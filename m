Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDA0C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8833E88CD8;
	Thu, 29 Aug 2024 17:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lBOkLqZy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BAFC88C35; Thu, 29 Aug 2024 17:01:20 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D7C888CB9
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6bf9db9740aso3880716d6.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943677; x=1725548477; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dwZK4ivQc22rJVxY7RV1GIH/Fp8I0xiU6mEtr/9MaRQ=;
 b=lBOkLqZy4P4K1r/0G6k6LNduK64Xxu/OfhkkLID1GIxfMh73Mltt6b8nAmUqo0lAp5
 meqABaRtLtbX9TB+5Ea7dMES7T0BM8yMjg3X7iolecAOFGz25cexLU/i1w5FBUAOPca3
 QVRNihlR9UutVTsPshtpQA+6dFngbYqR61REM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943677; x=1725548477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dwZK4ivQc22rJVxY7RV1GIH/Fp8I0xiU6mEtr/9MaRQ=;
 b=a5UVoZXtZP221rWJdLrVnDpX23opL33Mg7FAWa3+B/zPjJ1w63Ph4aN0rpYUatp429
 eUprgirpnC4yo5rn4i00/lnVgxMABIsKqwHUVhYhElFxO9Zuta/VkgZWmMliAnLrPUt6
 d12hoSKfWMsWgJCDvFq47hQHd09ISIRUmkLnKHxxiVY6JZmWjysDRG+qhRHWk4sg0MJJ
 g68bQknMmiw1GwXvZdMBGa6DwpuoKDLH6kVj+aRZ06BHVjw7xGHgq1Aw7kfzCNBtFIVx
 DtnAnUKGNMpEO5dnwQna6Mmp2qiwM77juYPDOQUr0kuVGRgPmGSPu02L4UWiBvbzpqi0
 8NbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtw3c/vShqakoXpz1X1HCpL7/uvEVXujmzBKlN4+BZRY+2KJvxl4xB5XEor0TDSygDnG9Umj4=@lists.denx.de
X-Gm-Message-State: AOJu0Yzuj5HEK4vWcuiuwOelujkmrbl5yimh3boZHCCSfzTL+FppnX3O
 ZG+LHoSpM+KC3P9bE3pthrmXrECEe+rsjZTogkNGAFggMvKXQM8JsDTRe7asDVNsY5IutHmHwSw
 a8+oekbo9f1sK5mQjeV2FHMPxmefWtWE+cq7W
X-Google-Smtp-Source: AGHT+IGqDYHnAQlf+hYrc+XKfhV9CKiiCDXpo3ihIoQ6saxGnFQFQdbpuGi/jRE766pkHpwh61/3J6PPGy1DWsvbtPE=
X-Received: by 2002:a05:6214:2e42:b0:6c1:6aa0:c21 with SMTP id
 6a1803df08f44-6c33e615b3amr37697666d6.3.1724943677061; Thu, 29 Aug 2024
 08:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240724150922.2343249-1-sjg@chromium.org>
 <20240724150922.2343249-13-sjg@chromium.org>
 <c886cdcb395e842d179144e5fa1d8b0de41127d8.camel@siemens.com>
 <CAFLszThiF=rbpCgVEc+D+R2xqP9jX2i_BiaRwdc2MkaNBDf2fQ@mail.gmail.com>
 <20240829142830.GY2479150@bill-the-cat>
In-Reply-To: <20240829142830.GY2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 09:01:06 -0600
Message-ID: <CAFLszTgVCxdPdLWio2CibYXQphvBdPn1HMMoRpsQ4xmVhoSWbQ@mail.gmail.com>
Subject: Re: [PATCH 12/35] global_data: Convert have_console into a flag
To: Tom Rini <trini@konsulko.com>
Cc: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>, 
 "peng.fan@nxp.com" <peng.fan@nxp.com>, 
 "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>, 
 "vitor.soares@toradex.com" <vitor.soares@toradex.com>,
 "clamor95@gmail.com" <clamor95@gmail.com>, 
 "sbabic@denx.de" <sbabic@denx.de>, "afd@ti.com" <afd@ti.com>,
 "ion@agorria.com" <ion@agorria.com>, 
 "marex@denx.de" <marex@denx.de>, "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>,
 "sean.anderson@seco.com" <sean.anderson@seco.com>, 
 "noreply@example.com" <noreply@example.com>, "Leto,
 Enrico" <enrico.leto@siemens.com>, 
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>,
 "mk7.kang@samsung.com" <mk7.kang@samsung.com>, 
 "devarsht@ti.com" <devarsht@ti.com>,
 "yangshiji66@outlook.com" <yangshiji66@outlook.com>, 
 "jonas@kwiboo.se" <jonas@kwiboo.se>, "danishanwar@ti.com" <danishanwar@ti.com>,
 "francis.laniel@amarulasolutions.com" <francis.laniel@amarulasolutions.com>,
 "nm@ti.com" <nm@ti.com>, 
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>, 
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "festevam@gmail.com" <festevam@gmail.com>, 
 "raymond.mao@linaro.org" <raymond.mao@linaro.org>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>
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

On Thu, 29 Aug 2024 at 08:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 08:05:35AM -0600, Simon Glass wrote:
> > Hi Alexander,
> >
> > On Fri, 16 Aug 2024 at 07:08, Sverdlin, Alexander
> > <alexander.sverdlin@siemens.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Wed, 2024-07-24 at 09:08 -0600, Simon Glass wrote:
> > > > We don't need a full word for this boolean value. Convert it into a flag
> > > > to save space in global_data.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  arch/arm/cpu/arm926ejs/mxs/spl_boot.c |  2 +-
> > > >  arch/arm/mach-exynos/spl_boot.c       |  2 +-
> > > >  arch/arm/mach-k3/common.c             |  2 +-
> > > >  arch/arm/mach-k3/r5/sysfw-loader.c    |  2 +-
> > > >  board/siemens/common/board_am335x.c   |  2 +-
> > > >  common/board_f.c                      |  2 +-
> > > >  common/console.c                      | 14 +++++++-------
> > > >  common/spl/spl.c                      |  2 +-
> > > >  include/asm-generic/global_data.h     | 17 +++++++----------
> > > >  9 files changed, 21 insertions(+), 24 deletions(-)
> > > >
> > > > diff --git a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c b/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
> > > > index 76a69d7f958..dd748328293 100644
> > > > --- a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
> > > > +++ b/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
> > >
> > > [...]
> > >
> > > > @@ -219,7 +210,7 @@ struct global_data {
> > > >  #endif
> > > >  #ifdef CONFIG_TIMER
> > > >       /**
> > > > -      * @timer: timer instance for Driver Model
> > > > +s     * @timer: timer instance for Driver Model
> > >
> > > an unintentional change?
> > >
> > > >        */
> > > >       struct udevice *timer;
> > > >  #endif
> > >
> > > the rest looks good to me and you can add my
> > > Reviewed-by: if you remove the above chunk.
> > >
> >
> > Thank you. I'm not sure where that came from, but it seems to be gone now.
>
> I fixed this up manually when applying (and added the tag).

Thanks!


- Simon
