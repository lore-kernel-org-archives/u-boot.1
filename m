Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FF9E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0DF2806D4;
	Mon,  6 Jan 2025 15:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M6gOe8ii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF400806CB; Mon,  6 Jan 2025 15:33:17 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C598D80619
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a7d7db4d89so45923285ab.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173994; x=1736778794; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5rbTlVkc84zp7vWSLnh3Pv2eQmEIaJ9glmJdxEB9MR8=;
 b=M6gOe8iiU8LHmqthsWkiYZ0FZLwNb96IDf9krXQh07dgTHZTf43cu3g40UIlRM+v05
 5RYFCLATjJpZjU0geqtA0SyQG2hH9hCQkQHIB4nbYuMKgEBgUctU1ZWezuBSAOCy4zwn
 AfthBduUhEA7z2NzDHpL0//IL2tqyv+vQM2fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173994; x=1736778794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5rbTlVkc84zp7vWSLnh3Pv2eQmEIaJ9glmJdxEB9MR8=;
 b=OY+861NL7DBLpR1jVbESGrAFSNsktaVGmRIjBmEDxALENIW2kzL7KY6SaL+0BqIoBi
 663yXZMLTrksl5ZE7xZ12/ZOTHZNwz5VPtzYVR2B+PgGIajLTC8+qYy6mjiRldABLgsj
 KCu1cPAn+NwJAhEckaAi2Jx19BqWVRuW4W2Q1wp5XBuubn1mG3/stcQ15js+XGVKdi6I
 iNrPjBENUedK0YiBj92lFWEiz+fVMk9v3O65uGBOuwP2lgT7b2j6G+gABBfYY3DzwKwJ
 FkCDLUSqIbicL4Wq7k/MMyxZLCCRYq1GbJyth6hAFIvxcjGnG7ISqL6rvSgSQRqwzzTi
 jVnw==
X-Gm-Message-State: AOJu0Yy7jkwjABpUL8dJ/r5LVe3+fNhS8NVLM8QF5aph5GtRGMPlll7w
 zis1yoHFAFA0zK+BsUeQ5WK1fmOBpHqNMLOe0ibX+V7r8KtehBbH3ny5r3waBGMMRhv6VyQ/eQE
 =
X-Gm-Gg: ASbGncsD2g3c8tnXRPQkhSX3R0Zq1gW3QV1+RS2rf2xUF/MYwfD39njOCvlScQOAEgY
 mXCBXDBo2HaBW1HwurVl0tw9e/0ksJHd8ojihYIxIIwps38WAxkmVKk7ycOrpKooPk9EHG2iIfY
 3XAZv8rYA1G+F5C8yAvddya8wRKhm1p4pLlI8JMcqvxY+KSg8CAElIdRfvQo/6ofIFeRSarhWCm
 NPEcvrwCMvcPQce5kXGibWSXicufjKLahUP4dByMma/5xk1cRTV7/CcbJNzLlbxtZCOS9Vx00jC
 acwtUaKqGdOQFflIbg==
X-Google-Smtp-Source: AGHT+IEq2cB9aThOHoPIB85lcxUqFHdWt30UV5Ta5omiwuhqRqMq0Gwg3g9fsKxuaXCX1B0KtPKH6w==
X-Received: by 2002:a05:6e02:1546:b0:3a7:764c:42fc with SMTP id
 e9e14a558f8ab-3c2d5916145mr493878255ab.21.1736173994032; 
 Mon, 06 Jan 2025 06:33:14 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 13/33] ofnode: Indicate when out of space in a few places
Date: Mon,  6 Jan 2025 07:32:09 -0700
Message-Id: <20250106143229.3023771-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

Update ofnode_add_subnode() and ofnode_add_prop() to return a suitable
error when space is exhausted in the FDT. This makes it easier to see
what is going wrong.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/ofnode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index ec03f6f550d..5b8be218d3b 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1607,9 +1607,10 @@ ofnode ofnode_by_prop_value(ofnode from, const char *propname,
 int ofnode_write_prop(ofnode node, const char *propname, const void *value,
 		      int len, bool copy)
 {
+	int ret;
+
 	if (of_live_active()) {
 		void *newval;
-		int ret;
 
 		if (copy) {
 			newval = malloc(len);
@@ -1623,8 +1624,12 @@ int ofnode_write_prop(ofnode node, const char *propname, const void *value,
 			free(newval);
 		return ret;
 	} else {
-		return fdt_setprop(ofnode_to_fdt(node), ofnode_to_offset(node),
-				   propname, value, len);
+		ret = fdt_setprop(ofnode_to_fdt(node), ofnode_to_offset(node),
+				  propname, value, len);
+		if (ret)
+			return ret == -FDT_ERR_NOSPACE ? -ENOSPC : -EINVAL;
+
+		return 0;
 	}
 }
 
@@ -1897,7 +1902,7 @@ int ofnode_add_subnode(ofnode node, const char *name, ofnode *subnodep)
 			ret = -EEXIST;
 		}
 		if (offset < 0)
-			return -EINVAL;
+			return offset == -FDT_ERR_NOSPACE ? -ENOSPC : -EINVAL;
 		subnode = noffset_to_ofnode(node, offset);
 	}
 
-- 
2.34.1

