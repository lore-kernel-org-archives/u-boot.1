Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FDAEB64DD
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 18:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92DAD8692C;
	Mon, 14 Aug 2023 20:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hxww6/Of";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41FD886958; Mon, 14 Aug 2023 20:43:11 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 505FD868D0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 20:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4fe28f92d8eso7308559e87.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 11:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692038588; x=1692643388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6SKURnMRu4q1NY5VP52ThfPW8GMQry2g+G5eGwgdj4o=;
 b=hxww6/Of/9ZZ6x7stvC8vrbzl6CqAa6u8ej25R+ptETP5uO8YrICyelGBIuXFg8cda
 jN4CH6yH9v/LlZkeKlRCW7SeAXlzZlO7wBA5kFohCyzxe47O6ZGGC5kRYM2DYuXOE5V8
 qFWHYYcziXb1hoqSziybNFBmhqyR5I4UU0bM/0x2kqF9+v5DctCDOLRYse1eTisIJZMv
 oP8o5LDiopn6TvFtYs5hcGgo12ecPRzaRcZsTs9BaQrUiPAKtMh1Vl2N1EvMNWsvee7H
 ye1UYhkT6vLU9xL6ul6Fpoh2DnrD+CRHSwg3oXbyvICgEFuLDSZAnGfXVvl5k0+K4+Yt
 SM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692038588; x=1692643388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6SKURnMRu4q1NY5VP52ThfPW8GMQry2g+G5eGwgdj4o=;
 b=Mw2PRWPo7LgktV84YyJQ3KSxX/9blzF0QvAwPLLtWq2xIPoyl/O5CP1+UVkWPks8YT
 A7kD6QpC+OyFzNctOW00+QJTVu2jXgR67t4cr85g259tcSbMMfkj9dvvBQB7IqA3aAU3
 MNhAieDKV28CxYWBAJ5zsJqqXPapWDyzCgsuV4iSQcLeuZqEqrChp3eJx9uzg6GU1Xxv
 3FQpBNKIQC7fltrBd04SNkM1JK9kMTH8XDVuFHDylp/FjHAjCLCL2+2hZyVTtAo6yz3+
 +8gdqa2w2EuTf/heYHncrcXd83R4nbu9+YZQZEDDTaxjFYAwa8d44BGc7pwZ35hKKayV
 gBAQ==
X-Gm-Message-State: AOJu0YxaHXlmtwKu3lMn060O2kYhcoXJlYWx+rFUl8i/q8Nb6fELbO5o
 aQaPfAb+0QPyfbdz8HRNIvSm9awSMzUPZHI8ckS14Q==
X-Google-Smtp-Source: AGHT+IErC+A9ofKhHu83XpjKdb1yv5WThmxdKpEFJHtARh4l/UAySaHAX7ItQhSl/aEwidhPPkxkaAqmtvqVfOgSbrg=
X-Received: by 2002:a05:6512:2117:b0:4f8:76ba:ad3c with SMTP id
 q23-20020a056512211700b004f876baad3cmr6357166lfr.55.1692038588536; Mon, 14
 Aug 2023 11:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230814090309.1548310-1-sughosh.ganu@linaro.org>
 <20230814090309.1548310-2-sughosh.ganu@linaro.org>
 <20230814150425.GW3630934@bill-the-cat>
In-Reply-To: <20230814150425.GW3630934@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 15 Aug 2023 00:12:57 +0530
Message-ID: <CADg8p95CFpBK+5C6th6D0w4guTsjdR1bGavGEb61kVsqyxyQSw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] scripts/Makefile.lib: Collate all dtsi files for
 inclusion
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
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

hi Tom,

On Mon, 14 Aug 2023 at 20:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Aug 14, 2023 at 02:33:06PM +0530, Sughosh Ganu wrote:
>
> > At the time of building a device-tree file, all the *u-boot.dtsi files
> > are looked for, in a particular order, and the first file found is
> > included. Then, the list of files specified in the
> > CONFIG_DEVICE_TREE_INCLUDES symbol are included.
> >
> > Combine these files that are to be included into a variable, and then
> > include all these files in one go.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >  scripts/Makefile.lib | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index f5ab7af0f4..f41b16781d 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -179,10 +179,13 @@ ifdef DEVICE_TREE_DEBUG
> >  u_boot_dtsi_options_debug = $(warning $(u_boot_dtsi_options_raw))
> >  endif
> >
> > -# We use the first match
> > -u_boot_dtsi = $(strip $(u_boot_dtsi_options_debug) \
> > +# We use the first match to be included
> > +include_files = $(strip $(u_boot_dtsi_options_debug) \
> >       $(notdir $(firstword $(u_boot_dtsi_options))))
> >
> > +# The CONFIG_DEVICE_TREE_INCLUDES also need to be included
> > +include_files += $(CONFIG_DEVICE_TREE_INCLUDES)
>
> This is what I wanted, logic-wise, but I think include_files is too
> vague.

Okay. How about dtsi_include_list, or dtsi_list? If not, can you
suggest a name which you think would be apt. Thanks.

-sughosh
