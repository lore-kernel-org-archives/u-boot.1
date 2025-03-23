Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7017C35FFC
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 00:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4145810FE;
	Sun, 23 Mar 2025 01:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xwj9W9ZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD72E81219; Sun, 23 Mar 2025 01:00:27 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8398080C93
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 01:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-301d6cbbd5bso5563925a91.3
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 17:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742688024; x=1743292824; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWWrnxZy3L4tX5nolPYRw2RmOyw+4A+v8Oz99o6Z2QE=;
 b=Xwj9W9ZUTAYQTWlKHeGylxfEqHSzrCyy/M7fE0M4SnpSEu4hInnp3O8QB2UhwP7mYi
 ri3qX5310m1uwJFLroVM+B7HMl9oClyyaAuihhI7UTcJM1PqqtM4alnzXdPvtuiiED+w
 2AsK0/sqqtgkaepOnF5dLf7fGKGPhw0RosJie7zi7P1Finu145I2YpySPJzsFKacNoFM
 lGMMHCb94UugzJ7UinLY87OQVF+RBubLLMxodsFKVqntSKRysKXYcDJqRW+eNidiCvnt
 vyzYHXlWwo43gstkGfJVW6U266djNV6ikzW1pc7kMxcD8+pXC7WfreBEL2zKMw+z+bpg
 ICPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742688024; x=1743292824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWWrnxZy3L4tX5nolPYRw2RmOyw+4A+v8Oz99o6Z2QE=;
 b=h46fl8uYdHKq6Q42ELov9UPmMPfk0sDmkk3yZDn4PH69Hcvk3D8O2lZd5FE+bRMoMm
 /205tX0MS6ykk+8nSOg+/2uLs+qPM8sSNu3mQt8twePxvDui7XPwowuc8x99QHzmBiqu
 d+bby2t4GDY2eQ6Y+YsSuBKB67SRYr2sLTO/2N9MXyuwMw2uJJM0GERcwZ4LNarLAEtH
 3Z8PJJb/vlA5oxwX1MjNOcJDhTciDp7T3ShoJPS7NqB/CAKDJjSb49nnhwQAjwfO0rQx
 7XeQXoqkrPY3aGmaAZhbUpeP7WCBLaTqNcjSPsxioqK4EOn0AumUZ0kseIAr1d2kg+yM
 pfuw==
X-Gm-Message-State: AOJu0YyS+E2Bt/9D3lumSy1P9BviB+4TyzvP+rdeExWwxLbfCLC1zuNo
 Gd4cSvooq8otiuMsDcyx0GTJSC5po11mxuqyW6qKXyg/Szm6+wHXD8/eIaYYiJXPCOY3A02puHZ
 iHr8+DDqM2NbhgI4HrU7D+jpMYlM=
X-Gm-Gg: ASbGncun7K+oyUznmuJlOhmreEPL4dMB6vdoyoXYq/hopEtkcQJsXjUc7E/qPtpPkzX
 YIESbAMNSW37KvTHGgrg8pugwtAvqwrUI/ru7w4YTaSCTf8Q1AlurPWWJpa7DaqjJcTSnIWzBv6
 27Du9tLwXLRUajMmexvQnm6JsTdA==
X-Google-Smtp-Source: AGHT+IE/UsLxi3vPrcxtt9r853rk/fGFRUYpreXssRhuAmsNzqSWY0vEWTbpYY/1vmi/D/y/MpyvjShAJ2eemvfxN3I=
X-Received: by 2002:a17:90b:17c5:b0:2ff:6167:e92d with SMTP id
 98e67ed59e1d1-3030ff111f3mr11565349a91.32.1742688023772; Sat, 22 Mar 2025
 17:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250322183812.784676-1-aford173@gmail.com>
 <20250322183812.784676-6-aford173@gmail.com>
 <e4d40a3f-d082-4144-8947-5fb523eeada8@mailbox.org>
In-Reply-To: <e4d40a3f-d082-4144-8947-5fb523eeada8@mailbox.org>
From: Adam Ford <aford173@gmail.com>
Date: Sat, 22 Mar 2025 19:00:12 -0500
X-Gm-Features: AQ5f1Jpw98-w4KQxSVt75YHoigZBW3ixjBBby12FkgTYOFgYoSCZv2PmnrOKXZo
Message-ID: <CAHCN7xLJ0dB3Du62A5pOrAYFjSXnaf=CG-SdLKn4Kfi5csUXpw@mail.gmail.com>
Subject: Re: [PATCH V3 5/6] imx: imx8: Imply CPU_IMX by default
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, festevam@gmail.com, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Yannic Moog <y.moog@phytec.de>, Gilles Talis <gilles.talis@gmail.com>, 
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov <w.egorov@phytec.de>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Mar 22, 2025 at 6:31=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> On 3/22/25 7:38 PM, Adam Ford wrote:
> > The imx8_cpu driver is a CPU Driver that supports the i.MX8Q
> > family. When it is enabled, it acts as an alternative to
> > arch/arm/mach-imx/cpu.c, but the imx8_cpu supports the driver
> > model where cpu.c does not.  Imply this newer driver by default.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >   arch/arm/mach-imx/imx8/Kconfig | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/mach-imx/imx8/Kconfig b/arch/arm/mach-imx/imx8/Kc=
onfig
> > index 9a43beda6fa..257c14e61b6 100644
> > --- a/arch/arm/mach-imx/imx8/Kconfig
> > +++ b/arch/arm/mach-imx/imx8/Kconfig
> > @@ -9,6 +9,8 @@ config AHAB_BOOT
> >   config IMX8
> >       bool
> >       select HAS_CAAM
> > +     imply CPU
> > +     imply CPU_IMX
> Shouldn't CPU_IMX select CPU ?

It does not currently.  Right now, it depends on CPU being set.  There
is another Kconfig option for CPU_ARMV8 that also depends on CPU, and
I would prefer not to change both of them.

adam
