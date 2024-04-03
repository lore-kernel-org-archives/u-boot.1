Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391FDCD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 20:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E38E8824C;
	Wed,  3 Apr 2024 22:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pZGyuZuk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AEFC88249; Wed,  3 Apr 2024 22:33:14 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 365298828D
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 22:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7BA063F274
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 20:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712176391;
 bh=nVs7W73bHY39lyvg1HrBrKCkxP91tmxQ3P4aT2kIGiM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=pZGyuZukDRruisD9aLg5cnUXT/IfF1fALAHvElp9nqMuJbd99bDY2Zuois66kq8Yi
 R6L0vKTBMypb+Zb8Z2GveYOrqEk+35SjSURiMo9cyZA7Qv4UpzVK1vgfCVAGEGQ7qW
 X90vbkQCAGnzRsf4qL5jjFBxolMNA5MdjeErEDZeSdaej+FUrcMvbT9Ep60Mqj2PmN
 OUE8JBkhVHH0Dv2YfyVxlpKc63zCUFKeKUhY7vhwBZ7jPaNP64XuuWlM7DL4yfwd+e
 ZlogKt0HNCZoCNDHsB0S6Bw0Cm2Ux63CM3MIwgPosAqvjienxL4EHacucAVNX9teWK
 3bocBBJVg0aCQ==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-343b9e49248so12258f8f.2
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 13:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712176390; x=1712781190;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nVs7W73bHY39lyvg1HrBrKCkxP91tmxQ3P4aT2kIGiM=;
 b=JwA9pSLxvmLGzWbe/ci05RZytzdsMPJS0xUkCpSZOxMPytW6ZTDGMYNjtVdO780yqO
 ko0T9qtSmslR6ZhT25EhH60T+U/e/3tx8F+NcqS0zJ9t0VQqdxe/Y7Yb/AsXXNGgliyU
 IDB0tTB3QXPVtFGGj0I+i0xAbgc99CyESPZuMehwIltEm+8SadvPG+vh61ecfhKVGm6h
 shgTp2Z12KR6p9R/XS2OCzWKi8+M6kmMvWrR/mEUXTk3TwhUNY/Gc9lek4nzTLFabpEr
 9eZzSMgNgKsanC2DeDf0UWqDUVkLVLqDf2y9ig+6zp61gHZxR0LkS+jiAf5g8EKGtlMf
 iJFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg00vViiDdCJMSjh1zRfpQQ51UADaIEt2nbAwLCU94Y9Dd8uyjEJjCBH1JkrEpn1gHzl3MBZUn5JLILQ/VHaqO0lRnGg==
X-Gm-Message-State: AOJu0YybbYX3sttR88v0Mr7ZmqJwCxvJgz1ZGsPagoU41ojZIucY95zT
 o97Jwf6kWsZ/n4BabqW2yt+yiVwU2LAO0oR4f90XwHblLBM/0uWPO2MkG5P0Ik6OMD1D8Di0MDg
 o1QOVuC+cBabl5ziY+MImEzU/xC9eBSbqxvr4Y6K8q0Y+4oWX2jTePBAe4mQ0a94AsFw=
X-Received: by 2002:a5d:4384:0:b0:33e:c7e9:3360 with SMTP id
 i4-20020a5d4384000000b0033ec7e93360mr334224wrq.18.1712176390014; 
 Wed, 03 Apr 2024 13:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSCBEotClcrahehNZGb8cjbm2CtWBje7sUMrWwHi8qgO7pgRmoa3FQ/skchTwlWxRW6V6H5Q==
X-Received: by 2002:a5d:4384:0:b0:33e:c7e9:3360 with SMTP id
 i4-20020a5d4384000000b0033ec7e93360mr334216wrq.18.1712176389650; 
 Wed, 03 Apr 2024 13:33:09 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 cc13-20020a5d5c0d000000b00341b8edbe8csm15664506wrb.87.2024.04.03.13.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 13:33:09 -0700 (PDT)
Message-ID: <0f74db58-a3e2-4faf-87ce-79fbf64314ff@canonical.com>
Date: Wed, 3 Apr 2024 22:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Don't delete variable from memory if adding a
 new one failed
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ilias Apalodimas <apalos@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20240403154353.440959-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240403154353.440959-1-ilias.apalodimas@linaro.org>
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

On 4/3/24 17:43, Ilias Apalodimas wrote:
> From: Ilias Apalodimas <apalos@gmail.com>
> 
> Our efi_var_mem_xxx() functions don't have a replace variant. Instead we
> add a new variable and delete the old instance when trying to replace a
> variable. Currently we delete the old version without checking the new
> one got added
> 
> Signed-off-by: Ilias Apalodimas <apalos@gmail.com>
> ---
>   lib/efi_loader/efi_variable.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index 40f7a0fb10d5..b6e60626a260 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -342,11 +342,12 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>   		ret = efi_var_mem_ins(variable_name, vendor, attributes,
>   				      data_size, data, 0, NULL, time);
>   	}
> -	efi_var_mem_del(var);
> 
>   	if (ret != EFI_SUCCESS)
>   		return ret;
> 
> +	efi_var_mem_del(var);
> +
>   	if (var_type == EFI_AUTH_VAR_PK)
>   		ret = efi_init_secure_state();
>   	else
> --
> 2.43.0
> 

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
