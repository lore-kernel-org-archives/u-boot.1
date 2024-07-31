Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A49CC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 866358897F;
	Wed, 31 Jul 2024 16:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hCA8urMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13DB688A05; Wed, 31 Jul 2024 16:38:57 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5C7388A16
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b7a3e468a9so41007506d6.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436734; x=1723041534; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yoMoY6hZ+zyff4u2qmDIEviXmPgEjQhWDCYwGNyGgH4=;
 b=hCA8urMGBR9M/z9CaRwOPpj+ImNKr0Lo/eMv/rjCICeS0WHNyTeWoaKj17QBjyQPYA
 3mhY5hz09WxfVvluGHHD8u7NtIMBR/0DmYomsOTXyMcjCbgFgWFB7i8Y9sMRO9PA6x02
 w/H9VeB/SYoCB6jZWPhdN7XvbNqUmEceOlMLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436734; x=1723041534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yoMoY6hZ+zyff4u2qmDIEviXmPgEjQhWDCYwGNyGgH4=;
 b=xJBu8qrfuG5x3o8o3Ymm+ZIenxvZlJmjgFqzdvCq/d/JHE0Djngl/vkS2W3yDgd6UU
 sruKeaY0nK47RxI3LgukSh7PHdisyRcP2nTdXVFZUAstQmIuDST1Sb/d0LImVooGu8qc
 QwYHIyYuuIr0VNJHggSE6rJLirRn7c+6qCWo/3xL5xI1427PhgNEB5phIYIPgUxcMvzk
 dtR5xp/pmJBPE6N+gjuCF3IzV9B8RKuccxhmh+/H9lC6ynslW38zV/8ymAMJNPYn0Jyd
 E6Ux9um3SuOozdNMtLChfTa6cs3hsEuDniRpuieuYtTRnvioyotvIJ5BY1eZlQZvU+t8
 bP5g==
X-Gm-Message-State: AOJu0Yx/ms2nCPKnBAwsVFon4kI9adC28hqmrp9qJInQs+nt2f556WG8
 I+yKmBFz3yhnpqMGnpOfq6nAwYgNty1Gtr3ZcIAo+3s7/EsRD6yKYNROSFWUOSomMVS11nJGrNc
 GMbcLXEmnLgIRiH7cNbtIGxZYNhWipA+It8pnMtWe3XNMwBM=
X-Google-Smtp-Source: AGHT+IETsOuIZ2gYaO9Kyart5sh8BfPwHKtxtswE35SPFyzgiB3MAyac6hUFRGP6z4+69Y324JTT5jUnhCURoUkVomk=
X-Received: by 2002:a05:6214:c25:b0:6b0:63ab:b7ba with SMTP id
 6a1803df08f44-6bb55a16647mr155643346d6.15.1722436733568; Wed, 31 Jul 2024
 07:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-7-sughosh.ganu@linaro.org>
 <CAFLszTgwmQTwRzBuOJvh-=qBGuq+5fRc6vxBptqgQuJyHyuP6w@mail.gmail.com>
 <CADg8p94zPZVFq3Snus8EPT58xPK1AXiNk227uqOstNtZ0NWx1g@mail.gmail.com>
In-Reply-To: <CADg8p94zPZVFq3Snus8EPT58xPK1AXiNk227uqOstNtZ0NWx1g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:38:42 -0600
Message-ID: <CAFLszTjUGoSFOF1TQevgN_y2KdGsmFeVPT11aK4EEpUOVtx05g@mail.gmail.com>
Subject: Re: [PATCH 06/40] alist: add a couple of helper functions
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Mon, 29 Jul 2024 at 12:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 26 Jul 2024 at 05:03, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 24 Jul 2024 at 00:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Add a couple of helper functions to detect an empty and full alist.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since rfc: None
> > >
> > >  include/alist.h | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> >
> > I had to hunt around to see why these are needed. It's fine to add new
> > functions to the API, but in this case I want to make a few points.
> >
> > >
> > > diff --git a/include/alist.h b/include/alist.h
> > > index 6cc3161dcd..06ae137102 100644
> > > --- a/include/alist.h
> > > +++ b/include/alist.h
> > > @@ -82,6 +82,28 @@ static inline bool alist_err(struct alist *lst)
> > >         return lst->flags & ALISTF_FAIL;
> > >  }
> > >
> > > +/**
> > > + * alist_full() - Check if the alist is full
> > > + *
> > > + * @lst: List to check
> > > + * Return: true if full, false otherwise
> > > + */
> > > +static inline bool alist_full(struct alist *lst)
> > > +{
> > > +       return lst->count == lst->alloc;
> > > +}
> >
> > In general I see you manually modifying the members of the alist,
> > rather than using the API to add a new item. I think it is better to
> > use the API.
> >
> > struct lmb_region rgn;
> >
> > rgn.base = ...
> > rgn.size = ...
> > rgn.flags = ...
> > if (!alist_add(&lmb.used, rgn. struct lmb_region))
> >    return -ENOMEM;
>
> Yes, I had seen this usage of the API in another of your patch.
> However, my personal opinion of the API's is that alist_expand_by()
> gives more clarity on what the function is doing. One gets a feeling
> that alist_add() is only adding the given node to the list, whereas it
> is doing a lot more under the hood. I feel that using the
> alist_expand_by() API makes the code much easier to understand, but
> that's my personal opinion.

With lmb there is the case of inserting a new element into the array,
something which the API doesn't support at present. Perhaps that would
help? It is a little hard to design the API until there are more users
of it.

alist_add() is really just adding an element (not a node) to the list,
isn't it? Do you mean that it is copying the data into the list?

>
> >
> > or you could make a function to add a new region to a list, with base,
> > size & flags as args.
> >
> > > +
> > > +/**
> > > + * alist_empty() - Check if the alist is empty
> > > + *
> > > + * @lst: List to check
> > > + * Return: true if empty, false otherwise
> > > + */
> > > +static inline bool alist_empty(struct alist *lst)
> > > +{
> > > +       return !lst->count && lst->alloc;
> > > +}
> >
> > I would argue that this is a surprising definition of 'empty'. Why the
> > second term? It seems to be because you want to know if it is safe to
> > set values in item[0]. But see above for how to use the API.
>
> I want the initialisation of the list to be kept separate from adding
> more 'nodes' to the list. Hence my usage.

In that case, please rename the function to something other than 'empty'.

Regards,
Simon
