Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20F2E7718B
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 17:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AE418021D;
	Thu, 19 Dec 2024 18:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kbRPww6w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 754A78021A; Thu, 19 Dec 2024 18:51:23 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 164D4802EF
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 18:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4679fc9b5f1so8186641cf.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 09:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734630680; x=1735235480; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JQK0JEWBAqWfm8fMvAbf8m5pyX/OV1aMO9Z3g+eFo9s=;
 b=kbRPww6wBqyJp0gEkxJy+RXqmsNg5iyeeG2eC1y01AWnplLe5XqxTFb0huo4jhdP41
 C4/qVLtieddp3Roov6z7qnk87iWRb4uAHO9heHgY9Je5mVXnE5bwTv9LVz6mWY5pV338
 Fgxv4CeX1IW6wvK30hOA3kbiRotlPgFclECKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734630680; x=1735235480;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQK0JEWBAqWfm8fMvAbf8m5pyX/OV1aMO9Z3g+eFo9s=;
 b=iQZGFgc6qZI+U+SxILT83BfvfGUYnPyehD65c/0B0dPZ3oeAamMAVZwCovi19rNSMR
 Cz5Q67NeGqPtB2WpSsAByByENgZr44KM/gGS4dJ0fEc7Nhr7vEAVe2VtGeFu4uoBs7zj
 Za+n152OFmBqr9fSEV0z//Hb356GC4HKUzZBhftqcdmthIhH1epAXgAy5XVVdwoJ2fO5
 Bf2Mkwz26QwVbyCihNb15HWtUPMLRqq2C/bIaMUew7pRCh4VcgJWEtpEfj8x1bUyA78l
 3zVWXaJ3NGPjmsSHq8xIebAQYtt9kwoX/Po1GGLdBANM53uAq4DYZSCjQE7jrLd/Lytf
 R5Gg==
X-Gm-Message-State: AOJu0YzykEps1FqsnXEh4fTVnlOkcyj0mqC3ioZFGtocp/s9755eNgLn
 iA+l1PI6qrb5N4csSUvpeh73xDAkIxjx+y8c61O6ndZEsXX1d5au8MnzeVpOAfA=
X-Gm-Gg: ASbGncvPg3P4ucg1gJoWO60+SHZ0Gkh3ZSVQIo275/48NM81Halb3PAW3yWSYNkyS8n
 h9CDuCCU3LUHaFjHOywLURUfiyUusJoLOns78fzYMZv03gYvuLP67kjUwe11VYjZHbc1cGDaKFf
 umBfh2vBFBHngjlAE8+H4MLdav3PLC4418Pm5NP9xFmDVLziUKDeDbFO/dwD9OlMrx8AOsBorVk
 wMP1WzNByrM0SiS/I6PS0HC2SgDN1+pXtasgqIhcCVC1Cvm5IQiB6eP
X-Google-Smtp-Source: AGHT+IHPpa+Po+lvPAwhbxsrZSfz6ppICactoNGUSwNd7B6nDspN1RE90FSS8grnxsP+VKrNg8Hw9w==
X-Received: by 2002:a05:622a:30d:b0:467:5da6:8096 with SMTP id
 d75a77b69052e-46908e6f856mr125292781cf.44.1734630679910; 
 Thu, 19 Dec 2024 09:51:19 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e64cf0fsm8313221cf.18.2024.12.19.09.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 09:51:18 -0800 (PST)
Date: Thu, 19 Dec 2024 11:51:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Nicolas Belin <nbelin@baylibre.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20241219
Message-ID: <20241219175116.GY1505244@bill-the-cat>
References: <87ldwc3pv3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rXqjSYu968YYUO6V"
Content-Disposition: inline
In-Reply-To: <87ldwc3pv3.fsf@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


--rXqjSYu968YYUO6V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 11:54:08AM +0100, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Please find some fixes for master:
>=20
> Android:
> - Fix kcmdline_extra support when parsing boot image
> - Fix memory leak when after bootargs concatenation
> - Fix length calculation when merging bootargs, cmdline and kcmdline
>=20
> CI Job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23951
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit 25fb58e88aba0c4af0af554d7b141be3f2e5e0=
b5:
>=20
>   ARM: stm32mp: Fix dram_bank_mmu_setup() for LMB located above ram_top (=
2024-12-17 09:14:01 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20241219
>=20
> for you to fetch changes up to 9e5fad0f792539ae4258bc116bf408bb6faf7e82:
>=20
>   boot: android: rework bootargs concatenation (2024-12-18 14:04:23 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--rXqjSYu968YYUO6V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdkXQwACgkQFHw5/5Y0
tyylDgv/W+ZYs2VcfPS99apZBJattuBsV4oAD8Z/VWXQrJpGKgP2Bkm1clh9v/7L
Y6pSBFIzydczuznTmSSGYyZamcp2tHbNqbj0HZJN0QOC1Og0OjOOM5BHKDYvljwq
x0+OGwKmBUi0TtQ2Y+5BwX9zuM1sy1+VP6vUcCzabxNfEPvyopVvz5uogQH2r0kU
OuQN6IgYMk7X9dSVY94qETHDfy29Hw5Pty++7HXoEWih4UItmIZxUIKGg+6DsGMG
oF0mDPYlpy8mE42LcFaqJvbAaEFkpnFKz7RC1I7aOUsjrezcLehJSFrsP27XzBE+
LQLNDnFARihnMt06SrZfEUO4t7oeJ3jo5+6BL//LsNtiYa+TeSwj//7c5g+lnJby
f1Z+hJlF747haQIPN32qaKkC8t4Gnlhsflj0GuyxWIMkWMt5ZwPU0Ebln4AyqjjV
N0MF55nCJUmYVTOdbrRaNu1fdntlgcIP4T97flIAI5eO/ooUeqm9xdDWurd+pvyD
VWgP86Ek
=Oe/Y
-----END PGP SIGNATURE-----

--rXqjSYu968YYUO6V--
