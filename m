Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B12CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 15:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C4158365E;
	Fri, 29 Aug 2025 17:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bc9jd7x+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E30668367F; Fri, 29 Aug 2025 17:48:55 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA42D83653
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 17:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-61cc281171cso3834379a12.0
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756482533; x=1757087333; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZBgbMjHGeN5spZnj7yeyi+GHc84F6Mr13Yivzthl+M=;
 b=bc9jd7x+15bMaBc66Mfxd3uOBQFgFWIqqzrEbJUob5s4Dz73IAUafEQli+IdFbdDBr
 DIi8vPnQtPZVeKshvde4Xzk291qRJJQ3GKi8LCW4rlCfcInKiUfd2+vKFN1aCUXLfU5B
 OXujLueaCkLRPzUZ9tBFSvF+kIKo1XI6iXbwmK8BzZbvuYkMw5oTe0S/alLwu0vktiSa
 bcujO9yxgnonzaujtrFepO9E5Z2ypqhBuPkMOIxd7LUHMb0Qs0CBa8iczisG7gJ4KDwg
 uHUzUlzkWfSrsHWfaHBoaQn4iNlxCvbQfRz0Wb5SqI0ZstkEJvauQ/UqzYEdDGRRo6VD
 2WCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756482533; x=1757087333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZBgbMjHGeN5spZnj7yeyi+GHc84F6Mr13Yivzthl+M=;
 b=kV1KaBBIHzIFdryJlOPJsjlJojKiOLk3Cf4ZB0D5NrrAVIQ7f+D574csW4ngNrsw05
 LR/qNsUaQve56PsQdBtJpNv04ZU7oTVAacjGAj/fTMQp7tpTsavmRdu7CnE9YpkDoK+F
 //fdk4g+E7iatC4sFUx+/8VleVsUrnnt32pOrtZFUgmTve3sNotUjfCqsYbftb0yd/2C
 IHo6WPLS24Ti7rwByPK6JcKHm9zxGN89fk1lT9E8oZnNlfTUZGmIQ7JV1yFGF47Znwda
 wzybUUf3Ap2WmQ11tn1iZ5zWCMKBsrw/nvRWtA6hpovhfBnlbARYknrrq32fCeOkP/pt
 qdiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHEPh5QioppLN2M20jRV9TrsVBlflnZ398N17Hw27itlK6WBYEOxTJsgB1HqdZX95fHuWN0oE=@lists.denx.de
X-Gm-Message-State: AOJu0YzuaFcEgZdN0/OuR2LSmk4iJi8PKDkzlGLCtJGpc9mK+b/xoun7
 PJlszJXBLQrp4Cltu461rl1gdkEFk8hvLtE6e/8FsM1HlGsmmbe9R0H4Wn6SaOpt/SuYHQuszFf
 iu1p9qZdWiYzBj9ta932hgMiuFtVZypQ=
X-Gm-Gg: ASbGncstoLB4UJrlsHU63BnMtXN+zZKf85RTrfaDByJyhmdd7r5Cs4iixIk3YEk6w9J
 FY0ynZjPnblColYbAprcUpQR229loVs/1ct8WtCqzuunGBByXny7Glmy4MQAcePlTFlerRJiXGq
 1Y6bogY9HngkYRzO/t2vWA6AsYFCeg7OJluG1Z30lWx5wYOXe4Zjd8/7iLqJkN1w1mNCmmwi55X
 jRDe5o8b273EKGs
X-Google-Smtp-Source: AGHT+IHv95NjxUBDXRryivr08gyT6aK+Hgi33R5ywSNdZd/kvNVTTNUawyTClmAA03E98tGrnWLWpRDb8Fhi3nBfvqk=
X-Received: by 2002:a05:6402:13c1:b0:608:f493:871c with SMTP id
 4fb4d7f45d1cf-61c1b40bdf3mr25321314a12.14.1756482532998; Fri, 29 Aug 2025
 08:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250806222710.23773-1-semen.protsenko@linaro.org>
 <CANAwSgSC4Af-kO9sFjd9Xugh4SxBmC_cvLhAK=xX7kQvk4avTw@mail.gmail.com>
 <CAPLW+4nSNLNW8TWi5OSb-UZzYGbC1GBX3HbV-9C=FgqW6qO0Zg@mail.gmail.com>
In-Reply-To: <CAPLW+4nSNLNW8TWi5OSb-UZzYGbC1GBX3HbV-9C=FgqW6qO0Zg@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 29 Aug 2025 21:18:36 +0530
X-Gm-Features: Ac12FXxMAlR6UTmKbH_vAS5wscTu-MaFHihCPN6bVsXM9Mf53GTx3UP3hRmFF2g
Message-ID: <CANAwSgTSuE8yg9YCxMLfCgdLVR0dxnvO=SaSTpCpRu0jG0GoHw@mail.gmail.com>
Subject: Re: [PATCH 00/10] samsung: e850-96: Enable USB host and Ethernet
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

Hi Sam,


On Wed, 27 Aug 2025 at 01:15, Sam Protsenko <semen.protsenko@linaro.org> wr=
ote:
>
> On Sun, Aug 24, 2025 at 8:22=E2=80=AFAM Anand Moon <linux.amoon@gmail.com=
> wrote:
> >
> > Hi Sam
> >
>
> Hi Anand,
>
> > On Thu, 7 Aug 2025 at 03:57, Sam Protsenko <semen.protsenko@linaro.org>=
 wrote:
> > >
> > > The E850-96 board has a LAN9514 chip which acts as a USB hub and
> > > Ethernet controller. It's connected to the SoC via USB lines. In orde=
r
> > > to make this chip functional the USB controller in Exynos850 SoC has =
to
> > > be configured in the host role, and the corresponding power regulator
> > > has to be enabled as well.
> > >
> > > This patch series enables USB host and network support on the E850-96=
 by
> > > making use of the LAN9514 chip. While at it, enable all power regulat=
ors
> > > (LDO) in the PMIC chip which can be useful in the bootloader and kern=
el,
> > > including the regulator used for LAN9514.
> > >
> > > Sam Protsenko (10):
> > >   usb: host: dwc3-of-simple: Add exynos850 compatible
> > >   board: samsung: e850-96: Set ethaddr
> > >   board: samsung: e850-96: Add ACPM code
> > >   board: samsung: e850-96: Add PMIC code
> > >   board: samsung: e850-96: Configure PMIC regulators
> > >   board: samsung: e850-96: Extract device info from fw loading code
> > >   board: samsung: e850-96: Add bootdev var to choose boot device
> > >   configs: e850-96: Disable CONFIG_DEFAULT_FDT_FILE
> > >   configs: e850-96: Enable USB host support
> > >   configs: e850-96: Enable Ethernet
> > >
> > >  board/samsung/e850-96/Makefile    |   2 +-
> > >  board/samsung/e850-96/acpm.c      | 169 ++++++++++++++++++++++++++++=
++
> > >  board/samsung/e850-96/acpm.h      |  27 +++++
> > >  board/samsung/e850-96/e850-96.c   |  97 +++++++++++++++--
> > >  board/samsung/e850-96/e850-96.env |   2 +-
> > >  board/samsung/e850-96/fw.c        |  45 ++++----
> > >  board/samsung/e850-96/fw.h        |   4 +-
> > >  board/samsung/e850-96/pmic.c      | 144 +++++++++++++++++++++++++
> > >  board/samsung/e850-96/pmic.h      |  14 +++
> > >  configs/e850-96_defconfig         |  10 +-
> > >  drivers/usb/host/dwc3-of-simple.c |   1 +
> > >  11 files changed, 482 insertions(+), 33 deletions(-)
> > >  create mode 100644 board/samsung/e850-96/acpm.c
> > >  create mode 100644 board/samsung/e850-96/acpm.h
> > >  create mode 100644 board/samsung/e850-96/pmic.c
> > >  create mode 100644 board/samsung/e850-96/pmic.h
> > >
> > Can you move pmic to drivers/power/pmic/ ?
> >
>
> Thank you for the review! This PMIC code is not really a driver, at
> least not yet. It's an ad-hoc solution, which is very specific to
> E850-96 board, and in its current form can't be used (even in theory)
> for different platforms. It also doesn't conform to U-Boot's Driver
> Model -- and I'd like to avoid reworking in such a way, please see the
> explanation below. At the moment it's very minimal and only needed to
> make Ethernet functional.
>
> The plan for proper PMIC enablement is to do that first in Linux kernel, =
i.e.:
>   - implement S2MPU12 driver
>   - define ACPM bus in device tree
>   - define PMIC node in device tree and describe all needed LDO regulator=
s
>
> and then porting all that into U-Boot. But that effort might take
> quite a long time to implement, as I'm the only engineer working on
> the E850-96 enablement at the moment. So I really think it's better to
> keep the PMIC code as a part of the board code for now, hope you're ok
> with that?
>
Ok, Thanks for this input.

Thanks
-Anand
