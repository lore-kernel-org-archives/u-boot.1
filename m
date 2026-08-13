Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDE0C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 631FD409FD;
	Thu, 13 Aug 2026 17:03:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6IMW5njkPLMd; Thu, 13 Aug 2026 17:03:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9855B40A0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786640589;
	bh=NRBFR+srYXHYiogpb3waqrcd6++I9f1HSZfkWom6kcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w7DONoJIXDAWX31Nq+ij+KGm3NxQ0UVnakyEQzT0WRkbKhyJsAcvKDItV23K4sPfM
	 n1k+McfRIWiDA+DXQvqa5oOGg7J/tX7UsmGKPS7A/wuOyTHYBx7oL9rJuCgjKtkT6n
	 cYz4neAVXVdvcN6s3s/nhJR4Vx3W5+riT4qqa/jpyRL410TiPGE0P4O+q9z8aVSBRE
	 4eUJXNkZV6N0ghIkO1xh3Nxzxer0zniOvnV/0MjX/D5/fpd2jJlPnrRR9+2OtXa+gW
	 Xij+gTKYbnTm3xE2Y2Wp073yFryFCfZOT/UeAqS5b8FUpjzxoEsdnstDKlrP4ApM4F
	 VuSp2zIPOHxxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9855B40A0B;
	Thu, 13 Aug 2026 17:03:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 42D15357
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:03:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 28F1E812BD
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:03:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 85lv0QkdYUbg for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 17:03:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A0B758118E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A0B758118E
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A0B758118E
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:03:01 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so88513a91.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 10:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786640581; x=1787245381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NRBFR+srYXHYiogpb3waqrcd6++I9f1HSZfkWom6kcs=;
 b=bME4O4BdTUtnAb0LoHePXhk8+88D1rVQhpWIDSY8bK9uq9oIL8gu3qNr7PwdB8y2jX
 vfc0J1CxU8K6gla3QF6QyemSX9BBHC768Y/3pwT0S8aZOsVYhiMpIfMc0w6SC7UqGxDy
 pgZXq6BHuzcVqQXm669rlx4HY18sUvey6gcmsma4rRnGB9y/4ial7vGRjOqvFEDPMiab
 MAj34qr5r/KI/gSoeuLsZBM36YgEee4KG/ANK+v6lShGdwxcqn+pWlIp9aWWzg7VOTKo
 K+E2nCjdEh1CHc6saEPdU44dd97MLvoU8otlmmCh2HhNTa0T0z7IVi8HaSMLpHBiTADS
 DvKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmT4NN5TZmiQnuXy0xnkJTAfWJqzHPOGUSTHPM1GNVLr3K5dSr+c4hLA9Vu8GlhXu9AwJ/HEY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzjLGLBcD7JXPXeWzmJMGov4913IMyaHUdZefRkncF7GJAxkKfp
 fc6En/n75otZc+4b5MkMjfiPjVtOPFdorGUArpzBND2ZtBw3uUtzaBkg
X-Gm-Gg: AR+sD11QZZDVluYM8Cd+5/DJMvq+RYLp4er4sYICQbDnJkBi3r4y6T5EwsR/XbPt5/h
 xHhxmFyRE17VczW2ae9FLI5Z/veVCIa5JKX9x5r7d3BFUhYj7fOAEwiFhR3woku8QOtrUjZjeXO
 MzYqWt3aC6fbcE1ilibsqgnwL0cbZ9c2GMtAVh8lkE5FJDLL6Qsx6JnFxEnyK2w2Jjsb9ZMLiTI
 OGX6q13cpYDiqP6vaSh+IVtMnVjD4S4mZsXXOQtLPb8Qa/95jwAU0pCi4LTzonJ7coel3IIUa43
 8f7YmoWJPWnO/5L7JYnzL7J3JsVL34bTlWEHV/9mu55DeBC1yXi2DiCR5YhuuO1Ikk3r7x9Z/2N
 sjYyyt5/ekziJPY2vacccaaBSHm0bVMUJN96XrRN4TshgW8hFML5oizwXE8jlmPNa0tNW02t30d
 wJ5M3mczR9QPkC8ifyhEq/gcfRnyqiszd9ASq4DCv4Ji67kRNXfyCh6FZCkfW0+7Rd14BOLZvIb
 aePa4ZroePWKfnULUVCSNLmZSZILx+2oc4zdyCqhRasLn/vAg==
X-Received: by 2002:a17:90a:ec8e:b0:38f:2168:b9cb with SMTP id
 98e67ed59e1d1-3931e09305emr9140455a91.9.1786640580530; 
 Thu, 13 Aug 2026 10:03:00 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a802:463c:b2f8:f8b2:9607:d599])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1413889d914sm92391c88.13.2026.08.13.10.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:02:59 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: u-boot@0leil.net
Cc: trini@konsulko.com, kever.yang@rock-chips.com, sjg@chromium.org,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v6 3/4] rockchip: rk3399: Add ROC-PC-PLUS board detection
Date: Thu, 13 Aug 2026 14:02:45 -0300
Message-ID: <20260813170246.110899-3-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813170246.110899-1-festevam@gmail.com>
References: <20260813170246.110899-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786640581; x=1787245381;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NRBFR+srYXHYiogpb3waqrcd6++I9f1HSZfkWom6kcs=;
 b=kLmbVLnDQgT5dxOtlK12TfLPTEquhKYvlsXdx6EMDcgt0xFNUpgU311h+0iiSW7OJR
 4kiUvNm0POFx4v6MY/ukErzzkmVQgrIaTOqEk5iQz2CEpASVsOwnnK9RwQ9gW0K26ZBz
 hnWCt6Tpt2jVum0lRGBY2BDfc2HOs9GO4h6qsVmaHVX/fvlWipueFXb2L3wV5NLGv0KA
 F63kDV6rmzxW9+twwUiWtFNJGhOtH7X76VOJarEg2j7ax2FF1W6m90P8oMw/tJwxgi5R
 Q5uFZIFkh++chsgz5W1D8OZ+Mps47VOlaN+M0ox7rH17MoQpBjg8vxNN1Lj0Rq6tILFU
 1ImQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=kLmbVLnD
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
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes since v5:
- Fixed inadvertent inversion of dm_i2c_probe().

 arch/arm/dts/rk3399-roc-pc-u-boot.dtsi      |  8 ++++
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c | 42 +++++++++++++++++++++
 configs/roc-pc-rk3399_defconfig             |  3 ++
 doc/board/rockchip/rockchip.rst             |  2 +-
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
index a85e9549c83..e7e4a2c8907 100644
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
index 6937a27176f..8f54e526c19 100644
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
@@ -54,4 +64,36 @@ void led_setup(void)
 	spl_gpio_output(gpio0, GPIO(BANK_B, 5), 1);
 }
 
+static bool is_roc_pc_plus(void)
+{
+	struct udevice *bus, *dev;
+
+	if (!(CONFIG_IS_ENABLED(I2C) && CONFIG_IS_ENABLED(DM_I2C)))
+		return false;
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
+	else
+		env_set("fdtfile", CONFIG_DEFAULT_FDT_FILE);
+
+	return 0;
+}
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 1df5cb03adb..53182dc8251 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -26,6 +26,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_I2C=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
@@ -37,6 +38,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIST="rockchip/rk3399-roc-pc rockchip/rk3399-roc-pc-plus"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
@@ -49,6 +51,7 @@ CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XMC=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de2df3046e2..d9c4b753949 100644
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

