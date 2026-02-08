Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA356EF06E8
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 04:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB01838FA;
	Sun,  8 Feb 2026 05:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="emKkse5o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC918366F; Sun,  8 Feb 2026 05:18:15 +0100 (CET)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2579839A5
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 05:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-12460a7caa2so2243381c88.1
 for <u-boot@lists.denx.de>; Sat, 07 Feb 2026 20:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770524291; x=1771129091; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KUPi70+djz5/qbyHUO97v+jwVbwvWXxE3kT/n/ARpQQ=;
 b=emKkse5o5HlLEXqyRnbVyo21/xyGXLEkJ8VS/bfM9QDV5Dw99emVKhr8RyGQhP9mBI
 gMK/PHkiGlpBH+nwrHs0xRMeMG3FAl85tx4ukqfP0VizGxH6qtghtv5BaVjVksIkMYjX
 rXgAMFrGoyeLHpwZNniXgme/xeGnQFhJlkZaKDg0vMCcZVEacqvE0nrTjwlvNNBX6u98
 Xy5TM00DL72ECjpAVH/pBFy4tywcoySpInssdsQUQqi0hC6XRJvnzjHOa0MAWeSZYCzK
 XDYKX2zPCDsOvn5bPqJgeCVChfTeqolH2MQ3bsaUMtpPcs4+05NQ1esveBYQGAa3hMqI
 06xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770524291; x=1771129091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUPi70+djz5/qbyHUO97v+jwVbwvWXxE3kT/n/ARpQQ=;
 b=kWwG+J9cjo8K8rEr/gR4co/AdRU4pAobVtyfxlzTHVhtl9gKe/zkvn5IVE/nDPKX4s
 SLw/1CGzF3XjnjAGD1WvLvZs/Fzn+unut8Po3qxzJwER9R7FEQw5ZXQ8MyeVJcxft2XY
 bLGxuhBuLm14PlAKOueB0QnhEOBvz5X29aZ1jURvD2+IVLKSzINgZa+WhJNStT4cR632
 gCR2vbz0S6BH8pt+k81BvEQ+i3oabkY/sQXmZB6LqgcBgwxlwiFiHzcKzYpg9/SPe2Su
 MlbWTgYgQ+AFMkU2HS1chqM/FDWEZsttEtCt6JIYDPbc+NN/SN9xYcBb4H0wELZceCwO
 lq3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv+vUc+iATmNQkbHK3VIb7tdqPxx4l1y2sN+WoH9dQFe0KJwErVaTht5l2JQf7PYobrAfmA8U=@lists.denx.de
X-Gm-Message-State: AOJu0Yyy5HZGwjZzDltDNDQEiGoDcNRI/VRxtqCWzk4vgJngUzU72K6G
 ZfjDd2WoZDMheIWjdJ4RGOCpwvzSBkgqZ6E/6XfR+HoeEKiR2fFH7rAR
X-Gm-Gg: AZuq6aL8dn3lpIT0HE0GqQtjMZGWzDrlPDOvdr6W6jN0QK11MBGR78NWUTKxZowzJzG
 6mfS5uohSlIY0A4+0sfyPUS59TaKYpHyrJd2SlE0QKkMHGU0svonSy0V9fiaOeOSz5hKlWBzxou
 G1QG0GWwFVu46j6//m0R8xS6XeV/cD08MMUleDjOtPNfJvRAfFHwnCABKVdU/8wEf/Rz6QIZS/R
 a6RbkYth17CQhdaAMVuiSu3WoCqI5AaAHHRFOUD9wNK/kqNcenu6TY4JM4t1T01xjYj0PBG9gVk
 P7X62gEv2gzn985tNx8jVY9J8o/cyHOVetxiYc2k5CiarmkKu8/8rrqOUVJUesPZ5ZYY98sI1Bk
 xCgwtkaHcikSqqNw2BvpKWbLvh/OqQufxleaAdMAjbhcR1elePgaWnBervEQAQkSS/PAyNoS8zU
 UCcR/azB1UpoTQl4YYlB9oPdYMnYBHkt/O
X-Received: by 2002:a05:7022:6196:b0:11c:b3ae:c9f1 with SMTP id
 a92af1059eb24-12703f3c756mr3329206c88.1.1770524291052; 
 Sat, 07 Feb 2026 20:18:11 -0800 (PST)
Received: from localhost.localdomain ([107.172.49.54])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-127041d9c91sm6562414c88.2.2026.02.07.20.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 20:18:10 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: jagan@amarulasolutions.com,
	vigneshr@ti.com
Cc: tudor.ambarus@linaro.org, u-boot@lists.denx.de, Ssunk <ssunkkan@gmail.com>
Subject: [PATCH] mtd: spi-nor: Add Dosilicon DS25M/Q series support
Date: Sun,  8 Feb 2026 12:17:57 +0800
Message-ID: <20260208041757.830-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 08 Feb 2026 05:29:06 +0100
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

Add support for dosilicon ds25m4cb, ds25m4dn, ds25q4cb, ds25q4dn

Datasheets:
ds25m4cb:
https://www.dosilicon.com/resources/SPI%20NOR/DS25M4CB-XXXXX_Rev04.pdf
ds25m4dn:
https://www.dosilicon.com/resources/SPI%20NOR/DS25M4DN-XXXXX_Rev03.pdf
ds25q4cb:
https://www.dosilicon.com/resources/SPI%20NOR/DS25Q4CB-XXXXX_Rev03.pdf
ds25q4dn:
https://www.dosilicon.com/resources/SPI%20NOR/DS25Q4DN-XXXXX_Rev01.pdf

Signed-off-by: Ssunk <ssunkkan@gmail.com>
---
 drivers/mtd/spi/Kconfig       |  5 +++++
 drivers/mtd/spi/spi-nor-ids.c | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index a13c7fc60e6..6d0d070ff9b 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -157,6 +157,11 @@ config SPI_FLASH_ATMEL
 	help
 	  Add support for various Atmel SPI flash chips (AT45xxx and AT25xxx)
 
+config SPI_FLASH_DOSILICON
+	bool "Dosilicon SPI flash support"
+	help
+	  Add support for various Dosilicon SPI flash chips (DS25xxx)
+
 config SPI_FLASH_EON
 	bool "EON SPI flash support"
 	help
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index b6a07fa9063..4cd5f2991b0 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -77,6 +77,17 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("at25sl321",	0x1f4216, 0, 64 * 1024,  64, SECT_4K) },
 	{ INFO("at26df081a",	0x1f4501, 0, 64 * 1024,  16, SECT_4K) },
 #endif
+#ifdef CONFIG_SPI_FLASH_DOSILICON
+    /* Dosilicon Co., Ltd */
+    { INFO("ds25m4cb", 0xe5401a, 0, 64 * 1024, 1024,
+           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+    { INFO("ds25m4dn", 0xe5401b, 0, 64 * 1024, 2048,
+           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+    { INFO("ds25q4cb", 0xe5301a, 0, 64 * 1024, 1024,
+           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+    { INFO("ds25q4dn", 0xe5301b, 0, 64 * 1024, 2048,
+           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+#endif
 #ifdef CONFIG_SPI_FLASH_EON		/* EON */
 	/* EON -- en25xxx */
 	{ INFO("en25q80b",   0x1c3014, 0, 64 * 1024,   16, SECT_4K) },
-- 
2.41.0.windows.1

