Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4867C369A1
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 09:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE79D82C34;
	Sat, 12 Apr 2025 11:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AcNSux7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F013782C7C; Sat, 12 Apr 2025 11:53:23 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0551A82C27
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 11:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso21128865e9.2
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 02:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744451601; x=1745056401; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=euKSA5tqWSPsr+B7YB3ljAv9Ob2yK7n1IoenHZVsDhY=;
 b=AcNSux7V/tyEofPoxIth/FTlkex8Ll0ShWuOnBEFzpqiZq5y0L21Vo6k78N4rUBBYP
 /+hh7veOa6WkYU3WJC1IbgqunbA46s1BQdxohDqN39DTGO3kyEQs7y9BwVjitHZi9m+0
 I8wGwC4XusRkrRvhy+zm9QmpBMEMpx4Zx2Hi/VMIVcRJyiYQmrATzmJKFcQ7aCGeEb8Z
 XE2OCqvvm27/o6F4Xl/5KeXS3AN9oy5qVFOeJl/xnuvmwv97IM687tMFuAH+ugJmUFTS
 Mx9csrHImCOIaBkz3bMi0nhdUEG3VNbUTIhGoAhH9vMtFQ5pd6Ci8y+mZgUOVa7wa2Ug
 sajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744451601; x=1745056401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=euKSA5tqWSPsr+B7YB3ljAv9Ob2yK7n1IoenHZVsDhY=;
 b=mozb91azweH8V+Fk20r1jWYmV52PamxiBSL3Me4m3QYfrI0t2FcWsqkbTNz7unAB//
 04hSCAMG5+Uu0KrDyhTn8VII4vBTW+GQErgVOlRLDRIsEniW0FsJZQmQfZ4OJCJWV0Bx
 ADkopbek8pOYdX4SumAeLmw/HJ7zPGSgxJ05rL+U00NWctApqw9DXbvTHKBLGVhwe9WV
 mXSkJ05uO+VLdoO2ihm748WTqeIpK2dKo0GLqobxAAIndmuM3A2qFh2emmpaiOTQefNw
 w0ok34A53A67THzMPNhOaUiM6oqRcbKM8y3e/odV4Oj9N/nBWjQg1JcyvyPA5azo13DY
 1L5A==
X-Gm-Message-State: AOJu0Yxn9Lm14kDvCHRjZwqu+8jVNjhRKBvR1iAhq/yoj86Z498MIIMm
 rSDpwcBJJy+9mfKhq3mfJCtQw9RsosKGSCk1BKG/Y+PeU8xVLm9MGQ7r7sNNl3WdlZkd+Kz8ni3
 o4mfimeWW4U4EGTPrm2tycdQTsdk=
X-Gm-Gg: ASbGncviAa/irNahXC7XOhMwOE0AQQQRCUH6Vx/kF9X8rapLV1DMx3pl9eMAd5j8mCq
 EsN7lqz9KG4TIwiudoOariW80YOa0Jo4i0/6z0jdXHrv/abDGGPzhSOlu6CDufwuADjuMf95DPp
 u6yL6REHzg2WWVTxygIxraKzI=
X-Google-Smtp-Source: AGHT+IGYJ6MJBNkJf6YbJoz2urMsrJ8qDSbMiG5NmaIfReAMZnsG4usioOGc6C3MdSfZ7bTfX8n+4SuoglwdXmiiJts=
X-Received: by 2002:a05:600c:24b:b0:43c:e2dd:98f3 with SMTP id
 5b1f17b1804b1-43f461f6f06mr7091115e9.21.1744451601164; Sat, 12 Apr 2025
 02:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250330192656.1280403-1-arturkow2000@gmail.com>
 <20250330212638.v2.1.Ib55fe26f355e42f7853676779e89e22356bd7230@changeid>
 <CAPVz0n3f4Op=7A1LTvKyTkeg_Y31wsfMj0SOgtor-TEgEHd96A@mail.gmail.com>
In-Reply-To: <CAPVz0n3f4Op=7A1LTvKyTkeg_Y31wsfMj0SOgtor-TEgEHd96A@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 12 Apr 2025 12:53:10 +0300
X-Gm-Features: ATxdqUHlO7A-IOPMBvzHwppvfjJ2Twa7stD_gBZrHewdq5vwACjpWOYESHxHIW4
Message-ID: <CAPVz0n09fkZYKN5D9YQ_zkm8fsB50eE=_Lszfg+u4=+9kBhHAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tegra: add funcmux for exposing UART over uSD slot
 on Tegra 20
To: Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.denx.de,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>
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

=D0=BF=D0=BD, 31 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 08:42 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D0=BD=D0=B4, 30 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 22:27 Ar=
tur Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > UART-A can be exposed through uSD, this was tested on Transformer T20
> > but should work on all Ventana-based boards.
> >
> > TX is exported on SDD pingroup corresponding to uSD CLK pin
> > RX is exported on SDB which is CMD pin in uSD slot
> >
> > Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
> > ---
> >
> > Changes in v2:
> > - fixed indentation of preprocessor directives
> >
> >  arch/arm/include/asm/arch-tegra20/funcmux.h | 1 +
> >  arch/arm/mach-tegra/board.c                 | 2 ++
> >  arch/arm/mach-tegra/tegra20/Kconfig         | 3 +++
> >  drivers/pinctrl/tegra/funcmux-tegra20.c     | 9 ++++++++-
> >  4 files changed, 14 insertions(+), 1 deletion(-)
> >
>
> Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>

Applied to u-boot-tegra/staging.
Thank you.
