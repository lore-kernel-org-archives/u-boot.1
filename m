Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34787CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 09:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74C5383965;
	Mon,  1 Sep 2025 11:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IvLFQ0Sc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFDCF8399C; Mon,  1 Sep 2025 11:29:50 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B803D833AD
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 11:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-55f6bdcc195so2131054e87.0
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756718988; x=1757323788; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZQN9MBG+UIwqvT5oVWOMfhIOeeHXdG9nNDRMKEtWnls=;
 b=IvLFQ0ScN9kj6t8wDMH1l6sFXwxRH/5TZh7wDG/wI+1Ow5RLRSDnluAQyCPqUS2p06
 3bwRol0beBWQB9gZkNL9HIrzSDuck9U3dN3+CSXvRtv7wn1UlocHUoqNDCUBA6kZMTtZ
 Lkr0K6vrAlZG/ik9k/L3Hr6Fdvpud4Bvz3xN3muVdqqiWjEodQ28cbIqS22bEfBJ9hC6
 hPss/P41XI7y7tUULEXYWoE4qnN9ZOVuQcO9mpKeDW04ATy3nkrOhovMigfp3fLgf9Q/
 dORh9ICgiKi+cQUXr9UMdPB/P2j9roiXL9N45jUHLBGRYZ0XmIpWyXDrJT64UoSQQuSg
 82Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756718988; x=1757323788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZQN9MBG+UIwqvT5oVWOMfhIOeeHXdG9nNDRMKEtWnls=;
 b=ezhwGPQE876oTPGrE2AM+aozo+gZqslvvxd9eFvUfBre8Bcy/EH3dJ7+yLD0AxNWWY
 jDU6BLcaSMD/ocZ2DN5k8mAnbuh9vC7EuTZ17W1Uatv4UAHb6EQN4i43QBAdEx8vEusm
 l0ya0ilA4hwWe6njRYdu1+4b+P9nbgPX5luRpyuquA5Oa8Ni0JbdtIWcwPc/BNfnOCXX
 qeYoq+AJ9DC0FXTBO1T4+8T3+J677q0ZKgwCveh1k7fplLShk5qeuafDVBgqZSIdvS+M
 f6b2t0HJz+doe7wiEU53UoMSRXXoyh0rW2jZCC8bZ+6ROe6adNlMtBtLrwr3DKHeQjct
 tR2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnUqgi5253DGo+zOtazwWLWJUlMOFD162MiWdJ11valbWMH2Hq2LaAQUoEJGF4hDKn0YSHbbc=@lists.denx.de
X-Gm-Message-State: AOJu0YwgZetHSToHsN5wMK0oeSH1P5hzZAHugyvsCMP0dHbunDtlnt/h
 0ePzH2JXoP9ZipRPm5FkXBRrdHjAnBBTEGK+7fWcLKZBqzyADEY1feX+h0RBsh5046F3GaIDyg3
 52Jzn6JDaNsTa8JSTsK8FEQ32ViQQDV4=
X-Gm-Gg: ASbGncuystlJnYFSsDdX3DxzyfUXYDb8XzzLAcivcR/inYmJKHCSqf1Gfybu1/GcWRW
 p4lGXRymhnxgIXQiCnhZ4KhKlhY1yfuVRGj2htULPxr3seNqkFE3jC4j7cbCDMcGLbfG8pA1Oqh
 M72CfZ7XAK6JiVo/EuVVq7a9RQHoCdfaYBZKkTfTjvEl+SOIzev2t4U4JZXYYFe0GWJ6ce40pRN
 NH/o9xe6lGJ8YCFlZV+t10QisNN1iLYHjp6jFhuuR/Br/TvG2w=
X-Google-Smtp-Source: AGHT+IE/tXSMXHHCWpbWepZ3R1EK514SSMWYSqeFeZJCRk3nPs7fRMUlzlRG507+oLFnuPZSrMz8pePQGI5JUC+tUHQ=
X-Received: by 2002:a2e:a9a7:0:b0:333:951f:6dd7 with SMTP id
 38308e7fff4ca-336ca900989mr18589941fa.3.1756718987759; Mon, 01 Sep 2025
 02:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250806222710.23773-1-semen.protsenko@linaro.org>
 <CANAwSgSC4Af-kO9sFjd9Xugh4SxBmC_cvLhAK=xX7kQvk4avTw@mail.gmail.com>
 <CAPLW+4nSNLNW8TWi5OSb-UZzYGbC1GBX3HbV-9C=FgqW6qO0Zg@mail.gmail.com>
 <CANAwSgTSuE8yg9YCxMLfCgdLVR0dxnvO=SaSTpCpRu0jG0GoHw@mail.gmail.com>
In-Reply-To: <CANAwSgTSuE8yg9YCxMLfCgdLVR0dxnvO=SaSTpCpRu0jG0GoHw@mail.gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Mon, 1 Sep 2025 18:29:34 +0900
X-Gm-Features: Ac12FXxXdmeLdBe19xy_ni5zEDsZxnBGeA48i7v2pX96cV-ic5o6h0jJK_WSqV0
Message-ID: <CALrBrZ3HzQAnP0pycVZiL0-6unstERC31L7V+B3ZnRZRMA3Hug@mail.gmail.com>
Subject: Re: [PATCH 00/10] samsung: e850-96: Enable USB host and Ethernet
To: Anand Moon <linux.amoon@gmail.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
 Minkyu Kang <mk7.kang@samsung.com>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi


2025=EB=85=84 8=EC=9B=94 30=EC=9D=BC (=ED=86=A0) 00:48, Anand Moon <linux.a=
moon@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hi Sam,
>
>
> On Wed, 27 Aug 2025 at 01:15, Sam Protsenko <semen.protsenko@linaro.org>
> wrote:
> >
> > On Sun, Aug 24, 2025 at 8:22=E2=80=AFAM Anand Moon <linux.amoon@gmail.c=
om>
> wrote:
> > >
> > > Hi Sam
> > >
> >
> > Hi Anand,
> >
> > > On Thu, 7 Aug 2025 at 03:57, Sam Protsenko <semen.protsenko@linaro.or=
g>
> wrote:
> > > >
> > > > The E850-96 board has a LAN9514 chip which acts as a USB hub and
> > > > Ethernet controller. It's connected to the SoC via USB lines. In
> order
> > > > to make this chip functional the USB controller in Exynos850 SoC ha=
s
> to
> > > > be configured in the host role, and the corresponding power regulat=
or
> > > > has to be enabled as well.
> > > >
> > > > This patch series enables USB host and network support on the
> E850-96 by
> > > > making use of the LAN9514 chip. While at it, enable all power
> regulators
> > > > (LDO) in the PMIC chip which can be useful in the bootloader and
> kernel,
> > > > including the regulator used for LAN9514.
> > > >
> > > > Sam Protsenko (10):
> > > >   usb: host: dwc3-of-simple: Add exynos850 compatible
> > > >   board: samsung: e850-96: Set ethaddr
> > > >   board: samsung: e850-96: Add ACPM code
> > > >   board: samsung: e850-96: Add PMIC code
> > > >   board: samsung: e850-96: Configure PMIC regulators
> > > >   board: samsung: e850-96: Extract device info from fw loading code
> > > >   board: samsung: e850-96: Add bootdev var to choose boot device
> > > >   configs: e850-96: Disable CONFIG_DEFAULT_FDT_FILE
> > > >   configs: e850-96: Enable USB host support
> > > >   configs: e850-96: Enable Ethernet
> > > >
> > > >  board/samsung/e850-96/Makefile    |   2 +-
> > > >  board/samsung/e850-96/acpm.c      | 169
> ++++++++++++++++++++++++++++++
> > > >  board/samsung/e850-96/acpm.h      |  27 +++++
> > > >  board/samsung/e850-96/e850-96.c   |  97 +++++++++++++++--
> > > >  board/samsung/e850-96/e850-96.env |   2 +-
> > > >  board/samsung/e850-96/fw.c        |  45 ++++----
> > > >  board/samsung/e850-96/fw.h        |   4 +-
> > > >  board/samsung/e850-96/pmic.c      | 144 +++++++++++++++++++++++++
> > > >  board/samsung/e850-96/pmic.h      |  14 +++
> > > >  configs/e850-96_defconfig         |  10 +-
> > > >  drivers/usb/host/dwc3-of-simple.c |   1 +
> > > >  11 files changed, 482 insertions(+), 33 deletions(-)
> > > >  create mode 100644 board/samsung/e850-96/acpm.c
> > > >  create mode 100644 board/samsung/e850-96/acpm.h
> > > >  create mode 100644 board/samsung/e850-96/pmic.c
> > > >  create mode 100644 board/samsung/e850-96/pmic.h
> > > >
> > > Can you move pmic to drivers/power/pmic/ ?
> > >
> >
> > Thank you for the review! This PMIC code is not really a driver, at
> > least not yet. It's an ad-hoc solution, which is very specific to
> > E850-96 board, and in its current form can't be used (even in theory)
> > for different platforms. It also doesn't conform to U-Boot's Driver
> > Model -- and I'd like to avoid reworking in such a way, please see the
> > explanation below. At the moment it's very minimal and only needed to
> > make Ethernet functional.
> >
> > The plan for proper PMIC enablement is to do that first in Linux kernel=
,
> i.e.:
> >   - implement S2MPU12 driver
> >   - define ACPM bus in device tree
> >   - define PMIC node in device tree and describe all needed LDO
> regulators
> >
> > and then porting all that into U-Boot. But that effort might take
> > quite a long time to implement, as I'm the only engineer working on
> > the E850-96 enablement at the moment. So I really think it's better to
> > keep the PMIC code as a part of the board code for now, hope you're ok
> > with that?
> >
> Ok, Thanks for this input.


applied to u-boot-samsung.

Thanks.
Minkyu Kang.


>
> Thanks
> -Anand
>
