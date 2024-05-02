Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779B5C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AFE388BE7;
	Thu,  2 May 2024 03:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Factc2r0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 853C888BED; Thu,  2 May 2024 03:31:50 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51EF488B98
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4371955d27fso45523671cf.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613507; x=1715218307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mr95XS4slzFbw8V05f9ALVkdwe0bfvRRNpRAZXjLy7Y=;
 b=Factc2r0JUaj2wWVMuofw99N2I4OHKIbUvUfU8EMdFdsKv7kkzYUEoOmT05T0ifqXA
 dDumkDJwrpBGywCuxkp5dPS9mUTr1STfQVQ1ZuidID4y9jk6AguVWbUWXIEmGYuHQefx
 iSDlLt2rrIO7XDwVODY0R2ZENMWfYdBg0phm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613507; x=1715218307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mr95XS4slzFbw8V05f9ALVkdwe0bfvRRNpRAZXjLy7Y=;
 b=oM3dTJa+Zy9zobepvu1RzLCBfsBJQNDEQjFzW79dJS4BPIb4Dnf9ov1YJ86fm9aUPb
 7AMsBYPqV8vYAlO5Auc+HjNJ/lLbvuqsRrzmr51AhsMn0IKCHV47JIPDXg0WMMbpvikb
 hZRSvCfW6HsD/N3VmPJu/uMRYlOVqzK4Mqp6PUruyzWbQ3Tp4s1EOxhTpJPQUvx3aLk/
 ZEj16pXtSCw/61vym+41hB4AlH6VYr20kCTH0qkvXTcoL9f/oS0FXrDgfzH2h6rYB+nw
 RCwI9IaFO5I+5FkCJBHMapc4GR+pWgQCPWfID0LlFkdxi8J4WT1o0HexyoGKx4ZH4slq
 tnsg==
X-Gm-Message-State: AOJu0Yy86rzgP/eeeW70uXyj7KbJeNmdShhkbUG5C6Fnb+PlNSj0edzJ
 e/byd1t71I5l5XfgDsrSXM/psQmwDCbkNIclljv/wDADWhs1Tgb1HHsE4bBEsblaTmGUIdHgRES
 hR5a7+PRm
X-Google-Smtp-Source: AGHT+IEC0FwojiPePbFCj/UqdsgSvxGCRartikvJFoUeDCGwOCEte0sXM0vpp8StbW0vVEB53tTEsA==
X-Received: by 2002:a05:622a:540e:b0:43a:c554:e64a with SMTP id
 en14-20020a05622a540e00b0043ac554e64amr5272254qtb.26.1714613506821; 
 Wed, 01 May 2024 18:31:46 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.45
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:31:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 05/81] arm: socfpga: Add missing <linux/types.h>
Date: Wed,  1 May 2024 19:30:22 -0600
Message-Id: <20240502013138.2383421-5-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

This file has many "Linux" style types in it, add <linux/types.h>

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-socfpga/include/mach/secure_reg_helper.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/secure_reg_helper.h b/arch/arm/mach-socfpga/include/mach/secure_reg_helper.h
index d5a11122c723..01335dc93108 100644
--- a/arch/arm/mach-socfpga/include/mach/secure_reg_helper.h
+++ b/arch/arm/mach-socfpga/include/mach/secure_reg_helper.h
@@ -7,6 +7,8 @@
 #ifndef	_SECURE_REG_HELPER_H_
 #define	_SECURE_REG_HELPER_H_
 
+#include <linux/types.h>
+
 #define SOCFPGA_SECURE_REG_SYSMGR_SOC64_SDMMC 1
 #define SOCFPGA_SECURE_REG_SYSMGR_SOC64_EMAC0 2
 #define SOCFPGA_SECURE_REG_SYSMGR_SOC64_EMAC1 3
-- 
2.34.1

