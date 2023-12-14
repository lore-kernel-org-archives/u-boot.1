Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B17C4167D
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D14D287B02;
	Thu, 14 Dec 2023 18:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="UuiX5XRD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3773887B03; Thu, 14 Dec 2023 18:36:49 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2269887AFF
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9OVdad2nlnTAZGd1nKtWmsmbp+8ydQvTyWJXqy6pqbZ/1Q3+8lTntAtcmgdrWpUTtw12l/Nv1r/5dL7nHu3UUZyDbt/E1ndHfN50YYTw0XXY1Zs21JF2OvhJhlRD0qiRzaSVz6Qu5IObQiaJQXRh4Hnjy3km0ofDcVhLo/t7IMkMetM3fhZb2Q5jqST9IXHh65oAUlL9e8IwOJeZ0an29W74KYwaajyy6AhaJNR1VfbIJSlZrlLl1bVp01ABFFS+XMPuED3oDkygwCekMJI7t5LCx3HLRzc6OvO3dlnXC6Y2wrqGeHYjfXGrnmEHDcktjqWEM4yeQOVzECttaV85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgCcEGWmsH4OiPtvL3IRAvc1WsFmM3INj6exYj8MW9M=;
 b=ecMFT0laWbt0Nv4u8HOlxp1xw7zkXY5CA/Cl8AFiLUsW0D0mdVDEi4bHJUgpCDzLp+GAlySqSMX+EnXWNWZvDQlce8xXnjS4GebFo1DOtnVmzJrZsyWanovpqarXvsV0XoO4rrqm0G6Di08jLAI8p4Nyff+DCT+CVje8upUHcELzr4u75Q36y2xBLPlItvYdlobKXk9fJBkBPa0d9Mt3LIjfTi3joEuPw/tObz3b7qbSQOvotgWj3ksI2bgEKujSsyvWhJiJIO2GDjIYlADe+HhOgfLe23EP/erRkoyxG708TUR/GMN7g0+rfHB3pzBL4LE+wCYG0N7NfR/4mVXAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgCcEGWmsH4OiPtvL3IRAvc1WsFmM3INj6exYj8MW9M=;
 b=UuiX5XRDg6XJ/usiRYS0QreE6dVingK8jYvGN4cyNbJZ/0sxwFazDCqWfL+gsFOOkX0deb4z4e0/RMSB/j66AKiXp//SNMC3+yF+3oO4UQ5j+Rcbdvb5rxX4iQWPOo0V4o8uHBiL/8mFeaNQh9JdsV+u12tiQmrXjR1bOVxffUgzqIqi7tlQdZtf5xD27DOoWt5ZcBJqan0Zps6R+4/6qgA8/51j2xfENdNXw7MWMCIg5ON4K2hfhILeD6a6dTRoejwnqGV034KBpJ/52YWHaRc3vhb2BZK06/DnRd+GN2RRwXcux9uVHdlgE0Q3zeRMVzAc1vgGKZr4ekxh2EoLiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:390::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Thu, 14 Dec
 2023 17:36:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 17:36:45 +0000
Message-ID: <826603ed-9cb5-4c24-b63e-34dceeeaf4eb@siemens.com>
Date: Thu, 14 Dec 2023 18:36:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence-quadspi: Fix error message on stuck busy
 state
Content-Language: en-US
To: Stefan Roese <sr@denx.de>, Jagan Teki <jagan@amarulasolutions.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
References: <856ada64-ba6e-4f32-bbf5-23030df85238@siemens.com>
 <2f42b8da-118e-45f2-a76a-813bd034e693@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <2f42b8da-118e-45f2-a76a-813bd034e693@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: de463f6d-3e0e-4fe8-78b3-08dbfccb3e36
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHeIEM8ZEREr7Hxb16rvLqtemlOEnO3ixBu2uLINc5NnXdTH+G2gnBEAnB4ovHlMeG5m1Xhg9U0ho27zs9Oxv9fydn27zZ6KS7BLG7sxugxzGFUFJs6fL31cZNoXrVkI0AW7kamZxiCcWgFNgCs9qSK5Xk+H0oxjC+tNCZZ+HxPA1MLeUxYLiEvxvBMC8PZdH1OJIzJJ0cL0vTBUC+raeBkitxuE/pFwnlzkLyNGviUn5ETQogTfHgmm/sqcqa76Hpt9vVzjfCkToA31uscLtsNMBPe1j0buMSTTJmYc/9P/PiHoTtzYIRiWsJ4PHH/FciocbcfZsF/5YbyY84bqPNAVTevQ+JtCeOboJt+VsxS308pwvIYcDFOidBM69XBZWJV0PgrxyQQUsyIG5ntjR4dVYCFaMBDXC3OZ3q4JsRCYW17f0KeXm013KotidXplrNMquEGgplwIkRW/0wNwDkjI6z22gR/2Kx0S2F5ahNeQe31JiyhiuMQ04HAOJaVwk/oJ85R60vL/qv5OMtneYEhLfMy1COrhVNAhlpDE5wCvwvFD8f8CUBE5pGEKYFBLhKcyvziPj096uzLkJ5VDugnriiwMqypy6X7tLxIkOuu+pyevCywfgJ36KUZ9tpcbLs6Mo2cK0QCRJPV7lMhjDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(2616005)(26005)(107886003)(82960400001)(31696002)(86362001)(38100700002)(36756003)(6512007)(15650500001)(83380400001)(45080400002)(5660300002)(6666004)(53546011)(6506007)(66556008)(110136005)(41300700001)(316002)(6486002)(8676002)(66946007)(44832011)(8936002)(66476007)(4326008)(2906002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVN6YUk4ZGhPZStyUis4VnhzT1ZVOWZKa0hCdXkvc1Q0SlBIWjNrR0l5b05O?=
 =?utf-8?B?Y2hlL2x2ZG91RmN3M1VDTnR6SzFXSGhudGt1ZGdQQW1lY2JFT2pPNWQyc1pm?=
 =?utf-8?B?N0txVDBreXQxMEdwMmFnTm94ZDNpcXc0aHdlNjRXT3lIK3BCRVNkNlZnY2VM?=
 =?utf-8?B?SGtraFdENnp4U0c0Z2tzRmh5bE94UXhkTEZWY2pDREVCWk81bVFiU0lUeElS?=
 =?utf-8?B?cVdaTWQ2UHJhMmF4M0lzOXRONXpCQldNdDRQNThWSEp5SzRhazhrVlZaMndJ?=
 =?utf-8?B?WFk2ajgxZjd1YTFYak5JYjQzT1cvdExFZHVPT0k1MTdGYTlidlhISmsyUzBK?=
 =?utf-8?B?T0swM3NSUzlXTG4xaDVPa1k0bEljd1YzZCs3eTBjS21QVFMrbk5OM3I4U21N?=
 =?utf-8?B?V05QVUp1RVc2R05qb2Nic1FyQkhvbEo0VmpZdVd2OGFnOURJdTQ4eTN0bVFk?=
 =?utf-8?B?eG0xemI2Qm1ZL3BTekF6cC9GbEo1di9zbTQrZWxlWEZXbWpnblNvRWhaQU1Z?=
 =?utf-8?B?a3hDakV6cE9ueDNSWUNSVXhNQVlpR0JlN3Izekx0MDJJSnN5Z0wzOS9aUGlj?=
 =?utf-8?B?ZGdBTytTRW5MaTN6MmdUSUZGN0RFQUd4T2hVUTRJcjBqa1JTQmhERmQzYXdq?=
 =?utf-8?B?TjRWR0VoWlNxTzhCUklveHRvbisrNE1qWVZ4R2FQYWNMWXNNdDdZWWJWbmlF?=
 =?utf-8?B?a3k4LzJKMUlXUG9rWG9nM1IxLzUyWkxzU1hnb3Z5eEIrV291aFIwVmlwR3hR?=
 =?utf-8?B?Mk5UQ01XSldZNDB4RUI4T0MzRW9MUXcxQ2E2azdjT254UHVhbEk3b0dKR1lI?=
 =?utf-8?B?ZDVPZWRheENSL2diMkdlaWJiNzZ2V04yNm1vS0RzQkhySm9MWjRqWVpQT2dR?=
 =?utf-8?B?QUhSODdpNStZMG01RlIyUkt3bXZNc0ZiM1pPb1g4d0hCLzVkT2ZLK01JMncv?=
 =?utf-8?B?ajlsOEVTeVhNNXVrN3BlN01wMm8yNzJhWkpCa2lXQmZyUjhMZU1ZT09vcCtW?=
 =?utf-8?B?OTZNZnJjVXdWTXdRc1UvTjRIWGMrSGpnZ2RkczNoY3p4cmlLWjEyLzBOVDln?=
 =?utf-8?B?aTVGbmNhOUg1S2oxVUl2UU9IbnpwenVNQmUyaWUxcWlzWnlLYUNmeGVhaWgy?=
 =?utf-8?B?aVQ5UWgweG5VeHlzSFRqZjJlUkxXYzUyYjFhM1hsT25pbUN3TlFBdEJLY2VY?=
 =?utf-8?B?V3pudEtqU09vblNseGhhUHo0VnFYejRoU21PQ0MxQ3doMDNZMzFzeU9WMVEw?=
 =?utf-8?B?RUpUVnFuZ051RFpubDNBOXE1UDFxZFJiY2x4SWpGLzQrdUhIKzdqNWFEem9W?=
 =?utf-8?B?K21qZVQ5aW8yRWJpOGU4YXQ3Q2ZpVElLcGM0SmJQbnNOS25vL2JvRE10SXBO?=
 =?utf-8?B?a2h6WkRDSCtQYU96eHk5NDZWRmlqUDhwSFR5TklNc09XWWVNK21HZXNYU284?=
 =?utf-8?B?ZVdRYUV1c2d6VFBhdmNadXBrd1ZiWjlHTEJreHBVVC9IbWhwaVhSdkxkVzFs?=
 =?utf-8?B?cCtIQTFFdkNwdlh5V2pJVlFJNk5HajQ4U2Q4OHo5bzFMMXhLMnJuTTFHaG9o?=
 =?utf-8?B?ekk5ckFKV0k2cGxodTIvVEowWm1HSEY3NkdPOTlaTzg5dkxVeVZGa0g0bVFl?=
 =?utf-8?B?Sy96V3dONVcvRm4wRUVKekt1ZEN2K1pDalVhRTV0b1R4UzlCbFBnOWZodmtM?=
 =?utf-8?B?LzR1VjFMWlVTYmhjcUpGcS9KWGJua1cveFhPN1IxZ3RzUzZZYnRiWHVvQktC?=
 =?utf-8?B?OUMvY3Zkc3R1VHJxSjhYZEZwZUFGQkdmNkJobWRGcTFGMFVWNVc2SVFTOUU3?=
 =?utf-8?B?ekowTzNyL2lkaG05VkdzS1ppTW1uZzZaNWtkRC9NeUswWEZVNERoZDYwMUlu?=
 =?utf-8?B?TVhQZDdWVjBROEoxTkxMQzBUN2pYR0dsK0o4RHR0QVdDa0VkbGNBYlJCWXFS?=
 =?utf-8?B?bDJMS0QwRHBsZEwyUXNsRGZXT0Fod0Q5U1Jwak13LzNpZkxTRURhdjY5QVB4?=
 =?utf-8?B?azdlTVVnR3dTWHc0Ulgrdno5TStnN3N0VjVFWlZTRThjeVZySVVjcEdUeTdH?=
 =?utf-8?B?dGFRYURjYXVpdFVIUU1sSy9zdUFxbE1FVVp1UVIxdm1lb1JpbjNRNzhlWkJB?=
 =?utf-8?B?OVRmNUNYYTdFOVJsV09wUUxqMDRDaFIwVDdXR1FiNHVQNGZXaXlNck5HRlY3?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de463f6d-3e0e-4fe8-78b3-08dbfccb3e36
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 17:36:45.6648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/sl2kaHA6NxGQ1Td2zrOIeDCVSw0zyUmrVmx5mNqj8+uiLvhKhrWHDgPvudziU0o/Eehk4xlOKjnrHwt4KEIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8186
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

On 31.10.23 08:14, Stefan Roese wrote:
> On 10/30/23 17:20, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> We are not iterating CQSPI_REG_RETRY, we are waiting 'timeout' ms, since
>> day 1.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Reviewed-by: Stefan Roese <sr@denx.de>
> 
> Thanks,
> Stefan
> 
>> ---
>>
>> We are unfortunately seeing that message right now, rarely but then
>> prominently...
>>
>>   drivers/spi/cadence_qspi_apb.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/cadence_qspi_apb.c
>> b/drivers/spi/cadence_qspi_apb.c
>> index 9ce2c0f254f..d033184aa46 100644
>> --- a/drivers/spi/cadence_qspi_apb.c
>> +++ b/drivers/spi/cadence_qspi_apb.c
>> @@ -171,8 +171,7 @@ static unsigned int cadence_qspi_wait_idle(void
>> *reg_base)
>>       }
>>         /* Timeout, still in busy mode. */
>> -    printf("QSPI: QSPI is still busy after poll for %d times.\n",
>> -           CQSPI_REG_RETRY);
>> +    printf("QSPI: QSPI is still busy after poll for %d ms.\n", timeout);
>>       return 0;
>>   }
>>   
> 
> Viele Grüße,
> Stefan Roese
> 

Ping.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

