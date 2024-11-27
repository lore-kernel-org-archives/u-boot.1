Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F83D66B9D
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 00:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 752E389CD1;
	Wed, 27 Nov 2024 01:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LFYLesQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FC2B89CC5; Wed, 27 Nov 2024 01:14:02 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00ACA895F0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 01:13:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5eede9695ffso3709588eaf.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732666438; x=1733271238; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6CHeD5BtfVv5DwobNjCmc8mPDhQ39a7luu75khcWCkA=;
 b=LFYLesQL+fDH73kLdB2VxsZBMfmw7b5PISHdrBJGIgk2Tr8RYQb5mF3W8n/PcpS/4W
 DzIgumkygipZcSTwq5GJUkUO0ssqHgbSH4p2WhBpvf7kXGYQYNcPBneKp48GuA+SQKc5
 1J9CkSNDXwqlNBoJnOCWoJKVYatJqLMRdk9Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732666438; x=1733271238;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6CHeD5BtfVv5DwobNjCmc8mPDhQ39a7luu75khcWCkA=;
 b=hKue4gyIeoQ/vsXYOuc+GemGY54cV3t6KkJzoPV+ki2t/ZzoKxxrfKkirRd/Z2mbLf
 7asMG2yJmyhIJFseqHJaCWAycFzqrX7GZUN1EIi7mfG73CMZAVYWzVeTqa4hd7hgLuxf
 9rbmVyRSyEEXUluWMwiMDNDKEO7JSGFOjtIPv0KiGiAA9wciY5e3TFlaz/svPGIOijeF
 Kb18J1NW94moXLzmP5Vq3VOpOeLkMaYkHTJwsoS0soKy1/vv8QxSCiMJ9pwhX6LSWjxD
 Vyc5FvG2jJYrWe/i3XP7y1V8w9h4Umm9EHOVgeZ243wdHRX5KOxruq+xD2zEywJX82fF
 ARfA==
X-Gm-Message-State: AOJu0YwJSZLghAg6rNQ8aKa94bjGPiytT3fki1ci0ga1YvEyZ4DvD1HU
 sPxs59X1jvulvmVlw0WeYJRcbEk4bxJUW7KqMh0run5cZv/w0h3jpsWGiKozTbI=
X-Gm-Gg: ASbGncsKPeIug/yUi8piHvsti2Zl6A8SPyzyAM0ZWG3SbUsWWYFK1h41Y3OBzOTGrpS
 Nzbrxt41pkFH9KQmo2BOvtGGbakNIfonq7xkS4Bckm8YXPDfG1MrTOa9YjOieZIcS4DNfVBkbbe
 guaQB8Jvh1gBpoR01u23FVk6XyRZtuWym8XqdN8zrCKITFFEw2E8U4dV+JJd55J72lV/ssyZj1D
 eYKiKc4/rOUdvzlfLgDa6awDXSN0vsKn8YgHccGmfXeqH3v6g==
X-Google-Smtp-Source: AGHT+IEyDYOEjjko/I/RHN/q+cIHgfqmi1kEbdc28bHSI1sYnOvP/rnu34PJn7A0MNLWVIloqIx7QQ==
X-Received: by 2002:a05:6358:678c:b0:1c3:813d:47c2 with SMTP id
 e5c5f4694b2df-1cab16941d2mr181570955d.20.1732666438567; 
 Tue, 26 Nov 2024 16:13:58 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466a63349cdsm14949811cf.5.2024.11.26.16.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 16:13:56 -0800 (PST)
Date: Tue, 26 Nov 2024 18:13:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20241126
Message-ID: <20241127001353.GX3600562@bill-the-cat>
References: <20241126115759.1117890-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wgZ6EHVTczzDYUfL"
Content-Disposition: inline
In-Reply-To: <20241126115759.1117890-1-festevam@gmail.com>
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


--wgZ6EHVTczzDYUfL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 08:57:59AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/next, thanks.
>=20
> The following changes since commit 48380f9b2a12e3fc6339d6af5a154bded769d9=
11:
>=20
>   Merge tag 'v2025.01-rc3' into next (2024-11-25 17:34:08 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20241126
>=20
> for you to fetch changes up to a488d9f26e37bcb5776bc8a2dadb708f1ac9cfdc:
>=20
>   board: phytec: phycore-imx8mm: Add EEPROM detection initialisation (202=
4-11-25 23:08:24 -0300)
>=20
> u-boot-imx-next-20241126

Applied to u-boot/next, thanks!

--=20
Tom

--wgZ6EHVTczzDYUfL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdGZD4ACgkQFHw5/5Y0
tyz2PQv/W/EDeOHhr76BZUJWtq/Gh7bRwe36V8kb5hega2ZzFJj8uuBckjVcj+BD
aQwXoDWSPVAKsMOzCpyX7NeEAtOzImSw/sicRstv8bRcLgCElXbjHcB/E5wRvaKc
bQMOTLcvX+FxLAerBLV76qK6TtS5kqWI05hdh2u+rEgFNwe9sjbOnzQGMMlTUWdv
RjgfvFiqPoEDqSOUQuCThK1nxdCKJbKb4Hp6WGcBFDeecT1n4HeAOFnPRqdaQFrT
vyBTqYlMHmoAi/o1pZouymipywXcPvhCLxnrO2qHBEGw43N1VAqFIg2XOeLQss8H
83LYIeAmZk47ngOqnezWURsbxGBjj/xzz8Nov8aumU18DhShai8FbYy089wT0saA
yavG+mzQk8EyWMPzMRVcoAYyRQb5O8he6KdiXC67JFeyijdSBzqtw3PkYDeCNqGu
5pseht+7ehgcm16VQvNZKXWExIV9Q4lakO1VhrsbDwbYAjaCVLOuBkUHW7sUgcKx
hOR0mbTk
=Q1HI
-----END PGP SIGNATURE-----

--wgZ6EHVTczzDYUfL--
