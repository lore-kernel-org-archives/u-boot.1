Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6670CC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 00:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93E30882AB;
	Thu,  2 May 2024 02:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mPz1/UTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F03988B35; Thu,  2 May 2024 02:45:15 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 537EE88286
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 02:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-34a42d6e216so1612997f8f.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 17:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714610713; x=1715215513; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9QTgqLBjxq00jYeExKUMIzO6Bsn+6g9PXyxIc41ero=;
 b=mPz1/UTjMqsIWG1otpyQXhbGcEIZYbIFO+/XQn0t69JuHWqh0wDp9vBDEdkeIYgKJ0
 n60jrijQgYVOJDw6wJzotfJrqADmzWKO81FKFM+hAVofSsDqv5FNSjntG+0iH8RGkdhA
 TC+OjqKv5ej5UYRkpmXi+Ol6DolyINmX/9yKAjbI95TNNPLLPiZNu3G2zijvls8/ngu/
 8c7CcuVocM8MFvDP7+mNWr3LS06a+oepI96vhAQM2gIhdYhSMr6KhmswM9lX9WKrY263
 GZiq54Xzb2NMT+VdpCPhTjDjyf4jrLw/nj+jqB6v5G1rt8dtQAhjyCAOrztXwQf+pozY
 Ra3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714610713; x=1715215513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9QTgqLBjxq00jYeExKUMIzO6Bsn+6g9PXyxIc41ero=;
 b=CmoL+OtPdAWNvfP27GQKhqezt2e3gK/ycNN5KbmDsheZt6dT5Mx85OzaxXkzhxJi2o
 OvKuZRLJJa37ev3P5g+GVy0jUpmBfpOMVbdzTDekBj/XNfP+nucxopRvmz+y/CFG39Nu
 xsA1Dw+64WVzpBeQ0MmAWTSV5uFsnXT7AT1FiWjROiq33ZiHy0Hm8WQNeuBYo6J2vQWo
 eKr/PMv0djosiyR8e+nLvo/8ko0tmIutUpH63HtmohHmmWmF5D7tOW/A7CWC0u85U/pe
 E9gtrw0j6Zr86gYHlN+uwvkm2nFfa0Z97T7pSpLunrU/3U6WlgkcgQygI9f41LzhMj1T
 KepQ==
X-Gm-Message-State: AOJu0YyEgc5n3Coc9IREajZCvEGby+j/Tp6IBcv/9H75/OwJGtRPYgas
 6ByAopj/gmUWtvF3PtasIbqq6S35xlCXonLg7mH59XbqlmCn6OG6kiXcORlKpd0mvZ2uabv7TbO
 S/tt9gAHR1LfN5xqxtJQw35fknow=
X-Google-Smtp-Source: AGHT+IEBrQmD6GSTIXf6HCePeSCYF/5EplN2QwXu1jHikWK1XwGYo2/cwDQiUeDsgMgKWXcEr/gfU6jhncukxTsPoKg=
X-Received: by 2002:adf:ed4b:0:b0:34d:a29d:a8d5 with SMTP id
 u11-20020adfed4b000000b0034da29da8d5mr2537395wro.4.1714610712383; Wed, 01 May
 2024 17:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-70-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-70-trini@konsulko.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Wed, 1 May 2024 17:45:01 -0700
Message-ID: <CAByghJbN7tg3wz4AmMS7MpDcg9kZG3h5Z6Z=1MPOEVs3mgAMgg@mail.gmail.com>
Subject: Re: [PATCH 070/149] board: hisilicon: Remove <common.h> and add
 needed includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peter Griffin <peter.griffin@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Apr 30, 2024 at 7:44=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
>  board/hisilicon/hikey/hikey.c       | 1 -
>  board/hisilicon/hikey960/hikey960.c | 1 -
>  board/hisilicon/poplar/poplar.c     | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/board/hisilicon/hikey/hikey.c b/board/hisilicon/hikey/hikey.=
c
> index c9a2d60ee56c..95a831efcafd 100644
> --- a/board/hisilicon/hikey/hikey.c
> +++ b/board/hisilicon/hikey/hikey.c
> @@ -3,7 +3,6 @@
>   * (C) Copyright 2015 Linaro
>   * Peter Griffin <peter.griffin@linaro.org>
>   */
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <fdt_support.h>
> diff --git a/board/hisilicon/hikey960/hikey960.c b/board/hisilicon/hikey9=
60/hikey960.c
> index f41fabbad099..5029f4edb2af 100644
> --- a/board/hisilicon/hikey960/hikey960.c
> +++ b/board/hisilicon/hikey960/hikey960.c
> @@ -4,7 +4,6 @@
>   * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>   */
>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <errno.h>
> diff --git a/board/hisilicon/poplar/poplar.c b/board/hisilicon/poplar/pop=
lar.c
> index b89e7e869766..c3ea080ff75a 100644
> --- a/board/hisilicon/poplar/poplar.c
> +++ b/board/hisilicon/poplar/poplar.c
> @@ -4,7 +4,6 @@
>   * Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>   */
>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <init.h>
> --
> 2.34.1
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
