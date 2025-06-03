Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D6FC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 18:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9495E828BC;
	Tue,  3 Jun 2025 20:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IQYk3xz+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF306829B2; Tue,  3 Jun 2025 20:26:44 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4157E8283E
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 20:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70df67e1b17so56167987b3.1
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748975201; x=1749580001; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3Ao6HOumNJXO7qXDzPFRd+rMh1TpCKR2dualsltcL14=;
 b=IQYk3xz+9yBp3M+E9qu6/ZG3NXL+zQ9sUQLdPx3hQF6fwGHCDDJrV8xXbbvv/amtEl
 mC+SBu1iY2OVOo47P3XIc3dlqazQNN1MAY+7F5un/yAcK+Yfzw4INy7Mv9Ogkn+kN7ZX
 grnGzsZwjNliXbCOpE/NozPXJ/5obACIX7SMtkvm2NtSQOw/czujWBvmre0m58j9SAxF
 L76Kb8CxlX+ewQILZiOieMUBgKLKbC0D/H6ZVOyIqp02UQYPsY3s1Zero86QH8brnShx
 mQySDbe+OVy8E4gW2V2x03WjqorKk0mg47KCZObsb3RqYfAd1XyJ/81rQjknR5YKDoVQ
 a26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748975201; x=1749580001;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Ao6HOumNJXO7qXDzPFRd+rMh1TpCKR2dualsltcL14=;
 b=t5rNeMrgZXS+KaBc6+dilEKedMXudpTtGuPBOq6mO2Sg3PSETGHQuqt4MMceciSVIX
 8u+3ySfJGaTb0wrs2MUNOyUvvLGdT46EZ09qjl1MxxfiXejQGSMHa1AnpT2GXBUgyZFw
 NYSZHn1QW776Gd7JgJVKeHm721JiUjd0KVl89dxw2F6hdJAoMsVMsyl3l4XKl3qHrCAB
 IE7nB66R4gCUnuCN5yZndyABWMlPxS3vgvpJx9I1SY5Uwzoel8BV/3vjMhzB2HMfF2EM
 UI8KCERPTSDJ9OvjCHexijTniNoQky2PUdN0LRRBQCI3CLiQ2UgDNdLtRBoKoUrs2whF
 ZZJA==
X-Gm-Message-State: AOJu0YwYdf/2+UzxjHkn0PPFksd6dkWZP4XDGzdWu2XId4PZFcFKg5/A
 DuBRMuCkQR4aQlRD+NtsUjrapL2Ypz0LkVIJ9oO+PMDDSMkTI4w8nfQYmgAbTs+BzXARSy/mGiL
 oDiKwJoweBKV6rQynKfULe1j9/LBMIDfmHDUXXXP/8w==
X-Gm-Gg: ASbGncthk7HjBclhRE56oe9gVmPSn3eT9j9CHwJYmDLGVeveCAuC9OlClVj98UZvNq0
 s49KM7R4K47sf8H3+DapS4Fa/CseDIw0K/KPbpjsuzUO2DWIC2e588hqeY00ZR51jufeQJHZSEx
 yWUDm1BOmGsrMUCMQutcX95qme153LBn77amcgPWGSTmKR
X-Google-Smtp-Source: AGHT+IEDEO6Fewx3ht7jpxogn/6eFsoGb3/1F2h7Tt8CiOncAHcVNc72ZkmjAZqjPnT9SkakAeo1oj1hHQsgHi4e3Jk=
X-Received: by 2002:a05:690c:c94:b0:70e:128c:3019 with SMTP id
 00721157ae682-71097e138f9mr193433607b3.31.1748975200935; Tue, 03 Jun 2025
 11:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250526091253.400802-1-sughosh.ganu@linaro.org>
 <20250526091253.400802-3-sughosh.ganu@linaro.org>
 <CAC_iWjL+0bwPS9eXfvnFjN8UcAta+zgHz8vfDWz5YvVwoE9tsA@mail.gmail.com>
 <CADg8p96yFhzabfzZEhNzWX+kEwBuOsih0kVL+0d=ZLt=F2JNDQ@mail.gmail.com>
 <CADg8p977sXJRS1CM6Lnmep0_gc3jc9b3yFg1A-qkVn5Gswr_=Q@mail.gmail.com>
In-Reply-To: <CADg8p977sXJRS1CM6Lnmep0_gc3jc9b3yFg1A-qkVn5Gswr_=Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 3 Jun 2025 21:26:04 +0300
X-Gm-Features: AX0GCFvTNf74BMXDboah31jbbQ_5vU8yLsTV8V-OvLunauKYlg-5lt0dimGmXEc
Message-ID: <CAC_iWj+Mzskthf1dLSX6NPyzWiRGzfbcekCs_c_mT3GpFH6gTg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] lmb: replace the lmb_alloc() and lmb_alloc_base()
 API's
To: Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Tue, 3 Jun 2025 at 09:44, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 30 May 2025 at 15:41, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Fri, 30 May 2025 at 13:17, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > > +static phys_addr_t lmb_alloc(phys_size_t size)
> > > > +{
> > > > +       int ret;
> > > > +       phys_addr_t addr;
> > > > +
> > > > +       /* All memory regions allocated with a 2MiB alignment */
> > > > +       ret = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr, size, LMB_NONE);
> > > > +       if (ret)
> > > > +               return 0;
> > > > +
> > > > +       return addr;
> > > > +}
> > > > +
> > >
> > > I think we  need a better naming for these. Right now we have
> > > lmb_alloc() here and in tests, addr_alloc() in snapdragon code.
> > > I'd say either export them as API if you think they would be useful,
> > > or get rid of the wrappers.
> >
> > I kept these functions as is to reduce the amount of change resulting
> > from introducing the API. Also, the newly introduced API has
> > parameters which are common across all the callers, which also was why
> > I kept a wrapper. This is especially true in the tests, where it would
> > be required to change the function names in a bunch of places without
> > much benefit.
> >
> > >
> > > [...]
> > >
> > > > +static phys_addr_t lmb_alloc(phys_size_t size, ulong align)
> > > > +{
> > > > +       int err;
> > > > +       phys_addr_t addr;
> > > > +
> > > > +       err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, align, &addr, size, LMB_NONE);
> > > > +       if (err)
> > > > +               return 0;
> > >
> > >
> > > This tends to blow up in random ways. See
> > > commit 67be24906fe. TL;DR 0 is a valid address in some systems.
> >
> > Yes, I see your point. I think the calling function will have to be
> > re-written such that the env variables get stored only when the API
> > returns successfully. Then at least the platform will not have an env
> > variable with some junk value.
>
> Thinking about this a bit, I think in these two instances, returning a
> value of 0 might not be an issue if the DRAM memory does not start at
> 0x0. Don't get me wrong, what you are suggesting is definitely
> correct. I am only thinking about increasing code size on these
> platforms if 0x0 is not a valid address, and moreover since the
> platforms were already setting 0x0 in case of an error.

what kind of code size increase are we talking about? It's returning
na int instead of a physical address so that should be close to zero?

Thanks
/Ilias
> If it is okay
> to increase code size on these platforms, I will change the calling
> function, such that the variable does not get set in case of an error.
> Maybe Casey and Mark can comment? Thanks.
>
> -sughosh
>
> >
> > -sughosh
> >
> > >
> > > > +
> > > > +       return addr;
> > > > +}
> > > > +
> > > > +static phys_addr_t lmb_alloc_base(phys_size_t size, ulong align,
> > > > +                                 phys_addr_t max_addr, u32 flags)
> > > > +{
> > > > +       int err;
> > > > +       phys_addr_t addr;
> > > > +
> > > > +       addr = max_addr;
> > > > +       err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, align, &addr, size, flags);
> > > > +       if (err)
> > > > +               return 0;
> > > > +
> > > > +       return addr;
> > > > +}
> > > > +
> > > >  #define lmb_alloc_addr(addr, size, flags) lmb_reserve(addr, size, flags)
> > > >
> > > >  static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > Cheers
> > > /Ilias
