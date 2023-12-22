Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAC6C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 05:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4441E87650;
	Fri, 22 Dec 2023 06:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="htqcuQBA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BDB877C4; Fri, 22 Dec 2023 06:46:48 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF50E87800
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 06:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d420aaa2abso789035ad.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 21:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703224004; x=1703828804; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2+UgqjE6qQ0jTIYF3OlUrm8dqmAvIT1HiSjii4rjqU=;
 b=htqcuQBAUMWVrGKp77i2GHvkZPac7r96Wg4M4w/P/0+WiH4IwV+qDRUQgSBF0iD3K2
 ttORzABbHGZvFPWkJ8E7RehTModfxn4x6Gora6VWBT3TdCungdDlQBz4H4COTO2JAVDC
 Z33VU/j4bhJCHH4KufyhASYsFSW+GgL+Nbidgf/oshhl4HJt+z23GEUWR+yoBnwoRvvD
 aB0qLQVXjhAQx6EyFPpO/pSq6Y+oRwcF5APSe0Q2z7Bx7dnBg38iPit/KwhE95iwGihy
 i9auTKlEYGJFzpTGe8inlrqpw496Su3RQU/gQdozMwSayoK9X34qQ1us3oLmaqwHvLjy
 Q1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703224004; x=1703828804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2+UgqjE6qQ0jTIYF3OlUrm8dqmAvIT1HiSjii4rjqU=;
 b=JdIS+VYGGte53ku60m0f7D3rk4/GPX/EZXuvrdCnUhfXArnTA1Sbx+ElvlZO2hqIdL
 fnu5BGzRBN8hvzmeAjnX8dQWzoO9U9QShxEiRWTIq++FAYUavZ7b3ADc737WVVO+z5Md
 FznaXwebGhaQJdyqeEO99vxhzAUXsYG8CuXmwERMpjm6iOeX/KJW1CxFj8NN9opsgwHX
 jrXpAMosE0JSYN1M6KnmYbk4VOP1//IWYPMR/yd+KkKkUN1+UyflN6D7CjWhcrYx/Kko
 LNJ7yI+VxIswkie39np1qXUvHJAJw/GNOid4b83X59vIoKPD0LO8rr0xqHTcbLRDq6wB
 EYMQ==
X-Gm-Message-State: AOJu0Yw69M5pJMOKXwco42QyxwCwlMoFRfSn790Em0hL2tv2L7jU3BRZ
 8rSl3m1SPX9Ha83XKg9158ZPLcut0Yo=
X-Google-Smtp-Source: AGHT+IFybw0dWAMLzMyWx8Mz86dbdmUNkfG39x6pAxMFBk2zJnIIEbPRuS4jrkJvQKvaW7iRbJyf6Q==
X-Received: by 2002:a17:903:2346:b0:1d3:ff24:b3b5 with SMTP id
 c6-20020a170903234600b001d3ff24b3b5mr610620plh.92.1703224004178; 
 Thu, 21 Dec 2023 21:46:44 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902704900b001d05456394csm2590661plt.28.2023.12.21.21.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 21:46:43 -0800 (PST)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 4/9] mtd: spi-nor-core: Use CLPEF(0x82) as alternative to
 CLSR(0x30) for S25 and S28
Date: Fri, 22 Dec 2023 14:46:01 +0900
Message-Id: <ceb99692ba605ef079c6f796082055bed047248b.1703220284.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
References: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Infineon(Cypress) S28Hx-T family does not support legacy CLSR(0x30) opcode.
Instead, it supports CLPEF(0x82) which has the same functionality as CLSR.
spansion_sr_ready() is for multi-die package parts including S28HS02GT, so
we need to use CLPEF instead of CLSR.

This change does not affect to S25x02GT which uses spansion_sr_ready() as
S25Hx-T family also supports CLPEF(0x82) as well as CLSR(0x30).

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 2 +-
 include/linux/mtd/spi-nor.h    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 3f761b9b9e..20e82aaa65 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -752,7 +752,7 @@ static int spansion_sr_ready(struct spi_nor *nor, u32 addr_base, u8 dummy)
 		else
 			dev_dbg(nor->dev, "Programming Error occurred\n");
 
-		nor->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
+		nor->write_reg(nor, SPINOR_OP_CYPRESS_CLPEF, NULL, 0);
 		return -EIO;
 	}
 
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index ebe38306a1..8a94e12037 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -180,6 +180,7 @@
 /* For Cypress flash. */
 #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
 #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
+#define SPINOR_OP_CYPRESS_CLPEF			0x82	/* Clear P/E err flag */
 #define SPINOR_REG_CYPRESS_ARCFN		0x00000006
 #define SPINOR_REG_CYPRESS_STR1V		0x00800000
 #define SPINOR_REG_CYPRESS_CFR1V		0x00800002
-- 
2.34.1

