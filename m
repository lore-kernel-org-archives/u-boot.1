Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3A2C52D7F
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 09:42:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1443388765;
	Wed, 14 Aug 2024 11:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="Iw4toqAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A857D888CC; Wed, 14 Aug 2024 11:42:04 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A67868800C
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 11:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReSk/SpcTKYdlkF0VNJ4k5Vv+Pu8axzPNdh5cLYHEI13CFw80LLnyCZU+trivj99yOkIa2dB72Qe6EzFtNHz+AVPxx2zg7JmqSVdqnGUOiFlM8gkFGorHUoEsMdQJN58wPgXwOZq8BIO7TRbREJMzy6zZvr+CpbdB7FzFy7vhJ7V59Q9pwO9poaBCrk+Hv88IqY2YngpzeYqfaW8LoumxCEtogl+WFDRCmB9PsBsPJFgky/tKepxnvJpQnegHhpmu7qm0KKzUr9mAWXFKHb4GjxI0DV7mPhG8Ww+envlBGX4IUs8T0duvoyVy0MrQasGWHQhlbCC4vfuH9EU/c63ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zraI3G0PcSIbzaXtf8AMTbLDE3MVZIDr3QS1u6dOjiY=;
 b=nC+8tB35toEVSAXGeZfk4R7oEtnoT5b+eyw54JXjImZ5+v+b2L9tx48IJtG42u2rV8mYiyI98YtMLlTgeuP0TH0VGl2PECoZYXVunYmYFIqUEJChKUtgJ685RHdzOn7kB1Aln+wjVag+MpT/ZU/bPTsxf0cvUeJa1D63VwMIPB5Cf/Q6gUqCw+WPclc29aqBLUt7iszByRhXuhMN08EWCuOK82nF8vZuLEFgRS7YW68Lb0PWBLpJsdaMuWiQsfbEjZY9HB1XTQJWn7rROn66TUsIV3KoF5AtUylTjnLdN+UTKWDKlmcXeZMApcXAgscBwnFHhnaEcXTgkbeTYZ2lHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zraI3G0PcSIbzaXtf8AMTbLDE3MVZIDr3QS1u6dOjiY=;
 b=Iw4toqAnz+zG6QkU3lLJlFmnaX3Br36kMm19eeW+v/dDVKwr4TG7Vc7yxktXpAJ7LGLPFUeAhtbox2zaeKYqhL0jmiakCZ+qgdwWkFdYSGSF5Ku0c9wsXwAv76XOIkZexpr9OCev4SOfquu6M2a7MqgN8zSeYvp8oHC+IhyeQmulyVVSoKaFrXD+b337+XpWOVr65Lnsf5WZW3hEji0K0i48UOCGb8bHNP0VgUjxVCg4FOaCuwipqxhk7+Qyodbf8iOIKjT5Bav2hczjimA1CEHszRnPq5wj0OVv7dRvHLy2t+2ykyzh1SQvQqhe9PNp7+yCEnvYozsLpyliByA6WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6625.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:565::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 09:42:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 09:42:01 +0000
Message-ID: <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
Date: Wed, 14 Aug 2024 11:41:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: OF_UPSTREAM vs. additional dtbs
To: Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240813125245.ezlu6me3ljwx6dkj@margarine>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: d0cca2d6-ffca-4502-803e-08dcbc4558d4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2JXN25oMU9WSUdDV1NxV2lXM0kyeFZoY2JzZmNycUN3eUkrVTI5ZzB0b1J5?=
 =?utf-8?B?aDAvQUtOREpxdTRpSW84bUhyTU4vQ1c3KzRIb3pETEorQTVZdGVaTU9LUElY?=
 =?utf-8?B?UzFTaG5OaVNtcU9BQk9ZeVNKeGNSb0UvbElHSmJiSXBkeFFISmVYLzVBM21C?=
 =?utf-8?B?ZzF5dkdwakJOQjRWRjhkcG9pS3JyZS91SFYrQW9kc291QzM5U054YXlGWDZF?=
 =?utf-8?B?OVV6cDRsUWZSMEkyWUcrYXJNeEJGc0gwSXdsc01TaHdVY0lWbEt0emxmaW10?=
 =?utf-8?B?dHlwVmRGMkt2VW9NSy9wMFN5M3NWZWhCeTB2QXFuMFh5WG02K0JFYU1ZdWlu?=
 =?utf-8?B?N1NCQ21ZNWRxUDB0OTNJU1BmdDVkQmxkSmJqZjJta3NwY2FVdk1DdE1LVHdw?=
 =?utf-8?B?bTZUa1lQQWU3d2ZBbmk5WjZjK2ZUWHRIeG1YTTlnMnhaQ05STDhvMFdOaFBS?=
 =?utf-8?B?U0lWMWtUVU82VXhqRGlhdUJnQTVXV3ZYT2JlaVZEcXdzSU4xNzVQTWFFVVFL?=
 =?utf-8?B?ckNQTEpWODQySHdYQjFGYU1SVzd2eWY3MzJrUVBSVjNzVWdwYXgrTWdtaURS?=
 =?utf-8?B?dUc3NHdKRmJaWHFRU0htUmp5MW13d1Z2T09IRnU5WDNwTTVBTDZ0a1gvWDZo?=
 =?utf-8?B?YjVncnpNQ0x4ZmVRUmdzajRlblh6SVVUcE55TmwxNXZmZ1p3MEYrMElHOS9m?=
 =?utf-8?B?bFNoUHBYSEZMTEFTb1UyQzJJbTduK3VBcTJpM3VDc3cweXZjNWVkczd6SFJQ?=
 =?utf-8?B?SXJEZUpJb2M1OHF6VGRIMCtBb1YwU2NaVU1HeGdHdU9rNkdwNVM2ZlluM25l?=
 =?utf-8?B?TkIvaEY1NHdBTzU3TlRneDF4TENwUmQ3Wlh6K2ZkdVEvdE02VkNEbGdOMGtS?=
 =?utf-8?B?QWxtNitKYXBZTWFsNEtxY01WV2JybGVCQ0JQYSthSlZzOXlseUlGTVc5bGN4?=
 =?utf-8?B?c09MUmlQUFlnVkRrVGYxaWp4V1ZEbE9zMjFOZU1iR1EyNDR1Q05keVcrN0Ni?=
 =?utf-8?B?Vy9Na3gzNVdoODByaUZmeDFzQ1FzV3V3L0VCRVRTUDVTc0NudWtETVF6YTVU?=
 =?utf-8?B?NlJnOTJqbG1kV09XenJFQVo0c2xmR3RsSm0xVXhDa1pBM0hIaTJucWtHeUVZ?=
 =?utf-8?B?Q3pIMWx1bUp3SnFvSkZaNnFVM2U2dVVuTERrcmhKNzBsMGYvazN2UFI4V3R1?=
 =?utf-8?B?RnJkWEFSYTZoQSt1djFXbGcxekFMVVNvM0dZcHV1d3RBRTlWMUxOUGU2c24r?=
 =?utf-8?B?SWtFK3pBcmtHZ29iLzZPQysyWVFnOCtoemZSU0thTUR5ZVFYTytYWm5YWktV?=
 =?utf-8?B?WFRBQnZxK2FWUUJ6d0tsWmVyL1RMSkZranE0N3FaQlVFQ08vcWpuMmtXNG5n?=
 =?utf-8?B?NVlBNTI0TDRRN25SSWdnSTViNFVFNHExVEFxZDlxWXBJTENKaStnaGtpUVFi?=
 =?utf-8?B?ZEx2UVpwMzhOOTNsWkc2TmVUamdzUGtiTENWUjV5Ny9DZkpCQVV4V05QYTBn?=
 =?utf-8?B?TXBUVDM5eHEzbkxObnNYV21wNGNlK3FpYU9FcXRkdVpaVk5LdHZNQkdtZ21U?=
 =?utf-8?B?QllIVHVwWnliMmpQQnUrUE5adjRRbERYZE1tdG8rc241YkcyWTlyNklmWDNE?=
 =?utf-8?B?eE5YVStCK1pEZ29ScWVaKzV4S25QUEphWkNTWVI0ZWVNSEdmMW1OSElWNU9y?=
 =?utf-8?B?TzQ0SmxqTHhDMUJNRFgycE9CNWkwOUpKd1piZXN5VWVWaTB6UWJZazJYN0hB?=
 =?utf-8?B?cFZOdnJVWFpXdEVuUWtNd2FyeTlicEZCUEgzTjV2QmpyaXQ1Umo1empoOFZP?=
 =?utf-8?B?Y2xYOHVoSWlXcndXb290UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUVVci9XN2ZEbXFnQjlSemhBU2dueFlvUnlnZXhSNW9SUjhaRDdvNTlwYmRu?=
 =?utf-8?B?SXd6bXo1NDZYaUhlaFFwS3lZQ0NhK0VpeWNQMnFXeG5oNVIyY2VSNDJVYlN5?=
 =?utf-8?B?SHRHTEtYb3BMYUQzeEJSbm5NVEs2dDUwZkdoRTVSczFEeGppbHR6Ukt4ajNn?=
 =?utf-8?B?Yzk3Vk9iV3hXOHE5clBWbWtDako1bUF3T0IzQzlKd3hYSkRjZkwwTTBscmhG?=
 =?utf-8?B?MjhYbzZoWW9uaVRXa0QrZjZ3ZnJ5R1Q2czRzWndvRU1ISndadFF4c3NnUlFT?=
 =?utf-8?B?TWZxRDlROFFndnY4ZzBYek50UVJlaThLN0xuMCtpQzBXR21OdEoyK3pVRVg2?=
 =?utf-8?B?eCtsZmNRWjhya24wcUtHVnhic01Zdm1RcGRraUVuVmVVeUd2MDVpZVRtYlJm?=
 =?utf-8?B?NHBubDdnS2J0elZzKyt3dVN1UXFoNmYrN05qb3VhZ2NLeHR4S3NQUVNkTnI2?=
 =?utf-8?B?cTdjMUM4WlgrVzd1R2ZzbXhaWHcyYllIL2l0azJvQks3czJ2SnNKb04zRzRS?=
 =?utf-8?B?Z285YlRybXNXMzAvSy9qZVFRdVNwNTQrZzFtQkYvWGQ5Z3ZwUmRFclBHc3hi?=
 =?utf-8?B?ZU9jRW50REtOQjRQT3loYmllNFA2RVEzbTFMTXVWRjF0Y2xiU1NYQmFZRlMx?=
 =?utf-8?B?eVFxRXJaVVR2TGFqekNkSUYxckQ1aVF2c2JKKzdXOHI5UVdoUnVzVlpFNXAx?=
 =?utf-8?B?RndiSGNLNmxsYUdxelNHWmZMMVJQa21RSVRPdGIwZis4Rmw2TXBscFJ5Tlk3?=
 =?utf-8?B?Sy9mNTdoRFBLZnh3M1QvVnlOeHJmM3FiWjg5K3E1UDRLSmZIaGFDc2ZleWFh?=
 =?utf-8?B?eFJpNUxHSmU2d3JrSTk5OE4wN05oTUxrWnBUazdHQ2xjSzREUURLOXhML1h5?=
 =?utf-8?B?R0dVeWZBNDcrWnp6UzRnT1oycVdOUnVoemltS0ZCTHlzUmR2NDJZUGtmYWt1?=
 =?utf-8?B?UU8vaDRYaEpzWS9MV0kwcFhiU05DS2NacnFFbEQweXJyWHU3Qy9FOWQwMmU1?=
 =?utf-8?B?NEU2WUhub3hYRGR6QWkxUm9tQmR1Y3dNUGdwYVJYckduaW9hRnluZkpUaDNU?=
 =?utf-8?B?R25LVlFaVHI0Y3VOWDNZaWNGRVowbnlwUGNiRUljQTdGYWYyYXBHbnFQQ0Jl?=
 =?utf-8?B?WmFqRXczZi9ORGRGd2l4TjN1UDlmRmVmem01V0hLSFRZZGE1VFllcEo4dTN2?=
 =?utf-8?B?ZUZIdjE3ajVwcDBvTTZGQ1gzZkZMczlXRXZnT0wyalpHT0U2SEU2ZUNxTFF5?=
 =?utf-8?B?elBIT3YvRjBPTnJsVHBNejlaTjREbHEzNEVVdHQzemQxSFgvRHBrdnhoSXFV?=
 =?utf-8?B?R0FVdm1HcGNkZjVabWUxbUxyVGVURTkzRExLTjRXK3ZLNmRic2V3b2FKM3VB?=
 =?utf-8?B?OG9VenppYkloc0I0REdCcUVQak8vdE9hWW40b2h2R3RWbjZCRmZLMGFha3FE?=
 =?utf-8?B?aTYrRUlxaTdSWGlTVHlYZ2J0amQxUGhwS1FCdEsyZ1hjT1Z6Z2lDNTJWWVJu?=
 =?utf-8?B?Ynl3WndUcXFTc0JjK29yWDRyZVljak1vSmtjNFFsNGNDNU1kTjVmQ1VhdUZE?=
 =?utf-8?B?dExlS0lwNWpNTk40RnB3ckt6eDFMcnBOblhubVd1SCtpUXBBSkswRnBXZzdH?=
 =?utf-8?B?eWhFRzNPRkZ0QlpUWnlIMGFNL1JYcUkzekZwaUZyak9pKzNESThFeWk1RXVm?=
 =?utf-8?B?MlNYVHlLT21FdWhUQjdTOXljd2hmYnl1NU1tb0Jva2Y5aVgxZmFBZGc0dGZ0?=
 =?utf-8?B?eVRJeHJ4M01YTU5ZYnhuNU54WHhSMExyVzhYb1p0RVlyUWhSTk9RNGM2QTNr?=
 =?utf-8?B?dzlZbmtOKzlrb1hNYXp4Rzc1d0xUZzhWODB1MnNSbjdlY05IU1pWWjdoei9y?=
 =?utf-8?B?d0NSbmpkVTBKUm02RjMvL1kzNzg1djVWdHN5QTU2L3daZWNVQXNsckdHd1VI?=
 =?utf-8?B?eFErOGtsZi91cXBhNFJVdGUvclBkUUxrRU43VTN3N0NubXZQODBWNVRlTlEv?=
 =?utf-8?B?MmVkUjBONU5BU1gzYnpVT3NobkZ2N3Y0Y3JzNERkN0xSQUJHM2gwNzgwOVpp?=
 =?utf-8?B?MHdGeURQWEltSWZvSDUybWl0TTY0d1FWbGttb3liaXUzRVdtaXlrSGRBR09Z?=
 =?utf-8?Q?4U5JI96JkIuwIww6sIli26Jl5?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cca2d6-ffca-4502-803e-08dcbc4558d4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 09:42:00.9965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4w+oyRojIZy2FxIOdI5/FKkBCZ40PS0NoS6dhP6H1Ao/gl7r85WbcqpOMu3I8AnFZAPBVutVSa33U7iD2p0Cuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6625
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

On 13.08.24 14:52, Nishanth Menon wrote:
> On 11:16-20240813, Jan Kiszka wrote:
>> Hi all,
>>
>> I'm trying to migrate the TI AM65x IOT2050 boards to OF_UPSTREAM but I'm
>> facing issues because I need to still build the u-boot-only overlays. It
>> is also a bit weird (but works) having to specify
>>
>> CONFIG_SPL_OF_LIST="../../../../arch/arm/dts/k3-am65-iot2050-spl"
>>

Actually, this does NOT work: I just had a long morning debugging SPL
which no longer started because it picked the non-filtered dtb. The
filtered one ended up in a folder outside of the u-boot sources because
of all those ../ and hard-wiring to dts/upstream.

>> for our spl dtb.
>>
>> Are there means to still build certain dtb[o] files in arch/<arch>/dts?
>> I'm a bit lost in the Makefile forest.
>>
> 
> Sumit: Any suggestions?
> 

I would really like to hear some better proposals than my local
workarounds to far. They don't converge although I already patched some
core Makefile (overlays are building now).

Jan

-- 
Siemens AG, Technology
Linux Expert Center

