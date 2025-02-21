Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCF8C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 13:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FE2280F67;
	Fri, 21 Feb 2025 14:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g2DpYVyA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E469806FE; Fri, 21 Feb 2025 08:42:08 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DCA38007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 08:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-546237cd3cbso1828958e87.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 23:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740123725; x=1740728525; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zyh+ectjepB2M1zfRnD8YwuAktQVrJbuSBD2/Nu11Z8=;
 b=g2DpYVyAfHBe2tGzZFrDXmPsgtl5CViUWoxjLUdTGyEPrAZbXJ4dq0yUaty1ONk3al
 w89PCVMN0+aPAIeoqhYQmLAiBqFs4mRSuKwGT6QUUkWvT6F71gmFqrEhPkmxa541CfhF
 a0CnBfOaeZFr29NHUPW4v61P298CUqThoE1BFZ6YnVdXbXNT29toNYrSzCe8ooaV8SVf
 peXaOINB1B//VoDHsjuk7tyEe4SlNzKPWCW+fu9HRiY9OaheSjAGMuQJ+EbFjQQfeV3a
 nMooclJ5NGw4wfEHp7yatoSAFoal+3dLbrwMtOs5TWejwBD4auccMY8/1TmFXOkswoba
 AC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740123725; x=1740728525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zyh+ectjepB2M1zfRnD8YwuAktQVrJbuSBD2/Nu11Z8=;
 b=VeGvbapYy/pX+VYkl9Y7L1hiWREo95+V+gGJWimaq6Hy5h3qcJAMHLyaswohd/BpdL
 PUVRgeKnUwn01swCHAq18h4BH6Bt7rrggyODold6sQowIoBcl3eol7+IU0WCTgpSHKWL
 TTTY6Alx11ULagA+zqJLDAUndbkrYuEFKd9tWh/DqmDtbF7hF7oOS4bI1kjDq8yuM1c/
 MKxje+TRy2D5JWb2yMV4VkgQMUkH/VZJtI1p75yyhZoX3QCb8oED69HC5mX45XfG9Qhp
 hYizG8g24WhkGa5sjvQxqlPbjjglANtHg1GW9XhDJVCNDRZvycvMUUmo3WHfbkdBmKw5
 qN8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/zcOU4XogX4cNO/qeNK7HcWT9iHiffJyZRh4qse69urGJBIK1WUF2l5sNDYaBFPt12Hquo6g=@lists.denx.de
X-Gm-Message-State: AOJu0Ywm+jk+PbFQ3KRJRF+tiIABygNJwtJ1Fxaah7YL9wYZ8ZlhMIg7
 bqFxMqkdv+dhXTN71zeNFrPL1Z6BJDY1vsR4SRxRQbZiJTFNp6D+q/5bt8JUckWyzb19UCVmfkq
 BifgcpZ1ZHSyK/dppN22Ii49JBiE=
X-Gm-Gg: ASbGncsCnmsWXYr5ljShrpa+EMpaPRIt/F8DBmS2vhaH/qnNaZ9rZMwui/HLHHa8wlc
 HoPw3tX9QtR4zaHmcPRPN6gHK+XdzoObQVUTXBZEU1en+RX/czzJDD1Chxln0kMp9xb2+IvpEdl
 mpU9KMqg==
X-Google-Smtp-Source: AGHT+IHs4J9foewhZswogmqxTsp5dme9PcWKT4iBRj+t/10VEEXejtHvnMlRwvUnruaDrO30Co1L/W4JnTUpZNHpuh4=
X-Received: by 2002:a05:6512:138b:b0:545:842:fd32 with SMTP id
 2adb3069b0e04-54838eeb0f2mr742713e87.19.1740123724453; Thu, 20 Feb 2025
 23:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20250123010112.78924-1-minda.chen@starfivetech.com>
 <CANV2PTN0w4XvmC9dt5aQcfcVS2nezShLxwSfJL1Xm-2Z-8=QLA@mail.gmail.com>
In-Reply-To: <CANV2PTN0w4XvmC9dt5aQcfcVS2nezShLxwSfJL1Xm-2Z-8=QLA@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Thu, 20 Feb 2025 23:41:53 -0800
X-Gm-Features: AWEUYZkuwSRl5zoqgMQu6rXQl1nC3XbX03n-LVQtovfab9Yrc2Fh_mWUSEnIvQo
Message-ID: <CANV2PTPrdF7spLK89BZ4fwnD9k8Y_9buMBNPnzJN7CDjBO6pKw@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Add Starfive JH7110 Cadence USB driver
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 21 Feb 2025 14:53:04 +0100
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

On Thu, Jan 23, 2025 at 6:51=E2=80=AFAM E Shattow <lucent@gmail.com> wrote:
>
> On Wed, Jan 22, 2025 at 5:01=E2=80=AFPM Minda Chen <minda.chen@starfivete=
ch.com> wrote:
> >
> > Add Starfive JH7110 Cadence USB driver and related PHY driver.
> > So the codes can be used in visionfive2 and star64 7110 board.
> >
> > The driver is almost the same with kernel driver.
> >
> > Test with Star64 JH7110 board USB 3.0 + USB 2.0 host.
> > The code can work.
> >
> > The Starfive JH7110 has enable CONFIG_OF_UPSTREAM. The dts is
> > from kernel
> >
> > - previous version
> >   v1: https://patchwork.ozlabs.org/project/uboot/cover/20240504150358.1=
9600-1-minda.chen@starfivetech.com/
> >   v2: https://patchwork.ozlabs.org/project/uboot/cover/20240704055014.5=
5117-1-minda.chen@starfivetech.com/
> >   v3: https://patchwork.ozlabs.org/project/uboot/cover/20240719013822.1=
01374-1-minda.chen@starfivetech.com/
> >   v4: https://patchwork.ozlabs.org/project/uboot/cover/20240829013058.6=
178-1-minda.chen@starfivetech.com/
> >
> > - patch description.
> >
> > patch1: Add set phy mode function in cdns3 core driver
> >         which is used by Starfive JH7110.
> > patch2-3: USB and PCIe 2.0 (usb 3.0) PHY drivier
> > patch4: Cadence USB wrapper driver.
> > patch5: Get the dr mode from wrapper device node.
> > patch6: Add JH7110 USB default overcurrent pin.
> > patch7: config update.
> > patch8: MAINTAINERS update
> >
> > - change:
> >         v6:
> >         - patch 5 format changed.
> >         - split v5 patch4 to v6 patch 4 and patch 5
> >         - delete v6 dts patch7 because the StarFive JH7110
> >           CONFIG_OF_UPSTREAM is enbled.
> >         v5:
> >         - patch 2-4 format changed.
> >         - For pareparing enable OF_UPSTREAM, patch4 get the dr mode
> >           from parent device dts node not the cdns core device dts.
> >         - patch2 add a common usb syscon setting headfile.
> >         - delete v4 patch8 and the star64 dts setting can be setting
> >           int star64 board dts configuration if the OF_UPSTREAM is
> >           enable.
> >         v4:
> >         - patch 2 Add usb split setting, default set USB 2.0 only.
> >         - patch 5 move to spl stage.
> >         - Add a new patch 8 for star64 board usb host, vbus pin setting
> >           and usb 3.0
> >         v3:
> >         - patch 1 Move the added code to cdns3_drd_update_mode().
> >         - patch 1-4 correct the code format.(follow Rogers's comments.)
> >         - patch 3 using regmap_field.
> >
> >         v2:
> >         - patch 1 Move the added code to cdns3_core_init_role(). Must
> >           set PHY mode before calling cdns3 role start function.
> >         - patch 1-4 correct the code format.(follow Marek's comments.)
> >         - patch 2 Add set 125M clock in PHY init function.
> >         - Add new patch5.
> >
> >
> > Minda Chen (8):
> >   usb: cdns3: Set USB PHY mode in cdns3_drd_update_mode()
> >   phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
> >   phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
> >   usb: cdns: starfive: Get dr mode from wrapper device dts node
> >   usb: cdns: starfive: Add cdns USB driver
> >   spl: starfive: visionfive2: Disable USB overcurrent pin by default.
> >   configs: starfive: Add visionfive2 cadence USB configuration
> >   MAINTAINERS: Update Starfive visionfive2 maintain files.
> >
> >  arch/riscv/include/asm/arch-jh7110/gpio.h    |   5 +
> >  board/starfive/visionfive2/MAINTAINERS       |   2 +
> >  board/starfive/visionfive2/spl.c             |   3 +
> >  configs/starfive_visionfive2_defconfig       |  10 +
> >  drivers/phy/Kconfig                          |   1 +
> >  drivers/phy/Makefile                         |   1 +
> >  drivers/phy/starfive/Kconfig                 |  21 ++
> >  drivers/phy/starfive/Makefile                |   7 +
> >  drivers/phy/starfive/phy-jh7110-pcie.c       | 239 +++++++++++++++++++
> >  drivers/phy/starfive/phy-jh7110-usb-syscon.h |   9 +
> >  drivers/phy/starfive/phy-jh7110-usb2.c       | 162 +++++++++++++
> >  drivers/usb/cdns3/Kconfig                    |   7 +
> >  drivers/usb/cdns3/Makefile                   |   1 +
> >  drivers/usb/cdns3/cdns3-starfive.c           | 182 ++++++++++++++
> >  drivers/usb/cdns3/core.c                     |   3 +
> >  drivers/usb/cdns3/drd.c                      |  14 ++
> >  16 files changed, 667 insertions(+)
> >  create mode 100644 drivers/phy/starfive/Kconfig
> >  create mode 100644 drivers/phy/starfive/Makefile
> >  create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
> >  create mode 100644 drivers/phy/starfive/phy-jh7110-usb-syscon.h
> >  create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
> >  create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
> >
> >
> > base-commit: bc157bb6667ed97e33be8ce8436c28baa275b295
> > --
> > 2.17.1
> >
>
> There are spelling and grammar errors in the commit messages for this
> series that I would like to see corrected. I will leave that for
> others doing code review to provide suggestions.
>
> This series can be applied as-is and does set the USB over-current
> register which allows USB function in Linux -next (i.e. Pine64 Star64,
> Milk-V Mars). However if you want USB2.0 functionality in U-Boot (i.e.
> Pine64 Star64, Milk-V Mars) then it is depending on at least
> dt-rebasing 6.14-rc1 which is not there yet as of this writing, and
> USB3.0 then additionally
> https://lore.kernel.org/linux-riscv/20250102183746.411526-1-e@freeshell.d=
e
> series to reach dt-rebasing which is not expected before the close of
> Linux 6.14 merge window.
>
> Without regard to code quality or spelling and grammar mistakes, I
> have tested this series both with and without the anticipated changes
> from upstream Linux. All features are working to the extent that I
> would expect. For the series:
>
> Tested-by: E Shattow <lucent@gmail.com>

Can someone take this patch series? Else does it need another revision
from Minda? -E
