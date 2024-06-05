Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E8DC27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 11:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4B4588348;
	Wed,  5 Jun 2024 13:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qY6T1X4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABE2588353; Wed,  5 Jun 2024 13:14:45 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99A0D8833C
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 13:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5295e488248so6966731e87.2
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717586083; x=1718190883;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nIW5od/1ZCvo/JXIgqI5X7NbD6j+1EG1xtIxX5/Qato=;
 b=qY6T1X4OIsqPOyRgmU586qwnmvN+wcBrkUNzoPFoe8B8lk+qyWcp+7UFXvoRWub42M
 +oPgxwSyjMzFZcoxeCzO/iWUrtdHIaJ6hYKAK/T8U6vvHktAShI1WZ1phdq58EzUfRnm
 bdImladG2ojGptUaA6OFveuEsuHhnw1romGqmTjQeH28MGacaKVjuhhhxtBhSAaxBs/q
 lfyr4KjCugAzeRgdFVunwnAsoOLYbp14NcpyoLPAx1PxBow6V+KTAeu4c8K3qY/LiLVV
 nPRfcEbGktS3grvt590d5KKLG6qtveVIDpFkk5dZgiVZzfAYKqAiBrLtTXyKq23cpf7R
 Qhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717586083; x=1718190883;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nIW5od/1ZCvo/JXIgqI5X7NbD6j+1EG1xtIxX5/Qato=;
 b=A5/pPnQVIjxnn2Nxbg6aguzS7nww/xTQqufs4If10c7b/3PrDcWcC5B0OjXX9TviSh
 k5kCtsnMMWoD5zNhqkbd1vlgKHGo0gx8MOmAOEJicv+I4ceTDv2JthFYYTOk1jGU7TZ6
 1cSJjuMbP8WKM62FaAtsGSieTCYDgkesj4PTdgFWBsRwvIiacqOMRS6NUH03ZHBgQwpc
 jXSwBg8EbIU51VFduD7+07bFz7VPQZL4/wAfSlKuCeHiTr3ZUPzMReXsUW2gZx1PuSSS
 xegHyuz5YFdQfwP9n6vZcMGuHHiSbzLeO0rJ99JQk6sJCP1BKVyXjYE2z4e5x6L1Mgmd
 weSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDWZl2Ubz/gIDh27/s3be+mWxSCIkkss/v2sfkmhNI2k2zke1BJR4ZMeP2FK0YGR51lduxT+B7JKWD8HCO69u8/Rv1cQ==
X-Gm-Message-State: AOJu0YwZQGc+Bl2+S5gWvw3Pkaee+evrfs1cazDBd7Bx6eeV/l3OcHP1
 l/zH3XgCuqtBi8BgBoNoEpDorsxVhNM8qGCbNe/GtM+uCRmuj3Aul/Zc6ZLqy4M=
X-Google-Smtp-Source: AGHT+IGG2eAF7PbKqWWlaIoUkGz6xdgTOrjBrodfqs5iX/FFxzahjgoBmaVMt+PLJC9xWEO40I6TVA==
X-Received: by 2002:a19:f812:0:b0:52b:8342:e0fc with SMTP id
 2adb3069b0e04-52bab4fcb22mr1340204e87.54.1717586082837; 
 Wed, 05 Jun 2024 04:14:42 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:37b7:f611:56e3:c116?
 ([2a05:6e02:10a5:e010:37b7:f611:56e3:c116])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158149057sm18317145e9.36.2024.06.05.04.14.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 04:14:42 -0700 (PDT)
Message-ID: <44f71d7d-a999-4479-9e7a-be2956b650bb@baylibre.com>
Date: Wed, 5 Jun 2024 13:14:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: bcb: Fix bcb compilation when CONFIG_CMD_BCB=n
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Dmitrii Merkurev <dimorinny@google.com>
Cc: Cody Schuffelen <schuffelen@google.com>, u-boot@lists.denx.de
References: <20240603-bcb-compil-v1-1-4edc2c77eed3@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20240603-bcb-compil-v1-1-4edc2c77eed3@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

hi,

Le 03/06/2024 à 11:04, Mattijs Korpershoek a écrit :
> commit dfeb4f0d7935 ("cmd: bcb: extend BCB C API to allow read/write the fields")
> introduced the bcb_get() function.
>
> When CONFIG_CMD_BCB=n, that function is stubbed.
> The stubbed function has a wrong prototype: value_size arg is missing.
>
> Add the missing argument to fix build when CONFIG_CMD_BCB=n.
>
> Fixes: dfeb4f0d7935 ("cmd: bcb: extend BCB C API to allow read/write the fields")
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   include/bcb.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/bcb.h b/include/bcb.h
> index 1941d8c28b4f..a56b547595a6 100644
> --- a/include/bcb.h
> +++ b/include/bcb.h
> @@ -58,7 +58,8 @@ static inline int bcb_set(enum bcb_field field, const char *value)
>   	return -EOPNOTSUPP;
>   }
>   
> -static inline int bcb_get(enum bcb_field field, char *value_out)
> +static inline int bcb_get(enum bcb_field field,
> +			  char *value_out, size_t value_size)
>   {
>   	return -EOPNOTSUPP;
>   }
>
> ---
> base-commit: ea722aa5eb33740ae77e8816aeb72b385e621cd0
> change-id: 20240603-bcb-compil-d8eaf7074475
>
> Best regards,

Reviewed-by: Guillaume La Roque<glaroque@baylibre.com>

Regards
Guillaume

