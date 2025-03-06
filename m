Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C57C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 13:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B2F180756;
	Thu,  6 Mar 2025 14:57:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LFfxXgVm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9652808A2; Thu,  6 Mar 2025 14:57:07 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C98468003E
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 14:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e5b6f3025dso875323a12.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 05:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741269424; x=1741874224; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j8OVKXW6TAsRHdFQfG4STPF51LzPRuHBIfPNIbSTLPc=;
 b=LFfxXgVmOksmk+3WZCwOEVPMd/4Va1BapeBZlZleFNwvI+qEIrtqRB4fc6PouxKBxw
 ba8fcUpO+RyY0M1xwYiYSQC9HtZcMOW7e5Y5jFHE/J3myJJVz10YNutbyNxs7fgOgFR0
 qpUpiytR0UZatGhschFn5s/HAJxdT8KEJn3tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741269424; x=1741874224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j8OVKXW6TAsRHdFQfG4STPF51LzPRuHBIfPNIbSTLPc=;
 b=nV2b9/Iwp4RVNjt4yMslSAKQPrRypaC87/VnHT9E3Hrk7E9Nfg/r/MpZOefD/Q7Rol
 63nygOEK9etipB04uLEENwdDd7UIrajNR7UyZUmzGY7RrLZgL4Ha6MTWI7LOnxxiVgkn
 dVcWm3wGCMOo+IGcUjtRzAOIzuaZI2dqzCIT+sCy5HF5f6I6TFWynQ5Yzuij0nZOpDX1
 YdktxmWHDy1+OHdanXy9QcF4FL191j6D3xAZeTiks81Xa3NphrUl0yZN3Wnw0WP9g7ii
 p0XZTn0+6/w8NgUnTj3f3vOws/aBzN9qxkvfaI9CzNkuMaEYRX42sLCJQ7oRhalvqM6h
 166w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq3VDUOiqPdGffJxWARevtFyzs1v41SSyZ5J+iuHHHWv8pWt9fizVuR/9e9H6HEh+7t3zkejY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6UKbhuES3ePdaZPh1XL8Q2+WAHeNmxfK7D836/ysdfaU4GSRh
 JiWhXbyyQaUTskS2SW+Ts8J2agLdjT9DfWzncRBp2IfeDKYKOxK/HzbN9IR3qrp4+oKNFruERGw
 gwxco9bs1MVxwbzUNyIiTmuibwt0Oc8hoGpux
X-Gm-Gg: ASbGncsqIS1B3wLIpepzCvAEx/+GJhqA1n/A7Jiu+/tvYo8eo2+aRIiAsBMQYWUT5+K
 1/5A+Ltzt3uP7nCZfQk8CeUNOFQxpYkKs6RMC/rOyutRVClRQEV42EscUxrdOaWXKP7VlOoiKlS
 cPO/pUm6nCm72gYAQe+lDaIE+kmvY=
X-Google-Smtp-Source: AGHT+IEUj/eZZRGWcKjzXrJGbALPWZXOzrpHpcIRNO9JvhTmuN6HAEmmJ5/QjSsXliFkkMmwdVY9OzwURxTx0K9spVs=
X-Received: by 2002:a17:907:6d1c:b0:ac2:c06:ad9d with SMTP id
 a640c23a62f3a-ac20d8bc1ecmr677967666b.14.1741269423779; Thu, 06 Mar 2025
 05:57:03 -0800 (PST)
MIME-Version: 1.0
References: <SJ0PR12MB66857BFB90475FE74294CF0482C22@SJ0PR12MB6685.namprd12.prod.outlook.com>
 <e1cfde30-ae7f-4ae8-9845-0c13eaeae87f@canonical.com>
 <61343d7f-d372-495e-b5b3-0bbe14d05a4b@amd.com>
 <51079568-f45b-4d79-b427-0b3d66ad8739@canonical.com>
 <56ed3099-ac7d-4224-a2e6-a38d31f0b29f@amd.com>
 <CAFLszTjxxYTxWhva9T8ER2_pNeLLoEpWCy467BvsB_eVQXnkoQ@mail.gmail.com>
 <d4d04e4b-e87a-4c89-a68d-944b180fba12@amd.com>
In-Reply-To: <d4d04e4b-e87a-4c89-a68d-944b180fba12@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Mar 2025 06:56:52 -0700
X-Gm-Features: AQ5f1Jo4BY0MHbnVQpu62I5vDTRrgCtqymW86Z9OeGl4V6NZR5LKoQ5EgmNZ3ZE
Message-ID: <CAFLszTg804YAxrLmUukPGAiPWKrV5PM+ihGQvwFax49eFNEm6w@mail.gmail.com>
Subject: Re: Halting auto-boot process in the U-Boot shell
 https://lore.kernel.org/u-boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>, "Begari,
 Padmarao" <Padmarao.Begari@amd.com>, 
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "Kummari,
 Prasad" <Prasad.Kummari@amd.com>
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

Hi Michal,

On Fri, 28 Feb 2025 at 07:42, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Simon,
>
> On 2/27/25 17:25, Simon Glass wrote:
> > Hi Michal,
> >
> > On Wed, 26 Feb 2025 at 02:04, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 2/26/25 09:59, Heinrich Schuchardt wrote:
> >>> On 2/26/25 09:28, Michal Simek wrote:
> >>>>
> >>>>
> >>>> On 2/26/25 09:23, Heinrich Schuchardt wrote:
> >>>>> On 2/26/25 07:48, Kummari, Prasad wrote:
> >>>>>> [AMD Official Use Only - AMD Internal Distribution Only]
> >>>>>>
> >>>>>>
> >>>>>> Hi Heinrich,
> >>>>>>
> >>>>>> Regarding below commit.
> >>>>>>
> >>>>>> commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85
> >>>>>> Author:     Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>>>>> AuthorDate: Tue Jun 14 08:02:03 2022 +0200
> >>>>>> Commit:     Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>>>>> CommitDate: Sun Jun 19 15:53:09 2022 +0200
> >>>>>>
> >>>>>>       efi_loader: initialize console size late
> >>>>>>
> >>>>>>       If CONFIG_VIDEO_DM=n we query the display size from the serial console.
> >>>>>>       Especially when using a remote console the response can be so late that
> >>>>>>       it interferes with autoboot.
> >>>>>>
> >>>>>> *    Only query the console size when running an EFI binary.*
> >>>>>>
> >>>>>> https://lore.kernel.org/u-boot/20220614060203.33600-1-
> >>>>>> heinrich.schuchardt@canonical.com/ <https://lore.kernel.org/u-
> >>>>>> boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/>
> >>>>>>
> >>>>>> Commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85 modifies the system to query
> >>>>>> the console size only when running an EFI binary. However, when
> >>>>>> CONFIG_EFI_CAPSULE_ON_DISK is enabled, the console is still being invoked,
> >>>>>> which shouldn't happen. This results in issues on our terminal, which cannot
> >>>>>> handle the resulting characters, leading to incorrect display and halting
> >>>>>> the auto-boot process in the U-Boot shell.
> >>>>>>
> >>>>>> *Log Output:*
> >>>>>>
> >>>>>> Warning: ethernet@ff0c0000 (eth0) using random MAC address - ee:df:0a:38:a8:c4
> >>>>>>
> >>>>>> eth0: ethernet@ff0c0000, eth1: mrmac@a40f0000, eth2: mrmac@a40f1000, eth3:
> >>>>>> mrmac@a40f2000, eth4: mrmac@a40f3000
> >>>>>>
> >>>>>> Cannot persist EFI variables without system partition
> >>>>>>
> >>>>>> Missing TPMv2 device for EFI_TCG_PROTOCOL
> >>>>>>
> >>>>>> Missing RNG device for EFI_RNG_PROTOCOL
> >>>>>>
> >>>>>> Hit any key to stop autoboot:  0
> >>>>>>
> >>>>>> *Versal> [42;173R*
> >>>>>>
> >>>>>> *Unknown command '[42' - try 'help'*
> >>>>>
> >>>>> Hello Prasad,
> >>>>>
> >>>>> The terminal emulation seems to be sending a valid reply indicating 42 rows
> >>>>> and 173 columns.
> >>>>>
> >>>>> It could be that in your setup you are hitting the time out in term_get_char().
> >>>>>
> >>>>> Could you, please, check what happens if you apply
> >>>>>
> >>>>> --- a/lib/efi_loader/efi_console.c
> >>>>> +++ b/lib/efi_loader/efi_console.c
> >>>>> @@ -92,8 +92,7 @@ static int term_get_char(s32 *c)
> >>>>>           timeout = timer_get_us() + 100000;
> >>>>>
> >>>>>           while (!tstc())
> >>>>> -               if (timer_get_us() > timeout)
> >>>>> -                       return 1;
> >>>>> +               ;
> >>>>>
> >>>>>           *c = getchar();
> >>>>>           return 0;
> >>>>>
> >>>>> If the failure disappears, next you would have to analyze why the timeout is
> >>>>> occurring (e.g. timer_get_us() running too fast).
> >>>>>
> >>>>> If you still get failures, please, add debug output term_read_reply() to
> >>>>> understand what is happening.
> >>>>
> >>>> But why is this send at this stage? Why capsule update needs to be aware about
> >>>> size of terminal? I understand that you need to know it for efi application
> >>>> but what's the reason to know it capsule update?
> >>>>
> >>>> Thanks,
> >>>> Michal
> >>>>
> >>>>
> >>>
> >>> Hello Michal,
> >>>
> >>> There are two separate questions to answer:
> >>>
> >>> * Why does determining the console not work?
> >>>
> >>> The problem can only occur EFI enabled systems. If determining the console size
> >>> fails here, we can expect it to fail when running EFI applications, too.
> >>
> >> yes but you don't know if users are going to boot over EFI or via legacy way.
> >> You can still use capsule update part only and using bootm/booti for booting.
> >>
> >>>
> >>> * Why is the EFI console initialized here?
> >>>
> >>> We have currently only one entry-point for initializing the whole of the EFI
> >>> sub-system. We are using the console before running any EFI application, e.g. in
> >>> the eficonfig command.
> >>>
> >>> This could be redesigned with some effort.
> >>
> >> And I think it should. Because there is no reason to do initialization of
> >> anything what it is not going to be used. At the end of day it is just delaying
> >> boot.
> >
> > Agreed. My attempt to resolve this for a similar situation just
> > resulted in my case being a bad example[1]. But this is just bad
> > design.
>
> Glad to see your patches.
> Not sure if implementation is fitting our needs but it is showing exactly the
> problem.
> I pretty much think that nothing should be done unless you explicitly asks for
> it. And I can't see any variable/Kconfig option which is enabled to start to
> call these chars.
>
> I am considering this as bug which should be fixed in this release because it is
> unintentionally breaking boot. I also expect that this is pretty much nice to
> have feature to use bigger screen instead of basic 80x25.

From my side I'm unable to get patches into EFI_LOADER and have tried
repeatedly to adjust the ANSI logic[2]. So I'm going to leave it to
others to figure out.

Regards,
Simon

>
> Thanks,
> Michal
>
>
> >
> > Regards,
> > SImon
> >
> > [1] https://lore.kernel.org/u-boot/20240926215950.1265143-9-sjg@chromium.org/
>

[2] https://patchwork.ozlabs.org/project/uboot/patch/20231121113557.800353-5-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20240811145209.4191404-37-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20240815202424.766778-11-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20240902011825.746421-11-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20240926215950.1265143-9-sjg@chromium.org/
https://patchwork.ozlabs.org/project/uboot/patch/20240926220226.1265965-9-sjg@chromium.org/
