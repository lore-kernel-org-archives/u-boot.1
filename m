Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2688CA0EDC
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 23:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C8DA832DA;
	Mon, 18 Aug 2025 01:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jPfFDSOT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A3C483A45; Sun, 17 Aug 2025 17:02:53 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 962758399D
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 17:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2430c3684d1so32013145ad.0
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755442969; x=1756047769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x1zcKc8Sdjewr/tDGAlyknzaoc+YYJQhcDXmV5pDLzI=;
 b=jPfFDSOTSpMa5UR3rTpDXaHzj2yLgCp2F/3KFt30NOwfNb46/s5Ze+EA17puwVYkf6
 MTQTnhLVO+GFXPrdpmVx4kbsrfWlq1jucK/2/XzuAjcFwTvoE9GhUeE5BmkCP+72w5qY
 9ODyr9GJRd/fJmp4Wq57VUz+3wqLOi+6UQtN6KkcQu2kR0MgM4gttr0+UNBMkjWA1r/h
 v6wdV7DiUfL7V5PyrU8ZxYCRFvOJXHrKaI5I87hVuXhurQfqP1peG4srkhP0IoBhsRhY
 M9sU7eYfEzOrazRizAsMknqkYOiXevQZcVZGrQb6f2bhhSCybkc9fAGIHBkcH1/eVp7x
 nfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755442969; x=1756047769;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x1zcKc8Sdjewr/tDGAlyknzaoc+YYJQhcDXmV5pDLzI=;
 b=h16OKEZBEqwQBO+qTBAu0O/WDTllcud7dHOF7s0sMlvvsRIWRAOCClf2Ioodcw3C5/
 pD3Olrs0uQ4iGCVFSoHPdUGh7Ut+U/SHArieKTfbKcaCEZTM+MCzKJd9syU6sHUF3x80
 x3PjZnIUJZbGDu2uYnlPAubrkF32qVGofUmkcp9bl2XNj6/DACUYlr9jyMDXNdsxY7Hs
 4oFglzfbu6msfrE2r1CK8eFOyYnvNU7AZpXK5WBqmJjp/W3hDsX6Unb7HOgTzyUTecWY
 crufUjKVtzgP6tOqk3sG2jVVepdl0aBiT8ewXZtN365kfU5c8C0U3fBMD5+EgMw81Qh3
 GYbg==
X-Gm-Message-State: AOJu0YzJvO9qvDrjhUM85RyH6cczVab9Yc/9MnlGBV+JpFRUjpdizE+b
 Facaae0Y3n84caw0Yv+mlzF1526V0zYSrG0t9aKQF75jc0VaYyRtsKKwP8Vk4A==
X-Gm-Gg: ASbGncuJpocpKgXhtZ/N4aH2Gu15s47p3nZFl0mak5Gt+v4+W5mxyvRR29u2TS/TeOX
 uhqJKPxwNssDiDxMsVpNWH6StuVKrOTuuukbXBP6TXv8+CQ/12/ZM1Pw6tuGnBqTPWfh+mUBmrh
 fv3PKggTgjvYhhatTe3xObTtnM0br/3YIg9lebhoQ4LtjvTPk210bIYXiF0D/t2emBWu64TecDK
 G5OlhV+mFyh14aWeDmZbOJ6j65kXARMLxAgZGh9gaXLICrYJMRE3XHfKcr2Y+C5cA1C2hq/4tob
 ssk0w6ekoZMYjx4I61kmnfLspNR3lMnp93aCVYB2E9ITMmM3i6Uk+aaqWvBaoRO2rIXCiPtYIe9
 XLs445hCwBbxEdiGMkTYJyjTykMqb7QqP40jeh0OTOW5VlvcM91xmUYmtgSKVfkWkOuQgFng11B
 6tlk9uvnaAV5LGjxq5ew==
X-Google-Smtp-Source: AGHT+IHGNNz5iE7o2S6cSy0GQcplNEGIwHc/+s2QzR2MQ8+PG2UzrNowtTk9Fsw7h9QgenCV+Zf4Yw==
X-Received: by 2002:a17:903:2305:b0:215:6c5f:d142 with SMTP id
 d9443c01a7336-2446bdd6bc1mr107035175ad.20.1755442968308; 
 Sun, 17 Aug 2025 08:02:48 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2446d50f710sm56922555ad.86.2025.08.17.08.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Aug 2025 08:02:47 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org,
 tien.fong.chee@altera.com, trini@konsulko.com, sjg@chromium.org,
 xypron.glpk@gmx.de, seanga2@gmail.com, daniel@makrotopia.org,
 lucienzx159@gmail.com
Cc: lucien.jheng@airoha.com,
	frank-w@public-files.de
Subject: [U-Boot, v6,
 1/1] misc: fs_loader: Add request_firmware_into_buf_via_script() for
 flexible firmware loading via U-Boot script
Date: Sun, 17 Aug 2025 23:02:03 +0800
Message-Id: <20250817150203.52850-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 Aug 2025 01:09:31 +0200
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

This commit introduces a new API,
request_firmware_into_buf_via_script(), to the fs_loader framework.
This function allows firmware to be loaded into memory using
a user-defined U-Boot script, providing greater flexibility for
firmware loading scenarios that cannot be handled by static file
paths or device/partition selection alone.

Key features:
- The API runs a specified U-Boot script (by name), which is responsible
  for loading the firmware into memory by any means (e.g., load from MMC, USB, network, etc.).
- The script must set two environment variables: 'fw_addr'
  (the memory address where the firmware is loaded) and
  'fw_size' (the size of the firmware in bytes).
- The function validates these variables, copies the firmware into a newly
  allocated buffer (using memdup), and returns the pointer
  via the provided double pointer argument.
- The maximum allowed firmware size is checked to prevent buffer overflows.
- The environment variables are cleared after use to avoid stale data.
- Detailed error messages are provided for all failure conditions to aid debugging.

Usage example:
1. Define a U-Boot script in the environment that loads the firmware
   and sets the required variables:
   => env set my_fw_script 'load mmc 0:1 ${loadaddr} firmware.bin &&
   env set fw_addr ${loadaddr} && env set fw_size ${filesize}'

2. In your code, call the new API:
   void *fw_buf = NULL;
   int ret = request_firmware_into_buf_via_script(&fw_buf, 0x46000000, "my_fw_script");
   if (ret < 0)
		return ret;

This approach allows board integrators and users to customize the firmware
loading process without modifying the source code,
simply by changing the script in the U-Boot environment.

Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
Change in PATCH v6:
fs_loader.c:
 * The min() function is unnecessary since the size is always guaranteed to be <= max_size.

Change in PATCH v5:
fs_loader.c:
 * add a check to ensure that the loaded firmware size does not exceed the specified `max_size`.
 * remove function description in fs_loader.c

Change in PATCH v4:
fs_loader.c:
 * User should pass an already pre-allocated buffer pointer into `buf`
   instead of a NULL pointer, to avoid memory allocation inside the API.

Change in PATCH v3:
fs_loader.c:
 * Use "fmt -w 72" to shrink the commit message to fit within 72 characters.
 * expand the script en8811h_load_firmware to erase memory before loading firmware,
   and to check the filesize after loading the first part of the firmware

Since the Airoha EN8811H requires MD32 firmware to be loaded via MDIO,
and U-Boot currently supports various FW loading methods (e.g., partition or rootfs for MMC),
I've followed Marek Vasut's advice [1] to implement this via U-Boot scripts.
[1] https://patchwork.ozlabs.org/project/uboot/patch/20250617081641.8385-5-marek.vasut+renesas@mailbox.org/

This commit expands the existing `fs_loader` concept by adding U-Boot script functionality.
This leverages U-Boot environment variables, providing significant flexibility
for FW loading without requiring CONFIG_* modifications or recompilations.

I've validated this API on the Banana Pi R3 Mini. Here are my test commands and logs:
1.  `env set en8811h_load_firmware 'env set fw_addr 0x46000000 && env set fw_size 0x24000 && mw.b ${fw_addr} 0 ${fw_size} && load mmc 0:3 0x46000000 /boot/EthMD32.dm.bin && if test ${filesize} -eq 4000; then load mmc 0:3 0x46004000 /boot/EthMD32.DSP.bin; else echo "loading MD32 FW failed"; env set fw_size 0; exit 1;fi'`
````Test Log````
Net:   16384 bytes read in 1 ms (15.6 MiB/s)
131072 bytes read in 9 ms (13.9 MiB/s)
addr: 0x46000000, size: 0x24000
Found Airoha Firmware.
MD32 firmware version: 24112802
````End of Test Log````

2.  `env set en8811h_load_firmware 'env set fw_addr 0x46000000 && env set fw_size 0x24000 && mmc partconf 0 1 2 2 && mmc read $fw_addr 0x0 0x120 && mmc partconf 0 1 1 0'`
````Test Log````
Net:   MMC read: dev # 0, block # 0, count 288 ... 288 blocks read: OK
addr: 0x46000000, size: 0x24000
Found Airoha Firmware.
MD32 firmware version: 24112802
````End of Test Log````

Test Logs:
https://gist.github.com/bjxlucX123/4190ab6c80c13af56a98ca99789d1e4a

 drivers/misc/fs_loader.c | 46 ++++++++++++++++++++++++++++++++++++++++
 include/fs_loader.h      | 24 +++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 66803f4b997..4eb51644e30 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -228,6 +228,52 @@ int request_firmware_into_buf(struct udevice *dev,
 	return ret;
 }

+int request_firmware_into_buf_via_script(void **buf, size_t max_size,
+					 const char *script_name)
+{
+	ulong addr, size;
+	int ret;
+	char cmd[32];
+
+	if (!buf || !script_name || !max_size)
+		return -EINVAL;
+
+	/* Create command to run the firmware loading script */
+	snprintf(cmd, sizeof(cmd), "run %s", script_name);
+
+	/* Run the firmware loading script */
+	ret = run_command_list(cmd, -1, 0);
+	if (ret) {
+		log_err("Firmware loading script '%s' not defined or failed.\n",
+			script_name);
+		return -EINVAL;
+	}
+
+	/* Find out where the firmware got loaded and how long it is */
+	addr = env_get_hex("fw_addr", 0);
+	size = env_get_hex("fw_size", 0);
+
+	/* Clear the variables set by the firmware loading script */
+	env_set("fw_addr", NULL);
+	env_set("fw_size", NULL);
+
+	if (!addr || !size) {
+		log_err("Firmware address (0x%lx) or size (0x%lx) are invalid.\n",
+			addr, size);
+		return -EINVAL;
+	}
+
+	if (size > max_size) {
+		log_err("Loaded firmware size 0x%lx exceeded maximum allowed size 0x%lx.\n",
+			size, max_size);
+		return -E2BIG;
+	}
+
+	memcpy(*buf, (void *)addr, size);
+
+	return 0;
+}
+
 static int fs_loader_of_to_plat(struct udevice *dev)
 {
 	u32 phandlepart[2];
diff --git a/include/fs_loader.h b/include/fs_loader.h
index 5eb5b7ab4a1..a433be1eb99 100644
--- a/include/fs_loader.h
+++ b/include/fs_loader.h
@@ -64,4 +64,28 @@ int request_firmware_into_buf(struct udevice *dev,
  * Return: 0 on success, negative value on error
  */
 int get_fs_loader(struct udevice **dev);
+
+/**
+ * request_firmware_into_buf_via_script() -
+ * Load firmware using a U-Boot script and copy to buffer
+ * @buf: Pointer to a pointer where the firmware buffer will be stored.
+ * @max_size: Maximum allowed size for the firmware to be loaded.
+ * @script_name: Name of the U-Boot script to execute for firmware loading.
+ *
+ * Executes a U-Boot script (@script_name) that loads firmware into
+ * memory and sets the environment variables 'fw_addr' (address) and
+ * 'fw_size' (size in bytes). On success, copies the firmware
+ * from the given address to user buffer @buf.
+ *
+ * The script must set these environment variables:
+ *   fw_addr - Address where firmware is loaded in memory
+ *   fw_size - Size of the firmware in bytes
+ *
+ * The script should be defined in the U-Boot environment, for example:
+ *   env set script_name 'load mmc 0:1 ${loadaddr} firmware.bin &&
+ *   env set fw_addr ${loadaddr} && env set fw_size ${filesize}
+ * Return: 0 on success, negative value on error.
+ */
+int request_firmware_into_buf_via_script(void **buf, size_t max_size,
+					 const char *script_name);
 #endif
--
2.34.1

