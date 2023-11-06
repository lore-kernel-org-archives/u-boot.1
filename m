Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C36C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 17:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADC5186538;
	Mon,  6 Nov 2023 18:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E2E686538; Mon,  6 Nov 2023 18:45:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6557186F8A
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 18:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4E8DC15;
 Mon,  6 Nov 2023 09:46:06 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B68223F64C;
 Mon,  6 Nov 2023 09:45:20 -0800 (PST)
Date: Mon, 6 Nov 2023 17:45:18 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Anup Patel <apatel@ventanamicro.com>, Xiang W
 <merlew4n6@gmail.com>, Chanho Park <chanho61.park@samsung.com>, Sughosh
 Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, Peter Hoyes
 <Peter.Hoyes@arm.com>, Alexey Romanov <avromanov@salutedevices.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231106174518.45f19dc3@donnerap.manchester.arm.com>
In-Reply-To: <20231106164627.GA496310@bill-the-cat>
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
 <50ff2080-5831-4963-937d-331248b59973@canonical.com>
 <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan>
 <20231106164627.GA496310@bill-the-cat>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Mon, 6 Nov 2023 11:46:27 -0500
Tom Rini <trini@konsulko.com> wrote:

Hi Tom,

> On Sat, Nov 04, 2023 at 05:12:12PM +0000, Andre Przywara wrote:
> > On Fri, 3 Nov 2023 13:38:58 -0600
> > Simon Glass <sjg@chromium.org> wrote:
> > 
> > Hi Simon,
> >   
> > > Hi Heinrich,
> > > 
> > > On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:  
> > > >
> > > > On 11/1/23 19:05, Andre Przywara wrote:    
> > > > > On Tue, 31 Oct 2023 14:55:50 +0200
> > > > > Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> > > > >
> > > > > Hi Heinrich,
> > > > >    
> > > > >> The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR. It
> > > > >> provides an interface to a physical entropy source.
> > > > >>
> > > > >> A RNG driver based on the seed CSR is provided. It depends on
> > > > >> mseccfg.sseed being set in the SBI firmware.    
> > > > >
> > > > > As you might have seen, I added a similar driver for the respective Arm
> > > > > functionality:
> > > > > https://lore.kernel.org/u-boot/20230830113230.3925868-1-andre.przywara@arm.com/
> > > > >
> > > > > And I see that you seem to use the same mechanism to probe and init the
> > > > > driver: U_BOOT_DRVINFO and fail in probe() if the feature is not
> > > > > implemented.
> > > > > One downside of this approach is that the driver is always loaded (and
> > > > > visible in the DM tree), even with the feature not being available.
> > > > > That doesn't seem too much of a problem on the first glance, but it
> > > > > occupies a device number, and any subsequent other DM_RNG devices
> > > > > (like virtio-rng) typically get higher device numbers. So without
> > > > > the feature, but with virtio-rng, I get:
> > > > > VExpress64# rng 0
> > > > > No RNG device    
> > > 
> > > Why do we get this? If the device is not there, the bind() function
> > > can return -ENODEV
> > > 
> > > I see this in U-Boot:
> > > 
> > > U_BOOT_DRVINFO(cpu_arm_rndr) = {
> > > 
> > > We should not use this.  
> > 
> > Agreed.
> >   
> > > Use the devicetree.  
> > 
> > No, this is definitely not something for the DT, at least not on ARM.
> > It's perfectly discoverable via the architected CPU ID registers.
> > Similar to PCI and USB devices, which we don't probe via the DT as well.
> > 
> > It's arguably not proper "driver" material per se, as I've argued before, but
> > it's the simplest solution and fits in nicely otherwise.
> > 
> > I was wondering if it might be something for UCLASS_CPU, something like
> > a "CPU feature bus": to let devices register on one on the many CPU
> > features (instead of compatible strings), then only bind() those
> > drivers it the respective bit is set.
> > 
> > Does that make sense? Would that be doable without boiling the ocean?
> > As I don't know if we see many users apart from this.  
> 
> I think we have a similar problem with how we're doing with DM_TIMER and
> armv7-a/armv7-m/armv8[1]. We shouldn't need the drivers in drivers/timer/
> to cover platforms where SYS_ARCH_TIMER is (or should be!) enabled. But
> in turn, the code under arch/arm/cpu/*/*timer.c doesn't implement the
> uclass side of things, only the regular API. This is because there's
> nothing to probe even because we don't support the kind of multi-arch
> binary where it'd be possible to not have the feature.

Well, normally we indeed build a U-Boot image for one particular board,
and chips typically don't gain new hardware features over night while
sitting on the shelf.
But then we also support software models (QEMU, Arm FVP) and "more
flexible" hardware (like FPGA platforms), where the CPU features are
indeed in flux. In QEMU it's as easy as "-cpu max", and people use that to
test new architecture features. 

For the arch timer it's a slightly different story, since every halfway
recent chip has it, but still we try to detect it at places, as it's easy
enough to do.

So I do believe there is some place for auto-detection, even in U-Boot.

Cheers,
Andre.
