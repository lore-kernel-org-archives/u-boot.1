Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E5EC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 17:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B91C87C10;
	Fri, 15 Dec 2023 18:14:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jFcasnI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F147A87805; Fri, 15 Dec 2023 18:14:46 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE49A8783D
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 18:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-589d4033e84so606768eaf.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 09:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702660482; x=1703265282; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H04rOFN+gVCz7wZLAuaryY8ppCGAJ5zRrSP6v7BYWtU=;
 b=jFcasnI0CJeqH+IZBgZk9+jzGdus0f2AnDh2D6Wd+k+l2TX0NlDiL80c7Jp6+V0f20
 oStOqUIHKYHgTnadjnq2jE0ha6j+8T63NCioye8oySIwNiD3+jB1I2covbrGEqS+5tU1
 0nfd8NFKp8fBNrq+sbwCmgQrtzIiAnrdwO5t53Rqur+PGU6YDnF1q2UIcLhdYB9KuRS3
 PBa02F0AKJeCMu+rEef28h1ex2nKp3Ll4lLGYhXrit2q3zkz6/acUjMxcCdHG0sSNTPv
 0Z0MHvnUKDeLCy5TVNjyXku5Fvz3Qn3M53xf0XaJFdDt7NxMaUtSviwISsSSgqIt4LsM
 8njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702660482; x=1703265282;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H04rOFN+gVCz7wZLAuaryY8ppCGAJ5zRrSP6v7BYWtU=;
 b=fzNokEAcYf1hp+eARaMpSiqmHWLI/F8HOpKb4NwSK+p51YsbO0t+9D9DF6/7tXka2O
 GkcEI9XTjJTJgsGiGCVcE3eOZikK4OrJsLXevlhwDzfx5ajV4B3eDStjSgFc5n4PzVRv
 DYDXkRbd+gO4b4KrMoQIJ2ZZqW3ho3ndpPVD2+UnUQtTxqtjQpauf+Uq68xCo2eXwAm4
 AVqy/47dQNhTST9BkrfWgJ91t5ruUB0L5Ge9AnayaQdWYHok6eQGjFQoRQcGu/BUGua+
 yV5LAtA5xuApmQw0i09dOA9TKt4aeMAb6riY69nDng/1Avl6jlrk6bgk2FcEWEeHZOoi
 cqNQ==
X-Gm-Message-State: AOJu0YwnBdeTzgrerL/b/k2fXO5S36DtMcEV3FFRtfSLOuYTph4I+b++
 NP0pS8N6UA2IP3tN0qB+IdQ=
X-Google-Smtp-Source: AGHT+IH/z0A8Dag2bVq26EwyOHH8Ly1vvtgek2x21UbMGg8PZYJApoUlfsv4qVxasBJ+9I1UejIFNA==
X-Received: by 2002:a05:6359:6006:b0:170:6ed7:2b9c with SMTP id
 rw6-20020a056359600600b001706ed72b9cmr10064475rwb.21.1702660482517; 
 Fri, 15 Dec 2023 09:14:42 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 ph30-20020a0562144a5e00b0067f201e3355sm331645qvb.111.2023.12.15.09.14.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 09:14:42 -0800 (PST)
Message-ID: <3212a131-f99b-3c69-ec42-420643726bc8@gmail.com>
Date: Fri, 15 Dec 2023 12:14:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/4] test: dm: clk_ccf: get "i2c_root" clock from
 &clk_ccf
Content-Language: en-US
To: forbidden405@outlook.com, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20231111-enable_count-v2-0-20e3728600b5@outlook.com>
 <20231111-enable_count-v2-4-20e3728600b5@outlook.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231111-enable_count-v2-4-20e3728600b5@outlook.com>
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

On 11/18/23 17:10, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> get i2c_root clock from device tree. In this way we get an CCF clock and
> also test ccf_clk_ops.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>   test/dm/clk_ccf.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/test/dm/clk_ccf.c b/test/dm/clk_ccf.c
> index e4ebb93cda..b8be6d6572 100644
> --- a/test/dm/clk_ccf.c
> +++ b/test/dm/clk_ccf.c
> @@ -18,8 +18,8 @@
>   /* Tests for Common Clock Framework driver */
>   static int dm_test_clk_ccf(struct unit_test_state *uts)
>   {
> -	struct clk *clk, *pclk;
> -	struct udevice *dev;
> +	struct clk *clk, *pclk, clk_ccf;
> +	struct udevice *dev, *test_dev;
>   	long long rate;
>   	int ret;
>   #if CONFIG_IS_ENABLED(CLK_CCF)
> @@ -29,6 +29,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
>   
>   	/* Get the device using the clk device */
>   	ut_assertok(uclass_get_device_by_name(UCLASS_CLK, "clk-ccf", &dev));
> +	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "clk-test", &test_dev));
>   
>   	/* Test for clk_get_by_id() */
>   	ret = clk_get_by_id(SANDBOX_CLK_ECSPI_ROOT, &clk);
> @@ -110,11 +111,18 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
>   
>   #if CONFIG_IS_ENABLED(CLK_CCF)
>   	/* Test clk tree enable/disable */
> +
> +	ret = clk_get_by_index(test_dev, SANDBOX_CLK_TEST_ID_I2C_ROOT, &clk_ccf);
> +	ut_assertok(ret);
> +	ut_asserteq_str("clk-ccf", clk_ccf.dev->name);
> +	ut_asserteq(clk_ccf.id, SANDBOX_CLK_I2C_ROOT);
> +
>   	ret = clk_get_by_id(SANDBOX_CLK_I2C_ROOT, &clk);
>   	ut_assertok(ret);
>   	ut_asserteq_str("i2c_root", clk->dev->name);
> +	ut_asserteq(clk->id, SANDBOX_CLK_I2C_ROOT);
>   
> -	ret = clk_enable(clk);
> +	ret = clk_enable(&clk_ccf);
>   	ut_assertok(ret);
>   
>   	ret = sandbox_clk_enable_count(clk);
> 

This patch should be combined with patches 1 and 3. With the changes spread out
over 3 patches it is hard to see what is going on.

--Sean
