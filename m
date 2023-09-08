Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D98EE8010
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD6A86A1F;
	Fri,  8 Sep 2023 16:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GkLr1O9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C6486A27; Fri,  8 Sep 2023 16:37:27 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E9CE86A1D
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 16:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jassisinghbrar@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so276595366b.0
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694183844; x=1694788644; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QkmdLr978RBi6uIfMOfJ4FBGaNUk+P+6uGiJAfI/hCM=;
 b=GkLr1O9wMeSC9S3Pku6zigZqIaTZAUTzmpUK3QSPVXUNjeXwgJr6D9whkvIC76nsq/
 q7t4wrXz2+n0XuO2oSYl5aFinmhcXHm0PEowji2pEih+3xyl4hhc8M0SKl31KGeuHCQ5
 Xobv7k31YbyztuODmQGijVpO1+nRtSyepb7fFsA7a1UaSr6ul9gTNaRhMufiC9b6hDcD
 QFtlFqOWegQ4W+fY3StOLkLvyzMWr5+FwOyeVWnvcjtkGIvUPMS94LR+B3ZnPFqw29y/
 mKMvamAk0dkQ6Ry0pyC2IBvb240XBltkxR3EVx7X52jEjHJsGcSOJYVL9oi9VhB4YFUo
 i32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694183844; x=1694788644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QkmdLr978RBi6uIfMOfJ4FBGaNUk+P+6uGiJAfI/hCM=;
 b=cmR5g5CAWVsKtF1xqnF7e4cl+hMXCn/WkpFqtoNIraOXuCYmVItcrEPGD2bqn1vRQs
 6/2mxHZB6EwAbZAFjUeM0sqmUylOrno4iWA1D3PLpKjlbCs/cVMrWUG52XJFEHuMslS5
 xiDZs4g+wrKE7INAvfO0oDWn0/JMa+JeJNuaWmNfdu7HfnPjGHDS0t9V9txyXFYGXb7e
 P/mnmb8HZJYUxn6wKbPfVqIv7l8ud3onaKRxxTNCpKFvN/gXSUGnc9ECmHZMYczL8ZlC
 H9yB18p9jkpVHsQHDE/DL67lnxdVxm9/DsJsIBnJ3sK+2W95uueLAcScq24Mzd+bfkfA
 PEYQ==
X-Gm-Message-State: AOJu0Yzh8FGP/tCo6d7ckdall9dDlyxlIyXH3h1LMDzU+vrTHGS7N2G6
 gclitSif6ysb8S3yivomXeBxZk16s0kKPaMvZpw=
X-Google-Smtp-Source: AGHT+IH38tEwekKnAA3XYcp5i785V1/ALENdxqSd4MBwNdFo0DV4lflbDeeu0mLG+jrZXCqd763IscRjmj9ZmukMBmg=
X-Received: by 2002:a17:906:253:b0:9a9:fc14:abec with SMTP id
 19-20020a170906025300b009a9fc14abecmr1790020ejl.50.1694183843777; Fri, 08 Sep
 2023 07:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org> <ZPldgbS8mu+5DG7Q@hera>
 <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
In-Reply-To: <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Fri, 8 Sep 2023 09:37:12 -0500
Message-ID: <CABb+yY0VJDu+L2C10E1O-uAU-p0OwuTq6XVF2XbYuOc2fBqoww@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rob Herring <robh@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

On Thu, Sep 7, 2023 at 3:08=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
> On Wed, 6 Sept 2023 at 23:20, Ilias Apalodimas
> >
> > > > I beg to differ. Devicetree is more than just hardware and always h=
as
> > > > been. See, for example the /chosen and /options nodes.
> > >
> > > There are exceptions...
> > >
> >
> > We've been this over and over again and frankly it gets a bit annoying.
> > It's called *DEVICE* tree for a reason.  As Rob pointed out there are
> > exceptions, but those made a lot of sense.  Having arbitrary internal A=
BI
> > stuff of various projects in the schema just defeats the definition of =
a
> > spec.
>
> Our efforts should not just be about internal ABI, but working to
> provide a consistent configuration system for all firmware elements.
>
Sure, programmatically we can pass any data/info via DT, however it is
only meant to map hardware features onto data structures.

devicetree.org  landing page
    "The devicetree is a data structure for describing hardware."

devicetree-specification-v0.3.pdf  Chapter-2 Line-1
   "DTSpec specifies a construct called a devicetree to describe
system hardware."

If we want to digress from the spec, we need the majority of
developers to switch sides :)  which is unlikely to happen and rightly
so, imho.

regards.
