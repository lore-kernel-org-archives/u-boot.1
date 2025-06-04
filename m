Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FF1C5B552
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 06:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D3F181FEE;
	Wed,  4 Jun 2025 08:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vOwY9DwA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9802E82103; Wed,  4 Jun 2025 08:37:06 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 021C581F0D
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 08:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4a43972dcd7so77585381cf.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 23:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749019023; x=1749623823; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RN+dPerI0ACmFVyIcB4w9Ak1fWjBT7QF3ounxIOOS6s=;
 b=vOwY9DwAK/5YnUm2J+lKEKPQ8lQn4vzb2RheYN60zG5NBB1NbA3Xhc3gjAepavwcGX
 CTkC4bFbBCL9mwO4Ho/b9E/VBaF/dBCN+3jUuP9tieFz64q4L7LJvVo/6V9UQY7wIiOw
 ulIli7soY2a3+ueWJ6OxfYA2BTR2/QjM8RhNwIzXSz5HJhBcWZax2DCJ6C+6L4L9Xm3c
 LLO+mkgXF5yhfHXZa1iyGj/HG17F4bsBJpj/V+S0x3XFiuV6cyiO9ley4ROuMY8uSY+Z
 VFPPhVH1j2QbDftZrGAqGiSGOjsUykvZGnCu3dzKP3YdC/tFIG4/jDsuVf5sYe4yIWrR
 94Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749019023; x=1749623823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RN+dPerI0ACmFVyIcB4w9Ak1fWjBT7QF3ounxIOOS6s=;
 b=ikhmVx8bcEicwDR9MSRv+b4yqUNMkOfP8TUfFQVggkdp2k7tTStbXDSHuvoGl009kv
 ovlffY/k9ivprv26B+vIHiE1Cndj19ynb0MqsAUxMVBjRjqRHJCwnZYt2pjueZ9FxdHG
 9pyMdaWAA7xcPmNQW8VOqYnEq59Es3o4Db/EmouXdQztQY3pc9SxCrGUV2XGu1IvZBAF
 ZXNv9gJiYiL7M/gpLvXRyZvbODGX2i8XBMgqVirwTdai9rcpD818dsHgwlkd6PV5FzQe
 H6kf/7ky4pL+PruUxStk92BpLzvQ6K3t6qPabwQQIEabVy2ydpWDpIlGpd0PppLn5FCM
 LG7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV628bdVbIWWcwx4Xn35X+YOvwDY6N6uDRrBvB0nJj+g/y2omS6PTld/jT1/NFe9GyByuRfVQk=@lists.denx.de
X-Gm-Message-State: AOJu0YwFp4Ld3q6oVURyScG1TT2Wk0ACeKyjxeLYWJQHvIBU3aaBhLwf
 w19EtC6wDSjceMU0N4CQQWVRVsvioCl0l4bwO8sN0y3U/Sv8UTV3mwozLZWYAdFnVWNJPL1j7xF
 0DQErFRHF4+6kLWJkKOmh4e2ePLF70kORakWcCo2MYg==
X-Gm-Gg: ASbGncvPm2VaD12uqerPwznmV1Mho0y2fRuSBATWPGMfaohh9cq6OySZeX+Spg3gIoD
 18kHpsyOz7QZSM+QkAsZYSKMVQ8t5WXQ2QVGW3Tpru8+htPu4RpcdiPi2mZXJDgWJbRaZjMilOO
 Ta92zr8osRfDR+Mp/2x744YnNQxc0mKdRqHw==
X-Google-Smtp-Source: AGHT+IE2E9mp2QYT6thLoHaHuOeueQo/VRBRwK0LEt00x1vm6fiOLVaP8D2CeWbN/c8iQ98VU71hFwuZkrC/IqpQLyU=
X-Received: by 2002:a05:622a:1e1a:b0:4a4:2cb0:2b29 with SMTP id
 d75a77b69052e-4a5a5872fbbmr25773161cf.35.1749019022861; Tue, 03 Jun 2025
 23:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250526091253.400802-1-sughosh.ganu@linaro.org>
 <20250526091253.400802-3-sughosh.ganu@linaro.org>
 <CAC_iWjL+0bwPS9eXfvnFjN8UcAta+zgHz8vfDWz5YvVwoE9tsA@mail.gmail.com>
 <CADg8p96yFhzabfzZEhNzWX+kEwBuOsih0kVL+0d=ZLt=F2JNDQ@mail.gmail.com>
 <CADg8p977sXJRS1CM6Lnmep0_gc3jc9b3yFg1A-qkVn5Gswr_=Q@mail.gmail.com>
 <20250603162246.GJ1382132@bill-the-cat>
 <9E314CBB-F00A-4331-B49F-5ECE6B74CF69@gmx.de>
In-Reply-To: <9E314CBB-F00A-4331-B49F-5ECE6B74CF69@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 4 Jun 2025 12:06:51 +0530
X-Gm-Features: AX0GCFuWu1XPnDvejI_n2Z1jIzyqU5X8pv1de0hrzclF177bb_P5Rkf0kzVktQU
Message-ID: <CADg8p94JgSQkWp8oK8UAD-0HswdVJvYUjgfONnk4UdsZ+cac3A@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] lmb: replace the lmb_alloc() and lmb_alloc_base()
 API's
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Simon Glass <sjg@chromium.org>
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

On Tue, 3 Jun 2025 at 23:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 3. Juni 2025 18:22:46 MESZ schrieb Tom Rini <trini@konsulko.com>:
> >On Tue, Jun 03, 2025 at 12:14:44PM +0530, Sughosh Ganu wrote:
> >> On Fri, 30 May 2025 at 15:41, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >> >
> >> > On Fri, 30 May 2025 at 13:17, Ilias Apalodimas
> >> > <ilias.apalodimas@linaro.org> wrote:
> >> > >
> >> > > > +static phys_addr_t lmb_alloc(phys_size_t size)
> >> > > > +{
> >> > > > +       int ret;
> >> > > > +       phys_addr_t addr;
> >> > > > +
> >> > > > +       /* All memory regions allocated with a 2MiB alignment */
> >> > > > +       ret = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr, size, LMB_NONE);
> >> > > > +       if (ret)
> >> > > > +               return 0;
> >> > > > +
> >> > > > +       return addr;
> >> > > > +}
> >> > > > +
> >> > >
> >> > > I think we  need a better naming for these. Right now we have
> >> > > lmb_alloc() here and in tests, addr_alloc() in snapdragon code.
> >> > > I'd say either export them as API if you think they would be useful,
> >> > > or get rid of the wrappers.
> >> >
> >> > I kept these functions as is to reduce the amount of change resulting
> >> > from introducing the API. Also, the newly introduced API has
> >> > parameters which are common across all the callers, which also was why
> >> > I kept a wrapper. This is especially true in the tests, where it would
> >> > be required to change the function names in a bunch of places without
> >> > much benefit.
> >> >
> >> > >
> >> > > [...]
> >> > >
> >> > > > +static phys_addr_t lmb_alloc(phys_size_t size, ulong align)
> >> > > > +{
> >> > > > +       int err;
> >> > > > +       phys_addr_t addr;
> >> > > > +
> >> > > > +       err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, align, &addr, size, LMB_NONE);
> >> > > > +       if (err)
> >> > > > +               return 0;
>
> Would lmb ever allocate at (phys_addr_t)-1 ?

I think this would depend on the memory map of the platform, and the
type of allocation requested -- whether it is requesting an address,
or simply asking for a region of memory.

>
> I guess this should work for all systems as error indicator.

The API would be returning an int variable, so it would return
negative values. And the actual address allocated would be returned as
part of the 'addr' parameter -- this is similar to the interface
provided by efi_allocate_pages().

-sughosh

>
> Best regards
>
> Heinrich
>
> >> > >
> >> > >
> >> > > This tends to blow up in random ways. See
> >> > > commit 67be24906fe. TL;DR 0 is a valid address in some systems.
> >> >
> >> > Yes, I see your point. I think the calling function will have to be
> >> > re-written such that the env variables get stored only when the API
> >> > returns successfully. Then at least the platform will not have an env
> >> > variable with some junk value.
> >>
> >> Thinking about this a bit, I think in these two instances, returning a
> >> value of 0 might not be an issue if the DRAM memory does not start at
> >> 0x0. Don't get me wrong, what you are suggesting is definitely
> >> correct. I am only thinking about increasing code size on these
> >> platforms if 0x0 is not a valid address, and moreover since the
> >> platforms were already setting 0x0 in case of an error. If it is okay
> >> to increase code size on these platforms, I will change the calling
> >> function, such that the variable does not get set in case of an error.
> >> Maybe Casey and Mark can comment? Thanks.
> >
> >Systems where 0x0 is not valid memory are common enough I think, yes.
> >You can see what the size growth is by checking say j721e_evm_a72
> >before/after, and if you haven't been using buildman for size
> >comparisons already, I posted
> >https://source.denx.de/u-boot/u-boot-extras/-/blob/master/contrib/trini/u-boot-size-test.sh?ref_type=heads
> >a while back now. Thanks.
> >
>
