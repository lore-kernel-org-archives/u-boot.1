Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F174E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 09:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AFAB8005B;
	Mon, 16 Dec 2024 10:57:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="XChha9mi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8776080104; Mon, 16 Dec 2024 10:57:06 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0686C8003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 10:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9lyO7ZEGNoWzguzLAPWFPNs/pjIcuuO5OwSrNdvE1BDFqsuSn1zhoHKW0UWy2c7IZRAmSqf5uh1pVYUr1xgiTwMV1TsVvWQAWSBVopfWR1t5VDpHgHiQFs5Y11rxC1MF8Ovl/ElVTDU96qmHWOk9QJbmj1KT+Ppje5TqNq56aS/SLEKX4d8FbvI0nOcsPnokSYPQ6X1xBbvhuga9m+eyljvQNVAzklVFPn6Q8+KmuPD/T/DCyMPfAwOci/Z5tX9RjcytjOgKiw3gCU0s98Mb2+lY7Ge84MDuqXE8Jo/iCodG1bNf0+RysOziRbl4jOkZenIWT+S2L9GtBEv9T45lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBdCsTv/xkJMD9tHgMynY3DCQNGEvtZIcBYLHF1ftzw=;
 b=I97MRVtNET2a6gggGZ+ZRgyt//jaC8lKpHBpn/nRhaNkOoDpCTEnKsdMXCMA1laV4IUzo1zKi03nrYz6yf+EM8WNam19ljupjKNqRo38zRnA8D/WGuoUjX1RgZHKd0dAvjzPuRwMM07U21rW0qVlGUFjZSgjHOuMYh2IHYt0aM0kj14ynYqnXvYe/Q0d51lYP23brpL772QH+phqDFQ2HKz/AYTKB0a4KBs6mLo5NU0bBLQxhiQHU1YTlFXkVdp7+7DCA4kkpOorO04FxXIkf4ypOLCvzsmr2aPoS/4s129A0lbnNLwkR3dc9NR/6VdAYjn5nbon+TFK29Z6gs9MoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBdCsTv/xkJMD9tHgMynY3DCQNGEvtZIcBYLHF1ftzw=;
 b=XChha9miFr9ky/+D8rugZ+AG6x7CjrnIyDOTZlbQBfTkkKltA/bfcFs7dwVi9TUqUDXoY2x7H+4YSnFhMmQ3avWQHBzmgchUhJx7ywIcIRCrdg1ONzRdCWNOwDGmMG5RquQPyircFFFNWA993EpJ1P6qcY1JOiwEs4K5oyqRdvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB9524.eurprd04.prod.outlook.com (2603:10a6:10:2f7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 09:57:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 09:57:01 +0000
Message-ID: <6b93f3d7-c0bf-4517-9523-3c1a6a1e23dd@cherry.de>
Date: Mon, 16 Dec 2024 10:57:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] rockchip: Add support for Radxa ROCK 5C
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 sumit.garg@linaro.org, jonas@kwiboo.se
References: <20241211033934.23044-1-naoki@radxa.com>
 <20241211033934.23044-6-naoki@radxa.com>
 <2600bdcb-3c57-4d52-97d1-c63758b25ed2@cherry.de>
 <115020791DA19920+c09c7adb-9fe7-47f4-99cb-2c8c862fe1c5@radxa.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <115020791DA19920+c09c7adb-9fe7-47f4-99cb-2c8c862fe1c5@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0443.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: d40665e8-16e4-42f1-5d4f-08dd1db7fce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wngva2I1aG04VU9iS09iKzRuMHpCeFhBVXU5Ukx5bUlGamt0UENvMWc1cDVl?=
 =?utf-8?B?c3RGV3JVcjVhQjFsR1RGQWJGT2RzWjAxTWRhRUhUN0NaU0x0dDByRks3T09l?=
 =?utf-8?B?REFsODArYUZLWDJ3enovaHRjQ3l1bitWOGVGaktISEI2a2F6bU83VUVSYlRx?=
 =?utf-8?B?OGx6TTFvejRnQkJ4Nm5Fc0djZGx0NDc4UDh0by9rRk8wNmdCVTMxRmhWMjJN?=
 =?utf-8?B?RUgxNFJ6OTRDWWNydDl3NGFVRkUyL3Iyd0ZONnplOWRIVFRnVXlXT3BxZVpE?=
 =?utf-8?B?VytZSWQzdXBmNUhYUWR0LzEwY01kWVVaSDluVW40OC85N1daR2lxMzdEeSs1?=
 =?utf-8?B?dWlobXd1YUpXT2J0eVQvaUNJVnJoc3dMZzFoeVo3OWtBRUJkQzhLc1lkT0Fm?=
 =?utf-8?B?VkVtMEZELy9WT25TUzlEdUFacVB2aHgvVWdOSnN6L2hQTHNRaTdBWGpXSlkz?=
 =?utf-8?B?WnBoa3RYOUdDVGZodlN6MnNrQ3BwTG9OVDJsSS9pTFVzODQ5a0hLdlRzQmVF?=
 =?utf-8?B?dGpxVnRMYkZYTmF2TlN6T0ZvdEhhdFRLV3p4WGpOVi84NjN3SzhjTDhrYUIv?=
 =?utf-8?B?WVJscUFUUDVUNzRBRktDRXRRdHhZUDRVbmJmK1hzWkJUazB5NnFFV2o1MGFp?=
 =?utf-8?B?SEJBeUI4cnBIdWpnbXRDTFcyRUpCK1dDVVJWZlZjZmdQWlAydjZGc1krN2h5?=
 =?utf-8?B?YVdnazc0TTdyQmM4dWwrQjlEUTl2TDZCSmpDbHpZM1c0QUl6ZVNQeEJXSWJt?=
 =?utf-8?B?UWhiMGorblluYW5EOG1YMFdmakRUcHc1NGdXRzVxNzBaNlFjN1JSU2hyYWFw?=
 =?utf-8?B?K3ZJNUV6Z3NaOTUwNTZ5TUZKWFFxQ3R4bTBQQUdsRUY0bit5SU8ydGwvM20r?=
 =?utf-8?B?RUd0OFlvRUxmTEN3NjdZRkhVNVQrZEs2bVJyTEs4eFRnS2tPd0IwWGNGV1Fk?=
 =?utf-8?B?b3BYUDNXTnByU2NrOVVRb1ZGLzhFb2RnRHQvcDc5TGRUNlN0MHg4bWU0dkpy?=
 =?utf-8?B?VWc3azRncmJXeEJaWGYyb0V4NmxQaVM2WVc5ZlNFaVJvQkw5Y1dmVWFuVkpy?=
 =?utf-8?B?UVdacmJFbHUxVzJudWQwYVZBVjJ6QnpoQzJ5VFZkTDZDL2FFdVNkT21jdDRB?=
 =?utf-8?B?NUVteThueDFvSWlxMTBSOFBoOTdFTy8vV1FySWpDaHQxam5LeDJZUjdOQnJr?=
 =?utf-8?B?bW4rWHZkc01nallvcWh4WmFUc0cxa1IzbmZuZUl0WVlveUxmdUovcWg5dDJQ?=
 =?utf-8?B?WmZUN01XYi9TcXE0cVZWVFhGUzBTYVlvc1hOTmNqTExvYVRQVWlITW90OUFs?=
 =?utf-8?B?N0dpYnlRUkhvR0lqcTZtSHNPeFF2WlE1dUxQQ1V2RnVVbUY0RUI0a3NxOGpX?=
 =?utf-8?B?TjhxNStNaTZxMXBMdE83TTBoNEN6d2MyMEIwKzY3WjFLKzZORml6dmc0a0lz?=
 =?utf-8?B?ZUhrYVhyM3Fjb2dCa04yTC9pQzRRSnZnbldTZld5bnRnRWUyNk9aTngvOWIv?=
 =?utf-8?B?UDNFeHdsNi9OSjlQdU9KZjBMK0RraXlselZzQzE1ZEFuQ0Z6anBuZTQrS0Vv?=
 =?utf-8?B?a1YvMlNUcnF0Vld0WFNHUnZBTlJuMmd3dEJsT3lBcTBrQzd1V2dkOTBPNjhU?=
 =?utf-8?B?VDRLRnRDaXc0Z01JSWVRcjZOM2JyRHJBZ1hwQ3VpY0dRb2RVU2ZiYXB4TTUy?=
 =?utf-8?B?ZnZJRm91Vmt3VVRVVS95TmRRS2NOemxsUkVDSWVXV0w5U0FxU0lFTGgzazJy?=
 =?utf-8?B?bk9oK0gwYzRCS05peE9mU2Q1U3pJL0E2ZEE0elAwWFNQa0NWdmdwV0tpQnFD?=
 =?utf-8?B?bUNYUGNHN0xZczdkN2tVZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW5MT1pDbzVmMHlMZm8wSFNLbldaN1FWVVRxVnRzdVd5czE5UE5Hc0Q1MHRF?=
 =?utf-8?B?RWlqWjFDM1RRdnBlcFpBTWc0czBacjRwemRoOStIZVNpVE9qQlMwTHNHZ09Y?=
 =?utf-8?B?TnhXTHprYTJUditQL0NiNnZ3WEVUTnYzTExXK3o5bytPRWZHVm1OcFMvTjVu?=
 =?utf-8?B?NXdsUWhJWmQ2NVNoRVV1VnQ5dXFjOHl6MXUwVTVPNXk2N1FZQXBSYzdUQmNm?=
 =?utf-8?B?dmMrbnhDdlFoeFE2QS9XM00vSHdSZUlpN2ZCblNKcU5GbXpyTE5CL0k5TE9U?=
 =?utf-8?B?dmtYRmlZcmoyTUROMnpUUkhrZVdyK0s3bitoZnI4UmhWL0VqQWgzVjQ0MkhF?=
 =?utf-8?B?N25YUGZqZTB4UEJva3ZvZDFGTnFuNTZKVWFJUnQ1SjQzTStPb016TDF6M09s?=
 =?utf-8?B?aVA2RWRnN2hFUkRaMEJBMEFVcHBaNWVoNThmV0VIU2QxOFNnMGlYbDRHdU1L?=
 =?utf-8?B?ci8welo4enEyakRyNm9qcDVvZFdqRnJOSXl4N0Q5YXUwczR6VnF6WVFPWVBY?=
 =?utf-8?B?dTRtYmZyYjNtZlkyK2N4N2E5NURWTXN4RnUwbGc1V1RvRDNjQzJRVnp4Vk9U?=
 =?utf-8?B?ZEhQcXZHMzFSQjlkSmY4UXFLSGhFRlVid0lPMlFJeDQzQTFrKzUxUXVqZUxP?=
 =?utf-8?B?MlZEbXk0dFByRCs3em5uM21Fa0crT09DWk8zSVRBclU2djB3MmQzT3ppYzhW?=
 =?utf-8?B?VGduYThIcW1nc3Mvb2dDZzhKMXR0SFdiK1JtcmZJYktvK0dOZ3FaaTFqQnRU?=
 =?utf-8?B?TUo5bnJ4d001bjg5Q3JldnNCM3BMS0pwWXhpN09WSkVnYWt4RUJhMVlEUkRu?=
 =?utf-8?B?QWs2a1E2M1BoQkFPNXJqK2ttSnp2bWxOSS83ODQwaWM2QXVEVWliMHVwV0Z4?=
 =?utf-8?B?b0VybXZKdHllVFRTZXcrUFkxNnZ0a2l3a2h6MzhnQXZVbmFERHdsSS91ZktT?=
 =?utf-8?B?RGhRbi9GSWh3K24rcHVTSCs1MFB1bXo3YXQ3NG51anA1SEUvMTJ2SEFuOXRn?=
 =?utf-8?B?K2E3Y2pyRk84Rks4bVBocFlXcm40b1dVYmpKTkZvYW9NanY3cW9OTXZ2OWNw?=
 =?utf-8?B?a1huaC9lYjdTS0FBaVMyMjRvYldQblFsOC9kZmhyaTNwdndPZ1FSampvZ0Y3?=
 =?utf-8?B?U2ZMMElJSlJCRC9xekZkckQ4dHVHSWZuYXkvY25HZEE4NmttTmtMN2VQL3Vo?=
 =?utf-8?B?L0RrN2Z2YTFxdHJRemlvL3lhUFR6NEZnRHBUMk9SWjUyZkloNXo5M0l1VHAv?=
 =?utf-8?B?aWlycFpWYVQxdFE1K0pqa2Njb1ZFd1JZSmR0ZmhjV2QrdnYyUnNmK3QxMDlM?=
 =?utf-8?B?VWdLcmxYTTBtV1RkSlc3OVRxQVcyWFBqTXN0UXpFSXZlRm52VFdtRGRTQzNN?=
 =?utf-8?B?WXJtbG5UbWNXTVBWcGl2S3VIeGUydlFMT1lDeWFlUnlaa3hzK0Y4VWxiR1JU?=
 =?utf-8?B?WkR3ZEhkRGNQYis1RFB0U1VEdHYrRGNpWkVZUDRwTWNiMlFGb0lsaE02L08r?=
 =?utf-8?B?Tk9WL0hvaTFiMUNJK2RMNGxLRUg3ZDNZa3g0TVlmb0JnZWlyT0dTVWlueGVC?=
 =?utf-8?B?dE9NZXpsTWd3VFpCTzdjYXZKc2dpTTlqV2xkbllNbXBzQW1GdGNRQUFNMmFO?=
 =?utf-8?B?SG9EOGdoRCt4TFp2TkQ4WWNGYkliUmxxR3FzWmowWUNkQU4wU3FUeS9XNXg1?=
 =?utf-8?B?NHErZ29Nd0haemJMeHFNU0kzNkVNb2JZUlhxNzJpUCtEcGtqdWFudDZNNVJF?=
 =?utf-8?B?OXlYdjJGaWJVcnZHV3hFZ0NQZTJQb1RxSkgrN3FKZlVRaDI4b2k4ZmYzenZR?=
 =?utf-8?B?QWR1VWNMZVJhOTBFWVphRnZKUXF5L2JORXNMNEJFZHJKOGNqVDdkUHkrM0ZU?=
 =?utf-8?B?MUxtRjNjZVB6dG5mRmpGeWk4WUg5eUQ0UWQyeHErT0hRQURQTXk5Mlg2QWE1?=
 =?utf-8?B?Nm1OaTdHTktUZ2dQWmdJSHRPWWRrVFViTUhtNXlueUp4SkhxR1VGZE82djRC?=
 =?utf-8?B?bDVpbjNYczZNenREbVpFdlM5SHNxeFVXeXcxRGhrR0lrSjB2VkxXT0J1SDZI?=
 =?utf-8?B?TURzUExBYnRkYi83M25kN2djR296MW0yWnZSQW1sNVlrcDg3bXlyVzRuL0ta?=
 =?utf-8?B?MkZkY2JhdE1EYkk5TFF0L3lpQ1A1S2lhQ2RTMU9XMXdLS3lyZ1VxWUFBdDFT?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d40665e8-16e4-42f1-5d4f-08dd1db7fce8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:57:01.8614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fR5UyShnXWgtcdeqKFD068UzqZn8HAEZ2ZSD7FkNsRWdp0+N/33gP677YhupAIcTLOgFXYFhxBiq+BnO6PSB1EqTJKRwqQjPkrze+L/Qezw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9524
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

Hi Naoki,

On 12/15/24 2:37 AM, FUKAUMI Naoki wrote:
> Hi Quentin,
> 
> Thank you very much for your review!
> 
> On 12/13/24 22:11, Quentin Schulz wrote:
>> Hi Naoki,
>>
>> On 12/11/24 4:39 AM, FUKAUMI Naoki wrote:
>>> Radxa ROCK 5C[1] is a Rockchip RK3588S2 based single board computer.
>>>
>>> [1] https://eur02.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Fradxa.com%2Fproducts%2Frock5%2F5c&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cbe7d810ae88f4203af8208dd1ca921c6%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638698234938145886%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=8TcHBC2dV1LzouPSR8%2FICOBVshq9RndgMQS3m3XLwFs%3D&reserved=0
>>>
>>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>>> ---
>>> Changes in v3:
>>> - fix compile error
>>> Changes in v2:
>>> - arch/arm/dts/rk3588s-rock-5-u-boot.dtsi: remove unused node
>>> - include/configs/rock-5-rk3588s.h: fix include order
>>> ---
>>>   arch/arm/dts/rk3588s-rock-5-u-boot.dtsi     | 16 ++++
>>>   arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi    |  6 ++
>>>   arch/arm/mach-rockchip/rk3588/Kconfig       |  7 ++
>>>   board/radxa/rock-5-rk3588s/Kconfig          | 12 +++
>>>   board/radxa/rock-5-rk3588s/MAINTAINERS      |  8 ++
>>>   board/radxa/rock-5-rk3588s/Makefile         |  3 +
>>>   board/radxa/rock-5-rk3588s/rock-5-rk3588s.c | 77 +++++++++++++++++
>>>   configs/rock-5-rk3588s_defconfig            | 94 +++++++++++++++++++++
>>>   doc/board/rockchip/rockchip.rst             |  1 +
>>>   include/configs/rock-5-rk3588s.h            | 15 ++++
>>>   10 files changed, 239 insertions(+)
>>>   create mode 100644 arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
>>>   create mode 100644 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>>>   create mode 100644 board/radxa/rock-5-rk3588s/Kconfig
>>>   create mode 100644 board/radxa/rock-5-rk3588s/MAINTAINERS
>>>   create mode 100644 board/radxa/rock-5-rk3588s/Makefile
>>>   create mode 100644 board/radxa/rock-5-rk3588s/rock-5-rk3588s.c
>>>   create mode 100644 configs/rock-5-rk3588s_defconfig
>>>   create mode 100644 include/configs/rock-5-rk3588s.h
>>>
>>> diff --git a/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi b/arch/arm/dts/ 
>>> rk3588s-rock-5-u-boot.dtsi
>>> new file mode 100644
>>> index 000000000000..be1a2f9ae7bb
>>> --- /dev/null
>>> +++ b/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
>>> @@ -0,0 +1,16 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
>>> + */
>>> +
>>> +#include "rk3588s-u-boot.dtsi"
>>> +
>>> +&saradc {
>>> +    bootph-pre-ram;
>>> +    vdd-microvolts = <1800000>;
>>> +};
>>> +
>>> +&sdhci {
>>> +    cap-mmc-highspeed;
>>> +    mmc-hs200-1_8v;
>>> +};
>>> diff --git a/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi b/arch/arm/dts/ 
>>> rk3588s-rock-5c-u-boot.dtsi
>>> new file mode 100644
>>> index 000000000000..bb1cc9e4a279
>>> --- /dev/null
>>> +++ b/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>>> @@ -0,0 +1,6 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
>>> + */
>>> +
>>> +#include "rk3588s-rock-5-u-boot.dtsi"
>>> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach- 
>>> rockchip/rk3588/Kconfig
>>> index b5a0e624a532..e1487ecb0464 100644
>>> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
>>> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
>>> @@ -260,6 +260,12 @@ config TARGET_ROCK_5_ITX_RK3588
>>>         Front-panel connectors for audio and case-power, -leds
>>>         Powered by either 12V, ATX power-supply or PoE
>>> +config TARGET_ROCK_5_RK3588S
>>
>> This should be TARGET_ROCK_5C_RK3588S?
> 
> rock-pi-4-rk3399_defconfig uses CONFIG_TARGET_ROCKPI4_RK3399.
> I'm doing same thing.
> 

config TARGET_ROCKPI4_RK3399
    help
      Support for ROCK Pi 4 board family by Radxa.

Here you say this option is for ROCK 5C only.

While this could be a good idea, anything odd needs to be justified in 
the commit log so that we can follow your train of thoughts.

This patch series only adds support for the ROCK 5C so nothing hints at 
this being usable/used for other boards from Radxa. Which boards are you 
planning to support with this option? If the ROCK 5B/ROCK 5 ITX aren't 
going to be part of it, why and how do I know which of the ROCK 5 is 
supported by this option?

This could also be started with a "normal" config option which is named 
after the board and for the next board support you want to reuse this 
config option for, you rename it to something more appropriate. In any 
case, please document the reasons for doing that :)

Cheers,
Quentin
