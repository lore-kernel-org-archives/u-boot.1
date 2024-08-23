Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA74C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 08:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A50F885C5;
	Fri, 23 Aug 2024 10:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CmCYHgzs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A872A886B1; Fri, 23 Aug 2024 10:10:40 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C9FB884C3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 10:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f029e9c9cfso20423831fa.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1724400637; x=1725005437;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzJK3iM0w8U7WyyNHLMy+vVzW9roXN6bQ3bF10Diwic=;
 b=CmCYHgzsA9vYDO9UOOyGmtts0zJjL4m91oNMGZpXjsZ7Ia+r5CMYVP5GRxYWV/m80X
 aBrMEQBeNZuLKUPi0pPLthDbxcIaB6UjjlTXGnpRM5y2rpvm0vjTBhbbwy2Ds4w14gyG
 YQsWB8dWyYoVOuLKwpjL8JZLs4jal7yVKzEg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724400637; x=1725005437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzJK3iM0w8U7WyyNHLMy+vVzW9roXN6bQ3bF10Diwic=;
 b=AZatfUyVjZkbq8Ta8qpv/jgL3NsJBNlR87vJmAQDJG/+FVYkbkXR/kPyGaKfdJWfXQ
 X3rRTG503DcV+SyI0rqULhpH6Eh436ZQtfZYbuXLUHw0vmfu8r0F7oe0CJLqHcOI3Qw7
 EQb3nYfabakx6NW4xCDnG350Pur2Uk6tClN0ilyGHBiaQaEbqML8yeLHxSyNLYVuAVl7
 +h67y9G494khzvSQdTHko4mHYpXZ+5OiOmWjQyvS0XqSAIcT8KBWb62dJ344xMxVaMSf
 jzlBWaA4zRNrzYpO8ni2lqQafIkHeZ9mgW7/2AVrjXhlU8XDC9G4XyiQ6ZnTb/Pvb5Zh
 aGuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy57cUuRgJZOWUrSWmOFZ00FmWx2IT9DxTjUJV9LV1IoZr3gzYbCIIGzOSOaKmbLCxkY9RndI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+i4bNGPR+LOHLDKshDS+lrMIBn9IrmDtJymjYJIANHCOXK3O3
 kL5JZmHH7URsT9a5nIpSeT8LhgaVhEQtPCbRKe4j2iekUnjFWMmrmI7A0QXM8uYxPKFDvY7aWtz
 Cqjoww3oiB3fvIS7Cdz74z50FfIZq34juoMNx8g==
X-Google-Smtp-Source: AGHT+IHcUeAr+70IxxFcfv0eey6h/QQN3ytSBL+ileJ12GGUj+fEJfjkaTmC5RsqXEXTuhCUiMovJtuiTllsan+H+iA=
X-Received: by 2002:a2e:361a:0:b0:2f3:cd65:cf65 with SMTP id
 38308e7fff4ca-2f4f577655emr9448881fa.28.1724400636908; Fri, 23 Aug 2024
 01:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
 <82c914ec-db68-5971-8ac0-6ed359872175@salutedevices.com>
 <CAOf5uwmuZoDpVTGA=vTm_7Ywkw8OWi0e2NpG3Q1ZgO6R=UnuHQ@mail.gmail.com>
 <bb05c33e-9769-7e1d-699e-f42829255796@salutedevices.com>
In-Reply-To: <bb05c33e-9769-7e1d-699e-f42829255796@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 23 Aug 2024 10:10:25 +0200
Message-ID: <CAOf5uw=UKXVB5H3DBzFFPx8nrXw3S44yPq=5CD+VAVHGuAmQTg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Meson: R/W support for pages used by boot ROM
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, 
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

Hi Arseniy

On Thu, Aug 22, 2024 at 9:04=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Hi, thanks!
>
> Thanks, Arseniy
>
> On 22.08.2024 00:17, Michael Nazzareno Trimarchi wrote:
> > Hi
> >
> > I will read them tomorrow ;)
> >
> > Thank you for understanding
> >

All the series are delegated to Neil. I will review anyway but I think
that will then pick from him

Michael

> > Michael
> >
> > Il mer 21 ago 2024, 22:25 Arseniy Krasnov <avkrasnov@salutedevices.com>=
 ha
> > scritto:
> >
> >> Hi, sorry, pls ping  =F0=9F=98=84
> >>
> >> Thanks
> >>
> >> On 08.07.2024 10:13, Arseniy Krasnov wrote:
> >>> Patchset is based on patchset for Linux (today merged to nand-next):
> >>>
> >> https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasnov@s=
alutedevices.com/
> >>>
> >>> Here is description from it:
> >>>
> >>>  >  Amlogic's boot ROM code needs that some pages on NAND must be wri=
tten
> >>>  >  in special "short" ECC mode with scrambling enabled. Such pages:
> >>>  >  1) Contain some metadata about hardware.
> >>>  >  2) Located with some interval starting from 0 offset, until some
> >>>  >     specified offset. Interval and second offset are set in the
> >>>  >     device tree.
> >>>  >
> >>>  >  This patchset adds R/W support for such pages. To enable it we ca=
n
> >> setup
> >>>  >  it in dts:
> >>>  >
> >>>  >      nand-is-boot-medium;
> >>>  >      amlogic,boot-pages =3D <1024>;
> >>>  >      amlogic,boot-page-step =3D <128>;
> >>>  >
> >>>  >  It means that each 128th page in range 0 to 1024 pages will be
> >> accessed
> >>>  >  in special mode ("short" ECC + scrambling). In practice this feat=
ure
> >> is
> >>>  >  needed when we want to update first block of NAND - driver will
> >> enable
> >>>  >  required mode by itself using value from device tree.
> >>>
> >>> The only difference is that patchset for Linux updates DT bindings, w=
hile
> >>> this adds NAND_IS_BOOT_MEDIUM flag support.
> >>>
> >>> Changelog:
> >>>  v1 -> v2:
> >>>  * Pls see per-patch changelog.
> >>>
> >>> Arseniy Krasnov (3):
> >>>   mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
> >>>   mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
> >>>   mtd: rawnand: meson: read/write access for boot ROM pages
> >>>
> >>>  drivers/mtd/nand/raw/meson_nand.c | 84 +++++++++++++++++++++--------=
--
> >>>  drivers/mtd/nand/raw/nand_base.c  |  3 ++
> >>>  include/linux/mtd/rawnand.h       |  5 ++
> >>>  3 files changed, 65 insertions(+), 27 deletions(-)
> >>>
> >>
> >



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
