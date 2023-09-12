Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4696CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 14:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F293386E41;
	Tue, 12 Sep 2023 16:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="cmLSiOmB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C99286CC0; Tue, 12 Sep 2023 16:41:24 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE90186E41
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 16:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5007c8308c3so9550120e87.0
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1694529681; x=1695134481; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bR7r4o/LL8wmEfFTnFBIjVj4qqyOmRCej7kZxH+l9U4=;
 b=cmLSiOmB4Dlq6jvvg0KEBu8qE/zm9vH9+NlKHBwVJy45R7xfE4yvKm2B8bfH3v7YJf
 wtZ8a+8/BncUIL14NbL9Of3Bt/cKsSUnWEtlCwgOgjTqoHrpIIWjfE16nC2d9yyf5KcA
 wvbOQL4nRHycCtYGvq4FabmD+5dLnDcS8nyq8hOniu8Ts1jGmMqJiG+sT66NcRY3+vjJ
 4IQHi90yxS8n8iK+HDn8nttWf56PsTZ8lDxfXMnTE3oGiRYzwE3sPOgSkc5GaPNxAC86
 arTJ+yIEE19p5wzJxtvRrJt0y0DDHXBidsZSQBPA+TQ2eAeAuBNoZHU5aOX7lbM0RRla
 RsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694529681; x=1695134481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bR7r4o/LL8wmEfFTnFBIjVj4qqyOmRCej7kZxH+l9U4=;
 b=Tcjl0pNEieiV1z9zwv8X4Gv7GTxfkSJXIYKxMjp0GjmN5Azku3awIgQ7BXmZ6mRHqy
 6iR8lL+wehDAox/tBq/JpXGUJHdG0wkfEHvxNx3zCmZPt+OWy7AreuWnnvC9b2YVGwnL
 UsaH4HV32Sh4NWJK/8b0W6442DpjrpZz0/lEhmLsIK7YKj3WDfZVGAO7toIFm2PGPVXd
 3o3Gyp3VPZDW/jPhMbLIjN80fG4cxlb+6VPtiNjSBuCzcT7J9gwwNFnxJpjABfQF/8SY
 kgikonoWFJOx9uEOxcQSl8yxR3HjzscoFr++XaCN4Q8C2d9SaIZWDxhBsjP9Rxzpyoq6
 4htQ==
X-Gm-Message-State: AOJu0YyFfdnAa41XgSse5Ys5MEN396ciCRNtZudPTQyFFwxu1IvfFSVk
 DfXCsxpF2zdq/IdF/a0CZdUKiN5cYN884XiTWhqgbXoq915IL799XGUYSw==
X-Google-Smtp-Source: AGHT+IGKvu24gJnZ4aHTpNdVUFPYZ18BndCXXv1kk5bheDxqs8fZgO6bTgRT3yICvLG3DLFSym5nfSTgfCBIiAHnPcE=
X-Received: by 2002:a05:6512:398f:b0:4fb:7559:aea3 with SMTP id
 j15-20020a056512398f00b004fb7559aea3mr12456145lfu.39.1694529680815; Tue, 12
 Sep 2023 07:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <b2dd17c4-2da7-4785-aae6-6a9568f82fc9@moroto.mountain>
 <CAPnjgZ2-O1NOEpAZKa0zZhG9qEyMdJ+Do644MTrZXKRrbMDcoA@mail.gmail.com>
 <359d53d7-1abc-4d17-88c2-b208d7cfda18@kadam.mountain>
 <CAPnjgZ2YzOKwUkOJs5x7kAQwhKbJu_ef2ryG4q8LALYeUuziAA@mail.gmail.com>
In-Reply-To: <CAPnjgZ2YzOKwUkOJs5x7kAQwhKbJu_ef2ryG4q8LALYeUuziAA@mail.gmail.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 12 Sep 2023 08:41:03 -0600
Message-ID: <CAPnjgZ1Ggr_6m-4=s++jH_4ESzq4J_8E1fkvSz5skaxWh2ZSAw@mail.gmail.com>
Subject: Re: [PATCH] addrmap: Fix off by one in addrmap_set_entry()
To: Dan Carpenter <dan.carpenter@linaro.org>, Bin Meng <bmeng@tinylab.org>, 
 Kumar Gala <galak@kernel.crashing.org>
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

On Thu, 27 Jul 2023 at 19:51, Simon Glass <sjg@google.com> wrote:
>
> Hi Dan,
>
> On Thu, 27 Jul 2023 at 04:56, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Wed, Jul 26, 2023 at 06:49:44PM -0600, Simon Glass wrote:
> > > Hi Dan,
> > >
> > > On Tue, 25 Jul 2023 at 09:40, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > > >
> > > > The > comparison needs to be changed to >= to prevent an out of bounds
> > > > write on th next line.
> > > >
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > ---
> > > >  lib/addr_map.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/lib/addr_map.c b/lib/addr_map.c
> > > > index 9b3e0a544e47..86e932e4b561 100644
> > > > --- a/lib/addr_map.c
> > > > +++ b/lib/addr_map.c
> > > > @@ -59,7 +59,7 @@ void *addrmap_phys_to_virt(phys_addr_t paddr)
> > > >  void addrmap_set_entry(unsigned long vaddr, phys_addr_t paddr,
> > > >                         phys_size_t size, int idx)
> > > >  {
> > > > -       if (idx > CONFIG_SYS_NUM_ADDR_MAP)
> > > > +       if (idx >= CONFIG_SYS_NUM_ADDR_MAP)
> > > >                 return;
> > >
> > > It looks like this function should return an error.
> > >
> >
> > If we hit this error path there probably isn't a reasonable way to
> > recover.  Maybe we could add a WARN()?
>
> When we get an error we should report it. For leaf functions like
> this, WARN adds to code size for a case that should not happen. The
> caller will need to check the error and fail. The function should
> always have had an error-return code, by the look of it. If we adopt
> the approach of warning instead of returning error codes,
>
> +Bin Meng
> +Kumar Gala

Since this is a fix, separate from the poor API:

Reviewed-by: Simon Glass <sjg@chromium.org>
