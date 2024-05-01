Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE74BC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AAD488CD0;
	Wed,  1 May 2024 04:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eeODTC2G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 431C288C8C; Wed,  1 May 2024 04:45:57 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3050088CB9
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-790e7c02430so293816585a.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531554; x=1715136354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrLjZ79iUqVs2X5EcyK9llJ90R8o3UXxM0QFp3L8nmg=;
 b=eeODTC2GrO2WTaShGuIcMMwgFmxkUvDXl7RfiVd1GozeDt6LE2Tk7W1dWVMp6AJTXi
 FGKfQWlq92vBGfmYMmngtHilsyvuaeLpb58cnuF5DWCQ/mcHwY1/FAMlysfNunySd+tV
 PDxPZKuEbSGMmXJMhwDX/70msCvOLjthK20z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531554; x=1715136354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xrLjZ79iUqVs2X5EcyK9llJ90R8o3UXxM0QFp3L8nmg=;
 b=A5T4aiJKDaDpAzqmrIhbdZ5TvjbjD98kyHOUfIENciEyYjpm3ooS9Fg+EXpomGT0EQ
 4ox4kWTBK/PvW/QLMYZ7vQJMCKRxvz6dKFZ54R6tzYd9mMRgiRSnda3JP6tJZT2/Q1CH
 9/sv9j0318St5uPw0qOE6iUj9bm4wrbmzt+wn5yZjJdXQpZTnvlxL2oTbOFKv+jF/ud6
 pWhVxKdoKO0ybAEwShHTvOueqn+0C4DvM1xq7guZomywsRBssCdDjidJ1gE/CfAdqufe
 8A6U6eRZOw7f9+TxOmUy96eOgAhJ+sJ41YsAHhEMUzYv25/amXh1FhqPwDlnAG68hlHc
 un5Q==
X-Gm-Message-State: AOJu0YzUBA4ACU+TDiiNqvjHahLicpBVltR5BnHbFXpRsvUnv8w90TOj
 MVuMkOM9/HQPpgNdjWjTRUEqT57N7dUcrt7/uy2mnPl85+ht4+eaJFJiz0AqYhyauAEc7vbXHS9
 K32LctmyS
X-Google-Smtp-Source: AGHT+IGmLNnfL7voNmDiqAlgaJdl/FEqpMB4cNXsrieg9XXJt1LKaTSwS/FOQiC8MryVz9s58s6L8A==
X-Received: by 2002:a05:6214:d48:b0:6a0:ab58:7f52 with SMTP id
 8-20020a0562140d4800b006a0ab587f52mr1480904qvr.37.1714531553899; 
 Tue, 30 Apr 2024 19:45:53 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Vladimir Zapolskiy <vz@mleia.com>,
	Thomas Weber <weber@corscience.de>
Subject: [PATCH 136/149] board: timll: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:43:03 -0600
Message-Id: <20240501024316.1767971-136-trini@konsulko.com>
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
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Thomas Weber <weber@corscience.de>
---
 board/timll/devkit3250/devkit3250.c     | 2 +-
 board/timll/devkit3250/devkit3250_spl.c | 1 -
 board/timll/devkit8000/devkit8000.c     | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/board/timll/devkit3250/devkit3250.c b/board/timll/devkit3250/devkit3250.c
index efef855b3d06..f0c0f03deeb8 100644
--- a/board/timll/devkit3250/devkit3250.c
+++ b/board/timll/devkit3250/devkit3250.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2011-2015 Vladimir Zapolskiy <vz@mleia.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/clk.h>
diff --git a/board/timll/devkit3250/devkit3250_spl.c b/board/timll/devkit3250/devkit3250_spl.c
index 12e8ae9c39cb..07a367c3ad15 100644
--- a/board/timll/devkit3250/devkit3250_spl.c
+++ b/board/timll/devkit3250/devkit3250_spl.c
@@ -5,7 +5,6 @@
  * (C) Copyright 2015 Vladimir Zapolskiy <vz@mleia.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/cpu.h>
diff --git a/board/timll/devkit8000/devkit8000.c b/board/timll/devkit8000/devkit8000.c
index 06009d8ad54c..ad404f7e9c4c 100644
--- a/board/timll/devkit8000/devkit8000.c
+++ b/board/timll/devkit8000/devkit8000.c
@@ -15,7 +15,7 @@
  *	Syed Mohammed Khasim <khasim@ti.com>
  *
  */
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
-- 
2.34.1

