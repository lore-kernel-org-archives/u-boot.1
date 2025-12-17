Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB387D65559
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 12:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A13A839FA;
	Wed, 17 Dec 2025 13:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MURCuYaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E3CF83B21; Wed, 17 Dec 2025 13:41:45 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E401D83979
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 13:41:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so3384970f8f.0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 04:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765975302; x=1766580102; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X2pixzsEAXGp3h/d6CVs1Trq43EtXDzyaDpeGJDu4xI=;
 b=MURCuYaVkxBAHIYF2AvSp6vnqeen2s73570KOWAAzMV/W8bddQnKLglTTfT2eGLcPF
 b6/PUolpE/jU+ubCaKhjUvEQDSx9sWFPF5Nn71NTZTASmlKh090jciajbDZKtX80uBb5
 kC8RojqwDCsrkWqyeYFCqYEpalUbQV0ayNiMEg7ryxZ46k2wWj37xTLVyLiyDrzOlc0q
 eEg+RPzp2i9vPFcEb3Fi7o8x79AaxYsatE0RiKahnM+uAG/OUh1iLbptY3VtuLkvYeFv
 11I2oriikl+wXyhxSe72735xJ0uRLA/RYfsmsn6muGiwEHJOJagmlmHg25fOB6HfbbYF
 J6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765975302; x=1766580102;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X2pixzsEAXGp3h/d6CVs1Trq43EtXDzyaDpeGJDu4xI=;
 b=a6jx8Pnaw26ZuI3QeD1Pk2/vB5Yq+K1xRLbmXLk8nVqGgMBCEu/gs/njXjP0XuhEl2
 DUQ0vAKzNpiTStXAIfePl7sak+ZPHp/TTz0SfDgZ2zyiUlJBy0wzWtQgxBK8CCqhQwKU
 9Ps1U5R6ohXnlq7yNaOgJf3cwfFKSlBP+vSDIGRuzdeUdWth5SfuXK9lIRooR3zLoSFV
 quUk0FfjxuGNWHfX9ij+LXxdA7jHUGkX1LAAwWduvsd8gQC3BtpZkLuRKxnOpO0ARRIZ
 /7W8CjFfJ0Pz0FpGqoCpBjJlrwapJJzOJHWwdeA0DimnuQegFUrQcVsnHwFkGbfd7f9z
 iE6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrdbmzKdjudoK9m8rRUWmShsCsVoLFUaXqYb+XFcBu6k8H+2MYn6ZvjLfumtM7b0DkaKkLJ7c=@lists.denx.de
X-Gm-Message-State: AOJu0YyXlH6RVoz4d5c7zg9KNp1EFPtE0h7O9InQosQOsItnmtvTspzD
 Uj1EDWARkyoMTJU8qAr+09LTjTWrRtfMBKUht0CWIdnf4UiikHhfhRJqKgaYFOrTLrg=
X-Gm-Gg: AY/fxX4KLfO/TNJdIQPf3RzFnNVVMwzYe1te3c6qLZhCTKNnQkK2gSQDa/1Ou0V/lcn
 fs4T3EAyIbNKnLLCsDKOToj+C6gQlxEgvgqwLu5FjKlbYZCADl+6xaUXhXBmjdL00LTJRmQwJFf
 8aZmKRj+7jze2G3xe58UZNITjVgSSBxVKoKXZTuChC3iYqr+U+P6IK8fJOcuI/6fj9lnj3/RUts
 BYu1Lt68IhWFUfG57e6A/olVQDYl/OeG4lhwBmMUycDXFkmzfLM5FIQNYpl68rupVsdm+BPkTwR
 oGZCk0hFTWVd+LSYvYwkX6J3C+z1OElZuZDdREdGpJOdkVPlI3FOW7si931ivK7ly3coSrb1weY
 yfvmwoxldxhCkhPuRmzx+dTF9a3ZEXz3eAZk28yJhwDBcYRG3De/iFkiXfGfv2Wgg3Wfn7/Vzzj
 Y26DGGrLPZkeSZ8oj2mqTNYqbvhcfj1xRgTs48+GYaSJiT5Xh2ql7QGdUzPbNTFKQigcrk
X-Google-Smtp-Source: AGHT+IHUb/ABHMrRMhKi37RXptEmcIOkfhNcbxanBuKURDEcX/ZYdb4qh1TCgTqPzP81Z0r56g7axg==
X-Received: by 2002:a5d:6941:0:b0:42f:b707:56f0 with SMTP id
 ffacd0b85a97d-42fb7075b96mr15600670f8f.37.1765975302263; 
 Wed, 17 Dec 2025 04:41:42 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1236:7c01:43a2:9012:56dd:2d0c?
 ([2a0a:ef40:1236:7c01:43a2:9012:56dd:2d0c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4310adeee5dsm4772271f8f.30.2025.12.17.04.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 04:41:41 -0800 (PST)
Message-ID: <f88cd0fc-2a93-4f17-9ff4-5b916e614fe9@linaro.org>
Date: Wed, 17 Dec 2025 13:41:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: Add MSM8996 support to Qualcomm QUSB2 phy
To: nathbappai@gmail.com, u-boot@lists.denx.de
Cc: u-boot-qcom@groups.io, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 bhupesh.linux@gmail.com
References: <20251207184919.12202-1-nathbappai@gmail.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251207184919.12202-1-nathbappai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Biswapriyo,

On 12/7/25 19:49, nathbappai@gmail.com wrote:
> From: Biswapriyo Nath <nathbappai@gmail.com>
> 
> This change is imported from Linux driver and tested with SM6125 SoC.
> Note, the msm8996_phy_cfg struct is same as sdm660_phy_cfg but
> qusb2_phy_cfg::se_clk_scheme_default differs only.
> 
> Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>

Thanks for this! Excited to see sm6125 support :D

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> 
>   drivers/phy/qcom/phy-qcom-qusb2.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
> index d98f6108..9e821365 100644
> --- a/drivers/phy/qcom/phy-qcom-qusb2.c
> +++ b/drivers/phy/qcom/phy-qcom-qusb2.c
> @@ -224,6 +224,18 @@ static const unsigned int qusb2_v2_regs_layout[] = {
>   	[QUSB2PHY_INTR_CTRL] = 0x230,
>   };
>   
> +static const struct qusb2_phy_cfg msm8996_phy_cfg = {
> +	.tbl = msm8996_init_tbl,
> +	.tbl_num = ARRAY_SIZE(msm8996_init_tbl),
> +	.regs = sm6115_regs_layout,
> +
> +	.has_pll_test = true,
> +	.se_clk_scheme_default = true,
> +	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
> +	.mask_core_ready = PLL_LOCKED,
> +	.autoresume_en = BIT(3),
> +};
> +
>   static const struct qusb2_phy_cfg sm6115_phy_cfg = {
>   	.tbl = sm6115_init_tbl,
>   	.tbl_num = ARRAY_SIZE(sm6115_init_tbl),
> @@ -450,6 +462,8 @@ static struct phy_ops qusb2phy_ops = {
>   };
>   
>   static const struct udevice_id qusb2phy_ids[] = {
> +	{ .compatible = "qcom,msm8996-qusb2-phy",
> +	  .data = (ulong)&msm8996_phy_cfg },
>   	{ .compatible = "qcom,qusb2-phy" },
>   	{ .compatible = "qcom,qcm2290-qusb2-phy",
>   	  .data = (ulong)&sm6115_phy_cfg },

