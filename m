Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B22C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 08:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CBD983692;
	Thu, 24 Jul 2025 10:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aCm3/kwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A2BF836A6; Thu, 24 Jul 2025 10:56:42 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4660683666
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 10:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4555f89b236so6588285e9.1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753347400; x=1753952200; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L/dgIKydSrTAvPOKLEK4s0Mk2cw02ww0r/3Av0RP3fU=;
 b=aCm3/kwXewY9PStkRF5e4LcAO2Gm/oDW8aiSSkJSRxg68JGvdmpBxzKzx1zeeL4kv6
 ygWsnqNis7CmxR2z6uZz0JHOsRKDjexOtZVteGwgoz6lhn7CJhxkD9SoCHpXUUvWR2yR
 K36R6ybkPC6/OAB4YgjxGexiZDIckOUmqwu64YGYTqG83KDP2EYsEl8UvBvr2ULcWygM
 OHFQdupAoPr6HTYrdKajxoLw52SVpS4hJTeH9berI6udleMRR5gmODqO6BY4P15iqc2K
 i0/niKyLNISOhIjljJHLNCYoeABysdFZ80+ltoVE7jWGynmwzTTcOGGBjixY6U/SyAHs
 YSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347400; x=1753952200;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L/dgIKydSrTAvPOKLEK4s0Mk2cw02ww0r/3Av0RP3fU=;
 b=DFgn61S1f4dr4OAPgWzXkj6maapcSUt2rmheoJ4hNtomkx+Nblz9b6BF9ySJc8S5l4
 O7kENx+PmrBdjzouAhcJ6/r4DEnbuJEFJyPSw9Xzuu2Tl4XbywRqhKMTem7/MFUEJIrc
 Wcdk/PjByh7rAZsrwC4M2HimwexKUhzuscbkurgUdqYEX3yhWJpTlfBYZKT2FSz40mq3
 vUv1sgXu0zjjoitKqJJtu43YafpgHDi3xWuiaTDs3HnWlmoq3SjkUvB/2uywDE1VXJxQ
 hSPy63qLGTAALq1GOFcY8LR+9u1antAbETsz/DAz0lBOjnjP2AH+mi8Qz8OB33Sifp0A
 2vtA==
X-Gm-Message-State: AOJu0YwJFBvhqs9SWvyoGXRPyvJLA9zjosuxxfd6HpePjmoZKyyHUOYA
 dGcTDcuz1Io7nJxiS9KLhPQXH+xrNCSkslumokDwY7jS4GhRmR56+aunVc78d+QQLqHBEbzfmqA
 b6WeGEmQ=
X-Gm-Gg: ASbGnctsamFRTXCDACS8dB0eUP834oB8xC4lbL75OYnpw1QnSb101jqscaFIDEo8vGi
 vUzPLF3VDMZf3QxAy0KgseMdqLXwWsAJdfwmy1nDmvh94hSAIDfajJkWQOk5WtVMQI+sv8flalY
 zjLz3U7wc5EMSk5qAtDwBwptMcwQ03TUUmqC0D76SiyX7NdDL4Xq3Ez+7YJ/TR4jLtKpPAgVD7P
 ukNfbVtkA5Q+BoZnjCtxgckIBtog39chzsw3bej9SGdvfXWXzeaoMHbLvs2oiC/CINDSkQx1a8T
 cKKLmTvXDvg24MjkU89FfVqZvHJef5R6vYQv1ByuO2kCsFreM2FmQ8+4X0znH+oZPadxKJijp3u
 /LLHIWozaEh0NBxDytnO4lkCK41wONH4PbpRjEmz0dBBkzzdbpus6K4mwNGkiEa8JS+ZpaDjEe5
 9bJmCcwEjLesyc
X-Google-Smtp-Source: AGHT+IEm56FOIfkABnz4XkSnsU3NRQC2zdh647nMeg2JY+M6OtD245+DyhF+/t/EOMY7THNT/j82wA==
X-Received: by 2002:a05:600c:4f4f:b0:456:1006:5418 with SMTP id
 5b1f17b1804b1-4586987e38bmr43878965e9.13.1753347399559; 
 Thu, 24 Jul 2025 01:56:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce?
 ([2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054ef47sm11888455e9.8.2025.07.24.01.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 01:56:38 -0700 (PDT)
Message-ID: <cd88a1ef-7a55-4c36-81ad-9890ea90e096@linaro.org>
Date: Thu, 24 Jul 2025 09:56:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: nand: Prevent dereference of NULL pointer
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250701-mtd_nand_fixes-v1-1-f31517bdce2e@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250701-mtd_nand_fixes-v1-1-f31517bdce2e@linaro.org>
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

ping?

On 01/07/2025 17:12, Andrew Goodbody wrote:
> In nand_wait_ready there is a loop that includes a NULL check for
> chip->dev_ready before it is dereferenced. Use a NULL check once the
> loop is exited as well to cover the case where it exits due to a timeout
> and it is therefore not known if chip->dev_ready is NULL or not.
> 
> This issue found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/mtd/nand/raw/nand_base.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index d3d1b93947b..48e3685d995 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -566,7 +566,7 @@ void nand_wait_ready(struct mtd_info *mtd)
>   				break;
>   	}
>   
> -	if (!chip->dev_ready(mtd))
> +	if (!chip->dev_ready || !chip->dev_ready(mtd))
>   		pr_warn("timeout while waiting for chip to become ready\n");
>   }
>   EXPORT_SYMBOL_GPL(nand_wait_ready);
> 
> ---
> base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
> change-id: 20250701-mtd_nand_fixes-191e5a19932d
> 
> Best regards,

