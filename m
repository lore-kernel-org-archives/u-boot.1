Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E5BC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 17:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4183887B9;
	Mon, 29 Jul 2024 19:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I2Wcm2bN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDEA884CA; Mon, 29 Jul 2024 19:22:03 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A5988271
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 19:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7a1e1237e9aso220769885a.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722273720; x=1722878520; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v12gAM2mqxIPHv2QCzrMf3EC/ir7nggW+8Mw/zKQuSA=;
 b=I2Wcm2bN7Qp76DotVBt2GY2sUQkm05Wqoq2+23pLofRU5oozudvUdMvu/V7Eb+MU83
 Q8HRo93ElNKA9liWQlJa0ZbwcRJe3MV8PQ1Ffr+WTi7CtO8NoIF0La3vafqjVr8XfpC2
 wBaeqWLATYnePb/q39I09vJE26of8+ta/lU6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722273720; x=1722878520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v12gAM2mqxIPHv2QCzrMf3EC/ir7nggW+8Mw/zKQuSA=;
 b=IBc+PXG9PvaCEEP1iY9+tPUVt4hDbEJc7XfAzR5eakDzN8dsi2/+/a+nSOFo5U9+A9
 ITIZy17ET8pRsErvTeN/l0+b3C2yvTMv/QIW3eF+lcnF2M7WteCwptdvNJ3cddBDvtxZ
 OrcXDq043R3FLaEG85zEUkz7krxWYeKr6k/ktle/hajIAlS78K9M5jrXDffDfSEdXKUv
 EjQQwqmcTo+D/6krW7fYY3dQb0XT9lE9hIcNYOyofuD9NJlweQenhcoKGJA79b+xvW+g
 zjstY0ffAZl8M/A850VZ3IxYuYHpM64AJGHLPisI0cxj0GS3aCXVk4LBJmJ2Wcz0O31b
 G0IQ==
X-Gm-Message-State: AOJu0YyI/xjrjTqjIVHYg0S2bZ1gNxbPDy1E6+YCAijef7kTM1Jnayq2
 qqM4tOn6TSPMbl6qGl0VmpFv5j4s49o9U1AYJ6hTsDq12c7r642dQgyvFB0IitdUf62qWD1dBjG
 v1a0j9AN9pOCHPBZEuPDurNRB80NFh4ZdSPgtPGcRrtOdun0=
X-Google-Smtp-Source: AGHT+IGxcNFxkJSIAb/gk+u0DRuk6kZgF8gEwhEXl+1O5fxBhJafXRYbApBq+qUAWP4mz+kDajCnIvDpVH52Q7yjxCg=
X-Received: by 2002:a05:6214:29ce:b0:6b7:aeb2:e796 with SMTP id
 6a1803df08f44-6bb55a1367amr110682786d6.33.1722273719964; Mon, 29 Jul 2024
 10:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <0b24ac9c0f40ba2410529ee6e0ffd603c9453cff.1718275638.git.chris@arachsys.com>
 <CAFLszTiwfVg7o+Rhf10U2exgUA-vJ4V_A-2L75ZLpwJ8sW=9Kw@mail.gmail.com>
 <CB131E81-078E-43FF-BE67-90D7F48EDB2E@arachsys.com>
 <CAFLszTggwpCnhZ0xaPR2n=e+x+PDe-wP4WxnPE60BqyF1ms3UA@mail.gmail.com>
 <43228DC7-4184-4C63-9BBA-65F056ECC91F@arachsys.com>
In-Reply-To: <43228DC7-4184-4C63-9BBA-65F056ECC91F@arachsys.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 11:21:49 -0600
Message-ID: <CAFLszThCz2NL+6svYMRD7qAHHNN8frWzrM4tyhDbuS77M3jUHg@mail.gmail.com>
Subject: Re: [PATCH RFC] gpio: Fix probing of gpio-hogs
To: Chris Webb <chris@arachsys.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
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

Hi Chris,

On Mon, 29 Jul 2024 at 10:45, Chris Webb <chris@arachsys.com> wrote:
>
> Hi Simon,
>
> Simon Glass <sjg@chromium.org> wrote:
>
> > Well, yes, mt7981_pinctrl is wrong since it is not actually binding
> > the GPIO devices until it itself is probed. It should do it when it is
> > bound.
>
> Oh I see! Yes, I can see the mtk_gpiochip_register(dev) in
> mtk_pinctrl_common_probe() exactly as you say.
>
> > Better still, those GPIO devices should be in the devicetree and bound
> > automatically by driver model. But, sigh, I see that there is no
> > compatible string in the gpio subnode of pinctrl@11d00000. It should
> > really have one and avoid all this pointless code and problems.
> >
> > mtk_pinctrl_common_probe() is misnamed, as it actually binds and then
> > probes.
> >
> > So (unless Linux allows a patch to add a compatible string) it needs a
> > new mtk_pinctrl_common_bind() (called from mtk_pinctrl_mt7981_bind())
> > which calls mtk_gpiochip_register(). Then you won't need to add your
> > dev_or_flags() into mtk_pinctrl_mt7981_bind().
>
> Yes, that makes complete sense. Many thanks! I'm very happy to write that
> patch and grab back the physical hardware to double-check on if you like?
> (Or equally happy to leave it if you'd prefer to fix yourself?)

OK good. Please go ahead!

>
> Presumably it needs to apply to every mtk soc that uses
> mtk_pinctrl_common_probe() as they'll all be affected by this problem.

Yes I suppose so.

Regards,
Simon
