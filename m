Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB40E77188
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E2A5806ED;
	Thu,  9 Jan 2025 03:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PXppIaBm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1202180654; Thu,  9 Jan 2025 03:23:44 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CD8380602
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCMsTPxSDQHumXy26WpiYoh32bKCf3TyofjVLV+rNWck7t9zqP+Y41qIJLzVPfGtU96bEvbjQNC6JyRnIo8AurbSUPUY7A9mrnv4Y99KWWmGFDD+Fql8SRy9fxWqHE8aTuCBNXp+xJc5VbTej7hjzE0apAbaefs3cHHsAqI7Sjx4KAPYHpLbyV1c9FV+IvgH+1PNVEDY5+E707Aque8uGWwHOvJ5KcezCaum6ewvWS9Ml+mnc1aQM446dOQi1UYHzxFJ8yG61YTezXurKwjjFTX5NR8LHQXxTX+X4jLhjLNToymznuZY20E1zy3QYmyugAqymZ5oP5oKsfwic/sl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzzueAfaaSkuTwVeSVpjMEV6Dd63tC1lLr247Doj82E=;
 b=Dm9PKW0TjEmq+kwxtl9XxP0gnNO7QqT5VKGWEHJsmqFz76NoSKBvSzIE6x8XFF2zedkDrYZnQYoiuW5DRq136g5GNCdYe/glUKYyF0W9B2XYkAjwC0eISD7G8zAnbI2aLkndfYxAARLbneZmkK45h86aT+zFQio9g9gbpBQ1OkWQ6tu0KziokenMOcmViFRaKKKmQRCEkNF4O92++SsbfaF1ZENgk188axeLBgln9Pbw1tpQ3cFLAmyTrPgruVq+1y2MOeWOPNwuoNuI8YtKNUGQDtjfuDtiBO/GzUhOOjIpCqwTd49WmxbTkyWz4jvMq4mWQReF+RLdPAKzIDztcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzzueAfaaSkuTwVeSVpjMEV6Dd63tC1lLr247Doj82E=;
 b=PXppIaBmAmM95wsiQMwARPYTz20p58CEn6yxocnLnjzmjeuwOu/rDwM8RRiaoWJ/5yEHdEYYtPT2z9UArGducdTpslIGn7Ha7Cg3TPVkYesoTuFmMDVOfGQPaXHCSMZGxhj1lqbb90P3Pa+wInYFxcel+MjI0a1zCRpGfuFEpIPpAanqwwohcdkxdI1wkUTZ+0YzjcIpiba47iMQZjAM2aRzqpdOcZbTiXKoMr9l1NONgYwDQxv0up8cqLeHb//pM3hkVMii5zLfTTQSnX5GQRbVTdLHNxWPS0plkOS56oGnct+C55blbpl0g03eXVbTRi9pnqNWwILz7/JE8lxQlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:40 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:14 +0800
Subject: [PATCH v3 13/17] imx: imx8mq_evk: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-13-16e5fc0baecf@nxp.com>
References: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
In-Reply-To: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f63b4c-e9b8-4050-61df-08dd3054a1af
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTR3N1VlZmhQR2JaNHIwVnIzcStxYldiZ29yWStxNVVEU2ZGdDAwNzFEd3B3?=
 =?utf-8?B?T0s0NlhZSm1MVEdhSzE1TFBoMDRkYlNjYVYzckNjOGJYaHlpMktWak9wOGtU?=
 =?utf-8?B?aVhnRndVVFhyK05xOVRmMm5lU0xHY3FjaEl5KzNzYk91cUNTaGNsMWZTV1VB?=
 =?utf-8?B?QXB6TjRqV2pUTWx4Ym44WWlyQkJpTElueEM1SzBPYXozZkNLWFlXTTR4RTdJ?=
 =?utf-8?B?dmVLQlZQKzZsdjlMWTkzZm5vMEc2ZDd3N1ppSDRDM3l5bE9IOXVadkViQ2ZW?=
 =?utf-8?B?dUZmdHg2bFVUTG9neHhEMVI0dklmaDdIbXNJQTBQa1hDRXV0T1JsejFGY0Np?=
 =?utf-8?B?b3MreTB2Vmx6cnR0S3B4SEFoN0g3RDM0V0ZjdDJTRDZxb1ZRMGtnaFA2aHdj?=
 =?utf-8?B?R09aRmtDVGVCVU9BaVF1d0NWTjlWTlVtMlQrV0VNSnMyenNsTDBmaWV1aEIz?=
 =?utf-8?B?ZjZ4ZUZmaVlRenJ0bEZIb1pSS2tQbkx5N0RaUmhCQzhSRzJvZDVYUmhKdnVl?=
 =?utf-8?B?U1ZZS0JHRlR3UlhHQ2RnNkpHaHIrM3JGV2Z4bUtjWEcxK1ROcEZHLzFYWFFY?=
 =?utf-8?B?bnZ4UkZ4SDkyUzZSZFlncXVMaUk1OENlRFoxK1djaGkwWjRzS2plRWpjZGln?=
 =?utf-8?B?YXgrT0UrbDVUdnRwazQ5UElnZHlBZFdpUUFtR2NIQ3hYMi9zVEhqU3FBZ2Vh?=
 =?utf-8?B?TkNVMWJGZGxGSENVOE9MUWw4NmhIVzFzZUU5T2NRaDNUbExIc3U0cFVkVzJk?=
 =?utf-8?B?eGFkTjlNdFNjZDFYOGdjVnRYSm5BNVJQejg5V2ZmTllTelF0cTkxQ0x2K3JB?=
 =?utf-8?B?cUV2SkFrQWJlNEk5Rzl1WmR3bDZpVndhTUREZTdNaVVFWEZmVlpjOXZjRXBq?=
 =?utf-8?B?TzJ0dERXeHRnWnU5bGk2U2NGN2ZRaS9ONXNqMGhpUXNMMXNiT1QyelgrNDBs?=
 =?utf-8?B?RTByQkQvMVFqR1orMFI5M3VTY003MVdTRWIxU2xqcklIVFpoVVJpb0paSDNr?=
 =?utf-8?B?TlNhYzlLRGZMMjRmNVM5WWpGNEhsTHlSTUdiVFloTHkyNWlpdldHV3Z5K0gx?=
 =?utf-8?B?YkpQQ0Q2NnRja3E3d1Z2ZjZpVlVWMVlkYzFlcDZXV29TUVJWeXJ6SS9ZTEhL?=
 =?utf-8?B?cHllWjNpKzN4Wk1pbU13UUNNVy9acjlCUXV3b3hTVkxFRGh2OXkrbWUyQWlU?=
 =?utf-8?B?azczTWZIUExoQ1VWT1pFUjBvY1h3TUNYbnc0YTI3c1piSEhVazdtYlkvTlF1?=
 =?utf-8?B?a3duSUZGNmY3RUNtTEJ4MktnazlPWTU3ZUl1eXJ6cFpPZU1DTkZCUmdoZ3Jh?=
 =?utf-8?B?VWhnZ2JNb29LcVczQ3NSYThjMkw4ZngweFRmUVNmMTZqRWhxVXFJNk01TVdZ?=
 =?utf-8?B?Z2NvSkM2SHFnL0NaNnBqTmhvWnh5eTdwVmgwZjA2RjFCc2krQzl2SVgxSTA2?=
 =?utf-8?B?VElPMGhFdkNlaThYZFRiTVkwUU5abGkvTHhzRElyRTFzVHo0OXhTbEw3RnV0?=
 =?utf-8?B?bW9aaE1GUElPeENXNHI3TVNNSjhyQjVBMVdDSGZpOUZxUElpdEdwUENkNXgv?=
 =?utf-8?B?UWUrclpaOTlpN1J5Tng4WWVDdVliZjYwV0FlK1N4S1p1LzhWNlhoQnhUaHpT?=
 =?utf-8?B?eXdBN2FJWEFoRVdkVmYxaXd0RmxkNVplaTVaYTBlL0hVU3JzREZzN1YreS9T?=
 =?utf-8?B?TDBIcjhuNUF4bTRjSGlzd1BrNThEdkJmblpIUkduLzBxZGNONUMzTHoyaXJD?=
 =?utf-8?B?clpoM1lmcEI4Mml2Y0I5WDBSbzd3NnA2bFQ1T01sWnVOazZLK1J1bEJ1c2VC?=
 =?utf-8?B?SUEzT3BEODFEMXI3MEZ1NzFtWitkc1FHYVhFODM5d0sxbXZXd0dzaWIrbk5R?=
 =?utf-8?B?ZG8wczUyd1NrK012OEN0TDhjV3NvS1Y5NVlpcE1leHZLRFIrSGRPWWFsYmsw?=
 =?utf-8?Q?XFemdFEJB2Lr52lB1/7DfUcIYWdkVoUy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXQyVXRPd1hRMXIyMnFCNThwamRETVg0WE4vY05USE9la1ZteThkVHJwTFI0?=
 =?utf-8?B?UitvN1hwRE5LTFo5cmY4dUlVTWxIZ21GUFRLb3p0SitEN3BWbW56a0t6K3dD?=
 =?utf-8?B?VHYxNmx3SXM3cjhiRVZBeXdDdkF6cHM5K2VlQlZDRk0rYTQ3MEFDdmlSQWtE?=
 =?utf-8?B?aTBkSG9YaThhYlMvdFFIL21RN2xhdGJoc0NPaVhIblVUZTg4eXUyZHA0TE5l?=
 =?utf-8?B?T21yd1Fmc3BDbyt4RmxpLy9sNUsxdU5XUHJRcnd2VEVoSTR4QWo0c2daWm1Q?=
 =?utf-8?B?dzM4L3UraU9qU2wxOEMyeUg0MHIxRkkrbldYbVNrcnBFVk03NGZkb3NHcmhW?=
 =?utf-8?B?aFdBSVZCS3l4djJVN3lrUFo3R2F3ejE5Y0h2NVZNcUdLTmhVTlFnZmN1VVdW?=
 =?utf-8?B?Zm5WbVFYWVpEWWJuQmJhNUFlNCt3UjBhN1F2SmdPaTBCbCtGM0MzSVhKZHZp?=
 =?utf-8?B?OGM5bzAzRUs2ZkpFRmhzQk02MzBSZGtFS2hGSndFY3hIdmZEL0ZSL2pLbkc2?=
 =?utf-8?B?cFJXN0FPc2czQ0I3WFd4WFREMGlnWWU4bWloMkpwWUdFSVNEVjQrdHRnL0pr?=
 =?utf-8?B?aVJIWGdmTUZqMHQyZHBkdGZEQXYrRTk5NGp5VDVRdFJFNm9RZXI0T0tKV0Rq?=
 =?utf-8?B?Vm4zMkc1c0VFVXVPaG84cUxxbFNYNDlZbVhzU0dKREFLZEFwZWlXMk1zUWNw?=
 =?utf-8?B?M3oxOTc4VENTWkRuQUc5VWJWbC9ibW83UjYrbVVBS1lwVjJ6YjRlTGt4SC9S?=
 =?utf-8?B?YTRqMGIxTmVITWxkUU1VSHN6UnJiTU14dDh3c2x2TkhwWUpmaTlLYi9qeWJq?=
 =?utf-8?B?NmdXRnhHWk1xb1RtMkVCdWZCUVhtMjFYNzBUbFRrVHBGc3RQWjJPaUwydEc1?=
 =?utf-8?B?OEJBYytOOHQ5QmhUU1VRcjhHaTJrYWpVdEVmcHJOeitjNktRT2NjMjJGNEFZ?=
 =?utf-8?B?RStmc0ZtamFrcTk4RVZyaERYajhwVXpwZk1Kc1dyOVlkOFVDL1FzdVNVTTJM?=
 =?utf-8?B?QUVhR3lJZDNJeGNqRzNETFFDemgyU25lZm9MUHZsMFZSd3VzNEg3cm42OC8y?=
 =?utf-8?B?T25jcHR1T3M0WHJxVlBsYkNoeFBJU2oyNDZrb0ZaemJxem5MT1NkQWNXQkhw?=
 =?utf-8?B?cm1xOE5ETW9tRXg1Zk1FQ0ZEaEV4OVFjbks3UVFrYVFObkZtTXhTcFBWV2RW?=
 =?utf-8?B?aEl5b3NLUkdBL0U5a3pOWGtoemJIUVk3Q0xNWFZBVkVLU05ta0hWd1drNEhW?=
 =?utf-8?B?NEpzcjVFdWtuaUZ2a1FKelk5NnVzRElHT1ZKU1ZwZWRtVjE2RGNQdWpGbjJs?=
 =?utf-8?B?anZ0K0E4bW45b1JiNWJyRGhISk5XcUt5YnFLZTRzYW4xNWFORjltSm5NUUVh?=
 =?utf-8?B?aDRLWGt1RGZwazd4OUlsTEFDTzFURXlEZGlsdVRUUFVKck1GK1VzRE43M09K?=
 =?utf-8?B?c3JxUVNIQUhDOGpOYnF2LzVDRy80aXU5TFdyczgzWTlNMWxCa3gzMENialBR?=
 =?utf-8?B?ZTFlUHo2bEZVc0NicDBCaEU3NUlXUE5OaHkrZS96OWs5NHVjR2ZjTmg0bFlD?=
 =?utf-8?B?UWt4RklUdEo5SDBtYk1GMXdoeFJSdExLcmptUE5vYWUyd2VVY1hvdWFHSnIw?=
 =?utf-8?B?UC9xUXZEbnZsKzhFVFg5OWp3bzBQQ2EyK29yYUpNMjBxalRUR0dOMXZxVGUy?=
 =?utf-8?B?VmJzZ0dYT3FzbXI0aDZ4UWUweHBoblpJcDE1NytseThiTUtMMGFyeHpkaUI1?=
 =?utf-8?B?K2ZJSGcvL1NpdjhXRUVSTUNMYTF6c1JnUloxQ3BNTWVnTUtkSXBwMXVIT0E4?=
 =?utf-8?B?cCtGUzhOWVpEbGZsR3BTdWdZM1ZIN1p3NVJQclI3YjJQblVwOHJlZ3NtbWk1?=
 =?utf-8?B?RFhzNHFpci9yOGVhekJLeVlBRzNLRzdic1g1aE1hR3ViMlcxNVVnanZXdUJZ?=
 =?utf-8?B?UHZodWZXVVhlS3M0MkJrVzhrMUJJNEJEK2FxYjlLVXIyNnVFaXR1SXJlL2Rn?=
 =?utf-8?B?ODBmcE9UeFMrZWZVUDNzcEJmK2I3MU9yS0NhUDFBSjBzaXVORndmMFhnTk9K?=
 =?utf-8?B?QzhjR2ZvRFdDdUd1WjhwOGRqNTlGQ3NWNEFOK2tDTlQ5d0xSQ2ZsRDB5VVpw?=
 =?utf-8?Q?ZZAD9r5g347pjvISJsSI9aD3h?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f63b4c-e9b8-4050-61df-08dd3054a1af
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:40.5532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJKsplN0YVAn6LGTDMfNiNi0aJpoIBs66Dt0YzyJuDABmESERdZBIgUhN3gTGD883LLo9SoDegztZzriHouxsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355
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

There is no gd used in the board file, so drop DECLARE_GLOBAL_DATA_PTR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mq_evk/imx8mq_evk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.c b/board/freescale/imx8mq_evk/imx8mq_evk.c
index 64a2f258f7a6f9bbc58466a47efa0098ec2a2333..f833996d5248eba637b443d7bc66141c3aff8f9b 100644
--- a/board/freescale/imx8mq_evk/imx8mq_evk.c
+++ b/board/freescale/imx8mq_evk/imx8mq_evk.c
@@ -6,12 +6,9 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8mq_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <env.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
 
 #define WDOG_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)

-- 
2.35.3

