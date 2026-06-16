Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16455CD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 19:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CD8A848BF;
	Tue, 16 Jun 2026 21:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rerMuUoS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9D9F84956; Tue, 16 Jun 2026 21:19:02 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA369848A2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 21:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490b9318997so36162875e9.2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 12:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781637540; x=1782242340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qjMZ9Kl84y3B/ciNg2kDGaB8inj1F2GW1cCqYY1J8rY=;
 b=rerMuUoSlSmYNQQkStUo9CS1mrQNBCN66nrhF//9c4lstnptm+T2zcv/QTJW007LYU
 cMMG0OJ1Zf3yqD0PKOVQshOLdRK3mZ1/uMIjWYIvNzq+Pn5v1+f2xJb4tMEcPxAHq37X
 z1AJISSncqAIU+hOR7Uc31T4dxFtyOu3h3xolUKMD8/iG6d9g457Y++Ftb4sd9Xz2B1q
 3ikYhody+cHc+qdaLcAdm80rLqF4CfTPB3cp6AnMgQdUULcH1PiS8XM0ioApXYVaofZD
 wql4rETQuf8lVtMEuyqL8pBoHloidFHipAeC4Ilqdu8swMtMl3wEMVVu8uHVJBgr2DC/
 dBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637540; x=1782242340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qjMZ9Kl84y3B/ciNg2kDGaB8inj1F2GW1cCqYY1J8rY=;
 b=MlE0d/A+EOpFhvFrBQs5eueLYM76GvT2GNtf9zkNzW8Wfiw+PNlDEboQgnjRrty9Fu
 OdSRrAHYv7xZNw70Ms/kgB40gLFjNz+HSM/Uh+I2nSc7+wkIqdPTzbCe5C4zzHAIpMxL
 kOIxdfZut2YMWeapyYvCnIQxZnNUh0aOAgO0wp9V3J/zHPn2OM3NDboU9fbTZUD2QgNF
 tnCl5Xk+wsaXJNKHch1itcxdjOdmuWkSGi0WyswsGYhAT5hJ6CC+wiK3J/eB+xcsXBgY
 MtQDQpHk3pc+U8V8E8G/kTTh/meSpyjoE6Mq32KAuDy7wuOyLImd0NLTDIjUighUX5Is
 cxdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HKzF08dQU7icqrEXzDVUZYUjFllgt1yoLJ4CF2qyN1rLly0SZew9o1t7OGzix3uUvCm93dQk=@lists.denx.de
X-Gm-Message-State: AOJu0YwMVEtk+YMEwaeF8uny8ZihpbOaTcFewsXs9+aXgKXK+EXwDoc/
 VOOHbigXVv18zUtCytxLntrVC0GcJAP5qMTcdnlr5ZAze6e7zEE5Hbqs
X-Gm-Gg: Acq92OH8R/HTgaXVJY/y+EGciJacWirAfShfa8W5iXhs/ogvJXajfBp1rD/oGwu6NYR
 Xk5RjxVkNtVHLAWm37TOBcCAu4GqJxDyHbKn4PDqNIPJtJTO5QB/S0ouDw1f5vB4ks66Sk48VTQ
 enSL3Ihw5UoTVGHJO6BUiuYU9AA/eIPK3D1kvjIOzRmpKfWxhb1/BAOt8kYFiX/I1E8SuYr8uMT
 5JW/0P4PiQMLiHukw0UJCmCAXtveajA9bP1fWu7tUIRV8jHSBbDBRjFNmUg+OWv2kKx75IoRjXS
 freB6H90L4jKoN9Ad9Pziu17Qsuwg3UOn1zqP/KdvxBYM1MWOYP0S5St91U+Q9J3JYQmzrLlEPj
 0MLGOusU7SCc+sBCKEm0YcZUJJ+HF9CuYTXUgRj4tbE0k4QSA9dG5ci+ZQ/zI4FqAbYseC9DoHb
 GL4StellZtN+tQxgs/f+iwQrlgIg5gr0KVsAPwaYjIQ1OeAjBdHVuF5xWjT1d+/ey+7g==
X-Received: by 2002:a05:600c:8184:b0:490:a646:9d75 with SMTP id
 5b1f17b1804b1-492333a74abmr16285635e9.9.1781637539853; 
 Tue, 16 Jun 2026 12:18:59 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4922f9cd140sm91326895e9.0.2026.06.16.12.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:18:59 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, Randolph Sapp <rs@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH v7 4/7] misc: fw_loader: implement request_firmware_size() OP
Date: Tue, 16 Jun 2026 21:18:39 +0200
Message-ID: <20260616191845.6182-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616191845.6182-1-ansuelsmth@gmail.com>
References: <20260616191845.6182-1-ansuelsmth@gmail.com>
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
index d77d877a9eaa..154544f65ff2 100644
--- a/drivers/misc/fw_loader/fw_loader-uclass.c
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -180,3 +180,22 @@ int request_firmware_into_buf(struct udevice *dev,
 
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

