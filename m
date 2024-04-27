Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118E9C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ADA988326;
	Sat, 27 Apr 2024 16:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z50eOnA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFE6588408; Sat, 27 Apr 2024 16:11:16 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D302488288
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78f02c96c52so208175985a.1
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227073; x=1714831873; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LpCucXqbFtEad7sOX3p7A88C81+t1QA7vC2teIDis1g=;
 b=Z50eOnA/RQ2CcdF83NrbhTuhQ9BxbQb6VynrnlEyu0myYuUyob/hh9bY0VmgaPrbqH
 bAU1YcnOi4/Q1+gb8xo6uD86x3o4KGXAxGaDsDFtXglBZUNYER8tGHbtbljFfw7BeRRd
 cQB3ANFgeSGZhk7QxBiHLtdML3oGILXuxe2oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227073; x=1714831873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpCucXqbFtEad7sOX3p7A88C81+t1QA7vC2teIDis1g=;
 b=ARUYbWDq158UcA9EZifPd52tE/mM2SnHZnNHeuANWCJj/TynfZFjRkrodFo9luNkkt
 i+Vbe1zqhaY2sRpq6EtekqfZo+Isdlj4MCkr+GReqBsLB5ivbQMBsKx/2RxpNKkm62nB
 3fjlheNd88dJqq285cLAxfghx1xlhu/uizcMOr5jcFxhB4B/bmt3m9gbTLQxI3ytczuz
 xJbJhWc+IEXLGfoSdzcEZQr2oFnOGtOuMXXI+LUoRdYozJN71U6fkszgLuR90I+RCAk1
 wHann/DQGMZsN6Q7PX/Uvj+xKOfqLHh4n3D7ltDAE+90RbnyvF8+hDPt35oDRkNe0+yz
 zpIw==
X-Gm-Message-State: AOJu0Yy0LPy9emKrR+l9/wDOd0u3ZD6xdMqeFn0aobC0+Ddb/uTweSsN
 KMZGjvVyWcmxZ9wfco340QshBsyISBMuiHXP7Oxq8qU5zgzcO93u9nzQhFXRoFBPJakvyL+mt4K
 hbmam9Q==
X-Google-Smtp-Source: AGHT+IEi9gmrSrA4HD1Jzfa3E/QQO4c4sARl1/CCLfn1pJZWqHoVvJoSXnKsjdcs8/Zye810wBPICw==
X-Received: by 2002:a05:620a:57d6:b0:790:b2a3:f86c with SMTP id
 wl22-20020a05620a57d600b00790b2a3f86cmr3068736qkn.34.1714227073236; 
 Sat, 27 Apr 2024 07:11:13 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.12
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 01/18] init.h: Add "struct cmd_tbl"
Date: Sat, 27 Apr 2024 08:10:49 -0600
Message-Id: <20240427141106.3406000-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427141106.3406000-1-trini@konsulko.com>
References: <20240427141106.3406000-1-trini@konsulko.com>
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

In order to avoid needing to add <command.h> to this file, add "struct
cmd_tbl" before the prototype for do_bdinfo().

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/init.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/init.h b/include/init.h
index 630d86729c4e..2c10171359cf 100644
--- a/include/init.h
+++ b/include/init.h
@@ -401,6 +401,8 @@ void bdinfo_print_size(const char *name, uint64_t size);
 /* Show arch-specific information for the 'bd' command */
 void arch_print_bdinfo(void);
 
+struct cmd_tbl;
+
 int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif	/* __ASSEMBLY__ */
-- 
2.34.1

