Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA516ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B64588E72;
	Tue, 10 Sep 2024 11:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C3CfRyQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC2D8880F; Tue, 10 Sep 2024 11:05:38 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFBB788F57
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-374d29ad8a7so3367435f8f.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725959132; x=1726563932; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYtihAiAeeFUfFq1Wl11n7Hzxiv8L0aqjYTSdZFK0TE=;
 b=C3CfRyQiwsCagq8lOHb4EjxEmaiwjlwIbtPKsYPodiNMuSFsq8PhR1WdpQdqogO9Fk
 fqX6sXoHuIMbatxMAm79h6QBfCy9QNenuLeNVruzg/oGk8qPWAK8vZorKQdgAHHbX+10
 regP3zMm4qJ+E3jyGbE2OGHKqOq5pCQT/HOAoGCf6wKyKUtYobWeklbuTdhRKEPZ0xhN
 aP/UTIeZTudqQvrrg2iyl4DclXXQpD9vt5QJ7e/clcWLzQui1dGDg8naQs3okZn3lSkE
 tx8blzj/UXs8XpMPWRv2uvwLd9WzYFbOMwUX64Z9pbCfIwr3aAMlDFqMBeovvutZLUko
 599Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725959132; x=1726563932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yYtihAiAeeFUfFq1Wl11n7Hzxiv8L0aqjYTSdZFK0TE=;
 b=c2YgwtnYlYEEiyRFITvj4dROJY91iAgK6RSXixXomfGaiazMmUO+pnEshfmVEVpd0e
 kYkPVcXJ53sYnkFW0+QuMmxAM+ekHDgehpi6rumDpQKV3dP0aMJvVDtS7/fjRbR38jTS
 XYs7zkk5T68qpD9BL7tBV+JodOLLV1T4vLxij/h+8UJum/IQ7/Af7NfuMnll2xpBJeN6
 U+G7fp6qeqpJdLa+uB6waXOfssQOx++Fn6OzXm+wYE6thJFpTQEKM+AxpSx6XaBEvR/l
 RxYX7ICAZug3waGRkSB0lf6TKcPhZb7G4nrULWDMb2ZqDVFWBD7cIzArkM+zcKnjgDjh
 1eSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYUkznXYi1QUX1nF720PSAzcQkp8gY1uybv+jO0Vv2GTbkS9SgwwTaRKmxHeu+N4GHtW9uErQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzPU5g9AVMa/9xU2SeeR2ENoOsEcL4xBeLliW/kEQyLaGE+uXPZ
 jG992REq+uN0GQaR1h8gq2+c1bauKj/+G9csahEwx8B0TU1+xOTp5y3jBS/DikwnSES4BsoDfUj
 rBcntPJgwNDc329Cr1Hsd1uzwoxc=
X-Google-Smtp-Source: AGHT+IFxvigfIppQilzwq4BIwn6savRiBvltAk/wDO7iILPosVyDu5/b54dAuUkrTULWSGcjQ7NmMzsaROVCSgE2LX4=
X-Received: by 2002:adf:f8c5:0:b0:374:c8e5:d568 with SMTP id
 ffacd0b85a97d-37889609f21mr7771918f8f.29.1725959131765; Tue, 10 Sep 2024
 02:05:31 -0700 (PDT)
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
 <CAPVz0n2-DCKDcVrAi00kF6yDcE2bN1mtUhzBcw7JDiZoXgzu0w@mail.gmail.com>
 <e5837ce4-0a14-4822-960d-6ab667a9f4b1@denx.de>
In-Reply-To: <e5837ce4-0a14-4822-960d-6ab667a9f4b1@denx.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 10 Sep 2024 12:05:20 +0300
Message-ID: <CAPVz0n323ktF6kb3WHR9JcE+xOzQr9-aWOR47+ZvwQr=ib18rg@mail.gmail.com>
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

=D0=BF=D0=BD, 9 =D0=B2=D0=B5=D1=80. 2024=E2=80=AF=D1=80. =D0=BE 19:13 Marek=
 Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 8/20/24 9:08 AM, Svyatoslav Ryhel wrote:
> > =D0=BF=D0=BD, 19 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE =
20:27 Marek Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On 8/1/24 2:28 AM, Marek Vasut wrote:
> >>> On 7/29/24 1:55 PM, Svyatoslav Ryhel wrote:
> >>>
> >>> [...]
> >>>
> >>>>>>> What is the problem you observe on tegra 3 ?
> >>>>>> i2c line fails since it probes in spl with your patch, but it does=
 not
> >>>>>> relocate and then probes once more after relocation. Probe fails a=
long
> >>>>>> with all devices on same line.
> >>>>>
> >>>>> Could it be that you either have to:
> >>>>> - Add DM_I2C to tegra 3 SPL
> >>>>> - Remove bootph-* from DT to remove the regulator node from SPL
> >>>>> - /delete-property/ regulator-always-on; and /delete-property/
> >>>>> regulator-boot-on; in -u-boot.dtsi to prevent the regulator from be=
ing
> >>>>> enabled in SPL ?
> >>>>>
> >>>> Obviously NO, you propose nonsense. Same dts is used for both stages=
.
> >>>
> >>> DT source yes, DT blob likely no.
> >>>
> >>>> And I have to add hack-ish stuff just because you wanna introduce co=
de
> >>>> which causes known regressions.
> >>>
> >>> I am trying to understand what problem there is on tegra 3, but it is
> >>> still not clear to me.
> >>>
> >>> Is the problem somehow related to PMICs (?) being probed in SPL (?)
> >>> because they have regulators (?) which are marked as regulator-always=
-on
> >>> ? If so, then this is correct behavior, and if this is not desired in
> >>> SPL, then you can remove this property from SPL DT in -u-boot.dtsi us=
ing
> >>> /delete-property/ .
> >>>
> >>> [...]
> >>>
> >>>> "We must not probe things as we go. There might be other
> >>>> dependencies not yet bound. It may also take some time. This is not
> >>>> following driver model design, sorry.
> >>>>
> >>>> So please think of a way to do this properly."
> >>>
> >>> What is this quote about ? Where is this from ?
> >>
> >> What is the problem with Tegra 3 and this patchset ?
> >>
> >> Can you please explain that so this patchset can move forward ?
> >>
> >
> > with your changes
> >
> > U-Boot 2024.07-00696-ge217e2769db9-dirty (Aug 20 2024 - 09:55:29 +0300)
> >
> > SoC: tegra114
> > Model: NVIDIA Tegra Note 7
> > Board: NVIDIA TegraTab
> > DRAM:  1 GiB
> > tegra_i2c_probe: called
> > i2c: controller bus 0 at 7000d000, speed 0: tegra_i2c_probe: exit
> > i2c_init_controller: speed=3D400000
> > i2c_init_controller: CLK_DIV_STD_FAST_MODE setting =3D 25
> > i2c_xfer: 2 messages
> > i2c_xfer: chip=3D0x58, len=3D0x1
> > i2c_write_data: chip=3D0x58, len=3D0x1
> > write_data:  0x37
> > pkt header 1 sent (0x10010)
> > pkt header 2 sent (0x0)
> > pkt header 3 sent (0x100b0)
> > pkt data sent (0x37)
> > tegra_i2c_write_data: Error (-1) !!!
> > i2c_write_data(): rc=3D-1
> > i2c_write: error sending
> > read error from device: bd26f8e0 register: 0x37!
>
> This seems like the PMIC driver (palmas?) is trying to read register
> 0x37 PGOOD and the I2C transfer fails . Why does the I2C transfer fail ?

You  are asking me? Because your patches break some important setup sequenc=
e.
PMIC model does not matter, all behave same way.

> You did mention something regarding I2C/PMIC driver probe timing, but it
> seems the I2C driver and PMIC drivers probe roughly around the same time
> in both pass and fail cases ?

Yes, here I agree that they both probe and probe passes, but I assume
timing of i2c call is critical and there may be some dependency which
is not ready.

> It seems the tegra3 DTs have most of the PMIC regulators marked as
> boot-on and always-on , so enabling the regulators early is the right
> thing to do.

Only essentials are added, thus they are marked this way.

>
> [...]
>
> > SoC: tegra114
> > Model: NVIDIA Tegra Note 7
> > Board: NVIDIA TegraTab
> > DRAM:  1 GiB
> > tegra_i2c_probe: called
> > i2c: controller bus 0 at 7000d000, speed 0: tegra_i2c_probe: exit
> > i2c_init_controller: speed=3D400000
> > i2c_init_controller: CLK_DIV_STD_FAST_MODE setting =3D 25
> > pkt header 1 sent (0x10010)
> > pkt header 2 sent (0x0)
> > pkt header 3 sent (0xb0)
> > pkt data sent (0x0)
> > i2c_xfer: 2 messages
> > i2c_xfer: chip=3D0x58, len=3D0x1
> > i2c_write_data: chip=3D0x58, len=3D0x1
> > write_data:  0xfb
> This seems to be access to register 0xfb , i.e. something else ?
