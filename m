Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E89C4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 15:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54F9A885D8;
	Sat,  4 May 2024 17:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A9C6885B8; Sat,  4 May 2024 17:04:21 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61766885C4
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 17:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kW7P53DDMRc5N6yLLstaqtM6TQlKRXzMAs4zcONUSMExKMuUjQWWYcrTh2TVmVAHLXrSPAboHeLbH+Yl5AVeVyn2Ovkk5DJ9W47CCJ+t5dhUDQhcR4J3D8ryE3dHLkaycfdOE+jx3odRBv9las6kunw4ATLflTFjPca5ozW5dFbWeGxWRsc6NvPC1/yE9XqpY/F3IxDSGKSHZhzSqt73wsptMNWmUmaThg5lP/mPgtRfW5fz48mjdNP7OR/T4Ug0IJPmYao6evUiO6qLt2VbK5yBcdss5/s0IPxV+T2D1SDAgwE84Q6hzqvzPLMxh68/6ML3jUVVHJYaH+f2EAVjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUB6u4H8sS65hR5rtTeD/CYxFcbs7XwaNrPbhpQkcac=;
 b=bhEZtO7M08/V0wGFXtR039KLuVpmZsgA4Yt2UEWPJh43Jw2diSvWvWlEWpRboA0LUqIHyu+k+Pvn3z4SPjmNs4fKx2a3t6k/IK+vTGtMN4De78O4LR4VOqc6IfACGAZz5lAde7WOsfekj5UToBt6dzR8Xar9UMR32xu1s/S+pB+COVeIdQau+ZB/Pfaqx+zu6hipRW1sXGx2n+kgYjS7Wkw9FcYhhMmsTZ1lB8beNXXOeWVx/e86FjkI+NVgkDxhSyGvwHeRYecQA/Sc1fFxoSxdt2j5Tpe39M4hKzoxj5KDVDH22KvwA01fg7k5yFAwhK5q8+MVD04HCbcgjN5Lzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0839.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sat, 4 May
 2024 15:04:14 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::3e54:57b5:e3e3:7f09]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::3e54:57b5:e3e3:7f09%6])
 with mapi id 15.20.7472.044; Sat, 4 May 2024 15:04:14 +0000
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
Subject: [PATCH v1 7/7] MAINTAINERS: Update Starfive visionfive2 maintain
 files.
Date: Sat,  4 May 2024 23:03:58 +0800
Message-Id: <20240504150358.19600-8-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240504150358.19600-1-minda.chen@starfivetech.com>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0005.CHNPR01.prod.partner.outlook.cn (10.2.0.75)
 To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn (10.43.36.12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0839:EE_
X-MS-Office365-Filtering-Correlation-Id: b57b491b-130f-4f00-20d4-08dc6c4b7681
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pckXuLxf9toLIysRHxkbx/HoMjqfK20ab0s1svVnb5s76x86f4JRjYfldm+e6631C0mLWCOgEgLx9+PePYAUhqXthAdXPTUloIs+ErwH16bnQCDY8XUs2wFoaZwDJc1507+Q2yhctJwDEZf2uPQJn+INKSKeAD/B/AfHKxLZVx47SDOlJX8FDPBM2Ug/BNGuRqJbaECnhDdyrR3iNGEHMNHe+PF5X50unhAtcmvpvugEHWwgbP4P1uZuEHNNxVgQmZEVR321EgS+BoKkPDnzFs1qs0/SPN9y0nPNWb5zS5wJwoLU9Qtmww0Cl5ufEBTM28cnMJ9HOKR4PRF5BJY1bzrgquvbws/YCH23SZ77YOPY5iqDEBnVFRLsU2BLfkPXtuxaKR6sQFxrzoTitUYD7M9/URfg/2c1Adu/2SWqbuVbX3Wo99bncE6Xr50/vRJ1NYfkC9Lcgt6TQPZOdstTUq6sRaoi8x3fzihFkQU1grrIyEhN4U7fciYS9XxmJTR2t1ezujneys3C1A1ToSXplKiwlLpv0hgec9xNoLQPtPnX00beLhdvuq/Ce88ztaGbhWel+pnygwaFI0dLUGMtfh/zOjAkywCX2gbFaYsRhg3vg64zgY3weVfAS7409qMaN5cSMYmTv/OwFVxgFCr/Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(41320700004)(7416005)(38350700005)(921011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uXpC9XGecSAQEA4i9HaWJvWsdgjkN929a+YEVxy+V7koknNoPjvAztZ8XyF8?=
 =?us-ascii?Q?3N7D6TDV/z6GuLrXmkYkkwqIAT9c+b3BW/t8qDndGDUG670n/F30oIeuvgYf?=
 =?us-ascii?Q?LD4BxjOa/rQxtbihiJJlU7TfbADhpWHxo/zoOFBK2PhqdgoJ2EEMvcf9FXwM?=
 =?us-ascii?Q?7CIAfO8JvGd6D8zrXNROWMwXenfftKKAGTlmy6L7UXhVMPm1xzCM2qqcWIkZ?=
 =?us-ascii?Q?/RmXkEna6emYCASngxnevzfaTqfi+2bIaOD8t4yAK2oUm28LfabRinLH9z31?=
 =?us-ascii?Q?l7S6C6soKdUbLTjMgWhaVN2xjGBpoqXWsUvsJkiBmQ7etAyR5sgsIZbazzv5?=
 =?us-ascii?Q?0JuUaG84L3l9XJ+zM1yx8eK7awTOP/ErvMASJrsRUJDUAY0vfDcQYirKaZPl?=
 =?us-ascii?Q?HOn1GZNaoC7J0qbsP65myDXvmkKk+l9vaoYAATxOa5KkxIgauh9RbTq6z3/S?=
 =?us-ascii?Q?KaJlj7K3V2wkqC/ED3izFXF4M/UWUNB1PexdL3CxLHneyvCTBQ5Ri72mJVXJ?=
 =?us-ascii?Q?97W/rRTOMwgbDZcVWyzg3tE1dOeJQLQQsbqxerDIbP/sMxpM5lH0wCRpCwzO?=
 =?us-ascii?Q?dEgUt5c1GNqN/JtPL4VOS3/WuVeIkTIVvZ7b3A1aYf83QOqU4z8BtxswdgPk?=
 =?us-ascii?Q?BVhzxjVCOVI6BPvbsAuoxtbB6FUoGmNKOjkTz7HbVcLv19locRW/Unjv4Thg?=
 =?us-ascii?Q?8D/K443YzlCRYKWWRSKuI33FIhyOhWmD+y6fRmnxRXjEFsU9WAjUUECOu1AC?=
 =?us-ascii?Q?wJ78dkPZs1k7XgfxOFvtNV+9oXznM3ZTHobAA2mU3LMFUhvi5/H5dfWQJZty?=
 =?us-ascii?Q?NmJtNpgPi+982UdMT124AoW+e46R4lhbsNdDvTQOtMexlAZovVdthSkB/NZc?=
 =?us-ascii?Q?RMev8U3IUa5AUsHD4o+UkqVmJTaILtb9XT7F68hLPiU88lTuaEh7/jSN1VJV?=
 =?us-ascii?Q?dMvZj7adCdTfI5KHrRccbemLU3HPl5b47PXGZOHoHoThI54ag3YNZpUIBjTz?=
 =?us-ascii?Q?UxMFFF1GqxNOjYgvtfWYNq6Z9l57lBIw9O+lk/hmrfqFgL0NxnGuUtTLdU3e?=
 =?us-ascii?Q?ca0VOyPyorBSnYGv2I9khep47ZPmjO4HF4gyD3Qnl+BQWF0C698dsI3dZMRS?=
 =?us-ascii?Q?iZXrbDnGIPGfBgAtU65fNJanBBINMjuWLWejI7IggeLbIdEISl2kkZ/KaOO3?=
 =?us-ascii?Q?7msFVssTcukrqzFMPYuo5yO0ijsV3gvm0eurDRhJj4j4g4QwEplcEPWfCECq?=
 =?us-ascii?Q?BpORBBvJ0/rP+Y7U8BdIeCkneNjQJhpGR+m/e+VumUI5BIlHW1OV349s3PXw?=
 =?us-ascii?Q?RahgaLI3hODcJN/eSJf/j26e/5EzqtW5Mlw60DOy1McFlf30VJ1ATqzP2btH?=
 =?us-ascii?Q?aTNNRkXatdTknB0fZW4W50ZRyXxstgPA/xArTCpSZcbd7ygZ+LOnRv46LWDr?=
 =?us-ascii?Q?OOGP1TJzSZiVcp9h5Ot1JpL002B8l23pinaA0CEl6tqzs11KX4iHPVQlfl5B?=
 =?us-ascii?Q?kvJ2zahZRKysTqGG1hzfVGxNZ1QrgdyyFpD/4QPTM1uQUKQP3Rk2iQm/sPYh?=
 =?us-ascii?Q?Q8BWgkILeNxdpwXEsw1fkMpjgN9Bd1ZytvXmqJJB6SF8YYf6wuA1PC7mAVsi?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57b491b-130f-4f00-20d4-08dc6c4b7681
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 15:04:14.7696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH34ocYVJ3a7CKUcD/51ogVkmHdNZr1z1gIOzn6ZwaU5ZmG8636xsbB9KgELc276YpO79gN1ktWex9iB+vj/nwP6aydA8SXm8CTd8tbmvKM=
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

Add USB related files to Starfive visionfive2 MAINTAINERS.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 board/starfive/visionfive2/MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
index d7f638f9b4..1faf83f581 100644
--- a/board/starfive/visionfive2/MAINTAINERS
+++ b/board/starfive/visionfive2/MAINTAINERS
@@ -6,3 +6,5 @@ F:	board/starfive/visionfive2/
 F:	include/configs/starfive-visionfive2.h
 F:	configs/starfive_visionfive2_defconfig
 F:	drivers/pci/pcie_starfive_jh7110.c
+F:	drivers/phy/starfive/
+F:	drivers/usb/cdns3/cdns3-starfive.c
-- 
2.17.1

