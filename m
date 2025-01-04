Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED6AE77198
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 03:21:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEDB3804CC;
	Sat,  4 Jan 2025 04:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IJKaxIID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32B0F804CB; Sat,  4 Jan 2025 04:20:07 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E07F6803F0
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMOCgxAHjc+0gvdOsTPUUafbsgdzPA/id6X8HvU8HrbVSw+mblwZ65NBYxQCJPuuVqLx31gut02mL6Ri9XVDohD4bI9k8EDWQiJOzB0Wm2Qyr+F4yubmD/9i0oRmhNTkI53Xmt56gRku+QLjiyNc50nz9VDwhSm6IQbv60n/WX9NcWrfKk+MQ5NhXRyvZUxE6IecK3HaAaNN7Ysj0jL/F0DqRpXbf+XszFD7dLV0juu8ZEkPw/Fiehp8TdOHOJebV/2nylpE/fEfRWDI/Q6/JJymLo6xe1iTzJwoShUL5qPbRlx/7VDUloyQqg3Rv2r4Ockg6iKdbWOCykFTK8nRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKnFBAxrZR6m8ndaMefK0b+/l0mbuRmyGNPlrnKKw8U=;
 b=xJRQeoE10TmB5vQWm47A4tfvOd98LLP6J0CeeYkO4z3cpUwCYkVbgoQYbhTmK+//flV3c+H+y08Z189/odjjZefpnEpx9Nv5fa4XT8zEIDzlcTjg7v09rqb07dPqxTO43mPSKtpdgzO6Yt21VDgsrEdNhHXtDLwxs9qkJa204lJNGJ9prv0KRJJ1JXuWtQlZ0ftSIC7cuInU3MasjMONcvooO25JgVdh2Ec/w0EbAsvUpCYzXtI319ZXf7uymaqnCWyPyoTPhWrEMnNmzsMCQ1YJMo7p3dFfJW+n5PyvNS3pvBamgCYAikkZFYR37H5yFrIsncL5ik2mcKih3bWA6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKnFBAxrZR6m8ndaMefK0b+/l0mbuRmyGNPlrnKKw8U=;
 b=IJKaxIIDlsQjATt+sp/xEPgL5hFosNEWjN5C05rz768lFJcNU1KVOliGhBOTpjOlFjJtG9zfvhJjj2fTkDefovltB02Mge4Y+EE6KY91E8QA7vxgRjfPIsjOklmbwsBtmN0oB8kAQs+jFGj9kjyUh1UT+sX/axTVFHmzMgvTXGChuwzyzLwxUGlSea/mfTrEkDx4g/S8FF2NbeWSCOuT+bztLDWpT39Ifcec+B4SNAtqkwKC/8Sj7mtTJva21CefJrvYYvERnDv0KqeJOC/ZEH/k4TYZybaPOMGvnpJgaSYdUZvVV52N2YLh1IF74Sala4O4TbBTvFup64i7tSBNyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Sat, 4 Jan
 2025 03:19:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 03:19:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 Jan 2025 12:25:45 +0800
Subject: [PATCH 11/12] imx: imx8mq_evk: Switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-imx-bootstd-v1-11-e09618cc1d65@nxp.com>
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
In-Reply-To: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d357134-8aa9-4370-fcdb-08dd2c6eaad0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTEvMkJhS29mSlhhbHBBRk1LbnJ2V08xMFZWaXNQNmxEUHl4QjdqdmdoWnIv?=
 =?utf-8?B?VjRJV3VrajNxRitYM0RFN1hJWmNaZGI4QmpLTDRSZEMxSENwZ2RsWDF2d2Zx?=
 =?utf-8?B?ejkzdG5uQ2Q1OU5nWXlWU2NOYjhlcXJWck5CakxHZDN4QlBDU1ZYdjU2Z09H?=
 =?utf-8?B?M1VoRGl5MXlSU0JPQ3pyRWRnQkVLS1Q0d2MwWTZsOVpmeEFrRjhLTFVzeGdM?=
 =?utf-8?B?WVA4VEpwdEhLdzErR3FKeitvOXllclE1WGMrOG54b2hUQm1LWWRrSmNHdlJF?=
 =?utf-8?B?aVdaQ3dVRU5Ua2hHZE41RmtNRmQ5M3pwY3JGNGdiUlhuOGtkSU91RnBqS0Ir?=
 =?utf-8?B?TnBkQnM1S1dsTEpteDAzbENiRlUzVTlCNERsd1cxYW9iZWJ0Zm9rTkdWZXJz?=
 =?utf-8?B?Qmx2NXlSRmt6OWplTGtiVnE5UmtEYzZadTNhQWhseE5zeGwzV3hqZUZzeER0?=
 =?utf-8?B?NmFIRVM3VmdPNSt0ak1Zd01LMDBvbitmSWV0a2xXcERxcXFVSFYwbnQxUUlt?=
 =?utf-8?B?SlQxTU8rR1dhK2ZmZFcrQ3hLWi9pOGtORWZ0ZFJnWTg4L3ZkOERZWXg0QW5N?=
 =?utf-8?B?bmhxMWxlNnlMT1ZRU1ZIaGMycjFXRnRoU2NodmQrKy8rdWk5SGlUZk5PbHh5?=
 =?utf-8?B?TVhvSXdkeHZFZmVYVDArMlJ2YlZHM09BWWwrK2ZzVVdtTXF4cnNCc2RYYlFj?=
 =?utf-8?B?VWZWTU1YRmdCRFJ6dHJCVC8yZTlETzhQbzk3ZU1RWmtmNGp0ZFZYUVNZSDZi?=
 =?utf-8?B?eVNSQXhpbnpJL1ByU1RWcFFiSGdFbEFILzVPNXNMRUMvYWpQUTIzOENZWHJk?=
 =?utf-8?B?Mm5Ga1E5TVhIdi9FaTRZbnlyOXNVUmJmY3dVcjd2Y2NBVWpZWTFBS1pyWC9Z?=
 =?utf-8?B?SXRuK3MwVzBVakRVa1JWTlpTT2dyVnJCMkFvb0FTL0ZpSjRkTnBZSVZETjhP?=
 =?utf-8?B?TlBzZ3hPdUZqWHFXK3I2SytZaGZyT3NZS20vRVRRdklsb1NMQTFHRDdHVGIw?=
 =?utf-8?B?cHZhSXRoTklZd1lFZTdicEhLc0JDazQxT1JnUGZ0SUlDL0YyVGh6M1BWYXh5?=
 =?utf-8?B?WXJlRkxLbVpaa04zWVhmYkdVZ09zVFZaUGdwUXgwenhUd3hPQzNFT2tEeEU0?=
 =?utf-8?B?bXlueXl6SmRwcmlteGpJZ0xMY2hSN245ZWFicEUvLzhXbWpyTDcxYk5jTVNH?=
 =?utf-8?B?dUFET1h0cHlaWUo2M2NtUDJQaXU5SEpzdFpRRTVIZHN2Vlg3TXgxU2xTTFYr?=
 =?utf-8?B?UzJydUdTY2ZlNjI2VVQ3WTVBcnZQVmZpY0VRRjkrZVJqMnYvY0VPODFGazc4?=
 =?utf-8?B?VmZUczhjaXd3UUVLSmx0WTE3a3RtMHpRMkdhaHIzdXB6UHhmSmgxNXEwOHZM?=
 =?utf-8?B?dGNObkZ2NzZmejRJY200TVJyMTUvR1ozTkIrMjhoem0yMUFFNzJmTi9TQjhX?=
 =?utf-8?B?S2RQb2hpR29jWHVkbWNSeTNpUnlxd25VdkFOUGZMdWN0TUh5NkJJTDUrRXpa?=
 =?utf-8?B?Y0NBTWZUYjYzU2VSclQzbDY5MllGZGNQZUdsbWRDNWUzc1JRbkg3MlV6TjJY?=
 =?utf-8?B?L0c5TWg1Z0plMDAwNjRUanFUbE9sbkw1eC9hQmRNcnZCUHNrVlAwRTVzbExx?=
 =?utf-8?B?elhOZ2FVSWFUcjl0YU1uL2dzcWtyd3p3UTVMMEI4QzV2ZVYvNEtFdjgzRW95?=
 =?utf-8?B?RUpUN2hZMjlYU3BKL0l4dzFpMk93VVZFRzN3MkZtcmN5VmZNekxVNUZXZUhh?=
 =?utf-8?B?ZjNLMUt2ZW13VDNPbFh4Z1ZhT0VQRlRoS0d0U3VSaG5NaHM1Zllua1RVK1Vh?=
 =?utf-8?B?L2VIVGY5OFllR0IwMUdxWFRzTy9BR215QythMVVNMHczZHhmT013STdjRDBi?=
 =?utf-8?B?YlYzNElOUFVITk5JVmNFVTBMcnYxVlZFekI1NDhpakJOdXkramgvblZPVzNN?=
 =?utf-8?Q?JT6BEYgimgnQ3Og0OR6g6uXf/smbxmfq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHU3dU93cXlENFBMOUd5QVRTTUFzVHRiZnQ4TjY3dVE3Rk10eW1RZ093ckFH?=
 =?utf-8?B?bnFSbTdMZWZLZWpsUlUydmxEUFZleDV2Rk9PdVpKUGdVRGhBditiTVBCbm9V?=
 =?utf-8?B?TXdMU1lwRERNYmpucnEwMURhOTl5b2htbHFoY1FJYnlVV0k2djkwdFYvSFRx?=
 =?utf-8?B?NGRGNnlveXJNUjh1MEExc2gzaUNudU9ITnUvdjZ4b3dPTlBYNGRYMUExYy9h?=
 =?utf-8?B?ZXdvWkFCeThBa2E3ZzU3ak40dUQyS3BkWU42UWM1MlFyekZIVUFyVVliZ2gx?=
 =?utf-8?B?YllSVzUwaU5sSlFjV2dCWDd2dDRDM3AvYW1kZXJ1MVYxS1laMUdBQlYySVgz?=
 =?utf-8?B?NzJBQ2o4TForL1pQamZXMkdvdDlEeENVRTlZam1NNE1mcUZXY2ZpNzJuT3F3?=
 =?utf-8?B?WC9BRnZoQjMzMUNxYTZheTgwK2RGdi96NFVCZTNTQnd5VklBWk1XSWN5YjN2?=
 =?utf-8?B?aFFHYUtvc0dYNVFXbnF0dE90VkovSGpBYXJZdEI2dDJDTllJTjdaNDdxRWwz?=
 =?utf-8?B?NFpGSm85VnRVcjJwTFhTVTAwUER0NGkra1R1TEc2N1BXa1JaV0lCTnh2amxO?=
 =?utf-8?B?UHFKWmxYbGRXaFhoUnFwb1BSYjdCemFMYjZ6bEYzZmRyRVdnMDI1TnFZWVU4?=
 =?utf-8?B?ZDNXSEl1QS9sV2VudXZac3M1VnQ3YlhBQ2x5RFhXdjg0NjNGZnVPdWxCZ20v?=
 =?utf-8?B?VjVub2VwbnJOTXcvNHA3VFVnTWt1TmltazZBSUNZdnVtcUpIV3Z0NE9OYUhD?=
 =?utf-8?B?dXpQRGdJVnVEdUFCQ1FBVlA4VHNDYXNBaUMvL0VJTlhzb0xxOUNudGUxZVFu?=
 =?utf-8?B?aEhkeDcrMEZ3R0Jnd2hzZUNHSHN1QXpZN0xTbmszbmxCUE0zUzV0WnlBTWNM?=
 =?utf-8?B?aUV5Q1FlcUxRenhUKytBclFIeDZzc29xV0o2ZDUvT0lJL3JpWXkxL3JYWVBD?=
 =?utf-8?B?Z29UUjNvSWRWa0dWVWQ1dVQ1VzQ2VzYvWFY4QmhETkN5TE9hc2grem9PMExr?=
 =?utf-8?B?UE1INTIyMVhpS0lXVXJZdWVjZEJWQTR1bG9OYkQ2bXdFK2NaS3NlcWJQWG1R?=
 =?utf-8?B?U3Y2alZ1cFlLeTVyRWdyQ25HazlvNXhPRlBIaFpkK0c5TGZwdDR4TlZCK2tm?=
 =?utf-8?B?S28yYVVMd045VjBhK2cva00vN2NIQmtrbzFIcWJ3dTU3SUtveXlpRTl0VG1q?=
 =?utf-8?B?OGlBeXJBTzhTOTlvendOMERQazV6TUFuVzV0ZUlOT05DUlpoaHlJSHdocWVl?=
 =?utf-8?B?MjNNY2E5VFVnTkJid0NtdVQ0c1c2VWlNc0JCN1VJSmc5RVl0T3pJbFp5d1VB?=
 =?utf-8?B?TURZVzhXWkZOa0lPNW40NFoydGJzU1lqQk56M1FjYTN3T25NeC9TeldtMDBR?=
 =?utf-8?B?STlCV2k2TTJ3elRrWTlpWkF1ckJRalVoV0VDc1ZySGtobnowMlpJbVFTUHc0?=
 =?utf-8?B?UVNsYUZ1eHJqRUtNMXFKdDRmdHVLeGFZZjdqMllYYXA3RHFldHpIb3dQVEJO?=
 =?utf-8?B?aEZZV2lZM3owWDVhL1ltR0FpMlEzY2ExVFdia0t5NG9BSVFyYUo5TmZ1SWRS?=
 =?utf-8?B?M2kzYUtDUzc4Tm9IT09ja0V0SkFOc1R2Z0xmemVOYVFTV1lmeVhkbHZPekpI?=
 =?utf-8?B?dWZSWm1SUnRJSGEvRFM0SmJJMTdzNHZHWlRuamlwejEvZmVkOXVCRzNERzNj?=
 =?utf-8?B?aXMwN01QQ29NRjc0d3ROcXE3TDBRdmIxbDJFdVNhcWVpWEhVREhRTmRYQlNv?=
 =?utf-8?B?R1Z6eTdCRktvV2FvaUg5b3JnTm9FQXFEQnovdFp3QTdCZlhSdVo0UkNFdC9I?=
 =?utf-8?B?Nnp1Qlp5cU5CcHEvTXNwc3Bzcncvd1J2aG90L2tvbC9EZy9selNWS1dvV2sw?=
 =?utf-8?B?cUpQcDY0VlJlL09tblMrTHF5ZVY1aDB0dnRGZS9CeWdWbE41SzN4ZjVTN21n?=
 =?utf-8?B?bVg0c0VhZDJ3bUFISTlxY3gvQktlQ3FkcEpvaGhYVFFqWks2dmZxUGw5UlpH?=
 =?utf-8?B?RHVYcWx2NmRPcm4wME1HUDVTdGZpY0xBQjZUcEphQ0pGK0l5aDcrYzEwUnJD?=
 =?utf-8?B?SmYrMy93QVRZT2Z5Tjl0Y1dVS0kzckI3VkhCTnhZNlpuWWdsaWQvZlMxSmhl?=
 =?utf-8?Q?3+ZzCFysRav7oOhCuOOmYQmDf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d357134-8aa9-4370-fcdb-08dd2c6eaad0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:19:58.1216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4iI3pcfh7S1ezG8OxXvpmpTxx8h+0Ad0/EBfNv8lz4DIAbJeLU93AIglZFtaqXjt5jLkyyZeJkQrifyCovEjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566
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

Move env to imx8mq_evk.env
Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Kconfig           |  2 ++
 board/freescale/imx8mq_evk/imx8mq_evk.env | 60 +++++++++++++++++++++++++++++++
 configs/imx8mq_evk_defconfig              |  4 ++-
 include/configs/imx8mq_evk.h              | 22 ------------
 4 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 28be6a22bf07e1341ec841bace149cdbb871fac0..76a8be7798c5d80a0384b1f28b1f18eff7b34e43 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -54,6 +54,8 @@ config TARGET_IMX8MQ_EVK
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX8MQ_PHANBELL
 	bool "imx8mq_phanbell"
diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.env b/board/freescale/imx8mq_evk/imx8mq_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..dcfe1c2f2d4118e5af01078e2e4402f60c2b7f6a
--- /dev/null
+++ b/board/freescale/imx8mq_evk/imx8mq_evk.env
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+boot_fdt=try
+boot_targets=mmc1 mmc2 dhcp
+bootm_size=0x10000000
+console=ttymxc0,115200
+fdt_addr_r=0x43000000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+initrd_addr=0x43800000
+image=Image
+ip_dyn=yes
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+loadaddr=CONFIG_SYS_LOAD_ADDR
+mmcautodetect=yes
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+prepare_mcore=setenv mcore_clk clk-imx8mq.mcore_booted;
+scriptaddr=CONFIG_SYS_LOAD_ADDR
+
+mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+mmcboot=echo Booting from mmc ...;
+	run mmcargs;
+	if test ${boot_fdt} = yes || test ${boot_fdt} = try; then
+		if run loadfdt; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	else
+		echo wait for boot;
+	fi;
+netargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=/dev/nfs
+	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	${get_cmd} ${loadaddr} ${image};
+	if test ${boot_fdt} = yes || test ${boot_fit} = try; then
+		if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadimage; then
+			run mmcboot;
+		else
+			run netboot;
+		fi;
+	fi;
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index a3a2333c98268d17942cd76c654bad63406099a8..13ad5f8e0de753ac69331509b1c68ac9aa9cb864 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x600000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_ENV_SOURCE_FILE="imx8mq_evk"
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_SYS_I2C_MXC_I2C1=y
@@ -30,8 +31,9 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
 CONFIG_SYS_PBSIZE=1050
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
diff --git a/include/configs/imx8mq_evk.h b/include/configs/imx8mq_evk.h
index 666f46ac105be6a7828bf54c388afad14ee1d1cf..2a86240e2c6dbf3e86e626a2b4a2c1311c68e8a0 100644
--- a/include/configs/imx8mq_evk.h
+++ b/include/configs/imx8mq_evk.h
@@ -26,28 +26,6 @@
 #define CFG_FEC_MXC_PHYADDR          0
 #endif
 
-#define BOOT_TARGET_DEVICES(func) \
-       func(MMC, mmc, 0) \
-       func(MMC, mmc, 1) \
-       func(DHCP, dhcp, na)
-
-#include <config_distro_bootcmd.h>
-
-/* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
-	BOOTENV \
-	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"image=Image\0" \
-	"console=ttymxc0,115200\0" \
-	"fdt_addr_r=0x43000000\0"			\
-	"boot_fdt=try\0" \
-	"fdtfile=imx8mq-evk.dtb\0" \
-	"initrd_addr=0x43800000\0"		\
-	"bootm_size=0x10000000\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR        0x40000000

-- 
2.35.3

