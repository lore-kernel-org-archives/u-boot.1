Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBF3D68B12
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 13:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C8998961E;
	Thu, 14 Nov 2024 14:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xg7Mu5/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC43488E41; Thu, 14 Nov 2024 14:25:07 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D5A489623
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 14:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43158625112so5934835e9.3
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 05:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731590703; x=1732195503;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=XRLewryI8oJlKeB7ksVS6GCInVqYjqGsDa9vYHOx9F4=;
 b=Xg7Mu5/zwD4OMkoBEGJljledqIy7c1dSn4JeyW4gApfTWVTn/jWxmky3oNPgYZ41fy
 dRb9OI9fV3LOPoisAi0I5PFD3V+5jBuGXbDmjJ8Nux32YJzGsbGiQXbm7fUqNis8TXuD
 Lu2aDjpTujZguXlNtO1Ib5pbUwZVN6RRORM8u7fMIxsyUz8G2Aag3I2XNPchtBT6voc1
 oAaAnzPgm+KzOOmjWZ/EE7TP+hGlMsTtbMR7eCLfkmjGJNZTE8l7RI0OR3ZTH6QHBXbn
 ie3IoOdtQkxdV5GnevMz+7FoEKd/GXeeITW6q585DXZNR8hFlsORnxZRpJy1y6w0L6Mt
 THeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731590703; x=1732195503;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XRLewryI8oJlKeB7ksVS6GCInVqYjqGsDa9vYHOx9F4=;
 b=K1p1sMB8SjtNoSEf4x5Si80xNVeC/PrjN3Mnfb6CJn6rTOAdKpO1IABqdg4s6R4nsW
 LxOJSPqZ5IHql1wbjicqUY0DZm5LQ0nsfs1MB0UkUlw/EGbjCH9tIlFOHHubDup8TOxw
 tzW2nWw6Qyr7ml8dQ3o+01CB5Xy0LXtC1Eo3CSEeLXdEjWXCGAPK7HvZr+DBoMavbVjP
 7LgJzp5q3gsR5P+el+wSWkFGmN8hk8aJLjHrMtK9ag96C4ZUBpPr0vmLaPIna6elykPd
 1jGU7qitHaKRRWMuyGRhd0x1yE+HKG7cinjrD47S8LSFz9c21u1IpQyOn1fdNHVuQp58
 95sQ==
X-Gm-Message-State: AOJu0YyP64uY2FF+U2ZdtJGIfDYPe9YHHyma7GSqIjhUCQoAE7r9D2cr
 OOgFkkJVqFyvxkVkWElT/fpqSqRQKfVEI+XZ+QK0DHQ3VZXieq4kveTnqwCHeLCRyRMN490ujhf
 O
X-Google-Smtp-Source: AGHT+IHn+1Wm1sezJ5eMUouYhqQgTv0U4XjokGJPTxMkFdbg2y2dyQodYYAv6dq19ptsriqzbYsMdw==
X-Received: by 2002:a05:600c:502b:b0:431:6083:cd38 with SMTP id
 5b1f17b1804b1-432da76fa50mr19312645e9.6.1731590703506; 
 Thu, 14 Nov 2024 05:25:03 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab721b7sm20690865e9.8.2024.11.14.05.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 05:25:02 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Ion Agorria <ion@agorria.com>, Svyatoslav
 Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] fastboot: properly handle unknown partition type
In-Reply-To: <20241113050607.1850472-1-caleb.connolly@linaro.org>
References: <20241113050607.1850472-1-caleb.connolly@linaro.org>
Date: Thu, 14 Nov 2024 14:25:00 +0100
Message-ID: <87h68aaqxf.fsf@baylibre.com>
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

Hi Caleb,

Thank you for the patch.

On mer., nov. 13, 2024 at 06:05, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> In getvar_partition_type() we attempt to find a filesystem driver for
> the partition (of the list of driver enabled in U-Boot), on failure we
> return the error to fastboot and completely bail out of the operation.
>
> However, this should not be a failure, instead we should just default to
> "raw". This allows commands like "fastboot format:ext4 userdata" to work
> if userdata didn't already have an ext4 partition table (or if FS_EXT4
> is disabled in U-Boot), as failing to determine the current partition
> type is not an error in this case.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/fastboot/fb_getvar.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
> index 93cbd598e024..9c2ce65a4e5b 100644
> --- a/drivers/fastboot/fb_getvar.c
> +++ b/drivers/fastboot/fb_getvar.c
> @@ -229,9 +229,10 @@ static void __maybe_unused getvar_partition_type(char *part_name, char *response
>  				       response);
>  	if (r >= 0) {
>  		r = fs_set_blk_dev_with_part(dev_desc, r);
>  		if (r < 0)
> -			fastboot_fail("failed to set partition", response);
> +			/* If we don't know then just default to raw */
> +			fastboot_okay("raw", response);
>  		else
>  			fastboot_okay(fs_get_type_name(), response);
>  	}
>  }
> -- 
> 2.47.0
