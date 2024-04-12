Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DCCC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 16:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4C868803B;
	Fri, 12 Apr 2024 18:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g7YJHr4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7150688020; Fri, 12 Apr 2024 17:27:38 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2709587F1F
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 17:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-69b5a87505cso2430146d6.2
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1712935654; x=1713540454; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SbEJNdBEgg7zteIjPRT61BO8wQHmtBNPFF5TlQkKbKo=;
 b=g7YJHr4hDbuJ6VcMNOyZfRu9/opuc2LnzGcX2P4pjdsqW6xwKNsRpwhgtVJ15/fGze
 pylpJHvdI7hIoeCgHWR6ZeZmyxEt8ZATJHYX4uOZAq90w2fpo7gRb7lH72Q4/+ou+HJc
 iNN8eh1LmIgYlPYtA0023O94APltfGbW3W7yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712935654; x=1713540454;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SbEJNdBEgg7zteIjPRT61BO8wQHmtBNPFF5TlQkKbKo=;
 b=jR3cEyqeBxl7GdvDLK/CKMosmAkMx5mK6Jr4PRvk6ksWJ8SGltAei7I95FOnx2TKm6
 OEW5XzJMkI8gSipCYAMpu3WZhQfwAo4JnUL/ENmbew6HZeRIaXPruSuuQwFIBS+ZbQG6
 eS3YFCgFKZSi9Unv+irNTSUtav4hp6wDv61G14adqA2uI4lM0wJJfcqT2G2RVw5LFiRp
 5ufBU2wqs8+SnKOaiJ/KvTADh3aZKeieB/iECSRWOCFIKIfWeJoGXy5G1mf0Mplg/Nee
 JxF2DuhKxr/Z74okD5PIBwcR48zClU5NvTbstavjFpic+5W/H3SAXip2YH+zgh+UCgDO
 5uTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Tr8KaFjVKPKOZtXjnGxb3CaoyyMlGy2d/Zfz40jpomRYpeW5Y+tj5abgE+3MI8CHKvM7UOyEu8vbyxvPzDRMx8UQLg==
X-Gm-Message-State: AOJu0Yyt2YV/tAirV7svid0q2msnRbeImXuUKksk2TMxejo3t11L8yCi
 qxOM+V9LkVaxJkfRsqsR1SYd/tOK54l8sRBKAYSWwq0NttH4GxZcggRclYsg4NkcEqMEJhJbOry
 n2KDcI97gakcydMrKNJiIots2eTSsYeCdqdjS
X-Google-Smtp-Source: AGHT+IGJKQQefkr1OCMZT+YQUVp/D1HI8E8z4+jZz882PNsanR0PyfyPLE/FkkTXry1gEPywtXO+rLndVVy0mTpZQc0=
X-Received: by 2002:a05:6214:293:b0:69b:1323:5d12 with SMTP id
 l19-20020a056214029300b0069b13235d12mr3428619qvv.38.1712935654688; Fri, 12
 Apr 2024 08:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240326200645.1182803-1-sjg@chromium.org>
 <20240408151057.1d1fcfb3@xps-13>
In-Reply-To: <20240408151057.1d1fcfb3@xps-13>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Apr 2024 09:27:23 -0600
Message-ID: <CAFLszTi1tp1-vdy2JLoarVxH_CWB8UMV+sHu=vrn4E7w62i6sw@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: mtd: fixed-partitions: Add alignment
 properties
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: devicetree@vger.kernel.org, Michael Walle <mwalle@kernel.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Rob Herring <robh@kernel.org>, 
 linux-mtd@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 12 Apr 2024 18:25:40 +0200
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

Hi Miquel,

On Mon, 8 Apr 2024 at 07:11, Miquel Raynal <miquel.raynal@bootlin.com> wrot=
e:
>
> Hi Simon,
>
> sjg@chromium.org wrote on Tue, 26 Mar 2024 14:06:44 -0600:
>
> > Add three properties for controlling alignment of partitions, aka
> > 'entries' in fixed-partition.
> >
> > For now there is no explicit mention of hierarchy, so a 'section' is
> > just the 'fixed-partitions' node.
> >
> > These new properties are inputs to the Binman packaging process, but ar=
e
> > also needed if the firmware is repacked, to ensure that alignment
> > constraints are not violated. Therefore they are provided as part of
> > the schema.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >
> > Changes in v10:
> > - Update the minimum to 2
> >
> > Changes in v9:
> > - Move binding example to next batch to avoid build error
> >
> > Changes in v7:
> > - Drop patch 'Add binman compatible'
> > - Put the alignment properties into the fixed-partition binding
> >
> > Changes in v6:
> > - Correct schema-validation errors missed due to older dt-schema
> >   (enum fix and reg addition)
> >
> > Changes in v5:
> > - Add value ranges
> > - Consistently mention alignment must be power-of-2
> > - Mention that alignment refers to bytes
> >
> > Changes in v2:
> > - Fix 'a' typo in commit message
> >
> >  .../bindings/mtd/partitions/partition.yaml    | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition=
.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > index 1ebe9e2347ea..656ca3db1762 100644
> > --- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > @@ -57,6 +57,57 @@ properties:
> >        user space from
> >      type: boolean
> >
> > +  align:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 2
> > +    maximum: 0x80000000
> > +    multipleOf: 2
> > +    description:
> > +      This sets the alignment of the entry in bytes.
> > +
> > +      The entry offset is adjusted so that the entry starts on an alig=
ned
> > +      boundary within the containing section or image. For example =E2=
=80=98align =3D
> > +      <16>=E2=80=99 means that the entry will start on a 16-byte bound=
ary. This may
> > +      mean that padding is added before the entry. The padding is part=
 of
> > +      the containing section but is not included in the entry, meaning=
 that
> > +      an empty space may be created before the entry starts. Alignment
> > +      must be a power of 2. If =E2=80=98align=E2=80=99 is not provided=
, no alignment is
> > +      performed.
> > +
> > +  align-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 2
> > +    maximum: 0x80000000
> > +    multipleOf: 2
> > +    description:
> > +      This sets the alignment of the entry size in bytes. It must be a=
 power
> > +      of 2.
> > +
> > +      For example, to ensure that the size of an entry is a multiple o=
f 64
> > +      bytes, set this to 64. While this does not affect the contents o=
f the
> > +      entry within binman itself (the padding is performed only when i=
ts
> > +      parent section is assembled), the end result is that the entry e=
nds
> > +      with the padding bytes, so may grow. If =E2=80=98align-size=E2=
=80=99 is not provided,
> > +      no alignment is performed.
>
> I don't think we should mention binman here. Can we have a software
> agnostic description? This should be understandable from anyone playing
> with mtd partitions I guess.

OK

>
> > +
> > +  align-end:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 2
> > +    maximum: 0x80000000
> > +    multipleOf: 2
>
> seems not to perfectly match the constraint, but I don't know if there
> is a powerOf keyword? (same above)

I believe this was discussed earlier. No there is no such option!

>
> > +    description:
> > +      This sets the alignment (in bytes) of the end of an entry with r=
espect
> > +      to the containing section. It must be a power of 2.
> > +
> > +      Some entries require that they end on an alignment boundary,
> > +      regardless of where they start. This does not move the start of =
the
> > +      entry, so the contents of the entry will still start at the begi=
nning.
> > +      But there may be padding at the end. While this does not affect =
the
> > +      contents of the entry within binman itself (the padding is perfo=
rmed
>
> content?                                same comment about binman?

OK

>
> > +      only when its parent section is assembled), the end result is th=
at the
> > +      entry ends with the padding bytes, so may grow. If =E2=80=98alig=
n-end=E2=80=99 is not
> > +      provided, no alignment is performed.
> > +
> >  if:
> >    not:
> >      required: [ reg ]
Regards,
SImon
