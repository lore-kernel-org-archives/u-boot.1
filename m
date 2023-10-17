Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6D6CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 19:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F056586F27;
	Tue, 17 Oct 2023 21:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="0eWy/Gdk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7762386F33; Tue, 17 Oct 2023 21:21:40 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B6BB86F20
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 21:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso981792966b.2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 12:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1697570496; x=1698175296;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oHYPaRz4W4RHcKNaZpSzpM26q/F+SHWiG2riuyWiP9M=;
 b=0eWy/Gdktfk2HgPNAi+WkA6UCIMKiVOAK3ahBveAhmgc5OnDOGT4WgsWY63/QlcHK1
 yMMUqv8l0Yh3ZNVt52KT4j4tpZwVD0c3g4eXFVvqgrdec+jVqsoudx5CjI3JpJgAqO16
 6Jbb2/TR2163QPnZqUMpXCgUn6ynnEY04GDk6NsstVhA013JQ7BRFhIafgKEZ+I2+mJm
 QWKoTGGMNbC8z4tbY53dsfCWuYsKXXko0lrDxNiMoRQsSr1V7y9FDgjIGz2mVXy2Hgzg
 SIcBC1MadBV8uaBy+Pacfc5xlBEhT+uiIcP5WrkJiH0jM7+Ezfna4vRGv/PZAbhhBkhB
 sASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697570496; x=1698175296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHYPaRz4W4RHcKNaZpSzpM26q/F+SHWiG2riuyWiP9M=;
 b=YAWsJFWo7KsgwKtkRK8eUTiBPeANTsZFk5ceKgPz27H1Sg4huNvnj9qYrCqMwye9bU
 fiIaxy3hJ/IEQ8xUcH7BlyJqRNX0LD1oOswdx5z8NchrmWuha5uwegvVd6ZRoYJQoUWg
 nZZsSfzLld+DFOFDUOmIWUO9kSa5xfafevFIQM3Bz88ocVbgJ2Z0e4yW0WkLHTkUUzup
 ti9Ogyd33CfLTjKL7Ul+I0pRi0EeW5aREPhmOnFo4h6zcS0pwBnb0y9xldhWWOpPFi60
 toIZO1oIpxjwsrfHPjGqmKawiaWK2Xe3rEK2bP4FcG8rGnFEwxp+Zx63PHhSKvWBY7X9
 /6vA==
X-Gm-Message-State: AOJu0Yz0tpWzoGJT8ibt+JCj2NF4jnDqTHGLDJhL7/TiKSpYTqzZrH7w
 t+bsYSCHSXzWM4eOOTRpsRK8wJ+gd1yJ6RG1XKIWSQ==
X-Google-Smtp-Source: AGHT+IEX1+4ycFJx3KpxkNLZSCMYLebaB2qVLVWxoZd8U8X7DuiYj++x5I+bei0J0BDF8PX+QOA4SYad4OamC8ef5Ug=
X-Received: by 2002:a17:907:368b:b0:9ae:695a:fed0 with SMTP id
 bi11-20020a170907368b00b009ae695afed0mr2579451ejc.11.1697570495418; Tue, 17
 Oct 2023 12:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230427180845.127439-1-festevam@gmail.com>
 <CAJ+vNU1C24pLqxVKbcEYTP+g5zXWz4ARSg-mUxJt9izdSSieVw@mail.gmail.com>
 <CAOMZO5BPRNoPhNtawQ1UzbQ1v=vhHF3TcYYPgKWyR4MzTOLy0w@mail.gmail.com>
 <CAJ+vNU1m+jC3Yn6zUpxdW89G+Lmh1SnAKVPb17TePJL8eK6fZA@mail.gmail.com>
 <CAHCN7xKdjjmtO_ipY5UGYqQ=bcP3wsYmPXNonJAJ2EPM5d7Rvg@mail.gmail.com>
 <CAJ+vNU0QTAtVYzJG4q2=njc5dSzDHVj4Ce4VaPnFYAkyjz6yyA@mail.gmail.com>
 <CAHCN7xLUFOVcQbDWO3OjrEyQzLhnWJUeFHGZ1ebSFPRU4ohPXQ@mail.gmail.com>
 <CAJ+vNU3MqMDhGwAo1O_KKcdwQFPmpTrXV1X0e4O5teaVU4oMTA@mail.gmail.com>
 <CAOMZO5B4oDDN8ZwAMM_DUY25_BebmkNZR2pohGSpmrOJcy2p1A@mail.gmail.com>
 <CAHCN7xL0BFfZuY1pREWjbmqXkPUaC1UZBEZcMKaR7hQTU+rDqQ@mail.gmail.com>
 <CAJ+vNU0JPBu2Q5Cdc5O+Oh+eCmqQ_qtoAZaz4DHVcqsBeg41Tg@mail.gmail.com>
 <CAOMZO5DG3hwi9gTs7DYGfa8NexapU99v03pD9mGoYj5LkwqodQ@mail.gmail.com>
 <CAJ+vNU1SKHPiPwF5P9+G=fMysoEHEnsJ=EBA8=MExOEOec=aYA@mail.gmail.com>
 <CAJ+vNU1zE7rmKzQWwziPtwG5MKAnx0NE94CCLF8y-_iVYwub2g@mail.gmail.com>
 <339b69d6-c586-d85d-64de-92cd1469d017@denx.de>
In-Reply-To: <339b69d6-c586-d85d-64de-92cd1469d017@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 17 Oct 2023 12:21:23 -0700
Message-ID: <CAJ+vNU3ZtGNOz4nUpiS2O1Q4c8=kZmMjK=TWvaCT-uKFkr1Uhg@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm: dts: imx8mm: Sync with Linux 6.3
To: Stefano Babic <sbabic@denx.de>
Cc: Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
 Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Li Jun <jun.li@nxp.com>, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>
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

On Thu, Jul 13, 2023 at 10:17=E2=80=AFPM Stefano Babic <sbabic@denx.de> wro=
te:
>
> Hi Tim, Fabio,
>
> On 14.07.23 02:42, Tim Harvey wrote:
> > On Wed, May 3, 2023 at 9:11=E2=80=AFAM Tim Harvey <tharvey@gateworks.co=
m> wrote:
> >>
> >> On Fri, Apr 28, 2023 at 11:19=E2=80=AFAM Fabio Estevam <festevam@gmail=
.com> wrote:
> >>>
> >>> Hi Tim,
> >>>
> >>> On Fri, Apr 28, 2023 at 2:59=E2=80=AFPM Tim Harvey <tharvey@gateworks=
.com> wrote:
> >>>
> >>>> I believe the fix we need is the following which moves phy setup
> >>>> before the register access (where it should have been along with the
> >>>> case for !defined(CONFIG_PHY):
> >>> ...
> >>>> If everyone agrees here I'll submit a formal patch which should get
> >>>> applied through Marek via the usb tree before the dt sync.
> >>>
> >>> This works for me, thanks.
> >>>
> >>> When you submit it, feel free to add:
> >>>
> >>> Tested-by: Fabio Estevam <festevam@denx.de>
> >>
> >> Fabio,
> >>
> >> with commit bb6ea0fe9290 ("usb: ehci-mx6: move phy setup before
> >> register access") now in imx/master:
> >> Tested-by: Tim Harvey <tharvey@gateworks.com> #imx8mm-venice-gw73xx-0x
> >>
> >
> > Stefano,
> >
> > It doesn't look like this got picked up in your latest tree for some re=
ason.
> >
>
> Series disappeared from my list in patchworks, maybe because I
> erroneously thought that a V2 will be sent. I will pick up the series,
> thanks for advising.
>
> Best regards,
> Stefano
>

Hi Stefano,

This series [1] is still missing - can you pick it up?

[PATCH 1/3] arm: dts: imx8mm: Sync with Linux 6.3
[PATCH 2/3] arm: dts: imx8mn: Sync with Linux 6.3
[PATCH 3/3] arm: dts: imx8mp: Sync with Linux 6.3

Best Regards,

Tim
[1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D352685&state=
=3D*
