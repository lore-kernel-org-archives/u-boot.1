Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEE5ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 08:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B5888E83;
	Tue, 10 Sep 2024 10:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cB/NNpQp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C134882BE; Tue, 10 Sep 2024 10:23:19 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 379F588E83
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 10:23:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cae102702so27672265e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 01:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725956596; x=1726561396;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:in-reply-to:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qlIhkS8UQimoGpa8INTiFICikqYb3u/JvWqitb3U3T0=;
 b=cB/NNpQpWEOQjoPYh1Y2JuOu9inIrDxo21UV+OMVi15fKdNEjA/C4Uv5u+ZiC9KFJA
 50mt44LYv7I4UcGImLihN5Oki0h0HQZfwTSXXm9gq8lUlvpZifflLtYg9aXrAvWM4A6A
 WlS/hNrdiL7vCaBA4dktKFNfJfwboMqPq9ydBZOtOual6e9kGCs/i4IY2xNV/PjiAe0o
 y6il5INPfJnD0HImj25RY5LofRKHi+rQ5EkhKOlMNeq8fldg2aG6DoNWpmvIsCmU/eXE
 re41SwBgY0Vlzj7gSsYWAI9W0TdDX3xtRfbLJuEeRfTNtLQDcG2TUSpsgRsZKw0tEti7
 TVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725956596; x=1726561396;
 h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qlIhkS8UQimoGpa8INTiFICikqYb3u/JvWqitb3U3T0=;
 b=wggh9TS5maeW6UwHnW07mUvuiJTu0WH/3QAJIUZLSf/Bo43sChvkX3Hc+I8PLOYxgK
 e2Q9B28vpjROsaO4zmOq+OYM3REdrQZUBtxenNazknR8t+CZS3xH+skeVts8UgL7uIPb
 yjsJwwWxj/4oOUVcRMQ0Xibx71zUpXnkPlaf3UpRBkNJHcOK/1Cb64Rx/OrZsWs7jCmC
 5TkkvfDluWr0Fb72HQEYsDw5hOb8KkIWVqSjG2oan1HI72DXDt+1+Wv/Rt80bEmt0VyE
 ZwgjtovIIJ9WhCfaVf3z0k5PFTB58JfY0zDCaD1JWSPWetJNcKkWpvOjP4XXNk8gS23F
 3f9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm8wYI5srByrc76Pq0JCxEY8dHMayJo70k0Rga19bCjilUxV54iXlDqss4m36ghjrcZMyLbS8=@lists.denx.de
X-Gm-Message-State: AOJu0YztWJntVbAT34TBO27vbV3Cj1UdHylQ1/FqI3LivQbbUOaM+Aa2
 YCXRJ2jLGdDHc5HE65Zr+L5cuCNX7K7wWqdLEYflsdFwBUs7TcFrtE0dw9aC3FY=
X-Google-Smtp-Source: AGHT+IEGvZC1kXWRf3Pj6qmOMa3alsSLZRhy3wKu0QpTSDnL2jCmRC8V51YNRTrVMON26sqWSaLZ6g==
X-Received: by 2002:a05:600c:1ca6:b0:426:6ed5:d682 with SMTP id
 5b1f17b1804b1-42cae70f0e2mr60467395e9.12.1725956596462; 
 Tue, 10 Sep 2024 01:23:16 -0700 (PDT)
Received: from localhost ([89.207.171.77]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb8afc9sm103701525e9.44.2024.09.10.01.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 01:23:15 -0700 (PDT)
From: Julien Masson <jmasson@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Julien Masson
 <jmasson@baylibre.com>, <u-boot@lists.denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>
Subject: Re: [PATCH] bootstd: android: Add U-Boot version to cmdline
In-Reply-To: <20240904-bootmeth-bootloader-version-v1-1-9979a8428566@baylibre.com>
Date: Tue, 10 Sep 2024 10:23:11 +0200
Message-ID: <87plpb9ats.fsf@baylibre.com>
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


On Tue 10 Sep 2024 at 10:23, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> When booting into Android fastbootd (a subset of recovery), the default
> UI shows the bootloader version in the screen [1].
> This is done via the ro.bootloader property which should come from the
> bootloader.
> 
> Provide the U-Boot version via a kernel commandline argument so that
> fastbootd can show it properly on the screen.
> 
> [1] https://android.googlesource.com/platform/bootable/recovery/+/refs/heads/main/fastboot/fastboot.cpp#42
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  boot/bootmeth_android.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 6e8d3e615db0..2fb82a5073de 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -22,6 +22,7 @@
>  #include <malloc.h>
>  #include <mapmem.h>
>  #include <part.h>
> +#include <version.h>
>  #include "bootmeth_android.h"
>  
>  #define BCB_FIELD_COMMAND_SZ 32
> @@ -171,6 +172,12 @@ static int configure_serialno(struct bootflow *bflow)
>  	return bootflow_cmdline_set_arg(bflow, "androidboot.serialno", serialno, false);
>  }
>  
> +static int configure_bootloader_version(struct bootflow *bflow)
> +{
> +	return bootflow_cmdline_set_arg(bflow, "androidboot.bootloader",
> +					PLAIN_VERSION, false);
> +}
> +
>  static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>  {
>  	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
> @@ -267,6 +274,8 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>  	/* Ignoring return code: setting serial number is not mandatory for booting */
>  	configure_serialno(bflow);
>  
> +	configure_bootloader_version(bflow);
> +
>  	if (priv->boot_mode == ANDROID_BOOT_MODE_NORMAL) {
>  		ret = bootflow_cmdline_set_arg(bflow, "androidboot.force_normal_boot",
>  					       "1", false);
> 
> ---
> base-commit: 360aaddd9cea8c256f50c576794415cadfb61819
> change-id: 20240904-bootmeth-bootloader-version-2a2b35fce4cf
> 
> Best regards,
> -- 
> Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 

Reviewed-by: Julien Masson <jmasson@baylibre.com>
-- 
Julien Masson
