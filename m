Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7837BC7115A
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 01:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1E2E88B68;
	Thu, 29 Aug 2024 03:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B96E88A75; Thu, 29 Aug 2024 03:31:22 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20716.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::716])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9DB988ABA
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 03:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYO07IuvTAiGLZPdz/AhHairl2nJ76UM737hODJ/gYj64eLxld+9TxMVUDwlsy6gEgrL7Y3Kj7GFR7QoU8b9d8eqHUrhsKaigKEY7cw/XqFtfiUztOLAFpiGahf5ljB1c2W1/3yCa+QcNVCBZ+lNG0ozyqiELLbktWj8pJqOhPLOE/zbwNmB1arludTWdLyz5Lu3Aji7jWXDwijj0BVygmN84XCU8OLUSyhPpSLq0rYjpwcZyL377RWiu9R2oadS9c+qH4mVu9cGpHpT7l0wLAaAX41aAUfZhJdD3/oluDARdbNkiZXt78gGccoKjBaKj9wMYwfakrdn6CTsebkWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq+aaTQlEq61CZkkyT7KJDcpUwx2TFmIJLTmXXDI59A=;
 b=DwkIznTohf3TsMDTEDKPV1g8Y+oTXfepyV85sjs9ncgRbte9ogApvGHaY9uuhbEVRPY267xRzR8JpzTqO1VdWfunBz1zU4V/OfcTh/e3mcbSyS/HKiXtAvshz37SMvf0XBaW2p2g78Zm/Ux6tCPbpCuRYce773eARMPjah5tRsYGUsdRvVpJMp27TZHke29/1ZmI4Vk1h7zvtdoXiiCYKzh2DszkqGqCjXfD3V3z+6PEKkuZqRHS2asjuzF0mG2cE+eMIrmSVA2q4pkooIxtmA7r35z5IWzWautisAs4FTXdodx+eBzbAkbCZ+WCG9263TztZ1bDNlBZHrSip+xfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0574.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 01:31:15 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.7897.027; Thu, 29 Aug 2024 01:31:15 +0000
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
Subject: [PATCH v4 6/9] configs: starfive: Add visionfive2 cadence USB
 configuration
Date: Thu, 29 Aug 2024 09:30:55 +0800
Message-Id: <20240829013058.6178-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240829013058.6178-1-minda.chen@starfivetech.com>
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0047.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::14) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0574:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b02c1e9-cf37-4d31-ba59-08dcc7ca4601
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|41320700013|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: Bjcoyhp5lKRvrs8NgeCFHIrigkmTWw8dKJh8RquoCZJVTUNEHEaANUdu6WeQPGec8jGY6pVfsYfF1E4FOgBx5eGyAHeTB88WaRxgnxVJKf374srnVQs+saSPkWBMNJE51NoBeFMjTcxWd1/rro+FAi9m50WNbrUL7QH9nrNeoPhMapxVkrfRdCJuA1WkV6gzaOhi2QJUF4TxAcMD1nm2UPCCQh7gTI4hv4N+CucAqPcA5RbZ+VdI4g3MRWl7kVmt8x83ugoxzWDY2BYUEbEoZuuRnEby5Ggh1NrfpVdF2q23LpzqWr+dC4s+FDdNOvMFlCbA8sRquKrcvW1qUbJ6yOZjKOG9EmGOvhnA6P1MsP+rTUBOWpPmwhQqCRKlG0c+oy84pflAnZtAYfJR7Hy7Msa3RBSkcuMDnY2XNjFeEjbiG3Amb4IOi2rURopoSstC2Zk4s24Bd3VtVmGK+p/n2hbgZhuY10LhsYt/5pzCyoXLlNsN/u6BuNA4ZkwzHwlnvTF7qc2CbBqkrEw/zMIyNuwLSAbkCD33l51D6HyC3m+Pc9+IRzIvTJKsdndt/A+esg9Mut9pc7e7fqt9I65+/zrGbvabnG88a8yzXHfitjA0+K2UKbXLQkgHxQbLv1tbW6qcD37370t6uBApMKTOVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(41320700013)(366016)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RGI1GWNz0iWJMVOXRoE4X5+dia316NUk93sMn0m0r1XTJAafdPg2B8+kf3vy?=
 =?us-ascii?Q?ELKDx1jJT8MeN8P2kzgB1Bcw2K6DdqWIEGZTgy6khX+tomlIrw/Tgrdt183W?=
 =?us-ascii?Q?6pC+bNhkI0lxLKZNQPpFzKtdIursC3N4KuX17ne7vUJAacCBurPWOtyzRYVh?=
 =?us-ascii?Q?Rbo51CRghqTtdJE1inQ3FnaO4mtESaw7/uMr0LlXb/rrg/8pSUrXABRVG4Zu?=
 =?us-ascii?Q?99HXP/x346v8jIKb1AY2AcARF8z+2INd2iFXBIlLQU8uswotexxjnRU2gWGn?=
 =?us-ascii?Q?87IKUT/iDCL40RL/CXyb++K9ZAarSML+xg6BHk8bqzsYn5AQmjsE1RivGd18?=
 =?us-ascii?Q?NuCITihAGbET/VBaI2X88BVt78WzhYVo40fKjtNqgTyCatM7CPWfWqnVCBUX?=
 =?us-ascii?Q?SRRHLFwwcjbhCAQq4Fjx/FL81MGs5Atk3Narn5oT/+oUJ2eajUkdAInHdIjN?=
 =?us-ascii?Q?KwPUSrr5XR9pGoa4xpFf2ECqfD3yXXFxnaIS0BMw1psxRyMurGAIWnXnCBih?=
 =?us-ascii?Q?AoAgBap5ik3AgcqSuMySN0WIsFfBFg0gtq9rMHMM1q2fu7cWsHAP1vRwTchn?=
 =?us-ascii?Q?mWHdh29APYtQ/A/GVdFaQkLn9mBj3HwmVphBiwt2qH4iRHzBou5xIQ2jXSGt?=
 =?us-ascii?Q?XkJJqysw3wC0F1etoklbeJXZBqlljpg0Cn2mzrWBETaAU+c9UeT+CvfVbPtu?=
 =?us-ascii?Q?e4yECY/fXQjnruVKPQEN6rsVz/pSUTFmiSPUtakWvQwjjxjWmkHFh+y0Etn7?=
 =?us-ascii?Q?F3lBji+qOcwUI4GhU1H2aaxABd0ApE3gbq4OXoG+9QrdUhJi38ym51ySd7lk?=
 =?us-ascii?Q?8haO5RIJU2U5cI5j+kV3Q5DgONl1oRc+rSPtj5lbw9JLXYjrGrgU4nqXygDx?=
 =?us-ascii?Q?AB/U0eY2qLzhKA29VclYixdPS398bgyn8sSsH96PajM//5qSMOixxTXKNNFr?=
 =?us-ascii?Q?qQMzsMHVi48E/0U5lawcEx64rXg4ZCnkhpjpszmQGEwpki2aAdVtR7kSoN7h?=
 =?us-ascii?Q?ESLWX4EPodh2nh/1Ok3q/o3J6bXeZA14A8ZnNaBgc22jbbawlOY/F/MminKU?=
 =?us-ascii?Q?GT3lXIGCaBC69abAD6tXfXEbkUk+AJowUl5nmHVZGT0zKy80+jLggw9qjRhp?=
 =?us-ascii?Q?1LbSZ4572b4AdrBIi6Ea3pVMhtsYzK52J6iKpFtI2REYE5CJMFpQKl4AXXmw?=
 =?us-ascii?Q?lRNPrS1LgeEeeMe4ZtwSxE9V81P2C9/OqyLEL7pofVceggMWIJ1AvWdBdZcI?=
 =?us-ascii?Q?Lv/9u/pMRV+BQirLcaCsAPvpR8xz31KdkdL88oG8GyZILuovOPgnCjGFrFBq?=
 =?us-ascii?Q?IpaD30xgrLIBl8Fb9hyR7aeUtQ9yBP7AelO+nr5koRUUQlDkPWxLWqFldeIp?=
 =?us-ascii?Q?IxGTItZS0kB2juZCE3foYTyTCTfudsUIw1mEplNzoH2+zOzLV6hPJEDmR2iW?=
 =?us-ascii?Q?bCeCvfx2iOm8gCg5fHyKCEP45byA7IeTyWk+H8pQEdUEMDoTBl10wCLx1TO0?=
 =?us-ascii?Q?/+Procc3qmINQ1CZrnXEzdAbH9hgdbo8BK8LYi9AtjGhurK4TXgL1qCX4XVI?=
 =?us-ascii?Q?FIQBIYme3/ECPn/ctNe7g4+jeUGaSDV0c2VFU5nm3Jhsb7Q4EfZaBFzHi/9o?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b02c1e9-cf37-4d31-ba59-08dcc7ca4601
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:31:15.2510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xk7ki45oemPhggAoPt1+FiI35MX7BtJptZSzOd+qCoUcWQGElfgXmn+PEuMGFglt7FGVkXorkMr3TU3dFpCMvAyche5T7nGs0O1j/CICvlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0574
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
index 174ac24dc7..35137eec59 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -69,6 +69,7 @@ CONFIG_SYS_EEPROM_SIZE=512
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=4
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
 CONFIG_CMD_MEMINFO=y
+# CONFIG_CMD_BIND is not set
 CONFIG_CMD_I2C=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
@@ -112,6 +113,8 @@ CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCI_REGION_MULTI_ENTRY=y
 CONFIG_PCIE_STARFIVE_JH7110=y
+CONFIG_PHY_STARFIVE_JH7110_PCIE=y
+CONFIG_PHY_STARFIVE_JH7110_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -127,13 +130,19 @@ CONFIG_CADENCE_QSPI=y
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

