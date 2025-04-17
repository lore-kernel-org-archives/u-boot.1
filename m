Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCBDC369C2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 12:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BBFD8301F;
	Thu, 17 Apr 2025 14:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="yRxNp0SH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CEE083010; Thu, 17 Apr 2025 11:10:08 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 976F182FC7
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso5018565e9.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1744881005; x=1745485805;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MpUuWHWMMuLj5gaki97tIwkKW9zRzhfR2MXriHH+9tw=;
 b=yRxNp0SHUz+EZazPSbq8Z7kTJD9MjHXdzR2YTSxSyNvPv34bLDe+rVNw3Z/4XjbY+d
 awWkDTPt4tvQRBHTNt2+JmJbnD2IpZGXHS2sDhBmFHNTNRvd6cBp9q2Cda2ZK1AQQ5tF
 Eigz6Pk21o/wKtc6avJxL4gh55rAC2j+H3zesjp1LEKVNjoc84w9oTLzzcByzMAsCJri
 8PqRTtH0/oi3y6cH4TIucWtGenbdsBVoFwjies6+QoGAu+gMxe+UptofDFwq50fXLy7b
 kHxAVw59ujk1DUaTyDIzXlgi1LZhxI1BZgFIn+4F1E/ZZnGMwBWWeaDepprLk+Y24rcX
 zCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744881005; x=1745485805;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MpUuWHWMMuLj5gaki97tIwkKW9zRzhfR2MXriHH+9tw=;
 b=TxC93aFa2kmlcXfFrsP9iRXlGn7r1ShMCPdqSOr2oA9BJEtVzWKx7XSYzAc8vzqfKe
 eKrD7djSH1Qa8Q9z4r3ri2X1Nmez/OWhLgji2iyTI0OikqV5T2mB2Zp35BZgrdO+4bVA
 32rsya6sJ7n6JTNcYqUmHiZuOBOtBS83j0t1I6Mj6sr2/Wk4FhNRY5cBLsFDXumT7DLe
 I98NuJuQPxXpOowH2/vACgOE8t+h6rDVsLfpZbEU/Yf+HoGla0paR8u3qOxLizqaIK+W
 Y2HrYOlqzAMJWjEf/fcWHzn1arZL2m/3f+5nhU3/tSAiqPMGXzDGSk3m7jxG4nFK3ECQ
 xPNA==
X-Gm-Message-State: AOJu0YwfeqhxQiHULheCuzVvu8L5kNUP0EuYSVxG1VtIiB/tGN18Bmo+
 yyb4ilZ6FNl6/C2FTN2FBUR69KVP/DxNh2NdOYXQVM+3I3eb3/owLULaEMA2aLVPqjUSPaJ1WN3
 h
X-Gm-Gg: ASbGnct44/37Yy8vx+1iF5ba1T0xIa9xMslPGw1sfT1maeGNUohR3CkDeeupKT7Nzfr
 WqL3Qsxzk9/d4al17zDQSDsnyL0n8xXncNZ5nEA78NP86IMsBawD+Dkx46s7qEOxhUMS7R/6gwq
 qWVLg66BhGb/9P01pd1M061mbZYRAP2z1c8itPCppAtcLITvvzCKGzhC1X+Tf1mFAIFktBTE3ly
 qebKV1Fk/NUwivoATvmTcxhuiVhydZZNW14kk128w54T+pZyE4xZcC/FVWb+/tq963VRpEq+Ps1
 zSVo4yuY1W9zPL+IzUGIURh+DmUugbbFi0XR4Iw=
X-Google-Smtp-Source: AGHT+IHcjZlA7D4fvdHdpNropsgobd6K9IhQg5veN3RKIcUXwGg2Ywl6OAQPOtoYHxgiz6qA2FyizA==
X-Received: by 2002:a05:600c:a30a:b0:43c:f3e4:d6f7 with SMTP id
 5b1f17b1804b1-4406801fbf2mr2007225e9.31.1744881004753; 
 Thu, 17 Apr 2025 02:10:04 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4405b58cc0csm46028945e9.32.2025.04.17.02.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 02:10:04 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 17 Apr 2025 11:09:48 +0200
Subject: [PATCH v2 1/8] arm: at91: remove at91_wdt struct in spl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-wdt-v2-1-49939de473e1@hifiphile.com>
References: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
In-Reply-To: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 17 Apr 2025 14:34:54 +0200
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

at91_wdt struct is only used by spl, remove this reference to
allow at91_wdt_t removal.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/mach-at91/spl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/spl.c b/arch/arm/mach-at91/spl.c
index 5feb8f735511a45dd37ee04bb3742f57d8f2e067..a814973242a723c47af210bd76db9210db061063 100644
--- a/arch/arm/mach-at91/spl.c
+++ b/arch/arm/mach-at91/spl.c
@@ -14,9 +14,7 @@
 #if !defined(CONFIG_WDT_AT91)
 void at91_disable_wdt(void)
 {
-	struct at91_wdt *wdt = (struct at91_wdt *)ATMEL_BASE_WDT;
-
-	writel(AT91_WDT_MR_WDDIS, &wdt->mr);
+	writel(AT91_WDT_MR_WDDIS, ATMEL_BASE_WDT + AT91_WDT_MR);
 }
 #endif
 

-- 
2.49.0

