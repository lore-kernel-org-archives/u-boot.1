Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CD5E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B421E80690;
	Thu,  9 Jan 2025 16:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kIfOXocr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E56780658; Thu,  9 Jan 2025 16:01:39 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F16F0805EA
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso176808266b.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736434896; x=1737039696; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gDDF+xJeGaFhkExgsyONSQn/rtISCgmZhBYZQt13AKc=;
 b=kIfOXocrTEPT+mk3tyuWsKtTNXyMFvnlYWK1sBQfLwXXVWiqWJAeZ3w0/mz5jSppEW
 eZBI5l+V20e7y/v5PhD9Z/bx35YB8BvNbSonHbNr/yeWY8zJ71Zj6ixAWFoWNmdva8KP
 jhYr4TJnjy6IIhfk492Vrcu0VHBerMSyH6ohE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434896; x=1737039696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gDDF+xJeGaFhkExgsyONSQn/rtISCgmZhBYZQt13AKc=;
 b=Q8poe7BGaDX8l5zYa6bq4Rz09iYJzF9tjlayJ4S7EI6yg66qVJiVqEW8LAm/IoJZq5
 QG3nwwcHZWuURTZkKL2XizYBrUvpyeqj/FYj5YYvjI8OkXDD8GS64Hom9yZDy7xtziHb
 A8gbuTrmrY1ZNOULWKvZL2t2PaYCsSQJehlh0Tn9a4JLOE2KE+3HNId0B97/caSSosB6
 0xCCYpD6y2i/pg1XZGg6PI5cHflxa0egl3vOUD0U9Wt2pmaBqHQiUXeVFKvaGU6xWlZ9
 cI7ZUxlUk5vyY0++THqRcnTRAuCwopFHR5t8KUNUlYoB4dM8nR6oCIcDWpYHlxY5SF1z
 mtqw==
X-Gm-Message-State: AOJu0YyogRDa9JtUhflf2fwArGAy1csYISJFvooX3MEV2iKwwQhmOg99
 ZGOFFPZxtE0vFhgpsMlGLYhvYfbytREojGFXOo83vzY56PUSHZCl/T9+ouI+DA9Ddhems70PzwV
 7vXFbPISXdmH2/MaUCl66wEyyZP7EvJBZgWct
X-Gm-Gg: ASbGncuCCYhkCqskrX8He8FlKDhcpZYdD14GYa4AUApGyvvYRMNULwm7NDAo4BvEdo9
 cxYxrRmQoOI2z4ebNKun9wX+NJ1ooKO94NOpuUZA=
X-Google-Smtp-Source: AGHT+IHLSBKg7+Zp5jfpIiVngfb9V54uIpkp5gy63d0Te4Ar7Fcpaa24pB1v/G4HGBg88iUnU451fsjaadRTPXgoR5Q=
X-Received: by 2002:a17:906:f58c:b0:aab:740f:e467 with SMTP id
 a640c23a62f3a-ab2ab67061amr529411066b.8.1736434894298; Thu, 09 Jan 2025
 07:01:34 -0800 (PST)
MIME-Version: 1.0
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-22-sjg@chromium.org>
 <20250106214025.GB3476@bill-the-cat>
In-Reply-To: <20250106214025.GB3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 08:01:22 -0700
X-Gm-Features: AbW1kvbb9qCUvWbIR7y3i5s8lPmbeUs0KnpuVTI3yKIRmgEgOXYleUvddjWEi8g
Message-ID: <CAFLszTjt3mr+ZZF0SmKdhDKsT8khmLG8NNsTnmWSXbX9+ei5=g@mail.gmail.com>
Subject: Re: [PATCH v2 21/33] emulation: fdt: Relax condition for
 OF_HAS_PRIOR_STAGE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 =?UTF-8?B?TWFyZWsgTW9qw61r?= <marek.mojik@nic.cz>, 
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>
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

On Mon, 6 Jan 2025 at 14:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 06, 2025 at 07:32:17AM -0700, Simon Glass wrote:
> > QEMU always gets its devicetree from the OF_BOARD mechanism so we should
> > not depend on !BLOBLIST here.
> >
> > The logic of PRIOR_STAGE is quite a mess, unfortuantely. We should rely
> > only standard passage to receive things from the prior stage. QEMU
> > should implement standard passage to provide its devicetree to U-Boot
> > However Linaro has blocked my patch to provide devicetree additions[1],
> > so little breath should be held in respect of either change.
> >
> > [1] https://lore.kernel.org/qemu-devel/20210926183410.256484-1-sjg@chromium.org/
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: 2b71470628c dts: OF_HAS_PRIOR_STAGE should depend on !BLOBLIST
> > ---
> >
> > (no changes since v1)
> >
> >  dts/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/dts/Kconfig b/dts/Kconfig
> > index 41a758e83a6..fc25a854708 100644
> > --- a/dts/Kconfig
> > +++ b/dts/Kconfig
> > @@ -191,7 +191,7 @@ config OF_BOARD
> >
> >  config OF_HAS_PRIOR_STAGE
> >       bool
> > -     depends on !BLOBLIST
> > +     depends on !BLOBLIST || ARCH_QEMU
> >       help
> >         Indicates that a prior stage of the firmware (before U-Boot proper)
> >         makes use of device tree and this board normally boots with that prior
>
> Since OF_HAS_PRIOR_STAGE has no prompt, it shouldn't have a depends line
> either really. I believe 2b71470628c is part of an attempt to say that
> if you have bloblist enabled then that's how the previous loader needs
> to pass the device tree. But indeed that's not quite how to enforce that
> kind of demand, so we should just drop the restriction here (and some
> other time fix the "imply OF_HAS_PRIOR_STAGE" to be "select
> OF_HAS_PRIOR_STAGE" because it's not prompted, imply is the wrong
> keyword.

So, just drop the 'depends' line?

I don't understand all this prior-stage stuff and I believe it is the
Wrong Direction. We should just say where the DT comes from.

Regards,
Simon
