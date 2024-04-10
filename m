Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35927CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 11:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A95948815A;
	Wed, 10 Apr 2024 13:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rpQdPRUY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E65BE88199; Wed, 10 Apr 2024 13:00:21 +0200 (CEST)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3018188122
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 13:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-479e857876fso1638552137.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712746817; x=1713351617; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M1Vxj7d/B5WXLff3GMxVdaPwKj91ZBL9oZlJc7+b5tM=;
 b=rpQdPRUYCYHiVELSQlsrxjYp0QygZJMVH4QCAQ43+7yruOWLX457ir4FZaKKIXBw0A
 nyOJNSWXGX2vyytElofd99cqHxL0LcNyOjWq7dE/nXyZAvjIRbQwFpK2WJZcgeFlETPo
 +zbF3B5L4FG3hH0YqKYqVD2Z53g3K7ifHilrqLSa55BGrGq/2sC0p9CyldZlCvf++Jwu
 xlCRsfdryCWomfl2lp3I507IKPV24Wm1o/FD3VzpPpJnZBsNxv6tBXXDpaOtagjTQyhS
 0IM+vTiogY5BcuHpN8IDTR9Q1fZfeXUxc5GEwSo/fbuQlE5MEOHJT34W95XI9V2l+YbJ
 cCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712746817; x=1713351617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M1Vxj7d/B5WXLff3GMxVdaPwKj91ZBL9oZlJc7+b5tM=;
 b=dM6I7KXGVuwJdehK+FmYUIqzNZ3i0s/PNNBRTMLSP74kER0EQ5OI7qJ3XqW93Dp2hc
 iM+haT6uHmIh9nxjf61P6CRU3E0mmInIoemv50xmlrkGu35o5KrA9QsmVZwA9kTFjU/9
 5hf9SYHqR/bzZp4f+GYnTIFof6tuKCn7iQvEwOiG2M77BrUlg/obRdU6KjWmiROQXrN6
 PcUBi31Q1ux7AiSBlikbJ3T7NIt99RThUNiRz8bt1TMXtCHgTbzLxQyoMQk6CRo6nm1U
 bqUGh1vtmlixwaUGDQTTQbMNi21r+6/k7dPwGF5qmBqDca255qGLlrg6tQecbCujIRLW
 /E8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqAK/2vzYbOcep07FvGYZUqylrbbzNvlTvtING6ifGEPB3G3XBrHPn6oFEvGonDLyuuKoolzB8d18EkrNugfnoHZVeDg==
X-Gm-Message-State: AOJu0Ywo+of4UuBl7xR9l5GsB8oHF/NNRXCdyLln7vdH/cbtyilsqjF5
 oJ+r0CG2BaFax0uU8f+fjohF5e3VqETKE4JTgtCWjbTk1UTOVXsr1gVcn3MeOebF1nvsw8GtPnS
 vFih7AFLWmOAv8DavWvoajK9/xJjC7Q6QbWgiIwfPMPEILewEm5g=
X-Google-Smtp-Source: AGHT+IH6Ofxx+ZQiOCiXLWwOmi7JLBc20RTPXr8nmp0EpY2xq/o1C3P5ubbKSN7Nde8QwyR5zQjWX0ccL+siGBJHp4s=
X-Received: by 2002:a05:6102:4190:b0:479:d1c6:2ee9 with SMTP id
 cd16-20020a056102419000b00479d1c62ee9mr2206593vsb.34.1712746817072; Wed, 10
 Apr 2024 04:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240409150252.561029-1-caleb.connolly@linaro.org>
In-Reply-To: <20240409150252.561029-1-caleb.connolly@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 10 Apr 2024 16:30:06 +0530
Message-ID: <CAFA6WYMgan5J=C_ugpMJfJD=b8dHF-YVOFDDyd1-R-G9REYN=A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Qualcomm mailing list
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.denx.de
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

On Tue, 9 Apr 2024 at 20:32, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add the newly created u-boot-qcom mailing list to keep track of Qualcomm
> patches.
>
> Additionally, link to the U-Boot Snapdragon custodian tree.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: u-boot@lists.denx.de
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0462ade4ac60..c0d2b5138fca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -602,9 +602,11 @@ F: arch/arm/dts/am335x-sancloud*
>  ARM SNAPDRAGON
>  M:     Caleb Connolly <caleb.connolly@linaro.org>
>  M:     Neil Armstrong <neil.armstrong@linaro.org>
>  R:     Sumit Garg <sumit.garg@linaro.org>
> +L:     u-boot-qcom@groups.io
>  S:     Maintained
> +T:     git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
>  F:     arch/arm/dts/msm8*.dtsi
>  F:     arch/arm/dts/pm8???.dtsi
>  F:     arch/arm/dts/pms405.dtsi
>  F:     arch/arm/dts/sdm845.dtsi
> --
> 2.44.0
>
