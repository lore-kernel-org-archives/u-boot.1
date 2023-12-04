Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F2DC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD51A878FC;
	Mon,  4 Dec 2023 01:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Li2dXhAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3B4878AF; Mon,  4 Dec 2023 01:44:45 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 274B687884
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-54bfa9b3ffaso5035249a12.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701650680; x=1702255480; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1nH+PBIp0LY/DZhcaitjRV7CFILEfUOxaS7NuRWm+M=;
 b=Li2dXhAHFJHVfGb3MMKj5pp4Tu5R1pXL6iyg5wzlweRCw2r8mS6kUoFj8SocOeKsub
 +I9kUMpvZxHFZESJ5QLHSlMk0WAfByNLJe8AHqocr+ICjkqgkUGN5nwDsMiqhWp/xuvf
 TT+7XQrJsPk0QR5yMyuTKhd9UEfHq9aYNZ0sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701650680; x=1702255480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1nH+PBIp0LY/DZhcaitjRV7CFILEfUOxaS7NuRWm+M=;
 b=STisUaM9NTVsxy00MHaruqLj7JKm15ZW3gZ7g5oWCF5QYrmgSiSo0EEzphImyUXQZz
 /OuAonr+EJ+3dcrXlnRu8jmy5vGWijpk+nFsdwsyr1D9WrIneENH2z7jDCyfsjI0gPp9
 9LbRaNgLP4jTW8Y6Zu6v9Fmoc/Sc2DmMj8TMUXNMFehMOopjuft46Oyxm9k4HjZk5PyX
 K/wBz7MJxlcFvF5tnZVk+ulDlcTqvc/MaUm6u2SVvpYWBzdUdltds0Hrh8i0xTq4BLOs
 VnFFyhK1egTlKFMWrp9DM7OpsS6xWnTukJR/SOOucwOhKolzuq5vK8LJJ60WqehDZdLm
 At3Q==
X-Gm-Message-State: AOJu0YyTXDnM3L+1rO+VizhUIvPnTpxwQOpMc8fXnpYN5E6i5wVnKbQe
 rsWJHxYMP5Mei4ROb9OP1tW2RpfN4b2I8wzXpZk7xA==
X-Google-Smtp-Source: AGHT+IG0hQH0WNZfXkQAMINQ0lAiURZQwTPruOL5KlM2H6tHCz3CEtaugq1sQ7L8UmB6QXQaGFg421ejzGBBnYZbLSA=
X-Received: by 2002:a17:906:71db:b0:a18:92db:282b with SMTP id
 i27-20020a17090671db00b00a1892db282bmr2638021ejk.39.1701650680395; Sun, 03
 Dec 2023 16:44:40 -0800 (PST)
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
 <CAHc5_t3dRJXNNjpjsqNov7Pfu7HLDP7x6POobRN=8XBcSXZnyg@mail.gmail.com>
In-Reply-To: <CAHc5_t3dRJXNNjpjsqNov7Pfu7HLDP7x6POobRN=8XBcSXZnyg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Dec 2023 17:44:26 -0700
Message-ID: <CAPnjgZ27OXUNwZUdvW+3S2Mmt-RMgeBME440VEiV62U-A6QY4g@mail.gmail.com>
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

On Sun, 3 Dec 2023 at 14:51, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Simon,
>
> On Sun, Dec 3, 2023 at 5:44=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Shantur,
> >
> > On Sat, 2 Dec 2023 at 16:03, Shantur Rathore <i@shantur.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Fri, Dec 1, 2023 at 6:44=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > > >
> > > > Hi Shantur,
> > > >
> > > > On Mon, 27 Nov 2023 at 10:27, Shantur Rathore <i@shantur.com> wrote=
:
> > > > >
> > > > > + Simon as he seems to have done a lot of work in the driver mode=
l.
> > > > >
> > > > > On Mon, Nov 27, 2023 at 10:12=E2=80=AFAM Shantur Rathore <i@shant=
ur.com> wrote:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > > > On Mon, Nov 27, 2023 at 7:16=E2=80=AFAM Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Shantur
> > > > > > >
> > > > > > > On Sun, 26 Nov 2023 at 12:33, Shantur Rathore <i@shantur.com>=
 wrote:
> > > > > > > >
> > > > > > > > Hi Peter,
> > > > > > > >
> > > > > > > > On Sat, Nov 25, 2023 at 6:19=E2=80=AFAM Peter Robinson <pbr=
obinson@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Shantur,
> > > > > > > > >
> > > > > > > > > On Fri, Nov 24, 2023 at 11:55=E2=80=AFPM Shantur Rathore =
<i@shantur.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Ilias,
> > > > > > > > > >
> > > > > > > > > > On Fri, Nov 24, 2023 at 10:50=E2=80=AFPM Ilias Apalodim=
as
> > > > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Shantur
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 24 Nov 2023 at 18:51, Shantur Rathore <i@shan=
tur.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > > >
> > > > > > > > > > > > I am trying to work out how to enable the SetVariab=
leRT service in
> > > > > > > > > > > > U-Boot and came across your patch [1] which initial=
ly had the
> > > > > > > > > > > > SetVariable RT service enabled in EFI but in the fi=
nal patch this was
> > > > > > > > > > > > removed.
> > > > > > > > > > > > I am hoping to implement it on top of the SPI Flash=
 EFI store [2] to
> > > > > > > > > > > > be able to set Boot order and boot items from Linux=
 the UEFI way.
> > > > > > > > > > > >
> > > > > > > > > > > > Can I pick your brain on why it was dropped in the =
patch?
> > > > > > > > > > > > Is there any limitation in SetVariableRT service ?
> > > > > > > > > > >
> > > > > > > > > > > I recently had a talk about it in Plumbers [0]. Gener=
ally speaking, RT
> > > > > > > > > > > + hardware owned by the kernel is a very weird combin=
ation since you
> > > > > > > > > > > can't guarantee exclusive access to the flash or the =
bus and you have
> > > > > > > > > > > to preserve a *lot* of code alive in u-boot.
> > > > > > > > > > >
> > > > > > > > > > > I'll respond to your v1 patchset and we can discuss d=
etails there as well.
> > > > > > > > > > >
> > > > > > > > > > > [0] https://lpc.events/event/17/contributions/1653/
> > > > > > > > > >
> > > > > > > > > > Thanks for the background and helping me understand the=
 problem.
> > > > > > > > > > Makes me wonder how things work in the PC world.
> > > > > > > > > > U-boot being only ~1MB, can we not leave it all in memo=
ry and maybe
> > > > > > > > > > just disable SPI access to Linux.
> > > > > > >
> > > > > > > That would work, but you cant guarantee Linux wont enable the=
 SPI flash.
> > > > > > >
> > > > > > > > >
> > > > > > > > > That's basically it, on x86 there's specific HW that's ow=
ned by
> > > > > > > > > firmware, I don't know the exact low level details of how=
 that works.
> > > > > > > > >
> > > > > > > > > I think x86 devices generally use eSPI for this HW [1] bu=
t I don't
> > > > > > > > > know the low level details. The Arm SBSA (Server HW spec)=
 and SBBR
> > > > > > > > > (Server Base Boot Requirements) specs that are key to Ser=
verReady may
> > > > > > > > > go into some details too if you're curious.
> > > > > > >
> > > > > > > On X86 the SPI flash is handled entirely by the firmware and =
SMM. You
> > > > > > > can find more details here [0]
> > > > > >
> > > > > > Thanks for more info.
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > I think the firmware is still accessible to PCs as one coul=
d update the firmware
> > > > > > > > in Windows so Windows has access to that device.
> > > > > > > >
> > > > > > > > I had some try myself and found that setting a variable to =
memory backed storage
> > > > > > > > is doable with SetVariable call but we want to store it in =
any
> > > > > > > > non-volatile storage
> > > > > > > > things really don't look good.
> > > > > > > >
> > > > > > > > To be able to write SetVariable to any device, the whole u-=
boot driver
> > > > > > > > model would need
> > > > > > > > to be kept in memory, might as well just keep the whole u-b=
oot in
> > > > > > > > memory at this point, it's anyway small.
> > > > > > > > I don't have much knowledge on how to or pros and cons of d=
oing this.
> > > > > > >
> > > > > > > The major problem here is who owns the hardware. With the SPI=
 flash
> > > > > > > implementation as well as the RPMB implementation Linux owns =
that
> > > > > > > flash.
> > > > > > > For the RPMB we've introduced a mechanism so the kernel repla=
ces the
> > > > > > > runtime calls with internal functions [1].  I think we should=
 come up
> > > > > > > with a similar architecture for SPI. In any case we should ke=
ep in
> > > > > > > mind that setting authenticated EFI variables should be forbi=
dden on
> > > > > > > the file/SPI backends since they are not really secure.
> > > > > > >
> > > > > >
> > > > > > Thanks, I understand now that we can't use SPI flash for saving=
 secure
> > > > > > variables and stop Linux from accessing it.
> > > > > > My requirement is to be able to save non-Secure boot related va=
riables
> > > > > > ( BootOrder, BootNext and BootOptions ).
> > > > > > For this purpose as we don't need secure channel and to be comp=
atible
> > > > > > with current Linux versions I started
> > > > > > implementing SetVariable in runtime in [1]
> > > > > > I was able to get it working until it's ready to write stuff in=
to SPI Flash.
> > > >
> > > > Yes, this makes sense to me and we don't need secure vars for these
> > > > features. They are really just hints from the OS or user.
> > > >
> > > > > > To be able to use SPI Flash, runtime call needs to access the d=
rivers
> > > > > > and this needs the whole driver-model to be in
> > > > > > efi runtime memory makes me think would it make sense to keep t=
he
> > > > > > whole u-boot in efi runtime memory or just
> > > > > > driver model and all SPI drivers for now and keep adding other =
drivers
> > > > > > when needed like RPMB.
> > > >
> > > > I don't fully agree with this. The OS is well able to access SPI fl=
ash
> > > > or any other device. There is no need to ask the firmware to do it,
> > > > unless there is some other reason. I can understand calling into a
> > > > secure OS, or using a TPM, but for SPI flash this doesn't make much
> > > > sense to me.
> > > >
> > >
> > > Sure, the OS can write to SPI Flash but the OS won't know what / wher=
e to write
> > > that U-Boot will be able to read and use as an EFI variable.
> > > AFAIK, all UEFI firmwares have some non volatile storage where firmwa=
re stores
> > > variables. As U-boot doesn't have its own non-volatile storage we wan=
t
> > > to allow u-boot to
> > > write EFI variables in SPI.
> > > This is needed to be able to manage EFI boot entries with efibootmgr =
in Linux.
> >
> > We can pass the offset of the vars to the OS using the devicetree,
> > e.g. using the fixed-partition binding, so then fwupd (or whatever)
> > can do the update.
> >
>
> Sure, we could do this but then this would be a non-standard way of
> managing the
> EFI variables.

Apparently. I keep thinking of this talk:

https://www.youtube.com/watch?v=3D36myc8wQhLo

This is a longer discussion, but I believe that much of the firmware
design happening today is an unnecessary obfuscation.

Regards,
Simon


>
> > >
> > > Why does he need it, you might think.
> > > My aim is to automate OS deployment on ARM boards for which I use
> > > Canonical MAAS.
> > > As a netinstall process the boot partition is configured as part of i=
nstall.
> > > As EFI/boot/bootxxxx.efi is optional [0], some distros like debian an=
d
> > > debian based Armbian
> > > don't install EFI/boot/bootxxxx.efi by default, it tries to set a boo=
t
> > > entry with efibootmgr
> > > and can't so I had to disable it.
> > > Now that update nvram is disabled in grub-install, it doesn't set up =
a
> > > boot variable but
> > > also doesn't install EFI/boot/bootxxxx.efi but EFI/debian/grubxxxx.ef=
i.
> > >
> > > I am able to work around by manually forcing grub-install with --remo=
vable param
> > > to force it to install EFI/boot/bootxxxx.efi, so it kinda works.
> > >
> > > This made me think of improvements we can make in u-boot to allow it
> > > function more
> > > like real UEFI firmware where it can.
> >
> > OK, I see.
> >
> > >
> > > > > >
> > > > > > I need some pointers to what would be the best approach accessi=
ng
> > > > > > hardware from runtime.
> > > >
> > > > We would need to publish a runtime interface with access to the dri=
ver
> > > > API. I did ask for this when the EFI runtime support was added, but=
 it
> > > > wasn't done.
> > > >
> > > > It would be possible to create a new 'runtime' phase of U-Boot (RPL=
?),
> > > > separate from the others. That will be much easier once we get the =
XPL
> > > > stuff sorted out., since adding new [hase would be fairly trivial  =
CPL
> > > > died as another contributor had a series which went in first...then=
 I
> > > > never got back to it.
> > > >
> > > > So for now having the entire U-Boot in runtime space seems reasonab=
le to me.
> > > >
> > > > I'll also mention that it would be nice to have s new-style API
> > > > (replacing the old API U-Boot currently has) which uses more of a
> > > > module approach. E.g. we could declare that uclass_first_device() i=
s
> > > > exported and can be called from outside U-Boot.
> > >
> > > I think this is way more deep than my current understanding of the u-=
boot and
> > > boot process. I might be able to implement this if and when RPMB acce=
ss is
> > > implemented for OP-TEE based access.
> >
> > Yes...it is a tricky area, but perhaps we can copy what Linux does
> > with the EXPORT_SYMBOL() macro. Anyway, that is for the future
> >
> Maybe, I will park this for now and wait for the OP-TEE RPMB solution.
>
> Kind regards,
> Shantur
