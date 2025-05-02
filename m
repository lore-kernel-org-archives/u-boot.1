Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738B5C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 13:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3463810EB;
	Fri,  2 May 2025 15:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="trf8c9l6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B644A820EB; Fri,  2 May 2025 15:42:28 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6DCB80F03
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 15:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e733a6ff491so1925882276.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746193344; x=1746798144; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T6QPQMdxAKVzJ6aREwaKWgvOLjbl+MUjTlQnv5Qp/Fs=;
 b=trf8c9l6cRbmYpo0pfFmkRQq0TQiUwkGaGEHB1LPc/aqDerKmLqZCte0NyJETP0SPO
 YdKbXEeTUBisUlrogsDQUfv3ktLlmLUdAyG8F7gk0I8g/L3aPvr7R+hRfvZKRjVGOVgu
 PY3WUdcvJHBMKjjgtHRspjpTVsJg7h9kj9s0otHBUNqR3njlOFyaG99ZCJIfBPasXXm9
 0Q98s6oIW1055pr/VakpgkjuSuh4vqbaHUSsiU4D/BZMVVIhJCIE6rjDLpJM4UWnZDQu
 08m7mgDwcPV3KL2SVleI/QaeEJjTzxZme0Dz3uf8BrgpTpVTZz9YD4E8ptdxndWS30lN
 cSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746193344; x=1746798144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T6QPQMdxAKVzJ6aREwaKWgvOLjbl+MUjTlQnv5Qp/Fs=;
 b=WW7OuSweDfSSfGrM3YLOM1w33Xe5IszDBdeECKfpV48yLTSf2Rvc3IoeCJ+H+B6s55
 Znh/Cj68TeyXaOPJ2I9iuiC55GjwueHVvE9emLiHOtxvVVUB54jvtWWl9hZRWC8bBIb+
 vAlDt1leGBqrSBbJvn/fuyKoK/YwZxEzC9p4FWAXtlU1BEAg8dEfJBnfxuH/rOrM2ip/
 kFiHGhZfj73LpDk9xQI0O3Az7kf5XvNaCH+FNs6BcXAJzNENVBbfbeZnm77aDhDXH4JT
 rf2VUfkrc8bd1ttFowIecf22cDqgu+YEC6vVV13lv3/0cMnSsAItp8uiGlUpFB7gRy8R
 Mo/g==
X-Gm-Message-State: AOJu0YwZ31qIcnEgbXFcc8v/g04a3+mGmf3X0BCJbrS37OMP4Q6RTGNI
 3wUxEBrWE7kSaFbK2YkAyk07YjGsnDuKQpFwB7tfwLi39AV3SAlxEepOaNMa1pKTJHhTHyvDc/1
 7SDcF0SCJwXOELN4qJ770qJAU21+l8fT0rE9M0g==
X-Gm-Gg: ASbGncvfHGznklgTRH9f/Pn5XjnHu5VAf1iL5lnfofZMc3UdgDHFguqHBHSi6ZpNj2I
 B6+opL8QtwknkY7eW2tRpp/z/nrUb+bfF5wvPcjQs7kBtq3VyvYiug11Q+Z6nxlVa7HkduWUAnT
 GViHlcVb936J+7GIS2OYBrk3k=
X-Google-Smtp-Source: AGHT+IFglGU6QGNTydRBnd0I95OCiGnzt7kg+r7/+WRm4MmsJi2EF7jWFptQtYm2iXWEQuob2jLT9vdY9sPi9e3FpD8=
X-Received: by 2002:a05:6902:274a:b0:e75:607f:5fd2 with SMTP id
 3f1490d57ef6-e756565e319mr4055406276.48.1746193344620; Fri, 02 May 2025
 06:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250501120239.199829-1-sughosh.ganu@linaro.org>
 <20250501120239.199829-3-sughosh.ganu@linaro.org>
 <D9LI7HGHRKRX.3NLD3DXDAG4@linaro.org>
 <CADg8p97qR=p4fZ+Gy8D5zqCHyNh_aSPJS6k9k-OCuWJHnttTwA@mail.gmail.com>
In-Reply-To: <CADg8p97qR=p4fZ+Gy8D5zqCHyNh_aSPJS6k9k-OCuWJHnttTwA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 2 May 2025 16:41:47 +0300
X-Gm-Features: ATxdqUE5Y7ygdDOqHqXbwCDGmzUpA8KR1wWiLANNYirhAtDWnXEh9CgkLnic1Bg
Message-ID: <CAC_iWj+8ujQXrNC2YC56coL_EfeXx_9hPRT2NhwKgXrjP5_ppw@mail.gmail.com>
Subject: Re: [PATCH 2/5] lmb: replace the lmb_alloc() and lmb_alloc_base()
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

[...]

> > > -                                     (ulong)lmb_alloc_base(rd_len,
> > > -                                                                 0x1000,
> > > -                                                                 initrd_high,
> > > -                                                                 LMB_NONE);
> > > +                             err = lmb_allocate_mem(LMB_MEM_ALLOC_MAX,
> > > +                                                    0x1000, &initrd_high,
> > > +                                                    rd_len, LMB_NONE);
> > >                       else
> > > -                             *initrd_start = (ulong)lmb_alloc(rd_len,
> > > -                                                              0x1000);
> > > +                             err = lmb_allocate_mem(LMB_MEM_ALLOC_ANY,
> > > +                                                    0x1000, &initrd_high,
> > > +                                                    rd_len, LMB_NONE);
> >
> > You are now calling the same function, put LMB_MEM_ALLOC_ANY/LMB_MEM_ALLOC_MAX in a variable instead
> > and make the if smaller
>
> Will do.
>
> >
> > [...]
> >
> > > diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> > > index 6585813de00..b8e1b0f35bb 100644
> > > --- a/boot/image-fdt.c
> > > +++ b/boot/image-fdt.c
> > > @@ -198,15 +198,27 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
> > >                       of_start = (void *)(uintptr_t)addr;
> > >                       disable_relocation = 1;
> > >               } else if (desired_addr) {
> > > -                     addr = lmb_alloc_base(of_len, 0x1000, desired_addr,
> > > -                                           LMB_NONE);
> > > +                     addr = desired_addr;
> > > +                     err = lmb_allocate_mem(LMB_MEM_ALLOC_MAX, 0x1000, &addr,
> >
> > Is this LMB_MEM_ALLOC_MAX or LMB_MEM_ALLOC_ADDR?
>
> This is a case for LMB_MEM_ALLOC_MAX as the desired_addr variable that
> is read as fdt_high has a valid value. So the allocated address should
> be below desired_addr.

Ah you are right, I misread lmb_alloc_base() for lmb_alloc_addr().
But in that case, can you rename 'desired_addr' as well to something
that makes more sense -- e.g high_addr or something like that.

[...]

Thanks
/Ilias
