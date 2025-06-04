Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215C4C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 10:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FBB182AA7;
	Wed,  4 Jun 2025 12:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wMwxA0dU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEEE382B07; Wed,  4 Jun 2025 12:39:05 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1038A80AE1
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 12:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7d09d4c8543so622174885a.1
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 03:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749033542; x=1749638342; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k6Uq1hKhDEf0n1CeJie4rUDx7ol3lxGHB3aLx/kOIp8=;
 b=wMwxA0dUcSMxwC502QjRyL6oufJ44gaEzCfOCAJ3c4N3oVI+6lPBI6VWxnaRPe1Gfh
 Zwv9JBA1OXr7ZlRWnBu86K+CXPqdI6BFa5mAq8tc3oMNsdGWzL2xCBRbXjdJyx2CHbMT
 2aczZGU2Pm2/KxLPjndvjFIM2k00FqUp0wPWd1duIXwnaNy1xc6QlRefxlfm0S11p6ky
 H5EgKlcBMSWTA7pxutLO+2b2oa87WFsHpcXs4TWg/PvjdUIhB41vf3/D1gvbnM4OoW8Q
 6czlE3Wo0o3OCOuGqa+rnv+h8zr2g8mxrbdrw9555LGnI6Pqx7Nj1kFIgl2O3CB2Ya0j
 V8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749033542; x=1749638342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k6Uq1hKhDEf0n1CeJie4rUDx7ol3lxGHB3aLx/kOIp8=;
 b=WmXfETnPbRgh9Xcs2JDLs568EtQJXO0TmhMs5b+xQequhHkGYfCepILGla+2b5GkmD
 76K9PtWkn0L/bKPBHHtx2VL6wNYB1Z0wcNT0X7PYGtID4rdrtHzmG2aZx2KYHP/RpYaR
 FATtJTpe3OZvE0wLLuhS7FM9jsOAHgY7r+JmpnE+tn5UbEQVnziFaTpSdIANiaQw+IkG
 0yXhde8gq05VF36yiYwM6RBWAGOug9T07enoy/XBIqAn8aG119w3LEJ4+nXj1+TRcYh7
 4S0WTm1K/ALhV3oIn21xqLH8bJnLnmzgS1ueG2lTgkH9E6FBAFpR+3acspuWlmC9X3av
 N+OA==
X-Gm-Message-State: AOJu0YwDDf1PH2IhgI1UNWiZ9d/r4Xa9At6b/1AWlzMIjO0UTVj/hCSM
 dV1XB4M8VWFGEZnR3F6395ZaRuZkmVZileidtmSLAdOQcYONVXqR9yh+h1JX8Q4LUA3dsTGJkWg
 6A4FcT1P/NOqKSoNnIBDOuL9fttlgCe7hz0+rCi9FQQ==
X-Gm-Gg: ASbGncvBYnz7AJvzXANjfVLbtua9iMoE6DfB9guvDDcDOi1HIUISaD09Zz13r78kuOY
 uIpb96tphybumCDxisVPWjo1+0ovlbXq9oPfKeNaCXyEvylbzFxWE3+OKa0abnFfhQU1bSZQ+kc
 oWZMl5zQfgWYB15EqwWYW7vu+8fgHGSDmcvQ==
X-Google-Smtp-Source: AGHT+IEZCNn39ALvu5mT8fadcuiblOEDDPjJf9Y7fFAGH2b3qXUjfOJfydvuncNQLwYw5mCrGOlBQyyF1xiDXeGpXCI=
X-Received: by 2002:a05:620a:27d1:b0:7d0:69ff:385a with SMTP id
 af79cd13be357-7d219912e30mr336787585a.58.1749033541804; Wed, 04 Jun 2025
 03:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250526091253.400802-1-sughosh.ganu@linaro.org>
 <20250526091253.400802-3-sughosh.ganu@linaro.org>
 <CAC_iWjL+0bwPS9eXfvnFjN8UcAta+zgHz8vfDWz5YvVwoE9tsA@mail.gmail.com>
 <CADg8p96yFhzabfzZEhNzWX+kEwBuOsih0kVL+0d=ZLt=F2JNDQ@mail.gmail.com>
 <CADg8p977sXJRS1CM6Lnmep0_gc3jc9b3yFg1A-qkVn5Gswr_=Q@mail.gmail.com>
 <CAC_iWj+Mzskthf1dLSX6NPyzWiRGzfbcekCs_c_mT3GpFH6gTg@mail.gmail.com>
 <CADg8p95CnQnj2_Wh6D05hCtZh75PDU-S-_MkSvzBdGFAgKJiug@mail.gmail.com>
 <CAC_iWjK9ZQoSx8a_nmbJ-R-FUak=N+r5Vy7VPLZHFNqwnzO1Tw@mail.gmail.com>
In-Reply-To: <CAC_iWjK9ZQoSx8a_nmbJ-R-FUak=N+r5Vy7VPLZHFNqwnzO1Tw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 4 Jun 2025 16:08:50 +0530
X-Gm-Features: AX0GCFuosJPnQjVrI1B58TP0qFYNKaH7IMWy-lsumhFpbdRQ4nEGUdRPUN-wVLA
Message-ID: <CADg8p95y-CLyHC7wxSUn7md61ayn=RsDxfj9EopVoOOKqT=f0w@mail.gmail.com>
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

On Wed, 4 Jun 2025 at 12:53, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> [...]
>
> > > > > >
> > > > > >
> > > > > > This tends to blow up in random ways. See
> > > > > > commit 67be24906fe. TL;DR 0 is a valid address in some systems.
> > > > >
> > > > > Yes, I see your point. I think the calling function will have to be
> > > > > re-written such that the env variables get stored only when the API
> > > > > returns successfully. Then at least the platform will not have an env
> > > > > variable with some junk value.
> > > >
> > > > Thinking about this a bit, I think in these two instances, returning a
> > > > value of 0 might not be an issue if the DRAM memory does not start at
> > > > 0x0. Don't get me wrong, what you are suggesting is definitely
> > > > correct. I am only thinking about increasing code size on these
> > > > platforms if 0x0 is not a valid address, and moreover since the
> > > > platforms were already setting 0x0 in case of an error.
> > >
> > > what kind of code size increase are we talking about?
> >
> > Let me check the actual size impact with the changes and get back to you.
> >
> > > It's returning
> > > na int instead of a physical address so that should be close to zero?
> >
> > Sorry, I do not understand what you are suggesting, but even the above
> > static function is returning a phys_addr_t value, which is 0 in case
> > of an error. And I have kept this to mimic the existing behaviour.
> > Thanks.
>
> I am saying that changing the return type from phys_addr_t to an int
> should have a negligible size impact.

Yes, that will not have a size impact, but there would have to be a
check for whether the env variable has to be set [1], and that adds to
the size. That check might be superfluous if the address 0x0 is not
valid for the memory map of the platform. Fwiw, adding this check adds
about 256 bytes to the binary -- I can incorporate the check if an
addition of 256 bytes is fine.

-sughosh

[1] - https://gist.github.com/sughoshg/3ec45f2a8942db7bf5872efc8d373928

>
> Thanks
> /Ilias
> >
> > -sughosh
> >
> > >
> > > Thanks
> > > /Ilias
> > > > If it is okay
> > > > to increase code size on these platforms, I will change the calling
> > > > function, such that the variable does not get set in case of an error.
> > > > Maybe Casey and Mark can comment? Thanks.
> > > >
> > > > -sughosh
> > > >
> > > > >
> > > > > -sughosh
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +       return addr;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static phys_addr_t lmb_alloc_base(phys_size_t size, ulong align,
> > > > > > > +                                 phys_addr_t max_addr, u32 flags)
> > > > > > > +{
> > > > > > > +       int err;
> > > > > > > +       phys_addr_t addr;
> > > > > > > +
> > > > > > > +       addr = max_addr;
> > > > > > > +       err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, align, &addr, size, flags);
> > > > > > > +       if (err)
> > > > > > > +               return 0;
> > > > > > > +
> > > > > > > +       return addr;
> > > > > > > +}
> > > > > > > +
> > > > > > >  #define lmb_alloc_addr(addr, size, flags) lmb_reserve(addr, size, flags)
> > > > > > >
> > > > > > >  static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
> > > > > >
> > > > > > Cheers
> > > > > > /Ilias
