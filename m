Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836F0C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 23:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE47E8129F;
	Tue, 22 Apr 2025 01:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R26jH3HH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 419A5812BC; Tue, 22 Apr 2025 01:30:14 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A7780F03
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 01:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22423adf751so45205945ad.2
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 16:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745278210; x=1745883010; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dRFf6f5lyxafxvXVB1O85/cnq2eVyNFz3uozsK/c67U=;
 b=R26jH3HHmqKnXzhOYXRAtW0gY5OdIo6zAUUF6txaZqaGYJTeFu20k3WXFH8yTJWqeW
 UoisGgo0+2RcR7aP9GX1+oTx9qca2D8ieCfvRW5hYo8iwcv8AaFQ87E8Bxrsw9QrrVlu
 Ivx2rrHc6glo3yED3b/56FdjDNiuhgTq8tKGTSip3DkyMpAsUNxwVxV1CSqJ2bT0YZbZ
 J3PgNONQzrhiJw3D+TcyrsaNe0XnGp/a49IfvxeaTXI0ESeD8VHKU2hgKjYPtj30dvtk
 1FwKZqqlHL4Xv/lvegx3eDE/pD85WwlfRVqsw/q4jRM3vdICSRHe4a1hOBu424JO11+l
 nQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745278210; x=1745883010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dRFf6f5lyxafxvXVB1O85/cnq2eVyNFz3uozsK/c67U=;
 b=ZwhkbpwyrCNe+2zNV4d36SAVXBsibXpDP4dtp0npLOkQBMuncrS/8jaX0U1nvls3Vq
 5winySS8n2dvBW2QeZAAQbdsZzADY3QmUaPX+9AN14UpPvvh747zAajtkCrTF6uCL76T
 4DuizP9iAlF0we4oYa50Xioi7vxMHqEelUyq/hbINAuygfbk8BpP0KFm+KIPpxlGiuc+
 b2Lher2Ct59/36lvODi+EypSZSUUPKtug/Q0Rs5FjUF8RyEoztToWXW4LXBMlf5FG/X2
 d1doCMHVOdtfboiKnmyF9ijh43VZT+ol9/JF9fqHsETqSPaGxfCCyP9bgK2Eth1FtKnM
 vaOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQAi1U+y9bNVjnZssEynkSME156s5yD4XmnivcfuJa0+IxYJ5IEVN1qDWBbhIw2jg7BjGm0pQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyFWGgvTQuvOAFpp3F9n0V4GAGdiRvknsL3b+MAHztDhY6pZtjH
 XrEyKl4YTI8W+G7q8X+rgJwmSQ6PnZkEaQWKrKtEMCnKAU324fjKfZy2SwdyOaPaa9tAoD2jthP
 74+9UMlewt/bwbMDRrM6NttZVH/UT/Q==
X-Gm-Gg: ASbGncufIJ2HEUqZvz8a6s51vHwNj40bhG+uMrvtB2rOSBv336MJN1BHi/sKUBWCLCu
 f3xGBIc2BkZsXBKYlksRr5aYcxex5n07hbNknH7L0r30WAu1YWGxL
X-Google-Smtp-Source: AGHT+IE5gOdODRePVtJ0PYKZHIZz5x2hrBx7mMsX088jcmvHjJMzP2Qk1qRmuqSUeOUplG3UMqlLjGAgzB3pBbbWy9c=
X-Received: by 2002:a17:902:e80f:b0:220:eade:d77e with SMTP id
 d9443c01a7336-22c5360c1a1mr208971975ad.40.1745278210439; Mon, 21 Apr 2025
 16:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
 <CAHCN7xLkDnLX5PHFNjXYn7AFXA5+S22aksgv62PpWpg80ZDQmA@mail.gmail.com>
 <d81112ad-017b-491a-b517-de828dd30c25@denx.de>
 <CAOMZO5CpQ-yv=8GhNv7=yjnA+uzzP9ZmB=P2d+xmhY1ktQJX9A@mail.gmail.com>
 <28b4bb24-4c56-4fe3-ae9b-db43c63290b1@denx.de>
In-Reply-To: <28b4bb24-4c56-4fe3-ae9b-db43c63290b1@denx.de>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 21 Apr 2025 18:29:58 -0500
X-Gm-Features: ATxdqUHMelPMSRjP7yRONnqbT4hSmgdte42GtfJrEu95WOammx-Ejj4cnu3QkKU
Message-ID: <CAHCN7x+RkN7XRo-YNLj1+Br--phDJHup5Xmnpj4b3OpvYEGohg@mail.gmail.com>
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, trini@konsulko.com, lukma@denx.de, 
 seanga2@gmail.com, francesco.dolcini@toradex.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Sun, Apr 20, 2025 at 2:20=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 4/20/25 3:07 AM, Fabio Estevam wrote:
> > On Sat, Apr 19, 2025 at 9:48=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> >
> >> Try something like this (also attached), maybe this needs to be made
> >> generic ?

Thanks for doing this.

> >
> > It works for me:
> >
> > Tested-by: Fabio Estevam <festevam@gmail.com>
>
> Can you send that as a fix ?
>
> And also, fix this patch up and drop the bogus second half of the commit
> message and do a V3.

Feel free to add:

Tested-by: Adam Ford <aford173@gmail.com> # imx8mp-beacon

adam
>
> Thanks
