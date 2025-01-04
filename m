Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B0DE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 03:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84EB180384;
	Sat,  4 Jan 2025 04:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J/yDJo8E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B28C7803C6; Sat,  4 Jan 2025 04:20:06 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60324804EB
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:20:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDl/5HLF8DL2C15nXNpu0+x/pEOjlh55ECqpPZuseBoOEFExCbgLcf6xBUkThA/SUWDhwJptFMBxQeiD5Fum7Z2mMOzB9BSCAlfO5tj63j44FS7YYgdnAXFnNRaliVHHUwA+SZolq6d0SSnPicf/LXrdGMIb+mPtp0MYVWFgNi5KT0FgDr4/R6SkVaCBl3qzqmFVdZ40m3hC+E6X1ioUO/EczKZcxudvY7MFqCw+TKAlLZKFi8xM+yGnaE5S+sOlWtR8lfqfgiwfD1O97axXDZoQsz5Tno7fEgUVLplypMwUuMuMtLAZfkPOTBrLmjCvU5eeIoczbfqbulWNbEvoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZGJNRa/yAdpxBrG9KEAWzgOfypBe9Xfci8XZ/XPwxo=;
 b=kcwGyfB9poSnFwk2+GXNhfpZ0R1jYwhamFmNm/+/hSoxszOCLn242By3FD4eq/GahoxiyAq5ltRA1PyCVBcFqPDYg+GDCfdMJb5hNO7DJAXoNjls3ZSMAlMS6mnFXyJ7GUI7HoFzVOyfLrl5TuXia3pu00swHqh8b+HI5tw79xp1HOwD3xuBqPD0KMuxvi669xaR6kna106NNE7Z1feeLmyDTJrlUAtjtXhIKD0siZ7vI5Io4KOA1DSzGaR/MQbX0KFnJHRsneD4vXkJ4dgQ9d6De+exOtVuA5hXpGn7PUWNZaVXemhnPvpvjTlHYYqP12xymImMAR9qpmndPZo5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZGJNRa/yAdpxBrG9KEAWzgOfypBe9Xfci8XZ/XPwxo=;
 b=J/yDJo8E7wQ0jUPS2Xqo1CZKTMOtkqRkj5FEOhCTk0Nrpe656nlFWf+EYhc4pjpW3I+KlmgIuxXfd/z8Qlg4LjqKREzJXOgRRtvaconT1tA2B7XZdjMQMmbRZs9mz+hp+TSPnsSjjSG1nJeO/zzEu0crwwF6h3WS6QCKqPL8hjK+xIJjKjANaY1dLgeZL+McecvzJOI5wIAPuK30ptGxFtPIYpZzYCoV59CdJI1eAMUw85Ypw7MpnGkkI56LgDYu4SqbnvXkaTF0METgRVkBfVBgZvzUrmFf3Hmfc79gY1/SmmxEBEt3j0scjiJIRK1FU1DUVtz4XfAlrQ5irUEcwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Sat, 4 Jan
 2025 03:19:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 03:19:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 Jan 2025 12:25:44 +0800
Subject: [PATCH 10/12] imx: imx8mq_evk: Enable dynamic settings to mmcdev
 and mmcroot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-imx-bootstd-v1-10-e09618cc1d65@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fce057e8-9ef9-453b-015a-08dd2c6ea998
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXFDSGNkK2U1Z0FxQ083RlUyWlh0bFhlbzlYWnI3aitKWHhleE5aOGo5dS9h?=
 =?utf-8?B?ZTNNTFk1SFBTd1E1Q3BVcUpJMnZhODhiNG9LU0s4a3VWUlJHRmNXZ2VzWDFn?=
 =?utf-8?B?ZHFsdHB4NFFjbW1iOVJINFI4THhQQk1YSWVvbWVvUGNzR3hHZEpteENJVlpI?=
 =?utf-8?B?YXdQc1FQVVlJMWdIQ1dUMW9jWG9HYXBFN3owNVZYL3RESFFMSUpEQVVKRkp4?=
 =?utf-8?B?blFYdW0wUjJlMUNha05ORzNIeDBWc3J5eHowS1VTa09LV3puRTA5MDFVQTVv?=
 =?utf-8?B?VnhaV0NLS2hEd1lOcHN2akNKa1lUL2s2djNhS2JFb28yVnlHVXlubXp0ZHVT?=
 =?utf-8?B?WUVvTGFWR2htbzdiQzl0eUZ2emdScENCQnI0VW8rcnd2OFJGUWVIZDlBNXll?=
 =?utf-8?B?dlFidjd3WjUyeS9PaXhmUCtTZ1NkazFwaUtZQm1XYXU5amRzamtZamdJSlpL?=
 =?utf-8?B?MzUzMmZVa2E1dlJMb1lGa1VDZE1JZEJ5MVp0U08yMEYwT2IweC9FenB2RFh5?=
 =?utf-8?B?cnVOZ3JPakRZN3YybTE2WFFkbVFnajJVc2VFbFVOR0VkQnZpUG1KM051TjYv?=
 =?utf-8?B?RmFXY1VQamE4eUJmckZ6dTV3V2dwSHl3TTNycjF4Y3V6aXQ5NURJSmNDc2hv?=
 =?utf-8?B?T3g2N2p3OXgrNTF3U1BzaXM1czdJbjl1NTg0UHdHUEZLTkx5WmFDREV4Qk45?=
 =?utf-8?B?cVJ4a0ZvS1lTd0RIQkVBRjRxQXhTZ1FxbGRNNk5Rak40cWwvaEtUcUxoKy8v?=
 =?utf-8?B?bzhCanZsektYd1RmM21BMHdvdmRnSjFJRytEMVQwZDgrVjhSS1crL1k0R1ZJ?=
 =?utf-8?B?Tk5KaTlLdVp3bnl6Nm83aFFwVlRKMTErbTUrdzhFZUkzWldaVlhnQ1Nnb01w?=
 =?utf-8?B?NytDKzJ0Rmt1WGVZVUxIUVpLd1czVUdFeEVRaHU4dC9NZUJzQ3I3aGRMS1JN?=
 =?utf-8?B?akVrRVNhN2poMUppMmNDcVZXQTdKb0l1VDlMcUlLYStaVG9pdExZSzNDVENl?=
 =?utf-8?B?b1Y0SDFicVE5bDdIOVBTRzhpdUxRSlEzZlE4NDJjMnpvalJpWm9vR2ExQURE?=
 =?utf-8?B?OTEwOUVGWVM1ZWhSWjI3a2drMUp0YnYvWFVxYUgxV2hwd1g3c05pWEpoVFBW?=
 =?utf-8?B?VUlJUWRCRm5rZU5XUmplOVdidXFJRmk1T1VzK2IydEhWdDdYajZJcVlpNEJx?=
 =?utf-8?B?QmZYcnFZbWpkQzdRKzhKc0V4TnZPWnJDUXdJYWNWM1NVamVFeHZGT0wwc1g1?=
 =?utf-8?B?T3lkQ3BzRDZtUXVPUUd3T21VSXdDL0dsdWFabDhQUHBRUlNjbFhITWN4YWpQ?=
 =?utf-8?B?NGZMczJQOUNkQzlOaU82MjlhYitCWWVqRTJlWjM0TXJmKzBQVzEwN1lsQlRa?=
 =?utf-8?B?QW1ORTllSUY5RUpvQWhoUFNHVlQ4THpkcVhYVUNHRzlQdXIrNlpzZzN1V0R1?=
 =?utf-8?B?M0UzV2NBcStuZTlqR1lXQlNLbmdKTEV5d1lVSy91ZVFPMEdrR1FMNHBKWUtO?=
 =?utf-8?B?NjhnZ3RLWng2dTJSWHlaMWEyL3p3NFVlVFZTaGRKWUN5Z2NhUFhoRFFTSm1i?=
 =?utf-8?B?b01XUTdWdTYzc2xkWHlrM04rSGRNR2F0ZGFUWlpIUWJXS1A1Z0VRcy85eWho?=
 =?utf-8?B?TG9IRzdaTE1PSmVNclRpOUJvWnBjWGkrOG9lbm1jM1pSam5Zd1l4RHdBV1Js?=
 =?utf-8?B?T3ZVcW03YmRVYkpNSmgzTFowcFZhUjZyTi9TMmhYb011UzFLSXRUTmlEVGVr?=
 =?utf-8?B?MC90Z0ZHcld1N1NpOG8xR3c2dWRPY1pmZUxpZ3cvT2N0ZWlCYXJSdXdrajVB?=
 =?utf-8?B?ZDg4d2lZMkpmYTJ4U0FIaW1RdzZ4WkUzeldESzYzaE1WZ3MzbXBXTlpyR0Jy?=
 =?utf-8?B?a0pvT3BieElMTHQ4U2xPbjhMamt3ZGt2TngvN1BZMTBlWFhsZWJXcG1NNmtS?=
 =?utf-8?Q?5yBLtQSoVmGrIBmxtAZfuICWjy1XUPfh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkI4R1NPL1Ezb1JGNnpWQ2RsbDh6cEtSWEJ0REpRQnhGWWhtbHU4M1hua3Jl?=
 =?utf-8?B?ME9sTkhZamc3MVl5T2dncFNIZWh2TkF4OTlDcmNQSkJkL2lValRBQTFsWnZ0?=
 =?utf-8?B?dTFIWVY4VXYvRXRKd240ZWpTM3haQUgxVmVGZlZqYnIzRTI3RUlibVluQ0J0?=
 =?utf-8?B?MTN0QlR1YmpTN05zbGVSSG8zOXBYVjdnWUh0ZkFxWXZ6TnU0ZklDeFRibU1w?=
 =?utf-8?B?UERvYWdzVVNMcHVZR2FEbHdYdW5Kb01jRkhpY0Izc0RTRm8wV2ZEVE1lNXBh?=
 =?utf-8?B?YzR1TjUza216dkt4Tm5YWW1nS1NPbzBYSXF4NWw0TzdjMWhsUFNVMEE2enF0?=
 =?utf-8?B?VUM4UEdoNFpuR1ZXK096eDJEZGRKVGxCL0FPUUtUQ1lKdjA2MEtXZEdneGZv?=
 =?utf-8?B?Vk1TbzNnRzI0Sm1XMzVFSlJPZ1JRUGpMc0tWbEh3eE1Oc1dtV3p1d0p6QzE2?=
 =?utf-8?B?cFhXNytLd1BXWC9OZmM5K1lpQVkrcGZKMENTQXJ5UlR0SDByUHdNWFZhR25D?=
 =?utf-8?B?SmxPRVNrN0c3bU1NN1NaM3NYSmR1bmRCbEYxaXVVMzJxZndwbG9KVkZ1cmpZ?=
 =?utf-8?B?VlIrMHlCYU5DS2djSmE1aHdYeUhYSW84b2ZjMjlkK0RpSU5tYjIvbi91SmlV?=
 =?utf-8?B?SlEwMVRLeElPeVBDaGloREFBa1lsSUsyc1VsVnB3c1l3RWYxaDg2WEtUNURK?=
 =?utf-8?B?R3Uyam5oNGdFSU5jV2dqVXpFRkM0RWVnZjYveUF2K1BIbUFVZU9aMEZOQllS?=
 =?utf-8?B?T1dlMTNVbHltcit5RFRBdEU0YWQrRk44bGZCYkZueDNzcjN0anhTL2J4eG9M?=
 =?utf-8?B?R1hTamFZUS9iTnZlRm9NRmhYRnJSbVVLOEY4QnFmV2tHRGhnRnJIVXJNVDBv?=
 =?utf-8?B?eWlUc3VpL3JRVUxrMFlZZ2d4K1o3b3dpY3pBNjROVXE4WnliZzQ3ditITTZs?=
 =?utf-8?B?NFVDTk1hSWw4UzB6cFFubkx6YkFia3ZmeUoyQmE4SWtFbGxhT2Zvb0VyVXJF?=
 =?utf-8?B?MS9tWnpNU1o3L3NBR2t0NTl0RVRDdmZnZndpejZBOUIzV21GMHJsRWo0UVBm?=
 =?utf-8?B?eWtsNzh2ZnM3am5WKys1RHNXOFI0V3FHREl4YTZ6eU5VWVJMV3FWLzN4eUpB?=
 =?utf-8?B?QlE1ZDNvd1BENVI0RFhjM1B0V1dOeHUxeHRzeDhKQ0RQV0YxUVZ1RnI5bzNQ?=
 =?utf-8?B?T0h5T2kyc3VNWUh3QXVpUHFrTmMxMVRQeVQ3S0RRMEpwRG5OL1FmTWoxTWw5?=
 =?utf-8?B?L0RnZDdiVHBHZVAxT2M4S095TDdVOENGWXZHQ1NmU0RPaUw3eWh2Y0dMM0dz?=
 =?utf-8?B?bzFpUDlsSnZLVHIxUmtCNDA5UWVMdVZmM3BabjN4U0NTS3dpSEtjYzIzbFAv?=
 =?utf-8?B?OFZBTTN3b0h5ZG5hanZzdk5hcGh5bHNRZ3A0K011d0pid2M3VUZ0N01uSkp3?=
 =?utf-8?B?bkNlMW1aWXZzbXF2azdmVy9La0dPTnB1dWlMWFNzYlQ5a2J0N2UrREZtV0xN?=
 =?utf-8?B?cVB2dW5oM3RkWGliK0t4bUJNMXUyREc0OGdrckc4a0NhbERyVGpFbnJERENG?=
 =?utf-8?B?VjM3dTAzaUZPT3JYdjdFUEVLVE5iaGN6eFR3R1liOHhqWlBJYy8xWXd5bDJj?=
 =?utf-8?B?WFp6Ky92N1d6NXA2UWxHSXhQQXJVVVoranMyWHJydWEydHJ0b25NQkxtMFBj?=
 =?utf-8?B?OTJrZDJ5WU1XTmZOWDNNNHFwOFVKbHJWNGR0YUJpdWlCV09FKzMxcWM1QUpK?=
 =?utf-8?B?bDhiWUg1d0pORW4walIzQk40aEpjTkd2VFFuS2N5YjlIbHU1SDlhQm5QYnNp?=
 =?utf-8?B?YWNmd3JBMzhzUUJ4aWUwNnZoZmYwVWxPaUdKR3pUY2RJSmo4WFBnVllsSWhE?=
 =?utf-8?B?NWJzTXc5cmNPWStLU1I4b0poRGwxRnlUNVJ6L3Y2bGpWd0RjWkNUVit3dUpV?=
 =?utf-8?B?OU9iMlh4WDhGNUcyZ0lNOFlZMXUrcVl1aTFYajV2TS9DeklHYitTTGJlbHNS?=
 =?utf-8?B?SFQ0WVVNRlJ3b3lwdndvZWVFT0lYUFlObTZrWWRpZkRYUllWRHhFQmsvTnFv?=
 =?utf-8?B?RVVNZk8vOEdDbnEvaENsb3doNlY3eGdHKzFkcG5QUnNNWW92TUpQYWVRV3d1?=
 =?utf-8?Q?XvIseeLTUy1LEjQs+q3I4SlFu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce057e8-9ef9-453b-015a-08dd2c6ea998
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:19:56.1283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwvtQmvX57FZnXp5iQwHwYKNvbGc9jO+T6dm7/16g3XtEbIAvZP/5x3eVHpdbmdbSbF5ZKMF80iFi5LiHAd2vA==
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

Enable dynamic settings to mmcdev and mmcroot for i.MX8MQ-EVK
Since we are here, clean up the including headers

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mq_evk/imx8mq_evk.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.c b/board/freescale/imx8mq_evk/imx8mq_evk.c
index ab920a4539cdf9a77607e1eba5640fa8a6233436..752a84635b419e834adf2089167460a0beb4b9db 100644
--- a/board/freescale/imx8mq_evk/imx8mq_evk.c
+++ b/board/freescale/imx8mq_evk/imx8mq_evk.c
@@ -4,29 +4,10 @@
  */
 
 #include <env.h>
-#include <init.h>
-#include <malloc.h>
-#include <errno.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <miiphy.h>
-#include <netdev.h>
 #include <asm/mach-imx/iomux-v3.h>
-#include <asm-generic/gpio.h>
-#include <fsl_esdhc_imx.h>
-#include <mmc.h>
+#include <asm/arch/clock.h>
 #include <asm/arch/imx8mq_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/mxc_i2c.h>
-#include <asm/arch/clock.h>
-#include <spl.h>
-#include <linux/bitops.h>
-#include <power/pmic.h>
-#include <power/pfuze100_pmic.h>
-#include "../common/pfuze.h"
-
-DECLARE_GLOBAL_DATA_PTR;
 
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
 
@@ -69,6 +50,10 @@ int board_mmc_get_env_dev(int devno)
 
 int board_late_init(void)
 {
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC)
+	board_late_mmc_env_init();
+#endif
+
 #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
 	env_set("board_name", "EVK");
 	env_set("board_rev", "iMX8MQ");

-- 
2.35.3

