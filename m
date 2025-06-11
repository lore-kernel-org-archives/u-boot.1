Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CF9C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 11:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E658070C;
	Wed, 11 Jun 2025 13:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mAYQ3lDK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA35782B20; Wed, 11 Jun 2025 13:15:08 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B73080050
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4deOzH7Gsd1DXcYotn4vALbz92rn6rmyUF9eOpUqI1FibrqWa9Z5cqWZta98gEFgXqcB3hq+54lx6o+uy5saoPEDg+BczB8sUrvBt1OBUTszm9NWYaRfc4+0L+MZT1/+tw54AYJEvA9cHfAMiE+AfPIqxKKzY98qUwptJG6aUISD7TA8bOZmd2dto10PeOPWzqyc3etOrCpacqnS6RjtPl3y/k26N5DO59yDu7NcHKn2kaM3bNVCmXU50T+aMdkB8Mm49Iu16+rIBbEngoiR8LNRhsp//madF1q+R2KhF58tHCwObxXyaTD4NoQzip7YKTmcB870N1IVr2KetK89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwZHK+k4CAolidWGa0cnxZkvFpUKyCnn04tcT5HYiAc=;
 b=APXSt7U43g2UtKdd13xLXMO0fwyIGlh3oF70biuGBNgY8CPY0F8zQc0e1A1m6NNKqzm0tU65hYvI5FmoSqPRivC8OiKKBSIgRjG6TrUm6NH51AKNs/n5sTlk4kp1d3wNNsY22+VY/ezuudsKl44flJIH4MV90wYWMt79A0s94v5v4nV8MHIzP49gmfiOtSep3XQQA8WoEqLUNRWXWJ27W3clAirGq9zGRRgyffkIQd+4NYuLzpwr0gwZrincR+XY+9M7yuYMXg4zDGK6GAku90uirzS0SwMkm5tXomqvi9Wdhrf8PMPvYt+wN+JKIW3oLimHtZwwJg8Ry48I6GGzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwZHK+k4CAolidWGa0cnxZkvFpUKyCnn04tcT5HYiAc=;
 b=mAYQ3lDKFtHfH9MGGj7Mx6xYYNzyS3euzp4aEIiR4hf0H7S681fuYRER2B1YZDx0y5V9oO8O/1I6nUDEU6XRz1CGdC4npezOXdhN/iySCS7J/4SUOW28d6RCwIjuOgN3Ffk+bu+S3UIetgnm3wjgMbUIUdzdwRQfaWeXR5xtBQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8182.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 11:15:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 11:15:03 +0000
Message-ID: <7504ed9e-7cbf-4b6a-a79f-64540550380e@cherry.de>
Date: Wed, 11 Jun 2025 13:15:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rk3288: add fdtoverlay_addr_r to default env
To: Marius Dinu <m95d+git@psihoexpert.ro>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>
References: <20250611110454.23428-1-m95d+git@psihoexpert.ro>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250611110454.23428-1-m95d+git@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR05CA0122.eurprd05.prod.outlook.com
 (2603:10a6:20b:497::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 56126c0a-ed09-4e4f-6d2f-08dda8d936a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2daa2UyVHhvZjcwb3ViSExOMi8wQnArSEJ6SlJ5RjUxOEVhdkhLZkd5TzVq?=
 =?utf-8?B?cm5qU2FaN3YrclZvclJjdkEwaUl6QmtCK3BEdE5vKzJ1MzYyVmJ3OEcwTFBP?=
 =?utf-8?B?Q1p4dUI3NDBocUNDcDRzSjJrbHNXK1RmejVwR1VueFZaTnlPd1JWZ21Da0ZV?=
 =?utf-8?B?ZjljZE1Ed05nNUZGZkoralpEeGtSNmNzc3BVSmpIZk1xUWZIQnprb3BibWU3?=
 =?utf-8?B?TWZJakE3aUdKbWcxVGEwRlI2bk9RbU5IZ0liY2NnTmxMQ29DbS9kTEZJMXU1?=
 =?utf-8?B?YkhyZENoTlEwV2U2dHhIQjhhUXJ4bFRsaGhGSmxDMXd5NVhBdTRYQ2NzdUVQ?=
 =?utf-8?B?dVdDM1ZsUFhzT0dvR3ZvWW80b0RTVFI4cERrRDJObExxNFdQNDVTY09DdmFF?=
 =?utf-8?B?Q0tGbG1lUDY4VTJXd1pqZUY2OHErY20wTkRQaU1LMUtwMmkyM2tjOU9SVFJh?=
 =?utf-8?B?UDB0clpVdGpOQi95TUlHY1p4dDRVQ1RZUjJxVWl5bXg4elpRSVh3eUNVdzNM?=
 =?utf-8?B?bGozejJ3Y3VJQ2pWbFZ3ckJOdFVHNFRsc1ozM1FmVWE1d3hHN2FWVzRZQngz?=
 =?utf-8?B?OU9yRjBvQkhsVkdvOGtBSE9mRng0QWRQWG5BVEphZG56SVc3UnpUanlDVCtH?=
 =?utf-8?B?Y3grTG9FWjBNWFlJOHJtcThhUmJIYWFoWHVoYnVROG1NQXA0MzV1cGlJaUNk?=
 =?utf-8?B?NENIUkdpWk9BcFovdDRnbkxORkVMbTRKZVdqbXRyZU9FK2pRS1hSV0kwZEk5?=
 =?utf-8?B?d2dUeElvV2NwRHlYTE1ZRmFVcVMrY2txSlhmOGV2L3g3Q1B3T3cxNVk0TThY?=
 =?utf-8?B?UmgyaFdUS1lHd2RzY0RyM2xaSEtDK1dXdm9CSnl2TURmNkE4eG5QSU5SZnpT?=
 =?utf-8?B?UkNuQnF5eEV4MFdUbUhpckNRUWRpdUdXeUkvZHRITDBSdjJLbjUybWUrYTVE?=
 =?utf-8?B?bTZpQnRmUzJvc2FTUmhnRHovMGlwU2tBT1FzRytqV2I0Vm42cVJyTnhEZWxH?=
 =?utf-8?B?QTR4M2ZUOW1WSktaWGZnZzZqZVkwSkt6djNheW9MN2dJaXR2Z3l5STUvNnVL?=
 =?utf-8?B?SHZzWEEzd3MvZTl5MmQ0ajFoTnA3UFdFUmlRUUlyUVVsbXVXcVRPSDNpR2Vo?=
 =?utf-8?B?VncxeElIeXJTS21KL05YMmZBbU52Y2hRRk4rN1ZmQXMvU0NyaVNreUFKWDRT?=
 =?utf-8?B?K3hXeldxdGI1SG5JbEJFWGg2ZWluRTdOcmxpTzBrS3BUNm0wSVY0dXN5dCtJ?=
 =?utf-8?B?VVByQklWQ3hGNk1TaTk2U2hhZTVWenlZdG4xcC9CVFc3L2syeXBlZWt1Q1hv?=
 =?utf-8?B?R3VZa2ZuMkFhSlJhTi96enY4RE9YYnRYN0xTbjZhM3VTYUhZQ0g0RGM0dWxy?=
 =?utf-8?B?L1ZqcklWcVpTbDFWdHVKNGk5eWd6NTNpSE9KbU1qa2h0OUZ3NVBaTGxSczAx?=
 =?utf-8?B?L3lnZEFvWkZKVHo0Y004SSswSVpiMTFIV01pbkQ0TWJHV3VMOGwySFd0Si9z?=
 =?utf-8?B?cHpWaVJsOVIyVUxwQ1QrUDR5MHgxdkFRdksxaElvV2plYU5sNzJrTlJNbEQx?=
 =?utf-8?B?Rmt1Y09COHI4bGJVL09wYW5nWFlQeDhxWEVHaU1ZN21iSWNBbGFkS1VFcDVh?=
 =?utf-8?B?am1mME9pWklyTm1iZjNjVXFHd2QrQlpqSUwzS3E3VGtGTVpLV2NPTVVMUllC?=
 =?utf-8?B?cHpYWjY2S3k1Y1JLSkJib3R5U1Z6T3lyTGFqaFhBWXZuUmQ0UWRzdjQ2L3ha?=
 =?utf-8?B?UG1yT0FURTNuQTJwZ3NJSHYzekRPWkl4QlJrSE11WnBON0ltckM0cUxyc0sx?=
 =?utf-8?B?aUUxdkYzNDh5RDVZK3BTcmY3eXNlc0NlelJTK1JZbXRSRXdrQk1MWjA4RStF?=
 =?utf-8?B?ZjRrSFFFaHF3SXRTc2hQR1o2RVA5MHVCRVpoTHhHZnBXdHlraXZUMWc3bTRx?=
 =?utf-8?Q?Z+VLhwuyctQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zy9EdTBRbm1uQmFYQzVyZk9lKytlSTJNNkdkRnVrbEJTVlNrUGsyeXlxMDJY?=
 =?utf-8?B?S0VXV1NwTlM4SUhPL1VBeDRZS09QTGtGTnJJMjBramtaOFNhT01SSnFZSFk5?=
 =?utf-8?B?c1RXbiswVGhocG9YNm82dmNlV0t4ZGZNdUVwV1FQUEFxMXdMVldYaXRxbUJM?=
 =?utf-8?B?bUlaSTNXbldia1hmNnpKSElVUUphZW5XelZPRTBHRlBobDJraCthdEpqQURy?=
 =?utf-8?B?NWZGd000QTgzdVpoaEJidU9zR3BEenc1RkRBVGVYUDFKK0NhcFpRdTgwUWJ6?=
 =?utf-8?B?WUNVWVAzQnREUTdNZWE5TDNRRVpRdUV5T3I3ZmNTUTJoWVFpY3lVbzhsVkFN?=
 =?utf-8?B?STN2Z2htZ3h0R2s4Ym8rWG1ud0JYYUJNeGQ5QlROei9yd1JHWFhMUmlBWTdk?=
 =?utf-8?B?ZFkyWUxDN2dmQThYSk1OZkNmSVY1bVVRUkI3ZElPUXdnR2MzdUNWanZWQjVX?=
 =?utf-8?B?LzBQMlM0YjVKc1d0WFE2dllLS1pWTk43MVN5emVGbHZrZG55RDhCcFRadld2?=
 =?utf-8?B?QVdsUzl5ano3QmQ3Rzg2cnQ3RFBDNEdMMXRiTlhacURMYnlXM2FxQXQxUkxz?=
 =?utf-8?B?cGpCZ01xejlYaUtLcCtWWS9uK0EydFA0NG9EeFZwVnZucG8wTVlIREUzTHRl?=
 =?utf-8?B?aFBGbWZ2SW1LRk95TEdlbHAybGprczAwWGF5RC9EdTlHMmhQM09zdU83Q29Z?=
 =?utf-8?B?cVVPaVJ3dm5QWGxBWUJKcGZlTWswbXloN0swdnZQOFJzWk5SZUlIcXlQVWZ2?=
 =?utf-8?B?emdQWXV1Q2N3VDNxUmVRZzJ0MHpmemdXQ1dxNUp4dks1dzFYdUJIeHZIQlAy?=
 =?utf-8?B?NlFvMUlQL0xPb1RCZDczbWNnajhHQ0tKOFVqc2RNOHQ4RWVQT0Q4TWRQZlZl?=
 =?utf-8?B?ZWZMU0t4ZGtHa0J6MnpCSGFMRlRIU0ZFYjIrWC92UUxCbGR6a3hwY1J5VERl?=
 =?utf-8?B?dFNPcGx5eFU5ZFp0TDI5S3ZSWHV1NTBIOURCckpwK0tWQWhINlRXRW02REp5?=
 =?utf-8?B?ampmcVJuS2sxQWtSbUxpYWNCQTI2bEhtcDc4QTFvUzBoRFRMbENMa2taRkxE?=
 =?utf-8?B?QkdOcVZwU0tLOWVYUm9lcUFacE5wVyt6M1ZwVkUvb1krMXNWbEtXclQxVDg1?=
 =?utf-8?B?ZjRXTTdLUmYxTFFYZHVlcEJIejRvYXJqM0JINks1L1UwTGR2NHpYenFRTk5C?=
 =?utf-8?B?MGQvcWh4LzREKy9Pbm92RVJPTzlRRjZuRFNLRmpIWVFGOXQyRWh5WVRxdXBQ?=
 =?utf-8?B?Q1ZrVDB1UVRXb0dOUzh5cllmcHl4QlBSWlNyVTdqbFlKQjNQNHEwdGFuWlI1?=
 =?utf-8?B?QjdJRXV6WUVHN1FQeGtpN01xMlZCWWUvQnJhbUFleElYOFV5TGJiZEEwdGty?=
 =?utf-8?B?bWJtdEMvbWFQeGhBd2kyeDZlSlNDakozekg2bmVwbFkyakRvVWxSU3NiREdV?=
 =?utf-8?B?Z0pXVk5wZDBGMlFxZ3IvT3lhVnBaOHVTYnp5TmpGcERBN3A5dFMwYU5ISEli?=
 =?utf-8?B?UEd0RmhHVHVhNlZvQ2k5dHBFMjVaVmZiM1g4N25YNmNoRjZNc3oxWFQ5Snp2?=
 =?utf-8?B?NG5pQ2lvNE1KS3VkaFMrbk1CN0F1K1lqZW14clVCd2FQcmdybWs4WFpnbEtC?=
 =?utf-8?B?R3IyeG5GcTBHU1lwZnA1dmVaWlE5QWRRdDd0b0VBUkQ2bFRtaXZuNVVpSzJx?=
 =?utf-8?B?ZGhPQlhES2hkY0ZXbU9XaFVGRTlhUExzVXlWVThqT1hjanNuSEJUc2d3QXJ5?=
 =?utf-8?B?RGVHaWxxQlhVVDFFM29UV2NmdzFhaE9PUE9qWDR4Z3dCT3ZYbUUySEd4NFZi?=
 =?utf-8?B?QklpNFNvT0ZDaSsrck9NbEl6Nndjb1RGazYrM0pwZFBob1c3K3BZQi9ZSlN4?=
 =?utf-8?B?VWFLVlFqUzdydDY1Z3kra1gra05qUUZ5YklTN0tIZFhDcGZLcDRaVkpNUHho?=
 =?utf-8?B?SEhGMUFjd3c2LzRXQWo4NnJiSzZSWER1UkFMTU5SMnZjQm9YM1hwcjZWaElo?=
 =?utf-8?B?Q1VuQmRRTWdpUnRGQXNYSGR3RkNpbHorQW83YnNLTUpXbkZxTzd2cTNMamx6?=
 =?utf-8?B?UlczU0UrWmx5N0d4a1hSY1RPdllhdXl2RVJzWWtvYW8rOHdLMlg4cHZQNXQr?=
 =?utf-8?B?NFo3dGJFVnMzYkxraEUvZ01Ud3FKdlJJU3dpVTl6UExPdTVlSW9VUWp6NVBo?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 56126c0a-ed09-4e4f-6d2f-08dda8d936a2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 11:15:03.6142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRg058nAyKbXW8ItLFJpXJlyfzGDKHeS3puyVj25lvfR5Z4GPGjbLbieg7deGWyc/g4j9v53bM/SyxHtGRvHyzf9yOjoSfo6UxhIaPw7kM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8182
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

Hi Marius,

On 6/11/25 1:04 PM, Marius Dinu wrote:
> [You don't often get email from m95d+git@psihoexpert.ro. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> rk3288 is missing fdtoverlay_addr_r.
> The new addresses match those used by rk3308.
> Tested on Asus TinkerBoard S.
> 
> Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>

Looks reasonable to me,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I'm wondering if and when we'll be able to share all those variables 
among all/most Rockchip SoC/boards instead of fixing them one by one? It 
seems like the last few releases we're playing catch-up with less 
popular (upstream) SoCs (see PX30 for example).

Thanks!
Quentin
