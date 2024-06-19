Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB12EC2BA1A
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 21:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DC5F884BF;
	Wed, 19 Jun 2024 23:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qMcAqzMs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C494884EA; Wed, 19 Jun 2024 23:28:12 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB578884C3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 23:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6f8d0a1e500so160823a34.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718832489; x=1719437289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ionMRDmQYunEs015GAi2rPg/RRUy1ygxYkFzcbmGt7M=;
 b=qMcAqzMsGF0zQc6HCOilixTqAC7h+ovvGVuRtVbOmdZsNUKOXdwjhB+she5a+8Z6X5
 gfuAfrsa/H7WroYPBZRpPdyUZRYuj1xNoU7T+Vr0nMKOEbuYsvIE4n+OMRXSvp7zw3H+
 LGVjYs+5HY4OKRlf6nQdVkjU7F9UBrLf5iJHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718832489; x=1719437289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ionMRDmQYunEs015GAi2rPg/RRUy1ygxYkFzcbmGt7M=;
 b=God1sf0T5wxwUyKwTTEU6IiWNpB9hUWrJADuLEvYC5LnHzm5YLiaPoRQKeXPhRh5Bo
 z+HZMppzTdYosnB+PuRpzg2ydIMaXa/6nKohnkQfHAYZ2AvAAutkTZwDSYoTcLGsLsmj
 DvG1z0jMvSWpf5FuF2z/weTCz6lTqaEV5qUljVGRzQF21R/mLvZcHbFVrlP8ALJNwoV9
 CtTToX6L2Y9+P/YNSBtFJMkCmoxmXtp2ja+TFNDXuS/AFH4wkzPh49PHasihvBEK7PC0
 4KnD5x1uXlEJFZCjw5/dJ4n6DpGI/QS/gQa6u1rMSvBNg1sL4qoDFv+Vc+gSJ/oSLcXM
 vpSA==
X-Gm-Message-State: AOJu0YyK/PJRDKxKbenkNhVEp3ZkbIpP75iVX79K40y8Hq40eWW+A71e
 G1U5S2TW8WbSGKjfVdEEWYOB+OsdpFqFEIbWD/LEoqczGaGJe5rOmdjoiLnEsThSh13c8GHbmW6
 NC/butg==
X-Google-Smtp-Source: AGHT+IHPXHwLSoCvsImYUoq10Ouye3jGje31A2riud8pyQkVgab21g8Ww1TU3eKQNe2Tdo//GePDzQ==
X-Received: by 2002:a05:6830:10d9:b0:6fa:348:5fa7 with SMTP id
 46e09a7af769-70075a73690mr4172109a34.31.1718832488631; 
 Wed, 19 Jun 2024 14:28:08 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-205-45.totalplay.net. [187.190.205.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7008a5a34c9sm338654a34.73.2024.06.19.14.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:28:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 6/7] powerpc: Add the old invalidate_icache_all function
Date: Wed, 19 Jun 2024 15:27:58 -0600
Message-Id: <20240619212759.3456158-6-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619212759.3456158-1-trini@konsulko.com>
References: <20240619212759.3456158-1-trini@konsulko.com>
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

Add the old invalidate_icache_all function that prints a warning that
was previously found in cmd/cache.c

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/powerpc/lib/cache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/lib/cache.c b/arch/powerpc/lib/cache.c
index 130318d745aa..a9cd7b8d30ac 100644
--- a/arch/powerpc/lib/cache.c
+++ b/arch/powerpc/lib/cache.c
@@ -5,6 +5,7 @@
  */
 
 #include <cpu_func.h>
+#include <stdio.h>
 #include <asm/cache.h>
 #include <watchdog.h>
 
@@ -52,3 +53,8 @@ void flush_dcache_all(void)
 {
 	flush_dcache_range(0, ~0);
 }
+
+void invalidate_icache_all(void)
+{
+	puts("No arch specific invalidate_icache_all available!\n");
+}
-- 
2.34.1

