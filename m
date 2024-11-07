Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8A5D5AE75
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 09:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF35891FE;
	Thu,  7 Nov 2024 10:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XtIbvJc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95DE289208; Thu,  7 Nov 2024 10:12:11 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4940C891FD
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e30fb8cb07so545289a91.3
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 01:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1730970728; x=1731575528;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cz+rFGGTEiKWs0dQpqIxvDiRGnDiPDD7XksIbXqClX8=;
 b=XtIbvJc0c+lsf24tYY+1J5nCeptj712tizpSiIdHE/BwOGu7fsXcjbbLZ+4Tx2YmNj
 qnFFaeyRNfz7PC7Ll5ddBRKPinGN9vkos/Fqn8vE6vK3A9mXmPATdoLALmUvhOko2QYn
 q/Crc0WBmd7mNbvFCZTHruseLkaa7l9awdgfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730970728; x=1731575528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cz+rFGGTEiKWs0dQpqIxvDiRGnDiPDD7XksIbXqClX8=;
 b=bbGyoa40UfEaTszZJsweEORl8P3oZk07Glf3r0VQgD6y6hESC0Yd9uJp7MEaZ/AlBV
 ekbY2ECXuayVcbVhzWoDKXBhsq2h33MsiK0DCwXDM/ol1qAmB5XTjNf049oX/JFy9oi1
 5k3HL0H1REhLovvrkZwYOR7rHhybwjTvZS6QbvRC7aOGpxUvpZzRL6KGa4040Kkuy5Wp
 h+1w9HBQbB6rtyPBxeitrn7wNgTjnkqLwbRXlf3wjlkB5gknfkkesV8d2E2LNJVXE/1c
 OjdKGvQFdXUfDp9TNrmBDXzUKnzPcpaqKzXI4h18TjCbr/5U5cDTbLSZzRwIL+NDhuzX
 bbZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVk36g6hY3xw3eQyCKThv5xDdp0g1jP6HzREda2jskHWJaWe5g2axaBTqNuE5KsWWslpgvtUI=@lists.denx.de
X-Gm-Message-State: AOJu0YwAb5px2Z8Za1TZBkuLxWTcZ+5eaWzUKPmeklCJYZYo8H66aXWs
 f7DX6D8LErv72vMk1f2vgiwCDR6q+juom66t4Kvx53o7RmtRhWNvNJ3xnSn7goBGzsM2DWqHNcw
 Qk7X12GLsuIEWv9qPvW5xReDYDTYE0WF5Em5GQA==
X-Google-Smtp-Source: AGHT+IFPT1t/kkq/OHp1gXkxzZWeZp7M9ebLJDAWDQoLQVTNTqb3XH0B0V3BxFCxscvvbP9y1ZuBuZGKjCKwAGfY79g=
X-Received: by 2002:a17:90b:1bc3:b0:2da:9115:15ce with SMTP id
 98e67ed59e1d1-2e9aaff79bemr405915a91.15.1730970727706; Thu, 07 Nov 2024
 01:12:07 -0800 (PST)
MIME-Version: 1.0
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <173058992364.1044919.1983318156372551084.b4-ty@konsulko.com>
 <CAOf5uw=292JNb1g03_Hcgav4zyUckh3R1_iphHnynHVeqC82Jw@mail.gmail.com>
 <20241102235319.GY3600562@bill-the-cat>
 <CAOf5uwnJwMaoA73kSwyibkRCV=tbFem3a4-ajBnH1mRkWdE-xA@mail.gmail.com>
In-Reply-To: <CAOf5uwnJwMaoA73kSwyibkRCV=tbFem3a4-ajBnH1mRkWdE-xA@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 7 Nov 2024 10:11:54 +0100
Message-ID: <CAOf5uwkrDP6i1OG62XGKPNByqw8PsmeQpAJPtBSC23T25JF6AA@mail.gmail.com>
Subject: Re: [PATCH 0/5] fs: ext4: implement opendir, readdir, closedir
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, U-Boot-Denx <u-boot@lists.denx.de>
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

On Sun, Nov 3, 2024 at 9:21=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> Il dom 3 nov 2024, 00:53 Tom Rini <trini@konsulko.com> ha scritto:
>>
>> On Sun, Nov 03, 2024 at 12:36:38AM +0100, Michael Nazzareno Trimarchi wr=
ote:
>> > Hi Tom
>> >
>> > On Sun, Nov 3, 2024 at 12:26=E2=80=AFAM Tom Rini <trini@konsulko.com> =
wrote:
>> > >
>> > > On Sat, 26 Oct 2024 08:40:43 +0200, Heinrich Schuchardt wrote:
>> > >
>> > > > With this series opendir, readdir, closedir are implemented for ex=
t4.
>> > > > These functions are needed for the UEFI sub-system to interact wit=
h
>> > > > the ext4 file system.
>> > > >
>> > > > To reduce code growth the functions are reused to implement the ls
>> > > > command for ext4.
>> > > >
>> > > > [...]
>> > >
>> > > Applied to local tree/v2-tidy-test-dir, thanks!
>> > >
>> > Am I sleeping?
>>
>> ... I always forget b4 compares with checked out branch, that should
>> have been master.
>>
>> > int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp) =
{
>> >     struct ext4_dir_stream *dirs =3D NULL;
>> >     struct ext2fs_node *dir =3D NULL;
>> >     int ret;
>> >
>> >     *dirsp =3D NULL;
>> >
>> >     dirs =3D calloc(1, sizeof(struct ext4_dir_stream));
>> >     if (!dirs)
>> >         return -ENOMEM;
>> >
>> >     dirs->dirname =3D strdup(dirname);
>> >     if (!dirs->dirname) {
>> >         free(dirs);
>> >         return -ENOMEM;
>> >     }
>> >
>> >     ret =3D ext4fs_find_file(dirname, &ext4fs_root->diropen, &dir,
>> > FILETYPE_DIRECTORY);
>> >
>> >     if (ret =3D=3D 1) {
>> >         ret =3D 0;
>> >         *dirsp =3D (struct fs_dir_stream *)dirs;
>> >     } else {
>> >         ret =3D -ENOENT;
>> >         free(dirs->dirname);
>> >         free(dirs);
>
>
> I have add in this path the free of dirs, because according to the code I=
 can see from this email is not reference anymore and anyway according to w=
hat I have commented already moving allocation of dirs later make the code =
a bit simpler.
>

There are few leaks in this function. I have fixed, can you take a
look again on what you merge?

Michael

> Michael
>
>
>> >     }
>> >
>> >     if (dir)
>> >         ext4fs_free_node(dir, &ext4fs_root->diropen);
>> >
>> >     return ret;
>> > }
>> >
>> > Should not be like this?
>>
>> Please elaborate?
>>
>> --
>> Tom



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
