Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C14C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 13:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23CD5849C5;
	Thu,  2 Jul 2026 15:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EpDPy8lQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 770C6849D2; Thu,  2 Jul 2026 15:00:51 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD1E849B1
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 15:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-666275a685eso871178d50.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 06:00:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782997248; cv=none;
 d=google.com; s=arc-20260327;
 b=oHuS2L6mwGjl1MoK1+H6CciEBOsCucPNBf8vm674vfxNLpjjBd9EzNCSWn3W7HUYTz
 7azWdoDCjQnih25FCLZR0QJ/ZnRX9dR3SE5u9dWcHnTuoP9v59noq4YUI3/HNUtC+eFs
 LqLI5Tg+CNT9f42K0JRoTMXRUyv710VjoGKvEviMcMICT1gNfuEvSVBJl0Kuy/Lx6ynk
 5aAjGqt83JJ/NtplJjpA7gKL1iOdbtDYSUFx7JQYvVWp5ZdcP3VaDGacdB+aJng2SnZS
 Z4gDX3R8iolezvvyQ5xBMYDvdqEyk1tbDRvlS1w55fBL4cPCFyxKNlYETErU3syLd3a+
 Y/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=C8xaCAhDL7OJuwlHuqRu2g86ZH3thOHsRN0taq/pk04=;
 fh=4vP3ydd4CVMqQpaOvbgZs4XckJACucA7raSo/oIm1r4=;
 b=bPPf8ktQuZ094hzjdQm7zG6R/e1I2ZETGljQ1SDB+QX7kOgbphGgWONQqty7oUhbhF
 fVcmuW14wcRD7NnREYmAsrERELZG/uJ6lpT1r+Cx2Yeqfmf1MhBVZPwLRMRigrodxyzp
 XrWwpkccrBVDUUdtCcbjk3wtUwrkFbx9ZyTMH0IW4/vw7PP5Su91DPQE+9hmTMZLCwSV
 t0hsBRl1hCTpRvO+E8Mxpo5eKuMURx7pih/L8jrsDQEzz06Fy0Y4mFpkfggJPcY3Yt3j
 9HKzeJIO011m3yeZeHGr634fdqcKBesrbtTvwyf6wo7asRMjWs87gFWNb/753WFl4acp
 20wA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1782997248; x=1783602048;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8xaCAhDL7OJuwlHuqRu2g86ZH3thOHsRN0taq/pk04=;
 b=EpDPy8lQi29HBqRLOu/Uy0ODkcd4Z9dTDgT3yHdb49zDVo3imdptYnrh+/4aSQAXAr
 Meq4ONwE2cgohoxjtUD3CRGTrm3v4IMGAuniVXZ47zH1IgYTquIYGgsPOE470X0X3xF+
 J5DusN05EeiC093XAazZPYDKfNhp1GDNtJVyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782997248; x=1783602048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C8xaCAhDL7OJuwlHuqRu2g86ZH3thOHsRN0taq/pk04=;
 b=d8948g1yIBZhWKVs+BI3vPZiymGPDhdkYUR8Ex+K8936tQijTplwjzLMyD6TjNZlID
 VJSX0XxsJaKB5dtQARJ4kRel6Kb6/KW6MA2NFlXpZpk0Nb+Vzp55wJC6tqf7yb8NYfeb
 mcrQaKQBQUipDMR1xJaGa4GoXL5E9m1PRrEStNSgZYhn0no53zcEQqRRT+WocO+VpT9g
 ZSw/uF5GYp5K2uAHIrJoKwwq4stu9dcZ7aXa3aJhagV+xXeQ+EWq5YJOqOlrEXtTvPBS
 9KPEJTb18YYhqOLkUORMzPfvX9vW9XknTbP0cIi7cVGRUtVeYSj8W65TSMPZhO2cYJB/
 xX7Q==
X-Gm-Message-State: AOJu0YzI4CGKgE5qaI4MTdmDrV1yn4bE4KjWbbipDxyZbPgGvjoZTPA3
 8GfGEW9qp6MF2Qg5sqxDrkhjlx8lNTO6ETQ0aw/D1HM/+yQpbE/bAn1iCRUPh5etFS/KwxlMhmv
 W1oNUkNOE/IiEeWoe8/hyqNTgM5nI63YeFNIoLJmArw==
X-Gm-Gg: AfdE7cmmqRBpke2RpvPewhBvAOpUtXW1OPmAggwrpMjxxA0JIOUCoOUTtHx0Wlm+fSN
 JO3QqaS8rbyln1sypxPJnFSeUqIDGCAZS1RcExxMCPHGgLxzcaluXCdcBaOLbcnIGWrJ65cMZLw
 R1zV5vYJLqko62H2z3rgygcYi1VSj9BbfuiBjob6ZIjOsjQ6WP9h9bhokFtVST2k/+MbciuFN38
 1aCBGgVYT6gvoM9rz55vQEQ5Q9PbybjrWU/5sxq7w6Z0PqLF+cTh12UPn7Y9zR7kOsGqC27F9mV
 lQE6C1s4HZoy93z0Lr8/iU5UNitPtV9wHWm6
X-Received: by 2002:a05:690e:484b:b0:664:b4b6:b09c with SMTP id
 956f58d0204a3-66521a2987dmr4247564d50.6.1782997247466; Thu, 02 Jul 2026
 06:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260529153159.3944049-1-dario.binacchi@amarulasolutions.com>
 <8aab07b8-9a23-4c0d-a2f9-3943f6490a60@foss.st.com>
In-Reply-To: <8aab07b8-9a23-4c0d-a2f9-3943f6490a60@foss.st.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 2 Jul 2026 15:00:36 +0200
X-Gm-Features: AVVi8Cd1TORiw-1IRZ7FaxiJrZvkRi6T2wgDRC04ImYM4sEn8PS_fnARYqwuiG0
Message-ID: <CABGWkvoUa0AHPFmqD-AKfik8oMdBh=JD-1JUcb3cMFDovmdwmg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: stm32: add U-Boot specific dtsi for
 stm32mp157f-dk2
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 michael@amarulasolutions.com, Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
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

Hi Patrice

On Mon, Jun 29, 2026 at 9:29=E2=80=AFAM Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
>
>
> On 5/29/26 17:31, Dario Binacchi wrote:
> > The STM32MP157F-DK2 board is a direct derivative of the STM32MP157C-DK2=
.
> > As explained by ST [1], the "STM32MP157F-DK2 is assembled with latest
> > STM32MP15 RevZ cut which is the only one available for new product now.
> > The major differences in this 'F' variant SoC are the increased max
> > frequency of the Cortex-A7 cores and the correction of some HW bugs
> > (Device Rev.Z, see errata ES0438)".
> >
> > On the software/architecture side, this variant utilizes SCMI (System
> > Control and Management Interface) for secure world resource management.
> > As a consequence, the underlying stm32mp15-scmi.dtsi explicitly deletes
> > several fixed clock nodes (such as clk_hse, clk_hsi, clk_lse, clk_lsi,
> > and clk_csi), making it impossible to include stm32mp157c-dk2-u-boot.dt=
si
> > without triggering compilation errors due to these missing clock labels=
.
> >
> > So let's introduce a dedicated stm32mp157f-dk2-u-boot.dtsi that directl=
y
> > defines the fwu-mdata node. This provides the necessary FWU metadata
> > configuration required to allow automatic A/B bank selection, supported
> > for STM32MP15 boards by commit 560d8f32703f ("board: st: stm32mp15:
> > support dynamic A/B bank bootup").
> >
> > [1] https://community.st.com/t5/stm32-mpus-products-and-hardware/i-m-wo=
ndering-what-s-the-difference-point-between-stm32mp157c/td-p/213460
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > ---
> >
> > Changes in v2:
> > - Drop the inclusion of stm32mp157c-dk2-u-boot.dtsi to avoid compilatio=
n
> >   errors caused by deleted clock nodes in stm32mp15-scmi.dtsi.
> > - Directly define the fwu-mdata node in stm32mp157f-dk2-u-boot.dtsi to
> >   properly support automatic A/B bank selection.
> >
> >  arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >  create mode 100644 arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
> >
> > diff --git a/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi b/arch/arm/dts/st=
m32mp157f-dk2-u-boot.dtsi
> > new file mode 100644
> > index 000000000000..77805417bfa9
> > --- /dev/null
> > +++ b/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
> > @@ -0,0 +1,11 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacch=
i@amarulasolutions.com>
> > + */
> > +
> > +/ {
> > +     fwu-mdata {
> > +             compatible =3D "u-boot,fwu-mdata-gpt";
> > +             fwu-mdata-store =3D <&sdmmc1>;
> > +     };
> > +};
>
> Hi Dario
>
> What about including stm32mp157c-dk2-u-boot.dtsi instead of defining fwu-=
mdata node ?

This was actually the approach used in v1. However, as you pointed out in t=
he
v1 thread [1], it does not build because stm32mp15-scmi.dtsi removes the
clk_hse, clk_hsi, clk_lse, clk_lsi and clk_csi labels referenced by
stm32mp157c-dk2-u-boot.dtsi.

That's why I dropped the include in v2 and defined only the fwu-mdata node
locally.

Or am I perhaps missing something?

[1] https://patchwork.ozlabs.org/project/uboot/patch/20260512071157.564081-=
1-dario.binacchi@amarulasolutions.com/

Thanks and regards,
Dario

>
> Thanks
> Patrice



--=20
Dario Binacchi
Senior Embedded Software Engineer
M. +39 328 0625246
dario.binacchi@amarulasolutions.com
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
Amarula Solutions SRL
 Via Felice Cavallotti 25D, 41012 Carpi, MO, IT
info@amarulasolutions.com
www.amarulasolutions.com
