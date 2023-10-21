Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E9ACDB474
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 02:39:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B0F987286;
	Sat, 21 Oct 2023 04:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m7IF9SRP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A06D6874CA; Sat, 21 Oct 2023 04:39:17 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0225C86FBD
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 04:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41cda69486eso6750101cf.3
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 19:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697855951; x=1698460751; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BtgH5whcD6GNYL4ttFliBIMymm8atHNag9I3rHcoN40=;
 b=m7IF9SRPuX6qAqbgWopLTbY0c9JRq3uuWIw9lYv81yRU3JSC+UPAzjO+us4JEBCGsU
 j8+6jPB32ePAfxgmyaVRAeyPt1j9KbQiSbcKT/R1m84tQdRaxC2MYj4ijhH0RK7nIGL9
 3wai57tfU+hDQ36mg7PvHM6igqiU71r+kCrwW4mDwZ98N5SKp66D53/Es5FYNfUPHxH3
 EW9uYHkvNyX1T4rUCHf3RN3CH88PAtLNn9290KoAH62xzKP2aCve0SKU4/VVzHFtt7o6
 P4zllsvJM6X0QJAh0do8MSfh0xpjmaY1rVsVRF7/xpp/xb0JmNGjVGJi6ZWEPjwlutc1
 WT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697855951; x=1698460751;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BtgH5whcD6GNYL4ttFliBIMymm8atHNag9I3rHcoN40=;
 b=aut5DQaA1QpBnSpkyX5KawbwkMoaBMMOoJk34T8qWRFxTHD1ekLcnHuRLEFWLW6IQ1
 Dk8ZncWHzOtHCkI/KJd/3lNjD6I2XmKJJ0u9piNwplpceC64rgjMiPKjMxyCO577ibN0
 SGCMKNyhWcS5h7N25Ddi8JF2M7sXRUNbLxwthR0hq+njsUoyhI9glrhHmSaImC5lTuk+
 EYGX3QYJyifTtyTZYcKGqV15MVMxpIArDUeoDJV7DIpl3+4YiXSL31f0fRaXu7uPImsr
 LfMAzS5PYWYUEUFlgDDi7JxAOtiV5Bpispz4JxMFTGEggJ/OIIShD+oWKE8IQPgHCT7y
 Uekw==
X-Gm-Message-State: AOJu0YzbfiWXUyorLYxo5ZORv8EhptNbXZudL2O4Qs287PTWRcKk397+
 UUT81Op4a9noxzf2AuPVu2g=
X-Google-Smtp-Source: AGHT+IEi7K6WLylkB0gJarUqDuDJmSxn4sPkKNeFDt17TsebcLJ4UpEDbSLWWxxiSQL0/vt7SFfgxQ==
X-Received: by 2002:a05:622a:10:b0:41c:dbdb:7ff5 with SMTP id
 x16-20020a05622a001000b0041cdbdb7ff5mr3008747qtw.33.1697855950619; 
 Fri, 20 Oct 2023 19:39:10 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 bb5-20020a05622a1b0500b00403cce833eesm1063168qtb.27.2023.10.20.19.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 19:39:09 -0700 (PDT)
Message-ID: <9443dc0e-f191-7266-64c8-6fb644b22d42@gmail.com>
Date: Fri, 20 Oct 2023 22:39:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [v4 24/24] clk_k210.c: Clean up how we handle nop
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20231019150105.714407-1-trini@konsulko.com>
 <20231019150105.714407-24-trini@konsulko.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231019150105.714407-24-trini@konsulko.com>
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

On 10/19/23 11:01, Tom Rini wrote:
> Now that sandbox has <asm/barrier.h> and defines nop() there we should
> include that in our driver for clarity and then remove our local nop()
> from <k210/pll.h>.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> I can see that our ARM <asm/barriers.h> should be <asm/barrier.h> and
> updated in a few other ways to match how the kernel is currently.  This
> is not a big deal yet as this driver is only for sandbox for risc-v
> 
> Cc: Sean Anderson <seanga2@gmail.com>
> ---
>   drivers/clk/clk_k210.c | 1 +
>   include/k210/pll.h     | 3 ---
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk_k210.c b/drivers/clk/clk_k210.c
> index c534cc07e092..b9469b93853b 100644
> --- a/drivers/clk/clk_k210.c
> +++ b/drivers/clk/clk_k210.c
> @@ -16,6 +16,7 @@
>   #include <dt-bindings/mfd/k210-sysctl.h>
>   #include <k210/pll.h>
>   #include <linux/bitfield.h>
> +#include <asm/barrier.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> diff --git a/include/k210/pll.h b/include/k210/pll.h
> index fd16a89cb203..175c47f6f233 100644
> --- a/include/k210/pll.h
> +++ b/include/k210/pll.h
> @@ -16,9 +16,6 @@ struct k210_pll_config {
>   #ifdef CONFIG_UNIT_TEST
>   TEST_STATIC int k210_pll_calc_config(u32 rate, u32 rate_in,
>   				     struct k210_pll_config *best);
> -#ifndef nop
> -#define nop()
> -#endif
>   
>   #endif
>   #endif /* K210_PLL_H */

Reviewed-by: Sean Anderson <seanga2@gmail.com>
