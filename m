Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9502C0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 13:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C108812C0;
	Mon, 27 Jan 2025 14:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WeFSQ640";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 448708111F; Mon, 27 Jan 2025 11:30:48 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC7B581115
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 11:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e54dbb2ea3fso771450276.0
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 02:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737973845; x=1738578645; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iNe01TpBhmdcNxveT5bLBGYmtuqfW8FdFflaX/dwIA=;
 b=WeFSQ640l6yuP67LFThynXHUIB+sHdwXhAUIk9f6b96yBirTtt0KPzkaXFoTFYJzn1
 3W7VxIdJ6C9MRDFOss4bu//N51golndW6Hipx4J5N38JtGctNOvtadCG9HRqME9iq8Xn
 HkCgoEN035AfPWx22jdl4AFr497Gbjb9xxZVz5FHv4MLAUlQO4DrK5DAteLGi40TyTwP
 4TGELIuA/wwvxzkOAaeN24naa8jw7oYJnvUbb/xO2+8aWwb7pG2c2ypJXgflDIMnbB3s
 iZXAuVdKjVKLIlOBKU4ZxnYtc4i0vij6RSlolFRUtWad2f9ZQmEKIipoHaib2mUQmoy1
 Kp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973845; x=1738578645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7iNe01TpBhmdcNxveT5bLBGYmtuqfW8FdFflaX/dwIA=;
 b=FZjk84lzKr9a+6UrG7ZEt6k57/Banq8oLjRsAP/VAER8gunffaJBSBqXJwNz2f5WFd
 JioGNnQgbEDnLIG28293SMDTv0IFIRm1mc39+03LXrMqYxEE+SG3xHtO6UPvhCcAC+XP
 XTxE2idVfTjJheEQVXZ72SCDvU2e8QeIytcMRev1YQAbGvXVvlALSVXov9Y350G+hE1C
 Y+cHd4y6/V2llgrm4ZVipiRLgu3lSagJU+lj0tFLb3KIWfe0YZkhBgkBgpqryZsiDxnf
 JIm4q83m5ZTQN9BoFAEV+2wVtsinrnWnT5mnwRZVErja06WaQIWYPqrCMCC/U4s4482z
 1Xeg==
X-Gm-Message-State: AOJu0YwBkTceDA4Liwm74SmPBoOoTKoW8A0ZpEWz9kUcQ9vXGtNaGOlR
 X3J3kVko01V4ymn08JICYmNPRQDYtx+rUCRYnCOl+e37B4Prc+rdPTXgR5uh9cZDx5cTl5SW14R
 gv/n0F1vx8NKxzXDRoCEhaX8Mc2U=
X-Gm-Gg: ASbGncv3stzDfgw6XxHdNMfVX9sEybkAYNCfFrGJyOwAKj2fv33hUfP5QePhctdbOcn
 qCmjSXxEA0nCc2tPnqAOv3/Ml98to4QS1dbdTGYwr0+4Ah/KN1zulQVWLypwB2Q==
X-Google-Smtp-Source: AGHT+IFmbep0JMUl2U79IEbt9YOHvgXAu5/3aD+SIJqeU0i7xTAXlkPmlHN6Dl9eN68HjJxi1qbkYfuQal2KfV2JoIw=
X-Received: by 2002:a05:6902:d43:b0:e39:80e2:48da with SMTP id
 3f1490d57ef6-e58119fccfbmr7033898276.6.1737973844726; Mon, 27 Jan 2025
 02:30:44 -0800 (PST)
MIME-Version: 1.0
References: <20241119224643.27692-4-l.rubusch@gmail.com>
 <DM8PR11MB55929EF6AD9A39B38967126CD2E12@DM8PR11MB5592.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB55929EF6AD9A39B38967126CD2E12@DM8PR11MB5592.namprd11.prod.outlook.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 27 Jan 2025 11:30:08 +0100
X-Gm-Features: AWEUYZmpOZ673FcZ0qNaPk3H6KgrrAxLDSbnu6GJPodRDu4-5iFPApyQ8XyU_30
Message-ID: <CAFXKEHbjzKqv74iN2v4PG7Zb0TqVh+8aqMsVQNhUKNd5zHq3Hg@mail.gmail.com>
Subject: Re: [PATCH v4 v5 03/10] ARM: dts: socfpga: add Mercury+ AA1 for
 u-boot dts
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "marex@denx.de" <marex@denx.de>, 
 "simon.k.r.goldschmidt@gmail.com" <simon.k.r.goldschmidt@gmail.com>, 
 "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>, 
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "michal.simek@amd.com" <michal.simek@amd.com>, 
 "Lim, Jit Loon" <jit.loon.lim@intel.com>,
 "barnas@google.com" <barnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 27 Jan 2025 14:02:41 +0100
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

On Wed, Jan 22, 2025 at 5:35=E2=80=AFAM Chee, Tien Fong
<tien.fong.chee@intel.com> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Lothar Rubusch
> > <l.rubusch@gmail.com>
> > Sent: Wednesday, November 20, 2024 6:47 AM
> > To: u-boot@lists.denx.de; trini@konsulko.com; marex@denx.de;
> > simon.k.r.goldschmidt@gmail.com; tien.fong.chee@intel.com;
> > sumit.garg@linaro.org
> > Cc: sjg@chromium.org; xypron.glpk@gmx.de; michal.simek@amd.com;
> > jit.loon.lim@intel.com; barnas@google.com; l.rubusch@gmail.com
> > Subject: [PATCH v4 v5 03/10] ARM: dts: socfpga: add Mercury+ AA1 for u-
> > boot dts
> >
> > Introduce u-boot specific device-tree files for Enclustra Mercury+ AA1 =
SoMs
> > (Intel/arria10).
> >
> > Generic device-tree fragments for linux and U-boot shall be provided in
> > dts/upstream. The selection of the generic device-tree fragments depend=
s
> > on a selected boot-mode and a selected carrier board.
> >
> > On Intel/Arria10 a handoff setup is needed for initialization of variou=
s clock /
> > pinmux / DRAM settings only used by U-Boot provided by the current patc=
h.
> >
> > Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  ..._arria10_enclustra_mercury_aa1-u-boot.dtsi |  45
> > +++  .../socfpga_arria10_enclustra_mercury_aa1.dts |  45 +++
> >  .../socfpga_arria10_mercury_aa1-u-boot.dtsi   |  19 ++
> >  .../dts/socfpga_arria10_mercury_aa1_handoff.h | 305
> > ++++++++++++++++++
> >  board/enclustra/mercury_aa1/Kconfig           |  37 +++
> >  board/enclustra/mercury_aa1/MAINTAINERS       |   2 +
> >  6 files changed, 453 insertions(+)
> >  create mode 100644 arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-
> > u-boot.dtsi
> >  create mode 100644
> > arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
> >  create mode 100644 arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
> >
> > diff --git a/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-
> > boot.dtsi b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-
> > boot.dtsi
> > new file mode 100644
> > index 0000000000..6e38286572
> > --- /dev/null
> > +++ b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
> > @@ -0,0 +1,45 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > +/*
> > + * Copyright (C) 2024 Lothar Rubusch <l.rubusch@gmail.com>  */
> > +
> > +/* Arria10 handoff (u-boot) */
> > +#include "socfpga_arria10_mercury_aa1_handoff.h"
> > +#include "socfpga_arria10-handoff.dtsi"
> > +#include "socfpga_arria10_handoff_u-boot.dtsi"
> > +#include "socfpga_arria10_mercury_aa1-u-boot.dtsi"
> > +
> > +/* Specific boot-mode (u-boot) */
> > +#if IS_ENABLED(CONFIG_ENCLUSTRA_SDMMC) ||
> > +IS_ENABLED(CONFIG_ENCLUSTRA_EMMC)
> > +
> > +/ {
> > +     fs_loader0: fs-loader {
> > +             bootph-all;
> > +             compatible =3D "u-boot,fs-loader";
> > +             phandlepart =3D <&mmc 1>;
> > +     };
> > +};
> > +
> > +&fpga_mgr {
> > +     bootph-all;
> > +     firmware-loader =3D <&fs_loader0>;
> > +     altr,bitstream =3D "fpga.itb";
> > +};
> > +
> > +#elif IS_ENABLED(CONFIG_ENCLUSTRA_QSPI)
> > +
> > +/ {
> > +     fs_loader0: fs-loader {
> > +             bootph-all;
> > +             compatible =3D "u-boot,fs-loader";
> > +             sfconfig =3D <0 0 50000000 3>;
>
> The RAW read implementation for fs_loader is not upstream yet, I afraid t=
his might not working, you want help to upstream?
>

Same answer here, as in my other reply. I appreciate your answer and
bringing it up again. If this continues, for sure there will be
technical issues. In this case I'll keep you in the loop. Thanx

> [...]
>
> Best regards,
> TF
