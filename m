Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B853E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5975A806F6;
	Wed,  1 Jan 2025 23:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wj2k4f9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 349938042F; Wed,  1 Jan 2025 23:23:20 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4729806F6
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2163b0c09afso143592425ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770195; x=1736374995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J207QZG/aUA8Vy/GcSpFRC2hvQidpmIPCbDnCfJ8dhA=;
 b=Wj2k4f9XP8M+/Z93s7uhr7WJVRduRCmE/A22/mjaEQ7FvndOZjGCqmzWjcATtdsEny
 9g1oySEGOM7seFkI5UI1o6d1Gi5IBdAQi6tM9YkyGXZwUCSDXeDgqZMIC0YP0LJkfP+K
 24QGMIdjHrsedds1qcgMkQDTti9lc0K4q0j7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770195; x=1736374995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J207QZG/aUA8Vy/GcSpFRC2hvQidpmIPCbDnCfJ8dhA=;
 b=TJHOcMYBkEjGoanJxTn96gkfLg8dSixhK4eIRzbnb3NNJcy9GKNBj05s/XwBFR7XlL
 BH96XHDq2ydPB1REFkb2BCLlEadyAZV4nF8tjubN0+xYiw+MzPa4iPrkIDqEcM0LxauR
 myfGrhulTRxgD9UJKCEqw4dxC1UqrsnfZ0iSvxREceCXOuRVT7cM2Nevc3dQ0X83T3go
 d9ySI0oeq/Cg/ETwebTTl90eXZRm+AnizYbWfiGKKOxkceoPlL7SlbEPXr9jydmJFj2X
 Ij2eZ5qLh4PxXHiklslOTXQ1L1HPgDdmqZLSJaQQtnnlusjEL/S2fpJK5sQ/k9apEDos
 FZnw==
X-Gm-Message-State: AOJu0Yzl6ppk7zXEl874iajxtzjmnEPjcWyTN5IG+fSTUcg8YFw4P9bD
 X05Jd9b0kpVN7+BPC2DuxMMnsN/XC7+p/ZNUxPyy8vluzjzPYmwEtGZQ+WETgD3VNbl/3H7kM1s
 =
X-Gm-Gg: ASbGnctBzNerY/Bzfx6LI8MHlM1SzBob7tD/Uh+zekQGZ0iabYK5uPUifVe1NfdVDFX
 yLb727P4Dh/8WXOHDE3Qbgr+Djbr4nZ+UqO/pTOh/MN7DvfdLcTrJDJbysfuIBAwxxpIHI1yeSW
 veft0NrCv7jGZ8S+xXR1zOZAPDuiHDAbqmfy2RwLQiKrgrXIN66eztE5hgu5JLeYnejK8ZVOhUk
 gKvIMgtQBuKfgdsHp8Sa7WCupRgMmzS4EvfvuiBbyMXJvv3pTOu2mI=
X-Google-Smtp-Source: AGHT+IExn8vVJn5xxLxB1zXyBvAnqbs6MPIqL5o8yVpNUtjN+nsilI3ylXk+v+yXNirlnpvcQjdlJQ==
X-Received: by 2002:a05:6a20:9144:b0:1e0:d1db:4d8a with SMTP id
 adf61e73a8af0-1e5e047801cmr66907111637.10.1735770194992; 
 Wed, 01 Jan 2025 14:23:14 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:23:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 61/67] upl: Handle serial on an ISA bus with /chosen node
Date: Thu,  2 Jan 2025 11:09:47 +1300
Message-ID: <20250101221003.1944600-62-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

When the serial port uses I/O ports, it is expected to be on an ISA bus.
Handle this by creating a suitable node and putting the serial port in
that node.

Add a reference to the serial port in the /chosen node.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 include/upl.h    |  3 +++
 test/boot/upl.c  |  1 +
 3 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index eecb56214df..c43a588dc40 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -482,19 +482,48 @@ static int add_upl_serial(const struct upl *upl, ofnode root,
 {
 	const struct upl_serial *ser = &upl->serial;
 	const struct memregion *first;
-	char name[26];
-	ofnode node;
+	char name[26], alias[36];
+	ofnode node, parent;
 	int ret;
 
-	if (!ser->compatible || skip_existing)
+	if (!ser->compatible)
 		return 0;
 	if (!ser->reg.count)
 		return log_msg_ret("ser", -EINVAL);
+
+	ret = ofnode_add_subnode(root, UPLN_CHOSEN, &node);
+	if (ret)
+		return log_msg_ret("uch", ret);
+
+	parent = root;
+	if (ser->access_type == UPLAT_IO) {
+		ret = ofnode_write_string(node, UPLP_STDOUT_PATH, "/isa/serial");
+		if (ret)
+			return log_msg_ret("uc0", ret);
+
+		ret = ofnode_add_subnode(root, "isa", &node);
+		if (ret)
+			return log_msg_ret("uc1", ret);
+		if (ofnode_write_string(node, UPLP_UPL_PARAMS_COMPAT, "isa") ||
+		    add_addr_size_cells(node, 2, 1))
+			return log_msg_ret("uc2", -EINVAL);
+		parent = node;
+		strcpy(alias, "/isa");
+	}
+
 	first = alist_get(&ser->reg, 0, struct memregion);
 	sprintf(name, UPLN_SERIAL "@%llx", first->base);
-	ret = ofnode_add_subnode(root, name, &node);
-	if (ret)
-		return log_msg_ret("img", ret);
+	ret = ofnode_add_subnode(parent, name, &node);
+	if (ret) {
+		if (ret == -EEXIST) {
+			if (skip_existing)
+				return 0;
+		} else {
+			return log_msg_ret("img", ret);
+		}
+	}
+
+	// ret = ofnode_write_string(node, UPLP_COMPATIBLE, "ns8250");
 	ret = ofnode_write_string(node, UPLP_COMPATIBLE, ser->compatible);
 	if (!ret)
 		ret = ofnode_write_u32(node, UPLP_CLOCK_FREQUENCY,
@@ -527,6 +556,11 @@ static int add_upl_serial(const struct upl *upl, ofnode root,
 					 ARRAY_SIZE(access_types),
 					 ser->access_type);
 	}
+	if (!ret) {
+		strlcat(alias, "/", sizeof(alias));
+		strlcat(alias, name, sizeof(alias));
+		ret = ofnode_write_string(node, UPLP_STDOUT_PATH, alias);
+	}
 	if (ret)
 		return log_msg_ret("ser", ret);
 
diff --git a/include/upl.h b/include/upl.h
index 62341f2f719..d5b2cad7196 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -21,6 +21,9 @@ struct unit_test_state;
 #define UPLP_ADDRESS_CELLS	"#address-cells"
 #define UPLP_SIZE_CELLS		"#size-cells"
 
+#define UPLN_CHOSEN		"chosen"
+#define UPLP_STDOUT_PATH	"stdout-path"
+
 #define UPLN_OPTIONS		"options"
 #define UPLN_UPL_PARAMS		"upl-params"
 #define UPLP_UPL_PARAMS_COMPAT	"upl"
diff --git a/test/boot/upl.c b/test/boot/upl.c
index 7171f16e42e..91b7baa75e2 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -6,6 +6,7 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#define LOG_DEBUG
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
 #include <abuf.h>
-- 
2.43.0

