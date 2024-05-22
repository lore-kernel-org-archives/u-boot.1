Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABEAC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 17:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5914D8885B;
	Wed, 22 May 2024 19:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="FspEcBXu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A935488856; Wed, 22 May 2024 19:07:36 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF5D88869
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 19:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so2258882a12.2
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 10:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1716397653; x=1717002453; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gS6BCF6iFVerxrhO3BtTUlbYkkKWrmdOnKJK3j19zHY=;
 b=FspEcBXuoSjd7WhGXeDfXjnjax6hRgK6zvvzwF+VcJfUVd/oozsIU9pzX59+P/egyw
 H2ASE3rRB0xVYWE7BMqvooHVyNSlZ3t7joGzglJSwSoT6S2yw6CjARTg2xdoL/klpheq
 pQy7hJDpXdhpgiHCAN6BcqmqwlJqOn8UQS5ZTobpt3gsNFOhOCGqdzOjE4/I4adS9N9L
 p2XPUty8dVRNkh+K5uvdmI2N2Lucy7kyxACobTVcAco4fFVA+jsfvihR+1B3GnDfc9QO
 B8J/8/Gcyv+3FaaQtCUL8ej/3PBww4/9M1EVOrkEQvnwH9kryi5l6xd4MNlTTYjBferI
 KISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716397653; x=1717002453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gS6BCF6iFVerxrhO3BtTUlbYkkKWrmdOnKJK3j19zHY=;
 b=wuc/aNJGYQJLM7lIJDZjGHbx82kNpMTkfTvtIthueU5rf4oV1FvFKWq6IkDLuXwdMP
 BFp0MHbLOCEDPX4Zh85qAjMKbFG+U9M5qqXmwVAL7j0rsLZOhV2agxbD6Ms4oTuCNlz/
 k5/kqbxjrbejzUk1NBpBgWLCJtgX47bmS7IV2EfDJiU5CCNz8CdvPYo1ZGrC/sx9VM8I
 ysMEDdHE0iM2dPwbHPEPVRrSygCiLZCjp8TArBWGz7PQiUcjOhnJbMDm6wiLwC6Gi+RJ
 3fCk44eHYuxdHGZsT615sHVvsKbe36WtjnTO0Vz9sSxiwsxFAzdkkMDAq6TanxDvW/ED
 HRSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV39zzDTkgGRZwAspe8FJTwzX9KVT260q0ONWa2ofi/xPmL9g5S530v9FH2N5uaG9aTya/7PmJQajuwv9tXOo0nL8xfZg==
X-Gm-Message-State: AOJu0YyVijoyAyM5Wg1Blj4JgttywXeSLlFNKIXDAUzEcXIZga+jkg5W
 pBmjK1KatXfGZGaXb1A/K4RjL1ck7br3ReMZg/mRSh51g4uhQFZLpC943NE9EXaNVfTl/mFt1nz
 0t14KE3yuLdKq2oS/gXQo4ZAnnM/rWHfsd1PsWQ==
X-Google-Smtp-Source: AGHT+IFEIN4wkDXjtRuBWT+RLt1T0j0Etl/aHeGg0Yfm8vzMt1eTHiqOBxRBBJkbmJ1WpnAa7dUmdKyHtojWLIcOnmk=
X-Received: by 2002:a17:90a:df8d:b0:2b9:a299:dd03 with SMTP id
 98e67ed59e1d1-2bd9f345903mr2590866a91.1.1716397648189; Wed, 22 May 2024
 10:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240522101437.225880-1-robert.marko@sartura.hr>
 <20240522101437.225880-5-robert.marko@sartura.hr>
 <65635268-b146-4413-a926-af13687b9e7d@linaro.org>
In-Reply-To: <65635268-b146-4413-a926-af13687b9e7d@linaro.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Wed, 22 May 2024 19:07:16 +0200
Message-ID: <CA+HBbNE4Vqh0AOxySavOENYRPCoWjj2=EoqaFB0v7q+RAh5NgA@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm: dts: add IPQ4019 ESS EDMA U-Boot additions
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@linaro.org, 
 lukma@denx.de, seanga2@gmail.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, j4g8y7@gmail.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, j.beck@linefinity.com
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

On Wed, May 22, 2024 at 6:21=E2=80=AFPM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
> Hi Robert,
>
> Thanks for the patches.
>
> On 22/05/2024 12:13, Robert Marko wrote:
> > IPQ4019 ESS EDMA support is not yet in upstream Linux, and even when
> > eventually it is merged the node will not be compatible with U-Boot dri=
ver
> > as the Linux driver properly models the internal switch.
>
> Is this going to cause dtc compile errors when the node eventually does
> land upstream and gets pulled into U-Boot?

Yes, most likely the nodes will conflict.
>
> How hard would it be to adjust the U-Boot driver to work with the
> upstream bindings?

I can probably make it work with the current latest pending Linux node plus=
 some
minor U-Boot additions, I don't think the node will change much (If at
all) in newer Linux
patch series for the IPQESS driver.

Regards,
Robert
>
> Kind regards,
> >
> > So, lets add the U-Boot additions DTSI for ESS EDMA for now.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >   arch/arm/dts/qcom-ipq4019-u-boot.dtsi | 27 ++++++++++++++++++++++++++=
+
> >   1 file changed, 27 insertions(+)
> >   create mode 100644 arch/arm/dts/qcom-ipq4019-u-boot.dtsi
> >
> > diff --git a/arch/arm/dts/qcom-ipq4019-u-boot.dtsi b/arch/arm/dts/qcom-=
ipq4019-u-boot.dtsi
> > new file mode 100644
> > index 0000000000..f70ef5c9a5
> > --- /dev/null
> > +++ b/arch/arm/dts/qcom-ipq4019-u-boot.dtsi
> > @@ -0,0 +1,27 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/ {
> > +     soc {
> > +             edma: edma@c080000 {
> > +                     compatible =3D "qcom,ess-edma";
> > +                     reg =3D <0xc080000 0x8000>, <0x98000 0x800>, <0xc=
000000 0x80000>;
> > +                     reg-names =3D "edma", "psgmii_phy", "switch";
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +                     resets =3D <&gcc ESS_PSGMII_ARES>, <&gcc ESS_RESE=
T>;
> > +                     reset-names =3D "psgmii", "ess";
> > +                     clocks =3D <&gcc GCC_ESS_CLK>;
> > +                     clock-names =3D "ess";
> > +                     status =3D "disabled";
> > +
> > +                     switch_ports: switch-ports {
> > +                             phy-mode =3D "psgmii";
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&mdio {
> > +     psgmiiphy: psgmii-phy@5 {
> > +             reg =3D <5>;
> > +     };
> > +};
>
> --
> // Caleb (they/them)



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
