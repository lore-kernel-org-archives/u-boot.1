Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A18C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 06:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B35B581E06;
	Tue,  3 Jun 2025 08:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a/xfPTBl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C08FA81E72; Tue,  3 Jun 2025 08:44:58 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4643180F0E
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 08:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4a43972dcd7so62795391cf.3
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 23:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748933095; x=1749537895; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fnt5TX0MApGX2obe/HoAgCeNBh6hN4/g9EBMGOD5Ngg=;
 b=a/xfPTBlUDbP5g/CvWanf3v7DOsYRodAr+8Ti1uPDh9X2ZL8bIZsTVsCp6//ytz3At
 EuZFK3TRhMc6b070xSM1cr2cCcchtKowRFlFx9zKdpFAWQd4aK1HWAz5Q4SlwJSfo0tm
 wRGt0jtPMdHXQBBwXX1W3zWhchkZcyvQCRHU11gcSpW//zN1BqfRz4tcsVuG7O584wCw
 yv+5hYbiCgB8LyrN/bJyFvZ/InuUulDZIJVJxmXScmUvGnJXTqxUsSBeJTiuPxnWcL+6
 9thoRAMg96A2iF1pqLZXwfDhTRgiuYYeqqLdh4K3XDSQkKp3HplIQ+YbozMtg3HNTNPE
 1pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748933095; x=1749537895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fnt5TX0MApGX2obe/HoAgCeNBh6hN4/g9EBMGOD5Ngg=;
 b=HP7UKwGx/Pp1pxO+11dGGrC14rNxuh9yX71sumCiWD1twfGKXMW1p8l+x8NFMSCqtP
 0JyP+pEDni4dWyOER2lcdxGG3LFD4Qw41FfCrjsWQHsvu0/H6E5as9PZI9NfbLYzpQvO
 CX9huAnbKsbT5jniL4xmyoi/t9k41KM/aPnuzCna74PXc4TH/PEW+C4BPxInkOYUhKpn
 rQbIyNIlrofyHV0KXAHv6N71ygJ7DmsFSrsatl4wiuRuz38k42+J0Oupwwvkzpw8u7q+
 X8dcJsTwI6Fc3LyFd2a0lV9gu8w2Rzhz8PJrSJbEvSgyOxuRnPH4OaiMrVml7dHFhR36
 OZAQ==
X-Gm-Message-State: AOJu0Yyw60G7s2hEbhXPkMJYcNZCKRb47WvoWH8BVy24EJ+G3DiEjzlE
 XtHPgxY2xHAJmdrYKeMvh2N3KfCSMiib9RVsB63oNoOuODJJm8ixJe0gHYQtp2C4uBDaXZ145Af
 3oWzCVIglKmkBHouFkJl8YbkvVbTZh5+AV1JR9zs1+w==
X-Gm-Gg: ASbGncvtdIeu7fGXhR6HSPOT0HwjChgmpDcKhAxt+1CBPy50Nhax61hQcrjUMhMtliG
 7jmQV2Ic9MVUBsbnp7c7tcgqm7rWOWEE3u95PYhH0qnD9KbPHz8Ixt6O0ErVXp97vUEnb8ehtSh
 BKokj6NtyFdPHDkpcM17FxhyzKH/UD0+Gqzu5UefW9QCJFymY/0pEtQN4=
X-Google-Smtp-Source: AGHT+IG0ZHkPWlrRr+yYFFwf7d11AipAtZiXWSB6C8DZwONQTRLEEYgCW89RX7x7PNw5Sq6BEJvtK43ZKDNpddMv62Y=
X-Received: by 2002:a05:622a:17cc:b0:4a4:41e9:738e with SMTP id
 d75a77b69052e-4a4a5e8d9a2mr155028531cf.6.1748933095143; Mon, 02 Jun 2025
 23:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250526091253.400802-1-sughosh.ganu@linaro.org>
 <20250526091253.400802-3-sughosh.ganu@linaro.org>
 <CAC_iWjL+0bwPS9eXfvnFjN8UcAta+zgHz8vfDWz5YvVwoE9tsA@mail.gmail.com>
 <CADg8p96yFhzabfzZEhNzWX+kEwBuOsih0kVL+0d=ZLt=F2JNDQ@mail.gmail.com>
In-Reply-To: <CADg8p96yFhzabfzZEhNzWX+kEwBuOsih0kVL+0d=ZLt=F2JNDQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 3 Jun 2025 12:14:44 +0530
X-Gm-Features: AX0GCFtOlCL81Dj4FYLUiGg7yBODLfhYlY0pxyObuignIl0C2rhLrglbslkYoUU
Message-ID: <CADg8p977sXJRS1CM6Lnmep0_gc3jc9b3yFg1A-qkVn5Gswr_=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] lmb: replace the lmb_alloc() and lmb_alloc_base()
 API's
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

On Fri, 30 May 2025 at 15:41, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 30 May 2025 at 13:17, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > > +static phys_addr_t lmb_alloc(phys_size_t size)
> > > +{
> > > +       int ret;
> > > +       phys_addr_t addr;
> > > +
> > > +       /* All memory regions allocated with a 2MiB alignment */
> > > +       ret = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr, size, LMB_NONE);
> > > +       if (ret)
> > > +               return 0;
> > > +
> > > +       return addr;
> > > +}
> > > +
> >
> > I think we  need a better naming for these. Right now we have
> > lmb_alloc() here and in tests, addr_alloc() in snapdragon code.
> > I'd say either export them as API if you think they would be useful,
> > or get rid of the wrappers.
>
> I kept these functions as is to reduce the amount of change resulting
> from introducing the API. Also, the newly introduced API has
> parameters which are common across all the callers, which also was why
> I kept a wrapper. This is especially true in the tests, where it would
> be required to change the function names in a bunch of places without
> much benefit.
>
> >
> > [...]
> >
> > > +static phys_addr_t lmb_alloc(phys_size_t size, ulong align)
> > > +{
> > > +       int err;
> > > +       phys_addr_t addr;
> > > +
> > > +       err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, align, &addr, size, LMB_NONE);
> > > +       if (err)
> > > +               return 0;
> >
> >
> > This tends to blow up in random ways. See
> > commit 67be24906fe. TL;DR 0 is a valid address in some systems.
>
> Yes, I see your point. I think the calling function will have to be
> re-written such that the env variables get stored only when the API
> returns successfully. Then at least the platform will not have an env
> variable with some junk value.

Thinking about this a bit, I think in these two instances, returning a
value of 0 might not be an issue if the DRAM memory does not start at
0x0. Don't get me wrong, what you are suggesting is definitely
correct. I am only thinking about increasing code size on these
platforms if 0x0 is not a valid address, and moreover since the
platforms were already setting 0x0 in case of an error. If it is okay
to increase code size on these platforms, I will change the calling
function, such that the variable does not get set in case of an error.
Maybe Casey and Mark can comment? Thanks.

-sughosh

>
> -sughosh
>
> >
> > > +
> > > +       return addr;
> > > +}
> > > +
> > > +static phys_addr_t lmb_alloc_base(phys_size_t size, ulong align,
> > > +                                 phys_addr_t max_addr, u32 flags)
> > > +{
> > > +       int err;
> > > +       phys_addr_t addr;
> > > +
> > > +       addr = max_addr;
> > > +       err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, align, &addr, size, flags);
> > > +       if (err)
> > > +               return 0;
> > > +
> > > +       return addr;
> > > +}
> > > +
> > >  #define lmb_alloc_addr(addr, size, flags) lmb_reserve(addr, size, flags)
> > >
> > >  static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
> > > --
> > > 2.34.1
> > >
> >
> > Cheers
> > /Ilias
