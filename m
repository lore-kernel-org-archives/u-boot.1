Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E124AD6A25B
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 23:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC52789313;
	Fri, 15 Nov 2024 00:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LwGOscjo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 372B089696; Fri, 15 Nov 2024 00:28:03 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA3989313
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 00:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cf872ecce7so836752a12.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 15:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731626880; x=1732231680; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wAGS/4F8VnYzPgI8XC5XVI2yJIs/Mqr9vFhvV7rwv4=;
 b=LwGOscjoXt6ysU9oqRguRP2cDtiirjfmodwxAMpYerCTethH33ciBd4Y1RXqhe5QWB
 aTvrmbzC7goHCpGPge0qhKyrO37gNeFdUrEE67DE1oIWRKryZIXnl5vLozT2iZ7rEWpA
 TsHlgkg4CG5NkwyUWXBq4/9LimmuXsS7/fPT8DnRkfIX1ZEdxRYO/tcla6O9inzHYrNe
 A+9QABvuzDL+EAoudwvcd+9ptiuOLRs1twm9+TmDasZ8hCjDrgPdQAARxcgEsEypoZTG
 rjNAZGDCY5W5qUoe8mqCJn0PuvUzdMV1IL7txZqVWTuLg4rHbtIH0eVVGxEMisyj30C/
 gSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731626880; x=1732231680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wAGS/4F8VnYzPgI8XC5XVI2yJIs/Mqr9vFhvV7rwv4=;
 b=Oy82sH6EhkSJZPC3Xrzt5/zbl75Li70Nbd50Php3cgxtXtr2UTEHhI/NlgqpmoivzV
 fiYfcf4qXXdVjAOFYVXYkBdbaR5+0DxvEIIObBoImb3uxvChrLajYJmeUNR3QJiOrN1e
 WwH2nOKuFa1klbGHLDIdsraW+8BUrdNGR8ha8auUFBl/PsdVyYyv6q75y1Lfg5JTay5W
 NkN1xleeBhYCcaysXhab+GnysM5c1cTFfF646qt45Akyyw8oS3CCiIZRwvcNlvkPsZUp
 bRnUqCv/YPWnR7LeQNOROvlYcdnFcDhPSUKXkYcdYUfAA+oWgT+6f3Ofdre64V5uFtsZ
 ehKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeD75gh2G7QnyyOYlIiyxAUeHntxXlPBIYJKlthkGw6+UndvXSUK8iUWBPKWkxp105atwub9o=@lists.denx.de
X-Gm-Message-State: AOJu0YzbacB/uIMH+lZi/B84PAGklGKiyJY+ZyhqSwYtLA4KtppCeXP7
 pDnQpRJ8ez8czwDoPZpCZy5Ahx7NrS6q/dIgDKcUucUlhkh+4G93DwvVOcUEb1elDbO6BMrV7j9
 S3uj1Ypa+wOHB41CAev1QZxtTnjw=
X-Google-Smtp-Source: AGHT+IFMr6KOhnbjeVmljN2a4zcF4kxXc8NGg/YgL0wpWVE9X6xqA0EPJcUrsupmNFpA+ZjvC3s9JOmElgSvIxb4z+E=
X-Received: by 2002:a05:6402:518d:b0:5cf:e43:7695 with SMTP id
 4fb4d7f45d1cf-5cf8fc38890mr253746a12.11.1731626880275; Thu, 14 Nov 2024
 15:28:00 -0800 (PST)
MIME-Version: 1.0
References: <DM5PR0102MB3477A6AC67623306D970177980AC2@DM5PR0102MB3477.prod.exchangelabs.com>
 <BYAPR01MB38307E0A0D8A480B35F122F6805B2@BYAPR01MB3830.prod.exchangelabs.com>
 <20241114145636.GF3600562@bill-the-cat>
 <868d9f51-0d84-4c22-abdc-95cd60184465@amd.com>
 <20241114163354.GH3600562@bill-the-cat>
 <CAJaLiFyw5jba5g=8h6R_aB26wqJvdN9eLvu3T6FJBBpm4LkzhA@mail.gmail.com>
 <20241114203349.GM3600562@bill-the-cat>
In-Reply-To: <20241114203349.GM3600562@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 14 Nov 2024 15:27:48 -0800
Message-ID: <CAJaLiFz+ja_qChEYg-KPh5uydp6Y_nXGv_9FF61W15pzPcpNMQ@mail.gmail.com>
Subject: Re: ZDI-CAN-24679: New Vulnerability Report
To: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Thomas Weber <weber@corscience.de>, 
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
 Phil Sutter <phil@nwl.cc>, Siddarth Gore <gores@marvell.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Heiko Schocher <hs@denx.de>, Evgeni Dobrev <evgeni@studio-punkt.com>,
 Ilko Iliev <iliev@ronetix.at>, Dave Purdy <david.c.purdy@gmail.com>,
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

Hi Tom,
Hi Stefan,

I've trimmed down the CC list a bit.

On Thu, Nov 14, 2024 at 12:33=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Nov 14, 2024 at 12:18:49PM -0800, Tony Dinh wrote:
> > Hi Tom,
> > Hi Stefan,
> >
> > On Thu, Nov 14, 2024 at 8:33=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Nov 14, 2024 at 04:07:15PM +0100, Michal Simek wrote:
> > >
> > > > Hi,
> > > >
> > > > On 11/14/24 15:56, Tom Rini wrote:
> > > > > On Thu, Nov 14, 2024 at 04:02:29AM +0000, zdi-disclosures@trendmi=
cro.com wrote:
> > > > >
> > > > > > Hi,
> > > > > > Do you have any updates to share regarding this vulnerability r=
eport?
> > > > >
> > > > > Michal, microblaze-generic is the most active platform that enabl=
es
> > > > > FS_JFFS2 by default and so vulnerable here. Can you find some res=
ources
> > > > > to look in to fixing this please? Thanks.
> > > >
> > > > We have actually discussed this recently and we have other issues w=
ith jffs2
> > > > and not going to fix it or recommend to use it.
> > > > JFFS2 should be removed from our configs and it is also not under o=
ur regression.
> > >
> > > Ah OK, thanks. Adding a few more maintainers now then.
> >
> > Does this affect only boards that explicitly use CMD_JFFS2? how about
> > boards that have not been converted to bootstd and still use "nand
> > read" like this:
> >
> > include/configs/openrd.h
> >
> > #define CFG_EXTRA_ENV_SETTINGS  "x_bootargs=3Dconsole=3DttyS0,115200 " =
\
> >         CONFIG_MTDPARTS_DEFAULT " rw ubi.mtd=3D2,2048\0" \
> >         "x_bootcmd_kernel=3Dnand read 0x6400000 0x100000 0x300000\0"   =
   \
>
> It's a problem for boards which read from JFFS2 in U-Boot, yes. So in
> the case of the kernel / etc being read from a raw location (or ubi or
> what-have-you), if FS_JFFS2 (or CMD_JFFS2, same list of platforms) is
> disabled the problem goes away. And if we're down to just a few lightly
> used platforms, we can just drop JFFS2 support. Thanks!
>
> --
> Tom

I did a survey. Currently, we have 27 boards that use JFFS2. In that,
I can take care of 15 boards (1 Armada XP and 14 Kirkwood).

- 10 boards with trivial changes (just remove JFFS2 from defconfigs)

configs/dns325_defconfig:CONFIG_CMD_JFFS2=3Dy
configs/dockstar_defconfig:CONFIG_CMD_JFFS2=3Dy
configs/goflexhome_defconfig:CONFIG_CMD_JFFS2=3Dy
configs/guruplug_defconfig:CONFIG_CMD_JFFS2=3Dy
configs/iconnect_defconfig:CONFIG_CMD_JFFS2=3Dy
configs/nas220_defconfig:CONFIG_CMD_JFFS2=3Dy
configs/nsa310s_defconfig:CONFIG_CMD_JFFS2=3Dy
configs/nsa325_defconfig:CONFIG_CMD_JFFS2=3Dy
configs/pogo_v4_defconfig:CONFIG_CMD_JFFS2=3Dy
configs/pogo_e02_defconfig:CONFIG_CMD_JFFS2=3Dy

- Four boards (actually 2 boards, openrd has 3 variations) need
convert to bootstd and remove JFFS2

configs/openrd_base_defconfig:CONFIG_CMD_JFFS2=3Dy
configs/openrd_client_defconfig:CONFIG_CMD_JFFS2=3Dy
configs/openrd_ultimate_defconfig:CONFIG_CMD_JFFS2=3Dy
configs/sheevaplug_defconfig:CONFIG_CMD_JFFS2=3Dy

- One board needs to remove legacy boot sequence and remove JFFS2
(bootstd already done)

configs/ds414_defconfig:CONFIG_CMD_JFFS2=3Dy

Hopefully someone will take care of the 12 remaining boards.

All the best,
Tony
