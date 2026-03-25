Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3DB109C058
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B25883F60;
	Wed, 25 Mar 2026 20:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TIRsMPUr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A050983A1B; Wed, 25 Mar 2026 20:00:35 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71B9B83FC6
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d9e22176a7so71634a34.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465231; x=1775070031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1G1cBov/E/HgOpNAvCiO69RyjOClqgUBXxCstqR8SBg=;
 b=TIRsMPUrMM6PHRCVkG0Z3P0iI/2/jmiyunaLowvLMDMY/vUrRV0uz7y73xkten09XM
 BXTdjiUc0tFukeVIDs0hmaNcO8sAxQNe+y7G2gz0JxMiDVxvjMa/HfW/y9/C6DnBNs9w
 UZ1l6uECMT9m8lLkS9jmyMeoXeUIm7OegaQ2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465231; x=1775070031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1G1cBov/E/HgOpNAvCiO69RyjOClqgUBXxCstqR8SBg=;
 b=LubxIEy1ZKYucoYUMYpEHasVZiwAZcgSUcijHl6PCZJkBOnocpr7YAIgZ3UMbZVxsG
 ghu/1TvEiCKUpc7g2gNQx9SAQCqWnq47NZKROaBk10numE8eTcPNM2dpMvAK+aPalbZO
 5tLPWhSwCa/bAaD5agMmZRC3v8ekfBwAdOrwwphHTYO8efVNVQqAdom+AYX3iK0rPD9S
 EVoJXFoMiCszXBZgb0Bqy/AzaHos8wY7WL5a9CG6Y7wDhhZW2lUICg+9Nyxr95lJauD4
 wVRTvccBcvv2WrIzGYyM+SmNBKTFs/eaIMKipXJAoiFIfXbUSKgJScctNQ+KNPz1sVW3
 kCQg==
X-Gm-Message-State: AOJu0YzpOwdwNM8VbVV7yHHVErHT41+123i9mOKIqPeAqgyUAS94PBT1
 Su1ofNgTzaD7K5423giJpGWDZsPrORFR56jf/Fqfh8HhjbfpIMFy2DUiAddmx9Puri2XE7MMnms
 hyfOOlqY=
X-Gm-Gg: ATEYQzz5BMPoiKc+vCDVWeA1lPV5KJspuKtBJbYqaGKRdgCjV2CtLQF+dDEbYBi47Fa
 Mw7VlFETKIGp12MJ9XJE7tGRWKQMRBo4kzE0M91AUMjYFVjv7Qg9ECHxf7/fMnPkx4m27AD9GS7
 tVi8vghWNFsNxVBVtZ9zx5YkduI6MaM6FYCOXOlNo/0SK3Zgn+1Q4Eu+a+p9nDF8dho/KosI7KQ
 llmYxuYVfB5HPwzClNZQRMihqFSEwsHopiNDj8HJYeBYrKYKdcSsHdrLAsVTmdh2TVp9fk+Wsxc
 c5/EWLO8oPh33F7WQa7oCoH1CC9vx6z5819Y7N7GZfWwkt+hwDUe4U1EAuhl00BulzNCFO8SU6R
 0xMiUCck4O5N6UfDPYWZqZfbud+KFmRyQN0ZUsjM+Xrd89pbZROS/RulI3dtaRFHZuob43eYsYv
 FMemyyM/0KTZJ/MS6247SUxAu3/Uhmvht4Xqgekh2hFZZHipWOs+wCiJhzSmhTE9u+Ih3OgWewE
 B8nsl9W0BNsizIUbWW4Zakg+jWMBeqlFthuOCyQCTdJPpTKpnbmUllYR+Z6Lw==
X-Received: by 2002:a05:6830:6505:b0:7d7:da02:1aa4 with SMTP id
 46e09a7af769-7d9d662b2a1mr2509747a34.1.1774465230978; 
 Wed, 25 Mar 2026 12:00:30 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e71f680asm476636a34.17.2026.03.25.12.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>
Subject: [PATCH] engicam: Drop unnecessary BOARD_EARLY_INIT_F usage
Date: Wed, 25 Mar 2026 13:00:29 -0600
Message-ID: <20260325190029.3428618-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
do-nothing board_early_init_f function. Change to not enabling the
option and so not needing an empty function.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
---
 board/engicam/imx8mm/spl.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/board/engicam/imx8mm/spl.c b/board/engicam/imx8mm/spl.c
index 5a6bcb1747a0..702f0caafaba 100644
--- a/board/engicam/imx8mm/spl.c
+++ b/board/engicam/imx8mm/spl.c
@@ -52,11 +52,6 @@ int board_fit_config_name_match(const char *name)
 }
 #endif
 
-int board_early_init_f(void)
-{
-       return 0;
-}
-
 void board_init_f(ulong dummy)
 {
 	int ret;
@@ -65,8 +60,6 @@ void board_init_f(ulong dummy)
 
 	init_uart_clk(1);
 
-	board_early_init_f();
-
 	timer_init();
 
 	/* Clear the BSS. */
-- 
2.43.0

