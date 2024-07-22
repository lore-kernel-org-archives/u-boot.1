Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A43C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1A11883BB;
	Mon, 22 Jul 2024 19:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wW0/hy9d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C319883D9; Mon, 22 Jul 2024 19:34:00 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56D2688395
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4928989e272so634362137.2
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721669637; x=1722274437; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CPYubr7er9J9d6B2C24uq9A0y4uuJUDbhv7WXbhTjJo=;
 b=wW0/hy9d+4CKq+RsGXUDFyZ09ZX7bi+1kQFVp947Fbrb0/nVLwLlxsB/CuSxaiGx86
 8YjOR9/vb8ELjf3+aTY53JQJ4GkvH9zOTvXo8xZhnkyttkfrwcZVttscOiP48VqRldzm
 Lt643LfC+SrtlndqEIn13pci63Yh5YtqAskY1p2UkVcqE79MZ39S/RneBdUjyy/D1I+I
 lVUvxvLNZ3ofXbgDAU7V18guEYGvH1KZL6U470JsDVwVW21H0x0mXW8kLHLyQljreouQ
 0l4FJZveu8b6g5o9Ef+m8jgJGMUJRtutUyG7XWzzFHF4JC3W0gXFFmcAC+YJESID1YL3
 Ye4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721669637; x=1722274437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CPYubr7er9J9d6B2C24uq9A0y4uuJUDbhv7WXbhTjJo=;
 b=V0qIbYmh0JJmHOulK7qRYi0mxxuGbyhPsj9l4c8yUfpjckphEFo2Eln92uJ1i1//D2
 eCWrmwcftmBupN+Jl6JrlwlHhEK5z/9FM350rfxQrtHeYHpHYducTuA6Z/871+7wou1K
 1VQ2DRbUAey/34U1QhJGUfy+BJQoVDuNDjVmeFLqgsmWCYg0B8/9sggQ8g2nq2Ktwasr
 qM+IymMr0J0Ld72wZYFWTCJnUjnAWRA6c10ZkE5dDsJV7GuuFD/hob+woRPqHtewB0fG
 oEkaWwwBDzjk4BVK4JjFindwv4AkgbqZH0ur4jgkESQ8oYHUfOf/k96vkHKh1Xr79N4+
 yUHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVolp8EEOglNoSYa57uX/UjXOi+Bluxq/PtSsfirHPzfMr7d7jxAQUVopMP6vUkBf75dPiWkUjPasHJW8RUrUWHhoN3Sg==
X-Gm-Message-State: AOJu0Ywgn79RAV9aJxp/20ligdfg70yHH9htE5H0M8VGvlROFjo3dNg4
 HdaFIhgIUZtYU5EnLHbHUkOhGpqmIZ+2XH04DfxolkKswP5sgEXKdp6YUlduttwH7Rl6/i6cI4T
 v+fOB/NTWTb6w8bwKty25w511Jm6KCupcearZAw==
X-Google-Smtp-Source: AGHT+IFjEwjEggwzq78QhkI9ASrApf/tp0zdjGgr8h66RXJ64o9kbSEtZD3kiTJCAmz/TMynLErAgaMcYKhMWJOhpJY=
X-Received: by 2002:a05:6102:6ce:b0:48f:df47:a4a8 with SMTP id
 ada2fe7eead31-4928ba9f4damr9473516137.29.1721669636918; Mon, 22 Jul 2024
 10:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
 <20240719-b4-dynamic-uuid-v5-4-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-4-8a83de3fe3dc@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 22 Jul 2024 23:03:21 +0530
Message-ID: <CADg8p96vdO5iqwQXtSpkQ6fqvrjmuuoWxHjQ3CtV7Xq=SEX2Eg@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] doc: uefi: document dynamic UUID generation
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Mario Six <mario.six@gdsys.cc>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

hi Caleb,

On Fri, 19 Jul 2024 at 18:14, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Document how platforms can generate GUIDs at runtime rather than
> maintaining a list of UUIDs per-board.
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/develop/uefi/uefi.rst | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index d450b12bf801..b284736cf6c2 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -448,8 +448,35 @@ the location of the firmware updates is not a very secure
>  practice. Getting this information from the firmware itself is more
>  secure, assuming the firmware has been verified by a previous stage
>  boot loader.
>
> +Dynamic FWU GUIDs
> +*****************

I believe you are using FWU as an acronym for firmware update ? If so,
can you mention it that way ? We use FWU in the A/B update context, so
it would be better not to use the term.

-sughosh

> +
> +The image_type_id contains a GUID value which is specific to the image
> +and board being updated, that is to say it should uniquely identify the
> +board model (and revision if relevant) and image pair. Traditionally,
> +these GUIDs are generated manually and hardcoded on a per-board basis,
> +however this scheme makes it difficult to scale up to support many
> +boards.
> +
> +To address this, v5 GUIDs can be used to generate board-specific GUIDs
> +at runtime, based on the board's devicetree root compatible
> +(e.g. "qcom,qrb5165-rb5").
> +
> +These strings are combined with the fw_image name to generate GUIDs for
> +each image. Support for dynamic UUIDs can be enabled by generating a new
> +namespace UUID and setting EFI_CAPSULE_NAMESPACE_GUID to it. Dynamic GUID
> +generation is only enabled if the image_type_id property is unset for your
> +firmware images, this is to avoid breaking existing boards with hardcoded
> +GUIDs.
> +
> +The mkeficapsule tool can be used to determine the GUIDs for a particular
> +board and image. It can be found in the tools directory.
> +
> +Firmware update images
> +**********************
> +
>  The firmware images structure defines the GUID values, image index
>  values and the name of the images that are to be updated through
>  the capsule update feature. These values are to be defined as part of
>  an array. These GUID values would be used by the Firmware Management
>
> --
> 2.45.2
>
