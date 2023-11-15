Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34D4C48BD7
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEFEA870D2;
	Wed, 15 Nov 2023 14:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eVjVNEzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14A5086FEF; Wed, 15 Nov 2023 14:53:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEB23871DF
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:53:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mripard@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700056424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jmfg+0VzYKId+m/afZYEDgvFmO0ojHezjGTVP1tL9r8=;
 b=eVjVNEzmz1WF+S3ccxYgW3pwcMpcrbLSMzN5SK0c38OyfwOAGdCjuddMbPhmf+jM7SmZ9H
 I9nghgjJWZYygSrkt60Tqgt9Q5BM8kP6UZX2y942YlKvdPnQzZiGj3u74PcC+SNhcX2IlM
 oYp07UPle+m3GFTJJhHB+VTsDGXrxAs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-RGuambn7PhapT6KbnXwvmQ-1; Wed, 15 Nov 2023 08:53:42 -0500
X-MC-Unique: RGuambn7PhapT6KbnXwvmQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40a4c765d3bso4881985e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700056421; x=1700661221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmfg+0VzYKId+m/afZYEDgvFmO0ojHezjGTVP1tL9r8=;
 b=QbQrVYAZ7GviWVZL8zb3N+aLl/QCoV+X+nxdvnjoxjRk0/7pz4q0U9EqHha36JMKRi
 BS2Sn5psqbBGd+vIB9MjvspbynpvWs+QtqAkMFdlyzIHeH2BAN8XNj14HekifOmHPgRD
 VI+t1EvOqhAPxTrw3HntJgbC7vqoRHIjQsuita0aiOordC8z9WIghWh3jxnUdYKft7bS
 ajp2kGztECNQcbLlOmj2BZdRBs5eO5SBHVMvtsPnAIrdRzIOV5rRh3HuHCue7ArmktbO
 Rnv/lI8q924iLLG0J1wsvaxvRZ60cLzDEnvFoUZ6tI5beKMkqr2kHh7ge2k5K5B+vqMH
 TGzA==
X-Gm-Message-State: AOJu0YwFej/PXhvlecdxwKYMsLLfxftNUiO+05epPZ9fQ/PpmDJnW1W1
 qGkAYORcgKPiI4FXwWWB6uJWqTWjn4kv/gMhtqI/ML+7llNEeuvqrmBXsVoZ8onTsUAraMUbYav
 jDzdxxV5V39pFzA==
X-Received: by 2002:a05:600c:1c1e:b0:405:3f06:d2ef with SMTP id
 j30-20020a05600c1c1e00b004053f06d2efmr4994873wms.4.1700056421439; 
 Wed, 15 Nov 2023 05:53:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCtpakZEwzztaOxmGirbqyrM+GNz2pI9zKDn+dng6WNhbFAb8TYGTFXnnlxOUgSbckwEVCng==
X-Received: by 2002:a05:600c:1c1e:b0:405:3f06:d2ef with SMTP id
 j30-20020a05600c1c1e00b004053f06d2efmr4994844wms.4.1700056421005; 
 Wed, 15 Nov 2023 05:53:41 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
 by smtp.gmail.com with ESMTPSA id
 fl23-20020a05600c0b9700b0040a45fffd27sm17622317wmb.10.2023.11.15.05.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 05:53:40 -0800 (PST)
Date: Wed, 15 Nov 2023 14:53:40 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Apurva Nandan <a-nandan@ti.com>
Cc: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, 
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Bryan Brattlof <bb@ti.com>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Roger Quadros <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 u-boot@lists.denx.de, Sinthu Raja M <sinthu.raja@mistralsolutions.com>, 
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v4 00/16] Introduce initial TI's J784S4 and AM69 support
Message-ID: <lusvfc2to2akeccammsslooai53i4tflvcv4k2iofz3yqco3u6@uvn5flsjhxv3>
References: <20231001165545.494212-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qctwhvs7v33wqbic"
Content-Disposition: inline
In-Reply-To: <20231001165545.494212-1-a-nandan@ti.com>
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


--qctwhvs7v33wqbic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 01, 2023 at 10:25:29PM +0530, Apurva Nandan wrote:
> This series will introduce basic support (SD and UART) support for Texas
> Instruments J784S4 EVM.
>=20
> The J784S4 SoC device tree patches are taken from kernel patch submissions
> and will be updated as they are accepted and merged to the kernel tree.
> All other patches are specific to SPL and u-boot and do not have
> dependency on other trees. Appreciate a review for acceptance to u-boot
> tree.
>=20
> Here are some of the salient features of the J784S4 automotive grade=20
> application processor:
>=20
> The J784S4 SoC belongs to the K3 Multicore SoC architecture
> platform, providing advanced system integration in automotive,
> ADAS and industrial applications requiring AI at the network edge.
> This SoC extends the K3 Jacinto 7 family of SoCs with focus on
> raising performance and integration while providing interfaces,
> memory architecture and compute performance for multi-sensor, high
> concurrency applications.
>=20
> Some highlights of this SoC are:
> * Up to 8 Cortex-A72s, four clusters of lockstep capable dual Cortex-R5F =
MCUs,
>   4 C7x floating point vector DSPs with Matrix Multiply Accelerator(MMA) =
for
>   deep learning and CNN.
> * 3D GPU: Automotive grade IMG BXS-4-64 MC1                =20
> * Vision Processing Accelerator (VPAC) with image signal processor and De=
pth
>   and Motion Processing Accelerator (DMPAC)
> * Three CSI2.0 4L RX plus two CSI2.0 4L TX, two DSI Tx, one eDP/DP and one
>   DPI interface.
> * Integrated gigabit ethernet switch, up to 8 ports (TDA4VH), two ports
>   support 10Gb USXGMII; Two 4 lane PCIe-GEN3 controllers, USB3.0 Dual-role
>   device subsystems, Up to 20 MCANs, among other peripherals.
>=20
> See J784S4 Technical Reference Manual (SPRUJ52 - JUNE 2022)
> for further details: http://www.ti.com/lit/zip/spruj52
>=20
> In addtion, the J784S4 EVM board is designed for TI J784S4 SoC. It=20
> supports the following interfaces:
> * 32 GB DDR4 RAM
> * x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mode
> * x1 Input Audio Jack, x1 Output Audio Jack
> * x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
> * x2 4L PCIe connector
> * x1 UHS-1 capable micro-SD card slot
> * 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
>   UFS flash.
> * x6 UART through UART-USB bridge
> * XDS110 for onboard JTAG debug using USB
> * Temperature sensors, user push buttons and LEDs
> * 40-pin User Expansion Connector
> * x2 ENET Expansion Connector, x1 GESI expander, x2 Display connector
> * x1 15-pin CSI header
> * x6 MCAN instances

I've tested this series on top of 2024.01-rc2, and while it worked fine
before, the (external) MMC is now broken:

U-Boot SPL 2024.01-rc2-00021-g8e3ced8fbad8 (Nov 15 2023 - 12:07:18 +0100)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.2--v09.01.02 (Kool Koala)')
SPL initial stack usage: 13416 bytes
Trying to boot from MMC2
Warning: Did not detect image signing certificate. Skipping authentication =
to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
Warning: Did not detect image signing certificate. Skipping authentication =
to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
Warning: Did not detect image signing certificate. Skipping authentication =
to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
Loading Environment from nowhere... OK
Warning: Did not detect image signing certificate. Skipping authentication =
to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
Warning: Did not detect image signing certificate. Skipping authentication =
to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
Starting ATF on ARM64 core...

NOTICE:  BL31: v2.9(release):v2.9.0
NOTICE:  BL31: Built : 12:07:09, Nov 15 2023
I/TC:
I/TC: OP-TEE version: 4.0.0 (gcc version 13.2.1 20230728 (Red Hat Cross 13.=
2.1-1) (GCC)) #1 Wed Nov 15 11:07:14 UTC 2023 aarch64
I/TC: WARNING: This OP-TEE configuration might be insecure!
I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architec=
ture/porting_guidelines.html
I/TC: Primary CPU initializing
I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.2--v09.01.02 (Kool Koala)')
I/TC: HUK Initialized
I/TC: Activated SA2UL device
I/TC: Enabled firewalls for SA2UL TRNG device
I/TC: SA2UL TRNG initialized
I/TC: SA2UL Drivers initialized
I/TC: Primary CPU switching to normal world boot

U-Boot SPL 2024.01-rc2-00021-g8e3ced8fbad8 (Nov 15 2023 - 12:07:30 +0100)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.2--v09.01.02 (Kool Koala)')
Trying to boot from MMC2
Warning: Did not detect image signing certificate. Skipping authentication =
to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
Warning: Did not detect image signing certificate. Skipping authentication =
to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices


U-Boot 2024.01-rc2-00021-g8e3ced8fbad8 (Nov 15 2023 - 12:07:30 +0100)

SoC:   J784S4 SR1.0 HS-FS
Model: Texas Instruments J784S4 EVM
DRAM:  32 GiB
Core:  90 devices, 31 uclasses, devicetree: separate
Flash: 0 Bytes
MMC:   mmc@4f80000: 0, mmc@4fb0000: 1
Loading Environment from nowhere... OK
In:    serial@2880000
Out:   serial@2880000
Err:   serial@2880000
am65_cpsw_nuss ethernet@46000000: K3 CPSW: nuss_ver: 0x6BA02102 cpsw_ver: 0=
x6BA82102 ale_ver: 0x00293904 Ports:1 mdio_freq:1000000
Net:   eth0: ethernet@46000000port@1
Hit any key to stop autoboot:  0
=3D> boot
i2c_write: error waiting for data ACK (status=3D0x116)
pca953x gpio@22: Error reading output register
Card did not respond to voltage select! : -110
mmc_init: -95, time 114

Maxime

--qctwhvs7v33wqbic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZVTNZAAKCRDj7w1vZxhR
xabOAQDvOP7C5t048kx+PX8bD4v0QfFlDejdsEHS7IEIbK+iLQD9HAuHhlmcKRmF
zH/vzZGv2rzem4+Mt/PDNwgeCZ9Obwo=
=0cAP
-----END PGP SIGNATURE-----

--qctwhvs7v33wqbic--

