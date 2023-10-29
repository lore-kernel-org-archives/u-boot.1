Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB95CC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 22:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99B4487252;
	Sun, 29 Oct 2023 23:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W/csOY+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2312187252; Sun, 29 Oct 2023 23:02:03 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0448F87252
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 23:02:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so615324066b.2
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 15:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698616920; x=1699221720; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Z8hqAIYGqdjitVKMCPMiAwtDVk1EnOq9DrlGdfmGRw=;
 b=W/csOY+4M+idHHRKbhy8w7q2gEUoxJXKCv6f2ACYFlROJdpBDUIXCjqcf4bZ0YaVYw
 jpsdAqKE3kmp8R/a5eU+pyniOJiLe7MulpyN9cWjzNhSQOMYgb0WcyuVFAM4/uj3B263
 qTsNEiMcNjzbZ2jMCjEt7a22VsCh3YljKfm35DzGJ6s4gJnPF1Kp3h/JxEY53Y7+wF+x
 tfXzmaGiLfs591Qudae3ghdtTIu8rAbrSp28O96o0AfEg5gIfAyGv0VfyvreWh+LO6H7
 bJqZ67UTY7zCm/sgZofath1nMcRIN96Q21ISnvfwKEekzZjNcgYPIly6m8KwhbZWjpVO
 V/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698616920; x=1699221720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Z8hqAIYGqdjitVKMCPMiAwtDVk1EnOq9DrlGdfmGRw=;
 b=BY7P2dyi1vDWRe5P2etR3iVhrSb5znhau/Q5UoKcz11+2+OomQnFPNEo5P337SECdo
 vZDRZYvcwl1wthWEL62yRodHuimOjxEOrE4vVg9B+ec3q/kuOfMHF/KrSMJ7NCCice3v
 katZda7pFlm75KdtkSitxFwLlXIABxUAn7bG/zhiAG8oxnJWBh4Xx5f+9oLsg+d4L5kY
 LQyV46nPBKdBig6ooEMiIkyMkbtnPcwHXmIvXfCRQy58h6g4nARC1XJM52sarCtoPu5L
 0R84sO+8rqNmO726MbluhidKsfkHdq2CdJaE3eObU3i9HKIP0cpacxriOp8HigS0ufkG
 /vww==
X-Gm-Message-State: AOJu0Yx598Vy6yKTbmmLKWzYUaipEP1/OTtau5gYiJP5+VQY7EMqiQx6
 GlgKotApZ+uNqWEB/yywdpc7gH2rlLhuCgG0VZI=
X-Google-Smtp-Source: AGHT+IFBSXhF0X9E1/PMu8PMWOAst0R8fW5bcxfj6M/4czVxVkwnGXigx+SNz+CKkaIWvCiUKtUn2pet1DGebOihU9I=
X-Received: by 2002:a17:907:1c0f:b0:9bf:2f84:5de7 with SMTP id
 nc15-20020a1709071c0f00b009bf2f845de7mr7498434ejc.4.1698616920248; Sun, 29
 Oct 2023 15:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231027-usb-fixes-1-v1-1-1c879bbcd928@marcan.st>
 <20231026232642.16668-1-marcan@marcan.st>
 <f2cd8dab-a494-4e9a-b450-0311444f436b@denx.de>
 <314492c3-4cd3-2711-1693-6d58501a9bd9@marcan.st>
 <b59472a6-a7e3-4bbd-814f-0c32265c14c3@denx.de>
 <CALeDE9M0DJ1DWucKDExEb67-vz7_BiU0kT1gUV_TVbb4OWPwhQ@mail.gmail.com>
In-Reply-To: <CALeDE9M0DJ1DWucKDExEb67-vz7_BiU0kT1gUV_TVbb4OWPwhQ@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sun, 29 Oct 2023 15:01:48 -0700
Message-ID: <CAJaLiFxZNpBvmuf0eAyjx70R=OOOVKJL1KKpy_8Q8bMGjvNkSQ@mail.gmail.com>
Subject: Re: [PATCH] fixup! usb: xhci: Guard all calls to xhci_wait_for_event
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Hector Martin <marcan@marcan.st>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 asahi@lists.linux.de, Minda Chen <minda.chen@starfivetech.com>
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

On Sun, Oct 29, 2023 at 2:33=E2=80=AFPM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> On Sun, Oct 29, 2023 at 9:25=E2=80=AFPM Marek Vasut <marex@denx.de> wrote=
:
> >
> > On 10/27/23 08:03, Hector Martin wrote:
> > > On 27/10/2023 09.36, Marek Vasut wrote:
> > >> On 10/27/23 01:26, Hector Martin wrote:
> > >>> Gah, I should've paid more attention to that rebase. Here's a dumb
> > >>> fixup for this patch. I'll squash it into a v2 if needed alongside
> > >>> any other changes, or if it looks good feel free to apply/squash
> > >>> it in directly.
> > >>>
> > >>> ---
> > >>>    drivers/usb/host/xhci-ring.c | 1 +
> > >>>    1 file changed, 1 insertion(+)
> > >>>
> > >>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-r=
ing.c
> > >>> index e2bd2e999a8e..7f2507be0cf0 100644
> > >>> --- a/drivers/usb/host/xhci-ring.c
> > >>> +++ b/drivers/usb/host/xhci-ring.c
> > >>> @@ -532,6 +532,7 @@ static void reset_ep(struct usb_device *udev, i=
nt ep_index)
> > >>>     event =3D xhci_wait_for_event(ctrl, TRB_COMPLETION);
> > >>>     if (!event)
> > >>>             return;
> > >>> +   field =3D le32_to_cpu(event->trans_event.flags);
> > >>>     BUG_ON(TRB_TO_SLOT_ID(field) !=3D udev->slot_id);
> > >>>     xhci_acknowledge_event(ctrl);
> > >>
> > >> Please squash, and add
> > >>
> > >> Reviewed-by: Marek Vasut <marex@denx.de>
> > >>
> > >> Also, +CC Minda,
> > >>
> > >> there has been a similar fix to this one but with much more informat=
ion
> > >> about the failure, see:
> > >>
> > >> [PATCH v1] usb: xhci: Check return value of wait for TRB_TRANSFER ev=
ent
> > >>
> > >> I think it would be useful to somehow include that information, so i=
t
> > >> wouldn't be lost.
> > >
> > > The root cause for *that* failure is what I fix in patch #5. From tha=
t
> > > thread:
> > >
> > >> scanning bus xhci_pci for devices... WARN halted endpoint, queueing
> > > URB anyway.
> > >
> > > Without #5 and without #1, that situation then leads to fireworks.
> > >
> > > A bunch of things are broken, which is why this is a series and not a
> > > single patch. I have more fixes to timeout handling, mass storage, et=
c.
> > > coming up after this. I fixed most of this in one long day of trying
> > > random USB devices, so it's not so much subtle super specific problem=
s I
> > > could document the crashes for as just wide-ranging problems in the
> > > u-boot USB stack. None of this is particularly hard to repro if you j=
ust
> > > try a bunch of normal consumer USB devices, including things like USB
> > > HDDs which take time to spin-up leading to timeouts etc.
> >
> > I think majority of users I can think of use USB mass storage devices,
> > like USB pen drives, not so much HDDs as far as I can tell.
>
> We see a bunch of spinning rust users in Fedora, these sorts of
> devices are used by a bunch of people that want to run up cheap home
> NAS devices so from experience I'd say while not usual to be USB
> sticks and some form of solid state storage, spinning disk isn't
> unusual.

What Peter said. A very common use case, even more so than USB flash
drives, is for the consumers to plug in a USB HDD to their routers or
home NAS, as a cheap and quick solution. I've seen this type of
timeout failure happen quite often with large >=3D 3TB HDDs in USB
enclosure.

All the best,
Tony

>
> > > The crash dumps
> > > aren't particularly useful, it's the subtleties of the xHCI interacti=
ons
> > > that are, but for that you need to add and enable a lot more debuggin=
g
> > > (patch #8).
> >
> > The crash dumps are more for posterity, when someone searches for a
> > problem they see. Search engines tend to pick those up and it might
> > point those people in the right direction.
> >
> > Also, it is good to include information about what triggered the crash,
> > e.g. which USB device on which hardware, in case this is needed in the
> > future.
> >
> > > I think the main reason all this stuff is broken and we're finding ou=
t
> > > now is that u-boot has traditionally been used in embedded devices wi=
th
> > > fairly narrow use cases for USB
> >
> > Yes
> >
> > >, and now we're running it on
> > > workstation-grade laptops and desktops and people are plugging in all
> > > kinds of normal USB devices and expecting their bootloader not to fre=
ak
> > > out with them (even though most of the time it doesn't need to talk t=
o
> > > them). It's really easy to run into this stuff when that's your use c=
ase.
> >
> > It is really appreciated to see people fix things like this stuff, than=
ks !
