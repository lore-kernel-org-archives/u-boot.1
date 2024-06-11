Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38BAC27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 16:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F3FA8840E;
	Tue, 11 Jun 2024 18:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IjmV+noZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B63A5886B1; Tue, 11 Jun 2024 18:29:41 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2600::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C22088262
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 18:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAI4PkT+VN8O81WuYEnRiBAL3zdo9t1Z3VaBZr+bCf4JLvYRM5qTrVb1iwYGw9NnqwyDWE7KXz1pSVmR4iKV/osM5xEoW9WXjN/WKgPHljKdGQjU/L7AVy1oSL4WIb+qo0DhE4QiAS7v1Ui5akM7LTb3WlMsGseDDysLSdRrTbIkcWZHvttqtYhPFLSMtgvHlrbvLeIqSgTHjazOPdUffrQNhF2gVKf/gO8CGz9iM0XE5LOF68o3IVv70y8kV+XQnZl/rBkHazLcOC1kEu3K9YrAw28tisCw242/AcfZtLbwpirGF1YEa1irdKExBL/KhQOFgqd3lcJa6T41PW2F1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxhYnDKZtMhbqgqVZVlAC2HuVT/1qZymHS9vHJPPTnA=;
 b=UPzKc8QmRoXKbRdnOcmgGiWOEdoqSCkkMtiwQdR7bnb2Naaw8Ew/vLW42D3WsiwEqCX3lO8zeZpcENm2Nzso8SBhZCWz224mcCXtJXNgD+b4LHUbLGgcwobtTlWrfrncIDdMBKveEQIlqBd+xPL2RgYNjc/qWXyqH6Kc7R5/bkJ/Y7VAJJdOS7VZSznefK7aVs+wJbr9a4a5/gVysFeA840U1Af0eTpPKAIIxBbLbh433K/lPweBD8ZdjmbS9/IM4BbKaa8kDrl6M+0+oHxCSGUv9j8h72CGHmNg/41YLjTmpgGxjKaQm9Yx7grnznqNLeHAo5Zo1fBScznKM1V53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxhYnDKZtMhbqgqVZVlAC2HuVT/1qZymHS9vHJPPTnA=;
 b=IjmV+noZx5TjW1of4zpTUNEAZixiCBQL32tb//rVrT6JN7+PFTb5Z3NXH8srrbRhZl2TG/GO+dpF8KTF11tPx6a/tccGd0JY5w11ZfVGI6aLoyp12O1kag5R0VDD0RNvCYo3fEP6xf+hjDAjLh4IQPfod1YJiRSEeNbjLGXGVTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB8PR04MB7146.eurprd04.prod.outlook.com (2603:10a6:10:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:29:37 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 16:29:36 +0000
Message-ID: <da9577ae-845b-4d86-b1bf-f406e71cd314@cherry.de>
Date: Tue, 11 Jun 2024 18:29:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drivers: bootcount: Add support for FAT filesystem
To: Vasileios Amoiridis <vassilisamir@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: hs@denx.de, pro@denx.de, vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
References: <20240610185116.353604-1-vassilisamir@gmail.com>
 <20240610185116.353604-2-vassilisamir@gmail.com>
 <34fcbe3d-f361-4671-8d27-e02f9a5dce9c@cherry.de>
 <20240611152733.GA441859@vamoiridPC>
 <374a3eee-e24c-4acd-abc3-f69f628a285a@cherry.de>
 <20240611160659.GH68077@bill-the-cat> <20240611162059.GC441859@vamoiridPC>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240611162059.GC441859@vamoiridPC>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::7) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB8PR04MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: affe4dea-06cd-4415-093d-08dc8a33af35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3AvaVMreXoxNXpsYUROeXMrS3RuUnlaZVVkZnhiVTloRHVDVnhqa2hWbVAr?=
 =?utf-8?B?M20zWDJOZ3BrMXkwRTcvQ1htZm1IODJMRHprQjlXQWpQVGtXNVVyRDh0VTY0?=
 =?utf-8?B?bU9kd3NjVWtaWTE5MDY0UEtabUQvSEIrWWNQWWZMQkc5VFFuZWlkRjBLSGx4?=
 =?utf-8?B?VWdHRWJyemdXNFB1MGhQNDYxSVNodEF2OUhLeEMvUXR3ZDFxUlBGYVVBSCt0?=
 =?utf-8?B?SXlRemJzZU5xV1dJRGlQOW1oUmhhUGZ1d1hicXkrcm81aFMwRG45aDJyZkhZ?=
 =?utf-8?B?NFdNNkczQnVhRkZTYVlZaHJ1OGxCbGxoU2dKRklOaVI3UE9LSGt6dHc4dmlG?=
 =?utf-8?B?ZzBsSUJMeTBGQTRFR09DU3g1dy9FZ2N1cVJla2lhbUUyT0VvU05OQ25OSEpJ?=
 =?utf-8?B?YnY2THc1alNlYjR4OUIyRCtzaG9BYXFWVnhKeC9lR3puWWRmNHpQZ2VoRDds?=
 =?utf-8?B?ZlFSbStWVlI1bkJGd0VHWUY4ai9xSTd5Tmw1MW9rM2FlK1FGWXR3MHBySFIy?=
 =?utf-8?B?cGlBRVY2c0diN0lLK1pkOFBtYWpUYlkwcFAzQ3JTdUJOdHRRUkRSaTFOaU5l?=
 =?utf-8?B?MFJZVmJyTzVlK0UwT0RBanFDUndBWHdvMHhnSnJRY1NYbzB4OTF1OUs4UWdV?=
 =?utf-8?B?N2F4LzQrZGdQYjBZWnVSSllKRHcveTNROUc4VDcycWhOVVp6ckVJUHd1ODNT?=
 =?utf-8?B?Y0FIMVorT0VCd1JHajJKNUtYMkhMNWU4cytRVGMrZEZzWStxVFY2ZmNlSXUr?=
 =?utf-8?B?b2xLOTN3OEZYazRkeE9uSUZnbytIdm5vaUY1M0NTLzRMZ2tJZzU4NjY2ZW4x?=
 =?utf-8?B?Zmp2N0xBYys1WkVsdUVvcW5WaE5YMHBmVE8rcEl0ZjdZbHlQLzRKSUtSSks5?=
 =?utf-8?B?d2tyczJRUE54S1JzS2FPdGRnWlZWbjdZbUxYMXZoNUxmWlBIeWt0bzVrNFFT?=
 =?utf-8?B?UG4zeUZweUhONlVOZVI0SHhSWFlTODdDaUg2L1JNZ0JTajJIWlIxVFNkTUJ6?=
 =?utf-8?B?Y2o5MDZxb2hKbXNKUzlBR2sxUlE0S2h1R1lqeWNZNVI0b1lFbXIwS0NXemdZ?=
 =?utf-8?B?RlJXcUV2UUhJcnBxN1RCNDZXblBVdjc1MXpJV3FETzdpZDQ3L3BKTkxZQmcr?=
 =?utf-8?B?dHFBdkxubHJYYlVFZUozaC9PekNOQTd5MTRyZXZPOHNQZmxwQUJqaTZ2ZnBB?=
 =?utf-8?B?MGNBVkpBWHVReGtubndWU25ETGllSkZvNzE0bFRRR0theW41aUZuUk5lcFUw?=
 =?utf-8?B?clkvTCtFVU9NRXNUckJuV3ltckJia29VaVJMUTZvNG5yM2Z4eGsxbXpwdXJ4?=
 =?utf-8?B?aVNrUSt5ejkxOEFNYXlwME54YThZYjMxNFVHZ1BSNDViRkN6NGlRS3JsSnlW?=
 =?utf-8?B?cW9XMTNFS1J4VHJ5VkdsVVZXRzhlbUxsS0pSSi9jUHJnQkRBZk54VExYQzRy?=
 =?utf-8?B?bUM3TjZOQktzcEtyS1dwSEZXMHBnQVBaNWRjVmtZNmd4MUEvbFhEeDFsNzBD?=
 =?utf-8?B?OGtCYnNYL215bWdPWmcvTzY5T1FUVzVuMWk1YitnTU9SZFZnRXAybkdxUDBE?=
 =?utf-8?B?SmlYcEpObVF4N0dHMXBHNXU3b1p0N3A0TGFkdExYTVdrZk5lUVM2aUNHUVVR?=
 =?utf-8?B?U0ZYcFBLajlyaG9yWmFpSWtJWUgveUcvWlFHMnRWOG5PckY5bnU3N0tWTW82?=
 =?utf-8?B?VzlPcUdMeGppYXlSR1VFRnhRenlKSjc4TnVBb3ZESTFSY1g3bVhxdGVpc0R5?=
 =?utf-8?Q?b03zeDfE1+6o7R52M1DdPaSOYNVjZx3qGKWzS4s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230032)(376006)(366008)(1800799016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDhPVW9iRnVCaWhMM1hMTndhdnlJWFR4d0NPQ2hiRFVQaTZzVnh1RjF5WGxO?=
 =?utf-8?B?NW5UVEs4UDY0eDBEWHhxVEp4U2ZNeWF2T2hHeG8yOUd0Y1IveENxUHRIMlZ0?=
 =?utf-8?B?NWJqTmlYYjJ6bmZtZTllU2ZVb1NvemhRdnJYcVV6VDVzVHQvZEFJcWJOaktj?=
 =?utf-8?B?KzNUSjl4MkhDQkc1ZTF4SkErZ2hXa09Zb1cwRXZyUGxHdTBrR0cyRDJZVTVR?=
 =?utf-8?B?SHFjKzdKQ3pNTzBmMTJPZFhXZDNFUWxXSVpVWlZjbTkvclR2Q3BjK2Ixd0pN?=
 =?utf-8?B?WG9IQml4VUNHYU53RDk0di9wNWQ5QkFEK3MxOVZLT2VNckZ4dUZIT1JYV1Rh?=
 =?utf-8?B?c2J1WVkxd1hUMFdBZ1phaVN1SEJqTng0bFYyUSt2dHd5ZXVydThRRlQ2dUk5?=
 =?utf-8?B?aFlWRmN1SHF3SDhNYkY4R3YyYm4zSE5SMFRVVlcwSnNMeWl1SzdYTE5WT0l4?=
 =?utf-8?B?L1B0TDJsdllTZWZXclVvV1AydlJvS2dGUDNyckNraDJLRGgvMWQ3RGdwbjAy?=
 =?utf-8?B?bW1JbEVuMVpRSHVZZFF6NXFoUnlMN3JMd2ordHVxbmgxOE1uTHFpOTlvc3A3?=
 =?utf-8?B?MW1NSmw3Ti85QzFzMlJXdDZ1eUhKTDdGMWVzd2ZVb3VxMmVKV3pHL01qVGMx?=
 =?utf-8?B?QmlUNDNuajl3K1BST3FVbUd5Y0lXZG9FSjRKaEdmemd6aVR4dGJmV1NlY1Z1?=
 =?utf-8?B?eHlxYU5hRmFHQ29uS0gweUlWQ2x3TWxXT1dzZU9JYWptVml0MjM3Q0tnZXJp?=
 =?utf-8?B?WExXZ2VtT0JzWkNGckgyVC8yRTUzZXh5T0FwMDY4ME1vQW53cTJ2Vlc5b2tk?=
 =?utf-8?B?MDBxeUVyZTZrUG1KNnBRYlBKVEF3bVZVdEFHVnN0eDhkNm94QTAvd2E4bk0z?=
 =?utf-8?B?a2VvSGlPa21sN0NkWERoWWcxcXF4SVphZ1RXSG5uMFNrRzE1K213U29tUjRX?=
 =?utf-8?B?dmsyZm9qL09YQ3k4RHBvd2t6eGxhaUhxSmRjekZSaklqY1ZzRDJUUDVSUDVJ?=
 =?utf-8?B?blBMbXNvVitmd2plUFlXZkg1RXNHYlNMN21VczhURHlLd0M5V2dnbjVCNEVs?=
 =?utf-8?B?UFRpY2h5YXdZU2RsbllxWWV4cTE4UWtpcjRZR3cwZUZXK09rcFZKZ2NieGJo?=
 =?utf-8?B?SEN1SmxxQ0pjYkhQV3YrcGdDcXAwcmhQajJMbitTbi9TUEQwK3BSZEdZaWVE?=
 =?utf-8?B?ZmZuUUpEdDhWS1IzZlZ2bGt3NGM4dEpmakZYdUxhTC9MSUlhMjZEUm5veTRN?=
 =?utf-8?B?ZW53MFRGQzFwVktsTmliKzI0U2ZvbytRYXowWjR2YmRmeEFuRDQ1NFFKaFZm?=
 =?utf-8?B?dTdtbnI4djdvWUU5bWlKV3NPRVBNV1NkZHNkWjNZeXU4WjJocU0vam5ZVXpk?=
 =?utf-8?B?dysycmprY1JkSmRnQUtCUGJKU1RGOHhETFVyNXRqNkZjRkJPMDhDd1MvZWJF?=
 =?utf-8?B?V0FUMUZvTXgva1BaaEJxN3BETGx6Tk82aWp3VWZuUG1MSFYwbGxFVnpibC9Z?=
 =?utf-8?B?T2hDbmlDbnMxajRjYnFZaGhla0orMjBzTnltRmNHY2FhRSswTzFCd0RORDB2?=
 =?utf-8?B?eVdVVVVmdzI4dlhwb2dvQ0cwdndZdlNNVWgxUnhzSDlyUGpEY0JBQVo2MFha?=
 =?utf-8?B?ZGpNQXYvK2JydmJoUThxN0xGVEtRZUdOZXlXbHN6M1RFbi9GQnpMN1lVYUJC?=
 =?utf-8?B?TkgxZXZjU0V6MmtyYTBNTVB5ZjBQVmlvcXNHZEZHK3VST2RXdjlvdk5ZdEJ3?=
 =?utf-8?B?WnpEWnV6Sm9BWXJsSmptbG9QUTdFc1Y1NE1DaU5QV3BOVEw4VCtzNUNWNG5I?=
 =?utf-8?B?NFJzaGtxRWJzQndPNUxYWG9MWXgrNXNIdmpxV0hCTE0zdERqcUxYbi9PK21n?=
 =?utf-8?B?Rk1rN3hQbUswVWVCcFY0ZlFLM2pNN1lzZktEbmoyZ0dQVWdyQ2R6dlVTL3FZ?=
 =?utf-8?B?U2taQ1lidElwS0ppUVk0bXhCWU9BbXk4R0htTWpEd2ZQTXh1WXhnaWZUbC9D?=
 =?utf-8?B?RVNFNGhyRTlTYmJNT0lFWFVSV2h3YlJ1K1poelVnUmU5ZUZrZGNpUlZhUXZP?=
 =?utf-8?B?VVY0TWZRVlBUeFhzSEVDMnVJb1ppbUg4T243alpzNFZBYmYrc0FKdkVUdU1N?=
 =?utf-8?B?dHN3RUs2dU54SytRN1Qra0RhWWVXbWJhUnhyVkwxOWFzV0F5WWc0N2pRU2ll?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: affe4dea-06cd-4415-093d-08dc8a33af35
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:29:36.8442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ta0+i4rDVwgTfviqMrHdio3Pe8n7AzgUBTq0MPcloaXyXFu2+75DvcOIJxmwyNS7/Cq767ya/h8ePsC5n8KLn/rJZiA/apuLMB0JtfpGDMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7146
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

Hi Vasileios,

On 6/11/24 6:20 PM, Vasileios Amoiridis wrote:
> On Tue, Jun 11, 2024 at 10:06:59AM -0600, Tom Rini wrote:
>> On Tue, Jun 11, 2024 at 05:41:19PM +0200, Quentin Schulz wrote:
>>> Hi Vasileios,
>>>
>>> On 6/11/24 5:27 PM, Vasileios Amoiridis wrote:
>>>> On Tue, Jun 11, 2024 at 11:33:12AM +0200, Quentin Schulz wrote:
>>>>> Hi Vasileios,
>>>>>
>>>>> On 6/10/24 8:51 PM, Vasileios Amoiridis wrote:
>>>>>> Add support to save boot count variable in a file in a FAT filesystem.
>>>>>>
>>>>>> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
>>>>>> ---
>>>>>>     doc/README.bootcount                          | 12 ++---
>>>>>>     drivers/bootcount/Kconfig                     | 53 +++++++++++++------
>>>>>>     drivers/bootcount/Makefile                    |  2 +-
>>>>>>     .../{bootcount_ext.c => bootcount_fs.c}       | 12 ++---
>>>>>>     4 files changed, 50 insertions(+), 29 deletions(-)
>>>>>>     rename drivers/bootcount/{bootcount_ext.c => bootcount_fs.c} (81%)
>>>>>>
>>>>>> diff --git a/doc/README.bootcount b/doc/README.bootcount
>>>>>> index f6c5f82f..0f4ffb68 100644
>>>>>> --- a/doc/README.bootcount
>>>>>> +++ b/doc/README.bootcount
>>>>>> @@ -23,15 +23,15 @@ It is the responsibility of some application code
>>>>> (typically a Linux
>>>>>>     application) to reset the variable "bootcount" to 0 when the system
>>>>> booted
>>>>>>     successfully, thus allowing for more boot cycles.
>>>>>>
>>>>>> -CONFIG_BOOTCOUNT_EXT
>>>>>> +CONFIG_BOOTCOUNT_FS
>>>>>>     --------------------
>>>>>>
>>>>>> -This adds support for maintaining boot count in a file on an EXT
>>>>> filesystem.
>>>>>> -The file to use is defined by:
>>>>>> +This adds support for maintaining boot count in a file on a filesystem.
>>>>>> +Supported filesystems are FAT and EXT. The file to use is defined by:
>>>>>>
>>>>>> -CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE
>>>>>> -CONFIG_SYS_BOOTCOUNT_EXT_DEVPART
>>>>>> -CONFIG_SYS_BOOTCOUNT_EXT_NAME
>>>>>> +CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
>>>>>> +CONFIG_SYS_BOOTCOUNT_FS_DEVPART
>>>>>> +CONFIG_SYS_BOOTCOUNT_FS_NAME
>>>>>>
>>>>>>     The format of the file is:
>>>>>>
>>>>>> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
>>>>>> index 3c56253b..d3679eb5 100644
>>>>>> --- a/drivers/bootcount/Kconfig
>>>>>> +++ b/drivers/bootcount/Kconfig
>>>>>> @@ -25,10 +25,9 @@ config BOOTCOUNT_GENERIC
>>>>>>     	    Set to the address where the bootcount and bootcount magic
>>>>>>     	    will be stored.
>>>>>>
>>>>>> -config BOOTCOUNT_EXT
>>>>>> -	bool "Boot counter on EXT filesystem"
>>>>>> -	depends on FS_EXT4
>>>>>> -	select EXT4_WRITE
>>>>>> +config BOOTCOUNT_FS
>>>>>> +	bool "Boot counter on a filesystem"
>>>>>> +	depends on FS_EXT4 || FS_FAT
>>>>> Do we really need this 'depends on' here? Especially if we have a choice
>>>>> below...
>>>>>
>>>> Well, probably this is redundant indeed.
>>>>
>>>>>>     	help
>>>>>>     	  Add support for maintaining boot count in a file on an EXT
>>>>> The help text is still mentioning EXT here.
>>>>>
>>>>
>>>> Ahh, I missed that.
>>>>
>>>>> I would recommend removing it, or listing the supported filesystems at the
>>>>> moment. While I assume you tested with FAT, I assume that with FS_ANY, any
>>>>> FS should be supported?
>>>>>
>>>>
>>>> Well, I tested it with both FAT and EXT4 and it works. AFAIU, due to the
>>>> implementation of the filesystem handling code in U-Boot, if the fs supports
>>>> a write a function, then it should work. But I cannot test for other
>>>> filesystems apart from FAT and EXT4 so I think it's better to limit the
>>>> option to these two.
>>>>
>>>
>>> I guess we can let people figure things out themselves and add new options
>>> for when they have tested them, no strong opinion here.
>>>
>>>>>>     	  filesystem.
>>>>>> @@ -184,26 +183,48 @@ config SYS_BOOTCOUNT_SINGLEWORD
>>>>>>     	  This option enables packing boot count magic value and boot count
>>>>>>     	  into single word (32 bits).
>>>>>>
>>>>>> -config SYS_BOOTCOUNT_EXT_INTERFACE
>>>>>> -	string "Interface on which to find boot counter EXT filesystem"
>>>>>> +if BOOTCOUNT_FS
>>>>>> +choice
>>>>>> +	prompt "Filesystem type"
>>>>>> +	default BOOTCOUNT_EXT
>>>>>> +
>>>>>> +config BOOTCOUNT_EXT
>>>>>> +	bool "Boot counter on EXT filesystem"
>>>>>> +	depends on FS_EXT4
>>>>>> +	select EXT4_WRITE
>>>>>> +	help
>>>>>> +	  Add support for maintaing boot counter in a file on EXT filesystem"
>>>>>> +
>>>>>> +config BOOTCOUNT_FAT
>>>>>> +	bool "Boot counter on FAT filesystem"
>>>>>> +	depends on FS_FAT
>>>>>> +	select FAT_WRITE
>>>>>> +	help
>>>>>> +	  Add support for maintaing boot counter in a file on FAT filesystem"
>>>>>> +
>>>
>>> Seems like I missed a typo here as well:
>>>
>>> s/maintaing/maintaining/ ? At least that's what we have in
>>> doc/README.bootcount
>>>
>>>>>> +endchoice
>>>>>> +endif
>>>>>> +
>>>>> Since we now support FS_ANY, do we really need this choice at all?
>>>>>
>>>>> Alternatively, should it **really** be a choice and not just a bunch of
>>>>> configs that depends on BOOTCOUNT_FS + whatever's needed to write on that FS
>>>>> instead? I think we could have both BOOTCOUNT_EXT and BOOTCOUNT_FAT set
>>>>> without issue?
>>>>>
>>>>> Cheers,
>>>>> Quentin
>>>>
>>>> Well, I think I kind of get the point but I am still a bit confused.
>>>> Do you mean that basically the configuration should be done the other way
>>>> around? Instead of choosing BOOTCOUNT_FS and then specifically to choose
>>>> EXT or FAT, to choose one of EXT/FAT and then to select BOOTCOUNT_FS?
>>>> If yes, what is the advantage of this approach?
>>>>
>>>
>>> I'm suggesting:
>>>
>>> """
>>> config BOOTCOUNT_FS
>>> 	bool "Boot counter on a filesystem"
>>>   	help
>>>
>>> config BOOTCOUNT_EXT
>>> 	bool "Boot counter on EXT filesystem"
>>>          default y
>>> 	depends on BOOTCOUNT_FS
>>> 	depends on FS_EXT4
>>> 	select EXT4_WRITE
>>> 	help
>>> 	  Add support for maintaing boot counter in a file on EXT filesystem"
>>>
>>> config BOOTCOUNT_FAT
>>> 	bool "Boot counter on FAT filesystem"
>>> 	depends on BOOTCOUNT_FS
>>> 	depends on FS_FAT
>>> 	select FAT_WRITE
>>> 	help
>>> 	  Add support for maintaing boot counter in a file on FAT filesystem"
>>> """
>>>
>>> This way we can have defconfigs where BOOTCOUNT_FAT and BOOTCOUNT_EXT are
>>> both selected, the user would then be free to decide if the same partition
>>> on two different devices but for the same purpose can be either ext2/3/4 or
>>> FAT, without recompiling U-Boot just for that.
>>>
>>> However, it would now be possible to have BOOTCOUNT_FS=y but neither
>>> BOOTCOUNT_EXT nor BOOTCOUNT_FAT set to y (e.g. if FS_EXT4 or FS_FAT isn't
>>> defined).
>>>
>>> Finally, the other option was just to NOT have BOOTCOUNT_FAT or
>>> BOOTCOUNT_EXT and let people select FS_EXT4/FS_FAT and EXT4_WRITE/FAT_WRITE
>>> themselves since the BOOTCOUNT_FAT/EXT aren't actually used in C code. This
>>> is less user-friendly though.
>>
>> I was thinking that with FS_ANY, we don't need a symbol per filesystem
>> type but can just handle it in the help text with something like "Please
>> ensure that you have enabled write support for the filesystem that you
>> will be used by the partition that you configure this feature for."
>>
> 
> Hi Tom,
> 
> I see that both you and Quentin are leaning towards this solution which is
> totally fine by me. As I said before, the user already needs to specify the
> device interface and the partition to be used so they can also be
> responsible to enable the appropriate filesystem write functionality. Indeed
> if more filesystems are added, it would be quite ugly to have multiple
> symbols just to choose a config.
> 

I wouldn't be surprised if some time in the future we make the device 
interface and partition configurable through a U-Boot environment.

Also, there's no need for U-Boot to know the fs to write to since it can 
be auto-detected, so adding an artificial hurdle isn't necessarily the 
best design choice.

Basically, I can have two products based on the same HW design. I have 
one with an EXT4 partition, and another for FAT partition, they both are 
on the same storage medium (one on one product, the other on the other 
product) in the same partition number. If we had an exclusive choice, 
then we would have to have two different U-Boot for essentially the same 
HW just based on the software design decisions. We cannot always avoid 
this, but I think we can here, so I think this would be pretty nice to 
have :)

> Also, if the user forgets to enable the appropriate *_WRITE config, it will
> trigger an error message in U-Boot that this operation is not supported
> which will be pretty obvious what needs to be done.
> 

OK, that's good news. I hope the message is explicit enough that users 
know what to do with the info. It's better than crashing U-Boot, which 
sometimes happen when in SPL or U-Boot proper pre-reloc for mysterious 
reasons and make things very frustrating to debug :)

> So I can go with a v3, following your proposals.
> 

Seems to me like this may be the way to go yes.

Cheers,
Quentin
