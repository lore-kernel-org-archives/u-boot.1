Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB72CC36019
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 11:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B4088CC9;
	Tue, 17 Sep 2024 13:47:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B69I2jM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2422188D76; Tue, 17 Sep 2024 13:47:55 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F355087AB9
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 13:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c3d20eed0bso6244757a12.0
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726573671; x=1727178471; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fo1z91PieIiKhVXB1LPw82eMWkOzJWhwNXXjEp0XIrU=;
 b=B69I2jM8tSQ+hbup99XmR9Xx/7BClWNocX/FO905r1azaINHkFMAENSUJQuezRn+pp
 TOAGlf6ho8AcDOvka/Ur0V+AbVrzFOYl0fIY38H3KS8dG0KgNWi998d2iW8dK9H3CdUM
 UuamRPysixXslqCpSo3/ngITZOzlpGVMqgKx4C25ojlQJ3M4rw2UR2WvvSUQYBzh28cv
 /iwsVPrxnvxTXLCAUJNd5VQIyV0Q3LsBfA1J8CJDy62HK3j32LDHy5ZPjsLjE7FM0ozN
 yLc00byRDXI0S0ddL536cz/zWXziwsGSqiuSs++yTe+Ny5QY9miafhAZesgeqf7jA5kA
 hYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726573671; x=1727178471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fo1z91PieIiKhVXB1LPw82eMWkOzJWhwNXXjEp0XIrU=;
 b=Ur/aYQRiAQHMiyuTR03k2v3HiZPoJVCOBg7FxgSn6hJ+oUhzTDflqMD2ukIN1t+DQu
 R+OOs/MMKdCOpwhH4pDWr6lWG1iELlE3e/cD40QhbXxBbRyuOmM6OKl8T4uNhSh2l6dv
 1rQFsB/sYSsypxi+vfDvPTpZC4VwKVbAR8FQ+WbJihB0CiXUaUa93/yZf0ohU+VRHiWl
 ZrI6xblRSFORkDMpzpgokOlu104oE5GyesHOszKGhcPn2PQt2NwA3lJn5l613BIGcN/Z
 LA5rmR2+Cqjz0/M70vYb6epjvJcM0YphT5DgzOJIszZnmNniGtRYj4AUwtnbVfRkyxli
 Ms6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfnI19cu8hbSJ/QetsVVVEyVMSqqDbEShhH15nMtPQaMDfxGzZ63DVoVdToTHMVQ8DEt8vycg=@lists.denx.de
X-Gm-Message-State: AOJu0YzZOzL+HzUh0bTrDeagS32+0Nn1u6BJgUFSutzdjxya22rhrdIT
 KeRmOuTm0oxltOm1uEa0FPP9biDhAPd7SGFPSozvsKclgFzSLgr/rcpDDniLYnvtElPqqbo+Jsd
 /V4OUXSaCeu3GTdRQ9RR51J5znwR/4e2mxC+vwQ==
X-Google-Smtp-Source: AGHT+IGWSn531yiDRXYObXgdf4e3C5Iej4LFAvsKM9iLtA4oQNqLr3WImST7xN1FazG7ogu/xp2jkB4uFgYCMOMh2D4=
X-Received: by 2002:a05:6402:1d51:b0:5c2:7740:b3bd with SMTP id
 4fb4d7f45d1cf-5c413e14eafmr16534745a12.14.1726573671293; Tue, 17 Sep 2024
 04:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-2-sughosh.ganu@linaro.org>
 <6dec397c-f7b2-4bb0-9e52-c13b97dd5025@gmx.de>
In-Reply-To: <6dec397c-f7b2-4bb0-9e52-c13b97dd5025@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 17 Sep 2024 17:17:39 +0530
Message-ID: <CADg8p95Dxc6KuwiHxkBd3rPWw8R2L_MJ2HstcQ=OkUgbGfyjJw@mail.gmail.com>
Subject: Re: [PATCH 01/16] lmb: add versions of the lmb API with flags
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
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

On Sat, 14 Sept 2024 at 20:01, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 9/5/24 10:27, Sughosh Ganu wrote:
> > The LMB module is to be used as a backend for allocating and freeing
> > up memory requested from other modules like EFI. These memory requests
> > are different from the typical LMB reservations in that memory
> > required by the EFI module cannot be overwritten, or re-requested. Add
> > versions of the LMB API functions with flags for allocating and
> > freeing up memory. The caller can then use these API's for specifying
> > the type of memory that is required. For now, these functions will be
> > used by the EFI memory module.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   include/lmb.h |  6 ++++++
> >   lib/lmb.c     | 39 ++++++++++++++++++++++++++++++++++++++-
> >   2 files changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/lmb.h b/include/lmb.h
> > index fc2daaa7bf..45a06c3b99 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -86,8 +86,13 @@ long lmb_reserve(phys_addr_t base, phys_size_t size);
> >   long lmb_reserve_flags(phys_addr_t base, phys_size_t size,
> >                      enum lmb_flags flags);
> >   phys_addr_t lmb_alloc(phys_size_t size, ulong align);
> > +phys_addr_t lmb_alloc_flags(phys_size_t size, ulong align, uint flags);
>
> Please, provide Sphinx style function descriptions for the functions
> that you are adding or changing.

Will do. Thanks.

-sughosh

>
> Cf.
> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation
>
> Best regards
>
> Heinrich
>
> >   phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
> > +phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
> > +                              phys_addr_t max_addr, uint flags);
> >   phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
> > +phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> > +                              uint flags);
> >   phys_size_t lmb_get_free_size(phys_addr_t addr);
> >
> >   /**
> > @@ -103,6 +108,7 @@ phys_size_t lmb_get_free_size(phys_addr_t addr);
> >   int lmb_is_reserved_flags(phys_addr_t addr, int flags);
> >
> >   long lmb_free(phys_addr_t base, phys_size_t size);
> > +long lmb_free_flags(phys_addr_t base, phys_size_t size, uint flags);
> >
> >   void lmb_dump_all(void);
> >   void lmb_dump_all_force(void);
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 3ed570fb29..da6a1595cc 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -479,7 +479,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
> >       return lmb_add_region(lmb_rgn_lst, base, size);
> >   }
> >
> > -long lmb_free(phys_addr_t base, phys_size_t size)
> > +static long __lmb_free(phys_addr_t base, phys_size_t size)
> >   {
> >       struct lmb_region *rgn;
> >       struct alist *lmb_rgn_lst = &lmb.used_mem;
> > @@ -530,6 +530,17 @@ long lmb_free(phys_addr_t base, phys_size_t size)
> >                                   rgn[i].flags);
> >   }
> >
> > +long lmb_free(phys_addr_t base, phys_size_t size)
> > +{
> > +     return __lmb_free(base, size);
> > +}
> > +
> > +long lmb_free_flags(phys_addr_t base, phys_size_t size,
> > +                 __always_unused uint flags)
> > +{
> > +     return __lmb_free(base, size);
> > +}
> > +
> >   long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flags flags)
> >   {
> >       struct alist *lmb_rgn_lst = &lmb.used_mem;
> > @@ -613,6 +624,12 @@ phys_addr_t lmb_alloc(phys_size_t size, ulong align)
> >       return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE);
> >   }
> >
> > +phys_addr_t lmb_alloc_flags(phys_size_t size, ulong align, uint flags)
> > +{
> > +     return __lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE,
> > +                             flags);
> > +}
> > +
> >   phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
> >   {
> >       phys_addr_t alloc;
> > @@ -626,6 +643,20 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
> >       return alloc;
> >   }
> >
> > +phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
> > +                              phys_addr_t max_addr, uint flags)
> > +{
> > +     phys_addr_t alloc;
> > +
> > +     alloc = __lmb_alloc_base(size, align, max_addr, flags);
> > +
> > +     if (alloc == 0)
> > +             printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
> > +                    (ulong)size, (ulong)max_addr);
> > +
> > +     return alloc;
> > +}
> > +
> >   static phys_addr_t __lmb_alloc_addr(phys_addr_t base, phys_size_t size,
> >                                   enum lmb_flags flags)
> >   {
> > @@ -660,6 +691,12 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
> >       return __lmb_alloc_addr(base, size, LMB_NONE);
> >   }
> >
> > +phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> > +                              uint flags)
> > +{
> > +     return __lmb_alloc_addr(base, size, flags);
> > +}
> > +
> >   /* Return number of bytes from a given address that are free */
> >   phys_size_t lmb_get_free_size(phys_addr_t addr)
> >   {
>
