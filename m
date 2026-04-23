Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7062EFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 19:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF98084422;
	Sat, 25 Apr 2026 21:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uDINEVKC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43BBB84480; Sat, 25 Apr 2026 21:43:23 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C316384353
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-8a049a767c3so101739876d6.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777146198; cv=none;
 d=google.com; s=arc-20240605;
 b=ZlZG0CI6uQVtH/q7rrtzqfQDdAUtZUuti6vHeCpoDWRXbcnct6NHlVLADnSAZ/IsaU
 9r7UVEpFKEKZcTO4HIihzKKxA0PAGZnk35kBfZI7OSK4KBmlv5RJSg39xAZFoM8gCJI5
 hRDeDI9s4lUb/md6LPoGbb5Y37ZdszX5jESoVoDj1CPe9uie3L0pgP4WeQoIDA+YJOj7
 6cEyXwceUbAer35IsmBQ5BgaHmciIeaRUGvYJuXGpC5FA33rSc69Qk0MBqiQfUEEHoOz
 l9rurt6VseFL4s1WAro19pxEg0R62KKCruxAThj6G3gRkRQ6+PbradNnmwlNnXooQwi5
 g+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PJDgb/4hL7GCIk8hKtK6Bh8GddCC3IwgEmplJMBWr0w=;
 fh=gjUznSifPfnjP02evgVXZIY4Q752n5UYaNV/xy8xD5A=;
 b=Sw6uYDHkfmiKD/7HhQpejBtS2D6+M3doYQ4aDBVHKkSVJUYQv5Mi5Y8Tj4QRaAFium
 4mtQ5H61foluztXYv+QMYY9mu1YGawP8Ii5E71M2Oz/980K3WMO4zL42ZKWPbyzFFtbx
 cZtMXeRn2aExe/ysWrvkGwwmg1t8ZH5QgdL+oxRtXH2GlCuRCaxrokift/CLnNPLdDS2
 QhT32jKD3yrfIZBYA1igOpI3Lwss24AMwOiUnr2He+za5nzYledK7loRrRcNPjq/Qm6r
 O8lJVIlPH3d8PkmdabUwRkxHxDxK+X1XHB2/JVEj94r3cOz1bYTw+/oYNiWEzIw/ZUnM
 BFaw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777146198; x=1777750998; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PJDgb/4hL7GCIk8hKtK6Bh8GddCC3IwgEmplJMBWr0w=;
 b=uDINEVKC4et4UcI0YgF7yCSYBLnRJa3n/El1GxVhcpOsemX4AZd3F8R9/U6K0tbX2h
 sfpgWv2Ti1cSbQdElreslZU5VbrYZAdCJKDSslz8pU7AnOAytYwVvISUkP9K5SEC3OH1
 ZyJy06jkjXRkFJ05oUUy6tTke+JV+uBxSy0pQrzEQB8OLAscUTRXh1tZRpdvr4jnTCu6
 wOo4m3DWXAXpXt/e63diN3r4xJOBIBh9GatafKfI+OfC7RMAmDVzIhreZvrYsKmuEDjs
 DhrHz+6xpZ9d6sVYrMZeYprFyhOgqL/o7Uf5jZ7nFMOu7PKY9j0n9+U7v+1TAvb8wcgN
 6nFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777146198; x=1777750998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJDgb/4hL7GCIk8hKtK6Bh8GddCC3IwgEmplJMBWr0w=;
 b=Qv1DjhbKqDW6ervFQ7NDblSJxZ1NIlyloE24wdWT+Ok6itbQanR6iT7H6XJrTXi55G
 fuzKnJx5XexLlUWo39HsvuxmwTThJkX6eRGYln5fdDkXbK5Spu+erB9qQB7Mrb6qhGpc
 YyJgc/6cpesdbz4ZJILdtVrmuULX3OihlMMfjHE4cVLNrwFJfHcdwJ5cJqxfdg11BjbH
 a2kqLdYJcuH6gDSo3+4IMDV/AKvDmmrchEy7WUxpH7Xxb91qLJkpyu07klHQQNH8yGvA
 OeF1kyY7Z4sVe7JX2xp83zB6MGJB7peXCNUhH3kj/9puBxbdKOGPjV7A8ctkwbRPcScU
 CDOw==
X-Gm-Message-State: AOJu0YzLZet7KhO5X0P7Kw9+jyhPQ4p7b5gQxQBvUzIhrQkY52Ov0w0l
 GEtMMrxMzB0KSi9MQCQot2BRbEyHG5H0JGkxbNz6pLD9nWGRzJ31/iXB5ZQlmx8YCFnHoAb/1G1
 e8tuwXSqHhXrxwI5TuNZEjJjF9HFf4/if1H//6jGEVpiFWEfjhOD6
X-Gm-Gg: AeBDiet7n3ylHwl+STL5LNm2nKWU+xK3CeNgPwjbngl25wkrY4XaONjbSAjSFthLJSv
 UEhqYjS1ygjsvkIP9+tRMwULqnIdCsOOL9wIvdHuLsaGWQ8WZqiCIkwN7p3sn6oBVNN0UyrJWZc
 sJe4mVLltc/O2gDSqXsHAYGBwpcX8nHmDlIbWOY2uaVqQHwPeUL4ob8UD0YRiTVPoR0uIxjtNpu
 7PEA7zC0rbTfFWLkzCwxCZDxfkZRJ2mJNrWO0i1cTUWl8WwFuyv4Sf4laTA7KxOLBMlMrIV6iXD
 S8l6HCYDE7SGM/w4euZ5N2mPqJJVR/1+9geZihqRi0sp/ty5Xyh3FIPD78Ao0f54qONmIPIRykQ
 uCzV1J8BCKjmV9232MPPS+S+ihGNHPoa9oVufaDX5CyzCwes/tRVcK7Z9fEIZhxaMrG/P2VqRl2
 kHv/LJQYLWlbJeoYWjZ0K5WQzDLMUmtxf53Rg4BPq9KliY39wpLqD+cGdDl05Ly+T1g8T1pP0ut
 QLv6qc15yG1wsveOMOkNUcBJoZk4m2JKQy0snJW/lCPcFRGGmADkO9mUwY/oryZHIBwAwO2i9Cs
 y3IGfq44pKRTYPjED6WEJyH/mT/9urKtzOcILoDA+LmpXAq4ZxR/Tyg=
X-Received: by 2002:a05:690e:1406:b0:651:c221:9648 with SMTP id
 956f58d0204a3-653118d26a6mr17660336d50.10.1776934659567; Thu, 23 Apr 2026
 01:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-init_bd_before_dram_init-v1-1-4486dacbe0e7@ti.com>
 <DI0DYY7YBB8Z.2C3BO493CSGBO@ti.com>
In-Reply-To: <DI0DYY7YBB8Z.2C3BO493CSGBO@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 23 Apr 2026 11:57:03 +0300
X-Gm-Features: AQROBzAMjcOwf45e0vV1MWH9nPRlehduzaWHGRU45I5Uvr-2v_ixO7_WQxFXpvA
Message-ID: <CAC_iWjKWEHHnm7H0OX9Z+K=BoGLeneH9aNJTEhnqeUQumSW7LA@mail.gmail.com>
Subject: Re: [PATCH] mach-k3: common: init gd->bd before dram_init_banksize
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Dhruva Gole <d-gole@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Vignesh R <vigneshr@ti.com>
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

Thanks for ropping me in Anshul

On Thu, 23 Apr 2026 at 11:20, Anshul Dalal <anshuld@ti.com> wrote:
>
> On Tue Mar 10, 2026 at 2:46 PM IST, Anshul Dalal wrote:
> > The dram_init_banksize API configures the dram banks inside gd->bd, so
> > ensure bd is initialized by calling spl_set_bd as part of
> > spl_enable_cache.
> >
> > Signed-off-by: Anshul Dalal <anshuld@ti.com>
>
> This patch can be dropped in favour of "treewide: move bi_dram[] from bd
> to gd"[1]. The patch fixes the issue since dram_init_banksize only modifies
> bi_dram field of bd which now gets moved to gd.
>
> [1]: https://lore.kernel.org/u-boot/20260416055948.130041-4-ilias.apalodimas@linaro.org/

Yes please.

/Ilias
>
> CC:+ Ilias
>
> > ---
> >  arch/arm/mach-k3/common.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> > index 2f3df5519c5..39467c21679 100644
> > --- a/arch/arm/mach-k3/common.c
> > +++ b/arch/arm/mach-k3/common.c
> > @@ -418,6 +418,9 @@ void spl_enable_cache(void)
> >       gd->ram_top = CFG_SYS_SDRAM_BASE;
> >       int ret = 0;
> >
> > +     /* dram_init_banksize populates bd, so init it first */
> > +     spl_set_bd();
> > +
> >       dram_init();
> >       dram_init_banksize();
> >
> >
> > ---
> > base-commit: 1e240f7206fccde4ec73ea432ab8360d321c5fe5
> > change-id: 20260310-init_bd_before_dram_init-7a9c3ad0b311
> >
> > Best regards,
>
