Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361DBC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 13:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C868882B7;
	Mon, 24 Jun 2024 15:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="cWfAq0vJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C2E882BE; Mon, 24 Jun 2024 15:09:00 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2600::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCDB188137
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 15:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9vhObewei3X/b1r4gCQzFrFD3DYb2KQuBJA7YW7kJJRAZIwOu0uAalKwbpQKNXgQMQBTMiU51I7PVs1SNAFyAZgdQfRNd0Kq4HildAzH6xzIibhUA+nj6DHyYhSZZ5fF3w1hnNbSDsBIRWjyA/2eF1Bch2xNJqtPbcTZ9W+4g6v7zMsSUnMcvU8scBzOM8lwHCkU6pmyajjgIjXsX2S9yz8Uxenn999NcahKkC1LZEh4TRSDn306r3D7eRPmRB+rMvM2h+t9t+3Rxe7VhpGn7LnZL+AkhT1TtWIxU5W0ZsKds8oFXzY1CWhn5T6OFhLzxCC/JRDtKtyQmHsmK4LAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/7OEdyi5jT0BehD7TO4eCLICfn9Azx01/5vdopgucQ=;
 b=EPG3WpcYtsqeNQzKvhAYDRFiUegkU6Hw59u9XVKxy1VDZzycsS+HXLGPRMsnRg/rz466x0D1Sg24VAekrE1g4wZashLvoDNPI8CzNUV4HyE4Zy1hlMhGtrdO73p40F3Spli6Wbgt15JAryhzooAWOjEwRz/B8OVbl87L6xRT0q3Ttk3oLlgx1m3hjntoxyXNc/pyahRqnPREtCCH5ayeh/8F8pWYkmkn5Y5xAz6zO1pElAfiqMo78n9Zvhgvnk4OBlzsis2A/saOKrpq9GjVrJtxnZ8Ga7epFKcUeBwy+7TiyqjuHGpK7PZSsNwp2aO6/+/eWI+AJy7vCOdGFh9SSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/7OEdyi5jT0BehD7TO4eCLICfn9Azx01/5vdopgucQ=;
 b=cWfAq0vJH1lyZyn0iiFq4PNFXlLVARIAnN4pDm8aPjgXHYfgb4ry3bidkk0q+FylHImwaee/n7tL43WUgQ8X4UXUuPNj+V4ze0aPDZXb7Fd/gXMALaMczVX6ftetKSw0bOyATol8uh25ehd2w+exMyVfKltqaq4J3IlD4KR4BuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DBBPR04MB8009.eurprd04.prod.outlook.com (2603:10a6:10:1ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 13:08:57 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 13:08:57 +0000
Message-ID: <888498a7-0d65-4dd0-907e-0f8eb8a92695@cherry.de>
Date: Mon, 24 Jun 2024 15:08:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: give a different name to rtl8169 interfaces
To: ETIENNE DUBLE <etienne.duble@imag.fr>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
Cc: joe hershberger <joe.hershberger@ni.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot <u-boot@lists.denx.de>
References: <1978999632.15003049.1719232814587.JavaMail.zimbra@univ-grenoble-alpes.fr>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <1978999632.15003049.1719232814587.JavaMail.zimbra@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0027.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::18) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DBBPR04MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ae41d4-4ef8-42ac-ab9f-08dc944ece41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Smhzd3UvVi9IOTFNVGhpWkRtRmJRcFRybjFvRDJiWlI3T0s4ZEhmNm55b1d1?=
 =?utf-8?B?Q0VaV1FXeXF4bzZPUm5iZGxBUUdKbmF1TTBBVmlzcHB4My8xVVJrVmxzdDF0?=
 =?utf-8?B?UEhRRkpla1huTUwxWXBMTEZjK1lVZytZU2cyYTV0N0xrNWQvQldPenU1bFFQ?=
 =?utf-8?B?Q0p3a1MvaElQaGtCK21tZFBBYlNoWjZWUEN0T0lHZnhiUDN5cUcvTTFQRW5h?=
 =?utf-8?B?V1NQOXk3RTVkb281MUpKQ1VTdlVVWVNYS3dHNGRjVjRKUlhPRmlERVg2WjE2?=
 =?utf-8?B?Ykx3bGdkUU9jd1V4Z0RDTEs3c3FDQXJxT2wyazVuOVdFdTNiZHgrMUtidCtN?=
 =?utf-8?B?MWNWREo2MnNtM0hEVEFSbEQ4UkZHZ0ViYjNQSUxLNXAzY2RuY0JKQXo5cGRr?=
 =?utf-8?B?RmdpUjhDU1RpOXZQaFNzendIZWV0Vk0zSnczNmwxWjd0Nms5UDVIcHlOUHZw?=
 =?utf-8?B?MllrR3JwWDN0TGFmKzJTdlpuQStCOVVwZXBsa0RHTmFIRWRrcSt1dTRrclBR?=
 =?utf-8?B?eGM3YW10Sk1tMWZZcFlDZHFKUVoydzR3bFZUeC9IeW9pSFR1TWtlNXhtZUVP?=
 =?utf-8?B?RC9uUEkvQzFxR0ttaHlmdmpTQUl4VndSY3FCK1h2eGE2MCs3M2RGVm9tVU9D?=
 =?utf-8?B?ZU1zcE4vU0N0bXVISytYMWxDc2h1dUlPVXBSMjllWUEwK1VXVW01QWhPcTJM?=
 =?utf-8?B?V3ovVWVQMlRSZGkrQWJtdEUyLzZtRVg3S21BOFJkS0lZNjRJYWJYOUYvU3Vs?=
 =?utf-8?B?aElxRmJZL1FxVE90SEs1R09SbTVxSHpiWkxkVisreTZUV0F6akNEU1VGTWhL?=
 =?utf-8?B?bENrZThkL3BXQ3dVTlZCdldwTFhuQks2Lzc4djRwQ2NqVEwya3ZZYURqdmJl?=
 =?utf-8?B?bEM5bnRHLytxSmNJUWlwNkVWakxmOVM4WUlTZkNMdFJRd1JRcGNjd2dlcDlr?=
 =?utf-8?B?OGNnWmc0ZHl4Uy93Q0hxQitIT1p2VWtxbkVCcEk5OWxmZnExRUhZME9WTU1N?=
 =?utf-8?B?RXdLalBXREVSQU1oK2wrWDQ0MXJ5eXJSWEdieWh6YUFIVjJEUkJJdHViVVJu?=
 =?utf-8?B?L1QwamRVd3AzSmpVTnluSXlDczR2QU5pcGJ2MnJNeUdPd3pzNG9NRTBTZTJI?=
 =?utf-8?B?WjZWSnhxMGFKS1NDbTlsNk9wYmhET05RV1V0NUFSNlJydHNaMEpCUm82citB?=
 =?utf-8?B?NFJ2VWtpdkR5d2RtQVJvOFdPSzlxMVpOV0lLTU8wWVBrSUFWb2RHaUU5cWNN?=
 =?utf-8?B?NjNOUkY1N3k4SFZXSU9GQVVCdWEzM3dadE15RjBqQnhYREV1dDUyNjl0QTZa?=
 =?utf-8?B?NWR6ejluMEpxZEorb1JEeUF4bDV6YmRjSFFQcXZ2d1d3NENvWTlHYTdkbk4r?=
 =?utf-8?B?WDVRcitRdGk0MzhMUjZzT3VJZUZtd25CcjRLWkFNYi9wZXRkZzdGUWhjeFEy?=
 =?utf-8?B?NEZEOUYybko4d2ZjRmRrc0Jwdno3YnpMaTJjTHFhVGtqN2RhR2FZTWhLWlQ3?=
 =?utf-8?B?SHFaTHZWZ1IwejB4dkUyTFVWZXE3T1J0eUwyVGRpTXlBWldid3JvL21XZm0z?=
 =?utf-8?B?cFJpYkUrcGhUMUZyMzlsZEw4b0tsOGozWEJCd2NmeHR0VmNvYllTM3hRTmpi?=
 =?utf-8?B?K2FPbWJiT0o5emVkUjRRU3NYSjVsUVlTbjNxYlF3cnVHelFqQ0NxWXFaUDAx?=
 =?utf-8?B?bmRtSWp5djNjMWhWVkMrZmQvQVRhenk0dkl5eThmRkdVZmdJTmtRWGFqSEpS?=
 =?utf-8?Q?ahc8d5gldBVGxkBsbrfUV6OpX1H1Dq9Pa0bTdUO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(7416011)(376011)(1800799021); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXIzbGczOXAyb2dQL09iWWJ4Q0s3VGdkMDVJdVFCZFlsSkdyS3JKTmRaTGhq?=
 =?utf-8?B?bGJZamlBdzNhYkdzUklSRnRqTDRQWUJGa2RQMG00Q3hpNEluZ091WDFTeVh6?=
 =?utf-8?B?Z0o5RW9DS0hkczErYlFDZFBQSWFDOHF2OHFrVlJuT0JWOFZwK3JRdEpKZ1Vy?=
 =?utf-8?B?QjNFbTlVMXJSNVROcTNXY214aVUvQ1FOemovNElPMnIxaU8ycEp6ZlVJdkNQ?=
 =?utf-8?B?UXA0QVVSRFlRY1F4dXgwYWp0M2lHVXloNGkzSnJXRE02alhqT1pnUXZUbEgw?=
 =?utf-8?B?cHVNb0drbjBZYWN4R1dtYkJKNll1d0YzSnZsTnBQNlJNVFQ1cXN2ZVB4aDVr?=
 =?utf-8?B?MEZ6allqRWR6Nm5VTkZPV0xRYXNtUTdQdEpwM2lScFFMWXNsalFWTTkvdFBN?=
 =?utf-8?B?bUtSMmVjZUVUdlJZRHFoVnJpeDN5SlZKTHdGTVN1V0I0eTQvd2JYTktNcXhQ?=
 =?utf-8?B?Yk5LL0RJbU9RaUJyZkdSa0I0Q3hoZTQxY3liUzlSNWxBT0JXR0FqaXp6bmly?=
 =?utf-8?B?UWc4b1JoZTVGZ1NPanoySVJORm5XL1FFN1pGRkZmZHp4Y3pBY2JMeDBNeHk2?=
 =?utf-8?B?RW5WMVY4Q1BSRDBFL1hVTFdob08xYUZseGo1RCtQTUdvdEx2aVk4MGtNbkZu?=
 =?utf-8?B?aWxhYUUrZDY2Vi9OOUl5bTFRUUNMWFVrZHBEZVJFZ29pckh3emhjUVRDMHJP?=
 =?utf-8?B?Ni9xTGhRc1V3NmJGRVVJdUNlNENLN2dGZ2VFOFQ0UWlMNllCSy94YlU4THoz?=
 =?utf-8?B?bnR5UUdVYjc3M1JlcmY3djdNblBrZFh6ZmQvaUNMSG1JemtWSkFWWWpab2do?=
 =?utf-8?B?YVl1ejE4YkdraVZwVHVOd3JYVjVTL3ZJQXZhTVBuRXl4TzVBcXdtcjZRRnBq?=
 =?utf-8?B?R1g5L2psQUFyajBXdVFSRmNuR2hXVHlEWXh2SzQwdWFLaGVjZXRxbTVjbUpu?=
 =?utf-8?B?cXpLQXFkbVNpUTZ6aXBUbldQc1hyaDRoQVB2WkU5d2EyclhReVJmbklNY2tZ?=
 =?utf-8?B?d0lLZVVOdlUybHdnOXBKL1lYRFcwOWRwcmtwS0xIcGphWFpEaWhBS2JKb1p1?=
 =?utf-8?B?OG1kUjJ5QlJpMlQ4dTBOQmZsNGRTUzQreXJHUE5GaHl0bGdWZFhKdzgvRVdB?=
 =?utf-8?B?c2tuRFo5MGRHNzFjMHZZTldFaTcxT28ycG0vVXE2TWp6a0lsbjlMZkVjU2VP?=
 =?utf-8?B?S3VvTU82TSticmd1cFN6WjMrWXE1L0IvWldXdVZjeWQwVW5HUkJ5YTRaQjNL?=
 =?utf-8?B?K3JnQVJIOXBGcE81MVhKQXl4OHZsRkJXTk1iNjFoUm9HUDR4WElYM2x2am5O?=
 =?utf-8?B?QURwYnJEa1cxRjc1VjlKVW0xQlp1dU8wNi85ckw0YzgrY3NoWkcranVRL3dN?=
 =?utf-8?B?ZzRLTHpKbXNjWFFvdzBTb0tNcHBtK1pBRWxZZHljNFJwcWhtN0NNdVA4SmdB?=
 =?utf-8?B?bGpZd3JTTUx0MmphbU5jZVBja3F2M1lXUitoK0FOU0Y4b0JKeks4ZDNSZy9q?=
 =?utf-8?B?akoyNXZGTlRuYWFZS1MybVk4eXJER3g2Mi9XRnYyNktEL3BISFltTmVQNFNU?=
 =?utf-8?B?WGw5ZkRDWnFjTzhmQXFNaHE4emhEVmIrdUVEN3oxQWdCc3ZkeFlQNGVEUThJ?=
 =?utf-8?B?UzRNdzVCcWdwZnoreXNVeTEwWmYwTVo3ZTE4bnpkcGJDY01KWWF1WnlnQ05i?=
 =?utf-8?B?VllMelhBOEswTlJBZWZXNmdPdFMweWI1KzhqQ2t0d1Q5V3lMVDVmSVY0b2pS?=
 =?utf-8?B?d21zWXhyTTc5RFZzUGxXdWcvZnlEQjcrWFdRVUNjSTNUNFNYek4rZU92Ymh2?=
 =?utf-8?B?dDVSTjJmanBVS2hmV3NVR1lReU1BVzQ5WVBXTk5sem03UlBkTEkxZHVCL1h2?=
 =?utf-8?B?ZFZINFI1VmpHRCtUNUpnWlNkOFRrbWU3NHZPanVRZkEveFphZFl5ajlKWFZ5?=
 =?utf-8?B?KzZsMm04YjVIdlViblJJQ2ZiU1htd2JLTVE0K2pqOUNoMHhLUTh1empXMnp4?=
 =?utf-8?B?NnAzSXVWSjlxRDF1Si94aC9iQ1lRL1ZhMFcrS3hadG10RkhhdEdlcGJtUWhO?=
 =?utf-8?B?OXJnNnY0VlowOXphQThQOFlBbG1vUUFVR0l5V3JDbU9HdStXRTRaT0lxbkl1?=
 =?utf-8?B?VG5UYlQ0YkMydEZqdE85WUowWS8wNE5HcEgxOW5tRWc3di8yaEVyeHRZTWl5?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ae41d4-4ef8-42ac-ab9f-08dc944ece41
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 13:08:57.0067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phDHi5bcZJa06IhGpWRpdItHAvR0VUJ8allBrCSWfMPW8NPVKLy5Dq35n3yQgvX6pxGEiBE8gTzpVIyqA8x9I3R8SIprZ3xGuk6Iz76afZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8009
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

Hi Etienne,

On 6/24/24 2:40 PM, ETIENNE DUBLE wrote:
> This commit implements the .bind member function,
> and gives a different name to interfaces:
> "RTL8169#0", "RTL8169#1", etc.
> 
> This was tested on a FriendlyElec Nanopi R5C board,
> which has two RTL-8125B interfaces managed by this
> driver. Since they were given the same name, it
> was previously not possible to select the 2nd one
> using ethact or ethprime environment variables.
> 
> Signed-off-by: Etienne Dublé <etienne.duble@imag.fr>
> ---
> 
>   drivers/net/rtl8169.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c
> index 93e83661ce..b30d51731f 100644
> --- a/drivers/net/rtl8169.c
> +++ b/drivers/net/rtl8169.c
> @@ -1091,6 +1091,16 @@ static int rtl8169_eth_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> +static int rtl8169_eth_bind(struct udevice *dev)
> +{
> +	static int card_number;
> +	char name[16];
> +
> +	sprintf(name, "RTL8169#%u", card_number++);
> +
> +	return device_set_name(dev, name);
> +}
> +

I don't think we can guarantee bind order so this may not be stable over 
time.

I'm wondering if there isn't a way to use the "ethernet" (ethernet0, 
ethernet1) alias in DT instead?

Cheers,
Quentin
