Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EF6C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 07:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A74B80C83;
	Tue, 10 Jun 2025 09:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DQeLbVII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D5B082AC4; Tue, 10 Jun 2025 09:18:26 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E01058070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-708d90aa8f9so48335377b3.3
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 00:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749539903; x=1750144703; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gkurHhkgoe/Htvq7tIx8EmV4MoySgkLH2P8OCC6Xx/s=;
 b=DQeLbVII0k2SPKhS/PC8/doSya6TAzLElK/lFXyb+b5XZVP2sj/C9C7PNWBrM6WyOa
 rQCtaAkOc1k1fBQXvc4UHU73YTCkThhk3Fu8yQdx7MXNvgfcEq1xGTmZCVVGhP0SS/fS
 inK8GZxJPh+WRToGpJCKgwvj54SVIUe/CE0pktSqEx49ExTL1ro7/MHzrFsi+JoCBAYy
 E57lDKAygDa8Ynl8R2dpWK3eWZ1ej1lXA2tyvjYFgM5a+4YXV0/LXEbM4C1fx3gNqB+F
 NUpaWOqCw+aNVPPQd+ogA5RCL+UqOKno0nbWBX40Sw1bimBJXGwncTPm8fhMnIL0/M+l
 InRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749539903; x=1750144703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gkurHhkgoe/Htvq7tIx8EmV4MoySgkLH2P8OCC6Xx/s=;
 b=JFYBO0YJfj635ngRqHM/e7nXTRNDCcXcraZUnq3jJRr8OSlAAcmszlsIdiz5Gzexr3
 rh7G2qVptEfFSQp12+q4vBr0S/e4Lia4MEtAzwuPwmgy5wE1TUBBZbbym6jztp2b54h/
 GXNSvnmHxNcBZnf30i+9QHA4CV6EBSC1RO10euss3S3rD3gkOmZn8mE1foNDTxMCo73L
 fwa36zHfikQYV9d6VlrvcZEX+jSUaGRlxBfnyymnem/Riweb6DS+svaTtuvDsE68addA
 nMHYUiE8e8DvyOnIU+0Q60cQCROOKGploSSRadSqCQnPovZ+91WZrH5PLcJD/SZz4ZeM
 ipyg==
X-Gm-Message-State: AOJu0YxAeG9MSzl47OiDwYE5DlD1vsx87/VdKMjG40TWYkxBxy6yR3yk
 gN0BCHrTDeKlmACWE51QW/ePlaL/HiqspwU2hNekVdmntC5/frVqdy9FX6qetb3Xq+OUcwqjwHy
 Hj9ttmWoFPol5GxZeSKMlB2EAvhpZruc9EGTnOhN8ug==
X-Gm-Gg: ASbGncu3wof3JH2FFZok+8iMLInt9fd/yPdPjHA+9VubjDRj/rwi74Nxdp2uVtocqcV
 O9BIe/LndbVUHmEzxbL5fr/C+QrVPOVtHETcrZ9rWaVOmSdqYTBeuy8tyaAwl6FrdKXqDKsZju4
 5NX1ZEkf9tUDl8do7NWgeoccypHDPg55qo45hRDfArkZPy
X-Google-Smtp-Source: AGHT+IH88F/A1ahW3hzl6HpkzhtZHLB3WCcggs8pq5m7k9PbOtAE201/XVS15KX9HmHDg9SAwKSAT90xqLIP80BU8k0=
X-Received: by 2002:a05:690c:a8e:b0:6ef:5097:5daa with SMTP id
 00721157ae682-7113675e124mr18252117b3.34.1749539902732; Tue, 10 Jun 2025
 00:18:22 -0700 (PDT)
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
 <CADg8p96Dok-xzfEYQcynr=L_t1uETGKeBqc7ahXCVWUT8yi7Kg@mail.gmail.com>
In-Reply-To: <CADg8p96Dok-xzfEYQcynr=L_t1uETGKeBqc7ahXCVWUT8yi7Kg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Jun 2025 10:17:46 +0300
X-Gm-Features: AX0GCFu0t_03eYplCYpktYhW_iAGKnmsDCwwQB0NlDpJjzM-trUUn6CffYd9oUw
Message-ID: <CAC_iWj+tS=9j+-C0h1bBMy_ssMZZn=f2XLUm0Kw=yWDiVz2aDg@mail.gmail.com>
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

Hi Sughosh

On Mon, 9 Jun 2025 at 11:30, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Wed, 4 Jun 2025 at 16:08, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Wed, 4 Jun 2025 at 12:53, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > [...]
> > >
> > > > > > > >
> > > > > > > >
> > > > > > > > This tends to blow up in random ways. See
> > > > > > > > commit 67be24906fe. TL;DR 0 is a valid address in some systems.
> > > > > > >
> > > > > > > Yes, I see your point. I think the calling function will have to be
> > > > > > > re-written such that the env variables get stored only when the API
> > > > > > > returns successfully. Then at least the platform will not have an env
> > > > > > > variable with some junk value.
> > > > > >
> > > > > > Thinking about this a bit, I think in these two instances, returning a
> > > > > > value of 0 might not be an issue if the DRAM memory does not start at
> > > > > > 0x0. Don't get me wrong, what you are suggesting is definitely
> > > > > > correct. I am only thinking about increasing code size on these
> > > > > > platforms if 0x0 is not a valid address, and moreover since the
> > > > > > platforms were already setting 0x0 in case of an error.
> > > > >
> > > > > what kind of code size increase are we talking about?
> > > >
> > > > Let me check the actual size impact with the changes and get back to you.
> > > >
> > > > > It's returning
> > > > > na int instead of a physical address so that should be close to zero?
> > > >
> > > > Sorry, I do not understand what you are suggesting, but even the above
> > > > static function is returning a phys_addr_t value, which is 0 in case
> > > > of an error. And I have kept this to mimic the existing behaviour.
> > > > Thanks.
> > >
> > > I am saying that changing the return type from phys_addr_t to an int
> > > should have a negligible size impact.
> >
> > Yes, that will not have a size impact, but there would have to be a
> > check for whether the env variable has to be set [1], and that adds to
> > the size. That check might be superfluous if the address 0x0 is not
> > valid for the memory map of the platform. Fwiw, adding this check adds
> > about 256 bytes to the binary -- I can incorporate the check if an
> > addition of 256 bytes is fine.
>
> Can we arrive at a decision on this please. If I don't get any
> response by tomorrow, I will incorporate Ilias's comment, and will put
> a check for setting the env variable. Thanks.

I think the added size is fine. The CI will warn otherwise on builds

Cheers
/Ilias
>
> -sughosh
>
> >
> > -sughosh
> >
> > [1] - https://gist.github.com/sughoshg/3ec45f2a8942db7bf5872efc8d373928
> >
> > >
> > > Thanks
> > > /Ilias
> > > >
> > > > -sughosh
> > > >
> > > > >
> > > > > Thanks
> > > > > /Ilias
> > > > > > If it is okay
> > > > > > to increase code size on these platforms, I will change the calling
> > > > > > function, such that the variable does not get set in case of an error.
> > > > > > Maybe Casey and Mark can comment? Thanks.
> > > > > >
> > > > > > -sughosh
> > > > > >
> > > > > > >
> > > > > > > -sughosh
> > > > > > >
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +       return addr;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static phys_addr_t lmb_alloc_base(phys_size_t size, ulong align,
> > > > > > > > > +                                 phys_addr_t max_addr, u32 flags)
> > > > > > > > > +{
> > > > > > > > > +       int err;
> > > > > > > > > +       phys_addr_t addr;
> > > > > > > > > +
> > > > > > > > > +       addr = max_addr;
> > > > > > > > > +       err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, align, &addr, size, flags);
> > > > > > > > > +       if (err)
> > > > > > > > > +               return 0;
> > > > > > > > > +
> > > > > > > > > +       return addr;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  #define lmb_alloc_addr(addr, size, flags) lmb_reserve(addr, size, flags)
> > > > > > > > >
> > > > > > > > >  static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
> > > > > > > > > --
> > > > > > > > > 2.34.1
> > > > > > > > >
> > > > > > > >
> > > > > > > > Cheers
> > > > > > > > /Ilias
