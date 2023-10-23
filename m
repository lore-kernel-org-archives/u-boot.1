Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE82C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E292287976;
	Mon, 23 Oct 2023 15:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D3586F59; Mon, 23 Oct 2023 15:25:42 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6320687969
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAE60C15;
 Mon, 23 Oct 2023 06:26:20 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E94E3F762;
 Mon, 23 Oct 2023 06:25:38 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>
Subject: [PATCH v3 24/24] sunxi: add MangoPi MQ-R board support
Date: Mon, 23 Oct 2023 14:24:49 +0100
Message-Id: <20231023132449.813863-25-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023132449.813863-1-andre.przywara@arm.com>
References: <20231023132449.813863-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The MangoPi MQ-R board uses an Allwinner T113s Soc (with 128MB of
embedded DRAM), support for which was just added to the code.

Since the devicetree was already synced from the latest Linux kernel
tree, all we need is a _defconfig file to add support for the board.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/dts/Makefile          |  2 ++
 configs/mangopi_mq_r_defconfig | 15 +++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 configs/mangopi_mq_r_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 4569483d5fd..3a9b365de10 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -776,6 +776,8 @@ dtb-$(CONFIG_MACH_SUN8I_V3S) += \
 	sun8i-s3-pinecube.dtb \
 	sun8i-v3-sl631-imx179.dtb \
 	sun8i-v3s-licheepi-zero.dtb
+dtb-$(CONFIG_MACH_SUN8I_R528) += \
+	sun8i-t113s-mangopi-mq-r-t113.dtb
 dtb-$(CONFIG_MACH_SUN50I_H5) += \
 	sun50i-h5-bananapi-m2-plus.dtb \
 	sun50i-h5-emlid-neutis-n5-devboard.dtb \
diff --git a/configs/mangopi_mq_r_defconfig b/configs/mangopi_mq_r_defconfig
new file mode 100644
index 00000000000..66ae639326f
--- /dev/null
+++ b/configs/mangopi_mq_r_defconfig
@@ -0,0 +1,15 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun8i-t113s-mangopi-mq-r-t113"
+CONFIG_SPL=y
+CONFIG_MACH_SUN8I_R528=y
+CONFIG_DRAM_CLK=792
+CONFIG_DRAM_ZQ=8092667
+CONFIG_SUNXI_MINIMUM_DRAM_MB=128
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_DRAM_SUNXI_ODT_EN=0
+CONFIG_DRAM_SUNXI_TPR0=0x004a2195
+CONFIG_DRAM_SUNXI_TPR11=0x340000
+CONFIG_DRAM_SUNXI_TPR12=0x46
+CONFIG_DRAM_SUNXI_TPR13=0x34000100
+CONFIG_CONS_INDEX=4
-- 
2.25.1

