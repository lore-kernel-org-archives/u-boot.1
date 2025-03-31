Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B67C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 19:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36CDE81DE3;
	Mon, 31 Mar 2025 21:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="InWciQ3+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A04681F28; Mon, 31 Mar 2025 21:16:32 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D39AC81DE3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 21:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so54086195e9.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 12:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1743448589; x=1744053389;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYdmyjvEoP409Ka5ZfFmp8qOVZEt1icFgIJBvVS70rE=;
 b=InWciQ3+37OexT0F8R8Nl/ADP2q5nZVzqcM/xkcFmBeLgDuSe8jS7PfsB4sSmC2UhN
 jVH2ag5lZe3eeJphuxeV/jHMLJtOJnORuLYx1dyiGPGkGyou1x4/3z6FPPQSEB2hZlXe
 +KYPDf0HKim5eZVQCFSJiqD/uCJdE0b+tUBo1Riv//xgirg4LQQ/36gPuOfSWZdhJKTf
 /Rn2hGcQ4cbEpkPMfAVqzUzpc3WEtFP0KKh55uiSEsHTaLhxfCLJfGEgbAKb0R7l+kPb
 SgyfAfKviRqSsYTDK1NbxMovUkLlQIJMsOBRxZZxI3tY9SIGXe2DNlT5exrkDMk1+s4K
 Eghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743448589; x=1744053389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CYdmyjvEoP409Ka5ZfFmp8qOVZEt1icFgIJBvVS70rE=;
 b=qGpgKkxgHX6W+ZIsjxJ3bIRvC3wdkb7bntCrfmxAcGBd7d325iwkcNjFkIngVZWv9/
 abWWedKzFkFHk6nc2fGMUFYKppwLd5bE2CwNt/N8F/AhwX9KfVXkR7bcmQv13M+vmWPR
 QzmOmfoeKq36DfMMcAtJORgONPD4fkKzZCZl6T9WTuk5mRYpA5NYjNf5Jd+NOzakdWoY
 uyNhiNzC02SYIZLdLg4kgJ/ztHov7Gvw1eq9RmooLsTuiYl+IfhJG2EgWjLXZjMxAdGu
 tKzblBANO5rWiVXwmDOleJr13m5sy3AGVj6Ju9mtFS16XtpBIAvTopFBfRggqOXruLNl
 Gyng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiBzwnHQ3rpWjlbcuhFxir+eQxNQO6L/ALL61IP01lA/b6vqo8/2twbFFvGd0CW4exUxiBD64=@lists.denx.de
X-Gm-Message-State: AOJu0YxUPHwxx30l23VB6WehZgM1J+hz+8BakDDjUtLtyv7N8gFAYj00
 mStDKy+Ozi5A6EZgaI+XFVyjAdl5yH1VFjkz9KobLkmVplv0cdmFeUxtI9tZ70I=
X-Gm-Gg: ASbGncuOhRMLJr9Ev8mnX8g2OP6t53ULdCmi6pObvZJ5f5VHTIvmfhmCIrLlyPxqWNe
 V2xIrL85gq73LEJpl/p5RgXh3m5OnubWzeX0Ne14sRBqX2KK9iaLKclXzwdWkjNlnwnAOtBkFsF
 2sWZTFRMoEbl8YWyVce2Vkscg1t0gB56/AF7L1lACicIGeo1ZMrzpX3QtxFsO0/qSgCGnCftQls
 u96k7W4J/Uzjkho+0i130Ao455C1WtOLPisvn38fGU00yIygnCDAen+w2pabukR9gYn1pvXw5CB
 tOKizAcXZVNtDgBdU5arbM5ixYC11C7rSWip3IvwDeA23HYFzUvD+QhG
X-Google-Smtp-Source: AGHT+IGsYzs8Dj60biT/aSvTrwtRkpkHe03AHOwT6WdPhOBtI1DML19M/BrMUiFMSOCVGA4f+OfG9Q==
X-Received: by 2002:a05:600c:3c93:b0:43c:fdbe:43be with SMTP id
 5b1f17b1804b1-43db62bf0f2mr87718485e9.27.1743448589184; 
 Mon, 31 Mar 2025 12:16:29 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d82dede98sm173144165e9.6.2025.03.31.12.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 12:16:28 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>,
	Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH 1/7] arm: at91: wdt: Remove unused at91_wdt struct
Date: Mon, 31 Mar 2025 21:15:10 +0200
Message-ID: <20250331191520.1805001-2-admin@hifiphile.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331191520.1805001-1-admin@hifiphile.com>
References: <20250331191520.1805001-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Mar 2025 21:19:48 +0200
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

at91_wdt struct is not used by anyone, let's remove it.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/mach-at91/include/mach/at91_wdt.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
index 8ef8e007d77..78ad0453fd9 100644
--- a/arch/arm/mach-at91/include/mach/at91_wdt.h
+++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
@@ -19,12 +19,6 @@
 
 #else
 
-typedef struct at91_wdt {
-	u32	cr;
-	u32	mr;
-	u32	sr;
-} at91_wdt_t;
-
 struct at91_wdt_priv {
 	void __iomem *regs;
 	u32 regval;
-- 
2.49.0

