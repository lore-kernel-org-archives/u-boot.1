Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3192FE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC418042A;
	Wed,  1 Jan 2025 23:13:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D50oqV5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F879804CE; Wed,  1 Jan 2025 23:13:01 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2F96803F6
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2161eb95317so151115505ad.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769577; x=1736374377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrPEa8/50jyVBENzPl1VHPuo5sGQaMcmy1297UpBonc=;
 b=D50oqV5QAXS2NG84Hy2JIudmxHOGlIQQ+Xwtf8ziaQmRIzLwuhnsf8FCN2ShjmAL7Y
 BJxSd1kG7PjMLvUn1sduaRQSOmDOMBl4XqsjGpmaza3s9gWS5DuwHxij5reJuFoKANFQ
 EVY/hrVPOW8E+qCw3+k4gKFHgOaPflKXa2q78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769577; x=1736374377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qrPEa8/50jyVBENzPl1VHPuo5sGQaMcmy1297UpBonc=;
 b=b0PpvXwYfy4+++9wrxwfaoekH0F3xqtgWcd0WfbDvZVa86KCGamUWmYusvhuaXelNR
 2gzI/MFoB+jOcx53esG/PO8voLapPUh5D11K80oi7mhkIVwaOogVZSr2dYucL2dHbUxA
 hVXjjedE8ogDNabZtG3tksr38Sx45p+5oHYLIxy2jW4cE7qpjnE6AkmvE8nn+Jt7Spw3
 Ln/ddXH/1tmtfW9kF60utUJVuIZbaFrBFGnhV8tyCprWjZ414yP7d3dK+xmdkrZvieps
 Nhyu1fiTqwLFxL15rY8Ngs1bDQsRGhHyYm2LG/XU4CBtt0d0g4b8manJToRAciZ0/gnC
 W4Lw==
X-Gm-Message-State: AOJu0YxEml8dqIp0YztD+TjpDQBDyQBV+XE4LbXUlb344eiUM0CyZoG/
 fQpAGNANPdrgO2kNv/NU7onv+6FKWWL5dglw/iswVL4VtVa5bUm8xy/Erwiy0RJotfpk8PTzzIo
 =
X-Gm-Gg: ASbGnctw7yOETUvzYtbiDude7ROA+oBR+iRF8OlE+OCAjg4hdbo2aVYvpvqoaVY9A3+
 Cb2tLgtH+XHA3/rPosDxVbYn6cdTVW1HBXqohmlqjVpepDAHxlu/orWvHW/oYyZvQBpoC2FCBaA
 hqy4blMK3UHWB37l+nb0srBLimtZiyWx+dAbZYtcA+IrqAEjSk14P+/vhnM7dLHF3t8CE/cXlq/
 2sacDElkslFmLsS7Yxu8bYvtpvDjxM0ZnvlvDjUkHjwDXRq6Hzz0Mw=
X-Google-Smtp-Source: AGHT+IEQWh+PT/60pZp5PxeZRBvRKA2+vvMRHQ94ABsD1D6w5S8xuWl9J4ksDcrVxUGJ017b2ja2IQ==
X-Received: by 2002:a05:6a00:35c6:b0:725:4109:5b5f with SMTP id
 d2e1a72fcca58-72abdd7bc5dmr79146759b3a.8.1735769576930; 
 Wed, 01 Jan 2025 14:12:56 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:12:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 22/67] upl: Create a function to create a memory node
Date: Thu,  2 Jan 2025 11:09:08 +1300
Message-ID: <20250101221003.1944600-23-sjg@chromium.org>
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

Pull out the code which creates a new memory-node into its own function,
since several functions have similar logic.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 66 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index 7d637c15ba0..6e9f67f686f 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -287,6 +287,48 @@ static int buffer_addr_size(const struct upl *upl, char *buf, int size,
 	return ptr - buf;
 }
 
+/**
+ * write_mem_node() - Write a memory node and reg property
+ *
+ * Creates a new node and then adds a 'reg' property within it, listing each of
+ * the memory regions in @mem
+ *
+ * @upl: UPL state
+ * @parent: Parent node for the new node
+ * @mem: List of memory regions to write (struct memregion)
+ * @leaf: Name of memory node (so name is <leaf>@<unit_address>)
+ * @nodep: Returns the created node
+ * Returns 0 if OK, -ve on error
+ */
+static int write_mem_node(const struct upl *upl, ofnode parent,
+			  const struct alist *mem, const char *leaf,
+			  ofnode *nodep)
+{
+	char buf[mem->count * sizeof(64) * 2];
+	const struct memregion *first;
+	char name[26];
+	ofnode node;
+	int ret, len;
+
+	if (!mem->count) {
+		log_debug("Memory '%s' has no regions\n", leaf);
+		return log_msg_ret("reg", -EINVAL);
+	}
+	first = alist_get(mem, 0, struct memregion);
+	sprintf(name, "%s@0x%lx", leaf, first->base);
+	ret = ofnode_add_subnode(parent, name, &node);
+	if (ret)
+		return log_msg_ret("wmn", ret);
+
+	len = buffer_addr_size(upl, buf, sizeof(buf), mem->count, mem);
+	ret = ofnode_write_prop(node, UPLP_REG, buf, len, true);
+	if (ret)
+		return log_msg_ret("wm1", ret);
+	*nodep = node;
+
+	return 0;
+}
+
 /**
  * add_upl_memory() - Add /memory nodes to the tree
  *
@@ -301,29 +343,15 @@ static int add_upl_memory(const struct upl *upl, ofnode root)
 	for (i = 0; i < upl->mem.count; i++) {
 		const struct upl_mem *mem = alist_get(&upl->mem, i,
 						      struct upl_mem);
-		char buf[mem->region.count * sizeof(64) * 2];
-		const struct memregion *first;
-		char name[26];
-		int ret, len;
 		ofnode node;
+		int ret;
 
-		if (!mem->region.count) {
-			log_debug("Memory %d has no regions\n", i);
-			return log_msg_ret("reg", -EINVAL);
-		}
-		first = alist_get(&mem->region, 0, struct memregion);
-		sprintf(name, UPLN_MEMORY "@0x%lx", first->base);
-		ret = ofnode_add_subnode(root, name, &node);
+		ret = write_mem_node(upl, root, &mem->region, UPLN_MEMORY,
+				     &node);
 		if (ret)
-			return log_msg_ret("mem", ret);
+			return log_msg_ret("ume", ret);
 
-		len = buffer_addr_size(upl, buf, sizeof(buf), mem->region.count,
-				       &mem->region);
-		if (len < 0)
-			return log_msg_ret("buf", len);
-
-		ret = ofnode_write_prop(node, UPLP_REG, buf, len, true);
-		if (!ret && mem->hotpluggable)
+		if (mem->hotpluggable)
 			ret = ofnode_write_bool(node, UPLP_HOTPLUGGABLE,
 						mem->hotpluggable);
 		if (ret)
-- 
2.43.0

