Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCE8FED9E7
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 15:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88871843E4;
	Tue, 17 Mar 2026 16:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KDv/b3h9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7638843B9; Tue, 17 Mar 2026 16:36:38 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF3398437C
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4853aec185aso48752955e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773761796; x=1774366596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k/6kSpsJEZwed2v18IcSrdq03Zwo71Wq4qJQ0bw02Rw=;
 b=KDv/b3h96HDXyfARcpJGH1koV2c4xE3dU4OMcahD/iAnJ5PtnzyT6yUzdE0zf/gPEw
 u3wq5lm9CTyXErHbpeoz+n7fC+EDHjH2m/zHEVad1z0vvYrxQa0xsPs+PGlzKU2sjDhP
 Sl64du0aoFDpDpuJ3XhcbzWzjNgkXrRS1sT8mTpFoz6YeXuZGLzXQ9PY1CQIbhRb0krl
 33Aad4a7WcEYOAYBMomE34qTALcrjxbNPuiOzSCqpkIekNQvVXGsj+DJDUQeV+Fq5Imv
 RbJKLL5U8A91aTktVdegMYR0c9jNTQNWLEgA1GAC7H25kAvlZ9605Z9ZVYQgo/8pOrSy
 Wb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773761796; x=1774366596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k/6kSpsJEZwed2v18IcSrdq03Zwo71Wq4qJQ0bw02Rw=;
 b=djZIHcJzvcRAI7V4qwu+dMGhNxiDUz4w0nIH7YJsOXNhsNEM9xguIB4iO9i1/tY9Ix
 rfu/o/3sJZFmT7TTOEDxl6Vap3ovK2ePKKOFPR1V3MmYzcLLTba+4uwfx7TCSiFDWc//
 S8ApybpjjxOGnNKPXb2n98UkxlOmoVuxZ6yIMi27/vHmVXKnmwB2SI0DqmPEX3AqbNPU
 QHL5NWv6q9++BHFLJW3sw+B4w+VieJUjylSEbkyItL+022oIlr4vQCv0pncOvnIM3syC
 NJeZYX0Bm9Iu5mtWWoIuz5rC5Bb1KU5MIi45Zi2mlZRwR7RACBJudmaj12gEyztM/+fc
 xIaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZHNyhbyXGDTtJudX9+LJH2tfqel4bX2bGfiYuQ/iiOkyvUMDWdTQI7Dbr7Y/7/I6ObFTX0OM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxboyn7/7OZaS9tO4h6lJScd6NOXh+hJu/bTitaMc75kOQwYHoE
 gQwTu6SKAEYKTycNIUFdJN9IFE5i7cDfRu9eP2A4AOI1L9WozPSz7GLF
X-Gm-Gg: ATEYQzygGDFB1Fbgu2LuaeMKEtGBmpD8gNN3DTQVBb/rn1yYPTyzyPix0zKbDQIXCZ4
 f3Y7hJ3Hwroi6IM4CkAWJWRxKifxRnoPe7XigeTczq0Jq9Y+M0gMEVR/j81H862j9WecvyDA1vr
 yiS5EcAXFxallkRREA8146zThLK5QkWm4FQBe4T+d3MM82siGyyrjVr4KmtDEO3AoQYRyNGWWA6
 Ua7sOJFbyEp1dfZZ5nFmDLBs867iGIHfcnZwzTPTt7k8wTyz9eNJ4ezTQ33pWNdKbELRytdTm9b
 +F4LSUBBczuRaBWkJp83L6jihSyZMiQVg/SSjBsqHDgLd6PXrqdYMiIedSYjiN59RzkFpZEFMwv
 f1g/2zQRSXQhmPPTdtduMMFZCroSwGEjNOiYg1GLn/uq3lA0sAcU/Cu7AeJhA91VvoI6zaX8Vxk
 +ceEk5bTgY5atTzfaxbrUpHTV136+OcuzvWflOXmiPxfNpAUhbHnXC9C8=
X-Received: by 2002:a05:600c:1395:b0:485:2fc5:3a5 with SMTP id
 5b1f17b1804b1-48556709d85mr283413815e9.26.1773761795894; 
 Tue, 17 Mar 2026 08:36:35 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-48556414295sm200870485e9.3.2026.03.17.08.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 08:36:35 -0700 (PDT)
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
Subject: [PATCH v3 3/5] misc: fw_loader: implement generic
 get_fw_loader_from_node()
Date: Tue, 17 Mar 2026 16:36:07 +0100
Message-ID: <20260317153614.18409-4-ansuelsmth@gmail.com>
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

