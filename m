Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029B8C54E76
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 22:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC6B386F67;
	Thu, 16 Nov 2023 23:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZYWZ3UUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF81786EA3; Thu, 16 Nov 2023 23:57:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D752486F67
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 23:57:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetb@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700175429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GuOvYKhEcfAVYjbMbETvpWvBNpuDqwG/S8w0yXNsCRo=;
 b=ZYWZ3UUq5tgH1SNc0ORDNXIZBoQaMOs9NUa1G+rh3bFqU91nsW2VsxHrjChToA/WilvVWB
 QYY7Bpt+DWQRr8dvQjCIB/qZ4lEXf2/EDj9z4JPixpf+8HABy4VqqoCa/t7vkDZpkEF8B8
 jygH4SjvM9Z//AyaboSTL/jmktJ2lrM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-fj3nPoE_OZu_ahBwIGFSaQ-1; Thu, 16 Nov 2023 17:57:07 -0500
X-MC-Unique: fj3nPoE_OZu_ahBwIGFSaQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-587b3885465so1286985eaf.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 14:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700175426; x=1700780226;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GuOvYKhEcfAVYjbMbETvpWvBNpuDqwG/S8w0yXNsCRo=;
 b=RhLzo7R84sLchSUZAgd3d7G1yc1+qfrOGY/jiDBmhfX7hQvh3gbtFjISCsbx0GQAW1
 KPkahhRP9fld9Xj0fAyodzyy6jAXs6WVarzviiZIfteoUhGIrd2ZxlakwRxBvRiXbJZt
 22OdEI6IxS9xGJColNbvq29ROmJ2UGniW/66TRF/EkQdQkr++N6oQK611MPqeTG2YD0p
 BpvsrClYXuxgi0i9VC1KZouvywMiNLULvmZqLh5hF5YUDRP7fFFc+m7KD6XpWx/70s5A
 eyYYL46mTOrnBI/ryUaiH42EZd4x93/l15P7XWYgFF+LaKcg2zZkuSaphBi4JVwFwyP8
 AJnA==
X-Gm-Message-State: AOJu0YzgfshS1eg3tdiqTrKyYXlg/9Uu1wyjisxsJpgt1a/W/7IJzk4z
 C1b8/VnNPdR1G0VTzWRWlZLfhowzd4JUUsxlVyUUfus3qqrXYOy/m6OnzZt4vrRC6FWdU2vRFK5
 WlcazZl4yc0mfbHaOXyJx/DUqyZwVuQ==
X-Received: by 2002:a4a:9c51:0:b0:586:8c18:ddd9 with SMTP id
 c17-20020a4a9c51000000b005868c18ddd9mr16925109ook.9.1700175426385; 
 Thu, 16 Nov 2023 14:57:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnc1+c4QkUW/AZzjoRruYvycB7+Zfys7hG7aqpY3xM9oyycI7x3J9i0yTv52Kd+VSfOoP2ntRo5JzlKAWkhKA=
X-Received: by 2002:a4a:9c51:0:b0:586:8c18:ddd9 with SMTP id
 c17-20020a4a9c51000000b005868c18ddd9mr16925073ook.9.1700175426020; Thu, 16
 Nov 2023 14:57:06 -0800 (PST)
MIME-Version: 1.0
References: <20231001165545.494212-1-a-nandan@ti.com>
 <lusvfc2to2akeccammsslooai53i4tflvcv4k2iofz3yqco3u6@uvn5flsjhxv3>
In-Reply-To: <lusvfc2to2akeccammsslooai53i4tflvcv4k2iofz3yqco3u6@uvn5flsjhxv3>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Thu, 16 Nov 2023 23:56:55 +0100
Message-ID: <CALE0LRsTUFdSKYEoWDhPZRQEZbwv3-CMV5931KRbPvWmvWTSQA@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] Introduce initial TI's J784S4 and AM69 support
To: Maxime Ripard <mripard@redhat.com>
Cc: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, 
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, 
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Roger Quadros <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de, 
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Maxime


On Wed, Nov 15, 2023 at 2:54=E2=80=AFPM Maxime Ripard <mripard@redhat.com> =
wrote:
>
> Hi,
>
> On Sun, Oct 01, 2023 at 10:25:29PM +0530, Apurva Nandan wrote:
> > This series will introduce basic support (SD and UART) support for Texa=
s
> > Instruments J784S4 EVM.
> >
> > The J784S4 SoC device tree patches are taken from kernel patch submissi=
ons
> > and will be updated as they are accepted and merged to the kernel tree.
> > All other patches are specific to SPL and u-boot and do not have
> > dependency on other trees. Appreciate a review for acceptance to u-boot
> > tree.
> >
> > Here are some of the salient features of the J784S4 automotive grade
> > application processor:
> >
> > The J784S4 SoC belongs to the K3 Multicore SoC architecture
> > platform, providing advanced system integration in automotive,
> > ADAS and industrial applications requiring AI at the network edge.
> > This SoC extends the K3 Jacinto 7 family of SoCs with focus on
> > raising performance and integration while providing interfaces,
> > memory architecture and compute performance for multi-sensor, high
> > concurrency applications.
> >
> > Some highlights of this SoC are:
> > * Up to 8 Cortex-A72s, four clusters of lockstep capable dual Cortex-R5=
F MCUs,
> >   4 C7x floating point vector DSPs with Matrix Multiply Accelerator(MMA=
) for
> >   deep learning and CNN.
> > * 3D GPU: Automotive grade IMG BXS-4-64 MC1
> > * Vision Processing Accelerator (VPAC) with image signal processor and =
Depth
> >   and Motion Processing Accelerator (DMPAC)
> > * Three CSI2.0 4L RX plus two CSI2.0 4L TX, two DSI Tx, one eDP/DP and =
one
> >   DPI interface.
> > * Integrated gigabit ethernet switch, up to 8 ports (TDA4VH), two ports
> >   support 10Gb USXGMII; Two 4 lane PCIe-GEN3 controllers, USB3.0 Dual-r=
ole
> >   device subsystems, Up to 20 MCANs, among other peripherals.
> >
> > See J784S4 Technical Reference Manual (SPRUJ52 - JUNE 2022)
> > for further details: http://www.ti.com/lit/zip/spruj52
> >
> > In addtion, the J784S4 EVM board is designed for TI J784S4 SoC. It
> > supports the following interfaces:
> > * 32 GB DDR4 RAM
> > * x2 Gigabit Ethernet interfaces capable of working in Switch and MAC m=
ode
> > * x1 Input Audio Jack, x1 Output Audio Jack
> > * x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
> > * x2 4L PCIe connector
> > * x1 UHS-1 capable micro-SD card slot
> > * 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
> >   UFS flash.
> > * x6 UART through UART-USB bridge
> > * XDS110 for onboard JTAG debug using USB
> > * Temperature sensors, user push buttons and LEDs
> > * 40-pin User Expansion Connector
> > * x2 ENET Expansion Connector, x1 GESI expander, x2 Display connector
> > * x1 15-pin CSI header
> > * x6 MCAN instances
>
> I've tested this series on top of 2024.01-rc2, and while it worked fine
> before, the (external) MMC is now broken:
>
> U-Boot SPL 2024.01-rc2-00021-g8e3ced8fbad8 (Nov 15 2023 - 12:07:18 +0100)
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.2--v09.01.02 (Kool Koala)')
> SPL initial stack usage: 13416 bytes
> Trying to boot from MMC2
> Warning: Did not detect image signing certificate. Skipping authenticatio=
n to prevent boot failure. This will fail on Security Enforcing(HS-SE) devi=
ces
> Warning: Did not detect image signing certificate. Skipping authenticatio=
n to prevent boot failure. This will fail on Security Enforcing(HS-SE) devi=
ces
> Warning: Did not detect image signing certificate. Skipping authenticatio=
n to prevent boot failure. This will fail on Security Enforcing(HS-SE) devi=
ces
> Loading Environment from nowhere... OK
> Warning: Did not detect image signing certificate. Skipping authenticatio=
n to prevent boot failure. This will fail on Security Enforcing(HS-SE) devi=
ces
> Warning: Did not detect image signing certificate. Skipping authenticatio=
n to prevent boot failure. This will fail on Security Enforcing(HS-SE) devi=
ces
> Starting ATF on ARM64 core...
>
> NOTICE:  BL31: v2.9(release):v2.9.0
> NOTICE:  BL31: Built : 12:07:09, Nov 15 2023
> I/TC:
> I/TC: OP-TEE version: 4.0.0 (gcc version 13.2.1 20230728 (Red Hat Cross 1=
3.2.1-1) (GCC)) #1 Wed Nov 15 11:07:14 UTC 2023 aarch64
> I/TC: WARNING: This OP-TEE configuration might be insecure!
> I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/archit=
ecture/porting_guidelines.html
> I/TC: Primary CPU initializing
> I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.2--v09.01.02 (Kool Koala)'=
)
> I/TC: HUK Initialized
> I/TC: Activated SA2UL device
> I/TC: Enabled firewalls for SA2UL TRNG device
> I/TC: SA2UL TRNG initialized
> I/TC: SA2UL Drivers initialized
> I/TC: Primary CPU switching to normal world boot
>
> U-Boot SPL 2024.01-rc2-00021-g8e3ced8fbad8 (Nov 15 2023 - 12:07:30 +0100)
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.2--v09.01.02 (Kool Koala)')
> Trying to boot from MMC2
> Warning: Did not detect image signing certificate. Skipping authenticatio=
n to prevent boot failure. This will fail on Security Enforcing(HS-SE) devi=
ces
> Warning: Did not detect image signing certificate. Skipping authenticatio=
n to prevent boot failure. This will fail on Security Enforcing(HS-SE) devi=
ces
>
>
> U-Boot 2024.01-rc2-00021-g8e3ced8fbad8 (Nov 15 2023 - 12:07:30 +0100)
>
> SoC:   J784S4 SR1.0 HS-FS
> Model: Texas Instruments J784S4 EVM

Maybe something changed but I'm surprised about it reporting an EVM
board. I was expecting something like

Model: Texas Instruments AM69 SK
Board: AM69-SK rev E2

Did you use the am69_sk_a72/r5  defconfigs?

> DRAM:  32 GiB
> Core:  90 devices, 31 uclasses, devicetree: separate
> Flash: 0 Bytes
> MMC:   mmc@4f80000: 0, mmc@4fb0000: 1
> Loading Environment from nowhere... OK
> In:    serial@2880000
> Out:   serial@2880000
> Err:   serial@2880000
> am65_cpsw_nuss ethernet@46000000: K3 CPSW: nuss_ver: 0x6BA02102 cpsw_ver:=
 0x6BA82102 ale_ver: 0x00293904 Ports:1 mdio_freq:1000000
> Net:   eth0: ethernet@46000000port@1
> Hit any key to stop autoboot:  0
> =3D> boot
> i2c_write: error waiting for data ACK (status=3D0x116)
> pca953x gpio@22: Error reading output register
> Card did not respond to voltage select! : -110
> mmc_init: -95, time 114
>
> Maxime

