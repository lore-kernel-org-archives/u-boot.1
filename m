Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EBAC2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 16:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFAD7884CA;
	Thu, 20 Jun 2024 18:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="RVPIT4KW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B96388361; Thu, 20 Jun 2024 18:48:54 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C52988126
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 18:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a6f09b457fdso120053866b.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 09:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1718902131; x=1719506931; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zuhHefUUm8pKU0wU1bUqlDeM6RQmXXcb16LWkj1LV2I=;
 b=RVPIT4KWAtGykrAMFjsp70haLMeNgpuQ0fl3i0zzSNI3QnFTtjZrTrPXhMtuuVXjZm
 hg0xGiiLbGsh4N88QAYoZxINPHmjjCAd412rHbe7PM5Z3KFnlAvMeSWMhvN1KeNyuzkc
 BWlcSnbADJ1rcED0ANTt921DQzVbEh598+CfMdwFYuDOP6/s6/3Ptpw47oIVvD08k/BE
 zd8FBYyhaQB6O+GFyZMr19ea66j85P670P/OBXFN0gJ0uu7XZyDVwFQeVnOciKexpPci
 rdl7GfJuhTFE5r1R1CS3sV74Hl0csA3fFF/3nFA6EHtOb/6Bnq84Pan5biFhfjpIkPBG
 9+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718902131; x=1719506931;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zuhHefUUm8pKU0wU1bUqlDeM6RQmXXcb16LWkj1LV2I=;
 b=rxSFxnInKCRFm84O5PMy0U3doPYzdZNAEXm1O5txy87ZluibeEM+LUH16qLpFxQ9RB
 e5JasKqNWa1cjIG0irX0UzxnTdCosJoVXtK72D1sKmplToDUsosYaIIBZk8rq9uAtVBN
 MQFBuZvnF1Av/nyBywH6Kj77XRptlf4mqOaq7vYxqWVQEbbZqfd1qKjoOVi7ehjGb9jD
 s+3fGuYOZ9jpanvfTmEO0uAQBlh4wnlnfb5QvZFgyEevPMqPYsMqHuxMQzemLxSDRyv7
 AK+WODAR5AcN3jJstPnsm7YfeAXlhnwNoRJyHEP7oZ8AzpdEgjqdrPrpDJYRRbC2skyU
 zg4Q==
X-Gm-Message-State: AOJu0Yy7goTq/pKkeS6cyRR59l0G1ypCXJde7C74OTGBoEb2bvsFienV
 lI5b6OUR8AGCt68aCNv8DmViIIyOwDmMnTRhfNk5qagvWJ2oc1nEDkiK0B9Iyu1ZPNPPaN6zb1q
 MSqdORcmo9BfusToykJ5D8A7zwBTJHPPmachtYQ==
X-Google-Smtp-Source: AGHT+IG/YK7lCt/BhcYSZJheGqmGA5MS3LJSB5zbfU3GsHzHNMnXHdJ0e3ycqdy65ry9myQB87RSiQ16uckmuWjxbas=
X-Received: by 2002:a17:907:8b9b:b0:a6f:b67d:959c with SMTP id
 a640c23a62f3a-a6fb67d9833mr263523266b.10.1718902130320; Thu, 20 Jun 2024
 09:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU3Ns0RVtROcChGAhfO=XbpnzwQv1SehexbgHX6ST6-Piw@mail.gmail.com>
 <e0f38bc9-bcc2-4476-a5d4-4f2efaebc0c1@arm.com>
 <CAJ+vNU0jiVb4caYeQ5HYKZ-dqxcdG1K5pPisJZpfL4q7Sc3zvA@mail.gmail.com>
 <50bfdbf9-2ab0-4111-bf2e-abe4c9ed86fb@arm.com>
 <D1R2ZW5Q12QQ.OU52AZIYS68O@walle.cc>
In-Reply-To: <D1R2ZW5Q12QQ.OU52AZIYS68O@walle.cc>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 20 Jun 2024 09:48:38 -0700
Message-ID: <CAJ+vNU2zu5jwr_jScDN3Xs9-PV0yKyPVqOLBK504i79veAu+Lw@mail.gmail.com>
Subject: Re: obscure microsd detection issue between U-Boot and kernel
To: Michael Walle <michael@walle.cc>,
 Christian Loehle <christian.loehle@arm.com>
Cc: u-boot <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Linux MMC List <linux-mmc@vger.kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
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

On Tue, Jun 4, 2024 at 1:14=E2=80=AFAM Michael Walle <michael@walle.cc> wro=
te:
>
> On Tue Jun 4, 2024 at 9:47 AM CEST, Christian Loehle wrote:
> > On 6/3/24 22:28, Tim Harvey wrote:
> > > On Mon, Jun 3, 2024 at 1:18=E2=80=AFAM Christian Loehle
> > > <christian.loehle@arm.com> wrote:
> > >>
> > >> On 5/31/24 21:47, Tim Harvey wrote:
> > >>> Greetings,
> > >>>
> > >>> I'm seeing an issue on an imx8mm board (imx8mm-venice-gw73xx) where
> > >>> for a specific set of microsd cards if I have accessed the microsd =
in
> > >>> U-Boot with UHS/1.8V the kernel will not recognize that microsd whe=
n
> > >>> scanning.
> > >>>
> > >>> The issue does not occur with all microsd cards but seems to appear
> > >>> with a large sample size of a specific card/model (Kingston SDC32 3=
2GB
> > >>> SDR104 card). I do not see a signal integrity issue on the scope.
> > >>>
> > >>> Instrumenting the kernel the issue is that the host reports a CRC
> > >>> error as soon as the first mmc_send_if_cond call which occurs in
> > >>> mmc_rescan_try_freq.
> > >>>
> > >>> I can avoid the issue by either not accessing the microsd in U-Boot=
 or
> > >>> by disabling UHS/1.8V mode in U-Boot therefore what I think is
> > >>> happening is that U-Boot leaves the card in UHS/1.8V signalling mod=
e
> > >>> and when the kernel scans it sets the voltage back to 3.3V
> > >>> standard/default and default timings then issues its clock cycles t=
o
> > >>> 'reset' the card and the card does not recognize the reset. I'm
> > >>> wondering if this is because the reset is done via clock cycles aft=
er
> > >>> the kernel has set the I/O voltage back to 3.3V when perhaps the ca=
rd
> > >>> is still in 1.8V mode (although I don't see how that would cause an
> > >>> issue)?
> > >>
> > >> It will cause an issue for many cards and might break some cards.
> > >>
> > >>>
> > >>> Is there some sort of MMC 'reset' I can/should do in U-Boot before
> > >>> booting the kernel? Has anyone encountered anything like this befor=
e?
> > >>
> > >> There is no 'switching back' to 3.3V signalling from UHS 1.8V.
> > >> The only way this can be done is therefore a full power-off.
> > >> Is that done correctly for your system?
> > >> AFAIR spec dictates 500ms of <0.5V on VCC. Note that  driving CLK/si=
gnal
> > >> lines can also sustain the card somewhat, as leakage is only limited
> > >> within operating voltage.
> > >
> > > Hi Christian,
> > >
> > > Are you saying the only way to properly reset from 1.8V is to have a
> > > VDD supply on the microSD card that can be turned off before booting
> > > to Linux? We have never had that before and never encountered
> > > something like this.
> >
> > Yes, the only safe way to use UHS-I really anyway.
>
> I can second that. And also keep in mind that the actual supply
> voltage must be below that threshold. Thus, the power-off time also
> depends on the capacitance on that supply line after the power load
> switch. There are switches with dedicated output discharge circuits
> built-in.
>
> That being said, from my experience there are cards which will work
> when switching back from 1V8 to 3V3 signalling and some don't. I
> haven't digged deeper into that topic, though.
>
> -michael
>
> > You could disable UHS for u-boot but that still leaves (potentially)
> > problematic warm-reboots of the board.
> > Having a (software-controlled) switchable regulator on SD VCC is pretty
> > common for this reason and you should be able to find it in most dts
> > for host controllers with sd-uhs-* property.
> > I'm afraid that the relevant spec section isn't available in the
> > simplified version.
> >
> > Kind Regards,
> > Christian
>

Thanks for both of your responses here!

I have a situation where I can re-create a problem switching from 1.8V
back to 3.3V with a specific card on a board that has ESD protection
between the IMX8MM host and the microSD connector (Semtech
ECLAMP2410P.TCT [1]) but works just fine on a previous revision of
that same PCB that does not have the ESD protection added. Boards with
proper ESD protection are the first time I've seen this issue occur.
Does this make sense at all?

I believe that the MMC device is 'reset' via a series of CLK cycles
with CMD/DAT non-asserted so I'm having a difficult time understanding
how this wouldn't work if the host has been reset to 3.3V.

Best Regards,

Tim
[1] https://www.semtech.com/products/circuit-protection/esd-emi-filter-devi=
ces/eclamp2410p
