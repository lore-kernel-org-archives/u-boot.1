Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5656BC04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 10:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE02688456;
	Wed,  8 May 2024 12:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dvaxD8s3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFFC78845B; Wed,  8 May 2024 12:14:04 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B131E8843F
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 12:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a59a17fcc6bso972558566b.1
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 03:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715163242; x=1715768042; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qbHRYC0ndcZjB0GS0deexMm2SXWks0VOSuVzOPo75u8=;
 b=dvaxD8s3gLqLOICZzXRR7m43pHJyf2DJTXdxfWLJX0vhXhUFixe0N0ls/5LrBLDLEK
 gaPGEoz881gk6q2T8emfyIu/X1KwgB/qnTy5GOXM8Xv25KUZ0X2F1o+MxWZsrjPm1Cs7
 BWj9Sbh0lwvL8ZHs21nhsvAxGp5zjc1L3uUumWe5r84VmYvqC32S4huEiQTN8bpyxwHd
 KYSxmqpNZ0UFg1lQUBwQJzOTINidtvvh+zn2ZX/eDkP4/fJXVRP77EMb6RiRi8Mm3LaN
 cCKFi6e62ah8MrIgmhGap82GLQwOphzTExvhHBL5+vx3oAvLJ2dk4Bt6Q6QMuF1o7Hu9
 lPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715163242; x=1715768042;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qbHRYC0ndcZjB0GS0deexMm2SXWks0VOSuVzOPo75u8=;
 b=JaRoOAFbHWgaODP8DLBZGuOWPOGMpP9tdxn7/skEmmqjtCgUOtPHVZUavVEOaUD/JL
 vBS6ikV4ulxcsqYwv5hECGuY+NpnKDPEhO+qg/OzLMMFTUQnYLOTRJvVeDpQvCafLRDv
 kpBu1q+Qtu/fG7waZ8ABaV3kaijHcAtqhiyjvcvtKkPbraiREWOZFg1deBRILXhpev+/
 AhnR9tw0Y1VafbDC9+X+pMQ9qvuamGqCfDeyxpnGmKDcbJiVn53bMEncfAXJEGLYcSoz
 DrHZOwxW+0MfUvgkoMz2CI1sqPW06Ly/AC2vCxyXgi6VlZ0meeLd21jBRScwM4pzr4+X
 iFKA==
X-Gm-Message-State: AOJu0YxTk1/kRD30MbG794UEyJvkeqzoJeGA4yAwA/fX91DR3ic+eyQ5
 IFJoOndzMMx1mGU37aLt9QTdtpuv143vphTg/szqi64MYYZZCvKr83qRxUIRRLIeFZIGRhM40KA
 Xf+Exq0W5QmWKz+qy8pwQ1ybDotGIY5xZoJk96A==
X-Google-Smtp-Source: AGHT+IFyTvZvfC5hAOKASag9gYs934CyROI0qtQF6A4jce8H08At2aT1JimrsQP8tobyRDnpTcjNFvxfGvBTxMfrMqM=
X-Received: by 2002:a17:906:cb8f:b0:a59:c319:f1dc with SMTP id
 a640c23a62f3a-a59fb949305mr126834966b.4.1715163242165; Wed, 08 May 2024
 03:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-6-raymond.mao@linaro.org>
In-Reply-To: <20240507175132.1456512-6-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 May 2024 13:13:25 +0300
Message-ID: <CAC_iWjKmX5pwrSe_e3L+V6GTVEO_122zWTfQpYntQha2aZ7T9A@mail.gmail.com>
Subject: Re: [PATCH v2 05/28] image: remove redundant hash includes
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 7 May 2024 at 20:54, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Remove the redundant includes of u-boot/md5.h, u-boot/sha1.h,
> u-boot/sha256.h and u-boot/sha512.h
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
>
>  boot/image-fit.c | 4 ----
>  boot/image.c     | 2 --
>  2 files changed, 6 deletions(-)
>
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 89e377563ce..1efc39f4408 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -38,10 +38,6 @@ DECLARE_GLOBAL_DATA_PTR;
>  #include <image.h>
>  #include <bootstage.h>
>  #include <u-boot/crc.h>
> -#include <u-boot/md5.h>
> -#include <u-boot/sha1.h>
> -#include <u-boot/sha256.h>
> -#include <u-boot/sha512.h>
>
>  /*****************************************************************************/
>  /* New uImage format routines */
> diff --git a/boot/image.c b/boot/image.c
> index 073931cd7a3..e57d6eae52d 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -26,8 +26,6 @@
>  #endif
>
>  #include <asm/global_data.h>
> -#include <u-boot/md5.h>
> -#include <u-boot/sha1.h>
>  #include <linux/errno.h>
>  #include <asm/io.h>
>
> --
> 2.25.1
>

This seems unrelated to the series of mbedTLS. Can you send a series
with the fixes independently? Tom can pick them up before mbedTLS and
it would make the review process easier


Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
