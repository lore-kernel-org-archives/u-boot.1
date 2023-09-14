Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C7BCA5506
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 12:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B1F1869F5;
	Thu, 14 Sep 2023 14:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kQ97ZZOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3969D86AE9; Thu, 14 Sep 2023 14:52:14 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56DCE86907
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 14:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31c7912416bso805339f8f.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694695932; x=1695300732; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k26QAZOL7NxAenSdCp3mrrW8SE/8yP0E84Qnxifbea4=;
 b=kQ97ZZOFmuyCHJbbaxD8wU9uaGFHcR6YZemr5e7/RG3xw6VV/0bqjJQ2ONU802G9/U
 o5slJFKdhDrJ5VmWPwct2L1p84p2SxSjc4h4wHfZJwikGULQ90HkChfln49HDqB6lFhQ
 d/N91uFrcCEpscQZ8yFdj4EyEw8UAfYezmKrGdwns57kvJEUDouHTLOhQbtTzsUBVDRj
 12EZLSuUKGq+ozcFGen67DZj9HyCRV8DjoYtzeIySGQfD7XAnrKXJzFRkpgNxKIs6Vs9
 64H2V16qIYCJaAM9gp3cJ7NrGp1RrAYT91/LhPTAAxUk9GZGPL+FKyF84NK9lRKuI7Cn
 QTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694695932; x=1695300732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k26QAZOL7NxAenSdCp3mrrW8SE/8yP0E84Qnxifbea4=;
 b=BLCYV3FILJCWyVOzOHn3zHv6gkSjzd6ZlxJvPRcJI4CQc8GNmRjHZdMplFgnIFio0Y
 /mgIX2zc09XuvvcJIQe7kqi1d3bCh4bE4DCJmdrbstiClxf7yQ5AuAg8tW81qVrbS+Ox
 TmnGZH2PgDG5VxTZfc8uHDbVyBnUxMB+GEnk9Fs8Z1Y2/jCEwcq9E7BpteJu7lWshOQL
 plkZCG1uUKpnJoHIWZpvUQfO6OmXlc8YhgoNyw3iFPDy3S1H3zZ5wxYENomuZNOSl4jh
 M4dd0ek+LI4SvWMLX7UlP0YGJ2VpC/zBrIX8OtB1EBElYugkpQ7gnfR6gFWTpA06kOQN
 waYg==
X-Gm-Message-State: AOJu0YybQ+20XLW17MUMC7plP+C3JShA4DGkuc5lRhptNYwXp/B7rYvU
 gfs3FdOdAaxTaOerzOyBxx3TGg==
X-Google-Smtp-Source: AGHT+IHY6VB4E1o1mCuJ1W3XUACgiE8Qu0DFdAb79vZ+SIKUZyeo5duOLvpFM6jmE/lBjwJY8/YNTA==
X-Received: by 2002:adf:ecc8:0:b0:319:7b66:7800 with SMTP id
 s8-20020adfecc8000000b003197b667800mr4575723wro.55.1694695931717; 
 Thu, 14 Sep 2023 05:52:11 -0700 (PDT)
Received: from hera (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a5d4ace000000b0031c5dda3aedsm1724674wrs.95.2023.09.14.05.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 05:52:11 -0700 (PDT)
Date: Thu, 14 Sep 2023 15:52:09 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH v2 2/6] net: wget: add wget with dns utility function
Message-ID: <ZQMB+VZ6msAaK5da@hera>
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
 <20230901102542.609239-3-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901102542.609239-3-masahisa.kojima@linaro.org>
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

Kojima-san

[...]

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

This is not idea, but I understand this is how dns currently works.  We
can take another look on improving this when LWIP lands

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
> +	strlcpy(net_boot_file_name, s, 1024);

sizeof(net_boot_file_name) here please

> +	strlcat(net_boot_file_name, ":/", 1024); /* append '/' which is removed by strsep() */
> +	strlcat(net_boot_file_name, file_name, 1024);

Don't you have to limit the size of subsequent writes depending on what
previous calls wrote? IOW that can't always be 1024.

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

Thanks
/Ilias
