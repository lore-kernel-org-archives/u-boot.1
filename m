Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33D5D44160
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 10:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1FDE81D6A;
	Fri, 12 Dec 2025 11:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YlNTLgoA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B7A0828A2; Fri, 12 Dec 2025 11:19:55 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34F11808AF
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 11:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so11670965e9.2
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 02:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765534787; x=1766139587; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZXQDkGooZgNghqh3/FCHbENWnZeYcECSIoMaiYPD0so=;
 b=YlNTLgoAMTGzTmgaDFeZwDCamFAepsMWHZCd5dFTNmSWyCHtCedz3d+Zp7icLY7pvn
 qWTvV5iu2p86AcSn1w+BQIqTRXDNW1x95MJkVcOYRAj3y+CYdhJyqaiLdUJ7SsF0w8rO
 8ZZDutcyWb7KaMWRQo0MvYVvmfPniuHVDbUvEeQ2Ep6Peexjd/OSlMz7BpER3Q6ujobI
 jJiLqzdK3msCzKS/Ix880kBM6oLbkK5X42BooXVUibjxcHtT6FQ4ic+chMCucHFvUc5C
 aZSs32a1Zda1BJ802l+bnCvclwD2QdbjYWEnsykUSwNQtqu3pax1C2m7nFg6r3aL/bL/
 yWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765534787; x=1766139587;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZXQDkGooZgNghqh3/FCHbENWnZeYcECSIoMaiYPD0so=;
 b=WfYkH7J37x4Z5oN/9Oz7Z5s4xWuIAk5w27T9u3XEjbk9Xgg3xhccce3aI30FcezqTG
 1T9RIFVozC0VYHHyfEHqFYSyILWDOrd1LswX4IHEhhPWc285Lu25AXONMUiGS4v2M4cW
 0E/KY9LrDYN/fKz/Nv0gFyQ7/HHH+ZYqdYdsvQeEOr6Y8iBgGeERLCLWtkSNBm6PacGk
 YCjieEYIdhvv75KuesAq8iukj2E9QT/UIRxryBliV+ROQC3/taA6czOzlSxdD16LCivb
 kraaDahFePGu4JXbpELQ/BpE4oMJ1jSMrA7j9k+3tV/J/00wDMH3lOM/NqtVxzaLVdfn
 laDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLV1iLeAng11zRD6bzBIYE80nOig4DWk+tXda0qDIccccx/hsqY/mohav1XKqsiwDV0RPGNkA=@lists.denx.de
X-Gm-Message-State: AOJu0YxJGq9SEW5YHXAKaf/vz91651ZLlBe+CKthI40WKNESzTk7lohh
 e1uRcEZ9BmhL50ttrV8fg2A7NgDadfFvcp1cWQzyxFuvoSHQCANuRdmpHemaiuJAW/c=
X-Gm-Gg: AY/fxX69QiTBBecHHhEJI8tYIkCr+gA/yznCu4pmORqfdASi3Jo1w0wA8Qtr7lu0xLv
 AD6gNauXBB0vAK/VTymoexIqSJNTovOGb7dGIfhMJjL97Fd9rMvHt6KQ+Qfrp+14AmiTJVUSRRz
 7TlFebIzMwecYbvC/9+hMjyM1/wigvqc/J/h6NmQxZnUejZ6gnlhgc0W/goQ+J2+NanjRclgnFJ
 NGphgdxkejuVX9u5PkimY00NayIK8TfPp7AL3/b0Ll7eicKszoCDOx0fLOo2YLwXLrGQXJMnHbu
 /UZsbRcKCNmdgKnU7I3usg1mv5b6MH7uCpo8e67P8gdWmP1Fh3K5gkqddTR/J6aBGKVPs4ZdvWe
 uaD0CstBBwITI28MDThSuTh1PlfsK2hZ8AC63Dd6TyPU3Nr634Wyiy/QDOsdLbfnT3nvAimObS3
 XpgdU/NhKkhurnvIAEjlL9MP5eNF7w2rF88nGeG5QHJ1EmdIwuhA4hUNOGp8B4B+OVNQ==
X-Google-Smtp-Source: AGHT+IEE59jsnGy8We8P38tQZttNblaOrMe+pR5/N8Xz/Yj/mrY6qW7Xj6RHA84ZZW+3LhyNzSapZA==
X-Received: by 2002:a05:600c:a086:b0:477:9986:5e6b with SMTP id
 5b1f17b1804b1-47a8f90e927mr15273105e9.28.1765534787505; 
 Fri, 12 Dec 2025 02:19:47 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:fed:3801:9287:1e8a:f239:8d00?
 ([2a0a:ef40:fed:3801:9287:1e8a:f239:8d00])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f4ae4d3sm9067915e9.5.2025.12.12.02.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 02:19:46 -0800 (PST)
Message-ID: <0aa60ddd-096a-4cc4-a990-986558bb8fa1@linaro.org>
Date: Fri, 12 Dec 2025 10:19:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "clk: Return value calculated by ERR_PTR"
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Nishanth Menon <nm@ti.com>
References: <20251212011906.865419-1-trini@konsulko.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20251212011906.865419-1-trini@konsulko.com>
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

On 12/12/2025 01:19, Tom Rini wrote:
> While this change was intended to fix a mistake in the code, of calling
> the ERR_PTR macro but not making use of the result, it seems that
> functionally platforms depend on the loop not existing here. The TI K3
> families of platforms for example were broken by this commit.
> 
> This reverts commit fe780310cfa8bf5a093894b5cd7fe85c6b02fd91.
> 
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   arch/sandbox/include/asm/clk.h |  1 -
>   drivers/clk/clk-uclass.c       |  4 ++--
>   drivers/clk/clk_sandbox.c      | 17 -----------------
>   test/dm/clk.c                  |  5 ++---
>   4 files changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/sandbox/include/asm/clk.h b/arch/sandbox/include/asm/clk.h
> index 2d3318cdcc4d..37fe49c7fcf6 100644
> --- a/arch/sandbox/include/asm/clk.h
> +++ b/arch/sandbox/include/asm/clk.h
> @@ -50,7 +50,6 @@ enum sandbox_clk_test_id {
>   
>   struct sandbox_clk_priv {
>   	bool probed;
> -	struct clk clk;
>   	ulong rate[SANDBOX_CLK_ID_COUNT];
>   	bool enabled[SANDBOX_CLK_ID_COUNT];
>   	bool requested[SANDBOX_CLK_ID_COUNT];
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 4420651f765c..0584429bed65 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -199,7 +199,7 @@ static struct clk *clk_set_default_get_by_id(struct clk *clk)
>   		if (ret) {
>   			debug("%s(): could not get parent clock pointer, id %lu\n",
>   			      __func__, clk->id);
> -			return ERR_PTR(ret);
> +			ERR_PTR(ret);
>   		}
>   	}
>   
> @@ -354,7 +354,7 @@ static int clk_set_default_rates(struct udevice *dev,
>   
>   		c = clk_set_default_get_by_id(&clk);
>   		if (IS_ERR(c))
> -			continue;
> +			return PTR_ERR(c);
>   
>   		ret = clk_set_rate(c, rates[index]);
>   
> diff --git a/drivers/clk/clk_sandbox.c b/drivers/clk/clk_sandbox.c
> index cd92a6a29f57..c8c5a88c52d9 100644
> --- a/drivers/clk/clk_sandbox.c
> +++ b/drivers/clk/clk_sandbox.c
> @@ -8,23 +8,8 @@
>   #include <errno.h>
>   #include <malloc.h>
>   #include <asm/clk.h>
> -#include <dm/device-internal.h>
>   #include <linux/clk-provider.h>
>   
> -static int sandbox_clk_of_to_plat(struct udevice *dev)
> -{
> -	struct clk *clk;
> -	struct sandbox_clk_priv *priv = dev_get_priv(dev);
> -
> -	clk = &priv->clk;
> -
> -	/* FIXME: This is not allowed */
> -	dev_set_uclass_priv(dev, clk);
> -
> -	clk->dev = dev;
> -	return 0;
> -}
> -
>   static ulong sandbox_clk_get_rate(struct clk *clk)
>   {
>   	struct sandbox_clk_priv *priv = dev_get_priv(clk->dev);
> @@ -117,7 +102,6 @@ static int sandbox_clk_request(struct clk *clk)
>   	if (id >= SANDBOX_CLK_ID_COUNT)
>   		return -EINVAL;
>   
> -	priv->clk.id = id;
>   	priv->requested[id] = true;
>   	return 0;
>   }
> @@ -148,7 +132,6 @@ U_BOOT_DRIVER(sandbox_clk) = {
>   	.name		= "sandbox_clk",
>   	.id		= UCLASS_CLK,
>   	.of_match	= sandbox_clk_ids,
> -	.of_to_plat	= sandbox_clk_of_to_plat,
>   	.ops		= &sandbox_clk_ops,
>   	.probe		= sandbox_clk_probe,
>   	.priv_auto	= sizeof(struct sandbox_clk_priv),
> diff --git a/test/dm/clk.c b/test/dm/clk.c
> index c3363796498b..790968e64774 100644
> --- a/test/dm/clk.c
> +++ b/test/dm/clk.c
> @@ -89,9 +89,8 @@ static int dm_test_clk(struct unit_test_state *uts)
>   						 SANDBOX_CLK_TEST_ID_SPI));
>   	ut_asserteq(0, sandbox_clk_test_get_rate(dev_test,
>   						 SANDBOX_CLK_TEST_ID_I2C));
> -	if (!CONFIG_IS_ENABLED(CLK_AUTO_ID))
> -		ut_asserteq(321, sandbox_clk_test_get_rate(dev_test,
> -							   SANDBOX_CLK_TEST_ID_DEVM1));
> +	ut_asserteq(321, sandbox_clk_test_get_rate(dev_test,
> +						   SANDBOX_CLK_TEST_ID_DEVM1));
>   	ut_asserteq(0, sandbox_clk_test_get_rate(dev_test,
>   						 SANDBOX_CLK_TEST_ID_DEVM2));


Reviewed-by: Andrew Goodbody <andrew.goodbody@linaro.org>

