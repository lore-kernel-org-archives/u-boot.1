Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55788C4345F
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 08:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AAC787F2E;
	Mon,  6 May 2024 10:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YeGzJnWG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA6687F8B; Mon,  6 May 2024 10:54:51 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1910087F2D
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 10:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5k+Zb9SlV/8Puec33PMmSCGn1APRifhQIQC3jrl44Tj0yvKZAFTI4gk90Qn8ICQQ92IUqVzbqRFLNnVQRm2Jc7R0ArIIy3oyna/es/r4JGXamgkar96J8Abr3PE7mn1aTR9SY3tzkVmdcwjc/CTYNa0iC/bMZMyKxOwtkcp8jD4TABiV/o5Gr8YLhINil+H0XAixkB8xSbKNnHjw7/kAFex58UOMaABC4x2bo2EdQGgxeazf4SSdZr32JMGp3IWg4CyC4gDZJOrHmN6FXbJCvpp8fj8TghtBdKCXawJsKRcrpBEzJAKkhrtQauvXwrYywP3J+zX2iMt6JB+/TLk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD5OetbelfzPGA7bLWusQijulylEe9b0J0rh+foqhBY=;
 b=FnGJkH6RDvxbepu/W01zEeBAX0PM01N3cduljJRhjGcBKfLM2Iy7SvFVeJGjfq1LtCiPXbdo5IwdXmt06fZBZbObz5RcMHOqCelg7rHwm7icIfE04DRM956+sCOJW+W8edvmp+dqkMIWwhpLjg0d+fbfHl+pUlA4TK+MIwWnAYbJ8XI/8tknj06bXH0Qf7rwr4NN1GMlhHV+ZkNiyJowfUDY7+NDrS+yRLubxfQC/Z3bkISiB7wfUvZqkZ8y80HdmFIxOQG6CqI54o+Dqlj0DJkeRENQR9cIut6+keQInOqeAKOmx6wNrwDeiXgIpvwLzDvVGQkCejtpNPWT5kuoWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD5OetbelfzPGA7bLWusQijulylEe9b0J0rh+foqhBY=;
 b=YeGzJnWGF5DJGOsKtwXiaLhs8tVqbGqZ4XQAxxYN1hFzlFgmPTXZZwExZWk58V/WfwXe828h67ZIhvqvWZXdvZEuFEN6fha9Fn2oMqUxrRoiIoeQpQyBBun5F7Ozrbf/S6N1Ojw1td7KPt7E6o7aTmiftzGvTAgm3JVFx5mwmFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by AM8PR04MB7747.eurprd04.prod.outlook.com (2603:10a6:20b:24a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 08:54:44 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 08:54:44 +0000
Message-ID: <35348244-daf0-489c-a56b-234981d95a2f@cherry.de>
Date: Mon, 6 May 2024 10:54:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: add ArmSoM Sige7 Rk3588 board
To: Jianfeng Liu <liujianfeng1994@gmail.com>, u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jagan Teki <jagan@edgeble.ai>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tianling Shen <cnsztl@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Weizhao Ouyang <weizhao.ouyang@arm.com>
References: <20240504170537.376538-1-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240504170537.376538-1-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::18) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|AM8PR04MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6680e0-8020-42fb-6a6a-08dc6daa2c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3VQOURnQktSNzZKelpLWWFvMWxMaXgrMDZySTdpQXVaMGVONHAvTWxORnB3?=
 =?utf-8?B?c3NtdTJieE1WNGdOZDdlckFTOXg4QzN4UVc1RmZTWm14VU9iTUhhTHNpTnNw?=
 =?utf-8?B?eFBWZGdLcmwxeDNOdUpnVDljcklLRHBaWjFjak9IdnJ3Ti84akloaDdPa0dz?=
 =?utf-8?B?cG5BSkRJaVFLdDZMT3JqQ3BSTW51VjMzQklhTVNMVUlDdFN0bkZzQUhnZmFw?=
 =?utf-8?B?bjdKdjQyTC9YUDVMODdncVFnN3hQaFdVUUF0ZkNYRGpyT2hUYjBQYkZud21K?=
 =?utf-8?B?SUdHdDNUaXlXMm8yeWJNRXo0aXB2OTZiQnRnaWJDWlpmazZqTGwrSVhTSzU2?=
 =?utf-8?B?MnNkY3BYTlBiNVFzcHlDOFpSS0w4dkQ4VGI1cUJ3czhqSjc2RUFmdkVLSHZ5?=
 =?utf-8?B?UTNCWVhNNmxLQnkwNjhwQlBvZm1OTlFJcjVBVUtWNGpLWUVOVTJ6Qk1jZ0pS?=
 =?utf-8?B?UUFoRG1oWXR3VG94bHFtT1k3UXR2NGVRdnF5ZllOQWw5eVlGYjNXWElQT1Ey?=
 =?utf-8?B?WThnOUFnakREblJCWjFVTGFtYmc5bm81MDlmR0Rvd3hySTFEUThpK2RWZ2Vu?=
 =?utf-8?B?cno5Z1RzZno3SmRESURxOG82OHp2bmJYV21VL20zcnN2VW03dEhmR0RJUkUx?=
 =?utf-8?B?M2RnWHRGOW5hRXRaeWo1QUNqOGYzUXJxSHhsZE9nZUhTWVY0SkJhcERUN043?=
 =?utf-8?B?L1VXeWowQlBZUGczRzBqakdYNkFHOFgyeHFGQjFpRGFSTkpId3NHYk1FUWRz?=
 =?utf-8?B?MmxIM2xrL21id05DN3J4SmNsQXpFRGt4c1RBcnlGK01odHZmdUo0TmJ0dElC?=
 =?utf-8?B?S0d4alhCNVJicW1yeFpXY0FTWUducDlnbUpITWRVV1hSVmQxMXhrVE0xTU8y?=
 =?utf-8?B?UUE5Zk03cFhLZ3kvMWV3S3duQkttOGViS25mS2tEVDh2eDM1RHRwTCtGTEF4?=
 =?utf-8?B?YUd0dUZVV1RpOWYxOGgrZ2dxaTh2RjRwbWN3LzZHTmtVM1dKTytQNm9ZV0U5?=
 =?utf-8?B?U0IvZDRUMDdFcFJkWi90cDRoOHJYazQyNkVsb09rOEk2L1RPUnlkeUY3amV3?=
 =?utf-8?B?V21CQnFHWUhoSkF4UmRod2xMVXAyUkYwQmF4QkNiMDBRYVlnMVhZcXFVRlhF?=
 =?utf-8?B?d3Zub2FUQW9MeUdFUlVHUk9ublNvTzRIZFhBWXBSQXlEc1d4Y1NiekpURWZT?=
 =?utf-8?B?aG0ra0l5dFQrRmp5NWdheUw3V2dYT1VHczNQQjEzNERqWjV3ZDBZVGdteGFW?=
 =?utf-8?B?VnFLRmdWT3BXUmJvWGhBYkZVQ1BYbmwyOVkxbWhhdzNqWWRaQTZhSjE0V0du?=
 =?utf-8?B?d29XMFFUSHZvN2t5bEFVbzdYM0lIK2E1U2VqeFhQSzhTV2pBVFhxdGxic21P?=
 =?utf-8?B?cHBFR3NGVHk3d2dxZ3RkYTUwTHhGSzBsOVdVbVhTTVBHZURTRC9NY2RCd1dw?=
 =?utf-8?B?WVNncjM3ZkpzRzI1VEFZc09oVDRlU05EUzhTOW8wYUYyelFCMTBpUFJ6NDZN?=
 =?utf-8?B?UXZBeG10WHhGSTZncWwvckFzeUthdWVBVXhsNUtlNzRSY2pBclpDRERFVVFx?=
 =?utf-8?B?c2tnQWJ5TjJHQTVyaXZUSk1PTlh2OGx5SmlGRTV4cHd5YkFqTUQwd0t5bVpr?=
 =?utf-8?B?WC9MTHJjam1GQ3pJV1ZwaEpsWU4xQlU3dnZHK3doTU5LSndFazdVZEJSTFNO?=
 =?utf-8?B?VVI3T24vRys4ZnpwcU5zZmpJZXR2RVhzUjhYSHBtdmZjYmVEM1Iyc1RRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1dNUVpWRlVMaUlsNzB4T0FmM2hEOHNacmFqdDRPbXFPUGovV3RPdXZkSkNu?=
 =?utf-8?B?enUwYXprWWR4UnRTam5KZW1iYVpQNmZtOGhXUHppeS91dmViRkhSdHZ5clZ0?=
 =?utf-8?B?eS9VNG9sUGwwbEhTYWtnTm0yR1lNeEZrcy95ZkhMTnJxQmZzWHNyNGdiTGll?=
 =?utf-8?B?cUNCd2Z3dTVXSGhLYUM3TC91UzEzbXkzVFM5d3B3RXg2UVZtSlcxRUlQd2xG?=
 =?utf-8?B?cFpZQkVQU3Z0aDVkOGkxSElLNXA1QmozUWkvRmpXMmJnWG5Gd216TTkwQTdP?=
 =?utf-8?B?Qk5IWStsY1Q0MGVsVk9YUUcrRXBTc2JLTWY3TGwyMS9yaHpSZUVzVG95ejJu?=
 =?utf-8?B?VXYwOWMwVURKUXhoWkRIYTQrNWxscW5nSklFa2x0QVYzcUFYNFpWb3N1VG5C?=
 =?utf-8?B?MmloSTltdnpoVUhlajFTc1F5dGpBOTlDc1RhTDV2OE0rSlJoV2svSTIvWmI5?=
 =?utf-8?B?QjJaUUhBeHlua0R5OE5hZm1tMzhlNEpJRmkzU3pGMzdVK2Zuc0NMbk9tcE0z?=
 =?utf-8?B?VkJiNEVOU0JyWmJMYkhUNmlqSEYzTlFOVlFIb0NZUm93MDFLZWtMZ1IxalAx?=
 =?utf-8?B?YVNINDhDU0dmYi9KL0tuQ0tPN2tndmNSSkpwQmZOdS9ITTdEdzhpbGRYQ3FN?=
 =?utf-8?B?UVJwVDhycVM0eU5FN3RHTzBHS1RnUXBGSlhGamtjaUx3dzNVemt6bHViVHBI?=
 =?utf-8?B?M2Y5Uk9VYnBJRkdPSHFSOGdSTEFoSlliQk5vRldicjVSQWVFM2dONXdTY0hX?=
 =?utf-8?B?disrMXlDWXhtRVVCVVJTb0JSZ3lCT3dWT2lDZElpWmV5MFpJSUhndTVidmZ2?=
 =?utf-8?B?ZVRnTHh6RVdMcEN6aUc3T0VnZDhLc29FRm51aFRRZ3pzYW9VeWxqUlYyenJq?=
 =?utf-8?B?Nnl4RDJwM2hlWHEyQjQ3RFV0N3BlQjgvMFZ2a09xdHA0S2dxVVBGRkdlUHM4?=
 =?utf-8?B?aEIwT2MxYW9ySmlPM09nK2xsZ0V1eUlHa3ZJc2w0TVRiekRrU2QyMEtYdkVC?=
 =?utf-8?B?d2hjODRIcmNCcys5OE9QTEZUdW1VeS9Hb1p4Sks5YzJnZ2JiRGxPKy9Hb2Yz?=
 =?utf-8?B?TGVrcHVzOTYrUFNRRFRFNUVySjhQcnozc1dVOFBkQXNyQ1IzeWl2WUFYamIz?=
 =?utf-8?B?ZTY4dm5Mc1VjTEp4M3k0aENkU0k2SmZBbEc3eVdaYjU2N3FkdTlHWUp1VSt0?=
 =?utf-8?B?YlJvbStTV2k3N0pjekJieGlsWEc5a0dJYy8ydDM2dC9NdXFKcWN4dk1pc21a?=
 =?utf-8?B?Y0k4OXJJMlZkaVNxeWtNaEo0ajUvT1RzdmNCaUx5MFpldzZPRTAyb3dpYW55?=
 =?utf-8?B?SkI1SjlRM1BGekRDOGovdHFkVENoTS9iK0xXMEpKZi9iZ0huWXRmVW92SGJp?=
 =?utf-8?B?b1hlY3g5dkkxYkxyaEpXTFlKMUpJSkc3azJnbVZiUXBNTmtlNE5zSGRxQS9W?=
 =?utf-8?B?TTNIZlRjYnVTQUlPV2FuTjlndFl5TXBhaE9adW1zTTJoZWRONExoV2VabXg3?=
 =?utf-8?B?ZGpNbGlpL1N1MGx6N2EvZ3daeWMvY2NhbHh4RTFOeXh5SWVPZzVpZFd1REt2?=
 =?utf-8?B?WU02MjFHRzZ1WkhLaEY3Z3ZhbGZjSUROa3pTa09SeDR5SE5ZbE1XRUdUbU1G?=
 =?utf-8?B?Z0VaalJXWDZkeitqZDdwQ2twVEgvaUd3N3grY1BKamx1NVl3VzM0SzQ4clov?=
 =?utf-8?B?WS9iaVJnSXk1MnA0L3ZkZjRsOGxJOGx6TnpKRTRxd3ZBY3lPdmdxM3BYeDNU?=
 =?utf-8?B?NDFvUDEvSlVaeFF0VlQxcW8wK0hLTHlvR1pkSnJES2IvL21oalBWMEwyMWx3?=
 =?utf-8?B?bDcvWjlKR0IwSzloSVZXNk1GSmlxNXNrUnkvNW1NUUIzRHZ3R2F2V1p5TlYz?=
 =?utf-8?B?dElZdktxZHdzWnV5c1lZNW1DYzE1MVlWSTNWMUZyZ01vQlg1Yy9FSVRzQloz?=
 =?utf-8?B?RW51SmJWdXo3RGVYZ3B3ZjZuRU1aWVVaMnRHN0RjRmRyZHZuRmhENElYZjl0?=
 =?utf-8?B?QVVoOWhVZmlYbUw3eXdUM0lreXZ6eXNjZnFnTU1CdVdKMzYyNWZpQ0Vabjhq?=
 =?utf-8?B?Ty9VS2NuSHJpWlN2RXZHSTE1cWlTYWRnVDdhMWdvSGZkQjlNNURZcjBCQ1ls?=
 =?utf-8?B?aFdrdCs5aG5qVmt2Q2lrMG5EZnRkcTVJMllVY3hOVzlobUFlWlA1aDBWbHo3?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6680e0-8020-42fb-6a6a-08dc6daa2c82
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 08:54:44.0818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3J7KqqKXv+nhL4UbU8EjN6NYTE/0PVFKhxr29s/DqnGcmD7DY1Qo3J6fKAR73MPeTGSV3yB7s/7syaUEUlAOapmYkDQCvlw3EV2vUa+QXsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7747
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

Hi Jianfeng Liu,

On 5/4/24 7:05 PM, Jianfeng Liu wrote:
> [You don't often get email from liujianfeng1994@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> ArmSoM Sige7 is a Rockchip RK3588 based SBC (Single Board Computer) by
> ArmSoM.
> 
> There are two variants depending on the DRAM size : 8G and 16G.
> 
> Specification:
> 
>      Rockchip Rk3588 SoC
>      4x ARM Cortex-A76, 4x ARM Cortex-A55
>      8/16GB memory LPDDR4x
>      Mali G610MC4 GPU
>      2x MIPI CSI 2 multiple lanes connector
>      64GB/128GB on board eMMC
>      uSD slot
>      1x USB 2.0 Type-A, 1x USB 3.0 Type-A, 1x USB 3.0 Type-C
>      1x HDMI 2.1 output
>      2x 2.5 Gbps Ethernet port
>      40-pin IO header including UART, SPI and I2C
>      USB PD over USB Type-C
>      Size: 92mm x 62mm
> 
> Kernel commit:
> 81c828a67c78 (arm64: dts: rockchip: Add ArmSom Sige7 board)
> 
> Note that these commits:
> - e18e5e8188f2 (arm64: dts: rockchip: add USBDP phys on rk3588)
> - 6fca4edb93d3 (arm64: dts: rockchip: Add rk3588 GPU node)
> are not synced to u-boot, so I remove usb3 drd nodes and gpu from kernel
> devicetree.
> 
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---
> 
>   MAINTAINERS                                  |   1 +
>   arch/arm/dts/Makefile                        |   1 +
>   arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi |  31 +
>   arch/arm/dts/rk3588-armsom-sige7.dts         | 691 +++++++++++++++++++
>   arch/arm/mach-rockchip/rk3588/Kconfig        |  26 +
>   board/armsom/sige7-rk3588/Kconfig            |  12 +
>   board/armsom/sige7-rk3588/MAINTAINERS        |   8 +
>   configs/sige7-rk3588_defconfig               | 104 +++
>   doc/board/rockchip/rockchip.rst              |   1 +
>   include/configs/sige7-rk3588.h               |  15 +
>   10 files changed, 890 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3588-armsom-sige7.dts
>   create mode 100644 board/armsom/sige7-rk3588/Kconfig
>   create mode 100644 board/armsom/sige7-rk3588/MAINTAINERS
>   create mode 100644 configs/sige7-rk3588_defconfig
>   create mode 100644 include/configs/sige7-rk3588.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a3b4d3712..52367bf38c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -532,6 +532,7 @@ F:  arch/arm/dts/rv11*
>   F:     arch/arm/include/asm/arch-rockchip/
>   F:     arch/arm/mach-rockchip/
>   F:     board/amarula/vyasa-rk3288/
> +F:     board/armsom/sige7-rk3588/

Can you order this alphabetically please?

>   F:     board/anbernic/rgxx3_rk3566/
>   F:     board/chipspark/popmetal_rk3288
>   F:     board/engicam/px30_core/
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index c9f1b25ad6..040238dede 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -166,6 +166,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) += \
>          rk3568-rock-3a.dtb
> 
>   dtb-$(CONFIG_ROCKCHIP_RK3588) += \
> +       rk3588-armsom-sige7.dtb \
>          rk3588s-coolpi-4b.dtb \
>          rk3588-coolpi-cm5-evb.dtb \
>          rk3588-edgeble-neu6a-io.dtb \
> diff --git a/arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi b/arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
> new file mode 100644
> index 0000000000..b9196ba5f5
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 ArmSoM Technology Co., Ltd.
> + */
> +
> +#include "rk3588-u-boot.dtsi"
> +
> +&sdhci {
> +       cap-mmc-highspeed;

I think this isn't supported in U-Boot on RK35xx devices just yet? We 
force everything to be HS200+ anyway if I remember correctly.

> +       mmc-hs200-1_8v;
> +};
> +
> +&u2phy1 {
> +       status = "okay";
> +};
> +
> +&u2phy1_otg {
> +       status = "okay";
> +};
> +
> +&usbdp_phy1 {
> +       status = "okay";
> +};
> +
> +&usbdp_phy1_u3 {
> +       status = "okay";
> +};
> +
> +&usb_host1_xhci {
> +       status = "okay";
> +};
> diff --git a/arch/arm/dts/rk3588-armsom-sige7.dts b/arch/arm/dts/rk3588-armsom-sige7.dts
> new file mode 100644
> index 0000000000..c7b46536ec
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-armsom-sige7.dts
> @@ -0,0 +1,691 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include "rk3588.dtsi"
> +
> +/ {
> +       model = "ArmSoM Sige7";
> +       compatible = "armsom,sige7", "rockchip,rk3588";
> +
> +       aliases {
> +               mmc0 = &sdhci;
> +               mmc1 = &sdmmc;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial2:1500000n8";
> +       };
> +
> +       analog-sound {
> +               compatible = "audio-graph-card";
> +               dais = <&i2s0_8ch_p0>;
> +               label = "rk3588-es8316";
> +               hp-det-gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&hp_detect>;
> +               routing = "MIC2", "Mic Jack",
> +                         "Headphones", "HPOL",
> +                         "Headphones", "HPOR";
> +               widgets = "Microphone", "Mic Jack",
> +                         "Headphone", "Headphones";
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&led_rgb_g>;
> +
> +               led_green: led-0 {
> +                       color = <LED_COLOR_ID_GREEN>;
> +                       function = LED_FUNCTION_STATUS;
> +                       gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "heartbeat";
> +               };
> +
> +               led_red: led-1 {
> +                       color = <LED_COLOR_ID_RED>;
> +                       function = LED_FUNCTION_STATUS;
> +                       gpios = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "none";
> +               };
> +       };
> +
> +       fan: pwm-fan {
> +               compatible = "pwm-fan";
> +               cooling-levels = <0 95 145 195 255>;
> +               fan-supply = <&vcc5v0_sys>;
> +               pwms = <&pwm1 0 50000 0>;
> +               #cooling-cells = <2>;
> +       };
> +
> +       vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc3v3_pcie2x1l2";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               startup-delay-us = <5000>;
> +               vin-supply = <&vcc_3v3_s3>;
> +       };
> +
> +       vcc3v3_pcie30: vcc3v3-pcie30-regulator {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
> +               regulator-name = "vcc3v3_pcie30";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               startup-delay-us = <5000>;
> +               vin-supply = <&vcc5v0_sys>;
> +       };
> +
> +       vcc5v0_host: vcc5v0-host-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc5v0_host";
> +               regulator-boot-on;
> +               regulator-always-on;
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               enable-active-high;
> +               gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&vcc5v0_host_en>;
> +               vin-supply = <&vcc5v0_sys>;
> +       };
> +
> +       vcc5v0_sys: vcc5v0-sys-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc5v0_sys";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +       };
> +
> +       vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc_1v1_nldo_s3";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <1100000>;
> +               regulator-max-microvolt = <1100000>;
> +               vin-supply = <&vcc5v0_sys>;
> +       };
> +};
> +
> +&combphy0_ps {
> +       status = "okay";
> +};
> +
> +&combphy1_ps {
> +       status = "okay";
> +};
> +
> +&combphy2_psu {
> +       status = "okay";
> +};
> +
> +&cpu_b0 {
> +       cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b1 {
> +       cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b2 {
> +       cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_b3 {
> +       cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_l0 {
> +       cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l1 {
> +       cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l2 {
> +       cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l3 {
> +       cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&i2c0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c0m2_xfer>;
> +       status = "okay";
> +
> +       vdd_cpu_big0_s0: regulator@42 {
> +               compatible = "rockchip,rk8602";
> +               reg = <0x42>;
> +               fcs,suspend-voltage-selector = <1>;
> +               regulator-name = "vdd_cpu_big0_s0";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <550000>;
> +               regulator-max-microvolt = <1050000>;
> +               regulator-ramp-delay = <2300>;
> +               vin-supply = <&vcc5v0_sys>;
> +
> +               regulator-state-mem {
> +                       regulator-off-in-suspend;
> +               };
> +       };
> +
> +       vdd_cpu_big1_s0: regulator@43 {
> +               compatible = "rockchip,rk8603", "rockchip,rk8602";
> +               reg = <0x43>;
> +               fcs,suspend-voltage-selector = <1>;
> +               regulator-name = "vdd_cpu_big1_s0";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <550000>;
> +               regulator-max-microvolt = <1050000>;
> +               regulator-ramp-delay = <2300>;
> +               vin-supply = <&vcc5v0_sys>;
> +
> +               regulator-state-mem {
> +                       regulator-off-in-suspend;
> +               };
> +       };
> +};
> +
> +&i2c6 {
> +       status = "okay";
> +
> +       hym8563: rtc@51 {
> +               compatible = "haoyu,hym8563";
> +               reg = <0x51>;
> +               interrupt-parent = <&gpio0>;
> +               interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> +               #clock-cells = <0>;
> +               clock-output-names = "hym8563";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&hym8563_int>;
> +               wakeup-source;
> +       };
> +};
> +
> +&i2c7 {
> +       status = "okay";
> +
> +       es8316: audio-codec@11 {
> +               compatible = "everest,es8316";
> +               reg = <0x11>;
> +               assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
> +               assigned-clock-rates = <12288000>;
> +               clocks = <&cru I2S0_8CH_MCLKOUT>;
> +               clock-names = "mclk";
> +               #sound-dai-cells = <0>;
> +
> +               port {
> +                       es8316_p0_0: endpoint {
> +                               remote-endpoint = <&i2s0_8ch_p0_0>;
> +                       };
> +               };
> +       };
> +};
> +
> +&i2s0_8ch {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2s0_lrck
> +                    &i2s0_mclk
> +                    &i2s0_sclk
> +                    &i2s0_sdi0
> +                    &i2s0_sdo0>;
> +       status = "okay";
> +
> +       i2s0_8ch_p0: port {
> +               i2s0_8ch_p0_0: endpoint {
> +                       dai-format = "i2s";
> +                       mclk-fs = <256>;
> +                       remote-endpoint = <&es8316_p0_0>;
> +               };
> +       };
> +};
> +
> +/* phy1 - right ethernet port */
> +&pcie2x1l0 {
> +       reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> +       status = "okay";
> +};
> +
> +/* phy2 - WiFi */
> +&pcie2x1l1 {
> +       reset-gpios = <&gpio3 RK_PD4 GPIO_ACTIVE_HIGH>;
> +       status = "okay";
> +};
> +
> +/* phy0 - left ethernet port */
> +&pcie2x1l2 {
> +       reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
> +       status = "okay";
> +};
> +
> +&pcie30phy {
> +       status = "okay";
> +};
> +
> +&pcie3x4 {
> +       reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> +       vpcie3v3-supply = <&vcc3v3_pcie30>;
> +       status = "okay";
> +};
> +
> +&pinctrl {
> +       hym8563 {
> +               hym8563_int: hym8563-int {
> +                       rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +
> +       leds {
> +               led_rgb_g: led-rgb-g {
> +                       rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +               led_rgb_r: led-rgb-r {
> +                       rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +
> +       sound {
> +               hp_detect: hp-detect {
> +                       rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +
> +       usb {
> +               vcc5v0_host_en: vcc5v0-host-en {
> +                       rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +};
> +
> +&pwm1 {
> +       status = "okay";
> +};
> +
> +&saradc {
> +       vref-supply = <&avcc_1v8_s0>;
> +       status = "okay";
> +};
> +
> +&sdhci {
> +       bus-width = <8>;
> +       no-sdio;
> +       no-sd;
> +       non-removable;
> +       mmc-hs200-1_8v;
> +       status = "okay";
> +};
> +
> +&sdmmc {
> +       bus-width = <4>;
> +       cap-mmc-highspeed;
> +       cap-sd-highspeed;
> +       disable-wp;
> +       max-frequency = <200000000>;
> +       no-sdio;
> +       no-mmc;
> +       sd-uhs-sdr104;
> +       vmmc-supply = <&vcc_3v3_s3>;
> +       vqmmc-supply = <&vccio_sd_s0>;
> +       status = "okay";
> +};
> +
> +&spi2 {
> +       assigned-clocks = <&cru CLK_SPI2>;
> +       assigned-clock-rates = <200000000>;
> +       num-cs = <1>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> +       status = "okay";
> +
> +       pmic@0 {
> +               compatible = "rockchip,rk806";
> +               spi-max-frequency = <1000000>;
> +               reg = <0x0>;
> +
> +               interrupt-parent = <&gpio0>;
> +               interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> +                           <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> +
> +               system-power-controller;
> +
> +               vcc1-supply = <&vcc5v0_sys>;
> +               vcc2-supply = <&vcc5v0_sys>;
> +               vcc3-supply = <&vcc5v0_sys>;
> +               vcc4-supply = <&vcc5v0_sys>;
> +               vcc5-supply = <&vcc5v0_sys>;
> +               vcc6-supply = <&vcc5v0_sys>;
> +               vcc7-supply = <&vcc5v0_sys>;
> +               vcc8-supply = <&vcc5v0_sys>;
> +               vcc9-supply = <&vcc5v0_sys>;
> +               vcc10-supply = <&vcc5v0_sys>;
> +               vcc11-supply = <&vcc_2v0_pldo_s3>;
> +               vcc12-supply = <&vcc5v0_sys>;
> +               vcc13-supply = <&vcc_1v1_nldo_s3>;
> +               vcc14-supply = <&vcc_1v1_nldo_s3>;
> +               vcca-supply = <&vcc5v0_sys>;
> +
> +               rk806_dvs1_null: dvs1-null-pins {
> +                       pins = "gpio_pwrctrl1";
> +                       function = "pin_fun0";
> +               };
> +
> +               rk806_dvs2_null: dvs2-null-pins {
> +                       pins = "gpio_pwrctrl2";
> +                       function = "pin_fun0";
> +               };
> +
> +               rk806_dvs3_null: dvs3-null-pins {
> +                       pins = "gpio_pwrctrl3";
> +                       function = "pin_fun0";
> +               };
> +
> +               regulators {
> +                       vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <550000>;
> +                               regulator-max-microvolt = <950000>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-name = "vdd_gpu_s0";
> +                               regulator-enable-ramp-delay = <400>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <550000>;
> +                               regulator-max-microvolt = <950000>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-name = "vdd_cpu_lit_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_log_s0: dcdc-reg3 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <675000>;
> +                               regulator-max-microvolt = <750000>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-name = "vdd_log_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt = <750000>;
> +                               };
> +                       };
> +
> +                       vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <550000>;
> +                               regulator-max-microvolt = <950000>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-name = "vdd_vdenc_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_ddr_s0: dcdc-reg5 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <675000>;
> +                               regulator-max-microvolt = <900000>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-name = "vdd_ddr_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt = <850000>;
> +                               };
> +                       };
> +
> +                       vdd2_ddr_s3: dcdc-reg6 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-name = "vdd2_ddr_s3";
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_2v0_pldo_s3: dcdc-reg7 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <2000000>;
> +                               regulator-max-microvolt = <2000000>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-name = "vdd_2v0_pldo_s3";
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt = <2000000>;
> +                               };
> +                       };
> +
> +                       vcc_3v3_s3: dcdc-reg8 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-name = "vcc_3v3_s3";
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt = <3300000>;
> +                               };
> +                       };
> +
> +                       vddq_ddr_s0: dcdc-reg9 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-name = "vddq_ddr_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_1v8_s3: dcdc-reg10 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-name = "vcc_1v8_s3";
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt = <1800000>;
> +                               };
> +                       };
> +
> +                       avcc_1v8_s0: pldo-reg1 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-name = "avcc_1v8_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_1v8_s0: pldo-reg2 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-name = "vcc_1v8_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt = <1800000>;
> +                               };
> +                       };
> +
> +                       avdd_1v2_s0: pldo-reg3 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <1200000>;
> +                               regulator-name = "avdd_1v2_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_3v3_s0: pldo-reg4 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-name = "vcc_3v3_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vccio_sd_s0: pldo-reg5 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-name = "vccio_sd_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       pldo6_s3: pldo-reg6 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-name = "pldo6_s3";
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt = <1800000>;
> +                               };
> +                       };
> +
> +                       vdd_0v75_s3: nldo-reg1 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <750000>;
> +                               regulator-max-microvolt = <750000>;
> +                               regulator-name = "vdd_0v75_s3";
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt = <750000>;
> +                               };
> +                       };
> +
> +                       vdd_ddr_pll_s0: nldo-reg2 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <850000>;
> +                               regulator-max-microvolt = <850000>;
> +                               regulator-name = "vdd_ddr_pll_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt = <850000>;
> +                               };
> +                       };
> +
> +                       avdd_0v75_s0: nldo-reg3 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <750000>;
> +                               regulator-max-microvolt = <750000>;
> +                               regulator-name = "avdd_0v75_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_0v85_s0: nldo-reg4 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <850000>;
> +                               regulator-max-microvolt = <850000>;
> +                               regulator-name = "vdd_0v85_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_0v75_s0: nldo-reg5 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <750000>;
> +                               regulator-max-microvolt = <750000>;
> +                               regulator-name = "vdd_0v75_s0";
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&u2phy3 {
> +       status = "okay";
> +};
> +
> +&u2phy3_host {
> +       phy-supply = <&vcc5v0_host>;
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       pinctrl-0 = <&uart2m0_xfer>;
> +       status = "okay";
> +};
> +
> +&usb_host1_ehci {
> +       status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +       status = "okay";
> +};
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index 39049ab35a..4c14b0be1e 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -152,6 +152,31 @@ config TARGET_ROCK5B_RK3588
>            USB PD over USB Type-C
>            Size: 100mm x 72mm (Pico-ITX form factor)
> 
> +config TARGET_SIGE7_RK3588
> +       bool "ArmSoM Sige7 RK3588 board"
> +       select BOARD_LATE_INIT
> +       help
> +         ArmSoM Sige7 is a Rockchip RK3588 based SBC (Single Board Computer)
> +         by ArmSoM.
> +
> +         There are two variants depending on the DRAM size : 8G and 16G.
> +
> +         Specification:
> +
> +         Rockchip Rk3588 SoC
> +         4x ARM Cortex-A76, 4x ARM Cortex-A55
> +         8/16GB memory LPDDR4x
> +         Mali G610MC4 GPU
> +         2x MIPI CSI 2 multiple lanes connector
> +         64GB/128GB on board eMMC
> +         uSD slot
> +         1x USB 2.0 Type-A, 1x USB 3.0 Type-A, 1x USB 3.0 Type-C
> +         1x HDMI 2.1 output
> +         2x 2.5 Gbps Ethernet port
> +         40-pin IO header including UART, SPI and I2C
> +         USB PD over USB Type-C
> +         Size: 92mm x 62mm
> +
>   config TARGET_QUARTZPRO64_RK3588
>          bool "Pine64 QuartzPro64 RK3588 board"
>          select BOARD_LATE_INIT
> @@ -221,6 +246,7 @@ config ROCKCHIP_COMMON_STACK_ADDR
>   config TEXT_BASE
>          default 0x00a00000
> 
> +source "board/armsom/sige7-rk3588/Kconfig"
>   source "board/edgeble/neural-compute-module-6/Kconfig"
>   source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
>   source "board/pine64/quartzpro64-rk3588/Kconfig"
> diff --git a/board/armsom/sige7-rk3588/Kconfig b/board/armsom/sige7-rk3588/Kconfig
> new file mode 100644
> index 0000000000..793985f531
> --- /dev/null
> +++ b/board/armsom/sige7-rk3588/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_SIGE7_RK3588
> +
> +config SYS_BOARD
> +       default "sige7-rk3588"
> +
> +config SYS_VENDOR
> +       default "armsom"
> +
> +config SYS_CONFIG_NAME
> +       default "sige7-rk3588"
> +
> +endif
> diff --git a/board/armsom/sige7-rk3588/MAINTAINERS b/board/armsom/sige7-rk3588/MAINTAINERS
> new file mode 100644
> index 0000000000..0b84946284
> --- /dev/null
> +++ b/board/armsom/sige7-rk3588/MAINTAINERS
> @@ -0,0 +1,8 @@
> +SIGE7-RK3588
> +M:     Jianfeng Liu <liujianfeng1994@gmail.com>
> +S:     Maintained
> +F:     board/armsom/sige7-rk3588
> +F:     include/configs/sige7-rk3588.h
> +F:     configs/sige7-rk3588_defconfig
> +F:     arch/arm/dts/rk3588-armsom-sige7.dts
> +F:     arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi

I would recommend using
arch/arm/dts/rk3588-armsom-sige7* here instead, as to not have to 
maintain a list of DTSes (e.g. if overlays are supported one day?)

> diff --git a/configs/sige7-rk3588_defconfig b/configs/sige7-rk3588_defconfig
> new file mode 100644
> index 0000000000..76fcd2878c
> --- /dev/null
> +++ b/configs/sige7-rk3588_defconfig
> @@ -0,0 +1,104 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3588-armsom-sige7"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y

The wiki doesn't seem to indicate there's any SPI flash on that device 
so I don't think we need to support anything related to it, especially 
the creation of the image to flash on an SPI nor?

> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_SIGE7_RK3588=y
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-armsom-sige7.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_DWC_AHCI=y
> +CONFIG_SPL_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=5
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_XTX=y

Ditto.

> +CONFIG_PHYLIB=y
> +CONFIG_RTL8169=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SFC=y

Ditto.

> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y
> +CONFIG_USB_HOST_ETHER=y
> +CONFIG_USB_ETHER_ASIX=y
> +CONFIG_USB_ETHER_ASIX88179=y
> +CONFIG_USB_ETHER_LAN75XX=y
> +CONFIG_USB_ETHER_LAN78XX=y
> +CONFIG_USB_ETHER_MCS7830=y
> +CONFIG_USB_ETHER_RTL8152=y
> +CONFIG_USB_ETHER_SMSC95XX=y

I'm surprised to see USB_ETHER support here? Is this something done on 
purpose? The board already has two 2.5Gbps Ethernet, are they not working?

Cheers,
Quentin
