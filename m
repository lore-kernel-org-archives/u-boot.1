Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0CDC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 15:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B60E4870ED;
	Sat,  4 Nov 2023 16:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kkpBNmfR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ACCD8710B; Sat,  4 Nov 2023 16:23:14 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 605B486F65
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 16:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7b9cd171d0dso1324422241.0
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699111387; x=1699716187; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m8YsGPoM2nP3Oro4YpLc0li5niugDAB0IrtRvzNgb/Q=;
 b=kkpBNmfRvX8FekjAI71HR17KdKcNETayW2Js4uYE6yY+/Ig3VjJbrMmfYVGuciNlql
 Jh9lNtk2x7u+KOur6cMo349IElY6qJRtDTF7qZrbVhK/g0GGoDTpETnQokifPu8gFu89
 yj1em2IbQzlbzM4TWYcm6JUbUz8QEGh7PQjTaGATOOHMjnIxupqAaIGanOEdS0fAnU5e
 G1eIKWdSpDYBK1TNWXQCskWPBu/xA+GF9cKAt6EuyekR3IpFR0xEDhKSTVcCCAfHzDgP
 Dr8jh+rePWieB9hDV72qX6tnCYUaQplZ2TwmpGXXv/cXuLJxsb3YapCr0WM9MV0QmE50
 SRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699111387; x=1699716187;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m8YsGPoM2nP3Oro4YpLc0li5niugDAB0IrtRvzNgb/Q=;
 b=YcvtLzRtZWeLysEq80BIzV3J3RV2HM6GtW7245UobsrKzzK3/ZXhdOURXsgSClRe/C
 qxmAISaHtFctxnLqyvqq72GU24AlXlcbdrPOcfbP2YNI13ef7Ut8yjIlKgYTBYCCDNDn
 5TOEyYpq2v/npu3lE2ysSjKlDsB9bvU+emrGxMYBqABFQTmlOqgVoRJA3HEwFFKV6aLI
 ldjMtzeJvr0qdOtmEDwRXabYWxDo5h+pZuq/xT50One8mF212rpaYg6FWeDtAj7N3VQ2
 aTfyycbC2sk6tsNnVI7GW7WFiCvlFPxgas0W7M/FXFhXVsaKgbFRPJrR1hEmsnM7yRTC
 2kRA==
X-Gm-Message-State: AOJu0Yyp2gjABA4BLKJwoMDuBnjmhdO0pa+5Zpf5dXzRSZ4YbItS46Q3
 w/Wx75W2wMewkr3dLIl8qSQ=
X-Google-Smtp-Source: AGHT+IGEVwLuE1wJ8IUOFTi16FAk+iRReYA53iw/os78VvzWuJAQ1NnVHT7QaRG98zhRxBN3U5mPag==
X-Received: by 2002:a67:cb91:0:b0:45d:9e46:fb50 with SMTP id
 h17-20020a67cb91000000b0045d9e46fb50mr3001730vsl.10.1699111386575; 
 Sat, 04 Nov 2023 08:23:06 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 kh6-20020a056214514600b006714f8b5512sm1727582qvb.6.2023.11.04.08.23.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 08:23:06 -0700 (PDT)
Message-ID: <81a727a6-599d-c5f8-e85b-9f66012d5e74@gmail.com>
Date: Sat, 4 Nov 2023 11:23:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 6/8] cmd: clk: Use dump function from clk_ops
Content-Language: en-US
To: Igor Prusov <ivprusov@sberdevices.ru>, Michal Simek
 <michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20231102122017.56995-1-ivprusov@sberdevices.ru>
 <20231102122017.56995-7-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231102122017.56995-7-ivprusov@sberdevices.ru>
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

On 11/2/23 08:20, Igor Prusov wrote:
> Add another loop to dump additional info from clock providers that
> implement dump operation.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   cmd/clk.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/cmd/clk.c b/cmd/clk.c
> index c7c379d7a6..4b9709d3ff 100644
> --- a/cmd/clk.c
> +++ b/cmd/clk.c
> @@ -62,6 +62,7 @@ static void show_clks(struct udevice *dev, int depth, int last_flag)
>   int __weak soc_clk_dump(void)
>   {
>   	struct udevice *dev;
> +	const struct clk_ops *ops;
>   
>   	printf(" Rate               Usecnt      Name\n");
>   	printf("------------------------------------------\n");
> @@ -69,6 +70,14 @@ int __weak soc_clk_dump(void)
>   	uclass_foreach_dev_probe(UCLASS_CLK, dev)
>   		show_clks(dev, -1, 0);
>   
> +	uclass_foreach_dev_probe(UCLASS_CLK, dev) {
> +		ops = dev_get_driver_ops(dev);
> +		if (ops && ops->dump) {
> +			printf("\n%s %s:\n", dev->driver->name, dev->name);
> +			ops->dump(dev);
> +		}
> +	}
> +
>   	return 0;
>   }
>   #else

Reviewed-by: Sean Anderson <seanga2@gmail.com>
