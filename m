Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FEBC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 21:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83325884FB;
	Wed, 19 Jun 2024 23:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lPWYgcZ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 197C688516; Wed, 19 Jun 2024 23:28:13 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADBBE87F5C
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 23:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5c1a6daa04bso110956eaf.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718832489; x=1719437289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iyab9n4brxTiscYvfj51byEryQbwz/zpscFbIZakAq0=;
 b=lPWYgcZ7GsBd7LRS5eGF7ZTQ/5cmPiAGSwGJYBH8SCFOm/Ra0mNiwv240op5cDW63p
 d8Pj0nWOLsI5kQglsM0Mdcj4Hq2YKTcFIHXnpZKbltZAOz7hvJfc0DZgiajUVURgBsnm
 x0wdJTp8u4D3cwNe7ObWqvpRwnX5CbEIcSa/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718832489; x=1719437289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iyab9n4brxTiscYvfj51byEryQbwz/zpscFbIZakAq0=;
 b=UUMRYUUDr+/pinHyue9mKRtkQoWZW/1u6NLAzhkCSpgiI3WSS9RsPQWJAotZAtERei
 IZXuo44dVUH2aBUpNOmPjOgvFSClxpSm29sSOg+2zqC3fYz06stgSTqwIoUdU6//jCSj
 ivEnvmw2g5nUAWpRz72doAy3DfTbJd30NF1IpX6z4EijdYDbkf8AhEZXWV7Y8fbDT4hd
 yk8Vqu8DzemPz2PUCZW3LMZEPkD9L/lsJLmaJuBFRsZTY86ipb/V2otmFScDw8zpQ76B
 sCLe5Em+jfnxNHDVjztznJYOIypWb4uRK4CFXUhDJpj6IMPCpEWzu7epSJ2GlAp6Oowh
 Magw==
X-Gm-Message-State: AOJu0YzmCifZ/9fvaxbjlN6xNq1gwesCWvh71f8dscehXSYt/OL6RfcR
 7TjfJNVB4CBG3TsFqT9DWlcX9rF/iI9VsG8ODhO0ClLjoY/xu0Ha71+e0XoNqkpX+TbsJ5o5+3P
 zqURcoA==
X-Google-Smtp-Source: AGHT+IEarZ+5qzDgKRwJyJj4q9TFwETyMk6tIq1qmMmERzsPZXSVYTuF22dL4XGkOmeAJGVQesUfkQ==
X-Received: by 2002:a4a:3542:0:b0:5ba:f2a5:3afc with SMTP id
 006d021491bc7-5c1adae6a61mr4433972eaf.1.1718832489413; 
 Wed, 19 Jun 2024 14:28:09 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-205-45.totalplay.net. [187.190.205.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7008a5a34c9sm338654a34.73.2024.06.19.14.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:28:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 7/7] cmd: cache: Remove weak functions
Date: Wed, 19 Jun 2024 15:27:59 -0600
Message-Id: <20240619212759.3456158-7-trini@konsulko.com>
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

It should be up to an architecture to decide how to implement cache
functions, and if they need to use weak functions or not. Allowing the
cache command to be built without cache functionality implemented is
unhelpful. Further, guard the call to noncached_set_region with
CONFIG_SYS_NONCACHED_MEMORY as that's when it's implemented and again is
an architecture specific detail.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
This patch series is intended to replace
https://patchwork.ozlabs.org/project/uboot/patch/20240616173105.7430-2-heinrich.schuchardt@canonical.com/
---
 cmd/cache.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/cmd/cache.c b/cmd/cache.c
index 0254ff17f9b2..7a2068296ef1 100644
--- a/cmd/cache.c
+++ b/cmd/cache.c
@@ -13,16 +13,6 @@
 
 static int parse_argv(const char *);
 
-void __weak invalidate_icache_all(void)
-{
-	/* please define arch specific invalidate_icache_all */
-	puts("No arch specific invalidate_icache_all available!\n");
-}
-
-__weak void noncached_set_region(void)
-{
-}
-
 static int do_icache(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
@@ -52,12 +42,6 @@ static int do_icache(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-void __weak flush_dcache_all(void)
-{
-	puts("No arch specific flush_dcache_all available!\n");
-	/* please define arch specific flush_dcache_all */
-}
-
 static int do_dcache(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
@@ -69,7 +53,9 @@ static int do_dcache(struct cmd_tbl *cmdtp, int flag, int argc,
 			break;
 		case 1:
 			dcache_enable();
+#ifdef CONFIG_SYS_NONCACHED_MEMORY
 			noncached_set_region();
+#endif
 			break;
 		case 2:
 			flush_dcache_all();
-- 
2.34.1

