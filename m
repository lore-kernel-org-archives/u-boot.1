Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9913D0E6D1
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F53188F8E;
	Mon, 21 Oct 2024 10:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ega4sBJG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F348788F8E; Mon, 21 Oct 2024 10:56:04 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9717889EB
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e3d523a24dso3060337a91.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 01:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729500961; x=1730105761; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+SVExKu+7sWB7Y/nwK06cY4fZOEdnkt+1Emrbyvmzxk=;
 b=Ega4sBJG1vdN3wldBvLHE6AW1JDZklC5qvA6i2F11o+aRiP/OhJL9Ek8MlDEjGJ7/7
 fPN6ryaHRrwFZ6jmy7k8FIVpeJ2NJ17PaSCmvX+yzJoa1TbY3uUWNgOqhtPN2nWTh9kU
 92daw+hSs7pQb+RQJHpWds1ZTtvjj410OLXQKLSjhBuS8s+VA4jJHryqkPi8jOTHe2R3
 xvc08Ky1O3v4oiOZ3A3QrDg7WHZpb2pSxBGGkkL8sQzMJd+eL893icsJM9eMGLQ4sgWi
 MGGG82RNmMNKA0j2p/EHu7V9MHmBELadUoE+jFDVgnei3HpePEIJebMA39TIiLQpMN/8
 EQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729500961; x=1730105761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+SVExKu+7sWB7Y/nwK06cY4fZOEdnkt+1Emrbyvmzxk=;
 b=fsF2837li6gJ5JugEmxreoVaNhHayoZU81+N4DJc/sCDLfgKwgvRmGGyUOrGrAQ/Jn
 FYPRl7x7cijDlA4O5beIquchHlk5mjRO1rCF+OFP5kJITZsyHqopy6UanUh2N3NLcXxM
 DRu7N0OKrKljQLnJtI+uHDgEqKERVk//27aBS+Vfhz/wdN2c6OCeHfpHsxt3rpCndfMC
 kS8aCZXXPU3uUS6NzUfKgB2/REsT1+Mi8n9HMakOAxxrBWwgj+gMcKYI4NSC70F/YZW3
 8iZCcuF+GA0+ay4fMG7CWAsu/fZYYr+qDqymj3vHQphXYn2mhJq/YVJwy18yvRYyOfBV
 1kIw==
X-Gm-Message-State: AOJu0YyXuy3OgzxmDAK7YdSY4k7vnNTjUTAROq5BYpIVP0lMDpbR47a/
 rUOLpnBaB10mKRZxaFDDPHCu2Jn3rmIpKNbabu3A1EdNzPxTNIcX5sKOJ4rbtq5HqwcuO7wXcKu
 vlRyoL3MoUZ6GKyKrRH+v4g7ZjlsaHEf3mKoLhg==
X-Google-Smtp-Source: AGHT+IF5vtyyuOivafoy/9X6lAGmFHYnNDX0RulrjXjkCz8414c1oWK6DEFWJynjptLl5QSMLlzxBJIeWWbI+TVlmvQ=
X-Received: by 2002:a17:90b:4a0c:b0:2e2:b3f8:b549 with SMTP id
 98e67ed59e1d1-2e561650b59mr13040344a91.23.1729500961400; Mon, 21 Oct 2024
 01:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241021081934.289473-1-sjg@chromium.org>
 <20241021081934.289473-8-sjg@chromium.org>
In-Reply-To: <20241021081934.289473-8-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 21 Oct 2024 11:55:25 +0300
Message-ID: <CAC_iWjL23bNJCOsGAu_200Dc0_FiJeLo0CBDwP87ckG7okVtyw@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] lmb: Export the lmb data structure
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Mon, 21 Oct 2024 at 11:19, Simon Glass <sjg@chromium.org> wrote:
>
> Provide a way to access this data structure so that the meminfo command
> can use it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v4:
> - Add patch to export the lmb data structure
>
>  lib/lmb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 7e90f178763..eec99c185ee 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -887,12 +887,12 @@ int lmb_init(void)
>         return 0;
>  }
>
> -#if CONFIG_IS_ENABLED(UNIT_TEST)
>  struct lmb *lmb_get(void)
>  {
>         return &lmb;
>  }
>
> +#if CONFIG_IS_ENABLED(UNIT_TEST)
>  int lmb_push(struct lmb *store)
>  {
>         int ret;
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
