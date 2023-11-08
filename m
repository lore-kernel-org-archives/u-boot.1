Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD467C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D94C86EA3;
	Wed,  8 Nov 2023 17:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hZtMTvuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30D6D86E2F; Wed,  8 Nov 2023 17:59:18 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E10A086EA6
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6ce37683cf6so4210235a34.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462753; x=1700067553; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZnOdKUWWE4zFAKJWidQzEqP0t/m6lENpHeoIBjpMExk=;
 b=hZtMTvuFnqLdb0NafNWnKXt2ejwwDxAyr7Sz6Gs9CqP0U80yVZDT5quTvykuDyv5zf
 X/AQ15XkjzpZK0vwkv9rsAwf2hsxFEKoVhv8i65sqwmNDnC+7Xg/v9kWpU1/JG1lrXeO
 U7nRiW37NTHQm8Wnflq6vtxo0TI6ptGQk/47bN1/DlX/oLNJtA0RSP5ZVM0bCbhC8Lck
 6QPqWwZ7v8eRewSZ/CLxb+15dBhDLxbJ8G6aVwLwAE9Dy75B1QT1kdVrhsfcWOZYpOIJ
 FqcOBpbS2IkLI7T0X9POCp7afc8cKya1/sjswb8J0Ia5Ngt+tT5z4QuLpnpTSnnIVA8V
 iJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462753; x=1700067553;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnOdKUWWE4zFAKJWidQzEqP0t/m6lENpHeoIBjpMExk=;
 b=kXP7GaSjGq2G/wJFb0MD2ZteDuvDBgGObfLardTrFscER7u/nw3pg9LklG3+uKNnpV
 dxJgUCUFVmqntZdgfgPaeqoRcP7AMUnpy8vuFpFI2U0WAjckUGWQpQAYHudgiiu/AwEw
 sgFfv0MtDkf5DbvwkgS/90xege98xjSKNXnJ5AheFkg0t+ujEA0ozgJTn0Le9EoW+F1h
 H7iBr2klyLXhSuIrqh+Nz0DX5qRr8YQr/W33m2C8VlKYwx9PJJbiDsxiCJC4FF1CRUTb
 9GPGf2AaHOJbB7mo5grqlMHmyVVJJ2qIes1LQ+/DgKvyB5yNzHQbYIxbTfSO9/v8Etow
 SjKg==
X-Gm-Message-State: AOJu0YwcDiMjtxj9Ru7LpHK4vhn856s0xNDSPhsuSh8CJCIacm+QnQ3Y
 PvmfoKwkpRW96QesEOc0L3E=
X-Google-Smtp-Source: AGHT+IETEvYweDNabSPYit/y8g1EtPfbXj0e+2RBrbqRDfj8gbZFR7JQQFtUnjhk4bU0jRWqQU4fSw==
X-Received: by 2002:a05:6830:2b21:b0:6be:c1b:ded4 with SMTP id
 l33-20020a0568302b2100b006be0c1bded4mr2768421otv.3.1699462753555; 
 Wed, 08 Nov 2023 08:59:13 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 kg16-20020a05622a761000b0040331a24f16sm1073339qtb.3.2023.11.08.08.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:59:13 -0800 (PST)
Message-ID: <976548be-3bdd-0655-8bbb-31c7acdbe4be@gmail.com>
Date: Wed, 8 Nov 2023 11:59:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 5/8] clk: Add dump operation to clk_ops
Content-Language: en-US
To: Igor Prusov <ivprusov@sberdevices.ru>, u-boot@lists.denx.de,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
References: <20231105083809.3293-1-ivprusov@sberdevices.ru>
 <20231105083809.3293-6-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231105083809.3293-6-ivprusov@sberdevices.ru>
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

On 11/5/23 03:38, Igor Prusov wrote:
> This adds dump function to struct clk_ops which should replace
> soc_clk_dump. It allows clock drivers to provide custom dump
> implementation without overriding generic CCF dump function.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   include/clk-uclass.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/include/clk-uclass.h b/include/clk-uclass.h
> index a22f1a5d84..3419daab34 100644
> --- a/include/clk-uclass.h
> +++ b/include/clk-uclass.h
> @@ -25,6 +25,7 @@ struct ofnode_phandle_args;
>    * @set_parent: Set current clock parent
>    * @enable: Enable a clock.
>    * @disable: Disable a clock.
> + * @dump: Print clock information.
>    *
>    * The individual methods are described more fully below.
>    */
> @@ -39,6 +40,9 @@ struct clk_ops {
>   	int (*set_parent)(struct clk *clk, struct clk *parent);
>   	int (*enable)(struct clk *clk);
>   	int (*disable)(struct clk *clk);
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +	void (*dump)(struct udevice *dev);
> +#endif
>   };
>   
>   #if 0 /* For documentation only */
> @@ -135,6 +139,17 @@ int enable(struct clk *clk);
>    * Return: zero on success, or -ve error code.
>    */
>   int disable(struct clk *clk);
> +
> +/**
> + * dump() - Print clock information.
> + * @clk:	The clock device to dump.
> + *
> + * If present, this function is called by "clk dump" command for each
> + * bound device.
> + *
> + * Return: zero on success, or -ve error code.

This is no longer correct, but I can remove it when applying.

> + */
> +void dump(struct udevice *dev);
>   #endif
>   
>   #endif

Reviewed-by: Sean Anderson <seanga2@gmail.com>
