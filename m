Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9D6CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 11:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26003833E9;
	Tue, 23 Sep 2025 13:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="HUZSQ1Vt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B81F7833ED; Tue, 23 Sep 2025 13:47:36 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E85C800B6
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 13:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYiQmhOYpBPc59Lj2/xbQKxPGYw6Ns3zukd5Z2tGfxqSiL5FNDlfdeuy5VUa1tPCWP3nYDol4ckumWSZ2qlx8S0+4lQR26esayeK/hC/V5jRZishpoFTDbDysTVeG0C9yWyIN7+bSTT6eK06NYzbA9mphhdiosshfonsmSzqhjzEcSU0DIT4MlzNFikafJhUotBN16lI0S0SIUpzHnenAq35yPA68VSmWNU2hjsaQRFBk7vUXMcLyY4KbanBRucdm0RT62EWpGT5SpLzxvKfGIGhM4M4PgM1yCHH6BdcwmpLqU8WSrdyZk4imqU2AAl3u1Y5qa8SE+J8iHPt6W1viQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x32UGcDGdG7eUG94HqsptxEo6xLeyxER5OKYuW0ZNIA=;
 b=N2rkroCNvUEG4M77cR2adTI7fXfmmkuFKsRxzep/TME0u1T7SChk49oCoOM4TWkOcNiT30OzHpKXUCKrQ8C39Ow018qmz0YnMfZs8xWbkLQb/NQvZHfoDe//2rwbZDRFRa2qIoympC04OQnj0U1JUeYbymzfgwbEEKPZ8zhwzgwXVhye8HVxna0Rkyf1A+ICNSdPNxGlLh/q9VlVtllxAmJfYzbW/tgwKqYnfGMQdtbyVaCuY83TARz6B8YBym9ubvMHV735nKzPjpcVDdTEpsKjLW1C3/3z3dP6Gatu9hSvslqPxLpcIrwUaPdlj3UTkZfgzx0erbAH55K0kzgSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x32UGcDGdG7eUG94HqsptxEo6xLeyxER5OKYuW0ZNIA=;
 b=HUZSQ1VtPMVdhXWYnx3vLgt8DWTUqeFGR/Ps762yVmF8ni9rovDK6qQRWOsV9miOJJDyZdYiRDHwhED+Ehr3bJmvgdQnLeQ0KGrR3I7cGujAqoPawxP31ApxMDZC440dafWiecFMH0F77Jathiy64fj328FpRIjp8bAzYxW85LM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 11:47:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 11:47:32 +0000
Message-ID: <65f3279b-b637-44b1-bdf9-ef82ccb44f2e@cherry.de>
Date: Tue, 23 Sep 2025 13:47:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd/dma: fix generic naming, spacing, and Dependencies
To: briansune <briansune@gmail.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com
References: <20250913163913.395-1-briansune@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250913163913.395-1-briansune@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 7829637b-490e-4536-4f0f-08ddfa96fb24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmhuYjFIQ2x4ajR5ZzBPSnNKbG4wUTlDZ2dDVnVzOFBzclU1SnZXK1dZQlVq?=
 =?utf-8?B?dFA0WkZPWjhDMVhMbEpnZ0dIcis3QlJ5VzdDSnlYcTJBb3dFQUREYkhQTGR3?=
 =?utf-8?B?MjBjSnQvRDgwUW1tMDAvSWZQcHR3ZHozOTRhOTU0Q3VSQkFiWjh2MnI2bkp4?=
 =?utf-8?B?N0xYVi9YWnRWK2pXaStrck9CaVBQYVNYRGNwRGVmYTBLUDAwQ29lbWhlRG9S?=
 =?utf-8?B?ZkFrKzZ0T0sydkZrMXZYV2xHWGNEdTVWd0VqZ3p4SjJDUm50NXpQU0VwR0Y2?=
 =?utf-8?B?QlRhUHdZMHk4K3BtU3JZN2lnWnJrb3BQTkR0TS9ESSs2VHRVbE1Bd2w1TGRS?=
 =?utf-8?B?bHNOTzh3MEFQb1BTdjV0N0tOOS9hWlNqZ1QraXZOQ2ZIbVVhNFQwa2RGc2Fi?=
 =?utf-8?B?MHk4TytvUGk3V3J5a1preUFWMWJFR01GamdLV0RsMjJHQTdhSmx5Z3lFcnRw?=
 =?utf-8?B?dHg2UGxNZHZzUWd1WWVzUUhqZTMvNzRQazNnRWMxVkdEaEQzZDdpMm5qUnN4?=
 =?utf-8?B?OVpkS21uWFlUMG1PaFcxck5VNXdDNTBiNVJrOGwzWElLMkVFMCt4YVU1TUNv?=
 =?utf-8?B?YTc5Z21aSnA2RzhxYjl3UHhDaWxMNjRFY3lnNlZ5emFhUkJzaUgrdkVOSUZm?=
 =?utf-8?B?LzZkWjFUVThsaVR3LzNEZytPR2pKZXNnb0YyNWFCZDdFVEJPWnVMSFZSTG04?=
 =?utf-8?B?OFQrU1k2YVpkNGtNN3pwVEx1SHdTaTJaZnRuVjd4MWRZc3dnY3ErM1BqZUo0?=
 =?utf-8?B?ZmQwdlJFKzE2V0hqRWQ1Zkd5Z1BTamZWc0VpWWJNdTVLVXVDemJzSkJ3c3Zj?=
 =?utf-8?B?d2F0Tm9qRHBUU2tXaGNKcHJNU0lJc2F4eWwxQnB5Ni9TZERkcitCMWdOZTNa?=
 =?utf-8?B?cXJ2VnZQdERiVXUvektLdFY5ZitnUXZsYlEwUUduU2hMVCtWRlhSZDlmdjhw?=
 =?utf-8?B?NkRxc2VGek4wWjQ2T2NLVURMbDAwOFlGLzRNMjBuL1YrWFFlUzN0UkVLZU5K?=
 =?utf-8?B?TDF6N2lJRzhMT0JFeTRXeHFjVk9TYnQzdHZjelNFaUkrQTY0N1NVa1RnTTNB?=
 =?utf-8?B?RHNsZUx4d3pvbVY3RWNlQXo5QXBZN2pWUXZkNFA2emd3QVpDUklhLzU2SFRh?=
 =?utf-8?B?UWQrT25CZEx3NWYwa2lsYnhmVktRckpJOFU2VHk2dUJ6a1VKb1c2MVl5YjVX?=
 =?utf-8?B?VkRWdlFmQ21qandlL0VXUE0xWEhRYnphMGp0ZHZRVndQV3U2enNVdGpuOW1S?=
 =?utf-8?B?TTB4ZzF1WDkrRDZJd2FnejFseUJpNnBDNnFFQytEem45c2lPd2I4Z01YaFNk?=
 =?utf-8?B?UXJjUEt4UXgyTmNrbkFXaWxONWdNdUpKVnFXV3FXSmRNOURaN0ltNk9DOGdx?=
 =?utf-8?B?NVBJUjdqYnpPS1M2MzJKc0VPckJxV3k1TWNvcVdkZHJjZ25xQlNGeExHbDlO?=
 =?utf-8?B?alBSNlA5QUNBWUNwTENKZ2syM0NBaEE5TUNjREtWc3dnak56SjhYbVB3NG9C?=
 =?utf-8?B?RVlZQXNnTmZWSXpRTmhwWDhSVHc1ZVhSalBNQzVOeG10aFRVaTE5ZlJZREZM?=
 =?utf-8?B?cW8yUTMyMUhaa2t6K2l3YTRXTmdIbHlSMlZHSm1SMkQzcVNOOEUxWmdtcGlm?=
 =?utf-8?B?VXpHY2lUdFdKclorL1VxbWJHNUF4TUtzRWZUcDUvNDJ6WStEWVlRZWFpVWtB?=
 =?utf-8?B?MHAxQmZOVEtwZmsvVWJ3NVE3OW1oemFxRmdJYnlmVU1mRzNOcC85SVhick9W?=
 =?utf-8?B?RzNKOXhJdzVsUFpjeGJIc3ZFTFI1cTdsZlZDcFVHK0w1NjFBcjN0ZmIwSkVk?=
 =?utf-8?B?TU9LZ0YwSmFyMzhkdkM5dGg1VjFwYUJnTHI1Z0YrQmJlR21DcWFBYytxTVdF?=
 =?utf-8?B?aDM0bExoT0hPV0tiQjhzYjBEeWRmMGNOSmEvQ1IrZVdiWlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTZhYUkvSCt6ZGZvb28ycnpzWThGeFR1Z25UdTZIdWpUMW9yK3NYakNLTGxY?=
 =?utf-8?B?SGVvcnJFNGQ5L0QzNTFvL0ZEYVdEOGJBd1JCczFvVktzeUlFamVkSHNucS9p?=
 =?utf-8?B?REt2VHp6aCtpeWlDUjMrS0dTR3NWNGRlVlRxUnVpKzlDWGNCb0RrcWp0bE12?=
 =?utf-8?B?R0Q1T2I1SVZVMmp1b04rTGpxbUsvRGlDL2NZMjNEcHJSbnlWaXl1M3hKT0hJ?=
 =?utf-8?B?RHZOWnhuQzUvTkgyN3ZHaXErZFMzWFRlbHg4VXZtWVpBc1dDdnBjUVRZSTZJ?=
 =?utf-8?B?NTZlMVZYVU1aNDlDdHlVd2J6VDdZZHd1cFhuLytOWDQycTJSM0JUWmQzdUdD?=
 =?utf-8?B?QmliMjRUUyt1bjVGODViWGZOa2Q5QlQ2NFgvS3owZVF4end6ZFFQa3NCVU9z?=
 =?utf-8?B?UWFWN3FtWG9HOFRyMEl1QTlXcE1DZVkxM1FTZkkxU3VVdlJ5cldJV0tXNUpZ?=
 =?utf-8?B?Q01wbTFRVkRSNFRnRGpNcDk5c0V1MTcxTjgvQ0lVYjB2RlJqNE9NVWVtckZ2?=
 =?utf-8?B?M1BPc2hVUVoxbURRSmQ3U2p6UzFGMDBvZHhsNit2TnRobkFLV0dvQ05EQUNH?=
 =?utf-8?B?WmR4LzQ0ak83K29vTmFQa3dQWGJLZjhOOTVILzAxdlRwcGpZSGpUUkQweFdi?=
 =?utf-8?B?Vks1TCtzZ3U4K1FkM0d1ZmdlM2J0V3pDSFNWd0Uwdjh0QkM4ck15dXp4UW1B?=
 =?utf-8?B?V2NlQlZuK05lVHRjeVQ0QktEbVdGSGk1eWYzbldIT1M4QVhmTUVUQTBmVW1L?=
 =?utf-8?B?SDlRWDVKb3pYbEdKSVl0RzdEWGx1MlQ3U1hmb0hUcGZRTTkxQi9KZ2o2S3dk?=
 =?utf-8?B?Q2dTTW1UR0ZBSE1rYnhXQzNDbTNvaExoeDhyenlJQkdLMTVXNzI3am54UHpC?=
 =?utf-8?B?WkhQcXFJU29PYTh6SlBJNzBUWE41ZUhVVC9DVUE0MUNBNDVhNThhdGpaWE9O?=
 =?utf-8?B?Nm9VdWtPQWQybG15c3lEQXRyMkw1eUlFdTNZbEVId2ZlZkZFbTRobDE2N1BS?=
 =?utf-8?B?ZUhWaWlEcWVxMjNVU1dBWmhySXZYOUtSR2pxM2kweTlVVHg5RVJzQ1I4dXNN?=
 =?utf-8?B?QW9rMnJVRElpMEo5Tnc5c1pqS0YrK0pnUWpmMFpzREJRall0cmNKeHU3SWEr?=
 =?utf-8?B?TjJLU1ZUajlYcklnY04zOUl4d0thK0pLVHhpVzdMRTVST2ZBNkovaXMzeS9I?=
 =?utf-8?B?Ti9QNUc5MjBoTzFHTVI3cXhOSG93SjlTZzRCbkEwRUFraFJJWGtqN3NQNy9u?=
 =?utf-8?B?bjJSbEVjS0M1ZkZ5YldGTzVhUWdLVlRlZEp6Y09nWU43ckMvdS9GK01qeGFt?=
 =?utf-8?B?R0lnY2k1eHdkVDdneTNFV09wVzlMaGZsTTQrRDV0dHVqdU5CNHRVa012UnVU?=
 =?utf-8?B?K2hUQnZpOWo0cnIyYXNzMFIzUi9IZDV0NUJuM0ZLQ2NkQm1YbnNkcFh1ekI0?=
 =?utf-8?B?bGFseGtTV2JJejhtd0NCL1dveHZ4QmJQMGt0T2RYMGlMRktmUVNyanpOdy9I?=
 =?utf-8?B?WUx2VnIrdml6UlBhaEZBYlRjR0piSkEwTngyMmNqazJXTXNkcXFIelRTK0ps?=
 =?utf-8?B?VEZnRUh6MUNKTG1xUnhFQU80dEZxanpGbXcvQkdCdnJZbFI3OGVGS0V5MzVW?=
 =?utf-8?B?dStmM0ZTSjFIT0JrYXhWNmRzNytkR0FseUtXTUZpeVA3TEtBdVhNWWlwbXRJ?=
 =?utf-8?B?b1A5NnRNNXEveklMb0oxZkxhdzZ1L2NocEZTbElkZk52RGkzTHdxTzQ1Mlg1?=
 =?utf-8?B?K3lIdnpCZHhhckh0eUJHN1duR0Y3SDBsZXV4R0NqUEhPNUtuYTlwMllZaFJV?=
 =?utf-8?B?SDRBVnFMKy93a1ZhM3lyMzY1SjFqSzlHMkFsazF5ZVlyemE2ZXFnWjZ4YWVY?=
 =?utf-8?B?Y1d6VXZTVjFQazBsTGxJb214eFZibytXM0YvZVRqMVpsTU5rVlZEWXBicHBi?=
 =?utf-8?B?RVZMdFhKUGlVZzFyd09MZG8xMGQxQnc4TERqWFFDazRhd2lvbVZaZ0RHOFVK?=
 =?utf-8?B?OTFxU09rNGdxcjlZMGVNV0kyalYrZ0RucGxzWU1LcjlCSnovdldmdmpXS0JT?=
 =?utf-8?B?NjNSaUN5R1JDQ1BRcEt3R2FKTlBpdWdGYlBuVys0dDRzR3NLeklUV0hxbndr?=
 =?utf-8?B?cU5oSUZDYmxQYTMvZisyekFXM2VnTElRa05DTFpDSlViMSszcUNyOFlnMDB1?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7829637b-490e-4536-4f0f-08ddfa96fb24
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:47:32.4180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THDwbeMA9+6+UURuQgFiYJ8kvCCJRtuUm7bIp4pnDdKFTDqoNADOYtjFJgVlNfXKf5pwvgBurYVU0bCUSmtJCkRevQ+OUnuLfdgiFJgIWMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898
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

Hi Brian,


The git commit title doesn't seem related to the actual content of the 
patch?

On 9/13/25 6:39 PM, briansune wrote:
> [You don't often get email from briansune@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> This adds a new U-Boot command 'c5_pl330_dma' for Cyclone V SoCDK
> boards. It provides access to the Reset Manager's Per2ModRst register
> to release the reset for ARM PrimeCell PL330 DMA channels. This allows
> software to initialize and use the PL330 DMA controller properly after
> reset.

Isn't this something that should be done by boards directly (i.e. 
somewhere in board/ directory) or at the SoC/arch level (i.e. arch/arm 
or arch/arm/mach-socfpga) or handle that in a DMA driver (I assume 
there's none now looking at drivers/dma/)? Essentially the question is 
"why do we need this as a command?".

> 
> Signed-off-by: briansune <briansune@gmail.com>

Needs to be Brian Sune here (same for the commit author which you can 
change with git commit --amend --author="Brian Sune 
<briansune@gmail.com>" if I remember correctly).

> ---
>   cmd/4913           |  0
>   cmd/5036           |  0

We don't need those files I assume?

Cheers,
Quentin
