Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD0EC30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 05:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6746888A9;
	Thu,  4 Jul 2024 07:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5342885BF; Thu,  4 Jul 2024 07:50:31 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 910A7885BF
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 07:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMS/sbMDAeTCkHpEflji7yErzEsOCUljFX0k4wM7kQubKpPCoFwmKlNrGJbthqQ3Xix7KZoEHSk6NGJDGIl5aCcqfcVUhPjlGFeDHFU5xzE4yjeqLTJU7MsA3DMtP44dG5YL9lf0Y6vyOhAwB28lUtij8F4CZJQkNWyEeQyItNOgp9zeHdtbJPhCm+xXkmvEyhGr/vSlyvVTlr47iFqLJk5fFLt7fB7lgg3IP4TKZ0p8dkOWkSlUX7OdDKuGtKE4adpIyDVNfoMVOe2poOGYYCDjsphQZH2aH6bU/ys5E7qmZE87lveGObtSqlpcVxnPN2GB7J4b24qfeBWBjIfvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QXj35w11mUN+6f97HVXRHf6IFikdGit+qFoeNRtzo8=;
 b=jfkeAyigqwvGB4FMYUhq1lcjKIWqwR49eecN8Q3GbbYpOwEGF4ipD5ZHQco+HPJDbX7QXW6xb/d9n0mhTPvK93VQ44X3MOBvTawMeDCYrZ9KcKT2JBoHf11kZtdhoT0W4aiKW7JaWpClPOmRpGI6N8RT8XHxO9pYTFFFhIaqh9r7t98O5GBqYBNYzyrN3b/OrAsckz49ft/EijWXPqx91gs00v68TaLdH7lPTvNFN/TwM4gpD/QKQdUKXqiPD/KcMlrghQF9kR9sS47Rft6gV+GmeK//LP7wrWg0YfN9gi1VzaUs8Ru1OHzAe9hb/7mAmxD1LgC9Lfjcp40HIJoS9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0766.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 05:50:22 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7719.029; Thu, 4 Jul 2024 05:50:22 +0000
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
Subject: [PATCH v2 0/7] Add Starfive JH7110 Cadence USB driver
Date: Thu,  4 Jul 2024 13:50:06 +0800
Message-Id: <20240704055014.55117-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0766:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b97868-053b-4160-1d52-08dc9bed31b6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: bp6nvBiQdEiGBw9OdNUiG1LCJKQY+QYlVuk97YGvqiFkNHSRBei9AS51V+OIxLTNlApJ94qjFnAMQBivOML2JuOtJyz3PEDdAxcRX843B4T7EyjiuSs+tAxKlMXX3KG0pDomapl4DptYE+gcWMm5uqe/7eQld0P2zQTbkXk0/VYWmCSWTYvX6gd0HB+geUjXKGuRZRkilLcno9UFk/b5LFAYitB30jO2RxdhoAP7S/YbJqXZw5yC8sM6+wkob80o0oYZSAl5ja3NjJ5sosq1QEpMEkSFqcmQfa7wQsKOa1OLgDmh/ogCHayLj5uyaXV8laj8NKuTgAOTYqjcBY2lAjL0ilnMTX3re+42cJLW9q+qk/2cnt5udCGaOXuzLpxwHVAhybk53d9MQRR6neBS7IOm2ZWn12yxWYc8NSOojoJ516BXWVT2NhP+HXFfl9Jx1O0BP5CaLuFCHLdtWBYJGoJXn56mQvNzYjZEsQ1uyK52ntTNniS0AocOp2AWesIZvoSrURlNPW1BIRwpwordN4Ts5Py2XOeLmyTELKeJLnkSLNt8qd5QpFeGROIV9S+LWSD8zPsqQrpNKuY0rrH7CmFGbTIEaeWWDtYfV8Xn+d1+vRBMsnFTkSLLm4zpqQOZf4kQKNfMYyOvLzqKFh7mmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bRcVzfW5sOjaNvutxgYbjP2WlNDHaQZCaW3KMokB/feZwCeWfxDjnPMGQiPK?=
 =?us-ascii?Q?6PfUazx3k7MQK64iuK45fl/RUPmIRYOH/NNx3472rbl4zI/xNemr4e4ckN9A?=
 =?us-ascii?Q?sD2ZQiTOKJTkegsr2IDJgI8B5phgUZ2WaRiHMvv/InhrBVzYTXT2KkUvsRx9?=
 =?us-ascii?Q?4i7L8KH/iMejp9aF31yaLgRQK0WnagZDmgiD8+eSP31dUKUcpk8+wld7ehrn?=
 =?us-ascii?Q?g9r0JjYtXNfJUn9a7R1WnB0h0lbUaXSTuBxG94DEeSzXYVFcCKNbxHR1deEx?=
 =?us-ascii?Q?dPh4ulaahLxDA5YF9t6qcGBobJKbljgEx6C47gGTDdMad6+TZKYzyQVdictW?=
 =?us-ascii?Q?OUC2jjAIKZVX/H+t2jbYn2kpLQM0fnvniIiPruE/ouXeEP1fnlC1bSVnNifK?=
 =?us-ascii?Q?P7MiRrINGyFbPaEEwYSQ4wY2FjNYiG4gAYQcr/HmOvlMyLepPINAYgjE+KGq?=
 =?us-ascii?Q?mnnGRLW09M8YLAgmt70VLNbM8yWzA3EqASYIU64QxkiTeTT3a5MuTBZTFyyD?=
 =?us-ascii?Q?PFtJQYQc0Vdwluyj4ksa/34MxFCr2dzFOOv1CR9jrU2zdYqzCF6Nr9QjYM9e?=
 =?us-ascii?Q?VbgN2s92tY0t6pbRBYTOp57+5s6nRiydEqOEASY+iFLpR6FL/9DzDpKdPZru?=
 =?us-ascii?Q?Q3uxhSVYh0j+KF7MDLG6PnUUv1tsVXXsQ9IMKkHc96ugcVasxEHBSvIxAFha?=
 =?us-ascii?Q?1FIQKUsO87RKelDaxSMh+2cH+jWxWoXzGeGpkz5z/Eg0zf06ZA6iO0HeKDnO?=
 =?us-ascii?Q?d6zr0yEFSGp+FjALRqtNXnMcf5/X6p5H6XMVEXNXEHgg3StVpE7iLz4mXbbZ?=
 =?us-ascii?Q?GJmKl3cMtkdkAd+zBTWMHbs6B56RN19gqwKoJTNIWYjHXESga9XFobldof1q?=
 =?us-ascii?Q?8zik9prifU+PzQpATkTgS19sY0wWW+j4rWDi1fxjD45ESmxH1a7wrPJnT9iT?=
 =?us-ascii?Q?c+KJANG9m55LHNLd6SXtbm9Jpsy7mcXEZczUmAEG6ChBPHbNmOdaudpXp7h0?=
 =?us-ascii?Q?2dbp/ESEHv0nICzsuVuL9zRJZ4kIwwu9aI3IfMr9zCFe6OHDASJwTy2cHqcg?=
 =?us-ascii?Q?bHyqeaySf7DYy4ChaFpkrbPeTZwAq1kuhiUTaaI+8ZSOjchnsO7g+/yVRZNH?=
 =?us-ascii?Q?wPBbjaHjCKg5vRDehTCtnEkgATUCmahu36H9itfzfmoAei6WG6uw1gfB87hS?=
 =?us-ascii?Q?OmLMNqSEoKnjMEsylM2K1EEL1etEQS8TzSD6yHirfCNnNwnJ/HlmG0XDw7s9?=
 =?us-ascii?Q?/dn71BMk516mdzABCOLICyLRdkodHDEhzeC6a8FZb3eS0uqw4PxGNWySB0tz?=
 =?us-ascii?Q?DLGRm+lmNwG8q5nLiaq10RKrqp8KoDSEMuF5ujudsrGpip0XXqm4lLnx+T07?=
 =?us-ascii?Q?rHn9cgO+MAV23R6ppsZh9VyMy3LTZ9CP+i7M40Oae7saxJ1D0mBtF9d7qyne?=
 =?us-ascii?Q?YjsQ3Xxn0IzQbWDyuXLm5V+/fM3KKr9qEEyuBLVN9C1BKe4TqLeehe3iyNTj?=
 =?us-ascii?Q?wFlpVm2LmDHUKA1NxAx0gyrB/DLxMV7FC987xQTeVwisJPldkR6p00nZ7zMc?=
 =?us-ascii?Q?CQxHj4/8I7FXzMNt+xMy0fSJ8vJq0iBilE0R9UVRWfm9CAReFu4CG/exw13v?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b97868-053b-4160-1d52-08dc9bed31b6
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 05:50:22.8445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lQXp57UF2+7C34vOTS8lWeJbAYmnwUViIwID37yMfALvUHVf2ddGHZQj5bWoF4EcVlvHk8rNf4z5FJ29dDviWupADrw9NsqRev2pnjMw9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0766
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

2. related dts node setting.
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

- previous version
  v1: https://patchwork.ozlabs.org/project/uboot/cover/20240504150358.19600-1-minda.chen@starfivetech.com/

- patch description.

patch1: Add set phy mode function in cdns3 core driver
        which is used by Starfive JH7110.
patch2-3: USB and PCIe 2.0 (usb 3.0) PHY drivier
patch4: Cadence USB wrapper driver.
patch5: Add JH7110 USB default overcurrent pin.
patch6-8 dts, config and maintainers update.

- change:
	v2:
	- patch 1 Move the added code to cdns3_core_init_role(). Must
	  set PHY mode before calling cdns3 role start function.
	- patch 1-4 correct the code format.(follow Marek's comments.)
	- patch 2 Add set 125M clock in PHY init function.
	- Add new patch5. 

Minda Chen (8):
  usb: cdns3: Set USB PHY mode in cdns3_core_init_role()
  phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
  phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
  usb: cdns: starfive: Add cdns USB driver
  pinctrl: starfive: Setup USB default disable overcurrent pin
  configs: starfive: Add visionfive2 cadence USB configuration
  dts: starfive: Add JH7110 Cadence USB dts node
  MAINTAINERS: Update Starfive visionfive2 maintain files.

 .../dts/jh7110-starfive-visionfive-2.dtsi     |   5 +
 arch/riscv/dts/jh7110.dtsi                    |  52 +++++
 board/starfive/visionfive2/MAINTAINERS        |   2 +
 configs/starfive_visionfive2_defconfig        |   9 +
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/starfive/Kconfig                  |  21 ++
 drivers/phy/starfive/Makefile                 |   7 +
 drivers/phy/starfive/phy-jh7110-pcie.c        | 202 ++++++++++++++++++
 drivers/phy/starfive/phy-jh7110-usb2.c        | 135 ++++++++++++
 drivers/pinctrl/starfive/pinctrl-jh7110-sys.c |  11 +-
 drivers/usb/cdns3/Kconfig                     |   7 +
 drivers/usb/cdns3/Makefile                    |   2 +
 drivers/usb/cdns3/cdns3-starfive.c            | 183 ++++++++++++++++
 drivers/usb/cdns3/core.c                      |  25 +++
 15 files changed, 661 insertions(+), 2 deletions(-)
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c


base-commit: 8937bb265a7f2251c1bd999784a4ef10e9c6080d
-- 
2.17.1

