Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450AFC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 06:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE696875F5;
	Thu, 30 Nov 2023 07:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=lessconfused.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=lessconfused.com header.i=@lessconfused.com header.b="Tx6760W+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA1D3875CC; Thu, 30 Nov 2023 07:54:13 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03C1387605
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 07:54:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=lessconfused.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=da@lessconfused.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2859bde1d62so674120a91.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 22:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lessconfused.com; s=lessconfused; t=1701327249; x=1701932049;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KiOVCOUrw0mNPOXjHdGbXoYWvXgdSF5m4RB+FeANl1w=;
 b=Tx6760W+mqEVN1H45qwt7cxc1l/183hdWszxFoZkF/muObKM/bUBgeBoi/Sy0zK2oS
 gtMjvALHPjHAhm2LvvezK00qdukTjUKDAGTbKeoKwQuqIjF2D20iTCYCHr3LIPcqjOYt
 p5Ej1XGS2CVATzjh1Srh0c0rK+zC+z8Nc/ksc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701327249; x=1701932049;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KiOVCOUrw0mNPOXjHdGbXoYWvXgdSF5m4RB+FeANl1w=;
 b=DDQjf8321Xv0AyHT8wESzE75XfftUxg0PbH9aT5SAGsnHsTanUsypzaL0rimzJRSc2
 I1KbIi2xMGahGAuVv8wexg3RKycDpldHzXoqjJlYZTaE71fvF2gfLEkEIIVEQI3d/I5j
 2tmzyHGC/pF4A4j3q1X8NbiBbbYFuu9Io7Q2Oh/YqABjGNLkl9Arh5yZdk12KpeM1drv
 SR6qDNDwzF3ci/WRpHnQ+G8cdzNaFtYOMxEV0rsvFsdcDx79hRigZndvN52CmbhicI/d
 fP4Ut925F6X9uO/20/j0AeVoy/bltpkXjIjTFzQRzWx4zaDfGCc6GbZBUAALnPqfPpO2
 qA5g==
X-Gm-Message-State: AOJu0YxJUP+AlgBo10yd4KnVB/gqgnG220fDDmQgDw6qx+pv/4+xomq2
 A2iMnuK+Nmt7BpwwbbObyxgA/aFVRgmL7TqMJPZjjA==
X-Google-Smtp-Source: AGHT+IFn8Ab+aa+aTWFPkIy6u8Rl0f1LSjMrCQBsLslzyw8pxU1dE3jMZALSYjmFh+uFgkLFOP2XwEwhyN/kRwJbiVQ=
X-Received: by 2002:a17:90b:4b0f:b0:281:8e9:7b86 with SMTP id
 lx15-20020a17090b4b0f00b0028108e97b86mr20273403pjb.23.1701327249278; Wed, 29
 Nov 2023 22:54:09 -0800 (PST)
MIME-Version: 1.0
References: <20230915160130.352099-1-jbrunet@baylibre.com>
 <c7704004-3ce5-44da-8010-99157eb7b0a1@linaro.org>
In-Reply-To: <c7704004-3ce5-44da-8010-99157eb7b0a1@linaro.org>
From: Da Xue <da@lessconfused.com>
Date: Thu, 30 Nov 2023 01:53:57 -0500
Message-ID: <CACdvmAgD5geSQ_EpBgX226v4CrFt26wEBxLjz00-abSkCGfnKg@mail.gmail.com>
Subject: Re: [RFT PATCH 0/2] mmc: meson-gx: improve MMC reliabilty
To: u-boot-amlogic@groups.io, neil.armstrong@linaro.org
Cc: Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
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

On Thu, Nov 23, 2023 at 8:54=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 15/09/2023 18:01, Jerome Brunet wrote:
> > Amlogic MMC on the GX (and later) SoCs has been problematic for years,
> > especially with u-boot.
> >
> > Linux has been fairly stable for a few years. It is using a fixed phase
> > setting with Core =3D 180, Tx =3D 0 and Rx =3D 0 (the latter cannot be =
set
> > starting from the v3 MMC IPs)
> >
> > Still the results were not good with those settings with u-boot, on som=
e
> > sm1 based platforms. U-boot then started using a 270 core phase for sm1
> > only.  This worked for most sm1 platforms but problems persist on other=
s.
> >
> > The proposal with this patchset is to use 270 for the ID phase, 180
> > otherwise.  This works well on the platforms I have tested (Libretech's
> > boards and VIM3L)
> >
> > It would be great if others could test this and report whether this wor=
k
> > for them or not.
> >
> > If the results are good, this might be ported to Linux as well (... but=
 the
> > situation is less critical there)
> >
> > Jerome Brunet (2):
> >    mmc: meson-gx: clean up and align on Linux settings
> >    mmc: meson-gx: set 270 core phase during the identification
> >
> >   drivers/mmc/meson_gx_mmc.c | 50 ++++++++++++++++++-------------------=
-
> >   drivers/mmc/meson_gx_mmc.h |  9 +++++--
> >   2 files changed, 31 insertions(+), 28 deletions(-)
> >
>
> I got a regression with this patchset on the BPI M5 (SM1) SDCard, u-boot =
pytest results:
> - https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/jobs/56039368=
84
> - full HTML log: https://amlogic-foss.gitlab.io/-/amlogic-u-boot-autotest=
/-/jobs/5603936884/artifacts/test-log.html
> Same device but without the patch:
> - https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/jobs/56018995=
56
> - full HTML log: https://amlogic-foss.gitlab.io/-/amlogic-u-boot-autotest=
/-/jobs/5601899556/artifacts/test-log.html
> Same branch but on A311D gives expected results:
> - https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/jobs/56039327=
46
> - full HTML log: https://amlogic-foss.gitlab.io/-/amlogic-u-boot-autotest=
/-/jobs/5603932746/artifacts/test-log.html
>
>
> eMMC devices gets 26MHz speed instead of 52MHz, and SD reads and writes g=
ives random errors:
>
> =3D> mmc info
> Device: mmc@ffe07000
> Manufacturer ID: 15
> OEM: 0
> Name: AJTD4R
> Bus Speed: 26000000
> Mode: MMC High Speed (26MHz)
> Rd Block Len: 512
> MMC version 5.1
> High Capacity: Yes
> Capacity: 4 MiB
> Bus Width: 8-bit
> Erase Group Size: 512 KiB
> HC WP Group Size: 8 MiB
> User Capacity: 14.6 GiB WRREL
> Boot Capacity: 4 MiB ENH
> RPMB Capacity: 4 MiB ENH
> Boot area 0 is not write protected
> Boot area 1 is not write protected
>
> =3D> mmc dev 0
>   ** fs_devread read error - block
> switch to partitions #0, OK
> mmc0 is current device
> =3D> mmc read 0x00200000 0 1000
> MMC read: dev # 0, block # 0, count 4096 ... 0 blocks read: ERROR
> =3D> mmc write 0x00200000 200000 3e8
> MMC write: dev # 0, block # 2097152, count 1000 ... 0 blocks written: ERR=
OR
>
>
> I ran the test twice to be sure.

I experienced some issues with certain SD cards as well on
AML-S905D3-CC-V02. I have a bunch of SD cards and will go through
testing them later this week.

=3D> mmc dev 1
switch to partitions #0, OK
mmc1 is current device
=3D> mmc info
Device: mmc@ffe05000
Manufacturer ID: df
OEM: 2104
Name: SDBus Speed: 25000000
Mode: MMC legacy
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 58.2 GiB
Bus Width: 1-bit
Erase Group Size: 512 Bytes
=3D> mmc read $kernel_addr_r 0 10000

MMC read: dev # 1, block # 0, count 65536 ... 0 blocks read: ERROR

>
> Neil
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#1889): https://groups.io/g/u-boot-amlogic/message/188=
9
> Mute This Topic: https://groups.io/mt/102766907/1922544
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/leave/4137477/1922544/118=
3329822/xyzzy [da@lessconfused.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
