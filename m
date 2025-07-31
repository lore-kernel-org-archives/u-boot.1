Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED01AC87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 21:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BC5783946;
	Thu, 31 Jul 2025 23:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="gcJX+VDD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D25283952; Thu, 31 Jul 2025 23:48:27 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CD4E8393F
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 23:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6197886a6eeso434212eaf.0
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1753998503; x=1754603303; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnsG7U5m+1ePcVNwQR85n1ZqpzZsZFLr11kX6UfJP1U=;
 b=gcJX+VDDoFzzSc5dar2I35Oi9/UDVJ9TaJeAIxlC5Ej+UX+5IEbDObpOaMXBqV81/N
 QJowLB2KNpTcuj/en1wTQlWxXDIVbMdrEeQCPQ/eeIklUuAmWR4m3P9F9iJyLHbHgErf
 EfOsaIBl7NlAK/kDyLRe1vSanmzZqCQUJFl1C7FF/Y6lWInOQv6HH8hHKfv6j1XIv61N
 RjY4A7rv7oOmVOZ/VVejRNVwqeSjjab+SHDEKZRrbLhYBslvK0xxMsulabNR0kVJrCDa
 SUKhLANOsCaMCVjWPN9mF5rpamPRZAKLadyJcG4FhHlQIibPHjdN1TSHjj3slm2ZgHWV
 kSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998503; x=1754603303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gnsG7U5m+1ePcVNwQR85n1ZqpzZsZFLr11kX6UfJP1U=;
 b=bFEkxBY357PNPTC1MEMJfUtBsqv9OtRAW1xBmDLhIOlbtQhWIpClgR0nbTw0E3qLJw
 p29RzekXEILBERFAFi+HDSIab9Dj6SqkC6K5AVhoBTlDv+r45eZFUh3Jo4xe6lhCwwDb
 Dk31Oe1T8m6jYV8kt1fi3CJQsN+hfWrDvhaJfVZ59AmzyIxzIZfiVUJ2RSurJpIys/xJ
 JTPOR1YyRn2ZCI/y3izYyOj+DqpUKq/4cCIlAbtfZbFFoQDsUBp7RbLVowDJsAid67UR
 n3pa/2az+t2+omhVS3hRYcMuvQFQ6beHoXAdLLN7DOOm4k3b49dqgeyPjnK+2F93f50h
 9ngA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfdvQxAaUSE6IgY4KvEOnI1Q4O04MmeRnQCsuIyLGvDZp0PaXvuzX1o4zTwbWi5y08Oti4ap8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx02oFqsBDY6LqB47sR82xSeTLA59a6TSq0IykfLbURnXXQ1Pky
 g+MMJMHxZ/Xu4MnBhiNj0JmfIAREcfeK4n9FHfTrgW1JFcrort28LLPugrlv5+ziThECdB+/gUV
 zsNeg413LzdQsLhZsevypABf27aKuSoQAdscj+dATFQ==
X-Gm-Gg: ASbGncvALR8cxicZJPX3Sv12nh0nWwaD0JIGlzhmJD+M8K8Bff2BE4frNvf7BkBtT8W
 fmSxjD1dmNw/6wZdPjJfzhd/oS2L47ST5+hyAryLFf+kq+HT/mCCEdJrPAOuSsUs1XHXkAHhyv+
 Gb2B07VfNuxSe9quN0OGX/7J53DJqd/Jqk62oET2O47dfFBMdxybvVZY5ZM2t6r7t6ty+8qqRUl
 HCMt+o=
X-Google-Smtp-Source: AGHT+IGW00SAn7Ud1NEA5cNwf2jf96MTsxvgV+BGdrFSnjUPwsDN23250iJx4fem+BYr10smuu+zOQ7vibMATzc75Y0=
X-Received: by 2002:a05:6820:2d08:b0:611:3e54:8d0a with SMTP id
 006d021491bc7-6197060910bmr2663797eaf.1.1753998503319; Thu, 31 Jul 2025
 14:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
 <CAJ+vNU2G=CMiHc4mU4fjQEz7zwjvx_EuiWWQo8MBVHGJdmTarA@mail.gmail.com>
 <PAXPR04MB9644BC97420DB4E3D877C2E2E225A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <CAJ+vNU1asw79GMnsTxNevg+xRo-1SQ9j_f+4e-TEy4TPZ+Qt+Q@mail.gmail.com>
 <PAXPR04MB9644E7123DD43D118AF21CA9E227A@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB9644E7123DD43D118AF21CA9E227A@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 31 Jul 2025 14:48:12 -0700
X-Gm-Features: Ac12FXyE8O8I53BIPKAxZIwfiKV09FB8ZK4Lyw-FmvLbytpG1E4ILX3ZYlaiOHA
Message-ID: <CAJ+vNU0fu3WdLjrFKh++SZGFdZ7J4hvWUH_jpJH99LMXk9G+fA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] imx: add i.MX95 b0 support
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Alice Guo <alice.guo@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>
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

On Thu, Jul 31, 2025 at 2:32=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Tim Harvey <tharvey@gateworks.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B47=E6=9C=8830=E6=97=
=A5 0:03
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Alice Guo (OSS) <alice.guo@oss.nxp.com>; P=
eng Fan
> > <peng.fan@nxp.com>; Ye Li <ye.li@nxp.com>
> > =E6=8A=84=E9=80=81: Stefano Babic <sbabic@nabladev.com>; Fabio Estevam
> > <festevam@gmail.com>; dl-uboot-imx <uboot-imx@nxp.com>; Tom Rini
> > <trini@konsulko.com>; u-boot@lists.denx.de; Alice Guo <alice.guo@nxp.co=
m>;
> > Jacky Bai <ping.bai@nxp.com>
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v2 0/4] imx: add i.MX95 b0 support
> >
> > On Mon, Jul 28, 2025 at 7:21=E2=80=AFPM Alice Guo (OSS) <alice.guo@oss.=
nxp.com>
> > wrote:
> > >
> > > Hi Tim,
> > >
> >
> > Hi Alice,
> >
> > Please stop top-posting in replies - It forces users to read the mail i=
n a
> > backwards order to properly understand, content gets lost and out of or=
der and
> > threads get broken.
> >
> > > A0 has been dropped.
> >
> > This is unacceptable. Had I known this series was doing this I would ha=
ve NAK'd
> > it. There was no mention in the commit log that this would drop support=
 for A0.
> > There are many vendors like myself who have A0 silicon evk's that will =
likely
> > never get upgraded and should not become bricks.
> >
> > We need to at least know how to get back to working boot firmware for A=
0. I
> > would be fine if there was just a Kconfig to select A0.
> >
> > >
> > > Please use mx95a0-ahab-container.img and the older imx-oei, and then =
you
> > can check if this change needs to be added.
> >
> > Yes, I tried mx95a0-ahab-container.img but I think you need to be more =
specific
> > with the 'older imx-oei' - there are obviously patches in the OEI's tha=
t also drop
> > support for A0. Regardless, I've gone back to the OEI that I was using =
previously
> > (lf-6.6.52-2.2.0) and I'm still not booting and reverting commit 993672=
4aa9b
> > ("imx95_evk: Add i.MX95 B0
> > support") didn't get me booting either. I'm still trying to figure it o=
ut.
>
> git clone -b master https://github.com/nxp-imx/imx-oei.git
> cd imx-oei
> make board=3Dmx95lp5 oei=3Dddr DEBUG=3D1 r=3DA0 DDR_CONFIG=3DXIMX95LPD5EV=
K19_6400mbps_train_timing_a1
> make board=3Dmx95lp5 oei=3Dtcm DEBUG=3D1 r=3DA0 DDR_CONFIG=3DXIMX95LPD5EV=
K19_6400mbps_train_timing_a1

Hi Alice,

Thanks - its good to know the OEI didn't drop support and also good to
understand something changed with the DDR configs. Note the tcm
doesn't use DDR_CONFIG so that can be dropped.

In order to restore support for IMX95 A0 silicon I also had to revert
all the changes to the imximage.cfg from commit 9936724aa9b
("imx95_evk: Add i.MX95 B0 support"):
diff --git a/arch/arm/mach-imx/imx9/scmi/imximage.cfg
b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
index c2c92174c1c..6af1c4ba628 100644
--- a/arch/arm/mach-imx/imx9/scmi/imximage.cfg
+++ b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
@@ -3,14 +3,13 @@
  * Copyright 2025 NXP
  */

-CNTR_VERSION 2
 BOOT_FROM SD
 SOC_TYPE IMX9
-APPEND mx95b0-ahab-container.img
+APPEND mx95a0-ahab-container.img
 CONTAINER
-DUMMY_DDR
 IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000
 HOLD 0x10000
+IMAGE OEI oei-m33-tcm.bin 0x1ffc0000
 IMAGE M33 m33_image.bin 0x1ffc0000
 IMAGE A55 spl/u-boot-spl.bin 0x20480000
 DUMMY_V2X 0x8b000000

So to restore A0 support we need the following:
- add a IMX95_A0 Kconfig selectable for IMX95
- use the config in imxiamge.cfg
- update doc/board/nxp/imx95_evk.rst to show differences in building
for the various versions of the imx95_evk that are out there (whatever
they may be)
imx95_19x19 with A0:
make -C imx-oei board=3Dmx95lp5 oei=3Dddr DEBUG=3D1 r=3DA0
DDR_CONFIG=3DXIMX95LPD5EVK19_6400mbps_train_timing_a1
cp imx-oei/build/mx95lp5/ddr/oei-m33-ddr.bin .
make -C imx-oei board=3Dmx95lp5 oei=3Dtcm DEBUG=3D1 r=3DA0
cp imx-oei/build/mx95lp5/tcm/oei-m33-tcm.bin .

Please put this together in a patch that has a fixes tag for commit
9936724aa9b ("imx95_evk: Add i.MX95 B0 support").

Best Regards,

Tim
