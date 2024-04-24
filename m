Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CCCC4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 14:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD54886AB;
	Wed, 24 Apr 2024 16:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BJHZIsGa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 552D5886AD; Wed, 24 Apr 2024 16:33:41 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C59BA886A4
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 16:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e3ca4fe4cfso49611055ad.2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713969217; x=1714574017; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KA/5X3Cpd7v24I7WxWPHI9IKKirQMGXLP0DeTiGsga0=;
 b=BJHZIsGa32MTiv2S6jo52Efz2SJxmww5Je/Q1yN0n0hvmpWd3n/6ebuJz2javf9jKC
 +IYYjGtCpNwm3stxtlZZRfgn1IHRtRjSgur//mRj5Jgfgiv6n+8lpZx4SaJSpyDnZ+GR
 V6/gL9CUFX4Mo6+0BSuwRuD2y5i6NmUJRoV0RQt3pvLu1sQQ9qc8ikJvDNhbsIPDfSoo
 rLISdYqePLUyGe05mWwigWhgHpiZrOgy/5P5SOqdD/WayMp5O5oLl54BK3Byg3IxHBa5
 cSx8eyc74XTBJBjKRiZLfkxAiiNlUZ8GILCBs1Y3jv2QbGwQsnoBW1UQhhS1hqJeUPJu
 GtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713969217; x=1714574017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KA/5X3Cpd7v24I7WxWPHI9IKKirQMGXLP0DeTiGsga0=;
 b=nuSLcJ/ZDhekTWb+hdkRDt1F7nzXEg+PTMZIPqA0h6elIh5LDgBMI7wKJCPD4zSArO
 loomMZ/oY9AVY/fhDeHOIqmKu6qDFL47NTNI08l9w/HOgbXoxnEpWxrZtyhwA70XTpm1
 Mg+Zw6MvUx5DG6ZUeAbD0jnMbhtevA4NaY2Q2rYwzKfKBqqU52aOAAGeq7YKqfwT9jwp
 Tmnzhel6C030gSJo/6AZWkrH7xMT8nrLtjCejUJ+nXr/ZtnCVrk7pPV5GWJyya/L6Y2/
 LTH5CR1+PZdhYP7ZpswoUC76yH+kmf5Iv1Ios3hg3NdWXtuT0JU97myCaQHoUIqwYsfg
 /lqQ==
X-Gm-Message-State: AOJu0YyOhMs3MBj8oyPJAeUt6BGlmcB6Oh2IO8P+3M7saBX2daAILMd4
 bkc9k4dXi9oAXz/9KogRhvcB24g3JHWXiNk5JstuPWBjJWYZk3H+Qoadtu/vNOUmxFagEHjBS5M
 oirmTAOnIlFK6WeYPHU7grSaN8ao=
X-Google-Smtp-Source: AGHT+IFptKKY5CGrkP/kiYC81TPd0UvwOoQeIB/dnBflZNKqtXleD9s6Te/nkmCefK74FX8KrLYiB3zWhiCT/CnmOhU=
X-Received: by 2002:a17:90a:7e8d:b0:2af:2dce:707c with SMTP id
 j13-20020a17090a7e8d00b002af2dce707cmr2212753pjl.35.1713969217097; Wed, 24
 Apr 2024 07:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240404030031.4726-1-aford173@gmail.com>
 <20240412000539.GM2493117@bill-the-cat>
 <CAHCN7xJRkUYCQkF9Lvm1PcpcoTjcqJy9fZAfcP=2ebRJsc2E9g@mail.gmail.com>
In-Reply-To: <CAHCN7xJRkUYCQkF9Lvm1PcpcoTjcqJy9fZAfcP=2ebRJsc2E9g@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 24 Apr 2024 09:33:25 -0500
Message-ID: <CAHCN7xLdDeiEaX2AKPk5_zT7PSYk3+eTNNZND1QS5n7U+FJCZA@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm: davinci: Migrate da850-evm to OF_UPSTREAM
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, Andrew Davis <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Martyn Welch <martyn.welch@collabora.com>
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

On Tue, Apr 16, 2024 at 6:53=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Thu, Apr 11, 2024 at 7:05=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Wed, Apr 03, 2024 at 10:00:09PM -0500, Adam Ford wrote:
> >
> > > The da850-evm can remove the U-Boot device trees if migrated
> > > to OF_UPSTREAM.  This means pointing the device trees to the
> > > ti/davinci directory.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > This series leads to failure to build for omapl138_lcdk and lego_ev3 or
> > was I supposed to bring in something else first? Thanks.
>
> I just got back from 10 days in Europe for the Embedded World
> Conference.  It should have been based on [1], but I haven't checked
> to see if it was applied.  I (maybe wrongly) assumed [1] would have
> been applied before this patch was.
>
> Once I get caught up, I'll look to see what's going one.
>

Tom -

Can you point me to a failing log for this, so I can try to replicate it?


adam

> adam
>
> [1] - https://www.mail-archive.com/u-boot@lists.denx.de/msg505123.html
>
>
>
> >
> > --
> > Tom
