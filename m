Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0124CCAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 14:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5691080325;
	Tue, 16 Sep 2025 16:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Au1Xo1/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E05F683253; Tue, 16 Sep 2025 16:38:02 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A8B9800D7
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 16:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3e9c5faa858so2822832f8f.3
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758033480; x=1758638280; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHgqnDTVym/kZgcoQFKFWfsEtbsSfuMmMnDBoO6rIh4=;
 b=Au1Xo1/DuVqvNcqdpOM0UFKOzZOjOqA0P2SBshlxZfWfK0XgbpJ4UXIB93M+vm3IRG
 5DMe+qSnCQ1QLLOAcGdEzv52g4++R+oNxNJw+/+jthgru0/W01WpPjcblCZZnQbQqpSH
 fFhExXFET+Ux/Kp3PxS0xDBytlT/vZ+eX5ccmQYnbLSD2hWuSQlWb9ltUAtFETH3ANf7
 DJKCF+OaNmFr/UphaM7VhIu/tLh7IvYhX1YKyF/veATF0NzcmgmGr0RaleYXeGU/gbKR
 tm1Ve/HtBB0onwWxqUWCyNfcSTE2OyN+XGQXIJZaEHTKftSeDrtnRA9mneJPCijZvIZP
 Ctaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758033480; x=1758638280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tHgqnDTVym/kZgcoQFKFWfsEtbsSfuMmMnDBoO6rIh4=;
 b=p+I3fzTbWpVY3fNnuJ1NVAOT6CfdOInaQ9AASnm2uPn5sfeXYo5YRIWigyOAFYUQoB
 h7iVtxsGo0U4PC2nSW3eg6wG3Q2UPzOv0jxuv8kwQNMex9R+kzeKE0UYb5htETgfZbGT
 Nh3dZ6FP1MY2wfRRROq5eScdrFwG7rrfOsjkQfLZxKrug/wkiq0MfyQ1OiX0LEHZDnwA
 qtABbqq3EU/xaQ2rQNt7z6BMtlX7jL3TRx63Ic9Y13HqCuZpvN5vpLakKhunpM/a1XbY
 jXRRLj/9ugiRfVeYZv/nK14XppiDiF+juU1n/2ooK1rlbvL50BNPp4xTUOq+YC7J7Ej5
 hu1g==
X-Gm-Message-State: AOJu0YyRkoGlbCxU+aGzY8MVxj25y46JlsdvsBtYuCg8Y1ayT6q+ZQut
 /lhmxcSkRkdH2oUeo8SdwxkEED5OYaR96mVsCZPZspHOz9ldCgwFSm/YJqkG+/bxaTQqrq4agTI
 M3LP6vR9lTAhAsnB0rLHdzP8f9DgYGQ0=
X-Gm-Gg: ASbGncsPm/BC2cAoh0g/3kr36X4gupq4wMcBq6g9wTq/EJC2wy3P9lHWYVzhp937eMe
 xnm8vutKCHYuBG2G3SfcC2tgoa2z1lyZWbyOay3l79gHdwLumHeyDwqQBta97bkBPzZTX5GSR38
 AAUS7ZIeU0GJzLwBF2uN7wR8T3Y45kN/Hp3d5lkzqr89fqxTPvO8djEdftEexM2nhlal8j7rYqn
 vzlpTPj
X-Google-Smtp-Source: AGHT+IFD5hyw/yKc1dx/I2gbWsUH77TdTQR7Ue4Z0XTi8AUEGeui4b1bf09LkNJqk57aeAYAj0F2ckOn/5uxTjUS3As=
X-Received: by 2002:a05:6000:22c5:b0:3ec:c50c:715b with SMTP id
 ffacd0b85a97d-3ecc50c7777mr1897139f8f.19.1758033479646; Tue, 16 Sep 2025
 07:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250915203827.GN124814@bill-the-cat>
 <CAPVz0n2tpEVrZ=1k9BPyg8h3Fa_P_J8VKoQFn0MZU0rOwVbstg@mail.gmail.com>
 <20250916143010.GS124814@bill-the-cat>
In-Reply-To: <20250916143010.GS124814@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 16 Sep 2025 17:37:47 +0300
X-Gm-Features: AS18NWCWK8NZFXGvKvHUHRAHh5SQwc84iWFJYG17_lsNXx6mJpJTGRpdS8thtGk
Message-ID: <CAPVz0n26poXVYQHHCUMnAJC2iexygxXaOO_yLhc_UaVwOE1M5A@mail.gmail.com>
Subject: Re: Continued need for ATAGS-based booting?
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dave Purdy <david.c.purdy@gmail.com>, 
 Ion Agorria <ion@agorria.com>, Jason Cooper <u-boot@lakedaemon.net>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Luka Perkov <luka@openwrt.org>, Luka Perkov <luka.perkov@sartura.hr>, 
 Michael Walle <michael@walle.cc>, Peter Geis <pgwipeout@gmail.com>,
 Phil Sutter <phil@nwl.cc>, 
 Stefan Roese <sr@denx.de>, Stephan Gerhold <stephan@gerhold.net>,
 Tony Dinh <mibodhi@gmail.com>, 
 Walter Schweizer <swwa@users.sourceforge.net>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
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

=D0=B2=D1=82, 16 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 17:30 Tom =
Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Sep 16, 2025 at 12:05:58PM +0300, Svyatoslav Ryhel wrote:
> > =D0=BF=D0=BD, 15 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 23:38 =
Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > As part of working on cleaning up documentation, I ended up seeing ju=
st
> > > how few boards still enable support for ATAGS-based OS booting. In fa=
ct,
> > > the list is:
> > > brcp150 brcp170 brcp1_1r brcp1_1r_switch brcp1_2r brsmarc2 chagall
> > > dockstar dreamplug ds109 ds116 ds414 endeavoru goflexhome grouper
> > > icnova-a20-swac iconnect ideapad-yoga-11 lschlv2 lsxhl mocha mot n1
> > > n2350 nsa310s nsa325 openrd_base openrd_client openrd_ultimate ouya
> > > picasso pogo_e02 pogo_v4 qc750 sheevaplug star stemmy surface-2
> > > surface-rt tegratab tf701t transformer_t20 transformer_t30 x3_t30
> > >
> > > And my question is, for you board maintainers, do you still need to
> > > actively support booting such old Linux kernels? Or can we disable th=
is
> > > support and then possibly be able to remove the underlying code as we=
ll.
> > > Thanks!
> > >
> > > --
> > > Tom
> >
> > Hello Tom!
> >
> > Maintainers of some boards in interest have agreed that support for
> > ATAGS-based OS booting can/should be removed from the boards in the
> > following list:
> > chagall endeavoru grouper ideapad-yoga-11 mocha mot n1 ouya picasso
> > qc750 star surface-2 surface-rt tegratab tf701t transformer_t20
> > transformer_t30 x3_t30
> >
> > Thank you for your support! Have a nice day.
>
> That's good. Are you going to submit a patch for the defconfigs or
> should I?
>

I can submit but that will not be too soon since I am quite occupied
with Linux kernel stuff right now. I'll try to cut some time for this
till the end of the week. Since there are still boards relying on
ATAGS I assume this change is not urgent.

> --
> Tom
