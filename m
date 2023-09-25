Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01635CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 12:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CFE486B93;
	Mon, 25 Sep 2023 14:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aw6/hU6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DD7C86BBC; Mon, 25 Sep 2023 14:46:16 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8192786B09
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 14:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32320381a07so2237061f8f.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695645974; x=1696250774; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0DgQ7bUSU5K4BmD9Fvddv8j1xInesxiIjzYAJCDjrw0=;
 b=aw6/hU6CetFmKOW7mQY7FpewVKs1eLhfpEogcUAGveM/2DjH/nqBfTWlHjhfHG3/d6
 Z28tWze6rWc45/31X/VPFHa2l8gkAhLMSq7SVbe8VVBOAL1joxCJcabCRVW3EhtiqjVF
 rxR8bGZ6MtxCDGy9wJaDnLbowpREHw82X8+Biib1HWCltZh/F3c8SEO9p23N/fO19hLA
 d6iFSgA/XWuUxB+hkeSToWe7LAewT46zCJtmRIimqqwgRqFGdKhlWRB6QogROXQhGLi4
 lBG/7A8HYVKOrtP8a995ce4tjNO+Lkc2h9DZ6eA3msQVyQJyg52mU7ETf+WV7GCEFNTJ
 3uXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695645974; x=1696250774;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DgQ7bUSU5K4BmD9Fvddv8j1xInesxiIjzYAJCDjrw0=;
 b=R1Mywsi0SQSZQlBbRs+FMW83u3/Uhwp3aRsrLht0e/iJqMJ/5HM0Is4JEL1cveuHTz
 pbfnqI0hsUNRbpNxVpUZOnpDbzDMttbo99jRETQl+GwxLCRuRPAnvQlkWWFIX8dO+13m
 yANfUZAY1dVudx/4Giv1S9Mvua8tu1lDmPLtLWFrrw0TGWYuTsOOwciMTVjAmRdPIgBA
 qyQ6uzsDvL0qV+zznUikWiVF4d5HCbAdfxjAmcY+wH6azTIiljSxNW6Bzd6snUtCeI7z
 /jEc9j5P67SE2eCX+gH62KeudLdNWENPBKgjxcGp/k2PfbjIGemdaXdSOWKmc1IAhycR
 RxwA==
X-Gm-Message-State: AOJu0YwNWu4EMpdYIUY4KkUzDuy4FmwHQC3S+8Ejgwc8+kWSBddVBdG1
 cC12eJEfABpPmPs6dUXB2fMTrQ==
X-Google-Smtp-Source: AGHT+IFNuYW5S+BjLDUV6QI8ZhHJOwMmqNk6wOqU0BJxUFsf76hlvmtuCj3hAb8IMNDsPew7oZ3N5w==
X-Received: by 2002:adf:ef83:0:b0:317:f714:3be6 with SMTP id
 d3-20020adfef83000000b00317f7143be6mr6117338wro.61.1695645973794; 
 Mon, 25 Sep 2023 05:46:13 -0700 (PDT)
Received: from hera (ppp046103219117.access.hol.gr. [46.103.219.117])
 by smtp.gmail.com with ESMTPSA id
 y23-20020a05600c365700b004052093a8f6sm12176287wmq.25.2023.09.25.05.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 05:46:13 -0700 (PDT)
Date: Mon, 25 Sep 2023 15:46:11 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v4 5/8] efi_loader: set EFI HTTP Boot download buffer as
 reserved
Message-ID: <ZRGBE9HUjLB8f7lS@hera>
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
 <20230922071119.1439482-6-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922071119.1439482-6-masahisa.kojima@linaro.org>
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

Kojima-san,

[...]
>  /* Carve out DT reserved memory ranges */
>  void efi_carve_out_dt_rsv(void *fdt);
>  /* Purge unused kaslr-seed */
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 605be5041e..4991056946 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -326,6 +326,11 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>  			return EFI_INVALID_PARAMETER;
>
>  		ret = load_default_file_from_blk_dev(blk, handle);
> +		if (ret != EFI_SUCCESS)
> +			return ret;
> +
> +		/* whole ramdisk must be reserved */
> +		efi_reserve_memory(image_addr, image_size, true);

Why is this a different patch though?
My concern is code duplication when we add similar functionality in
eficonfig.  Isn't there a better place to handle the memory reservation?

[...]

Thanks
/Ilias

