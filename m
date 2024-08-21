Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AB8C531DF
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 02:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA7A88ADC;
	Wed, 21 Aug 2024 04:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sro3/DQf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA9E188B2D; Wed, 21 Aug 2024 04:11:16 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF4B88AAA
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 04:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6bf90d52e79so21447976d6.3
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 19:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724206273; x=1724811073; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zdpgdMbjMHNzNz0E92uFYk/NUMH/6Z0PjqcYzL+t/ac=;
 b=Sro3/DQfmjbHdNqbxUgw38BzeJ2c7XM3Mx9xvk/GktH5Ec/tJDAxDBNMH9rO6kpoVA
 N8nyC0k0ewmZB3RUk6H5ePV0KU49Om+kEICaXhXFzFO33fTz6JrY1gmD+1ncXFjvEG51
 RZpaS4MM/uv43HtXqk3sPQ8kAEwmwFi1bA0WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724206273; x=1724811073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zdpgdMbjMHNzNz0E92uFYk/NUMH/6Z0PjqcYzL+t/ac=;
 b=EDlafqK+d/7l/HWIDmGlOFAXAlJqYN2+HNJzV6v+q3S7P3rYREjLGGA1B/4L+Xshkj
 c/ucbnfRpQQuuHlW1NnQDiujD0EJEnfkd6ixJWevhP8KeZDL1m9P6jROATgG2vOEFITc
 cGPTzviRCNvxbjjIZSXIF+/LQgOQbqgbe5vDGRTz1+BphIcmrUtDIlmm1790BP/EvKb+
 XKzpbv5s0SB2psNJeD083GJalLeVkaD+GgyS5u5LB7NO3d1GQkZOxEXfMvGaT3GSY3f1
 SPdzBycHdncjbFSevyr7WKZx8Fm9oBY46HvQtbaToyFMQuV2WzDBtTLDVMFC++stp00R
 +HYg==
X-Gm-Message-State: AOJu0YygBQo5NqAG307tiJV4u708OhA9g2TSfzzhztaYWHuU/Dj9Mv9N
 oxRDSl3ps9y+svG1ZIic/3yP7OnXm7JyCLo1tgnbCYhw+UteSQgUNBwfeWeSUvFkyEv9fpOHVVn
 DIyobxKIZYkXyCIhfuLnG6oxNP9Z54cRMyFS2MfFfSyO6s6U=
X-Google-Smtp-Source: AGHT+IG5xVWVXdR/CXqEKZf5YKCZLN/IT+Fp0j/FEq2nRrd2yD2OuMg9KpHdl8U7Q7PiQ6Nh5EjYhk5/GqnBoVrGO48=
X-Received: by 2002:a05:6214:550a:b0:6bf:875f:3ccd with SMTP id
 6a1803df08f44-6c155d484a4mr13788036d6.12.1724206273579; Tue, 20 Aug 2024
 19:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240819210719.71747-1-trini@konsulko.com>
 <20240819210719.71747-2-trini@konsulko.com>
In-Reply-To: <20240819210719.71747-2-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Aug 2024 20:11:02 -0600
Message-ID: <CAFLszTjXNK-J8NFing8S3cv_RWoHKED6WhLbbaOZ6R7KMiygwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Dockerfile: Update to namespace for some labels
To: Tom Rini <trini@konsulko.com>
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

On Mon, 19 Aug 2024 at 15:07, Tom Rini <trini@konsulko.com> wrote:
>
> Using "MAINTAINER" and "Description" have been replaced with
> org.opencontainers.image namespace variables.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  tools/docker/Dockerfile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index cda87354566d..f0e36994cc23 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -3,8 +3,8 @@
>  # to build U-Boot and run our test suites.
>
>  FROM ubuntu:jammy-20240227
> -MAINTAINER Tom Rini <trini@konsulko.com>
> -LABEL Description=" This image is for building U-Boot inside a container"
> +LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
> +LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
>
>  # Make sure apt is happy
>  ENV DEBIAN_FRONTEND=noninteractive
> --
> 2.34.1
>
