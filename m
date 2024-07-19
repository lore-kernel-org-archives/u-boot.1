Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A92C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 01:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FCEE88B59;
	Fri, 19 Jul 2024 03:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D73B488B52; Fri, 19 Jul 2024 03:38:39 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EB3088276
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 03:38:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9HOgZ/eOQbCO7mK4zmbNrbdEmOiobMx7kRYjciBqel7B7s0XXeIYBXdse5BO0vqDB0lrPYdnWQUCs225rLeZAF9b6ASD0tqg+4v9oFnLcY1iC5DqFqVfy8WDelqqubqgPEme4clMfMObU+/DxUCVfM4L8V67gTpdpnYD8umpMX7plFK1zl/Z2K2jFeWZUCVChIyih0XNPGiq7oPYdexKyiic4e97uRdr3tIaVD6m+h4hq0ZzeyUQ8CLyYGjsMgYUiZfAsQg09WpOy7RLB2w3tC7oOPefImBrhWY9LFQWZDeaIQHnDLwjR3uy3JZ5fvjilIOux+KKdlJljGjzsSYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRPRia7wfb7xB6xYFePVkNChbvJAr4kSeJ8uWBqJ6R0=;
 b=SktR5tls594n2+bK81JwlV1euZwIFvYxL/gu5b72Q8LUCvILR+leeU3pkt7YOEvPnx4rvRKiBKkbrvj0YNa6+3ZKY0vVCUhK09c88EvMD2VmGbwtPcaG4CT7qF06JXF4PODoWmriaUgoPh3V7JW6GV/Pq/JHpm83LcxcJr/8cTnjsucDpNnGih2C2wepiY3+haP+r4XcOSaY4CN8YiZ5uZxJIaWvHB64hy502lXLaGe9slbRkESwpe3ndHeTbb2fBBVAMo+V1GnmYNt9wZ5HvKvJQeaYwypaUsOzcDJfzEUb6QNQgA7poxc2BgKgv/oq3dJstJh0srrN0yMcdLKvPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.46; Fri, 19 Jul
 2024 01:38:32 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::bd9e:fb57:ebf7:9d71]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::bd9e:fb57:ebf7:9d71%4])
 with mapi id 15.20.7741.046; Fri, 19 Jul 2024 01:38:32 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v3 0/8] Add Starfive JH7110 Cadence USB driver
Date: Fri, 19 Jul 2024 09:38:14 +0800
Message-Id: <20240719013822.101374-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0623:EE_
X-MS-Office365-Filtering-Correlation-Id: f161a349-6e33-4716-7547-08dca7937f9c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|52116014|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: Lw/DbQAbQJOehsbfnWVWdJ3NO2xjSNF9eKHyQdYi2JGPzChC5OS5IeLetyEoDu3BERPIJ9MRxZURlugoXawcEYMkBuBRt6yNC1t5GPER81q3sN/ZzGy2sEJde0+36ihObWZALWK0ttEEg23M0K+KvxO+Ec3IPQ2NTyy5tbFdGlNCXl+jqlRCaw/IAdZzNulytB2yveaB3un7T6NOm5xdCD9R43FIpDJwM53ku3uOdj5o4Gn6VHVKUC61/C6GAYv5e3PcSMCK93jTNaJyAUAEJQHsW2nVvZck7NLVHrm9da7KEhTtbqd63mBRMMnSQPltggQdISEoNkI1Ka5sn78zGqSrT5Ns+gOPykkzkdIdGEmsDCKW0upOmazbebI2pL/OMZNjmiZwDmt2go04TV0E03z38mQxrl/ptWGlkgFi49IgcW9rHggUjUo21IX7VzvuZdKkJIX20ChFbIhnmUlFRpecesg5YD3JRLjHMQJr46ZwWLJsxc2Aa/Iv58FWMvZQa9QXmGLrTK3bALvd5QGOsx5m+AeW1Jv36pg+2RgdddDPeWMUFRadBSWKaJNZstujNWg9kcD1893rLPwpNkY+DDrPz3HDPXAhYnCWK+Ma0hOAkahJ/Ccv0cywlEfWRtwQjIgX5AePS0PCWoTTKXTALA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(52116014)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t3q/ruRvkDnLuEGQMY/cz5r2/3fvVbcJofyjhLLXz+ddLFLItdHwom6K6z9/?=
 =?us-ascii?Q?7dJBYbeOjzUsFft08xdawawwgDFENkrH3de4kPoRMmVyzCpsYhHet+hd8Aip?=
 =?us-ascii?Q?iPuHHJmx4gzS8n5ErGIAN3Q3DyPi3EHv2gUGVZIfQCqzxkJ6i1do5YAfYiX2?=
 =?us-ascii?Q?tOuMIVuXh8MvffTf9uOV/r9x9o+QMBuQbxlq93Ts4sEcJrAeU9sKE87jpvlO?=
 =?us-ascii?Q?/heHRlnUnQ+5q+tJ64vulheXlZs57tAlu8/6eltxzcHkGMevAuVXPVaYDSdj?=
 =?us-ascii?Q?sAxksYgk46x3pIvmbmKFLTaqgMUsgZ6toowUMdJVb9JdryyAPcMxTu2vitD/?=
 =?us-ascii?Q?3Ha1IEM4lulnHlx4JuhtT0oBL96DwK8tqMG8DdpmIHfdsIH9bb4gxbDNuhhD?=
 =?us-ascii?Q?CNNIXv15wh4Pyh/52RoLQWp5DcXadJ9uOG1Ou0kdboaQ2F+fY2bOMtxwWPIc?=
 =?us-ascii?Q?JxVv12HOmq5ZE1ucsFE/fQeQQXmFQhgVDpCJiiYDTWztT1g1xN+jwsLDxBIa?=
 =?us-ascii?Q?yz2nZKT902VAgF12rZx+uiACYUgn6Nb27VFuP/e46RTkCNaHK6itaynf87tW?=
 =?us-ascii?Q?l+ZDynQn1IH7FFRyhCqrKMRkQNdvYuwbZFjyIXsyYHgRbKrqL/qv9dWQBHz9?=
 =?us-ascii?Q?Jy0Wj8DW0dH/odtmOCyDM0jpXkYqS/ymtnHAmLsqi6vCrxHpqYk3b0idsWbH?=
 =?us-ascii?Q?GMAbMr+AUyzz7Q4v1tlWYOSkFalHmVICuP49LSrRFrNYqTXPoc+5W2w9n54n?=
 =?us-ascii?Q?n4DEyNsKzwB3hehP4sAIIGdLCFTzh0YmPrJTzgpauI+cXSfY34VSuwVaAfjy?=
 =?us-ascii?Q?92LQCSkjt9GJqRvpgSp8ZNyvPSDFu76SoLACBfcDYCAwdnLDCzP/sD+LGcf4?=
 =?us-ascii?Q?8ZLvOswTV+3vP5nHX8WYVm8uTI0MFJG0L1eUIQta1rkKzBLU1qiP4jhmFfqD?=
 =?us-ascii?Q?nxdkq8MdqrVuGl9OA0g+UGidHBTFzgzH3ScuOf1SlzQdi7rZjB6rv9ZDM06A?=
 =?us-ascii?Q?Noli4gQu341jF/Hu6iapCx2vVuJFUYg+kYe7C/45P1fkBZNZsQq9bFWT2qsZ?=
 =?us-ascii?Q?hVO5asfVR/Kwv8zlW+7hkzFK10hYawVG6wb1Ob2ZLk4kYx5WIjDDpFbXWMfb?=
 =?us-ascii?Q?W7uIBIQuxwhkqupWP2RIAryHRJm/FewsqVAAwBfw9Pc9hfpKAvILFUJ7ExLC?=
 =?us-ascii?Q?eZ3f6x8mq1ITCJ5kvg63dB2HLJBab3Ychp4UvEOeFLwRVFTcU6zKR78sgbaF?=
 =?us-ascii?Q?HWOjXo7ytDD6U3mg7KRkRrnEPDMAqYtBaIdlSpfCgvEY/A7/lzB9PZ9dkNuZ?=
 =?us-ascii?Q?+686YJS+Bsmz4cisTPC/YfnHOA8XZEe+s/tf+IJ/hgmyCTQ4a2pvyF5Ms6Ys?=
 =?us-ascii?Q?yAn8oledu1SRlTp0PAi71issKptBv5nQ1vmTskj71i/Zn2LjZgGponVrFlOn?=
 =?us-ascii?Q?Her35oL7dkhfz8Q4USrl+/cPV5lrPBpy+LcvkUx+1BxDjFngctco8afS6YpT?=
 =?us-ascii?Q?etr3lDI9q5tayz2HwJNrlmjm75OIWXE6B7/9oPnSsD5AbFXarJYfxnSAYXqr?=
 =?us-ascii?Q?iBWZjVVQJHGgas6pae0E1jEfzmoQh21zRE24t7ogeaq3PdtDpB5A5SY4Dcxv?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f161a349-6e33-4716-7547-08dca7937f9c
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 01:38:32.3995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPUN7aM6WmvuHkjrrkghU7QyriDYsdjwE7I6ADP3OzaybXIv4UnJy06RVf1EDMwJLZW5tOZLrX9a3cJC9D4qjxFzwXAPjLrdt/WaW+GSFqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0623
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

Add Starfive JH7110 Cadence USB driver and related PHY driver.
So the codes can be used in visionfive2 and star64 7110 board.

The driver is almost the same with kernel driver.

Test with Star64 JH7110 board USB 3.0 + USB 2.0 host.
The code can work.

- Star64 using USB 3.0 and USB 2.0 host must add below board dts setting.
(Vbus bin setting. If usb host in Other JH7110 vbus pin is not GPIO, don't
require to set this)

1. usb pin setting
	usb_pins: usb0-0 {
		driver-vbus-pin {
			pinmux = <GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS,
					  GPOEN_ENABLE,
					  GPI_NONE)>;
			bias-disable;
			input-disable;
			input-schmitt-disable;
			slew-rate = <0>;
		};
	};

2. related dts node setting(USB 3.0 host)
&pcie0 {
	status = "disabled";
};

&pciephy0 {
	starfive,sys-syscon = <&sys_syscon 0x18>;
	starfive,stg-syscon = <&stg_syscon 0x148 0x1f4>;
	status = "okay";
};

&usb0 {
	pinctrl-names = "default";
	pinctrl-0 = <&usb_pins>;
	status = "okay";
};

&usb_cdns3 {
	phys = <&usbphy0>, <&pciephy0>;
	phy-names = "cdns3,usb2-phy", "cdns3,usb3-phy";
	dr_mode = "host";
	status = "okay";
};

- If other board is USB 2.0 host, Just set dr mode is OKay.
&usb_cdns3 {
	dr_mode = "host";
	status = "okay";
};

- previous version
  v1: https://patchwork.ozlabs.org/project/uboot/cover/20240504150358.19600-1-minda.chen@starfivetech.com/
  v2: https://patchwork.ozlabs.org/project/uboot/cover/20240704055014.55117-1-minda.chen@starfivetech.com/

- patch description.

patch1: Add set phy mode function in cdns3 core driver
        which is used by Starfive JH7110.
patch2-3: USB and PCIe 2.0 (usb 3.0) PHY drivier
patch4: Cadence USB wrapper driver.
patch5: Add JH7110 USB default overcurrent pin.
patch6-8 dts, config and maintainers update.

- change:
	v3:
	- patch 1 Move the added code to cdns3_drd_update_mode().
	- patch 1-4 correct the code format.(follow Rogers's comments.)
	- patch 3 using regmap_field.

	v2:
	- patch 1 Move the added code to cdns3_core_init_role(). Must
	  set PHY mode before calling cdns3 role start function.
	- patch 1-4 correct the code format.(follow Marek's comments.)
	- patch 2 Add set 125M clock in PHY init function.
	- Add new patch5.


Minda Chen (8):
  usb: cdns3: Set USB PHY mode in cdns3_drd_update_mode()
  phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
  phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
  usb: cdns: starfive: Add cdns USB driver
  pinctrl: starfive: Setup USB default disable overcurrent pin
  configs: starfive: Add visionfive2 cadence USB configuration
  dts: starfive: Add JH7110 Cadence USB dts node
  MAINTAINERS: Update Starfive visionfive2 maintain files.

 .../dts/jh7110-starfive-visionfive-2.dtsi     |   5 +
 arch/riscv/dts/jh7110.dtsi                    |  52 ++++
 board/starfive/visionfive2/MAINTAINERS        |   2 +
 configs/starfive_visionfive2_defconfig        |   9 +
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/starfive/Kconfig                  |  21 ++
 drivers/phy/starfive/Makefile                 |   7 +
 drivers/phy/starfive/phy-jh7110-pcie.c        | 237 ++++++++++++++++++
 drivers/phy/starfive/phy-jh7110-usb2.c        | 135 ++++++++++
 drivers/pinctrl/starfive/pinctrl-jh7110-sys.c |  11 +-
 drivers/usb/cdns3/Kconfig                     |   7 +
 drivers/usb/cdns3/Makefile                    |   2 +
 drivers/usb/cdns3/cdns3-starfive.c            | 191 ++++++++++++++
 drivers/usb/cdns3/drd.c                       |  14 ++
 15 files changed, 693 insertions(+), 2 deletions(-)
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c


base-commit: fd46ea0e701920eb205c2bce9d527bf0dec10b59
-- 
2.17.1

