Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A8AC83F03
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 20:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B350982103;
	Wed,  2 Jul 2025 22:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OH+f7Os5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 352CC81FEE; Wed,  2 Jul 2025 16:48:46 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E86ED800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 16:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b2c4331c50eso6699918a12.3
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751467722; x=1752072522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K8D+gU+p1eHm9iiWxKufrydXYLgnh0rHbhWd+/HlWeE=;
 b=OH+f7Os5BWszgLBc3NRy74V4y8yjE72U6oHtZrKxw4JxJmlPXaBWAZ1QoecWERzRAp
 n49OhBBISuBJamDZkGP9Vv2ctRCvO6gskflHi16vcLG2cbk+tIdXwXZO+JSgACDCCc+v
 5JcmDCXcQIsznhoNT5gIiVWccDEOoZztRTDHVk7nYUJ9kagBRorgFFFDc+PdyYfLafUN
 TVP2ln7b+uDvTkQg1NrQirJQpcW5rImYDHNMBOV/1rTRdswCRfohHVat5zCb1i3DWvSf
 V1L72ZIgajDVSS2weHIUAw/C1PLUbvFehKtjV4I/oFkcNepgM1Gpw0ZmIYARcDPKoClf
 XyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751467722; x=1752072522;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K8D+gU+p1eHm9iiWxKufrydXYLgnh0rHbhWd+/HlWeE=;
 b=HBYw++W3I/C6Aie1cizt+dACPgQ0zFQ+QgVc+zVaNB9bLeG+LqwnmMotAN/ra5wVO3
 fHp7a+KPW/UqWGf4mpcOzhFksUE2VjGUC7TWFt8FA+58H+mB8r1QkAuvTTHxVowPCpJf
 UUapu2evqMRRQ1izJfA64/kT+QktejHoOiI5dgeEgur5IzSmozN2BYRiJvYZQCLJG2QF
 mCGEZW8/iYJUYjjYFuaPjyKNQJssUJ9oHbXbpYBRK45zTtGMlohJMXMqJjKUnEfJwKn/
 VdDJFjETJXJSzRxBi70jmiZwrDBlzg8d/MpAgbb1qSAEM+iTx2jMe/x6e0Jb9BgLiUMj
 QVww==
X-Gm-Message-State: AOJu0YxRV+MWHJxR+B0pyG+78C0a0WZNYhHO+yR+c9D3NMaxuJP02IVr
 ExxoFBJhbx8SNKieFmfSMnPOw8QiADVyeKmDG4ShZd16gQG1XEsbsyK6kxzaFQ==
X-Gm-Gg: ASbGnctPr3Mi+u6ctotHsUSGxoCoAd3DZBs2nYotyiqjT3rGzrk/bEpzPMDQIgzTC2J
 xpJ1oKB5JegL2pvB/4QKZbTwFpSnlNEg3frskI0AMMY7yiH+NSzBXDETep/Lj5lesYqqHxKYulv
 xnA7+yD9FzH83OljKrvzki7nhpebhwBROxKYDtvfXdT+f9QAkFrQ3jyWJOGibK5iPVhE5xLoNDo
 b4DED1fYIJuPXibtsXQB2By9SmoieaPcFM8afUbgofZrOTJNXqPIGdBg0WvQRXEuTVu8MxGMZ9I
 XNbHSpRT6FC6GMxptmcWOi+gt+kc+MqWG702P0KdPU3oIxEFdvM9SJk6FbZiQU/9yGmVLIGDwiK
 73cZfraegG5ho3YpOxTzeDMy4/hooY3e/TybDvQ93xt6CAXgXvTWwal7uRSgzDCghefm+
X-Google-Smtp-Source: AGHT+IFzRj6NYewseAZ7toh6px+hD/9YsLtlCPOVyaIG9vdwa/jOqRN0Glg0mKyKDw/Mqv6a/VIEWA==
X-Received: by 2002:a17:90b:51c5:b0:311:d3a5:572a with SMTP id
 98e67ed59e1d1-31a90b960bbmr4687994a91.8.1751467722047; 
 Wed, 02 Jul 2025 07:48:42 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31a9cc66830sm22578a91.16.2025.07.02.07.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 07:48:41 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org,
 lucienzx159@gmail.com, jit.loon.lim@intel.com, tien.fong.chee@intel.com
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org,
 albert-al.lee@airoha.com
Subject: [U-Boot, v1,
 1/1] misc: fs_loader: Add request_firmware_into_buf_via_env API for
 environment-based firmware loading
Date: Wed,  2 Jul 2025 22:47:53 +0800
Message-Id: <20250702144753.18846-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 02 Jul 2025 22:17:46 +0200
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

