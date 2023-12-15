Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129BDC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 17:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E6B87C45;
	Fri, 15 Dec 2023 18:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nTL6R/ss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FDBF87C3A; Fri, 15 Dec 2023 18:49:21 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5972D87C47
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 18:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a1f653e3c3dso125726866b.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 09:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702662559; x=1703267359; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lT5+jSyIY6cVXiOxTcRNpam6DR6ghkHpvkeKZ8zzkrg=;
 b=nTL6R/ssQtisgWkr7Z3pFpvVkJ8kLqbXpmjvw+lbvCG4dqbMEzO03q43tuIVEMaohZ
 KSDFrLzdy2sjGgvHID+SN02lecUOiOOvGjubNhSUrwPEvS5a7DpPJoM9PAGRRMYbSOh4
 AQoM/X+OIaMImSmxJXFPdY4nkqlgLGA1Q0Egg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702662559; x=1703267359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lT5+jSyIY6cVXiOxTcRNpam6DR6ghkHpvkeKZ8zzkrg=;
 b=hIg5pevHLLW5HSBYRgQU9gKNTQQtT+7LhTKEs6djrClvfVCXCu4eGQGq67xyOLh5Ud
 TOXqdZV9rri/5YTVspqAISrvJOANrOeYaS8h0XivLpvSoW66j7PtjM2yDjqDuy0h6rA7
 gST6jvL9plV0IX9YAsomtmeLRQe/rCukTg7dC1KbvHsVNbs0kic3+7u/y06G0JRVxmYh
 RFHG+oqAJ/dcx0i0K5XPOjOAi1XFoov81WfQk+RtL8aWh1hcZs8NDjRcek+N0sPZsvVz
 sjzaEtgIoUAvsTlWVALB1vqzT4apLHINhDeMCYjM7R2sVxKsQprlFNBvPhcEyS2/c5G/
 u/Jg==
X-Gm-Message-State: AOJu0Yx7iilM0exxv9vGOKa3qrdLAxKM2KcIZEpJpCf+faCEooZJfofX
 iR4km2SMWya2gJWKI0xQPrxVYiYt2x3QDEAeMEe4h6b4zyzk72UjMkc=
X-Google-Smtp-Source: AGHT+IGPZ+XlKSNsIRITGqdotvZenCWav61fAPUKGJWJFaigKMvICj5/W4feYe/n6YmTgdKbRARiqQjTDogeO4wt8ZI=
X-Received: by 2002:a17:906:2254:b0:a1f:a302:1ae8 with SMTP id
 20-20020a170906225400b00a1fa3021ae8mr2297016ejr.156.1702662558615; Fri, 15
 Dec 2023 09:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20231215094230.130121-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231215094230.130121-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Dec 2023 10:49:04 -0700
Message-ID: <CAPnjgZ1gNb2Vaanjw8--0n=QPYnWwfWdexHFE7zS7cPhCop_+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] buildman: type cotaining
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Fri, 15 Dec 2023 at 02:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/cotaining/containing/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  tools/buildman/boards.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/buildman/boards.py b/tools/buildman/boards.py
> index 341a5056df..3c2822715f 100644
> --- a/tools/buildman/boards.py
> +++ b/tools/buildman/boards.py
> @@ -119,7 +119,7 @@ class Expr:
>          """Set up a new Expr object.
>
>          Args:
> -            expr (str): String cotaining regular expression to store
> +            expr (str): String containing regular expression to store
>          """
>          self._expr = expr
>          self._re = re.compile(expr)
> --
> 2.40.1
>

Reviewed-by: Simon Glass <sjg@chromium.org>
