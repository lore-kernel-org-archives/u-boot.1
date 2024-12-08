Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF26E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 12:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85D8E894E5;
	Sun,  8 Dec 2024 13:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IC2Z10FI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 392B489510; Sun,  8 Dec 2024 13:17:43 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5A1389473
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 13:17:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6ef8028fe9fso28177527b3.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 04:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733660259; x=1734265059; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q3ov44c8wOeJPpb97+3ZcfFvlMLsT3eDnRvhov4T6UA=;
 b=IC2Z10FI2yH00E7SHMudWa5VUya6aop8jwlMHDXfPpIU25uydr9kdMHoYtSmKAF0A4
 1MR3D/d66ZDFxBUuODtLQ58jxo5yll57LZgGnI1jyOhXwM/3JN/9NBwjwZFJ3hox1KqM
 73THGrSZ6/ZEd2KE1Pz3n5rmGrkLFFd1uWrmB3C/wx4Pf4eIonGn2ywcShLGj5j+WNvg
 nxlA72jqu2xKoYMCCXNZ/+29VkrlSObcMs44hdOL6qbDhLBvmPNHZ2IvclTukIwB2hz6
 Xw5aMkURJE0y11AHm0xU04GLBJ4D67GxD75pTr6npf0+H01NnfrE9+Y3zOKlYWHuoBVn
 hOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733660259; x=1734265059;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q3ov44c8wOeJPpb97+3ZcfFvlMLsT3eDnRvhov4T6UA=;
 b=wS208TnAo7KHIqgvn3T1xND/wb0yxp8i/NuHHUVsN9c8PTX8/Yd333WyGctWQugyO1
 q3FNOPuh474UAq0PefcAmPH9nPq2NsnabLZMbvUyYFknuvd/C97WUc59MMufHVI42oLX
 HC/towMlYr7dLeAst7gWeQq74OA2iFqYnyasCfXP0OhJl9swp3k+s1jc4iWrjM1BafYt
 1vf4Up1ESW8iQwyZSD4zb7ENI7ENvLlBO1EATP0OceQ+h8xctS5bENU+60PRQ97TIws9
 92+M6THfyeSd2mZUP2eKcRBJ7a0+vIh7z4SE4PSMEdrOsXnjQrSyMW7pNZfxSNa4EeJz
 +LEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKlZcqcpNQkVevs3b3/18dc0pRlzuKr0gBITo7CZnlArCA3GdIVzA6ygbaf1my4/duZ02VUvY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/CWb6YVsTqGQTY7lx+1kl7YFZaBI9gNTI4v+1yniLJuvYr7jR
 ZmgTGPk93ZZo97+EhZg8N+wOezKFeFzp1/feLxXntSp8yaZzKIJ6NijQsqJdYNK24bXVXz312Ku
 Kz66u/wFAdUqZKUwSuCdbZEM7PAMcPy5FSr7JWA==
X-Gm-Gg: ASbGncvFCwEKtRJ0ZxXAXUfaa/vYe4SrMlwDAU+UlEUNCr5fqWJkogeDKb50QCBgU7W
 r441XbIs0Auf+yRrxOsibe0aCfBkxuBI=
X-Google-Smtp-Source: AGHT+IEJYaF4FcAowbR147UK3YRUnLkd29lHvcKeDhZARdCkX/tHdcuJ1lNjWC/g8ykOzMwO5fOupIEVz68JY+/XaUY=
X-Received: by 2002:a05:690c:7001:b0:6ef:7312:d05e with SMTP id
 00721157ae682-6efe3c0da5cmr79018737b3.19.1733660259677; Sun, 08 Dec 2024
 04:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-8-ilias.apalodimas@linaro.org>
 <14396C54-AE97-4D24-878E-16E73E9F0CA8@gmx.de>
 <CAC_iWjLiax+zU_Zb1Loi6Vh2HiepS6nPqFm1jCq3wNPMs_7PUg@mail.gmail.com>
In-Reply-To: <CAC_iWjLiax+zU_Zb1Loi6Vh2HiepS6nPqFm1jCq3wNPMs_7PUg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 8 Dec 2024 14:17:03 +0200
Message-ID: <CAC_iWjKWRe_HVowzyZ9JLufOxfS2ZXfUJn1c1u-NB_5BPHZsDA@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] lmb: Rename _lmb_alloc_addr_flags()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: trini@konsulko.com, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Nam Cao <namcao@linutronix.de>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Sun, 8 Dec 2024 at 14:12, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Heinrich
>
> On Sun, 8 Dec 2024 at 14:05, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > Am 8. Dezember 2024 11:52:10 MEZ schrieb Ilias Apalodimas <ilias.apalodimas@linaro.org>:
> > >After all the cleanups of the previous patches there's not point anymore
> > >to define lmb_alloc_addr_flags() and _lmb_alloc_addr_flags().
> > >
> > >Fix the incocistency of the flags type, which one function was
> > >definining as uintn and the other as an enum lmb_flags and rename
> > >_lmb_alloc_addr_flags() to lmb_alloc_addr_flags()
> > >
> > >Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >---
> > > include/lmb.h |  2 +-
> > > lib/lmb.c     | 34 ++++++++++++++--------------------
> > > 2 files changed, 15 insertions(+), 21 deletions(-)
> > >
> > >diff --git a/include/lmb.h b/include/lmb.h
> > >index a35a69d69f77..4f3c861b15a6 100644
> > >--- a/include/lmb.h
> > >+++ b/include/lmb.h
> > >@@ -111,7 +111,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
> > >  * Return: base address on success, 0 on error
> > >  */
> > > phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> > >-                               uint flags);
> > >+                               enum lmb_flags flags);
> >
> > This change implies that flags IS NOT a bitfield. Flags may only hold a SINGLE value from the enum.
> >
> > This looks wrong looking at the definition of the constants via BIT().
> >
> > Defining the constants of a bitfield in an enum was wrong (or at best misleading) from the beginning.
>
> Ah yes correct, I'll just leave it to uint and change the function prototype

Hmm thinking about it again. Those flags are never used as bitfield.
They are always used as discrete values. So I think we should keep it
as is

Thanks
/Ilias
>
> Thanks
> /Ilias
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > > /**
> > >  * lmb_is_reserved_flags() - test if address is in reserved region with flag bits set
> > >diff --git a/lib/lmb.c b/lib/lmb.c
> > >index c09f1a1277ad..67bde60b74be 100644
> > >--- a/lib/lmb.c
> > >+++ b/lib/lmb.c
> > >@@ -777,8 +777,20 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
> > >       return alloc;
> > > }
> > >
> > >-static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
> > >-                                  enum lmb_flags flags)
> > >+/**
> > >+ * lmb_alloc_addr_flags() - Allocate specified memory address with specified attributes
> > >+ * @base: Base Address requested
> > >+ * @size: Size of the region requested
> > >+ * @flags: Memory region attributes to be set
> > >+ *
> > >+ * Allocate a region of memory with the attributes specified through the
> > >+ * parameter. The base parameter is used to specify the base address
> > >+ * of the requested region.
> > >+ *
> > >+ * Return: base address on success, 0 on error
> > >+ */
> > >+phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> > >+                               enum lmb_flags flags)
> > > {
> > >       long rgn;
> > >       struct lmb_region *lmb_memory = lmb.available_mem.data;
> > >@@ -802,24 +814,6 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
> > >       return 0;
> > > }
> > >
> > >-/**
> > >- * lmb_alloc_addr_flags() - Allocate specified memory address with specified attributes
> > >- * @base: Base Address requested
> > >- * @size: Size of the region requested
> > >- * @flags: Memory region attributes to be set
> > >- *
> > >- * Allocate a region of memory with the attributes specified through the
> > >- * parameter. The base parameter is used to specify the base address
> > >- * of the requested region.
> > >- *
> > >- * Return: base address on success, 0 on error
> > >- */
> > >-phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> > >-                               uint flags)
> > >-{
> > >-      return _lmb_alloc_addr(base, size, flags);
> > >-}
> > >-
> > > /* Return number of bytes from a given address that are free */
> > > phys_size_t lmb_get_free_size(phys_addr_t addr)
> > > {
> >
