Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C64C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 15:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C49CD87134;
	Tue,  7 Nov 2023 16:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF1088715B; Tue,  7 Nov 2023 16:12:56 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D9E3787134
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 16:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C56713D5;
 Tue,  7 Nov 2023 07:13:37 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 034B33F703;
 Tue,  7 Nov 2023 07:12:50 -0800 (PST)
Date: Tue, 7 Nov 2023 15:12:48 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>, Anup Patel
 <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>, Chanho Park
 <chanho61.park@samsung.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot@lists.denx.de, Peter Hoyes <Peter.Hoyes@arm.com>, Alexey Romanov
 <avromanov@salutedevices.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231107151248.0c6247c4@donnerap.manchester.arm.com>
In-Reply-To: <CAPnjgZ1eMxbJGhxSGF1NgCELz+MOoPK0k3hsB-hzEXTo0=3szQ@mail.gmail.com>
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
 <50ff2080-5831-4963-937d-331248b59973@canonical.com>
 <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan>
 <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106215331.0d770df8@slackpad.lan>
 <CAPnjgZ2GY8o_UR-rqYOimYe1t_NV+6eAa8rZY3Eaak6vp7Vciw@mail.gmail.com>
 <20231107112708.4030f2e1@donnerap.manchester.arm.com>
 <CAPnjgZ1eMxbJGhxSGF1NgCELz+MOoPK0k3hsB-hzEXTo0=3szQ@mail.gmail.com>
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

On Tue, 7 Nov 2023 05:22:58 -0700
Simon Glass <sjg@chromium.org> wrote:

Hi Simon,

> Hi Andre,
> 
> On Tue, 7 Nov 2023 at 04:27, Andre Przywara <andre.przywara@arm.com>
> wrote:
> >
> > On Tue, 7 Nov 2023 01:08:15 +0000
> > Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Simon,
> >  
> > > On Mon, 6 Nov 2023 at 21:55, Andre Przywara <andre.przywara@arm.com>
> > > wrote:  
> > > >
> > > > On Mon, 6 Nov 2023 13:38:39 -0700
> > > > Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Simon,
> > > >  
> > > > > On Mon, 6 Nov 2023 at 10:26, Andre Przywara
> > > > > <andre.przywara@arm.com> wrote:  
> > > > > >
> > > > > > On Sat, 4 Nov 2023 19:45:06 +0000
> > > > > > Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >  
> > > > > > > On Sat, 4 Nov 2023 at 17:13, Andre Przywara
> > > > > > > <andre.przywara@arm.com> wrote:  
> > > > > > > >
> > > > > > > > On Fri, 3 Nov 2023 13:38:58 -0600
> > > > > > > > Simon Glass <sjg@chromium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >  
> > > > > > > > > Hi Heinrich,
> > > > > > > > >
> > > > > > > > > On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
> > > > > > > > > <heinrich.schuchardt@canonical.com> wrote:  
> > > > > > > > > >
> > > > > > > > > > On 11/1/23 19:05, Andre Przywara wrote:  
> > > > > > > > > > > On Tue, 31 Oct 2023 14:55:50 +0200
> > > > > > > > > > > Heinrich Schuchardt
> > > > > > > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > >  
> > > > > > > > > > >> The Zkr ISA extension (ratified Nov 2021)
> > > > > > > > > > >> introduced the seed CSR. It provides an interface
> > > > > > > > > > >> to a physical entropy source.
> > > > > > > > > > >>
> > > > > > > > > > >> A RNG driver based on the seed CSR is provided. It
> > > > > > > > > > >> depends on mseccfg.sseed being set in the SBI
> > > > > > > > > > >> firmware.  
> > > > > > > > > > >
> > > > > > > > > > > As you might have seen, I added a similar driver for
> > > > > > > > > > > the respective Arm functionality:
> > > > > > > > > > > https://lore.kernel.org/u-boot/20230830113230.3925868-1-andre.przywara@arm.com/
> > > > > > > > > > >
> > > > > > > > > > > And I see that you seem to use the same mechanism to
> > > > > > > > > > > probe and init the driver: U_BOOT_DRVINFO and fail
> > > > > > > > > > > in probe() if the feature is not implemented.
> > > > > > > > > > > One downside of this approach is that the driver is
> > > > > > > > > > > always loaded (and visible in the DM tree), even
> > > > > > > > > > > with the feature not being available. That doesn't
> > > > > > > > > > > seem too much of a problem on the first glance, but
> > > > > > > > > > > it occupies a device number, and any subsequent
> > > > > > > > > > > other DM_RNG devices (like virtio-rng) typically get
> > > > > > > > > > > higher device numbers. So without the feature, but
> > > > > > > > > > > with virtio-rng, I get: VExpress64# rng 0 No RNG
> > > > > > > > > > > device  
> > > > > > > > >
> > > > > > > > > Why do we get this? If the device is not there, the
> > > > > > > > > bind() function can return -ENODEV
> > > > > > > > >
> > > > > > > > > I see this in U-Boot:
> > > > > > > > >
> > > > > > > > > U_BOOT_DRVINFO(cpu_arm_rndr) = {
> > > > > > > > >
> > > > > > > > > We should not use this.  
> > > > > > > >
> > > > > > > > Agreed.
> > > > > > > >  
> > > > > > > > > Use the devicetree.  
> > > > > > > >
> > > > > > > > No, this is definitely not something for the DT, at least
> > > > > > > > not on ARM. It's perfectly discoverable via the
> > > > > > > > architected CPU ID registers. Similar to PCI and USB
> > > > > > > > devices, which we don't probe via the DT as well.
> > > > > > > >
> > > > > > > > It's arguably not proper "driver" material per se, as I've
> > > > > > > > argued before, but it's the simplest solution and fits in
> > > > > > > > nicely otherwise.
> > > > > > > >
> > > > > > > > I was wondering if it might be something for UCLASS_CPU,
> > > > > > > > something like a "CPU feature bus": to let devices
> > > > > > > > register on one on the many CPU features (instead of
> > > > > > > > compatible strings), then only bind() those drivers it the
> > > > > > > > respective bit is set.
> > > > > > > >
> > > > > > > > Does that make sense? Would that be doable without boiling
> > > > > > > > the ocean? As I don't know if we see many users apart from
> > > > > > > > this.  
> > > > > > >
> > > > > > > I have seen this so many times, where people want to avoid
> > > > > > > putting things in the DT and then are surprised that
> > > > > > > everything is difficult, broken and confusing. Why not just
> > > > > > > follow the rules? It is not just about whether we can avoid
> > > > > > > it, etc. It is about how devices fit together cohesively in
> > > > > > > the system, and how U-Boot operates.  
> > > > > >
> > > > > > A devicetree is only for peripherals *that cannot be located
> > > > > > by probing*.  
> > > > >
> > > > > I have to stop you there. It absolutely is not limited to that.  
> > > >
> > > > I am very sorry, but I - (and seemingly everyone else in the
> > > > kernel DT community?) - seem to disagree here.  
> > >
> > > Really? Where is that even coming from? Certainly not the DT spec.  
> >
> > It seems to be common agreement between devicetree folks, and I find
> > it in one of Frank Roward's slidedeck about devicetree in the early
> > days (2015ish). But indeed this should be added to official documents.
> > I poked some people to get this sorted.  
> 
> Yes I recall those dark days but it is not actually correct. That sort
> of restriction would be very destructive, in fact.
> 
> Even if you look at all the PCI stuff you can see that specifying
> probe-able stuff in the DT is fine.

In the recent PCI case this is exactly about non-probe-able stuff:
"This is the groundwork for applying overlays to PCI devices containing
non-discoverable downstream devices."
And if I understand this correctly, this is for generating DT nodes in the
live OF tree only, during kernel runtime?

But yes, there are exceptions from that rule, be it for quirks, or
if you need further integration information, like an interrupt, as used
for the Arm Generic Timer (aka arch timer) or the Arm PMU.
But in those cases there is always a good reason, and then a binding is
accepted.
But in general: no, if we can safely probe it, we don't want a DT node.

> > > > > > Which are traditionally most peripherals in non-server Arm
> > > > > > SoCs. While I do love the DT, the best DT node is the one you
> > > > > > don't need.  
> > > > >
> > > > > We need it in U-Boot, at least.
> > > > >
> > > > > I'll send a patch with a warning on U_BOOT_DRVINFO() as it seems
> > > > > that some people did not see the header-file comment.  
> > > >
> > > > Fair enough.
> > > >  
> > > > > Let's just stop this discussion and instead talk about the
> > > > > binding we need.  
> > > >
> > > > Alright, if that is your decision, I will send a patch to revert
> > > > that "driver". There will never be a binding for a CPU instruction
> > > > discoverable by the architected CPU ID register.  
> > >
> > > That statement just mystifies me. Why not just send a binding? Even
> > > the people that complain that DT should only describe hardware will
> > > be happy with it.
> > >
> > > The code you sent should have been a clue that you need to know
> > > whether the feature is present:  
> >
> > Ah, sorry, I sense some misunderstanding: I was arguing about the ARM
> > RNDR driver. The Arm architecture manual describes the FEAT_RNG
> > feature as perfectly discoverable, in a clean way, without any risk or
> > further knowledge about the platform.
> >
> > This thread here was originally about the RISC-V driver (written by
> > Heinrich), where the situation is slightly different: while there seem
> > to be CSRs to discover CPU features, this is apparently not the case
> > for every instruction. So Heinrich did some probing, testing for an
> > illegal instruction, which honestly still sounds better than a DT node
> > to me. 
> > > +       /* Check if reading seed leads to interrupt */
> > > +       set_resume(&resume);
> > > +       ret = setjmp(resume.jump);
> > > +       if (ret)
> > > +               log_debug("Exception %ld reading seed CSR\n",
> > > resume.code);
> > > +       else
> > > +               val = read_seed();
> > > +       set_resume(NULL);
> > > +       if (ret)
> > > +               return -ENODEV;
> > >
> > > I have never seen code like that in a driver. Please let's just have
> > > the binding discussion with the Linux people and hopefully they will
> > > see reason.  
> >
> > For the RISC-V case: maybe. But there is already a (newish) binding to
> > list CPU features in the DT:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/riscv/extensions.yaml
> > It's just not a normal device node binding, with a compatible string,
> > instead a string list inside each CPU's node.  
> 
> Hmm so each CPU has its own random-number generator?

Don't know what you mean? How those CPU instructions typically work is
that there are generic *architected* instructions or system registers,
described by the official ARMv8.5 FEAT_RNG, in this case, while the
actual entropy source is provided by the integrator. So it's a common
interface to whatever TRNG the SoC might already have anyway.
And one reason for this feature was to exactly do away with the device
specific interfaces and discovery, and allow easy access for any user.

> > So one possibility would be some connector code that parses that list
> > and looks for drivers having registered? Like a CPU bus, I think Sean
> > proposed something like this earlier. Or we ditch the idea of this
> > being a regular driver in the first place, instead go with a "CPU
> > entropy instruction abstraction".
> >
> > But for Arm it's a different story.  
> 
> The key thing here is that U-Boot (mostly) needs to have a DT node for
> each device it creates.

That's a (current?) U-Boot design decision, unrelated to the hardware it
describes. Hence nothing that really justifies a hardware DTB description.

> In the case of a random-number generator, there can be several devices
> in the system.

Yes, and others (Linux, for instance) can apparently just cope fine with
this.

> We want to control which one is used for a particular feature.

So that means it's a policy decision, which might even differ between
different users with different needs. So again not hardware related.

> This is normally done with aliases, or with a phandle from the feature
> that uses it.

Well, aliases and phandles are DT features, so naturally apply to devices
in the DT. But that doesn't mean we need to shoehorn everything into some
DT.
And part of that is policy again, so doesn't really belong in the
*hardware* DT.

> > > > I had some gripes with that "driver" in the first place, but it
> > > > was so temptingly simple and fit in so nicely, for instance into
> > > > the UEFI entropy service without even touching that code, that I
> > > > couldn't resist to just try it. And it actually solved a nasty
> > > > problem for us, where the kernel boot was stuck for minutes
> > > > waiting for enough entropy to ... let a script create a random
> > > > filename ;-) But we also have virtio-rng, so are not limited to
> > > > the instructions.
> > > >
> > > > But well, I guess I will just bite the bullet and go along the
> > > > proper route and create some RNG instruction abstraction, as
> > > > sketched in that other email.  
> > >
> > > I don't know what that is.  
> >
> > That's what Tom and I were talking about earlier:
> > ... "a simple get_cpu_random() function, implemented per architecture,
> > and with some kind of success flag, should be easy enough to do. Then
> > either the users (UEFI?) explicitly call this before trying
> > UCLASS_RNG, or we wrap this for every RNG user."  
> 
> That doesn't solve the problem, though. The TPM may provide random
> numbers. There may be some other crypto thing, or even a remoteproc
> interface.

Yes, or a PCI based entropy source, which would have a normal driver, but
no DT as well. And anyway you might expose this via a driver, but I don't
see why every device must be described in the DT.

> We already have a perfectly good way of selecting between multiple
> devices. It is used all over U-Boot. We should not be inventing a
> hard-coded hack just because we are confused about whether something
> is a device. Just make it a device.

And this is exactly what my ARM RNDR driver was doing: using a
UCLASS_RNG driver interface to expose entropy. I just don't understand why
we desperately need a DT node for that? I understand that U_BOOT_DRVINFO
should not be used, and this is fine.
So if you don't like the Linux style approach of treating CPU instructions
separately, that's fair enough, but I also don't see why a U-Boot DM
driver must be DT only.

> > > In the other email I proposed a binding for this, so I hope that can
> > > make progress.  
> >
> > I don't think we need a new DT binding for RISC-V, instead lean on
> > riscv,isa-extensions.  
> 
> IMO we do need a new DT binding for the reasons given above.

I don't agree, the current binding gives you perfect discoverability, just
not via the usual compatible string search. But that's some discussion for
the DT maintainers anyway ...

> > And I am pretty sure any attempt at a binding for ARM will be NAKed
> > immediately.  
> 
> Well perhaps you can help resolve that, which seems to be the core
> issue here. I hope you can understand my frustration at this sort of
> tactic. It is quite destructive. U-Boot has suffered for years from an
> inability to upstream bindings. It has been a significant drag on the
> project and its contributors. We need to change the conversation here
> and permit non-Linux projects to contribute to bindings for
> firmware-specific reasons, even ones which Linux doesn't care about.

The Linux kernel repo does accept bindings for devices that Linux doesn't
have or need a driver for (DRAM controllers, for instance). If you look at
DT binding patch submissions, maintainers routinely object the word
"driver" or even the mentioning of "Linux" in there, because the binding
is user agnostic and not bound to a Linux driver at all. And the DT
maintainers are very clear that those are not the the "Linux DT bindings",
but that the Linux kernel community is just the place that provides the
review experience and the infrastructure to host the binding files.

So in those cases I don't think it's about the DT maintainers being
hostile or unreasonable, it's just a general problem of some requests being
out of scope of a *hardware* DTB.

> A clear statement to that effect would put my mind at ease. It just
> shouldn't be this hard.

I can't help to think that you like the FDT as a well understood and
flexible general purpose data structure. And it can indeed be used as a
configuration file, especially since you have the parser in your code
already - the FIT image is a good example. But this is distinct from the
Devicetree as a hardware description.
Would it help to separate the two use cases: to go with one DTB that is
strictly for hardware configuration, as described by the DT bindings in
the Linux kernel tree, and a *separate* DT blob that carries configuration
information, U-Boot specific data (like memory layout, SRAM usage, device
priorities, packaging information)? TF-A chose this approach: there is
hw-config, which is the hardware DTB, and there is fw-config, which is a
FDT blob as well, but describes the firmware layout and other configuration
information.

Cheers,
Andre

> > > > > > But as Heinrich also said: those instructions are not
> > > > > > peripherals, they are part of an instruction set extensions,
> > > > > > the same story as with x86's RDRAND instruction. We don't have
> > > > > > those in ACPI or so as well, because CPUID has you covered.
> > > > > > The same on ARM, ID_AA64ISAR0_EL1 is readable on every chip
> > > > > > (outside of EL0), and tells you whether you have the RNDR
> > > > > > register or not. IIUC RISC-V is slightly different here, since
> > > > > > not all ISA extensions are covered by CSRs, hence some of them
> > > > > > indeed listed in the DT.
> > > > > >
> > > > > > So a proper solution(TM) would be to split this up in
> > > > > > architectural *instructions* and proper TRNG *devices*, maybe
> > > > > > wrapping this up in some function that tests both. This is
> > > > > > roughly what the kernel does, somewhat abstracted by the
> > > > > > concept of "entropy sources", which could be TRNG devices, CPU
> > > > > > instructions, interrupt jitter or even "instruction execution
> > > > > > jitter"[1], with the latter two definitely not being devices
> > > > > > really at all.
> > > > > >
> > > > > > But I don't know if U-Boot wants to go through the hassle of
> > > > > > this whole framework, as we tend to implement things much
> > > > > > easier. But a simple get_cpu_random() function, implemented
> > > > > > per architecture, and with some kind of success flag, should
> > > > > > be easy enough to do. Then either the users (UEFI?) explicitly
> > > > > > call this before trying UCLASS_RNG, or we wrap this for every
> > > > > > RNG user.
> > > > > >
> > > > > > Cheers,
> > > > > > Andre
> > > > > >  
> > > > > > > > > > > VExpress64# rng 1
> > > > > > > > > > > 00000000: f3 88 b6 d4 24 da 49 ca 49 f7 9e 66 5f 12
> > > > > > > > > > > 07 b2  ....$.I.I..f_...  
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Essentially in any case were you have multiple drivers
> > > > > > > > > > for the same device using uclass_get_device(, 0, ) and
> > > > > > > > > > uclass_find_first_device() will only give you the
> > > > > > > > > > first bound device and not the first successfully
> > > > > > > > > > probed device. Furthermore neither of this functions
> > > > > > > > > > causes probing. This is not restricted to the RNG
> > > > > > > > > > drivers but could also happen with multiple TPM
> > > > > > > > > > drivers or multiple watchdogs.
> > > > > > > > > >
> > > > > > > > > > This patch is related to the problem:
> > > > > > > > > >
> > > > > > > > > > [PATCH v1] rng: add dm_rng_read_default() helper
> > > > > > > > > > https://lore.kernel.org/u-boot/4e28a388-f5b1-4cf7-b0e3-b12a876d0567@gmx.de/T/#me44263ec9141e3ea65ee232aa9a411fc6201bd95
> > > > > > > > > >
> > > > > > > > > > We have weak function platform_get_rng_device() which
> > > > > > > > > > should be moved to drivers/rng/rng-uclass.c.
> > > > > > > > > >
> > > > > > > > > > We could add a function to drivers/core/uclass.c to
> > > > > > > > > > retrieve the first successfully probed device. Another
> > > > > > > > > > approach would be to implement
> > > > > > > > > > uclass_driver.post_probe() in the RNG uclass to take
> > > > > > > > > > note of the first successfully probed device.
> > > > > > > > > >
> > > > > > > > > > @Simon:
> > > > > > > > > > What would make most sense from a DM design
> > > > > > > > > > standpoint?  
> > > > > > > > >
> > > > > > > > > I am sure I provided feedback on this at the time, but I
> > > > > > > > > don't remember. OK I just found it here [1]. So the
> > > > > > > > > problem is entirely because my feedback was not
> > > > > > > > > addressed. Please just address it and avoid this sort of
> > > > > > > > > mess.  
> > > > > > > >
> > > > > > > > Yeah, Tom just merged it, but that's not Heinrich's fault
> > > > > > > > ;-) 
> > > > > > > > > So arm_rndr should have a devicetree compatible string
> > > > > > > > > and be bound like anything else. If for some reason the
> > > > > > > > > device doesn't exist in the hardware, it can return
> > > > > > > > > -ENODEV from its bind() method.
> > > > > > > > >
> > > > > > > > > If you want to control which RNG device is used for
> > > > > > > > > booting, you could add a property to /bootstd with a
> > > > > > > > > phandle to the device. We are trying to provide a
> > > > > > > > > standard approach to booting in U-Boot, used by all
> > > > > > > > > methods. Doing one-off things for particular cases is
> > > > > > > > > best avoided.  
> > > > > > > >
> > > > > > > > Picking the first usable device doesn't sound much like a
> > > > > > > > one-off to me. After all the caller (be it UEFI or the rng
> > > > > > > > command) later detect that this is not usable. So there
> > > > > > > > might be some merit to cover this more automatically,
> > > > > > > > either in the caller, or by providing a suitable wrapper
> > > > > > > > function?  
> > > > > > >
> > > > > > > Or just follow the existing mechanisms which have been in
> > > > > > > U-Boot for years. Please...!
> > > > > > >
> > > > > > > [..]
> > > > > > >
> > > > > > >
> > > > > > > Regards,
> > > > > > > Simon  
> > > > > > >  >  
> > > > > > > > > [1]
> > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20230830113230.3925868-1-andre.przywara@arm.com/
> > > > > > > > >  
> > > > > > > >  
> > > >  
> > >
> > > Regards,
> > > SImon  
> >  

