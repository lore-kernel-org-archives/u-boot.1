Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244AAC27C77
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F259889DE;
	Fri, 14 Jun 2024 16:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gSlLTxK6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEAA5889F1; Fri, 14 Jun 2024 16:21:19 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB66688950
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1F0683FE1A
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718374877;
 bh=1slP/PVqpNE//HuKNJjPhlbtFYjL75aqZRfaYtiQxJc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=gSlLTxK6lReJbjnEoo1TKDT2QTbbe4Acz5xRPqceUpOBe3PdI/0XE2BZmX4QHWTu6
 HkrygTUaNgqUYe0EElI+Kp1K4pEjjXTG5l43NiM6y28QE8gwFHfCp/wkw9KbnicbJK
 +4tVeNpXncUCxly0+xd+XaL8QLNYCEAVwoBT3tF3dx7JdE9l2FZLqGXCN9h0VQhByn
 3emwuo/ZW8kIsri58vlWDLHRsnCmQzMluHWz7qoSuhry8sKrmuWqagox6SQ4UGeRNe
 TDMRH1pd68KJCS2TKSmScK2a/rG2gNHOLOc5Snkgy/aHHJblGMaCpcq2+djxuZrYuK
 wegQj1QCHz+Kg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-421e17ae038so18472485e9.0
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 07:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718374876; x=1718979676;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1slP/PVqpNE//HuKNJjPhlbtFYjL75aqZRfaYtiQxJc=;
 b=aKo1b2d5BA3fH45EvkbpX7DVqYCexIz8yKhSooJ0qgMz+OGNhle1bWXkV5rGyDWzXX
 h1xED0EfSrgUdcpHfYa04vxssAeVo0l/imMCbPQW2hRm8P7MP514OurnMzUnygV5BWNG
 ur5/2/c5QhtoC92tM+NYNX6GYTfmnjxxAreJlP1yeeK0grSYo10ciOUQLqsRs2xmbu+1
 KLzJtIbbKEK7csIMCBS6q5GfP+zEADaFtbnteZ+7vUR550HL/7tbfJRq6rBczLI/JeIL
 booqtxAFobI3u+lsUQ5KZfWxVuDQGrkYU0Iv7TQFrwdTXkLCroNFIkDr58+nQW4Pu76o
 AdSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+ScIBCyg9ArvTEGhDLO4tFX6k3Td1xdiMeHC8sJl7dAlcfiuOm1mH5oAGd7T2a9D9GLHzPI6qmHEE2BCSrekjCWkYvw==
X-Gm-Message-State: AOJu0YwXJesYa0mSh4VdNU4kw0G6sgnekYBxts4ijdedTk1Elgqry3ox
 iZAjN0ayjFWWhwp7VNXIfvv0JgprZKbQ7FaOpWb0rxf/h02Hf6BU9CjJ9mfTkWnCZsh33eoL93D
 p9KaAtHR0c01l6MXtdCJT8H9+5YHgKoWKtmux+o/1hJ9F7ZWStvHZBAFhN23lirN8tWc=
X-Received: by 2002:a05:600c:19d1:b0:41f:b0e7:f299 with SMTP id
 5b1f17b1804b1-42304826452mr21375195e9.9.1718374876735; 
 Fri, 14 Jun 2024 07:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHQchuVFCq1fXwWGJlYCeIhkSKdW2kH+PKK8hpCqvh1NgEvjFUECRpSXErDKy4l1kUxWGwAA==
X-Received: by 2002:a05:600c:19d1:b0:41f:b0e7:f299 with SMTP id
 5b1f17b1804b1-42304826452mr21374985e9.9.1718374876290; 
 Fri, 14 Jun 2024 07:21:16 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-178-202-041-025.um47.pools.vodafone-ip.de. [178.202.41.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286eef9c1sm100171065e9.7.2024.06.14.07.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 07:21:15 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, Conor Dooley <conor.dooley@microchip.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] mmc: consider cd-gpios in Synopsys DesignWare driver
Date: Fri, 14 Jun 2024 16:21:02 +0200
Message-ID: <20240614142102.123715-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

The JH7110 SoC uses a GPIO for card detect.

* In the of_to_plat function check if a cd-gpios definition exists and
  request the GPIO.
* In the getcd function return the GPIO value in this case.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/mmc/snps_dw_mmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/snps_dw_mmc.c b/drivers/mmc/snps_dw_mmc.c
index 9bdbe5070b1..2f0133f22c9 100644
--- a/drivers/mmc/snps_dw_mmc.c
+++ b/drivers/mmc/snps_dw_mmc.c
@@ -12,6 +12,7 @@
 #include <dwmmc.h>
 #include <errno.h>
 #include <fdtdec.h>
+#include <asm/gpio.h>
 #include <dm/device_compat.h>
 #include <linux/libfdt.h>
 #include <linux/err.h>
@@ -29,6 +30,7 @@ struct snps_dwmci_plat {
 struct snps_dwmci_priv_data {
 	struct dwmci_host	host;
 	u32			f_max;
+	struct gpio_desc	cd_gpio;
 };
 
 static int snps_dwmmc_clk_setup(struct udevice *dev)
@@ -106,6 +108,8 @@ static int snps_dwmmc_of_to_plat(struct udevice *dev)
 	if (!ret && priv->f_max < CLOCK_MIN)
 		return -EINVAL;
 
+	gpio_request_by_name(dev, "cd-gpios", 0, &priv->cd_gpio, GPIOD_IS_IN);
+
 	host->fifo_mode = dev_read_bool(dev, "fifo-mode");
 	host->name = dev->name;
 	host->dev_index = 0;
@@ -119,6 +123,9 @@ int snps_dwmmc_getcd(struct udevice *dev)
 	struct snps_dwmci_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
 
+	if (dm_gpio_is_valid(&priv->cd_gpio))
+		return dm_gpio_get_value(&priv->cd_gpio);
+
 	return !(dwmci_readl(host, DWMCI_CDETECT) & 1);
 }
 
-- 
2.43.0

