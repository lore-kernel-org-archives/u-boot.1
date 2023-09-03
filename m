Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23442C83F2D
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 18:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9E3F86479;
	Sun,  3 Sep 2023 20:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CsBqz4cH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31433864A6; Sun,  3 Sep 2023 20:06:35 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18A2286411
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 20:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bd0d19a304so11647781fa.1
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693764391; x=1694369191; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B9UhRskiaqYYmHJ74SzBh0ypfqtHkapr3cO6ABHzFL0=;
 b=CsBqz4cHWXRDAGyyAeIZXapXF5ZUFC6oV3triufJDGuuMAhCm3h/kTvhIIpY35dd3l
 4rgaacB8NPnzvJS9nZKfF8R877gPpVLcOKVnDdu5Ou7cHs4mVmVU362aSVIuQ7KyfE4m
 uNvji7XAIz8bFbNiEIGiSxJ0gfsTE1BcxdppE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693764391; x=1694369191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B9UhRskiaqYYmHJ74SzBh0ypfqtHkapr3cO6ABHzFL0=;
 b=fxAj1+6m2sbH3mwsOZAsdl8lalfsIWdvh4dH+gTwyWSZBL3lg9bEPN7ZnVlz5iis9y
 NjyyWbtemF8dzkjGBumscCjaVfNYSgMBthYEYp9jMX/Zb4ldZ/sVAl76siq/dWDiFX71
 k8ipy0/xjkDgM5CbDTGErWYO23vdav6+WRLs8RU5ZAs00hN9OAm4vPsah1mnNmbKTvYR
 EFW6pq3DCLQmv9WjoI3mu+V5uUyAgf7ZBmespW5ft4SgJDQji3lq5v4yw96inbA97tW4
 PfMTnd8cgbE9/zfiqFRfComcwz4HJqiyaiS4KTdRH8oqt6fJCSAJkuOD+KTHaXzyV4V3
 ARZw==
X-Gm-Message-State: AOJu0Yzx+Orqb4gJLbm+Vl8aEM/ArKxN2TeCedC/6NFgJ0ix1vv3d3nY
 qw8THJIdKVHEc8aA7ABHkpTmt4E13imOk/LXk8KVnw==
X-Google-Smtp-Source: AGHT+IEPc1idBJf6tXYdM0EzQH8vYoz1VjwmJsjY/WT9rfVbO6QnJBmE5YUHnKaDdTCYbYiFY4ErXXnPdBMx3WtDM38=
X-Received: by 2002:a05:6512:3f1a:b0:4f8:770f:1b08 with SMTP id
 y26-20020a0565123f1a00b004f8770f1b08mr5833791lfa.13.1693764391095; Sun, 03
 Sep 2023 11:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230823134209.1450567-1-sjg@chromium.org>
 <20230823134209.1450567-8-sjg@chromium.org>
 <20230823151400.GK3953269@bill-the-cat>
 <CAPnjgZ1VBpE8S7G-eBfAeRNQ6PgNvONbGyLceDYL0JsoNnYMjQ@mail.gmail.com>
 <20230903164244.GY3101304@bill-the-cat>
In-Reply-To: <20230903164244.GY3101304@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Sep 2023 12:06:13 -0600
Message-ID: <CAPnjgZ3WbCoxx-GGcf-fXA9iU6pzyr7BJGZD5tRvG0+tZ6Frdg@mail.gmail.com>
Subject: Re: [PATCH 7/7] fs: Fix a confusing error about overlapping regions
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Sjoerd Simons <sjoerd@collabora.com>
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

On Sun, 3 Sept 2023 at 10:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 31, 2023 at 06:15:19PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 23 Aug 2023 at 09:14, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Aug 23, 2023 at 07:42:03AM -0600, Simon Glass wrote:
> > >
> > > > When lmb runs out of space in its internal tables, it gives errors on
> > > > every fs load operation. This is horribly confusing, as the poor user
> > > > tries different memory regions one at a time.
> > > >
> > > > Use the updated API to check the error code and print a helpful message.
> > > > Also, allow the operation to proceed.
> > > >
> > > > Update the tests accordingly.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > [snip]
> > > > +     if (ret == -E2BIG) {
> > > > +             log_warning("Reservation tables exhausted: see CONFIG_LMB_USE_MAX_REGIONS\n");
> > > > +             return 0;
> > > > +     }
> > >
> > > This isn't the right option.  Everyone has CONFIG_LMB_USE_MAX_REGIONS
> > > set.  You would want to increase CONFIG_LMB_MAX_REGIONS.
> > >
> > > But it sounds like what you've found and fixed is an underlying problem
> > > as to why 16 regions isn't enough in some common cases now?  So we could
> >
> > I don't think I have fixed anything. But I'll send v2 and perhaps it
> > will be clearer what is going on here.
> >
> > > possibly avoid the string size growth here and have a comment that also
> > > matches up with the help under LMB_MAX_REGIONS?
> >
> > I don't know, sorry. The size of struct(lmb) on 64-bit sandbox is
> > about 400 bytes. There seems to be a lot of code to save not much
> > memory.
>
> What do you mean here?  The alternative is not unlimited ranges but
> instead to define the limit of memory regions and limit of reserved
> ranges.

A better alternative would be not to limit the number of regions, IMO,
i.e. have an array of regions that can grow as needed.

Regards,
Simon
