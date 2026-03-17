Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B66FED9E4
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 15:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BDC6843FA;
	Tue, 17 Mar 2026 16:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lPI6nnOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05F35843AD; Tue, 17 Mar 2026 16:36:42 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC791843B9
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so36779695e9.0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 08:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773761799; x=1774366599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+1jxtjk1+yKKThtEA+DWmyaB+7uwGlWzTjYzkNoAJ1A=;
 b=lPI6nnOx2Bn1V3yvkC7mwesK1vif/J7fhFAJXHy2ErCBME9G5y9Rnwi5/Hou3gJ8tk
 rUEUFnG8JmtfuYrZTdldz51yUTVLoy/D79hCBvIcwFxuVGhZqSSFnenx36jPpPHIV+NR
 yn4XoZPzIQUYlnOkt5a+gBSFe2XNDCkBuENmoi252tmWMUbNmgsg4/uYd4CUFstc/OS5
 fELET/z9UYxuNRy9oNqD5HfQLYqYxCJkiCPbmw3JlP1BldqPcGb4BpjqGsCwzA1mMqbW
 1ZJrz7Ct4PHCYJEvkpsc34NG/XQ8ai8THwCxJyATQbMwQ4PC43BajPwFiEu22t0p9JPs
 Oldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773761799; x=1774366599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+1jxtjk1+yKKThtEA+DWmyaB+7uwGlWzTjYzkNoAJ1A=;
 b=aoPC3/JoHC598//qWx9cC0KNVLnaUVp9S5I/hPp/wdLOuNZlxgNWVLgccOHyNrgQNg
 /7HqxwHFljZ7UxFSAaaglnteOVoDutxlbKXEJYXxZVaLDqf83PRqkUCIH0psZVmsYG8+
 gSJCuCsZUpVy1HYjknl3vn12l8QVEiWTVYBLWWzvr9vwwGhdmGsWrgOWjZ31nH7LPhNK
 RHWmpX5f4eUJ6wsmgyxf1FZkrPHS2QSU9umJ8pRoyk7ApH0BmWHnsWasIuCL/hGJWTaH
 wX6RYgw1sJhrz0jXiYZ/eMA9KIUxBTJ0FGrYnsUOEGgL5IvqxU2tywO88r1WnZBxYRH/
 jNqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKIVR4TnYVzigpUyGJ33uA2AK2TtwudguVyPsjyDuX2tyr8iBKLHwapuvM13xZ5WVLb/CBMms=@lists.denx.de
X-Gm-Message-State: AOJu0YxOpk/iWabgLk98DsWzNGNbbQA4Og9sCEhOjxaG7I1h8qoOUDK9
 y1ReKIeDrgAsoNmsGsKnNqLjcxfqhgncqsAmjh9100TDEguCs1K2/zJa
X-Gm-Gg: ATEYQzxFtuZVP0YvGpEjGv+bR6CnvW86xvhatO3QJKfgEOLFDVw2sp7rzVFVKfMFMn7
 5jqtl5NExSjYLfnweYVoKov71ZHtWEMqVHIKnBRmZ7jg7DBKvYqIoKuGFrzZs6OOqW4Mlxobnfp
 xYKfOtPZPxEGHvTGRTtjXbpN/wuAl2ibytcSqU/Oggu7A5hJWPNWdMGNVkVO2b8ohgKstVGT8mL
 3wPwFAydXW6CwadvqgTtwepopkxHhb15bd+0yhICBeLonHj7MItSw7ZSayS+bo7sashK2sGFcva
 itMKY0fIxWbJ9a9xxfqKGCumlEo3WRnpzQOziOfiUP97bz1IXhLztRLDD1TaH8L3LIuS89Zg1x4
 MUpQEVGr6dWxZ+O4kwyEB/oKEnc8VLP/kSB5QTQDP6v09t0doDO71S0uM9uJL9jqAGBnYhhMPtD
 IRWxZMJ5Myfn0T1LHZCQ/Tt1LYXyaAvlLKFUn7j5zS8zM1Y4l7bBKFkgg=
X-Received: by 2002:a05:600c:34c4:b0:485:3b9e:caa7 with SMTP id
 5b1f17b1804b1-4855670e6d0mr262082355e9.23.1773761799080; 
 Tue, 17 Mar 2026 08:36:39 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-48556414295sm200870485e9.3.2026.03.17.08.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 08:36:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>, Harsha Vardhan V M <h-vm@ti.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v3 5/5] misc: fw_loader: implement request_firmware_size() OP
Date: Tue, 17 Mar 2026 16:36:09 +0100
Message-ID: <20260317153614.18409-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317153614.18409-1-ansuelsmth@gmail.com>
References: <20260317153614.18409-1-ansuelsmth@gmail.com>
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
index 429abc4f60cd..434e0afbfe2a 100644
--- a/drivers/misc/fw_loader/fs_loader.c
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -92,15 +92,8 @@ static int select_fs_dev(struct device_plat *plat)
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
 
@@ -125,6 +118,28 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
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
 
@@ -146,9 +161,41 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
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
 
@@ -162,6 +209,7 @@ static int fs_loader_probe(struct udevice *dev)
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

