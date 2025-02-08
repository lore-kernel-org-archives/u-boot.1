Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66E6C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 19:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E095F80820;
	Sat,  8 Feb 2025 20:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vlVIKehA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 089B380821; Sat,  8 Feb 2025 20:57:01 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA904807FE
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 20:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C87C73F220
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 19:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739044617;
 bh=DDvYIUv2xUu5lCiUSPdAlFimnHmvdonYZFAlJ2EcVbQ=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=vlVIKehAaZd+ZxJcZbRHavp8dK077TETjxo15nlgapd2UTBq2ja2q0bw5MOaWCvXr
 wgExnhRVtLlpz+m6NyQpfMkHgmwgTmJ8EKe9IHjpPNzh3sm76W0l+5gF8KT4yzAo1Y
 eLNPGrzs6kf1TQ69mst8n07igv/nJ1tptzAOTYeeMTXHk3rExFJJE2+Ar+kqa1mjqR
 FrUVJtzcTGeTN/HV/mjriuMYRl5pYT1x4dLOR/beqkCYK8IJDzAFMRLSyEyb5o8xWz
 8ndyiU8Oj/HjJvlZwzHjLPEqDDlwZe1or/L7ac4wMbUtsHa92VC0UlC9+zuAJWpU6z
 MG2+pO+buCaxA==
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2f83e54432dso10318842a91.2
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 11:56:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739044616; x=1739649416;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DDvYIUv2xUu5lCiUSPdAlFimnHmvdonYZFAlJ2EcVbQ=;
 b=Envkz38jTLMt45jwgOjfSeV3IdIwwm4sUqj0nC12F74qNYxeKYjYZAnRTsw3wm2teQ
 597HpWPCMHyFbQlGgapkAX0b/IKFUejIUrV5UYlB6quzHvH46ncD9xJh5fMQUVxRWwU9
 s1x7Q3lROH/fPsojKETsoNa7kqx07SpAVSHYTYIsQkYLZ7JE9JwtUBD3lNYQ7sQSkVaB
 p8hbfx234LTLhoVag+9kWJBYy8evZhXYHtepDCNTnv0Z0fcEA5RZAMpbukq8/N1nagDp
 PSHfDhMgjHASGchw+Ey2g1gMjXwHMjkUAlq6V3FCy3BCrRqfLaWAxBj2yxTQgeaLdaLE
 ICYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpPR9NOSGJ6FBY7y0GKFRwNu7vxU+d28J+hfwaLdIuX1HwAAT7zmSQjtsNDK/NmsGbZ7K9WdQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyyxbzKfABFQehXzEqe973j86TbhuN7pnxcIHIQ3nvPFkmwofdn
 SQsbGB2jRHQz0Y+vOVI3enPHkwbeL+pMKTsQcjtVoohFh617bbPaSLM2vepUbpNp1gsPGYCVOQa
 COnM74v8BeJwRPPQ93e6tP8kdbmdysG6HTMdEe8DSplpKUTm3uQQuEnQAE5S1o6aPHugE58PfIK
 Lo7aiaGrP0pd9g1JdQQED2YtKW6rvv5Q4586HM08T/rw==
X-Gm-Gg: ASbGncsvqlhvFOyhQWle6/jMMNR1eDN8kloa9crv1PFSTar03tEGUx0BoEsnICKkWCF
 BU58//CsqN840FSYT4TtEuBVlLHLo3XJfwTmw5GQyEFnl/oEyxqYur6ZJHx7Nzw==
X-Received: by 2002:a17:90b:2fce:b0:2ee:dcf6:1c8f with SMTP id
 98e67ed59e1d1-2fa2417bed3mr13540573a91.16.1739044616196; 
 Sat, 08 Feb 2025 11:56:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8OIyZkDMIpqeycrdXXxk+mR+FGbYO3mZWIfZmUxEuoccgihvfEpyRain6cfVHRezV9I3GPxP8q/Sx/vmEeXc=
X-Received: by 2002:a17:90b:2fce:b0:2ee:dcf6:1c8f with SMTP id
 98e67ed59e1d1-2fa2417bed3mr13540551a91.16.1739044615772; Sat, 08 Feb 2025
 11:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
 <20250207172116.117749-3-heinrich.schuchardt@canonical.com>
 <CAFLszTiDkiMmAaNq1KuJ-hRonJhg2-Qis2V-EZhEyamFBfuAAg@mail.gmail.com>
In-Reply-To: <CAFLszTiDkiMmAaNq1KuJ-hRonJhg2-Qis2V-EZhEyamFBfuAAg@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Sat, 8 Feb 2025 20:56:44 +0100
X-Gm-Features: AWEUYZkj6865hX_2OEZNVlB2Niwf5GOqGZQwXiweuS5Cs1588uZQe0ioKoEGvl4
Message-ID: <CAM=mAOkhXskRtmmoS5vohy3a+-MYKqYpG+nW=oVn2AfVrnhDog@mail.gmail.com>
Subject: Re: [PATCH 2/6] riscv: dts: starfive: DeepComputing FML13V01 binman
 config
To: Simon Glass <sjg@chromium.org>
Cc: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, 
 Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>,
 "E . Shattow" <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>, 
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Simon Glass <sjg@chromium.org> schrieb am Sa., 8. Feb. 2025, 18:16:

> Hi Heinrich,
>
> On Fri, 7 Feb 2025 at 10:23, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > Add the DeepComputing Framework motherboard (FML13V01) to the binman
> > include for the starfive_visionfive2_defconfig.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  arch/riscv/dts/starfive-visionfive2-binman.dtsi | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> > index 4cce001e80d..63289405fbb 100644
> > --- a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> > +++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> > @@ -16,6 +16,16 @@
> >         itb {
> >                 fit {
> >                         images {
> > +                               fdt-jh7110-deepcomputing-fml13v01 {
>
> fdt-1 is better than repeating all this information multiple times
>


Thank you for reviewing

Non-speaking references like fdt-1 lead to coding errors. This why we don't
call our C variables i0000 - i9999.


> > +                                       description =
> "jh7110-deepcomputing-fml13v01";
>
> That should be a description of the board, e.g. its marketing name.


The devicetree jh7110-deepcomputing-fml13v01.dtb has

model = "DeepComputing FML13V01";

for this JH7110 board. I could make the formatting a bit nicer.


> > +                                       load = <0x40400000>;
> > +                                       compression = "none";
> > +
> > +                                       blob-ext {
> > +                                               filename =
> "dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dtb";
>
> This should not be blob-ext. It should be using the normal:
>
>    u-boot-dtb {
>    };
>

Then probably all occurrences should be updated in this file.

Best regards

Heinrich


> > +                                       };
> > +                               };
> > +
> >                                 fdt-jh7110-milkv-mars {
> >                                         description =
> "jh7110-milkv-mars";
> >                                         load = <0x40400000>;
> > @@ -58,6 +68,13 @@
> >                         };
> >
> >                         configurations {
> > +                               conf-jh7110-deepcomputing-fml13v01 {
> > +                                       description =
> "jh7110-deepcomputing-fml13v01";
> > +                                       firmware = "opensbi";
> > +                                       loadables = "uboot";
> > +                                       fdt =
> "fdt-jh7110-deepcomputing-fml13v01";
> > +                               };
> > +
> >                                 conf-jh7110-milkv-mars {
> >                                         description =
> "jh7110-milkv-mars";
> >                                         firmware = "opensbi";
> > --
> > 2.47.1
> >
>
> Regards,
> Simon
>
