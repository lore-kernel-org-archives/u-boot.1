Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1496C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B233C88CB2;
	Wed,  1 May 2024 04:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rdOyW0eW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17E6488CA8; Wed,  1 May 2024 04:45:53 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9581688CAB
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6a0ce3e823fso13802366d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531549; x=1715136349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qiDFuKiOQeRgigAeRPNJdMgQCXEGFxmGYIbtjIkiwN0=;
 b=rdOyW0eWkDJ2sgF/ieMhD/NS+tXi54sY6mNzztM7zdaz1XmOQlgj6ZeA4+fCQbbVCU
 cybCZ25cW5z+issly24FM6bY3dkQ+imkX3p2CZpVRhbE+dilGjqVU7DVV3Q7Aaf8DpWu
 WTlivT0mvT0qDGBN3L1Ni61PNWrdQzpe3PouI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531549; x=1715136349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qiDFuKiOQeRgigAeRPNJdMgQCXEGFxmGYIbtjIkiwN0=;
 b=ARCCVxzYBbVlVqPrOAsFOfL4bhvEcpe73O78eY8hrjcGHSR2HFJfqrvJ5WD8xCkquP
 /tRyaDsuZOPhq0LkMFGBSC2Kl7USJAnmnSg5kku+TxzeU7AVuINydoP6yK5rTn1RAKqz
 EyVCwgVkbBOp+o6m5U8nGqH7YsmpomUZHnvs8l4szvcYiuQJwWo26e0Rtddfhxk4mSQw
 fqny8Waj8Vm4Mm6CxmhKhb4vxpIVqe3gP9ClGK0lsETz1hCo6HDMPzX9CN7NG07nVDpi
 4vrqcI2/ocYVtVbrWeznuXY8AuTj56588CtTz7vsSncSER319xIxEnVOpcvZ8t/1GJTr
 L1Fg==
X-Gm-Message-State: AOJu0YwFUpy5+wBZwuSfT7PtRt8H2tReZ+3bUsNHxNDGQzTfpnULbHtx
 LdZt1ypTn7n8pQbP4QzRgez4XPr2/5+rQi/DeSCS/0EwL21YVOZL3ihnxJABfv+PxrKrTu9BdtQ
 jhD20O0eT
X-Google-Smtp-Source: AGHT+IFVGOQbeVBaDQj3Bs7wVmUkxQ5XN0TC3A/+6cMzjpS4KN027rf2vHOOv/+3r4XPhZIbo5qCUQ==
X-Received: by 2002:a05:6214:2465:b0:6a0:d6c1:b795 with SMTP id
 im5-20020a056214246500b006a0d6c1b795mr1328410qvb.5.1714531549398; 
 Tue, 30 Apr 2024 19:45:49 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 132/149] board: terasic: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:59 -0600
Message-Id: <20240501024316.1767971-132-trini@konsulko.com>
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
Cc: Anatolij Gustschin <agust@denx.de>
---
 board/terasic/de1-soc/socfpga.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/terasic/de1-soc/socfpga.c b/board/terasic/de1-soc/socfpga.c
index 22fbee40aba9..8d17f44fd373 100644
--- a/board/terasic/de1-soc/socfpga.c
+++ b/board/terasic/de1-soc/socfpga.c
@@ -2,7 +2,6 @@
 /*
  *  Copyright (C) 2012 Altera Corporation <www.altera.com>
  */
-#include <common.h>
 #include <spl.h>
 
 void board_boot_order(u32 *spl_boot_list)
-- 
2.34.1

