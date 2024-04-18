Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD12C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 23:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E45AF88668;
	Fri, 19 Apr 2024 01:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RGiUouAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B5AF88667; Fri, 19 Apr 2024 01:19:19 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 496E68868D
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 01:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-34665dd7610so731970f8f.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 16:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713482356; x=1714087156; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FLoC0q6l9RmN2lK9IeLgwW4D6JAmWyu9OKKr+Xo2IhI=;
 b=RGiUouAFDiyzs9YZMukeD0+l3i9yNT+Eiwuyq0tHtnLAFTAydYD1NCNrrMlrqXryVZ
 40P9Nf5o5LRbHmXKi5MwWeSkOKReZZbKgcejdJ2KvWYVcoXpjEonRM1BVoBl3gKbzyHT
 lezKdM1QhOs1XkpoTGAd69w8VUm6CJREI5HG22c6vyL2DQFADSJTQ/BDRe/gYJhCAFpn
 mZwOcDbA2hp4bSjfw1J39O41soXYfv/uH3kautrBz2scWTCQYQ6wdGJKlTVuZQmZsEsV
 3GzugzjrGD+yR7DdaizmBXHsiIzo4dGt6QCibvpa+S6EqOjTD/s5VQuCBBNvysS+HCDn
 iV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713482356; x=1714087156;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FLoC0q6l9RmN2lK9IeLgwW4D6JAmWyu9OKKr+Xo2IhI=;
 b=YEwfRWm2Gww8ECyvhKys1cPMF2cbbIXmpIH3+CX3EnBqJQt2J5DKlkgb0IklyQhTOf
 QABCf//yyONd7ViP9vgMPkG8zg2h/Uuv0djDgXT18PbgyOokBmtnSGV/D+cZOgwv/QCV
 SzLZvMKE39Gz5/mWgeKkdN1LoKEI9vL5YCCpJOXVBKpgvENWnb7p+kh0IRUY1suXPDQv
 daze4cDwDVMHTPBfcK/yaz7Qy1IZolF2Kawh7eHlShxRC9iDBGqTdnZoJjrKm4uRJGXF
 oaBJ63lEP7K8iQUhLViEdzRpOI3FcnLz+96ttO7Nc/bf2jpY8fdvIVRuJ311bEe2MbDL
 hitw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlJ7ggZ/FLSd9ffs7RXJurcCrFA9cMqh8q5BOa++52p4CvgwjLSL1AbyfyO622L0j6UZS3oqMTqM8/IUVpw1+lqgGqNQ==
X-Gm-Message-State: AOJu0YwbE0Vi88CqBqYCpQy/ETq3Z/D6hpKRrU5NK/ZTckBg/ZyqVb+A
 jvS+bjdWu4PbozztN4QyfmVEh+nDReUMYKginnmFP48OUVNPlh1jadCI5ohl6rg=
X-Google-Smtp-Source: AGHT+IGMZwZRZ6R1GvhW011zMBwQdPGbaauGFEqHP6Y9SLKHK+FrIMaxMZqMHZREwp8zlZOg5SEs1g==
X-Received: by 2002:a5d:678e:0:b0:341:d912:1fec with SMTP id
 v14-20020a5d678e000000b00341d9121fecmr170416wru.49.1713482355628; 
 Thu, 18 Apr 2024 16:19:15 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a5d6d46000000b003434f526cb5sm2891858wri.95.2024.04.18.16.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 16:19:15 -0700 (PDT)
Message-ID: <d1d12577-d5a2-493e-b07a-b2fca2b6558c@linaro.org>
Date: Fri, 19 Apr 2024 00:19:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] mach-snapdragon: implement ft_board_setup() for USB
 role selection
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
 <20240418-b4-qcom-rbx-fixes-v1-6-f5f19d52969e@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-6-f5f19d52969e@linaro.org>
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



On 18/04/2024 18:25, Caleb Connolly wrote:
> Some Qualcomm boards have only one USB controller which is muxed between
> the type-c port and an internal USB hub for type-A and ethernet. We
> modify the DT for these to force them to host mode in U-Boot. However in
> Linux DRD role switching is supported (required, even). Use
> ft_board_setup() to adjust the dr_mode property for these boards.
> 
> While we're here, define pr_fmt for this file so we can more easily
> identify log messages.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/of_fixup.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 3f7ac227bd09..55368dd43b66 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -16,8 +16,10 @@
>   * Copyright (c) 2024 Linaro Ltd.
>   *   Author: Caleb Connolly <caleb.connolly@linaro.org>
>   */
>  
> +#define pr_fmt(fmt) "of_fixup: " fmt
> +
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dm/of_access.h>
>  #include <dm/of.h>
>  #include <fdt_support.h>
> @@ -152,4 +154,22 @@ void qcom_of_fixup_nodes(void)
>  {
>  	time_call(fixup_usb_nodes);
>  	time_call(fixup_power_domains);
>  }
> +
> +int ft_board_setup(void *blob, struct bd_info __maybe_unused *bd)
> +{
> +	struct fdt_header *fdt = blob;
> +	int node;
> +
> +	/* We only want to do this fix-up for the RB1 board, quick return for all others */
> +	if (!fdt_node_check_compatible(fdt, 0, "qcom,qrb4210-rb2"))

This if block is accidentally inverted...
> +		return 0;
> +
> +	fdt_for_each_node_by_compatible(node, blob, 0, "snps,dwc3") {
> +		log_debug("%s: Setting 'dr_mode' to OTG\n", fdt_get_name(blob, node, NULL));
> +		fdt_setprop_string(fdt, node, "dr_mode", "otg");
> +		break;
> +	}
> +
> +	return 0;
> +}
> 

-- 
// Caleb (they/them)
