Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD41C4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 15:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D88885B3;
	Sat,  4 May 2024 17:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E4A7885A3; Sat,  4 May 2024 17:04:20 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AFAB8859B
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 17:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtUWham6MUGx1v4MJ+z830FFKhQEeWUgNvuLmFZpC+koljBaB1xnUQTYbxPaunAizGOm1bSZK3k2ZqQGXBQVScjwzu7fZSxdZ1nUPjPdpiyaWS/p82T2D2Vt2lFMwWXfgLTGCYYmzI+IrfCAS/twtDjTIvSnX1d0cFX4dJpHp81HKmQg5nUjiNPqFEIc0Qz52iZKN5VZjDJGQGvppDMupQ2CSQ8ugCmhfIBzSrVGmnQ29mJ2kNPLx08Vbbwnl7K+lOoWNuKBXNaCCtl4Khjrsjzx5ad5Nbt/TylZ79rb6C5Fqc/uiBSUsvTlgB9hCXOE190kttCL64Vtl1WDu6GDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5Q94kZzlpy+3WUz2QQdVIrVvurh8YgX/5yxWt0/XCY=;
 b=VJ58uRjYh11qp8907F6+Z/DB14k8Z7nhOlMatrKXenqk52oMZFFVANnb2ToJucYmQDFz/9bB4aLctJls90wzLs1f7hpN3RrZi0ZpWW/4bwBCsFb+6VBj8X3yjhw/b3DPfTT7FHAcbZp0SozvYqihDaPXbYABPhhpBYkk1AlZWYRa9ky3FKqpAXDrFHP0d3bZMUsUdiMi9OjbUHHiY4d2mCIjSQaNmRceT0Twsga1S8bCv/gA0BAQV2Knp8EJr+q7LHCla5UgVC5OLeOfNBRbVRqp+cgzsCa/aI7ywHUBsoUrtfffK3Q9pU/EzICS9s2b1L60eaCszn+LMNp16RLMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0839.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sat, 4 May
 2024 15:04:12 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::3e54:57b5:e3e3:7f09]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::3e54:57b5:e3e3:7f09%6])
 with mapi id 15.20.7472.044; Sat, 4 May 2024 15:04:12 +0000
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
Subject: [PATCH v1 5/7] configs: starfive: Add visionfive2 cadence USB
 configuration
Date: Sat,  4 May 2024 23:03:56 +0800
Message-Id: <20240504150358.19600-6-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240504150358.19600-1-minda.chen@starfivetech.com>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0005.CHNPR01.prod.partner.outlook.cn (10.2.0.75)
 To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn (10.43.36.12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0839:EE_
X-MS-Office365-Filtering-Correlation-Id: ab58f9c6-11c1-4688-e16c-08dc6c4b7535
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ixgh0pAPpWyDkNK+FkXPODrPiO8EHUKe6zmhmEJjCmMw9BOtf+sgTSlbt3HLkBNi9sMv/o7gKbkQsdPJXuruuIYy9it37NF6uXzMo1wKZ3qbXLRj4/+o90BfhVV/xQHJcVmMhmbtlAbnYyv6ok4k0c6O3R3v2csnHrk+H1kVBQrXylRxaJfy6WZIRy5a64rEJgRZ94VtOCvP9dGq4TuWXYFdqOVpWHvSNB8LOXUU4qnoGJpchZWS2D6PlVNJlkXxuAqkbNhrpWy7msmEP7zN9LC5rvuTDchV0k6pfnaf1Rheh9oDPy39pgCktMGYXlfODJjnyxvgy2N35eMbxz/iV02okQD3CJmfOwehtE9LyHn3ymKDcV1FxhxTujmPtjnTU4BIwxtKFrXmHOPf3NcHu2Zs22aVUrTIlbDkuyAHk3Gw0VO4oAigfZTdwtE+WXYJ2VurUHc8iT26/JmVqjP2Iq2Wc5kDssLRts4LkABgvoo74RKTnAJcw7wZCl8i2HK+3tlgHm+tPAe359Do9+Bw5hQSzx2eETinSdiWO4sc11qcVxqToYunnUdG3S2DP28YbJ2RKoMXtAM/8ThSvjaETqYuFej5dTMo1FJJPga13VA6y18bUTCw8P2RczidopgwPwOdoN9jIDOcEwVi1SQ8/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(41320700004)(7416005)(38350700005)(921011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V8mxZc6CuM6uLTeNrrhtvbLyarSrj8W8YXKDHsJFCx1DtXnu/UkrOLe0r4k+?=
 =?us-ascii?Q?/Gqw1IK6iuOIHR8B+eu2c6gIam6tU9OZJM/ffSRTbC2q/lUqwch4Ib+iejC5?=
 =?us-ascii?Q?/mgjhmqWqTkFZMqT9XStkXJc7PTDL7eWYXr87GF9HDD4SWZRDpnbX/UkNzTU?=
 =?us-ascii?Q?SWWhmnu5C+MVDWKRerWrhupGL2VVJvkE5EtAVnfNz9tVo6t6XCm5eXKHQQPA?=
 =?us-ascii?Q?gEYNyVIVZzwttnnyKCLUEsZlENlBPsTSsCJYdJunzEfB4z2NVNUt1mZxXczQ?=
 =?us-ascii?Q?2omUbjNALvy3KyPCmVCk3RY25qzmDOg8HWmL0FDlYreKhqcvVWAylur8r5T8?=
 =?us-ascii?Q?Xwa8534HuGOtLYVo2CVMVkpQ6H00BLKJpPzy3KNQzKnxnIwbnsyMs0wBq+CE?=
 =?us-ascii?Q?Nuss7APWNX+8LzXqdNqI0jxuMfOUNlPGx0ie6Sk8HU/4IiiedAPHDVQQqhKt?=
 =?us-ascii?Q?r/ywFgrJUT/txxDSrXXMguL8bEJw+kdYbPlsi7BVZw8UknvA0YrT/PCCpOey?=
 =?us-ascii?Q?F9Tq28zpDzDDNK8vmslk1l2mAC2feCHPKiH+S4pGaGRp4iozqgGWkkkrtxPn?=
 =?us-ascii?Q?Lygl0a5CMgzc6igdo0ihzSz6ZpW8+I0ma5eNMoDpaS09r2yjkZwxDD3EE3ck?=
 =?us-ascii?Q?JKTZiwjcyEd2wMOjZIo3Macx3T6L8ZZ7HaCs5VxqRHTf47Nd8JANgZRUCjo8?=
 =?us-ascii?Q?JR85nJoqZOFaeE5FS1RKqygqpDpq0uclH/erebCc+KDEPtJ40Kb9EIto8Ayg?=
 =?us-ascii?Q?Er2eJPPr0O/Nw+szBTywMpLb3jc31qfwtzyZBP2dgtNPSLX1NVPJFVcW3tZI?=
 =?us-ascii?Q?HYNK/FyKYWXfY0c0eMrjz9c0kwHJTXAMY3GpX3AaFe6eQ7VtSxmd7HW9H5OS?=
 =?us-ascii?Q?8vvAUgg/kcRlj9B2Xhx1WL2vdK3SfJJazjk32m1D95u/3J773HiHIsUnCa5X?=
 =?us-ascii?Q?eHf2vVV+LZ07gDEzcK9UjCb0quu4YPAWwFjfULlio/g2o9LlWczKAbTPHTCh?=
 =?us-ascii?Q?A8c/Ov+274SxtGDFgIA2Q96vH3xSUA2ruCQN6BCKnLC01Fc6ko/6Y8V2rNzL?=
 =?us-ascii?Q?72F31ERzFQMpJzr8yR4VPRxfl85HEb55J7cXwhp9ot91shGzBDAkgVYtMhxT?=
 =?us-ascii?Q?nEpqUSZfvFLNPQbYFIvMSudLC76o+Zx7U2WSG0FgUriwA9ni9VHH+NkEar+s?=
 =?us-ascii?Q?6zqT2KwXW04pqwHde/PaoiS37EymfjCenOEK9lMPz2ZNQj50iOr1Gxd/bFXn?=
 =?us-ascii?Q?SM9LCPKkK7E706SDJqgQxmn4GiN46cRQUaPkaG3uZe3d6kfjvQOpHkmwUkDO?=
 =?us-ascii?Q?UysTSQiBxEl6uKYYJu+Tf0bz+fWZh8bLJqcWJgFu1Eacc4Y4trq8xej4dk56?=
 =?us-ascii?Q?kW3U8ahfell7jH3LfantfDm1YJFlxC8lKvYAbpLML52XGgmvIyQAC5P6cROV?=
 =?us-ascii?Q?FpGQSADJYFdO4zHg1RGAHtdMqsvfDlpgkndnBci0YQ+MQYkoYgzw4oKADAY+?=
 =?us-ascii?Q?DtrlBY/tZ6J7EYqx9TUwdQrrft7Q8jt7WLpsIivIp/J2sRgb40RWvgw8CU3a?=
 =?us-ascii?Q?bTYL+jjb1sv61tO4hA1v30AV0W4E3rysI/sqd/shGilKJp3tJNc8DmJz+2eY?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab58f9c6-11c1-4688-e16c-08dc6c4b7535
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 15:04:12.5571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XX9+Ve767/qS4nufqV+QSV79vnM86VtxKjfKAvi1nr1S2PXrUHRSTppOo4FyEIH6Xp+jP6+sdjUehDr25DqAZERycP4Pctjqf70UHCzXIgw=
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

Add cadence USB confiuration.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 3bbd1dbd67..444ddd508d 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -68,6 +68,7 @@ CONFIG_SYS_EEPROM_SIZE=512
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=4
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
 CONFIG_CMD_MEMINFO=y
+# CONFIG_CMD_BIND is not set
 CONFIG_CMD_I2C=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
@@ -111,6 +112,8 @@ CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCI_REGION_MULTI_ENTRY=y
 CONFIG_PCIE_STARFIVE_JH7110=y
+CONFIG_PHY_STARFIVE_JH7110_PCIE=y
+CONFIG_PHY_STARFIVE_JH7110_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -126,13 +129,19 @@ CONFIG_CADENCE_QSPI=y
 CONFIG_SYSRESET=y
 CONFIG_TIMER_EARLY=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_PCI=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_PCI=y
+CONFIG_USB_CDNS3=y
+CONFIG_USB_CDNS3_GADGET=y
+CONFIG_USB_CDNS3_HOST=y
+# CONFIG_USB_CDNS3_TI is not set
 CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
 # CONFIG_WATCHDOG is not set
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
-- 
2.17.1

