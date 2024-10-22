Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338CDD2C54B
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 13:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93B2788FA5;
	Tue, 22 Oct 2024 15:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g2UEJsTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF13088FA7; Tue, 22 Oct 2024 15:24:20 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C25A488D3A
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 15:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d4fd00574so3862800f8f.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729603458; x=1730208258;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=syB2xU9i17UZEkH1sKuqW7aEy/PVCDqbKK3UoReWvDI=;
 b=g2UEJsTAx/XhjU5V+TXlmqVbqyW+aL580kwc/IOt4LC+3PdBxb/UwUh/BekRkBXLYo
 MA1ukYPakmvtVtPUZToqHrU8k6ayLqv17c3dq1DOhuf1dFzudpT0EKJ7voGfSQd4awXb
 1UY/tApw9WuV5zGuIPalLHzY4HtDFjA7ff77aEiVzqLtTKEXbfzDg00g3nIUSo+i93Fh
 KDyFGdeBKLq+TCX6so0jDDQtsNie6sIFuo2GMMT1bj8/X4TJOlU+vttoWv+7WEexm22i
 ul3mNgQBWwKZn5PbL4u/qVzSuTi0tnY+aVUnCNactveI/h4KJQ2fhophfB5amZYidBkd
 TWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729603458; x=1730208258;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=syB2xU9i17UZEkH1sKuqW7aEy/PVCDqbKK3UoReWvDI=;
 b=FDrZviMjrepnxO5/DIKrsX/9eUhX6IdNRtFllJdrqu7r6w4WnEJrqwPWhtUnL6bx2b
 RL3sZBBlI00QBSAUumbVOLaT8J4/uMBuyiqBgeKppLYo1YrYQc6aFzRld+7hI3un5qvH
 IEOkliXUzKWuIKesfsjq6GMTgOAvR1v/SLfQh41rroH8mTRzpvhV1qsIvd1ftbEPKKod
 h+JvR82eBBHhdUUA0lX7SFO7zZy47nQOpINz28rbvwPm0tVVqsF4Mk5V07mGg1seHvj2
 Q5i9fhqW+szJ3oLWp5LTKQGq118CZIgrtOh7YQfm67Ju1darzdXNHDIWeFtzLtU8C0xj
 mzrw==
X-Gm-Message-State: AOJu0YzNzOLXCc8WYIRkM7ADaJTlD7ObwTNqLbA3m2VzjA+8GoTlZPBt
 AsbuPn9aPCQBZJZ4+HboUM3KLY4244FJNhEdTet/y3+hoanG10mbO8T+D1ltqx0=
X-Google-Smtp-Source: AGHT+IHns0rRpQmfdQTEtKZv4weyOloErSD/qfmMMrOtYxYzxMdgYBnsmlWZMvAEAvEdrs/5Zs3rjw==
X-Received: by 2002:adf:e951:0:b0:377:94b:4f51 with SMTP id
 ffacd0b85a97d-37ef12c25f4mr1928626f8f.22.1729603458126; 
 Tue, 22 Oct 2024 06:24:18 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b93ea6sm6678187f8f.84.2024.10.22.06.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 06:24:17 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Guillaume La Roque
 <glaroque@baylibre.com>,
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com,
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
Subject: Re: [PATCH 1/6] bootstd: android: add support of bootimage v2
In-Reply-To: <20241017-adnroidv2-v1-1-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <20241017-adnroidv2-v1-1-781c939902c9@baylibre.com>
Date: Tue, 22 Oct 2024 15:24:14 +0200
Message-ID: <87sesouv7l.fsf@baylibre.com>
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

Hi Guillaume,

Thank you for the patch.

On jeu., oct. 17, 2024 at 18:10, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Android bootmeth only support boot image v3/4.
>
> Add support of Android Boot Image version 2 [1].
> Vendor boot image is only supported in version 3 and 4 so don't try to
> read it when header version if version is less than 3.

Remove: "if version":
don't try to read it when header is less than 3.

>
> 1: https://source.android.com/docs/core/architecture/bootloader/boot-image-header#header-v2

Please use standard link notation (using [1] instead of 1:).
See some examples:

https://source.denx.de/u-boot/u-boot/-/commit/9214627f5ecede8610e33abf2de5a0083f3f80ce
https://source.denx.de/u-boot/u-boot/-/commit/608a31bdec6284ad6f821226e4c62c9cd3052874

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  boot/bootmeth_android.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 19b1f2c377b9..2e7f85e4a708 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -259,16 +259,12 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>  		goto free_priv;
>  	}
>  
> -	if (priv->header_version != 4) {
> -		log_debug("only boot.img v4 is supported %u\n", priv->header_version);
> -		ret = -EINVAL;
> -		goto free_priv;
> -	}
> -
> -	ret = scan_vendor_boot_part(bflow->blk, priv);
> -	if (ret < 0) {
> -		log_debug("scan vendor_boot failed: err=%d\n", ret);
> -		goto free_priv;
> +	if (priv->header_version >= 3) {
> +		ret = scan_vendor_boot_part(bflow->blk, priv);
> +		if (ret < 0) {
> +			log_debug("scan vendor_boot failed: err=%d\n", ret);
> +			goto free_priv;
> +		}
>  	}
>  
>  	/*
> @@ -476,12 +472,13 @@ static int boot_android_normal(struct bootflow *bflow)
>  	if (ret < 0)
>  		return log_msg_ret("read boot", ret);
>  
> -	ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
> -	if (ret < 0)
> -		return log_msg_ret("read vendor_boot", ret);
> -
> +	if (priv->header_version >= 3) {
> +		ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
> +		if (ret < 0)
> +			return log_msg_ret("read vendor_boot", ret);
> +		set_avendor_bootimg_addr(vloadaddr);
> +	}
>  	set_abootimg_addr(loadaddr);
> -	set_avendor_bootimg_addr(vloadaddr);
>  
>  	ret = bootm_boot_start(loadaddr, bflow->cmdline);
>  
>
> -- 
> 2.34.1
