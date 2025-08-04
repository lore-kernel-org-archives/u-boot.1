Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F5AC87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 16:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E11DD83FC5;
	Mon,  4 Aug 2025 18:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tB0juEbK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E46783F9D; Mon,  4 Aug 2025 18:57:01 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A6D83FA7
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 18:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-458bdde7dedso15519385e9.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 09:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754326619; x=1754931419; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yFir9spubR5UB4MJ04Nmm9K1lEa1PoFPonWrTtKOGwI=;
 b=tB0juEbKPboOjwUItfK4/OJXTZFNtS0xRHxzAkurCbgYYDJTFbSpLFLEHJQbmDNU+M
 bmQJGp7ftvSm2KQDW9DkFVV9rT/DezJBA0n2c58NVP5iAUv/BiiXDwWoCvGvl9Xorwx6
 PpdkT+WGbKpHcfDr+JrtQ4VTtyAJdQD0h0bG+gUiNtULCjwG7ERQPI8nrbd+5lKi5ddy
 1Sqjr68whXipjZFObuBqE2Ux+Z1tf+g7iXkJiHA9ipJDmHLv0RT2q17U8SRSuw8Jdr0N
 TTZoo+CDm790ikBN1bJFMRrRq2g9a+Xlcg+Q4Us6Y7RpJ7m1Ix+HecABDw7jnMSM9Ipr
 VH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754326619; x=1754931419;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFir9spubR5UB4MJ04Nmm9K1lEa1PoFPonWrTtKOGwI=;
 b=EgAEyJdsO2k5huEjmww60NXLyUs1U7W/Nawq1AKoQUTBW9NK10KDo33exse8uhHAnJ
 GgrXTIAJ6a2+gogCTb+2E5hPM9RVGV/jmG9rqFUcARPbbMGrFAHP/XsbuWArlTdZ3l4R
 RxPDRPxUW6qSYBw38lOVCp1f3DQ6+k9uy89qr5ZbmpE8XDFeERm6bt7q5nluURZHljPP
 BXey6obIAdts+d6QM927eIZowf7CfgVCLQ0FVhiNuV/2k24WLpKkCrpXak0NBrcFf9R6
 TaO9zD3/RHXusQYVCGri4u0QPjtnc295X8ILCIl+0Uz8IISpt+2Wr+Zal7BtuuRgTzow
 6/8w==
X-Gm-Message-State: AOJu0YyEohXo9OcNfNYDfY1Rj4dFtRHAPht+YLoDfrbHGtlDB2jDM91i
 6wD72HEutZ4QDYxo2ijYeIH41uBkn0o1WqTrPovJ9Yc1mnkkbKQ6ymoajAD05RaRbF7n48K/Zlt
 HdB9O
X-Gm-Gg: ASbGncv4T1EMneKoq1WFA4pwbSc/65pTcYIaTdygwOlIl3nwGssfeeOPB/xKlDGcjk/
 iRXrQyiVjIjdqFV7kkvpenuv/S0I24dRxRpsPMnwsE6N9/1NloBGSvKEldnQQRTsnSNHeVsNMb4
 VJAZaZ/YeQ1my8pQwEiPACdc+YRUmh85frS+y2hWuULwx+QIqTIoFqcG9Mmxbc5IXv6rUG3xZZ0
 pnoYCE7YKhHhXsA7tkyxQSeyFTAdggIuJcKceZXcjTJhhZUx/XHfE43efwDws99apMQhi+m8XNI
 Q1qkQ+NKU0BZybMyJMX+HLfyO0U7UBzpxzkpPicc+opsHUPrJF7Jbc5c5lwHbfDK3+jehEhyzVx
 ansCN3pL+Ws8cuJw1+6KPEbvbCHzybtLLk7Uo9gXuMU4Ind3JQ0A=
X-Google-Smtp-Source: AGHT+IFB0CHpAzK/5ZiknboJPSkJHqWDNMg48Aem/NM7yXuc2pBjQmSdg5wXSlKERJfNKdn7doA2tQ==
X-Received: by 2002:a05:600c:1d05:b0:459:d709:e5b0 with SMTP id
 5b1f17b1804b1-459d709e958mr46644165e9.5.1754326618660; 
 Mon, 04 Aug 2025 09:56:58 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459c58ececdsm43054265e9.1.2025.08.04.09.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:56:57 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 04 Aug 2025 17:56:55 +0100
Subject: [PATCH 1/5] net: fsl_enetc: Fix copy/paste error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-fsl_enetc-v1-1-0708a826f9fb@linaro.org>
References: <20250804-fsl_enetc-v1-0-0708a826f9fb@linaro.org>
In-Reply-To: <20250804-fsl_enetc-v1-0-0708a826f9fb@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

In netc_blk_ctrl_probe the test for failure of the function
clk_prepare_enable should not return PTR_ERR(ipg_clk) as it does not
check IS_ERR(ipg_clk) instead it should return err as that is what is
holding the error code in this case.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/fsl_enetc_netc_blk_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/fsl_enetc_netc_blk_ctrl.c b/drivers/net/fsl_enetc_netc_blk_ctrl.c
index 46b68d3d8a4..fecd66eb15a 100644
--- a/drivers/net/fsl_enetc_netc_blk_ctrl.c
+++ b/drivers/net/fsl_enetc_netc_blk_ctrl.c
@@ -293,7 +293,7 @@ static int netc_blk_ctrl_probe(struct udevice *dev)
 	err = clk_prepare_enable(ipg_clk);
 	if (err) {
 		dev_err(dev, "Enable ipg clock failed\n");
-		return PTR_ERR(ipg_clk);
+		return err;
 	}
 
 	regs = dev_read_addr_name(dev, "ierb");

-- 
2.39.5

