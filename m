Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CF3C10F16
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB1688C3C;
	Wed,  1 May 2024 04:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JxUw/wdS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88DDD88C30; Wed,  1 May 2024 04:45:18 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C20088C26
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-790c7785ddbso286740785a.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531514; x=1715136314; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GkWgqz0taOLpP29eldKfiU41y5XPzgcd6l/ZWJtxRPo=;
 b=JxUw/wdSB4dN6GUygl0/WUoi9GeMylSuz3qMr9blDhotFKQc+xtNLINaAmCH7HqJpX
 8Wy7+rmfsRlYmHIfVVnr91UU5pkav2TJPqyYBdz6gKJZnnnb0lIV5rB5UjwRaeDJ9TwZ
 Y3zI3m3o2JPsaSDeQMEcIBf+ouh1YX86q9AWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531514; x=1715136314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GkWgqz0taOLpP29eldKfiU41y5XPzgcd6l/ZWJtxRPo=;
 b=hwyeHc0FaKMQCcuBbG9mBt3jCkYrPjRGZblhHGmaGZiN6fi2z0PwFgsT0zbChKixjl
 V/fhu6xaYPAr+mGGYX9Z63quBXwpIx3yqFwzDh3jZBWb+E++tm9JvYmbZW9euGqefEV0
 rnsYGWgCva04JinucH3/m5hC9xdXXH0g6tnGIfttneSI7Q9SXrK+cRQBhelgO8d0tOde
 gSycvyF42JO7KuIr5QOLGVil45dmNDqfVvMMicxNNXD0iul8Aiujzgn2v7X3kcdmTufb
 BhNAv7o8ksKqrZSi8mExtrjt2/8vkqjYbK1NA8Xtl6XRumfjEIR6u/xCSVjEovSL1cLN
 0k+Q==
X-Gm-Message-State: AOJu0YwKhnAO0+TnMqCXdAvE6Vw80kaJsDwfrSSNP0pzTtqg30XPm7KZ
 i+T+1xjjMZQXkOyX3sqS+GaCoGCVneD+nuH6JEsCzSxEM/v0qyH6s40EPyLW7ByfBkNqn/W/y2G
 Xm2hxDWCk
X-Google-Smtp-Source: AGHT+IFOQ/eV3hDZ/e3GL4UzPfy3eb0ExuFCilA90bDnN3GvgSdD6Fm6tZAvRPtGsTFvkJ1WwtpORw==
X-Received: by 2002:a05:6214:509d:b0:6a0:76b9:3e11 with SMTP id
 kk29-20020a056214509d00b006a076b93e11mr1180227qvb.53.1714531514187; 
 Tue, 30 Apr 2024 19:45:14 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tianrui Wei <tianrui-wei@outlook.com>
Subject: [PATCH 101/149] board: openpiton: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:28 -0600
Message-Id: <20240501024316.1767971-101-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tianrui Wei <tianrui-wei@outlook.com>
---
 board/openpiton/riscv64/openpiton-riscv64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/openpiton/riscv64/openpiton-riscv64.c b/board/openpiton/riscv64/openpiton-riscv64.c
index f2282d154888..4c957e889921 100644
--- a/board/openpiton/riscv64/openpiton-riscv64.c
+++ b/board/openpiton/riscv64/openpiton-riscv64.c
@@ -8,7 +8,6 @@
  *   Pragnesh Patel <pragnesh.patel@sifive.com>
  *   Tianrui Wei <tianrui-wei@outlook.com>
  */
-#include <common.h>
 #include <init.h>
 #include <configs/openpiton-riscv64.h>
 #include <dm.h>
-- 
2.34.1

