Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DE4C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 15:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3DB183F8A;
	Mon,  4 Aug 2025 17:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HMRRdhCK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46B1783F58; Mon,  4 Aug 2025 17:08:30 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71E1183E16
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 17:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b42348bae1fso2262348a12.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 08:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754320106; x=1754924906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4JXhcTC1vecnEgh9Wvr2a5MDjbE9ikHRluqgZq4dhY8=;
 b=HMRRdhCKsQRWxNxd7z0NipBZOK9qT57+gpPDfS8fpr9Fc7p9Bs35JIP6IlOuW/y93l
 7L6pevjIpKSQFP0afU5PrS3wI+nKgHLyzkaqxSho+sQ99khYQKZQDFWiBvNywawVXYeS
 Zu9fC1elBgoyDWIwJxRr+iiGclhwuDtBF1GX4ZqP5PP29FE6Yq7pgi7BmhtmBfS1SG0k
 +rmo3r9ZtgcIHYsVy3/z4AvYpNDB3AvE+8GoGSZaaTGsHNjyipezX5p1n3uCQ8YEyqAq
 A2ac6eUrV0TMBpENe+r8HkzwMryItTvuQHyY816pyp9WxwLMBuanN3enhb3OCi6yomNv
 WtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754320106; x=1754924906;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4JXhcTC1vecnEgh9Wvr2a5MDjbE9ikHRluqgZq4dhY8=;
 b=njUAHvIX8W2YfZOItWgpwXHjH9VK0d0IJiraeq7eT5uY07YeQqFReMcxedpuCx54rD
 ii7lyPZmoURz5jCHf+qrUa8Ia69hOY3BcfO0b/Bbajw7H3VqUu6OZJNLlHvtCXe2wLCX
 9fNJODx4umnVRLlisx37in9sd8U6GNFDI8AcQ3s+c7Ki6IowFRoSPyAKdtf+lIL4e2MQ
 uk3M1cdLgSIxLrZDqI+doyXQtKeeT3s3AF0/H6LYd4RM96fNzsKm3W1ITj+TNm3CtRfd
 LVtMgG5y6nWba+UkE2+35Rv6qYJ58mYrIphIp8zNbyV92TfmCdkuvEutOV2sfPvfqNWX
 gOXQ==
X-Gm-Message-State: AOJu0Yw1ygOca/Jg1ahOLjI7WtYXkNbLXO9Nph0YdE1tKApMtiByDS9E
 zli9x3lffb0hwH8hWT+NKu4midXD6PcpFLnEOG640eQe03sJzS6IzfCHBV2v9Q==
X-Gm-Gg: ASbGncsguSvVwwuBa9qEF5JnQyXUBLwssTv6+GG5L5ShIRpKycLi0Dq0RyT1rKjOMcb
 +/xOEnC8FODn6XqwDEK+4hfLuO6X48gPhMqVjoeoVNyt6DaZSKOC3qq6r2clLE+GdQ+756CbBG4
 HgI890u3m/AF1/mR1yH6Dl7q3xkrFqZrw/+okd9P1LUnpYc0hgGoeLXzyMEU094yEnypVfnWwFW
 E5/panXai2UBEILdMBHU9juffqmrCmRxXWHejj/VKYZfjITS9yCVOzJFu9PkTsvZMgWD0NrXu0k
 t6wBv0QsPz+j+IzPhFnVzHyfiAh8ODFDY5tkJX6Hqwnu1CHdhofTKC6cNpaRQje92GHg97dt2dN
 HDJFhOot4rW0tnSpoLkO5M8Q9cjap/1FcrDepGta08fnvW4nOu/CJrxppD9qtrSph5CU1WJSzuX
 bGAhtvILJOFgxQiysT5w==
X-Google-Smtp-Source: AGHT+IGVB9xtPfjDon02/d6U7m+ynJnta8R4NqFMT6qdV30cJ9GuZ6tBoTTpBueMazaQuu1jIXU8ew==
X-Received: by 2002:a17:902:d4c1:b0:240:8323:365e with SMTP id
 d9443c01a7336-24247028662mr134280055ad.47.1754320105430; 
 Mon, 04 Aug 2025 08:08:25 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8ac8ed4sm110936175ad.189.2025.08.04.08.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 08:08:25 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org,
 tien.fong.chee@altera.com, trini@konsulko.com, sjg@chromium.org,
 xypron.glpk@gmx.de, seanga2@gmail.com, daniel@makrotopia.org,
 lucienzx159@gmail.com
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, albert-al.lee@airoha.com
Subject: [U-Boot, v4,
 1/1] misc: fs_loader: Add request_firmware_into_buf_via_script() for
 flexible firmware loading via U-Boot script
Date: Mon,  4 Aug 2025 23:07:34 +0800
Message-Id: <20250804150734.4901-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 04 Aug 2025 17:13:11 +0200
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
- The function validates these variables, copies the firmware into a allocated buffer
  (using memcpy), and returns the pointer via the provided double pointer argument.
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
Change in PATCH v4:
air_en8811h.c:
 * User should pass an already pre-allocated buffer pointer into `buf`
   instead of a NULL pointer, to avoid memory allocation inside the API.

Change in PATCH v3:
air_en8811h.c:
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
https://gist.github.com/bjxlucX123/f75a2a15efdfc2938ebd22e45cfb6eec

 drivers/misc/fs_loader.c | 61 ++++++++++++++++++++++++++++++++++++++++
 include/fs_loader.h      | 24 ++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 66803f4b997..5953231e252 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -228,6 +228,67 @@ int request_firmware_into_buf(struct udevice *dev,
 	return ret;
 }

+/**
+ * request_firmware_into_buf_via_script() -
+ * Load firmware using a U-Boot script and copy to buffer
+ * @buf: Pointer to a pointer where the firmware buffer will be stored.
+ * @max_size: Maximum allowed size for the firmware to be loaded.
+ * @script_name: Name of the U-Boot script to execute for firmware loading.
+ *
+ * Executes a U-Boot script (@script_name) that loads firmware into
+ * memory and sets the environment variables 'fw_addr' (address) and
+ * 'fw_size' (size in bytes). Allocates a buffer, copies the firmware
+ * from the given address, and returns the pointer via @buf.
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
+	memcpy(*buf, (void *)addr, min(size, max_size));
+
+	return 0;
+}
+
 static int fs_loader_of_to_plat(struct udevice *dev)
 {
 	u32 phandlepart[2];
diff --git a/include/fs_loader.h b/include/fs_loader.h
index 5eb5b7ab4a1..6a16260be88 100644
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
+ * 'fw_size' (size in bytes). Allocates a buffer, copies the firmware
+ * from the given address, and returns the pointer via @buf.
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
+                                      const char *script_name);
 #endif
--
2.34.1

