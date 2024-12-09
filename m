Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B22E77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 18:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 287E489712;
	Mon,  9 Dec 2024 19:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b8kaVXmQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EDEF88DFE; Mon,  9 Dec 2024 19:18:02 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2AD3896F9
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 19:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so259186266b.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 10:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733768278; x=1734373078; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rKasUoHBnkNbI8rIdqUhH14b+Mp2VbymZMOPyDprHl4=;
 b=b8kaVXmQrCos76z5iEVr18vAqTLVX+ylpw9k/SycBVdy5jQ7h510W8TVw24aCR1nAe
 12Mcvbl+Ap3p3/BVNIyv5R4VDcn73WzNEL4//GADGOsbhoKn9oLExz6tynQEcoIzvrXm
 1i+m6LNpiRqthiWitZrcRGzzt7teuBkp8jvq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733768278; x=1734373078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rKasUoHBnkNbI8rIdqUhH14b+Mp2VbymZMOPyDprHl4=;
 b=NpjBupVHrhAlJj5EbRKhfCUdfvV8qgDplexnjKeauFJMBSl1tyKCOmcgbcweNKjIl4
 RWK54GBiGDB8aJmH6uyPx5A5/Td2ytrPWX66/k4gHMr5AVlYVKSDYeHotAgqLRdzDHjA
 918jz+xqu2AdHDpwK/RkEvppZYU588lAgqAcCZeUffHrC6CGanDgbX6Ue/kU+24eKdpG
 zhtpYGVIcJ+sikTZfOH5io2Sp5ASZ/+e2D6OwCKKbEszr9B2vmjYv7kZERYblFX/ZMNU
 LJMu5sH+UmyoTS096sErWNRL8GvpohmUdvX7bQ8E2kd6HAG7UrI6Qh1sugAionZ3nHYF
 ZnSA==
X-Gm-Message-State: AOJu0YwA6W+PAofuLpSSa7iwgJCvxtfKdvHFQGxY1G5PccJUGIP4DvM5
 lde0RDeEk/fR5iufU0FcOyUChjaoecr2oPfqomy3JIDxL0nxMNs+x9wU6u60236awbVRRwyCcuR
 A9LpoCoB0FQ9qRmkGVgK2QlXrIPg3i9I1jDET
X-Gm-Gg: ASbGncuQyia9yupyWen/gfjjFSJBl/u6DDmYE5WJ9GUEh9G9ZmtFcHtaEoVTeJJXdcw
 dSFwGiHE5TZm6BbhDTX6/ipCiFjlN0dr5
X-Google-Smtp-Source: AGHT+IH+8B4ok3yE58e5wtbGdJA7ynTTU5HH8tXq4teeoBwSCQ522iuvsq41pQhZqaAgeQUtU4NOSF2FVbuz83wBuOE=
X-Received: by 2002:a17:906:cc9:b0:aa6:6fa5:65b0 with SMTP id
 a640c23a62f3a-aa66fa5664emr595849866b.44.1733768278041; Mon, 09 Dec 2024
 10:17:58 -0800 (PST)
MIME-Version: 1.0
References: <20241206131113.2865416-1-sjg@chromium.org>
 <20241206131113.2865416-3-sjg@chromium.org>
 <20241206141310.GP2457179@bill-the-cat>
 <CAFLszThS0mDMe=ujRDPFDDrhM_9p=o=v5oBbpsQTAbDNfU5Qpg@mail.gmail.com>
 <20241206194915.GY2457179@bill-the-cat>
 <CAFLszThxuK=W5gYPPNtaObf-3te-Rc+T-3rXANkMfFAxs0ECSw@mail.gmail.com>
In-Reply-To: <CAFLszThxuK=W5gYPPNtaObf-3te-Rc+T-3rXANkMfFAxs0ECSw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 11:17:46 -0700
Message-ID: <CAFLszTgo5a=j4+X+tiQWtOCs3BCm4pkp5-CXTtGwiGhBJ-B_9Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] fdt: Allow expanding the devicetree during relocation
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, Sumit Garg <sumit.garg@linaro.org>, 
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

Hi Tom,

On Mon, 9 Dec 2024 at 11:07, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Fri, 6 Dec 2024 at 12:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Dec 06, 2024 at 12:18:07PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 6 Dec 2024 at 07:13, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Dec 06, 2024 at 06:11:12AM -0700, Simon Glass wrote:
> > > >
> > > > [snip]
> > > > > A comment in that function says that we assume there is space after the
> > > > > existing fdt to use for padding, with the padding size set to
> > > > > CONFIG_SYS_FDT_PAD
> > > > >
> > > > > However, there is no guarantee that this space is available. If using
> > > > > the control FDT, then global_data is immediately above it, so expanding
> > > > > the FDT and adding FDT properties will cause U-Boot to fail.
> > > >
> > > > This sounds like a generic issue and should be fixed outside of a "Pi"
> > > > series.
> > >
> > > Yes and I know you keep asking for multiple smaller series, but I've
> > > explained that keeping track of all that for months at a time is too
> > > challenging for me.
> >
> > Yes, and it's also too challenging to review for the rest of us.
> >
> > > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > > index 41a758e83a6..360611edd01 100644
> > > > > --- a/dts/Kconfig
> > > > > +++ b/dts/Kconfig
> > > > > @@ -219,6 +219,17 @@ config OF_OMIT_DTB
> > > > >         This is used for boards which normally provide a devicetree via a
> > > > >         runtime mechanism (such as OF_BOARD), to avoid confusion.
> > > > >
> > > > > +config OF_EXPAND
> > > > > +     hex # "Amount to allow the control FDT to expand"
> > > >
> > > > No "# ..." because the help explains what to do here, if needed.
> > >
> > > OK
> > >
> > > >
> > > > > +     default SYS_FDT_PAD if OF_LIBFDT
> > > > > +     default 0
> > > >
> > > > A "default 0" is almost always wrong.
> > >
> > > In this case it is correct, since it means not to add any extra space
> > > for the FDT.
> >
> > Which is still wrong? Because we don't allow for this particular device
> > tree in memory to be read-only and so the question is "Do you want to
> > break things on some platforms or not?".
> >
> > > > > +     help
> > > > > +       Some boards make use of the control FDT to boot an OS, thus when
> > > > > +       image_setup_libfdt() adds extra things to the end of the FDT, there
> > > > > +       needs to be enough space.
> > > > > +
> > > > > +       Set this to the number of bytes of extra space required for the FDT.
> > > >
> > > > We should just use SYS_FDT_PAD directly and not add a new option.
> > >
> > > I thought I read somewhere that fdt_high == -1 should not be used. So
> > > for most boards, this padding is not needed?
> >
> > That's also true, and gets back to why putting multiple patches in a
> > single series is a Bad Idea. The function in question isn't doing some
> > check for if we've disabled device tree relocation for the OS, it's
> > early on, it's reserving our control fdt, yes? And then the problem ends
> > up being later on, we use the control fdt for the OS, and modify it, but
> > haven't ensured there's enough space for said modifications to not stomp
> > on something else? That is a much bigger generic problem, no?
>
> It seems that people are already aware of the problem this patch
> addresses, but since it is specific to fdt_high, which should not be
> used, it seems unnecessary to worry about it.
>
> I'm going to drop this patch.

I forgot to mention one other thing that I noticed.

If someone uses U-Boot with this series, but does not erase fdt_high
from the environment, then it will not boot. It seems like a bit of a
trap, to me.

Regards,
Simon
