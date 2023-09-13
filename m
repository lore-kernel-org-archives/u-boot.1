Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC55EEB599
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 06:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF81486F61;
	Wed, 13 Sep 2023 08:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GwFFEA0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B1C986F63; Wed, 13 Sep 2023 08:30:42 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00C008676C
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 08:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-403004a96eeso44609145e9.3
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 23:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694586639; x=1695191439; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FJVjfFcSpmbV+JTOhvypJqJrY2MwMkiwZ2yuL+1SVIw=;
 b=GwFFEA0yaeLS1T8ScaN92Czhaf4BrXcj8E17KxlMwT3xnvPkoryJybCklPHSpPAr10
 OvC5UUCDxKY03c4sn/5HQt4H5he7WUujdzCbDzRsOFPib5gYtS8PVFZKsP/sYWrXgwjN
 6EwP7tWEctRc9aVyrq+K/JAbXKZw7WTvjuNluAknrnZCZegnNTm1Lz1fnYZdxS02VrNK
 4KGCj2s0HhDvyv07AiVmaKhGe0nNLrXiCPvkp4a9FLD0H8WhTAKfoXJi3XlizBFbGY4u
 8rhgOAJpY2930iW3rmHwUTHhqSv+RdOaENJpjXTIjn8PX+w1s0a20rz3vliCTeg8VDZA
 dLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694586639; x=1695191439;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJVjfFcSpmbV+JTOhvypJqJrY2MwMkiwZ2yuL+1SVIw=;
 b=kcj5z3mS3d/zIABXcyDMMaIkFhuUpG77UqQJCiCmuVOcX3XrF//Ol25cJzIveai7rh
 0KO6C4V+67Lz2Hk6YtLDePgbljHpKqKB7s0oZbD2tOAk+uBufO4KnKJlMjk6cvW13kxS
 i7LasH3EQdA/Q1qVkBAbz8qyJMdowjECkUuE9WL3Ilokw6nJDEoepnknr05cbximCmqQ
 hZh5/lLJ3P11WY76varcN4Rbr3HxCpliomeMiLZArBs6MNHzIckoULMgWDAcgVvWAcu5
 kK4bb9StfnV4NisuxajE+vLJaqcr19y8QrDv3WPOVIvea60s5LeVIqxkYvMm3EivLmn8
 UxsA==
X-Gm-Message-State: AOJu0YxdxvYLerkVpes6s+LgHRegde8t9rGiSf4ulUGt2Ke7rZDuEjm4
 26ceblNBBtODuVThuRQ1sQcN7g==
X-Google-Smtp-Source: AGHT+IFCbiIhRZajXr9hV20FvyoIp4tDtzuQal04CcOeCVRQ2y3JjPCeTxQQpwCN3EAXQ/OY9GMkwA==
X-Received: by 2002:adf:ebc8:0:b0:319:79b4:a8ba with SMTP id
 v8-20020adfebc8000000b0031979b4a8bamr1157046wrn.41.1694586639420; 
 Tue, 12 Sep 2023 23:30:39 -0700 (PDT)
Received: from hera (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a5d4ec6000000b003177074f830sm14636705wrv.59.2023.09.12.23.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 23:30:39 -0700 (PDT)
Date: Wed, 13 Sep 2023 09:30:36 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de
Subject: Re: [PATCHv8 15/15] net/lwip/wget add port selection
Message-ID: <ZQFXDNFYH8sPOIZT@hera>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135320.7066-16-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908135320.7066-16-maxim.uvarov@linaro.org>
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

Hi Maxi,

I'd drop this from the series.  It's useful in the long run, but let's just
get the minimum functionality in first

Thanks
/Ilias
On Fri, Sep 08, 2023 at 07:53:20PM +0600, Maxim Uvarov wrote:
> Allow to specify HTTP port instead of just using default for wget command.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  include/net/lwip.h             |  2 +-
>  net/lwip/apps/http/lwip-wget.c | 40 +++++++++++++++++++++++++---------
>  2 files changed, 31 insertions(+), 11 deletions(-)
>
> diff --git a/include/net/lwip.h b/include/net/lwip.h
> index 1e92f9871c..6de646771e 100644
> --- a/include/net/lwip.h
> +++ b/include/net/lwip.h
> @@ -54,7 +54,7 @@ int ulwip_tftp(ulong addr, const char *filename);
>   *
>   *
>   * @addr:  start address to download result
> - * @url:   url in format http://host/url
> + * @url:   url in format http://host[:port]/url
>   * Returns: 0 for success, !0 if error
>   */
>  int ulwip_wget(ulong addr, char *url);
> diff --git a/net/lwip/apps/http/lwip-wget.c b/net/lwip/apps/http/lwip-wget.c
> index 5c432056b1..7de1c962c6 100644
> --- a/net/lwip/apps/http/lwip-wget.c
> +++ b/net/lwip/apps/http/lwip-wget.c
> @@ -63,18 +63,38 @@ static int parse_url(char *url, char *host, u16 *port)
>  	p += strlen("http://");
>
>  	/* parse hostname */
> -	pp = strchr(p, '/');
> -	if (!pp) {
> -		return -2;
> +	pp = strchr(p, ':');
> +	if (pp) {
> +#define PORT_STR_SIZE 5
> +		char portstr[PORT_STR_SIZE];
> +
> +		if (pp - p >= SERVER_NAME_SIZE)
> +			return -2;
> +		memcpy(host, p, pp - p);
> +		host[pp - p + 1] = '\0';
> +
> +		p = pp + 1;
> +		pp = strchr(p, '/');
> +		if (!pp)
> +			return -3;
> +
> +		if (pp - p >= PORT_STR_SIZE)
> +			return -4;
> +		memcpy(portstr, p, pp - p);
> +		portstr[pp - p] = '\0';
> +		*port = (u16)dectoul(portstr, NULL);
> +	} else {
> +		pp = strchr(p, '/');
> +		if (!pp)
> +			return -5;
> +
> +		if (pp - p >= SERVER_NAME_SIZE)
> +			return -6;
> +		memcpy(host, p, pp - p);
> +		host[pp - p + 1] = '\0';
> +		*port = HTTP_PORT_DEFAULT;
>  	}
>
> -	if (pp - p >= SERVER_NAME_SIZE)
> -		return -3;
> -
> -	memcpy(host, p, pp - p);
> -	host[pp - p + 1] = '\0';
> -	*port = HTTP_PORT_DEFAULT;
> -
>  	return 0;
>  }
>
> --
> 2.30.2
>
