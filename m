Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE5DC61DB2
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAE6082A65;
	Mon,  9 Jun 2025 10:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YTYuuT09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74F8782B07; Mon,  9 Jun 2025 10:30:31 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE8B882A36
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4a4312b4849so50122931cf.1
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 01:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749457827; x=1750062627; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bml/OffESHrlZuoGt+xRCeEaRwYGBtCArhIBHvoYaOw=;
 b=YTYuuT09vEKzDB+Nqc+7PnZZAwWYW2GcaXGBcxj3wdQrygnCGVbuJOAt7QOyVSgrTz
 NnWoW6avs9UgrBWDO4e/hHEwXVu4t/l4RwQxW49SzarUqIagcgaaV3d96Nuvj+G83RXs
 k1vz1bAbpnNdLoCdCgPck6p+RTWIC3Ydfuq89o69sGSMCc9bBUvFjgemKA03otgHJHBW
 Q5kxrTir+eKG3UlrI053lfJVU80EolntswZ9H64q2ZX7XQvbSa6Aj2yWRi/nu3N02xLm
 vf7ZDRTt0qhSk1CK5bjEu6L0NjC56hfrkYNWY779Tm6szzNNCllEAQQ2CogxXxS4jZTU
 stLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749457827; x=1750062627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bml/OffESHrlZuoGt+xRCeEaRwYGBtCArhIBHvoYaOw=;
 b=ZzH/1VKz0/97aOAIYbEzCTa3fZt5XKwi/1bxhCYnLA1F8WwbsDMfBNWezba8dA3IAF
 SuKTvswWXJXxXDbcAa0XBdCjYPs60ONN2IGYfSdS40sMlRXkphcsR6Fsh3KFhTY+WLjV
 HVpAoWD8mPZgyCJhHvMqEnrAFO0JhtmD0FUhHYNEiVU6X1csgmMt7K9PryiH9q7xcluv
 2W5tFXhJGTy+xGTzJqqo857BpJOLSI5jN/KF56rtjCBEi7ifUa3zP5hXoQuwP61U7j3A
 O86xU6rXFrAqkTh5DrwUTuTyjx52P5Grt3TgP0z/CNaXYDmMDAU2TeJP9MWL+Of6w8Ft
 u/Gw==
X-Gm-Message-State: AOJu0Yyoy8l8ikxUnKHGsAsblV0vN6cByFK1IhTCp4XnhgmcoBn+t1L2
 SyW+Jun5fBDt++mJY8VWaDiXCMCQnGQBdeohHEg6EGgmyZ+G7dsI/LOFYOEu1cAuJdGAPlHiGwo
 k/1rIzwL2vLIXHIJgZsmCJFTttlOmF0gQDPHY5lXuKA==
X-Gm-Gg: ASbGncv5W5hUnSnLYQZVS9oNaFexlJhO6nyxglFBz9ZjapC5u+t4blTkTMSAsraAKQ+
 lV7sO5aqrV3cQMWyLpZsU2eCXaL1TlQd1mZGQQRLX2oJ4AV4FTErgzkJsyjiUfzcBBZ3Ypg0cc7
 FyrdeiVDw5i4ZV5vOEwGO+85CUwHh9kvN1hAk+hQ2EQSEt
X-Google-Smtp-Source: AGHT+IGieVz2CSzWEgpAyq3tBzBUYvtOLns4auYlwEj9a4CtvKzOZaI/ULJZJUyHNBViq5Yrb0Nb8D7oW6KSi7+g4gI=
X-Received: by 2002:ad4:5c81:0:b0:6fa:9d4b:fa10 with SMTP id
 6a1803df08f44-6fb08eeef5emr211550826d6.0.1749457827544; Mon, 09 Jun 2025
 01:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250526091253.400802-1-sughosh.ganu@linaro.org>
 <20250526091253.400802-3-sughosh.ganu@linaro.org>
 <CAC_iWjL+0bwPS9eXfvnFjN8UcAta+zgHz8vfDWz5YvVwoE9tsA@mail.gmail.com>
 <CADg8p96yFhzabfzZEhNzWX+kEwBuOsih0kVL+0d=ZLt=F2JNDQ@mail.gmail.com>
 <CADg8p977sXJRS1CM6Lnmep0_gc3jc9b3yFg1A-qkVn5Gswr_=Q@mail.gmail.com>
 <CAC_iWj+Mzskthf1dLSX6NPyzWiRGzfbcekCs_c_mT3GpFH6gTg@mail.gmail.com>
 <CADg8p95CnQnj2_Wh6D05hCtZh75PDU-S-_MkSvzBdGFAgKJiug@mail.gmail.com>
 <CAC_iWjK9ZQoSx8a_nmbJ-R-FUak=N+r5Vy7VPLZHFNqwnzO1Tw@mail.gmail.com>
 <CADg8p95y-CLyHC7wxSUn7md61ayn=RsDxfj9EopVoOOKqT=f0w@mail.gmail.com>
In-Reply-To: <CADg8p95y-CLyHC7wxSUn7md61ayn=RsDxfj9EopVoOOKqT=f0w@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 9 Jun 2025 14:00:16 +0530
X-Gm-Features: AX0GCFtmCf8zC0gLOgjttkPU5UheWIoWlyzzJ5AxaCdQx305ZjRDOfZQhF8MKlI
Message-ID: <CADg8p96Dok-xzfEYQcynr=L_t1uETGKeBqc7ahXCVWUT8yi7Kg@mail.gmail.com>
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

On Wed, 4 Jun 2025 at 16:08, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Wed, 4 Jun 2025 at 12:53, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > [...]
> >
> > > > > > >
> > > > > > >
> > > > > > > This tends to blow up in random ways. See
> > > > > > > commit 67be24906fe. TL;DR 0 is a valid address in some systems.
> > > > > >
> > > > > > Yes, I see your point. I think the calling function will have to be
> > > > > > re-written such that the env variables get stored only when the API
> > > > > > returns successfully. Then at least the platform will not have an env
> > > > > > variable with some junk value.
> > > > >
> > > > > Thinking about this a bit, I think in these two instances, returning a
> > > > > value of 0 might not be an issue if the DRAM memory does not start at
> > > > > 0x0. Don't get me wrong, what you are suggesting is definitely
> > > > > correct. I am only thinking about increasing code size on these
> > > > > platforms if 0x0 is not a valid address, and moreover since the
> > > > > platforms were already setting 0x0 in case of an error.
> > > >
> > > > what kind of code size increase are we talking about?
> > >
> > > Let me check the actual size impact with the changes and get back to you.
> > >
> > > > It's returning
> > > > na int instead of a physical address so that should be close to zero?
> > >
> > > Sorry, I do not understand what you are suggesting, but even the above
> > > static function is returning a phys_addr_t value, which is 0 in case
> > > of an error. And I have kept this to mimic the existing behaviour.
> > > Thanks.
> >
> > I am saying that changing the return type from phys_addr_t to an int
> > should have a negligible size impact.
>
> Yes, that will not have a size impact, but there would have to be a
> check for whether the env variable has to be set [1], and that adds to
> the size. That check might be superfluous if the address 0x0 is not
> valid for the memory map of the platform. Fwiw, adding this check adds
> about 256 bytes to the binary -- I can incorporate the check if an
> addition of 256 bytes is fine.

Can we arrive at a decision on this please. If I don't get any
response by tomorrow, I will incorporate Ilias's comment, and will put
a check for setting the env variable. Thanks.

-sughosh

>
> -sughosh
>
> [1] - https://gist.github.com/sughoshg/3ec45f2a8942db7bf5872efc8d373928
>
> >
> > Thanks
> > /Ilias
> > >
> > > -sughosh
> > >
> > > >
> > > > Thanks
> > > > /Ilias
> > > > > If it is okay
> > > > > to increase code size on these platforms, I will change the calling
> > > > > function, such that the variable does not get set in case of an error.
> > > > > Maybe Casey and Mark can comment? Thanks.
> > > > >
> > > > > -sughosh
> > > > >
> > > > > >
> > > > > > -sughosh
> > > > > >
> > > > > > >
> > > > > > > > +
> > > > > > > > +       return addr;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static phys_addr_t lmb_alloc_base(phys_size_t size, ulong align,
> > > > > > > > +                                 phys_addr_t max_addr, u32 flags)
> > > > > > > > +{
> > > > > > > > +       int err;
> > > > > > > > +       phys_addr_t addr;
> > > > > > > > +
> > > > > > > > +       addr = max_addr;
> > > > > > > > +       err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, align, &addr, size, flags);
> > > > > > > > +       if (err)
> > > > > > > > +               return 0;
> > > > > > > > +
> > > > > > > > +       return addr;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  #define lmb_alloc_addr(addr, size, flags) lmb_reserve(addr, size, flags)
> > > > > > > >
> > > > > > > >  static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
> > > > > > > > --
> > > > > > > > 2.34.1
> > > > > > > >
> > > > > > >
> > > > > > > Cheers
> > > > > > > /Ilias
