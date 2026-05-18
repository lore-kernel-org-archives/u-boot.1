Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F26BCD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 21:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEC9E846B4;
	Mon, 18 May 2026 23:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qkg1wnAt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A1A5846B5; Mon, 18 May 2026 23:55:07 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90FAD846B4
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 23:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shofiqtest@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-39397d63804so37313611fa.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 14:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779141302; x=1779746102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bS8zWtoDL5dnhTuKcBNA9HWAw1ABWgJXSd56RFnyukE=;
 b=Qkg1wnAtqRDLtozV5q+xB6MfrNTGWTZT+1O7yVn8GAlEAWByq4vcm1afsegMRHtD83
 3VP6uOQOXIUC+81ZZIZVBkEbWeJUPuDtCKIuJQ3om0imru47kT822nwbhvNP7C2cVxqa
 /PYpxr83EW2V2k4OhV/hHfJUnEMba5Ss3ioEeUQcOARI9E4eLeocZz4EDlqOqbal/xEQ
 fe3vqbIlXY/JGQa0LxwH2hnTrZ04HXkai76xyOqiLeGKxhPF4nFWwko69ht7qCqT7frA
 VygTYdCSiqLL9J1KfY3h6vMdbuuFO95eAlJMBuzEZFNYAFHypb24o4Nu07ku+k9SE/+7
 tbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779141302; x=1779746102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bS8zWtoDL5dnhTuKcBNA9HWAw1ABWgJXSd56RFnyukE=;
 b=k2IaKBSEtEx/d5Fcu3AzesKW6XJdhs2cypqbUa9QgNFCPQwaiEoQrLWnS8miLOntzm
 0EPJ7hZIIuDbEPir53B+xRVeuorSXQHmJjn8huQlOlx7eIAxA6gI+RgdIgBpKmW21foj
 iDFjwAL1P8EC84ms9f7e0iLYpDvwLl4tLwec9JzC2bHh1RPZk03teGFg7AUJ7D1Pg2Kk
 PwK6mrFsS00wTCMD0zDlAZBy3EwS5cQsq9e7/l90hZ0QS+YD+Q2N8onPMG2Jirp/WIE9
 YkjTG6aZBjGLLKZ6bEAYr8J/7puXAlV9qF9rXbQQmarikJj8vQvEznHF0Sb0BEa2PA0S
 1L/Q==
X-Gm-Message-State: AOJu0YwftsHuQbfAqvY70gxIepuCVlDw5ebKq2luZH/zgJ9Sv9d0juOA
 JNcFKoLW7b5qXh6OTLHDob1co0f6a0MjTPAqyJ6SyrWWpvsqBMgwDEoW
X-Gm-Gg: Acq92OH6tlJq2EXFix0E14AF7N/E/TzcXyTl4g7rg/hO8xxHD70i4O76djYJMHivmTR
 /cF69EA6EST6zvEs1VOEZn2XGCOCgPLdRW7KXPFQ9VyOKqGl90uhW0VLrtC79GoT8Vi0gfV/fyv
 SPW4tPN/YhuDo73doWFtZKVhEjU7+KAoAZmm9TUiTdSaQ1VmuQO5IDVRaZdgKN+FjnP9dQ7Slgg
 e2GmeOummFFAMvIOn5rZ09wg9/DeknMLYE7cxMesHPxzdxJX8MyKzTmlzcw7MJHH7DGyd/zTBdV
 y3LF2mC5p6gABu4E61YYHS9uTDrIYP1PDvw0eThrp+yMU1k6tGn08/FP0o0PIyeeDgeJjCc8fdz
 sLtE4eG3KQqMTZpVVNXhZKU9jhDzhUamDujJ5I80HPEP/kz+viNUJbehLEVpZb4Q7Q2ErjW7shN
 jnIr0GcTO4UWmKUdTz+UFtBDXFsrKVFaPDIiBE4vOvdhmNzCQqDsPafMSi
X-Received: by 2002:a05:651c:12c1:b0:38e:2fcc:78ed with SMTP id
 38308e7fff4ca-395619baddcmr51573411fa.0.1779141302198; 
 Mon, 18 May 2026 14:55:02 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395882c3928sm15158541fa.11.2026.05.18.14.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:55:00 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: brian.ruley@gehealthcare.com
Cc: u-boot@lists.denx.de,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH 1/2] imx6: clock: fix clk0/clk1 swap in
 select_ldb_di_clock_source()
Date: Tue, 19 May 2026 00:54:44 +0300
Message-ID: <20260518215445.175753-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260518215445.175753-1-shofiqtest@gmail.com>
References: <20260518205734.163815-1-shofiqtest@gmail.com>
 <20260518215445.175753-1-shofiqtest@gmail.com>
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

clk0 was being written to LDB_DI1_CLK_SEL and clk1 to LDB_DI0_CLK_SEL.
The arguments were silently effective before because all callers passed
the same value for both, but the mapping was reversed.

Fixes: bd3e19dbd90 ("imx6: clock: allow different clock sources for ldb")
Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 arch/arm/mach-imx/mx6/clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mx6/clock.c b/arch/arm/mach-imx/mx6/clock.c
index 828a101ba05..646d1fff6d7 100644
--- a/arch/arm/mach-imx/mx6/clock.c
+++ b/arch/arm/mach-imx/mx6/clock.c
@@ -1525,8 +1525,8 @@ void select_ldb_di_clock_source(enum ldb_di_clock clk0, enum ldb_di_clock clk1)
 	reg = readl(&mxc_ccm->cs2cdr);
 	reg &= ~(MXC_CCM_CS2CDR_LDB_DI1_CLK_SEL_MASK
 	      | MXC_CCM_CS2CDR_LDB_DI0_CLK_SEL_MASK);
-	reg |= ((clk0 << MXC_CCM_CS2CDR_LDB_DI1_CLK_SEL_OFFSET)
-	      | (clk1 << MXC_CCM_CS2CDR_LDB_DI0_CLK_SEL_OFFSET));
+	reg |= ((clk1 << MXC_CCM_CS2CDR_LDB_DI1_CLK_SEL_OFFSET)
+	      | (clk0 << MXC_CCM_CS2CDR_LDB_DI0_CLK_SEL_OFFSET));
 	writel(reg, &mxc_ccm->cs2cdr);
 
 	/* Unbypass pll3_sw_clk */
-- 
2.51.1

