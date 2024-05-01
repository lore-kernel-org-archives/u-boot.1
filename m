Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AEAC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC68B88C32;
	Wed,  1 May 2024 04:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fc+Lufou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 363B588C0B; Wed,  1 May 2024 04:45:41 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0F288C80
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7926564c111so37032585a.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531536; x=1715136336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GflnFKOa094jqFnmBoILeUC3b7NH8RszwqE36VpVib8=;
 b=fc+Lufoutb50RvwF/QFIkiBl0B4ATmFjLjd03QpugcRHr0bKuBy3MTvk+xtHgTrYPB
 MlnBKwylt+auEAqeL98dZqvhOTm0JuBG90Wv/pa05N4PGClVuXY9lmDBswCX98bQ+ySD
 83aDsaXVkw068yIuinUixQSOGCmiGb8iRx5Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531536; x=1715136336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GflnFKOa094jqFnmBoILeUC3b7NH8RszwqE36VpVib8=;
 b=xAWvIug+pUzb5+O4z7nHMO7sUQgpl0bD9cbx6ZO0HZyNeFKPWW+IAf+CtkkJFC6d18
 INRFLbac7yTgg/LVE5LosxMe2pIiVxbmeCEx6KLyrzfAPGWSWiQrETA+G9jMinQ3tBzF
 8e5AefiirZEv1VDmSQwNm8VJ19aFp6hb9rRQDVNaehJ6R7FrDYpSTqnocv6KjJVjquK5
 c+k7DxpvcTBOXdn39gfI+w+DO6UglM0+U2GRW0cI4+XV05cTbY/L28/CpPfsGvVLu2SA
 BRI4+1MNWdKq55Fpj7CVVaN3Q/qCrvS1iQCs2yaiSejegwDF+Fhpce9ZeOL1wa4LJ2Q8
 BXJA==
X-Gm-Message-State: AOJu0YxGoTDC3A5hTDPEPI2RG7DlFkSIvdGyMLMceXG775ttp1s96hwd
 Ai6dyz5Blyvn5utXX7CLVGDQt2sxwZ63Gi6OaW1t+S/b6PJGFwNRSakl/o3k831C+5WP7sOQY6D
 p9ynn9W2X
X-Google-Smtp-Source: AGHT+IEbkP2uDSg7PzG37vhKb/Yze4r+6yFGGucXOjbX41MV9SN2djrN+P7a1K4K40cC6Nl3xtFzqA==
X-Received: by 2002:a05:6214:2b0c:b0:6a0:af22:e2b with SMTP id
 jx12-20020a0562142b0c00b006a0af220e2bmr1283525qvb.24.1714531536552; 
 Tue, 30 Apr 2024 19:45:36 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 120/149] board: socionext: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:47 -0600
Message-Id: <20240501024316.1767971-120-trini@konsulko.com>
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
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
---
 board/socionext/developerbox/developerbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/socionext/developerbox/developerbox.c b/board/socionext/developerbox/developerbox.c
index 062e4a7b79fa..556a9ed527e7 100644
--- a/board/socionext/developerbox/developerbox.c
+++ b/board/socionext/developerbox/developerbox.c
@@ -9,7 +9,7 @@
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
-#include <common.h>
+#include <config.h>
 #include <efi.h>
 #include <efi_loader.h>
 #include <env_internal.h>
-- 
2.34.1

