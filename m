Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58988CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 15:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D26A839CC;
	Thu, 14 Aug 2025 17:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kOoLv8Ca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B3BD83993; Thu, 14 Aug 2025 17:14:00 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB70583980
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 17:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-76e38a6b92aso383053b3a.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755184436; x=1755789236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NAFlxvK3wKNSUctvmG8gBHSOQ/qnmbu8VfblRZpCHY0=;
 b=kOoLv8CarBWxI7p3f7RRRc+mCED66l2s3L7Il44Pw1f9ful/nXIcbQUaFlXuSERfqI
 2Jziv2qMyOTaraA8IirUX8rS5A7TgT90PSWtVBAkeyUbRrQ20o5seFIePb08YXxQx2t9
 sdyju4WowLIta6gzZ+pcMdAZuB2lMSvYXR1l15YqNmUfWhmRQuT5wTPPls8l6Fz6awzy
 V0aS2MVq36wRN4QIvDCN8l/eHSyfktXGTiLzbtcShDp90qcJCgegZi2GLYjGJs5Umno9
 eT6Nnp0NbXb0gn+kzdxq4OZ3mHuxFVKZ8UXYtiel4JupBYuDUgkmZ6YsTkLhG+Lswy8W
 RhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755184436; x=1755789236;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NAFlxvK3wKNSUctvmG8gBHSOQ/qnmbu8VfblRZpCHY0=;
 b=HOTX66iSLR95KptRzR0K++ZOfYkFXGV4gaMsXiXTJBLNwuQfuHWYZhWsEcsb8U5WOs
 ZlHw03ioYfBNr0020+YENb56mG4OTifxeS6BVpv1Ou4eReEVifz2eZZwEewSDf01MyhB
 Xj6xIPx/sosoWSTERhSmt+tCjW/lLxIGCUTTONy1WW3Db7u0xgGWxVhubSg33LEPcaDl
 ytcZCOAs30J1AHIRCMJbiJELDINZ9PN/v67OqU3my4xSnUlLilpmPFL6zOen++6GD3l/
 pKAu026Yyvumq927JCjRod/O5NIUwnhXIZ+qi48RweodQ7wmr+X1iY3R4yUGshKqMfKn
 47wg==
X-Gm-Message-State: AOJu0YxSK3mRu5UPjAqrAxFBrZ21RdBiayqApndtTj74+q6YfnE8zZU8
 E6yG+WR+VQEAiJcTw1K10grDBRqCo4rTykS1RDrzaNBw76i+4iciD4YakDSnAw==
X-Gm-Gg: ASbGncuwz/6kaIg5mYhsqhNW7dsFdYqgA2UMWNBjZ2BeZsVSWafM+JnuISS2EGR2Qy5
 oJpzJKJF8VTzq3m3xCFKsJt1tc6NVdAp/3EUSUa+9oUL73Zki9a6Rmo2NROSBzm7hFnLEP+lIdt
 EvLcbDFLu1VUm4uDp/NUY5Pi+X54mSd9X83Ew5ppbDfV5IBtFQeSOUtqXXO+r/pvDfBBab8rjqw
 gjplilYDogdz7wvwgDTlpMCKOIpPUAiVZ6l4vq79rtYb+Y3rWA/Ueou9Nt89GA1CPn/+/oxvEMk
 8u/azMDZMDmXjMCAuaB5OlhxjFIKlk5Qv5YmGETya1j2tHJFH3wh/iK6AqAM7StIzozXq19eGhE
 ecMgO30+vgfVgXoOIaQsXTLGpmQVq7GnCMXFJWBqlGFrn6R/UEvOLSxVrtbFyKkM2zzmGYAX+m/
 cKF6EW537gvLhJ3ugJqA==
X-Google-Smtp-Source: AGHT+IGsC3XwQMKyqfMJmn5EKfJfGbL3P13FVfHiaMcnTZv2SAw1xQVHO/KG5kdUqJWzFiwtnDnSog==
X-Received: by 2002:a05:6a00:92a3:b0:748:fe3a:49f2 with SMTP id
 d2e1a72fcca58-76e2fdee316mr4535875b3a.21.1755184435707; 
 Thu, 14 Aug 2025 08:13:55 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e2037acf2sm4963260b3a.112.2025.08.14.08.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 08:13:55 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org,
 tien.fong.chee@altera.com, trini@konsulko.com, sjg@chromium.org,
 xypron.glpk@gmx.de, seanga2@gmail.com, daniel@makrotopia.org,
 lucienzx159@gmail.com
Cc: lucien.jheng@airoha.com,
	frank-w@public-files.de
Subject: [U-Boot, v5,
 1/1] misc: fs_loader: Add request_firmware_into_buf_via_script() for
 flexible firmware loading via U-Boot script
Date: Thu, 14 Aug 2025 23:12:53 +0800
Message-Id: <20250814151253.11053-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 Aug 2025 17:15:25 +0200
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
index 66803f4b997..efe1796fbea 100644
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
+	memcpy(*buf, (void *)addr, min(size, max_size));
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

