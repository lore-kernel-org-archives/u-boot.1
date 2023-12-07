Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE0CC4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 14:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEAEE8715C;
	Thu,  7 Dec 2023 15:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Fi4uU8wv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FB0F87232; Thu,  7 Dec 2023 15:25:09 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D7F486FB8
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 15:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1F24A3F6E6
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1701959103;
 bh=s4ts0vq9WioTVsGuZexk/A42NUKryCT0uHlLXmDhLUo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Fi4uU8wv909cXFIMoVVwch/XiBrFzK4AIP0gSFpS607HvHMUR7UQe1AStohVocSoG
 9yApXBq3meZ4e7+5nu44SxPpZSlOCS3VOq1UBA2BW4mUFn1T65uELOgr4I0CXnhDLa
 Ic1mAe6VHhwayYTH08wAs1yqPSfJzkLfVjrNXDOcZxJ8pghGmA6B587/gV3sIRBuGA
 xDaCwSIghUQ7ieGr0wH7FJGxLhi8xIwCJAmdoyq4vCjato4Iwlzb0QeTHF3Nzvm5TA
 073rG6gQDvSArrE2Kz1cYQosaoNtuZLnENlsfVw/OLJTDz6q+/Ju2lyZZSnkTQIxfa
 TWMmjImBYhC/A==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-332e71b8841so1013077f8f.0
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 06:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701959102; x=1702563902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s4ts0vq9WioTVsGuZexk/A42NUKryCT0uHlLXmDhLUo=;
 b=Xl12yuwiMaDidwAkHNOh0iFaPkkBpKKrywAAutmRrjYXas1T8fkWCXTRYhqm7bripG
 WY9JMIUSwrRAKTLkVB3jSpnm2veqrp2fq7HTemYwPJDyPSLToz/OnYPYL8hlAJTiz2DQ
 FLjkAjzJV4YuteZSW+y1RHKdE6vkF1treSCtN8AUEB4IOxQG2J3Agv67RPGG8soMebp7
 bbRAhsznKmOVR4jFMmHGq1iYtOi+WGF3xVC3R1DI9uHVYf20O6u7CxDEZ7a16peaZlwY
 H7bZAZ0youMVesD5iltQAahgi1j9fkSucAsV44Bk9gpRJetGima1UUcMK7gfDjOQ9EZz
 Aolg==
X-Gm-Message-State: AOJu0Yy/Y6mwYPFhAgQCfXpg/WoveXqkkSDl15UQq6P/ngP5cszZZZul
 lzboexGsx4xEfzExXpYD4c4lOGNPn7YTNnVKjo27/ey3CpwLLwue1QqaZl4pVdqZakxijXKtvuf
 5nh2pBSD+9ffC80DyYZKlSYYS3RrCs1A=
X-Received: by 2002:a1c:7505:0:b0:40b:5e59:ccb2 with SMTP id
 o5-20020a1c7505000000b0040b5e59ccb2mr1776353wmc.147.1701959102740; 
 Thu, 07 Dec 2023 06:25:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXYEFkQfvgwFozdy3GGEy3RMMF2GRI0EqK/BVLP/d7WIITzMEqKpe3DZZEOddnK2nRf6zOUg==
X-Received: by 2002:a1c:7505:0:b0:40b:5e59:ccb2 with SMTP id
 o5-20020a1c7505000000b0040b5e59ccb2mr1776347wmc.147.1701959102306; 
 Thu, 07 Dec 2023 06:25:02 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 az8-20020a05600c600800b004064cd71aa8sm2072506wmb.34.2023.12.07.06.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 06:25:01 -0800 (PST)
Message-ID: <9d9bdc85-1924-4a1e-8021-9b12a7df7713@canonical.com>
Date: Thu, 7 Dec 2023 15:25:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bootstd: Fix a memory leak in the efi manager bootflow
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, sjg@chromium.org
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
References: <20231207123636.26264-1-ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231207123636.26264-1-ilias.apalodimas@linaro.org>
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

On 07.12.23 13:36, Ilias Apalodimas wrote:
> efi_get_var() allocates memory which has to be freed after the value of
> the variable is consumed. Free the memory properly
> 
> Fixes: f2bfa0cb1794 ("bootstd: Make efi_mgr bootmeth work for non-sandbox setups")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
> Apologies for the quick resend but the previous patches wasn't compiling due to
> the missing #include <malloc.h>
> 
> Changes since v1
> - Add #include <malloc.h> since it's needed for free()
> 
>   boot/bootmeth_efi_mgr.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> index e6c42d41fb80..6428c096d7f8 100644
> --- a/boot/bootmeth_efi_mgr.c
> +++ b/boot/bootmeth_efi_mgr.c
> @@ -16,6 +16,7 @@
>   #include <dm.h>
>   #include <efi_loader.h>
>   #include <efi_variable.h>
> +#include <malloc.h>
> 
>   /**
>    * struct efi_mgr_priv - private info for the efi-mgr driver
> @@ -65,6 +66,7 @@ static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>   	bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
>   				&size);
>   	if (bootorder) {
> +		free(bootorder);
>   		bflow->state = BOOTFLOWST_READY;
>   		return 0;
>   	}
> --
> 2.40.1
> 

