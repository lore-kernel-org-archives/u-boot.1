Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B35ECFC271
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 07:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A1988E5F;
	Tue, 15 Oct 2024 09:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="a4fq31e9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 109A588E8E; Tue, 15 Oct 2024 09:11:45 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFCE888DED
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 09:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e29715835ceso158634276.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728976301; x=1729581101; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9WDOsOyjBr40/DG942xFzJoGHyL5sVb4xHCb4VnkNc=;
 b=a4fq31e9imdXETP+Ar52/yc0nAODNYHJ6LrpkWk8y86cTOWC6mYFziMuc3M7EpcuRA
 KWMo55Q+2QWZmPZ/qspquj2hmMhCbXu2yRyY5b0DevyC9qWljg037A4UYjfDLlT82rJN
 j8zeNq9ustXhNlgMUW0tQdCPKVQllQulZGGLyX48FnW9iKtMI3YuymgU/2upzNO0cX1l
 D09GPmStsgltDcHgmE2zXSUwGIS/IhZ7zwO/aS2ba5mubsWkbevli7bwi8aCFAhp45au
 4PgzmFHIi+UjI+wkHFUT4iDZUizfdrZELUfQ1uMHL7DqjHreXw/S0ZKK4Pqa7gUV5vDT
 64aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728976301; x=1729581101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9WDOsOyjBr40/DG942xFzJoGHyL5sVb4xHCb4VnkNc=;
 b=or7PlzQ+HXNeU2PWY9rQP5We1TXRWflXm13HP0ETLUjONko/G4W3C5ogX6d/6qod5o
 cvddcDzQ0+P1mtUfqzby+zTkHbcluzX9TYDm645j3mw9MOF8GKeIwPW34n3S6noNOYeV
 0WeHjgnzjjPMbHRys2lpUHCPvXO2ylcE4Jc0FbEttbOhlkNecFoiNnEbyloSNREaR+OP
 do+/JKq3lULyP0TsVMUak2dPL6tywBQlZvt15Bw8US508aTUjrv6murh7UkkrC2Qj29x
 VkreMoOZCmlymzw5H3TaTG//hU/RnAZ5DoqgZhzIBZJVqwgO/L28x2ZFvfLP5vFcJerr
 w9cw==
X-Gm-Message-State: AOJu0Yw0I9C50uJgml/o10uMc0X4vZqzFa6Ul6omNPECDTY9ZINk9hhb
 t0Pso7+1RtDRxza/QiBuFL2ZVSUwonv/oQhhgAnHFFBd7H7E+R7FWyRgeprYgPWNFLJTTFe7DMm
 MlCBjwEUqHkxjDwbb7+DvWeWH946LqZlipbR8XA==
X-Google-Smtp-Source: AGHT+IEE2Ussky40sGg5Fy7CgZzwGrcTgatV3H+zKQuhbNH2LR6iEBrqSt3Pt4DE4GmZBBlBnLI6BKbrNuBwTrNqdrk=
X-Received: by 2002:a05:6902:cc9:b0:e29:d7d:5dff with SMTP id
 3f1490d57ef6-e2919d9e471mr12122854276.23.1728976301624; Tue, 15 Oct 2024
 00:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
 <20241014131152.267405-21-patrick.rudolph@9elements.com>
 <CAFyOScrFmRQ2LeCC3MRDE1M4cbAvbjoyE-b97gjYPdrWBNBtZQ@mail.gmail.com>
In-Reply-To: <CAFyOScrFmRQ2LeCC3MRDE1M4cbAvbjoyE-b97gjYPdrWBNBtZQ@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Tue, 15 Oct 2024 09:11:30 +0200
Message-ID: <CALNFmy3Sbdk49hFAfabz-VYhdDMHHmyJHz8mmMdDr=wcSgCVUA@mail.gmail.com>
Subject: Re: [PATCH v8 20/37] arm: gic-v3-its: Implement of_xlate
To: Moritz Fischer <moritzf@google.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Moritz,
On Tue, Oct 15, 2024 at 3:30=E2=80=AFAM Moritz Fischer <moritzf@google.com>=
 wrote:
>
> Hi Patrick,
>
> On Mon, Oct 14, 2024 at 6:16=E2=80=AFAM Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Translate IRQs by implementing of_xlate() as required by
> > irq_get_by_index() to parse interrupt properties.
> >
> > TEST: Booted on qemu sbsa-ref that has a GICV3.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> > Changelog v6:
> > - Update header order
> >
> > ---
> >  arch/arm/lib/gic-v3-its.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
> > index 22fa46a341..0d5545bfb2 100644
> > --- a/arch/arm/lib/gic-v3-its.c
> > +++ b/arch/arm/lib/gic-v3-its.c
> > @@ -4,6 +4,7 @@
> >   */
> >  #include <cpu_func.h>
> >  #include <dm.h>
> > +#include <irq.h>
> >  #include <asm/gic.h>
> >  #include <asm/gic-v3.h>
> >  #include <asm/io.h>
> > @@ -163,8 +164,28 @@ static const struct udevice_id gic_v3_ids[] =3D {
> >         {}
> >  };
> >
> > +static int arm_gic_v3_of_xlate(struct irq *irq, struct ofnode_phandle_=
args *args)
> > +{
> > +       if (args->args_count > 2) {
> > +               log_debug("Invalid args_count: %d\n", args->args_count)=
;
> > +               return -EINVAL;
> > +       }
> Aren't gicv3 at least #interrupt-cells =3D 3; to distinguish PPI / SPI?
Yes, you are right. I missed that since qemu SBSA uses #interrupt-cells=3D1=
.

> > +
> > +       if (args->args_count > 0)
> > +               irq->id =3D args->args[0];
> > +       if (args->args_count > 1)
> > +               irq->flags =3D args->args[1];
>
> Don't you have to distinguish PPI and SPIs here? You'll use
> args->args[0] as PPI vs SPI and args[1] is either 1:1 (PPI) or offset
> by 32 for SPIs or am I misunderstanding something?

Yes, that's correct. Will send an updated version.

> > +
> > +       return 0;
> > +}
> > +
> > +static const struct irq_ops arm_gic_v3_ops =3D {
> > +       .of_xlate               =3D  arm_gic_v3_of_xlate,
> > +};
> > +
> >  U_BOOT_DRIVER(arm_gic_v3) =3D {
> >         .name           =3D "gic-v3",
> >         .id             =3D UCLASS_IRQ,
> >         .of_match       =3D gic_v3_ids,
> > +       .ops            =3D &arm_gic_v3_ops,
> >  };
> > --
> > 2.46.2
> >
>
> Cheers,
> Moritz
