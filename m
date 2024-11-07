Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1947CD5AE7A
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 09:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A85C8921F;
	Thu,  7 Nov 2024 10:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZdPVVDjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D9C28921C; Thu,  7 Nov 2024 10:31:28 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17CE988B64
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20c805a0753so7784355ad.0
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 01:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1730971884; x=1731576684;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bk3UAo+IsjrJvOqK36OBqtqnBLXRwVMa9No42veOXiA=;
 b=ZdPVVDjNiDeafYwBFbNBJIMsVD5DdRd8jg3Xj5z0zMPKZCQ9rzzCKXc232quRkYZ++
 P/QQ0Ip2eCxY73YSe9v+5RKUsQdrJf3YmkeTbKznTPdSY/QIRhDZ4KsVkzS0kR0sE8PO
 saVvbaFk0w5Xq9Ya/5LDa9MnSd2CZ1bOKz0ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730971884; x=1731576684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bk3UAo+IsjrJvOqK36OBqtqnBLXRwVMa9No42veOXiA=;
 b=s4E2s17dwsmzmBfyVvK07sWlC4/sHK9l+Bg9kWcMAT13CifSJbuhXwgyk3ZAbIkEMg
 LC+/JM0rLgRaRgTg+y5ctFDLbzp7esrfbYhZZSVf2yNcVPUDsSGE+aLxR3FO7r+SWk+H
 joJRctq4oXOfP6EC1f94uLL75hVhOlZjJRSo+blDmmVzSi4DTwya+iVt1xCagE3B4Zim
 6g03hIzhn7cF/hF90fxDkN2NOVSEGS6NDlSXp8BAF26uGiYu6buCufkBe5GWHJ+ORc2z
 I9gBhgQG9AhBsNRn8CYuHT9JkwpqKR2QFX3KfeR1t0JBIC7CC+MsaycdrEf4J7f1UXpI
 9C1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCw7ReSOQrJxFPdh4hlu8lYS3C74TikGQzvoOW0svIBJYL8oZaNVxTMiTDYwWU2PUk1LqdgLw=@lists.denx.de
X-Gm-Message-State: AOJu0YwKhqMxSo4YJDFenvkI42vIaKsZpr4LIUdg9Vh7XvQACiDo4/qZ
 kI/fDMH9Y+cdFE31TMjoWNsBdqhlRKSDGWgGAryqHumhDrxikLYj+qJ7iMwz2NOf3nwILenbYNG
 nRuV/PPP3KzjMPicPs8Ea8qBE1lBcMA1qan8xzg==
X-Google-Smtp-Source: AGHT+IE2EargNon4X3+mTZCkxeazB+jXadAxIZiWSxfPbpm1eLbKXnmNr7KQA4wZVZldQ9b4AT1YGUAXXlXJJBJSFLI=
X-Received: by 2002:a17:903:2287:b0:20d:284c:8d54 with SMTP id
 d9443c01a7336-210c6c1f299mr602232245ad.34.1730971884077; Thu, 07 Nov 2024
 01:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <173058992364.1044919.1983318156372551084.b4-ty@konsulko.com>
 <CAOf5uw=292JNb1g03_Hcgav4zyUckh3R1_iphHnynHVeqC82Jw@mail.gmail.com>
 <e79be8c7-2461-425f-8f7b-e24ad3884d65@gmx.de>
In-Reply-To: <e79be8c7-2461-425f-8f7b-e24ad3884d65@gmx.de>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 7 Nov 2024 10:31:11 +0100
Message-ID: <CAOf5uwmXy4qevGpYe04pYCcSJ3r20o9WXzqemDLfi6z5A041LQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] fs: ext4: implement opendir, readdir, closedir
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Weinberger <richard@nod.at>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de, 
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

Hi

On Thu, Nov 7, 2024 at 10:27=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 11/3/24 00:36, Michael Nazzareno Trimarchi wrote:
> > Hi Tom
> >
> > On Sun, Nov 3, 2024 at 12:26=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> >>
> >> On Sat, 26 Oct 2024 08:40:43 +0200, Heinrich Schuchardt wrote:
> >>
> >>> With this series opendir, readdir, closedir are implemented for ext4.
> >>> These functions are needed for the UEFI sub-system to interact with
> >>> the ext4 file system.
> >>>
> >>> To reduce code growth the functions are reused to implement the ls
> >>> command for ext4.
> >>>
> >>> [...]
> >>
> >> Applied to local tree/v2-tidy-test-dir, thanks!
> >>
> > Am I sleeping?
> >
> > int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp) {
> >      struct ext4_dir_stream *dirs =3D NULL;
>
> Thank you for your review.
>
> We should not set a value that we do not use.
>
> >      struct ext2fs_node *dir =3D NULL;
> >      int ret;
> >
> >      *dirsp =3D NULL;
> >
> >      dirs =3D calloc(1, sizeof(struct ext4_dir_stream));
> >      if (!dirs)
> >          return -ENOMEM;
> >
> >      dirs->dirname =3D strdup(dirname);
> >      if (!dirs->dirname) {
>
> Yes this line in my code is incorrect.
>

We need to use valgrind in unit test or we need some code analys to
automate this process.
We are always looking for memory leaks in uboot in exit path or we
need to have alloction funciton that
automatic free the memory when we go in error path

Michael

> >          free(dirs);
> >          return -ENOMEM;
> >      }
> >
> >      ret =3D ext4fs_find_file(dirname, &ext4fs_root->diropen, &dir,
> > FILETYPE_DIRECTORY);
> >
> >      if (ret =3D=3D 1) {
> >          ret =3D 0;
> >          *dirsp =3D (struct fs_dir_stream *)dirs;
> >      } else {
> >          ret =3D -ENOENT;
> >          free(dirs->dirname);
> >          free(dirs);
>
> Yes, we should avoid a memory leak here.
>
> I will send a patch.
>
> Best regards
>
> Heinrich
>
> >      }
> >
> >      if (dir)
> >          ext4fs_free_node(dir, &ext4fs_root->diropen);
> >
> >      return ret;
> > }
> >
> > Should not be like this?
> >
> >> --
> >> Tom
> >>
> >>
> >
> >
>


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
