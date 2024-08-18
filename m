Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B26C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 15:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C116E88852;
	Sun, 18 Aug 2024 17:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JXvkYNQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81EF68886A; Sun, 18 Aug 2024 17:25:42 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C01C88744
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 17:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e02b79c6f21so3774378276.2
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723994739; x=1724599539; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b9rZMTguH/6mczAH8UwwgY80USLEsnqIXEaZUlIqDJw=;
 b=JXvkYNQXp94mvV9+e/EjGicDjbKuor4zlDwhev8NpQZAW6ezfBFswCvwdNSj9PAzY/
 4NF52yHFG60RDaGcnFqtnAg1uiOfNtcPctK4xqpQ5H7dT8SXP7KWk/j2NkaoIzo/pkw+
 mtW+7FwNRagfndjPW8+vtIUGOG0rlTQpqqzQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723994739; x=1724599539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b9rZMTguH/6mczAH8UwwgY80USLEsnqIXEaZUlIqDJw=;
 b=kqZGADtkDPtnxJhhgzDw/DYhmqnkn6k0pkeNH7Qn3ZosdvFCwoWvyKvN/eMTQCXO1X
 l8NhOD2MHwUd8fuwxZ/h2Or8dog7Sy+vmR0EA0BqsavfItG/1ifXuyd47Qo7ooWZ13P4
 cNbgndAhEmZfKgHOQ/C+FhGr/GKF/VPc019hraVxm+QjvrFgpEboS5VGS/LXIVD6ail0
 GxKMxuNuyrHWyVEsLX2ZTZh8VqprK1kTUhYVUPAsATDrA4Y1EO2I9vBTSCEUiH78HsQh
 mvelEG7tVDG6uWpnpWfg8qK1UF1MZ/W/d+ExtphesCV4mmqsZegCvTC2A6io0unmVvvy
 j49A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8IglDAYAXMgmZsMS21JdJ/0B74gZ/gQsl3W+s3Wpwn/g8Z4zI8f9YJplOtyHJZKwkxIxIi7LG8uQk/n70o6PwpPSIOg==
X-Gm-Message-State: AOJu0YwudOYjTFUTKrzIIe7hpZEcuZOfzhjCq8SqFgoUCMSC6loVYw+d
 FAKcs6x13IGd0t4RCzTB3E376iOrEhNlEGT4TBlzUVZDRJs2PQaSWYXTRHGYyhhZODmRPbswD8u
 5SnJ7q94sWPGazBKVibXOEIsIJTmPZgyR3ND6
X-Google-Smtp-Source: AGHT+IEK4y7lr3AObKS+mRdLq+O1gsU9dqopMOiGtKRNZMBp4Zs2GhI3RYtACogKTzZqkM7sRbaX5bmnpKpFU+k5kUc=
X-Received: by 2002:a05:6902:c0f:b0:e11:7858:9478 with SMTP id
 3f1490d57ef6-e1180ec8334mr8201210276.22.1723994738944; Sun, 18 Aug 2024
 08:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240814134518.82692-1-ilias.apalodimas@linaro.org>
 <CAFLszTjrBL-GonZKqp3Ab5vQPMZ+BZu8V21y4z0qBCGuH64uJw@mail.gmail.com>
 <CAC_iWjKF0DMfJza-ojYXPg_tHL14DTdK+GzhxhEX3etpaNiK8Q@mail.gmail.com>
 <CAFLszTjfhtRqRTdQOi-Dhzpa_aVSVSU8FjWmXEKz5vi=_0i=BA@mail.gmail.com>
 <CAC_iWj+gi30VzTFcJiHY9YzUt13Jne9oBVRsESYTknmJZaSXtg@mail.gmail.com>
In-Reply-To: <CAC_iWj+gi30VzTFcJiHY9YzUt13Jne9oBVRsESYTknmJZaSXtg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 18 Aug 2024 16:25:27 +0100
Message-ID: <CAFLszTjNh339F2po+j2XG4ym1vp4gBOuFuCUsZH9dZtZNrFq8w@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: clean up the efi configuration status
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Shengyu Qu <wiagn233@outlook.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Greg Malysa <greg.malysa@timesys.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Anand Moon <linux.amoon@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Eddie James <eajames@linux.ibm.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Ilias,

On Fri, 16 Aug 2024 at 19:49, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
> On mobile apologies for any weird formatting in advance.
>
> On Fri, Aug 16, 2024, 04:34 Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Ilias,
>>
>> On Thu, 15 Aug 2024 at 15:11, Ilias Apalodimas
>> <ilias.apalodimas@linaro.org> wrote:
>> >
>> >
>> >
>> > On Thu, Aug 15, 2024, 23:33 Simon Glass <sjg@chromium.org> wrote:
>> >>
>> >> Hi Ilias,
>> >>
>> >> On Wed, 14 Aug 2024 at 07:45, Ilias Apalodimas
>> >> <ilias.apalodimas@linaro.org> wrote:
>> >> >
>> >> > The EFI_LOADER and EFI config options are randomly scattered under lib/
>> >> > making it cumbersome to navigate and enable options, unless you really
>> >> > know what you are doing. On top of that the existing options are in
>> >> > random order instead of a logical one.
>> >> >
>> >> > So let's move things around a bit and present two enties for the
>> >>
>> >> entries
>> >>
>> >> > EFI_LOADER and EFI options in the main config screen.
>> >> > While at it add menus for Capsules, Protocols, and Services in the
>> >> > EFI_LOADER so people can find their way around easier
>> >> >
>> >> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> >> > ---
>> >> >  Kconfig                |   4 +
>> >> >  lib/Kconfig            |   2 -
>> >> >  lib/efi/Kconfig        |   5 +
>> >> >  lib/efi_loader/Kconfig | 202 +++++++++++++++++++++++------------------
>> >> >  4 files changed, 123 insertions(+), 90 deletions(-)
>> >> >
>> >> > diff --git a/Kconfig b/Kconfig
>> >> > index 82df59f176ec..62c5441e3576 100644
>> >> > --- a/Kconfig
>> >> > +++ b/Kconfig
>> >> > @@ -756,3 +756,7 @@ source "lib/Kconfig"
>> >> >  source "test/Kconfig"
>> >> >
>> >> >  source "tools/Kconfig"
>> >> > +
>> >> > +source "lib/efi_loader/Kconfig"
>> >> > +
>> >>
>> >> This should be included from boot/Kconfig as it relates to booting.
>> >
>> >
>> > Hmm why? Booting is one of the things efi does. I prefer having it on the main menu since it's a pointer to the entire spec, protocols, services etc
>>
>> True. From a functionality point of view, there is booting and
>> firmware update. Is there anything else? I have thought for a while
>> that we should perhaps have an 'update' menu. Where, for example,
>> would VBE fit in the menus?
>
>
> Why don't we do something similar for VBE? I agree that those are the 2 main categories, but I think it's far more intuitive to have all in one place depending on what to choose to boot and upgrade your device.
>
> Otherwise you have to enable the 'boot method' and start navigation around for updates etc.

Hmm, for now (I think?) we have everything related to boot and update
in boot/ - is that right? So I would favour having the 'EFI' thing in
boot/Kconfig. It is a bit like BOOTSTD_DEFAULTS, where we enable the
common things that people are likely to want. So when you turn on
EFI_LOADER (which is generally on by default) you get the booting and
updating features. Maybe the EFI_LOADER should be just for the loader
and we should have something more generic (EFI_DEFAULTS ?) to enable
the common things.

We don't have an equivalent for VBE, but sometime before the end of
Sept I will post the A/b/recovery method and it will be in better
shape.

>
>>
>> >
>> >
>> >>
>> >> The EFI app thing should perhaps be under there too...I'm not sure.
>> >
>> >
>> > I was toying around with the idea as well. But eventually I decided this needs it's own entry since it's about building U-Boot as a pe/coff. I don't mind changing this though.
>>
>> Yes, building as an app isn't really about booting. It looks very
>> lonely at the end of the menu, though.
>
>
> I'll fold this in to UEFI

Seems reasonable to me. Oddly U-Boot doesn't fully support booting
with UEFI when booted from UEFI...some sort of pass-through. So for
now the EFI app and EFI loader are not really related. But we
certainly don't want it at the top level.

Regards,
Simon
