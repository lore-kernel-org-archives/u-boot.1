Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADAFF4485A
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 13:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC89841A2;
	Fri, 10 Apr 2026 15:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="mGzt5R8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F25C8419C; Fri, 10 Apr 2026 15:32:55 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44F288412A
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43cf3ee0fc1so1250542f8f.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775827973; x=1776432773;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JPkQh1mbXFukhjglZ5Uz+w/yM9Y4YzDZBiDwcE/KMjw=;
 b=mGzt5R8cdBZlt0M7AFESPDKx3yX1Aa22NdkTjbM59vJJnAQEKi3jqLzdr3qkaduRUJ
 qXtDN/8crS5WXlVhlxMe1udHhlLlz845NtoGRsG7jsH6ZVnCaA6erX+4LW0jJ5QMmkvf
 JIHGazft3hy4ODYB/0DZQ7tAsvLsJcDQOQDKqUoIIwczWppb4ToZ26a5v6SiYbWvDbes
 X+Vo/4A4XTnIQXrC3xkiAbrSypbAYnrfCFwYEp5LORmW4peaDtHI/8Suqn5MgrEKyHi5
 vuHzaooAjaneSBwBgT91GfkZBmwWuf54ia5OJ+S5ngKAS+fXqYYMB2xWN0yXpJSccbXc
 gqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775827973; x=1776432773;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JPkQh1mbXFukhjglZ5Uz+w/yM9Y4YzDZBiDwcE/KMjw=;
 b=beYJhIGNliFRN8Ntk1/W4aETwylb2R1fIAsHyvHX2mkFyYs2nxDZUkpzllJVJ6fjWE
 jB1z8/VFTYfiU6814kYZ+D+axhIk/TtLKO4eNtvK9A1953znvm+pyHQEuqCdKMcu1wty
 tdfGwrZwqKAlxnMOampqk7WR0oIkKA6JI1eEqDJndeCWMEbvfGUk5cnIUNxn0qzK/kCp
 1Gt06RhLU2pB6YUkr7uPyN+wmA02EUqJccxT4O7OX+rLU74zLd5SsN77B0VZlnL1dWfP
 nVye/tyhC0D2RERwO0v6s0VQp51NddV/fEgtiX/oS4box8ThKT2/+ttpMho8SqBi8K5m
 wmWg==
X-Gm-Message-State: AOJu0Yw9XLXit0G7bPJhqJK+mCtAKHIIl5frZwkyvlKqPLCkSAkO+O3s
 hc2/ozGOL4H+XXssEiPw5zi11UZGWW6rvw1MEodxJMCdMRRUY/6VNiimUzEWEGQYQ4A=
X-Gm-Gg: AeBDievJHDNn5lfWF9DpC87gsBWnaa9gwcjclIrw+0zHOSg51wl1+R50T+Ur38VK17G
 3mdaJDG0OhSjC3Lf9hvTW176dKRNUSZH2Mz0eZetgj4CVhclB0qgb37r2I4PAco02wQzqlJ2tbR
 sfDMpqW8dvCPqyqtI1WKnCVxD2OxycL2HRN2TZc4/NS4E2dyWyFqZn+jqYCiqx36YauY8gloRiU
 DVqOQYu9wfayIGImrSZHp8AwAfLO5AibDwmFsYjup7P1JbcIUCl2HMMrxf3u9iqI4h5Xbfh1vay
 hUFlcfsQcMjd81jTmD10Ezeyep5BMqLVvmuJVmLsMp1NjZDQmOwPimwQZ6PmAvvjSFtmV1t3BwV
 d9EanBsphvjgXkfxDewmUZBsyuCuXYG3NVaShjVNJj18nZ6lrCBtundC1h/Gh5nJQ1zde1ra8W5
 LeEr+AnkxdUA5A9RDWAfcotNyJngiENnE=
X-Received: by 2002:a05:6000:2482:b0:43c:f81f:3e7b with SMTP id
 ffacd0b85a97d-43d6492f775mr4210202f8f.6.1775827972639; 
 Fri, 10 Apr 2026 06:32:52 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e50044sm7521093f8f.25.2026.04.10.06.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:32:52 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 10 Apr 2026 15:31:42 +0200
Subject: [PATCH v5 02/12] configs: am335x_evm_defconfig: Enable panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-topic-am33-evm-oftree-v2026-01-v5-2-4b9c7aca0e3e@baylibre.com>
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
In-Reply-To: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=msp@baylibre.com;
 h=from:subject:message-id; bh=4ukWTPl11dA7ju943KsRIXw4k3rBB8rkirnMzkQwus4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbv091Bc6xdXm7/5rlneRNfvHfuhjPHkxa6aC0NKFFw
 T5edsWhjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjI09sM/2NWSb0482TaU2V+
 1w9x7xh/PTDZ6vPB9hpn4KSzelViIvWMDMdftfwwXcV8bqunX0u9a+6uY92b1qeafcx0c689+sH
 qMycA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Enable LCD panel support on am335x-evm:
 - CLK_CCF and CLK_TI_* for display clock tree
 - DM_PWM and PWM_TI_ECAP for backlight control
 - VIDEO and AM335X_LCD for display controller

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 configs/am335x_evm_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 5a3e0530a31663faf565e0afeede5765be16985b..bd188c252780fb541afbbe61a243bddaab79be93 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -60,8 +60,14 @@ CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_SYS_BOOTCOUNT_BE=y
+CONFIG_CLK=y
+CONFIG_CLK_CCF=y
 CONFIG_CLK_CDCE9XX=y
+CONFIG_CLK_TI_AM3_DPLL=y
 CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_NAND=y
@@ -71,6 +77,7 @@ CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=1
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_DM_I2C=y
+CONFIG_MISC=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 # CONFIG_MMC_HW_PARTITIONING is not set
 CONFIG_MMC_OMAP_HS=y
@@ -95,6 +102,8 @@ CONFIG_DM_PMIC=y
 # CONFIG_SPL_DM_PMIC is not set
 CONFIG_PMIC_TPS65217=y
 CONFIG_SPL_POWER_TPS65910=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_TI_ECAP=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_OMAP3_SPI=y
@@ -113,6 +122,8 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
 CONFIG_USB_ETHER=y
 CONFIG_SPL_USB_ETHER=y
+CONFIG_VIDEO=y
+CONFIG_AM335X_LCD=y
 CONFIG_WDT=y
 # CONFIG_SPL_WDT is not set
 CONFIG_DYNAMIC_CRC_TABLE=y

-- 
2.53.0

