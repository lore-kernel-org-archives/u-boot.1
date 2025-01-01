Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158B2E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0DF680727;
	Wed,  1 Jan 2025 23:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ju49DL0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2063080717; Wed,  1 Jan 2025 23:23:13 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B0980379
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:23:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-219f8263ae0so105000055ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770189; x=1736374989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rwOFWouKF9Vs6amOeBve4fNh55dlh4Nvx76Lc5ZNnU=;
 b=ju49DL0vzn0OgfSSbq/KJunOYbJVLxiGWQ+EGAcqSdOzd8mVZLwUSYVlIk1OGzY+gQ
 YearRFzM9H6QGk2C1/4R20BtjIIhp9JaaPN7e1K3j2Z9gykjkXDUtod1CGW/7y3Icq87
 DMS5pY30BTI5fcFBL2jiVjy2x+YseGDOvOdrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770189; x=1736374989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rwOFWouKF9Vs6amOeBve4fNh55dlh4Nvx76Lc5ZNnU=;
 b=iw+lqMxkwdZ+P8S2VCHnV94b0vNfzt562qcLV3d6mSgFZW5KH6cou2Zyq8+RH8GAQ4
 ds4t6N/2zQdzHaYhI7FPZ0cTOmpqbqs8NrHPSrxDoi3b58N0GibdqPksyHKwg/7+xAg/
 jYr2spKNaxjqKlwZK2o2Dv0GFH6Y1HzK72TzQQ4dIqKpxEN3fMhj65Evf4MbgzLti7A6
 KGxrYIVlLTNnbndRBxzmf+As48gvZNc+CqEwlYyhOXQ772q40Xs6NTys7nI11b+yKO7G
 LSFzPq8KTRUcF04aeI9F484GQb+dmFjm3a/q7S/OyYpiT+BQUSL8+7I1RXHwFOf5GUnh
 xbrQ==
X-Gm-Message-State: AOJu0Yz/Py/toHmuki17vZbt+hO57xBXGUxT3IviLiM2cCxxkVAQyo45
 1hXCD4U41a+mWsNDq0tvP3DIyhxdTgulepMSKWo6+2IOEbjjLMCWNdsX8+WhQhOsh9himiW2B1s
 =
X-Gm-Gg: ASbGncuEFVEhHeibNm78PP+MGWh87BAPID9s9rMad1lKN5lkxbpR4ihRB5gP+V5sLBa
 C9VxV+6Qa/FcZWTK5NqbmQ81mAtVh1xePA3FB9y7FVwuFgJlZ4SLcoo8lEq6kuVOuBZKquX7JZN
 Z3ajucu1L9kJMb5Xlmiwg2+U+ynBr3NlTl6vDgVdFk6Osxi+KEdvPE1fYHQ2tO3CvT5AByhWhkc
 OSiufJA/8utGgtD8ZT2QkDOMsYS7QUN8Hisc3MsxnZyur4vFfA8el0=
X-Google-Smtp-Source: AGHT+IGg5saziplKVkih/0sdV8cg1G13TEerHLo3ovvdp/CsGDYNmsFHnLfDSpqr5EzrKlh4srXJig==
X-Received: by 2002:a05:6a21:3181:b0:1e1:b062:f409 with SMTP id
 adf61e73a8af0-1e5e081db95mr67698968637.43.1735770188829; 
 Wed, 01 Jan 2025 14:23:08 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:23:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 59/67] upl: Improve uniqueness of log_msg_ret() strings
Date: Thu,  2 Jan 2025 11:09:45 +1300
Message-ID: <20250101221003.1944600-60-sjg@chromium.org>
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

Adjust some of these to make them more likely to be unique. Fix up the
comment for buffer_addr_size() while we are here.

Fix an incorrect error-return in upl_write_handoff() while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index 79613a0f463..eecb56214df 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -244,7 +244,7 @@ static int add_upl_params(const struct upl *upl, ofnode options)
 }
 
 /**
- * add_upl_images() - Add /options/upl-images nodes and properties to the tree
+ * add_upl_images() - Add /options/upl-images/upl-image nodes / props to tree
  *
  * @upl: UPL state
  * @node: /options node to add to
@@ -508,7 +508,7 @@ static int add_upl_serial(const struct upl *upl, ofnode root,
 
 		len = encode_reg(upl, buf, sizeof(buf), 1, &ser->reg);
 		if (len < 0)
-			return log_msg_ret("buf", len);
+			return log_msg_ret("aus", len);
 
 		ret = ofnode_write_prop(node, UPLP_REG, buf, len, true);
 	}
@@ -549,7 +549,7 @@ static int add_upl_graphics(const struct upl *upl, ofnode root)
 	int ret;
 
 	if (!gra->reg.count)
-		return log_msg_ret("gra", -ENOENT);
+		return log_msg_ret("ugr", -ENOENT);
 	first = alist_get(&gra->reg, 0, struct memregion);
 	sprintf(name, UPLN_GRAPHICS "@%llx", first->base);
 	ret = ofnode_add_subnode(root, name, &node);
@@ -563,7 +563,7 @@ static int add_upl_graphics(const struct upl *upl, ofnode root)
 
 		len = encode_reg(upl, buf, sizeof(buf), 1, &gra->reg);
 		if (len < 0)
-			return log_msg_ret("buf", len);
+			return log_msg_ret("aug", len);
 
 		ret = ofnode_write_prop(node, UPLP_REG, buf, len, true);
 	}
@@ -595,7 +595,7 @@ int upl_write_handoff(const struct upl *upl, ofnode root, bool skip_existing)
 		return log_msg_ret("ad1", ret);
 	ret = ofnode_add_subnode(root, UPLN_OPTIONS, &options);
 	if (ret && ret != -EEXIST)
-		return log_msg_ret("opt", -EINVAL);
+		return log_msg_ret("opt", ret);
 
 	ret = add_upl_params(upl, options);
 	if (ret)
@@ -623,7 +623,7 @@ int upl_write_handoff(const struct upl *upl, ofnode root, bool skip_existing)
 
 	ret = add_upl_graphics(upl, root);
 	if (ret && ret != -ENOENT)
-		return log_msg_ret("ad6", ret);
+		return log_msg_ret("ad7", ret);
 
 	return 0;
 }
@@ -636,7 +636,7 @@ int upl_create_handoff_tree(const struct upl *upl, oftree *treep)
 
 	ret = oftree_new(&tree);
 	if (ret)
-		return log_msg_ret("new", ret);
+		return log_msg_ret("cht", -EINVAL);
 
 	root = oftree_root(tree);
 	if (!ofnode_valid(root))
-- 
2.43.0

