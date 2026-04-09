Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7DFEA3C4E
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0711384199;
	Thu,  9 Apr 2026 15:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j9oY/3Gn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4E22840D8; Thu,  9 Apr 2026 15:33:25 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5E3F840D8
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 15:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-483487335c2so9608985e9.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775741603; x=1776346403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wom+wv5EWByyc+JYGuIFn6ETumtVEz+CC387lA5LnVQ=;
 b=j9oY/3GnExnE0fzAxPLBTI7youpvyPubArfh8t6xh6/MlQGrX3tHtJiAaYB6e8qg3g
 PsyLnvp0mEOpuo9JSc92zBqd9PQOuE1yLFfuaa/2Ja4nDBaxKKI8UwPfsVkTO6HC2XKj
 EKI3sp+BZfxNIXJeIG7y9/hdh7Aj/VHDc3DACCUz71Aqn5rb6c2mRTJPF1kTJMDUEwcm
 hdmAk3rTl1khIck1dQnS1P9pV8UVHidwG7G05PHnaCqLP2LOXvjW1Lr9aH8szL441ekS
 36ShvFAPmvFNlQ9k5abLpIpwV2JS7rGqlvOb/cJDpiqwu4LYwOAc3oAN0AwmnnBEAJWS
 yfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775741603; x=1776346403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Wom+wv5EWByyc+JYGuIFn6ETumtVEz+CC387lA5LnVQ=;
 b=MlTrARzeKiUXtLefV1zRQtOyyyvQq4tNzXisQtAlEmzvhhytYZUIZgqCeSA4ULxNd2
 5CfGTlTUS/DOrAeq3q0Ccj3Of13t1NSo6/tnbjr+cKJcJnqr1LTyiFradgKqeDPkAEou
 i57bJTmdRp6c6faVeUMvU4CkBwgP9XGQrj7FBdl7pkXYojS8p4hdPEzWawzX+GkQHweT
 aOLbYy1oIPSgJ3ZotaYr/XKdx3LX2jJPkhOP3c/RMkwvAqn9qzlFBo0w54aVmAubfwUb
 NuKdB/YtufzPW47hJmKX9ctfi9GBd/Kdsdm4VmZtKSlRMf9Peoxdzg4BTxTiZA+PpdSF
 j96Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6WYqB038Isuva92qSs2qISXmSYZA7CytdmLqgJHuQ9TYia/P4+2XmjGQOxfn1fVLvBQf4mwg=@lists.denx.de
X-Gm-Message-State: AOJu0YwFtP76Og81fIsI+Hs2KZNruUxNKMJPtkOKDYDcHJrNFQyzD+zg
 ZuD4fpMa0dS+IwJqAMRMp8PCQg+4ACytNuL3dT7HDZu8Me026ZKNWR1j
X-Gm-Gg: AeBDievpIfedhXYTlCzmHgqDK+vwbd0NTKAU8IzqEM6eRz8SJ+9tzFUNYqtOSGfj/+W
 v6TEY2Q6iJ0GkChl+oKaVJUGajMm4Zgmt0+uGcVKBmXYQQvtbcadx0nSHJHbCFoz969Upvzb9cL
 GA4l3AMzK4kp3SJL8vwQ4QqTTgm3M7s96rqNW03pxB9qKkeJJhqyAu8ac7j9GqDNAyMvWHA8Ugf
 LWfT2Nh3vJ0BUfhUlJlFRd/uK8axebcad8HFc4AQXZqugZlQP62ia6mMEneTxx9yy3NaOiGmdv8
 fpbhDGl6jfUVlRMGumkf8w2RHdyaXDi3/15LO7LEVMGYUFsJFdMcqprG0izUxnYNM27sa1+w17L
 8tW2XoG+hGWoeY1mBUTNPlp/juKxprBaG7aVLihKp6/ub6nbE5zf147v7uACj50i+bkwJRL4o/H
 konFMjhrywD0leDutiiAqUsHydB/o6H6Cp+9hIte0PHhKyxlzq4cCTYhSXD7MHUHtmZb/uW9Y=
X-Received: by 2002:a05:600c:4ecf:b0:488:aa33:dcbd with SMTP id
 5b1f17b1804b1-488aa33e02emr240066665e9.26.1775741603062; 
 Thu, 09 Apr 2026 06:33:23 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-61-192-155.retail.telecomitalia.it.
 [82.61.192.155]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-488ccf9b919sm52876215e9.0.2026.04.09.06.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 06:33:22 -0700 (PDT)
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
Subject: [PATCH v6 3/6] misc: fw_loader: implement generic
 get_fw_loader_from_node()
Date: Thu,  9 Apr 2026 15:32:59 +0200
Message-ID: <20260409133303.31875-4-ansuelsmth@gmail.com>
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
index 16a1fe2d4a65..c32c213b5b38 100644
--- a/drivers/misc/fw_loader/fw_loader-uclass.c
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -9,6 +9,8 @@
 #include <linux/types.h>
 #include <dm.h>
 #include <dm/device.h>
+#include <dm/device-internal.h>
+#include <dm/uclass.h>
 #include <fw_loader.h>
 
 #ifdef CONFIG_CMD_UBIFS
@@ -96,6 +98,27 @@ UCLASS_DRIVER(fw_loader) = {
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

