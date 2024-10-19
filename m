Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515B0D3C916
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D1F788EFD;
	Sat, 19 Oct 2024 17:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GJnLzKm7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC2D88EFD; Sat, 19 Oct 2024 17:22:33 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85F568857C
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a3b463e9b0so11390325ab.3
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351350; x=1729956150; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4I0s1bygbqZEGJRdtuWJh2il9unroLiRDWne3a3GcQo=;
 b=GJnLzKm7it82ZMeOz0kUDpMZacqqs251IHo5tGdxvL4gE15+65BbRWUrHCmDEMTBNj
 baebaPkieOS2VXWKFsHGcpob+078gz+5QTLIaWpAvVzhxdP8q/2DSQGZQJ0xa44U1hzs
 ZEc9NMjGSv8U0ecXgCSi0TAFvnUuehvXZedSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351350; x=1729956150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4I0s1bygbqZEGJRdtuWJh2il9unroLiRDWne3a3GcQo=;
 b=OEubhEBid35pcG0xqn+hfLTovHvQVWj+9J8D/3gdAbrMu0Oe/D4ioUo3arfKJnvbbn
 DEn62V7FoFUWUYmcTahErLA/m8bkma9q3/Rx7qDgW/qA9WU8OCfUFq2Cgx+T3y56Sg/k
 3tAXORhZe2slG+gmw6rXH89+jyx5jv8eJalsos0K8JfkgFbmoXHFXTDTDS0OxdXPG5rw
 OQ4REnXXJjszEnUDwC5K7KQ+6LzPKu1P3bxJ7Uake4GWjnYtF4gVx2Ms99/GGs/SqbAL
 /t9rkaM/34Z6WqI9xTUisRgfqtFgMKdgbsesOJrZ3kGbhB5MfU/CaoXQm4eE6ZrC/P+G
 EYSQ==
X-Gm-Message-State: AOJu0YwUuKiUcQXQpHuK8Qg7EmhXPYfPdYQUfhiQ9JW2/bJaajbrhdcn
 0kDXxmHf9vUxPZT7d7bhusMFMpL5mYK/kTV7zGkSO+v+g82xoNPmaJJIocMvs8qbyo7pvxJvYF0
 =
X-Google-Smtp-Source: AGHT+IHCD9m62QW7Cr8hvv3qkmYPtF4d5dR6yp66+oiUmfDhACo+hBOJlxos4FPHDu4Mi3cx3DCl7A==
X-Received: by 2002:a05:6e02:1445:b0:3a2:7651:9878 with SMTP id
 e9e14a558f8ab-3a3f4073cf2mr48460095ab.12.1729351350182; 
 Sat, 19 Oct 2024 08:22:30 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 02/31] alist: Add a comment for alist_init_struct()
Date: Sat, 19 Oct 2024 09:21:42 -0600
Message-Id: <20241019152211.1014896-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

Comment this macro so that it is clear how to use it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/alist.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/alist.h b/include/alist.h
index 0343946bc4a..a727f1c7dfa 100644
--- a/include/alist.h
+++ b/include/alist.h
@@ -198,6 +198,12 @@ bool alist_expand_by(struct alist *lst, uint inc_by);
  */
 bool alist_init(struct alist *lst, uint obj_size, uint alloc_size);
 
+/**
+ * alist_init_struct() - Typed version of alist_init()
+ *
+ * Use as:
+ *	alist_init(&lst, struct my_struct);
+ */
 #define alist_init_struct(_lst, _struct)	\
 	alist_init(_lst, sizeof(_struct), 0)
 
-- 
2.34.1

