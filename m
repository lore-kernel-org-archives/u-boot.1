Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052EECD1297
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 23:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5119E86E40;
	Thu, 11 Apr 2024 01:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="cPV/OXz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8A28701E; Thu, 11 Apr 2024 01:46:43 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C57C85B66
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 01:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 6c36a21b-f794-11ee-b571-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 6c36a21b-f794-11ee-b571-005056992ed3;
 Thu, 11 Apr 2024 01:45:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=wz3YT0/Sq+si8smEAOOefp84HrLO3aQX/85e5f6DpN4=;
 b=cPV/OXz1TCnA3HIMCrqY55NQJft/cV1SKFlyXiX7oGDoqcyBH8UrBZIisjvphsloBVKldIaObfTvd
 GFhxE/aF8d0cBCCXNhTwp27RE0HYhMCGDfU6IXzIY8oFX0DAmJN/+3GUcxlDJXOqISwHTtJJhDUOtQ
 tEqtSVXMZox9opLmlZ5CfmWlGCu2YwN+QcVqxrNB5QGhEK65+zJqJh1K/RBx3EzINOJA6gmP4+FyZz
 UuMHmIKi+YKvxohynZh6SleQ5F6OOkwKWRui96jxpfXeAAGcT81Hgh/10Pg93RPjbMJXwp+eQn3awG
 hTs7xnvZT6LyOO2nVnwLR2AV3LKIrxw==
X-KPN-MID: 33|EaRVHhaHgREQzIqa+iBM3TVa/F7DlL7z+K0Aw3A6AYA7ZUWDQLjTJp+t2bokmDa
 IFPQkngf/iUGr3KisMMM00TDPCs7Bu/HRcAdLEGa+OKw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|tpr8/YUuNv533r0yJSs+YPHZMWJ8hkmekiHF/1+QDA/ATxeiPGrQIpu7HFwVVOX
 2357qCBVPtRTu720/YOaGDw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 93c86bc2-f794-11ee-94eb-00505699b758;
 Thu, 11 Apr 2024 01:46:40 +0200 (CEST)
Date: Thu, 11 Apr 2024 01:46:40 +0200
Message-Id: <87sezshjbz.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: trini@konsulko.com, sjg@chromium.org,
 oleksandr.suvorov@foundries.io, paulerwan.rio@gmail.com,
 hugo.cornelis@essensium.com, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com
In-Reply-To: <20240410233116.57402-1-heinrich.schuchardt@canonical.com>
 (message from Heinrich Schuchardt on Thu, 11 Apr 2024 01:31:16 +0200)
Subject: Re: [PATCH 1/1] tools: use adequate entropy source for initialization
 vector
References: <20240410233116.57402-1-heinrich.schuchardt@canonical.com>
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

> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Date: Thu, 11 Apr 2024 01:31:16 +0200
> 
> The random() function is unsafe to initialize cryptographic data.
> Use getrandom() which reads from /dev/urandom instead.
> 
> getrandom() is available on Linux sine release 3.17 and on BSD.

NACK

getrandom() isn't evailable on OpenBSD.  Either use getentropy() or
arc4random_buf() instead.

> Addresses-Coverity-ID: 312953 Calling risky function
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  tools/image-host.c | 36 +++---------------------------------
>  1 file changed, 3 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/image-host.c b/tools/image-host.c
> index b2a0f2e6d16..d30a235baf6 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -13,11 +13,11 @@
>  #include <fdt_region.h>
>  #include <image.h>
>  #include <version.h>
> -
>  #if CONFIG_IS_ENABLED(FIT_SIGNATURE)
>  #include <openssl/pem.h>
>  #include <openssl/evp.h>
>  #endif
> +#include <sys/random.h>
>  
>  /**
>   * fit_set_hash_value - set hash value in requested has node
> @@ -364,36 +364,6 @@ static int fit_image_read_key_iv_data(const char *keydir, const char *key_iv_nam
>  	return ret;
>  }
>  
> -static int get_random_data(void *data, int size)
> -{
> -	unsigned char *tmp = data;
> -	struct timespec date;
> -	int i, ret;
> -
> -	if (!tmp) {
> -		fprintf(stderr, "%s: pointer data is NULL\n", __func__);
> -		ret = -1;
> -		goto out;
> -	}
> -
> -	ret = clock_gettime(CLOCK_MONOTONIC, &date);
> -	if (ret) {
> -		fprintf(stderr, "%s: clock_gettime has failed (%s)\n", __func__,
> -			strerror(errno));
> -		goto out;
> -	}
> -
> -	srandom(date.tv_nsec);
> -
> -	for (i = 0; i < size; i++) {
> -		*tmp = random() & 0xff;
> -		tmp++;
> -	}
> -
> - out:
> -	return ret;
> -}
> -
>  static int fit_image_setup_cipher(struct image_cipher_info *info,
>  				  const char *keydir, void *fit,
>  				  const char *image_name, int image_noffset,
> @@ -465,8 +435,8 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
>  		if (ret < 0)
>  			goto out;
>  	} else {
> -		/* Generate an ramdom IV */
> -		ret = get_random_data((void *)info->iv, info->cipher->iv_len);
> +		/* Generate a ramdom initialization vector */
> +		ret = getrandom((void *)info->iv, info->cipher->iv_len, 0);
>  	}
>  
>   out:
> -- 
> 2.43.0
> 
> 
