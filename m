Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE0DE95A7E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2435864F3;
	Sun,  8 Oct 2023 01:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wpt0Iem3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F13BE86ED4; Sun,  8 Oct 2023 01:12:20 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FE5F86EC4
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59f55c276c3so41694107b3.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720319; x=1697325119; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t7ln9ithRvDwxjujFIBo0ONbSpxst78IrldQQ4QwmRU=;
 b=Wpt0Iem3T+9deaa4eRohhZmjHB4MR6RP9DxzbGAYgkQQqLTb1ptAeWSW4qjInShdBW
 zFq1lV9qif5jv63tK4PwRiTOlL4UIJjYkFzv3Yg35PZEQi1QBzAnuF1W9g93km5kAQme
 wzROOY2jXXab0FVneWQByH/aSEl7cPolxkt+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720319; x=1697325119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t7ln9ithRvDwxjujFIBo0ONbSpxst78IrldQQ4QwmRU=;
 b=OgNYsEd0/fL/3YFhrY5JlvVeHnaSyM31yEWfUtwV+rXRmZm0YNflrapmjxZRqLyyLN
 ZTn/Q3PbbGLUsqGxulu7TIpUGF0g8KngOG43QCftnuhq/KfMJn7FR6xDlg0lNDSgYJiw
 YYhPDd3yOh927cnXNVLmsCeCjdo10RmlM84ejEhlkTJq1YVM4ePLKWnw+uvQdngEkdC7
 R1zZORVbFaaN4AhbD/lGxiwO1Fc3RvshWyKV5l9WvgX84s6CkBpmsoHf8xCzFNvM9YiA
 yocFAPWpReKA6BVkGvmGhXEK/5YkwOAa17hg0ocBHogG+OEScAT3P0QNf4qu0MG5wsSt
 RM6A==
X-Gm-Message-State: AOJu0YzB1+CccH6vvF8xePdLWoXg1S97JjEfSUvhT4wahM37jx86w0Pl
 oN+hHWT2LlRxp4w0Nwrjjx4Ahs+Z9b07aaoA7QlEsw==
X-Google-Smtp-Source: AGHT+IHpv6xMknfOojpssMMleYnr8HVLV6HWMZBBeoMJ9ZDIDnqAZ+QyWNpPDU0/q0ho2/PGAzwpsXn4fE9SpJDmDnA=
X-Received: by 2002:a81:8490:0:b0:583:af98:6fb3 with SMTP id
 u138-20020a818490000000b00583af986fb3mr12348658ywf.15.1696720319362; Sat, 07
 Oct 2023 16:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231004112722.416877-1-sughosh.ganu@linaro.org>
 <20231004112722.416877-5-sughosh.ganu@linaro.org>
In-Reply-To: <20231004112722.416877-5-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Oct 2023 17:09:49 -0600
Message-ID: <CAPnjgZ2zhqStA-1viaTgTHvkMWNUg5TYAraWP0UxAi28sr0EmA@mail.gmail.com>
Subject: Re: [PATCH 4/5] btool: mkeficapsule: Add support for EFI empty
 capsule generation
To: sughosh.ganu@linaro.org
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Sugosh,

On Wed, 4 Oct 2023 at 05:27, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add a method to the mkeficapsule bintool to generate empty
> capsules. These are capsules needed for the FWU A/B update feature.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  tools/binman/btool/mkeficapsule.py | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
> index 61179747ff..89c0adfc9f 100644
> --- a/tools/binman/btool/mkeficapsule.py
> +++ b/tools/binman/btool/mkeficapsule.py
> @@ -80,6 +80,35 @@ class Bintoolmkeficapsule(bintool.Bintool):
>
>          return self.run_cmd(*args)
>
> +    def generate_empty_capsule(self, accept, revert, image_guid,

Instead of two separate bools, how about an 'operation' param, a
string which is either accept or revert? Or perhaps just have 'accept'
 and pass True or False?

> +                               output_fname):
> +        """Generate empty capsules for FWU A/B updates
> +
> +        Args:
> +            accept (int): Generate an accept capsule
> +            revert (int): Generate a revert capsule
> +            image_guid (str): GUID used for identifying the image
> +            output_fname (str): Path to the output capsule file
> +
> +        Returns:
> +            str: Tool output
> +        """
> +        if accept:
> +            args = [
> +                f'--guid={image_guid}',
> +                '--fw-accept'
> +            ]
> +        elif revert:
> +            args = [
> +                '--fw-revert'
> +            ]

That can be on none line

> +
> +        args += [
> +            output_fname
> +        ]

Same here

> +
> +        return self.run_cmd(*args)
> +
>      def fetch(self, method):
>          """Fetch handler for mkeficapsule
>
> --
> 2.34.1
>

Regards,
Simon
