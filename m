Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E621FCC05D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 19:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B8CF83FC6;
	Fri,  6 Mar 2026 20:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZfM3dtgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ABC183FC6; Fri,  6 Mar 2026 20:06:04 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1663283F75
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 20:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439b790af67so3671508f8f.0
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 11:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772823961; x=1773428761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=msIw5A8lEbdTRGIO/KUE6Rc99lCKIZcRhUbF273WHOs=;
 b=ZfM3dtgZmkWL8u32lwIXt6JVnkoOChnQkrZysv2iUlAXXRWnchsw16k1egWck+d8rZ
 L2rKq66YZugkZ/f5/RMzujnh03jNR9tSWF0Dy8ryErWLM2+UqRD2FZWJYRtCAXSN7McD
 TtljRe+5WH2rn+qf2naeyC+LnZzqGK1DIxTpKpZqeXVY0DFZgolsilYD/QSk/CSKAOWu
 QzRR9EKyt+4Ch58mwe5MAFee5R17GNKj9KOs6DpCtIrdoInRqSSEDKNRo36nw3T6UYi9
 M8+8fIMYxu1PAIjHqXvXI1yUosTzWuxQiU7LBd9htAR29tCKtb/E0ollMotmXrywtRN5
 uKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772823961; x=1773428761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=msIw5A8lEbdTRGIO/KUE6Rc99lCKIZcRhUbF273WHOs=;
 b=THsomACV6W2ATkqrt6m4onJ1KWaPMp8Uf/Xb/Oqt1gGQ6OGDb8L0R6ZCu0f03iQkVx
 Q6H/OlbMRFWlEDb0o2mILr3Lb6Zzf/O/GmGYNSMYYqrBTkqT4WCPOxVH8vLN8DvJFswd
 fWGtps61eA3BbgyRI49cgECIlU3iqr3pu25Q+/MjQJStIfWYCakEZCHTmL/Nschmo15T
 I9F2+gfrm/qdsfx6Ldqlx8CUtd1A2QpxBx2cMIRgKAGpP/13glFfAz2N9ir9Ms+Z2Tr4
 X+LQ4CQeZ5yyTL2mTUoHxdKJkH4PCtnwMruIK31zGpXzZWAAJxAv9I0hOY50LiG8ae4f
 +LtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOEojro0C9WZ/6HJ1GiFBgnsdtfKZ0c84Cpr6y43tIXpCJ6cefa6hHrZIOI7QiTKr7fNebcY4=@lists.denx.de
X-Gm-Message-State: AOJu0YxuV8nFRDobuWVcnOYoPgMZbvZnHO52cjLwIK0jQTvwaR6W8n7h
 f6rsTbfxjVCPd75iLykjyse47qwLR2DfI1cYvkFLP+47YR7Zbpl2EzKq
X-Gm-Gg: ATEYQzyHuww7bHQqYdRWuIFZt+M6wlUKQ56FIZawavthKj/1q9SZlET0c5h8nsrbtHu
 vC83Or2JUaNnRKLhZWTfzuIGinHztw8yclSj3cEzVqOHPYy/Gvs7jOp5qUBWjZp5KJVZ7TPp4aI
 Llly6XjPWn+ig0VD3WX1SV9oBw2Nd0wjPWGGZ0KRUhAxJ513sZrVFQL6HtEQ5XywHuRv2EHg/6Y
 TSCbyHY8x1GhvGYcwAIEVyPxsB48NaH4uRTFl+FTSdb6fzM5oelZYYeQUAC1zQaLudGyB4QBpGW
 3i1x5qOFq47Cn3FavnNG2BDdUWJdbDVpfdCcrg/tqNAKs5bWsqo28/BNe6tW+yFZ8B+4m3DJzHy
 N+lhy5CbOesxb9yD+Sdl3z9H4wwt6dYQYznkqZvjdYNabu0jwn9+Dk7Yag0xCRsLBQ5shE7FZ3k
 FKoBcxpzTspFAPEwif01DHe6XAMjKSRG/a6kg6lts5sIfwBlkzEON9Buc=
X-Received: by 2002:a05:6000:288d:b0:439:c9fb:c552 with SMTP id
 ffacd0b85a97d-439da556c78mr5989598f8f.19.1772823961191; 
 Fri, 06 Mar 2026 11:06:01 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-439dae45786sm6701065f8f.32.2026.03.06.11.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:06:00 -0800 (PST)
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
Subject: [PATCH v2 3/5] misc: fw_loader: implement generic
 get_fw_loader_from_node()
Date: Fri,  6 Mar 2026 20:05:37 +0100
Message-ID: <20260306190542.22920-4-ansuelsmth@gmail.com>
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
 include/fw_loader.h                | 15 +++++++++++
 2 files changed, 55 insertions(+)

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
2.51.0

