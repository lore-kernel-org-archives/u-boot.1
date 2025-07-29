Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82930C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C8C783197;
	Wed, 30 Jul 2025 07:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hHl8zirp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19E0D82BA7; Tue, 29 Jul 2025 16:53:22 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D63D82B20
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 16:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76a3374b143so715182b3a.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753800797; x=1754405597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KGkzBzpWaLPFnSXVG3yEQYA7LO3xz9tvWrBbImOvh8M=;
 b=hHl8zirpYn8VpyhLtAUiSKBL1qgHjjynqJVABaNJV2rmcjQQHhv+3ic6cK8t6MjmXm
 BSJj44aUdqko2opDSCpfh1YnsiJBROI4Bf+Bjj5Vx+Kgq5sQGCLpSr31+Zp4YxOFqaBq
 wlnPpIgOB+lxANjtXGrMAmdLfpGqlJznrfC4dOgGqP8p4KzVWnp4EmSNJhWTrRxsyRxR
 NY3Smp/G6YJ5qhZt/RqCAWRfPRspCN8luQxpmFBO75Ty4eU9lBKTo922C5j15qkb/POw
 Md3JWtdj5eeFqdq/sTxT3T5etXfzGG755x9PEAhH1ewn6/k+sDqlzYByjt4aCfx9gMSN
 Y7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753800797; x=1754405597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KGkzBzpWaLPFnSXVG3yEQYA7LO3xz9tvWrBbImOvh8M=;
 b=tvJbUKr41uOXTKpQ1ELT+CujuHSRYLxrzvsE5l78GIsjoW6Ce+j82L6LD6XhJkr4wK
 tEfBCmrB59owW1TXypqJXQHm26ck84DVmnITkogw55vk4LkjgWG0dqZbLzS/T6GOuh2G
 fYS7lnX3JJu4y8Uud9wyOobQY9xUKcENwiG4nxzWLlBjUjKpXv95/Xr0h0lnDe9DBCHL
 sZ2Oa9uZ3DoSr4U7xHKXLAMuZnm+fkSEcwDmWJ379iC3etjZ6hgs19eUjD7xZYV0uRYz
 cpXb56gJAnI2jmvnyI9W/0y9BBmG84dYlZIpmV/+sbO5tLCOtnpYrlcJaxOes42aiFf5
 3Q9g==
X-Gm-Message-State: AOJu0YzeugigdfBaymn7pVHhZsPubhEoLWYptOMm4iPXvKhl4md3qbkk
 OSps5fyiGKqvb+FLfbx3J57xKNgRudLtuZmMDe5+p/haKfReX3JJvI+nxnf8xQ==
X-Gm-Gg: ASbGncv4mTkJGRRnOjGjoHJunTz3skbQEhGfH7XPkjodi1Ib442mYy2zArMuc2mKKWe
 81q+D1u9picCoSAzSufyfdskQ1jL2a8dWOJU8SxjaiiN6ZAUTE0NLxMl06+jrnRBDikCcDwpyZD
 q9K6Y8NekAqa2G93XRbWiAIOKw2imcMuNiKlx3sD8PRSkrM7h3bdQgIwo5vDIC7MoKVCJkddZt4
 GM/GYQzP7qelSy4oiTP3bQT2fKCBA9LX9B4almtGnSgwPzK1LINyG+3Gql+OUpP0TJkP48YO713
 ngcR4b3ERIfhE6BE/ffYB31W8iz1IThXOn1JCvqeQZ2f6IrsA7wtRbzMr3EoD3YTZgMAMn9sm2Q
 LRfC988f+mNq/GGpD6jE4S9Yr4pWd3jJOBL4n84MJ/97Kq3RQdLV8CsteISrtl+grdawuFq+PWt
 nn9cscU3K6F+Z4v2bBqg==
X-Google-Smtp-Source: AGHT+IFPqsBdCjBqw5pbgSfyfCefdSXzyBYYXp2b/e82YK1r2ZYST2mwt+TqqjJeprOtc+qxDD0b/g==
X-Received: by 2002:a05:6a20:3ca3:b0:239:c5f:62a1 with SMTP id
 adf61e73a8af0-23d701a8e3dmr22651502637.33.1753800797242; 
 Tue, 29 Jul 2025 07:53:17 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640b4c8516sm8232951b3a.106.2025.07.29.07.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 07:53:16 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org,
 tien.fong.chee@altera.com, trini@konsulko.com, sjg@chromium.org,
 xypron.glpk@gmx.de, seanga2@gmail.com
Cc: lucienzx159@gmail.com, lucien.jheng@airoha.com, frank-w@public-files.de,
 daniel@makrotopia.org, albert-al.lee@airoha.com
Subject: [U-Boot, v3,
 1/1] misc: fs_loader: Add request_firmware_into_buf_via_script() for
 flexible firmware loading via U-Boot script
Date: Tue, 29 Jul 2025 22:51:46 +0800
Message-Id: <20250729145146.2935-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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
https://gist.github.com/bjxlucX123/6098f927c790861dbcebb87ea0059af5

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

