Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AE7D711BF
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 16:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0CDF8877E;
	Wed, 20 Nov 2024 17:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bj3dLWAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A009C88F6C; Wed, 20 Nov 2024 17:03:48 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 045118877E
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 17:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7f8c7ca7f3cso4405259a12.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 08:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732118624; x=1732723424; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DgpgChuc8e9+ElgqW7fbWzvMXWowjfyr5Q+LP4Adqrk=;
 b=bj3dLWAD/zwaYtT/raMJWvVDSGvvyI+9GwbidCd0y7J4W/RCtBs2X0nUZTj784l/Wj
 Zr5TWJ3n6ny3LVsKZzulz270vJmNILvCfu8lsKOgE+nftj4eF6/popV+MsSGbNCnLGNP
 2lhGqydrhE+RUBoF64vJUoSuGI4KgDIrkla+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732118624; x=1732723424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DgpgChuc8e9+ElgqW7fbWzvMXWowjfyr5Q+LP4Adqrk=;
 b=je38O6b12qhGpGTgVKEngpfXXTcC93tsEzaz2hFoBL3YhpuC6SEnAGi8rnjxY3QjMf
 Sxh3Fn/qz5klWpDUR6ztfsmXbSJIwoFXPxN5t3PaDloOAEAK8VK+WmVTSCMcZJkZidud
 mnRSaJ+IeNQd1cDYAXmbF3PrAtg49hILaiXAYLhWnP3Z7oHLxNGbv/Lq7mhRdLKbRAQC
 0Qgpe/Yg6aPLFxOxy66CkswBdvKHqtUhOQA2sZqKLNfgcqFiL3HvOQd9d57PZui4C642
 cx7w5JAJvAaBaTwJKV525JMwKnyv/kWppeXML0dKtAbxPX/31aV9OiHQJQF0mnKYhqQu
 eo8A==
X-Gm-Message-State: AOJu0YzGpqJNtdtoUYgDUoj7ryUXHGLgYr0a67h475WLUrD8Mfarj4jx
 pZegZZDtQQ3xELQQjiIfo2li2VHRkCczLrdhSJUPqLr5BpDb5qRWnz6HEQfb9vTsRGV6Ew9RHW2
 xyHqRGmZk3vLdQgS0m+EgEcrF0Q8KlwgNiZvH
X-Google-Smtp-Source: AGHT+IEKgk/JwusdxqbxAoKJ4f9LVwlODJeMKBwmQxx5Ufm/hgDwglpm2jhQu17RWmPYBigPoHB+LDxtS5hqOzrFrIE=
X-Received: by 2002:a05:6a21:168e:b0:1db:e0d7:675c with SMTP id
 adf61e73a8af0-1ddae5df808mr4723007637.13.1732118624459; Wed, 20 Nov 2024
 08:03:44 -0800 (PST)
MIME-Version: 1.0
References: <20241120153642.861633-1-sjg@chromium.org>
 <20241120153642.861633-4-sjg@chromium.org>
 <460f478d-62cc-4f17-8d52-00d2e1e83485@linaro.org>
In-Reply-To: <460f478d-62cc-4f17-8d52-00d2e1e83485@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 09:03:30 -0700
Message-ID: <CAFLszTjzZQ=Uaw+wjHUeP86SaHppYBMa3ZPSpFAoBwG9jJfEZw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] common: Move autoprobe out to board init
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Svyatoslav <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Caleb,

On Wed, 20 Nov 2024 at 08:51, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon, Marex,
>
> On 20/11/2024 16:36, Simon Glass wrote:
> > Rather than doing autoprobe within the driver model code, move it out to
> > the board-init code. This makes it clear that it is a separate step from
> > binding devices.
> >
> > For now this is always done twice, before and after relocation, but we
> > should discuss whether it might be possible to drop the post-relocation
> > probe.
> >
> > For boards with SPL, the autoprobe is still done there as well.
> >
> > Note that with this change, autoprobe happens after the
> > EVT_DM_POST_INIT_R/F events are sent, rather than before.
> >
> > Link: https://lore.kernel.org/u-boot/20240626235717.272219-1-marex@denx.de/
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
>
> [...]
>
> > +For some platforms, certain devices must be probed to get the platform into
> > +a working state. To help with this, drivers marked with DM_FLAG_PROBE_AFTER_BIND
>
> I've found the documentation around this flag lacking, and the
> implementation confusing. Here you say /drivers/ with this flag (which
> would imply I can add it to the U_BOOT_DRIVER() definition, but further
> below the function doc says /device/ with this flag.
>
> In practise, it seems like the flag has to be added to the device in the
> bind() function, and adding it to the driver definition doesn't work
> (this left me scrataching my head for a while). The commit message
> adding it explains this and it seems like the idea was to have a way to
> trigger probing a device from the .bind() callback.
>
> I don't think I'm the only one confused by this, since grepping for it
> reveals two watchdog drivers which set this on their U_BOOT_DRIVER()
> definition.
>
> I can only see one driver that ever enables this flag conditionally,
> that's the ARM PSCI driver. Every other user sets it unconditionally in
> the .bind() callback.
>
> Would it make sense to rework this into a driver flag?
>
> Otherwise, could you document this behaviour more explicitly in this series?

I agree with you and I very-much want to document this better.

The original patch[1] came with no documentation nor tests. It was
applied within 5 days, after Sean raised exactly the same objections
that I have with this feature. Those objections were overruled and the
patch was applied anyway.

So here I am trying to clean this up.

As to the driver thing, my main concern is that it is too easy for
people to add the flag, causing a large slowdown in U-Boot's
pre-relocation startup speed. Perhaps the solution to that could be to
enable bootstage everywhere and report the time in the banner?

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20220422131555.123598-1-marex@denx.de/
