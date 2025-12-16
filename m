Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE0FD5C0D7
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 08:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90FA18042F;
	Tue, 16 Dec 2025 09:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="mW4sJUYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03A7D805D7; Tue, 16 Dec 2025 09:23:11 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBDEF80325
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 09:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fz5kpoB7kNs71GIGbQki2gjLtG2Up78NJ+/cS3gva9jZ3vP4i7RQbjMZBKJM0J7F9VWglDP2JL+klKNvfd4y5W1FgvNRey37thqlfGRsS+qpJzqnVK9KK2ZAkDITQ4PGlqvlRFv9q76vuoccEo2Y/7GSF9yNQJZqDhtlSzdk9aukFr2R/lgjSMgQnDFAGA2A5B9lJdo7ViesLfCGrXWRgsH2vEr5qFkjvAmiZmsCq005rT8sFMZDhnOpCcOk1nmP/n4joqyYlzRXxWbuBEspWoAj37nhiOBhjzobQYf/lK57GsxxgcHLxaOidSg8M5rxPoB8JXC1H1COgjhXdJXifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvhq0koGxmu62Erc5nQTWVZKpaHrRhX+k+GehhOMt+E=;
 b=nzQj2zgNpmANY75yJyMSE5BPoqUTlrpvKK/09aCSw8Kr7kBbUBuVZ/miRdgudNyNxYsSvA7SDqsJchik046tFu7zEoqVJJFvVigZlHsyDT9BQ2PTAIJrKtyDnOVbJ/ZyO6oQEA1TC9aJpNyJtnNtmTqXudxVUz+Nt7wla2PRnXh5+ZqyBQOKXhAIUr1ZDOBnQ9j2UdQB014aybErat2U27huRrjpVmmhK+eRYt1EZ3wApkcZ1W87GbR1GbI40uyENPrJIStYtzMsuJfjXGNUc1wEsJoq7RXDywq14oOAmdgaQSPJBuEcVHH2wnUm3Js97lKo9dngbq3mErs8U18fQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvhq0koGxmu62Erc5nQTWVZKpaHrRhX+k+GehhOMt+E=;
 b=mW4sJUYi/z80KxeK0AUaU/EgT4rd51Eybpk5kqZYN0pV87GFfCAGeDRBoNb84pq5IwucwOGhvzUfRkI+vcNl0T8xpvDPEG0Oo+d5KqyRCqNoFgc5xSjZL7Ju50/j4Q4Grtjo1rAiBImJhhKXwmj6sryaKedZDSVrctM9xA/1wZbPAbGDat+gJAe/TGpzbHszEGiiG6e1c/CbzmD8cwp9ThaonVEiLqjvX17TB6xUVZbIkHtETbgEDloZEKZDPjGY1Ikr8DeayJAjbXlZMnwTZMdA5lrf5RE/eyj3vn5L3Z38zb95jgAz1MYEql6DPxJyw3jDP5uh9Lh9Auo966Jjvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA3PR03MB7256.namprd03.prod.outlook.com (2603:10b6:806:300::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 08:23:06 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 08:23:06 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1] ddr: altera: arria10: Fix incorrect address for mpu1
Date: Tue, 16 Dec 2025 00:21:57 -0800
Message-ID: <20251216082157.15475-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::12) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA3PR03MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed76a05-e6af-4350-1628-08de3c7c5692
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3tVSqzO+cQfpABPnwwsEVvOZSrVzDhQjN7xCyBfbO3g+tT/eFTafB227VUZx?=
 =?us-ascii?Q?eZb1eQP7Lh13tAkzK85D0RUq0VPeH4Fc0P6PbI7A6mlnfGiSRcpgzGa60Fpt?=
 =?us-ascii?Q?MeeYDDrRXqS2u3l7Z4WmuWJLIl9Fpp8TC9LLTdzxKnlq7nLSnqfhIN231snh?=
 =?us-ascii?Q?6LjA6V2lRkEM8nGqCXmsEuvtowfJ8ZCFYR2BxkZ/ICnMInvHTwlbr3URsejc?=
 =?us-ascii?Q?c2OmC9t4QkId9m1ayW52Pwra3OF3UJ/kglgasWa0sUjvPSpT78cBuRRX5QTN?=
 =?us-ascii?Q?omXjvgE27EJ5vcoUCaASAoFN+Ks+p8cO0JZac+ZVbLHs6BnBAJEz3eVMbrXf?=
 =?us-ascii?Q?+stQaUc7IdwJCQI4viuKOVJF8Z0t6c71Ce1CTxp/UR0aKHlb46ObMhu9TuPm?=
 =?us-ascii?Q?3DFFKiVSsFKg7ktWxUGIlPYU5kUAp036fz0oBOZL1KrXN0qRHode7okMlY2f?=
 =?us-ascii?Q?djAzl9TISEXCaCfy0ukIUc3ytlpvAfPX6kn82dYFNClKGcT2W5q/0u+oQ3ha?=
 =?us-ascii?Q?+J8E7N5IKasE14VVhISeuyidLCw8C9B/g+J56FGC57cWulZc4CiA2PGxH2PI?=
 =?us-ascii?Q?30un85kylZfyzcJQcy5R5+Xmf6t5mcRK8C8e+8Gd9RFPM4ETizV4HhrWfEIG?=
 =?us-ascii?Q?mepfdqnirESMOr/EP/Gbbfm7fzktgjACkz8X0iKziOb8X4PpvZnbrra7Xy/2?=
 =?us-ascii?Q?2Uw706XBTaMkOe0oP8NljulnyvqdSLaUarD9uqvCa6A/gZMv6UkQzevntsn9?=
 =?us-ascii?Q?L9NBV4HoIvunr/+TCkFtdsO7x9TjP7ZOT1JrNH8cpl/JnRNyHNVHnl8hGk10?=
 =?us-ascii?Q?vEkD8PyCuWL74wz+7amEXpiNSlvakWX4Fl6BDcV0oYJGDQIoGBFqJ/XCCR3I?=
 =?us-ascii?Q?anSdXg2CTFVQHqM6OuV5W5KzrEIO/mR/d38rfi7UU4k5m1wlJmCg9kzXLcNJ?=
 =?us-ascii?Q?3MpR4ZlCFobDYOXYYE1vYVU/Yu78jdLzXk31tWewuLXZB43Ubtf33ohjyLl2?=
 =?us-ascii?Q?dQgbCgWBInmlTpyhn2BHMljpM1a+0qKfUVFDSyNGtoUU2C9lebnf0QHMmpV0?=
 =?us-ascii?Q?qtmFqqxWOTaZOqmS33i3u3pI9A5heRoPZKaROPCnNZCXNSPyyVGTL20RaP4n?=
 =?us-ascii?Q?xu7VmHJYMBijnHgwVghujthaaeM6X/YdN0T5zRZ7UG9fzKk6BnH29FgGqYmc?=
 =?us-ascii?Q?gD0NBiUFMZLfcwApRIiQcjBEjSl3kqSY/+9v6sABXADLU7jgPrNYyRCexKpA?=
 =?us-ascii?Q?sXJ4OgEFO7iDuV0Wv3DVyAhBDSmwHn8+oPPS2QiuHtR2tu+x2P9fJAvIF0h8?=
 =?us-ascii?Q?DSXKvwKDTN0L5s6VQgfyYVM56AmZmu328dqlKBsWdEZNaRAqsL/zPWnW/fdY?=
 =?us-ascii?Q?7mMYoSAR7/NtYVb+KXx0i7lzF6ez3eJNF2x4pkDLMLaDzz+Cj44OXyi0RYP1?=
 =?us-ascii?Q?fcQu1Sa7iIfuQXuRwX+BfIUUgQWpi+MO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SrnlTRZinvnWasyfgt3VIntwnioUGUXhKlO1EHyX0ISexoJH47an77ZKXBwX?=
 =?us-ascii?Q?3h+oyUmGgcPfiCyEOcyFzcG2343ZU45WAx8yGRBzmyswi2xsXwq2f7hZVFVJ?=
 =?us-ascii?Q?67+wmmDaWfAGxY5RxZIDhmPtM7aZLelcvTVbMm0Nf2cFYiBODKQcCaKiOC0K?=
 =?us-ascii?Q?KIwdoHoFgp1sWKDr4YZFGRI9xPjoNgwvmQRCDwn25a6HbYznWDn4QAZBDXJw?=
 =?us-ascii?Q?HTckw/Je12kJNpe6FykGQarEK+sfiG318HTuwBX2QrPfpl5tI98V/2LXVn9g?=
 =?us-ascii?Q?r5ouPHFNV8/OrAU5WZi+CjQOO07xFWl6ND/3c07LrrdUO5ugtPmNljGzmZ5O?=
 =?us-ascii?Q?piu9qsuFPUPOkJXvP3fJkPQxpuWbZYKXgr/ZeBjnI+39SstDkfu/3WkJyLOC?=
 =?us-ascii?Q?SyQFzOgBbAbBvKrINnAWFmyCF0g7kerVnknijXCeDvObplCphR+SCW+OGg9C?=
 =?us-ascii?Q?JAkFEqNQx8mR6f2bc/yr+v6LbzbxbTJMhmmre1NafoiQovkfSrc/JkT1UmXt?=
 =?us-ascii?Q?BQ2t6PDe4ceumOHDa3oBCjGFaBZsrHZyUexKPw2Xa6kUAMn5i6hXN36q69uo?=
 =?us-ascii?Q?XLnJm/3pEqrOcwCjunRYG/x+NkGw2mlRkNHKIdcNe7lsEjTsM0/5PkBbjnjB?=
 =?us-ascii?Q?eDVPRkUsP4HmZaFjqNWsi7As7FdZO51+Wa83VNmlAMvH0hCJDxcDsFkFOSUn?=
 =?us-ascii?Q?puDaEpAT1N5rzLSFWKDc0IRoTxQOR0ttp4zGpeLUaRWy2GaaNSxcmXVQdwqz?=
 =?us-ascii?Q?T3mymGWQMO3FHjHeTpr0LlbgKN46XyomRukMXW+OlVg5wxpjLnC2lJ661npC?=
 =?us-ascii?Q?ApJRUgEFGH+rv7aT8UubsE7tHiPtGXYOhE4i8CBiQQonFggIbvmMP/bhrNGd?=
 =?us-ascii?Q?Yb/ox4jl4+ado0WJtbrNc/vV6GTgGsq0/W3YC5lD2dRqM3NtD9oa+zl3C7gd?=
 =?us-ascii?Q?7LUOoRSbIpyTw+po5x2CRKO74U+DuUKZaxHuZTJez8DgIrQ9XFCyoz1nbBya?=
 =?us-ascii?Q?QyNlkOUJ+HA+yPyt+zK4LrxsIVule1BrCFxabS1+nOLVbIRpEVNA803Gkju2?=
 =?us-ascii?Q?Ax5VFDw4dnm2yOLE9uwuzFG84W+vouB65chRHCWgaX8pmKxlqtYf2n7o6Zco?=
 =?us-ascii?Q?kMped0ZxjtlqGPQwJvygKBxn4GEgjOdIl2qXibzLg/QqZPOfQTKq0x+06mTc?=
 =?us-ascii?Q?foGqquVCb54ARpZ/kY69/cJ0pOJ6BpW2bM06zlHZcmYzngiEXsFZomP7tOQR?=
 =?us-ascii?Q?xzKGcYRspLjTBMZH+XmlMD1/OU2iqNmhCE6jjyjHfIMGQOxvCJNN20kcNmnk?=
 =?us-ascii?Q?va+GPP7TMUl1//fjaubhKYNlsjRosRHfdZ4NAORTaJCrQyPqG5UuLC0c9lTH?=
 =?us-ascii?Q?KT9A+DYdIFP+3fEFkvrRRwjSDAZ4huTAMo0lvWY3f8vYYibtC2zJi/2por58?=
 =?us-ascii?Q?zSblz8lF0bab7gbWNPOqCRDTiYvY2l9wiWjqHy8y2XBDO+HyIi65xWtJrG0c?=
 =?us-ascii?Q?u2g8daR5hSfduDSMVHEMpbOI9JBzRUrVnhemB7TbBXxedGMld5k2ONOxFVPd?=
 =?us-ascii?Q?C+BJk2Psc1acDcjaVE/1tUQPEmQwt4n5D78ESm9I6rsgp02Stu94LfRjoYcH?=
 =?us-ascii?Q?jlsuBpFk3qb0IwIAyP3neg5bLkPXJhPhEfgjXAni/4kLCcC7x6yaGM2a4JAI?=
 =?us-ascii?Q?MM7J1gR4FUiPmLEZRgObco9Xd2dCrt0m+wxK9H0YlXwL8FxRH9rNjJpf/3Yt?=
 =?us-ascii?Q?J0GbS46tgFRvLrBMmpnVrESHYJ/lmXE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed76a05-e6af-4350-1628-08de3c7c5692
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:23:06.1039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qyuo/VXtGFzAhWx46d9WJglGGL3ZHmYw9cYzPiXohtYbS2hCdslcPsfSRyC1gPL4LT50IHSHtR0JCgr87g0UfjkSHeQm2+GhRXyxfoBM+PM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7256
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS is already added in
SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET() macro.

Remove extra SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS in mpu1 address
computation.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/ddr/altera/sdram_arria10.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index d3305a6c82d..a4f941a2215 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -475,7 +475,6 @@ const struct firewall_entry firewall_table[] = {
 	},
 	{
 		"mpu1",
-		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS +
 		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET(mpuregion1addr),
 		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET(enable),
 		ALT_NOC_FW_DDR_SCR_EN_MPUREG1EN_SET_MSK
-- 
2.43.7

