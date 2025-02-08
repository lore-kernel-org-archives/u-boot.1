Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E1AC02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6F8180836;
	Sat,  8 Feb 2025 18:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CSKXhEDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EA3D8083F; Sat,  8 Feb 2025 18:12:45 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D078082A
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-844dfe4b136so79602139f.3
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034760; x=1739639560; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22DTu4dGLVb3YFvFaQrr6xvHm/rcyuyLS42GLIaK0NU=;
 b=CSKXhEDt1/5pNwiP1pI7eiaIcCvzfxPm6sStygpPcH3pkt7CB+vb+Ww1rdG4pK6H18
 GSWJTl6nEjMsyZg1F2n2CZ/ig1+xaWVV8cRkjM5dlPR/0DjpPAEIQKIMkd0+Mo2kTBpU
 qCdYOUaFUAitl/QVSOznJpI4IZKmxvs1i4/Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034760; x=1739639560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22DTu4dGLVb3YFvFaQrr6xvHm/rcyuyLS42GLIaK0NU=;
 b=WSpzz/qQpAOFnXkThPR7IJrbttIMY1jdWDl2/jTUU/7rtYFiUI5iIXr8YAD1EFbkVo
 BqOVQkHBmcS28DYQJpvYtP2UIOMj+TNxHP5AtAJSF4rYnBLg0kM+pgyqFqX8yl+lXnXN
 Ufaw11LG2zdMM3cOM7a1mN13rtTj5uABJXsJ9xYr9uKLvF+G+Du5vRhVFDbYdjZbvXe0
 WpG/u8KM6Y0TEFRl7d3s/mRgAVS13YucI8pIpTLyMsee6oS/4y7EgLtVU4tz+TU6Sa/z
 qOCVsGy5D2h/k2m+GS0WdUDQkpkwcTa6R0AuwegcP7A+iTL6qLTD5cAwHtydq7tqM1Cq
 f0NA==
X-Gm-Message-State: AOJu0YxE4qzGRXSrpxo1gMfUfzftbXTLoxl3erVy6YDC0p5vff8GSPI8
 IB0ro922QTzSoVn6WVf2Q8UJ48COmX5xahiIQ+XFwx38BMw17THnsMgiai2eah5iXYtleUxydCU
 =
X-Gm-Gg: ASbGncv0IIC7C77cNMeVpc5wPNqNMdIsKV/t+Hl7HDYCD9Nta1e/5RECtxCkg3RWbMC
 ZQLGupEgEyArLC2C6m//fz+vGXslPGP3WbJSt1AlUjaraKmHBhXJv5DGpGrJZs1vjsNdkdZnrhM
 Kf5SvTI25w1BHCPxzYOXIldrS4syFTyFnxxP7hqU/r8HudC0XVqRDxvJZxdX7jiF4Quz+2SOOZN
 odvPVlJnm3pCbzjbQEfco9HVzUCy0WVWCYAxfjqfHQPJ13KVKUeckIbBnyXyam8X6sYTpM2rB/V
 QuMAXCn/m9Tg2RzDKUDRgQ7RHJ9JOvc+iP+1E3ZUEgiSc3d0Da90
X-Google-Smtp-Source: AGHT+IERk1d1OWJy5p/kc8T0eBmMVHUn9Og984zEz7ifVtFniRxMwUeKrq/rvsn0ZM5rYB5gaE1MYg==
X-Received: by 2002:a05:6602:3a01:b0:851:efec:53ad with SMTP id
 ca18e2360f4ac-854fd8b7226mr781188239f.7.1739034760582; 
 Sat, 08 Feb 2025 09:12:40 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 15/29] efi: arm: Avoid allocating page tables when running
 under EFI
Date: Sat,  8 Feb 2025 10:11:35 -0700
Message-ID: <20250208171154.1305761-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

The previous bootloader has already set up the page tables, so don't try
to do it again.

This fixes a crash in QEMU when booting from EDK2

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/lib/cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
index 516754caeaf..bdd0f202bf9 100644
--- a/arch/arm/lib/cache.c
+++ b/arch/arm/lib/cache.c
@@ -6,6 +6,7 @@
 
 #include <config.h>
 #include <cpu_func.h>
+#include <init.h>
 #include <log.h>
 #include <malloc.h>
 #include <asm/cache.h>
@@ -138,6 +139,8 @@ int arch_reserve_mmu(void)
 
 __weak int arm_reserve_mmu(void)
 {
+	if (!ll_boot_init())
+		return 0;
 #if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
 	/* reserve TLB table */
 	gd->arch.tlb_size = PGTABLE_SIZE;
-- 
2.43.0

