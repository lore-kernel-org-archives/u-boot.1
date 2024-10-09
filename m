Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5353DCF042E
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 017D089001;
	Wed,  9 Oct 2024 03:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W2xNKgCP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0A3E8912F; Wed,  9 Oct 2024 03:57:26 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB5E89001
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbc5d17c2eso8076556d6.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439043; x=1729043843; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F7QeoXT5Jm0nt55+9qFiRGQ+C3e1YeSxeORar2I+wwA=;
 b=W2xNKgCPpqwZf6HlRuFz3vUVcJp0RJkg7XeUVLzWF6khuUC9Y0j6c+YJN9MpAo6HR8
 bweuRo8/na7JxxqyRa54OMH5DGuCfbJbAJRGgZIUycW26nnUcyFmf+8REbiAz5zBvULJ
 u7hGSJEpGbW8Rxj4qM9zT930vjbl7MIsgkrdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439043; x=1729043843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F7QeoXT5Jm0nt55+9qFiRGQ+C3e1YeSxeORar2I+wwA=;
 b=i16vXND8vGmnyrv3r/qvoBJgx2w5kg1quR/DV6vcPm9Ai0UEHmNfLTza6JEFdQuqWu
 Rnoma1jAUyN/twkpSMKPXFwjUPCguOARY9I80BvLAakTnQi4a0CEXdAQRbZl7pr87v6M
 sbRd3RE9YjG6feyDrS2Miw1kCwFHcDsG+UyP4M1HU1Itm03PzYmvzBH0YS/+H2s8UL0l
 J4a3fuQMCRe6Ef1DU9m1MnThFMv/z0Gnoq794PgUK4kKoC1+1kxvc2IazmrUwB3jcKRD
 BvytULJ562R/8cif0nvne47elmkINpavBJt4hsmxUpVZ+rcbfQNFRjyf+8V9T2nR4wwB
 VcXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3dt1RJSf12hFDoDyU1nCi2QEpNavX9Is6+/IMhpT3oXTUMUgimVGp7OcDlH6GvYKCNKoZ+o0=@lists.denx.de
X-Gm-Message-State: AOJu0YyjluIQ+BFCek++8n4TLCAHy5KtYuBRQIovhw1vWEW4Lj6oJXtL
 hZ/eaV0ZOhal2SlMNl3ihVnDZN4RZkdxlys37GlSpygjbr0UZzPaR2RYLYtiSuyv69VeQmK45f1
 a5JXzBDaHEVTrMBg5rBVvFavMaEQrdTRO2uNABQ9JDo8Yp7kW/g==
X-Google-Smtp-Source: AGHT+IH2qnmvHUKeHoW6qMX/vvPTVL8sBGuHNz/6x9q9hiUa2xLC9EPvLXX5hOvo605Jify8B9yd7oL8v7ppmJ/KkZ0=
X-Received: by 2002:a05:6214:3983:b0:6c1:6bf9:8fea with SMTP id
 6a1803df08f44-6cbc958ea99mr16220776d6.50.1728439043492; Tue, 08 Oct 2024
 18:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
 <CAFLszThMT+kN_u=ch-6m+3Ja615PwYjHd_La2KRhOzktXD21jg@mail.gmail.com>
 <20241008044825.w6ldvvoibk5zrk32@uda0497581>
In-Reply-To: <20241008044825.w6ldvvoibk5zrk32@uda0497581>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:57:12 -0600
Message-ID: <CAFLszTinZSXJQ8WbmKXP4j3wqXLZK9-tdM2jngan8N6RgRLtNg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Add AVS support for J721S2
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de, 
 Neha Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, 
 Aniket Limaye <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
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

Hi Manorit,

On Mon, 7 Oct 2024 at 22:48, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> Hi Simon,
>
> On 09:23-20241007, Simon Glass wrote:
> > Hi Manorit,
> >
> > On Fri, 4 Oct 2024 at 00:24, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> > >
> > > This series adds support for AVS on J721S2.
> >
> > What is AVS? You should write an abbreviation out in full at least
> > once in the series.
>
> Totally missed this part, let me take that up in the next revision!
>
> But basically it is Adaptive voltage scaling. This allows us to run
> our CPU with the optimal voltage for that particular silicon which would
> have been written in efuse during manufacturing itself. This helps in
> saving power during runtime [0]

OK thank you.

Regards,
Simon



>
> [0]: https://www.ti.com/lit/pdf/spruj28 (Section 5.2.4.1 AVS Support)
>
> Regards,
> Manorit
>
> >
> > >
> > > AVS Test for J721S2: https://gist.github.com/manorit2001/b2fd9f6764a863294d4aa0755c83c84f
> > > Boot Test results: https://gist.github.com/manorit2001/15e45f6c421aeeb93effde023a537762
> > >
> > > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > > ---
> > > Changes in v4:
> > >
> > > * Udit
> > > - Use the compatible for finding the node rather than alias.
> > > - Remove debug print
> > > - Add ret value in error prints
> > >
> > > - Link to v3: https://lore.kernel.org/r/20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com
> > >
> > > ---
> > > Manorit Chawdhry (7):
> > >       power: pmic: tps65941: Add DM_PMIC dependency
> > >       drivers: misc: k3_avs: Check return code while programming AVS
> > >       arm: dts: k3-j7*-r5: Add MPU clock in clocks property
> > >       drivers: misc: k3_avs: Extract MPU clk and dev ID from DT
> > >       arm: mach-k3: j721s2_init: Initialize AVS Class 0
> > >       arm: dts: j721s2: Add VTM node in R5
> > >       configs: j721s2_evm_r5_defconfig: Add AVS Configs
> > >
> > >  arch/arm/dts/k3-am69-r5-sk.dts                  |  3 +-
> > >  arch/arm/dts/k3-j7200-r5-common-proc-board.dts  |  3 +-
> > >  arch/arm/dts/k3-j721e-r5.dtsi                   |  3 +-
> > >  arch/arm/dts/k3-j721s2-r5-common-proc-board.dts |  9 ++++++
> > >  arch/arm/dts/k3-j721s2-r5.dtsi                  |  3 +-
> > >  arch/arm/dts/k3-j784s4-r5-evm.dts               |  3 +-
> > >  arch/arm/mach-k3/j721s2/j721s2_init.c           | 10 +++++++
> > >  configs/am68_sk_r5_defconfig                    |  4 +++
> > >  configs/j721s2_evm_r5_defconfig                 |  6 ++++
> > >  drivers/misc/k3_avs.c                           | 40 ++++++++++++++++++++++++-
> > >  drivers/power/pmic/Kconfig                      |  1 +
> > >  11 files changed, 79 insertions(+), 6 deletions(-)
> > > ---
> > > base-commit: 3a0b829efc35227b1079a444f00e0729502197ad
> > > change-id: 20240130-b4-upstream-j721s2-avs-8c187d3fe26a
> > >
> > > Best regards,
> > > --
> > > Manorit Chawdhry <m-chawdhry@ti.com>
> > >
> >
> > Regards,
> > Simon
