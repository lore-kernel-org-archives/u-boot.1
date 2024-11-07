Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACA8D5D67D
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 17:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 746BE89259;
	Thu,  7 Nov 2024 18:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UiPHOmsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA37D8926A; Thu,  7 Nov 2024 18:53:31 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5267E89072
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 18:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KI6V8M1TVKmj9ybglmhM7SrG++OaU+mQ3yE+7inAri5DQmxa0UDFc3jRwLLKTULVD0+8pT/JrzZVYI3EIn22eIlxBCYuTltX72hZ/sYMeY5eyHnOc5Su/KB70+zmNaft4dMKSAhD2Ns98HKRSFv3QOY2el/ejy+lm0KTTIO4MhKn6/18CXYZot9CYiCdujoOpsxkmKtOHREQb2alqeF4CbbopD8TQVwPokF2v1JpxzK0sdIzn9VNLcNrVPqE4noAYCzUQDrUVXXLLORiT/lTOUJej5DoSexU/zxmzqTK5ktL92ii4Dlgs3nlecG/c0BYEsjUOloB9k/7wEJK+ef5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjO13GUKApNSCIf/pNMh6F7xEOGdUcTjA3qjy4Bk2dY=;
 b=faXW3VVXJGmlr+mIdqoUTfYkimYXHjET73AY0W+0EKCmjDXw2de67IzOypKSs7jfvW5GuzqVIzO8RYBZKJmDq4J8Y59b6aBNGueI96AmKiE3Lw+NIqUPwjL2ELEKbzFCea2qq743PiL7rQghfIaMNc969fNddX1OhPk07Pym/gZXJ8jvog34fFDi4zcJUSKQTLwvhZZ1FddmkqwI20MGZrzuOu898QzNG+nJwLXVAv8KtHc3VngN+Jo9SFAbKsWkDQnLP+f7qb3NzGOIy9h8Jve51VGI/Vi2HfWq09+Ucp7kfooeZChUFYItLvHa5n6KkEDipdbKu4tvI7KTW81e4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjO13GUKApNSCIf/pNMh6F7xEOGdUcTjA3qjy4Bk2dY=;
 b=UiPHOmsGCB96ZEkYr4mFYWz8KSK0DyHr7zErT/t9D1bbihXQVOdurhmNZ2X7CbC+leBHjmLk6Gy9L5TQAbGr+n4u7EF7dpDxFcdsXxY2n1CR2QnhGslEOKyY+S1QD0mz5ADQdMD1+AnXXYWJFp1zChBmuAcwadVCOwwPAU+CIJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7855.eurprd04.prod.outlook.com (2603:10a6:102:ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 17:53:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 17:53:26 +0000
Message-ID: <fcd78623-0706-4324-85be-16ce56a8e446@cherry.de>
Date: Thu, 7 Nov 2024 18:53:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: rk3588: Implement checkboard() to print
 SoC variant
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20241102203746.3631481-1-jonas@kwiboo.se>
 <20241102203746.3631481-3-jonas@kwiboo.se>
 <f4f66f6c-3b96-4529-a90c-cd3a0b900a56@cherry.de>
 <cef9b291-5c27-454c-a24a-565d4510add5@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <cef9b291-5c27-454c-a24a-565d4510add5@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: c0bbf520-d048-4726-0373-08dcff551441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2MzeWErM1RsczJGaXBkcDhTMWJiUFh1NmlRVEZWLzl6MDdoZk5uTHlHOFV0?=
 =?utf-8?B?dGtMQ0NaUUZRTno2UzkxTkc2MFR5NC9ZQ29iek5URlF4UWRVVktHU01pZy9K?=
 =?utf-8?B?NlE0ZFpWZHlEbDdEZ0dOMTdIUU1ITGFhR3pmUEtESldCWFNXYXhZejNveldm?=
 =?utf-8?B?L1JUZWtwb0lxZk8xYkl3Syt0VXpvV05yLzNOWEN3enVCeE5RUVBBMEdCL0pO?=
 =?utf-8?B?bWdrQTV2L0hJZTdxdWFSenhuK25FbzFpUlhrUG5JR2tLa2F2NE1vdHVtRVMr?=
 =?utf-8?B?RFk0ZExWM1phMFdmVU9mcWxUbFNLK3lvTDNuZjB2S3Q4NHpsQlNSL2FDQk40?=
 =?utf-8?B?MUw1NVZFVXlvTWxydHZOSVN2L25OTmlieDQ5RVN4K216cDJ2d1FCWjF5M2hI?=
 =?utf-8?B?cGg4ZkN4d3gwYkRiTmthM1BNRCtXZXhQNkQyRXJnSXg4OXYrcDIydXVkVjVZ?=
 =?utf-8?B?MjdzVnFzU3dyaDJxVnA3dUpFK2FIZEYzUWNSTThlbFYxMWlQQlV6ZEU4VFNM?=
 =?utf-8?B?YXp1YTRJeGZBWU85Q0NuLzd6VkdzZ2lZVVFHTkpQb3huZWJ0alZXV0p0dElz?=
 =?utf-8?B?SG9zQWZXOUNsaUduVzQ0cUU5d1lVRTNYd29xejNlUm9uSnpjb0orVFZtUnhy?=
 =?utf-8?B?SkhycUs5bG45VVhSOC9BVU9RWTBYT2tnN0J2dFJxaFNZaFlxbmdldmpqN2l3?=
 =?utf-8?B?NFB5TkRsb3kyaFVZQ2tScnlFendpMHdoRThkdGZmQnF2b0JtVTRJL1RWYUQx?=
 =?utf-8?B?emUvcmpad1pnbWpwUXg1QkdYQ04rZ3NNSmI4dTVtNG90NjRMMXpaeEEwQnVx?=
 =?utf-8?B?WERIZ1VteVZ0ZGFpN2JaT1dBbW9BNjBmMU1GczgyNUp4dHlnM1RlL2Nocm5Z?=
 =?utf-8?B?YlQ1QTNuQlBaODRGVzV3eXhYNTUyUTlocmtpRUVTMVFLenpmRlcxZEZSYXpL?=
 =?utf-8?B?TEUydDNWeVlQVzNpaTAzTDlBZ0ZUVEJ4OUZPaGo1ZVpZbWxMVWp5ZlpKZjE2?=
 =?utf-8?B?cG9uaVVQSHVWRzhkWWZMeHl0bHBBb2M3ejFLSmJFQm5wRHVFeWUzNjFSRmsz?=
 =?utf-8?B?MVEwOFBnMTkwQU5jTXZVR0Znem9sUHNXSHBOOUNwcStrZmlVYzJhYWd1elRR?=
 =?utf-8?B?UEZwb1VmWFNJZnJWc0l2bkE4OE51aVhSL0d0R0pQZFNUbWtlUVFxNmtzVENo?=
 =?utf-8?B?ZlB1cEJuakZBdDJZVmU3TzVaRHFnQ0pUd0xYVG1KUjJySDhRY1JlTHErRmhS?=
 =?utf-8?B?RjVBVHFLOXRSdmxNM0kydlNFbGpNcG5HditjUFQxa2MwS0Z6MC9CMmtDMmdG?=
 =?utf-8?B?UTM0S3BUMTl1YWVYZHJxcGxPY2VVYmNKU2hPb2tuZG93ZzRCclNBK0tLL3pk?=
 =?utf-8?B?RmFjTUg3ckR4TWpkYURrWU83ZWQ5L1BBNUYzWFZqRnRnek9UQnR2SEhIbjBr?=
 =?utf-8?B?emI5c3BwTmo2aFJPRWUrRlFaSzNkNlZxSG56SG5aVFlNWjd1alVlNlJBUld6?=
 =?utf-8?B?WnBaMXRnQWd5YmtxS0pFQmFucDFjaGYyR1kvZ0tQV3ltVUVFK0Y5T0VuVU8r?=
 =?utf-8?B?NlZaOHNTcWRSSUdSOERaYUNhbW9lQ2NBVGt5S0dja3FuYlZJTkwvZnVFNzkw?=
 =?utf-8?B?bkVyd0JHem1YQXJ0ZXc0STBwejF5RjhCcjRWdDA3T2ZLeDJFM0JtaHEzWkg5?=
 =?utf-8?Q?YxOMCH5FSWCKpPqxHsu9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXBzaUtMMGI3NlJ5bHVITDN3RWlBRUZXNlFRenVRMi9SeFJmaXBTb21uakJ5?=
 =?utf-8?B?eVR1ZXordnRSUmxDYUhkWmJTdkp2eTlMM3daQkIyZmc2bXFldCtudVhTODRW?=
 =?utf-8?B?TU4zQzBvMnZDNXlDSGZvcnVwa1haSUE2MXZQMERCMkFncDJQRnRhTGFaQWZL?=
 =?utf-8?B?N2gzWGc0NjRSeVkreXdpcUY4L3U2UStyVmhEcm03OC9senlJWjBQNTVaSUJ2?=
 =?utf-8?B?UzNPbVBiYUdzSTRrU0dGOFltMVptMW90Wml6RTc1ait4MURuK3ZaaG5nYnVu?=
 =?utf-8?B?MHBPc1d3NzlhYTdZbW1EZ2lkNk1odCt2ZE8wS0RqY1RudUN3UEZWbG9ibEFD?=
 =?utf-8?B?cDZmbzFrY1dsTHhpVEdLK09tRU9hVWVBQ2kxRkNNaU1MK1orMy9VZkZjNlRZ?=
 =?utf-8?B?OE55LzI3cGRBVVViUFEwWGJuZWgzSXV6TDVaQVlBV3E1NGtWNGtZczQwN1VP?=
 =?utf-8?B?T3pPSXMyZ3cvaitsUzgxdVgweFFYNG11TnBYK3BjbUpNVkxpRzhrTzdIS2pL?=
 =?utf-8?B?ZU1YTWR6ZlF1ZDhxQnhXNnVRNEIwbVM3RDFYbGQ1THYrUkRhOUxDL3VEYk5z?=
 =?utf-8?B?aXBIekRHcVYvb2hHajZKaFhvOWEybmVabTMweG9HRno3MTIzbUV4VXJ1VTYw?=
 =?utf-8?B?KzRNZUt1cXhyZFA0S1F0N0x3clVlOC9YTkt0eDlEcTV3WWJSSUJLSmdNWitQ?=
 =?utf-8?B?NDFERjRQN0JRL1p0UnN4cU9jS0ZyUmhSTDFtSXdvSjNhTkF1eXhYUGVCMjZa?=
 =?utf-8?B?KzRmY0lYRDNhUGhhWW9RcHRCdzZVWGNQdlg4SmFlUDN3K3lmRDZmYmFObUxu?=
 =?utf-8?B?U0o3ZDNFd0FRZENubm5NdWNkNTR0a0VJSE1INVFvTGZvR3lDN1lNR3ozdUp6?=
 =?utf-8?B?aU5WRG5PbklzeVlKWDdUMXJRUForZ0xTaERIRVoyUXo4cmJYb3ZrYXlTNFRP?=
 =?utf-8?B?a3hwODgzLzFXUWRiZ0Y4bkhuWGdVOG11czZKVW5oNmUraE8vWk5qM0VWNy8r?=
 =?utf-8?B?WS8yZVpIaGpiVVhzK2VDc1BIdEJoeUVMNUJ5MHpQQjNaY2tObWdJMFBkVzdx?=
 =?utf-8?B?Um1LVmROQlZDRFB0SGpXSzNzVy9jWG54b284Z0x1K0RteklRR3RFRmhLNUZN?=
 =?utf-8?B?ZE5HdXFRR25vMnRzZm4rYVVsUzJabDRVT2F3ODBYUUk3VVN6Y3Q5T0FKNHE3?=
 =?utf-8?B?a1lQYUJGM1FTSTlvQXp2WWcxY0NhQm9wbVprNDhGakk2ekQwWTRjSHB1QWky?=
 =?utf-8?B?ZmY5NUlUdVd5VmNRdjlRd2ZvcFErSlpFKzBYNFg5VjZWTDlWeVRWVnhuaXlx?=
 =?utf-8?B?QkFpNmVENWVkcWVaZTM5d212ZDRXL2t4MFVZa3BpZm5wY3RmUnpPQlNwbmhI?=
 =?utf-8?B?K0lHeFg5WmxRM0xleWxQSE9TcXNyYitvanJjeElNRlhTc1lNWWlIT0ZDU0l4?=
 =?utf-8?B?L1VrZHp2TU1ZWk9FMS8yd1llbmd1S1B3MmV6azRoN2hGTzJ0VWpUZlVZUjRW?=
 =?utf-8?B?WEh6dTAyZWh6ejRML2xHSFMyYkZOdjlkUDdITjQ1a0pLZnhLdE9vOVBBbm1N?=
 =?utf-8?B?TVF3ZlpseDRJcjBrZVBnRXNLY2RUVEpkOTZPeXdiVTR1T0RSdnhwSmhKUGpZ?=
 =?utf-8?B?MVZLYlBldVJYdTlELzBSRWFWL2thT2o0b1FJa0pSOStBcTFnWTNOSlBJcFpC?=
 =?utf-8?B?b3F6WUV2WEd6Vys2NGFLbnA4WjFMMndSMjVNR1ZQWkFYVzN1aUdleUMvZCtm?=
 =?utf-8?B?OHBoaHkrRjJ5eG9oTld5S3UyTnE5UjIvSnNBRjdDdlJxcHQ3Nm5YK29VWmVG?=
 =?utf-8?B?QXFjM2c3MmQ3WnU2NjZzWkhlRGhnZVdGY1cxMEtBR25sajdGRnVYeGQ0WmVq?=
 =?utf-8?B?bnlCMUQrUUV4dUxma05NWkZYWVdYOVdEZTNCTzNTeFVJL0E2UEJFNmpUUk9o?=
 =?utf-8?B?OVA5RG9va01DWlMrWjI5VVY0T2lzS3VPbXVDYm1BUnBuc3pjbDRFK3FaYVZ1?=
 =?utf-8?B?cjUyakNjWTRuM1k0V0Q0Wkh5cWtBOUFIUFd6VVZpbS9aMDlKbXNSOVpHcXB2?=
 =?utf-8?B?clFyVGZjS1NVV1Q1MUE3ajB2WitGMjZzSklBUG9TNWx0RFNoK0NnRFNwelQz?=
 =?utf-8?B?UTZVMy9aZGU0YlRrY0k2bUZkOGxQVUlmOXRrUnY1cFhvdENMdDk4UUthM2x3?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bbf520-d048-4726-0373-08dcff551441
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 17:53:25.9440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbWNVVjiqULftuC3Gn/uN2YPgd2V9ALkL77bB6qVgNKjBP/hyGE2/sMp8CcAEmo1ENgbSvD2QAuqbhKuk4TFqcW8y+eJUrSLIrZEdg6tp7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7855
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

On 11/7/24 3:29 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-11-07 13:01, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 11/2/24 9:37 PM, Jonas Karlman wrote:
>>> Implement checkboard() to print current SoC model used by a board,
>>> e.g. one of:
>>>
>>>     SoC:   RK3582 v1
>>>     SoC:   RK3588 v0
>>>     SoC:   RK3588 v1
>>>     SoC:   RK3588S v0
>>>     SoC:   RK3588S v1
>>>     SoC:   RK3588S2 v1
>>>
>>> when U-Boot proper is running.
>>>
>>>     U-Boot 2025.01-rc1 (Nov 02 2024 - 20:19:01 +0000)
>>>
>>>     Model: Generic RK3588S/RK3588
>>>     SoC:   RK3588S2 v1
>>>     DRAM:  8 GiB
>>>
>>> Information about the SoC model, variant and version is read from OTP.
>>>
>>> Also update rk3588s-u-boot.dtsi to include OTP in U-Boot pre-reloc phase,
>>> where checkboard() is called.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> v2:
>>> - Update commit message
>>> - Update code comments
>>> - Drop generic-rk3588_defconfig change
>>> ---
>>>    arch/arm/dts/rk3588s-u-boot.dtsi       |  4 ++
>>>    arch/arm/mach-rockchip/rk3588/rk3588.c | 58 ++++++++++++++++++++++++++
>>>    2 files changed, 62 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
>>> index 09d8b311cec5..8880d162b11c 100644
>>> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
>>> @@ -69,6 +69,10 @@
>>>    	bootph-all;
>>>    };
>>>    
>>> +&otp {
>>> +	bootph-some-ram;
>>> +};
>>> +
>>>    &pcfg_pull_down {
>>>    	bootph-all;
>>>    };
>>> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
>>> index e2dac2a5b806..f9da7a6f1477 100644
>>> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
>>> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
>>> @@ -4,6 +4,8 @@
>>>     * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
>>>     */
>>>    
>>> +#include <dm.h>
>>> +#include <misc.h>
>>>    #include <spl.h>
>>>    #include <asm/armv8/mmu.h>
>>>    #include <asm/arch-rockchip/bootrom.h>
>>> @@ -178,3 +180,59 @@ int arch_cpu_init(void)
>>>    	return 0;
>>>    }
>>>    #endif
>>> +
>>> +#define RK3588_OTP_CPU_CODE_OFFSET		0x02
>>> +#define RK3588_OTP_SPECIFICATION_OFFSET		0x06
>>> +#define RK3588_OTP_CPU_VERSION_OFFSET		0x1c
>>> +
>>> +int checkboard(void)
>>> +{
>>> +	u8 cpu_code[2], specification, package, cpu_version;
>>> +	struct udevice *dev;
>>> +	char suffix[3];
>>> +	int ret;
>>> +
>>> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
>>> +					  DM_DRIVER_GET(rockchip_otp), &dev);
>>> +	if (ret) {
>>> +		debug("%s: could not find otp device, ret=%d\n", __func__, ret);
>>
>> We should probably start using log_debug instead?
> 
> I guess we should?, not sure why there is two different and what the
> difference is. Have typically only ever used debug() or printf(), so I
> just went with what was used in the code copied from board.c.
> 

But I think that doing this also build the assert() in?

>>
>> I guess with #define LOG_CATEGORY LOGC_ARCH
>>
>> at the top?
> 
> I can give it a try, what/how is the log category used for?
> 
> My simple debug workflow is just to add a '#define LOG_DEBUG' at top of
> a file when I want some more debug info.
> 

This defines DEBUG which then defines _DEBUG to 1 which enables assert().

Not sure how to selectively increase the log level for a specific 
drivers/class though but the docs[1] say #define LOG_DEBUG. And if I 
trust my ability to read C, it'll end up also enabling assert()s...

I think those should not be enabled with the same constant but that's 
where we stand today.

[1] 
https://docs.u-boot.org/en/latest/develop/logging.html#temporary-logging-within-a-single-file

Cheers,
Quentin
