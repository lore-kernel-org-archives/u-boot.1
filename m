Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649BCD5C0C5
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A3B8892E5;
	Fri,  8 Nov 2024 14:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S5yjToYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF55988EBA; Fri,  8 Nov 2024 11:08:56 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B7E38904D
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 11:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massonju.eseo@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d808ae924so1232375f8f.0
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 02:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731060534; x=1731665334; darn=lists.denx.de;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=DRLYTdOM6l0kAvtmGPa77gHpnx7MiBdeWBTsHLMJxmo=;
 b=S5yjToYfNouPiLqBmjoYI2rncxSIdNHNUs4WDzFFF9aYli1VcQfDrwXxExaKgxRXCb
 wCF2JpNXfKErapx5RIk74fhKPMtF4XejapsvNscpYJNQiPvWnYVdhJys+nzb7b1wL7x0
 GDjKWbslXvMGEOHRFvfCHfJwhQd38xlixDisIfYr7DDaI5BXoBak+EEnZclEM4aYc2EU
 hU5n8MjFmtm0HYlJW/05OSQdOgCmf7vtBodBWe8pk7RQAoj1uvGnM7DhXP9RRY5p1mmo
 RqEPg3dqUDVs1cuc33iLGQmuar8/200SNb+kVTYrxenJcI6ET725i/hmx9w/WZd5pxVJ
 k04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731060534; x=1731665334;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DRLYTdOM6l0kAvtmGPa77gHpnx7MiBdeWBTsHLMJxmo=;
 b=iZZqTTuu1SvCvG9JT/dPhPgb/K8ijTWeiTSTXS19MbUzjLHvmYsTlh5+mn1MIwnvtK
 sMv/kCXtKL6JL+yqw0ubGvZQ290N4aOxRhGa20tSLSXgQlKY1ZQs14fGLkxE40X6Hub9
 KhYY3EPfFwmhnFa8oBAXSUmkFDukcQKAN3xhrh8WnbyhupmRDSsqt8zdpUcVw1xpkT2d
 VF47UUamTKKiKyKifmbWFtsT3HGagNIPvTVq+VsLuqOsYaUZtVuEiPdT886DRgzGHO3F
 r9uTjVBPXd7ON/0kMg4aewoWCyAQ6afh8ldE0jgQA867lU9V+XAOGpGJJME6BC1dy8rY
 q7bQ==
X-Gm-Message-State: AOJu0YxJvNoT176gF5e7w1g6cZztDrbgrecOJpVo8iCFwFcIql3Xr41o
 wl7u5HBdHTfrMywsK11wISe+ToYRrdNLeDtbMiv8rPMTg2SGFjUS
X-Google-Smtp-Source: AGHT+IHQAbWx+puJ5qS+WpcRF4XXnLDrl12pxr7CQ6HnnCW0DmfzuKFMcLgprHBLI70LrNS8Q7ra6A==
X-Received: by 2002:a05:6000:1449:b0:381:b716:2470 with SMTP id
 ffacd0b85a97d-381f1883dc8mr1832563f8f.40.1731060533858; 
 Fri, 08 Nov 2024 02:08:53 -0800 (PST)
Received: from localhost ([2a04:cec2:a:e411:4963:a2f2:7806:b10e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda04211sm4122711f8f.94.2024.11.08.02.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 02:08:53 -0800 (PST)
From: Julien Masson <massonju.eseo@gmail.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, Guillaume La Roque
 <glaroque@baylibre.com>,
 <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>,
 <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
Subject: Re: [PATCH 1/6] bootstd: android: add support of bootimage v2
In-Reply-To: <20241017-adnroidv2-v1-1-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
Date: Fri, 08 Nov 2024 11:08:52 +0100
Message-ID: <8734k2javf.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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


On Fri 08 Nov 2024 at 11:07, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Android bootmeth only support boot image v3/4.
> 
> Add support of Android Boot Image version 2 [1].
> Vendor boot image is only supported in version 3 and 4 so don't try to
> read it when header version if version is less than 3.
> 
> 1: https://source.android.com/docs/core/architecture/bootloader/boot-image-header#header-v2
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
> 
> 
>

Tested on mediatek MT8365 EVK board with boot image V2.

Tested-by: Julien Masson <jmasson@baylibre.com>
-- 
Julien Masson
