Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB61CEBF93
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 07:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8063E83B86;
	Tue, 18 Nov 2025 08:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hGXxA8+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90CED83C5E; Tue, 18 Nov 2025 08:28:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 489D283AC7
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 08:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763450894; x=1764055694; i=xypron.glpk@gmx.de;
 bh=9UpVSdMe0TaEyqN2HAJEC3k5TuCTG0ngX5h8NDfoi3g=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hGXxA8+Dp1U17hYEjL/c78dneg1N1j97em8GA6h+upntbDTekF/ZshbGlizN0S/W
 SkR7dvsdFB9ljsJh5IyV0n9a13KdY0U2HVTcgXxfUOZMKK2XQQh8Vp0A/bmejwJZS
 ot8HtjDQOQ+uv4pWgNk7IwmxRyGX/pExwG+wsuAde3hMd+NOd8cpNT/jcBhIhLogM
 +Uabjno4PrVsmgF/D4qWeVxe+6TNfyqcYfs5RlwcahRqPOEWpjhPNIiS3gsIQshmp
 aOwtw/XQdVJKGmBKs4qqnicNjC9Bj6+fOGtvvSXGrQZiktafjkVg+cvqtPDpzrUXs
 IAZVMtXt6+B3n8tlLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsHs0-1wAcjP3jHG-00zw7R; Tue, 18
 Nov 2025 08:28:14 +0100
Date: Tue, 18 Nov 2025 08:08:12 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: E Shattow <e@freeshell.de>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH v2] doc: board: starfive: update jh7110 common description
User-Agent: Thunderbird for Android
In-Reply-To: <20251117233603.15409-1-e@freeshell.de>
References: <20251117233603.15409-1-e@freeshell.de>
Message-ID: <24B5D5B7-0D3F-4091-82B8-A5E2328DE59F@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fD73RkiLswUsawV0UhDBkktgsLgJQIWJxjlNHhdzyw0gpx1LcRs
 mQwL/zq2N/4jkJV9E3XLGXFL5OiaesaoVO8GO5Td7lT59i3baU6SgZi4fjxgaEMi/U3pKJ9
 wa+P33x7gO+duIKBE9jeBVTn9J+XkHeJ3hHXtPeskgq1uKHGgvLqnHdVjNkXoeUnnWP6byY
 NrM+/IKGf+N1r9cc2+1Sg==
UI-OutboundReport: notjunk:1;M01:P0:XBSZYzIZeo0=;74q792+7MK8VGdpdvDLl+Oo6gqu
 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
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

Am 18=2E November 2025 00:35:51 MEZ schrieb E Shattow <e@freeshell=2Ede>:
>Updates to the JH7110 common description:
>- add detailed overview of JH-7110 SoC and boot process
>- revise descriptions of deprecated StarFive loader modes
>- refresh build directions grouped with SPL debug advice
>- reduce usage instructions into common methods shared by supported board=
s
>- cite starfive_visionfive2 board maintainer description of StarFive load=
er
>- cite published datasheets for ambient operating temperature data
>
>Redundant/deprecated sections of each board doc are dropped accordingly:
>- deepcomputing fml13v01
>- milk-v mars
>- pine64 star64 (also add inclusion of JH7110 common description)
>- visionfive2
>
>Signed-off-by: E Shattow <e@freeshell=2Ede>
>---
>Changes since v1:
>
>By popular request I have expanded on the topic of deprecated boot modes=
=2E
>For those users that rely on this it is now more descriptive about
>factors contributing to the feature deprecation and naming the U-Boot
>release version when this change is in effect=2E Re-introducing these mod=
es
>is out of scope for this documentation series, however=2E
>
>- reST needs a space between numeric and the substitution
>- add comment identifying where U-Boot SPL again reads state of [RGPIO1:R=
GPIO0]
>  useful to refer to for boards with button+transistors instead of MSEL D=
IP
>- cite reference to JH-7110 Boot User Guide BootROM description of StarFi=
ve loader
>- expand on topic of supported and deprecated U-Boot SPL boot modes
>- cite from published datasheets for ambient operating temperature data
>- drop not-yet-published OpenSBI version recommendation
>---
> doc/board/starfive/deepcomputing_fml13v01=2Erst |  32 -
> doc/board/starfive/jh7110_common=2Erst          | 633 +++++++++++++++---
> doc/board/starfive/milk-v_mars=2Erst            |  73 --
> doc/board/starfive/pine64_star64=2Erst          |  77 +--
> doc/board/starfive/visionfive2=2Erst            | 449 -------------
> 5 files changed, 547 insertions(+), 717 deletions(-)
>
>diff --git a/doc/board/starfive/deepcomputing_fml13v01=2Erst b/doc/board/=
starfive/deepcomputing_fml13v01=2Erst
>index 5d9612483b4=2E=2E9777f4c6303 100644
>--- a/doc/board/starfive/deepcomputing_fml13v01=2Erst
>+++ b/doc/board/starfive/deepcomputing_fml13v01=2Erst
>@@ -9,38 +9,6 @@ The DeepComputing Framework motherboard (FLM13V01) can b=
e combined with a
> U-Boot for the board uses the same binaries as the VisionFive 2 board=2E
> Currently only serial console output is supported by mainline U-Boot=2E
>=20
>-Building
>---------
>-
>-Setup the cross compilation environment variable:
>-
>-=2E=2E code-block:: bash
>-
>-   export CROSS_COMPILE=3Driscv64-linux-gnu-
>-
>-The M-mode software OpenSBI provides the supervisor binary interface (SB=
I) and
>-is responsible for the switch to S-Mode=2E It is a prerequisite for buil=
ding
>-U-Boot=2E Support for the JH7110 was introduced in OpenSBI 1=2E2=2E It i=
s recommended
>-to use a current release=2E
>-
>-=2E=2E code-block:: bash
>-
>-    git clone https://github=2Ecom/riscv/opensbi=2Egit
>-    cd opensbi
>-    make PLATFORM=3Dgeneric FW_TEXT_START=3D0x40000000 FW_OPTIONS=3D0
>-    export OPENSBI=3D"$(pwd)/build/platform/generic/firmware/fw_dynamic=
=2Ebin"
>-
>-Now build U-Boot SPL and main U-Boot=2E
>-
>-=2E=2E code-block:: bash
>-
>-    cd <U-Boot-dir>
>-    make starfive_visionfive2_defconfig
>-    make
>-
>-This will generate the U-Boot SPL image (spl/u-boot-spl=2Ebin=2Enormal=
=2Eout) as well
>-as the FIT image (u-boot=2Eitb) with OpenSBI, U-Boot, and device-trees=
=2E
>-
> Device-tree selection
> ---------------------
>=20
>diff --git a/doc/board/starfive/jh7110_common=2Erst b/doc/board/starfive/=
jh7110_common=2Erst
>index 4a8058ee5da=2E=2E2f049b4c327 100644
>--- a/doc/board/starfive/jh7110_common=2Erst
>+++ b/doc/board/starfive/jh7110_common=2Erst
>@@ -1,103 +1,560 @@
> =2E=2E SPDX-License-Identifier: GPL-2=2E0-or-later
>+=2E=2E |arrowin| unicode:: U+2190
>+=2E=2E |arrowout| unicode:: U+2192
>+=2E=2E |degreecelsius| unicode:: U+2103
>+=2E=2E _U74-MC Core Complex: https://www=2Estarfivetech=2Ecom/uploads/u7=
4mc_core_complex_manual_21G1=2Epdf
>+=2E=2E _JH-7110 Technical Reference Manual: https://doc-en=2Ervspace=2Eo=
rg/JH7110/TRM/
>+=2E=2E _JH-7110 Boot User Guide BootROM: https://doc-en=2Ervspace=2Eorg/=
VisionFive2/Boot_UG/JH7110_SDK/bootrom=2Ehtml
>+=2E=2E _JH-7110 Datasheet: https://doc-en=2Ervspace=2Eorg/JH7110/PDF/JH7=
110_DS=2Epdf
>+=2E=2E _JH-7110I Datasheet: https://doc-en=2Ervspace=2Eorg/JH7110/PDF/JH=
7110I_DS=2Epdf
>+=2E=2E _Description of StarFive loader: https://lore=2Ekernel=2Eorg/u-bo=
ot/ZQ2PR01MB1307E9F46803F18B2B9D5394E6C22@ZQ2PR01MB1307=2ECHNPR01=2Eprod=2E=
partner=2Eoutlook=2Ecn/
>=20
>-Boot source selection
>----------------------
>+StarFive JH-7110 RISC-V SoC
>+---------------------------
>=20
>-The board provides DIP switches to select the device for loading the boo=
t
>-firmware=2E
>+* JH-7110 working frequency 1=2E5GHz
>+  ambient operating temperature range -20 |degreecelsius| to +85 |degree=
celsius|
>+  (`JH-7110 Datasheet`_)
>=20
>-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=3D
>-Boot source SW1 SW2
>-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=3D
>-UART        OFF OFF
>-SD-card     ON  OFF
>-eMMC        OFF ON
>-SPI flash   ON  ON
>-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=3D
>+* JH-7110I working frequency 1=2E5GHz
>+  ambient operating temperature range -40 |degreecelsius| to +85 |degree=
celsius|
>+  (`JH-7110I Datasheet`_)
>=20
>-Flashing a new U-Boot version
>------------------------------
>+* JH-7110S working frequency 1=2E25GHz
>=20
>-U-Boot SPL is provided as file spl/u-boot-spl=2Ebin=2Enormal=2Eout=2E Ma=
in U-Boot is
>-in file u-boot=2Eitb=2E
>+JH-7110 is a 4+1 core RISC-V System on Chip:
>=20
>-Assuming your new U-Boot version is on partition 1 of an SD-card you cou=
ld
>-install it to the SPI flash with:
>+* `U74-MC Core Complex`_
>=20
>-=2E=2E code-block:: console
>+  * S7 monitor core RV64IMAC
>+
>+    * Physical Memory Protection
>+    * 16KB L1 Instruction cache
>+    * 8KB Data Tightly-Integrated Memory
>+
>+  * U74 application core RV64GC (x4)
>+
>+    * Sv39 Memory Management Unit
>+    * Floating Point Unit
>+    * 32KB L1 Instruction cache
>+    * 32KB L1 Data cache
>+    * Physical Memory Protection
>+
>+  * Core-Local INTerruptor
>+  * Platform-Level Interrupt Controller
>+  * Debug
>+  * Bus Matrix
>+
>+    * 2MB L2 cache
>+
>+      * Memory Port |arrowout| 128-bit AXI4
>+
>+    * System Port |arrowout| 64-bit AXI4
>+    * Peripheral Port |arrowout| 64-bit AXI4
>+    * Front Port |arrowin| 64-bit AXI4
>+
>+* Block
>+
>+  * RV32IMAFCB E24 co-processor
>+
>+    * 16KB Instruction cache
>+    * 32KB Tightly-Integrated Memory "A"
>+    * 32KB Tightly-Integrated Memory "B"
>+
>+  * Mailbox
>+  * SGDMA
>+
>+* Network-on-Chip/AXI bus
>+* Memory
>+
>+  * SRAM 256KB/BootROM 32KB
>+  * LPDDR4/DDR4/LPDDR3/DDR3 32-bit 2800 Mbps (2133 Mbps supported workin=
g speed)
>+  * QSPI Flash Controller
>+
>+* Interfaces
>+
>+  * PCIe2=2E0 1-lane x2
>+  * Ethernet MAC 10/100/1000 Mbps x2
>+  * USB 2=2E0 Host/Device
>+  * SDIO3=2E0 x2
>+  * CAN2=2E0B x2
>+
>+* Audio
>+
>+  * Cadence Tensilica HiFi-4 Audio DSP defined by U74MC or E24
>+
>+    * 4x 32x32-bit MACs
>+    * some 72-bit accumulators
>+    * limited support for 8x 32x16-bit MACs
>+    * fourth VLIW slot
>+    * two 64-bit loads per cycle
>+    * optional floating point unit for four single-precision MACs per cy=
cle
>+
>+  * I2S/PCM-TDM
>+  * I2S/PCM
>+  * PDM x4
>+  * SPDIF
>+
>+* Graphics
>+
>+  * Epicsemi ISP
>+  * IMG BXE-4-32 Integrated GPU with 3D Acceleration
>+  * 12-bit DVP
>+  * MIPI-CSI
>+
>+* Cryptographic function
>+
>+  * TRNG
>+  * OTP
>+  * Security HW Engine AES/DES/3DES/HASH/PKA
>+
>+* Block
>+
>+  * PAD_SHARE used for reset
>+  * Power Management Unit Clock Reset Generator
>+  * PLL x3
>+  * JTAG
>+  * RTC
>+  * Temperature Sensor
>+
>+Supported SoC drivers:
>+
>+* ns16550 UART
>+* StarFive JH-7110 clock
>+* StarFive JH-7110 reset
>+* Cadence QSPI controller
>+* DesignWare MMC for eMMC/SD support
>+* PLDA PCIe controller
>+* Cadence USB2=2E0/3=2E0 controller
>+
>+Supported common peripherals:
>+
>+* AXP15060 Power Management Unit
>+* LPDDR4 2GB / 4GB / 8GB DRAM memory
>+* AT24C04F 4K bits (512 x 8) EEPROM
>+* QSPI NOR Flash 16M or SoC ROM UART loader for boot (selectable by GPIO=
)
>+
>+Extra supported peripherals present on some boards:
>+
>+* Motorcomm YT8531C Gigabit Ethernet PHY
>+* On-board VL805 PCIE-USB controller driver
>+* Status LED RGPIO3
>+
>+Build U-Boot
>+------------
>+
>+1=2E  Add a RISC-V toolchain to your PATH=2E
>+2=2E  Set cross compilation environment variable if needed:
>+
>+    =2E=2E code-block:: none
>+
>+       export CROSS_COMPILE=3D<riscv64 toolchain prefix>
>+
>+3=2E  U-Boot for JH-7110 requires OpenSBI v1=2E5+ generic platform objec=
t
>+    fw_dynamic=2Ebin to be included in the Flattened Image Tree blob=2E =
OpenSBI may
>+    first be built as below:

Please, describe that the JH7710S requires a patch that will be in OpenSBI=
 v1=2E8 for reboot support=2E


>+
>+    =2E=2E code-block:: console
>+
>+       # clone and/or update OpenSBI sources
>+       git clone https://github=2Ecom/riscv/opensbi=2Egit opensbi=2Egit
>+       git -C opensbi=2Egit checkout v1=2E7
>+       # always clean build directory when building OpenSBI due to incom=
plete
>+       # dependency tracking
>+       make -C opensbi=2Egit -O opensbi clean
>+       make -C opensbi=2Egit -O opensbi PLATFORM=3Dgeneric
>+
>+4=2E  Now build the First Stage BootLoader (U-Boot Secondary Program Loa=
der) and
>+    Second Boot Loader (OpenSBI + U-Boot Main):
>+
>+    =2E=2E code-block:: console
>+
>+       git clone https://source=2Edenx=2Ede/u-boot/u-boot=2Egit u-boot=
=2Egit
>+       make -C u-boot=2Egit -O u-boot starfive_visionfive2_defconfig
>+       export OPENSBI=3Dopensbi/build/platform/generic/firmware/fw_dynam=
ic=2Ebin
>+       make -C u-boot=2Egit -O u-boot

Why make it that complicated? Neither -O nor -C is needed if you are in th=
e U-Boot directory=2E

-j(nproc) is helpful=2E

>+
>+    This will generate the U-Boot SPL image object post-processed with S=
tarFive
>+    SPL headers (u-boot/spl/u-boot-spl=2Ebin=2Enormal=2Eout) as well as =
the FIT image
>+    (u-boot/u-boot=2Eitb) of OpenSBI and U-Boot Main=2E
>+
>+    Note: Debug UART is not available from U-Boot SPL when U-Boot Main u=
ses the
>+    SBI interface for this=2E Add the following configuration changes ab=
ove to

Please, mention that the SBI based debug UART is enabled by default=2E



>+    enable early debug UART in U-Boot SPL::
>+
>+        u-boot=2Egit/scripts/config --file u-boot/=2Econfig \
>+         --set-val DEBUG_UART_BASE 0x10000000 \
>+         --set-val DEBUG_UART_CLOCK 24000000 \
>+         --enable DEBUG_UART_NS16550 \
>+         --disable DEBUG_SBI_CONSOLE \
>+         --set-val SPL_DEBUG_UART_BASE 0x10000000 \
>+         --set-val DEBUG_UART_SHIFT 2
>+
>+        make -C u-boot=2Egit -O u-boot olddefconfig

Just mention the Kconfig values=2E `make menuconfig` is the sane way to ed=
it the configuration=2E

>+
>+Boot description
>+----------------
>+
>+JH-7110 reset vectors (one 36-bit address per each of four U7 cores) are=
 located
>+split into four pairs of SYS SYSCON registers=2E The default value for a=
ll four

What does SYS SYSCON allude to?

>+reset vectors is 2a000000=2E

Which registers?

>+
>+Execute-in-place BootROM code located at 2a000000 is not published by St=
arFive
>+however may be generally described as deciding based on [RGPIO2:RGPIO0] =
state
>+where to transfer SPL data from, verify headers and CRC, and then jump t=
o code
>+execution in L2 LIM=2E
>+
>+Zero Stage Program Loader
>+^^^^^^^^^^^^^^^^^^^^^^^^^
>+
>+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>+RGPIO2 Boot Vector ZSPL function
>+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>+0      0x2A00_0000 On-chip 32KB BootROM
>+1      0x2100_0000 QSPI XIP Flash (256mb)
>+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>+
>+JH-7110 ZSPL functionally consists of the selection of reset vector regi=
ster
>+defaults at chip-design time in concert with BootROM code at 2a000000=2E=
 `JH-7110
>+Technical Reference Manual`_ says "if XIP flash is disabled in OTP
>+configuration, system cannot boot from XIP flash"=2E Presumably there is=
 some OTP
>+configuration involved but there is no documentation available with whic=
h to
>+expand on that topic=2E
>+
>+Zero Stage BootLoader
>+^^^^^^^^^^^^^^^^^^^^^
>+
>+JH-7110 ZSBL is typically StarFive loader code in BootROM selected by RG=
PIO2
>+pull-down=2E
>+
>+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>+RGPIO1 RGPIO0 StarFive loader function @ 0x2A00_0000
>+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>+0      0      1-bit QSPI Flash offset 0x0
>+0      1      SDIO3=2E0 *(deprecated)*

SD-card would be better comprehensible=2E

>+1      0      eMMC5=2E0 *(deprecated)*
>+1      1      UART Serial XMODEM loader
>+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>+
>+According to `JH-7110 Boot User Guide BootROM`_ the StarFive loader code=
 reads
>+content to SRAM @ 0x0800_0000 from different media selected by [RGPIO1,R=
GPIO0]=2E
>+
>+`Description of StarFive loader`_ by the StarFive VisionFive2 board main=
tainer:
>+
>+    The SD card boot mode is supported but the mmc driver of BootROM is =
not

of the

>+    compatible with a few SD cards=2E If you can't boot from a SD card, =
you can
>+    change another card for a try=2E
>+
>+    The eMMC boot mode loads SPL from sector 0, while the SD card boot m=
ode
>+    loads GPT header from sector 1 and then finds the partition whose GU=
ID is

loads the

>+    2E54B353-1271-4842-806F-E436D6AF6985 to load SPL=2E So if we try to =
use GPT
>+    partition in eMMC, it will fail to boot and report CRC (stored at 0x=
290)
>+    failure=2E The workaround is using the backup load address=2E After =
the CRC
>+    failure happens, it will try to load the SPL from the backup address
>+    (stored at 0x4~0x7)=2E That is why we write 0x00100000 to 0x4~0x7=2E=
 But this

This value is not fixed=2E The backup location can be freely chosen=2E


>+    workaround is not a standard process and may destroy the partition
>+    information stored in sector 0=2E
>+
>+There are additional unexplained GUID references in the JH-7110 MaskROM =
so the
>+description given is not complete=2E Attribution and modifications to th=
e GPL2=2E0+
>+source code used in StarFive loader have not been published as of this w=
riting=2E
>+Due to the lack of verifiable documentation the upstream Linux devicetre=
e does
>+not contain hints for mmc0 and mmc1 interfaces to be included in U-Boot =
SPL=2E As
>+of U-Boot release v2025=2E10 and newer the U-Boot specific devicetree ov=
erride of
>+hints for mmc0 and mmc1 interfaces that are required for the deprecated =
modes
>+have been dropped marking the deprecation of these boot modes in U-Boot=
=2E

Do you mean upstream  U-Boot will fail to boot from SD-card, which is the =
Ubuntu default?

This would need to be fixed urgently=2E=20

>+
>+Supported modes in U-Boot SPL are QSPI Flash and UART Serial XMODEM load=
er as
>+accepted by upstream Linux Kernel for StarFive JH-7110 common devicetree=
=2E
>+
>+First Stage BootLoader
>+^^^^^^^^^^^^^^^^^^^^^^
>+
>+JH-7110 FSBL is typically U-Boot SPL or any vendor flash programming too=
l=2E
>+
>+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>+RGPIO1 RGPIO0 U-Boot SPL function
>+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>+0      0      BOOT_DEVICE_SPI @ offset 0x100000 (CONFIG_ENV_OFFSET + CON=
FIG_ENV_SIZE)
>+0      1      BOOT_DEVICE_MMC2 @ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTIT=
ION
>+1      0      BOOT_DEVICE_MMC1 @ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTIT=
ION
>+1      1      BOOT_DEVICE_UART @ YMODEM
>+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+U-Boot SPL initializes DRAM and configures PLLs needed by CPU and periph=
erals=2E
>+U-Boot SPL function is selected by configuration of [RGPIO1:RGPIO0] then=
 copies
>+data to the start of DRAM and executes=2E
>+
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+Address     Description
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+0x040000000 start of DRAM
>+0x240000000 uncached alias of DRAM
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+Note: The largest DRAM size with JH7110 is 8GB because the uncached alia=
s of
>+DRAM begins at +8GB following the start of DRAM=2E
>+
>+Second Stage BootLoader (OpenSBI fw_dynamic=2Ebin + U-Boot Main)
>+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>+
>+U-Boot Main is supported in S-mode and depends on prior stage M-mode SBI=
 runtime
>+services provided by OpenSBI FW_DYNAMIC firmware=2E
>+
>+Loading U-Boot
>+--------------
>+
>+Vendored versions of U-Boot (as pre-installed on supported boards) are g=
enerally
>+capable in U-Boot console of UART data transfer and updating QSPI Flash=
=2E
>+Additionally there may be a vendor Board Support Package using the depre=
cated
>+SDIO3=2E0 / eMMC5=2E0 boot modes=2E It is not documented here how to upd=
ate U-Boot in
>+vendor BSP data images, nor use of the deprecated boot modes=2E The reco=
mmended
>+upgrade path is to update QSPI Flash in U-Boot console or from GNU/Linux=
 OS=2E
>+
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>+Flash offset Length                       Data source
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>+0x000000     0x0f0000 (CONFIG_ENV_OFFSET) u-boot/spl/u-boot-spl=2Ebin=2E=
normal=2Eout
>+0x0f0000     0x010000 (CONFIG_ENV_SIZE)   runtime generated defaults if =
bad CRC
>+0x100000     0xf00000                     u-boot/u-boot=2Eitb
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>+
>+Recovery U-Boot console
>+^^^^^^^^^^^^^^^^^^^^^^^
>+
>+With UART serial USB adapter and tio serial terminal::

The description below makes no sense to me=2E

For recovery you would just use U-Boot=2E There is no need for any recover=
y binary=2E

Best regards=20

Heinrich

>+
>+    tio /dev/ttyUSB0 -o 1
>+        tio 3=2E9
>+        Press ctrl-t q to quit
>+        Connected to /dev/ttyUSB0
>+
>+    # Power on the board with [RGPIO1:RGPI0]=3D3
>+        (C)StarFive
>+        CC
>+        (C)StarFive
>+        CCC
>+
>+    (Control-t-x)
>+        Please enter which X modem protocol to use:
>+         (0) XMODEM-1K send
>+         (1) XMODEM-CRC send
>+         (2) XMODEM-CRC receive
>+
>+    0
>+        Send file with XMODEM-1K
>+        Enter file name:
>+
>+    u-boot/spl/u-boot-spl=2Ebin=2Enormal=2Eout
>+        Sending file 'u-boot/spl/u-boot-spl=2Ebin=2Enormal=2Eout'
>+        Press any key to abort transfer
>+        =2E=2E=2E|
>+        Done
>+
>+    # U-Boot SPL on the board with [RGPIO1:RGPI0]=3D3
>+        U-Boot SPL 2025=2E10 (Oct 23 2025 - 17:01:49 -0700)
>+        DDR version: dc2e84f0=2E
>+        Trying to boot from UART
>+        CCC
>+
>+    (Control-t-y)
>+        Send file with YMODEM
>+        Enter file name:
>+
>+    u-boot/u-boot=2Eitb
>+        Sending file 'u-boot/u-boot=2Eitb'
>+        Press any key to abort transfer
>+        =2E=2E=2E|
>+        Done
>+        Loaded 3122637 bytes
>+
>+        OpenSBI v1=2E7
>+           ____                    _____ ____ _____
>+          / __ \                  / ____|  _ \_   _|
>+         | |  | |_ __   ___ _ __ | (___ | |_) || |
>+         | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
>+         | |__| | |_) |  __/ | | |____) | |_) || |_
>+          \____/| =2E__/ \___|_| |_|_____/|____/_____|
>+                | |
>+                |_|
>+
>+        Platform Name               : Pine64 Star64
>+        Platform Features           : medeleg
>+        Platform HART Count         : 4
>+        Platform IPI Device         : aclint-mswi
>+        Platform Timer Device       : aclint-mtimer @ 4000000Hz
>+        Platform Console Device     : uart8250
>+        Platform HSM Device         : ---
>+        Platform PMU Device         : ---
>+        Platform Reboot Device      : pm-reset
>+        Platform Shutdown Device    : pm-reset
>+        Platform Suspend Device     : ---
>+        Platform CPPC Device        : ---
>+        Firmware Base               : 0x40000000
>+        Firmware Size               : 353 KB
>+        Firmware RW Offset          : 0x40000
>+        Firmware RW Size            : 97 KB
>+        Firmware Heap Offset        : 0x4c000
>+        Firmware Heap Size          : 49 KB (total), 3 KB (reserved), 12=
 KB (used), 33 KB (free)
>+        Firmware Scratch Size       : 4096 B (total), 400 B (used), 3696=
 B (free)
>+        Runtime SBI Version         : 3=2E0
>+        Standard SBI Extensions     : time,rfnc,ipi,base,hsm,srst,pmu,db=
cn,fwft,legacy,dbtr,sse
>+        Experimental SBI Extensions : none
>+
>+        Domain0 Name                : root
>+        Domain0 Boot HART           : 4
>+        Domain0 HARTs               : 1*,2*,3*,4*
>+        Domain0 Region00            : 0x0000000010000000-0x0000000010000=
fff M: (I,R,W) S/U: (R,W)
>+        Domain0 Region01            : 0x0000000002000000-0x000000000200f=
fff M: (I,R,W) S/U: ()
>+        Domain0 Region02            : 0x0000000040040000-0x000000004005f=
fff M: (R,W) S/U: ()
>+        Domain0 Region03            : 0x0000000040000000-0x000000004003f=
fff M: (R,X) S/U: ()
>+        Domain0 Region04            : 0x000000000c000000-0x000000000ffff=
fff M: (I,R,W) S/U: (R,W)
>+        Domain0 Region05            : 0x0000000000000000-0xfffffffffffff=
fff M: () S/U: (R,W,X)
>+        Domain0 Next Address        : 0x0000000040200000
>+        Domain0 Next Arg1           : 0x0000000042200000
>+        Domain0 Next Mode           : S-mode
>+        Domain0 SysReset            : yes
>+        Domain0 SysSuspend          : yes
>+
>+        Boot HART ID                : 4
>+        Boot HART Domain            : root
>+        Boot HART Priv Version      : v1=2E11
>+        Boot HART Base ISA          : rv64imafdcbx
>+        Boot HART ISA Extensions    : zihpm,sdtrig
>+        Boot HART PMP Count         : 8
>+        Boot HART PMP Granularity   : 12 bits
>+        Boot HART PMP Address Bits  : 34
>+        Boot HART MHPM Info         : 2 (0x00000018)
>+        Boot HART Debug Triggers    : 8 triggers
>+        Boot HART MIDELEG           : 0x0000000000000222
>+        Boot HART MEDELEG           : 0x000000000000b109
>+
>+
>+        U-Boot 2025=2E10 (Oct 23 2025 - 17:01:49 -0700)
>+
>+        CPU:   sifive,u74-mc
>+        Model: Pine64 Star64
>+        DRAM:  4 GiB
>+        Core:  160 devices, 29 uclasses, devicetree: board
>+        WDT:   Not starting watchdog@13070000
>+        MMC:   mmc@16010000: 0, mmc@16020000: 1
>+        Loading Environment from SPIFlash=2E=2E=2E
>+        SF: Detected gd25lq128 with page size 256 Bytes, erase size 4 Ki=
B, total 16 MiB
>+        *** Warning - bad CRC, using default environment
>+
>+        StarFive EEPROM format v2
>+
>+        --------EEPROM INFO--------
>+        Vendor : PINE64
>+        Product full SN: STAR64V1-2310-D004E000-0000xxxx
>+        data version: 0x2
>+        PCB revision: 0xc1
>+        BOM revision: A
>+        Ethernet MAC0 address: 6c:cf:39:00:xx:xx
>+        Ethernet MAC1 address: 6c:cf:39:00:xx:xx
>+        --------EEPROM INFO--------
>+
>+        starfive_7110_pcie pcie@9c0000000: Starfive PCIe bus probed=2E
>+        In:    serial@10000000
>+        Out:   serial@10000000
>+        Err:   serial@10000000
>+        Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
>+        starting USB=2E=2E=2E
>+        Register 2000820 NbrPorts 2
>+        Starting the controller
>+        USB XHCI 1=2E00
>+        Bus usb@0: 4 USB Device(s) found
>+               scanning usb for storage devices=2E=2E=2E 0 Storage Devic=
e(s) found
>+        Working FDT set to ff717fe0
>+        Hit any key to stop autoboot: 2 1 0
>+
>+    (enter)
>+        StarFive #
>+
>+Update QSPI Flash using U-Boot console
>+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>+
>+With UART serial USB adapter and tio serial terminal::
>+
>+    tio /dev/ttyUSB0 -o 1
>+        tio 3=2E9
>+        Press ctrl-t q to quit
>+        Connected to /dev/ttyUSB0
>+
>+    (enter)
>+        StarFive #
>=20
>     sf probe
>-    load mmc 1:1 $kernel_addr_r u-boot-spl=2Ebin=2Enormal=2Eout
>-    sf update $kernel_addr_r 0 $filesize
>-    load mmc 1:1 $kernel_addr_r u-boot=2Eitb
>-    sf update $kernel_addr_r 0x100000 $filesize
>+        StarFive # sf probe
>+        SF: Detected gd25lq128 with page size 256 Bytes, erase size 4 Ki=
B, total 16 MiB
>=20
>-For loading the files from a TFTP server refer to the dhcp and tftpboot
>-commands=2E
>+    loady && sf update $loadaddr 0 $filesize
>+        StarFive # loady && sf update $loadaddr 0 $filesize
>+        ## Ready for binary (ymodem) download to 0x82000000 at 115200 bp=
s=2E=2E=2E
>+        CCC
>=20
>-After updating U-Boot you may want to erase a saved environment and rebo=
ot=2E
>+    (Control-t-y)
>+        Send file with YMODEM
>+        Enter file name:
>=20
>-=2E=2E code-block:: console
>+    u-boot/spl/u-boot-spl=2Ebin=2Enormal=2Eout
>+        Sending file 'u-boot/spl/u-boot-spl=2Ebin=2Enormal=2Eout'
>+        Press any key to abort transfer
>+        =2E=2E=2E|
>+        Done
>+        ## Total Size      =3D 0x00024eb7 =3D 151223 Bytes
>+        ## Start Addr      =3D 0x82000000
>+        device 0 offset 0x0, size 0x24eb7
>+        151223 bytes written, 0 bytes skipped in 0=2E634s, speed 243096 =
B/s
>+        StarFive #
>=20
>     env erase
>-    reset
>-
>-Booting from SD-Card
>---------------------
>-
>-The device boot ROM loads U-Boot SPL (u-boot-spl=2Ebin=2Enormal=2Eout) f=
rom the
>-partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985=2E You are=
 free
>-to choose any partition number=2E
>-
>-With the default configuration U-Boot SPL loads the U-Boot FIT image
>-(u-boot=2Eitb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTIT=
ION=3D0x2)=2E
>-When formatting it is recommended to use GUID
>-BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition=2E
>-
>-Booting from eMMC
>------------------
>-
>-The device boot ROM tries to load U-Boot SPL (u-boot-spl=2Ebin=2Enormal=
=2Eout) from
>-sector 0 of the eMMC's main hardware partition=2E But this conflicts wit=
h GPT
>-partitioning=2E Fortunately eMMC can alternatively load U-Boot SPL from =
a backup
>-position=2E
>-
>-For U-Boot SPL (u-boot-spl=2Ebin=2Enormal=2Eout) starting at sector 2048=
 (position
>-0x100000) write the following bytes to the eMMC device after GPT partiti=
oning:
>-
>-=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>-Address Bytes
>-=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>-0x0000  40 02 00 00  00 00 10 00
>-0x0290  40 02 00 00  00 00 10 00
>-=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>-
>-With the default configuration U-Boot SPL loads the U-Boot FIT image
>-(u-boot=2Eitb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTIT=
ION=3D0x2)=2E
>-When formatting it is recommended to use GUID
>-BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition=2E
>-
>-Booting from UART
>------------------
>-
>-The boot ROM supports the X-modem protocol to upload
>-spl/u-boot-spl=2Ebin=2Enormal=2Eout=2E U-Boot SPL support loading the FI=
T image
>-u-boot=2Eitb via the Y-modem protocol=2E
>-
>-Due to restrictions of the boot ROM not all X-modem implementations are
>-compatible=2E The package tio (https://github=2Ecom/tio/tio) has been fo=
und to be
>-usable=2E
>-
>-Debug UART
>-----------
>-
>-By default the SBI interface is used for the debug UART=2E But this only=
 works
>-in main U-Boot=2E To enable the debug UART in SPL, too, use the followin=
g
>-settings::
>-
>-    CONFIG_DEBUG_UART=3Dy
>-    CONFIG_DEBUG_UART_NS16550=3Dy
>-    CONFIG_DEBUG_UART_BASE=3D0x10000000
>-    CONFIG_SPL_DEBUG_UART_BASE=3D0x10000000
>-    CONFIG_DEBUG_UART_CLOCK=3D24000000
>-    CONFIG_DEBUG_UART_SHIFT=3D2
>+        StarFive # env erase
>+        Erasing Environment on SPIFlash=2E=2E=2E OK
>+        StarFive #
>+
>+    loady && sf update $loadaddr 100000 $filesize
>+        StarFive # loady $loadaddr && sf update $loadaddr 100000 $filesi=
ze
>+        ## Ready for binary (ymodem) download to 0x82000000 at 115200 bp=
s=2E=2E=2E
>+        CCC
>+
>+    (Control-t-y)
>+        Send file with YMODEM
>+        Enter file name:
>+
>+    u-boot/u-boot=2Eitb
>+        Sending file 'u-boot/u-boot=2Eitb'
>+        Press any key to abort transfer
>+        =2E=2E=2E|
>+        Done
>+        ## Total Size      =3D 0x002fa5cd =3D 3122637 Bytes
>+        ## Start Addr      =3D 0x82000000
>+        device 0 offset 0x100000, size 0x2fa5cd
>+        3122637 bytes written, 0 bytes skipped in 18=2E137s, speed 17627=
2 B/s
>+        StarFive #
>+
>+Update QSPI Flash from GNU/Linux OS
>+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>+
>+With mtd-utils::
>+
>+    cat /proc/mtd
>+        dev:    size   erasesize  name
>+        mtd0: 000f0000 00001000 "spl"
>+        mtd1: 00010000 00001000 "uboot-env"
>+        mtd2: 00f00000 00001000 "uboot"
>+
>+    flashcp --verbose u-boot/spl/u-boot-spl=2Ebin=2Enormal=2Eout /dev/mt=
d0
>+        Erasing blocks: 37/37 (100%)
>+        Writing data: 147k/147k (100%)
>+        Verifying data: 147k/147k (100%)
>+
>+    flashcp --verbose --erase-all /dev/zero /dev/mtd1
>+        Erasing blocks: 16/16 (100%)
>+        Writing data: 0k/0k (100%)
>+        Verifying data: 0k/0k (100%)
>+
>+    flashcp --verbose u-boot/u-boot=2Eitb /dev/mtd2
>+        Erasing blocks: 763/763 (100%)
>+        Writing data: 3049k/3049k (100%)
>+        Verifying data: 3049k/3049k (100%)
>diff --git a/doc/board/starfive/milk-v_mars=2Erst b/doc/board/starfive/mi=
lk-v_mars=2Erst
>index ce4539a46f1=2E=2E0dbc500b734 100644
>--- a/doc/board/starfive/milk-v_mars=2Erst
>+++ b/doc/board/starfive/milk-v_mars=2Erst
>@@ -7,38 +7,6 @@ U-Boot for the Milk-V Mars uses the same U-Boot binaries=
 as the VisionFive 2
> board=2E In U-Boot SPL the actual board is detected and the device-tree =
patched
> accordingly=2E
>=20
>-Building
>---------
>-
>-1=2E Add the RISC-V toolchain to your PATH=2E
>-2=2E Setup ARCH & cross compilation environment variable:
>-
>-=2E=2E code-block:: none
>-
>-   export CROSS_COMPILE=3D<riscv64 toolchain prefix>
>-
>-The M-mode software OpenSBI provides the supervisor binary interface (SB=
I) and
>-is responsible for the switch to S-Mode=2E It is a prerequisite to build=
 U-Boot=2E
>-Support for the JH7110 was introduced in OpenSBI 1=2E2=2E It is recommen=
ded to use
>-a current release=2E
>-
>-=2E=2E code-block:: console
>-
>-	git clone https://github=2Ecom/riscv/opensbi=2Egit
>-	cd opensbi
>-	make PLATFORM=3Dgeneric FW_TEXT_START=3D0x40000000 FW_OPTIONS=3D0
>-
>-Now build the U-Boot SPL and U-Boot proper=2E
>-
>-=2E=2E code-block:: console
>-
>-	cd <U-Boot-dir>
>-	make starfive_visionfive2_defconfig
>-	make OPENSBI=3D$(opensbi_dir)/build/platform/generic/firmware/fw_dynami=
c=2Ebin
>-
>-This will generate the U-Boot SPL image (spl/u-boot-spl=2Ebin=2Enormal=
=2Eout) as well
>-as the FIT image (u-boot=2Eitb) with OpenSBI and U-Boot=2E
>-
> Device-tree selection
> ---------------------
>=20
>@@ -57,45 +25,4 @@ environment
> or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set=
 to
> provide a default value=2E
>=20
>-Preparing the SD-Card
>----------------------
>-
>-The device firmware loads U-Boot SPL (u-boot-spl=2Ebin=2Enormal=2Eout) f=
rom the
>-partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985=2E You are=
 free
>-to choose any partition number=2E
>-
>-With the default configuration U-Boot SPL loads the U-Boot FIT image
>-(u-boot=2Eitb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTIT=
ION=3D0x2)=2E
>-When formatting it is recommended to use GUID
>-BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition=2E
>-
>-The FIT image (u-boot=2Eitb) is a combination of OpenSBI's fw_dynamic=2E=
bin,
>-u-boot-nodtb=2Ebin and the device tree blob=2E
>-
>-Format the SD card (make sure the disk has GPT, otherwise use gdisk to s=
witch)
>-
>-=2E=2E code-block:: bash
>-
>-	sudo sgdisk --clear \
>-	  --set-alignment=3D2 \
>-	  --new=3D1:4096:8191 --change-name=3D1:spl --typecode=3D1:2E54B353-127=
1-4842-806F-E436D6AF6985\
>-	  --new=3D2:8192:16383 --change-name=3D2:uboot --typecode=3D2:BC13C2FF-=
59E6-4262-A352-B275FD6F7172  \
>-	  --new=3D3:16384:1654784 --change-name=3D3:system --typecode=3D3:EBD0A=
0A2-B9E5-4433-87C0-68B6B72699C7 \
>-	  /dev/sdb
>-
>-Copy U-Boot to the SD card
>-
>-=2E=2E code-block:: bash
>-
>-	sudo dd if=3Du-boot-spl=2Ebin=2Enormal=2Eout of=3D/dev/sdb1
>-	sudo dd if=3Du-boot=2Eitb of=3D/dev/sdb2
>-
>-	sudo mount /dev/sdb3 /mnt/
>-	sudo cp u-boot-spl=2Ebin=2Enormal=2Eout /mnt/
>-	sudo cp u-boot=2Eitb /mnt/
>-	sudo cp Image=2Egz /mnt/
>-	sudo cp initramfs=2Ecpio=2Egz /mnt/
>-	sudo cp jh7110-starfive-visionfive-2=2Edtb /mnt/
>-	sudo umount /mnt
>-
> =2E=2E include:: jh7110_common=2Erst
>diff --git a/doc/board/starfive/pine64_star64=2Erst b/doc/board/starfive/=
pine64_star64=2Erst
>index d1752c452da=2E=2E78a330be455 100644
>--- a/doc/board/starfive/pine64_star64=2Erst
>+++ b/doc/board/starfive/pine64_star64=2Erst
>@@ -7,38 +7,6 @@ U-Boot for the Star64 uses the same U-Boot binaries as t=
he VisionFive 2 board=2E
> In U-Boot SPL the actual board is detected and the device-tree patched
> accordingly=2E
>=20
>-Building
>---------
>-
>-1=2E Add the RISC-V toolchain to your PATH=2E
>-2=2E Setup ARCH & cross compilation environment variable:
>-
>-=2E=2E code-block:: none
>-
>-   export CROSS_COMPILE=3D<riscv64 toolchain prefix>
>-
>-The M-mode software OpenSBI provides the supervisor binary interface (SB=
I) and
>-is responsible for the switch to S-Mode=2E It is a prerequisite to build=
 U-Boot=2E
>-Support for the JH7110 was introduced in OpenSBI 1=2E2=2E It is recommen=
ded to use
>-a current release=2E
>-
>-=2E=2E code-block:: console
>-
>-	git clone https://github=2Ecom/riscv/opensbi=2Egit
>-	cd opensbi
>-	make PLATFORM=3Dgeneric FW_TEXT_START=3D0x40000000
>-
>-Now build the U-Boot SPL and U-Boot proper=2E
>-
>-=2E=2E code-block:: console
>-
>-	cd <U-Boot-dir>
>-	make starfive_visionfive2_defconfig
>-	make OPENSBI=3D$(opensbi_dir)/build/platform/generic/firmware/fw_dynami=
c=2Ebin
>-
>-This will generate the U-Boot SPL image (spl/u-boot-spl=2Ebin=2Enormal=
=2Eout) as well
>-as the FIT image (u-boot=2Eitb) with OpenSBI and U-Boot=2E
>-
> Device-tree selection
> ---------------------
>=20
>@@ -55,49 +23,6 @@ environment
> or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set=
 to
> provide a default value=2E
>=20
>-Preparing the SD-Card
>----------------------
>-
>-The device firmware loads U-Boot SPL (u-boot-spl=2Ebin=2Enormal=2Eout) f=
rom the
>-partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985=2E You are=
 free
>-to choose any partition number=2E
>-
>-With the default configuration U-Boot SPL loads the U-Boot FIT image
>-(u-boot=2Eitb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTIT=
ION=3D0x2)=2E
>-When formatting it is recommended to use GUID
>-BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition=2E
>-
>-The FIT image (u-boot=2Eitb) is a combination of OpenSBI's fw_dynamic=2E=
bin,
>-u-boot-nodtb=2Ebin and the device tree blob=2E
>-
>-Format the SD card (make sure the disk has GPT, otherwise use gdisk to s=
witch)
>-
>-=2E=2E code-block:: bash
>-
>-	sudo sgdisk --clear \
>-	  --set-alignment=3D2 \
>-	  --new=3D1:4096:8191 --change-name=3D1:spl --typecode=3D1:2E54B353-127=
1-4842-806F-E436D6AF6985\
>-	  --new=3D2:8192:16383 --change-name=3D2:uboot --typecode=3D2:BC13C2FF-=
59E6-4262-A352-B275FD6F7172  \
>-	  --new=3D3:16384:1654784 --change-name=3D3:system --typecode=3D3:EBD0A=
0A2-B9E5-4433-87C0-68B6B72699C7 \
>-	  /dev/sdb
>-
>-Copy U-Boot to the SD card
>-
>-=2E=2E code-block:: bash
>-
>-	sudo dd if=3Du-boot-spl=2Ebin=2Enormal=2Eout of=3D/dev/sdb1
>-	sudo dd if=3Du-boot=2Eitb of=3D/dev/sdb2
>-
>-	sudo mount /dev/sdb3 /mnt/
>-	sudo cp u-boot-spl=2Ebin=2Enormal=2Eout /mnt/
>-	sudo cp u-boot=2Eitb /mnt/
>-	sudo cp Image=2Egz /mnt/
>-	sudo cp initramfs=2Ecpio=2Egz /mnt/
>-	sudo cp jh7110-starfive-visionfive-2=2Edtb /mnt/
>-	sudo umount /mnt
>-
>-=2E=2E include:: jh7110_common=2Erst
>-
> Serial Number and MAC address issues
> ------------------------------------
>=20
>@@ -183,3 +108,5 @@ The MAC addresses may be "set" as follows by writing =
as a custom config to SPI
> 	env set eth1addr 6c:cf:39:ce:64:5a
> 	env save
> 	reset
>+
>+=2E=2E include:: jh7110_common=2Erst
>diff --git a/doc/board/starfive/visionfive2=2Erst b/doc/board/starfive/vi=
sionfive2=2Erst
>index 11121a1751a=2E=2Ec92ea16f91b 100644
>--- a/doc/board/starfive/visionfive2=2Erst
>+++ b/doc/board/starfive/visionfive2=2Erst
>@@ -3,74 +3,9 @@
> StarFive VisionFive2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>-JH7110 RISC-V SoC
>------------------
>-
>-The JH7110 is 4+1 64-bit RISC-V SoC from StarFive=2E
>-
> The StarFive VisionFive2 development platform is based on JH7110 and cap=
able
> of running Linux=2E
>=20
>-Mainline support
>-----------------
>-
>-The support for following drivers are already enabled:
>-
>-1=2E ns16550 UART Driver=2E
>-2=2E StarFive JH7110 clock Driver=2E
>-3=2E StarFive JH7110 reset Driver=2E
>-4=2E Cadence QSPI controller Driver=2E
>-5=2E MMC SPI Driver for MMC/SD support=2E
>-6=2E PLDA PCIE controller driver=2E
>-7=2E On-board VL805 PCIE-USB controller driver=2E
>-
>-Booting from MMC using U-Boot SPL
>----------------------------------
>-
>-The current U-Boot port is supported in S-mode only and loaded from DRAM=
=2E
>-
>-A prior stage M-mode firmware/bootloader (e=2Eg OpenSBI) is required to
>-boot the u-boot=2Eitb in S-mode and provide M-mode runtime services=2E
>-
>-Currently, the u-boot=2Eitb is used as a dynamic of the OpenSBI FW_DYNAM=
IC
>-firmware with the latest=2E
>-
>-Building
>---------
>-
>-1=2E Add the RISC-V toolchain to your PATH=2E
>-2=2E Setup ARCH & cross compilation environment variable:
>-
>-=2E=2E code-block:: none
>-
>-   export CROSS_COMPILE=3D<riscv64 toolchain prefix>
>-
>-Before building U-Boot SPL, OpenSBI must be built first=2E OpenSBI can b=
e
>-cloned and built for JH7110 as below:
>-
>-=2E=2E code-block:: console
>-
>-	git clone https://github=2Ecom/riscv/opensbi=2Egit
>-	cd opensbi
>-	make PLATFORM=3Dgeneric FW_TEXT_START=3D0x40000000 FW_OPTIONS=3D0
>-
>-The VisionFive 2 support for OpenSBI was introduced after the v1=2E2 rel=
ease=2E
>-
>-More detailed description of steps required to build FW_DYNAMIC firmware
>-is beyond the scope of this document=2E Please refer OpenSBI documenatio=
n=2E
>-(Note: OpenSBI git repo is at https://github=2Ecom/riscv/opensbi=2Egit)
>-
>-Now build the U-Boot SPL and U-Boot proper
>-
>-=2E=2E code-block:: console
>-
>-	cd <U-Boot-dir>
>-	make starfive_visionfive2_defconfig
>-	make OPENSBI=3D$(opensbi_dir)/opensbi/build/platform/generic/firmware/f=
w_dynamic=2Ebin
>-
>-This will generate the U-Boot SPL image (spl/u-boot-spl=2Ebin=2Enormal=
=2Eout) as well
>-as the FIT image (u-boot=2Eitb) with OpenSBI and U-Boot=2E
>-
> Device-tree selection
> ---------------------
>=20
>@@ -89,388 +24,4 @@ environment
> or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to pro=
vide
> a default value=2E
>=20
>-Flashing
>---------
>-
>-The device firmware loads U-Boot SPL (u-boot-spl=2Ebin=2Enormal=2Eout) f=
rom the
>-partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985=2E You are=
 free
>-to choose any partition number=2E
>-
>-With the default configuration U-Boot SPL loads the U-Boot FIT image
>-(u-boot=2Eitb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTIT=
ION=3D0x2)=2E
>-When formatting it is recommended to use GUID
>-BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition=2E
>-
>-The FIT image (u-boot=2Eitb) is a combination of OpenSBI's fw_dynamic=2E=
bin,
>-u-boot-nodtb=2Ebin and the device tree blob
>-(jh7110-starfive-visionfive-2-v1=2E3b=2Edtb or
>-jh7110-starfive-visionfive-2-v1=2E2a=2Edtb)=2E
>-
>-Format the SD card (make sure the disk has GPT, otherwise use gdisk to s=
witch)
>-
>-=2E=2E code-block:: bash
>-
>-	sudo sgdisk --clear \
>-	  --set-alignment=3D2 \
>-	  --new=3D1:4096:8191 --change-name=3D1:spl --typecode=3D1:2E54B353-127=
1-4842-806F-E436D6AF6985\
>-	  --new=3D2:8192:16383 --change-name=3D2:uboot --typecode=3D2:BC13C2FF-=
59E6-4262-A352-B275FD6F7172  \
>-	  --new=3D3:16384:1654784 --change-name=3D3:system --typecode=3D3:EBD0A=
0A2-B9E5-4433-87C0-68B6B72699C7 \
>-	  /dev/sdb
>-	sudo mkfs=2Evfat -F32 /dev/sdb3
>-
>-Program the SD card
>-
>-=2E=2E code-block:: bash
>-
>-	sudo dd if=3Du-boot-spl=2Ebin=2Enormal=2Eout of=3D/dev/sdb1
>-	sudo dd if=3Du-boot=2Eitb of=3D/dev/sdb2
>-
>-	sudo mount /dev/sdb3 /mnt/
>-	sudo cp u-boot-spl=2Ebin=2Enormal=2Eout /mnt/
>-	sudo cp u-boot=2Eitb /mnt/
>-	sudo cp Image=2Egz /mnt/
>-	sudo cp initramfs=2Ecpio=2Egz /mnt/
>-	sudo cp jh7110-starfive-visionfive-2=2Edtb /mnt/
>-	sudo umount /mnt
>-
> =2E=2E include:: jh7110_common=2Erst
>-
>-Sample boot log from StarFive VisionFive2 board
>------------------------------------------------
>-
>-=2E=2E code-block:: none
>-
>-
>-	U-Boot SPL 2023=2E04-rc2-00055-gfc43b9c51a-dirty (Mar 02 2023 - 10:51:3=
9 +0800)
>-	DDR version: dc2e84f0=2E
>-	Trying to boot from MMC2
>-
>-	OpenSBI v1=2E2-80-g4b28afc
>-	  ____                    _____ ____ _____
>-	 / __ \                  / ____|  _ \_   _|
>-	| |  | |_ __   ___ _ __ | (___ | |_) || |
>-	| |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
>-	| |__| | |_) |  __/ | | |____) | |_) || |_
>-	 \____/| =2E__/ \___|_| |_|_____/|____/_____|
>-	       | |
>-	       |_|
>-
>-	Platform Name             : StarFive VisionFive 2 v1=2E3B
>-	Platform Features         : medeleg
>-	Platform HART Count       : 5
>-	Platform IPI Device       : aclint-mswi
>-	Platform Timer Device     : aclint-mtimer @ 4000000Hz
>-	Platform Console Device   : uart8250
>-	Platform HSM Device       : ---
>-	Platform PMU Device       : ---
>-	Platform Reboot Device    : ---
>-	Platform Shutdown Device  : ---
>-	Platform Suspend Device   : ---
>-	Firmware Base             : 0x40000000
>-	Firmware Size             : 264 KB
>-	Firmware RW Offset        : 0x20000
>-	Runtime SBI Version       : 1=2E0
>-
>-	Domain0 Name              : root
>-	Domain0 Boot HART         : 2
>-	Domain0 HARTs             : 0*,1*,2*,3*,4*
>-	Domain0 Region00          : 0x0000000002000000-0x000000000200ffff M: (I=
,R,W) S/U: ()
>-	Domain0 Region01          : 0x0000000040000000-0x000000004001ffff M: (R=
,X) S/U: ()
>-	Domain0 Region02          : 0x0000000040000000-0x000000004007ffff M: (R=
,W) S/U: ()
>-	Domain0 Region03          : 0x0000000000000000-0xffffffffffffffff M: (R=
,W,X) S/U: (R,W,X)
>-	Domain0 Next Address      : 0x0000000040200000
>-	Domain0 Next Arg1         : 0x0000000040287970
>-	Domain0 Next Mode         : S-mode
>-	Domain0 SysReset          : yes
>-	Domain0 SysSuspend        : yes
>-
>-	Boot HART ID              : 2
>-	Boot HART Domain          : root
>-	Boot HART Priv Version    : v1=2E11
>-	Boot HART Base ISA        : rv64imafdcbx
>-	Boot HART ISA Extensions  : none
>-	Boot HART PMP Count       : 8
>-	Boot HART PMP Granularity : 4096
>-	Boot HART PMP Address Bits: 34
>-	Boot HART MHPM Count      : 2
>-	Boot HART MIDELEG         : 0x0000000000000222
>-	Boot HART MEDELEG         : 0x000000000000b109
>-
>-
>-	U-Boot 2023=2E04-rc2-00055-gfc43b9c51a-dirty (Mar 02 2023 - 10:51:39 +0=
800)
>-
>-	CPU:   rv64imac_zba_zbb
>-	Model: StarFive VisionFive 2 v1=2E3B
>-	DRAM:  8 GiB
>-	Core:  107 devices, 18 uclasses, devicetree: separate
>-	MMC:   mmc@16010000: 0, mmc@16020000: 1
>-	Loading Environment from nowhere=2E=2E=2E OK
>-	In:    serial@10000000
>-	Out:   serial@10000000
>-	Err:   serial@10000000
>-	Net:   No ethernet found=2E
>-	Working FDT set to ff74a340
>-	Hit any key to stop autoboot:  0
>-	StarFive #
>-	StarFive # version
>-	U-Boot 2023=2E04-rc2-00055-gfc43b9c51a-dirty (Mar 02 2023 - 10:51:39 +0=
800)
>-
>-	riscv64-buildroot-linux-gnu-gcc=2Ebr_real (Buildroot VF2_515_v1=2E0=2E0=
_rc4) 10=2E3=2E0
>-	GNU ld (GNU Binutils) 2=2E36=2E1
>-	StarFive #
>-	StarFive # mmc dev 1
>-	switch to partitions #0, OK
>-	mmc1 is current device
>-	StarFive # mmc info
>-	Device: mmc@16020000
>-	Manufacturer ID: 9f
>-	OEM: 5449
>-	Name: SD64G
>-	Bus Speed: 50000000
>-	Mode: SD High Speed (50MHz)
>-	Rd Block Len: 512
>-	SD version 3=2E0
>-	High Capacity: Yes
>-	Capacity: 58=2E3 GiB
>-	Bus Width: 4-bit
>-	Erase Group Size: 512 Bytes
>-	StarFive #
>-	StarFive # mmc part
>-
>-	Partition Map for MMC device 1  --   Partition Type: EFI
>-
>-	Part    Start LBA       End LBA         Name
>-			Attributes
>-			Type GUID
>-			Partition GUID
>-	1     0x00001000      0x00001fff      "spl"
>-			attrs:  0x0000000000000000
>-			type:   2e54b353-1271-4842-806f-e436d6af6985
>-					(2e54b353-1271-4842-806f-e436d6af6985)
>-			guid:   d5ee2056-3020-475b-9a33-25b4257c9f12
>-	2     0x00002000      0x00003fff      "uboot"
>-			attrs:  0x0000000000000000
>-			type:   bc13c2ff-59e6-4262-a352-b275fd6f7172
>-					(bc13c2ff-59e6-4262-a352-b275fd6f7172)
>-			guid:   379ab7fe-fd0c-4149-b758-960c1cbfc0cc
>-	3     0x00004000      0x00194000      "system"
>-			attrs:  0x0000000000000000
>-			type:   ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
>-					(data)
>-			guid:   539a6df9-4655-4953-8541-733ca36eb1db
>-	StarFive #
>-	StarFive # fatls mmc 1:3
>-	6429424   Image=2Egz
>-	717705   u-boot=2Eitb
>-	125437   u-boot-spl=2Ebin=2Enormal=2Eout
>-	152848495   initramfs=2Ecpio=2Egz
>-		11285   jh7110-starfive-visionfive-2-v1=2E3b=2Edtb
>-
>-	5 file(s), 0 dir(s)
>-
>-	StarFive # fatload mmc 1:3 ${kernel_addr_r} Image=2Egz
>-	6429424 bytes read in 394 ms (15=2E6 MiB/s)
>-	StarFive # fatload mmc 1:3 ${fdt_addr_r} jh7110-starfive-visionfive-2=
=2Edtb
>-	11285 bytes read in 5 ms (2=2E2 MiB/s)
>-	StarFive # fatload mmc 1:3 ${ramdisk_addr_r} initramfs=2Ecpio=2Egz
>-	152848495 bytes read in 9271 ms (15=2E7 MiB/s)
>-	StarFive # booti ${kernel_addr_r} ${ramdisk_addr_r}:${filesize} ${fdt_a=
ddr_r}
>-	Uncompressing Kernel Image
>-	## Flattened Device Tree blob at 46000000
>-	Booting using the fdt blob at 0x46000000
>-	Working FDT set to 46000000
>-	Loading Ramdisk to f5579000, end fe73d86f =2E=2E=2E OK
>-	Loading Device Tree to 00000000f5573000, end 00000000f5578c14 =2E=2E=2E=
 OK
>-	Working FDT set to f5573000
>-
>-	Starting kernel =2E=2E=2E
>-
>-
>-	] Linux version 6=2E2=2E0-starfive-00026-g11934a315b67 (wyh@wyh-Virtual=
Box) (riscv64-linux-gnu-gcc (Ubuntu 7=2E5=2E0-3ubuntu1~18=2E04) 7=2E5=2E0, =
GNU ld (GNU Binutils for Ubuntu) 2=2E30) #1 SMP Thu Mar  2 14:51:36 CST 202=
3
>-	[    0=2E000000] OF: fdt: Ignoring memory range 0x40000000 - 0x40200000
>-	[    0=2E000000] Machine model: StarFive VisionFive 2 v1=2E3B
>-	[    0=2E000000] efi: UEFI not found=2E
>-	[    0=2E000000] Zone ranges:
>-	[    0=2E000000]   DMA32    [mem 0x0000000040200000-0x00000000ffffffff]
>-	[    0=2E000000]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
>-	[    0=2E000000] Movable zone start for each node
>-	[    0=2E000000] Early memory node ranges
>-	[    0=2E000000]   node   0: [mem 0x0000000040200000-0x000000013fffffff=
]
>-	[    0=2E000000] Initmem setup node 0 [mem 0x0000000040200000-0x0000000=
13fffffff]
>-	[    0=2E000000] On node 0, zone DMA32: 512 pages in unavailable ranges
>-	[    0=2E000000] SBI specification v1=2E0 detected
>-	[    0=2E000000] SBI implementation ID=3D0x1 Version=3D0x10002
>-	[    0=2E000000] SBI TIME extension detected
>-	[    0=2E000000] SBI IPI extension detected
>-	[    0=2E000000] SBI RFENCE extension detected
>-	[    0=2E000000] SBI HSM extension detected
>-	[    0=2E000000] CPU with hartid=3D0 is not available
>-	[    0=2E000000] CPU with hartid=3D0 is not available
>-	[    0=2E000000] CPU with hartid=3D0 is not available
>-	[    0=2E000000] riscv: base ISA extensions acdfim
>-	[    0=2E000000] riscv: ELF capabilities acdfim
>-	[    0=2E000000] percpu: Embedded 18 pages/cpu s35960 r8192 d29576 u737=
28
>-	[    0=2E000000] pcpu-alloc: s35960 r8192 d29576 u73728 alloc=3D18*4096
>-	[    0=2E000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
>-	[    0=2E000000] Built 1 zonelists, mobility grouping on=2E  Total page=
s: 1031688
>-	[    0=2E000000] Kernel command line: console=3DttyS0,115200 debug root=
wait earlycon=3Dsbi
>-	[    0=2E000000] Dentry cache hash table entries: 524288 (order: 10, 41=
94304 bytes, linear)
>-	[    0=2E000000] Inode-cache hash table entries: 262144 (order: 9, 2097=
152 bytes, linear)
>-	[    0=2E000000] mem auto-init: stack:off, heap alloc:off, heap free:of=
f
>-	[    0=2E000000] software IO TLB: area num 4=2E
>-	[    0=2E000000] software IO TLB: mapped [mem 0x00000000f1573000-0x0000=
0000f5573000] (64MB)
>-	[    0=2E000000] Virtual kernel memory layout:
>-	[    0=2E000000]       fixmap : 0xffffffc6fee00000 - 0xffffffc6ff000000=
   (2048 kB)
>-	[    0=2E000000]       pci io : 0xffffffc6ff000000 - 0xffffffc700000000=
   (  16 MB)
>-	[    0=2E000000]      vmemmap : 0xffffffc700000000 - 0xffffffc800000000=
   (4096 MB)
>-	[    0=2E000000]      vmalloc : 0xffffffc800000000 - 0xffffffd800000000=
   (  64 GB)
>-	[    0=2E000000]      modules : 0xffffffff0136a000 - 0xffffffff80000000=
   (2028 MB)
>-	[    0=2E000000]       lowmem : 0xffffffd800000000 - 0xffffffd8ffe00000=
   (4094 MB)
>-	[    0=2E000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff=
   (2047 MB)
>-	[    0=2E000000] Memory: 3867604K/4192256K available (8012K kernel code=
, 4919K rwdata, 4096K rodata, 2190K init, 476K bss, 324652K reserved, 0K cm=
a-reserved)
>-	[    0=2E000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=
=3D4, Nodes=3D1
>-	[    0=2E000000] rcu: Hierarchical RCU implementation=2E
>-	[    0=2E000000] rcu:     RCU restricting CPUs from NR_CPUS=3D64 to nr_=
cpu_ids=3D4=2E
>-	[    0=2E000000] rcu:     RCU debug extended QS entry/exit=2E
>-	[    0=2E000000]  Tracing variant of Tasks RCU enabled=2E
>-	[    0=2E000000] rcu: RCU calculated value of scheduler-enlistment dela=
y is 25 jiffies=2E
>-	[    0=2E000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_c=
pu_ids=3D4
>-	[    0=2E000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>-	[    0=2E000000] CPU with hartid=3D0 is not available
>-	[    0=2E000000] riscv-intc: unable to find hart id for /cpus/cpu@0/int=
errupt-controller
>-	[    0=2E000000] riscv-intc: 64 local interrupts mapped
>-	[    0=2E000000] plic: interrupt-controller@c000000: mapped 136 interru=
pts with 4 handlers for 9 contexts=2E
>-	[    0=2E000000] rcu: srcu_init: Setting srcu_struct sizes based on con=
tention=2E
>-	[    0=2E000000] riscv-timer: riscv_timer_init_dt: Registering clocksou=
rce cpuid [0] hartid [4]
>-	[    0=2E000000] clocksource: riscv_clocksource: mask: 0xffffffffffffff=
ff max_cycles: 0x1d854df40, max_idle_ns: 881590404240 ns
>-	[    0=2E000003] sched_clock: 64 bits at 4MHz, resolution 250ns, wraps =
every 2199023255500ns
>-	[    0=2E000437] Console: colour dummy device 80x25
>-	[    0=2E000568] Calibrating delay loop (skipped), value calculated usi=
ng timer frequency=2E=2E 8=2E00 BogoMIPS (lpj=3D16000)
>-	[    0=2E000602] pid_max: default: 32768 minimum: 301
>-	[    0=2E000752] LSM: initializing lsm=3Dcapability,integrity
>-	[    0=2E001071] Mount-cache hash table entries: 8192 (order: 4, 65536 =
bytes, linear)
>-	[    0=2E001189] Mountpoint-cache hash table entries: 8192 (order: 4, 6=
5536 bytes, linear)
>-	[    0=2E004201] CPU node for /cpus/cpu@0 exist but the possible cpu ra=
nge is :0-3
>-	[    0=2E007426] cblist_init_generic: Setting adjustable number of call=
back queues=2E
>-	[    0=2E007457] cblist_init_generic: Setting shift to 2 and lim to 1=
=2E
>-	[    0=2E007875] riscv: ELF compat mode unsupported
>-	[    0=2E007902] ASID allocator disabled (0 bits)
>-	[    0=2E008405] rcu: Hierarchical SRCU implementation=2E
>-	[    0=2E008426] rcu:     Max phase no-delay instances is 1000=2E
>-	[    0=2E009247] EFI services will not be available=2E
>-	[    0=2E010738] smp: Bringing up secondary CPUs =2E=2E=2E
>-	[    0=2E018358] smp: Brought up 1 node, 4 CPUs
>-	[    0=2E021776] devtmpfs: initialized
>-	[    0=2E027337] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xf=
fffffff, max_idle_ns: 7645041785100000 ns
>-	[    0=2E027389] futex hash table entries: 1024 (order: 4, 65536 bytes,=
 linear)
>-	[    0=2E027888] pinctrl core: initialized pinctrl subsystem
>-	[    0=2E029881] NET: Registered PF_NETLINK/PF_ROUTE protocol family
>-	[    0=2E030401] audit: initializing netlink subsys (disabled)
>-	[    0=2E031041] audit: type=3D2000 audit(0=2E028:1): state=3Dinitializ=
ed audit_enabled=3D0 res=3D1
>-	[    0=2E031943] cpuidle: using governor menu
>-	[    0=2E043011] HugeTLB: registered 2=2E00 MiB page size, pre-allocate=
d 0 pages
>-	[    0=2E043033] HugeTLB: 0 KiB vmemmap can be freed for a 2=2E00 MiB p=
age
>-	[    0=2E044943] iommu: Default domain type: Translated
>-	[    0=2E044965] iommu: DMA domain TLB invalidation policy: strict mode
>-	[    0=2E046089] SCSI subsystem initialized
>-	[    0=2E046733] libata version 3=2E00 loaded=2E
>-	[    0=2E047231] usbcore: registered new interface driver usbfs
>-	[    0=2E047315] usbcore: registered new interface driver hub
>-	[    0=2E047420] usbcore: registered new device driver usb
>-	[    0=2E049770] vgaarb: loaded
>-	[    0=2E050277] clocksource: Switched to clocksource riscv_clocksource
>-	[    0=2E084690] NET: Registered PF_INET protocol family
>-	[    0=2E085561] IP idents hash table entries: 65536 (order: 7, 524288 =
bytes, linear)
>-	[    0=2E093010] tcp_listen_portaddr_hash hash table entries: 2048 (ord=
er: 4, 65536 bytes, linear)
>-	[    0=2E093152] Table-perturb hash table entries: 65536 (order: 6, 262=
144 bytes, linear)
>-	[    0=2E093224] TCP established hash table entries: 32768 (order: 6, 2=
62144 bytes, linear)
>-	[    0=2E093821] TCP bind hash table entries: 32768 (order: 9, 2097152 =
bytes, linear)
>-	[    0=2E117880] TCP: Hash tables configured (established 32768 bind 32=
768)
>-	[    0=2E118500] UDP hash table entries: 2048 (order: 5, 196608 bytes, =
linear)
>-	[    0=2E118881] UDP-Lite hash table entries: 2048 (order: 5, 196608 by=
tes, linear)
>-	[    0=2E119675] NET: Registered PF_UNIX/PF_LOCAL protocol family
>-	[    0=2E121749] RPC: Registered named UNIX socket transport module=2E
>-	[    0=2E121776] RPC: Registered udp transport module=2E
>-	[    0=2E121784] RPC: Registered tcp transport module=2E
>-	[    0=2E121791] RPC: Registered tcp NFSv4=2E1 backchannel transport mo=
dule=2E
>-	[    0=2E121816] PCI: CLS 0 bytes, default 64
>-	[    0=2E124101] Unpacking initramfs=2E=2E=2E
>-	[    0=2E125468] workingset: timestamp_bits=3D46 max_order=3D20 bucket_=
order=3D0
>-	[    0=2E128372] NFS: Registering the id_resolver key type
>-	[    0=2E128498] Key type id_resolver registered
>-	[    0=2E128525] Key type id_legacy registered
>-	[    0=2E128625] nfs4filelayout_init: NFSv4 File Layout Driver Register=
ing=2E=2E=2E
>-	[    0=2E128649] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver =
Registering=2E=2E=2E
>-	[    0=2E129358] 9p: Installing v9fs 9p2000 file system support
>-	[    0=2E130179] NET: Registered PF_ALG protocol family
>-	[    0=2E130499] Block layer SCSI generic (bsg) driver version 0=2E4 lo=
aded (major 247)
>-	[    0=2E130544] io scheduler mq-deadline registered
>-	[    0=2E130556] io scheduler kyber registered
>-	[    0=2E416754] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabl=
ed
>-	[    0=2E420857] SuperH (H)SCI(F) driver initialized
>-	[    0=2E443735] loop: module loaded
>-	[    0=2E448605] e1000e: Intel(R) PRO/1000 Network Driver
>-	[    0=2E448627] e1000e: Copyright(c) 1999 - 2015 Intel Corporation=2E
>-	[    0=2E450716] usbcore: registered new interface driver uas
>-	[    0=2E450832] usbcore: registered new interface driver usb-storage
>-	[    0=2E451638] mousedev: PS/2 mouse device common for all mice
>-	[    0=2E453465] sdhci: Secure Digital Host Controller Interface driver
>-	[    0=2E453487] sdhci: Copyright(c) Pierre Ossman
>-	[    0=2E453584] sdhci-pltfm: SDHCI platform and OF driver helper
>-	[    0=2E454140] usbcore: registered new interface driver usbhid
>-	[    0=2E454174] usbhid: USB HID core driver
>-	[    0=2E454833] riscv-pmu-sbi: SBI PMU extension is available
>-	[    0=2E454920] riscv-pmu-sbi: 16 firmware and 4 hardware counters
>-	[    0=2E454942] riscv-pmu-sbi: Perf sampling/filtering is not supporte=
d as sscof extension is not available
>-	[    0=2E457071] NET: Registered PF_INET6 protocol family
>-	[    0=2E460627] Segment Routing with IPv6
>-	[    0=2E460821] In-situ OAM (IOAM) with IPv6
>-	[    0=2E461005] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
>-	[    0=2E462712] NET: Registered PF_PACKET protocol family
>-	[    0=2E462933] 9pnet: Installing 9P2000 support
>-	[    0=2E463141] Key type dns_resolver registered
>-	[    0=2E463168] start plist test
>-	[    0=2E469261] end plist test
>-	[    0=2E506774] debug_vm_pgtable: [debug_vm_pgtable         ]: Validat=
ing architecture page table helpers
>-	[    0=2E553683] gpio gpiochip0: Static allocation of GPIO base is depr=
ecated, use dynamic allocation=2E
>-	[    0=2E554741] starfive-jh7110-sys-pinctrl 13040000=2Epinctrl: StarFi=
ve GPIO chip registered 64 GPIOs
>-	[    0=2E555900] gpio gpiochip1: Static allocation of GPIO base is depr=
ecated, use dynamic allocation=2E
>-	[    0=2E556772] starfive-jh7110-aon-pinctrl 17020000=2Epinctrl: StarFi=
ve GPIO chip registered 4 GPIOs
>-	[    0=2E559454] printk: console [ttyS0] disabled
>-	[    0=2E579948] 10000000=2Eserial: ttyS0 at MMIO 0x10000000 (irq =3D 3=
, base_baud =3D 1500000) is a 16550A
>-	[    0=2E580082] printk: console [ttyS0] enabled
>-	[   13=2E642680] Freeing initrd memory: 149264K
>-	[   13=2E651051] Freeing unused kernel image (initmem) memory: 2188K
>-	[   13=2E666431] Run /init as init process
>-	[   13=2E670116]   with arguments:
>-	[   13=2E673168]     /init
>-	[   13=2E675488]   with environment:
>-	[   13=2E678668]     HOME=3D/
>-	[   13=2E681038]     TERM=3Dlinux
>-	Starting syslogd: OK
>-	Starting klogd: OK
>-	Running sysctl: OK
>-	Populating /dev using udev: [   14=2E145944] udevd[93]: starting versio=
n 3=2E2=2E10
>-	[   15=2E214287] random: crng init done
>-	[   15=2E240816] udevd[94]: starting eudev-3=2E2=2E10
>-	done
>-	Saving random seed: OK
>-	Starting system message bus: dbus[122]: Unknown username "pulse" in mes=
sage bus configuration file
>-	done
>-	Starting rpcbind: OK
>-	Starting iptables: OK
>-	Starting bluetoothd: OK
>-	Starting network: Waiting for interface eth0 to appear=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E timeout!
>-	run-parts: /etc/network/if-pre-up=2Ed/wait_iface: exit status 1
>-	FAIL
>-	Starting dropbear sshd: OK
>-	Starting NFS statd: OK
>-	Starting NFS services: OK
>-	Starting NFS daemon: rpc=2Enfsd: Unable to access /proc/fs/nfsd errno 2=
 (No such file or directory)=2E
>-	Please try, as root, 'mount -t nfsd nfsd /proc/fs/nfsd' and then restar=
t rpc=2Enfsd to correct the problem
>-	FAIL
>-	Starting NFS mountd: OK
>-	Starting DHCP server: FAIL
>-
>-	Welcome to Buildroot
>-	buildroot login:
>
>base-commit: 69cc92d6869b8ff4591e5b8850872da34934bab9

