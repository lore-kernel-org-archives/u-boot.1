Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2FDC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9276587D47;
	Wed,  1 Nov 2023 17:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qb0iAx5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEAAB87D29; Wed,  1 Nov 2023 17:28:41 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FB5B87D09
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41c157bbd30so43336791cf.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856112; x=1699460912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=crEN3stJejLDERx/aqaO6DQRRgExWaQ0h7rsEHX0HRg=;
 b=qb0iAx5/7Wx+Tgy1UU6Eeq6lkLO4GeRrVC3EtsoCLOiszdENC4Sk179LJIhcCMqAr4
 MuciW0FbEoWqjXb71D678KhkCVuGkX/O66GqbRn14DVoayweNgRSegsTEhbsb0r13NVI
 irGybmnQRHI52swuC5x1OJUehtsE6CJGW84jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856112; x=1699460912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crEN3stJejLDERx/aqaO6DQRRgExWaQ0h7rsEHX0HRg=;
 b=JH7Qny5zdSvZDleaOOtwcR+LgBLc+gYS3dkAN+u4HQd64oSY1h/ePdtHS52Bjfxuxf
 n9rkHG5ybuG56693gqMnxM/NtxmMepQApMBpryS9tFGqcgXg/4mXLLFJfgHgqV9hN4/6
 mBfu/GXWmT6YO8bVrzQhQXFA2Yp522jjiZJZCaPKC96EaGKqVvXQ/sE+F5Wguc4Ji0CE
 Wy84kJflcOYHA5eCi06+nhWusxFtQ831/H1Uwb/j4RcWc0XmHADMxpONsYCpp5dOpx4w
 7wAOQqmUXubdions8sGcNxRJTZ3cVTHEqw6rGMFtkAn6l5TIJW8CRxCjITLagib7MEDW
 K9Ng==
X-Gm-Message-State: AOJu0Yz2NrCHtBDhHIRrBljN6VrUTJJkKRLDYUyMGJW3Rtin5QC5/rH5
 MYc6P4BUvRdDjRey8TaZOUqElD11EmqInaI5ckWnXg==
X-Google-Smtp-Source: AGHT+IFbcv6CURgg1VoiwalkKtJfBZy89vndOC6ak6DFUZmxeKAd2KoEk3qCGHnsvfax/FxfshuW+Q==
X-Received: by 2002:a05:6214:230e:b0:647:406b:4b06 with SMTP id
 gc14-20020a056214230e00b00647406b4b06mr18463543qvb.57.1698856112182; 
 Wed, 01 Nov 2023 09:28:32 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 07/20] powerpc: mpc83xx: Rework includes slightly
Date: Wed,  1 Nov 2023 12:28:11 -0400
Message-Id: <20231101162824.3755579-7-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

In order to not rely on common.h providing a number of common includes,
cleanup what we include directly in order to be able to drop common.h
later.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/powerpc/cpu/mpc83xx/cpu_init.c | 2 ++
 arch/powerpc/cpu/mpc83xx/start.S    | 1 +
 include/mpc83xx.h                   | 2 --
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/cpu/mpc83xx/cpu_init.c b/arch/powerpc/cpu/mpc83xx/cpu_init.c
index 8e6d3d28fc63..340f9a0da56c 100644
--- a/arch/powerpc/cpu/mpc83xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc83xx/cpu_init.c
@@ -18,6 +18,8 @@
 #ifdef CONFIG_QE
 #include <fsl_qe.h>
 #endif
+#include <asm/ppc.h>
+#include <asm/fsl_lbc.h>
 
 #include "lblaw/lblaw.h"
 #include "elbc/elbc.h"
diff --git a/arch/powerpc/cpu/mpc83xx/start.S b/arch/powerpc/cpu/mpc83xx/start.S
index d72d3147f63d..ceb548678946 100644
--- a/arch/powerpc/cpu/mpc83xx/start.S
+++ b/arch/powerpc/cpu/mpc83xx/start.S
@@ -20,6 +20,7 @@
 
 #include <asm/cache.h>
 #include <asm/mmu.h>
+#include <asm/fsl_lbc.h>
 #include <asm/u-boot.h>
 
 #include "hrcw/hrcw.h"
diff --git a/include/mpc83xx.h b/include/mpc83xx.h
index 5926c8090a48..aa8803413cd5 100644
--- a/include/mpc83xx.h
+++ b/include/mpc83xx.h
@@ -6,8 +6,6 @@
 #ifndef __MPC83XX_H__
 #define __MPC83XX_H__
 
-#include <config.h>
-#include <asm/fsl_lbc.h>
 #if defined(CONFIG_E300)
 #include <asm/e300.h>
 #endif
-- 
2.34.1

