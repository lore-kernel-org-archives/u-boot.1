Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9034C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1266D8707A;
	Wed,  1 Nov 2023 19:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E1/U4sr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF6A868BF; Wed,  1 Nov 2023 19:41:40 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E2F87D88
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-66d17bdabe1so964776d6.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698864090; x=1699468890; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oVKocWK19/uGccQosMqioi1E2Dacpa+7Doc5Uik6auE=;
 b=E1/U4sr72tGnhEPLw+7oI3cpTkKi3suHMMpRH4jzzR0agid3h4sk2JOSEtxHDcX8oO
 VzFcm6qfZBD+tzH6xUCAsxpIJq2yRiZ/bIVXC6y/Xg72CJVbv5wVYdsY2a1YXXkieCdQ
 utbpHo+CGii76cUA98alHDEFhenb71aWcVy+xyWlV9hhPylyAhBFrGz4+15mF0FXdzGl
 6IS4/nqH+E00viIuohniSjzT3Ax5w2FXzXxmvBnXxS7sNw7rDk7x6OJfYDmQ33R81iuP
 mAVffw6y4/B6OTPlaJfTNlTNsSxmuPAUwsqpG4zMq+Qox+n4na9GQkZqB37PAKud4Oyb
 xIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698864090; x=1699468890;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oVKocWK19/uGccQosMqioi1E2Dacpa+7Doc5Uik6auE=;
 b=hjeRCzpiTvAa8Z+KVOfb9vFwao0J8Ao88SaRkmOtlWkQLwDu7XK1sqryocJVWpIL22
 i55FIYYs3PRRXbfr4Ov6qaMqamt88FHVHbMQdvfMx7xQtP0wPfWmAzt4sAUEiN+RftPa
 zOLMva100RMf0Zwcv0n0DET4JErgJzB7bYOZ8uEsvdkxGVSb7W0ZhwOS1GWRHHzMEqAt
 hJqGmTZBwq3HhJMvISrOV/fU/lqM3O+y4B7kdu6Ce4BG7j06Ysj902FGaYHEXUmTWtFU
 5z5prSag20WSlu7L2uMxlurK2Loho+AvqB9k9sEgN2Gw0tuRoMcAZF2XQ87sANdl0vdv
 pEZQ==
X-Gm-Message-State: AOJu0YzKvp+/MVfax0GD1lLgdkIzyUfHkIf//Bqz9h2Wj5HxEBp+41wz
 s0Athfq6/YHbvQAv+GYDo/VuqwOFdMPV4w==
X-Google-Smtp-Source: AGHT+IGURpytqQV/iP2X9KIrLR45GxqU49MrwQkx9vJfX8d0Fm6KOqIXH5HkcgnAlBX099JkPK/7vQ==
X-Received: by 2002:a05:6214:e67:b0:66d:1ae6:2a5a with SMTP id
 jz7-20020a0562140e6700b0066d1ae62a5amr18016217qvb.7.1698864089723; 
 Wed, 01 Nov 2023 11:41:29 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 g15-20020ac870cf000000b004197d6d97c4sm1610993qtp.24.2023.11.01.11.41.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 11:41:29 -0700 (PDT)
Message-ID: <d554be7d-c800-78bc-3cf8-51db11e27ed0@gmail.com>
Date: Wed, 1 Nov 2023 14:41:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] clk: mux: check value returned from
 clk_mux_val_to_index()
Content-Language: en-US
To: Maksim Kiselev <bigunclemax@gmail.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>
References: <20230905173307.3404875-1-bigunclemax@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20230905173307.3404875-1-bigunclemax@gmail.com>
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

On 9/5/23 13:33, Maksim Kiselev wrote:
> The clk_mux_val_to_index() may return -EINVAL. In this case
> clk_mux_get_parent() will return a wrong parent index and
> this will lead to out of bounds error.
> 
> E.g. when we register mux clk:
> 	ret = clk_register(clk, UBOOT_DM_CLK_CCF_MUX, name,
> 			   parent_names[clk_mux_get_parent(clk)]);
> 
> Let's add a check on the return value of clk_mux_val_to_index() and if
> it's negative, set parent index to 0.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>   drivers/clk/clk-mux.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index 017f25f7a5..00fe916171 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -88,6 +88,7 @@ unsigned int clk_mux_index_to_val(u32 *table, unsigned int flags, u8 index)
>   u8 clk_mux_get_parent(struct clk *clk)
>   {
>   	struct clk_mux *mux = to_clk_mux(clk);
> +	int index;
>   	u32 val;
>   
>   #if IS_ENABLED(CONFIG_SANDBOX_CLK_CCF)
> @@ -98,7 +99,13 @@ u8 clk_mux_get_parent(struct clk *clk)
>   	val >>= mux->shift;
>   	val &= mux->mask;
>   
> -	return clk_mux_val_to_index(clk, mux->table, mux->flags, val);
> +	index = clk_mux_val_to_index(clk, mux->table, mux->flags, val);
> +	if (index < 0) {
> +		log_err("Could not fetch index\n");
> +		index = 0;
> +	}
> +
> +	return index;
>   }
>   
>   static int clk_fetch_parent_index(struct clk *clk,

Reviewed-by: Sean Anderson <seanga2@gmail.com>

But can you add something to the commit (or error) message about
how this indicates a bug in the driver (e.g. there aren't enough
parents to match the hardware).

--Sean
