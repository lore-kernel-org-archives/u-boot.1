Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79F0C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 12:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B188881D6;
	Tue, 18 Jun 2024 14:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mu09/eLY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A41C9881D6; Tue, 18 Jun 2024 14:43:45 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EB7E88137
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 14:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-797a8cfc4ecso329376585a.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 05:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718714621; x=1719319421; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=43xMkb/sC+i6RXMX71jfOqCIEP1VV6ybLAwr0V/Bmu4=;
 b=mu09/eLYjEYDrlzJfDBlJ9ajGoThybFUzxRGUxTQyFn+1AmwGA84nkDdPMqmaQ90tN
 aF9zGQoz1bmSOD+MfnaozHR0R+NT3n1q1ZAjmJaOEIAD4CEjaKQz33AGwgdk3qj5dNUQ
 h5Mf494hwlad24jXq8fvg6cdMMF7r2UqTCXgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718714621; x=1719319421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=43xMkb/sC+i6RXMX71jfOqCIEP1VV6ybLAwr0V/Bmu4=;
 b=l9utY4q5gI7kxCUjhw59e5TfXP+i4y+Sq84ivKdaDAqJDAsAJ427w3mTbJEcdUh3a2
 yz2VDfmwv+1mBprw21WZN0+JirNil3ZQTId50TP00d9LKAeUEkqkHA1mMVHClqRyKJpK
 v62n1pXFznUeIfYdtMwBEXMQ6F64cOtWNuB1lXbPjWpQNkhq9js9Qqzx0vQq9bzdxJdH
 xAbP+wRd5LDA8x4NYYtOAkTyNw+FCtGCR+ZRZxyzc0Zr0jiecFMJKL2p8uQFKKN2LmHC
 GZx2LMzqoL1PvGxIQO6GJux1EMS/+wdQHdG0qzo0iXCXoT0VcZzCi37IF4ia2cjJ+WWX
 rU0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxEuTuoCcf0cS3xuAGtM8rXRTz/PnEsnBro6CivzO6fEuUqRr+6Jyr3faNb1Ouw5SNeWnB62y9CiyNKS5gcEdG48VGfA==
X-Gm-Message-State: AOJu0Yzpd2iQzthYvDA3cAV8cQoXuVOwg/H3QDGgVoMGpcbh9SKfJ0pW
 srO8aYLvSg+xgMmc9g2JdGKX88lGtE5qrQfkm+v9OyadKCsdNqfoTmQpA069VlWI64bv50igYkH
 J2AgE686OUn3q+2ZWoylQpwOnnzf8cCQnNopP
X-Google-Smtp-Source: AGHT+IEUrOHQPZavuKX3Aia+jjvOJvZQhcXrXv4vUfh0MBf0/q2DfCiH/TiuAME8jYc//ksd+Rh/E4VboGICajDw/Vc=
X-Received: by 2002:ad4:4e68:0:b0:6b0:8fab:d8db with SMTP id
 6a1803df08f44-6b2afcb1a1amr122326626d6.27.1718714621316; Tue, 18 Jun 2024
 05:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240618063230.24478-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240618063230.24478-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Jun 2024 06:43:30 -0600
Message-ID: <CAFLszTioe8E9VPTViyOv-3OPmksj-hgWS=6xJYiq+B0dLfYgXQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] spl: correct link to FIT specification
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

On Tue, 18 Jun 2024 at 00:32, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Replace the invalid link to the FIT file format specification.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> SPL is tightly size constrained.
>
> Shouldn't we remove the message with the link which is only of interest
> to developers.
> ---
>  common/spl/spl_fit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I believe we wanted to use the internal U-Boot link, which can include
the external docs using some Sphinx magic[1]

>
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 988125be008..2a097f4464c 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -587,7 +587,7 @@ __weak void *spl_load_simple_fit_fix_load(const void *fit)
>  static void warn_deprecated(const char *msg)
>  {
>         printf("DEPRECATED: %s\n", msg);
> -       printf("\tSee doc/uImage.FIT/source_file_format.txt\n");
> +       printf("\tSee https://fitspec.osfw.foundation/\n");
>  }
>
>  static int spl_fit_upload_fpga(struct spl_fit_info *ctx, int node,
> --
> 2.43.0
>

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/cover/20240604195256.1820285-1-sam.povilus@amd.com/
