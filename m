Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E488DC4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 536F487BCC;
	Fri, 15 Dec 2023 19:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UxrboNEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA9087BCC; Fri, 15 Dec 2023 19:49:53 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6E3987BA0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-67f02843e91so6617996d6.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 10:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702666188; x=1703270988; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZzOrMKa5eWD931dGx5W28Nfx8jWcxrZG8JPDrDgZus8=;
 b=UxrboNEf2iTBPGfcfw6MfriFxCRSRA8TDR2ghud/p3R8EeYZNzJkAdXyVO9zoWyz38
 zpqaCRA1WPNhyBsPrLXmPZ9aHeu0ZbhEruewkXAJHYG4rPhMPED/YaVK/26eQAPW3D5+
 XCC5vBA0LtksknikwllPgcxX0sDc7Zjq+7wFYGenwSHB5kqvF1M5DUBkRB51ftVO9ru+
 8E3DD5DCJU8stiRGjejT1gyU+g/uYR8g5NTIuU2AYPKvL2IWgDe1y3iq9Wm4dw0yLLBd
 suKIHcN+b8HVs9twAl+Sm9vL8Gvjmz29yxyW8uHO5insxAAseTdA6Xb8uB5oBT2tjaYQ
 j5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702666188; x=1703270988;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZzOrMKa5eWD931dGx5W28Nfx8jWcxrZG8JPDrDgZus8=;
 b=uVqCfTHCX9CvSFhacCG/alYpLGSevVdinHBYhJb3+aVYPyXMMKKdVGQ4n99VZmiEJL
 u8dDXL4HfEzITVJmdXYcsq2z4YwXHXqCdPW3qglLxHP+WON7Je806JmeWLj+C4Dkv9JP
 SxG6MO7Lfyfov25Yv/sQNdD7KZdZM6FyhgSX5J1mgUpeJwLXJUhP2YslW8hi9uTwYoVZ
 UjhYg5fJVJhnqFz2E08mVWmPEB1fMBVNz94P8IPrx5pjgC6qrqX+EbTbnOd0W4fSm54l
 YtTs0dG4xHC1H0o9yp8ivBqdK3EhPDVz3vOgOA/pXasslONypgF0yhmAIbRUbq8xrKb6
 ahGA==
X-Gm-Message-State: AOJu0YxVJp8PAtidMDSUEtvOJCySS+XzacgGz9jKKEf7vveXlM567N5I
 QoRW2CHf/1PBtUo8gB1TPCo=
X-Google-Smtp-Source: AGHT+IENrYptQb57tuwx2b4gu8ZcGdYSGCagcCVrDWhWilsUQiEv7kC1OZt/1+IxfMiT1XpHHJJiRQ==
X-Received: by 2002:a0c:ef81:0:b0:67a:b5de:1dff with SMTP id
 w1-20020a0cef81000000b0067ab5de1dffmr10939421qvr.74.1702666188412; 
 Fri, 15 Dec 2023 10:49:48 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 d17-20020a0cea91000000b0067eabe0116dsm6798156qvp.72.2023.12.15.10.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 10:49:48 -0800 (PST)
Message-ID: <74767c7c-0ea8-8c3a-4ea1-143e6dce87b2@gmail.com>
Date: Fri, 15 Dec 2023 13:49:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] test: dm: clk_ccf: test ccf_clk_ops
Content-Language: en-US
To: forbidden405@outlook.com, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20231111-enable_count-v3-0-08a821892fa9@outlook.com>
 <20231111-enable_count-v3-2-08a821892fa9@outlook.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231111-enable_count-v3-2-08a821892fa9@outlook.com>
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

On 12/15/23 13:28, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Assign ccf_clk_ops to .ops of clk_ccf driver so that it can act as an
> clk provider. Also add "#clock-cells=<1>" to its device tree node.
> 
> Add "i2c_root" to clk_test in the device tree and driver for testing.
> 
> Get "i2c_root" clock in CCF unit tests and add tests for it.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>   arch/sandbox/dts/test.dts      |  4 +++-
>   arch/sandbox/include/asm/clk.h |  1 +
>   drivers/clk/clk_sandbox_ccf.c  |  1 +
>   drivers/clk/clk_sandbox_test.c |  1 +
>   test/dm/clk_ccf.c              | 14 +++++++++++---
>   5 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index c7197795ef..a3a865d65c 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -631,9 +631,10 @@
>   		clocks = <&clk_fixed>,
>   			 <&clk_sandbox 1>,
>   			 <&clk_sandbox 0>,
> +			 <&ccf 11>,
>   			 <&clk_sandbox 3>,
>   			 <&clk_sandbox 2>;
> -		clock-names = "fixed", "i2c", "spi", "uart2", "uart1";
> +		clock-names = "fixed", "i2c", "spi", "i2c_root", "uart2", "uart1";
>   	};
>   
>   	clk-test2 {
> @@ -654,6 +655,7 @@
>   
>   	ccf: clk-ccf {
>   		compatible = "sandbox,clk-ccf";
> +		#clock-cells = <1>;
>   	};
>   
>   	efi-media {
> diff --git a/arch/sandbox/include/asm/clk.h b/arch/sandbox/include/asm/clk.h
> index df7156fe31..1daf2e7ac7 100644
> --- a/arch/sandbox/include/asm/clk.h
> +++ b/arch/sandbox/include/asm/clk.h
> @@ -39,6 +39,7 @@ enum sandbox_clk_test_id {
>   	SANDBOX_CLK_TEST_ID_FIXED,
>   	SANDBOX_CLK_TEST_ID_SPI,
>   	SANDBOX_CLK_TEST_ID_I2C,
> +	SANDBOX_CLK_TEST_ID_I2C_ROOT,
>   	SANDBOX_CLK_TEST_ID_DEVM1,
>   	SANDBOX_CLK_TEST_ID_DEVM2,
>   	SANDBOX_CLK_TEST_ID_DEVM_NULL,
> diff --git a/drivers/clk/clk_sandbox_ccf.c b/drivers/clk/clk_sandbox_ccf.c
> index fedcdd4044..38184e27aa 100644
> --- a/drivers/clk/clk_sandbox_ccf.c
> +++ b/drivers/clk/clk_sandbox_ccf.c
> @@ -284,6 +284,7 @@ static int sandbox_clk_ccf_probe(struct udevice *dev)
>   U_BOOT_DRIVER(sandbox_clk_ccf) = {
>   	.name = "sandbox_clk_ccf",
>   	.id = UCLASS_CLK,
> +	.ops = &ccf_clk_ops,
>   	.probe = sandbox_clk_ccf_probe,
>   	.of_match = sandbox_clk_ccf_test_ids,
>   };
> diff --git a/drivers/clk/clk_sandbox_test.c b/drivers/clk/clk_sandbox_test.c
> index 5807a454f3..c695b69321 100644
> --- a/drivers/clk/clk_sandbox_test.c
> +++ b/drivers/clk/clk_sandbox_test.c
> @@ -15,6 +15,7 @@ static const char * const sandbox_clk_test_names[] = {
>   	[SANDBOX_CLK_TEST_ID_FIXED] = "fixed",
>   	[SANDBOX_CLK_TEST_ID_SPI] = "spi",
>   	[SANDBOX_CLK_TEST_ID_I2C] = "i2c",
> +	[SANDBOX_CLK_TEST_ID_I2C_ROOT] = "i2c_root",
>   };
>   
>   int sandbox_clk_test_get(struct udevice *dev)
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

Reviewed-by: Sean Anderson <seanga2@gmail.com>
