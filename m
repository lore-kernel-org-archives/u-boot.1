Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85115C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FACC82DB0;
	Mon,  7 Apr 2025 11:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TkLbLKhO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 661C582DA1; Mon,  7 Apr 2025 11:54:41 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E83D82D0C
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac2dfdf3c38so834995566b.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744019679; x=1744624479; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tN741xSxEN2az9AYG73nz4jt6mHQ6/S8ra/ALW0HwAw=;
 b=TkLbLKhO8KrPEbnQGBk5uDr6/0WbkfDcvwezHIZCH4QjYYzZjxTWiHeCmJB2fk6Zpg
 1D4qYd4KvOm5WEEMILFNe9XPwzKJBnJAU633vqtzjYAAdIS1J7EvPdQMcky+M5iVwiYe
 n7cgQA4Qpm1BzWhB4sNojClOgJItmXaqF34MxW/PkKqLp/ZzNv2I34hRvGru4Y4k7zft
 MQSejaBzQzpT8z1psl1rQ1zbD3nOOCz07Q43aeMHil0TEkQ6rNgjrWauuO2knyjhHeJc
 BKd4JfvcBL52igWSfMctHGlX57nV9uUFofvFvhZ8tkpFW37EySNyNLlirdQ3YRZzLIHv
 BKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744019679; x=1744624479;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tN741xSxEN2az9AYG73nz4jt6mHQ6/S8ra/ALW0HwAw=;
 b=kDRkSEYCWITIHHwJKtTe9Wiju0izIeC3AqXRc0Nx9OxXiM654qfzl8D/QKnW78fjIw
 /XHrH4vu1Sxsc4G0bydvnWLIyEvvq6hN8ME+T8BFEwBVLY9k5z/JUPCAhmBqJuiApcBn
 J/XBaeLckuzkLRYtga0KpNv9kdbLVZpTkH6faDUXgtM3b8jzKT40LtHxtwmauGvoFEDj
 6WFNbSYIcaNKgK4wxFRgLq5G2MBQ/27D+fHIO0Y7xi+cTuVsZqhxE72VWIKRc08HAnip
 V8ggv0OYVFemj9Sd8GHxIhOnvUb8D1rejtcgEbTQSXb9PHpdCYV6TnllxOsMCNvFZEEL
 cx+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb2BYjT+T/jyEi8hCqdoQbdeLoSm2mKhxaUjoqL2IL9UbOz7P2NA1hk9TIGEEeeWYZp/7j6i4=@lists.denx.de
X-Gm-Message-State: AOJu0YzmUQ/ZQFFiUQNWXzcrEWyyVVzxbG5xw1AUni99Zu0Bk/hGVeQO
 pXN+fIBy9poU1suqTT/7UX00WGE1HESPIHkSb9PdJnBHLOClRjzeUt5qWlueIGQ=
X-Gm-Gg: ASbGnctwA9nZ/6J2utQQiY8GkfIaHV2/hIjqs8RQ578tzWvwX8kyc7bMI072Mg4tEGp
 P2IyjfCug1dRETTcz7ovR4K5pWb6w+3jViijlngysKiIwb5isiYwXFe/Yejn+nPGSPTCv/hpOSe
 UVQ/v8oBm7HUHu0krfDf+8aLCGIBhsO+GMSACNOzg+5IJgPy+/QI9RiVstUv9is7xIBGYq+f0Bb
 dlAprhexQJJpY26DJAMjyNtgXIr4kyZ6Ls+ZBuAtzP5qyAUfTsVtcoFQQcQEymP+XKWfXkhqUUm
 IRcCLLDEiR/1jeWEnFDZmpnoJ1ycalO8ie9NzKgYqyC0thABMMv5cgdPTg==
X-Google-Smtp-Source: AGHT+IG9oO+9t8xcT2JyW1FLn5MO2zgNZKNJJKhe/MieTXAsuNOOooRraK/5mrSNiX0N1tfLtViHAg==
X-Received: by 2002:a17:907:2d90:b0:ac2:b086:88d5 with SMTP id
 a640c23a62f3a-ac7d18a1efdmr1123579766b.18.1744019678800; 
 Mon, 07 Apr 2025 02:54:38 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:7d3f:b102:5311:c65b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c013f6b5sm735733766b.109.2025.04.07.02.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 02:54:38 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 11:54:21 +0200
Subject: [PATCH 1/6] usb: host: ehci-msm: Fix pointer check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ehci-msm-fixes-v1-1-f8b30eb05d07@linaro.org>
References: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
In-Reply-To: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jianfeng Zhu <JianfengA.Zhu@sony.com>, Jacky Cao <Jacky.Cao@sony.com>, 
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

dev_read_addr_ptr() returns a null pointer on error, not FDT_ADDR_T_NONE.

Fixes: 2be1130a9305 ("usb: ehci-msm: Use dev interface to get device address")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/usb/host/ehci-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index a759aea9db38dd5af2bb85b677ac403018983cfb..dd1d527a3a2c3f38df747dbb41cbb84bf76286e2 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -141,7 +141,7 @@ static int ehci_usb_of_to_plat(struct udevice *dev)
 	priv->ulpi_vp.port_num = 0;
 	priv->ehci = dev_read_addr_ptr(dev);
 
-	if (priv->ehci == (void *)FDT_ADDR_T_NONE)
+	if (!priv->ehci)
 		return -EINVAL;
 
 	/* Warning: this will not work if viewport address is > 64 bit due to

-- 
2.47.2

