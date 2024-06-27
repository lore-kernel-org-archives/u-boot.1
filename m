Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB269C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0430487F5C;
	Thu, 27 Jun 2024 10:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D+Gje5NR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D86E884A7; Thu, 27 Jun 2024 10:02:29 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 641E587E49
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-79c0bc8092dso226866485a.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719475346; x=1720080146; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VnceFawjZg561B1hOcHZoTALJW7KkWkfRbu5Qq6vuQ8=;
 b=D+Gje5NRox1vCLPbRrKuthKqHOgAjnDcYX5qujWmcjq8tDEfZjWg72gFMddkyefem+
 oIJTCWAtOk6g7mwZ88zN+mHwHlpluQjC0NefprtzICeFdPozor376NvDWuqQB6yfS8eG
 EVhpI+QohmYIQDgYFSZfUNaljbS+rK6ghy3Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719475346; x=1720080146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VnceFawjZg561B1hOcHZoTALJW7KkWkfRbu5Qq6vuQ8=;
 b=R8TiTF3FTxysaCwljw4iNeiDHETssc64dfBtDpr9FSmtIbMZIhgNtI1Li40zxzsQE6
 GI6tZ6VxZIGJ7rIZRHVpdM4FgJ1uLwGLgT3iw+AKIeNMpvq/UmGHd4FPgQSLXy1EUSJN
 CNDsUeMylDq0f1xbANdeMhIyiwOM1XayXK1LAjkJGKiJQyxvdwb+MbCB0bjd64qCXSsO
 4sBKwxUkMCRa400AzC4kX2Nci5LWm881SjAiFGcMOMQWspp6e/+G13sU6jYmBGL9ZqvQ
 j/IQwnV0A3obmRny6zWpw9PJA/W8erXm8CO092k3FXvyX2WgFQLPauUBJj8GEbFbAg9N
 ZKOg==
X-Gm-Message-State: AOJu0YwoUVLdq8nUZe++n2D3RzvhKdEKjdTUu2ixzBkU3D3caZzC6vUB
 sBTLUQD57ZAdsub/P2ClpePqo3ZFUOTd33hmkPYdevAvd/YQjBXIcqtKscoUXBAjfTRvCCqwbQE
 P3AW0XW5fwVZHwNxQhFs70bDT8Lbl8osr3Mfu
X-Google-Smtp-Source: AGHT+IFO+Ypggsbw74JhRjk1y+LjwTNPvBXXDQR2bM/i5meW/YYbvXv6x96+VFoEZthTZ/ZecqjXXmJF6qAzw5HiouQ=
X-Received: by 2002:a0c:ea86:0:b0:6b5:a98:44b8 with SMTP id
 6a1803df08f44-6b53643de93mr137428446d6.29.1719475346141; Thu, 27 Jun 2024
 01:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240626155945.278640-1-sjg@chromium.org>
 <20240626155945.278640-15-sjg@chromium.org>
 <e6df1db5-745d-4398-9207-7f08faa1628d@kwiboo.se>
In-Reply-To: <e6df1db5-745d-4398-9207-7f08faa1628d@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 09:02:14 +0100
Message-ID: <CAFLszTjRO7CypWHBLqHr2NW6YPjxdD+VxeUEWLXGfbiPE4kJ3A@mail.gmail.com>
Subject: Re: [PATCH v5 14/16] rockchip: Avoid #ifdefs in RK3399 SPL
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
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

Hi Jonas,

On Wed, 26 Jun 2024 at 17:16, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-06-26 17:59, Simon Glass wrote:
> > The code here is confusing due to large blocks which are #ifdefed out.
> > Add a function phase_sdram_init() which returns whether SDRAM init
> > should happen in the current phase, using that as needed to control the
> > code flow.
> >
> > This increases code size by about 500 bytes in SPL when the cache is on,
> > since it must call the rather large rockchip_sdram_size() function.
> >
> > - Drop the non-dcache optimisation, since the cache should normally be on
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v5:
> > - Move setting of pmugrf into the probe() function
> >
> > Changes in v3:
> > - Split out the refactoring into a separate patch
> >
> >  drivers/ram/rockchip/sdram_rk3399.c | 33 ++++++++++++++---------------
> >  1 file changed, 16 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> > index 3c4e20f4e80..b259e8e3dd6 100644
> > --- a/drivers/ram/rockchip/sdram_rk3399.c
> > +++ b/drivers/ram/rockchip/sdram_rk3399.c
>
> [snip]
>
> > +/**
> > + * phase_sdram_init() - Check if this is the phase where SDRAM init happens
> > + *
> > + * Returns: true to do SDRAM init in this phase, false to not
> > + */
> > +static bool phase_sdram_init(void)
> > +{
> > +     return spl_phase() == PHASE_TPL ||
> > +         (!IS_ENABLED(CONFIG_TPL) && !spl_in_proper());
>
> This still need to check for !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL)
> to be correct, else you must build with both CONFIG_TPL and
> CONFIG_ROCKCHIP_EXTERNAL_TPL or the generated SPL will incorrectly try
> to initialize DRAM.
>
> DRAM should only be initialized in TPL or ROCKCHIP_EXTERNAL_TPL,
> or if none of them are defined in SPL. All other phases should
> just read and report dram size.

Thanks for the info.

The reason I am finding this hard to understand is that
ROCKCHIP_EXTERNAL_TPL does not appear in the code as it is. So I
cannot figure out why it needs to be added. Is there a bug in the
current code, or does my patch introduce a bug, or...?

Regards,
Simon
