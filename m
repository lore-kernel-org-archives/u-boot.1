Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFEDC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 19:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A00B8719D;
	Fri,  3 Nov 2023 20:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Sj1E0vYU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 296C7871FC; Fri,  3 Nov 2023 20:44:25 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D4C870BF
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 20:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507bd644a96so3430754e87.3
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 12:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1699040657; x=1699645457; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9C6QqZpylMTp/R9eCJV2w4kCiD+sfpMIyvH1fMgjZY=;
 b=Sj1E0vYU9H1263KuU/4rO5KFUoIlKIPGsYiYsyZcvSQXEwgFiHJFsuYo6xolAOqCbi
 s8Cn1Wzk3L8AbzGer2E94OOiZsE0mHrs6RkIMdNi9GtBH+crSJpUodSS4AcPtXMEjF/C
 k5xMFGfesdPlc/XHl8PoYBYYfHed+F2MaHTjFIwT4EW0nKdq+778CFVVa/daCxl7RTna
 NL5KAnRRaNoUgVC2JBBjpXcCpeATLUnyTwWH1HuedeZL5VXTE3vutKyWrEUiow7uTauv
 iy13KhGbb5o5seJKN6v45tBZKIBLW8Wh1izVhR3RbP4VnZTi4yRkJVLhfVpE+1C4sDII
 JKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699040657; x=1699645457;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y9C6QqZpylMTp/R9eCJV2w4kCiD+sfpMIyvH1fMgjZY=;
 b=ToBmJTriHNf2VD3j7wue4wd5iy7lST26W/tQul/+Jwi8hH+xP9fPfMdkbozVTOefwO
 8og0Lz1F+LlsvqWuxdVPIUnMUVXwuz09nmm/2ZwDBRBc6zMrzG4eEvrPuK8n06CY5/Po
 s5PCsEoetxs1WTHJuri1i6I6AoM1tR4yZP5y39X4vC6Ia02Bshd6wPlrlnIoQDKrAqH6
 QgxUFes46BEIHCpbsMzdMoI1n9UfHURjzOoQ1WDT/dLBn7jmrNjR0vFy+OZ75d5UpTtR
 Xg7lNDPnhJ/QZ5nxYdMv63pdtPrJG4XrqLAOa02+ul4M5RZNxtGJDFSz0+5L/WaX/5sI
 pgfw==
X-Gm-Message-State: AOJu0YxTO/27zB7bzL5GjTZoP9aUZRXYjQBQXylFb4VRHZfEcDP3N+De
 66l0jTdzP9Dprg7HbvDokgyg77SW+d3qPPJRuzQJ1xvYIbaJoZivQzw=
X-Google-Smtp-Source: AGHT+IEBbQYf5od8ZYc57YyUO+4oZOXcVXXEh194z8ifQa4WrBIgv8K+SjH46BTC2fAvzed7Dl3wT1o7QM6w2ceiaZ4=
X-Received: by 2002:a19:ca5b:0:b0:507:9ff3:ae82 with SMTP id
 h27-20020a19ca5b000000b005079ff3ae82mr16028223lfj.18.1699040657289; Fri, 03
 Nov 2023 12:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231024062032.8543-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ07zojtkV6ReQiC3XPf_AW96YnAc6APqhfk7wUDMmyOrA@mail.gmail.com>
 <CAPnjgZ3zFnAaivWa1BaUDbTfzRc-SZ_H8+YSvAKtwBJ64=XftQ@mail.gmail.com>
 <1ac5013d-8991-4abd-baad-94776801c58c@canonical.com>
 <87a5s6qwfe.fsf@bloch.sibelius.xs4all.nl>
 <20231025211354.GZ496310@bill-the-cat>
 <f5e39630-0065-42e3-95a9-91e608e2c919@canonical.com>
In-Reply-To: <f5e39630-0065-42e3-95a9-91e608e2c919@canonical.com>
From: Simon Glass <sjg@google.com>
Date: Fri, 3 Nov 2023 13:44:06 -0600
Message-ID: <CAPnjgZ1zzWZ48nn2ux7yd1pJ4mWVOt4w2ToBZC6MR2wcxbnMsQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] efi_loader: expose the device-tree file name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de, Mark Kettenis <mark.kettenis@xs4all.nl>
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

On Wed, 25 Oct 2023 at 15:22, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 10/25/23 23:13, Tom Rini wrote:
> > On Wed, Oct 25, 2023 at 10:28:05PM +0200, Mark Kettenis wrote:
> >>> Date: Wed, 25 Oct 2023 21:57:44 +0200
> >>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>
> >>> On 10/25/23 20:23, Simon Glass wrote:
> >>>> Hi Heinrich,
> >>>>
> >>>> On Tue, 24 Oct 2023 at 18:02, Simon Glass <sjg@google.com> wrote:
> >>>>>
> >>>>> Hi Heinrich,
> >>>>>
> >>>>> On Mon, 23 Oct 2023 at 23:20, Heinrich Schuchardt
> >>>>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>>>
> >>>>>> Forward and backward compatibility of Linux kernel device-trees is
> >>>>>> sometimes missing. One solution approach is to load a kernel specific
> >>>>>> device-tree. This can either be done via a U-Boot scripts (like the one
> >>>>>> generated by Debian package flash-kernel or by a boot loader like GRUB.
> >>>>>> The boot loader approach currently requires to know the device-tree name
> >>>>>> before first boot which makes it unusable for generic images.
> >>>>>>
> >>>>>> Expose the device-tree file name as EFI variable FdtFile.
> >>>>>> This will allow bootloaders to load a kernel specific device-tree.
> >>>>>
> >>>>> kernel-specific
> >>>>>
> >>>>>>
> >>>>>> The variable will not be exposed on ACPI based systems or if the
> >>>>>> environment variable fdtfile is not defined.
> >>>>>>
> >>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>>>> ---
> >>>>>> v4:
> >>>>>>           Generalize the description of the content of $fdtfile.
> >>>>>> v3:
> >>>>>>           Add documentation
> >>>>>> v2:
> >>>>>>           Use a unique GUID to enable future U-Boot independent
> >>>>>>           standardization.
> >>>>>>           Do not try to add the variable on ACPI based systems.
> >>>>>> ---
> >>>>>>    doc/develop/uefi/uefi.rst  | 14 ++++++++++++++
> >>>>>>    include/efi_loader.h       |  5 +++++
> >>>>>>    lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
> >>>>>>    3 files changed, 49 insertions(+)
> >>>>>>
> >>>>>> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> >>>>>> index fb16ac743a..702c490831 100644
> >>>>>> --- a/doc/develop/uefi/uefi.rst
> >>>>>> +++ b/doc/develop/uefi/uefi.rst
> >>>>>> @@ -916,6 +916,20 @@ So our final format of the FilePathList[] is::
> >>>>>>
> >>>>>>        Loaded image - end node (0xff) - VenMedia - initrd_1 - [end node (0x01) - initrd_n ...] - end node (0xff)
> >>>>>>
> >>>>>> +EFI variable FdtFile
> >>>>>> +~~~~~~~~~~~~~~~~~~~~
> >>>>>> +
> >>>>>> +Ideally U-Boot would always expose a device-tree that can be used for booting
> >>>>>> +any operating systems. Unfortunately operating systems like Linux sometimes
> >>>>>> +break forward and backward compatibility. In this case there is a need to load
> >>>>>> +an operating system version specific device-tree.
> >>>>>
> >>>>> This seems to be a strong statement. Given the effort that goes into
> >>>>> the DT, changes are supposed to be backwards-compatible. Is this
> >>>>> generally true, or is it just that we want an up-to-date DT for the
> >>>>> kernel to enable new features?
> >>>>
> >>>> Did you see this comment?
> >>>
> >>> It would have been nice to put the person which made that comment on copy.
> >>>
> >>> The truth lies in the world "supposed":
> >>>
> >>> The idea of a device-tree that never needs to change is quite old and
> >>> never became true on ARM devices.
> >>>
> >>> We all know Linux tends to break both forward and backward compatibility
> >>> of device-trees. Here is a nice example:
> >>>
> >>> d0c6707ca423 ("arm64: dts: allwinner: H5: NanoPi Neo Plus2: phy-mode
> >>> rgmii-id")
> >>>
> >>> Driver changes broke forward and backwards compatibility of a lot of
> >>> Allwinner boards.
> >>
> >> Well, that happened in 2020.  Things have gotten better over time.
> >
> > Well, yes and no.  Given the brief summary here, I bet this was just
> > like when phy-mode and am335x platforms had DT compatibility broken and
> > the answer was that it was OK because the DT was incorrectly describing
> > hardware. So this is the reminder that there are cases of breaking DT
> > compatibility that are allowed. Even if the DT has been out (and wrong)
> > for several years.
> >
> > That's not the main point of this thread and I don't want to derail
> > things further along this point, I just want to note that the details
> > here reminded me of when things are allowed to be incompatible with
> > previous trees.
> >
>

Unfortunately I was off the list for a week or so, but I see this one
so will reply here.

> You are conflating things:
>
> The EFI variable is a hint to the GRUB OS to find the correct
> device-tree file without scanning hundreds of device-tree. You can not
> build a compatibility check for it into U-Boot.

Actually we can...and I think that is what we should do.

>
> In distro-boot we are using the same value from environment variable
> $fdtfile. Here you could check the compatible string but this might
> break booting .

We need to figure that point out. The compatible string is
programmatically is defined to be correct, so it is the filename that
may/may not be useful. What am I missing?

For distro-boot, do you mean the scripts? We are trying to deprecate
those. Of course we have brought in all the same work-arounds, etc.,
but with bootstd we can start to clean things up, I hope.

So let's think about how we can have U-Boot choose the right DT to boot with.

Regards,
Simon
