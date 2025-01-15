Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAD4C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC758807B1;
	Wed, 15 Jan 2025 14:30:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C/TLJo7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F67B807AE; Wed, 15 Jan 2025 14:30:26 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50E57807C4
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIisANcVZFBc29/PjW9diiXLC9ADsAb1HKFpYen2ziqv7PlmUkOywybXgVaPa/oovqsEs48LaKKPhEQN39kvRMsF+K+E4U+Go3udfw+Jm0FaEyWf/ahJFGRBNPV7bwNkxC4D9eqkdZz8nKefDX/25G2hBiItssWaz2H5HJWkFQmg8WhP92KZ5qEaUFDjZOKXabgJDB5qhZQ6toJIrvnd18aoeJVN8TB9Bj3co9mDRu+7MkvQXz4RrKqxOqOOWJS+99YTgrgaXqWRN7cAeeFGSIeMExtZY9fAGrXwnYQIi81UaPVD99dAdxFVOL5cIlATIA6cYQnKv3bL9uTC96v91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuwOEQZEourDzHfu60ciKo7M4Bx1uaaHFcG+diFR7v0=;
 b=OoEJBHSPzGsSRpyEF6z6CP3CdqiPo0ALq+eBg2dwGqGQew77fcEiCR5yzkWxNpMQg/yRnghcNNwAB5NXpzHUuT56DNmCdHwyiOfXu9LlLkfB25sXMPTGTjp1GlUfo1reunLXBpcpu5Cd3SqNjRxMXU+PAHY7eqb0TfdZR2wuwr1JGnrIzGKy1NZcT9h13dFa6GfN8hz+XuCivFajLnzK8aMqefdmS1khnXBZUrU+Z/7Agsbc1Lae84eKTLGZ1Bmc6wB3CuEYbILqZNhYWaJFNRHDASpgw6iePji02ht1UwXxWTfNg3wJudeBybG/iv3YGrA06y4GaYaauBMiv1Rglw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuwOEQZEourDzHfu60ciKo7M4Bx1uaaHFcG+diFR7v0=;
 b=C/TLJo7N48wzQTgFeQ9nrKg7e3GBqp1K+GhBcPnHeiGgrwtKoo4XRER8oadmwXYyPjA0pKvbMIraFweqUNIuzByflMB8ISuuYaTxuPvCY1FPygPeUPC7FRb2/vBVtWkECvdyRSZzrwN+yW9dyXg7eu7eGhR0RNGMTvV4XiPBljLc6xkjA7ZM1TChbGcrIZ+CBCOelnDPg40OXMf0ha6WqGWLoRUbZxCBlSjApZYRdy7eKfWPiFaE1sDIW6fI/F6C/7PaqS0yRh0xwk0ATXTQz+JvrRSW0aaChz4/d1Wn8zyTHwFS8ZXbbbanjwm6YX4tK5sfZWTmnFCLI8bkQLY5xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8593.eurprd04.prod.outlook.com (2603:10a6:20b:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:30:21 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:30:21 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:29:05 +0800
Subject: [PATCH v4 18/20] imx: add V2X container support on i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-18-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, 
 Alice Guo <alice.guo@nxp.com>, Teo Hall <teo.hall@nxp.com>, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=4715;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=5mjLko0D90emd8eazTMT621owZ10RDbCttkbBOSrtws=;
 b=1XdQ1uu20NqOr0dxFj3WIu5kdHjmGqh2/hchxrHsztxsMG9bbsLZg85i5Bm/AcEjr9mvg+q22
 2o/hGL0RsuWCZ9vIpkjzAF33vHTn1Y9BD2F3Xiszpex2zskei1jR71e
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa2afc5-faf9-4920-043e-08dd3568c295
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFV5TG1RYWVZUFI0VzBNWVVvQnppUi9pNk9IcmZvT01mdnBSMUQ5MGNLM2JR?=
 =?utf-8?B?eWR6OWw4cmppOTFwaDZkbGNVcUhJTUxCbWxsT01EYThzdU9ldklidnkzanNm?=
 =?utf-8?B?RXZDR3gvNGcvVHZXRFBXRkNkMXZlRDYrRSthMEZWR2U2d2k2SzZFZDNjSkY1?=
 =?utf-8?B?UlFCdStobmxIWXd0OUxCZEplWThzYnlhY2JzeHdhd0t6Und0VTJXei83OUgz?=
 =?utf-8?B?cGN6OVRJTE56WjhmMGV0RkN1NzFoNEI5cUpJQTNEMEFsYkVBVHM0czRRRnFF?=
 =?utf-8?B?amd4VXRIaEtMUXp4eUpOaWlRMTZIc1diWlo1M1FtMWkyNWlHS2xLOVF4Rmti?=
 =?utf-8?B?d0FLbXQzWGt0M0h4U3Y4T2xpdnNqa0NrRWs1WERtaGhBS1Rsam5ncG5aMndi?=
 =?utf-8?B?OTJFV2VNVnJoREU3VGVKdlFkZnNEYTJ0TkQ3KzNkV3dsZTZRd3BwOFBaNEd4?=
 =?utf-8?B?azNDd0lhZmhLcENnS0dWcVVMT1pNd0xhbGdLSWJrQStTV1FJMEZDMjVMZGgv?=
 =?utf-8?B?ZG16UlYvWE54N0N0WWZIUEl5S2FwS1VTVlFXbTBsQ0FFK0dwTVdYMGZYSVg0?=
 =?utf-8?B?VU5iQlNJUlNOYzFBczZ5UUJvQXcrRXZGckZHVkQzTldsRVpFZVZhbE9heTdG?=
 =?utf-8?B?azFPVjVEaDcrVmc3QWlOblMzek1yTmU4RnBNMFpMTUJuVzNHTU13YTlQZThp?=
 =?utf-8?B?QVlhU1B1Q1o2SThPTzdOVTdmMEJ6NGhXVzhVQkM2Z0NnMVZXcjZ3K1NCZm0z?=
 =?utf-8?B?RWpoQmtxeXRCUkJFNCtGMW9oREo4Y1NvUTdibHIxUzdhMHU3MkRtQXdvYnR0?=
 =?utf-8?B?c0hDN2QxNndzNTRNbFR4YUovajBYWmE0M095V0VjTUY5VzJtYldMZVI1OXFw?=
 =?utf-8?B?VGtxbmwzU2xwejBXMVZJTTRVUXBUd01WZnFRK29nQ05NNXc2VUJ4Z0JsOE5S?=
 =?utf-8?B?RUdEQ3ZVLzlBVm4xSXdTYURHN0pyTGZsZGppL29WNmw0TFFMbFBNcU84bWJQ?=
 =?utf-8?B?QkhVVXUrSGJ3cndHZUE2SUdHZVNnM2pYb0F5SFdQdnY3MEFIeXNHN3JlU1Zi?=
 =?utf-8?B?bGRONjRrMnJyVk1PS1RxdmRCTzBCK0JEcXgzL2psaG1Bb3BZd3pvdGx3aWxC?=
 =?utf-8?B?YUNYYmRoYmlFOVZYYXBGTEhtZG5zUy8rQ0Fab3p4eS9tcEc0aERldHhCdU00?=
 =?utf-8?B?WHZkWWpMMjB3dHV1WEMydWxLR0orV015UHcvRTVTWWZWREVEUW1ETm10RjdL?=
 =?utf-8?B?YVEzRWNmTXdhU2xQZ3VqWi8vaFpOeUkwNkRHVC9CalZZQ3R5UXVsenBHZktB?=
 =?utf-8?B?RXh4K1VMTGdoWWR4YnRaSm5HVTROZXlwdEZWa0pEOEowbzdjOUtmLzNmZzZE?=
 =?utf-8?B?VFVncHR6bjNOVW5ZSHBYVTlTbGVhRHFJN1FMMUFyMWVZSVFkVmd3bW9pc2t2?=
 =?utf-8?B?REVQbVhwRjlpSXptWEg4R1l1aFJuNTRVRzQrSDAvK2hwZ0VGd0pXaEVqWWpK?=
 =?utf-8?B?WnRzNUFqc3NXSXZvaFhGQnZHS1k1Vmg0MVJrdU53aGF4RXg2Y09sMTB6ZXg5?=
 =?utf-8?B?MnhKd3c0aWxJUkpVQjJUaHdyRmhzZnkvRXc1VlRQaHMrNXlYZTNLNnVQUFhC?=
 =?utf-8?B?djdWcXpkUEsycVdGV3BXVFpsNWI5VTNVYno0MFNCak8rZGNyQVRiSjkwZmpm?=
 =?utf-8?B?WGlRMWNCdmh1T2QxdWsyVDdJODFMcFlzWkRIbnR3aXlwSmdBZU12MWdINGxO?=
 =?utf-8?B?MTBOYXhwenZvOXd6ZzlsWW85NlZTY2lCK2xkY0FQKzFoSUZXcGRmWngvSUNt?=
 =?utf-8?B?MFFFbkgreG5BS29wNlVodjU4REhBYStRSVZVUDY2cjVxTTEzTkRLMEk5bE4z?=
 =?utf-8?B?Sy9Ua3UzOFFCRDZyUkR3b0Y2Y0xnaW9YZVJ0NVo3ZmxVSW10clFIcjF0QXlH?=
 =?utf-8?Q?oi5Wx1CZWDV4NaFst6W4w0GDUXC1D9GA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SER2WFZPSkFpenpjdWcvTU9HNFJHUWJKM3h3K2Y0Q1F3STNJbDhUYkp4UnI0?=
 =?utf-8?B?VDNDSFllZWJROXJ1N1VMcFN4dEpEVkRDYkg4MkM1THFkL2JwMjU4aWZsajhG?=
 =?utf-8?B?OUU1V21FbFI5SHpUT01uek0xMjFtaFJxUy9HOEN2YUtFeW1HUDdDTElBL0hj?=
 =?utf-8?B?OHlRRUwwb1E3TkZ1b3A3elBxYndOUEpsdVVXT01ialRaOHB5ZTk5VnZCWlJR?=
 =?utf-8?B?d3BkeFpNMm81OWYvc2dUbjMzMkhWNHM1S3hrZ2JYYWpkaHhLQjRpYzJseUoy?=
 =?utf-8?B?bU9qbUNmOEJlbC9lUmRRYWJWVm8rNUY5SVl0b2tlWG9iUFJhOEc5aHM4YlpT?=
 =?utf-8?B?WkhZdE5DVm1IcER5eDlzdVNSQzM0TVFSQUZ3M2tNVE55TFRZWlpHbnlzV0NC?=
 =?utf-8?B?emt0dGFhZElWaTc1bE8xSVkzWEpnMTl4R2s0a0hCOEMrU2FQb2Zpai9zNGhn?=
 =?utf-8?B?elZmOU9HNHl5cEpxaUczUkhBNkc4Q3lLTzF0Uzc3aEozclZ2ajJyQUZScEZD?=
 =?utf-8?B?YWJwZHVKa2p5T3VQMC9iY1gwMFBoU3JIUVZFbEg0MFhxZkdqODJ5SzNjY0dw?=
 =?utf-8?B?SGVzTnZLSnFYOURacm5BUG83NzNCSzZQQXhYN1Ixd00zd3dhZ3JLY3RqVlZ5?=
 =?utf-8?B?Zm1WWWUzdksxY085Q0hFUVl0WUxOUk45YWZtRDJiMFEyNnJEU2V6blhpSnRT?=
 =?utf-8?B?bFF2QmtBOXdTbDRVeEVmQkljWXd5RVByNzJMb0JSb0JQTExaeEVPRE4rY01o?=
 =?utf-8?B?RHAzR2JkNWVBajZKTGVjQXpWeVQwRkJXNEhHVC9Sd01vdkpMQmZkUnlXaVJi?=
 =?utf-8?B?MHZ0dmRYakkrU2J1MFdFbXJNTlBOMVc4UzFRUnRhdHhKWEw2UThWM3pwZFFm?=
 =?utf-8?B?VEE1aDhLMlFXeXdxN212eEVyZDIwdHI2ckhlU3pUNHh6WG1MU2pVMXZtSDdI?=
 =?utf-8?B?dkYwS2FCZ2svNlZVS1Q2WFBaSit1M1M3Q0kvbkNsKzhjMXo5aFNub2dXajdj?=
 =?utf-8?B?MzZuMXRwU25qYmRUcWJTbVNFQVdJVDhXYTcvdGZFZ004RGF4Q3ZncytWQ0pD?=
 =?utf-8?B?ZjlPTGhMZ3V1K1hGWXFhbmgyQk5RSGlEeTJNR1E4SFNPcjRJN3NYWjk3ZnV1?=
 =?utf-8?B?SktmS2xGUzJYOVIyNFlnVlo4b1VqU0dRSWZCcmIyWmwxMzU2UEUza0ZDN3la?=
 =?utf-8?B?djJ4UmJwT2oyUC9FOXNPUUxBdmoyRGpma2syaVhMMjQ0YVFxTkNEejdZaVB5?=
 =?utf-8?B?YUJBSWhYZEs2WTdGWHRqak1kOGYxOGFTT1FSVDBFNjlsYnhncmZ6cHZTd3R6?=
 =?utf-8?B?bkwzUy9MdkNZNnRFdVB1L3FYUjNNSnp1d0sxMnozdThubmp4L20zb0dpVEVo?=
 =?utf-8?B?TXdxUVVUclBHNzcxa2poR1k1a1VKNWoxYjkxcUZkNkRocWcrRnMvYW5SZGcy?=
 =?utf-8?B?M0svS1g1V2Q2cW1pT28zdzdhQXhSYmt5a1R2cGtnSmpRa3lNbVJlWmdFNldP?=
 =?utf-8?B?VHl4QkdYYlZmbGlpNmdpdmZ1R1ZRc0syREVKbjlpVnNwNE5kWTZXdXd1VGVv?=
 =?utf-8?B?VGVvVEM2UWdBZjVLSGYvTSs3WDdSaFZSdEV5V3hrbGhxU3VRRG1nTzlxMW9T?=
 =?utf-8?B?RVJ3RndWYllNY0V3UUdsSFNlcS9VSXVFWWUrM04rbDY4bjlJT3hhaVcxVW5l?=
 =?utf-8?B?b05VMjlrSWwyaWFwemtZeUxacXVWVzZYK29na1dmM1pZTSt5YVJRUzM3UnhY?=
 =?utf-8?B?WVZld0NBZ1NmQXR4R3FyS2t3UEhrQklQckpvU2EwdnR4c1E4YUpJaW9ldFBQ?=
 =?utf-8?B?eDZJbWk4eXBnT3lPcnFxandXMzc5VkFEUDVtdWt4MktMazVvcldhZ0txalQx?=
 =?utf-8?B?ZGFyMG5CQXlkWHZIVjFuaXZublhKM0I1U211V0J0bVB1NVVCY0tIbUZIVE82?=
 =?utf-8?B?SEcyWEsyMXZ0Q1JwUk1zalQvWG4rSWUyK0pLZjRLWVdsclozUkZyTEpnYkJ4?=
 =?utf-8?B?YjBGSVQ3ajFXTHpST3NuM2owNjMzUThtZkNNQityNUZWdTZmZytqRk02N0Nm?=
 =?utf-8?B?WUxLeC9ZRm96TldCcHYxd1dMdjcwUDhmSWQwT1hzc0MrVHBlZUVkUTBVMzJC?=
 =?utf-8?Q?uARCcOpp3CoCm3GYsfAAMt3ys?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa2afc5-faf9-4920-043e-08dd3568c295
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:30:21.4853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltTK1IR6/qw4O+fYetFP1nDHeYYTFRNeLekG/09IcI2mtkLi2wuBQzbg1kad3KpNz2nLghTQH+Z+/3YjsRjeyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8593
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

From: Teo Hall <teo.hall@nxp.com>

This patch adds V2X container support on i.MX95.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Teo Hall <teo.hall@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 63 +++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 2afe9d38a0681862098a6566a873873f24069b88..54ae7721888dbc93fdaba8e5aedc52c4506bb1c1 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -231,45 +231,62 @@ static unsigned long get_boot_device_offset(void *dev, int dev_type)
 	return offset;
 }
 
-static int get_imageset_end(void *dev, int dev_type)
+static ulong get_imageset_end(void *dev, int dev_type)
 {
-	unsigned long offset1 = 0, offset2 = 0;
-	int value_container[2];
+	unsigned long offset[3] = {};
+	int value_container[3] = {};
 	u16 hdr_length;
 
-	offset1 = get_boot_device_offset(dev, dev_type);
-	offset2 = CONTAINER_HDR_ALIGNMENT + offset1;
+	offset[0] = get_boot_device_offset(dev, dev_type);
 
-	value_container[0] = get_dev_container_size(dev, dev_type, offset1, &hdr_length);
+	value_container[0] = get_dev_container_size(dev, dev_type, offset[0], &hdr_length);
 	if (value_container[0] < 0) {
 		printf("Parse seco container failed %d\n", value_container[0]);
-		return value_container[0];
+		return 0;
 	}
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	value_container[1] = get_dev_container_size(dev, dev_type, offset2, &hdr_length);
-	if (value_container[1] < 0) {
-		debug("Parse scu container failed %d, only seco container\n",
-		      value_container[1]);
-		/* return seco container total size */
-		return value_container[0] + offset1;
+	if (is_imx95()) {
+		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+
+		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length);
+		if (value_container[1] < 0) {
+			printf("Parse v2x container failed %d\n", value_container[1]);
+			return value_container[0] + offset[0]; /* return seco container total size */
+		}
+
+		debug("v2x container size 0x%x\n", value_container[1]);
+
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[1];
+	} else {
+		/* Skip offset[1] */
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
 	}
 
-	debug("scu container size 0x%x\n", value_container[1]);
+	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length);
+	if (value_container[2] < 0) {
+		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
+		if (is_imx95())
+			return value_container[1] + offset[1]; /* return seco + v2x container total size */
+		else
+			return value_container[0] + offset[0]; /* return seco container total size */
+	}
 
-	return value_container[1] + offset2;
+	debug("scu container size 0x%x\n", value_container[2]);
+
+	return value_container[2] + offset[2];
 }
 
 #ifdef CONFIG_SPL_SPI_LOAD
 unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(flash, QSPI_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from QSPI 0x%x\n", end);
+	printf("Load image from QSPI 0x%lx\n", end);
 
 	return end;
 }
@@ -279,12 +296,12 @@ unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						unsigned long raw_sect)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(mmc, MMC_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from MMC/SD 0x%x\n", end);
+	printf("Load image from MMC/SD 0x%lx\n", end);
 
 	return end / mmc->read_bl_len;
 }
@@ -312,12 +329,12 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 #ifdef CONFIG_SPL_NAND_SUPPORT
 uint32_t spl_nand_get_uboot_raw_page(void)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end((void *)NULL, NAND_DEV);
 	end = ROUND(end, SZ_16K);
 
-	printf("Load image from NAND 0x%x\n", end);
+	printf("Load image from NAND 0x%lx\n", end);
 
 	return end;
 }
@@ -326,7 +343,7 @@ uint32_t spl_nand_get_uboot_raw_page(void)
 #ifdef CONFIG_SPL_NOR_SUPPORT
 unsigned long spl_nor_get_uboot_base(void)
 {
-	int end;
+	ulong end;
 
 	/* Calculate the image set end,
 	 * if it is less than CFG_SYS_UBOOT_BASE(0x8281000),
@@ -339,7 +356,7 @@ unsigned long spl_nor_get_uboot_base(void)
 	else
 		end = ROUND(end, SZ_1K);
 
-	printf("Load image from NOR 0x%x\n", end);
+	printf("Load image from NOR 0x%lx\n", end);
 
 	return end;
 }

-- 
2.34.1

