Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8E7C07533
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 15:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 800C4842D0;
	Wed, 15 Nov 2023 16:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PBjxlwNH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 184C886FB2; Wed, 15 Nov 2023 16:05:30 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03ED884003
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 16:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a8ee23f043so78511767b3.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 07:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700060726; x=1700665526; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KwSX/yjDa2dgx1fu1gTIROe3gZupaZsTSScej14Dpps=;
 b=PBjxlwNHVstSDb05UV3/BlhgYNE8abTeqPprZq8yvOAaRzWEKrTZSwYGtqAPVMBdJ9
 683/Llo7tAwVHl3fyLZjpNEaHKH6K79Ipx6F+35WSc/62WD6TbBelk25rGbWAO7+a+Zw
 UkLKUyKhVKUyzS2L2+8jZ1uypTQ8FqsTaH8G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700060726; x=1700665526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KwSX/yjDa2dgx1fu1gTIROe3gZupaZsTSScej14Dpps=;
 b=EKp46ZEBzIxYszzs40x4pmRUNAloDx8Oofb45t/E5gqG3V36KJYxhALIqAVl/CIZ/J
 hukLMKymzcSDesLbWDkRqeSI4d5CFRaxXBCGg7uZtxh8y4OZ87HD34+326EG5iEJvYht
 xC9y9oXnlefDeZQUj9nwC1gkdhprUhBCa/CpR2VG3vqAP20tjbQ4Bjh1RyLE+7R8d6Kx
 P6ZLt6ebtPdjEyTkrdO1AC0H+Sl+3Y1c7NV0mk56lpdhoOCccn1AsOnbkX5HGGgajWyO
 PqQJmY42lJfR3lm1zSaqpGwGvYKEPGK86MdN3NuvuCPvhheLKDOjBAt1fr0pNS+XX9PH
 MD6A==
X-Gm-Message-State: AOJu0YxOs4tAqVLkwLzlsnZ5K7fFHYY2bPRxpM7SkZ9K3OZ4HiMPBdi2
 wzF2lk4XD4GuYP3Iw5sM78Dc8REQncLDYlVlKWgV2Q==
X-Google-Smtp-Source: AGHT+IEP2OC1AeQ1gQWjBlzcoCJ/S+fU9l9bFymSUrgIIXiHilnLShnR67c4rXIZeR6mCkkdTbZebEfF+gvs6SVwCgo=
X-Received: by 2002:a81:a107:0:b0:5a7:af97:c787 with SMTP id
 y7-20020a81a107000000b005a7af97c787mr12880536ywg.11.1700060726448; Wed, 15
 Nov 2023 07:05:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
 <CAPnjgZ1-_ohZaVwMGtTDt4-W--2q0AM2KPtX9RLgAbMEhMRugw@mail.gmail.com>
 <CAHc5_t1icj6d82GH+FK8qGg3MvDkpwEicH964ULcN971_=aSKg@mail.gmail.com>
 <CAHc5_t2vLU9gHufMS_Fjv6j5+E8ksgCCLzKQ7NxTHzJsdcmsNQ@mail.gmail.com>
In-Reply-To: <CAHc5_t2vLU9gHufMS_Fjv6j5+E8ksgCCLzKQ7NxTHzJsdcmsNQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 08:05:13 -0700
Message-ID: <CAPnjgZ3VY_M+zd2na+N9WCxj-L2F+KKhLgykQ21FTA7GPVrKNQ@mail.gmail.com>
Subject: Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Shantur,

On Wed, 15 Nov 2023 at 07:50, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Simon,
>
> I did some testing on the USB 3.0 port and it seems like bootflow
> causes something to happen to the USB.
> It seems to be only reproducible on the USB3.0 port.
>
> I am using an AMicro   AM8180 NVME to USB adapter on the USB3.0 port
> of RockPro64.

Is this the blue port on top of the USB-C connector?

>
> Booting the Armbian installation using

Which version of Armbian / download link?

>
> => fatload usb 0:1 ${kernel_addr_r} EFI/boot/bootaa64.efi
> 979672 bytes read in 6 ms (155.7 MiB/s)
> => bootefi ${kernel_addr_r}
>
> works 100%, no issues with USB whatsoever.
>
> Booting same with
>
> => setenv boot_targets usb
> => setenv bootmeths efi
> => bootflow  scan -lb
> Scanning for bootflows in all bootdevs
> Seq  Method       State   Uclass    Part  Name                      Filename
> ---  -----------  ------  --------  ----  ------------------------
> ----------------
> Scanning bootdev 'usb_mass_storage.lun0.bootdev':
>   0  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo
> efi/boot/bootaa64.efi
> ** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_1' with efi
>
> And I see issues with USB device not communicating properly like
>
> [   50.182144] sd 0:0:0:0: [sda] tag#29 uas_eh_abort_handler 0 uas-tag
> 24 inflight: CMD OUT
> [   50.182957] sd 0:0:0:0: [sda] tag#29 CDB: opcode=0x2a 2a 00 03 4e
> e9 78 00 00 08 00
> [   55.270116] xhci-hcd xhci-hcd.2.auto: xHCI host not responding to
> stop endpoint command
> [   55.284476] xhci-hcd xhci-hcd.2.auto: xHCI host controller not
> responding, assume dead
> [   55.285494] xhci-hcd xhci-hcd.2.auto: HC died; cleaning up
>
> This is 100% reproducible.
>
> Is bootflow doing something different to USB than normal fatload +
> bootefi, I see internally it uses bootefi as well.

Yes it is scanning first, before reading the efi app, etc.

I have the same hardware so may be able to dig into this.

Regards,
Simon
