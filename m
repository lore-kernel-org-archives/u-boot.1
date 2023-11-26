Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CC3C4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 16:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA4AC871A4;
	Sun, 26 Nov 2023 17:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D4RWfuDo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F8AD871ED; Sun, 26 Nov 2023 17:10:11 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A47786FB4
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 17:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c876e44157so41726091fa.2
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 08:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701015007; x=1701619807; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UNycHbKsz1Tha7u/LqAllBRWxgA3l2yWF2IMlLgBkww=;
 b=D4RWfuDo3GFLgh+zExUjgCOoIKBM3WyH2b0Svq/iortE8H67DJOCQt3hr56ZPGGyGU
 iHauAPMqcGOX6sZlr6aa17CpJXpMri7zei9zPrERSvbFS3Som4TYeNY781RXqm/NFtSN
 Jg0mlwcgvOVr4431S/yHqlr+xe40SU4TET6VWbqPoROvPCEt1/CVEbEk456w5TvO6tM1
 AyUE0wNYfDXU3Dhq95MtKVzFM5rcQxNG9EQUYf77dPJqmjiN21MWUUAy9c6f/sidHZ4z
 B/96ijSzK6emqLBxFgZF1fSpL1XoV695dxkHo32D7sCvVqdYvAiZQyFoh741n4xya17R
 mUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701015007; x=1701619807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UNycHbKsz1Tha7u/LqAllBRWxgA3l2yWF2IMlLgBkww=;
 b=vqYY3c10V/We8C6rhnJFTXc0BbOQoFLMqN2RlDVGv8TOZYwUI9YtcZAZxVOSpUYxRl
 Wc9FSv71H1tl2J/swxI1f02O4IZ01ZH45dBWIb8ch7Fg5a6sIt0W8+SWbDJwIzfTb610
 GVnULe12VhzfW06BQaR1al3ov7rBFOfm5tDr5qqaIEvbG9kJYrxcX6WFeIFo+s3UQfCz
 BfR85428mIpmER1YuVCNE+dVJDVrcGIw8QiyddknWpQq0v/r+OMxCLlFDuPSdiQJ0TOh
 L+w4zn0NZqXDEifMB6ba4DbUCYi0bNtNNSovd7EX1KVLCf9rzIwPtuxmDV2IxsGmMgUb
 T1Mg==
X-Gm-Message-State: AOJu0YyqWFstBOVoORvtM662OIDw8LtIR48yjHpraDMhEkwLXa1e85Ji
 RAF16YfjHoy6ohsHl9bE5Ja+ELpQE251WkyBylNjlC3IIDA=
X-Google-Smtp-Source: AGHT+IFie4ZqfKlbc7y8ONb38mtAoKLoD2cK4XVung7F+sFuQ0+bpYfj+18SBhm4UClFJ6ItSD5oQ4QqduRQ8KTE00M=
X-Received: by 2002:a05:6512:e89:b0:50a:b2d5:9c8d with SMTP id
 bi9-20020a0565120e8900b0050ab2d59c8dmr7251969lfb.55.1701015007200; Sun, 26
 Nov 2023 08:10:07 -0800 (PST)
MIME-Version: 1.0
References: <CABEcMwVkWqwKVGCUTJw366rM7qk1NGGpJ_Aw8cX4wRCSvJMwPw@mail.gmail.com>
 <CAC_iWjKNf6RxPoKzPjJiLV+UnQES344wb=sqS1wCnQzC+J-Hkw@mail.gmail.com>
 <CAHc5_t0UNC5PPxJ3ji4ToOqzHpcSovYRUJbb2ZJ64qTTOZ+1Bw@mail.gmail.com>
 <CALeDE9ONK7CMP6DXKRrjzqxm1r-afB7bgKSDhekrhOMUnhhktQ@mail.gmail.com>
 <CAHc5_t3QQUT=aid9NYRysPvtVG31Ohtvo=RxZkDPo9W9saQUdA@mail.gmail.com>
In-Reply-To: <CAHc5_t3QQUT=aid9NYRysPvtVG31Ohtvo=RxZkDPo9W9saQUdA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 26 Nov 2023 16:09:55 +0000
Message-ID: <CALeDE9PUGYW0BW2w144ZetSegfxeNr-DtNZREe_AoU1=-7tyqQ@mail.gmail.com>
Subject: Re: efi: Set Variable Runtime implementation
To: Shantur Rathore <i@shantur.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 takahiro.akashi@linaro.org, U-Boot Mailing List <u-boot@lists.denx.de>
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

> > > > > I am trying to work out how to enable the SetVariableRT service in
> > > > > U-Boot and came across your patch [1] which initially had the
> > > > > SetVariable RT service enabled in EFI but in the final patch this was
> > > > > removed.
> > > > > I am hoping to implement it on top of the SPI Flash EFI store [2] to
> > > > > be able to set Boot order and boot items from Linux the UEFI way.
> > > > >
> > > > > Can I pick your brain on why it was dropped in the patch?
> > > > > Is there any limitation in SetVariableRT service ?
> > > >
> > > > I recently had a talk about it in Plumbers [0]. Generally speaking, RT
> > > > + hardware owned by the kernel is a very weird combination since you
> > > > can't guarantee exclusive access to the flash or the bus and you have
> > > > to preserve a *lot* of code alive in u-boot.
> > > >
> > > > I'll respond to your v1 patchset and we can discuss details there as well.
> > > >
> > > > [0] https://lpc.events/event/17/contributions/1653/
> > >
> > > Thanks for the background and helping me understand the problem.
> > > Makes me wonder how things work in the PC world.
> > > U-boot being only ~1MB, can we not leave it all in memory and maybe
> > > just disable SPI access to Linux.
> >
> > That's basically it, on x86 there's specific HW that's owned by
> > firmware, I don't know the exact low level details of how that works.
> >
> > I think x86 devices generally use eSPI for this HW [1] but I don't
> > know the low level details. The Arm SBSA (Server HW spec) and SBBR
> > (Server Base Boot Requirements) specs that are key to ServerReady may
> > go into some details too if you're curious.
>
> Thanks,
> I think the firmware is still accessible to PCs as one could update the firmware
> in Windows so Windows has access to that device.

I believe in most cases what happens is the OS sets up the update
ready so the firmware itself can apply it on a reboot. This is how
UEFI Capsule update works.

If you run "fwupdmgr security" on a Linux system you can see some
security features like "SPI lock" and "SPI write". I have at least one
x86 hobbyist system where you can enable/disable the SPI access/lock
but even with that the firmware update is done from the UEFI shell.

> I had some try myself and found that setting a variable to memory backed storage
> is doable with SetVariable call but we want to store it in any
> non-volatile storage
> things really don't look good.
>
> To be able to write SetVariable to any device, the whole u-boot driver
> model would need
> to be kept in memory, might as well just keep the whole u-boot in
> memory at this point, it's anyway small.
> I don't have much knowledge on how to or pros and cons of doing this.

I believe when set variable is running there is a small subset of
U-Boot in memory but Ilias will definitely know the details there.

> >
> > BTW I plan to test your other patches on the Pinebook Pro.
> >
> > [1] https://www.totalphase.com/blog/2021/09/what-is-the-espi-protocol-and-how-does-it-improve-upon-lpc/
>
> Thanks, that would be helpful.
> I am particularly keen on the usb patch here
> https://patchwork.ozlabs.org/project/uboot/patch/20231110141311.512334-1-i@shantur.com/

I'll take a look.

Peter
