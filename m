Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149BCC28B23
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 06:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7298E81249;
	Thu,  6 Mar 2025 07:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F35880E94; Thu,  6 Mar 2025 07:20:55 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20731.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F350D80805
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 07:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1GnezDw0qwVN63Fp1finfupQ6PnGx+luvRy777kaVNHVZaUbXHEV9beHByidZSdqpEQkZ/2hvCDKI+jDDSlGvwUAKD5q/0Xqjfke5My1ihlSkVlV+sRbAlosK25wbFpKlMkeduUsL5zlDy2IzHKZZxJm/85W2kiMI2WYJYKswCUbRtQNxMppGinfFBZ1Za/k/I3yn83zzchvsWpjcQtUpv6IsF2PVsiKg67xv5XD7Afehg09x99ffl9HIgV2mHDQJFUsbJ4YkQVxNW2IrWv3gzdhDpt2JTTMdfS1kkMHvsPmSTsnDpHKsed7pT8kNBYSv8aG+tsJpc+D9evNdVk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfY5LFKoOmLFdcHXchPZCIDVUiWpKjQlmh+wkQB1AOM=;
 b=mqq8o6+ucersLOYIu72crtGS4Tqnwgpf95cL/c4xceSL7NrybKpgk+hA/aNC3mJ40kTr+uHlFYHWZf5/kNKNDFG3egO/ffYkdOurZ1nwaBoRs8f0y8WVTUoWtS29IBOhKC28CGqaTIHZIiMin4ZGXvFCI/QIe7vAfStdhfjPh8QssvpFRPg8435KzjxLVN8GJ2wY+5+kM0QZC0yk9Gob2n210saHyhDCWV864LOcNwHpAsb04+fb9TqYD2bn4SiwTyAJuFvPflHf+5uVgAO0LLLpCsDpqKbEA6nddfb5XoFNUizy0jTRX9gOX0SFhnLN5cDDPHfZHt4dLogeLYGCbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.30; Thu, 6 Mar
 2025 06:20:41 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 6 Mar 2025 06:20:41 +0000
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
Subject: [PATCH v7 0/8] Add Starfive JH7110 Cadence USB driver
Date: Thu,  6 Mar 2025 14:20:24 +0800
Message-Id: <20250306062032.50314-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::35) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d974c2e-1529-4146-111b-08dd5c7704fa
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|41320700013|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: j4Y8rDbo2XT3DZScVq0S/HUW9Bf+AREHhJ3CmlL65gEBonTmqDABA4siZ5zamYFuauWBdd848azZguOrhDaQ62s8rJ9QUoS6fMqrOZ5kyoa0u3/l0SPcroRMNxNoyQ5+fqIUwgunA6RjtdTBaV7suISvvupKjQ6rptE+XdJ2oSkkLe8dF88iqm+NTc+Y7Tj9BRZ7bIdr3ODnneDSkVJxGTqvve2koes67jHd66bYemzdGBKZopFQQ3x3trsnIa1Y+fkw78R+EpVLr9D7dTBC3wvFYX6Ppk28lVyVB2IgvQ2Vv+6+JHnXNLIFlKPxbyJsg6daOJ218b2wKgCI/o02FXDl4bHe3sWDBhpRNsxrB6sMIxgtvBRqL5hIoGnR8GdB1eFB0+XG/2gQq6Ykk2F/624jHxk5/VTQTsN4GvzWtuFI7qFINJD4erfkGz1bLZuUL5QsccfLnZ5wYRBezUSOUBIkmOomujq5Xc4LvS5JFg1Nqx/fH0/Y68KMHIEbKaxhnhEwAxLV22+Ts8+dYaTAuR9ZEvH2Gos31T/kCEx1WB7B7cy+8d0wnACb+SWcE0En5ZjVtLd4G4BFJRc8GUISW+M8YdaK/TmsnZFifV+bW7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(41320700013)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/R+B2m2Ht1mrTKuCziDuRlJ3jWC+EY1bqhD4EFlh1atiR/InNc9NFtkkPDJB?=
 =?us-ascii?Q?MJUCvWTjJEhMWS1qv9IVITGpe4XahDmRL1CVXL2gQVLkpkyDnmqDEOXrofdo?=
 =?us-ascii?Q?Izs+wZp2HYLKvrENHleHNAw/lh4NLbqfHlUarWFO2WQgsL+Vuu8UpzLWk2j8?=
 =?us-ascii?Q?rFQVuGcRvCD+L4Cpwhweouy16j5mOY4N7BgzWLzZOCmcxNjd2rjPP2NbA3l0?=
 =?us-ascii?Q?OasinU1TFMpUUlRB9mtoYQvVe/mHSjQQSfztTo69ekWQu2cQAykwd0/A1/Vo?=
 =?us-ascii?Q?wztTq0iCJQhPYp/gANxgh65bUuiJZHhMVxmoJm7cbGWIbR0BoxaM09Rd1ORT?=
 =?us-ascii?Q?N+8yGgiCQ+ocjRjFMMpk+c6LQOwjEaSNK2Q1WsayXV34VL3nf1I+wO9mBOrB?=
 =?us-ascii?Q?Grklt3KDro+AGWtFk7694H/Heq4T5aq1sEyjHCqaYXI2xSpkrCe1lhCk8uyw?=
 =?us-ascii?Q?e5AyL9NeeqDUIQnUg3b1NGkXFQQh5BmIPd8vAIHZadYFD1XQjkT6mNd4ZreS?=
 =?us-ascii?Q?caA+u/sUz6bk/6JfFD4r+po/jqK657InuNXjFUHu14602SiP3w2Yacq4h68E?=
 =?us-ascii?Q?A6GyRMkkf7iNlu/HiJkrQChKsd5Q4zGdhEEbVRHUET17GiC92CboTACpPOO+?=
 =?us-ascii?Q?QNYfiatpfM2FkSy8O0SIt1sHa7YDBfG9B0b+05MtHETFCkUCClM3U0sLvVRV?=
 =?us-ascii?Q?AzvKwS45In7JO6EctzGbu+R1Llp55omzKXS9F3cF/fdUqXSdVP/gWzUFt36z?=
 =?us-ascii?Q?QXoiT2u0Q01h7UXaWI1tluhTgRjT3PSTvhfvUtm3I/Z2nfCobpNLf/kL5qHL?=
 =?us-ascii?Q?cPO2N/HYcj1MZbHk0LIFEBu65TbGKDF1B71WEBe78Mg9Uq3/fkf1C80KjFyi?=
 =?us-ascii?Q?Zg8WRFryoXPVDgAeFyPP83YM5/FVS0jPqiN4RqgO7p/7sb0TqBTwQA7NhmRA?=
 =?us-ascii?Q?DvdeRHvTH/z3ENHa3GDuQ6aCTyHAAQmcHVxR88O8BONCaSioh1379iIA4xkn?=
 =?us-ascii?Q?KNN7FGfsgWmpcvMTep/hQPMHup5A4fCPFefmswPgcLIiAGTz3ANHcwY2pgDG?=
 =?us-ascii?Q?fjmaDaoYSKniXdJIJyBglQilT7MYIcnXoqv/JTGAC0IEzycZ7rRLR7mYkZqw?=
 =?us-ascii?Q?16G//Slo/TMVT6rqM0BsUzaSfgv7v79igS8Bbyfw+gVIgk7SM8Q4k7YfaUs9?=
 =?us-ascii?Q?b859PuFR9UdWA592nJRoh6V0yKM0BDgeC8dS/4PuttkgqogkX3YFya2kLxfw?=
 =?us-ascii?Q?3pNjJXuh4QzOUExb5Aa7G9/a1SAvmhgqs4iH/d1l7VY9nbG5emNo7V+ugKUg?=
 =?us-ascii?Q?gid1Ieib3BVWCYvrQmffuKQ4afTXHAAiph3pRKmuA0/k+VkNUy/93QeJ+Ipc?=
 =?us-ascii?Q?rbZbsf9tJKHfeV8qSfLSOhnj4bggiq9VNXGwljM6+ZgGuUDfmhfIWn/idJfq?=
 =?us-ascii?Q?QpiPwS0Y7/qAfLhiDhYAgZ6MJN4fXFDneunTSq2HSyy3mmMtIjKgeOmO+cYE?=
 =?us-ascii?Q?R9+Mun9SP5pWCwKqbBdlD/RIUD0YPxMJo0/f4e+svKLBn1Yalcyb/o3fDFye?=
 =?us-ascii?Q?7SxkPmOyTZ5S62lqEaJB66NHGXcb1+cqJwiGQ5QWkfuIHOqXD9amPV08Aank?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d974c2e-1529-4146-111b-08dd5c7704fa
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:20:41.2030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLX6deAjN8EnERoY+ilTNWHNz0b4XsP4RPc7UNQQW1MUJIrnvlsyoLx8yB5I+y6v0zmJ8KyMhGMRo6LlffvS6lfWpMA9fVSCWbj9a+nMDkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496
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
  v5: https://patchwork.ozlabs.org/project/uboot/cover/20241012031328.4268-1-minda.chen@starfivetech.com/
  v6: https://patchwork.ozlabs.org/project/uboot/cover/20250123010112.78924-1-minda.chen@starfivetech.com/

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
        v7:
        - Add reviewed tag and test tag.
        - patch5 sort the head file.   
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


base-commit: 274dc5291cfbcb54cf54c337d2123adea075e299
-- 
2.17.1

