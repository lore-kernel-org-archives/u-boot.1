Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC8EC19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D2CB8123D;
	Thu, 27 Feb 2025 17:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VxgNDoQm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3611681250; Thu, 27 Feb 2025 17:25:53 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6261810F5
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ab78e6edb99so155404066b.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740673550; x=1741278350; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k9WcDdsiV7ezaNSD+Z1c0dpMn3D2UUwjwfDh41VrFgU=;
 b=VxgNDoQmoVJXhJwrOp0V61CIHEiVwiNzAGBENjjP/Sv27VbLfI6YKd3z5PwxJejA1u
 I9ZE9bo/zgtPmaqlZ18lxmUIuK387theTQigfdw5JxoAakMO2v526jiNncZ7/610JA3j
 4ZXe9AXg0FQLjDOLdORIhfTZvDTnWvcldWF3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673550; x=1741278350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k9WcDdsiV7ezaNSD+Z1c0dpMn3D2UUwjwfDh41VrFgU=;
 b=VUUtolgYke7MseX4y29DqaIPGWe+oLpXBN8gAbKtfo/bREOnrgLv0l2D3xyKALrjls
 zHLwLKcg4ma6zx52ZvFgIWgqNXTnNEqIj/whvAhrf1TTANlljcQ/KNvHsEZ6Liz5Zb/T
 EVoDaelIWXXh2b3ymHR/Jtx8y5LIKPk5sK0RG1oZBUQvx8SrIQlKcx0SXQEmxlgdmy4p
 w7FF5pnPPXW9WI1O9aELRhuBBHyp1bLKx5wg2Xyhi3IioKOGJsAmoJMHXtx69vjTVT1T
 hlIgsjJhBG78FpMI1lFLnKrV85saMD//NxOTssEPpnBuLC+28a+l9AoSoQg2og2lymVC
 WJJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9zWo1LFVK+UeENBzr00xsx33bbhSm6gjiXcOlbh4VjxrzWIJUs+yCaQK/PAl8MzHqi4WqT2Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyJN98OzzoO7BXPOqC0ZaYxw+w7ZKKUcwBNgDEeODlqmST5rJ5n
 j2R/QvKyLDIRZ2Op5K+wCLbO9CTueP5IlbKTMYF2eIlBuEyl9abV/blByomytf4HTWH8e4rpzDa
 S6t6FtoQvIEQraST+BjH8MOfu00b9j/FcXFsc6cqEz+TWC8o=
X-Gm-Gg: ASbGnctd9nba3GTBL0paXmBqyEqk/gKuuRs3ZWNMDAGPcYsCOFKrg+T2CBTtTAarsge
 gSb+JL3CTXvF4F5tQGl+Q9kpp0e0UwqGKEXyDFLTJY7GxfNYgUcKxWQFouCyo+k3sWL8FKWDksg
 9hLZSjqi7C
X-Google-Smtp-Source: AGHT+IG+C5d3wsNZ13nDxmxkapBqNp0x1fYWmWt5gWX0ac6BapPcAR4317HhdCtkhu5qa71mom7duWu39aJq0Xb6if0=
X-Received: by 2002:a17:907:86ac:b0:ab6:df79:f577 with SMTP id
 a640c23a62f3a-abf25d945c1mr8490566b.9.1740673550120; Thu, 27 Feb 2025
 08:25:50 -0800 (PST)
MIME-Version: 1.0
References: <SJ0PR12MB66857BFB90475FE74294CF0482C22@SJ0PR12MB6685.namprd12.prod.outlook.com>
 <e1cfde30-ae7f-4ae8-9845-0c13eaeae87f@canonical.com>
 <61343d7f-d372-495e-b5b3-0bbe14d05a4b@amd.com>
 <51079568-f45b-4d79-b427-0b3d66ad8739@canonical.com>
 <56ed3099-ac7d-4224-a2e6-a38d31f0b29f@amd.com>
In-Reply-To: <56ed3099-ac7d-4224-a2e6-a38d31f0b29f@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Feb 2025 09:25:37 -0700
X-Gm-Features: AQ5f1Jrj4-vOD4lRx7swPW20Vg9P7W4kz-7cWFizRF-Dhw5DZAtgCo6SNYwYhto
Message-ID: <CAFLszTjxxYTxWhva9T8ER2_pNeLLoEpWCy467BvsB_eVQXnkoQ@mail.gmail.com>
Subject: Re: Halting auto-boot process in the U-Boot shell
 https://lore.kernel.org/u-boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/
To: Michal Simek <michal.simek@amd.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
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

On Wed, 26 Feb 2025 at 02:04, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 2/26/25 09:59, Heinrich Schuchardt wrote:
> > On 2/26/25 09:28, Michal Simek wrote:
> >>
> >>
> >> On 2/26/25 09:23, Heinrich Schuchardt wrote:
> >>> On 2/26/25 07:48, Kummari, Prasad wrote:
> >>>> [AMD Official Use Only - AMD Internal Distribution Only]
> >>>>
> >>>>
> >>>> Hi Heinrich,
> >>>>
> >>>> Regarding below commit.
> >>>>
> >>>> commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85
> >>>> Author:     Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>>> AuthorDate: Tue Jun 14 08:02:03 2022 +0200
> >>>> Commit:     Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>>> CommitDate: Sun Jun 19 15:53:09 2022 +0200
> >>>>
> >>>>      efi_loader: initialize console size late
> >>>>
> >>>>      If CONFIG_VIDEO_DM=n we query the display size from the serial console.
> >>>>      Especially when using a remote console the response can be so late that
> >>>>      it interferes with autoboot.
> >>>>
> >>>> *    Only query the console size when running an EFI binary.*
> >>>>
> >>>> https://lore.kernel.org/u-boot/20220614060203.33600-1-
> >>>> heinrich.schuchardt@canonical.com/ <https://lore.kernel.org/u-
> >>>> boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/>
> >>>>
> >>>> Commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85 modifies the system to query
> >>>> the console size only when running an EFI binary. However, when
> >>>> CONFIG_EFI_CAPSULE_ON_DISK is enabled, the console is still being invoked,
> >>>> which shouldn't happen. This results in issues on our terminal, which cannot
> >>>> handle the resulting characters, leading to incorrect display and halting
> >>>> the auto-boot process in the U-Boot shell.
> >>>>
> >>>> *Log Output:*
> >>>>
> >>>> Warning: ethernet@ff0c0000 (eth0) using random MAC address - ee:df:0a:38:a8:c4
> >>>>
> >>>> eth0: ethernet@ff0c0000, eth1: mrmac@a40f0000, eth2: mrmac@a40f1000, eth3:
> >>>> mrmac@a40f2000, eth4: mrmac@a40f3000
> >>>>
> >>>> Cannot persist EFI variables without system partition
> >>>>
> >>>> Missing TPMv2 device for EFI_TCG_PROTOCOL
> >>>>
> >>>> Missing RNG device for EFI_RNG_PROTOCOL
> >>>>
> >>>> Hit any key to stop autoboot:  0
> >>>>
> >>>> *Versal> [42;173R*
> >>>>
> >>>> *Unknown command '[42' - try 'help'*
> >>>
> >>> Hello Prasad,
> >>>
> >>> The terminal emulation seems to be sending a valid reply indicating 42 rows
> >>> and 173 columns.
> >>>
> >>> It could be that in your setup you are hitting the time out in term_get_char().
> >>>
> >>> Could you, please, check what happens if you apply
> >>>
> >>> --- a/lib/efi_loader/efi_console.c
> >>> +++ b/lib/efi_loader/efi_console.c
> >>> @@ -92,8 +92,7 @@ static int term_get_char(s32 *c)
> >>>          timeout = timer_get_us() + 100000;
> >>>
> >>>          while (!tstc())
> >>> -               if (timer_get_us() > timeout)
> >>> -                       return 1;
> >>> +               ;
> >>>
> >>>          *c = getchar();
> >>>          return 0;
> >>>
> >>> If the failure disappears, next you would have to analyze why the timeout is
> >>> occurring (e.g. timer_get_us() running too fast).
> >>>
> >>> If you still get failures, please, add debug output term_read_reply() to
> >>> understand what is happening.
> >>
> >> But why is this send at this stage? Why capsule update needs to be aware about
> >> size of terminal? I understand that you need to know it for efi application
> >> but what's the reason to know it capsule update?
> >>
> >> Thanks,
> >> Michal
> >>
> >>
> >
> > Hello Michal,
> >
> > There are two separate questions to answer:
> >
> > * Why does determining the console not work?
> >
> > The problem can only occur EFI enabled systems. If determining the console size
> > fails here, we can expect it to fail when running EFI applications, too.
>
> yes but you don't know if users are going to boot over EFI or via legacy way.
> You can still use capsule update part only and using bootm/booti for booting.
>
> >
> > * Why is the EFI console initialized here?
> >
> > We have currently only one entry-point for initializing the whole of the EFI
> > sub-system. We are using the console before running any EFI application, e.g. in
> > the eficonfig command.
> >
> > This could be redesigned with some effort.
>
> And I think it should. Because there is no reason to do initialization of
> anything what it is not going to be used. At the end of day it is just delaying
> boot.

Agreed. My attempt to resolve this for a similar situation just
resulted in my case being a bad example[1]. But this is just bad
design.

Regards,
SImon

[1] https://lore.kernel.org/u-boot/20240926215950.1265143-9-sjg@chromium.org/
