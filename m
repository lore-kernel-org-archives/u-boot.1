Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27F5C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 17:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22A1586538;
	Mon,  6 Nov 2023 18:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TtTF56Nr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C1A2867E2; Mon,  6 Nov 2023 18:48:13 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6AC3801B6
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 18:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5440f25dcc7so5941647a12.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 09:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699292890; x=1699897690; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0jJKjBGfhGBJoDibI6YkRf0XDlRvrTv3cUW8Uc+a1Vg=;
 b=TtTF56NreLbpdPccoI5dcG1iL4YLnzWl39cp35OACwdfTRX837twHDoBcHdHRjcLgG
 cXioDM1gEsGpBgM/eu3XGFDXtliLIpTIjVS1TdUuQDZPG5jX8cDp+0P/jK/9424835AE
 1Jk2BjCxuqtmx3PuCR7NJilMEQF0XA4gn7/Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699292890; x=1699897690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0jJKjBGfhGBJoDibI6YkRf0XDlRvrTv3cUW8Uc+a1Vg=;
 b=Se2I8oeh452bedWps5wQHaGox/PdrXwZP9FsANWJHazbDkYv0qIyHxpDoBuuThP/ax
 tNhanFYQ9GuPQmWR0ZllXxozaSXm5EiBs5hDOG9qUo1VOLVsL6yt0XRUyFA08/HAjL3d
 kxF7uyB7ebTLOOtAX8TyqDRz6jaTyKHRYQk4eMmGFXMW77FfKufVv3To6i0QK//q7Amq
 +jf6rPnFuHn067dFsA0pIAEv/ASVmrLW3TXOCNMtMcMZ56OQWX86uq14g2tZG2k4Kj3D
 lgGoiohpmreq24oX896LD06mNDROjPG+K/qu+5GPzwtMmMjjEQcdLs6GLyVWtC8/xWih
 RgXQ==
X-Gm-Message-State: AOJu0YxMwrCbIfyLRrtQjfkdEmvDq0DdPgjS2+mve5TJXll1SKfrfnfI
 vXWtLhWT8nqlpu4aPvjrMa11P94meaS5MUeKAgGbrQ==
X-Google-Smtp-Source: AGHT+IFh5ItbrywAjIeBlJy6o5jAXo2s5zNEjAa6oFJg+IDzwDhpVywI/mGDjikB3SJH24vN8SrWMTsgG8JSH+ioP4s=
X-Received: by 2002:a50:bb2f:0:b0:542:f28e:2947 with SMTP id
 y44-20020a50bb2f000000b00542f28e2947mr19286319ede.26.1699292890033; Mon, 06
 Nov 2023 09:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20231004132324.44198-1-rogerq@kernel.org>
 <20231004132324.44198-2-rogerq@kernel.org>
 <26457fd1-439d-fb87-52cc-350a884a8dcd@ti.com>
 <20231004135436.ihofrxutzcdefica@audacious>
 <895a5d8f-1d5f-4f90-90a1-ca75bc1ff54f@ti.com>
 <20231005163645.GS8465@bill-the-cat>
 <20231005171010.zvza7uqyn4mcgp5g@handsaw>
 <20231005171614.yiatmyczip2jnmf4@surround>
 <CAPnjgZ1fnqgk5W_8-jkJL1keXGM4CfnK-jPnFtQcFcV+y89+cA@mail.gmail.com>
 <20231106055351.f2fny5ys6avi5qnk@ula0497581>
 <20231106153159.GH496310@bill-the-cat>
 <736c04ab-9c48-4957-b242-fcbde0ace68b@ti.com>
In-Reply-To: <736c04ab-9c48-4957-b242-fcbde0ace68b@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Nov 2023 10:47:52 -0700
Message-ID: <CAPnjgZ1JTcybX9sRFQtddcwefLum6_+ynQSWbQ=4NVdO6eAxhg@mail.gmail.com>
Subject: Re: [PATCH 1/2] board: ti: am62x: am62x.env: Fix boot_targets
To: Andrew Davis <afd@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Nishanth Menon <nm@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, vigneshr@ti.com, jonas@kwiboo.se, srk@ti.com,
 bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
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

Hi Andrew,

On Mon, 6 Nov 2023 at 10:27, Andrew Davis <afd@ti.com> wrote:
>
> On 11/6/23 9:31 AM, Tom Rini wrote:
> > On Mon, Nov 06, 2023 at 11:23:51AM +0530, Manorit Chawdhry wrote:
> >> Hi Simon,
> >>
> >> On 11:22-20231005, Simon Glass wrote:
> >>> Hi Nishanth,
> >>>
> >>> On Thu, 5 Oct 2023 at 11:16, Nishanth Menon <nm@ti.com> wrote:
> >>>>
> >>>> On 12:10-20231005, Nishanth Menon wrote:
> >>>>> On 12:36-20231005, Tom Rini wrote:
> >>>>>> On Thu, Oct 05, 2023 at 09:19:48AM -0500, Andrew Davis wrote:
> >>>>>>> On 10/4/23 8:54 AM, Nishanth Menon wrote:
> >>>>>>>> On 08:48-20231004, Andrew Davis wrote:
> >>>>>>>>> On 10/4/23 8:23 AM, Roger Quadros wrote:
> >>>>>>>>>> ti_mmc is not a valid boot_target for standard boot flow so
> >>>>>>>>>
> >>>>>>>>> Is there some way to make it into a valid boot_target? Otherwise
> >>>>>>>>> how do we use uEnv.txt files, or boot from FIT images with overlays?
> >>>>>>>>
> >>>>>>>> envboot takes care of uEnv.txt file (see
> >>>>>>>> https://lore.kernel.org/all/20231004132324.44198-3-rogerq@kernel.org/)
> >>>>>>>>
> >>>>>>>> Early remote proc loading and FIT image is a question for stdboot itself.
> >>>>>>>>
> >>>>>>>
> >>>>>>> If stdboot is missing these features then we shouldn't switch until it
> >>>>>>> has them. I'm all for switching to this, but only if it is complete.
> >>>>>>
> >>>>>> Depends on what you mean?  Did you mean an option to run scripts
> >>>>>> (exists) or an option to do what TI needs done, via
> >>>>>> boot/bootmeth_something.c ?  If the latter, someone from TI needs to
> >>>>>> figure out what that should be and do (but plumbing-wise everything it
> >>>>>> needs should exist).
> >>>>>
> >>>>> Andrew is generalizing here (on the wrong patch though).
> >>>>>
> >>>>> On am62x platforms, there is nothing regressing with this series. The
> >>>>> challenge is early remote_proc loading which is done for J7* platforms.
> >>>>>
> >>>>> How that is initiated as part of bootmethods is something of a gap.
> >>>>>
> >>>>> The other gap has been support for uEnv.txt -> which we can workaround
> >>>>> at the moment by using CONFIG_BOOTCOMMAND="run envboot; bootflow scan
> >>>>> -lb" in defconfig (This series from Roger already does that - hence I am
> >>>>> saying that Andrew is complaining on the wrong series).
> >>>>>
> >>>>> Ideally, we should just have CONFIG_BOOTCOMMAND="bootflow scan -lb" and
> >>>>> uEnv.txt remoteproc loads and the various standard bootmethods should
> >>>>> "just work".
> >>>>
> >>>>
> >>>> I forgot to add: FIT image authenticated boot flow. That is really what
> >>>> ti_mmc distroboot method was trying to solve.
> >>>>
> >>>> Maybe Simon or someone know how the stdboot flow handles authenticated
> >>>> kernel image and dtb boot flow with FIT image?
> >>>
> >>> Yes you can use FIT configuration verification and things should work as normal.
> >>>
> >>
> >> Could you give any reference documentation for this?
> >
> > I suspect you should start with doc/usage/fit/beaglebone_vboot.rst
> >
>
>  From that doc:
>
> ```
> Boot the board using the commands below::
>
>      setenv bootargs console=ttyO0,115200n8 quiet root=/dev/mmcblk0p2 ro rootfstype=ext4 rootwait
>      ext2load mmc 0:2 82000000 /boot/image.fit
>      bootm 82000000
> ```
>
> This is very much not stdboot :( This doc has some good and current info on building
> a secure FIT image, but much of it is showing its age. Stdboot is still missing
>
>   * ability to limit boot mode search to only one image (FIT)

What does this mean? Can you please be more specific or give an example?

>   * fetching and applying FIT overlay/config strings

Re overlays, is this the 'extension' command? What are config strings?

>   * remote proc loading

What command can do this?

>   * uEnv.txt processing

What command can do this?

>
> Last two can be solved by adding to CONFIG_BOOTCOMMAND before calling `bootflow scan`
> as suggested above. Until we figure out the first two I don't see us ready to switch.

I'm happy to help figure this out.

Regards,
SImon
