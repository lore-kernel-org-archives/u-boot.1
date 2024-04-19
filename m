Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8B0C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 20:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9695088131;
	Fri, 19 Apr 2024 22:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="uTYOT/aY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E325C8845F; Fri, 19 Apr 2024 22:55:13 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22C6488125
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 22:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-61b4387ae4fso5300567b3.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1713560110; x=1714164910;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8K//KSNRdul6MA/nksSS50ySk22f3aTwIwp4+Ron/c0=;
 b=uTYOT/aYUMezfTO4Mo0wnV1sA1ra7EMt84/tey7m5H0K2RNJOHufH7o/wJJjXA+UgK
 bxkXmT12Xv3x2Znak9Uq0WhkTV6EGdEoBUalXi64ws/xK/Us4egHP3WYPzU7MQDKkzbu
 4+zWSWUZplI30cdbTdE7jb3xIfY1PAdlL/ToIuw8H6YlhDezJoR+IcE2XX59YiYOJmlz
 JbVbPC5IrhP7NiciwklTW7j8PyOHS4BWwiOcELDGVSwey4YRlgV5hlJZPLi+sn0Hd5v8
 nfKPojn23sW8wkwBB8tJEAXQQ8zpVw3LVCAQijACPIXbkwJDMvbntgE+tnjRQVDjfHvy
 8jzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713560110; x=1714164910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8K//KSNRdul6MA/nksSS50ySk22f3aTwIwp4+Ron/c0=;
 b=ODZjNR2LRgesCEe0DXs54NgsHpejyeoUWTqD6RSObxoiRiTGiqqZdrtUPZ4yPH+/mT
 HmZSSJ/jss0y28uG7593KIVo74X5yf2VUwbTK43w3+BbG0NBVNa+sqoDtiA9IkaSYWML
 VtjC0G2tXbU127awcCw6HHPh4m77CJOi/3sL7kbwipq5KvXyp+eMsRVcwkwJulb/+nyc
 0vP8EnsXYNeo9MOKnxnfHhwVktNrSqXiK0SJiLPqEiYgwCnKKiZjZB2FiJJ8+eKlB9xr
 5pNe9KDl1OQ++98z3WWq62OiEBNpslQXnzKhYkUYMxNGZwxN6tuxn5bb7329noSDAc7/
 vkpw==
X-Gm-Message-State: AOJu0Yx2f4/aPZ5YPPqDt6teE6cALakLcGFfUAHFyS9aLrHmucalxaPL
 XKauKCD5DfUrPsReTW/W/PeNGKxbMAbR0lPP7ez5ePEe9gIcDNuN4Gb7J0OvdlaSgwkDnOTIL4r
 sEJBOi/genm8jewi5ZBUqiBW60uidknt44zxQ
X-Google-Smtp-Source: AGHT+IE7oSZsShu+7kRO+Cn6VbwrZgpMszLKhQgLKQs18pBhAuazt2CBGB4qDbULLRBJ3cUvkfxbqCf4TopajXDqsdA=
X-Received: by 2002:a05:690c:c94:b0:618:5083:caa0 with SMTP id
 cm20-20020a05690c0c9400b006185083caa0mr3214789ywb.12.1713560109996; Fri, 19
 Apr 2024 13:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20240326022044epcas1p4c22b3f79421ca2ba3e93988d29016192@epcas1p4.samsung.com>
 <20240326021819.770-1-greg.malysa@timesys.com>
 <002d01da905d$c0d03600$4270a200$@samsung.com>
 <060201da921b$c22bbeb0$46833c10$@samsung.com>
In-Reply-To: <060201da921b$c22bbeb0$46833c10$@samsung.com>
From: Greg Malysa <greg.malysa@timesys.com>
Date: Fri, 19 Apr 2024 16:54:42 -0400
Message-ID: <CAAjXUaoQ76WLKw0kuYkOS2C=N7wZB-qceSAWio-oxW3=J+Tomg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: introduce adma_write_desc() hook to struct
 sdhci_ops
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Peter Geis <pgwipeout@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

Hi,

> Some target are failed to build. (e.g, j721e_beagleboneai64_r5)
>
> +drivers/mmc/sdhci-adma.c: In function '__sdhci_adma_write_desc':
> +drivers/mmc/sdhci-adma.c:37:43: error: 'const struct sdhci_ops' has no member named 'adma_write_desc'
> +   37 |         if (host && host->ops && host->ops->adma_write_desc)
> +      |                                           ^~
> +drivers/mmc/sdhci-adma.c:38:26: error: 'const struct sdhci_ops' has no member named 'adma_write_desc'
> +   38 |                 host->ops->adma_write_desc(host, desc, addr, len, end);
> +      |                          ^~
> +make[3]: *** [scripts/Makefile.build:257: drivers/mmc/sdhci-adma.o] Error 1
> +make[2]: *** [scripts/Makefile.build:397: drivers/mmc] Error 2

I will test v2 with CI before resubmitting so that this issue is
fixed. It is caused by the change and explanation below:

> > > diff --git a/include/sdhci.h b/include/sdhci.h
> > > index a1b74e3bd7..4bde7db5c7 100644
> > > --- a/include/sdhci.h
> > > +++ b/include/sdhci.h
> > > @@ -291,6 +291,11 @@ struct sdhci_ops {
> > >      * Return: 0 if successful, -ve on error
> > >      */
> > >     int     (*set_enhanced_strobe)(struct sdhci_host *host);
> > > +
> > > +#if CONFIG_IS_ENABLED(MMC_SDHCI_ADMA)
> > > +   void    (*adma_write_desc)(struct sdhci_host *host, void **desc,
> > > +                              dma_addr_t addr, int len, bool end);
> > > +#endif
> > >  };

We got a little too excited about following checkpatch's
recommendations (no #ifdef CONFIG_xyz, prefer #if
CONFIG_IS_ENABLED(xyz)), which breaks down in this case:

CONFIG_IS_ENABLED(xyz) checks if:
- regular build and CONFIG_xyz is enabled (this portion succeeds)
- SPL build and CONFIG_SPL_xyz is enabled (this portion fails)
drivers/mmc/Makefile builds sdhci-adma.o based on
CONFIG_SDHCI_ADMA_HELPERS only.

There is no CONFIG_SPL_SDHCI_ADMA_HELPERS so CONFIG_IS_ENABLED fails
while building the SPL version of sdhci-adma.o as the structure
definition is different. This only appears on platforms which have
CONFIG_SPL_MMC enabled, which our platform did not, so I missed this
interaction earlier. I apologize for this mistake.

This will be fixed in v2 by changing the #if back to #ifdef
CONFIG_MMC_SDHCI_ADMA_HELPERS, which I will submit after CI finishes
running to verify on all platforms.

Thanks,
Greg

-- 
Greg Malysa
Timesys Corporation
