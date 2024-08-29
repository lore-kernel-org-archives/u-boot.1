Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFF2C7115B
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 01:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF3D488AB9;
	Thu, 29 Aug 2024 03:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6A4688AFA; Thu, 29 Aug 2024 03:31:17 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20711.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC0C488A92
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 03:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0JN5xcOIcHGlI6MuRrEWXdAQVzCW6DPY3qBf1KivfTGKR5LEAJXLfDemjnG5Xvr4F1DCaTbEqPLDvC8CplOEo1ulUktCWMDcpd1RKqKuYSFVzR+Oqva9H//ipMk/Vw35N49uY8C0ohnSk8MY82k7dZM5fALu8MjawieiRqSDdp1d5RL6LjHA3PMfh/X6q6Mny/2L+EsDkWv47ULCpThxoPzAVIz68DPBsYyDH/yoUGUMMxkPJkxPhODBMpZFpa1ezVMBg5IJ/NpeAVcuKS7TqeIjoBsgbMEGe0enuFJ6w9yKacroCpVyD2rWD3gnktlhjXs0QBnlRhSwjrr5rUALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H54ymZBw0AUBtNSwhClWR78Z7X8VlpMrBHtbm6RNhxM=;
 b=SghSMPbAFZ/GjnNw4O9U4xE/FYthCec4Mr3NBZ00nTbKBvkKzO+HLbas76/Q/wN1cqru3FdSheaFaI5zIC7ldZS8t57/EMmL4rK5pdWCdYqYLfjcmv33MlnAYEfEDereFq2paEcK5kx4Mj9I63VYXDcW9sVkZJNEghMzlctp/4Gpl3lq84AhdvjCHwXnOu94ETuo7JxBEqPyBt0IoxxMJsXz/M+Tqnp1c/BL/Dm6YfFrp5Nu5/w8743cWDE97GHhUpPbfSF4CNjXNEVuRvl4wkUncPFgz9qQyTzQNMKX/7e1tX+TQvOgOIPC62hFwJA6xvMCoBtbbmlla95U0BhDLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0830.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 01:31:07 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.7897.027; Thu, 29 Aug 2024 01:31:07 +0000
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
Subject: [PATCH v4 0/9] Add Starfive JH7110 Cadence USB driver
Date: Thu, 29 Aug 2024 09:30:49 +0800
Message-Id: <20240829013058.6178-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0047.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::14) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0830:EE_
X-MS-Office365-Filtering-Correlation-Id: 063ea6ac-4dec-4bf0-dc15-08dcc7ca414a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: m+k7vT3BNG2hiiPUoxewAHWDVVrMuSf8Ger6XknIUB0kJFc7AnFQvvh4GXt2Ckunw6D9TLl9krtLo6kCpnIJQ0aEWdMh0iXxd0DMor582d5YNMVxiZ7N3pK+SkgTkwqMp+XbhPSSrwQ1Xcxi2XVeg/0ONwoQgTIGqhvNKZbAWbFdTma7zvp27CJO7Tn9fWtTxbJPiY1H4dEw0+eJ/VzekCxLOZ1f3B/bgrH8TohdsQydCoK3Ms7URMQVJGrVsQzTpnS0cubMcDgrrJtlR9u8jK0nrNZl7hwALCvN7tUpqdvCTb7IM57R2KNz8F2zeDfy49S9DfYaNr7fz64ntYUWTIS+F/X/BCZnQreD307QPNd7HN271CQty7UhwZgCvA8/XoU1ZVfdsBpZuD+Vk/q0rNBa7unFDJ6xZyoLra4ybIXMGKGIbgY1hFi539HI7loYz3q+GDL5WqSs8kEmrfxeQAWA0xtRXoU8pryqjG4WcFOE1cd0ngWkXQo5m6KrW5xW6+uUboTwduVWpOHS9WwJoe2gEgQQQ9pj+CbnciXnHiBH1N8RbPE3lpTHjxZyc2dbWqdDLlaYxFOcjnYIw8StKGYbF1tqJmXswy2OEhvO/4SCx0TlNACS/RMmmKExuGaWTfr5JEW7hhwHy+NvWAmJ1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(52116014)(7416014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UVwNEQrC4UhM0rAZV5cHgLvJ5YLIkBdFibQbiX2lM/NeUj/tY6Wr8L2WSnwW?=
 =?us-ascii?Q?Et2GSMq1JXVAlr3+oX7zMf25YGNcN0jYkSBhvm0aulKtFAT765GXJwXR/RnF?=
 =?us-ascii?Q?hmA2eEy/fmAQYwoDLZvwILMcyrhx7NxM6Tg8TYgF4rVrjGER5HrnN5gRpTzU?=
 =?us-ascii?Q?MDuwVgE1xAm8BqI9UfJRt8NSZfuhSKQEfdAeIUDOvWpYBueqZ4GXFbs5Hd7F?=
 =?us-ascii?Q?CAdwLLllQVP7Y8I/e1Fer1YAGCga0c6/DnJolB3J7h1qc3wzU7PVTBRYbSS7?=
 =?us-ascii?Q?beE/OgRa8Z2Txb/T8vNAzitKsaOZSdPYNtjrcSGb9I07MOLTwnGaGUxVoIzl?=
 =?us-ascii?Q?gumGwZtTPxvk7z4mpvzqsoRKrVUUGxrx1jLlV9Ez+6YvqV+F3Pkfuv1ZrRWw?=
 =?us-ascii?Q?7otQCquA2Jr73G+Mb0C0Df+h4xOdVPApjekqZ257dKm3q5Ip55aBiLNkaYSb?=
 =?us-ascii?Q?ZPhsdeNfCXnauxVCAv2uNC7/RSdqLZllwYvbJslaxPFcVDqI/JdM4bKa1NUg?=
 =?us-ascii?Q?sGbteQDR6unhASihV5mB0ryjOdVHfXrKOGtmqR+vajqlK4j/WvpI86kR1P0i?=
 =?us-ascii?Q?f8uHnKn0IA+8yYYhqI+Qb0wUwAfe8gO/1PJNVWSbNnLvQ6+zjPUFXtrphZ0P?=
 =?us-ascii?Q?jlfhiH7DRH/iyQt/4Zj6xpJ4XtT8D3IntMNfMdAq5KqStwb5Wf/dekZdArut?=
 =?us-ascii?Q?mbFh2+Xgz8/aXs+J41UDfP3amc1SpbuE3W7zdD4PvsSwjccsCj89RdzhI5fY?=
 =?us-ascii?Q?gGEBJx+HkhQpEFw6FxLDlUlCR93nxff+I7SI0ziNM8VVYtv4vzDIkSkKaOuQ?=
 =?us-ascii?Q?Z52NRQVxkgpp1fwTwfBA5IcQs2EOywgcbk4OVvnGlXdYt/tHjzcNI/7aSCtu?=
 =?us-ascii?Q?xroqLlWFVCC7PzksFJ8/+Jb6+cQ+34cWEi8+cG2w9nq6tTlfobb6QmwgxDlX?=
 =?us-ascii?Q?tD6hzBe/GvkyGZ/PVy6qoFzmg23hWG0PXuaHAMOSZhaDUM3u27SLI0o5tol0?=
 =?us-ascii?Q?qzoGSUWazqYdVpvsJPmTT5DHhXK9jFkyMdMtvZJuNgoT8h8IRZxaQF1GLU5F?=
 =?us-ascii?Q?ofm7ugDsz7o3OmjfvpwwVk+8bTReml0sjcV8o785579tpme2pz13LtBp4Oka?=
 =?us-ascii?Q?x4ZaaS4ldGZtsDsMHWR4kOuzeViDZx/UcH5053/1R2bZRBMbVjulVC1dyEDd?=
 =?us-ascii?Q?saFZo6TwFWgOaCZ/n8ozdHAg7oKYgHNpPR5N7vme4X/jOnuPm7hC+UMens+m?=
 =?us-ascii?Q?8tCKd7k8e0BVunJhD+ZCpBtkN/2jDBvz1AJuTAAC6aUm0aspq2oDiXgbSyVX?=
 =?us-ascii?Q?9w7Ksn/dmjlI8DGsJ73p23c00ZO4kuI+QnnO85ox3BT9dXAn+OjsXeyRs71o?=
 =?us-ascii?Q?5PRLlYjE7Ad18FCKRp5r0vtpZMurBtoHQCvsAE3fhaozd5uaCY9gxAT76s42?=
 =?us-ascii?Q?EYZjfkd5HvGTdWmgb1fJqdKw6kCdxEmwkq+PK1mjZMvVUDcrA+QgKcXK44DD?=
 =?us-ascii?Q?y7CJHK4v1RZxtJKMbVGQv2d0GpbLMLOvB/1vWCxBJBn31+/w5riKBcfpZRuy?=
 =?us-ascii?Q?MKsVvhuG/OFuwFRm/aWDAc/DsVyKVLJOrMKQvyohUfgXOS9spZhqTtWd/63o?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063ea6ac-4dec-4bf0-dc15-08dcc7ca414a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:31:07.3991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUtuqJlrbaevxwydPiTfNhSF5ueSzNO5fo5UoKwkF2p4qLM5Ws8UdrSf/ASfpbIz/7qTKyUt0DlgKoz3T/YnhjbCYGMYwpV3b6mz1ZNvJic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0830
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

- previous version
  v1: https://patchwork.ozlabs.org/project/uboot/cover/20240504150358.19600-1-minda.chen@starfivetech.com/
  v2: https://patchwork.ozlabs.org/project/uboot/cover/20240704055014.55117-1-minda.chen@starfivetech.com/
  v3: https://patchwork.ozlabs.org/project/uboot/cover/20240719013822.101374-1-minda.chen@starfivetech.com/

- patch description.

patch1: Add set phy mode function in cdns3 core driver
        which is used by Starfive JH7110.
patch2-3: USB and PCIe 2.0 (usb 3.0) PHY drivier
patch4: Cadence USB wrapper driver.
patch5: Add JH7110 USB default overcurrent pin.
patch6-7 dts, config update.
patch8: Add star64 spl dts fixup patch
patch9: MAINTAINERS update

- change:
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

Minda Chen (9):
  usb: cdns3: Set USB PHY mode in cdns3_drd_update_mode()
  phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
  phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
  usb: cdns: starfive: Add cdns USB driver
  spl: starfive: visionfive2: Disable USB overcurrent pin by default.
  configs: starfive: Add visionfive2 cadence USB configuration
  dts: starfive: Add JH7110 Cadence USB dts node
  spl: starfive: star64: Setup USB fdt fixup function
  MAINTAINERS: Update Starfive visionfive2 maintain files.

 .../dts/jh7110-starfive-visionfive-2.dtsi     |   5 +
 arch/riscv/dts/jh7110.dtsi                    |  53 ++++
 arch/riscv/include/asm/arch-jh7110/gpio.h     |   5 +
 board/starfive/visionfive2/MAINTAINERS        |   2 +
 board/starfive/visionfive2/spl.c              |  69 +++++
 configs/starfive_visionfive2_defconfig        |   9 +
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/starfive/Kconfig                  |  21 ++
 drivers/phy/starfive/Makefile                 |   7 +
 drivers/phy/starfive/phy-jh7110-pcie.c        | 237 ++++++++++++++++++
 drivers/phy/starfive/phy-jh7110-usb2.c        | 166 ++++++++++++
 drivers/usb/cdns3/Kconfig                     |   7 +
 drivers/usb/cdns3/Makefile                    |   2 +
 drivers/usb/cdns3/cdns3-starfive.c            | 191 ++++++++++++++
 drivers/usb/cdns3/drd.c                       |  14 ++
 16 files changed, 790 insertions(+)
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c


base-commit: ee2af844ba1b27b2e959c4e649e4b769fbeb4074
-- 
2.17.1

