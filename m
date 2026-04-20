Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFCDF36C58
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 11:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB098432E;
	Mon, 20 Apr 2026 13:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CFebshMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9394384333; Mon, 20 Apr 2026 13:41:16 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD8E78431E
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFXW7blZbTjKTtLvPOQQ/WpWwhWXBJPxAgR2stlcT/bUlJVI4BJJiPBrvBHZzK6EbCdmXJN/cH6RwNw1gS9y1TlSqAEylDjBoEnKeTOk7lbPQmvkqxRR/HUojjO42sSGVuJ3qY1Nh84DO8o1dsIFbSdXL34xk0VVUmwsafUUtZogNdJaxfqviyzbHuB01aUiY3KlVahrqmcNGcAegzx731U0FFemMqwVHKUdZcp7p2RkXnQtBVNjr174jl+F/v0UgH5nKB3VpFFhTCGFZHw1uSy/YQc1NcNnjopz1Izku9rTIuk0m/XhwQdrgksNcc1yIRht6fJPPVY1c8vYklk5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA/p7qyEHHuPlscMa0HqDO+wwuQxy1Xz8FAHRjUN4v4=;
 b=uYoyq73mqJi6SdcKrgPk4NDZ3oO70SgHns21VRPTcjS7WAyUQSzWTIn01NWqiWiLvxlgMp7gTp1W6obOfEVJhkO8rvFc5eCHzkvRMNjedBD6TtGIfIni9KRuP+9SW7RpBRXlmstIe/vqDPvsXTiRDeV3TMWpk8TeFQ3tLQxvjS/nuqqPMMtTJwwHKelZIt+DVyGJJgrMLrEBnfgLMBqDEl0bAMhdQ/SazC//cv74QlKVuD60KuqYNCPwJf7tjpnREuY3ub5KRIHukuCukSaigy7D7XqFFyPoxU+jguf294kPila9FV+MBcU57yMPwe9tfxD0pVYxm/tqb6Shbel7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA/p7qyEHHuPlscMa0HqDO+wwuQxy1Xz8FAHRjUN4v4=;
 b=CFebshMfAcbWfXBcES6yWOJcoBd3BfA2hBjbqlxhc143kGkkRpIUjObRt0fC1aWR+i8/3myLMmE7qLDzwTOdfECgQRQfNRsL0s+pI2WYsnwtGbbVMQqx9V5zyt1jkCGOZNt18pnoAUHjqwDe4myBF+PccNsaV0YpzgRTjRy42ArawsfZ8nnTeRLZ0Y8TOh1NZr9qVAbIzMBZaPEPap3twE5pc2VXQj9uCz9OKIyg118eQpakCAZ3RWfxpmFDMyzsjIK9eA2QuifCtL9wWV7EIE5odjMQ+e55YEpwck9Ur9wZ8SqWjY9kgvbp2qzeD5nQJZNjKKVgNV8SFbznk4gApQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by VI0PR04MB10664.eurprd04.prod.outlook.com (2603:10a6:800:259::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 11:41:11 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 11:41:10 +0000
Date: Mon, 20 Apr 2026 20:57:43 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, ye.li@oss.nxp.com,
 uboot-imx@nxp.com, matt@traverse.com.au
Subject: Re: [PATCH 3/4] arm: dts: fsl-ls1088a: Enable SD device
Message-ID: <aeYix19UtlpVzbAP@nxa18884-linux.ap.freescale.net>
References: <20260417141529.1490622-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417141529.1490622-1-ye.li@nxp.com>
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|VI0PR04MB10664:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1d550b-e491-4988-c794-08de9ed1b7ea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: F2frMvqdeODUrTu1J98bWfAOSnCAU5E7wTwXQInJU/aNjd/fwixPPoQZC5hT0myLDyr4xusA4KopMBCbuir9HftB5TOp+aEJIaRrwBkft4ufY0lB8mRb4+M7hDrSRHYso6UPKG65nuVUTQiGhR7KjIjHT9v4pN+zEcTOApdBcY3cje/LieHVhMdIxWeyNbsWgoStcmkdUNlwNRaA54/c+efE28EZcsI8fx0NStpYmez3yIqGJoDtUggRUxrMDZlmGQ1oXXJTLwZfLBVAogWSHF0R+fSxrMK7stL0lc6/z7tdMsxrlR2iucVbEfBw9K3ZVF4Q+4fN1NrzR3QBIoTID3fP0oz7TY6H211d5nWN379VxBJq4bXaPj5732PPlVzBix09rdxyfL084GqmbX8pB8UtJfVtvIjMfhrUrQBE+z+ujWftGDUrCNyvHmWlJqI3JtHj8YIFxSqqs4QmBGyNai4nNpjQ4D0gxTwvYaeDWmqYvGtK6BKv46t1QfevT0qyOwYjsKs4js5iIg2VH0rLRm27P7eMy5KKkA/Cq6tCwplu4JLLAUFFg0szQ47tY8UHwyyWgygODDLxMSuyATX1xHhob1BopvFRBJlf/PXbfVzAP4UfuaCAm2cYacTSsU7vFM/ktSpcKexIb7ASv2VejRhE8gljinWYKOLPIGt+8P9NKPtMnc/CCFmK7dBOPnMziIWFjNbmScLP4J6Ub9UOce4kvEy4ltpergRQn+YzndPfYhKaVt3sFEj8P2nCY/UWM2eq3Z9n/+JgZy+L6UhRuYI8e4ftbzwD856h2Ylfcy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?unTPeMacHCUR3PfJaZ3T8Yx9/SR16XuRrGrXQqJrBmCNkds9osGmE6nBJXsI?=
 =?us-ascii?Q?zGPUH6ZQeqq5WkbEWwnGn84pd8LgKuuJFjFvkotpOuEUOhLKJAcuVefsrZhn?=
 =?us-ascii?Q?oHVH4ualcvRpUgqwrxXn9h0/IXLR0MHqZzug/T/Lht4Po81FGLcNpKhkVyxY?=
 =?us-ascii?Q?mMIVeD9nlW4Zdm1P+hkybaCCFMEo90vELw+5ho93HLGrVTTgjFRUZGKbS+Xg?=
 =?us-ascii?Q?hJJtFPlz290pMJ7jYA1cOO734hbwa2G8rCP2VFWneHG1gdZRY+oFuIfLIbsx?=
 =?us-ascii?Q?3UmP6NPLYYWoWBYGXc8EV/rSEcb7YSHc4Cj/UpWTVtgF4I40P4k7YlFeuJdU?=
 =?us-ascii?Q?zgDunxPzXe33ntp6/iFxzj97euNtxiDS9+Aoo29jNhBKT4YpSyQZr8QsOtDi?=
 =?us-ascii?Q?UWY5CyM1BbeiVlQO4IIpyD/L1+JYbvrBJb1WaMNIoaq+vWUNIjJ/KWgrm/Yl?=
 =?us-ascii?Q?+zY/VZ72mzkDDJGn0RLA1J1Wv5Q22+mj8z6+uiOnZ1SYzfNZgzYeIWAd+9Ku?=
 =?us-ascii?Q?8PRr0nIxPIkyst6VxX5mk0dsraNt05myB+H2iFZjesnkSuHz2yUHn8GO6TkY?=
 =?us-ascii?Q?eKzvCoPsum0A5WIrjAxy7L9i/0/gP99uB3vypWHWfKSn3A3yaiT9ek/zTkO2?=
 =?us-ascii?Q?z5H/FC775mgUNIiZKdGH8ErGwadwSqb0qkD4wseE8bxepTOX82LmKYQpnV7b?=
 =?us-ascii?Q?DCq2HSbLfwTArbEZ+xIpsqbZORsyUYscj+pcmRQY5m/rUznNB87+iALXiFL4?=
 =?us-ascii?Q?WOuKhZF2vH5IIeU7vDN1dgqDdjvIFk3YEyz2Fhooq6XPlCZ/s9BeYhPL5G7e?=
 =?us-ascii?Q?H7z/3gy+Ydj+iv/93YgZpYRRb5JQ3M7p7rkRjpIiniTvM6ePn0niRmwNtIoB?=
 =?us-ascii?Q?CzCfz6nnX5QYt0CeT0x/ZobTyn32sdgmRDn3w0b/mJYSSmsgj3jmG0AUtV94?=
 =?us-ascii?Q?92gvHXKTUyJ79f9iEK+gK48pQOSz/EvXfvCq8d9mPXaO/d0y79WAHeq9mX04?=
 =?us-ascii?Q?W14hRw2TQNp7ETVrKEIqrLkmF/CgYMUMpoXvaO8ErwtyeNWns5gpMAOA+zUA?=
 =?us-ascii?Q?kRQ5B0T58whaxVMU8OI8Io8opvBvJdM4jbH1f9nMn3zWWXvc/Qq8soJr0bHW?=
 =?us-ascii?Q?QjWHBcr75h+P/vA25gCzzUwL54jiXyq4pH5IdUcpI4SWt+e/l147cG9/m46k?=
 =?us-ascii?Q?mcSJJvZEoPUENNMoViyTKn3noy4+RE0YslGO4lROP1qTIyBxCakR0Ym7pcHB?=
 =?us-ascii?Q?73F+L9EWaPTsgkYyhFfu4mEJPDnIElDeFa3KClh0XRrnXH5t0mRwMmISFCPI?=
 =?us-ascii?Q?xD8oFgj/j+JbNAS9sowi9xuZUT7bdhx63thPj+JLC2JoOsQlIwUKDOtle2JH?=
 =?us-ascii?Q?SGf0gNDbYVEBEbAcXoeI25zzFt5OYrIN61WDPjbI69JTR/WSxJvtRWjmYAlq?=
 =?us-ascii?Q?Y420i4hHYJw6i4nttDUDs3o+syAWQDnaQVikNS7M88q4galWmfakw+IfcHKm?=
 =?us-ascii?Q?vjj2W2j29fQgVIQOe3fU6oboTubdnD4PQeSw2t+UCirQISSZ6N6prO5Sdh9m?=
 =?us-ascii?Q?g9zrJXRuqQnsd6tmh+lGeNY9GE18qTw36OftLAXS2HZlsvsVUtTn7MjeDh3u?=
 =?us-ascii?Q?ThqCDfL+FxkZ3ldjP4AeVOKqs9MHwn6mxxg4ijEWCDcAOycf/5e6Rr1qH2nt?=
 =?us-ascii?Q?6fR89VmSEsBD4sSr0MOQsTmQ/jZ3/NqNaMFDWLrRu4vucFJpCrAAfI+WCqqN?=
 =?us-ascii?Q?e5iqGXlTcg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1d550b-e491-4988-c794-08de9ed1b7ea
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 11:41:10.5824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tOKWtLXoyHqoSR08YJezPW64XIshe5I9Zs3p6ROxGEH+8MTAsKHc4Y6dxv9ZcoEMbKYikY9TyNVUGBntneoPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10664
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

On Fri, Apr 17, 2026 at 10:15:28PM +0800, Ye Li wrote:
>Due to update of fsl-ls1088a.dtsi in previous patch, the esdhc
>node is disabled, so u-boot can't to probe any eSDHC controller.
>
>Fixes: fd4f7b0158d0 ("arm: dts: fsl-ls1088a: move and sync existing bindings to be under /soc")
>Signed-off-by: Ye Li <ye.li@nxp.com>
>Tested-by: Wei Lu <w.lu@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
