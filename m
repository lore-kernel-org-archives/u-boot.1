Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F169DEE6451
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B78388D9A;
	Thu, 12 Sep 2024 08:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="MYvQ+EMw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BED8888D9F; Thu, 12 Sep 2024 08:52:39 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE5B88B67
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e026a2238d8so608875276.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726123956; x=1726728756; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLkaK81iYIb9QbaQN9iKtEvGU7CisYacIxRKhgfyrlY=;
 b=MYvQ+EMwBVgB76KNW2ratFgFRQih0nB2VLC/CVT3Y/nfaVGfGseT1BD9BmWcZhacfC
 HvW5P1v1Nq9tz7PYZ4YIzhTnTfy/6wgjIKH19gHt90tFaAZjxK0Xb38JCJ2kxgM8X/3g
 6pup/GieAgFI9bjuaxJOBW1xrLf+0enpJmCvA+OBgMxtn1ev7RzFL0SFgVxsZcc7+7QZ
 Y8WUSDrQr9vtwvDEB15GOa5G/Y5AZAZCHoyp9mG05FgAOG5OV2sNoFz7uCYuSRIPZ46A
 Zk/0rvU4NJorKdeIAasblrlGqqVyZTOnSQu2WXTqzQqIa4L3kUDwzCTeiphP/eN5+zJ5
 BgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726123956; x=1726728756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hLkaK81iYIb9QbaQN9iKtEvGU7CisYacIxRKhgfyrlY=;
 b=k0j7E7zuTADOMaTEORDkz5OiLvX7MioaHgZjyZ6Cfn91Zs3G1Kdu4bwMIyrzRXAIr/
 ZSRREzZUxvtBJHkUkpNv1G22EtfG7vMB8SjcmfanybcIjvBZ4Mp+313bdoi12u2N8JwE
 TN+aBQ0cy9bTwI6je++LFhP1RjB5ZD25Em5EmSvR2n/DIZaElytnyEiojtb0qUxE6EdD
 GJUz7rn7M5c38/tvNp7LGp8q1uNq2GLNAK1b2c2u+XpF0ihUl+Z9BEuuaz9Z8eFn3j+t
 zrjeaspZPsJcHo832E59uLS2sERCfujEu01zp17YGJcbzq9PeuCzLNn68pSGdyeaYncn
 em+Q==
X-Gm-Message-State: AOJu0Yz2akCpCQCOYp2NNnWaVsVVguzGMfb4buMj8tr8+evM9xu6xgxj
 /f0nz4zYIvJytvNbqJt/W88WSlx3Sh9X2JAj86O9MAlqN4Rh7/nFhKJVY50LcqZ+iZnzL1FY/41
 uQMsl7k8uCXcBbpRXzzx+iWbBljakKT7hIbsX1A==
X-Google-Smtp-Source: AGHT+IE35bmn18N00hx7rFjKW30hUoh0ihgQXRO90TFwIR1WEYAfXyzLCcRLwfMKmqJQgXBekgI4jFhRlOUljN09S8E=
X-Received: by 2002:a05:6902:cc1:b0:e1b:dc38:1a8c with SMTP id
 3f1490d57ef6-e1d9dc3cb25mr1371935276.43.1726123956429; Wed, 11 Sep 2024
 23:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-20-patrick.rudolph@9elements.com>
 <CAFLszTj90Xm50hNCC0S3wn7nJyXp4R2JoMMg1+sCUabjJGhJTQ@mail.gmail.com>
In-Reply-To: <CAFLszTj90Xm50hNCC0S3wn7nJyXp4R2JoMMg1+sCUabjJGhJTQ@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Thu, 12 Sep 2024 08:52:25 +0200
Message-ID: <CALNFmy02rq76r6PJ6De1pavvAFOfUvB8XjY8Vydepcoi=G0Whw@mail.gmail.com>
Subject: Re: [PATCH v3 19/30] arm: gic-v3-its: Rename objects
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

On Thu, Sep 12, 2024 at 2:59=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Patrick,
>
> On Wed, 11 Sept 2024 at 00:29, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > The code accesses the gic-v3 node, but not the gic-v3-its node,
> > thus rename the objects to clarify which node it operates on.
> >
> > The following commit will make use of the gic-v3-its node for real.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > ---
> >  arch/arm/lib/gic-v3-its.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> But how many interrupt controllers are there? Would
> uclass_first_device_err(UCLASS_IRQ) work?
On most GICv2 compatible SBCs there's just one.
With GICv3+ you can have an additional GIC ITS as well, which would
also use class UCLASS_IRQ.
But on servers there even more than two...

I'd prefer the current code as it would work with the follow up commit
that adds another
UCLASS_IRQ driver.

>
> >
> > diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
> > index 2cc0a32f9d..22fa46a341 100644
> > --- a/arch/arm/lib/gic-v3-its.c
> > +++ b/arch/arm/lib/gic-v3-its.c
> > @@ -35,10 +35,10 @@ static int gic_v3_its_get_gic_addr(struct gic_v3_it=
s_priv *priv)
> >         int ret;
> >
> >         ret =3D uclass_get_device_by_driver(UCLASS_IRQ,
> > -                                         DM_DRIVER_GET(arm_gic_v3_its)=
, &dev);
> > +                                         DM_DRIVER_GET(arm_gic_v3), &d=
ev);
> >         if (ret) {
> >                 pr_err("%s: failed to get %s irq device\n", __func__,
> > -                      DM_DRIVER_GET(arm_gic_v3_its)->name);
> > +                      DM_DRIVER_GET(arm_gic_v3)->name);
> >                 return ret;
> >         }
> >
> > @@ -158,13 +158,13 @@ int gic_lpi_tables_init(u64 base, u32 num_redist)
> >         return 0;
> >  }
> >
> > -static const struct udevice_id gic_v3_its_ids[] =3D {
> > +static const struct udevice_id gic_v3_ids[] =3D {
> >         { .compatible =3D "arm,gic-v3" },
> >         {}
> >  };
> >
> > -U_BOOT_DRIVER(arm_gic_v3_its) =3D {
> > +U_BOOT_DRIVER(arm_gic_v3) =3D {
> >         .name           =3D "gic-v3",
> >         .id             =3D UCLASS_IRQ,
> > -       .of_match       =3D gic_v3_its_ids,
> > +       .of_match       =3D gic_v3_ids,
> >  };
> > --
> > 2.46.0
> >
>
> Regards,
> Simon
