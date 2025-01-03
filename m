Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A017E7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E1C7803F5;
	Fri,  3 Jan 2025 07:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wKqozjgk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8339B8042F; Fri,  3 Jan 2025 07:46:54 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6572A8056B
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgjJVpyjsmYEtbDOt76NDLIxm5c3Y8zSyI3Nfh3sbg0iFyzSprEuLhFY75qBG5Wl22ugkq3l7R7lFCcVoHSCjOgRUc4mVb0loQNTOb0l9lflc5OtO3PLF+fm5ghy0tBPMkRDIRRe2eiO/qsEb/OseQcYCuT41W7i4MncOgKBvIfvbhue7QFTu0ZjDMC34Evin+kB6vBIv6iUum27Vs0YzYUo+sKxpFaF3jmAgEdJEbA+Hzt0Sv3VqMKOnwudLs46CcbBwURS08w651H1SsirN2w9cIwOZ6ocaAaRnZL0ZaYe1+Pk7kU2E1E8E/azS0jBeGeTXuM3avv8/VBPqSr1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP3RcSByZBJzopUI0rB2AJ13LqruwSIYaRlmxQkqcHk=;
 b=lnV5dLD+ki+aQAsmramZzsiMyp209SpRrhiCP3kVy8CGt+ZdlPONXsAg8jVxVWDQZIBCwDvRjUf/8Bd95Vb7+qmvzqbwsYNDjqzFgsgrettWERHHKZVLfKrleEfhVZNAasvKvBs8NjLQyy9kNbUNA/EiwRy1jcP+pgWEu1YuQi03onhuN6fEqPt1TKXzKVqrw7hqqD4Vpz98VNmztk/fqvHOv3qcakSfAsvZwFnnnJR5uez3pmbfFRWuxJsJshwozK2Zr8jnUVMTW+erIQiCZsZqEm3L9EOxe2sLJ85GDRmEfZ82VhSXrIBbLcaBm502FIZvL4CV7tJ/exD/IbASlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP3RcSByZBJzopUI0rB2AJ13LqruwSIYaRlmxQkqcHk=;
 b=wKqozjgk+nL6LLiV5/Rj58MIfKpQT3w9jPQsJAsfDAPTZ4VX3asNFrvp8XzsWQBRhV360age304EQnVOGcEvXgjPjfm2AdeF+RgojMbgiOncOquxr/Zs8bwo0tJDXDgdhemnUpc6wEGeYw/S7o8bHxsIcRowhKbAF53xjmVPeZN5+QrMe+/9bIvFHVpZJCZ6g5dM2nGvcmOM0QARUujpwKvd79IHOIQGptvA16wDxmCbY/4AsEMLzxQKc3to+mxroZ9oZSLJCOf5KljGXxfeuUpl26EKU/DxjDHc0bD3GS/QJjuZ/AnjznsVHHpQu8iccPGOFG2KNzL0I40gyuEcDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10903.eurprd04.prod.outlook.com (2603:10a6:800:265::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:46:46 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:46:46 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:49 +0800
Subject: [PATCH v3 14/17] binman: add a new entry type for packing DDR PHY
 firmware images
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-14-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=5098;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=TnSjTL3tEylZ2TW6IiDcsPG0Fj2l0Xr+3oW68Yr7BOE=;
 b=qpthhcEVioodyQxuZzo/AHAyGH37mv55XsmCurCtk1fcicpT5G4oSEq6drGeyTgr4h88jaVN5
 /98G+jEUI1GDwApUOgaU2g3ppiyXRtlLeL9aBU6Quht8eehA+Lo8cGM
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10903:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d90a18a-2af6-485f-38d5-08dd2bc26421
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWwvbDl5UkUvYk9VQ3hUM0pmeCtUbkNsdDBldVgrVldEeExYY0hSYVdYN0Zk?=
 =?utf-8?B?d0luWnFNempQMHp5RFhJSVdWd0VvaWhzaTVaeG1hSUlScnc0TDlhdHgvK2N5?=
 =?utf-8?B?cWJTM1JveUJENG5CSG5VdE1iOHZNN242NUtyMkhxZ2FqbUZhc3c3ZDFkZWJO?=
 =?utf-8?B?bkNuRnZUZ1VWY2ZTTGd6Y2xJT3VmNzAyY3c3Zy9GdC9ERGxCcTRMdDJyUW5D?=
 =?utf-8?B?bVZsMEh0ZWppM1JEemowV1NoTC9ycDRrSlphYmMwa2Z5MmdlbEY0OFhnNUNX?=
 =?utf-8?B?VldVRExFM25DVjlXV1dHQmZsd1lLb3hqNUk4SHB0K2trZE02emdBVDdxOThJ?=
 =?utf-8?B?Y0Q0MHVJZDU1cXFOT2RRQnRJNzFKT3JXV3N4Q2tXQzcxcXdnWU5CK1NyVnV2?=
 =?utf-8?B?Zy9YVmhMRTZIdmtidTdNblg2aHYyQ0gwbGpsZVZpclg5YVVIU25QaU9lMTk4?=
 =?utf-8?B?ODZQcW1BMXRTdUlvV2J0TEFMdlNGL2Q3Q1JrSHdIQjZVVGpNUlVNZ0RmdkdQ?=
 =?utf-8?B?S3l6ZjJRN29oZmlyZklIU0NWSFozUjF6eFY1OGs0VnN2eUpOS2JoOVZVenRi?=
 =?utf-8?B?LzMwVlp3djFCNmlIeSt5RlhkUzNkbmFCNkU1d0tPd25HVHBhVWQ2cHhaWVVl?=
 =?utf-8?B?RFRYYnYxRnNMcmlZa3h4dThUbCsrQzdIRDJqQ1dydlhENTNPRjJuNTAvL1Rz?=
 =?utf-8?B?aFNtNlJwNjhwc01FclBTNFVMZGgrTGNYSHhTaWZxb2JxUjlhaVJPVm5Ud3pO?=
 =?utf-8?B?dktyNDJKMUJQbWoxeXVndkhpa3p4YXNMT21jQ1VNTXFuQXNhbkdvU3NRMFlj?=
 =?utf-8?B?ZkRjY3lmMUFZRXVqbWJGZjR3bEMxNkJ0R1NuMzJpdU5ER3V1SUNSMnlSdEFw?=
 =?utf-8?B?NmlaWFdkTzgrQ3dDNi9UZGw5NDd4dStiRDdWOWtLYi90L2dua0hlcUo1Q1E1?=
 =?utf-8?B?QXFoTlR4MkhRUHFvYlNsSTNWWG01U21rdGpXSi8rcDFnQ2JSTjJmUmdqVGY2?=
 =?utf-8?B?ZnVxZ0RTQmY4NzduSXh2NEFMNXdpWk9CTlZWMWltTjNNU256WStRY01XaGFZ?=
 =?utf-8?B?cEpzbjVwQmYvSFZmTUFZaGNIRTV6RUoxT041NllGVHpnb1NTYjFtSVlOR2xa?=
 =?utf-8?B?MEdJVmw5UlM5bFlpd1pVekdxb2NvcFV2blJLVFord1RGQlk1S2ZBMTBJcW9U?=
 =?utf-8?B?U1RrZWhRYlgyVDRqMWJMbjdCdDdTQ1dVN1UzcldyNzV2Rnc3Y2NIazU3L2Fy?=
 =?utf-8?B?Y3R4T1QwZGtJeG12cnZkVnhPN0Z2R2FOd1I2alY5MVp0cDhpZlNZSFJZR1JJ?=
 =?utf-8?B?TkgzeEEvTlV2VDlES29OdnVydTFtUDhNMi8vUWJmM3VpbnJrYXJ5NEFMUFFN?=
 =?utf-8?B?Yllud2U1dkpPN3Evajgwc21icEJhWWV6amJrQmVhUXpDckgyRVNaVldrMThT?=
 =?utf-8?B?K1VWSTJUbjNXeC9hTnFybm5SL1k1K3M4ZE1DQ3VTekRFSUtXL1lwMUxnZWsx?=
 =?utf-8?B?Vk00UjY3Rkc5eVArYkZFNFYrYmxnVjB4dkwya1AwSW1TYnZxa25DYXJtSXRZ?=
 =?utf-8?B?YTFoY2JZVzVYU2Iwdzk4Z0lVSnB6TXBJaXZiTjI5YS9nUVBqYzlidXBvcysx?=
 =?utf-8?B?V2tmbDJraHVpSlpnc09WWDZLcm5Da2RFUDRBUlEzb0ovMVNETzVMYmtqV0hI?=
 =?utf-8?B?NnRBSzlCVGZsNDBwWlJ2YzdjYy9CQyt1bnNvL0IrekRpMFlLNkVrdEZHK1Zn?=
 =?utf-8?B?aVptZm54dTREZmhwQ1FNOUw3QkFIZWRQMTlBbUtUTVk5QWxoNlFwd1FOeU1F?=
 =?utf-8?B?ZThrc1o0MmlQcXNNVXhkaFF2ZTFzT1VlNTJsNkt1VlZPNWhoVWZJa1JDKzRL?=
 =?utf-8?B?VVBHcVY5UVFCL1lmUm96OURpVTVYVEptdFFRTHV1cnE2TDZyOXFJZUk4Y1Ny?=
 =?utf-8?Q?qCUAjN8O4SVQOEHYKw5AeH6mpln7eJNp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzNiOW1LQlE4R1c2UUt3L1FXOG9tY2hObUk4YmFlZURiYisrWVcwcWhVV1U3?=
 =?utf-8?B?ZmFKQ01OS0l0NHQ2bUVUZzN5YWtLZnZDYjV6eVV4dkV4RWNmK05POVNMMUkw?=
 =?utf-8?B?T1pqL0NQWmVTNkQ4dktpRk4yU2JLdVJyVmF4UHZhWUdpWW1mRktIOXZGMUpt?=
 =?utf-8?B?VDZjTUdQZ3JHdDBreUZDNzlvS3FYZEV0emNLaFVlZEM2VzFUSmxUTFAzcDVw?=
 =?utf-8?B?cUJmdk1NMmY1TzlHdTFXaGU2d3Exd0U1b0tvSkRqa3V5OGM5NWQwV2hhQ3RJ?=
 =?utf-8?B?R0gwUG1NTmp0N1ZTYUpVRlFhNWJ1dEJUUURZYzBtdVhjc3MvV1NvSlhRSjBi?=
 =?utf-8?B?d3dmVlVOODNQaUpJNWtVY1huMEYrU1gvSjNqVDJtanl2ZG9GcEFSSUJyYkF4?=
 =?utf-8?B?Q3JPYWFDaVIxWnJMNmN0OHJVWVJ1UlV0RytCa2Nzc3BTS0V3eEtFaTNuMWJ0?=
 =?utf-8?B?dmJSOEZKd2U0Q1hVOGpuZ0hCNm56OFhXSHFSZTFocEM2Y0hFdmU4d0p2ZXRT?=
 =?utf-8?B?TmZOUEdVZkU3aWdiMWpldVB2dmZVVGhkTEFMNXhGdzhiOTJEYXkvK2Z0RWdZ?=
 =?utf-8?B?VndVdWtSWjVyblhwTEwzYU1uTTd0SDE5OUdZYWwxZ21La0lGdWdtZnVwME5s?=
 =?utf-8?B?b1J0cktPNG1FeWkveGhNMTMzb2RnQWpKM25peEJianZRdEt4STYxenNuTkdm?=
 =?utf-8?B?cy91MFNwZXpSU0hrYk1HUkpBWkRqOGloa1l1cW9ZZDJwQ09NSEZDN3B2RDNy?=
 =?utf-8?B?eURtd3UwOHJRY3EvVDNjTERqYVpTLzNBTVNWQkV2TkdhcTZYcUo1cHZDeXhH?=
 =?utf-8?B?UTE2NWVkVXVNLzMvd1ZiRzFwQ1BxYlNLS1QrbWdKUlpDWWZkb0RDTVpOL2ZL?=
 =?utf-8?B?NUlxYUJMQzBFQ085ZytnSmFxRnBjLzJNTTdRR1RiWmZGWjBUVEZTc0FNWFNq?=
 =?utf-8?B?TTRjWnVySzJPM3IzOG9sR09Xb1FFdGoyNDN1UTY1Wkw5VDZVNEMwTXBBQkVI?=
 =?utf-8?B?Z1Vvenp3VWFCbmNTd3l5WjhPaE5rM3FFK2RScHdkOVBFTFNuNW9SYnNTdWt5?=
 =?utf-8?B?T0l5YVczc0ZtYmkvZVgvOEIwbExsREZjOURoazZMVWVhQlhtKzEyRGNDVFE0?=
 =?utf-8?B?Q3h4andNZWZ4MS9Va3VsWmJaTEVqYnQxMXJjK0ZBcmhWR0lhUVRHVURUVWNm?=
 =?utf-8?B?SjZqY3VrYVp3Q0Rnem1jRVpKZm1pR2FPbllGQ1E1T1hUdmlxV3hnbmx4aStz?=
 =?utf-8?B?SGhibnp0OTBsRzZhS1hKc3NNdmwzczVqQ1ZaSFE0S2c4dk1TMFY2Z0hyTVpr?=
 =?utf-8?B?K2xYWVhIUDc3SCtvY1Fhb3psRXRVRkRCcWxpTUN1c3ZkTGluL1Y4QWhodjRp?=
 =?utf-8?B?ZkFGMlNwYTUvTFBKOTRNWTl4bG8rWEdvclhNRld3TnFROTBWSmFtK3pGWGZq?=
 =?utf-8?B?MTliOGtUMEVsb0N1Y2QrRVVkOHcwK1lPS25pRU16UnFxVzVIZ2ZvdE5USFBB?=
 =?utf-8?B?TWJNWnV2NWZGR21FR1l0amVzVTQ4aE1wRHFxN2J6cll1Y0JXRHJTOWFjL0sr?=
 =?utf-8?B?bVh3K0VwRVVhY0xlQkY3dW5qN01YRkhTemNwektUY0svQTk5dUw5S1RqdWFC?=
 =?utf-8?B?dEpQdFJWQm5vaDU1c2V2WFZpbmI4NDZWdS9LR0Q0clVzM3Vrcnd5MFZ3aUlx?=
 =?utf-8?B?SjFBU2V0djBsTExiV0xjWmdURzFGb2lGUzhYcll0U3piVWRocERyU09wazNy?=
 =?utf-8?B?b0FtbHdSUDJsSUJCTGVJbmRScUJWYUdxR05abHQ0clc5NDVPWjdjRTRxWHJD?=
 =?utf-8?B?Ry81WUthMjU2VmdDNzVBR3dERDdmdkxYUXRQcFoxNS9mM2g2dU02c3ZuRWxF?=
 =?utf-8?B?dG8zaFRseFNMNWtPTmN1dU5MZzZ1YXJFblhSNzZSOWozYUxzZEJkL2FiZUFZ?=
 =?utf-8?B?MDBvbTJmdEg3dmtrNXpBVU5odXBvMTBtMGc3T2JzRFVZRytkNkUyeC9TTVlH?=
 =?utf-8?B?dER2UXY5RWptWU9HeWVGc09BSlZoNkZ5d3hVQk94dk52Mm5ka0ZYU3JKKzRu?=
 =?utf-8?B?SnNvamcreUNJSjVCOGJGM29PVUhqNVdqeFJ2V00wWXFpSUZJZGN4WFFtbndP?=
 =?utf-8?Q?TxdsnbZXT6NykgPq0h7jprwjE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d90a18a-2af6-485f-38d5-08dd2bc26421
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:46:46.0838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmTKXGBv03A+4cdNukP+Ng32QIzLpjSTbTABmd9sFBw8QDZZgfVeeLB8NiEVZC33LghlF6p8N+0j5XATIVtCUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10903
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

i.MX95 needs to combine DDR PHY firmware images and their byte counts
together, so add a new entry type nxp-header-ddrfw for this requirement.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 tools/binman/entries.rst                  | 10 ++++++++++
 tools/binman/etype/nxp_header_ddrfw.py    | 32 +++++++++++++++++++++++++++++++
 tools/binman/ftest.py                     | 11 +++++++++++
 tools/binman/test/346_nxp_ddrfw_imx95.dts | 24 +++++++++++++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 780e9817fb6496b5f2a4aef6ed1c0b4c8d9a4ba2..6da3f0b904643360ca11da32e31129f5f54d279c 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1663,6 +1663,16 @@ Properties / Entry arguments:
 
 
 
+.. _etype_nxp_header_ddrfw:
+
+Entry: nxp-header-ddrfw: add a header to DDR PHY firmware images
+---------------------------------------------------
+
+This entry is used to combine DDR PHY firmware images and their byte counts
+together. See imx95_evk.rst for how to get DDR PHY Firmware Images.
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
diff --git a/tools/binman/etype/nxp_header_ddrfw.py b/tools/binman/etype/nxp_header_ddrfw.py
new file mode 100644
index 0000000000000000000000000000000000000000..541f045aa2e0bff5fea7c91c6939e35ef0b7200a
--- /dev/null
+++ b/tools/binman/etype/nxp_header_ddrfw.py
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2024 NXP
+
+from binman.etype.section import Entry_section
+
+class Entry_nxp_header_ddrfw(Entry_section):
+    """Add a header to DDR PHY firmware images
+
+    This entry is used for i.MX95 to combine DDR PHY firmware images and their
+    byte counts together.
+
+    See imx95_evk.rst for how to get DDR PHY Firmware Images.
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+
+    def BuildSectionData(self, required):
+        section_data = bytearray()
+        header_data = bytearray()
+
+        for entry in self._entries.values():
+            entry_data = entry.GetData(required)
+
+            if not required and entry_data is None:
+                return None
+
+            section_data += entry_data
+            header_data += entry.contents_size.to_bytes(4, 'little')
+
+        return header_data + section_data
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a553ca9e5642b685b908e817972b42bfba1d8a0a..62acc1d885cf6565999672d25584602929c3c4c3 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -104,6 +104,8 @@ PRE_LOAD_VERSION      = 0x11223344.to_bytes(4, 'big')
 PRE_LOAD_HDR_SIZE     = 0x00001000.to_bytes(4, 'big')
 TI_BOARD_CONFIG_DATA  = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
 TI_UNSECURE_DATA      = b'unsecuredata'
+IMX_LPDDR_IMEM_DATA   = b'qwertyuiop1234567890'
+IMX_LPDDR_DMEM_DATA   = b'asdfghjklzxcvbnm'
 
 # Subdirectory of the input dir to use to put test FDTs
 TEST_FDT_SUBDIR       = 'fdts'
@@ -202,6 +204,8 @@ class TestFunctional(unittest.TestCase):
         TestFunctional._MakeInputFile('fsp_m.bin', FSP_M_DATA)
         TestFunctional._MakeInputFile('fsp_s.bin', FSP_S_DATA)
         TestFunctional._MakeInputFile('fsp_t.bin', FSP_T_DATA)
+        TestFunctional._MakeInputFile('lpddr5_imem.bin', IMX_LPDDR_IMEM_DATA)
+        TestFunctional._MakeInputFile('lpddr5_dmem.bin', IMX_LPDDR_DMEM_DATA)
 
         cls._elf_testdir = os.path.join(cls._indir, 'elftest')
         elf_test.BuildElfTestFiles(cls._elf_testdir)
@@ -7826,6 +7830,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test that binman can produce an iMX8 image"""
         self._DoTestFile('339_nxp_imx8.dts')
 
+    def testNxpHeaderDdrfw(self):
+        """Test that binman can add a header to DDR PHY firmware images"""
+        data = self._DoReadFile('346_nxp_ddrfw_imx95.dts')
+        self.assertEqual(len(IMX_LPDDR_IMEM_DATA).to_bytes(4, 'little') +
+                         len(IMX_LPDDR_DMEM_DATA).to_bytes(4, 'little') +
+                         IMX_LPDDR_IMEM_DATA + IMX_LPDDR_DMEM_DATA, data)
+
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
         if not elf.ELF_TOOLS:
diff --git a/tools/binman/test/346_nxp_ddrfw_imx95.dts b/tools/binman/test/346_nxp_ddrfw_imx95.dts
new file mode 100644
index 0000000000000000000000000000000000000000..889f6f29860746c09a91aaad7658976559760d9c
--- /dev/null
+++ b/tools/binman/test/346_nxp_ddrfw_imx95.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		imx-lpddr {
+			type = "nxp-header-ddrfw";
+
+			imx-lpddr-imem {
+				filename = "lpddr5_imem.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr-dmem {
+				filename = "lpddr5_dmem.bin";
+				type = "blob-ext";
+			};
+		};
+	};
+};

-- 
2.34.1

