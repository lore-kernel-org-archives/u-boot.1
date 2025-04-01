Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A251DC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F4C380FDA;
	Tue,  1 Apr 2025 17:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MGYiad9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCF7A81782; Tue,  1 Apr 2025 17:48:44 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D84B980584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac6e8cf9132so1009765466b.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743522521; x=1744127321; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=orsbFgSSbnTe2tAsGPovRYNJsZDxyK88UvtY8AkXdAM=;
 b=MGYiad9l4u/0v1Lp3xIjpjgGN5ppxrdZ0nU2m7NgXtWJRdunhDYHEh3DONEhfXd2iN
 H1bqvSP4Ulwlsr870GL6R8uEs8IPWSqnGeyFmtKtKHRbbGYB9YJDP70wQr12X4jTDnnz
 JsYsqfjLg2fZQ/+QYvsgPrFIye/6E19zz6JJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743522521; x=1744127321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=orsbFgSSbnTe2tAsGPovRYNJsZDxyK88UvtY8AkXdAM=;
 b=kjqoP5zzxkn8wdKE64EGtK0datSRlYQuvE8LwEWHTLnV0uZmXLkVr1TwkhkCGv1D5i
 SXqMvY5ymzRC7VtUjb9vjNyRVZr7M3K844UnxpQupa3awjLV/8L3+rN7DQ8bu8obpMfr
 wCd0PiE3TpyZr7QsS5N1m39V5TVJzB0NRC0llfdbQoZcTU6O5VQNHiIByZxpr565I7oC
 Jdf/PZAVtZtAB3UASuHvOCB4ng6XBLpXHP+spEW7cnyiBvfRv0DwRUWPvCcPOXR2qD8a
 Dl//jROg4CFIu4J/t4exv/pGQwNkCK6MeM8OeijZB6xysKfE+ZIAztCSo7yFPIxzfRq3
 TZfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU25pv5oGme4ZWILkt2ugNAI9ATazrEAcqYu9EQjzOxUsgUY3hDepDEaF5WX1ywME5A/NRxOO4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywj64tjp5tdGdpXfwtGSIXyLfcQp3wSs03YONn3CAczhjxHwF1o
 5oHR1bqwjlTr8FQH5xqKaHmhTrHEe7JLDnpSwGEOjX+9NCzMrKxoqsa1WWBBCDUImHgkAYqo+yz
 J8U55oFcREV18dMj/rh1sxvJuRNKQDyfTuBwbUay/uzH9hz4wzQ==
X-Gm-Gg: ASbGnctme8JjeGuxeNVjUM7WNv+q4xATAuLf9cK937qET6gnynoWeSAGYqnA/b6ezNi
 YB+3B/KKPOkao64ay/stw2u6FtdopplZ3Kvs+J/KPM5kpR8fJAlIKfmDzQv8+Iafibvrkc/aIYf
 qITQectxJFhd1SmXd37wXxyLYls3JL
X-Google-Smtp-Source: AGHT+IFfzYUb9wXnVMV0PSEHMLhXLEU9cilYpkUW/7UMuQ5oqkVAq4QgHFeKykDeyfatN900UgHX4gdLAHZFiFtN/XE=
X-Received: by 2002:a17:907:7e9c:b0:ac2:4db0:1d22 with SMTP id
 a640c23a62f3a-ac782e3cbb2mr296768266b.42.1743522521121; Tue, 01 Apr 2025
 08:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231024062032.8543-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ07zojtkV6ReQiC3XPf_AW96YnAc6APqhfk7wUDMmyOrA@mail.gmail.com>
 <CAPnjgZ3zFnAaivWa1BaUDbTfzRc-SZ_H8+YSvAKtwBJ64=XftQ@mail.gmail.com>
 <1ac5013d-8991-4abd-baad-94776801c58c@canonical.com>
 <87a5s6qwfe.fsf@bloch.sibelius.xs4all.nl>
 <20231025211354.GZ496310@bill-the-cat>
 <f5e39630-0065-42e3-95a9-91e608e2c919@canonical.com>
 <CAPnjgZ1zzWZ48nn2ux7yd1pJ4mWVOt4w2ToBZC6MR2wcxbnMsQ@mail.gmail.com>
 <db43d704-8f6d-4583-9b86-d1d2709f7bf6@linaro.org>
 <CAFLszTgaZC6eOdtSV5Ukny3zffiixVep14iSiYzc8RpykmBE9g@mail.gmail.com>
 <657308f0-bc64-49c3-bd14-c932a88e5ccd@linaro.org>
 <9c6ac5b0-8a4d-47fd-8be3-d9d49f9cb644@canonical.com>
 <98a9629c-a6b4-4e01-8f2b-694ee6ca7c06@linaro.org>
In-Reply-To: <98a9629c-a6b4-4e01-8f2b-694ee6ca7c06@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 04:48:28 +1300
X-Gm-Features: AQ5f1JoXzAt2zneHafN9DIHjqzpnjW2e4or8yJsj5Qi1lJWogonNe_toq9suFqk
Message-ID: <CAFLszTi+JifdrpJ7ttH_GXBPbsDEa6SvYKxtb0xbuTD+AWJF0g@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] efi_loader: expose the device-tree file name
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, 
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
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

Hi Caleb,

On Mon, 31 Mar 2025 at 03:38, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Heinrich,
>
> On 3/28/25 15:18, Heinrich Schuchardt wrote:
> > On 28.03.25 14:00, Caleb Connolly wrote:
> >>
> >>
> >> On 3/28/25 13:01, Simon Glass wrote:
> >>> Hi Caleb,
> >>>
> >>> On Sun, 23 Mar 2025 at 12:39, Caleb Connolly
> >>> <caleb.connolly@linaro.org> wrote:
> >>>>
> >>>> Hi all,
> >>>>
> >>>> Reviving this as it is still very much an issue, and especially
> >>>> relevant
> >>>> for Qualcomm platforms.
> >>>>
> >>>> On 11/3/23 20:44, Simon Glass wrote:
> >>>>> Hi Heinrich,
> >>>>>
> >>>>> On Wed, 25 Oct 2023 at 15:22, Heinrich Schuchardt
> >>>>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>>>
> >>>>>> On 10/25/23 23:13, Tom Rini wrote:
> >>>>>>> On Wed, Oct 25, 2023 at 10:28:05PM +0200, Mark Kettenis wrote:
> >>>>>>>>> Date: Wed, 25 Oct 2023 21:57:44 +0200
> >>>>>>>>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>>>>>>>
> >>>>>>>>> On 10/25/23 20:23, Simon Glass wrote:
> >>>>>>>>>> Hi Heinrich,
> >>>>>>>>>>
> >>>>>>>>>> On Tue, 24 Oct 2023 at 18:02, Simon Glass <sjg@google.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> Hi Heinrich,
> >>>>>>>>>>>
> >>>>>>>>>>> On Mon, 23 Oct 2023 at 23:20, Heinrich Schuchardt
> >>>>>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> Forward and backward compatibility of Linux kernel device-
> >>>>>>>>>>>> trees is
> >>>>>>>>>>>> sometimes missing. One solution approach is to load a kernel
> >>>>>>>>>>>> specific
> >>>>>>>>>>>> device-tree. This can either be done via a U-Boot scripts
> >>>>>>>>>>>> (like the one
> >>>>>>>>>>>> generated by Debian package flash-kernel or by a boot loader
> >>>>>>>>>>>> like GRUB.
> >>>>>>>>>>>> The boot loader approach currently requires to know the
> >>>>>>>>>>>> device-tree name
> >>>>>>>>>>>> before first boot which makes it unusable for generic images.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Expose the device-tree file name as EFI variable FdtFile.
> >>>>>>>>>>>> This will allow bootloaders to load a kernel specific
> >>>>>>>>>>>> device- tree.
> >>>>>>>>>>>
> >>>>>>>>>>> kernel-specific
> >>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> The variable will not be exposed on ACPI based systems or if
> >>>>>>>>>>>> the
> >>>>>>>>>>>> environment variable fdtfile is not defined.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Signed-off-by: Heinrich Schuchardt
> >>>>>>>>>>>> <heinrich.schuchardt@canonical.com>
> >>>>>>>>>>>> ---
> >>>>>>>>>>>> v4:
> >>>>>>>>>>>>             Generalize the description of the content of
> >>>>>>>>>>>> $fdtfile.
> >>>>>>>>>>>> v3:
> >>>>>>>>>>>>             Add documentation
> >>>>>>>>>>>> v2:
> >>>>>>>>>>>>             Use a unique GUID to enable future U-Boot
> >>>>>>>>>>>> independent
> >>>>>>>>>>>>             standardization.
> >>>>>>>>>>>>             Do not try to add the variable on ACPI based
> >>>>>>>>>>>> systems.
> >>>>>>>>>>>> ---
> >>>>>>>>>>>>      doc/develop/uefi/uefi.rst  | 14 ++++++++++++++
> >>>>>>>>>>>>      include/efi_loader.h       |  5 +++++
> >>>>>>>>>>>>      lib/efi_loader/efi_setup.c | 30 +++++++++++++++++++++++
> >>>>>>>>>>>> + ++++++
> >>>>>>>>>>>>      3 files changed, 49 insertions(+)
> >>>>>>>>>>>>
> >>>>>>>>>>>> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/
> >>>>>>>>>>>> uefi.rst
> >>>>>>>>>>>> index fb16ac743a..702c490831 100644
> >>>>>>>>>>>> --- a/doc/develop/uefi/uefi.rst
> >>>>>>>>>>>> +++ b/doc/develop/uefi/uefi.rst
> >>>>>>>>>>>> @@ -916,6 +916,20 @@ So our final format of the
> >>>>>>>>>>>> FilePathList[] is::
> >>>>>>>>>>>>
> >>>>>>>>>>>>          Loaded image - end node (0xff) - VenMedia -
> >>>>>>>>>>>> initrd_1 - [end node (0x01) - initrd_n ...] - end node (0xff)
> >>>>>>>>>>>>
> >>>>>>>>>>>> +EFI variable FdtFile
> >>>>>>>>>>>> +~~~~~~~~~~~~~~~~~~~~
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +Ideally U-Boot would always expose a device-tree that can
> >>>>>>>>>>>> be used for booting
> >>>>>>>>>>>> +any operating systems. Unfortunately operating systems like
> >>>>>>>>>>>> Linux sometimes
> >>>>>>>>>>>> +break forward and backward compatibility. In this case
> >>>>>>>>>>>> there is a need to load
> >>>>>>>>>>>> +an operating system version specific device-tree.
> >>>>>>>>>>>
> >>>>>>>>>>> This seems to be a strong statement. Given the effort that
> >>>>>>>>>>> goes into
> >>>>>>>>>>> the DT, changes are supposed to be backwards-compatible. Is this
> >>>>>>>>>>> generally true, or is it just that we want an up-to-date DT
> >>>>>>>>>>> for the
> >>>>>>>>>>> kernel to enable new features?
> >>>>>>>>>>
> >>>>>>>>>> Did you see this comment?
> >>>>>>>>>
> >>>>>>>>> It would have been nice to put the person which made that
> >>>>>>>>> comment on copy.
> >>>>>>>>>
> >>>>>>>>> The truth lies in the world "supposed":
> >>>>>>>>>
> >>>>>>>>> The idea of a device-tree that never needs to change is quite
> >>>>>>>>> old and
> >>>>>>>>> never became true on ARM devices.
> >>>>>>>>>
> >>>>>>>>> We all know Linux tends to break both forward and backward
> >>>>>>>>> compatibility
> >>>>>>>>> of device-trees. Here is a nice example:
> >>>>>>>>>
> >>>>>>>>> d0c6707ca423 ("arm64: dts: allwinner: H5: NanoPi Neo Plus2:
> >>>>>>>>> phy- mode
> >>>>>>>>> rgmii-id")
> >>>>>>>>>
> >>>>>>>>> Driver changes broke forward and backwards compatibility of a
> >>>>>>>>> lot of
> >>>>>>>>> Allwinner boards.
> >>>>>>>>
> >>>>>>>> Well, that happened in 2020.  Things have gotten better over time.
> >>>>
> >>>> (kinda off-topic context on DT version compat)
> >>>>
> >>>>   From what I've seen, there is not yet very much infrastructure or
> >>>> common practise in place in the kernel to handle parsing DTB in a
> >>>> backwards compatible way. For example there has been efforts to
> >>>> simplify
> >>>> the dwc3 devicetree for Qualcomm platforms with a series dating back
> >>>> about as far as this U-Boot patch!
> >>>>
> >>>> https://lore.kernel.org/linux-arm-msm/20250318-dwc3-refactor-
> >>>> v5-1-90ea6e5b3ba4@oss.qualcomm.com/
> >>>>
> >>>> Earlier versions attempted to convert the older DTS to the newer format
> >>>> internally, but after much discussion it was decided that this wasn't
> >>>> really feasible, instead the new approach is to duplicate the entire
> >>>> dwc3 driver to maintain DT compatibility.
> >>>>
> >>>> It's obviously good to see compatibility taken seriously, since it
> >>>> seems
> >>>> clear that if we ever want to treat DT as firmware, the kernel will
> >>>> need
> >>>> to do this (and eventually vendors could ship laptops with DT out of
> >>>> the
> >>>> box which works with upstream -- crazier things have happened).
> >>>>
> >>>> But I think in the mean time we still want to be able to drive distro
> >>>> adoption, and the way I see it teaching GRUB and systemd-boot about a
> >>>> new FdtFile EFI variable is going to make that way simpler...
> >
> > There was a discussion in the context of EBBR if this is the right way
> > forward. And the general opinion was that the compatible string should
> > be used for matching the dtb files.
>
> Ideally, the file name should contain the same information as the
> compatible string, or more. Currently in upstream there are devices with
> different display variants that have identical compatible strings but
> different dtb files.
>
> >
> >>>
> >>> GRUB is unlikely even to handle devicetree properly as it does not
> >>> implement FIT, nor the best-match algorithm in FIT. So everything is a
> >>> workaround.
> >
> > For the Qualcomm laptop case the current patch would not solve anything
> > as the selection of the device-tree needs to be based on SMBIOS value.
>
> I bought this idea up with the laptops team and the upstream Qualcomm
> maintainer, everyone agreed that this approach would be a much more
> scalable intermediate solution. Since the HWID matching stuff will just
> not scale or make it into distros easily (e.g. generic installer won't
> work on the laptops currently because of this).
>
> If my understanding of EFI is correct, it would be possible to set this
> variable on the laptops via EFI shell (or even some custom EFI app for
> simplicity), and there is a non-zero chance that we could get some
> vendors to support setting this variable directly in their EFI firmware
> setup.
>
> >
> > Systemd-boot allows to add a rule-table to the UKI header to select
> > device-trees from a UKI image.
> >
> > That is a smarter solution than trying to hard-code logic in U-Boot to
> > set fdtfile and an FdtFile EFI variable.
>
> Right, we try to guess fdtfile today in mach-snapdragon and that sucks.
> I brainstormed this a bit with Ilias and what we came up with is to have
> U-Boot embed the fdtfile value directly into the /chosen node of every
> DTB we build with OF_UPSTREAM. Since the paths are identical to the kernel.
>
> This way you can have a single U-Boot binary (as we support for
> Qualcomm) boot on different boards and whichever DTB you give to U-Boot
> (say qcom/sdm845-db845c.dtb for example) will be the value that FdtFile
> gets. Then sd-boot/GRUB will look for a DTB under the same name relative
> to the devicetree-dir for the kernel version you're booting.
>
> Yes long term all this is far from the ideal solution, but it's a lot
> better than what we have today and much less hacky than every other
> proposal I've seen particularly for the laptops.
>
> Most importantly, it doesn't require distro changes, we already know for
> sure that distros are not going to adopt FIT. Arguing on the merits is
> pointless.

While it is very hard to predict the future, I don't share your pessimism :-)

IMO UKI is a poor man's FIT and eventually it will end up with similar
features to FIT, just uglier and with less flexibility.

Regards,
Simon


>
> Kind regards,
>
> >
> >>
> >> FIT has nothing to do with DT loading
> >>>
> >>>>>>>
> >>>>>>> Well, yes and no.  Given the brief summary here, I bet this was just
> >>>>>>> like when phy-mode and am335x platforms had DT compatibility
> >>>>>>> broken and
> >>>>>>> the answer was that it was OK because the DT was incorrectly
> >>>>>>> describing
> >>>>>>> hardware. So this is the reminder that there are cases of
> >>>>>>> breaking DT
> >>>>>>> compatibility that are allowed. Even if the DT has been out (and
> >>>>>>> wrong)
> >>>>>>> for several years.
> >>>>>>>
> >>>>>>> That's not the main point of this thread and I don't want to derail
> >>>>>>> things further along this point, I just want to note that the
> >>>>>>> details
> >>>>>>> here reminded me of when things are allowed to be incompatible with
> >>>>>>> previous trees.
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>> Unfortunately I was off the list for a week or so, but I see this one
> >>>>> so will reply here.
> >>>>>
> >>>>>> You are conflating things:
> >>>>>>
> >>>>>> The EFI variable is a hint to the GRUB OS to find the correct
> >>>>>> device-tree file without scanning hundreds of device-tree. You can
> >>>>>> not
> >>>>>> build a compatibility check for it into U-Boot.
> >>>>>
> >>>>> Actually we can...and I think that is what we should do.
> >>>>
> >>>> No, how and where an EFI bootloader app chooses to load the FDT from is
> >>>> entirely implementation dependent. It may be extremely costly to
> >>>> compare
> >>>> compatible strings for every single dtb, and whether or not to do so is
> >>>> the decision of the distro anyways, all we can do in U-Boot is try to
> >>>> promote best practise (which clearly isn't compatible prop comparison
> >>>> for hundreds of DTBs...)
> >>>
> >>> U-Boot promotes best practice, which is to check the compatible
> >>> properties of hundreds of nodes in the FIT to find the right one.
> >>
> >> Distros don't ship FIT images (which would be absolutely huge by the
> >> way, 75M for all DTBs today), they ship DTBs in a directory structure
> >> following the kernel layout.
> >
> > It might make sense to support compressed FIT images.
> >
> > Whether all device-trees are stored as files in /lib/firmware/<kernel-
> > version>/device-tree/ or are part of the kernel image (FIT or UKI) does
> > not change the space requirement on disk.
> >
> > Best regards
> >
> > Heinrich
> >
> >>
> >> If the kernel started outputting FIT images with all DTBs it would
> >> have to be installed in addition to the directory layout, and only
> >> provide a considerably less efficient interface to pick a DTB.
> >>
> >> We want Fedora images that you download today to be able to boot and
> >> select an appropriate DTB. FIT is just not a good fit (haha) for this
> >> problem.
> >>
> >> A fit mapping compatible strings to filenames would be an improvement
> >> but that's so much additional complexity to come up with a value that
> >> U- Boot already has...
> >>
> >>>>
> >>>> Providing FdtFile as an EFI variable will make it possible for grub and
> >>>> systemd-boot to support the same kind of "fdtdir" property that
> >>>> extlinux
> >>>> does, this would simply enable versioned DTB loading for distros and
> >>>> make booting wayyyyy easier.
> >>>
> >>> It is perpetuating an incorrect approach, though. It won't lead to
> >>> happiness. Perhaps systemd-boot should support FIT?
> >>
> >> What do i even say to this. You haven't explained what's incorrect
> >>>
> >>> As to versions, the compatible string needs to handle that. We cannot
> >>> have a situation where we ship two different devices trees that have
> >>> the same compatible strings but different contents as there is no
> >>> (spec-correct) way to distinguish them.
> >>>
> >>>>
> >>>> With regards to the design, I think a good follow-up patch would set a
> >>>> default value for $fdtfile (and consequently FdtFile) from the
> >>>> DEVICE_TREE build variable as a constant (maybe only if OF_UPSTREAM is
> >>>> enabled).
> >>>
> >>> Please no. We should not continue down this broken path.
> >>
> >> ???
> >>>
> >>>>
> >>>> This would be correct in almost all cases (and wayyy better than the
> >>>> hacky fdtfile generating code we have in mach-snapdragon right now).
> >>>
> >>> Yes, but you really should figure out how to remove that code. It is
> >>> present on other boards too. One of the things not on my list (but I
> >>> wish it were) is to clean up how RISC-V does devicetree selection
> >>> within U-Boot.
> >>
> >> That is why i revived this patch...
> >>>
> >>>>>
> >>>>> For distro-boot, do you mean the scripts? We are trying to deprecate
> >>>>> those. Of course we have brought in all the same work-arounds, etc.,
> >>>>> but with bootstd we can start to clean things up, I hope.
> >>>>>
> >>>>> So let's think about how we can have U-Boot choose the right DT to
> >>>>> boot with.
> >>>>>
> >>>>> Regards,
> >>>>> Simon
> >>>>
> >>>> Heinrich, since it's been a while, if you aren't super interested in
> >>>> re-sending this patch I'd be happy to address the wording feedback and
> >>>> re-spin it, along with a patch setting the default $fdtfile (else I can
> >>>> send that as a follow-up).
> >>>
> >>> The best thing to do here is to use FIT. You can put all the FDTs in a
> >>> FIT and leave the kernel out, if necessary.
> >>
> >> You cannot do this, distros will not do this for thousands of FDTs
> >>>
> >>> Another idea, which I may have suggested before (can't remember) would
> >>> be to add an EFI service which U-Boot implements, which returns the
> >>> correct FDT to use. U-Boot can then scan the files one by one to
> >>> figure it out, although hopefully that would prompt someone to create
> >>> a FIT (or a text file?) which has this information in it.
> >>>
> >>> But fdtfile is just not the right approach.
> >>
> >> You've pushed for FIT but never explained why fdtfile is a bad solution.
> >>>
> >>>>
> >>>> I'll also open an issue for getting support for this added to
> >>>> systemd-boot.
> >>>
> >>> FIT?
> >>>
> >>> Regards,
> >>> Simon
> >>
> >
>
> --
> Caleb (they/them)
>
