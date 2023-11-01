Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92379C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 726AE87D56;
	Wed,  1 Nov 2023 17:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NyXQtt4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 774DA87D4D; Wed,  1 Nov 2023 17:28:46 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4519987D23
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a7af20c488so70241257b3.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856117; x=1699460917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ul9cXdDv5AekXjzQfeJhTwsjTkYpDZWn0oQAqvF4Wpk=;
 b=NyXQtt4XgY9GR7mfsU2PwiGRUHX2p1g6CoO3KXC1hX4ldYBrbUWCPJ2Rkrs4Nd0HgY
 oimzmkL/uGiCpSaeLBFlBeQV1A65TQMx747KDHj+nA44/yFNJXJOj6qLuJTuQvS4JHJa
 SK2Cts46ib/3BYUNynfkEuIixOZfK+7aEIsUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856117; x=1699460917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ul9cXdDv5AekXjzQfeJhTwsjTkYpDZWn0oQAqvF4Wpk=;
 b=lNVZTdUQfevSx6ZD+5Bmrn936uoyn1zziJ/NYxCy5r/nRtVZvbe710VN+qsmN3wyd5
 oXtBUDp/biwCoJL/GJEz6i9J60acGo3iLA9nouZOOJOjYi2kQp2Qm74jrpeOmz6FqEsw
 6HLdtQvmELkyNaiMi2PoWNH9iZ80keJB/1O/VTDDbnzaNWhW0pLgT8YrV8TlHRgDQg8Q
 J3I0g6LApEeST2+XxtKSFOd6U7dguTmfuVUaGwUfcDjZVrR0g3CpsG0mptVlt0Eumm55
 UkrY5amII+AbX8qGR/MsFbze1Sqm7D09Q7CD0AWkV2dE6hwKnfORu6oNhQ54ZLAYX3Bu
 92Rw==
X-Gm-Message-State: AOJu0YywCXkTTheEAgv0q0Va6JJxFc3yf2ANQAtT1GSz5EWUO10M9piM
 zuISHpIlz3VKxwaWZpJCoVwjUxxUf1Ml1PHgzd+Y9Q==
X-Google-Smtp-Source: AGHT+IH4vJl+tsO9Dy18OANkP17KwcU692pJ3u9PRG66L2AYYb1urVsKvFR43WQjXv/fpJ8veX8OEQ==
X-Received: by 2002:a0d:ec47:0:b0:595:9135:83c7 with SMTP id
 r7-20020a0dec47000000b00595913583c7mr15555176ywn.47.1698856116783; 
 Wed, 01 Nov 2023 09:28:36 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.36
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 13/20] ls2080aqds: Add missing headers to eth_ls1088aqds.c
Date: Wed,  1 Nov 2023 12:28:17 -0400
Message-Id: <20231101162824.3755579-13-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

As we call sprintf in this file we need to include vsprintf.h in order
to get the function prototype and we need linux/string.h for strcmp.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 board/freescale/ls2080aqds/eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/freescale/ls2080aqds/eth.c b/board/freescale/ls2080aqds/eth.c
index 0d0d5de15623..048ab44c5919 100644
--- a/board/freescale/ls2080aqds/eth.c
+++ b/board/freescale/ls2080aqds/eth.c
@@ -3,6 +3,8 @@
  * Copyright 2015 Freescale Semiconductor, Inc.
  */
 
+#include <vsprintf.h>
+#include <linux/string.h>
 #include <asm/io.h>
 #include <asm/arch/fsl_serdes.h>
 #include <fsl-mc/fsl_mc.h>
-- 
2.34.1

