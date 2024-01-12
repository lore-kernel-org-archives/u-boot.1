Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5BAC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 380FE87937;
	Fri, 12 Jan 2024 14:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lR/Es1mV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5ED1879DB; Fri, 12 Jan 2024 14:18:36 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 674BC87883
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:18:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-337984681bcso287288f8f.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705065514; x=1705670314;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QqwuCM5QN1jMzU1O3BSNSG+3oZj3OOwERFYg0TE+7qs=;
 b=lR/Es1mVTctZOPjorJ/BzIfB6C1g5zpa36ZPWTB+bcxQih1ZAI6YUDL2w4HqxnI65V
 mdiYsdWaGu55tU+htaX09nfqNQp1MYHF5psEMnAx8wg0Lj6ccYrw6Ir8bQWCfENMTe1f
 8F131gNakMoJA58r6kntFStNvDDDszkHmm69e57VG+RkdHCvWgUr+/nw4gSk92nTdSby
 pLDdj6QBuX2iqbbI9eGB+cFzoYslZ52fpPAOrPdVurrUSu+mj8JEeH4t2NJp92M4RafS
 rlmx98+Tbvpr2Q6vHNxOC33D9x+6O+Bn91KRQnZZDfpuTvZjWZe9t7jbztBoBiVZbRjb
 b6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705065514; x=1705670314;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QqwuCM5QN1jMzU1O3BSNSG+3oZj3OOwERFYg0TE+7qs=;
 b=Q1fANnu4erZ/2lOa6AgmibXMZggshJ5efNklt9M4pqjtEdqoMDl4ALv5zqInWoUjzH
 7G3+WIPmeeasAOQscC6k3pG8M8lUw9jwqXDAmq9zCZvb1r3sLhOEVoIr++zzbqpuGAjh
 zjZUu4Y+fg7r8jLtmiFB1DfJVaQuvc5Jow77KQDn0VjHn/qKW+amocMN4VDng1rXiuBH
 o+pUI5JmYqUSB0VNrWFF6omZgfSk0sAW+H8jnLtVD4Sdw8KBpH0VTiNWxtZLq9ErPKzR
 Tb/X2VCaomtkEin66CZcRExjjeBAOtIz325RbmAbb9OEBAVLuTY91CZDXhsnuw5jg5I6
 +RlQ==
X-Gm-Message-State: AOJu0Yysa2F3B0g9c1NxiB0ZZUB/xrhpTs3lrkrJGH8PEJ7mTeVSpDMC
 hfH75qWCt9LHTXMTzvIzbLPrWvTyeQp5Lg==
X-Google-Smtp-Source: AGHT+IFlWzvjZ+UY7OnFSiUiMuLJs8HI0i9ZrFhej8R7uJrw2hQyo2I0P6JlHiQIARQS5G0dg54bfA==
X-Received: by 2002:a5d:4cc6:0:b0:336:d040:3f17 with SMTP id
 c6-20020a5d4cc6000000b00336d0403f17mr566829wrt.124.1705065513723; 
 Fri, 12 Jan 2024 05:18:33 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a5d6452000000b0033761b2de64sm3877150wrw.76.2024.01.12.05.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:18:33 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sjoerd Simons <sjoerd@collabora.com>, Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Martyn Welch <martyn.welch@collabora.com>, Roger
 Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Marcel
 Ziswiler <marcel.ziswiler@toradex.com>, Neha Malcom Francis
 <n-francis@ti.com>, Nikhil
 M Jain <n-jain1@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v4 7/7] doc: board: Add document for DFU boot on am62x SoCs
In-Reply-To: <5ee4497041ca512a11daa4323ec2d36ade06128d.camel@collabora.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-8-sjoerd@collabora.com>
 <20240112123636.2h44vbdffrjlik5g@kindling>
 <5ee4497041ca512a11daa4323ec2d36ade06128d.camel@collabora.com>
Date: Fri, 12 Jan 2024 14:18:32 +0100
Message-ID: <87zfxalmfr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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


Hi Sjoerd, Nishanth,

On Fri, Jan 12, 2024 at 13:58, Sjoerd Simons <sjoerd@collabora.com> wrote:

> On Fri, 2024-01-12 at 06:36 -0600, Nishanth Menon wrote:
>> On 09:52-20240112, Sjoerd Simons wrote:
>> >=20
>> > +DFU based boot
>> > +--------------
>> > +
>> > +To boot the board over DFU, ensure there is no SD card inserted
>> > with a
>> > +bootloader. Hold the USR switch while plugging into the Type C to
>> > boot into DFU
>> > +mode. After power-on the build artifacts needs to be uploaded one
>> > by one with a
>> > +tool like dfu-util.
>>=20
>> Don't we also need a wiped out emmc unfortunately?
>
> Nope just not having an SD card without boot artifacts is enough (or to
> keep things simple no SD card). the USR switch changes the bootmode to
> have SD as primary, DFU as fallback, so what's on the eMMC is luckily
> not relevant.
>
> So i've been happily testing with the factory eMMC image untouched to
> allow me to compare against the factory u-boot behaviour=20

I've been using DFU for quite some time on Beagle Play and I observe
the same behaviour as Sjoerd. What is on eMMC is fortunetly not relevant
to have DFU mode functional.

>
>>=20
>> > +
>> > +.. include::=C2=A0 ../ti/am62x_sk.rst
>> > +=C2=A0=C2=A0=C2=A0 :start-after: .. am62x_evm_rst_include_start_dfu_b=
oot
>> > +=C2=A0=C2=A0=C2=A0 :end-before: .. am62x_evm_rst_include_end_dfu_boot
>> > +
>> > =C2=A0Debugging U-Boot
>> > =C2=A0----------------
>> > =C2=A0
>> > diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
>> > index b12dc85f06b..904a54cd5ff 100644
>> > --- a/doc/board/ti/am62x_sk.rst
>> > +++ b/doc/board/ti/am62x_sk.rst
>> > @@ -105,6 +105,20 @@ Set the variables corresponding to this
>> > platform:
>> > =C2=A0
>> > =C2=A0* 3.1 R5:
>> > =C2=A0
>> > +.. include::=C2=A0 ../ti/k3.rst
>> > +=C2=A0=C2=A0=C2=A0 :start-after: .. k3_rst_include_start_build_steps_=
spl_r5
>> > +=C2=A0=C2=A0=C2=A0 :end-before: .. k3_rst_include_end_build_steps_spl=
_r5
>> > +
>> > +* 3.1.1 Alternatively build R5 for DFU boot:
>> > +
>> > +As the SPL size can get to big when building with support for
>> > booting both from
>> > +local storage *and* DFU an extra config fragment should be used to
>> > enable DFU
>> > +support (and disable storage support)
>> > +
>> > +.. prompt:: bash $
>> > +
>> > +=C2=A0 export UBOOT_CFG_CORTEXR=3D${UBOOT_CFG_CORTEXR}
>> > am62x_r5_usbdfu.config
>> > +
>> > =C2=A0.. include::=C2=A0 ../ti/k3.rst
>> > =C2=A0=C2=A0=C2=A0=C2=A0 :start-after: .. k3_rst_include_start_build_s=
teps_spl_r5
>> > =C2=A0=C2=A0=C2=A0=C2=A0 :end-before: .. k3_rst_include_end_build_step=
s_spl_r5
>> > @@ -251,6 +265,29 @@ https://www.ti.com/lit/pdf/spruiv7=C2=A0under the
>> > `Boot Mode Pins` section.
>> > =C2=A0
>> > =C2=A0For SW2 and SW1, the switch state in the "ON" position =3D 1.
>> > =C2=A0
>> > +DFU based boot
>> > +--------------
>> > +
>> > +To boot the board over DFU, set the switches to DFU mode and
>> > connect to the
>> > +USB Type C DRD Port on the board. After power-on the build
>> > artifacts needs to be
>> > +uploaded one by one with a tool like dfu-util.
>> > +
>> > +.. am62x_evm_rst_include_start_dfu_boot
>> > +
>> > +The initial ROM will have a DFU alt named `bootloader` for the
>> > initial R5 spl
>> > +upload. The next stages as exposed by u-boot have target alts
>> > matching the name
>> > +of the artifacts, for these a USB reset has to be done after each
>> > upload.
>> > +
>> > +When using dfu-util the following commands can be used to boot to
>> > a u-boot shell:
>> > +
>> > +.. prompt:: bash $
>> > +
>> > +=C2=A0 dfu-util -a bootloader -D tiboot3.bin
>> > +=C2=A0 dfu-util -R -a tispl -D tispl.bin
>> > +=C2=A0 dfu-util -R -a u-boot.img -D u-boot.img
>> > +
>> > +.. am62x_evm_rst_include_end_dfu_boot
>> > +
>> > =C2=A0Debugging U-Boot
>> > =C2=A0----------------
>> > =C2=A0
>> > --=20
>> > 2.43.0
>> >=20
>>=20
>
> --=20
> Sjoerd Simons
> Collabora Ltd.
