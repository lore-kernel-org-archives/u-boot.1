Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D23CD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 13:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5167384A9E;
	Thu,  7 May 2026 15:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OB25SuSB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1240784ADD; Thu,  7 May 2026 15:30:33 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 251DD84A78
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 15:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bc177ebda91so157900266b.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 06:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778160630; cv=none;
 d=google.com; s=arc-20240605;
 b=AcDDAT+wsrDyyjefJJAW6L5slRu/arS2RmaYnM4MZqVMmHb+bY5ffFJBMkPApUKxeJ
 7spc9hZPS8Q1QxmJIOjIR44MsSd/CwjmUw56cxkLVopUV//LxOVHG8gOzBEDVYg30HSG
 O6mGD2SPVJJoxEC1Kf8yMrrGPj3haCiY0Re17fBHNeFQ86xWJP7yCRc/eqMfAURTaB5L
 W6VtHAkl5B304nn2g7re2wcrO2nTw1/mr2874ThXg2sLNQSIHA2LsswY8gKr52/cTfG8
 o3opcLkF94dfxs1qVIdMTjp9PVc03IQMjRAaOHK6f6jEUdM2E7EmNRRbLVPjKHo3Bk0P
 e1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nW3w2s3VUTnGhQLoJ7iPZHDOSmGY3zPpGIXd3YveCMg=;
 fh=Lwet1BBut5ur9R2NSYCMNJw+S6PZXZ1ROwp9lg8y6LE=;
 b=hHwmo4koTBF09aFWFpswMvAB/S2175l34+Pi7z43M29+BCmsECzNqzjs0pmd7XyvHv
 M3pp+dtw/p4PJE0JEUhskqR37fFuv6P/ExH/31WFhdb7lYsMAtLxxfJ+mBTYDDQjnuoE
 IrMqTZJaxJhH3RiDNcxq/RhtA7m2n3A0LXbYR1Fdee8/vd8eHZjkGCI0Y6I9/o7MPtHV
 sl3XLz/iYObZYmOVXrXJqx1lVrGdQlTg5bUSYTOnBdn3G+rEmpDqMZ82u2MkBGHrb1Ky
 BMbtbOmXT7HjImU6AwWqzLKgsgzw8Yp9rWwO968aJvgaZ29B/ppmRqGI04g/FLfGnWMp
 XxRw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778160630; x=1778765430; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nW3w2s3VUTnGhQLoJ7iPZHDOSmGY3zPpGIXd3YveCMg=;
 b=OB25SuSBIiDIcg+jDS66vi72xwDFV6xhL08gTI8p/4FyuZJ4qfuLReV8PqUVyXZr2r
 doTY61N2ABjdof4NkA9IFk5ZAmV1iIcmF04cpu2+auOuZ0rU/plmHW725KY0IoVTE1ro
 stfJcJBqYOqKrf3W6tz0bJ0JS5+PCHn6Rc6zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778160630; x=1778765430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nW3w2s3VUTnGhQLoJ7iPZHDOSmGY3zPpGIXd3YveCMg=;
 b=b2hk4poP1zwQCKBW9aq7xjKcXev2c+0uJ0isvZPwi7tJF4H0Ik8gaqSg3xZKqtNJck
 T8B9vjXnfF9TxS/gcwaeVbG3IzoIn/8Sh6SvlY7le+59UPl6It/iOmz4E3eaZifo+sA2
 J/6+K1leq4SRiWwj6bWpauB/5Qu5bMZ864Ar5RJ+Cqu1R6B75gZdSDWvVhvYlquaFXsG
 0RUE6TF+11XPhU+WtxrIiUbWNiKt7atmWCW8XUuLPaGd8E1phMDTYkoLpH1Ddd0decWw
 I9gK7lw6Pj9fMe6kujVK6IIa1CyA9RUvEAOD14a3OGlSecGn1lDACFjAwlt6pNvHwQQU
 /eIQ==
X-Gm-Message-State: AOJu0YxVFao3nU4zpJYnqYnVjyu1hRglxXxYE9VkGV0z/FCVhEeHrTBY
 h8hxcHJE8CoX1RLR0V8zHEJORg6oAIMmLIwRPw53ZYlzi8CS8u5x6DccJuXexlFOd6L8x6Rg7br
 ZXyPDgqXiH8GTugAFAaesclbDDaJ5zYcChgABVUl0Jyo6SsCdcNc=
X-Gm-Gg: AeBDiesFHYaprm1NaYMTWfGMXajlGMTj8DldJtLmhks3gXeneSjHZrc01coan7LuLw1
 8OdBzDAbwDuu1bagmauI95VI9Eko2TmrTE4wW5qpCmn06iRU8PkKYO9b6/uO2SmDpsUyFMJIkpF
 Xc8AV3UBFjLnqZnFvbX+/ApjlUT9nt71iBnCfGvbeCX86uGy1IhOdpQAI5+b1fKWsgVI1+r98YH
 re8AFuyKFBXCUjynh7x+IC/Q/qEXyVh2QK10ByS/O5vQhYpqRzfvH8ahuQnCTCol3l6eZIZaTdn
 sLqKX6v79NVMejQt
X-Received: by 2002:a17:907:26c4:b0:bc3:ae79:f02d with SMTP id
 a640c23a62f3a-bc56a649890mr480862466b.7.1778160630343; Thu, 07 May 2026
 06:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260504172731.156719-1-jhaller.oss@gmail.com>
In-Reply-To: <20260504172731.156719-1-jhaller.oss@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 07:30:15 -0600
X-Gm-Features: AVHnY4Jm8TVtNNb-jvZYnRQ_fe8gWb6p99c8aqGtj_rp2VAYVx0MOir108z3gRM
Message-ID: <CAFLszTgW+TF-iPn8=xcYdaNbZnpJ52wJ+G5dppGCzYtLgL9nRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools: binman: fit: support engine override via
 argument
To: Julian Haller <julian.haller@philips.com>
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

Hi Julian,

On 2026-05-04T17:27:31, None <jhaller.oss@gmail.com> wrote:
> tools: binman: fit: support engine override via argument
>
> Allow overriding fit,engine and fit,engine-keydir via arguments,
> enabling engine selection at build time without modifying the device
> tree.
>
> Signed-off-by: Julian Haller <julian.haller@philips.com>
>
> Makefile                  |  2 ++
>  tools/binman/etype/fit.py | 13 +++----------
>  2 files changed, 5 insertions(+), 10 deletions(-)

> diff --git a/Makefile b/Makefile
> @@ -1701,6 +1701,8 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
>               -a vpl-dtb=$(CONFIG_VPL_OF_REAL) \
>               -a pre-load-key-path=${PRE_LOAD_KEY_PATH} \
>               -a of-spl-remove-props=$(CONFIG_OF_SPL_REMOVE_PROPS) \
> +             $(if $(FIT_ENGINE),-a fit$(comma)engine=$(FIT_ENGINE)) \
> +             $(if $(FIT_ENGINE_KEYDIR),-a fit$(comma)engine-keydir=$(FIT_ENGINE_KEYDIR)) \

Please mention these new make variables in the docs (e.g.
doc/usage/fit/signature.rst) so users can discover them - also how
about an example invocation in the commit message?

> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> @@ -646,17 +646,10 @@ class Entry_fit(Entry_section):
>                               OpenSSL API, as second element of the Tuple. None
>                               if no keydir to pass.
>          """
> -        engine = None
> +        engine = self.GetArg('fit,engine', str)
>          engine_keydir = None
> -
> -        prop = self._fit_props.get('fit,engine')
> -        if prop is not None:
> -            engine = prop.value
> -
> -            prop = self._fit_props.get('fit,engine-keydir')
> -            if prop is not None:
> -                engine_keydir = prop.value
> -
> +        if engine is not None:
> +            engine_keydir = self.GetArg('fit,engine-keydir', str)
>          return engine, engine_keydir

The fit,engine and fit,engine-keydir blocks in the class docstring
describe these only as devicetree properties, but these can also be
entry args.

> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> @@ -646,17 +646,10 @@ class Entry_fit(Entry_section):
> +        engine = self.GetArg('fit,engine', str)

Can you check 'binman test -T' and confirm that you have coverage for
the new code?

Regards,
Simon
