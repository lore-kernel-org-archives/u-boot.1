Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D536EE57CD
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 22:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD3DE86AEB;
	Sun, 10 Sep 2023 00:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ScoVJHZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5957A86AE7; Sun, 10 Sep 2023 00:40:37 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C79A786AD0
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 00:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52f31fb26e2so676974a12.3
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 15:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694299234; x=1694904034; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HH/+pshZkTpZv3Y+FJdhNHQVmmCQFNeFe7HWpElLmzU=;
 b=ScoVJHZ4brAAMYVOLvJkFNuMDWNLksYMegM5ASnAVsyqtqhWGuLcQFJbB7kZq9Sy3x
 pqkDNENaEbL0l6NEih3uBy7ulxcsbAA6AMiczbapragXuatxePg1m1uQ/myU4+sTS+s/
 GQcVsye8O7gotnMpIcFzTAiTh8alf5kGGooYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694299234; x=1694904034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HH/+pshZkTpZv3Y+FJdhNHQVmmCQFNeFe7HWpElLmzU=;
 b=M9uRei7y4d3HQ7LRHrA+5G//4sndzdM2yUVy8pFcCtV/ziPmoFwwVBcO9YjzqgGWUM
 p+xdkhI6wH2uG65poA8Y0/XTh6KQ7yBi9ftg86NvQsBa40cDP1hMWUBX6ZNU1OnqpDBw
 OB3slFm12HbnZx310eVl7Cri4qaP/Os6gMhHQojz2l6DpPZlywLkhZD4qpUTjkSf944Y
 JHwk4vrDBc6OdnwtdCaeJVtFmbpnm5dmdfrcscO78fdxe+VA+M3y8hSkbUjJjTsIKvO8
 XmdFNPeQJLtNKrC/xQmmmeClma4RtvRvxGZdQ+8cWvjgskGY9ocC9oAtlRFm758V3AKX
 +gbA==
X-Gm-Message-State: AOJu0YywpFTt67DqprGpvt5IdmSmefJtju/Sx0SQJ/V+tA2aKSSdRv31
 H3wPFzi1OmZRqzAprf7PS2cYGZ7k3MAev6gh/5qu9A==
X-Google-Smtp-Source: AGHT+IFrWRpLbl5VBDOHv1Jgv+ESvlzO8fGQiu6W79llnlicsuRBSroLYNnBj0sNU7nbGU/xUQ4DSmg87aO838h2YZM=
X-Received: by 2002:aa7:ce05:0:b0:523:3853:e01a with SMTP id
 d5-20020aa7ce05000000b005233853e01amr4473909edv.36.1694299234153; Sat, 09 Sep
 2023 15:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230907214012.74978-1-sjg@chromium.org>
 <20230907214012.74978-2-sjg@chromium.org>
 <CAL_Jsq+N1=XuZqFsVEgBeVpJzTBJRJ+w76roOUBtbP2Y8f3bEw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+N1=XuZqFsVEgBeVpJzTBJRJ+w76roOUBtbP2Y8f3bEw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 9 Sep 2023 16:40:22 -0600
Message-ID: <CAPnjgZ1eE6s_07OAdNeWYEDVbPg-tz7S5jk15i0OJhHTrwBaMQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] schemas: memory: Add ECC properties
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Dhaval Sharma <dhaval@rivosinc.com>, 
 Guo Dong <guo.dong@intel.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Yunhui Cui <cuiyunhui@bytedance.com>, Chiu Chasel <chasel.chiu@intel.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Ard Biesheuvel <ardb@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Lean Sheng Tan <sheng.tan@9elements.com>, 
 Gua Guo <gua.guo@intel.com>, ron minnich <rminnich@gmail.com>
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

On Fri, 8 Sept 2023 at 05:46, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 7, 2023 at 4:40=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Some memories provide ECC detection and/or correction. For software whi=
ch
> > wants to check memory, it is helpful to see which regions provide this
> > feature.
> >
> > Add this as a property of the /memory nodes, since it presumably follow=
s
> > the hardware-level memory system.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v6:
> > - Use a number of bits instead of a string property
> > - Fix inidcates typo
> >
> > Changes in v5:
> > - Redo to make this property specific to ECC
> > - Provide properties both for detection and correction
> >
> > Changes in v3:
> > - Add new patch to update the /memory nodes
> >
> >  dtschema/schemas/memory.yaml | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yam=
l
> > index 1d74410..1a48b1c 100644
> > --- a/dtschema/schemas/memory.yaml
> > +++ b/dtschema/schemas/memory.yaml
> > @@ -31,10 +31,21 @@ patternProperties:
> >
> >        numa-node-id:
> >          $ref: types.yaml#/definitions/uint32
> > -        description:
> > +        description: |
>
> Why? '|' is not needed for any of these.
>
> >            For the purpose of identification, each NUMA node is associa=
ted with
> >            a unique token known as a node id.
> > -
>
> blank line between properties.
>
> I can fix these up when applying.

OK thank you.

>
> > +      ecc-detection-bits:
> > +        default: 0
> > +        description: |
> > +          If present, this indicates the number of bits of memory erro=
r which
> > +          can be detected and reported by the Error-Correction Code (E=
CC) memory
> > +          subsystem (typically 0, 1 or 2).
> > +      ecc-correction-bits:
> > +        default: 0
> > +        description: |
> > +          If present, this indicates the number of bits of memory erro=
r which
> > +          can be corrected by the Error-Correction Code (ECC) memory s=
ubsystem
> > +          (typically 0, 1 or 2).
> >
> >      required:
> >        - device_type
> > --
> > 2.42.0.283.g2d96d420d3-goog
> >

Regards,
Simon
