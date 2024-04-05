Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09F7CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 04:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D153788208;
	Fri,  5 Apr 2024 06:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GcSuCCBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6138988393; Fri,  5 Apr 2024 06:40:49 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C12488208
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 06:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gch981213@gmail.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-dc74e33fe1bso1755727276.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 21:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712292046; x=1712896846; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lx1bDtZuXZ6zcN8yuffJbFOf6qsqH7wBOCOnoZFGYZc=;
 b=GcSuCCBtz3sZ9QjYh4ZmlIwc/jhaV1kBk4D0Yivex+aRoVSl5lXKUvFI5aD1jX9Aj9
 MfwoHd98AdrAK9YCOhCJuHnNMoQ4cvYydeeu6Xmdr8X1TQCacTyFC2cMx1md/UynxcMF
 WeHGaq4Zw2eoW2Q10J66IOcJGeC+ARVvaX6yW0LryY/N0q0SADL49LUbqGGxfP9ha8O9
 Vb+3aHXd8cUKMIIRhJ5UAaZXet6uS5rjrCujKPXgwawiHw34GS88f2jEIGlR7ogk0nWj
 5eiHaf3D5Nhrs1H/8T7QG34McBiGkUo95w3gXWKonAMDeM888BX7Pq7PJ3XFfiTH7gua
 PGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712292046; x=1712896846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lx1bDtZuXZ6zcN8yuffJbFOf6qsqH7wBOCOnoZFGYZc=;
 b=HiZeQTtrPQ19/5Dh9nH76a8MTolHB4Emt7zKRYBAwOFhhDCjnQVi1Udfqttn7UJy1a
 2MmVHXI7F6+ybcGWWw+jOUfQ2BZhqvc7NX/dhFjHm2MyQOr5UAYTrQ4KqlgS3Rpy9J1N
 And8YnWcP9eB7XtNvqZzmP8fym3k9xbeZ32Hi4xhDi6JD/k8F9AanInH3WbCmBA/A40I
 M22FgfSXOGHt2Lc53p1qT9ZecJTUsyM5zimUPEtem104L7jJJt02eH2K/SWuJ2fk6W1a
 mfmMn1xQ0XDpRGX87FnqJptEI+hpzSyiInRNyJnbFexc7S+J42+DdThmMadtnxfVSWuf
 xbhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHgEz13cJBX6bDpW4splPybRhzF0QmbFjtxiD+Na4qejddxvNU6DmACOvMvd0VPh9YNIGtB54SXcS2MG4sAMi8kMn0cA==
X-Gm-Message-State: AOJu0YxfZ0pvM68YXaDDYhI7TqwpAkO0r2fEW6dUTqdPAY3+nTj+CQMP
 x7DQmUuqM7lEhozFiSIzrP4gxsoNYv0N7CQ8+CQGokuwL3sM/TtnvcL4BorsvBD0f2qDhx56Y/m
 WiPUUeghArLKky7t84GnKsK1VCCQ=
X-Google-Smtp-Source: AGHT+IFb4ojrIjVyoJ3v1vUMRAFtk8NI8y8qu1myjSfxO1L6cBmzx8pJCat8+d8sL9q85mFx/SlJ+9kAGXTmjFpYzmw=
X-Received: by 2002:a25:b009:0:b0:dc7:4854:1b1e with SMTP id
 q9-20020a25b009000000b00dc748541b1emr229933ybf.54.1712292046110; Thu, 04 Apr
 2024 21:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240325144148.3738195-1-avromanov@salutedevices.com>
 <20240325144148.3738195-7-avromanov@salutedevices.com>
 <CAJsYDVJC6eTGCXi7m_s3FOpg8isnwRxnQbkAUeSvCRrHSYUdFA@mail.gmail.com>
 <20240404080210.5f5u4r223b4oauum@cab-wsm-0029881.sigma.sbrf.ru>
In-Reply-To: <20240404080210.5f5u4r223b4oauum@cab-wsm-0029881.sigma.sbrf.ru>
From: Chuanhong Guo <gch981213@gmail.com>
Date: Fri, 5 Apr 2024 12:40:34 +0800
Message-ID: <CAJsYDVKqj4jP+Pe_kGesskhwA8O4EWf1GGhBcU1vCeJiUrNzeg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] spinand: bind UBI block
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>, 
 "michael@amarulasolutions.com" <michael@amarulasolutions.com>, 
 "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
 "kmpark@infradead.org" <kmpark@infradead.org>, 
 "hs@denx.de" <hs@denx.de>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "dunaev@tecon.ru" <dunaev@tecon.ru>, 
 "sjg@chromium.org" <sjg@chromium.org>, "bmeng@tinylab.org" <bmeng@tinylab.org>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "tobias@waldekranz.com" <tobias@waldekranz.com>, 
 "jpewhacker@gmail.com" <jpewhacker@gmail.com>, 
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>, 
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "jbx6244@gmail.com" <jbx6244@gmail.com>, 
 "abdellatif.elkhlifi@arm.com" <abdellatif.elkhlifi@arm.com>, 
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>, 
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 kernel <kernel@sberdevices.ru>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi!

On Thu, Apr 4, 2024 at 4:02=E2=80=AFPM Alexey Romanov
<avromanov@salutedevices.com> wrote:
> > > +#include <ubi_uboot.h>
> > >  #include <dm/device_compat.h>
> > >  #include <dm/devres.h>
> > >  #include <dm/uclass.h>
> > > @@ -1182,8 +1183,13 @@ static int spinand_bind(struct udevice *dev)
> > >  {
> > >         if (blk_enabled()) {
> > >                 struct spinand_plat *plat =3D dev_get_plat(dev);
> > > +               int ret;
> > > +
> > > +               ret =3D mtd_bind(dev, &plat->mtd);
> > > +               if (ret)
> > > +                       return ret;
> > >
> > > -               return mtd_bind(dev, &plat->mtd);
> > > +               return ubi_bind(dev);
> >
> > Is this expecting the entire SPI-NAND covered by a single UBI partition=
?
>
> Why? Nah.

I can't find the code it's patching in my outdated local tree and
made a wrong guess. Sorry for my ignorance.

> ubi_bind() just create block device and bind it to SPI-NAND device.
> When working with this block device user must specify, which SPI-NAND
> partition UBI is located on.
>

And thanks for the explanation!

--=20
Regards,
Chuanhong Guo
