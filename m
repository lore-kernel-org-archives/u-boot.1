Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EA3CAC586
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 11:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF51382AE9;
	Mon,  8 Sep 2025 13:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qk10pcOW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CCDF83145; Mon,  8 Sep 2025 13:31:49 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A24E3809A5
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 13:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-61d143aa4acso6811550a12.2
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 04:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757331107; x=1757935907; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LI2UCi++izr1qq+ZKC51YUnkPm4Y7O0SrEPMFcdKEfo=;
 b=qk10pcOWimANl4DvbOBTDqIeFU3sPi4gQhsPVkcCAJRgTiovXMKmwADssCNyHYhtZJ
 PGy32nVPAgQcyfkJqJeRtNFZhgr7UBTopKe79KBm79b6fgRQ4tqnryI0CUX6ReMgTSrF
 wovhvvYu6v1xbK7iSYhC/9+1iRVRYbyK5klkgPUbP0k7OcfMwUIZhRJLqo7C4ttPdUQc
 qahQuuxPoGnce+zckM5Ae7BNMV7IRcO5I+by4XHEVe+mL34o8ih2FdJXGOLB+q1dkoIm
 7zCOyOxUkoyiFrQKiDxvKGfYCVm/8j18uzoOG7+9t5oF4qRfk7eMgCaVoZnF015QrNhO
 YT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757331107; x=1757935907;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LI2UCi++izr1qq+ZKC51YUnkPm4Y7O0SrEPMFcdKEfo=;
 b=idmbHMaW3fWeCN0QZo3fg+MOLMfoGnLNHzgxqZM58q1QNI8CgPfLmzBxxbR6a1DGEV
 v0IRoGhP4MaBAs4tNDwyWoK/bY1ogali+zrVwh/BiehieDeiISTYNHIRCjcxlDvPBs+U
 rfvinlbtB4Ffh42dyxOdYk3LK5hX01O/xFX+OFntFXPHOi8USkwtxRsGwjkIFTTVJPE1
 q/rDiyjZ1H0lU7eRPiVjjSp/48ipyrhXSxn1QjXdSttBzcpwtxMi3ZpelyQ2cRkBX091
 ZOIqHDadj/k2l+uhEF3Y7v63O+NcxZis3YMAmswR0HtThGXBrBh4P5Ihve2HfI1pIMCx
 1+SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdxuc8inaBAfYiQzj8k4TYscayT3v99wCpEYE67bryOctXSyqeeZLMC/Gc1XHj2X5ZT5oRdjk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0EWdX6eDTqeNIqjxogU8irrA5uhcGnykNWPGcrhdYNQUncpcS
 v6OvmeUt3o5y/ql6xrCNYHNRVQgXiMkdEQJXGq6UCxUys5J78uQ0/ZqdJ7tp82TpP6E=
X-Gm-Gg: ASbGncuIIwY4F6SpylSHyN7ffQ+J5CguiTNotLrDfH0495AiDHFoUCqz1coMko/iPap
 8ag0VFQhzyHGzav0kiJ53OYXhIPsbe9xboZMaMZTZkq3ZXZJ8Cm35cAZUpBIIffpIptVmLUFRWn
 JpuW3cOM58DtCwR8yfoULV8kk9slVM89FbUx5zZDybpSyC9TiqePGi+cOpbZrby6at8ndeBnkjz
 yJ82QnwIAN52kSsKr0nucroAx3TbMs2AGsDYZ2XDREDn2p6viINDZ5Gxez+StZVXS6B2iWtuFQK
 UyfG5QY5ugAsH/iqD5wCooU/JdqV5LsCIPEOS4iUxvQobgX4k1URtev6o520gmjQBzHDqBLLG5q
 Vw7Zi7Z49rcl1fwv+jTvLYWIki6j0gkpurg==
X-Google-Smtp-Source: AGHT+IH8/4ahpw50tNVjpLqjrQ7qciz3hQrHc11cUCMxQLPCJc3DK6sC5E26Vas3XwoVrHVnwqQyxQ==
X-Received: by 2002:a05:6402:1d50:b0:61d:1d36:a7d5 with SMTP id
 4fb4d7f45d1cf-6237ebc9354mr7386475a12.19.1757331106328; 
 Mon, 08 Sep 2025 04:31:46 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:30:60d4:28a5:7729:b0b6])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc214bb7sm21251501a12.13.2025.09.08.04.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 04:31:45 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 08 Sep 2025 13:31:24 +0200
Subject: [PATCH v2 4/6] serial: msm: Reset after writing to DMEN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-db410c-autoboot-fixes-v2-4-316ed98e0143@linaro.org>
References: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
In-Reply-To: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

According to the documentation of the UART controller in the APQ8016E TRM,
clearing bits inside UARTDM_DMEN requires resetting the transmitter and/or
receiver. We do reset inside uart_dm_init(), but before writing to
UARTDM_DMEN. This doesn't seem to cause problems in practice, but let's
move the reset to the end of uart_dm_init() to better match the
recommendations in the documentation.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/serial/serial_msm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index aa4d10e7c5138f919978272e4967ece8293073b3..5523ec4afe17f242d61bc2ec4b4534b5b974434c 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -219,11 +219,12 @@ static void uart_dm_init(struct msm_serial_data *priv)
 	/* Enable RS232 flow control to support RS232 db9 connector */
 	writel(UARTDM_MR1_RX_RDY_CTL, priv->base + UARTDM_MR1);
 	writel(UARTDM_MR2_8_N_1_MODE, priv->base + UARTDM_MR2);
-	writel(UARTDM_CR_CMD_RESET_RX, priv->base + UARTDM_CR);
-	writel(UARTDM_CR_CMD_RESET_TX, priv->base + UARTDM_CR);
 
 	/* Make sure BAM/single character mode is disabled */
 	writel(0x0, priv->base + UARTDM_DMEN);
+
+	writel(UARTDM_CR_CMD_RESET_RX, priv->base + UARTDM_CR);
+	writel(UARTDM_CR_CMD_RESET_TX, priv->base + UARTDM_CR);
 }
 static int msm_serial_probe(struct udevice *dev)
 {

-- 
2.50.1

