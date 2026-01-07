Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC97D0D17C
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 23:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D337840A9;
	Thu,  8 Jan 2026 00:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QlK3M8Yj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D4584047; Thu,  8 Jan 2026 00:16:06 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7F6283A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 00:16:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3e8f418e051so1823847fac.3
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 15:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767827760; x=1768432560;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Z0UUeqwyGczgG1eDlRJjrIVFVMSukZnD/dO0TwuV58=;
 b=QlK3M8YjMcPYyEBbZvUYApse1XCAiJ8lF9wDVN2OMUeMqjk23BHTKFl7pxtD4Izxpv
 vbvSfIdkmsitAIBWwUsu7PndoMCR83rlpfaRN/ATveKYgKBtZKYNUViyh1uMLLoIvLSc
 Kpwwal3KRMSO5CSzw3ugk6cRPAMOKlo1xs1PLd9pj2d7Sm1ehQyejRtQiYtL01Atmu4O
 b+FHjR0AL7OBgJNOptMJnzToErLU5ZhtGoE0IR3K0MkC9CFhGs4NnHmKMLMpwRbeidAz
 uCDYepb68vWPCh69AKgpRV2PgFDdgMWUSQ73Z/IMYnNQMGGQP8hSsKPTe7exlc0CFZ3X
 0VjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767827760; x=1768432560;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Z0UUeqwyGczgG1eDlRJjrIVFVMSukZnD/dO0TwuV58=;
 b=e0ew7fLSmcGhTWVAOzLTuybXAce9RFP8YADS1IUeTcPdQhObQ9Rk8qkYDsyiumqCBK
 NZECYwDRlUdJHpKa9Ik5TaB2/zj9EW9qMkZ2OG1HtYac/B0rVici6o340lHCrAuO8HBu
 KGqMZXM48L+svqMgpgTMuwGcgV+Ie/vbIizHWgODVJw6UsDYpsjby0hmBPTmtdWFNM/R
 B2CmXum+0wLDczX/9AANDdKwXnKlay2X57RQ1lAvlhGxzKQpUAVkYeaixj/kjAzg9+84
 nCZ005sUI+MwpZSIyJy/uaSVxGdrHdDeCsVCyjDfoDzgTsl5jNF0OV1m3MClrLkq/13Q
 LvYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZzMVpYWrpPYZZHlPCzFtQf4FoxVgChqmXt0BvP43CrQbTqucQ/pSt86XwIY7CG7NqitX3pt8=@lists.denx.de
X-Gm-Message-State: AOJu0YwOHlXAjMXkHqcIvCtNbeQmwbd50g5ZFj8Ii07+ce+f/7Oppy5T
 oSsBg3Nag5Yu6xVO7slCkYk5f1yzzsYhPrtPEZiHdBLjhuQTUaCTfpndburL3Fo+a6k=
X-Gm-Gg: AY/fxX7lzb/5xVHqdAWEOC2HUZ0UvA5Rj74/rvZDE4XO60gT+xLuAKlZ6m15a00Nexz
 Lhv9GVcMUm7UjS9Tn7Fxh5N4YDtqPUaxji5EjlGYistIvWl94yNUWNluHcMKjCMtIY92azBE/U2
 EZYn5LuXeApHqLNzfLNMpabN+9TrCzTg1dt9gkaYL3DgZIaYGB8n9ch0fR4YpJ6zS9v4C63fCvK
 folUbRqJzWquwuTt53bdIzebD4x/+MNIHpwO2CPvzJRujAXEZAgCBn0Vq6BC7ZYwmZY6EXaE0bo
 aNDzbPMoVl/lPJCAVd6iEBSXHJBxMZfWd2NpNwnMOrQ+TShAUwSSbBkazGRnIT/nx9STlsnVbbC
 ub9eY/3l0lAwq2Z1iNPKiUiSqM/49Gi0ktKjNvehb0zC7URrfvXPRfw2h8CIJ2r3MevuiHYurvw
 q4tjzCmUvN1N782lEJ2vz5e+3PzKu77SbZX2rhkpZaeWl2urTVZdQBzPHALil6
X-Google-Smtp-Source: AGHT+IElQdjxPL/FyxpR+pwU6IkzS7THa0AI4zds1FOn/8XBjXAe9ON2zKGwnW4dtOGQytBemfNk/g==
X-Received: by 2002:a05:6870:b00d:b0:3f5:484:7442 with SMTP id
 586e51a60fabf-3ffc0af6e26mr2200114fac.32.1767827760029; 
 Wed, 07 Jan 2026 15:16:00 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:f278:961a:494a:41af?
 ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa50722e9sm3990116fac.14.2026.01.07.15.15.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 15:15:59 -0800 (PST)
Message-ID: <043974a8-4eb6-4b8e-a0e6-77cb37f3dd43@baylibre.com>
Date: Wed, 7 Jan 2026 17:15:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] pinctrl: mediatek: support mediatek,pctl-regmap
 property
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
References: <20260106-pinctl-mtk-mt8365-v1-0-0ca3eb382468@baylibre.com>
 <20260106-pinctl-mtk-mt8365-v1-1-0ca3eb382468@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260106-pinctl-mtk-mt8365-v1-1-0ca3eb382468@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 08 Jan 2026 00:36:38 +0100
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

On 1/6/26 4:05 PM, David Lechner wrote:
> Add support for the mediatek,pctl-regmap devicetree property to the
> common MediaTek pinctrl driver.
> 
> In upstream devicetrees from Linux, the pinctrl nodes may be on the
> interrupt controller register address space rather than the pinctrl
> register address space. In this case, there is a syscon node linking to
> the actual pinctrl registers. This uses a common property name of
> mediatek,pctl-regmap for the phandle to the syscon node.
> 
> The logic here is that if this property is present, we look up the
> syscon node and use it's address as the base address of the pinctrl
> registers and ignore the pinctrl node's own reg property. (Support
> for interrupts could be added later if needed.)
> 
> There is also at least one SoC in Linux that has two syscon phandles
> in this property. This implementation support parsing this, but doesn't
> do anything with the second syscon yet (the 2nd syscon is for interrupts
> which we are saving for later).
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 38 +++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 4aecb84504a..0483d532800 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -809,9 +809,47 @@ int mtk_pinctrl_common_probe(struct udevice *dev,
>  	fdt_addr_t addr;
>  	u32 base_calc = soc->base_calc;
>  	u32 nbase_names = soc->nbase_names;
> +	int num_regmaps;
>  
>  	priv->soc = soc;
>  
> +	/*
> +	 * Some controllers have 1 or 2 syscon nodes where the actual pinctl
> +	 * registers reside. In this case, dev is an interrupt controller which
> +	 * isn't supported at this time. The optional 2nd syscon node is also
> +	 * for the interrupt controller, so we only use the 1st one currently.
> +	 */
> +	num_regmaps = dev_count_phandle_with_args(dev, "mediatek,pctl-regmap", NULL, 0);
> +	if (num_regmaps > ARRAY_SIZE(priv->base))
> +		return -EINVAL;
> +
> +	if (num_regmaps > 0) {
> +		for (i = 0; i < num_regmaps; i++) {
> +			struct ofnode_phandle_args args;
> +			struct udevice *syscon_dev;
> +			int ret;
> +
> +			ret = dev_read_phandle_with_args(dev, "mediatek,pctl-regmap",
> +							 NULL, 0, i, &args);
> +			if (ret)
> +				return ret;
> +
> +			ret = uclass_get_device_by_ofnode(UCLASS_SYSCON,
> +							  args.node,
> +							  &syscon_dev);

I did not realize that this is not robust against probe order. I got
lucky during initial testing, but it is failing now that I am working
on something else. So I will need to find a solution and send a v2.

> +			if (ret)
> +				return ret;
> +
> +			addr = dev_read_addr_index(syscon_dev, 0);
> +			if (addr == FDT_ADDR_T_NONE)
> +				return -EINVAL;
> +
> +			priv->base[i] = (void __iomem *)addr;
> +		}
> +
> +		return 0;
> +	}
> +
>  	if (!base_calc)
>  		nbase_names = 1;
>  
> 

