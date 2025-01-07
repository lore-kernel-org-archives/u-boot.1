Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490B8E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 14:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4B49801E8;
	Tue,  7 Jan 2025 15:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BZoZJ8D1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F7A805E2; Tue,  7 Jan 2025 15:32:37 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F4E98007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 15:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so2580546666b.2
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 06:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736260353; x=1736865153; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DgmtqaiCXqXPGJJq/ORD2RRQxJ2tR8T9iFqTH+FSor4=;
 b=BZoZJ8D1QLtGB0mTQxbfe8tkTxvAPpKKtJHGXpgLTVAuC1hymM1EPGZA+7TLtM0D00
 XJn3qlLy7IcJURyVgkphyOnE1cji3xyOH6cG73qrZVqj2nzNryIPhxhbr01+FhWYldSt
 hYi/jDlHXI4sYUMZPG052JYjOV3cTVJdjWtGl4jbVAvMsW2O2m29OAw72k2ciwb9HbAi
 laJU/fZ9Dh7cOPelU9w/LZCWL8MhLajccmMtT8jLi23z1CxOG4LhMYPSvnaHnmJmTWh7
 RUduhDL/0TR5ZC2rkZ/IrmPteadqL0k7iTELWovH2nGFleHXKaC0RgKJtznzAzFFQz9n
 e2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736260353; x=1736865153;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DgmtqaiCXqXPGJJq/ORD2RRQxJ2tR8T9iFqTH+FSor4=;
 b=uWEFtmFXC3pksLQEFV6bvHTcjE1ugI1jtmpwXDQ5rdMy+vvob8bfDZ8yDfYTLmzMmj
 iBiy12/w2wDhtxKByIwR3LEZD+HYG8vamRMhJu+kbBiGyd1RhH3gqm/aKuRE7Oe+ayuW
 6AZ5A4Gvf8bW/vy8L5H/PwKSi3H433myt82Za/jWSOaz+WoVDl+AseHs61GsOIBR1+I8
 bneL8MqcdZcIte995ZmOACxM13mgRay33DDZRQFJNbflbHZLQmySv1QW+kygFWlsLDl7
 ZvsV/LlR85Ia5E8mzxl4BCgEYwqU4yXBgSv7jEIE1jYqI90VyNNBz/dB1QfnuNsg8M1X
 C5fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLR+HuFQdF37LshQPzrPOh01+J5eR9hbksZnDsIOA8paI5Gz3pK0TBgfCqDRYEHk/FcStzmOA=@lists.denx.de
X-Gm-Message-State: AOJu0YxiBQkiCIz7LPUahsYzYWQtJHQxdogrgCEUb6SrzXbMKdaRnP+W
 mGjqKLVoJLa4ARoGEcoQTN2pKnx8hwCKX+Ob9V8QIOmBPy19dMtVgHpUmXbexaM=
X-Gm-Gg: ASbGncsqMjDs9EjVUyUxjhvOl1BdigP9jtYy6HIEMmm5g2RbnxJQkARbObshamKPRH1
 wl9gK7owGBGxuHBItoxkJItik8EllizsT+idbTXezTdM1pdT8EG0xAsHYzi6QrG9mTOqzYYUyGv
 /OjSVoTbvGwVYmJBytYUUswRtpxoX9SiguR2CgylroHBbpfD3Jm5ntRpTMg5dMUZTCY9TGOXVqD
 S/v2DzZzQ8E6TWhhasozAHO18gNdZN+GTkB5ezxO0gvCqkdIrDkoEXILjscojv7UQNZvRtDnD72
 DPMl7g+YKXcmAXF+vQz3clHmfVnO/3PfbDs+BxI=
X-Google-Smtp-Source: AGHT+IHTQ2EG1oKjRmADxRfMRIfpGstKCsBYK7afsrOgxRZsPE4cskGXZ73Fte8TYkL2SElnFjG7Ew==
X-Received: by 2002:a17:907:8dce:b0:aae:df74:acd1 with SMTP id
 a640c23a62f3a-aaedf74c300mr4610457866b.11.1736260351365; 
 Tue, 07 Jan 2025 06:32:31 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f013938sm2378837466b.139.2025.01.07.06.32.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 06:32:30 -0800 (PST)
Message-ID: <28289f92-114b-4608-9b5b-6267deb6dbd6@linaro.org>
Date: Tue, 7 Jan 2025 15:32:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] pinctrl: qcom: add clk_req functions
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241125-topic-pcie-pinctrl-v1-0-4df323d90397@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241125-topic-pcie-pinctrl-v1-0-4df323d90397@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 25/11/2024 09:29, Neil Armstrong wrote:
> Add the missing PCIe clk_req functions for the SM8550, SM8650
> and X1E80100 TLMM.
> 
> Depends on:
> - https://lore.kernel.org/all/20241115-topic-x1e80100-pinctrl-v1-0-35f984226e47@linaro.org/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks neil!

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Neil Armstrong (3):
>       pinctrl: qcom: sm8550: add pcie1_clk_req_n function
>       pinctrl: qcom: sm8650: add pcie[01]_clk_req_n function
>       pinctrl: qcom: x1e80100: add pcie[3456ab]_clk functions
> 
>  drivers/pinctrl/qcom/pinctrl-sm8550.c   | 1 +
>  drivers/pinctrl/qcom/pinctrl-sm8650.c   | 2 ++
>  drivers/pinctrl/qcom/pinctrl-x1e80100.c | 5 +++++
>  3 files changed, 8 insertions(+)
> ---
> base-commit: 7a36c84ff57177ccd3107f62c8d14fa0093e0e76
> change-id: 20241125-topic-pcie-pinctrl-77f1c184e73f
> 
> Best regards,

-- 
// Caleb (they/them)

