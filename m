Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963B3C83F1A
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 17:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08AD082F8E;
	Sun, 20 Jul 2025 19:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a3eBdKuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75DEB83045; Sun, 20 Jul 2025 17:05:04 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2170882D21
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 17:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-747c2cc3419so2697090b3a.2
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 08:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753023899; x=1753628699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xuk3MUKynYpHBfWCywsJ4m7Qcy1GlScPo50O/2qrYZQ=;
 b=a3eBdKuwyt6BmsJ5ZXsncXpIagoSW3sQwQYPGMHogoyKrk8cJb9BJ+xi0BldlzP59R
 SHHX3I5A9AcdG01wJ+y4J0Hlq12Ay9bsOfDPOOfJMbagYsrSCU+MeCEpj0/YY29l0zcu
 tXg8rPOuwNWZThiTG2tftZNqsfj1SG9lISsV5We1f0iph7uxBuHD30HLcAjUZhvzGDmU
 yecFNa7NhooFgMGTMSRloSBc5DQwQXSvITT6qwC0fnfqa1qu6fFPzqUhREQ44YcBhCjR
 nFEQxBxZYme4P+BHVhBUcms7OdLro/Rxb1LutzRsT3Ye6RyxhU3MAJTWI28zGUaJ2TGy
 ATag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753023899; x=1753628699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xuk3MUKynYpHBfWCywsJ4m7Qcy1GlScPo50O/2qrYZQ=;
 b=HyInrwnue4edgJyq/m1g4PnQF78LlL6ykDOZk05bsTa0YHH6+e3qIFNpvy/paYJkmo
 Oay1HZTYyL+1jO+cspw9SLfpD9POfHmznhaTkeNpVFr8qG1PErMkC872DEhvb4F+vcdv
 2PPPlEsCM8w8Y1cwBArtnhSfIXKby5cRncOODiEciyjW6B+MgIWcnL1ZtEmCNWjPmfKD
 5DQAzwmGkz9l/KU4ynlOPWCemwoAQDwsqsUSI6bnzW36U0j0xm5+oPgCg++aXiBv/VpU
 Hr4vjss/SJVThfLuYY1UL0xHXbbybOWU5HA/un5LmhmrBR4KDneaUF3aosTb7AYCYCf0
 UWUg==
X-Gm-Message-State: AOJu0YwrkaxWHHV0Qu8T97dZ6N4tKU+PBH8A01Dfta0DD661sH8czuYX
 heDPGvRSQJkdp4ABw4gMWRsMmw7D8NgnYHbSme5lXu3t8FZMpz5egrUkd4lowA==
X-Gm-Gg: ASbGncsCVeg3+DVLTDhi95VOIM+ZokhXvaRs9xMjOC+KDv74qnNzpH/wFtRK8W6SvQP
 Ma7WdJ+zqkBE/iXpTtEWcGJn1x1NfZj28XJeBuoNS8GGpc2zmq4UEHBIONpoLZjCe0vnz1HmNuZ
 M7IHLFC1mwIJ8mw3y26crV0YuxxKaAwpE2Wte9SaBD77RRS76SeK6VL/Y3Ihht6EbHIFnCiE9tE
 aEBorFIWF2NoSmf3kwmFBFeYtAGYjN7nAyAFMhGgCEO1ElhApGHklA8RlXXt0UPovQ+Hc3CwfMv
 1RAzPuu//NL5SClVziXgc1kUpqcdGTga0ev2HO6SfPO152gc4Dmvu3GU/eGpVDcgppBKMOzdzOE
 OW+tn1f4dcDimJ3PfTs82nj3hrTgwXZj7r4ZY29byDfK9qSyzNAKq3T5f0/bXDL+TN1pqUVeS2c
 kmFGewVui4yxbrBlVBhg==
X-Google-Smtp-Source: AGHT+IF1HFHZFnQlbm/bIUOkVpGwxyPk+EREAWh+dJvx2BNsr0XXq6sQdjZDNDcuHZxkQ4y69pX4+g==
X-Received: by 2002:a05:6a00:179f:b0:749:4fd7:3513 with SMTP id
 d2e1a72fcca58-759ad9e5239mr12501264b3a.16.1753023899168; 
 Sun, 20 Jul 2025 08:04:59 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759c84e2706sm4192233b3a.31.2025.07.20.08.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Jul 2025 08:04:58 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org,
 tien.fong.chee@altera.com, trini@konsulko.com, sjg@chromium.org,
 xypron.glpk@gmx.de, seanga2@gmail.com
Cc: lucienzx159@gmail.com, lucien.jheng@airoha.com, frank-w@public-files.de,
 daniel@makrotopia.org, albert-al.lee@airoha.com
Subject: [U-Boot, v1,
 1/1] misc: fs_loader: Add request_firmware_into_buf_via_env API for
 environment-based firmware loading
Date: Sun, 20 Jul 2025 23:04:04 +0800
Message-Id: <20250720150404.25844-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 20 Jul 2025 19:24:14 +0200
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

This commit adds request_firmware_into_buf_via_env() to the fs_loader driver,
enabling firmware loading into a buffer
using environment variables for path and size.
It supports multiple entries via indexed variable names
(e.g., "fw_dir0", "fw_size0").
This provides flexible, scriptable firmware loading without hardcoded details.

Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
Change log:
- Re-sending as previous version and add more maintainers to review.

 drivers/misc/fs_loader.c | 59 ++++++++++++++++++++++++++++++++++++++++
 include/fs_loader.h      | 18 ++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 66803f4b997..a4f4448f5cc 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -228,6 +228,65 @@ int request_firmware_into_buf(struct udevice *dev,
 	return ret;
 }

+/**
+ * request_firmware_into_buf_via_env - Load firmware using environment variables.
+ * @dev: An instance of a driver.
+ * @buf: Address of buffer to load firmware into.
+ * @offset: Offset of a file for start reading into buffer.
+ * @fw_index: Index of the firmware entry to load.
+ *
+ * This function loads firmware into the provided buffer using environment
+ * variables to determine the firmware file path, address, and size. It supports
+ * multiple firmware entries by using indexed environment variable names such as
+ * "fw_dir0", "fw_size0", etc.
+ *
+ * Return: Size of total read, negative value when error.
+ */
+int request_firmware_into_buf_via_env(struct udevice *dev,
+				      void *buf, u32 offset,
+				      unsigned int fw_index)
+{
+	char var_name[32];
+	size_t size;
+	int ret;
+
+	for (unsigned int index = 0; index < fw_index; index++) {
+		snprintf(var_name, sizeof(var_name), "fw_dir%u", index);
+		const char *name = env_get(var_name);
+
+		if (!name) {
+			printf("Error: env var %s not set.\n", var_name);
+			goto fail;
+		}
+
+		snprintf(var_name, sizeof(var_name), "fw_size%u", index);
+		size = env_get_hex(var_name, 0);
+		if (!size) {
+			printf("Error: env var %s is invalid or zero.\n", var_name);
+			goto fail;
+		}
+
+		ret = request_firmware_into_buf(dev, name, buf, size, offset);
+		if (ret < 0) {
+			printf("Error: Failed to load firmware %s, size 0x%zx.\n",
+			       name, size);
+			return ret;
+		}
+
+		buf = (void *)((uintptr_t)buf + size);
+	}
+
+	return 0;
+fail:
+	printf("Error: Failed to load firmware via environment variables.\n"
+	       "Set these environment variables for each firmware index:\n"
+	       "  fw_dirN   - path to firmware file (e.g., fw_dir0)\n"
+	       "  fw_sizeN  - size of firmware (e.g., fw_size0)\n"
+	       "Where N is the firmware index (0, 1, ...).\n");
+
+	return -EINVAL;
+}
+
 static int fs_loader_of_to_plat(struct udevice *dev)
 {
 	u32 phandlepart[2];
diff --git a/include/fs_loader.h b/include/fs_loader.h
index 5eb5b7ab4a1..0d130daacfc 100644
--- a/include/fs_loader.h
+++ b/include/fs_loader.h
@@ -64,4 +64,22 @@ int request_firmware_into_buf(struct udevice *dev,
  * Return: 0 on success, negative value on error
  */
 int get_fs_loader(struct udevice **dev);
+
+/**
+ * request_firmware_into_buf_via_env - Load firmware using environment variables.
+ * @dev: An instance of a driver.
+ * @buf: Address of buffer to load firmware into.
+ * @offset: Offset of a file for start reading into buffer.
+ * @fw_index: Index of the firmware entry to load.
+ *
+ * This function loads firmware into the provided buffer using environment
+ * variables to determine the firmware file path, address, and size. It supports
+ * multiple firmware entries by using indexed environment variable names such as
+ * "fw_dir0", "fw_size0", etc.
+ *
+ * Return: Size of total read, negative value when error.
+ */
+int request_firmware_into_buf_via_env(struct udevice *dev,
+				      void *buf, u32 offset,
+				      unsigned int fw_index);
 #endif
--
2.34.1

