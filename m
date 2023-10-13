Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89331CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:23:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED41A86EDA;
	Fri, 13 Oct 2023 18:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ksF8s1T8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAF0E86A4C; Fri, 13 Oct 2023 18:22:34 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF0BA86EF4
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53de8fc1ad8so3992122a12.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697214134; x=1697818934; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xyvpM8nkMQ8htUoVfPnABWOwQu/gpZPhhDtuXQjqcbg=;
 b=ksF8s1T8RetSZEw0zCoRoWZcn/um6skVy8ffkVQV8UZHwZ1KT8wk74lq8Zkh8e6z8V
 uYJaqcyNehUFK75HEjCSCeFxOO0AWiXs8761UrJqmq/wVrIakl+iaWMQk7SOHdxzaV5k
 8EN3IkN1HLnnuTRCoHcy2SehqfFpR7EXjjono30XpqbEj683vOSI5gAwU4ZnA5BCZZvR
 TlYIBfSvW2Kb80uog7EWj5r+zcum+6kyRcl0HDZK2kqlzgzKr+p55Y46RJrQB/KnBnW3
 wOgo7km2Y9BLxmpBcJU1ySlxr1jtBKBbg9wX9mNLF1yrFyldAXl6hD2WXDWFNR4cbKFx
 Tw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697214134; x=1697818934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xyvpM8nkMQ8htUoVfPnABWOwQu/gpZPhhDtuXQjqcbg=;
 b=lzzVa/+9ZbEWJjfb1mFv2DKiPQ0hx4yI6Jg06kUmaPXpWfCPFwS0NZgvxod27zEAnT
 vLKgeOxW2s6UmR0/sZeUSojAPjwDEnTTFN0UArCKdRyjWWDNLdDr3r/ntEJliOxzk87s
 tutTw09HvfVyI1rvPQ0IRLqcpwI9AAm4ItbPVG63x4gR3Nkh3XrOVhl2ILXqSiXG+oip
 gnkPWtcW31JW8f1k28JTbMY2XxRtJXkKGUUZWPo/FnJiJ3i+mDKSlrag12M5rQibb7qF
 HTS0WUp2Ca5zlupppwKTg/cKXWKkJQJqcMAFwmkfjON6Xj7elk8WX4oKXGqqIrJG3Hw8
 yzJw==
X-Gm-Message-State: AOJu0Yy+gEDp+K4iSAX5zzk+zNDj4cZEhYOsm9Yyb6RINHGde/GAfUja
 48tSIRHimJkUe8GYYlgdgnjpUMcWO05GiWq2F98=
X-Google-Smtp-Source: AGHT+IGGcaHDY01N3rwfcRQX+w9Kgbu1DqocZByn2DI6ofzjai51UitgdllpWIf0j8HvG3rl1GjnpP1IMwnoeFSUOZE=
X-Received: by 2002:a50:858d:0:b0:53b:9948:cc1f with SMTP id
 a13-20020a50858d000000b0053b9948cc1fmr13952447edh.12.1697214134051; Fri, 13
 Oct 2023 09:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CALeDE9N6nhRBwtYqJ=7nqYuCsmbw03j3RBXRQ8jYsD=OMY=gBw@mail.gmail.com>
 <VI1PR08MB28474179AFB989B308072B1E83CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CAPnjgZ3t9-trzoLGc7Jcj0=J0sQLQcHSGN3_Pf+3=iZ6=rPPqA@mail.gmail.com>
 <CALeDE9Oh9c+X5tG9RswuE=a=yQRW-j93q2oHJeOehLHHY2bSgw@mail.gmail.com>
In-Reply-To: <CALeDE9Oh9c+X5tG9RswuE=a=yQRW-j93q2oHJeOehLHHY2bSgw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 13 Oct 2023 17:22:03 +0100
Message-ID: <CALeDE9MnMuHSH4sgAC+Z2_+71QgToHt8e8rib3igxFDKV+DYWw@mail.gmail.com>
Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
To: Simon Glass <sjg@chromium.org>
Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Ivan Ivanov <ivan.ivanov@suse.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, Oct 13, 2023 at 5:09=E2=80=AFPM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> On Tue, Oct 10, 2023 at 3:58=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi,
> >
> > On Tue, 10 Oct 2023 at 04:39, Guillaume Gardet <Guillaume.Gardet@arm.co=
m> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Peter Robinson <pbrobinson@gmail.com>
> > > > Sent: Tuesday, October 10, 2023 12:22 PM
> > > > To: Guillaume Gardet <Guillaume.Gardet@arm.com>
> > > > Cc: mbrugger@suse.com; Ivan Ivanov <ivan.ivanov@suse.com>; Simon Gl=
ass
> > > > <sjg@chromium.org>; u-boot@lists.denx.de
> > > > Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
> > > >
> > > > On Tue, Oct 10, 2023 at 10:26=E2=80=AFAM Guillaume Gardet
> > > > <Guillaume.Gardet@arm.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > U-Boot 2023.10 does not boot from uSD on RPi4.
> > > > > This has been found on openSUSE Tumbleweed. The only diff we need=
 is:
> > > > >   -CONFIG_OF_EMBED=3Dy
> > > > >   +CONFIG_OF_BOARD=3Dy
> > > > > To use firmware provided Device Tree. But that should not affect =
the mmc
> > > > behavior too much, I think.
> > > >
> > > > I've been booting Fedora fine on a RPi4 BUT there's issues with the=
 display
> > > > turning off [1] when the accelerated display modules load
> > > > (vc4) as a result of this patch set. Can you confirm if that's the =
same problem
> > > > you're seeing?
> > >
> > > No, that's not my problem. My issue is grub was not loaded by u-boot =
from uSD.
> > > It seems more like Simon's problem: https://lists.denx.de/pipermail/u=
-boot/2023-October/533162.html
> > >
> > > @Simon, can you check if the patch below fixes your boot problem on R=
Pi4, please?
> >
> > This has been reported at least twice before. There is a fix [2] which =
is in my queue to apply.
>
> Looking at that patch it scans the first 3 devices, how does it handle
> non storage devices like SDIO WiFi modules? It shouldn't be trying to
> scan those.

And in the case of the RPi the other enabled SDHCI interface is the
WiFi, why would we even be trying to boot off a non storage interface,
something here just feels broken/wrong in general.

The patch does make it work with pure upstream, and I'm not sure why
the Fedora build boots it fine out of the box, but the patch just
feels like it's hacking around some other underlying problem with
bootstd, we didn't have this problem with the previous method and
trying to boot off non storage interfaces feels like it could cause
other problems.
