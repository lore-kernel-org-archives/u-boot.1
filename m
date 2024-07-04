Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAF6C3271E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 13:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 788EC88476;
	Thu,  4 Jul 2024 15:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="R/ZNIh7T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13FC68886C; Thu,  4 Jul 2024 15:26:13 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B19F38823C
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 15:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1720099540; x=1720704340; i=xypron.glpk@gmx.de;
 bh=1m2ubSCOgqEZHlradOctb+rJQXEb8WhqvCcD25i/keE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=R/ZNIh7Tc4DCYz47thN/HmEA7onhR9zkhTA7Li8zRAvgpLX3wnx/Hk7UHSCQ57Ju
 OYip7qVTnAsUb+JfRyJpFr5Bf34U+ncVkldTBO80NhHcq6KuWgSD9D8huTOELLMPZ
 0hsj8lBgNFXcxibfgj9BgZtxrhoOmwr3ZkogVIo3WY3JPGMK4RroBofE2HWVKvOkL
 Vhtj9wQXzTVTsUTiP12tGdUtD1qOp94UzjDx7/M52qQs/WLKWCGWEUjDf6xS7sk2S
 wMfx/bVkRMvz+SCAE5V5oQkJdVXFmsCcYDGa0t9wkKABE1LLbZTM4EAEhbgcW4SVw
 UShz/c4GtPDc89d4HA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm27-1seTZ11E4J-001ZKO; Thu, 04
 Jul 2024 15:25:40 +0200
Message-ID: <9067a38f-1ebe-40bc-821c-e1cbeb49a615@gmx.de>
Date: Thu, 4 Jul 2024 15:25:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Add Starfive JH7110 Cadence USB driver
To: Minda Chen <minda.chen@starfivetech.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 E Shattow <lucent@gmail.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Roger Quadros <rogerq@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
References: <20240704055014.55117-1-minda.chen@starfivetech.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240704055014.55117-1-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QXOE+khCwGOltJUNnB4e4F0xLb1eFsqGKnawKd6wZcIfr0PfIUA
 CLBH6R7vk7JuoKtnSvYfemNeoSZrL/0E1+zLF2TUibHc4xfK/XOanfGv/tosjblcLi4Yvqy
 MlfsrFOJ1kgePw7CYM0lj71fnsO9bkKJaYxl14Bx5rLAE3Kv9bSs6gFOM1IhY8p8Y70F1sd
 WCu6UikgwQEU9RCoHCSWQ==
UI-OutboundReport: notjunk:1;M01:P0:hp9nbJH4eHg=;xrbCfsAOlleS9IPy++Nq+MPhUFC
 y58LNBuYZ3n4Po478kd6fAPu80lh47J4FDjCYg6BtR9rDkujjaQMm7qxfIfGM7ACSf63c0VDC
 3E8iXRzsiVxOSp7JxK0/IhZUDTlO4cjslGaU7vfGnY/gtITrnhz3lStwFB2DIRLaeovXuWW7Z
 f/gdAHWMCzhtaUQ8qK73LQ9hsaVFz90FlImVhrn4api0gxkt7y9ztB44JSMv8O7AOLZ8BUeIS
 oQXeMuvjqMcws/4o2yiTyFc3nRRegeGmb/XUR+M7n1edIYLBuROemtLu/VTIjNWJKv+qDBlcu
 EzEaHL3ztV9FnR2gicxsJeBzlv+q78BMwzVw0ASD9ircqlNB0W+o6DcQY7/tyjj42/97sGOUn
 MiiugwZZOMCguT74Y+o63Cg+hUgD0v4U3B8LZylfp5EB8ptcNwCaQGTqhKFEsN99OCB9lswqq
 GyKWUIb1phabbmMOBnN1AaSkmBaOiNrRDD1R++1HoefAltuGv8G7mrVc4IKWHrNzkT19rAXF8
 YyuTWPWrz/Nf7yrCYqiLL2JQoXsG0VTwsIVRBkjIJ5K0rIc1cOvrjRpoVW8Jxtndn/S+XitE6
 S4sDEiz3BGIyLIX/1p8IyMDB/JXqZRwIUs0+UrCbIVTxseGjV+dlZ9vTY/fJzbf7PfWfQUUnJ
 jpyCzc7/KWIq1FK8ynxFIFbQ4/p1tFwkF9UdMIaEk+ozUE8S37tBCgqwH/F/2JABWR6OdlsW7
 CABqLix+sBnVphZvq+osrlrRWqKH5z1rgpBWWfgWJdPq/ZKnllu28TLao4nqbTNbvnHtlBIzH
 J/U+QCaVRaWYFo81T3tiKBrBe0mvrIEXz4QmNuseMR9bo=
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

On 7/4/24 07:50, Minda Chen wrote:
> Add Starfive JH7110 Cadence USB driver and related PHY driver.
> So the codes can be used in visionfive2 and star64 7110 board.
>
> The driver is almost the same with kernel driver.
>
> Test with Star64 JH7110 board USB 3.0 + USB 2.0 host.
> The code can work.
>
> - Star64 using USB 3.0 and USB 2.0 host must add below board dts setting=
.

Does this mean a future patch for spl_fdt_fixup_star64() is needed?

Did you also have a look at the USB on the Milk V Mars CM?

Best regards

Heinrich

>
> 1. usb pin setting
> 	usb_pins: usb0-0 {
> 		driver-vbus-pin {
> 			pinmux =3D <GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS,
> 					  GPOEN_ENABLE,
> 					  GPI_NONE)>;
> 			bias-disable;
> 			input-disable;
> 			input-schmitt-disable;
> 			slew-rate =3D <0>;
> 		};
> 	};
>
> 2. related dts node setting.
> &pcie0 {
> 	status =3D "disabled";
> };
>
> &pciephy0 {
> 	starfive,sys-syscon =3D <&sys_syscon 0x18>;
> 	starfive,stg-syscon =3D <&stg_syscon 0x148 0x1f4>;
> 	status =3D "okay";
> };
>
> &usb0 {
> 	pinctrl-names =3D "default";
> 	pinctrl-0 =3D <&usb_pins>;
> 	status =3D "okay";
> };
>
> &usb_cdns3 {
> 	phys =3D <&usbphy0>, <&pciephy0>;
> 	phy-names =3D "cdns3,usb2-phy", "cdns3,usb3-phy";
> 	dr_mode =3D "host";
> 	status =3D "okay";
> };
>
> - previous version
>    v1: https://patchwork.ozlabs.org/project/uboot/cover/20240504150358.1=
9600-1-minda.chen@starfivetech.com/
>
> - patch description.
>
> patch1: Add set phy mode function in cdns3 core driver
>          which is used by Starfive JH7110.
> patch2-3: USB and PCIe 2.0 (usb 3.0) PHY drivier
> patch4: Cadence USB wrapper driver.
> patch5: Add JH7110 USB default overcurrent pin.
> patch6-8 dts, config and maintainers update.
>
> - change:
> 	v2:
> 	- patch 1 Move the added code to cdns3_core_init_role(). Must
> 	  set PHY mode before calling cdns3 role start function.
> 	- patch 1-4 correct the code format.(follow Marek's comments.)
> 	- patch 2 Add set 125M clock in PHY init function.
> 	- Add new patch5.
>
> Minda Chen (8):
>    usb: cdns3: Set USB PHY mode in cdns3_core_init_role()
>    phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
>    phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
>    usb: cdns: starfive: Add cdns USB driver
>    pinctrl: starfive: Setup USB default disable overcurrent pin
>    configs: starfive: Add visionfive2 cadence USB configuration
>    dts: starfive: Add JH7110 Cadence USB dts node
>    MAINTAINERS: Update Starfive visionfive2 maintain files.
>
>   .../dts/jh7110-starfive-visionfive-2.dtsi     |   5 +
>   arch/riscv/dts/jh7110.dtsi                    |  52 +++++
>   board/starfive/visionfive2/MAINTAINERS        |   2 +
>   configs/starfive_visionfive2_defconfig        |   9 +
>   drivers/phy/Kconfig                           |   1 +
>   drivers/phy/Makefile                          |   1 +
>   drivers/phy/starfive/Kconfig                  |  21 ++
>   drivers/phy/starfive/Makefile                 |   7 +
>   drivers/phy/starfive/phy-jh7110-pcie.c        | 202 ++++++++++++++++++
>   drivers/phy/starfive/phy-jh7110-usb2.c        | 135 ++++++++++++
>   drivers/pinctrl/starfive/pinctrl-jh7110-sys.c |  11 +-
>   drivers/usb/cdns3/Kconfig                     |   7 +
>   drivers/usb/cdns3/Makefile                    |   2 +
>   drivers/usb/cdns3/cdns3-starfive.c            | 183 ++++++++++++++++
>   drivers/usb/cdns3/core.c                      |  25 +++
>   15 files changed, 661 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/phy/starfive/Kconfig
>   create mode 100644 drivers/phy/starfive/Makefile
>   create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
>   create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
>   create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
>
>
> base-commit: 8937bb265a7f2251c1bd999784a4ef10e9c6080d

