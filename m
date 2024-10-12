Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0FECF2564
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 11:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E060288A1C;
	Sat, 12 Oct 2024 13:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="spPbE0dG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72FD588C9C; Sat, 12 Oct 2024 13:05:13 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C84B88901
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 13:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4311c575172so16134715e9.2
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 04:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728731111; x=1729335911;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yrLx217Q/yikaZugYKAAmEkE2SP6n1WsqiWlkkB8bsM=;
 b=spPbE0dGA1KYfwr2BW2qScx603ZCgelXImK6DRjNrGDAbEktLRVh0r8BWjEzEfVSTw
 uJyigOPOQNnDwPzdXsMPlAK4q9JVhYvT+qyUWM3PMsyz42ViDMic/wD/xBKo/I4hlyld
 FWKVKxP25cX2xcHj99lS1tj3gBUq7tXQo+bv6vP6JdElTzjsGfPWwpQLiit1hFkC3SrY
 g+iphyeAoT6YbGkHq1IsuQEaKN6sZ17TTMKraQXyHxlAmbLvk6e/t+/lm7R0IOqcLeWF
 wRMnz27yecqVAY21yglTLHjMXAaBClFqMxdtTFMLRl3fa2+4C87l+Yog8J1bSIEQilLA
 Loug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728731111; x=1729335911;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yrLx217Q/yikaZugYKAAmEkE2SP6n1WsqiWlkkB8bsM=;
 b=tdyOWKx07s2A1KpqICtgzbZrEdY2dUpiYL2adWqw0hyBv25B5kBA3GqWqc28Venv/s
 YmoNkyv2BBfoB9p54zHNRoq9Gt7TlUrB50RpVz6J2GKbNpzcw7291Gsp5x6U7DbkSXs9
 iHgl4+SISkj1tZkn6scyihowtswdjx/8fqNGW5wpI9JMde0UC7d2EwTh+OH+HIEyY4la
 ZYPbHEVCIY3xqqfDqC3up2Sa+hPtEUqFP4pbLaNB8tNg8EBpjnwydWgOp63b9fc5spT/
 r80JfuHvd03S41tbuxdnjCfS8m0MEdZYTN1JN7CKZ2CCt8tUjNP++8N55HKCJQU8bE+9
 nIwg==
X-Gm-Message-State: AOJu0Yx0oeXF4mfr3FRrUPlpLegc0T8FnVkjBuaQHtmRNyPZ6xkopZ5j
 Q6m626nD8dtqBZ6BbZQwPqPdLeRqwR5TAQxUGuJzGhJw2lAFSOZzRdNdNSxkhX8=
X-Google-Smtp-Source: AGHT+IHRmmaxscQPORhnIFWEPaU3isMnjsn8pU/7RlfOpnd402abQF2c5RsRxVvXORMd25BDyPBOjA==
X-Received: by 2002:a05:600c:5117:b0:42c:b9c7:f54b with SMTP id
 5b1f17b1804b1-4311dee59aamr53162665e9.16.1728731110648; 
 Sat, 12 Oct 2024 04:05:10 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:e40:30d4:b1ee:f034?
 ([2a05:6e02:10a5:e010:e40:30d4:b1ee:f034])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf4b1a0sm96163375e9.14.2024.10.12.04.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 04:05:10 -0700 (PDT)
Message-ID: <643e645b-01a4-4f51-8930-2e469a14a711@baylibre.com>
Date: Sat, 12 Oct 2024 13:05:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] configs: khadas-vim3{l}: Increase boot/recovery
 partition size
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
References: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
 <20241011-yukawa-aosp-parts-v1-1-7d74aa13ff8e@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20241011-yukawa-aosp-parts-v1-1-7d74aa13ff8e@baylibre.com>
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

Hi,

Le 11/10/2024 à 17:51, Mattijs Korpershoek a écrit :
> The Android Common Kernel is over 34MiB now [1]. This does not
> include any kernel modules nor the Android ramdisk.
>
> To make sure we are future proof, increase both recovery
> and boot partitions to 64 MiB.
>
> [1] https://source.android.com/docs/core/architecture/kernel/gki-android15-6_6-release-builds
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   include/configs/khadas-vim3_android.h  | 8 ++++----
>   include/configs/khadas-vim3l_android.h | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
> index da6adf6c413a..b76e049f09cc 100644
> --- a/include/configs/khadas-vim3_android.h
> +++ b/include/configs/khadas-vim3_android.h
> @@ -21,8 +21,8 @@
>   	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
>   	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
>   	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
> -	"name=boot_a,size=32M,bootable,uuid=${uuid_gpt_boot_a};" \
> -	"name=boot_b,size=32M,bootable,uuid=${uuid_gpt_boot_b};" \
> +	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
> +	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
>   	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
>   	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
>   	"name=rootfs,size=-,uuid=" ROOT_UUID
> @@ -33,8 +33,8 @@
>   	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
>   	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
>   	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
> -	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
> -	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
> +	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
> +	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
>   	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
>   	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
>   	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
> diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
> index b1768e2d8211..0ab8ffd372a4 100644
> --- a/include/configs/khadas-vim3l_android.h
> +++ b/include/configs/khadas-vim3l_android.h
> @@ -21,8 +21,8 @@
>   	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
>   	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
>   	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
> -	"name=boot_a,size=32M,bootable,uuid=${uuid_gpt_boot_a};" \
> -	"name=boot_b,size=32M,bootable,uuid=${uuid_gpt_boot_b};" \
> +	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
> +	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
>   	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
>   	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
>   	"name=rootfs,size=-,uuid=" ROOT_UUID
> @@ -33,8 +33,8 @@
>   	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
>   	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
>   	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
> -	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
> -	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
> +	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
> +	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
>   	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
>   	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
>   	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

