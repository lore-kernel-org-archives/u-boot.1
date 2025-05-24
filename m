Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21455C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 13:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD0C83082;
	Sat, 24 May 2025 15:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d+JXF4ZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C07D830B4; Sat, 24 May 2025 15:44:05 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 067E882E8E
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 15:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3dc6f653152so2159305ab.3
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748094241; x=1748699041; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bUZaj5uKg5cGp+RGtTemOOOzppPzxVkAot2HtyLbNXY=;
 b=d+JXF4ZHv2I+Y3A7dylCEjc64BZGeKTxMpNay8Out6ZUF1l9eJtcuWuIvmL1eGODuc
 85EN1AOvTS7bGWzCsQYd+gWY87AdTyAG60rgR/tlS+5xgr4gY+iaDp7f5DTYEOYYu6Lh
 WHjYEdWq6L54LpWZ587z6KEEbxpHyeCrZQniY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748094241; x=1748699041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bUZaj5uKg5cGp+RGtTemOOOzppPzxVkAot2HtyLbNXY=;
 b=VAqGNJ7MjslGaIg1WnlquB0FUG53Eqz450HYpOfxluOgfNw/qyTo05y2SPXXOjY2F5
 belqw2WGnzEakxJnOUZEcHjW9FiILsY5tHtVe4t0kYS3wM2zROfHkwHIdCkWKmevzP6o
 XhYtQ9ZA39sHGOckKTme/vBXTMmjXN6NdN+ve5CHqBKh8OWLLMMFvpvN5JtGr4wbz5co
 ybD4cJo3Y5sfKbFU1mfngK7nugmrIokwyl8rESQzWR2hyjBrcLll9OyuIHF5Nh/QMiKm
 SoU3ABKYA8uhVFVJ7gTgIvlYpV0f468IWk95Qr7znjcm/I8N+f7mtuztMpAHFJny4v3O
 fwmw==
X-Gm-Message-State: AOJu0YxtegT8DPJtgJaW9rrgl7KmH+EbL1CqNNQBp13gihnTWciokRv1
 VmyxG6GXgqcjSITHLxpleA33qb8sdQJ7q2zTONLAqRpBSz8TKwNOtslGY/5EO+2BbGmA85ovy4H
 RnzKm8n+Z
X-Gm-Gg: ASbGncsQdNPl+4G6oRKDQ6JlxOeeUQ4DyUcSMo9bLl9AeUhsmjVJFrvbhKF8KX+2J1d
 6fqxhoJ92DDQH8IH2Tl3jg866BiUP6yfon17mJBJEZrxXarSpOtWqAro4jsylKpvM5N90ty/iKo
 TL8ESn+HR2vl8qvjEeQMCtT9wvziCu0rMmdz2Cqyyjbz0WrQPVu4RFMAsE5VvMvTiufTBN0k+vM
 XFPq30pUY/IifySXG67jU6vw3ctekYHdGhOUWxSbou2sX9EwUTOuUeMGlhr6W2G9dQ6eAS74na2
 6hazXzZa8+Fd5YuIMe9bqIZ5P4fUnqvCFcK+ZOyaUwHtVXbAPyB84pYPpTUXq5zx3Xm2ESy0hBV
 yrFxxA4j2eyKH
X-Google-Smtp-Source: AGHT+IGe2DEBKrE1vuOEe2Y304a3hckkxJwZQ+2tbH6Uab9ZQWpahnegfGCA+WApMZFVlHzf5SA3Zg==
X-Received: by 2002:a05:6e02:3788:b0:3dc:8273:8c81 with SMTP id
 e9e14a558f8ab-3dc9b719446mr25117935ab.22.1748094241139; 
 Sat, 24 May 2025 06:44:01 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc38bf26sm4033091173.19.2025.05.24.06.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 06:43:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] bootstd: Add a function to find an image by type
Date: Sat, 24 May 2025 07:43:46 -0600
Message-ID: <20250524134356.939898-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Provide a way to locate an image in a bootflow based on its type.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow.c        | 13 +++++++++++++
 boot/bootmeth-uclass.c |  2 +-
 include/bootflow.h     | 11 +++++++++++
 test/boot/bootflow.c   | 16 ++++++++++++++++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 76dadb93be1..ec455e86215 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -998,6 +998,19 @@ struct bootflow_img *bootflow_img_add(struct bootflow *bflow, const char *fname,
 	return ptr;
 }
 
+const struct bootflow_img *bootflow_img_find(const struct bootflow *bflow,
+					     enum bootflow_img_t type)
+{
+	const struct bootflow_img *img;
+
+	alist_for_each(img, &bflow->images) {
+		if (img->type == type)
+			return img;
+	}
+
+	return NULL;
+}
+
 int bootflow_get_seq(const struct bootflow *bflow)
 {
 	struct bootstd_priv *std;
diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 02bbe77b563..5f2e10c879b 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -388,7 +388,7 @@ int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
 	if (ret)
 		return log_msg_ret("all", ret);
 
-	if (!bootflow_img_add(bflow, bflow->fname, type, map_to_sysmem(buf),
+	if (!bootflow_img_add(bflow, bflow->fname, type, abuf_addr(buf),
 			      size))
 		return log_msg_ret("boi", -ENOMEM);
 
diff --git a/include/bootflow.h b/include/bootflow.h
index c0e19feb9cc..1c3f950bfe3 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -647,6 +647,17 @@ const char *bootflow_img_type_name(enum bootflow_img_t type);
 struct bootflow_img *bootflow_img_add(struct bootflow *bflow, const char *fname,
 				      enum bootflow_img_t type, ulong addr,
 				      ulong size);
+
+/**
+ * bootflow_img_find() - Find the first image of a given type
+ *
+ * @bflow: Bootflow to search
+ * @type: Image type to search for
+ * Return: Pointer to image, or NULL if not found
+ */
+const struct bootflow_img *bootflow_img_find(const struct bootflow *bflow,
+					     enum bootflow_img_t type);
+
 /**
  * bootflow_get_seq() - Get the sequence number of a bootflow
  *
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 0dd8fa71261..a39757627c7 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1488,6 +1488,22 @@ static int bootstd_images(struct unit_test_state *uts)
 	ptr = map_sysmem(img->addr, 0);
 	ut_asserteq(0, *(ulong *)ptr);
 
+	/* check we can find images */
+	bflow = alist_get(&std->bootflows, 1, struct bootflow);
+	img = bootflow_img_find(bflow, (enum bootflow_img_t)IH_TYPE_SCRIPT);
+	ut_assertnonnull(img);
+	ut_asserteq(IH_TYPE_SCRIPT, img->type);
+	ut_asserteq(map_to_sysmem(bflow->buf), img->addr);
+	ut_asserteq(bflow->size, img->size);
+
+	img = bootflow_img_find(bflow, BFI_LOGO);
+	ut_assertnonnull(img);
+	ut_asserteq(BFI_LOGO, img->type);
+	ut_asserteq(map_to_sysmem(bflow->logo), img->addr);
+	ut_asserteq(bflow->logo_size, img->size);
+
+	ut_assertnull(bootflow_img_find(bflow, BFI_CMDLINE));
+
 	ut_assert_console_end();
 
 	return 0;
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: boo
