Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4CEC0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 13:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8A34801B0;
	Thu, 23 Jan 2025 14:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uZKNaWGM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E94280214; Thu, 23 Jan 2025 14:40:24 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32DE480137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 14:40:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso6398365e9.1
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 05:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737639622; x=1738244422;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OHxSkl/lbwFD0ruYcEhtNX4AijEQBEZ6CkOa2XYMyuc=;
 b=uZKNaWGM8hAkBzSpbeBG8hWW3RraQI+BoyHRbHlK2nn3mvFxoKxWF4TESRreaBLqzT
 ImEMi9CP0i0xvlRMGIcMTEZi6ZUS/eexMOAseiXi9Miq8L4kRwnZJkKj35vlqDX4G51K
 +9UlOv1yMpIkwKzEVS2KaJbDFOplpf+0T1aUuUrkSGY+IWDfeaIRlrKESPpH16KpYos2
 QlD7fdXdOBd2WHJ0IPdRd+rrSw10uYiFMzyiwD/nfCm+suqDRTDOJm6w4qpGGbe+MFu6
 nXgg2zTKjUnmpZUP0veKINm5AKvMKX9fxEwh9NFilu6kUSNhjnIbtkc5QDGM7hOCYl9w
 Y3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737639622; x=1738244422;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OHxSkl/lbwFD0ruYcEhtNX4AijEQBEZ6CkOa2XYMyuc=;
 b=MwxLeyftBKvOdtCtoSIXx6H1w/KE9bftdmYYjCp5f3vfHcY9Ni+3S7uWXJZgHZLMlF
 33wQVKB4QXdiyx24UclOBRpPpZVSm5rsEaKNQ7Unut1ySgbVMJvEDs3ghkvIeUIRQ2RX
 /LViL4iVNCcyJDI7E+jLSE1YhGL6CSKxz7tgdqKsUnovDHkQmwQNj9Drq4qixJ15ki9m
 IIwinjqK7A3HeYVGhyeQgSFrJ2Pl7dQ05fwgIfsWoPebR3TPtFDaWXvfLIJBxLIFH4yg
 RKkiPEBxXxRTTdrzQmQO5JGphbRVIDxfuqwxUToINiEQcxsHRexBCiBi/lvJzH/159PB
 ++tA==
X-Gm-Message-State: AOJu0YxOXYy60DfgSGUkldl4OFKg22t+5/xXtHPX3/Wk2PW+2PtgW6hM
 JVxE8V/OLQBd+laItIb/2kFpElWtSPNPvoXiyYkUV3Q8barOpbFt702fiJIDeEg=
X-Gm-Gg: ASbGncvhT8a1LpLd5PFL5o248esT1IWp5wvV3qgddf2tEbo0U6WOn9fiedoHQ1ii8+T
 /12M22UbMGUbFBW9HttghFqZfv+988WAknfOLfHh6yCZ5yz7+TSZ6EZx9zXtVJ+3YITtDgp3nm+
 UlysFp8crmXn7Tp5YzwwTtRAGoeHj62ou4AkFSJ+c3e/y1lGpbhyZqpY70hEOUzPAQYBYxyd/Ir
 xAd1fazvEFUq9R3iVQ0k/WY2D8uZNAF4ymQ8RvRHV3dNprkMdwltPJWiLylVJoaL4LsA/ZWAsM2
 qbhqkLNCbhIRHBmwrz8gcfNTa/DDndIoBl5Wlwyq82Gd
X-Google-Smtp-Source: AGHT+IHgWeCQXVD/oyKHxEdRRUcGlpy4jDupkKcO1rpnkTvvYWdl4CEd7P7EUuGv4G0Lv/RYI68j9A==
X-Received: by 2002:a7b:c8c9:0:b0:436:fb02:e68 with SMTP id
 5b1f17b1804b1-438913bdd6cmr235431305e9.2.1737639621606; 
 Thu, 23 Jan 2025 05:40:21 -0800 (PST)
Received: from localhost ([2a04:cec0:1900:d4b5:e910:e51a:5b57:1fb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b318aae1sm64968295e9.1.2025.01.23.05.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 05:40:21 -0800 (PST)
From: Julien Masson <jmasson@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Guillaume La Roque
 <glaroque@baylibre.com>
Cc: <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v2 2/2] bootstd: android: Allow boot with AVB failures
 when unlocked
In-Reply-To: <20250108-avb-disable-verif-v2-2-ba7d3b0d5b6a@baylibre.com>
References: <20250108-avb-disable-verif-v2-0-ba7d3b0d5b6a@baylibre.com>
Date: Thu, 23 Jan 2025 14:40:20 +0100
Message-ID: <871pwtd4xn.fsf@baylibre.com>
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


On Thu 23 Jan 2025 at 14:40, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

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
>  boot/bootmeth_android.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 2cd167f80280801618a317a65e93a10e70a0d9ee..dc9aad1633bb7a6d577013bfa0f939343f2e066b 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -407,17 +407,26 @@ static int run_avb_verification(struct bootflow *bflow)
>  				 AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALIDATE,
>  				 &out_data);
>  
> -	if (result != AVB_SLOT_VERIFY_RESULT_OK) {
> -		printf("Verification failed, reason: %s\n",
> -		       str_avb_slot_error(result));
> -		avb_slot_verify_data_free(out_data);
> -		return log_msg_ret("avb verify", -EIO);
> -	}
> -
> -	if (unlocked)
> -		boot_state = AVB_ORANGE;
> -	else
> +	if (!unlocked) {
> +		/* When device is locked, we only accept AVB_SLOT_VERIFY_RESULT_OK */
> +		if (result != AVB_SLOT_VERIFY_RESULT_OK) {
> +			printf("Verification failed, reason: %s\n",
> +			       str_avb_slot_error(result));
> +			avb_slot_verify_data_free(out_data);
> +			return log_msg_ret("avb verify", -EIO);
> +		}
>  		boot_state = AVB_GREEN;
> +	} else {
> +		/* When device is unlocked, we also accept verification errors */
> +		if (result != AVB_SLOT_VERIFY_RESULT_OK &&
> +		    result != AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION) {
> +			printf("Unlocked verification failed, reason: %s\n",
> +			       str_avb_slot_error(result));
> +			avb_slot_verify_data_free(out_data);
> +			return log_msg_ret("avb verify unlocked", -EIO);
> +		}
> +		boot_state = AVB_ORANGE;
> +	}
>  
>  	extra_args = avb_set_state(avb_ops, boot_state);
>  	if (extra_args) {
> @@ -427,9 +436,11 @@ static int run_avb_verification(struct bootflow *bflow)
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
> 

Reviewed-by: Julien Masson <jmasson@baylibre.com>
