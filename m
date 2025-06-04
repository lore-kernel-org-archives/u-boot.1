Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FF5C5B552
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 07:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC74882B07;
	Wed,  4 Jun 2025 09:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KqryCmnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EFBD82BD9; Wed,  4 Jun 2025 09:24:02 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AEA982103
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 09:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70f862dbeaeso65993107b3.1
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 00:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749021839; x=1749626639; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=plXigEB8XPHg7SzkYjPXa2VEaf/yqERRT6co2ayw/0s=;
 b=KqryCmnBRGFqJd0eC1OMUR1pV56IuFOFeAGwypotxsSgdjCVVBJ36H2SvMXNrFppSq
 xlXFX7t1BvgRPmZniVt9uAlTuGppjZ5yeC0P0nNs8C/aehh/Dn+YmfXnXYAvV5fEz+iF
 8Db3PtW3mFkzNnW3p3KJJOy2qhrqbIxjFG4L38N6dEbhWwpqqq2O82SeHcK+Fl7b8iwR
 9FetipwfFO0dIpshAvIKsP8XnCqtctjHBgg8qKiyndjW6DRCgUCqO9CI20TrIcqMkKtX
 Ch0VSutFVLkeAOPRWEmbFoCoy76vEsuunyTG1qRnAwctFhYbNHwCkd83a36kYeUnpoTZ
 nwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749021839; x=1749626639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=plXigEB8XPHg7SzkYjPXa2VEaf/yqERRT6co2ayw/0s=;
 b=f57IFFsx6j6OttZJ7vZi8/Mh/5sdwaeUvJa8eU8L48rHx6i/Hbnrq3KXpD4K33jWCJ
 VI77FfWXhZBRbssIMAmTmJKhCW2+7XM4TUW/n6LqyV2Xs04PJx81xwWd1fMzRD1n13u5
 w1x7rO2KvBkxp4905l4dydaCBDpwThqIYJIbVtom5rglHHTKaq+qbXnHj76O2dw8sLnq
 xZB1osSIm9i5fI7YVxD/NAfyy+SNFSg0dnQcs8yN8/zUHXJoCAsVjhGUGirjBL9OSuyR
 bKGl5JnZgU/4dWlJ7mz22xTmWbdnlPASDSya3zsynD4m+CZyNd5pK4KxnHwPGSn+V73j
 baZA==
X-Gm-Message-State: AOJu0YzFyZdia+YF/alEPKoV3gJ/sHtqzGKf9cIw40Mefdr1yjejGfMk
 lCBivcGw3DJcRDHu2cSBV5+bIhGqUgVU3wj8sAGKgNR7VRxuDQ0Mn3VtlmFeiiHuxOwyBbXHl+k
 Ttd6NHxTgtEGbIUYS7dpjujZ+ofq7WUoSPgfCpk+prA==
X-Gm-Gg: ASbGncvaLIWVndOsm2SKT0nZ9yH3r798YionXDOXmfo9d/PXt49YbezwJ36QcCCNn/8
 3M1+aBcNy4cO7C2yYcKIQqBHrbO0BBukL2S24dNFe0KVSeG9MY0RO08NZXvfvmgIaewCkG3K6t+
 t8e35ra4tAkOwTvD2dMr2XJoUlB0GYhChj9w==
X-Google-Smtp-Source: AGHT+IGWWodvE8lcvp4ZgvByC2un5Kqpyfk522JwGwNF6GC+CpYtI9rtfDqfvMUrG9lknmJxXH1QkF5FdvE+km4RjJY=
X-Received: by 2002:a05:690c:28b:b0:708:2604:4a10 with SMTP id
 00721157ae682-710d9dac0bdmr22386837b3.18.1749021838824; Wed, 04 Jun 2025
 00:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250526091253.400802-1-sughosh.ganu@linaro.org>
 <20250526091253.400802-3-sughosh.ganu@linaro.org>
 <CAC_iWjL+0bwPS9eXfvnFjN8UcAta+zgHz8vfDWz5YvVwoE9tsA@mail.gmail.com>
 <CADg8p96yFhzabfzZEhNzWX+kEwBuOsih0kVL+0d=ZLt=F2JNDQ@mail.gmail.com>
 <CADg8p977sXJRS1CM6Lnmep0_gc3jc9b3yFg1A-qkVn5Gswr_=Q@mail.gmail.com>
 <CAC_iWj+Mzskthf1dLSX6NPyzWiRGzfbcekCs_c_mT3GpFH6gTg@mail.gmail.com>
 <CADg8p95CnQnj2_Wh6D05hCtZh75PDU-S-_MkSvzBdGFAgKJiug@mail.gmail.com>
In-Reply-To: <CADg8p95CnQnj2_Wh6D05hCtZh75PDU-S-_MkSvzBdGFAgKJiug@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 4 Jun 2025 10:23:20 +0300
X-Gm-Features: AX0GCFtzEuX0Esc5nYojER7EZ9xkr0kPSQ6NhW-UokDjrt3PwBbDvP3OWsApb9c
Message-ID: <CAC_iWjK9ZQoSx8a_nmbJ-R-FUak=N+r5Vy7VPLZHFNqwnzO1Tw@mail.gmail.com>
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

[...]

> > > > >
> > > > >
> > > > > This tends to blow up in random ways. See
> > > > > commit 67be24906fe. TL;DR 0 is a valid address in some systems.
> > > >
> > > > Yes, I see your point. I think the calling function will have to be
> > > > re-written such that the env variables get stored only when the API
> > > > returns successfully. Then at least the platform will not have an env
> > > > variable with some junk value.
> > >
> > > Thinking about this a bit, I think in these two instances, returning a
> > > value of 0 might not be an issue if the DRAM memory does not start at
> > > 0x0. Don't get me wrong, what you are suggesting is definitely
> > > correct. I am only thinking about increasing code size on these
> > > platforms if 0x0 is not a valid address, and moreover since the
> > > platforms were already setting 0x0 in case of an error.
> >
> > what kind of code size increase are we talking about?
>
> Let me check the actual size impact with the changes and get back to you.
>
> > It's returning
> > na int instead of a physical address so that should be close to zero?
>
> Sorry, I do not understand what you are suggesting, but even the above
> static function is returning a phys_addr_t value, which is 0 in case
> of an error. And I have kept this to mimic the existing behaviour.
> Thanks.

I am saying that changing the return type from phys_addr_t to an int
should have a negligible size impact.

Thanks
/Ilias
>
> -sughosh
>
> >
> > Thanks
> > /Ilias
> > > If it is okay
> > > to increase code size on these platforms, I will change the calling
> > > function, such that the variable does not get set in case of an error.
> > > Maybe Casey and Mark can comment? Thanks.
> > >
> > > -sughosh
> > >
> > > >
> > > > -sughosh
> > > >
> > > > >
> > > > > > +
> > > > > > +       return addr;
> > > > > > +}
> > > > > > +
> > > > > > +static phys_addr_t lmb_alloc_base(phys_size_t size, ulong align,
> > > > > > +                                 phys_addr_t max_addr, u32 flags)
> > > > > > +{
> > > > > > +       int err;
> > > > > > +       phys_addr_t addr;
> > > > > > +
> > > > > > +       addr = max_addr;
> > > > > > +       err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, align, &addr, size, flags);
> > > > > > +       if (err)
> > > > > > +               return 0;
> > > > > > +
> > > > > > +       return addr;
> > > > > > +}
> > > > > > +
> > > > > >  #define lmb_alloc_addr(addr, size, flags) lmb_reserve(addr, size, flags)
> > > > > >
> > > > > >  static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
> > > > > > --
> > > > > > 2.34.1
> > > > > >
> > > > >
> > > > > Cheers
> > > > > /Ilias
