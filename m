Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8897BCDB482
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 19:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E8FA86F42;
	Tue, 17 Oct 2023 21:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JTFq8Y2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9013F86F45; Tue, 17 Oct 2023 21:27:08 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F6F86F20
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 21:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so988505066b.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 12:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697570824; x=1698175624; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vLlMofsUEW76Z8UTNsjmIS9G13WGGRg6rmJmQI5o7SA=;
 b=JTFq8Y2lB4Rrl27lNwdk4R//tCOUzqlnKlIqZx4bWdIe2E+RyH/eYVY1HwYwUFllEw
 8691bNM5tDcwxYG0oUMIpq6YTC7NManiTaiDziUUieUmsvIAsfeYyQMMx6wEy576YvoF
 PR26wH1dWARGaeUgwDyHjBZ+sMz/Ww2pfM00RS6kopYMZfPzulV43lDTq4t1ajXYq3tC
 LKrd+cDB/eAk1XOXNI90GLSPBPis3iz4IspQWl/byM10w73I1QI8Kd/bvnizjV9GMw1c
 FoTN+EZPB5wcZFa2Rbe0Bx0BrOhjCSQW3rzIckxYSfjvcIuvX/a/0xcYVNYazlKI89vK
 wZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697570824; x=1698175624;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLlMofsUEW76Z8UTNsjmIS9G13WGGRg6rmJmQI5o7SA=;
 b=rVUE92FpDNHq70iyQbPvGLFQFiY36yB/4rVuzw8ycIIMe1tTRb1hGFARrJ4ffMruLA
 L84VyDZAh2C4KpQyiHyhr0GVv1AuBADuOlyJbB6F6DaGsnzwDbW21STqZqBmXDjD6yoF
 6UxxB5O1RrtheEjCIH9QRsAXYd2MoEJDegtABXCz5mGC+ZL6H+ljzb4sybRsvW4qUeL3
 CakZEv3BsEm5pZD6pP3eRuPHNsgSY1CI6kP0DMm1uInNhpEzfeng/s9239+1Fkiavw5t
 QLROq7uvUaJUCLh/vVjJ1+cmd6WsHrSG/lKrQ2cshFDmixYO9YLQmdB/ardXgjnDMsIT
 N9Cw==
X-Gm-Message-State: AOJu0YzjBXIf8FgtlWQ3I1NBhlr9GvLM9b3hgk3scIC09lb5bqikW0gp
 P0hXHYVBELdwJ2vnRwmBtaPMQw==
X-Google-Smtp-Source: AGHT+IHmQPkRN+hv8q5/2fT0viVYUNyl2GpFR68fcqVcndjdHn96TdGWz2z5xmjupzth3qq57kwuMA==
X-Received: by 2002:a17:907:70a:b0:9b7:2a13:160c with SMTP id
 xb10-20020a170907070a00b009b72a13160cmr2440661ejb.69.1697570823841; 
 Tue, 17 Oct 2023 12:27:03 -0700 (PDT)
Received: from hades (ppp046103219117.access.hol.gr. [46.103.219.117])
 by smtp.gmail.com with ESMTPSA id
 i27-20020a170906115b00b009b2ba067b37sm277234eja.202.2023.10.17.12.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 12:27:03 -0700 (PDT)
Date: Tue, 17 Oct 2023 22:27:00 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH v7 8/9] cmd: efidebug: add uri device path
Message-ID: <ZS7gBMES7sBTbUu+@hades>
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-9-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016064526.2410856-9-masahisa.kojima@linaro.org>
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

> +			id = (int)hextoul(argv[1], &endp);
> +			if (*endp != '\0' || id > 0xffff)
> +				return CMD_RET_USAGE;
> +
> +			efi_create_indexed_name(var_name16, sizeof(var_name16),
> +						"Boot", id);
> +
> +			label = efi_convert_string(argv[2]);
> +			if (!label)
> +				return CMD_RET_FAILURE;
> +			lo.label = label;
> +
> +			uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
> +			fp_free = efi_alloc(uridp_len + sizeof(END));
> +			uridp = (struct efi_device_path_uri *)fp_free;
> +			uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> +			uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
> +			uridp->dp.length = uridp_len;
> +			if (!wget_validate_uri(argv[3])) {
> +				printf("ERROR: invalid URI\n");
> +				r = CMD_RET_FAILURE;
> +				goto out;
> +			}

This needs to be moved right under label = efi_convert_string(argv[2]);
and group all the checks together early.  You won't have to allocate and
free the memory as well 

> +
> +			strcpy(uridp->uri, argv[3]);
> +			pos = (char *)uridp + uridp_len;
> +			memcpy(pos, &END, sizeof(END));
> +			fp_size += uridp_len + sizeof(END);

Assign this earlier and use it on fp_free = efi_alloc(...)

> +			file_path = (struct efi_device_path *)uridp;
> +			argc -= 3;

[...]

> + *
> + * @uri:	uri string of target file of wget
> + * Return:	true if uri is valid, false if uri is invalid
> + */
> +bool wget_validate_uri(char *uri);
> +
>  #endif /* __NET_H__ */
> diff --git a/net/wget.c b/net/wget.c
> index 2087146b37..6ae2237a0a 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -566,3 +566,74 @@ out:
>  	return ret;
>  }
>  #endif
> +
 
Regards
/Ilias
