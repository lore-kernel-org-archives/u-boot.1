Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F817CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 13:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDCE183BAD;
	Thu,  6 Nov 2025 14:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="vN/yD9I8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A532A83B5F; Thu,  6 Nov 2025 12:12:41 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C055A83B72
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 12:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47754547a38so6546835e9.2
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 03:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1762427559; x=1763032359;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xhePCpc3NHSADsMsxqSNVQRf9XYSN9Jzb0N/PZTzy4Q=;
 b=vN/yD9I8BQI2uSNh78wQxfv+2ggknnlD7Ks14B4UC+b9MEt/8PUc+XLum+93ZXD1Vm
 aoEvN6IG78koB9/WjdI//JeluXQxlT0gHMVFxyyk+Lm0D+kiDXurpHvEjGmxA6rGl4kt
 xW01KDXLFA31cfcSs1I85dF5XBNem3EeNmCfDQ0T3W9W4JcgkgPmE5HTMPtBTTMQAZo5
 UqatZGllzRXt1t6ve120l8GgwAeFOCvntZScyawIBK9IdljzqmT8rutU0xueJ7JWk33s
 NimJNI98c11fJxM77ufGl4GtV5w/LG2xXIvbnslWW71jRgvgucyOjNilcTIdqBFNd+S4
 ui4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762427559; x=1763032359;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xhePCpc3NHSADsMsxqSNVQRf9XYSN9Jzb0N/PZTzy4Q=;
 b=FV7kTpIgHQeolJVb5gV/bKv0rg/+wWKiHq6U+D2NPpTg40/MLHVRey+fXX9csK50d9
 Fl9jly+wu1tb28gZ0O77pX2F/D4Kth07+kTppdMlbupg/KK8zf1lZgRi/Lr2e6MORkWd
 5BQSUVGWPtrjrBQl7i7tCkQ1PidMnzvYLznku0okagU2n1f+SQuuOERF4RV1V21hHYSW
 Sjelx6IUlghRwtg3xeaW9mMYgt41ETrMN0AwqNkTLzEiBc1v7cOXpbahnWdatcZmm55i
 JvqAXTGy6x727t3LdXLigxxfh5/rHDna1n4d6Slr2nt5pLdT9TIWJpNetFvBPH7LKJZ9
 XyXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/Q4pwjf2QCEkV9oh/a0J43gQhE3YlhcusCgcPxnlRlELHf+OgyXT/1LPZixzDu1iTNRZLJH8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1qEjnSIhejH5HA79noiieK04ZMMtOr6j+5QgNEJlkoWvaRSbv
 HyFuWAZvtfHfBVXqXGzeC47n60JFWn/Iv94zXh9YOCN1tbkwK5HmdAhvWMEqWxH5MbXK2em1TbI
 VHDxN
X-Gm-Gg: ASbGnctRDvr3O3n7UuotDVLpBP505sfaMf+nrYPLXJHofg1nQPGaLG/SE8YdVbxZ6X3
 j2ZgL5cLQRJ+17LK/Mz8Xqtkk0IJwbcLRG3FXxd7LgT0NFqIDmZatvsa4GlLiFZjTVQagZcQxDn
 BIAFbeGvoaJc3Lt1Vlx1YNjqBSVNEyg7X8TcVOSn92nEGJMJlpB4Tib5+Xl7jKcC8DKkqUXUlbq
 7xxn5tf3jg8jNOP7M7IIIWqgr6vGGVXaYvBvTmJqKg6Cc3ft28prtJP2b5XU3waskr+Sxn8LyEc
 5Cw1J+tZRFOXjlVvsRE1AZ128+WdNk5vLp8QYnSuUUrqHVaMViRWLTDMeiRYcYfYYDAeBOJxgzQ
 9rFE0ipiUTsF44U7AaLYhy1HIu4CRAI7WEmxj3mPNM4ZEDqmgD/zjYCy3C/a5eqm8iGf9oNkOcF
 w=
X-Google-Smtp-Source: AGHT+IGrWiJBhXzmk+ctZH+WJAPKXHe8I6yd/OG88kwUSIkh9cGQjS59vf8lI72mijQJrD6Q7FSj5w==
X-Received: by 2002:a05:600c:5291:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-4775cdf76d3mr64866125e9.19.1762427558498; 
 Thu, 06 Nov 2025 03:12:38 -0800 (PST)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-429eb3951c6sm4582966f8f.0.2025.11.06.03.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 03:12:38 -0800 (PST)
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 06 Nov 2025 12:12:01 +0100
Subject: [PATCH 1/2] mtd: rawnand: atmel: set pmecc data setup time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-pmecc-v1-1-a1f3cf430be9@hifiphile.com>
References: <20251106-pmecc-v1-0-a1f3cf430be9@hifiphile.com>
In-Reply-To: <20251106-pmecc-v1-0-a1f3cf430be9@hifiphile.com>
To: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>, 
 Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 06 Nov 2025 14:09:21 +0100
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

Setup the pmecc data setup time as 3 clock cycles for 133MHz as
recommended by the datasheet.

Backported from Linux: f552a7c7 ("mtd: rawnand: atmel: set pmecc data
setup time")

Fixes: a490e1b7c017c ("nand: atmel: Add pmecc driver")

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/mtd/nand/raw/atmel/pmecc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index e500a0fe3f8671ff08195c94c3383696a7731eb3..7c4e9bd5f9967b119239adf2b39e683ea62b71fd 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -142,6 +142,7 @@ struct atmel_pmecc_caps {
 	int nstrengths;
 	int el_offset;
 	bool correct_erased_chunks;
+	bool clk_ctrl;
 };
 
 struct atmel_pmecc_user_conf_cache {
@@ -840,6 +841,10 @@ atmel_pmecc_create(struct udevice *dev,
 
 	pmecc->regs.timing = 0;
 
+	/* pmecc data setup time */
+	if (caps->clk_ctrl)
+		writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
+
 	/* Disable all interrupts before registering the PMECC handler. */
 	writel(0xffffffff, pmecc->regs.base + ATMEL_PMECC_IDR);
 	atmel_pmecc_reset(pmecc);
@@ -884,6 +889,7 @@ static struct atmel_pmecc_caps at91sam9g45_caps = {
 	.strengths = atmel_pmecc_strengths,
 	.nstrengths = 5,
 	.el_offset = 0x8c,
+	.clk_ctrl = true,
 };
 
 static struct atmel_pmecc_caps sama5d4_caps = {

-- 
2.51.0

