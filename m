Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DDACD80A2
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 10:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4359886E01;
	Tue, 10 Oct 2023 12:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KiGdAVkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65AD786C67; Tue, 10 Oct 2023 12:39:49 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8844986DCE
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 12:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5333fb34be3so9299662a12.1
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 03:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696934386; x=1697539186; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1m/QEQT2Gqm4DonaeDh+i5i7VOWdG0mhgmIYOJ1iYK4=;
 b=KiGdAVkQmvlUBklZIG1MtTKaCMKwKGWwKP8tVnlZOBS3V/SeYAtg+d7VfZFMAGUYm1
 XcX4QrExZkoPx0RFFAv7EGLqQ3BfCuVT9rMnNF6wmHDOimgS5AeGGTZV1qVcp5lB1V1g
 muG0PDzHTD+nA6PG13YOF9bh1Fqnl9TislOij00xb0baG8Bs6WNCFVMXL0wc4wMvERH1
 eWALvTJLw7cz+Jiq+cvhbmQXRhKJ3TK/VtdX4oBcfa4RkSCfmjxMHoXklH11cWPhwJN8
 QmfbvJvXZH4d6v17rYEerFUYjbzLjdduWzi+9E3dZ6dxvLpOIQFtMNxN6h0B2Y9XlGV5
 JwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696934386; x=1697539186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1m/QEQT2Gqm4DonaeDh+i5i7VOWdG0mhgmIYOJ1iYK4=;
 b=ryhBXRX9t8P2/+qKiN4Ucou98ktnuG1LohmzAOPqTligamOWghFwc6dAmLIVlRXCna
 /zgvir9ZxI/Dlluqp+Q0+mx6fWsuvfK/0Ajk/eY0x/ezM+yPVu8oWq6YsxxSJbhXZqRh
 N/Go3zUop020ZkgWykkc+T32HKEImN9WuUZ2y05ZbkegK4bqr+vfS1KbbM18HHSHcuuJ
 +3HNxP36sbSYwZeamQjci6pzS4FrJXv0EInyiWb4gnJFqts5Hi/zkdzJoiM7irK3YiCV
 5bFKoGDI931QX7tEdvgxi7F/a2OqyFERCoH2LHUnzZU0nq6RVv5PBFxNprHMCdouyUY6
 tx3g==
X-Gm-Message-State: AOJu0Yz8V7IEEsncVliodQCfq0oAt5ORP/iQkxucXb0AiRkdjRZtLb1w
 jPyrZ1562lMo3z7dnv5Q5L3dcZJgGMQGO50Qouw=
X-Google-Smtp-Source: AGHT+IF9KdheQXiZkmEK+SkOhAUV5j1DyUQyfGxwLY2yFlKuFX/JSFzrwpdpkyrfquKBwUAYhj3gcQehVXEto/kgaCI=
X-Received: by 2002:aa7:cd42:0:b0:530:9e58:db59 with SMTP id
 v2-20020aa7cd42000000b005309e58db59mr16328526edw.3.1696934386172; Tue, 10 Oct
 2023 03:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231007155535.1699567-1-benwolsieffer@gmail.com>
 <CALeDE9MX8FiayfjY=Wv2y3n9DBkTAqQsqnNjDkCXDDUeCSMLag@mail.gmail.com>
 <ZSMuDsxG8M6opMFy@Dell-Inspiron-15>
In-Reply-To: <ZSMuDsxG8M6opMFy@Dell-Inspiron-15>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 10 Oct 2023 11:39:34 +0100
Message-ID: <CALeDE9NgsZpgkNXPGWFNoV+ZDe=4LAirD4LYVAYZUAEdnx443w@mail.gmail.com>
Subject: Re: [PATCH] arm: rpi: explicitly enumerate mmc boot targets
To: Ben Wolsieffer <benwolsieffer@gmail.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>
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

On Sun, Oct 8, 2023 at 11:32=E2=80=AFPM Ben Wolsieffer <benwolsieffer@gmail=
.com> wrote:
>
> Hi Peter,
>
> On Sun, Oct 08, 2023 at 07:21:57PM +0100, Peter Robinson wrote:
> > On Sat, Oct 7, 2023 at 4:55=E2=80=AFPM Ben Wolsieffer <benwolsieffer@gm=
ail.com> wrote:
> > >
> > > Using the unqualified "mmc" boot target causes the Raspberry Pi 4 to
> > > fail to boot. c771e5b explains this approach as follows:
> > >
> > > > We don't need to specify the mmc devices individually, since they a=
re
> > > > used in order from 0 to 2, and standard boot uses that order anyway=
.
> > >
> > > In practice, U-Boot first attempts to boot from the unconnected mmc1
> > > interface, and, when this fails, moves on to attempt the USB and netw=
ork
> > > boot targets rather than trying mmc0.
> >
> > Really? It shouldn't be enumerating it if it's not defined in device
> > tree, I've not seen this in my testing.
>
> It does seem odd, but U-Boot definitely sees two MMC interfaces:
>
> U-Boot> mmc list
> mmcnr@7e300000: 1
> mmc@7e340000: 0 (SD)

The WiFi interface is connected by SDHCI/SDIO which AFAICT is the
first interface.

> >
> > > This patch explicitly enumerates the mmc interfaces, causing each to =
be
> > > attempted in turn. This matches what is done on other boards, and all=
ows
> > > the system to boot successfully.
> > >
> > > Fixes: c771e5b8c2 ("arm: rpi: Switch to standard boot")
> > > Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
> > > ---
> > >  board/raspberrypi/rpi/rpi.env | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rp=
i.env
> > > index 30228285ed..02210b97b5 100644
> > > --- a/board/raspberrypi/rpi/rpi.env
> > > +++ b/board/raspberrypi/rpi/rpi.env
> > > @@ -74,4 +74,4 @@ pxefile_addr_r=3D0x02500000
> > >  fdt_addr_r=3D0x02600000
> > >  ramdisk_addr_r=3D0x02700000
> > >
> > > -boot_targets=3Dmmc usb pxe dhcp
> > > +boot_targets=3Dmmc0 mmc1 mmc2 usb pxe dhcp
> >
> > Why are you adding mmc1 and mmc2 if they're not connected?
>
> I was trying to match the old distro boot behavior, which had three MMC
> interfaces listed.
