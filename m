Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C699BE83F1F
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54BC383B9D;
	Thu,  5 Feb 2026 16:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O9wKQN1Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEF0483BD2; Thu,  5 Feb 2026 16:15:55 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9E6883AAD
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:15:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBu+JBqh1jTY9+Yh76ZdfJOVtpeDHzCwSplewZYOdobeF12oDOGG72RO5/zJSv/aP8cFBDXeb4pn4xdzFp2O8zZE9x2MKQYKNg/ldr0Xm29kKe2bQ6Cmx6D4nd0FmSPkrq9lpU+ts4/u4ZYZklYRILIK8MVXnpSKGYoTz8eQ8UiLBedIobZSKLXdxb54AFUm0s5lywbizjPXHrZutNQAiJcgBmzzY4NgranHlXyuqk5cofbhQ4KtEr7diEi5wiy6dzAWci04UsDbGXONv4so9g6/uPY4xWOIm7J6MVYLyDRkxmSC6BHe1nKn8R8NtTyczUgqkVQda2zQNzUA5Wd6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S80ezqkm765HYEljIoxkm/X+Jy1BvhEZcnSNjSVFwE4=;
 b=JJ4cI0DyOlHctIwItQvcrR3n5v/fpFjQ3GR85sqtSVrVibkBEqSp+AxrNB8rBl3KYH5Y1N8exH43gpleDm3CsUluO4oDn1XyGeuYo/P6O9+PqSNl7CHbvXTN2UDzXd2e/m5qhkAn1wb8RVrz4cJ84Rs828hWv67ylYZgWYh3Epqwlksov7DrQlLkeXaZ+od8RZYP38qho9piU2IrJPnvaCAUJMO0zcMQ5hlpmltIMLs6ylQUY2Qo+ViQefUyOX4sS+G+tpHB649ckg5CjVOtO6RvURunMDJUCVq5gyENB9FSGgiALnMBc7+WvAwV9AqoRN+CbLfAUV8hdECEcSireQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S80ezqkm765HYEljIoxkm/X+Jy1BvhEZcnSNjSVFwE4=;
 b=O9wKQN1QNBvTTzke0/bKki5e5/I6kng8KZHI/5Nh5UhFijXLdt/T0vNrclQ67K+fbMpJBLl7JAxecCBpBnqm1qBxH45nJdxUAySSjPK0XjXS1NZAhyS+SodYXvmCiW27xmTqJRMtErGtm+Hnf27R8PIV2znTekvpznfMURYXycgtgjXjgolb41Rz362Ye34/Uog06IrWYyaLXjWyXFbqv6DKjNaRaxd0oSXkfe10cGng6QZgs9Mf+FvyiXoqnWaNDP+xebIzKbD7TFGdCOupwSvyVkhyRr9wbMyDxYvSFicz+hOPatwEZ5K2hUSfAqv+O/aVsr3fXQ8r3ceS62noYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 15:15:51 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:15:51 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 05 Feb 2026 21:55:12 +0800
Subject: [PATCH v1 06/12] imx: container: Add i.MX952 support to
 get_imageset_end()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-imx952-v1-6-2103d0222a0b@nxp.com>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
In-Reply-To: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: dac5dc68-fc06-4890-6bb7-08de64c972b1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|19092799006|1800799024|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXViZm16ZGNteGxFeDhWNE5QS2pBdUFaN2o0TEdLYVZIeC8zUUtPNG9kTmdS?=
 =?utf-8?B?cU1jRlMxSWt4RWw2OGpGSkxpYXNJYVM5SFVHUTBWVWk2aFhkZ054THZ4QXd4?=
 =?utf-8?B?bzVoay80SmFzaDhmcmZQaG9WaE9KcC9QSktKcldEeWtRVVFUbUR5MUF1QjRV?=
 =?utf-8?B?QUVSSWpKcUdReGRjNmNUREorK3JBZzk2UGpxZmhtdmsvWXJqTFVpR28zT1VE?=
 =?utf-8?B?UklNOXY3eEJBQi9RWHFIWmZrOGFaMVVDUHlNRzRaMVJDYW9NWmhYRG40QmVM?=
 =?utf-8?B?cEJraU1VL1IrN2kvejdnNlpNVFgrT1JIb0lVWXZFejV2K29nSExYVzZZbUxs?=
 =?utf-8?B?WWZOdTFTN1hwREdQWWMzVVNtdjB4NXFHbitILzl5WktBdWNKaEUzb2JIdG1a?=
 =?utf-8?B?dGhBQkJRa1RzVzVHc2VYb000azZCMWc3eWdpK3BQUG5YT2Y4L29ra1FmdStw?=
 =?utf-8?B?T1lXV3BTakl4OHdyTFdOTm5CQ2M4dks3RlgzelZTbXhzZWtNN01RTG13ZTVM?=
 =?utf-8?B?MEx4bGl0M1BuekdKZFdsRFdvM0JkbGV5YzhJZUtWSmNXRDVOTVhSMjJDRVVC?=
 =?utf-8?B?dVJYQ29mMG9GazczNVBMU0R5djVDVzh6MllTZklsUUU0WSthdFBmUmYzdmVF?=
 =?utf-8?B?VHZaT0NQNlc3Vk1SbVFVR21KOWg4M3NHazhxL1FtL0l4NkUwcXpKRkd6TDVN?=
 =?utf-8?B?bkRHaFpTRnYwS1htRHk4bWhaWGFJcDNlK3FPT2dNQm4reTJQNGd4QjJheDZ2?=
 =?utf-8?B?SHE3UVFYNnA3NnVOTE0wYlhTMGpncEV0aWVROUQyYlRjZHU0TTVjQ2U4T3Zs?=
 =?utf-8?B?eVNFR0Q5WU9TUGZVeklkd2c1cjEvRnR6NTVyeEZTVWxLdEY5RUhKcnJRemlW?=
 =?utf-8?B?NDJ0Y1lsU3BtNGhxU1N4cjJob0F3SzZGcXVhMk5HSW5UNWJGeVoxRlppOEwv?=
 =?utf-8?B?QVpjUlJ3aTYxYVBpMStLMys1VGpDd2UxUDUwWTZYQzFHdXZnMDlwTWUwWnlj?=
 =?utf-8?B?dUE2a01zdVVHQXFES0QwMDZXM2JPRVhyWWFTbzE0MTNMZlFJR2NnWmd5TS9L?=
 =?utf-8?B?L2lSL2k0T3lvZHgwTkxQeGlMR1hZUStmOGxZWWZvZWhEc0F5N01xbWFEcE82?=
 =?utf-8?B?NW1CVTR0WjhibVpMWUkxY3cvTno3WjFGNXBXbm0xMTIzdGxnM3VmSlYzV1l4?=
 =?utf-8?B?Qm9kVlkxNHdaQVRhclArem5OUkpoUzdNWEw5Q2FXYnVrcDRvamN2UVhiVzd3?=
 =?utf-8?B?SnYyVDRiNkw1ZCs3aWowcm94bEJkb3FYNEFDYXpzcUsrU3ozcE9FUVplN3p3?=
 =?utf-8?B?N1kyZUhTekFsdWkycTJuZkk3NWR1VGZicTVzL1VsWmU2dHNnelhZZDZxRHNF?=
 =?utf-8?B?Y0dzSEprM2JHenFTdlp0M1dSekxsaHNOV0d3QVQ1SktJcDhxSEJoYThNcE80?=
 =?utf-8?B?VUZOcnBPUXFxL2lXd3FqNW1KV1FsWGpuMVZOM1JDTWIrUjQybXNPQyszQ29l?=
 =?utf-8?B?T0NVVittQnZzeDFyNEZwTDk2c0Y2SEJYSnY2Uy90eEh3elEyNkhvTlRrMUEz?=
 =?utf-8?B?RE9QSnF0SFY5KzNYcldEUWxHSUlBMEwxeDNiVjRXQ0NVK0VVQklUTGxHSWsz?=
 =?utf-8?B?QVEvMy8xTFFQcHUzUTBxS1ZOTmtwK3RJdFBFZUF2UUFyclVkckN6MTRIYnhX?=
 =?utf-8?B?NWFZdTdrekdLallYMFd0VmtISW53NXA5RGRrTjlMMDBHUHNQMGJYMGtFdUR1?=
 =?utf-8?B?a2VuTDVQV2xtVXNYVUFyWHdDNWhoeVNCanNzYVN4MFFXNnlheXBKZC9Zb2VK?=
 =?utf-8?B?S1pmcVk1MTVOVy9va0hqdXhCZEVsRG0vSVBMNnQ4TkRGejZ3VGtsd1R1U0Js?=
 =?utf-8?B?RmpxdE1Vc2RlbUE1SlQ5NGhhd3g4ellML3B4UHJ4U2Q4c2hNY3JWdTRzTzcx?=
 =?utf-8?B?VytCMWlJWkVYV29mTzFUdWF3eHp0VExySnRBK2JJM3prRGhNbE12SnFuV3Rs?=
 =?utf-8?B?SVJyVlk5NHk1Wm9nbVJNcjhyTHhhZlV5c2lmL2dkYm9vMFhGd1dLQVhLUHhI?=
 =?utf-8?B?NEo4V2N2YjZlTCtJVUVvWURXamVOOFVhdGlEOE5WeEtCUWJtVVVhaEJQVWhY?=
 =?utf-8?B?UmF6eDIydnNmMGV2aFdBRTJTU3NOVUlpSXBxRTlvR1ZkVWFEaTU4dmpDcDNU?=
 =?utf-8?Q?9EQmuomLlHkWtFNNqqo6JSs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(19092799006)(1800799024)(376014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkMwaURtVG1rcFNXL1FHaFNhME9yTStmYlAvM1FMSG0vQzQ4WHEyK2c2VDV1?=
 =?utf-8?B?NHZJSFRUMXhPenhtcW04aFhycHpXNUI0dWxYdytKb3pGMFNublNKY292RTRS?=
 =?utf-8?B?cFZOSFlkS1ErZDRhM0MvV01Ca0VKRjRUcUhFNCtwM2NuelJ1djRSejNQMW05?=
 =?utf-8?B?NEdoWVpSRk5NRHVManJKS21IUTZYQ2NmaFg1QVRlQjV6Y3gvSHlTQXJ5L1pq?=
 =?utf-8?B?MHNoYTc2L3NRMXZyMEIyaVpqVXU0Y3U1VWNhTzdqSVMxbG8yYkRKQXdrZFRI?=
 =?utf-8?B?cVVuVnlCYXo5K0tCM1BqcStONTRFbi9heFV6SmFJSU42OC83RGpvMTFhZDE2?=
 =?utf-8?B?dDZCN1EyT20xdVgxNlRHclFWK0h6NFpNL0YramhJMWtHUEJpVnp5SnE2MEsz?=
 =?utf-8?B?WTlCYU1MbW5FalFybks1ckRjZUQ1YkY3VGFaSjNyMWtEWWwwNkZUbnV3WUFZ?=
 =?utf-8?B?dWI3TlNIVjJWaXpSU3lJTzlac1YxVXBqWjRDYkpvV2tyS2I1Tmozbm8zZ2dV?=
 =?utf-8?B?ajgzUmRNYVFLczlkRUVFQ1I0bFFsTzhvVndOT0RVbnQ2Y0U2WW5TQ3QzTWdu?=
 =?utf-8?B?dHMrajd0UjdWZWJOamQ4cWMyREFVby9SNldndTZmaTZuWVpoWnJaR1JBSGls?=
 =?utf-8?B?Y1dRMFlQdU5ZODI2TGUxUmRKd0xwMDVhakpiSWxnUGI0QkNaOCtaQ0lhQ0VK?=
 =?utf-8?B?WTZkNUpkdVExQTJDY1UzUGM5dXRUZXVwT2hVdlhqdHUyZDVFL2ppaDdVeTM4?=
 =?utf-8?B?WmhWQUx3c0cxamF1eUZsU1ZzRlRSMVE5WkVvL3NFTnBOSVhIY0xXSGkzU3VZ?=
 =?utf-8?B?UmRoWklmNUgrNmR3dnVoUGo0MEYyMDBlWk54YUI3YXZ3K2tjL2gyQnBEa1Fz?=
 =?utf-8?B?Q3UxZXNYMGw3UE5lbHkvSXNHcHZmVW1kRnVFVG15dDJwbWF6ZVpQbjN1QmIr?=
 =?utf-8?B?QjdrS05VUjROdTh5K0UzZzNWVWZFaHZGeFBlY1JvUEU1aWFNOTFyL0ZlRDB3?=
 =?utf-8?B?bnZqUGhvbi9VRk4wOFVGUWtNZFhQQi9PM0ZjL1J0NVcxZVpRa3RIdXpWOUNQ?=
 =?utf-8?B?UW9YdUdNTTFsSkp4akRJa2kxUHVUSDRaSTdmTWFnZlEvS3NGL2hJN3RHUUdn?=
 =?utf-8?B?UzZ6eXlLUytObGdlTGRRYnFRS2NyakltSlJvRDVaenB3UE53b2VpNjAzTnpX?=
 =?utf-8?B?enJsZEV5a0NVMGFSOStTM3BLVjIvMWF2Uk1BMzRaZW94L1ZZUE8vRUtkNStp?=
 =?utf-8?B?d1RKWEVqdG1UVW9STEh0R2I0aDdYYndibmlrS3p3aVV1UnllVzNSSFo4NWF2?=
 =?utf-8?B?T2RvSTRkSnU2b05oN2c0ZHJQRHRjbzFUbHpUczFVUXV6NkVhWWZhWW5mQjlF?=
 =?utf-8?B?WTlEYTRKVzViU2VuazNYczdIZHVwMTdBVFdZT20vRTR2U2crM0tZWE5CeldY?=
 =?utf-8?B?S1lnOHdyTDhRMmV4OGo5USttbjBHWWRTTU5aOVUvYm1tK3ZrckkvUkRMYXpu?=
 =?utf-8?B?dFBCYVJXN1EzaHZqdmhjVWp1ZzNwYlZ0Y1NwcG5hdFNlOHIyenQ5cmltVXZ6?=
 =?utf-8?B?MU04YVBsZ1FIYkQ5OUh0TzZuL05rbWhmeWI4MURLSFdudEZ2MlZsV050ZG55?=
 =?utf-8?B?WlRFNUQ2TmZyTE51NjhFc0tuVnNsZXBVRVg3YnZuOTAzamJudkNnU2xnQW1w?=
 =?utf-8?B?V3JRSEFRMlBpR3AzRG5xdG5tNmhVa3VWMDZtMDlTQmg1dXoxM0ZrU3J3VEpa?=
 =?utf-8?B?KytucGVrUWJZbHJtNWpiQXlrUkFVU2k5cmZzUDZxZzlNWU9nR2dScUo4YVVv?=
 =?utf-8?B?NVRPMFlrVDEySmVvVkFIL2E1anZEM0tjek1MbEo3RWtmOXFaNzBLaGRjcWsz?=
 =?utf-8?B?TDY5Rmpyak9HT3oxUCtpdmY4dWE4MUxEZkpGbytDNjNzZmxuSTBmMTFGN2FO?=
 =?utf-8?B?ZmM1S05RQStvenVBN3VaY1A0cnFZRGxnRy84TndZV1pKZCt6NHdUWmQ5VzlY?=
 =?utf-8?B?K0hDMTM2c0V5MUlKd0hGMHVYRnkwL3p5cGlBVS80Q2owVUJDeDhvSlJJY0Fk?=
 =?utf-8?B?NG4vaVZRTEJmNHlUKzNpSDI3QVJ6OTVwcWFrSmxNN0tPMnYxL1JqV2s5R3ZE?=
 =?utf-8?B?RVdJOHl5ZXIyWjkwbUZBYUMzdEdlMFpsbUlXa2IrWU9IbnVHR2F4VG9SNExG?=
 =?utf-8?B?WlFiREp3MFFBM1RPVTI2UExNNDNBc1BuRWVGQ0hTMktGSnkzOFpyQjAyWE1z?=
 =?utf-8?B?cHpUWjFSYk9sQkJkSFZPdE1xa25pb1V2cmJqemRiSkwyTDhFUmdkNXZ6YnJn?=
 =?utf-8?B?cVhwWDExVWcxVXlLWjR5TmRsOG1vYnFENExXWkNjVm9JSXdJTVg3Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac5dc68-fc06-4890-6bb7-08de64c972b1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:15:51.2678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwY1aQtBZwFVLHK8cRKYhh15Tddce3a83beAVY2Cw0r3WqkLEXELyL4mwLCuE3SEBHZipMD7nweBsCoiY53EIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233
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

Extend get_imageset_end() to handle i.MX952.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 78f2488cf6d..7bfcc9d7e9d 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -297,7 +297,7 @@ static ulong get_imageset_end(void *dev, int dev_type)
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	if (is_imx95() || is_imx94()) {
+	if (is_imx95() || is_imx94() || is_imx952()) {
 		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
 
 		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length, &v2x_fw);
@@ -321,7 +321,7 @@ static ulong get_imageset_end(void *dev, int dev_type)
 	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length, NULL);
 	if (value_container[2] < 0) {
 		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
-		if (is_imx95() || is_imx94())
+		if (is_imx95() || is_imx94() || is_imx952())
 			return value_container[1] + offset[1]; /* return seco + v2x container total size */
 		else
 			return value_container[0] + offset[0]; /* return seco container total size */

-- 
2.43.0

