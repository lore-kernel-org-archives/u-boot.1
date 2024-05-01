Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D31C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8FDB88CC2;
	Wed,  1 May 2024 04:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="obxxitzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6767F88CB6; Wed,  1 May 2024 04:45:50 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19D3688C1C
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-69b5ece41dfso26526866d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531547; x=1715136347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0F2Z2C+qM8z4n5pTjwFlF9tJaRV8rJRinx4lWxmzgs=;
 b=obxxitzPMptHg88LRE1vwIeU9z27TezXQuGDCnfaH8U9npFP+VHo0376wZbbQeWAd5
 cwu0bqrgUv5g+Asjfi/4alM0GIQd8TYVI2K3guWjnJl6v/7DuRx/qKg8SgW9BL+gHfBl
 f1lw82mPlPc9xhVD1HiDOkeStUQjCeGClkO5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531547; x=1715136347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0F2Z2C+qM8z4n5pTjwFlF9tJaRV8rJRinx4lWxmzgs=;
 b=mjNNggpiJbcsMkdZmW4ktgiT1OWhMdKDTPUuF9EESuAkefsRLzxpkdBMWVbKxM/8uf
 7z/WHhhjKSqU5Wl7E/fwkyj3E/341SvzGRrpZyyDudDuGEWBS79F8e45dSNwRfCLwhAU
 mfU598t2pkgUNebNNdgFKJUdga2ejetYpdOgJV1Z4FpS32EUiaNClmieg/BlQuEuFaoJ
 8bsbsihEpuDo2e5dRtSyGqwTzq5q3q7TmuQlf1kmLIj9jZNpQT05W9c7B7B0MCLxjWb4
 Kz0H9NbQ1C5yirEV6aTzHwjB2gPDqZBPKhNAqVb/V/4e+Rhete+cnKxhYEyxXu9LT5CP
 vk9Q==
X-Gm-Message-State: AOJu0YxkZv2JXlHnG2iMqhCk77zdgjfqb+xGNPsoykV8nKNYB6x0GhmN
 cC5QU6NORzl7l15B2jm1AnMys+nlqs0rn8z/L105pmIIbvxG/RA1b67ADG7odk4+ZdZgtrh2JxN
 LAgQlxjBU
X-Google-Smtp-Source: AGHT+IElN0JvOjxA9w3jKOVeVq74CBYlTzmqjLShcx4fVCSeF4DgnGegaIJru/Ddo9VLLNunRLwnhQ==
X-Received: by 2002:a05:6214:1c05:b0:6a0:69ef:a264 with SMTP id
 u5-20020a0562141c0500b006a069efa264mr1310485qvc.23.1714531546774; 
 Tue, 30 Apr 2024 19:45:46 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 130/149] board: tcl: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:42:57 -0600
Message-Id: <20240501024316.1767971-130-trini@konsulko.com>
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
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 board/tcl/sl50/board.c | 2 +-
 board/tcl/sl50/mux.c   | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/tcl/sl50/board.c b/board/tcl/sl50/board.c
index 3f7d42f3eb8d..2e54ede62d6f 100644
--- a/board/tcl/sl50/board.c
+++ b/board/tcl/sl50/board.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <errno.h>
 #include <init.h>
diff --git a/board/tcl/sl50/mux.c b/board/tcl/sl50/mux.c
index ab9088145aba..6d89c4a3998d 100644
--- a/board/tcl/sl50/mux.c
+++ b/board/tcl/sl50/mux.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
-- 
2.34.1

