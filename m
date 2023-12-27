Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE14C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 17:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599F787973;
	Wed, 27 Dec 2023 18:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HFkrdorq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C881877E2; Wed, 27 Dec 2023 18:48:58 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0072287946
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 18:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5eefd0da5c0so1724947b3.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703699334; x=1704304134; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VfcX6i5X5q6ebT8CNWEh8vCP0gLcaEFtD4S4GUoKsgM=;
 b=HFkrdorqXkwsMzv3TlLuDQMLrNeaT1uq4NuEEW2c83EiCV8xR2sjy2WDUrYebT/aP/
 F27DnWxtwYotE5Uzk9dCzPqEiBQrdaMJsbArWBhCvDMRvOrPWErNr2pur30HWKAP/ulY
 4jIHcTonAMM7RehQ0NDiI61lG8jqD2vo2S/9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703699334; x=1704304134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VfcX6i5X5q6ebT8CNWEh8vCP0gLcaEFtD4S4GUoKsgM=;
 b=JJcuekB8SSxIJk5vG+/8F8N0qu5t8hAN4PoLCpv4PVf7o+8DfModAUKI4L74Iwq30s
 f3OpVK9ey2c3glsTXh0vRIDsDLQ/2DRAO2iEgJ+FxRW27Lr0xSDHh2AfUa8dGGhtm7NE
 YxqSiKH5Fvlv3B/Y0W+CK+hbgME8LSspFrgBtJCF0lmKX/3EgHu+73F0uFAm5vbsvOR9
 3zBged/9wq01LyzwOCBYiP69FrWjcm23Q7R3XZCj0Wtqcm9O8bjdNMwKmG/tBM1PB2Ts
 YPPKS9Z8odyxeYgegkZGIAM/+hnDO1RaimZE2yd9OuPYa/bgbIDaEf1kaEegzHF8Z+gL
 lA1A==
X-Gm-Message-State: AOJu0YwdtxA9fzLJm5QA3clIg3HbNKNxN0EjDL7Mxoel+a1235Dr3pR7
 et3C2ElIalk23FSGsWttuIA3+gRpN1giA9Sxg/W5hD/Fsr3e
X-Google-Smtp-Source: AGHT+IEGBbvmkrGdRZex8szE6DMA9lmk9AVg58U1BKTldKvpmLj/30Phnx4oFcbUZ3gxPF4h06alsflh9LyzNbYcTXs=
X-Received: by 2002:a81:6c45:0:b0:5e8:141f:7d8e with SMTP id
 h66-20020a816c45000000b005e8141f7d8emr6464428ywc.9.1703699334688; Wed, 27 Dec
 2023 09:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20231226094625.221671-1-sjg@chromium.org>
 <20231226120710.GH2652760@bill-the-cat>
 <CAC_iWjLy1E9wEW3zX2waN9mc=tz7PTKE0gJ4RucqMmZR2cA6_Q@mail.gmail.com>
In-Reply-To: <CAC_iWjLy1E9wEW3zX2waN9mc=tz7PTKE0gJ4RucqMmZR2cA6_Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Dec 2023 17:48:44 +0000
Message-ID: <CAFLszTgqS9TF1F-RxO1dpZPZGG6QBiKm0n_e0yVHAume+xT3eA@mail.gmail.com>
Subject: Re: [PATCH v4] fdt: Allow the devicetree to come from a bloblist
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Baruch Siach <baruch@tkos.co.il>, 
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>
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

Hi Ilias,

On Wed, Dec 27, 2023 at 6:44=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Tom,
>
> On Tue, 26 Dec 2023 at 14:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:
> >
> > > Standard passage provides for a bloblist to be passed from one firmwa=
re
> > > phase to the next. That can be used to pass the devicetree along as w=
ell.
> > > Add an option to support this.
> > >
> > > Tests for this will be added as part of the Universal Payload work.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > > The discussion on this was not resolved and is now important due to t=
he
> > > bloblist series from Raymond. So I am sending it again since I believ=
e
> > > this is a better starting point than building on OF_BOARD
> >
> > I really don't like adding another option for "DT is given to us". Why
> > isn't adding another enum to fdt_source_t sufficient, and if we have
> > bloblist enabled, that will look for and use if found? Maybe some other
> > code needs to be restructured and cleaned up too?
>
> Same here. On top of that the bloblist has a few items in there, e.g a
> TPM eventlog. What are we going to do? Add a Kconfig for each item?

No, but that is just a straw man. The DT is special and U-Boot reports
where it comes from.

>
> This has been going back and forth for a while. I've lost count of how
> many times I repeated the same proposal, but here it goes again. We
> have OF_BOARD and BLOBLIST options. The bloblist and its properties
> are scannable at runtime. Can't we use the combination of these 2 can
> be used to imply we expect things from a bloblist. If we want to be
> stricter in the future and explicitly expect the DT from a bloblist,
> we could add a Kconfig option failing the boot if that's missing.

I would like to have that Kconfig option now, not later. In my mind,
the boot must be deterministic, so that if OF_BLOBLIST is enabled, the
DT must come from there, or it is an error.

Also, repeating it doesn't make the proposal good. We agreed that
OF_BOARD would eventually go away, so building on top of it is not
setting us up for the future.

Regards,
Simon
