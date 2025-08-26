Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CF5CA0FE9
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 19:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C30C830F6;
	Tue, 26 Aug 2025 21:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gu1F2V7F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D65C8313B; Tue, 26 Aug 2025 21:45:16 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 987048309D
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 21:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e96dd4bd847so1046657276.0
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 12:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756237511; x=1756842311; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7MKDgqD0ZUhNv15NVtz6VGb0kCh97QFfyC4K141MGg=;
 b=gu1F2V7FZ2ZQRyJ4kw6ablLGERE3zUO4X1sE0knpDmNquH/PG0q5sLvu1pMiPkSxzX
 TWPWCVFnxuL12HXSg65vY8lJ5vGUxX8le9W7HtvXh4MBcxbohprpqK7PgBmSFBRJ1hbD
 yEnABvcEipHtVqftBRRh1PGhHHyCYgiSPpI7dPxiWx/r1epuLf1w/lLQDdvnKKJelWOB
 PHD+xkDFSoqMbzZ0EowO10PC3MUTEa1srfjt5xw1xq4S78pX85LihOYs7dE9FT/DqWql
 Tdtoe4vnnGXaHQwsr4p+AtHraHME6LN9kwl1k/2QpmfPn+fHAQm2HFfkWkrfsplppFq7
 kWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756237511; x=1756842311;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7MKDgqD0ZUhNv15NVtz6VGb0kCh97QFfyC4K141MGg=;
 b=XQq7rXPYDf5vH/9yz5FF5mKIbXR9LUDKzlT73v0Ly5dRY4wJY5n8SmlWG8tNSbepmi
 MpVdqoFRaaPF8DFznq8936JurDSRdISWcyOywgb+YGqLrFjYa5T5lCBWrPost15HSFSP
 GI+8ekue/yMRrMnr/1AZihxN+t/G9g+s6kxv+5uB8WdS2U5taVPf9hSoXjz/RFLlOBU+
 H8XeCcVwGEPkCvLtTERlzT4Lj+Jin26czy4ReMBWOg9syTNH7zOKjYkWt3PcJ0MX+Qju
 InQBe8CkVXL/EZEav2jkgEVN3HayIsg70panWNQBBJEDd/vNgXjWi4QdIKWIRMbiSduv
 gzQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKR6LcbIGhW5qdu0RhbGyAf4q/byq/bybnqMlyVpMIq+onTQ6Rner8oXJYOLY8wVdy58IpyXw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywc3o/BNMyiGHuxYldHw+dcFSulyCg++806s5SAnya76ZDqa5nY
 xsLqGAIkEQTAZq3XaxoljCk+NW0Bmkqu0rpySIJAEiy9bWAr72EebSP7ipAFXOhpUzCJV77jTLI
 cDLb/AvVFkhhGV66M+nhG4Fdr8Oc6q0dTQUqQCie+2w==
X-Gm-Gg: ASbGncueSMiLevpbgrc4QwcrYf9OOHI8nMKv1mZQ2YsZLx1kUojTsM5hGDRe+njPz3j
 kOcmz4HvmKcPWkR8zahYs21TbztXt/Focqwg4osQTEX9HkkX9nDv71lDPUb8buLc7AzjVtyHc5c
 kJ5Y5MVvA4kfnaw2vV38EgJ82q28Q77LCfvP9ls4q1+nKdyHFYZwdy2TuLmttetpxsCJHX4vDvb
 6hrIQ==
X-Google-Smtp-Source: AGHT+IECwtm9pxK019FepkyEkI6qb/NZfvzWyX4xeVWGM5a360Vd4RRZsOn3KlRGTBDv+bW+0u1WycBQ7n5XImqMz/g=
X-Received: by 2002:a05:6902:6010:b0:e94:e1e5:930a with SMTP id
 3f1490d57ef6-e951c3e79c7mr16201060276.50.1756237511077; Tue, 26 Aug 2025
 12:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250806222710.23773-1-semen.protsenko@linaro.org>
 <CANAwSgSC4Af-kO9sFjd9Xugh4SxBmC_cvLhAK=xX7kQvk4avTw@mail.gmail.com>
In-Reply-To: <CANAwSgSC4Af-kO9sFjd9Xugh4SxBmC_cvLhAK=xX7kQvk4avTw@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 26 Aug 2025 14:44:59 -0500
X-Gm-Features: Ac12FXwiE34ildHo0zBqXzOWK9yQ_D9YELRYpkaXztZXLVRiBvl6vi1pU4cFars
Message-ID: <CAPLW+4nSNLNW8TWi5OSb-UZzYGbC1GBX3HbV-9C=FgqW6qO0Zg@mail.gmail.com>
Subject: Re: [PATCH 00/10] samsung: e850-96: Enable USB host and Ethernet
To: Anand Moon <linux.amoon@gmail.com>
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

On Sun, Aug 24, 2025 at 8:22=E2=80=AFAM Anand Moon <linux.amoon@gmail.com> =
wrote:
>
> Hi Sam
>

Hi Anand,

> On Thu, 7 Aug 2025 at 03:57, Sam Protsenko <semen.protsenko@linaro.org> w=
rote:
> >
> > The E850-96 board has a LAN9514 chip which acts as a USB hub and
> > Ethernet controller. It's connected to the SoC via USB lines. In order
> > to make this chip functional the USB controller in Exynos850 SoC has to
> > be configured in the host role, and the corresponding power regulator
> > has to be enabled as well.
> >
> > This patch series enables USB host and network support on the E850-96 b=
y
> > making use of the LAN9514 chip. While at it, enable all power regulator=
s
> > (LDO) in the PMIC chip which can be useful in the bootloader and kernel=
,
> > including the regulator used for LAN9514.
> >
> > Sam Protsenko (10):
> >   usb: host: dwc3-of-simple: Add exynos850 compatible
> >   board: samsung: e850-96: Set ethaddr
> >   board: samsung: e850-96: Add ACPM code
> >   board: samsung: e850-96: Add PMIC code
> >   board: samsung: e850-96: Configure PMIC regulators
> >   board: samsung: e850-96: Extract device info from fw loading code
> >   board: samsung: e850-96: Add bootdev var to choose boot device
> >   configs: e850-96: Disable CONFIG_DEFAULT_FDT_FILE
> >   configs: e850-96: Enable USB host support
> >   configs: e850-96: Enable Ethernet
> >
> >  board/samsung/e850-96/Makefile    |   2 +-
> >  board/samsung/e850-96/acpm.c      | 169 ++++++++++++++++++++++++++++++
> >  board/samsung/e850-96/acpm.h      |  27 +++++
> >  board/samsung/e850-96/e850-96.c   |  97 +++++++++++++++--
> >  board/samsung/e850-96/e850-96.env |   2 +-
> >  board/samsung/e850-96/fw.c        |  45 ++++----
> >  board/samsung/e850-96/fw.h        |   4 +-
> >  board/samsung/e850-96/pmic.c      | 144 +++++++++++++++++++++++++
> >  board/samsung/e850-96/pmic.h      |  14 +++
> >  configs/e850-96_defconfig         |  10 +-
> >  drivers/usb/host/dwc3-of-simple.c |   1 +
> >  11 files changed, 482 insertions(+), 33 deletions(-)
> >  create mode 100644 board/samsung/e850-96/acpm.c
> >  create mode 100644 board/samsung/e850-96/acpm.h
> >  create mode 100644 board/samsung/e850-96/pmic.c
> >  create mode 100644 board/samsung/e850-96/pmic.h
> >
> Can you move pmic to drivers/power/pmic/ ?
>

Thank you for the review! This PMIC code is not really a driver, at
least not yet. It's an ad-hoc solution, which is very specific to
E850-96 board, and in its current form can't be used (even in theory)
for different platforms. It also doesn't conform to U-Boot's Driver
Model -- and I'd like to avoid reworking in such a way, please see the
explanation below. At the moment it's very minimal and only needed to
make Ethernet functional.

The plan for proper PMIC enablement is to do that first in Linux kernel, i.=
e.:
  - implement S2MPU12 driver
  - define ACPM bus in device tree
  - define PMIC node in device tree and describe all needed LDO regulators

and then porting all that into U-Boot. But that effort might take
quite a long time to implement, as I'm the only engineer working on
the E850-96 enablement at the moment. So I really think it's better to
keep the PMIC code as a part of the board code for now, hope you're ok
with that?

Thanks!

> Thanks
> -Anand
