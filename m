Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70817C4452B
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 01:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3281980EB4;
	Wed, 22 Jul 2026 01:37:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BFjoCGizl0LN; Wed, 22 Jul 2026 01:37:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FF9580EA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784684229;
	bh=L5adt8n/PT+v32GeaBdJC5B3V2NbIAL/h+Qvv4bG2ag=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=uMByqkOshAl164sKOKJRXe2zrVus2I40mxq/UzhIuSINlHpVlQ9NjeRGh/qQoRNlk
	 KEI4k6Ajf3LAf2A1AeKLkKDki7S+kEXnOEFbswRG8aSJQ5mJxRMI1/wjHRNMumMULt
	 1Mf7PnBnkaC6OWHLsXByMjqBWXM4lDrq/XpCkTIyeFUrT8MEWdSoqQ5dyXWmAZndAb
	 WWUjP7uaBwNmOF6UaJN8g6WE+8882Fipt/yJgh6T0xG6Fc34rs6yzemshsvyYOHWu4
	 S8Ld9oA3fwtuiuZXI94DiwhukVkiSRGA9a+Nrc41itGtYyO7fiy6lvYG4mfWFHFEp9
	 kEvXFvGHEkFig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FF9580EA2;
	Wed, 22 Jul 2026 01:37:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 95B2110A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87D4B401A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:37:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vexFj8u5S2yi for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 01:37:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A02E04007C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A02E04007C
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A02E04007C
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:37:07 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7ff05e5d009so138163727b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 18:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784684226; x=1785289026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L5adt8n/PT+v32GeaBdJC5B3V2NbIAL/h+Qvv4bG2ag=;
 b=iA8mh7S2qJuZ9vAEH9oWcZLXNY9dufTrPGSEZ9y+7cNdmrCkyPEXMgPjWVeZ3+kmUI
 Gn3IyHr0jW5Ug11ItlFMLHXzGZUo2mFZfQ5RHU//rfBqARdv+Uo+FaEieZNnsV1d6VR0
 w95DD9I7g9sXro+TrYwshqMVYksQMQ/IX9b5PyPn2KewO4fur9+44Zsee2dYXyLdP6ub
 AGSlOpx0G+rYDaVNDkOFRfoxEfM5mYy0lJZYwlCqSIbkt4YVZhXlW9KBorM2Fh4PMk2k
 W3p506pkTHR7f/nBI/kJ1okcYkrIMPbNI6vQ55aH2bf6JuNMoBBrb40VbjBHV83h1Luu
 SgjA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXamzFrTIv6urLBQBsz5CXSSQz6g37+AsJSSwgI5rdak1mEq18AlpWEAE4ru233Y+CUebqAkg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz4HS3JRO9+5yaAoTWO9JZAKK5EjYxgdZ/ms54eOZ272MK/XD8K
 mJ9OJK/tAV4WveNwece6CZEkjo58YX39RZD8RbPeR3xqDOpM5ikScAb3
X-Gm-Gg: AR+sD12ba3a6DllKL8Jkmsl8GPVglbjnRK0B/Vmnq82hpXxkXFLw2GmIOONHFhv4Njt
 vLi8oGToP5BPB5tlsd0cEVoUbDUY15rcNxclqKBDBXAeRl+UtkN3A5xX+XbppAyh7auNEcfOtfe
 +i+8zoKwpR8oVGInS41TadGQxX15n0iALMvORU9s6Hlc+JyumuqbBB+2KzaG2Bee3NQZfoOtVNn
 FKRpM76lfYqOmXnRRgnLghmANso6gY6G0FYfUhw4HSsoXnxvlIXcQG9Hh15Hz0kVPcRqQb6n3rn
 K0mUwyqaJg73ISl6IKVnx9mPRNt+EdhBSY8d93VthpGi474gQWFZwqLq5uqKOZYQeyxSgv5TfES
 yL/gW15E+D6KuR6tiesApJPouz0guHQZp+l9tgZDaO5I1U3n8uftpR5Mn8azd4DAn13gRzHcgid
 fWMjtbKGcgDAKyjvtlFicSzMyhH6NoxgbuMNHD8kvbD/kXe2VKcA1lPH1wig==
X-Received: by 2002:a05:690c:ecd:b0:81d:bac0:88dc with SMTP id
 00721157ae682-81ef2857f6dmr60076767b3.59.1784684226256; 
 Tue, 21 Jul 2026 18:37:06 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a801:a24:1ad1:7a2c:313f:6408])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33ee52a0sm6372937b3.36.2026.07.21.18.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 18:37:05 -0700 (PDT)
To: u-boot@0leil.net
Cc: djw@t-chip.com.cn, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, trini@konsulko.com,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 3/5] rockchip: rk3399: Add ROC-PC-PLUS board detection
Date: Tue, 21 Jul 2026 22:36:40 -0300
Message-ID: <20260722013642.1011666-3-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722013642.1011666-1-festevam@gmail.com>
References: <20260722013642.1011666-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784684226; x=1785289026;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L5adt8n/PT+v32GeaBdJC5B3V2NbIAL/h+Qvv4bG2ag=;
 b=sSeNIzig7WbEsZHgrMWWfy22EeRxLBKY0zgkIukeHCh1jZ/TJQVfMzEpY7km00QJvr
 cU+dBXS4wRY7qe9EnPlZElpkKBolFQKnLjjzHx0xYVswNZO1PGv62tSCi8wR+tFPZHdI
 f8V2MQ6a3sVhOUif+NOtvf/EQMI5GNj0fqrNwZ4x0SA7TNfV/bb4TXSdV5AmpY5cquX8
 YgGmJ1dOFFg2GQ74SEY/xy9gjKV19ywF/lyiG8V7+LKUK3b3EziT/p5tHlNpm1yOcD6p
 Dgeu/JKILyVOxDhsvdtx7bv++KHEiCSYiLD2ns7Yfjp3rVgbd9fUa8aoGvTnhEvgD23b
 7oHA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=sSeNIzig
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Fabio Estevam via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Fabio Estevam <festevam@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Fabio Estevam <festevam@nabladev.com>

The ROC-RK3399-PC has an MP8859 regulator on I2C7 at address 0x66,
while the ROC-RK3399-PC-PLUS does not. Probe for the regulator in SPL
and use the result to select the matching devicetree from the U-Boot
FIT. Fall back to the original board if the I2C bus cannot be probed.

Build both devicetrees from the existing roc-pc-rk3399_defconfig and
enable the XMC SPI NOR driver used by the Plus variant. Set fdtfile
from the selected U-Boot devicetree so the matching Linux devicetree
is used as well.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- Added run-time board time detection.

 arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi |  3 ++
 arch/arm/dts/rk3399-roc-pc-u-boot.dtsi      |  8 +++++
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c | 37 +++++++++++++++++++++
 configs/roc-pc-rk3399_defconfig             |  3 ++
 doc/board/rockchip/rockchip.rst             |  2 +-
 5 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi

diff --git a/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
new file mode 100644
index 000000000000..c80529a62b97
--- /dev/null
+++ b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "rk3399-roc-pc-u-boot.dtsi"
diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
index a85e9549c83e..e7e4a2c89072 100644
--- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
@@ -12,6 +12,14 @@
 	};
 };
 
+&i2c7 {
+	bootph-pre-ram;
+};
+
+&i2c7_xfer {
+	bootph-pre-ram;
+};
+
 &gpio4 {
 	bootph-pre-ram;
 };
diff --git a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
index 6937a27176f9..60a3ba43cdbd 100644
--- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
+++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
@@ -5,14 +5,24 @@
 
 #include <dm.h>
 #include <env.h>
+#include <fdtdec.h>
+#include <i2c.h>
+#include <image.h>
 #include <log.h>
 #include <spl_gpio.h>
+#include <asm/global_data.h>
 #include <asm/io.h>
 
 #include <asm/arch-rockchip/cru.h>
 #include <asm/arch-rockchip/gpio.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 
+#define ROC_PC_MP8859_BUS	"i2c@ff160000"
+#define ROC_PC_MP8859_ADDR	0x66
+#define ROC_PC_PLUS_FDTFILE	"rockchip/rk3399-roc-pc-plus.dtb"
+
+DECLARE_GLOBAL_DATA_PTR;
+
 #ifdef CONFIG_XPL_BUILD
 
 #define PMUGRF_BASE	0xff320000
@@ -54,4 +64,31 @@ void led_setup(void)
 	spl_gpio_output(gpio0, GPIO(BANK_B, 5), 1);
 }
 
+static bool is_roc_pc_plus(void)
+{
+	struct udevice *bus, *dev;
+
+	if (uclass_get_device_by_name(UCLASS_I2C, ROC_PC_MP8859_BUS, &bus))
+		return false;
+
+	return dm_i2c_probe(bus, ROC_PC_MP8859_ADDR, 0, &dev);
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	if (is_roc_pc_plus())
+		return strcmp(name, ROC_PC_PLUS_FDTFILE);
+
+	return strcmp(name, CONFIG_DEFAULT_FDT_FILE);
+}
+
 #endif
+
+int rk_board_late_init(void)
+{
+	if (!fdt_node_check_compatible(gd->fdt_blob, 0,
+				       "firefly,roc-rk3399-pc-plus"))
+		env_set("fdtfile", ROC_PC_PLUS_FDTFILE);
+
+	return 0;
+}
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 1df5cb03adbb..6ef447e0e715 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -3,12 +3,14 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SPL_GPIO=y
+CONFIG_SPL_I2C=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x8000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-roc-pc"
+CONFIG_OF_LIST="rockchip/rk3399-roc-pc rockchip/rk3399-roc-pc-plus"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
@@ -48,6 +50,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_XMC=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 9351a5b8eae7..b565aea311e9 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -81,7 +81,7 @@ List of mainline supported Rockchip boards:
      - 96boards RK3399 Ficus (ficus-rk3399)
      - 96boards Rock960 (rock960-rk3399)
      - Firefly-RK3399 (firefly_rk3399)
-     - Firefly ROC-RK3399-PC
+     - Firefly ROC-RK3399-PC/ROC-RK3399-PC-PLUS (roc-pc-rk3399)
      - FriendlyElec NanoPC-T4 (nanopc-t4-rk3399)
      - FriendlyElec NanoPi M4 (nanopi-m4-rk3399)
      - FriendlyElec NanoPi M4B (nanopi-m4b-rk3399)
-- 
2.43.0

