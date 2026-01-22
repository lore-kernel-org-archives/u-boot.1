Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A272C44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09AD483946;
	Thu, 22 Jan 2026 00:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NrhW5lOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A946B83B32; Thu, 22 Jan 2026 00:51:23 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD7183AEE
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7pxkWwnYtsQLZ60wVo7DAIPcN4FgEqmB9gtQB3Z8syUdDTQVUpcLNNqlbS6HFl9OzoOHAG+3bBpBUCdtkmOy9slyCbK80Bw9Co3vJs4ogYPD+Nx9zTKiM2oqb+sCtbM3JKNNbpa6fAbCaXBOhUeoEdwoIn0qnVEbFJTw0iJdXN+06ZtF9kA08DvNJCnhh3h6nx42Soaru59rPJUZTrvhSFJ3gaRtpjoYH4agWbBbllMs/k8G2jwtTetB+sjaOT5qWNmPaQa6IjA64RwDZwpIX8BVWbfZpulxjYrT1ri6aM1zYTzBSOTtUBaoDvEoleUvnIN0Tx4OhyEabq9fqJc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjWOvQ2egx9CJXP89p2I+0lrd1PjXESs2sMB2D95etE=;
 b=BaH2T/uNsShKMeX44/7iziXJpfTtjwv6DYsInqoBKQRpmSqZdebvZP/XAGN1rmpntuu4edwviimP4cCEnp1BPdj3Ka9FF7t5e1mx324kmiFj/uGtiOI+Unbihn9CnpgyhqccXjEbiqG+FcaSoID4UoCVQWRkcYZlrWX63fu4unNW5aCN25eqW1rMrVSno7H1A0WhMpREwEU0fWWnliwoBdPuZFHPCVzYWFZS7OpivXS5DZk6uFWqDcz718y08BSqi8+5Q064I8tyq3Nt6PVh7S1iqxmbVgwh3uAhIRcJG3unR0OyMTD4bbvuGKinC9DRcw2WvC3WwkOk9bFnWfU7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjWOvQ2egx9CJXP89p2I+0lrd1PjXESs2sMB2D95etE=;
 b=NrhW5lOv5egWzGKHaVovPBH0GXw3fgvY8txyOs4W5ftUMNq5yJZw4ZV1QuCeTkPXF6YhFyOkYRStwdn38Ge4tc7tUNcZcZ2rZ6Ll0bwk4GcAAT5vsNsw/AytHg66HWu0dc3PzGXu4MwxqsM30rcfu7SMS66jLcTRX3wbBYHybAuGFi98FEWF/IO3fpE7RVNmnvaRojnhWnS8qLJNwW1QtJY+paWneezuJMBr5dKGLwjp18g/BRKWh53mbYd/ZR+zPKxDvsVwUNbONii9NSOhzcu/Bt2PV9ULv8/z2ilrIMfGRF59FHE9dVD9rB8U5RDFM3HV1BkM59Liob6MRgcNFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 23:51:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 23:51:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 22 Jan 2026 09:05:44 +0800
Subject: [PATCH 01/12] imx8mm_evk: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-imx-clean-v1-v1-1-a52a94b7e173@nxp.com>
References: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
In-Reply-To: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To PAWSPRMB0023.eurprd04.prod.outlook.com
 (2603:10a6:102:37e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: be50cc1a-cc55-4bbe-a887-08de5947f7d2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUp2KzFJZjEzcFFaNFhTQlN4TVA2Zi9QQzUwM2tSTVFCRU5vQ0lhUTZwcFo2?=
 =?utf-8?B?VmE1NTd0MFJBM0ZnU1FKOWdkYXRDMkxPcS80MkJFa2hEMVIrVm9mT1RrdURa?=
 =?utf-8?B?aFB2OThqNkppWWI5Y1BwRTdCUDVQOUJQVkZ6VGIwaUtkcEpXRzVHZVRFV2RP?=
 =?utf-8?B?Z1ovd3FjanBkdWRtaGhlSDhYZU51eDMwWGh6MHpITWVhZVFzMCttdU94cldS?=
 =?utf-8?B?T05jaXdtdFFLZlR4QmpuNGRkY2Q0NnRNc3U4STlOVTFpakkrUEVhMVJBNGVr?=
 =?utf-8?B?NVQ3RUpMeGpJSmlQcmFTK1JCbXMyalJQdU94U3RGWTIyQ3diOFBMNlQ5TmVv?=
 =?utf-8?B?RmExZzdWcXlvQ3RhekcwMjJQbWNzMUFoMThhd3pxVVl6UU90aXlKb3p1Z3FG?=
 =?utf-8?B?Z2gzK1ZhTkcvMmk3d1FkeG8zaVExVDlXSHd1WWZmeVh1czc4T1hiLy9KaWlm?=
 =?utf-8?B?VEp3bHhJVnVCOHl4Qzl0ZWZDZlVrOGVXbHluNm45WVhqS3NMS1RDMmR0NjJI?=
 =?utf-8?B?R05HV2NxUFAwQmliN3ozeDZCVXhLN0VlM3VtK25Jc2dQL09vU0FMZ2tqeEpk?=
 =?utf-8?B?MGQ4eXp1d0dnOFNTais0U2ZyM1paZk56V0lUbVA2WWZKT3JUSFBydGhHc0Fz?=
 =?utf-8?B?eFpBeDFSSUJUVEJkT1B2aEU5MHdaSVBZYytIRmZlaXlZNC80N3NiUGZJWW1o?=
 =?utf-8?B?Y0FBSTBLK0pBZHR4bzFENDJvYkZRV1JGandURDZoOW5WdkgrQkVKUWxOMHlU?=
 =?utf-8?B?YlJhc0JzUWlMalN3eThZcEVEdHcvb3ZzckhTOHNMd0RmUWlscWhUbUVSVHdo?=
 =?utf-8?B?aDVnd240YjBIdzdwaHo1SWlRL0JWNEg3S0JkclBKdEZ3elRvUHVzZm1SOXBp?=
 =?utf-8?B?QitUc1J0bUMwM0Fmc3RDT2ZnNnZ0MlByaXd6NWJ5cGwwSnNwSmNwdUczNjNs?=
 =?utf-8?B?VCs0RjFiMjVMaGdmaHMzUmtPU0VWSjBsZm9vcmlob0RzdFVFeFkwanY4SGxo?=
 =?utf-8?B?T3pVUkFIdC95YmhLcDlEZnVJelp1S29vQjU3dDlJd1lMRTBTN1dJejkyMW1E?=
 =?utf-8?B?bGZWZ0RJclhCNDN3RWluL3VWZlNkbVlOOUFacXQ1S0FZeG9JY3ZDZzI5ZGVa?=
 =?utf-8?B?VGxmdlJzbG15WU5PNGRFbmtOOUhUL2x4M2plWUZhOExFTFliOFByS2VHQ2xJ?=
 =?utf-8?B?VWxNZUNPZFd4b3lReUV4Z01JckUrblI0bko5alh1a3hlUEIwdkZQdEZDd0ZJ?=
 =?utf-8?B?MmJsWHMvMlRFN1FrdWxMTURVT2w1bUZKTkVBcklzb29vZ2NwUTlFbURvQWdY?=
 =?utf-8?B?bWJqTUFFUjd5ZlRlNjJvaEhua2I5UHBBY2ZYVXVuUWdIVFVBNGxFTUJwWk9W?=
 =?utf-8?B?N2t3dkYxUzYwd21vWWJHQjhyVWhyc0pOOTdvRjV2cm4rWWdSb3FGSEpxOXov?=
 =?utf-8?B?OXhQd20zUGZ1a3hhYlZXaWRmbkYwbFNOMVVWYmpzZTJPdWNuVWtVN00ybmdu?=
 =?utf-8?B?OFMyVTQwM3hzcU5kM2ttcW5pV1hLUkdzbDhYRnlsU1dTbVVGbEdzcnZJZ25O?=
 =?utf-8?B?blg0UjRSQTJLNVR0bm1oOVJTZEZkWjh0by96bUxpanhUMk9aUkVBRzE2RjBv?=
 =?utf-8?B?VHh1cmt2MDhybjRhZW15U3MyVS9QNzZRM0xnbHE1dmNzRHEzMEVaK1Y3RWU0?=
 =?utf-8?B?cHl0UXd2YnJMZSt1K3A3ZG9zenJDVXEvRno5UVhDQnhxMndPeStMZW44aGwr?=
 =?utf-8?B?aTdheUhvWGFyM2Z2QklIZjhpWVZYbyswY1VNWmwwRG9EMjZhNUg0ODVMamc2?=
 =?utf-8?B?bkoyN3NwK21LV3BjcHpnSXhjTG9QRzNLQUx5Q2hmV3FvcDZnZmhISkRZK1Rj?=
 =?utf-8?B?dUx4S3RrQXBhNEVXdlpJRzFxNVp0WHVGV2pseER0Z2RsbG5SMHRVeE9VRUc1?=
 =?utf-8?B?cVlSTXR1TExXanJ0MS8weFY0R0k3QmFUMjRwY1N5bkthN243ZXE1MS9sOUdY?=
 =?utf-8?B?bk9EQk9LYlBBZVp4UHdDbWJoS2MzM1NUZXBQR1dsRERGd3dra0dsckd6NmR5?=
 =?utf-8?B?b1JJcEQ1Vi9PREcyZ3E5MjNscDhzNnhTaVdReG81TGFadmQ0YTRFeFVzaFVM?=
 =?utf-8?B?U0RBRUlMUUxvK0tSVEtBdW45aEZIY0hXY0g2Ty9DWUduRW1pVVV4c3hYN3ht?=
 =?utf-8?Q?kBdDNbiTFwLIWFwM7ofr01g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2dhZmxHSDN3K1VmLzBJNmg4SWEwWEVHamd6eHZSMzBjOHRqTm5abER1U004?=
 =?utf-8?B?cW5ITmpzQ2NsdHAvdzR4OFM3ZGxIQjJPSU9pRVlnc1ZjcjI4aW92TXN6Si8r?=
 =?utf-8?B?OTl0NG5XMk1iOEZaeFFwTVVYbFR0a1V0Vk9nRFBZbG0vWmV5aERWYVk2cE5z?=
 =?utf-8?B?NUdJaEpkbjdaODJlRkJ0R3FLdlB4REFZdUp5cjZKWXptSk1XVFdUeHFzaUlX?=
 =?utf-8?B?VUppVldTRm14MXJmcHV1dlNXdlg1VkVWVlhZVFhkS2NIQ25oUWtKditrOWMy?=
 =?utf-8?B?REN1SGEyZ0RLK2tzN3cybHRteTRxeGJLWFVvVkttQy8wN2Rtb0JQdkZGY3ZW?=
 =?utf-8?B?SGwrR3VRYTlmYW5OdG9SUm1yTHE1Zkg4YzltbkdwMlZTWDA0bk1aM1lFV0VK?=
 =?utf-8?B?bkwrbXVuWUVkcWROaTJ0VEV3U0cwcTJGSVhBb0ljaGMrbFYzSjMzYXo1VWJ2?=
 =?utf-8?B?ci96VnVPZTVDdndLSzc2VG53TGRHQ2ZFKzY5SXJ3T29PNDZmclBrWHRXdFR2?=
 =?utf-8?B?ZmJiTXAzSk9oUnlxRmZPR2REQnNIdEN6eGszMndrMVhHcGpEK0FrV3FKa1B1?=
 =?utf-8?B?Z3dlNko1cER4ZjZZSFNKT29FdGpoWWM2dHZhaGVVekhtQTIyYmxYa08wNDhq?=
 =?utf-8?B?M2w4OTZqNE43ckRyT0E0U3JxNmwvalliZEZwZ1hqenI4d3Bzaml4eTdiSlZJ?=
 =?utf-8?B?U0xOa1RkM3J2S3E5d2ZmUFNhZ1JGM21hVnFROXJ5bmd6eU0xS0NsazhLaEVT?=
 =?utf-8?B?WHJxUGUvUnpPSGU4Zmp3cDBrK3c4a2N1TFpoMm84SnFGbWRiTkhyTWdWeWsw?=
 =?utf-8?B?ZFJmb1ExZE1tSXI3dmxrbnRybXZFMFFaT3F3MnFiUElwc0FEd3NkWUsrQUZu?=
 =?utf-8?B?RzVuYXBERUZteFFMdGVpd2QxTXBubENkVFcwTGl2ZFBJU3hRcVg5djhhVmFy?=
 =?utf-8?B?and0MFlqbkZJM3ByK0did0RQMWxndmdHeXdSSHRaSHZiTTl0aU5tRkFJMGZp?=
 =?utf-8?B?ZjZTQlFYTHBSVHp0ZExGOWNsbStwNG1Cc2xmZDBSNTdPS3FSLzRrY2dVVk5w?=
 =?utf-8?B?eml5ckgzTS9MblRvaE9vTlRSREdZU0J5RkVxNTd5Z0lhV2lQQmU5WU0zWXZ5?=
 =?utf-8?B?ZVh3UDlrWWc3ZXpjYmZDNEFOOWxyTU16bUE0dThEVFdodlVneTROWndZWm1q?=
 =?utf-8?B?ZURSdWtWSUhOZ28yRkZYekh2UTV2YjJic2VBM0U5aXRQSXdOY0JlYUZZRENB?=
 =?utf-8?B?cGNDeTl1UjZKL05CYjhpNnZwd2EwSVkxRGNuZm1LS3lxY0Rob2VPVnJLTGl4?=
 =?utf-8?B?NmFGcTBSZnBpQXkzOTdoWnFVa3o0dTFuV0tFemhCd1pXQnR4VWNKNWNZUWhl?=
 =?utf-8?B?WWxVaTBrcVphRXFSY2o1WGd5S3E1U3dKVnNmY3AvSjZ2TkFtelcwbnhveCtQ?=
 =?utf-8?B?TkEvVGw3TVI5SGRxWGhqMklBSXNmZmtFYVhoQ0p0cEpBT3F3Lzg3dVd2SkY5?=
 =?utf-8?B?NVcrQnVNczZwOWY4UkpnU1FoNWcvZWN0WFNXRjlWVFB5SWhDZkFGMVkyd2tV?=
 =?utf-8?B?RDBSRlliWm5YSzg3eTZNRVlaZmNRcTZGZ0RMQk9WcVBzVVdBNXZCbGVORjJN?=
 =?utf-8?B?Q3dmV1BuZ2w5UGFYbVhMT0VMSjkxaVBIcWgvMnZ3Y3Y5cWkwRkY1WlMyQXI0?=
 =?utf-8?B?K1FQZTQ1eTlqYXQvZHhNNmJLaXJyRkcrYThyOTFjbHdhc1NJamNpdmN1K21U?=
 =?utf-8?B?VFZFS0diazRnWG5LcGlNOXd2MFZwV2xwZ3pjaVZsczE0OTRVUWJ0OFlneFdk?=
 =?utf-8?B?SWtrRzBBMjFoMHV1a3VSRVhmb3VDdzROZHJrNmxOWWVGQ0xqUTFNbml5NUwy?=
 =?utf-8?B?MzhLbi9tSmhyTGJzUG5mTXUxbCsxQUk1K2Q5dHR0V0p4Q3ByR2ZBSWlyMUx5?=
 =?utf-8?B?SDVBaDJIVVR0M0NEVHIrMFVDdDhVd01XQ0dGcDZsQ09VYktVM1hkNm9DQ1J4?=
 =?utf-8?B?aHJWdW9iR0Q4NWRodTkzR3pudnMyYkpjTGFLY1krcWRjUTZtaDlqV3hQekd6?=
 =?utf-8?B?T1VLeGdGNURPK2VtSnFhSEN5enZ5NEM5ZmxjRnIyZlJ1U21ldEc1azI1aGZj?=
 =?utf-8?B?cXZOaXBnL3hnOTJGZGU3UEFqSTNCcGhOS2FySUhMcnNQOWptelI3T1gvanlk?=
 =?utf-8?B?Y2RhUGlXbTlwOVdEYWdRTlYwSkZ1Y2RpL0dBUHE3ZkJaN3d0UHgvVjV1bWl3?=
 =?utf-8?B?RldHNFl4blVmRy9rMTZKMExrVmU5NEJ0RjJyK1o5M1o2YjlLSWt5UnlmQ3Jw?=
 =?utf-8?B?QTlPSVQ3L3FOQjIyaVN4MkJJL1dIQlExWVdWWUcwTCtOQmJueWdlUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be50cc1a-cc55-4bbe-a887-08de5947f7d2
X-MS-Exchange-CrossTenant-AuthSource: PAWSPRMB0023.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 23:51:19.6845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzfuwMsGUgbtfeDYp6obUJ8rq9NxBpT7qoI1WiTxeJ/HtbNCHtDo7JaPQRIGzqGEbNJkkr/HCbahhiOwC1M+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
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

From: Peng Fan <peng.fan@nxp.com>

There is no user of "gd", so drop DECLARE_GLOBAL_DATA_PTR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mm_evk/imx8mm_evk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/freescale/imx8mm_evk/imx8mm_evk.c b/board/freescale/imx8mm_evk/imx8mm_evk.c
index ecc20768cb5..a8c1ef287e5 100644
--- a/board/freescale/imx8mm_evk/imx8mm_evk.c
+++ b/board/freescale/imx8mm_evk/imx8mm_evk.c
@@ -9,14 +9,11 @@
 #include <init.h>
 #include <miiphy.h>
 #include <netdev.h>
-#include <asm/global_data.h>
 
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
 	EFI_GUID(0xead2005e, 0x7780, 0x400b, 0x93, 0x48, \

-- 
2.51.0

