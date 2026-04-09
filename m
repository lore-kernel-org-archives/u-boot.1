Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC36F364AB
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 18:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5F55841DF;
	Thu,  9 Apr 2026 20:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZW8xMVDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D667F84099; Thu,  9 Apr 2026 18:33:29 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD2C983CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 18:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-42321c8b8f5so945852fac.1
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775752406; x=1776357206; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i+CBakdrEwu/cYOohDO4esz1hhSw1R39593GJtVydxM=;
 b=ZW8xMVDX/wKL5c0sq2EBslVyB1paw0YjU9uYMZUbcBYWGUqfoMQIPziGEyQTiJSb6C
 1nTzd7hNlknjckRpOg6Kno/Qll187ykOTUngW72SJVNA2q6Wivak+w9T0H/XB2O86QV+
 R82PkKotNyf/ZuB9pdWNlpYCulFEj6T5DG9Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775752406; x=1776357206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+CBakdrEwu/cYOohDO4esz1hhSw1R39593GJtVydxM=;
 b=K8JCwOeI/CtK7/aYRh/zajOdncdgeuHQ6xyys2jTGq0mHAZKSmWF3PDu4i15BLRahY
 C5AxwtWSwZ16hqr3YMF8wLZVNcHcAZ3X8/VAeFZNIgR/3cjVBuzYn0SQ9wq9IT0fhPLQ
 FiPsJsXmn5tgDpcezrnBiUh7wUw3TIKl5K6nspCOVi2lpJFPhp4aVV7ROGoevqeV0HYm
 +JU4Q6xgo8GKgudmYIpifjkA+k8qwSPHG3odkOkKKD6tlm8wAGT6jJOZpTN18Da6kXvC
 VOROZ/Hhn2MKXYXHUExIyoqsoo1mqdzmF1RG72r7YuO94Ckxz06yAw7bNjcwsQdelsIb
 JDqg==
X-Gm-Message-State: AOJu0YzXX/hFura81nxg5IMbERE0dtYg9NKF762RYrgHlPlunIDCUGFT
 3UnpxmBVsy/Ar1BmWtLMYaGgEHRZKFAi3tyrGK8BQjqysPwGo44Ir+/Jk9PFsvmcIxXHzyw7cMa
 ysBC++BU=
X-Gm-Gg: AeBDies1ISv8Ix+D7yEbrY8V0FJJKzGBwL8q/Rlu0J15xNJiN9XYPbOm9rLt9ctDfew
 2Bthu8B50DoEAyy6x2HrIw1DIf1JYXiYoO5lopCxhDaTyosVafSExeQg714Lggy73fk0caNbJdb
 ZEVbiqQ7RcSr1chSrmiT1x6He+b0JvNHyzunmofmanSBkXi/HVvUvOMNQB0GbsUjNGjucxW3/GJ
 k5fQv2NKdTHptzujOfIkV6hHEv+ACKW5xHmT4Sw1IxQa7uvdAKhn9JrAXf52K19YaHSlBUriY03
 64693HzoPuNn6EDT6JwbdX/sqn+HgBtmG3GUTb5bdJfCH6umndQZMK23RmskR117v/z4NzJJa7k
 NyWcjq1CtwBtql0uVNpQXgRTEIc2XDWQwNrARSB+AKJzy9kfAw6JPyqye+hTYn3tniyKJV7jyAe
 DNlVly3fpNumq68E+CTF+iNontoU8SwTRBTUJLlIf0efNH8tsROyWDwWvvQaXHeLB6kspjrJacW
 Jek+7CduOvC/aq9RMSL3qyKzjoAFOgrm9LGxVUksyfIdpmfuFY=
X-Received: by 2002:a05:6871:eb06:b0:3e8:8dcb:cdc7 with SMTP id
 586e51a60fabf-423bd02b9dfmr2110896fac.20.1775752406067; 
 Thu, 09 Apr 2026 09:33:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm65760fac.17.2026.04.09.09.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 09:33:25 -0700 (PDT)
Date: Thu, 9 Apr 2026 10:33:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Jorge Cisneros <jorge.cisneros@hpe.com>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Jean-Marie Verdun <verdun@hpe.com>, Nick Hawkins <nick.hawkins@hpe.com>,
 Casey Connolly <casey.connolly@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tony Dinh <mibodhi@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Shmuel Leib Melamud <smelamud@redhat.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Chen-Yu Tsai <wens@kernel.org>,
 Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Philip Molloy <philip.molloy@analog.com>
Subject: Re: [PATCH 0/9] arm: hpe: Add HPE GSC (Gen12) BMC SoC support
Message-ID: <20260409163321.GN41863@bill-the-cat>
References: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nbyU/ED8A3Db9i+N"
Content-Disposition: inline
In-Reply-To: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 09 Apr 2026 20:12:34 +0200
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


--nbyU/ED8A3Db9i+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 07:24:12PM +0000, Jorge Cisneros wrote:

> This series adds support for the HPE GSC (Gen Server Controller), an
> ARM64-based BMC SoC used in HPE ProLiant and Synergy Gen12 servers.
>=20
> The GSC is the successor to the GXP SoC (already upstream) used in
> Gen11 servers. It features dual Cortex-A35 cores with GICv3, a Denali
> DDR memory controller, Cadence GEM Ethernet (SGMII), and reuses several
> GXP IP blocks (timer, SPI, I2C).
>=20
> The existing ARCH_GXP Kconfig symbol is renamed to ARCH_HPE to serve as
> an umbrella for both the GXP (ARMv7) and GSC (ARMv8) SoC variants,
> selected via a choice menu under mach-hpe.
>=20
> New drivers:
> - Watchdog (drivers/watchdog/gsc_wdt.c)
> - Memory-mapped virtual EEPROM for VPD (drivers/misc/gsc_mem_eeprom.c)
> - Cadence GEM support added to the existing MACB driver
>=20
> Board support includes DRAM sizing from the Denali memory controller,
> MAC address provisioning from VPD EEPROM, FDT fixups for network
> configuration, shared Ethernet/DisplayPort PHY initialization, and a
> server_id command for reading server identification from the CPLD.
>=20
> Notes:
> - The server_id command (patch 7) is hardware-specific and reads from
>   GSC CPLD registers, so no sandbox test is included.
> - MAINTAINERS warnings in patches 1-8 are resolved by patch 9.
>=20
> Based on v2026.04-rc4 (ba7bf918dafcd093ad733b07ba490baeb20cf5da).
> Tested: both gxp_defconfig and gsc_defconfig build cleanly.

Thanks for posting this. I have just a few comments to follow.

--=20
Tom

--nbyU/ED8A3Db9i+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadfUzgAKCRAr4qD1Cr/k
CkaLAQDepYRlg3BBjfBgTpbdPyMnCnlCF3qioxcMjOuckHfqXQEAg1TzLTZfJtG1
7/Zsk+Ngggt3PFoojlFWJwValc+8eAg=
=HoCp
-----END PGP SIGNATURE-----

--nbyU/ED8A3Db9i+N--
