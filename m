Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B31C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1D8B88CEF;
	Wed,  1 May 2024 04:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dmfvJMqH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A56188C8C; Wed,  1 May 2024 04:46:05 +0200 (CEST)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 359DA88C8B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4defa67bc32so768591e0c.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531562; x=1715136362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7GtafP5tgECCmO7HD12bx4El1jk0nQtn9b6pcJCRxE=;
 b=dmfvJMqHh/qqJxSMjhlclfwCTdhIoh2VUSO6aLJ+RTz/aMOVlUzTh8qLUzwo8CxhFk
 NGHstlq9kO9t4OUEr/s+Lr7Tq0uslLXRdNT6BaVXSu3VD6Zr64cYe74lAKPHxt9Pav8d
 Pl4VBTlpnjeyct1VmISgRW96a9SSf0+ppRqlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531562; x=1715136362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7GtafP5tgECCmO7HD12bx4El1jk0nQtn9b6pcJCRxE=;
 b=FsjO0XdXaGXOSjaG9mR1cikjay2mv67ZDP8drnQ3FNR0v4ZvF5rjK+/h+lhIxNepQI
 hFx0C2JHuzf1NwFtqIvsDCJN2gztDOWo8wj1nO3E9vSmkxRbbEfQbDWHLqD6qtb8EmGP
 PHxXYeG9h7Ll7VqvZQrGwoc/oVWTJprni7b7fw/x6IcjlEgr/mdntg9M/iU1jWBDhf2q
 RtkuDDjMPfG77M6FOWhN9qfqwmjQQEpeL4JQXOI2+Xq5KvxTL7npkMCN1rY+SIjB9JoV
 4foLIk5FKMH7b0/VNaUAb5vQngt8gs6mRmD20I/BtQcGLzfNwq7tYzweR+2pz1o9En68
 8CVw==
X-Gm-Message-State: AOJu0YwOSNJm1R4lNKVBTE4ckDF9m4DkYFnvTWDvgYC9ekQ7OkAdPZj2
 uQENqzaKz+SlEbJLpekfJ2vqeJo/k6NCpYn1XYN5A/8An9MxqurA4yB1Svy6YjzzM2f7IEZ+pWV
 DkHv86qLm
X-Google-Smtp-Source: AGHT+IGE+G1NDSvSCERjgvaLlRwszVAVn18gDoIohMFq7o98hCXKbC+l16NQzVOlQjuY9J7f+3f/sQ==
X-Received: by 2002:a67:ce84:0:b0:47c:33fc:4619 with SMTP id
 c4-20020a67ce84000000b0047c33fc4619mr1598040vse.9.1714531561908; 
 Tue, 30 Apr 2024 19:46:01 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:46:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 145/149] board: warp7: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:43:12 -0600
Message-Id: <20240501024316.1767971-145-trini@konsulko.com>
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
Cc: Fabio Estevam <festevam@gmail.com>
---
 board/warp7/warp7.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/warp7/warp7.c b/board/warp7/warp7.c
index ead52d5a490c..4cd3ff0051b7 100644
--- a/board/warp7/warp7.c
+++ b/board/warp7/warp7.c
@@ -15,7 +15,6 @@
 #include <asm/mach-imx/hab.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/io.h>
-#include <common.h>
 #include <env.h>
 #include <asm/arch/crm_regs.h>
 #include <netdev.h>
-- 
2.34.1

