Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4A8CD128A
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 12:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BF59882B1;
	Thu, 11 Apr 2024 14:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q8ZoftUe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A1B88280; Thu, 11 Apr 2024 14:43:11 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 336348828A
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 14:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a47385a4379so157487866b.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712839388; x=1713444188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pw93TmDPDQAkwl5pKSFrKySzCNLuFRwznyTmTT4BPnc=;
 b=Q8ZoftUezFZoOFhmCXDrWUkM0CxpWadAoXnvz98gPE/EoOgeu1WjQwErrEjJfVQOl2
 m8SNIaju67Te3ppsm/P+Nz+B/r8MzLgeM58GIAiOy5qRuD+AJJVDfo3/IQOI6Ybbw9dZ
 CSPdrhtZRaKVGLO1dKHx0oFL7kJwSNN7lzztqoCmJdnP4r9p0/dCQ+1l+ugwXu53e1Mo
 7W4Qaqhews2dqQ7VjuYg26DEKZ1XkznfO/cSvgTgNQ70FgY+a9ZSp7mYO3TgIppV5NL4
 qZBA6ng3OnMGce8dI3sgociPIFMwXNWPkJstB47ch/+pbLWu/TO0ZkR7m7j0ED1d2RNE
 fAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712839388; x=1713444188;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pw93TmDPDQAkwl5pKSFrKySzCNLuFRwznyTmTT4BPnc=;
 b=ivJAWC6OqjVQZjYFiUCo5PgMQlZn7Ga5HARxpeCNeQz3wfPjcYOoiJIWdTba/jW8Dj
 NMn+rsQkRPNbkzQtYQhK6yKRiVXlKx6odFvNymVTztqqCZK92ZYxIQ2qb53xhbn3t2Xr
 9uQuRiqWJwDekkvmpW6LzbGK05ULMO1pNnnBTL+itizRDcFAzd98ITXgdnBIneJeTjQE
 QOauyhETkCx8cJXO9Woi02D2ozYqlJg+X0h2JqvkytAc5udDnWMmQ8WcGikfIhy78rA4
 VwuBpp/1Q3lCrBhe7FP7wDOlTjkYWFca0TYMXLUB1jFRmm5BUz555XYxZd4QoOmiHtfy
 C5SQ==
X-Gm-Message-State: AOJu0YxFoCCa0OnL0MbSQ58KbHo6M+QTn/FKCIn5E/r5AsZcd1PxooXB
 06DXcWzSkQ6lnQpPFKZNvxiZ++EpvbwVk18vVbWyCBxBHj9G1uFjOZW6VKUxhmo=
X-Google-Smtp-Source: AGHT+IErVWJABI82gNrDBeWuw/tGLSn1HoF37LSrAAMMVrAoDj08cUbIdOIDSG5IYT4cg4X/d2UZJw==
X-Received: by 2002:a17:907:7d8c:b0:a52:2238:abd7 with SMTP id
 oz12-20020a1709077d8c00b00a522238abd7mr1568026ejc.32.1712839388741; 
 Thu, 11 Apr 2024 05:43:08 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a170906844100b00a4e8a47107asm710491ejy.200.2024.04.11.05.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 05:43:08 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240405-topic-sm8x50-pinctrl-v1-0-92d563c28c90@linaro.org>
References: <20240405-topic-sm8x50-pinctrl-v1-0-92d563c28c90@linaro.org>
Subject: Re: [PATCH 0/3] qcom: add pinctrl driver for SM8550 and SM8650
Message-Id: <171283938769.622116.15145320526567860572.b4-ty@linaro.org>
Date: Thu, 11 Apr 2024 14:43:07 +0200
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


On Fri, 05 Apr 2024 10:15:09 +0200, Neil Armstrong wrote:
> Add pinctrl driver for the TLMM block found in the SM8550 & SM8650 SoCs.
> 
> This driver only handles the gpio and qup debug uart pinmux, and makes sure
> the pinconf applies on SDC2 pins.
> 
> Finally enable both drivers in the Qualcomm defconfig
> 
> [...]

Applied, thanks!

[1/3] pinctrl: qcom: Add SM8550 pinctrl driver
      commit: 225c991b41a2255054dfcafb7667979c6a88bffd
[2/3] pinctrl: qcom: Add SM8650 pinctrl driver
      commit: b0725abe0ae5c41c03dfc9af921120fe501f07f5
[3/3] qcom_defconfig: enable SM8550 & SM8650 pinctrl driver
      commit: c32ab322d04eed52d5ad30b19d45fe041c19a250

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

