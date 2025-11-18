Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44D0CED63B
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ECD683D9F;
	Tue, 18 Nov 2025 14:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2UZQLM6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA92483CF3; Tue, 18 Nov 2025 11:42:20 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04CFE83CDF
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b739b3fc2a0so299135466b.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462538; x=1764067338;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Iom/guv4dIhTbUav8mlCa12BEDkzcHh53HWYurG3w6o=;
 b=2UZQLM6TjIea20x2PlmuZUyjh6GEXnDhTX1gSglksf7lCF0FpmQO7SajFGTvia/fSm
 uDZC0LEQ79zlWr+RBx+f/9RwHEPSG1GmmJT6juABJmsV41BJMItWhou/7/w5ZZB/XRB0
 KhpX6OeJsPyd3vwEeGS9exhKa0V4UX3cfFg6zLgxHV4WRriaz6WSLoqaENbF3ZwzMWCm
 W/FYFBoP9dV8UJaF+SCifDHNPJv9BzEpfmU7jZKeY0wf3XA2u/3yA9UE970rRUeUg+tb
 S07iLvc9ttH3mf/CYWgRP0RpuN+5dKISUPplcZEm9gu/PpKtRNpLvf58HEalIrG5CajB
 yv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462538; x=1764067338;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Iom/guv4dIhTbUav8mlCa12BEDkzcHh53HWYurG3w6o=;
 b=wnlG3HQ92LVEd9zc3hBGkx0Kob0ibvb2CorT8xhykKJiry/mpHJrmBlsN0DmFWydKZ
 +ERjG8hSWXwM1jmrNhq55ngwfKBqVUhzNleWWsNkyGevWNMOQZhj144n0RW/yuu+8AdT
 2bu66hDdP3kS+6PTPu7nP8mFG3O8UJkZrXkuJHJyjTHNJQb6B7P+GPtDlkPQ46NBalMg
 g9rKfhUW0Tt0tnPcfxQ9ip6urQo+k+xhkLieb59RzqtnxhaH5gru1RXKbXvbZL9K59mD
 0PtzS/EYGHMZLeqJsESTxLl/oXdOxc4gh1tI24WRkYoU9hdpxSGnyQ0zv1vMmAoIypAD
 gtxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDs+z1Fz5gfcfgrmTJBm2baEydmHTm00fE599kUmjzn1o5hTPw3UO4K/KndW2MMIZHDxvHYhY=@lists.denx.de
X-Gm-Message-State: AOJu0YwMJN04Ex1PXosa49b7LCzRA+JqseMdWRrd4qJ+EIpZkrWujZh0
 kEeDgCgpmDh8BgiAue9R7wjBJihibsq2g+iiR5Zn98I9zqnFX7MOvWGBin4tWy1NyUY=
X-Gm-Gg: ASbGncvfF+nQHYQovVFCxheuD2qXxr2s4NKOE9OjPFG6cEccnE3VpM3lRmycsSOaSH0
 ZqM/LjkN9ECjFm6Vs0z1CfC33Yhx4CW46de/0CjJsgJxdLKDELvDO2fOcRoZj+GFwdCKGBjQIIp
 7nK4vrsR71Qrsqdy3gdL0q20EPXb8uLiqgxIWIpk5UHsDIrdtWFWlArekbtXgXVK58xtk04cNIx
 fP+DMxxUEtp19gqoeFgrHO+xaAxW1CQvkBzedht1JQS0yU5zRwJhDNcCNGfo1Nk5OV5HgEy0WiC
 K563Ko1kmHwGj/EOVEbIgycfl1Pg3MKAffK0MkPP+Efm7G92Ir9mcttOcDN4wbc40N4zXPhGusi
 fTmeyTtiXMZKyOkMQJ+RGmTqDAzN90w5R7ibklZZFngk23TxyeWIiqMLbr7GxBDiT6FxkzQ/Z
X-Google-Smtp-Source: AGHT+IF29KqnmhNuF1YyrwlcZuxfkvydZsH/SUWO7bBEFfA7NZXtV5giDqd8QbHrhlJQAMaToizLvQ==
X-Received: by 2002:a17:907:1b20:b0:b6d:3fc9:e60c with SMTP id
 a640c23a62f3a-b736780c131mr1679615366b.20.1763462538420; 
 Tue, 18 Nov 2025 02:42:18 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fad4494sm1308563966b.18.2025.11.18.02.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:17 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 18 Nov 2025 11:40:24 +0100
Subject: [PATCH 04/15] configs: am335x_evm_defconfig: Enable panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-4-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=msp@baylibre.com;
 h=from:subject:message-id; bh=/cVXpbo9y1WYsRjaoC53RzA1V/D67hjkcX/2Iz6Vdi4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZX1f7w8cTvHU+f1uW3M+cfaR/6otpbSzNVc5+kefeW
 GwXZHjYUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABN5V8rwP8plRkDske1TeiP2
 7L62v1fDOI8tpZ6RY+2Xlcp3vkyd28Dwv871odu+tK92FXV7FpfO1vBc0jtX5vHciczO2hZ3P13
 RZwQA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
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

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
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
2.51.0

