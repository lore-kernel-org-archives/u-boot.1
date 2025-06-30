Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B432C8302B
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 15:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2BA3809A5;
	Mon, 30 Jun 2025 17:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uGqZHnLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E1280B9B; Mon, 30 Jun 2025 17:56:46 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6949F800C1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 17:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4531e146a24so27623505e9.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751299002; x=1751903802; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gXwZxPQKeQw03+xjOhGCICb8On1OdmSMkulGkNCr0hk=;
 b=uGqZHnLqEc/foGcW5qojd6XJlxF4XZ1gVCjICaWP17zU7GZ5ZsKsx2NFPl4iY8F+TK
 xpnPFilcV9cnO164vqDPWuY5awbj9+t+t/RUkjTRjg3wbi5cjQg7F9jo01OUXBice72n
 ZJuUiJ+llBU7r9YwSPSsbrgVuHAeRJiJj4RNGn1hSGLqpwx1AQkTsA+gur5B4NznluJg
 +d6/hQUCse0nWDJ1Js35vibbhtwn9y8ByQ6pgT5XHEKjCYtnCcDs8164wvouo0uGUndz
 DMaEsyyCo0um372M1jr++Ul/kS7AuMbafeT5nDO36AEuI6aLE8jbMSuu9zdhuivMB2kR
 KVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751299002; x=1751903802;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gXwZxPQKeQw03+xjOhGCICb8On1OdmSMkulGkNCr0hk=;
 b=JaSw6yFXrmY6b5GkDdG1YO2z7bAcR4hEvifTlwCS2xOXU6Ni0BFZjCM5FkmKi9L//4
 M0Z2F3eLMWhplY3Dpwt6YTG8NiYmNFc8t/N5i1tXdKX/FXYKDq6oUpUwuTANVE2PQ1Gi
 fwgUqGPylyabJs9LsANOVwRerFQHrvEJS2I21AB/7oPZUf5Q5Q8dQJUjXUYv5UgwjwGh
 mY1bMBCxMxPOls7lqVK3a8OyfxKKOuK9RgTaqjMS79A3+UCyhsubTz6MI+Y/wUjz22FP
 nJs3jI1CazD+xloucCuEiWSdkjefs5kQILkP7jIJn/qO6E/DlivvJySgVbpgb1IEy2y9
 hz0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwOme9RDasqNsQ/ylwcz1Xxz64kS5M4rNcC0yYVdMxR/w8lXbwV6M+PajyvtINp94xtQHxSuQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxeag9n5NuS/gqPoa1Z+1ewMtOewuu2aPwIKAERPRtlZ7DPtzBD
 qoi0imjqGuzHuP1bZZd69EREoBxjscMIgiLjgatCOavdxMy78BJho4OYNWUDIaG8B0Q=
X-Gm-Gg: ASbGncuklcOXkuipOGWZ2y5dscmQgRB2ru8Xji22ii/7g4LNwRYMIvFRXgX7C4xWiLY
 gSPt9CXVw59X2Z6Els+obOY2VSIXC4pc3h68/oyBBLHtuGcVZuhElVzsFI1pMwFgrNEP6F1WZBq
 tSO47dNuUIpsZMNrPV2uW2E1qg7HM/P6KsRohD3GrfuUna6MjxcN/h3TDjpt+Awzo2SMZ0Df9Kb
 aeepk80WhECmCMg+dhwYbngQWuIxH4IHTSgM4hQiVJIageOdtnd5m/S2JlmtsQgoL4SDZWwI2Gb
 ROEIue85RmtLQvPYNYbXJx6oTgSz7YM6SrZ+jWMHHKJ8KxGSX4pi3pIT9seiBkEKgmPqQod/61k
 +MNcZy4nJWqbXOIXR9KC0zmZ1rf8=
X-Google-Smtp-Source: AGHT+IE3vPKDPcSomNyJM/R8TiFBtXjADwbxGuXc0s8r12jr3h13PGRCrisual6t6kYzN1JdDyxnaA==
X-Received: by 2002:a05:6000:250a:b0:3a5:1f2:68f3 with SMTP id
 ffacd0b85a97d-3a90b6dfac9mr10118061f8f.46.1751299001774; 
 Mon, 30 Jun 2025 08:56:41 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3d10e.dip0.t-ipconnect.de. [79.195.209.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52cbasm10898438f8f.62.2025.06.30.08.56.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 08:56:40 -0700 (PDT)
Message-ID: <537cb674-3ba4-4b89-9ef5-86e430bd32c9@linaro.org>
Date: Mon, 30 Jun 2025 17:56:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] configs: qcom_qcs9100: Fix fastboot buffer address
 for QCS9100 board
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 quic_varada@quicinc.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250630070040.734486-1-balaji.selvanathan@oss.qualcomm.com>
 <20250630070040.734486-3-balaji.selvanathan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250630070040.734486-3-balaji.selvanathan@oss.qualcomm.com>
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



On 30/06/2025 09:00, Balaji Selvanathan wrote:
> The default value of CONFIG_FASTBOOT_BUF_ADDR is 0, which causes
> NULL pointer dereference during fastboot commands.
> 
> Set it to 0xdb300000, a safe and sufficiently large region in RAM
> of the QCS9100 board, to prevent crashes and ensure reliable
> fastboot functionality.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

fwiw since you're using the default environment
(board/qualcomm/default.env) it defines an alias for the fastboot
command to use a region allocated at runtime (which is tracked by U-Boot
and guarunteed not to overlap with anything else). At the U-Boot prompt
just do "run fastboot" to execute the alias (which expands to "fastboot
-l $fastboot_addr_r usb 0")

Ideally we would get rid of this workaround and instead teach fastboot
to prioritise the runtime address from that variable if it's set.

Hard-coding the address like this could cause issues if it happens to
overlap with some LMB allocated region.

If you have the cycles free to fix it properly I would be very greatful,
but I'm happy to take this in the meantime.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

Kind regards,

> ---
>  configs/qcom_qcs9100_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
> index 10ff4d25398..5b6475dcfe0 100644
> --- a/configs/qcom_qcs9100_defconfig
> +++ b/configs/qcom_qcs9100_defconfig
> @@ -15,4 +15,6 @@ CONFIG_DEBUG_UART_CLOCK=14745600
>  CONFIG_TEXT_BASE=0xaf000000
>  CONFIG_REMAKE_ELF=y
>  
> +CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
> +
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"

-- 
// Casey (she/her)

