Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0514C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 17:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F194586ED0;
	Mon, 27 Nov 2023 18:27:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="M0DzG43C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E6E87150; Mon, 27 Nov 2023 18:27:33 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 014CB86ED0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 18:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-54af0eca12dso4553672a12.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 09:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701106048; x=1701710848;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3jjY9kKL6+AQrDuf/3YCDjCHEf4X59aJnnF63t1o3Q=;
 b=M0DzG43CGJqcSP9x8h2TOVupN/pxkx2cTENfXu0u7lYZ4dcMA7ogDwfVJTz8dfAF2F
 y8g9/sFgI/RRgiZ01qmJGRXZY2Q/n1jIkRxKyVG8D55vuoqYjEnpE+yV0aMWP/8Nj1/e
 ptel8xCYIY+92W4heI5Kcy+ThZPw0bJLY5NffP1L8bBXQLr9llHOsXH9NfXhmVuCdkvE
 Y/2MHJa226L9UFqGwANV0IQGUqfF+0ly6sB3a5gjbB7/wXPJ/Jhh4zZFbs1AjHiM4kdq
 R1QcWsKKY2iJBpqcOL68GzHfuA8KggzcLkfxp0HwZD16Eq8zTzYgGiI2nsyg08LQ/7Ko
 pOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701106048; x=1701710848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z3jjY9kKL6+AQrDuf/3YCDjCHEf4X59aJnnF63t1o3Q=;
 b=Qug6ixwdrGkai80Vw4vsWWGXUHLGGEjrnECW11rrvvcP3zaESGajPGOQfmeYLUgn8L
 VEXEgSMLKNFvEuvV+CNnzpIsk0UyQCUp6YwhbiY1sSHa7D7sOnaVeAW2H4PA5wVyUcxo
 pmbYFzHSwB0/c/9qocEue7x3D8VSlHA1XvX6J/xf31vPpfBZyQglkJaj7czNvn+rPmKw
 8StlbeIv3jtWgPHlirXHO1+N3J0lzxGTlAfje9HyQq6OEmWSpiUyu0puoKHujus2gaAO
 kLG4Am86HLCfsyb2vYIzpLG1L/efegGP/fbchXM0nj7egY7ZJxGZu5jCElXGnXXzVL8E
 ChYQ==
X-Gm-Message-State: AOJu0Yz3gzqkCNvfjh5akD1oCoXoqTQhlZ0oWOnw24MWW3UHQ2KbuB/I
 hzajgdgFPeCWCScK0k8YMGK4KTS8oaBvtjQgHOMnfA==
X-Google-Smtp-Source: AGHT+IGR6JmKkST9CurHvcjiK7FmZqEQOoBm5rCKngkPK6pVyfGKeMmBOPtjSfUHd5gbf579a3uuOA==
X-Received: by 2002:a17:906:4f:b0:a0d:3a13:b4a6 with SMTP id
 15-20020a170906004f00b00a0d3a13b4a6mr3655084ejg.72.1701106047684; 
 Mon, 27 Nov 2023 09:27:27 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
 [209.85.208.48]) by smtp.gmail.com with ESMTPSA id
 t11-20020a170906a10b00b009ff8be60791sm5892774ejy.210.2023.11.27.09.27.27
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 09:27:27 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-54b7ef7f4d5so1242029a12.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 09:27:27 -0800 (PST)
X-Received: by 2002:a50:d593:0:b0:53e:1825:be81 with SMTP id
 v19-20020a50d593000000b0053e1825be81mr9660327edi.21.1701106046771; Mon, 27
 Nov 2023 09:27:26 -0800 (PST)
MIME-Version: 1.0
References: <CABEcMwVkWqwKVGCUTJw366rM7qk1NGGpJ_Aw8cX4wRCSvJMwPw@mail.gmail.com>
 <CAC_iWjKNf6RxPoKzPjJiLV+UnQES344wb=sqS1wCnQzC+J-Hkw@mail.gmail.com>
 <CAHc5_t0UNC5PPxJ3ji4ToOqzHpcSovYRUJbb2ZJ64qTTOZ+1Bw@mail.gmail.com>
 <CALeDE9ONK7CMP6DXKRrjzqxm1r-afB7bgKSDhekrhOMUnhhktQ@mail.gmail.com>
 <CAHc5_t3QQUT=aid9NYRysPvtVG31Ohtvo=RxZkDPo9W9saQUdA@mail.gmail.com>
 <CAC_iWj+HV4dBqa4iG4NfJ9T=jwdqxLMi5Lunis7ZFezQ23VPag@mail.gmail.com>
 <CAHc5_t3oa=Hho+WRSWN4UoE5zSLV-G_Pn6fbZKqzT0eP3ZAZcg@mail.gmail.com>
In-Reply-To: <CAHc5_t3oa=Hho+WRSWN4UoE5zSLV-G_Pn6fbZKqzT0eP3ZAZcg@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Mon, 27 Nov 2023 17:27:15 +0000
X-Gmail-Original-Message-ID: <CAHc5_t2_V8huBnpBTQmn-B3assO5hDD0yZAZx=WRAf0jQB7kqw@mail.gmail.com>
Message-ID: <CAHc5_t2_V8huBnpBTQmn-B3assO5hDD0yZAZx=WRAf0jQB7kqw@mail.gmail.com>
Subject: Re: efi: Set Variable Runtime implementation
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
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

+ Simon as he seems to have done a lot of work in the driver model.

On Mon, Nov 27, 2023 at 10:12=E2=80=AFAM Shantur Rathore <i@shantur.com> wr=
ote:
>
> Hi Ilias,
>
> On Mon, Nov 27, 2023 at 7:16=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Shantur
> >
> > On Sun, 26 Nov 2023 at 12:33, Shantur Rathore <i@shantur.com> wrote:
> > >
> > > Hi Peter,
> > >
> > > On Sat, Nov 25, 2023 at 6:19=E2=80=AFAM Peter Robinson <pbrobinson@gm=
ail.com> wrote:
> > > >
> > > > Hi Shantur,
> > > >
> > > > On Fri, Nov 24, 2023 at 11:55=E2=80=AFPM Shantur Rathore <i@shantur=
.com> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Fri, Nov 24, 2023 at 10:50=E2=80=AFPM Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Shantur
> > > > > >
> > > > > > On Fri, 24 Nov 2023 at 18:51, Shantur Rathore <i@shantur.com> w=
rote:
> > > > > > >
> > > > > > > Hi Heinrich,
> > > > > > >
> > > > > > > I am trying to work out how to enable the SetVariableRT servi=
ce in
> > > > > > > U-Boot and came across your patch [1] which initially had the
> > > > > > > SetVariable RT service enabled in EFI but in the final patch =
this was
> > > > > > > removed.
> > > > > > > I am hoping to implement it on top of the SPI Flash EFI store=
 [2] to
> > > > > > > be able to set Boot order and boot items from Linux the UEFI =
way.
> > > > > > >
> > > > > > > Can I pick your brain on why it was dropped in the patch?
> > > > > > > Is there any limitation in SetVariableRT service ?
> > > > > >
> > > > > > I recently had a talk about it in Plumbers [0]. Generally speak=
ing, RT
> > > > > > + hardware owned by the kernel is a very weird combination sinc=
e you
> > > > > > can't guarantee exclusive access to the flash or the bus and yo=
u have
> > > > > > to preserve a *lot* of code alive in u-boot.
> > > > > >
> > > > > > I'll respond to your v1 patchset and we can discuss details the=
re as well.
> > > > > >
> > > > > > [0] https://lpc.events/event/17/contributions/1653/
> > > > >
> > > > > Thanks for the background and helping me understand the problem.
> > > > > Makes me wonder how things work in the PC world.
> > > > > U-boot being only ~1MB, can we not leave it all in memory and may=
be
> > > > > just disable SPI access to Linux.
> >
> > That would work, but you cant guarantee Linux wont enable the SPI flash=
.
> >
> > > >
> > > > That's basically it, on x86 there's specific HW that's owned by
> > > > firmware, I don't know the exact low level details of how that work=
s.
> > > >
> > > > I think x86 devices generally use eSPI for this HW [1] but I don't
> > > > know the low level details. The Arm SBSA (Server HW spec) and SBBR
> > > > (Server Base Boot Requirements) specs that are key to ServerReady m=
ay
> > > > go into some details too if you're curious.
> >
> > On X86 the SPI flash is handled entirely by the firmware and SMM. You
> > can find more details here [0]
>
> Thanks for more info.
>
> >
> > >
> > > Thanks,
> > > I think the firmware is still accessible to PCs as one could update t=
he firmware
> > > in Windows so Windows has access to that device.
> > >
> > > I had some try myself and found that setting a variable to memory bac=
ked storage
> > > is doable with SetVariable call but we want to store it in any
> > > non-volatile storage
> > > things really don't look good.
> > >
> > > To be able to write SetVariable to any device, the whole u-boot drive=
r
> > > model would need
> > > to be kept in memory, might as well just keep the whole u-boot in
> > > memory at this point, it's anyway small.
> > > I don't have much knowledge on how to or pros and cons of doing this.
> >
> > The major problem here is who owns the hardware. With the SPI flash
> > implementation as well as the RPMB implementation Linux owns that
> > flash.
> > For the RPMB we've introduced a mechanism so the kernel replaces the
> > runtime calls with internal functions [1].  I think we should come up
> > with a similar architecture for SPI. In any case we should keep in
> > mind that setting authenticated EFI variables should be forbidden on
> > the file/SPI backends since they are not really secure.
> >
>
> Thanks, I understand now that we can't use SPI flash for saving secure
> variables and stop Linux from accessing it.
> My requirement is to be able to save non-Secure boot related variables
> ( BootOrder, BootNext and BootOptions ).
> For this purpose as we don't need secure channel and to be compatible
> with current Linux versions I started
> implementing SetVariable in runtime in [1]
> I was able to get it working until it's ready to write stuff into SPI Fla=
sh.
> To be able to use SPI Flash, runtime call needs to access the drivers
> and this needs the whole driver-model to be in
> efi runtime memory makes me think would it make sense to keep the
> whole u-boot in efi runtime memory or just
> driver model and all SPI drivers for now and keep adding other drivers
> when needed like RPMB.
>
> I need some pointers to what would be the best approach accessing
> hardware from runtime.
>
> [1] - https://github.com/shantur/u-boot/tree/spi-flash-runtime-setvariabl=
e
>
> Kind regards,
> Shantur
