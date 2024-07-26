Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E83C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 17:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35A1C87C7E;
	Fri, 26 Jul 2024 19:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dh0BuVsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7395487B84; Fri, 26 Jul 2024 19:28:00 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DE5888363
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 19:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3db157d3bb9so712563b6e.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 10:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722014877; x=1722619677; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XMCMwKXaeQpYq00bRqIZV0BTlQhale32PQnMfZEWo7M=;
 b=Dh0BuVsjWh5JHhYi9YICED6S2fmHJcgsDiY9wn0jwaUQU7U5+k3ysH+o5+Isd6c4tv
 pKxhfIu6PZyM5Dv7bZT/cDautjb1VvzayLG7PB5lko9buzQ38fhCVn9/DlYpk821bdcl
 XRFgYlVyoey7Cz83imAnZyMaQAwc+NB8KY60A8AaNJjUy5ziNtAbptA9bKq6owTy8tg9
 MmGP0mh1/LNpZMfZW+qyHUi159zE7axp7okG3AjVol74rT4/j0gh0we5quVcB4ipfinx
 FoE7+0aywIx/+Hj4G6PygOVOudnqPkZ+E6vJDWV3hyJ3nOs3m20uKN3S+iEg/lqbWy3F
 XzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722014877; x=1722619677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XMCMwKXaeQpYq00bRqIZV0BTlQhale32PQnMfZEWo7M=;
 b=UzUC6oPDP3CTt2tSQVT0djGqIxNLTaezYlnzqFz3vYGICXbGaPctQA/O/qBgaY3V/x
 DNROelOkO6VGgiSb2RGkTx4qwOhILY33HYDs3ABIzaHw0/XdmLXDcAAPog0fPZVHZEaH
 lZAsg42XQae2+mqVE5N9gIJ1kbMqmJiqiJTaPhPm1NLrBDUP7iap0uwvu2OYTlNRYXdP
 vtC+m1fFKt0iLaj7LSLqTMyVsF4WQeDBgvrqZ1vWLNBqxLwJzCV70GDixU3Vgqv+t5zZ
 ihzZTM+N0LMhfguVs8c+c+K9pgxxW327awItB8m32uhJyIbhWvn0L9qeI8tbX0XoiItS
 /TcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxkOWR9i5+ylDFNVRhr1qaIsxbI4M5NjOyYSxyr61aU4xAHzL4ld0hZmkRwj9v5R4ySpbYs/YRkBJy0jD5oEwnHMcXzA==
X-Gm-Message-State: AOJu0YxIivqdO+AG49i43X+Wtf9IuCWimuoTiyeaHrhlrS8p9+Mni4yn
 H+90U08+unnFaeMy7FAy8885va8OPQWz5Kk9Eo+QABwD0o9aHhoUPNDe5lTdOKhqC7RN8i7764b
 RStdPLMJcrsgrdZZ51IfznLJwMKc=
X-Google-Smtp-Source: AGHT+IFIUpOzDI6j/0gLaa4l0cwijvRNLEwSdogtY7jEoFbpGqkKDu2MXRSAyG9bD5VlQrazvwvXUM3AqgsguepkDuI=
X-Received: by 2002:a05:6808:1387:b0:3d9:26d6:c70a with SMTP id
 5614622812f47-3db2358bbc7mr565195b6e.10.1722014876907; Fri, 26 Jul 2024
 10:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
 <CAPLW+4=xXM8m7y030kcxTBwgLfm_cud8HYrwF0k75=GOg==zAg@mail.gmail.com>
 <CANAwSgSw3ZkZBaVeAUoj6hCtGoydEmMEoLBaEkU4JW586M5TEA@mail.gmail.com>
 <20240627144205.GB38804@bill-the-cat>
 <CAPLW+4m6SjAmDxQFBJhQwmGP-DOOPXipEY8n6CuWk81ZFZRbeg@mail.gmail.com>
 <CAOf5uwmy0DkjmPW_Nb3iP-3jLfgmtV0toPhFPM7=Zsi9h6RMBw@mail.gmail.com>
 <CAPLW+4kOEin1SJA=vat4fB-R4Am+mFX0S9awr=R+bM3nfrUR+w@mail.gmail.com>
In-Reply-To: <CAPLW+4kOEin1SJA=vat4fB-R4Am+mFX0S9awr=R+bM3nfrUR+w@mail.gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Sat, 27 Jul 2024 02:27:45 +0900
Message-ID: <CALrBrZ2WRiEOgjOxWVtTF104-V=XH6Q8FRTu9j8yDvFf9tS_4Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/40] mmc: dw_mmc: Enable eMMC on E850-96 board
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Minkyu Kang <mk7.kang@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, Yang Xiwen <forbidden405@outlook.com>, 
 uboot-snps-arc@synopsys.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,


2024=EB=85=84 7=EC=9B=94 26=EC=9D=BC (=EA=B8=88) 05:58, Sam Protsenko <seme=
n.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On Thu, Jul 25, 2024 at 1:25=E2=80=AFPM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi all
> >
> > Il mar 9 lug 2024, 02:48 Sam Protsenko <semen.protsenko@linaro.org> ha
> scritto:
> >>
> >> On Thu, Jun 27, 2024 at 9:42=E2=80=AFAM Tom Rini <trini@konsulko.com> =
wrote:
> >> >
> >> > On Wed, Jun 26, 2024 at 10:12:12PM +0530, Anand Moon wrote:
> >> > > Hi Sam,
> >> > >
> >> > > On Wed, 19 Jun 2024 at 02:26, Sam Protsenko <
> semen.protsenko@linaro.org> wrote:
> >> > > >
> >> > > > If there are no new comments on this series, can you please appl=
y
> it?
> >> > > >
> >> > > > Thanks!
> >> > >
> >> > > Tested on Odroid XU4 and Odrroid U3 boards
> >> > >
> >> > > Please add my
> >> > >
> >> > > Reviewed-by: Anand Moon <linux.amoon@gmail.com>
> >> > > Tested-by: Anand Moon <linux.amoon@gmail.com>
> >> >
> >> > Thanks, Minkyu will you be able to pick these up (and other
> outstanding
> >> > patches) for a pull request to -next soon?
> >> >
> >>
> >> Hi Minkyu,
> >>
> >> Gentle nudge :) Could you please apply this series? I'm working on
> >> some other features requiring eMMC enabled, so it would be great to
> >> have it merged soon.


I'll check at next week.


> >
> >
> > I think that we should merge your clock patch. I will rethink my series
> and make a differente design but agree that 5 months are too much
> >
>
> Thanks, Michael! Please let me know if you need any help with further clk
> work.
>
> > Michael
> >>
> >>
> >> Thanks!
> >>
> >> > --
> >> > Tom


Thanks.
Minkyu Kang.
