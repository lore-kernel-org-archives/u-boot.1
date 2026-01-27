Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33E3D2D8E5
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 10:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E489383F53;
	Tue, 27 Jan 2026 11:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="SS5qECPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B40783F50; Tue, 27 Jan 2026 11:10:59 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E118583F50;
 Tue, 27 Jan 2026 11:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPrF3wocNz0V/ncE052qwJfJ+qjCOD7WCbSQJwog54LB8y6HM+ka9e/+ldFtpjY8s5nUsXQoHAWZMgxZzCaDHUM2HRo2vknyV9S+x9xhBS4X18ezNmxHYA/Ek1a93oRWEOAkkbgftzTFcaPDzkcAfFDQTaNFo83XtDIY7UZGmR9W1ZL7fGkkED62uhPU38JKnrfatuxxI7Us0Pu9jaqGScUmPtULKTH6LnGjFnA+jdWF7txV0wSYjGbWhiZioImVDa1KPC3lq2WhmFTBV2eKq4su3oQeW33JwvzrY6l8UNrlunUYq2C2osW1/07fk3pA7BOw1i3zVkumaOSVha9CFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2p52oss0W2pv35kU/k7nl71Yen9O1Ein8vOK8HeF6+U=;
 b=NPvSxKwhUzbXHgYsK4az/fjgeDspXV9xBTixJH47Ij6Iz4ZCYROKUM8AKtv7/d5Fv8fASm9L43qAzxBCNMtRQgR8OpzPn0IjWPLj2jRbz7fCwy5JEMSdd7TDS0Vx88gXr0CCFGMWt9N5y4oZtsT/ShzgLUxY66NYKQH7IEpC8JhJt7J5Py3lV+ja+NtSantLxUQKrKDQr8L8clxC08zQvZuPxNt9Gu6OVbwrGQms711LE8rhFIUBkJSppfKJWJVjV5NNIOmBlLyQwogvPB6LzkOkUevzh0p8w+vVsXQrCzrovqZ19p9jUENXh9HVFdrB+PEdG9yTdCtjMajapw5XAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2p52oss0W2pv35kU/k7nl71Yen9O1Ein8vOK8HeF6+U=;
 b=SS5qECPOPDcazemfdXOMQBnqzj7ExdDHcK6MqSwejyz+Xaw8JdPcC52MkD8hJS76J93lES0UZda6LcWL1tDwOkrv/qyz0R9o0f4VWtyUt/40uYBpn5/YXEzg9rAOs1Krgh77msLWH1o1z+RExE6C8m3eP/R3jPj/bTsZs9l+I6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 10:10:54 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 10:10:54 +0000
Message-ID: <c2737282-7001-46f3-8ada-58e4007329fe@cherry.de>
Date: Tue, 27 Jan 2026 11:10:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] U-Boot v2026.04-rc1 released
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
References: <20260126204548.GX3416603@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260126204548.GX3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB8PR04MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 6916e308-bfea-4b49-d772-08de5d8c5b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWJiMGplSUV5QXh4bU9GZWVRUG9CL1NqSlp5WUswWk1RVFFWZTU0SmNzTC8y?=
 =?utf-8?B?NjdLcVlCLzBveXhSaEExMkxUSjA1NllvaVg3RTBFWnJzNGoxNHc4MlFLalZt?=
 =?utf-8?B?Q093WDU0NHpzZkdGUWxsdjQ5UzZPcEdtRGNXakpOUFFHRVRGOTdHRDVQSm5F?=
 =?utf-8?B?ZWVEQjA3UnA5NHlENTN3UDVMK2R6YUUwd3l2U1NSRWJuVzMvS2tSYWV4Y21V?=
 =?utf-8?B?R0RDNWdKVzlGZXJ5SStRcTZyQ1dCeUJGZVl5ek5tYm9rZXhpRlFPeDc5ODFv?=
 =?utf-8?B?NFVnbUp4dnZYRXk0ZFJ6bDFhL3lTT0ZBdkRWSGRUcHVDbTQxV3JDdzFIN1hr?=
 =?utf-8?B?WmVlR1R1QlBNRUw3ZDhRQ2RIMVIvQWVYNlIwQzJNd3Q4azJiVDg5WkFlekZl?=
 =?utf-8?B?WlJnUlB3R0E0blhwamdRVDdyS2I2bWZUUCtqNXRMMWhHanZtWWEyUmordnIr?=
 =?utf-8?B?SWd6K0VxenFSSFo3U1NhS0t4MjFDTmttbkZLWjVtQW5vbGY3TXAxV2sxdVI3?=
 =?utf-8?B?cDZycmZRZlVlSWtpVXkrYkpwU1M4cGFYZG9NeHlWcUNyanRWZlVkcTR4L2ho?=
 =?utf-8?B?VFdHNGNYb0NaSUczNEM5QVdwNFQ1bTNZb0M0REpsUnVWSXlUdlRuRCtNMnlw?=
 =?utf-8?B?dDJxUjZJV3J4SCtXNGNyVzhsTWw4LzRjNU94d2lmdkNndDJpRHRUTzY1UTg1?=
 =?utf-8?B?dnJpaHRCTXRiMUhIalA5K1B1V2hZNjAxTWUyRmhtNHV2b1VxM0kyRmhBVFJY?=
 =?utf-8?B?aU5FQ3EyL1VXb1BjVGdnYlA5TTU4ZTVwblhieHdKb1U2b0tPNTlTVnVSa0gw?=
 =?utf-8?B?Ykk1NEo0RnR6SEZkTXlDdnlXTVF6dkhPczFJZUFBS1Q5dXhWMTBnNXA5Ylo2?=
 =?utf-8?B?U0hwTkJVTitSNmtoSFd3aTFGcjZvVVR2ZFB0aGt0cWptdTd5YW9aL0F5dklQ?=
 =?utf-8?B?OWdOWWUwVGFySFFOUHdXY05lU0xxcmc1NWxrVGdmMm5hNzlzSXl1b1BBZUtL?=
 =?utf-8?B?R3dEUGFiTGJQYTVPZytydU5adEc1dHhHN1MzRVFYQStKYTV2ZGFHT0lPNnNZ?=
 =?utf-8?B?VkppSHJrYTNZK1NmcVFOYWFOY2xkc0JrQ3BYaHZTdGRtZmtVZjhqLzRzTHlU?=
 =?utf-8?B?c3RqZk9lVWhzVTZzTVJvTzFDT3ZLeEpBYU5jL3BjUXZVL2xYb21nNVY2U01n?=
 =?utf-8?B?bHhqTnl1VXVZcFRBWUFKMER1N2pZZi9nYkhrb2VyWkxxWjJGOXB2UytHZnlw?=
 =?utf-8?B?Qnk4TU9WKytCekdNMnZBdmpFWEozWDAwVUdOa05TOGpoOFN3Ym93YkgxRW55?=
 =?utf-8?B?T3hUalRzZDRUNTZ4NkF0eGV5dUxwWDdpZEhVaUM2KzFtZWlhR1JPaVplcW55?=
 =?utf-8?B?cnBhVEZZRDZuREgwVTQvUk9sUm5sT0M2bllNR1J3TG1Yd3N4YzNud1ZGUEIr?=
 =?utf-8?B?YTRYMHhnWjRlMlR5TGMzKyttSzk4Mnd2ZGw4QnQ0ZHJ5WEhDT0h4WmR1Yjlh?=
 =?utf-8?B?VWhIZWRsYWw3VExNVElDSGtDVDhLaURQT0hwaWpQcFJLZU5ZeHFUbU84dm9J?=
 =?utf-8?B?bXEvemtjQUo0ZFhMMVZTZ1NrUFVuQXVmcVhUTTVBR05RVGhrek1XanMycE1n?=
 =?utf-8?B?SWVuR1hFZjJYOHR0REFRZU45Qkcxd0NmV1VnNHl4RFIvMlhjTlFQWkdTRjNR?=
 =?utf-8?B?UEY2c0dNcWZJUVBFblQrSlBFdTEydjF2YmJtNUY0YjlYajZEclhZRll5ZENK?=
 =?utf-8?B?OFAzYzY2MzFwenQ5V2VlVXNwUWhuZStPRk5UNE11TnFwbVlVZjhMWHNCVWRJ?=
 =?utf-8?B?Ulp2QmVnRDdBUGdGaWdOaTl1UFdjNW9BYzIxWWJ4cjhvbmc4dE1CS0xrakVr?=
 =?utf-8?B?dG11UjJhN0J1RzF1VjZTWjNEY2J6TXMrMHNNTXc2Mkh4eDlmQXBDbk9uc2Fw?=
 =?utf-8?B?dC95dk5aR1dQMmdPQU9lNDhzZ1E0d0lPTHZiL09lTlVuenhpRjVkRmVBSjYr?=
 =?utf-8?B?eWlFZ0JObDJBc3JCUnlqZy9xRkQxQzFmYVV4Qk5wVmhzTUdYLzVZTXhnNVJw?=
 =?utf-8?Q?+l6zgx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFZzUCtzbXR4cFFEcWVyZFdvay9hZEpzT2FtWEhBQm91K2FQajYzOElIc0Zk?=
 =?utf-8?B?Z1doZjlaT0dUNmFSUk5XMUFQUHBFdzBjVXd0MXJUbVNEMUE4Tm9RYkFSNFgx?=
 =?utf-8?B?aXhLOEV3Q2pUM1FQZ0lnd0ZTOVYyUzliTVQwa25Nd0YvdDRQRFAxM01DbWNl?=
 =?utf-8?B?VjNOdjFiQW8yeTR5S3E1UFFPTlQzR05ybUIzNU1BeFpuczNXeDBjTy8wblZH?=
 =?utf-8?B?L0NPbDZ5QWVpbkR3cmpSbUpNVnEra0ZxSkl5L2FhMUw0dUZIMDVsVG8xWTNW?=
 =?utf-8?B?VWdNSEtUOGZqWERtVkplZ2JxTVFTZ2F4Wkp4Y1l4T0ltb0NLcDlZTURnbGpH?=
 =?utf-8?B?TlJ3VWhtMTcrbVB4RjVjUk83UWJENGkvSHFSNWcyaW83T0x0ZGl2UCtaVGRM?=
 =?utf-8?B?V0w4bUtxeWlFYWs2RzV1MGtzbk4vZXl2N0JGY200bXloZzVuNUVFZ3IzN3l6?=
 =?utf-8?B?MndXeWE2T1FlQWdkNFdPYjA1ZEZ2YWFDanZBbEhBVDZhS0lWNnhqV2J6V2l1?=
 =?utf-8?B?NW5OR1NmTkp6eVBMVTk5bFBYMWY4ckJCbXhLSFF2SHIwU0prSHIrVjkvUXMx?=
 =?utf-8?B?aFNUVjYvMnlmMS96WGRFWHh1eDF2K3VVYTNrQUI5azltM21SOVpiSDA5b3Nv?=
 =?utf-8?B?UFA3QXBIUjRnMTVXN0trWXlFZERDRS9YNktGblRlN2lzdGx0ck93S3NjMVNL?=
 =?utf-8?B?Ky9PM3B3T3EyT0QwNnVDbTBBZ0tZUEtiOGw1bElBeUlnZFBGaktBS2pBVzA0?=
 =?utf-8?B?Yk96OGwrek9OK21yVjU3YldqNUhQWUtkUTNVVHJvUGJUWGdVZFFha3pXQjNW?=
 =?utf-8?B?eDNhVTB0OHVRNVA3MWlueTlnenNKWGw3dy9tNE1ocXFoM0g0a1ZpcW02RkdG?=
 =?utf-8?B?R0xmQm1HSTNGS3Y3S3Z6dzJHZ1g5U2hLQ3E2eDFwYnF2cy8yMlB4V0ZCOUhx?=
 =?utf-8?B?cFVDcHdISmI3S3RKWlM1bmE1OENPTW1rRXBoUmlJcDh0anpLbTIwd21MeC9i?=
 =?utf-8?B?RFhlaEhjWHRucTRsSlNRVDhKY2RENUdkeXhidzJyejAyZ1JVOFZiQXBVUkdH?=
 =?utf-8?B?RmxmNTBhaGNEQUkzUnNBSnhKbW9XL0tFUWJ6ZTVBZGJuT3plMzNEWHlVU2Jm?=
 =?utf-8?B?U2t2SnAvc0ZpN3pheXFlRHNtSXNHczdoT2pOTEhpQlFNdmxDSDdIeUFiQWk3?=
 =?utf-8?B?UEJ3dWhDcnAzSmEzcHl4ckV6ME5KaXlwMk5NcldXb3NKb3BCUFhMTFUzZlQ2?=
 =?utf-8?B?VEdsdXE2aHNwNzVVa0t6cnpXcWMzVzRMUEY3MElzUUNyT2VIN3NUdUxrS2Vy?=
 =?utf-8?B?OG13aFRRVWcxdVNpYVB1UUJNM3UyNzZBL0lpQ0xicldhb0MxVlpXUXNUQUN3?=
 =?utf-8?B?eTJXRkptbWd3VEpaTEpjK08wUWE0RGc1UVc4ZVVNcUp5RWhQYUp6dXA0TUFY?=
 =?utf-8?B?UFlUaFJhTlY3bjRuMWw0ZFZEeTBFbk1MQ25KR0hPbGk4cEk3ZW1pbS9lckZX?=
 =?utf-8?B?WWZtVk92QTNtZHNZODdhK3FWTG1LOGpKWE5NUWQ2a0NsK09obnI3VHpMUlBZ?=
 =?utf-8?B?UnpnTHVMQzJtUTJYUVdxenUxUDJMRHpCTEw3UkYza3dCcjFpak9qME9leDdk?=
 =?utf-8?B?QTV4M0YrVnY1d0daQUVOR1hCcEVLblVnYU0zeGptb2Z1RHRvY2VDZUJoVHc5?=
 =?utf-8?B?MnBsZ2Q1MGUzTEc5M2N4bUhaYTBrM0NaTWtCcnRVQm1XcFlZODEwU0xwTXZj?=
 =?utf-8?B?S2xZMmx6YW1EaDRKZzRDdnFkZExsS0FXVEFSdDdjMklpUkZ5QlNicU5DK2Na?=
 =?utf-8?B?KzlwZFhhcWIxQzR2a0JOZFhMbjZUMzhLSVRTblE2VlJKSnNzenMrYUZJMUdT?=
 =?utf-8?B?MDJodHZkNW9lekdieXVRVVVINTdXWkpIckhNVkE4ZmFOMVBnVUN2ZnF6TTQ0?=
 =?utf-8?B?WkFUOEJnQUkyU1BzOXZLN2NSUzR3UnJWSmJCbUZXR2lJSXREU1hETzV3WlpD?=
 =?utf-8?B?Ujc0N3ZRZmtpWjJPb3dHa2lkQ2dQZkhsYzhTUDFtUzk5dFdiMUNmbDhuenRo?=
 =?utf-8?B?aDZmcU16L3g0LzBQT3VZV2s4VzA0dkZ5bmRUYlNzZEJwS2VTK1JhK0ZIcXdz?=
 =?utf-8?B?bHVhKzZFSmRqQVFOd3NOQmIvMGNpTGYrNmZzeXVJVjNKSHRDMTBZN1NlaGd5?=
 =?utf-8?B?UFoxUURVT0dKdWxVWlhYQVJ2a2lrSkxHM3lxY2ljOEE2LzVqdWJoMHovNHZt?=
 =?utf-8?B?aWhpNnZoWUNvNGM5T2hubUptTHAwN0sxbytJMTdZYWI3TGNaV093Smp2YnNL?=
 =?utf-8?B?cmVqYnFlRXR3c0J0ak0rcWY4dVljUnM2NHBYMFF4eFA2Zk1aSkx3KzcxTnNT?=
 =?utf-8?Q?OpR+YKaTAA3KFvVK6m1S29jT8vYBiCrg1iWTb?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6916e308-bfea-4b49-d772-08de5d8c5b9c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 10:10:54.8225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFroWWABo7iqu44GVnYORqWjF6iJa21wUG1/4pgDkP1+gqfzFZwUCvAlGspvtttN5qI+NjKK014wkhbDB+Ezl75q/IU02KltQQ2JGql7rCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890
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

Hi Tom, all,

On 1/26/26 9:45 PM, Tom Rini wrote:
> Hey all,
> 
> So it's release day and I have tagged and pushed things out.
> 
> First and foremost, this is a bit rougher than I would like but I hope
> that doing the release will underscore the urgency of finishing some of
> these fixes. We now require for our own use to be given a correctly (8
> byte) aligned device tree. This is done in a lot of cases. However:
> https://patchwork.ozlabs.org/project/uboot/patch/20260122172247.2995437-1-b-padhi@ti.com/#3640858
> is needed to ensure that platforms that use a FIT image in the SPL phase
> work.
> https://patchwork.ozlabs.org/project/uboot/patch/20260120153314.95091-2-jamie.gibbons@microchip.com/
> needs to be addressed further to fix the case of platforms which apply
> overlays in FIT images (SPL or OS). This series also shows that if your
> platform does not boot then SPL_MALLOC_F_LEN may be too small.
> https://lore.kernel.org/u-boot/20260123161907.392211-1-festevam@gmail.com/
> contains some of the discussion around the case of SPL *not* enabling
> SPL_BSS_SEPARATE and so having an incorrectly sized empty BSS appeneded
> to the image.
> 
> So, that's the important state of things right now. Some platforms are
> broken. People helping to test the proposed fixes, or if needed, picking
> up the changes and posting the next version of them, would be
> appreciated.
> 
> We're continuing with a community meeting following the release and the
> calendar link is
> https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=MHYzYzQ1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com&scp=ALL
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> January 26th, 2025. 9am (GMT -06:00)
> 
> To join by phone:
> https://meet.google.com/tel/btj-wgcg-euw?pin=1307528552322&hs=1
> 
> In terms of a rough changelog:
> - We're on v6.17-dts for upstream device trees/bindings. The v6.18-dts

We're on v6.18-dts already, so increment one in both versions above to 
have the current state.

Cheers,
Quentin
