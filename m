Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94142C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA93688BAC;
	Wed,  1 May 2024 04:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M/rs5QTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2490F88B9D; Wed,  1 May 2024 04:44:45 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99EAD88BAC
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6a0c8fb3540so4318506d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531481; x=1715136281; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7B/iIORXl6MbfpPeo3KN9hw9BdyPn/5cTqaRFKlpvI=;
 b=M/rs5QTlW4/MBWIApH+f8EUWL7Jesaq3Wxb1HDQpQy6qy1/CRnhapzFyHwsTX6t/fi
 nk60sKrRN/3XgUCYSLuEnCb49EV0gL4356Hm4Bpls1BV17GaCQJLpucsoPHrEN/NfbSl
 19Evpzx+i8oiP5Xx3FMr22Rn7rEJLCTGhOAwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531481; x=1715136281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7B/iIORXl6MbfpPeo3KN9hw9BdyPn/5cTqaRFKlpvI=;
 b=L4DsnqNFlGm87UuIQ8Cme8NxCLrOWi1GVcl4CW8FqDPAWveyYl4maJ9JjP8hKQLy5t
 kjzJIletlJ0Z+De4q/Xc0nlMk11rll+z8IUrYuGG0YjpXgfR7lwJfFycwXJz9oNZultU
 0UIU0t65CvuvfW4F86r91mhu1wrZlX134CLhHw7rMtzb72iuX5YGnrP/T0+QcBhYAP1R
 oeRGegIB+54n8cyQlt/mtMX2SOqN8J3J+A22eTSTQPNjBS78VgT1xfxC4nnCae//CqKm
 9QWmVLbWJ9HE/QlOJrc3QV3mxAvPvfFN/gllkqQywZUCES81LYCLmJXVQRe+v487BN19
 dFiQ==
X-Gm-Message-State: AOJu0YzQTxfgtDwI8NSq9ZnE69bsBl3Hl/+bZmbQmO3LTRHl+xVsq6HK
 bwEzn2Qky/xcVjtcLPPlVzB5uEI3RNR8IXYpybp7VVELOeTakDr2XUWUujbJOgEHPS1lkfGkVaB
 IjXHK9w==
X-Google-Smtp-Source: AGHT+IFWTGNMz+QypzMuAxcejBws2xJHQTZGjUBwKMJP6SRymlD2RgaPyCvQDP0uOnoyObGBlpvT/w==
X-Received: by 2002:a05:6214:1c4f:b0:6a0:e529:e953 with SMTP id
 if15-20020a0562141c4f00b006a0e529e953mr6013227qvb.6.1714531481389; 
 Tue, 30 Apr 2024 19:44:41 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>, Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: [PATCH 070/149] board: hisilicon: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:57 -0600
Message-Id: <20240501024316.1767971-70-trini@konsulko.com>
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
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
---
 board/hisilicon/hikey/hikey.c       | 1 -
 board/hisilicon/hikey960/hikey960.c | 1 -
 board/hisilicon/poplar/poplar.c     | 1 -
 3 files changed, 3 deletions(-)

diff --git a/board/hisilicon/hikey/hikey.c b/board/hisilicon/hikey/hikey.c
index c9a2d60ee56c..95a831efcafd 100644
--- a/board/hisilicon/hikey/hikey.c
+++ b/board/hisilicon/hikey/hikey.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2015 Linaro
  * Peter Griffin <peter.griffin@linaro.org>
  */
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <fdt_support.h>
diff --git a/board/hisilicon/hikey960/hikey960.c b/board/hisilicon/hikey960/hikey960.c
index f41fabbad099..5029f4edb2af 100644
--- a/board/hisilicon/hikey960/hikey960.c
+++ b/board/hisilicon/hikey960/hikey960.c
@@ -4,7 +4,6 @@
  * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/board/hisilicon/poplar/poplar.c b/board/hisilicon/poplar/poplar.c
index b89e7e869766..c3ea080ff75a 100644
--- a/board/hisilicon/poplar/poplar.c
+++ b/board/hisilicon/poplar/poplar.c
@@ -4,7 +4,6 @@
  * Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <init.h>
-- 
2.34.1

