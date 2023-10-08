Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC634E95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 18:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0A1086563;
	Sun,  8 Oct 2023 20:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EKSjb2OW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03C468662F; Sun,  8 Oct 2023 20:02:39 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB97586552
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 20:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53639fb0ba4so6566338a12.0
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696788156; x=1697392956; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eqgl4Ajgiz8XWvOKhNTPlFX0EgGTv2TikbQNcdrAzs=;
 b=EKSjb2OWVrPYMbwLVBCHGuDj10gCTr0kV8qXWTmQJ7XVUwvKxKV4X8KwhDCtOQDLLi
 WH/KWvS+uxVwgyu4YO6GS+fooWWtOBN7U1dIHacHYHd+Yz5qY9n6UtHcDArlkjS5+fry
 bYpopyvGWesVWDT6SYRMofR/qV8OitEC6W4NQexa3jfexR7oCIOaFukeKQGFfg6AvLwN
 nAsbRHXnDYwOswWeik5z+IaBy74P/LdGk5dS3GL9Arc71pv8zy0rr/M+3p75mi7MWK3V
 0+u4WCrGDSZ2M2i/Wobm7aEiQgpgpSHAtlC0X1RprO6asB2HNjjRfv8YKMT8RzrVyFuh
 6gMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696788156; x=1697392956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5eqgl4Ajgiz8XWvOKhNTPlFX0EgGTv2TikbQNcdrAzs=;
 b=R3PCb2OTloz3r/HQmclzcnVo/G8wUOAi1cfpwqlZDVgYww1mMJluoaYKB+JY3AzpOE
 iaRIyL+MdPFfEiUJrwh9U7cv2I6N+TQaUK+qJMNm3QISu6VBYQckJSrjod58qoLp8o7M
 xk7xQidif2/Q8H8eoZQD0oNaWxgXaIUGrk/m6uQjXrdJP/TooEN6ZJegrJtWAzTaKlZD
 fQmJhmToz7HXec5FcWLBfMG+INpNwj3D8pnuj+w5Xl0s+0AroaCWaqui14AgHB3gGIKD
 NDpSLsLnNbYwfVNnZmXgJ5uFVsrEIBxbtCUd4WJA4sUQPu7+VrsGmE1wbh5CTWZM6ICK
 MZ8g==
X-Gm-Message-State: AOJu0YxlGUVwO1Nf6IFuu18nFmsQ74w0qM2tw/ADoVaigL2+BT4HZMQN
 cSgvHyw+8hAnKsa2YbeVdBGX6dgwn6JWrD5ah60=
X-Google-Smtp-Source: AGHT+IG95ep8XBX4jYUQ9Cdr7S489dYhcGXQNsdQlj07uPMyKJEy5CMnaJJsRf+wADX9TEM8mAVRwyi1LEntz3zgFSM=
X-Received: by 2002:a05:6402:785:b0:523:ae0a:a446 with SMTP id
 d5-20020a056402078500b00523ae0aa446mr13950072edy.24.1696788155947; Sun, 08
 Oct 2023 11:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230727215433.578830-1-sjg@chromium.org>
 <CALeDE9MADwXU_gExvQZJnxKYDk1C1YLiZyL1jhe9-Um1hQA=6Q@mail.gmail.com>
 <CAPnjgZ2L7Rfbuj6aN3oQqOPPxywraDaL1AM6xyQiNB8T6PFPGg@mail.gmail.com>
In-Reply-To: <CAPnjgZ2L7Rfbuj6aN3oQqOPPxywraDaL1AM6xyQiNB8T6PFPGg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 8 Oct 2023 19:02:25 +0100
Message-ID: <CALeDE9OJpP8P-8Wk=Jt=Ju2Q8MQoLVDOjvY8HBMF6JZP3pitVg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] rpi: Convert to standard boot
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Matthias Brugger <mbrugger@suse.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
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

> > So with more testing of 2023.10 in Fedora we found a regression where
> > the display dies when the vc4 module loads in the kernel. With further
> > debug it was found that it was due to the new U-Boot and with
> > bisecting it myself I have found this series is the cause of the
> > regression.
> >
> > The testing I have done is with recent RPi firmware, U-Boot 2023.10
> > and kernel 6.5.x, but also seen with 6.4.x, with a minimal text only
> > image. I can also reproduce it by using the F-38 GA image, no updates
> > and purely just changing the U-Boot component. I've done my testing on
> > the RPi4.
> >
> > Let me know if you need more information, I believe you have a RPi you
> > can test with.
>
> Thanks for the report. Which rpi should I test with? I take it that
> vc4 is a kernel module? Do you have the error message?

Well I've been testing on the RPi4 (as I mentioned above), there's no
direct error message that's directly linked but the screen goes blank
and turns off, even on a text only install, and yes, on the rpi4 the
vc4 kernel module deals with driving the HDMI and other output
interfaces (whereas the v3d is the driver for the render unit), and on
rpi3 and older vc4 also runs the 3D render module too.

> Regards,
> Simon
>
>
> >
> > Regards,
> > Peter
> >
> > On Thu, Jul 27, 2023 at 10:54=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > >
> > > This series moves Raspberry Pi boards over to use standard boot.
> > >
> > > It also moves rpi over to use a text-based environment. Unfortunately=
 it
> > > is not possible to empty the header file due to several CFG options.
> > >
> > > Fix the repeated "and and" while we are here.
> > >
> > > Note that this reduces rodata size by about 4.5KB. We could get anoth=
er
> > >
> > > for a total image-size saving of about 15KB. This is mostly because
> > > HUSH_PARSER is not enabled anymore and the environment shrinks down b=
y
> > > about 3.5K. Hush is not actually needed anymore, since standard boot =
does
> > > not use it. Also CMD_SYSBOOT is dropped since standard boot calls the
> > > pxe_utils code directly in that case.
> > >
> > > Changes in v3:
> > > - Rebase to -master
> > >
> > > Changes in v2:
> > > - Rebase to -next
> > > - Add new patch to disable DISTRO_DEFAULTS
> > >
> > > Simon Glass (3):
> > >   arm: rpi: Switch to standard boot
> > >   rpi: Disable DISTRO_DEFAULTS
> > >   arm: rpi: Switch to a text environment
> > >
> > >  board/raspberrypi/rpi/rpi.env  |  77 +++++++++++++++++++
> > >  configs/rpi_0_w_defconfig      |   2 +-
> > >  configs/rpi_2_defconfig        |   2 +-
> > >  configs/rpi_3_32b_defconfig    |   2 +-
> > >  configs/rpi_3_b_plus_defconfig |   2 +-
> > >  configs/rpi_3_defconfig        |   2 +-
> > >  configs/rpi_4_32b_defconfig    |   2 +-
> > >  configs/rpi_4_defconfig        |   2 +-
> > >  configs/rpi_arm64_defconfig    |   2 +-
> > >  configs/rpi_defconfig          |   2 +-
> > >  include/configs/rpi.h          | 134 -------------------------------=
--
> > >  11 files changed, 86 insertions(+), 143 deletions(-)
> > >  create mode 100644 board/raspberrypi/rpi/rpi.env
> > >
> > > --
> > > 2.41.0.487.g6d72f3e995-goog
> > >
