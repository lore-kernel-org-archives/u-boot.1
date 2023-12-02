Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40FCC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 23:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38E5387780;
	Sun,  3 Dec 2023 00:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="In9j1ITK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAFEC8778F; Sun,  3 Dec 2023 00:03:35 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49E328777B
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 00:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40bd5eaa66cso11946155e9.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 15:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701558212; x=1702163012;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g1dlwFAfWx2aCVhPitTu0bTLbKUOftsnrjqolpw3GcI=;
 b=In9j1ITKO/QdQVBxmD/zUzcTV1qShR34MGqZlVQsiTHCXTj0UMu47Um2aVyUomIzjJ
 LiuhUR//+ejHxc3FirUtN+gpxIX1XKCou1lCOUmkyEOuXms/xN1/POF7xc8SYLF8fbDu
 Bg1L91WkHjBhgYLeQ0FTeRvD3kxobIdTNZxnyNkBe5azpodDc6X8VLrKRDgixRVPyrGw
 aSX5dsgyK2eAlofrsYEXkm9MV583B8JU3h9wlObn9dhEi3naQPc6T/9ZJrrau7VjoDAr
 ZFpwkEcG2EJYQpfimlTfXTiT0wh16HLAnxGs9eFosOWDaR/vh1TCmRwBw5nahPs/akAw
 I3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701558212; x=1702163012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g1dlwFAfWx2aCVhPitTu0bTLbKUOftsnrjqolpw3GcI=;
 b=fos+J5OW16jlSLmHE0pSBq184ZXvgyREtgGCenixAMrsyOavfz5Z1FwcC02mWw+P8s
 ClgYwdRNDJXN4tCMl/MshUjBVn03J2dJXbwAVff4k4stmVmJ4Cs0p/9hPDXQYgM/R/Kf
 SN/CS5+5uuDB5xROpSPnmuQM2WvQKHbBZ916cyDn3VOEpbr1+hNN/dAJSm6GDqKjpSwn
 Jq3NxZ1rHGXLc5v+ClpL2VUIE0YhBe0JasJ34A/2yRGI22ZyJe3eGNc9D5bm94S7ckQz
 O3lyd/ESeRKF43n+PU7quuRyVpwiOMHWA+VvXbgy4GQpZ3ujBJk+aFMfDCbh+e5rGgE+
 WFlA==
X-Gm-Message-State: AOJu0Yy4FlWr8VJVPFyPWzcjM+2mAWT/sj3DMcj/7DZiMjcIOC78Ikei
 6pR21HEMQnpqCcN3YV8ujJPnXYvTwq4+hk5/CEgTlQ==
X-Google-Smtp-Source: AGHT+IEhLenzQF9+jsmemB+ocaVP3MMn1D7ScrooWuHFQBCRJrDAJ88RRRiwrnO4b0UosDyvF1foPA==
X-Received: by 2002:a05:600c:4d02:b0:40b:36e6:78c5 with SMTP id
 u2-20020a05600c4d0200b0040b36e678c5mr1300682wmp.37.1701558212158; 
 Sat, 02 Dec 2023 15:03:32 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170906111200b00a0d02cfa48bsm3539248eja.213.2023.12.02.15.03.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 15:03:31 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-54c846da5e9so582856a12.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 15:03:31 -0800 (PST)
X-Received: by 2002:a50:a446:0:b0:54c:6fd0:fdea with SMTP id
 v6-20020a50a446000000b0054c6fd0fdeamr1501492edb.24.1701558211204; Sat, 02 Dec
 2023 15:03:31 -0800 (PST)
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
In-Reply-To: <CAPnjgZ21qLnSFcCJ9rPQXEfQf-NjMBF3kYUDBBOc6WUQXQtDEA@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Sat, 2 Dec 2023 23:03:20 +0000
X-Gmail-Original-Message-ID: <CAHc5_t37JdQUHN+R9i15X1hOuXuMNt08TrzeawYy149R7qkRyw@mail.gmail.com>
Message-ID: <CAHc5_t37JdQUHN+R9i15X1hOuXuMNt08TrzeawYy149R7qkRyw@mail.gmail.com>
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

On Fri, Dec 1, 2023 at 6:44=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Shantur,
>
> On Mon, 27 Nov 2023 at 10:27, Shantur Rathore <i@shantur.com> wrote:
> >
> > + Simon as he seems to have done a lot of work in the driver model.
> >
> > On Mon, Nov 27, 2023 at 10:12=E2=80=AFAM Shantur Rathore <i@shantur.com=
> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Mon, Nov 27, 2023 at 7:16=E2=80=AFAM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Shantur
> > > >
> > > > On Sun, 26 Nov 2023 at 12:33, Shantur Rathore <i@shantur.com> wrote=
:
> > > > >
> > > > > Hi Peter,
> > > > >
> > > > > On Sat, Nov 25, 2023 at 6:19=E2=80=AFAM Peter Robinson <pbrobinso=
n@gmail.com> wrote:
> > > > > >
> > > > > > Hi Shantur,
> > > > > >
> > > > > > On Fri, Nov 24, 2023 at 11:55=E2=80=AFPM Shantur Rathore <i@sha=
ntur.com> wrote:
> > > > > > >
> > > > > > > Hi Ilias,
> > > > > > >
> > > > > > > On Fri, Nov 24, 2023 at 10:50=E2=80=AFPM Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Hi Shantur
> > > > > > > >
> > > > > > > > On Fri, 24 Nov 2023 at 18:51, Shantur Rathore <i@shantur.co=
m> wrote:
> > > > > > > > >
> > > > > > > > > Hi Heinrich,
> > > > > > > > >
> > > > > > > > > I am trying to work out how to enable the SetVariableRT s=
ervice in
> > > > > > > > > U-Boot and came across your patch [1] which initially had=
 the
> > > > > > > > > SetVariable RT service enabled in EFI but in the final pa=
tch this was
> > > > > > > > > removed.
> > > > > > > > > I am hoping to implement it on top of the SPI Flash EFI s=
tore [2] to
> > > > > > > > > be able to set Boot order and boot items from Linux the U=
EFI way.
> > > > > > > > >
> > > > > > > > > Can I pick your brain on why it was dropped in the patch?
> > > > > > > > > Is there any limitation in SetVariableRT service ?
> > > > > > > >
> > > > > > > > I recently had a talk about it in Plumbers [0]. Generally s=
peaking, RT
> > > > > > > > + hardware owned by the kernel is a very weird combination =
since you
> > > > > > > > can't guarantee exclusive access to the flash or the bus an=
d you have
> > > > > > > > to preserve a *lot* of code alive in u-boot.
> > > > > > > >
> > > > > > > > I'll respond to your v1 patchset and we can discuss details=
 there as well.
> > > > > > > >
> > > > > > > > [0] https://lpc.events/event/17/contributions/1653/
> > > > > > >
> > > > > > > Thanks for the background and helping me understand the probl=
em.
> > > > > > > Makes me wonder how things work in the PC world.
> > > > > > > U-boot being only ~1MB, can we not leave it all in memory and=
 maybe
> > > > > > > just disable SPI access to Linux.
> > > >
> > > > That would work, but you cant guarantee Linux wont enable the SPI f=
lash.
> > > >
> > > > > >
> > > > > > That's basically it, on x86 there's specific HW that's owned by
> > > > > > firmware, I don't know the exact low level details of how that =
works.
> > > > > >
> > > > > > I think x86 devices generally use eSPI for this HW [1] but I do=
n't
> > > > > > know the low level details. The Arm SBSA (Server HW spec) and S=
BBR
> > > > > > (Server Base Boot Requirements) specs that are key to ServerRea=
dy may
> > > > > > go into some details too if you're curious.
> > > >
> > > > On X86 the SPI flash is handled entirely by the firmware and SMM. Y=
ou
> > > > can find more details here [0]
> > >
> > > Thanks for more info.
> > >
> > > >
> > > > >
> > > > > Thanks,
> > > > > I think the firmware is still accessible to PCs as one could upda=
te the firmware
> > > > > in Windows so Windows has access to that device.
> > > > >
> > > > > I had some try myself and found that setting a variable to memory=
 backed storage
> > > > > is doable with SetVariable call but we want to store it in any
> > > > > non-volatile storage
> > > > > things really don't look good.
> > > > >
> > > > > To be able to write SetVariable to any device, the whole u-boot d=
river
> > > > > model would need
> > > > > to be kept in memory, might as well just keep the whole u-boot in
> > > > > memory at this point, it's anyway small.
> > > > > I don't have much knowledge on how to or pros and cons of doing t=
his.
> > > >
> > > > The major problem here is who owns the hardware. With the SPI flash
> > > > implementation as well as the RPMB implementation Linux owns that
> > > > flash.
> > > > For the RPMB we've introduced a mechanism so the kernel replaces th=
e
> > > > runtime calls with internal functions [1].  I think we should come =
up
> > > > with a similar architecture for SPI. In any case we should keep in
> > > > mind that setting authenticated EFI variables should be forbidden o=
n
> > > > the file/SPI backends since they are not really secure.
> > > >
> > >
> > > Thanks, I understand now that we can't use SPI flash for saving secur=
e
> > > variables and stop Linux from accessing it.
> > > My requirement is to be able to save non-Secure boot related variable=
s
> > > ( BootOrder, BootNext and BootOptions ).
> > > For this purpose as we don't need secure channel and to be compatible
> > > with current Linux versions I started
> > > implementing SetVariable in runtime in [1]
> > > I was able to get it working until it's ready to write stuff into SPI=
 Flash.
>
> Yes, this makes sense to me and we don't need secure vars for these
> features. They are really just hints from the OS or user.
>
> > > To be able to use SPI Flash, runtime call needs to access the drivers
> > > and this needs the whole driver-model to be in
> > > efi runtime memory makes me think would it make sense to keep the
> > > whole u-boot in efi runtime memory or just
> > > driver model and all SPI drivers for now and keep adding other driver=
s
> > > when needed like RPMB.
>
> I don't fully agree with this. The OS is well able to access SPI flash
> or any other device. There is no need to ask the firmware to do it,
> unless there is some other reason. I can understand calling into a
> secure OS, or using a TPM, but for SPI flash this doesn't make much
> sense to me.
>

Sure, the OS can write to SPI Flash but the OS won't know what / where to w=
rite
that U-Boot will be able to read and use as an EFI variable.
AFAIK, all UEFI firmwares have some non volatile storage where firmware sto=
res
variables. As U-boot doesn't have its own non-volatile storage we want
to allow u-boot to
write EFI variables in SPI.
This is needed to be able to manage EFI boot entries with efibootmgr in Lin=
ux.

Why does he need it, you might think.
My aim is to automate OS deployment on ARM boards for which I use
Canonical MAAS.
As a netinstall process the boot partition is configured as part of install=
.
As EFI/boot/bootxxxx.efi is optional [0], some distros like debian and
debian based Armbian
don't install EFI/boot/bootxxxx.efi by default, it tries to set a boot
entry with efibootmgr
and can't so I had to disable it.
Now that update nvram is disabled in grub-install, it doesn't set up a
boot variable but
also doesn't install EFI/boot/bootxxxx.efi but EFI/debian/grubxxxx.efi.

I am able to work around by manually forcing grub-install with --removable =
param
to force it to install EFI/boot/bootxxxx.efi, so it kinda works.

This made me think of improvements we can make in u-boot to allow it
function more
like real UEFI firmware where it can.

> > >
> > > I need some pointers to what would be the best approach accessing
> > > hardware from runtime.
>
> We would need to publish a runtime interface with access to the driver
> API. I did ask for this when the EFI runtime support was added, but it
> wasn't done.
>
> It would be possible to create a new 'runtime' phase of U-Boot (RPL?),
> separate from the others. That will be much easier once we get the XPL
> stuff sorted out., since adding new [hase would be fairly trivial  CPL
> died as another contributor had a series which went in first...then I
> never got back to it.
>
> So for now having the entire U-Boot in runtime space seems reasonable to =
me.
>
> I'll also mention that it would be nice to have s new-style API
> (replacing the old API U-Boot currently has) which uses more of a
> module approach. E.g. we could declare that uclass_first_device() is
> exported and can be called from outside U-Boot.

I think this is way more deep than my current understanding of the u-boot a=
nd
boot process. I might be able to implement this if and when RPMB access is
implemented for OP-TEE based access.

[0] - https://www.rodsbooks.com/efi-bootloaders/principles.html

Kind Regards,
Shantur
