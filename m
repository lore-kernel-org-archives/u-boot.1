Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73F1D206A4
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7099188D54;
	Wed, 16 Oct 2024 09:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R3D6sCPL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEC0688AFF; Wed, 16 Oct 2024 09:19:07 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B838388D3A
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orW3WJFzSJahHpOM35GOPxDFTbfB8l4wl/PecGggIQ8orrogPzw8DKR80jgj7tFBGnAvAknj2uQla1zcmag1WA8YGEL8/TYRHQHQA/232H4xqDcXtvBkHi9EPTUvA3ZS54hD6a+BwLTRHlGBLqNEaEyVlPXxBwuLq4U80PAZ2da6Nd0ppb0j/i3AjcN7Kuxe3RMloOA5OYuxix+wzmf7cXadRclmZCvcoY3rEMvUBpLEZzfVdfTbb2NKhJQOCm/3Y3YW+FNQ9xJitOkMNWLT732+/RkA90BtRAtCceFZK+adX4k6XHB1FPsaxc3WaZAdXaXPWQBRCAkq03BFraQzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kr4noaAidQZ9709/vlpN0BEP5WPzi5WKXBE/+s4GiM=;
 b=JcN53geacdzRhNOYkCusSrIpR2HGtP3T5gnY2cGCYtxcX6E51mOB5dORUQ24rfuYu2z64bzg9czCdF+rwUAY+H9kCjdaXo98IMwqyh6tz9IuY7tzhjFcaV7nubjp4re1wfM5uVS/GddrtBXE7EygUy8LrpZUYM+0bUXomNJMfwkDh6fppNj7nhVY59YCnB5AIOniF08MEt/F/adl9FxCt18oxGUV2tv2s2lv9OKE8ZtIxrRNoFQ2d8CmlX5LyvYbG/0JRQvmR3v2cGQQCS5z3u0swBMOII/TWpZM9ATp1JZ5yP6+jrjzp8rU0wFMyez+e0R1r8d+aYU3Qi6h2YGVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kr4noaAidQZ9709/vlpN0BEP5WPzi5WKXBE/+s4GiM=;
 b=R3D6sCPLcVHJVp7Z8BO+8gNz12NoX0aXltJCIvknmM05rvJTJuZA5PuMZ5qpClw9Sd6QDy3rVaEcXfXt6IMQjndP6B3VSMge+fLTx0yCZYDScDs59d1lY0Ol6df4ehIiyUYm/uqnzKWug4drqHMeI3dlFy6ki/zANFoNJvPGk1zvHilqqElMs4lHwcKDpPXMojD3+dFYhkWVQvFCJN2V7gBAl9N/zElFBB6rQ5dZz4alUoFZ7de8Hs8PC6XgEhgZWAIs9KJkxfj5L0jV6uoQQsPNSw1GxxdQ43d4URWgUFBWikCLEG441+yQSvpv4Vy1rHEdPBvNaY8zT9kf3xwRrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS4PR04MB9362.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 07:19:00 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:19:00 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:17:54 +0800
Subject: [PATCH 01/17] mailbox: add i.MX95 Messaging Unit (MU) driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-1-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Viorel Suman <viorel.suman@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS4PR04MB9362:EE_
X-MS-Office365-Filtering-Correlation-Id: 29391184-b26a-45df-66b8-08dcedb2ce5d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3FPRW1oYTVmL050dWZQWGdKUmtKUXhXUUVFUlNDSWtMVkVGV2pPVVdZeUw4?=
 =?utf-8?B?L0RRaW5VK2VXOXA3SmI2WkEwZ1ppRTEwb2duR3hwTkIxbVBRdlF6VTdnNGMy?=
 =?utf-8?B?WlF4MnQ5MjFMSDUvOGw3aDBMNStQQnE5R0NyNmlTT2lIOHBnd213SkRYdmxr?=
 =?utf-8?B?MWVpOFdyeUg5cDdtMU0zc3crNmxtc0k5b3dydHdZZ0NuYk42SGdzOW5oQ09i?=
 =?utf-8?B?Y1JoN2NZcTNjc21nT1VCY09OZEZSMDVqSi9vWEhyQ1RBenQrZGVFeWxsZDlH?=
 =?utf-8?B?RlFISmJub0x3b0FJVGxKZ1JtRjJmcVhwcXoyWVoxNkVibUpDRGNEbXZVdDhp?=
 =?utf-8?B?bGJoSXhRVmpjVGFoSER1SHRzbHZ0cm1acDVpZXRMNjhpdFlVYW9NaWgwUkZC?=
 =?utf-8?B?ZytucjZicnB3dFRwcjNBandScDFCZzA5T1YwSnp2WUg1Q3NTdGJRN3VyUUg1?=
 =?utf-8?B?eEdvb3VsdzJsUWZHdWYxSlJLNGppZWIyRkl2MGYyTzlBenIzVGVQYVZLOHpo?=
 =?utf-8?B?R1NPQlVlNlZIL3psamorSThOU3REanBjY3NoQWZSeDB5YitBMXQ0L0NKV0xY?=
 =?utf-8?B?Nm9ZZkQ2QXM4ZHU0cTJEZEkveWNEbW9XbXMwdmRzMWRXb01vdytDRWM3VG82?=
 =?utf-8?B?SVZjNTFCTkJwT3Jwakx3VjFzemN6Q0VnNWhqMDBFbWRMdG9heW8wUWRLc0lr?=
 =?utf-8?B?Vzhvdnc5a1BnMDVSdERHUUVia0ZhM2RhbFl0Nk53bjF2TWtnZzJGbDd3TVMz?=
 =?utf-8?B?YTFtTjZZNDlMbTNZSkd2N25LdXJZY0pwRjF4VjdOL2c0OE1wZFoxME9jTGI0?=
 =?utf-8?B?eFI1bWJRLzVGOENnb3czMis5b0phcjUwbktaMFZzcTRVcmJKVUxna0s3U0VH?=
 =?utf-8?B?Vmd1a1MxekR6WGlzcWtYaWg3N01KNExrOStycHZHUW9yY3ZSUXlSb1B1aUxk?=
 =?utf-8?B?dmpYZXVHaXp1Q1RJWXozY2NxUG1xTUVRRkhvTGhWNXlpeUtibm1hc3VNc2JZ?=
 =?utf-8?B?azg2OUdCWGN2czNBTVlZSkNiK0E2cjdQZk4zNXZXMUxFVEhmTWlrMXRRaU5w?=
 =?utf-8?B?K0NiYWtrMFRHVnpFZFA2VXk5SjBsNmgvRXFPUUJ3dEJNZ0VnNGRaUkVBbWpv?=
 =?utf-8?B?dHpuZ2x3TXhNRDVtK0wvWWQvWEJ3RG1rK2VweStRVnBoNXpTQTBKMEpOeHgx?=
 =?utf-8?B?TlZQOG9LWXU4RlBQMmJ2dVVDR1hMTWJkTnZLRndMUHZrVXBhcW5LRllhM0Jz?=
 =?utf-8?B?R2xNejlYdTVSajZtTVViU3NCR2NBU3dqZ25MTkM5S29BSHZLTDdQckswZk5L?=
 =?utf-8?B?eUt4V0JZdElzeTd2YUo3UzFJRnB5cVFudGI3SmpPM2R5NkJyTGNMbW9PTFMr?=
 =?utf-8?B?dW1FYlVDdGRMREdjMG1pSkptTkM5cUN5VE8yQjNZQVdoVG9RcVM1TkM5bmk1?=
 =?utf-8?B?QTBhWVp4WGtiTmVTTGJ6MjZMeS9mWDhwakliSDNVb2c1NDA4UjNjMzcrd1l1?=
 =?utf-8?B?V2tUQ1gxQ2d0aFR6RkllNVlNRHExWTE4aUJuUU13N2llcnZSdGNuSEdDdjZm?=
 =?utf-8?B?Nm9iUXl0L1F5NnZFc3BmWnFwNXpUSlYwNjhWNUFkaWlVR09ydGluVTUrRzc3?=
 =?utf-8?B?bm44YVEwOFRpU0luSm0wa0dncjJTSEpHeGUvdGdoNS9VZmFmUmVqSFpwZ0JB?=
 =?utf-8?B?L0t4WDdTTWx1UGt5YStZczhXU0dmOXhsV1ZXTHcyMXdzNjc5alM4dklsM01p?=
 =?utf-8?B?ZERIc3ZYNGhuZS83SWNSS0RSVC9uSUl3bWFBUzVpUXIwZ1Q5VFA2Sis2dVB2?=
 =?utf-8?B?Q3VqaWRxOWdpck5DTmRXUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3d6ZXl3MTVOMWF4dVV3eVMwQUxjbVl4QThOVlNnZDB1N011RlYzYUdWdVJ5?=
 =?utf-8?B?RnFIYmFjMnhUSFZsOExrV1l1WWdycHQ5bHhtQ2tmamtWV1RLU0xldzNUNCtk?=
 =?utf-8?B?UUVlR3orcXl5VW9xQ3hmcUM2MEthbkxqV0kvOHN1YnV2bUlmaE9wbnlrcWI4?=
 =?utf-8?B?K09nNTFKV0hwbm5SWmVpeTA5dGhYYmRjaTBscmhaWTg0U2c0ZEpDMmlpQldj?=
 =?utf-8?B?SmFDdFF3T0FndnI5aTMzMW9sbEJnMFVMVFcyVFViZ2p2MzdsUEJnNmdnNkht?=
 =?utf-8?B?RTFTOE5qUlkva2RIMG9Lb0dHN0RsMS9veEd3YldqZWZicU1DUmZGeUpld2Nr?=
 =?utf-8?B?eFNVMzZXRHIxZE01cVJSUTh6cWFXUTF1TVQ4OWhKSFJTNlFUbU1EL01EV2xG?=
 =?utf-8?B?dWhyTFJ4dkFLYlc5RWZCbUxtQTJZTkRoaDVFV3p4V1pNZG81czUvUXYyUmtl?=
 =?utf-8?B?Z3BueEpFQTRQOHA5Vld5STRuc0x1QTUwTUFhVUk3bkJoTmNMTm83TlJPbWIw?=
 =?utf-8?B?dmNXcmoyYWx1b09NK2V5M3pFcGtQaFJ3VDl6WG9adWJZNWhreDJObERiUUhJ?=
 =?utf-8?B?YjBtQWJUbGZhbUxFM04zNXNyS2JYZVUrVG9TWGlmampjRXpYN3o1a2oyYk9E?=
 =?utf-8?B?QlhZZmJQd29WT3ZNS1laaWxDMndVUUtBbFVHcU5XdlNvSTRZdk5SeENBQ2NE?=
 =?utf-8?B?Y0tiTi9yQ2owUExkeXg3Q256S0M5WE8zcWkyamtTVzdsVEdNdldUZHMyTlNT?=
 =?utf-8?B?bHRIQU1YWEdaREhBTXhvcjFrUzlveU0wUDFWaVNoZ1cyMitQSCtXN2ZXOW8w?=
 =?utf-8?B?V3dkYjF4UFhVMTB3blpaV2tHTkNWVWpxU0UvdytIYjM2S1hOZTFONjg3WkpG?=
 =?utf-8?B?K25kazczaW9WZFNvNzFadkxzaVRnckp4S3dMcjYyT1BTelY2dHh1T082V05J?=
 =?utf-8?B?R2g2ZytkVm9UUThWUEFOOEdGb1pWcGlKbG1yRDRLYlE2ODFUTlFuK2NReEI0?=
 =?utf-8?B?aDBPYXo0NWR2RWR2ZklLRWdoaWdQYnhxK0dsOUZEczVpWDIrRDNkU3k0TVJM?=
 =?utf-8?B?RDR4TFgwZCtwOUdnVGw0cENrbjE3V09BUXdqUkZsc3ZJZ2o1eEtiaEYwV0Nk?=
 =?utf-8?B?Uy9jUXhwSzc0WVMyWXlQbTMxMm0vR3RjVXlRbktUUnhtQjlnM1VpYXBKWGtF?=
 =?utf-8?B?QUsvVlVoWkpodXgxQkFkKzc4aElQS0trSFp0dURlc1FGOUZBbUVyNTRDbUhm?=
 =?utf-8?B?R3hhL2tpRjZiYi94TmRuK2NHM293NTlEQWVEdFNrdjRwSHBrUzYyTTNHREgx?=
 =?utf-8?B?RndSS1QrYTI0NEpKN05RMzJOMGIrRkFvZzhqQXU2WEJ0QzFJYWRzUWhHOFFr?=
 =?utf-8?B?RTJXZFpwcHNUaWNRcEk3K2lHL2FaeUFDWUhRUW9qNmVkK0I4dDFjM00xdFhF?=
 =?utf-8?B?NWNHaUh2aUtRaFZGUXpqY2IxKzVQZ2M3Mlo1UHpzY0JrOGh2dVIza3B0VEw1?=
 =?utf-8?B?MGZDZVVGQ0dWTFltWEhpbXBFZUFZSTVzbGRIdmZreXFUZWYxOTNKTUlKcmYy?=
 =?utf-8?B?akYrTGs5dytScU5NdURUN3Z0VWRQdS92amc4aVFINmJCZEVGQkZZajN1MWxu?=
 =?utf-8?B?Mm5hMXJPMEhSQlRwWXp4K1c1UHpUWVhRc3B4TkNRQWdVOUxiR2NMWllCZmZl?=
 =?utf-8?B?L2ZOdVd2ekJkOEpiVGJkdDkvU2sxL09ROElpU0VYNHBCaG1NTGFZdDhBSXpj?=
 =?utf-8?B?TE5mSlQrWmM4RndKZzl5bU8vZitsTmpZRElmbzU2bXZmbUpPSlJGVldNdUdG?=
 =?utf-8?B?RXdaTmF1QU5FYkorNnNRd2p6Q0UwM2c5SHlyVUg3RXV3QVBVWEVaU0h6VWFM?=
 =?utf-8?B?NnpJQThqTkl4MFRVekxQVDVKS3NjdXhnVjJCWU5IWVhrUklsTG51ME1uUDc4?=
 =?utf-8?B?dm5mUUxJZ1RkSkhZNW50MjJNc0gweHdFR0d2VEk4MlFoMFN6QXFzR01hUHRv?=
 =?utf-8?B?eStyTmRUL1U5cC9nTEtCYTFNODEvMU5wcTlRanhNME1VeTFLb2gzRGVQa0Vm?=
 =?utf-8?B?aEY4My95Vy85NXluUEFTWDNtZXRWWjlGdnBsOHh3ZjloekFMY3NpZURhbU95?=
 =?utf-8?Q?sOkcB0xKj+ec1n+iGmDCMslK1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29391184-b26a-45df-66b8-08dcedb2ce5d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:00.3564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shYInAB8+iR1keZS0IDkm8c76cHeppLON58vEnzKfu03L0vogikb+MQxz954CTx4zEqEI4Jj6fGHJRTL3TxwtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9362
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

i.MX95 Messaging Unit (MU) enables 2 processors on a chip to communicate
and coordinate by passing messages (e.g. frame information, event
notices and requests) through the MU interface. This patch provides a
driver for i.MX95 MU using the common mailbox framework. Currently, SCMI
exchanges on i.MX95 uses a mailbox transport with SMT format, and the
harware used is this MU.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/mailbox/Kconfig       |   7 +
 drivers/mailbox/Makefile      |   1 +
 drivers/mailbox/imx-mailbox.c | 417 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 425 insertions(+)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 67d5ac1a74228ccd82b2725c0bb745354d099948..4d9f004ebad7f57034a6cdae3bff9645fa0ee67d 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -21,6 +21,13 @@ config APPLE_MBOX
 	  such as the System Management Controller (SMC) and NVMe and this
 	  driver is required to get that functionality up and running.
 
+config IMX_MU_MBOX
+	bool "Enable i.MX MU MBOX support"
+	depends on DM_MAILBOX
+	help
+	  Enable support for i.MX Messaging Unit for communication with other
+	  processors on the SoC using mailbox interface
+
 config SANDBOX_MBOX
 	bool "Enable the sandbox mailbox test driver"
 	depends on DM_MAILBOX && SANDBOX
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 59e8d0de93cacfcbd9e10b0796a7abc53653715e..96a6adb709526325b30f849c7cc1125f55de314f 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_$(SPL_)DM_MAILBOX) += mailbox-uclass.o
 obj-$(CONFIG_APPLE_MBOX) += apple-mbox.o
+obj-$(CONFIG_IMX_MU_MBOX) += imx-mailbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox-test.o
 obj-$(CONFIG_STM32_IPCC) += stm32-ipcc.o
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
new file mode 100644
index 0000000000000000000000000000000000000000..584950b20d0afe0aac8a2b0c6146282292b43859
--- /dev/null
+++ b/drivers/mailbox/imx-mailbox.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2017-2023 NXP
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <mailbox-uclass.h>
+#include <linux/bitfield.h>
+#include <linux/bug.h>
+#include <linux/iopoll.h>
+#include <linux/compat.h>
+
+/* This driver only exposes the status bits to keep with the
+ * polling methodology of u-boot.
+ */
+DECLARE_GLOBAL_DATA_PTR;
+
+#define IMX_MU_CHANS		24
+
+#define IMX_MU_V2_PAR_OFF	0x4
+#define IMX_MU_V2_TR_MASK	GENMASK(7, 0)
+#define IMX_MU_V2_RR_MASK	GENMASK(15, 8)
+
+enum imx_mu_chan_type {
+	IMX_MU_TYPE_TX          = 0, /* Tx */
+	IMX_MU_TYPE_RX          = 1, /* Rx */
+	IMX_MU_TYPE_TXDB        = 2, /* Tx doorbell */
+	IMX_MU_TYPE_RXDB        = 3, /* Rx doorbell */
+	IMX_MU_TYPE_RST         = 4, /* Reset */
+	IMX_MU_TYPE_TXDB_V2     = 5, /* Tx doorbell with S/W ACK */
+};
+
+enum imx_mu_xcr {
+	IMX_MU_CR,
+	IMX_MU_GIER,
+	IMX_MU_GCR,
+	IMX_MU_TCR,
+	IMX_MU_RCR,
+	IMX_MU_xCR_MAX,
+};
+
+enum imx_mu_xsr {
+	IMX_MU_SR,
+	IMX_MU_GSR,
+	IMX_MU_TSR,
+	IMX_MU_RSR,
+	IMX_MU_xSR_MAX,
+};
+
+struct imx_mu_con_priv {
+	unsigned int		idx;
+	enum imx_mu_chan_type	type;
+	struct mbox_chan	*chan;
+};
+
+enum imx_mu_type {
+	IMX_MU_V1,
+	IMX_MU_V2 = BIT(1),
+	IMX_MU_V2_S4 = BIT(15),
+	IMX_MU_V2_IRQ = BIT(16),
+};
+
+struct imx_mu {
+	void __iomem *base;
+	const struct imx_mu_dcfg *dcfg;
+	u32 num_tr;
+	u32 num_rr;
+	/* use pointers to channel as a way to reserve channels */
+	struct mbox_chan *channels[IMX_MU_CHANS];
+	struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
+};
+
+struct imx_mu_dcfg {
+	int (*tx)(struct imx_mu *plat, struct imx_mu_con_priv *cp, const void *data);
+	int (*rx)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*rxdb)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*init)(struct imx_mu *plat);
+	int (*of_xlate)(struct mbox_chan *chan, struct ofnode_phandle_args *args);
+	enum imx_mu_type type;
+	u32	xTR;			/* Transmit Register0 */
+	u32	xRR;			/* Receive Register0 */
+	u32	xSR[IMX_MU_xSR_MAX];	/* Status Registers */
+	u32	xCR[IMX_MU_xCR_MAX];	/* Control Registers */
+};
+
+#define IMX_MU_xSR_GIPn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+#define IMX_MU_xSR_RFn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+#define IMX_MU_xSR_TEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+
+/* General Purpose Interrupt Enable */
+#define IMX_MU_xCR_GIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+/* Receive Interrupt Enable */
+#define IMX_MU_xCR_RIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+/* Transmit Interrupt Enable */
+#define IMX_MU_xCR_TIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+/* General Purpose Interrupt Request */
+#define IMX_MU_xCR_GIRn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(16 + (3 - (x))))
+/* MU reset */
+#define IMX_MU_xCR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(5))
+#define IMX_MU_xSR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(7))
+
+static void imx_mu_write(struct imx_mu *plat, u32 val, u32 offs)
+{
+	iowrite32(val, plat->base + offs);
+}
+
+static u32 imx_mu_read(struct imx_mu *plat, u32 offs)
+{
+	return ioread32(plat->base + offs);
+}
+
+static u32 imx_mu_xcr_rmw(struct imx_mu *plat, enum imx_mu_xcr type, u32 set, u32 clr)
+{
+	u32 val;
+
+	val = imx_mu_read(plat, plat->dcfg->xCR[type]);
+	val &= ~clr;
+	val |= set;
+	imx_mu_write(plat, val, plat->dcfg->xCR[type]);
+
+	return val;
+}
+
+/* check that the channel is open or owned by caller */
+static int imx_mu_check_channel(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	if (plat->channels[chan->id] != NULL) {
+		/* if reserved check that caller owns */
+		if (plat->channels[chan->id] == chan)
+			return 1; /* caller owns the channel */
+
+		return -EACCES;
+	}
+
+	return 0; /* channel empty */
+}
+
+static int imx_mu_chan_request(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp;
+	enum imx_mu_chan_type type;
+	int idx;
+
+	type = chan->id / 4;
+	idx = chan->id % 4;
+
+	if (imx_mu_check_channel(chan) < 0) /* check if channel already in use */
+		return -EPERM;
+
+	plat->channels[chan->id] = chan;
+	chan->con_priv = kcalloc(1, sizeof(struct imx_mu_con_priv), 0);
+	if (!chan->con_priv)
+		return -ENOMEM;
+	cp = chan->con_priv;
+	cp->idx = idx;
+	cp->type = type;
+	cp->chan = chan;
+
+	switch (type) {
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, IMX_MU_xCR_RIEn(plat->dcfg->type, idx), 0);
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, IMX_MU_xCR_GIEn(plat->dcfg->type, idx), 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int imx_mu_chan_free(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) <= 0) /* check that the channel is also not empty */
+		return -EINVAL;
+
+	/* if you own channel and  channel is NOT empty */
+	plat->channels[chan->id] = NULL;
+	switch (cp->type) {
+	case IMX_MU_TYPE_TX:
+		imx_mu_xcr_rmw(plat, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, 0, IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		break;
+	}
+
+	kfree(cp);
+
+	return 0;
+}
+
+static int imx_mu_send(struct mbox_chan *chan, const void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	return plat->dcfg->tx(plat, cp, data);
+}
+
+static int imx_mu_recv(struct mbox_chan *chan, void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+	u32 ctrl, val;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_RXDB:
+		/* check if GSR[GIRn] bit is set */
+		if (readx_poll_timeout(ioread32, plat->base + plat->dcfg->xSR[IMX_MU_GSR],
+		    val, val & BIT(cp->idx), 1000000) < 0)
+			return -EBUSY;
+
+		ctrl = imx_mu_read(plat, plat->dcfg->xCR[IMX_MU_GIER]);
+		val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+		val &= IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx) &
+			(ctrl & IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		dev_warn(chan->dev, "Unhandled channel type %d\n", cp->type);
+		return -EOPNOTSUPP;
+	};
+
+	if (val == IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx))
+		plat->dcfg->rxdb(plat, cp);
+
+	return 0;
+}
+
+static int imx_mu_of_to_plat(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE)
+		return -ENODEV;
+
+	plat->base = (struct mu_type *)addr;
+
+	return 0;
+}
+
+static int imx_mu_init_generic(struct imx_mu *plat)
+{
+	unsigned int i;
+	unsigned int val;
+
+	if (plat->num_rr > 4 || plat->num_tr > 4) {
+		WARN_ONCE(true, "%s not support TR/RR larger than 4\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	/* Set default MU configuration */
+	for (i = 0; i < IMX_MU_xCR_MAX; i++)
+		imx_mu_write(plat, 0, plat->dcfg->xCR[i]);
+
+	/* Clear any pending GIP */
+	val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+	imx_mu_write(plat, val, plat->dcfg->xSR[IMX_MU_GSR]);
+
+	/* Clear any pending RSR */
+	for (i = 0; i < plat->num_rr; i++)
+		imx_mu_read(plat, plat->dcfg->xRR + i * 4);
+
+	return 0;
+}
+
+static int imx_mu_generic_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	enum imx_mu_chan_type type;
+	int idx, cid;
+
+	if (args->args_count != 2) {
+		dev_err(chan->dev, "Invalid argument count %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	type = args->args[0]; /* channel type */
+	idx = args->args[1]; /* index */
+
+	cid = type * 4 + idx;
+	if (cid >= IMX_MU_CHANS) {
+		dev_err(chan->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n",
+			cid, type, idx);
+		return -EINVAL;
+	}
+
+	chan->id = cid;
+
+	return 0;
+}
+
+static int imx_mu_generic_tx(struct imx_mu *plat, struct imx_mu_con_priv *cp,
+			     const void *data)
+{
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+		imx_mu_xcr_rmw(plat, IMX_MU_GCR, IMX_MU_xCR_GIRn(plat->dcfg->type, cp->idx), 0);
+		break;
+	default:
+		dev_warn(cp->chan->dev, "Send data on wrong channel type: %d\n", cp->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int imx_mu_generic_rxdb(struct imx_mu *plat, struct imx_mu_con_priv *cp)
+{
+	imx_mu_write(plat, IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx),
+		     plat->dcfg->xSR[IMX_MU_GSR]);
+
+	return 0;
+}
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx95 = {
+	.tx	= imx_mu_generic_tx,
+	.rxdb	= imx_mu_generic_rxdb,
+	.init	= imx_mu_init_generic,
+	.of_xlate = imx_mu_generic_of_xlate,
+	.type	= IMX_MU_V2,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
+};
+
+static const struct udevice_id ids[] = {
+	{ .compatible = "fsl,imx95-mu", .data = (ulong)&imx_mu_cfg_imx95 },
+	{ }
+};
+
+int imx_mu_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	return plat->dcfg->of_xlate(chan, args);
+}
+
+struct mbox_ops imx_mu_ops = {
+	.of_xlate = imx_mu_of_xlate,
+	.request  = imx_mu_chan_request,
+	.rfree    = imx_mu_chan_free,
+	.send     = imx_mu_send,
+	.recv     = imx_mu_recv,
+};
+
+static void imx_mu_get_tr_rr(struct imx_mu *plat)
+{
+	u32 val;
+
+	if (plat->dcfg->type & IMX_MU_V2) {
+		val = imx_mu_read(plat, IMX_MU_V2_PAR_OFF);
+		plat->num_tr = FIELD_GET(IMX_MU_V2_TR_MASK, val);
+		plat->num_rr = FIELD_GET(IMX_MU_V2_RR_MASK, val);
+	} else {
+		plat->num_tr = 4;
+		plat->num_rr = 4;
+	}
+}
+
+static int imx_mu_probe(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	int ret;
+
+	debug("%s(dev=%p)\n", __func__, dev);
+
+	plat->dcfg = (void *)dev_get_driver_data(dev);
+
+	imx_mu_get_tr_rr(plat);
+
+	ret = plat->dcfg->init(plat);
+	if (ret) {
+		dev_err(dev, "Failed to init MU\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(imx_mu) = {
+	.name = "imx-mu",
+	.id = UCLASS_MAILBOX,
+	.of_match = ids,
+	.of_to_plat = imx_mu_of_to_plat,
+	.plat_auto = sizeof(struct imx_mu),
+	.probe = imx_mu_probe,
+	.ops = &imx_mu_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};

-- 
2.34.1

