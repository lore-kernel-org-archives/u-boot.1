Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6E2C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 17:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CC7080540;
	Sat, 22 Feb 2025 18:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740244498;
	bh=dUtw7+4n+V8VxmEBCs4q44p3ox8mAzn/wCXO0wMCs7U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Gw8+9KRn85vy/P71048ZbyOxShiKXB+S0Oz/kaff1Bi12XG82SlmTfFIXk83lC+TU
	 YSr3n+1QcOKZwkVRbNAJ+WXNw4QhcWnCCHmdHfFmGH3yA+Jdcb8sxNHugh9VoC6L5e
	 XE9v0JpEhy7Vd9YrOLUOMOJvGz7p+YxW/7yBD4+YTQwCv319Vip2oTKC2Guxd0IZSa
	 zFVIGOVH6X6rb0sz2dLWmVAmzCzGi7O3rjGlrRU64k0yuV12/6i6knK7U9gmU/QeuC
	 jw1zwsdhMvkmUHP8366NxyobDJMRpcLqM2HTyTgzkrzMQky4H3DNrKd/cLytDksndT
	 naVg6FjNnbKrQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D8F808B6; Sat, 22 Feb 2025 18:14:57 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28F99800B6
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 18:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="PjHFEdDC"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5A73210382D37; Sat, 22 Feb 2025 18:14:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740244494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dUtw7+4n+V8VxmEBCs4q44p3ox8mAzn/wCXO0wMCs7U=;
 b=PjHFEdDCkzloQ9KK+x6b1HkQ9qtPpTc+MxD0Fgtl9ih6L+4BelvdTWwhZiv2jpVm+kEpqW
 gPZ4+O2Tg5S+Mpjrtfs/ebgz5O9bwoz46qkFdDRxWvovj2bHB90MU6EmC876/23cHAM2L8
 nO0OirCF1p6CokFCczndRvyAUEaG3/U8Hh2HNaR7CuG+iu7xyDRfwx4NjzDgG785K7yfVQ
 sEhGNDnWcLfIsgWBb3Qpcf8BMyngAWXvqwW1t6qaHn6cBzfSswHjweYja76Dqm1vxC2t7X
 On+F8P0+uxKrhxymQ0ys7vJFA3X+3ERVxDYwBnUbMqRqBi+RfmWjag5mTl2imw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Introduce DH STM32MP15xx DHSOM board specific
 defconfigs
Date: Sat, 22 Feb 2025 18:13:44 +0100
Message-ID: <20250222171438.90953-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Move stm32mp15_dhcom_basic_defconfig into stm32mp15_dhcom_basic.config.
Retain legacy stm32mp15_dhcom_basic_defconfig as multi-config for all
DH STM32MP15xx DHCOM based boards. Move stm32mp15_dhsor_basic_defconfig
into stm32mp15_dhsor_basic.config. Retain stm32mp15_dhsor_basic_defconfig
as multi-config for all DH STM32MP15xx DHCOR based boards.

Introduce separate stm32mp15_dhcom_drc02_basic_defconfig,
stm32mp15_dhcom_pdk2_basic_defconfig, stm32mp15_dhcom_picoitx_basic_defconfig
for each STM32MP15xx DHCOM based board and separate
stm32mp15_dhcor_avenger96_basic_defconfig,
stm32mp15_dhcor_drc_compact_basic_defconfig,
stm32mp15_dhcor_testbench_basic_defconfig for each
STM32MP15xx DHCOR based board, to make build for those boards easier.
No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 configs/stm32mp15_dhcom_basic.config                | 8 ++++++++
 configs/stm32mp15_dhcom_basic_defconfig             | 8 +-------
 configs/stm32mp15_dhcom_drc02_basic_defconfig       | 4 ++++
 configs/stm32mp15_dhcom_pdk2_basic_defconfig        | 4 ++++
 configs/stm32mp15_dhcom_picoitx_basic_defconfig     | 4 ++++
 configs/stm32mp15_dhcor_avenger96_basic_defconfig   | 4 ++++
 configs/stm32mp15_dhcor_basic.config                | 8 ++++++++
 configs/stm32mp15_dhcor_basic_defconfig             | 8 +-------
 configs/stm32mp15_dhcor_drc_compact_basic_defconfig | 4 ++++
 configs/stm32mp15_dhcor_testbench_basic_defconfig   | 4 ++++
 10 files changed, 42 insertions(+), 14 deletions(-)
 create mode 100644 configs/stm32mp15_dhcom_basic.config
 create mode 100644 configs/stm32mp15_dhcom_drc02_basic_defconfig
 create mode 100644 configs/stm32mp15_dhcom_pdk2_basic_defconfig
 create mode 100644 configs/stm32mp15_dhcom_picoitx_basic_defconfig
 create mode 100644 configs/stm32mp15_dhcor_avenger96_basic_defconfig
 create mode 100644 configs/stm32mp15_dhcor_basic.config
 create mode 100644 configs/stm32mp15_dhcor_drc_compact_basic_defconfig
 create mode 100644 configs/stm32mp15_dhcor_testbench_basic_defconfig

diff --git a/configs/stm32mp15_dhcom_basic.config b/configs/stm32mp15_dhcom_basic.config
new file mode 100644
index 00000000000..d78916bb5b2
--- /dev/null
+++ b/configs/stm32mp15_dhcom_basic.config
@@ -0,0 +1,8 @@
+#include <configs/stm32mp15_dhsom.config>
+
+CONFIG_ARM=y
+CONFIG_ARCH_STM32MP=y
+CONFIG_SYS_MEMTEST_START=0xc0000000
+CONFIG_SYS_MEMTEST_END=0xc4000000
+CONFIG_SYS_I2C_EEPROM_BUS=3
+CONFIG_SYS_I2C_EEPROM_ADDR=0x50
diff --git a/configs/stm32mp15_dhcom_basic_defconfig b/configs/stm32mp15_dhcom_basic_defconfig
index a28f2862048..297092bd746 100644
--- a/configs/stm32mp15_dhcom_basic_defconfig
+++ b/configs/stm32mp15_dhcom_basic_defconfig
@@ -1,10 +1,4 @@
-#include <configs/stm32mp15_dhsom.config>
+#include <configs/stm32mp15_dhcom_basic.config>
 
-CONFIG_ARM=y
-CONFIG_ARCH_STM32MP=y
 CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp157c-dhcom-pdk2"
-CONFIG_SYS_MEMTEST_START=0xc0000000
-CONFIG_SYS_MEMTEST_END=0xc4000000
-CONFIG_SYS_I2C_EEPROM_BUS=3
 CONFIG_OF_LIST="st/stm32mp157c-dhcom-pdk2 st/stm32mp153c-dhcom-drc02 st/stm32mp157c-dhcom-picoitx"
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
diff --git a/configs/stm32mp15_dhcom_drc02_basic_defconfig b/configs/stm32mp15_dhcom_drc02_basic_defconfig
new file mode 100644
index 00000000000..838c3db253d
--- /dev/null
+++ b/configs/stm32mp15_dhcom_drc02_basic_defconfig
@@ -0,0 +1,4 @@
+#include <configs/stm32mp15_dhcom_basic.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp153c-dhcom-drc02"
+CONFIG_OF_LIST="st/stm32mp153c-dhcom-drc02"
diff --git a/configs/stm32mp15_dhcom_pdk2_basic_defconfig b/configs/stm32mp15_dhcom_pdk2_basic_defconfig
new file mode 100644
index 00000000000..c6996233c9f
--- /dev/null
+++ b/configs/stm32mp15_dhcom_pdk2_basic_defconfig
@@ -0,0 +1,4 @@
+#include <configs/stm32mp15_dhcom_basic.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp157c-dhcom-pdk2"
+CONFIG_OF_LIST="st/stm32mp157c-dhcom-pdk2"
diff --git a/configs/stm32mp15_dhcom_picoitx_basic_defconfig b/configs/stm32mp15_dhcom_picoitx_basic_defconfig
new file mode 100644
index 00000000000..5682edbfcbf
--- /dev/null
+++ b/configs/stm32mp15_dhcom_picoitx_basic_defconfig
@@ -0,0 +1,4 @@
+#include <configs/stm32mp15_dhcom_basic.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp157c-dhcom-picoitx"
+CONFIG_OF_LIST="st/stm32mp157c-dhcom-picoitx"
diff --git a/configs/stm32mp15_dhcor_avenger96_basic_defconfig b/configs/stm32mp15_dhcor_avenger96_basic_defconfig
new file mode 100644
index 00000000000..5d27cd5ed7e
--- /dev/null
+++ b/configs/stm32mp15_dhcor_avenger96_basic_defconfig
@@ -0,0 +1,4 @@
+#include <configs/stm32mp15_dhcor_basic.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp157a-dhcor-avenger96"
+CONFIG_OF_LIST="st/stm32mp157a-dhcor-avenger96"
diff --git a/configs/stm32mp15_dhcor_basic.config b/configs/stm32mp15_dhcor_basic.config
new file mode 100644
index 00000000000..e9c0cb9f95a
--- /dev/null
+++ b/configs/stm32mp15_dhcor_basic.config
@@ -0,0 +1,8 @@
+#include <configs/stm32mp15_dhsom.config>
+
+CONFIG_ARM=y
+CONFIG_ARCH_STM32MP=y
+CONFIG_SYS_I2C_EEPROM_BUS=2
+CONFIG_SYS_I2C_EEPROM_ADDR=0x53
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
diff --git a/configs/stm32mp15_dhcor_basic_defconfig b/configs/stm32mp15_dhcor_basic_defconfig
index f6f2af6e7a2..beb6d1d5a9a 100644
--- a/configs/stm32mp15_dhcor_basic_defconfig
+++ b/configs/stm32mp15_dhcor_basic_defconfig
@@ -1,10 +1,4 @@
-#include <configs/stm32mp15_dhsom.config>
+#include <configs/stm32mp15_dhcor_basic.config>
 
-CONFIG_ARM=y
-CONFIG_ARCH_STM32MP=y
 CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp157a-dhcor-avenger96"
-CONFIG_SYS_I2C_EEPROM_BUS=2
 CONFIG_OF_LIST="st/stm32mp157a-dhcor-avenger96 st/stm32mp151a-dhcor-testbench st/stm32mp153c-dhcor-drc-compact"
-CONFIG_SYS_I2C_EEPROM_ADDR=0x53
-CONFIG_PHY_MICREL=y
-CONFIG_PHY_MICREL_KSZ90X1=y
diff --git a/configs/stm32mp15_dhcor_drc_compact_basic_defconfig b/configs/stm32mp15_dhcor_drc_compact_basic_defconfig
new file mode 100644
index 00000000000..7b1d73a33b5
--- /dev/null
+++ b/configs/stm32mp15_dhcor_drc_compact_basic_defconfig
@@ -0,0 +1,4 @@
+#include <configs/stm32mp15_dhcor_basic.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp153c-dhcor-drc-compact"
+CONFIG_OF_LIST="st/stm32mp153c-dhcor-drc-compact"
diff --git a/configs/stm32mp15_dhcor_testbench_basic_defconfig b/configs/stm32mp15_dhcor_testbench_basic_defconfig
new file mode 100644
index 00000000000..7ba327cbd82
--- /dev/null
+++ b/configs/stm32mp15_dhcor_testbench_basic_defconfig
@@ -0,0 +1,4 @@
+#include <configs/stm32mp15_dhcor_basic.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp151a-dhcor-testbench"
+CONFIG_OF_LIST="st/stm32mp151a-dhcor-testbench"
-- 
2.47.2

