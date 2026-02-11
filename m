Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF70EB597E
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 09:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 284A38367F;
	Wed, 11 Feb 2026 10:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m97GlcBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0819783A47; Wed, 11 Feb 2026 10:04:05 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AFCA831AC
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 10:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCIndoeVcivIKpEv1aDfyqoYQDH3nMu2NHrYdPJQ+5V/FNQf8irEQ1pWF3+SYLLT3MxKOtjaRXZN1eA9tSHb61qX3p7b7XnOrMm2mtOfduxkNK5P6XDrKlOYMEEGXwPmblhBrN2nON0wYfjJw4wokdTuRclF+CPnvk2E66OOg++A1EW7K+dhv43YZ2RusFJQFHZyT0bCFwYCLqvOpVyZXxh9j7y+FksywK62987VnmR5oHZ4awv2H/zmZsg1LIkfz2WB2mOzVmmc+bYSn1J73zRge8ZMabecL9oNJn1pPQ6mXtKlwQS3/07760zSAByNOl0Td29KQt+jwE3JocFPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcQDOxn3UGp6o/ErCWZL4NpdH1AgZZy6JGAbLwU9y9M=;
 b=srY24jUBSGKKPfUVUpz4z5ZFy7lDm7oKvmFT3qN12KZtw+qros+6DVjJ/R2txZMMSV4mjgQhM4n3KmGlhv/EpeQf2NDsQWGK5+S5oZt3CVgY963aahsM5YVZVDaJzVTUkuCEMSrE6rjLf/EaeNIwHdqk4+89exZQNRYSKw2tbHajIorvXiCl6jc/v4Bd8yqv/LNyMjnxP0wHe+oe4tSS0MR80erArhSzFMNNYRoV5UK6fLMxOCjZU1WOC4lYlGYKMA6utOPMbovFRAPjeWX7TYwhdTDWD/tDiKrZUaTJI4H6fCjM7zhj6Jk+IBJW66gLYTE/dCPgraUFug8IYzmpcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcQDOxn3UGp6o/ErCWZL4NpdH1AgZZy6JGAbLwU9y9M=;
 b=m97GlcBJA2bGUSJtJ8kfXVgZ8evtbgAWJvsSGXe7ac0vf338Il8RD87XaLjqaCACytfgFJHpqNtXc5PhY5rBUpmcWrWIInZkZBol4LK5yS3zcpsVGo7BwpV9jpSA9cP0PnST6BfpPKPIg2q3bIfehi2l0QUS72nbyxMfFxSJByE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 09:03:56 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9587.016; Wed, 11 Feb 2026
 09:03:55 +0000
Message-ID: <55b577a0-aa99-4cd3-a408-ffe274e7d6a6@amd.com>
Date: Wed, 11 Feb 2026 10:03:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: Add support for flash reset
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260208183556.695948-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260208183556.695948-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0143.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::27) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 53974516-646d-4685-5556-08de694c7bfb
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXp1ZlFiRzlOTjhqNDM2bWNqbGhvMCs2OWNLN1pTYjg2Z1A3Wm8venV5bCtq?=
 =?utf-8?B?VXFqWUU4TzZQcGl0TmFldWg5bkJuSFNhbGh4aDJCcEdtQm5aVStxeXFMQmdW?=
 =?utf-8?B?YzVzSTRUU1U3N25FSkR4RWFVTk9JY1Qzc0xkNEloUlRMbWF2cktWRER1Z3RO?=
 =?utf-8?B?T25ZejBhY1pPM01OTVJ0aXZ5QVFmbzdYdkRpSDhUa0RYdE4yTkVNMmdmSVRY?=
 =?utf-8?B?SXk0NEg2bjZLc0c5cmtJd1RZd25RZFVnN2RubllOeGw5cWd5ODdJV3JaQTRx?=
 =?utf-8?B?dExzaWc1WWVvNkJPYk03WVM2clN2dVNhV3I3NXhlQkgvZUh2a0luT3JkZlA4?=
 =?utf-8?B?R2dLc0pmNmpXcHpjQkJGMXBvM08rS1lEeWYwaVNBVVdEVytLcmhJK2ZHUWVa?=
 =?utf-8?B?R08rQmdkWkxCSlhNOTIwME5PYWFNM05jd1B3UVNOTjJyRk5TSnkxOHBlYnR4?=
 =?utf-8?B?R1A1WVJIOWVicGNNcHd5V0RYSm4vWUh1SHpuQ2I0MVphUS9rdHhQSmo4ZEMv?=
 =?utf-8?B?c1IybG1lK0FTSVhXY20vc082cTVRUHh4QUl0QXExamJFYUhGNzdWL0dkQzhu?=
 =?utf-8?B?VnZlUXhxOW1LdkxjNTBpalQwZVlUTENwb3dCYlgzTE82TDdDSVBwbndzODI2?=
 =?utf-8?B?K3dacnovUDdpbVZTWVhBMlhLNVRVR1V6SzBUbU1haU9wdWhTZGMyQ0czSFBz?=
 =?utf-8?B?NHB3dUtNVVZ4MzVKQXYwbTV5YVJzcUtZT1IyZkEyR1p1VUtuS3F0aFIrT2hq?=
 =?utf-8?B?TFM1UGN4amsyQUpDQXBRbTE4aWs0amxpWkNlUUx1S0hKLzVDTDc1U1BmUi9P?=
 =?utf-8?B?amxmWTFsUTc0RVpLYnFmdmVHOHBhVXJIV1RnbW9WMzRLamtJdFJmamdxY1lT?=
 =?utf-8?B?R3pOcFB0MTZ5NVc5eGFzVnFhSFNRTE9UYmpwWU53NmRVWWZpWEJtaWsxQk5Z?=
 =?utf-8?B?L1g0UnIzVUM4ejFPL3Y4QUtpT0Q0dGxUcUwvbm5KbUYrTFA1U0Y1SHFicXpp?=
 =?utf-8?B?UHAyK25vZUxabHJieTRBV0lHT2J6OU9zUkM1b3hYZ3JkakltUFNybTFadHJZ?=
 =?utf-8?B?aUNLVGZzTnU5cG0yQ3QwSTUxaE51S2dPUStSZ3J5QzAvdmJkM1ppY2xTMFpG?=
 =?utf-8?B?azd5SWp4eWdtL0VBUE5pUDU3UmRycDlkYVN2UDdGcklOVWlFS2RWQUJPREgz?=
 =?utf-8?B?RTc5b1pyaWpQSUxsbmFSNUVKSlZ5T24vZ05EdWVXYVNPNVVrTGhGazVWekha?=
 =?utf-8?B?a09tZ1JwbWNQQWlRdlRPVXRWQjloM3ovUE9oSmxISm9Gdkc2TGlPS1o1ZnR1?=
 =?utf-8?B?V0xSd2oyMHlWNUR4RFpTUzVIMHZYeXZIWHFMNWN1eFVBL2krSHRCV3FjNFB4?=
 =?utf-8?B?bFFaRk9oUnJ4eWVYK0lMb293dml4OCtIMTMwUkFySGpoMExaY2s4U1pNbSsy?=
 =?utf-8?B?MFdndjR1S29lc05BMkd1Z3lyVWl2MExCaHRScmR2Q0NQYUlVVE5FNFpjRWtq?=
 =?utf-8?B?RjZJeFUwd2pSeXFVa0ZWd1QxT25qYSs2QnJ0di94dmk4TVpROWdlcnZUU0Vr?=
 =?utf-8?B?STY2QVFEMkgvcmFMTGo3T21NSHQvTXFUQXBUdEthMzZVVHdIUmlkUTlrUFFY?=
 =?utf-8?B?bHA5TDRkSkowRHFkTGNoZHA3bTlsRWFPc1JXR2U5ZnRCZmZzUGkwME1kMXhZ?=
 =?utf-8?B?VUt0MHBJL05EVEFWcndoQVl0WVZNS0F6RWZHb3dmeVpuZUpZclhsZUhVcmlK?=
 =?utf-8?B?OC9GT05YejNRNlZZR3haTytXZXZwcG1laHF3UXlYOGlKUStCMmI2NFJneWRV?=
 =?utf-8?B?S0hMYjMzWWRobVFqYkMxUElsMzAvT0xyRi9aaVBuN1RUYUZCN2o4eHdlMUl2?=
 =?utf-8?B?OXBvVmtGdittYnhtZ1QvK0RCNXRhL2wvZzdGWkFTRDMzYVRIL2hnMjNJNkE3?=
 =?utf-8?B?TElVRkJsTVZUcFozV2gzS1hKTkxNbVdjOVRsYVlIZFJRUFltMTgxdUI0ZmRX?=
 =?utf-8?B?Qkd3MXZmWVBnZllkUnFuQUVZSUprWjZmTGFVWVowN2FWTG5PUkc0S2sxSlBW?=
 =?utf-8?B?aWZNOFdHd2U5UGR0N2MrNDJ2Mi9ORGdHTGVjdXZwS0ttNFYyWGduSTdmVmk1?=
 =?utf-8?Q?37KWeeykaG2t+9OIiT6rzAEUj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG9YZTgvMVprQkZ2NlBKaTNSRlZCekYyczBDcjNoVElHdTA4amlQNGFEZVlt?=
 =?utf-8?B?ZkR1cDJpbDVaVlhSTEI1cGdaaWszMVp6WHREVThmN1NiNWExcmxISGpKS01H?=
 =?utf-8?B?QVdQcnFiMVFJZUpkdHpxcytOanYyTVVKU0JwV2NTU3pETnk1ZXZQN1N4SmQ4?=
 =?utf-8?B?cGg5V3p4VDJzSWtDSVFxTlViL0ZoUnpvVWk0ZUw3UlNNcEdLbFo2RW5BTjJL?=
 =?utf-8?B?VTUyM0E1K2pnYU5vTmIzM3RQSUdHc3lINkJKZXk3YmZzNlVQeHFzQ0h2U1ky?=
 =?utf-8?B?ZlVaZitVYTNHaSthTnFBRDduK3FCV3RKdHdOSm1CajV4MUpiUWlmaSt1QXY5?=
 =?utf-8?B?MXBYbWdHTmk1cmRldjZKVlpQb0pNYnhTV1dZVysvUWhUWk9EVVl5bEI0MzRM?=
 =?utf-8?B?b2tNeGVORXc5N2pVVFBFcTdIWWNSeUNoVEJMVW1SRFFEMTg3STZuaHp6aXJ6?=
 =?utf-8?B?Y1lsVVQrTU8rWkg2NGhFak5HM3NoRlcwVjBYQ2JqeXlkRXMzVVdXK0FYU0lv?=
 =?utf-8?B?UzMyUjdLSE1Kdk44OEZNeTU0U1JLRzBQL3lVaitIL3RPa1lLOE52TWNWWTJU?=
 =?utf-8?B?RCtHc1UrN2Nxdk53SlpKVThNZkZMc2YreWJyUVlZUTJ4TGlCTGh4cXNTTlFw?=
 =?utf-8?B?NzM1bmhzNEg5YjJ6di9sa2JFdzQ5ZEIxVlQvLyt3em9GMXpKM2FRU2t3cnYy?=
 =?utf-8?B?djdxUFpMZWlJLzJieXpTZStxNENCWXFzaFJGSVVUUWFIRWJVTUFrV1huU01Z?=
 =?utf-8?B?NCtvYWcwbWRxTXJFZFh5dlZUUnhldGgyaHc5SVowZ2prL2E3Rll5S0ZMdFp6?=
 =?utf-8?B?VXhUblJTL1EzajNVdmdETEJ3ODZtVzd0VkxTQi9HbVRlNDRvVEM5aTRMK2Js?=
 =?utf-8?B?VnpxK3FWSzRlOCswUFY0c1ozQ25Yc2UzSVdOcGhCU3hYWWt5MGk1YjB0WU02?=
 =?utf-8?B?cGthRkNiaTFBUmFzTkxWakRraWNkRlJxUHdBU2dTSzJqSjJnS0QzMEVYVGJN?=
 =?utf-8?B?dXNvMFBRcGRXVTlqSTAzRjJNL3FOcGx2d1N1ZjNpOWtOSVV1ZjVzcGt3MXhi?=
 =?utf-8?B?TWFpd0ljSUdFMFp6ZFlqNEw3clFkV0NmclR6SFBrYjB3KzVOekUxcG14aC90?=
 =?utf-8?B?R0dQNUEzSStHMWl1cXBWazB0dnluWGZNWXljeXdVVDhmelgxM2U2b0h6NVlK?=
 =?utf-8?B?aXZ3RWRLcEJoNnp4VlhQT3pTaE1SSThPa0FTbUdiWkMrQllGdE5Rbk9hank5?=
 =?utf-8?B?a1FFYTd4WE94c25BUHR5RnBuQjMya29mUHZLTEsxUWRoSEJaRUJ2cmJ6ektF?=
 =?utf-8?B?ZG1ZSDh0Q0ZuSVJQZ1A1OXFydS9ZSm4wMnU5VjFkTVFNcjVpM0dxZ0dhU21C?=
 =?utf-8?B?V1oxWHo1MU5pUWlha1NVckUvVjVsUFhaT2V1UWR2OGdqaFRySi9JVktTdUIy?=
 =?utf-8?B?SDVyQkJWTnhMaXB1ZCtkejRMZjhNS2VFMVp5SksvdDEwOTZKcDYyeDcwTTJ4?=
 =?utf-8?B?RzRaaWUzQnZDL2lkRjQ4MThtTnkzNjRQV0tyMTIzZ3Y0d3hlYmtDUDdDSHp5?=
 =?utf-8?B?VmtMVjZPQ3VjeVNwZDY2WGt2NnBJdW8rbXBENG50MWh2c1VjdDR0blBCU3h3?=
 =?utf-8?B?YUxzYTRzUmpVaDVYbFB3T2RzMUUyQUpxS2tqUjNzRStHdVBnTnlKdXJHRUxj?=
 =?utf-8?B?WFpidzJvTmE2eER5OENYTGtBVFcxQVlJd2x0alR0ZEhSWDk5YzVmN1hER3lx?=
 =?utf-8?B?R2hTcEZqeXRNUmxST2k4ZEsxbTljOXo2MGk2MmRNamcyNVNCalpPV1EvWXYw?=
 =?utf-8?B?Njgra2poZFlJMk5ja3paVkVVd3NnU0M3TmFaZWs1akhDR1grWFViWXh4Sks3?=
 =?utf-8?B?ODVPMmIzb1prR2lyQmllU2kxMVlCOG1ab3AzMzByQ0kyTVpqRXp4TkF4ZGl1?=
 =?utf-8?B?ZEVmZ0lKRFZueWR6VDgzZkM1Tmk4RkE5MUsxTjF0UUx3VkdkTzJMVTg0ak9U?=
 =?utf-8?B?U041THZXZDZCVTFEbzk0TkszY01wYUl0STRKemxLeW80elpZZnV2aW5ZWWdy?=
 =?utf-8?B?QS9OTlArYytkYjJrWVhrc3BJVlNDZW40TW83VnVFQTN3cko4M2NOdFo0V2ZD?=
 =?utf-8?B?YUtaamV2K0huZzJTRUtiTjdtSVdqYUp2ek1kcjNoalpHOW9ldFFsS3puWUd5?=
 =?utf-8?B?VGljL2lHWW0yM2NQTFVVZ1ZWeXI0U3R6TXFvbWxmYWpHblJEVlZXdDB4OHRp?=
 =?utf-8?B?VXpCQmQ3ZmJackRZRVF6Zml5bW5hdEkvZzN3WitMUis0cVNvVG9MUnFTVmZm?=
 =?utf-8?B?M0FNbEtVd0pTYWFJR3dkWThydkg0UFNxdDBkN1RraGlUYXVFMStiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53974516-646d-4685-5556-08de694c7bfb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 09:03:55.5550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8uCYJMYiROv8YfJ5vJOr9xNeh0y8u40QLD437OhKE8IDgeH6YDvQjUft/9P+H+S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063
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



On 2/8/26 19:35, Padmarao Begari wrote:
> Add support for spi-nor flash reset via GPIO controller
> by reading the reset-gpios property.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
> Change in v2:
> -Add missing gpio header in the patch
> ---
>   drivers/mtd/spi/spi-nor-core.c | 41 ++++++++++++++++++++++++++++++++++
>   include/linux/mtd/spi-nor.h    |  1 +
>   2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index 76c33b24368..e3de667214b 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -12,6 +12,7 @@
>   #include <display_options.h>
>   #include <log.h>
>   #include <watchdog.h>
> +#include <asm-generic/gpio.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
>   #include <dm/devres.h>
> @@ -4466,6 +4467,40 @@ void spi_nor_set_fixups(struct spi_nor *nor)
>   #endif /* SPI_FLASH_MACRONIX */
>   }
>   
> +static int spi_nor_hw_reset(struct spi_nor *nor)
> +{
> +#if CONFIG_IS_ENABLED(DM_GPIO)
> +	struct udevice *dev = nor->spi->dev;
> +	int rc;
> +
> +	nor->flash_gpio_reset = devm_gpiod_get_optional(dev, "reset",
> +							GPIOD_IS_OUT |
> +							GPIOD_ACTIVE_LOW);
> +
> +	if (nor->flash_gpio_reset) {
> +		/*
> +		 * Experimental delay values by looking at different flash device
> +		 * vendors datasheets.
> +		 */
> +		udelay(5);
> +
> +		/* Toggle gpio to reset the flash device. */
> +		rc = dm_gpio_set_value(nor->flash_gpio_reset, 1);
> +		if (rc)
> +			return rc;
> +
> +		udelay(150);
> +
> +		rc = dm_gpio_set_value(nor->flash_gpio_reset, 0);
> +		if (rc)
> +			return rc;
> +
> +		udelay(1200);

I would remove all of these delays and if there is necessary to setup some times 
it should be done via gpio delay driver I sent recently.

https://lore.kernel.org/all/cover.1770105146.git.michal.simek@amd.com/


> +	}
> +#endif
> +	return 0;
> +}
> +
>   int spi_nor_scan(struct spi_nor *nor)
>   {
>   	struct spi_nor_flash_parameter params;
> @@ -4491,6 +4526,12 @@ int spi_nor_scan(struct spi_nor *nor)
>   
>   	nor->setup = spi_nor_default_setup;
>   
> +	if (CONFIG_IS_ENABLED(DM_GPIO)) {

I can't see any reason why DM_GPIO should be check here when you have it above too.

> +		ret = spi_nor_hw_reset(nor);
> +		if (ret)
> +			return ret;
> +	}
> +
>   #ifdef CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT
>   	/*
>   	 * When the flash is handed to us in a stateful mode like 8D-8D-8D, it
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 4eef4ab0488..8017d0dd9db 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -583,6 +583,7 @@ struct spi_nor {
>   	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
>   	enum spi_nor_cmd_ext	cmd_ext_type;
>   	struct spi_nor_fixups	*fixups;
> +	struct gpio_desc	*flash_gpio_reset;

Do we need it here? Because it is used only once and never again. I don't think 
you should have it here. You can just have it as variable in spi_nor_hw_reset().

>   
>   	int (*setup)(struct spi_nor *nor, const struct flash_info *info,
>   		     const struct spi_nor_flash_parameter *params);

M
