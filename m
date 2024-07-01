Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE18FC3065A
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 19:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 035878867A;
	Mon,  1 Jul 2024 21:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rVmkN5Zj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A21C1886CE; Mon,  1 Jul 2024 21:52:24 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA93E88297
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 21:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Sam.Povilus@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENgcYSZNl3BCFbgkxh317Y505Ab1FuHwZ2C7ovG9VVQGkGb720a5mS8O6Ny3m0CG8XonpLFur8089tadYclZ7BHRYKwzZjWHvLc40GViSPq+Wc8jNd+JGouv7ao7Tw7wtcBcKTrzhx1SrSk/QOr8rd38yGBszURdPhDoCFHtCXPl4BjfwuenzWxLyNSSYCRypPQOtkNkQo9U8V3wjT0xpkiCzQS38OV3/Q5eFXayA6NNhBPHayRmxTYHjfTZuwsonNg9EJxIp7SMjyvqRoNY9OLRzfGIg4N5hzq2fRUNxu7uegj3CieloaTn2F1DU9m1F7QcD6S7qNMZsp8pXxVDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY7nijsU78tGxl0kqVoHdVrzCjSofQXOSkyA8ImgkfI=;
 b=Dtx0iXvRQ7qX0qifX/Kzp/F210LJM+iP0rqqYrmLHUFPE8992jJBee/ghcDKRQ38rAkT9fw9Xwc2iTZfpBJ5XW52G4ZW1i6Ns6VGD0UmOvr80bhKsU0/rm/mkydKo0Xea/7Rqt6FIPiXBkzXKffFN+BuPj3JP0lM3Z3XW52WeVZnOESWwD2Jygz5MjseuyT1pujxV33o6PlLgC0pC3dbgyVehdIKXwkrhwHRLGrQUd1U0ERIg9PpT6FUktETjZoWZzNXko0pC4gR1AxnEtSDOPZ5MkYcIphkg6b1EGT7IRa28fPdOcbM0qgw/xO7ozqAxN+rdspcZfT29uKSqT7SyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY7nijsU78tGxl0kqVoHdVrzCjSofQXOSkyA8ImgkfI=;
 b=rVmkN5Zj52vE/JHLw+avgg5MNfQbdmuKtqLJXco1JfuJHVotmhSRRcM1TQ6uQKxQvpIz+jS52pfNm7np1+hbsOPt7DsyLz2qWT8yrUSjjZRSaxSO3aQ1BmSIy7k8STRwlNDL/dphnX6L5j5gJN2bccqsMzC5eBWrzWglTltoj4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 19:52:13 +0000
Received: from IA0PR12MB8424.namprd12.prod.outlook.com
 ([fe80::4f1f:1b25:8ca1:a52]) by IA0PR12MB8424.namprd12.prod.outlook.com
 ([fe80::4f1f:1b25:8ca1:a52%5]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 19:52:13 +0000
Message-ID: <92415d1b-d644-4224-ba2c-1b4d23f1f385@amd.com>
Date: Mon, 1 Jul 2024 13:52:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/1] doc: Remove FIT documentation that is elsewhere
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: git@amd.com, trini@konsulko.com, sjg@chromium.org, u-boot@lists.denx.de
References: <20240617202041.3740154-1-sam.povilus@amd.com>
 <20240617202041.3740154-2-sam.povilus@amd.com>
 <b882aacb-e4bd-4749-b228-3fefedff7364@gmx.de>
Content-Language: en-US
From: Sam Povilus <sam.povilus@amd.com>
In-Reply-To: <b882aacb-e4bd-4749-b228-3fefedff7364@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:610:58::17) To IA0PR12MB8424.namprd12.prod.outlook.com
 (2603:10b6:208:40c::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8424:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bc5982-1b26-46aa-8b4f-08dc9a074d51
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEJrZjhTUms5RndKZTFzaTZpWnpGOW4zeGlidGljNmR5K3Nid2tUaGFiazRL?=
 =?utf-8?B?Ykl3eFVLSU9SNHVETEFNRW1LTzRNaUlqdWh2MjkxeWVhRm43L2FscWo0dUdo?=
 =?utf-8?B?LytUcXVKbmJyZlJ1cGhXUUVUdk1tNXN2Tm9BQ1ZTem1MLy9GVHRQT3ZjUW9E?=
 =?utf-8?B?NVVPRXhIMWtTUGxnNXF4OEgrOGN3NHBmK3FoUCtCZzZJTmN4ajJiVjRrQ3Jj?=
 =?utf-8?B?QVlQbDVRWTNoSFh6dGEzYWUrUHhkZC9tTkRSNGJvb2Ezc2JSNUNZcTZzZ3ZR?=
 =?utf-8?B?WE8xWU1uN004MFJQV3hkYXJVWVYyaTloQTEzS2FIUnZYMVBVV0JDYmI3MzZ4?=
 =?utf-8?B?WHBuVFlaaXZhL1JVUXpQVFpjVWttNHdrUm5OYlNIa3hOUTZGdlVKWFI2Ykc3?=
 =?utf-8?B?cHNmaDNWdkU0eXpDMzR6Vm14KzhaNUtsVzBaTzRuQU9ZVnpqZ1RHNDRqMGRO?=
 =?utf-8?B?NHdqNHkra2doZTJEN3RsMFdTa25vODFJUDkxajBsVDRRb3FROFVxc2FWUDQz?=
 =?utf-8?B?aWlpc2lmVkE3aGl3STFkZWUra0VuM0t2N3VwWlV4Y1VscjFCRXBGMUFoZ3Fi?=
 =?utf-8?B?R2EwbW1YaTQ4bTNpaUpGN1J4Ti9XVk9aYUxOcE1GRTlaaFJWekxWekpmaVFV?=
 =?utf-8?B?T0V4NnYwM29SRVRNY1RzSVo5c3hqMVVRRGswSVk3MnRSMXJrY0diVkh1UHMy?=
 =?utf-8?B?RUdaSnZhWWVQQzJjWnJJYnZWcDNtd1hnKy9hT2xwR2JqUUdhSnJaOWNpd2Va?=
 =?utf-8?B?QTNXNDl4bHlKKzZ2OUduL1ZJaXo2U2tVb01DSGliVHdhNzMzQ3hGK2lMWS9K?=
 =?utf-8?B?SHZsbFAwZ1VyRUNXNzh0L2VQSG1YclRMNjVWRGJXRG5WbmF0bEJpeTJKUUsz?=
 =?utf-8?B?T3h6a2xPVUpVbXErWms2SFRSUW41TWMwTlROOTYvNEc4VHFzYlFaSW9rdzNT?=
 =?utf-8?B?aVRDU0g0K3ZkWDRjZUJlV1J3azZpU1lZVlNJVnV1SHZWVWU3VUdTNUd0NWtU?=
 =?utf-8?B?c0Z0VEhSQVRJOEdVVjBTNmRldWp1eFcvTGplTFBndzdXelJqVXJUVkVZTkVG?=
 =?utf-8?B?UHVwbXR6L2ltVzVUb3p2WksrdmxPZWhpcWhKeVpTME45bk8zSUxzcWJ0Nmlz?=
 =?utf-8?B?NXdoTUNVUHFwYklUSStrZEdDUjhGaCs0YkdKSktWOVJvVUNySkVPWkVJbnlt?=
 =?utf-8?B?R21XdTJQbzNVMmY1SGhsMzNGdjh1b0Y5QW02YUtJbnQvUC9DZVJYVnhoQ244?=
 =?utf-8?B?RjNvY0Ivd0MrYmxWNldOTVpxQTgvU2prQ2pEcUVaZmJMVTNpZjJWaUcrbUp1?=
 =?utf-8?B?Sk5XdytrdzdKR2Z5Ym13cUFIdjM0V0dKRFAyUnU3VytFa092bVNvcjBwZjNZ?=
 =?utf-8?B?OVkxSE5EUFBkbXdlUVE2UnUvV3NwUUxLRWNoZTV6dENvMjBacUNOMDM2NFpH?=
 =?utf-8?B?N1l1cVBoN295ZXEzSlA0Q2UzTlFEbHdVdGtXZ3RmN296Zy8zaTNuTUFtVDJu?=
 =?utf-8?B?KzNLUGl4ekRDL3FzLzU4MUlhYnd3V1JJVHRuZnpVME93MDllNkJrRURGYnhu?=
 =?utf-8?B?eVU2eERnYWVaK2UyMkx2LzBReVd1YkVVdGhoOTJwcnBtQUdmdEx2UGF6SUd1?=
 =?utf-8?B?aUFoQnE0OHExNmQ0azR2eER2cVM0QWxOTkJhVHAvQTdnTUs5T2hEOEtpSUp2?=
 =?utf-8?B?YjVHTDRpUkZibDZ5NmFIZC9LQ1lpRStZaXd3TnFYczBGUHVyWGFxZFNlR01M?=
 =?utf-8?Q?R48YSAc1BGxlN2WiuY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8424.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckdhWGFFSWNlT1BTMFhXL2VDTWQ2S0Z6OENkQ2JoTjQ0OEtPZU5wc01oVDRW?=
 =?utf-8?B?QlFqRjdKVFZ4bmpoelZYaEtsTEF0QWlpQlhUdytJTThTUUhieXRtZENYckdQ?=
 =?utf-8?B?VngyYXhSSnpoTVE0eFJoOU5ZYzZySW9BaGtLU2ovbTFCME1EVUlBK0F4bVpa?=
 =?utf-8?B?dFlGUEwyZkZmOGJaYXBkRDNFUlNjNUFubnZuUnBpaE9iQWg3NTBDMy81UWZU?=
 =?utf-8?B?Mzh5SGV4aHpRc1FlT0lPNkxTdE5IKy9PL0dNcmVYdTdhR1RXd01pODNCUTVB?=
 =?utf-8?B?c2JEYWNPdzRxekxDK1lacGJRYjdkdmh4MUk2TkM0SmJNc2FaQ0JpcTJnckZX?=
 =?utf-8?B?elBLL0hVRFRhc0hrVkowS1oydjExaUNTd1ByRGdaRWVBTi9BNW9KZFA3US9S?=
 =?utf-8?B?dk9uMXh1ODZNdktOSVZDbkZIUXVBcHMxdnZ3R0tRMHUzUGNzdUNla3F1VTFx?=
 =?utf-8?B?ZUxOR0N6R0FUTUVCR09oR1JFTlozM0YrWjArWTRMNy9HNXhodGYwRG9EZlFV?=
 =?utf-8?B?eld6QWVhVE9nVWlMckFyU1dYMEhIV1RLcmJtRURrbDRya1FTMVJodDBaMGkx?=
 =?utf-8?B?dWFjUGZ5NithcUFlUUlxMitVb3JXT0JyemJPbXRvNUZTREdvejFwcG15MTY2?=
 =?utf-8?B?NHFXRUQrNEtMY2lDUkN5OVhLdVJPVDkzaFZmZkhrcWN1dm9mYmZRRjFDT2JK?=
 =?utf-8?B?Zk1pZzNqbkxUT2hSRUFYdHlXc3MxUEIyNUdqM1NWYmozVE85OGZFNjE5RHBw?=
 =?utf-8?B?cEo1RTVjYlJoYXQrR2dFeXg5cjlDNUxtUHVaZ040cUVBVVV3aTZ5aVdVNDJP?=
 =?utf-8?B?ekhMN1pHU09KSnhCL2hnMkptZGxEMWdWNnFQRmNzMi9VdVB0aXdpT3NaekVj?=
 =?utf-8?B?bEhrTGVhNDlma214QjVreWhaSWJFSkRYYjNYVHlkdm9HL0FEZ2tmdEFhV21x?=
 =?utf-8?B?NmlMeFFmbUgwL251dkcrN0FtT290YUQ0bTIrQXJkc3Q3QVQ2RnNNajVLUUJN?=
 =?utf-8?B?eFplUmtTUWhnV1lIYWFGVm03Z2RES015V1JjS1o5VmxFdnkxeEdOMWx4TTVk?=
 =?utf-8?B?MXMyWnZRbzRKWnZnRWpFcDhhRFQ5Ujg3Zm44aHZ5bXBCZndIcjdrNEZIOWRE?=
 =?utf-8?B?aTMyQWhIM0JEdHMyZksyd2llSHVUQk43RWZkQ3ptbnFydk9NaWNQSXJsTkEw?=
 =?utf-8?B?V0J6OTNxMXhDem1jZWF4N0lLZVpOcmh0N1k3TW9LbmYvNmJhdUFSMlVQQzBj?=
 =?utf-8?B?d295UGNTMUtzSDhHSDMwcklSMjJnODFkc0hVSWY0UEpZK3kvREZ3K2JLdGJZ?=
 =?utf-8?B?VUcrdGxuazU1VW9JWDU3cHRNTWx3UHlZcXNnemRFcHBWWVZmMHF6bm9GMEJ2?=
 =?utf-8?B?NlFxOFNOelltZzJERXFxTzF6Nnc1VUw4bFN2RkJ0NXRjbXkwSHZtVWdzVnpZ?=
 =?utf-8?B?K1NWZG1VZWpQU3ljbVh5YTB5T3BFd1hyVTR5dzRRQ0hXZStQMkR6QXVNUXFw?=
 =?utf-8?B?SU5GMTlTZ3JYVG1MZisvTFdpbFNrcmczaUZQS0ROQ0FndUR2NzdXUzJOeTJq?=
 =?utf-8?B?c0RPU3pZUWY2aExSbm9aNURWSFlKL2ZFWkRtdzM3V0VpbktoN2REZWxMbkxL?=
 =?utf-8?B?UDJyTWdlVmxBdWhyNGhsZjl6T2g5WFIwZytKT2hxN1Ryb0RCelVRNnVrdmV0?=
 =?utf-8?B?ZWRCRXpNZHVHWmswOU05WXB1UzNjLzVMbUJQT1hvRWpYQVBFK3dpbmR0dks3?=
 =?utf-8?B?MWpMVWd3anhJU0tScFFsM2F0NXI2NXk5UitHTDU4WFE2djlzSnV2WXJxcHNJ?=
 =?utf-8?B?UUdnejRDaGF1WmpTTW9ERVNoUkUxYjlKZTVlU2RRb0NSQ2d4ZlJpU3RXZFhy?=
 =?utf-8?B?YkhHcHlPQzFMa3Jpa3NCUmZMWS9qdE93c2t3Z2YxZnZrL2pLeGFTTlVjMU4z?=
 =?utf-8?B?VXFCY293WDZRTkpDeFBXYTIrZUcvc0hlQnFVdktyMlY1eEV1bzc2KzZ2VENB?=
 =?utf-8?B?MUF6MUdLRkM4UTNhNUI5Ti9ZWjFHdDVKdXVrTU9sVFhTL053U0c2VGFjRmFu?=
 =?utf-8?B?MlIxWlg0V0tucHorTTBDMkpGWmhjai9DeEdzZXptRTBmNVVmRktrblh3SjdB?=
 =?utf-8?Q?hWs3yqlYoKcihD1eqH/n2xbNH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bc5982-1b26-46aa-8b4f-08dc9a074d51
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8424.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 19:52:13.4235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/jqFM8Ka1cLVs+X7HTS/aHD4Z6AauAgYd+ThvD58C4VtiDxGgyOoMbZKR2zSb8FJ2zwhhQLIsRfYhAC4pYyWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
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



On 6/18/2024 12:03 AM, Heinrich Schuchardt wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
> 
> 
> On 6/17/24 22:20, Sam Povilus wrote:
>> FIT documentation is now a separate project, instead of having a
>> duplicate, we should point at the other project.
>>
>> Signed-off-by: Sam Povilus <sam.povilus@amd.com>
>> ---
>>   doc/usage/fit/index.rst              |  14 +-
>>   doc/usage/fit/source_file_format.rst | 682 +--------------------------
>>   2 files changed, 5 insertions(+), 691 deletions(-)
>>
>> diff --git a/doc/usage/fit/index.rst b/doc/usage/fit/index.rst
>> index bd25bd30b2..12a8c6fb16 100644
>> --- a/doc/usage/fit/index.rst
>> +++ b/doc/usage/fit/index.rst
>> @@ -4,16 +4,6 @@ Flat Image Tree (FIT)
>>   =====================
>>
>>   U-Boot uses Flat Image Tree (FIT) as a standard file format for 
>> packaging
>> -images that it it reads and boots. Documentation about FIT is 
>> available at
>> -doc/uImage.FIT
>> +images that it it reads and boots. Documentation about FIT is 
>> available in
>> +`the Flattened Image Tree project <https://fitspec.osfw.foundation/>`_.
>>
>> -.. toctree::
>> -    :maxdepth: 1
>> -
>> -    source_file_format
> 
> This is the only entry to be replaced by the external link.
> 
>> -    howto
>> -    x86-fit-boot
>> -    signature
>> -    verified-boot
>> -    beaglebone_vboot
>> -    overlay-fdt-boot
> 
> All of these files are staying around and must be kept linked.

I would argue that if this list is not being maintained, it is better to 
remove it than to try to keep it up to date. Maybe that should be a 
separate patch though?

> 
> Many links are missing here. The complete list should be:
> 
>      beaglebone_vboot
>      howto
>      kernel_fdt
>      kernel_fdts_compressed
>      kernel
>      multi
>      multi_spl
>      multi-with-fpga
>      multi-with-loadables
>      overlay-fdt-boot
>      sec_firmware_ppa
>      signature
>      sign-configs
>      sign-images
>      uefi
>      update3
>      update_uboot
>      verified-boot
>      x86-fit-boot
> 
> These other documents should be carefully redacted. E.g. howto.rst
> refers to the FIT file format as "the new uImage format".

I agree that it would be nice to take a pass through all this 
documentation and clean it up, but I think there is value in doing small 
cleanups as one has time.

> 
> Best regards
> 
> Heinrich
> 
>> diff --git a/doc/usage/fit/source_file_format.rst 
>> b/doc/usage/fit/source_file_format.rst
>> index b2b1e42bd7..0c44329a82 100644
>> --- a/doc/usage/fit/source_file_format.rst
>> +++ b/doc/usage/fit/source_file_format.rst
>> @@ -3,682 +3,6 @@
>>   Flattened Image Tree (FIT) Format
>>   =================================
>>
>> -Introduction
>> -------------
>> -
>> -The number of elements playing a role in the kernel booting process has
>> -increased over time and now typically includes the devicetree, kernel 
>> image and
>> -possibly a ramdisk image. Generally, all must be placed in the system 
>> memory and
>> -booted together.
>> -
>> -For firmware images a similar process has taken place, with various 
>> binaries
>> -loaded at different addresses, such as ARM's ATF, OpenSBI, FPGA and 
>> U-Boot
>> -itself.
>> -
>> -FIT provides a flexible and extensible format to deal with this 
>> complexity. It
>> -provides support for multiple components. It also supports multiple
>> -configurations, so that the same FIT can be used to boot multiple 
>> boards, with
>> -some components in common (e.g. kernel) and some specific to that 
>> board (e.g.
>> -devicetree).
>> -
>> -Terminology
>> -~~~~~~~~~~~
>> -
>> -This document defines FIT by providing FDT (Flat Device Tree) 
>> bindings. These
>> -describe the final form of the FIT at the moment when it is used. The 
>> user
>> -perspective may be simpler, as some of the properties (like 
>> timestamps and
>> -hashes) are filled in automatically by the U-Boot mkimage tool.
>> -
>> -To avoid confusion with the kernel FDT the following naming 
>> convention is used:
>> -
>> -FIT
>> -    Flattened Image Tree
>> -
>> -FIT is formally a flattened devicetree (in the libfdt meaning), which 
>> conforms
>> -to bindings defined in this document.
>> -
>> -.its
>> -    image tree source
>> -
>> -.itb
>> -    flattened image tree blob
>> -
>> -Image-building procedure
>> -~~~~~~~~~~~~~~~~~~~~~~~~
>> -
>> -The following picture shows how the FIT is prepared. Input consists of
>> -image source file (.its) and a set of data files. Image is created 
>> with the
>> -help of standard U-Boot mkimage tool which in turn uses dtc (device tree
>> -compiler) to produce image tree blob (.itb). The resulting .itb file 
>> is the
>> -actual binary of a new FIT::
>> -
>> -    tqm5200.its
>> -    +
>> -    vmlinux.bin.gz     mkimage + dtc               xfer to target
>> -    eldk-4.2-ramdisk  --------------> tqm5200.itb --------------> boot
>> -    tqm5200.dtb                          /|\
>> -                                          |
>> -                                     'new FIT'
>> -
>> -Steps:
>> -
>> -#. Create .its file, automatically filled-in properties are omitted
>> -
>> -#. Call mkimage tool on a .its file
>> -
>> -#. mkimage calls dtc to create .itb image and assures that
>> -   missing properties are added
>> -
>> -#. .itb (new FIT) is uploaded onto the target and used therein
>> -
>> -
>> -Unique identifiers
>> -~~~~~~~~~~~~~~~~~~
>> -
>> -To identify FIT sub-nodes representing images, hashes, configurations 
>> (which
>> -are defined in the following sections), the "unit name" of the given 
>> sub-node
>> -is used as it's identifier as it assures uniqueness without additional
>> -checking required.
>> -
>> -
>> -External data
>> -~~~~~~~~~~~~~
>> -
>> -FIT is normally built initially with image data in the 'data' 
>> property of each
>> -image node. It is also possible for this data to reside outside the 
>> FIT itself.
>> -This allows the 'FDT' part of the FIT to be quite small, so that it 
>> can be
>> -loaded and scanned without loading a large amount of data. Then when 
>> an image is
>> -needed it can be loaded from an external source.
>> -
>> -External FITs use 'data-offset' or 'data-position' instead of 'data'.
>> -
>> -The mkimage tool can convert a FIT to use external data using the 
>> `-E` argument,
>> -optionally using `-p` to specific a fixed position.
>> -
>> -It is often desirable to align each image to a block size or 
>> cache-line size
>> -(e.g. 512 bytes), so that there is no need to copy it to an aligned 
>> address when
>> -reading the image data. The mkimage tool provides a `-B` argument to 
>> support
>> -this.
>> -
>> -Root-node properties
>> ---------------------
>> -
>> -The root node of the FIT should have the following layout::
>> -
>> -    / o image-tree
>> -        |- description = "image description"
>> -        |- timestamp = <12399321>
>> -        |- #address-cells = <1>
>> -        |
>> -        o images
>> -        | |
>> -        | o image-1 {...}
>> -        | o image-2 {...}
>> -        | ...
>> -        |
>> -        o configurations
>> -          |- default = "conf-1"
>> -          |
>> -          o conf-1 {...}
>> -          o conf-2 {...}
>> -          ...
>> -
>> -Optional property
>> -~~~~~~~~~~~~~~~~~
>> -
>> -description
>> -    Textual description of the FIT
>> -
>> -Mandatory property
>> -~~~~~~~~~~~~~~~~~~
>> -
>> -timestamp
>> -    Last image modification time being counted in seconds since
>> -    1970-01-01 00:00:00 - to be automatically calculated by mkimage 
>> tool.
>> -
>> -Conditionally mandatory property
>> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> -
>> -#address-cells
>> -    Number of 32bit cells required to represent entry and
>> -    load addresses supplied within sub-image nodes. May be omitted 
>> when no
>> -    entry or load addresses are used.
>> -
>> -Mandatory nodes
>> -~~~~~~~~~~~~~~~
>> -
>> -images
>> -    This node contains a set of sub-nodes, each of them representing
>> -    single component sub-image (like kernel, ramdisk, etc.). At least 
>> one
>> -    sub-image is required.
>> -
>> -configurations
>> -    Contains a set of available configuration nodes and
>> -    defines a default configuration.
>> -
>> -
>> -'/images' node
>> ---------------
>> -
>> -This node is a container node for component sub-image nodes. Each 
>> sub-node of
>> -the '/images' node should have the following layout::
>> -
>> -    o image-1
>> -        |- description = "component sub-image description"
>> -        |- data = /incbin/("path/to/data/file.bin")
>> -        |- type = "sub-image type name"
>> -        |- arch = "ARCH name"
>> -        |- os = "OS name"
>> -        |- compression = "compression name"
>> -        |- load = <00000000>
>> -        |- entry = <00000000>
>> -        |
>> -        o hash-1 {...}
>> -        o hash-2 {...}
>> -        ...
>> -
>> -Mandatory properties
>> -~~~~~~~~~~~~~~~~~~~~
>> -
>> -description
>> -    Textual description of the component sub-image
>> -
>> -type
>> -    Name of component sub-image type. Supported types are:
>> -
>> -    ====================  ==================
>> -    Sub-image type        Meaning
>> -    ====================  ==================
>> -    invalid               Invalid Image
>> -    aisimage              Davinci AIS image
>> -    atmelimage            ATMEL ROM-Boot Image
>> -    copro                 Coprocessor Image}
>> -    fdt_legacy            legacy Image with Flat Device Tree
>> -    filesystem            Filesystem Image
>> -    firmware              Firmware
>> -    firmware_ivt          Firmware with HABv4 IVT }
>> -    flat_dt               Flat Device Tree
>> -    fpga                  FPGA Image }
>> -    gpimage               TI Keystone SPL Image
>> -    imx8image             NXP i.MX8 Boot Image
>> -    imx8mimage            NXP i.MX8M Boot Image
>> -    imximage              Freescale i.MX Boot Image
>> -    kernel                Kernel Image
>> -    kernel_noload         Kernel Image (no loading done)
>> -    kwbimage              Kirkwood Boot Image
>> -    lpc32xximage          LPC32XX Boot Image
>> -    mtk_image             MediaTek BootROM loadable Image }
>> -    multi                 Multi-File Image
>> -    mxsimage              Freescale MXS Boot Image
>> -    omapimage             TI OMAP SPL With GP CH
>> -    pblimage              Freescale PBL Boot Image
>> -    pmmc                  TI Power Management Micro-Controller Firmware
>> -    ramdisk               RAMDisk Image
>> -    rkimage               Rockchip Boot Image }
>> -    rksd                  Rockchip SD Boot Image }
>> -    rkspi                 Rockchip SPI Boot Image }
>> -    script                Script
>> -    socfpgaimage          Altera SoCFPGA CV/AV preloader
>> -    socfpgaimage_v1       Altera SoCFPGA A10 preloader
>> -    spkgimage             Renesas SPKG Image }
>> -    standalone            Standalone Program
>> -    stm32image            STMicroelectronics STM32 Image }
>> -    sunxi_egon            Allwinner eGON Boot Image }
>> -    sunxi_toc0            Allwinner TOC0 Boot Image }
>> -    tee                   Trusted Execution Environment Image
>> -    ublimage              Davinci UBL image
>> -    vybridimage           Vybrid Boot Image
>> -    x86_setup             x86 setup.bin
>> -    zynqimage             Xilinx Zynq Boot Image }
>> -    zynqmpbif             Xilinx ZynqMP Boot Image (bif) }
>> -    zynqmpimage           Xilinx ZynqMP Boot Image }
>> -    ====================  ==================
>> -
>> -compression
>> -    Compression used by included data. If no compression is used, the
>> -    compression property should be set to "none". If the data is 
>> compressed but
>> -    it should not be uncompressed by the loader (e.g. compressed 
>> ramdisk), this
>> -    should also be set to "none".
>> -
>> -    Supported compression types are:
>> -
>> -    ====================  ==================
>> -    Compression type      Meaning
>> -    ====================  ==================
>> -    none                  uncompressed
>> -    bzip2                 bzip2 compressed
>> -    gzip                  gzip compressed
>> -    lz4                   lz4 compressed
>> -    lzma                  lzma compressed
>> -    lzo                   lzo compressed
>> -    zstd                  zstd compressed
>> -    ====================  ==================
>> -
>> -data-size
>> -    size of the data in bytes
>> -
>> -
>> -Conditionally mandatory property
>> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> -
>> -data
>> -    Path to the external file which contains this node's binary data. 
>> Within
>> -    the FIT this is the contents of the file. This is mandatory unless
>> -    external data is used.
>> -
>> -data-offset
>> -    Offset of the data in a separate image store. The image store is 
>> placed
>> -    immediately after the last byte of the device tree binary, 
>> aligned to a
>> -    4-byte boundary. This is mandatory if external data is used, with 
>> an offset.
>> -
>> -data-position
>> -    Machine address at which the data is to be found. This is a fixed 
>> address
>> -    not relative to the loading of the FIT. This is mandatory if 
>> external data
>> -    used with a fixed address.
>> -
>> -os
>> -    OS name, mandatory for types "kernel". Valid OS names are:
>> -
>> -    ====================  ==================
>> -    OS name               Meaning
>> -    ====================  ==================
>> -    invalid               Invalid OS
>> -    4_4bsd                4_4BSD
>> -    arm-trusted-firmware  ARM Trusted Firmware
>> -    dell                  Dell
>> -    efi                   EFI Firmware
>> -    esix                  Esix
>> -    freebsd               FreeBSD
>> -    integrity             INTEGRITY
>> -    irix                  Irix
>> -    linux                 Linux
>> -    ncr                   NCR
>> -    netbsd                NetBSD
>> -    openbsd               OpenBSD
>> -    openrtos              OpenRTOS
>> -    opensbi               RISC-V OpenSBI
>> -    ose                   Enea OSE
>> -    plan9                 Plan 9
>> -    psos                  pSOS
>> -    qnx                   QNX
>> -    rtems                 RTEMS
>> -    sco                   SCO
>> -    solaris               Solaris
>> -    svr4                  SVR4
>> -    tee                   Trusted Execution Environment
>> -    u-boot                U-Boot
>> -    vxworks               VxWorks
>> -    ====================  ==================
>> -
>> -arch
>> -    Architecture name, mandatory for types: "standalone", "kernel",
>> -    "firmware", "ramdisk" and "fdt". Valid architecture names are:
>> -
>> -    ====================  ==================
>> -    Architecture type     Meaning
>> -    ====================  ==================
>> -    invalid               Invalid ARCH
>> -    alpha                 Alpha
>> -    arc                   ARC
>> -    arm64                 AArch64
>> -    arm                   ARM
>> -    avr32                 AVR32
>> -    blackfin              Blackfin
>> -    ia64                  IA64
>> -    m68k                  M68K
>> -    microblaze            MicroBlaze
>> -    mips64                MIPS 64 Bit
>> -    mips                  MIPS
>> -    nds32                 NDS32
>> -    nios2                 NIOS II
>> -    or1k                  OpenRISC 1000
>> -    powerpc               PowerPC
>> -    ppc                   PowerPC
>> -    riscv                 RISC-V
>> -    s390                  IBM S390
>> -    sandbox               Sandbox
>> -    sh                    SuperH
>> -    sparc64               SPARC 64 Bit
>> -    sparc                 SPARC
>> -    x86_64                AMD x86_64
>> -    x86                   Intel x86
>> -    xtensa                Xtensa
>> -    ====================  ==================
>> -
>> -entry
>> -    entry point address, address size is determined by
>> -    '#address-cells' property of the root node.
>> -    Mandatory for types: "firmware", and "kernel".
>> -
>> -load
>> -    load address, address size is determined by '#address-cells'
>> -    property of the root node.
>> -    Mandatory for types: "firmware", and "kernel".
>> -
>> -compatible
>> -    compatible method for loading image.
>> -    Mandatory for types: "fpga", and images that do not specify a 
>> load address.
>> -    Supported compatible methods:
>> -
>> -    ==========================  
>> =========================================
>> -    Compatible string           Meaning
>> -    ==========================  
>> =========================================
>> -    u-boot,fpga-legacy          Generic fpga loading routine.
>> -    u-boot,zynqmp-fpga-ddrauth  Signed non-encrypted FPGA bitstream for
>> -                                Xilinx Zynq UltraScale+ (ZymqMP) device.
>> -    u-boot,zynqmp-fpga-enc      Encrypted FPGA bitstream for Xilinx Zynq
>> -                                UltraScale+ (ZynqMP) device.
>> -    ==========================  
>> =========================================
>> -
>> -phase
>> -    U-Boot phase for which the image is intended.
>> -
>> -    "spl"
>> -        image is an SPL image
>> -
>> -    "u-boot"
>> -        image is a U-Boot image
>> -
>> -Optional nodes:
>> -
>> -hash-1
>> -    Each hash sub-node represents separate hash or checksum
>> -    calculated for node's data according to specified algorithm.
>> -
>> -signature-1
>> -    Each signature sub-node represents separate signature
>> -    calculated for node's data according to specified algorithm.
>> -
>> -
>> -Hash nodes
>> -----------
>> -
>> -::
>> -
>> -    o hash-1
>> -        |- algo = "hash or checksum algorithm name"
>> -        |- value = [hash or checksum value]
>> -
>> -Mandatory properties
>> -~~~~~~~~~~~~~~~~~~~~
>> -
>> -algo
>> -    Algorithm name. Supported algoriths and their value sizes are:
>> -
>> -    ==================== ============ 
>> =========================================
>> -    Sub-image type       Size (bytes) Meaning
>> -    ==================== ============ 
>> =========================================
>> -    crc16-ccitt          2            Cyclic Redundancy Check 16-bit
>> -                                      (Consultative Committee for 
>> International
>> -                                      Telegraphy and Telephony)
>> -    crc32                4            Cyclic Redundancy Check 32-bit
>> -    md5                  16           Message Digest 5 (MD5)
>> -    sha1                 20           Secure Hash Algorithm 1 (SHA1)
>> -    sha256               32           Secure Hash Algorithm 2 (SHA256)
>> -    sha384               48           Secure Hash Algorithm 2 (SHA384)
>> -    sha512               64           Secure Hash Algorithm 2 (SHA512)
>> -    ==================== ============ 
>> =========================================
>> -
>> -value
>> -    Actual checksum or hash value.
>> -
>> -Image-signature nodes
>> ----------------------
>> -
>> -::
>> -
>> -    o signature-1
>> -        |- algo = "algorithm name"
>> -        |- key-name-hint = "key name"
>> -        |- value = [hash or checksum value]
>> -
>> -
>> -Mandatory properties
>> -~~~~~~~~~~~~~~~~~~~~
>> -
>> -_`FIT Algorithm`:
>> -
>> -algo
>> -    Algorithm name. Supported algoriths and their value sizes are 
>> shown below.
>> -    Note that the hash is specified separately from the signing 
>> algorithm, so
>> -    it is possible to mix and match any SHA algorithm with any signing
>> -    algorithm. The size of the signature relates to the signing 
>> algorithm, not
>> -    the hash, since it is the hash that is signed.
>> -
>> -    ==================== ============ 
>> =========================================
>> -    Sub-image type       Size (bytes) Meaning
>> -    ==================== ============ 
>> =========================================
>> -    sha1,rsa2048         256          SHA1 hash signed with 2048-bit
>> -                                      Rivest–Shamir–Adleman algorithm
>> -    sha1,rsa3072         384          SHA1 hash signed with 2048-bit RSA
>> -    sha1,rsa4096         512          SHA1 hash signed with 2048-bit RSA
>> -    sha1,ecdsa256        32           SHA1 hash signed with 256-bit  
>> Elliptic
>> -                                      Curve Digital Signature Algorithm
>> -    sha256,...
>> -    sha384,...
>> -    sha512,...
>> -    ==================== ============ 
>> =========================================
>> -
>> -key-name-hint
>> -    Name of key to use for signing. The keys will normally be in
>> -    a single directory (parameter -k to mkimage). For a given key 
>> <name>, its
>> -    private key is stored in <name>.key and the certificate is stored in
>> -    <name>.crt.
>> -
>> -sign-images
>> -    A list of images to sign, each being a property of the conf
>> -    node that contains then. The default is "kernel,fdt" which means 
>> that these
>> -    two images will be looked up in the config and signed if present. 
>> This is
>> -    used by mkimage to determine which images to sign.
>> -
>> -The following properies are added as part of signing, and are mandatory:
>> -
>> -value
>> -    Actual signature value. This is added by mkimage.
>> -
>> -hashed-nodes
>> -    A list of nodes which were hashed by the signer. Each is
>> -    a string - the full path to node. A typical value might be::
>> -
>> -     hashed-nodes = "/", "/configurations/conf-1", "/images/kernel",
>> -         "/images/kernel/hash-1", "/images/fdt-1",
>> -         "/images/fdt-1/hash-1";
>> -
>> -hashed-strings
>> -    The start and size of the string region of the FIT that was 
>> hashed. The
>> -    start is normally 0, indicating the first byte of the string 
>> table. The size
>> -    indicates the number of bytes hashed as part of signing.
>> -
>> -The following properies are added as part of signing, and are optional:
>> -
>> -timestamp
>> -    Time when image was signed (standard Unix time_t format)
>> -
>> -signer-name
>> -    Name of the signer (e.g. "mkimage")
>> -
>> -signer-version
>> -    Version string of the signer (e.g. "2013.01")
>> -
>> -comment
>> -    Additional information about the signer or image
>> -
>> -padding
>> -    The padding algorithm, it may be pkcs-1.5 or pss,
>> -    if no value is provided we assume pkcs-1.5
>> -
>> -
>> -'/configurations' node
>> -----------------------
>> -
>> -The 'configurations' node creates convenient, labeled boot 
>> configurations,
>> -which combine together kernel images with their ramdisks and fdt blobs.
>> -
>> -The 'configurations' node has the following structure::
>> -
>> -    o configurations
>> -        |- default = "default configuration sub-node unit name"
>> -        |
>> -        o config-1 {...}
>> -        o config-2 {...}
>> -        ...
>> -
>> -
>> -Optional property
>> -~~~~~~~~~~~~~~~~~
>> -
>> -default
>> -    Selects one of the configuration sub-nodes as a default 
>> configuration.
>> -
>> -Mandatory nodes
>> -~~~~~~~~~~~~~~~
>> -
>> -configuration-sub-node-unit-name
>> -    At least one of the configuration sub-nodes is required.
>> -
>> -Optional nodes
>> -~~~~~~~~~~~~~~
>> -
>> -signature-1
>> -    Each signature sub-node represents separate signature
>> -    calculated for the configuration according to specified algorithm.
>> -
>> -
>> -Configuration nodes
>> --------------------
>> -
>> -Each configuration has the following structure::
>> -
>> -    o config-1
>> -        |- description = "configuration description"
>> -        |- kernel = "kernel sub-node unit name"
>> -        |- fdt = "fdt sub-node unit-name" [, "fdt overlay sub-node 
>> unit-name", ...]
>> -        |- loadables = "loadables sub-node unit-name"
>> -        |- script = "
>> -        |- compatible = "vendor,board-style device tree compatible 
>> string"
>> -        o signature-1 {...}
>> -
>> -Mandatory properties
>> -~~~~~~~~~~~~~~~~~~~~
>> -
>> -description
>> -    Textual configuration description.
>> -
>> -kernel or firmware
>> -    Unit name of the corresponding kernel or firmware
>> -    (u-boot, op-tee, etc) image. If both "kernel" and "firmware" are 
>> specified,
>> -    control is passed to the firmware image.
>> -
>> -Optional properties
>> -~~~~~~~~~~~~~~~~~~~
>> -
>> -fdt
>> -    Unit name of the corresponding fdt blob (component image node of a
>> -    "fdt type"). Additional fdt overlay nodes can be supplied which 
>> signify
>> -    that the resulting device tree blob is generated by the first 
>> base fdt
>> -    blob with all subsequent overlays applied.
>> -
>> -fpga
>> -    Unit name of the corresponding fpga bitstream blob
>> -    (component image node of a "fpga type").
>> -
>> -loadables
>> -    Unit name containing a list of additional binaries to be
>> -    loaded at their given locations.  "loadables" is a 
>> comma-separated list
>> -    of strings. U-Boot will load each binary at its given 
>> start-address and
>> -    may optionally invoke additional post-processing steps on this 
>> binary based
>> -    on its component image node type.
>> -
>> -script
>> -    The image to use when loading a U-Boot script (for use with the
>> -    source command).
>> -
>> -compatible
>> -    The root compatible string of the U-Boot device tree that
>> -    this configuration shall automatically match when 
>> CONFIG_FIT_BEST_MATCH is
>> -    enabled. If this property is not provided, the compatible string 
>> will be
>> -    extracted from the fdt blob instead. This is only possible if the 
>> fdt is
>> -    not compressed, so images with compressed fdts that want to use 
>> compatible
>> -    string matching must always provide this property.
>> -
>> -The FDT blob is required to properly boot FDT based kernel, so the 
>> minimal
>> -configuration for 2.6 FDT kernel is (kernel, fdt) pair.
>> -
>> -Older, 2.4 kernel and 2.6 non-FDT kernel do not use FDT blob, in such 
>> cases
>> -'struct bd_info' must be passed instead of FDT blob, thus fdt 
>> property *must
>> -not* be specified in a configuration node.
>> -
>> -Configuration-signature nodes
>> ------------------------------
>> -
>> -::
>> -
>> -    o signature-1
>> -        |- algo = "algorithm name"
>> -        |- key-name-hint = "key name"
>> -        |- sign-images = "path1", "path2";
>> -        |- value = [hash or checksum value]
>> -        |- hashed-strings = <0 len>
>> -
>> -
>> -Mandatory properties
>> -~~~~~~~~~~~~~~~~~~~~
>> -
>> -algo
>> -    See `FIT Algorithm`_.
>> -
>> -key-name-hint
>> -    Name of key to use for signing. The keys will normally be in
>> -    a single directory (parameter -k to mkimage). For a given key 
>> <name>, its
>> -    private key is stored in <name>.key and the certificate is stored in
>> -    <name>.crt.
>> -
>> -The following properies are added as part of signing, and are mandatory:
>> -
>> -value
>> -    Actual signature value. This is added by mkimage.
>> -
>> -The following properies are added as part of signing, and are optional:
>> -
>> -timestamp
>> -    Time when image was signed (standard Unix time_t format)
>> -
>> -signer-name
>> -    Name of the signer (e.g. "mkimage")
>> -
>> -signer-version
>> -    Version string of the signer (e.g. "2013.01")
>> -
>> -comment
>> -    Additional information about the signer or image
>> -
>> -padding
>> -    The padding algorithm, it may be pkcs-1.5 or pss,
>> -    if no value is provided we assume pkcs-1.5
>> -
>> -
>> -
>> -Examples
>> ---------
>> -
>> -Some example files are available here, showing various scenarios
>> -
>> -.. toctree::
>> -    :maxdepth: 1
>> -
>> -    kernel
>> -    kernel_fdt
>> -    kernel_fdts_compressed
>> -    multi
>> -    multi_spl
>> -    multi-with-fpga
>> -    multi-with-loadables
>> -    sec_firmware_ppa
>> -    sign-configs
>> -    sign-images
>> -    uefi
>> -    update3
>> -    update_uboot
>> -
>> -.. sectionauthor:: Marian Balakowicz <m8@semihalf.com>
>> -.. sectionauthor:: External data additions, 25/1/16 Simon Glass 
>> <sjg@chromium.org>
>> +FIT format documentation has been moved to
>> +`a separate project <https://fitspec.osfw.foundation/>`_. Updates to the
>> +format/specification should be submitted there.
>> \ No newline at end of file
> 
