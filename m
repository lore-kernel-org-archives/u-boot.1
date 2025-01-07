Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E87E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 07:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB3180704;
	Tue,  7 Jan 2025 07:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HFNIZEZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4061480612; Tue,  7 Jan 2025 07:59:34 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B43B80634
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6RFJSUFVuqRCHmQmaqZjbWut+GKWJfk+6nrVHF2MOUMsLXPx7IH2vobH4RH/QjW9LHrdbGIfNPVKjgPFi1Sxj6cO7bs6v6YE5PUC8AV5PgX8dRJTpjlKmG4xHJD1ZGOchhAi1AIWp+4FwnST1S80N/+jGsZJ5kqEdCvEeKl3Ov03Ai1l2/g0lk41Hny7Sym8E2pWFH+ViH3b7Siov+CbKd+C2XM9DWhcpoQ6OVqbahaBNx1GYz6Arlrc6+zy5BvZmby1l2NjPdM0qUBrK2EjU51cKt3DwxMw5qIPmSkCldsufU6XucnzUYojEJgsxMGq5YT2MvhvwxMQDYH72SX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjKHbdltrW81DtDjKaV3gkga4jwnM1Qvg75tC97abCg=;
 b=Ux47K77TPCOisTgbZiJPcZAwIHmychMvj/UTaBzMYxx9M5eZVDxPBRJuH40I12Kn5L9lwi+mjXVtmZMvx1tkWu0taTF7Bfs8Dmov6MjzWwTUoEqwqF2TbA95pfrv/mXMxCLxqstxME6/Jqrh96fcMyEJ9ThGL4oq2kYStl4mNd2Dg4Vo/tMeDZ9GWxLEcqETjgFElkyOapv/9ggVdbadvpRIDb3mRaY5qFKErkQnd4efpk2CruKj8AAl9/3kN4Y9qP7gRWA/2HKUvIwrkUUj4gmtJHgWDys0eGlpCC/yNuDVpBuPmbGaP/Iw7DBDnM9c/BmlAy3O6OKj83ZMQt1zMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjKHbdltrW81DtDjKaV3gkga4jwnM1Qvg75tC97abCg=;
 b=HFNIZEZR6zfIrfjEIPMCTgJ8fRjTgZ7rv7kGbKaMikVqxPtjnIBb1nPPskvn+jSSRC1h5j5uUKRO6g0vywDULPPVwuhyh5Yz6LX61EgoZF3r4mkb7GWQcuXajvKEH0WZw705KquPV9e8UIxgpXZUKEoiGChH9f0o6mthzPAzFm2WzBxeR5xlqlNatFXVgS212UaE6lFsVQ6FPuHU4PJA3b5DSI0WvFTGWzE1RL5zijPWAIRF4WP5WDr0dg2qphilY+V8XARlPwejdC4UchflK4pEpykxRXBPZmkS3ssln3pAKm9CwD7qRYsCiZQxGAn3vYWUHmGyz4r50pczrP5ylQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10523.eurprd04.prod.outlook.com (2603:10a6:150:1d4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:59:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:10 +0800
Subject: [PATCH v2 10/16] imx: imx8mm_evk: Enable dynamic settings to
 mmcdev and mmcroot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-10-97671b1694cd@nxp.com>
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
In-Reply-To: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10523:EE_
X-MS-Office365-Filtering-Correlation-Id: 08009fc4-95f5-4f2c-c263-08dd2ee8d20f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTViWGZLeXFXbmdwbEl3cEpqM2NmRzk4cXZnT0J3bXRzSEdLdmJucS9YRE5P?=
 =?utf-8?B?a1hZTFdVeFhBQ3pSRlQwK0EyTDkwS0J6WEJMb2FaOElQT2IyR2pSWlVWMUpt?=
 =?utf-8?B?b3VwWENiemlKZCtKZzN1ZWZGcFBBenorODlpYmlqK1lBZDBzQkNnVW5YYVBV?=
 =?utf-8?B?cDZseEM2ZUZpSFBYZWYvODF0NWV5c0c1azd6ZHJGaktGQys1b0pHcUJZWXFk?=
 =?utf-8?B?ZjBsbElDbTZKd2lYN0dSamZXS0JMV1hHWjdpbFkyeUovckJ6WE9IejQ0aHk4?=
 =?utf-8?B?cFVZc28rZnRQMzJQYklhZXRpdnUrWlJMTzJ6YnMvYTNOMWRLQ2FEbUYwVkE4?=
 =?utf-8?B?S1ZQampHamh4L2l6Nk10M1pmNHVCU0lYNEhsTmt0bG5jS1pYV3l5V2NIcHli?=
 =?utf-8?B?Mjh4K1EvQVVyZUJSQ0xsenFJeWpkYzFoWnBGNldZMUNXajN0RGZSZG5oQmRX?=
 =?utf-8?B?cnFyN2FHR3FzdllGcHRvSUxMdStkZENyb01XU3UrNUFMME55b2VkN3YxNktU?=
 =?utf-8?B?Y2VMbUNJUmZzeWFQTHlNOWNlK0l2RmRUbFFEakZoQmx1NnYwQWgrUTRnTGNG?=
 =?utf-8?B?ejdJbWs3MkJ0ZlhERmcvYnFSelF0TVRHYlNPQ2N0cWdvT21HMGd4RkFXNDFR?=
 =?utf-8?B?dzdnUW9aQWMzVUk1SWo3QkNCQlI5eGpCVTR4REYrbUVKQzI3SUpibGxIRDZV?=
 =?utf-8?B?dnVzSUpHOURjS040akkyeTdraklHM1FlUG9FdGlwK3BONE0vVzNGTFFNWkV5?=
 =?utf-8?B?aW1GQ1Q0ZUJXU2o1enp5TWQ2SGtQUGVvU093Wnc2YkJ5bzd0M1JQckkrVWR0?=
 =?utf-8?B?cVVqQjJNeG1kWnBjUXkzUksrWGFkdVlHUlJEMk9adTg4VDlVRytWLyttcUgw?=
 =?utf-8?B?RjY3MGdTSUExL3FablQ5aEFVY3RDanRuWHhyVGtKNkpQSFovTnhvODRGeWda?=
 =?utf-8?B?a1lQZkRJWVF3UWYyVEpoK1h1NVJGWTR5U0R1TnpnREJFNldmRmJnVHZiOEtr?=
 =?utf-8?B?dmExVFdMcEo2ZWw0R0IrcjBEaHM4UTV3STdEeTJDQ1Nxa1lvaFA2ZWE5bm9v?=
 =?utf-8?B?RDVUVzdMZktvaVd4RkZMVkpCaXIwU0psdEhuemRlZHRNdXJKdmtURS9DYndu?=
 =?utf-8?B?T3VJU0k5ZnBtNHcvK2tvQUV6K0ZmYzIvb2l1bmJGKzU3TGlESkY4MytmUXBs?=
 =?utf-8?B?eThqU1F0REhxb2kyS1l3MnBBQTNkZnZRai9JbnRPS0pwVk5rVlhjK2NWTFZH?=
 =?utf-8?B?QzBGblRkY01mQ0FCNnFQNzkvbDZGSTZDbm1DUXF1dFh2L2k3WUtsQUxPVUtO?=
 =?utf-8?B?NmlEMmUwaFNtN3B5Q3B1bHBrZ0FsZWNwSE1FK092bWIxdWhGeUgrdGtUYlVT?=
 =?utf-8?B?b1lkSUJhazB4b1JCVHUrdTJKaEI3R0hsU3ZtSXEvTXpnTndXT1d4NHF5RzQ2?=
 =?utf-8?B?YXZvb1JGanAvMi83YS8yNTRhNjVZQUNrN0RpZXVhR0VDVUQ1QzlpUjJZYVBm?=
 =?utf-8?B?RWtyb0NzQ2dhdUJCYXdqWG91dllSMkRGY0FKV3FlOHpRV0NpZXlEaWRIajdi?=
 =?utf-8?B?M0tZcnBhbFc4bEpVcXhjNUNjYVM3NEpxdFhQaURCNkh2eFZFTlpUTzZzNWUw?=
 =?utf-8?B?TXV4VENYMUxoc0xWdzNLajdUUHZSWk0vQUd1UFBDWGduYkJRRnc2cG9DdC8v?=
 =?utf-8?B?YnpaNm54NEJYRjZ4Yk5iLzBwMTdWN1N3Sk5FQ3N2RnhhbG5IMjAzdXEydzdl?=
 =?utf-8?B?a1hhTExSRHdNV29IWkQ2UlNJMTRsSmZoeEZHYTVrRDZRMlEzVGZ3RHhOZ0Er?=
 =?utf-8?B?YVdnRDdvZnhJQ0MvNnRKZFgrQzBMUll1S2lvYVFXZW1iK25LVXQrd0ZMVXQz?=
 =?utf-8?B?b1VnY2d4Nkk1MVRPU2laNnRGbS92VXdTQStBMEhDcmRYbjJSNkZQWC8wcEU0?=
 =?utf-8?Q?O8I5KNG/3newGjNuO7YUW75LtAg8ScF4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTRPZ1RUaW1BT2xVazVrdXIwd20rSGNuVXNhZEU2S2taaE9QMi9aQ3JqSStF?=
 =?utf-8?B?emdmd2RkWjVqZ0h4bVRSS3o0a3JwMDcvWG5DWkFxcVlDYThrd3MwNnh2Y3pr?=
 =?utf-8?B?YjlESnFNczEyRFJKZ1FhSG9saS9CcEMraHJ3VzBRSWQ4T0Zab09RZ3V5QUYx?=
 =?utf-8?B?VWxHeDZ2MDFKSVI5VCswYVRRR0RQVFNFMm9ISnpQdFJ6ajJMVGlOMy9UY2ls?=
 =?utf-8?B?bVY5a01ybTdLVldKRFE2bm9IQ2tPRmlkRzdYMmFteWNVSW5GWDc3d1pNb2F1?=
 =?utf-8?B?ZjRGNXp4c3plZU9FeWRxMjFJUHZhT2V0L3UzdHZKczBMNDVWT1FOLzZSRFJO?=
 =?utf-8?B?UXpwNjBMRUZLMHowc1JPSVh3d2ZYaU5RWVYraUgrQ3RySlNacSsycDB3N3Fn?=
 =?utf-8?B?SktZOVozcnI1dTNrMzhDWVNqT1pXS0taUTliRHRRa2Z5UGx3bXBsZFdHM1Nx?=
 =?utf-8?B?R3IwQlZuZDYzUnNFMjI0eTlMUnF1bHhvaXZ0WHFucHU0WSsyUkpldHBBcEYz?=
 =?utf-8?B?UE9XVm5Ya0NIMkVXTWVoN3oxNnRmMXV3ckFhRHVEdTJIcFdhWVB5bGNlb1lT?=
 =?utf-8?B?cllGZGMrU05EQWZ0dFB5dklYZ0ZndjF1VnlZajNYMmU2bmh4ZkFodnFqOWhk?=
 =?utf-8?B?Q29MUmpvUkFlZGV4Qzlrb0tlSGw2UWxYUnpjMlRtQTd2UTNnUUdiNTFBZ2M0?=
 =?utf-8?B?UmpZa0Q2T2tTWW1NdUY4VjJoV3dSS0tQMWRxNExZZVFyOVVhSUZoZmFpY3hZ?=
 =?utf-8?B?U2p3d2dHNWR1WG8xQ0cwRzliNVhBUDNMTzF3ODdSM29Ick8wTTg2Y1BqWjBP?=
 =?utf-8?B?RWZZOVVOajNQR0JXT2JDay94MjJPUUE4cHROaXFtVURqRTg1SUo1eFlYS3Ns?=
 =?utf-8?B?T1E4UlRtMDlzRHpsVjNtK1VLcUhiVE52Y3Q2SmVPTUVFZlUwV3B6ZURXYkk5?=
 =?utf-8?B?SmQ3UlJkTUR0R1Fwb3V5dmxhemFnVlJ5d1ZtQTR0amdXc2NDbjAzNlhkQ1RJ?=
 =?utf-8?B?VWRkLzA3UytEOFNWVmFtQ3B6bFVid2tXZ0M4SjdyU2s4TTg2ajlFUGlFZEJl?=
 =?utf-8?B?ZldmMDdhRkZjVis4Z051dHA4UVhKTHkxWnhYSnBDdjFCc3dEa2JUREFkYW5T?=
 =?utf-8?B?V2ZpTnI2NXhSbFdzWUZ6dkFmMXllcXZBL0hpNXQ5SmFOMkdJaTYxVE4zUHk3?=
 =?utf-8?B?ZkhBLytvMnVBV2gzSGRpTWovYklTMzFDc2ZZTi9FOWQrenUwRW1DUnRVcm9m?=
 =?utf-8?B?bUhvQUh0bUllV0I2aEZQbFNETkpoSlVodXBuaFd5TVlSVUhSTzV3QXNENHJn?=
 =?utf-8?B?NEJjUnRxZUJKdXd2TElBdlVMZTdnVTR1Z1o4VkExY0pXVXVGazRKNWdRUi9D?=
 =?utf-8?B?MTNMd0gzZ0hrcnU0d1lWUWhIMkp4QjBlV21zaFN1MGdTTTFaTmNiVkVuN2ZM?=
 =?utf-8?B?OVQvd0VyaU43bS9zTEtwUk5tSnJIcUx4VzZxeit1cTE3MWtFRU5zb1lCWVdL?=
 =?utf-8?B?VVZ0NUdSbnFZU0ZLM0VQdFVlV09HTVRVVFNla2tNRE9IZk9RTmZBa1N5SGZl?=
 =?utf-8?B?VUY4L21GVDJsdEtBeXl0R0RBSG5MVDN0eUJNRGZiNGhVVkEzc0dVMTRMbUJy?=
 =?utf-8?B?YVErM3QzT21yTUUrM2hpTXh3UGVYOVI5UkhVV1Z3MWdmUUJiaDZjcXA3a3FL?=
 =?utf-8?B?WXRLbzRJYnhUdWh5ZXZMMXV6UmpVb0hZRDFDOTB4RU1UbkMrS0pFcDFYZUg1?=
 =?utf-8?B?UWRTaHE4c1dEb3d0elRYTC9Cb0E2d3p0ZXZYNTY2dkt0QTFhdC93YkkvYVNt?=
 =?utf-8?B?UTdSTlhwNHVHdjZqUklrTlU4aUJEQUc0NDk2MEo4eC83dWI2RVBHWUMzNjJG?=
 =?utf-8?B?Mmx6dFBpeGVXcU5jWlNOcXdMK0dpZFJXMFY4Z3FTMGEvUFo3eTYxZkFVa2d4?=
 =?utf-8?B?aHc3WldqZGNva1ovNElHQytSWEVBZWVZV0ZnSGEyNTlyNllYRVFUQ1FMZlZD?=
 =?utf-8?B?K2hHa1R2bXhjNGVLWDk1NldhWER5RkcwaW1heWlxa1hxbmtmZzR3bWxKSFhQ?=
 =?utf-8?B?NXZwK2h5eXRncWd3UXNTYXZFZllvRVBhbkh5STJ6QXZZNHNyUWRNMjF4Zkhr?=
 =?utf-8?Q?iHBJSjAlpU0AuYD1OTrbq1m24?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08009fc4-95f5-4f2c-c263-08dd2ee8d20f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:25.0063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oO7Kju74ViMt6Exq0a/C1Af/AvbCaGW+VNUdUdlihcZtDvfkady65Q0eLjpy5aLghFOGsukYlU1iWCOoPEk3Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10523
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

Enable dynamic settings to mmcdev and mmcroot for i.MX8MM-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mm_evk/imx8mm_evk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/freescale/imx8mm_evk/imx8mm_evk.c b/board/freescale/imx8mm_evk/imx8mm_evk.c
index 4c4436af3b1dd7e796e48458488d2df4e60c182a..d41db8d31d81b44b86a7aab5fa57d97d99e41a05 100644
--- a/board/freescale/imx8mm_evk/imx8mm_evk.c
+++ b/board/freescale/imx8mm_evk/imx8mm_evk.c
@@ -59,6 +59,9 @@ int board_mmc_get_env_dev(int devno)
 
 int board_late_init(void)
 {
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+		board_late_mmc_env_init();
+
 	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)) {
 		env_set("board_name", "EVK");
 		env_set("board_rev", "iMX8MM");

-- 
2.35.3

