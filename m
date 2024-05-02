Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9FDC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982A388B98;
	Thu,  2 May 2024 15:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="MQXwc4uv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD63988BE5; Thu,  2 May 2024 15:32:40 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B0108846E
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 15:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIDXg7TcEqI6KGe2Rr8XLgGoM7zwiqU0tAREDqmk7XomY7iDQQUVFBluAXOexas4Z1joPzcKWlV0UZovQQ4SXC9kBIz9ZKvXeLijHG9quecZ4xBVYO/nnksYby47mb8pLnHMf/P6IdoLV1oQdHOn4tT8v8xJjwDh4Wf9iBiYhOIIMxOIVXgLB3R/sSQofFSFKpl+ozmcOJz1Li3askl3fmGwIfBbrDNszNShnoHuIOoD74jHxfmLrUE1kFJBqcnFIA6EClOj4xAqNUpLYMoP3Td4+5vhgAassUgMMopNA+WeN1CbHnsnjC6eumV4WyIWU+JxcvGXQ7VXBCNpT+/ZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WWIEmUhKGFYO11B6WKIRfESnpaWKymI3zCpqdSs1pc=;
 b=lpdd5V1AjgL9iI/WfDyfzK6NJ3HGqZKKICNfiZB9kUKaSiXVMWJJrtX1vQeOR4wOerq0qs1eOaoNKwiNhRKniO89S2jPM+O6wFEwHQ+LEhEaa1Fdyhz1DO3lGklyvBMCliTm9Wvw08P/CSes3eQgr5jn0Kc1y+xtQj8PH/HATrAgo3XR3D3hRH8iJD6aNlrAx9Tv105/fkEf7oIjI6GifM/Irrq7yL95joKwPx1MSOs1Slx/Lk5ouYNmpjbIstPrApYezXaH6uBlYwB+OPL/97YIlDX5jTcWBtdFRCHKtb8SmKGxYwllvteCr49rBTMUoMKurVYCv5UFtcicOGYTPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WWIEmUhKGFYO11B6WKIRfESnpaWKymI3zCpqdSs1pc=;
 b=MQXwc4uvhJJw06k/yuXEgH4QA+hLyM6FrBA5EROYsGaENQm1rezbb0/PLYrTTGfgQTd7Gm2GjxVbCi+GMyD9XSHRU7NeHx1FrSUA9pXUTY1Z+WmXjqTfL6AsX2Vg/DEiw5yvvqcpj4ES6rg5j+rknvk2sEjgsMjubNDRmBNiaAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by DBBPR08MB10649.eurprd08.prod.outlook.com (2603:10a6:10:52e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Thu, 2 May
 2024 13:32:35 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 13:32:35 +0000
Message-ID: <59be86ee-1523-41e1-af79-5495f077f796@weidmueller.com>
Date: Thu, 2 May 2024 15:32:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Use header file from external library in u-boot
To: u-boot@lists.denx.de,
 Johannes Kirchmair - SKIDATA <Johannes.Kirchmair@skidata.com>
References: <GVAP278MB0456BCDA64C66C434932AF388C182@GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM>
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <GVAP278MB0456BCDA64C66C434932AF388C182@GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::14) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|DBBPR08MB10649:EE_
X-MS-Office365-Filtering-Correlation-Id: 31153686-5328-46d1-07a1-08dc6aac53b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXZsYmNVMVVJMlBDM2pUVEZqSk9Sem5NVTdyWkNoODBub3BITlp6MnRYSnFV?=
 =?utf-8?B?Q214OFZUY2x6R3cyUnIycGIzQ3RENlU2TkxqOE9oODVQMWZRMHFWUnIyWHU1?=
 =?utf-8?B?THloYjRzZmovNGF1WWxUSnNqaHUrSVd1Vjdrbi9PRERCOXo3TU5QZEpzYWFv?=
 =?utf-8?B?Nmo2U3VBdk0xSHVoQjJDMlo4SForUHBQUUxZTHpBVlFZaWR6NGJuNEdURnpo?=
 =?utf-8?B?TW0vQS9DVzV2OWhsOVkzNk1NZHM2bXdTREMyZGxJODZYMSs3dU1QbWx3b0lG?=
 =?utf-8?B?L3kxZXJ5MTdyVythcThwd3dyVTQ4RjFuYXJqcGdPQTJ3VnB1alVENXZLTk5r?=
 =?utf-8?B?NElUYU1NNkcxNTYvdWFkQU84VjVQdGNkVlcrb1o1YWhTNGM1Tm94Qk1YdVhC?=
 =?utf-8?B?Q2JGL3dJVk5VQUp1dW5UaFk2bGppYis2cjdmd3pJS3lDNGhLMEpUaUk5STB0?=
 =?utf-8?B?WkFXYWlzZFF2NGkraGNJdGZjV2FaNytqY0M1SEtSMnphS1Q2a1pDallLU1RY?=
 =?utf-8?B?djRWL2I0SEhaVndmaGs3NTc1OXJhUzR6b3lkOFYxTWZWZEJjM0k5ZUZrcDVW?=
 =?utf-8?B?cnBxd0xXdm5oVWNIZENRbFM2VXB0bUdiSzNkSEN1WmhVelZ6ODN5UlRMZmpi?=
 =?utf-8?B?NGdPSEdaeThOWUdhVE1hZlphWkJ5bHA1MDFDUjFsanhNZDU1Unl0eFNzYVoy?=
 =?utf-8?B?aHE1YWxSaFA0enJBZnBsbUg5RFF1b3RKU2xkaTl4dUYwVXBzMkYwSmVjQ2Zo?=
 =?utf-8?B?alJGZ0dnK2xOMFF2R2V4dkxDQ0lCMU1qMkFMQmxINENtU0JPSmRES0s1Vzdr?=
 =?utf-8?B?dUdvc0ZSbzFJUVFMeTlwRnlWaVMvblI5K0VuVURnQUkwM3ZXT2h4ZHFoU3BG?=
 =?utf-8?B?SFlVcncwMnBvWUwvcTZWbko1ekp5VlZvTXBMaDYybll0WUl5a0tTdE45Zm5o?=
 =?utf-8?B?MHJvNmFyNmdVWmxxZlp2TTJmUVhmaDJaeUQyWlJOWkgxNGxjc2I5ZWEzaUl2?=
 =?utf-8?B?VDZvS2l2dDBUZXBxbFM4MFRyUFlBSWxYMFlIVVhOMEJiVkVqQzB5UUJIZEZ1?=
 =?utf-8?B?eHJ6d3FpZ3R2bjdaM0hnTnNkbXpKUko4WTVkZ2wxb29YdVBKNGlKcm5SbTZI?=
 =?utf-8?B?MGZzSjlORGhyK3Y3WWVGU3JucmwvZXJZUlh1cDNSd0o3TzkxY1c0dVNkVTVy?=
 =?utf-8?B?TTlxZ0k2TTRqSm5hV1NVRmNoV0RYK3N0SFp5RDd1ME1WNHlDbkpjcC9kTFJZ?=
 =?utf-8?B?YTZ2eFphRDNiQnVHODJud01CZ2hZQ0t3UGk5VkJnS1kyZHR3VFIwTlhvdFVI?=
 =?utf-8?B?aEQ3Y2tzMGw2cFlhbmNoMDdtU0lxNUlRS1kwSnFrcUFkSjFmSDFhN3Q0aUhh?=
 =?utf-8?B?Q1FoM3QxdVdUdXAyTkVzZEdQSTg5MysvNzF4RXZ4ZmZHaXdNRCtvejJjei9Y?=
 =?utf-8?B?YUlTbGZYcWJ0cG5MVFRkaUVsK3dvUzExODRiVGtwUkNTSWM1L0pLNFU2a0R3?=
 =?utf-8?B?Y1FxMDcyV004OVBweFN2Z2JQTG5jdFNnMzlEL1Ntbld6SXRueDN3SW4vNi8z?=
 =?utf-8?B?RlQ0MzdzUFREU2JsaGx1ZlQzRDZmMmg0RzE4d0lxdUVEbVY5Y2FqT1l5MXFk?=
 =?utf-8?B?eGwrV0FYYVBRQVFBbklGODZQOEFXWTEyM29qbTFaV1kyM0VzOEhsRVhPTVpH?=
 =?utf-8?B?Ulk0RFRtU3JtcjVKamhXR2ZxdUhXZXlHMDZLR1J6YVJkMStiZUZyZ0hnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGJUT0ZDVnIwNGRtVnRCUkt5WElLWDhsazJVLzM4MEptZXY1YjBnUXJLaGtY?=
 =?utf-8?B?TG9mL0N2QWV5WVNBS0RYa3h0S3RHbWc1TktJVFlxWEhvbHNnWUQrdzBJWGFs?=
 =?utf-8?B?Mk9WV2NzMDNCaDdJT1VhN2tIRWlOc01hcjBHbUE3N3FZOTFuQTdzNmpPMjdm?=
 =?utf-8?B?K2xyd0NZZElrNksxVnhrR3Nwd1JlbjdHSW4wUmxFZGY1VURGbnlEZ0dDcndV?=
 =?utf-8?B?ZGJWTDNHNXR3b1FSV2NKdmZ6Vm9DdllKMHI2a08vNlIxM1VHdU0rcG9uSDBn?=
 =?utf-8?B?bENMTUhDM25pclQvd1BEZXBjdWE4clY4WFllQXpRSHJqSUk0M3JoN1doZCth?=
 =?utf-8?B?MVQwcHJNdlRRQm9JaGFuYXg5Q2ZmeElrbjJ0VTcxWWdscWh3cjlERDRLZzZU?=
 =?utf-8?B?UlI5TjVQb3o2ZDJxOVBzZTFaQWR2dEU2bW81aFNFY3JRYmx6MlNoSWhQSmZV?=
 =?utf-8?B?S2tOZDZqd2N6ZW82ZUovdkx6VHgvV1VsRHlqSVF5SVdiK0NRS29FN2MvOWd6?=
 =?utf-8?B?UVE4K3JucDNBczlKRU0vQlJHa1dwMitLY29KZFV0UWJQRk9PZ3FZdjArVER4?=
 =?utf-8?B?WlNZVHlNZWFFWnVDcDd0M2diY2g2T3R4YXR2K1l4Z1ZkazJ6Nnllc3lJa2tI?=
 =?utf-8?B?R2xadTVPU1lXK05zdU1pK1NrVHcxQ0JhUXJyajFpejV5UTFHTDJ1SkZHb3BW?=
 =?utf-8?B?TkxUTXBRdEh3QkV3T0JzYkZyK0g0cnI2WmhRTW1teGs4RjhKQXIvc2Z2TDRv?=
 =?utf-8?B?Vm9NVnVGaG5CekpKOFF0SUUvSkxqVFJqZEZZeGE1Q2I5TmhjdzQ5UGZockFB?=
 =?utf-8?B?ejBXMlU0UEpOQzdYSk51UFJjWHVyK2V0WHJkZS95WXVYZzRJZGFKbFA0andR?=
 =?utf-8?B?WFdNcGlCc2hWem9YU1BvSFJtS3pEakpBMlhhRWhlNkJrTWxoTGIzOUpvWjNG?=
 =?utf-8?B?YjdZOWV6TzA4Z3ZwSEV5MnFjOHpaZHpQVC8wRHRvRUdqS1dldy9rd25BYU9r?=
 =?utf-8?B?SDAybkdKUVl2cWRCRmR5bVNGRU81MS94TStxK2lhaUFSNzFxSHNqQTBZSlBV?=
 =?utf-8?B?L3ZzRTl4WjFVblJhTDg1bVd6Y0lKY0JwSlQ2Y2JXdEsrV2tqY0FtMUNlUEZi?=
 =?utf-8?B?bVRDblp3NDJKZlpXdkUzUWF1dW92cDFWRVprWG5jclp1YU9FZWhsYTd0UG40?=
 =?utf-8?B?VktCeUNmZVA2Q2RxVkw5ZjFlTkhhNmdIaFZFOUV0TndDVHVYcThXVElqdkVx?=
 =?utf-8?B?SFJrMklIVlhTMGxvZWNpNXQ4dG1XbDhFT2E2VGRSQ2pJRGZ3THlwV1crT2s1?=
 =?utf-8?B?cEd5RVEybll5b0hQbjNGRW96R1l4RzdNZ2kxZytDMjRMYUJ3amE2RTVmUlRG?=
 =?utf-8?B?MVl4T0pXdmhqZ2xLLzRGRjlROVUxckE0QVBLR2NtSHNVOWJBS2dZeTA3M2Jr?=
 =?utf-8?B?YVpab0d0NnVBeTZpWGNvbHdZeUpDTzBKVlFqdmpaRHlEWDVjU25lR2t0bE5V?=
 =?utf-8?B?L09TOWEwUjUxcnAxNkwwQWs1KzYxbmk0Z0diMkcvR3M2dE9EUXBGVzhmWGVo?=
 =?utf-8?B?L1g5SEdrenBwNFZKOVZRSXoyZHkzQ05Mb2c0UEpKV0p0NC9ET0NibHVSalJD?=
 =?utf-8?B?SmpMUzNTcXNIT1VYU2psODg1dUFXNzZFZzBHZUpuRmhPZzk4M21mL3FQbjJ3?=
 =?utf-8?B?cGZWeXlRU2ppSkpVc0V5eW1hK2JUS3RwMHZrR2RTMHZGRHNtZFlRUGNKai9I?=
 =?utf-8?B?d2s5WEZWZzJFUE1TZ3M2dUZlRzRrUERTT3FrK3NabHRoV1MxelhRTVQ4N0hM?=
 =?utf-8?B?dHBYUmE5Sy9ncjVIOVRxRHlXdjJHTEMwelJYY2VBMWd6N3pRSWRBblp4bE1O?=
 =?utf-8?B?cXpNZnhheTI4R1ZqSUhQMWQybkZvaUQwWG5hN1BYZURUaGk2VmhxakRFU25O?=
 =?utf-8?B?SmFON3U2TDZyMllnaHdzSW5uUFc3RjM3dEN2RVpSOE5SbjBiQ1o3eFhaalJH?=
 =?utf-8?B?YlNFUXBDQXNqeXB0WXJ2LytTeXpkMlBLQ0VlMExOQWJtS05vTWxKcHk1Q21M?=
 =?utf-8?B?TDJ4YjVCUkJmaHZOVkk5NmJJOUFGbks3Q3FNZzdaUmdKM3lRckd3ZmJQU0sw?=
 =?utf-8?B?Ri9zQUNVT3dGeFN6VGZyTW4rV1F5ZlRXYzkrZ1VqWkc1ZTEzRkdCb2ZuNVJS?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31153686-5328-46d1-07a1-08dc6aac53b3
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 13:32:35.1725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FckDxipvyd+Kph8gYY+ia0kRKiv/NsuDFT1RMpsA1vxKq3NG0MAWtlKvKBBvVw1YwaxWnSApRiML9CWT/zwoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10649
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

On 02.05.2024 08:57, Johannes Kirchmair - SKIDATA wrote:
> Dear u-boot folks,
> 
> we are trying to share some information between u-boot and a Linux user space tool. For this we place some information in a FRAM. This information is just some numeric values, indicating some wanted behaviour. I thought of using a header file to keep these values aligned between the user space tool and u-boot. This header is provided by a library.  Including it into the user space tool is straight forward, but into u-boot does seem complicated, as the build system is not meant to include external libraries. Is there a preferred way to do this kind of alignment or a suggestion on how to handle this?
> 
> Best regards
> Johannes

How about writing it into the linux device-tree. 'bootstage' does this 
in the same way if I remember correctly.

