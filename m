Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F734D1A427
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 03:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FBDF88C8F;
	Sat, 12 Oct 2024 05:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4369688B55; Sat, 12 Oct 2024 05:13:57 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20708.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5804388A4C
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 05:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bgb4NA0Z+QWMR/jpGNqqpn4WqUjEBSRwL+4i+9lPVr07UY9eDSY1F0b/rv77oURl+qgJX+GezAq6DSWIE6Cn1N25XQGFzt+ELNlGUka3y37MWVQfMZNc0ysVMBqQVa3hoskWG/MmiHJRs4AXqy8i1JS+EYp3vEKaWOVWQmqQfOUSLOWo62Y8RQ9OU3cszqWhTCWA3AGASHvRFXYdEIQzAnckXXYf7yo1u+10nYW8uFeOXZJh8cn6IYpVFBLQvnWktHGfJnSEpB0os895GQjJRAXMvCyX1d/gAD78PJfCPk7kehZMQCf1bZMN1Jymfux5yV7yl00VdNDrqlF39eWi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YT2qoDni+FF3x9bT8Q6kUJatttUw7HXWUrARgVCgpok=;
 b=DjBaNaWaZ7UxPGvIhUaPHC5me8gbTD74iM+xwM1QVeMxpf4TXrsBujmt3LIyAbJ7Hdkwo73dCdkt5tRT1Smnf9D0dgnldFHTtWTgJaU34muAyco40Nbj9BCERYocdOXVN19D5EyTv1ocvozxkvNfQ0ZXg6+0xSHIK7zCxrsmxk69/6lMxEcdEd+g+KGHbuq9WTehqqoqoRuIs/rnIX0vyu+5MZtvtzjmUHphHgq/4AZsI7a5+OqYiGjeVD8BaZDjNw4luRWtw1MteIqTqOU8n30Gy/Qj/B7k/Z+xufSNAbx9SAT6eosYkXHucW2SaebSum3Riuco71ftwBRg6IIY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) by BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 03:13:43 +0000
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 ([fe80::480b:a135:6e33:10ff]) by
 BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn ([fe80::480b:a135:6e33:10ff%5])
 with mapi id 15.20.8048.017; Sat, 12 Oct 2024 03:13:42 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v5 0/8] Add Starfive JH7110 Cadence USB driver
Date: Sat, 12 Oct 2024 11:13:20 +0800
Message-Id: <20241012031328.4268-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::26) To BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0850:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c5b95e-987e-46a2-edf8-08dcea6be070
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: ot23bFtQ4v8aItuNW1MEydIpQdlgPCSXQbcBE3Cb0QwBA34XVi1fHSoic9ZfiHL4PrhJ4ykhq+f7F/jVek3PHh4i05U2UY2xithU8pedAyIGsE4UnUQinul/BEZQEM9RFYMIqMu2YuMXt0NvTQ4trcK6Jmf3QY23xXGnJKbUEBRgVQ9OZSxWR4mMEavjl0QKln40g2JJ3z4/nyJK9sAzKUITbE3SDdVRRxAq02w5cCP2Z/ZG7QVV6xYCGukDWVBNT3VGNhiB+UyeZpC4dNMsIt76tL+UaDJm0lYGez1glBW97ihtDDqJIlNTBmEIbJE6nvknFZVb8l/JnhgLj/AYsqJZMyge3KXoOIaLmJVUOtU5qiEIucmlJ/luYwC1fbb5HBAu6PN9xA3l0aX9vHT2GtiDVksr2ZdtZSMfhgh02IQiqqAJ4zif9Xt1KnXoXK+TCC/7bbnL6GFgbLEZTCmhBKDg8otjh2m6+RyC3WLxlzO8MboBz3z1+sgCSStqGnXBq2SeUNos0197ffOJfN0IAyvYxkOxsuIfJ9TnB2yrEyQD02VFwsE8WjZlbHpGQqOzDT3AsQLCL7yN3p3JifbQL+AAj1fQLZuFsjJW2bbQhwaHYieuW5dRqVkil9aQJvLeMwUBr9cFyaOXh7vg2WBZMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I3rlvPv17JWGKpx3ZBCM4+RmB7NgqZZ6KVr7DlvQLHMguPNpWwBTWrPKUnM9?=
 =?us-ascii?Q?NrKsGm1I9sg5JoaxEhEumV8CUw9fK8lcWUCWYqyF5ZeDCWUppR9dWowjr4t1?=
 =?us-ascii?Q?BO+chjIkBjYwmh3gq1S+2kLsAuQsSGurRmSYJZpdAzCT4obf/6505RcJkvQS?=
 =?us-ascii?Q?ogR1zQvaermTb4ALjnt54oJ6zu26iNVpYYS9GCzIXrCxGsqIv/taK7YkKlFL?=
 =?us-ascii?Q?67QNkRnlkFvKPSBvZASW1Fb9zpbuH2/XCdiKRqbQA000AfO97DQzAXyY15hL?=
 =?us-ascii?Q?+XTvMw7fbocTFPdizys+dXLBT1VYHnekeujLNQBHdPAcUL8OJ8qK1kqxEMQe?=
 =?us-ascii?Q?q2nswoUZdTJg2xpkAxzBZiSaWDSFAmfa9WQoFNliZ0wJWaH+JjXQaYsnk+hM?=
 =?us-ascii?Q?nRCVjO44nFyqUNyrEyPVCwMAmeQUtvHHztCkLdmiGO3RXcY28kqic+TXWF2d?=
 =?us-ascii?Q?L9WAOlrpqvHnfn18/4Thg2grdGK+o5XN9+Uhq0PngU0EQNBug/vc840n7Qeh?=
 =?us-ascii?Q?C0mySxcKLgSQqGip7mRXEWvhy6PfAoRVbuS0nWOEgXCHlIjE5KyoXBjFeWsC?=
 =?us-ascii?Q?kBnsXAl8u6vQZoE2priQ0/csHHKH/WzqqorfuxGS7YAMA1nlMbYLLLW/NOp8?=
 =?us-ascii?Q?J5Vj6PxedokfvPc0UbBdMIiPTwHG1bhkRNKYuOA+KmWi1fSXR7/d5oSa2vDP?=
 =?us-ascii?Q?+pK7+5j6sZz1KaLRhCI2iWtCW1JkEyJUvqlSRHkEnkGAC6AyOQheLvA7s2e/?=
 =?us-ascii?Q?SVtUQBkYtryuax33bT0Ax8IimdBE7og4yY0+wzwJStBs7y0Lsxb9wLlQlAq5?=
 =?us-ascii?Q?BA3mltw6AiIiVSNofCKShSJS55jMddyJQk2M4+p1gAModb8Ltw+z5Mp0/1zw?=
 =?us-ascii?Q?jZELjv61rclA7UwcZLVSpL6Vcvw6/RcNncyOs5WSJRX+ElFlJzxRFwaugPQH?=
 =?us-ascii?Q?0rYrjMakwSrpyvwuoLmQPtA9wrquRIcAR5oe1KnxzpaB/+OW453Rg2t6+B0P?=
 =?us-ascii?Q?d2ezTnBNCT3UGTXzbZUsVpiz9iqAmxFKSrjYueoEiUA/QLeaWXrpyDQ9VLJg?=
 =?us-ascii?Q?xU2+iFnsIBZcVmWiOThLVgEfIKFF6Inb3vEezH5e3bqGQnN0yum7nRiRARXa?=
 =?us-ascii?Q?f0U/2nNLigew3MvEV4reVludwZwAj2xpFw7Fyia98/vuf+NaRfNUeumDyDv/?=
 =?us-ascii?Q?kmzb9GV32/wy5UAMN2buVNvFnH/DUV01JaZPJumiwdId610HbZj+Cer0Gq7L?=
 =?us-ascii?Q?viyPkf51Lul06cs8dv7yCHzKrT1YwwNTMSXxT4beNiAb25fh+mB0KerervNm?=
 =?us-ascii?Q?Rg9CwVCByzOlwBAP6WC/5jtGTmNGfq9AV/5PGIrNSVNJob+N9txvzHesaGRT?=
 =?us-ascii?Q?ShKmtgcs83FnU6fWe9wlw0elk9490DtFoOyZYep2jEeUBno3vqK6ZbV20pvv?=
 =?us-ascii?Q?e6appEnw56gtYKQ8wBTXNhHP0moRVZkBPjQklegzHPWXywb8h9ICJO9QXHuX?=
 =?us-ascii?Q?XW0YYcAANGyI/hk8qVbao9sSYaBN9RcnvY1zJ7/ncArwTxxsw8R06baBG3fj?=
 =?us-ascii?Q?Q+K9AyAOz+bgmR0gP5M/ikWLnsiiTIhzYJzrlculLtRY2ITjxlfsPlXS3skj?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c5b95e-987e-46a2-edf8-08dcea6be070
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 03:13:42.8769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKpQGr/+CNo/3TWfP9A0LhBtVlYVGPqtqcF/KjWUAOBeOST5KrS+6rhfHmcW/i+AVVVe/LPW8BP+RSEF96lx1EB2G5I0rjHwUPk6mkcKchw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0850
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
(Vbus bin setting. If usb host in Other JH7110 board vbus pin is not GPIO,
don't require to set this)

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
	starfive,sys-syscon = <&sys_syscon>;
	starfive,stg-syscon = <&stg_syscon 0x148 0x1f4>;
	status = "okay";
};

&usb0 {
	pinctrl-names = "default";
	pinctrl-0 = <&usb_pins>;
	dr_mode = "host";
	status = "okay";
};

&usb_cdns3 {
	phys = <&usbphy0>, <&pciephy0>;
	phy-names = "cdns3,usb2-phy", "cdns3,usb3-phy";
};

- If other board is USB 2.0 host, Just set dr mode is OKay.
&usb0 {
	dr_mode = "host";
	status = "okay";
};

- previous version
  v1: https://patchwork.ozlabs.org/project/uboot/cover/20240504150358.19600-1-minda.chen@starfivetech.com/
  v2: https://patchwork.ozlabs.org/project/uboot/cover/20240704055014.55117-1-minda.chen@starfivetech.com/
  v3: https://patchwork.ozlabs.org/project/uboot/cover/20240719013822.101374-1-minda.chen@starfivetech.com/
  v4: https://patchwork.ozlabs.org/project/uboot/cover/20240829013058.6178-1-minda.chen@starfivetech.com/

- patch description.

patch1: Add set phy mode function in cdns3 core driver
        which is used by Starfive JH7110.
patch2-3: USB and PCIe 2.0 (usb 3.0) PHY drivier
patch4: Cadence USB wrapper driver.
patch5: Add JH7110 USB default overcurrent pin.
patch6-7 dts, config update.
patch8: MAINTAINERS update

- change:
        v5:
	- patch 2-4 format changed.
        - For pareparing enable OF_UPSTREAM, patch4 get the dr mode
	  from parent device dts node not the cdns core device dts.
        - patch2 add a common usb syscon setting headfile.
        - delete v4 patch8 and the star64 dts setting can be setting
	  int star64 board dts configuration if the OF_UPSTREAM is
	  enable.
        v4:
        - patch 2 Add usb split setting, default set USB 2.0 only.
        - patch 5 move to spl stage.
        - Add a new patch 8 for star64 board usb host, vbus pin setting
          and usb 3.0  
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
  spl: starfive: visionfive2: Disable USB overcurrent pin by default.
  configs: starfive: Add visionfive2 cadence USB configuration
  dts: starfive: Add JH7110 Cadence USB dts node
  MAINTAINERS: Update Starfive visionfive2 maintain files.

 .../dts/jh7110-starfive-visionfive-2.dtsi     |   5 +
 arch/riscv/dts/jh7110.dtsi                    |  53 ++++
 arch/riscv/include/asm/arch-jh7110/gpio.h     |   5 +
 board/starfive/visionfive2/MAINTAINERS        |   2 +
 board/starfive/visionfive2/spl.c              |   3 +
 configs/starfive_visionfive2_defconfig        |  10 +
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/starfive/Kconfig                  |  21 ++
 drivers/phy/starfive/Makefile                 |   7 +
 drivers/phy/starfive/phy-jh7110-pcie.c        | 239 ++++++++++++++++++
 drivers/phy/starfive/phy-jh7110-usb-syscon.h  |   9 +
 drivers/phy/starfive/phy-jh7110-usb2.c        | 162 ++++++++++++
 drivers/usb/cdns3/Kconfig                     |   7 +
 drivers/usb/cdns3/Makefile                    |   2 +
 drivers/usb/cdns3/cdns3-starfive.c            | 183 ++++++++++++++
 drivers/usb/cdns3/core.c                      |   3 +
 drivers/usb/cdns3/drd.c                       |  14 +
 18 files changed, 727 insertions(+)
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb-syscon.h
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c


base-commit: c530f6079c70219e01022142b404bf8a6b572366
-- 
2.17.1

