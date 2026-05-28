Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD759CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F66B847C4;
	Thu, 28 May 2026 19:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UG+zoxot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E21D846E6; Thu, 28 May 2026 19:12:25 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E994E846F4
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bd124546379so1939943566b.3
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779988341; cv=none;
 d=google.com; s=arc-20240605;
 b=S/I+eNsiUga3fpAX5u9ZJF63v9lw1TmaNp4Zx8204lGv+f+hy+MJ71tOsGMf/5HPJj
 R0VSmwHhf0KMlkmXSVfJeYsHZm20z7JVX6qoZktkzkPskarfT3hk6cPEiUXb5gPFlabd
 mnL9nCQXTVe+v2MrXOnqgf4qYDnX9+nRzwcsIb0DH4zzXzgyWX9Ej4IbFkeGx6KQMikR
 1GzUo9Ok2RAzG6tOtODQIIzO5VXlUb44HaO7AeGiEE66w3nY+jV2pnySVlevgXUC/ugl
 35oM9GEjtiRhwxIeBzLGpDttylsovgZ45bHhVIoF3i4AqNhahdxTxEng6PSsXljFMELT
 JDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O05ZveS/RC1bWdMbWd+O2zXbL+4n6AjYL8tNx/NZ/lY=;
 fh=KQHSLF6SPXj/m/mhHIOxeD0jPtvMNlvVyd1ycIo3uvA=;
 b=YbdN62CsHU97WTX0l2Big4Ae/HET2BNcczxBBqJuyAo7h6rGOc7kbacD9o/VeB52Xh
 FGacsss8rVw5zz5jNCPKunPrMTeYGqQnCVrzwIkPTpfWsRBPf9UOQpKw8DbSU1Or3sVO
 t7FI8AKtYDEZ4NpMPO/dWoQs9U9gl83nYvy22d+8ZPjQM4Z01MJPNdjZyUWb6ATGVSAU
 5go3hdyZ+QnWK9QrFYzVKwZhjbLIcwPvMOjoCM1ct/EFTjTwXoiTy1r5e642lSy3N3np
 b624b9jrUZEojNThxPhPiZcg7DlSYxXdXtdUkymihIMxuoiClbC/5JEJTRCcvphDggNP
 Tu/w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988341; x=1780593141; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O05ZveS/RC1bWdMbWd+O2zXbL+4n6AjYL8tNx/NZ/lY=;
 b=UG+zoxotK0w+nRS248YAhl1wy8QdZGltFwVQXkBV2Fgs80zfjXRjLRRzFV9yGRuNGT
 XljBcvsnJhYkC4Bp7PJrxwvCcBMZBHllvJA8NHUnT9iM2mxn2QZyObqhlF3mwISzN/ZL
 biBq9US02xYxeORA8RKt+Oe3qf0EjsHRqUZ2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988341; x=1780593141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O05ZveS/RC1bWdMbWd+O2zXbL+4n6AjYL8tNx/NZ/lY=;
 b=GchzosiQtbYFa8MkpFpas7xtxny+7CW/QXaPGXnrIH1X1MIuHEgkyoV5aBOWiLrQsa
 v8LG4PueCZEc5JDb60wASGGcvWrD5+CU1EsnZ3RrJ1ZegH4sBuxafnflHAFpK6yu4A/P
 Uqbwd/LKzQkza+sDcvEZhepaq35Mwi4jfXSWLDnFfBnOdWoEEXMaJZ+8uLHB1ySywdQr
 +A7S3fff5htiLIiOoo+jpUCmqo9ifEtkCRMWysU9UeCUdEg+kIa9XUDSirJT4LX5xHp+
 zzj40kuso2OHIKHJAj0hEMeu0u2LxieZpno5N430J02GdcRLYTgu3WXlXf1NjH0sPzCx
 FlOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eu1E9Nf3+c3Q+jbBUel70SB4yPZ9LUaD69ciTPVs1SETkoC7IIJGDHv6cShwlmR/fuwRDn+c=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9V+Z7kLO2OuB+ymmI7WlUVlxylnFxF9fyMG0DSBtgRu83RjIZ
 rqKM5lvMp/ygZ7xOOzvjpu9jbABprrErnDlI7aicuiSKAPgX6DmbLYVVEcp3W7ahNeSswAedoID
 P2p8YpIraE8PuY5eM/pO3XXvBvB7Sa2yzWeddLQh1BtEHUPBkqOg6U3v4VWq+oQ==
X-Gm-Gg: Acq92OEbcWX/jKUjkK9vnOB7W+lvmkYgeE0EZxTUbimuoVy3qNktEw7QIiXt2hZ+Fi9
 bzsZI4P9iFu9HBE3e1Lfvk3Je5XF2NamnkFazSRPDk5yN163XoxLkc1mXUs1HOHv5yjQY3jKOwZ
 4iE5lAujYlEpMRQeXI83irUAAP6eziRYwLyulVZvNM/I5VdYdoYykOcaG4YbBx8XSs/jsH6Egwd
 IKSO2V4dDrZUMaQUwqfG+wTB5/RMlUt8TDNQDhOZIh5HhEn0DhlmnZ4qK9c+NrQ6xt0C2LFLjfA
 Tw4JW6G3quuN2sri
X-Received: by 2002:a17:907:7246:b0:b9c:aba8:87c6 with SMTP id
 a640c23a62f3a-be97411af77mr3570166b.37.1779988341340; Thu, 28 May 2026
 10:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260527161033.3273795-1-sjg@chromium.org>
 <20260527161033.3273795-3-sjg@chromium.org>
 <6fc3e71a-8872-4c35-969a-f54ce2869947@gmx.de>
 <20260527194345.GA93986@bill-the-cat>
In-Reply-To: <20260527194345.GA93986@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 May 2026 12:12:09 -0500
X-Gm-Features: AVHnY4IFt0m5Yr-2YsQsh1tUAIQ4LWEIWoAV1GQapw8HirFjkufUpud7_b6jDBE
Message-ID: <CAFLszTh+vVMydNuHwJsK8J6adZX-ptiYvWSYza-QKEZ-XQnAcg@mail.gmail.com>
Subject: Re: [PATCH 02/13] alist: Allow inclusion from OS headers
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tom,

On Wed, 27 May 2026 at 21:43, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, May 27, 2026 at 08:36:45PM +0200, Heinrich Schuchardt wrote:
> > On 5/27/26 18:10, Simon Glass wrote:
> > > Sandbox needs to include system headers in some files, but also wants
> > > to use alist. Adjust the headers to permit this.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >   include/alist.h | 16 +++++++++++-----
> > >   lib/alist.c     |  1 +
> > >   2 files changed, 12 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/alist.h b/include/alist.h
> > > index b00d9ea97d6..69d7cdb722f 100644
> > > --- a/include/alist.h
> > > +++ b/include/alist.h
> > > @@ -10,8 +10,14 @@
> > >   #define __ALIST_H
> > >   #include <stdbool.h>
> > > -#include <linux/bitops.h>
> > > +
> > > +#ifdef USE_HOSTCC
> > > +#include <sys/types.h>
> > > +#include <stdint.h>
> > > +#else
> > >   #include <linux/types.h>
> > > +#endif
> > > +#define BIT(nr)                    (1UL << (nr))
> >
> > BIT(nr) is already defined in include/linux/bitops.h.
> >
> > We must not assume that no module includes both alist.h and linux/bitop=
s.h.
> > E.g. include/expo.h and include/lmb.h include both alist.h and
> > linux/bitops.h. We should avoid redefinitions.
> >
> > The following is an abuse of the enum type:
> >
> > enum alist_flags {
> >         ALISTF_FAIL     =3D BIT(0),
> > };
> >
> > As this is the only use of BIT(), we could simply use the value "1" her=
e.
> >
> > #define ALISTF_FAIL (1)
> >
> > But as ALISTF_FAIL is the only bit in flags used, the best solution wou=
ld be
> > replacing flags by a boolean called fail.
>
> I see this as another reminder about how frustrating it was that alist
> was introduced under the guise of "must have this for an x86 feature"
> but instead is a solution in need of a problem to solve, and whenever
> it's used for something else, yet another problem with it is shown.

The alist was motivated by its original commit. It allows easy
iteration, uses less memory (no next/prev pointers in every element),
uses fewer allocations than linked lists (one malloc() for the whole
list instead of one for each node) and has much better cache locality
as a result (i.e. improved performance).

I asked my friendly AI to compare them:

  - Reach for alist when you want a growable, index-addressable, cache-frie=
ndly
  collection of small value objects you mostly append to and iterate (e.g.
  bootflow/bootdev scan results, parsed tables).
  - Reach for list_head when elements need O(1) removal/splice from arbitra=
ry
  positions, must keep stable identity while linked, or already exist as
  independently-allocated objects (most driver-model / subsystem object lis=
ts).

  One nuance: alist_for_each is pure pointer arithmetic over the buffer, wh=
ereas
   list_for_each_entry uses container_of to recover the enclosing struct fr=
om
  the embedded node =E2=80=94 a direct consequence of array-of-values vs.
  intrusive-links.

Regards,
Simon
