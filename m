Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DAFC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 21:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A22187A93;
	Thu, 14 Dec 2023 22:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MEXceueG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E1F87A8E; Thu, 14 Dec 2023 22:09:39 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6001987B3A
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 22:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a1db99cd1b2so2350666b.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 13:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702588176; x=1703192976; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnjPB6iX18JgpGdFMBMYrxpteo2U43QjbY9/lo9Je7Y=;
 b=MEXceueGXcuXjFqOdA4FvGnWzJBjIRUQJT4HP/Sj//o4WelMVcnW5beHiAvg0yPmHf
 jInmpulid6oiRdaf5dfbGJr/9BXkPXF2BCB21EQUDVxat5crRf3s+YUnmHc8nTrnh9V6
 SkaIXwDB8DK9EjbytRc1WJbM9dgfuCxij+g1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702588176; x=1703192976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnjPB6iX18JgpGdFMBMYrxpteo2U43QjbY9/lo9Je7Y=;
 b=PtGA863c69YYUjAMP8jde84a06+DGiLhXmk53wVKGKz04VjsyJ//PbOV4Vvplw1vLt
 Y8OBB4lb5+EWjYoUBYadHogm16y55ykh6oLeqPEDS2XRidFEMWLPj8dTmU7W+IlRKEka
 HJMqHQPCf0/hMS8kSnK1wSialil18tpU66mPnIQvgqiospqJrylUhY452tOrz6ymMTEj
 n3R4nb0i1uNQQnSu3EGxAHAx6ikEOSkLpOSVP7d0vPAhpxJga/ZQ/U/dkg+QQ/1XgJbM
 FtiKg6g6J3hOowojNuF6mV1pWUh4mWAhPpesbUkAo49bSESGQm3th8jHG7meS9AcKgag
 HGIg==
X-Gm-Message-State: AOJu0YyFXGfKnlGfilNGME7NHEZABdaK2Bc6lSeYetFNNb/cVv5Kj7fY
 Pf2zZ4xhbgKmAuD/eq+ZU1h+hVaNPtVVIPA8LXZqcQ==
X-Google-Smtp-Source: AGHT+IE1mZhqGInPUAvje+k24w89h1v23G78AX9kBt06f8sNc/raFxf+pFaK2GPm69Hxyl/NeGszL+XSJBb5CtBIqnE=
X-Received: by 2002:a17:907:2d12:b0:a19:9b79:8b45 with SMTP id
 gs18-20020a1709072d1200b00a199b798b45mr5234161ejc.86.1702588175444; Thu, 14
 Dec 2023 13:09:35 -0800 (PST)
MIME-Version: 1.0
References: <20231116172859.393744-1-sjg@chromium.org>
 <20231208150042.GA1278773-robh@kernel.org>
 <CAPnjgZ2i4gvgiUeHPOfHuOdBooV4e=QQEq6iMo0JbDwOS6dCwA@mail.gmail.com>
 <CAL_Jsq+xMZ8yz4H9D59uCSyX4h5W+4ruGF++=wVA=msXz+Y01A@mail.gmail.com>
 <CAPnjgZ1uW8T6woXSqFUNm301=W3zBYOrADREkrz=DuwSW87qZg@mail.gmail.com>
 <20231214172702.GA617226-robh@kernel.org>
In-Reply-To: <20231214172702.GA617226-robh@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 14 Dec 2023 14:09:24 -0700
Message-ID: <CAPnjgZ2oJSGPO91Y_aLbe+v250WFrND4n3T0mOvhERYidVu=eQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: Add binman compatible
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
 linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>, 
 Michael Walle <mwalle@kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Pratyush Yadav <ptyadav@amazon.de>, 
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org
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

Hi Rob,

On Thu, 14 Dec 2023 at 10:27, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Dec 08, 2023 at 03:58:10PM -0700, Simon Glass wrote:
> > Hi Rob,
> >
> > On Fri, 8 Dec 2023 at 14:56, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Dec 8, 2023 at 11:47=E2=80=AFAM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > On Fri, 8 Dec 2023 at 08:00, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Thu, Nov 16, 2023 at 10:28:50AM -0700, Simon Glass wrote:
> > > > > > Add a compatible string for binman, so we can extend fixed-part=
itions
> > > > > > in various ways.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v5)
> > > > > >
> > > > > > Changes in v5:
> > > > > > - Add #address/size-cells and parternProperties
> > > > > > - Drop $ref to fixed-partitions.yaml
> > > > > > - Drop 'select: false'
> > > > > >
> > > > > > Changes in v4:
> > > > > > - Change subject line
> > > > > >
> > > > > > Changes in v3:
> > > > > > - Drop fixed-partition additional compatible string
> > > > > > - Drop fixed-partitions from the example
> > > > > > - Mention use of compatible instead of label
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Drop mention of 'enhanced features' in fixed-partitions.yaml
> > > > > > - Mention Binman input and output properties
> > > > > > - Use plain partition@xxx for the node name
> > > > > >
> > > > > >  .../bindings/mtd/partitions/binman.yaml       | 68 +++++++++++=
++++++++
> > > > > >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> > > > > >  MAINTAINERS                                   |  5 ++
> > > > > >  3 files changed, 74 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/mtd/parti=
tions/binman.yaml
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/b=
inman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..329217550a98
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/binman.y=
aml
> > > > > > @@ -0,0 +1,68 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > > +# Copyright 2023 Google LLC
> > > > > > +
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: Binman firmware layout
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > > +
> > > > > > +description: |
> > > > > > +  The binman node provides a layout for firmware, used when pa=
ckaging firmware
> > > > > > +  from multiple projects. It is based on fixed-partitions, wit=
h some
> > > > > > +  extensions, but uses 'compatible' to indicate the contents o=
f the node, to
> > > > > > +  avoid perturbing or confusing existing installations which u=
se 'label' for a
> > > > > > +  particular purpose.
> > > > > > +
> > > > > > +  Binman supports properties used as inputs to the firmware-pa=
ckaging process,
> > > > > > +  such as those which control alignment of partitions. This bi=
nding addresses
> > > > > > +  these 'input' properties. For example, it is common for the =
'reg' property
> > > > > > +  (an 'output' property) to be set by Binman, based on the ali=
gnment requested
> > > > > > +  in the input.
> > > > > > +
> > > > > > +  Once processing is complete, input properties have mostly se=
rved their
> > > > > > +  purpose, at least until the firmware is repacked later, e.g.=
 due to a
> > > > > > +  firmware update. The 'fixed-partitions' binding should provi=
de enough
> > > > > > +  information to read the firmware at runtime, including decom=
pression if
> > > > > > +  needed.
> > > > >
> > > > > How is this going to work exactly? binman reads these nodes and t=
hen
> > > > > writes out 'fixed-partitions' nodes. But then you've lost the bin=
man
> > > > > specifc parts needed for repacking.
> > > >
> > > > No, they are the same node. I do want the extra information to stic=
k
> > > > around. So long as it is compatible with fixed-partition as well, t=
his
> > > > should work OK.
> > >
> > > How can it be both? The partitions node compatible can be either
> > > 'fixed-partitions' or 'binman'.
> >
> > Can we not allow it to be both? I have tried to adjust things in
> > response to feedback but perhaps the feedback was leading me down the
> > wrong path?
>
> Sure, but then the schema has to and that means extending
> fixed-partitions.

Can we cross that bridge later? There might be resistance to it. I'm
not sure. For now, perhaps just a binman compatible works well enough
to make progress.

Regards,
Simon
