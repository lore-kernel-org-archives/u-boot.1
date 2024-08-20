Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3436C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 07:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BBCD88A03;
	Tue, 20 Aug 2024 09:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="agYbpj1n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C042889FC; Tue, 20 Aug 2024 09:08:47 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64BB588D33
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 09:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-427fc97a88cso43204035e9.0
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 00:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724137725; x=1724742525; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3LJEYHA2XOTIDrht30ok10zYXLC86HjHlIy9/udnHk=;
 b=agYbpj1newa20YTf1KYXw9JQkEAxmBKACwn9te2KydWo2EfZf8xX1sM52qHwcM+9fA
 zBZmpuu8bO09Zz6CcZB8STaRm898u9t5AICNBjxtpj/CV1R75OuXxlXkX9XefngpWaLg
 sSgrXZal5cNtMf8tB4yAOezyKmCADdqGFF4LyHHrCjlhgYoVSY+6IMXUcHC2Ue12yiNV
 7czAqmp+kI3sXFahJtZxAZpib3vsBik6nMc/Ae4h3RQBD2cYvzwRrI2SfkLVnSX4eUTx
 epLOIK9yArk7Hpx1X30UMr9PRCB5oPlN67yIMzKVa7RvpAOUtuqmZE5TaNTcXLMzr1Yv
 OmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724137725; x=1724742525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3LJEYHA2XOTIDrht30ok10zYXLC86HjHlIy9/udnHk=;
 b=rg8Y6SePRkZJcxMErfQf6PT/9J2zygotdtkZv3CGW93YSsvvJ/CeT4hdi3CXYIWgFI
 +etpyoh/Yq6edcfVmzT05bIvKn50F+YNwWBFkn1qd0bPXdOKS8GI9uvng8Tr22OLuj+K
 NXc3bZocWIV7SK5AwLEbvMx+9nd89KER/OAuynzq1o0X/otYOtBQ3cUXPwtY7aTkWQ5U
 5E5j5qyx+gfVK+oq29ZNZRXIt0w1KSTHS5jC1mrypG5nyz7501RqnmBxF79VHJqzDrf+
 +KDO6vvzcL1fqSrEhaVT2GzCvBwuy9qp5hvBRo12SKXNBgbHpQBAOigI5tK8q5TwS8mq
 qEXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNzlkTiVqRNY99T40d1WwaP0Xxo8iJuTMHFf5+9DroXULz/bMhofeDx3V1Ddbn/czyV3Wuib4=@lists.denx.de
X-Gm-Message-State: AOJu0YyyF9pRm2J/ZP8Ku+SkazMN9S1dCdDXeX0+j/zovJFqv5VespKG
 G0ieUdpv/LW4vwDhVYNUAqCOsnPYTP//Rfbgq6oCk9ygWK+bFFRFJdac/yXtYeBRrFNULdPUqNO
 DoU0z9KOGh+JxnsyMaxZ7UERcI0E=
X-Google-Smtp-Source: AGHT+IE8r+DBicErg1DATPZwGq10IxAheKv4Yxm1cs+khDD50KQXRolWl+nYSV2AAIYR3W9LpSgopMKb3ryZzrPS1zQ=
X-Received: by 2002:a5d:59a1:0:b0:371:86bc:6c05 with SMTP id
 ffacd0b85a97d-371c5fa6aeamr920676f8f.10.1724137724308; Tue, 20 Aug 2024
 00:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
 <a73dffe5-87e3-4e96-965f-9d029f2af8ed@denx.de>
 <CAPVz0n0C6TPdBRUEvJmgAUGAKoetuzr1j=0cMXweP2EqMTwn=g@mail.gmail.com>
 <0910419d-e8ab-4bf9-a083-dc2783afaca1@denx.de>
 <4D07A6E5-F156-44C3-A26D-0F2D913CE92D@gmail.com>
 <18d84528-d2e5-41d6-ae1d-109ee30853b2@denx.de>
 <CAPVz0n2Jzfih0Z85TSQbnz-8OrX4D6UN=anKGTJ=hckRt8f3xA@mail.gmail.com>
 <a95f0d60-2883-4c3d-8a53-ee3ef414cc32@denx.de>
 <CAPVz0n3Ji1sKQK+Lnq8rP3ZqwX3o-kXe2btj93UuVBa3T5C=qw@mail.gmail.com>
 <eced1020-2157-44a4-98a9-845e218529d9@denx.de>
 <45c74c58-98cf-43df-b837-c48b0341c551@denx.de>
In-Reply-To: <45c74c58-98cf-43df-b837-c48b0341c551@denx.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 20 Aug 2024 10:08:33 +0300
Message-ID: <CAPVz0n2-DCKDcVrAi00kF6yDcE2bN1mtUhzBcw7JDiZoXgzu0w@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, uboot-stm32@st-md-mailman.stormreply.com
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

=D0=BF=D0=BD, 19 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 20:2=
7 Marek Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 8/1/24 2:28 AM, Marek Vasut wrote:
> > On 7/29/24 1:55 PM, Svyatoslav Ryhel wrote:
> >
> > [...]
> >
> >>>>> What is the problem you observe on tegra 3 ?
> >>>> i2c line fails since it probes in spl with your patch, but it does n=
ot
> >>>> relocate and then probes once more after relocation. Probe fails alo=
ng
> >>>> with all devices on same line.
> >>>
> >>> Could it be that you either have to:
> >>> - Add DM_I2C to tegra 3 SPL
> >>> - Remove bootph-* from DT to remove the regulator node from SPL
> >>> - /delete-property/ regulator-always-on; and /delete-property/
> >>> regulator-boot-on; in -u-boot.dtsi to prevent the regulator from bein=
g
> >>> enabled in SPL ?
> >>>
> >> Obviously NO, you propose nonsense. Same dts is used for both stages.
> >
> > DT source yes, DT blob likely no.
> >
> >> And I have to add hack-ish stuff just because you wanna introduce code
> >> which causes known regressions.
> >
> > I am trying to understand what problem there is on tegra 3, but it is
> > still not clear to me.
> >
> > Is the problem somehow related to PMICs (?) being probed in SPL (?)
> > because they have regulators (?) which are marked as regulator-always-o=
n
> > ? If so, then this is correct behavior, and if this is not desired in
> > SPL, then you can remove this property from SPL DT in -u-boot.dtsi usin=
g
> > /delete-property/ .
> >
> > [...]
> >
> >> "We must not probe things as we go. There might be other
> >> dependencies not yet bound. It may also take some time. This is not
> >> following driver model design, sorry.
> >>
> >> So please think of a way to do this properly."
> >
> > What is this quote about ? Where is this from ?
>
> What is the problem with Tegra 3 and this patchset ?
>
> Can you please explain that so this patchset can move forward ?
>

with your changes

U-Boot 2024.07-00696-ge217e2769db9-dirty (Aug 20 2024 - 09:55:29 +0300)

SoC: tegra114
Model: NVIDIA Tegra Note 7
Board: NVIDIA TegraTab
DRAM:  1 GiB
tegra_i2c_probe: called
i2c: controller bus 0 at 7000d000, speed 0: tegra_i2c_probe: exit
i2c_init_controller: speed=3D400000
i2c_init_controller: CLK_DIV_STD_FAST_MODE setting =3D 25
i2c_xfer: 2 messages
i2c_xfer: chip=3D0x58, len=3D0x1
i2c_write_data: chip=3D0x58, len=3D0x1
write_data:  0x37
pkt header 1 sent (0x10010)
pkt header 2 sent (0x0)
pkt header 3 sent (0x100b0)
pkt data sent (0x37)
tegra_i2c_write_data: Error (-1) !!!
i2c_write_data(): rc=3D-1
i2c_write: error sending
read error from device: bd26f8e0 register: 0x37!
i2c_xfer: 2 messages
i2c_xfer: chip=3D0x58, len=3D0x1
i2c_write_data: chip=3D0x58, len=3D0x1
write_data:  0x3b
pkt header 1 sent (0x10010)
pkt header 2 sent (0x0)
pkt header 3 sent (0x100b0)
pkt data sent (0x3b)
tegra_i2c_write_data: Error (-1) !!!
i2c_write_data(): rc=3D-1
i2c_write: error sending
read error from device: bd26f8e0 register: 0x3b!
i2c_xfer: 2 messages
i2c_xfer: chip=3D0x58, len=3D0x1
i2c_write_data: chip=3D0x58, len=3D0x1
write_data:  0x61
pkt header 1 sent (0x10010)
pkt header 2 sent (0x0)
pkt header 3 sent (0x100b0)
pkt data sent (0x61)
tegra_i2c_write_data: Error (-1) !!!
i2c_write_data(): rc=3D-1
i2c_write: error sending
read error from device: bd26f8e0 register: 0x61!
i2c_xfer: 2 messages
i2c_xfer: chip=3D0x58, len=3D0x1
i2c_write_data: chip=3D0x58, len=3D0x1
i2c_xfer: chip=3D0x58, len=3D0x1
i2c_write_data: chip=3D0x58, len=3D0x1
write_data:  0x65
pkt header 1 sent (0x10010)
pkt header 2 sent (0x0)
pkt header 3 sent (0x100b0)
pkt data sent (0x65)
tegra_i2c_write_data: Error (-1) !!!
i2c_write_data(): rc=3D-1
i2c_write: error sending
read error from device: bd26f8e0 register: 0x65!
pkt header 1 sent (0x10010)
pkt header 2 sent (0x0)
pkt header 3 sent (0xb0)
pkt data sent (0xbd)
tegra_i2c_write_data: Error (-1) !!!

without your changes

U-Boot 2024.07-00696-g45c25f82f356-dirty (Aug 20 2024 - 09:58:40 +0300)

SoC: tegra114
Model: NVIDIA Tegra Note 7
Board: NVIDIA TegraTab
DRAM:  1 GiB
tegra_i2c_probe: called
i2c: controller bus 0 at 7000d000, speed 0: tegra_i2c_probe: exit
i2c_init_controller: speed=3D400000
i2c_init_controller: CLK_DIV_STD_FAST_MODE setting =3D 25
pkt header 1 sent (0x10010)
pkt header 2 sent (0x0)
pkt header 3 sent (0xb0)
pkt data sent (0x0)
i2c_xfer: 2 messages
i2c_xfer: chip=3D0x58, len=3D0x1
i2c_write_data: chip=3D0x58, len=3D0x1
write_data:  0xfb
pkt header 1 sent (0x10010)
pkt header 2 sent (0x0)
pkt header 3 sent (0x100b0)
pkt data sent (0xfb)
i2c_xfer: chip=3D0x58, len=3D0x1
inside i2c_read_data():
pkt header 1 sent (0x10010)
pkt header 2 sent (0x0)
pkt header 3 sent (0x800b1)
pkt data received (0x2)
i2c_read_data:  0x02
i2c_xfer: 1 messages
i2c_xfer: chip=3D0x58, len=3D0x2
i2c_write_data: chip=3D0x58, len=3D0x2
write_data:  0xfb 0x02
pkt header 1 sent (0x10010)
pkt header 2 sent (0x1)
pkt header 3 sent (0xb0)
pkt data sent (0x2fb)
i2c_xfer: 2 messages
i2c_xfer: chip=3D0x58, len=3D0x1
i2c_write_data: chip=3D0x58, len=3D0x1
write_data:  0xfe
pkt header 1 sent (0x10010)
pkt header 2 sent (0x0)
pkt header 3 sent (0x100b0)
pkt data sent (0xfe)
i2c_xfer: chip=3D0x58, len=3D0x1
inside i2c_read_data():
pkt header 1 sent (0x10010)

i2c driver refuses to work properly

> Thank you
