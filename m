Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B6E1048922
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 01:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B651F83F14;
	Sat, 28 Feb 2026 02:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NUmdHuhi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B99C883F14; Sat, 28 Feb 2026 02:43:22 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8197183A1B
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 02:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1Jdp7hWXreEez/gU63DbtusqsiAIxOzkI8VrAuO7wsvzKpAe6kfh5kpr+6mv0QP+kh0Qlfwqqxp4w/jpOGaRY8Iqa5hL43mrOwQfwOah7ufHyTVfxb9f1u+FgHHsTU/elCwjlUI+NJ5SVP9W4tM4vXsKUO20UXeG6UfSSZ0au/iYVrNccNlsdgyTT991fZDjW6tpNxE9V8FHQxjwrCAaDxdoVwmOSnpk2zyIiB6l+16kr5g6trGUsdNCsdCE15n7opBQ7cqYu1EQAbexSLsFrjOCJgoApy1HuhrFqbhtbY1x6PHuvd5tRVh8bp7xQbfWBFTmeKKG3jmB9EVrR7dQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kvssIqfh/RQXbbzNRHHMCNgVlcHOIILKb6cYYBZ1Ic=;
 b=Bd7HaqC+DD0OxhyyNGr9Xxz/kPZH47NEPdrssG4Bnxf348U6tauA5Ldm10TLkkTCBnIK4fsFSK2lfHtbQS4j5R7WowC7ckmn+Lh+UbsbkDNpv+cwWnJ0K7p1QU5MY8FeJfhIxGw/VF6vaY8foZ11A39vqPdELA9TnQKkzJXD2/ZT5G50QQHc2Q1E6q0bUPOJ3GzjsG9LsAWHJ6mf+14PCTBd9jaEKoJGSl7T38mwgnSXaYEPkYTGIiI7kRox6HHbjTrbG21+aMPnGGXa4t17aSGlbqVjuM45mXoUX1yM0cDO0Pdvt6H4Ey3SnsNcAlQ3kUdov8TxEByjLeOWOUBR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kvssIqfh/RQXbbzNRHHMCNgVlcHOIILKb6cYYBZ1Ic=;
 b=NUmdHuhiWXqJK6fJ6bD/KPw3YYQ0pAoQx115YqpVb//4ook8gI6cuO1xz+Rq5DU/qmQVBzkNNVoiMMFU1nSOVebZ+i3RuGG7VfsStpogezedr2VwO4Ho6vFLO6CLV9gOVpPj5G9prsK7mJiM2vMsjr1vbRFzgDS/DaxwfhnXjYJNH68r21AK6mxJ9o8FPAd37p5jMP2+eTswctq9tmEp31fbhm56THAMhxouFbosmBm0EMFPq4CSHPkIsZNi4VVmvR+1+Qky7GdPxKvSPZhpduW9pVH5AnM5kEg69C0gT8mGAL+nzPmOKtkhbXmBUcv84UWrdICtVH4IQTp9/uDUTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by MI3PR04MB12440.eurprd04.prod.outlook.com (2603:10a6:290:75::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 01:43:18 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:43:18 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 28 Feb 2026 08:22:23 +0800
Subject: [PATCH v2 05/13] imx: ele_ahab: Add i.MX952 support to
 display_life_cycle()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-imx952-v1-5-0a360e7e8cb7@nxp.com>
References: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
In-Reply-To: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jacky Bai <ping.bai@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Jindong Yue <jindong.yue@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|MI3PR04MB12440:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e96aa3-d815-4cd6-388e-08de766abf62
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: wJnFtl1HQOnsuRstuhFgXXUxe3kwLJZt3Jo+zPAojME71do6sP03km4SRs4da6OUQ1kZWk7AB++yjaLFs3UWeDLFMHT+GP1AdwVKbFVUh5r8MVPWoA3XkMBSOHItCq+yojfGQkXq0DDDlzVDxoDpfdsOFDFjRrjuVY0+tRX2aJjA9iCjFvBuPCtv0fKaUdbV8GPav2MeRBf+92COjmFiqKMT//tCW+uDtkyy/99/0SD3zPv6npJMbiyDEkhLXzc3tmmSJhkK9sBlDdMxUfn8lBExrN9MG10graUJ1KecC0KQkY0rVYgSM8ciI3V7cp91krEqUZ5Qd9N+ly9/W+BjHOkOIpUrAe4qYAY5IrlOUrCy1AAiS9FAf0dMdUFnK+h9SYdRHpYoBDlDadWcd26RRrmi53ELxNCRLcLTpCy0BeRkwGc/Xoy4WXC6WA4W3ukd3xsU8l6MDkfVcfve3CAKEbXuOOn61oWZX5AtimpYgFFd8qZ4K9Q5FoJKGWLgRAyi5kyGxcbgWfDZouS1rAURBa5o20eLtPuOb4xmeFHjsHPxBlZdUvwYss0GmgOGzBl+cWBZiGi+1fOBXXJKflYyUJHdDm79MZJWZ9Ftx4eygJX/MbuWnW1WeleHkCSXGq4NnYC2GePkEGntcD/aNa0UqXiCFRWHzg7FJ/1juQrYAz2VKYOWzK1smAAlhkcca+9kh3iD8vGqqiscq/WRcC2julhekJPRrE9t5XWZ1GMJYuHqsNFC0/rUVZmdXmi/V66drylygR0qnyW4E6rhJfMagH7r99i5MmbctCgkuXA0vBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHdpelZQdE9QcEt1NEprMDFYeGZONFJhSDlVMi95c0c0dDhja0d2SlB0RUFS?=
 =?utf-8?B?c3VhYUFnV1pTWm1nSlVNb2FjaUtseld2QVpIaTZLTzdKL0NCNVNzK1NqZHpV?=
 =?utf-8?B?MERKc3BWVm50OC84R0ZkM2pYYVlzV21FaVV2dHBmSUFDbGRJM1kvOVFaY3pm?=
 =?utf-8?B?ZGhNdUZGODN4Y3I4NE5Nd2kyOUtGUHZCaDBab3lTdzRwaXJBa2x1Yi9qOWlq?=
 =?utf-8?B?S0dpWkJGd29hK2pNUXEwWG1EOFZKQUhkMnZmV3htdE9sNkQxNXZ3WU9hQWFM?=
 =?utf-8?B?b2Y2NjdsaWd3dTlaWTJYNmJFdW9pc20rcTV3Z3k3L2doOTg5bm1URHFETGpI?=
 =?utf-8?B?KzNObSt1MklUbGxsZGFZcUtvY3lqSVRkNDFETmhxZnRLR0tUdGlOeHNpb2RG?=
 =?utf-8?B?ZlF0RkZoQ1ZDaWRKSVZpNTJpMER3VXZUSnk5Vm5ZanNPYXFSb1E4MVhOTEU5?=
 =?utf-8?B?cnAwZEhuQVN3Q2FTM3N4bDhLQWlya1Rwc2hnYlllMDZRWGhKNlkrcS9XKzhs?=
 =?utf-8?B?ZlkwOXBYVVlucjUvdFF5SHJMN0xPcHA2U0JpdjBuZk1DbGhIOFMyOFl5RGNK?=
 =?utf-8?B?bUk1emdmeHd2MGd1UE9ER2ZCMXVzY1B0cUNhVUtqRnNCb0F6aXJ1R1pFcE9I?=
 =?utf-8?B?MUN1ancwTEUzV1pNazlGeGNnNElqM1FjMG5nclNWN2xwbVRQMGZESStmdlpu?=
 =?utf-8?B?czNYaHpWRGRSK29HNDhzaU9YdkxibWMxeEg3c014dnJWZHBOUTBsWkh5dGU3?=
 =?utf-8?B?aFp0bHJkQWJqYU13aWNtQmNXTVoyaEQ0OFV1RUtiTmxQTTVuS3MrZnJqdzRI?=
 =?utf-8?B?RWdBRHhiM0FYS2REQmpxRzJFT2hFcE9GRmdlYnRVRW1qdFBlcDR1OVZKTjZz?=
 =?utf-8?B?TTIwNnorclJsQWZPTm5ocmZFMmliZUlIQnpyYzJhczJYUUdUVy9RS04vZzN0?=
 =?utf-8?B?MlllU015SDZqdDUwY1drZW8zYXc3ZWFTQ1RxRklMdHl5TU1FR0xFc3MybDM5?=
 =?utf-8?B?ZDhSb1RRcHZzWU80QzVQVjMvWU44VkVud0c0cWE3SVhBSGFzWE5TSFA2Qjd3?=
 =?utf-8?B?YW1PeCtaVVZUZ280Sy8wZzNweGNOZkpJQUFrQ3o4N2lSR1cwWTQzWVpQRXd6?=
 =?utf-8?B?OFd6UTRrcmZDMDJ0Z1YzaWNJOFhsZHNHQm1CVW81ZDhZb3pCdUI5OTRsa3Y4?=
 =?utf-8?B?VG42SDdxQ1JzaFd3Umk0V0ZQZzErK0lTMzR4dFFjbzNkUE5taUpveXQ3bE0v?=
 =?utf-8?B?RDQ2d3NlMFhaOG0wV0NiQXhtNFJycFU1RENkZFRlUm9QVllIeW94aDJPY3o0?=
 =?utf-8?B?eTlmTUlHS0hwVUJiMitnc2FRSjZJSUxpeGtmYjhaWFB1cmhRUnhzWWl4MDJk?=
 =?utf-8?B?WVFDN2NuYkJ0bnpOZ2VqL2ZnWitBMnhOOEhvN01BZk15d0hmSXdqc2c5SkVV?=
 =?utf-8?B?Tmp4cGw0aTRJVXI5UnRXd1RjNzU4eU9KUDNsZWYxQWVaUWhwc1RsNWNVUHVR?=
 =?utf-8?B?Zi9mcml3Q1k5NlV2MHU2QTFuNnMxd1YzWVR4emFSYnNLYURuT2dMWU1HNW1I?=
 =?utf-8?B?bDJxQXhrSUVhZGlNUGQ4Y280TVk0emtxbkF1UkpuelUzNlBkeFlJcFNrMi8y?=
 =?utf-8?B?V3BTMlphSTJaY3A2alJ0bmQ3Z3VSVzcxRVNwTUxsSy9nME1qa2cwVll3MFFw?=
 =?utf-8?B?ZjdoOWhLNHFvZ2V4MVNadG1rdU1yVlFWZVRUQnQzdUVGVlEvcWRaTmUzTUl4?=
 =?utf-8?B?MUQrUjUwdGZUYVlJUWxNaDVlVFphZW04dTVHL3ZuS0pONm9LN3o3Mm81NzRK?=
 =?utf-8?B?N2V3aWNiZlg2K05NVUVHYmNyQ0dybTdEajhPTm5qUFRnRTY0N3Urb1FHcm9v?=
 =?utf-8?B?S2lUeHpDS3BkNFRTeUJTM205ZTVaMTFsNTF5cjBrZm0xOHdFOS9WakZhSWsv?=
 =?utf-8?B?Z2I3akNhUTNRelpvOEkxMEoxM3k5UnRzNzVYK0dzWW5Yc0pkNlhGOHFCUkRZ?=
 =?utf-8?B?VnphWGhEVEhPVkc3SEVMVG5jUytWRmhpaytLQ0FveW9WWXJXS09CbVEvU3o0?=
 =?utf-8?B?S1lCbVpEancxVkp6azJXOWcyd2E0cXZaRmZSZE9ZMnQ4VGljcmRYaVJqOWZB?=
 =?utf-8?B?LytJSENNdm54YUFzT1FJdjY5ZlRnZzlSaGl5SElQYlNPU3hQS1JVbDBaTEhF?=
 =?utf-8?B?d3lEbFFOL3dwbG00RTVFcVk0YytvSlR5aXl2V2NYRVBERG4wYXpJckIxMVhL?=
 =?utf-8?B?elpkMTFDY0QzSnlJYTlpS2pEY2ZIOWdoUjlNRVFGYm9zaWVZa3g2NlJEUmFv?=
 =?utf-8?B?K2RHQ0VVZ0RBekV3ZElMa3hxSnI5OGdaWVV5QXhCTWtsNkc1cGlFdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e96aa3-d815-4cd6-388e-08de766abf62
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:43:18.4537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzOPBtvniPgJkpq6cvNi82a2QVgA0Yx68CAE/52YBwQ1yDOBa66Sy8DMwFW30HjF7/A1F5SA/UZkiqxj5OjXZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12440
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

From: Alice Guo <alice.guo@nxp.com>

Extend display_life_cycle() to support i.MX952.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/ele_ahab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 4d4620dcafd..9794391fb35 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -412,7 +412,7 @@ static int do_authenticate(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
-#if IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94)
+#if IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94) || IS_ENABLED(CONFIG_IMX952)
 #define FSB_LC_OFFSET 0x414
 #define LC_OEM_OPEN 0x10
 static void display_life_cycle(u32 lc)

-- 
2.43.0

