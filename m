Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBE5C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FBD488BF1;
	Wed,  1 May 2024 04:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qQIRC1as";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 487A888BD2; Wed,  1 May 2024 04:45:01 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06F1E88BDE
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6a0406438b5so26617916d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531497; x=1715136297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUHAJUEcP0QAbhaVSMc0Fkx2baUg6ufUQLhxfY4EPT0=;
 b=qQIRC1as7kdFQAFTGXXExdIKpdZpu1ZsrZYplIHI04vGpkGxACEObxxmYDLZYaLlQJ
 c2/yiYuIjkc01QJT6J3wuH4nN9fzFakcf9YkiMSMbGkFdlJWBXeZ6WYQdKMIQ/G9Q2Ko
 CQp10oOtcNuFFmK8trLAHlSRWfag48GqKzfZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531497; x=1715136297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qUHAJUEcP0QAbhaVSMc0Fkx2baUg6ufUQLhxfY4EPT0=;
 b=YkYtP++eg2nl0y3pRJAfJsbnryXg348Von8VXm2CrWrtYNtZd5xduOuAZ/TxOd9it1
 zWW7ifD6WPBAhyx7LvOPnAhO4/8ngo29GT9NlhO419kYCi3H92CUIfOrVAumqix7QKVi
 nJ3Fr77o7rtQnXMoCxcH1VNmsJ7uUYEIP2PUE47Vlk/arq53eMmGH8md1glwu9w67von
 Pu/4MhBIKuX1Yux/gtcRbuHmEkBFp9r/obySLTnUopogCEfG5pVUq6t+B6bBL1keFHQU
 0JJ6DbkExXEylviAgcmh2VW7cX+W38n9Whyy4A9/tOlCdmiz7/F1QttPohANb8f0zOSi
 tJYQ==
X-Gm-Message-State: AOJu0YxrUzZjIMPH00nFGUhz4tY5iFThuXEXjk2sr5wnGSPDuS8MnJYR
 4N+euIE65ZWBlFp3bMWbuCvjgkCB4kd256d2LoBfZYm8z14b0s9/zghiInWsykYklR7AChDAnxw
 nSq7CvA==
X-Google-Smtp-Source: AGHT+IEpw/PKKQUwyAoHlGM+UjkSoWcxC6nNA01PVjvj5chpbbIYvQrVoZXMDeQmRpaopBSg7CAk/g==
X-Received: by 2002:ad4:41cc:0:b0:6a0:cace:1ae4 with SMTP id
 a12-20020ad441cc000000b006a0cace1ae4mr1122090qvq.46.1714531497701; 
 Tue, 30 Apr 2024 19:44:57 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 085/149] board: liebherr: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:12 -0600
Message-Id: <20240501024316.1767971-85-trini@konsulko.com>
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
Cc: Lukasz Majewski <lukma@denx.de>
---
 board/liebherr/display5/display5.c | 1 -
 board/liebherr/display5/spl.c      | 1 -
 board/liebherr/mccmon6/mccmon6.c   | 1 -
 board/liebherr/xea/spl_xea.c       | 1 -
 board/liebherr/xea/xea.c           | 1 -
 5 files changed, 5 deletions(-)

diff --git a/board/liebherr/display5/display5.c b/board/liebherr/display5/display5.c
index e3a59dbec009..a0bbd03e8d19 100644
--- a/board/liebherr/display5/display5.c
+++ b/board/liebherr/display5/display5.c
@@ -4,7 +4,6 @@
  * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdt_support.h>
 #include <init.h>
diff --git a/board/liebherr/display5/spl.c b/board/liebherr/display5/spl.c
index 97928e92215c..819d3acbe560 100644
--- a/board/liebherr/display5/spl.c
+++ b/board/liebherr/display5/spl.c
@@ -4,7 +4,6 @@
  * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <env.h>
 #include <image.h>
diff --git a/board/liebherr/mccmon6/mccmon6.c b/board/liebherr/mccmon6/mccmon6.c
index 1b49526fba4f..fef915b2acaa 100644
--- a/board/liebherr/mccmon6/mccmon6.c
+++ b/board/liebherr/mccmon6/mccmon6.c
@@ -4,7 +4,6 @@
  * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
  */
 
-#include <common.h>
 #include <env.h>
 #include <init.h>
 #include <serial.h>
diff --git a/board/liebherr/xea/spl_xea.c b/board/liebherr/xea/spl_xea.c
index 6cf8f8390e8b..88c157eca45a 100644
--- a/board/liebherr/xea/spl_xea.c
+++ b/board/liebherr/xea/spl_xea.c
@@ -12,7 +12,6 @@
  * on behalf of DENX Software Engineering GmbH
  */
 
-#include <common.h>
 #include <config.h>
 #include <asm/io.h>
 #include <asm/arch/iomux-mx28.h>
diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
index 0a6fd7f1437e..9ade3563b255 100644
--- a/board/liebherr/xea/xea.c
+++ b/board/liebherr/xea/xea.c
@@ -13,7 +13,6 @@
  *
  */
 
-#include <common.h>
 #include <fdt_support.h>
 #include <init.h>
 #include <log.h>
-- 
2.34.1

