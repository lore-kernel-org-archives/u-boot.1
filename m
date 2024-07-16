Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEC0C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54BA9889AD;
	Tue, 16 Jul 2024 09:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ADMDkFku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82E5D8899A; Tue, 16 Jul 2024 09:45:43 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 837468899A
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4266fcb311cso36140505e9.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721115941; x=1721720741;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=v2wLi4EV5MH84ffFoBi3jU0R4u1ekeuziJdegYF0gwA=;
 b=ADMDkFkuo/DsbQPXtAlIWBbZPHj4+8obLLPS/CYq1b/31UX0tR7h1MtdK0gewzFizP
 YLrsQW2rOh2IaVBPixCm7kPG2jqCeWFDaN+WiF2ZNMTB1W9zGM+ByxQrTchV5dDZh3so
 R3+UlJX0qwNcfi3haks8YkKByTK1dl7yG7kNTNyE7/jGVdM1mAcaYDUxCQ7v4xHKn37/
 NP5defYzpPRp+UKmKYqFRsCgNMRzgiEPBBM0V9eu8UmrrmBXKl9o9tHH/IIbHotBGnvI
 noWidgv4WNhlF0rabqMJuwf5+mDkxpAGjbhszgPOoSrNVvPe/dCBrQe62GWOQhHwoOJS
 TbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721115941; x=1721720741;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v2wLi4EV5MH84ffFoBi3jU0R4u1ekeuziJdegYF0gwA=;
 b=ocP9//Ty4GMIDAZMWs957Z1ZgT23g/E/LaYNMu4vP5hZolhT0WQiHGesiyc6mqMwh6
 3u/Nd45OaWJI2GI0OXsyi8rnOCd7ytXBrkV287mNG9yca7K16KdaVN8DaZONlaytz7JX
 MyZsyUa83G1cs9VWopZ0JGY9L2KIlY1K0fuyU9+eTz8Dh2j2vwhKTqlZaA/hgk1QpEaP
 aBvG64Jyt8LCUWcVaAC6lf7wFpJsUlvRUoyvJ4CxMIq6HFVL/44Umd3Bu3L2d9Ob6UVI
 7yVjZJ+pkE8cRnrBb3jvn3EtHsNfj6goiFTGL745bGzikcNk3qMtK9CUbWNXwJYMRFnS
 An/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYOl/rRSoCeZRF0NrVVvEL4zDW40g5nLsZn9yLR/jRO4GInQ+KcOlfqgrlqwjfXqEZYz5PnkcoS69dbG5MpvSs9OPWZg==
X-Gm-Message-State: AOJu0YwRl/35MMfmolPEFiQu8nhkUgP8T5XrHCOm0uOFnHFIsQXTX+Jd
 /fIYYtxfCNGpQaM7hd5LuYfFf8nDNmilxxPt1N+DQvfjoHV2YXZiKFikFpQBt8w=
X-Google-Smtp-Source: AGHT+IFrfhdXFBRboTdjLfGLC5m9lxzPMGeupwX+RBTo9neZe/vCTSC35ip87r4Pu+aU43rIsSPMig==
X-Received: by 2002:a05:600c:470f:b0:426:629f:1556 with SMTP id
 5b1f17b1804b1-427ba6f49a7mr8156375e9.31.1721115940638; 
 Tue, 16 Jul 2024 00:45:40 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f23981fsm149868025e9.4.2024.07.16.00.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:45:39 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 10/14] bootstd: Correct handling of script from network
In-Reply-To: <20240716070419.1897560-11-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
 <20240716070419.1897560-11-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:45:36 +0200
Message-ID: <87frs9n5jz.fsf@baylibre.com>
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

Hi Simon,

Thank you for the patch.

On mar., juil. 16, 2024 at 08:04, Simon Glass <sjg@chromium.org> wrote:

> When reading a script from a network, no block device is available.
> Update the implementation to support this correctly, avoiding setting
> environment variables which relate only to block devices.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> (no changes since v1)
>
>  boot/bootmeth_script.c | 51 +++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 20 deletions(-)
>
> diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
> index 24da47c7259..c5cbf18c2e6 100644
> --- a/boot/bootmeth_script.c
> +++ b/boot/bootmeth_script.c
> @@ -185,31 +185,42 @@ static int script_set_bootflow(struct udevice *dev, struct bootflow *bflow,
>  
>  static int script_boot(struct udevice *dev, struct bootflow *bflow)
>  {
> -	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
> +	struct blk_desc *desc;
>  	ulong addr;
>  	int ret = 0;
>  
> -	if (desc->uclass_id == UCLASS_USB) {
> -		ret = env_set("devtype", "usb");
> +	if (bflow->blk) {
> +		desc = dev_get_uclass_plat(bflow->blk);
> +		if (desc->uclass_id == UCLASS_USB) {
> +			ret = env_set("devtype", "usb");
> +		} else {
> +			/*
> +			 * If the uclass is AHCI, but the driver is ATA
> +			 * (not scsi), set devtype to sata
> +			 */
> +			if (IS_ENABLED(CONFIG_SATA) &&
> +			    desc->uclass_id == UCLASS_AHCI)
> +				ret = env_set("devtype", "sata");
> +			else
> +				ret = env_set("devtype", blk_get_devtype(bflow->blk));
> +		}
> +		if (!ret)
> +			ret = env_set_hex("devnum", desc->devnum);
> +		if (!ret)
> +			ret = env_set_hex("distro_bootpart", bflow->part);
> +		if (!ret)
> +			ret = env_set("prefix", bflow->subdir);
> +		if (!ret && IS_ENABLED(CONFIG_ARCH_SUNXI) &&
> +		    !strcmp("mmc", blk_get_devtype(bflow->blk)))
> +			ret = env_set_hex("mmc_bootdev", desc->devnum);
>  	} else {
> -		/* If the uclass is AHCI, but the driver is ATA
> -		 * (not scsi), set devtype to sata
> -		 */
> -		if (IS_ENABLED(CONFIG_SATA) &&
> -		    desc->uclass_id == UCLASS_AHCI)
> -			ret = env_set("devtype", "sata");
> -		else
> -			ret = env_set("devtype", blk_get_devtype(bflow->blk));
> +		const struct udevice *media = dev_get_parent(bflow->dev);
> +
> +		ret = env_set("devtype",
> +			      uclass_get_name(device_get_uclass_id(media)));
> +		if (!ret)
> +			ret = env_set_hex("devnum", dev_seq(media));
>  	}
> -	if (!ret)
> -		ret = env_set_hex("devnum", desc->devnum);
> -	if (!ret)
> -		ret = env_set_hex("distro_bootpart", bflow->part);
> -	if (!ret)
> -		ret = env_set("prefix", bflow->subdir);
> -	if (!ret && IS_ENABLED(CONFIG_ARCH_SUNXI) &&
> -	    !strcmp("mmc", blk_get_devtype(bflow->blk)))
> -		ret = env_set_hex("mmc_bootdev", desc->devnum);
>  	if (ret)
>  		return log_msg_ret("env", ret);
>  
> -- 
> 2.34.1
