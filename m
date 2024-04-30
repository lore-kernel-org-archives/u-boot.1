Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18B9C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 137DD88A2A;
	Tue, 30 Apr 2024 15:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pUkndYQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACE3288A24; Tue, 30 Apr 2024 15:36:19 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B015F88A2E
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-43716ff5494so59572301cf.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484175; x=1715088975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nX6jOk8wwKbEItlzQt4Hp6AAMuS9Assh+V7tL8zMLo=;
 b=pUkndYQi4YFZAksF/nTsjUQiXnaJh6MHSAGzyCA5qzcnomVR9v/TD4JAUh6xnjjVn8
 yzweyzZ2NVmRiSHg4TXhY6+FPojnnBBKSTr7B3KGscyZsVh+NFz5HvAbgR5HLhgZcWXB
 TxfUDUekYzV1ZLpb8uUCUXDsSdm6u9WoilXVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484175; x=1715088975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7nX6jOk8wwKbEItlzQt4Hp6AAMuS9Assh+V7tL8zMLo=;
 b=XyG4TdlbKUTDyEORZWxvcTfgs7LbDFxWPFKs97256BXrnMCN+UitHMI4esWKhTtObx
 mEWzP6wGJuTMAe1IgksCve7Kc0DgTViHXDFKrOzcxJHBZZA7GtdpmeADNPyYYi2qh3uG
 +vbo2IwC+ZJr39XyiwHyR2hNve559thbBHl/iJ81pR6pxr+u32A6qqSOdmSYRtP4S/ck
 O7dBzFpzUBrsT05B2w9zxNruIgQKf2+1ZfJ/PnEnxI/qL+MkLiw7MENEQZZu0Y9MVBPN
 +1Ak5U1qTuX/AsnGHvV/FgyTqZDk1LqXjuMSKDAOnM0+nYfBm/z3oUHJktU74Icx2rRb
 t8AA==
X-Gm-Message-State: AOJu0YxYBzXW49IjxxgwwZZzoEk99A2ACbrEvAa3MsAddk2OPP2ngVlu
 6WGB6CPiE7AEjtyTjSNTxMMe6Rghuu9B6xXTXs/3TlE+fEeoLCwSQ8MVKZWSeDZCFvLpVvY76v2
 sH0cwKw==
X-Google-Smtp-Source: AGHT+IHoktGd6eHS3U2a39rSiP4zDApL6M1cvbrvCMvdecfTepK1xi/8zV0qC1CAz6waCrYmo3pB5Q==
X-Received: by 2002:a05:6214:2b0c:b0:6a0:c123:8a78 with SMTP id
 jx12-20020a0562142b0c00b006a0c1238a78mr4788878qvb.6.1714484175041; 
 Tue, 30 Apr 2024 06:36:15 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 11/33] arm: owl: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:37 -0600
Message-Id: <20240430133559.1836389-11-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
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

Remove <common.h> from all mach-owl files and when needed add missing
include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/mach-owl/soc.c        | 3 ++-
 arch/arm/mach-owl/sysmap-owl.c | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-owl/soc.c b/arch/arm/mach-owl/soc.c
index f0f46f2dcb74..e6332452e3ee 100644
--- a/arch/arm/mach-owl/soc.c
+++ b/arch/arm/mach-owl/soc.c
@@ -5,13 +5,14 @@
  * Copyright (C) 2018 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
  */
 
+#include <config.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <linux/arm-smccc.h>
 #include <linux/psci.h>
-#include <common.h>
 #include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/psci.h>
diff --git a/arch/arm/mach-owl/sysmap-owl.c b/arch/arm/mach-owl/sysmap-owl.c
index 81f6ca2e4919..6f0a220320e4 100644
--- a/arch/arm/mach-owl/sysmap-owl.c
+++ b/arch/arm/mach-owl/sysmap-owl.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2018 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
  */
 
-#include <common.h>
 #include <asm/armv8/mmu.h>
 
 static struct mm_region owl_mem_map[] = {
-- 
2.34.1

