Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B128ECCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 17:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A42836F0;
	Thu, 30 Oct 2025 18:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gigadevice.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=gigadevice.com header.i=@gigadevice.com header.b="KjDmyLeZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 145C283849; Thu, 30 Oct 2025 18:59:23 +0100 (CET)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 987A5836D1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 18:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gigadevice.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vlim@gigadevice.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tG1LpsewqpT896mj9UqWpu+mfO2seO7nK2ozGMTrnbALi3qjgybF41fsEqD1HDTwzSNvGKr4rZPr8NywnALplw0YYJ+6te9vd6xeadTOWXICPOLSfx7agjr42on93UVnOmweo0L/smaxDXVTzSL9Skbu60eUNQ1dZn86rK+CEOsVjR/R+aIZ22O4k4RRgBslgPrDmkef7FAw+EyyGOmXKuWl9oAo9jm/BgMS38lHJiOEFyJ/eeDICRw2FJv2JUPPmmNt3GRnjJ5xl2vSiawS6QaP9v6S+8m881D4enXqBnORIfAUPb8AjFWpYAgsSRRIvAaN7bh6KKV9QjIaJMMWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zilOSNI39VvA4Mh4Wx4VssX586+OuhJOhTbBFXzU28U=;
 b=RgTpOUfyerizcFQlvecFpNlMOOTa/jb+aTDGNAC//QcqBdk+e3mbsDeMR4IAwEf9Hx4JY/N/i+/dA9PTF1acvXYwXyUDpYTjhgvFG/vZoJAJ9PDGUB4cHxutTZG+T+TC0sn4ilx6TToTo9QWMs+y0qKJHTQgt3haLNhpus2ZtWCo79twrXve2QPxWwI1PlIRemkCJoFiPa+vdicRw85nLYGlBndlYKvGjpfcrKgIhdssyXbBnUu+vZR//cN5l+NaeL74YGHzwWOCXw1C5WdJa9bYewS4I+l54CoNUARMWvdaT0Jqw2lvUv/yvwiUMmgFFBhGT4Wz5OyBeJe2HtMc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigadevice.com; dmarc=pass action=none
 header.from=gigadevice.com; dkim=pass header.d=gigadevice.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigadevice.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zilOSNI39VvA4Mh4Wx4VssX586+OuhJOhTbBFXzU28U=;
 b=KjDmyLeZFyzx+zyHFYlT7KzOVwuBNX/Klhf4SQbuCYRT9Ib/mm9IDGzHBfTaQ0iqGqXsvwyqdXOafiUtRoTF8SPIzNZA9deJ5W7k/Xm2lBimANF5w2mRmoTRuLrzkTiBEJGxvUOf5/PzYGGKxbf0EhgwQHtVghSjCIi1akHQXpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigadevice.com;
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com (2603:1096:4:26f::11)
 by OSQPR06MB7231.apcprd06.prod.outlook.com (2603:1096:604:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 17:59:14 +0000
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16]) by SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16%4]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 17:59:14 +0000
From: Victor <vlim@gigadevice.com>
To: u-boot@lists.denx.de, git@amd.com, jagan@amarulasolutions.com,
 vigneshr@ti.com, tudor.ambarus@linaro.org, trini@konsulko.com,
 Takahiro.Kuwano@infineon.com, venkatesh.abbarapu@amd.com,
 marek.vasut+renesas@mailbox.org, havish.mutya@amd.com
Cc: vlim@gigadevice.com
Subject: [PATCH V1 0/1] MTD/SPI: Add new part numbers and modify one part
Date: Thu, 30 Oct 2025 10:58:55 -0700
Message-Id: <20251030175856.115246-1-vlim@gigadevice.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To SI6PR06MB7813.apcprd06.prod.outlook.com
 (2603:1096:4:26f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI6PR06MB7813:EE_|OSQPR06MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d3f673-8d05-405a-5b7e-08de17de09a3
X-LD-Processed: f84ba339-959c-4ab1-9b67-1e43414f945e,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|10070799003|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SbVVeJsBSi6TvXQCtqO77glH0IxkGRJTzCen/RdWAHMyldlnEpHRaiqDQnVZ?=
 =?us-ascii?Q?WEQBSdfnCpxX2awz0yPYe9bpHEYiZMPwyaetKcsCkLtOVy6sBFL20+o4Ye/9?=
 =?us-ascii?Q?uvSFrp/absTAu21X0m3u4OYe4nvmEtAuibhnueEcq+zy3FF0tN0RydL1R8d1?=
 =?us-ascii?Q?gbhzFRU1TCPghWgKd61RPuSl2LzfV08ejmPlmOQ05hK546fSdsiH2Q+mgZ7b?=
 =?us-ascii?Q?0txbYfX0N868fQ4CN4wQCRURXZxisKR4yGYEXWZCW+bosvXc22lmy1ddnEEH?=
 =?us-ascii?Q?1r/ZNjX7ycpbIM5SVA0yvb2y9Zog/C4aqa11RC1pVcgoXdkT0qiJA+I2Fz8r?=
 =?us-ascii?Q?jDM5ahcqqncKjBSOJPKnhZDAg4WNHwbN0FFiVFxEEtLY+JEcOcDAa57d+kbe?=
 =?us-ascii?Q?lAkS+bMEy39fnWYIYGjCI9d1vg1bQ4H/RvaOagmMPAtEXEHIPY32SHbaYbbq?=
 =?us-ascii?Q?56nPp5PCedvI99FF8gcrNL9H1wYymBUFBgryfBWYR1eDf7bDU+W+cbkDegU8?=
 =?us-ascii?Q?1YSiA4MWUGsI/WUymUw1Jg0xiwhRr+I6FrTgPC9XAmJdCxKhIK1Bu4tATBqW?=
 =?us-ascii?Q?UOkyzt5oYUdaHCvzJghHS9P3o6dubA6QaVS2O3Hq8JcS1Rqsb3A4K0o8uk+W?=
 =?us-ascii?Q?GNko92nKwrzdrCIeSdPuWGnL2ofbVjVOQDYF7OyEUbuDMu+jpIi3thBJXtSj?=
 =?us-ascii?Q?Y3xRKHPFwD5MyTRYj759dbYZDDZ8XFVMOP4qSna/MurRH0QsYKDZYbXUkVVx?=
 =?us-ascii?Q?tQgt0tx3frhPvJsnZYsHXBnsC1wkk1SRRJSHu4DhQrCPI6XSG9m0qIPydgJr?=
 =?us-ascii?Q?rDCt5hXNrrnQOqCdm+D3CGal/YznINU3gGF9ZXJvw1bSHMhVqL/VDPW1u4St?=
 =?us-ascii?Q?rla0tzIKLCWH4Z7qIFdeMZ47bpMnSiUYwI/Y88CDqgctGTUPp1QZeDKGUi+X?=
 =?us-ascii?Q?6U9+4Ud7sM7CFIJzg9jh0sPuncpQH60vQtjDo6ldq/IDXl+Ni2zN/pnRGqQ5?=
 =?us-ascii?Q?xEwBojSV7f3QEDpoQBcFpWTm5yREg3zfW8QkYITs4iw/G4fRuUAsU1iHPg+S?=
 =?us-ascii?Q?23irovwiyI99gNGAtL5vujh8+1T1qUPisnSsTCG4oOuW26AtFHszXUTuR+dI?=
 =?us-ascii?Q?VSIvsiGIFomgmVp6iVznm9Lh13usr2CQ7iV64Cgw+vLwSmKLR4jK4da2XKHx?=
 =?us-ascii?Q?rO4hGef1EFs1VjJNmTG3FKgossb1DfAmeB+ItsnPWIa5XGxsgP1piZn0E4Az?=
 =?us-ascii?Q?Jkeq/tZxpd2orLqcB4d+PQo92+3YvkxDZNCANo4dFXD8bPUp0xM/JLNYmpYO?=
 =?us-ascii?Q?nOr324y3izbt1wC2w6Yc6ji8O3vm4fkQRiiWUAnC+kzzegrxwhK7cQu/ZOUx?=
 =?us-ascii?Q?CdHLVfNzB1A9wh7DTuFNrC7GqziFTT3YuqDtUerN+B8j7PPkqyiFUC8GOAPe?=
 =?us-ascii?Q?xMgYANgov36R8nUbZ0MI2482HBD1fxel?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7813.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(10070799003)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vVMcryFNZXPbKkSTusB7II5vo2o8H8Jy/I7yIRMqDPTauoGirYSIcvDp8NSU?=
 =?us-ascii?Q?doEPOBFrgkw6fL/KpSCJ8REQkbRCEHB1wfIg/8fGR36zByp2DWA40IPX4Fj9?=
 =?us-ascii?Q?SjbhJg7IgCP7CymaXzt8PU/SZl0j6w8IhudD6TW3H9TXHWEDYx6T9atAI2LG?=
 =?us-ascii?Q?DluIAzOl8g/99QvbRPNC44aEpdQLgvC4Roj5Y1AXSKhZSrkAnLWCRwDXNYoZ?=
 =?us-ascii?Q?H5sXZljrJ9VI2ijDNtdpO9tKqpyvstrVTF6Uw868tHeSPa7NrxcOnxYwjxWL?=
 =?us-ascii?Q?f2qZ8qQO+EXnB8QUG9Epdmn7QoUNxE50m7RlhAlGxfW7YXtVRdbMJD11yAQc?=
 =?us-ascii?Q?7Rw7oMGTbbkNjH7QRseIUTx8I7q/iHsYvuWINkoyfn811attQdRGSTpyBlNJ?=
 =?us-ascii?Q?0KyNIsyodEGjXJPQy3eOx+as7c5ZqBGi1VWxIV/2bOMpapBX11qZxJz6qKt9?=
 =?us-ascii?Q?u6ZW1bKx85ASBLXQ2aivDWghe9WyaM4gvvhs0MFj3V8iy17g8tjykrz6JZTV?=
 =?us-ascii?Q?vEQHo7dF3se46cRqmYYejUY+9h4ixlX0J3WjpfaCFXixcKS671zCbOeL8L3M?=
 =?us-ascii?Q?E4LxSEaDGYHYsG56IjNd//OGy6gzXnaLNvZdRLEdQPGmgVmQ0FXXB3F0HJZl?=
 =?us-ascii?Q?qlndDa8eu9m2gkBz0Q3dPPWqv+mmXMPXdoq7Iqwjod3/mjGBp3ivHs3+di+Z?=
 =?us-ascii?Q?vuw/L/cvElw5K9ZElmzv4IazZTbviEmsbe8J2pWWFl/xJlJ1VCu5N/EMwGO+?=
 =?us-ascii?Q?DTHU8PqZUMtvZ1YuePlK1YsLYDET+yzKK7lr/4m1/v378rDZCcbkfBdSvVtz?=
 =?us-ascii?Q?Gud98c4G3AhSKQFSoFco7E1mmCOjP7kjF0iqW5CtUIQ6uiRpe8nKKMCz9Qdt?=
 =?us-ascii?Q?1ZRAPv01jnxSSpLJYv9OcMETjWtnoaWiDqr90pxbQ6D5XdkMZ42qx++nhmD4?=
 =?us-ascii?Q?OLcWiJxAoup7a1JG6WlbeXmol+E4P3hU5UYPEe+tOmZor1ECJ4RS6Dl1OzcN?=
 =?us-ascii?Q?kW2HrXYkBjolFz9vRbk0vrjRkamjwfy1exwWY74G341etOTkrPa0Lqjsa/J3?=
 =?us-ascii?Q?2K+1jCh5IgcCcdIudJHQ194JKouAivLk1ghkcM1fS6DXiOZhIHyUSXjrvFrR?=
 =?us-ascii?Q?p+LCSqdpSKnb5YBGwHlV4VBtkT/6fnXG/jpMwpu1lvzxDTRHiP52kxYawA9N?=
 =?us-ascii?Q?3YrGR3yR4H+9+bN1E6/cmB3/iw9Gh8790rHCR1tNh8n0/JQ8FU+ZEVhIKYh2?=
 =?us-ascii?Q?Fdga38b0TMeJdzF+XahOQ4YJ0ksQFrqyC0wENLkWoydNNIxqtwk0IJZBIuxZ?=
 =?us-ascii?Q?YrEqxmbDyIdbfJa0OmGzES6mJeob9HTzUNuWr+wbzgWOqGmmVslVMVhKgXf8?=
 =?us-ascii?Q?c7F6U7pI0QiNDbI8gVtllMJ+n1flrVXlE7bvRZwoFDX7C/vFFQSvqxuV0lFi?=
 =?us-ascii?Q?9FYHgDKe10zdIKLB8fO7YaAScQro7vdtntDsRT7dYKtfp4emrToYDI9gTo6U?=
 =?us-ascii?Q?HIYlLGwD+h3hjE4tuI57RIynxmiArIkel06qCkIjnqpWHczEp1jBLXuFzh3P?=
 =?us-ascii?Q?kQoEi3v+l/CFsyEZCvl934kKN4Kb/qPzrX3Tr+TXHAMjijIr5BNp9X8By3tb?=
 =?us-ascii?Q?CQaarwaYicXb6BctS8OlD1lmVECMFlNvQ/Rl7kIU3B3V?=
X-OriginatorOrg: gigadevice.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d3f673-8d05-405a-5b7e-08de17de09a3
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7813.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:59:14.8120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f84ba339-959c-4ab1-9b67-1e43414f945e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0y9hLuxtCUl4hhAJrhEr/vtjDHadhe8tgv/3cWJn672zKYHT3GBZXCGHFkRcNMrcEqeS0m7NACEGJai/ahcH1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7231
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

gd25lq256d: add SPI_NOR_4B_OPCODES to definition

gd25lb512: 1.8V 512Mbit
https://download.gigadevice.com/Datasheet/DS-01014-GD25LB512MF-Rev1.1.pdf

gd55lb01g: 1.8V 1Gbit
https://download.gigadevice.com/Datasheet/DS-01013-GD55LB01GF-Rev1.1.pdf

gd55lb02g: 1.8V 2Gbit
https://download.gigadevice.com/Datasheet/DS-01015-GD55LB02GF-Rev1.2.pdf

gd55lf01g: 1.8V 1Gbit high performance
Can send datasheet over email.

gd55lf02g: 1.8V 2Gbit high performance
Can send datasheet over email.

These parts have been tested on Xilinx ZC702 board.


Victor (1):
  MTD/SPI: Add new part numbers and modify one part number

 drivers/mtd/spi/spi-nor-ids.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.34.1

