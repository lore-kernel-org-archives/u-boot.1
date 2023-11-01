Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB27C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2871487714;
	Wed,  1 Nov 2023 19:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YIGN3OsN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5A7A87714; Wed,  1 Nov 2023 19:27:29 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBFE876DC
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-418201cb9e9so109271cf.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 11:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698863243; x=1699468043; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tykb2DKGDNe+6CtbUGEReVdbnbVVedVokXn3x0jA7jY=;
 b=YIGN3OsNFWOeQS/uf4olU0k6Wx/W5ccjWg/ZLbeGkS4DK0NsWn9LDV+mgHA7evd22X
 B+cC3sv+gboHnCv7jrzrMO1fG6B3pC9BExwyId7rCy0pyFCmEgAA5REdp/BQbn/j1EVN
 lTxENlY9kDuufJAP6vUO+36k+FM3yHNBgO1G+xTCBzTZEHulsvr45CIGvsGDHfNmWP/i
 hlI5Zb0+xIqmLbI1ku/uwyay+XeNOO74tZ8nwVqcTJ5/moPEQg63yJgREGVpKKTtegoG
 pdGMqykgintpsJ8B8wuVi8tP7niu9FluKkfHSux52KFIRCa5HBFWnTtMdygTuH8j1N9p
 e8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698863243; x=1699468043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tykb2DKGDNe+6CtbUGEReVdbnbVVedVokXn3x0jA7jY=;
 b=aFYotclLisr8fY6ONUy4ZnQTW6HRWF4o2JIKxLuy+GSMneW/1HmKwdYG4qGUGksmMC
 0uWfc7A55e8yTYfqvg62dNEq/DvUi4FO1SztgAxQ0eYXsMqBF1/PwFOIi0+2St6c7fJc
 /+IzW9JSrXA+ARszZuhXLmQse8gQ0uajlA51MZEuNjVEq38ri1Vfus20g4s2yOQjvKBE
 omLx1tIBKF/wZce1REHWIUtTzhSOPL7wL1bdQwVaNGsV5opG5YJW55r3s5fsFNGt4Yeq
 4/AkSzrPYSdlIAFsQntguSarImAVLtK66dNRHUJLwtdnUZr2N3SuL3XV8iOoAPgYbIYm
 1tkA==
X-Gm-Message-State: AOJu0YzZJylj3ovoa/Nl4/cCnccdrHlZ2UTX2LQwJYaua+sD9HGCsUT3
 WI/lYPCpXpKrigvpbvQEk3c=
X-Google-Smtp-Source: AGHT+IE0E569vDQ7GoawXWJ/6r9lppl079YeW+raJ59CMDDfzIb/i8z1L19pl5kg2nnE6HvfqXg/Fg==
X-Received: by 2002:a05:6214:1c48:b0:674:fa5a:45b5 with SMTP id
 if8-20020a0562141c4800b00674fa5a45b5mr6356566qvb.38.1698863242999; 
 Wed, 01 Nov 2023 11:27:22 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 w4-20020a0562140b2400b0066d132b1c8bsm1664437qvj.102.2023.11.01.11.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 11:27:22 -0700 (PDT)
Message-ID: <24a97f82-d872-e57f-2fa8-ded6e74244a4@gmail.com>
Date: Wed, 1 Nov 2023 14:27:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drivers: clk: Adjust temp var data type to properly match
 that of struct clk_ops
Content-Language: en-US
To: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc: greg.malysa@timesys.com, ryan.matthews@timesys.com, trini@konsulko.com,
 Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
References: <20230515195005.1961495-1-nathan.morrison@timesys.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20230515195005.1961495-1-nathan.morrison@timesys.com>
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

On 5/15/23 15:49, Nathan Barrett-Morrison wrote:
> In commit 5c5992cb90cf ("clk: Add debugging for return values"), a
> temporary storage variable was added around the ops->get_rate() call
> inside clk_get_rate(), so that the result could be passed through
> log_ret.
> 
> This temporary variable was declared as an int, yet when we look in
> struct clk_ops, we can see this needs to be a ulong:
> ulong (*get_rate)(struct clk *clk);
> 
> This was resulting in a signed to unsigned casting error on our
> builds, where a clock value of 0xABCDABCD was being incorrectly cast
> to 0xFFFFFFFFABCDABCD.
> 
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> ---
>   drivers/clk/clk-uclass.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index dc3e9d6a26..4e3e3b8537 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -471,7 +471,7 @@ void clk_free(struct clk *clk)
>   ulong clk_get_rate(struct clk *clk)
>   {
>   	const struct clk_ops *ops;
> -	int ret;
> +	ulong ret;
>   
>   	debug("%s(clk=%p)\n", __func__, clk);
>   	if (!clk_valid(clk))

Reviewed-by: Sean Anderson <seanga2@gmail.com>
