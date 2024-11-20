Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50FDD63935
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 12:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E5EF896E0;
	Wed, 20 Nov 2024 13:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U3UxBL1i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81FC589684; Wed, 20 Nov 2024 12:11:29 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 927F28901F
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 12:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6ea34be9b20so5630857b3.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 03:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732101085; x=1732705885; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PM7V7BcBpapndhEyc7qFXDJCWlV7dYELflraSMB2BEM=;
 b=U3UxBL1ioRnhivpcEluUbQ8/TdfVwd0jjw+QR8NbXYvY4PRs4Ka5lZaGDD4jLfOdmM
 +6/wpJpa+V/bs1s8o1EIfPLa1yWCM7ImuBcijb/PpvPo1JA5Ysd2v8teCjfz4K6Gu8M7
 qTCG2R0iNFvnqa3j15WjPIBay40WG4AcKzX97kkypwjzEbo7oYw0IR25tyieOlXfX7L/
 PxnoYsc2tWt4u4m+BQk17HwIUXjDm+pkND+S7txJQIPCbAyEIavGOqBKdeo/46xtAzhc
 51tjkTpKJlyqxwR81oRaand1++WHPhTdm8mW5JcGmBjibtmWbN8GLBoZI2EF5faC+V8+
 jkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732101085; x=1732705885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PM7V7BcBpapndhEyc7qFXDJCWlV7dYELflraSMB2BEM=;
 b=pg3rzWnT7TFFxM35biXfPGv08cwJbwj/tl3WRQwlOV/6Xug8fMk4cGyO5JCcnVIs6D
 Db2gK9azwdgIkmdge2BxLRc8I9DXG8a2POxDlqWtRzotcl+r9WkusyzF4GJkFMOJXqvw
 tcglz9XjqLYzzZGHGjjC5kUPiydyBlfUnPD9auK0/61Jtz//fA0DtV10j63ZsKGgmRor
 XTeCjF8DC6R7f970fShjlnUPH1n3visKRNjSXVOKrhQhA7nDPRx7yx0w8m2/oZVPDqxr
 3/x+ORbMbVnsMuKL+dbG3yOtFI7BBS7ChRD6PvOfoMoFFTE4V+9uCi1naBmlF/WjNGO/
 8x/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCIk7UWftBi+jP+E/A8vVqtJ9xgoDUrlR/31KB6thD3alhuHULJqWYIA7x3O5izmKC8xRDKo8=@lists.denx.de
X-Gm-Message-State: AOJu0YyGieljANlHT2YuSob+6/sRqpkRDQXp2YKjqFhP1yEeF3pBn2aE
 go+OK1kGKeOMhV4M/qjVvqMqNCbtELxz9ljJxuCq6bja7BESzxXgQtYpZ2/QxH3wl2COSXBAJbn
 6Yr03wMQDOfNoLzM2QpadO3/KfVg=
X-Gm-Gg: ASbGncvAMp1KiTU4M7XS3cGMGwH5RajyWcl8wd4ZJFiTs1LzNt7XnTjsSSVF76ShRDg
 TXGPcl23v14IniJlFcerdOf0jF5ELyNY=
X-Google-Smtp-Source: AGHT+IFo4kyzXNNgib04B9iyin8vdeszLrIcvfQImjIqWy0FTy/I7qU0lhE6RZKgNkofsVHR8f9wCKURNsOR60YAH0U=
X-Received: by 2002:a05:690c:6ac8:b0:6ee:b774:fff7 with SMTP id
 00721157ae682-6eebd2b0490mr9168697b3.10.1732101085393; Wed, 20 Nov 2024
 03:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20241119222837.27550-1-l.rubusch@gmail.com>
 <20241119222837.27550-3-l.rubusch@gmail.com>
 <20241120-employer-haunt-ff43822eb5f3@thorsis.com>
 <CAFXKEHaHofdP8ec4En1Our2a=mhewhxN+q0KxDs9sA6c+wcW-A@mail.gmail.com>
 <20241120-trustee-appealing-7c4a54657479@thorsis.com>
In-Reply-To: <20241120-trustee-appealing-7c4a54657479@thorsis.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 20 Nov 2024 12:10:49 +0100
Message-ID: <CAFXKEHYeOLsgOBhJ5xBV0gOJiAp5J7FHbR+jXnorLfruzW=M2A@mail.gmail.com>
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

On Wed, Nov 20, 2024 at 11:26=E2=80=AFAM Alexander Dahl <ada@thorsis.com> w=
rote:
>
> Hello Lothar,
>
> Am Wed, Nov 20, 2024 at 11:11:23AM +0100 schrieb Lothar Rubusch:
> > Hi, thank you all! This is outstanding, such a fast feedback! As I
> > also just ran a tool over the texts, adjusted formatting and
> > reverted/accepted some changes manually to my knowledge (I'm not a
> > native speaker). Please, could you clarify the following?
>
> What about mentioning the tool in the commit message then?
>
> >
> > On Wed, Nov 20, 2024 at 8:15=E2=80=AFAM Alexander Dahl <ada@thorsis.com=
> wrote:
> > >
> > > Hello Lothar,
> > >
> > > Am Tue, Nov 19, 2024 at 10:28:36PM +0000 schrieb Lothar Rubusch:
> > > > Fix some typos and duplicate words in gdb.rst.
> > > >
> > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > ---
> > > >  doc/develop/gdb.rst | 14 +++++++-------
> > > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/doc/develop/gdb.rst b/doc/develop/gdb.rst
> > > > index 4e359c7f22..dc38435227 100644
> > > > --- a/doc/develop/gdb.rst
> > > > +++ b/doc/develop/gdb.rst
> > > > @@ -8,12 +8,12 @@ Using a JTAG adapter it is possible to debug a ru=
nning U-Boot with GDB.
> > > >  A common way is to connect a debug adapter to the JTAG connector o=
f your
> > > >  board, run a GDB server, connect GDB to the GDB server, and use GD=
B as usual.
> > > >
> > > > -Similarly QEMU can provide a GDB server.
> > > > +Similarly, QEMU can provide a GDB server.
> > > >
> > > >  Preparing build
> > > >  ---------------
> > > >
> > > > -Building U-Boot with with reduced optimization (-Og) and without l=
ink time
> > > > +Building U-Boot with reduced optimization (-Og) and without link t=
ime
> > >
> > > ack
> > >
> > > >  optimization is recommended for easier debugging::
> > > >
> > > >      CONFIG_CC_OPTIMIZE_FOR_DEBUG=3Dy
> > > > @@ -24,8 +24,8 @@ Otherwise build, install, and run U-Boot as usual=
.
> > > >  Using OpenOCD as GDB server
> > > >  ---------------------------
> > > >
> > > > -`OpenOCD <https://openocd.org/>`_ is an open source tool supportin=
g hardware
> > > > -debug probes, and providing a GDB server. It is readily available =
in major Linux
> > > > +`OpenOCD <https://openocd.org/>`_ is an open-source tool supportin=
g hardware
> > > > +debug probes and provide a GDB server. It is readily available in =
major Linux
> > >
> > > NACK.  It would read "OpenOCD is a tool supporting x and provide y"
> > > now.  This is most probably wrong?
> >
> > I'm not sure if I got the point. If you can't find the time to answer,
> > I'll simply revert this entire change and leave it as is, no prob.
> > So, change 1) is "open source" to "open-source"; change 2) is a
> > removal of the comma; and change 3) "providing" -> "provide". Do I
> > understand you correctly, change 1) could be ok, where change 2) is to
> > be left as is, and also change 3) has to be as is?
>
> I have no strong opinion on 1).
> I'm not sure about the comma in 2).
>
> Let me explain 3) although I'm no native speaker as well.
>
> You could split the previous sentence in two like this:
>
>   OpenOCD is an open source tool supporting hardware debug probes.
>   OpenOCD is an open source tool providing a GDB server.
>
> After your change the first part stays the same, the second part
> becomes:
>
>   OpenOCD is an open source tool provide a GDB server.
>
> or
>
>   OpenOCD provide a GDB server.
>
> It depends on how you interpret what parts the "and" connects (or
> which redundant part can be omitted), but both variants sound just
> wrong.  So if you can not convince us this is a real style improvement
> in correct language, leave it as is.

Thank you so much. I understand. My question was actually just about
confirmation,
and more about keeping 1) or not. Since 2) and 3) are pretty clear.
Sorry, I was not clear.

> Personally I think automated tools can help detecting language issues,
> but the patch author should review changes carefully before sending
> them to other developers.  ;-)

Agree.

Best,
L
