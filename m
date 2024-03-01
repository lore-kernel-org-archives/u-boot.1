Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C037C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 16:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BBC3878A1;
	Fri,  1 Mar 2024 17:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hggJMRZY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 843F387CE8; Fri,  1 Mar 2024 17:04:11 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 241AB87837
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 17:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412c34e84a5so10055245e9.3
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 08:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709309046; x=1709913846; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mxGOxni6YaLQ+y09GGqvYsrKiKGJFWbgzD3YGucNQKk=;
 b=hggJMRZYruSRwufsTryEdzuKDdHDYhV+VyRWIuvgpww2vis4YTrJE/UsuA2mvJD9GG
 kt3lXDk3am4QQv/eorGC/fRSPOEHdh2AHsXasb09WVFLEh7AmIe2+ebNoGoTIa9ovV/8
 JMGJxUri1Ph8zfgJ5Lr1T9HWWiukTtAAQYgxmYh7bEFY6dHyah5I8ZaVw4K9psYQlqE6
 rjkfotEUPEUEFCKFCkAlm2SL/WRDTnitPpKVzSyxH+OyzhSU9CnanZeb95fQEhlCh+lV
 spKqh0lCK2V1ActPM4lhIL83ls50CHHKvKgToe/m21pMZaHfTtusdZ+QY9VuWcv5NQ9f
 mhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709309046; x=1709913846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mxGOxni6YaLQ+y09GGqvYsrKiKGJFWbgzD3YGucNQKk=;
 b=gSx14OZx6BXvnjUh4vu9Ex3dfeLc9wAvqkxp5WwPhDFyrNk4gCDFGpWpnHbER6Zh/R
 nd57qEuAKonQ+EA2aJ2Xp3z7ehFBoi+Vm6eI6q8XDq2YQmGQuroKCKE2Yl4QnArqk5Nx
 d2tteHOPGIIFVr1+afJfNDhjykI1fiVBym55qq1h47m7K0R+MC6QohNqJy8VZjm6MqfJ
 YYlkEjoxlSXftlg8z8KW1sKvAnZLDtpSNIUyLxDuJ42e6o/z0G7h36cNPOT/LITSGSB4
 1QGC67dlnb0bmeUAL+mMw+IvG8485PeGv4QFeKAHVbASKwxCFjtQkA7Zw8gYJVjH/FCI
 9hZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTiW0x4bPu3VBcTyYfBTex0zSZrzj2ldP5EJ6C8/+OnRceSqnivwqO62q+t7Ei2463QdBwkCbDdUFXgJxLIjOTRGfeCw==
X-Gm-Message-State: AOJu0Yxfw7QE3MZtufQWXY9usvA3iuiPy5/xoaKpTGtQ1IDcd3b+kFiY
 kJhrn6TCXjsbw9Z6awZckr1gKbC8sFHeZIwTlMnSbDMSzTDS8hnYYaKtB1Uu17Y=
X-Google-Smtp-Source: AGHT+IGKXsi8LxPxhEREPdZjEgn1LM3flpzHhrjUdEJdpXz0RASNNRXWUzfTEdBnIsKCBCsykdw2PQ==
X-Received: by 2002:a05:600c:350a:b0:412:cb58:6b20 with SMTP id
 h10-20020a05600c350a00b00412cb586b20mr757705wmq.7.1709309046501; 
 Fri, 01 Mar 2024 08:04:06 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 m26-20020a05600c3b1a00b00412cbe4f41bsm856067wms.4.2024.03.01.08.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 08:04:06 -0800 (PST)
Message-ID: <3ac7d46c-a4fc-4609-ab22-d63291ae0343@linaro.org>
Date: Fri, 1 Mar 2024 16:04:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] clk: qcom: clear div mask before assigning new divider
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
 <20240229142043.1263690-2-volodymyr_babchuk@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240229142043.1263690-2-volodymyr_babchuk@epam.com>
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



On 29/02/2024 14:21, Volodymyr Babchuk wrote:
> We need to do this to ensure that new divider is applied
"The current behaviour does a bitwise OR of the previous and new divider
values, this is wrong."
> correctly. This fixes potential issue with 1Gbit ethernet on
> SA8155P-ADP boards.

Wow, that's a subtle one!
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Small nit with the wording, otherwise

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> 
>  drivers/clk/qcom/clock-qcom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 7c683e5192..729d190c54 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -117,7 +117,8 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>  
>  	/* setup src select and divider */
>  	cfg  = readl(base + regs->cfg_rcgr);
> -	cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK);
> +	cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK |
> +		 CFG_SRC_DIV_MASK);
>  	cfg |= source & CFG_SRC_SEL_MASK; /* Select clock source */
>  
>  	if (div)

-- 
// Caleb (they/them)
