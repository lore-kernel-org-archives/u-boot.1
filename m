Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6B0E75451
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 16:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F61386C1C;
	Thu,  5 Oct 2023 18:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BmlZGNQM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30FEA86C37; Thu,  5 Oct 2023 18:31:57 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A28BB86BD6
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 18:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59f82ad1e09so13922127b3.0
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696523511; x=1697128311; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fy28HAWAIZXO7bc+ctSMSUHUfLMdmTA9UzkKRTyORcU=;
 b=BmlZGNQMjqO/DE/1r11dvVDzQ8ot52OXPso4uHzOhdcOqasa2NxKXPBZAHr8DV+MAw
 WRSb0Y7SQxdmFp5xxb1SxFIxBx9gywMV17IsdvvU270OdzXFNRbiN8w8VyCYYXRd5nqv
 hbURj8UUCxFywnqThq3VrwswmST/hrx/K/OEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696523511; x=1697128311;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fy28HAWAIZXO7bc+ctSMSUHUfLMdmTA9UzkKRTyORcU=;
 b=VRJrZawSdm+X0fPrxofGTvkyJemzAmZ+GijXHMWO1SUSM5RWB3M3evVh6QtVxu3CkX
 cqPm/1Bmyl3huibFNjR0qYZBBTHo/DDRPgetERT/mKicDbpcSYuywOaPvw83C5/O4jlk
 Srg3B4CQc30QjrGQnYZdUpEHCDYaKgOBlQUqZ/bv2rhtWNnb3UGUOeNIp0j1uP4cr/wD
 rd7xD8tSWU7nuxKGDLuodqVrYRa8b2Ar2yG+F33D9JCJhTybnOMSRfdUaOlji40cynxF
 wFou4bs5aAU8n+LELesva3UnQmOYD+nKBOo5xNyYClgun1X+GGWKtWscyJ7mL5eerY/E
 F9jw==
X-Gm-Message-State: AOJu0YyJrqhWv6TIUmCiVv5PhE08rFQ1UYUSEwUdDAzhNCpk562fWnGQ
 pA8g/9HEzam5cxczYex/f79Iyw==
X-Google-Smtp-Source: AGHT+IEcRCApAw1YryLezDh/eaAayj/WHh0QdQ7qLZvZ4LwehgdFNxiZ3iN35U3K4ZH9AXEULB121Q==
X-Received: by 2002:a81:5b82:0:b0:594:e97b:f6fa with SMTP id
 p124-20020a815b82000000b00594e97bf6famr6239677ywb.30.1696523511388; 
 Thu, 05 Oct 2023 09:31:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f1fa-53fc-3572-fce8.res6.spectrum.com.
 [2603:6081:7b00:6400:f1fa:53fc:3572:fce8])
 by smtp.gmail.com with ESMTPSA id
 c18-20020a814e12000000b005a21d290f90sm620131ywb.14.2023.10.05.09.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 09:31:50 -0700 (PDT)
Date: Thu, 5 Oct 2023 12:31:48 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Roger Quadros <rogerq@kernel.org>, nm@ti.com, vigneshr@ti.com,
 m-chawdhry@ti.com, jonas@kwiboo.se, srk@ti.com, afd@ti.com,
 bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] board: ti: am64x: Switch to standard boot flow
Message-ID: <20231005163148.GR8465@bill-the-cat>
References: <20231005130642.21402-1-rogerq@kernel.org>
 <20231005130642.21402-3-rogerq@kernel.org>
 <CAPnjgZ0uMLFdqvpcDMKnXQDL-m1ecUB33gat4EZK7jm=UeEB4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LDwWFezyV2OtySxh"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0uMLFdqvpcDMKnXQDL-m1ecUB33gat4EZK7jm=UeEB4g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--LDwWFezyV2OtySxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 09:01:42AM -0600, Simon Glass wrote:
> Hi Roger,
>=20
> On Thu, 5 Oct 2023 at 07:07, Roger Quadros <rogerq@kernel.org> wrote:
> >
> > Switch to using bootstd. Note with this change, we will stop using
> > distro_bootcmd and instead depend entirely on bootflow method of
> > starting the system up.
> >
> > Drop header files that are no longer needed in am64x_evm.h.
> > k3_dfu.h is available via k3_dfu.env in am64x.env.
> >
> > Drop unused macro CFG_SYS_SDRAM_BASE1.
> >
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > ---
> >  board/ti/am64x/am64x.env        | 1 +
> >  configs/am64x_evm_a53_defconfig | 5 +++--
> >  include/configs/am64x_evm.h     | 9 ---------
> >  3 files changed, 4 insertions(+), 11 deletions(-)
> >
> > diff --git a/board/ti/am64x/am64x.env b/board/ti/am64x/am64x.env
> > index 68e42222b7..efd736b99b 100644
> > --- a/board/ti/am64x/am64x.env
> > +++ b/board/ti/am64x/am64x.env
> > @@ -15,6 +15,7 @@ console=3DttyS2,115200n8
> >  args_all=3Dsetenv optargs earlycon=3Dns16550a,mmio32,0x02800000 ${mtdp=
arts}
> >  run_kern=3Dbooti ${loadaddr} ${rd_spec} ${fdtaddr}
> >
> > +boot_targets=3Dmmc1 mmc0 usb pxe dhcp
> >  boot=3Dmmc
> >  mmcdev=3D1
> >  bootpart=3D1:2
> > diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_de=
fconfig
> > index 718ad176cb..43bfcf957a 100644
> > --- a/configs/am64x_evm_a53_defconfig
> > +++ b/configs/am64x_evm_a53_defconfig
> > @@ -31,8 +31,9 @@ CONFIG_SPL_SPI=3Dy
> >  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> >  CONFIG_SPL_LOAD_FIT=3Dy
> >  CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x81000000
> > -CONFIG_DISTRO_DEFAULTS=3Dy
> > -CONFIG_BOOTCOMMAND=3D"run envboot; run distro_bootcmd;"
> > +CONFIG_BOOTSTD_FULL=3Dy
> > +CONFIG_BOOTSTD_DEFAULTS=3Dy
> > +CONFIG_BOOTCOMMAND=3D"run envboot; bootflow scan -lb"
> >  CONFIG_BOARD_LATE_INIT=3Dy
> >  CONFIG_SPL_MAX_SIZE=3D0x180000
> >  CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> > diff --git a/include/configs/am64x_evm.h b/include/configs/am64x_evm.h
> > index 062102a610..f9f8c7bc2f 100644
> > --- a/include/configs/am64x_evm.h
> > +++ b/include/configs/am64x_evm.h
> > @@ -9,15 +9,6 @@
> >  #ifndef __CONFIG_AM642_EVM_H
> >  #define __CONFIG_AM642_EVM_H
> >
> > -#include <linux/sizes.h>
> > -#include <config_distro_bootcmd.h>
> > -#include <env/ti/mmc.h>
> > -#include <asm/arch/am64_hardware.h>
> > -#include <env/ti/k3_dfu.h>
> > -
> > -/* DDR Configuration */
> > -#define CFG_SYS_SDRAM_BASE1            0x880000000
> > -
> >  /* Now for the remaining common defines */
> >  #include <configs/ti_armv7_common.h>
>=20
> It looks like this file still includes distro_bootcmd and defines all
> the BOOT_TARGET things. Can they be dropped? Perhaps for now they
> could be put behind an #ifdef if other boards need them?
>=20
> I suspect that with your patch as is, the environment is still full of sc=
ripts?

There's a lot of TI platforms, so I'm not sure what "#if" you're
thinking of might make it cleaner?  We could / should move some of the
still relevant content and comments from that file to
include/env/ti/ti_armv7_common.env as I do think some of the K3
platforms could just drop <configs/ti_armv7_common.h> at this point.

--=20
Tom

--LDwWFezyV2OtySxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUe5PEACgkQFHw5/5Y0
tyySBAv9H0ukthDavLgZYpcUYeXB1nGDYnh2PIPh5LyftzG9h5G6JsQjPTVNMwlk
SijACaYeb5db7Sq1ST1odwDlccmgWmex7slWVEoY9rqqWpCD2ZtkaTAX+n2Y8wEb
IRO3M0P9ONOVRRer+A9scvYFWRAq+YmGf2P+xWMP1lleUUo1WbzPJVDU2iCakL4V
p9NhExmegb29J55JuU95FbmjdqaV7EScjIL2LPd7f0emZAYptyBj4uY66e+yc/Ip
wma8SQ7UTRqG/pjpiT36lN1KzuCrDuouG4KUFKD6yrxZZTp+5Ut7BWqsGv6cyZG/
PJ627D8+Rin0i5UTLJWAxTVkTLYTjO1BUJVW0Kz4WOse1uV4iOonV/G/1UyehhfN
2FDeJCwU0Dna2m2SDr13/29e0AFsV3b/nKPo/5HDVvT3jVus7suoDn14CqpNttdL
gUw5y3gnOpnAe2kXZSNxVZE36N95AW3Pw39fLl7OXwBO+hxBSdWSS6JpWuhXy5qH
+5brEr+f
=FV7I
-----END PGP SIGNATURE-----

--LDwWFezyV2OtySxh--
