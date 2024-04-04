Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3ECCD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 16:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EBA98838F;
	Thu,  4 Apr 2024 18:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="T44StBf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCB1C883D6; Thu,  4 Apr 2024 18:44:12 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B21E7881D0
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 18:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1712249050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HN8hP7nerz9Cgem7eksYoRoK7ClhHu3h4GkL/Wb/lpg=;
 b=T44StBf+NBZpDamovdHX+/oGtAIsJi38s1mc3Kl62dIIjZBAkzl92kOBxwloP9udBfqjx7
 Y+Z2MwgvfGuf0HzWLxgCn8r/sMNXwN1HyEJze04VqWZYQZ4KKjhV5jMj/rCxJ/a83kS37K
 JzwfgWdOTEyk4hQgHK+Ias16JHCO2XXc9v4htLe0OPq/cl6L9moBXuyPAq+AHkSEqs6SgN
 9aFuQTEKWkLuQ99b2z4kNf4JpazKRbXbuVP6hR3KlMYOsjhGSoLZ7cUxGPfJBfRe0j5YS7
 bDgXi8i5XvpIu5laDgJo0ymDTD2ukwt+q3Mpscqjog9EoLyw14O4tErzZE7ZcA==
Date: Thu, 04 Apr 2024 18:44:10 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] tools: open FIT image read-only
In-Reply-To: <rt336whqarwenm6q2pbla2x2yewfxwjpxuh2x6mmo5i7ynfopl@tarta.nabijaczleweli.xyz>
References: <a5562c55fef9fd07e8a087ebcd389e60@manjaro.org>
 <rt336whqarwenm6q2pbla2x2yewfxwjpxuh2x6mmo5i7ynfopl@tarta.nabijaczleweli.xyz>
Message-ID: <9db2f3f506b14abe32cb888a9919a29c@manjaro.org>
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

Hello all,

Just a brief reminder about merging this patch.  It looks fine to me.


On 2024-03-21 19:31, Ahelenia Ziemiańska wrote:
> Open for reading as O_RDONLY instead of O_RDWR:
> the only usage of the fd is for the single read() below;
> this prevented
> 	mkimage -f auto -A arm64 \
> 		-T kernel -C lz4 -d Image-6.6.15.lz4 \
> 		-b mt8173-elm-hana-6.6.15.dtb outf
> when the inputs were unwritable.
> 
> Link: https://bugs.debian.org/1063097
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  tools/fit_image.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/fit_image.c b/tools/fit_image.c
> index beef1fa8..0fccfbb4 100644
> --- a/tools/fit_image.c
> +++ b/tools/fit_image.c
> @@ -137,7 +137,7 @@ static int fdt_property_file(struct
> image_tool_params *params,
>  	int ret;
>  	int fd;
> 
> -	fd = open(fname, O_RDWR | O_BINARY);
> +	fd = open(fname, O_RDONLY | O_BINARY);
>  	if (fd < 0) {
>  		fprintf(stderr, "%s: Can't open %s: %s\n",
>  			params->cmdname, fname, strerror(errno));
