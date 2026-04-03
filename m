Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B44E8536E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 13:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D04484118;
	Fri,  3 Apr 2026 15:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oSROIRA5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFCA784120; Fri,  3 Apr 2026 15:52:26 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D996884101
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 15:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-483487335c2so19847755e9.2
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 06:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775224344; x=1775829144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lRyMlkwMBFUTS1fPkCX5K1jq+MSWJv9ALEWgihBG4qE=;
 b=oSROIRA50GVnMeK7G2aqIEtu38b5Zgw7LjYHjRSggRZS8xNyF/2YudAQs1WvQhUVcT
 pB8w0/Dlo/CD/sNqeuc1wIW7vU1Eh1/N2jAVi2TFnyd/v58PAJP3j02P8AfDb/y1exyl
 GMZSvvFp9S+Xn+LypT957DEhgo1zNksCdFjaIusUPMZUExvOq8qpkP2MLfZGAqeHlWjq
 r4kqPZCHwm2QOhMSVo70V3efIHW2CYlVD7w+j9pwUJsChCK808VxKn1oixrhgbisfJ35
 5iStSzLsxGLTj0iEbex7cFyrCSaI0HsoW9reexPOq1gllYhjzeoNop4fBIHoz802yN2V
 /kmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775224344; x=1775829144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lRyMlkwMBFUTS1fPkCX5K1jq+MSWJv9ALEWgihBG4qE=;
 b=OQ5VJbkp0PrQWELpMeEUom6zNyayU+jP/6WXxz2rLpZ6U05cG933gdvN1nayQGZXJq
 dV/Op+AzuJDeTkPSpJgakNo88fH44PGPnusxkjTNxdDUfe58Ub9Q1z2TFGMpXYWS/avO
 +AzktOyL0gc4S7OMyDnYwiHA1O65t69fshCo+uEgnDj3+1h4myMQ/WFobjOsBqIvOUHQ
 zPY+HhX+T7V/5/Se7kycyWjfHu4NGhnzkaMipt/ALgttsgDmJ7mwOoWVBPgZugXYrCDW
 MAfdeibq8ykEpToPVq1r7PFpcJWSJ9MrUwK3Iyn2vorvEhbdCGot7zYV7ZW2X2PZg/ie
 RGkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWxeC7w8c6vKT9o1rp00wEY5TFSGCJiMPG/+VnJ9Gq6uicm/LHKCbDLoWPeMNFTaiHBgUxheQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2uwklp8+RLPJ0PMFDNxmEi5APLpLyk3Ev7U301hLJlJy6ZZNy
 ddrG+2FyJVH4gk4U7qI2Vs82gXtV0xRwPwrONgb5qjSZBULcpLchWAq1
X-Gm-Gg: ATEYQzwVck+mk5uUkBa+CtOsopmSDSZ1lJE9iVIrdD2f4hl+D2YAjOIk0FbndnlDp54
 JQJA+tKwP+h8CgyR4swdE7+27rZHgB5KiiSjKwurDn4PLRfYKDhrzGHmvY3w2plWodaJAd8DT+B
 0OwpktGWcP0IpJUhhjfslLTKptrsMcblBKYPeAeM37WRMCrkfaXfpD5VZmTBe9ddKKG+TTZLSmt
 jJlp/VSPHPjC0S/ee4u4tSyxCk8lMdmWORQth0aH9ofb3fsxjELJ1htKniGUIUhqFUv0CNQ5s5O
 rb6RdfLTGCCdLWGiFbdWMF5HFKTpYboZ72c6Pvti3kdBWtzP15dlkfsNRCBwKMMOi2sid07L5Xo
 7W1O2AE92NnyWq3oiyDhQ9PO0sWFLHhGzwAyH/0vevze0Yz+x88snznY5EhyuQ0NWCKgKypAia1
 EtIOUNsV1C7IFTMouEPgrdFvs=
X-Received: by 2002:a05:600c:1f96:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-488996e142bmr48366555e9.6.1775224343999; 
 Fri, 03 Apr 2026 06:52:23 -0700 (PDT)
Received: from Ansuel-XPS24 ([217.202.87.54])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4888a7162cesm196732895e9.13.2026.04.03.06.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 06:52:23 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Harsha Vardhan V M <h-vm@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v5 4/6] misc: fw_loader: implement request_firmware_size() OP
Date: Fri,  3 Apr 2026 15:52:01 +0200
Message-ID: <20260403135205.26979-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403135205.26979-1-ansuelsmth@gmail.com>
References: <20260403135205.26979-1-ansuelsmth@gmail.com>
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
 drivers/misc/fw_loader/fs_loader.c | 72 +++++++++++++++++++++++++-----
 drivers/misc/fw_loader/fw_loader.c | 20 +++++++++
 drivers/misc/fw_loader/internal.h  |  1 +
 include/fw_loader.h                |  9 ++++
 4 files changed, 91 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
index 2748d9f041e8..87e7840686f1 100644
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
 
@@ -143,9 +158,43 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
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
+	struct firmware *firmwarep;
+	loff_t size = 0;
+	int ret;
+
+	ret = __fw_get_filesystem_firmware_prepare(dev);
+	if (ret)
+		goto out;
+
+	firmwarep = dev_get_priv(dev);
+	if (!firmwarep) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = fs_size(firmwarep->name, &size);
+	if (ret) {
+		debug("Error: %d Failed to get size for %s.\n",
+		      ret, firmwarep->name);
+		goto out;
+	}
+
+	ret = size;
+
+out:
+	__fw_get_filesystem_firmware_release(dev);
 	return ret;
 }
 
@@ -159,6 +208,7 @@ static int fs_loader_probe(struct udevice *dev)
 		return ret;
 
 	plat->get_firmware = fw_get_filesystem_firmware;
+	plat->get_size = fw_get_filesystem_firmware_size;
 
 	return 0;
 };
diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
index c3d0de1b93e7..06bd6ab9ab12 100644
--- a/drivers/misc/fw_loader/fw_loader.c
+++ b/drivers/misc/fw_loader/fw_loader.c
@@ -174,3 +174,23 @@ int request_firmware_into_buf(struct udevice *dev,
 
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
index fa006b7e6077..a94de609d0b6 100644
--- a/drivers/misc/fw_loader/internal.h
+++ b/drivers/misc/fw_loader/internal.h
@@ -34,6 +34,7 @@ struct device_plat {
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

