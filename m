Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C04C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 12:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F14D88479;
	Wed, 17 Apr 2024 14:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="g8Qe6RfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10DE988477; Wed, 17 Apr 2024 14:36:06 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B55A8832B
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 14:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A68B33F8E5
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 12:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713357361;
 bh=Ls38EpTnEYH/Lu7+hwoBF3JEZC4yNgtI0Xp1fIMIGpE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=g8Qe6RfNkbiIFVy7hZPVso2bpEyPUWwuKvpuZDSE52oA19X0qPbjt3T1ivTi2/syf
 5M53NiRewhveSynDpw+1BVTVOmBWSw1UORvo6qUTCe/Z2Zhr58ngGenli0AoKT9zcR
 OVd6YoAFmbXD5z6OcEyo2H3HX0cAdQ6yC8djOoZyfwy+7DTdI8gjsTaR3VWRnFGo2m
 +aG/PmOUNUI70Ng8xQkqXPDJsNLRzcaCdypNMLp8i8O5Ha1qEZAXHCAczMVi0yRK2J
 2YuL3iMJvGNab27HMFPV075Au7+g4ZPQ4nPJYbhl3i3zHS+FtD1lXqExC6WyR8PnuU
 Mvd0vgJHxnFiA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-417bf71efb4so4362265e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 05:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713357357; x=1713962157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ls38EpTnEYH/Lu7+hwoBF3JEZC4yNgtI0Xp1fIMIGpE=;
 b=sXf4H2TAWzRtj60qt51yIxoyH/MffuXwic/1zM62eisHkbSD6izaEHmPqvK21o0c6Q
 Et+qRuKD4LFqSs9XFPmoiUfXt7eVxEKF1cjMrkyErk0+ZHKGcYf/XAzDkTCJLyBDH4Ae
 FvPMuNx5Gdu/LmdkUP3bgQe7fiTyIoEGBp+SlopnQdSFc7FtpNpC5WZGjf+/ZNRWVxf7
 VEtjSdeBVqGCop7N5+P8/k1mSnOVEdCCb8ofVPKiVUHsJuFpEmabSii4KmoKGamgUVel
 6zBW+qe1Ccq8MAij37TOClfG/moD4R7IkOpzryfLrwZNVENBDVrgP0Q62fR4ESPpzFkK
 qM7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc8oSDHI73dZ9mkRQk6OwSaE36L2uDo+mmdpMbKwKqAZ6lQlKNpOU4Z+uDW5oKxOzbCrNHu3vMlNi+Gk/ytjlDSqTwPQ==
X-Gm-Message-State: AOJu0YxsU/NlDSgm+kcsaUL4xmRe8A+KuhyKp1xqE5KYhXPkGS7Yc4jU
 SdtlMQp5M6/MPtmxd9OzifKbDWNdp1FB2EinYOzjaNwSxRpS9m8chSWgEr5JhfjudBhEbd2tlGO
 sN1hNrKafvl68lCuMKUbSSxMehzXFPvss19tZ9IgFS/ZLifQUH5dg3JWXSQWCYyRQTUM=
X-Received: by 2002:a05:600c:885:b0:418:98fc:a46a with SMTP id
 l5-20020a05600c088500b0041898fca46amr2049523wmp.15.1713357357601; 
 Wed, 17 Apr 2024 05:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF67+riIEahU/KuWvVLTzGm3uordpLhVXFrS9gMh7n46TDFTaCfb36pjDRzFMVjJ3vSW8j9iA==
X-Received: by 2002:a05:600c:885:b0:418:98fc:a46a with SMTP id
 l5-20020a05600c088500b0041898fca46amr2049509wmp.15.1713357357195; 
 Wed, 17 Apr 2024 05:35:57 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00416b163e52bsm2654024wmq.14.2024.04.17.05.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 05:35:56 -0700 (PDT)
Message-ID: <0d64f0d1-1b8f-4bbc-8ec6-a479ae1925df@canonical.com>
Date: Wed, 17 Apr 2024 14:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] efi_loader: Add OS notifications for SetVariable
 at runtime
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Janne Grunau <j@jannau.net>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Weizhao Ouyang <o451686892@gmail.com>,
 u-boot@lists.denx.de, kettenis@openbsd.org,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240417101928.119115-1-ilias.apalodimas@linaro.org>
 <20240417101928.119115-3-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240417101928.119115-3-ilias.apalodimas@linaro.org>
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

On 17.04.24 12:19, Ilias Apalodimas wrote:
> Previous patches enable SetVariable at runtime using a volatile storage
> backend using EFI_RUNTIME_SERVICES_DATA allocared memory. Since there's
> no recommendation from the spec on how to notify the OS, add a volatile
> EFI variable that contains the filename relative to the ESP. OS'es
> can use that file and update it at runtime
> 
> $~ efivar -p -n b2ac5fc9-92b7-4acd-aeac-11e818c3130c-RTStorageVolatile
> GUID: b2ac5fc9-92b7-4acd-aeac-11e818c3130c
> Name: "RTStorageVolatile"
> Attributes:
> 	Boot Service Access
> 	Runtime Service Access
> Value:
> 00000000  75 62 6f 6f 74 65 66 69  2e 76 61 72 00           |ubootefi.var.   |
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   include/efi_loader.h         |  4 ++++
>   lib/efi_loader/efi_runtime.c | 19 ++++++++++++++++---
>   2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index bb51c0281774..69442f4e58de 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -159,6 +159,10 @@ static inline void efi_set_bootdev(const char *dev, const char *devnr,
>   #define EFICONFIG_AUTO_GENERATED_ENTRY_GUID \
>   	EFI_GUID(0x8108ac4e, 0x9f11, 0x4d59, \
>   		 0x85, 0x0e, 0xe2, 0x1a, 0x52, 0x2c, 0x59, 0xb2)
> +#define U_BOOT_EFI_RT_VAR_FILE_GUID \
> +	EFI_GUID(0xb2ac5fc9, 0x92b7, 0x4acd, \
> +		 0xae, 0xac, 0x11, 0xe8, 0x18, 0xc3, 0x13, 0x0c)
> +
>   
>   /* Use internal device tree when starting UEFI application */
>   #define EFI_FDT_USE_INTERNAL NULL
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index dde083b09665..c8f7a88ba8db 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -10,6 +10,7 @@
>   #include <dm.h>
>   #include <elf.h>
>   #include <efi_loader.h>
> +#include <efi_variable.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <rtc.h>
> @@ -110,6 +111,7 @@ static __efi_runtime_data efi_uintn_t efi_descriptor_size;
>    */
>   efi_status_t efi_init_runtime_supported(void)
>   {
> +	const efi_guid_t efi_guid_efi_rt_var_file = U_BOOT_EFI_RT_VAR_FILE_GUID;
>   	efi_status_t ret;
>   	struct efi_rt_properties_table *rt_table;
>   
> @@ -127,9 +129,20 @@ efi_status_t efi_init_runtime_supported(void)
>   				EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
>   				EFI_RT_SUPPORTED_CONVERT_POINTER;
>   
> -	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
> -		rt_table->runtime_services_supported |=
> -			EFI_RT_SUPPORTED_SET_VARIABLE;
> +	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> +		ret = efi_set_variable_int(u"RTStorageVolatile",
> +					   &efi_guid_efi_rt_var_file,
> +					   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					   EFI_VARIABLE_RUNTIME_ACCESS |
> +					   EFI_VARIABLE_READ_ONLY,
> +					   sizeof(EFI_VAR_FILE_NAME),
> +					   EFI_VAR_FILE_NAME, false);
> +		if (ret != EFI_SUCCESS) {
> +			log_err("Failed to set RTStorageVolatile\n");
> +			return ret;
> +		}
> +		rt_table->runtime_services_supported |= EFI_RT_SUPPORTED_SET_VARIABLE;
> +	}
>   
>   	/*
>   	 * This value must be synced with efi_runtime_detach_list

