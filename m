Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E86C25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 06:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC1F88813;
	Wed, 22 May 2024 08:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="odGMyFs2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8494C88488; Wed, 22 May 2024 08:29:02 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 761BF8881F
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4202ca70287so2611105e9.3
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 23:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716359340; x=1716964140; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3FehQcu0pgMujl8jUBIM/X6GSdxcROQL1hKKayn2Xok=;
 b=odGMyFs2BctF5EooOMcGh3bJzbH6Iz6OnwhyoL4dKpaquH8w87pXmbRqggyEsVmeEm
 aUpMex6yTsGR8YrcsrowNgIhBo1MlrC5hQHMpJvE85Vs2VfUWswmksy5G82KVj7JqPeu
 PGbOOezKglpQASe1i/OqNMPnhL6GQzyBbU8wleg53baKUL6HV/5y4tCMSalmXj3Y6Jr4
 gtLba8nOK7ZsAPUVmmYslzFeSowusFdMBbl/GZHa9mS91eG0CRljGKipN7HvOHywhpv4
 Djluqc/8ma3TNk9xRctOTJVXC+QBJFkZ3C9/w3mXAFlPQIyODSU+Gpc+XzfIDRnXYkVQ
 OasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716359340; x=1716964140;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FehQcu0pgMujl8jUBIM/X6GSdxcROQL1hKKayn2Xok=;
 b=LpEZHFFT/FtPj3+avghmlMtdrz9tYLA6sBgcVk5XSs+rj5ipu1md0D/LN8gtcTl2X0
 fP1B/TxpNHTpj9LlToj97URaCDThh6OGGT6GQn+vGqiPLbevg1kR75jv5ovimuM6rC6g
 QsVgQ6O8ACrWGwsFSQQm5mDhnfeMBZ/66+jCLEcP76S2WKrIDIfCQE/f/5mLD8uAckGl
 CPII09iW91zcSMSoTjfin2kTTsSgm085MdLtUXJGk3f5VGXVHgd6ZkYd6x/MaHISbJuA
 bvlE92cMYPExNSn1grRlFM8wX0z5o2JnLzVRYY6UwAvV1ajz+TaLn9LHzsPRCMng3u0X
 hoaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXktFqSVL9i/glpYvV+GLPYT+m3msem0ODcrQ8rrOqWDCYMnYnSfmspTai3D08XgBTV10vWr1AHRwFJ7i6YuKgd/rQtmg==
X-Gm-Message-State: AOJu0Yz9GGySTxEhRGkvm77cGvDuK6IzboBWXsRZ+xaqqPbiXSk8/O0m
 foDrpRfrdowOojTSSHfqdu2UTYoMZxBvLrp4rsyQcjvqLtsIocMAn5XJZWct/sw=
X-Google-Smtp-Source: AGHT+IEmXIXeWy2DnhcUKlELT0vG/lDhNxN+MmqIzzhCuw16GpkisAGFPSmpWO5f3+dhL95AZCASmw==
X-Received: by 2002:a05:600c:4fc2:b0:420:e454:1599 with SMTP id
 5b1f17b1804b1-420fd2ffc97mr10111915e9.15.1716359339846; 
 Tue, 21 May 2024 23:28:59 -0700 (PDT)
Received: from hera (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm488335245e9.30.2024.05.21.23.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 23:28:59 -0700 (PDT)
Date: Wed, 22 May 2024 09:28:57 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
Subject: Re: [RFC 10/14] efi_loader: load device-tree specified in boot option
Message-ID: <Zk2QqSXxS6NgonVv@hera>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-11-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426141321.232236-11-heinrich.schuchardt@canonical.com>
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

On Fri, Apr 26, 2024 at 04:13:17PM +0200, Heinrich Schuchardt wrote:
> We allow to specify the triple of binary, initrd, and device-tree in boot
> options.
>
> Add the code to actually load the specified device-tree.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_bootmgr.c | 57 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index d924810a94b..3d58a928b10 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1185,6 +1185,55 @@ out:
>  	return ret;
>  }
>
> +/**
> + * load_fdt_from_load_option - load device-tree from load option
> + *
> + * Return:	pointer to loaded device-tree or NULL
> + */
> +static void *load_fdt_from_load_option(void)
> +{
> +	struct efi_device_path *dp = NULL;
> +	struct efi_file_handle *f = NULL;
> +	efi_uintn_t filesize;
> +	void *buffer;
> +	efi_status_t ret;
> +
> +	dp = efi_get_dp_from_boot(&efi_guid_fdt);
> +	if (!dp)
> +		return NULL;
> +
> +	/* Open file */
> +	f = efi_file_from_path(dp);
> +	if (!f) {
> +		log_err("Can't find fdt specified in Boot####\n");
> +		goto out;
> +	}
> +
> +	/* Get file size */
> +	ret = efi_file_size(f, &filesize);
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +
> +	buffer = malloc(filesize);
> +	if (!buffer) {
> +		log_err("Out of memory\n");
> +		goto out;
> +	}
> +	ret = EFI_CALL(f->read(f, &filesize, (void *)buffer));
> +	if (ret != EFI_SUCCESS) {
> +		log_err("Can't read fdt\n");
> +		free(buffer);
> +		buffer = NULL;
> +	}
> +
> +out:
> +	efi_free_pool(dp);
> +	if (f)
> +		EFI_CALL(f->close(f));
> +
> +	return buffer;
> +}
> +
>  /**
>   * efi_bootmgr_run() - execute EFI boot manager
>   * @fdt:	Flat device tree
> @@ -1200,6 +1249,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
>  	efi_handle_t handle;
>  	void *load_options;
>  	efi_status_t ret;
> +	void *fdt_lo;
>
>  	/* Initialize EFI drivers */
>  	ret = efi_init_obj_list();
> @@ -1215,9 +1265,14 @@ efi_status_t efi_bootmgr_run(void *fdt)
>  		return ret;
>  	}
>
> +	fdt_lo = load_fdt_from_load_option();
> +	if (fdt_lo)
> +		fdt = fdt_lo;
> +
>  	ret = efi_install_fdt(fdt);
> +	free(fdt_lo);
>  	if (ret != EFI_SUCCESS) {
> -		if (EFI_CALL(efi_unload_image(*handle)) == EFI_SUCCESS)
> +		if (EFI_CALL(efi_unload_image(handle)) == EFI_SUCCESS)

You don't need this change. The *handle was a typo in patch #9

Thanks
/Ilias
>  			free(load_options);
>  		else
>  			log_err("Unloading image failed\n");
> --
> 2.43.0
>
