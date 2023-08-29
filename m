Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A37C71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 17:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33D8186519;
	Tue, 29 Aug 2023 19:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=null.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=null.net header.i=ivo.ivanov@null.net header.b="ZpituyYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5A9086511; Tue, 29 Aug 2023 19:25:27 +0200 (CEST)
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6634C8650A
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 19:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=null.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivo.ivanov@null.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=null.net;
 s=s1089575; t=1693329923; x=1693934723; i=ivo.ivanov@null.net;
 bh=YKNAM4VjeJ2yjlZorYWAQ6X6zZtnleHLUu5yf5hJ+sE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=ZpituyYnCTr4DZ36cCq4JhKtwqhqDsNhhLuLuj11Z+ZYEQVgPZ2pNbhqthH1vcs61UI9Xzx
 787aPWfC87ANrwsvwbFGIYVJu/13dyVEb+I5PmiZwTqfjVR+S8mOVPauv2BOQPmV5y3BM/yH6
 lsmUpl5WYSGrmErOm8m+GfadbmoDaDmpeCZgJ0ihGnvyB6jll6Kd1MP/tYrTFa2vG8ff3OUyz
 aAwW6J1gnsuCiZohUztNc3xi/voCPSci6+kQm2jockfw0D3G2fPActBMKLnRtN6jLX7y/T5Qo
 9XCOrlzWxoX+8t8dIaU1yKv0gUe3/6f1s9C9sR+deVKdxXTqF+/A==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from ivaylo-desktop ([91.139.201.119]) by smtp.mail.com (mrgmxus005
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0LtHZd-1pZ8Bd1y03-012sT1;
 Tue, 29 Aug 2023 19:25:22 +0200
From: ivo.ivanov@null.net
To: u-boot@lists.denx.de
Cc: kettenis@openbsd.org,
	Ivaylo Ivanov <ivo.ivanov@null.net>
Subject: [PATCH] arm: mach-apple: Move M1/M2 specifics into a separate folder
Date: Tue, 29 Aug 2023 20:25:19 +0300
Message-Id: <20230829172519.72803-1-ivo.ivanov@null.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EmvXgr6pFtILtJg2cX6kUg5tbwmaV476V1ujJaj8jFGE/DywjmF
 cdyS6VkazaXTQmZtFlQPnN2697loVhHYy6nlgTENgjRQL9fTQCz1i6bMBXZA8zMEXM6J6g+
 fIHx63mujEUltoG5znFH7A5L+U9FQf95EYk0hnrhivehZpCW7Egei+wCX9eedLRFE6BYteM
 jmmxbXuw68e4zntWdITSA==
UI-OutboundReport: notjunk:1;M01:P0:e3CWPR81fCY=;fp5+o5fSwIPSTwsMsq/kJFMoc0l
 ibgb0GEpxBXcgr3tvHxwRTNYKq4QRguODlEj2E7MjZDGWt4/gB6IxsN1Ir2bUKV9unu7iXP4q
 WhH1kQnVo5piXltYTIjicmOiLKZEm5p2gvLqqOMGQVWsOOb0J0qh4Fb9R+Zszy93jsbKTA5dE
 yQocU8BqgL/SL7LyUMTyJ7nDPopiAfK1ZSY/4bquhjIOaMpc6BlWuODCvHS/llkApb1VVg5AJ
 EU4Xf6/1IChCXctO7/QKKg/Hg8DsHk2LMqZpsKlmWre3kd4/2uQgDgkpIdDV0VbDhYoAssgUq
 4CPAFCBPnyNiNBPXpCwdMgFWyaH0+BTjOdVdoOqO2W/fN+qtOjJ4/HCdGmihXFSY3mQLeDCaB
 ixdNHN8+Wr4WUc8prcXiIpwmKELVZq5ELn2WqOp4SpBM3t/KmUgSFlb4/YFb2PKIqt++g8nfK
 Ayt22xvQwVu3WSgVlfFF6rhpatu/vt5KqvGbBy1RLnZLclGwUk7fKIZRLkfou0D/Z9ddKf+Y2
 +3pb8LZdRJPEZf+zfcPl+qK9BpiDH4U41suRoGnWjpiw6Ssw4gEJAXHuJf2jtMC4KDmgqQ8gk
 B3Ym1GdDSdQPzrA9q+DZB/VgSHrnD9Q5ORqx+EAPo/1e6AKJ0s6z10ZQHu+1CAeieXq351B7m
 eutNgBJbBuUwwLRTWb+CMR98Sou4l4Ttfeuh0a+WTjF6lSScbn6w/FIlnq0BXpVrzp2g6PNSP
 NV7iYSa4q8Jx3bzQeDHVeXD+ulroxtU+WOPIZ2sSOsPNWi2/RQa6D3KZcBGyPTp5/O/zh5HhD
 2wFcT6pV09cV6wtT5T7Z3rfjoTZkCx3AlAaKdxTlPW1aFrn6I/yh//788gMOvp4+9dxvZa230
 XGnVIWjRAgVfYAnKZ/hhhHNeEepn8hpC84RD8yOW9wBRwdDc8pen11Vs1QDjgT8H0qlKLjCwS
 Uy9hkZ1YVFfq0gh2ll22Z+OTMPo=
X-Mailman-Approved-At: Tue, 29 Aug 2023 19:34:58 +0200
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

From: Ivaylo Ivanov <ivo.ivanov@null.net>

Currently, mach-apple assumes we're working with M1/M2. Make room for
adding support for other Apple SoCs by moving everything from the M1/M2
SoC family in "mach-apple/" into "mach-apple/m1/".

Signed-off-by: Ivaylo Ivanov <ivo.ivanov@null.net>
=2D--
 arch/arm/Kconfig                             | 29 --------------
 arch/arm/mach-apple/Kconfig                  | 42 ++++++++++++++++++++
 arch/arm/mach-apple/Makefile                 |  5 +--
 arch/arm/mach-apple/m1/Makefile              |  6 +++
 arch/arm/mach-apple/{ =3D> m1}/board.c         |  0
 arch/arm/mach-apple/{ =3D> m1}/lowlevel_init.S |  0
 arch/arm/mach-apple/{ =3D> m1}/rtkit.c         |  0
 arch/arm/mach-apple/{ =3D> m1}/sart.c          |  0
 configs/apple_m1_defconfig                   |  1 +
 9 files changed, 50 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/mach-apple/m1/Makefile
 rename arch/arm/mach-apple/{ =3D> m1}/board.c (100%)
 rename arch/arm/mach-apple/{ =3D> m1}/lowlevel_init.S (100%)
 rename arch/arm/mach-apple/{ =3D> m1}/rtkit.c (100%)
 rename arch/arm/mach-apple/{ =3D> m1}/sart.c (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 97c25b4f14..5339da370c 100644
=2D-- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -980,38 +980,9 @@ config ARCH_NPCM

 config ARCH_APPLE
 	bool "Apple SoCs"
-	select ARM64
-	select CLK
-	select CMD_PCI
-	select CMD_USB
 	select DM
-	select DM_GPIO
-	select DM_KEYBOARD
-	select DM_MAILBOX
 	select DM_RESET
 	select DM_SERIAL
-	select DM_SPI
-	select DM_USB
-	select VIDEO
-	select IOMMU
-	select LINUX_KERNEL_IMAGE_HEADER
-	select OF_BOARD_SETUP
-	select OF_CONTROL
-	select PCI
-	select PINCTRL
-	select POSITION_INDEPENDENT
-	select POWER_DOMAIN
-	select REGMAP
-	select SPI
-	select SYSCON
-	select SYSRESET
-	select SYSRESET_WATCHDOG
-	select SYSRESET_WATCHDOG_AUTO
-	select USB
-	imply CMD_DM
-	imply CMD_GPT
-	imply DISTRO_DEFAULTS
-	imply OF_HAS_PRIOR_STAGE

 config ARCH_OWL
 	bool "Actions Semi OWL SoCs"
diff --git a/arch/arm/mach-apple/Kconfig b/arch/arm/mach-apple/Kconfig
index 294690ec0e..a38779b387 100644
=2D-- a/arch/arm/mach-apple/Kconfig
+++ b/arch/arm/mach-apple/Kconfig
@@ -3,6 +3,46 @@ if ARCH_APPLE
 config TEXT_BASE
 	default 0x00000000

+choice
+	prompt "Apple Silicon architecture type select"
+	optional
+
+config ARCH_APPLE_M1
+	bool "Apple M1/M2 SoC family"
+	select ARM64
+	select CLK
+	select CMD_PCI
+	select CMD_USB
+	select DM_GPIO
+	select DM_KEYBOARD
+	select DM_MAILBOX
+	select DM_SPI
+	select DM_USB
+	select VIDEO
+	select IOMMU
+	select LINUX_KERNEL_IMAGE_HEADER
+	select OF_BOARD_SETUP
+	select OF_CONTROL
+	select PCI
+	select PINCTRL
+	select POSITION_INDEPENDENT
+	select POWER_DOMAIN
+	select REGMAP
+	select SPI
+	select SYSCON
+	select SYSRESET
+	select SYSRESET_WATCHDOG
+	select SYSRESET_WATCHDOG_AUTO
+	select USB
+	imply CMD_DM
+	imply CMD_GPT
+	imply DISTRO_DEFAULTS
+	imply OF_HAS_PRIOR_STAGE
+
+endchoice
+
+if ARCH_APPLE_M1
+
 config SYS_CONFIG_NAME
 	default "apple"

@@ -19,3 +59,5 @@ config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default TEXT_BASE

 endif
+
+endif
diff --git a/arch/arm/mach-apple/Makefile b/arch/arm/mach-apple/Makefile
index 50b465b947..d147ccdde2 100644
=2D-- a/arch/arm/mach-apple/Makefile
+++ b/arch/arm/mach-apple/Makefile
@@ -1,6 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0+

-obj-y +=3D board.o
-obj-y +=3D lowlevel_init.o
-obj-y +=3D rtkit.o
-obj-$(CONFIG_NVME_APPLE) +=3D sart.o
+obj-$(CONFIG_ARCH_APPLE_M1) +=3D m1/
diff --git a/arch/arm/mach-apple/m1/Makefile b/arch/arm/mach-apple/m1/Make=
file
new file mode 100644
index 0000000000..50b465b947
=2D-- /dev/null
+++ b/arch/arm/mach-apple/m1/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y +=3D board.o
+obj-y +=3D lowlevel_init.o
+obj-y +=3D rtkit.o
+obj-$(CONFIG_NVME_APPLE) +=3D sart.o
diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/m1/board.c
similarity index 100%
rename from arch/arm/mach-apple/board.c
rename to arch/arm/mach-apple/m1/board.c
diff --git a/arch/arm/mach-apple/lowlevel_init.S b/arch/arm/mach-apple/m1/=
lowlevel_init.S
similarity index 100%
rename from arch/arm/mach-apple/lowlevel_init.S
rename to arch/arm/mach-apple/m1/lowlevel_init.S
diff --git a/arch/arm/mach-apple/rtkit.c b/arch/arm/mach-apple/m1/rtkit.c
similarity index 100%
rename from arch/arm/mach-apple/rtkit.c
rename to arch/arm/mach-apple/m1/rtkit.c
diff --git a/arch/arm/mach-apple/sart.c b/arch/arm/mach-apple/m1/sart.c
similarity index 100%
rename from arch/arm/mach-apple/sart.c
rename to arch/arm/mach-apple/m1/sart.c
diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
index 755560971e..bd723881da 100644
=2D-- a/configs/apple_m1_defconfig
+++ b/configs/apple_m1_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=3Dy
 CONFIG_ARCH_APPLE=3Dy
+CONFIG_ARCH_APPLE_M1=3Dy
 CONFIG_DEFAULT_DEVICE_TREE=3D"t8103-j274"
 CONFIG_SYS_LOAD_ADDR=3D0x0
 CONFIG_USE_PREBOOT=3Dy
=2D-
2.34.1

