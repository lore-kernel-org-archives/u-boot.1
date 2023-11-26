Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D645C4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 10:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6745487006;
	Sun, 26 Nov 2023 11:34:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="vs2koIx5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B24871BE; Sun, 26 Nov 2023 11:34:03 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB66B87005
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 11:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a00c200782dso475235966b.1
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 02:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700994839; x=1701599639;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p1L5w9k33K3CzjjSCrYG/5s6RbPMiKb7WGtJAM0ofzA=;
 b=vs2koIx58xI4ezhpAppi8NTTe4rfAhKPThsIy0vLDGV5UTDY/wdHWmtbYF7PnbqMTz
 VUbVuuRiL3bWAkkinljqdVXqzibXQ9qWJKULjvt6rJI9U5DKPuVK5RipShqpaqRoVO7A
 SpW5OpH+X71xkekXJiPL38/mAl4yzsGKWD4A34QsOyfTZrJRNAKvqODyw5SY3zsEUOvp
 EVkeNn7KJ6AZkBNr9sN1m9vU5h1rmHUUBGkSiu3BOsvWLSDCziBFTs0QZCbSzd1Hqzg3
 pEVJpXvIIQTHaO/oc1xR8PJhLkscNAFX9zqMUh6WlZV8zpQayG3ztD1efVVnYxJRmAKr
 zV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700994839; x=1701599639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1L5w9k33K3CzjjSCrYG/5s6RbPMiKb7WGtJAM0ofzA=;
 b=EttTTw36gwdvhiPdqJBqZpahcL8jeBhAS2vVp7zUl5YZgBJktuGh/gQhm20JzDLKgC
 Fuo7SFVXPzLDS0X3TGlZGaI3bVS4v6e/2ed3iVd0zjv+Ojo5bezd+0jX2iKfo4g/LONg
 h4TpIwAmxNFv+toV6D3lDsiKLXhXoJB++rsg8S9Q0qtLs23cmGswgQoiFqtDyDX9ZYfp
 Y+7PpTy7QIrZUmJCD18PVXf/2K2fFhpEEhYSZ8eRXyaH9bQ+QRXyqbNqtP/CDIBP8Z3x
 eJ9cIUuKuVDcwADtuEGUbzEjQTxIG12B6D0z68Y28LIB71czrLFVME+NfkuHiUxn6oBz
 ZC3w==
X-Gm-Message-State: AOJu0YzvwZMAFE9bz5YcTZIcOUDEuY4GWQRo45fGIIJeb2YulRuKi6Ea
 +Y8UwWMBZysbhEGIgy2wA3KBKSIWNks4Duh0rPw=
X-Google-Smtp-Source: AGHT+IGpzChN3DKHqNSsRVmopPEk9vT6BYU6eypJRCN7CisqllGFadXAUI76RjDHT7Aga8ppWoW5mw==
X-Received: by 2002:a17:906:eb0f:b0:a02:95ea:1289 with SMTP id
 mb15-20020a170906eb0f00b00a0295ea1289mr6463901ejb.20.1700994838486; 
 Sun, 26 Nov 2023 02:33:58 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com.
 [209.85.208.41]) by smtp.gmail.com with ESMTPSA id
 gw9-20020a170906f14900b009fc8f309183sm4420949ejb.51.2023.11.26.02.33.57
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 02:33:58 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-5484ef5e3d2so4253078a12.3
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 02:33:57 -0800 (PST)
X-Received: by 2002:a50:ab52:0:b0:53e:8972:1d4f with SMTP id
 t18-20020a50ab52000000b0053e89721d4fmr6443785edc.5.1700994837628; Sun, 26 Nov
 2023 02:33:57 -0800 (PST)
MIME-Version: 1.0
References: <CABEcMwVkWqwKVGCUTJw366rM7qk1NGGpJ_Aw8cX4wRCSvJMwPw@mail.gmail.com>
 <CAC_iWjKNf6RxPoKzPjJiLV+UnQES344wb=sqS1wCnQzC+J-Hkw@mail.gmail.com>
 <CAHc5_t0UNC5PPxJ3ji4ToOqzHpcSovYRUJbb2ZJ64qTTOZ+1Bw@mail.gmail.com>
 <CALeDE9ONK7CMP6DXKRrjzqxm1r-afB7bgKSDhekrhOMUnhhktQ@mail.gmail.com>
In-Reply-To: <CALeDE9ONK7CMP6DXKRrjzqxm1r-afB7bgKSDhekrhOMUnhhktQ@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Sun, 26 Nov 2023 10:33:46 +0000
X-Gmail-Original-Message-ID: <CAHc5_t3QQUT=aid9NYRysPvtVG31Ohtvo=RxZkDPo9W9saQUdA@mail.gmail.com>
Message-ID: <CAHc5_t3QQUT=aid9NYRysPvtVG31Ohtvo=RxZkDPo9W9saQUdA@mail.gmail.com>
Subject: Re: efi: Set Variable Runtime implementation
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 takahiro.akashi@linaro.org, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Peter,

On Sat, Nov 25, 2023 at 6:19=E2=80=AFAM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> Hi Shantur,
>
> On Fri, Nov 24, 2023 at 11:55=E2=80=AFPM Shantur Rathore <i@shantur.com> =
wrote:
> >
> > Hi Ilias,
> >
> > On Fri, Nov 24, 2023 at 10:50=E2=80=AFPM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Shantur
> > >
> > > On Fri, 24 Nov 2023 at 18:51, Shantur Rathore <i@shantur.com> wrote:
> > > >
> > > > Hi Heinrich,
> > > >
> > > > I am trying to work out how to enable the SetVariableRT service in
> > > > U-Boot and came across your patch [1] which initially had the
> > > > SetVariable RT service enabled in EFI but in the final patch this w=
as
> > > > removed.
> > > > I am hoping to implement it on top of the SPI Flash EFI store [2] t=
o
> > > > be able to set Boot order and boot items from Linux the UEFI way.
> > > >
> > > > Can I pick your brain on why it was dropped in the patch?
> > > > Is there any limitation in SetVariableRT service ?
> > >
> > > I recently had a talk about it in Plumbers [0]. Generally speaking, R=
T
> > > + hardware owned by the kernel is a very weird combination since you
> > > can't guarantee exclusive access to the flash or the bus and you have
> > > to preserve a *lot* of code alive in u-boot.
> > >
> > > I'll respond to your v1 patchset and we can discuss details there as =
well.
> > >
> > > [0] https://lpc.events/event/17/contributions/1653/
> >
> > Thanks for the background and helping me understand the problem.
> > Makes me wonder how things work in the PC world.
> > U-boot being only ~1MB, can we not leave it all in memory and maybe
> > just disable SPI access to Linux.
>
> That's basically it, on x86 there's specific HW that's owned by
> firmware, I don't know the exact low level details of how that works.
>
> I think x86 devices generally use eSPI for this HW [1] but I don't
> know the low level details. The Arm SBSA (Server HW spec) and SBBR
> (Server Base Boot Requirements) specs that are key to ServerReady may
> go into some details too if you're curious.

Thanks,
I think the firmware is still accessible to PCs as one could update the fir=
mware
in Windows so Windows has access to that device.

I had some try myself and found that setting a variable to memory backed st=
orage
is doable with SetVariable call but we want to store it in any
non-volatile storage
things really don't look good.

To be able to write SetVariable to any device, the whole u-boot driver
model would need
to be kept in memory, might as well just keep the whole u-boot in
memory at this point, it's anyway small.
I don't have much knowledge on how to or pros and cons of doing this.

>
> BTW I plan to test your other patches on the Pinebook Pro.
>
> [1] https://www.totalphase.com/blog/2021/09/what-is-the-espi-protocol-and=
-how-does-it-improve-upon-lpc/

Thanks, that would be helpful.
I am particularly keen on the usb patch here
https://patchwork.ozlabs.org/project/uboot/patch/20231110141311.512334-1-i@=
shantur.com/

Kind regards,
Shantur
