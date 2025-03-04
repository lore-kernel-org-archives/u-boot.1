Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEB1C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E87E816AF;
	Tue,  4 Mar 2025 14:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J+IDPZCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20592816AF; Tue,  4 Mar 2025 14:49:24 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 216C68175D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43bc4b16135so12795905e9.1
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741096160; x=1741700960; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qucU/eAU0NwZQba9+FhDjMZs7MAM/TJ9z5A/5cRNon8=;
 b=J+IDPZCAGHEFce3mHGpjPS7Wqn3h7C86/CP08wxvWHfKpWLVN+EJfwA4Hr4vZbBqpv
 MbFix+5GOju2St4f2YNo6XFW2/vw5JMxIBcxd5K9ruadnE/y8fftjAERhrxsmoMrs4jw
 1sAuX7kgTaGv86MXiPwXQOiUBHeuQ08ptBZMIC1WNqjRCE5yrKiYJive5P9HiZuYxanG
 Cbigm85kxNr7SJWW4upHM6PHuNN5iCP1VxSvm/ylvPju9u2ciZBt502rOGeqimuwENUU
 zXWkpI6cg2oTL9qjl0ZqsWN/HOt1bfVgMF7LUV782YWcKBFtOVgupJSqvJHDLI/NwChj
 bkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741096160; x=1741700960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qucU/eAU0NwZQba9+FhDjMZs7MAM/TJ9z5A/5cRNon8=;
 b=hwHFYpBr5ORluNpVwBuvujDv1gISOCGWuXPm6nrB6dvGoLuGbJWCVOKuNUAFtOCDJY
 d04+yWoKuJpE/yz+Du07xlBz/WVeKGVDmN52K90XhZ3XOHlBd7yoP/hrCekcWHYXkxnM
 XgV2JVvXEZUGT0CxvoxRFV51yATupiQfBPhEet375poeKZpC+nW1Bk9HPJJkDW6O8vET
 fCnzGL8DHQeQNT0nhPgxqW9U6qxw03xxjOCqfEYIyOoMWYEjEnJGeT/BeCpNNY7ckILC
 lWsgW86txSwFCmOk0I8nWWVtoQXGkoDimU8rOf61Oi8icWfb/VGXHDg+wuSu2brJGlWs
 O/UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFL2VNXu8lmP/d2nwXSJ6e5BQ4/MG+oHhaC7vyXR+bcSDI9bYLSlCgTyXWxtr79Z1sOoZJSaU=@lists.denx.de
X-Gm-Message-State: AOJu0YxXsiQhnh4FrN+3TcMkCbnzyNgdhyneTd+zscKdZelLG3Y1jJyJ
 lKwzS7oZtCe0BBY2VLrTnLKEjrVK/ViWgU7ifVrndzj3A2ixcni4Vachgnl29i0=
X-Gm-Gg: ASbGncvNEqttA6qvA2u9RxabpYKL1FNySMwP6HskXzb8NUKaceZpyNFrxbQhBE5V2OV
 49CJlTn9HGUKZ0RRBkcHvhws2zF9D4wAOGhy23XchEzkFvlwY3uZD+7GefIiiL+owwBtt6W+45j
 qj8EQOammbyUXYfI6Zf0nmT5M+bmqCO0LEyTllqFsBJIZ7EQoBYIP1ZhWSTbuU8Nbcj+49z2KLj
 v/V6PWFW/kkyEhn+Dn/3yjvXN8nBknCu5Fhkzpx9BxcfnPzKrmfuC8mrUn2XxU005bPBuU9vfer
 JjAVN++ZEyzznPDn2VvSZp7VtEZHxi+s2kNppuzlt71x3d8lumK8DRE=
X-Google-Smtp-Source: AGHT+IG2JizlknD2bCLnhTphNL66IOi9r0RX8j6FSo9TEJxgGpnHtqa/P6vDiWBBcZSmwTbS+xyT5g==
X-Received: by 2002:a05:600c:4182:b0:43b:ce36:7574 with SMTP id
 5b1f17b1804b1-43bce3677camr15399905e9.11.1741096160519; 
 Tue, 04 Mar 2025 05:49:20 -0800 (PST)
Received: from [10.100.0.2] ([45.84.137.215]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc06eba55sm77044335e9.21.2025.03.04.05.49.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 05:49:20 -0800 (PST)
Message-ID: <13373651-dcf9-4860-ac90-9d73134e4424@linaro.org>
Date: Tue, 4 Mar 2025 14:49:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] efi_loader: Clean up usage of structure jmp_buf_data
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Janne Grunau <j@jannau.net>,
 Yao Zi <ziyao@disroot.org>, u-boot@lists.denx.de
References: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
 <20250302142121.150480-5-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250302142121.150480-5-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
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



On 3/2/25 15:21, Heinrich Schuchardt wrote:
> From: Yao Zi <ziyao@disroot.org>
> 
> Structure jmp_buf_data provides the underlying format of jmp_buf, which
> we actually don't care about. Clean up existing code to use the standard
> jmp_buf type. This introduces no functional change.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  include/efi_loader.h          | 4 ++--
>  lib/efi_loader/efi_boottime.c | 9 ++++-----
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 1d75d97ebbc..22b724f311a 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -15,13 +15,13 @@
>  #include <efi_api.h>
>  #include <image.h>
>  #include <pe.h>
> +#include <setjmp.h>
>  #include <linux/list.h>
>  #include <linux/sizes.h>
>  #include <linux/oid_registry.h>
>  
>  struct blk_desc;
>  struct bootflow;
> -struct jmp_buf_data;
>  
>  #if CONFIG_IS_ENABLED(EFI_LOADER)
>  
> @@ -485,7 +485,7 @@ struct efi_loaded_image_obj {
>  	efi_status_t *exit_status;
>  	efi_uintn_t *exit_data_size;
>  	u16 **exit_data;
> -	struct jmp_buf_data *exit_jmp;
> +	jmp_buf *exit_jmp;
>  	EFIAPI efi_status_t (*entry)(efi_handle_t image_handle,
>  				     struct efi_system_table *st);
>  	u16 image_type;
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index bdf9e7e8066..853a1c8c097 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -21,7 +21,6 @@
>  #include <usb.h>
>  #include <watchdog.h>
>  #include <asm/global_data.h>
> -#include <setjmp.h>
>  #include <linux/libfdt_env.h>
>  
>  DECLARE_GLOBAL_DATA_PTR;
> @@ -3199,7 +3198,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
>  	void *info;
>  	efi_handle_t parent_image = current_image;
>  	efi_status_t exit_status;
> -	struct jmp_buf_data exit_jmp;
> +	jmp_buf exit_jmp;
>  
>  	EFI_ENTRY("%p, %p, %p", image_handle, exit_data_size, exit_data);
>  
> @@ -3238,7 +3237,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
>  	}
>  
>  	/* call the image! */
> -	if (setjmp(&exit_jmp)) {
> +	if (setjmp(exit_jmp)) {
>  		/*
>  		 * We called the entry point of the child image with EFI_CALL
>  		 * in the lines below. The child image called the Exit() boot
> @@ -3444,7 +3443,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
>  	struct efi_loaded_image *loaded_image_protocol;
>  	struct efi_loaded_image_obj *image_obj =
>  		(struct efi_loaded_image_obj *)image_handle;
> -	struct jmp_buf_data *exit_jmp;
> +	jmp_buf *exit_jmp;
>  
>  	EFI_ENTRY("%p, %ld, %zu, %p", image_handle, exit_status,
>  		  exit_data_size, exit_data);
> @@ -3511,7 +3510,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
>  	 */
>  	efi_restore_gd();
>  
> -	longjmp(exit_jmp, 1);
> +	longjmp(*exit_jmp, 1);
>  
>  	panic("EFI application exited");
>  out:

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Regards,
-- 
Jerome
