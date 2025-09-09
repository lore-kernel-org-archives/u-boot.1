Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102D9CAC582
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 22:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 513D58319C;
	Wed, 10 Sep 2025 00:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NYfdYk2K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84FF6831A4; Wed, 10 Sep 2025 00:03:19 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5905183192
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 00:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-889b846c568so246190339f.1
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 15:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757455396; x=1758060196; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x1mwFbFnkF4bAlzxDn9G1oavs5Igqe0iYmt7M8aqT18=;
 b=NYfdYk2KdMschhYkxuflAakh5s7TARlQI8m4NOGmr/8ULnrINlRsRK+rrB59Gnvb01
 8/If+zA9ZGVm69sPKgFYdo9nk4cgtRiTrcnXYyPZSTZptdrnnfApuQaClqnT0A+i+fbw
 PC93L9n3fu52bHiM25Ns/S/HHBCFLB6jQwygU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757455396; x=1758060196;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x1mwFbFnkF4bAlzxDn9G1oavs5Igqe0iYmt7M8aqT18=;
 b=Qfdm6EaXHIpjoUKy4AEmYAr4ak2YEGuQIW/OsUb4TrmHvncI7JLVAFe0sXdEM1rr1j
 mqoGwQW2uE11GijUC3+fx6vl31Cv1Bw4w7GeZio4K3ohsAEzjmCswkpZ1lJXV7y2luGL
 kHNSDVjmtdx6vIRDWsSQc0qmP/dtO1lYFAUgHwqkzEf2c+OlpKlCMm9M56ENbbKuZ34F
 r79pJTMOk912hAoBGNJ0jVn/iJFIfKUzlNAgkQpczYuEq8c3QAJA68U35E7waB2xhXJR
 OhAdFZahAucaf6BZSM6vwrryWkCkAwteaagPCsucQ1RMm96NAUxa4SSV1XMpWKdNisNS
 CfFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGGyvTC6hh6WLI0mTKXnCarathqudygqf+y7At8yy5Om7viUe17zjlbg6IB9qdKm3bCMSb6zE=@lists.denx.de
X-Gm-Message-State: AOJu0YwTTwrmY5WRRtE5lATUvEsU++2N02h9Z32hHy3EtUYh+mLvzuKd
 RE8V8qGMclte+ictRQ/ixuqsPHiGrs35GrNUbQTfVzKJgf74MSoCWwlcBITthUxthn8=
X-Gm-Gg: ASbGncsYkBPCYOeS72y02ueuJPSvrp7KPDvWP6DSnvV3RdL/ht3UfGcVURBlVspn/U3
 AfB+6mhdSDKODuaohCip2xvwCJoJveNwj29A8Tpiozgfx46259kuZeFCFDKMTeE2iY3wYwCzn6g
 CycygpsAc6EKLJFH23tRB3ms19wf593+iywNCwaGAAb+3mEC6Xe00NexDdYZwd4afTyF6vj6UOH
 9IoDt79do3CjAjbrew/oRsFpaHc7l2gz4D8oMjtroJtwVl7Db4ygVsjv5eOJq3C4o1KeqYvDo4p
 +sqvEouZesxlah5D7pXWWbGUR65RBy8XD2KyB98MDpJVjSZEFuTbUpDT246sz5u8Wd1QkmccdIZ
 DhCBen6rFLox7yE7N3mj7nudLErJ2gQYayNrkB58ivmMMvHbIOo4idlLf
X-Google-Smtp-Source: AGHT+IHTssjrCcaZu2EKpqQ9fGgVWue4vf1+ld0yryMYbh4Nk0X+u8d3zpnyVpgEjnFwRWvda6cZxw==
X-Received: by 2002:a05:6602:29cb:b0:873:47c7:6ff3 with SMTP id
 ca18e2360f4ac-88777540282mr2198735339f.7.1757455396077; 
 Tue, 09 Sep 2025 15:03:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-88c31dee466sm192175539f.7.2025.09.09.15.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 15:03:14 -0700 (PDT)
Date: Tue, 9 Sep 2025 16:03:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Paresh Bhagat <p-bhagat@ti.com>
Cc: vigneshr@ti.com, praneeth@ti.com, nm@ti.com, u-boot@lists.denx.de,
 bb@ti.com, khasim@ti.com, v-singh1@ti.com, afd@ti.com, anshuld@ti.com
Subject: Re: [RFC PATCH v2 0/5] Add initial support for AM62D2-EVM
Message-ID: <20250909220312.GD124814@bill-the-cat>
References: <20250909053429.444854-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y5OVnBuvRQS0VN0Q"
Content-Disposition: inline
In-Reply-To: <20250909053429.444854-1-p-bhagat@ti.com>
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


--y5OVnBuvRQS0VN0Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 11:04:24AM +0530, Paresh Bhagat wrote:
> The AM62D2 SoC, part of the K3 architecture, is built for high-performance
> DSP tasks in automotive audio, pro audio, radar, sonar, and medical
> imaging. It features up to four Cortex-A53 cores (1.4GHz), two Cortex-R5F
> cores, and a C7x DSP with 2 TOPS MMA. Key interfaces include multi-channel
> McASP audio, TSN-capable Gigabit Ethernet, and a range of peripherals
> (UART, SPI, I2C, CAN, USB, eMMC/SD, OSPI, CSI). It supports LPDDR4/DDR4,
> secure boot with hardware security, and low-power modes with
> CAN/GPIO/UART wakeup.
[snip]
>  arch/arm/dts/Makefile                        |    2 +
>  arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi | 2802 ++++++++++++++++++
>  arch/arm/dts/k3-am62d-evm-binman.dtsi        |  262 ++
>  arch/arm/dts/k3-am62d2-evm-u-boot.dtsi       |   14 +
>  arch/arm/dts/k3-am62d2-r5-evm.dts            |   82 +
>  arch/arm/mach-k3/am62ax/Kconfig              |   25 +
>  board/ti/am62dx/Kconfig                      |   26 +
>  board/ti/am62dx/MAINTAINERS                  |    8 +
>  board/ti/am62dx/Makefile                     |    7 +
>  board/ti/am62dx/am62dx.env                   |   21 +
>  board/ti/am62dx/board-cfg.yaml               |   36 +
>  board/ti/am62dx/evm.c                        |   37 +
>  board/ti/am62dx/pm-cfg.yaml                  |   12 +
>  board/ti/am62dx/rm-cfg.yaml                  | 1047 +++++++
>  board/ti/am62dx/sec-cfg.yaml                 |  379 +++
>  board/ti/am62dx/tifs-rm-cfg.yaml             |  903 ++++++
>  configs/am62dx_evm_a53_defconfig             |   22 +
>  configs/am62dx_evm_r5_defconfig              |   20 +
>  18 files changed, 5705 insertions(+)
>  create mode 100644 arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi
>  create mode 100644 arch/arm/dts/k3-am62d-evm-binman.dtsi
>  create mode 100644 arch/arm/dts/k3-am62d2-evm-u-boot.dtsi
>  create mode 100644 arch/arm/dts/k3-am62d2-r5-evm.dts
>  create mode 100644 board/ti/am62dx/Kconfig
>  create mode 100644 board/ti/am62dx/MAINTAINERS
>  create mode 100644 board/ti/am62dx/Makefile
>  create mode 100644 board/ti/am62dx/am62dx.env
>  create mode 100644 board/ti/am62dx/board-cfg.yaml
>  create mode 100644 board/ti/am62dx/evm.c
>  create mode 100644 board/ti/am62dx/pm-cfg.yaml
>  create mode 100644 board/ti/am62dx/rm-cfg.yaml
>  create mode 100644 board/ti/am62dx/sec-cfg.yaml
>  create mode 100644 board/ti/am62dx/tifs-rm-cfg.yaml
>  create mode 100644 configs/am62dx_evm_a53_defconfig
>  create mode 100644 configs/am62dx_evm_r5_defconfig

This isn't architecture and board, it's just a board, it should be a
single patch. In that some of these yaml files are big, it would be good
to figure out as a generic problem how to reduce that if possible (I
don't know if it is).

--=20
Tom

--y5OVnBuvRQS0VN0Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMCkIAAKCRAr4qD1Cr/k
CiBIAQC6z+L1Hu7419d6Iw+oLgSNn4GMMaE6cy/cAc/cmfXy/QEAhVzerxfwgI6o
cZjSnBWB0qijnogSBAZh3W1s+XN1UwE=
=ky1r
-----END PGP SIGNATURE-----

--y5OVnBuvRQS0VN0Q--
