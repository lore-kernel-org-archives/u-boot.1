Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCD3CD1284
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 12:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FCE18824A;
	Thu, 11 Apr 2024 14:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LgySK2pY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1C1D8829F; Thu, 11 Apr 2024 14:43:11 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72E0688280
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 14:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d89346eb45so55466121fa.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712839387; x=1713444187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FuqcYjlNNVsBXLzXpvA0uXb1Pn1TvkPDbDuuYvHoMQ=;
 b=LgySK2pYsRHwXU6y0JZ6b29gPCr655xH0H81eb0hJEOt3aKHN3mXPE6Z0Oit/l9WYq
 44qo4xiJY+w8m2yCzKC+KZRHTxVsyKRSdRsXkQZuSMtNJxrrCEKYpoKgqbQWq+mxIDK7
 YjH9MuxDKY8RlgaMkl3JDSZ5nJuha6NRIs4ph8XeSLdxiGHasuZyC82BJ/MHcSR+9d8v
 ZmlbV5snAsoyhqavdr2wKvS0MfxUL04bY37+1JfmE/4CSbJSt5ewptYmgfL0nY2gaFxJ
 hkWGs1ZOhlQSB9NHLDqFB0/7TLj+C3oAMSE+1wKgPnnhMA9tAp1QtEvhVZLaLS0pOIAS
 5o1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712839387; x=1713444187;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3FuqcYjlNNVsBXLzXpvA0uXb1Pn1TvkPDbDuuYvHoMQ=;
 b=PJiY7JrtNGTKfsYiiao1d2TqeKeqqY1ScLsjbEf/EQMQIz+K8X4iGWZ4c8rn5ywxdH
 maq83Io0M/PNHgWF42uzPSPR2h+5bAeGqSBTsypTlkKB+GpvDAQVRmwYx0lBWRyLu7e9
 icfM6Eu5RgBXRSkwPW2WXJyS2+p1lm7jfrkolfqjIGxsmcsNLafh57rA1S2k4+gCyjDA
 4NbBgPB6KuF9/InQN9O4lterpHgbnYERAbYnau0JUgohG8eZ9NEjxutmJGDos0AJk2Rl
 08xwyTkIPpNDpFpGSeIpUItkScCmByaWy9XNS8H0RKm9TTIWPH1vs32CCHGQk94vwhLw
 lWvQ==
X-Gm-Message-State: AOJu0YwlIfvijhVqauXW773J/2OQ4Mh1emFaFvqIl0ccmwW7deFNL0/a
 R1igCxdyQvbE55pk+8nkar3z7dyTN6LaSje+sdKdHKaN8El5ncNm1lfhjczuIrKL+nQe4gbL38l
 4
X-Google-Smtp-Source: AGHT+IFmm6jn/03c6L0j7wbfdgWYdEuKCPVAL9rGUGxdKCx4Gk0bgvGwJMYSRkXsUMSWk4YWA5z3+w==
X-Received: by 2002:a2e:9e57:0:b0:2d8:7266:ae74 with SMTP id
 g23-20020a2e9e57000000b002d87266ae74mr4502637ljk.26.1712839387429; 
 Thu, 11 Apr 2024 05:43:07 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a170906844100b00a4e8a47107asm710491ejy.200.2024.04.11.05.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 05:43:06 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
In-Reply-To: <20240410-topic-sm8x50-usb-phy-v2-0-9d2d90bd04da@linaro.org>
References: <20240410-topic-sm8x50-usb-phy-v2-0-9d2d90bd04da@linaro.org>
Subject: Re: [PATCH v2 0/2] phy: qcom: add support for the Qualcomm
 Synopsys eUSB2 PHY
Message-Id: <171283938659.622116.10661068866793180391.b4-ty@linaro.org>
Date: Thu, 11 Apr 2024 14:43:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Wed, 10 Apr 2024 18:01:11 +0200, Neil Armstrong wrote:
> Add support for the new Qualcomm Synopsys eUSB2 PHY found in the
> SM8550 and SM8650 SoCs.
> 
> Finally enable the driver in the Qualcomm defconfig.
> 
> 

Applied, thanks!

[1/2] phy: qcom: add Synopsys eUSB2 PHY driver
      commit: 01d9217273df37c5150bab45018b0ee54cb1f30e
[2/2] qcom_defconfig: enable the Qualcomm Synopsys eUSB2 PHY driver
      commit: 1e6adb446297fdaea5561c001e58cc9f2cb7a743

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

