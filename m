Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B204AD63936
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 12:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0310F89699;
	Wed, 20 Nov 2024 13:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cVGw7RB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 724A389417; Wed, 20 Nov 2024 11:25:50 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E536B893EA
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:25:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6eeb5ee7463so1336137b3.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 02:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732098347; x=1732703147; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuH+YK6gUrpDnasZF/7ZOGaPBc7TCss7cy+ogxqdU/g=;
 b=cVGw7RB6PhQMW6JmQoxG3uYmhHIxrvH44Oz7oj0zolSSUqAMf8L++TPOTQ9qG/ozRI
 MqVrhoAVdozgjAq/Jtg7PN4wLa2hKai9vfdPdtZ+E8RZOVcgcn7KWlqWQToUt8sTm62V
 oE2bIghMPlYKgb4Q+wiwlm17xfILX/RTAXghokhagLh49Ulh5azE+zcAq7diMS/c15Dm
 VT5n6tiaKuq4mSwv8SMJLQMd9Qh1k2cVOG2kz2NURMfc7OshcNgO3ttj2h0NmKWNH2c4
 TSZD2u1hn0pWzv6TPQ27eOYDAhZYm66JIJI7R+I6duXNopf9v2xJhPwyeTL6tzWl/PcB
 sVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732098347; x=1732703147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VuH+YK6gUrpDnasZF/7ZOGaPBc7TCss7cy+ogxqdU/g=;
 b=Os7DuG/ZIrQbvy/IpNpRFVr2IWym3ZUJVIpB8vh7jd4KA0RfjW0DjdCChPCxlm5XTX
 zIHZzTwsbWofgNDcHgUAfTVtYCIn+3zWzVRG9maOVZ2RNq2lD0BdPjvJL73AQGowyjZy
 bJt8cPFqYgXP4RPTbaQ67koQPQyh8sd2oFUZ3byptwg7lcs2KF3YDfzV3Wq4EvMxC7UP
 CAqnpU6ywchekLNNyuB/u+0Bp0DVEpSU3wA6pAHJhky2wItWigIEWGNKY/7o4TbbAiR+
 KeSPqDsBo3uFckJNb8F/iQz361zwFgNFtgqYh6VM/hFD0Ap1x8/wwLAZ3eDcYU49PCcJ
 Vb1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUarlrqIJ+IU32kfcH+hkfNHP+zV38amAX9z+OMmX1OA/dRpWeeYGYF/GZ1xsAoV+LKJOVMNc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0JTPjAD3vxQM1bHe3k5yjpbPpu6STA/AHEyhNhYzsn/+7ND11
 A0UNwRj8wZ0zJD8a7TxmlpJBtDIq/8ciWCUMuoe6uNEt9rKeKqsb6DBPGS9MqVejRwR4mm/X24V
 OU/00IRCA7NdRCvB6s2uDcpfFJYw=
X-Gm-Gg: ASbGncuTDEheqn0p1gCTtMg8Tn6j5nlYdCmPWJ2iuYH85c8KHIleghsQ2MFIqbgahzt
 QOv5BZT9GUoA0s6+ZwBOmj1IcRE95roQ=
X-Google-Smtp-Source: AGHT+IHQykBdLsnwEZikINeDVw36Hr9QrQMiAHgn2a1bnGgcwx9ba+S9G3m5jcU4iZ3NcOcuKz1hTqxof1qCsy6ITIg=
X-Received: by 2002:a05:690c:6ac8:b0:6ee:b774:fff7 with SMTP id
 00721157ae682-6eebd2b0490mr8736537b3.10.1732098346687; Wed, 20 Nov 2024
 02:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20241119222837.27550-1-l.rubusch@gmail.com>
 <20241119222837.27550-3-l.rubusch@gmail.com>
 <2BD68232-B09D-4F0C-9969-B90230A6FB90@gmx.de>
In-Reply-To: <2BD68232-B09D-4F0C-9969-B90230A6FB90@gmx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 20 Nov 2024 11:25:10 +0100
Message-ID: <CAFXKEHbJ3fYNgD_Mxxi30FpX+habBOr2WmkcGjw_6=4b0X8nkA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] doc: develop: Fix typos and wording in gdb.rst
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: sjg@chromium.org, trini@konsulko.com, alpernebiyasak@gmail.com, 
 ada@thorsis.com, mkorpershoek@baylibre.com, 
 dario.binacchi@amarulasolutions.com, pbrobinson@gmail.com, n-francis@ti.com, 
 afd@ti.com, al.kochet@gmail.com, u-boot@lists.denx.de
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
native speaker).

On Tue, Nov 19, 2024 at 11:48=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> Am 19. November 2024 23:28:36 MEZ schrieb Lothar Rubusch <l.rubusch@gmail=
.com>:
> >Fix some typos and duplicate words in gdb.rst.
[...]
> >     CONFIG_CC_OPTIMIZE_FOR_DEBUG=3Dy
> >@@ -24,8 +24,8 @@ Otherwise build, install, and run U-Boot as usual.
> > Using OpenOCD as GDB server
> > ---------------------------
> >
> >-`OpenOCD <https://openocd.org/>`_ is an open source tool supporting har=
dware
> >-debug probes, and providing a GDB server. It is readily available in ma=
jor Linux
> >+`OpenOCD <https://openocd.org/>`_ is an open-source tool supporting har=
dware
> >+debug probes and provide a GDB server. It is readily available in major=
 Linux
>
> Thanks for the patch.
>
> 'tool' is singular. You cannot use 'provide' here.

Ok.

> > distributions or you can build it from source.
> >
> > Here is example of starting OpenOCD on Debian using a J-Link adapter an=
d a
> >@@ -124,7 +124,7 @@ with the command *bdinfo*:
> >     Early malloc usage: cd8 / 2000
> >
> > Look out for the line starting with *relocaddr* which has the address
> >-you need, ``0x27f7a000`` in this case.
> >+You need, ``0x27f7a000`` in this case.
>
> You is only capitalized at the start of sentences.

Ok.

> >
> > On most architectures (not sandbox, x86, Xtensa) the global data pointe=
r is
> > stored in a fixed register:
> >@@ -144,7 +144,7 @@ riscv        gp
> > sh           r13
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D
> >
> >-On these architecture the relocation address cat be determined by
> >+On this architecture the relocation address can be determined by
>
> On these architectures ...

Ok.
