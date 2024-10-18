Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF43D3E1AC
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 04:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A0CA88ED2;
	Sat, 19 Oct 2024 06:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gciukd6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B603288DA0; Fri, 18 Oct 2024 23:58:13 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5936F88BB2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 23:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e2977cf16f9so421265276.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729288690; x=1729893490; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hfq03oLDO0ucCauVCowte60CE2qL4QOaLpptHiCUMeE=;
 b=gciukd6r2hlOiSM+zBLE+x2d6x8r8My/VXuallZh3MBJdd8XUaxQrruTi3tNDeL0Lo
 ESuk5H+LOK0vRtuL8L9pfp33vGPOVH0sHPoNs1K/XPc8M4CgRjSWNlPxhyrZFS9ETPb5
 2CUS85kTz+fwmP0UTf9WjPJ1Rcqm8dijzKz/A8Hgv9jMFijMh6j+SudWJYxkobutV2Om
 ArlRA/ioqiZlMCTByX1udg4sUNwA+BDla2qLLx+InpbnWtnRVmeiYHTeX4QQcGGUWW1q
 YiXLlpMuhAma+magSDqz1lh8RqpHnxP3GCkG745I6CkVrsQWut3cx1NH0PJpdpmSRGWd
 kbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729288690; x=1729893490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hfq03oLDO0ucCauVCowte60CE2qL4QOaLpptHiCUMeE=;
 b=Pwb2TZzQL/lhxux4K36gWTKSuUsdSSsGqL5ALJyKfHTOYe2y3qtxkCoGtLJQwIAAEU
 PNFtxB3tVc1LyMSPDzHtBJzILCerP9H5XgVO7kT2efoh5nVQRRZY00pqg9ClNZkFIibT
 O0mutbES9DUSWk7gYseeduIDM+SOEmqFjW/pfBS780VTncnVgld8G9klzY4DocFysw7C
 /NP6QW+L+PERh8aiDmdy0MIlCMtBUif4Z2ZpPvoiFekRIJQS9nVIqrk6WTQk8qaN4+hv
 arO2dcNlyQazR1J0FW29+sBqsC/jJrkTGO43jIVt/mg4pdG9488LTU+2PI54vbW1Em/y
 7s+Q==
X-Gm-Message-State: AOJu0Yy/5VseTVTk63A/3qQHkRS53+luQmETK327Ke5fX1wJwD05lX7K
 aAqqfoTmosUcSixBCcrT6iK9e3MZtGh2nvNV4ZtTpqwtkDliDv3ZkPJ+s0/AzrRElV4V3ZG3qoJ
 hRuQ4JVCdwSa0C1rlxYfoCMDrRXg=
X-Google-Smtp-Source: AGHT+IF5y1AJQqywv6kDzXooF+DzucwNz9olQ5vEVT2q7V6mHbF788NYN6UMXQJ8+nqBw3ia/pyUbmENt3DiTU+2e1c=
X-Received: by 2002:a05:690c:3349:b0:6e3:2dc0:1c9b with SMTP id
 00721157ae682-6e5bfc5d6f5mr18693727b3.8.1729288690209; Fri, 18 Oct 2024
 14:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
 <20241013143232.2090645-4-l.rubusch@gmail.com>
 <5e52d3d1-51d7-4e93-b5ad-b3782e157dac@denx.de>
In-Reply-To: <5e52d3d1-51d7-4e93-b5ad-b3782e157dac@denx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Fri, 18 Oct 2024 23:57:34 +0200
Message-ID: <CAFXKEHYQ6vsuNv31cMkx_pCnRThZwUitVZR3ptQVUrcYxVeKjQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] ARM: dts: socfpga: add Mercury+ AA1 for u-boot dts
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com, sumit.garg@linaro.org, sjg@chromium.org, 
 xypron.glpk@gmx.de, michal.simek@amd.com, jit.loon.lim@intel.com, 
 barnas@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 19 Oct 2024 06:39:29 +0200
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

On Mon, Oct 14, 2024 at 8:42=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 10/13/24 4:32 PM, Lothar Rubusch wrote:
>
> [...]
>
> > diff --git a/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts b/a=
rch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
> > new file mode 100644
> > index 0000000000..1b29ab9358
> > --- /dev/null
> > +++ b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
> > @@ -0,0 +1,86 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > +/*
> > + * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
> > + */
> > +
> > +/dts-v1/;
> > +
> > +/* The arria10 family */
> > +#include "socfpga/socfpga_arria10_mercury_aa1.dtsi"
> > +
> > +/ {
> > +     aliases {
> > +             ethernet0 =3D &gmac0;
> > +             serial0 =3D &uart0;
> > +             serial1 =3D &uart1;
> > +             i2c0 =3D &i2c1;
> > +             i2c1 =3D &i2c0;
> > +             spi0 =3D &qspi;
> > +     };
> > +};
> > +
> > +&qspi {
> > +     bootph-all;
> > +     status =3D "okay";
> > +     flash0: s25fl512s@0 {
> > +             bootph-all;
> > +
> > +             cdns,page-size =3D <256>;
> > +             cdns,block-size =3D <16>;
> > +
> > +             cdns,tshsl-ns =3D <200>;
> > +             cdns,tsd2d-ns =3D <255>;
> > +             cdns,tchsh-ns =3D <20>;
> > +             cdns,tslch-ns =3D <20>;
> > +     };
> > +};
> > +
> > +/* Carrier board support */
> > +#if IS_ENABLED(CONFIG_ENCLUSTRA_PE1)
> > +# include "socfpga/socfpga_enclustra_mercury_pe1.dtsi"
> > +#elif IS_ENABLED(CONFIG_ENCLUSTRA_PE3)
> > +# include "socfpga/socfpga_enclustra_mercury_pe3.dtsi"
> > +#elif IS_ENABLED(CONFIG_ENCLUSTRA_ST1)
> > +# include "socfpga/socfpga_enclustra_mercury_st1.dtsi"
> > +#endif
>
> Can this be moved to socfpga_arria10_mercury_aa1-u-boot.dtsi instead ,
> as this is likely not going to be part of the upstream
> socfpga_arria10_mercury_aa1.dts ?

I may try to put more of this content into a ...-u-boot.dtsi and then
try to take more advantage out of the u-boot DT generation process. I
will have a look on what I could improve to match the u-boot DT
generation approach still a bit better.

I was orienting myself a bit by the other arria10 devices there. But I
think .dts in dts/upstream will definitely not work with the current
approach, and as a .dts file due to this bitstream loading and muxing
situation needed to be done in SPL and u-boot only. I'll see if I can
figure out.
