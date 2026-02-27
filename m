Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A51FEFB6A
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 16:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A0CC83D1A;
	Fri, 27 Feb 2026 17:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xemk1AkD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ACE283E76; Fri, 27 Feb 2026 17:13:32 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E329E83CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 17:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso16104945e9.0
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772208808; x=1772813608; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MPcO1lADfCIwooBwHdiKK/1ffxUy9HdRNQy+Tz1AAFE=;
 b=Xemk1AkDTORoJ37WVyb3w6yAG/E2H75g1RmfO5Ar3EbUN26ygBKdXx2jWm55HurOxP
 UTp9p++fybrv91ldCsRTmiYyitIDWw5SnF0lLmIIlFuOWXBurwusCzMJ6qeHq8LK773H
 JgXGMCxfu0DU9bipZe+F3XlpjLEDJlqnnmFJrPXWe2PF7nrR4/9FLU6xjttziTdA1v+Z
 vQOG0wbtStb+76e0gOOKwZSuznPTQyOlnEFcfe9ICFzUQBEq2yElTY8CI8WMYF5VyLzc
 eNRhI+QIA3zbkbwB796l7nJX7SfP7EyVkEYX9ShXO0TzuXV66LhQoh/oL34JqfcSGSUg
 oLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772208808; x=1772813608;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MPcO1lADfCIwooBwHdiKK/1ffxUy9HdRNQy+Tz1AAFE=;
 b=rxjkTp235B0bKqNsQMl+aFpg4bJBnpUqrFSc/uJ93BHtbQZqOFKqsCz+cKIVCRwqac
 Tl1BClzrtfRn/oyqnCbKjovBz6Tu9cuVJjL6ZJbMWYyswLMzLREtoMHzgYpjPwY+zAEd
 FQMOwlbMebnciqSZcTOXJzbDpapgxPOvotB1tRoQfB10QTtFN48sGadMH9k9WL7n5qKt
 4cZ6IFEMypI9g5f9mrK9STS+Tesb/bhofBEWQKAc9P/ZIMnMIyTgpEBTTacGrj3hxgbG
 jO3N3rhJMWfQO6+2N+eI7U+X/uM1KFtRxzQ8rR4iDNJaTvTdQHh8jAWQdi2OwFjRu0MG
 93Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQYexYKdJVmCT46B+sRR9uzfNqHlLyJNm+AJYURTcY7PMzdKM8W+c2NDc1BlGpRrE4aUejmVM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7giD0QHPDowrZz4pLeIBAr5XcqHH3buIe8ghscagyviqxzMHH
 cE3KMKezcKtxZtcp7OFhELOTAideIvg7ZAXZdp8BjqgCRi2l1Ewl0UKz/V+yvcEVzJNNC1bpi1d
 +Zqj1
X-Gm-Gg: ATEYQzyAGXFhDtWQwhVpehdUr/ZELDmWMqvK3l2hwIJ2ePHs1V2Fbz0DzfCLPxLwD7f
 Jop0x0cHXh7RxpHPDzsm3o4MDLQ82BJREjX65qgwXiomhs85tyNjXI8niH5KKcT4jjrxZ4Uubms
 xJ/I585tLgOpB7hckSUlegWSRDiEqi1HQJemQY/FeDhh1dBD+ubI4UZbHdIGwHLlnhYfxjACesD
 SRH5sJyOsuKtwsS+GSSfHKnMDNKJ4/09nymV2uWziUr2OqBxlhwBEmMcSru3ZEuWYXGj1ezy6v8
 xyaqmaIXKNhn3OlLXelkmHZQINFdi6ZzHmBSRxyv3k3+hOV9dPFEBQMkp0ekomYzO5VWzq1jZsa
 SRVbn02s7srYGP2CGhfBnbJF81fx24BzW7j0HUs5GVGfwUhOxF0Q2IuaMQSl5AKD3DbRpHi5xwa
 zZaWVmuT6hrOz693fmk4cAQxn/Uf2LLOdwnqtssyP+VATvGdaKBbQcD9QiWeuW4Albjw==
X-Received: by 2002:a05:600c:4715:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-483c9c2a51cmr51021265e9.33.1772208808178; 
 Fri, 27 Feb 2026 08:13:28 -0800 (PST)
Received: from [192.168.1.36] (p4fc3dfb8.dip0.t-ipconnect.de. [79.195.223.184])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb789efsm111959205e9.2.2026.02.27.08.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 08:13:27 -0800 (PST)
Message-ID: <89ee5c39-0a2b-4418-bd00-6e85345079d3@linaro.org>
Date: Fri, 27 Feb 2026 17:13:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: sc7280: add missing SDCC1 clocks
To: Ajit Singh <blfizzyy@gmail.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Luca Weiss <luca.weiss@fairphone.com>
References: <20260226193217.82657-1-blfizzyy@gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
Content-Language: en-US
In-Reply-To: <20260226193217.82657-1-blfizzyy@gmail.com>
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



On 26/02/2026 20:32, Ajit Singh wrote:
> Add GCC_SDCC1_AHB_CLK and GCC_SDCC1_APPS_CLK gate clocks.
> Required on platforms where SDCC1 is used for eMMC.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=a3cc092196ef63570c8744c3ac88c3c6c67ab44b
> 
> Signed-off-by: Ajit Singh <blfizzyy@gmail.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  drivers/clk/qcom/clock-sc7280.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
> index 7b6ed826023..acdaccf7462 100644
> --- a/drivers/clk/qcom/clock-sc7280.c
> +++ b/drivers/clk/qcom/clock-sc7280.c
> @@ -155,6 +155,8 @@ static const struct gate_clk sc7280_clks[] = {
>  	GATE_CLK(GCC_UFS_1_CLKREF_EN, 0x8c000, BIT(0)),
>  	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0)),
>  	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_AHB_CLK,  0x75004, BIT(0)),
> +	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x75008, BIT(0)),
>  };
>  
>  static int sc7280_enable(struct clk *clk)

-- 
// Casey (she/her)

