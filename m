Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE04C87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 04:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9EC683045;
	Mon, 28 Jul 2025 06:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IZMtbNZ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6805783043; Sun, 27 Jul 2025 16:17:26 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BE5182F8F
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 16:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2401b855635so1445665ad.2
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753625842; x=1754230642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ijD+3lKSq9HMSp/GAloQAXi3L2df9Htvb1aoLAsQe/o=;
 b=IZMtbNZ5kbKzx06WzwQFgQ17NFlFhApzDLMmmoBv5AvqDs+ckFh0DzxOjuHNYOpDWV
 6inKWKarZWO7gFZ87UoCZqXKkEqUjM2SM6G5R1vzIs5VsIXWdiUi73uRpYrq29oa68rC
 CwVJi6XUxWpnnWw7hrNdPY5ZUUGI3WqUJM6zlzmxrQBytCnRIS8/F8XjVs+lhBbFMdym
 8DWi5tnDHaPttWqyCvii7bgKlJVsSdLiVBH6khlIbhi9YzDGttynWNU09IYf8qOvbU+n
 XrgcvJ1Y4TUBZI54P3Z0yY7M+yZpUTKDOWjY9unHd8ZwSqpKTkaRMeGeLb+bSlnn0Lu9
 U5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753625842; x=1754230642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ijD+3lKSq9HMSp/GAloQAXi3L2df9Htvb1aoLAsQe/o=;
 b=kMJBOZpq2JGvWrrGiyC5BMfHe17pcSJncRd6QjYVQpdBjpPs9kVTFxZ0ZvQ/QSYOj9
 7nqzp6Mxu5YWFcIprf/K8y8bwVa/px11JPTRgq2jPOi/DoSM11fX30K2xdsZCJqeOSI2
 ep6Gezi/H+dmPlKKr9Agu7PGfHJVsFRgaWnzGE7ZBfxstxdvfm7zePNnhtpBYxbQ0sQj
 thcPLBnI4orzTdTqoQDv+KKvxQO8PVouKo0NAJ3WA0ck9y85RzRRb5BMfxu94sbkalTj
 sb59eGH2mCoAf64f9jSOyKLi+Mc8F4bZzDsLDw/THXgTwW7/sBQISucccjDAZBidbnsc
 q5og==
X-Gm-Message-State: AOJu0YzAJGPmUlJSsUC2ebQrX3um0W0bgMfNuVj+S5bgxog3YYyWiYRm
 GKb6ZhYmdcaoYNvBTp5uCMaO9wW67lZWt373DohyPlvB0F9ULMlcidnV9AaPlw==
X-Gm-Gg: ASbGncvsUi7j/BBbxfWAdGUHCouyRDsNsmc0OX3/ySSx4PT2HWlABA0fkbFzJIU56Zh
 FoWXgSCzrFhkC8JbpXmbXV3wOPri6AdzmpMUW/CuLY1nbeyKXycIBz/Cl45y2/IpSVMJLZmFcie
 St3c7Uvhyt6JtqX+cYmA59HqwxsX5+sgQA83hwnB6iiMMGpgRrFz2YeH0s3Vxl0QrgHbD5wQsVT
 Qq/Fh1W5U6DAYkkTC/g3B+tgEUUldFeOXkFqY5asRDOygQTx9BVSR4uGNa5l6ffKTj0UbDseesx
 8z7GEApwIcCd7wC9AWcVZ0EvVZfflaIlDQyeui4ib3b68eisLjwYeEbsXMeTZVd6Il6M795rsmt
 rev7wqrIqLRkE+Yypi9ANfSL7tftvfqzp4/NShLpX43FP4xGXUcftwTgZs29MBTindIYMVFZQLe
 JHAGy1U5hNtrhxqJKgeA==
X-Google-Smtp-Source: AGHT+IHGjkCzZdQPcaZeKiHC2mvNH9nPdAnSaoVtmm564iIlg4arZ//pDvHGNsCQrX5j6eKPEuxWpQ==
X-Received: by 2002:a17:903:2a86:b0:235:e1e4:ec5e with SMTP id
 d9443c01a7336-23fb31252dfmr146744995ad.49.1753625841763; 
 Sun, 27 Jul 2025 07:17:21 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe30ff47sm35133225ad.13.2025.07.27.07.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 07:17:21 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org,
 tien.fong.chee@altera.com, trini@konsulko.com, sjg@chromium.org,
 xypron.glpk@gmx.de, seanga2@gmail.com
Cc: lucienzx159@gmail.com, lucien.jheng@airoha.com, frank-w@public-files.de,
 daniel@makrotopia.org
Subject: [U-Boot, v2,
 1/1] misc: fs_loader: Add request_firmware_into_buf_via_script() for
 flexible firmware loading via U-Boot script
Date: Sun, 27 Jul 2025 22:16:09 +0800
Message-Id: <20250727141609.15425-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Jul 2025 06:33:29 +0200
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

This commit introduces a new API, request_firmware_into_buf_via_script(),
to the fs_loader framework.
This function allows firmware to be loaded into memory
using a user-defined U-Boot script,
providing greater flexibility for firmware loading scenarios that cannot be handled
by static file paths or device/partition selection alone.

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
   => env set my_fw_script 'load mmc 0:1 ${loadaddr} firmware.bin && env set fw_addr ${loadaddr} && env set fw_size ${filesize}'

2. In your code, call the new API:
   void *fw_buf;
   int ret = request_firmware_into_buf_via_script(&fw_buf, 0x24000, "my_fw_script");
   if (ret < 0)
		return ret;

This approach allows board integrators and users to customize the firmware
loading process without modifying the source code,
simply by changing the script in the U-Boot environment.

Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---

Since the Airoha EN8811H requires MD32 firmware to be loaded via MDIO,
and U-Boot currently supports various FW loading methods (e.g., partition or rootfs for MMC),
I've followed Marek Vasut's advice [1] to implement this via U-Boot scripts.
[1] https://patchwork.ozlabs.org/project/uboot/patch/20250617081641.8385-5-marek.vasut+renesas@mailbox.org/

This commit expands the existing `fs_loader` concept by adding U-Boot script functionality.
This leverages U-Boot environment variables, providing significant flexibility
for FW loading without requiring CONFIG_* modifications or recompilations.

I've validated this API on the Banana Pi R3 Mini. Here are my test commands and logs:
1.  `env set en8811h_load_firmware 'env set fw_addr 0x46000000 && env set fw_size 0x24000 && load mmc 0:3 0x46000000 /boot/EthMD32.dm.bin && load mmc 0:3 0x46004000 /boot/EthMD32.DSP.bin'`
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
https://gist.github.com/bjxlucX123/15aa5f92493e1363ec81fd5e5b83ee6d

 drivers/misc/fs_loader.c | 72 ++++++++++++++++++++++++++++++++++++++++
 include/fs_loader.h      | 24 ++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 66803f4b997..202ee7c7bfb 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -228,6 +228,78 @@ int request_firmware_into_buf(struct udevice *dev,
 	return ret;
 }

+/**
+ * request_firmware_into_buf_via_script() -
+ * Load firmware using a U-Boot script and copy to buffer
+ * @buf: Pointer to a void* that will receive a pointer to the copied firmware buffer.
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
+                                      const char *script_name)
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
+		       script_name);
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
+	/* Validate the firmware size against the buffer size */
+	if (size > max_size) {
+		log_err("Firmware size (0x%lx) exceeds buffer size (0x%zx).\n",
+			size, max_size);
+		return -EINVAL;
+	}
+
+	*buf = (void *)memdup((void *)addr, size);
+	if (!*buf) {
+		log_err("Failed to allocate memory for firmware copy.\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int fs_loader_of_to_plat(struct udevice *dev)
 {
 	u32 phandlepart[2];
diff --git a/include/fs_loader.h b/include/fs_loader.h
index 5eb5b7ab4a1..97ed4cc2af0 100644
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
+ * @buf: Pointer to a void* that will receive a pointer to the copied firmware buffer.
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

