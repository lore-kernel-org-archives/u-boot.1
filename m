Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83674EA3C4E
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FDF28414B;
	Thu,  9 Apr 2026 15:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sCmF870f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F4DB841D6; Thu,  9 Apr 2026 15:33:27 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F06C8414B
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 15:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488a29e6110so9956625e9.3
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 06:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775741605; x=1776346405; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QXY/GsbVe9Lk6E8NTjJVvdwZuIu3JOlbbq9iW2053qg=;
 b=sCmF870fyd10KbybzrDYThYj7R1EM9OklrYT8k4ifjshKmjBdi9FLZZ1SRJO8iGOlA
 ORTknok4/66k2KyPBHW2fWJVnNtuLBEFvN+LrGotLS1z4v+pQWOgzQ2yu3M41ljdo1Qh
 8JhH40xcaRkT4Oidx9X+BZb5dwh4pap31AR8VTbyi6+miGe0Q2jDo//kIEpR7zmYV1R5
 or1BJPw/kXc8s2rp30WfvIJlD+WaDQzk70upHpZ56Mw0bW2jJqExai5iHSDLz3aYnG1p
 6VNB1Kh4xpV8YZmzyaGkE30DUgUPSsup4hYafJQ8uiATg9xzmKjkUDhb4I0gtgLyrHbb
 jiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775741605; x=1776346405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QXY/GsbVe9Lk6E8NTjJVvdwZuIu3JOlbbq9iW2053qg=;
 b=KPDO1XKq9CbLSq0WXHqnMIXB33NJlhhpPlt5cw7DQ6cSgh1wXranaCOYKbbpTAmuX6
 58MIAaMueAT8P7YfHY/0bFnWP2bUNWdJjjuSb9yJpwKZSo0vHS9k0GjiK8Q+A5dXkJ3T
 uzJ+tzgqA+vsJscEaEkdIIWQFcDZwIZB7/HRIoZF3z23MMKx4I2M9dBhb0zpzjF6OsB5
 fu7bYdy79hdXZfO/oqZyAtEVrRhyxUya3qm/wHhv3PPlEiFuiRxySY/aIUXWScv3GV4i
 1zyez/q5GjROPIlWs+y+Oat5X5TLiayfcOghtVGia/QBcHY2YjlSujjhsi9/IlBFn8Ei
 dk4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVymrLNweivY1OnrCsLNv9uBUzrhlhqWSsZp9xi5QoYls9SrdRPF12xgk0c6SdrUp0A5RF7xU8=@lists.denx.de
X-Gm-Message-State: AOJu0YxKjihPKsS2LMKu4w5lT7cFk4PVcauU3jluprrE+NvOHe7jG8nj
 1cGfRH7j95G8sE9ynjGgREFFxgFYk2gKAZ508/5HXbNr1ED4MflkE52I
X-Gm-Gg: AeBDievHFouaDUsydB5yVgMDVWsrVwF5Wog0cFLfjYkVuDVwE1jAIC3AOcTrM9apClL
 KWxO6pwEXvlid2217w3ITQBf75wW21sm5TLEm8lzLm5TTGDe+Olwys5kepi8l0xwz9rhKfunjcH
 LPG1wS04YRwUPW/t9UqkemKmhn0ASwGEedKDw8xYqdKyZwyi7N6ufxcZKb/zg2VGA1S7lQ0PpWC
 SHerJpWcS9mF++O4SPpubKXkuJuWDb0ZoRtkI6iDYRRri3hCkm7MfLSR/mWRtA7qHy8KRUuEeKm
 UtZnI1qNV1vnhAzC7GqKgJ7Wnv6VioTRVirxNlRePLa0HpzmrNnvtPNyXs7CA47SPM8SrhNatqh
 TFqtD9ZzysWT99qbDg62j9NQ9AvTnkqquOKu3WSmYO3VN+lpewNrLKuKk7S5KIWTI7BHdMrZE+V
 lHVvE42h5lpZMUYa3KbAVnY4o9cT27c0/up+yDM6jBRt9J/ZtHA7Xv0zpbMDq2swtLgS+UE6U=
X-Received: by 2002:a05:600c:3549:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-488997d5e5bmr331365735e9.25.1775741604562; 
 Thu, 09 Apr 2026 06:33:24 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-61-192-155.retail.telecomitalia.it.
 [82.61.192.155]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-488ccf9b919sm52876215e9.0.2026.04.09.06.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 06:33:24 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v6 4/6] misc: fw_loader: implement request_firmware_size() OP
Date: Thu,  9 Apr 2026 15:33:00 +0200
Message-ID: <20260409133303.31875-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409133303.31875-1-ansuelsmth@gmail.com>
References: <20260409133303.31875-1-ansuelsmth@gmail.com>
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

FS loader is updated to handle the new .get_size() handler.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fs_loader.c        | 68 +++++++++++++++++++----
 drivers/misc/fw_loader/fw_loader-uclass.c | 19 +++++++
 drivers/misc/fw_loader/internal.h         |  7 +++
 include/fw_loader.h                       |  9 +++
 4 files changed, 91 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
index 2694111d8396..8f549654a1be 100644
--- a/drivers/misc/fw_loader/fs_loader.c
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -89,18 +89,10 @@ static int select_fs_dev(struct device_plat *plat)
 	return ret;
 }
 
-/**
- * fw_get_filesystem_firmware - load firmware into an allocated buffer.
- * @dev: An instance of a driver.
- *
- * Return: Size of total read, negative value when error.
- */
-static int fw_get_filesystem_firmware(struct udevice *dev)
+static int fw_get_filesystem_prepare(struct udevice *dev)
 {
 	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
-	struct firmware *upriv = dev_get_uclass_priv(dev);
 	struct device_plat *plat = dev_get_uclass_plat(dev);
-	loff_t actread = 0;
 	int ret;
 
 	storage_interface = env_get("storage_interface");
@@ -124,6 +116,29 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 		ret = select_fs_dev(plat);
 	}
 
+	return ret;
+}
+
+static void fw_get_filesystem_release(struct udevice *dev)
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
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+	loff_t actread = 0;
+	int ret;
+
+	ret = fw_get_filesystem_prepare(dev);
 	if (ret)
 		goto out;
 
@@ -138,14 +153,43 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 	}
 
 out:
-#ifdef CONFIG_CMD_UBIFS
-	umount_ubifs();
-#endif
+	fw_get_filesystem_release(dev);
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
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+	loff_t size = 0;
+	int ret;
+
+	ret = fw_get_filesystem_prepare(dev);
+	if (ret)
+		goto out;
+
+	ret = fs_size(upriv->name, &size);
+	if (ret) {
+		debug("Error: %d Failed to get size for %s.\n",
+		      ret, upriv->name);
+		goto out;
+	}
+
+	ret = size;
+
+out:
+	fw_get_filesystem_release(dev);
 	return ret;
 }
 
 static const struct fw_loader_ops fs_loader_ops = {
 	.get_firmware = fw_get_filesystem_firmware,
+	.get_size = fw_get_filesystem_firmware_size,
 };
 
 static const struct udevice_id fs_loader_ids[] = {
diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
index c32c213b5b38..19379c23411b 100644
--- a/drivers/misc/fw_loader/fw_loader-uclass.c
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -168,3 +168,22 @@ int request_firmware_into_buf(struct udevice *dev,
 
 	return ops->get_firmware(dev);
 }
+
+int request_firmware_size(struct udevice *dev, const char *name)
+{
+	struct fw_loader_ops *ops;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	ret = _request_firmware_prepare(dev, name, NULL, 0, 0);
+	if (ret < 0) /* error */
+		return ret;
+
+	ops = fw_loader_get_ops(dev);
+	if (!ops->get_size)
+		return -EOPNOTSUPP;
+
+	return ops->get_size(dev);
+}
diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
index 2f93d0c706b6..9964dc436afb 100644
--- a/drivers/misc/fw_loader/internal.h
+++ b/drivers/misc/fw_loader/internal.h
@@ -32,6 +32,13 @@ struct fw_loader_ops {
 	 * @dev:	Firmware Loader device to read firmware from
 	 */
 	int (*get_firmware)(struct udevice *dev);
+
+	/**
+	 * get_size() - get firmware size from Firmware Loader driver
+	 *
+	 * @dev:	Firmware Loader device to get firmware size from
+	 */
+	int (*get_size)(struct udevice *dev);
 };
 
 #define fw_loader_get_ops(dev)	((struct fw_loader_ops *)(dev)->driver->ops)
diff --git a/include/fw_loader.h b/include/fw_loader.h
index 99c47380a172..01f242dcbefd 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -38,6 +38,15 @@ int request_firmware_into_buf(struct udevice *dev,
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

