Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461C2C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 15:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48AF28806A;
	Wed, 20 Mar 2024 16:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="F3SVZlq9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD7088077; Wed, 20 Mar 2024 16:59:33 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55BC887E3A
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 16:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1710950370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kIhApbWCFmFTC0cZV2ycSqkR9wmecCfq98Yej1SxA5o=;
 b=F3SVZlq9aisKPoGdGS+HY+BYXu9AdFIq405aPtxZCN4usdd50qoi0Ru0jGUu0RnaBqRLXH
 PoW3ML2xPHxErHdPaBSvRfr/EJ5N0O3J9AiKfPbPfdhZGcRbtCD3BwUlkVB7FZn+IoMxq4
 S40X02SVvzz/jaVNlCSMoLVWyBdxWb42Y7GephsxGpKkVPpyDlOsYW9DU5kjQVJcaU6YTA
 OZ+CKT2Ez1ncxMaA/KRTcmz8imOs4g2sF1rL+6j4bBOHVimTMWUsmvHDapxTmJ+qHEESDA
 QHBLMx3Ll6boG7illFac9V0qZ04zry00/8N0xHylVH1H1oSh7hYwXVDNEAdimA==
Date: Wed, 20 Mar 2024 16:59:29 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] tools: open FIT image for reading as O_RDONLY instead of
 O_RDWR
In-Reply-To: <yehdhyy7f272rllmk3jiyome7muiqrbm7ezbu4xnqcymrcaobu@tarta.nabijaczleweli.xyz>
References: <yehdhyy7f272rllmk3jiyome7muiqrbm7ezbu4xnqcymrcaobu@tarta.nabijaczleweli.xyz>
Message-ID: <a5562c55fef9fd07e8a087ebcd389e60@manjaro.org>
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
> The only usage of the fd is for the single read() below;
> this prevented
> 	mkimage -f auto -A arm64 \
> 		-T kernel -C lz4 -d Image-6.6.15.lz4 \
> 		-b mt8173-elm-hana-6.6.15.dtb outf
> when the inputs were unwriteable.

s/unwriteable/unwritable/

Also, the patch subject could be moved to the patch description,
and the following could be used instead, as the subject:

     tools: open FIT image read-only

> 
> Link: https://bugs.debian.org/1063097
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Looking good to me.  Opening the file read-only is also good
from the standpoint of using least privilege to perform the
required operation.

With the small nitpicks above,

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

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
