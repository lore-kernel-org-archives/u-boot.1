Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0532C47258
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 09:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 178FE87073;
	Fri,  2 Feb 2024 10:11:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mIktFhw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A57487142; Fri,  2 Feb 2024 10:11:47 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98AAF86F80
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 10:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5113303e664so1184583e87.0
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 01:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706865104; x=1707469904;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jNRPNPUWspW7AwDt4Hq/R7YIiZtj28y4i7arNJT7LWk=;
 b=mIktFhw8JT5T9hF1HmFr6i6kgZNPKLwDvfYescFua/gPactBZszri349Rm0aEAqL87
 cOmrdbBeqbce5PrL84+GF3BsgSX/P9ReFZHu+T/CBJeMdCdv2x5dvSvDni1MJwam9zIJ
 vgfR9s61/WIgtHDRPRA432u0HAGdqKCWJ1WAQKf3dH/HewCLsP2blQc1j4RrW4K7w4oX
 XvR05aYvHvmjDXSUe5/UNyj2uxGJW+/rSVYN5HNmAGlp66qk2rzVza4q7UG1iX+jjyEO
 aEbUFcuT275+PNkFAXiZX+RCivVrvcJNZmNWU5dR2Fk1fGxRTzDcKWAVQFKueHrbTIvT
 CBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706865104; x=1707469904;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jNRPNPUWspW7AwDt4Hq/R7YIiZtj28y4i7arNJT7LWk=;
 b=U8zpoz4h+Wnz81zLpKhIxDALUfN4/eEeuwK94dBZeG4W71cV5wrZU4onT/YBiLwLo5
 pa52x6IBhyIYvonB+2MdxPNhJAdsy9lqiOzcemcr0U/qgRzn4eHHn/Hz5BO/mC8ZVjoV
 S5Pvi2NceOLmIx4er44c3HcLeJjWY1bBw4KAESjLfZTGi+VMAdki/L7MOLy5flh+py8x
 BS6CHuJgJWgfGWLKexyPVg5IKb7oKe4BcGZNE339teFIMbQcCWxRPy1FwG/N7u/5IfkM
 LEk30c0RHW8oxAWi/xHWBjxqvGqTEOs7lF3yIq63p5C54qnGiLBot9A7EIQsEgRzd5eb
 7nBw==
X-Forwarded-Encrypted: i=0;
 AJvYcCVpCzCcP1u7CJborM/adWcV/ir+JP+5c+pfLNKXsqg9X3s9Ekc5sd4y03fNHPxpFVs/UdWPhcCi7737hoKUvMi7hO9cDw==
X-Gm-Message-State: AOJu0YwB6R+u69Cw0w7jEvzQGahHIG3iDRxkrSKYmn4yFJVh+3EASNoO
 wstLUzp6LThaE6qlsdHsNdYZYQMLwOA6jlusy56E/hfHwIDHMPO1O0F8uxcVfzY=
X-Google-Smtp-Source: AGHT+IEo1jihL6n04z07q9w9X+PEyWok8KrZUyHp0bzaGoFOLYSfnI8mrIRSswI0WCB/LYhISfq3rQ==
X-Received: by 2002:a05:6512:3d01:b0:511:3a11:166c with SMTP id
 d1-20020a0565123d0100b005113a11166cmr393636lfv.34.1706865103683; 
 Fri, 02 Feb 2024 01:11:43 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUgVPIQNuYbUt9CX7HC0LB9rRxUe/SJvgXO7uVprnLNZgIN1WTjoo15TR2iu3KHlLmDURBia1pWfJMfRd1QhjKJ8LcUgvJrmyndTvTyktzoZDXfYVN/4cpUzsJ2Muzm
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a5d4524000000b0033addeabd6fsm1470482wra.18.2024.02.02.01.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 01:11:43 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de
Cc: qianfanguijin@163.com, Dan Carpenter <dan.carpenter@linaro.org>, Sean
 Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH] lib: sparse: Fix error checking for write_sparse_chunk_raw
In-Reply-To: <20240201181851.221701-1-sean.anderson@seco.com>
References: <20240201181851.221701-1-sean.anderson@seco.com>
Date: Fri, 02 Feb 2024 10:11:39 +0100
Message-ID: <87fryb44dw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Sean,

Thank you for the patch.

On Thu, Feb 01, 2024 at 13:18, Sean Anderson <sean.anderson@seco.com> wrote:

> The return value of write_sparse_chunk_raw is unsigned, so the existing
> check has no effect. Use IS_ERR_VALUE to detect error instead, which is
> what write_sparse_chunk_raw does itself.
>
> Fixes: 62649165cb0 ("lib: sparse: Make CHUNK_TYPE_RAW buffer aligned")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/u-boot/1b323ec3-59b0-490b-a2f0-fd961dafcf49@moroto.mountain/
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  lib/image-sparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/image-sparse.c b/lib/image-sparse.c
> index f8289064692..09225692e9b 100644
> --- a/lib/image-sparse.c
> +++ b/lib/image-sparse.c
> @@ -211,7 +211,7 @@ int write_sparse_image(struct sparse_storage *info,
>  
>  			blks = write_sparse_chunk_raw(info, blk, blkcnt,
>  						      data, response);
> -			if (blks < 0)
> +			if (IS_ERR_VALUE(blks))
>  				return -1;
>  
>  			blk += blks;
> -- 
> 2.35.1.1320.gc452695387.dirty
