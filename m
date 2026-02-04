Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CECBE95396
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 13:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 621EC83AA9;
	Wed,  4 Feb 2026 14:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="1Sa7+bcn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E02E483A3D; Wed,  4 Feb 2026 14:16:58 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA2E83A3D
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 14:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niko.mauno@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fssNmUU+b2bQmAFrcIdgkLj3NbOD9DnA97iA/Ers5F/U3EUG1KqiDe8WW0PfTY9epZMHZ57eMMKEcRoWUWzmdSdNxQrFSXJfGew2zUGQ3hDoyqFDrdIVnseMpbFmYiZNDxsTC20t+LLlh9Dn6FXEq0OleERKPE6BXn+46XjVWfhgQZCwdMfuTsbf0mDy/5k+8BleL/d9U+5+ZgiWdiHjcIiNPFFL2C9EXDPvasnaeUAGwtAbKskkHFf4k7IVtoUrUaLDGFtg69FAbMK/Yg/+n2libzPNhnbdH5xq5tCFser/pp9uXniARVq2r+it1PzIz2bWsBYeStE0noQr37ng/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKw2J8i1DdOlU1ckEtfY7OVxoL58ubzNvIVnl3wsfIM=;
 b=EAZzISzJi7ImEe1P6BfHHzXXbK+66aE+Sr+UhOt3WuUhSCH1iJjwzQPfjZauuf16E+/7Nv+PtBIbJTbWlFCwRN8J/VzcB5Z7U7HiqPjcOcAFqdarUx+bq1AA+HlUAnAXeMR4gMfm4C2ajI+iAgeRwdawMPqtRZdR/CvCNjrU5AP+qs5BfVF602KssYfTUZeWGweFITDEUpP4XUulIk2kylSACUCLTPFfSZu9RqThvZjia//hp7ViO6rxIfVPgF/NuBsfv9ZGmh1uPauOy2qRHBTvHbmyz0m7tX6u3HuMpJOqTJIDDNNkbuG3eiU/LbGc+8AEk29eoC7A0JVnPoKcdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKw2J8i1DdOlU1ckEtfY7OVxoL58ubzNvIVnl3wsfIM=;
 b=1Sa7+bcnV/1VRxCLP4fWcEwYBaYpb2f+QmxgkTCU9i+V6q4RfJ+kRos5YixxRjumnxfu+nQN/JtKJIC8CRuW81Z4UL72FV2YL+vNCRXG4TwfbIDiLPH08U/+OqHfx2rr1FajrqDDtFDUC96EBnjTFlrFZB4WMW/Nr1fsa2FXPM7TW+qh9AcvSVyx1RsesNIDMVJApafT4c4040JXY179f239Yif53yQ7dkaFCnsHXEzC1MEMvNBcczGe9LXYqdrSo9EMgS0qmxxPxNjGbhDqx1B6ozRuKaTw4ZoicalY0ZCUd+DxDndGAODIiNaIt2tYxE78e1rUimC5xHHFVM02GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by GV4PR06MB10191.eurprd06.prod.outlook.com (2603:10a6:150:2df::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 13:16:55 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::fb61:408a:ba4e:990f]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::fb61:408a:ba4e:990f%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 13:16:54 +0000
From: niko.mauno@vaisala.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH v2 2/3] bootcount: Fix potential clobbering issue
Date: Wed,  4 Feb 2026 15:17:36 +0200
Message-ID: <20260204131804.23805-2-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770197302.git.niko.mauno@vaisala.com>
References: <cover.1770197302.git.niko.mauno@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007563.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3fb) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|GV4PR06MB10191:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4223bc-032e-48b5-fc37-08de63efaad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5G41lxr448DeEyq071/lYMLLWTslBCnTUsGsL3qmwOw+ZJVAstT86eKrSQD3?=
 =?us-ascii?Q?z4qOFv5N+PouIkKGi0II7pF6Q6a4MaNTu9jE0OdRS/SQz5x7k8LJGu/BLogC?=
 =?us-ascii?Q?nhgzsmiY6RycSHhDnFq6nuUuhKHWqnqh93YJ+eCn36KGdcNeEUhqZbcmYGMT?=
 =?us-ascii?Q?Maa7kpUAFQkawi0mgYmJbtHVkE57Rpfwon3tZiB9RoR8krMQCzxw1KRj4eDs?=
 =?us-ascii?Q?LDdD0tgkr1LvrVWTf3nVBu3o1OtUAjpjuYZL/CImUWWrm2nej3mimjX0Mf2N?=
 =?us-ascii?Q?dLvaHbiLQb0owPCi1jJdG15fyLgIAD8TJlFjBoIbGRtG7szVnka4PU1kF5GF?=
 =?us-ascii?Q?E5M6wrRS/ooxoHIXIFjI7bcRYF3ovg4o2RGgvrhLO4TI1yeyAxKtFgbsg3bs?=
 =?us-ascii?Q?uHpoSJty0GUQWelVICIBWhCCcwoZsOyqjGpaUzdn8vbjFoL/e9aTz//X5H56?=
 =?us-ascii?Q?Lrw5H07svE52yBP25WNleCDQZPOa2WsY3IsznyV8OUVclEAd/6khlZU2ya1h?=
 =?us-ascii?Q?3P3R5F0xEYnBNlWZq7IgCwiC4EHzwrYRhAuRBMgnYbqg+SXaR4zLzl8d1+po?=
 =?us-ascii?Q?S3DpcL97NFUcRta01KwUBXFrRcxUaJ6ZSVu+b+ViVe329tb0o6mbZbkXsRZX?=
 =?us-ascii?Q?RUDpb7LggVEoMbecYoZf/Z8XczspH0zq4XkLq0WI+sTQr7CdyFmFHNTHuDEv?=
 =?us-ascii?Q?wpcCRpLTtFbWbwc3IYl0C8ov9H5tkz/0B0YdQhOKUhrJYpN+gyuS07aVr5aO?=
 =?us-ascii?Q?bMMwuQObySpPqk/ohWXwI0Xlec9nEb9jiVo1TkkBzLYAJVXK5DZaxhLFiViG?=
 =?us-ascii?Q?Xdrhj4ebe/PyN4k0HohALzXqD3d2Vfeldn0b9OhYHj9hX7j+1ceMtHGJI/hv?=
 =?us-ascii?Q?BSry1LJaEjXfydlJc0WyylazfzUcbNe90A5tfP/eoUv+4q2d+mXCf9KD8x37?=
 =?us-ascii?Q?xXmF59jrk4/m6lrjhYsQRDK57UlIdoROeEs/A3dNySA1a17+WCpctIYwmzO2?=
 =?us-ascii?Q?EHnmXFScV1rS+dVJKDpVQzoD3yGCDDi7waR6Tr8quWjkkR7HzbecaRMTaU8E?=
 =?us-ascii?Q?Yw/ZQj8oNtVrXcHuYz5iR/CsiH/QMfihB1Hogj3fNHUAVLq4IVinxd3ZhHpe?=
 =?us-ascii?Q?bBhe4zyEEK3j7cQJwz1LSrz7DWdQuq/7kpmzPwMvckDWGHf+OrUR8RiVNC9n?=
 =?us-ascii?Q?pMdayPdce3JM79J+es8JCtP2qF6eUXbK44blYcGH1xdGke3K+U2OGBzo56xz?=
 =?us-ascii?Q?4/QmkGW7PqyB4EGSD3E2KsOkap7w4OBHmv38A649ylODbM9FIffKHauPwQsa?=
 =?us-ascii?Q?P9byQxYH5AhpC0k070MsN8Qq/Ib4Q0YCF/UXPDpyaqlJeFf7ZvNbxVfXrw95?=
 =?us-ascii?Q?Z9aLKGY/u8yW73Eu1zgBK1KW/+7F8ddq4f5qOcCl7hZAHOhL+pcbUVkRj78V?=
 =?us-ascii?Q?I2jsn+lv4KgMZOI9m3WrtZqUmyIoUSFIfO0CuDjfwEacjb86EJforSU6dUgT?=
 =?us-ascii?Q?lWg4nDiwwBBMUIJ60JzurqRZJ1LLaR/er4ogsMINwHqLepNicF5qwJX6jxTs?=
 =?us-ascii?Q?gS5coUVXa4CCuUry63uu84n2winlpwqLAMfxT1f32Gi3n/3i68/XEyP5lzqk?=
 =?us-ascii?Q?mPMX3L+ciD1oW/5daJAEjq0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR06MB8447.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RRrCnXadKVdJTV/xGm54IvO90p53rToqwT7pgzbpXKJlgO890tQK1UOhqnyD?=
 =?us-ascii?Q?OQoCfy00pmi1OlyeRst2zJEp2pOWS4LSf7DpImT7qCgqJzt/ank0UTc/vYwa?=
 =?us-ascii?Q?/waLcDHpZxaPaqdZdeAGPczKwgv6panvDzpyeZD4mwjLFEnKJwAVE/FyASdK?=
 =?us-ascii?Q?IbcHsfzTALpcndm3Jku90NVkD9UX7foBHF7ZZz/Q6Y8kSdjk5jCn11tfxote?=
 =?us-ascii?Q?trnKwRaT8QGECIu8+9yGnSruHIhSqt/Tn9cM2UcsqSQs+0oD/5Pk8SJ+de0E?=
 =?us-ascii?Q?799bhc+6VTpTYUZwhfKMMwhuKWeyl9zSORGDSNU8X78gcr5wEuO1Ov2iyU+L?=
 =?us-ascii?Q?NirkmhLYmCZ8v16VUMNf/YlhN4x1rtmVOA4t99S47LjX4lzXilTAPXOEmj/n?=
 =?us-ascii?Q?zworCfSWhFJ9UnEWeAK+zJNgb1eoRAVAELSXIaja4QffCpfsEtaO9waeUbXG?=
 =?us-ascii?Q?o0q9Llkt1p/KbIwu8ag9xV15WIYxCuJcoZdbyBocwDXOPjwaGRJVMtmufcvA?=
 =?us-ascii?Q?wwjWM6MPK40spC8mX7JVY7jcvo5NkfTWbNAvwP4JnVdghXf6vHHtkDw4NpY7?=
 =?us-ascii?Q?sM10AYcXZ8bmOB9IeqARtxRl9pxlhCvnDirIHhZkx3oecddwSpFveCFcthsu?=
 =?us-ascii?Q?PUboxuvUrqzdLmlAyl+MGb2IjamVcNG4iqKdiLjMgSxQOhfPAHcKFhhRd516?=
 =?us-ascii?Q?VoaRzjt54UuHx3n8uh+IHrJs2kpC4bTbvgCWAN9cJOrlf6J30Ec6ver+WeWm?=
 =?us-ascii?Q?nzywAJo7cFKbzmUxotA9hbqbNJEefLHfM9WZmfVJOCGqbcfZd5QwXX3HgKJc?=
 =?us-ascii?Q?l20n3BtXVEgfC4TPCmNBJph8ojfG/qaaZSe42G48q499a+Pg/t0IxqHDM0LD?=
 =?us-ascii?Q?zNoSyuKsDIT3t/Lg9/rGUPVEQw6FjnVAmxdkx8fXTKQ6ctnlt+cg99O/EXuT?=
 =?us-ascii?Q?3vvYp1vZtwIdcv4PjIgilNpxMF8wlKYntphobzB4EpT/tzI30FR9h/nlEMGZ?=
 =?us-ascii?Q?pbSVBEyd2VoeAtZ/8eLZ7p1WeaMpzfX4/ATd34F5LmmwbNmyB9Su9T4XEqIu?=
 =?us-ascii?Q?LUYW5Jw/lc0Oyu0PvymAkWmABknlH0fApifqgp2ayksm7aiqLQmL9sFynxTT?=
 =?us-ascii?Q?JGFsHwBuk6uT8DoMbN2uOTgOB5/NQYPHSmJG5THsEt1xSfeNGrioDutEj0Wb?=
 =?us-ascii?Q?eSI+2h6TvPc5qhYlmZoFcFnw7iTbDc99XRxD2uPRsWLbve7CuUA7tWTbESNU?=
 =?us-ascii?Q?hQhuxcW9EcCTKUqwlC5TFWYy/h2p/OZyP9PM4RamLvWJ9KTPDMYJanFW99/0?=
 =?us-ascii?Q?2ey+62rcimHws0xe/LeJOLWLMQsABiihTvtJLycEje2ABpg4P9hyQZOYpp6Z?=
 =?us-ascii?Q?jz5hQXvu/79NFBAbj29XsFFtPBok+c6qLjHL9CEqQJScR9RIujxUIcwbiC1h?=
 =?us-ascii?Q?3Idgdt9xDCfOJoxA3jOCdkQlbn2wIT9tNrYIETa0iS8ghFi6QULmHj19YE1W?=
 =?us-ascii?Q?XuQZhO3PvnN+PB6Y+QwMeRf/SdpW9naI3JK/0dfyY8vMDWrzYHq/eVJ5Gp+b?=
 =?us-ascii?Q?dtgoX++0UYwJnBaGuE2pG/PbC/glvfhAP/+N0/7vcqsJeRO+lFwfQ5NMyoTE?=
 =?us-ascii?Q?1dAHS1DaLOL1Dnd8MjFRIy/wbWTA4JTT4xGU0dXRjZy26708NNOBJz3txcpD?=
 =?us-ascii?Q?6yAziJbqcpLgTZE2klSB/HXG7a4Kc1UvYIrE6TY/2ATOMebaKW3wwzXvJ92Y?=
 =?us-ascii?Q?QjPTa/z1VgIiFHylbVYFSng9wT5zuDI=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4223bc-032e-48b5-fc37-08de63efaad1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 13:16:54.8894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKuZR3n2yIHIk53umHenb+axirgFGViopU0Tcx1NA2/NyDc75BZcwg0ezYfJ5HvizwTWTBFJP0eOKCTyqi/oMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR06MB10191
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

From: Niko Mauno <niko.mauno@vaisala.com>

When storing the single word bootcount value, apply the bootcount count
mask to prevent clobbering the magic half of the value.

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 drivers/bootcount/bootcount.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bootcount/bootcount.c b/drivers/bootcount/bootcount.c
index 454e50591df..2c0114d9705 100644
--- a/drivers/bootcount/bootcount.c
+++ b/drivers/bootcount/bootcount.c
@@ -19,7 +19,8 @@ __weak void bootcount_store(ulong a)
 	uintptr_t flush_end;
 
 #if defined(CONFIG_SYS_BOOTCOUNT_SINGLEWORD)
-	raw_bootcount_store(reg, (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK) | a);
+	raw_bootcount_store(reg, (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK)
+		| (a & BOOTCOUNT_COUNT_MASK));
 
 	flush_end = roundup(CONFIG_SYS_BOOTCOUNT_ADDR + 4,
 			    CONFIG_SYS_CACHELINE_SIZE);
@@ -98,7 +99,8 @@ static int bootcount_mem_set(struct udevice *dev, const u32 a)
 	uintptr_t flush_end;
 
 	if (priv->singleword) {
-		raw_bootcount_store(reg, (magic & BOOTCOUNT_MAGIC_MASK) | a);
+		raw_bootcount_store(reg, (magic & BOOTCOUNT_MAGIC_MASK)
+			| (a & BOOTCOUNT_COUNT_MASK));
 		flush_end = roundup(priv->base + 4,
 				    CONFIG_SYS_CACHELINE_SIZE);
 	} else {
-- 
2.47.3

