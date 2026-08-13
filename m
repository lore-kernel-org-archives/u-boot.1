Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585FFC5CFDB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 11:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF832811EE;
	Thu, 13 Aug 2026 11:45:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mPowzYDZIt39; Thu, 13 Aug 2026 11:45:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3187F81168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786621503;
	bh=oHCU6rLxvj5zuE4ImCYKW5wlQuGvww6hFH8A6y3tsbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lCE6v5kNj1SkNnBPrba+ZqYsXqiHA7TonDSvhrzFK6pMzTkEsSmeXizgDzmI3Bjrh
	 +OZvkHnFZRDEGdN/Vr5JHbdeybF6AnkR6lJsMGAI1ub5ykvBD7nd7YzSqkqptPh3jG
	 8bc9GrxvRGTURYP5/G1+CZRpa+BF0yYiD2bLfFQ6iJUG7z1AmmPL8L1BCi4vINKhrr
	 zlc4msAI523qoi/+0bvSY6kfRPcpm2Ny1mqLFyMVYe3oZeaDVxrf36RqCHSwolJrml
	 d5b9FSxHqDvw+F1wv0LDUWgBSmK51l8+wl5TUMRm/ji3Fdo8Ok8mDDKdwUSvJ6FQkJ
	 nm4fRW6VXXykg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3187F81168;
	Thu, 13 Aug 2026 11:45:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 13B94109
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 11:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 052B18116C
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 11:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3UNj7kG235Zp for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 11:45:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4535081160
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4535081160
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4535081160
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 11:45:01 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cbe827e3cb4so2144415a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 04:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786621500; x=1787226300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oHCU6rLxvj5zuE4ImCYKW5wlQuGvww6hFH8A6y3tsbA=;
 b=r8Rq+MTvnEXamEHll/GVGs+F14uVBMioHGw/xdyVFpVJ/lWNJi/TFBscbR3mifLbtR
 zSxGys8PFGGE2ZAdqfpdvk0IrgZSA1hMaK3R9WXAyrcx7psXB9me3oT0yHatDxQU/vYv
 l5g2pDrNV1Hk3yXI8thdsEf3I8HNlh9BIoxbuul3s0nTmGA8A5jJS3DofnezyEd6bGI5
 JA0jO23sSOfKuuf7YSc1uNQaZ3J+6Vtw+0h/qcyKM1/gpIEvw0/2ON/ys+PH/dkN+yM2
 xuv/V/ZNwcbW7utfDIBp5qAKgbeHxC9H6JRwAQEIKCakDpzXoKeKSA6zwYpxKWFZHGVg
 rLOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0CzCwp1CYuAxLDwGpP4kU9gEu8qgRwfOW9Oo27Z48mUeJSXb7rcMRtXLb2C4IQzx0Fn/vj2U=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzKevNlpfnQe45+sofGRr1PBzCet92K1PMxu197RVxwbgJtpM2O
 Ck3r01CU0N2LTJ3De3VXz3D5/kpQntcKAwZgjIK3UqYW4S2Ph00ZOsXxh1kaiQ==
X-Gm-Gg: AR+sD12ezhOUb01EJ3Dm3i8ybjMpHIvjm+qQyWcFQupX198LmGP5gQQYyQCKzP+2XeN
 9VwAQP1saaSYcKik0zZksTIjLi0vmoTeGoTmZ2qXh2DGYy6E8IJeBn9ce66V3Oirfz9YuDN1byq
 Ny4rV6hIfo1oXWVjFYoClGf0ENjtX4orFBa5Ccjc+avK3Nsy/Dj7ujBNA9xm7iY8M/RhGucX4kJ
 K/b/uRi0ZNuDIZc5Q02oA5YlN/72rc5iwl6Cqw32KzvcNO7Eyx33KHgB8psVdebV32geNpulpsL
 w9lvum/rkVpcTd650iMqJYPMDlEEwtnD5+9Qd2EVx8gMfoGokwAPdhcKStzU7XxkOg0jSMKjf0C
 Zu4PfbjarQOD3XOTrW8YSTzKpvax3+jl67QIK6d/s223+Bc3JFogiYFxN3lM04gAS76lUHi5tAO
 sEUWzWPWq+K5iItxJtgFMdTtUqH7D1Jbkfa3q3vXj6lpa0Ww5BZnF4VD0czMLeO458FHFSvRPRW
 YiloxwviwzjK1qkDGWk2EoFrz/5kovT2Mf1ug==
X-Received: by 2002:a05:6a21:50f:b0:3bf:a7d5:df38 with SMTP id
 adf61e73a8af0-3cc54ffff10mr7698125637.9.1786621500261; 
 Thu, 13 Aug 2026 04:45:00 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a802:463c:b2f8:f8b2:9607:d599])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721aceasm918764a12.25.2026.08.13.04.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:44:59 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v5 3/4] rockchip: rk3399: Add ROC-PC-PLUS board detection
Date: Thu, 13 Aug 2026 08:44:44 -0300
Message-ID: <20260813114445.51640-3-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813114445.51640-1-festevam@gmail.com>
References: <20260813114445.51640-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786621500; x=1787226300;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oHCU6rLxvj5zuE4ImCYKW5wlQuGvww6hFH8A6y3tsbA=;
 b=jgInV0ay9sD0wEsG3ZpB+aDTBRop24pGzKVnjygYKZSpMk7ZY/25mLxrmSwQYu+iLc
 gohy6vgXV1x+gMckN74ONN+Sq1Dbdlikbp1c0qVBrrbSS4+Bb6x3Dlry3JuXNp91TOIW
 6GSZNREi0lQvpocZYOAzrmOlA6C7G95vOkCpNReb8GhxNCGfALrpA/uAudkoL8dpLiNX
 jcgfKaNGHICU26C4n3B8u8mlfSRowdKYmhgIZVoTLUnOR0aVrTNLuInCFxpMZMkIo9sC
 vLrkaGLP5DT9K8zOfTOUmQVMKiOSdO6gqfzLet3OrAzH2ZwIfWfjfZjB/ob2uHHuIxem
 w+Mw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jgInV0ay
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
Changes since v4:
- Fixed mezzanine build error.

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
+	return !dm_i2c_probe(bus, ROC_PC_MP8859_ADDR, 0, &dev);
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

