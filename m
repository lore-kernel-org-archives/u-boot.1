Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2D4C6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 15:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC4FC8802B;
	Wed, 20 Mar 2024 16:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="UGpVTBA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C87E8802B; Wed, 20 Mar 2024 16:59:55 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 112CD83346
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 16:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1710950392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+nn+RuMbqiOlJlmm6zuOE2Iz3om2HDqrtzEhDWDkV9k=;
 b=UGpVTBA7dLbTQ7kIp28M7XSr72a/JCp+vVPq6mAsuMgEqsQ8Ffs7x73A8eYz79690WwIS/
 q2/RaNHnCESbsC7p6D0EIb0IN34Jzg5swfx9GHE0QrR6fJMZvue2xIt8J1fcxyfHlh21EW
 uGZy6UjlOZAIkQ1U77qzizg91Ryig5INLXPKI6dO9Fa58mm/5cLcCmIPNJkkpJ9Odlg2J+
 Gfzhg1Ibf9aZpRg1nXRU2oDuj8m/n3/AD+u7phIqhaGy09c0i46tHluVkoY8w5ZgQfvTQz
 95+LZbDZl48GaNtGesLCpJDCwhWykB8u7ufUcEyB+JV1eng1Ho04UGi16vcIMw==
Date: Wed, 20 Mar 2024 16:59:52 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] tools: copyfile: use 64k instead of 512 buffer
In-Reply-To: <4le6hwyli3wl2fisv5lr3rizbqzx3g2xzytw26zcrsvgchqy6i@tarta.nabijaczleweli.xyz>
References: <4le6hwyli3wl2fisv5lr3rizbqzx3g2xzytw26zcrsvgchqy6i@tarta.nabijaczleweli.xyz>
Message-ID: <f48faaa30f42ab63c616611b0b0067b6@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Ahelenia,

Please see my comments below.

On 2024-03-20 14:08, Ahelenia Ziemiańska wrote:
> This is an incredible pessimisation:

s/pessimisation/optimization/

> mkimage took >200ms (and 49489 writes (of which 49456 512)),
> now it takes  110ms (and   419 writes (of which   386 64k)).
> 
> sendfile is much more appropriate for this and is done in one syscall,
> but doesn't bring any significant speedups over 64k r/w
> at the 13M size ranges, so there's no need to introduce
> 	#if __linux__
> 	while((size = sendfile(fd_dst, fd_src, NULL, 128 * 1024 * 1024)) > 0)
> 		;
> 	if(size != -1) {
> 		ret = 0;
> 		goto out;
> 	}
> 	#endif
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Looking good to me.  With the small nitpick above and
a suggestion below,

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  tools/fit_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/fit_common.c b/tools/fit_common.c
> index 2d417d47..373fab6a 100644
> --- a/tools/fit_common.c
> +++ b/tools/fit_common.c
> @@ -145,14 +145,14 @@ int copyfile(const char *src, const char *dst)
>  		goto out;
>  	}
> 
> -	buf = calloc(1, 512);
> +	buf = calloc(1, 64 * 1024);
>  	if (!buf) {
>  		printf("Can't allocate buffer to copy file\n");
>  		goto out;
>  	}
> 
>  	while (1) {
> -		size = read(fd_src, buf, 512);
> +		size = read(fd_src, buf, 64 * 1024);

Perhaps this would be a good opportunity to introduce a new
#define for 64 * 1024 as the new buffer size.

>  		if (size < 0) {
>  			printf("Can't read file %s\n", src);
>  			goto out;
