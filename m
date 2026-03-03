Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20341EC1444
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 13:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DDCA83F69;
	Tue,  3 Mar 2026 14:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y1HxoQxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0C1E83F8E; Tue,  3 Mar 2026 14:29:32 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C59F83F69
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 14:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48379a42f76so46467685e9.0
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 05:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772544570; x=1773149370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oVl1yyb04sqyotD0alUiBVB1SuuEGiZYrazc8GyLc0U=;
 b=Y1HxoQxjYVXZAUO+2frFI2WBTuRDy0MEWYmeoxswirGo4qTtOESO4oiTwd1BOGX70l
 JWFU87wOuWJ778IvNImasa2FoDxrkhNRg4rvzffdw+wnN02jf0TKbATL4mYJlc1p3fyp
 QEmBXlm+AbXN0JMpzdAm0KzY1zymQaeMndnS+2O0CO3B83d/yojlK+PECT3lQBvvcoKg
 tvxPZsE/0Vn2t0L7IP11EnmNF9Ksj1dIF2TYDgI8USbhkCEExGVlwnpVZs8kP5WxlswS
 xJOg663C+F7DXGBaU8qFBgtHeKVznqvcRk3zzpM89v6p6YYW5aRFFB5lCVLgN/1i80u6
 em9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772544570; x=1773149370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oVl1yyb04sqyotD0alUiBVB1SuuEGiZYrazc8GyLc0U=;
 b=w4pyhWDl9b60kW80sW4hhFpRnh3LObTFT5LJqykjdHHxFc7H5rmGwVpWti28ne4OeV
 gZamjDRXn28cQZVMW0ShsjX/bUDbk3LsIG+4BPp1na7q9GaYxLAwkoIZPAUowzZ6V451
 lqXqkwoskZPJAr3hSkCd0vsetzHCnn9oZSmYQ+1DKjFzr+gqMRogrKLTvES8lwl88lxq
 bpHFrqPOWhweE4S4C3RBIGicI8BeCam6yT+KXYp+g6WZ0E5g1+Esh3MvISIuI+K9Vljm
 VyIvme4ENuFeZJ9BXxt/dTm2RFiaZkVB4GB+3Vz9fKHdGLCi4/3zCMq2BpMAiaHw/RR8
 1OFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT8GmiKAKN58oV2Q2GfIcQzXg/MhtXKHpdhSYSItAf2vjsGA7yhTRyANcbHWhNRws6WhXE3do=@lists.denx.de
X-Gm-Message-State: AOJu0YyYN1W7zbc7VYsTUgehcqzBn5QNl6YJkCzq8+xKDXQ66LJNOZMR
 z9pOSQLO8Z7Zv77gHIJyNa1MlKV1vvwM96fOGsXCObixHlemayxADsvyDGjLQA==
X-Gm-Gg: ATEYQzyqviZI+2Edcx9ADR3EJA2bdaFYWXP+eToQG0oIEunZi7m4+AKJrhuKKJQsUzQ
 3Z9EKWeZfj6v4o4UCE3rx0ACli0AXQzsmqIU2RACeGY3jv3AkBCwjwke7s4SKvT9roORy2ysvfp
 TONBgNbLDErJtHWaH6GvifN8UG+h4i2eQM1gcTjoT4CKkjjByJcsOWfVmwzGyywiwgqUO0/20A3
 gykLHYy+m4oEdj9wXeqQe5iHx7ZCv77XhxXuwlxAxtMgGOARLRH8MvpiEKUqIBcrRJ6JwkBg0jf
 96hVG0n74rCr5vD39/CAre9tSMY9Jrfd8FRXizaQZGs6LrsWF7g3J8eYLEHM1dfe8gYRK4IBTNx
 tMWo2WpAiAvqW0jdWnKvWQ02xWk2QnmkfcgLol6Xjr6IRemhN/IeicrFVTVYYk6MWtxTVNMzwRL
 x2a/QwFk5iE8Blb1n5SOkC7ueBxL4kIwfPw0GyWABpB2fxV+Hsxat1nU1Wtl3VnbnuiA==
X-Received: by 2002:a05:600c:c167:b0:483:7020:864 with SMTP id
 5b1f17b1804b1-483c9c0fb66mr242227765e9.25.1772544569379; 
 Tue, 03 Mar 2026 05:29:29 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483bd68826asm772625095e9.0.2026.03.03.05.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 05:29:28 -0800 (PST)
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
Subject: [PATCH 3/5] misc: fw_loader: implement generic
 get_fw_loader_from_node()
Date: Tue,  3 Mar 2026 14:29:10 +0100
Message-ID: <20260303132916.5502-4-ansuelsmth@gmail.com>
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

Implement a generic function to get a FW loader dev from a node.

There is currently only get_fs_loader() but that is limited to chosen
node and is limited only to FS loader.

Introduce get_fw_loader_from_node() that will parse the
"firmware-loader" from a specified node and will loop over all the
available FW loader until one is found (as it will be probed by the
dedicated compatible)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fw_loader.c | 40 ++++++++++++++++++++++++++++++
 include/fw_loader.h                | 13 ++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
index 6459ba23a15b..e477a631fae3 100644
--- a/drivers/misc/fw_loader/fw_loader.c
+++ b/drivers/misc/fw_loader/fw_loader.c
@@ -8,6 +8,7 @@
 #include <blk.h>
 #include <linux/types.h>
 #include <dm/device.h>
+#include <dm/uclass.h>
 #include <fw_loader.h>
 
 #include "internal.h"
@@ -67,6 +68,45 @@ int generic_fw_loader_probe(struct udevice *dev)
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
index 56f5e3be6195..d07306c0674f 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -8,6 +8,19 @@
 
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
2.51.0

