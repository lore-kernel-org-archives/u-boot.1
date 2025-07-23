Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD05C83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 16:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80D9E83559;
	Wed, 23 Jul 2025 18:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R8MwxGLa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B5383577; Wed, 23 Jul 2025 18:04:45 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 558AD833D0
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 18:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4550709f2c1so53557025e9.3
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753286683; x=1753891483; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4JaC2rByjiSqr2nsMFIJz0z9WpFlyWYbTMT6kx1WLk=;
 b=R8MwxGLaJ1AvSN6JHIpmImyMJxOFJgIVqj59+YqJGg1AJ6aK3TxKpywpzgIFNL56xy
 MVOuGTWTU9WSo7tbX9HzeWr80TE4zgIqBXli5WQkjulRNxy4FnBcupM3rEmkjoa3Ixzk
 pwz8gW0OwvCXIjfsfMHleV0dju3GtC17HNszMNZ+KGBdGUKsWrJkSt3cEB5K91dNVKab
 hBM+4tWlugxgD0LD68x+fiIPT8aKv1cGxnAEkS0QTQm/J4EKopploUyd9OF/V7Om6980
 56KKqUo4bBasFzs+VulsVrGzbVDIKyXSdILcI6z3kV9eCNdT2m2ptlPL1hrDaXEoux4I
 NIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286683; x=1753891483;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y4JaC2rByjiSqr2nsMFIJz0z9WpFlyWYbTMT6kx1WLk=;
 b=Uk5Z+MEggy2AXYP+TE5cc086WZ/kRDdiSHLAZpktA5GywFEdVdNEi+C04MQnqKrUec
 si6BB1aTwTMDQJwebFXOsjK6O1hz5G/8AcpjC3kpT16h2WJkgPnz1divJFkrLbZt0H0y
 1n4PpJN4FT1m7tqXnXveOCa8tOin1vwh3rHxuZJXz+Vh+PqJxvCFPGH8zYTga45kadfV
 REAo6bKQnSuQo+BQWh5G1Oo71vdE0IUQZMNCfcqko2xVFOy1X+nVVHi4515F0Jmzu3mK
 JNMwOW3x8cBaeM8Zr1UdjwX2cOwdWoJvB9ebFVrKbOH47f5RaBDG7+GqLmm/usBWslOK
 dekw==
X-Gm-Message-State: AOJu0YzKZZlj6duYuuzITMJ0dTWfLRC7CL4jX8we3yJ/5wjfMmAqD56K
 OPOtVFt4W5jwTDw8SRFEcNUKhlzz1pX+LlJ7/vp96/13Id/3KpB1bbsdPCgTbQ6ddkmhbDWEaz1
 eR1dS
X-Gm-Gg: ASbGncubD+UdKjVVS3Q5oOp1VGKHLgaf4VXm0UznBsBaT2RZ0A2HYrkwNEJhQ84Dc5A
 KtWEqtq4TDopsH8QHbmNGwcmXA0TEXVebTL0dEEGF+iGm9FrS1ZnNBUJvLbIPV/VtYdfZoNO2Yx
 6HElrbuHze8iHEDFvm3b7Yogghtivy60KajOY/QhifqATGnz0rbPkRZMcdLgI+B9GD4t2XU2au3
 t1FThlNgh8Sv7D+TZIciWGmIWzdl2sDf2Go0yjbeB9utiV5mkvLnl2FwLBuwnveX5otVVbqDY4b
 HrQ156pI9J2LjYVCPlFNvFLUyAftwRsq6o/q2dF4HmqKUvg0IJqj9pyUcah0h/9LKfQ0Yb/c3Gl
 ex6pGAlJFgfMXaoItwtcRwd3AppmcuMqHTXUC6dQNJSUnxntocGc=
X-Google-Smtp-Source: AGHT+IGnFRqibVkccBMC9QFHaw9eztava7o+1u8M7WzHn724Dw33gbrxmRVKh7duWWDnVDFsvr/1uw==
X-Received: by 2002:a05:600c:45c3:b0:43d:b3:fb1 with SMTP id
 5b1f17b1804b1-45868d69d8emr32520205e9.27.1753286682389; 
 Wed, 23 Jul 2025 09:04:42 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cdd8:a59a:1949:12ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458693e20absm27919515e9.24.2025.07.23.09.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 09:04:41 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 23 Jul 2025 17:04:41 +0100
Subject: [PATCH] clk: exynos: Fix always true test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-clk_exynos-v1-1-fcedf6be444b@linaro.org>
X-B4-Tracking: v=1; b=H4sIABgIgWgC/x2N0QqDMAwAf0XyvEKtVMVfkTHSLmrYrJIMcYj/v
 rrH4zjuACVhUuiKA4Q2Vl5ShvJWQJwwjWT4mRmcdd42rjLx/XrQ/k2LmtBirJvaD760kIOASiY
 IpjhdyYz6IbnEKjTw/r/09/P8AVWX4K51AAAA
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In exynos7420_peric1_get_rate the variable ret is declared as an
'unsigned int' but is then used to receive the return value of
clk_get_by_index which returns an int. The value of ret is then tested
for being less than 0 which will always fail for an unsigned variable.
Fix this by declaring ret as an 'int' so that the test for the error
condition is valid.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/exynos/clk-exynos7420.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/exynos/clk-exynos7420.c b/drivers/clk/exynos/clk-exynos7420.c
index 3aa751bf4e4..7de4e688f03 100644
--- a/drivers/clk/exynos/clk-exynos7420.c
+++ b/drivers/clk/exynos/clk-exynos7420.c
@@ -192,7 +192,7 @@ static int exynos7420_clk_top0_probe(struct udevice *dev)
 static ulong exynos7420_peric1_get_rate(struct clk *clk)
 {
 	struct clk in_clk;
-	unsigned int ret;
+	int ret;
 	unsigned long freq = 0;
 
 	switch (clk->id) {

---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250723-clk_exynos-b8ac6765f510

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

