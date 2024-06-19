Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DAFC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 21:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0929884C7;
	Wed, 19 Jun 2024 23:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jFvdQiPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3E1884DC; Wed, 19 Jun 2024 23:28:11 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E8E1884C7
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 23:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5c1a6685cd5so91824eaf.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718832488; x=1719437288; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MrEwfaZ6oEG/5NXcYWX1oC0Z6XG5hvAO/TiTt9oZZQM=;
 b=jFvdQiPoBe5b+0Yds2PBTfHzsaeitbRqes8EkuistlMN6p1AFBYiePtg6eV3r/awin
 BNl2s6uoNfGdFcmlJtUPpbXQSZp9SIcbM51Ka5r6FEwrF+Hsqlp1wIMdu3QqXydKm9NM
 Q7zCOR8V006oM0PJoNkXBl05uzKnd1S+h0lkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718832488; x=1719437288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MrEwfaZ6oEG/5NXcYWX1oC0Z6XG5hvAO/TiTt9oZZQM=;
 b=co0644DF/IDTNdD5qCgx5eXOfv9K/2nlRdwxpOxQQfroJSty8LsioZZOINFWvyq7Kn
 izKSnOznMQUj7QkqfzjTOdbzMU4R7d9RFRyLbTE4FTOfatFEXxNMM/veEAB9rMHFEw/e
 PFcETeCwVzTVL4jTvTUgr0qhOmWuO4DFHKBhHGZgJB1bWdkW5TiClfmAixpQ4SbmxbIi
 LtS3x42AWfzV7vKpapQ3K3nEmx3XYCM+b0ZLVjPYaFlEslbvCnnVVzg5ukWyeDOLST4P
 tNErwuSM8QURVxiTMuxgmNQL3dKpzrequYWElnETzopojbUMASLEjnyK6ztmnSQHh/my
 0TwA==
X-Gm-Message-State: AOJu0Yy/J22/BKKwjqrGJh1JYgLvfZ2Gpw+1FFcyUC8TqqDMSDOcPAyO
 KJGTZrpepaYkcewSU9eb3S6sse1/1SPHKE3bDw/0ztqd9ymfOOjRxTc+sGAViWqZTGq3AJhZsG6
 rBGHHJA==
X-Google-Smtp-Source: AGHT+IFTI1sun9eIebxuu0jhttHE2epXfTVgsW8vyywc06TRgpylDfan7nX5GJq0iAjmZfjx70ZzEQ==
X-Received: by 2002:a05:6820:2b83:b0:5c1:ae36:14e with SMTP id
 006d021491bc7-5c1ae36016emr4089417eaf.6.1718832487747; 
 Wed, 19 Jun 2024 14:28:07 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-205-45.totalplay.net. [187.190.205.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7008a5a34c9sm338654a34.73.2024.06.19.14.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:28:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 5/7] powerpc: Implement a default flush_dcache_all
Date: Wed, 19 Jun 2024 15:27:57 -0600
Message-Id: <20240619212759.3456158-5-trini@konsulko.com>
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

Implement a weak default version of flush_dcache_all which is based on
the ARM default, which is to flush the entire range via
flush_dcache_range(...).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/powerpc/lib/cache.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/lib/cache.c b/arch/powerpc/lib/cache.c
index e480b2696494..130318d745aa 100644
--- a/arch/powerpc/lib/cache.c
+++ b/arch/powerpc/lib/cache.c
@@ -43,3 +43,12 @@ void flush_cache(ulong start_addr, ulong size)
 	/* flush prefetch queue */
 	asm volatile("isync" : : : "memory");
 }
+
+/*
+ * Default implementation:
+ * do a range flush for the entire range
+ */
+void flush_dcache_all(void)
+{
+	flush_dcache_range(0, ~0);
+}
-- 
2.34.1

