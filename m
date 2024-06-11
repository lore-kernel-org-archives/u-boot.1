Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B47C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF09288748;
	Tue, 11 Jun 2024 20:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i78D5HES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A535588784; Tue, 11 Jun 2024 20:52:32 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 969CA88765
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b06bedc5d1so21453096d6.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131948; x=1718736748; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mzO8+aH7KebFsD1OblQKdFujG7uJaFW+ODw90UXXizA=;
 b=i78D5HESXUR6BmHDG67t31+vQVOnKix4NXm/1VgISRoupLwbgO6uprNRC7IeRoY93B
 LAyUZosmkcxZ2xpLais0gFGKvkzDLbsAtt0so14koiwWUYLrvsYTVeXo6Dz9R70Xk/c5
 N4qU2BozFeKtufnKqFKxHemjfQl2qRyqMn5zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131948; x=1718736748;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mzO8+aH7KebFsD1OblQKdFujG7uJaFW+ODw90UXXizA=;
 b=W9u5tEHTr/Acab2yuosflmQwJBWEwTjtdPEgkfosF+owcyfwmNPD9EiE06XdVQVkOj
 SLGwXbyuaQqSi4K1QVzDBWJB7wQ2ZWi/VlF1suqdBe8qIQm6qrWzEwbSi7XKF5eKgfBI
 toE5HgSLZVdB+1fQPdpJd17HGpDfMQSttqA6BR4tYqbo2si1+8iIWFFEDD7KBGdJjy7+
 hJSNwZaVQ6r8y1KYvKE8m2sI9ktwikeYoJF6vg9DriArFrzamoVugxZBZpMpD+AzN/dz
 71dhW89X77/T5GRyEoU+x+XydsnQQbk36fCWULCwxSryIRQgvDazDyxpJ9AuygWxxzMF
 EzEg==
X-Gm-Message-State: AOJu0YwF/GfSK39cJZX7gRua6YgyBL4ka53AszSIgk3HguKqXi1UdEFV
 GU5lQyRSNHcvCRBqWP0f11BWRQCB5DAloPOJsqkcNwt8Ccj4AWMem0QXyulmVfzpWCk3eLD2Isu
 REfB1Yl/cTM6l0XV7TsODx2OcIAKOMYGJScZb
X-Google-Smtp-Source: AGHT+IHbFt2h1gjfEKFYzutCdoPAomLTuGLpSMF867gTLqlbGnHBHAWavQi++AlHQswz9IzdCHVwRmCtIbFHIymO+kk=
X-Received: by 2002:a05:6214:2b86:b0:6b0:7a34:5cdd with SMTP id
 6a1803df08f44-6b07a34616cmr67200086d6.44.1718131948578; Tue, 11 Jun 2024
 11:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-21-sughosh.ganu@linaro.org>
In-Reply-To: <20240607185240.1892031-21-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:52:18 -0600
Message-ID: <CAFLszTgu6YXSrkBCG8gENNB2DB9V7qVPEhyLM+WCLe58B4NCmA@mail.gmail.com>
Subject: Re: [RFC PATCH 20/31] test: cedit: use allocated address for reading
 file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>
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

Hi Sughosh,

On Fri, 7 Jun 2024 at 12:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Instead of a randomly selected address, use an LMB allocated one for
> reading the file into memory. With the LMB map now being persistent
> and global, the address used for reading the file might be already
> allocated as non-overwritable, resulting in a failure. Get a valid
> address from LMB and then read the file to that address.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  test/boot/cedit.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/test/boot/cedit.c b/test/boot/cedit.c
> index aa41719048..1f4147da89 100644
> --- a/test/boot/cedit.c
> +++ b/test/boot/cedit.c
> @@ -8,6 +8,7 @@
>  #include <cedit.h>
>  #include <env.h>
>  #include <expo.h>
> +#include <lmb.h>
>  #include <mapmem.h>
>  #include <dm/ofnode.h>
>  #include <test/ut.h>
> @@ -62,7 +63,7 @@ static int cedit_fdt(struct unit_test_state *uts)
>         struct video_priv *vid_priv;
>         extern struct expo *cur_exp;
>         struct scene_obj_menu *menu;
> -       ulong addr = 0x1000;
> +       ulong addr;
>         struct ofprop prop;
>         struct scene *scn;
>         oftree tree;
> @@ -87,6 +88,8 @@ static int cedit_fdt(struct unit_test_state *uts)
>         str = abuf_data(&tline->buf);
>         strcpy(str, "my-machine");
>
> +       addr = lmb_alloc(1024, 1024);
> +       ut_asserteq(!!addr, !0);
>         ut_assertok(run_command("cedit write_fdt hostfs - settings.dtb", 0));
>         ut_assertok(run_commandf("load hostfs - %lx settings.dtb", addr));
>         ut_assert_nextlinen("1024 bytes read");
> --
> 2.34.1
>

This is a situation where we don't want to make changes.

We know that address is valid for testing. We won't have LMB
allocations that persist across tests...even if that were to happen we
would want the test to reset the lmb state. That is how the sandbox
test-system works.

Regards,
Simon
