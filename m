Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47356C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 14:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C3C8129B;
	Fri, 28 Mar 2025 15:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A1r50fSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B98518144A; Fri, 28 Mar 2025 15:17:31 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E79D8070C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 15:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so2738948a91.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743171448; x=1743776248; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=twT9DjX6sytVthbHNb6eqOxzJImOoXzuJPz42Cfs8xA=;
 b=A1r50fSh/JWIlYwkIAxJmU+ZwQY3A1y2UtHl0q+FrKb+940P3SMdhq2ULm2gWVKmW1
 Sb9p1wUT0nqXvNfj829GaN8Q+vUJFK/zJHm5xpx1K02hFu+1+YCrfotF5Cn1RK5biFso
 v8Ymo8pakJYFmnTjrMOMBDKg0Az3IDD1NgycBqGMpf5pmKRFy92tJuEZBgdbK98eNH4h
 pwMmJQyaRoyjsKLsRBtKnf9N6/mg7x5B0SHvswP7o1ZJVBHSHqQT4stkZj+cbGtZOb3J
 IgwjetTC9TVp4mKzlxCnZmaNUmhQ1t4OAVrEs+/zUodZGAGTwWaK1TSFKWhy03bN4sKa
 Q6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743171448; x=1743776248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=twT9DjX6sytVthbHNb6eqOxzJImOoXzuJPz42Cfs8xA=;
 b=aMffYHvZaz0ATBaZLmKFJkrThfuadtZ+t26ZJSUc35ftXPGtJxItMFr9omcUR2vrA/
 fi2XyHGNPLBn8It4k4DuCOS7cxyiwLvfgXHfPErViJrcyWVuRb4NM/DSA/YWphfEBnCT
 QoRqQ04Q3/9IAcOuQ7AqEwis3x14gfm9OfqqbCKA4h08E7dbTLxBEr9O2Ir1hkmGpV51
 5LPzvKmX3VH8j15rtjMnWrCT8jbyBctGjEKJjsiBngzpH+bpKauz+eHXK7kjYbsCCc7P
 bQsP4skrQaNURnYiv6gRuXHMvj4NbVXBpRWe9HsTGM77FNaEERutASqj7eazGJa5QZKw
 erKg==
X-Gm-Message-State: AOJu0Yy1QrqR89yaxwtC5LRBkY6r/A8/FIUhZsWbECfwPhCO7b1rP3/D
 zj4gE6vdEfuDzjEX0u9WTfFanpKszIeRcwjsZTdqpPuy+UwEGxkjO36Mfg8rjOadow9nitkbwgn
 PHxux51kSa93JKxkz3UNy8ANsXlc9LyhNcRMuzQ==
X-Gm-Gg: ASbGncsYSKwdQzvSyxmKxWwO+QoE45EBJKWMbmzxXivRbCRZKsHrBSsr0HyeQT2jDaw
 i1wEUgYDb+SYff44JyPjGofCkNGSvkfjRk8AZSsbCicZmJyaqRF2g9Jpq2mFJVZpT4lEfEEzSdx
 Z9fJ/mmpGgC5+oHHd7taLFAtMtgbX9
X-Google-Smtp-Source: AGHT+IFQtqxAr7hnLAfsELzwQQYIxedqHJe06spPUhQh3lI5qEz4eloVZv5URkmwSSFWp89cQ74BMNPu7W37lL6tm8Y=
X-Received: by 2002:a17:90b:224c:b0:2ee:ab29:1a63 with SMTP id
 98e67ed59e1d1-303a7c5dbfcmr10462404a91.3.1743171447575; Fri, 28 Mar 2025
 07:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <CAFLszTjpbxH6_LEuv5mAyOjt812hXvTKL1nDpP42HMJXwMryWA@mail.gmail.com>
In-Reply-To: <CAFLszTjpbxH6_LEuv5mAyOjt812hXvTKL1nDpP42HMJXwMryWA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 28 Mar 2025 10:17:14 -0400
X-Gm-Features: AQ5f1JprjsNbhIqLYaiD-Xk1lTdkTt6Mhb_Bjqz9BbUO1tHZ34dGE5iuConzNyg
Message-ID: <CAEfUkU+tYjjNQAmwv2=FWkPYxLZriAd3FdAVQQrdt7PTXK_xiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: fix the overriding of fdt from bloblist
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>, Ravi Minnikanti <rminnikanti@marvell.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Simon,

On Fri, 28 Mar 2025 at 07:34, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Thu, 27 Mar 2025 at 17:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > When a bloblist is valid and contains fdt, it explicitly means
> > a previous boot stage is passing transfer list compliant with
> > Firmware Handoff specification, thus the fdt from bloblist should
> > not be overridden with the ones from board or env variables.
>
> Why is that? The board can choose to override it, if it wishes, but in
> general, if gd->fdt_blob is already set up, it should return -EEXIST
> from board_fdt_blob_setup().
>
First, if a board is running in a "stand-alone" mode, there should not
be a transfer list passed from the previous boot stage.
Secondly, overriding the transfer list with the env variables does not
make sense, since booti, bootm and bootefi are actually using the env
variables to get the fdt when launching to the kernel.
We need to do the opposite way - override the env variable with the
one pointing to the bloblist fdt (See my patch [2/2]), then all boot
commands can work with the transfer list.

Regards,
Raymond

> >
> > Fixes: 70fe23859437 ("fdt: Allow the devicetree to come from a bloblist")
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  lib/fdtdec.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > index f09c9926a7a..c38738b48c7 100644
> > --- a/lib/fdtdec.c
> > +++ b/lib/fdtdec.c
> > @@ -1708,7 +1708,7 @@ int fdtdec_setup(void)
> >                                 gd->fdt_src = FDTSRC_BLOBLIST;
> >                                 log_debug("Devicetree is in bloblist at %p\n",
> >                                           gd->fdt_blob);
> > -                               ret = 0;
> > +                               goto setup_fdt;
> >                         } else {
> >                                 log_debug("No FDT found in bloblist\n");
> >                                 ret = -ENOENT;
> > @@ -1752,6 +1752,7 @@ int fdtdec_setup(void)
> >                 }
> >         }
> >
> > +setup_fdt:
> >         if (CONFIG_IS_ENABLED(MULTI_DTB_FIT))
> >                 setup_multi_dtb_fit();
> >
> > --
> > 2.25.1
> >
>
> Regards,
> Simon
