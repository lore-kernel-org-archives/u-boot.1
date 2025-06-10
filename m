Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86958C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 09:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AABB48070C;
	Tue, 10 Jun 2025 11:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="E+RA+OMh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C0A48070C; Tue, 10 Jun 2025 11:00:07 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07E8C805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 11:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdEcyJWBQMy2I4XgiscK8bM1aacm3P0iiEXF8xMhFoSuZcmMOI03jseq8QCVZuEGo6f0fzZ9IDFV7J2URRI0RS3og63OOdScwNSfJCvSClka/giZJ5BY0B/a8HeiUHBCtqzkr5eNpbq3OcHNMtSRbw3sdYR62YqBrQM17W/RKLwHvh7A/xZppwd5qZXYdEivFoEGXyP8WMyckNXAlamqXntGg2THC4N8jUaDBxKW+8zWqP0RQRosjdRpTPO8FSB1C0VdMfYOzK66ZZKihrrS8gFQ08Bv131BlGLpEgiVoyTRRUn3ryj0BWDhyIpXg4qTco2u+oTydk2ZPP87ZSrVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+tErNcGaS/y+ef4zR9htRngeokh+bmV2YIAABHo0hU=;
 b=b0vRNrW9mO166YRINeFt2/YNx1gMH5svlLwkZM3LbBlFsb+ZmjdX/2e4XC7R0083AiA8Ox3wbm4O+pdNbScsMbyOQ+BXsdxM50TtW9CWTkNvZLSpD74wm4+QjMp+xkJdXB7VdSRv83clRyREARimGOkWUm7n2md2Yo3H+nQoz7kink8aKSIQ49DtdZsABGz2EwBxKDpVKTs2kAY1FUw7LvbR/LpNeE0UYhq3Yy33E8Pv8gXRmDUamnB/buJJNst0eo7Bf302uLJLSnHA+btZ7WJd0jRKeW9QxZsIobClU1dsYtO6PMyuFMQPFX7yVozGHxpTF2JGG4u3PfalaeBVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+tErNcGaS/y+ef4zR9htRngeokh+bmV2YIAABHo0hU=;
 b=E+RA+OMhPO4gyX1jaz0anYG+IMWPdzzGyREO/OQg7AfVKUCUtmywoDq3DQD76HkqgKQ8IwaSmwLKDUDa5JLhZ1PPn7l2voh1TVupDO0G8ylScy0V6JQT0uPNJt9psaQGWdMAoO7dkD/AXe94JIdMRQg9DhHhuUfFRrszRhLxzOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10964.eurprd04.prod.outlook.com (2603:10a6:102:490::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 09:00:01 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 09:00:01 +0000
Message-ID: <e1a6d439-063d-48db-a94e-96cb952abc72@cherry.de>
Date: Tue, 10 Jun 2025 10:59:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cmd: remove duplicate DHCPv6 Kconfig definitions
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Tom Rini <trini@konsulko.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>, Bryan Brattlof <bb@ti.com>,
 u-boot@lists.denx.de
References: <20250607120303.210990-1-heinrich.schuchardt@canonical.com>
 <20250607120303.210990-3-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250607120303.210990-3-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0217.eurprd07.prod.outlook.com
 (2603:10a6:802:58::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10964:EE_
X-MS-Office365-Filtering-Correlation-Id: b6227bc6-c71c-40ae-7854-08dda7fd2f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkF5dmhXQ1hwMkltTXd5R0tDYU8vTHZrdGdPaldTdzdtY01XTWNHeUlCR3dy?=
 =?utf-8?B?NTk3VTlnbkV6ZHgzYXUxNW16dmM3dmYrazE3UElmVWxNNDRiamMzRTdNb01I?=
 =?utf-8?B?ZzNGSHdNMytoYXdycmNYRFc4UjZzSllCdkN4RVBmL0RpbDVHMzM1NTJVekxJ?=
 =?utf-8?B?STd1b01Yam5rY290L0hKdGhYMm51N2dnNXhudnZWVDJJSWdGazBpaFVwdHpS?=
 =?utf-8?B?OTg0emYyVkFmU1NXdDI2KzVqTitYLytTUitFSU5haWwzMUxBSXR5citHbnUy?=
 =?utf-8?B?SUZiTDQ4dDRFaVVWWUdtejk2UENocGVIN1ovMHZ2THQ4K2dTTWtQSmxkMHF5?=
 =?utf-8?B?bnloSUl2MnNQY0NLMWhnL3dyQVBRVzhQQUNJR2JkbWJzNWhPNjlOY1RwRENo?=
 =?utf-8?B?OVZVTmQ4bDF4UzhmenZMY0lxa0dQOWJXQytQUDdlVzdsc295OHdQeERWdm9k?=
 =?utf-8?B?UHpHRjlOUXVWTXdmUDY1SU9scU4yQjVGYVUwa2tSOGx6dGVRM1NuM2dyTzRu?=
 =?utf-8?B?cEtwSEJVRTN3NWJUMFFlMFZ4S0xVZ3Z0Z1ZHRWhqZnRaTktpaWhCTUZ0ZVdo?=
 =?utf-8?B?WmpleGVaWUMyT3daY0o3aXU5cWQ2aUgxdEVaS1FURHBwOFd6SGF2WjUvdW1B?=
 =?utf-8?B?RFpkSklWKzhqc2dRSFJLYm9CMTFjUHJFMDJOY1VXT0htTVBEZEZqa2k0RVhN?=
 =?utf-8?B?dkc0QmVsU0JYRDVTRjJTTEt2aEp2aFFoemk2blJVTjAvV1ZhWGRTazBFdlJE?=
 =?utf-8?B?bnhrVXFIaG9mTVJNQStOTERadXEva21oc1NVMVhiWE92ZkJXOUVGdURUa0VX?=
 =?utf-8?B?MFU2b1dsUTF2ZDd3Y1B6OXQwelVjdVViZSt2cnVYVGFJTjJIa1FxZEJTMXZx?=
 =?utf-8?B?MzVXTGdTdHhTVDV1ZU1IQXlGZ0FDZUdrZGI4SzgzSW1pSmhOdTU0cm53U3Jx?=
 =?utf-8?B?UXllNzQrcUROaHAzVEprY24yNDQrdHdQcU54Ym5HV3lZZXNLbmFOMXF1Mm5X?=
 =?utf-8?B?cmFscHl5YTRPRUhvN1hpRzMxWE13bjZ0cEVVWHRocjd0ZjhKSHJvTWdVaFlW?=
 =?utf-8?B?V1dlSW9PbDNQL0xrZ1RYbS84Wi9HMXpqRjNycXQ2aFYvd040Z2hDWFplaUpn?=
 =?utf-8?B?Yk04dVpWTzZrS2t0ZnFVOXpwQnFjeGQ0YkxtSGhMNW9hVGtXSFIzRFZZaFQ4?=
 =?utf-8?B?eVNBR2x4bm94c2pJcjFTWUpSUUYvdTd2NDhGeDZWY0xOWTNiRENxWktkU20w?=
 =?utf-8?B?cXJBMS9Xdk1wNmdBTHpWdFVVREIxME10eGZnb3NaZ0Z6dE1kT2tRanJBUU5t?=
 =?utf-8?B?NS9PaW1KcjZZZ1ZQT1MyK1BpMnRoK2p0WkozbW9EV0NIMEpLL3RSN21FWC9j?=
 =?utf-8?B?ZDNORjltWVdpcnRzZzhqeDZ2Um85OFpVejJZT2VXK2EyQ09GRGRRMGs5RnRi?=
 =?utf-8?B?ZW5PdjVtVnZyYTJNdHZzM2g5L3BzS0hPYWpHZ1QyZWJEY1VBZEV4U3lNWUVo?=
 =?utf-8?B?Wld2Wjlzb2FKT2J2UVBOOTlTVTJEN3JmQm1qTE5zbUdNc2hpL3ZLR1lpSVF0?=
 =?utf-8?B?dDBBNHVFUGdETnpwVXh2TzJlam5PUXhTN291eEhuc1VKY01nRVgyeVU0NEV1?=
 =?utf-8?B?UzMva2Y3MXM4YU1MdHZhK2FkcnE2OVg0RDdrbGwxQmlPRHl6REpmSjBFcWo3?=
 =?utf-8?B?STJkb1lZblZJeTY1NnNXeVkxT3R1K3hLeU5xdmVJaCtyZGZPeDE4dDFLOU9r?=
 =?utf-8?B?K1hUUjY1UFBLcnBGdFRpR3ZkemY3L2dDeHc0NExiMExUWVMvN1ZoS2lwaDE0?=
 =?utf-8?B?dGhpa1FEb2picXhUL0VDZnNQMEdva04yNzZmVkZCd05uLzczQitzcndSbjhU?=
 =?utf-8?B?THdEQUM0YTZYMi9sMDFBKzN5K1ZQalRLazBmVmZQUWdzV0xPUHMvNEl6cm1x?=
 =?utf-8?Q?M7052PUonkE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmM4L2RvWkp4VE1TMEFaWHE2emp3bVREMkIzaXJCekxQamNQQlo0MDkwdHFZ?=
 =?utf-8?B?ZTk4cnFBQ3hyU1k1U1dCTE14dzJ3WTJZNWRnaDIyajExRWx5SDM4Vlg1aHl2?=
 =?utf-8?B?SUlnN2NPempDVHdxd0pYcWU1T1lSKzN5d3B0QmpUZ0dDeFdVVEJENW5qVGl5?=
 =?utf-8?B?K25aZzhYenZja1V1MjlDcHYrbnlkaVFzaHJ2ZWt4bXVUZ2pwSlJoQ3JXSWxB?=
 =?utf-8?B?TTJwM2NWcHYzMm92OEU1SkF3NmIreGM4aHpWWG1VR05sai85TlA5Slh5VXBB?=
 =?utf-8?B?RlpjWHE2aVF4elFWS21td21Gb2g1cTZJZ0dRellJY1FXTFQ0dEp6ZnA5Yjdm?=
 =?utf-8?B?eklqMi9vZVRTL0lKaDlyT0dpQjh5NFpBQnZJY3RqT0FXTkNMUVJqOThHZ3cw?=
 =?utf-8?B?LzN0WFlnQnYwbXJsWlNPdFFTbVR3SUcwWk1EcVlMbFpaRmhjZVN1dzcwLzRY?=
 =?utf-8?B?bzRRdkhNN05RQm9SRUlvMmdCdHl3L1Bxck1LaXg4TG9oTjhRUEo1YWZuMWt4?=
 =?utf-8?B?eSs5Q3FaeU1OZGhqckczQjN4aTI1cTluYnV2RDF5OWFvcXlnOS9mVFVUUVY5?=
 =?utf-8?B?dFc3ODhTeVc3eHBLOG5BakhLRkJYckMwWGUrUWpGSStBemtYenAxS2tMU3lN?=
 =?utf-8?B?ZVpwR2dZVDFGTWtlU1NrMWh5SnVOc1FJbmM4OTUwbHlqTmFQUjlSRG12YVkz?=
 =?utf-8?B?R3V6Skd2KzBYWnlXTFhHenFVVyt4WWlWTUgzNzB1a1lKUVVPSXNId2plKzds?=
 =?utf-8?B?N3d4TTJnUFVUdFl4OFFIVG9CZDdXMXAzL2E0bStzRXQ3Z2QwSmJVanBDOGN5?=
 =?utf-8?B?N3RGVk85eUNSS3VZbWMwOWlnRXJOZm9vZ3FtKzlVdFkxVXkycXFoNmZhWlJw?=
 =?utf-8?B?VmtSY2R5eEJlVGsvYzhaTVpuOXl4cW5iVm1aVnUwNzRGZ3kxK0NnMmM2clV3?=
 =?utf-8?B?MlFkVHlCR05Vb3ZFVkRjM1plVmRpa29GbEZqNjJEUy90dEVuR0FRQjN2aHp2?=
 =?utf-8?B?TmM1MnZFZGt6SnA0RVFwU25wUW9xTXlPeGJ3VUgyMGxPV21XZ1B6NWwzblZ3?=
 =?utf-8?B?WUJWM3VEN3FWZVZPVDArWDF4dEs2dFZaam13bzJadzFLbXNDTi81Sm5Ec0or?=
 =?utf-8?B?Wm5kU2dNL0VDSThWeitDVVBacTVKZXRvYzV0d0RoQi9WSjlsZ3ErcHVyMElk?=
 =?utf-8?B?ZFpxa0VGTHFlc1FicWhid2VsSXpmTVp0Wm5DbGtWdDkzSDRsOG1jM25pZ3Bx?=
 =?utf-8?B?ZHZjVTJ0TkxJUThBcVkvS0pnSllCVUR4OEFrSEx0OEtscEJsL00way9nZSt1?=
 =?utf-8?B?L29ac29NNGsySEs2MlNLZTVabGloYXp1ZlpiWkNqZURhM1JoeVNjVjFLcmUv?=
 =?utf-8?B?aExKdm9XMXFJNVk5eXpJS3ZVbkhZdzZpcHYrdkw3V1pPYXQ2ZUVQbUR3aEtI?=
 =?utf-8?B?V2lYem5jTm4vek1NS3FmR2JvWDMzSUtEUWE5bVJNNEMzc2RNSmhMNW91ZS9R?=
 =?utf-8?B?ek8zZy9KK1Qwc2xGWnNsNmhUMmpUWTFGQTNVSjhlV2QzRXlTdzF4VklOTml4?=
 =?utf-8?B?VEtsR2JnbUxUcTJiQ2U3MlA0Rm9JUE4vMmtYZlBLb0dmVHhocXQ5T2RPQlgy?=
 =?utf-8?B?V3JmZHl3YWNHWXVubWlkcDBuUkVBQVBhdTBHcURMSXhBVWtFZFRxMkdMQjNL?=
 =?utf-8?B?bkttbUpvTXZxNU9hMFZ5eUZRcWhveFZhVXN3ZEFkYTBHRExUQmhrdW81UTM5?=
 =?utf-8?B?V2pmQjVCdjN2WG0zZm41VjRzUmNITis4RVJKQm1hSEhxN3NKQ29Ra2FtZDZk?=
 =?utf-8?B?ODdEQXJDNXNoSS9MenBBTkF6S1lSbEhWQWFoRWRyY2E1QmtOd21RK01BWVNv?=
 =?utf-8?B?U0NrTmVQSkE3UHFYYSs5cGtMSG12bSt5TG15UWlFQmdwOUQ5azhPbmVNamNJ?=
 =?utf-8?B?cjluMjV2b1h3cWNCYVhvaGw1dzMxblAyelMyYVd4ZmJSOVFqamJVYlU4Qnpa?=
 =?utf-8?B?STQ1ZzlvNVV6M3psL1pxemZDdStkUDhyajdVSGd4VS9kaTdoM0pwRG8vS3pM?=
 =?utf-8?B?bzV6TkZ3NlhDWmorM3loeDF1UklHdU02UURqdDU2ZUVVSTJvZ2dkUC9vcTQ1?=
 =?utf-8?B?L0F6VSs5V1hselBZTlF4MTd4Uk9uOUpTdEVLVDN2dmFJTjRHR1JzZEpURzBN?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b6227bc6-c71c-40ae-7854-08dda7fd2f22
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 09:00:01.7817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/TOUPtUXYtdKgdGgOZLaER65shIUn76HGnqYmHnoqiqAtMtiQNNnV3KPZOYpqhjUchBoTKa2o0AwAAAHD+03dSN1fN9FZRlwm8jmcnkHoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10964
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

Hi Heinrich,

On 6/7/25 2:03 PM, Heinrich Schuchardt wrote:
> Remove duplicate definition of
> 
> * DHCP6_PXE_CLIENTARCH
> * DHCP6_PXE_DHCP_OPTION
> * DHCP6_ENTERPRISE_ID
> 

This doesn't seem to be an issue in master branch, but it does show up 
in next, so maybe add [next] tag in the mail subject?

Also seems to be added in a merge commit, so maybe add:

Fixes: 5eb1b7843811 ("Merge patch series "test/py: enable HTTP testing"")

as well?

With that,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
