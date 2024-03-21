Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A27C6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 20:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01704880F1;
	Thu, 21 Mar 2024 21:50:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="SSr+IOPF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF1388013; Thu, 21 Mar 2024 21:50:47 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A4CA88120
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 21:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1711054243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2+7HLee2/9JznTVMjmwD/UeTUBvDbgH7s3/hQd+oMo=;
 b=SSr+IOPFbjKbNsN8LsXE5laYyQZ7GKHsnGTshddkUMbniiK6YhWX7uupcv2Y33R5t/Sl7F
 B2xq5yAsQMUAW7C/g12iWChMwvLCctGG/CYGiK0Iev6qeyILN1RKUGttk71uedqEKRShQe
 pTK7xsDtKQNw6ynuLojcRrWzStxQ5LXJzBreflky4jkVmyBltP6AwCH1mvwUjDeFM7XuTY
 tEfmHle6USR5WdBT5Jg1d73KND979DdQO8uvmVQG+PK3ZBDzryXODqCpSUHBEmnbWQz4Fn
 Co6NU50md8l22YHIpec8iU8m4ckfSId4ZFrfjyfTnu5thURv7U1H3v8vPLHN+Q==
Date: Thu, 21 Mar 2024 21:50:43 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3] tools: copyfile: use 64k instead of 512 buffer
In-Reply-To: <u2jkzgrq4tbtvvazqzamuixjiwhdrwvnla7sdbfm6ia2si52i7@tarta.nabijaczleweli.xyz>
References: <2894747cef36c9533b2915b803ce754f@manjaro.org>
 <u2jkzgrq4tbtvvazqzamuixjiwhdrwvnla7sdbfm6ia2si52i7@tarta.nabijaczleweli.xyz>
Message-ID: <af5db6b1165d5f800f21463592779f8e@manjaro.org>
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

On 2024-03-21 21:37, Ahelenia Ziemiańska wrote:
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
> Also extract the buffer size to a constant.
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Please, remove my Reviewed-by tag from this version of the patch,
because it no longer applies.

> ---
> On Thu, Mar 21, 2024 at 08:49:52PM +0100, Dragan Simic wrote:
>> On 2024-03-21 19:29, Ahelenia Ziemiańska wrote:
>> > This is a trivial but significant optimisation:
>> s/optimisation/optimization/
> This seems to run counter to precedent of not doing americans'
> imperialism for them for free
> (I see -ise/-ize in free variation even in my 100-deep checkout).

Well, that's politics, which I have no interest about.

>> > +#define copyfile_bufsize (64 * 1024)
>> This is not the right place for such a preprocessor directive.
>> Instead, it should be placed at the start of the file.
>> 
>> Also, it should use all uppercase letters.
> FTR, neither of these points seem to be universal;
> I modelled this after tools/mtk_image.c (also cf. 
> scripts/kconfig/expr.c),
> but there are at least 25 other function-local macros
> (as in git grep -B1 '^#define' | grep -c -A1 -e '-{' returns 27).

AFAICT, scripts/kconfig/expr.c could use come cleanups.

> Also kinda weird to explicitly request a macro
> only to review it back to a constant, but whatever.

Well, it isn't weird.  See, the instances of a preprocessor #define
directive are replaced with its definition before the source code
reaches the compiler, making it, in this case, a bit easier for the
compiler to do its job.

The way you wrote it below, the compiler will almost surely optimize
out the constant variable and replace it with the literal number in
the generated object code, but that puts unnecessary burden on the
compiler, which can be avoided by feeding it with the literal number,
using a preprocessor directive.

>  tools/fit_common.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/fit_common.c b/tools/fit_common.c
> index 2d417d47..37066203 100644
> --- a/tools/fit_common.c
> +++ b/tools/fit_common.c
> @@ -129,6 +129,7 @@ int copyfile(const char *src, const char *dst)
>  {
>  	int fd_src = -1, fd_dst = -1;
>  	void *buf = NULL;
> +	const size_t bufsize = 64 * 1024;
>  	ssize_t size;
>  	size_t count;
>  	int ret = -1;
> @@ -145,14 +146,14 @@ int copyfile(const char *src, const char *dst)
>  		goto out;
>  	}
> 
> -	buf = calloc(1, 512);
> +	buf = calloc(1, bufsize);
>  	if (!buf) {
>  		printf("Can't allocate buffer to copy file\n");
>  		goto out;
>  	}
> 
>  	while (1) {
> -		size = read(fd_src, buf, 512);
> +		size = read(fd_src, buf, bufsize);
>  		if (size < 0) {
>  			printf("Can't read file %s\n", src);
>  			goto out;
