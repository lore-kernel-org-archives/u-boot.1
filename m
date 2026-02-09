Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A5FE7E0D5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 19:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC41D83C91;
	Mon,  9 Feb 2026 20:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kW8kn4eK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 334AE83C67; Mon,  9 Feb 2026 20:51:09 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 163A9802C1
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 20:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4832701b9b7so17687875e9.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 11:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770666666; x=1771271466; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IFQrlQ0AgCczVWi/Uue0J6g2rIWHLCy67FKAnbL3Yc0=;
 b=kW8kn4eK35RwFKEU8dDDHIDq+wJzvOkF+onHQ9NqasBuIzpQiafhavzmQOwP4vKhL7
 F0L7chK+ys9jZzEtuyvMfQyZr62VOHE6yCniTIMNx70/C7s01Z6pBVwh2YCVI+AHRjia
 zZeQO5iMNRgnVGdPtdVToMPKJoQEkHT77mHjhkqxGl6ie431s/G0/Zm9UVnzNmLLU9Qk
 MecwdMHYt16Suny+zhVjQ1Pb7VRk43smcN0i14EsZlZjOrHjQAdL5AOwV7w/k+qdOSBf
 QIETyBm9FGk7UJ02PezjmMyfIaEhHuuenMQvtEJC7azOKWFWGCRby+R0k6cmYz3xpcCE
 bspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770666666; x=1771271466;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IFQrlQ0AgCczVWi/Uue0J6g2rIWHLCy67FKAnbL3Yc0=;
 b=i1zPai0JJ6EnwglPrR1AW7TsK90q06H7AzAyCflOkn72J+XVb8yb+gv51fF7y53pA/
 e93bvLv3ZtrCKs6utlD8qHj7eAJL6ox2XV6W9RYMRMAJK7CvV2Rfw/AkW1UiA4zMfWal
 OK555naDnGgb+FP9niS1VKTur6gbliyW5AUMB97AXFPeUcdeuezvNXgBoZfbqgAG0uP7
 v3Inc1BWoREJ4rBTmg1Z3GpOGSg9GijYqCbSxwEJS/rXHPQOo3Z7c+rOUQHIRFsxk7Lr
 AGnrk7yoZ15JfTn6+M4upumBy5whjJU62Uj4Sy77fxJ80ja1wZmm/1nQID1UaafLdrd6
 viuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUWtVp+JgsI6Zkk0vOrvtKpD5ZsSuAM1Z6+PXWlWmbyRDRmx01BArFC6EIm1NcRtXFyRAjpa8=@lists.denx.de
X-Gm-Message-State: AOJu0YxD+CM4AsIyNbpAE3rk3eA6HQH0uyDJv6dozAI4IHdzHfb6o5YX
 lU+z8RNJSKZ/JXvpNR7ID/JAouVJjsC5xFG72Eu1wxdkvaoCWWz9JpolUkVI3qY/V/JYo6MtZMB
 zUXwI
X-Gm-Gg: AZuq6aJvcMVePz8fNDODicLQyhYZf0wtOqBEHa6gsjqfP6Bsfq64E241qtA9Zw9TfQ7
 lO6h2EvsvRcJ8/CxGutpwCoDVWt0IcG+fugqEjdUtjqn1K2t/hsaNzYvi5nI0TpeJuntAgd+zQW
 2iRDzcU64JnAgXHvAkJn5wME2mNUxT0HrFY4hmO7574lQ2IIuK3kUcGU4zMIumlZEQGp386EZrA
 R0K6SLvUW69Bzoqij7KmDrRu61o46+XOSb57X7GBGljz70ZiNLf/YHdJThnEzG1e2gzcz4IbenS
 U7qjZ7guOQh/Wbuqwqe/iQUUGClHz9HIPWUJ3DXPbkblnmVNZqkTj8jj3AJJ+RHzn9IrYSMQLo1
 BFeBZFdO+5vOtrotbz7D7ngNO8oGE72UI1LlxEON9xWqZpURfk40d6Njd4UVhRIs4OEtKkD3BMV
 FMJufOiJjQxV51WEpP4CPSvMSJGI5L0uJTkE4rX7LPF6Wtd/wvO0xdSa0lPzAT
X-Received: by 2002:a05:600c:4506:b0:480:1c53:2085 with SMTP id
 5b1f17b1804b1-48320213830mr150893975e9.19.1770666666483; 
 Mon, 09 Feb 2026 11:51:06 -0800 (PST)
Received: from [192.168.1.36] (p5b29ea02.dip0.t-ipconnect.de. [91.41.234.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7d55c9sm9595355e9.8.2026.02.09.11.51.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 11:51:05 -0800 (PST)
Message-ID: <dc224c74-aa8c-4ff6-9a7d-4629cbb0e14e@linaro.org>
Date: Mon, 9 Feb 2026 20:51:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] qcom_defconfig: Enable SM6125 clock driver
Content-Language: en-US
To: Biswapriyo Nath <nathbappai@gmail.com>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20260204-sm6125-clk-pinctrl-v1-0-9cf4c556557a@gmail.com>
 <20260204-sm6125-clk-pinctrl-v1-2-9cf4c556557a@gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260204-sm6125-clk-pinctrl-v1-2-9cf4c556557a@gmail.com>
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



On 04/02/2026 17:10, Biswapriyo Nath wrote:
> Enable the driver so that SM6125 devices can boot with qcom_defconfig.
> 
> Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index fe5880de1..fc21aa5fd 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -63,6 +63,7 @@ CONFIG_CLK_QCOM_QCS8300=y
>  CONFIG_CLK_QCOM_SA8775P=y
>  CONFIG_CLK_QCOM_SDM845=y
>  CONFIG_CLK_QCOM_SM6115=y
> +CONFIG_CLK_QCOM_SM6125=y
>  CONFIG_CLK_QCOM_SM6350=y
>  CONFIG_CLK_QCOM_SM7150=y
>  CONFIG_CLK_QCOM_SM8150=y
> 

-- 
// Casey (she/her)

