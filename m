Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A191C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D22D687DEA;
	Sun, 21 Jul 2024 12:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QKQbrT4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AF0687DC7; Sun, 21 Jul 2024 12:08:52 +0200 (CEST)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8480D880F8
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4f51981b1beso203759e0c.2
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556528; x=1722161328; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DlfUiYsPf5zlW15uGXcV1orXOFGoHiZRibNL1BC7xF4=;
 b=QKQbrT4tL5uz50/A1aJMPHaXN3pEhctsTPraSbHXNvDDkPo/9qmOx4qUnmn5owXbBY
 R3bZfnhaQX2I4anpJ2KARLRckZPCMTjMgdb6obzaEXkCTM4DgvpNVl7N5+P/90Rwtdti
 Ib5jc44RXHnwGxv5aWR3rfZmnKBYvSEnoYYwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556528; x=1722161328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DlfUiYsPf5zlW15uGXcV1orXOFGoHiZRibNL1BC7xF4=;
 b=pxM4divSOG6FPc/s8AwXje/hYUQ9Y0tHDXBNFgrCMOqrFn6nE8/odn6QHh2E9MneIR
 PT5PpTbAl6lqHYpCTsmgKaYkib0DlrGuXIxxXBYl3vdvL+4az0yVnN+Dk3eSW3KTXbTm
 7f6fKROULQHveBf9Kosq/qWcshjYvcYKz7T8bSIRXa0j09KLjKXIkgDQoMynOc9TvG0U
 ZnzmibyllFmZD70oqDHQRDxCnUkFJ7et51K2J0klw2uC5nzHTQuDDPuu8II3/hR7GIo6
 sD6VYhB03LA3YBh2ZhciZnAGWsJfylxoehPkxPJzP8pnw35lh42verFDAelvOknQSVS9
 +ROQ==
X-Gm-Message-State: AOJu0YwKfPFU/CX+u4NGo1cpWC6zb58udCzcggjV3bsCjsDbz35QvU/z
 9dstj0YU+6+MEGquhJh/fxJCH3TyHbH+3DWaCHaEDwitVlQJZdj8448+C921A5MM8bxFuNYPgiU
 kCpEUROxcFUZeR1WCC6XUIejCG3tjBEexp311
X-Google-Smtp-Source: AGHT+IFc7biNyc5rYdukI6kdvCi6mrNVEHNfy0/JZ8rPAZS0wa9e/ksuWtKtSn15frAByo9emFsOd+dBxNCJ1ctiWyc=
X-Received: by 2002:a05:6122:4105:b0:4f5:1787:18aa with SMTP id
 71dfb90a1353d-4f517871c9fmr1659280e0c.0.1721556528343; Sun, 21 Jul 2024
 03:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-14-sjg@chromium.org>
 <b3b642fd-fbf9-50e1-cc6b-8c52b551fd54@gmail.com>
In-Reply-To: <b3b642fd-fbf9-50e1-cc6b-8c52b551fd54@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 21 Jul 2024 11:08:36 +0100
Message-ID: <CAFLszTh+aEqdajNRq=6Y=w=3NPAocL4nL3Md-cohjXVAvVJ5-g@mail.gmail.com>
Subject: Re: [PATCH 13/14] spl: Create a function to init spl_load_info
To: Sean Anderson <seanga2@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>, 
 Chanho Park <chanho61.park@samsung.com>, Fabio Estevam <festevam@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Maksim Kiselev <bigunclemax@gmail.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Walle <mwalle@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>, 
 Stefano Babic <sbabic@denx.de>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, Xavier Drudis Ferran <xdrudis@tinet.cat>
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

Hi Sean,

On Sat, 20 Jul 2024 at 17:11, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 7/20/24 02:17, Simon Glass wrote:
> > Rather than having every caller set this up individually, create a
> > common init function. This allows new fields to be added without the
> > risk of them being left uninited.
> >
>
> What is the code size impact of this?

I don't see any, e.g. for socfpga_n5x_atf (which enabled
SPL_FS_FAT)and firefly-rk3288

>
> IIRC the reason why I didn't do this is to avoid growing the code in
> cases where priv is unused.

>
> Although in some places there are memsets which should be removed anyway.

Yes, that might be helping.

Regards,
SImon
