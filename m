Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A18FCE082
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 13:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E43683F26;
	Thu, 26 Feb 2026 14:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=weidmueller.com header.i=@weidmueller.com header.b="IUEMAOES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8215783D1A; Thu, 26 Feb 2026 12:59:41 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6373E83642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 12:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XW26yP2LeffBkGb8wXZREzDhVEAzw8rcZLUU1U27zAHOH8ntsSYtSFKnPpXmb/WI0ee3jTVHedUK9eoRwjfYntol+C8q9ktAQ0DWXQWV/sqZPzMKIpg2mOs1xbvG1peXiCSQBE8f9399XtETBpjZfjc0Srw6j1CHXS570oD6DF7kK8qWF0yhH8cRkMx+sudrmF9LpU6SYLjxMUfMEDwI6Yk6ptq4drUDldIz78+GWE5l2MRTlbtTILYsWst8Q65/JImOPW+ZcdEp7b3QO1MyloeTk8My6Sy/PHLUoAWB+moJh3ypJIXUOLOrFfQHyfOLwVC6SjwhmTt1dacutiSrwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVlhJOuGGGh+dyfKVYsm0l9/26TLg3+Uf2D+K6Q9wQE=;
 b=ps176KDmldKF+1zHR3EjUYlc0GgjmMuwxht7qUrQejktS1vNQonxy5F3UjDMCinXAvLznJzspMq1qShUKHWNsSmlLcA3RxGaijz55091NkCwVhUnQtweNvktmcVAk/8bCOlr9BcwpSyGdF4Xd5ztPSqAQtDqCFibM9HIsdjoQ0xbJefGm+FxICVsJ29H86VdUxIdvxyJ0dSdm8RKuUx7wtHU2M8k1PjqZw4PdOu9ar81G8/OrpA+fMmWskeQR3ljJimJVcvUEh0njHuLfcSdyl2im2NcA9RVltYktCZrOBRjbO02tK9UZNeoumPPows7MqLc/FRgig4+vvK1ok//mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVlhJOuGGGh+dyfKVYsm0l9/26TLg3+Uf2D+K6Q9wQE=;
 b=IUEMAOESoGDujTCFCspytqw1R7cRu5LQGeAfdUL0NiWGs863v4EY3RUjDStlKHHawsOHscSnRZh9kxw64OmK3iTfuffy09lMcmyfJHPckS1ymrOUuwLWilA8n9j+Bk3Re5DkV9lONGdDf2WV4rkWvHyQK6m9MRTi66fOa/+BvBIkVGvStHa0vpBWBuWFn0Cf2sEbChfKSO6xJX3NOQnhR11jvau7oFP0cW/EBdzeRHQeE4k8xrzVDyeHUT56qfFCMcI98g+IBelSgqIjklLez3ASrGliqAI5vzmakKyB2w9feiuLCaJaMu8ght20KqkKeKmKIUiKrIUSTg5b0GLotg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com (2603:10a6:20b:578::22)
 by AS8PR08MB6309.eurprd08.prod.outlook.com (2603:10a6:20b:29f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 11:59:37 +0000
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778]) by AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 11:59:37 +0000
Message-ID: <2c47184c-7bb9-400c-aca2-0874209adef6@weidmueller.com>
Date: Thu, 26 Feb 2026 12:59:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] test: fs_helper: Drop the size_gran argument
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
References: <20260225162357.3449937-1-sjg@chromium.org>
 <20260225162357.3449937-4-sjg@chromium.org>
 <20260225171246.GQ1593142@bill-the-cat>
From: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
In-Reply-To: <20260225171246.GQ1593142@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To AS2PR08MB9199.eurprd08.prod.outlook.com
 (2603:10a6:20b:578::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB9199:EE_|AS8PR08MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 268efd0d-5d42-40f3-42ce-08de752e833c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 8PqtRZvvu50ffQsX5LVyOOzUsh4NxEquh8BoxjI5fJJVLmx2GbPaPmwP0HNfabQ+Jzba1AtSJxNODKcYC/2bc2eBjiqn9FGcKHdwfGptoMGY3s+62Moz8CwwoLZRX6Bi06dSSp9KW/go0DJqzGFx16chMRYsUszynAcPnWyqeNCXjNicD4g533INLT2cPTq9EjD4QDLSwTZSqPbzn7xcGHxT+dBc3vFegIeuZWHO7zG8/CaxAM8iJZdlLNjNILEb1vUEWv6b0oQ3HSpQ02NfNXgw6rccxBQp2nvFW/1CqRyA8wrtfjAR0GfcwrWLvZNJVJb48joIx0iM+K/pAMqEz3jFwomC3NsFRwQf7jFyqvKa7fbQ7IDc+/moFOoEFRYmrJb/WZWc0iNOBybOdqLPwLocvOwXeFABAFlAKfNl8JmpgL9L/LXRprIqISr2LJu/biCPDVw1ShrlO4gUGAHkmKSUE2wfzB0SNQEMKagVt/5gnsGA0ey01OU+d3+YH5y78rw2RtiKKKURVHq9QVMT5sjKs5dqSBw0cmAU0pl417ySBZfHht/F7zsIHf5UnK93M0/4Cz+zLFof97jAweDZ1HFOPOL0jd7WKzNDcx9czgu0cn+cT1WkjEfNExPrlx9G/6cwI+AeN2sntKrXpKZZ0oJFBG/nBUzr8PgIHrIE8KSfb+xa9qDef/XtRwP+qVm7evdrf6xF9ESMrUNzMZTI80oygzS9Cq/VW1avdNewb+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB9199.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WndlWUNTOXYxci9TQk4raTNlNUI3N3dMQnFoeE1VTmFQeVlPeTBuT1FFam9Q?=
 =?utf-8?B?MlphWmxNaWJhK2IwZ0djbU1tK09VMjBZUitXK1ZucTk0VXkyZ3NuUUFOTHdy?=
 =?utf-8?B?Y2srVm9EcXhNL2RJNERFTmxtcUg4YTh1ZG1KRHMrR1RwdzV6dDcrWkFEaFZP?=
 =?utf-8?B?MkNEUUNTb21ZM0xiSHFHTGdyWWQwYjZLQ29CN2xmSzZkbUxRQVIvNjV1YWxZ?=
 =?utf-8?B?UGRCT0ZaUDZ1Y0xXMzZBZWJZaVZ6YjJydGg3NlJLbVp3cGFFOUMxR1lRRG5N?=
 =?utf-8?B?cjFFZ1dQUC8yU24wdEdzQ09iUHFLYTF3QlRvQ3NrV216NkJRTWt6ODRrWVV0?=
 =?utf-8?B?NmZWUlc5NGF4RVkwMGxvNnkzc2pYcmFXeXNMQ3dUQ2RsYnMyNnJoQkJLL0Iv?=
 =?utf-8?B?ZWVTMFlISWk2aUFNaVB5TnhzV1RHSmN4c0JJeEp2QnpIVG5Rb3o5am1hMmdX?=
 =?utf-8?B?OHAycG9lY3FVTnIwUkdkZVJ3VU5tU3p1emt6cC9DdnExd1d0TUxpd1Q2ZktR?=
 =?utf-8?B?VkhGUm1xQ1llN2I2QlJNYWV3NndBR24zdlE4Q1NiVUY0L3F4UVd1c1I2RzlO?=
 =?utf-8?B?di81d0pJNzFWRDMwcDRUS2lBRk9yVFB6Zm5hb0tZVy9xd0o2UDh1Y2tjKzVS?=
 =?utf-8?B?UkFiRVQyTU1QNHRPLzU3bytnYmdmWlV0WjcyZnFNK3UwUE9RYy9zVUxqeStG?=
 =?utf-8?B?K20rUTBHWDdld2lHVGxVQjJzdmNTWlJjUGoxOU5lSjNLQVV6OGNIQng2Ulcx?=
 =?utf-8?B?WUFPOTJYSWpqMGw2UFI2eno5OHBFRDRZSjNyeXZ6N3RqOTJ1ZFBaNTNOWWFu?=
 =?utf-8?B?Y3AveXBhb2dyVWMrbzhUeE5NWnpQRDV4QlEzT3FadHdwZUlNc1FxU2o1ckx4?=
 =?utf-8?B?eWpadG56V0FDZCtwdjVJenA0TGFMS25WVFh5SDYrb1ovdHR0blFSSUYva1RN?=
 =?utf-8?B?elo2VWk1cXh3WXZaMjZFL2pyK29IbkxGeGxrNHpzemtCRndWOHFJajhweXE2?=
 =?utf-8?B?WUlWWVdaNUduelJESExZbmc1dlV5OFJwUjVRby9Jclp6VllJM2xSTmRIOUI4?=
 =?utf-8?B?WXQ0UTdoOFJaZUliaDV1NEhQRlZUM0Myd2hNMzVTekg4Y0xCd1RwdnNLNENN?=
 =?utf-8?B?MUpkNk12cGpJSW1kOXVFa1h2SmlYVnRiVG5ZMVFjcEpYOUc4N0RmK1MwN1J6?=
 =?utf-8?B?NXNxakZFbkFSWCtOZmZDSlJlYVREVG82R1JTQVdyQTFiNGVhMDNrcEIvQjgw?=
 =?utf-8?B?eU9ESVBvVCszS3pjQzJ0Z0ZGQ084N1ZKYTJQdzV2MERCMjljMlJvS3A0b1N1?=
 =?utf-8?B?SWdpZ0pnRUNlZW84ZEJUTmsvbzB5RVNEM095elZWZkxYaGcwK283OG85bE5q?=
 =?utf-8?B?ejJ3RnlvRlplVThFWGRwZmhxaGVqSXpNSlBrNi9QTlZZVFNRN09leWpPVlA0?=
 =?utf-8?B?WUt0MWZmaVNJRk9zNy9qb0p1K053bzF5ajVvektOZUhyZC9hd3hRUEplRXVt?=
 =?utf-8?B?Q1huaWtCaXFRMU51S0VvbkV4eFdKQ010QXMvWVRMekpXUjM0TE5ZaEtXRmsw?=
 =?utf-8?B?UDBYR01aSlBCVXZucWNBNzFYNjB6WUhvVUlxOVBKS2NCVm9WTmw4SkFWSmoz?=
 =?utf-8?B?K2lmd29NS1ExM2g3bnFlT2FySURSS1RLWllqaWkzVnE1UVlPdk9RZmRHT1R3?=
 =?utf-8?B?SDZKaTJNRzVwMkdhTEJSRnFBY1J3WnlGWkFBMytxUlRudWVzMWNSbGNmdHFo?=
 =?utf-8?B?WUNVbGt0cXJBYTB1bHYrR3FNVVlubG5XUThuSTBnMC9OOEszZXFNNzZCUEt3?=
 =?utf-8?B?dS9CdGRBR1BxMHlVVlJ1QzNyZnlJc09rWlVQSmdKclJNK0ZFdndGdlZTd3My?=
 =?utf-8?B?MlVhWVd2MDFsNzFhZWd3VUs0eHF6T1M1OW44d0RJL1FCaW1nUTVOMG53a2FK?=
 =?utf-8?B?aE1OQVJzUmxsZWpVVGV5MnREWVFxRW8xZXpld1I4RUhXNVdmZ29sWU9KNVkw?=
 =?utf-8?B?alg4UnpHRkhlMTdDNm5PSURqTzNEa0kxUVFUeEh0TTh6YWtnNHhlMFl2ekVl?=
 =?utf-8?B?UlM1MDNGY0E1RnZVczBZMmlIOTFhVi9QWHVJVzNyUFRaTGl6TlI5V3lJcHJv?=
 =?utf-8?B?ak9oYWw5NEFjaEk5UW9BUlNJT3VId1crMGJaN1dmazNBamV1V1ljWEtDNzFB?=
 =?utf-8?B?WXVJY2JoRWdwNWwzcEgvdmN6MFNuWTZSTXpCTDJqVVpPL2FqNjN2enFEbDVR?=
 =?utf-8?B?eEJiWUNLODVZTTdKSkJtd0R3eEVRTkFuWDFSSjhwQS9udmJnNDJqTTdFU0ow?=
 =?utf-8?B?dFdCS2x4dlJPQ1FsL2F5Z3N2cEQyMERncWdhOENySWxkUm83ZzZydE9NTTVi?=
 =?utf-8?Q?7gXoG3o/+jxET1A+5nV3AO4feWlA5gA3tXZEa?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268efd0d-5d42-40f3-42ce-08de752e833c
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB9199.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 11:59:36.9951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Y3QHONkNvnkgB9nNe6mQNLpRGZ4jC9GIDzQ+SgCkroiDj1oTPbWjdM9bgsNBAVXCNvucHaBCf/bKjAy/BlU4Eox2lDFyEA1hV69ZEcoheLADbBXcw/U01YjYQMyy+im
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6309
X-Mailman-Approved-At: Thu, 26 Feb 2026 14:43:22 +0100
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



On 2/25/2026 6:12 PM, Tom Rini wrote:
> On Wed, Feb 25, 2026 at 09:23:47AM -0700, Simon Glass wrote:
> 
>> From: Simon Glass <simon.glass@canonical.com>
>>
>> Nothing uses this argument, so make it a constant for now.
>>
>> Also fix a pylint warning when checking for vfat/exfat.
>>
>> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> 
> It would be good to ask the author about why they added it and mentioned
> making 8.5MB filesystem images.
> 

Thanks for checking with me. Initially i wanted to write tests that 
create filesystem images that are slightly larger and slightly 
smallerthan the minimal size of a fat16 image. But these tests do not exist.

So i am ok with Simon's change to remove size_gran argument.

-- 
Christian Taedcke
Software Developer

