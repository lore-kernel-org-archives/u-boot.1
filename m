Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD97CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F14B887897;
	Mon, 23 Oct 2023 09:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="h4VGaJsd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7876C878A6; Mon, 23 Oct 2023 09:08:54 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E10874BD
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5401bab7525so2231747a12.2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698044932; x=1698649732; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TapcrGtAZQDw3OV2Qlio0ro5CNM53B7N9Tr4xbgUGGc=;
 b=h4VGaJsdlUci7HON2/Yx3He2dowEpU6W1ip8ferG8NFQB219RBp0iFVAReHzMznLmL
 dqZ2BsMEzTQWbikWRnvLnepIOvs1xlV1KTclKwLURqTIf654TVSpeeffVLr8C6cXEct7
 J946unDdPZNziVmQrGfz4EVjEZvv7PtO3q8dEfL/1ZHMC2BzFQb7fh7AausNyjguKwx9
 BxiEhH9oCCrWXg2E6h9dzYzmZNeqA5SZEZfSoeHofUFjdTgA9OtpKJxVH6T2doLV/LDd
 PQGXObwCHchu//K3INlr9EbZhDx8GT5scE+s+uaryvVg42MXHzT/DbMbvYO8+JpTpe11
 TgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044932; x=1698649732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TapcrGtAZQDw3OV2Qlio0ro5CNM53B7N9Tr4xbgUGGc=;
 b=h5Wztox530JGB6BXgp1QFyjvE5mWXAt5P2oZ1N15/JKSnjcS24u1GauO3kirpesnJU
 GanUICtY4RJVrF2rFIaMTqAVaIW5rC3If2IuHsZYJH/OXUEdjherOsKQ407mkf5wXblB
 089d62YOFmK5HPxC9LQ7lmJe6kjD6E//Qo6h28XfgkV/4rtT7cXhrqXmii2WNerlfWEW
 n/UJsjRTeLOsBHSNnY8/oC/g+V458+RF+v5tfOh1T6gTm+SpRrAo74rkU4FwQZY0kkFF
 +GaHYhlnKMgUXwbyvKOpJk/TakYms5VE5CD7Y81BnaRvAqxcWsyI3iht95hTaK2rq/J9
 GofA==
X-Gm-Message-State: AOJu0YyO7cixbS9yQzXr8jxCad2k/PNmFhncp+v3gnWvGIzB+SDHEcPk
 8L6CCdFRtk64Dpg7XssdUBkG7k7Hza0r8NTgI41Olg==
X-Google-Smtp-Source: AGHT+IFIdi1uStt80e+oG4KCVLoKZ7PqEIHB0Q1ryBENOzAFNlK2EVSiZr/ktXN2sKnb2+PGEATOB+KV52moh8Gv3ig=
X-Received: by 2002:a17:907:1b11:b0:9ae:6ad0:f6db with SMTP id
 mp17-20020a1709071b1100b009ae6ad0f6dbmr7105865ejc.71.1698044931440; Mon, 23
 Oct 2023 00:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231017134951.26672-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3fdWAUbZb7kbWfEZvFvuh79LmWpmbOdRhEk=qw2PTbcg@mail.gmail.com>
 <0c1abfbc-fd2a-4dd9-8447-53e5ee32ab85@canonical.com>
 <CAPnjgZ18Utd0V7kctaqD6aZqfmNy9Qogg8dw5WaHkAar9C+Dxw@mail.gmail.com>
 <750bac2f-3bcd-4ae1-b5ed-a82e8159846b@canonical.com>
 <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
 <ea1ba7c2-7f9c-4702-a6da-efb728771e24@canonical.com>
 <20231020162410.GK3119521@bill-the-cat>
 <CAPnjgZ0zwQ+J-17YEhAtTtLhTcK7K9=nqNNqOdNmG5bY+rFrhg@mail.gmail.com>
 <7481371f-657d-46d6-b8e7-74da7a200ee9@canonical.com>
In-Reply-To: <7481371f-657d-46d6-b8e7-74da7a200ee9@canonical.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 23 Oct 2023 00:08:40 -0700
Message-ID: <CAPnjgZ3_WSS+Z2xsRTvf-7ChPN42OVLgLf8ZvGv=2FVrNuHkhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Doug Anderson <dianders@google.com>, Tom Rini <trini@konsulko.com>
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

Hi Heinrich,

On Sat, 21 Oct 2023 at 21:53, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 10/21/23 17:42, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 20 Oct 2023 at 09:24, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Fri, Oct 20, 2023 at 05:40:03PM +0200, Heinrich Schuchardt wrote:
> >>> On 20.10.23 15:21, Simon Glass wrote:
> >>>> +Doug Anderson
> >>>>
> >>>> Hi Heinrich,
> >>>>
> >>>> On Thu, 19 Oct 2023 at 09:09, Heinrich Schuchardt
> >>>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>>
> >>>>> On 19.10.23 15:55, Simon Glass wrote:
> >>>>>> Hi Heinrich,
> >>>>>>
> >>>>>> On Wed, 18 Oct 2023 at 02:15, Heinrich Schuchardt
> >>>>>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>>>>
> >>>>>>> On 10/18/23 05:33, Simon Glass wrote:
> >>>>>>>> Hi Heinrich,
> >>>>>>>>
> >>>>>>>> On Tue, 17 Oct 2023 at 07:50, Heinrich Schuchardt
> >>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>>>>>>
> >>>>>>>>> Forward and backward compatibility of Linux kernel device-trees is
> >>>>>>>>> sometimes missing. One solution approach is to load a kernel specific
> >>>>>>>>> device-tree. This can either be done via a U-Boot scripts (like the one
> >>>>>>>>> generated by Debian package flash-kernel or by a boot loader like GRUB.
> >>>>>>>>> The boot loader approach currently requires to know the device-tree name
> >>>>>>>>> before first boot which makes it unusable for generic images.
> >>>>>>>>>
> >>>>>>>>> Expose the device-tree file name as EFI variable FdtFile.
> >>>>>>>>> This will allow bootloaders to load a kernel specific device-tree.
> >>>>>>>>>
> >>>>>>>>> The variable will not be exposed on ACPI based systems or if the
> >>>>>>>>> environment variable fdtfile is not defined.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>>>>>>> ---
> >>>>>>>>> v2:
> >>>>>>>>>             Use a unique GUID to enable future U-Boot independent
> >>>>>>>>>             standardization.
> >>>>>>>>>             Do not try to add the variable on ACPI based systems.
> >>>>>>>>> ---
> >>>>>>>>>      include/efi_loader.h       |  5 +++++
> >>>>>>>>>      lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
> >>>>>>>>>      2 files changed, 35 insertions(+)
> >>>>>>>>
> >>>>>>>> I was too slow to reply to v1.
> >>>>>>>>
> >>>>>>>> Does grub load the DT? I was assuming that U-Boot would pass it on?
> >>>>>>>> What is the interface between U-Boot and grub?
> >>>>>>>
> >>>>>>> The device-tree built into U-Boot is often out of date and not usable to
> >>>>>>> boot current Linux. A single device-tree can be loaded by U-Boot from
> >>>>>>> file and passed on as EFI configuration table. This device-tree may not
> >>>>>>> be compatible with all kernel versions exposed by GRUB.
> >>>>>>>
> >>>>>>> GRUB provides a devicetree command. It is disabled if you use secure
> >>>>>>> boot. At least in Debian and Ubuntu GRUB invokes the
> >>>>>>> EFI_DT_FIXUP_PROTOCOL exposed by U-Boot to run U-Boot's device-tree
> >>>>>>> fix-ups after loading a device-tree.
> >>>>>>>
> >>>>>>> Vendor scripts for GRUB like Ubuntu's /etc/grub.d/10_linux add
> >>>>>>> devicetree commands to the boot options in grub.cfg.
> >>>>>>
> >>>>>> Thanks. I wonder if you could document this somewhere? It seems like
> >>>>>> there are a lot of options and it is quite complicated.
> >>>>>>
> >>>>>> Back to the question, I suppose you are expecting grub to load the DT
> >>>>>> using this filename? But why doesn't U-Boot load it instead? It seems
> >>>>>> very convoluted.
> >>>>>
> >>>>> A separate file of this name exists for every kernel version installed.
> >>>>> The loaded dtb must match the kernel. U-Boot does not know what kernel
> >>>>> version will be chosen in GRUB. And for a generic image GRUB does not
> >>>>> what board it is on.
> >>>>>
> >>>>>>
> >>>>>> Also, can we test this interface?
> >>>>>
> >>>>> Neither the sandbox nor QEMU have environment variable fdtfile. And we
> >>>>> don't create the EFI variable with ACPI as used on the sandbox.
> >>>>
> >>>> I worry that this is creating another interface that some poor sod is
> >>>> going to have to deal with in the future. Is this part of the EFI
> >>>> standard?
> >>>
> >>> No, the UEFI standard does not care much about device-trees. It only defines
> >>> the GUID for the configuration table.
> >>>
> >>>>
> >>>> We should really be using the compatible string to choose the
> >>>> devicetree. Why are we using filenames at all? What is the
> >>>> relationship between the compatible string and the filename? Is there
> >>>> a lookup table, or should we create one?
> >>>
> >>> There is no 1:1 relationship between compatible string and filename, e.g.
> >>> the following arm64 device-trees use the same compatible string:
> >>>
> >>> amd/amd-overdrive-rev-b0.dts
> >>> amd/amd-overdrive-rev-b1.dts
> >>>
> >>> amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
> >>> amlogic/meson-axg-jethome-jethub-j110-rev-3.dts
> >>>
> >>> xilinx/zynqmp-zc1751-xm015-dc1.dts
> >>> xilinx/zynqmp-zc1751-xm015-dc1.dts
> >>> xilinx/zynqmp-zc1751-xm015-dc1.dts
> >>> xilinx/zynqmp-zc1751-xm015-dc1.dts
> >>>
> >>>>
> >>>> The correct way of doing this is implemented in U-Boot with
> >>>> CONFIG_FIT_BEST_MATCH.
> >>>
> >>> Why should we write complicated code to find a *possibly* matching file if
> >>> we already know the filename that needs to be loaded?
> >>
> >> I think that is the unfortunate key here. We can make a guess, or best
> >> match, but it might not be right. And we need a reliable way to find and
> >> use the correct tree. And the U-Boot portion of that may be "set the EFI
> >> var if it's not already set" rather than "and now load it".
> >
> > That is not my understanding of how it works. The compatible string is
> > how Linux knows what the hardware is...if it doesn't match, then
> > things are going to go wrong. It is also how U-Boot works, e.g. with
> > FIT. I don't believe this is a 'guess'. The compatible string is used
> > programmatically and must be correct.
>
> It is not how U-Boot works. In distroboot U-Boot uses environment
> variable fdtfile to load the correct device-tree.

Yes, that is my point.

>
> Your suggestion would mean that distroboot or GRUB would have to sift
> through literally hundreds of device-tree files which would considerably
> increase the boot time. The process might end up with multiple dtb files
> that match.

Have you tried it? Just for interest I tried it on the latest Fedora on rpi_4:

$ python scripts/make_fit.py -f test.fit /media/sda2/dtb
Fit size 6a0400 / 6.6 MB, 485 files, uncompressed 16.8 MB

On an rpi_3 with a terribly slow uSD card:
U-Boot> load mmc 0 10000 teste.fit
6910708 bytes read in 601 ms (11 MiB/s)

U-Boot> bootm start 10000
## Loading kernel from FIT Image at 00010000 ...
   Using 'conf-272' configuration
   Trying 'kernel' kernel subimage
   Verifying Hash Integrity ... OK
## Loading fdt from FIT Image at 00010000 ...
   Using 'conf-272' configuration
   Trying 'fdt-272' fdt subimage
   Verifying Hash Integrity ... OK
   Uncompressing Flat Device Tree
   Booting using the fdt blob at 0x3dbf8010
Working FDT set to 3dbf8010

Then I timed how long it takes to get the right FDT:
                 3,466  fdt_best

So that is 3.5ms. Re the load time, it is easy enough to use an
external FIT and just load the metadata part, which cuts the load time
down to 35ms. So the overall cost is about 40ms. It actually takes the
rpi4 longer than that to write the messages to the display (although
I'm not sure why).

There cannot be multiple DTs that match...unless you mean that there
might be different board revisions. But even then, the compatible
string is how they are disambiguated.

So this process is already defined and correct.

> >
> > fdt_node_check_compatible() does most of the work...then you need to
> > check which FDT has the most specific match (i.e. latest in the string
> > list). That handles things like board revisions, variants, etc.
> >
> > My concern is about adding a feature when there is already a defined
> > spec and mechanism for this to work. What happens when we load the
> > file and the compatible is wrong?
> >
> > At best, I see the filename as a hint.
> >
> > [Perhaps this is the wrong time to ask, but why are kernels +DT not
> > shipped in FIT on ARM?]
>
> FIT is U-Boot specific. For Linux distributions it is easier to use a
> firmware agnostic method of booting.

I'd like to suggest that distros use both. Then U-Boot can work as it
was designed and we can avoid these work-arounds.

FIT is actually implemented in various other bootloaders. In fact
perhaps grub is the only one that doesn't? I can't think of any
others.

>
> >>
> >>>> Can we mirror something like that in grub, etc?
> >>
> >> I'm splitting this part out because no, having to have N projects write
> >> the same bit of code, but with its own quirks and bugs doesn't sound
> >> like the right direction. It's why today we have a few different sets of
> >> logic to try and find / set the right device tree, so that whatever
> >> follows after doesn't have to also do that, and get updated for every
> >> new platform too.
> >>
> >> And of course yes, ideally, boards would be manufactured with an up to
> >> date and correct device tree on them.
> >
> > OK, well I perhaps have the wrong end of the stick here.
> >
> > As I learn more about how distros boot I see a great need for
> > information about what is actually being booted. For example, the
> > current 'bootflow menu' mostly shows useless information when EFI is
> > used to boot, since it doesn't know what the things are. We have to
> > jump to grub (or whatever) to find out. Grub knows because the OS set
> > up a grub menu.
>
> The menu should show the EFI boot options. Then you can decide which of
> the multiple operating systems on your device you want to boot.
>
> The bottleneck is secure boot. As Red Hat did not want Microsoft to sign
> every single kernel they came up with shim. Now we can only have one EFI
> boot option per operating system. It is only after shim that you can
> load one of multiple kernels.

OK, but I wonder if each .efi could have a description of at least who
wrote it? It would be very useful to tell if it is Ubuntu or Fedora
before booting it.

>
> >
> > Really we need to see this standard boot thing to the end. Each OS
> > should provide information from /etc/lsb_release as well as info from
> > menu.grub (sorry can't remember the right name), so that we know what
>
> /boot/grub/grub.cfg

That is actually a script in a grub format. I think we need something
more generic. Or are you suggesting that U-Boot should parse grub.cfg
?

>
> > can be booted. Having to jump to an OS-specific bootloader to even be
> > able to show a menu is a pretty poor show.
>
> With secure-boot you still would need to load the OS specific shim.
> Further you would need a means to communicate your decision to whatever
> program loads the kernel.

Yes that's right, similar to how you are communicating the FDT here, I suppose.

>
> >
> > Anyway I think I understand why this variable is needed. Please add
> > some documentation on all this.
>
> Yes I should add a paragraph on the variable.
>
> >
> > My main concern is whether this sort of thing is going to make it even
> > harder to boot in a simple, standard manner.
> >
> > Re Heinrich's comment:
> >
> >> There is no 1:1 relationship between compatible string and filename,
> >> e.g. the following arm64 device-trees use the same compatible string:
> >
> >>> amd/amd-overdrive-rev-b0.dts
> >>> amd/amd-overdrive-rev-b1.dts
> >
> > That just seems like a bug to me. The compatible should include the
> > board rev as it does for xlnx,zynqmp-zcu102-rev1.1 etc.
>
> Yes, here it is a bug.
>
> In theory you could have different device-trees for different device
> configurations (e.g. USB OTG vs USB host). In this case having the same
> compatible string would be correct.

That is the sort of thing that really should not be allowed. The FIT
mechanism keeps people honest.

Regards,
Simon
