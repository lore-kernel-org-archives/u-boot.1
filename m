Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BA7E8536E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 13:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A8D083CF5;
	Fri,  3 Apr 2026 15:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bnsAm92a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 134C084106; Fri,  3 Apr 2026 15:52:25 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A70383642
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 15:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-486fba7ce4cso21031165e9.3
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775224342; x=1775829142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FpGY0w16smbsfp4yVZg3H6HPl0bjoC+Muh3Sv0+eOYQ=;
 b=bnsAm92aztZMX8P9u7PADFrUJ7kleLqYufuTeU4WOM1JoBBRCYznANIPZd/SzzeW/a
 6pV46QFnfI2VOkfJ8qv/oimBbw/fMnAnW1J30mYxp9HGYFKWhBwK1GN8SfIUupaXd+4Z
 HIMsuRkrZ1jVkl91AZUCuBuNV8c1r5Xcx+2+6mxjWwPxmdhWmJuztKqrFSWIjBDWHjAy
 B9n1PeadpeOpPlySKQ+GU42/so0DJaNp7ucuSr0N2QmFQV1Cg4xBA6tQlN3wVqMP7Isv
 9V1mD/5CvLGIwMzkOEivtpckMZACj8Ed6G6bEV+T83kWtHcNmZKSrUzcnRarBuNWqeki
 kE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775224342; x=1775829142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FpGY0w16smbsfp4yVZg3H6HPl0bjoC+Muh3Sv0+eOYQ=;
 b=Ct19WE+4CED6PlVjcRRBPq+aLSXvhoVE0aIPIFWkC6tBVbbTVRXuZbI9/wo2oRDzqL
 NOG8g+UspTNDqP3TX0a3eiqiaJcK/WXiWi3485GG3y2RUsqVhgeC5IZOQbeHwAdIy+oE
 Ukldht/D0oiLYNsoXkfP/p2TW3V2Li1yE1tnMMOf+79Kav6cSquvQt/yPkz1ShFJLe83
 RjA2bguoolzn5uTV8vBDwwznTyOKeocu66/OCfeHDHss+tyekhIugM1+IJSRnJhx2ROX
 6HXYVs6z54C6pMPzMpKd4yOhP/HVs3AYpCTJD4K5ruayO1vJcmwpkrOu5ZV7f4K3CzAX
 a1kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoFtWiMkEtvzu0yTnIPOAs32gN8ZIbW3lYiRpd0qXEvBd019lmGjSbEoprz0EMEqryWHOl2Kg=@lists.denx.de
X-Gm-Message-State: AOJu0YzRN9X/4CWfdNHN+H2OQleSzt69C1c78910LeY5e34xMzJWS/9+
 QPxAUTchogR+BOTMPOdf4lCoFNQSKynsgACezae6swG1sB/u2bZcsKhJ
X-Gm-Gg: ATEYQzx4KShjZBbytdldFqx73NHozZOWbLDKs7u4bcXCME9AuOem3bPMCMOoEAtzOf4
 Y5b+QIu6DNDcf0gqjsZvz1AI6sVEV/pkDEYcYRE04+jiESInMtxS8abgvH4zQebIjmK1uff3KvL
 jbj65AnBhXw7a1bMng4D4RD05MEeMGT8MjjJfWjpJNH1HFL0PZpY35IcMD6yGAKlXhs4/XMvkLp
 jkLaf4yNNzOfY9jW1SZuQ69MMw4iDnc2WzFkcurFcJY35iku4yT6E0n+mrDOM53qOUBfqcakL8m
 cWEijklEIr21kPTGconr5sbvZ/9ojmiG6qW+Siz8jdo7cisH+4rvPd9uLVCC5blZ4/0ySEtrNWC
 EZka7UiNWZstAoSrW/06KbfD+fvq3aqDQV0hhoyw34ziKVsf05bwf5qF9N8fe5WaqpEeHPzTxRU
 YXRj6qAPg1dB2JdRz0q6y/QDA=
X-Received: by 2002:a05:600c:1381:b0:485:6e40:5584 with SMTP id
 5b1f17b1804b1-488996afdaemr51460915e9.6.1775224341778; 
 Fri, 03 Apr 2026 06:52:21 -0700 (PDT)
Received: from Ansuel-XPS24 ([217.202.87.54])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4888a7162cesm196732895e9.13.2026.04.03.06.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 06:52:21 -0700 (PDT)
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
Subject: [PATCH v5 3/6] misc: fw_loader: implement generic
 get_fw_loader_from_node()
Date: Fri,  3 Apr 2026 15:52:00 +0200
Message-ID: <20260403135205.26979-4-ansuelsmth@gmail.com>
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

Implement a generic function to get a FW loader dev from a node.

There is currently only get_fs_loader() but that is limited to chosen
node and is limited only to FS loader.

Introduce get_fw_loader_from_node() that will parse the
"firmware-loader" from a specified node and will search and probe a
matching FW loader device, if found.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fw_loader.c | 32 ++++++++++++++++++++++++++++++
 include/fw_loader.h                | 15 ++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
index 644b98de9f6c..c3d0de1b93e7 100644
--- a/drivers/misc/fw_loader/fw_loader.c
+++ b/drivers/misc/fw_loader/fw_loader.c
@@ -8,6 +8,7 @@
 #include <blk.h>
 #include <linux/types.h>
 #include <dm/device.h>
+#include <dm/uclass.h>
 #include <fw_loader.h>
 
 #ifdef CONFIG_CMD_UBIFS
@@ -90,6 +91,37 @@ int generic_fw_loader_probe(struct udevice *dev)
 	return 0;
 }
 
+/**
+ * get_fw_loader_from_node - Get FW loader dev from @node.
+ *
+ * @node: ofnode where "firmware-loader" phandle is stored.
+ * @dev: pointer where to store the FW loader dev.
+ *
+ * Search and probe a matching FW loader device, if found.
+ *
+ * Return: Negative value if fail, 0 for successful.
+ */
+int get_fw_loader_from_node(ofnode node, struct udevice **dev)
+{
+	struct udevice *fw_dev;
+	int i, ret;
+
+	node = ofnode_parse_phandle(node, "firmware-loader", 0);
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	ret = device_find_global_by_ofnode(node, &fw_dev)
+	if (ret)
+		return ret;
+
+	ret = device_probe(fw_dev);
+	if (ret)
+		return ret;
+
+	*dev = fw_dev;
+	return 0;
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

