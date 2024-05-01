Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6292DC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 415B288C2A;
	Wed,  1 May 2024 04:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kL+kNSP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 878B388C1D; Wed,  1 May 2024 04:45:14 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D6838804F
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-69b9365e584so3645176d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531511; x=1715136311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IC7z3cg+VQcVQ+3/FbHIbwob63kIE4NRtuRVH7XA0M=;
 b=kL+kNSP1D4bxQKrl3ezBmadePX6juuTnf6x2BFBWkWqB2Y2te+ZOA0B+kj2V4z+vP/
 1VFt2lmRGmjFfm/BcHfYlAEtidWShBagMgeXEf5Afi/tnTj7k1uFD9Gqbpb+8yVOmPFR
 q6cBkdwr+bEAImkXQTjdbn9r1RJSSUvPB+o/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531511; x=1715136311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7IC7z3cg+VQcVQ+3/FbHIbwob63kIE4NRtuRVH7XA0M=;
 b=IoFGPYZoF3Rvuf7nhVrsUEya4Wcd0ErDweZyjK84Ivwm5dQuxGT/FUNR4ILVugpwT5
 E9Rkf9DaHp7xS6/Ts2EW/vIXjfw6wfH7m2W8gqTdlJE+L9d2YXu1CDwrhpLX/42vt34Y
 4XpXVXxTnwapw0x2+38XJpOVvynl1p+g6CmmJnvYsjBqO9Cus09wx7b46U9iatB9ZfbV
 DygA07vCsLzAKLfoaNYbf9piU+xuVYP1E/DZE+dOCuXKO7N6gPFI7HuNukdU4L1+WnWm
 zx2z0c+VsBtNbNXbcHg0zT6jFiRoCsL9JkWzs0RrbIjhaAFg2SdWEf/79oS0xP08vteS
 BZJQ==
X-Gm-Message-State: AOJu0YxfXQkk/jub7v0+CQO2P9TYqN3eLB52IFee0pyj39ISfsI+yLY0
 jeegRpaPkLtvb+HBu1UnAxqw4TREhk+wVDKOsPRJpTA6aj9jVRMTRffCaJOlyKuIZu/3GJJe2ea
 LAJOKA9t7
X-Google-Smtp-Source: AGHT+IGv4lE+6jLBSdc12vf74Sv0oHaFUjdXDEKXizJkMK9gs9F7d0E6+CodPmtOAdlgn18+qfMLvg==
X-Received: by 2002:a05:6214:1090:b0:6a0:e7d8:4adb with SMTP id
 o16-20020a056214109000b006a0e7d84adbmr3908663qvr.26.1714531511226; 
 Tue, 30 Apr 2024 19:45:11 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stanley Chu <yschu@nuvoton.com>,
	Jim Liu <JJLIU0@nuvoton.com>
Subject: [PATCH 098/149] board: nuvoton: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:25 -0600
Message-Id: <20240501024316.1767971-98-trini@konsulko.com>
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
Cc: Stanley Chu <yschu@nuvoton.com>
Cc: Jim Liu <JJLIU0@nuvoton.com>
---
 board/nuvoton/arbel_evb/arbel_evb.c | 1 -
 board/nuvoton/poleg_evb/poleg_evb.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index 8fc56c183976..44e0cc9ae7cb 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2022 Nuvoton Technology Corp.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/io.h>
 #include <asm/arch/gcr.h>
diff --git a/board/nuvoton/poleg_evb/poleg_evb.c b/board/nuvoton/poleg_evb/poleg_evb.c
index 7421911a416b..093ea292ac02 100644
--- a/board/nuvoton/poleg_evb/poleg_evb.c
+++ b/board/nuvoton/poleg_evb/poleg_evb.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2021 Nuvoton Technology Corp.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <asm/io.h>
-- 
2.34.1

