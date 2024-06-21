Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56860C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 14:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80729884FF;
	Fri, 21 Jun 2024 16:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mT9gJ6O4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72C798840F; Fri, 21 Jun 2024 16:54:54 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CF74884FF
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 16:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LEsmaK022497;
 Fri, 21 Jun 2024 09:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718981688;
 bh=cOUOg5nZxVljtejtyrNRwMpH/SmDJGTTxY1IvxB+xVU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=mT9gJ6O4zy7ShpcsvO8v2uNFgdreDl5zysRVQ+DbmYnlMawIrXAly7ceC/wAtY/zW
 aP1qVgbopF7B1FzAoCDVzPKwAAfuc2uWDz0MaV41+X+LQreG+SDcYBG4Wicam1asY5
 dFm0RJg98Rf/Vfs1dFhv1pcbfJdun5GYP+QMmSqg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LEsmS4025331
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 21 Jun 2024 09:54:48 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 09:54:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 09:54:48 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LEsm8n055822;
 Fri, 21 Jun 2024 09:54:48 -0500
Date: Fri, 21 Jun 2024 09:54:48 -0500
From: Bryan Brattlof <bb@ti.com>
To: Peter Robinson <pbrobinson@gmail.com>
CC: Nishanth Menon <nm@ti.com>, <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Enric Balletbo i Serra
 <eballetb@redhat.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Josh Boyer <jwboyer@redhat.com>
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
Message-ID: <20240621145448.6bur6wfgufvifuk2@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240620213539.ftmjhphypssxp5n4@desolate>
 <CALeDE9OF5Eqqk5PgTZUUi7r-1ApC7HhoxUMELQRWLXVJzuPOew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALeDE9OF5Eqqk5PgTZUUi7r-1ApC7HhoxUMELQRWLXVJzuPOew@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On June 20, 2024 thus sayeth Peter Robinson:
> Hi Nishanth,
> 
> Thanks for starting this conversation.
> 
> > We have briefly discussed this topic on IRC[1]. I would like to
> > propose a new boot-firmware repository similar to the Linux-firmware
> > repository under the aegis of u-boot hosting.
> >
> > In addition to TI, it looks like some NXP[2] and Rockchip[3]
> > platforms seem to require additional closed-source/open-source
> > binaries to have a complete bootable image. Distribution rights and
> > locations of these binaries are challenging, and there needs to be a
> > standard for how and where they are hosted for end users.
> 
> Yes, it's been painful for some time, and often the distribution is
> unclear because often the binaries are copies around between SBC
> makers often without the other bits such as licenses etc so it's a
> case of "who knows ¯\_(ツ)_/¯" even if it's the same for all devices of
> a particular SoC.
> 
> Having a process around licensing and redistribution requirements is useful.
> 
> > Further, looking ahead to future architectures:
> > * IP firmware: More and more IP vendors are embedding their own
> >   "specialized controllers" and require firmware for the operation
> >   (similar to Rockchip's DDR controller, I guess),
> > * boot stage firmware: Additional stages of the boot process involve
> >   vendor intermediate firmware, such as power configuration.
> > * Security enclave binaries: While I see a few folks trying to have an
> >   open-source s/w architecture, many PKA and PQC systems still require
> >   prop binaries for IP reasons.
> >
> > NOTE: I am not judging any company(including TI) for reasons why some
> > firmware is proprietary, but I hate to have the end users and other
> > system (distro) maintainers have to deal with hell trying to make the
> > life of end users easy to live with.
> >
> > In the case of TI's K3 architecture devices, we have two binary blobs
> > that are critical for the boot process.
> >
> > 1. TIFS Firmware / DMSC firmware[4]—This is the security enclave
> >   firmware. It is often encrypted, and sources are not public (due to
> >   various business/regulatory reasons).
> > 2. DM Firmware[5] - There is a source in public in some cases and
> >   binary only in others - essentially limited function binary to be
> >   put up in the device management uC. In cases where the source is
> >   available, the build procedure is, in my personal opinion, pretty
> >   arcane, and even though in theory it is practical, in practice, not
> >   friendly - efforts are going to simplify it, even probably integrate
> >   it with a more opensource ecosystem, but that is talking "look at the
> >   tea leaves" stuff.
> > 3. Low Power Management (LPM) binaries: tifs stub: another encrypted
> >   binary that gives the tifs system context restore logic before
> >   retrieving tifs firmware and a corresponding DM restoration binary.
> >
> > All told, this is not unlike the situation that necessitated the
> > creation of a Linux firmware repository.
> >
> > Options that I see:
> >
> > 1. Let the status quo be - SoC vendors maintain random locations and
> >   random rules to maintain boot firmware.
> > 2. Ask Linux-firmware to host the binaries in a single canonical
> >   location
> 
> I don't believe this makes sense. linux-firmware is designed for
> firmware that is loaded by linunx drivers, these are not, they're
> generally used a part of early boot firmware prior to the linux kernel
> even booting, and could in fact be any other OS. As it is
> linux-firmware is 2Gb+ in size, as a maintainer of that package in
> Fedora having to determine which of 1000s of firmware is used by linux
> or something else or if we need to ship it is hard enough already
> without throwing a whole raft of other FW into the mix. I think a
> separate repo is the right way to go here please.
> 
>

Agree! While consolidating all of these binaries together under denx.de
or linux-firmware is needed, it doesn't make much sense to put this in a 
linux-firmware like repo. Unlike linux-firmware we don't need all of 
these binaries on the board (another side-effect of putting these u-boot 
binaries in linux-firmware), only the tiniest of subsets will be used
for a specific board build.

My hope was we could use some type of distribution mirroring system like 
most distributions use for their binaries today with some central 
routing for all the build machines consuming these blobs. This has the 
benefit of allowing vendors to help out with hosting and bandwidth if 
that's a problem and gives denx.de the ability to secure the software 
supply chain.

Using a system like this does add to the complexity of an already 
complex setup/build system for u-boot. But we can do much better than a 
signed git repo

~Bryan


> > 3. Host a boot-firmware repository - u-boot repo may be the more
> >   logical location.
> >
> > * (1) isn't the correct answer.
> >
> > * (2) Though I haven't seen any policy from the Linux-firmware
> >   community mandating anything of the form, the binaries we are talking
> 
> my understanding is the policy is that it's firmware required by linux drivers.
> 
> >   of may not belong to Linux-firmware as they aren't strictly speaking
> >   something Linux kernel will load (since the bootloader has that
> >   responsibility), and in some cases may not even directly talk to
> >   (security enclave or DDR firmware stuff). I am adding Josh to this
> >   mail to see if he has any opinions on the topic (but keeping
> >   from cross posting on linux-firmware list, unless folks feel it is
> >   OK).
> >
> > On (3):
> > Proposal:
> >
> > * Create a boot firmware repository in Denx and/or GitHub (if
> >   financials are a hurdle, I hope we can solve it as a community).
> > * Limit binaries only to those consumed part of the u-boot scope.
> > * Limit binaries only to those that do not have an opensource project
> >   (Trusted Firmware-A/M, OP-TEE, etc..) or depend entirely on vendor
> >   source or are binary only in nature (subject to licensing terms below)
> > * Limit binaries to some pre-established size to prevent repository
> >   explosion - say, 512Kib?
> 
> Not sure that makes sense, if a FW is needed by a device to boot it
> doesn't make sense to exclude it based on some arbitrary size
> 
> > * Follow the same rules of integration and licensing guidelines as
> >   Linux-firmware[6].
> > * Similar rules as Linux-firmware guidelines of ABI backward and
> >   forward compatibility.
> > * Set a workflow update flow and a compatibility requirements document
> 
> * needs to come from the vendor (there's been issues with
> linux-firmware where people try and post firmware that might not be
> redistributable)
> * need to be freely redistributable
> * needs something similar to the liniux-firmware whence file etc.
> * The new linux-firmware PR automation etc is quite good
> 
> > If we agree to have boot firmware under the stewardship of u-boot, we
> > should also set other rules, which is excellent to discuss.
> 
> I think that's a good start, I think we should be open to expansion.
> 
> > Thoughts?
> >
> > [1] https://libera.irclog.whitequark.org/u-boot/2024-06-13#36498796;
> > [2] https://docs.nxp.com/bundle/AN14093/page/topics/build_the_u-boot.html
> > [3] https://bbs.t-firefly.com/forum.php?mod=viewthread&tid=2236
> > [4] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/tree/ti-sysfw?h=ti-linux-firmware
> > [5] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/tree/ti-dm?h=ti-linux-firmware
> > [6] https://docs.kernel.org/next/driver-api/firmware/firmware-usage-guidelines.html
> > --
> > Regards,
> > Nishanth Menon
> > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
