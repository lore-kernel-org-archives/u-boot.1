Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB90AE7F154
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 11:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA0E86EBF;
	Fri, 29 Sep 2023 13:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rt6Ogd4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF8D86EC0; Fri, 29 Sep 2023 13:48:16 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E3DB86E6B
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 13:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-533cbbd0153so14572304a12.0
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695988094; x=1696592894; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FFIuqFuDe1iQX20nzjyCxqtbCDdNNZQ4LNoin0ve7Ts=;
 b=rt6Ogd4cIzUbHTq17KYAijtzuxE7nRv+YEpxpzrLE23FcaJ5ntPqv6WmrDqrwIeYTn
 v1CoEfyloBagsmpl0G9CmtB4YhGz+lQ82HGp6KLzbJQ5itLpJAojD0yrVChTCXeQ+00t
 xpnTrWCpHRAQHZj5yc9366qwxoSH2qDkYZ8hFTcmydYKS/rlLBH1SQcJCu56rNMxU6Az
 sEyfMQ9dm4DLbBBb5qsHctBE2C293PhJ/UUeGyVEA1k8+cD82a7Cwy1G1C7oGoBL+NeT
 +KYTEceG524u8cjOWn3EihXAHrg6dKF/9fYhimFStBnbCnvO6uMtlBGhugU7vw5PYEAj
 KC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695988094; x=1696592894;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFIuqFuDe1iQX20nzjyCxqtbCDdNNZQ4LNoin0ve7Ts=;
 b=xGjCpeKqUZIWL2RCdZZMzVtX5i1hGi0wDgmSEndDOvrjkzfjt7P0ohBmH//0v67iDA
 RHU4xRiWGeeJ0jSFTxvjJTPwFsLjZiKz2b1yy3jCSN/CxURpmgPQiUaSP38JusAdK1hZ
 8N2+GorXrHDJIW6NfxRr6/y4N7I2APZoRKGjGsCMs350wubneTvYh5fPD/Wp/SXDL+9y
 558OpAYc2pP1RDqNO9i+a1GTlN/mItwf843Zfl5G88OC4nl1irwZAVR8k5/pfeMV8IqY
 eujXFC4cNyToYmF5qccery1udFezvFD7hRhDMWBQ55ceXxxDoYVPb3DScKcgWvLuYRHX
 hcHw==
X-Gm-Message-State: AOJu0YzvC7Ac+6wpEUSqkeApn3vYEqLNDAL0g2yZRpKqAI8wPz+B4KvP
 PkmBCHLuriXh4HZA4scckoaVxA==
X-Google-Smtp-Source: AGHT+IHpXBHzFIA8rGlqHDaQR/twpc/q1vka2mOoh/Pgct8T1bI461T9mZPZbzaJ0Uc+40ptrDY+Qw==
X-Received: by 2002:a05:6402:558:b0:51d:9399:4707 with SMTP id
 i24-20020a056402055800b0051d93994707mr3539686edx.26.1695988093745; 
 Fri, 29 Sep 2023 04:48:13 -0700 (PDT)
Received: from hades (ppp046103219117.access.hol.gr. [46.103.219.117])
 by smtp.gmail.com with ESMTPSA id
 f5-20020aa7d845000000b005364b54a4basm1296438eds.80.2023.09.29.04.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 04:48:13 -0700 (PDT)
Date: Fri, 29 Sep 2023 14:48:10 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v5 4/7] efi_loader: support boot from URI device path
Message-ID: <ZRa5eiRu+SHvglrp@hades>
References: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
 <20230927093631.1595494-5-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927093631.1595494-5-masahisa.kojima@linaro.org>
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

Hi Kojima-san,


[...]

> +
> +/**
> + * try_load_default_file() - try to load the default file
> + *
> + * Search the device having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> + * then try to load with the default boot file(e.g. EFI/BOOT/BOOTAA64.EFI).
> + *
> + * @dev			pointer to the UCLASS_BLK or UCLASS_PARTITION udevice
> + * @image_handle:	pointer to handle for newly installed image
> + * Return:		status code
> + */
> +static efi_status_t try_load_default_file(struct udevice *dev,
> +					  efi_handle_t *image_handle)
> +{
> +	efi_status_t ret;
> +	efi_handle_t handle;
> +	struct efi_handler *handler;
> +	struct efi_device_path *file_path;
> +	struct efi_device_path *device_path;
> +
> +	if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle)) {
> +		log_warning("DM_TAG_EFI not found\n");
> +		return EFI_INVALID_PARAMETER;
> +	}
> +
> +	ret = efi_search_protocol(handle,
> +				  &efi_simple_file_system_protocol_guid, &handler);
> +	if (ret != EFI_SUCCESS)
> +		return ret;
> +
> +	ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
> +					 (void **)&device_path, efi_root, NULL,
> +					 EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> +	if (ret != EFI_SUCCESS)
> +		return ret;
> +
> +	file_path = expand_media_path(device_path);
> +	ret = EFI_CALL(efi_load_image(true, efi_root, file_path, NULL, 0,
> +				      image_handle));
> +
> +	efi_free_pool(file_path);
> +
> +	return ret;
> +}

We've discussed this on v4, but I am replying here, since you sent a v5 in
the meantime. 
What I ideally wanted to do here is 
- Add the boot option automatically once the disk gets mount (you've
already sent a patch for that)
- Since the boot option is automatically added we could instead of
  searching for BOOTAA64.EFI search for matches with a load option of
  '1234567'.
Is there some timing issue that I am missing which doesnt allow us to do
that ?
 
[...]

Cheers
/Ilias
