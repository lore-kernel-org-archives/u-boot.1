Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73083F9EDE8
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B04D68431E;
	Wed, 22 Apr 2026 16:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PWzHZEUI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F4E984390; Wed, 22 Apr 2026 16:32:18 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B703584324
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:32:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-50d87610513so61403581cf.3
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868331; x=1777473131; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DKyP1GeLlM2HxM5e4ojKxbvYqrComSgv0WjNQBya5w=;
 b=PWzHZEUInl/RPTqcCfKT+PnduG10vXZJ74PRFWL6avfwbwzXco9EjFl3doAPfcXY9j
 LFqOx+irDmhDqAzswW9Y2HIx6D2BR0jeBtUQ5niZs1r8rzUiT1vdvNq2xfXJU31strtQ
 l23RO+f4il5OPE9g7dZ2NneQKgLvTzDqIwhEa9HqhjXV3FYEwgFfz+ltTW8Cx9E1zU9r
 nd3GwYxGvhdkBxgmR4jRC6sR8wJR/xtsNhwDTIREi/xI1FojHy5yFPOzHqVAK+VDGA8b
 YLCuPoPdLzl8zzyuf0gqUc8IwF/UXJDBnvaAfcPH7MWsSebUy/d5v59SYZT3Ea6GVJK5
 kOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868331; x=1777473131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3DKyP1GeLlM2HxM5e4ojKxbvYqrComSgv0WjNQBya5w=;
 b=BdK8PMNmSi9edh9wnF+aTImArjqrs9hTa33cJOGaooxcn8zZK36pHup7c2OE/85AzU
 xaeWm1rZN27pivFZj3a6/13V5/KbjxU0NYJD9BB0btuSBytPAicGY3FkOUOkACrBqE/0
 b2WX+njsdb3XrP1/ECT/94oOkFWljkDIxNz90lwnovC6GFSwSLmX+xnAFu+SQRFczeZR
 rOZUcKIT90pSi7hgQXKTwyLTKdfU1+ue6CEzO/DVFqGANa9I45w8s5+/byec16MzcZRY
 R0GLkMgYVuSzYr1sw3QJQAzYcRmlFUWSb+TLn4ResAgVnz/alP2h01wiFwLwQbZ4eYaK
 DL/w==
X-Gm-Message-State: AOJu0YxpRN0q2iBdKmkeeA0AwwzIKeMg2xdsPpaZpZ+0UWpYyvNmNBmI
 SDHZUNzaUpATe6DRwq6XRADKSLUWCqQ5iwkSag7ZMJGvhb9OKWWLRROy217hY7MD7SE=
X-Gm-Gg: AeBDieuz6Lpy8ElELL1bbA3JnfzfX6ROC58c2ldSkHam5mKOOIl4lKovW+gqhbxpqm4
 i1ULNosEGHF2tVqLz/+Z6VgVLgGN4GtqaScw33PTeNcM+FeC+TgKqwwCci7udnYUm3bZpupKNO9
 mxU7Jus2Rqk+3xA5BEWhDOh2w1LlFB0YIJbu8eSgMAdAG6OoQxuvPd+ow4DeX6PesSmye6l8Bb3
 UPc9WMVPZVJr4IA+oiQLKMALv8GcM2ogmJy66oGF01KkZbLFEqklU9YtOk831CV1l2qTuQJehJJ
 p4c+D+MYxrGLC3H9DewawwvPFPTEAT3E25kfL/2S/cc1muBCCrQfY5hKXshr+rXGILcd5Ilq7Uj
 IwGw5lB6GR71N02U+wMhJPezY00ZNAEd91oPNHArnDXDXLlosjdgoLMuH8N2PuNcM3GPPCDpnQ0
 zmhbwYYRm0j04dhF2zz/z4nN11xnu1rduUHM6Y5zaFjTVQuIFNIafjcAKZyR70eLdvhm40rqqZ4
 5Vs2oyjWqYtyIaAIBqgBKUgmSuC6j/+
X-Received: by 2002:a05:622a:5147:b0:50e:631c:c38d with SMTP id
 d75a77b69052e-50e631cc483mr165465571cf.46.1776868331274; 
 Wed, 22 Apr 2026 07:32:11 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:32:10 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 16/16] spacemit: k1: rename device tree prefix from "k1-" to
 "k1_"
Date: Wed, 22 Apr 2026 10:31:12 -0400
Message-Id: <20260422143112.1329478-17-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260422143112.1329478-1-raymondmaoca@gmail.com>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

This change replaces the hyphen ("-") in the DTS prefix with an
underscore ("_") for consistency with other prefixes in the
Spacemit K1 SoC platform.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 arch/riscv/dts/Makefile                                   | 2 +-
 arch/riscv/dts/{k1-bananapi-f3.dts => k1_bananapi-f3.dts} | 2 +-
 arch/riscv/dts/{k1-muse-pi-pro.dts => k1_muse-pi-pro.dts} | 0
 arch/riscv/dts/{k1-pinctrl.dtsi => k1_pinctrl.dtsi}       | 0
 arch/riscv/dts/{k1-spl.dts => k1_spl.dts}                 | 0
 board/spacemit/k1/spl.c                                   | 2 +-
 configs/spacemit_k1_defconfig                             | 4 ++--
 7 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/riscv/dts/{k1-bananapi-f3.dts => k1_bananapi-f3.dts} (99%)
 rename arch/riscv/dts/{k1-muse-pi-pro.dts => k1_muse-pi-pro.dts} (100%)
 rename arch/riscv/dts/{k1-pinctrl.dtsi => k1_pinctrl.dtsi} (100%)
 rename arch/riscv/dts/{k1-spl.dts => k1_spl.dts} (100%)

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 22b62e25d4d..3827ff72215 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -9,7 +9,7 @@ dtb-$(CONFIG_TARGET_LICHEERV_NANO) += sg2002-licheerv-nano-b.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
 dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
-dtb-$(CONFIG_TARGET_SPACEMIT_K1) += k1-bananapi-f3.dtb k1-muse-pi-pro.dtb k1-spl.dtb
+dtb-$(CONFIG_TARGET_SPACEMIT_K1) += k1_bananapi-f3.dtb k1_muse-pi-pro.dtb k1_spl.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv64.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-binman.dtb
diff --git a/arch/riscv/dts/k1-bananapi-f3.dts b/arch/riscv/dts/k1_bananapi-f3.dts
similarity index 99%
rename from arch/riscv/dts/k1-bananapi-f3.dts
rename to arch/riscv/dts/k1_bananapi-f3.dts
index ea11029c182..bcb5be5f1bc 100644
--- a/arch/riscv/dts/k1-bananapi-f3.dts
+++ b/arch/riscv/dts/k1_bananapi-f3.dts
@@ -5,7 +5,7 @@
 
 #include "k1.dtsi"
 #include "binman.dtsi"
-#include "k1-pinctrl.dtsi"
+#include "k1_pinctrl.dtsi"
 
 / {
 	model = "Banana Pi BPI-F3";
diff --git a/arch/riscv/dts/k1-muse-pi-pro.dts b/arch/riscv/dts/k1_muse-pi-pro.dts
similarity index 100%
rename from arch/riscv/dts/k1-muse-pi-pro.dts
rename to arch/riscv/dts/k1_muse-pi-pro.dts
diff --git a/arch/riscv/dts/k1-pinctrl.dtsi b/arch/riscv/dts/k1_pinctrl.dtsi
similarity index 100%
rename from arch/riscv/dts/k1-pinctrl.dtsi
rename to arch/riscv/dts/k1_pinctrl.dtsi
diff --git a/arch/riscv/dts/k1-spl.dts b/arch/riscv/dts/k1_spl.dts
similarity index 100%
rename from arch/riscv/dts/k1-spl.dts
rename to arch/riscv/dts/k1_spl.dts
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 2556dfe047a..b8e1327dc57 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -374,7 +374,7 @@ int board_fit_config_name_match(const char *name)
 
 	memset(fdt_name, 0, I2C_BUF_SIZE);
 	if (!strncmp(product_name, "k1-x_", 5)) {
-		snprintf(fdt_name, I2C_BUF_SIZE, "%s-%s", "k1",
+		snprintf(fdt_name, I2C_BUF_SIZE, "%s_%s", "k1",
 			 &product_name[5]);
 	}
 	for (i = 0; i < I2C_BUF_SIZE; i++) {
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 13f055cdf53..ddd0c959c12 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -3,8 +3,8 @@ CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
-CONFIG_DEFAULT_DEVICE_TREE="k1-spl"
-CONFIG_OF_LIST="k1-bananapi-f3 k1-muse-pi-pro"
+CONFIG_DEFAULT_DEVICE_TREE="k1_spl"
+CONFIG_OF_LIST="k1_bananapi-f3 k1_muse-pi-pro"
 CONFIG_SPL=y
 CONFIG_SPL_TEXT_BASE=0xc0801000
 CONFIG_SPL_MAX_SIZE=0x33000
-- 
2.25.1

