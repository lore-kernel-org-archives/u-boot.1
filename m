Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EA4C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7458288615;
	Mon, 10 Jun 2024 17:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZvBvZxS5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A0DD885FE; Mon, 10 Jun 2024 17:54:16 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B66D885EB
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 17:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5ba33b08550so2435511eaf.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718034853; x=1718639653; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WGZiK5w2L1TdeItHQX6kTaHRoyUzwKHMj1WWNaQc9DQ=;
 b=ZvBvZxS5NGkXGg06kU0liS8J99SejLvUl38QobhLVM1j5qvabZjtQksA08k5Cr9XbB
 YCjoL3EhljlH0QCyC+4M+kujJ/pAIlqy91RJu7chusCPczjorqHRa8lnfgmkVxv+Ybf5
 hcNZRq9wam4pg29V4d4A/fmddVaVa2BTSQfac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718034853; x=1718639653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WGZiK5w2L1TdeItHQX6kTaHRoyUzwKHMj1WWNaQc9DQ=;
 b=YN7MBJWxizHhI6YBHExBCvgVmL+py+5ImGDCxEoetR9NamJuGHpZwhNNQTMlz3mgD+
 ZlhnG+TieZKLwqE8DnIHZf/l+85YYxAtjbwNKkwKqOD82xy6nDSFlHzdN904+CuorUpg
 EV+63lmi8ZvkLWXacrS1re8t65kpWeGcsQHgfaAp8i/sxDo+AXGoYh7tUa9/XNL+09DV
 mdPxL7wAzMHmdp1RiG76muZCXMdFBWCGWle3zL9ETooAQ2TFDmcLBeSh9fACOSVA8HWY
 2yopF008WJd0QnCO1efaHbov33+IRwERJJFOdIzpvOpv5aofeHEQo67/IBv/EdWNsXaH
 CefQ==
X-Gm-Message-State: AOJu0YxwsKVIGb41KhYWoxWIrWGiuF6rlGEdjF7nurv3vaQ2ncrrYmgn
 4sLf+k54YbNgl2Iu0Wk+Tfolvio4Kjc/4UdWMMEahs6gmQi4t8VwYPkwlnx7sgqHfOhJSJnnO8o
 vm1CFnK8tSZDvPJDT6XyKGBS6NnePeTuXTn5QsSCdPtI8EKU=
X-Google-Smtp-Source: AGHT+IEi0M7Ov4TNjgKBH8NrBTIYLcb7PweWr6/mvkWnZ/pGyfwpk5ggMrZ9Ze8Vmj91zULLDN15SYvTr24zT94KEf4=
X-Received: by 2002:a05:6358:4327:b0:19f:5317:499b with SMTP id
 e5c5f4694b2df-19f53174b78mr326292955d.30.1718034853009; Mon, 10 Jun 2024
 08:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-6-sjg@chromium.org>
 <CAC_iWjK6CKheBax2VxL4JydJqLzus9UF5hNMqMXtscqebxKuwQ@mail.gmail.com>
In-Reply-To: <CAC_iWjK6CKheBax2VxL4JydJqLzus9UF5hNMqMXtscqebxKuwQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Jun 2024 09:54:02 -0600
Message-ID: <CAFLszTh1X3zGnN_DOQvuJGAqBM5BoeZZuS0k5ntL5kkc+Oyv7g@mail.gmail.com>
Subject: Re: [PATCH 5/9] fdt: Correct condition for bloblist existing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jerry Van Baren <vanbaren@cideas.com>, Shiji Yang <yangshiji66@outlook.com>
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

Hi Ilias,

On Tue, 4 Jun 2024 at 23:33, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, 5 Jun 2024 at 06:26, Simon Glass <sjg@chromium.org> wrote:
> >
> > On some boards, the bloblist is created in SPL once SDRAM is ready. It
> > cannot be accessed until that point, so is not available early in SPL.
> >
> > Add a condition to avoid a hang in this case.
> >
> > This fixes a hang in chromebook_coral
> >
> > Fixes: 70fe2385943 ("fdt: Allow the devicetree to come from a bloblist")
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  lib/fdtdec.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > index b2c59ab3818..b141244e3b9 100644
> > --- a/lib/fdtdec.c
> > +++ b/lib/fdtdec.c
> > @@ -1669,8 +1669,16 @@ int fdtdec_setup(void)
> >  {
> >         int ret = -ENOENT;
> >
> > -       /* If allowing a bloblist, check that first */
> > -       if (CONFIG_IS_ENABLED(BLOBLIST)) {
> > +       /*
> > +        * If allowing a bloblist, check that first. This would be better
> > +        * handled with an OF_BLOBLIST Kconfig, but that caused far too much
> > +        * argument, so add a hack here, used e.g. by chromebook_coral
> > +        * The necessary test is whether the previous stage passed a bloblist,
> > +        * not whether this one creates one.
> > +        */
> > +       if (CONFIG_IS_ENABLED(OF_BLOBLIST) &&
> > +           (spl_prev_phase() != PHASE_TPL ||
> > +            !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
>
> The same condition exists in common/bloblist.c.
> Carve out a function --e.g
>
> bool can can_enable_bloblist(void)
>      return ....
>
> instead of open coding that

Unfortunately it looks like the conditions are different, with the one
you mention being:

if (spl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
from_addr = false;

(is that the one you mean?)

So I don't think I can combine them into a helper function.

Regards,
Simon
