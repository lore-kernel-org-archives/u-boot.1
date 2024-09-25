Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26A7C369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBE6688C60;
	Wed, 25 Sep 2024 14:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i729y0Yl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3375D88B6D; Wed, 25 Sep 2024 14:50:36 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D27A88BD2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cb25aad5dfso3168276d6.3
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727268632; x=1727873432; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=chYLyTg5fHKfBO2ZsRFHKhSjjSy9bj+k0VnIQWnkuRU=;
 b=i729y0Yl/RNmx4cOvEIxMVqka+WNPer00WPbEyaMGdKp8WH8rzPZ6bGLwZPiVlc00Q
 Bk0rFAOJpUxCAe95z+YsO4lbHZFEpWAlWbQ5rGRH72Jte9RqLkov+56of33DZjuv0ocy
 0BAkoQ08mt9DyU6CQiSNpTuWtp+Zp2iWfdUzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727268632; x=1727873432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=chYLyTg5fHKfBO2ZsRFHKhSjjSy9bj+k0VnIQWnkuRU=;
 b=T73aKQyUze8ddfjUf0kaNZkgqSt/LYrEGiHo6GRi3XHS6m4lzKUTf6Zj2b7lpVUFeu
 doxhIKM0QWoOvB3ummcHqNexATul8y7WftwKzD2U3px0jowIex9rZj1MWMiO9OofEFGA
 cDURJ6kw45dw+qVUsBoL8fIkNC2Qbv18RRCwkVVLPx5anUERrPTMMFo5GksdmVHIpSzS
 l2mEbL7N5/l7S6a4m/TYdO5FHuHaTmStmjmYwozno+Mrqonuefb8fkRFNEZRIddppD+g
 uJQ9eoiO4KpDtt1nWQKy2xOfl/9vbfpPxcHHT0aW/nVtDDM60n/Qu50Z9Dam1uZ4wNor
 luiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtTtwQSWo2gszUcqqTvmVshRsDxrswrxa45aUoGU5MTDiciy9W+eDBGJgWOoEmXFztK99F6pE=@lists.denx.de
X-Gm-Message-State: AOJu0YzvnU7v6c+mnKk3ILfw5cnWWuZA9tdh/YixApem0hbtdZbRAQGJ
 LjUovR3FgZ+bGONQTn9bniBgrVlm+deKLhExWPluYZqbaAaW5prcyaG3pel/Nwsi1gwYsqt62V/
 jcCIeNz3RLWLlRMa6eetsyMIek+y6BlWT1fHZ
X-Google-Smtp-Source: AGHT+IHNmvM0JbCX+Be0yoqbNMRxg/l9wFptdLDDpDq2nws6TiEzrDwjJmOFwaIREmcC8vOema3XzsXkFsWu3NT/Ulk=
X-Received: by 2002:a05:6214:4a01:b0:6c5:26ac:d857 with SMTP id
 6a1803df08f44-6cb1de0c7bemr35832396d6.50.1727268632117; Wed, 25 Sep 2024
 05:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240914160548.42551-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjL46Gb03MS7znLujAKC0VkgOrUaZMy7XPw-jpw3TELTA@mail.gmail.com>
 <d95b95d2-7afb-42f2-9a01-75d601368be9@canonical.com>
 <CAC_iWjLCnUpnVGuVYnhzo4EaUmKMSZPws3hSzOOvQqirC71hfQ@mail.gmail.com>
 <CAFLszTimJuwFKp6DaRDJ22=0tbNPYbcLMT9hcFrC9Rca6vzAyg@mail.gmail.com>
 <b8d1cef7-4e56-49c6-aeca-b471a82870cd@canonical.com>
 <CAC_iWjLY9Oea-AryLyrQJ3zXX+Bihza5B8R5UpXh58K3+Ff=Xw@mail.gmail.com>
 <CAFLszTgASXx5t7=T+yLtC0W9dwo=FkQPF5T6eYD2uyFUWE6D_A@mail.gmail.com>
 <CAC_iWjJL2tHTe84iqOkzDxANed-TdOObDYoW2jUwe3T=x=cyqA@mail.gmail.com>
 <CAFLszTghAmCGoiHq+iBwBRC99ucBOUGG+mjq8HEjUVkPAJu-ZQ@mail.gmail.com>
 <CAC_iWjKLODdFV701vo-ECEo+_U6NQoLS=HsrgmS+RyDHd5pi0A@mail.gmail.com>
 <CAFLszTits7gXaCfCzwvOOwLcYOtHSPBTh8H+5o5jgZ2wh4eNuQ@mail.gmail.com>
 <CAC_iWjKetz0BUriZ__khwQaPshadFFNsdZXyN8rtPe8VpkkVwg@mail.gmail.com>
 <CAFLszTgL-S3jeXK=OWTaqGKtSQDMo=JjiHT3w4+xup+d4Qr4kA@mail.gmail.com>
 <00f85c61-4d15-4d38-ad0d-f039715ed1d6@canonical.com>
In-Reply-To: <00f85c61-4d15-4d38-ad0d-f039715ed1d6@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Sep 2024 14:50:19 +0200
Message-ID: <CAFLszThs-uPmLjNnve4TgKxVCEiNyhnCBE0x6ACLcBuG64p7mA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_leader: delete rng-seed if having EFI RNG protocol
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Sun, 22 Sept 2024 at 15:43, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 20.09.24 17:58, Simon Glass wrote:
> > Hi Ilias,
> >
> > On Fri, 20 Sept 2024 at 09:37, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Simon,
> >>
> >> On Fri, 20 Sept 2024 at 10:25, Simon Glass <sjg@chromium.org> wrote:
> >>>
> >>> Hi Ilias,
> >>>
> >>> On Thu, 19 Sept 2024 at 17:51, Ilias Apalodimas
> >>> <ilias.apalodimas@linaro.org> wrote:
> >>>>
> >>>> On Thu, 19 Sept 2024 at 18:39, Simon Glass <sjg@chromium.org> wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> On Thu, 19 Sept 2024 at 17:37, Ilias Apalodimas
> >>>>> <ilias.apalodimas@linaro.org> wrote:
> >>>>>>
> >>>>>> On Thu, 19 Sept 2024 at 18:19, Simon Glass <sjg@chromium.org> wrote:
> >>>>>>>
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> On Thu, 19 Sept 2024 at 17:13, Ilias Apalodimas
> >>>>>>> <ilias.apalodimas@linaro.org> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On Thu, Sep 19, 2024, 18:05 Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On 19.09.24 17:00, Simon Glass wrote:
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>> On Thu, 19 Sept 2024 at 16:32, Ilias Apalodimas
> >>>>>>>>>> <ilias.apalodimas@linaro.org> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> Hi all,
> >>>>>>>>>>>
> >>>>>>>>>>> On Thu, 19 Sept 2024 at 17:20, Heinrich Schuchardt
> >>>>>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 19.09.24 16:10, Simon Glass wrote:
> >>>>>>>>>>>>> Hi Heinrich,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
> >>>>>>>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> For measured be boot we must avoid any volatile values in the device-tree.
> >>>>>>>>>>>>>> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Could you explain a bit why this is, and where this is checked?
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Measured boot relies on creating hashes of artifacts and writing these
> >>>>>>>>>>>> to TPM. If the hashes don't match the OS will either warn or refuse to
> >>>>>>>>>>>> boot. The device-tree is one of the artifacts that are measured.
> >>>>>>>>>>>>
> >>>>>>>>>>>> If we have random values in /chosen, measured boot will fail.
> >>>>>>>>>>>>
> >>>>>>>>>>>> When an EFI RNG protocol is provided by the firmware, GRUB and the
> >>>>>>>>>>>> kernel will use it instead of /chosen/rng-seed and /chosen/kaslr-seed.
> >>>>>>>>>>>
> >>>>>>>>>>> There's a comment on top of that function that explains what happens as well.
> >>>>>>>>>>> In short the EFI stub does not even look at the KASLR seed and never
> >>>>>>>>>>> randomizes the physical placement of the kernel. It only does that
> >>>>>>>>>>> when the EFI_RNG protocol is there.
> >>>>>>>>>>
> >>>>>>>>>> OK thank you. I suppose I am more just wondering why it got added in
> >>>>>>>>>> the first place?
> >>>>>>>>>
> >>>>>>>>> For booting via the legacy Linux entry point adding kaslr-seed allows to
> >>>>>>>>> randomize addresses. QEMU adds rng-seed instead of kaslr-seed.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Not the kernel physical placement. It randomizes only the virtual placement
> >>>>>>>
> >>>>>>> So, are you saying that U-Boot adds this field into the FDT and then removes it?
> >>>>>>
> >>>>>> Yes. As Heinrich said, the rng seed is still usable for some
> >>>>>> randomization. If we boot with EFI and have an RNG protocol, we dont
> >>>>>> need it and it also messes up the TPM measurements, so we remove it.
> >>>>>> But the code that injects it to u-boot, or the prior bootloader that
> >>>>>> handed you over a DT,  does not know if you plan to boot with EFI.
> >>>>>
> >>>>> I'm actually surprised that this works. Normally, removing a property
> >>>>> does not drop that property from the string table, so adding a
> >>>>> property and deleting it is not normally the same as never adding it.
> >>>>> But perhaps that has changed?
> >>>>>
> >>>>> Anyway, I think we should add the property when we know it is OK to do
> >>>>> so, which is just before we boot. If you agree I can take a look at
> >>>>> that.
> >>>>
> >>>> Sure, but we won't be able to remove this code. There are still
> >>>> first-stage boot loaders that might send you a DT over a bloblist,
> >>>> that has a kaslr-seed
> >>>
> >>> But then I don't see what problem that causes...I'm just going to
> >>> leave this madness to you :-)
> >>>
> >>
> >> The problem is that in theory, we need to measure a DT as early as
> >> possible, but that's not doable in U-Boot yet. The TCG specs have no
> >> guidance on measuring DTs, but do have on ACPI tables and we basically
> >> copy what's done for ACPI.
> >>
> >> The DT is more fragile though. As Heinrich said if you decide to
> >> measure it, you can't have random values -- whether that comes from
> >> U-Boot injecting those or a previous loader is irrelevant. The result
> >> is the same, if you have random values in the measured DT, e.g a mac
> >> address or a kaslr-seed the measurements we take on PCR1 will be
> >> different and as a result kind of useless.
> >>
> >> For the reasons above, measuring a DT is not in any default config.
> >> It's up to the user whether he wants to measure it or not. But for the
> >> kaslr-seed, since the kernel does not use it when booting via EFI and
> >> the EFI_RNG protocol is installed, we remove it.
> >>
> >> Hope that clarifies things a bit
> >
> > Yes it does, thank you.
> >
> > IMO measuring the devicetree should really be done using a hash of
> > only part of the tree, for example excluding the /options node and
> > perhaps /chosen as well. I just looked to refresh my memory, and
> > adding then removing a property does not result in the same DT as
> > before the addition.
>
> We must not exclude the /chosen node as it may contain:
>
> * /chosen/bootargs - Command line arguments must be measured.
> * /chosen/initrd - Filename of the initial RAM disk.
>
> For more items see
> https://www.kernel.org/doc/Documentation/devicetree/bindings/chosen.txt.
>
> >
> > There are several reasons I have this opinion:
> > - The DT is used for things which don't relate to Linux, such as /options/u-boot
> > - The DT may have overlays applied
> > - Some DT nodes may have been 'fixed' up by U-Boot
> >
> > So if we want to 'measure' the DT, we should probably provide in the
> > DT an indication of which part is hashed, so Linux etc. can take that
> > into account. Also we may want to have multiple hashes, to deal with
> > the case of additions being made. We have something similar to this
> > with FIT signatures, but that mechanism is not suitable here (although
> > it could perhaps help inspire a solution).
>
> Current Linux just expects the measurement. It would not to be able to
> consume any information describing which part of the DT has been measured.
>
> The idea of measurement is that it should capture the whole state. We
> cannot generally exclude fix-ups:
>
> If memory is added and U-Boot changes the device-tree accordingly, this
> should change the measurement.
>
> If the network card is replaced with a different card resulting in a
> different MAC address copied to the device-tree, this should change the
> measurement, too.

Yes, anything that is used must be measured.

But removing things from the devicetree does not generally put it back
to the state before they were added. That's really the main point I
was trying to get across.

Regards,
Simon
