Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F46EC87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 09:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F69D830F4;
	Mon, 11 Aug 2025 11:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mWC34RAd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E39C583257; Mon, 11 Aug 2025 11:49:06 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2ED2830E4
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 11:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4f5skpWZ/3H5FUuhoWITnvamm+GSnI4iiKBtEgDD8czyy6mJNVAKTMk7dopJGQF3Te7q7QyLto1BpoO2PbGVFebeOK1Q9GOy9jZ6cdxz3nNjv1BrSK7FrtZpIC6f4+qWmjsNh+08wDgMBX2e6ZK81hg25snRS95ojAaXC2VMeAhEAVvmbUqMPBawmk8GDBQMrcijwQLqh1IKEaMqkQYme/Vk07cK2VveH9mwIcyu6/67tcFJNrhAHlR5iFLvt4Hz6LjyQ45UrJpPVQ5qLlE2aB3zxyU72JmCpSrYaeLbTxBafxbNbv9IjDXunOX57qnCprPPFf/gfW/+MaTKYbQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9A+FsK5kS7iKQSXBQUJP8VMZA+lwIDiBgXkIkBbDI5I=;
 b=R9qeFiSMFuVVaQ75WL4xCkwvTXptMl1y29O0jtzZ02mLOKYhNEy+dBnvfTAdUjtfCtLbdC5oWHY/b9uM3nbXd+oO9O0rmxuNtYPWdWO4xo/3YHIkdMqRuVGl2EVanUps5UQRJAsbpm6+rSCc/+8xmHJS57qmBsi/nwdjwfFqRlpk6xcSDoG8Zpqm2AhTFPDlAl/NbUYi2UYGrQFe8ScD1qV+TQcWVu+3YWayWE1Js50jV39LM692MYHQd4oHbGuBrUQaUQfmgTmJG17KtmZm9LwNFyLPd1G6NoRL/CWtcNHboq8b9SaShZhMTpNtFbW0dpjsWgrKrjrlMHRgxxzzWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9A+FsK5kS7iKQSXBQUJP8VMZA+lwIDiBgXkIkBbDI5I=;
 b=mWC34RAd2O8McaOBomOmTeu44uuTzC1x+GZnPjcCZZioNtkqJpI4YKd68aeWGcWsX+Ew1wvHX97srIJYpAEGtMsh2Icf0EUQiW+ctztN+FCYsgg4rQEtXztyTQGIN7miHZvS//sHSpZm5Suh+LkaVGYIDIeAMXWkknEZvI/ND/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAWPR04MB9960.eurprd04.prod.outlook.com (2603:10a6:102:38b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.11; Mon, 11 Aug
 2025 09:49:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 09:49:02 +0000
Message-ID: <ae2e5a9c-ce3c-48db-ad6b-1ce4033e3816@cherry.de>
Date: Mon, 11 Aug 2025 11:49:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] rockchip: rk3576: Add SPI Flash boot support
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250801210619.2618622-1-jonas@kwiboo.se>
 <20250801210619.2618622-4-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250801210619.2618622-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAWPR04MB9960:EE_
X-MS-Office365-Filtering-Correlation-Id: 14167863-cfb9-41b5-e8ea-08ddd8bc4d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amFyMnFGUThxZzNoZ2tDb2Rza2hwdUNuV1l1Z2F6UnJFN094blhIbGdkNm5h?=
 =?utf-8?B?NjY3VnJLL1JVcTlDU2d2UlZIUXRoL0NZbXhOOGE3UlV0dVlNVlRQTDJlSTV5?=
 =?utf-8?B?WlRBdG1aOUJHZnc2cDl1bk5sQWVxM2E1djBVT1VGSC9qZTQrbitqUmdwWHB2?=
 =?utf-8?B?WXk2T2ZtVXc1WmZPRldkU0xYZmdKZWdKQnlsdHBpWWV0NlZrME9PUjRWRHZX?=
 =?utf-8?B?Q2p1Y2JVWkwxTkplZzY5aTJOeWxUMVJtdG9mb0l1WGlCYzZkb3l6c1pBcUt5?=
 =?utf-8?B?cGJMaDc3Mi9xQ2RUcEo4SW1jdTQxb1JqbXNwRGxmdGNYbnFMa3NqYWc1TFBi?=
 =?utf-8?B?YlhMaSsvdXJzUTA5VnZaeXF0QWV5SERVRUNiUHlBcEhoNG1mSFNmTitDSzJm?=
 =?utf-8?B?bWpWMlgwWGIyQXF6UGxTWk9XZDVOZUtzcVhaaGprMHpHUUJZVzBrZ0RyNUNB?=
 =?utf-8?B?cFcxaGhjS21GeXdWSS9rWmo2amplckk4M09zZ1dLWjU4Zzkyd0xKVHhTc21F?=
 =?utf-8?B?YVkxWHNNZ3hyR29xOTVZYUtlWjF2K1gyQ0h1Yk1tV053Tzh0SWNaMDdFb2dG?=
 =?utf-8?B?cVd2M0FISFJlSFR5VjZTQmRYUFk5b0M3V3VqQ2hTeTR2UTNSckl4VXZxb0dx?=
 =?utf-8?B?eWtpdXlwTWFucGFQTFQ0bjAvbDhwaWJIamx2VDZxYnBUbDE2elozaFBMQ1lX?=
 =?utf-8?B?aHdNdHFsakRFNng4SXhwRVd5MU5wSGpCbjEyOUlXYzlVM1JSdWxXTjNmN3dH?=
 =?utf-8?B?MHpKbFNyT2ovdUNiYWVXNE0xTXJ3UG5tNi84UkE2QkJLaUpDQW40UWxyTWk4?=
 =?utf-8?B?bnB6QXlORGlUeEU3TW9MUWNlUFd4R3lPK2k3WlJITGdheXRtNkc5Z05nUlJW?=
 =?utf-8?B?OW82aXpRb3A2YWJTVUFzaHR4WW9BQ2tWREJXdHZCakpvaFZ0ZC9oWjhYTyt4?=
 =?utf-8?B?MHdiQkFjdnVmWjlxNjhCOTgra1lmSGZUMHN4eEVoei9KcFJRWnp2Z2EyTEda?=
 =?utf-8?B?YnljN0ZkME96T0pqR2xuMDU3NFBhRlZCRE1TaFUxU1ZMcmkzMStJU3Blcmlj?=
 =?utf-8?B?WUU0RlRKVG5ESWQ5am1DNjEvTDBUazV1STIzekEzZFVDTHVnbmdYQklLdzhP?=
 =?utf-8?B?amlEcnB5TnNiVmNHYjBLQ3NrYUovam5pYkZ2N3ljUWNnQ3ZjdmxQcjdBR2Rn?=
 =?utf-8?B?b2VRZTcva1J2OGRXcnV4OENoTVVrR2UybkpMOFZ1c29ISEMyd0x0RVhLb1RZ?=
 =?utf-8?B?VDJibDQ1QUVZTFVLdmFacDNjQUJ3Y0xVYmszZ1dlZXJ5c3lxVUt6b1FWbHZq?=
 =?utf-8?B?UkVEcE1odVJFR0Y4cG5VdkRwWXJEbmlXcyt3QnBiTzdoTUxuYlpRbkx6L09s?=
 =?utf-8?B?dmp2ZjRWaFJ1WWx2dnBOdEN1Yk0vdDBWVDlTTzRvNGdzbk5rNGdpcE9pSUF0?=
 =?utf-8?B?RW1BUU90elgrb2hwU3hibkM0emZmMmxRQmlYMzVvSTdqNjRoK3lTRnRFby9K?=
 =?utf-8?B?V0FRb3RKbDNNbWQ4bE10cG5JcnNDR05BVlFzTEFaZGozVEdNZjF1VXFic0wz?=
 =?utf-8?B?bGdIeStpUzN3RG5pNVNKaHRqcUhRQkRyUmF3dFoxV21nd1g0bUk3NEpUUS80?=
 =?utf-8?B?YUtWZ2JMU2JQdXFURGhrakNxVExJM2k1SSttbU02R1hFNncyUW5LNU0zSWU0?=
 =?utf-8?B?T3VIQ05CYjJJMW9KekYyQ0JrM1FzN0QxTytUOE5jYzJ5b2w3QlNVbHJVNmM3?=
 =?utf-8?B?bFFDZk42bGZ2cVRoMkVSTzNKdmYwL0dPSlFla1dicG54WHI3RTBHQUJZb0pO?=
 =?utf-8?B?WDlQSit6eERESlZsZVErdDN3TUdsRjMybTlCc2xJMTRLcTRNLzNpNG5tZU53?=
 =?utf-8?B?Q1h0Ym8wU1A2UEJiYVRwNGUwaCtiaEdTZ0JEd0gxcVdDVHdBbUFzaHFwRVo2?=
 =?utf-8?Q?yBpXfVcL22k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDZiZjA5Z1BKVTJhaGh3dEt2VXl4V3Q3RkN0YjdGNlNhQ09Xc1cyZEFXaGJy?=
 =?utf-8?B?L2lBTS9FNzFMd1k4ay92Rk1LN0NiR0M3YUd3VXArdUZuVWJXcE80RGtFZWJr?=
 =?utf-8?B?TDhLL1ZJTDRjRnp4Znc2bDh6ZVVvQkdRK0w5dVlCSVlhRVJBODU5TFdwV1Jk?=
 =?utf-8?B?NEMrK0F2T1BkMjN6a0kvcitXb1JEeCsrWktNbTdTNnZrYmM4dy8xQ0xIRkEv?=
 =?utf-8?B?NVAxQlRHdHlzYzVVM3l1aDN4ZFRDdWJ1K2tMYTNPMXRMR3RwNS91OWkxQThQ?=
 =?utf-8?B?TUx0b29PczgzQmlrMUNNR3hBVlhCcWtLVFJwcHVQekxyMUw4UU5Na3BhaDRo?=
 =?utf-8?B?aCtxVG05ekduYjh3SWxSZ3hMVHFWTU5WNUN1V2RhSlVUanRoeDFQem54b0Y0?=
 =?utf-8?B?dzhBMENaN3k4OXBtY2kwZUc4aFUvYnhIRFhuTlk1RlREaG4ybXB3a21TUzg1?=
 =?utf-8?B?NmN3aXhraFNWbERuSW05RElCV1F6c0IvYkEzTkRUTjVKaC9TRGJweGZHTjJP?=
 =?utf-8?B?SXdiMzFOWnBjV3g4NGJOd0N2YzhOV0VHaldjMFRQSFJLWkFmcHRpbk9WUk5N?=
 =?utf-8?B?MGYyVmxxWi9heFo3WmZkSURwd24wbW1YM29lY1UwM2ordUtYOHE3WkNJV2lw?=
 =?utf-8?B?V0U4b2lYc3ZSdi8yc1AwdHhUTURYSXRLd1Fpak1yTndkWVJNajUrN2x2QjQ4?=
 =?utf-8?B?SUNrK2VWUjlmc2FRcVgxeWxVVXpiT0RITjdQdDFMS1VKSncyMXhHdHc0RG9N?=
 =?utf-8?B?dm4vbWFPNGRLSTdjREE2ZWVlbWU1VWRsdjJJQ0JKMFExY3pZMG51U3plcHZL?=
 =?utf-8?B?cjJpM3E3R2lYaXF5Z0pFa3BpVVZoUEMzOFZ6Zm51U3F3ODhVdG05dEMvSGtQ?=
 =?utf-8?B?bzQvNmF1ZVo1cldPT3dXY1dHODg3U0VOdlc2aEV6aExna1NlbmJvd1hBV0xE?=
 =?utf-8?B?Y3ROdWVxVkszN2VDOXdlWndJVy82UmV5VS9mSnFXcEoxZlNTTzc1SVhJd2Js?=
 =?utf-8?B?UkMvZWlhc0NjMWtXcFdrSnZNNXZaMG1iRUwrSEh4UTM5V1NzeDhjanhxa1ZM?=
 =?utf-8?B?Rnh5MERPK01NdTFOL0lLQVA5QUVId0xWT1l4N0Rsd28xMEIyZUNhT2dSSEx4?=
 =?utf-8?B?am94YkJNVFJLSmdHSmdSQ0NQVUJHM2FHRGJtMUZMaGR4RTFWZHF0c3VRcWFv?=
 =?utf-8?B?NzcwMlQ5SS9Nekd5RUtoemVuTmU2UjZxZDV3UTdSMENBU3VVblI3cUJhY0l5?=
 =?utf-8?B?cm1EVTc3UlpnYXVPbkl1OE1lWGsyUFpsNjhoTDB3ZERmbnJ6WW5TOEhwRG5z?=
 =?utf-8?B?MjgxUy9XTWR1QkYyMTl6Vmhic0MvakdNQ2dlVzVSUDg0SDJkU25GWVpCSGdC?=
 =?utf-8?B?QlYveW9vZ0xxVTZxN2plOEF3dkJNOUhLd2MvNzY5WldiVWNuOFd6RGpqdWc3?=
 =?utf-8?B?ZnkwZ0JiS2tkWEkvZm50LzF3T0IvZUJRYzFibjkrc3FpZEZ5RDdiNmlEY0Nn?=
 =?utf-8?B?SkJpSTJBTHFLckoyUDVZRXRqZi8xWUNXbE45MzE0cUVTejM4UGFJVXhQQXZV?=
 =?utf-8?B?dG5YL2NlTnN6VU5POCszeU1JVWpRSG83ajRNS0NJNkw1T0gzaGVxdG1WZTRH?=
 =?utf-8?B?c2YvMWtwTXo4WkZYUkRycm45NW1yUjE3MlVCaU9PeS9HbmJMZFJ0ZTVBSlpo?=
 =?utf-8?B?YjIxQUp4M3VTTlBJOEh1UE10NGppWWU2K25TbXZzdTlsckFQSGtNZ1dkcUpk?=
 =?utf-8?B?MENHdklNUUNEVXNXTndSVkdJNE9zNjFRYncxdzBwcDFsTDNXcHNBUldiZUg1?=
 =?utf-8?B?UUlQMEpxMitLaFB5bzZHV0x5TENCZkhUTnhaQS94U2dLclJROXhKOERtTS9s?=
 =?utf-8?B?OUJuRjFtaWlvRFlXa2cwYUFrRlBSMTJNb2krenllSFZLVEdtZjhDcEw2aHds?=
 =?utf-8?B?NXF6N3VOQUt6eFRoSy9kVkkxdm0rQ1Z4S2p4cVZ2VVJtdDQ1SXFlSzdBUWxl?=
 =?utf-8?B?ajRhMjUxZ3lRdXpadGVDTVB5OUNraCs2QmZUelZKTG9RYkZMbDVUR1U2YU1r?=
 =?utf-8?B?ZG11UWUvRE1HbkY1ZDdRWU9YMFYrNE1WUEhQTjVhT0dSaUJneVRLMUs2SkRr?=
 =?utf-8?B?TDBubjhITGplNUliQ1lnMFhVcVk1UFpEajYxTmxoOVg4TjlGOW14LzFod0wx?=
 =?utf-8?B?dnJiQ3pnWVBDUzRFTFB6enUzZm5Fajd3NXFIT3VvNDYrdXptUXJZL082TUJH?=
 =?utf-8?B?VmFIUEorNmszSGdzcXAxUm12R2J3PT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 14167863-cfb9-41b5-e8ea-08ddd8bc4d5e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:49:02.1621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5KQAo7knewITC22K0PwW1anV5L1LuOvr5JmGgWoSnFlnsO+lhJgEjUMSYwXaw9j6l09Cwj4l33vMWhYqj4zn0T3IGPfNLJvHHb1mGbMyZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9960
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

Hi Jonas,

On 8/1/25 11:06 PM, Jonas Karlman wrote:
> The bootsource ids reported by BootROM of RK3576 for SPI NOR and USB
> differs slightly compared to prior SoCs:
> 
> - Booting from sfc0 (ROCK 4D) report the normal bootsource id 0x3.
> - Booting from sfc1 M1 (NanoPi M5) report a new bootsource id 0x23.
> - Booting from sfc1 M0 has not been tested (no board using this config).

I would refrain from adding partial support for it then.

> - Booting from USB report a new bootsource id 0x81.
> 
> Add a RK3576 specific read_brom_bootsource_id() function to help decode
> the new bootsource id values and the required boot_devices mapping of
> sfc0 and sfc1 to help support booting from SPI flash on RK3576.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: No change
> ---
>   arch/arm/dts/rk3576-u-boot.dtsi        | 36 ++++++++++++++++++++++++++
>   arch/arm/mach-rockchip/rk3576/rk3576.c | 23 ++++++++++++++++
>   2 files changed, 59 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
> index fb5a107f47d9..c7ed09e03eec 100644
> --- a/arch/arm/dts/rk3576-u-boot.dtsi
> +++ b/arch/arm/dts/rk3576-u-boot.dtsi
> @@ -6,6 +6,11 @@
>   #include "rockchip-u-boot.dtsi"
>   
>   / {
> +	aliases {
> +		spi5 = &sfc0;
> +		spi6 = &sfc1;
> +	};
> +
>   	chosen {
>   		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
>   	};
> @@ -16,6 +21,17 @@
>   	};
>   };
>   
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> +			offset = <0x8000>;
> +		};
> +	};
> +};
> +#endif
> +
>   &cru {
>   	bootph-all;
>   };
> @@ -45,6 +61,16 @@
>   	bootph-some-ram;
>   };
>   
> +&fspi0_csn0 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&fspi0_pins {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
>   &ioc_grf {
>   	bootph-all;
>   };
> @@ -116,6 +142,16 @@
>   	bootph-some-ram;
>   };
>   
> +&sfc0 {
> +	bootph-some-ram;
> +	u-boot,spl-sfc-no-dma;
> +};
> +
> +&sfc1 {
> +	bootph-some-ram;
> +	u-boot,spl-sfc-no-dma;
> +};
> +
>   &sys_grf {
>   	bootph-all;
>   };
> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
> index a6c2fbdc4840..3d5bdeeeb846 100644
> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
> @@ -36,8 +36,17 @@
>   #define USB_GRF_BASE		0x2601E000
>   #define USB3OTG0_CON1		0x0030
>   
> +enum {
> +	BROM_BOOTSOURCE_FSPI0 = 3,
> +	BROM_BOOTSOURCE_FSPI1_M0 = 4,
> +	BROM_BOOTSOURCE_FSPI1_M1 = 6,
> +};
> +
>   const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   	[BROM_BOOTSOURCE_EMMC] = "/soc/mmc@2a330000",
> +	[BROM_BOOTSOURCE_FSPI0] = "/soc/spi@2a340000/flash@0",
> +	[BROM_BOOTSOURCE_FSPI1_M0] = "/soc/spi@2a300000/flash@0",

This in addition to BROM_BOOTSOURCE_FSPI1_M0 in the enum may mislead the 
user into believing it is supported whereas we most likely need to do 
another mapping in read_brom_bootsource_id() below, so I would just not 
add either to this patch.

> +	[BROM_BOOTSOURCE_FSPI1_M1] = "/soc/spi@2a300000/flash@0",
>   	[BROM_BOOTSOURCE_SD] = "/soc/mmc@2a310000",
>   };
>   
> @@ -85,6 +94,20 @@ void board_debug_uart_init(void)
>   {
>   }
>   
> +u32 read_brom_bootsource_id(void)
> +{
> +	u32 bootsource_id = readl(BROM_BOOTSOURCE_ID_ADDR);
> +
> +	if (bootsource_id == 0x23)
> +		return BROM_BOOTSOURCE_FSPI1_M1;
> +	else if (bootsource_id == 0x81)
> +		return BROM_BOOTSOURCE_USB;

I believe this differs from what we've done for all other SoCs where we 
have an entry at the offset bootsource_id in the boot_devices array.

On RK3588 it seems we're doing something similar of defining new 
BROM_BOOTSOURCE_ values in another enum and using them in the 
boot_devices array as indices. However, it seems we're using them 
verbatim instead of doing the mapping like we do here in rk3576.c. The 
only reason I could think of that is that 0x81 would create a pretty big 
array for no specific reason. Considering we already have an entry for 
the exact same scenario with a different number, I feel like it's fair 
to do the mapping.

It would be nice at least to provide some information on why it's done 
this way since it differs from what we've done until now. Especially 
that the enum doesn't match the raw value from the register anymore.

Cheers,
Quentin
