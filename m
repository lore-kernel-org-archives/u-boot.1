Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E65E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 13:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD2F801F5;
	Fri, 10 Jan 2025 14:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C0vV8YKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6524A8036B; Fri, 10 Jan 2025 14:38:44 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA785800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 14:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso1635419f8f.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 05:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736516321; x=1737121121; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JQqJVuROzcu+8CaYzbNDAf4YYJOiW5TwSwQTKVkrlz0=;
 b=C0vV8YKYvH7+6NlnrYAvluvnvL33rf0yvTqbfgK5ISauGXkgPQ1OZ/ZDCm6ykLQZTR
 KuOS79tgNXbTwqYnymwn40fVwJ5HJUbb9CKOPue8GOTbj0u8jTtzHXm7/RCacpHMe+Q8
 mvcgzi9JEDX5WEWKB9Tzq0CU7gqHG0YJ2RE3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736516321; x=1737121121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JQqJVuROzcu+8CaYzbNDAf4YYJOiW5TwSwQTKVkrlz0=;
 b=hP35ipwY+mYv1Y1+T1pnybOhNtrSsx5Kh5ZAz3fHMrsoYS+pSeRPJCIDIJZvXLHEg1
 UPEIecYEVyeK9oZCmaaGK0osXWkiB9GwZLEzzSSmN1ipjEa99dJgkAgevbjXDCVPRGas
 cV/oHWdxAW90wUp+l+A9+4dUA08lyI5mZFCMTV5nl25Txh4qunlojaQg+3NYA5T0iqXu
 ekbHEtazzyl6mQFnt/hNz2FWTOUimo9C65lI+mLaeGJ8UBnKc9a2J8YVsd9R+1yYkfdf
 9Ja+od91XPVbyhQGnsKnx+UDnM+SEmbhplly1/4KAr4sWmtTRjoCHXIMu+ffHzL4u5CR
 Cg7A==
X-Gm-Message-State: AOJu0YwnJ5klKhAFLKSMgTuZPvn+mNyNpTkmuYkijkbjV93UlLpe7zXv
 DZpTpJ8/k5hOFn8k7rk3ZjZ+LUn2Q+tBWS8ZynQIBzzO+IdiNLyDcBaQrR/maBqpDJGzqYEKMv8
 /PePmVHg61dpE4v2K9xQ+ngvhUpyT1dtXNsM/
X-Gm-Gg: ASbGncu3yQMVvbp8TeVw9yu0pFdVcqG9GnPKBxLK6Z7E0rOsbtiUYSsHZbpgnJewYay
 +6WFhx51/okevMKPlrJXBUw9rmGxbrqlOVI39OXE=
X-Google-Smtp-Source: AGHT+IErkIov1qNH3IiAuae1wNm5KMlTHdr90FIFZpL++DwAYh9eHRz08gpR2/8U0WtD/JjQ+Cp42ZlnSIvtL/ZxNc4=
X-Received: by 2002:a05:6000:2a3:b0:385:fb8d:865b with SMTP id
 ffacd0b85a97d-38a8735649cmr11377708f8f.48.1736516321413; Fri, 10 Jan 2025
 05:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-22-sjg@chromium.org>
 <20250106214025.GB3476@bill-the-cat>
 <CAFLszTjt3mr+ZZF0SmKdhDKsT8khmLG8NNsTnmWSXbX9+ei5=g@mail.gmail.com>
 <20250109151414.GV3476@bill-the-cat>
In-Reply-To: <20250109151414.GV3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Jan 2025 06:38:28 -0700
X-Gm-Features: AbW1kvafNygH4IKdoYUOQeCjaxjRh0ZlgOR-cb9xuVlUK_EMwt9ZqN5PslBln6Q
Message-ID: <CAFLszThjBM+pKRAV0z8-kFqAEwoyeOn3m2hrebwYggcLoVsTTg@mail.gmail.com>
Subject: Re: [PATCH v2 21/33] emulation: fdt: Relax condition for
 OF_HAS_PRIOR_STAGE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 =?UTF-8?B?TWFyZWsgTW9qw61r?= <marek.mojik@nic.cz>, 
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>
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

On Thu, 9 Jan 2025 at 08:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 09, 2025 at 08:01:22AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 6 Jan 2025 at 14:40, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Jan 06, 2025 at 07:32:17AM -0700, Simon Glass wrote:
> > > > QEMU always gets its devicetree from the OF_BOARD mechanism so we should
> > > > not depend on !BLOBLIST here.
> > > >
> > > > The logic of PRIOR_STAGE is quite a mess, unfortuantely. We should rely
> > > > only standard passage to receive things from the prior stage. QEMU
> > > > should implement standard passage to provide its devicetree to U-Boot
> > > > However Linaro has blocked my patch to provide devicetree additions[1],
> > > > so little breath should be held in respect of either change.
> > > >
> > > > [1] https://lore.kernel.org/qemu-devel/20210926183410.256484-1-sjg@chromium.org/
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Fixes: 2b71470628c dts: OF_HAS_PRIOR_STAGE should depend on !BLOBLIST
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  dts/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > index 41a758e83a6..fc25a854708 100644
> > > > --- a/dts/Kconfig
> > > > +++ b/dts/Kconfig
> > > > @@ -191,7 +191,7 @@ config OF_BOARD
> > > >
> > > >  config OF_HAS_PRIOR_STAGE
> > > >       bool
> > > > -     depends on !BLOBLIST
> > > > +     depends on !BLOBLIST || ARCH_QEMU
> > > >       help
> > > >         Indicates that a prior stage of the firmware (before U-Boot proper)
> > > >         makes use of device tree and this board normally boots with that prior
> > >
> > > Since OF_HAS_PRIOR_STAGE has no prompt, it shouldn't have a depends line
> > > either really. I believe 2b71470628c is part of an attempt to say that
> > > if you have bloblist enabled then that's how the previous loader needs
> > > to pass the device tree. But indeed that's not quite how to enforce that
> > > kind of demand, so we should just drop the restriction here (and some
> > > other time fix the "imply OF_HAS_PRIOR_STAGE" to be "select
> > > OF_HAS_PRIOR_STAGE" because it's not prompted, imply is the wrong
> > > keyword.
> >
> > So, just drop the 'depends' line?
>
> Correct.

OK

>
> > I don't understand all this prior-stage stuff and I believe it is the
> > Wrong Direction. We should just say where the DT comes from.
>
> Yes, but we're all keen to not rehash years worth of discussion here
> either.

Indeed.

Regards,
SImon
