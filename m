Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2943C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB25488BAE;
	Wed,  1 May 2024 04:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rrWi8rsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F31A88BA3; Wed,  1 May 2024 04:44:41 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E0BF88B99
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-479edfd02e4so2124984137.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531478; x=1715136278; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAHm6UEsiRj0cFhZ36jHnk1VlPbMoVFBT9G52i4D/c0=;
 b=rrWi8rsuMVUdBUqNt+xlc0qhepe4A8dGB4fhhBtpe0vw8/dAS725qD1bXFSCLykQDV
 e4W4Cg9MhTB/2viu/nu5ppYlD168YWSCLPMynui7ed+CRQxhwMj9bCKrdkt+BDU5+uw8
 5hWciGT4T1rVmGq5Rnp0jtyFxGaPY0vqVnnAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531478; x=1715136278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAHm6UEsiRj0cFhZ36jHnk1VlPbMoVFBT9G52i4D/c0=;
 b=nasgEoLmnJE0FEywPZYRNxM7GzcM2bKuVjEWRQezsdMOGl7kHRQ5Kizkv08Gj3pSdF
 eUMWKaFzDCukaO1jN6y0QAVekko7EJXakoPaiSvbn2W3fUChp4AioX1j00ZBzbhyBXSD
 BR3OYoe/aGvdrZsi9ectNKWnILse+wYCU/omWBjp8X0WoHU8Tk7RE/IS7/XV7wDKtZpV
 ya/kiC0nczdalsWBS6rwhFzoUJDWj6aSXtNgd1KogI4poyk9Rgv7dSJ4ePB/fJxYeJxk
 DFT/NzSl65NMbEdULEaVAKRDNjOmrNP/xjpoKApr/oYly2JGWLI6VwVgzPK1Ple162sB
 nYyA==
X-Gm-Message-State: AOJu0Yx5+/r246zNUQ/R/HsAXfFYtMAqFTND+B11Poqhu2U+v97rCIW+
 oMSYr1zpHTrsik0V0L7KocrE9U+ixMB5lduZdc4dGnDpPiU/2djUnEA/WN8+qwoSf0kh0b2tbyQ
 sQpG7SQ==
X-Google-Smtp-Source: AGHT+IEfUpLcDHeiUj0xsJRgssuSr4GHU0sNtqh8rGqwmCcKkglSb8SgRsq/jHcAvbvXUYmYdD2p0Q==
X-Received: by 2002:a67:f05a:0:b0:47b:9547:bfde with SMTP id
 q26-20020a67f05a000000b0047b9547bfdemr1685949vsm.13.1714531478253; 
 Tue, 30 Apr 2024 19:44:38 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>
Subject: [PATCH 067/149] board: google: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:54 -0600
Message-Id: <20240501024316.1767971-67-trini@konsulko.com>
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
Cc: Simon Glass <sjg@chromium.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Marco Franchi <marcofrk@gmail.com>
Cc: Alifer Moraes <alifer.wsdm@gmail.com>
---
 board/google/chromebook_coral/coral.c          | 1 -
 board/google/imx8mq_phanbell/imx8mq_phanbell.c | 1 -
 board/google/imx8mq_phanbell/spl.c             | 2 +-
 board/google/veyron/veyron.c                   | 1 -
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/board/google/chromebook_coral/coral.c b/board/google/chromebook_coral/coral.c
index 9d9168d608a1..7b2724c01d04 100644
--- a/board/google/chromebook_coral/coral.c
+++ b/board/google/chromebook_coral/coral.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY	UCLASS_SYSINFO
 
-#include <common.h>
 #include <bloblist.h>
 #include <command.h>
 #include <cros_ec.h>
diff --git a/board/google/imx8mq_phanbell/imx8mq_phanbell.c b/board/google/imx8mq_phanbell/imx8mq_phanbell.c
index d0a740dd3f40..9544d6dd19a8 100644
--- a/board/google/imx8mq_phanbell/imx8mq_phanbell.c
+++ b/board/google/imx8mq_phanbell/imx8mq_phanbell.c
@@ -3,7 +3,6 @@
  * Copyright 2020 NXP
  */
 
-#include <common.h>
 #include <env.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/board/google/imx8mq_phanbell/spl.c b/board/google/imx8mq_phanbell/spl.c
index 83de5bfd75fa..cfba9300dcbf 100644
--- a/board/google/imx8mq_phanbell/spl.c
+++ b/board/google/imx8mq_phanbell/spl.c
@@ -4,7 +4,7 @@
  *
  */
 
-#include <common.h>
+#include <config.h>
 #include <hang.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/google/veyron/veyron.c b/board/google/veyron/veyron.c
index 32dbcdc4d10a..53c3435c92fc 100644
--- a/board/google/veyron/veyron.c
+++ b/board/google/veyron/veyron.c
@@ -4,7 +4,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
-- 
2.34.1

