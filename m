Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979C0C46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 07:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CACA787AA8;
	Fri, 29 Dec 2023 08:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j+Npng0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F137387AA8; Fri, 29 Dec 2023 08:32:50 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDE5F87A17
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 08:32:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a235eb41251so753465766b.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 23:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703835168; x=1704439968; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M/vul68KSTdWeczjwJfNRsfbDAzVdeporIR8e9Ox9vw=;
 b=j+Npng0E4acIgyiFwH3ysuH7VRagAI9uVRZhGXeUs1oq8gsxLpXEHqyUxzB/Vt79UI
 yQ6tRR1Z4Nqh9lTvJgrsSRBwOTQESU2OEc86ILM/OBHEplrz0c3vtcqj+vMiWeONuYqz
 FeL0rM2uxF25lHlb5XLbK729wdZdp3jrZDMXRvEvKKjTFJGhpKWVSd02udWwfswOVpHM
 1/zqve5J9DfNpaqQukE3/Ujr9LgwC2J0UOKJ62k8Exmaw5KzTy/f7HkKD9pc7Kf/z8p0
 dHN+SluoNPY/vkw1U/YDJNapNCfgaEd8S08cSjIlBYOBPXXps5ahut2O7T+7R2nJxpjg
 YhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703835168; x=1704439968;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/vul68KSTdWeczjwJfNRsfbDAzVdeporIR8e9Ox9vw=;
 b=FGtsOVr6fuOh6Ts5XTtTLQgFJ1bMNADzu7mLcrWeD/vPUA6+9dYzMw6/KhbDmrAB3k
 7D3YBNQNJKUbOhpXciALkpvkXESMppup6GRZf/mUyf4ztGYKj1kpV6w+zcM8gXega4Lg
 Ib6WsUZbXAdx0rTO32fUhldkLN1lfkbv7+ZRlYhzYbCfwYwLAtMmXdgx3epdLTwqHgR3
 hSQ4d53JfcQ4ACtc1rbLMJ78n2PfOxbaohxHq39OgZKHEE8bsizlWdFHnsSAgiXmI1nu
 T9ZopoSWOzPEbHNV0O9Gux+5wreAQHsYsLD2scY8xrH6gRCAc5hlhk2NSQJzUNN5vL5c
 Pznw==
X-Gm-Message-State: AOJu0YwOOt3l47tLFBCA7dYX3/gMZuuFwtEj4iEIIOPncH5YDlhnfBsQ
 ARBI5y2IOQ2i0g+ijv1QvzAgT33B6ROY5A==
X-Google-Smtp-Source: AGHT+IH/fw9bZ7bNdByWdT64RwvzBFW5pBHrUsj8Stz6UPrKqpIc4lMWBcbxc5bCmiRJuUvGcob1oQ==
X-Received: by 2002:a17:906:1090:b0:a26:8700:16b0 with SMTP id
 u16-20020a170906109000b00a26870016b0mr3364526eju.98.1703835168236; 
 Thu, 28 Dec 2023 23:32:48 -0800 (PST)
Received: from hades (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 zx15-20020a170907348f00b00a1d5444c2cdsm5707455ejb.140.2023.12.28.23.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 23:32:47 -0800 (PST)
Date: Fri, 29 Dec 2023 09:32:45 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 5/9] acpi: enable writing ACPI tables on QEMU
Message-ID: <ZY52HXjJGruD7fM3@hades>
References: <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
 <20231219150408.10949-6-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219150408.10949-6-heinrich.schuchardt@canonical.com>
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

On Tue, Dec 19, 2023 at 04:04:04PM +0100, Heinrich Schuchardt wrote:
> Invoke write_acpi_tables() via EVT_LAST_STAGE_INIT on QEMU except on X86.
> X86 calls write_acpi_tables() in write_tables().
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> v4:
> 	no change
> v3:
> 	no change
> v2:
> 	new patch
> ---
>  drivers/misc/qfw_acpi.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/misc/qfw_acpi.c b/drivers/misc/qfw_acpi.c
> index 6e14b2a504..7ffed1e8c0 100644
> --- a/drivers/misc/qfw_acpi.c
> +++ b/drivers/misc/qfw_acpi.c
> @@ -9,9 +9,11 @@
>  #include <acpi/acpi_table.h>
>  #include <errno.h>
>  #include <malloc.h>
> +#include <mapmem.h>
>  #include <qfw.h>
>  #include <tables_csum.h>
>  #include <stdio.h>
> +#include <linux/sizes.h>
>  #include <asm/byteorder.h>
>  #include <asm/global_data.h>
>  
> @@ -254,3 +256,26 @@ ulong acpi_get_rsdp_addr(void)
>  	file = qfw_find_file(dev, "etc/acpi/rsdp");
>  	return file->addr;
>  }
> +
> +#ifndef CONFIG_X86
> +static int evt_write_acpi_tables(void)
> +{
> +	ulong addr, end;
> +	void *ptr;
> +
> +	/* Reserve 64K for ACPI tables, aligned to a 4K boundary */
> +	ptr = memalign(SZ_4K, SZ_64K);
> +	if (!ptr)
> +		return -ENOMEM;
> +	addr = map_to_sysmem(ptr);
> +
> +	/* Generate ACPI tables */
> +	end = write_acpi_tables(addr);
> +	gd->arch.table_start = addr;
> +	gd->arch.table_end = addr;

is this a typo and should be
gd->arch.table_end = end; ?

> +
> +	return 0;
> +}
> +
> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, evt_write_acpi_tables);
> +#endif
> -- 
> 2.40.1
> 

Thanks
/Ilias
