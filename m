Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A659FCD11DB
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 19:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD57288013;
	Thu, 21 Mar 2024 20:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="MY6zFKaJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BBA188113; Thu, 21 Mar 2024 20:49:55 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF2EE87D08
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 20:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1711050592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwsPrpDUr4wOBYagQlE8typidR/MOeMg/UJeLIjBhKA=;
 b=MY6zFKaJoHqpMU8hOssLQET2/9zkK1qmL9/5BTVtieAdwugbBvDxyUuZJjN8iBAVOgdH9w
 naP9aSig7udeXKRSZ1ElQ1tPID5Mc6xIq3cRFZaDDWqmuxPGWU4uHtXWTdTplZDuBVMpZ9
 iu26GJc/SW9zZfmhtalBHMwjOqI19teDcXR4+SYHo5M8CdYDxvDX2RvvAm+VCMvgdvbMn7
 4bZnQToaWn3Dx0xeqTpwdiUwlaR1htISm9iNlBFViSqSTnG4XEpNfxxXKSCI8rVJ7YoVvm
 onF3Jh5LqKN9dYW5sH9C12H9ubI4152D2niKXgj7qjgUu4PJO7Du/sC8r9qSDw==
Date: Thu, 21 Mar 2024 20:49:52 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] tools: copyfile: use 64k instead of 512 buffer
In-Reply-To: <bb5hzhpopwm2d65b5wjsvafsr537nbuyk3msebwth2v56vo3hu@tarta.nabijaczleweli.xyz>
References: <f48faaa30f42ab63c616611b0b0067b6@manjaro.org>
 <bb5hzhpopwm2d65b5wjsvafsr537nbuyk3msebwth2v56vo3hu@tarta.nabijaczleweli.xyz>
Message-ID: <2894747cef36c9533b2915b803ce754f@manjaro.org>
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

On 2024-03-21 19:29, Ahelenia Ziemiańska wrote:
> This is a trivial but significant optimisation:

s/optimisation/optimization/

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
> Also lift up the buffer size to a macro.

s/lift up/extract/
s/macro/constant/

> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  tools/fit_common.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/fit_common.c b/tools/fit_common.c
> index 2d417d47..1df4785c 100644
> --- a/tools/fit_common.c
> +++ b/tools/fit_common.c
> @@ -127,6 +127,7 @@ err:
> 
>  int copyfile(const char *src, const char *dst)
>  {
> +#define copyfile_bufsize (64 * 1024)

This is not the right place for such a preprocessor directive.
Instead, it should be placed at the start of the file.

Also, it should use all uppercase letters.

>  	int fd_src = -1, fd_dst = -1;
>  	void *buf = NULL;
>  	ssize_t size;
> @@ -145,14 +146,14 @@ int copyfile(const char *src, const char *dst)
>  		goto out;
>  	}
> 
> -	buf = calloc(1, 512);
> +	buf = calloc(1, copyfile_bufsize);
>  	if (!buf) {
>  		printf("Can't allocate buffer to copy file\n");
>  		goto out;
>  	}
> 
>  	while (1) {
> -		size = read(fd_src, buf, 512);
> +		size = read(fd_src, buf, copyfile_bufsize);
>  		if (size < 0) {
>  			printf("Can't read file %s\n", src);
>  			goto out;
