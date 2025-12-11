Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C67D41C17
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CACF83E28;
	Thu, 11 Dec 2025 11:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N+TOmC8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF77839DE; Thu, 11 Dec 2025 10:12:57 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C0A4835B3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 10:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xmg6fG8pFfhxfRCqPgNBsBO+FXPYq4StDUEPC++ASmnmjzmDrJJlZbWAIgskEnao1DzsTbWXTthvFFkmdCht2uicGMnoHUg6ZzgOJTlfbJY1rfNkBY/xclKdTiFctqMwA9cfW5q5PoenbBKwbJRwu1tzcazPrG8Da7jXAKdHtl5pmttDPlVC5lt7/Gb3t6jg8y6GRYe6bEH2eoqIwl02RNwl65kkd/VH+OL4dkS5iFU6jWkJ27jxXfM2FzUsgIhGwCA5nIdE/564vx9S2Ru5DmAeHxwdykQ6qIEKPOO4i/6jV3+dkvpfMJOH2ls0/pEwdPSbV6DwaJR5vJCDlGq1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM+rWMVXeQklOTmDW+c/+HIdePAgIFVsfBpK1kTcpcM=;
 b=uxm+WVchR1bcGSkJwDhSHA+k0oQOqam4Rfovq5s1Q71dOZ2kjgNOIsMr02ZTA4/rrEL4MtRkoQ8OUGnUPcl9zMmaRZP7/+BDbN90iKnjrVvDM4WveX7tPIdwtxo6JONCvzdXkKb4+pwaZYzj9K3UkmgUDrKIO0Y3docRVd+eG9UDe1vS0OPFpmVWPvxELsEPK81RnkQ6N4ghyHAPGEwmt9JPONffKdM5yikogXg80wt6mcchIGu6XKjjkwmh7M91XvRzHDljIUjPNA0BW3jgFA8ASejEUJ80pMCACjjy3k3yN385/sV+bUQzkcgAKVZGtL3NQIHIyd049IjbnFrkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM+rWMVXeQklOTmDW+c/+HIdePAgIFVsfBpK1kTcpcM=;
 b=N+TOmC8IZ4oie2FdE77UsWkEqsRg0Q1XGVosz8f5hE5vggmr/xctdM61IR+3d4c1Hm3WuqsJsbJn1fzPlRIyVq1fF3n9vr5wiybi9e4tthOMm7sakzQ8ul9eEwS5xp1NC7d7zJTYqk0Gjm3+KpKXVruF8gu1FdDpnolJZti96LXI8FVYJuoReVA1dwr3mu8AcvOohDYGBmoOsV4V0F5CJ8G8jo4XLX69vEEOkx3xwjpLq6g77dy3eEdVvFuzVzMBj0s+JDn+SnnZx2CBa7okMxXMPUcJQTKW8WlP1g2lqSN+UhkCPmri2oO8ncjBzPDDhIUTPxbrwNLB1m6TgqRA0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8827.eurprd04.prod.outlook.com (2603:10a6:20b:40a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 09:12:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 09:12:53 +0000
Date: Thu, 11 Dec 2025 18:26:25 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
Subject: Re: [PATCH v2 9/9] mmc: sdhci-cadence6: Add DLL master control and
 improve tuning reliability
Message-ID: <aTqcUZNMiCWb77Ly@nxa18884-linux.ap.freescale.net>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
 <204e8d92cad8d609a18006a4848f2c5a57f6b495.1764760325.git.tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <204e8d92cad8d609a18006a4848f2c5a57f6b495.1764760325.git.tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ba55dd-b902-4710-a622-08de38957763
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jfK0Ip4UN4Pe8E9qCiLewYDWhB8Uh+N1LmNHnQeBLIP7e2a5kJQ3AyGFjj6D?=
 =?us-ascii?Q?aQITF8pwbepI8Ga9kNOEcL2+/8N8+gjY+gkhkZPDiFDUkltYQ7ssgRypahyu?=
 =?us-ascii?Q?lTJy03VOXuv0qU3MR09j/Om4w9YLI7cH0srggL/bZxWqznZv0VfAyldcQJV4?=
 =?us-ascii?Q?zIB8kvuDfWelZjQC4sfLaCZtqXHzHqxSJLnIBOZw9oz4oPyDORNeJH30Y4mr?=
 =?us-ascii?Q?Fa9YsWKoYNjeAnFKOZ7l4tiGGq/m1/+51sTOQSUBXBANs5vhf/e3yYd4LS74?=
 =?us-ascii?Q?34n+fPwpkl3EnfHOgyTYMDUChkiod5xv1j7ACHYsSbt/AJXSlrjBs3dsrO4T?=
 =?us-ascii?Q?DJ8RaVPoOu+zihBOu5rQ/o063panGEKIgHlj6bCu9nw0KfEQO854DyaqdDMs?=
 =?us-ascii?Q?Covoeh77EldLlpu47UqPZGm7kPCM0IepXQV/CXvJs7JJ91QoQRsNgsoI/+fh?=
 =?us-ascii?Q?4PB5Skyo+IXe7vdy7wZ8TOPd5fhqMRsRDeG+taeBpK44J3zkeBarUfSuJS4y?=
 =?us-ascii?Q?aD9IEopsCE+lRIrGY3vQDmxwQ4HQtzuxKx98iKHb6WIoBCodPuZFxOeGtJeW?=
 =?us-ascii?Q?VjNmXEZrxNx+E50FXze/dZECt0rPB447V7JKTrbE8cpWJpE/7L6gYuV/6w9x?=
 =?us-ascii?Q?JjhLmK98FfdchG1UPdUM1Ij3TtNTNEnBnm0kFNlk7FaIjYV6lYk1v6ylJDO8?=
 =?us-ascii?Q?aJ7PtdbW1weeMSIy9a2mxS94y3hnqxB5axfpD0AJpA+TYKOjx1umJvnpWGBy?=
 =?us-ascii?Q?0BZgvuGTHpuEGaUbvBt+5/whzLTpLgsUs2fy8sEjxycg2pk8KM8ttlt4mrky?=
 =?us-ascii?Q?7hDRk8Erylp0M1cIQZFMNxHtJJU/LPDDlDBaHWHJEBzIuN5cjpSNne4C+SYe?=
 =?us-ascii?Q?ksKFa0bJjE6M3znZcrruqCyy7CnW2UnlZi8yRtKcY/2lo+6tVd+noLOB29kw?=
 =?us-ascii?Q?05jWpXNnYnxtc3Lub5GMDmrYInGmTKPuHdxpaLNBAkGH4J8yB+vT8kRy/JL2?=
 =?us-ascii?Q?S6My0B9hrMzZBiiHu/PO5KoFKXNP2bdF+wFaiSIknERy9ojyMvOvZfdVgta7?=
 =?us-ascii?Q?IWyf1U+4gWpedUvLfWzkMy5wvK+UTLfLlCchBOHYQr3ek+F8DD5d5jxkIAMC?=
 =?us-ascii?Q?ksuKn0d08k/Aywawj9KvFmpu8JEvA6UCFfJcRwS+Gvt66ahwqogQuuIFUfV6?=
 =?us-ascii?Q?M2I4AnfNYSRmPlfeEC94wMWr1i2e2h+Z6XQih92ctXtDw8c6X0E6S7AfZsHg?=
 =?us-ascii?Q?qHb48vIJeSTP3/FUXASyFflkwxh1M125nIZmyqdgAyD4EsK6qFM9lltlu+L2?=
 =?us-ascii?Q?LTYvc3ZUYuH32BAghapc9NTDBx5y/3vbekrD2xWYn8NiT6cEdwaPV0mPK3hG?=
 =?us-ascii?Q?Datsn76LTMMCMMOt7yQVV2L2YfgMFy8KKxvtse+PNrgRUDGcyCQ9awsuKPcu?=
 =?us-ascii?Q?Z7/rerTkO3G5nGpI5pd+RiZCkCB7lOSGYjvGrxfNKJSP1a6ja79Quo0UiJt5?=
 =?us-ascii?Q?EKEEPcxCb6C+lmRFmnfQom2TlJu6z02qCaDB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Zy7oKZmSiKBzrLLW3T08oHYL0Ne2guw0Q/J4w+phO2supnSlJiJSAqWO/Tz?=
 =?us-ascii?Q?k1a9QIrTx9wZlO5brbXBTP/WCKnODEzt2beo5tScdk2dITUj0eqhOBxZeH6N?=
 =?us-ascii?Q?NB0+prVwcfOM4f0K+FA0TujgT9lNHbf/vmqtajMLZVmh3a35ncxj2sb7HHWD?=
 =?us-ascii?Q?mlU9ZFjbbmN0WAk+QDBIfG7CfRJeeBQ3ZsyIMSL1oBvnHc/8RkPPumoM78K7?=
 =?us-ascii?Q?av01brS0HqwwgrPIFLHr1MBknjUAj6xnmwA4DqG7HeuWzco91PtBjF/lJ+NV?=
 =?us-ascii?Q?dzg7dzmR2F/oYHU4UUubRYnYYe1s/tH6z1Y6uGWoevwwZ5V0SYt8eU33TFut?=
 =?us-ascii?Q?uEtGDpjWJN+w93eKvgO1ndSubSiyP2fCjEvFIJsLHD6cWoIN5/iRi907ok6I?=
 =?us-ascii?Q?89jQxBrem1gQvPfg3QxbcIr/BJeo8J0NoUixNHA70kV3n4rNi8eXL4Wpk+Yv?=
 =?us-ascii?Q?yc5tFvT92XgkIkQA4ofcHGt5VgeAFqtKzXypZm8bnWWMvgFwwWr6ycpWW6pM?=
 =?us-ascii?Q?UPLerS/JiMxW/Vs/F3i55I+Ky/tgUxQP+mr2tr2ZMumhW+10nx12DEJ8FGPN?=
 =?us-ascii?Q?kkDyWAI62r6PkrE95T0EbKXmwqGz8oLZ/mDKcsk1e1SjolErIY3eYPK+Aja4?=
 =?us-ascii?Q?QfQkcBUptgJhjNnkNJyq7dLfm05cfiXC/9EBf16gvIieDrvPHGCBHj3veiBn?=
 =?us-ascii?Q?g5AI5t2jzJMYVkUjEVyFyFOlIaynkUbLd/Le6ZPH3v6pmSP/ec8WaapX+Cql?=
 =?us-ascii?Q?Tu1/yfIrEalqfUgVKvp7BgnFapABJ7i4BHIFKjvttcWfkw4LR+d3AHpP+5B7?=
 =?us-ascii?Q?7QHwicPtuDR25jCnRL1/t5TX/tN25SEIKBpjKUdg8wiZaWi1k+24i/cLfUTf?=
 =?us-ascii?Q?wd6knXlTOaIbux2HM1uheuQ7LQ1mrcmbi+nTvHdM2a3sOpPia1XuSn9rhOdH?=
 =?us-ascii?Q?QI8gLLUZF2jS4moYPKwxHsIVQW/XHJ+uFnoyLbhKqrdBN1ItVIzz9R0qU4+U?=
 =?us-ascii?Q?AhQmwN7q/oCWR0Y1zYfHFjBzZt198d5X5MNfgfzc+Bok2hhDwtS3J1lWHkV/?=
 =?us-ascii?Q?vsFwvFCNSxQeOOqLbwc4Y6/JUUT/ypkzTfcLOpbQ+7BhE2yw8pg+jPAfC6d1?=
 =?us-ascii?Q?4yaob6uCy4NHvFXekCA5ImAAsupfZZSMrVIhFLANI9ISSCiNlBuKWtXTU9UD?=
 =?us-ascii?Q?1/oSjqCLHToWvxzbIOECi7qIAmIPXioSJLtuNg9RyPHMNy5G10d12FcDFZDA?=
 =?us-ascii?Q?pT4QNvRIlOjAns0sjXqlAg07k10O1uJR+y5AuDkpB703dfp1O4gP4iRcuMlq?=
 =?us-ascii?Q?ZBuM0+3WCkxnTTOY/7dHraxCD7wBz7Oqky4ndA4zfu0cdkR5UFY35hiXApSU?=
 =?us-ascii?Q?hSyYnSyEs20qSTGq/JolDmxklgnskJDqw0ScAUgSt5sCBFkHVdQ8qhx0+Nwi?=
 =?us-ascii?Q?ltW09bTjDMmY9b4xFPqrWQFyQKOQ8kcJluwRGrkqQqcSfc0d97fx0O+jAJxN?=
 =?us-ascii?Q?SHJJijCQUJM/e+H9QsYOaDTiJiTNDzTxPnd1XYMsYbduMl/RRI1uHZtW38wA?=
 =?us-ascii?Q?QLddQMG9Te4T2kjOWeLg3aSrDExE7709OSCASzlR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ba55dd-b902-4710-a622-08de38957763
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 09:12:53.8724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lybX/NGuRPc/LIeRAGBM37cgS6rP6FJFaVO9/P4WahpYu9fqy/AIivIWjKYa2K3cCdacGRtanSftJH7HYTuaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8827
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

On Wed, Dec 03, 2025 at 04:21:39AM -0800, Tanmay Kathpalia wrote:
>- Add support for configuring the PHY DLL master control register for all
>  SD/eMMC timing modes (DS, HS, SDR, DDR, HS200, HS400) by extending the
>  PHY configuration arrays and writing the value during PHY adjustment.
>- Fix tuning reliability by toggling the DLL reset before and after
>  updating the PHY_DLL_SLAVE_CTRL_REG_ADDR register.
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
