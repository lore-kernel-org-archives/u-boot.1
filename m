Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EC5C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 21:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8DB48777D;
	Sun,  3 Dec 2023 22:52:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="3W4Vp0ZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D77BD870B8; Sun,  3 Dec 2023 22:51:53 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBB9869B6
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 22:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50bdec453c8so2360397e87.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 13:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701640309; x=1702245109;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/hOUZLB4jxzHHYxUjtUs72OcZIN57wgG2tC69D+iiA4=;
 b=3W4Vp0ZE29t1HueOIsk2WC9efyw0O/FdPVI0SUiH2HVpKnFaOorvCriho+r+eAyxvh
 gw/RZH+evN5ZlRMURCJAvVg9TcBVKCOSM6IDB4Idb+tjt7SNaqKAfMoUUdXbyazJ4gpc
 tbiikkEtUvKxeg49dQ7Rdpa5bKquwgaG8Lie4ycoG5rZV0jAZ/gC+FvlW0lBXjEYhz6y
 N0d7ts6GG12XzznwFc0tzC1CfRPo1gmJEOQ5l1uRYBmr++BKHo1XPr45S3rCoOz4cAei
 C6m6WAjGlpA4HB74QlyYlRgZjB8sJe+IRlC26qMtgU8uOQlUqvDyOlUqBU0OTDPcuvp5
 8akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701640309; x=1702245109;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/hOUZLB4jxzHHYxUjtUs72OcZIN57wgG2tC69D+iiA4=;
 b=LzCUWQUQqs4L5sKlaSaCq5cNfZgfhYw+gouZCo5VgP0WEm9M2a2QPmTVuqB70LlwNc
 JkX7HPrBcRCUUYSZKFbEgMmcgtzeq9w0far+Eg+k3AWXvYVPpodjFwuRvnnCFdr83fLF
 wExHXDSEizctcPay1oO7uFGBEZMqyxLjpWuai91LM9HmwizhZJ9r9Nqyi8XmhvmOW6fh
 tdRXuQa8gltyI+r7u/RHhM5vrprT2i/sKa8X/oQGgnqqjnRahDpt6CC2tlUUoyv9gVT+
 Ef0NqJCVBhBJM6a2RGujdDctRRviRRUUZwfRXRyHikZLTVKgm0oztXSOx/Htto0lEGGJ
 NiDw==
X-Gm-Message-State: AOJu0YwI8fY1B3k83AT36qlgzD62eGscQp3Wh+YF17IfFxpDrC4/VbeP
 OyW9POXuKZA8f+rPylO2rJtId02+7lN1OM4wsog73TRk
X-Google-Smtp-Source: AGHT+IFJMb9BqrNbJNOFaR4n7D8EhZ/I8NiZkZO2E5O7uWkot6TM5U36a0ItCVhxzvCQz0ge1NPuGQ==
X-Received: by 2002:ac2:4c37:0:b0:50b:f486:a65e with SMTP id
 u23-20020ac24c37000000b0050bf486a65emr480493lfq.106.1701640309082; 
 Sun, 03 Dec 2023 13:51:49 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com.
 [209.85.167.46]) by smtp.gmail.com with ESMTPSA id
 n12-20020a05651203ec00b0050bbad31c64sm161714lfq.172.2023.12.03.13.51.48
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 13:51:48 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-50bdec453c8so2360380e87.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 13:51:48 -0800 (PST)
X-Received: by 2002:ac2:4f05:0:b0:50b:d764:6eb7 with SMTP id
 k5-20020ac24f05000000b0050bd7646eb7mr3577425lfr.103.1701640308223; Sun, 03
 Dec 2023 13:51:48 -0800 (PST)
MIME-Version: 1.0
References: <CABEcMwVkWqwKVGCUTJw366rM7qk1NGGpJ_Aw8cX4wRCSvJMwPw@mail.gmail.com>
 <CAC_iWjKNf6RxPoKzPjJiLV+UnQES344wb=sqS1wCnQzC+J-Hkw@mail.gmail.com>
 <CAHc5_t0UNC5PPxJ3ji4ToOqzHpcSovYRUJbb2ZJ64qTTOZ+1Bw@mail.gmail.com>
 <CALeDE9ONK7CMP6DXKRrjzqxm1r-afB7bgKSDhekrhOMUnhhktQ@mail.gmail.com>
 <CAHc5_t3QQUT=aid9NYRysPvtVG31Ohtvo=RxZkDPo9W9saQUdA@mail.gmail.com>
 <CAC_iWj+HV4dBqa4iG4NfJ9T=jwdqxLMi5Lunis7ZFezQ23VPag@mail.gmail.com>
 <CAHc5_t3oa=Hho+WRSWN4UoE5zSLV-G_Pn6fbZKqzT0eP3ZAZcg@mail.gmail.com>
 <CAHc5_t2_V8huBnpBTQmn-B3assO5hDD0yZAZx=WRAf0jQB7kqw@mail.gmail.com>
 <CAPnjgZ21qLnSFcCJ9rPQXEfQf-NjMBF3kYUDBBOc6WUQXQtDEA@mail.gmail.com>
 <CAHc5_t37JdQUHN+R9i15X1hOuXuMNt08TrzeawYy149R7qkRyw@mail.gmail.com>
 <CAPnjgZ1ecMpCqziKm1qBVddNsAB1E5C7-aYuh+hM-p2uOeub=A@mail.gmail.com>
In-Reply-To: <CAPnjgZ1ecMpCqziKm1qBVddNsAB1E5C7-aYuh+hM-p2uOeub=A@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Sun, 3 Dec 2023 21:51:37 +0000
X-Gmail-Original-Message-ID: <CAHc5_t3dRJXNNjpjsqNov7Pfu7HLDP7x6POobRN=8XBcSXZnyg@mail.gmail.com>
Message-ID: <CAHc5_t3dRJXNNjpjsqNov7Pfu7HLDP7x6POobRN=8XBcSXZnyg@mail.gmail.com>
Subject: Re: efi: Set Variable Runtime implementation
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
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

Hi Simon,

On Sun, Dec 3, 2023 at 5:44=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Shantur,
>
> On Sat, 2 Dec 2023 at 16:03, Shantur Rathore <i@shantur.com> wrote:
> >
> > Hi Simon,
> >
> > On Fri, Dec 1, 2023 at 6:44=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> > >
> > > Hi Shantur,
> > >
> > > On Mon, 27 Nov 2023 at 10:27, Shantur Rathore <i@shantur.com> wrote:
> > > >
> > > > + Simon as he seems to have done a lot of work in the driver model.
> > > >
> > > > On Mon, Nov 27, 2023 at 10:12=E2=80=AFAM Shantur Rathore <i@shantur=
.com> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Mon, Nov 27, 2023 at 7:16=E2=80=AFAM Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Shantur
> > > > > >
> > > > > > On Sun, 26 Nov 2023 at 12:33, Shantur Rathore <i@shantur.com> w=
rote:
> > > > > > >
> > > > > > > Hi Peter,
> > > > > > >
> > > > > > > On Sat, Nov 25, 2023 at 6:19=E2=80=AFAM Peter Robinson <pbrob=
inson@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Shantur,
> > > > > > > >
> > > > > > > > On Fri, Nov 24, 2023 at 11:55=E2=80=AFPM Shantur Rathore <i=
@shantur.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Ilias,
> > > > > > > > >
> > > > > > > > > On Fri, Nov 24, 2023 at 10:50=E2=80=AFPM Ilias Apalodimas
> > > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Shantur
> > > > > > > > > >
> > > > > > > > > > On Fri, 24 Nov 2023 at 18:51, Shantur Rathore <i@shantu=
r.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > >
> > > > > > > > > > > I am trying to work out how to enable the SetVariable=
RT service in
> > > > > > > > > > > U-Boot and came across your patch [1] which initially=
 had the
> > > > > > > > > > > SetVariable RT service enabled in EFI but in the fina=
l patch this was
> > > > > > > > > > > removed.
> > > > > > > > > > > I am hoping to implement it on top of the SPI Flash E=
FI store [2] to
> > > > > > > > > > > be able to set Boot order and boot items from Linux t=
he UEFI way.
> > > > > > > > > > >
> > > > > > > > > > > Can I pick your brain on why it was dropped in the pa=
tch?
> > > > > > > > > > > Is there any limitation in SetVariableRT service ?
> > > > > > > > > >
> > > > > > > > > > I recently had a talk about it in Plumbers [0]. General=
ly speaking, RT
> > > > > > > > > > + hardware owned by the kernel is a very weird combinat=
ion since you
> > > > > > > > > > can't guarantee exclusive access to the flash or the bu=
s and you have
> > > > > > > > > > to preserve a *lot* of code alive in u-boot.
> > > > > > > > > >
> > > > > > > > > > I'll respond to your v1 patchset and we can discuss det=
ails there as well.
> > > > > > > > > >
> > > > > > > > > > [0] https://lpc.events/event/17/contributions/1653/
> > > > > > > > >
> > > > > > > > > Thanks for the background and helping me understand the p=
roblem.
> > > > > > > > > Makes me wonder how things work in the PC world.
> > > > > > > > > U-boot being only ~1MB, can we not leave it all in memory=
 and maybe
> > > > > > > > > just disable SPI access to Linux.
> > > > > >
> > > > > > That would work, but you cant guarantee Linux wont enable the S=
PI flash.
> > > > > >
> > > > > > > >
> > > > > > > > That's basically it, on x86 there's specific HW that's owne=
d by
> > > > > > > > firmware, I don't know the exact low level details of how t=
hat works.
> > > > > > > >
> > > > > > > > I think x86 devices generally use eSPI for this HW [1] but =
I don't
> > > > > > > > know the low level details. The Arm SBSA (Server HW spec) a=
nd SBBR
> > > > > > > > (Server Base Boot Requirements) specs that are key to Serve=
rReady may
> > > > > > > > go into some details too if you're curious.
> > > > > >
> > > > > > On X86 the SPI flash is handled entirely by the firmware and SM=
M. You
> > > > > > can find more details here [0]
> > > > >
> > > > > Thanks for more info.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > > I think the firmware is still accessible to PCs as one could =
update the firmware
> > > > > > > in Windows so Windows has access to that device.
> > > > > > >
> > > > > > > I had some try myself and found that setting a variable to me=
mory backed storage
> > > > > > > is doable with SetVariable call but we want to store it in an=
y
> > > > > > > non-volatile storage
> > > > > > > things really don't look good.
> > > > > > >
> > > > > > > To be able to write SetVariable to any device, the whole u-bo=
ot driver
> > > > > > > model would need
> > > > > > > to be kept in memory, might as well just keep the whole u-boo=
t in
> > > > > > > memory at this point, it's anyway small.
> > > > > > > I don't have much knowledge on how to or pros and cons of doi=
ng this.
> > > > > >
> > > > > > The major problem here is who owns the hardware. With the SPI f=
lash
> > > > > > implementation as well as the RPMB implementation Linux owns th=
at
> > > > > > flash.
> > > > > > For the RPMB we've introduced a mechanism so the kernel replace=
s the
> > > > > > runtime calls with internal functions [1].  I think we should c=
ome up
> > > > > > with a similar architecture for SPI. In any case we should keep=
 in
> > > > > > mind that setting authenticated EFI variables should be forbidd=
en on
> > > > > > the file/SPI backends since they are not really secure.
> > > > > >
> > > > >
> > > > > Thanks, I understand now that we can't use SPI flash for saving s=
ecure
> > > > > variables and stop Linux from accessing it.
> > > > > My requirement is to be able to save non-Secure boot related vari=
ables
> > > > > ( BootOrder, BootNext and BootOptions ).
> > > > > For this purpose as we don't need secure channel and to be compat=
ible
> > > > > with current Linux versions I started
> > > > > implementing SetVariable in runtime in [1]
> > > > > I was able to get it working until it's ready to write stuff into=
 SPI Flash.
> > >
> > > Yes, this makes sense to me and we don't need secure vars for these
> > > features. They are really just hints from the OS or user.
> > >
> > > > > To be able to use SPI Flash, runtime call needs to access the dri=
vers
> > > > > and this needs the whole driver-model to be in
> > > > > efi runtime memory makes me think would it make sense to keep the
> > > > > whole u-boot in efi runtime memory or just
> > > > > driver model and all SPI drivers for now and keep adding other dr=
ivers
> > > > > when needed like RPMB.
> > >
> > > I don't fully agree with this. The OS is well able to access SPI flas=
h
> > > or any other device. There is no need to ask the firmware to do it,
> > > unless there is some other reason. I can understand calling into a
> > > secure OS, or using a TPM, but for SPI flash this doesn't make much
> > > sense to me.
> > >
> >
> > Sure, the OS can write to SPI Flash but the OS won't know what / where =
to write
> > that U-Boot will be able to read and use as an EFI variable.
> > AFAIK, all UEFI firmwares have some non volatile storage where firmware=
 stores
> > variables. As U-boot doesn't have its own non-volatile storage we want
> > to allow u-boot to
> > write EFI variables in SPI.
> > This is needed to be able to manage EFI boot entries with efibootmgr in=
 Linux.
>
> We can pass the offset of the vars to the OS using the devicetree,
> e.g. using the fixed-partition binding, so then fwupd (or whatever)
> can do the update.
>

Sure, we could do this but then this would be a non-standard way of
managing the
EFI variables.

> >
> > Why does he need it, you might think.
> > My aim is to automate OS deployment on ARM boards for which I use
> > Canonical MAAS.
> > As a netinstall process the boot partition is configured as part of ins=
tall.
> > As EFI/boot/bootxxxx.efi is optional [0], some distros like debian and
> > debian based Armbian
> > don't install EFI/boot/bootxxxx.efi by default, it tries to set a boot
> > entry with efibootmgr
> > and can't so I had to disable it.
> > Now that update nvram is disabled in grub-install, it doesn't set up a
> > boot variable but
> > also doesn't install EFI/boot/bootxxxx.efi but EFI/debian/grubxxxx.efi.
> >
> > I am able to work around by manually forcing grub-install with --remova=
ble param
> > to force it to install EFI/boot/bootxxxx.efi, so it kinda works.
> >
> > This made me think of improvements we can make in u-boot to allow it
> > function more
> > like real UEFI firmware where it can.
>
> OK, I see.
>
> >
> > > > >
> > > > > I need some pointers to what would be the best approach accessing
> > > > > hardware from runtime.
> > >
> > > We would need to publish a runtime interface with access to the drive=
r
> > > API. I did ask for this when the EFI runtime support was added, but i=
t
> > > wasn't done.
> > >
> > > It would be possible to create a new 'runtime' phase of U-Boot (RPL?)=
,
> > > separate from the others. That will be much easier once we get the XP=
L
> > > stuff sorted out., since adding new [hase would be fairly trivial  CP=
L
> > > died as another contributor had a series which went in first...then I
> > > never got back to it.
> > >
> > > So for now having the entire U-Boot in runtime space seems reasonable=
 to me.
> > >
> > > I'll also mention that it would be nice to have s new-style API
> > > (replacing the old API U-Boot currently has) which uses more of a
> > > module approach. E.g. we could declare that uclass_first_device() is
> > > exported and can be called from outside U-Boot.
> >
> > I think this is way more deep than my current understanding of the u-bo=
ot and
> > boot process. I might be able to implement this if and when RPMB access=
 is
> > implemented for OP-TEE based access.
>
> Yes...it is a tricky area, but perhaps we can copy what Linux does
> with the EXPORT_SYMBOL() macro. Anyway, that is for the future
>
Maybe, I will park this for now and wait for the OP-TEE RPMB solution.

Kind regards,
Shantur
