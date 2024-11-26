Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC45CD66B9A
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 00:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC37289CC2;
	Wed, 27 Nov 2024 01:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732666304;
	bh=En55yc9wFq6KnBGp8M0JDDtUo3bBul+K3r1x3LQKzmw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xs8+TFjs4GAuPvf4yCRDoU822uxOcnof/0rgJjEpP3ueimxlaajsVAhfNCUzgnIl4
	 aMaI+k5EbYNZolI3YFNmaoPLj6z21rc9rFxhpOV4LK6YQ6FG8vV1bt6trftXXEixQx
	 vWK7NYcSJ3TmMTP5q7lsHBh+lx62bz1FkYbrvlNmFl/EQMMTL8zOnNIwDRqXujUj4N
	 q8ZU52f5Q2KYQAIZkyxL51vo2R6vOe3WGYTZZeD9RwI7gNNRgN8odDoy10siF4ac+b
	 vg3Bgemu08MQmNSlqIHIIEGGWvXZGfjZiaSDuB1AwHXlzLzNZbnbrNueL1NGIv2xhN
	 s3nsCM8UyZUuQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2DEE5895E0;
 Wed, 27 Nov 2024 01:11:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732666304;
 bh=En55yc9wFq6KnBGp8M0JDDtUo3bBul+K3r1x3LQKzmw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=brCiIZ1QNGDaL3LbFXKiKbKmLRCu6dDtjy8NH6hSaqpaA0SzJxp/ZB28BdAgvdNnW
 TwK4c1UGr8WtbEtcjJ+0LrSW/cM3GkajZwTi5APsxvRU2dnCndwCRyvAmp0s5zc4Km
 Fu5k/gEtmNDW5MI03a1kIGgyu3u4RA2vUQyMCgEocQU6sQPSV73xRyO+DoRkJ2qhdS
 U2rHQKM6JwT+JuL8Miu0gI8axjNGCc6PW8DxHLhya6uaySv0E1Qy6vdxkfI+VvvT6Q
 qO1CaSjQH/3fhVzABwKgWQ2cDyiXlWwnyEK3NSDBBmK5E7f+Qw7h+D8kZPikWJb7PC
 u7rbidP5datCQ==
Message-ID: <4808e6e6-84b1-4a83-bca2-ab02336832e8@denx.de>
Date: Wed, 27 Nov 2024 00:41:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Makefile: avoid non-standard sed expressions
To: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de
References: <20241126191214.21709-1-kettenis@openbsd.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241126191214.21709-1-kettenis@openbsd.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/26/24 8:12 PM, Mark Kettenis wrote:
> The '?' that is used in the sed expression that determines MK_ARCH
> is part of the extended regular expression syntax, but the default
> behaviour of sed as specified by POSIX is to use only basic regular
> expression syntax.  Use the equivalent '\{0,1\}' instead as
> suggested by the OpenBSD re_format(7) man page.
> 
> Fixes: 04b1d84221d5 ("Makefile: fix empty MK_ARCH when using ccache")
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 22953bdabd8..7933ade6eff 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -21,7 +21,7 @@ include include/host_arch.h
>   ifeq ("", "$(CROSS_COMPILE)")
>     MK_ARCH="${shell uname -m}"
>   else
> -  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^\(ccache\)\?[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\3/p'}"
> +  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^\(ccache\)\{0,1\}[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\3/p'}"
Interesting, and noted too, thanks.

Reviewed-by: Marek Vasut <marex@denx.de>
