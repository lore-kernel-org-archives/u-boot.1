Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FFACCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 13:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0836983BBE;
	Thu,  6 Nov 2025 14:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="zyrxPPKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B5583B5F; Thu,  6 Nov 2025 12:12:43 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C90BF83B82
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 12:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so490026f8f.3
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 03:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1762427560; x=1763032360;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DbZi0DI21xZNXewkcj61ftotkhHEoPwJKqviIM5mbos=;
 b=zyrxPPKYvkMDS5qvxqZ/TTHmd1l6nfo7wqfV3Stul0i9yVwUPQLai1NExYY0Ba12f3
 WH6q03ikAqNu7vsN7sh9X/+/o81BhjeO5woO9L4ao2tlrDN+VHorlynrI9ixCK+vMpGI
 gKuyTtaoOjXvfI5ieZxycTCOf+7rHixMmfConzTww1Br2CyNsvzBE6jO2b8JW0M/uP4W
 gHaMAZOJfkxChz+bshZi+mUp3q+yQ4GAgCAYhiueoW3FMnAv9kczZFifRJ0ZyiMzGQ2x
 mgOHfjVYFepzHp6hr9X9KkLgGIWTlmxECeAVuWPi+AptWCqvbHtdSM1mXDHqLfR3jnn2
 XEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762427560; x=1763032360;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DbZi0DI21xZNXewkcj61ftotkhHEoPwJKqviIM5mbos=;
 b=w1Uwntj1/EoUiHg7U408uRmRR2eDbEYBAcADcEtKgkDH9sRFvCK1pY7GRqK8KNOqQ0
 KE3FVFL4DeQC8ukFYUrbjd3afmDph/Z6nKb7CQj7XMZ2bNcjS4ZFDnkH0/L2+Yx2V4ap
 3KrM5FEF29l24VSuXpocvhx6A0dpRiWjHPMq1dQpqDFLcdm2Z+F1l0tihlAenyu9M6n/
 jKnHKpnMoJC2v/watc1c2xEVBQiTcIY8qHFEbHkAHXnyM0ydSC7XV1Y8ZQvHdTlwmXO4
 wOvs5NdrYs3lLXQYZvlxOiVMPnCqIZ829Z4WjpSxBA7y7SHg+T69nWoSpnB7/TqQRT7i
 AuCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4X3BPXeNOqiSqiLyjke4eT0H7f+yP+9kA5qN8cNNDc/3Ttd8lh+zRrmOBp69RHCC9aK1FoFQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzDCwxM35X+AkY3cBrv7kFOEav1eSJn95hNfQ4jVhKgXq2zXZFO
 Rv7BQOFsdkLBUqNL7dyMGbEtTQbho2T9FhFj9OYdrW7Z2E6GjCGohKcUMkGJcyUsufB8SjXFms0
 2w1vs
X-Gm-Gg: ASbGnctSVcuEPYgsmLWBLvJQmRicriPPathDs9lmR5Rwfjg/RBpui6eaQKjlht13lU+
 HTanqWrtRja+PEmn+3obar5yMNZpzBFlQ12Cwy4o4ozPrYWREg5AA5eADhZP+Nu2t2jkznIK8Mq
 /3hcXvV/ZskXeaF2byd2zjQ9Lz+j8M9o0Pqf9IvdS8i9M68LjzLtnJ6dOnOfLllSPTgBksV0aJQ
 l3wWC6HLkJCLNR3Im25YTZ48z+lsrN1U7vFIgpsH1sigCOrCGreNYGDkSYWtaYp+vME4CwZ3/NT
 GUH4b9N54PvfDUCOITW/GgTuZ11Vk6dkHDZz+QYwBwvOkAV6+T+1A4BjWeE9rF6cRssDkZbramz
 XxxLesiJrJyQ4Df5eBTsZl5vcKOFye1ElonxJmvhY7maIFGcoGRYWADBYrTpjwPOxWGdKZ57pyy
 I=
X-Google-Smtp-Source: AGHT+IFPquUhoKMYcpG2jQlz0AaW7XMPwwgqRLWycXHByS59iw8C+VDo9w1JG/UGzFfWVSxMA5eAAQ==
X-Received: by 2002:a05:6000:4103:b0:429:c16f:2376 with SMTP id
 ffacd0b85a97d-429e3311c25mr5069373f8f.63.1762427559856; 
 Thu, 06 Nov 2025 03:12:39 -0800 (PST)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-429eb3951c6sm4582966f8f.0.2025.11.06.03.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 03:12:38 -0800 (PST)
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 06 Nov 2025 12:12:02 +0100
Subject: [PATCH 2/2] mtd: rawnand: atmel: Remove timing from atmel_pmecc struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-pmecc-v1-2-a1f3cf430be9@hifiphile.com>
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

"timing" is unused in atmel_pmecc struct, also it's not exist in Linux
driver, let's remove it.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/mtd/nand/raw/atmel/pmecc.c | 2 --
 drivers/mtd/nand/raw/atmel/pmecc.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index 7c4e9bd5f9967b119239adf2b39e683ea62b71fd..8fc5614cc0091d3e0f4b9280beee9e684fe2a57d 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -839,8 +839,6 @@ atmel_pmecc_create(struct udevice *dev,
 	ofnode_read_resource(dev->node_, 1, &res);
 	pmecc->regs.errloc = (void *)res.start;
 
-	pmecc->regs.timing = 0;
-
 	/* pmecc data setup time */
 	if (caps->clk_ctrl)
 		writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
diff --git a/drivers/mtd/nand/raw/atmel/pmecc.h b/drivers/mtd/nand/raw/atmel/pmecc.h
index 43f96b2f168c7b88e0c907996f2ae64f8554ed58..88b0d18040e7c48f226c74ce9b5caf93b5760360 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.h
+++ b/drivers/mtd/nand/raw/atmel/pmecc.h
@@ -65,7 +65,6 @@ struct atmel_pmecc {
 	struct {
 		void __iomem *base;
 		void __iomem *errloc;
-		void __iomem *timing;
 	} regs;
 
 	/* Mutex used for pmecc enable/disable */

-- 
2.51.0

