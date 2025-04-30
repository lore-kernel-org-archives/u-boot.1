Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D80C3ABA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 15:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8900282BAA;
	Wed, 30 Apr 2025 17:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gupZo9t+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65CDD8215E; Wed, 30 Apr 2025 17:00:57 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E118782BB4
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 17:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso1306692966b.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 08:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746025254; x=1746630054; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9lP0Mj7QfeHGxt7uNEbNUNNKB3b83sTFultnY8jdfm8=;
 b=gupZo9t+rIq1FU8KD5zM9c89XNT3DO332Wci9ffMJQBVX63brjYbCUyY65WVeH378l
 SaYSE85fc3TrZRCuHiPdDBmWfonWIABnim3vMzDZVclqySvLzzZU5ba9YgP/8Sh/kOs5
 ps5717ZjzaCpe2PIP8dVJWexl0rcZgSUEbbIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025254; x=1746630054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9lP0Mj7QfeHGxt7uNEbNUNNKB3b83sTFultnY8jdfm8=;
 b=npbdzzuK6yngO6AUDnyfacdtbdzgKKJ0uUnRbLmoD6aOG+EIQa/r+zWhGKuCDtfLs7
 tl9J+PkOoB97YdZRyTnfetG3P2f3ic8EKgdzv6l7zjdctlJSz+mVogBSXVrgNFSbHLi5
 GMDABPUgogAhC34JF4dJqHIDay8kWZdacTRvqoEI0BprBI/+4B3MFemlRxvHb4majOWw
 jnEDSvdZK+Q2UWUcDVpQbdMbZ858Utt2N3/AR9wsE3g/GbKvLj0Wwz3gsQRc3aQOrZZ+
 ZbQCAtQWZTHjWpcOHhGzZntxprfw71vvBfAnp5r8S6Hl4/qs11nVdftAX3RrCMa3pRSc
 c2aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw/Kf//f7IHu1rhzEh/sGL1DLTMkDVK4SswQDO9991d2osSP7SqBj1ay5zq/IKuZUJXWuqyY4=@lists.denx.de
X-Gm-Message-State: AOJu0Yxcz34JxCkA2DUFNgr57IzQOpZFPCs3WxDGzXqKdKxxyzHTr/ic
 REyWYZFKD3DbCvB22Qtn5IgStuhIJRyB+zkQGseN/3Y56baqhBOmRsQrUG6gAelke6Q1kLApUPx
 5AYWpSoP+dHuLLHkGQmdE34APR3b2j1itI1TW
X-Gm-Gg: ASbGncvZX1fMq5qyPXmIP1CPod4eQOD0NJ+OheFo90drLm+gSR+TbBUNag3+/OEPHTb
 JoOvnts0zt8vI92gaBoOl4yVFWobxWnlK0HRayjFkRm8xsFkceyOl9sGGUwcRfY4DCjniA28czK
 E5EyuTcjbQf6iLBdve5pyUaJI=
X-Google-Smtp-Source: AGHT+IFHV/6L7TmJqEjcV6J7GpMRAdFohWioqNQb0V+ouxYPzhufZy8HdJTw8DsQdcU60y02lh9VrVN2hLGndO78cVA=
X-Received: by 2002:a17:907:9712:b0:ace:ca87:2306 with SMTP id
 a640c23a62f3a-acedc634e1fmr344208966b.34.1746025253911; Wed, 30 Apr 2025
 08:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <18d1c97d9a420c40181352bf1445e2772d784d9a.camel@codethink.co.uk>
 <CAFLszTjjsdp7xijT1SVq9P3mou9vvGWmK5_ngb1Y6Ap4A99QSQ@mail.gmail.com>
 <20250430141513.GN1261075@bill-the-cat>
In-Reply-To: <20250430141513.GN1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Apr 2025 09:00:40 -0600
X-Gm-Features: ATxdqUFmlwVoXFTqCCI-AL6jfEGZcrul44tJVqLUM-cZpez51tCR8Jc6cHbZg6c
Message-ID: <CAFLszTh-G4m2oXZya7SBBeYw2f4S0Od7=toS1H2iwMeumSsHgA@mail.gmail.com>
Subject: Re: [REGRESSION] [PATCH v6 0/3] Static initcalls
To: Tom Rini <trini@konsulko.com>
Cc: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Stefan Roese <sr@denx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
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

On Wed, 30 Apr 2025 at 08:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Apr 30, 2025 at 07:54:46AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 29 Apr 2025 at 16:32, Marcel Ziswiler
> > <marcel.ziswiler@codethink.co.uk> wrote:
> > >
> > > Hi Jerome
> > >
> > > On Fri, 2025-04-04 at 15:50 +0200, Jerome Forissier wrote:
> > > > This series replaces the dynamic initcalls (with function pointers) with
> > > > static calls, and gets rid of initcall_run_list(), init_sequence_f,
> > > > init_sequence_f_r and init_sequence_r. This makes the code simpler and the
> > > > binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -510
> > > > bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
> > > >
> > > > Execution time doesn't seem to change noticeably. There is no impact on
> > > > the SPL.
> > > >
> > > > The inline assembly fixes, although they look unrelated, are triggered
> > > > on some platforms with LTO enabled. For example: kirkwood_defconfig.
> > > >
> > > > CI: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/25514
> > >
> > > This series seems to cause a regression on rock5b. E.g. on today's master:
> > >
> > > => pci enum
> > > => setenv ipaddr 192.168.10.2
> > > => ping 192.168.10.1
> > > failed to initialize card: -12
> > > failed to initialize card: -12
> > > failed to initialize card: -12
> > > failed to initialize card: -12
> > > failed to initialize card: -12
> > > failed to initialize card: -12
> > > failed to initialize card: -12
> > > failed to initialize card: -12
> > > No ethernet found.
> > > failed to initialize card: -12
> > > failed to initialize card: -12
> > > ping failed; host 192.168.10.1 is not alive
> > >
> > > Seems the rtl8169 driver runs out of memory trying to allocate descriptors?
> > >
> > > If I revert this series on top of today's master:
> > >
> > > => pci enum
> > > => setenv ipaddr 192.168.10.2
> > > => ping 192.168.10.1
> > >
> > > Warning: eth_rtl8169 MAC addresses don't match:
> > > Address in DT is                00:e0:4c:68:01:5a
> > > Address in environment is       fe:b1:db:60:25:69
> > > Using eth_rtl8169 device
> > > host 192.168.10.1 is alive
> > >
> > > I just completed the bisection and will now look into what exactly could be going on.
> > >
> > > Any insights are much appreciated.
> > >
> > > Thanks!
> >
> > I have one of these boards in my lab. Could you please apply the
> > pending lab patches, e.g. [1]? Also, can we get this board running
> > network tests?
>
> Your lab patches sadly stopped applying, I think somewhere around where
> you didn't comment on my feedback about needing to fix problems with how
> modern i.MX platforms do/don't handle blobs, and also the "all" make
> target.

I believe it was when you didn't want to disable boards which don't
work (e.g. samus).

Still, any conflicts are trivial, so perhaps just apply them?

Regards,
SImon
