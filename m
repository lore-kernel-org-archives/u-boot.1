Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F01C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F22484005;
	Mon,  4 Aug 2025 23:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p1OeQe5C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3630484002; Mon,  4 Aug 2025 23:57:33 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B27488400E
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-87c54a2985fso290231039f.3
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344648; x=1754949448; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVf10ka1URnSL72mc0kSg2rUn0+Q88Q7ZdqxAwSM2l0=;
 b=p1OeQe5C6SEaaDFtxjCnesOjODrf3C8LwQzJ273cMaZkBZKN8fPrYePy50QB15hBKd
 SooWPodNQPjo2tAdd6Z+WJGw3OfDWqlUSL3eEzH6+DZAxE67Xo40Y8RsH3JU86XO0+cM
 Lk33jhYMcEkN1LBWDsuHpccUCY4yEmiz1oQqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344648; x=1754949448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MVf10ka1URnSL72mc0kSg2rUn0+Q88Q7ZdqxAwSM2l0=;
 b=WiZ39AQjea5reHfyJpzc/rl2Cpf5UenBTM5eLJxy1d6NP7k7hlst5JErnAoZFny8Rg
 2B5KWPDBS1DzuCyaSr/SoFqU1HiT7VklkXJwPCujaameep73H4852tM6DU5et7DSLNAe
 gZKPzMbkBXLqguwrF79segFEV2W4x1zsmYrNeFjlMNkgz61iFe6vE4IkojF2fv1GvX0N
 2HhASL31LcvwSRrpl/aW0xIK0E9R95gjFVfR6Tlf/Mh8N1vtedz2/U+B4V+gMmno5EcB
 XtUTJuCdFpLsmR14Qhukdtr/F89/culFtyDzYhvWx05KQfOo2A7qBmV0tKKViOxX+UH6
 xMVw==
X-Gm-Message-State: AOJu0YwFWCL7Hnxxys+zeA2OTuPqepwQoFAdOPLRWrB567O/4BuEXYv7
 BcZUiQBE34cbT7f433N86913OkwwjOQXq0XLmi0PpOoF6iiyDoGieWnDb/ntxGHVkyv7JY2064T
 rYS3pwjk=
X-Gm-Gg: ASbGnctJ2O7PwitQ71chNT2KI5hHnrgJDkErm996bfsoNbUQOgFehkKiORZbwG7DiE0
 PmAxLRwX2ous+eWg/Dc65PCRs5/6WyS6vGfPezfLVWuWY1RJd655U3irA0ctDvyUMYNrCJ1+7DP
 /qv2gY0bHGbI3GaOpKyAx3lomkUYPYoOCe98Sz/Es3KXGnqP6PNiS4o+5NwajhMYxNsJxaLvwkM
 UDv26hQMVJQ/xpesiHpX8/T3dFHzGq3W/Gjxhyk4qlydz/4OHyHdjsUh5D4CEMT+82KmMGScKHc
 MlZO763zE1OZzgfm0ad0ejXbsa/Kmy8sqrB+IE+eqopYWCbkzsSsCFtYad4hrPtSKztFZ6Se7T/
 2D3ksSKWPPhmwSfxCYURAiI/IYNb7IEkvwPkpODlORfz4huxGLlt8w+S+H9Q5ijf0T1o4
X-Google-Smtp-Source: AGHT+IEWek3M9cktKZvb1H7ZTcSh3myG9gVG45BDjOK6qafCoHj/O5p3vnPCM4hTqgH5QxHKpRvZTw==
X-Received: by 2002:a05:6602:1c83:b0:873:1c2d:18e7 with SMTP id
 ca18e2360f4ac-881683b13f9mr1489254039f.10.1754344648481; 
 Mon, 04 Aug 2025 14:57:28 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a9f677f81sm1066177173.39.2025.08.04.14.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:57:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/2] spi: altera_spi: Add missing <time.h> to altera_spi.c
Date: Mon,  4 Aug 2025 15:57:18 -0600
Message-ID: <20250804215719.1413106-9-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804215719.1413106-1-trini@konsulko.com>
References: <20250804215719.1413106-1-trini@konsulko.com>
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

This driver references the get_timer macro while relying on an
indirection inclusion of <time.h>. Add the missing include directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/spi/altera_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/altera_spi.c b/drivers/spi/altera_spi.c
index dafaf1130bb3..a75d861bda48 100644
--- a/drivers/spi/altera_spi.c
+++ b/drivers/spi/altera_spi.c
@@ -12,6 +12,7 @@
 #include <malloc.h>
 #include <fdtdec.h>
 #include <spi.h>
+#include <time.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 
-- 
2.43.0

