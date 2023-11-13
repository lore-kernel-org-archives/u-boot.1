Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B466C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 18:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5F8186611;
	Mon, 13 Nov 2023 19:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PnHyz6k6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7D338716D; Mon, 13 Nov 2023 19:14:51 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746C5864F3
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 19:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-670e7ae4a2eso49121816d6.1
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 10:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699899288; x=1700504088; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w6pLqa04OkzALlVnRfvSa2W6iVE+CukD8vMJ38OXCjU=;
 b=PnHyz6k6Crd0xMciMdLkdA07mqH8tYkQZIW4ti7TFoSY8VIZEOKHE6OTiVMJ3lpanZ
 LGebd0AtnVAq9LN27QDBDqUTkDnvtcjg4ZYoBt+TqfCKVk5dSeFXB/UxGW5yldTs/3v9
 /S8vYHopbMPod+TU6v61kMPPXc9jmrjKzhODgLiwiiJvs7yRKkwygxcs6vyknpM7aYJt
 BMHXYG4qY4NnbfqO9+2A4rUPiRXeqmmb2xvRK2h2ith4HtEyEtZU7KRjfAsz+2th9orb
 0sUl2X5MU+NAq5AAh1IqnXdICbbwj6PFTrpplWdTaSaWwFuW42X90DygHMCytjcw639p
 A5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699899288; x=1700504088;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w6pLqa04OkzALlVnRfvSa2W6iVE+CukD8vMJ38OXCjU=;
 b=WH2EfZYzSVLH3OhyWoCEmh2pAbponoQZ4s0GlgdkA+Qe0IivodAPvIBjLhnNZucOwl
 LvNS+PhuWpKx0XA2gS/0vxtExIHTZ6pCjiiJId+Qc45d6HvgrgXf47r4IjvpCvyIqt7e
 GQ3BDsO0AOOjboimG5HRsyufyPZWopomcfVMKAWPlgp45fLHO6BEatiqQZ6icDPRUO9f
 ABPmOMq8JG8nNMrdHCvc+aWsNWu5URDPrEonFQEjHi1VPdM081i4JUELn1WptKHRK6g/
 2HcKMY2DG9Q5ULxEr1gyV9IX0fmxCiifVhNRSWnnzrwxD6VTVTXOfWpM7jr/HbYSsV5m
 bkxw==
X-Gm-Message-State: AOJu0Yx63/Co/iRJyOTcC2yA16XuCrKZq/ARMBQvEvsNSn0+M4wqBtIg
 zE4xAub56uMLI0XPdRQY7hQ=
X-Google-Smtp-Source: AGHT+IH/Ky79u/8t9EoOC8/Iz9jQVv/F5BLhks+BsjJtpJ2ECairrXgB1KcIqE891mmp2pm8td3Rnw==
X-Received: by 2002:ad4:56e4:0:b0:65b:134:ed27 with SMTP id
 cr4-20020ad456e4000000b0065b0134ed27mr499873qvb.4.1699899288175; 
 Mon, 13 Nov 2023 10:14:48 -0800 (PST)
Received: from [172.25.83.38] ([12.186.190.2])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a0ceecd000000b00671b009412asm2210256qvs.141.2023.11.13.10.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 10:14:47 -0800 (PST)
Message-ID: <77028055-5537-da29-bcea-6a373210782c@gmail.com>
Date: Mon, 13 Nov 2023 13:14:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] clk: check parent_name in clk_register to avoid
 confusing log_error() output
Content-Language: en-US
To: forbidden405@outlook.com, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20230807-clk-fix-v2-1-0b688e21fb4e@outlook.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20230807-clk-fix-v2-1-0b688e21fb4e@outlook.com>
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



On 11/10/23 14:19, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> For some gate clocks and fixed clocks without a parent, calling
> clk_register will print an useless error message indicating that parent
> is missing. Fix that by gaurding log_xxx() with an if-statement.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> Suggested-by: Sean Anderson <seanga2@gmail.com>
> ---
> It's found during my development for HiSilicon clock driver.
> ---
> Changes in v2:
> - drop the commit which exports clk_mux_register.
> - drop the commit which is already merged
> - drop ccf enable_count fix as it'll be in another patchset
> - use Anderson's patch for clk_register()
> - Link to v1: https://lore.kernel.org/r/20230809-clk-fix-v1-0-808dbae54e5e@outlook.com
> ---
>   drivers/clk/clk.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index a5a3461b66..6ede1b4d4d 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -18,17 +18,19 @@
>   int clk_register(struct clk *clk, const char *drv_name,
>   		 const char *name, const char *parent_name)
>   {
> -	struct udevice *parent;
> +	struct udevice *parent = NULL;
>   	struct driver *drv;
>   	int ret;
>   
> -	ret = uclass_get_device_by_name(UCLASS_CLK, parent_name, &parent);
> -	if (ret) {
> -		log_err("%s: failed to get %s device (parent of %s)\n",
> -			__func__, parent_name, name);
> -	} else {
> -		log_debug("%s: name: %s parent: %s [0x%p]\n", __func__, name,
> -			  parent->name, parent);
> +	if (parent_name) {
> +		ret = uclass_get_device_by_name(UCLASS_CLK, parent_name, &parent);
> +		if (ret) {
> +			log_err("%s: failed to get %s device (parent of %s)\n",
> +				__func__, parent_name, name);
> +		} else {
> +			log_debug("%s: name: %s parent: %s [0x%p]\n", __func__, name,
> +				  parent->name, parent);
> +		}
>   	}
>   
>   	drv = lists_driver_lookup_name(drv_name);
> 
> ---
> base-commit: 580eb31199be8a822e62f20965854a242f895d03
> change-id: 20230807-clk-fix-17e895f79817
> 
> Best regards,
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>
