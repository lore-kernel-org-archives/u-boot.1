Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B936AC07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 05:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B932886F85;
	Wed, 15 Nov 2023 06:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iFamDfyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D516487040; Wed, 15 Nov 2023 06:57:22 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B5C86F18
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 06:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-509c61e0cf4so7798229e87.2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 21:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700027840; x=1700632640; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4H9pUOx4DDkWgvP0nap9moKZbKnaoTiXu4ypwVx0aMw=;
 b=iFamDfyNfgyvxV8wR2xAZPaAuxS2lHCCcEv9LMGxhYmMDzVtjYbXMhvCLCE4CY8Ok3
 TavxoMwQiWgjDHgS2G1vkk02NZj84zn7uGBrt6H6cao5rROiQWw1pTN7lkMmE0CK74Lm
 Nvcg8VI2nEuFlrBCs0UA3oDf6kdpOQOXXXCfyCTZiuDuBu5rJbcztx914Y/TQa6fp54t
 oWpCt1tW0aVYUfjsZBA103v/iRmcUfZUWxt9dmpAJsys9XEVTkctLnbfkjV3VCOflsX0
 xiUdCVYoBeweEtAIak8UGYsI5MMeXICTk2gb49oubIxRZz0OC01vuGlT9a9wGg9Biz6n
 owlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700027840; x=1700632640;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4H9pUOx4DDkWgvP0nap9moKZbKnaoTiXu4ypwVx0aMw=;
 b=XroLm2znR3l+72T7fmmQCMKNoOChiy8CAWtcJbWX7aPghc7IGE4BQghiEfPYN9hPvq
 TQvcEoe1V67aKRLQQtaxpc3uw53LtuDdtHQRGu3BQb2lCbTjX1I0NN6NlBgFyxnDi//y
 iFo2oUoW0HoC0/H7BHVDhEcGy0pGp4fgpydY8dE1LDp7AVvrx7MtimyZrXnH+x0GgWYI
 4ooZdwzJtAuFHApvC3d+Tx1cPNNQp4rnoNmJWc035sIf6BUSgZlfEkP5l2i2EfgI8Vr0
 A9W8sPhjHp3FD9DR7rYj51T86bShu4AObAGEVBhvT7mYNlwDFOrvZnqvgIMHWHNpiLE7
 Q1hw==
X-Gm-Message-State: AOJu0YwDNrH/B8wPfpNZ6JrZOqA/vgD7czKJoGBLNRbTeL2pHcFE0ZBV
 DqdSCYT6Tp9szK8W1UduVpW1BqCaYFsdIKTQvGo=
X-Google-Smtp-Source: AGHT+IH/Xva4GVu6i9w/OOWeRTlNLDpyxLoP0ZrK15utySWp2tG4W8+1XURVBs4fO6mtIfd8uJEbbmWU4Iu6nbxL4Z8=
X-Received: by 2002:ac2:434d:0:b0:508:26b2:7803 with SMTP id
 o13-20020ac2434d000000b0050826b27803mr7460176lfl.69.1700027839302; Tue, 14
 Nov 2023 21:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20231114085159.3739887-1-JJLIU0@nuvoton.com>
 <20231114162329.GV6601@bill-the-cat>
In-Reply-To: <20231114162329.GV6601@bill-the-cat>
From: Jim Liu <jim.t90615@gmail.com>
Date: Wed, 15 Nov 2023 13:57:08 +0800
Message-ID: <CAKUZ0+H3xU6WX3SjqUiSe0bBBA1=Kp=6h+bFrGEHK9_v+Z6sVQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fix/add npcm845 serial and board error
To: Tom Rini <trini@konsulko.com>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, YSCHU@nuvoton.com, 
 u-boot@lists.denx.de
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

Hi Tom

Thanks for your check.
These patches I have checked and tested on npcm845 evb.
The compile log and boot log is as blow:

https://drive.google.com/file/d/1v3PFArKiqpFc0l9i0fy1xj0AauKlKS0k/view?usp=
=3Dsharing


If you have any confusion or you can't see the log please let me know.

Best regards,
Jim

On Wed, Nov 15, 2023 at 12:23=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Tue, Nov 14, 2023 at 04:51:55PM +0800, Jim Liu wrote:
>
> > 1. Fix serial error and add bypass serial setting.
> > 2. Fix/Add dts node node.
> > 3. Add full function defconfig
> >
> > Jim Liu (4):
> >   arm: dts: npcm845-evb: fix/add node and aliases
> >   configs: arbel: Enable full functions
> >   serial: npcm: support skip uart clock setting
> >   board: nuvoton: update console environment variable
> >
> >  arch/arm/dts/nuvoton-common-npcm8xx.dtsi      | 11 ++-
> >  arch/arm/dts/nuvoton-npcm845-evb.dts          | 29 ++++++--
> >  arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi      |  2 +-
> >  board/nuvoton/arbel_evb/Kconfig               |  1 +
> >  board/nuvoton/arbel_evb/arbel_evb.c           |  7 ++
> >  board/nuvoton/common/Kconfig                  |  9 +++
> >  board/nuvoton/common/Makefile                 |  1 +
> >  board/nuvoton/common/uart.c                   | 71 +++++++++++++++++++
> >  board/nuvoton/common/uart.h                   | 11 +++
> >  board/nuvoton/poleg_evb/Kconfig               |  1 +
> >  board/nuvoton/poleg_evb/poleg_evb.c           |  8 +++
> >  configs/arbel_evb_defconfig                   | 16 ++++-
> >  drivers/serial/serial_npcm.c                  | 39 ++++++----
> >  include/dt-bindings/phy/nuvoton,npcm-usbphy.h | 14 ++++
> >  14 files changed, 194 insertions(+), 26 deletions(-)
> >  create mode 100644 board/nuvoton/common/Kconfig
> >  create mode 100644 board/nuvoton/common/Makefile
> >  create mode 100644 board/nuvoton/common/uart.c
> >  create mode 100644 board/nuvoton/common/uart.h
> >  create mode 100644 include/dt-bindings/phy/nuvoton,npcm-usbphy.h
>
> I just want to make sure now that you've given this series a compile and
> boot test on some platform, yes? Thanks.
>
> --
> Tom
