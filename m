Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0901BEDE9A8
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 11:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3206086F47;
	Thu, 14 Sep 2023 13:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gqPTaxBA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC63A86F58; Thu, 14 Sep 2023 13:41:27 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 643B286A40
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 13:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-502e0b7875dso1479885e87.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 04:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694691685; x=1695296485; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fFUeX2KbQKotKRnabAzi5RTlTBkSv2CeiH7iOYRZxPk=;
 b=gqPTaxBA+XJhRBR8mIb0hcPjLBI8lirthZ4JBsD6gB2rFFoj4kh2OsMcLV7oSteG29
 0vf3asCg/qOllbSgkdkSXb7G7LzzOq8MIHZV7NBJ4kzWw6Z5kNmt1yP22HgEaKgt5Y6e
 0PnSohL3oW15oc6iiKuVyju6BHT+srYSY+MlZZw1TWevkGu2xT4gCvb3dz7ljItAcuEO
 sqYSQAlixVPbN5OBKxiVzXHnAdLNP4oPQPlQ0+UXkxrCOVI2dHkTxiDPI72mFx7BqATc
 qtBByZEC4LnJcOa2ZuJZnusTRfX88HhST2nehc+f5as+JROLCWQiXhyV+V8xF6d/B0CF
 8x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694691685; x=1695296485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fFUeX2KbQKotKRnabAzi5RTlTBkSv2CeiH7iOYRZxPk=;
 b=w1lPxpO2hjeEoJ1QakBAAPOm1+rmMqMqTt7wHKFQ9kup4PxrCixaYap3kYUGmTKLbQ
 pIEZeTsfGb0dLDHZQzKRhUhDfdBm/NHLUG573k9/m/LZ1PH4WpbwK7phk2qCKTkPKYTr
 4av3g5Txu0XxPS3JtYha+knUyM3F0o7n6rNbLNOQE1VkiKBXsxUxOgA1FHu+8n3Zti2+
 T63x8NfUimm/r0KAjpCkeQWuNNyNl924olEHsKNMZoG6XG21jzqqUl6LN+JpRr47VA5B
 y9Rqf9ZoyNVuWATavuFzDw5ptsoGODi0XLb51FGhveJxc2PHzK956h4ef3wqqp4rH79d
 mSYg==
X-Gm-Message-State: AOJu0YxovGtB43LmwMWZnekcWerXNnxZkXCitZ3pqGorZkn3JkGHsP5g
 BsSVpVArQhRYCDEWNa+bvVTck7ffB9jeTLnTne5fjQ==
X-Google-Smtp-Source: AGHT+IHvi2cXhxzka22a9Pn11wh/vIkFaXtul/Qb8E1+/fZqhdAUyXQ4u/eNJdZ6gizShA4UCP2N6+jhiohaQ/EafLw=
X-Received: by 2002:a05:6512:304d:b0:502:cc8d:f206 with SMTP id
 b13-20020a056512304d00b00502cc8df206mr4870336lfb.23.1694691684510; Thu, 14
 Sep 2023 04:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230908120002.29851-1-sughosh.ganu@linaro.org>
 <20230908120002.29851-4-sughosh.ganu@linaro.org>
 <CAPnjgZ3Zi3hmQg7d5+0461hRK+5O_V89PY=QxMwQarhhqUW6VQ@mail.gmail.com>
 <CADg8p97cQJYogd_MZT_hCH71XjqkO85VEay2fb7hZx1YwX+OPA@mail.gmail.com>
 <CAPnjgZ1EBJJ7ZtHZVo1vp24gCrN-A-m4Hk3udLbKPS18C3QNqw@mail.gmail.com>
In-Reply-To: <CAPnjgZ1EBJJ7ZtHZVo1vp24gCrN-A-m4Hk3udLbKPS18C3QNqw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 14 Sep 2023 17:11:13 +0530
Message-ID: <CADg8p96g_5rmppg0LmrZ_Cch4-HgvafxPedcMbJ-hu_7Awh0Ug@mail.gmail.com>
Subject: Re: [PATCH 3/8] binman: capsule: Generate capsules through config file
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>,
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>
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

hi Simon,

On Wed, 13 Sept 2023 at 23:37, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Mon, 11 Sept 2023 at 08:13, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > hi Simon,
> >
> > On Mon, 11 Sept 2023 at 00:44, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Fri, 8 Sept 2023 at 06:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > Add support in binman for generating capsules by reading the capsule
> > > > parameters through a config file. Also add a test case in binman for
> > > > this mode of capsule generation.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > >
> > > >  tools/binman/entries.rst                   | 35 ++++++++++++
> > > >  tools/binman/etype/efi_capsule_cfg_file.py | 66 ++++++++++++++++++++++
> > > >  tools/binman/ftest.py                      | 29 ++++++++++
> > > >  tools/binman/test/319_capsule_cfg.dts      | 15 +++++
> > > >  4 files changed, 145 insertions(+)
> > > >  create mode 100644 tools/binman/etype/efi_capsule_cfg_file.py
> > > >  create mode 100644 tools/binman/test/319_capsule_cfg.dts
> > >
> > > I think we discussed this some time ago. The problem I have with this
> > > is that it adds another way of specifying the image description,
> > > separate from the binman definition. This introduces all sorts of
> > > problems:
> > >
> > > - the question of where the filenames are located, something which
> > > binman tries to handle cohesively
> > > - binman has no knowledge of what is being put in the capsules
> > > - the resulting fdtmap lacks any information about what is in the capsules
> > > - it seems to create two ways of doing the same thing
> > >
> > > Binman can presumably already create multiple capsule files, just by
> > > adding to the description.
> > >
> > > What need does this feature meet?
> >
> > We already had this discussion earlier about the need for generating
> > capsules through the config file, where I had explained the need for
> > this [1]. This is functionality which is supported by the
> > specification, and we have folks who are interested in having the
> > capsules generated through config file, and also in generation of a
> > single capsule file consisting of multiple input payloads.
> >
> > I understand that this model does not fit with the usual way in binman
> > of generating an output image by specifying it's inputs as DT nodes.
> > But just because this does not fit or align with the design of the
> > tool does not mean that we do not add support for the functionality.
> > Why can't we support this in binman as long as it is properly
> > documented as to what is being done. Moreover, my initial versions of
> > this patchset were attempting to achieve this by adding a make target,
> > but you had shot it down [2]. So it either has to be done through
> > binman, or through a make target.
>
> We have a lot of balls in the air right now...I would like to pause
> this one until we get the other things sorted out:

Okay, fair enough. I will check if the capsule generation through
config file can be added to the mkeficapsule tool in the meantime.
Also, can you review the last two patches of this series [1] [2] which
are adding support for empty capsules. I don't think they are at odds
with the idea of binman. Thanks.

-sughosh

[1] - https://patchwork.ozlabs.org/project/uboot/patch/20230908120002.29851-8-sughosh.ganu@linaro.org/
[2] - https://patchwork.ozlabs.org/project/uboot/patch/20230908120002.29851-9-sughosh.ganu@linaro.org/

>
> - simple capsule update in sandbox (see my other email)
> - example of how to use all this on a real board (Tom is going to make
> a proposal there)
> - tidy up the testing so that it is easier to understand and fits
> better with the test framework
> - figure out the DT story, since we are still struggling to align
> there (Binman bindings, removing nodes, etc)
>
> We don't need to get all those done, but we do need to at least agree
> on the direction.
>
> Regards,
> Simon
>
>
> >
> > -sughosh
> >
> > [1] - https://lists.denx.de/pipermail/u-boot/2023-July/524849.html
> > [2] - https://lists.denx.de/pipermail/u-boot/2023-June/521103.html
