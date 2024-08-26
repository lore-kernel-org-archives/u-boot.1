Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8439C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 06:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 249BB88840;
	Mon, 26 Aug 2024 08:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="d2mBNK83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A986488846; Mon, 26 Aug 2024 08:15:22 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C8CC8843A
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 08:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a86883231b4so500095266b.3
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 23:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1724652920; x=1725257720;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJ5ifD7jTdcTz+YgMhdtDMZPEjK0J8HsxCROu7L+F7o=;
 b=d2mBNK83G+bKTJG/n48YCdcHNzVpn8KlqQWeuo4NnmkRs816vVSDwPCDZAvSdyR3xc
 1/JLmmicOtHLQk+6bJxpcpaxQQvAusl/ChHdroA/cM4XG33bWlE1R7ctMGHKcPsWgbUG
 tzL95Jhum3V8wg9vGFtw/1DI+c+HZZInGH2Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724652920; x=1725257720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZJ5ifD7jTdcTz+YgMhdtDMZPEjK0J8HsxCROu7L+F7o=;
 b=IX14RsUcmxc2Dyns8IBNxrd7veF7b0COGrsjrVHkSHpxd4rqhyXrnFTMeua1vJghz+
 XLpDJG7D7fVBGKL2KEUOfe+wJcFRP9/nkqUdWf1c4zOnQEL4SYMwLe7HDyWYm7rAt1cR
 OfHOFrj2V5K28OQds5NXvzTxIQYQDaDYr7vGol+LdVq8pjFF0dJ7OXlXxCQFJtn/Tj3T
 P1FA4g9IbooxJvNVzkACojXFnrXFqfG4VnMpajwjWjSn9bC/0LLRlZkP6mqa/2qLVmYr
 rix7TVp1N5i2CAuVs4awJYLLFM6+oVNWLOKG1538d0uConmJYtwNE0sBwkGLENtNv3GM
 hj7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSgEFDa4TtuoNrspHDGaQc7NaYTOGTAFSbobhhU5NOiwV8JgT07CLKhJkrN4IekKlxnNzPDAQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw24wNi1DPrFGUb+zxCryUdv1ZVpsbolwk47z+W0wN8ebUl7P/Y
 KHwhhpurH3tTmGwCD+WxCVlGV9LOZGf7sQ8wwtnS5nGpbTd0KTkqT1Fb1naTpPjtaVYkwTQrOvl
 QsQXk9wO+VuU1gHcHcBw6bSDqTKdVS9VR10/y+A==
X-Google-Smtp-Source: AGHT+IEhqZYwsswNemY7h5TdnfKNlvQonD884wkoY8B8jUX6fJfMXV8jKy1a0qqerynW9CeNNBxcH6ONDw2H843ptoI=
X-Received: by 2002:a17:907:2cc6:b0:a80:f893:51bb with SMTP id
 a640c23a62f3a-a86a54f2001mr627000566b.68.1724652919162; Sun, 25 Aug 2024
 23:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
 <82c914ec-db68-5971-8ac0-6ed359872175@salutedevices.com>
 <CAOf5uwmuZoDpVTGA=vTm_7Ywkw8OWi0e2NpG3Q1ZgO6R=UnuHQ@mail.gmail.com>
 <bb05c33e-9769-7e1d-699e-f42829255796@salutedevices.com>
 <CAOf5uw=UKXVB5H3DBzFFPx8nrXw3S44yPq=5CD+VAVHGuAmQTg@mail.gmail.com>
 <0343aa52-8f23-4447-1827-3de7710735f3@salutedevices.com>
 <887fcb7b-5bd7-40ef-9bb5-ab9ed5079b06@linaro.org>
In-Reply-To: <887fcb7b-5bd7-40ef-9bb5-ab9ed5079b06@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 26 Aug 2024 08:15:07 +0200
Message-ID: <CAOf5uwnH-RTPWshLt_SnB=U=Fdug38m7Jsvm_PDm3kaCQEb_jA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Meson: R/W support for pages used by boot ROM
To: neil.armstrong@linaro.org
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <seanga2@gmail.com>, U-Boot-Denx <u-boot@lists.denx.de>,
 u-boot-amlogic@groups.io, 
 kernel <kernel@sberdevices.ru>, oxffffaa@gmail.com
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

Hi Aresenly

On Fri, Aug 23, 2024 at 10:53=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 23/08/2024 10:29, Arseniy Krasnov wrote:
> > Hi! Got it, thanks!
> >
> > On 23.08.2024 11:10, Michael Nazzareno Trimarchi wrote:
> >> Hi Arseniy
> >>
> >> On Thu, Aug 22, 2024 at 9:04=E2=80=AFAM Arseniy Krasnov
> >> <avkrasnov@salutedevices.com> wrote:
> >>>
> >>> Hi, thanks!
> >>>
> >>> Thanks, Arseniy
> >>>
> >>> On 22.08.2024 00:17, Michael Nazzareno Trimarchi wrote:
> >>>> Hi
> >>>>
> >>>> I will read them tomorrow ;)
> >>>>
> >>>> Thank you for understanding
> >>>>
> >>
> >> All the series are delegated to Neil. I will review anyway but I think
> >> that will then pick from him
>
> Sure I can pick them if reviewed!
>

Can you please resend the series? I don't find in my mailbox (strange)

Michael

> Neil
>
> >>
> >> Michael
> >>
> >>>> Michael
> >>>>
> >>>> Il mer 21 ago 2024, 22:25 Arseniy Krasnov <avkrasnov@salutedevices.c=
om> ha
> >>>> scritto:
> >>>>
> >>>>> Hi, sorry, pls ping  =F0=9F=98=84
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>> On 08.07.2024 10:13, Arseniy Krasnov wrote:
> >>>>>> Patchset is based on patchset for Linux (today merged to nand-next=
):
> >>>>>>
> >>>>> https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasno=
v@salutedevices.com/
> >>>>>>
> >>>>>> Here is description from it:
> >>>>>>
> >>>>>>   >  Amlogic's boot ROM code needs that some pages on NAND must be=
 written
> >>>>>>   >  in special "short" ECC mode with scrambling enabled. Such pag=
es:
> >>>>>>   >  1) Contain some metadata about hardware.
> >>>>>>   >  2) Located with some interval starting from 0 offset, until s=
ome
> >>>>>>   >     specified offset. Interval and second offset are set in th=
e
> >>>>>>   >     device tree.
> >>>>>>   >
> >>>>>>   >  This patchset adds R/W support for such pages. To enable it w=
e can
> >>>>> setup
> >>>>>>   >  it in dts:
> >>>>>>   >
> >>>>>>   >      nand-is-boot-medium;
> >>>>>>   >      amlogic,boot-pages =3D <1024>;
> >>>>>>   >      amlogic,boot-page-step =3D <128>;
> >>>>>>   >
> >>>>>>   >  It means that each 128th page in range 0 to 1024 pages will b=
e
> >>>>> accessed
> >>>>>>   >  in special mode ("short" ECC + scrambling). In practice this =
feature
> >>>>> is
> >>>>>>   >  needed when we want to update first block of NAND - driver wi=
ll
> >>>>> enable
> >>>>>>   >  required mode by itself using value from device tree.
> >>>>>>
> >>>>>> The only difference is that patchset for Linux updates DT bindings=
, while
> >>>>>> this adds NAND_IS_BOOT_MEDIUM flag support.
> >>>>>>
> >>>>>> Changelog:
> >>>>>>   v1 -> v2:
> >>>>>>   * Pls see per-patch changelog.
> >>>>>>
> >>>>>> Arseniy Krasnov (3):
> >>>>>>    mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
> >>>>>>    mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
> >>>>>>    mtd: rawnand: meson: read/write access for boot ROM pages
> >>>>>>
> >>>>>>   drivers/mtd/nand/raw/meson_nand.c | 84 +++++++++++++++++++++----=
------
> >>>>>>   drivers/mtd/nand/raw/nand_base.c  |  3 ++
> >>>>>>   include/linux/mtd/rawnand.h       |  5 ++
> >>>>>>   3 files changed, 65 insertions(+), 27 deletions(-)
> >>>>>>
> >>>>>
> >>>>
> >>
> >>
> >>
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
