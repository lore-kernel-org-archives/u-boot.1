Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C05CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 10:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE7368746E;
	Fri, 20 Oct 2023 12:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="UgFHbecR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CC7487479; Fri, 20 Oct 2023 12:22:07 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9E487467
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 12:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-27d0a173e61so489581a91.0
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 03:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1697797321; x=1698402121; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oy2Rfnymf4eV6j6Vt+9UvpER42SXq8YyYK3XXPzIyC0=;
 b=UgFHbecRNj3AblR6DgZYqRw2i0GUeptGRuu90aE/c4mEB3EyZdrvY1exFM7JhcjBH1
 UKFpvpdCjTNIPS0LsNC4Gr9Y6+kZKY73RYkcDgnf0m5WJ2CfjcC3z981sGgMuGDqt7p8
 FJv2EdaC8tcNUsUBOEeVObMgr2K+KDInQwUsAcOZzH/4lfbh9lYNTIvA6TnFVp0L73U7
 2E/xWVxsp+JmcYbZSM2bXGj1uodnH+drfPlvVODrouIFIuh47ZS2/kh0USesult2PD2I
 t3St9+dnfj7XJHARKavBNEh36FqQtfwb5RM3Et41Y/dm9chZBtsahh2Xj0ZfLAR5HXr+
 I68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697797321; x=1698402121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oy2Rfnymf4eV6j6Vt+9UvpER42SXq8YyYK3XXPzIyC0=;
 b=JtBFroj2Si+uaTRvAwq1WMFJN3mjvtKIlek7r3kqll47woQ0XHD3lu/w9yMhZtcld2
 tQYJaqlQUUzbepKKcxpu2pnY25WZyj9qLUaySlczP2G2ou4fWMZ8c+bzJaQC2wdaJqIJ
 lUIi1YfpUERn6yyK5Vrh95Fcz4H16m+dKXITI56shuXtSKhiPcKyqkxjmWClOdAdPeRr
 pDQjTmfdH8E77gJC4I+aGoXWMcEdAfLaZZLMvXyK0PvUjjOLHFIE+x+oLMMjZtJ0bsPz
 u7E6QRoMwNm5J2+xMohEPqH9vdnARkRQClwCM2viN48iDB6DnBME+J09GhEq3/sTobjC
 btoQ==
X-Gm-Message-State: AOJu0YzWAQ57mSY0bHmhI0kDqXECmrZEl7IsaTS8VfTTHzaQ6dNQfM6o
 IgR35lUDtWzzfs/wsRtnGT4ydZq1Ecg5D9Oxdy/W3cIa8SN8gyJg
X-Google-Smtp-Source: AGHT+IGQTghKuv8uQkizoVVBD9iku7VpSb6Oi6HO3DGdSxAMGzXv+j0L3RgBFZPFmcHZg0JgVwkUWoe+LTXjtu2XeG0=
X-Received: by 2002:a17:90a:202:b0:273:ec96:b6f9 with SMTP id
 c2-20020a17090a020200b00273ec96b6f9mr1373070pjc.25.1697797321410; Fri, 20 Oct
 2023 03:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230914101642.1603383-1-robert.marko@sartura.hr>
 <20230914101642.1603383-2-robert.marko@sartura.hr>
 <9194bb32-1f06-6b6d-acd0-c5baefb4ae2a@denx.de>
 <dee2aa61-662f-4116-8981-1094337e0f9f@denx.de>
In-Reply-To: <dee2aa61-662f-4116-8981-1094337e0f9f@denx.de>
From: Robert Marko <robert.marko@sartura.hr>
Date: Fri, 20 Oct 2023 12:21:50 +0200
Message-ID: <CA+HBbNGGo8NN8AHZVbsLe5J-kGwLQfw_00xX8vVDHYQdtxH_iA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm: mvebu: Espressobin: move network setup into a
 separate function
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, luka.perkov@sartura.hr
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

On Fri, Oct 20, 2023 at 8:46=E2=80=AFAM Stefan Roese <sr@denx.de> wrote:
>
> Hi Robert,
>
> On 9/18/23 08:47, Stefan Roese wrote:
> > On 9/14/23 12:16, Robert Marko wrote:
> >> Currently, Esspresobin switch is being setup directly in
> >> last_stage_init()
> >> which makes it hard to add support for any other board to be setup.
> >>
> >> So, lets just move the switch setup code to a separate function and
> >> call it
> >> if compatible matches, there should be no functional change.
> >>
> >> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> >
> > Reviewed-by: Stefan Roese <sr@denx.de>
>
> This patch and the next one do not apply on latest master. Could you
> please re-spin the patch series?

Done.

Regards,
Robert

>
> Thanks,
> Stefan
>
> > Thanks,
> > Stefan
> >
> >> ---
> >>   board/Marvell/mvebu_armada-37xx/board.c | 16 +++++++++++-----
> >>   1 file changed, 11 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/board/Marvell/mvebu_armada-37xx/board.c
> >> b/board/Marvell/mvebu_armada-37xx/board.c
> >> index da325e8c75..6527155c6e 100644
> >> --- a/board/Marvell/mvebu_armada-37xx/board.c
> >> +++ b/board/Marvell/mvebu_armada-37xx/board.c
> >> @@ -300,15 +300,11 @@ static int mii_multi_chip_mode_write(struct
> >> udevice *bus, int dev_smi_addr,
> >>       return 0;
> >>   }
> >> -/* Bring-up board-specific network stuff */
> >> -int last_stage_init(void)
> >> +static int espressobin_last_stage_init(void)
> >>   {
> >>       struct udevice *bus;
> >>       ofnode node;
> >> -    if (!of_machine_is_compatible("globalscale,espressobin"))
> >> -        return 0;
> >> -
> >>       node =3D ofnode_by_compatible(ofnode_null(), "marvell,orion-mdio=
");
> >>       if (!ofnode_valid(node) ||
> >>           uclass_get_device_by_ofnode(UCLASS_MDIO, node, &bus) ||
> >> @@ -356,6 +352,16 @@ int last_stage_init(void)
> >>       return 0;
> >>   }
> >> +
> >> +/* Bring-up board-specific network stuff */
> >> +int last_stage_init(void)
> >> +{
> >> +
> >> +    if (of_machine_is_compatible("globalscale,espressobin"))
> >> +        return espressobin_last_stage_init();
> >> +
> >> +    return 0;
> >> +}
> >>   #endif
> >>   #ifdef CONFIG_OF_BOARD_SETUP
> >
> > Viele Gr=C3=BC=C3=9Fe,
> > Stefan Roese
> >
>
> Viele Gr=C3=BC=C3=9Fe,
> Stefan Roese
>
> --
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
