Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500A5C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 07:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A403880104;
	Tue, 18 Feb 2025 08:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gtQpgB5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62F8A8043C; Tue, 18 Feb 2025 08:54:38 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29B04800B3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 08:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e058ca6806so3744088a12.3
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 23:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739865275; x=1740470075; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZK/yc6xVk5Sb32YOAEitgGsCumDVmZjkUpwNeGOMPOA=;
 b=gtQpgB5fL8Tn8C9oTqaZw7hpn6uLDaJ01NV/ip6IYq8HTYx3ekuua6jdMCgt18ZAxr
 6aJ8IAbtAeqmc71cr2UsfqgWcL5VbFShxFzgwZE+cAf5dv4a/8DoTVXrFbT04latjFuC
 iahHAlC+Y6RDQGkrRjIL2Tua138tOroJVY1Kumv9obNboSyUfuD7U1NMH0iiLkXbV+uw
 RXuLpLbpoBtgcMcExiafJz4B6TfLWR9yxu1nFB20BQbf5ZfERbdGtgsZazH+8Hw0Q+B2
 saLpj0zL1rfOphPUbbdhe5ZITNpuQ9+umMf10totima6hIkiMgEcUK2J5tunQuLyH6qR
 L+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739865275; x=1740470075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZK/yc6xVk5Sb32YOAEitgGsCumDVmZjkUpwNeGOMPOA=;
 b=EAW8Mn1k+RLg+9OB8On9+y0bsQZd3utYb88PqWHRMSWRPP4w47TdAq6/PYMtmUd+bb
 8qrMJUi7lcbuQ3n5GqPVaChJVIelRbMC8ipP3ypZbhY8VN2TXkRW7jyesSXF+R0pFD4j
 co3tIeiTru3a5G9elzeMAHB1cNcMPwfvLbfqhE/Qhym8GPUjmwdZAXGhVoQwyN1476b5
 4xF9myP0xDcgHifex1HisfwVNjrt1kUrgxAkGbS+TW8SUHrZQr3uorfWDpw25HcK+Ihy
 dteUgJTn67toJO7hjrCu/DlsRvT8fluDslzdjPAlE4sMTdnSGQXCHQXW+Ok2G15P6iNs
 6KqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWopYs0yjK1oGPuf+Zg3eUWHJyHwMSbblJL9EV3qOjiYjl+/wv3QQCw1NKxyPBhGN3zQcuTPug=@lists.denx.de
X-Gm-Message-State: AOJu0YzlrYmEr4jA+Xdtb9d9TXegIro0rbq5NU7NlBwxBVzq7ARNXEiy
 XAm0c3jVPjx9wYuYz7ipa0x5tFm2CXmxePinbtvrY0dLshp0mktH/w8eo6lEQb8=
X-Gm-Gg: ASbGncsMmGNfUfsK0n8nF3T03hGtNoK3fYGZpf2wxz+PPm/gG7oMmcYl83R2Ce//Zhn
 5mfFMH3YhnhVWQWVb7HtTZo4eRV/GYMvUvU/+RPic7YSAfMdlwqvEbSNqBQ+6/JrdQjNcsNuojm
 lK0lcY4Ld2s66CRaLkOxulm+HRrFK4nJcCckFlPZv0RRVICun2ujgPAVGMmfFf6N5Q7UJhTaQlQ
 OZHCI+5wToTtfm+aGykwpEaZno2nMXMUYYOgvUDts6YKxGtVCgRSRxX+U2PU4ueXxC7jtwSpnPu
 K/NE4hymOF7lpKbZG/d1mRIqUfw8b8FlaYkyB/6Er/st36eh
X-Google-Smtp-Source: AGHT+IEkw35vmoOxvV9tyVaGa/wukEdq26n8N2+wZv5Qwp0zMp1ZOPqLKL5SeR+gc/FzJ0aX1+0bPg==
X-Received: by 2002:a17:906:314f:b0:abb:6b1a:7b22 with SMTP id
 a640c23a62f3a-abb70b3b6f4mr1232763466b.29.1739865275559; 
 Mon, 17 Feb 2025 23:54:35 -0800 (PST)
Received: from hades (ppp176092155198.access.hol.gr. [176.92.155.198])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba5a4f4cb4sm928161166b.118.2025.02.17.23.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 23:54:35 -0800 (PST)
Date: Tue, 18 Feb 2025 09:54:31 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Daniel Schultz <d.schultz@phytec.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aashvij Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/3] efi_firmware: set EFI capsule dfu_alt_info env
 explicitly
Message-ID: <Z7Q8t2lCXjikVSm0@hades>
References: <20250213195351.3518305-1-j-humphreys@ti.com>
 <20250213195351.3518305-3-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213195351.3518305-3-j-humphreys@ti.com>
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

Hi Jonathan, 

The patch looks correct but there's a few more things to address.

On Thu, Feb 13, 2025 at 01:53:50PM -0600, Jonathan Humphreys wrote:
> The current implementation of EFI capsule update uses set_dfu_alt_info() to
> set the dfu_alt_info environment variable with the settings it requires.
> However, set_dfu_alt_info() is doing this for all DFU operations, even
> those unrelated to capsule update.
> 
> Thus other uses of DFU, such as DFU boot which sets its own value for the
> dfu_alt_info environment variable, will have that setting overwritten with
> the capsule update setting. Similarly, any user defined value for the
> dfu_alt_info environment variable would get overwritten when any DFU
> operation was performed, including simply performing a "dfu 0 list"
> command.
> 
> The solution is stop using the set_dfu_alt_info() mechanism to set the
> dfu_alt_info environment variable and instead explicitly set it to the
> capsule update's setting just before performing the capsule update's DFU
> operation, and then restore the environment variable back to its original
> value.
> 
> This patch implements the explicit setting and restoring of the
> dfu_alt_info environment variable as part of the EFI capsule update
> operation.
> 
> The fix is fully implemented in a subsequent patch that removes the capsule
> update dfu_alt_info support in set_dfu_alt_info().
> 
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  lib/efi_loader/efi_firmware.c | 39 ++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 5a754c9cd03..1a1cf3b55e1 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -649,8 +649,10 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>  	efi_status_t (*progress)(efi_uintn_t completion),
>  	u16 **abort_reason)
>  {
> +	int ret;
>  	efi_status_t status;
>  	struct fmp_state state = { 0 };
> +	char *orig_dfu_env;
>  
>  	EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
>  		  image_size, vendor_code, progress, abort_reason);
> @@ -663,7 +665,22 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>  	if (status != EFI_SUCCESS)
>  		return EFI_EXIT(status);
>  
> -	if (fit_update(image))
> +	orig_dfu_env = strdup(env_get("dfu_alt_info"));

strdup might fail, we need to check that the orig_dfu_env is !NULL

> +	if (env_set("dfu_alt_info", update_info.dfu_string)) {
> +		log_err("unable to set env variable \"dfu_alt_info\"!\n");
> +		free(orig_dfu_env);
> +		return EFI_EXIT(EFI_DEVICE_ERROR);
> +	}
> +
> +	ret = fit_update(image);

> +
> +	if (env_set("dfu_alt_info", orig_dfu_env)) {
> +		log_err("unable to set env variable \"dfu_alt_info\"!\n");
> +		ret = 1;

This will work but for consistency just use an EFI defined error e.g 
ret = EFI_DEVICE_ERROR;

> +	}
> +	free(orig_dfu_env);
> +
> +	if (ret)

I am not 100% sure this exiting here is useful. If fit_update has succeeded
we have updated our firmware. So I think we should just add a warning here,
that resetting the dfu to its original value failed, and any further dfu
ops will fail. 

>  		return EFI_EXIT(EFI_DEVICE_ERROR);
>  
>  	efi_firmware_set_fmp_state_var(&state, image_index);
> @@ -717,6 +734,7 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>  	u8 dfu_alt_num;
>  	efi_status_t status;
>  	struct fmp_state state = { 0 };
> +	char *orig_dfu_env;
>  
>  	EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
>  		  image_size, vendor_code, progress, abort_reason);
> @@ -747,8 +765,23 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>  		}
>  	}
>  
> -	if (dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
> -			     NULL, NULL))
> +	orig_dfu_env = strdup(env_get("dfu_alt_info"));
> +	if (env_set("dfu_alt_info", update_info.dfu_string)) {
> +		log_err("unable to set env variable \"dfu_alt_info\"!\n");
> +		free(orig_dfu_env);
> +		return EFI_EXIT(EFI_DEVICE_ERROR);
> +	}
> +
> +	ret = dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
> +			       NULL, NULL);
> +
> +	if (env_set("dfu_alt_info", orig_dfu_env)) {
> +		log_err("unable to set env variable \"dfu_alt_info\"!\n");
> +		ret = 1;
> +	}
> +	free(orig_dfu_env);
> +
> +	if (ret)
>  		return EFI_EXIT(EFI_DEVICE_ERROR);
>  
>  	efi_firmware_set_fmp_state_var(&state, image_index);
> -- 
> 2.34.1
> 

Thanks
/Ilias
