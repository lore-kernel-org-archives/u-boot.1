Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5535C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEFF788C40;
	Wed,  1 May 2024 04:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jp6VfLQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE07488C30; Wed,  1 May 2024 04:45:18 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0E3F88C29
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-69b59c10720so17087106d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531515; x=1715136315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VouijIRERP3GHoEdrTeA7KDmIM4P1CgAbVscOiovy8A=;
 b=jp6VfLQLrTHbIFHGt3sHCJSzHh/BBaAGOtnA2077y6E7Yz3GmHnwHG1Ae7tIDYrCUT
 xD2mLVez+fqVc2VHGzuDh5pQm9T3hM4ERb3aEBLGIQWkyvDB++7X8XmITWHKCfkpX7KP
 qoifN+7M7B7SDmQPZHhFFr1KUb6tVO8nCQCY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531515; x=1715136315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VouijIRERP3GHoEdrTeA7KDmIM4P1CgAbVscOiovy8A=;
 b=bTgPztCApR5yU5UHDa+BqoEfIIzZM8guoZzAx+0afnP4h5W/gqOMEkuPbUrMksd0Ca
 EU2C6PrwVIGd3TdtLZIjdeeCI9SjPg0OWda/V3V+QHPatMY5+mS7mnuIN7nqTXqiWuZN
 tjI87OvUMhwkjXdPTjVwl1J8f/yxTeZEmkHvE7PMYZ6w2VNBuhKLATuWIwn4JEa7u3wR
 eP0vssMBUpSU/BDVkXalpRGAO499TrTbpki623x7qtZ1I/PWTbA6j6EsO9ZdlnRa9U8Q
 OvrXFnL3up2hXQtgIYicRZlRp7u80B5WxCx6LCkapNWSyVqSJXWgGPba7588ccMe7ZI/
 3JFQ==
X-Gm-Message-State: AOJu0YxMn+wFUf/ucZPAs8EZt5IedINc1fovE/YlWe9CWN9eGN/9Rcnx
 teKILLXkLZdsUR7hYb0H4zvwH+qGE951Vw39kdvm12+pIq6JgwKgeFXpCdH2nfAxCOrJtInb+sm
 +gDxvPfY5
X-Google-Smtp-Source: AGHT+IGkoquaNdpSvqLs92H2zTjVKec1eFHA4jciFvsEIuBURzbhjCOj1o+MpoX8g/sRLO5xT60jig==
X-Received: by 2002:a05:6214:20ec:b0:6a0:c950:437f with SMTP id
 12-20020a05621420ec00b006a0c950437fmr1157345qvk.12.1714531515131; 
 Tue, 30 Apr 2024 19:45:15 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
Subject: [PATCH 102/149] board: out4: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:42:29 -0600
Message-Id: <20240501024316.1767971-102-trini@konsulko.com>
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
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
---
 board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c b/board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c
index edb200e9e55b..10469aecd0bb 100644
--- a/board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c
+++ b/board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c
@@ -5,7 +5,6 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
 #include <asm/mach-imx/boot_mode.h>
-#include <common.h>
 #include <env.h>
 
 DECLARE_GLOBAL_DATA_PTR;
-- 
2.34.1

