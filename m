Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603A2E7717D
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80A8D891CF;
	Sat,  7 Dec 2024 18:26:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OJm2EiaD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83F32892B8; Sat,  7 Dec 2024 18:26:01 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D0038919F
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:25:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so226628266b.0
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592358; x=1734197158; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dMawYqpwUhoWJLJRdxXOKmOUNPUGKjbHIi8NxoCsMt8=;
 b=OJm2EiaDe12l7sig5bLjH22wlGRdHvBEw5IkfrIGNNbseYmPZI6IOnIAZBuSlZ0ie2
 ZIGO6omeHXzQVDEkKsaWgcArNsRy8S2LXv5zO+3arMNKBFzLruuWXOCu/OXSsM8O878t
 CSYbanYe/MO6rMczPQOTt9TGMHHu7sDHhiXck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592358; x=1734197158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dMawYqpwUhoWJLJRdxXOKmOUNPUGKjbHIi8NxoCsMt8=;
 b=pOzZX91sbBTQaelTFvt6b47FjMKtPXKwX8ZS8ZcFaplxFfXHv1a8XUNZ9KZ9z79Zvu
 69wnJTwW9h+/t5imPV3lzjidlermKrdgXzBP77BayW4ewVpu32hz/14d4WeSr0ZJ8h8j
 AQLzYe0AxeVmrx2mpxQy9Z/4pfYw1nM7ZSs2bdv+74bssebnJM9cdToh9Xmy67pSkNGF
 Jk6WB2vFEO3OwgdKhqKerogMIuTeA41vYFguZEzdGD1hlv4V62pPMS4SzBMnnoBV62cx
 EgvXfaWi2/XqCKPPwA/ILmh5JTH54CYAv2wSakKg+NF2TMALVMY2V53IclNZWMSWpcZC
 r0qg==
X-Gm-Message-State: AOJu0YxOIJofi6zpEFyZnHKmYZRSydbmBzIZft0q1B1XzFfiUs6jj6IZ
 0jl9+nfYdTsTEAeU4WoTmXU8K5haWTZkbHIT8m47fpeJeOB3WtM46dsk4pPDPiyqH5HXy3LxwKf
 hY5GmWuVDMkLxZ5fXpbWcUjLn44Sfj5MJY+AL
X-Gm-Gg: ASbGncvnO7lgrZwETI6/R9T1goNW9eBhFZVaEK2X2Uq+fVNtgcreQ+0SvObHkpytWT6
 UO1FkUckyQgAVwZjpFW17NpnTcSHNafPx
X-Google-Smtp-Source: AGHT+IHlrarbe5EtYAXvGUZN27retryEB7I1zSwg0t4+CX3rXw5KBqoUAC084M9uWCyBoOqMFFMz9GqNFl2i+2nslGA=
X-Received: by 2002:a17:907:9145:b0:aa5:630d:7de0 with SMTP id
 a640c23a62f3a-aa63a26a7c0mr584478266b.44.1733592357275; Sat, 07 Dec 2024
 09:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20240920072444.134997-1-sjg@chromium.org>
 <20240920072444.134997-14-sjg@chromium.org>
 <20241003215724.GA2107876@bill-the-cat>
In-Reply-To: <20241003215724.GA2107876@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Dec 2024 10:25:45 -0700
Message-ID: <CAFLszTiqiODFGn5JfPP_Z-SEX+oC_Y1p1oaOE65PjxW2N-X2sg@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] mmc: Add more debugging for SPL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>, 
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>
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

Hi Tom,

On Thu, 3 Oct 2024 at 15:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 20, 2024 at 09:24:37AM +0200, Simon Glass wrote:
>
> > When MMC booting fails it is sometimes hard to figure out what went
> > wrong as there is no error code. It isn't even clear which MMC device
> > was chosen, since SPL can have its own numbering.
> >
> > Add some debugging to help with this.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> [snip]
> > @@ -76,6 +77,12 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
> >       int ret;
> >
> >  #if CONFIG_IS_ENABLED(DM_MMC)
> > +     struct udevice *dev;
> > +     struct uclass *uc;
> > +
> > +     log_debug("Selecting MMC dev %d; seqs:\n", mmc_dev);
> > +     uclass_id_foreach_dev(UCLASS_MMC, dev, uc)
> > +             log_debug("%d: %s\n", dev_seq(dev), dev->name);
> >       ret = mmc_init_device(mmc_dev);
> >  #else
> >       ret = mmc_initialize(NULL);
>
> For the record, this change, even with debugging not enabled (and LOG
> not enabled) is not size change free and does not get optimized away by
> the compiler. I'm not sure off-hand if there's a clever way to fix that,
> so I'm not blocking the series on this.

Yes, I can depend on _DEBUG so I'll add that patch to the vbe series.

Regards,
Simon
