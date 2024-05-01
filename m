Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9DCC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9886288BB7;
	Wed,  1 May 2024 04:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N1y1pZjO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9817888BB3; Wed,  1 May 2024 04:44:47 +0200 (CEST)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C8B288B7B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7f169d3ef53so588801241.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531482; x=1715136282; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ght9Vl/1+lltPSgVg3TjPSvnCNCZpG4tXLg1nzUtjg=;
 b=N1y1pZjOhNaDwrgDbIe53YdY4jUxC7DtSy/P0k+tbWAGA25gAdtlloab+TZ/Sjfk80
 ojq8D76ShV72X8YIqFBo73K2hFAlKOygLKnASwV3fymec29liSOxPzCCVS+4VvmcGeA6
 OkQ1H3MGCyYUbJpt9L2aZICP/3hNaZj3/rLHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531482; x=1715136282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ght9Vl/1+lltPSgVg3TjPSvnCNCZpG4tXLg1nzUtjg=;
 b=JvGQ49uoUQM5CtO2h8C8G0h9IUVjOmIL6d/RLUn5O4djV0DOcPI0/Qy4Y6wRcXwTwa
 f65DitYz1Kk4ti0N8do90ItOut3Ks6dTlLSaBrVkGZOMLv76w2grPWm/7svhPlBdlBbH
 +/5p9uLyF6Bxl293aYUUQS57+v6avw/qb0ic/+yZH54mjZG7GCzIBQChhkDG4R3HMk3L
 PbLZFf7b/C3bEPi3Yg5tDxaY5urc4vyWkNOCBoDX7aRV+w8dLERdJOSUM9NKPqSUzjnA
 gn9TbZj4CHB0hActorH0JPdSZxCk7vb4oMUIjoi5unabxiLDA7YOoLV1feemF1AuMbgw
 vOgA==
X-Gm-Message-State: AOJu0YwhA1QVcTZoNHnYhdSfudqWYuYAQvkk5vMGp1KerpKnE1jDVMfk
 +IGfsApP1x4cPkOxgQtBO45bo+sMuLZcUA4HpBJUEaAN1TgJvwMhYVZO3UT6mBowGyaAreseJCj
 d6mUOgA==
X-Google-Smtp-Source: AGHT+IEDnLShSeewbBI+JPH97exMq+o8ypD9ggD7fE+ac6XzxUVSah6FFRIcQ0P4HoHSCmp7A7IGWw==
X-Received: by 2002:a05:6102:72f:b0:47c:1cce:c465 with SMTP id
 u15-20020a056102072f00b0047c1ccec465mr1617321vsg.0.1714531482374; 
 Tue, 30 Apr 2024 19:44:42 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 071/149] board: hoperun: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:58 -0600
Message-Id: <20240501024316.1767971-71-trini@konsulko.com>
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
Cc: Biju Das <biju.das.jz@bp.renesas.com>
---
 board/hoperun/hihope-rzg2/hihope-rzg2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/hoperun/hihope-rzg2/hihope-rzg2.c b/board/hoperun/hihope-rzg2/hihope-rzg2.c
index 68d3d300dc40..0966e257464a 100644
--- a/board/hoperun/hihope-rzg2/hihope-rzg2.c
+++ b/board/hoperun/hihope-rzg2/hihope-rzg2.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2021 Renesas Electronics Corporation
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/processor.h>
-- 
2.34.1

