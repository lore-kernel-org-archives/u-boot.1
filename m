Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66363CD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 21:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E55987FA7;
	Sun, 31 Mar 2024 23:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZFstuf9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14FC787FC6; Sun, 31 Mar 2024 22:03:35 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6BE387F8B
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugeneuriev@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-515b43b39fdso2949914e87.1
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711915412; x=1712520212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKcNN9BhN8UKpZzIBetRxa/3ScpLoQgKpgUqXqnwsWw=;
 b=ZFstuf9v3DkLK7AYjFzA3hoL7zbBAp8QZ/x8gY8DrFv3YbFGxU1LhTdM5g8JJQwFYN
 P83syuAesfFV9FkbsqsNwJTrx54khvgFrOeEa1Xp76tKtu1XtvQFVy0ivw7tdP9LW75U
 sZJ+emrJARDli+XSyN1XmuM9ZEhshWe1wD2MKuvgpuDZZRIWF1cGGWDIxPOLxhAJaJuY
 3TqXa+WVIbBuWm0WEFxsnrqw6FNJXQ031rX71ttvgUUWvH2ieqejm1uRFby2sLvlcYfy
 qjwtdy7MXoaWZshS0NEGYKjb7utYnX2VNS+ONeSKXmnj7aTWJqjUJWi7qiqismVDftax
 EiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711915412; x=1712520212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKcNN9BhN8UKpZzIBetRxa/3ScpLoQgKpgUqXqnwsWw=;
 b=ezUitkaVwxKB58kw5ZOWiGqatmevAJuO8RxsMAlo8Os7ETo9C+YKx0zJFpRzrK0BVZ
 JHAGkR/aUgAc52x1riwamL0+VShtSq3IWdMKRPxBRy+wt3OEGBVVvkYZhcNtrF3jy+Vp
 bPSDmg4L9Rr/6/jUvBKKQctkh6OjyvRzhjhTwh+r5GU5rOBPj8921BFwFgo0MGkI1z0V
 IM3GdUkvYtKZsvFtqh17ZAz0yQYpbqPt5AwCBtSMzjuzn7qOrzI9D+vzEem25qP2VaL/
 +TMCgLV+zWXM7UsPB3XN8Wb6u4soz5TXW0gtMvb7XhBfCwgPbXh9qqGrf8uycI9wfnnd
 Jnsw==
X-Gm-Message-State: AOJu0Yx5PmQvwDh82qejgFPZ9kBAnUEU9ur3wsAzgvIVfQ+A0GYfIgnC
 Lc6CiCFg7Ce/7mOfU9errFY6G8k/KnrMZ+WTSX28B7shhwNxyNuE6MSbqeaD
X-Google-Smtp-Source: AGHT+IGop+vW5M6ZJKy9U/q2LelBKIDEpYMDoBIdCBEfi0Vws/D9GVzrSRY8mGJd9X0JqXHhHADGGQ==
X-Received: by 2002:a05:6512:15a6:b0:516:a1ad:cedd with SMTP id
 bp38-20020a05651215a600b00516a1adceddmr1526053lfb.14.1711915412066; 
 Sun, 31 Mar 2024 13:03:32 -0700 (PDT)
Received: from BlackProtonRN.clients.gtk.su ([185.16.100.35])
 by smtp.gmail.com with ESMTPSA id
 l5-20020ac25545000000b00516a08ce8f8sm425000lfk.269.2024.03.31.13.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 13:03:31 -0700 (PDT)
From: Eugene Uriev <eugeneuriev@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Eugene Uriev <eugeneuriev@gmail.com>
Subject: [PATCH 2/9] mcheck: Use memset/memcpy instead of
 MALLOC_ZERO/MALLOC_COPY for mcheck.
Date: Sun, 31 Mar 2024 23:03:20 +0300
Message-Id: <20240331200327.29141-3-eugeneuriev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240331200327.29141-1-eugeneuriev@gmail.com>
References: <20240331200327.29141-1-eugeneuriev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 Mar 2024 23:00:15 +0200
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

These fast helpers sometimes breach mem-chunk boundaries.
Thus they trigger mcheck alarm. Standard ones are accurate though.

Signed-off-by: Eugene Uriev <eugeneuriev@gmail.com>
---

 common/dlmalloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index 40acd3dfa5..0813e7e8b1 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -34,6 +34,10 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #ifdef MCHECK_HEAP_PROTECTION
  #define STATIC_IF_MCHECK static
+ #undef MALLOC_COPY
+ #undef MALLOC_ZERO
+static inline void MALLOC_ZERO(void *p, size_t sz) { memset(p, 0, sz); }
+static inline void MALLOC_COPY(void *dest, const void *src, size_t sz) { memcpy(dest, src, sz); }
 #else
  #define STATIC_IF_MCHECK
  #define mALLOc_impl mALLOc
-- 
2.25.1

