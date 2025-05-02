Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88496C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 09:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFC4281F7E;
	Fri,  2 May 2025 11:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="jHbFfGE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6828781FDE; Fri,  2 May 2025 11:32:56 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::709])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49ED681E72
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 11:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTcRZY0eVTvxkl6Hx49iiGueP8XPLhDtN4lIYQVyXCOL7F65OQ3MvbB1X7uS3AEcBQj7Q1A5FBNYeg5oc3GZliV4NYUL6s4MTynTu9Z9R7T93IPz+e2227E9dLlatp2s8enVZhQ5JGs8W0ZKJb4F5WJHRcnXMUWYFS2HCwsLLWzEPgrfL8a035bCM3r3lvR6h5EntKogIRb7m1YCt/EK1DIX9uxXBV9tNCVDiOh53Y+F4OWD8xDbov9eE17cZ78trNZNbi+PbZB+YzhGq+yXzbD3Oh/MfLHIEjvNNolVrvRjU7NQfzfiID2yzfbTeCSwwWCA3rgt9ZucoWsiK3yw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7x+dPmMWHwMOs7JV6M2B+b96mcAuCgQm54DKiqpYfk=;
 b=ScgS4jO/zlg4sSybTIGzmTD3ME859mtUJBwPfsqhr8P1j5WHwbgZv0NdOS1OWn5gFzQaITjP+xGJ7BtiEBgbGsRtW3PZRoyBdKaVGhZYxOWwUvN/yKHId05uwnoBs9TClYs4N6U+yI+oI5FC8F8TfDRC17V9rN5mg2+1f76Vx8Eoxsewrv6WnyXY+8KdFmNCoLc4ql3O8wQX52nDRMfpJYtknxnqAZb1wF+HB4j7frMenQ76VuWbU/oCdjldQyZCzZz5EP+5ObgwuiMonxgexr9QPzusQe1lo6gzyqpxl9A1LH5p6+46LZJMv8nsMQPQ+AoI8X2AFDVuUEa/ouw2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7x+dPmMWHwMOs7JV6M2B+b96mcAuCgQm54DKiqpYfk=;
 b=jHbFfGE/BEc53tkDFbuyJIqTtmxQjqppa0P0DRNOyYIYBYMhVRpWxjkIZcBQMVSJEAm0HiwTG2gH0JyUIqIaalQdMansPku1gDi1kJ3iQ2S7P3QAQRCyqPirI2uYLXbmJ+kXiMrHGJ6giFdzcq/IA3IJNPOiFNy5RtoVCursDGwtZut9il9Dgo4y1/xEWSxwdRLO2P3TdFMMehnd4YoJfoMTUtcRh7lozP7qD4pf+R9HSRLvz+3/ajk4xmBEYFW6fk8IrtYkxOjXNL11Ps7+FAg5hQM7Oj9wDRj/SFpF4NVjvlxvEfCSn+oRtGmR15/vt6ghY7dFI5jdpLGARl6T3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by AS4P195MB1813.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:51c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 09:32:52 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%4]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 09:32:52 +0000
Message-ID: <e9ff8b0e-5aa7-44d7-a661-b21dd2643d95@phytec.de>
Date: Fri, 2 May 2025 11:32:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm: mach-k3: am62a: Fixup a53 max cpu frequency by
 speed-grade
To: Aparna Patra <a-patra@ti.com>, u-boot@lists.denx.de, trini@konsulko.com,
 afd@ti.com
Cc: d-gole@ti.com, vigneshr@ti.com, n-francis@ti.com, nm@ti.com, bb@ti.com
References: <20250430104236.2611089-1-a-patra@ti.com>
 <20250430104236.2611089-4-a-patra@ti.com>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20250430104236.2611089-4-a-patra@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0310.namprd04.prod.outlook.com
 (2603:10b6:303:82::15) To VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:248::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2484:EE_|AS4P195MB1813:EE_
X-MS-Office365-Filtering-Correlation-Id: e8fec2d6-137d-4af4-9d47-08dd895c4f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjdiNWJxYUdwNEwxTmpGeWFKT3Jrb0djMXh1d3hDZGMvelhwK3F5a2QzbTRl?=
 =?utf-8?B?L3lxb0dMNGJkRVBRUEhHU1Q1T29ibk5YWHVtMkQ5b0dCYm0xUmZjN1BRV1hQ?=
 =?utf-8?B?L1V3MDZwN3V1SWhPRDdXR0pXOGhsaVNrZVVwdm5rTkYrN202UDVBYU9YWlA4?=
 =?utf-8?B?azF0NnhPTE1rMUlPK1RMRkJFMERhR0FXTkwxQUZEcUtKak4wMk55dm53ZVlm?=
 =?utf-8?B?UkhHK1BZZytIU1V4TkcwalJudnV1R0VZNGl4R0lkTzFHcENuMVlnb1dEbmdM?=
 =?utf-8?B?eER0MWpPL0hNQTdSUThDajlZNW1HdDViclJ0dllxSFc5aXR1N1FxT0pJZWN4?=
 =?utf-8?B?MzdrOG1NcWhlcnVsTmhJWG1ML1RoeGlpZWFpR1pFV3g0RXozYS9ndm1CU3RX?=
 =?utf-8?B?YjFPbHRpRllQZ2lnd3FQT1A5SW9sSmVIUTdrY05jd25FZDV5TUs3blJDWmdL?=
 =?utf-8?B?UUhqOTN3STl0U2dxWVgwbW1zb284bUNWaDZUNmdzU2xRMVBFSEgzK0JjUDNX?=
 =?utf-8?B?STJSeC9qZWFLYnVJaXQveWV0OVlwTVFWMkdNRExpSzRCMlVFdzlxVWhJSGh6?=
 =?utf-8?B?WmZUcHltbmQzZGJYWmYvUEFkRjBpODhYNDFTMklLd2prWXNPSlRoQ3ZKeTM1?=
 =?utf-8?B?ekhZUUliVmhoVStLdW9WRUp6TWprUjJqSUhKTEtzVmR3SzNzNzU0eStieE5U?=
 =?utf-8?B?SENTOHhnUStBUDBNS1JQR3c5T1MxOERYS044V3lHV25Sc0cvUWNhTjVyWmdD?=
 =?utf-8?B?Yittdk1tU3llMTZTWWNsZGRQTEZ2bFNISmhjcVRBSFArY1MxY2YvbEIvSEg1?=
 =?utf-8?B?SFp0dDE4b2JrSElBTGt1cFB0UUtQdFdIWjc5ak11RW1GdVdQeWZnclAxa256?=
 =?utf-8?B?aWYvWXJvT3BOb3d2S1JKYlFyeEUxWXRKKzNpRCtoTkQzQzhpQnZ6cXdJa0l3?=
 =?utf-8?B?blRvTTNYb2QvN3RHVmtLMCtuUXhieUVYaWp6czk5dkhuR3NHWituWnMvSkk0?=
 =?utf-8?B?aW5zam4wL3g0MXdVc1k0UGxXdU9aS1UyVjNtWFB1eFJCZ0VtOVlhalg4MVlD?=
 =?utf-8?B?akVaNFppZ2V4d3d5dzJ6bGlnVCtNUmxSVFA3U2VWb21JTjJENFdCZi8yY2NM?=
 =?utf-8?B?V3hWcndQb3B0NzZsa2FENkJ0YXNPbXJsZDVNQk9rengvaW9tWnhzcUJZd3BC?=
 =?utf-8?B?Qi9VYmpXWEM2NEFEU2JEZExtcDB6WWtVZXlEb25oVytVSFhrZHlwM1grUTJs?=
 =?utf-8?B?ZFIwM2pQL25kNnZoTW5RK3o5UDZkcEs2djF5Ni9HRDA3QWV5U1U2aW5zTkIy?=
 =?utf-8?B?S2UxOVkwdi9UcktucXB1RHhsQXF1bGdFbjRwTG5pNHJ6NkJ1bEpaU0d0TDNi?=
 =?utf-8?B?OTlRR3ZRV1EzVXB5LzRBQzY2MFpvRDM3R0s2TFNYUmVmM2hzQ0NkcEpQempY?=
 =?utf-8?B?NXFVRXpYT2o5SkEwTTlIT1AwbjB3VVpvcmNYYmt4SEhJM1hVdWtjNFRnWFZs?=
 =?utf-8?B?SVBoTWtOVW9SMUpWR09pREN2VHp1djRRa21lNkNNNlA4ck01YnVpZHE1Q3Bi?=
 =?utf-8?B?R0hlUGZCQ1llaHBwTHZuYmhicFNpYVNZZ0s4OSsxUFM5eEUzT0VQTCtLOE5X?=
 =?utf-8?B?ZWRXckZ3L3ZyeDZueXg1Y3AxZVY0VHhjUldXZnRKd3V5eGxpR01adWJJZ0VZ?=
 =?utf-8?B?L04xM3JMTHNGbFBsbElvbzY0L3czTFVtL2xCQzRRT1RtRHppRnZXVXZiR0g3?=
 =?utf-8?B?Y1I1VFVXNzBKOUtURFM3MDB2dmZGNEdxSXRQU1hheEtrNGt6cVV1Uzd4N3Jv?=
 =?utf-8?B?TWs2RnhEbitIV1JYcTlMZ3U5WW9yWStFM0pWRWtvWi91VUd2QitKT3Q2eUo1?=
 =?utf-8?B?bkN2M3MyOWJSdGFGMUxlUFhxTCtQOXZQUStJVWpIclN4K3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFhrd1o4a1NVbVk4d1pVMWY3YUgxdHVMS0hmUW4zNFZCcWZ1UkdENzJLbmo4?=
 =?utf-8?B?aWtPQjZ2QmYrZ0F0U216MjJZU1V1MEN3QkpxNFUwZ1lLYzlEWFhLb2NERDZB?=
 =?utf-8?B?eE5XS3pETFVGTnZGMG4ySm5ISkFHa3FnS09WVkpZMlNjbGRTZUs1RWx4SU5i?=
 =?utf-8?B?VHUwaVlOazAxSGx0ZFh0My85eEd4c3pNK05sZjN4KzEwVVlGT3VWczR1RUNn?=
 =?utf-8?B?VnNsUVRZRmF1VmUzUVhqY2xaOTR3TkNvcGY4aElVejhqZURQeVJaR0I2b05z?=
 =?utf-8?B?NEdaKzFodHZkNGJEbDJzQlVhaHhtNUtlQ21rcmhSRDdadkpTS2t5ZFRRNFZZ?=
 =?utf-8?B?WHltQ2l5d04zTmRWSFpiME9KSkVZYktGQVJBcHU5QlJUbTUyRHRJbnQySExY?=
 =?utf-8?B?UmFRMlhuNnBXVm0vUjB2c0lyeEtkS015dmNFTFZoTFBCcmZQRThJL3NYNlR3?=
 =?utf-8?B?YXkwQ1g5c0Q0eHd4VnQyS0plYzAyQzk0YllpZEhjZUd3Rk1TZTFic01YbEYz?=
 =?utf-8?B?bndjQzBWb2kzYm5WMWFDckd2S0dtdnVuNlM1dGttTWE2Ynp6TE93Q1BCTzgw?=
 =?utf-8?B?eWZlcEFScDdDRkdmOGhZYnoyaVRpWmtFZkFmak1PZ25Ca21XWkhtUFZ4UzJu?=
 =?utf-8?B?bEZQbktMbXRocEk0TkpCSXorS1ppU0JjZ1BKbWc4ZVBEMGxOR2w3RjhTZXp2?=
 =?utf-8?B?UTJIRUZnVVlsa1B1azRlY2NCYUVud0FNbDg3bWZ5OERjNy94akJFNE8yMWpR?=
 =?utf-8?B?UVZWZ1JLY0FsMVQ4T3p4eFBwSlVWaUVneG9XS3lFQ08xbFlqeDJPN0I5S1Qv?=
 =?utf-8?B?cU9nZnV4blB5YlhUUnhmaHkwYnB4VFVEMXFJbmRNcFc1Qnh6NzRkcUl5NFE0?=
 =?utf-8?B?Y0hkTzRURGJGNFEwNy9PUVV4dWs5NWZtSWp3Z0pIVDVJMmx3RnlsRDlMYkNY?=
 =?utf-8?B?a0Z0N2lyc0kvNnlxSmxIRnJ4NkllR2piNjBwTDJvY04xeHFnSTlIRjF4dXYv?=
 =?utf-8?B?SzhxUzV6bXBmTFBCWGtaVGZ0MUc0S1FHdjRQRm9DQmMwNlBnZXVVMzR5OTND?=
 =?utf-8?B?R2FGNVlPa3BOd0tzRWhCaGNIMnlGZkVwZEpVYzErN0dzT25DSXB0V3Y0c0hQ?=
 =?utf-8?B?RjBsTGkzQkhzbjRhbU40VTl1blVuSG9OemRCYWluRWYwa2pvWEp3M2VQdnFK?=
 =?utf-8?B?WTVMS1I1S2lJUHJYRlhlbkJ2L0JlMVBHaTUrNXVLLzVuL2VwWm8va2xNVTdh?=
 =?utf-8?B?Uml3K0REYStJbnc1YWpGYWhIR0tOTUdsSkhZYUNreDhaZFQ3Z1I4SG9ZOXpx?=
 =?utf-8?B?eWtpRW81UFlML0Z0STBzYml1OSt6cmU2M2tjQ3dwUTFiWHNMMkRoZmdnbGlR?=
 =?utf-8?B?TkwzOHlsZnlHUnJSeE5xK1VUWE1PVzJSOVpOd0MyazVqZVJCdkZwSllVaFdI?=
 =?utf-8?B?WDBHMDlSd3Uzbyt4ZzhZL1lFalBVOGV6eGo2OElIQW9wSFBLL3RHcUVRUHJ4?=
 =?utf-8?B?c3JrZ0RNd3RwRms5dWJaVEI4TlV1Y3lCQUJRbXBVR29Ja0pCMXRTYTRoSGx6?=
 =?utf-8?B?bDY4cE9SWWw2aFE1eW4vdzJ4Q1NOckEwSEs0N2FHQW1uZ0dPWVhBOFFxRnVF?=
 =?utf-8?B?bHk3dUdXaWduL3kwcllOeUNVL3VBcHBqY2d4aGRycmlCamhqQ21sUU0zaUFE?=
 =?utf-8?B?OTI0SHIwUm9YQURQckJGQWNsQlFRSVI1L0VJU3Rob2pqcjlGd1NzbWZ4NW1Q?=
 =?utf-8?B?a0JlZXJ4SHJuSldRbVFwbHVIKzIvYWVDZDF0dG4yMENVWmo2Q0VZdm1VNVdr?=
 =?utf-8?B?emhJbU4wencvOWcrcmJBR2NUa2J0a2pWYkVlQlpybWt1VnZ4c2VuSWlIQ1F5?=
 =?utf-8?B?d0EzdEQ3RmgxZCtZbURXV1F4dFlUR01UM0xJT3RyTGVhSTJOYmptRG5hbWZi?=
 =?utf-8?B?aWowYTFKK1UvRVk1bVNNUG9pUGxYKzI4Ulhia1VEY0hROGM4dGxSMEJnVVNy?=
 =?utf-8?B?V2p5WG5EbWhXZjhoQkplN09GNnlsbzU0SlpVcGR2akQ3TUZQSkJHYlR5Q0o1?=
 =?utf-8?B?aU8yVlpocHVTRG9UcmZoWnduRkdHOGlGbXp5V3BLMjgrNTljSSsyaGtkUE96?=
 =?utf-8?B?UVVib01SQWQxS1RkYlFaQkVUK2dmSU53Y2VEbExUaEtuT2loOWZTNmlsSjJH?=
 =?utf-8?Q?95LYU85HpR4ZGdV9IodNp9CbpuQgXLDf4Dp7GehgddVk?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fec2d6-137d-4af4-9d47-08dd895c4f63
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:32:52.2370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKSz9QyJYrFdDFYV/cyPKv2hEmQNA5ScACuKKfBhx+21kIBqU2GzXafFRcAwRjWQDd3aRxnb0Kjj9BL1VufIQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1813
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


On 4/30/25 12:42, Aparna Patra wrote:
> AM62A SoC has multiple speed grades. Add function to delete
> non-relevant CPU frequency nodes, based on the information
> retrieved from hardware registers. Fastest grade's maximum
> frequency also depends on PMIC voltage,hence to simplify
> implementation use the smaller value.
>
> Signed-off-by: Aparna Patra <a-patra@ti.com>
> ---
>   arch/arm/mach-k3/am62ax/am62a7_fdt.c          | 14 +++++++++++
>   .../arm/mach-k3/include/mach/am62a_hardware.h | 23 +++++++++++++++++++
>   2 files changed, 37 insertions(+)
>
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_fdt.c b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
> index 40833ca392..9526c5b255 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_fdt.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
> @@ -81,6 +81,19 @@ static void fdt_fixup_thermal_zone_nodes_am62a(void *blob, int maxc)
>   	}
>   }
>   
> +static void fdt_fixup_cpu_freq_nodes_am62a(void *blob, int max_freq)
> +{
> +	if (max_freq >= 1250000000)
> +		return;
I dont think this if case is required. Just let if fail both following 
conditions.
> +	if (max_freq <= 1000000000) {
> +		fdt_del_node_path(blob, "/opp-table/opp-1250000000");
> +		fdt_del_node_path(blob, "/opp-table/opp-1400000000");
> +	}
> +	if (max_freq <= 800000000) {
> +		fdt_del_node_path(blob, "/opp-table/opp-1000000000");
> +	}
> +}
> +
>   int ft_system_setup(void *blob, struct bd_info *bd)
>   {
>   	fdt_fixup_cores_wdt_nodes_am62a(blob, k3_get_core_nr());
> @@ -88,6 +101,7 @@ int ft_system_setup(void *blob, struct bd_info *bd)
>   	fdt_fixup_video_codec_nodes_am62a(blob, k3_has_video_codec());
>   	fdt_fixup_canfd_nodes_am62a(blob, k3_has_canfd());
>   	fdt_fixup_thermal_zone_nodes_am62a(blob, k3_get_max_temp());
> +	fdt_fixup_cpu_freq_nodes_am62a(blob, k3_get_a53_max_frequency());
>   	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
>   	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
>   
> diff --git a/arch/arm/mach-k3/include/mach/am62a_hardware.h b/arch/arm/mach-k3/include/mach/am62a_hardware.h
> index 0ec04a72f5..64e4a379fa 100644
> --- a/arch/arm/mach-k3/include/mach/am62a_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am62a_hardware.h
> @@ -28,6 +28,8 @@
>   #define JTAG_DEV_VIDEO_CODEC_SHIFT			14
>   #define JTAG_DEV_DSS_MASK			GENMASK(16, 13)
>   #define JTAG_DEV_DSS_SHIFT			13
> +#define JTAG_DEV_SPEED_MASK			GENMASK(10, 6)
> +#define JTAG_DEV_SPEED_SHIFT			6
>   #define JTAG_DEV_TEMP_MASK			GENMASK(5, 3)
>   #define JTAG_DEV_TEMP_SHIFT			3
>   
> @@ -144,6 +146,27 @@ static inline int k3_get_max_temp(void)
>   		return JTAG_DEV_TEMP_EXTENDED_VALUE;
>   }
>   
> +static inline char k3_get_speed_grade(void)
> +{
> +	u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
> +	u32 speed_grade = (dev_id & JTAG_DEV_SPEED_MASK) >>
> +			   JTAG_DEV_SPEED_SHIFT;
> +
> +	return 'A' - 1 + speed_grade;
> +}
> +
> +static inline int k3_get_a53_max_frequency(void)
> +{
> +	if (k3_get_speed_grade() <= 'N')
> +		return 800000000;
> +

^ empty lines where should be none in this function.

- Daniel

> +	else if (k3_get_speed_grade() <= 'R')
> +		return 1000000000;
> +
> +	else
> +		return 1250000000;
> +}
> +
>   #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
>   
>   static const u32 put_device_ids[] = {};
