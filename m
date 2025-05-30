Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA585C5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 10:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB89C83291;
	Fri, 30 May 2025 12:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VeQUSg5M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 871208329C; Fri, 30 May 2025 12:11:58 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C96182BAF
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 12:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-476a720e806so16559981cf.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 03:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748599915; x=1749204715; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MsJuMSHGrjuQw2gkM2QTVCNVGQwhNU1xph6vQfAGxms=;
 b=VeQUSg5Mrp6oQDI00j1RzEB4S3XN1fuHju+qDokcqm91U37JcJxGwxllqxAiZX6y+l
 8BTMJE9xxhQ9QLRgsqryfwSElV0FYpJldRWG7P3YBCEysD8oaBvQIScF/pQ5gyV1vJM4
 7slT8xQKzKffnwLe68eJCuTtzD55V9BTWxOjCp+KMcIC4YG6zo53QK0EbqsvpfBUwCXR
 gf82d7dHSKRl0OHaWxjfB5nxPgfjbqzxDdzxt5Rq0F40iQfAP+9sh+CFkM2BaM2q5MJL
 OKRFZ2N7VEi9Ti49tsfUSohqfb/xWGHOHLHdYV05N2o6fSlgTHgVE54tV/kLGi2hzgRi
 CKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748599915; x=1749204715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MsJuMSHGrjuQw2gkM2QTVCNVGQwhNU1xph6vQfAGxms=;
 b=MqaLkKiPiXXyYVczujuhza/xksI/58kzWgs8ROiLVQPj7jV5uLdF9pptcr5r4z9vrP
 TMdXacKBf2+IsnNakcB1kpUrjmKD67nbvUkIwbxzi3ziEov8BWQpqrCDFL9g/YR33CUZ
 Nmy6vXgju/LjfNWWP+YyAplHVgHwQsK+wzLX4hyc6IRedVRemLoDrSeYvj6nb3RxHlkD
 NbD9AOyz2LkuaMdkiNtfiMdg65tUVIy6DItB/IZ6L9wP9wd6jaztOXwzvWLSt+ydNOm0
 MOBA+T4ynnH1nwmKqimj50NkKo0c8Gfcrma20+iTQQ1G/8SoNHU5XsWgj/j+4Drc2Tcp
 gEAQ==
X-Gm-Message-State: AOJu0Yz1B1UgAlgmQaMCKFwyACtchVKxjwKvkRUgSwHgkCN0Pu8NIJR8
 16udsf41i+F315jemD3WwblxGNt5JthkUaZ7IPqD72IV8qR7cGGxAJldMmkM3CvDK+jmxA5W8N2
 FD0RTj0NhytKOHIky6TLeih1UjSJRqAwDKiUqFMx7RQ==
X-Gm-Gg: ASbGncsaw7U+IZNDhUhIHLKRfpEnmrMa4fG1XsC7DwtUqKJAJP3ddNmlNv+Pn0UusLN
 pZV7vFY0WFf6kLfs7jH76O7wO5/65CYcbYiYryEJ+Foh7RlCGOxoY5tZGdp1gC09HEc1z/OFA+x
 w7o7XRHoTh5w5s7DVK8c7Rc+6JOt34QgBKVeEtMw178SdP
X-Google-Smtp-Source: AGHT+IGx4wqsm8mKzF3Z7p4Gahg09gZS6/iSiZeOgoqUzcrSSQyV5sqImjUn8aSUOP2yXR2o1G2GqUuJW9XEaJPNcec=
X-Received: by 2002:a05:622a:540a:b0:494:f705:3ba7 with SMTP id
 d75a77b69052e-4a4400b7f5cmr47429411cf.44.1748599915158; Fri, 30 May 2025
 03:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250526091253.400802-1-sughosh.ganu@linaro.org>
 <20250526091253.400802-3-sughosh.ganu@linaro.org>
 <CAC_iWjL+0bwPS9eXfvnFjN8UcAta+zgHz8vfDWz5YvVwoE9tsA@mail.gmail.com>
In-Reply-To: <CAC_iWjL+0bwPS9eXfvnFjN8UcAta+zgHz8vfDWz5YvVwoE9tsA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 30 May 2025 15:41:44 +0530
X-Gm-Features: AX0GCFtxJTkXKJI2U5TxSB7yELYELbGjzBBOOpT9WYtbImmNNB2dfgLdK7BjZHk
Message-ID: <CADg8p96yFhzabfzZEhNzWX+kEwBuOsih0kVL+0d=ZLt=F2JNDQ@mail.gmail.com>
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

On Fri, 30 May 2025 at 13:17, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> > +static phys_addr_t lmb_alloc(phys_size_t size)
> > +{
> > +       int ret;
> > +       phys_addr_t addr;
> > +
> > +       /* All memory regions allocated with a 2MiB alignment */
> > +       ret = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr, size, LMB_NONE);
> > +       if (ret)
> > +               return 0;
> > +
> > +       return addr;
> > +}
> > +
>
> I think we  need a better naming for these. Right now we have
> lmb_alloc() here and in tests, addr_alloc() in snapdragon code.
> I'd say either export them as API if you think they would be useful,
> or get rid of the wrappers.

I kept these functions as is to reduce the amount of change resulting
from introducing the API. Also, the newly introduced API has
parameters which are common across all the callers, which also was why
I kept a wrapper. This is especially true in the tests, where it would
be required to change the function names in a bunch of places without
much benefit.

>
> [...]
>
> > +static phys_addr_t lmb_alloc(phys_size_t size, ulong align)
> > +{
> > +       int err;
> > +       phys_addr_t addr;
> > +
> > +       err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, align, &addr, size, LMB_NONE);
> > +       if (err)
> > +               return 0;
>
>
> This tends to blow up in random ways. See
> commit 67be24906fe. TL;DR 0 is a valid address in some systems.

Yes, I see your point. I think the calling function will have to be
re-written such that the env variables get stored only when the API
returns successfully. Then at least the platform will not have an env
variable with some junk value.

-sughosh

>
> > +
> > +       return addr;
> > +}
> > +
> > +static phys_addr_t lmb_alloc_base(phys_size_t size, ulong align,
> > +                                 phys_addr_t max_addr, u32 flags)
> > +{
> > +       int err;
> > +       phys_addr_t addr;
> > +
> > +       addr = max_addr;
> > +       err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, align, &addr, size, flags);
> > +       if (err)
> > +               return 0;
> > +
> > +       return addr;
> > +}
> > +
> >  #define lmb_alloc_addr(addr, size, flags) lmb_reserve(addr, size, flags)
> >
> >  static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
> > --
> > 2.34.1
> >
>
> Cheers
> /Ilias
