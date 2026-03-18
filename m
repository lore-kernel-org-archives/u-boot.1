Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205ADFEDA09
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 01:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0874841CD;
	Wed, 18 Mar 2026 02:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dLQB3ZeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E7308421D; Wed, 18 Mar 2026 02:28:21 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1F1A840A2
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 02:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d73ccee442so6636466a34.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 18:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773797297; x=1774402097; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cr9H7Nbu9GfWyVguPU/mjH+U6mWUyZlXUbncqjT8Zvc=;
 b=dLQB3ZeEW21BxPsVzpQ1sQUYjhXfOdx7/yENLE6Ze1gX6HgmRskr//ocMEtakFl9KB
 x0A6Lbd1AguMSdMPwvrpKMJua6WvyQAeAvNd8dwoLOoOVEd2A5lHU1KvyrE//3JzjWJv
 haQpf6io+xZUqf0Hab4TZHKmXMMGGwgHs0F1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773797297; x=1774402097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cr9H7Nbu9GfWyVguPU/mjH+U6mWUyZlXUbncqjT8Zvc=;
 b=lZtpp8hHicpDajsoTX2kdVqmgndPv5uGwoVWueTXkEuB9qx0D4k7NsRAy8RXhcKOGo
 KiIEqf5AtiljrCiM061RdGjJsXBLsAJk0e4PORlNdlihMR8wBaRhId0PduhUDQOUQAGt
 8ObKVLUNn71Qev135TAXF9y2SitAhHG2KjR3dBtczeezSahIO32lcOdvxgSUTqrlOD9T
 dXMiETNdVEj8FTTStpxf3tJTk+aTtnmIzOFvoVz/jCS6XWw9ckI7ZSNvDZhb69K1id40
 AGhABHtj7jHrdwpAUg5P28arOU0diBBxXoWGgowzW2cSt/lZLIGTqIwAzJYuxK6BGDj0
 mSbg==
X-Gm-Message-State: AOJu0YxjqbYKpt7ZVYK3Mt4h4tM08rVVvzJOKzOW2LuaLudk2jxhF2sD
 PuhPmZIEZ9ixdNt/kebnc+EeT//+gVVkTc7S1D1HnOBFxxoEcLsCUXHDp5rlN0L9rdwfMo2Ibz3
 qbSulMa4=
X-Gm-Gg: ATEYQzwB21zKlkECvT+d+1fP3rKCsGdXNUSlChj5w1Nb9MuO1kSWpHq7A8NeKc2GLsT
 15+FDmKwrHovK+GHar1X86wXY0eocOwBEfexSmL2l7RpI12nnnmQzsxS+1jWdmg2zUScTEr2CuI
 RTOw878EOMr5S4F6OvbdHLYJp/U10LdZ4dBa0Xy2c8oAbYritEWL3ff73P2S0zc9vMr91IrjrFv
 JbGNr5jP/qwsLJnmjoUnKMP4TQhh5TKPYqpZUCfIlIKhDxWtjLYhByEv1QnkVQOIYhGGQauEJNG
 MelMaNkaDey6xBecJcZsuOmeFtSAwDFKLYlAXphX/VtgOjim5wC417VVx6lEatFow5vlULx9enb
 eXznRYVkMCaWBgFof0RlrT41kt63egzgG8IKjfIgRZcB/+jANeGuLICgQzDEjijlCkDnwWb2DQh
 w9Wd50EvxkW5Nm2gn7wBK0ORTDFNM9jmNu0HOzF4lqF+cxZbPXa4Iwge2vnZztU8pDcSNUDOWRs
 zDowcK61/bvqIWCF4B/qKP+/KRzUx6QQTUDMwQc83AVrv4Z
X-Received: by 2002:a05:6830:6f83:b0:7d7:b7dc:d9cb with SMTP id
 46e09a7af769-7d7ca72102fmr1245100a34.17.1773797297549; 
 Tue, 17 Mar 2026 18:28:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c9950b2dsm1055012a34.5.2026.03.17.18.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 18:28:17 -0700 (PDT)
Date: Tue, 17 Mar 2026 19:28:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull dm
Message-ID: <20260318012815.GH502704@bill-the-cat>
References: <CAFLszTji9OgwrDfXOif9rExEKM=Op66qQ0MYjcRPnY_V_XsVNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EAolG0IqBBvRvbFF"
Content-Disposition: inline
In-Reply-To: <CAFLszTji9OgwrDfXOif9rExEKM=Op66qQ0MYjcRPnY_V_XsVNw@mail.gmail.com>
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


--EAolG0IqBBvRvbFF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 06:11:28PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/29554
>=20
>=20
> The following changes since commit eefb822fb574e28d49fc9f358328854e17fc84=
06:
>=20
>   Merge tag 'rpi-2026.04-rc4' of
> https://source.denx.de/u-boot/custodians/u-boot-raspberrypi
> (2026-03-12 16:10:46 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-17mar26
>=20
> for you to fetch changes up to fb275d2abf38736626c6c5d8e46e6273f73f59f3:
>=20
>   test: binman: Add test for pkcs11 signed capsule (2026-03-17 07:41:52 -=
0600)
>=20
> ----------------------------------------------------------------
> Binman test-file reorganisation
> Binman EFI-capsule PKCS11 support

Please rebase on next so I don't have to, thanks.

--=20
Tom

--EAolG0IqBBvRvbFF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabn/rgAKCRAr4qD1Cr/k
CtUHAP0Xi8SJ608caA/AQurzJeITcwEGHB/Qgm1978O+3X+HsAD/eQrhzceu9tjl
NDcRYfo5RZvAvF22H1+7fAXTdUgeRwc=
=kgOb
-----END PGP SIGNATURE-----

--EAolG0IqBBvRvbFF--
