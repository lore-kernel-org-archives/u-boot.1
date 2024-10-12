Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850E3D1A42C
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 03:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A79A088CBF;
	Sat, 12 Oct 2024 05:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B735888B55; Sat, 12 Oct 2024 05:14:02 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20708.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0691688C40
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 05:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW9dI5nRoYLHby6D3r0jDdLXClqTLa7u+BdRZj2po+OIiHpFn4QdkbW1GPR8SqMQzzC6UQ4zYV+yWPAYG5fq7W28KsR2Z6r+QuK+OqMXOkpD+mGgSfpwe4ucoPe7EHtNdSeflgbRL2KF29fQTWnZ2oc0AHwMP+Af2QMOrGniN/iLHpEyKnIa/3Sb+rekHuFJ+EAOqrZ8uS5gIGOAoKkH47rjE6JU86rAiI+0m2+B0lLM1ChYzlBDwB4dnA1v4yKFmdPYkW5ZBzcmCZgk+b0A+E/Kc/pspuSceY0AgxYun9Ah1EiPRIWKHfseYpDGzmtqGQrHbCz7nmutEZ1NSrPXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyU8RrEQZjV3qU89E7IhqzAdLpaK8PGCPbb1rt+Klm0=;
 b=bVXgBWzFgmWNhyPJ7EhF7oneQ3WexBcxpcRYwDaGd/lCdHXeHI16x9DDe28L7iYHxqGNM/duRwp87f6aDFt16CxaLPuqABwu3cVhdbZ/Fi8qtk7N2eJrCQO7oX9TXNUpqoiQoaADiBtT2o01gU/5v1q5a0WpBP2rE4CxAjuSGcHr6f8+RRI6Kb5ydZgXvVxd9P29GIMOeps6hW/JWY3/rasop8sV/XqWICEWGVy/Pk3Evs2jSh8MoNxv6ysnXn4hEWmWmnDyF8tnPvKO0PQUP32DLZqzpgZF9GX3ntPplp2wUFPJHwWHivyLpT7DBHToToYxBYBbmTrBVHCd88rZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) by BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 03:13:49 +0000
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 ([fe80::480b:a135:6e33:10ff]) by
 BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn ([fe80::480b:a135:6e33:10ff%5])
 with mapi id 15.20.8048.017; Sat, 12 Oct 2024 03:13:49 +0000
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
Subject: [PATCH v5 6/8] configs: starfive: Add visionfive2 cadence USB
 configuration
Date: Sat, 12 Oct 2024 11:13:26 +0800
Message-Id: <20241012031328.4268-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241012031328.4268-1-minda.chen@starfivetech.com>
References: <20241012031328.4268-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::26) To BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0850:EE_
X-MS-Office365-Filtering-Correlation-Id: cb756ad0-dac5-4f6d-f654-08dcea6be43b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: EqhKcMH5tMrY1u5AZWSFJCuEbHxruolNHjHtqwMBtbv/tWJp9xDxT+/4fbiIIX5yZ277LrY0b4adMlGURQXfsjQ0mWEpl1iuR9B8mgH938haX82T3thH38v2AV1NQMQbBqGjbCj2CjhKk5MU88EegbE3gQDYtmIbcmqtm5iDtc66BV1OnhnBE0jfAxywD2nphonL9pdGXu3zHAVirFNWEH1dfh3CmM6elXHVeJdW+PmcIov2voi6Qjd44Cbhk2CLwdu9/PZhkWltL5v/G/QVZnuE+KEaqbWJjeus9wdoHkIj3//dWR6qqUeJztpo+dXpI6tqWo/WM/lDqNFXLHkoF6x5FDw4dyqSlAnfQU0Xt0jkXieORV0HcolCUDkQDgYXfGPleLzzHshNdJeIXbG/91qe2TUV3T6u+/QfEcc+DiLEodQB8S0sGPAwIbTqtIPEm7/f1rqFaaj5JyJwwKqQYKBagXiuDhR3Eln0vi6R/VwCLLsscl7F04jqjEXna5alSPyT4fBWHZOE7+5GgKFHTWscMD1+JY3yysLsdo4lFacWtzYss2Sq29nnHpMWain5IHUdQFEt6OG+2QH3zeeXLxvqSDC1Xfh7Kps6CxfitmjqKC8zKXkdqNjR0EJaoWNShSUSE3RmrnZK/wtVM6lZng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qOgiF2MyDbLsm9AOE0qpIctdRgveyqQVuqZEyiuFd0POqScniiLkcQTNwSNg?=
 =?us-ascii?Q?eZveVa916C58OYRk0//oubbXeEC0I76pLJ+xJ+KHS18tVhtkFn6fB9iNlznl?=
 =?us-ascii?Q?jCulgdqwoBppBfiQv2j8DinYhdIh9YPZC+LGMJ+banjJF7613MJGlV+X3fAd?=
 =?us-ascii?Q?C99wa+d8FzqR2OuaVbV+KBFRvOdtwkA40yx+rHRk8vo69fLdMaQXAkn0/Gyu?=
 =?us-ascii?Q?usYN6awCUqp7G61Rbt6vnZNJZ0rfFZSs7MMa8bgUFuiwWhnn6/NW0eWZ0knu?=
 =?us-ascii?Q?DI8iXInSgI2+G8YaBQM2O5EyCbItPPUOMncGwV3zYvzniFUVsfrySqGg2sEB?=
 =?us-ascii?Q?4du84+lZZ0Ggb7h7sTFXTed7HrE8esiO/smviRwPokLNa4U94P0RFrrV73f1?=
 =?us-ascii?Q?++vtIbWMa2RS6EZC/X+L+3VINQmGLbBVOVrItbVl0+CFqWHeVqaNpQD0cjC/?=
 =?us-ascii?Q?X4mc+1Kq1/lzBOSP/yKIHsECbNnHZ8DsZa7/jXl1jXfFNGFuK7oCFlZSHX0b?=
 =?us-ascii?Q?A6+SoylBXaYSMJhdgiKLFiNAmQhYdhqQN7RRMxVSB3UQ7xsqkSFq9LFUDQqq?=
 =?us-ascii?Q?E02RcVS5AqTKxePfePm2eSQRL5hYZSkw4RBdJojsjbPtwD+nr/fJ9JlFkFXF?=
 =?us-ascii?Q?GbKjS0R0RK9E4H7c+dg6RMsQg5yrjIoxZt7kuYsGF6C3I7UQI3aUGKXQKkGH?=
 =?us-ascii?Q?upULF3mamWyBZrVYiT9JEUN8ABoEVW0KPTkdWeUCiWjObMObOoMhPViMjMtH?=
 =?us-ascii?Q?atyP6Z7TT8QeoSP+GsffPcaBa/WTdcL7tT8LiAzeSG7Oz/F0qRlXMck1s004?=
 =?us-ascii?Q?amx4HbFoOnPW0u+FER3Zi8Kt1htOwE9QeByzOH28qMnRM9MsOhoX9LZ4NJvw?=
 =?us-ascii?Q?wkdfOTtVSyL05CCvU3vKY+0QCWxCvw8+oQaT0HtBwaYsEKnzbEgYSJ95sGMy?=
 =?us-ascii?Q?fne2iwJb0iKZ2nu+/Dr2xJY+vgQcx3liQST5Dx7XMIF/MnQzMcK3VCrWZyfI?=
 =?us-ascii?Q?ZftcCv1xpGjBcwg+QiKzlJEdP7n2pJefe+P6WHd9c2Vo/KBWYka0PwdTEy1I?=
 =?us-ascii?Q?/0we7+e4p+9LPmDYzClA4+l+gBPUI3OiSHRkoJzss5hNDkLZpSCFOt8167Zm?=
 =?us-ascii?Q?YEmFk4RT6Ij+5TgsGmFk2cF1a9GFuiUAx075wpBZOPIUtZ84JxIqrtI4Wwn7?=
 =?us-ascii?Q?aLEwn+1b7G/G+L1WJ+w+OZzbiEWWNvwELKdxr99RmlTU1b582MwsyRyscc5g?=
 =?us-ascii?Q?a5CwT+tXss9Kl/NuL1OTEfC50L48ne8ejCRBeDrIJXn8cYqCr40cHrpQJzEO?=
 =?us-ascii?Q?NDY5jZuwwXtj7U+9q18RFlYcNr7IYCj9nreriMeUsz2ly8ofUtYX/nFCyuB5?=
 =?us-ascii?Q?17es4buGCUJYb6kIw27e6SBgzMGVNMzrHfJ8krHH/aGS16nphfKM7wt30l+j?=
 =?us-ascii?Q?QhdFN+kME5I6Z8V/KbM+ILyt7DnsbVcTMDa7p9We3UJOCOfH7DMk7PIhIAmo?=
 =?us-ascii?Q?OJdDUa6My3/wbDdphiqwZNIYFEYDSoMlotsFonkf0k9K7EQ5AsqqjqZUoeku?=
 =?us-ascii?Q?h0hvEcxdyoDDtWc+NVjkqfJI1cCCsD9w3Mz/gLHScqmTFiGND1fzQ2pPdZsu?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb756ad0-dac5-4f6d-f654-08dcea6be43b
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 03:13:49.2612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /z+YorpyBpboxb1qB5ftFiiff+wpDI+4ze9rayLPvbMLDvJe1UUZ9565Qtlptcwlm8wPKraXWUDSZyDkiwIo2Za8OY2t8746lQqyw5Qcu5I=
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

Add cadence USB confiuration.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 174ac24dc74..4329c8705ec 100644
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
@@ -112,6 +113,9 @@ CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCI_REGION_MULTI_ENTRY=y
 CONFIG_PCIE_STARFIVE_JH7110=y
+CONFIG_PHY=y
+CONFIG_PHY_STARFIVE_JH7110_PCIE=y
+CONFIG_PHY_STARFIVE_JH7110_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -127,13 +131,19 @@ CONFIG_CADENCE_QSPI=y
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

