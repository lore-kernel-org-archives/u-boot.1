Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FEDC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 21:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77FEC8872F;
	Wed, 10 Jul 2024 23:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ec1NVRB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C646A88717; Wed, 10 Jul 2024 23:17:37 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D02998872E
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 23:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/ZdzP2lQnySj+BOmgCRaS9QP2ycC1vsKeKqwLP7mbvxHhKlzrkkJqliNb4siqC1Af/t97mT7BqTBPbzdjDzFoPGQBXlrDGkzoZFFCdPZ8Nw8xNfKhTk+lQSeyreicJ1ZM5upfUsQKfbcyvLeNrjTwoPKIq40NznCAfr5X0/wHLqY/fTJ2Mg97qu/7MpeV5mZAvLQg1B9rwcno3MtIveydPTmM6AgBB5E4Ds6wTA9Re3iny6FWqay9lMs77ILzBklTS+rv06Itck+oTSqlinGVNDIc3IuXmbhiJqb8Fo39XAYu3xdnmhbkl8Neb6CDCMMug1DSktXFFgMp2b4Ixw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU4cdIOrd/xtunQbnyY5jfpbf9nfiYoTz2xifPI3x/A=;
 b=kZTfaG86Zhw7P/MZii/GZ5WfLvNo6+THs/QNYgYDgG6EVsC70IGrxR7UC9ACWqGYbc0oVZMmeqAzK5mW0UQP+dQBG4/on2rdcJI6Ywga+gFWlv9HgP4iGhpaSf3W9lI/JzF92nUl7XCfjtMFRtdsHeN8XGQM3y90izX2sNjWSzkT3lochZFz9O4Vzj2wmIlJAQH/8CpsCBKCdFdTKti4gBdOK8TJfRwJjnazb6vDWS9XBDQ5mkWd13AmiFESqZ557ldF28P9qKEltVK6G37+r2vxShZQZZENrEai5nSgSiZOsJR12kVQN53mGNLHJ0LGYSABXvM3AYRuX66kLDGI4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU4cdIOrd/xtunQbnyY5jfpbf9nfiYoTz2xifPI3x/A=;
 b=ec1NVRB8nm8ohMHzHfXMHi4/JGkz0gHsJQo3Iw/HyvUqKSiL+Ztqywhgluqs15qPhuAsl7osDp2MyKrYWL0bAp9zdD9llT6ZewOCj/3fjPnonYpPL98BE1fNerFCNxqsn3PXvlzYejzjKwHnxSfI/amfiHoSEhPo+Dkl9DNMT+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB6711.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 21:17:33 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 21:17:33 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 2/2] board: rpi: remove leftover CONFIG_HW_WATCHDOG block
Date: Wed, 10 Jul 2024 23:17:30 +0200
Message-ID: <20240710211730.2635847-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710211730.2635847-1-rasmus.villemoes@prevas.dk>
References: <20240710211730.2635847-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0113.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::19) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: cae01214-4521-4880-0007-08dca125b6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xJ3xQOD9r4+3YTZUJhbkwLn/hTcoHUR1qxRXgXHi8c1irwdcxMEpUVZuQX/O?=
 =?us-ascii?Q?s94OAIJVBki2gTRDZqpz/eH4sT6tMs+L3t7xIy7gK7ye54B53RlG6A5CIwSz?=
 =?us-ascii?Q?RSDvs4nd/belSjaHpWVjuGlTQbr6aqicdJC18X7VzuSo0NVgf1cOO1kxQ7z/?=
 =?us-ascii?Q?GOTTSpe9wZwXuN7RWTSGH5nzca4J47wBVAhvPl2U4V4CaM+870UcEnleAyF0?=
 =?us-ascii?Q?JA8BNfmd2Hi4o0JAVjJnkW0tBHHLhtrXYEhsSEiTTUgOWbvCtC1uOB5X6pXr?=
 =?us-ascii?Q?50QffY6Dsd+QNR6CLbJpCHr+t7Q4/iCDnp5IL5tLDdWUOseTi0oqV1y27vAb?=
 =?us-ascii?Q?ox7/8xCmT5SJ8/1nWdjvMDPx72aSL5eeoBqWwSJAuwejvWI8VYXFeSmLpeqq?=
 =?us-ascii?Q?va5US1iZ4OxD/F5fARgcXulto3bzLbkciy+wh0zEUPPOpTgUPiLmMmgH2XNr?=
 =?us-ascii?Q?hqV/lulPFXrzHxJkhaJ0nBUfxTUw/ftv8/1dLjpPOBWIcN5dDYHMIil53nCy?=
 =?us-ascii?Q?I7h9MRMq+JB+10vK3fqICYKBX3qae7cU52bfQZmvq2Tk+Phwi6ygk9ySCZvR?=
 =?us-ascii?Q?b/qNIEt5N/wDsaU3gSnZBYn0jERgH+wSIeNbMvSlR5K0DmdSZUqQsjUFidfh?=
 =?us-ascii?Q?VJ3TnFWH2dIKB5gua7hQJRWu/tCLbQbGzrmJSf4qJwaJqM/jLMJxFNvDZKnV?=
 =?us-ascii?Q?cAp7+cr4zxbxcENo5E+6PRCSknnRu9jasXtIjrpHnrVgIcWj7GJeZlSTLB8a?=
 =?us-ascii?Q?hyLU6ghN/Y53CK2JB99Vz/9L/97HF5kWYc5YGTga+8AFs2vidN5F0ALVbOtG?=
 =?us-ascii?Q?Z9M2ToZKjeqNVF06Tud2AfUb5PV5rFaAGjrW4vXCxixGY3TRtkYcCMM+e2aK?=
 =?us-ascii?Q?tcZsdsD1IAdvKBCR40pWxU+vqfAxaZPYykuEky3N7ajwI15CVFtnDrLm6f35?=
 =?us-ascii?Q?FKPbIwsXEIG/Fnq4gBqQj8z+jzcF9tQo0kZiXpVB6KlBVX6x0FHGJo36LINd?=
 =?us-ascii?Q?8/P1YuGSP8P6a90lCKBoYH4mRKZeIN5ke19ZOEi94QC8Jb+ZnXKWhK0BOpww?=
 =?us-ascii?Q?xoWGQWVsbVdjGOVoLmDi6sodrq6chKF1TYzi6jT2MYqAIxRUZIpAMZciD3mM?=
 =?us-ascii?Q?wUBqzoqD/4H1Hw/CLO+qFLiazPhXGqxWOFWz2v34elKURKcecW0eMhGXk4zP?=
 =?us-ascii?Q?LClOOhWp/wv0TMWio3ZnGfEQjXuNQKN5ZCMGdlz8JdDevNil1i3V1ySP+iIp?=
 =?us-ascii?Q?b7cakU1MeEPsdPeYrufQiwCVOpa/dv73FE+7lGP4ztoxDn/4YjSMtbGLLmYl?=
 =?us-ascii?Q?gSXB4epGtqJgDeSeX1ubwF1vj2jPd1Hok7xDUSgvjsiIEFfy3gHeCYfYySiM?=
 =?us-ascii?Q?nwhMLq7Q0VZAtSOCpTIZh9j1PKhpROO2BTwAyBlRkRy5iC48FA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ceLpwgHvT4iEyo1xcIvBEGLrQ/CWD4xwOMjNI121RFwfGh5VEtP7dH+csh80?=
 =?us-ascii?Q?6UsX0GsnXwXViS4ATK4YzFHGIEMPxwlYPDMkkLsFMPetzCL1VywwdWgIOTAg?=
 =?us-ascii?Q?xQxPAvHzU6SbmSmMesdETyfsZj2N6jQndPTFFs+7E3D4AvVSRflUCygh5JOY?=
 =?us-ascii?Q?gpnnokY4rp3OtZsbeILYaXyBnN6HandpdVK0RFC+jxtv4da/QKydv0SaWaYX?=
 =?us-ascii?Q?5Kg9L7x7P0mJ6th/yUMuf7MxVkatjMrBOKRMyATi86+TCXj/P5R/8TME77DH?=
 =?us-ascii?Q?MHZNxDTaYpC9jEKm18oSKPj0PbmZI6eZDMOp/hXB952uwyO5ichLaXONJ19/?=
 =?us-ascii?Q?I1MQ8HaT9uO8rdNJ+1PxKIRp5FxpWqofSdPdVUrVTZgxicl6Iyh5JJW1KJfs?=
 =?us-ascii?Q?GgTm8Gl4bb3JX1xNdBqTlXq3VbQymGH359exjrhg3wXvMAy0rgRO+41+aT14?=
 =?us-ascii?Q?yReMIAjQX1Z2tMMtU0jwlqiSir6A5cmDS1JAHC2TYHhp6Isp9az2EDU6gM85?=
 =?us-ascii?Q?bkh+sDlizsYnkZOlWvW3zJFbWapmDAGghT9PmRkyH9/aiey1NmSsP1bB0OmF?=
 =?us-ascii?Q?5W9ICIm5g50grwxJ+n4WNAyiXSfZzH+abqxzlU+BtCWfvzLtC5kP/aQrg6ni?=
 =?us-ascii?Q?dSoeYArqWmYTA/J5gcoPMNn/DZwap1YJOQyzL39NU8ei5ldnWlmae2XHkg7y?=
 =?us-ascii?Q?XAv6ADLjZVoYqUGqtk3aUv5UFv7yxGtau8fNBtN30HGYjPGo95eD5giEKcHT?=
 =?us-ascii?Q?XBh3cCDMwURh6ez0PZGWo6G2k+v5h0Gd4t6eD7V5Tym8W4ptvJoISZr+ELVH?=
 =?us-ascii?Q?WnJph4vp5vqlKkn9dk+EjKpzk6GnNsj7FY3u5hCSm9/vWuYjFIk85+BCa95G?=
 =?us-ascii?Q?mbZF9kLiEU0rGxMs0cFXYfOVdpk48W+O5djfLuoNLyzP96Dmb14tqp4FamHY?=
 =?us-ascii?Q?APFCJj3cJ4syb2siahavSoX/UC3uhhzNC283IQzfR74UqcYr4pMIS2kapEDF?=
 =?us-ascii?Q?o/H3+1vjZkAxSrWPK9CGDDJ14WeQOwo95n8JZs7aJRQvwrqcE00QEBXQrV3O?=
 =?us-ascii?Q?C7Qbv1fiwsluWcC4qPuruoWrv6/cCzKTg1k0KWKllqaj9Im0DVAh7wz6m4o1?=
 =?us-ascii?Q?+cfg/NanjKCBrJbY6hvtbLSvqQmwDWTqy2wCCVtOWzBidrFhpx8Xef9wGisa?=
 =?us-ascii?Q?cYcjpbhYx5I7KGuhUadbk2q7qeOJIGJGFfZehJzlpCo9Uz0y7A/dro90dxi0?=
 =?us-ascii?Q?posI5/ZPh38fswgSmoDJa3as4LXg3tkZwV82nmlTI0kBAoMny9tk6/tD12N2?=
 =?us-ascii?Q?2OQzw8M/uGib2ZSDTR1g2y/A5MLRoVQbQdnsyNBY9VRTkqDn/XbtooUUGGXU?=
 =?us-ascii?Q?bA7wCHZczOPvATmwPp8OHSTIEvpAN68Soz95SWAEpP466nA+KbVa5OWfsRyz?=
 =?us-ascii?Q?f5Zv5vPqbvQ3IikRlx6lKy+DQLuzm6fzIFc97MlkUGcZ/WEgGt1UIeHVGU+l?=
 =?us-ascii?Q?oOq7sZ+k25QycFez+FjcOcQHkcauz6SACuaWQv2UCtyjhUsgzYOFb9Cwf1D3?=
 =?us-ascii?Q?dm9863Jxc7dUnqqjZEqJo0NmCX7yVwLb1ywVvSmGsxRo6GBq3jXFDZQtbApF?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: cae01214-4521-4880-0007-08dca125b6f2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 21:17:33.5888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lS0lbDagqRjxKKBgyCVsRKUz+rm8xqDFnggfohdhLcPlSiCfakpB595Jkmz7xYZ7NSSJTP8QD6L9mN55rFpOBlhl1nqIL2dRmz7z4ZxUm2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6711
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

This was added in commit 45a6d231b2f (bcm2835_wdt: support for the
BCM2835/2836 watchdog), which did do 'select HW_WATCHDOG'. That
incarnation of the watchdog driver later got removed in
c7adc0b5f98 (watchdog: bcm2835_wdt: Remove unused BCM283x watchdog
driver and its references), but this block was left behind.

Another rpi watchdog driver has since been added, but that does not
select HW_WATCHDOG, so this remains dead and unused. Remove it.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 board/raspberrypi/rpi/rpi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index d996eb0cf69..9a83cf2d6a7 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -493,10 +493,6 @@ static void get_board_revision(void)
 
 int board_init(void)
 {
-#ifdef CONFIG_HW_WATCHDOG
-	hw_watchdog_init();
-#endif
-
 	get_board_revision();
 
 	gd->bd->bi_boot_params = 0x100;
-- 
2.45.2

