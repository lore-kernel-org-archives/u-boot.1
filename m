Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD54FE77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 06:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76BFF80619;
	Tue,  7 Jan 2025 07:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="p/ZPcUDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9505480612; Tue,  7 Jan 2025 07:59:19 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95BEF80619
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LY05j7+4WjD/OHxzHrb4Eijg4vRcZNU9U2x4r0M9uqMsSScS1fYB5JZ9nRqd4Wxxw3DPQVHvgyu/tr5vUOPNIOsQhmPYraZ5dgsBmMXLQkvRXidxKzkn4Ga+ri3VJeYkTBSIlqa2SPcORkxa/T0x4wPkPi3Ypq5COMM8pq+kFi3fKi5clI/n2fM9CiFeGm/S0utaEc5Qvd9VLPDeoYrySlgoiuRwDfUvcpW64XxHWjXchhuMBzOGQxj/s1OliReptT0O9FD8WdkX+JvDC6DMydoNBeHBT5lDvEbdm96Kl1kx15dJ/C4fxbPRg3FN0IO9s3MOUH2X/UXKGwDJhZgRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yhC/dNX+0FmZ3LNXyiOBPVeIQm1JcxVfHq/g1pNmV4=;
 b=VeFRvPuM41gVor7ffHk8srtm633E0N/KJevLYuA6QNME5VvXzafoMBRTIOsjG4F2g43UTeypIw8S3qzh9Up5BqhM3BBW+GZH9oXT3ccYW0oUGqQOAW8000cjGvN2QbFjLqN+cLWYnbZEaRDen5pmlDshKPpavpuW/uwXwRKyNA2XHxgWHDluU1NiRwerf5t4mPO3Jgnr/0mBHgHdVAkqd1lCcL4K1rzWwZOOtSLPkN9kDDTufYZVRvV0U8C938jZ1x7UzDo+CPXUycASr3r4swQIeKEf0iftAHs6dW9Q/OtLyysK5NSRWpSgTrri6xrAov9R51M1WLoa2OiVKsZmzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yhC/dNX+0FmZ3LNXyiOBPVeIQm1JcxVfHq/g1pNmV4=;
 b=p/ZPcUDCKTCqfUS2OdnhZmnr5/Gn/YNhMlzoBpqEJmB2BjEaHzAeDPOqIz5+JWDwuMMAkT2bW8VcIue33O6x0yKiXxztqf4Kwg5coemuzX6/N/Auquyku0JGAawfIkDKVvl+8iHPsnv+zFtJQ5ozGmaxHukVn+nnMhskcj7T96dLmtZqsZs3ntqDJQShMA/MVjo8p+yXky5vefLkWYtHkc1G7FkOtifbJGk7KCXDSfgZvYO052oU8XbHdWl8fbDRlJHopwK4N0JwUvxagPIohu1PvpcHgKMSGmIxWUIlu1rXzXx1nVihRtgKrBq5ckM/4hDmeT0Otg491AtKTKXtFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10523.eurprd04.prod.outlook.com (2603:10a6:150:1d4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:59:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:04 +0800
Subject: [PATCH v2 04/16] imx: imx8mp_evk: Enable dynamic settings to
 mmcdev and mmcroot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-4-97671b1694cd@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 935df681-6bf4-4740-2449-08dd2ee8c8b8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDB5L2RWb0JDOWlCMUd3MWRqdWpTbjMxSmE5ZEtVMFo3T0RESTNYZGJzdWps?=
 =?utf-8?B?M1FNUWJXb21jZCtYZHpsMktqcWVXVmJiWmducmkvYk9PUTVnVWhTbWdpdE96?=
 =?utf-8?B?eHdabnZrYzI0UlQreklodnlxV2FRZUlMM1Z0cGFKdnZHWVkxZit4YzRWYy8y?=
 =?utf-8?B?Q013SGtYRDNYSGpuUVBTSlR5OHpuQy9JN2lVbFVFdzB0MGIyWitpMlpyalRq?=
 =?utf-8?B?QnZQeVBxd2J3V2VuR21FRkFLSCtoYlRqSFdQU0tpdVE2dFpxR0ZXWlo5N1Zw?=
 =?utf-8?B?T1JTVitqTExtMmdoeXNFQUoxM2NaTTdCYTl2MndZY3hQUFhKSkVreXBieTVF?=
 =?utf-8?B?WFl6a1d3TTZZb0VEN2UxWVluaHNNbUlDTHFtVkxTRHlyUmNHTTJmUVRYTHcr?=
 =?utf-8?B?L0dlWitKbXFSQTMyZ1YweFNCSjFoSlU4dkd4WWFoSHMrSGpqRzBPOFp3QVds?=
 =?utf-8?B?dGxRSU9yNkVPTlF5QVNKKzJPbzVCcWM5bFlnYW5DSDVUNWNWaEN2ZDZ5ZTE1?=
 =?utf-8?B?a2RxREkxWlE3eWtoS0JESGJwOXlnVk4vaktiSzNPSllTZXZyaXkyb0x0THAv?=
 =?utf-8?B?R1BNVStOWlJzSElRSWtHZCt1V2NQUHFCY2hpUDdDWVA3UXpQaFM1NExHaURl?=
 =?utf-8?B?L0dYSHd3MWtVT3BUcUVlYlVBMWx3cnJkTmhab1Z2TlNoaVQxT0s1MG1hVklk?=
 =?utf-8?B?TjhqOFVjbVZweGVxa2F2T2l1bUt4ajZMYTY2SnlXM04yNi9ScGFhOGh4RW9y?=
 =?utf-8?B?YWxValBFVWN2elBZK2tITm9TK3FSMmh0YkJqejZOV0RScHZkVU5NaXl5ZkJq?=
 =?utf-8?B?eDZHSlZ0VDBjc1JsRDRVK0RCRXlBUnlMcGFVMkVER2o1cWc0SGpqSS9NQ1RE?=
 =?utf-8?B?aWg0akJvUHdGdEk5a3NlT3habkdKekJvUThSZlVJdkhvUndFRkdwNjBMVml2?=
 =?utf-8?B?SVhudHNQNGFkM2VLcGhycjVCOGxXZ05GTzZRNHYyUlU0VHl1ODB0OVNYN3Jk?=
 =?utf-8?B?Kyt5cG8yNVNlMG5GVWRCVVk4SUhNSzlJVDdmY3crTTYxcjE0SzZPNnVXb2dK?=
 =?utf-8?B?bnh6Yng2a1ZiVUFVRG1aTEdRSms3QnpDc3BxSkdqanJ1amdZWm4vWkpKYUt3?=
 =?utf-8?B?VUg4czV4NjRtektLV29PZ0Y3T0s2UHh0SEZpRUdsQTBJcmR2NFBFV3BLL3lD?=
 =?utf-8?B?T3RHWDdndHNYMHNWQndOQlNoY2ZuTDRTN3l1QVozRFpXZ3JCU2xWeVU4TlRW?=
 =?utf-8?B?MUdGQWxGUzlJRWM2Qkh0RDJvTGtNUFpGdnc0TlByM3BycDBtT0hNbEJGOGNj?=
 =?utf-8?B?bnZMdDdTK3FLZ29kRFlwTVpadEtwdUtjdDRRU21KRmpReU5UbVJwMCtncjht?=
 =?utf-8?B?M3Y1K0trOHQzQ2ZOUWFGREMrd0UrTTdaaVFENi9wdFFlNWZHb0Q1a3VLRm9H?=
 =?utf-8?B?ZG1LSXdCTTBCbGl2NUtaOVNjMkt6c1U3RHQ2Mm5iZjVJQ0JlbUNlWjJhUXJH?=
 =?utf-8?B?a21mYkZDSzFqcFdneVFkUXlVMGRTMSs3cklsUGs1V2tIK1pCcGZQTHNwckZr?=
 =?utf-8?B?OEtoWERqd2YxdVZNQWpscGEyVjNyaytOOUVqYVhya1JwQW5qcUg4MEg1NEJB?=
 =?utf-8?B?TnU4bWN5akNWb2NiZE1yek9jY1AzWUJidy85MmxaQkpwWXQvcmI2UHZBbFds?=
 =?utf-8?B?RFBnTkpLMUJiUjlMc2JvOE5xK2tDWFhFQXk4T1JmeU9wZ1kvdEgxMWtwWHhh?=
 =?utf-8?B?NDBwRDgrd05XL0ZuZWpxYUN0dkdjcW16ZFVJem9LVDY3R2dYNE1xR2ovazNK?=
 =?utf-8?B?NTIxNUhRd1dMVXp6QVh1YUkyc3FhVStOTnkwc2JXd0RwTWYyUWpkSUpJMTds?=
 =?utf-8?B?YWVqTlcyck9GTDlPUG1lT2xZNjRYbU9vV0ZzYkdiSTFtcEowK2JwaGJJejd2?=
 =?utf-8?Q?RKeNq5ZepSfHSfGPjvMJ+wqzLKGNVbCH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWhmVC81Rm1PS3dHNmxWNjNkYWp6aGFRMzZzZ0lpKzZZdDZreER5ZnUrYUE5?=
 =?utf-8?B?ZjB5MExRa3Y4Y2tSb0dtV2FQdHhaMDV4TG1OeE9XNjNGUWVHaVJwSC9DNTRC?=
 =?utf-8?B?UXBXMFl0VG5wMzU2NVFreXJRa0RTQUZicGNvZGN6TlFpYlVZQ2FkK1UvbWxR?=
 =?utf-8?B?aUtnNzBJSjJmM01VVVFRSGJiRmhab1N3Um1uQThBdmtKaHNzQXA0VmZQYWlO?=
 =?utf-8?B?ZnFtSS9yS0MzUHhxNXU3VTIzcURkMUZkNVFkQVpUUk1aZlFlNzBseU5qeHVH?=
 =?utf-8?B?ZW4yOGZBMkVRWG4vdXI3dEM1RnFUTW01eTh3VXlDclVDcDdPZVU0NlRMVi85?=
 =?utf-8?B?bTNBMGg4d2VuTW5oT1Y5Wkd4MUo4VzZHdzNScTh0UXJxM1IvdmRyQzFVRjB3?=
 =?utf-8?B?TzBERVpEVktPVFBEOHd0dmgzTjM3QklRa3F4cDE1SkpNVFdlNlcrSXZMUFBR?=
 =?utf-8?B?NmlLNU1wQUtHNW5rdHVMUTYrak45c1dxUXh1WjduVkNTV2pFWmRkNVRUN2VK?=
 =?utf-8?B?azM4VGRXVXN1K2g5RkNkcHREZFRqUGFha2NXTTZETUVFdXlDYUx2Rmdza1hZ?=
 =?utf-8?B?ODFuUlVKLzZxZ1VEemZ6VTdPMExJN1VyUThHZlVlUTFQR3pVYTgwV0FPdU9X?=
 =?utf-8?B?dHJRT1pRYUVQVE5VUWd6eW5md1hIdjljdGNZL3ZWUmR4dGcySVhqY1kxMDhJ?=
 =?utf-8?B?VlRnczFFZys5VlNId0FUNWx3SDZGVmJ0WnNLTXhuWFhhbGRVb2RrN0RKdmJX?=
 =?utf-8?B?UGFxcElvSTRSVjR3NXk4ZFdzdnBvZVl2akQyd0Y4VlU4U2ZKRHdLQzd5amZn?=
 =?utf-8?B?bHFlaXZqT3hYL1F2c2pNZlE1a2JET1IzYVNDZFlOaVBtWjRGaTNiOWtSZDNW?=
 =?utf-8?B?a0g4UXdFSE40UHdQM1hRUm1oTXliQmFRTXpEQXFVeTdIVmVxbUhtN2p2clNC?=
 =?utf-8?B?SXJ0SWxGVE56UU4rL1BVR2F1ZnA4dG1zMjVValJMR29HbTR2VTNSWExNWDlH?=
 =?utf-8?B?b3J3bHZRbGs5WTVodURZK3pxc0hOMkJjSDM4UDVZbHVmY09Fb1BFOFZ1d25U?=
 =?utf-8?B?SXU4NFFBN2pYUTU2TU01WU5LL0xGL09zVE9QWVdGYnlHL0dCTGg2cWs4cW1N?=
 =?utf-8?B?WkZ1ZUNwZzNiMmdJd01QMHhabERMNkcrM0x4bzVLZWxDTHZCVTlHcUZKTjVL?=
 =?utf-8?B?bEVSOGNpVC9xUnNTN2lxNHNjWHlSR1J3K2dQTTZndEwrK1ROWDVOZFFFN2dC?=
 =?utf-8?B?czdVaUhUWGZKck1JeVlFU2w4NGZhYUViZitPTVZLRkY4OXZUT25xUXBRYjBC?=
 =?utf-8?B?Mk5uNzNlRHE4Z3dzK2tMRFhLTEh2TUtNM1p3cktFdVFMNlZqMTlRMm8yQVdW?=
 =?utf-8?B?WiszaXF2ay9lNCtEczFUdUo4YTV2a2tacTlMaHdYcWJpZ0xWS05id2IvQjFZ?=
 =?utf-8?B?UHdkVm90ZmdmU1hOWFB6ZDVxVUdscGY1Y2hRMlN0WHNBUGcveEZvWktPbWtP?=
 =?utf-8?B?eTMwRjlqcVlZeTVpcHpwU0dpdjVMbTFjSmlObU5lNlZZMWxZdllaMTk4aHE4?=
 =?utf-8?B?WWhNekNvVHFCN1lhYUowRnI3SU8xcUJqcmxCcU10M3lVZHVqd1Jna25MTG1W?=
 =?utf-8?B?TFdRNldxamlYK0ZLZHl3cENPSHlkY08yMkJSODRNZytUM0hkRE5oWGp2Q3Fv?=
 =?utf-8?B?R1FRMWZBVWMyY3g0QTFDSjRLZ0RiOEdkNWpyNEdWS200QzZxRldSZ3BNRnU1?=
 =?utf-8?B?R1FTSEhIdW5kdDdDUXNlSXNyWXFObXNEejhBcEZud0JqR1lpNTBzc3ZPbDlj?=
 =?utf-8?B?aEtOd0lFREpmcXhPOWxjODdzL1hWVWxDbEtsTTVKVGhlMEJncXRUSEZFV0Fp?=
 =?utf-8?B?YlhmbDBod3VrVHl6WXZ1M2FRS1A4anpSRXZ3RUNMVDNNS01ML0tWSm9uOGNT?=
 =?utf-8?B?ZU1CdGVzdzJmOURzL3h0b0tVQXhEblA2ZmoydWF1UjZROFluRmtJaHZQSFFZ?=
 =?utf-8?B?OTZ0aWQ2UXdra2U5NDVURGY3OFROREtkeS9GY3pCTUt5OEJqZFlpd3dhcFNa?=
 =?utf-8?B?K0tnNHYrdnp5dkIxZWk3b2Jsc24ySFRyeC9OQmRnMjNkUDBRK2dlWWduQXNk?=
 =?utf-8?Q?45nKQif+w6KrRtO3pney4WStw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935df681-6bf4-4740-2449-08dd2ee8c8b8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:09.2046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQiRj4BrC8omMZVurqJmgxLpmBsrlgBhAKfVOUDrDt/Tny3ZEl7g0fKxsZjaVI0x1WSShR4DfL5Jjhd0AGTECA==
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

Enable dynamic settings to mmcdev and mmcroot for i.MX8MP-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/common/Makefile         | 2 +-
 board/freescale/imx8mp_evk/imx8mp_evk.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/board/freescale/common/Makefile b/board/freescale/common/Makefile
index c2c86c0dd08252e8feef5d2f2f5176af408020ac..468a06725c1e470d0d36f79e8a25e31799562e9b 100644
--- a/board/freescale/common/Makefile
+++ b/board/freescale/common/Makefile
@@ -59,7 +59,7 @@ obj-$(CONFIG_POWER_PFUZE100)	+= pfuze.o
 endif
 obj-$(CONFIG_DM_PMIC_PFUZE100)	+= pfuze.o
 obj-$(CONFIG_POWER_MC34VR500)	+= mc34vr500.o
-ifneq (,$(filter $(SOC), imx8ulp imx9))
+ifneq (,$(filter $(SOC), imx8m imx8ulp imx9))
 obj-y				+= mmc.o
 endif
 
diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.c b/board/freescale/imx8mp_evk/imx8mp_evk.c
index 024b46ef8bc28bd8f6085cc9cc290b719b37fd66..2ff067bc6752135f323398e620e37ef11d1b91bb 100644
--- a/board/freescale/imx8mp_evk/imx8mp_evk.c
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
@@ -3,6 +3,7 @@
  * Copyright 2019 NXP
  */
 
+#include <asm/arch/sys_proto.h>
 #include <env.h>
 
 int board_init(void)
@@ -12,6 +13,10 @@ int board_init(void)
 
 int board_late_init(void)
 {
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC)
+	board_late_mmc_env_init();
+#endif
+
 #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
 	env_set("board_name", "EVK");
 	env_set("board_rev", "iMX8MP");

-- 
2.35.3

