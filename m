Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70711E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 12:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C251A894E5;
	Sun,  8 Dec 2024 13:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LpdSJvYp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B2689515; Sun,  8 Dec 2024 13:12:43 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 364F389473
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 13:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6eeca49d8baso26375307b3.0
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 04:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733659960; x=1734264760; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QKeJZVtWY8bnjrAzSPMWsTc1a7HGSu4ZvGjLvKZrOXM=;
 b=LpdSJvYp7RpQiEoWknBVeJVoue5hOIh97f2IOwD7g0h9NvZ8E9W/sr+Rsdw9uu3i+p
 x2+jrXuMMOJIMilf/gjpnc3uJ1yQ41nX9F6ghbMcXXTqcHc7BDLPxQWnjSoL3uzzkpng
 gWU7yKpTaFF5xUlxNzdVfLZsxIk+pugxJpEWwHznlcfYIQluZKm6O+DjgMT0zf4/pcb9
 3O59gJRMgCvHZbpuiwzut5+CsdEhnHP/uzBibT0ZpPd5WOCCZDAWiU6J3Tix0m1ZSQba
 bKGLv/Nrmlj50C2BYB7xLxqE6GlYL4P8Q3KylNGgQUcWCrcodpttuhF+IV9TDHMQgWCa
 049g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733659960; x=1734264760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QKeJZVtWY8bnjrAzSPMWsTc1a7HGSu4ZvGjLvKZrOXM=;
 b=pUT85oMxPiegaZ0ryqLDXJOgDm/pxJo5CjjeEcgqZhc8QViuEOrym/wP6UB6UD5MsB
 FPU7yqQpxH8yaGTHjQubXpVNjUjlQq+8yjPriYwjfaEjiIOxKWotLN4FbRtTFgy9Mpv9
 eirI2fQM8R++iSyR5CRPk15JCc5YDHH1xhgE93FvdJVK9KOCf83F12JH9apJ8GBLTDaB
 OlJoLcfYd+NhHZDVICw3CCowohHY8E9pDoy/aXdpOTBqqw4ts6avgCItlFw4i/1b9dJq
 oGB9LKwu1a0/Mpljc/wKkwPUy6lbOFdTxOV7iIdg3sl3d4vqHIj8iegOexHzbjzYQyGB
 ou4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK1X+clE0n+WEg9OoH9ewqqNz+EF0dVoZM6NOSrBuLQduMhIFJp7l1hqrV2qJ7Taqq5I/PdrQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5m2hvHEO4UWZtbK6t5r9gqOdBiURKOnY6e7g0PJGnNH1vjVnn
 xX1+T9aEvpkV4O8UrYx+36kQxeQCj4bVharPr3vc622gjJdQ9ubGfwFbVtvLZ0Zae9McU5o749m
 tIw3WrYfkITz9jlptide/pYOufllRcz0Z4QGnqg==
X-Gm-Gg: ASbGnctjb4ZzhLoEOVQ4MUoMNYlbXW93Jsk1btDTpnHlU1GywXqDwdyEF472kwL04mT
 va8eorSmJR86X3qOW+Fd+dzdcoxGDsM0=
X-Google-Smtp-Source: AGHT+IFTxEwjbK2EGF2zOJ4KfPOuZgPlNyzQDmmRUYyR9OEwEQ4mCuIkbwXdo0219R5ceNh6vUlbBn0EsDR/APkzPxA=
X-Received: by 2002:a05:690c:700f:b0:6ee:8088:831d with SMTP id
 00721157ae682-6efd03d7d60mr122208577b3.3.1733659959554; Sun, 08 Dec 2024
 04:12:39 -0800 (PST)
MIME-Version: 1.0
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-8-ilias.apalodimas@linaro.org>
 <14396C54-AE97-4D24-878E-16E73E9F0CA8@gmx.de>
In-Reply-To: <14396C54-AE97-4D24-878E-16E73E9F0CA8@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 8 Dec 2024 14:12:03 +0200
Message-ID: <CAC_iWjLiax+zU_Zb1Loi6Vh2HiepS6nPqFm1jCq3wNPMs_7PUg@mail.gmail.com>
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

Hi Heinrich

On Sun, 8 Dec 2024 at 14:05, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 8. Dezember 2024 11:52:10 MEZ schrieb Ilias Apalodimas <ilias.apalodimas@linaro.org>:
> >After all the cleanups of the previous patches there's not point anymore
> >to define lmb_alloc_addr_flags() and _lmb_alloc_addr_flags().
> >
> >Fix the incocistency of the flags type, which one function was
> >definining as uintn and the other as an enum lmb_flags and rename
> >_lmb_alloc_addr_flags() to lmb_alloc_addr_flags()
> >
> >Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >---
> > include/lmb.h |  2 +-
> > lib/lmb.c     | 34 ++++++++++++++--------------------
> > 2 files changed, 15 insertions(+), 21 deletions(-)
> >
> >diff --git a/include/lmb.h b/include/lmb.h
> >index a35a69d69f77..4f3c861b15a6 100644
> >--- a/include/lmb.h
> >+++ b/include/lmb.h
> >@@ -111,7 +111,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
> >  * Return: base address on success, 0 on error
> >  */
> > phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> >-                               uint flags);
> >+                               enum lmb_flags flags);
>
> This change implies that flags IS NOT a bitfield. Flags may only hold a SINGLE value from the enum.
>
> This looks wrong looking at the definition of the constants via BIT().
>
> Defining the constants of a bitfield in an enum was wrong (or at best misleading) from the beginning.

Ah yes correct, I'll just leave it to uint and change the function prototype

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> > /**
> >  * lmb_is_reserved_flags() - test if address is in reserved region with flag bits set
> >diff --git a/lib/lmb.c b/lib/lmb.c
> >index c09f1a1277ad..67bde60b74be 100644
> >--- a/lib/lmb.c
> >+++ b/lib/lmb.c
> >@@ -777,8 +777,20 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
> >       return alloc;
> > }
> >
> >-static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
> >-                                  enum lmb_flags flags)
> >+/**
> >+ * lmb_alloc_addr_flags() - Allocate specified memory address with specified attributes
> >+ * @base: Base Address requested
> >+ * @size: Size of the region requested
> >+ * @flags: Memory region attributes to be set
> >+ *
> >+ * Allocate a region of memory with the attributes specified through the
> >+ * parameter. The base parameter is used to specify the base address
> >+ * of the requested region.
> >+ *
> >+ * Return: base address on success, 0 on error
> >+ */
> >+phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> >+                               enum lmb_flags flags)
> > {
> >       long rgn;
> >       struct lmb_region *lmb_memory = lmb.available_mem.data;
> >@@ -802,24 +814,6 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
> >       return 0;
> > }
> >
> >-/**
> >- * lmb_alloc_addr_flags() - Allocate specified memory address with specified attributes
> >- * @base: Base Address requested
> >- * @size: Size of the region requested
> >- * @flags: Memory region attributes to be set
> >- *
> >- * Allocate a region of memory with the attributes specified through the
> >- * parameter. The base parameter is used to specify the base address
> >- * of the requested region.
> >- *
> >- * Return: base address on success, 0 on error
> >- */
> >-phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> >-                               uint flags)
> >-{
> >-      return _lmb_alloc_addr(base, size, flags);
> >-}
> >-
> > /* Return number of bytes from a given address that are free */
> > phys_size_t lmb_get_free_size(phys_addr_t addr)
> > {
>
