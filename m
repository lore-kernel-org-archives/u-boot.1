Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD30C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 04:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EEEE88AC4;
	Wed,  1 May 2024 06:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vb/vowpB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6045788AC7; Wed,  1 May 2024 06:30:09 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17B1588AC3
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 06:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6a0f66ed5feso209026d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 21:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714537806; x=1715142606; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NoMOr50Hx/MYtmpJPFARIvvKdF0Mpt8ltnjNRWtD94I=;
 b=Vb/vowpB7zXF34SvmPQ7kHseU3oCzVJ91siXmmaykcaRWR46Qe2dwU88o0bvOHfJJM
 OpGNtCiWsTVqsTEbBWt8IlQ8Desbdp97QF4BbT88IF9X7CJ3Zpxe+rP9vh+U4BsmFeiQ
 XYhNfrfoCapXWrHsHjtR7CfIY/BjhDbRdVkfRZtKrUDSFdvWBybzywuGxP8lIaljT/+T
 d27w7peyqyXWL7C+rBJypiqwbB+5fxrLcGbqTrTOZEebpLFYvYPTUaH9LKSmY/PMgrNH
 cBg6gdGhhHunaZPFNkm6M6Ehny4iB1OBhkIqHG0X8MOo4etAZ7Dc/ZqsvAeSvskl11SE
 SuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714537806; x=1715142606;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NoMOr50Hx/MYtmpJPFARIvvKdF0Mpt8ltnjNRWtD94I=;
 b=LnKsPkCVSjnpyiwnuR30kl504WM5D1BbZaZgnV/MBEivgPnYlLlCM0iZDBCehlON4g
 epKdyrxZA0YexPE/t7kfaH7lf4WZDDfBZAX04o/cVbtdlh6wWkBu1hKmJ9w+f21UqxHV
 HlJsrSkNwh3akbA/HnNUQt85rrGehT1ILTidYFeZ4k58+fwRgscgfp+wZePz8SW3woXZ
 zEYtdVzmhN+evw21kJ3hcTOCNeZw4MZFwUTXjktn4Rluv+J7LICwLEBPRkmQbi2FrQPS
 F9CMyPP0oDSMUtEU9LetdWDh2VQ+5RQE55DdjMM7gGJ4WTKmYPNbvnzLZ8Sin5gNZUR+
 0o/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYKn6lWxLhyjpEygwzThXUTmFyerd2mZgaMEnHvsUi7l6zqdHWL+Oz51nsup3wUCu6rP7SndTUllVKo2Oxm3VIxSdBIA==
X-Gm-Message-State: AOJu0YwMkeqaASUFM9Bm0VZDjB/TvLcSi+BRGwKY63oPgM8S2P391Bn3
 9RzLhbVFLv8iZgjY2HL4SczWkvJZyt+cvbpvEE5T0IKUCqRXLm/vXiC9YA==
X-Google-Smtp-Source: AGHT+IHFkTPg0IA+CLZyzMP3CLP6GUlG7TYvQMx/AgQLXDZ+6v437+YGDpmxiU3uWwwhgClA/ksNow==
X-Received: by 2002:a05:6214:262f:b0:6a0:6e42:601b with SMTP id
 gv15-20020a056214262f00b006a06e42601bmr2907359qvb.8.1714537805799; 
 Tue, 30 Apr 2024 21:30:05 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 t10-20020a05621405ca00b006a0d456f452sm2002162qvz.66.2024.04.30.21.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 21:30:05 -0700 (PDT)
Message-ID: <f53ebf1a-30d0-3149-d713-28443549826b@gmail.com>
Date: Wed, 1 May 2024 00:30:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 118/149] board: sipeed: Remove <common.h> and add needed
 includes
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-118-trini@konsulko.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240501024316.1767971-118-trini@konsulko.com>
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

On 4/30/24 22:42, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Sean Anderson <seanga2@gmail.com>
> ---
>   board/sipeed/maix/maix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/sipeed/maix/maix.c b/board/sipeed/maix/maix.c
> index 06653b5a8765..08077a1f9e13 100644
> --- a/board/sipeed/maix/maix.c
> +++ b/board/sipeed/maix/maix.c
> @@ -3,7 +3,7 @@
>    * Copyright (C) 2019-20 Sean Anderson <seanga2@gmail.com>
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <fdt_support.h>

Reviewed-by: Sean Anderson <seanga2@gmail.com>
