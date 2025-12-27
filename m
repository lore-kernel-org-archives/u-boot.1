Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98301E8FDD8
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 14:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F1683C2B;
	Sat, 27 Dec 2025 15:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Upp9lmNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A693C83BFE; Sat, 27 Dec 2025 15:53:08 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D7383B82
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 15:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-64b8b5410a1so8924695a12.2
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 06:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766847186; x=1767451986; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SeJLfneYah9dCnn0KBMCQwwgjiG6aMsAjhA61aKpfLY=;
 b=Upp9lmNW+Js0KMZxRVdkn4cjahcKkcy/e2Ogj31Q+GHgIRs0HkeN9E7gH4AkgBvYAS
 yOZqk7hLlNkxMwvtf9qJvxY9G4D+lfBvs4SU65UJx4W6K2K0BVziFpxNjlsfToWQ+PJf
 nDejvee/zl3KJ+YNoYhM4zIfp3h4+qouyt+SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766847186; x=1767451986;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SeJLfneYah9dCnn0KBMCQwwgjiG6aMsAjhA61aKpfLY=;
 b=si9Hx+zdIiVLiPFY0k2eQzFaTFwG9sY/y0/6VSk/SPnxo9gXBUHneazWdz261H3kFm
 XKeRNXAHRZjTRr6qj51IrIVa7Cezc+4yLMYf2oeBhUO37xjt9HmDDoLTJclBJ9idvCXQ
 RqK6LPxKHhVjzSEjURTimbSS+dwz58JR8qMi71P7490/sAP5iBg9l/TOt7ZqHR3AAvP7
 4pmqWaslRaVQG7o+pqpTkUSPuCZmT/Q+Ih0TfMYxeFIjzpBchbfuPZTqGHHnis1juR9c
 XU/AFcD/FCT162GMvWscxKlb0PhUhaO4fr5uOahuXYwkrx69cUy/UqOTPwNe7AemWbG8
 xFtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe7ARHCSnAgngCdAGvVjqYpuJk2pnJGjpBhyWCVPdS+D+PmPuHyz+gYysq8m1biMegq0n5+fU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzl78aF19J/Neriiml+CSNho4e8bKOcfg/NdLXFir4EiYXiJ3/s
 HDeMl402cWD2p+by2CAIEqe9TBPwcIMTc86j3kGLgeRIAvlkNFtw3JaCiJ20WZdsqJ1cA0b5Tvs
 f3IWhWy+emeKsS9HFLa6Z9IepJSkFfzJiskgb4nwC
X-Gm-Gg: AY/fxX7H5qm/xf3Gk5oOnu6ZRB1pVAC+gWdtNcUCNzIRgiz+W1iGATUdcYna5jxyCXw
 bcmZdGlgPjnXYyNWW92FwUebGHWmYMiYgkqGWc7gGpVff2fOmhs9oxClEQp36NbED894bXCkpcC
 UUYzWPV5aNpzKXY1FVU1xD5He2pCqaX7vPeeSqsZUP7Qp1u+0XOW3MhvzeTrvymy1fOdyMLE6GT
 a2gO3/xFydJE7JFsJTKHPF7WfzB079jbci7hckdxz10H0ClKjrQOZ3HuI+AJOwCiYs9nw==
X-Google-Smtp-Source: AGHT+IGmeI6HZGfbgHNPaxew31syklhceKKYo+KrD1AsWNQ5x2/utsJ3HUZfzfeat/CVXkslylKDguGr7ZvwDdp1+oY=
X-Received: by 2002:a17:907:1c0f:b0:b83:3715:530e with SMTP id
 a640c23a62f3a-b83371556d9mr540773866b.11.1766847186076; Sat, 27 Dec 2025
 06:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20251212-kconfig-reorg-v1-0-72441d8cc53c@cherry.de>
 <20251212-kconfig-reorg-v1-4-72441d8cc53c@cherry.de>
 <0617453d-7d6b-4d76-96c4-6ebebf4c9da1@ti.com>
In-Reply-To: <0617453d-7d6b-4d76-96c4-6ebebf4c9da1@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 07:52:38 -0700
X-Gm-Features: AQt7F2oy2y9brdVU2bURNf3LgkXGJN2T-9h9voDMKGANolGQ6Xpk2JWAnhw8x8k
Message-ID: <CAFLszTgCBx+O_niLBjmQfmbxaALCV-UVtrM6f0R-sBb-qs-EzA@mail.gmail.com>
Subject: Re: [PATCH 4/8] boot: fix prompt for VPL_LOAD_FIT_FULL
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Jesse Taube <mr.bossman075@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martin Schwan <m.schwan@phytec.de>, 
 Anshul Dalal <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, Ye Li <ye.li@nxp.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Justin Klaassen <justin@tidylabs.net>, 
 Samuel Holland <samuel@sholland.org>, Rui Miguel Silva <rui.silva@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Sat, 13 Dec 2025 at 00:07, Kumar, Udit <u-kumar1@ti.com> wrote:
>
>
> On 12/12/2025 11:43 PM, Quentin Schulz wrote:
> > From: Quentin Schulz <quentin.schulz@cherry.de>
> >
> > The prompt wrongly specifies this applies to SPL while this symbol is
> > for VPL, let's fix this oversight.
> >
> > Fixes: 8dfbd798122b ("boot: Allow use of FIT in TPL and VPL")
> > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > ---
> >   boot/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 3e882d3f4f9..dc6988aca71 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -361,7 +361,7 @@ config VPL_LOAD_FIT
> >       default y
> >
> >   config VPL_LOAD_FIT_FULL
> > -     bool "Enable SPL loading U-Boot as a FIT (full fitImage features)"
> > +     bool "Enable VPL loading U-Boot as a FIT (full fitImage features)"
>
>
> Thanks for catching it
>
> Acked-by: Udit Kumar <u-kumar1@ti.com>
>
>
> >       select VPL_FIT
> >       help
> >         Normally with the SPL framework a legacy image is generated as part
> >

Reviewed-by: Simon Glass <simon.glass@canonical.com>
