Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF57FF60D8
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 07:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA48B84088;
	Tue, 31 Mar 2026 09:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eqdnJ+5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A09A284082; Tue, 31 Mar 2026 09:53:58 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA7C683F0A
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 09:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so53976305e9.1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 00:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774943635; x=1775548435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2ORj84iNSbkgpiM21gHmI5ty7ZisVRiWvA1wNGv34d0=;
 b=eqdnJ+5JSc2IyzkWL+HzDXIvYoswB9jN8r1M977qlCHSeQtJgbjVxIqzWl2nnW0mwc
 7DA4z21nDhZ+HaIGb4ekk/Jg9ZNbeKjPvLEWDnJFI5eE3lDhxPaowXRRNd/hFWc70Xpr
 UGGdFYkmwnklzxepnpixLss1QW5PIsGMH3vj5w40SivXKzuwDj2Wg5PxghWiz0uvMyEz
 DN8psLsWSyBGWQj67YjLt5N8qCATrgVWwZw8b33+2iRrv2AjZWL/uax/WXkLCXfkMBvF
 p8dlHK4ooUKa9IgU6tWjicrx+jf5POADFNBPVuXYWLUVlrNjIQNajH8f4s2itHlccH1p
 iQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774943635; x=1775548435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2ORj84iNSbkgpiM21gHmI5ty7ZisVRiWvA1wNGv34d0=;
 b=Ce4cy3U3DzIWXWStdUVBGGVpE4BufF/R138BAlYVMuLMDjc6edSPjcRDdyXZt+sbwu
 gdzw33czYNEVBcpKixRI38VQsuPvNOR48YvVUDOXe57QTejZEfd9ZQzquj7S2q4j17Wr
 Ue1M9C7ZUF+yj7frd9XqqQRXGFKtqhC+gFZaXhmMJ4slGLjgC3Z5gfmonkIESpallzNn
 ZUQSVsfoLixOf7zgFWFGKyc14TsrzrWWeaRfCJSltSdbOya1sr4zDaZ2w4OuWrgmz3OS
 zHnZNdizPwjze2cdRO+j+uf5T7tiBDSZcSCuRmS0nuXR8mLXvLPqkpeTUJPbZalCIDje
 IseQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSdm5cvj7eG5EC6Qzmcw0MIYS3MMQgsAbSRB5X2BWjUwlzpBXY3tGcaKpUBGXwpU3faH+HFVY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx30z4dKFRe2sAaHJkeClzTkfCDMl1BVp9nyVj1cV3nMHdVz7Ye
 QJWTfC627IOe61P7Xhb+PvUegvrJHEW6maJlm1Cc/DzlSkgM8QSLl6oU
X-Gm-Gg: ATEYQzyokKsC4OvF4YROythwusw3clKP7HKjaRU1S5q4UAC14hMD+bq4OG1DeBOInnE
 J4Vt862LTdIm0RF7ag+t0es41HjiYQ7ro6KAkIKAPc4N1MR93s9okHANk5YCN7bVrEyIZxQYGqz
 8+7aIAGfi/2ogsSTC90eiiQtM+PGJvTeQVFReC6LE74K4tPAcIzkOlqmZMvKoWADTaw6hbev9ej
 Ln5MHmL7g7/o0Qzpi4Y49RVBsCBYJSA1D6RbyiP+kIifoMJLrWuAYHkhpjfpqlNmGE4mjUbpQ6Z
 x7WnxM3QpbvKSce4OPv6MSSr1OPfENalSWhjmMW1qwp2igm7PqgXZwsKJov6tPC+kZjHkQKwgC2
 o+IL2Ga1d23B9HPT4dD76v5qkUxygv1iqRTMX+lePmCuq3DboPEAJxAnYJTL8I43fEzvgU5b8W6
 OLoSotiU/VVFjF4l6LIu39Q4Lr5LjPd08+V1wcbsVsJEosS0+Ffm018Wg=
X-Received: by 2002:a05:600c:8907:b0:485:fbd2:f72 with SMTP id
 5b1f17b1804b1-4887818678emr31580055e9.1.1774943634832; 
 Tue, 31 Mar 2026 00:53:54 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4887c561750sm23889915e9.2.2026.03.31.00.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 00:53:54 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Christian Marangi <ansuelsmth@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chen-Yu Tsai <wens@kernel.org>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>, Harsha Vardhan V M <h-vm@ti.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v4 5/5] misc: fw_loader: implement request_firmware_size() OP
Date: Tue, 31 Mar 2026 09:53:24 +0200
Message-ID: <20260331075338.2391-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331075338.2391-1-ansuelsmth@gmail.com>
References: <20260331075338.2391-1-ansuelsmth@gmail.com>
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

It might be useful to get the firmware size before reading it to allocate
the correct size. This is needed for case where the firmware size change
across different firmware version and is not always the same. In such case
the only way to handle this scenario is to allocate a big-enough buffer to
read the firmware.

To better handle this, introduce the request_firmware_size() OP to get the
firmware size before reading it. This way proper buffer can be allocated
and dynamic firmware size can be better supported.

Both FS and FIP lodaer are updated to handle the new .get_size() handler.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fip_loader.c | 29 ++++++++++++
 drivers/misc/fw_loader/fs_loader.c  | 70 ++++++++++++++++++++++++-----
 drivers/misc/fw_loader/fw_loader.c  | 20 +++++++++
 drivers/misc/fw_loader/internal.h   |  1 +
 include/fw_loader.h                 |  9 ++++
 5 files changed, 118 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
index 5c01013276d7..b50c89c892d6 100644
--- a/drivers/misc/fw_loader/fip_loader.c
+++ b/drivers/misc/fw_loader/fip_loader.c
@@ -495,6 +495,34 @@ static int fw_get_fip_firmware(struct udevice *dev)
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
+		return ret;
+
+	struct firmware *firmwarep = dev_get_priv(dev);
+
+	if (!firmwarep)
+		return -EINVAL;
+
+	ret = parse_fip_firmware(firmwarep, &info, &ent);
+	if (ret)
+		return ret;
+
+	return ent.size;
+}
+
 static int fip_loader_probe(struct udevice *dev)
 {
 	struct device_plat *plat = dev_get_plat(dev);
@@ -505,6 +533,7 @@ static int fip_loader_probe(struct udevice *dev)
 		return ret;
 
 	plat->get_firmware = fw_get_fip_firmware;
+	plat->get_size = fw_get_fip_firmware_size;
 
 	return 0;
 };
diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
index 26ac936aa590..a92ee8a4b519 100644
--- a/drivers/misc/fw_loader/fs_loader.c
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -89,15 +89,8 @@ static int select_fs_dev(struct device_plat *plat)
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
 
@@ -122,6 +115,28 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
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
 
@@ -143,9 +158,41 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
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
 
@@ -159,6 +206,7 @@ static int fs_loader_probe(struct udevice *dev)
 		return ret;
 
 	plat->get_firmware = fw_get_filesystem_firmware;
+	plat->get_size = fw_get_filesystem_firmware_size;
 
 	return 0;
 };
diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
index 26c2ce406ac9..c761fb1ff281 100644
--- a/drivers/misc/fw_loader/fw_loader.c
+++ b/drivers/misc/fw_loader/fw_loader.c
@@ -185,3 +185,23 @@ int request_firmware_into_buf(struct udevice *dev,
 
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
index 9e7585a92808..d823d56e53f5 100644
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
2.53.0

