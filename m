Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A943D0E6D3
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 09:07:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E302892DA;
	Mon, 21 Oct 2024 11:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BNHGieWs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 771A6892E8; Mon, 21 Oct 2024 11:07:57 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DA1C892D8
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 11:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fb501492ccso40652161fa.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 02:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729501674; x=1730106474; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhNl7Ul95kFNulThZu2aiumooJjViKRK5d4VZMIUj3s=;
 b=BNHGieWsChjW1W973XGK2c5bw2WEMa24H+L8B0uyXIo429s+M0+CUZE+2G8Noueq+V
 wGQrkOOTtNmmjjLixPN56yn4niA6Pa79RoGVJ1ipLa7yIzp+vXhS3PdXcrkwjr7lrBmV
 1goukJRngDHhsWnMyYdajmvNVdC6UyzI68PrU7I8DrIT/lOiJg2brLh3gB055VL0i4pZ
 dfFE1PqdDWnYhxNDwv4puq68cUmlKVhiam4UNkCzI2wid899JWhgQZOj4mTdZUKb1w4G
 aqVes4WrqSnBd7byDLRYEhv6iz2ypegizRxQEzt9tFimYw5hZq1vSZ4MLkAdmb3x2N7+
 DUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729501674; x=1730106474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BhNl7Ul95kFNulThZu2aiumooJjViKRK5d4VZMIUj3s=;
 b=mzLTOzeGB1JvzwRwqV1OCjMKDEySA4S8Rf5/I1VqvdAvP4B5Y1cud/3LV8Ferr1Tya
 2lM/apiuBC19NdWBcwJ+IGeAXDTtjj00WAqsOsgqquzbOOc/SaQfYs5U4h16TWz52LwV
 4XGUeJFf6VXN/OyHJQCy/7QXv+HEgVR/jQOrGB2t/JSK7kPl0e/q9DVQaTibmBCllgfc
 KYp17jrKca3UQQNSY/SsCPtzd62PlB4iOWrzPLkhVwmxkBR11Vc4uNmfdTa4hrMBxLYJ
 O0g5SLBG7fyH+VUp6Fq3ksd/CRDhV0H+8Vy7nPz7270qC/W5l1GjmqVUP7gGgKflOljN
 Q9yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgMMeEPcdLqgn32PYLzim/czoHNrwx9kTm9DcH+iwBThdgixvSNb0YBwh8kiCcB9GmVzyuHSk=@lists.denx.de
X-Gm-Message-State: AOJu0YyJdPhrXCUmGGhi7SehptDeYUa4HvCAMj578+e5AQD7XUKNYNOa
 56UfBv6Z0PoV32mmRd3e3w/CNYXvIkKxgd7Xho44r3VOf/16NZP5kvfKR4oAXDjZsxAXXiZOUlP
 G+79NsexEwJ2fKKRGoDQjf402hCM=
X-Google-Smtp-Source: AGHT+IE0ABPSXeaaeRmQuwCTqtyxtuqhmnEc3dQ/Bz0nIyk2xCEjQdi708jyZ79zVTblH8l1ZPtmEHJUh/0a4Nr3ozc=
X-Received: by 2002:a2e:a986:0:b0:2fb:61d9:d717 with SMTP id
 38308e7fff4ca-2fb82eb4d5amr47729991fa.26.1729501674140; Mon, 21 Oct 2024
 02:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20241018083806.30679-1-weijie.gao@mediatek.com>
 <CAFLszThr2dusigg9R_3ytoGXybzV6sjChDp+40L+K_Qeo=rNdw@mail.gmail.com>
In-Reply-To: <CAFLszThr2dusigg9R_3ytoGXybzV6sjChDp+40L+K_Qeo=rNdw@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Mon, 21 Oct 2024 02:07:43 -0700
Message-ID: <CANV2PTM7t7SgmQaFz6KBwTpJG8_PEbXqfMu=BpTuS=2F5XqB9A@mail.gmail.com>
Subject: Re: [PATCH] menu: fix the logic checking whether ESC key is pressed
To: Simon Glass <sjg@chromium.org>
Cc: Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Daniel Golle <daniel@makrotopia.org>, John Crispin <john@phrozen.org>
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

Hi,

On Fri, Oct 18, 2024 at 8:03=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Weijie,
>
> On Fri, 18 Oct 2024 at 02:38, Weijie Gao <weijie.gao@mediatek.com> wrote:
> >
> > It's observed that the bootmenu on a serial console sometimes
> > incorrectly quitted with superfluous characters filled to command
> > line input:
> >
> > >  *** U-Boot Boot Menu ***
> > >
> > >      1. Startup system (Default)
> > >      2. Upgrade firmware
> > >      3. Upgrade ATF BL2
> > >      4. Upgrade ATF FIP
> > >      5. Load image
> > >      0. U-Boot console
> > >
> > >
> > >  Press UP/DOWN to move, ENTER to select, ESC to quit
> > >MT7988> [B
> >
> > Analysis shows it was caused by the wrong logic of bootmenu_loop:
> >
> > At first the bootmenu_loop received the first ESC char correctly.
> >
> > However, during the second call to bootmenu_loop, there's no data
> > in the UART Rx FIFO. Due to the low baudrate, the second char of
> > the down array key sequence hasn't be fully received.
> >
> > But bootmenu_loop just did a mdelay(10), and then treated it as a
> > single ESC key press event. It didn't even try tstc() again after
> > the 10ms timeout.
> >
> > This patch fixes this issue by letting bootmenu_loop check tstc()
> > twice.
> >
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > ---
> >  common/menu.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/common/menu.c b/common/menu.c
> > index 5fd705039fc..bd2ac3e0ed9 100644
> > --- a/common/menu.c
> > +++ b/common/menu.c
> > @@ -566,7 +566,7 @@ enum bootmenu_key bootmenu_loop(struct bootmenu_dat=
a *menu,
> >                                 struct cli_ch_state *cch)
> >  {
> >         enum bootmenu_key key;
> > -       int c;
> > +       int c, errchar =3D 0;
> >         int choice;
> >
> >         c =3D cli_ch_process(cch, 0);
> > @@ -574,7 +574,8 @@ enum bootmenu_key bootmenu_loop(struct bootmenu_dat=
a *menu,
> >                 while (!c && !tstc()) {
> >                         schedule();
> >                         mdelay(10);
> > -                       c =3D cli_ch_process(cch, -ETIMEDOUT);
> > +                       c =3D cli_ch_process(cch, errchar);
> > +                       errchar =3D -ETIMEDOUT;
> >                 }
> >                 if (!c) {
> >                         c =3D getchar();
> > --
> > 2.34.1
> >
>
> This looks reasonable from a first glance, but please can you rebase
> on -master ?
>
> Regards,
> Simon

Does this affect eficonfig menu ? I was having some intermittent
trouble about the eficonfig menu quitting suddenly before this patch.
With this fix applied it's no worse but maybe better, I tried for some
minutes to reproduce the previous behaviour and was not able to make
the glitch happen.

Tested-By: E Shattow <lucent@gmail.com>
