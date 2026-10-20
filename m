Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C641606A31E
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k5opBOMk;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nPP6NLE0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78A4660872;
	Tue, 20 Oct 2026 08:03:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gs1u4dcrhlOO; Tue, 20 Oct 2026 08:03:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AAF8B60842
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792483394;
	b=dgd/xXOVB0NBCUayKy9DtI5TBRlxWcjREUaQeiH8+aMHv+n3+Ih4YhJ+qraZwKSeIYjl
	 LZP/quJOflg6o+6l+erMKpE4Nrc7s75f+Y6IboP3IVqIVWLj9k/o4FcG4EUg7TeryHDXR
	 bFWT19zR4UolgPswW8dBVr0dC1rShoLlN2/KYXui03ReQQD0VJPvMdNqIijmbwzEIfrgi
	 KXjByQKCBbv3PxXCMYAT2FERckt1YB347ZqQmvl/QVLN91P9xljviTGNVHJoHD6pnAC/F
	 znZ/+KpGsxZgZ0DMr+xSsUx33Eom+GXstf0PKxqO5iGHObvsrw7HfjNUhgLJvqOnmxw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792483394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=B92waVEW9qRxUWF7T/aHA1e0UsdalqhguqfCujYDfPA=;
	b=Kl+GjDFPJwE/dnsYuigZYoS/1PeBjB3rqQmxCEioxlcK+vKaWRzlTu6nIFPhPQmAfkpB
	 G47lU3CPjxtEU1bCGG8lanemjaD3gNDaOn8+eBh8RpmwSuQv0isL7CLkAFrgAIk3VzF2U
	 Qa93uCpK5WsqWnC7IJN85g7OOgBJG+n2HLTpgNIW5FoGzljYUyb5zUdOeVFP1/oohYgoW
	 laNmUAiJ2YxBgwJQSWzbuKDWIq6jJOIWVU+xC+Q6lXSSUmJQpsp98taTpXCuTfZ7IWyzA
	 qMEPE8dqlcX/ju2ZtsV9bWys/TqKclXv7h0ESmTYnil8608EGkIYOZ4K5BG+LwRQmvA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792483394;
	bh=B92waVEW9qRxUWF7T/aHA1e0UsdalqhguqfCujYDfPA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k5opBOMkNe7F89izCoSmGYahzJWI0BeCyP0k1sku5OWTFxixUrH6+z8edEJack5qf
	 vLWhm4DU1Xh1qHq9uNi0/qEdgqAJy4pmvjxFIKl2knv1xQrz2aUx4NgBk5PUVEmdNY
	 WVlDZSiCT3UyomiK8gLHQpxKqlIJgoSEzYlai3O52PQMDTR5Fapqp0Ajh0sjQ8kmNX
	 XjL14/1Pz9kUy0ZLgV4sZ1YW5e6dhEyBESJCjmdOr2xVufhQwrAZYu/tHTn8kRQQD+
	 oQ4kNVc1xqnL1YAxD85eNR1dSyKh4zTOoPmja9pd6EqyqkurnHPDs1h9rSCxJixhz9
	 y3OrgDA3DAseA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAF8B60842;
	Tue, 20 Oct 2026 08:03:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CE3352A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BCB6E4081F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:03:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y-SstzUxKGxT for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:03:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 97985407FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792483392;
 b=gEDxlHqlFvz47Xfe3F7lypu09fzZzWM4h6xgcjjhMOt24JGwyk0FMOJhS/9nTg3q50qY
 /3ET/ewvvJzSUliJUmG21l6On2tM4kgNk1LCeNv5OaapJPwsojuW4G6TLKHAY1SgDqqSL
 HgsfUfjmdnTly4cjRD5J3a3v/6Kx/Vg1bRRmF0II+sWcWdClNF8i+VpBiXYRBdGB21Z7B
 GLJChCxkYQjsQFFLqrTuDl+H7Imzzgj+E1zpTKE7s1t31UrbJ6WNb7Y/57dNmIpD31zEC
 ANsquoqDIHsg9886N3wow5xCg56LQOGGhIAtpeLmjOOHU1Cc0RBphK7HdDQbFHdQ9rw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792483392;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=B92waVEW9qRxUWF7T/aHA1e0UsdalqhguqfCujYDfPA=;
 b=nwyPlI7Wm3pTUhxCVvQy/BtL9QxvlbVrs+qbOpX1YP2DFZwZ+5AJp1ybG9sH7u/MWy8t
 QmUOeZU9W0FWSMARko5ymhVu491LgURw6UjMfKS5CDMOaHWvBkYSUGJAK1lbwn7spzWUx
 E1GORzTlfaI/XsHF0+f+1eL1/TH+v/rz/Knxx4qLCvDK6BX48xM9lq0+I+17HN9k8CbpD
 qk9OqPllwJ81RGndh7UB/EJp56K4fvo1iX9mNp5v1NpAAglo/uQsDK36rK7C0UfTv27hx
 P0OKEgpaN+mP50QaE7FDjzO7o51HXPaCej2UJEQA3w7nXspozpX8kxWtn4dmAG5frPg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nPP6NLE0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=nPP6NLE0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97985407FB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:03:11 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso712444a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792483389; cv=none;
 d=google.com; s=arc-20260327;
 b=lnegywATdDFvEgPR4ks4PfaihqCHKiS0LLoACuf+UUoLa0A2ZCY+S0coU3Sf5OYH+A
 Y9oovg2hkXyD9aTPz1ybJ9lDawv4DY3g98Qn6Y7qk6vnwcxomMrgbqzs+zr1IJX+/Yse
 QJ5rmdPlHF+y2RDNK8g6P3dkUkqKU3W4oEVsAS5vwZ9gPQ0/TChmmzqrfLM4QGfftLrn
 3JHQ6JJwsTtwt1Zj1poQ/6Riu96F4AzLrzTR8e9n9NBL/mo4TA8CS6/KQ3QeAd3GIOSd
 4vMRJ2k7W4TQeFultsGoz+8CNqjPA7EZLAi2I9oTUEqMbY0KXCQRjLsDmkD4xz0lOmvX
 2DCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=B92waVEW9qRxUWF7T/aHA1e0UsdalqhguqfCujYDfPA=;
 fh=rI2ZnGpDN6kd3EtRXz4adaRZliFi+l4fDfD6SzaQKCU=;
 b=UpWDk9kzzMSJzYiKNATsxvnQaZasLuAl7jIqdnXWoa52/pZxN33EKkwwfDQKRHGhuA
 vpvCTNLApW5Ypj++tRd9tSi9Pf+ZVz9czaAqZ5iQEr/n9YM8G6ozP2UZDjs1Wt3t8sTM
 D9BK7/fEX+McVO6O+Sfw2SXvFT0azvf1VkM2eylDJx3S4I2vxdWS/kijTQc56f+eE839
 wVc9MVJmHK6izWezIJgiuJZeEbcea+9Gg3Y+QItcbkAcwuE17VqupWSMZqoKm1p+PshP
 LfYlgu9IgLsPy8Xv3gOlcCFhGu++VeOLQdLQWfqnRGpWc9NikaRWgNf7838Tmxiroqra
 QkBA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792483389; x=1793088189;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B92waVEW9qRxUWF7T/aHA1e0UsdalqhguqfCujYDfPA=;
 b=nPP6NLE0zXs21CLfVHGeJjoWwBygAM0ZZT7bFG2TTjtK/GGG3aDJHUiAwOk49XPICl
 2ZbNROGnc2laamyOdzKF8CBNOWnEa7kPYKQO7I8CN4YAohBeXm7ZDupLgXEVfcPWr4n1
 Z8pOSGIc2SkY3HEzZ/NenlnGNMto8LtpSa1vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792483389; x=1793088189;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B92waVEW9qRxUWF7T/aHA1e0UsdalqhguqfCujYDfPA=;
 b=VJZ00OXmGnwRNOUL8QLTlZZ8BErzNWHDdEObY6ey0tfK22XYHhaHh+HshFkzEc7RpI
 FPwi7O5pEAopKFQFoL8yyxqXqzhuYUV6dOLneohuJXIXCpxO/R7OYROe836JYTpVc77W
 mpKf3VILm8Lx21SmOWGYQi29WjUSiIDvROCUkC4QSii8UgDdoNT16Dpb/yPHK8SjOSnt
 9Zz26Tij1Iga+No0xkEyTwX3+8f7gk+eC+tjehvxg/Dy0BreWZ6l36YT7uMaUJZvT7EI
 7TmgJvLTJcr+lSSGSbzy2+TNUBsPqHnq9EkME5VZq3Q5dy/0t5wbG8+naUzVEU6awoaz
 Ai5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxy0sq7uIdNXiePhdNUDOk0GJbChkOSeET6H8dyz7YYYMSzuTk0XUy/86o7bnPkATdSdCBeD1g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJtawBHkQr+LGN8Pn6pQ5qCWl81koqETtOGmZrh5LGOdxsUT7VM
 swpD9/pP/eopv6ZvEWCLUNXMZdntRANbCseWLXOuzPhJLEZij0nfRL/RKTnI2ZMtA+OP50w/t8y
 MGcVTRM7oA31hUyHssTIYt/7sDDSQApiNDGlhT3tu
X-Gm-Gg: AYBFou0DHJofVZSDLxPYuXhlZTafGt5V9L1/Un3+kreX65HfrONuMAavG6vx3r2vLJ2
 Fja8vSqvVXqd0a8chIYucUNgx6Cefh6tS/2GKV3MYvg60HYPXeC3wblU6gJeU1BNQhVYHixm0/F
 wSpQHcVOifrM1LMOOPYXsyUex4RMVvsc6Yv1aqiC/KmDuBikYXLuylB+T9zR2VZO3mTmiEBMTBf
 Jn/mFuxD+RPBE9gxcJ8JAmVAefjlBGwgadbU5zL5W+/biECrRefM08ryS4kTjVZEYJ7RPLm7aCe
 K6VzAPnhQNxm1UbDB4hbUSu+Sx/Ztdbwe1LzHDAOatS1QS4RH7v7rKWMP3WMVfl6owuzyTaawVH
 Rp7IUtrbqct90TBICOy4RJ/g2h6BFSIard7B/nb6bYjbn7THtn0H1MERZ
X-Received: by 2002:a05:6402:7ca:b0:6ae:1895:3b3e with SMTP id
 4fb4d7f45d1cf-6b3e67d897emr685214a12.6.1792483386930; Tue, 20 Oct 2026
 01:03:06 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 04:03:04 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 12:32:01 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <adbf35ed13c45830dcc36e05d667b37e6a2017db.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
 <adbf35ed13c45830dcc36e05d667b37e6a2017db.1791966831.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 04:03:04 -0400
X-Gm-Features: AclHuK-3XKVOfc_PiVu4JzrGp7HuN5lup47e-6_F5-lzrFMPuXOt80R7eSn9Itg
Message-ID: <CAFLszTgwg9=HiUDwzM-bJYW-s3NFfbLEEN6UBr362DPbDmB0EA@mail.gmail.com>
Subject: Re: [PATCH 10/11] boot: build the imagemap pointers only when enabled
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Vincent Jardin <vjardin@free.fr>, 
 Anton Ivanov <anton@binarly.io>, Randolph Sapp <rs@ti.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daniel,

On 2026-10-14T08:38:38, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: build the imagemap pointers only when enabled
>
> struct bootm_headers and struct bootm_info carry an imagemap pointer
> whatever the configuration, so every board pays for it with the feature
> off, and each use site has to spell out an IS_ENABLED() test beside the
> NULL check.
>
> Compile the two fields under CONFIG_IMAGEMAP and reach them through
> bootm_imagemap(), bootm_set_imagemap() and bootm_info_imagemap(), which
> fold to NULL and to nothing when it is off.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
>  boot/bootm.c     | 28 ++++++++++++++--------------
>  boot/image-fit.c | 12 ++++++------
>  include/bootm.h  | 17 +++++++++++++++++
>  include/image.h  | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 68 insertions(+), 20 deletions(-)

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2246,11 +2246,11 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
>  	    !fit_image_get_load(fit, noffset, &img_load)) {
>  		dst = map_sysmem(img_load, data_sz);
>
> -		mapped = imagemap_map_to(images->imagemap, data_off, data_sz,
> +		mapped = imagemap_map_to(bootm_imagemap(images), data_off, data_sz,
>  					 dst);

This runs to 83 columns once tabs expand. A local for the device would
bring it back under 80 and avoid the double call a few lines on in the
else branch.

> diff --git a/include/bootm.h b/include/bootm.h
> @@ -52,12 +52,29 @@ struct bootm_info {
>  	const char *conf_fdt;
>  	bool boot_progress;
>  	struct bootm_headers *images;
> +#if CONFIG_IS_ENABLED(IMAGEMAP)
>  	struct udevice *imagemap;
> +#endif

Please add a bootm_info_set_imagemap() alongside the getter. Without
it any future caller that wants to populate bmi->imagemap (the openwrt
bootmeth the cover letter mentions) has to spell the ifdef out itself,
which is the pattern this patch is retiring.

> diff --git a/include/bootm.h b/include/bootm.h
> @@ -52,12 +52,29 @@ struct bootm_info {
> +static inline struct udevice *bootm_info_imagemap(struct bootm_info *bmi)
> +{
> +#if CONFIG_IS_ENABLED(IMAGEMAP)
> +	return bmi->imagemap;
> +#else
> +	return NULL;
> +#endif
> +}

bootm_imagemap() in image.h guards on '!defined(USE_HOSTCC) &&
CONFIG_IS_ENABLED(IMAGEMAP)' but this one drops the USE_HOSTCC half.
tools/image-host.c pulls bootm.h in, so please keep the two guards in
step.

> diff --git a/boot/bootm.c b/boot/bootm.c
> @@ -1318,9 +1318,9 @@ int bootm_run_states(struct bootm_info *bmi, int states)
>  	/* Now run the OS! We hope this doesn't return */
>  	if (!ret && (states & BOOTM_STATE_OS_GO)) {
>  		/* Release storage backend before jumping - no return expected */
> -		if (IS_ENABLED(CONFIG_IMAGEMAP) && images->imagemap) {
> -			imagemap_cleanup(images->imagemap);
> -			images->imagemap = NULL;
> +		if (bootm_imagemap(images)) {
> +			imagemap_cleanup(bootm_imagemap(images));
> +			bootm_set_imagemap(images, NULL);
>  		}

The same cleanup block appears here and in the err: path just below,
so should be in a helper.

Regards,
Simon
