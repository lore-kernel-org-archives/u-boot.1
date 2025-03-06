Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E9BC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 06:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C52BB81428;
	Thu,  6 Mar 2025 07:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83B5F81668; Thu,  6 Mar 2025 07:21:07 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410D381433
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 07:21:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2XuAAjbSuE1TjlUgxot+UPrh+2ZDQR03v4bHNsuDe1AnDzkTBY0YAbitC9HX8G0bHXXdaWNl2z1LE73lgpSJ1nDms9xkDbT5cpwEMyxqfM3fErfC9Z+a/ho+ux0cTpyOACYhcBNrx8RZdUGbhLFut1CKaPwXyTFyslhk8KuzFWs29FlgasKWxjmLDi18EMMT/KZwBIdaKTbW10O5DVYih/QhIMadHUkmNsebasGG8zJywjjth3WhzXi2YQCOZ/86u6RITwXg3Jqs0gfOgWYZr4gui/A5PiULNYDTw4+zTg1Jirf/wvEBUYisTb5yyUFf7rcpnsEkbZ6STtrTjo9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nv7WnYp0O1ZwAzKzvz1SnHLoIBQse9rGHGiMFCEMofA=;
 b=XqX2Ro0DWMARcxBw5GmoW05kvQVQEE9VKqJadBZ7Q2u1Ptv0kVbAyTVmbPLavp9e4w/Pp8yL4eFD+4ChmjNiCyL7F74LXlGCTdWLOSMScfzZot4CkJYCrOg9+uRv/eZ68WCY72ZczNltYGjk1nmhdkVj3+4VruCR2yo9hmrgwGYh70q1LuV7Mo+LvtwEgJ5AWPjZsl4wj8uHan8ZhdhIoLkz29j78YNlvvjc7HDcG/O3ppbiEMshgVOOD0IvY4iB3PiAgX1+kiO5wCvAXxY3SPWXw8IcDN/BDuleOJNTdlcLc81xZGzwoN/VEzI4GQ3gk2ooOSr3jxCpClu1hakmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.30; Thu, 6 Mar
 2025 06:20:57 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 6 Mar 2025 06:20:57 +0000
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
Subject: [PATCH v7 7/8] configs: starfive: Add visionfive2 cadence USB
 configuration
Date: Thu,  6 Mar 2025 14:20:31 +0800
Message-Id: <20250306062032.50314-8-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250306062032.50314-1-minda.chen@starfivetech.com>
References: <20250306062032.50314-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::35) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d71d3af-f77b-4f65-8685-08dd5c770a8f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|41320700013|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: Bxde18dMceJO29qkl64vl1FSj0I5XDvMDw9b5qGDh5J65nkwGLfgOZdZaLDTdwk6JnNg9JHkxVq6IKi7Mw1vzZij0xb+YE4Cpg3WWq3cOd8GDkiWbTkEqGDTtokC5CYlmVlo6xkkcj43vhfg32W540QvDnRI2TLU2U/a6mv989KPBrcrjKTs4AoPztrxSLQHO9Wt0Gv9H4vBTxdtnfW4V5COELdK2TnTtXZd87R0SduKDI00VQgAAiiab4iqyPP8tdyhHSOh0qFuAKG8SoWgrF7vj2864FbNT/vNgGctnqVxVRnMkEd7NwTU1Ms5UN8Af7a9Z39pfvwM9Vahi1G6HEK44UTk5HsnDCtBYLIysFVxdiGHIb6vfBbQjN0HaMiMBTGJhBo7EtFC+JAY9vUtaNQlzDSbQ9tGoUbvBHjFwcDEpPoWMU2vIExJryh3UGn3OpdheTe4b3rjIvzeRlODhSWNlXbcjbDsolm5L6SGrYwORltZUu4Eeip88rY7SWmOWUEY930UG8QC03/NUAAIFOQjpdeNWkTX4A2gQWTeuuMdIFfF8+vQhipUKyvOKA+w85a5GzDZ4HQ4tG0bQvl/zd+4KkQ8u2euCUOTsumciz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(41320700013)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sAWCq1BHGo6ATwoN9r9Rn0vMoQZsK6VWt7ZbwN/en5ntOhGPnhGRv3kKGlVt?=
 =?us-ascii?Q?Km0nLBeIIvJo1mGMRBDGa1PliW345etMXMQ/8cl0RcUoFxlXwAvOxuFTKWIx?=
 =?us-ascii?Q?14GgfBGtFWNt9jnSbWXEvAyGjEemgLKdjrJpM64Pip1tcbBT1/io/Gg1u+Ia?=
 =?us-ascii?Q?CfVc3tfPjGJ2jPcInaDNuPtB03je5ORFs1VLAhdduxR1gAT5BIYJkuh/d9Le?=
 =?us-ascii?Q?t80C9vPiY+52EVMDawY85/NdoGkk642CYNmjzN6WZx1HC81MTYWQARVRGMAh?=
 =?us-ascii?Q?HlFZpla9VJoJzJY4+i4rDlc8f6ZM1hPEiCTQ5wcplOrDw2vPzzjUU8WcEe/2?=
 =?us-ascii?Q?sP1GGlbbvJ00fNO1RKjmsVHRt2PmadK7dadeqmrwo/NssnPd/WvEZmNcdM+m?=
 =?us-ascii?Q?A8w0OsLujgO2uZL3NVRCzKO9F0HpZFtPrnwvt4m1vJXnGSQPbG1y96VI7NQu?=
 =?us-ascii?Q?NTow11ztsoaLx16kfRMxYe0xw9gdFHqHIJVJzmAZIBPWwDYGZ8xiDzVyN3vO?=
 =?us-ascii?Q?96ESOTsuFlmmE4EC8L19ZhqP00VWojZlJ49r7rsdoRkXjlnCpaSUeud3I2Wb?=
 =?us-ascii?Q?XoYpogyK5dR1kiHxvlTkuC+nRi9J7LoCMfWljLhWY9LisWiIn+Qx0hYtxfMv?=
 =?us-ascii?Q?VQ1RGfVPpnrVXaGpexWWYtu6XhnsEwyik0miwxdh7YIttKdm2msrY5tp0iAe?=
 =?us-ascii?Q?0/HzvRyQvwr5GDwzsps6b5lSppuq1MQnIWvScLzX0XrScxijM1xAPCT0IPal?=
 =?us-ascii?Q?OZb7HrQPR+P8qnfhxQR3Q0U9sLr2L8+ZS3wHFIVcxkrpyzrfYtWiCQLv70bD?=
 =?us-ascii?Q?62PeptCxkhX4nqy/2pT53Y3RlrjHdKMJu2PVQY4/LI4vyzYL2xEh/Xtnh5iU?=
 =?us-ascii?Q?7GEbr2kdBTCvN5N9QbAm87PVToGuJE41r1CFdHZFtXMrqMr2EXrSd6FvAYhx?=
 =?us-ascii?Q?J8L1YLX4ixyonfLF3eq8H6NuWgNMXT1HkZbye2EJEbXQ/Azz7Kred1AzEqF4?=
 =?us-ascii?Q?plICvnMahhaVuDfAB4fSIjgrBrXT2I4ib38Y1VdWhWioQqAmVnhBchZ7kxzd?=
 =?us-ascii?Q?pyOM462xtcyLSzcYUsoJSonFeO1kyxJiAE1tsqQuyRM8icwldiToF+z0wmDg?=
 =?us-ascii?Q?8gOGB0aVEKGY/564ylvJ1DPs1BxJt3k657E38BBexcdSI3oKj7ZU7XEtPxWI?=
 =?us-ascii?Q?mIjUmu4Q6YiCLPkEACNsre97dywB7lU1qMMW0vKeyF1994xmrCQc7DObXCWR?=
 =?us-ascii?Q?XYJmmeCnNBXEDjAF2PO+U+yQIM7loTzW0gzw2x9/JHPCwk0i+xPZ31iFnchs?=
 =?us-ascii?Q?yGEfRkEKoJkcQShT8+dJDltFdH9zK3Zl5s0SOEiSa+NOzX6daBqWe4h11IEd?=
 =?us-ascii?Q?BcNqlndBzl9JxKSe/cP/iTbstf5NqCmbhMhDrNHMmA/pisU3sqWI1JqtOZD3?=
 =?us-ascii?Q?vwQcHftau5+QrlE5HQJWdFSCRqicWSEoAKEhWwcCFQIYjGmB+zt/u4pwHIsj?=
 =?us-ascii?Q?UkX19izBiRolyL1rCUhnM3r1OwlKRJO9/FionjYoMgSLJoAjksNBfzt7EuzJ?=
 =?us-ascii?Q?CEsWxoQumjeFHQw5RwAs28dHyWDMeEqGRDwKGObFM6CjnSqA6jSAByWoII5N?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d71d3af-f77b-4f65-8685-08dd5c770a8f
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:20:50.5498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zonn7WE8O37sAqcZc+qRhax3IjzqGzGWZ08/S39pqtkivp0ISwFioVSjiRRnzDeCNkhuSsiTG7+EthmVPpfbvuG+3HzC9vO7TiMPYTExgk=
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

Add cadence USB confiuration.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Tested-by: E Shattow <lucent@gmail.com>
---
 configs/starfive_visionfive2_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index c3f2142ae1b..c2be9ffae27 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -71,6 +71,7 @@ CONFIG_SYS_EEPROM_SIZE=512
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=4
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
 CONFIG_CMD_MEMINFO=y
+# CONFIG_CMD_BIND is not set
 CONFIG_CMD_I2C=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
@@ -116,6 +117,9 @@ CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCI_REGION_MULTI_ENTRY=y
 CONFIG_PCIE_STARFIVE_JH7110=y
+CONFIG_PHY=y
+CONFIG_PHY_STARFIVE_JH7110_PCIE=y
+CONFIG_PHY_STARFIVE_JH7110_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -131,13 +135,19 @@ CONFIG_CADENCE_QSPI=y
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

