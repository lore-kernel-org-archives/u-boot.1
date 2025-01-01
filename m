Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B24E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BE7D806C9;
	Wed,  1 Jan 2025 23:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SYsqHc1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B8B180391; Wed,  1 Jan 2025 23:17:03 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 474E580628
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-216426b0865so142773895ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769819; x=1736374619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5We6timMP0xjV66HThUZD69TqFSpTLo472ERufGOBtI=;
 b=SYsqHc1e6r2rxdjB6rGPiQanY7dpnMj/mkXd2XboOMIFFPMi1Bd8uh5TCLFs/jBerS
 HNpwFi4oqJqodQw6TOW35Q04CFkJXwQTKDebvKJjJjzkxUDDB/8DAfe++nPb9QzCIGsx
 Z+gUN+ocFA7g/OCG5USf25tGobqRSAAUdRTAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769819; x=1736374619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5We6timMP0xjV66HThUZD69TqFSpTLo472ERufGOBtI=;
 b=jJ8HbQGAduoWjVNosr0/TCpq4zfF+cceqYeruxP6q+zzxui/6pm1eKQ0SB/arjeJjU
 aqzAiUh70etkmDQCXY+F8FtvUHdn+Mw8aAVoHXKv0mOJsXCDCE7LyTk0/SFkHHsSQK5G
 D7HVFt3efsLlZfFM4THSjFOe9fdusgTRpJ1obrw8A/0tG0m6sADJhfZ3NVIdqgYnedM1
 qOYpPnHR2pPiZznyqL1N8Wx2mu0hqfL36CZgNyUwIT5103A9l57+0V7Yt9RTOYXTPfPK
 jeLIIfaxKEBC2h849K3m2drSMIitpXfgVqT/78nCPEb3+LFC6qDWcxCpGxwtLvpzWd1d
 tAmA==
X-Gm-Message-State: AOJu0Yyc1AUqXx5UDZwzg2eyXEN6B+KxKEpQ2kkUebbj9MqFL+6n0w3E
 TzsF6fHEF6k6Ci6ErmyDV6wkmknU5Mv5GbdEfP+nxumnaVFNmW60rKd9DAVdjwPbyoAsBaJwZic
 =
X-Gm-Gg: ASbGncveRcVMCMUerswrL2zCCv4+7sxAUvFtO9JeKi0RupGjaOyM3pr+Hb33p72o9V+
 7xD96AQBEo2w+qJuGv9EakdaQtpBdVLkGy5ze9SJXa/bza7LdVQWwoEWLLN0p85L3rGBkrriUQi
 TBejlBBPfWs/eCGptn2Hc8Jq5wZzuezZNlAEk/wUHN8B3SNh1bd11D1oJhuKdUkmhO+o58OZ1xQ
 MHUleM23EtPoW9GnLGlb8eAeGXdHlhoJAk9Y+gZ0HzVV2V2tm1X7Ow=
X-Google-Smtp-Source: AGHT+IHug5KFcrmRdsE4YDH9+kDfNQb0vcrTx//D3hkeR3PllowmOmrSv2aqeqVpuo1oCd4krnP86Q==
X-Received: by 2002:a05:6a21:6f87:b0:1db:c20f:2c4d with SMTP id
 adf61e73a8af0-1e5e044b1c1mr63784971637.2.1735769819286; 
 Wed, 01 Jan 2025 14:16:59 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:16:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 38/67] upl: Add addr/size tags in the reserved-memory node
Date: Thu,  2 Jan 2025 11:09:24 +1300
Message-ID: <20250101221003.1944600-39-sjg@chromium.org>
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

This node should have tags indicating the size of the addresses it uses.

The existing add_root_props() function only serves to add these tags to
a node. Rename it and allow passing the target-node to the function.

Use this to add nodes to the root and reserved-memory nodes.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index b2e9ae85712..60548937090 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -144,18 +144,18 @@ static int ofnode_write_value(ofnode node, const char *prop,
 }
 
 /**
- * add_root_props() - Add root properties to the tree
+ * add_addr_size_cells() - Add #address/#size-cells properties to the tree
  *
  * @node: Node to add to
  * Return 0 if OK, -ve on error
  */
-static int add_root_props(const struct upl *upl, ofnode node)
+static int add_addr_size_cells(ofnode node, int addr_cells, int size_cells)
 {
 	int ret;
 
-	ret = ofnode_write_u32(node, UPLP_ADDRESS_CELLS, upl->addr_cells);
+	ret = ofnode_write_u32(node, UPLP_ADDRESS_CELLS, addr_cells);
 	if (!ret)
-		ret = ofnode_write_u32(node, UPLP_SIZE_CELLS, upl->size_cells);
+		ret = ofnode_write_u32(node, UPLP_SIZE_CELLS, size_cells);
 	if (ret)
 		return log_msg_ret("cel", ret);
 
@@ -421,6 +421,9 @@ static int add_upl_memres(const struct upl *upl, ofnode root,
 			return 0;
 		return log_msg_ret("img", ret);
 	}
+	ret = add_addr_size_cells(mem_node, upl->addr_cells, upl->size_cells);
+	if (ret)
+		return log_msg_ret("im2", ret);
 
 	for (i = 0; i < upl->memres.count; i++) {
 		const struct upl_memres *memres = alist_get(&upl->memres, i,
@@ -562,7 +565,7 @@ int upl_write_handoff(const struct upl *upl, ofnode root, bool skip_existing)
 	ofnode options;
 	int ret;
 
-	ret = add_root_props(upl, root);
+	ret = add_addr_size_cells(root, upl->addr_cells, upl->size_cells);
 	if (ret)
 		return log_msg_ret("ad1", ret);
 	ret = ofnode_add_subnode(root, UPLN_OPTIONS, &options);
-- 
2.43.0

