Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF2EEC143D
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 13:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61CC483F9A;
	Tue,  3 Mar 2026 14:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JmqHba8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C18E883F59; Tue,  3 Mar 2026 14:29:35 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8715A838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 14:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-483a2338616so35377375e9.0
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 05:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772544573; x=1773149373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mhH/ei1Fyl7MxwqCjMi/IYznuPoOSwM/eMh5S5gYEL8=;
 b=JmqHba8tsyN5ft5LmvY3YcEc22sYWGLBOhQaVS5yulARAzcSp6YJ8GVB7j3BdqaL5P
 Kstn4vFsqKfhVGBBp4AQf25zPr2p32v8dlnxhTF0vKnHtKIP8YUq5B3H+qZt5rOUFWVj
 dqF0kHqhI+gRSvPbXQSoYZZ6FEwojZ63bA5Q8PLmCnzTjWiwSJfcEAmARebJKPZa7zKF
 NytobjOLyPr09G/IxxRssRor8kOkm4U0uaPTGjqnEa+yExdwF5l2IUaGk7UCVnaItcRx
 iDs1s2VeCB6WTuyisqSqoWD9v6B/PjreUVKFY5qOBeBbLSXBS6SE2a4s+S165amJSrEL
 O+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772544573; x=1773149373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mhH/ei1Fyl7MxwqCjMi/IYznuPoOSwM/eMh5S5gYEL8=;
 b=pBy9LO3OaCNIi3SNTft3lT6lu1IblTW2kINcKFRHhVW+aqhQBrNn36fjjse+92l2h5
 0rGPcmMc1rUVvEJn/wlH5ejriHtaNwZssYf5Rw1ZpTbHQSX3r1FtKf5Dlb23oJ7bm4z+
 bvAfZJEzA5IDRIxJb5LU6hko7yThRG+7kijf1x9LmIXRvl9AH0Z7GqzJqiiTlmZnQ8b0
 +KxrRDYFuqoaK0vHw/bYT4lnMu6kk/C0spoGKwr0bJl/TSLla+fH0qVgeHrg+ZjP6ayN
 fYOUYrHeDkuFEtMWJOHA5HibGDl9WRwvZZ1qFbHbVewFhl/jYiPDHlgM5n083km0E/ry
 IMeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR0mAo096gov7Qp/poY7sN/q36SAhtMxxzC9STTadOvgHTqPG4hEQ64evBGLADWu3wbdlcxTA=@lists.denx.de
X-Gm-Message-State: AOJu0Yys8NdWTneDfexPvHHjdWjftRK5LbkBrDdS1RLK51jrE++3eU7e
 w143ifKZhO1ONcWCPMA56EIyUtKBNDm+Ozzq0wgEjmy7LKZAyzVv6bfBAoRKMw==
X-Gm-Gg: ATEYQzwp/SuXa22CwDXkhPM57ETbKt+efBql/dcBtb/g2QEVgivPHA0n6bcLmJ6ouu5
 Yg7I6IpfqXjDJkx15z08DbQmJpPBbjyoCmoTuQT/d96M+qEniKJjZdH/rHfcfRfZiw6du7WkT3t
 BE0WQzwoK4NhcSPMSVSJ0Q9dSqu6PVv+1GD5stNGudgS3Ca3I1wlLbDFj6hTGRrLK9ehnmgpqVa
 OP6Ie7ztERDrLGrkhyIiS5FGRMu8S4Qvk5jdPiI8K0UyyD/N1vhd6ICYLuxiTNaVQPwycJWUai6
 8D2IeOE78/eZyCHU3oLRMup/RZ8zK9SYCuHpP5NiAUj5I/fd1rhjJQAA0UxKp/HjH1PRj70ogmZ
 2PHFKTUTiqYF86agt7qDUztFXnhDQ71clAJGgusKt73lAPJtc9RGUmP1nUvHvXpzJl0eghVMk0D
 sUnAEowA0PzUTDE0/zpoI/mk2OtpYYxIbkg87UXVu4wvDMLVuiLphx4Gw=
X-Received: by 2002:a05:600c:8108:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-483c9bffddcmr230503515e9.27.1772544572663; 
 Tue, 03 Mar 2026 05:29:32 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483bd68826asm772625095e9.0.2026.03.03.05.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 05:29:31 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Harsha Vardhan V M <h-vm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Chen-Yu Tsai <wens@kernel.org>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 u-boot@lists.denx.de
Subject: [PATCH 5/5] misc: fw_loader: implement request_firmware_size() OP
Date: Tue,  3 Mar 2026 14:29:12 +0100
Message-ID: <20260303132916.5502-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303132916.5502-1-ansuelsmth@gmail.com>
References: <20260303132916.5502-1-ansuelsmth@gmail.com>
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

It might be useful to get the firmware size before reading it to allocate the
correct size. This is needed for case where the firmware size change across
different firmware version and is not always the same. In such case the only way
to handle this scenario is to allocate a big-enough buffer to read the firmware.

To better handle this, introduce the request_firmware_size() OP to get the
firmware size before reading it. This way proper buffer can be allocated and
dynamic firmware size can be better supported.

Both FS and FIP lodaer are updated to handle the new .get_size() handler.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fip_loader.c | 35 +++++++++++++++
 drivers/misc/fw_loader/fs_loader.c  | 70 ++++++++++++++++++++++++-----
 drivers/misc/fw_loader/fw_loader.c  | 20 +++++++++
 drivers/misc/fw_loader/internal.h   |  1 +
 include/fw_loader.h                 |  9 ++++
 5 files changed, 124 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
index 376e1d2a59d8..a285f785db37 100644
--- a/drivers/misc/fw_loader/fip_loader.c
+++ b/drivers/misc/fw_loader/fip_loader.c
@@ -523,6 +523,40 @@ out:
 	return ret;
 }
 
+/**
+ * fw_get_fip_firmware_size - get firmware size.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of firmware, negative value when error.
+ */
+static int fw_get_fip_firmware_size(struct udevice *dev)
+{
+	struct fip_toc_entry ent;
+	struct fip_storage_info info = { };
+	int ret;
+
+	ret = fw_parse_storage_info(dev, &info);
+	if (ret)
+		goto out;
+
+	struct firmware *firmwarep = dev_get_priv(dev);
+
+	if (!firmwarep) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = parse_fip_firmware(firmwarep, &info, &ent);
+	if (ret)
+		goto out;
+
+	ret = ent.size;
+
+out:
+	fw_storage_info_release(dev, &info);
+	return ret;
+}
+
 static int fip_loader_probe(struct udevice *dev)
 {
 	struct device_plat *plat = dev_get_plat(dev);
@@ -533,6 +567,7 @@ static int fip_loader_probe(struct udevice *dev)
 		return ret;
 
 	plat->get_firmware = fw_get_fip_firmware;
+	plat->get_size = fw_get_fip_firmware_size;
 
 	return 0;
 };
diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
index 4ae01b9c8f0d..d6b9f4998815 100644
--- a/drivers/misc/fw_loader/fs_loader.c
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -93,15 +93,8 @@ static int select_fs_dev(struct device_plat *plat)
 	return ret;
 }
 
-/**
- * fw_get_filesystem_firmware - load firmware into an allocated buffer.
- * @dev: An instance of a driver.
- *
- * Return: Size of total read, negative value when error.
- */
-static int fw_get_filesystem_firmware(struct udevice *dev)
+static int __fw_get_filesystem_firmware_prepare(struct udevice *dev)
 {
-	loff_t actread = 0;
 	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
 	int ret;
 
@@ -126,6 +119,28 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 		ret = select_fs_dev(dev_get_plat(dev));
 	}
 
+	return ret;
+}
+
+static void __fw_get_filesystem_firmware_release(struct udevice *dev)
+{
+#ifdef CONFIG_CMD_UBIFS
+	umount_ubifs();
+#endif
+}
+
+/**
+ * fw_get_filesystem_firmware - load firmware into an allocated buffer.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of total read, negative value when error.
+ */
+static int fw_get_filesystem_firmware(struct udevice *dev)
+{
+	loff_t actread = 0;
+	int ret;
+
+	ret = __fw_get_filesystem_firmware_prepare(dev);
 	if (ret)
 		goto out;
 
@@ -147,9 +162,41 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 	}
 
 out:
-#ifdef CONFIG_CMD_UBIFS
-	umount_ubifs();
-#endif
+	__fw_get_filesystem_firmware_release(dev);
+	return ret;
+}
+
+/**
+ * fw_get_filesystem_firmware_size - get firmware size.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of firmware, negative value when error.
+ */
+static int fw_get_filesystem_firmware_size(struct udevice *dev)
+{
+	loff_t size = 0;
+	int ret;
+
+	ret = __fw_get_filesystem_firmware_prepare(dev);
+	if (ret)
+		goto out;
+
+	struct firmware *firmwarep = dev_get_priv(dev);
+
+	if (!firmwarep)
+		return -ENOMEM;
+
+	ret = fs_size(firmwarep->name, &size);
+
+	if (ret) {
+		debug("Error: %d Failed to get size for %s.\n",
+		      ret, firmwarep->name);
+	} else {
+		ret = size;
+	}
+
+out:
+	__fw_get_filesystem_firmware_release(dev);
 	return ret;
 }
 
@@ -163,6 +210,7 @@ static int fs_loader_probe(struct udevice *dev)
 		return ret;
 
 	plat->get_firmware = fw_get_filesystem_firmware;
+	plat->get_size = fw_get_filesystem_firmware_size;
 
 	return 0;
 };
diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
index d2446fdc07da..d5973fce4b9c 100644
--- a/drivers/misc/fw_loader/fw_loader.c
+++ b/drivers/misc/fw_loader/fw_loader.c
@@ -162,3 +162,23 @@ int request_firmware_into_buf(struct udevice *dev,
 
 	return plat->get_firmware(dev);
 }
+
+int request_firmware_size(struct udevice *dev, const char *name)
+{
+	struct device_plat *plat;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	ret = _request_firmware_prepare(dev, name, NULL, 0, 0);
+	if (ret < 0) /* error */
+		return ret;
+
+	plat = dev_get_plat(dev);
+
+	if (!plat->get_size)
+		return -EOPNOTSUPP;
+
+	return plat->get_size(dev);
+}
diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
index 5513e043925f..4701b494bf3f 100644
--- a/drivers/misc/fw_loader/internal.h
+++ b/drivers/misc/fw_loader/internal.h
@@ -36,6 +36,7 @@ struct device_plat {
 	char *ubivol;
 
 	int (*get_firmware)(struct udevice *dev);
+	int (*get_size)(struct udevice *dev);
 };
 
 /**
diff --git a/include/fw_loader.h b/include/fw_loader.h
index d07306c0674f..a3fa980c768d 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -37,6 +37,15 @@ int request_firmware_into_buf(struct udevice *dev,
 			      const char *name,
 			      void *buf, size_t size, u32 offset);
 
+/**
+ * request_firmware_size - Get firmware size.
+ * @dev: An instance of a driver.
+ * @name: Name of firmware file.
+ *
+ * Return: Size of firmware, negative value when error.
+ */
+int request_firmware_size(struct udevice *dev, const char *name);
+
 /**
  * request_firmware_into_buf_via_script() -
  * Load firmware using a U-Boot script and copy to buffer
-- 
2.51.0

