Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB73BD13588
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 10:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 430EB89079;
	Mon, 28 Oct 2024 11:04:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WOj/PMjR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B461189072; Mon, 28 Oct 2024 11:04:44 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9351F89083
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 11:04:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ek6oTC+aMTPa57458oepQpIjiLq8eD54jrm78wfvxaeYa7uBMWu0q2/Ddji7s3IwFObu6DqAkCAS8qHP8dO4eFFw0O2GcxDM7EiaSSbRZr5PDLpAduxWnVCFaDwGj2TV3RzpgPji52S8ne3C/4BL4fLIh0y7QIY05som1uiG6AjZS6XUs+EnV/ov4lVvwGWom2a8YClpiZehx2ieaXqKRyAoNAPWBVx3A6JY56rbzv32RrMy/3k9EBpemzyH+0BQWfCs6pc0ZjPhLYyqU/W/cQM4oZh915mSxmlAm1ewmEDsJ318zGof13f3/fAXDfl/CC0aecd7dH14va5pbPWg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpgCl92SXJzHn3SzKzscNCf1R1ROzmEEnLVowHLv8VU=;
 b=iEPaz+dfReysXyovaYBAgde4dRiVlesbXOhhlk4eW4KpDlJJLq+LWe8AkCTsMLeMRbE6mxuSxn+NztL+m1ECwOqTkZJHmKBzHXbhVg+hjkeOsO64wLYwBN3PWmwKKbJpbLy3I+mCNBH9ViyZcClt9/hgDPke0+SHgHY9qScgaa/d1SHB47hRo70i+DUVFUITqSiFnq6KiF+JptosoApTS67WBQA/WLQ+GCSyQnHT73EIrezVFtgKjehgGsfrqv3m5dUZxz+/JjUvISV41vxawV6ldQubcOUtKyvBW1GcxoRModrTURqEIfkaOudJfRji1HPTvJis5G8vEQlwLWO8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpgCl92SXJzHn3SzKzscNCf1R1ROzmEEnLVowHLv8VU=;
 b=WOj/PMjRj68lTDgcq3mhxdoWBeMSq4CdMDBzDyH4n/FS0T2bLN4kRLimo0IGHSOBtRejgnOWzMt8fgqBpKedU86TiQYNdekcoZYWIHmDivoHnjJhrCDTdsZs2/sHQQEjtAsIV/942B11Ex8BbF0ndwWQZ/RrV8DbDTHcLyFttT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9076.eurprd04.prod.outlook.com (2603:10a6:102:22a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 10:04:33 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 10:04:33 +0000
Message-ID: <cf0dfa6c-4bdc-47db-8847-2575b44f1384@cherry.de>
Date: Mon, 28 Oct 2024 11:04:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm: core: downgrade some dm_warn messages to log_debug()
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alexander Dahl <ada@thorsis.com>
References: <20241015-dm-debug-less-verbose-v1-1-366e8f00b556@cherry.de>
 <CAFLszTgg23HAJ5duUZDnhoX+xvbPCpdtrx0CUVQytxm8sZRsHA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTgg23HAJ5duUZDnhoX+xvbPCpdtrx0CUVQytxm8sZRsHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 30bb0d95-aba0-4caa-6725-08dcf737eb91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0NsZVFHREtjc0pqZnRPNGZYVDJmamhwUHYrZ2daZGhwVzQ4V3dRSlE2QWtr?=
 =?utf-8?B?Z3U1SGd2Q2hEeXhBbEJYdG14ajAzL0xJTmdhU0NSczFVUDIzS2dKU0g4S1hF?=
 =?utf-8?B?REI3MmdXT1ZPZG9qUEh5eUNtQVVPTSt2VkxSbHJOZ3kyWVFQdDdrSytSNEtZ?=
 =?utf-8?B?UUR3YU9GVG9vaU9wamU5cXc3TDFUS3U1clUyZUtUSkMvcGVmRjBTRXltY3E3?=
 =?utf-8?B?Ym1kTGcvVndLNkJrVVVkK3R0YlhMb3J4YUN1UjNRQ3hxUGVKZUZ4SklNN3Bi?=
 =?utf-8?B?OXBvWG4ycjBsQmZ0NEJOeXhRTlNScUhaL2Z0RzBwRWZhREt4TDJZbEc0UDEx?=
 =?utf-8?B?N0tPSW83Zys3WHhZbDZLOU5BeFh2QkVOakc5ei9RWk02dHRSMkpvUUg3WUdS?=
 =?utf-8?B?T0g2NE1MdjV5cUUzTXRZdldId0RTd3FPR0tMNWdqNVNlakE0ajBISEhLeDBQ?=
 =?utf-8?B?Z0pGQU94cXYwNDN5RU9xL1IxVGtKNENuVkhEcTBvQkJLR0FDU2tKclNFTk1r?=
 =?utf-8?B?NHBJYXRHT1dmUXJxYVZSOVFjN3JmdUVZbnQ0R2JZb1I1VXgwcG1iWGR1Kzdx?=
 =?utf-8?B?UHNBbm9md0U4SGM1VDkrVEVZRWpjYUYwckw1TTRvVzVLSVAxTkh4WHJMdGdN?=
 =?utf-8?B?cXR3MFVTYlZMd3JmcVBnc0pxRzk2dXR5U1plV0YwRlVxRElDRmtKTDlWZTBY?=
 =?utf-8?B?aDQxNExUVUZOVWFwT3JWMnlFL0x3dlFrRzFVaW1JVGNSdWpyVU8zL0QxV0NZ?=
 =?utf-8?B?alZ6U3BqVUlULzlkVVQ0b1RGNk1nSlFudy9PaWdmNmNLSXdMOXkzdlVYTzlk?=
 =?utf-8?B?QjhGQzlKTmV6VnZGWE4rR1BRc1JPQllrcVdkVVdFd08rLy9MMEFXbHdEUEE2?=
 =?utf-8?B?Nis4c1dpSFkweFYvcjZwL3phTk1kODlFUFhnOXFOWmZrNXlpcmloMjRGeVc1?=
 =?utf-8?B?WVUxSVpvclhwYkJIbDVJcDZDNTdCeUxpVWFLTWlqb2h4bFNFaFZvVGlvRUpF?=
 =?utf-8?B?eGpuZlVOcHJSYmI3ZkxvanF2WU5vWWE3a01lWXdVZ0xwaWliVTdZa3JobHdQ?=
 =?utf-8?B?eXNNTm5vY01xK09pMUNmd2hPMkNhOG9pbUVmQ1JqbkFKQ3VENXBqUzdEY3pt?=
 =?utf-8?B?S1c0UExZV2hpYzBGNDZ0UENsZTlqUlQxOG1yNzVBQy9TSUs1eTQ1RW9EMlRq?=
 =?utf-8?B?UmhEVHVkMy9TZlg3T3BFbXVwK2FUdzV4UmhEUXlsUDkwMkVHL0U3UmxUbmJW?=
 =?utf-8?B?Y1RSMmVRT01TL3V2OGgwaDJXdE5xMTVrd3ZMRWJKbjNMZ1RmVmNDbk91bFMy?=
 =?utf-8?B?MWpNdjFtdXlUSGFadExhUXpoQlQ3cHhxNnZLRy9peEJTczFjaGJlNkpFNWdL?=
 =?utf-8?B?SjlhbTBxU0ZRemR0STF4UFRkVzNCM29XK0Y0a0x1emMrOVBMWUhwNmpCSVNu?=
 =?utf-8?B?bTlKeTQ2TWVRY2txaGFCV25kK0lieVV2Wmc2Ujg0MXRySld1WHRmdHhiQnIr?=
 =?utf-8?B?S1NtWWQzV05OYnhCSnE5RmxVdDdlMHNvcCtLVmp3SG1WcThsUEdCakxPUE9F?=
 =?utf-8?B?dkRLWHJ3RlJEdlZUL0hsQ21HMGQyUkI2RmVIcWhBRFNLUjk4SUsxTzc3QkxC?=
 =?utf-8?B?UGNGanlZc3F3cFRzYXlLUHJSNlV3YjFGOUNsN29JM0hRaDRlYUJ3enlHSWkx?=
 =?utf-8?B?S1JkenA0N0JGTHpzRmhGQzM5UWo3NDVwd1V4aGRtZzA0Y1V1d2o1Zjl2c2pL?=
 =?utf-8?Q?gONA5NWqHTQJeJ4/8m2eAVuTy2UJyV4CjjXsre1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnZWd0RuM2w3c0FtUVJRMGR4azFZV2YrMmpscVp0SWpkTExGRnBxd0xWbm5q?=
 =?utf-8?B?NVJacHE2MjdtVDJKMHJ2cEMxWDA5ZXlZQyt2TWg3THZKQmRQcHBGdXZSbUE4?=
 =?utf-8?B?T2xNZVFwbTVLNk1iaGNPNmMzK3lBN0NpSStzZWpsb1FUZitueWtyUWlIQjdy?=
 =?utf-8?B?SkJGQkNoc1RuMDVrMy9rMFlOOEoxTmNuU1Z3V2lDQncwYjhxVVZnQXh6VGo1?=
 =?utf-8?B?WWJiTVpzeCsvWG9TVFMrNkhnS0ZOdUFLVExYRDRidC94Q0dic3hIU0JpNmh2?=
 =?utf-8?B?VUZNa3VzNUhvU3pPUjhvbFFhZ21rOXVCK3R0aExzQ2ZPRzQrMGZCb0FaV1FN?=
 =?utf-8?B?SUp5cVJnb1hKdmorMjFoZHc1Ulc1YUVyeUErSy9tM3Qwc1VmWjg2U3V1RS9y?=
 =?utf-8?B?bnA1S0xscWFiUks1Rm9pcG8wWnhveDRlcmEwcDQxN0pjcnZzUU1zdmhwdVk4?=
 =?utf-8?B?VWlWbk9ROFNNRjExaFhseXpacWpQQjIvbXprNXNYcWZyVnQxMTd4UExvTWE3?=
 =?utf-8?B?d3VZREV6cHpJczNaREdIbkI2VjNPWmFjSUowLzJEUGVtNUx5dHFIZnU5Vncw?=
 =?utf-8?B?bWxVdThGaFA4eVVCcjhndmNRbkwrdkJISUU1SHM2eUg2UEZlODNtZHVmR0hy?=
 =?utf-8?B?b256Z3RDaWV6VXhjYmVtdS9aZmhqelloWEE5SDVMT3g4aW9Mdy9McUxFS1lX?=
 =?utf-8?B?WlJjeDVMNXJncGU1WC8rdTNQeGQyOFdjN3dORzlaYmZGK3Ntc1d0VjY4OG4y?=
 =?utf-8?B?RFB3aTRLdTNOTnZQak9KUHVsSmd5TDRqM2N4VG9nc2hjZXpIMXZyUFp4cytI?=
 =?utf-8?B?dXNtMlUzNkplMEMzTWZuTDVabkY3Z3VoTW8rRkxIb21paWlnTGJTd3FxaTZS?=
 =?utf-8?B?QjRxTm9HdEpOa0R2VXNXeGhDdmRNdnltVTIxY083aWtlNng0dk03Wk9xL3Z1?=
 =?utf-8?B?SlJhcEg0N3duQkFJQmtUcTJQdkJraEhEdHRZbjR5Z292ZTNza3M0RHJ4VGdH?=
 =?utf-8?B?S3NkM3gyQlRyaWpRdVBxRlI4Q1lqYXNFSjZ0c2NPMGpZTlhKNitCV1ZuUkRm?=
 =?utf-8?B?MDcxWEJTY05WNmR4RDVWTzM2cEw2N0Y4Ym45MDBTVEl2VzlXRFlqdnROR0RC?=
 =?utf-8?B?MXdvRnBMTnEyREVvQkI3UDlHL3lqT3d3cHQ5N0xFSmlyWlhrUnJDNmQwMmdm?=
 =?utf-8?B?SUExS3JGRW5tS1l1UE11NHdJUis3VkNhbkZ1dmNIc1NRRm1iOTBkOEZhd0xS?=
 =?utf-8?B?aXVxOUNORHRkZnhvTGQ2aXB0MzlkOFhWZThnY2Q2a1JkNGxVUDl4aHUvZ1FT?=
 =?utf-8?B?Nlc2dDY2ZUVTakNoTVpGY0wzRFl6VVVoY1VLa0F0S0NTbVFjdklCZGRHR0Ux?=
 =?utf-8?B?ZGJNUW12SFRVZ0pZZm5XV25vc1BiVk9tUHRFK3RSWEU4VWtqRU9QNWw0UjFY?=
 =?utf-8?B?UDZ3WnZlcFJzOHY4c2xLSU5KbnpUcjlSc3Iyc1R6NlREMTdaVm5wN0IwODA5?=
 =?utf-8?B?TkhOdElJUGFBVHZZN1JZZHFDaTM0YXVDSEhqU2lyQTFuMmc1bk5SYU1KVHVG?=
 =?utf-8?B?MkdMOEhKc3c0N3UvREtGRjJpUzZZVVdpeCtKNHNMYW9XUjlLTzdCQiswK1BE?=
 =?utf-8?B?UC9LY1Y0cVM4dmhlMGNYNFNUYVhQbGRtNkhkSmxjM3duWnJvT1NuZ0txZUdk?=
 =?utf-8?B?VmROOFgxWllJU2JvY2c5TFpDYkVhVzBKZHdFZVN2V1ZoMGRWS2Y5aWsvVE1q?=
 =?utf-8?B?NDdERUFKVTNITnZLZjdXa2I2ckVwOVVnMEowNUVWLzA3MUJXQ1NLenFoY3c3?=
 =?utf-8?B?Mk9yK3hYNzFRdzNsRkRFdWdDdTMyU1ZhKy8xVnptRE5RK1ZrOWMzT2JqeEtH?=
 =?utf-8?B?bXc2dFBWWWpKRk1WbWJQQ3hoK1htUWxmNnVkZ2ZwaXVSMVhIZDN2a0NWZjcx?=
 =?utf-8?B?MEJVdUtrOHE2Wk5MZzlXeVgzdmdlRXE4U0hjYkFNZG16bmcxUXVuaFo1S0NF?=
 =?utf-8?B?eityQjZsZk93WE0reTBaYStET092dmUvNmtGL01mQjZnbGFZSFY4QW1nYVN5?=
 =?utf-8?B?Z2dXb2FYdERmSzhrL3p5U0RpMGFRM2F0V0c3ZzBsb2tnMDBFUDBVMXpUZXlm?=
 =?utf-8?B?RENNRmRsMmluVXFYbnFOVHlCaWIzWE41eDRxRkFvTEtrSnZVb1I3cDJodkp2?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bb0d95-aba0-4caa-6725-08dcf737eb91
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 10:04:32.9103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgZkC8VvUml93MkV0AF40jGoIbth/CGSP9kFc3CFShfWkYCyc3wQ1UKQUrYqF2EP9lzSsihASH6BIw4slr3XD767pDo4TAzWe+uMpKrNiMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9076
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

Hi Simon,

On 10/27/24 6:16 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Tue, 15 Oct 2024 at 16:32, Quentin Schulz <foss+uboot@0leil.net> wrote:
>>
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> People complained that enabling (SPL_)DM_WARN was now totally unusable
>> due to the amount of messages printed on the console.
>>
>> Let's downgrade the log level of some messages that are clearly not on
>> the error path.
>>
>> Note that there's one pr_debug in there, because it is followed by
>> pr_cont so it made sense to reuse the same family of functions.
>>
>> Reported-by: Alexander Dahl <ada@thorsis.com>
>> Fixes: 6afdb1585112 ("dm: core: migrate debug() messages to use dm_warn")
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> Note that I am not entirely sure about the "not found" and "not large
>> enough" changes there.
>>
>> Another note, %#x isn't handled by tinyprintf so it just prints "x"
>> instead of the value.
>>
>> Finally, I don't know how one can enable LOG_DEBUG level without
>> enabling DEBUG which enables assert() so I just tested that by removing
>> the #define DEBUG in include/log.h :)
>> ---
>>   drivers/core/of_access.c | 36 ++++++++++++-------------
>>   drivers/core/of_addr.c   | 26 +++++++++---------
>>   drivers/core/of_extra.c  |  6 ++---
>>   drivers/core/ofnode.c    | 68 ++++++++++++++++++++++++------------------------
>>   4 files changed, 68 insertions(+), 68 deletions(-)
> 
> This is an improvement, so:
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> For -EOVERFLOW I think warning would be better, but in that case you
> need to print a prefix, since otherwise the warning will have nothing
> before it. So it is a little tricky. I can imagine some support in the
> log module to help with this, although I haven't thought about it too
> hard.
> 

Agreed. We could also simply print the propname in the dm_warn() call 
and keep the one at the top of the function to use dm_debug() instead.

> Also, we should really remove __func__ when adding logging, since
> people can enable the option if they want function names to be stored.
> 

But then we'll have a bunch of functions printing one of their 
parameters and "(not found)" for example. A bit odd to me. But on the 
theoretical level, I agree, enabling the appropriate symbol would 
already add that line, it's just that I see limit use of those messages 
if it's not set.

Thanks for the review!

Cheers,
Quentin
