Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92727E7C4DA
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF4EB87511;
	Wed,  4 Oct 2023 18:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O0yMhEUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE89186EB7; Wed,  4 Oct 2023 18:06:05 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA6D48752F
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9b1ebc80d0aso750366b.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696435562; x=1697040362; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JXMY0UlzCXXysobfPTUw3MvymyulfDMm4djV4xjuSLo=;
 b=O0yMhEUkgXk98AptQ/a23wGqo+7aN8zaXBPtACF5YPR2mbx1OHvxGcMYx516mngGE6
 xM//YwMX8sk6qHnrjdiKTTBVI5FF+GSDt2PsW8YJ8SGhFZLiWCeDznF+pxhDuoLXT2z+
 Wfa5oTY0O80FvebIu84c5GvJXcYPDTStnKz4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696435562; x=1697040362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JXMY0UlzCXXysobfPTUw3MvymyulfDMm4djV4xjuSLo=;
 b=XBqPfWM3Ra9cP/7qVCskTKFOA+cckTcLTguR5nMQoR6YyZUhorTobmoMTVTmhfutxE
 rLyRVQtXEEk0BDcM6Ca9hIvD28YP4FApEK7xB/LR6zHIo6oa3UTAifFn0sSWeEqinpzf
 q7l7O2+NgH1EqHYxKRb/opcvJZrgvHzmT/ML3P41gNg661FI7arKzpH+KKnhffq/QPxP
 sxh4LBPW5fuB4/xnr6xqSEEDbvfE0eMwpHbQHXer2KjI/C5S8Ma+DcVvMIn/nBBZTBLx
 1ZPU9Jt1QU1uSDAzNsB7MrkLR1vP4kTQ3pLvS5YT2+Mj9dty3lrt6is471QLvztzRl6d
 SBvQ==
X-Gm-Message-State: AOJu0YzWxdufxFeQ7pvPXL1GF6IsXUUqGroew9F8caqe4OL18SV3p/X+
 9EpIzJaFJ6Jmy/iDT0eEahWoPL9RfFeIgUyMNYKgRQ==
X-Google-Smtp-Source: AGHT+IGqVaYwYjDX7LnINduPH2/9kJQhL4we82kv8wvcqWvPtz+C2ElHBSAuMC4vIAj9ICBYHQriteVS30W2xb61XAI=
X-Received: by 2002:a17:906:23e9:b0:9b2:c583:cd71 with SMTP id
 j9-20020a17090623e900b009b2c583cd71mr2451474ejg.50.1696435562091; Wed, 04 Oct
 2023 09:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231002174948.1015223-1-sjg@chromium.org>
 <20231004093620.2b1d6917@xps-13>
In-Reply-To: <20231004093620.2b1d6917@xps-13>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:05:43 -0600
Message-ID: <CAPnjgZ3bsNvCO_DkUG+99Ep_RPtQR42+AvxbLoZGBq+G8cWtPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: fixed-partitions: Add binman
 compatible
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 linux-mtd@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Pratyush Yadav <ptyadav@amazon.de>, 
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 4 Oct 2023 at 01:36, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Simon,
>
> sjg@chromium.org wrote on Mon,  2 Oct 2023 11:49:40 -0600:
>
> > Add a compatible string for binman, so we can extend fixed-partitions
> > in various ways.
>
> I've been thinking at the proper way to describe the binman partitions.
> I am wondering if we should really extend the fixed-partitions
> schema. This description is really basic and kind of supposed to remain
> like that. Instead, I wonder if we should not just keep the binman
> compatible alone, like many others already. This way it would be very clear
> what is expected and allowed in both cases. I am thinking about
> something like that:
>
>         Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
>
> this file is also referenced there (but this patch does the same, which
> is what I'd expect):
>
>         Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
>
> I'll let the binding maintainers judge whether they think it's
> relevant, it's not a strong opposition.

OK, yes I can do that. I suppose they would still remain backwards
compatible, due to the use of '$ref: partition.yaml#'

>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
>
> [...]
>
> > +properties:
> > +  compatible:
> > +    const: binman
>
> Right now this does not fit (I believe) the example. But if we no
> longer extend fixed-partitions but just create binman.yaml, this will
> probably be enough.

OK

>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    partitions {
> > +        compatible = "binman", "fixed-partitions";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        partition@100000 {
> > +            label = "u-boot";
> > +            reg = <0x100000 0xf00000>;
> > +        };
> > +    };

Regards,
Simon
