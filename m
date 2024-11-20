Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D6AD63936
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 12:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96D6A895D2;
	Wed, 20 Nov 2024 13:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e4enBXDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F592895BD; Wed, 20 Nov 2024 11:12:03 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B565288F6C
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6e394dea01fso4545217b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 02:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732097519; x=1732702319; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlBHOqa9Lp+qaLngfl68HTqyESfUl6jw9XMbW5XD0RM=;
 b=e4enBXDMFY+eQnG3VnjMWB4FGRnK0ehEFqrPsZqT2rgcSgTGYo7UXnwfUmoiHvkxPZ
 38zcM5RnHPfPD73K5S2TniupawL7tc668Vsrayr7pEmHJ9plkXqiiUVmjYkxWw14Hz8q
 +INbX5oh4mvOshodIfYplvzlxmAS4DOdVPwXqSTyZNz//BepSIIXZZo+PFe//PTQTDDo
 08FUfd+SvPBDMk05CQF/Wdp8sriyGETLepMwdJI3k6Qgae04gdsFwyTpj62iW9mFN/+u
 EyBPY6gbtW6sk6Of6EAI2OWCE1Vz8cpvcKCiNqr9gCR+0ean71wprm8PdP30eSgGgeJp
 /Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732097519; x=1732702319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SlBHOqa9Lp+qaLngfl68HTqyESfUl6jw9XMbW5XD0RM=;
 b=TvK/48p3sP4hVbSdB2gf8A4HDSkuM5+MGOXIjBD0Pwc8Ec8fC0+QGMxB1XdhmrH0IR
 /6+8/fYH33fG6qFSqs8PMjrmmMGnf/zSlh3V0pl6dkX0jS1h+btHrVSwbE1YP6spTdhB
 JyyuuUy/UK9qkqVPD/+gERGd8BHu5RjRs7DK8P9bC4gaae1HAKtKsSrrtYRkS/FBFc0Q
 Tctkp1Mf10wowY/GpzyRepSTrjNmLT15orTLdLrLNmNdIuBc1wSb5g7YgGE6GFAYZ0gL
 AWUvxYY7G3s9N6qKa29onEH4fCQ3QT2Zq4sGN77iXm7Q6usXX1IFFuF03gO4SbSYLLc3
 KDFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6FOM6j7Z1sBBywaFGBlYsMvaNYfjbxCZMzlcOYRG/23OqbQArNCO78qRjbDnDByW8xTlk25o=@lists.denx.de
X-Gm-Message-State: AOJu0YxBsTCZEiNz8pP/sOBaUz46hB4r+27CU5BoI9yY8QP888V4t8Yk
 2oPM+JT0QP7fvmuyhx3VzVXABHHro94mLy8gcW57nTkfnJIu73GfUyUSJOrKvjXzXfhgREA/4Di
 DWmqqA/PhwyNusqOxh5WSid7E62g=
X-Gm-Gg: ASbGncvD89FkeTdO6O56M0VHZMrUKJyZSmP4H2nZaAJoryU7S0uDt7GeLrxeA9BPALx
 AYuAbVwrOKmJPlQiWSVmsj8iiF+8aUN8=
X-Google-Smtp-Source: AGHT+IH26z7fG+8obj10DcfpyipzKYW8qz5Np1mrff/wrSGugE6QWANE3loH1xQoUCNc6UD/+s2LiwsMPzMu01DLJq4=
X-Received: by 2002:a05:690c:63c8:b0:6ea:881b:b534 with SMTP id
 00721157ae682-6eebd0f1f81mr8378867b3.1.1732097519598; Wed, 20 Nov 2024
 02:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20241119222837.27550-1-l.rubusch@gmail.com>
 <20241119222837.27550-3-l.rubusch@gmail.com>
 <20241120-employer-haunt-ff43822eb5f3@thorsis.com>
In-Reply-To: <20241120-employer-haunt-ff43822eb5f3@thorsis.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 20 Nov 2024 11:11:23 +0100
Message-ID: <CAFXKEHaHofdP8ec4En1Our2a=mhewhxN+q0KxDs9sA6c+wcW-A@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] doc: develop: Fix typos and wording in gdb.rst
To: Lothar Rubusch <l.rubusch@gmail.com>, sjg@chromium.org, trini@konsulko.com,
 alpernebiyasak@gmail.com, xypron.glpk@gmx.de, mkorpershoek@baylibre.com, 
 dario.binacchi@amarulasolutions.com, pbrobinson@gmail.com, n-francis@ti.com, 
 afd@ti.com, al.kochet@gmail.com, u-boot@lists.denx.de
Cc: ada@thorsis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 20 Nov 2024 13:56:12 +0100
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

Hi, thank you all! This is outstanding, such a fast feedback! As I
also just ran a tool over the texts, adjusted formatting and
reverted/accepted some changes manually to my knowledge (I'm not a
native speaker). Please, could you clarify the following?

On Wed, Nov 20, 2024 at 8:15=E2=80=AFAM Alexander Dahl <ada@thorsis.com> wr=
ote:
>
> Hello Lothar,
>
> Am Tue, Nov 19, 2024 at 10:28:36PM +0000 schrieb Lothar Rubusch:
> > Fix some typos and duplicate words in gdb.rst.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  doc/develop/gdb.rst | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/doc/develop/gdb.rst b/doc/develop/gdb.rst
> > index 4e359c7f22..dc38435227 100644
> > --- a/doc/develop/gdb.rst
> > +++ b/doc/develop/gdb.rst
> > @@ -8,12 +8,12 @@ Using a JTAG adapter it is possible to debug a runnin=
g U-Boot with GDB.
> >  A common way is to connect a debug adapter to the JTAG connector of yo=
ur
> >  board, run a GDB server, connect GDB to the GDB server, and use GDB as=
 usual.
> >
> > -Similarly QEMU can provide a GDB server.
> > +Similarly, QEMU can provide a GDB server.
> >
> >  Preparing build
> >  ---------------
> >
> > -Building U-Boot with with reduced optimization (-Og) and without link =
time
> > +Building U-Boot with reduced optimization (-Og) and without link time
>
> ack
>
> >  optimization is recommended for easier debugging::
> >
> >      CONFIG_CC_OPTIMIZE_FOR_DEBUG=3Dy
> > @@ -24,8 +24,8 @@ Otherwise build, install, and run U-Boot as usual.
> >  Using OpenOCD as GDB server
> >  ---------------------------
> >
> > -`OpenOCD <https://openocd.org/>`_ is an open source tool supporting ha=
rdware
> > -debug probes, and providing a GDB server. It is readily available in m=
ajor Linux
> > +`OpenOCD <https://openocd.org/>`_ is an open-source tool supporting ha=
rdware
> > +debug probes and provide a GDB server. It is readily available in majo=
r Linux
>
> NACK.  It would read "OpenOCD is a tool supporting x and provide y"
> now.  This is most probably wrong?

I'm not sure if I got the point. If you can't find the time to answer,
I'll simply revert this entire change and leave it as is, no prob.
So, change 1) is "open source" to "open-source"; change 2) is a
removal of the comma; and change 3) "providing" -> "provide". Do I
understand you correctly, change 1) could be ok, where change 2) is to
be left as is, and also change 3) has to be as is?

> >  distributions or you can build it from source.
> >
> >  Here is example of starting OpenOCD on Debian using a J-Link adapter a=
nd a
> > @@ -124,7 +124,7 @@ with the command *bdinfo*:
> >      Early malloc usage: cd8 / 2000
> >
> >  Look out for the line starting with *relocaddr* which has the address
> > -you need, ``0x27f7a000`` in this case.
> > +You need, ``0x27f7a000`` in this case.
>
> NACK.  These are not two sentences but one, containing "the address you
> need".  Splitting that makes no sense.

Agree. This was already meantioned.
