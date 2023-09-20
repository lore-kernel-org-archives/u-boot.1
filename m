Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550C8CE79A8
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 02:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 198D186AD8;
	Wed, 20 Sep 2023 04:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BJ/QDGSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 528D986B59; Wed, 20 Sep 2023 04:59:15 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3046F86AD0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 04:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-532addba879so972898a12.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 19:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178753; x=1695783553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V643SAsCTTfad4EbbLdzbqERxWy6FEJmtE4h6yJCaiQ=;
 b=BJ/QDGSdFw0ZI0zVjPW/H3dN6P87ZjldCD25UDSWqlu/dW88EUKEURIKS7WuV8MlZl
 CoWI4gFELeHIvacPuDqclpNmCe0gPxj9nJkvZCxBkOUXXaaaNofV0NWMvnHvSzAiESc9
 IcNzxRLlU0jvn3wZD4G54x/S7/UoWCeYYtebE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178753; x=1695783553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V643SAsCTTfad4EbbLdzbqERxWy6FEJmtE4h6yJCaiQ=;
 b=eszrfSx/SPj5foJpZQU15CUfInr++3DxogHGjQd87QV4RflDh1dv2HTakC9mDsIVew
 z91cB1RGwbX1cRoFU+yoGKoBsrxWEJ/F036c/4VJ04/9Iovh4iHTNW7Zy5aa9Y7misbr
 w5+ksZ5paSO3zUoArDl1YtCu8IEzxLp4StIQ9nkaAwH26B6h3E4jy0GDbnhTS9AbeLzU
 +qT30q9ZrC0auBBVGQhFqAQqVyJ4oHgxMwWfk2GN7ywCoZ2DFOtbORS4PBJfWtcXm3jU
 pCosFXGQU0qbgLbGnTzaggResIZND9naGqMvH7TLVgnZvP6zf2nrE1XtC1ASTgbtlwCe
 YJLA==
X-Gm-Message-State: AOJu0YzrRwwPF3LtBOYuKUcOmDtOYw8QRQ8yBgawuQTixwV3RPk6XJom
 gPbl46Uy559uWj4uCypVFA2qOSVs3JiXtZ9xNGVWLw==
X-Google-Smtp-Source: AGHT+IFmKigqf5hFhksqosUrZEuhiuEGK/+npKsgyJtXdDPDK34Su/JspXcr1OIhz35iF+U9pSZk5k6aMY00Smj09GE=
X-Received: by 2002:a05:6402:11c8:b0:52e:3ce8:e333 with SMTP id
 j8-20020a05640211c800b0052e3ce8e333mr6266049edw.18.1695178752512; Tue, 19 Sep
 2023 19:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230919100222.9319-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230919100222.9319-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Sep 2023 20:58:57 -0600
Message-ID: <CAPnjgZ37dufD9oGuzSBkAoOz6GqndSuYbdYRkQv57k+V14bKJw@mail.gmail.com>
Subject: Re: [PATCH 1/1] binman: doc: Remove incomplete sentence
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich,


On Tue, 19 Sept 2023 at 04:02, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> This is the difference between version 1 and 2 of Massimo's patch:
>
> binman: doc: fix reference tag placement for Logging section
> v2: https://lore.kernel.org/u-boot/20230913161633.999542-1-massimo.pegorer+oss@gmail.com/
> v1: https://lore.kernel.org/u-boot/20230909135235.21242-1-massimo.pegorer+oss@gmail.com/
>
> Fixes: 0f40e23fd22 ("binman: add documentation for binman sign option")
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  tools/binman/binman.rst | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

I don't mind which patch is applied.


>
> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> index 8945b19446..020988d955 100644
> --- a/tools/binman/binman.rst
> +++ b/tools/binman/binman.rst
> @@ -1480,8 +1480,6 @@ as set in stone, so Binman will ensure it doesn't change. Without this feature,
>  repacking an entry might cause it to disobey the original constraints provided
>  when it was created.
>
> - Repacking an image involves
> -
>
>  Signing FIT container with private key in an image
>  --------------------------------------------------
> --
> 2.40.1
>
