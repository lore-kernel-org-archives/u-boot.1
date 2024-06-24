Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133A2C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 20:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53BE0883AD;
	Mon, 24 Jun 2024 22:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LuhU4msM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C592883BA; Mon, 24 Jun 2024 22:21:58 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33148883AD
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 22:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2c7a480c146so889645a91.2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719260513; x=1719865313; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=doQW66FgWZ6tP7oyCtB2tj8WufY+Z4vTV/6OcmdE8MY=;
 b=LuhU4msMsx/R7/PKM4wVSd0bt+3DYl8m3oD09XYrgrD0YH/nKS/l8+4YvVbRjqeEFK
 BSZ/2huXZwlxxb9SAIprqw9NZzBh2kvMxuUfl4nYYWYLBB7a3aH5ZWFC2CohU7TNIIju
 n8VZC+46lQK/OnecJJ7ifS7uApYA/x8/mjMKXCKRGNwY9GaH7xZgzXEN6LPH7i7cPEZI
 NnFi+hFW/Ht76BukduE1P7QmhA7Oy+1j2iuI9FkiD+PjzzMix0x/bnaCiESu/0MvYVwu
 9SVLfiNBIOGICGObQalGA0+SRlKERxlzYiqPDAfdP6MkImflbvDlQHSVBvt5+PS5jYmd
 XI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719260513; x=1719865313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=doQW66FgWZ6tP7oyCtB2tj8WufY+Z4vTV/6OcmdE8MY=;
 b=XQzGQCLRj68ooCjwP/9ahQ06l6+MZNWxTcwSxC/KQN70+qP0BuzSVz91rRvGwXt8wi
 1Mw07fXPATuL0uV+a6oht6idc6UC1XAgkFpflP1sXHas+XhONu2LQat93fBIuASdM2Uv
 FNwwfZ7ZZ4L7aCTBocpxKnEru+EhUR5g+rlryBugsDgVX8kf7C7RETl7novaBN079wIa
 9SHaK4Xa2mKmgR/JcbVvQmTYMXljaxazZEllhq7oOH4PCOT9gAnRtNjkuF1Vxsxct2CM
 9mSOsCdlGExOpghmLHSouNOezqQ6OjBBkcRfhsS7BYi1g6yocq0bmX75haJplhrvuCW/
 P3ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE1VobR70i8ojgqwAziGxcX0lHwPaO2dJnpdMujwhrqbwJCfIlcNj8alekCCXDPhClZd2z2LPznV15PXnhTP1fPCo1SQ==
X-Gm-Message-State: AOJu0YzBGG/Sn7M4ZOCCoUFthdFUMmEYvqOL4HqIRL6DwoaSr0yO4gZ9
 z5s4FA/ZCagAyl+yTyQo4iimi+tlNT9NPyLYo8RuU8/qC/pT1/i0Bil5xexpw/eSbAe12mCK9m1
 f3Mt+K7NGIZrQfXLwTuQIJbFM9hI=
X-Google-Smtp-Source: AGHT+IEbcmertabfqcR9zltn75jSlDjLrBrlG81wp2pceKd/CSPEHaV6gFNeTzj+XgoyWTX8h5FYe6iFT0gydsI9auQ=
X-Received: by 2002:a17:90a:fa96:b0:2c7:dfb6:dbe9 with SMTP id
 98e67ed59e1d1-2c84298b2demr6539088a91.4.1719260512565; Mon, 24 Jun 2024
 13:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU34T3gpSn0upzfK8ra5pUyVDE-CQZGaNo73btHA4pdE-A@mail.gmail.com>
 <CAHCN7xLoLecTjdThuxHH9K7KP6NVpaajyRov=TO8em2ADPmyyQ@mail.gmail.com>
In-Reply-To: <CAHCN7xLoLecTjdThuxHH9K7KP6NVpaajyRov=TO8em2ADPmyyQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 24 Jun 2024 17:21:40 -0300
Message-ID: <CAOMZO5Bicg0So555vNVz-dncviq0twWdeJmmwdLp70fP9t8KHQ@mail.gmail.com>
Subject: Re: USB OTG mode for DWC3 (ie imx8mp) host controller with usb_ether
 USB Ethernet gadget?
To: Adam Ford <aford173@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot <u-boot@lists.denx.de>, 
 Marek Vasut <marex@denx.de>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 dl-uboot-imx <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>,
 Teresa Remmet <t.remmet@phytec.de>
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

On Mon, Jun 24, 2024 at 4:54=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:

> I think some people tried to push a Type-C driver if memory serves,
> but I think it was rejected.  I don't recall the details and my memory
> is terrible.  :-)

There is a recent series from Sebastian that adds USB Type-C support:

https://lore.kernel.org/u-boot/20240604163546.60225-1-sebastian.reichel@col=
labora.com/
