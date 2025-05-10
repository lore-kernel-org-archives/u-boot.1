Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DCAC3ABC5
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 13:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DFA68294C;
	Sun, 11 May 2025 15:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=chewies.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=chewies-net.20230601.gappssmtp.com header.i=@chewies-net.20230601.gappssmtp.com header.b="n9zPzeD3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12CEF8283E; Sat, 10 May 2025 22:22:00 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B08A78211F
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 22:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=chewies.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=raz@chewies.net
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-acacb8743a7so539857366b.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chewies-net.20230601.gappssmtp.com; s=20230601; t=1746908517; x=1747513317;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghFoxlYELDJTH8sQXcJctO6qyyJl1AJpsH25aK+VUgs=;
 b=n9zPzeD3U0jv5HiCqNGOvnTqLJjduZOO3LCj77KWQdlD2HGGgeHJjfL0M672/elNiy
 bCybhb69MvpFjT7vYSXjbXdfRLyXyi141rrDwDtixu45VN6tUGxbeko18ekqj7EqtEwF
 9oz+2yythSpmlhoJ0xuHJU2eOiWTeIYh9jriwkR2JMM1o9RKnuGTsjMIAVe4nAF5HjDh
 f5cgEwl6833P71rEfeZQetd9VaIgZLMeiA2NnG65w+ZXGH1WdVlejHylaRQBuKcL7z+L
 J1rs8QaOH3RpFVCXLDY7noSXWppKpUuaUTB5A3E5ShV1V7L88xmwQaPKks1blJZQ+y5p
 V1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746908517; x=1747513317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ghFoxlYELDJTH8sQXcJctO6qyyJl1AJpsH25aK+VUgs=;
 b=OmCLu+u0lbz7DkADV2+TiqjqeNArlgC28m+REJOtss5OM0cpUV85Vu/Cs1QSiG1R7j
 VD3wkudgJmxJyusYUKU5yLTaEvenF/I4fsnPj7qh+SSMYtmiu1UjXR5+h2uJ88RsOs1K
 IyFOoi52c1iLxc/eFUVAe9CvjF08gEnsNkQNd9KMA9aZWarHmSxEDhm45Gu6t/sfyYKY
 9PA29KuZ5j32zTRR77/MtIpS1t2j+zBvNyKdDFjbGjcap686sKX40KlxaC7bkhqf+pal
 haobMUW9U0/OMyiUiwHlboeacyGQ/RmCxjowmjvnMTGCzmRWP4AQF3pAjeij7FYFp98t
 y5ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrn8dNQCYYD3Xg5r2UTSJAbGv4TEWYt5eWwAJ537VUc4H2YwbA0FFRHGVGEGcLgnvoPt00Fsk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6FcTfWjbykxW1ClOqoh/ZCTuvLsur+9o4x7im7ycVBK4TDDGj
 bvM6PLIVH7xDIRn+8h9NwJZcxxC+OT3A6raCyf6GCEwC6uvOJdybm1zVr4zuS1iTR6VuPNMFfrN
 lbfhgnLDCu39okbtAFYqyeu0NToemPOQxFgZU
X-Gm-Gg: ASbGncujl3Y3M7FtR6TMNt99JkiH7sTF0hdI2bSH1q9uCXpsCIgxSAyOK3YkrvfvzgU
 dbbAWjuc0DdQ0Igv23fgKfd54Jcwlte6Ryr7vYflmrdnddn24VjaVnSjcfRxmNnmmY1pL7UZeC4
 QQq6BcszoKLPN5WnKcYaP/nVPHkaw/TQ==
X-Google-Smtp-Source: AGHT+IHrmIxpu89JcXp8pTsYpjYQ52JP4jQJB6ftV4JyF40SXcxgujBoCYyks/9VE96AKLi7tzU34e4CP9TYSNEW1s0=
X-Received: by 2002:a17:907:c317:b0:ace:8176:9870 with SMTP id
 a640c23a62f3a-ad21b16d832mr722442266b.9.1746908516933; Sat, 10 May 2025
 13:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
 <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
 <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
 <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org>
 <CAEUiLuYW61Vz4zAie2K9cnXXQxxRj150Nc-fJMQCh9NwXZQmzQ@mail.gmail.com>
 <CANAwSgRkqAj5Q4LMO-CKBSoMgO-+zd6JpbVs+eWY3kPgmj9bug@mail.gmail.com>
 <CAEUiLubakMjzhi2sUTQx1S4ciTjkL6ysx465i1t-T5zKUQdUvw@mail.gmail.com>
In-Reply-To: <CAEUiLubakMjzhi2sUTQx1S4ciTjkL6ysx465i1t-T5zKUQdUvw@mail.gmail.com>
From: Wayne Schroeder <raz@chewies.net>
Date: Sat, 10 May 2025 15:21:44 -0500
X-Gm-Features: AX0GCFutdAtYDL586PDSub990CVv4WeGORcasNYzmQIEdeFBm-BEawgbOOwFLNY
Message-ID: <CAEUiLuY2D_CzkEH0+gCvkbC_MtJ4B-MLYYkx_r2E9BHxPvuVjg@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: Anand Moon <linux.amoon@gmail.com>
Cc: Ferass El Hafidi <funderscore@postmarketos.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, 
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 11 May 2025 15:02:43 +0200
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

Applied patches to 2025.04 release (applied clean).  Made stock
defconfig for odroid n2, built, signed, installed.  The reboot issue
remains and usb ports are unavailable to linux kernel after reboot.

It is worth noting that linux does see some enumeration of devices
after a while, but even if it logs to the console about device
attachment, the devices don't actually function.  This was the same
behavior with the release version.

Wayne

On Fri, May 9, 2025 at 10:01=E2=80=AFAM Wayne Schroeder <raz@chewies.net> w=
rote:
>
> Yes.  Will report back how it works on the n2+.
>
>
> On Fri, May 9, 2025 at 2:08=E2=80=AFAM Anand Moon <linux.amoon@gmail.com>=
 wrote:
> >
> > Hi Wayne,
> >
> > On Fri, 9 May 2025 at 01:25, Wayne Schroeder <raz@chewies.net> wrote:
> > >
> > > I actually already have a working solution that I documented in my
> > > github repo (dubschro/odroid-n2).  All I do is set BOOTCOMMAND to
> > > check/delete a flag file on my boot partition and if it is found, the=
n
> > > reset usb and sleep for 10 seconds.  I then have a systemd shutdown
> > > script only on reboot to touch that file.
> > >
> > > CONFIG_BOOTCOMMAND=3D"fatrm mmc 0:1 reboot && echo Resetting USB on
> > > reboot... && usb reset && sleep 10; run distro_bootcmd"
> > >
> > > It is a hack, but... the system reliably reboots remotely now, and
> > > that's the important part for now.
> > >
> > > Wayne
> > >
> > > On Thu, May 8, 2025 at 11:22=E2=80=AFAM Ferass El Hafidi
> > > <funderscore@postmarketos.org> wrote:
> > > >
> > > > On Wed May 7, 2025 at 1:03 PM UTC, Wayne Schroeder wrote:
> > > > > It's hard for me to quantify if usb works in u-boot as I'm not lo=
ading
> > > > > off of any usb storage devices.  It certainly never lets me use t=
he
> > > > > keyboard to abort auto boot, and never has.  On reboot, to reliab=
ly
> > > >
> > > > You can send bytes via UART to abort boot, if you happen to have a =
UART
> > > > adapter around.
> > >
> > Can you test this series to see if this resolves the issue?
> >
> > https://patchwork.ozlabs.org/project/uboot/list/?series=3D456088
> >
> > Thanks
> > -Anand
> >
> > > _______________________________________________
> > > linux-amlogic mailing list
> > > linux-amlogic@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-amlogic
