Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91394FD3774
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20BBC83F00;
	Wed, 25 Feb 2026 17:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="g8S2/NGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E988283F00; Wed, 25 Feb 2026 17:53:58 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDBBB83D77
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-59e5aa4ca41so6558256e87.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1772038436; x=1772643236;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GkJhvi1974w4+hMGdr7GktoYxy4wpW/zeqmFApZg+vA=;
 b=g8S2/NGzEJPU/HIQso/9qGJVGEwz0MWa6Bni+w8TFSiEQ/BexjklDDIP/XkbIb5OX/
 Ha6FISACIKZOfBCKQ2Id3vlTb90Fm4A/LhkF/1MYIxLXggyH65se5MYNEuA2Gyt2NuRa
 gDd9DEoyZa27tuGBdPXzFwC6Y9Ea6ns+SFWGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772038436; x=1772643236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GkJhvi1974w4+hMGdr7GktoYxy4wpW/zeqmFApZg+vA=;
 b=IHn8JpBUfeWxWMJL+4+iH1eVia1RXu8Cu4ddBFrO0acM++G7KO+yXYS4xh7J9crt+Y
 lCcA+KM4+0TOgMKBibM+qo549Nwl3bxNKXuvFWXiH5qGAuCN/XGpBt5icaXm73UcSIEb
 p5+xXagPOinRWrxC9JENRqT/pmvfvcsn7O3jAGDqcCupjyS/hCxj0qalkz7j59VX8xqP
 EM1tv9PIulXZzWqqeClKSvzlRqXaepZ7f8WR2TFSZomdqu+tm152meSmurGNSRJFulM8
 DH5hUHlo67XaYGA7B2RpwdOOb98KpRe7aC89ys2c8KqwfyBGl0dkvt3j09huk4NbdIDT
 q7hA==
X-Gm-Message-State: AOJu0YxNswhoEDGQQyVM15S5fteC2uUs6XvQljkkhpT4OmPqT3C49ZPV
 KUothwl+Kpe+pVdDaQiA6nbmkwJzKQ1HrXMfZWaSArv13s+WGah43YR6PRcgufVspq+xgMyL4c/
 rapM1
X-Gm-Gg: ATEYQzyfS7Y31NeDsoJ9cXHN7p9iPm3pPz+mH8ljRE8wLtT3UTvXrNa+7s6AiEpu10s
 S5IF5puip43tjqPeojtGcADUSWXN0lMlo9aKJ2XRYry3xd5CU9X61yOrrvWt/tMI7ZhB7xPSFxu
 IKJfd3Tgl+aXCwDp6b5OVjgj23CpN+tV8HB/8h5sNwO5PsiJ9UdNV0V5/1x+ozmqmpT7L9kpDNz
 jWLkhxGgOmaX2AG4lvdpoBz7h44SiMYXVG8sK3d9aWylXblMyKPfMivA7fqID323oxcbaAKNdGS
 EP1ooQ7R+dh3jXYL3WXU51gqKnK//FsrxKCRBGrktxWmQltb2y3DBaKKlr3UeoYxogk2j3CBxTr
 JfY8MHvXIRW6CPrb7JScZeg0btn5meRvby4x1UkC+U21gbOo/yh2ZG1cCIY+4sZdH1knVM2TEaG
 0Zgv5KeqxGGLlz0RqQJptR3uVsfBzbdZjJCyNzrNnBX2KujPb8Iymq9xIi2IYCRgJFuv3QEKEo9
 HkTZUGtazqY1uhWdF4X79vnoxNYMpaerOP56vg7BO4BUeZhZqzDzlOrduo=
X-Received: by 2002:a05:600c:4f4b:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-483a95e1f34mr292230325e9.17.1772036345446; 
 Wed, 25 Feb 2026 08:19:05 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.43.111])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f19f5sm186562265e9.1.2026.02.25.08.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:19:05 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 6/9] spi: stm32: add stm32_spi_is_enabled() helper
Date: Wed, 25 Feb 2026 17:16:57 +0100
Message-ID: <20260225161851.2475274-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
References: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
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

Add a helper to check the SPE (SPI Enable) bit and replace the
open-coded bitwise check in stm32_spi_stopxfer() with this helper to
improve readability and consistency.

This is also a preparatory step for future driver updates that require
checking the SPI enable state across different code paths.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(Added in v3)

 drivers/spi/stm32_spi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/stm32_spi.c b/drivers/spi/stm32_spi.c
index adba97915cd3..70eb8735e03d 100644
--- a/drivers/spi/stm32_spi.c
+++ b/drivers/spi/stm32_spi.c
@@ -192,6 +192,11 @@ static void stm32_spi_read_rxfifo(struct udevice *bus)
 	log_debug("%d bytes left\n", priv->rx_len);
 }
 
+static bool stm32_spi_is_enabled(void __iomem *base)
+{
+	return !!(readl(base + STM32_SPI_CR1) & SPI_CR1_SPE);
+}
+
 static int stm32_spi_enable(void __iomem *base)
 {
 	log_debug("\n");
@@ -245,9 +250,7 @@ static void stm32_spi_stopxfer(struct udevice *dev)
 
 	dev_dbg(dev, "\n");
 
-	cr1 = readl(base + STM32_SPI_CR1);
-
-	if (!(cr1 & SPI_CR1_SPE))
+	if (!stm32_spi_is_enabled(base))
 		return;
 
 	/* Wait on EOT or suspend the flow */
-- 
2.43.0

