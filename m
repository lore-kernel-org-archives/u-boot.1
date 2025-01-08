Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57465E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 16:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 954FD800DF;
	Wed,  8 Jan 2025 17:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QDBYdQN/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 888AD80196; Wed,  8 Jan 2025 17:27:50 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD608006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 17:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aafc9d75f8bso1995666b.2
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 08:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736353668; x=1736958468; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aue52UTo0kszhaewfQrVQasYHqLrOykV77aVz107J1k=;
 b=QDBYdQN/IqzJ84ePUn+xAk8ZDAdpzd+lB02oDuDPWg9JTUQBRzP8NphfXrTOzmU8hT
 FCLXVpXaMiatDwG/diLPObHGsDmpw4ADHGkn2viv/aIFUDxOynjYIcGdNB2qm4B5FRFK
 gSBt5aPFzA77IkGqOM7kVq4TwPR3aaokZoXQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736353668; x=1736958468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aue52UTo0kszhaewfQrVQasYHqLrOykV77aVz107J1k=;
 b=QzsjLRCsvFljLfutw1AI5LOtgTwnJ0hp1e1VwniFEztLAeQUFFMJvQ4RvVTLRIkUWz
 yRVikENrYrS74oArBjZwNJ4SX+V9vGnPmW3fGiqovacCE1JaUlBaC6x7oLVIi7dQkjec
 EFg1Nc2CkmY1JTkbrTwrs2UoAYVXjW8aGjJWFdr4dq/sbqsOm3fBc78dGvDxKYic+QZ3
 25Hpl69w+APVygm6zKugEAqN3USwNk6s2MFSXu4XY0vPu77xj+qzbST+zCiryMG05ptM
 BML2LzyCWoJGsFupj3uaGwyq81D8pU3DQq3GwdIg7lAJ0nbYYR90FP0AW2Tb6CiBjmR4
 EYYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAWTbHfQOmS1vA/NxjkzdsaSlVJ9LA0NhxJ8N+ujTUa175KzsgS7tQbIVNt8hTuKO2S4WrM+I=@lists.denx.de
X-Gm-Message-State: AOJu0YxEddWUTePitUDJXtntdxUJoQVxp2AbdHk183KrdaQjAg2Qxgi9
 sHsdRTNe2PVjZXyJFaYBekaDxKbjSzUm5N6K9WlXc4Ia+Y9AoS1FX5hVBjqN4tLwKgRNLP2lDiV
 0Jj3lHGOIv+73QwHfh5HZ3bPlo1EOHXRr9vO7
X-Gm-Gg: ASbGncuZM8lteBiNooOJWbFGYpqSA8dChrd2cIgHCBrqqpFLx2oTC+PCEPnbvSENdUG
 O68L7S7mOL8mtZyd00jiZGdgcU1bNZnCywUq3n5U=
X-Google-Smtp-Source: AGHT+IHBMOdSl+iFyY8O4oi5liUx4M4P9gWWLIkMTG+4vYl7RJ/BjP3Yx/Tv9rbe+dobGYWVoOiBEEDEDYGNtOzn980=
X-Received: by 2002:a17:907:c10:b0:aa6:77e6:ea3d with SMTP id
 a640c23a62f3a-ab2abc92415mr286810966b.45.1736353667789; Wed, 08 Jan 2025
 08:27:47 -0800 (PST)
MIME-Version: 1.0
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
 <CAFLszTi_px3qRGvpcC5WKLw+r5BqqQciOP-Vg1LEN+rt9876wQ@mail.gmail.com>
 <20250106013311.GA8414@localhost.localdomain>
 <CAFLszTi2ya3V4SDfpZxLzzyAdyM9KN0MGuZPnK2XeO8wRNw69w@mail.gmail.com>
 <PAXPR04MB8459B6A69CA0713B0B51058988102@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAFLszTg8UHbgHnFM-6JjYFK5pd_+HW61_jzMM-eeV9+hQgOspQ@mail.gmail.com>
 <PAXPR04MB8459A3864AB97715CE45D52B88112@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459A3864AB97715CE45D52B88112@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jan 2025 09:27:35 -0700
X-Gm-Features: AbW1kvZCeEzhCmeqvu5i3vlzcMp0zR_xGYYJ3erWlVIvnpQUcr-VuuFJW9yeVGI
Message-ID: <CAFLszTgCOrdjVMne9=cMqf568+QPXXYSfHK7n1tOsnSdsW2Wxg@mail.gmail.com>
Subject: Re: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1 EVK/QSB and
 i.MX8M EVK
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Peng,

On Mon, 6 Jan 2025 at 18:40, Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Simon,
>
> > Subject: Re: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1
> > EVK/QSB and i.MX8M EVK
> >
> > Hi Peng,
> >
> > On Sun, 5 Jan 2025 at 18:14, Peng Fan <peng.fan@nxp.com> wrote:
> > >
> > > > Subject: Re: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1
> > > > EVK/QSB and i.MX8M EVK
> > > >
> > > > Hi Peng,
> > > >
> > > > On Sun, 5 Jan 2025 at 17:27, Peng Fan <peng.fan@oss.nxp.com>
> > wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Sun, Jan 05, 2025 at 08:30:55AM +1300, Simon Glass wrote:
> > > > > >Hi Peng,
> > > > > >
> > > > > >On Sat, 4 Jan 2025 at 16:19, Peng Fan (OSS)
> > > > <peng.fan@oss.nxp.com> wrote:
> > > > > >>
> > > > > >> Switch to bootstd for NXP i.MX9/8M boards with a
> > bsp_bootcmd
> > > > as fallback.
> > > > > >>
> > > > > [...]
> > > > > >>
> > > > > >
> > > > > >This also switches to a text environment, great!
> > > > > >
> > > > > >For bsp_bootcmd is it possible to create a bootmeth for your use
> > > > case?
> > > > > >If you would like to take a look (separate from this series), I
> > > > > >could help with any issues that come up.
> > > > >
> > > > > I just give a quick look of bootmeth, seems needs extlinux or
> > > > > bootscript (boot.scr). But both are used on NXP i.MX release as of
> > > > > now. In NXP releases, we put all script in the U-Boot ENV.
> > > > >
> > > > > Do you have suggestions how to move to support bootmeth.
> > > >
> > > > I'm not entirely sure what you are trying to do with the bootcmd,
> > >
> > > With a single u-boot, we want to support Fedora/SUSE/etc and NXP
> > Yocto
> > > releases.
> > >
> > > So add a bsp_bootcmd as fallback to run NXP Yocto releases.
> > > NXP Yocto releases not have extlinux.cfg, nor boot.scr, we just have
> > > simple uboot hush command in bootcmd, simplied saying:
> > > run loadimage; run loadfdt; run mmcargs; booti ${loadaddr} -
> > > ${fdtaddr}
> > >
> > > > you could write your own bootmeth, e.g. using common code from
> > the
> > > > others. For example, bootmeth_script.c shows how to run a script
> > and
> > > > bootmeth_extlinux.c shows how to run an extlinux file. You could
> > > > then create C code to perform your 'bsp' function, e.g. a new
> > > > bootmeth_bsp.c.
> > >
> > > I will give a look, but this seems we need put the "run loadimage and
> > etc"
> > > in dtb and needs bootmeth_imx.c to support it.
> >
> > Note that my suggestion here is as a follow-on to you current series,
> > which I believe can be applied as is.
> >
>
> I see.
>
> > Anyway, as a starting point, yes you can use run_command() lots of
> > times in the bootmeth to run the things you need. From there you can
> > potentially change some commands to direct calls into the U-Boot
> > functionality. The idea is to be able to locate the bootflow as a separate
> > thing from booting it. I am quite happy to help as well.
>
> It would be great if you could help here. Appreciate in advance.

Separately, if you have access to a low-cost board you can send me,
I'd like to add it to my lab, which is now available to custodians via
gitlab now.

Regards,
Simon
