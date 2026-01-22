Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD3EC44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6107B83A3B;
	Thu, 22 Jan 2026 00:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Xe59ylKB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0DB180077; Thu, 22 Jan 2026 00:51:20 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C7680077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUbxHAPVRuOz/ZF9MgZS80ccYtzzK6UhYD9cOngs/Rjz/fGKiQbrPZAiS3hGFmLLUPWdxNRdMCmSG4QMMdnNW6xIQiaVoUkiBCwZybtgEyAcb6+tX7d4L7ju5yie/lhciw6YCvMvbsueQ6ul8LLdsa+t0cDGPDg0KaYGpT84nQoZh5DWF1veJUF+I3mbVFjXPmSMKDdXDqvqILhl56LsAsfLvJeetCPO9VSQ35IwbpYGfOIwnhWlExxYTzwdppWiVTF7BFi+YySUFRxDeJeTw2b37wqK2sX83ovwKWYm7h9bH0WunQdiIl5mlG03jekgRXD/DWp3PRvuAB4skhVYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYaV/2J7HNXwwGKLAWGVScKo7iZbuCMomXE4grc7SRc=;
 b=pxMSylHmCxnNyQtmD7NbUzxlorGx+T7FDcYwjIK0vLUc6k6QBNabx3noJVBAnHBuNwAwm3dzQ5qIFNo/9ZlIQnoQ/Eq80mwD8FJCU14oVCbRuvoB/ZK6ju9LcZMaLt0eu64+qxpkWmomeOdSxdu4LpZtkIrjZFqj6/ifeS7K3fMmf9/IZmfLOHAuEKX+wnad4fSWHI6YOT3miPSk7y1WHNJKWgpm6qk84TaiJ/8dF1pUMVi1T6fwszYddxS95gjcX8h4+BoHR7tibB7ebr17cO7lopoGc8jilx1LHKe3+cNUUYIgUqx4iSAefuFOfaTexRT+WcfhT4xzwXA9f3/ubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYaV/2J7HNXwwGKLAWGVScKo7iZbuCMomXE4grc7SRc=;
 b=Xe59ylKB5GD6FFeE2rZnWf02EspnKn7zhFgG2jLzNVlEnYgmU9huS6X2MDql/QEH0vZAlpXlnqWRA6MQZ4CTgWeHKVhIFB0cGKl7cEhW6FSZjwr1aC7BWK7YuHwcodqFfdn4bFfAG25bQjGR2Rlb+REcusSv8JcGEDkz7QdlRuH4ST83LzWkV6QVwYKtWPQXaInM0ht8Rsp7HJX3+JKtr32IfzmhQBsKVIbFX/6kMGWAnE8YPRojGJbmcGP4lXu45JKUtKcN7r9Ez+cx46ZzyvxUBxFFloAgG3t26PN7l3Wlu3uW4CFDEZv3hkmSwoQO4UR3rAvlqecsBTTd1eSUFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 23:51:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 23:51:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/12] imx8m/8ulp/93-frdm: board cleanup
Date: Thu, 22 Jan 2026 09:05:43 +0800
Message-Id: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOd3cWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0NL3czcCt3knNTEPN0yQ90UY4skA1Mzi0QLA1MloJaCotS0zAqwcdG
 xtbUA8U5tnl4AAAA=
X-Change-ID: 20260119-imx-clean-v1-d38b0568a805
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
X-MS-Office365-Filtering-Correlation-Id: 82be2bcb-e396-42e2-a05f-08de5947f5c2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEkxb2VibWpwQkRNaUdVQlRWQ2xVYTBmL2VGVVVIaE84aWFTWjFhQlAyayt0?=
 =?utf-8?B?QXB2Qzhub01GQW5GaThuRmYxc0dmcE9LbVU0bXZPYlBIenB2RlVCaG5Fa0tC?=
 =?utf-8?B?NlFseUwzcUFIcTBLaGhhLzdzWU1wNkUzbUs2MHpRRUxNKzIvb1hJRXh1NlBL?=
 =?utf-8?B?M24zUDAxYzhyNnlpbUJQUThvcDhkQ2o2cythK2tCTkZ2MWhSeGdaTllBUUwx?=
 =?utf-8?B?YzZGakd3NTFrVEtSbzZSN1N5MURWSjVNUWVJd2dHZUdVbHN1OXpmKy8zMW9v?=
 =?utf-8?B?aGsxNDJSOTNmN0lGcU9LZUZvL0lISGhJclJuN0grMjlNSjY0MGg5U3lockhW?=
 =?utf-8?B?ZmhNTnFZUWM1dzhNUmZrVE4vS1FzeFNDNkptcE1tNEUzVHhYeEVZMTJjQ2R4?=
 =?utf-8?B?eFZ0cmxMRzR5UVhUTk9xRVQvWXFWU1F4K0hGZXBGTDNuVnhPVHIxYVRjMWxx?=
 =?utf-8?B?cHFwaGtEemtjNFo4djBTQ1ZRTHJPRVJIOVNtOWtRNHBWRlkrK0J4Nkl2cHZi?=
 =?utf-8?B?VHd5a1dOS1cxcG82cE0yU1RoRkgzTm5idVVoT0NNNndzdi9HbkNSazZFU0xW?=
 =?utf-8?B?MlZUb2swSDM2cmJVY0QrWGFQZG0vSmlMcEdIamFLV3YvSUtpQlV5eVMzZmdE?=
 =?utf-8?B?Qy9aQVVucTVNdTV4RU9OOS94c3JnTSt5cXZybTZFRGczQzZ0RmV2VDRockY1?=
 =?utf-8?B?bjJZWXhGU21UNjdPSFpjVTZyRGlMWEc2L1NKVnRhOWptbjkxeG9EcWtVMGlF?=
 =?utf-8?B?QTd6amNRMzA5QVppV0p6dUZsdy9MeUFTc28rd2ZvdElrQ3lzMTJ6UWRoblEz?=
 =?utf-8?B?dnd1U0RlandPUW1RZytZUVZDU21FUGoxVWZLQlhOb3pkeTVCQ0xpOVlGSmkr?=
 =?utf-8?B?UVkwN3cxalV0akpEVTVWTEhpK1RKTDBSa3d0NDk4K1lBWXo4UEgzOHlCRmcr?=
 =?utf-8?B?bDlaeVZqMEg0b1FjT1pBR0JIa2xNZnVrOXhZVEU3OGtuSk9SQnpKRzl2WTUv?=
 =?utf-8?B?bnovdVpNNUNqS3B4bjBVemMxb0N6NU9PY1lPK0dUQ2xsYTdtRjFWVVIwQS9V?=
 =?utf-8?B?RE1hWk55VnVSZjE5ZFlqcFdYckN6bFJ0UWdBWUsyYmdzbmVGUkF3T3BLam93?=
 =?utf-8?B?cjhHTFlTMzgyYjA5SHRlcnJzRGxVVFJnR1ZQREpLbEVUQkF4dVUwdVRaRHNw?=
 =?utf-8?B?TVBRaTM2cXpFd0lTa3l2VnhqSUduWnIwc2d2VlB2RDM5Mk1zdWRFZE9ROXI5?=
 =?utf-8?B?TDZWaTdVQmIxNG5zcm9OcU5GN2JSQVVCdGtuTWZKV1cvZStpemZEK3hqWlZo?=
 =?utf-8?B?R216a3lRMWh3dzNHUlQxNVFHMmgzVWlFSTZseUs0RjBLZmljdmtLUjZvL00x?=
 =?utf-8?B?em9jYnQzSTVFYkJnbEp4enNVSWoyYzVVRXJDcDlnRXpHWFMya1hPR1JudU9M?=
 =?utf-8?B?bjR3eFk1SG9aaTdIWTlRdXBVc2NyZ3JvellxYWFhQ0Z4ZVFwcGwvT05xQUhN?=
 =?utf-8?B?SlA1bDZiaWJ4cGtybzlQTy9XdDVXSXFHMHVxQ0xMV0hwbVJSZWQrVEhqeDFy?=
 =?utf-8?B?MWpibEVCcUxQb2M1K2RwVkpoK1dKZnhiaWhjZmRWRmN2OEFtK2pHSkt5TTQ5?=
 =?utf-8?B?SlJ1WG5rd1RUaDhUeTVWSlU4YXVTUjhtMW9lNTRXaERNSGxubG9TM0RJNjda?=
 =?utf-8?B?NlZaUFB4ODR6bjI4T0Z2U0FaNVFhVi9tNHI3MVE1a21Fdm5OVEVEa2dnRk4r?=
 =?utf-8?B?RERwZzhCVWRURDFKMEtPdG9rV0Y0Tjdtdlh1bWZGcUxoN3lhampXNXBTWDFZ?=
 =?utf-8?B?dU1BOUFuZ284WmZ5K2N1aHB3VzRwRjlWc0FpQWJndWt6aDVhd2NPaXpzUGpQ?=
 =?utf-8?B?WVdTekUrdE9GZCt1Mi9ySkNvUXdLa3hpTzhRVUl2eXNkMWJyN2NFRnVnV1BH?=
 =?utf-8?B?RFpLbDlITUlFN0F1VEU3VFV4RmtWNWNLK0lDSUhLcmc1QVNJZ0sxb251ZG1F?=
 =?utf-8?B?NDRsd1RmTWdmN3E1UnlJcTNiUkFVK3UvZXR6czVZcHF2NW1lTVJ1UGtFd2dW?=
 =?utf-8?B?WkVZTHovZENISjl5RzNrS0FzajV4amFFdk5yVGpONklUL2k2ai9NcnE1eHBV?=
 =?utf-8?B?Qi8xbmZ1Y3ZxbUxEYlRJVWNZVWtIY0k4RG5vaCtDb1VBWUFFUU5RbEt5d3d2?=
 =?utf-8?Q?LHy+Gh5nmJQZv97uzSs/P4s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ay9jZHlsZ2d4THlqRlkwN2t0ejdJU2VqdC9EUWY0Tks5ZkxTdHhFV25oVEsx?=
 =?utf-8?B?aHc2S1pLYkxRMHl1QldWeERvbXl1bEY3bGJBYWF6SThjS2lxaDE0S3NnbGdy?=
 =?utf-8?B?dGJ1QUlYL3JXMDQvUzBGdUZJZmZkckwwbkZuNE1zb1AyTUFhUG1FT2dtMmd0?=
 =?utf-8?B?a1lhR0syNUVqc0VkcWpMTjE1YnVsYW1vQlRWNTFBNFR4MjMxUnY3aGNMZnUx?=
 =?utf-8?B?ZmtUdUVWQVNOanNreEZqd2psODVPSEhLNzZROURiNzdZam5oYTVZZ2t2ZlVL?=
 =?utf-8?B?SXBRSzZla3JXVGlGRkRwb2FKT3BheXlUVW9ab01Qb3hkZk5EZml5MFIwU2xx?=
 =?utf-8?B?NDM0Q3k3OFY4MWo4SmJ5ODd3b0J2MGdXcHA0K3JOYy9WVnpML1dzNFJvNDN4?=
 =?utf-8?B?VXRzbnF4ZEptUVVlVGVPMHM2d3NNOTM0TW9NQlBuYUNLa0tWN0R4MkUxSEVG?=
 =?utf-8?B?bGQ1eE15NWJtL0syK0RTSmlJSzVwTmxTVGUxYmxiNGVVOUViRE1lOXloVENv?=
 =?utf-8?B?WnNVSHhycURITzBNZkhDNXBzc1pLdkQwb1hJUXJxeTgzYjBjOHE5Y243cUpz?=
 =?utf-8?B?OFdyNGlLZnYrdE55VFNrc0pVekVZOUttYVFJTkM5QmRSNkFRS2ZhSmN6RzZy?=
 =?utf-8?B?WkhxQ0VldHBldXVnN2RqOU5DOWllYzdHN3FicVhyVHFiOGh3V0RleFl6VUhI?=
 =?utf-8?B?Zm9TU1lPWFEyK3Y3SWFENlpMWkhvcThsZlRZMFFjNkppa2JiQ0I0eUhNeVgy?=
 =?utf-8?B?SncwLzJHWk9BYXFXZDNzNnJJcDY4dUVUQmNXcXgrWW0ra1NSekc5NGpEaUVT?=
 =?utf-8?B?Q0VoUDhUS3ZJWDg5Z2lrWWFHS21ablBCSWkyeUNIU1p3VUtLRlcyZWpCMk1o?=
 =?utf-8?B?M1BlMkluY0dRazZORjJIYXlsYWhpOFpLc0h3bEdURlNXQk5tSCtISHM0Umxh?=
 =?utf-8?B?eStKYU1YSUNWVXRjV0FtWGxqRFROMUtLekRLNVFjRzZPbWwxT0pveXNrU1pq?=
 =?utf-8?B?LzhlN3RQU2FvcVVZc3h5eDM3U1BvWXpRQlBQalVoMklURjA5TjZ2b0JDNnp6?=
 =?utf-8?B?Q1hYejZYdVc2aENkNjhWWlo3c2xKbHhUMDBhMUNBVGtiSk12VklvYyt0cS9v?=
 =?utf-8?B?WXBlK0JBQWxDWjVZNTZidHBQMU5aUllWdEJDVWVoNThtRWdWOVZ6TDA1RU4x?=
 =?utf-8?B?aUFSNGVPMWhVa1d1TWdUL2VTeHNtTmsxUGNYQjV4M0NlbEN6QW1SVy9kekRq?=
 =?utf-8?B?bXJXZXYxcGJLbG00UWp6TDd5azh0Q1lacXQxZEhuM3pjMGI3YW1lT2NyZXJN?=
 =?utf-8?B?bEhvalY1cnRjUy8xU0kyYVdDSHhraStYdmYwY0J1QzNQM0R1ckN4T0hRK2Yw?=
 =?utf-8?B?eWtGMVZZcHRYMDFCY0x2Z3dqTmdTdHdxVkxQQ3dyM1dSMk5WTitjaTB2cXFF?=
 =?utf-8?B?QytpUDgyVnYzaXBaUDhtUWc0OVpQUlRnN3h0QXNzOXRVbVFWQzlaTkpIakRC?=
 =?utf-8?B?eFJyd3BkbnJRUWE0YjF3cGJ1aTdJTGR1MUZDVG1MRE9LeEZpRythTVFCQmhD?=
 =?utf-8?B?WTFPZXdiSFZTLzNNT2gvK0V4d0FQUnQ2QVhvWnFVT1piS3hLak44cHpUYlpm?=
 =?utf-8?B?TGlwbFgwK1lxOHlSWFh0TTIwd0pIM0pYWnFOMHZQVDduS241YXkybkEzSHhD?=
 =?utf-8?B?cWhxaUZnOXl3bUlDOHVWMnhZNWNkVmNnVDdoTjM4V0tZdUFweDR1enBtK1l6?=
 =?utf-8?B?YmkwMDhaalNhZWJEOThRUm5KVThkMm9aS3BSeDVGZ2Q1NDdMbXhGekt2dXYv?=
 =?utf-8?B?ZFhYR2x4LzlLVzhoa0VyVGZDZnU5TVFuSHM5NHZDR0lOVCsxZTJZOGNrUFNH?=
 =?utf-8?B?TStMNFlMUWZLenVWaHdyZ3QvaVhocGNBSC8vekVBaXNEYyt5YU9XSkVSWTlj?=
 =?utf-8?B?V2h4ZjAwQTF0czNvdFdvU2c5OUovOCtKTXlXWlNsNVA0Qzh1dWt3UC83Umgr?=
 =?utf-8?B?NFpIRi9aSzh5NHZMemdEcm9rdkpDblZIVDVwY2RObGl0enFtZ2p6cU5IemhV?=
 =?utf-8?B?S0pyL2p4Vnh6L1dZcGtYRlB3TjZIcWR4T2lYU0dQRWdmSmF4M3l5K2o5RU5W?=
 =?utf-8?B?MWlWV1JNMHNOV2UrT2J3RXY2MEFXWlF1OWZINExuTk55UHRoN2tXOHpWelNu?=
 =?utf-8?B?Y2RpUmV2ZnVFQ1l6aWxQQmxwbFZCcElTQjgzTTlkUWljOU9sNVRad3ZBeWxu?=
 =?utf-8?B?dW4vWnJ0K3dTV0FZckNQK2lnZWNFblJsNnBBNHRSTEpJMEtiMFBFOCtzSGYy?=
 =?utf-8?B?N0w2ODFMTXpBaUdMOXF3V0FZbjRYSUh3YmpadDZrUFhPeWZLWnNFZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82be2bcb-e396-42e2-a05f-08de5947f5c2
X-MS-Exchange-CrossTenant-AuthSource: PAWSPRMB0023.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 23:51:14.4926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+3YQw9jqRhTQJLtGj/gWDqfpea5NL6xY2B7o/DoK4Vo6Q0X5rlU7BWwPjrbJUU4fbawL/ZUhE+gF2X79VEtjg==
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

The 2nd batch to do some cleanup. The patchset is mainly to cleanup
i.MX8M/ULP-EVK board code and sort the included header files.

While at here when reviewing the code, the i.MX93 FRDM EFI GUID
is copied from i.MX93-EVK which is wrong, so updated it.

For patches to sort the header, I follow such rules to sort the header,
same as the last patchset to clean i.MX9:
*.h [generic header]
asm/*.h
asm/arch/*.h
asm/mach-imx/*.h

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/29059

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (12):
      imx8mm_evk: Drop DECLARE_GLOBAL_DATA_PTR
      imx8mp_evk: spl: Drop i2c_pad_info1
      imx8mp_evk: spl: Drop DECLARE_GLOBAL_DATA_PTR
      imx8mp_evk: Cleanup headers
      imx8mn_evk: spl: Drop DECLARE_GLOBAL_DATA_PTR
      imx8mn_evk: Cleanup headers
      imx8ulp_evk: Drop DECLARE_GLOBAL_DATA_PTR
      imx8ulp_evk: Drop board_phy_config
      imx8ulp_evk: Cleanup headers
      imx8mq_evk: spl: Drop DECLARE_GLOBAL_DATA_PTR
      imx93_frdm: Drop DECLARE_GLOBAL_DATA_PTR
      imx93_frdm: Update IMX_BOOT_IMAGE_GUID

 board/freescale/imx8mm_evk/imx8mm_evk.c   |  3 ---
 board/freescale/imx8mn_evk/imx8mn_evk.c   |  4 ++--
 board/freescale/imx8mn_evk/spl.c          | 22 ++++------------------
 board/freescale/imx8mp_evk/imx8mp_evk.c   |  2 +-
 board/freescale/imx8mp_evk/spl.c          | 30 +++---------------------------
 board/freescale/imx8mq_evk/spl.c          |  3 ---
 board/freescale/imx8ulp_evk/imx8ulp_evk.c | 17 ++---------------
 board/freescale/imx8ulp_evk/spl.c         | 12 +-----------
 board/freescale/imx93_frdm/imx93_frdm.c   |  7 ++-----
 9 files changed, 15 insertions(+), 85 deletions(-)
---
base-commit: 6b2d05748cf3cd6ba417a96c00602b0122e10af6
change-id: 20260119-imx-clean-v1-d38b0568a805

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

