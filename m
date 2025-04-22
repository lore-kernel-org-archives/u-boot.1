Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A30C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 17:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 142A781273;
	Tue, 22 Apr 2025 19:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KzXg5/Xs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D48A8144A; Tue, 22 Apr 2025 14:46:23 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 488B081273
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 14:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so38119185e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 05:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745325981; x=1745930781; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7m5BYuOJhJu+kjddaKZcD2WF0+TS+J+6tk6nh1rDsvk=;
 b=KzXg5/Xs9ZgXp0cH0+Hf0hr5jBj/DAD7KLrDVxeTpavdTCr+7YBC17PbikUv4VCpit
 fZkyuoprkOp6ffr+KpUNqN3CFf/dRdgnZe0CSrknXM0+ctFHwdrcLHQM8xcjlBIJ4AY+
 xGn0HH5mvtU5I6nIgTGPq46vxuB1vfOOu0EMT3yuLoArbptFgYCo4Eh1d3RDC6lwXkFJ
 hpOhxv8I3H0fAi/IfsNGg0DrUR/3pV4iJpyJWmGbaEBxnYE/52Zdps7tySd/PoOD/yDv
 iQKswHJLq7Pp4K+sHe316x0rA4QEYyvVXGV087F/C5b4G59KRX5pOXk8gj5YmHVatt4g
 kQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745325981; x=1745930781;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7m5BYuOJhJu+kjddaKZcD2WF0+TS+J+6tk6nh1rDsvk=;
 b=tzULIu8Z04dPnvTS0Hg9oUHCGcz+1GYd019BpDbjcQ54KT9vlhypT+vyIIRtNTf3BQ
 lpRT43+E6Qnu8NtpdRNDLjNyN+5KrFM4zo3evR2KuQy0PLtOzp9gqw7it+wS4/Gvunc+
 dcJaqVmob5XwGc/gwm+GPkjZBoANse9qFIAN965ASrcOO2oLTwwhvBPeJNSMsHVsvONg
 KLhTbhoR+KjaDNQqVeEAQaBfKxATZIBarPuAhu8AethBf+MtvYmnq4S2W6hEsocLVJRE
 swPhseOfqVLcpijJJHTIhNsjyKL5M6vPzuZ0MSSi5GpYKIpITlYd/GIiMethNOqcTPfC
 7NhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC2ykrpzdNK9XuH2B9J+4bnUGmcOSa2T+gSZ1ahcNdsIOS7Izm+iq3I8jklw2yChck0TDQF3w=@lists.denx.de
X-Gm-Message-State: AOJu0YxO3VT39kMGG+hW/b8NS/827ahk6nGl3RXc+r/KoFACyXOnhWvJ
 97YGxnhea49WdK1kqvWCZBqYH1eRjF7F4GsRqocr2arzp8N3X2EgEs86LDjIFzE=
X-Gm-Gg: ASbGnctv604Dm+aIOCDaOfz/b5OSP+JnFNsaEqUzQyadeE8sqdvlf3eHueNNGFQ9pL+
 8bSo3m6knVvTOhgKL3Hm7zOAy1vOBaKeWNlNBqCIwg3KOkROSO10AbkRkZzjRUfR6FcSUc+5M28
 T/TAJk+/u1OkU5AmNHcmwjFvBD6ESMY416BZzyGn1miAg3DkzUEB9qnUidEjgp8+9XnD7SkYjZ4
 /q9RfdsVMewwL95fj5nEL3N34lGT3aX8lQC7mngvXyrGeFaUbFE2doMAvL/BbL00yETKglg1jdD
 fuv0lYLJU7wtOZEsfqyYjUj0Ob+16mU2jA1O494p87b4HqxHiHnWI0PkaXMpSKPvx+ZO/OLv8VZ
 l6jsMKQ==
X-Google-Smtp-Source: AGHT+IG0HFG0XPxO6sWyWD25DtNsTPAprfnuWqYjhtVRvOV52c2T2ENdDMqTb1xxK//qv9IdjPOmMQ==
X-Received: by 2002:a05:600c:46c7:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-4406aa876a7mr147705745e9.0.1745325980720; 
 Tue, 22 Apr 2025 05:46:20 -0700 (PDT)
Received: from [192.168.1.47] (i5E863A78.versanet.de. [94.134.58.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcb6sm170466535e9.18.2025.04.22.05.46.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 05:46:18 -0700 (PDT)
Message-ID: <e7207669-bc38-41ff-b100-4570f8051855@linaro.org>
Date: Tue, 22 Apr 2025 14:46:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] clk: qcom: Allow polling for clock status in
 qcom_gate_clk_en()
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250422-apq8016-clock-fixes2-v1-0-bfc9dd933da6@linaro.org>
 <20250422-apq8016-clock-fixes2-v1-4-bfc9dd933da6@linaro.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250422-apq8016-clock-fixes2-v1-4-bfc9dd933da6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 22 Apr 2025 19:29:01 +0200
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



On 4/22/25 12:54, Stephan Gerhold wrote:
> GATE_CLK() in its current state is unsafe: A simple write to the clock
> enable register does not guarantee that the clock is immediately running.
> Without polling the clock status, we may issue writes to registers before
> the necessary clocks start running. This doesn't seem to cause issues in
> U-Boot at the moment, but for example removing the CLK_OFF polling in TF-A
> for the SMMU clocks on DB410c reliably triggers an exception during boot.
> 
> Make it possible to poll the branch clock status register, by adding a new
> BRANCH_CLK() macro that takes the extra register address. Existing usages
> work just as before, without polling the clock status. Ideally all usages
> should be updated to specify the correct poll address in the future.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   drivers/clk/qcom/clock-qcom.c | 15 +++++++++++++++
>   drivers/clk/qcom/clock-qcom.h |  7 +++++--
>   2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 7a259db79342c31dfe85220c68c82197861ccdf6..6b46d9db744b87538b796bf729d16785bca08545 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -83,6 +83,21 @@ int qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
>   	}
>   
>   	setbits_le32(priv->base + priv->data->clks[id].reg, priv->data->clks[id].en_val);
> +	if (priv->data->clks[id].cbcr_reg) {
> +		unsigned int count;
> +		u32 val;
> +
> +		for (count = 0; count < 200; count++) {
> +			val = readl(priv->base + priv->data->clks[id].cbcr_reg);
> +			val &= BRANCH_CHECK_MASK;
> +			if (val == BRANCH_ON_VAL || val == BRANCH_NOC_FSM_ON_VAL)
> +				break;
> +			udelay(1);
> +		}
> +		if (WARN(count == 200, "WARNING: Clock @ %#lx [%#010x] stuck at off\n",
> +			 priv->data->clks[id].cbcr_reg, val))
> +			return -EBUSY;
> +	}
>   	return 0;
>   }
>   
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index ee0347d9d86716c09e7f57b343f12b5908f8cb92..28145061844255460e8a6868b69ffe9a7dd663b0 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -52,13 +52,16 @@ struct freq_tbl {
>   struct gate_clk {
>   	uintptr_t reg;
>   	u32 en_val;
> +	uintptr_t cbcr_reg;
>   	const char *name;
>   };
>   
>   #ifdef DEBUG
> -#define GATE_CLK(clk, reg, val) [clk] = { reg, val, #clk }
> +#define GATE_CLK(clk, reg, val) [clk] = { reg, val, 0, #clk }
> +#define BRANCH_CLK(clk, en_reg, val, cbcr_reg) [clk] = { en_reg, val, cbcr_reg, #clk }

The "gate clock" naming is kinda BS here anyways, I think it's confusing 
to have "gate clock" = "enable and run" and "branch clock" = "wait for 
enable"

We should probably rename gate clock to branch clock, but let's not 
block this series on that. For now would you be fine with renaming the 
"BRANCH_CLK" macro to "GATE_CLK_POLLED"? Maybe add a comment that we 
plan to rename GATE->BRANCH and that using GATE_CLK (non-polled) is 
deprecated and the polled variant will be required for future patches.

Kind regards,>   #else
> -#define GATE_CLK(clk, reg, val) [clk] = { reg, val, NULL }
> +#define GATE_CLK(clk, reg, val) [clk] = { reg, val, 0, NULL }
> +#define BRANCH_CLK(clk, en_reg, val, cbcr_reg) [clk] = { en_reg, val, cbcr_reg, NULL }
>   #endif
>   
>   struct qcom_reset_map {
> 

-- 
Casey (she/they)

