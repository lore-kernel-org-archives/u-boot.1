Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969E9CA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 11:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B9682F03;
	Wed, 20 Aug 2025 13:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Suv1ooMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8183982B07; Wed, 20 Aug 2025 13:05:24 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5B7B801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 13:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0tWDeF+G4NaMcOxzecWHZGnXj7q6GcYJ+1yRbAlGYbrS/1gybiCbFgnRKRKEKOi7One6nQH/hwrWpV1Sd1wlbezpLVzXiB1fNTwFu/2jLEAQuvXBm29zgyh3MrAdbji16+fSq3kECyNDhKCuv2A0x2zR/79VjLRDC81/FpTTIkB9XH9bKP+zXpvSiFw8648Wnjc1CXX8zQk1NrG/vo3XFy+IgOKtuqqkDsT6kqHp9s9w56Kga1RIGFWH1Ac1JdTwDQxpA67V49aOGC3EgrNPY6++oqbgq61vlA+ksn0jOBrD6A8sFDzsHEgJ6YfEjD2kZ5ho3FXrzq7tUDMh9X67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opCjB00ien0CAkvjjjo+CQxADqONcnlX+2kfrIkuq/o=;
 b=gZ51rUIQqSlB0Fkk59Y0480T2yefCbzYPLvzSEY1CpQ/vTqZc0gvpqj29Jo9XAMFw8zBP14Z837UsbPA+1bowF09Qz1/WZlyMTJKOWYWVx5COvCALt96MkOBva6oBkbYzdzhN5H2xb8XP+gTPc17gHGZP2hnhrTdNC7TDU5s1Y6z6BgOiW6tuTD6DtfAh9lCgE6foenAHn9gSTkgHhR6Gq/Y4puJnPUmLiYxWNR9NxNej2wv3o6igrF7KVm4Zv0gNyv8pr9b+k6p9KxkpbWzj79cvIuDZerhoODGSnjevLnGN0bbMjRsz4aTttqqHzvxR8xBMqcVju0aYyYHiSn4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opCjB00ien0CAkvjjjo+CQxADqONcnlX+2kfrIkuq/o=;
 b=Suv1ooMYCefK0R3Z6t5iiigqlsmIC2yqrh4lXgzp6A1YBiVp5TEPeGOyWZSPDaB7mTyAq3FcfS30CU7DhaE/oN2h2VdDTRL+XFi6k/AvlOK02fSj8iNyOp0tCYCU/cH2Hxvp4eTr1B58JUgL1M45L1hhs32C2CgCCdn8D4cZ/tvGumwuDtSfGDk1uQNXNqbnyFy/UfOLy26EOuza5mxdeIlQcvuPSiKKq10eTWWzXNy3kSIu6ZtNfYtSDrVeEG0485InEFZRq1YSAVtQvtYGnO3nkT0RevmFt53+krhVX/0LOvNMaMB3WYfKyJ1g14YXE/PCZ+eeL5qZNVxstwSSBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by OSKPR04MB11365.eurprd04.prod.outlook.com (2603:10a6:e10:95::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 11:05:19 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 11:05:19 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 11 Aug 2025 05:59:36 +0800
Subject: [PATCH v3 2/2] imx95_evk: Restore support for i.MX95 A0 silicon
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-imx95-v1-2-569d8014172f@oss.nxp.com>
References: <20250811-imx95-v1-0-569d8014172f@oss.nxp.com>
In-Reply-To: <20250811-imx95-v1-0-569d8014172f@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|OSKPR04MB11365:EE_
X-MS-Office365-Filtering-Correlation-Id: 09871107-064f-492b-341e-08dddfd9736a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|52116014|1800799024|366016|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHY3LzZUa1BvSW1aOUllU2ZBRmp4MUpESnluOTRmbmdYUm1ZWElNRU9yNXI5?=
 =?utf-8?B?ZUQ1N3QyT0RrNk54NVY0anJSOXgzSXM3eXhtUDE4UzFzbmdhdmJXdlB0OUwv?=
 =?utf-8?B?SDJPTW9Kc1BVTVdpcUt1Mzc5dG1pWEplOEJpaVA1N2YvY2dDVGxoKzZReFM5?=
 =?utf-8?B?ek9iby9oNVMrLzhUYU42aEY5ZzV5Sy80YnI2KzRIb2UyRUlDNm15Q3J6U3Az?=
 =?utf-8?B?bG9sdUdxWXlBd05SSXdnRVMzS0F4RUpRYXdvcTJWMDNESlRxZEVGczBZR3Q5?=
 =?utf-8?B?RG43ZE9PcjJwSUNHNXdvT1VCaGVsZGp1dm90Q1VhdEdtQ0h0ZTl2bVVLb3Vt?=
 =?utf-8?B?Tk8xek1OZ0U3bDMyN21xd1N5TVIvSlp3emczbzBJaFN6U0ZyKzNHUzZLMFha?=
 =?utf-8?B?aDNOeWpZVU1jQmFMeWJDVUg3b1lYblFtbElPcFpXbUhDR0RlbVMxNEk3V0JY?=
 =?utf-8?B?cllVMEprR295b09PYk50KzF0SDV1NUJXaU9SaVY4LzY3UDZnYzByc2VpOFhZ?=
 =?utf-8?B?bGZnalJpQjZsWTlSek03TjNRWGNBaE9YcTBNUGcrdlYwMldzVDdValVUNWtB?=
 =?utf-8?B?SmxLcFh4dXFLZnIrZWkweC9lZXVIWnpocnZBTGVyT2lZZnJMc0xlL3orQ0hJ?=
 =?utf-8?B?WDc3UEdaeVJtcHJ6c2NTcXdXeG9sN0JXVUxhcU9jWWtqcFpid2V5eHJLMlgx?=
 =?utf-8?B?bXdBalFjeStIVEdybnZlTlZ3VWx4UXlxdHp1UkJzdzJvS1V2Y2NKK3ZkTk90?=
 =?utf-8?B?d3dLSUZPbzF4MFA0UHQzb1FFdmRsUWtrTHU2Z0RCcmFWNjdmaUhKMlFjVXh2?=
 =?utf-8?B?M2FEcmc2VmFlN0d4QVdFdlUySm1SL1A2dFNOcUNBK3l5ZVZqQU9jTFNtbUN5?=
 =?utf-8?B?aU1uOGwzRlJEOHJraUFwZ1FjRDJUZ1BvNjVQbDN5aDgzZUNCM05DRk5PbFV5?=
 =?utf-8?B?NG5KUTlXSWZjZlYwOGZUbVFCaGR1SmdOZlVKWHlnTDZ0citudUtaSlFiNk9M?=
 =?utf-8?B?NmtMVGhENXg2dDBYUTNjQnJlc0xNRDU1ZDRGVDhSbDZXLy9Ub3dCaldyczc2?=
 =?utf-8?B?a3V1RzhMdEtiRUF5RjVrNnNIanJFeHdvei9LdFJEd2ZrRGZ3RndoNDFkd05k?=
 =?utf-8?B?cnhwamN6c2JWV21pUUE4SURkK1RwSUdtNWtqcnd2ZUNPQWhNbTN3Y2NWZVZn?=
 =?utf-8?B?cWFQdmRzeHVtdDMwL2Q2UWFNOE5EaHNsWnBFdlNUOVpxblR6clkzb25XUXlS?=
 =?utf-8?B?U1c0TjNvOHlLeCtQeVdsS29zdURPUjVIclBMdFpGR1Jzby9DTFZnZkI0MGo4?=
 =?utf-8?B?ZlJyanBFMWVkVWdHUzl5MG5la0JIL2JwNVh4SDNwNVBXYU93bTR6VWI0WHVt?=
 =?utf-8?B?Rzloc0JRZGRUOThaT3lHMDJBRkZVcmo5a1dZRmF6UU4vak1kdjZIdkx6ZjdP?=
 =?utf-8?B?OHhqRy90K0M3bVMvazB6enM4TWdOQnlrdmh1dk9XaUFCQmU5dDBObE5VNWlX?=
 =?utf-8?B?dVVaNExBUjRBbzAvTjA3cmF2bU5SbXFSdUQyWXUyekZ5eFBGbHF4T3VpRWE1?=
 =?utf-8?B?dVdCT1hROS95eDVwM1ZOYk1JN1pldWt4UFFFMERDTDJjaHNHdzJqREk1SmlH?=
 =?utf-8?B?dFZpRytiRzc3a21lKzN4azNuQmJzUXlMZW43NjhnZzVXMlMwTFVnVDhHUDZm?=
 =?utf-8?B?NEJ4SExnVWdzSlJFdE02N3duUytrTWRaaWQveG9ZcldwRkJOWFZxeVJBZktW?=
 =?utf-8?B?UDVONlJKNTU2ZXllbDZuRE50ZnlzcWFJbklicDlqN3ZXNlphbi9yWmNZbThD?=
 =?utf-8?B?RjROOFZ5WHFoUEdrSFBOdEFMU2E1OStKMmh3ZHF2dXVVTnBHcEVXL2c3STZZ?=
 =?utf-8?B?K3pXSE9VNVBWa0dOT0VyZ1RiSVprd0lLa2hLRmIrUldoSWxyN1dNb1ZINDhs?=
 =?utf-8?B?TUhER2N3VkdEOVNabjVTeDdZaTR5RjduQVBOUHhPMHU3OTR0RXFFdlpuMnBj?=
 =?utf-8?Q?Hm/18slVOIlKftudObrWqmeK8Ix3Pk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(52116014)(1800799024)(366016)(13003099007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHo5RHBiUFhlazh5b1hqdmNGVUdRUDNWZkhQTS9WZnBKQUptZXMvR2NLbUt2?=
 =?utf-8?B?WHRnMUdrLzFaZU1PSGZPZnhqMGw0dGhQNXduRS9ZWXlxZ3pLTHJSOW9qMGYx?=
 =?utf-8?B?QU1DYmV5eW9YeGtXYlR3b1YxMVZCVHN5RXh5Wndzb1hYTHRLYXY4cjg1U2to?=
 =?utf-8?B?V2JxcDd3VXNoamN2bEgrNnFFVk1RU1preWh6dEg3ZHBmRDJzZFQ4WGt6RmZC?=
 =?utf-8?B?UnhxSUovR0VpMDhZa0YzUjB2MGZqVXFyNG0rVVJISmNpcE00WU1yV3AxTk54?=
 =?utf-8?B?V0s3cyt2YzZzRld5UWlqVy9zeXZOdmJ4czgyR1I1WnNtZzlRc0FUc3ZpZGJO?=
 =?utf-8?B?ZFhNeHV4TXNuYnpzRHdoZWUxL2F5RldOdFhLaWJOREhER0lXbzAyZE43OTVa?=
 =?utf-8?B?UWkzODd3QjFXa2xSaXNWWGZCV0R1MHlKL2xvbGo0NjhINzR6QXl5WkF3allm?=
 =?utf-8?B?SEs5blZJWTU3bkxwaDA0YTIybDd5ME9ZM2VFdEZ1SFdXTmpLNklTZ2Y2S2FX?=
 =?utf-8?B?b2tWOWJTMU51djdSelpTVGZyZkcwRVJ2UEhGUlYzbzhldTNvMzNHM2NOQjVv?=
 =?utf-8?B?eFNLMmVlU2xPaTZKekpiYmdTU2FraVhtVW9SUVhCRW5LQjVYbGprMTYrenlB?=
 =?utf-8?B?OEQvMEtHZGRIT0lCWGlmWE9reFJ0UFhDVVo1YWEwamR5VjBrTitNTFA2N0Ey?=
 =?utf-8?B?VC8xbkZmTUF0ak9qUksvY1Bxa0N1NUEweDVZTnlLM3h3NjZZTDY2QVlvSFB5?=
 =?utf-8?B?T3BpemM2ckJLZS92YXVXV1ZMaXhXRkJlanA3a091QUJpTWx5Z1V3MDVFVjBR?=
 =?utf-8?B?bVB3Z3NFWUpTUHBXK3RlK1J5Y3JvTWVBVEt5Q1JNanVKK3pvbHM5ODBkRjNa?=
 =?utf-8?B?NEFxa2J6SkhmRG5OVTlTbW9XbUlhVWdWUGY5YkFNZzdjWmVySXh4dG84RmNR?=
 =?utf-8?B?WFhBajBDS2x4Wlc2cmVWSWk1Y0pLWWJIcXo5Z3BVKzMyVms3djZlMit5bHJY?=
 =?utf-8?B?dVJPS2NmV0Vxb1FydmhZbzZXK2xBUlNRYm5veEdubU42UHdjRjE2K1dsOVFr?=
 =?utf-8?B?YzUxUUVRK2RPWXk5U3ZNQ3RWdVlrMFArRVpIK3NmcG45NUpjZ3pFam1HZTB2?=
 =?utf-8?B?cWFkRUo0UGhFLzlBTjNPTE1SVG9Jc0V4UWRTSGRxN3lmeCtHYmorTWc0WTNL?=
 =?utf-8?B?RDVyTk5kYWlLYVg2YkN3Q2xydmdxOGRxVjgxcXl0TGUrQndTUmwyRGNGYTdr?=
 =?utf-8?B?NTZhaUorOUsrRDJMQnhJRlpQUmNyWmdyeXpvc2NBZlRXSzVHUjZiTGM1RG5h?=
 =?utf-8?B?cVZBSlFxL2RmNGtueTROTVdra25SdGFuRlhNQ0tnNkxTa3d4RW56UE9TMFo2?=
 =?utf-8?B?R3FPanFpektxMkhBUFlpVUYxV1hjWng5RFlmQmxPUHI4UzR5M0NCUHhVSHJ0?=
 =?utf-8?B?WjhMUkprM1JIU0Z0N1ZPY0l6eUZiV1FnNlZUVFNKV3h1SDZTcTNXN1NYNmMv?=
 =?utf-8?B?MHQyZHEvQnJMNEVZd2RyKzlsdXNXRjZtTXgxVmI4VnR1eU1MdHREeGNYNDls?=
 =?utf-8?B?eXVmUm9PQTBNRm5RM3IvdGsxQXlyK2swYkp3ZVF5L2dqaFlJUTF1cUtUZE11?=
 =?utf-8?B?aEtBTzRLSGZqeDd1MjBxMkdQekRWcmtFdXNpNEpDZWJiSEIzeGtDeDlmZENC?=
 =?utf-8?B?eFRWNC9QRHB4MitidWk0dTNZWEFXcDFNeFk1UzM5Y2RhNXlDSzdxc053RjBI?=
 =?utf-8?B?MWdXb0Z5aENVY3BvQThETSt5djBkWW9ZRWtraXVNLzF4REdaa1N4V29HRzVQ?=
 =?utf-8?B?Qkl4UDB3bExKbnpCRVFnTitYMzBIUGpEYytCaFJyOGx5MEdQNkpEZ3pQdlA5?=
 =?utf-8?B?WkhmOGQ2YWVvUWN0ZVo2QnRFVnMrZ2hvZThhS2ZUQ09zWTF2L1N1aFQ0UnRI?=
 =?utf-8?B?dDJsNStwcE1HNlcvdUJwd3hkdldUUEJkRlk1cUJpUFdiRUc2Um9SU1BnWm9W?=
 =?utf-8?B?K1FrbGNseld6YWdWaTJwYlhGT1BzOXlkVVBzMDZKRkJSYlowN2tKL3Y3NnRQ?=
 =?utf-8?B?SlA0SVFtcnhuZHB2MDJyeGhSWHhOVkdTV0NNT1ZWcEVyYm83bitnY1BmcWts?=
 =?utf-8?Q?uUeuVbALspIpherfrUc0a4FU/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09871107-064f-492b-341e-08dddfd9736a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:05:19.5249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IP7pxb/u9QgLAHBscNmQKoEjL9A0ft6B5dX4CwgHWgGDA/X9KL5qfRKeWVnY6A+0mG8ZMQiTtn/EmeXrl+tRNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11365
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

This patch is used to restore support for i.MX95 A0 silicon. To avoid
duplicating defconfig, imx95.config is added and can be shared between
imx95_a0_19x19_evk_defconfig and imx95_19x19_evk_defconfig.

container.cfg and imximage.cfg are used to created .cfgout files that
are be passed to mkimage with -n to build flash.bin. Now they have been
deleted and replaced by adding their content to properties of node which
type is nxp-imx9image under binman node.

Fixes: 9936724aa9b ("imx95_evk: Add i.MX95 B0 support")

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Tested-By: Tim Harvey <tharvey@gateworks.com> # imx95-19x19-evk (rA0)
---
 Makefile                                  |   3 +-
 arch/arm/dts/imx95-u-boot.dtsi            |  44 +++++++--
 arch/arm/mach-imx/Makefile                |   5 +
 arch/arm/mach-imx/imx9/Kconfig            |   5 +-
 arch/arm/mach-imx/imx9/scmi/container.cfg |  11 ---
 arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  16 ----
 board/freescale/imx95_evk/MAINTAINERS     |   1 +
 configs/imx95_19x19_evk_defconfig         | 153 +-----------------------------
 configs/imx95_a0_19x19_evk_defconfig      |   2 +
 configs/imx95_evk.config                  | 150 +++++++++++++++++++++++++++++
 doc/board/nxp/imx95_evk.rst               |  42 +++++++-
 11 files changed, 241 insertions(+), 191 deletions(-)

diff --git a/Makefile b/Makefile
index 63e23886cde..462c0cd1bb2 100644
--- a/Makefile
+++ b/Makefile
@@ -2469,7 +2469,8 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
 	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
-	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot
+	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot \
+	       imx9image*
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
index 9bf8f9834c9..de74398fdfe 100644
--- a/arch/arm/dts/imx95-u-boot.dtsi
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -52,15 +52,47 @@
 			pad-byte = <0x00>;
 
 			spl {
-				align = <0x400>;
-				align-size = <0x400>;
-				type = "mkimage";
-				args = "-n spl/u-boot-spl.cfgout -T imx8image";
+				type = "nxp-imx9image";
+				cfg-path = "spl/u-boot-spl.cfgout";
+				args;
+
+#ifndef CONFIG_IMX95_A0
+				cntr-version = <2>;
+#endif
+				boot-from = "sd";
+				soc-type = "IMX9";
+#ifdef CONFIG_IMX95_A0
+				append = "mx95a0-ahab-container.img";
+#else
+				append = "mx95b0-ahab-container.img";
+#endif
+				container;
+#ifndef CONFIG_IMX95_A0
+				dummy-ddr;
+#endif
+				image0 = "oei", "m33-oei-ddrfw.bin", "0x1ffc0000";
+				hold = <0x10000>;
+#ifdef CONFIG_IMX95_A0
+				image1 = "oei", "oei-m33-tcm.bin", "0x1ffc0000";
+#endif
+				image2 = "m33", "m33_image.bin", "0x1ffc0000";
+				image3 = "a55", "spl/u-boot-spl.bin", "0x20480000";
+				dummy-v2x = <0x8b000000>;
 			};
 
 			u-boot {
-				type = "mkimage";
-				args = "-n u-boot-container.cfgout -T imx8image";
+				type = "nxp-imx9image";
+				cfg-path = "u-boot-container.cfgout";
+				args;
+
+#ifndef CONFIG_IMX95_A0
+				cntr-version = <2>;
+#endif
+				boot-from = "sd";
+				soc-type = "IMX9";
+				container;
+				image0 = "a55", "bl31.bin", "0x8a200000";
+				image1 = "a55", "u-boot.bin", "0x90200000";
 			};
 		};
 	};
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 8bd85e889ab..fa2cdaba144 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -223,6 +223,10 @@ endif
 
 ifeq ($(CONFIG_ARCH_IMX9)$(CONFIG_ARCH_IMX8ULP), y)
 
+ifneq ($(and $(CONFIG_IMX95),$(CONFIG_BINMAN)),)
+SPL: spl/u-boot-spl.bin FORCE
+	$(call if_changed,mkimage)
+else
 quiet_cmd_cpp_cfg_imx9_check = CHECK    $@
 cmd_cpp_cfg_imx9_check = $(CPP) $(cpp_flags) -D__ASSEMBLY__ -x c -o $@ $< && $(srctree)/tools/imx9_image.sh $@
 
@@ -244,6 +248,7 @@ u-boot-container.cfgout: $(IMX_CONTAINER_CFG) FORCE
 flash.bin: spl/u-boot-spl-ddr.bin container.cfgout FORCE
 	$(call if_changed,mkimage)
 endif
+endif
 
 else
 MKIMAGEFLAGS_SPL = -n $(filter-out $(PLUGIN).bin $< $(PHONY),$^) \
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 4e0e194690b..b6acbb20ff0 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -25,6 +25,9 @@ config IMX91
 	select ARCH_MISC_INIT
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95_A0
+	bool "Support for i.MX95 A0 silicon version"
+
 config IMX95
 	bool
 	select ARCH_MISC_INIT
@@ -33,7 +36,7 @@ config IMX95
 	select DM_MAILBOX
 	select SCMI_FIRMWARE
 	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
-	select IMX_PQC_SUPPORT
+	select IMX_PQC_SUPPORT if !IMX95_A0
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-imx/imx9/scmi/container.cfg
deleted file mode 100644
index b25f3b726c5..00000000000
--- a/arch/arm/mach-imx/imx9/scmi/container.cfg
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2025 NXP
- */
-
-CNTR_VERSION 2
-BOOT_FROM SD
-SOC_TYPE IMX9
-CONTAINER
-IMAGE A55 bl31.bin 0x8a200000
-IMAGE A55 u-boot.bin CONFIG_TEXT_BASE
diff --git a/arch/arm/mach-imx/imx9/scmi/imximage.cfg b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
deleted file mode 100644
index c2c92174c1c..00000000000
--- a/arch/arm/mach-imx/imx9/scmi/imximage.cfg
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2025 NXP
- */
-
-CNTR_VERSION 2
-BOOT_FROM SD
-SOC_TYPE IMX9
-APPEND mx95b0-ahab-container.img
-CONTAINER
-DUMMY_DDR
-IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000
-HOLD 0x10000
-IMAGE M33 m33_image.bin 0x1ffc0000
-IMAGE A55 spl/u-boot-spl.bin 0x20480000
-DUMMY_V2X 0x8b000000
diff --git a/board/freescale/imx95_evk/MAINTAINERS b/board/freescale/imx95_evk/MAINTAINERS
index 5caf763e0cc..9d5c4e41b65 100644
--- a/board/freescale/imx95_evk/MAINTAINERS
+++ b/board/freescale/imx95_evk/MAINTAINERS
@@ -3,4 +3,5 @@ M:	Alice Guo <alice.guo@nxp.com>
 S:	Maintained
 F:	board/freescale/imx95_evk/
 F:	include/configs/imx95_evk.h
+F:	configs/imx95_a0_19x19_evk_defconfig
 F:	configs/imx95_19x19_evk_defconfig
diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_defconfig
index 73818a82627..542b71f5c07 100644
--- a/configs/imx95_19x19_evk_defconfig
+++ b/configs/imx95_19x19_evk_defconfig
@@ -1,152 +1 @@
-CONFIG_ARM=y
-CONFIG_ARCH_IMX9=y
-CONFIG_TEXT_BASE=0x90200000
-CONFIG_SYS_MALLOC_LEN=0x2000000
-CONFIG_SYS_MALLOC_F_LEN=0x10000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=3
-CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
-CONFIG_SF_DEFAULT_SPEED=40000000
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_OFFSET=0x700000
-CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/scmi/imximage.cfg"
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-evk"
-CONFIG_TARGET_IMX95_19X19_EVK=y
-CONFIG_OF_LIBFDT_OVERLAY=y
-CONFIG_SYS_MONITOR_LEN=524288
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_TEXT_BASE=0x20480000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x204d6000
-CONFIG_SPL_BSS_MAX_SIZE=0x2000
-CONFIG_SYS_LOAD_ADDR=0x90400000
-CONFIG_SPL=y
-CONFIG_SPL_RECOVER_DATA_SECTION=y
-CONFIG_PCI=y
-CONFIG_SYS_MEMTEST_START=0x90000000
-CONFIG_SYS_MEMTEST_END=0xA0000000
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
-CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
-CONFIG_SYS_CBSIZE=2048
-CONFIG_SYS_PBSIZE=2074
-CONFIG_BOARD_EARLY_INIT_F=y
-# CONFIG_BOARD_INIT is not set
-CONFIG_BOARD_LATE_INIT=y
-CONFIG_PCI_INIT_R=y
-CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_BOARD_INIT=y
-CONFIG_SPL_LOAD_IMX_CONTAINER=y
-CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
-CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
-CONFIG_SPL_I2C=y
-CONFIG_SPL_DM_MAILBOX=y
-CONFIG_SPL_POWER=y
-CONFIG_SPL_WATCHDOG=y
-CONFIG_SYS_PROMPT="u-boot=> "
-CONFIG_CMD_ERASEENV=y
-CONFIG_CMD_NVEDIT_EFI=y
-CONFIG_CRC32_VERIFY=y
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_CLK=y
-CONFIG_CMD_DFU=y
-CONFIG_CMD_FUSE=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_POWEROFF=y
-CONFIG_CMD_SNTP=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EFIDEBUG=y
-CONFIG_CMD_RTC=y
-CONFIG_CMD_TIME=y
-CONFIG_CMD_GETTIME=y
-CONFIG_CMD_TIMER=y
-CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_HASH=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_NOWHERE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_MMC_DEVICE_INDEX=1
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eth0"
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SYS_RX_ETH_BUFFER=8
-CONFIG_SPL_DM=y
-CONFIG_REGMAP=y
-CONFIG_SYSCON=y
-CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_CLK=y
-CONFIG_SPL_CLK=y
-CONFIG_SPL_CLK_CCF=y
-CONFIG_CLK_CCF=y
-CONFIG_CLK_SCMI=y
-CONFIG_SPL_CLK_SCMI=y
-CONFIG_DFU_MMC=y
-CONFIG_DFU_RAM=y
-CONFIG_SPL_FIRMWARE=y
-# CONFIG_SCMI_AGENT_SMCCC is not set
-CONFIG_IMX_RGPIO2P=y
-CONFIG_DM_PCA953X=y
-CONFIG_ADP5585_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_IMX_LPI2C=y
-CONFIG_IMX_MU_MBOX=y
-CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS400_ES_SUPPORT=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_MT35XU=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_AQUANTIA=y
-CONFIG_PHY_REALTEK=y
-CONFIG_DM_MDIO=y
-CONFIG_MII=y
-CONFIG_FSL_ENETC=y
-CONFIG_PCIE_ECAM_GENERIC=y
-CONFIG_PHY=y
-CONFIG_PINCTRL=y
-CONFIG_SPL_PINCTRL=y
-CONFIG_PINCTRL_IMX_SCMI=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_SCMI_POWER_DOMAIN=y
-CONFIG_DM_REGULATOR=y
-CONFIG_SPL_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_SPL_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_RTC=y
-CONFIG_DM_SERIAL=y
-CONFIG_FSL_LPUART=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_NXP_FSPI=y
-CONFIG_ULP_WATCHDOG=y
-CONFIG_LZO=y
-CONFIG_BZIP2=y
+#include <configs/imx95_evk.config>
diff --git a/configs/imx95_a0_19x19_evk_defconfig b/configs/imx95_a0_19x19_evk_defconfig
new file mode 100644
index 00000000000..9376f11b151
--- /dev/null
+++ b/configs/imx95_a0_19x19_evk_defconfig
@@ -0,0 +1,2 @@
+#include <configs/imx95_evk.config>
+CONFIG_IMX95_A0=y
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
new file mode 100644
index 00000000000..231b42cb377
--- /dev/null
+++ b/configs/imx95_evk.config
@@ -0,0 +1,150 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-evk"
+CONFIG_TARGET_IMX95_19X19_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_EARLY_INIT_F=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
index 27cd15eb7c9..709992e016d 100644
--- a/doc/board/nxp/imx95_evk.rst
+++ b/doc/board/nxp/imx95_evk.rst
@@ -25,6 +25,17 @@ Note: srctree is U-Boot source directory
 
    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.2-89161a8.bin
    $ sh firmware-ele-imx-2.0.2-89161a8.bin --auto-accept
+
+i.MX95 A0 silicon version
+
+.. code-block:: bash
+
+   $ cp firmware-ele-imx-2.0.2-89161a8/mx95a0-ahab-container.img $(srctree)
+
+i.MX95 B0 silicon version
+
+.. code-block:: bash
+
    $ cp firmware-ele-imx-2.0.2-89161a8/mx95b0-ahab-container.img $(srctree)
 
 Get DDR PHY Firmware Images
@@ -53,12 +64,24 @@ branch: master
    $ export TOOLS=$PWD
    $ git clone -b master https://github.com/nxp-imx/imx-oei.git
    $ cd imx-oei
-   $ make board=mx95lp5 oei=ddr DEBUG=1
+
+i.MX95 A0 silicon version
+
+.. code-block:: bash
+
+   $ make board=mx95lp5 oei=ddr DEBUG=1 r=A0 DDR_CONFIG=XIMX95LPD5EVK19_6400mbps_train_timing_a1 all
    $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
 
-   $ make board=mx95lp5 oei=tcm DEBUG=1
+   $ make board=mx95lp5 oei=tcm DEBUG=1 r=A0 all
    $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)
 
+i.MX95 B0 silicon version
+
+.. code-block:: bash
+
+   $ make board=mx95lp5 oei=ddr DEBUG=1 r=B0 all
+   $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
+
 Get and Build System Manager Image
 --------------------------------------
 
@@ -82,13 +105,14 @@ Get and Build the ARM Trusted Firmware
 
 Note: srctree is U-Boot source directory
 Get ATF from: https://github.com/nxp-imx/imx-atf/
-branch: lf_v2.10
+branch: lf_v2.12
 
 .. code-block:: bash
 
    $ export CROSS_COMPILE=aarch64-poky-linux-
    $ unset LDFLAGS
-   $ git clone -b lf_v2.10 https://github.com/nxp-imx/imx-atf.git
+   $ unset AS
+   $ git clone -b lf_v2.12 https://github.com/nxp-imx/imx-atf.git
    $ cd imx-atf
    $ make PLAT=imx95 bl31
    $ cp build/imx95/release/bl31.bin $(srctree)
@@ -96,6 +120,16 @@ branch: lf_v2.10
 Build the Bootloader Image
 --------------------------
 
+i.MX95 A0 silicon version
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx95_a0_19x19_evk_defconfig
+   $ make
+
+i.MX95 B0 silicon version
+
 .. code-block:: bash
 
    $ export CROSS_COMPILE=aarch64-poky-linux-

-- 
2.43.0

