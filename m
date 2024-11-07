Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A58FD43341
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 11:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04EBA88E3C;
	Thu,  7 Nov 2024 12:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dGo3Ag8j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C08CB88E3C; Thu,  7 Nov 2024 12:04:52 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5876488E31
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 12:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqDPTn5KWBXiR8yDp9EFD4SQ6oE3kyT/B2cY/uOzqzc4KVhumd6D7yh0pq+HcBU7nisU/gNwdyEsojT3SzutaCiFgnU6EXC3Q/nPRVkiLJLB5u5cE64wEawfwZqdKwd/fO//DLZJNlbFP9WXFk/VR1IXu8rabE913TdBTPBTgiQNvbTDDm74WP4v4I59Zy0m+V5euE4qUMhcvvvGPFx/r4d+p8gqfXr9ZOkwPeuoFHWXD+gKm9AiAsI3WV5AFheTElRP3dd8j8hRYK2h9hisbT6UqtDtdoaq1KNBjuuT6sizMPuGP8tr4UG9825Rs6/X7kIXr4ckJKaVP70B8oC6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nZR8Fr9yCHAO1qFvPaG8NFTdpIkSFppFexs8N0uEQk=;
 b=a4i8kp6X/omFV5Gugtnw7N1soClmgrIq7/P4fGf0ysA7AAIDUb9nKoC5JAD6rzVpnEmTWRP+WHZBEu1BhLwwkFMAshrK69NEpBZDzfHXWa5AKa1P7g0dEvIoGU1Q+7YoLdU9loSqTmyR79o/3IRUX7WVr5Hmojo3oMjQhw4qhVGMSVvGHslVlj3lB23sOzJ/sUMnEH88IodPSp9K8f9xnNv2OaJ5S1+Q19BAN4w0OPOpIO+51H/dToFTyGRyNyXTXV2AmY76+ZO/eeeT1B+a9QtsQptLdSI5t7MeQ93/f+ks7Sec5zT3c93e/BhkJEh1pz2ViWVbzgoE2+Ed/QmmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nZR8Fr9yCHAO1qFvPaG8NFTdpIkSFppFexs8N0uEQk=;
 b=dGo3Ag8j3abZg1OIxFZoNZaF+N8X5zD23LGROTNOQwPevtJTsoIxVpOCr8Z9TefjCLzz8qogVLCeZiIjR8Ce4/71cPVddXMxWao5JjnSSQl8jZMUE7lsw/g3mU8oJq8J2f5K544+D7jOj9asEAQ9vDwC4eJfRgBMW7qAovmYA/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7323.eurprd04.prod.outlook.com (2603:10a6:102:88::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 11:04:47 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 11:04:47 +0000
Message-ID: <5cfa0fbe-5003-4da1-9933-7664da07cd4d@cherry.de>
Date: Thu, 7 Nov 2024 12:04:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 4/4] rockchip: rk3399: move sysreset-gpio logic to
 TPL
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Paul Kocialkowski <paulk@sys-base.io>,
 Paul Kocialkowski <contact@paulk.fr>
References: <20241106-rk3399-sysreset-gpio-tpl-v2-0-22aa82189eb6@cherry.de>
 <20241106-rk3399-sysreset-gpio-tpl-v2-4-22aa82189eb6@cherry.de>
 <149361d4-4cbb-4007-b00f-6b4efbd7978f@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <149361d4-4cbb-4007-b00f-6b4efbd7978f@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6fff85-bda8-4500-c001-08dcff1bfe2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzBNTEl6anE3SXhkQ3hLYXpBOTlvVUkrNjcwVVlNVExrNkdSQnBMaENVY0ZB?=
 =?utf-8?B?b0I1ZGZwRjI4WHBJU00yajRIenVWSHQrV2cvVGY1RTNQTWh3cmRFakxERXpw?=
 =?utf-8?B?SytnYWlEdU9xMi9SSGNWczNEU2xpZWVwSSswNy9Kbm1aaWsva3hWMVpPRVNq?=
 =?utf-8?B?WUxBSXpyZkYzcCtUelNaT1NGNU01VTA1MWdUUWJkbXdoV3VtaDk5NFhDdnp1?=
 =?utf-8?B?STlLME9lZXJ3d3JNdjZKT25kS0NvREw3Q3hjdFdEcm04Y0RFT1pubTdUQTYv?=
 =?utf-8?B?cU5iR2JIendzUVdkSkVyT0hGRGIwS05DaVRYWE5PenBrRUtpVDBJTHdaY3Qy?=
 =?utf-8?B?dVh3bklUTndOemJKVSsxcmZ6RWtaT1dUUVQzNTZTd1E4eDhYOUROYWNsU2tk?=
 =?utf-8?B?VC9wblZ4ejVTYU1ialJiZGlxZHBEYi9uczlaMkdSWUUyV2s2WHdFK2NhL2RK?=
 =?utf-8?B?UVNFM2VobTdsVk9EYytWSE5Dd0o5VmlLU1BzTFJXQ0pkZFEwRkR6NjZiZmVG?=
 =?utf-8?B?N2xaalYxKzRwYlFBNDNCbjlCZERuekJ3RTduMFl3N1ppaDIxU04vanBYdnN0?=
 =?utf-8?B?cWhLWHcxcEJYU21hVjkyNFdRWURhQTJsZnVGY1NxTTdsbjV4N2FncHpCZjR3?=
 =?utf-8?B?S2QvdDc1OVlFdXpQNGdwRFowVkk0MkNoNjJMUjh0U3d0Z3R1RjU4VVBWL2Fo?=
 =?utf-8?B?RzVEQzBOSEM4REc1Z3c3VVVJMFl3Z3FXM29BVjRiNUdSREg3aDc1dkpZbXlD?=
 =?utf-8?B?T2hkTzZHWmE1WC9LSVluMmxYbURITkQ1dGxhcWI1KzVOWmZFYnY0a1RZYmlE?=
 =?utf-8?B?QU9RcjBCekV4Nm16UUdhRnczYjFWVnFVbUNpYUdicDA0UGQwRXJxalludzVh?=
 =?utf-8?B?blpjRlBxdTA3cGVTazNtN2lORk04VGtrd1B3bmdQOXMvbkFPNmdyMklsRHda?=
 =?utf-8?B?UDh3RkxXNFRBSGJSME1TRE1JS2JkRVJzSVhkMnpBRCtjU2JXRFVTTk9uTWRX?=
 =?utf-8?B?a2hPU0xLY0dFYlBJY3RBamM4OXJlSlZ4L1hEZnVRTTFWRE5NcWk2aFdBK3p0?=
 =?utf-8?B?RjgvYjgrdFozUDQ2cXhCSVlGbzF2NkRmWmxyak1SNU1XYzFEdmNPajVBaXdD?=
 =?utf-8?B?bnlBK3d2bnFUQ1lUWGdLNW1DSEpUTTRCSlNOZkdxaGpNSitKSGljUUNlZ1ow?=
 =?utf-8?B?UzJZbE9UZ0VwZ1lGeUx5RGxBYkl3Uk8wUVJvVHJRcHJEdVczUUIzVVhtaVA1?=
 =?utf-8?B?LzZwcG81YU9pZnlSRWlxNEtKZ0VTU3llZENWakdxcCtaNFZrOWF3OFhlc2Ju?=
 =?utf-8?B?d3NLV3g3L1hlcTA0U1FTMkliL0kzdUt1S2FuVlpLL08xRFNkS2tNZVNiaGRM?=
 =?utf-8?B?TFBqbi9Ed1Z6cGM4RitQZVVYUTJNVHdLaFdBMmdsNE11VThueHFPRXEyRkhX?=
 =?utf-8?B?clU4bUgxc2lVRFNaOEkxWERrbDJVT0lhdXlsVE95U1NqOEhXa2xaNXZVYm1P?=
 =?utf-8?B?SUR2QVFsZmRlVGdROGF5dVJFdVI2eUY4cHkvVERGaDNBSnlPMm9UZ2F3ekVC?=
 =?utf-8?B?aTlYM3d3ZkQ1Q0FWUzc5cWQ4aEh2WUM1NUcvNmgzTXcvR0MzZGNEUmJjVEMr?=
 =?utf-8?B?S21Ua0FJTGhVSFljYTc3VzM4Z1M0cHNzSGtTc1o3MHVYMWgrSDcvUStubWl5?=
 =?utf-8?Q?8/ww/u7Z4oCWHVflZs1G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzFnNmhZRGhBeCsrVTEyb080R0xHZ2dsdHU3V0xqOG5pZFZNMW5xZ0N2NHFQ?=
 =?utf-8?B?T2N4bHg1ZEg4aTNXeWYvbm1TRDhodEUyTllXekZ3aTNNNXI3Mk53Vkt6MzFp?=
 =?utf-8?B?UTk0UTdSMkREWTY3clF3ZUpmdTI2cFJBOWFLdVNwWEUxSkVBcW1jT1Iwbmxa?=
 =?utf-8?B?NHBpKzlPbm1TVHdiUmYwZTMxcE56SmhkZVRnYUFVVTdwVi82dFdnanU5L1Fv?=
 =?utf-8?B?WDREbE5IYzNSYlhReVZ4WWxSeVNJaTRnVWRHdHNNQ0tRNW5PdEUrZlBuMzlU?=
 =?utf-8?B?eUM0NFljTThkVUpnVUcwK2RuTkV1YXFWdjNkdEpMSURPWEM0bVY3QU1yL2V5?=
 =?utf-8?B?NWQxakdhR0Jqb2tER0R4NDBMYWJZODk5WG01cmh0b0ZTYXFWdlFzOFZLaENX?=
 =?utf-8?B?RUlCRjZxMjIwWGw3TlJ5L0Y1UWtvMEJTaEtiMVI1QlFXbzg1YllkazFldWc3?=
 =?utf-8?B?cElBNWFYRWVKZXcyUWRsYVNySTRleTlpTlZuKzhDKzE2WWRBanR4MXZVdVZF?=
 =?utf-8?B?bzIxNENaT1pybmhrSWtMS1VkV2tIeHlIVktIM2REK2lyeGxiMHR3c0Jma21J?=
 =?utf-8?B?SjJtU3RwcXJRVnRqMEp6UjdwMitWWlRSMDBtbnlDNHFwNlpmV2h1Q0FMWXBu?=
 =?utf-8?B?R1VUMVlic0tBUlF3Nm1OZ01YMldRemd1cnIxWGVrRTlYdTg0bE00Zmsxd2VI?=
 =?utf-8?B?cnl6bC95eFNnSjJpMEJrQ0lpblZFeDZpNGRiQ2VaWDl3T1lFeW04YW1rSlpi?=
 =?utf-8?B?bWxDSVN1cmp4UGZZRnB6R1FtNG1PYVRNMklwWnd4b1lkUlNpREhodUNDSlRD?=
 =?utf-8?B?N0VLbVZ2aStiOWR3emV6d2ZGUDduZG04UjNpYlVNQkR1Rzl0TmprdCtkSGdj?=
 =?utf-8?B?V0ZtT25ZblAwK2lLQnRDN3N2MDdqWjNEblFSVmdnQkwxaXNGbDRCOG9xbmN1?=
 =?utf-8?B?b3dDRzg0ME9TWnBvN244aUd3Q0NUc014R3R4R3VWYk9MREZjTjFRanhzVy9P?=
 =?utf-8?B?VEdTUUNnSXJ3b012OFl0TGZVR3ljWE52NFB1VHZvWUczbnVzUkw1VElnS0Jo?=
 =?utf-8?B?WXlzcURVcFBhZnFONnR1T3N4MUR6S1JITXUrNjROeUpLajZWcXRWeU1SNHJN?=
 =?utf-8?B?OVR4cWJTb2NLMWQ4a3NrQXZxbEZqTGRMNUZaZFFmUmV4a3hIaUVyOHJDUU8z?=
 =?utf-8?B?Ykd6d3gvajlFY1BkbDRWaElGSXFWTEM1aEpQQVZ1cDVrc25FR0pCbXR2Rnpy?=
 =?utf-8?B?VFVFcDBBZFBBbVJLUGN5QzVhcm9TN2Y0UjJaOWVZRXVkdlo3cXVzTm8yWG1w?=
 =?utf-8?B?SERUTTlxSHNYdmhYTDJRN1ZmVnZUWlFpQjc0aHY1eXNTdTBvWFQ3L3ZFaEVC?=
 =?utf-8?B?SjNPNkJyVnFGU3dqNVIySHlWOVphVkJCR2E5WkZYZnJoaWFXcm16djhuQTZj?=
 =?utf-8?B?T0VINTh2R3pYbnpZekhlcUx1dStRTWM3VmpLeEZRWVROTGNmNmw5ejJIa05L?=
 =?utf-8?B?RGQza2lWbzhLUjR3Ym8wdnkwbFhzTE9JRnNUa3czYktUblpuVCsrMXRTRlIv?=
 =?utf-8?B?bytjdjJmS0RxQUNFTEVhZFpWZFJsMzNyU2lEWDlocFZldG9YTEtGZkY4WXpm?=
 =?utf-8?B?YTBOTUdxaWhQQ29aOXozT3VOQjBOVjhSK21UODBXQVhIMUsrR1hLSm5tOE5H?=
 =?utf-8?B?dFN4akRESlVnZHFOV044TkdSNmsyODM2eXYyN0NLSkdqenAvUlVqcDR4ekNo?=
 =?utf-8?B?Qk4wNTN4WktRUmU2ekNBdjdmWFVQVCs0MWhmWldjclc3cy9EUUpwUTRWTXg4?=
 =?utf-8?B?SEFmbVpwQnZ3YlRyVEY1REVkSG93U0c2YlRyZVBTQ1hDYjl1cWs5aWRETStq?=
 =?utf-8?B?emZ5NU9KaXBIVVVwalh5WUJLMzdJcGRERDFEb2NLOFc3ZDU3TlZha0JiZnZD?=
 =?utf-8?B?U0RLeUdMYzJXdTJIZ1FqSFh3MzU3VHlqK0dpZFJmS2VOKzVrWlN0SVNlQitM?=
 =?utf-8?B?dkZZTHFoRHNZNzBEVGVkVi9TZjJwT3poT0ZTNDZNNkxIVEc1MjRYdE8rMXpG?=
 =?utf-8?B?WTRMSU16WVNFWkVmU05FWGlQVDMxNGN2bHN6cEVXblQzSXVLbzVsVEI4T0tE?=
 =?utf-8?B?azV6Ti8xUXFKOHdncExpTlFMQ0RiYVRsR3Q2MVlVKzNjZUQxS0c4SmhGbHUx?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6fff85-bda8-4500-c001-08dcff1bfe2f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 11:04:47.5082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rz19sgm8gsHM+Xqy/cN9OFWflRWuumsXsZA0KDLBh+Ej7tDljsZdSAGK6Jedq/wBnrY0d2Vg2hO+kJLQrsRZ9vWjllhoV6FjOxQVyWqZkSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7323
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

Hi Kever,

On 11/7/24 8:14 AM, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/11/6 19:29, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> If TPL_GPIO and TPL_PINCTRL_ROCKCHIP are enabled and a sysreset-gpio is
>> provided in the TPL Device Tree, this will trigger a system reset
>> similar to what's currently been done in SPL whenever the RK3399 "warm"
>> boots. Because there's currently only one user of sysreset-gpio logic,
>> and TPL is enabled on that board, so let's migrate the logic and that
>> board to do it in TPL.
>>
>> There are three reasons for moving this earlier:
> 
> Yes, this movement is reasonable and needed for this workaround, 
> although still not
> 
> understand why puma board need this.
> 

Me neither, this predates me joining the company, c.f.:
https://source.denx.de/u-boot/u-boot/-/commit/ae0d33a7291a164a11ae034bcf4f71226b2bef48
https://source.denx.de/u-boot/u-boot/-/commit/5f104178bf713615dc404fdfcf0fb53d89c66a07
https://source.denx.de/u-boot/u-boot/-/commit/07586ee4322abca01db52624b925e5218538f259

What I can tell you is that it seems this is required as Paul (in Cc) is 
trying to add support for it for the Firefly ROC-RK3399-PC[1] and the 
ROCKPro64[2], so it seems it's useful for **some** purpose.

[1] 
https://lore.kernel.org/u-boot/20240926183111.1324284-1-paulk@sys-base.io/
[2] 
https://lore.kernel.org/u-boot/20240926183111.1324284-2-paulk@sys-base.io/

>> - faster boot time as we don't need to reach SPL to be able to reset the
>>    system on a condition we know is already met in TPL,
>> - have less code to be impacted by the issue this system reset works
>>    around (that is, "unclean" SoC registers after a reboot),
>> - less confusion around the reason for restarting. Indeed when done from
>>    SPL, the following log can be observed:
>>
>> """
>> U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45)
>> Channel 0: DDR3, 666MHz
>> BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
>> Channel 1: DDR3, 666MHz
>> BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
>> 256B stride
>> Trying to boot from BOOTROM
>> Returning to boot ROM...
>>
>> U-Boot SPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 
>> 15:31:45 +0100)
>> Trying to boot from MMC2
>>
>> U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45)
>> """
> So with this patch set, we can see the TPL banner twice ?
> 
> 
> PS: We are able to merge to master instead of next before next branch is 
> open, because we still have
> 
> enough time to debug before next release.
> 

My understanding is that once -rc1 is out, we should only do bug fixing 
in master. BUT at the same time, next branch isn't actually open until -rc2.

Up to you! It's not really urgent, Puma was migrated to TPL only in 
v2023.01 and we've lived without sysreset-gpio in TPL since then :)

Cheers,
Quentin
