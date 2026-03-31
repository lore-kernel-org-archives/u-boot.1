Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9707FF60D8
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 07:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CA2E84073;
	Tue, 31 Mar 2026 09:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iSQl9zts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEFC58406D; Tue, 31 Mar 2026 09:53:54 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE04C84020
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 09:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so66237105e9.3
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 00:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774943632; x=1775548432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k/6kSpsJEZwed2v18IcSrdq03Zwo71Wq4qJQ0bw02Rw=;
 b=iSQl9ztsvT/99gqzeCMu6nZSXvLnfZhnPYK8CMWl8d5D5BnzaQKy2zJ9+63eEd5mMe
 IX5L/vVz0+HYaGv8iNpvVdxiMyh+7yuM16NAJuy1hSNp9Q1Azp1tExnWJg6KooDHyjiV
 sUumjweiDg4woOV/Rzc4PJ7Tq9ea8VGzwHCjUMz7OxT3QQwhiPJxu0FRDWm1Cj0bo805
 PQwSjzKBjqYWjWF5n5L+svnLGpvHt1RiOQWubAj3qWuy0lw/mhZnhR0XKKTclrHtEx4O
 VcIMjKC8IcjeNFi1AfN2kcr1whl0nmKp4yPZ/ltSinlDrzM9wXQoqLYgwQRgulfNUN0R
 B7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774943632; x=1775548432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k/6kSpsJEZwed2v18IcSrdq03Zwo71Wq4qJQ0bw02Rw=;
 b=IALMRJgRck75eqorOmJ5KcObWmRmxm2IppJqCgmBMQxNASekEpO5Wm4vtvUWiZwHDF
 NipKnAH04Co26WLqsGOleEbg5DGT+L7xtVyYorvtQPvnFpAm9MahTCFJcHeJ8Tzg39uV
 DmWNwJ+vJ5qtYKPlQCYwH6L73mRrHBwH74TNm1DqihUpzlug/W6BA/FsPayXs2oCZ2Jr
 AAbV5x2JJ4GlgL1rkBmJSFjyed/OCwGbDPeQDF/GwycMWdtihgz3NaL26gmYjVP+TOnn
 +ZUc3LmdVNypnh+i38Ho+tuQ4uwMsOnQNKb28ikp/zn9WKfG/KZREj94VBdeOyJFeWJM
 XZ8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2ivHsALw+Oah1LwBMZ023Apuo3RVmCV/hZFSZ32RtusioExtSiJZ1Umb5+oxTLIIKccS1X/o=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+E8L8ciEaJqTLdjSyBa+ejIiOwiGZlD36c9DNsNwwM9siHstU
 gqycs/CefHFHEKq47C4XO7+cKrHfkWEHjsF2Xnf+TDmEok31FpkuEkGj
X-Gm-Gg: ATEYQzyxLgEas++A195LIWFOex62UvS7ARHMOye2ueEhlRLkjBFEK888ZhI5i/AYRmN
 45p1dTbo3+BtBEqly+eZjz6MMSaa2fBcWbun/GX01WNJz8V7xIquRu/t+Hp5gpIkg8CAtT4WOL/
 fKk4Q1HDbujFLdzBFfrLGUi5USTlcGVY8mKfmsMMy3HCZzTUhHlmGIN2x6HWEQnDaAq6fn+qbma
 54P/3hYUv8ODttZWyTVfTBNIykimWh8F8K8Zm0Jf37K3E+JZloR5DgmG1hP/FKWf5ad+dmzs84A
 DuM7dXOJIJgGJ6wsNqhDyC+69BkL/iyCY5u6Bob7g54pIiy95Jvby/UIt0rpEFJa6uD//jjWxOI
 LghmHNL18+IOiZDqXbBYMDXRbllSBmfPhtb660sF8rk7AJ5ucS1Sr6rzifb4kqiKXe6JrR1o4xP
 M8UPiF06z3SaWQBnwF4PVTc8K+yhHSM5hNNzD4dSs8cOhZFP/N+FAwRN8tUN5cxqLicA==
X-Received: by 2002:a05:600c:4e15:b0:485:2ce2:4c8a with SMTP id
 5b1f17b1804b1-48727d67a21mr249760345e9.1.1774943632033; 
 Tue, 31 Mar 2026 00:53:52 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4887c561750sm23889915e9.2.2026.03.31.00.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 00:53:51 -0700 (PDT)
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
Subject: [PATCH v4 3/5] misc: fw_loader: implement generic
 get_fw_loader_from_node()
Date: Tue, 31 Mar 2026 09:53:22 +0200
Message-ID: <20260331075338.2391-4-ansuelsmth@gmail.com>
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

Implement a generic function to get a FW loader dev from a node.

There is currently only get_fs_loader() but that is limited to chosen
node and is limited only to FS loader.

Introduce get_fw_loader_from_node() that will parse the
"firmware-loader" from a specified node and will loop over all the
available FW loader until one is found (as it will be probed by the
dedicated compatible)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/misc/fw_loader/fw_loader.c | 40 ++++++++++++++++++++++++++++++
 include/fw_loader.h                | 15 +++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
index 644b98de9f6c..2738d42d4721 100644
--- a/drivers/misc/fw_loader/fw_loader.c
+++ b/drivers/misc/fw_loader/fw_loader.c
@@ -8,6 +8,7 @@
 #include <blk.h>
 #include <linux/types.h>
 #include <dm/device.h>
+#include <dm/uclass.h>
 #include <fw_loader.h>
 
 #ifdef CONFIG_CMD_UBIFS
@@ -90,6 +91,45 @@ int generic_fw_loader_probe(struct udevice *dev)
 	return 0;
 }
 
+static int fw_loaders[] = {
+#if CONFIG_IS_ENABLED(FS_LOADER)
+	UCLASS_FS_FIRMWARE_LOADER,
+#endif
+};
+
+/**
+ * get_fw_loader_from_node - Get FW loader dev from @node.
+ *
+ * @node: ofnode where "firmware-loader" phandle is stored.
+ * @dev: pointer where to store the FW loader dev.
+ *
+ * Loop over all the supported FW loader and find a matching
+ * one.
+ *
+ * Return: Negative value if fail, 0 for successful.
+ */
+int get_fw_loader_from_node(ofnode node, struct udevice **dev)
+{
+	int i, ret;
+
+	node = ofnode_parse_phandle(node, "firmware-loader", 0);
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	/*
+	 * Loop over all the available FW loaders and stop when
+	 * found one.
+	 */
+	for (i = 0; i < ARRAY_SIZE(fw_loaders); i++) {
+		ret = uclass_get_device_by_ofnode(fw_loaders[i],
+						  node, dev);
+		if (!ret)
+			return 0;
+	}
+
+	return -ENODEV;
+}
+
 /**
  * _request_firmware_prepare - Prepare firmware struct.
  *
diff --git a/include/fw_loader.h b/include/fw_loader.h
index 56f5e3be6195..7053c7bc6f05 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -6,8 +6,23 @@
 #ifndef _FW_LOADER_H_
 #define _FW_LOADER_H_
 
+#include <dm/ofnode_decl.h>
+
 struct udevice;
 
+/**
+ * get_fw_loader_from_node - Get FW loader dev from @node.
+ *
+ * @node: ofnode where "firmware-loader" phandle is stored.
+ * @dev: pointer where to store the FW loader dev.
+ *
+ * Loop over all the supported FW loader and find a matching
+ * one.
+ *
+ * Return: Negative value if fail, 0 for successful.
+ */
+int get_fw_loader_from_node(ofnode node, struct udevice **dev);
+
 /**
  * request_firmware_into_buf - Load firmware into a previously allocated buffer.
  * @dev: An instance of a driver.
-- 
2.53.0

