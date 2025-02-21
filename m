Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B16C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 13:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7FA806FE;
	Fri, 21 Feb 2025 14:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KPQhcVhR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A709F80F56; Fri, 21 Feb 2025 14:54:57 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82B4A8039E
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 14:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/3DjKunY39kqPH2ekZ3Y2NYXGsImK60P8t1EK2VcadruFzS0ouWlNiwTBOK/YmR3A11CYuVi0fgvChJ/gJ3Hjr6upuUp3X0fxslF4jnIWhpOoeEMpgIx+3yvWDUuk4xWDyO1DMA8NKYYtRrrhz5N4IXxiCS3P4N2laqhyFoJNgmsWB7nzdJZKmBauG8CMwaWC0lCj/+p2odN6ySt/T/WHJcUUgHFYmlyZfTiIq77HURf+kj9OEFlJmzBvf/WyKjc95gHHO2Jep3Mm0Vvjyrltbt9pufEJjZXBYGzIoBwxkoGE82D6YLGciEO1HX5LCaQkqSn1KGhnlfev34jJbZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+SnfGgcn2TKFKXI7/ROS+cNC7qeF/l37U95UdZxRQc=;
 b=uZiG06ktO4ez89VzpvtutWN9GIzdiQPxjAOsBt4+hyBflYJkB5CqX2uzMvXZz46H2UYdI5+hdSTBexjDEnb3pVooTv9TNBpxtEuCQkZTDjqrvW+w1TQlpN4wHTrvl5Q+TRVxmXx7kM7BLNei8UuEtuoatD99WyklLIuJdE59z51fh6DK12FpX5e7Lc3g1EXihAuizEf9MCTM94IqbvbxMZQSpE5YUSMFEIGN0ZQkh1RgpJxCEDbXH+90s9OocJKUl99O1xXc6gICn3ORGkf1PJ9Y4ZC/UppPdeN+0Kk9xyrxEacTQqN6QImkWm6oaJFvSZvXL1zZDX2YMJl09wihwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+SnfGgcn2TKFKXI7/ROS+cNC7qeF/l37U95UdZxRQc=;
 b=KPQhcVhRt75dHD69OrVTPwWZcabaYd05Wa78Ku9rPLnMysMEcsWmSa6nFBE4Z4/lY+IPAc6l+HCKdemfg06Z4C56u2LdyGLVAlFu+gAOGa9vbXpo7kS+Hy/VYbWgQCSpgU70etVzJP7boarOFm6UQnornSl7lDRgn9GkkpcZk2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 13:54:50 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Fri, 21 Feb 2025
 13:54:50 +0000
Message-ID: <60f6f69d-7bdc-4ddd-b4f6-05b8d34ca382@cherry.de>
Date: Fri, 21 Feb 2025 14:54:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] power: regulator: Avoid probing of regulators at
 pre-ram stage
To: Udit Kumar <u-kumar1@ti.com>, trini@konsulko.com, jh80.chung@samsung.com, 
 marex@denx.de, u-boot@lists.denx.de
Cc: nm@ti.com, patrice.chotard@foss.st.com, n-francis@ti.com,
 sjg@chromium.org, m-chawdhry@ti.com, jonas@kwiboo.se
References: <20250221124505.1972915-1-u-kumar1@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250221124505.1972915-1-u-kumar1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::22) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c5ac1c-9322-4a7f-6235-08dd527f4ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmdOc2s3am1RN3BsMzllSm1QVWtmRVFIUFVpSWl6TFF6d2NOcW9VOExXSmR1?=
 =?utf-8?B?M2xxdFRGcjdqQmxOT003c2lhQjhBcDlBVUpYS0kva05JUTZNZFhCYTUrZ050?=
 =?utf-8?B?UmVJY0p1UkpWd0hmQ0hIYTlNdy9Jd1k5R0RZUzhyZHFuS0luRWhoRlh6UGN2?=
 =?utf-8?B?SEVZSU9DVlpSYmgzZXk3NkJGRWxkM09QWVZaYjVYQ0hJUHo5RHRMTlhiQUN1?=
 =?utf-8?B?VmFpS21YTHgxTk1jUHlYMTY2Z21UZDgzaUxVQm5XeGpydnVoYTVGY1E1UUNE?=
 =?utf-8?B?MWc2WERiRmhYbXJIejd1cTIvUFBwQm5zY2JKeFJrMXh3T2Fjd2I3dklscXVk?=
 =?utf-8?B?dFh0czFPT0F2em1lWm9oUEJFcnNWa2VOVVBhYTNraWkvTFNsTmtkNHFxNEha?=
 =?utf-8?B?QlgrdGpSUkpmQVNtQS9QNTlpeWlEZTJIaFVRT3RaUGRnY3FsOGplcFhVanAx?=
 =?utf-8?B?Wi9yWGJiVzNIZmJNYXI1dW9tNVVkWXZmSURLLzFBVG50Yk15N3JOaHg5bXh5?=
 =?utf-8?B?eE1lTmo1ODVZTEN6MStaSzI2ZmlZQ3p2WDlqdFpBNVFrM3piOWRxNUllUmxK?=
 =?utf-8?B?ZEpuVVFlSEJCK3Rjd2xZNWFkTlpqVy9tNjV0dmNrVDdIOEc0MU5EdUlEeVh2?=
 =?utf-8?B?ZjVrSjFCVjM0WlNGZGM2bno5SDc4R0NRWFpTcVFPdzRYU1BFM3hIUlpFWXg1?=
 =?utf-8?B?bTVrSWJTUDJ6TFJIUUd1Mk4yVlVJSkNkSW4yTUVWVEhNOVh2cWtkKzdOQmlh?=
 =?utf-8?B?bHRXc2R4dUNjQ3ppa01kU0d5OENCU0trcGpGeUNMK0hzVU82RE9ScVVyQkdw?=
 =?utf-8?B?VkJjTlhhK0I1M1VVMXg5ajROL3E5WUd1NU43ZkhRdFJ0aElNcDQxU1ZUNVdY?=
 =?utf-8?B?SlBneEhhcU5ncER0ZHp1OHVtUEtEd1NpeTBXY3B4c0FCRDNQQ255YjJZOGhD?=
 =?utf-8?B?eVN3VGtKUVlhcFR3ZjZheVBYend6VFZ3azhneXRvejIvUzROdzhlOFYxckVG?=
 =?utf-8?B?WWNqSEp6Z0IzcGRiZ2c2TXJwcFRvREE1TFhGNGI5UTI2NEc3UEU0cWxlbExw?=
 =?utf-8?B?d1VQS0Z1dVJKc012b2VPOERSdkVoM054YkNOZE5HUnlBSGNDVG82Z0RKVFM0?=
 =?utf-8?B?UnlBWm1MUDJjY29rTGxxeGZBT0diOWdqLzF5UmFwSmRhK2V0SkZMd1dBc21a?=
 =?utf-8?B?VUszQWNRL1k2VnBleFZRQzN1WmdPclFhRXlLWkJLbFhZRGluRk9md2hIQXoz?=
 =?utf-8?B?Rm1OWDArU0lmbGZRc0NwS1R2VDhnWjUvUHpJSUJQaXJTam1RTzVvN2ltanA1?=
 =?utf-8?B?OHppOUJ1bmZwYnl2RnhUdGlGdEh1Q3VuUFZEUUFWTEpjdE9BRHJjaFNjK2Zi?=
 =?utf-8?B?VXFQUCs4MVlaRW9PZ2UvR0tBNlZtKy9OTEJGUHplQ2E2cWlscmVhdUZEZS80?=
 =?utf-8?B?TnVaQmlxM2VOWjNTbVZMUk1jM1F5WXV1emltUVF3clJLanlKbHBLVXlhMlRG?=
 =?utf-8?B?bE4rVjdTRWZHSERXMjNvTFhRMmxaU2V2dHFUcEpYYlJ2Y2RPYW1hdDJhdjF5?=
 =?utf-8?B?eTdpVlhMTVlqenpkWnFVbmVCUmd5bzBGdnlPMHc3UXV4QjBzSHVaWWh4a0pY?=
 =?utf-8?B?QXRwcW5nM0FNUG9aVWdlbTh3YkZQeFBTVDB4OUxuQUU0YWJYL3BBRmVUb2Mv?=
 =?utf-8?B?a0Zkeis0dU9ZYkozUzVST00zNHo3eFZoczFra0VGaE9Ub2JCd3Z5OEFCVkxU?=
 =?utf-8?B?bXlnUlB1bGl2Y2dMZXJJUGloMFhacEpGbDRTLzFOdU9BbkFpcEJwMG1jUCtq?=
 =?utf-8?B?N1l4WEFDQVNjWHJQRHh6c2Mzd1I5bFNqY0pXdDhpU2FLbUFjSzJ1Vk1peFpa?=
 =?utf-8?Q?JMpNJ5IJSbHwq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVp3VHlWV3dGV08ybElxR0dOVHI2Q0NXZnpmQzdwNjdCalhzdFdOZ3ZUK3pu?=
 =?utf-8?B?RFNobGIzbk9NSTBZVnZCc09KU0FhK2ZEOGVtKzd0RmRBMDNwWkZ6V3dHd21u?=
 =?utf-8?B?M2FFa2hGbUM4UmdORElyV0NkclliSnVGMzk5Ym9qelFXV2NpZ1dZQml3OUNj?=
 =?utf-8?B?VDcvYjRBdTlKd2s1dmZCMEdWaHFPazBUNVArbnlSc2F2b2dhempqRG9yVTRN?=
 =?utf-8?B?Ykd4eFlNRjU5YjZqQktuQkVacWZpclZuYzNEQTFkWjRVUzFMKzc5M2tYSzI2?=
 =?utf-8?B?ZzhLMzZkUzdRd1ozZWx1SEp2MG0zTGhiTVE4UFFuaEdxa2dIdmF4Mjd3UWVH?=
 =?utf-8?B?OFFBUy8xem5jT1V1ODlWSUY3aWl0Z2tzV3djVlEydHdsb2p4TDQycEtnSzRL?=
 =?utf-8?B?QU1TU2xUZ1pITEdnVE50bWVWTGw2aTcvUTdGTjZ2aUdMZmhFUDBRazZNMzFX?=
 =?utf-8?B?aGZ6anE0cjR5SlBZcXh4dlJDV0VzT2t0MUhGUWdmQW9qVWhNRUE2c3YwdmN5?=
 =?utf-8?B?cEVtcUo4a2VJL1hYeU9XbmpuRmg1cEk3Vi9BMEtWRzYxNmZKTWlvWkxzTHlQ?=
 =?utf-8?B?SS9YczFFckVabDVnNHNNMDlWdTIxNkcwVkVXdnFUK0o0NmNkeGI0enVwUlRj?=
 =?utf-8?B?TE1vTUxUeEZGNkxrVllqQmJMdmVlenJHTW56NWVNblhBYlpMTXJ0M2Q4NzB3?=
 =?utf-8?B?NjV6OVZsRkZpS1g4bmxEbHRyWVB6QlNjaHFVbG9kc3kvQ1p3WnJSZkhVTTFy?=
 =?utf-8?B?bmN0R3ZVOCsrZFZtYmRNZkVIQTVTM0hxMXVtOGZOUVl2K3R4NXVaVW11L0xZ?=
 =?utf-8?B?ZlJ3S1lRK0NFSUd6YkFPV1l3dWhGRGErbCtoU0R2dnF3dnF2N2hlL1I0SGZt?=
 =?utf-8?B?QTJjZnNlNDYxRzZaVG1XQzFlWm8wUWNPcmZLVFVEenprcFNxbnkvTnZHTldE?=
 =?utf-8?B?L041UmJBREdCYXhwVWpwWjlCNnFkeWU2ZC80ZFk1Uzg5OFNJVUpjZVp3T2Ew?=
 =?utf-8?B?anREVVZraUJJSWUwb3hyd1I5UWF3dFRsUmZxWFVHTlYremZKaXlpM05TWlJL?=
 =?utf-8?B?VkNhckMyTXVOSGhEaWFhWStJaWZZK1MvTmdpb2VwYkVlYlpTMUt2T3p5bWJH?=
 =?utf-8?B?L2lpOWovSllQQlgzQ0lhMUtOdlhZL3RIMlFVWWRUOEhkT2toa0JGZk1pSEwz?=
 =?utf-8?B?dzNsTk9VNG9XdWo0OTFNZS9raHNaR25yMzBsOVE4V3JCQzRJWkg4bkI3ZzlR?=
 =?utf-8?B?MGExd2pOVkN0WEROdjRTR2xmQk5kOUpxUnBuMXIwTkxhc21oU0pYYmJRL2sz?=
 =?utf-8?B?MDVtRFJQb0FMQTg2ckhUQlRGMEhWQ1M1ellXSy9uanJZSkU0NmVndzdSVFpr?=
 =?utf-8?B?N2RnQ1FSN0Zaekl1eXNEam91WkROWU1hTXgwVXhpQlJMdGZEbERUQTRRSmpN?=
 =?utf-8?B?SkFsWml0ZGNYMUhBRHZJdFhuU3MvS2lvY25OSzh2aWJLZ0NiUzZpWWZialJu?=
 =?utf-8?B?ZjJ0L0w4Q3VsUW5rVjdRSmFtZ3ZMWG1rd0ZyY1dvY0dwWEZUZkE1WW0yL1ZU?=
 =?utf-8?B?bjF2UTc0elhLTVdCeEV6aUNYanUydlZKL0hrKzNhYUpNYWF0anFSNEVqUXpO?=
 =?utf-8?B?dWhsRGw3dmsxZ1Z5VFAzWXFmeEtuRUlKY0pNSEUxc0cyTW5jU1p2dDFjckdF?=
 =?utf-8?B?NkYwa0lVSXcxTUN4anYrckxBUjlKZEc4NnE5WGFoeDA5WklmdkM1bWhSQ1lW?=
 =?utf-8?B?WUxVU2c1YkoxanBpSmd1TFhud05XMlREc1hxL2dHWW1LU2w3U3I0dEVWN1BT?=
 =?utf-8?B?UGc2cm1Dc1Fld1hqdXQ5TTJoK2xLU2dMemlDZEV1OXQwZkhpelZkL2YvYXox?=
 =?utf-8?B?cGFONFFISW5sRFU5S2hqci9nSWtrWi93bXpoVXZhWW52dTNhQVVYME1DQW9r?=
 =?utf-8?B?a1VzTGZ6NUQrakd3N25VQzRsRE5zMlNhRGZjK3hnNTYyVzhOOFJUbytQNmxr?=
 =?utf-8?B?Z0ZvdXZBMkJJWmZYR25JdzNoWGM0TXdMUkdJbGJtS3g1aFNWc0J1MmhCa05s?=
 =?utf-8?B?MU90bGorVmhVQTBiQWJEZ3BmVXppTVpVbHhWUlJ1aFFYclVlOXVkcW1FTFJX?=
 =?utf-8?B?aStyYUlWV2Z2SGk3VGxvRkFJZFFCMlM4cEVZQUVoYktySERXYm05MnA5bU9E?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c5ac1c-9322-4a7f-6235-08dd527f4ed8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 13:54:50.6354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtcY4AmKq91AfiDTKzQkPim8f05iY9XtYnxE6VFBmnRoCFVqFOYMmijCXOW4GMJvBRcRWkzqlkFWsI7jO4kPUwuhtKIiU9BUMOcrziVuJFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213
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

Hi Udit,

On 2/21/25 1:45 PM, Udit Kumar wrote:
> commit 51c4679d2f84 ("power: regulator: Trigger probe of regulators which are always-on or boot-on")
> allow always on and boot on regulators to be early probed.
> Due to this probing boot time increases.
> Since in hardware regulators are always on, so probing of such

According to the DT binding:

- regulator-always-on only means it should never be disabled, not that 
it's automatically enabled.

- regulator-boot-on means "It's expected that this regulator was left on 
by the bootloader." We're the bootloader so it's our duty to turn the 
regulator on.

So I'm not sure the justification is valid here.

I vaguely remember this patch was discussed a lot between Marek, Simon 
and possibly Caleb so let's see if they have something to say.

Cheers,
Quentin
