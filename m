Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5686C02181
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 01:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDD02807A7;
	Thu, 23 Jan 2025 02:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68AC080214; Thu, 23 Jan 2025 02:01:32 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20715.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E63FC8001F
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 02:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctUXkUZ7lNYdkCgM4lT24kR9C7KdCAMx3Fh3BgO4Gyn0mWnq7LkngsX1gmycRARKOKmaD9pj6gAMpczTh6VqysCZkQbQfCcE/LTSbJdXXpVIsRNn2skkokQvIVI7w5nSMqfK9RMZ8LbSZnKEw6mLkIhMhlV+1uo1uf4SieXnsNTjkCSdEbz7U6/rT8wz8KZ+bhSSOBaliR8IJuLj9lqymHWQZJFpgHhb6Fes0miweGksAXtI3I+e6aPzF6T/rlaKR9KU3GbNOAI3GAZ6CR7mJRZL8EzW7fEpQ4qESozE3yDywC1IVjr+sjkZ29wvkSFlgkJHQKHv8ktTa+76RBZTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qOcSSJK1YNd8rVqZycfVw7WSfLWaH5L2x2ibaM9gik=;
 b=ekLsTraApbGv4oKClPKwhYLZq7ejTJinfGuScUogoFRr3w8rhFyQUXjWafiWwPz3BKX6rX6OsYCXLdykXEW666aylD5QRIQ0/st17uKFlspYsJV8LG+wM+arnEDl5o+x+M5DD4qNgAzt9AGhkEj/I+AGYcqiFMobIxmAgLYgV5dFla7QwK4v16tR9YGQAO/6WE6h1z0YSglsVuSp3wfhwUUEFIGoFptLLMUQ1T4VrjrNoyUfga3zwqZA/M1ZVLNHA61n14X2jr1XxdTuU61BQsVfhstYfoAq9uDGrUpZIBEj6DdpaGcoudJUWNR+XnXrS+zM0R9LRrC4kBrg/JKnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0813.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.8; Thu, 23 Jan
 2025 01:01:20 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 23 Jan 2025 01:01:20 +0000
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
Subject: [PATCH v6 0/8] Add Starfive JH7110 Cadence USB driver
Date: Thu, 23 Jan 2025 09:01:04 +0800
Message-Id: <20250123010112.78924-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0029.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::10) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0813:EE_
X-MS-Office365-Filtering-Correlation-Id: 22342e7d-5da4-4d0e-6602-08dd3b49730f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: ToREqKN48r51A/40IUYY8SFqT891p/Mk0I/JiiYKcqCjDTC9UQ3cLK/pRVaWr95hpqIlPg2sJb0PjDoR23oXep4g9QMOAcViJThOx+2HtS+wOYKY8VN8tMfreviCeDTTCCQFivqlHXU3pVcl0F6fS9SwcSoDEX6ZqwPTdJDNi/Ui35ugX7oyOSmduwxDCtW1dO36HDN0ibkxOGzYEVuerDE8uvdZsSvG3GdnHEcNLDbptgaIbhqMckSIZwkpWO+dqANbkVsCtTBXgUCrZbk85zII6T1XLqsNMHSYC1HCvcW4SFpfvs7EmDX2jo5MoYbVK2e4aElcTnNlHeP/W+C+S6+dNCzS8HT7gUN0D4ToKu2SdswyMQmNjjdBVNWlcFyQp9DhICNmjHsyod+q2pQWAem4cPV4TVkowdsnNTrunXOOD0sR0wzcj6oSJG2sSyE8tXnSI7GGTODY5ZmeBCo5wgfg5QCUxSrSBoc+HnE4wUxG8XS0ZcydlKB4ar9y7qcJ2OEYaukhpnpg8kwY+M4bdTzyZkxSFGEyuDJFOKu/QXwjt6vnG9Ssb3rd5YW7p7OvT1J5J95olpU92TlvBSPkJXXqO92yi4Iz0sQAqTPmHt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?geXKyA5/ocUMjVLz7KVGZkAoeUPmXJXMHrLWnVHtcblfoKpmc3LEeIPJoE+S?=
 =?us-ascii?Q?NKxUr/J+J/ci5tjJIS9YrN6eZGQgAA0T6dUJsMaItV6dUtAShWA7ec990sxb?=
 =?us-ascii?Q?lS95GKyXf60dowsQCICZyTlfNusgklTA5UXuNPOKGiFT11dM2BMBcos7D74C?=
 =?us-ascii?Q?A67deFKsBkWb6enEZquCXiBKdtYOgD4v7066WEynH3s6TeEZOHtI0VtogElL?=
 =?us-ascii?Q?Tfec+HHWXLoWauMI0F4Wpw4eP0kQAzziTWbyJFtS/DTHH7Rt/nAry2iLBugg?=
 =?us-ascii?Q?FVZDWJM627nQ7+VYBGqKAofm1x3TUsFMFPXXLx4lBt1YM1PbpfylpVjjQSKY?=
 =?us-ascii?Q?43LTLdy4GDqGkseNe6gf4JViDQ4vSM8s0PTcK9KWHoduGE6fdSCMQWIxXn0M?=
 =?us-ascii?Q?AAD3TMb5M0ma6G4TlQgDdMxDKPoLib1pjfaJrqzjuuwmPlvoltkDM7R+Xy5S?=
 =?us-ascii?Q?5BDPKb2f0sJ3VygHn5UmyHtUaInPKAyivSvMFP3xpd3Sk3xlA0YFEN6Yc+9q?=
 =?us-ascii?Q?a3CVQMcBexPtmNwMU5A0q2W5e/0gMn2HkO2ArqUdN6VcBdjNMvvVDRaViEH7?=
 =?us-ascii?Q?VXMnT9wIKxPjr1s4DyPYrNL+vJcnorQZfmBB01NglIFxO0wy1IN8TljgsP9e?=
 =?us-ascii?Q?V9s3tzWPUyjsfzNo9CGZIiRBPAUK/oDDMpgOku8W9wlGSm3uqUf460qp2VRd?=
 =?us-ascii?Q?Ru/mqHRWbCsKYUFjZXYy7haYW1lM9YYkXG5iX0msJooRPEPb9lB+Cy1fHS0c?=
 =?us-ascii?Q?CxzU7/37wKRqm1MlaXgkojNtJNzwtTerU7HGx8Ki9+sKq6Q7lv4l7togIEgK?=
 =?us-ascii?Q?/Z7YOh+XcaA+8CK7LXDqZ07MqfTQRxDSjJF4J/TtfHTnsSxHmr96ub2MSS8E?=
 =?us-ascii?Q?FkUoLM3t/89eBJCay1Nuq4TRGj2VXLV66keuL+NClkmKTzTdu+NnMEa3XpUx?=
 =?us-ascii?Q?yxKwqoP8txqWu43830yhGh/Hcq99I4RL0dovm4e6FLWR6NhKZHw/HY1rNQzH?=
 =?us-ascii?Q?P4CpMyudSz+1UEKAgH7qT8WIlGxDDG5KMpjteb9gEBlAazeJNMa4FWug0ulA?=
 =?us-ascii?Q?GZ2fGHteENAhuTF9apDxdRsZpgEhf4iTKaG57zNLaPvFH18+0MUjTTj2aNLR?=
 =?us-ascii?Q?ofxR2ahMRvj3czbSs8lqmYMkCA6T0Wf2OhqMUtVXVKbqraVFxLkMaQvSyvol?=
 =?us-ascii?Q?ZmjRuZH/YeZ5W6TwIzCFG6IKQoSD+MObH7Rnqjee29MvAp89eSxpjkeC84h9?=
 =?us-ascii?Q?+BdkxpFbbzwJ3g4evxx/4lXk27SAwBG4nQ4mUojJJJVkz2fWJ6w78pH7dxN2?=
 =?us-ascii?Q?kXNxbu7MVrXdHgWKUpDnqbPziPdmBuQ/ggjk2GXlm44p1v4OlCyZQCI7Ty00?=
 =?us-ascii?Q?aiKKJNvv66eWBg9y5z8EVK6FPgfhbT9ZicYG+n6PMptVLuz5y0iK+duyOObZ?=
 =?us-ascii?Q?fpgiRLJmFKU9wR6Pn6ALVIUcrkF9tQ0isTDGDNYZoRlIwAeuFFURabDF8hrc?=
 =?us-ascii?Q?4vI7iDvHCDtOJORxvMVfLaWb6i0muYm0uz7HW2oLBweJtm1JnihpQ8EtKmTf?=
 =?us-ascii?Q?csggwgO2pHwVKqC7iqWnS1Ad+IXWd0z+xWIxSpkqse+MqVKYR+FcRiU33kZo?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22342e7d-5da4-4d0e-6602-08dd3b49730f
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 01:01:20.7010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9aaZsvq2Cg+u71/tOYHAXbWBjUre138YkG2udW2/lHhaQbHjJo/wBU066JKVio77siV8XYOQ8QxyymiJp6CEWlkIhDWEELfmNZHQJj9HLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0813
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

The Starfive JH7110 has enable CONFIG_OF_UPSTREAM. The dts is
from kernel

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
patch5: Get the dr mode from wrapper device node.
patch6: Add JH7110 USB default overcurrent pin.
patch7: config update.
patch8: MAINTAINERS update

- change:
        v6:
	- patch 5 format changed.
	- split v5 patch4 to v6 patch 4 and patch 5
        - delete v6 dts patch7 because the StarFive JH7110
          CONFIG_OF_UPSTREAM is enbled.
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
  usb: cdns: starfive: Get dr mode from wrapper device dts node
  usb: cdns: starfive: Add cdns USB driver
  spl: starfive: visionfive2: Disable USB overcurrent pin by default.
  configs: starfive: Add visionfive2 cadence USB configuration
  MAINTAINERS: Update Starfive visionfive2 maintain files.

 arch/riscv/include/asm/arch-jh7110/gpio.h    |   5 +
 board/starfive/visionfive2/MAINTAINERS       |   2 +
 board/starfive/visionfive2/spl.c             |   3 +
 configs/starfive_visionfive2_defconfig       |  10 +
 drivers/phy/Kconfig                          |   1 +
 drivers/phy/Makefile                         |   1 +
 drivers/phy/starfive/Kconfig                 |  21 ++
 drivers/phy/starfive/Makefile                |   7 +
 drivers/phy/starfive/phy-jh7110-pcie.c       | 239 +++++++++++++++++++
 drivers/phy/starfive/phy-jh7110-usb-syscon.h |   9 +
 drivers/phy/starfive/phy-jh7110-usb2.c       | 162 +++++++++++++
 drivers/usb/cdns3/Kconfig                    |   7 +
 drivers/usb/cdns3/Makefile                   |   1 +
 drivers/usb/cdns3/cdns3-starfive.c           | 182 ++++++++++++++
 drivers/usb/cdns3/core.c                     |   3 +
 drivers/usb/cdns3/drd.c                      |  14 ++
 16 files changed, 667 insertions(+)
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb-syscon.h
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c


base-commit: bc157bb6667ed97e33be8ce8436c28baa275b295
-- 
2.17.1

