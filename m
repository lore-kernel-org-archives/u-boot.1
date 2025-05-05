Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EA5C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 19:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC9EF828C2;
	Mon,  5 May 2025 21:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZG5N23po";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D03B28215B; Mon,  5 May 2025 21:16:48 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 894D68215B
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 21:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5f4d0da2d2cso9555949a12.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 12:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746472605; x=1747077405; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5uHlyP+uY/Snsd9VevsoOJ0b3zqi/86VLnwaSvTGO7M=;
 b=ZG5N23po/XNrjRvIjAybJ5OmH1plwUSGmTAcpprgoJReziZdS5zn5rQPAwF+YrKjs3
 Z466lOLL40fo7q247gkABa80AyLKWTidvd/Z/3G3j2rOmdzCiRT3cBScH0+7u58C6p5L
 YbxkW9+VXxK7h8fx5qzNR2JPc7nEnYj+YbFYZ2HHmLpm4HtqZC7EqZxIvAKxOD0b9iZ4
 cQPl7HXMTSFdoGjq7ucAl10pVGpJfWUmaM3vdheF9sOE+vrqdP+mQxwAl9lDg5y+fe/+
 DejPtxD7bJllx2IndpCZdQdpViXUChn3lsIqsthBzK3eOM6f/aaTgr7c7KzS0Rp2gGgU
 Ifkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746472605; x=1747077405;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5uHlyP+uY/Snsd9VevsoOJ0b3zqi/86VLnwaSvTGO7M=;
 b=rIvoE5Ais1ho4rhEpI3Dhlam+NcLIdYDZ4cjXGsZ4BzCzpaLmplegfuzaqjqkIxvpD
 A3XD89qtK+6j/a58Uojy5Ebh/bsNh+DQPvwQw1HFwcE/PpmUL7WO+HrxBt85BsylJ2ww
 T9eOeSE7ZgGsgcNNyOd6CnJc3TcDEBN4nt7Ol8N21A4+y21+c1sO9T3xGgQwIbk1rQOM
 YIDvuh3AaUZIu+x5qr9hwYVGJ1KV1nSpg2iG9UxrxvxtELPbaZi/u0USIYqV8SxTt6yT
 KyhwlpZdKh88GozJvt+3eaXtKOu6OuftYvkCFzDocxgmWPyr0EYxgpwOwTVLm81rTZ6g
 ZWjg==
X-Gm-Message-State: AOJu0YwcqnfVxQdVCmYk+5SZGkxRtnz1+zdbI6A8Ha9HNmooovCt8d/M
 KABvEBMqI7owXpEfHgi6qwzgeV7rGq+3gHZOEXzcqawKc9RMxa75w9qrYzKwYysx1qYZzWkMvuV
 Wd9329Z2c8Y1jRos6WYlXQsBKzTQ=
X-Gm-Gg: ASbGncswtSdCImYiQ/okMsZxbhz6ghI3FsQHcNa+ID5mHGrc2QES6V3Qx+AsuZJVWv2
 SQqZmLminaFz1o4EYIK81PRymS5TEdccHK27qk5r2ghuXl0Jjz0wPo1Y6eoAl1PFEw93/+FjqRa
 fWjvC7hnfQkKDAMWDu6ca0VpB3V9pJGLrTRx/SWG3VwJkDGiJMW/yredofIRhGOwzTyQ==
X-Google-Smtp-Source: AGHT+IFTwWli0gdfF0UDwuK3w6PMbF887plJd4zkXxhjqBINg3q076xbnMC3G18D2I6oMfDzy/MeMZV/JBzneKZdvOM=
X-Received: by 2002:a05:6402:2812:b0:5f3:4ac5:9bc0 with SMTP id
 4fb4d7f45d1cf-5fb70a6ab81mr162613a12.25.1746472604632; Mon, 05 May 2025
 12:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250502201226.1369013-1-trini@konsulko.com>
 <20250502201226.1369013-3-trini@konsulko.com>
 <CAJaLiFy-fRjCr+bWbL8VmTjbqno6LZRB764=7mA81qz+OGOXmw@mail.gmail.com>
 <CAJaLiFyksNRAfY-Drh+hWO_XW6Zn4n=ZQo7LdNAkeRAt9RT8_w@mail.gmail.com>
 <20250505135030.GL1261075@bill-the-cat>
In-Reply-To: <20250505135030.GL1261075@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 5 May 2025 12:16:31 -0700
X-Gm-Features: ATxdqUERtoehXh_E1FTohGwaMn5F9oBfw9nm4j553k4HA7nvnH6xyfHsY86iOaY
Message-ID: <CAJaLiFygUb_zWrorCTr615wvPNvuBAJAtRuzHOPNjA99cUv1uw@mail.gmail.com>
Subject: Re: [PATCH 2/2] global: Convert almost all remaining non-DM_SERIAL
 users
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>
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

Hi Tom,

On Mon, May 5, 2025 at 6:50=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, May 04, 2025 at 03:42:24PM -0700, Tony Dinh wrote:
> > On Sun, May 4, 2025 at 3:37=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wr=
ote:
> > >
> > > Hi Tom,
> > >
> > > On Fri, May 2, 2025 at 1:12=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > > >
> > > > This converts almost all of the remaining non-DM_SERIAL users to en=
able
> > > > DM_SERIAL. These are platforms where there have long been other SoC
> > > > boards that have switched and so it's been a matter of inertia keep=
ing
> > > > these from being converted. Do so now.
> > > >
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > >
> > > The Kirkwood boards (not sure about the others) also need to have
> > > CONFIG_SYS_NS16550 enabled after we removed CONFIG_SYS_NS16550_SERIAL
> > > and CONFIG_SYS_NS16550_REG_SIZE.
> > >
> > > Here was the patch:
> > > https://lists.denx.de/pipermail/u-boot/2023-January/507221.html
> > >
> > > [PATCH] arm: kirkwood: Use CONFIG_SYS_NS16550 with DM_SERIAL for Kirk=
wood boards
> > >     arm: kirkwood: Use CONFIG_SYS_NS16550 with DM_SERIAL for Kirkwood=
 boards
> > >     CONFIG_SYS_NS16550 is required when DM_SERIAL is enabled for
> > > Kirkwood boards.
> > >
> > > diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/=
Kconfig
> > > index 45cc9326368..b19ed2c6b3e 100644
> > > --- a/arch/arm/mach-kirkwood/Kconfig
> > > +++ b/arch/arm/mach-kirkwood/Kconfig
> > > @@ -15,6 +15,7 @@ config SHEEVA_88SV131
> > >  config KIRKWOOD_COMMON
> > >         bool
> > >         select DM_SERIAL
> > > +       select SYS_NS16550
> > >
> > >  config HAS_CUSTOM_SYS_INIT_SP_ADDR
> > >          bool "Use a custom location for the initial stack pointer ad=
dress"
> > >
> > > So we need to either add SYS_NS16550 to each of these defconfigs
> > > below, or select KIRKWOOD_COMMON for each of these boards in
> > > arch/arm/mach-kirkwood/Kconfig:
> > >
> > > SBx81LIFKW_defconfig
> > > SBx81LIFXCAT_defconfig
> > > d2net_v2_defconfig
> > > dns325_defconfig
> > > guruplug_defconfig
> > > ib62x0_defconfig
> > > inetspace_v2_defconfig
> > > nas220_defconfig
> > > net2big_v2_defconfig
> > > netspace_lite_v2_defconfig
> > > netspace_max_v2_defconfig
> > > netspace_mini_v2_defconfig
> > > netspace_v2_defconfig
>
> Ah OK, thanks. Can you please prepare a patch to select KIRKWOOD_COMMON
> for these?

Will do.

All the best,
Tony

>
> [snip]
> > BTW, I will submit a separate patch for the DS109.
>
> OK, great.
>
> --
> Tom
