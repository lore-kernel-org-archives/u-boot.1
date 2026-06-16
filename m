Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C3ECD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 19:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B90A784949;
	Tue, 16 Jun 2026 21:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VoNFKYQE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D388F848C5; Tue, 16 Jun 2026 21:19:00 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F72848DF
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 21:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4922244f7c7so30898885e9.0
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781637538; x=1782242338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aoLEw7Z4a8ZtemFZ6orX08o2o8wnI61Jxsz9rouocqw=;
 b=VoNFKYQE8f+uSsMtVBLHfeKTsFQx6ahUAhbKoLGRT537j5rrPqaYNDYmK0kzYhY6R/
 TE+rR2vZKosWPYngwvHhUduOuqKjtoVAHUREDulUEyGamPetnVQ6uj2HZV5fE/JIo6Aj
 akjVff94/7DqThL5CPco4HKHK4l6rErVT/4U0ZfzW94zk3tmR6QijEHF3c2OljZL96m7
 8Gm4EC0Xkq8nkF75h+nqVbFy2xD3wgSpk1HwqHcJII3khuGe5UQVGIUgpNDvDy48t2n5
 XwyvWTRAerzDp2TpfGUi19+Mm++T7+UdKLNYYFU/WaCTMEBvAKceID0PtbHHtt2tS6kL
 4Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637538; x=1782242338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aoLEw7Z4a8ZtemFZ6orX08o2o8wnI61Jxsz9rouocqw=;
 b=gJeRofrM0fv1podHYTrFOFtmw+gCzQ1mSrvgrtTGQs+cX4sX2MWzTjyugHIzDOb3AN
 69Ou/6oWLhzf0DpvKyobJUUTo/MTM+QoQOej+fHcH7uWC3TgsL6dSaxJF7SUe8r4EVwn
 O1o4fjeyDcBjwjET+6e57LXk+wkO6hRQlFrMzvQ3Aeju18sc1JhU5qHx7gXJDYzQHM/n
 Fkyz6FvVWPoLUokxQKWYpegPnoIU5hLSZq2/2H76J/weZo6OZy8gtceUeqTM1qE662ra
 sO3UR5yRBgbNzhHbMd/jnisJnb6B+QfQkACrxQTZjSLsLXt1xPEBOz0tKbKzOKeCenuR
 SLyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/d46bEzfmOCXUM7TXkbjY4HMzjwne4EXMbD5AUmzmqoCl8WSBC6p1T6La+WOJlTRQCOShrQbk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz309N2K3ehWR4HleJnQpax12/aATpGnbArd3G5gIwcWZaTunZx
 bUUJj33MBsI67Jx0rW80B+7K279K5L580N4fFAeREsjjFnPTB784QTgD
X-Gm-Gg: Acq92OHuB2nxEpGzstihvQV53Z/exuYmAK4s/D/CbpuK3rw6d2kEDiT1hZzMqLjnYRB
 ZOYU8346FGvNyeiI7ErTVYhlGEbxtLLTu1YtcOjzuAVkruSyqgbesMTmLYlOZNCq4qZnL13W3WC
 xcidouGRqikbXC6E0RuGHhMnLBCdgLnJvH3atP3lxTW4VcpAFFwOM2juDwD72GHwVARMs8bRjrA
 vpbl3cK6C+ne8UdNssDqTUyL554stU7rjIWHMji9xjOmoqcPA+klT1QSbZ2b6jBgSwg4m+mpaxb
 I+vqDVab9UW5fz4HagYUM0Ln+FYmpPXYymfYFZorh41yyTOp1zOoNWGHxWHKqefg1u1CXZXbERm
 witV10CkDMmFL8m53nMzycsbqvS5/RELbrXumKUD5e70EO1oG469R94fyKxLxS/DrqnbycFJ5nX
 G6mn0Nq/m7p26jo/OGHMTSRdP0fWOSW4ROdLh4j9GXkk/lk0YAPtvmTGc=
X-Received: by 2002:a05:600c:8b88:b0:48a:906b:14ca with SMTP id
 5b1f17b1804b1-492333c94e9mr12033815e9.20.1781637538100; 
 Tue, 16 Jun 2026 12:18:58 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4922f9cd140sm91326895e9.0.2026.06.16.12.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:18:57 -0700 (PDT)
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
Subject: [PATCH v7 3/7] misc: fw_loader: implement generic
 get_fw_loader_from_node()
Date: Tue, 16 Jun 2026 21:18:38 +0200
Message-ID: <20260616191845.6182-4-ansuelsmth@gmail.com>
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

Implement a generic function to get a FW loader dev from a node.

There is currently only get_fs_loader() but that is limited to chosen
node and is limited only to FS loader.

Introduce get_fw_loader_from_node() that will parse the
"firmware-loader" from a specified node and will search and probe a
matching FW loader device, if found.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fw_loader-uclass.c | 23 +++++++++++++++++++++++
 include/fw_loader.h                       | 14 ++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
index 25bad7f7d701..d77d877a9eaa 100644
--- a/drivers/misc/fw_loader/fw_loader-uclass.c
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -9,6 +9,8 @@
 #include <linux/types.h>
 #include <dm.h>
 #include <dm/device.h>
+#include <dm/device-internal.h>
+#include <dm/uclass.h>
 #include <fw_loader.h>
 
 #if CONFIG_IS_ENABLED(CMD_UBIFS)
@@ -108,6 +110,27 @@ UCLASS_DRIVER(fw_loader) = {
 	.per_device_auto = sizeof(struct firmware),
 };
 
+int get_fw_loader_from_node(ofnode node, struct udevice **dev)
+{
+	struct udevice *fw_dev;
+	int ret;
+
+	node = ofnode_parse_phandle(node, "firmware-loader", 0);
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	ret = device_find_global_by_ofnode(node, &fw_dev);
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
index 56f5e3be6195..99c47380a172 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -6,8 +6,22 @@
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
+ * Search and probe a matching FW loader device, if found.
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

