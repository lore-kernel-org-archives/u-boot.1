Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0B4C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 18:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44DFC87623;
	Fri,  1 Dec 2023 19:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dwhf7KKP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 751088764D; Fri,  1 Dec 2023 19:44:19 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E438749E
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 19:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a18ebac19efso365751566b.0
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 10:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701456256; x=1702061056; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oee+tnQbFNT4jG9RGdlslHy1GhTkA0g021sFeRt2zqw=;
 b=Dwhf7KKPqAqDkrDyAwdMep9G8lvhJxuJQTwiyWqoSYNmhe7PsqxwxXAI0PUvtRicGk
 sqSWbKiRLIxKx9SAB93iBtzOLh+nIoKgt8UKJ5w8PMb92el91xK4MlC2QCTnfux9Sgna
 x8tK0Px6SqMx34pwF2OOHSMKyIEeijvh84djY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701456256; x=1702061056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oee+tnQbFNT4jG9RGdlslHy1GhTkA0g021sFeRt2zqw=;
 b=LuEpAKAzOMe6ZdOCQegbRxXGJAZSAhMTD95wWZJJem3iWZEGh/+xHBl8I2U/5wYisp
 eYRsYkFgPMIYNBjEIfvxkMp9vUyhq50R+snabrq7D0qFyr+qw5sMSnQ5Lr6kWL+vSlKW
 yPCkaD/DeOjg2Pk+7X2OM6pyfkgFyGlLOPT7IgUp/MmblzCNBrzqP0wCeI1AZsuS58Lk
 okfd/L2MBAJWUXwz4m/MCRhLaumWpEMJ6e4b2fUk9p2pSaPR4qLPGpKCBY/qMsWIfwha
 QOMWEoVqApIoHRhujqeVySV8mCpIw/g3tNlhrDYXKsg+sHpZTFNLsvVO9JYtkD0i3P6r
 hIPw==
X-Gm-Message-State: AOJu0YxAAl6cLGv7tRfPqrwvxOdnX9HRGsyd6Kl1fsc5Ob7zOg6eLvho
 KVGCxquhdWBDMAkoIGZhcEULMr1w92ht5xbRMjjWSA==
X-Google-Smtp-Source: AGHT+IH8KeUeJwLQljtW0PiLGS6+jI8gzwuQNSbhc0Un/wjCBJWYd0CUU4K2buB4nbS/rNrC8v6aDeHNIqRR1Qy5OBE=
X-Received: by 2002:a17:906:51d1:b0:9fd:fdae:a9d0 with SMTP id
 v17-20020a17090651d100b009fdfdaea9d0mr2257967ejk.5.1701456256138; Fri, 01 Dec
 2023 10:44:16 -0800 (PST)
MIME-Version: 1.0
References: <CABEcMwVkWqwKVGCUTJw366rM7qk1NGGpJ_Aw8cX4wRCSvJMwPw@mail.gmail.com>
 <CAC_iWjKNf6RxPoKzPjJiLV+UnQES344wb=sqS1wCnQzC+J-Hkw@mail.gmail.com>
 <CAHc5_t0UNC5PPxJ3ji4ToOqzHpcSovYRUJbb2ZJ64qTTOZ+1Bw@mail.gmail.com>
 <CALeDE9ONK7CMP6DXKRrjzqxm1r-afB7bgKSDhekrhOMUnhhktQ@mail.gmail.com>
 <CAHc5_t3QQUT=aid9NYRysPvtVG31Ohtvo=RxZkDPo9W9saQUdA@mail.gmail.com>
 <CAC_iWj+HV4dBqa4iG4NfJ9T=jwdqxLMi5Lunis7ZFezQ23VPag@mail.gmail.com>
 <CAHc5_t3oa=Hho+WRSWN4UoE5zSLV-G_Pn6fbZKqzT0eP3ZAZcg@mail.gmail.com>
 <CAHc5_t2_V8huBnpBTQmn-B3assO5hDD0yZAZx=WRAf0jQB7kqw@mail.gmail.com>
In-Reply-To: <CAHc5_t2_V8huBnpBTQmn-B3assO5hDD0yZAZx=WRAf0jQB7kqw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Dec 2023 11:43:57 -0700
Message-ID: <CAPnjgZ21qLnSFcCJ9rPQXEfQf-NjMBF3kYUDBBOc6WUQXQtDEA@mail.gmail.com>
Subject: Re: efi: Set Variable Runtime implementation
To: Shantur Rathore <i@shantur.com>
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

Hi Shantur,

On Mon, 27 Nov 2023 at 10:27, Shantur Rathore <i@shantur.com> wrote:
>
> + Simon as he seems to have done a lot of work in the driver model.
>
> On Mon, Nov 27, 2023 at 10:12=E2=80=AFAM Shantur Rathore <i@shantur.com> =
wrote:
> >
> > Hi Ilias,
> >
> > On Mon, Nov 27, 2023 at 7:16=E2=80=AFAM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Shantur
> > >
> > > On Sun, 26 Nov 2023 at 12:33, Shantur Rathore <i@shantur.com> wrote:
> > > >
> > > > Hi Peter,
> > > >
> > > > On Sat, Nov 25, 2023 at 6:19=E2=80=AFAM Peter Robinson <pbrobinson@=
gmail.com> wrote:
> > > > >
> > > > > Hi Shantur,
> > > > >
> > > > > On Fri, Nov 24, 2023 at 11:55=E2=80=AFPM Shantur Rathore <i@shant=
ur.com> wrote:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > > > On Fri, Nov 24, 2023 at 10:50=E2=80=AFPM Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Shantur
> > > > > > >
> > > > > > > On Fri, 24 Nov 2023 at 18:51, Shantur Rathore <i@shantur.com>=
 wrote:
> > > > > > > >
> > > > > > > > Hi Heinrich,
> > > > > > > >
> > > > > > > > I am trying to work out how to enable the SetVariableRT ser=
vice in
> > > > > > > > U-Boot and came across your patch [1] which initially had t=
he
> > > > > > > > SetVariable RT service enabled in EFI but in the final patc=
h this was
> > > > > > > > removed.
> > > > > > > > I am hoping to implement it on top of the SPI Flash EFI sto=
re [2] to
> > > > > > > > be able to set Boot order and boot items from Linux the UEF=
I way.
> > > > > > > >
> > > > > > > > Can I pick your brain on why it was dropped in the patch?
> > > > > > > > Is there any limitation in SetVariableRT service ?
> > > > > > >
> > > > > > > I recently had a talk about it in Plumbers [0]. Generally spe=
aking, RT
> > > > > > > + hardware owned by the kernel is a very weird combination si=
nce you
> > > > > > > can't guarantee exclusive access to the flash or the bus and =
you have
> > > > > > > to preserve a *lot* of code alive in u-boot.
> > > > > > >
> > > > > > > I'll respond to your v1 patchset and we can discuss details t=
here as well.
> > > > > > >
> > > > > > > [0] https://lpc.events/event/17/contributions/1653/
> > > > > >
> > > > > > Thanks for the background and helping me understand the problem=
.
> > > > > > Makes me wonder how things work in the PC world.
> > > > > > U-boot being only ~1MB, can we not leave it all in memory and m=
aybe
> > > > > > just disable SPI access to Linux.
> > >
> > > That would work, but you cant guarantee Linux wont enable the SPI fla=
sh.
> > >
> > > > >
> > > > > That's basically it, on x86 there's specific HW that's owned by
> > > > > firmware, I don't know the exact low level details of how that wo=
rks.
> > > > >
> > > > > I think x86 devices generally use eSPI for this HW [1] but I don'=
t
> > > > > know the low level details. The Arm SBSA (Server HW spec) and SBB=
R
> > > > > (Server Base Boot Requirements) specs that are key to ServerReady=
 may
> > > > > go into some details too if you're curious.
> > >
> > > On X86 the SPI flash is handled entirely by the firmware and SMM. You
> > > can find more details here [0]
> >
> > Thanks for more info.
> >
> > >
> > > >
> > > > Thanks,
> > > > I think the firmware is still accessible to PCs as one could update=
 the firmware
> > > > in Windows so Windows has access to that device.
> > > >
> > > > I had some try myself and found that setting a variable to memory b=
acked storage
> > > > is doable with SetVariable call but we want to store it in any
> > > > non-volatile storage
> > > > things really don't look good.
> > > >
> > > > To be able to write SetVariable to any device, the whole u-boot dri=
ver
> > > > model would need
> > > > to be kept in memory, might as well just keep the whole u-boot in
> > > > memory at this point, it's anyway small.
> > > > I don't have much knowledge on how to or pros and cons of doing thi=
s.
> > >
> > > The major problem here is who owns the hardware. With the SPI flash
> > > implementation as well as the RPMB implementation Linux owns that
> > > flash.
> > > For the RPMB we've introduced a mechanism so the kernel replaces the
> > > runtime calls with internal functions [1].  I think we should come up
> > > with a similar architecture for SPI. In any case we should keep in
> > > mind that setting authenticated EFI variables should be forbidden on
> > > the file/SPI backends since they are not really secure.
> > >
> >
> > Thanks, I understand now that we can't use SPI flash for saving secure
> > variables and stop Linux from accessing it.
> > My requirement is to be able to save non-Secure boot related variables
> > ( BootOrder, BootNext and BootOptions ).
> > For this purpose as we don't need secure channel and to be compatible
> > with current Linux versions I started
> > implementing SetVariable in runtime in [1]
> > I was able to get it working until it's ready to write stuff into SPI F=
lash.

Yes, this makes sense to me and we don't need secure vars for these
features. They are really just hints from the OS or user.

> > To be able to use SPI Flash, runtime call needs to access the drivers
> > and this needs the whole driver-model to be in
> > efi runtime memory makes me think would it make sense to keep the
> > whole u-boot in efi runtime memory or just
> > driver model and all SPI drivers for now and keep adding other drivers
> > when needed like RPMB.

I don't fully agree with this. The OS is well able to access SPI flash
or any other device. There is no need to ask the firmware to do it,
unless there is some other reason. I can understand calling into a
secure OS, or using a TPM, but for SPI flash this doesn't make much
sense to me.

> >
> > I need some pointers to what would be the best approach accessing
> > hardware from runtime.

We would need to publish a runtime interface with access to the driver
API. I did ask for this when the EFI runtime support was added, but it
wasn't done.

It would be possible to create a new 'runtime' phase of U-Boot (RPL?),
separate from the others. That will be much easier once we get the XPL
stuff sorted out., since adding new [hase would be fairly trivial  CPL
died as another contributor had a series which went in first...then I
never got back to it.

So for now having the entire U-Boot in runtime space seems reasonable to me=
.

I'll also mention that it would be nice to have s new-style API
(replacing the old API U-Boot currently has) which uses more of a
module approach. E.g. we could declare that uclass_first_device() is
exported and can be called from outside U-Boot.

> >
> > [1] - https://github.com/shantur/u-boot/tree/spi-flash-runtime-setvaria=
ble
> >
> > Kind regards,
> > Shantur

Regards,
Simon
