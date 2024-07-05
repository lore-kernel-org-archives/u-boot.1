Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3905BC30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 12:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3EEF88961;
	Fri,  5 Jul 2024 14:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="02ri+Z3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93FD18896C; Fri,  5 Jul 2024 14:15:48 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 902998893E
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 14:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2eaa89464a3so16535641fa.3
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 05:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720181746; x=1720786546;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=hWebfJrLwsUzMgMvFUyS2eS9wTPP+etTXaIzsqjEBBY=;
 b=02ri+Z3U3t0Tb9tuL1UrcYrvYXRnRCk+Mfj6I3eAUT/0bndETRmYrsXl6JoYcCBA8W
 dz7t84JCaIEMRDcB59CC3SgXJgunbHqBmBNlMAWl7yRgDqXcv+MxW5oErDOpX75VsYni
 k7dTBFv2y+CDzPkIsv47pXgZBTFNkSxjivOmhcB5JNPA3aiLS9fKxQPnE8KqRhq/3eMo
 y0mVnFzzIHkbB+0JbM5UKuyMoUwFQO+5/ECIW0QjL6ZNtbuSSI7TkWK14/TaY4OaAznR
 XFbm3G5evrebmMbD3GzrBca3zHOe0Dh13D0rzp4xgrKFnfRtxOL323a8NzOX/7dwZAp6
 afVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720181746; x=1720786546;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hWebfJrLwsUzMgMvFUyS2eS9wTPP+etTXaIzsqjEBBY=;
 b=snBhpIZ/KYEKcdnKYYH9cnJ+YImPWLxf6u83oYj4f0dSKyVEQ25tQO37oh6fB4cusm
 mOI+xrRe0kX4d/JwgP/kKDpPkdLhR/CpdtO4SAH5KLbMSJpC/N/GGuAQCdnXdhIkCism
 2Izc4uVwbh/ySs4sYfB/5QmjIiOK2fIvCkDlXthFZe6hFwPjMPVKtri08jplhBDg6P97
 cx38paaM48QiIRnA/IEukFUOybUTPWVxdiRwVIs3yHBVfmU+KqIq5s7lFJ9scb5dMRg3
 KThtK/HJoU/rDvnEy3UVyzd/3NPP9b8CZHM4QO8jM5qdC6u+XKA/RqyYyWcMtXNZpJH7
 cc1Q==
X-Gm-Message-State: AOJu0Ywd3A3o4wu9ls1lDvMQeL2r6KN+fwNJJJKGjvud61FMgTIwfaN3
 Rvw/lFDf+8n4KamaiA0p7pnJNfwgY3K2e55xmUTaMN0HIbG5m7JbSYHUOzXu0FQ=
X-Google-Smtp-Source: AGHT+IE1AAFt3++iK+oUFXvjhmJ65hkmRsFG7piqaCWoTD0EjnJRxF2fsrOnR++PxjDcOe6uAcXPSw==
X-Received: by 2002:a2e:9254:0:b0:2ee:80b2:1ea4 with SMTP id
 38308e7fff4ca-2ee8eda2d5dmr27944831fa.26.1720181745635; 
 Fri, 05 Jul 2024 05:15:45 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a21cb57sm58715375e9.21.2024.07.05.05.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 05:15:45 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Alexey Romanov
 <avromanov@salutedevices.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Ion Agorria <ion@agorria.com>, Simon Glass <sjg@chromium.org>, Svyatoslav
 Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] include/fastboot.h: add missing types.h include
In-Reply-To: <20240621015135.1570605-1-caleb.connolly@linaro.org>
References: <20240621015135.1570605-1-caleb.connolly@linaro.org>
Date: Fri, 05 Jul 2024 14:15:44 +0200
Message-ID: <877ce0m3v3.fsf@baylibre.com>
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

Hi Caleb,

Thank you for the patch.

On ven., juin 21, 2024 at 03:51, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> Fixes a compile error when building with only the TCP fastboot implementation.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  include/fastboot.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/fastboot.h b/include/fastboot.h
> index 2ca1b907a54d..b106d6177493 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -11,8 +11,10 @@
>   */
>  #ifndef _FASTBOOT_H_
>  #define _FASTBOOT_H_
>  
> +#include <linux/types.h>
> +
>  #define FASTBOOT_VERSION	"0.4"
>  
>  /*
>   * Signals u-boot fastboot code to send multiple responses by
> -- 
> 2.45.0
