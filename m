Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD813C369D9
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 08:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B949812BC;
	Sat,  3 May 2025 10:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iWJ5yRQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB72381F0D; Sat,  3 May 2025 10:37:22 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A212F810EB
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 10:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e5c7d6b96fso5009992a12.3
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 01:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746261440; x=1746866240; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uCdhwnCpsBriWaR9FA4Ma4axmASjb7CyH/xtYAq09Es=;
 b=iWJ5yRQZn7wSXGjdnj3uskTXaymXW97OU6o8w4DBdtIP2BDpaaJttZ7qOAPO5PEPm3
 fyL/FH0EbAkcpP6L5eOVEWxdULaNRVqwiAJ7BUCKlcjr2pLPEEQYDobhwrm0a5Al72DS
 Ep533vuwfFPzDizBvya2gwz8lI0JhnyNGGbtUo1gczMofmf+yKWaQueihqTSidvDN1XL
 OVMKlkKx50uxoMsXLwBpbIuveqK6NtktpdJQXoosg/0oWjGP/huNnqQEbyLmP6/7VUlK
 x1De2KV6MQ66FRug1RULM3FXsTVSNRBtsfTbpKwA/IW4HFdi9468mXwLxZ2AIDYGj6E+
 YS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746261440; x=1746866240;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uCdhwnCpsBriWaR9FA4Ma4axmASjb7CyH/xtYAq09Es=;
 b=cEWnuTS2sCLiIlTquKp/tIZ9ymMhX9cOu+sZgMIolsSOLwhrtNfiSeAYlkPxhXfFBf
 Xu2sGcKxLMK4gYLQjkj5jjMCx5xbTbCiG9OKDkdBB3Ye7G4/s7j4lFft3PbukCf4dP8Q
 w5sr8i/hhR1Xm57tQ5xpG9Ir48Wmd1avXGcmnfz4YauEbEqxMGb7wApfqAxoQunLqk7F
 VjWTAx9I4cP1FoYA8w5lxKwaFdkZSWCpyZP+vMObY3ddjSOha9DJnm7EBl4ZtwIB5BH6
 j52QOjtE+lUk7l31dIsWg90fnpsQZjCUm/84Ut825Nkfej8gO2KoeafZizC9W34598kj
 ab9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsmQrZA+ysxo2mNoJd0etH4xjz/laeFCZBNcH2foUwOZ7/hlkv/GNh3sEnB5iCUGair/Kuoi0=@lists.denx.de
X-Gm-Message-State: AOJu0YxSDYz0LhCPLALvXQkBcglqssSKfHs9OzFf1OHSK+0Z1Gtt3XED
 WGXQ4hrU573bs1VBPKbdrBtqQM/+XSfrZ1+51qQUFb5Z5Nn0wYCc/OJ7OFgMKhwcGjcH/GV+6RJ
 F6gHcRxAWW1PUunN6qFDmOmEwsS0=
X-Gm-Gg: ASbGnctn/6p6zWE0+xb0Te5jgC3lD8/9LGTEFHXzaiF74VvbotqW4iQUyKue4+mAfxi
 ZLea3f/vqiacE8CsLNhOiB1VRvbXCccqLikIHwLOeAvlExPm3wJTICCuoyhv5R8qZe+SHntXdmE
 vQJe0gMr5nD9UrWZJzbuxGO06hh52z1eufNduJXQRoCk5VWusl+fDkTM4=
X-Google-Smtp-Source: AGHT+IENy/EFJ4uSCjia3mDw5hPCHyVYoeN+qsstbKmwMT8wXBNrAGow79Plz36aL/Tn+6H0v9CyF6FaWMiGoOlNn4U=
X-Received: by 2002:a05:6402:2709:b0:5f1:e466:660 with SMTP id
 4fb4d7f45d1cf-5fab056d2a8mr359046a12.5.1746261439808; Sat, 03 May 2025
 01:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250502144718.313633-1-sjg@chromium.org>
 <20250502150035.GU1261075@bill-the-cat>
 <CAFLszTiic_fp=etd+t8OCiEy8=yWdrwEAp8XNChFecbpXVJ=aQ@mail.gmail.com>
In-Reply-To: <CAFLszTiic_fp=etd+t8OCiEy8=yWdrwEAp8XNChFecbpXVJ=aQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 3 May 2025 09:37:08 +0100
X-Gm-Features: ATxdqUHSnZ1M0ldBy7X6iObEOtPUH6mxeywxvwF-zggEMzYgXYNJBcnlxDfbTtU
Message-ID: <CALeDE9N3d+paBv3gp=JnBt5E02XAs0cZjT701h3Yf7fxkWopOQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/60] expo: Various features and improvements
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Simon,

> > > This series collects together some new features for expo to make it more
> > > useful for boot menus:
> > >
> > > - measurement and display of multi-line text objects
> > > - internal alignment for objects (e.g. centred text)
> > > - editable strings in text fields
> > > - new 'box' object to draw a rectangle
> > > - highlighting of menu items, rather than just relying on a pointer

Each of the 5 sections above should be a separate patch set. A patch
set should be on a single topic, as soon as you feel you need to add
the term "collects together" you should be splitting it up.

> > > Expo's boot menu is restructured so that it is possible to iterate
> > > through various bootdevs and update the menu as new ones are found. This
> > > is more in keeping with how bootstd works.
> > >
> > > A new textedit object is added, intended to provide a simple text
> > > editor. Future work will complete this.
> > >
> > > With this series the boot menu has a better layout and appearance.
> > >
> > > Changes in v2:
> > > - Add new patch to pass in the video device for cedit_prepare()
> > > - Add new patch to test rendering a lineedit
> > > - Add new patch to test editing a lineedit
> > > - Handle the case of an initially empty string
> > > - Only check the text objects used by the bootmenu, for now
> >
> > ... include the 13 part series you asked me if could go in now,
> > yesterday?
> >
> > > Simon Glass (60):
> >
> > 60 is far too much for anyone to provide meaningful review.
>
> This is expo and no one commented on the previous series, so I'm not
> expecting much feedback. But once people start using it, things will
> come up.

Well a series of 6 patches just goes straight into the trash because I
don't even know where to try and begin to test it.

Peter
