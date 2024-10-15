Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536D0D2169C
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B3668811C;
	Tue, 15 Oct 2024 15:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oOa+6lFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E3C38811C; Tue, 15 Oct 2024 15:10:48 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE791880F4
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cb82317809so38148286d6.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728997844; x=1729602644; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M5Gj09dvHpTmISFlAsvD7+Y+usk3ZctE5UIuUrldp2U=;
 b=oOa+6lFbIR2AO+2rqK15dekjdptCPLlqyiA0Fg137xOSu4rMrfib1BFUnNOM0gdHJc
 zhIdxNIkOE+Y9i32VnkMvhsn998/jVbMgAnuOcUGiNA8FezrOfhB1eGuI3YMzD05rrKp
 AY7LTOiBsD0xhbSAeWz9USzm6bVMPNYJmZ2Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728997844; x=1729602644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M5Gj09dvHpTmISFlAsvD7+Y+usk3ZctE5UIuUrldp2U=;
 b=M0AscBjc6jgHIyqzAfaP5iS3sF8dqghjgCQFPYb/EsJBrAeMBemYu21I1qKbMF32La
 kZfDppPV/C8PQ+BoDJYwFSIu7WUSM9cFyMKNsbFaOjfQDM0lG7bfvpZiP0zGmdL9wEVz
 fLNVHSyluoDhW78zQjIoqDtpwFSRo4Juh4f/KUzX/Qoe4HcskisulzgxmCgSkaMv2CJD
 yCY2sNwfm5tJIwYO1JsIyRA7ZS47POt0a38NzYERchWxjofexFhYFyU0XnpXfqqqGdKY
 SCUYG4xohdQOWSeJgWlyuDVUU8g00Z8rDgguayFEcG8t4HJ/uF4951GvXItxA2inkpPI
 /WCg==
X-Gm-Message-State: AOJu0Yx857r0LLeYqRjjg/YS+rstiTaYtte66Jw4yQtciJrKSTaTFqpP
 /LfGd3gyLu0WF/kV99NXa/GmQVCGCgmMd0j2PpcJj0GAW7kguPk00wwrEBCLEusGyJDJCKmuUFE
 PUCydbArXJGt/CDFCN9/29k4n61zEIbXFYzsu
X-Google-Smtp-Source: AGHT+IH6GC+GJ1sfl+4wv71nD/hupPyRcy6De5JrV/AJgnJ+lpjZz2Iuc6zCjJ/fps9yB37T/PHJIziImBtraUa8/DA=
X-Received: by 2002:a05:6214:418a:b0:6cb:f99d:5d71 with SMTP id
 6a1803df08f44-6cbf9e95a32mr168676466d6.33.1728997844602; Tue, 15 Oct 2024
 06:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-11-sughosh.ganu@linaro.org>
 <CAFLszThkoMSEgxnHQQBYEswbHcFHuDWn0RiJOCN6jV7g=Y+9Qg@mail.gmail.com>
 <CADg8p95iXsJP=oEuxwfzLm1oLDoJMfTfGH4pw1TV-rRF7vVLJw@mail.gmail.com>
In-Reply-To: <CADg8p95iXsJP=oEuxwfzLm1oLDoJMfTfGH4pw1TV-rRF7vVLJw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Oct 2024 07:10:34 -0600
Message-ID: <CAFLszTg6R=Yv=Og9Er3fvtdvsbPLYvuv78+j3=+9zy5=xqW8Sw@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] lmb: allow for boards to specify memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Tue, 15 Oct 2024 at 03:31, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Mon, 14 Oct 2024 at 21:21, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Sun, 13 Oct 2024 at 04:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Some architectures have special or unique aspects which need
> > > consideration when adding memory ranges to the list of available
> > > memory map. Enable this config in such scenarios which allow
> > > architectures and boards to define their own memory map.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V2: None
> > >
> > >  include/lmb.h |  2 ++
> > >  lib/Kconfig   | 18 ++++++++++++++++++
> > >  lib/lmb.c     |  3 +++
> > >  3 files changed, 23 insertions(+)
> >
> > Since this is in addition to the existing LMB (which protects U-Boot's
> > memory-region) I suggest emitting an event in initr_lmb() to add
> > things to the LMB.
>
> But I thought this approach had been agreed upon by you. I had shared
> a branch with you earlier [1] which had this commit for your feedback,
> and you got back saying that this approach is fine with you [2].

If this is just for x86, then sure we can sort this out after this
series. The x86 thing is strange as there are sometimes several tables
involved.


>
> -sughosh
>
> [1] - https://lists.denx.de/pipermail/u-boot/2024-August/562690.html
> [2] - https://lists.denx.de/pipermail/u-boot/2024-August/563498.html
>
> >
> > But for SPL, this doesn't work, since we are trying not to add events
> > for SPL. Perhaps I will discover this further on in this series, but
> > which boards need to do something special in SPL?
> >

Regards,
Simon
