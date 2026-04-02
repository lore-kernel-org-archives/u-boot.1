Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B3CCC6B03
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 07:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C54839DF;
	Thu,  2 Apr 2026 09:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB9084056; Thu,  2 Apr 2026 09:00:56 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F78480212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 09:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRIPxcILqxiReS33pFZPoe2IDrA3Nk9EoQ34EUIFgm94MNrbd/fmPaWvLOWZq+WCKjU95Hcy5ipZGNzZEtmITXO3Bxt+Hz6hOPQHh5YnkPKqDfMK37NqdX/RLhi/o6Vsq0WASzYVLuh+Mnk9tiYOWvi0CMv5iim9M/64H7NVCnDeQAY8X81xXlV29Ys2vyGWx1W5upDWXi+YK4k9oCnlNGtBPcoPw7o+a8gIf4ngZXf+AvC9pdgU8x93bgX6gQ8t7j2Fjw5W5zlfBZKTdt9dB4zIzMkM8dyg9kk/xgIPC2D3nM6cQBh6dDqLxnJlESkQKV9ANEpRdsmfuC2xzG45ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjVmH5LJyKM8pDj0N9CyA938JLE2e7bfTCgZd9CbYKw=;
 b=FvKaqGmsrOoGPbIKTZJfQ3S1FVMb7U0K1VrRvlZl0gLDcue1yIYLostIz2muZFR0oMPkD/HJMsqlbMieL/RDkoysM32uMOg6VJjbqLTAb/CFmJ4iUh5XBlX9/oeF5bqRWpsJ4LEF9vuk+PP/55N9ttWi2+WZe4/kLi7K4WMX4X/L/VrCvJnxeYaIWTmZjuIEOXuJ5nhiOL9r2/oU2Be33ql4QtfsPJbNWCtBYn6rBN9PYhzf1+/JxjZch/ma8XGIhYqUrHb9DqUqF2jotBlwN+kWv+rHcYJmr+QYl1dWEq97xiMO/nACu54qL3EggLzSaVCbx07Ha5I/RfIrkfGZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1276.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 07:00:49 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%4])
 with mapi id 15.20.9769.018; Thu, 2 Apr 2026 07:00:49 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/2] configs: visionfive2: Add VisionFive 2 Lite eMMC DT to
 OF_LIST
Date: Thu,  2 Apr 2026 15:00:40 +0800
Message-ID: <20260402070041.2418-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260402070041.2418-1-hal.feng@starfivetech.com>
References: <20260402070041.2418-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0055.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::22) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1276:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8853bb-12c2-4463-1942-08de90859207
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dC4be7+vIAtEAmwcn6QUK6/sCNcwbmYUMY85PyIYcThvkt0kc1ewbICmP1LzhZskpgWocP4IwFp7v2h/hGKMzyHap2Rr3JqEOAvYJ5DeHnkmWqetqTwfmjw48xFf0pqZQKGnH/CANdRRDwd7m8Xx7aca1Y9VWAkd5ZrPFEH6/Lx59hBiismNcGmGTibi8BEZOZMOTvCB/9ol/DSybe0uJJswZtj9ViEslklegjlLc34ZlatrOnjZ3apLb/cmU83926jIPfJtjPetWqVJ1wIB264mZ+WnRVlOhZ/RAPRj8IEQ2bgqGqB1EXgSlbGVQ/q/XO9CrqpKnaziDfWgfLCs713Ak+jrufmd5V7aJViqHd3oxAE+KchIP370of85FgOBFuaTBvhEeu3zmWkAxOutxlGgW6rIAuGZvBXoy+i4nyECWMdO2J/ZMZjyvkgMqSJadekJM26M5AWrdtZ4Y+z892kr6F8uz29W2feBhWR/69cJv+ElgYpIGh6BbokYE6kzfuI17ZohdtyDNmTSBFROnbqYLOaI1UhOmVGB52SIcITRe+KfBLkmLAHxC9hgubhwIdHzRCyuVC+w6VNzNjaL6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pQjUALzpGvzw6OB1iPJg5wgryhv5tptaNvv24xNKPgpVSl/X/rDPzfvDc8M/?=
 =?us-ascii?Q?5/yW7FUHAMgeAkUuB/Z8oMHqm2K7J/IEuVb9h+C+TR352MIj1bV4TmQf504b?=
 =?us-ascii?Q?KvFUtk2SILyjU1TDHTkrac4b/vAocNqJ8dUgwz5FaZxp3qN1JpTfzSZ+JN3K?=
 =?us-ascii?Q?TmEC1XWmUl+exuXjxAnG25Nfc8VHAAfQexBbpaqf/8KbHVXKpQaQTYyqYDih?=
 =?us-ascii?Q?B0CtXfpIRl2HaACuAr1E/3L7nibB4N0xm6SAynUKuxP/gCBK1RFxOlyJu01m?=
 =?us-ascii?Q?0y6LFxiRzuU+PI7dqO1bX1bUjQdXtcCldEcQu2dKx/5A7ZNR0IyriVbqUB/7?=
 =?us-ascii?Q?vDOyQr4tVbzbuh1nyPYviYmBhCBZAFUFpn4JweKv4D9/YyA9jwmo7epeuNMi?=
 =?us-ascii?Q?nP9JkosTBfH3zU/xPVgpf5aNoWnyMQVHtmpuKakFwyo78NQjgbGQzlonBk6c?=
 =?us-ascii?Q?bJTAPUXswDqEKSKUMjcR7mQSkQ3+WdEm04pOAZZbbWKd4xkHq62F2Lsp1lQt?=
 =?us-ascii?Q?GQcdhb9gNyhfy6jhGTfI0dVfOKgWQM4g7nccB7GXyZZg/6fGX+Ky4iRwf90K?=
 =?us-ascii?Q?Gu/gD4YXIMcW5vcv/faM8emTu83XfoOxsoUyc3FhHjcJN4pHxD6uL/qFooPN?=
 =?us-ascii?Q?AlSJFJWxsvcyiToEI4VVOLDKODA16f9u7JVJ/+7JzQXcrFEEc5zBJsyLH36y?=
 =?us-ascii?Q?TW/lZcpNG8XhSJ95d62DijlhwONy2l6rKPZNBvtGX2KI1DiKMj+0DCsEJxVP?=
 =?us-ascii?Q?WCKIJ7aQmhC7JvSlDIiPHUbftPRCCLtNq2CsXcgGPC5/odGZ/dDUh/22leOI?=
 =?us-ascii?Q?cpfS8iJwd8iS8N8IrzowY/xZ2LHH3O2i72Fm0foW4HhHH/Y06xOl/ab+XEnm?=
 =?us-ascii?Q?UTAGHVKv2a5qGTmrSFFGfSN0yp1ZtT2Gl0qBuR6VOxxEbsc560//Az+7ipo4?=
 =?us-ascii?Q?iIIqrG25Ao15fcA/OQPZ0tYffdJG95fqFg8fxlSPq+M4OyMikBr84NEUDUPQ?=
 =?us-ascii?Q?wPX4URNQIWHzd8E+BwKt0P9QHFtP+VDXkTcJqaA6Pzq991b6+k83gK7kq9S4?=
 =?us-ascii?Q?kQngc2gz2xJVGB6e2nSl/eTbTfWNS3aBT8e662LNgllawee/6wUhDqYX+TtK?=
 =?us-ascii?Q?Z7kyeQe+QmWs2bOkSxtZ3vapEEwnVfluhpOuMvH3WlGkGUP3cxQv07BsnKtB?=
 =?us-ascii?Q?fAnPDv1PxpAQ16p/qao3wXW3AR5pS48ZwjbgcE0dW5AbfE2XE0QlHshbs4Zz?=
 =?us-ascii?Q?hM9KPx2kOviHqD9DeFRWf8pyfHacDo/5xInOiv/kA8nSCApEOKiWANBFPK21?=
 =?us-ascii?Q?LT8PpmrSM5m8rRq9eSnVnMzFDrwGWLZVejftDeJJc1HzbZ7Rma/nNvwOp6mU?=
 =?us-ascii?Q?0eprYKoBuCm9KB+POu0D9hyNVHZwRAeY207WvXpRSdtRxMSH2BzaDAXKjn9i?=
 =?us-ascii?Q?u5kR6BpPuQhUt5gUhrxKBYfagYSDXE1xB70/iQBXVAouPIJKm3Jy9kGMDTDL?=
 =?us-ascii?Q?ZDw8U5saW40DASVu0Ix88B7SR5Fu4s4+mnD78Fajbq+kjQlK7yoFTjgvHyir?=
 =?us-ascii?Q?l3Ki/eW5Z1VGi35qawDT7HLxV3+YA8Ljgb4x6DGkLQjjqE4igwYU7inLwKGg?=
 =?us-ascii?Q?5nMwM8ZYPqzvlGkKuEe/mYh7XFKOrqrkCOaUMF2mqv45VT4+G4afT4UB/yEo?=
 =?us-ascii?Q?biijXnIs7sAGY17xw4R07nFKVeYxUVR+Y1Q3RD7q3POVLH4mQZutUqQVCmSQ?=
 =?us-ascii?Q?J+oNP8ngaroF9zzhKgqFVrPr+gGSBbw=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8853bb-12c2-4463-1942-08de90859207
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 07:00:48.9307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tk40EDvOCyssEyBdLOB11hTdbZNMuQ2lSFbbRg7LYjByGWQC4/v3P0g6Y/22PkM/LRP+FNq30z+5+4SyFCmTGbmS1P/ukYgMjnqB+DtsSUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1276
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

So the VisionFive 2 Lite eMMC DT will be built and merged into FIT.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 74a24dfd074..b6b3108ac5c 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -80,7 +80,7 @@ CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
 CONFIG_DEVICE_TREE_INCLUDES="starfive-visionfive2-u-boot.dtsi"
-CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm-lite starfive/jh7110-orangepi-rv starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-starfive-visionfive-2-lite"
+CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm-lite starfive/jh7110-orangepi-rv starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-starfive-visionfive-2-lite starfive/jh7110-starfive-visionfive-2-lite-emmc"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-- 
2.43.2

