Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE83CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 10:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E9BA86BE7;
	Mon, 25 Sep 2023 12:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oe5ZFoRH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E0D486BB2; Mon, 25 Sep 2023 12:52:08 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FB8A86BE7
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 12:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32320381a07so1985662f8f.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 03:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695639126; x=1696243926; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QDAzQe+OvGmSqdrOeEWuBv56wcLddCGGELKoz8MM1c0=;
 b=oe5ZFoRHCGFImsmJdbFYKmCSe+nsZ7IPDbiZR+CscIGI/IHY3z1tFBfwlYi4zq0WpY
 2Lllvoj+wqaFEX0cNPqApd/C/ZRpHfWX5XqtT7zQGPag8kHKb2Q5Fmhh9oKJUvqE37zW
 Rs6NmiFJHwg4EMnILc2S/0LcxZ+WlIB916lxlmiClr7j2gHM1GEkBAVAaBpr3DLYUemg
 a+tn9vFlNo5Kv8/4ys7tKZT7oyiZy0clidCslNxJ452jLy9721GVx8hoQvSfyqgOD5HC
 2pcpW0U20xy9NZC6tpKQn0wkcNKaUlFWI3dpNLNya4wRt/unbMqWNtkAO3M9CQQAoCbE
 nK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695639126; x=1696243926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDAzQe+OvGmSqdrOeEWuBv56wcLddCGGELKoz8MM1c0=;
 b=dSOc5Qeyvpx0EM9Gm3yEKsrdqs48WrVvR6r/5RV9eFqZ43ykcmSuZm+i1ZUndPJ0ii
 qH/u0inTAHzAMEUXWlj0ryGLO/Uof7wNka/XZxXtKZqVufgnFrKlikMfa55XJJsa5S72
 pH8IAZoV3Juq21yoFy2QpqkRiY53ocODjnp+umii42u44VyCFX1GedVTPqjCUZjnYZKQ
 SUXg/9jLjzMKWmghGaRjwlsY6TZiveHz4v4kXNbfhezTlwgcwgWgZFiRF+NzavDw3kus
 VSVvhrN3+XVd7GUbdb5tmR/JIReSKGAY1dFeOg53pIDPPvJgfGIP+bhx0jwsoDmUkHCz
 m2IA==
X-Gm-Message-State: AOJu0YzXankq1rTYLIUm5VhEnqaD4lXxGULYj2kG5cJUAtF5Vq60ZJQ8
 0fgXv4b0/h1McVRlykW2nxpMOg==
X-Google-Smtp-Source: AGHT+IHg66+QHtHSL/toke9KSVvGth+MJN8wPc+boHpsmllr3lTlHzYpj4ug66w81x9Q5oNrOklV2Q==
X-Received: by 2002:a05:6000:1948:b0:317:e1fb:d57b with SMTP id
 e8-20020a056000194800b00317e1fbd57bmr5712200wry.56.1695639126072; 
 Mon, 25 Sep 2023 03:52:06 -0700 (PDT)
Received: from hera (ppp046103219117.access.hol.gr. [46.103.219.117])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a5d49c7000000b003176aa612b1sm11488644wrs.38.2023.09.25.03.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 03:52:05 -0700 (PDT)
Date: Mon, 25 Sep 2023 13:52:03 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH v4 2/8] net: wget: add wget with dns utility function
Message-ID: <ZRFmU32r473EsOpH@hera>
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
 <20230922071119.1439482-3-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922071119.1439482-3-masahisa.kojima@linaro.org>
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

On Fri, Sep 22, 2023 at 04:11:13PM +0900, Masahisa Kojima wrote:
> Current wget takes the target uri in this format:
>  "<http server ip>:<file path>"  e.g.) 192.168.1.1:/bar
> The http server ip address must be resolved before
> calling wget.
>
> This commit adds the utility function runs wget with dhs.
> User can call wget with the uri like "http://foo/bar".
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  include/net.h |  9 +++++++++
>  net/wget.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/include/net.h b/include/net.h
> index e254df7d7f..57889d8b7a 100644
> --- a/include/net.h
> +++ b/include/net.h
> @@ -926,4 +926,13 @@ void eth_set_enable_bootdevs(bool enable);
>  static inline void eth_set_enable_bootdevs(bool enable) {}
>  #endif
>
> +/**
> + * wget_with_dns() - runs dns host IP address resulution before wget
> + *
> + * @dst_addr:	destination address to download the file
> + * @uri:	uri string of target file of wget
> + * Return:	downloaded file size, negative if failed
> + */
> +int wget_with_dns(ulong dst_addr, char *uri);
> +
>  #endif /* __NET_H__ */
> diff --git a/net/wget.c b/net/wget.c
> index a48a8cb624..4801e28eb9 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -15,6 +15,7 @@
>  #include <net.h>
>  #include <net/tcp.h>
>  #include <net/wget.h>
> +#include <stdlib.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> @@ -504,3 +505,56 @@ void wget_start(void)
>
>  	wget_send(TCP_SYN, 0, 0, 0);
>  }
> +
> +#if (IS_ENABLED(CONFIG_CMD_DNS))
> +int wget_with_dns(ulong dst_addr, char *uri)
> +{
> +	int ret;
> +	char *s, *host_name, *file_name, *str_copy;
> +
> +	/*
> +	 * Download file using wget.
> +	 *
> +	 * U-Boot wget takes the target uri in this format.
> +	 *  "<http server ip>:<file path>"  e.g.) 192.168.1.1:/sample/test.iso
> +	 * Need to resolve the http server ip address before starting wget.
> +	 */
> +	str_copy = strdup(uri);
> +	if (!str_copy)
> +		return -ENOMEM;
> +
> +	s = str_copy + strlen("http://");
> +	host_name = strsep(&s, "/");
> +	if (!s) {
> +		log_err("Error: invalied uri, no file path\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	file_name = s;
> +
> +	/* TODO: If the given uri has ip address for the http server, skip dns */
> +	net_dns_resolve = host_name;
> +	net_dns_env_var = "httpserverip";
> +	if (net_loop(DNS) < 0) {
> +		log_err("Error: dns lookup of %s failed, check setup\n", net_dns_resolve);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	s = env_get("httpserverip");
> +	if (!s) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	strlcpy(net_boot_file_name, s, sizeof(net_boot_file_name));
> +	strlcat(net_boot_file_name, ":/", sizeof(net_boot_file_name)); /* append '/' which is removed by strsep() */
> +	strlcat(net_boot_file_name, file_name, sizeof(net_boot_file_name));
> +	image_load_addr = dst_addr;
> +	ret = net_loop(WGET);
> +
> +out:
> +	free(str_copy);
> +
> +	return ret;
> +}
> +#endif
> --
> 2.34.1
>

This can be done better when we integrate LWIP but for now

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

