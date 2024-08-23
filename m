Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AF9C5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CF0D88B82;
	Fri, 23 Aug 2024 22:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l95d6J20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81ADD88B82; Fri, 23 Aug 2024 22:47:38 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D7188915
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6bf747371ecso10877686d6.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724446055; x=1725050855; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GsChpDflhMr6t6rqRoUQJASgX3wSU81OmifLCb0c1G0=;
 b=l95d6J20NIq5x0m73XeqQjEeyQ+guvlL1uOwk4AUnfg3XJ5ue751bniI1TQqjgYzDy
 K4loSbVtyS4XrwWVxjcXyQGLRuu1z+z4PpwDmn1CdS9eJC2WDphQ4ugObEVBC+MhMYj1
 BvCDiY3ON6NsUvMgPOpMmjKYbE2Gk6yZfgync=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724446055; x=1725050855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GsChpDflhMr6t6rqRoUQJASgX3wSU81OmifLCb0c1G0=;
 b=Ylz0xm9eCrlXlr/6myU7KbLGIiQzorhMus8IGNE1e9GwBtfOWyiPl6+X6OPE8K8HZd
 /yh7vWQ5S8DuKadobWDuuF0fPaL930Wh38Tuj/VO6PizK+/ZypF+8TV5DphXY5u4gOOp
 spiw+Meq/rUj0nNarxP9CBz8JX90iEMyaNPNRZRwRQEIyt6wQIIqPAN8SBbbvxwOHiyv
 iv6zYUGB4r3UFX5cZqVXLmVJymT5ool6W0z/JAtEjXTG6NdAZB2+STjosmnCHtGXNF48
 BJrSyRl/aQ+YPQ8bys5XjAV+hcBHF4u9FY6ToA4eleenSNbkSvilOJPa28oPowEdGBmu
 Xo0A==
X-Gm-Message-State: AOJu0Yx426Oltgx1V6HdvP+RQNU+opAoZYdSHJrpHHu7UXHFfG8hx/ku
 kz/xYaPnbnTyrhuOU6Agke3/nNdVApVMzKJr66S3/sLrGGPQAXLz1sNuO1ksEZHKNPN3N4YfCWu
 wlAbuSzQFzN9D7Ky+Mb5iE8bfHa5zlaMVvE2T
X-Google-Smtp-Source: AGHT+IGIrX0VbTPb6mwTrrpsn4s4+0rMQsq4PCzpCpPNHpLbe0K9RMVQyldIsU49gt8xIPcFc+EPPNMThjaO9+oWVxo=
X-Received: by 2002:a05:6214:3f83:b0:6c1:6b23:dc9 with SMTP id
 6a1803df08f44-6c16dcbd32cmr38483676d6.37.1724446055354; Fri, 23 Aug 2024
 13:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
 <20240821105839.2870293-17-sughosh.ganu@linaro.org>
In-Reply-To: <20240821105839.2870293-17-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Aug 2024 14:47:24 -0600
Message-ID: <CAFLszTizku0LVch5=XRUoz_DzH-nXc9-CXjNDN9-E7G9dTc6LA@mail.gmail.com>
Subject: Re: [PATCH v3 16/27] ppc: lmb: move arch specific lmb reservations to
 arch_misc_init()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
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

On Wed, 21 Aug 2024 at 05:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> All the current function definitions of arch_lmb_reserve() are doing
> the same thing -- reserve the U-Boot memory region. The powerpc(ppc)
> architecture, in addition, is making some LMB reservations for the
> bootm related image loading. Move these ppc specific reservations to
> the arch_misc_init() function. This allows to move the U-Boot memory
> region reservation to a different function, and remove
> arch_lmb_reserve() in a subsequent commit.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2: New patch
>
>  arch/powerpc/cpu/mpc85xx/cpu_init.c | 16 --------
>  arch/powerpc/lib/Makefile           |  1 +
>  arch/powerpc/lib/bootm.c            | 40 -------------------
>  arch/powerpc/lib/misc.c             | 62 +++++++++++++++++++++++++++++
>  lib/Kconfig                         |  1 +
>  5 files changed, 64 insertions(+), 56 deletions(-)
>  create mode 100644 arch/powerpc/lib/misc.c

Reviewed-by: Simon Glass <sjg@chromium.org>
