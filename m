Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB9EFCC05D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 19:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C290C83F86;
	Fri,  6 Mar 2026 20:06:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IVSmc2++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB00983FD4; Fri,  6 Mar 2026 20:06:06 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D620783F00
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 20:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439c9bdc1eeso3255563f8f.3
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 11:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772823964; x=1773428764; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XYJOhPmhJ1dAFAHFRgHG4U33pX6thzJ6giUMeoK5bJM=;
 b=IVSmc2++JZJHhQI5ol5OsLirDPlLri6uNHIQqlo2UfCAmoinGEIYgZbRB9AsJ5k/dT
 gjDchLhAN1ckq13vUoXGnahj5Twqr7aEbjBTXzfeQfgHD53aMi1qe+SIKfioToXBOSDy
 E1EHRtjFhxqaFtHuYac/Mo82p/ICdTQ+xSRMUdHVRtesPQuUmfrekrA/EPvxb5pEG/a3
 D2iovd5U3rM2Ev/ZMm+GmALg8/KHX366UwP1vn/4W9ej6k9XpA3DjAbXUAIdoR+e8VR+
 0gNTr5+svV2tuupGMQq3ZfE99fbaYHRp4/Jo3fie/1Ge+ydnAzHEzPsjN+2WbOl/fqxo
 b69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772823964; x=1773428764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XYJOhPmhJ1dAFAHFRgHG4U33pX6thzJ6giUMeoK5bJM=;
 b=LRB36i7r/iqQETjWD5QGe6fUwCYipxY4PdxqeXqvh9q9QZNJ+m2F7XwiBQL2qQ/jt6
 SoYt85Rb1Azv93Teo+ufVAPtyUoGK3HUZI2yZG68REquC5tI44NSbPGBKH1cLF8xt31+
 N+ioVOGl4aKfy6Bh0l9AVHTQ5Gekbf3OBO+doJ78c3Ga+dTzArnMcPYRcH+Hj56FH50R
 F9fIyYxBvJ01xpRVtEU4UCzTHel17KXwy+/3Go13ofIp4JQya1TY9XYX4dfWcVNfGPOg
 uoXWHSfL7L1Yg6tB098j9TtHzCkVlxZckf24Uj+KhwjpuK2GY01HnmoJjW5Fg0V4sg13
 x/Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQQnF8BWDTPSMu/OjKq2jbhfYEnrhCbtdf68xb9RAahu0YG8SXbmSPX59fTLibVkV5vBcqcnM=@lists.denx.de
X-Gm-Message-State: AOJu0YzMo8DBzvXHaaMM3+Q2dv2ltZKIZvAbEBd2EFmivAaKrQ59Djl3
 huSpt9DX7NUwPIXS+47C841K5tDRXURy3Wnqx4zXKZwMTNzVIszI0TAj
X-Gm-Gg: ATEYQzxHpmK80AK49YBoktFn6jZslDFDY9wRV0by1QX/TcY7j7EKa8bNvJOkG3FtEO6
 OCqrtT3IfSXCV45xxN7ycY4NPYhfIkGfv9q4XTswfSONbGNVIB2LlVLj6cY+pADfVPme1QjM0YU
 nuL1rH5yCRKDLjaFeou6AMF/YQtg3AMBsjxJ/xxEV1NuWFws7VCPXE4WqQVSxgQqLCAd/n22SRn
 3huKPEDrmeBipy/Ac6atGNZ6bLmti4lVHGQsM0N1nvt1EHfjvZ4WRlk7lu4Gws3j9zaVaSlUrF6
 G91NSQyh/9I5jgqTwmNHZgFS9lxUxX/3kkkvB4yQ1wWV1ua18SPZSfnknSxn3ZzIy+M56/lpUv5
 GUN511HFRTa8Gfn5lEOl+lnckAN4vERGlfH1TLeKgTPbXSnzyxMqajkdf6LTrDpo2pj28vRK3lz
 AYl1AhIOd5qpSt3v5FiQqamXXf5dxSZNvN72eaUcVPR/5nqQVrF/B7xDI=
X-Received: by 2002:a05:6000:4210:b0:439:becb:6286 with SMTP id
 ffacd0b85a97d-439da87c5a7mr5371508f8f.54.1772823963979; 
 Fri, 06 Mar 2026 11:06:03 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-439dae45786sm6701065f8f.32.2026.03.06.11.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:06:03 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Paul Kocialkowski <paulk@sys-base.io>, Chen-Yu Tsai <wens@kernel.org>,
 Justin Klaassen <justin@tidylabs.net>, Harsha Vardhan V M <h-vm@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH v2 5/5] misc: fw_loader: implement request_firmware_size() OP
Date: Fri,  6 Mar 2026 20:05:39 +0100
Message-ID: <20260306190542.22920-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306190542.22920-1-ansuelsmth@gmail.com>
References: <20260306190542.22920-1-ansuelsmth@gmail.com>
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
index 7053c7bc6f05..1af3db385161 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -39,6 +39,15 @@ int request_firmware_into_buf(struct udevice *dev,
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

