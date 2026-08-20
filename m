Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A598CC5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10C9640651;
	Thu, 20 Aug 2026 12:53:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id neVnndKS-7IX; Thu, 20 Aug 2026 12:53:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787230431;
	bh=D/kW/fF+tD4gW504wDfwG/cuf3TS6rTJt2x+H+omWs4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hn0LUk0bazZaj0E3x/1TKoslDORqy7Bbh1F5UCOmq+UlE7AHPS3//sJdn/KbQ/rRU
	 xOYEuGBEsXRSdJiEdkKmyjNKM+n5a/Z8nji05Ii9Laxb+EIeDQ56fOLNWEpZEGQAjF
	 cxbXvCSq8sfrVx9QQmyVbysQ3vZOlwD5UwIpcviQm9TwE2a7Q57i6ktXhbNYQQ9ujB
	 NLzOSSc7zeCYTHXtpSHuBscXUijEUOVxlG1jja5iKFFJLH8/bM9zyr3ZuZ3ZIPzh0/
	 o2YdGWgJtxuxKdLhpbhdzHIhKCSgJW01wCXns3NLrbvvaVqEkCKXW0i055hVeBfkKf
	 N6mdmS1aE1/mQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D31ED405AB;
	Thu, 20 Aug 2026 12:53:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C68540B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5246160740
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:53:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q29gDZtZcAHj for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:53:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Zn52Marv
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A437A60739
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIlMCnSJFn3IbqWBqTLKVavx1lCgbhADJwdldTwmS1JtShxIms4D5lTwNKtvtYjSrssyXWHBFvjgAL24iwDemi1cHKYKdIHLU7BMpVTe89cW7w89hNW/Hhz6eRzfUDYEfttqnPIOxzvR+MhdqAYphcqCH/sArdNyQwP8s2lMwCBo47bjYajHywfrv9J5VvAb91hkuFmyNDzaMaoYryo9YVnr2BaMFdXhXOLrmOIJPys+vNu3ViBe6uhOekOD03sWmNCSTYerVYW9Nz+P4ONtLdIRPcpelGwSS4idFd+EafYJ8iA5N8RNP2F2caIuhorPBXafQpRI4xnSAMP3iy+YLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/kW/fF+tD4gW504wDfwG/cuf3TS6rTJt2x+H+omWs4=;
 b=SYQoNPXf6KTl+zELg7clKOFxhTEZXOuFVcPswKE5DxaE0VYy6oUVoL5/a/AvZRadFFvBFLVgcXfx8k8Sub4+iGNrnSJPmLJgdV9/9zzYuAdY6rzQLrgjrZ1k+VEgfX/BtY19Dgaw4KYJssdkBfU69nQc4S1S618Kaq7P7ERVchrdjDXmbFKfjczKV3HhwoEGOsPByBvmhjjo9pAYF3cWKp8afLHlnXe0FwnqvsBTeg27WxKbFMvKa9T/GpsXFkTtTnddY8Taknk6A3rDZqxrn2el65L88uPJa7CCJ/oNZLTFGGEm04kF2t+Mk6SGJ2ckqCgfVIwV2pSCvXU5TAWOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/kW/fF+tD4gW504wDfwG/cuf3TS6rTJt2x+H+omWs4=;
 b=Zn52MarvQlZCJ1yhywNxC5NL74evho9w+6QbMZyBktBLnd17g6xU5DdvqG9vNm3vkB7sGeROIhlc/Gkb/JMOCraoV1pf50kmJOaUPu3r0FWZEMg/tYEySsiOBZlWTzRTtMxP92Xa+pe6H8Tqz8K4n/eKGeGehJLCbYhtq8xu8Ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DU0PR04MB9297.eurprd04.prod.outlook.com (2603:10a6:10:354::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 12:53:40 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 12:53:40 +0000
Message-ID: <fa8799df-3e40-46ef-a4b1-8bdf57415eb0@cherry.de>
Date: Thu, 20 Aug 2026 14:53:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] rockchip: doc: add back to ROM section
To: Alexey Charkov <alchark@flipper.net>
Cc: Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com,
 sjg@chromium.org, trini@konsulko.com, u-boot@lists.u-boot-project.org,
 eddie.cai.linux@gmail.com, Jonas Karlman <jonas@kwiboo.se>
References: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
 <483e93ba-a427-4ed1-b5f6-8d6cd11c5a42@gmail.com>
 <c885ef7b-5d2c-4a0f-8681-43f3f87c650f@cherry.de>
 <CAKTNdwEaUsQLe1qmn8JUVEXWqyO47ny510XN4K2+j59FGih9YA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAKTNdwEaUsQLe1qmn8JUVEXWqyO47ny510XN4K2+j59FGih9YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0041.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::13) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DU0PR04MB9297:EE_
X-MS-Office365-Filtering-Correlation-Id: 0186e74e-a0c0-4632-b8ee-08defeba0f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|23010399003|366016|3023799007|4133799003|6133799003|56012099006|10067099003|4143699003|11063799006|22082099003|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: xsfRVt9C6INlQIPEtRCU1abpICVa7sjdGm/f8FU0+VYZLBMzx/knI8qlAK8auYpLhNsfbXJxhAiRw3OUzANqRw4Jy9bj10uVH2MJg1kQa/QUAxF525w7hr/81YGviqB0y/q2WFOmMz48Bmd20A1JW6/aLz8Pmo4u9NLlE6qgYtGjikh0KPM0CQF/zKwN9ImEWfTnZRVcbWucHq8qfWnYR8bk6NKajk/4yXN17oMDpruG4Qsj0Ah/ZrES86wUccWotznDnv5w7zVq8AHyrsqWC4ty19c5pFbYjvJCSRvoV1eeA0Gi4i0PvKnhc/krRk9xpNkPUPMTtbC0lsdS3mmfR6g1QcXsbUR2IPG0tUmIk7iFd6exfVOKs/Tfw1uBybsMpkKxVxXJWjmBTcy0prERLzSBMDjeAbHyH/NoxrfNkB8iIa1KsupPYNfO4CdIc5Uhm4sR41Ap+ZAVeFw1cNXyNj4G+AEgPFLQHf1n1kFc7QKymYy/yknoVf1N5KPhR7YlMbYtK7Q7XHR0EQ6UctyKQok/D0O4OYTL1giPok9ha/m7xhQA0HnDr1/Kuc/gtRT84TdCZK8fI9hhfwzSYqwQYPw5AL4Sjh98tLblATIBEQtwl12d9dlgtLJ1tWC5v3JS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(23010399003)(366016)(3023799007)(4133799003)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGEwczYzdktHZSswR0VVUmJibHQ4dUZIRGhldWFQV2U1TFNMcm5hQmk4WFpL?=
 =?utf-8?B?SllsV1dxZ3J1b2YzNzNCVVgreExPc1JWai9SVTVLcEl2c3IwbU5GemE4Sm9F?=
 =?utf-8?B?ZG1PYmZhSk5SdkVlVExmV1ZJVUtVeW85dHNqa1dEWnhBZW45cGNaUFdybjlw?=
 =?utf-8?B?dnVBTWZUSXhkbFdGSytHQ3N4NDNzaHMyRXc2NHR5Z1NPek1XRzJGWTM2QVdw?=
 =?utf-8?B?Qm9Tekdoa1h3REE5ell4SEdldnp5V3FmVXJOL056bUUrSEs0a0tmdVhCRXdr?=
 =?utf-8?B?cUMvbk9aMTFXSFU5WTRpSEZSSWk1bjJvaTZ5cCszcWpaUEJXL3VjbDdmZE5l?=
 =?utf-8?B?TnpuUW5UNkxqeURKa2tSM2MvdEdXd1ViSWZTZGg0dGl3NkFRWGVmaitnSlVx?=
 =?utf-8?B?MGZlNWFia09ScDc3TEhreTRWVE5EZFdJeWRFMjRhUXArcCtkWTVxOW0xNWZO?=
 =?utf-8?B?VHhhNEtiTUhMdnZqQXFkbEI0dnVOTkl3ZG5CQUIvcGV3c0VCdytlTkJiaXFW?=
 =?utf-8?B?ZXZGTmpzQ25tb09sWkhWa09ITCtKUkkrcE5IT25qOStGUDVOeGh6dDJ1aGlt?=
 =?utf-8?B?b285VTBpcEwyOTFkelJnT1NJYWVJWnpwR1hVWHh2cGpoYVI0a3REaU5SbkVF?=
 =?utf-8?B?Qkt4MmdVSytYcWkvSUV5eFMxWFV3UnJDQ2tBTi90b1d3clBjVjlhMHJlWnNF?=
 =?utf-8?B?QjF1YXhjbnFDWWx6MXRTNi9laDVUWEFJL2VxcWJWdm51M2dGVUFLTXIxMk1N?=
 =?utf-8?B?WWJXKzNubENJc1lRSEpDOHhzM3VSeXJTWTJZaTN4U2k5bEN5dVNDVUhvUFVk?=
 =?utf-8?B?ckZuemUvUlhoRVBBYlJPdyt3bHJQSXM2NFo2ak1IYUZwcWg5Q0w1SVgvNGNm?=
 =?utf-8?B?RE5nbGx3NmJkYXR0SmFvNVhMR2FZcE5iWkU2dE1pYmN4TVNBNnF6bEtLNDRu?=
 =?utf-8?B?MzRzams2R293am9yYTNRdnhCTFN6VVJheUVjMGhoeVlRZjd6Y25iLzNuVEk4?=
 =?utf-8?B?czlKY2dQNmg5YlVxQzJ2VFJnVHZLZTZYeG9tZEExQ1FEWnFSNnk3TWtkNUxD?=
 =?utf-8?B?YjJTVWVmR3BrNS9RemQ0MytvREVEd0JLc2Zlekx0Q1NUdHdVQ3orRUh4SWE5?=
 =?utf-8?B?aHJ3UHRLRDl2VEdEVGZPZ3p3ODBBSmZVRWNEUEZjekVCbjBMaG5RMG9IQmNE?=
 =?utf-8?B?dUlZOUJhMndyYXlCV1pHNkVGckRQU1gxYklNRTUvc1E3d2Q4YTdaM081TzRu?=
 =?utf-8?B?OU1hWlBZOGlidld0RkN5NFlJa1AxeFRjazV0TnEyYUJwQnY3aktINVg3STZE?=
 =?utf-8?B?QzViZWVlYVRIVjRuSjZKZGtWRWg5c3FLSTVEUzRMUi9lNmt6R0VkcXV0dnFZ?=
 =?utf-8?B?dThTUHhCZnlVNDU4VGo3eDdyTitFczdoVWlzSzQ2cGZSejhZcHJMVlIwbEdi?=
 =?utf-8?B?Q2FVQTRuNVJmVWNEMnBWRlBEK3RvUHVpY1dYSHNPZ0Y1NDVwRWZObzZOeUhx?=
 =?utf-8?B?TmRWTDV6aHZlcEFYNlpQYlA1Z0FaT3Y5MEdXMURtdGpQMy9XNmlEbGZKOWIz?=
 =?utf-8?B?Vjg1NEQwMHFOQi90SWxmL3Z3alJ3ZXo2L0RpUmo4dkg5dDdOUzg1Y0d1Wmdv?=
 =?utf-8?B?T25uTnB3NzFqd0hWaThEOUtVeW1hNmQrQzFQV3FoVnA3a2xIVDdUdGVSb1lx?=
 =?utf-8?B?eXR2K3RNUDRVTmJRcjZsSUtnRmdHSXhOejRVOWlXMFNob0hUOWEySHl4bVhO?=
 =?utf-8?B?Z2FxcjRGWk9GeEFzSGlWcjZ5cWVUWUVVcUFMMU45T2V2emErUGs3TUw0akYy?=
 =?utf-8?B?Y2hvV3hHOWlyL0I4UU1QMm9GMXo0akNNUGtWajY0VytSUFduaitVcDJpQXN1?=
 =?utf-8?B?N0NDb0cxeWd2YXF3eVBQbk8wazJINUhGVTNDWGlkV2RuS0F4blRDODhkbExW?=
 =?utf-8?B?THBsOWZ0VW40WUZWWGZkYU40cW52emtyazlUTm9GblY1Q2hhZmpkcXl2ZDB1?=
 =?utf-8?B?VS83OWVlWmJpYjcyM0NFOFBGQ2YwVllQdUVWNjZpWE14c0RxT3I2d1VvZE9B?=
 =?utf-8?B?UDRxMHYxa2J6VUNXaG9uUlB0K2dEaDdSNlV6N08vb3N5a2ZwL2doWm41VTdU?=
 =?utf-8?B?bmlqQ1RmSVNtditWS29oN2FMekYrdUNBRU1iMlQzRWZ0NlByZXBTYUdHV3NZ?=
 =?utf-8?B?SklweUdFSmYzdkMwekt0Ui8xNUg3emtJV0JkMFZObkRXU1UzZkhYU3BLV1JE?=
 =?utf-8?B?eHNHVEdIeVhjT0t5MGlobTBKL1drV1pJS2xHUlZ2R011cTdFWG5JSHhhYlND?=
 =?utf-8?B?bXIyNXBMaEVkdEF2WDgrditwSEtkWUgzWnc5bVhsOHJ0WktCM0YycEVqTzkz?=
 =?utf-8?Q?MQEmajQa6b8MBbkZI2bI36/Z/7ap0Q0wQGcGVLe0Y8uAx?=
X-MS-Exchange-AntiSpam-MessageData-1: BUQ/5npXt4p6Lw==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0186e74e-a0c0-4632-b8ee-08defeba0f21
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 12:53:40.5899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FR9K/fvOvfz8rBbv6rKZnIiaB4x7ugG4tm8w8cqU/VZDRqDSLxzJ4y4qTjLu/mF3gQBojtSNkPurxt636T8w9vDXGFWQQMMUxjhrcaUXiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9297
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Alexey,

On 8/20/26 12:40 PM, Alexey Charkov wrote:
> Hi Quentin,
> 
> On Wed, Aug 19, 2026 at 4:49 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Johan,
>>
>> Please incorporate Jonas's comments made on the v6:
>> https://lore.kernel.org/u-boot/1e47521b-c3f2-4c62-86eb-51866b911968@kwiboo.se/
>>
>> This also applies to patches 2 and 4's content and commit titles/logs. I
>> won't repeat his review here.
>>
>> On 8/15/26 3:08 PM, Johan Jonker wrote:
>>> Add a back to ROM section to rockchip.rst
>>> Correct Kconfig text.
>>>
>>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>> Changed V7:
>>> Move under a 'Boot flow' heading
>>> Remove "Some"
>>> ---
>>>    arch/arm/mach-rockchip/Kconfig  | 16 ++++++++--------
>>>    doc/board/rockchip/rockchip.rst | 11 +++++++++++
>>>    2 files changed, 19 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>>> index 1a2e7847c9e7..c1dbcce1e27c 100644
>>> --- a/arch/arm/mach-rockchip/Kconfig
>>> +++ b/arch/arm/mach-rockchip/Kconfig
>>> @@ -600,26 +600,26 @@ config ROCKCHIP_USB_UART
>>>          SoCs will enable this routing as a debug measure.
>>>
>>>    config SPL_ROCKCHIP_BACK_TO_BROM
>>> -     bool "SPL returns to bootrom"
>>> +     bool "SPL returns to boot ROM"
>>>        default y if ROCKCHIP_RK3036
>>>        select ROCKCHIP_BROM_HELPER
>>>        select SPL_BOOTROM_SUPPORT
>>>        depends on SPL
>>>        help
>>> -       Rockchip SoCs have ability to load SPL & U-Boot binary. If enabled,
>>> -       SPL will return to the boot rom, which will then load the U-Boot
>>> -       binary to keep going on.
>>> +       Rockchip SoCs have the ability to load a second loader binary
>>
>> If I'm not mistaken, it can go back to BROM more than once? I vaguely
>> recall the maximum supported number of images in the rk header to be 4
>> from a discussion we had with Jonas but cannot find a source anymore :/
> 
> That's right, the RKNS image can have up to 4 entries. I've been
> digging into RK3576 boot ROM quirks and can confirm from its behavior
> that it checks for <= 4 when loading. I've also written up a separate
> doc [1] on the behavior of the RK3576 specific ROM version, but I
> don't know how well that generalizes to other SoC versions.
> 

I think we need to split the docs between aarch32 and aarch64 at least. 
I'm wondering whether we should have SoC-specific docs as well. We can 
avoid docs duplication by making use of literalinclude directive.

I don't know if we should generalize the BootROM part as it's likely 
going to be SoC-specific. E.g. RK3576 is the only (or one of very few) 
Rockchip SoCs that has UFS support. It's also part of the RK35xx 
subfamily that reads the SARADC channel 0 at boot to decide on which 
boot media to try booting from. I'm assuming the secure boot part of it 
may also be different. RK3399, PX30 and RK3588 all behave differently in 
that regard so it wouldn't be far-fetched that SoCs in the same family 
may also have different secure boot implementations.

> Another interesting part that I discovered there is that the ROM looks
> for the image header at multiple offsets into each storage device.
> This can potentially enable failsafe fallbacks to guard against a
> failed write or a corrupted image (e.g. write known-good copies into
> higher-numbered slots, and only then write the fresh idbloader.img at
> sector 64).
> 

Yeah, this has been known for a few SoCs already. Barebox for example 
uses this knowledge to do exactly what you suggested: 
https://elixir.bootlin.com/barebox/v2026.07.0/source/arch/arm/mach-rockchip/bbu.c#L19

SPI on RK3399 for example looks at offset 0 and 64 (I know, because I 
messed up a few times and flashed my image at offset 64 instead of (my) 
expected offset 64 and it still booted TPL (and then broke because 
U-Boot proper wasn't at the expected location IIRC).

I'm unsure whether the offsets are stable across SoCs.

It'd be nice to have a dump of the BootROM of all supported SoCs and 
then get info from that, but that's something that's rarely done (and 
likely even less so publicly shared).

> [1] https://docs.flipper.net/one/hardware/rk3576/boot-rom#normal-boot-from-persistent-storage
> 

Thanks for sharing, I'm sure this will come in handy at some point :)

>> Maybe we should reword this to "have the ability to go back after SPL to
>> BootROM and have it load and execute the next binary in the image
>> (typically U-Boot proper)"?
>>
>>> +       after the SPL phase. If enabled, SPL will return to the boot ROM,
>>> +       which will then load and execute the U-Boot binary.
>>>
>>>    config TPL_ROCKCHIP_BACK_TO_BROM
>>> -     bool "TPL returns to bootrom"
>>> +     bool "TPL returns to boot ROM"
>>>        default y
>>>        select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
>>>        select TPL_BOOTROM_SUPPORT
>>>        depends on TPL
>>>        help
>>> -       Rockchip SoCs have ability to load SPL & U-Boot binary. If enabled,
>>> -       SPL will return to the boot rom, which will then load the U-Boot
>>> -       binary to keep going on.
>>> +       Rockchip SoCs have the ability to load a second loader binary
>>> +       after the TPL phase. If enabled, TPL will return to the boot ROM,
>>> +       which will then load and execute a SPL binary.
>>
>> Maybe we should reword this to "have the ability to go back after TPL to
>> BootROM and have it load and execute the next binary in the image
>> (typically U-Boot SPL)"?
>>
>>>
>>>    config ROCKCHIP_COMMON_BOARD
>>>        bool "Rockchip common board file"
>>> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
>>> index 5e16e860bfd5..d5945e805ba8 100644
>>> --- a/doc/board/rockchip/rockchip.rst
>>> +++ b/doc/board/rockchip/rockchip.rst
>>> @@ -560,5 +560,16 @@ config-flash.ini:
>>>            PATH=RK30xxLoader_uboot.bin
>>>
>>>
>>> +Boot flow
>>> +---------
>>> +
>>> +Back to ROM
>>> +^^^^^^^^^^^
>>> +
>>> +Rockchip SoCs have the ability to load a second loader binary.
>>> +If enabled, the TPL/SPL code will return to the boot ROM, which will then
>>> +load and execute a SPL or U-Boot binary.
>>
>> Maybe we should reword this to "have the ability to go, after a binary's
>> been already loaded and executed, back to BootROM and have it load and
>> execute the next binary in the image (typically SPL/U-Boot proper)".
> 
> On RK3576 in particular, both the boost.bin (which fixes SD card boot)
> and the DDR init (the closed-source TPL) return to the boot ROM, and
> then the boot ROM loads the SPL (and optionally its payload) into RAM
> and executes it. So "a second loader binary" sounds too narrow. I
> would say something like:
> 
> Rockchip SoCs have the ability to return control to the boot ROM after
> any loaded binary has completed execution. In this case the boot ROM
> loads and executes the next binary in the image, which for different
> SoC versions can be the DRAM trainer, the SPL, or any other payload.
> 

I don't like the "different SoC versions" part as it isn't necessarily 
specific to the SoC as far as I understood. It depends on what's next in 
the image. If you're returning from SPL, the next image is likely going 
to be proper. From TPL, likely SPL but could be VPL as well (though 
nothing does that at the moment). With the SD boost stuff for RK3576, 
and dboot/rboot for some newer SoCs, likely TPL from what I understood.

> I wouldn't mention the U-Boot proper in the same row, as it normally
> expects an FDT to work with, which the boot ROM won't provide (that's
> the SPL's job).

On Rockchip, we have a u-boot.itb as after-SPL stage, which contains 
TF-A, optionally OP-TEE OS, U-Boot proper (possibly compressed) and 
device tree(s). I don't remember for sure which device tree is passed to 
TF-A (as it's SPL loading and jumping to it, and SPL has a different FDT 
than proper) but I think it's proper's as we read the device tree back 
to insert in the kernel's FDT U-Boot's reserved memory nodes for at 
least OP-TEE OS, which are inserted by OP-TEE OS in the FDT passed by 
TF-A (passed by SPL).

I wouldn't focus too much on SPL_ROCKCHIP_BACK_TO_BROM as we only have 
four boards selecting it: rock_defconfig (via a select in 
ROCKCHIP_RK3188), phycore-rk3288_defconfig, popmetal-rk3288_defconfig 
and rock2_defconfig. All rather ancient and I own none of them.
I would just omit U-Boot proper being loaded by BootROM as those boards 
haven't seen any activity in the last few years aside from the switch to 
OF_UPSTREAM Johan did. I'm assuming any new board will use 
TPL_ROCKCHIP_BACK_TO_BROM so we should focus on documenting that.

Cheers,
Quentin
