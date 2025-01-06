Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AE8E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 12:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E66801E8;
	Mon,  6 Jan 2025 13:15:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DAE4Htv6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DABCC8036B; Mon,  6 Jan 2025 13:15:38 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7125E801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 13:15:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso56010266b.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 04:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736165735; x=1736770535; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+amcQcm5xsO+iYwFq2vMpXJ0M2/4cuzY1t5cBtUmV8M=;
 b=DAE4Htv6QruvJH/OCY/5tE9Q7R89THIsT/F42Qgp90YTMkYN8N7zPAIHn31+6BcUf+
 1dVRG7+wQbxR39k5vXVzTH7IpKc3Qe2mjOGDqA51wgwVBQvrR4UKTtrUJjnWuBPmsX63
 2NfmmXbFdMk2zQ3LC8Q8BiaS++jM3gttvrtIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736165735; x=1736770535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+amcQcm5xsO+iYwFq2vMpXJ0M2/4cuzY1t5cBtUmV8M=;
 b=Xf8o3phuSpgFNNRRBtKKxdYtgKYsMOOdfI1REdHrlvcFFsJ1ajWukIYymGbSYQgra1
 i+ig6lcLCrD3mJb5khe4v4qwE/OkMQMoapQz6uc4ZkLhB3y4AXYs0DTJUFtoNGbOTGIt
 57uYsoErX/ng9X9+W8eNyC+pQ5njuX8GCYhlZnmBJLCfqVpjQmRmLFuRt9DiuXOuhkR5
 YsgD7Qbx/4o69stC5cFvywWxEnanqiMH/m0ANssKVeOwHSIP7mrOGWzFg8VxS5xJj7y4
 kvdDsQEf21nioLiknSFh9LDsjLmGrHDJ9OJ2c1GiZ3byYsiJbDWfwpyJGZOW9lBBPU/U
 JtEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkXmyaicRk8h6syhU4mmdFTNjbOTH81qHnxhaf0tr5F/GaObwq8w/CK12HlRt8fB4W00/YvaA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzn8+d9wbKc74xoskRjhQ+z4M15p3U1qc5WTjyYpp773Cr6Az69
 bcR52ov0E1YI/QgyGFhCH0WTMM/JB/RC831lcF/hLOD/DNnOKIoonfARHv8aif2TedemCsKKoi1
 AbZPoqu43nKOHLkDRG5gdY/AjzmS9oxk+1AWL
X-Gm-Gg: ASbGnctB2RZG4KHn6TbzscJYXFrDyKz2tVVYn0GTtrX7lchyoBKmc828v+bQjQlkff5
 y+R9o+LCk0MXEsP+ISIWWogfJ2x+wNw3QcosGd68=
X-Google-Smtp-Source: AGHT+IFmh6n9lAQdVh0l2Tn+kahWjeH7LNx3PCyVRoRBZ4DfuWal57zKnanCc9OeNTeMF57/4jrS6t8m3MS9yjTn7/U=
X-Received: by 2002:a17:907:3607:b0:aa6:5910:49af with SMTP id
 a640c23a62f3a-aac2b6611c2mr5374318166b.24.1736165735559; Mon, 06 Jan 2025
 04:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
 <CAFLszTi_px3qRGvpcC5WKLw+r5BqqQciOP-Vg1LEN+rt9876wQ@mail.gmail.com>
 <20250106013311.GA8414@localhost.localdomain>
 <CAFLszTi2ya3V4SDfpZxLzzyAdyM9KN0MGuZPnK2XeO8wRNw69w@mail.gmail.com>
 <PAXPR04MB8459B6A69CA0713B0B51058988102@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459B6A69CA0713B0B51058988102@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Jan 2025 05:15:23 -0700
Message-ID: <CAFLszTg8UHbgHnFM-6JjYFK5pd_+HW61_jzMM-eeV9+hQgOspQ@mail.gmail.com>
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

On Sun, 5 Jan 2025 at 18:14, Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1
> > EVK/QSB and i.MX8M EVK
> >
> > Hi Peng,
> >
> > On Sun, 5 Jan 2025 at 17:27, Peng Fan <peng.fan@oss.nxp.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Sun, Jan 05, 2025 at 08:30:55AM +1300, Simon Glass wrote:
> > > >Hi Peng,
> > > >
> > > >On Sat, 4 Jan 2025 at 16:19, Peng Fan (OSS)
> > <peng.fan@oss.nxp.com> wrote:
> > > >>
> > > >> Switch to bootstd for NXP i.MX9/8M boards with a bsp_bootcmd
> > as fallback.
> > > >>
> > > [...]
> > > >>
> > > >
> > > >This also switches to a text environment, great!
> > > >
> > > >For bsp_bootcmd is it possible to create a bootmeth for your use
> > case?
> > > >If you would like to take a look (separate from this series), I could
> > > >help with any issues that come up.
> > >
> > > I just give a quick look of bootmeth, seems needs extlinux or
> > > bootscript (boot.scr). But both are used on NXP i.MX release as of
> > > now. In NXP releases, we put all script in the U-Boot ENV.
> > >
> > > Do you have suggestions how to move to support bootmeth.
> >
> > I'm not entirely sure what you are trying to do with the bootcmd,
>
> With a single u-boot, we want to support Fedora/SUSE/etc and NXP
> Yocto releases.
>
> So add a bsp_bootcmd as fallback to run NXP Yocto releases.
> NXP Yocto releases not have extlinux.cfg, nor boot.scr, we just
> have simple uboot hush command in bootcmd, simplied saying:
> run loadimage; run loadfdt; run mmcargs; booti ${loadaddr} - ${fdtaddr}
>
> > you could write your own bootmeth, e.g. using common code from the
> > others. For example, bootmeth_script.c shows how to run a script and
> > bootmeth_extlinux.c shows how to run an extlinux file. You could then
> > create C code to perform your 'bsp' function, e.g. a new
> > bootmeth_bsp.c.
>
> I will give a look, but this seems we need put the "run loadimage and etc"
> in dtb and needs bootmeth_imx.c to support it.

Note that my suggestion here is as a follow-on to you current series,
which I believe can be applied as is.

Anyway, as a starting point, yes you can use run_command() lots of
times in the bootmeth to run the things you need. From there you can
potentially change some commands to direct calls into the U-Boot
functionality. The idea is to be able to locate the bootflow as a
separate thing from booting it. I am quite happy to help as well.

Regards,
SImon
