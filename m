Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2798FCCF9E9
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 00:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFDF286568;
	Wed,  6 Sep 2023 02:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6D8F86550; Wed,  6 Sep 2023 02:14:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E42AC86590
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 02:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9FA611FB;
 Tue,  5 Sep 2023 17:14:41 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCEC33F64C;
 Tue,  5 Sep 2023 17:14:02 -0700 (PDT)
Date: Wed, 6 Sep 2023 01:12:58 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Hans de Goede
 <hdegoede@redhat.com>, u-boot@lists.denx.de, Samuel Holland
 <samuel@sholland.org>, Jarrah Gosbell <kernel@undef.tools>, Jernej
 =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Subject: Re: [PATCH] sunxi: board: provide CPU idle states to loaded OS
Message-ID: <20230906011232.05ee691a@slackpad.lan>
In-Reply-To: <ZPboy228t8rVajL8@skv.local>
References: <20230904205430.1647654-1-andrej.skvortzov@gmail.com>
 <20230905092712.6ba245bb@donnerap.manchester.arm.com>
 <ZPboy228t8rVajL8@skv.local>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 5 Sep 2023 11:37:31 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

Hi,

> On 23-09-05 09:27, Andre Przywara wrote:
> > On Mon,  4 Sep 2023 23:54:30 +0300
> > Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> > 
> > Hi Andrey,
> >   
> > > When using SCPI as the PSCI backend, firmware can wake up the CPUs and
> > > cluster from sleep, so CPU idle states are available for loaded OS to
> > > use. TF-A modifies DTB to advertise available CPU idle states, when
> > > SCPI is detected. This change copies nodes added by TF-A to any new
> > > dtb that is used for loaded OS.  
> > 
> > Why do you need that, exactly? Why not just use $fdtcontroladdr for the
> > kernel? We now keep the U-Boot copy of the .dts files in sync with the
> > kernel. If you need to modify the DT in U-Boot, for instance by applying
> > overlays, you can copy that DTB into a better suitable location first:  
> > => fdt move $fdtcontroladdr $fdt_addr_r  
> > 
> > In any case, there shall be only one DT, that one in the U-Boot image. Why
> > do you need to load another one for the kernel?  
> 
> extlinux is used by distributions (sometimes with device-specific changes especially

What distros are that? I guess some special ones, targeting embedded
devices, like the Pinephone?
And who is generating extlinux.conf then? Is that some distro specific
scripting, similar to how grub is configured?
Honest questions, I am not a user of extlinux, I mostly use UEFI
booting, or type U-Boot commands directly for experiments, or use
boot.scr, as a quick-and-dirty hack.

> for platforms not fully supported by mainline yet),

Do you need any changes to the DT? Do you need to apply overlays?
If you run on a non-mainlined platform, you could still put your DT
into the U-Boot tree, then you wouldn't need to load another DTB, which
also simplifies the deployment on the kernel/distro side.

> then U-Boot loads DT defined in
> extlinux.conf file. u-boot scripts are not used in case of extlinux at all.

That's fine, you don't need any U-Boot scripts for this to work. If
there is no "fdt" or "fdtdir" label in extlinux.conf, then the U-Boot
PXE code will eventually fall back to $fdtcontroladdr - I just tested
that.
So could you make that work for you? I guess all you need to change is
to remove any fdtdir label from extlinux.conf?

Cheers,
Andre
