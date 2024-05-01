Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2835C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2960E88B1D;
	Wed,  1 May 2024 04:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="czoSaz2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4AAD88B1B; Wed,  1 May 2024 04:44:05 +0200 (CEST)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A3C888AF2
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7f16ff3aa61so537898241.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531437; x=1715136237; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0q1eZo2rGpTMwEaWnj8kNk4nAjrq/mlG+GigggeHobA=;
 b=czoSaz2VgrHgpxgANJKEr5NswJiwfKRuIbec6A00lz/+smaIyOx6X/ObQh4rn+0yEQ
 ywcwFgXypi2N1HwWYF+PrecdWY0JZc2o/AbxMuCOeNbUewne1B+ve+B9NXYR0Q+jlj/B
 ZONf4YAWfkmeJ8VFZnBN91TsfYSIs5lNhWLzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531437; x=1715136237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0q1eZo2rGpTMwEaWnj8kNk4nAjrq/mlG+GigggeHobA=;
 b=uK2mpp1Gkpyq0Gq/4xgXlCOiWQZ3ZuXGALEXgtrQFkArpx4Ui5buS0ZJwMXLXwMd5J
 srtJc8L6MrDwvNcPl67OoPR27P02nKTJeVbWNoyP5PMiQnkfbZWxYc5t+DZDb3kPPpz5
 pMITyYQhmVRHpnUIJN2O8d8ekTsgJ3SOJuxgCBVIyRbHNmFiNzhJh6Y5OXUNQKYCYbWU
 SjTNyG8s5BFbARA5i8pnRXYKmlY7LJefpzkFfibKNBkdvbF+tLWA+ll0+dvPFL7D+b/6
 I5gSqDxM1K+K5DeXpdfjKSfr+sjj5EdBNjYzNw17v2FfIzUpMwZcvKiw+Sp+GKGMJTP6
 MNSw==
X-Gm-Message-State: AOJu0YwL57j4b1G7Y4B6NMNTBmokv3LcFx6o5L9ElOCcIbJAYvNCkAju
 3ifNANwf6U7KwcwMXrbdn5Xxdb1aW2kju6LsTjGAjflJqd7ihyU86ZspFUUqrdcUsgwuUvYjG8D
 zUun1Vg==
X-Google-Smtp-Source: AGHT+IEFRFzL2dMzp6VxjEMoPaXH4JmzYUb5VgxKf7hZNm+To058QZzjSQ+Fdt6ArRsIqOG7NN3MBg==
X-Received: by 2002:a67:f542:0:b0:47b:add2:8a74 with SMTP id
 z2-20020a67f542000000b0047badd28a74mr1378785vsn.14.1714531437259; 
 Tue, 30 Apr 2024 19:43:57 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 033/149] board: cadence: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:20 -0600
Message-Id: <20240501024316.1767971-33-trini@konsulko.com>
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 board/cadence/xtfpga/xtfpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/cadence/xtfpga/xtfpga.c b/board/cadence/xtfpga/xtfpga.c
index 8e4081b4c6dd..5110fed31194 100644
--- a/board/cadence/xtfpga/xtfpga.c
+++ b/board/cadence/xtfpga/xtfpga.c
@@ -4,7 +4,7 @@
  * (C) Copyright 2014 - 2016 Cadence Design Systems Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <clock_legacy.h>
 #include <command.h>
 #include <dm.h>
-- 
2.34.1

