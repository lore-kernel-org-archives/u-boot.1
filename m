Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA90CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 16:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421CF83DF3;
	Fri,  7 Nov 2025 17:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="zIA6XWII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6716283DCA; Fri,  7 Nov 2025 16:02:36 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 512D383D90
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 16:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so6054585e9.1
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1762527754; x=1763132554;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NeBOlHxeVBacE/0U5goisUIhGyNP0ZnhE1oiIoLMnFg=;
 b=zIA6XWIINPjqLcv+/z8aG4TYOkecGqjGPHnpCSsQlMKOECAPHyoscbu+6sr/Y1yBMF
 JdAlkcoO+3nM25sfeKxSiwg5AegZuIAeTagSB52mbMv6RWhNE+CkAhWUyRLio+zItv6l
 819fUvkY6yPee/DfHSNa3ObUMmtT7qcJ7BvRLNYcHIPMGshMrKgvKfP1WFBprOVtWk6m
 +cVn0J2u8P1wqWyDTsD7gwG7PmtIlC7R0aT3zClIXDgJxOODCFjMIX3TmWkQREPgBQpC
 p50kPrRDAGvotNOtoW6HfenfbHFIETTUDZ5grbj4chOzOvoAsIIRJw2XiIX3IXPCiR5O
 J3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762527754; x=1763132554;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NeBOlHxeVBacE/0U5goisUIhGyNP0ZnhE1oiIoLMnFg=;
 b=r96V4wGtmlwr64L9p6W9Z3bYmpoHMcEYfJykOhN8MVobQrileBR9k1eEye0XS9WeuW
 lJ+k7p6rGA8MNaogP5sN02CePM2AQjUDo3UJ2Zg8AKkrjb8VmNHX2ED7ZpiEBOdYzwHV
 M7J5AOM66vBnSxVql2ObuAJlxk+qH9AldEXyg47fxcr7oCXodrPnGwc9plp6CoXIZybJ
 imgnQU72m5XA53HrsC+AsWNDXSl87o86AhSsPYcO4KghMo1ucGvyTQmabOaWMY2GQDGu
 +l8Pu6hl5HhUfxxStGIj4xs8/nzqQ9CvXlJqKc3EjwbT4XxjWhDRFjcj8UGfeRiTihmX
 Um0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrSsJQR1UYAPze0CoUo/CSL54ducilc9CaOdNfCtgBkqDgrYBiZarao0lRseq6oB4z/RFfRB8=@lists.denx.de
X-Gm-Message-State: AOJu0YwQiGh5+HHB7g1x7IQv2dlg1ymIpaUkYeKoXHkOi36rn3KhvLM6
 762IFt4Ga/YFqj8dn936YfxzS00VGuZ8brhUTGFPwlvO+43ZCVZPVbOWO4lKYgPfi9bfiVu5ccq
 OOwcS
X-Gm-Gg: ASbGncsslk3+4lsLrTnYRM2d4NVpD69ZPHtJ9/bAOJdjXBn51SyXKcPkyPxRAgnqiFb
 7vl/KvJoGbgPk2IAgLctWY3P5G3uJ0hMUF9lyss/KqpgRjD6jmPwK0vDl5zHCgrm21sI04ukrNM
 hdcX8ghFRlshGYE3TbAcgQ4NL4nGyXwQcDh9Ral0QacyYhZrRt0X862OrX00CZyWkVcpLuy0uEi
 /iI5+VAqsbegU5wLpMXm3pkW+0oivVKUVRA9sN+SRlygL+GmAI6iDzzfeoryDJqkX42gru4Gw4h
 LOeDWok1937DaiLbtw4yMkVuLXL7i7iWGbVjF21JX+Vs0IAwwkf5MNL0zlTWAyyZMdw5gjskNUP
 MEMqoi2sks6CCwFm+E6q1icckk2lljl/d1hFPT+z2VhatFexItDCcd1GFpsq5pch+gYoM3ujssj
 rUlGYcef8lsA==
X-Google-Smtp-Source: AGHT+IGENzpeUlz2afgpKWNtH5YLfaV/aJlHUlZn7kDeCskCk5cUD9Hb358FKrEMO7NRAKKQ6LV31Q==
X-Received: by 2002:a05:600c:797:b0:475:dc32:5600 with SMTP id
 5b1f17b1804b1-4776dcd706amr13013085e9.19.1762527753404; 
 Fri, 07 Nov 2025 07:02:33 -0800 (PST)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47763e15481sm42508845e9.3.2025.11.07.07.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:02:32 -0800 (PST)
From: Zixun LI <admin@hifiphile.com>
Date: Fri, 07 Nov 2025 16:02:23 +0100
Subject: [PATCH v2 1/2] mtd: rawnand: atmel: set pmecc data setup time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-pmecc-v2-1-271e6aea3231@hifiphile.com>
References: <20251107-pmecc-v2-0-271e6aea3231@hifiphile.com>
In-Reply-To: <20251107-pmecc-v2-0-271e6aea3231@hifiphile.com>
To: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>, 
 Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Fri, 07 Nov 2025 17:57:52 +0100
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

Backported from Linux: f55f552a7c7e0a1 ("mtd: rawnand: atmel: set pmecc
data setup time")

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

