Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FABBCD128A
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 13:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CA1E87DEA;
	Mon,  8 Apr 2024 15:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TYiyMgXw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E28C87FBF; Mon,  8 Apr 2024 15:11:05 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 298BE87BA8
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 15:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A7F71BF209;
 Mon,  8 Apr 2024 13:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1712581862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=irIHF5I8mXyLCKw8dni+/EZgNZOMISZkd0b9zPdDuaU=;
 b=TYiyMgXw+kQUQbK4L36ZVzZLv2VElfGQi5RM0DQOm15l7UTgnBnIa2WeyMU64WSAuJk3Hg
 CNMMw3B0XKX+E9glwfXqm0qIbnWAoc95Ny5x9NI8vCCv8xmSmGkyu9RgpHJWDTIeNIUYGR
 vCx6aUkoYFE/V4erY7lNKihCMVCNJcx88NGbr7t0aif/OiDlpaRqjJ6fjbrAZZJs4PXK/N
 El0IMjmjarmPGeFprPCSVP9ppKT+1ikNUOiLQ+5FkfQf2enZx+VhvkG9Vxju0XkMvKz5xJ
 a8ZJlglJfwPz3UzatjI5SXuHUCy8OF1MlrvbLMTZlW//jpCc2Dxo6QuRFQH0zw==
Date: Mon, 8 Apr 2024 15:10:57 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, Michael Walle <mwalle@kernel.org>, U-Boot
 Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Rob
 Herring <robh@kernel.org>, linux-mtd@lists.infradead.org, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/2] dt-bindings: mtd: fixed-partitions: Add
 alignment properties
Message-ID: <20240408151057.1d1fcfb3@xps-13>
In-Reply-To: <20240326200645.1182803-1-sjg@chromium.org>
References: <20240326200645.1182803-1-sjg@chromium.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Simon,

sjg@chromium.org wrote on Tue, 26 Mar 2024 14:06:44 -0600:

> Add three properties for controlling alignment of partitions, aka
> 'entries' in fixed-partition.
>=20
> For now there is no explicit mention of hierarchy, so a 'section' is
> just the 'fixed-partitions' node.
>=20
> These new properties are inputs to the Binman packaging process, but are
> also needed if the firmware is repacked, to ensure that alignment
> constraints are not violated. Therefore they are provided as part of
> the schema.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>=20
> Changes in v10:
> - Update the minimum to 2
>=20
> Changes in v9:
> - Move binding example to next batch to avoid build error
>=20
> Changes in v7:
> - Drop patch 'Add binman compatible'
> - Put the alignment properties into the fixed-partition binding
>=20
> Changes in v6:
> - Correct schema-validation errors missed due to older dt-schema
>   (enum fix and reg addition)
>=20
> Changes in v5:
> - Add value ranges
> - Consistently mention alignment must be power-of-2
> - Mention that alignment refers to bytes
>=20
> Changes in v2:
> - Fix 'a' typo in commit message
>=20
>  .../bindings/mtd/partitions/partition.yaml    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.y=
aml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> index 1ebe9e2347ea..656ca3db1762 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> @@ -57,6 +57,57 @@ properties:
>        user space from
>      type: boolean
> =20
> +  align:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 2
> +    maximum: 0x80000000
> +    multipleOf: 2
> +    description:
> +      This sets the alignment of the entry in bytes.
> +
> +      The entry offset is adjusted so that the entry starts on an aligned
> +      boundary within the containing section or image. For example =E2=
=80=98align =3D
> +      <16>=E2=80=99 means that the entry will start on a 16-byte boundar=
y. This may
> +      mean that padding is added before the entry. The padding is part of
> +      the containing section but is not included in the entry, meaning t=
hat
> +      an empty space may be created before the entry starts. Alignment
> +      must be a power of 2. If =E2=80=98align=E2=80=99 is not provided, =
no alignment is
> +      performed.
> +
> +  align-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 2
> +    maximum: 0x80000000
> +    multipleOf: 2
> +    description:
> +      This sets the alignment of the entry size in bytes. It must be a p=
ower
> +      of 2.
> +
> +      For example, to ensure that the size of an entry is a multiple of =
64
> +      bytes, set this to 64. While this does not affect the contents of =
the
> +      entry within binman itself (the padding is performed only when its
> +      parent section is assembled), the end result is that the entry ends
> +      with the padding bytes, so may grow. If =E2=80=98align-size=E2=80=
=99 is not provided,
> +      no alignment is performed.

I don't think we should mention binman here. Can we have a software
agnostic description? This should be understandable from anyone playing
with mtd partitions I guess.

> +
> +  align-end:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 2
> +    maximum: 0x80000000
> +    multipleOf: 2

seems not to perfectly match the constraint, but I don't know if there
is a powerOf keyword? (same above)

> +    description:
> +      This sets the alignment (in bytes) of the end of an entry with res=
pect
> +      to the containing section. It must be a power of 2.
> +
> +      Some entries require that they end on an alignment boundary,
> +      regardless of where they start. This does not move the start of the
> +      entry, so the contents of the entry will still start at the beginn=
ing.
> +      But there may be padding at the end. While this does not affect the
> +      contents of the entry within binman itself (the padding is perform=
ed

content?				same comment about binman?

> +      only when its parent section is assembled), the end result is that=
 the
> +      entry ends with the padding bytes, so may grow. If =E2=80=98align-=
end=E2=80=99 is not
> +      provided, no alignment is performed.
> +
>  if:
>    not:
>      required: [ reg ]


Thanks,
Miqu=C3=A8l
