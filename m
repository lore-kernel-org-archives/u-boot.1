Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314C0C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 21:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39CDE87158;
	Sun, 29 Oct 2023 22:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cInEG5UZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C786487158; Sun, 29 Oct 2023 22:33:22 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71FA587154
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 22:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53dd752685fso6116782a12.3
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 14:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698615197; x=1699219997; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBnf0AaLUXL0TiKjHEQGfrW+A7UpMyw7OzlxLSyVvjE=;
 b=cInEG5UZhn/F0I0AEOJ8otdSorJF8+o3inY/4A3fqPtuzLAKWoXu8JApBWdi7fqvgR
 CH3AxqPfr3POtAbik5NtmTAjhMgxGYRRWGctfLYoJbDxinsxqHomoJz5l7cVpehva3tE
 Pl9b7blw0NWHZYkowxvlmOmq5GDn5pcVMk19FK+rDEVRTXtIBI/7LO95J8eRb7T3N40h
 X5WtPI487WMwoic67yUPr+qOxlaXozaKoXhb9ZMc/RM3M0StY4flCPkBChadaBLMtcfi
 9C2qiMLd9keeliT0yBUWhBs5PhPlHvOETDZW35oLTAh9Uy4QLtKx1W5sDIdYap02yhrL
 7Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698615197; x=1699219997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PBnf0AaLUXL0TiKjHEQGfrW+A7UpMyw7OzlxLSyVvjE=;
 b=FejntCJ7sJ99DnXxR3/eHeuUrG+Hp4FpeUK8sOAXzNbT3JS5qwNa/kvOBSkf4qj65A
 acLe78KNwcZWu021tmz7H+u9GxqT624RkLc2zH5JErBFO2urjL4knPRxRwgqO1CnAT0/
 YXFIPw2iiDhwVNEOF2bb/olb7ZeKh2aeoDK3j0tkI0A39Os0Za0rypWXgyszDSYDZiL5
 4VWAuVQnIZTBvqPdrLnk+J0nlb1jMNxv9y7DRUs12RofucLYZnpPEkA8rhIdgkTsguba
 gsaJaOWRrnPPMcUgwOCtIR9Ld1TO72Qme2Scvu/qSKtRjuKUDwdmKLmqdvg2ie6Pkw23
 hlFw==
X-Gm-Message-State: AOJu0Yy+jRjsXo7rn2wCffIaElqluMYOXKol/tzgIlKtWdcAII3ywAjD
 Vs8xHXeR35TA6PVdH9mTRiJku3SEElNYICYs6q0=
X-Google-Smtp-Source: AGHT+IFPg6BCxjfuwJMRy6cypNIxFOppHQZbHg2mXhYid26+bxy4aUKwx0dEDScMvVvKBWvnPVEE2VvPIqvAVeV7WFo=
X-Received: by 2002:a05:6402:2912:b0:53e:81f6:8060 with SMTP id
 ee18-20020a056402291200b0053e81f68060mr6198148edb.14.1698615196652; Sun, 29
 Oct 2023 14:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231027-usb-fixes-1-v1-1-1c879bbcd928@marcan.st>
 <20231026232642.16668-1-marcan@marcan.st>
 <f2cd8dab-a494-4e9a-b450-0311444f436b@denx.de>
 <314492c3-4cd3-2711-1693-6d58501a9bd9@marcan.st>
 <b59472a6-a7e3-4bbd-814f-0c32265c14c3@denx.de>
In-Reply-To: <b59472a6-a7e3-4bbd-814f-0c32265c14c3@denx.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 29 Oct 2023 21:33:05 +0000
Message-ID: <CALeDE9M0DJ1DWucKDExEb67-vz7_BiU0kT1gUV_TVbb4OWPwhQ@mail.gmail.com>
Subject: Re: [PATCH] fixup! usb: xhci: Guard all calls to xhci_wait_for_event
To: Marek Vasut <marex@denx.de>
Cc: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>, 
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

On Sun, Oct 29, 2023 at 9:25=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 10/27/23 08:03, Hector Martin wrote:
> > On 27/10/2023 09.36, Marek Vasut wrote:
> >> On 10/27/23 01:26, Hector Martin wrote:
> >>> Gah, I should've paid more attention to that rebase. Here's a dumb
> >>> fixup for this patch. I'll squash it into a v2 if needed alongside
> >>> any other changes, or if it looks good feel free to apply/squash
> >>> it in directly.
> >>>
> >>> ---
> >>>    drivers/usb/host/xhci-ring.c | 1 +
> >>>    1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-rin=
g.c
> >>> index e2bd2e999a8e..7f2507be0cf0 100644
> >>> --- a/drivers/usb/host/xhci-ring.c
> >>> +++ b/drivers/usb/host/xhci-ring.c
> >>> @@ -532,6 +532,7 @@ static void reset_ep(struct usb_device *udev, int=
 ep_index)
> >>>     event =3D xhci_wait_for_event(ctrl, TRB_COMPLETION);
> >>>     if (!event)
> >>>             return;
> >>> +   field =3D le32_to_cpu(event->trans_event.flags);
> >>>     BUG_ON(TRB_TO_SLOT_ID(field) !=3D udev->slot_id);
> >>>     xhci_acknowledge_event(ctrl);
> >>
> >> Please squash, and add
> >>
> >> Reviewed-by: Marek Vasut <marex@denx.de>
> >>
> >> Also, +CC Minda,
> >>
> >> there has been a similar fix to this one but with much more informatio=
n
> >> about the failure, see:
> >>
> >> [PATCH v1] usb: xhci: Check return value of wait for TRB_TRANSFER even=
t
> >>
> >> I think it would be useful to somehow include that information, so it
> >> wouldn't be lost.
> >
> > The root cause for *that* failure is what I fix in patch #5. From that
> > thread:
> >
> >> scanning bus xhci_pci for devices... WARN halted endpoint, queueing
> > URB anyway.
> >
> > Without #5 and without #1, that situation then leads to fireworks.
> >
> > A bunch of things are broken, which is why this is a series and not a
> > single patch. I have more fixes to timeout handling, mass storage, etc.
> > coming up after this. I fixed most of this in one long day of trying
> > random USB devices, so it's not so much subtle super specific problems =
I
> > could document the crashes for as just wide-ranging problems in the
> > u-boot USB stack. None of this is particularly hard to repro if you jus=
t
> > try a bunch of normal consumer USB devices, including things like USB
> > HDDs which take time to spin-up leading to timeouts etc.
>
> I think majority of users I can think of use USB mass storage devices,
> like USB pen drives, not so much HDDs as far as I can tell.

We see a bunch of spinning rust users in Fedora, these sorts of
devices are used by a bunch of people that want to run up cheap home
NAS devices so from experience I'd say while not usual to be USB
sticks and some form of solid state storage, spinning disk isn't
unusual.

> > The crash dumps
> > aren't particularly useful, it's the subtleties of the xHCI interaction=
s
> > that are, but for that you need to add and enable a lot more debugging
> > (patch #8).
>
> The crash dumps are more for posterity, when someone searches for a
> problem they see. Search engines tend to pick those up and it might
> point those people in the right direction.
>
> Also, it is good to include information about what triggered the crash,
> e.g. which USB device on which hardware, in case this is needed in the
> future.
>
> > I think the main reason all this stuff is broken and we're finding out
> > now is that u-boot has traditionally been used in embedded devices with
> > fairly narrow use cases for USB
>
> Yes
>
> >, and now we're running it on
> > workstation-grade laptops and desktops and people are plugging in all
> > kinds of normal USB devices and expecting their bootloader not to freak
> > out with them (even though most of the time it doesn't need to talk to
> > them). It's really easy to run into this stuff when that's your use cas=
e.
>
> It is really appreciated to see people fix things like this stuff, thanks=
 !
