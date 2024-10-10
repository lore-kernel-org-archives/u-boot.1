Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C9FCF07A5
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 724118915F;
	Thu, 10 Oct 2024 07:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="KCvQSEp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA64189114; Thu, 10 Oct 2024 07:56:02 +0200 (CEST)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13054890E5
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 2024101005555818a6c86fb16edabe17 for <u-boot@lists.denx.de>;
 Thu, 10 Oct 2024 07:55:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VfhMScn83cismwFtCoc495hcaAgSbPuuG0vCxyb6RQ8=;
 b=KCvQSEp7r+wN74yAK+yS0RdXkGJ8WvkVEqZ7rPThxZXwzGXNK/4Zfylcr+ali4PqooYmVC
 1R9MGJuubd5Gm88oioLGsNB/sOMKPLRWuJFGNJe5XOA64yIH43dmoWdzMwgxTGlrKzKC35Tl
 PEtGauskVjy3j9/MxwjLKeK4NREqbRLPeAccMTdNsVnR4rlWPomYk6h9/T/X+G9Eup289Gpq
 SMBkwbggPerDACoIwPTBoGI60/iqHjjvfi0K3b+dK8K7IYxcocmW0SzL60aFuSICmRLAiqCf
 LR2QcVucZD7FpIqPJZiY1LvU27q+rfWI0UQbaAYsi9rt9Ir+r6NSH4Tg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 08/11] dts: iot2050: Support new IOT2050-SM variant
Date: Thu, 10 Oct 2024 07:55:52 +0200
Message-ID: <881166f811788e6440919ebf26109433c1214961.1728539755.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1728539755.git.jan.kiszka@siemens.com>
References: <cover.1728539755.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Baocheng Su <baocheng.su@siemens.com>

the dts file for IOT2050-SM variant is copied from kernel side without
any change.

Main differences between the new variant and Advanced PG2:

1. Arduino interface is removed. Instead, an new ASIC is added for
   communicating with PLC 1200 signal modules.
2. USB 3.0 type A connector is removed, only USB 2.0 type A connector is
   avaiable.
3. DP interface is tailored down. Instead, to communicate with the
   PLC 1200 signal modules, a USB 3.0 type B connector is added but the
   signal is not USB.
4. DDR size is increased to 4 GB.
5. Two sensors are added, one tilt sensor and one light sensor.

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
[Jan: rebased over OF_UPSTREAM]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/dts/k3-am65-iot2050-boot-image.dtsi      |  5 ++++-
 .../dts/k3-am6548-iot2050-advanced-sm-u-boot.dtsi |  1 +
 board/siemens/iot2050/board.c                     | 15 ++++++++++++++-
 configs/iot2050_defconfig                         |  2 +-
 doc/board/siemens/iot2050.rst                     |  4 +++-
 5 files changed, 23 insertions(+), 4 deletions(-)
 create mode 120000 arch/arm/dts/k3-am6548-iot2050-advanced-sm-u-boot.dtsi

diff --git a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
index 1b31d412b4c..f49d6f262f2 100644
--- a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
+++ b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
@@ -229,7 +229,10 @@
 		};
 
 		fit@380000 {
-			fit,fdt-list-val = "ti/k3-am6528-iot2050-basic-pg2", "ti/k3-am6548-iot2050-advanced-pg2", "ti/k3-am6548-iot2050-advanced-m2";
+			fit,fdt-list-val = "ti/k3-am6528-iot2050-basic-pg2",
+					   "ti/k3-am6548-iot2050-advanced-pg2",
+					   "ti/k3-am6548-iot2050-advanced-m2",
+					   "ti/k3-am6548-iot2050-advanced-sm";
 
 			images {
 				bkey-usb3-overlay {
diff --git a/arch/arm/dts/k3-am6548-iot2050-advanced-sm-u-boot.dtsi b/arch/arm/dts/k3-am6548-iot2050-advanced-sm-u-boot.dtsi
new file mode 120000
index 00000000000..859776d3ffe
--- /dev/null
+++ b/arch/arm/dts/k3-am6548-iot2050-advanced-sm-u-boot.dtsi
@@ -0,0 +1 @@
+k3-am6528-iot2050-basic-pg2-u-boot.dtsi
\ No newline at end of file
diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index 9d4c9cf1b31..e6bedc38917 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -174,6 +174,14 @@ static bool board_is_m2(void)
 		strcmp((char *)info->name, "IOT2050-ADVANCED-M2") == 0;
 }
 
+static bool board_is_sm(void)
+{
+	struct iot2050_info *info = IOT2050_INFO_DATA;
+
+	return info->magic == IOT2050_INFO_MAGIC &&
+		strcmp((char *)info->name, "IOT2050-ADVANCED-SM") == 0;
+}
+
 static void remove_mmc1_target(void)
 {
 	char *boot_targets = strdup(env_get("boot_targets"));
@@ -189,7 +197,10 @@ static void remove_mmc1_target(void)
 
 static void enable_pcie_connector_power(void)
 {
-	set_pinvalue("gpio@601000_17", "P3V3_PCIE_CON_EN", 1);
+	if (board_is_sm())
+		set_pinvalue("gpio@601000_22", "P3V3_PCIE_CON_EN", 1);
+	else
+		set_pinvalue("gpio@601000_17", "P3V3_PCIE_CON_EN", 1);
 	udelay(4 * 100);
 }
 
@@ -230,6 +241,8 @@ void set_board_info_env(void)
 			fdtfile = "ti/k3-am6548-iot2050-advanced.dtb";
 		else if (board_is_m2())
 			fdtfile = "ti/k3-am6548-iot2050-advanced-m2.dtb";
+		else if (board_is_sm())
+			fdtfile = "ti/k3-am6548-iot2050-advanced-sm.dtb";
 		else
 			fdtfile = "ti/k3-am6548-iot2050-advanced-pg2.dtb";
 	} else {
diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
index 78db6d21099..2624f0cb573 100644
--- a/configs/iot2050_defconfig
+++ b/configs/iot2050_defconfig
@@ -80,7 +80,7 @@ CONFIG_CMD_TIME=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
-CONFIG_OF_LIST="ti/k3-am6528-iot2050-basic ti/k3-am6528-iot2050-basic-pg2 ti/k3-am6548-iot2050-advanced ti/k3-am6548-iot2050-advanced-pg2 ti/k3-am6548-iot2050-advanced-m2"
+CONFIG_OF_LIST="ti/k3-am6528-iot2050-basic ti/k3-am6528-iot2050-basic-pg2 ti/k3-am6548-iot2050-advanced ti/k3-am6548-iot2050-advanced-pg2 ti/k3-am6548-iot2050-advanced-m2 ti/k3-am6548-iot2050-advanced-sm"
 CONFIG_OF_OVERLAY_LIST="ti/k3-am6548-iot2050-advanced-m2-bkey-usb3 ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie"
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_OF_LIST="ti/k3-am6528-iot2050-basic"
diff --git a/doc/board/siemens/iot2050.rst b/doc/board/siemens/iot2050.rst
index d0c0a412097..37b23f6146b 100644
--- a/doc/board/siemens/iot2050.rst
+++ b/doc/board/siemens/iot2050.rst
@@ -8,7 +8,9 @@ The SIMATIC IOT2050 is an open industrial IoT gateway that is using the TI
 AM6528 GP (Basic variant) or the AM6548 HS (Advanced variant). The Advanced
 variant is prepared for secure boot. M.2 Variant also uses the AM6548 HS.
 Instead of a MiniPCI connector, it comes with two M.2 connectors and can
-support 5G/WIFI/BT applications or connect an SSD.
+support 5G/WIFI/BT applications or connect an SSD. Compared with the AM6548
+Advanced variant, SM variant removes the Arduino interface, and adds a new
+ASIC for communicating with the PLC 1200 signal modules.
 
 The IOT2050 starts only from OSPI. It loads a Siemens-provided bootloader
 called SE-Boot for the MCU domain (R5F cores), then hands over to ATF and
-- 
2.43.0

