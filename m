Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AC8CA0EDB
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 04:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCEFB88A24;
	Fri, 30 Aug 2024 06:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ElK9Owbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70B2088D2F; Fri, 30 Aug 2024 03:06:40 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CB3E88D3E
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e04196b7603so1282551276.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 18:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724979995; x=1725584795; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cf6M2F1tvjJqxEb+pYLNuivDpwq+/7lDx8MKI/Cb7ak=;
 b=ElK9OwbwaYvl/Kx17D+HD4PavwpAr7cwe8TBAd0kKXNagiVWc4pfSLQhO+fmlGSsJl
 v3HSXMOWNOsvij3roA2MtuwH6Uii/jY8fuq3U2jBH299IesafjOqUpoUqHSQyN5LoVOH
 IwHEa8h4OONcjmfRJ7/snsfHJbzlT4uvWuFWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724979995; x=1725584795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cf6M2F1tvjJqxEb+pYLNuivDpwq+/7lDx8MKI/Cb7ak=;
 b=WSbhg1Uda9FyLkmqNR1AM57vuYijlqGzaj8t2NWtfxXFQNqTQqqTX69Qtx7kMWag3Q
 hzQpzBZxvCFy0EFRV7Mqw7HaWwMJ0qSnjHBEGb6ELJ+aDtLI7WroyDhmqFa0GvmV5PY7
 C0nyWMPW/7cOX2QdvhD0WJKqR2NVnQAiN1X6JQAGDol3aG4XA4Htpu7LACgdxzZvtOnL
 Q+fElumFR0D6EN+NgzCIYiP78pr9vkZBpRg8G4w1VbY7oHWjKLQfN6NUrcyOqyYEx2RT
 CZ85LuXrxSTIKHoKaB657fXRiK7fPeaQgfWR+/uKNGeWk2o3haS2SwQWogphmyBMVXRw
 GdGA==
X-Gm-Message-State: AOJu0Yy6IhI8hCqF8FujGEu1eM5TAjWIwRJhvLb9LaqOJdoERSYBYekY
 QS2gHsI17/wphF1Emds3aGXkuUc2qi6bqaSGWPDdJvWyexlJv6fngjH73ppm//9/MhgQNIwDF75
 sG12nOVhmRpLCojcnXp7t8X8dmb9aWgI3hfaY
X-Google-Smtp-Source: AGHT+IEycXiGkAfq6gvly4OV4Uy6IAGlzUioEGQ2r2aHPUFAG8/2yegyUDjp34ueqq6nTRSRd9fZdhEo8YtZt+dFn/c=
X-Received: by 2002:a05:6902:11cc:b0:e13:d399:38cc with SMTP id
 3f1490d57ef6-e1a7a1a4dc8mr609611276.45.1724979995256; Thu, 29 Aug 2024
 18:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829183257.GN2479150@bill-the-cat>
In-Reply-To: <20240829183257.GN2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 19:06:24 -0600
Message-ID: <CAFLszTgzAZKzzTspccw2_ax5K6WWkgNA1h_8D9sD17SqPVN-hw@mail.gmail.com>
Subject: Re: [PATCH 00/19] vbe: Series part E
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Chanho Park <chanho61.park@samsung.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Eddie James <eajames@linux.ibm.com>, Gary Bisson <bisson.gary@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Julien Masson <jmasson@baylibre.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Nam Cao <namcao@linutronix.de>, Paul-Erwan Rio <paulerwan.rio@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 30 Aug 2024 06:39:05 +0200
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

On Thu, 29 Aug 2024 at 12:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 08:57:43AM -0600, Simon Glass wrote:
>
> > This includes various patches towards implementing the VBE abrec
> > bootmeth in U-Boot. It mostly focuses on SPL tweaks and adjusting what
> > fatures are available in VPL.
>
> A lot of this series makes me really want to stop and rework how we
> configure / build things. Having say ZLIB, SPL_ZLIB, TPL_ZLIB and
> VPL_ZLIB really isn't good.

Yup and I had a solution or that a year or two ago and it died.

Any revival of that, or new solution will have to wait until VBE abrec
is done. I hope there is only one more series after this, then a small
one for the VBE thing itself.

Regards,
Simon
