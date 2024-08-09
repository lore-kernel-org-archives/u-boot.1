Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8F6C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 18:56:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F826884A9;
	Fri,  9 Aug 2024 20:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GaXZiyUz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8006F88B07; Fri,  9 Aug 2024 20:56:48 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D8EB884A9
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 20:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3db157d3bb9so1612100b6e.2
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 11:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723229805; x=1723834605; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RIMJI1S7qR9479PsTtyPDGeXqRrufQXIh9mAR+dQBRk=;
 b=GaXZiyUzBG3cBMUavVS/O6yyR253VTA2HUP0pIAaRTQKBfLtTlw/kbzrl0PczH63+T
 gP4egyjTMGLgKO6NpiHjjOR5RYpmGuyjg6uFnNH+NGrgPJwzbPf2PHR7n1NwjQlPfvSM
 6ZWeMviUr/p3L6tS7LNMsEjKn8Eg8qb3MIjGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723229805; x=1723834605;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIMJI1S7qR9479PsTtyPDGeXqRrufQXIh9mAR+dQBRk=;
 b=AgDy4jrMPEjC/4PW41EVZodjJAuNY4jpqwUnzjI8LBscHhoPt7SC9AenFWVYdDsK0J
 FDwSrNFv3iBcWN0tujCy/TLgCF06if9NKxs430GMbqKd/WzPuRCZ8GInu9Q2Fv5yX0Iv
 ZWM1fIRgnKBu8ZVYiiCJLqvcli4ciDRWBbaylLIPZmmLT+BpbDJsrdigVJLcs5vKCABK
 O6vF8UeAxQdFABGSEcfHcqqCaVK0QLLYkvUB9Tjcjx8NpxwN8G1vtt6pjWUyU7/JyCX8
 CmizPju45cHWONoAqtaSRoKsK5KA1IaxzuS/mA6tt4C/wdUDd6HSKxOkXhjsrSTrSVCM
 nu+w==
X-Gm-Message-State: AOJu0YzqRTXEf2ea7LPxoN8nwQ/8I0Byn8HUJpK/9YUSYHGp2Wn8YoS1
 i0oSfxogWDB/RHRUOQ1RgR4n/CRM0cY1avY6tng4uMnz980SmVUicoyD6L2TY9o=
X-Google-Smtp-Source: AGHT+IEM43GrLokOt/UFaIaiYaHtRXOC51eJxViXbhNgviUoSAzMsmyvjfft4r1kp9C5/EONL5dqtg==
X-Received: by 2002:a05:6871:520d:b0:25d:ff1b:3793 with SMTP id
 586e51a60fabf-26c62f16f25mr3136453fac.35.1723229804853; 
 Fri, 09 Aug 2024 11:56:44 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70c7b81daedsm83058a34.18.2024.08.09.11.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 11:56:44 -0700 (PDT)
Date: Fri, 9 Aug 2024 12:56:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 00/20] i2c: Chip away at some old code
Message-ID: <20240809185641.GU1626301@bill-the-cat>
References: <20240718173611.4014274-1-sjg@chromium.org>
 <CAFLszTj3JsUHFvWUmP07mGwK315qO=Bt0uQ=JGeKrLgBOQxoJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Iffoq89iKcoLON4X"
Content-Disposition: inline
In-Reply-To: <CAFLszTj3JsUHFvWUmP07mGwK315qO=Bt0uQ=JGeKrLgBOQxoJA@mail.gmail.com>
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


--Iffoq89iKcoLON4X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 12:37:52PM -0600, Simon Glass wrote:
> -cc most
>=20
> Hi,
>=20
> On Thu, 18 Jul 2024 at 11:36, Simon Glass <sjg@chromium.org> wrote:
> >
> > This series aims to remove some of the older contents of i2c.h so that
> > we can move towards having just the dm API.
> >
> > It removes four boards which are getting in the way.
> >
> >
> > Simon Glass (20):
> >   arm: Remove pg_wcom boards
> >   i2c: Remove board_i2c_init()
> >   i2c: Remove IC2_xxx enum
> >   i2c: Remove CFG_I2C_MULTI_BUS
> >   mips: malta: Drop CMD_DATE
> >   armv8: ls2085a: Drop CMD_DATE
> >   mx28 / mx51: Drop CMD_DATE
> >   MPC837XERDB: ethernut5: work_92105: Drop CMD_DATE
> >   rtc: Drop CFG_SYS_RTC_BUS_NUM
> >   date: Drop the legacy I2C code
> >   keymile: Remove use of legacy I2C
> >   i2c: mxc: pg_wcom: Drop legacy I2c
> >   i2c: Drop reference to SYS_I2C_INIT_BOARD
> >   octeon: Drop OCTEON_I2C_FDT dead code
> >   i2c: Remove I2C_SET_BUS()
> >   i2c: Remove I2C_GET_BUS()
> >   i2c: Drop CFG_SYS_MAX_I2C_BUS
> >   i2c: Drop i2c_get_bus_num_fdt() and i2c_reset_port_fdt()
> >   i2c: Remove CFG_SYS_I2C_MAX_HOPS
> >   i2c: Remove CFG_SYS_I2C_DIRECT_BUS
> >
> >  README                                        |  27 +--
> >  arch/arm/dts/ls1021a-pg-wcom-expu1.dts        | 141 -----------
> >  arch/arm/dts/ls1021a-pg-wcom-seli8.dts        | 124 ----------
> >  arch/mips/mach-octeon/octeon_fdt.c            |  22 --
> >  board/keymile/Kconfig                         |   4 -
> >  board/keymile/common/common.c                 |  69 ------
> >  board/keymile/pg-wcom-ls102xa/Kconfig         |  39 ----
> >  board/keymile/pg-wcom-ls102xa/MAINTAINERS     |  16 --
> >  board/keymile/pg-wcom-ls102xa/Makefile        |  11 -
> >  board/keymile/pg-wcom-ls102xa/ddr.c           |  91 --------
> >  .../keymile/pg-wcom-ls102xa/pg-wcom-expu1.env |   3 -
> >  .../keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c | 218 ------------------
> >  .../keymile/pg-wcom-ls102xa/pg-wcom-seli8.env |   3 -
> >  cmd/date.c                                    |  32 ---
> >  cmd/i2c.c                                     |  23 --
> >  configs/MPC837XERDB_defconfig                 |   1 -
> >  configs/ethernut5_defconfig                   |   1 -
> >  configs/ls2080aqds_nand_defconfig             |   1 -
> >  configs/ls2080aqds_qspi_defconfig             |   1 -
> >  configs/ls2080ardb_nand_defconfig             |   1 -
> >  configs/malta64_defconfig                     |   1 -
> >  configs/malta64el_defconfig                   |   1 -
> >  configs/malta_defconfig                       |   1 -
> >  configs/maltael_defconfig                     |   1 -
> >  configs/mx28evk_defconfig                     |   1 -
> >  configs/mx51evk_defconfig                     |   1 -
> >  configs/pg_wcom_expu1_defconfig               | 109 ---------
> >  configs/pg_wcom_expu1_update_defconfig        | 107 ---------
> >  configs/pg_wcom_seli8_defconfig               | 109 ---------
> >  configs/pg_wcom_seli8_update_defconfig        | 107 ---------
> >  configs/work_92105_defconfig                  |   1 -
> >  doc/I2C_Edge_Conditions                       |  10 +-
> >  drivers/ddr/fsl/main.c                        |   3 +-
> >  drivers/i2c/i2c_core.c                        | 141 -----------
> >  drivers/i2c/soft_i2c.c                        |  11 -
> >  drivers/power/power_i2c.c                     |   5 -
> >  drivers/usb/host/ohci-lpc32xx.c               |   4 -
> >  include/configs/ethernut5.h                   |   3 -
> >  include/configs/km/pg-wcom-ls102xa.h          | 167 --------------
> >  include/configs/ls1028aqds.h                  |   1 -
> >  include/configs/ls1028ardb.h                  |   2 -
> >  include/configs/ls1046afrwy.h                 |   1 -
> >  include/configs/lx2160aqds.h                  |   3 -
> >  include/configs/lx2160ardb.h                  |   3 -
> >  include/configs/lx2162aqds.h                  |   3 -
> >  include/configs/m53menlo.h                    |   2 -
> >  include/configs/omap3_beagle.h                |   3 -
> >  include/configs/pg-wcom-expu1.h               |  49 ----
> >  include/configs/pg-wcom-seli8.h               |  40 ----
> >  include/configs/sniper.h                      |  14 --
> >  include/configs/tqma6.h                       |   3 -
> >  include/configs/tqma6_wru4.h                  |   1 -
> >  include/i2c.h                                 | 107 ---------
> >  53 files changed, 6 insertions(+), 1837 deletions(-)
> >  delete mode 100644 arch/arm/dts/ls1021a-pg-wcom-expu1.dts
> >  delete mode 100644 arch/arm/dts/ls1021a-pg-wcom-seli8.dts
> >  delete mode 100644 board/keymile/pg-wcom-ls102xa/Kconfig
> >  delete mode 100644 board/keymile/pg-wcom-ls102xa/MAINTAINERS
> >  delete mode 100644 board/keymile/pg-wcom-ls102xa/Makefile
> >  delete mode 100644 board/keymile/pg-wcom-ls102xa/ddr.c
> >  delete mode 100644 board/keymile/pg-wcom-ls102xa/pg-wcom-expu1.env
> >  delete mode 100644 board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
> >  delete mode 100644 board/keymile/pg-wcom-ls102xa/pg-wcom-seli8.env
> >  delete mode 100644 configs/pg_wcom_expu1_defconfig
> >  delete mode 100644 configs/pg_wcom_expu1_update_defconfig
> >  delete mode 100644 configs/pg_wcom_seli8_defconfig
> >  delete mode 100644 configs/pg_wcom_seli8_update_defconfig
> >  delete mode 100644 include/configs/km/pg-wcom-ls102xa.h
> >  delete mode 100644 include/configs/pg-wcom-expu1.h
> >  delete mode 100644 include/configs/pg-wcom-seli8.h
>=20
> What shall we do with this series?

Later today once I merge Heiko's PR for -next to -next, rebase on top
there please, I believe all of the platforms have been converted now.
Thanks.

--=20
Tom

--Iffoq89iKcoLON4X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma2ZmYACgkQFHw5/5Y0
tyxK5Qv9EWQUisJIOXmLnfmZDOKoCKyaBxHkTl0o+hH6kDpIvDqnEnAN+osYrnyZ
n/BgqLst+J7BlBAUBQVwHPr6Jy2N7vTdKAhU2A7uCdzfa+0RUV3Yk51qdLfv5+4w
DWOpnv2mQ/qZy+QfxKI2hPwL6rQPVooGu6VByiTcrnArkfzaqt1Na5L0o4pwPFXp
5Bs1+2qoJRdOZ1JUq9QholGuscS2gt4848Ui93au7VRP1bAsa9GPnoopCvSog2Ay
N5qlzp8Bpc7h/LvdV+FhsaQSKr+DSMMstbnsdLvcxrZGo6odZjYx2qge9HbkON1A
1GV96fkl4Oz+bg9JTnJw9hcHAn3/2tg1mQoyxOnfJXU8Aokn4OcjszDkWQi/aX5t
29shL/0Dv6d/kmc2ts08XM2QuvcLwjWhKrDKaZEvHB9ylt/t4hYPJ1nvD0Iwjvn1
4jMK5F1tFDtyA5HbxeLnL+SaO5BwO5DtON7yo+/Mhd/0MCN6QZNOQ/Zny8U/c7CK
c5z/RqOT
=85Ed
-----END PGP SIGNATURE-----

--Iffoq89iKcoLON4X--
