Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECE6C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 21:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56AE8874FC;
	Wed, 25 Oct 2023 23:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="U5mJ7g96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762E4874D7; Wed, 25 Oct 2023 23:05:24 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48FA0874D7
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 23:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso232545a12.2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698267921; x=1698872721; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ulOmT9dlBnIgHg5zilaRyzBIwXeH7NHnajzCuWOZx5Q=;
 b=U5mJ7g96maXv1IuMXNleQrUvlKaM2ztQqcoooqmRODr+MDlSbySpmIXicpilMa+TA+
 BnTeQGGVjQfL9VS8H56BCkYdlhxDxTRpj/ftz7SJYBY5Vilwj1RB844jpBaOopb5px4k
 SQsD3pLo45sRcoPBZJ/+tvUeLpI/sgGe3uFIUe/09phKHOizlGQp35mE54Ogdsnb/MEP
 3HzwwoevHVdoPbrKMbkzYLUJ4KbDfWgpestGhCeah3BvRpEezD8seLBntPhdKRFpIrMs
 gvrOWuMIeToQZ4xYP4weSTPPvoe3SbFXPd/iYBegpmHF546jmAznTlnMA3mDntzEFF0G
 4Ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698267921; x=1698872721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ulOmT9dlBnIgHg5zilaRyzBIwXeH7NHnajzCuWOZx5Q=;
 b=RUIFTPl5m0K+iqQ+Wy4fmG0vFHz2CV0Z8cdL0FB/x5UbHciNxVbQMqPI+Dg/pqwlKe
 ZqObrh1bmQAKrB3g1g6BjU/wVVX1RqQ2NG/JoHTYgiW/Ml2imViposqxZz+mAr8exija
 ZCtHkJesBHA415wAd2kEdST31JybOWQCJ0iD7H5+ldJv/NsiB2F/ESFtRVZgW5CHpRUe
 APa+P0JAykujsYvnvKPfBD7dY+Tm6vi7D9qubPAM2f8w+O36aUjfQOFoaiMGWiq4TPHO
 EUL9gIWtgwPrfXxXHtxCZkImb6pl0YwWrrgpJ0fSI/6d1FWuUq7aSvLrq8P5PcS0gFIc
 IBLw==
X-Gm-Message-State: AOJu0Yy2MfDaQDtV/kCq1X+dOlZkn6+8ac1B9b9o/us7BfT2k+qyn6fi
 qlI2zONS6oPi4qLk/vU3x6fuV5DYVZaf+4kya49Mug==
X-Google-Smtp-Source: AGHT+IGIVzOrVZdSFJlyL63AJmZf3PiFfblxeQeWMh3QSeaXjmYgiKyWFMissSvZ0r6rXsHv1hDx1WbGG4i8KmDH+6I=
X-Received: by 2002:a50:f681:0:b0:53e:fd81:67ab with SMTP id
 d1-20020a50f681000000b0053efd8167abmr10418784edn.6.1698267921453; Wed, 25 Oct
 2023 14:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231024062032.8543-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ07zojtkV6ReQiC3XPf_AW96YnAc6APqhfk7wUDMmyOrA@mail.gmail.com>
 <CAPnjgZ3zFnAaivWa1BaUDbTfzRc-SZ_H8+YSvAKtwBJ64=XftQ@mail.gmail.com>
 <1ac5013d-8991-4abd-baad-94776801c58c@canonical.com>
 <87a5s6qwfe.fsf@bloch.sibelius.xs4all.nl>
 <10833e97-46ab-4a14-8e4a-c6e3dd5eb376@canonical.com>
In-Reply-To: <10833e97-46ab-4a14-8e4a-c6e3dd5eb376@canonical.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 25 Oct 2023 21:05:03 +0000
Message-ID: <CAPnjgZ0u7fPkjKAca8KOdE8Zib9QGh57ieZDgh-j80MQGntLWw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] efi_loader: expose the device-tree file name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de, trini@konsulko.com
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

On Wed, 25 Oct 2023 at 20:51, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 10/25/23 22:28, Mark Kettenis wrote:
> >> Date: Wed, 25 Oct 2023 21:57:44 +0200
> >> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>
> >> On 10/25/23 20:23, Simon Glass wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Tue, 24 Oct 2023 at 18:02, Simon Glass <sjg@google.com> wrote:
> >>>>
> >>>> Hi Heinrich,
> >>>>
> >>>> On Mon, 23 Oct 2023 at 23:20, Heinrich Schuchardt
> >>>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>>
> >>>>> Forward and backward compatibility of Linux kernel device-trees is
> >>>>> sometimes missing. One solution approach is to load a kernel specific
> >>>>> device-tree. This can either be done via a U-Boot scripts (like the one
> >>>>> generated by Debian package flash-kernel or by a boot loader like GRUB.
> >>>>> The boot loader approach currently requires to know the device-tree name
> >>>>> before first boot which makes it unusable for generic images.
> >>>>>
> >>>>> Expose the device-tree file name as EFI variable FdtFile.
> >>>>> This will allow bootloaders to load a kernel specific device-tree.
> >>>>
> >>>> kernel-specific
> >>>>
> >>>>>
> >>>>> The variable will not be exposed on ACPI based systems or if the
> >>>>> environment variable fdtfile is not defined.
> >>>>>
> >>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>>> ---
> >>>>> v4:
> >>>>>           Generalize the description of the content of $fdtfile.
> >>>>> v3:
> >>>>>           Add documentation
> >>>>> v2:
> >>>>>           Use a unique GUID to enable future U-Boot independent
> >>>>>           standardization.
> >>>>>           Do not try to add the variable on ACPI based systems.
> >>>>> ---
> >>>>>    doc/develop/uefi/uefi.rst  | 14 ++++++++++++++
> >>>>>    include/efi_loader.h       |  5 +++++
> >>>>>    lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
> >>>>>    3 files changed, 49 insertions(+)
> >>>>>
> >>>>> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> >>>>> index fb16ac743a..702c490831 100644
> >>>>> --- a/doc/develop/uefi/uefi.rst
> >>>>> +++ b/doc/develop/uefi/uefi.rst
> >>>>> @@ -916,6 +916,20 @@ So our final format of the FilePathList[] is::
> >>>>>
> >>>>>        Loaded image - end node (0xff) - VenMedia - initrd_1 - [end node (0x01) - initrd_n ...] - end node (0xff)
> >>>>>
> >>>>> +EFI variable FdtFile
> >>>>> +~~~~~~~~~~~~~~~~~~~~
> >>>>> +
> >>>>> +Ideally U-Boot would always expose a device-tree that can be used for booting
> >>>>> +any operating systems. Unfortunately operating systems like Linux sometimes
> >>>>> +break forward and backward compatibility. In this case there is a need to load
> >>>>> +an operating system version specific device-tree.
> >>>>
> >>>> This seems to be a strong statement. Given the effort that goes into
> >>>> the DT, changes are supposed to be backwards-compatible. Is this
> >>>> generally true, or is it just that we want an up-to-date DT for the
> >>>> kernel to enable new features?
> >>>
> >>> Did you see this comment?
> >>
> >> It would have been nice to put the person which made that comment on copy.
> >>
> >> The truth lies in the world "supposed":
> >>
> >> The idea of a device-tree that never needs to change is quite old and
> >> never became true on ARM devices.
> >>
> >> We all know Linux tends to break both forward and backward compatibility
> >> of device-trees. Here is a nice example:
> >>
> >> d0c6707ca423 ("arm64: dts: allwinner: H5: NanoPi Neo Plus2: phy-mode
> >> rgmii-id")
> >>
> >> Driver changes broke forward and backwards compatibility of a lot of
> >> Allwinner boards.
> >
> > Well, that happened in 2020.  Things have gotten better over time.
>
> The 2020 event struck me because a Linux kernel would not even be
> compatible with the device-tree of the same kernel release.
>
> This year I once again had issues with booting an Allwinner board with a
> device-tree from a different Debian kernel version. Both backward and
> forward compatibility were broken. But at least I could boot with a
> matching device-tree.

Oh dear.

>
> >
> >> Distros will continue to load the device-tree that matches the kernel to
> >> get the best possible board support and need to do this efficiently.
> >
> > Right.  Even if there is full backward/forward compatibility, you
> > probably want the latest device-tree to make sure you get the most
> > complete hardware support.
> >
> > But this shouldn't be used as an argument to not care about
> > backward/forward compatibility.
>
> Nobody in this thread suggested to not care about forward and backward
> compatibility.

The key thing we need to agree on is that the compatible string is the
source of truth for booting. You check the model compatible and search
for a matching DT with the best match, taking into account board
revisions, etc. It is defined to be correct. If for some reason this
process is wrong, then the board *should not boot*.

So anything which suggests that the above is not correct, or doesn't
always work, or doesn't work well with EFI...is really going in the
wrong direction.

Of course there will be workarounds, like this one, but the 'correct'
way of doing it must still work. Nor is it 'slow' to do this, as I
have demonstrated.

Perhaps we should add a compatible check into U-Boot, to make sure we
are not choosing the wrong DT? At least for me, trying to get the
filename right is a bit of a pain, with so many characters looking the
same.

Regards,
Simon
