Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2CAE9271C
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 17:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9665786CD0;
	Thu,  5 Oct 2023 19:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MRg7YoJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D10A86B55; Thu,  5 Oct 2023 19:22:44 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6586386D02
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 19:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53639fb0ba4so2198699a12.0
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696526559; x=1697131359; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=90RgCm9ulHsBZDJc0G+sz8YS+D0YNMan09Yu1HomGrM=;
 b=MRg7YoJEP8DaCUS15rZTMLCWGfke5NtThvPn+Z3ERL0W8l+fyLCFgklEKhvObaNmiO
 zlOMOftPBP6XBYTboq8ThyW3debX9u+A7pvUwnv2rrEJY98VCxspBdQpFaTR0XJfHSwm
 BbCMm7N7cobgGOX+YkjbJ6nf3V6d+IVC2iAJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696526559; x=1697131359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=90RgCm9ulHsBZDJc0G+sz8YS+D0YNMan09Yu1HomGrM=;
 b=ObPTW19ndiQaIZ4jDZjRN57Irw3i8YUVQfsUe+diIy45LBFthzB7Pl0LVOKVSr1P8j
 j6lm5uRbahLOddEmAzbRjI4d1IaXNtzGZhx0yNyzMp8GWPy/w+1olqkgreydWqHT2Yfx
 BsAwbJg4HJaOwgV5RayF88EJ76UTtciwGaKk5rUDaTwPev53VyyxoNn2v46sRf1zC88x
 dSJ2MD7CW3PrZfem7Vuti4IaHmxB5RMPZrtqOz9KGFZtqALshT5QkNjPpOaM8WN1xFHr
 guTGBpa3A/akXoS7GTXeqqDC8WLcIUsqRStnpQzM4yDaWLUIC44fJATwAaRArXpAb7g4
 OP2A==
X-Gm-Message-State: AOJu0Yz9zk9e3Ux8wvKJoXp/G/mg2gfvEMT5Iyz5zXdzV3NhlG+0LFxi
 1GSqfKjWGkorOZN4oh06KIy/ZU70ILyO4EEvZwNn+Q==
X-Google-Smtp-Source: AGHT+IHsY9POFMpMexp06eq8WTFeT0S+M0DZwAfkmWLJE2JlKtSUwti7w9InCfOESP7mcyUZdxRhM5ApAwcFyc2m2dc=
X-Received: by 2002:a17:906:31c9:b0:9b6:499a:172d with SMTP id
 f9-20020a17090631c900b009b6499a172dmr5709045ejf.52.1696526558856; Thu, 05 Oct
 2023 10:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231004132324.44198-1-rogerq@kernel.org>
 <20231004132324.44198-2-rogerq@kernel.org>
 <26457fd1-439d-fb87-52cc-350a884a8dcd@ti.com>
 <20231004135436.ihofrxutzcdefica@audacious>
 <895a5d8f-1d5f-4f90-90a1-ca75bc1ff54f@ti.com>
 <20231005163645.GS8465@bill-the-cat>
 <20231005171010.zvza7uqyn4mcgp5g@handsaw>
 <20231005171614.yiatmyczip2jnmf4@surround>
In-Reply-To: <20231005171614.yiatmyczip2jnmf4@surround>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Oct 2023 11:22:27 -0600
Message-ID: <CAPnjgZ1fnqgk5W_8-jkJL1keXGM4CfnK-jPnFtQcFcV+y89+cA@mail.gmail.com>
Subject: Re: [PATCH 1/2] board: ti: am62x: am62x.env: Fix boot_targets
To: Nishanth Menon <nm@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>,
 Roger Quadros <rogerq@kernel.org>, 
 vigneshr@ti.com, m-chawdhry@ti.com, jonas@kwiboo.se, srk@ti.com, bb@ti.com, 
 praneeth@ti.com, u-boot@lists.denx.de
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

Hi Nishanth,

On Thu, 5 Oct 2023 at 11:16, Nishanth Menon <nm@ti.com> wrote:
>
> On 12:10-20231005, Nishanth Menon wrote:
> > On 12:36-20231005, Tom Rini wrote:
> > > On Thu, Oct 05, 2023 at 09:19:48AM -0500, Andrew Davis wrote:
> > > > On 10/4/23 8:54 AM, Nishanth Menon wrote:
> > > > > On 08:48-20231004, Andrew Davis wrote:
> > > > > > On 10/4/23 8:23 AM, Roger Quadros wrote:
> > > > > > > ti_mmc is not a valid boot_target for standard boot flow so
> > > > > >
> > > > > > Is there some way to make it into a valid boot_target? Otherwise
> > > > > > how do we use uEnv.txt files, or boot from FIT images with overlays?
> > > > >
> > > > > envboot takes care of uEnv.txt file (see
> > > > > https://lore.kernel.org/all/20231004132324.44198-3-rogerq@kernel.org/)
> > > > >
> > > > > Early remote proc loading and FIT image is a question for stdboot itself.
> > > > >
> > > >
> > > > If stdboot is missing these features then we shouldn't switch until it
> > > > has them. I'm all for switching to this, but only if it is complete.
> > >
> > > Depends on what you mean?  Did you mean an option to run scripts
> > > (exists) or an option to do what TI needs done, via
> > > boot/bootmeth_something.c ?  If the latter, someone from TI needs to
> > > figure out what that should be and do (but plumbing-wise everything it
> > > needs should exist).
> >
> > Andrew is generalizing here (on the wrong patch though).
> >
> > On am62x platforms, there is nothing regressing with this series. The
> > challenge is early remote_proc loading which is done for J7* platforms.
> >
> > How that is initiated as part of bootmethods is something of a gap.
> >
> > The other gap has been support for uEnv.txt -> which we can workaround
> > at the moment by using CONFIG_BOOTCOMMAND="run envboot; bootflow scan
> > -lb" in defconfig (This series from Roger already does that - hence I am
> > saying that Andrew is complaining on the wrong series).
> >
> > Ideally, we should just have CONFIG_BOOTCOMMAND="bootflow scan -lb" and
> > uEnv.txt remoteproc loads and the various standard bootmethods should
> > "just work".
>
>
> I forgot to add: FIT image authenticated boot flow. That is really what
> ti_mmc distroboot method was trying to solve.
>
> Maybe Simon or someone know how the stdboot flow handles authenticated
> kernel image and dtb boot flow with FIT image?

Yes you can use FIT configuration verification and things should work as normal.

Regards,
Simon
