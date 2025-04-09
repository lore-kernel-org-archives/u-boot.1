Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95624C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 09:41:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15AC383531;
	Wed,  9 Apr 2025 11:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BrKI5V7h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A3FA835D8; Wed,  9 Apr 2025 11:41:51 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FEB883061
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 11:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M44p5qtJr5b0guZCjCkn/Q7dKbDvT0cFYLCHqXY6yO0PRCiFOYeGkdDC9r8aS+pb5YCn0ilWa4NKc++NCXhs3jF7HObYiMVE/rc/DJT1LFxfIcj7HthAEMaw6SoyAt7xTghoZKG9Tyf/QUDwxMKooZswddWx4WOOxIE3ysFnxeS455O2kFBca0N2cPwCyhhFL2nNQjx3n8x2FDcUEx3ZZ+wZU8eG2RwRd7+/oV6UaAq76rPYxDQXtk7iN1QvGfvniQGyH6bpeC5AtaubMSoK1StngsUp7M1ZxVa087v78b3u1QdAYKR7cvuHGVPBWYM5LJPFWI/J2a3rCCDZT8olpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayLMTrSwPtpQp0+8A1N8sgLwIJjp7ucfl5Xsn2xd5zI=;
 b=JorMoA2xnMcg7E38U3fIcx2+Jya0cGf+okAbI3/onCu6Gtzr+pNMHpkBibfI8RmLRG4B/+Oo49kbPpk6IV1Em9/vL/12b/w2N+XPkXBevcdkxYp1iOOReCCJPjSUzQpeaWo3CeIT+q9E9pND2QYHZ3jeBACjA10oDKDIFtneGqa5jG+Wd3SizYZu+jWe09bVBfFjrTFjuZXQIGf7cNwgPKw6i8SMMdEi62faEGwhA67jlFdedIWrS5C2ud4qL8HtddAUrDq3VFSt7QJ8Hw5FFQKDxKzd5VPvCh+jEQ4ra1j5VcUGQSzbIpQ1zu1qBLCwg4smu7r0dPQjfgunsQkN8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayLMTrSwPtpQp0+8A1N8sgLwIJjp7ucfl5Xsn2xd5zI=;
 b=BrKI5V7hDFf9WmzZdy2dgWvXAbdaTN1cGnhTwDNLdW9zPYhD4yGnMyZoEH1Xc3BtRs4ZvCDez6KbOoy7OzEDIbhm4RZcRPalDuFbQdiOSGlg5LlJOO86Tc9wlu0C5hovQSYq4cB39jMdMjtQLFz2XJKlTt+SJ4q8X1j20GthHt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB9069.eurprd04.prod.outlook.com (2603:10a6:150:20::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 09:41:45 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 09:41:44 +0000
Message-ID: <cf0a4c2b-8508-4c00-918c-18df9621c3e1@cherry.de>
Date: Wed, 9 Apr 2025 11:41:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] rockchip: binman: Un-indent the FIT template
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-6-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250329150626.2879942-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0042.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9aba74-bc20-44e5-e830-08dd774abd71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckZwTEJLS05pN0F6eGFUay9KRXBxWk1LSTRRb21YOERmU21tbGJYcFcvK1VZ?=
 =?utf-8?B?bnRBKzloSTAxVjNoM0xVampsYW5WSHprZHBYQVJta2Z2bGlVQ1d5OXJrYXB0?=
 =?utf-8?B?NWMwNWN3b3ljWnJnZzhKeTh1MHlBQlk5aVI3cFBETndETVlWaTNxQ2tDdkRI?=
 =?utf-8?B?VUhadjJ3Z05BaVVYZFFPSm1KNU5Vejh1Y3Q0dFVXU2cwb0o5cFgxYmpKclhw?=
 =?utf-8?B?akxta1lrTWF2ZHFod2tsWE1VQmNhSTdDbG9mR3dxV0prOEltdmxZSFFLWkZr?=
 =?utf-8?B?U2ZXVnNyWkZ2WEZPaklEUGQ5WDRLYTF0Wjc3R1M1ejQxSk1OT3VxSCtKVXVO?=
 =?utf-8?B?ZVVtUFh2eS80ek5YeXliLzVBT2dsczQ1OHR5WU8vQjJWZEo4Vm9TK29VTWUy?=
 =?utf-8?B?Y1NTNGV5VENnQmpkVWVyVGlTRGNrYzFQS0YvZXl3QzdKOVZpS09SV2ErbUlm?=
 =?utf-8?B?dkcra0hLNEdqd2ZWYnFjQ25MT0NQZXNHdnJpMEF0bFJyR2NhWjA3TG80QTFr?=
 =?utf-8?B?RXZPSkxGQ1FpMVBlL29uNEV5SG80aGhXWXJsSTEvR0RvMGI1Y1hIYWJSb3d3?=
 =?utf-8?B?VGhTUFJyR0RXeW40Rms3WEsydkMxRnNiRGxtRUVveTdTS2xZaGFaOGRUODdx?=
 =?utf-8?B?aC9tdFpiQUxnUnBjQ3l6UnNOQ05jTGNFWWZYTThXcWxXSUlJWHR3VmJkMkNZ?=
 =?utf-8?B?U2ZUbnozU0lrdWF0Y20vRDZCZE42d3laaVJFSW8vRnlGRmpHcDdGUnMyWXhY?=
 =?utf-8?B?M2VUM05BNG5XRlA1VzJwdWFVWlUxMG5XZEhmcDh3SWR4VmxwMmdIemZiNUlS?=
 =?utf-8?B?RTgvNUUwNmdVU2dzeFdMRVU4aC8ydDErQThpdGhnYnBEQXZHeDAxTjg3ZFRW?=
 =?utf-8?B?Tk9PdkJ3RnFnNXpXNFJIc2xOY1NpVXg2NUlFaTRNb3pSK2d2VFhJUlI5WElS?=
 =?utf-8?B?M0k2MkYvRGdmMjI4YVNmR2lDV1c0SUNSNkRTNTY5LzN5cUVXeklCTlZLNjBC?=
 =?utf-8?B?cU56eFBMcEVZdDFacDZITUZKMWZtYVdCdXhtWWJ5MVZDbG9SUksxMmZBbFV6?=
 =?utf-8?B?L0FKejYxTnZNSUlGZFgrNXNvR01XS2UyWEkxTEZ5NEJ5aWlXaFpGTWY0d2hR?=
 =?utf-8?B?MDA1YVJ6QkZMbTVQM0VYaXkrVjE5RUs4RkpDOWFSRWdWTStoM3FoUENtQnpU?=
 =?utf-8?B?VE1SUXVjb283TnVNZXdKRzl3US9zSzloRnI4R2YzZERET3FGNGtMME9oMXFB?=
 =?utf-8?B?MUd2M2hOL09nc1F6dnN3cW9aUUlMa2Y5bGdHY0ZIMkcxREZKNWtBd1pDeWpO?=
 =?utf-8?B?TlAzWEMwTjU0YmEwMkF0T3dyQnd1UDN1SHlBaGZub2JhZ0RwYTljTzQyQmZI?=
 =?utf-8?B?d2o1UVpWWEVFOFB1K2FMY0RSWjRsWlBmZW0zZlBSN1cza0NyUHU2TndMU041?=
 =?utf-8?B?aHE3ZVl3TUJnM1JTTjcxOXNjK3owMWhHeXVLRjVjb0JOK3d3VzZWcmVzNHBW?=
 =?utf-8?B?UkxUUy9uL2Q3RysxVVRJSjI5U0E3cnZFUmFaV3VYaW11enN0Rm4zR0JWdm9V?=
 =?utf-8?B?RmVXS1YwaFlFendiNkhjWFFRTUpoNUxNUW9HOXY3N3FhRlQzZVQwbW8zakE4?=
 =?utf-8?B?RW0yMkN1OHJ2cThpSG53WUtkZjRJd2JkTlNkUTZvMmdPV1RPNm9zT3JWN2lZ?=
 =?utf-8?B?YnlVVmh2MWxteDJNS2J4K1p5QmxralJtYnAzejZwbEM5VXlyRFFiSm5pM3pF?=
 =?utf-8?B?SXZzOTNSd1VuL1NEc2dYR1hKZS9jRi9IT3Via3hJMm81eWlZQzAwUW9pU05J?=
 =?utf-8?B?ckdJT095emRXb2xjUDF0VWpRcWxCbGhDczF2ZmV2c21DRjd2RmZlNy9JNk1s?=
 =?utf-8?Q?+nMwk+eQFExaG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFFaYTVucEk2QWNHLzhIdk9MTWozb3NsSXQ3Tm1iRnM4R3o1SERrSmFxYk5o?=
 =?utf-8?B?Y0wxR1pOWkRwL2x0eDcrM2U0U0pWQWN3RUVhb213RG85cUFhOWpUN0VmS1hM?=
 =?utf-8?B?SnlsbnJUS0FSQlU2R3czMEdqYTFQQXRWeG1ZRFkzR1RWWnBvTEJKUDJUQnZK?=
 =?utf-8?B?TXdyQURad3Q0NW82MFZreHhEc052U3Y1ZXk3TFloNHhUZTNBNlZzdTBLZkNU?=
 =?utf-8?B?bHFSc0M5QW0zbVVpMEVCaDlUbTJlaG80d2Z3V09yVHJUNVlPcjIwY0x3WWF4?=
 =?utf-8?B?cDFaUEEzY3Zsc1M3WGdJYWVudGk3N0o5cWNzaUQvOWVlV2JYOVkvQ0dzL2d0?=
 =?utf-8?B?R1krTWRKc0l2a2Ivbnpncnl6dDZ0c1JtQzN2bzNYWWNRdDlzZUZEeEc4elJH?=
 =?utf-8?B?QWQ0TzJ6Z2FSNGhVWDFSdTlQeFZ4cXphN052T2owOTBjL3plYWV2clZucDVN?=
 =?utf-8?B?M2FOV3BJNEVnU2pHQmx6UEVTaElqTFNnci90WlRaNHFyTzFJNTBYWGxmend2?=
 =?utf-8?B?a1l1OFpYbUs0a2ltMjhlT1BYWVcwZms3Y2JiYUJwNDJJWG42Umxwd1J5WnAr?=
 =?utf-8?B?cGp0YTVVcFNzNTNUc3FyazFXaUVzeU5sYUlBeGJNV1lXRWVaZnlGcGRTVVJP?=
 =?utf-8?B?ck1FdE9PVXB6cTNnTUhQUUluSkFJVnZzUG14NS9VcTg5b3pDMndwRTRmOEl4?=
 =?utf-8?B?d2hCK29kdVJEa1o1cFFJOEpkeVBCK3hCL0ltdS9hQ3B1amtoM2daWG15S2NK?=
 =?utf-8?B?cTlrNktzd09MSFl3aDZlTXZjWkpiWGp6RlBTc3MxWTFObGFYb1c1REc2c21a?=
 =?utf-8?B?NUtZamtjWm5HTG9pVHJuRE5iNUpDcTBFZEprd1NaejkvUTNJTCs4TFZaLzFK?=
 =?utf-8?B?NkU2R0pCYVh5Q1hKbzNsMDk0M1VCRURqSTk4WVhYOUh2N1hoMW4xdWZuZFZB?=
 =?utf-8?B?SW9jRFlhVGt5aUJLWUZSVm1hdFUxTUNWeHNKcmRVWXpzRDhXQVlKd2h1Qjli?=
 =?utf-8?B?ZWpVK20yUHExZGs2bVJqRHp1ZEFySFZOSitJTzVoR3FaRGJSRkNPOGRNbzBx?=
 =?utf-8?B?azhrUkxycmhTSVducEdoQk5KNk9qUWhPdjV1RklQazFLSFVib2pEeERFeitJ?=
 =?utf-8?B?NmVIV284c0hwanhCa3huRGdKYlJRamxXbklpTmNUQUsvYjRDTWZGMU9PRTZZ?=
 =?utf-8?B?a29LYW1SOUc2QlFXVmRoU3l4RnBrblBZZkVESGVMU294aFBaYUd1eVpyQWxW?=
 =?utf-8?B?SXJTVmVxNUVMY01uMHV3UGtCWnhVMFdKZUd5TzluTUJ1elpUMXNBdGlzZ0s0?=
 =?utf-8?B?UHp5QlJ1QVdQaGc4NVdsRWEzUTVHQXVOV21DZTdVZ2VQaEZHY2lxV2ZqQTdF?=
 =?utf-8?B?eGFrM09qMDdqVkJxeFZpWWcvd1NOTFU5cHEyazU3bm9UL1d2cS9KWHgzR1Vt?=
 =?utf-8?B?UThDOS9XSGZ2TFBJODU3TE9WSVpSbzVWTXFrdkZwbnZ1UlM2VEpZdkZRMDNP?=
 =?utf-8?B?bXd3ZGhQZkVldkxVOTYzN3Q0UlpXbmhWTEx0OTZoV2NPUEs0VTU1MmRDU05R?=
 =?utf-8?B?MTJJQVg1anhGRTl1cFRlZUUwZ3d5VHNPOXVNS3N4dHFTb2s4OGtVamdqd3Fo?=
 =?utf-8?B?UXBzbGNmYVczdElVZHFZUjV0elFpYkRBUTBvMzdRNnJ3WFJBdFMwZmY0T1pT?=
 =?utf-8?B?ZnVhNStqWmNvUWQwVzQ4ZmV5UEkvQ3pmWXk4eWpnWGlBWUtkSnZldTVWaTJa?=
 =?utf-8?B?ZzMzRGJkbWc1ZVhOSGsrZ0UvUjNMM0pUSEU5dHNBZkRKNVAwU0dmTGtCWVpJ?=
 =?utf-8?B?RGZ4WjdkSit4UFY4V3kzYmN2ZlMrM24wUjU1YnE3UTd2dVpDa3BKYWdzWGRO?=
 =?utf-8?B?UnJoQkU1VkRjZmFpNC9UNGlWcURjeDNrQmtQRTltODQzWmJCN1ZnYUVRM2hn?=
 =?utf-8?B?WWlSZzdhQW5OSWQvYXF2d3pVc1hZcGE1NS9PdUVqYnRUVGhLdjhxTzd3cUY3?=
 =?utf-8?B?Z1lSblhXdzBjU1QzU2l6WlNuNGgwSDZaWlpuNnY1WXc1OTlmZDJFMEkrWlBz?=
 =?utf-8?B?SU1TbXMwSzQxSmxoL3o1YU5xRGRNYzB0eFR4TDVEK21VanNhc3lxYzlOZlZI?=
 =?utf-8?B?OTFCeU84N2Y5d3VqSXdGQVR2S2QwNTZmenAybG14ZWdhdTMwd09tT21aWG8y?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9aba74-bc20-44e5-e830-08dd774abd71
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 09:41:44.9320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbrqYaRVz0gUIDcDtDTedeaLD2VijTMFvjESkiYn+lRO/LsiUi4/ORD14QTIPs0WXVE13329m+N6fh+Mq33Ci8kjGgaOHDug12OWPVhcfHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9069
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

Hi Jonas, Simon,

On 3/29/25 4:06 PM, Jonas Karlman wrote:
> From: Simon Glass <sjg@chromium.org>
> 
> Fix the indentation on the template. This is done in a separate patch
> so that it is easier to review.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
