Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC520C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 02:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B118787680;
	Thu, 30 Nov 2023 03:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TyyxygqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45A9287652; Thu, 30 Nov 2023 03:46:26 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6013087665
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 03:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-da30fd994fdso1324917276.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701312381; x=1701917181; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R6eA8mHg0n/C0k76Xy0egRt3oukjNpiIJs6E9O0mhAU=;
 b=TyyxygqO5TmxoI/Wr+JlyRBrgiarrgg1UXZcq8DGQyUqlufYO6E/80NGo45e0GOYwG
 q7MXUGait3dkVYWknThgCC66RqPOaEgik3XgcxdllZuYKBTnADWpKiVr6s7FgdHhA6aZ
 YM7iHan4r5ZQtekCRMGT9byVTQJUpZ3TiO2Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701312381; x=1701917181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R6eA8mHg0n/C0k76Xy0egRt3oukjNpiIJs6E9O0mhAU=;
 b=rwP0pyI1M3z/2MbvYgnswX4a22one5lVCdc8afkau9LZFYeliC/tjx6TFKekUSJDVC
 Q5nHcvtI2TF5Yh8WNZ/rqURa+ROUeYpru9PjRcRxB3kqU2O2r85NpRsCL1AT27Mv/Uke
 KBEzYs9NRhU7dll1SFhsYhuTkIIiJbkBTAdxhKk6vxztIFUpXLWqUW8kRhcT2pBSoMxt
 L9RlG8hWpv0S4Wn2j4wcs2yp0pJRW0Zv0umIvS2JCLtigRxDKdl2SJ7XFV1PEL7LvhD+
 kHNOqhB0UHzIweUjcNOvIWrApVk+PqAKZd/0B22AiKfaFKTHGOdG0T+daJmAU5H07UCb
 W3og==
X-Gm-Message-State: AOJu0YwFS1OqF2StE4t77rBe0aYEDh1sUe5uCEA+gN7IUdtQalOTpyvn
 CJDg/jLDc4NqyCOn3Oo4raA1srrGhitCWJkeT6Ztgw==
X-Google-Smtp-Source: AGHT+IEA1S1ai91MJu58t5Kj+iEfi/SvXdPD9TyCwzpv6ycorZG7cKnxEtRbTaY/ESlJFOU1d2f4BXzzayZ8xYD1dGI=
X-Received: by 2002:a25:ac43:0:b0:d9a:c0af:9da with SMTP id
 r3-20020a25ac43000000b00d9ac0af09damr15257916ybd.28.1701312380797; Wed, 29
 Nov 2023 18:46:20 -0800 (PST)
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
 <CAPnjgZ1JTcybX9sRFQtddcwefLum6_+ynQSWbQ=4NVdO6eAxhg@mail.gmail.com>
 <7df59596-ac84-4e26-844f-3f3ad4bb0b7f@ti.com>
In-Reply-To: <7df59596-ac84-4e26-844f-3f3ad4bb0b7f@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 19:45:30 -0700
Message-ID: <CAPnjgZ06tDBGko7RxO_ec1hKYqOhfhY9D7FdPiaVcDxaomeUDA@mail.gmail.com>
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

On Mon, 6 Nov 2023 at 11:05, Andrew Davis <afd@ti.com> wrote:
>
> On 11/6/23 11:47 AM, Simon Glass wrote:
> > Hi Andrew,
> >
> > On Mon, 6 Nov 2023 at 10:27, Andrew Davis <afd@ti.com> wrote:
> >>
> >> On 11/6/23 9:31 AM, Tom Rini wrote:
> >>> On Mon, Nov 06, 2023 at 11:23:51AM +0530, Manorit Chawdhry wrote:
> >>>> Hi Simon,
> >>>>
> >>>> On 11:22-20231005, Simon Glass wrote:
> >>>>> Hi Nishanth,
> >>>>>
> >>>>> On Thu, 5 Oct 2023 at 11:16, Nishanth Menon <nm@ti.com> wrote:
> >>>>>>
> >>>>>> On 12:10-20231005, Nishanth Menon wrote:
> >>>>>>> On 12:36-20231005, Tom Rini wrote:
> >>>>>>>> On Thu, Oct 05, 2023 at 09:19:48AM -0500, Andrew Davis wrote:
> >>>>>>>>> On 10/4/23 8:54 AM, Nishanth Menon wrote:
> >>>>>>>>>> On 08:48-20231004, Andrew Davis wrote:
> >>>>>>>>>>> On 10/4/23 8:23 AM, Roger Quadros wrote:
> >>>>>>>>>>>> ti_mmc is not a valid boot_target for standard boot flow so
> >>>>>>>>>>>
> >>>>>>>>>>> Is there some way to make it into a valid boot_target? Otherwise
> >>>>>>>>>>> how do we use uEnv.txt files, or boot from FIT images with overlays?
> >>>>>>>>>>
> >>>>>>>>>> envboot takes care of uEnv.txt file (see
> >>>>>>>>>> https://lore.kernel.org/all/20231004132324.44198-3-rogerq@kernel.org/)
> >>>>>>>>>>
> >>>>>>>>>> Early remote proc loading and FIT image is a question for stdboot itself.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> If stdboot is missing these features then we shouldn't switch until it
> >>>>>>>>> has them. I'm all for switching to this, but only if it is complete.
> >>>>>>>>
> >>>>>>>> Depends on what you mean?  Did you mean an option to run scripts
> >>>>>>>> (exists) or an option to do what TI needs done, via
> >>>>>>>> boot/bootmeth_something.c ?  If the latter, someone from TI needs to
> >>>>>>>> figure out what that should be and do (but plumbing-wise everything it
> >>>>>>>> needs should exist).
> >>>>>>>
> >>>>>>> Andrew is generalizing here (on the wrong patch though).
> >>>>>>>
> >>>>>>> On am62x platforms, there is nothing regressing with this series. The
> >>>>>>> challenge is early remote_proc loading which is done for J7* platforms.
> >>>>>>>
> >>>>>>> How that is initiated as part of bootmethods is something of a gap.
> >>>>>>>
> >>>>>>> The other gap has been support for uEnv.txt -> which we can workaround
> >>>>>>> at the moment by using CONFIG_BOOTCOMMAND="run envboot; bootflow scan
> >>>>>>> -lb" in defconfig (This series from Roger already does that - hence I am
> >>>>>>> saying that Andrew is complaining on the wrong series).
> >>>>>>>
> >>>>>>> Ideally, we should just have CONFIG_BOOTCOMMAND="bootflow scan -lb" and
> >>>>>>> uEnv.txt remoteproc loads and the various standard bootmethods should
> >>>>>>> "just work".
> >>>>>>
> >>>>>>
> >>>>>> I forgot to add: FIT image authenticated boot flow. That is really what
> >>>>>> ti_mmc distroboot method was trying to solve.
> >>>>>>
> >>>>>> Maybe Simon or someone know how the stdboot flow handles authenticated
> >>>>>> kernel image and dtb boot flow with FIT image?
> >>>>>
> >>>>> Yes you can use FIT configuration verification and things should work as normal.
> >>>>>
> >>>>
> >>>> Could you give any reference documentation for this?
> >>>
> >>> I suspect you should start with doc/usage/fit/beaglebone_vboot.rst
> >>>
> >>
> >>   From that doc:
> >>
> >> ```
> >> Boot the board using the commands below::
> >>
> >>       setenv bootargs console=ttyO0,115200n8 quiet root=/dev/mmcblk0p2 ro rootfstype=ext4 rootwait
> >>       ext2load mmc 0:2 82000000 /boot/image.fit
> >>       bootm 82000000
> >> ```
> >>
> >> This is very much not stdboot :( This doc has some good and current info on building
> >> a secure FIT image, but much of it is showing its age. Stdboot is still missing
> >>
> >>    * ability to limit boot mode search to only one image (FIT)
> >
> > What does this mean? Can you please be more specific or give an example?
> >
>
> Sure, for instance with secure boot we only want to search for FIT images
> and if for each media this fails we do not want to fall back to other
> image types or boot modes (like UART boot or net boot which would bypass
> the signature checks).

We could have something like:

bootstd {
   image-types = "fit", "uimage";
}

to limit the supported types.

>
> Something similar is needed for searching for EFI compatible boot across
> each enabled boot media first, before trying other methods on each media.
> Basically breadth-first search on each media type not depth-first.

How about:

bootstd {
   scan-order = "bootmeth,bootdev";   // instead of default "bootdev,bootmeth";
};


>
> >>    * fetching and applying FIT overlay/config strings
> >
> > Re overlays, is this the 'extension' command? What are config strings?
> >
>
> When we have DT overlays in our FIT image, we build a string to pass to
> bootm to apply all the selected overlays[0]. If there is now another
> mechanism for this please let me know (building this string today is messy).
>
> https://source.denx.de/u-boot/u-boot/-/blob/master/include/env/ti/ti_common.env?ref_type=heads#L18

My proposal for this is to implement extensions in FIT. This would
have a new extensions nodes, so you can specify what extensions are
available for each FIT configuration.

configurations {
   conf-1 {
      compatible = ...
      extensions = "ext1", "ext-2";
   };

extensions {
   ext-1 {
      fdto = "fdt-1";   // fdt overlay for this 'cape'
      compatible = "vendor,combined-device1";
      extensions = "ext3";
   };

   ext-2 {
      fdto = "fdto-2";   // fdt overlay for this 'cape'
      compatible = "vendor,device2";
   };

   ext-3 {
      fdto = "fdto-3";
      compatible = "vendor,device3";
   };

So FIT configurations now have a list of supported extensions. The
extensions are hierarchical so that you can have ext1 which can
optionally have ext-2 as well. This allows boards which share a lot of
'capes' to be specified only ones.

Extensions actually present are declared by a sysinfo driver for the
board, with new methods:

get_compat() - determine the compatible strings for the current platform
get_ext() - get a list of compatible strings for extensions which are
actually present

The extension compatible strings are used to select the correct things
from the FIT, apply the overlays and produce the final DT.

>
> >>    * remote proc loading
> >
> > What command can do this?
> >
>
> https://source.denx.de/u-boot/u-boot/-/blob/master/include/env/ti/ti_common.env?ref_type=heads#L28

This could be a new property in bootstd:

bootstd: {
   probe-before = <&phandle of remoteproc>, ...
};

>
> >>    * uEnv.txt processing
> >
> > What command can do this?
> >
>
> run envboot;
>
> https://source.denx.de/u-boot/u-boot/-/blob/master/include/env/ti/mmc.env?ref_type=heads#L20

This could be a new bootmeth which looks for uenv.txt on available
devices. It might be better to put the env in a FIT or something with
a checksum.

>
> >>
> >> Last two can be solved by adding to CONFIG_BOOTCOMMAND before calling `bootflow scan`
> >> as suggested above. Until we figure out the first two I don't see us ready to switch.
> >
> > I'm happy to help figure this out.
> >
>
> Thanks, we are eager to standardize our boot flows and stdboot seems like the
> right way forward, very happy to have your guidance on these last few items :)

Regards,
Simon
