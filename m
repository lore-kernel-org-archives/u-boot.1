Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852BBC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 19:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC50F87A5F;
	Thu, 28 Dec 2023 20:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="inBdF2WX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 770C087A4E; Thu, 28 Dec 2023 20:52:32 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E99D87A5F
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 20:52:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32f8441dfb5so5959711f8f.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 11:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703793148; x=1704397948; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYBRQBpXv65HIzw7QE5lWi6YcuJ8juwq0/xoWaFS1p4=;
 b=inBdF2WXw1zyBh3zA2cGmV+Ix0VleotVarPmLk+wp652eXw4qdvkU5z6rVukc5mHx+
 18ZCqJ4XUbahUL4Bu1Spx20uWsvCx8z4At/ODKdOjVtQITcKeQt6qdMmx9SlDwnaIRAh
 n8X2DnCDVoPP55kZXO8vtTEe8whUzYoNqhRexbL2jjITWgqlaLqPgoj2wSDTVvKLIjKc
 /0lYoc6GlSwTyHl/ZcED09lToQm0GKA+dnxjZVsi37/0erd36xbLbfH/ELf2Wm9wx7MQ
 818zYo7x2pugF7vHOO3wFO1sJInltAagh8Dr7Dqwq/EHhBoFRSaVXday2eFAJUTytM5b
 iw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703793148; x=1704397948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aYBRQBpXv65HIzw7QE5lWi6YcuJ8juwq0/xoWaFS1p4=;
 b=dgNLg1X+ndFsx3jIrB7ia11KYvs+1umnk50a/SKi5e6kAjsBNTD6nwRFmq2RDaiujq
 ya/uoiiahvjHdvsmxv9RQREdGCUUnONVUxw5Fn54CJZKo9XaHmDMT7H3bVWWxjUg2xzX
 aWk6GYSI9I2qn/OCTKxVUJhOBzFLf6VN2hE05dImTDZ3dFvQ+lMzqxu8SXsT7E2ercF6
 vTgeUwmz8Od6g7AavMXaO1omcDIoGuZxEYFQ0ud/ykeGdNsjPATnlq1J4MDDBD1A45iC
 hUr1kqAKNWQ2r/0VKA3v3V3E3UstjgCARckwmkhv8jXs4y/nJaX1as3tw7a4BYnNwB5W
 ltGw==
X-Gm-Message-State: AOJu0YwF5A1r9wATjBZu9T8D2l8RQiSYc9PYWNjyY6+57OFo+ndDD4l3
 mjPCoNmqTjCVNMOmJ6dkBJVpiAezKrKYTTHWFKxwaOCQ
X-Google-Smtp-Source: AGHT+IFXjT7lflllWVL+XsQA+rZ/1uGfzDBFuGELcbTTnednf9TA1NOAZWIILmFe8DZrJ+xRbGr32gtUmGiAs4+7zyM=
X-Received: by 2002:adf:ee87:0:b0:333:2ace:9747 with SMTP id
 b7-20020adfee87000000b003332ace9747mr5017784wro.11.1703793148211; Thu, 28 Dec
 2023 11:52:28 -0800 (PST)
MIME-Version: 1.0
References: <20231228180154.50473-1-clamor95@gmail.com>
 <20231228180154.50473-5-clamor95@gmail.com>
 <CAFLszThd95iSPMOBr_21_Zckg74BtgA23EVpfXQKqnArFc-UDQ@mail.gmail.com>
In-Reply-To: <CAFLszThd95iSPMOBr_21_Zckg74BtgA23EVpfXQKqnArFc-UDQ@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 28 Dec 2023 21:52:17 +0200
Message-ID: <CAPVz0n3OwhrW41tV9x32UXyL6yZdLr8CU9S7XuTneDiwUQY7AQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] common: console: record console from the beginning
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, 
 Heiko Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
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

=D1=87=D1=82, 28 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =D0=BE 21:4=
8 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Dec 28, 2023 at 6:02=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.=
com> wrote:
> >
> > From: Ion Agorria <ion@agorria.com>
> >
> > Set flag to enable console record on console_record_init
> > and not only on console_record_reset_enable. This fixes
> > missing start of U-Boot log for fastboot oem console
> > command.
> >
> > Signed-off-by: Ion Agorria <ion@agorria.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > ---
> >  common/console.c | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> OK, I can see the use of this...but I wonder if we can now get rid of
> the same line of code from console_record_reset_enable() ?
>

Interesting question but let's leave it to a dedicated patch :)

Best Regards,
Svyatoslav R.

> >
> > diff --git a/common/console.c b/common/console.c
> > index 6f2089caa0..e6d7ebe935 100644
> > --- a/common/console.c
> > +++ b/common/console.c
> > @@ -821,6 +821,9 @@ int console_record_init(void)
> >         ret =3D membuff_new((struct membuff *)&gd->console_in,
> >                           CONFIG_CONSOLE_RECORD_IN_SIZE);
> >
> > +       /* Start recording from the beginning */
> > +       gd->flags |=3D GD_FLG_RECORD;
> > +
> >         return ret;
> >  }
> >
> > --
> > 2.40.1
> >
>
> Regards,
> Simon
