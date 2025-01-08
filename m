Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138E8E77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 13:58:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D4D7800DF;
	Wed,  8 Jan 2025 14:58:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PTu9zL5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED34E803DC; Wed,  8 Jan 2025 14:58:29 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C4978006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 14:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso112510455e9.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 05:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736344706; x=1736949506;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ndUmhqUkIp2BPQqLEK8kzxoRrr17IIg8eOs8hS6EvZY=;
 b=PTu9zL5lXFKjlz+w7xeU5ze/MxGIUbNVk99J5Qu5PK39GO0GfhY8KWyaX/NOQ0eyrb
 I1eqJiu8Ua0WMT1/2QNk+hS6m0h0oCTVqbb8EhX8knTKI0geTibrI8jh1XeWD0fyCuiZ
 Y8k6a5y0q277Rwcxgi+UmslDpqHsIj628pFQGMLhiCAt/9tNiqL8dM6xfhRrd6lYg37z
 JQ2RkGxdw8ae2JVYCHloyz1kKMkt2DVCDAmrKputjA9BFjAw0RSg40bU1DAGmF+bIhEy
 uDDw+n7nbm9LDFqJHb9SaMpfso/kRGl1SlktUAPm0IahizCqTJY1xSJMvv8QrQ8h58VI
 rymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736344706; x=1736949506;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ndUmhqUkIp2BPQqLEK8kzxoRrr17IIg8eOs8hS6EvZY=;
 b=o5eCdXipv89pUu2z3q7Wvjq8ycFEP+s81vPqNHeZ5nRasFisck19nrMKmik+o5Nzt4
 5JWB1oqhYNjXU+q/H00q8MUrNBM7rZ8dwR48llULq5zNgqG52X1LSNwoV1llMZDqGhZt
 1Ola66NAuuaTvmOe5yPpU2DGPO4Eqo7n1yPXN8PsC+tg9kVZYYa7A7z+5Kh0M4DdY2u+
 QFNuXW6Gnu2renYfymNV1CW3KsZKXugvmbVnj0IcNn6MN2x6vzCrXWV4a8jmqghwkHE5
 I0+l+kZyMbNALmclYgJcOWveNFwIt3rqzqLrhm9eoplWI3gE2GqlKxp0FZUovVftVUeA
 JkiQ==
X-Gm-Message-State: AOJu0YzvTeUMmWIkzz0zRqbbAJFHvmhcVbLdDIcL7XmDJJWqHUpWhC1j
 3b6kECdj+3w45k6/1r0BQN1wQj7blb8y0+4lqZGQHW9HrebmPpa3XfrgZdYTXPA=
X-Gm-Gg: ASbGncu6vFuBU3unDhyqvFpbwr2htCr6kLNU0GaMv6LdklNItkLnSE9mmnzDp78XLa7
 HZ8SuHk46YgHX1bmcIqk9W1sKwEboa2htjSdTCWZbOKtAoV/TFV7kn6owcmGWQ9INo+RWX9FUUi
 4q6VtOpPCeIdIumUc1XSo9MgD+MyEH/pCCyP/Fr2iyt+c/TsK0tCn8Pg1gX3BMfpUMw3FLNC/Mh
 wYjnlTM9bIiKWcNj+tfdD3cYC0jjFhgjV9byldjsN0nQHWOjkC6G4xFasNx7VBc4Q==
X-Google-Smtp-Source: AGHT+IHNTMfrWbzeMu4eu7cE/+laBy4r23Hkp90InnUKL+o7zdSC7mEDIDAWJek4bL9SgKVvB6NRDA==
X-Received: by 2002:a05:600c:4f06:b0:436:6160:5b81 with SMTP id
 5b1f17b1804b1-436e26b98d1mr26010405e9.14.1736344706311; 
 Wed, 08 Jan 2025 05:58:26 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da6336sm21786955e9.8.2025.01.08.05.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 05:58:25 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Julien
 Masson <jmasson@baylibre.com>, Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] bootstd: android: Allow boot with AVB failures when
 unlocked
In-Reply-To: <20250108-avb-disable-verif-v1-2-009c35710ef4@baylibre.com>
References: <20250108-avb-disable-verif-v1-0-009c35710ef4@baylibre.com>
 <20250108-avb-disable-verif-v1-2-009c35710ef4@baylibre.com>
Date: Wed, 08 Jan 2025 14:58:25 +0100
Message-ID: <87tta9be66.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Please ignore this patch, I've send this a bit too fast and did not test
all the cases.

Sorry for the noise.

Mattijs

On mer., janv. 08, 2025 at 14:43, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> When the bootloader is UNLOCKED, it should be possible to boot Android
> even if AVB reports verification errors [1].
>
> This allows developers to flash modified partitions on
> userdebug/engineering builds.
>
> Developers can do so on unlocked devices with:
> $ fastboot flash --disable-verity --disable-verification vbmeta vbmeta.img
>
> In such case, bootmeth_android refuses to boot.
>
> Allow the boot to continue when the device is UNLOCKED and AVB reports
> verification errors.
>
> [1] https://source.android.com/docs/security/features/verifiedboot/boot-flow#unlocked-devices
> Fixes: 125d9f3306ea ("bootstd: Add a bootmeth for Android")
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  boot/bootmeth_android.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 2cd167f80280801618a317a65e93a10e70a0d9ee..564d21784feb0667bf9bed2a59be0a232601a7dd 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -407,11 +407,16 @@ static int run_avb_verification(struct bootflow *bflow)
>  				 AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALIDATE,
>  				 &out_data);
>  
> -	if (result != AVB_SLOT_VERIFY_RESULT_OK) {
> +	if (result != AVB_SLOT_VERIFY_RESULT_OK && !unlocked) {
>  		printf("Verification failed, reason: %s\n",
>  		       str_avb_slot_error(result));
>  		avb_slot_verify_data_free(out_data);
>  		return log_msg_ret("avb verify", -EIO);
> +	} else if (result != AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION && unlocked) {
> +		printf("Unlocked verification failed, reason: %s\n",
> +		       str_avb_slot_error(result));
> +		avb_slot_verify_data_free(out_data);
> +		return log_msg_ret("avb verify unlocked", -EIO);
>  	}
>  
>  	if (unlocked)
> @@ -427,9 +432,11 @@ static int run_avb_verification(struct bootflow *bflow)
>  			goto free_out_data;
>  	}
>  
> -	ret = avb_append_commandline(bflow, out_data->cmdline);
> -	if (ret < 0)
> -		goto free_out_data;
> +	if (result == AVB_SLOT_VERIFY_RESULT_OK) {
> +		ret = avb_append_commandline(bflow, out_data->cmdline);
> +		if (ret < 0)
> +			goto free_out_data;
> +	}
>  
>  	return 0;
>  
>
> -- 
> 2.47.1
