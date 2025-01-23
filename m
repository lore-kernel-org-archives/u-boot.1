Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4272AC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 01:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CF7B807E9;
	Thu, 23 Jan 2025 02:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3666807CD; Thu, 23 Jan 2025 02:01:35 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20715.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 272B680214
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 02:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bO4Iza1G/kAHAdIujHTT9MO2ZFazHEwNpPwL5z0Q/ggPki+6knD0tcfwcBrQcgmKPrrycTo3B8T2IEKoI5fmYvJ28rIAVhrGCxqbWZiuW4WV+mikOlIs2FLchcKqkqhLLnXxnnbcdk5CV7BEA/i9u+ipvRBJwDioXPoNCHvl/AK17FQ/SJ2AS+CwQc0Av09BJedqlknmxnxVpOAXXqfnn5GTtFM6R/NHIcsJKc2HFtAW1O2H4JZNgNNulWug+8Nm2u46wepFvppDzcBYpMVhojc+C/uSIijAv/kjbI4mkQFCBO2UNpTlpvOQDseUL0j4f1pJZm3hqdqtqVBZyyVmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LicDOx2GsBZVG2ikeE4C4xO9+MTbiiVwJInwKO2Ir/w=;
 b=aaQvz1f1hospL5sy1gPAZ3Bb2tTOHPwc4U740MfFuulYOQO8gdUOOriQ9Uu2zrNvvz53YjHfEbr95AUaKnG2dVMnTBePDUlpMsSm2phyyltSNJB9w6dKxUfTxAvFw3cZfc5y+BhScyMpNbwZ2OGDM0LjJHYHX/zQP6FOVee3LNoe+CrdydDPUZeCUAKres4hZZ7bgASOf13R8jWRZlzZvbOi9F6xSMjctnXsO8hgdxeafvM9HTD0nSSOZszDN14rnlQxksES19LnsBIDUM5yq0qat00Z36HYypkcgUAFk+c1zjF+22YL0o1yPdnTifHpmqM2INRIMNZLYtZwOFgfMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0813.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.8; Thu, 23 Jan
 2025 01:01:31 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 23 Jan 2025 01:01:31 +0000
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
Subject: [PATCH v6 7/8] configs: starfive: Add visionfive2 cadence USB
 configuration
Date: Thu, 23 Jan 2025 09:01:11 +0800
Message-Id: <20250123010112.78924-8-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250123010112.78924-1-minda.chen@starfivetech.com>
References: <20250123010112.78924-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0029.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::10) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0813:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d18d183-0162-40f4-0e8c-08dd3b49794c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: dn1OuVv03xiYq0uy29/UbE4UQtCCQUSTdDRTfqK5/wesHOs+QJa4aZrGB715RRHOVkHnBYBb7p6t9OXIyn9NeGSpTqL1r/EwkQ1vvCuQP3VZ+gxbbGWA6K+dMvUYpCh0hvM4yu429kNzqdYnFNQuf+WOrlI89m43HuCUU8E10M0DyGn2e+B5ycU/XmhWetOGrGdL1y8XQdPUfVOpcEKhxRc3ub/NC2FA7S2FRFa4c3VERs/p6BgWlF9mIBpWRAhbZqUcWe5ftdGtF0udITFkF4zxLdiuza1qXFOmPJAcQmh4TpsxxQDeGomGq6m0Jc7OLniBjsGtxcu1Botw5ukhZqcS64raEncBjv1+0eGClhELoMRdpGZ/w6Vgzy3W4+y5scycdKyQbwwWP7Pvkyd8D7vRglZfe31UTv7/0bhCdOVHHW++LZsI/ALKPF2nv30hhrW8bw3UUss1BTOxD74ysDGAfqy7AAx38xh7Ftydkghq7zM7ZuoNnh+mNJmxe6X94GOpWTf1UOA9y/yWuF3k4kcH23qfRsQ4KcE7yjet4FUhio9Cj5W7vXRPcLRJJhRV4+EP1eWRG/RkP8GoEr41TVWOdfliJ9uiLZrjneLl8VM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:es; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bJC1fTyy8qq8O5+cHpLeZ9W4wSTx3AlMRC2gCejrarz5+kSeZ2mQAm5Eivgf?=
 =?us-ascii?Q?l5IDAZHPE2/488uXgSQT7RK6gT2fzXIyt7pExEvovEE9EHtFUURQg2TyDCgu?=
 =?us-ascii?Q?dTfSzFCFaUeNWS2YQYHNYhNtCGITRB/dxhwpg1Fv77hwsgyUEfxAGk/8JqJ3?=
 =?us-ascii?Q?+Ov9+nqzGW4O3rTLXMdlznbM97CZLBjbBbf/qZyZSmxC6ymN7okDn3c8do/M?=
 =?us-ascii?Q?9pRfqXyZwBz14CeI+mmLQglgiNz2udQx8+APm1uauE806MBhK8tb/T+yx9N2?=
 =?us-ascii?Q?6dkXDuMTtGd4UPrihxOohZLg0Q5c/taFYAzpW+pO7zvFlGJ5bY9RfB9bUdTN?=
 =?us-ascii?Q?j3m98Btgi52Zdc4oxvQpjGh4Itt3BFQfj/3DdOmcovy4GYNCZBvbJkrRsmi7?=
 =?us-ascii?Q?/p3DN8Njk1Cvwo2eJNqJIGvZF23MybunhYzDbEGdTjOT+bVuiUMpllXhpNyi?=
 =?us-ascii?Q?IkmJWcrIUOga7dS42wd0/K+XIHC5v9qGxx43ekP1rnk2MWeOaSz3ASlwj+aX?=
 =?us-ascii?Q?kWf2fJhUtiY1ewlvApjTU09gJzarzjHB7BTqIujTpSVH/2WSt4cfg000bf0n?=
 =?us-ascii?Q?TkH6urGkXEW7Nyu2Zyftdyk/ZyqBBU3JGB44hT0FMYT9qrakXMh0w40Hi7rB?=
 =?us-ascii?Q?bkfF3msLjmKKNhLwal5wsexdfK/rtneLMVC5jaJiiIctPAvTOA6hvobSirC8?=
 =?us-ascii?Q?Xfu95UVY6sCprumAAwB+bdvGTwFAr/8rLEYjAFq48jpH3b8vmJ3vh4lw80Uf?=
 =?us-ascii?Q?46x9/at0g0PDd7lAO6h24LMeBiT+eACRKY6ywC9ee+Norr/OScGfaGFQPHNO?=
 =?us-ascii?Q?Z/wEjlkfhWl9YBHfZm4YrBliSkqsbNSinpkdqWldj6Wgyn6Xa6cHNIkbsFB/?=
 =?us-ascii?Q?OEZjq4wbiWauYoxtTUiIjLG0U9axdZ6ommpGGfxdJclgfEbEGTX/HnhyzxrH?=
 =?us-ascii?Q?pTt27iR5EjTkoEHBSfNZpEWVn/BaOCEP7oEUwLHEiIZstRXSp/C0UDqWa6Qf?=
 =?us-ascii?Q?531rZhBfwwUmI09bwItxlNRm8G98cReUE7Lk4UxktFcEHtY2JJi4ZgIfIOTx?=
 =?us-ascii?Q?HT9KN/JHU+xVLGwviyY93oSVN9SdTEf8jaslW9IpLo0isz+fbsERNyFb/vMa?=
 =?us-ascii?Q?dXyNPzcaTkJeCG8GbRs51V7S/9Nkko0R1a9Dd9v67cLHJ60OOqAXDJWsTt+f?=
 =?us-ascii?Q?SGL3D4aKtCyNZjV8yuccHtX6UD35fcsJSoiAumpu5SXElr3GBMpI9YO//x1y?=
 =?us-ascii?Q?sfs9k62i3Amwe2kXkHOZIEYzhrbROwuvq/UndRWzPrxEnyl4LZ1juqqAg+lI?=
 =?us-ascii?Q?d8PHjfo5RvClskBaTxhB63wcj/QKByevVtmeW5y3/IyCpuorInREjjasaDcW?=
 =?us-ascii?Q?39+qt+aQzwTJCeVbkFlYM90VfoZ/8u9vJvhrxLG2tft84rt32U0n3Pqw82HL?=
 =?us-ascii?Q?TSKEJJJiZYavii85BgeKWyiFqefCxzqxvsjAJgLK7LazWL4e0H0fk/vAyQrc?=
 =?us-ascii?Q?48eanXY3Z5XRWl9rKAgwMM8ngGmYnU51ILonT1G4hMUiYNY4pQ0Ya8SlfhGR?=
 =?us-ascii?Q?YlmnPpvXqjriwLlt6Fy01oM4sYevwjHyLMToRrdkMW5lnIrKiRES03DIDLTP?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d18d183-0162-40f4-0e8c-08dd3b49794c
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 01:01:31.1310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6OHjLr6/EQva4ycf6ygPnDME5GmD81M3a+i64kgzsrn3CYA3RJ0oQ5HX5Qs8iT40tWBOVn8AdcCdLpi3pcJefnEAxQgV+6WTrGBzus7Umg=
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

Add cadence USB confiuration.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
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

