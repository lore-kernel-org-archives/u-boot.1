Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C054F483E7
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B30998412A;
	Mon, 23 Mar 2026 20:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZGXn12Ir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EBB6841FA; Mon, 23 Mar 2026 20:37:24 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB81B84114
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4VlXREF6DvpwaDii5e+OX2lmpTF1IjwFybtj/j97ZFRS1/FiE3gOZToSmEhSAUKXzUIoPqjGdrLhHv1l4ne74baOTtlBjPuk/J3XKPNMbwIVcE+aY8rwd0muEGT5dDX5UzU956WAgxZHWd3hkRVN7zZLqGtAnGDc4Vngj0+qDZadGcBeXBBdOMCaasxJCnEJMD3VMT7AsE+JiGqqwQ24edRUu5PDhyx3j5y7FteO4ZPSqPv7Lrf2F67YqDXyFhCNlGTveZmV9jw27kzQ3YIUYGaokyfLVd4qNYbu2clVNLkDk68W5xlzJeNQp6D16TyLeyKj/bxFLkVtRlS9vO9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+KmXV4N3pUhHInWPyMWNx15Teb0iybN18vg5VCFHjk=;
 b=GPtUB+VUz6ASXSFij8XYjRbLGGz7zsgfnzrGS0BE4dUKpuydQt+iGdrHPHjGz8SKW4qJoAAqvK7IHKz4TdT4n8b733fQ5OljyIE3HW+YqHZMUuWsESyf/BcU3uAJKVAyRLImhzG7acvk1QycHlOZhZ/4Shpg0kGeeV1GwO8f+nyKjLiV0DNhH/FI59K7pWzXI75nfupq0wkZQJMP1vFtj/+IoPwQEg9FUHKKsdudltaI/ebQvd+PykmMN/XzBNeft53O1gWahqqciKvACDUS41G4M7pFFWL+uvT7rP5Or8umN8+25HdOycz5TQmcDwkUVicbymTBJXcezonmr56czg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+KmXV4N3pUhHInWPyMWNx15Teb0iybN18vg5VCFHjk=;
 b=ZGXn12IrTv2Duq67VaccMY68Ra4LPpwvnNIWKqo3JDnkQ0ULlK68YYcy4Oj3SpVNvMG9F2Y7z2Gog4xOnt3Z1YEVLjhcIp/qik6SSXZwN557sbGPG0VcylIfIkm6Kr1raNi+IMItEJ09EHjbckdo6bCmissGlcSnHt7AxExMSGU=
Received: from SA0PR13CA0025.namprd13.prod.outlook.com (2603:10b6:806:130::30)
 by MW5PR10MB5716.namprd10.prod.outlook.com (2603:10b6:303:1a3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 19:37:17 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::b3) by SA0PR13CA0025.outlook.office365.com
 (2603:10b6:806:130::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 19:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 19:37:14 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 14:37:14 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 14:37:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Mar 2026 14:37:14 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62NJbEN3834467;
 Mon, 23 Mar 2026 14:37:14 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 23 Mar 2026 14:37:14 -0500
Message-ID: <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
CC: <rs@ti.com>, <bb@ti.com>, <nm@ti.com>, <trini@konsulko.com>, <afd@ti.com>, 
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
From: Randolph Sapp <rs@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260317223800.776581-1-rs@ti.com>
 <20260317223800.776581-3-rs@ti.com> <DH7I5D8U3GQX.1NAV7HTPAAJ8L@ti.com>
 <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
In-Reply-To: <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|MW5PR10MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: d200ff07-7a45-4015-57e1-08de89139625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: e4RSgvtjUJn8QhssMsoHTugKV7IKtJE1sTvP2TyfhPXcJdYDpVBBF/fqWd7L8LpqBh8Tg2zkWhBLK+3NsyfyN7shYzAKfwpG557SF58zTqwPp9TOyDSkW5ObIGDMwjYyvb8Tabi6bp9Kwg8B7LrS1a733+7HFsDOyqi/eKoQhX2zMvjIEC7srP9kfsfVNGp1Wmzn+lLT+/vaDbio2M7dGW5gECdQ8ymImJhAYXEYEjDr4VC1iMoF3PzUZuTs7OGgGZGpRpLRPIqTI3ZDTNV1zhb9ZxOUl2r98kl6RxmOuF4zvJwders9tw+5bkbVGS6ABgBt7TM3pxGeRuY1ArU3IoCkJGXJzJEzB6/JZIXl8JpBY4aD+zjJGKycNRAc0oEgCJTMRLbT0s2SCGEneKZOSpsLKWbYVjaz+teYPIH3LiPIwAFo+cFqVEoNa8QRKchOk5tIrt0yngh5xKWwSAmqXHsmGJivxr58qBSgEh+mPxFtmLFx2QcdVbxPFhzVSAukYzLTVZFEYa1OLINWQ6qhA9d3xshBef8uDz8Lt3hehdTcUhCyv1M38K74R683S9qirENbV28Q6ZbFwV+hFMQbHSo331ZUnVqiyl3o1qnlFEQeawUlzSZixtHrLb52rGmKWxHx+I0oQTMSZIqhu7VKrVLGKIt3s2lWp7ICpsE1Xe1iKCqPhW5/YHFP22TmhgQIU0M+mpFPfIBqCEAt8yqFPj98Svsu+M/H8JuFW0+eTwg=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /XsqPiweL3Lf5Bau5d9A2SmAoOKoyhLcUW6HM7kc760Vg/816AqXFofEwfMt7WHPJtmAtd+bQZVXYd57HzN7Yc1J8Ty/BkW3ZdB/12MVlKPLV/B8z40YRw05l27sM/ZZkQmbMBoOTO2OlwiCEjEO/Ep27qCA2xnBeIIvogjbhasFmePFR8GDIfM763aR7XQ1MPmD5rYpGoTaSB0oWfTUtY9Cg1dwAVqBv9dytWiBDcMGNE3fI6ob/7D8SN47r3KcpDqrBwaoiZ6GvwxSB/p5HGIKAW+8oNLBFCURjORkVO/J/bmmtXGxRe03D3C54qy/UUbi3DvNJHbh+u3CnQIMp7JWmhxwYso4LGhTpnZ+BZSVtJw477vCtldAhem7rGl5ssq3CeDwcMfAxaqfOkhyB4cAId3Y1dxfTKdm7DWPKZW4hwVSheAxOh6f22MRfIRl
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 19:37:14.8897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d200ff07-7a45-4015-57e1-08de89139625
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5716
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

On Fri Mar 20, 2026 at 10:32 AM CDT, Robert Nelson wrote:
>> > +++ b/configs/am62_pocketbeagle2_a53_defconfig
>> > @@ -6,11 +6,11 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
>> >  CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
>> >  CONFIG_NR_DRAM_BANKS=3D1
>> >  CONFIG_SOC_K3_AM625=3Dy
>> > -CONFIG_TARGET_AM625_A53_BEAGLEPLAY=3Dy
>> > +CONFIG_TARGET_AM62X_A53_POCKETBEAGLE2=3Dy
>> >  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>> >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80b80000
>> >  CONFIG_DM_GPIO=3Dy
>> > -CONFIG_DEFAULT_DEVICE_TREE=3D"ti/k3-am625-beagleplay"
>> > +CONFIG_DEFAULT_DEVICE_TREE=3D"ti/k3-am62-pocketbeagle2"
>> >  CONFIG_OF_LIBFDT_OVERLAY=3Dy
>> >  CONFIG_DM_RESET=3Dy
>> >  CONFIG_SPL_MMC=3Dy
>> > @@ -44,8 +44,6 @@ CONFIG_SPL_I2C=3Dy
>> >  CONFIG_SPL_DM_MAILBOX=3Dy
>> >  CONFIG_SPL_POWER_DOMAIN=3Dy
>> >  CONFIG_SPL_YMODEM_SUPPORT=3Dy
>> > -CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
>> > -CONFIG_CMD_NVEDIT_EFI=3Dy
>> >  CONFIG_CMD_GPIO=3Dy
>> >  CONFIG_CMD_GPIO_READ=3Dy
>> >  CONFIG_CMD_I2C=3Dy
>> > @@ -53,6 +51,7 @@ CONFIG_CMD_MMC=3Dy
>> >  CONFIG_CMD_EFIDEBUG=3Dy
>> >  CONFIG_CMD_PMIC=3Dy
>> >  CONFIG_CMD_REGULATOR=3Dy
>> > +CONFIG_CMD_CACHE=3Dy
>> >  CONFIG_OF_CONTROL=3Dy
>> >  CONFIG_SPL_OF_CONTROL=3Dy
>> >  CONFIG_OF_UPSTREAM=3Dy
>> > @@ -90,10 +89,6 @@ CONFIG_MMC_SDHCI=3Dy
>> >  CONFIG_MMC_SDHCI_ADMA=3Dy
>> >  CONFIG_SPL_MMC_SDHCI_ADMA=3Dy
>> >  CONFIG_MMC_SDHCI_AM654=3Dy
>> > -CONFIG_PHY_REALTEK=3Dy
>> > -CONFIG_PHY_TI=3Dy
>> > -CONFIG_DM_ETH_PHY=3Dy
>> > -CONFIG_TI_AM65_CPSW_NUSS=3Dy
>> >  CONFIG_PHY=3Dy
>> >  CONFIG_PINCTRL=3Dy
>> >  CONFIG_SPL_PINCTRL=3Dy
>> > @@ -120,7 +115,8 @@ CONFIG_SYSRESET_TI_SCI=3Dy
>> >  CONFIG_EXT4_WRITE=3Dy
>> >  CONFIG_FS_FAT_MAX_CLUSTSIZE=3D16384
>> >  CONFIG_LZO=3Dy
>> > -CONFIG_EFI_SET_TIME=3Dy
>> > +CONFIG_SYS_MEM_TOP_HIDE=3D0x4000000
>>
>> Any reason why we are using TOP_HIDE here instead of just moving OPTEE
>> lower in DDR like we do on the 512MiB AM6254atl EVM?
>
> Sorry, that is now a legacy setting before OPTEE finally got moved in
> v2026.01, as this had been developed thru v2025 u-boot releases..
>

Well, it's worth noting that this change was not done in the usual way, and
involves user interaction during the build beyond selecting a defconfig.

https://texasinstruments.github.io/processor-sdk-doc/processor-sdk-linux-AM=
62X/esd/docs/master/linux/Foundational_Components_ATF.html
https://git.ti.com/cgit/arago-project/meta-ti/tree/meta-ti-bsp/conf/machine=
/am62xxsip-evm.conf

Robert, are you alright with me making the requested changes?

Randolph
