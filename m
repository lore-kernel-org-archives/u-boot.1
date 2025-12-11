Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A25D41C14
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBBBE83DCA;
	Thu, 11 Dec 2025 11:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JL2dEToJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F8C183C94; Thu, 11 Dec 2025 09:59:52 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36DF0835B3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:59:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNRbW40MIxrtithGnP9z302WQAdr3p2aID3yg3ghmkdzrEpk2ZQuWW+XULRrskQMiOdvSqa2pQ0Hdwtusak7nyem277UxEOaTi+d3gtpK2DSNXHoDN0B4RU1O73p1qflpmAOidrIn9j2X5ZU8GDGgK27bVjJKNUK5hME/Bbh2ynutjwuMl5GC/FY/yTH1+5E+QH8kQalPyuXJC4SYx9evEA2eMrOJx5rwgZD/7N9GqMD1lL8CQf5AdGhFoT7TGWTdPKwlXRprZga2Izoambi35dEY1UzzUqvIiI4LpjuwcmpEJAQsni/A1vHBiYF3E0Kwl+bcYMMadyW5lFgpDRmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Rr4RDCaCMxoWBLYkTBn0OWaycAQQP7Zu5wKKNbmPeE=;
 b=cOuCQIFQhxiKoPKrKL0H6Bictbo8iNExgeHZqv3q4IHIMnCFQjNu6KPaxUey78W1Cn6onw9VTvaNJXRqQpOB1cQmjEcZGPxUeatqBsw2Bg+0lMJ1yT9PrSBGuu2g3f9cvu0ZkMJ7JXYjGUzltkS9wz5R9DTwj4X7CXwMAqpWDl8RhhehV081pshL+mJyZh37AojaK+NGEZhdo9PF2KmOCV3YrgycL43GQbDDOiptaruToDqcPS5Bve2hSyXphIy0wsLjMNV5REYm/KPJw4vT3kdYMopIhA9vsSHXDp97KBNv5JVzdNprSKCmbwKkt9634XzcJnNYBCXmsA5iMkvhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Rr4RDCaCMxoWBLYkTBn0OWaycAQQP7Zu5wKKNbmPeE=;
 b=JL2dEToJQZW0PUZZigINzAsiUwVwmBxEFzrcq5NscZ9mo8R4rGwjMHfgH9ZcYz60Ds+tizMuyVvkwSPJ9EQkBSGL0oMCUSEWzq3qzWPe7c/YlgkAie4D+bZNusoLFMGgykp0vL98TgLMW1gCduaXLubis0DJ+yEXewG/TMo7qXwou6lqvJeoqcqyp6EmuFQjQRuBw6Y3MJO8fxeM7NGwwEctPIrGNU+BBN7p+uhHknnRnWJEZO3v/huDTuS0d6rJIsCjXRH4Ngn63lRS3sCwnr7vuHDeEE4LWLTTW2UHtN7+o5dH/PkeMhSNfB27ygmytkuxk713X2G01GqKNgi3vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11304.eurprd04.prod.outlook.com (2603:10a6:150:2a8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 08:59:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 08:59:46 +0000
Date: Thu, 11 Dec 2025 18:13:18 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
Subject: Re: [PATCH v2 4/9] mmc: sdhci-cadence: Set controller and PHY speed
 modes for SD and eMMC cards
Message-ID: <aTqZPs559NV7RV9T@nxa18884-linux.ap.freescale.net>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
 <fb91138ab3f1b6208eb5cf053441c8a19afd8443.1764760325.git.tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb91138ab3f1b6208eb5cf053441c8a19afd8443.1764760325.git.tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SG2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:3:17::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11304:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0c511b-a41c-4fbe-9cad-08de3893a243
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|1800799024|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zP9DxurBvNpyUTz8Dvs5yHbxoaQe6HGd8bR1pMLoKZIaoE9PEHNYslbuuvNl?=
 =?us-ascii?Q?CBaaTxGNqYAhfSoxtPQJS5HE4cFQAnitI2qkemuUj62rtO+aMi6mcsOBAvUo?=
 =?us-ascii?Q?YXB1RpCPD9OZdXrc5zfCtTfk0G4TdY/BfU/geu9VgysjXwsWZvfDMC4y9qEy?=
 =?us-ascii?Q?nIE2kxVY6QaicfKtMD1OEPvT9XytKyFJlj5E5yLNBF2PnXP/NJi0zkcY6HuX?=
 =?us-ascii?Q?BhpcxYaGQn+iSrc67nAkfH3qBFvbWoDFf6CmJ2M8slu2fRKQ8eVEjJ7nSsTQ?=
 =?us-ascii?Q?RzrtNs2OM1CphcYec6RRr3wSFBgYaRM2Vh/R87aXRRXfBXUVaeWabBmxgRlm?=
 =?us-ascii?Q?91nCLHSW9xlI6AwIaugaIp4iWxaIccedhg5ycHnshj4QKYX5R4HdeBUlx3hW?=
 =?us-ascii?Q?LQRlnCJ9IDHQ5H4CysvnAoXQPxFJe5iL7HTmE6NOxHoy0INh4O0HIQRJ0cF+?=
 =?us-ascii?Q?sOXPvWX+1gfUofEHiBC5JVZ3IYVkRKDoO8DRSmdEHFXAGyh/WEx0elxOQvSp?=
 =?us-ascii?Q?xaWhptTLcvpx24tLvkEjHDiWB9DEv5vfJBDFEQLpDuu/Nk++8ea0uaS1SWYV?=
 =?us-ascii?Q?hVD4wcjDvx5Hx76bH2HmUfistMJZ4eScuxH40ZizE7nXuOHNXuzAPKbhMeN2?=
 =?us-ascii?Q?anv9zuEjZ8qJjtv5Rj0azhtXBrrpBtBb4onnbci5sjeupbWabxglZ34gZ1Uc?=
 =?us-ascii?Q?Cc07sVmOKcInxPzXbOdWqgDkwI9MWKFeH+Omjx/+ODi0EubXAGJHCmOVA1FX?=
 =?us-ascii?Q?ngb39eYY18IYNRF66Te0SGDv3tWIEJRXFaMzBPjexsudQaF4EqZb1GXozOcA?=
 =?us-ascii?Q?KAqM4XBWal0/kNJ3nswA2jdQTIZ+2CWrrIm0LzbtWCGnAz9NhFC72w0qBQrj?=
 =?us-ascii?Q?zOSccBun6PKFse3/aOL4SwdGdIlqaSzXqXA6QosddTqGsIMxBeO4shH7o3md?=
 =?us-ascii?Q?3HOzRiZRKivezYCY3ppJ/5AJ2rRJ97U21f8jDqLfiwAn1IMASmzjRR0WQd64?=
 =?us-ascii?Q?chZAC1hsXz8FJhZ432cze1ZKU5y9NNWvhtAzYh3/ZA8tj6oPRb5tHsavCxa9?=
 =?us-ascii?Q?gHvTc7l73cWHNsGGAfV0TV3MuscDzvay/iGAGOmG7XPDYI7OpdSjGGz563kJ?=
 =?us-ascii?Q?CXbaor3Ys4JeZ6lIplX8025bx+opk6T9mN+6Ro5LE9DlNSi9LLdWshOSl/Vf?=
 =?us-ascii?Q?ElBtaBe27atTCCBJUC+rHPA0ijZg9ulfFik6VF3gL3BJVttXLXKhk0RAAREH?=
 =?us-ascii?Q?AWZXI6ANP1mA0aeot5oWvHN8s9VwljMZkmx5aNo85SZnSV0accMp0Y7ylnfH?=
 =?us-ascii?Q?/WVx+CVG2wgDjuwUrSLj/I+PsLMLOSimxp/pMshPS/btCCP89uC/KhGu7ymT?=
 =?us-ascii?Q?NdVfpyKbE6LiTkG+p91apa/JA3+JWPRQWf6eZ6NQZIkW5HioBajejG82LbFZ?=
 =?us-ascii?Q?lhzueplyfx8/7XbXn/f4tsBcrixFk1mn5UvHy49koa2RF1yP2B4uihQnPDQ2?=
 =?us-ascii?Q?Ik37souDI2ukHpQfgAS7bdTSvpUyfO8KUV2D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(1800799024)(376014)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z60hMF0yaUoRRrE2NNsPaQ86OwTMmbChp2jKO861kdRK4w0dj2xJnuRbm5Gp?=
 =?us-ascii?Q?BRdh2epXsDcjXTdelbZ5E3A25vBrz9MiYdfpdyfiuyFf8bvpCRwG4b5BkrAb?=
 =?us-ascii?Q?JfI1Ok0UWMeEEXFlcVyuc7QizrqU0rQs59WCsHos90rS05tk/C0aa4wNv3Zn?=
 =?us-ascii?Q?xbEheL1bxxhiWJJeCWqqizwC/U2QlGGEhm7EoylRAa8IchWEAH7fjS+nGeFm?=
 =?us-ascii?Q?H+IssTdYbmQogNQwgi00vW4tFCkDn/rgw+dXS70HDOSsi1c5aT/xeFl5sz8H?=
 =?us-ascii?Q?AON8uzEzGsmNE0E+EbVAyX6+443eYlrSlsfD1pA3VlfQHKMXll7pcsjhs7R2?=
 =?us-ascii?Q?lh1FQG0AoCYOdu7c9D0ew5aZTDeZeQAzaFlf7z29+05Iz+Y86s9HU7kEEEmL?=
 =?us-ascii?Q?Urjh98upDlHzCCtQrZO3rLORZTFQkn/OEuZFde6SMZgqp1Xpy3Tp0wUtQx+e?=
 =?us-ascii?Q?H37pLQrrlQEjC/B9TCmrkG+mVzS1iHjj83SH5m1owAHiKRpk1colTHM8fr1h?=
 =?us-ascii?Q?3HCCPWZSbU2xRXx/xpWwWVOaugEJPaSJM2R5U7UflOPu/LxtJZoQF4P97Dvr?=
 =?us-ascii?Q?TeURyYNxbDpvkvVv5kYIKsU9REiwpNMW/B/D4ZMxhFmNnH4MzFjwW2zlPyoa?=
 =?us-ascii?Q?tl8e1qODQPf/0PTCAGGTCsk9oZkQgtT+9601UwYpKlVhS8Gd4zSXqUK9nx7B?=
 =?us-ascii?Q?lUF+54OWpudmurOswgF6msm2AaOnANlEFxZtC6Wju9U8YVSYTNnCnEe+RIsm?=
 =?us-ascii?Q?f1r1SpzHMrQxjGKNLwtntTZtGGrhv6J/k0j/ZSb0imG1Iy829uV2dCr4bTcj?=
 =?us-ascii?Q?3DaTtrEDOYY8v6DJYKmpZwpVywbhmhdtkI6ki8Kvu9nytfObp0+625W9e2Ex?=
 =?us-ascii?Q?gG+jMRF8F8dN5342glvcVMVTkIRSTW480t+86sWJyIpZ/SLblCAlk9+O5cjV?=
 =?us-ascii?Q?H4eBHCs3xaDTH2TRPHfe4a3ZGyb2t8GvdGB+R66Zl+ij6Zcl4B4sTxO41s2U?=
 =?us-ascii?Q?Imae59kS8Pwd+3xY8W4deFjDLP8y+lYXqTCXPKS5AU/v0Z9BfGy5hQLq/IKp?=
 =?us-ascii?Q?u9dEUhM3hy+AdyjQ3mlF3wHgCAlwM9d3A1phgTiyG3ffudLs1JYba5BZipMm?=
 =?us-ascii?Q?NdlOwxf2m1sqx9SuXksGiseE9Sa8TcYWk9KoNvB8InUTgT0O9UTkjUCTySnJ?=
 =?us-ascii?Q?AAVA1C3S1SAZEyD2WkNZycspEilMpKExbRz6vF2VFKBEntog1JnvHb865sjG?=
 =?us-ascii?Q?VC6ltAhCLCG/5NPw//9zLjs3y4qVwXJCnwBYAHBCAhETtTH5Jnis3r/cb5s4?=
 =?us-ascii?Q?+ot0VPaEUFXb4X0Ebj7AIjI7KKHwsYmFj+9xtRbFw7NRENjsj7Ybknb8BsjJ?=
 =?us-ascii?Q?tyEOhb7J5XitadDtbokOuCx7Swo69UtfNqeZQxozlLK6V2iZdOJSUx2wWNLf?=
 =?us-ascii?Q?AoUR4x5WFlcAyba7CEdxD5ziHq/9xbXTWJbKPWofda74Q1GRBAvBq65/p4Ny?=
 =?us-ascii?Q?cgI6WAuVQdYRrweuI8OCO+dnDcZ3z51NhHMIS9l6z9jhgtg3KVpUEYvgAdWp?=
 =?us-ascii?Q?MYpga8X/ZUsJeUCxL1bddCzgeq0KP/x2ufIIUzbk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0c511b-a41c-4fbe-9cad-08de3893a243
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 08:59:46.8379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqW1gkylHas//MD9TnqY1LSn26XRpykbIlQ8QN59YO4RJFBDyt/dB+QPoIHbuLAFgZ2aPJcSVqpPsMFjQKBtuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11304
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

On Wed, Dec 03, 2025 at 04:21:34AM -0800, Tanmay Kathpalia wrote:
>Replace the legacy clock frequency-based timing mode selection with
>proper MMC timing mode constants.
>
>Changes to sdhci-cadence.c:
>- Add sdhci_cdns_get_hrs06_mode() helper function for mode selection
>- Replace clock frequency logic with mmc->selected_mode switch statement
>- Use proper MMC timing constants (MMC_HS, UHS_SDR104, etc.)
>- Add SD card specific handling with standard SDHCI control register setup
>
>Changes to sdhci-cadence6.c:
>- Add SD high speed PHY and control configuration arrays
>- Update sdhci_cdns6_phy_adj() to use timing modes instead of HRS06 modes
>- Support both SD and eMMC timing modes with appropriate PHY settings
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
