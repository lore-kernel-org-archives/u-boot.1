Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E3FEB28F4
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 08:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3933883AA9;
	Fri,  6 Feb 2026 09:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="P/izZQLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BABF83AA9; Fri,  6 Feb 2026 09:55:08 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD52836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 09:55:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6F06C3F784
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 08:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1770368105;
 bh=vTsZuex4Gxbw3dgVDnAo7Z5QpF+UD8fi8Nv8hlnnbIk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=P/izZQLmpzNP2cb0P138uK/vf4Tb5shEXF2Oq42fxRkRX2OO4eh6edbT0JAS+KL5j
 9RwCzXBgwEq7D5gECXqDaqvf1jOqp0APrfmAyhp86wbUXJBNKBw9Tnv2Hs69PNTE7b
 oft+345VGrJs8OMJRxpav2Y8pz6mwg78xjgaDCVXwfM0/XFNurvTy9EGQVHGNMQiBD
 OToL0lW67Dnm0ki4THkpN2nTgW/txITisGHXrc+M/kggsxIg6gTx+cQv4B2mqlNHul
 jfB+hLQVVUKgYsobk27PtxJq5enQk6PsYBDVdPURd3BQ4yGqbg7lr9pfisev2xPsaX
 O09GJTWpe4ne7wZ8e4jKYk/aWhFcenC/Adq3U7EbrllE3Bj/LKPTP01DHJLalkJuuM
 q4+D+iETakDIgYvHDtNd9mJdD4BfLyVwdRzPMTq26dFaMv4SngRbhBHqmPENoT/XE9
 z4qTBqfuti6nv9qG/seuQF2aQ3CLg/7SL1VJOVXeH0GNIHKYvZKHVBOChOfPTfzpgv
 +oaVFnslP617FW4/hGIyJqqHEuOWr8J/tK7R3qBLBOhQWJClP7GEu9/joWGPScZfpz
 MxRBd9jEVlvjdlRJgMVfrpWXyuOw04TpDu0UyxlVXpNUqUhEBd4a+u5vo9fucUwaaq
 tSnwtOQ8O8Ytt/SYDUo/cRwI=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4802bb29400so16988275e9.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 00:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770368105; x=1770972905;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vTsZuex4Gxbw3dgVDnAo7Z5QpF+UD8fi8Nv8hlnnbIk=;
 b=ewp7juYjaSIeMguGjji/8jaOzh9+lZURRlkjwfrK4H9muyOvhDxIp2MU4ZHG7h5Qgl
 5fKMfgU3QBLu4T8ponZCR6Fblo9ZlJmyVgOd2YaQ6pBxIQ4wCkTvb2xotsHE4FmzJZZt
 g3r8yuhFmbhaiSGYSB3+JPGHr8k7kVcnpcdS8qbHfzEUWUBuZ3cQxSuCUNg46g62juBl
 cJCTEY056wTtbnBOYbDhttL+dpEXIg1HQYQdA9xZj4S5W2QUdlJAghowRP7GJnx+L7//
 kn7Wt0dKDrpDq+eu7kDak3b0kZ+pWYnqJLqeWe8h5qEKc/e/n5up6Kp+fWaT0dbYezvH
 wcEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFAwUxpcj1f+Oeg9plt6pXiHoD1LBBp6CqMIdgY46DEvnukRuChrQp9/rjYnT6yNTCg652LU0=@lists.denx.de
X-Gm-Message-State: AOJu0YzOQ3lBTjqZwe9wPLTS539M8MJiGJVQVJCziuZSX/EEze3w7C/U
 Oe75AuwIkbZ+AOZnPopU78zo+nC5vuEHYmmB9O4qt402OIuXiyF3lle10X8rhMHPQ/Gd1DvKxuV
 1yOma/LwrYVJAiAdhGB890HjJYqCXXMoT9rjJvD9ttXiSPR5vHFkG59kq0EujHQpM/8RWMJI=
X-Gm-Gg: AZuq6aKmGSt3wuRK4zNNqF7eDmDL8BJwI/cj5TKMd1vb2pKKX8xUYWhWuDUhEILo/Uj
 FRvRT6ITPRzvOq3Bsov6JcqlFQY6GnS8lwf6F5eSxPIkCMf58Ke8dHFsiPfjbaubiKJt6QsPe/R
 b3Qi5r+XhcZbYM8jmMw8G40Tegqy0FFBO6NJF/urdc12fM9nrt+FiwHGH8qOFBABASq5Mi4Qbpd
 UxwBH75fcuP/2rrnF844VVbAWQV8welTBcriET5yPrHUVgRYqapRqAcRb5EvswwcNg8JOHiz4DW
 BC17WvZSb7iMNxIoPKj1dAYVyQuPZIywD3roR+5oUiQ8WvMqRxUzWDBjqy/Y9agebKhrK2fKpjn
 YGrE18SU2wViieFr8lK0bkr9O0gcte05rPZdm7UeB7exHnbfFilNVqMcn2G9/3FFt6mjCwavO/h
 CtF+XffXo=
X-Received: by 2002:a05:600c:3113:b0:480:4b59:932e with SMTP id
 5b1f17b1804b1-483201e495fmr26496435e9.11.1770368105028; 
 Fri, 06 Feb 2026 00:55:05 -0800 (PST)
X-Received: by 2002:a05:600c:3113:b0:480:4b59:932e with SMTP id
 5b1f17b1804b1-483201e495fmr26496155e9.11.1770368104582; 
 Fri, 06 Feb 2026 00:55:04 -0800 (PST)
Received: from [192.168.103.128]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320719bf4sm36247905e9.10.2026.02.06.00.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 00:55:04 -0800 (PST)
Message-ID: <d84769eb-75fd-405d-8a3a-4d158a8c9092@canonical.com>
Date: Fri, 6 Feb 2026 09:55:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: fix efi_debug_image_info_normal allocation
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>
References: <20260203125941.1876658-1-vincent.stehle@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260203125941.1876658-1-vincent.stehle@arm.com>
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

On 2/3/26 13:59, Vincent Stehlé wrote:
> When adding a new EFI Debug Image Info entry, we allocate memory for a new
> EFI Debug Image Info Normal structure and we add a new entry into the EFI
> Debug Image Info Table, which is in fact just a pointer to the allocated
> structure.
> 
> However, when allocating memory for the new structure we allocate memory
> for the wrong type, leading to allocating memory for just a pointer instead
> of the desired structure.
> 
> Fix the type used during allocation.
> 
> Fixes: 146546138af5 ("efi: add EFI_DEBUG_IMAGE_INFO for debug")
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   lib/efi_loader/efi_debug_support.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_debug_support.c
> index 490b0bb7088..8d0c133871e 100644
> --- a/lib/efi_loader/efi_debug_support.c
> +++ b/lib/efi_loader/efi_debug_support.c
> @@ -111,7 +111,7 @@ efi_status_t efi_core_new_debug_image_info_entry(u32 image_info_type,
>   
>   	/* Allocate data for new entry. */
>   	ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA,
> -				sizeof(union efi_debug_image_info),
> +				sizeof(struct efi_debug_image_info_normal),
>   				(void **)(&(*table)[index].normal_image));
>   	if (ret == EFI_SUCCESS && (*table)[index].normal_image) {
>   		/* Update the entry. */

