Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EACC3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 11:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C5BF80107;
	Fri, 16 May 2025 13:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bfbaxMIQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D4E78059D; Fri, 16 May 2025 13:54:38 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A08EE80079
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 13:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-550edba125bso195370e87.3
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 04:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747396475; x=1748001275; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D1rB7xAf0pW/5Pxh2XFbjzfBUjWrCHEbsO7br+CWGHg=;
 b=bfbaxMIQ2kEtW0Xkqxa6ftvlDrYYxwLbzu/QVciyTMDzWLH7ZNf0PtiYuz0oVj44EL
 67d3VE3AtuIEABY41BEyZL25a2Iok1wKWT9395xrHZzvYoofkC5T3AVU/G4tfYHTUpW+
 7mJ/6EO6mH2thNXNJgZ2ydnIQwGoIJQUPRXYPYlDntLMOo7UJqFonvyQ+S6odTHe0wFB
 cYU9FJLjFwRp+Pp5h8PcdtEEmz0/2sOO9E2f90tkrcRQ3895eCag0/vS6DmW8/j7ujRB
 0AobRiwIrATssVP2HLbmrdJRYPAR6g/Qfoo3a9AG6VaEXMmIdoJF6n8DzW/pcPQnO5C5
 GDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747396475; x=1748001275;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D1rB7xAf0pW/5Pxh2XFbjzfBUjWrCHEbsO7br+CWGHg=;
 b=IkoPOjH7mk8+8wBbeN3FKTd40les/1ugJPQDKDEN6yH1nBd3Fc7K4QpbbQN0JFFbe3
 aAK+Z4OoXTlJIpZATgq7y3WllsVPjiiEza0NY34u9+c5oO+Im3/hkjsomxFkdajr/bO5
 OzCCQ9G8AWLH5jV9NW6ULSygEziw5DxCPg3JlYJN2DOJ8Sk8vaVTPPd3qBCBGpw0MKDo
 VH4/ZYMmCg7IhoG/L4k0jUy3CKZCGtBeKzbC0/Uy/vBdJbt1OLqINGsWITwlNWNkcQhe
 x4HjGjuNsIykxDsLgutw/HnhbXabmNSKIND7ltTZHYlcl4p7AsYNh77yOvfPj+7+g4ti
 L+dA==
X-Gm-Message-State: AOJu0YyPgYsNlQL0uP3LX60omYQ8Q/HkSh7T+bPGQ760fSyJRBhoixWX
 3L4sys1Wn8aV/zTlJFp21G68EH+wnflA8L+nSLV9c1zXK5i2pLOv+Lii8KAGOEOp
X-Gm-Gg: ASbGncvGYUB4zQhxvxR8Rp0rqiv+yYIpD9qSel0SYkHp0W0+JZYX8Nd+ngSZJ5Foqqq
 wLF+bFWX7unFwdlNShswYVK68iylpk41IFlBK5fYMML2ghPAd0251XFvY22F8X3dsN9xGlk2daS
 qrQuA5TUiCYBESw7K2KhelXPie7vqNGmGL19Z/2s234S062ApbnpCKU3nIb1JdAiHqLP/MDA2r4
 h96cn5fd6SPRDu3OHbz75eKRGHe1IsD1y1eHj4JqtOBmUL/eN8G6gSX/zj+kBnb0nnIEzkeK3ZX
 YpaCk2wT0tpNYLCwhPA2PtRq/obMToc9gQHGX6BbhsE8REAct9Na0GTBv7iQDMxREULV9p1mrLJ
 tUqT+SaGxKacGq59Z0w==
X-Google-Smtp-Source: AGHT+IFkxEjyhouSZQpYCySheZEKUsKYUwrUEpoIxjndTcTVbfvTT8GZm3N3CLCzvr3WNAHp683L2Q==
X-Received: by 2002:a05:6512:650e:b0:549:8cbb:5443 with SMTP id
 2adb3069b0e04-550e724a21emr836358e87.47.1747396475085; 
 Fri, 16 May 2025 04:54:35 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-550e70181b4sm407078e87.116.2025.05.16.04.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 04:54:34 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] boot: fix memory leak in bootmeth-uclass.c
Date: Fri, 16 May 2025 14:54:29 +0300
Message-Id: <20250516115429.8889-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Anton Moryakov <ant.v.moryakov@gmail.com>

The static analyzer (Svace) reported a memory leak in bootmeth_setup_iter_order():
Dynamic memory referenced by 'order' was allocated by calloc() at bootmeth-uclass.c:113
but could be lost when returning error codes.

This fix:
1. Adds proper error handling with goto/cleanup pattern
2. Frees allocated 'order' before returning error codes
3. Maintains all existing functionality

Identified issues fixed:
- Memory leak on !include_global (-EPERM)
- Memory leak on empty method list (-ENOENT)
- Memory leak on allocation failure (-ENOMEM)

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 boot/bootmeth-uclass.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 014b7588e8d..b3870ba5364 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -135,8 +135,10 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
 		 * We don't support skipping global bootmeths. Instead, the user
 		 * should omit them from the ordering
 		 */
-		if (!include_global)
-			return log_msg_ret("glob", -EPERM);
+		if (!include_global) {
+			ret = log_msg_ret("glob", -EPERM);
+			goto err;
+		} 
 		memcpy(order, std->bootmeth_order,
 		       count * sizeof(struct bootmeth *));
 
@@ -190,9 +192,10 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
 		}
 		count = upto;
 	}
-	if (!count)
-		return log_msg_ret("count2", -ENOENT);
-
+    if (!count) {
+        ret = log_msg_ret("count2", -ENOENT);
+        goto err;
+    }
 	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && include_global &&
 	    iter->first_glob_method != -1 && iter->first_glob_method != count) {
 		iter->cur_method = iter->first_glob_method;
@@ -202,6 +205,10 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
 	iter->num_methods = count;
 
 	return 0;
+
+err:
+    free(order);
+    return ret;
 }
 
 int bootmeth_set_order(const char *order_str)
-- 
2.30.2

