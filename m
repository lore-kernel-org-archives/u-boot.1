Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4F8D5E37F
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 20:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C586F89326;
	Sat,  9 Nov 2024 21:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yn/+pLfY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D7D18929F; Sat,  9 Nov 2024 21:06:25 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 988098929F
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 21:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-460c1ba306bso23999271cf.2
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 12:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731182782; x=1731787582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EkCLruBBG3FL1pkXxpxV8B0XKU1ot29MDmsZt8rMaqo=;
 b=Yn/+pLfY0D2TpzGcaOatCkf6kGRueEe7a8FZMuWdCe1sHR09H/IrhqfhvTwG10HmW9
 KJICTyAwWyaAUifl7V7JIlN3COCY2XiN4fLhYL8zsHJSOSQtbHqsv8bPQwCQKA3PIZfP
 WeX49eTohY7hHhB3S9G6EgfIOKJ/hQNyfGzzVRhMaIrPrqOlwXQd27valk+X8o4+JHuN
 XQrC9/YrNCBQEeaft9CnPJ8o56BhTsh4lCBOUmQ0RyUDbBBi87B/Ctg5MP+L59Q+bCp8
 cJ9eck/7gIXJtcXJDoKuYRWQYJtEb65eJqZxVSOXyDVnI62/Ncy+JgVuFuXfOFjUY2Hu
 Druw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731182782; x=1731787582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EkCLruBBG3FL1pkXxpxV8B0XKU1ot29MDmsZt8rMaqo=;
 b=sB7bbkkcayBDS3RyREGa5S03RMh+vlgVKwZy/Ay8AXLEuR/YO1VXYOVrflEz0YBI6J
 k2BQLBBzIZE0a+IttZ1bZ7Qz5J4jf/i6zDkZHxdiHLoQkPx3e44W29sS1jF6NubzfEsj
 mz3RLpWYiMsK9t6vunqBNr24GraQDTqasnnMB5qblqu/mROR3BATHvnYeKeKgzO324jf
 twMg91Z114BuYGHNNWqdGoJtCkWCfM66PIwpSHMRs0qBPEjDRrNOcPHrQqunEldMxBuq
 bNVaOLcT9Q9BVYQxtKp8fxgMJQymwcESQ2s2VU7N0wEdMKEJcoWK051LDqkkkaUj2FGA
 6uiA==
X-Gm-Message-State: AOJu0YxM76s9ZPo64v5NyfbTx77mADNI9tMjul3BfjheK6FKCZKdDJWt
 ugqIFfA66qQa27ZPQfy8HPfONqgVn1WhnKqYdLZNvxiBj1cCnUP8Q0+HJQ==
X-Google-Smtp-Source: AGHT+IGV5mJSE4nLZqnJ6O2BE+71RQArAen+5rF95NY1XhuRuRfbgabt73YJHEneVtfFnYNBYBZBnQ==
X-Received: by 2002:ac8:5a4e:0:b0:460:abf3:c454 with SMTP id
 d75a77b69052e-463093471dfmr118485871cf.18.1731182782168; 
 Sat, 09 Nov 2024 12:06:22 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ff5d678asm36525341cf.85.2024.11.09.12.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 12:06:21 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, lukma@denx.de, Adam Ford <aford173@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 2/4] configs: imx8mn_beacon: Enable FSPI_CONF_HEADER
Date: Sat,  9 Nov 2024 14:06:03 -0600
Message-ID: <20241109200610.1615430-3-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241109200610.1615430-1-aford173@gmail.com>
References: <20241109200610.1615430-1-aford173@gmail.com>
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

The binman device tree can generate both the FSPI version and
the SD/eMMC binaries at the same time.  Since the imx8mn_beacon
board supports the FSPI booting, enable the config option.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 configs/imx8mn_beacon_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defconfig
index aa8341226a..6f66d3e748 100644
--- a/configs/imx8mn_beacon_defconfig
+++ b/configs/imx8mn_beacon_defconfig
@@ -149,3 +149,5 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_IMX_WATCHDOG=y
+CONFIG_FSPI_CONF_HEADER=y
+CONFIG_FSPI_CONF_FILE="fspi_header.bin"
-- 
2.45.2

