Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B75C25B78
	for <u-boot@archiver.kernel.org>; Sat, 25 May 2024 21:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D1B0882C4;
	Sat, 25 May 2024 23:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kUAzXcmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB5B5882AF; Sat, 25 May 2024 23:53:34 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF0B8830C
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 23:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5b2cc8c4b8aso5594985eaf.1
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716674011; x=1717278811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/OYSheNlORPwPczKReckMZu0fQE2svMGFa1U+qR/sdo=;
 b=kUAzXcmmektlXHwhMatHhJfjgfYNVh44ymjzWoCoFz+npKc2HX0KR7aYOvb+LtYjI9
 Uy/f+vokbfDt7XZ8F2tt5OKUykJW6oRSFjT6gM/ARRBOLg5MrAr6KrCCiTkclhyeyx4N
 SMEGtrA1ya2rolA2+bU6Ty8sXDTi/HCcA+4uTPJhoqaqWyDWGseDaAY4mQiG+JBqZOE0
 GOdhxHE6mbi8/euiCNRgfrVSX5wPMmmiZdu20epnzXvxb9G8ni/pedXowIpIWetvLP3a
 BqzWHn4SPvSiSQoOAWyH2uLM8vnqNDAfbK12luQYq53e22nFg4nCMfLXLPxBGPnymIqa
 W73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716674011; x=1717278811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/OYSheNlORPwPczKReckMZu0fQE2svMGFa1U+qR/sdo=;
 b=JzoMY/mERoIBBz5BUWTZ3YSc56vllx1Ehx93B5oH2F2flbNQXAoqn5hQmcZUXNzH3O
 MIYfouDHVXhSwPrDVwTMGf1ZnYBWH4BBlFDbzsT14Fz7PADgEhWlCafdaV+ySnG8dILw
 4YIgx1AzUfIE9m8kYIOhW+nrOSVqbzCVFJKTDokWEVtfSyA7SJs2q2Z2+Vl58g2SsmLk
 4enhErwy5fp+w+QBNHJuB3t1oYeCenOddt8DMbUzOmsuWV7/ropcIebsWrQf4JOri0pE
 ZOvkw6SxAwn20E8S7f2qgwXq/hxxkxMEluO/AVld3PVRHcOB3qIVPlJYzKBU3NacxHWw
 dDyQ==
X-Gm-Message-State: AOJu0YwN1UnMn3PdhYZjPBvPiRKQlXJxIwNrN8rD4Z3j/h4X/2MqV+hp
 K4NSY9bUlniiQ98q6ER660ItZ5AYH9+FASeeQbSql5qcIW6d/P0P6C7ByTPMNAE=
X-Google-Smtp-Source: AGHT+IHvgYXK1VI5MlkUEcI/WAK0neLiYUmql0saIy4LG+ncuoWoAaNIvNwPCqzGDz8YIRsua1j3xQ==
X-Received: by 2002:a4a:7609:0:b0:5b9:70f8:4b82 with SMTP id
 006d021491bc7-5b970f856cdmr4838582eaf.9.1716674011404; 
 Sat, 25 May 2024 14:53:31 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5b96c4d5377sm927429eaf.24.2024.05.25.14.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 14:53:31 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] arm: exynos: Map iRAM APM area for Exynos850 SoC
Date: Sat, 25 May 2024 16:53:30 -0500
Message-Id: <20240525215330.16609-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

This iRAM APM area is needed for I3C access to PMIC via APM block.
Without this mapping any access to APM iRAM leads to "Synchronous Abort"
exception.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm/mach-exynos/mmu-arm64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-exynos/mmu-arm64.c b/arch/arm/mach-exynos/mmu-arm64.c
index 30e522804fbf..4c154950f73b 100644
--- a/arch/arm/mach-exynos/mmu-arm64.c
+++ b/arch/arm/mach-exynos/mmu-arm64.c
@@ -101,6 +101,14 @@ struct mm_region *mem_map = exynos7880_mem_map;
 
 static struct mm_region exynos850_mem_map[] = {
 	{
+		/* iRAM */
+		.virt = 0x02000000UL,
+		.phys = 0x02000000UL,
+		.size = SZ_2M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
 		/* Peripheral block */
 		.virt = 0x10000000UL,
 		.phys = 0x10000000UL,
-- 
2.39.2

