Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9B3C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 12:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C0DF80F95;
	Fri,  7 Aug 2026 12:40:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E_0m6IUmAFC9; Fri,  7 Aug 2026 12:40:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C0D780E42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786106434;
	bh=NMV3GGNj/cvZADcvQZ0ITKw6KYSBrO+K/iB82WVal4g=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=S3mUgyHLTTh772QWuntC9akMI3ixQy4QrMxmoTdP5OeYrNw7D+ka4CLby9es+GG9Z
	 kCe89uL4emWSl1UkDQ/N/w22iA+TUxzO5ZW2Cmu/VI807MddW6w9I0OdFliDkLbNBe
	 tEPa9nZqDXxFdtdmCiJ17M3gMMVYJmJAQBZ1ZP9X9EPHK3409uHvRm2vfs5l+H/y7b
	 J0nfNfnirv/2wcZUACAHYnRJ3WYI6EnxpJwWkHDuqzooSylGuOgJk5MTL/ZsGMHxji
	 pLfO/pPipThu+lKJVJrV6yMVIukxivsZk8RP+ShPDq0GudIWpllSEtSnUwEUOIscdO
	 2vv7CnhoJUuBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C0D780E42;
	Fri,  7 Aug 2026 12:40:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DF25D198
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C4E2380D48
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:40:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 91D4UT0rtdx0 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 12:40:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8B9EB80BD7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B9EB80BD7
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B9EB80BD7
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:40:31 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4956869750eso24496555e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 05:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786106429; x=1786711229;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NMV3GGNj/cvZADcvQZ0ITKw6KYSBrO+K/iB82WVal4g=;
 b=P4fr/bmauRqNqTm2ETkyGDJqBM2V9ZwY956H2lqvGlcctHQhOLABgdFIuLcmVwjm2q
 caN/1RtuDT6lCApBWeiAvr/bLwNyPihFrH+j5l2UmlLAta/vEvLtoduG7fVJChubH0J5
 14zEzVhjvt3zvDU/BMpZfZD7KWR1iVfHHY9Lv/tO6k0tLbL3ulZszOU14SW6Ra/1PTtp
 TEC1NRUZSTwcyhJB8lVFzL6YH26Ay2WDKFeBuDbFNUBdScU2WR3QBtVnVTTPDICkOxn4
 g98hVEfT0n3txJJiHV6U/0O+I73N3Rx+ad2f7YHPCiJer1tY6y2UrTkDalZCcJwehAIA
 p+TA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrx9IWdHX9kfWteReC0+NQ9VUVh7clXs2QOLQM1deO7yMnbStmmPGf2lNgtOTyiCXVrnzn8AcU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxdCb0vqIMnfQ/YZZZnvFmseF/y/CTTkUpfG9kSzYkX55me9kmz
 Ev5OTfloFy/bT2BFifVFaKRVU9K5BF1QOLNIJ3cxpS/OQoDaPnabbc6ORvi4W45bn/4=
X-Gm-Gg: AR+sD11kIFAFfl0LFnWZsG9nyO4WocgNB8EjoevTeOO4HjupyEGOGquDK0B/EqtjTDH
 3Ja9S7uxIIPHZV9LoGiYlS6xJh39Y4vX2KDag8IYOEkooyibb4TeNhc51bFyyWqUNWYYrVpT3en
 VMtA48r9aOWI8nyirxiF/BA/ZK3M/atQIp+gcx5UBBo54DhWm4sGL6CBEvQdKnuvF9RTS81gmrB
 v5ONJ3Wu82g11fbycYhXQkB4oLkZer82Xddt8TGA9KSJikuqSiqKgHylUa8uhP5Q7oWTeUmnCde
 NZVlqKv387iZolnZdqWXI01reKYqGKXjJL/EjNsMcn32P/Gmb/Qyh9Sx5zrvScMXQCwMc6gfouw
 hf762Ms1MEXkh2umAfzlsmwYofe4fN3/A3kuLjLyAvT6Le/M1A5XLfieIjzNcCdEW5Yvk/wlQvW
 JpwG0BoAti3D32qpI5oU/DUKe341H1a5uuaqghx/2YpO2P+PQvNE/IelJ482Cl0jiW2CwdIbKKp
 PZRrR+c+BsFfL3MjML0enN+FvCik25KFj5XXhbFLQBo
X-Received: by 2002:a05:600c:3ba2:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-4994e794edamr283424385e9.2.1786106427509; 
 Fri, 07 Aug 2026 05:40:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:66e6:6f30:5a76:1cc2?
 ([2a01:e0a:106d:1080:66e6:6f30:5a76:1cc2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9f0230sm32793455e9.6.2026.08.07.05.40.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 05:40:27 -0700 (PDT)
Message-ID: <e3976d91-6163-44e9-b8eb-ea27f4b6211f@linaro.org>
Date: Fri, 7 Aug 2026 14:40:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/7] clk: qcom: Add dedicated sa8775p RPMH clock driver
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com>
 <20260806-b4-monaco-v1-1-8d7b4e2f4fe1@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260806-b4-monaco-v1-1-8d7b4e2f4fe1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786106429; x=1786711229;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NMV3GGNj/cvZADcvQZ0ITKw6KYSBrO+K/iB82WVal4g=;
 b=WZUTRNtPVZ4EATzexSZzyOdC+l8bmwF/3oQIPUj2lbV16LBDae1Ego/gacKf8BgKwh
 jz93cyAs5o7bUVFmPtj1mGtZIITzuUWheMLJ/Hxse6KSJfQQ+hb9ldJakbPWn7J/GX+D
 XmOHGgUa4Zg3c6P1lgLGyE1rmalGsAbdP4127eOROZ/tRQHpsS5+9j8aaZM77rbUXldm
 Lt3ffnG/EfOnZC7vvLGHT0CnH7r2YACpi8UdeXk1O70UoalAsOV2NNenBHMv34IXt2t3
 AWsRvSJp2d3eAHqq7AOC53r7GCRVXEve85ECxOt9e7InBebRMQCz/vk9dHEpFG6uTuVO
 V2mw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WZUTRNtP
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/6/26 18:12, Balaji Selvanathan wrote:
> sa8775p was being handled by the generic clock stub, which just
> no-ops every request. Give it a real driver that provides support for
> get/set rate.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/clk/clk-stub.c           |  1 -
>   drivers/clk/qcom/clock-sa8775p.c | 46 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index 4a6c71016da..f7d42892423 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -51,7 +51,6 @@ static struct clk_ops stub_clk_ops = {
>   static const struct udevice_id stub_clk_ids[] = {
>   	{ .compatible = "qcom,qcs615-rpmh-clk" },
>   	{ .compatible = "qcom,rpmcc" },
> -	{ .compatible = "qcom,sa8775p-rpmh-clk" },
>   	{ .compatible = "qcom,sc7180-rpmh-clk" },
>   	{ .compatible = "qcom,sc7280-rpmh-clk" },
>   	{ .compatible = "qcom,sdm670-rpmh-clk" },
> diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
> index 7eec4aeae48..49b94078a41 100644
> --- a/drivers/clk/qcom/clock-sa8775p.c
> +++ b/drivers/clk/qcom/clock-sa8775p.c
> @@ -13,8 +13,14 @@
>   #include <linux/bug.h>
>   #include <linux/bitops.h>
>   #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
> +#include <dt-bindings/clock/qcom,rpmh.h>
>   #include "clock-qcom.h"
>   
> +#define TCXO_RATE	38400000
> +
> +/* RPMH_CXO_CLK = bi_tcxo_div2 on sa8775p */
> +#define TCXO_DIV2_RATE	(TCXO_RATE / 2)

Actually this is valid since SM8550, so perhaps it should be a separate standalone driver
for sm8550/sm8650/sa8775p...

Neil

> +
>   #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1b040
>   #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
>   #define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
> @@ -275,3 +281,43 @@ U_BOOT_DRIVER(gcc_sa8775p) = {
>   	.bind		= qcom_cc_bind,
>   	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>   };
> +
> +static ulong sa8775p_rpmh_clk_set_rate(struct clk *clk, ulong rate)
> +{
> +	return (clk->rate = rate);
> +}
> +
> +static ulong sa8775p_rpmh_clk_get_rate(struct clk *clk)
> +{
> +	switch (clk->id) {
> +	case RPMH_CXO_CLK:
> +		return TCXO_DIV2_RATE;
> +	default:
> +		return clk->rate;
> +	}
> +}
> +
> +static int sa8775p_rpmh_clk_nop(struct clk *clk)
> +{
> +	return 0;
> +}
> +
> +static struct clk_ops sa8775p_rpmh_clk_ops = {
> +	.set_rate = sa8775p_rpmh_clk_set_rate,
> +	.get_rate = sa8775p_rpmh_clk_get_rate,
> +	.enable = sa8775p_rpmh_clk_nop,
> +	.disable = sa8775p_rpmh_clk_nop,
> +};
> +
> +static const struct udevice_id sa8775p_rpmh_clk_ids[] = {
> +	{ .compatible = "qcom,sa8775p-rpmh-clk" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(sa8775p_rpmh_clk) = {
> +	.name		= "sa8775p_rpmh_clk",
> +	.id		= UCLASS_CLK,
> +	.of_match	= sa8775p_rpmh_clk_ids,
> +	.ops		= &sa8775p_rpmh_clk_ops,
> +	.flags		= DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};
> 

