Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF190C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9996F88CAD;
	Wed,  1 May 2024 04:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rsO0WYw6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05DDE88771; Wed,  1 May 2024 04:46:05 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E3ED88CEA
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-78f04924a96so534357185a.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531561; x=1715136361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w734tJ+f1suPka1sL+h1o4cA7/CRVWC4lCsvAxSufo4=;
 b=rsO0WYw6N9n/VbUz85y/0/Zi6ZYkxb9cnCnynuiWSnpCLs4weonCx2ZeA4iLae0/iK
 e8ExAUPVCC4/8Xej9AnFr+jqIGhVYH1/zZcUiEwaX10XiC1Qa0GriCuMK5DHYcJnKqNq
 vfpI6zC2qbCMsINy/wt1IqyGEiQJ9bMwbrFCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531561; x=1715136361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w734tJ+f1suPka1sL+h1o4cA7/CRVWC4lCsvAxSufo4=;
 b=vySTQC+vrhElteLkg27yh2HOasmWEM5z6CvsU/Qeh9y6jvIFgWkBFWxaZoOCe8+s1I
 agUwLAxEIZCLgN9HL/CIf9tp2PkrR938iuGpvD26Gp+DcmZfYgd2jbiXQr46Wj3xyVJl
 tB3kwUEdt8de8XFVTZ2ceOAM8TH4GGeow0x3cnHRjUjXSHbbZcGTDFhgHDM+B2NrsqIF
 QdVUi9DhgmpRFGkJOEFEOftAsVh7DHgQ5AG5UUohuVm/RhuJIFxiBSugzZCmi467xMAM
 2YtLxVzu0ITnS8LbgE2v1uAe9k3c6B31tl9nbojMJ2O0sJsK2iD2DYxIbMSQLWD7ANix
 MOWg==
X-Gm-Message-State: AOJu0Yys+kAaGR92nJfEGOnlCs1sl66NvFZyFDypGwJRCHpC4dztJ/1l
 v08m+gLuL7+nXwKaBMEQdSwc9m3S7a/xjaPcLJYtdr8qOvn1X8m1s6zTivra/dcwfMn15SJyTip
 lCg/T/PzK
X-Google-Smtp-Source: AGHT+IE/HQdOf6MlCSKiBXMdET48WxKC7ZnkQ/aDLo+cS6FAQj3JCaL1DQT3i93v8NUoKvryckLwDw==
X-Received: by 2002:a05:6214:4114:b0:6a0:a00e:7583 with SMTP id
 kc20-20020a056214411400b006a0a00e7583mr1160886qvb.18.1714531561061; 
 Tue, 30 Apr 2024 19:46:01 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:46:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 144/149] board: wandboard: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:43:11 -0600
Message-Id: <20240501024316.1767971-144-trini@konsulko.com>
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
 board/wandboard/spl.c       | 2 +-
 board/wandboard/wandboard.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/wandboard/spl.c b/board/wandboard/spl.c
index 717e02a039b7..9ce2785a4f04 100644
--- a/board/wandboard/spl.c
+++ b/board/wandboard/spl.c
@@ -5,7 +5,7 @@
  *         Richard Hu <hakahu@gmail.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
diff --git a/board/wandboard/wandboard.c b/board/wandboard/wandboard.c
index 8be62c86695d..a48ef33ffdec 100644
--- a/board/wandboard/wandboard.c
+++ b/board/wandboard/wandboard.c
@@ -6,7 +6,6 @@
  * Author: Fabio Estevam <fabio.estevam@freescale.com>
  */
 
-#include <common.h>
 #include <image.h>
 #include <init.h>
 #include <log.h>
-- 
2.34.1

