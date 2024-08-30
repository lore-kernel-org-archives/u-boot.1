Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4109CA101A
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 22:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 533E688CFA;
	Sat, 31 Aug 2024 00:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WY0zoa38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A46288BFB; Fri, 30 Aug 2024 15:36:16 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB09388BBC
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 15:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e165ab430e7so1854932276.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 06:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1725024973; x=1725629773;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzet2kh29brG4zVVOjRpUNweZI7M1j6Rgxjui1gy+Fw=;
 b=WY0zoa38K9OMyWazBQOzcBOvO2gOLGJ0vcatiEj4+nGXQnDWbn4/pa8Es20rXTYKTl
 1CEwRd0bR8n00OYcRRjCHX2ZmHnGgjIeXuof2MSFGXC2dpwl3EMpAg/r7Sk6yQ6Wax/U
 SAl+uBLH9Sdw4bKDQJB+/weo0t/opuLejkMO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725024973; x=1725629773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pzet2kh29brG4zVVOjRpUNweZI7M1j6Rgxjui1gy+Fw=;
 b=Pj8w0La59wKtye5wf5M5EP4/ECXHSvnVFSfaa/t1sEwQmWNnTZ1n3HbAZTrhm8AoBX
 nu511Lx73uxnhBeXMkj8j4qTEgFHggtPEDykY7svVHPF4S2p5Ot6N6eZaLFthywnbHuZ
 m3QgKseixZ0LramZ7pN8qAde0V71e6iwiVx+NJCGgPq0eCtVBPFgorZT3yrfXoUPGtSJ
 qNRl9S9Zqkdfn0PI8lrI4RsFh7yc6xILZ/gJ5sTHZ/uMFEMqgwmikt0/SmNlA+ElF1I1
 XAC/fX5bEeJb8MbbikUktQGxf6oKkYPa3LpwGg/QOR+kRW+sPA3M6mYWBDX8yDWE0kFv
 Z3YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbU2rqkIojepaVPArPD7ANEHTZ7kYGBQeosnEBgvSxPgC4Is0rpKq6/VGNz4vicJ7fxCSMcfU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzq0detfhS+1kDFbpNn56DQ4rterOAU29DyO4g4PQlUW5gtiB6r
 IhCXrVSXXqBlxKylaZvL5gBE03jyWqtZ00d26pSJ3G7/C+VvxS4jAD4kf5gJeiBEoNpPxs9x1yb
 iC8tZEJOLV7GHpc4WsRDATsID+WK23h+SaVsDPQ==
X-Google-Smtp-Source: AGHT+IGGgTYivM0Qot11++GAJtn8n2eetm+qPX+ej1sx8HDVaGKd9omfGRFu/QxltFQCtgXYIVOa8HQpatNAox9Kf9w=
X-Received: by 2002:a05:6902:1b8c:b0:e13:c6ec:2a7d with SMTP id
 3f1490d57ef6-e1a7a1a1cdemr2637510276.37.1725024972852; Fri, 30 Aug 2024
 06:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240304161607.82759-1-marex@denx.de>
 <CAMty3ZB=s5ZNhgHZ2Q8vbzcvFCdO=62xHSY+dAeyr=y3ujkgWA@mail.gmail.com>
 <19a4f9fd-81c7-4ff7-a202-8f0f0c5857a9@denx.de>
In-Reply-To: <19a4f9fd-81c7-4ff7-a202-8f0f0c5857a9@denx.de>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 30 Aug 2024 19:06:01 +0530
Message-ID: <CAMty3ZD0e1N_AQVOn_eCNkQQusib64QannFfx8Edku57WZWrfA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Clear Winbond SR3 WPS bit on boot
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Hai Pham <hai.pham.ud@renesas.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Johann Neuhauser <jneuhauser@dh-electronics.com>,
 Simon Glass <sjg@chromium.org>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 31 Aug 2024 00:57:39 +0200
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

On Sun, Aug 25, 2024 at 5:58=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 5/24/24 6:05 PM, Jagan Teki wrote:
> > On Mon, Mar 4, 2024 at 9:46=E2=80=AFPM Marek Vasut <marex@denx.de> wrot=
e:
> >>
> >> Some Winbond SPI NORs have special SR3 register which is
> >> used among other things to control whether non-standard
> >> "Individual Block/Sector Write Protection" (WPS bit)
> >> locking scheme is activated. This non-standard locking
> >> scheme is not supported by either U-Boot or Linux SPI
> >> NOR stack so make sure it is disabled, otherwise the
> >> SPI NOR may appear locked for no obvious reason.
> >>
> >> This SR3 WPS appears e.g. on W25Q16FW which has the same ID as
> >> W25Q16DW, but the W25Q16DW does not implement the SR3 WPS bit.
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> ---
> >
> > Applied to u-boot-spi/master
>
> I do not see this patch in u-boot/master , was it missed ?

I missed it, I will send it as part of PR soon.

Jagan.
