Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B0BC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 14:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47DC982BD7;
	Thu, 15 May 2025 16:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g+dQRJ5C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D590782BD9; Thu, 15 May 2025 16:30:55 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 456E982BC1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72a4793d4e2so788761a34.2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747319450; x=1747924250; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6FwGeMmufxL89wnFBX6JEdc/4NWN+KI4ZrzvKBpY9qU=;
 b=g+dQRJ5CplomE+WgmMqK0FoxbxlK3vinaTvM861JQkmN7xKPYlUom4mtuSqeaoq6BI
 LIG99Zjh8miH4i8W/oXgdcjrEeqZ1HkP9TIz7Bv+xybdH6K4Q/PEWJE4byhY1ZmR9T7k
 gg9GB5uQ3JKdbJFX2zJ6ynfjpFUBOvWAlcwDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747319450; x=1747924250;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6FwGeMmufxL89wnFBX6JEdc/4NWN+KI4ZrzvKBpY9qU=;
 b=vNqVlyM1Z7TSgVP0i8rJv2rdvRMDRC1qy72AiI1ueLEDhpkgLzJCabjOIV3tNXNs1Q
 0SGDNuG5WIUlMMrLHR88rQmoA5BUanuVWv7QDfQhOqdjSniUYhCXxzltdcFxy1yVG232
 EQWSrkHg3wd35ADH3uIeQ4RwRCAamt5GkcMSNjPn6pE3pza8g7SWYn3hYmACOwLN8qde
 SnfriznVvH7HJzupBcPK8GgAJlmer3JRZgHq2T3Rkp253MoDf4ZK9/vwTi6tfzDtAv+I
 mz5HM5Wq7gmU80bK5oGAJ5wPRl0yc66GFGieK0cJ7KSehv7e6csE0XC3mbLaGM5zeV9Y
 3ZoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm+1zRHVwBf+9gUPGrHDDBD86JuwYfIlYbPjUriGMWhM57XMk1GyQdh5o+UO14kqvg/JSgKhU=@lists.denx.de
X-Gm-Message-State: AOJu0YywI/ttJBMBOlUlYcMx0m8j9iIqDunCGtVtiEMJkX9khNjzoYec
 H3lvpPwPqLyk7WWHbMjeC4thQbIviaFqGDarGGgGhND2iEgk3n8WUt3N80GvEl/7B7hAdsn+hk+
 S9/U=
X-Gm-Gg: ASbGncuqJ6Iyow/xeHnQ6ojNhKoME1hsvaDiVP7JogbvruFccT6mCWfukk4SNz1G7vG
 uWLZPKrGOp82r1nzCDpD0IskVgXcE5zCk78SXH8BUlPFxxITYqdRYur3v6KUcAwfQTvy6JkG5C8
 LFCdl6FphWzfZQErWaYTlrTWOyL2P+z56HG78a7FvflwDdNAUN6hrWrmFy4btw8RpOaT5x6KSk7
 7LE1Oe/xbJ7NLMmtzBgaN/NkjiyZny2xPmtFxiAlkHqpIKFsNVZFJGyDHSgsEJ5BGpvRk9Q41O2
 h4xOWwh5KB9EmRdEr2NOLahQ+B4WTIWlqMLLGLZL/rZX8FaMkLVgqYc5DycBv4a/AVkSgGPOLTO
 8sYYo9lVLofDE
X-Google-Smtp-Source: AGHT+IGAWs6BWUolWz2IOT+pYHqyYXUiNxxhxtUOdHG1aQG5iD6XG9jiOVPlnycdBdiw3bae45BEBA==
X-Received: by 2002:a05:6870:47a8:b0:2d4:d07c:7cb6 with SMTP id
 586e51a60fabf-2e32b057131mr4326759fac.1.1747319439363; 
 Thu, 15 May 2025 07:30:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba06dded9sm3147185fac.14.2025.05.15.07.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 07:30:38 -0700 (PDT)
Date: Thu, 15 May 2025 08:30:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, michael@amarulasolutions.com,
 linux-amarula@amarulasolutions.com, Anshul Dalal <anshuld@ti.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Trevor Woerner <twoerner@gmail.com>
Subject: Re: [RFC PATCH 1/3] spl: Kconfig: allow to enable
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR for i.MX8M
Message-ID: <20250515143035.GH603748@bill-the-cat>
References: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
 <20250515131246.784206-2-dario.binacchi@amarulasolutions.com>
 <257158ee-7496-4da2-84c1-6bc74965cde0@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8hH4k1yXtN0RRKt+"
Content-Disposition: inline
In-Reply-To: <257158ee-7496-4da2-84c1-6bc74965cde0@cherry.de>
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


--8hH4k1yXtN0RRKt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 03:26:18PM +0200, Quentin Schulz wrote:
> Hi Dario,
>=20
> On 5/15/25 3:12 PM, Dario Binacchi wrote:
> > Commit 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options") brea=
ks
> > the boot of the BSH SMM S2 board. As stated in the commit itself, "Some
> > boards use this value even though MMC is not enabled in SPL, for example
> > imx8mn_bsh_smm_s2". The same commit makes SPL_SYS_MMCSD_RAW_MODE depend
> > on SPL_DM_MMC || SPL_MMC. With SPL_SYS_MMCSD_RAW_MODE unset, it is not
> > possible to enable SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR, thus breaking
> > the board's boot process.
> >=20
> > The patch once again allows SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR to be
> > selected also for boards that do not use MMC, in this case on the i.MX8M
> > platform.
> >=20
>=20
> Why would you use SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR if you don't have =
any
> MMC? Shouldn't we rather fix the incorrect usage of this variable to be
> something else (or better guarded?).

It appears that arch/arm/mach-imx/spl_imx_romapi.c::spl_romapi_get_uboot_ba=
se()
will use the value so that we (apparently) go ROM->U-Boot, or at least
ROM->some series of prior stage loaders->ROM->U-Boot. I'm not sure I
love overloading the value like this, but I can't say it's wrong.
Perhaps the help needs to be updated too?

--=20
Tom

--8hH4k1yXtN0RRKt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgl+oQACgkQFHw5/5Y0
tywIQwv/Y6KalpAI1tbjURx1Sc16G0MH6A/WzUeLXlsOxtrC97Xk9cgZ0wHzBqtx
80mR3zeW/nwHac3AUeuxfLyuU9qKy8/pTSTu9QX2SI/deqh8Gi777w9pkX18BWyl
J3tWYZrJt/Lv88vAcBisIsZmAPfPsQorx14FX85PtblJjlx9TafLt4+dB8+Q6toZ
4KwUPcmA4jREnG+cgevMsHkBqbpLrI0SvBkpS57cyqe9wmc1yTU3xMpJC9EdhNC7
Y2jsagoP1/pZwI9pOwfgicV/MTvWM0mRmAFryTKyl1pcCfbm6me44ee/i8Jf5yJq
2IdLtbXdcVcfWz0Rmx8aoqy/x1r+fWdsv1kQ3UFju8GiFDIlCV5X+M+A1HkHF/Jx
Kb9B7W/C+e0g1d3zAQqJAsZhON1Z6ZqwV+QkMaQGOdKWODc/TEjJedEvb88T4KJP
ij6T9uICvVF2oqBz93CrwEIbWcWHKZLaZkP8NpVyNtKRN9ul36x3DbO029QQKNiS
3YaD6UTR
=csZV
-----END PGP SIGNATURE-----

--8hH4k1yXtN0RRKt+--
