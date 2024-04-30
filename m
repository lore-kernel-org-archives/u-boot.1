Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD02C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C7288A78;
	Tue, 30 Apr 2024 15:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G/OFFe7Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D45588A5E; Tue, 30 Apr 2024 15:36:33 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC20F88A6A
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6a0b4622ea0so17504046d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484188; x=1715088988; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NuT15ewAdCx3dIZpIl3gQetej90w+XOx+TLHYQrvKiA=;
 b=G/OFFe7ZsEKyJvILwmytzpRYFV7kr4gYPrsXmh4fXQGhw+SW1tZ1/ksZMI5dTe31T2
 A2VT0FmTzUNHbMBeskY89AFyKrQGP48TbLIG7hJIEdOifsdlhW2jPFkc9Sn9hNX2ieEo
 JQ3ZcQ+lMbA4XThPeowqLEdNlTJCVEgoawTXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484188; x=1715088988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NuT15ewAdCx3dIZpIl3gQetej90w+XOx+TLHYQrvKiA=;
 b=jBpbETF2coJkCQ4aOpV95A6yUqTjL5HLEEeq9uwjgUBvr0/N2ZnTMh9CsaDV5ryNfT
 IYpKqHihDLuImG8e62AI9oMW3em310cluW+OsVmUZtOndtiggkNAUlahuL8NAIe34Gq1
 aVJZq1xyIH3Pm9DpaNqBcVstas6pvDOXOaqfjF6ggjU28U8vbOx65K8V97E8srVMbMcV
 VK5oWouV9X0miLMEgGp0slR50kInEA9u4pFaBNRKVrNUm3bHT8EcVB5vvwl/HpubJD5R
 jfJrx3PB8JUmf6brjrj8Y3YxK0hOwrxNsBUbXL8PNXTHRkkqF+wPIbeng7rOlOx7NKyE
 avzA==
X-Gm-Message-State: AOJu0YxXiBzR+jd3HtRW/AQ1+miZSsfmYSOTxW436Z0hB86y/FzuItBU
 4xGfBQH7Urcpa2fvbGSYF9JLAui4aPQ5bxhV5n3o3mIeZgOnAfsWTMoqnG18AuX+GaY/oAtCXMM
 F9HSsDA==
X-Google-Smtp-Source: AGHT+IF2Sz+8pg2JV5D8kOOeE7jf0y+uZUZLeKfRzWRonDc5yAJiunGZhmN0nBkT7TiG1vyW3PwIBA==
X-Received: by 2002:a05:6214:1d09:b0:6a0:669f:ff2c with SMTP id
 e9-20020a0562141d0900b006a0669fff2cmr14886988qvd.64.1714484188190; 
 Tue, 30 Apr 2024 06:36:28 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 24/33] arm: histb: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:50 -0600
Message-Id: <20240430133559.1836389-24-trini@konsulko.com>
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

Remove <common.h> from all mach-histb files and when needed add missing
include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/mach-histb/board_common.c | 1 -
 arch/arm/mach-histb/sysmap-histb.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-histb/board_common.c b/arch/arm/mach-histb/board_common.c
index a26c2066e028..84d02c9aca21 100644
--- a/arch/arm/mach-histb/board_common.c
+++ b/arch/arm/mach-histb/board_common.c
@@ -5,7 +5,6 @@
  * (C) Copyright 2023 Yang Xiwen <forbidden405@outlook.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <init.h>
 #include <asm/system.h>
diff --git a/arch/arm/mach-histb/sysmap-histb.c b/arch/arm/mach-histb/sysmap-histb.c
index 83a2bb941799..76414558379f 100644
--- a/arch/arm/mach-histb/sysmap-histb.c
+++ b/arch/arm/mach-histb/sysmap-histb.c
@@ -5,7 +5,6 @@
  * (C) Copyright 2023 Yang Xiwen <forbidden405@outlook.com>
  */
 
-#include <common.h>
 #include <asm/armv8/mmu.h>
 
 static struct mm_region histb_mem_map[] = {
-- 
2.34.1

