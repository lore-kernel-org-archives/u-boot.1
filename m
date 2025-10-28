Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1DCCCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 13:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47B128384E;
	Tue, 28 Oct 2025 14:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cAe5KZU5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4FC283A13; Tue, 28 Oct 2025 11:48:14 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B817B83A43
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 11:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgccOMUVDqSpTjOMpyfhCr/pjO9Wrz6I23JvbFKBxIamV6cnoxMEN3PWyYTfZcCyHFqWa0Jy0uxW6gGwV8LCUEeT+LLdF1JdXq8ow+L98/6kCE5uqm4ajbHA2ZfesR+b/6YkEnLJIZXmq7zRi2h97PJxh0qcYyhgwL1wrYr/uYzLy+lVn2UNhllSi3RUgu6D56mAJyiki2EV/521dZso7WfHG8k09f6ynPduL3gXnCEeGwbSkeMobaav67tEb4F+BWYGqfIEh/ECsC8+5tnVc+yi7YlXaWDr4ZDCI5XWdmwMJpuN8SCISCmk7Nz1riNxm3TV6wMzhP4brHRQRPa+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb77hfCJ0iXwNvm7KCV/BbiKDKUTwzRAqTWujepn6eE=;
 b=l6s3Dv6QBSZXNaxYJimAdjcxgghsU4FmSVDs2Tpdby6ifrMezpUDCnmP4Sdw9RB3S+kvPtjYIjwqN8l2cObF0YRjAaoRtZUKExscEVe6wsLecDh6cUUNoped1vvBivNXQAjz2qHl8t3VbtL5kws/zihlM8BankjxxAEvgiaqS9HG1Uze8S3qKqP6T6gwcEAWAkee0jwbBUB3acpJN+qgzdgwKU+DXIGpjY3pHvV3yzD+XdbFRXv+iZUX0kCiT/PpPKQHpfIMdwWg9LcvowBUGo2PeP87G/ghz04XWcXZQGficRgUbnAorAaPBo3uQFJKjk/bbkKNzS58r7KmIET6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb77hfCJ0iXwNvm7KCV/BbiKDKUTwzRAqTWujepn6eE=;
 b=cAe5KZU58gGnerJHn1PwsxVIgJ2Zfu+e2BAlBoV6kc0Yryv6bCmiZlj74NOqB79nmxaO7k4tVVmL99JWP+EIsKOisXqJ8wI1zbVhdbmDZX8mcfed0hrDWjSXZGvz8xZZLs3jISe6UHKCDv6x3yZ2ZZM/wb5LQsRXPgkuRoWWenuSCcPqusz0xxPepDyG8uh/ecMtX9YW5t+KPBcRPK60ZT3VkjIo1lfEjm0TM/iU+Sg7hLOQ/DgRGvOrHTdm965GPHLu0tU+IfVwFs23y+n7T9V+JSu8N5HtquSoAv/IXvnfjDEp1OWMLSe6MWwncl31+giNBmAM4BD1Cz7A7ex/4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7575.eurprd04.prod.outlook.com (2603:10a6:20b:29c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 10:48:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 10:48:10 +0000
Date: Tue, 28 Oct 2025 20:00:34 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: Re: [PATCH 2/4] clk: scmi: Factor out clock control flags resolution
Message-ID: <20251028120034.GC9371@nxa18884-linux.ap.freescale.net>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
 <20251028034225.260469-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028034225.260469-2-marek.vasut+renesas@mailbox.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR03CA0095.apcprd03.prod.outlook.com
 (2603:1096:4:7c::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e31ae8a-74b8-4e86-a430-08de160f7cb0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vA03XnkT1HZOJ+UE4gkNk8DqC59vWAGjHwBKnfYSIOrh4CZmps8Xcl/X4O4k?=
 =?us-ascii?Q?gBrNWBO2ATMgt3aDIdYMOSzhDu3Ma5KmKyp5h/wMZUnEEVE9hFpwRZ6uD+nw?=
 =?us-ascii?Q?RAstf2CMGAGLGb90v9XGXpFv3YFJFrMy5R6qmqxElytMdB9dn14v0rQZcN6C?=
 =?us-ascii?Q?ksAO+vT4dd/zTqmuoEmpe6u1sTROmOf2BfRKAnlQw5zEEFpOhBSFOEqXlIyS?=
 =?us-ascii?Q?QMOUyeB3c6lLtV1iHO9tSzEBFVbiIHKP2DYDI1cnfWfFV+5wiSPzK2jz7RLK?=
 =?us-ascii?Q?z6ikvsLoD1yhb3aLyohaVqnBr1F4uyQYgp6jpLxPcY/ytDocVCQR9XI8d4CF?=
 =?us-ascii?Q?TeBeqr0XBMuTq1+2Kp4YTFU1ZoUUky69IgE6Z0anu6lozjB4GBnz1LNf7Pml?=
 =?us-ascii?Q?aE5oYDtQp3sMvqFBmXcQXNt69wHzSLMxQoXXFZj3GOqcjNP96eg2qACLT3ES?=
 =?us-ascii?Q?J6U1JReYkQFECsEkK6o4nz664iI1uqAuUViEl80ZpwGD5n69DESjWee4CN6k?=
 =?us-ascii?Q?nf90YdAIWTlMxoOACPQsELAwCb4m98XGQE/kPBg7yXk0n4VVceu0ioQ9F4ca?=
 =?us-ascii?Q?cD1byqNVzlC+vFJ56oWUueGFMkIy8CHp1Z6/5DvQEmBwkRIhqE2nxHjwhPbc?=
 =?us-ascii?Q?9loUGWXuD0sMJDg2dl2ILb9rBl8w96N/tePOMhVSogPgafv0bmE29iij62oZ?=
 =?us-ascii?Q?L5b4Zr82a7RaA7Hk3KQlCBU/ErXip20dnXee6xVLSoLFVlyNtx29GeYM3cGi?=
 =?us-ascii?Q?Hd1kUKWhfbskqdeBf+V3woKodgRE4SzziPvmFjcUKSuAMdGeuNAURcO2n8Cw?=
 =?us-ascii?Q?+jVYhYpyT6BfV+yHqAYPD7Z4Pd7K/+vd+XmBbOTTsAlOxkGsRoxfFffs4UJ2?=
 =?us-ascii?Q?/WGospniLDLIA7QCNZLwouGDedUx32F5dDMfzHpTfY+o2wfJoE3bkGS6fkMZ?=
 =?us-ascii?Q?B26NQk+lPVb2eXCu1kUWcV4KxeChzauk5XGMgmCkfbEBXqEzXYYktG7bIWFT?=
 =?us-ascii?Q?mVNJZYNTLTwu7p0TuxJcKBhDKRgoA+l35MrEFQUBJzBAjd6rm10qqxz6XoB5?=
 =?us-ascii?Q?ggjLGi25FBIHhfyv78OBMGCSoXnA9J/lVcHOUIGE/3YPREVpnaSlQ2fF/RB0?=
 =?us-ascii?Q?pcjaG07Tav9huwZLqYlA1S5GzEBDQv8iEaJshFv23fC4vjiEG0TCEJlyY3u9?=
 =?us-ascii?Q?rZCJD9j3DIlv3lLIJdWxtJ/MzeF1k1u3w0StOEqCjcqPxE0OCNlatVFqfDwN?=
 =?us-ascii?Q?0chJU7YHFej3J8qUmsccII/UXzp0DxcXWmpNTDRxiHgkCnovET3VDsfOtqP4?=
 =?us-ascii?Q?3xPCmvrI1cgCHxnPdKUQbBuz0Fvdb4CknV2U7UsT1y3qBLsVk3eoAEIad2jJ?=
 =?us-ascii?Q?5Mp8JUMNy7sTKlLTF5BYeQgmuJSP6ogJQXUqbUgenfApS+SThhLXXc7B4DB+?=
 =?us-ascii?Q?HYTFaY+NdEJoGcKGwgMhT/Rl76uyC3iGG2Nuk1TF+uYn1bSphB8xw7sL8cPe?=
 =?us-ascii?Q?fIYkEqPTsHUHkTn3Sopi0ZXoyigdN8ZB54sV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ej+bIEDFeyfdCS9PaYW2BYfkUKcD3CUiVP14Zwa+44Yjtx8OU9H4FbIxJd6/?=
 =?us-ascii?Q?0fPA06KAZ6VrzPdyNnblLJRPNo6JY2MjNBJnWGy3jmCw5yCoE0zH6fq/GJhS?=
 =?us-ascii?Q?pFx1P13CpKpffqeezDYiySpsjrdJTjU5jthZ5PbwOdP1LVOYwUBfbpA5LaHb?=
 =?us-ascii?Q?I9YSoEvKARAodpqUvKRxb67o/AZI+M5PCkkdILW/UHyOUU21qEt+/9RaOc5D?=
 =?us-ascii?Q?NAIO3sygGdilqv84lOO1PNF/pxDdmxaqhKa7Vpxi4SPO6wxDcz1o9PAtj5ZQ?=
 =?us-ascii?Q?NHeRbpocDmHbMX1giAaxYGpMD6FWQTWcyGAsNDKB6//JiJSnGztvAojD9Z4P?=
 =?us-ascii?Q?y9OF7Xo1L/Eag47HBHx5YeQ/MRLJsxZ7yNiumXxypP5WqTsTuXsUUWIg6uZb?=
 =?us-ascii?Q?kJw1hX2DBaKf1yPpNR0HcNJxzA8446nhS0KaKqcutkdeu9gIPGKOIMXUjEtP?=
 =?us-ascii?Q?8jXeXiL0EiZjEmPnzDCLflg4LnSBRyYSiq+xOYPOXgTM5MVMr65F2YHJOkbZ?=
 =?us-ascii?Q?akoFP5jJvvtmfVPU5+kgvc9JEUUp9r++lbuDu/MAyDxKieO9eEtDwwN79ElL?=
 =?us-ascii?Q?uvXX0cp1mOxjz3mA/9sYLb9QjNowYduA/mf1S5v0QGW+QGpHOCq9v5px32hh?=
 =?us-ascii?Q?zwzgeRybu/MCnZsBJnxmuHfPF2/hchm2ioX+5YI74r4wse/VugD35BjQoNc8?=
 =?us-ascii?Q?9wTxwd5romjK6TYW5CmcFRl5xP2AYu3aI2Sa7YEsYjngOUSiyd3p7YjmGbZL?=
 =?us-ascii?Q?lEZBOJ0Yt7EjAoWHo+E01n5imzK3pCIAp5Jry1wM6uLHrFk5vT3sbsd5neKF?=
 =?us-ascii?Q?BN/xvFOpgBFk6AEiNC4ui0KNGyPyZ5W3LJ9JFUDjukM6pBu3W8WPoBX3t2NW?=
 =?us-ascii?Q?q8FhjOjyETGEvdqLTJYp+aIFA6YR2upeUN4cRuP9nu4pXTzmKsQgYdIynlYD?=
 =?us-ascii?Q?WzF04RkS5BCQxlk/cOgjNhcoDOUXfRYP9XJeYzsHzkd4rWFubqaM2nNh0WuK?=
 =?us-ascii?Q?AXd4aeSc7qiFTJ9Atp5BpsdFj3alb5IuUKhLnymUmyonQCpqGy/ckOTfWxQF?=
 =?us-ascii?Q?cmpEowV9SO5sjIGfuZjrzNdqRTLUPyrVoljZQxudOeBYEyZcKRcrgkAf+YE8?=
 =?us-ascii?Q?OInZbmKyEZXvXD6idfz819vnJwyfi49hkXtoz1g2L8oO9txJyysjyKxruHXi?=
 =?us-ascii?Q?fGGkfsSbsxBAp2yxTlqN4h2hpyjnpM3VhuIjdnxWt7JETB9TJPhfXcyFx+XS?=
 =?us-ascii?Q?Cr3QJJYLAePY/p5SMFaUErKxQ2yLRq3Uhz6VWJW2/xNLP+GOPuvTCS69xJ+u?=
 =?us-ascii?Q?bk44W+zijHN0JG3MO3rWlHA1xGWKSH0jl6hQQ6nJ/ugwYiFzVXpDDGENinF4?=
 =?us-ascii?Q?dBcAEKlOy0fBAmu/f2RPcFl9hkXOILz1wVn5LEBjt6zZ8ZVme9EOCQlbZq6M?=
 =?us-ascii?Q?o445HikIqR2LCcRioZeflO7CW8/CbA36vBJXn7rfAZoHjQnm/vvQQljpvvbV?=
 =?us-ascii?Q?o2yE0JRf71yZUfeylxkQiqaP7KeId3YNLGUUEicOaiHM4QFdlm2Fkt522wm7?=
 =?us-ascii?Q?gLPrUBZLoyCRnxKqfRnJc553KxksPgSlDIOR4MA1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e31ae8a-74b8-4e86-a430-08de160f7cb0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 10:48:10.7192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rR2SUei9grMjME4dD3PXl1u5U5CPXxwGkf2I9eAk7X6r+gWsSU4GqOV1GuvU39itqB61e5OumjZqIdpB9G7KCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7575
X-Mailman-Approved-At: Tue, 28 Oct 2025 14:10:51 +0100
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

On Tue, Oct 28, 2025 at 04:41:04AM +0100, Marek Vasut wrote:
>Pull clock control flags resolution into dedicated function and
>call it from each site that does access clock control flags. No
>functional change.
>
>This is a preparatory patch for deferred issue of SCMI_CLOCK_ATTRIBUTES.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
