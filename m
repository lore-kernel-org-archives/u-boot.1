Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C80EC36014
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 14:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED28829F5;
	Fri,  4 Apr 2025 16:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jSY7bjjz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4A7682A36; Fri,  4 Apr 2025 16:49:41 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FA5F82A0A
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 16:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224100e9a5cso23047645ad.2
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743778176; x=1744382976; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoZuUW7pGdED/Xf41pBvl49pBkONiGJCDiSSyPmF5oM=;
 b=jSY7bjjzOQ10eCNsoQ+gy9akM2VBanIi5B3DYzVkXlbQUW5SAIHMlMeT8NwB00IUrF
 zoLNZilSIP2ykf/wIR5IfrNsSjpXhQ7m0aphad2CpqjNMvM0pAhMeuBCHcnKWJXVZSrK
 QKcrve5EoOkOoiKT7p3Dx3/4SoyI0xHXlu/S0+GpyMrXAzaSi003DXExj/Py4PYP4du7
 xI3aWzQ5gamwvv3nBPiUOQozIN2/FG/A4BmxYBgdg3a5E65WTI7J8d73o6jqZ1iM7Jqd
 t1Xz6NVLiZ0t5YH7xxDp1Gy/r75o0dzyIiQkhza8g4LfuXh7Z9EkmozpjFmNq21+oJGI
 l5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743778176; x=1744382976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eoZuUW7pGdED/Xf41pBvl49pBkONiGJCDiSSyPmF5oM=;
 b=Z0HTtqu0ivOOrKrLeSP2EfcDt2TqDivWLAIFtyIbiRjobOd8nytspnIArPvlpNBklq
 TSJSikh4fteG3NzR2tf66OwJfZyi0402rSDFFMGLeCMte0e6vxJsIj1oTmPpJCA0COky
 utBVNiYaL8vwvvsiktxOi8C4R1e0uZneuDws2Gz6iOH16fji7Yl77KgvzXk6xFLO2nSG
 qmrRsWbnn/PWSLlpo8oPdva9TUi9Uz7ricAqkKSYC1k7NjaONPwyfcIawsWsTTCWlOlc
 gRksqKbXGnP1GWwNvS7UGd3+Zx/4YjvB7/lGws0ibMm5bG1lGa6AJZJAgVQShAMkBg05
 hy5w==
X-Gm-Message-State: AOJu0Yxtrw5H5tOUFP486+DvXRXfEWSszWzn9CVDHCDAyF4K0jAah/BE
 5GMs2hASNIk5+IeWWSFjPG4krdwiGkVlTtjmYLP2uliAchkBDtbD4qqu5CRHulyWM0qHbpSwdE1
 h
X-Gm-Gg: ASbGncsZe33+hZgkzcRHodPh08FyFx9uUOhu+ydt7ApiOD7T86NocfKW/DNZzyFNjzn
 6O9rCUkOdFkGBQS0BJ8cWXqGQNZsuNX8N6wihBc2A/YSLj+A/6UT2gSCh1YjyqOYMQXAFLVv+8A
 FLAq0Q4yII25+O4ccBdH4hOYNSumCxmjhwaxp6bXKIXl8aw46efakKl5ZS0jgulxvNILoPgg+iB
 +LMB4fA7YAe7FuFebhiOjshr0cDMeDTu1pzDGiLyACUJ2x0RpDu88RRepzEEvEWXka/fRIR3RTn
 ufivI9R2+4T2s3bxokfsf8ClV1C7M0Jp5sdaNlFFr6ro1dJbK4Dh/ZrDBTrndAegyl6ywCBqjpY
 L
X-Google-Smtp-Source: AGHT+IFXAyljRCd3ZtWR4OfVDlbtbM0FjNFTXbDdsba5J2fzcchLTZ57oLG7pN8hVJ+9g4NZAzAARg==
X-Received: by 2002:a17:903:3bc6:b0:224:1eab:97b5 with SMTP id
 d9443c01a7336-22a8a858f8fmr43910175ad.1.1743778176520; 
 Fri, 04 Apr 2025 07:49:36 -0700 (PDT)
Received: from localhost.localdomain ([103.97.166.196])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2297866dccbsm32950705ad.176.2025.04.04.07.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 07:49:36 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Tom Rini <trini@konsulko.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 1/3] riscv: image: Add new image type for RV64
Date: Fri,  4 Apr 2025 14:48:55 +0000
Message-ID: <20250404144859.112313-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404144859.112313-1-mchitale@ventanamicro.com>
References: <20250404144859.112313-1-mchitale@ventanamicro.com>
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

Similar to ARM and X86, introduce a new image type which allows u-boot
to distinguish between images built for 32-bit vs 64-bit Risc-V CPUs.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Maxim Moskalets <maximmosk4@gmail.com>
---
 boot/image.c    | 3 ++-
 include/image.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/boot/image.c b/boot/image.c
index 139c5bd035a..45299a7dc33 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[] = {
 	{	IH_ARCH_ARC,		"arc",		"ARC",		},
 	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
 	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
-	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
+	{	IH_ARCH_RISCV,		"riscv",	"RISC-V 32 Bit",},
+	{	IH_ARCH_RISCV64,	"riscv64",	"RISC-V 64 Bit",},
 	{	-1,			"",		"",		},
 };
 
diff --git a/include/image.h b/include/image.h
index 07912606f33..411bfcd0877 100644
--- a/include/image.h
+++ b/include/image.h
@@ -138,7 +138,8 @@ enum {
 	IH_ARCH_ARC,			/* Synopsys DesignWare ARC */
 	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
 	IH_ARCH_XTENSA,			/* Xtensa	*/
-	IH_ARCH_RISCV,			/* RISC-V */
+	IH_ARCH_RISCV,			/* RISC-V 32 bit*/
+	IH_ARCH_RISCV64,		/* RISC-V 64 bit*/
 
 	IH_ARCH_COUNT,
 };
-- 
2.43.0

