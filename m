Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78BDC4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 15:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE69288586;
	Sat,  4 May 2024 17:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D713B8857D; Sat,  4 May 2024 17:04:14 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 509708857D
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 17:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clVd4wHBR7+M4oNCm/H+suHqo9PDZx7azlc/jez82dV9/krdNnLJp52lEnI4GeNKTRAvayayCo/fIeiOK9HMnyTnu2MIQIQxbePz1LhSKWYy9etl4jQKd2w1RmCSK/POYSsHU9q0fM81Ztan5gD3/nWCp64NKGktd92l9YQdMHXK/K6uaz71usFU3Yx7NGYtoXWTdMgGxa2RWkAZzxj0KTdCJVs8jKZWEnPrNtTd8u8Om9DhHPJ+9nwxQ4+RlprbC+fDFjgdFvCqoxp6n2m5ibib+yvI6o9AO8iTdUJ/sN4bYLIfHFQrA9FgLbrTY/J7P56mQQ44f8fAghNvFbqurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL6JadR89Mf0Fl0Jhf4XY3ZopiZPl2W97gcA4UnpHWU=;
 b=DA7VNa/6eUT75cilmC3ZZSR0FahBp9GW6T5eu8SrF0fhiP13kpFc/+uqfDI4I9mcUuYEob4DC3lF0s3jvoHVHO/nuWeKwuXHC/NU7viUtzkhvgB41vUWbCtc2GLb+KTCNHhuRkOgMWEs3dqdhhHiAUycMqCo1c1+BwHMSW0GvtVFZM1LpBkVda977dTY5403QrcOATBle/Ls2+GGg1DqvRjacBXyTtq+JDDarTdBgMtdCD5zxPKOT4Ye9Wqt2kOWwA5MsuH0T1faspViBcJGJrofIBH5V7k58KfSp5lm2eYU71NVm4h4FaE/wAXdqx8NHNW0oK1Nc6IKnQyesjwrRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0839.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sat, 4 May
 2024 15:04:07 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::3e54:57b5:e3e3:7f09]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::3e54:57b5:e3e3:7f09%6])
 with mapi id 15.20.7472.044; Sat, 4 May 2024 15:04:07 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v1 0/7] Add Starfive JH7110 Cadence USB driver
Date: Sat,  4 May 2024 23:03:51 +0800
Message-Id: <20240504150358.19600-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0005.CHNPR01.prod.partner.outlook.cn (10.2.0.75)
 To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn (10.43.36.12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0839:EE_
X-MS-Office365-Filtering-Correlation-Id: 8afd4c98-4450-4f89-2c78-08dc6c4b71ea
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7EGVqCVOTq8wYk6k07q7d6HRJqpSE6oFF6foH67wVykIszC5GsHyjsCsrkZtX5XTSobgf8UJrt+YP0c5aDJKRvUPJk80lEVfKmCj76e9k/3eRja68hoPAw0zvQUdwApW9CWUo+VZEcVGDbOHQyTpz0jiR1l4NYO9FJM5shqB3nBh0dpMgmMpxAAlarm06DRvLcHA3NKvlINcESZZ84XMSOCJiZlGsGah1++u2/7i+jdiTp065ABDO3/gS4e0LUZJrQwPF72WxyrLP3jBzu4SThx+ArkAN5G4n1/lYLpyOikuWo0gEqCZfxE+SJ8W0GHGgEYDdZCa9KQ/zR6Bir+br3BzDLnEQ3AOAN0QbYB4ebdLvfbY0oQ0PG6K2W/VoRYoMvC/RBFzXAQj7C1YSaomsz9Nmi8OiWt70f9vHbrp531c+LW9cRxZfXur435j8ci+acWqaL1TAXeg6UTuqbB0llc2E1WM/N+dCyvXwZg5r9oDI3dSm49rmM5fzJUpGkYtWrA6zlj259pciuLfn6b/FQc2oLwz160DEFfK7vW7aOwPcy6EaMuvHh8MtlFaJ4qfirdFqx+XlBgtfQKAPf1i5PtuQBusvvKH6GoxfbZYVX7MmJJuX5J26ZUj3QUDzK0tJvrBi/j6/ye3Y+lZYTqlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(41320700004)(7416005)(38350700005)(921011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Y6egohllEVkabRujQfJscrqDmt7nWhuQCkdy3mZiqdtTqn/XbVp17Rkhe5G?=
 =?us-ascii?Q?z0gt2NjqAImK0IuMe4c/w9ZKgiZNr1gKsqrmZxqRIkfEiYZXnB7fgL236SKP?=
 =?us-ascii?Q?u84rVkfjUreQkz82LjyA5oST5U5wunfOC3TquL5/5dFa9pmiZRd1iETraIaE?=
 =?us-ascii?Q?PoCcp2XT37A9MQHuTkRBmv7gx9QRWOIVODh0RGqy6wAPNZT3327t5lbpEiKJ?=
 =?us-ascii?Q?KDDfk+aKKfLR+H4tYl5FL83UuJlqdi82ke8spG4xPNfCLM2yoWLY/v8Boh6A?=
 =?us-ascii?Q?ndkbdLZ+p9HPdSHrHh5fT7vYLEwBD7VCT6N1bl+xGHdyKhOzjTwV0fjkpKDt?=
 =?us-ascii?Q?3RVe3oepLOGHJmfRhe02iLpltTdT03nf08IddwQg6qrRFYeu9Bac7EtPO6YD?=
 =?us-ascii?Q?9vJdatKQ8Kg433lOBoDEdSS1K67MtJvn4vKuc9GMyKWTGpoJywRl7bQMuYmy?=
 =?us-ascii?Q?JEc6mQxQ9YF5JV4WeuDvprFWumWSsQsHphN0Rf9sAC03q4EVUWZ5VogXnqrW?=
 =?us-ascii?Q?wZvQYnfXN9btFaGvTlKvQkJzPRPjv3Awzrl3gKaUFZyU4pMGJdJaskMf/g1E?=
 =?us-ascii?Q?DiegGvFo4hPyXRI3JAAulhlZKG8pOqEHWiFRtyWQfIDh6aSjQSdsEM3ZerTq?=
 =?us-ascii?Q?AFKbXKwI5FDmNKmMaeACBWs6oSZh/PFPPRHtReVyI+jbxp+tVr6gNEZlntUT?=
 =?us-ascii?Q?g07sfex/+3tx5uAYFovJgcAfKaTwWyu1pklVHskzArQelOUc/waV/YbvO1+C?=
 =?us-ascii?Q?qHgyJciisefjR115skOTi615FNmAZt41VHrirDzJX4x31WCJDtkaz7ikyYmu?=
 =?us-ascii?Q?cAvdds8Vmg7VoLeD7qHtRanE4bg972XKPAtWlT7FbbLqqdqqIkQa44vHnCna?=
 =?us-ascii?Q?yXXpEQJ/SYr+KoT6UeVQ5eKUfWspDVSTgtMPypHsJExKspEsc8efNUEUfGGI?=
 =?us-ascii?Q?jNLKgcDu096LxNfBN2LwgCUY5RQbEQdTLghGjZXOFW1ZTJcKbyPsYHjNPLqI?=
 =?us-ascii?Q?6DgbltWWzlN4zBguBHUuAXorcgp6Aq2Y70YXbEBDv4ElPFDgPy2ugeGC/z6N?=
 =?us-ascii?Q?4b/tP8aVp+flLaw7J8nhrDF6UuKy2sRQBOuKYXJE4WisFmb6SnShC90cx7uF?=
 =?us-ascii?Q?ldVGz39NHuYwHx0bhBnx6cHXUVQXRoANeqK9YEXtyDh7PvkGZ0XfNdYt+gQu?=
 =?us-ascii?Q?SuLa7UX2Tir6OvS9jm3VcQ84yLHNBKZcdsOFgy0383k17R5Xuj0OeltENfhG?=
 =?us-ascii?Q?B2swH3KGGXYoBLXuVG4IYuRuVyNNZJH1UL8xP1XEiZKBTg5aHwaV7Lc6+rSC?=
 =?us-ascii?Q?Dmiy3z+zYMIdsHfyW4/qOOtGxSqlyQZNsk5w+B6wQhyYTE5nVQ7NmLEubl4V?=
 =?us-ascii?Q?fsKfYqnT3c/kSm8P4AfgtxZ8n099FdptTaTurzY9w7YhK4vwf5VNo5nsDLqH?=
 =?us-ascii?Q?J1usxwl9q3tljOz//xVDjuiVk8sm9xYhD3cTpzvYJ8ru85UedYaRMvolzcxr?=
 =?us-ascii?Q?VrvulnhQ7/s0i+NLIuFiwEEESm0iUHq9EM7b9bDi3iyPIEoorPF6kV7Vhov0?=
 =?us-ascii?Q?l8xKupwfN61BJKC9Dic8RrBpUdX0FGbRw+JEi9EICQMoo99FEqyoWvGRfEee?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afd4c98-4450-4f89-2c78-08dc6c4b71ea
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 15:04:07.0739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +usgqD9uzK4Sg2p54B6KvLUIl9oid/yVIFLz8VIPPt/EED4LRxbZUZAIkDvX+TO4bIn+GA/Rtojz+RTZtxDU2G8dOdfAGgFp2OlER+Unyu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0839
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
So the codes can be used in visionfive2 and milkv 7110 board.

The driver is almost the same with kernel driver.

patch1: Add set phy mode function in cdns3 core driver
        which is used by Starfive.

patch2-3: USB and PCIe 2.0 (usb 3.0) PHY drivier
patch4: Cadence USB wrapper driver.
patch5-7 dts, config and maintainers update.

Minda Chen (7):
  usb: cdns3: Set USB PHY mode in cdns3_probe()
  phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
  phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
  usb: cdns: starfive: Add cdns USB driver
  configs: starfive: Add visionfive2 cadence USB configuration
  dts: starfive: Add JH7110 Cadence USB dts node
  MAINTAINERS: Update Starfive visionfive2 maintain files.

 .../dts/jh7110-starfive-visionfive-2.dtsi     |   5 +
 arch/riscv/dts/jh7110.dtsi                    |  52 +++++
 board/starfive/visionfive2/MAINTAINERS        |   2 +
 configs/starfive_visionfive2_defconfig        |   9 +
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/starfive/Kconfig                  |  19 ++
 drivers/phy/starfive/Makefile                 |   7 +
 drivers/phy/starfive/phy-jh7110-pcie.c        | 211 ++++++++++++++++++
 drivers/phy/starfive/phy-jh7110-usb2.c        | 135 +++++++++++
 drivers/usb/cdns3/Kconfig                     |   7 +
 drivers/usb/cdns3/Makefile                    |   2 +
 drivers/usb/cdns3/cdns3-starfive.c            | 184 +++++++++++++++
 drivers/usb/cdns3/core.c                      |  17 ++
 14 files changed, 652 insertions(+)
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c


base-commit: 174ac987655c888017c82df1883c0c2ea0dc2495
-- 
2.17.1

