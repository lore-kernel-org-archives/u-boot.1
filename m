Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E89DD6D232
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 15:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB56883DEE;
	Thu, 18 Dec 2025 16:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uihyavFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EC1583E0E; Thu, 18 Dec 2025 16:51:23 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2BC383DE4
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 16:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c765f41346so363714a34.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 07:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766073079; x=1766677879; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dnZ4cSgkkSmaEBqVOwygz5NAtfYza80dHdI0y73tgyI=;
 b=uihyavFU82jNSTDOUg2aYDdghYFhWUoyCsUJ6l011TEtROi3MVoaNkr4luJvGHM7ae
 r76USb90h4/T8Kt1MsSQ+J63isZk6jdXIpaPSzX5PfNOVyB85jy5jdci95H0SZOZf6Hh
 KGHbri2+OcCLoo7h965V/JL7EqTx7sLVyT9Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766073079; x=1766677879;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnZ4cSgkkSmaEBqVOwygz5NAtfYza80dHdI0y73tgyI=;
 b=I0/Wzeelv7YjZMZkg00EMeYpwY5e6KqLtwmA2hf1VYdH6W3SLplKkP6Tv2Yf2FQwlB
 PQa9Q5tax+/G7ICI6m8WZnYYU9ycbKX73ultg5V578GiZlvW+DXDI0+JESyb7et0Cwmu
 2qMeBGwXi3H5My+5XZIYhFr0N8N3zC59P2vYLM6ykoHSpiBsS74W+gMIiORwBWShOu1R
 aKtHXpa+KJ70hE0w2ie7c8BnX0RRVExUNQTBtPoRiW8365hxCt9NXQJtYbmu53xonUa1
 Q1oBxH9wPqEAUlhZxCiesTIPcpYPvZ5ife1+YQJDt3g/YVYv/fI5AAgk5FktG8U21g6M
 LkOA==
X-Gm-Message-State: AOJu0Yw0mzdzhs6xP1AX/u5tPJtJ1bEQeENr5eQvk4GNv5GmhT4/UMVR
 LRwm3QLlJr5rVO8/pGQ46BGayX9Z/3yKyrq5MEeKDwkfdqX2xEeEMujZGd9PW1SsFTklcaEK9XI
 YN09oCXY=
X-Gm-Gg: AY/fxX5A5bXi+yeJMLgsHQvH+8Jb8bE47r3zDtWiRP4G22o5FqQl+ze52hqFxDiLqUb
 qXcrg0l56KD/GkjzAx1ROMKA9RJY6mVsJLM6LJ1AbTPlQeNxLBybU2vOJH2f9f9e/avBX6vcA6X
 Q1mu8AXBUD9EZB8DYdES3T0P2GUviDAJoiouLydtqYtoBAkDPuGTlTYNDROR8yc45vcmbK2kqeL
 4cz58Q/2z15gHTAOjAerKvmPcSAJo8KQ99cqXWT4N1fVLuURaTawLh/3kRjjR82TAykBb3r7gdd
 hzUhjFTBQSmPAWTYiXoCdAyAogigKA3HBaxAVOwY0HlEqDZC/4+IiX9gJAKno0vTVg6y9w5sSht
 aX20MxTDbtVG0vYy4uZORDW7DtZmDNQme5KZ1uzcWUa6l5M5SsSac30lG0DdZbuDiVp0Q2M0UFK
 TUn7ccxSNBKLHYcxfZVQ4jZ43yh0d6ZxPFMwFCyzWtDo7h+0e5K/ekz/hH06Ex
X-Google-Smtp-Source: AGHT+IFNbbtPqFL2um1Fht3S2aX35r0fPngq/6J3JxY72NdWLxUZ4lpGeUxWt889aARH47cKwofeVQ==
X-Received: by 2002:a05:6808:15a9:b0:455:bf27:e960 with SMTP id
 5614622812f47-457b1ee2ba9mr29754b6e.24.1766073079322; 
 Thu, 18 Dec 2025 07:51:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457a42f816csm1428476b6e.2.2025.12.18.07.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 07:51:18 -0800 (PST)
Date: Thu, 18 Dec 2025 09:51:16 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: u-boot@lists.denx.de,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: Pull request: SoCFPGA changes for u-boot-socfpga-next-20251217
Message-ID: <20251218155116.GK303283@bill-the-cat>
References: <08e65074-4fb9-4ba6-8cdf-5e51659f8ddf@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LzdR9le9dB+eJ2KM"
Content-Disposition: inline
In-Reply-To: <08e65074-4fb9-4ba6-8cdf-5e51659f8ddf@altera.com>
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


--LzdR9le9dB+eJ2KM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 10:05:31PM +0800, Chee, Tien Fong wrote:

> Dear Tom,
>=20
> SoCFPGA updates for next (2025-12-17)
> This pull request brings together a set of fixes and enhancements
> across the SoCFPGA platform family, with a focus on MMC/SPL robustness,
> EFI boot enablement, and Agilex5 SD/eMMC support.
> Highlights:
>=20
>  *
>    SPL / MMC:
>      o
>        Fix Kconfig handling for
>        SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
>      o
>        Correct raw sector calculations and respect explicit sector values
>        when loading U-Boot from MMC in SPL
>      o
>        Adjust raw MMC loading logic for SoCFPGA platforms
>  *
>    EFI boot:
>      o
>        Permit EFI booting on SoCFPGA platforms
>      o
>        Disable mkeficapsule tool build for Arria 10 where unsupported
>  *
>    Agilex5:
>      o
>        Upgrade SDHCI controller from SD4HC to SD6HC
>      o
>        Enable MMC and Cadence SDHCI support in defconfig
>      o
>        Add dedicated eMMC device tree and defconfig for Agilex5 SoCDK
>      o
>        Revert incorrect GPIO configuration for SDIO_SEL
>      o
>        Refine U-Boot DT handling for SD and eMMC boot variants
>  *
>    SPI:
>      o
>        Allow disabling the DesignWare SPI driver in SPL via Kconfig
>  *
>    Board / configuration fixes:
>      o
>        Enable random MAC address generation for Cyclone V
>      o
>        Fix DE0-Nano-SoC boot configuration
>      o
>        Remove obsolete or conflicting options from multiple legacy
>        SoCFPGA defconfigs
>=20
>=20
> Pipelines test passinghttps://source.denx.de/u-boot/custodians/u-boot-soc=
fpga/-/pipelines/28776
>=20
> Thanks.
>=20
> Best regards,
> Tien Fong
>=20
> The following changes since commit 47b50fb1125c539d80ed3e7f739c02c6486e1b=
52:
>=20
> cmd: part: Fix part argument description for `part number` (2025-12-16
> 11:14:53 -0600)
>=20
> are available in the Git repository at:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
> tags/u-boot-socfpga-next-20251217
>=20
> for you to fetch changes up to 6f419247baa45917fcdd67062e271b8884d8c7aa:
>=20
> configs: socfpga: Permit EFI booting (2025-12-17 18:50:33 +0800)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--LzdR9le9dB+eJ2KM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUQi8QAKCRAr4qD1Cr/k
CrBaAP9IY4xSl5ntplInUy1/snkAFbbArtCenFYSOE7Uy4pSpwEA8aIRR5mbNeI2
bX192BG7YhoGhFmg4MhRXk/DF26TVgE=
=ZAIr
-----END PGP SIGNATURE-----

--LzdR9le9dB+eJ2KM--
