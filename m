Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08D0CD1284
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 13:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC1B687B89;
	Tue,  9 Apr 2024 15:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="QkWSzzKx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C3CA87D9C; Tue,  9 Apr 2024 15:46:09 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCC74879E2
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 15:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1712670367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCZBgtuknFdX6wQU0N573ZHAJFrrE0H130fSY0kEnWQ=;
 b=QkWSzzKxLtZ9nBG0nUrpYjWrPvsHUPkBrF8FF/Jpc0WDDiybfPXENkg4ZNYExyc0CwcLVo
 3XYSy0c+ZKwf2wwE/fgEHSL3BiYJVGaklz1m8VzYnh3HDb5A/v1qJeVRDl0J+r8PpUkmmT
 Li53YkT6iAJ1nHLZOhUMsuth2i2+oMQGHfqz9LEqC8FooQKwO+SkZNEYzV+MXPLOHP5hZn
 aXJLWmw2AgN5wbkPsSDc7wmBULz49G0nmPvDyAz8j2yGnZ6P+g5Ju9PROSvfmyKrcPUAWN
 6znf6dyeVs/Xx2mY71sMP2j7FhNLmXqfguE3bg0Lj44QeppgU+tAa181BrDk+Q==
Date: Tue, 09 Apr 2024 15:46:06 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4] tools: copyfile: use 64k instead of 512 buffer
In-Reply-To: <xp66c7g532kqzu6tai7enm3ribhhvftsr2o7uqfv3qmodcxy5l@tarta.nabijaczleweli.xyz>
References: <af5db6b1165d5f800f21463592779f8e@manjaro.org>
 <xp66c7g532kqzu6tai7enm3ribhhvftsr2o7uqfv3qmodcxy5l@tarta.nabijaczleweli.xyz>
Message-ID: <76ed7b3cc3be42f325a49e61e135c0b9@manjaro.org>
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

On 2024-04-09 14:14, Ahelenia Ziemiańska wrote:
> This is a trivial but significant optimization:
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
> Also extract the buffer size to a macro.
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Looking good to me, thanks for the v4.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  tools/fit_common.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/fit_common.c b/tools/fit_common.c
> index 2d417d47..d1cde16c 100644
> --- a/tools/fit_common.c
> +++ b/tools/fit_common.c
> @@ -23,6 +23,8 @@
>  #include <image.h>
>  #include <u-boot/crc.h>
> 
> +#define COPYFILE_BUFSIZE (64 * 1024)
> +
>  void fit_print_header(const void *fit, struct image_tool_params 
> *params)
>  {
>  	fit_print_contents(fit);
> @@ -145,14 +147,14 @@ int copyfile(const char *src, const char *dst)
>  		goto out;
>  	}
> 
> -	buf = calloc(1, 512);
> +	buf = calloc(1, COPYFILE_BUFSIZE);
>  	if (!buf) {
>  		printf("Can't allocate buffer to copy file\n");
>  		goto out;
>  	}
> 
>  	while (1) {
> -		size = read(fd_src, buf, 512);
> +		size = read(fd_src, buf, COPYFILE_BUFSIZE);
>  		if (size < 0) {
>  			printf("Can't read file %s\n", src);
>  			goto out;
