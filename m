Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12631C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 10:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CEC7870AC;
	Mon, 27 Nov 2023 11:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="iL6J6Fa+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13BEA86F6D; Mon, 27 Nov 2023 11:12:54 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4F5F87214
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a00ac0101d9so536846166b.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 02:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701079970; x=1701684770;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBd0ZxZ5rbOjzMXqcncgJBxr2q4O4/ReHJFF4WBCTjA=;
 b=iL6J6Fa+nr3TeB2OrGY9MsO9I/USUzMK1T5pd+fvEv2rVtkyqVgcxkjd2tg9BndGi7
 r3D7MVBMN7gPYRQ5Lqqx33RNeYHeFsWqCSgtC8l0gLC3OcOy55NMNDdiSteQcaZ6P5IF
 RhQ53m2jbRVkoMTPTqYcmWlaZPSGEez5hfhxaCwB4XJC3psdi/dHcHveUDUzUab+qlfr
 cJq57NboBQKJNu58g/05BEL/vZiYrnplMJoUIIPr1MhV+/EDZp5M4/kWpsvJrOAcz9sT
 GCP2Vh/GFQn6s2WMbPpgHGnhRZKJZNX1WVols4c+PAakY7YhvCz1sV4tUpJj25ib0fkM
 ZggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701079970; x=1701684770;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBd0ZxZ5rbOjzMXqcncgJBxr2q4O4/ReHJFF4WBCTjA=;
 b=l7xS+JAUbCgEdpVGMmm3So6CyMbB2EUmdhyKr9XUcjPT2pkZCHfGeyXysC6NN3aqxF
 wQ7iH1ROBkAhHYsjQb9z/3D3PfxZs7jIK3tnAApOMNVexp5l5ovjqWxo07BdaTdCqVrX
 /S0zIefyVhwYC/6wyGVx54pZ0HGjcUPi2YXIig7QBgWTXHrqO/SJueGoMzRtTRVu04ZW
 vyO/SDX00VnfCwWB1lof30a6IVbAixErICvXsNftJIpP/Gt9kQKrjQBX7v2oQogq0ZIF
 fQOIdUgOunQpuEIMVMoB1PnoXlRwYmusNDhkmEnnp5V9vCz0CDOUIdf6ur6gAUCm7g+W
 JxpQ==
X-Gm-Message-State: AOJu0Yx7ze6qyM73EDtW/rKWJH4nliRW5koxXF/9i/sw9U8p+R/765qV
 jIHR68fGSNEJCcV5D8FAzptQiWfyun0HoaBzSrpjtA==
X-Google-Smtp-Source: AGHT+IHda15IIGI1zVpne6umdr4wPt7VdKz3IUXpNA3DBMhZgbfDwR2LSFbRaMw7xfmbymzqt66QIw==
X-Received: by 2002:a17:907:29c8:b0:a03:d3ff:1e14 with SMTP id
 ev8-20020a17090729c800b00a03d3ff1e14mr6897034ejc.28.1701079970344; 
 Mon, 27 Nov 2023 02:12:50 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 bj25-20020a170906b05900b009fea232316bsm5515620ejb.193.2023.11.27.02.12.49
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 02:12:49 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-54b0073d50fso3470142a12.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 02:12:49 -0800 (PST)
X-Received: by 2002:a50:ccc9:0:b0:53f:9ced:e5b4 with SMTP id
 b9-20020a50ccc9000000b0053f9cede5b4mr8653606edj.13.1701079969533; Mon, 27 Nov
 2023 02:12:49 -0800 (PST)
MIME-Version: 1.0
References: <CABEcMwVkWqwKVGCUTJw366rM7qk1NGGpJ_Aw8cX4wRCSvJMwPw@mail.gmail.com>
 <CAC_iWjKNf6RxPoKzPjJiLV+UnQES344wb=sqS1wCnQzC+J-Hkw@mail.gmail.com>
 <CAHc5_t0UNC5PPxJ3ji4ToOqzHpcSovYRUJbb2ZJ64qTTOZ+1Bw@mail.gmail.com>
 <CALeDE9ONK7CMP6DXKRrjzqxm1r-afB7bgKSDhekrhOMUnhhktQ@mail.gmail.com>
 <CAHc5_t3QQUT=aid9NYRysPvtVG31Ohtvo=RxZkDPo9W9saQUdA@mail.gmail.com>
 <CAC_iWj+HV4dBqa4iG4NfJ9T=jwdqxLMi5Lunis7ZFezQ23VPag@mail.gmail.com>
In-Reply-To: <CAC_iWj+HV4dBqa4iG4NfJ9T=jwdqxLMi5Lunis7ZFezQ23VPag@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Mon, 27 Nov 2023 10:12:38 +0000
X-Gmail-Original-Message-ID: <CAHc5_t3oa=Hho+WRSWN4UoE5zSLV-G_Pn6fbZKqzT0eP3ZAZcg@mail.gmail.com>
Message-ID: <CAHc5_t3oa=Hho+WRSWN4UoE5zSLV-G_Pn6fbZKqzT0eP3ZAZcg@mail.gmail.com>
Subject: Re: efi: Set Variable Runtime implementation
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, takahiro.akashi@linaro.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Ilias,

On Mon, Nov 27, 2023 at 7:16=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Shantur
>
> On Sun, 26 Nov 2023 at 12:33, Shantur Rathore <i@shantur.com> wrote:
> >
> > Hi Peter,
> >
> > On Sat, Nov 25, 2023 at 6:19=E2=80=AFAM Peter Robinson <pbrobinson@gmai=
l.com> wrote:
> > >
> > > Hi Shantur,
> > >
> > > On Fri, Nov 24, 2023 at 11:55=E2=80=AFPM Shantur Rathore <i@shantur.c=
om> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Fri, Nov 24, 2023 at 10:50=E2=80=AFPM Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Shantur
> > > > >
> > > > > On Fri, 24 Nov 2023 at 18:51, Shantur Rathore <i@shantur.com> wro=
te:
> > > > > >
> > > > > > Hi Heinrich,
> > > > > >
> > > > > > I am trying to work out how to enable the SetVariableRT service=
 in
> > > > > > U-Boot and came across your patch [1] which initially had the
> > > > > > SetVariable RT service enabled in EFI but in the final patch th=
is was
> > > > > > removed.
> > > > > > I am hoping to implement it on top of the SPI Flash EFI store [=
2] to
> > > > > > be able to set Boot order and boot items from Linux the UEFI wa=
y.
> > > > > >
> > > > > > Can I pick your brain on why it was dropped in the patch?
> > > > > > Is there any limitation in SetVariableRT service ?
> > > > >
> > > > > I recently had a talk about it in Plumbers [0]. Generally speakin=
g, RT
> > > > > + hardware owned by the kernel is a very weird combination since =
you
> > > > > can't guarantee exclusive access to the flash or the bus and you =
have
> > > > > to preserve a *lot* of code alive in u-boot.
> > > > >
> > > > > I'll respond to your v1 patchset and we can discuss details there=
 as well.
> > > > >
> > > > > [0] https://lpc.events/event/17/contributions/1653/
> > > >
> > > > Thanks for the background and helping me understand the problem.
> > > > Makes me wonder how things work in the PC world.
> > > > U-boot being only ~1MB, can we not leave it all in memory and maybe
> > > > just disable SPI access to Linux.
>
> That would work, but you cant guarantee Linux wont enable the SPI flash.
>
> > >
> > > That's basically it, on x86 there's specific HW that's owned by
> > > firmware, I don't know the exact low level details of how that works.
> > >
> > > I think x86 devices generally use eSPI for this HW [1] but I don't
> > > know the low level details. The Arm SBSA (Server HW spec) and SBBR
> > > (Server Base Boot Requirements) specs that are key to ServerReady may
> > > go into some details too if you're curious.
>
> On X86 the SPI flash is handled entirely by the firmware and SMM. You
> can find more details here [0]

Thanks for more info.

>
> >
> > Thanks,
> > I think the firmware is still accessible to PCs as one could update the=
 firmware
> > in Windows so Windows has access to that device.
> >
> > I had some try myself and found that setting a variable to memory backe=
d storage
> > is doable with SetVariable call but we want to store it in any
> > non-volatile storage
> > things really don't look good.
> >
> > To be able to write SetVariable to any device, the whole u-boot driver
> > model would need
> > to be kept in memory, might as well just keep the whole u-boot in
> > memory at this point, it's anyway small.
> > I don't have much knowledge on how to or pros and cons of doing this.
>
> The major problem here is who owns the hardware. With the SPI flash
> implementation as well as the RPMB implementation Linux owns that
> flash.
> For the RPMB we've introduced a mechanism so the kernel replaces the
> runtime calls with internal functions [1].  I think we should come up
> with a similar architecture for SPI. In any case we should keep in
> mind that setting authenticated EFI variables should be forbidden on
> the file/SPI backends since they are not really secure.
>

Thanks, I understand now that we can't use SPI flash for saving secure
variables and stop Linux from accessing it.
My requirement is to be able to save non-Secure boot related variables
( BootOrder, BootNext and BootOptions ).
For this purpose as we don't need secure channel and to be compatible
with current Linux versions I started
implementing SetVariable in runtime in [1]
I was able to get it working until it's ready to write stuff into SPI Flash=
.
To be able to use SPI Flash, runtime call needs to access the drivers
and this needs the whole driver-model to be in
efi runtime memory makes me think would it make sense to keep the
whole u-boot in efi runtime memory or just
driver model and all SPI drivers for now and keep adding other drivers
when needed like RPMB.

I need some pointers to what would be the best approach accessing
hardware from runtime.

[1] - https://github.com/shantur/u-boot/tree/spi-flash-runtime-setvariable

Kind regards,
Shantur
