Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B72AC3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 13:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F086682076;
	Tue,  6 May 2025 15:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CYN/Rqsx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B7E820F6; Tue,  6 May 2025 15:34:33 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20721.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::721])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0372E8056A
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 15:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZnfl1cB7jfWCdVYhaUD8DwMDycnmlBDoFM9Myw58ZfR7jScz5XHp6uijwdQArD//IZWzQtufb9iNIhUjmkx1UQBWW6pKFnJcLlQRYYLImHmb/89gVEzIkEffCPTVgbMOO5/twZy9PANkZqkTpYGcNgXuWo1QTmHRDUwj2YVLMkU9wPv0XMFMyEwEAFEYvi9VqYP53v2H02lo40L7ce9ih9vX/ZqGIHzAr7WY9FSuAWdLkpOwTmGRZJhG0YDbXlWMQFYzdaAYZ1LVFbBoPFC2yzibhC81esdVRPhgK0a9eMWhGPI4L81iw4mZLLPp3FDhllsDjulS+Zz+K7D+jywDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTmopq22EfFdCPGHmSn64AkQtw/Nki7eV5cFFFCuts8=;
 b=cs6UfQXrXSQDCqz4K0BLD9bW8csCjqKFpdJO0Oca+QaSmuhNU0vfeYO2RR8J70QAgoU4ksWomocG0BZ9BCIWU2TRd7s3jN3+9eBEy0OuCXkGWVoL+c9Em8slgkL+vjSIIDqJ7l14wojTKsW1T7clw6zs4d/rmABmXIvKEpYA0ojRv7Vrx4C/KEDLJAKDUzcs4MYueTYNmgODtsk30cCEMXMH46v+mGuAuc/0lkjIfUe6//mrAZtQaKwozvcMkeVR28WJ0ExSxUp6zZjfG8SxyEuwoF1za8PH5uUuzAY7hqf97tUoZS1SYt4UHmRCSIaBzjm1huLUyO+DsGXHFhjA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTmopq22EfFdCPGHmSn64AkQtw/Nki7eV5cFFFCuts8=;
 b=CYN/RqsxTjK4UXrncuHgTnIwO0j+JTyDwQHrcEF8dLWGTKQOm+V3hgvXbGKDAxGjBS5hYPoLOhiIAqmuFq3bi7ZcYCzQt7/MrW8R/7L8pGCfVltskZlst8uBJGmBOM12c5YmPcNPgJa/xDVkrWTyHoYQYXzl86vGux/uSe55ov9Gy8UKgsOaFAsHEK+6NRsHr51jmL9HHVDMiALeGLz4mHAf041QDNpcSg1+vEYhPRfT823LAR+JIi44ENbqgAM8qHlZnUBTICOjlck1dy1pmTHzGAqQkdi+QCv51Uk4sT1saCPPNQJAKu53lfPWb36F6aFc/V5mLu4TsFe52ejOMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DB9P195MB1610.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:37d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 13:34:28 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 13:34:28 +0000
Message-ID: <75cb65be-8a75-44f0-b467-a5c153651e58@phytec.de>
Date: Tue, 6 May 2025 16:34:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: dts: k3: require mandatory firmware in binman
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>, Apurva Nandan <a-nandan@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de
References: <20250506-non-optional-v2-1-f58b12aab913@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250506-non-optional-v2-1-f58b12aab913@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0131.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::29) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DB9P195MB1610:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b5d967-3b63-463d-eeaa-08dd8ca2b973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ymx6QW05MGlybGlrYjc5OWxkbjU3RGU3ZWhrWW42eVFDYjllTHAvL010anZm?=
 =?utf-8?B?M0lEQkY1NW1uSFpMczlUTDFBSUhkWGNvVi9VRGRDK1BLR0dlRFA3S3Q1TXRu?=
 =?utf-8?B?ZCtpNHJVRnBBY3RDUWRDV1RMY3UvS2F6cWRpYTRBT1RYbkRoVXA2ZVhzY04y?=
 =?utf-8?B?ZG1CVVo4eDhJdE5FY3A4encxbFdqdFZBWmpxNHMzN1hqRkU5TkpNcEdWMWd1?=
 =?utf-8?B?RThCL0JKNzFKeG92cnZPVFU2RHFjaGVxdjNNRksxU2VzUjV1d0s4bjJOUnpD?=
 =?utf-8?B?R3NhWXJOVWVzbnVWcG0ySXpMZlozQktDRW5OeHgzeU9xejlyOVhpSDJabGhw?=
 =?utf-8?B?TWJnMG9obkExQ0wwdER5MExVb24vOER4ckx5UC95RmQ5N1BtT0hxaWEzamRj?=
 =?utf-8?B?ZC96ZHlEelJiWS82MVhQQ0lXNjYzcVlJQTJQdUZJMzJTcU5hMFZDd0t6cUxj?=
 =?utf-8?B?czBPWlZqbVZhME1LTjlCbDM2Vm93ZHUxaFZDdXY1eGtnSkpIWlUxN0txUUFt?=
 =?utf-8?B?TGQvS1RBeTIvRUoxTFd6MnFmSG1VcWo0OWp2ZVJVeGpXUHZhamIxanZJSWVB?=
 =?utf-8?B?UzhEMFhOR0gzbjZUWmtSMVdLTFlaZnE3NkRkcTN4MEVtNEdNMTQyUEdQL29q?=
 =?utf-8?B?RnFRejl3a0RvRXZRSkoyT0dmZTJiWUtxWVBCbzB0d2RNbEJTMlhPWGwvbVRa?=
 =?utf-8?B?MjJQQ0pJVU9OMzVwbGIwYlIwUFZjQzVvdTF5NTRKMW9xN2t5WithdmgrVE5G?=
 =?utf-8?B?dDlPams5VTRHK0NITjY4TFdoa2VlZFczU2dEaStuRmtOZmdnSGZjbjc2S1NT?=
 =?utf-8?B?Y1Yrd21BM2h6alhlMGh4MkxtYWsyMFByMHFCS2RSMStrcHFMOXRld2c1YnpK?=
 =?utf-8?B?dVE5dkt2OGNIWXk2TzRhTWd6NjBzWXVtMjBaT0NTdkFyUXk1dGhrTUlrT1VW?=
 =?utf-8?B?cTBLSXFkUEZlNVFCV0M5amllbjlnTkEwaXh5WXJmRUV3UmxsL1NabmNvVDdx?=
 =?utf-8?B?NTlpNXRBdHhURGh0aHVxRGVlZzdyRkR2T3ZCSVNIREJ5OFVTU25hZzlkTnJT?=
 =?utf-8?B?V2hydWRxYW01bHhHNnlzcElYWi8xd2xqbWp4eDAwSnc2UXdsUXUzdlBKY05z?=
 =?utf-8?B?S1VadDJ3TnE0SUNFTVFSK25oUnJTMDZQTTdZK01wT0crU2hGVlUydjJzd0cw?=
 =?utf-8?B?U0xrTFJiODJ1VlVHa1VZdUJ3R05xT0lsNGpTTGpYR3VCMnMzdWpxdXg0cElr?=
 =?utf-8?B?TEZyYUMvQ2V5MmNkR0U0bjB1N3MyNi9SSjZLMTBtMzR2YlZtZXBxdTE5d0ZH?=
 =?utf-8?B?TU1kK3dYdlZSYTR5Mkh5TjA4aHdPNU1mdnZGcUhBSGs3WGswd3ZmSVE0RndY?=
 =?utf-8?B?N205TXRGUEpwRmZDczFRL3NGYVBLOGY1VFVSOU5HOUo0bXQ5RnI1Vk4xUG5L?=
 =?utf-8?B?Mmo0bk5qNHhqVXdvRUFSTlJ6c3NFaG02MEU5cVFpMGM2MzA2cVV6QzhFWXB1?=
 =?utf-8?B?cUNDYVJ1TW8xUFpvUXdLR2lISHovUXY1cEJ1NXc0cGlWQ0xLS1B2UjJjNjlF?=
 =?utf-8?B?VHBobndjNjdiL1N1VlBaRlVGQnlneFBKSC93QUd3KzhoZmZEN1NpdmZsM3hY?=
 =?utf-8?B?TXhPaTFkWVFlUEZTSlZ0L1NXUkRqZmlpdld1VXdmYTk2Qmt6Q3V0OGlFQ2Vh?=
 =?utf-8?B?aTJwVndqaUV4a2h0K0JHZVEvYTFmbUxocVBvQ05EaUZDVVBrQWgyS2R5RE5B?=
 =?utf-8?B?a0ZTTlRoSlZyWXRiR21RZWVNc3g4d3JISmwyalIvK2pxSEhlcWlQMWNYSzJZ?=
 =?utf-8?B?YVQxQnBnVDNoTHBJZ2VOMTNsb2pPN2c3Rzl4SEdka000WkxyV011RXRJM1JT?=
 =?utf-8?B?NU9LZkhYaFp4Y2RYQzlmM0dQeXhIU1hwTVRBb1hIUmdRMUwxSHBhTmhtZFBM?=
 =?utf-8?Q?9I7wcPv7VV4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWZmMmMzakJQSjZ0VFQxM2gwMC9nQmtrRmgxZHJteDdabS83NlFLWHQ3aVZ4?=
 =?utf-8?B?VFd5WkhTK1JMMHBUYmpYc3d2RHhERHNHZU53VkloU3ZWQWNpQXpjNm9PNGxt?=
 =?utf-8?B?NlJPTVYrSnBEY3JGbDRzdlBVQXd0K09aWlVFc25ZcndaTS9yQTNSOWRKN2NY?=
 =?utf-8?B?S3ZkOXE5dE50eDJ0TnB1UFFQZ3ltMzFkazZXWVE3WjFyeDNZbDg5QXBtQ2Y3?=
 =?utf-8?B?YWZqY09XL3VZb3hJdG82T1RCdzY1MzBqbUdxaEVGcUtQRTU3dzFmQ0pVRG54?=
 =?utf-8?B?OFpENmpWb3BJY2NPRnBabnRaYWVJb2dibFlrbndJcGxiQzM2VWdqM1BhY3J4?=
 =?utf-8?B?anpmNzhlR3dUeDlGZkhpeXJOSmlzNWxHRjJFYlZURFhxT2VNM3ZQLzJHRDIx?=
 =?utf-8?B?eWVLVStOb2ptZWhoV0xIRXNLekxFRmpwa3dUOFdDTk9INkNUWjR6WkowRVdB?=
 =?utf-8?B?Tjl5RVJOMTNZQTBwTjNrSGJIV0ZNZ2RUVnZBNVhIR3A4aXNzYSs2RHV1YXhy?=
 =?utf-8?B?c2l2bEF1cjJqa3NXWENUK3hObUsxclp5T0RjVjJsNDI2bVpYOGRqNUd6N2ds?=
 =?utf-8?B?NkVBWDJ6VFcya2hnMUxSQlZaNVhiWWpjQTFOYWJNQ2FsOGNoODFTZ3JQbm1C?=
 =?utf-8?B?L0ZDZ3JERmtEVjJnaHBIN3BYRnVhUFQ5QWFYM1oxSVBrRnFOam1aejBQWVZs?=
 =?utf-8?B?VVpEcUs2SFpWVndPV2xnSFFNS1hTY1lUSS9wRWZxT3lGTmhJV1F1TDA1NjFP?=
 =?utf-8?B?azFGRXhuNmJhZVZCSHozbWxRMWxlYUdWbTY3VkN6L2FSS1FwbFVKUkhGZEVJ?=
 =?utf-8?B?RzVnUFdoa05uSHFwK3BTTzN6TnUweS9DMURjMFoyYysrM1o3ZjNud2RSTU9x?=
 =?utf-8?B?RVhjWTE2S0Z3UVV1MXo0YVc1eElUTlpFMEVKS28yQmtlR2RyYWtSTHBhb3RC?=
 =?utf-8?B?QlF4YzlXVnMrVlJNTUdwalByaVhlYjliZnpHVkR5amErQzVXOXArWU1hRGRV?=
 =?utf-8?B?VnFjQ2l2L3VuWkxwM05YbS9DOXFaMmEvTDB6a1htM0ZPSEhQSXY0c0JiUEpI?=
 =?utf-8?B?WUxOK0Y3aTZIVitRYysrblBmclJWMzEvL3duaHN5VDB2dE5nNDRabGZMQnky?=
 =?utf-8?B?VWd1bmhJNituekxGRGJtUHZRNUZrclFBV2I4NndVRG1yQnVBZkJRUVlJL1Fq?=
 =?utf-8?B?eEJYMWFOYkNMZk9iSUdWd0hISWZMREs0TDRsaXo3QnBSR0xEdWdQN1pXdk9O?=
 =?utf-8?B?TTJ5Q1VpYldCcFNZYzkyZmVCM29jcmU1TFREaEJQSzdFV01EZ21HQi95dHRu?=
 =?utf-8?B?cFFlcTloU0krVHZBNmZrb0tZRFkvK2Q1WW5kVTI2SVEwcDdhbzVJUHhFVVg1?=
 =?utf-8?B?MkRxc1krRjRPTHlTVGVtWHBmdTUrSGU2N3lGQ1pVMnZHN0VNZEE4b3VXSzgr?=
 =?utf-8?B?VFVOdUkzMys4VDhvYjBWQ3ZCSnRZS0xwdm5XdFZxSDlUYk5DeitEY1lwQW9k?=
 =?utf-8?B?TEJIRTA5THpBL21WeWk2MVJQNzBnR3gyY2poYkwxQjUxeEw1SnQ5Z25Zdnhi?=
 =?utf-8?B?VTFyU0l4K2s1eWRzRytiTkdudWVvdnZEcnk0NjV2U0d5S2JaNjM1T3d3VzVo?=
 =?utf-8?B?Y1hyUUJSamUzQVpEdDVOYnVIYmpXUjNjSEprR0dRV0RTQVNKc1ZFOHRpYVBI?=
 =?utf-8?B?TjJzcWpXbG9aMzJQY1RRWnlaZjlybTlDb21BdEY0Vlg0ZC94MytqNTh0WnVL?=
 =?utf-8?B?RkNkWVA1UnY4L2ttSjFOS3ZweUJ4ME1pMlFPZUI5QTAwRm1yNDBUODFuWktr?=
 =?utf-8?B?ZXZ2T1dsN29abU5wWENkblR3SUdXd25NUTVIOXdxRVhYdjZROTgxMEZlNFB4?=
 =?utf-8?B?RHdHY0tXcVdqWmJSZTJvRlhtSTFubldNbUJad2FHRDY0RjJ6L1U0WVp6Y0dG?=
 =?utf-8?B?ZUxaSmFwVXg4bHNuUVBod3hldzVDQWFxRm9uWDZyUDVEeWRlREo1MW12V3Y2?=
 =?utf-8?B?UWs1N0d2MFlaalFFVlhZMy9lbHhWd2tpWmFCUFQxQ1lvT3VxTnJFdFkwOEdj?=
 =?utf-8?B?aDlTWlpLbVNjTUYyT3p2ZHUyRExudGhYN0xpR1Awc2FRb1daTEtpOTJpbDRp?=
 =?utf-8?Q?MbrcUp070PLmqjfTlNg9w/usB?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b5d967-3b63-463d-eeaa-08dd8ca2b973
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 13:34:28.2435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0H46lMeclWVw+vqkEJU4i4R8w3UiZffn6Mo49+zESDPB8WFhOct9lfOsVSmxstu5RRndRR5fIA8OG7gVWvASw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1610
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

Am 06.05.25 um 16:11 schrieb Bryan Brattlof:
> TI's Foundational Security (TIFS), Device Management (DM) and Device
> Management and Security Control (DMSC) firmware are required for a
> successful boot. Remove the 'optional' flag so binman will emit an error
> if these firmware components are not found
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>

Acked-by: Wadim Egorov <w.egorov@phytec.de>

> ---
> Changes in v2:
> - Rebased on -master
> - Link to v1: https://lore.kernel.org/r/20250429-non-optional-v1-1-b4cad3bc7789@ti.com
> ---
>   arch/arm/dts/k3-am625-phycore-som-binman.dtsi     |  5 -----
>   arch/arm/dts/k3-am625-r5-beagleplay.dts           |  1 -
>   arch/arm/dts/k3-am625-sk-binman.dtsi              |  7 -------
>   arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi |  5 -----
>   arch/arm/dts/k3-am62a-phycore-som-binman.dtsi     |  7 -------
>   arch/arm/dts/k3-am62a-sk-binman.dtsi              |  7 -------
>   arch/arm/dts/k3-am62p-sk-binman.dtsi              |  5 -----
>   arch/arm/dts/k3-am642-phycore-som-binman.dtsi     |  5 -----
>   arch/arm/dts/k3-am64x-binman.dtsi                 |  5 -----
>   arch/arm/dts/k3-am65x-binman.dtsi                 |  3 ---
>   arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi      |  5 -----
>   arch/arm/dts/k3-j7200-binman.dtsi                 | 11 -----------
>   arch/arm/dts/k3-j721e-binman.dtsi                 | 11 -----------
>   arch/arm/dts/k3-j721e-r5-beagleboneai64.dts       |  1 -
>   arch/arm/dts/k3-j721s2-binman.dtsi                |  7 -------
>   arch/arm/dts/k3-j722s-binman.dtsi                 |  5 -----
>   arch/arm/dts/k3-j784s4-binman.dtsi                |  7 -------
>   17 files changed, 97 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> index 9b536d679afa3..32d8804a395f1 100644
> --- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> @@ -36,7 +36,6 @@
>   		ti_fs_enc: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -45,7 +44,6 @@
>   		sysfw_inner_cert: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -82,7 +80,6 @@
>   		ti_fs_enc_fs: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -91,7 +88,6 @@
>   		sysfw_inner_cert_fs: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg_fs: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -125,7 +121,6 @@
>   		ti_fs_gp: ti-fs-gp.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
>   			filename = "combined-tifs-cfg.bin";
> diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
> index 9e0a6ed678448..0ff46a2633039 100644
> --- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
> +++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
> @@ -103,7 +103,6 @@
>   		ti_fs_gp: ti-fs-gp.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
>   			filename = "combined-tifs-cfg.bin";
> diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
> index cc619f5920e2b..6822a5dac896e 100644
> --- a/arch/arm/dts/k3-am625-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
> @@ -34,7 +34,6 @@
>   		ti_fs_enc: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -43,7 +42,6 @@
>   		sysfw_inner_cert: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -80,7 +78,6 @@
>   		ti_fs_enc_fs: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -89,7 +86,6 @@
>   		sysfw_inner_cert_fs: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg_fs: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -123,7 +119,6 @@
>   		ti_fs_gp: ti-fs-gp.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -263,7 +258,6 @@
>   					};
>   					dm: ti-dm {
>   						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -						optional;
>   					};
>   				};
>   
> @@ -391,7 +385,6 @@
>   				dm {
>   					ti-dm {
>   						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -						optional;
>   					};
>   				};
>   
> diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> index 5a8788b227b12..bfbba28269cf3 100644
> --- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> @@ -34,7 +34,6 @@
>   		ti_fs_enc: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -43,7 +42,6 @@
>   		sysfw_inner_cert: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -80,7 +78,6 @@
>   		ti_fs_enc_fs: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -89,7 +86,6 @@
>   		sysfw_inner_cert_fs: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg_fs: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -123,7 +119,6 @@
>   		ti_fs_gp: ti-fs-gp.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
>   			filename = "combined-tifs-cfg.bin";
> diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> index 1871926c20776..fd3401015325c 100644
> --- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
> @@ -41,7 +41,6 @@
>   		ti_fs_enc: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -50,7 +49,6 @@
>   		sysfw_inner_cert: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -87,7 +85,6 @@
>   		ti_fs_enc_fs: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-fs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -96,7 +93,6 @@
>   		sysfw_inner_cert_fs: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-fs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg_fs: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -130,7 +126,6 @@
>   		ti_fs_gp: ti-fs-gp.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62ax-gp.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -269,7 +264,6 @@
>   					};
>   					dm: ti-dm {
>   						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -						optional;
>   					};
>   				};
>   
> @@ -456,7 +450,6 @@
>   				dm {
>   					ti-dm {
>   						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -						optional;
>   					};
>   				};
>   
> diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
> index ed973541ffffc..877a513a24186 100644
> --- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
> @@ -38,7 +38,6 @@
>   		ti_fs_enc: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -47,7 +46,6 @@
>   		sysfw_inner_cert: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -84,7 +82,6 @@
>   		ti_fs_enc_fs: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-fs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -93,7 +90,6 @@
>   		sysfw_inner_cert_fs: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-fs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg_fs: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -127,7 +123,6 @@
>   		ti_fs_gp: ti-fs-gp.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62ax-gp.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -253,7 +248,6 @@
>   					};
>   					dm: ti-dm {
>   						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -						optional;
>   					};
>   				};
>   
> @@ -379,7 +373,6 @@
>   				dm {
>   					ti-dm {
>   						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -						optional;
>   					};
>   				};
>   
> diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
> index 8216add3498b3..d65e5c4d4e1e5 100644
> --- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
> @@ -38,7 +38,6 @@
>   		ti_fs_enc_fs: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62px-hs-fs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
> @@ -49,7 +48,6 @@
>   		sysfw_inner_cert_fs: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-am62px-hs-fs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_dm_cfg_fs: combined-dm-cfg.bin {
> @@ -87,7 +85,6 @@
>   		ti_fs_enc_hs: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-am62px-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_tifs_cfg_hs: combined-tifs-cfg.bin {
> @@ -98,7 +95,6 @@
>   		sysfw_inner_cert_hs: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-am62px-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_dm_cfg_hs: combined-dm-cfg.bin {
> @@ -203,7 +199,6 @@
>   
>   					dm: ti-dm {
>   						filename = "ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -						optional;
>   					};
>   				};
>   
> diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
> index 5228eed19bf58..966905bd64db9 100644
> --- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
> @@ -33,7 +33,6 @@
>   		ti_sci_enc: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_sysfw_cfg: combined-sysfw-cfg.bin {
>   			filename = "combined-sysfw-cfg.bin";
> @@ -42,7 +41,6 @@
>   		sysfw_inner_cert: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   	};
> @@ -73,7 +71,6 @@
>   		ti_sci_enc_fs: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-fs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_sysfw_cfg_fs: combined-sysfw-cfg.bin {
>   			filename = "combined-sysfw-cfg.bin";
> @@ -82,7 +79,6 @@
>   		sysfw_inner_cert_fs: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-fs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   	};
> @@ -109,7 +105,6 @@
>   		ti_sci_gp: ti-sci-gp.bin {
>   			filename = "ti-sysfw/ti-sci-firmware-am64x-gp.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_sysfw_cfg_gp: combined-sysfw-cfg-gp.bin {
>   			filename = "combined-sysfw-cfg.bin";
> diff --git a/arch/arm/dts/k3-am64x-binman.dtsi b/arch/arm/dts/k3-am64x-binman.dtsi
> index f768c4d946d47..32e47a3f68888 100644
> --- a/arch/arm/dts/k3-am64x-binman.dtsi
> +++ b/arch/arm/dts/k3-am64x-binman.dtsi
> @@ -29,7 +29,6 @@
>   		ti_sci_enc: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_sysfw_cfg: combined-sysfw-cfg.bin {
>   			filename = "combined-sysfw-cfg.bin";
> @@ -38,7 +37,6 @@
>   		sysfw_inner_cert: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   	};
> @@ -69,7 +67,6 @@
>   		ti_sci_enc_fs: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-fs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_sysfw_cfg_fs: combined-sysfw-cfg.bin {
>   			filename = "combined-sysfw-cfg.bin";
> @@ -78,7 +75,6 @@
>   		sysfw_inner_cert_fs: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-fs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   	};
> @@ -105,7 +101,6 @@
>   		ti_sci_gp: ti-sci-gp.bin {
>   			filename = "ti-sysfw/ti-sci-firmware-am64x-gp.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_sysfw_cfg_gp: combined-sysfw-cfg-gp.bin {
>   			filename = "combined-sysfw-cfg.bin";
> diff --git a/arch/arm/dts/k3-am65x-binman.dtsi b/arch/arm/dts/k3-am65x-binman.dtsi
> index 350775e42c2ab..cc82c8b576890 100644
> --- a/arch/arm/dts/k3-am65x-binman.dtsi
> +++ b/arch/arm/dts/k3-am65x-binman.dtsi
> @@ -32,12 +32,10 @@
>   		ti_sci_cert: ti-sci-cert.bin {
>   			filename = "ti-sysfw/ti-sci-firmware-am65x_sr2-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		ti-sci-firmware-am65x-hs-enc.bin {
>   			filename = "ti-sysfw/ti-sci-firmware-am65x_sr2-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   	};
>   	itb {
> @@ -73,7 +71,6 @@
>   		ti_sci: ti-sci.bin {
>   			filename = "ti-sysfw/ti-sci-firmware-am65x_sr2-gp.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   	};
>   	itb_gp {
> diff --git a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> index ba05d41035787..2a0023fb7c313 100644
> --- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> @@ -88,7 +88,6 @@
>   		ti_fs_enc: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_tifs_cfg: combined-tifs-cfg.bin {
> @@ -99,7 +98,6 @@
>   		sysfw_inner_cert: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_dm_cfg: combined-dm-cfg.bin {
> @@ -140,7 +138,6 @@
>   		ti_fs_enc_fs: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-fs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
> @@ -151,7 +148,6 @@
>   		sysfw_inner_cert_fs: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-fs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_dm_cfg_fs: combined-dm-cfg.bin {
> @@ -181,7 +177,6 @@
>   
>   					dm: ti-dm {
>   						filename = "ti-dm/j722s/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -						optional;
>   					};
>   				};
>   
> diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
> index 47a4cde6b8544..b74bd1657f932 100644
> --- a/arch/arm/dts/k3-j7200-binman.dtsi
> +++ b/arch/arm/dts/k3-j7200-binman.dtsi
> @@ -35,7 +35,6 @@
>   		ti_fs_enc_sr1: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j7200-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_sr1: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -44,7 +43,6 @@
>   		sysfw_inner_cert_sr1: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-j7200-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg_sr1: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -80,7 +78,6 @@
>   		ti_fs_enc: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j7200_sr2-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -89,7 +86,6 @@
>   		sysfw_inner_cert: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-j7200_sr2-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -127,7 +123,6 @@
>   		ti_fs_enc_fs_sr1: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j7200-hs-fs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_fs_sr1: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -136,7 +131,6 @@
>   		sysfw_inner_cert_fs_sr1: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-j7200-hs-fs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg_fs_sr1: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -172,7 +166,6 @@
>   		ti_fs_enc_fs: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j7200_sr2-hs-fs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -181,7 +174,6 @@
>   		sysfw_inner_cert_fs: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-j7200_sr2-hs-fs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg_fs: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -216,7 +208,6 @@
>   		ti_fs_gp: ti-fs-gp.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j7200-gp.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -339,7 +330,6 @@
>   					};
>   					dm: ti-dm {
>   						filename = "ti-dm/j7200/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -						optional;
>   					};
>   				};
>   
> @@ -425,7 +415,6 @@
>   				dm {
>   					ti-dm {
>   						filename = "ti-dm/j7200/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -						optional;
>   					};
>   				};
>   
> diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
> index 6adfab164ee2f..9522a95650622 100644
> --- a/arch/arm/dts/k3-j721e-binman.dtsi
> +++ b/arch/arm/dts/k3-j721e-binman.dtsi
> @@ -46,12 +46,10 @@
>   		ti_fs_cert: ti-fs-cert.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j721e_sr1_1-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		ti-fs-firmware-j721e_sr1_1-hs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j721e_sr1_1-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   	};
>   
> @@ -67,12 +65,10 @@
>   		ti_fs_cert_sr2: ti-fs-cert.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j721e_sr2-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		ti-fs-firmware-j721e_sr2-hs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j721e_sr2-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   	};
>   
> @@ -148,12 +144,10 @@
>   		ti-fs-cert-fs.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j721e_sr1_1-hs-fs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		ti-fs-firmware-j721e-hs-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j721e_sr1_1-hs-fs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   	};
>   	itb_fs_sr1_1 {
> @@ -235,12 +229,10 @@
>   		ti-fs-cert-fs.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j721e_sr2-hs-fs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		ti-fs-firmware-j721e-hs-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j721e_sr2-hs-fs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   	};
>   	itb_fs {
> @@ -276,7 +268,6 @@
>   		ti_fs: ti-fs.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j721e-gp.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   	};
>   	itb_gp {
> @@ -461,7 +452,6 @@
>   					};
>   					dm: ti-dm {
>   						filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -						optional;
>   					};
>   				};
>   
> @@ -546,7 +536,6 @@
>   				dm {
>   					ti-dm {
>   						filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -						optional;
>   					};
>   				};
>   
> diff --git a/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts b/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
> index 586ddb6e7c8f1..5f0dfe9c2fa22 100644
> --- a/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
> +++ b/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
> @@ -47,7 +47,6 @@
>   		ti_fs: ti-fs.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j721e-gp.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   	};
>   
> diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
> index 73af184d27ed4..4f524e58ceba0 100644
> --- a/arch/arm/dts/k3-j721s2-binman.dtsi
> +++ b/arch/arm/dts/k3-j721s2-binman.dtsi
> @@ -34,7 +34,6 @@
>   		ti_fs_enc: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j721s2-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -43,7 +42,6 @@
>   		sysfw_inner_cert: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-j721s2-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -79,7 +77,6 @@
>   		ti_fs_enc_fs: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j721s2-hs-fs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -88,7 +85,6 @@
>   		sysfw_inner_cert_fs: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-j721s2-hs-fs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_dm_cfg_fs: combined-dm-cfg.bin {
>   			filename = "combined-dm-cfg.bin";
> @@ -123,7 +119,6 @@
>   		ti_fs_gp: ti-fs-gp.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j721s2-gp.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
>   			filename = "combined-tifs-cfg.bin";
> @@ -280,7 +275,6 @@
>   					};
>   					dm: ti-dm {
>   						filename = "ti-dm/j721s2/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -						optional;
>   					};
>   				};
>   
> @@ -366,7 +360,6 @@
>   				dm {
>   					ti-dm {
>   						filename = "ti-dm/j721s2/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -						optional;
>   					};
>   				};
>   
> diff --git a/arch/arm/dts/k3-j722s-binman.dtsi b/arch/arm/dts/k3-j722s-binman.dtsi
> index 8f1471371e5bf..57e966ea66644 100644
> --- a/arch/arm/dts/k3-j722s-binman.dtsi
> +++ b/arch/arm/dts/k3-j722s-binman.dtsi
> @@ -36,7 +36,6 @@
>   		ti_fs_enc: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_tifs_cfg: combined-tifs-cfg.bin {
> @@ -47,7 +46,6 @@
>   		sysfw_inner_cert: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_dm_cfg: combined-dm-cfg.bin {
> @@ -88,7 +86,6 @@
>   		ti_fs_enc_fs: ti-fs-enc.bin {
>   			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-fs-enc.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
> @@ -99,7 +96,6 @@
>   		sysfw_inner_cert_fs: sysfw-inner-cert {
>   			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-fs-cert.bin";
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_dm_cfg_fs: combined-dm-cfg.bin {
> @@ -129,7 +125,6 @@
>   
>   					dm: ti-dm {
>   						filename = "ti-dm/j722s/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> -						optional;
>   					};
>   				};
>   
> diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
> index cb1fbc6592355..a7ce1ee2b0317 100644
> --- a/arch/arm/dts/k3-j784s4-binman.dtsi
> +++ b/arch/arm/dts/k3-j784s4-binman.dtsi
> @@ -39,7 +39,6 @@
>   
>   		ti_fs_enc: ti-fs-enc.bin {
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_tifs_cfg: combined-tifs-cfg.bin {
> @@ -49,7 +48,6 @@
>   
>   		sysfw_inner_cert: sysfw-inner-cert {
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_dm_cfg: combined-dm-cfg.bin {
> @@ -88,7 +86,6 @@
>   
>   		ti_fs_enc_fs: ti-fs-enc.bin {
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
> @@ -98,7 +95,6 @@
>   
>   		sysfw_inner_cert_fs: sysfw-inner-cert {
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_dm_cfg_fs: combined-dm-cfg.bin {
> @@ -135,7 +131,6 @@
>   
>   		ti_fs_gp: ti-fs-gp.bin {
>   			type = "blob-ext";
> -			optional;
>   		};
>   
>   		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
> @@ -166,7 +161,6 @@
>   					};
>   
>   					dm: ti-dm {
> -						optional;
>   					};
>   				};
>   
> @@ -255,7 +249,6 @@
>   			images {
>   				dm {
>   					ti-dm {
> -						optional;
>   					};
>   				};
>   
> 
> ---
> base-commit: 4d3b5c679bc9d5c6cbbeedcc1e4a186f1cc35541
> change-id: 20250429-non-optional-7dbf2bbdb15f
> 
> Best regards,

