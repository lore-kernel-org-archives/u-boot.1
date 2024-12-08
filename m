Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E247E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 14:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A7D78946D;
	Sun,  8 Dec 2024 15:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vjgl16s/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 865DE894B7; Sun,  8 Dec 2024 15:48:59 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD1C88B0A
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 15:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6efa08f91c8so33771107b3.1
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 06:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733669336; x=1734274136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3HcpSMHEoQKOT2K+uVYC7qun4/dwb31bku4hiltljR4=;
 b=Vjgl16s/jNy2WFmr0c1V0RuQ44LmV0L7Ulpr+k6vmqc43XcPTICGDTlUancki6XtHq
 4MwZbL/Adqsat4t/4X+JDC3pdNIkvJ0R90F5H4GYzDCgq7EyNu6ctZuttkoWT2pWotkc
 bkIqdy0wYugYVeqbCpoEtqkX6+TuBo5rtoKxNRjrE8VLaUXrL0ihdwjX6gUEkLRBJum2
 OreUsN1QgitwrmLTWNY+e/p8QRT1SobfIivricLfwLgpbhspCSx/l8DQiheQQY9XYiVZ
 po9bEqrdihVWm6w4GfIYtDE4+5utjip+IpAH35fwXjv3zuJy9DI5dZkqGmbdz83MjE2r
 diow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733669336; x=1734274136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3HcpSMHEoQKOT2K+uVYC7qun4/dwb31bku4hiltljR4=;
 b=HHu/5k7fTDkyJhX1D5onLzwPCIN6KpOGIQkaBfvwwHmzPIQYA12yYq71qe0lk4NVq7
 ecYeRCVAmfSmmF8NQJceLs0wh9BI86W8lxE/SJqi0qyIQlwzM1wxnDep/bE7b5ZL8mdD
 KCwjUzu7+at2qxOLgrjn9VllfF0V57dU5GPrC94zjWuoetBSz0YbScEbXA5r81xdaGc9
 EyKqvuqXyIrc7mnt0P9RWB8gftjltxVuq9Ddxd57JwvGRfokbTtRQJ9dM+hvGRiMYfS6
 wqVFbgSepjLqyunSHUw6fwZcG1wuzJNn+xYUU+qGnMZdAWldc+tkzfDuc0cYIWP3PrVF
 ls9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYZoIdKiZ06maIS7HO0fTY1MwTY7tgdZ4A1yNB/oeSh+YMVcLMVDRPHQXJbxuPY3LfjJspU6c=@lists.denx.de
X-Gm-Message-State: AOJu0YyyEbXp2q/t3nF+VWgB4jMfPE5QMrg4xLl89DBZJXSQBG12W/a5
 rDM/RLagcysuLvREbgXzc+C0g//sa1KLq2JZX4diKpnQp7OAxU/OSrYdsgzsWNcBdA0iM80L9Zt
 o26KsqXaO9nh665x1O0E+8iootYu4/KJTBGFSYA==
X-Gm-Gg: ASbGncsO4PncTBt2MiMLQysOCktFGi7huhehGcN9nkeKHBb5MnUGO8TdIlYNxtthvpD
 /1RSMA8FBfgtlSLK1AG8dlygDyGt2xzo=
X-Google-Smtp-Source: AGHT+IEFgoHb3qNsV7wSECjpaEH3q9SZmO15Pj0uTSeYW6kE8o7w2KhTbgKaB37AKlY5SYhedBqBzmY2Re43Df99BEA=
X-Received: by 2002:a05:690c:62c8:b0:6ef:4ed2:7dfe with SMTP id
 00721157ae682-6efe3c6c9f6mr107854847b3.31.1733669336062; Sun, 08 Dec 2024
 06:48:56 -0800 (PST)
MIME-Version: 1.0
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-8-ilias.apalodimas@linaro.org>
 <14396C54-AE97-4D24-878E-16E73E9F0CA8@gmx.de>
 <CAC_iWjLiax+zU_Zb1Loi6Vh2HiepS6nPqFm1jCq3wNPMs_7PUg@mail.gmail.com>
 <CAC_iWjKWRe_HVowzyZ9JLufOxfS2ZXfUJn1c1u-NB_5BPHZsDA@mail.gmail.com>
In-Reply-To: <CAC_iWjKWRe_HVowzyZ9JLufOxfS2ZXfUJn1c1u-NB_5BPHZsDA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 8 Dec 2024 16:48:20 +0200
Message-ID: <CAC_iWjJ7DNk+PoORGgmpzYy89BTCcZrH+BaYVh1TMuSD2=gv8w@mail.gmail.com>
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

On Sun, 8 Dec 2024 at 14:17, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Sun, 8 Dec 2024 at 14:12, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Heinrich
> >
> > On Sun, 8 Dec 2024 at 14:05, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > Am 8. Dezember 2024 11:52:10 MEZ schrieb Ilias Apalodimas <ilias.apalodimas@linaro.org>:
> > > >After all the cleanups of the previous patches there's not point anymore
> > > >to define lmb_alloc_addr_flags() and _lmb_alloc_addr_flags().
> > > >
> > > >Fix the incocistency of the flags type, which one function was
> > > >definining as uintn and the other as an enum lmb_flags and rename
> > > >_lmb_alloc_addr_flags() to lmb_alloc_addr_flags()
> > > >
> > > >Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > >---
> > > > include/lmb.h |  2 +-
> > > > lib/lmb.c     | 34 ++++++++++++++--------------------
> > > > 2 files changed, 15 insertions(+), 21 deletions(-)
> > > >
> > > >diff --git a/include/lmb.h b/include/lmb.h
> > > >index a35a69d69f77..4f3c861b15a6 100644
> > > >--- a/include/lmb.h
> > > >+++ b/include/lmb.h
> > > >@@ -111,7 +111,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
> > > >  * Return: base address on success, 0 on error
> > > >  */
> > > > phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> > > >-                               uint flags);
> > > >+                               enum lmb_flags flags);
> > >
> > > This change implies that flags IS NOT a bitfield. Flags may only hold a SINGLE value from the enum.
> > >
> > > This looks wrong looking at the definition of the constants via BIT().
> > >
> > > Defining the constants of a bitfield in an enum was wrong (or at best misleading) from the beginning.
> >
> > Ah yes correct, I'll just leave it to uint and change the function prototype
>
> Hmm thinking about it again. Those flags are never used as bitfield.
> They are always used as discrete values. So I think we should keep it
> as is

Ok, the above is not correct, we do indeed them use as a bitmask. So
I'll just change the type to unit

Thanks
/Ilias
>
> Thanks
> /Ilias
> >
> > Thanks
> > /Ilias
> > >
> > > Best regards
> > >
> > > Heinrich
> > >
> > > >
> > > > /**
> > > >  * lmb_is_reserved_flags() - test if address is in reserved region with flag bits set
> > > >diff --git a/lib/lmb.c b/lib/lmb.c
> > > >index c09f1a1277ad..67bde60b74be 100644
> > > >--- a/lib/lmb.c
> > > >+++ b/lib/lmb.c
> > > >@@ -777,8 +777,20 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
> > > >       return alloc;
> > > > }
> > > >
> > > >-static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
> > > >-                                  enum lmb_flags flags)
> > > >+/**
> > > >+ * lmb_alloc_addr_flags() - Allocate specified memory address with specified attributes
> > > >+ * @base: Base Address requested
> > > >+ * @size: Size of the region requested
> > > >+ * @flags: Memory region attributes to be set
> > > >+ *
> > > >+ * Allocate a region of memory with the attributes specified through the
> > > >+ * parameter. The base parameter is used to specify the base address
> > > >+ * of the requested region.
> > > >+ *
> > > >+ * Return: base address on success, 0 on error
> > > >+ */
> > > >+phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> > > >+                               enum lmb_flags flags)
> > > > {
> > > >       long rgn;
> > > >       struct lmb_region *lmb_memory = lmb.available_mem.data;
> > > >@@ -802,24 +814,6 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
> > > >       return 0;
> > > > }
> > > >
> > > >-/**
> > > >- * lmb_alloc_addr_flags() - Allocate specified memory address with specified attributes
> > > >- * @base: Base Address requested
> > > >- * @size: Size of the region requested
> > > >- * @flags: Memory region attributes to be set
> > > >- *
> > > >- * Allocate a region of memory with the attributes specified through the
> > > >- * parameter. The base parameter is used to specify the base address
> > > >- * of the requested region.
> > > >- *
> > > >- * Return: base address on success, 0 on error
> > > >- */
> > > >-phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> > > >-                               uint flags)
> > > >-{
> > > >-      return _lmb_alloc_addr(base, size, flags);
> > > >-}
> > > >-
> > > > /* Return number of bytes from a given address that are free */
> > > > phys_size_t lmb_get_free_size(phys_addr_t addr)
> > > > {
> > >
