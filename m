Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08931C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 16:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67C3182A2F;
	Fri,  9 May 2025 18:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=chewies.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=chewies-net.20230601.gappssmtp.com header.i=@chewies-net.20230601.gappssmtp.com header.b="H0an6OZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45C7F82998; Fri,  9 May 2025 17:01:33 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC40582162
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 17:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=chewies.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=raz@chewies.net
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5fbf007ea38so3648033a12.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chewies-net.20230601.gappssmtp.com; s=20230601; t=1746802890; x=1747407690;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBgL3ZL550pwHUyGu0636IzKUM8jYg6oWWIjwlwmye0=;
 b=H0an6OZQCAul+YhJAeqWprAHHuPTsmO/FM4YiH0Wr8gdw0YvYGMtuyLiUnmdcpntVz
 ApXQ/yLJWqnSiJp/WfGPu9fXBxEh8UhRl3FaEAlokujs1IIp4ZkmqF9wJ/bgfWGKVazn
 t6CZ3e0ojgH8bFNgfppwMBKAX+y6kZfEvY4hycAhAfBeRsDIrhmEwo/zp7sTO94jnSdu
 N7S8q+W5Dm60CS8//PjmoqPn31cvoAplZKeIjpQC9n6F9bLTUS6tpnbSzAJVwFiy9uLD
 V1xiC4kCxMhVT2WSQtD3Hyl7FwyWnKc56UhRkQ1YnPlEwYaFfwAcrt3lIzPGh5PqpSik
 H+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746802890; x=1747407690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wBgL3ZL550pwHUyGu0636IzKUM8jYg6oWWIjwlwmye0=;
 b=aqIXKNJWmrqeNlB7G01mTO4FvE7nYcN3xkUSCPWJNBu3uTOckZxjgZhMsEpApKac7r
 9Zxj8klV19cThAmGXzNSQ823L8CbaRRaZmhDmbe6hWCcYz0H+Rkre13zZ74HTxvMu4ST
 kyvlbM5ym4w6GFqM8F3x0FqQACIJUrSdsrHvHawU6b/pfhbc0e27DA+NurEjHHA3bdup
 QfPTpJIhK62ZJ2cviA731iT4BeYZbLubBFfrAHOS9AHy5tbVwPPrKRZTKS4SlFH8n19y
 rIbtfdHlN5Lleek/XQRkVH3vBoxd9xbFGDRkIii7v1jP8QiAtrzTrybRnsJOjWD1aKkl
 JO4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdXutGsRgIsa67ARpyglpOkMm07xXPWhquTBmYS1s1yP60V2NfSv12kKNlud5TFm0Wz4cApkQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy98/cYH7A8/CiRVJ8m1I/9gPkvad9veN9tZg6/hG/73ltYLOl1
 /9dG8oXr3ABUWG+4e5JNCRxfZn0XBuO3tHpTIZ36qzaX7x5V4ZH2FJeXDzFXFSj5xzOWd83UXIf
 yp4o1zCCbPZt9AoCfjy9OUHRZyvu0kfBhbpwl
X-Gm-Gg: ASbGnctrcwivjJWdw2imqmo8Uc+BWW8zaSAuIuLbURgQnuFr6ZpTO97RTKhXE0W04IW
 kjC5hMciJqjcU6Xgr0XmkxgIQfLc8y+Q41l/1xaBG4UC1wlQlnSCqwdB8mnj7kPuSxCrAcyUSMI
 RYiO71uURIthYIDyRcwAPy
X-Google-Smtp-Source: AGHT+IFf+nVAgdwIKvhp6FKx94q2YT6+sEg9xhUFkBICZbH6CrypO4w3U2C9D+gFHigfCbHoi7dvxkUDtWZbD7xfAIc=
X-Received: by 2002:a17:907:a2cd:b0:ace:caff:675a with SMTP id
 a640c23a62f3a-ad218e47c9bmr306712966b.10.1746802889091; Fri, 09 May 2025
 08:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
 <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
 <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
 <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org>
 <CAEUiLuYW61Vz4zAie2K9cnXXQxxRj150Nc-fJMQCh9NwXZQmzQ@mail.gmail.com>
 <CANAwSgRkqAj5Q4LMO-CKBSoMgO-+zd6JpbVs+eWY3kPgmj9bug@mail.gmail.com>
In-Reply-To: <CANAwSgRkqAj5Q4LMO-CKBSoMgO-+zd6JpbVs+eWY3kPgmj9bug@mail.gmail.com>
From: Wayne Schroeder <raz@chewies.net>
Date: Fri, 9 May 2025 10:01:17 -0500
X-Gm-Features: ATxdqUE_PmhZ54jFeg6jIYai2y3B-gBv2fkdfTsqYASmYzXd9Nfo6C7yAcR2Cw4
Message-ID: <CAEUiLubakMjzhi2sUTQx1S4ciTjkL6ysx465i1t-T5zKUQdUvw@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: Anand Moon <linux.amoon@gmail.com>
Cc: Ferass El Hafidi <funderscore@postmarketos.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, 
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 09 May 2025 18:48:46 +0200
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

Yes.  Will report back how it works on the n2+.


On Fri, May 9, 2025 at 2:08=E2=80=AFAM Anand Moon <linux.amoon@gmail.com> w=
rote:
>
> Hi Wayne,
>
> On Fri, 9 May 2025 at 01:25, Wayne Schroeder <raz@chewies.net> wrote:
> >
> > I actually already have a working solution that I documented in my
> > github repo (dubschro/odroid-n2).  All I do is set BOOTCOMMAND to
> > check/delete a flag file on my boot partition and if it is found, then
> > reset usb and sleep for 10 seconds.  I then have a systemd shutdown
> > script only on reboot to touch that file.
> >
> > CONFIG_BOOTCOMMAND=3D"fatrm mmc 0:1 reboot && echo Resetting USB on
> > reboot... && usb reset && sleep 10; run distro_bootcmd"
> >
> > It is a hack, but... the system reliably reboots remotely now, and
> > that's the important part for now.
> >
> > Wayne
> >
> > On Thu, May 8, 2025 at 11:22=E2=80=AFAM Ferass El Hafidi
> > <funderscore@postmarketos.org> wrote:
> > >
> > > On Wed May 7, 2025 at 1:03 PM UTC, Wayne Schroeder wrote:
> > > > It's hard for me to quantify if usb works in u-boot as I'm not load=
ing
> > > > off of any usb storage devices.  It certainly never lets me use the
> > > > keyboard to abort auto boot, and never has.  On reboot, to reliably
> > >
> > > You can send bytes via UART to abort boot, if you happen to have a UA=
RT
> > > adapter around.
> >
> Can you test this series to see if this resolves the issue?
>
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D456088
>
> Thanks
> -Anand
>
> > _______________________________________________
> > linux-amlogic mailing list
> > linux-amlogic@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-amlogic
