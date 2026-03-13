Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EACA105F796
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 10:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A48498423D;
	Fri, 13 Mar 2026 11:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ywpueIy7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B912A84221; Fri, 13 Mar 2026 11:42:41 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 724438420C
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 11:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNHMu/KnxKe0z+R+GwiiqxsDONJ9HN5Zjra9j4mgVXRpjM1GN8uIFWX02C2TC3VEgDc7YkeTiTeNBNErV5p5iNPO6UKRXLUF7mMy98f0j8DiFpmhLid5XTTzlb12oNSV4Fj8PPKWthgU43xLBMlmG5ZvERX95ReQtrb7NPHnWaderai0rnQKON7w2INtLRl5UhDv7XmfVvvyhA7WAMqtulrRJLbZRVnaFMMv2sBtTGa8FYX4YiwmqYeE52APCytGcm7sODpIjVl1a3WrGCKpGwA8qsmqV9aJHVrCNDz2Tg58QficS8d4TrnWhxmWshLkkTnMCu2WzHa+8JAQ2ejzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JT+6MN2/aIYIJLhlgg9pK1fvCgKRxQT+9x1Iy6q3Cik=;
 b=blHQ6cT3oBKFkC5vRwggCG4p4HXQjhIm95b3Gu+CoIPlNH/tlcTEhe4uM+3r/UZcfsueU1Ng1D859OIxlXQXo4k3a8Epk+l65GAgQvl+CUDDw+X4mOqoxgTqd+bSGR13FGtpk8VoVegkvrjn87vJoIgr/QPqtBZ2aLawV1er5h7INFrFbZVcQSBUB2Y+Ow3QiV08Ezh67HntIlhxIlSqTpS6BiC0l6yP16b5H2xmxrPeZCaQm03oT6DAfd0rZKFmxTnKBwXuSGQadkPfPgtMMCBxFOzmrHBs9PorPG6h1H5A/aqICJjQJ+TubRcnjRJzN4+TYSpzft9PQEiZSf5A9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT+6MN2/aIYIJLhlgg9pK1fvCgKRxQT+9x1Iy6q3Cik=;
 b=ywpueIy7m9syLQa9zyk3Xzhe28dbFnd/v8sUXF28ZOzefRT8++0+815O9+B6HlwcNhT5FyxIbjohy0aYDFbrjmZrCCGokaZl7VDEUInrRQPtzyr9W3cS6MAx8SGh7BomVKRe9dW+coX13xCTq1TkuzduJBmuEZ1Enly0kZALWsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Fri, 13 Mar
 2026 10:42:34 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 10:42:34 +0000
Message-ID: <805030c3-4474-4f05-aa71-78b6c69a5568@amd.com>
Date: Fri, 13 Mar 2026 11:42:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: avoid superfluous variable store writes on
 unchanged data
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, git@amd.com,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>,
 Tom Rini <trini@konsulko.com>
References: <00b03eb724de3e8b3e46ec630860e751bdc40011.1773322038.git.michal.simek@amd.com>
 <CAC_iWjL2OUZCvqAvEtdGHUyihsz6dekYsBYiP90Fi3wqz_H8yA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWjL2OUZCvqAvEtdGHUyihsz6dekYsBYiP90Fi3wqz_H8yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0055.prod.exchangelabs.com (2603:10b6:a03:94::32)
 To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: af9ef8b8-35d4-486c-a830-08de80ed3cb0
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 74ntNfqqYaNy1HXBPnkfM6wngZbG0Y3oJm7LH/8jYLKb2CJWIfpeBU/NBML0D5a22KPkFH7uSWC7cj2y7IPtJzVeXrlPwOD1/UjsITBnB3XJwuhpwhx+bPjwr/tcYqHlGmWwaOVXtqa2t4Y94ktwhJ2TssBBez9tWQrQEqyBRerl83Igkoj9t4FDQ4xuqQcl9Wj8GXT3tSX5Y6joujPCF1tHzVgiIXMRqG4+AuU8qD9ywT7Zo37LaN8824/S8hSI4pImJfVcZIR1wICRXGhZQVuuLjF9o7POg/fZ8LxD5npnCXYaL+y4OorauytMuq/0wTbzGUiXD+qh+2qSPvPcjoiotG+IdDwyqioCGHimN/yi8VJGr7mWfwrEoqRcNtc/NAkE0AnyhccVCh/h3WJXPBb83MCIOSbkEsLuuvgBjedyTkB9RmaiHqZl8p8Z/ENdjYe6fiy8baLwixI8F525fwC3kutVp9VIPK7DzEbZQTF7BZWKwoi0khtG5GNKwf1C40WjoAlSuKlL/UpieZ3WULcZCBIPpYgh/R54nKzYp22FI7n3tFM7vmAtosFUztQwh9Yp47qPDS8xS7kiq4Wy7cVwgJiPFYCU9JiaI4o+VAcCMZD3Q6w47BEQqYJNwpISTyBk7mDDHjUylVyLo5k8Pb4RzDQmbcCJgvT7BR/08aNkSyxfIoorlaed3QvmULsFSP/NDAPY4C5fWgcdz6Fp+WtsSsCbGf8ICb0SkwrfaV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5KdFh5UW1VYi95K3RGa21rUzB1WlorYmlUVFFlMDc2RVBBVkN6MllxYnl6?=
 =?utf-8?B?VGZCd0xpVDVoblBnYnNUR3pDckJZbVBqaS9JUVl5NHBTUk1xL1BUcTdFV1g3?=
 =?utf-8?B?UTRaY1ZaeVFPNmRoSGV3S1QzZlJaMFNJUVlqaTJ2RUswWis5cXB4eFYwYkR0?=
 =?utf-8?B?dHZjTkQ5Z1M4Rm1OUDNZVW9lZ3RjdFRoRDByMEdXYnljcDhYdXh6UGozWGNU?=
 =?utf-8?B?dWhUSUtNOFdtcFl6OGYyblIrRUxxSENxMjVESEJBeXhLU2VVWnpPNTVLU3Vq?=
 =?utf-8?B?UE1URTdrVk8zNklvVkRRai91THZqMDUxK3g3TGVHS1o4aW1DRWxoSzZjQlh0?=
 =?utf-8?B?N2o0MG9Da212R1c0bnZBK3diUk5TSElnc21ZbmFuYStoOVFKK0w1SVorRThX?=
 =?utf-8?B?RmxZR1QzejV1RGFGNWlra0NCL3lsV1l1Z2lzZG1XNkZmSy9QelBwZkZDeXhF?=
 =?utf-8?B?QWFnRmJzWHdFWVpLbjNUYkNHTUQycUhxMVNMcis3WUpJVmVRcjMwRnFVZ3gv?=
 =?utf-8?B?dldleERGMDN0dHhUNkkwdjRvRkdiUUJZK29sSnR5T3ZHY0xBbHlzd3ZpNEta?=
 =?utf-8?B?VVFtS2s1VFBPRFE5MjVVank0TytUeTFDa2tzRkdaRExocmNGUm5zVkg0OHdj?=
 =?utf-8?B?UHlqcXNhWGRlVnduSnI0dlk5QzIxQTJyUk9LL2U4cklyOHRJakp6dXFkVFNC?=
 =?utf-8?B?bUFIYkJFZEZOdW5KQzFOY04wb05rRkJGRjdDRlA2b25tNzhyK3JYQno2SG9r?=
 =?utf-8?B?ZWxlak1LNDB1VlFtMEtLRE0xVnlndE1PUnNNUkh3UVhINjVHMnBMa2xXVVAy?=
 =?utf-8?B?Q244Vmt0ZllVWE5JMjVFMEhYZU40ZDVqZEFsSlc1M0NtVDFWcnVGSXZsY1Mx?=
 =?utf-8?B?N296TzFHQUhpbVorMDRqTkVvcElyOXFRRURIWWRvOWVyQ051ZEphTVZwUnBJ?=
 =?utf-8?B?Vk9zVzhuaHNqNUhucjlldUd5Mmd5NDhyQ2VKV3FqeHcwSmQ1MHZOWEhiSFpj?=
 =?utf-8?B?UU4ydExXaTFza21nNjRLN0FSUHI4YnU4NTFBR0pjYmppbnU4b1h3R1dBbHdo?=
 =?utf-8?B?bEVzN3d5UnJ4Yll4SjQ4NTROY1pJdm42WVNoT2NIRE5nNHRFNVBTQm02d1BF?=
 =?utf-8?B?YWlzQ0tKVE5rTnBnMXhrQ21YOGR2d2I4Rnk2Wlg2bjFoWGN3cVRmckNYWEJv?=
 =?utf-8?B?NXVmMElWSFhYYmptbkEwVU8zTm94dG0vRCt1L3BtR3Nlck9lamtZNkVjTkcw?=
 =?utf-8?B?aFRCK3VDaWw0LzhReklaL2UrMk8zeGQ1WWZHaS9ONjZCbXMwaDRaV2dSMWtk?=
 =?utf-8?B?Z3VNc1RhWU9uTUhxbzJ5YlVNdDJFd1YrUWNadzZLb0tmbzVVWThrSlBtQXkw?=
 =?utf-8?B?QVd3UkVtSUhiV1FUVFNEb2xmYzN1Y1pJVStmTmNaRVRxdk9sWHlrZEdONEFB?=
 =?utf-8?B?WmJVekh4SkZtTnBodnl6RHdLOXoraUJQam9LbUZ3cVhTaTM5UFByYVZjdy84?=
 =?utf-8?B?Yjljd3hUTXE0N1ZmS1o4OFRwRWIvRmFxSDJPRDNEb3IvYjQ2Y0lqVll6L1FX?=
 =?utf-8?B?Ui9RNVVHUUEzOUhzNjVCVkUvbnBYck9OYmh1VXV1NTc3L25ObTI3TUhRSVNl?=
 =?utf-8?B?cmxGVk5GSWpBd0dyZ1dUeTJLUHhKWW9Rd2JjeVQzazNxVTJ4VUg2SXluSkZ6?=
 =?utf-8?B?bC9ORGZuc3BVNDMwcHE4VS9YRG4zeEFEcTRGVUU2QWNyeFhhbCt1enRIblBw?=
 =?utf-8?B?d3BVWExDUjZjblIzc3pnNzIvMWswbHhVcjdZektiMFdQUjN3YldGNTBsYlFU?=
 =?utf-8?B?NUYrcGdtTjhKaXpKTzkvYldjM0xvT0pLSGpKcTgyTE9NaW5DSXMxUFhETEky?=
 =?utf-8?B?WW1mZHNuam9ocXZEUDNMUUhNUWVxQ2xKY0gxV05pN2NkMEs5UnhHWUFPOU9r?=
 =?utf-8?B?dHFBWTVJN1Z5V3YwSzM3VWVIZEZyN2ppNHRnb1JhZnc4MXJYakdMM3gxSUNF?=
 =?utf-8?B?amVDUzI1SW1nazBNUTJUR1BhVzVUcTNldUx4Nm95WkJFaTg5b2xQNS9URTdi?=
 =?utf-8?B?TitVL29Vd1A1ekdLRFVOM25lbGtVQkF5Y1NYeUYzTnlTSEFBWWg2eVZoUmV6?=
 =?utf-8?B?Snh4bkorODN4RCtTMlg3d2REcjc2TTd2RVVNTk94QkI0a0gxL050Y2JTYkc0?=
 =?utf-8?B?R1R3d25sd1BPeWc5RlhuYU5HbEtuWmRhOGQycTB6dmF4cVh2bWlSbkN4WEZs?=
 =?utf-8?B?Q29WTEgwZzJBaWFWcytia1BSaHNXTit0WG1SS3NjUDdZVGNSY21iZjlqa3p4?=
 =?utf-8?B?R2N4eHluam1HUm9ueGZ6RUtGM01CT0xERWdkKzhtOWdnblJjb0N6dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9ef8b8-35d4-486c-a830-08de80ed3cb0
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 10:42:34.8524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWV04GjqgT1O+tAz2TsfuRbHnLXGI+32RqeJXlsNqL17Sd07tCYz1KZJlGhw4w92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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



On 3/13/26 11:28, Ilias Apalodimas wrote:
> Thanks Michal
> 
> 
> The code looks sane apart from the runtime part.
> 
> [...]
> 
>> +
>> +                       if (!memcmp(old_data, data1, size1)) {
> 
> So this will probably blowup in Linux. We had similar issues with
> memcpy and added efi_memcpy_runtime()

ok. It means you want to just do comparison via loop right?

M
