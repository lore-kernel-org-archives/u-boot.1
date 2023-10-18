Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5BBCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 09:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9605864D4;
	Wed, 18 Oct 2023 11:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="X8LQU+dV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D2C986F25; Wed, 18 Oct 2023 11:00:47 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9474F864D4
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 11:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW8nnJB3I0HAAcxQJ6fa8cqjMw7Vl2EY1hmLFeLKXneyl0yvAuSs1+aiEXWysCnFnfW9+XeM9hyC8IVycsnjpW6PFeogB8kx62YdQZjFElSZ47cNreg0XhyIKdW59OB7g7znEghrjemu0k1YVnYTSYUsJOlWJKdS924e8Wa377T9xe+6DhwkJ/bBabxyQ7C4KU/uKMDpYhf0XwzPgR4M8IUh6pHsspmqEGPwidVhdRlMjuLjAFM7qZtcgFc2Oo5z0DQJ8jnNmcNLctboFgmA3Gqlsoz1545VLK/RaGkO8kGmzkz76OSfzdkCY83F+LoCZYAy6vBijRtp/WnP78sqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RC61mm0Ef/eRlvtORTaTIUXLPZPrZg8m2Oiw22S8juM=;
 b=KZfLQYsBp+SX23m08iPsrQXRyQjCqju2OleQ74tKLBqBTRhR0Zax+ompusSLCJGnCeyAcp12fKV/x828Q9pAqfYSBCY/3v0n1h/vXbcXNAKiZuFJGsYewgD8sJIQKOyOD54nxc3tevB9ZXPrFnaMAy3aYlzVkP+7R7Mv2OITqbOai35nwHI9PQJ8G2mEOLq4HLF5uAtX3KtkKSlsDCmOzxePSLvEzESK0jBlVJhOsWlqpW2m0YAZJeSDM/FT26VfnBiN+f7q10TL8htDmosR6MWGvxXDoFvy3NhxWWYoWg3jIh4r7qZjnvoCXIfGapwptSlj4YeX6UzRGDhEZf3AEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RC61mm0Ef/eRlvtORTaTIUXLPZPrZg8m2Oiw22S8juM=;
 b=X8LQU+dVA/e4iOZMUPiXz4L7RuRybBVCuXSbuV0A8W3bW1qQijkUb/jTiiPZP22JC7ZiHVhO6gQi49Xsjtz8g+DUiiUXFi2lW9ShU3qrCuitX0QMjDHKPwWaYEGYFZc6W9a66zKasmsAXwhK6udj22NX3orM7zQydONhT3Zw2Zc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DBAPR10MB4010.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 09:00:44 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 09:00:43 +0000
Message-ID: <edd95b65-5944-4b52-9c32-4c51ca523841@prevas.dk>
Date: Wed, 18 Oct 2023 11:00:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: commit 83c63f0d118 (led: Move OF "label" property parsing to core)
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Marek Vasut <marex@denx.de>, u-boot <u-boot@lists.denx.de>
References: <d588fefd-45ec-4642-bf6d-73fcc652591d@prevas.dk>
 <485cdc88-6898-43b9-9079-f9fe58e26848@denx.de>
 <83bff57b-6d1e-4e31-9286-f32c60d6b052@prevas.dk>
Cc: Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <83bff57b-6d1e-4e31-9286-f32c60d6b052@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0092.eurprd02.prod.outlook.com
 (2603:10a6:208:154::33) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DBAPR10MB4010:EE_
X-MS-Office365-Filtering-Correlation-Id: 7637d1b1-beb8-493b-9cbe-08dbcfb8b5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pb2fTAHY/QtTJr4xLzXEF6G9KNp1CgziSX1UPNkbjNlBg803negvI6NH68NaXHM0kcYWFut0cp/SCv1QyIKcvWaABu2W8w/uqfup2b5kv0aL1VhHa8L4NLRoAo2M5KANMIE2twgr85KWyF0WAz1kFIyA/ClhQtqtAyeQpbg/wC1u35dE75xfqWVCO85uy8yom6Hfy+IAQks04vOeMeeV612q6Zc/1NA5au83TD1I6HHPCvE43uGKrzABMauNinsu+cU8EaXACjYyINKDUkcOlIDNiVGY9VEHKPurGzSpoZcXXcgfEWDDbxWa0xH5K5jOutL0hknYp39hNIzdr60soc5LCEnRXaOS5kQs85COvqjpuEqWQWAf1yeW+nOVU3TDT/WeF/8XdEeNynnLd2SK3Z94QkW/sbj1KgxEMDwKiUS11W7HWATLJC0SFTdzv5SokiEAxytMyU0F5USeRa9k9kKwGxsm8wNrcR3kddzSd3RJWTtrU4EY+FljypDglE361pGnyRL62eEukeF1UOr4NjEZqn/VjBH/eKa0RCWdmcYthHMXKzZ6gBw3/2J7LC5aRvfWZZO9kc3y1ZEv6ClcYhmRZ/T4zNM73x8n1CfmJM4OpuvMlQaMf++yzM/cju347m//ifGG4tXqH8U91cCFKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(136003)(39840400004)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(26005)(110136005)(31686004)(6486002)(36756003)(38100700002)(316002)(6506007)(2616005)(4744005)(66556008)(31696002)(66476007)(66946007)(478600001)(86362001)(44832011)(41300700001)(4326008)(8676002)(2906002)(6512007)(5660300002)(8936002)(8976002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEp4eTBsL2RXdmdoYTk0bzZIK0VYOVRxdE9hc3lHL0wrUWFPOEpYdHRTK2k4?=
 =?utf-8?B?dS96Tm1jQkFVaTN5ZEgrbk9BL2RWamNUN3VpbnV2anBBYmNuTmpqcnZ1MHlL?=
 =?utf-8?B?cUU0L0cxbVc2MGpoeUgrdzV4bUs3WlBNUkxyaGVxQ1J2Q1BpbHZMOHpFR2Q4?=
 =?utf-8?B?RjJyRE1IQkV1eDNGVmhpa0xiN3dxeVhITDBOdXZRRisvZnNRL2pubjJKcnIz?=
 =?utf-8?B?UDU4UjUvejUxMFk4WTFrT1JzbGJqTGhnYmI1UFdaZlRlNlZsOVZGNFZJV1V2?=
 =?utf-8?B?TUdlQU1rT2h4Ykc5S3VjVTk3a3F0L3hGRkVlYXZPVVBnbFJIYmJqOVd0TUNK?=
 =?utf-8?B?ei9hemdIUVMzNU5jVGxCRHk0bUl4TnNxZzVWbGhoYmsySGR0M3MrUjcrakdr?=
 =?utf-8?B?ODByNnhNRlgrczlhWlhHMERNR0tnTG5vaUw3UmVCMWQwbGNFczJGclBtWHdt?=
 =?utf-8?B?cjY0RGlCOVBrTFVET0lpMDBCVjBnMDZIcXNXMTA2MU0raWwyRGlFSjhDc2Zk?=
 =?utf-8?B?VENaT3hHVHplNDhvZ3pkSG1aWHpZR3JMZWk1RkhMRkNKQ2RDRy9VV3VaRytk?=
 =?utf-8?B?STZ1NEQxTzA1Vkh5VWNidFpvak9OMGFSRituMU10MWlqcUtKMU9ZM3R6NlhS?=
 =?utf-8?B?SGRXclJXTDFVOTh5UUtuMUlrUFF0K3l3Qlh5UzBDNGRUT1lFbkk4OGlLZGZN?=
 =?utf-8?B?aTBkV3hiakZETXoxNjh5dk9LT0tuUFlGZlQyMnpLa0JmWUpwNVBodTVxYTZv?=
 =?utf-8?B?Vk5OdTA2dHc1ZzA4a3FEVzZ3Y0x1ZTc0ZkdKRVliUUxlbjVmYUtxVVN2bitG?=
 =?utf-8?B?TWJTb0VyTlpmOEwvZDFRdmgzOXppQ2gxYjBxaldwcmJHV2xnSmlDd3VDa2ta?=
 =?utf-8?B?L0FGcnZyLzV3WnRaNzB0OCsxOWhhMWhlNWU2NEFRK0tkbEk0bm0wYloxVFZT?=
 =?utf-8?B?Szh1bldGUkx1N0JEN29tRTN6ckhQVk5ZWmd5UEtTaEhqWGJBRmRxTFNFMkN5?=
 =?utf-8?B?WVZiQXVxc3E1S28wY3d5cy9rRmx5WmF0dGk1aUsxM1k4RXNiTDNma3BZRW1C?=
 =?utf-8?B?a2tBQ01tRXExc3ZwclpUUlBUOFRYbXNGamdpQlppaUVkTHJpZnBSTVFuYm1L?=
 =?utf-8?B?RERJaUVjdnF4RUFQSDBUcWpodU5kN3l0WFViSjE5dHdPeUVkVUxvWDhNRUl4?=
 =?utf-8?B?NzN5eUtHeFhFMWJuNllBQmllM1J1Rk1jeTVYajFrdC9VZVpvS3dhRTJXRE1V?=
 =?utf-8?B?VjF1UmVXa1dnWm0rbDF0QzVTLzdYazBNLytILy9ZK3VrWVM3WTFPTGVNZ0Jv?=
 =?utf-8?B?WHN4b3dHeUNML0lkUU02QnpHOEFweC9qblN3TnNtck5aVU9kUlpoZXRrVjlp?=
 =?utf-8?B?WDNKM0pnTS9jd1ZkRWorZkdDc3J5a2ZIMnlGWkxwU3BqaGlaMnh0RmhVWmtp?=
 =?utf-8?B?cmIyYUJFYXllVjlKZ0FDWlNjY0JHa3RBWXh1TldYbjF4WUc1UmdyOHQ5Q21j?=
 =?utf-8?B?bGdia3JOM3F5YUlVQjhZMjZuazZTMGtPQkJYdGxPNk10eXRKWjl2bU5PZmJT?=
 =?utf-8?B?R1U5VWdPVFh1MnJzeVplN2g2WXBJR2pYSXc0d0JscCtuN0g0Yy9pVytDQjc5?=
 =?utf-8?B?ZCtlUVpvZEh2eStSM0JleHlGOTlveS9McThqbGx6Ulg4eWdXcGdpOUlkU1k0?=
 =?utf-8?B?eEtpWndxSWtybEZ5OTh6b0haK1hNV3ZBWkVRRUpZMFA1cEp1cjdvVjZzdEo0?=
 =?utf-8?B?TlNPNU8vdjRDYlplWk9jL2hMTFRXSUI2U1ZuOFowa0hGM0tnVFZTRjltNjB4?=
 =?utf-8?B?RFduM2Fkc2dyR3ZPa21rZXRIRTVLRDhwT1h0ay9sNFl5b1AwRFQ4RlhqOUVB?=
 =?utf-8?B?MFNoaU1OZ2FKSW1CNmYxODM0WWtQV0RORFJiYlJTTjJsREoxVXZIRkNpdndy?=
 =?utf-8?B?aU9XYStZNHppeXJab0QyODJJeGZCZmpMbHFYdEs0VEtZcnpUcTlzb0dFcmF4?=
 =?utf-8?B?Nk9vdExScEdMSnhHTjUrZWh5U0RkRy92dDZrc1VhMUNrVmJxQ0RNdmUxSkxC?=
 =?utf-8?B?YzFkemY4elZGUXFucTMvT0lpZHlmUXd4S3U1Zm9iNXV3dzE3TVZIN1VCTk9w?=
 =?utf-8?B?L0h0VUdGKzgvUEJsMy9SWnVsQU9HNXZWY2w4eHltWXZxZWh5NFptVWpzZVFz?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7637d1b1-beb8-493b-9cbe-08dbcfb8b5e3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 09:00:43.7212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Or1Jv+tGqpqeNwF6N+BKw9IsJtxquYzHSXtExyicb4XzreUKCcK50fmNd/fh5FTUSTlEIcH8OSFcgKtGxffeWonQ3wXMae4uvg4EybXru5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4010
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

On 18/10/2023 09.43, Rasmus Villemoes wrote:
> On 17/10/2023 17.33, Marek Vasut wrote:

>> Which string ? The "bcm6753-led" is driver name , so that would have to
>> be parametrized.
> 
> Exactly. The only difference between the two examples (apart from the
> scope of the variables) is the driver name, but I think a
> generic_led_bind() could just do this inside the loop:
> 
>   device_bind_driver_to_node(parent, parent->driver->name,
>                           ofnode_get_name(node),
>                           node, &dev);
> 

Ah, no, that won't work for the drivers that do distinguish between the
top-level and child nodes, e.g. the gpio one. Oh well, a one-line
wrapper in each driver is still better than what we have currently.

Rasmus

