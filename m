Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D2FC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 15:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E50805E7;
	Wed,  5 Feb 2025 16:15:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kxzwJxcz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32BA3806C9; Wed,  5 Feb 2025 16:15:42 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A17D780562
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 16:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMRVA4U7h5+acGzqJLuCC6X9Q2LXxK4v4yWwuFZu6h86vfET4y0vecwgRjQV40KtXIHGXXlP4hDjOgutS22h+qSMw/xp6FMECzxWShe27lOD+7P4Ub9CJ9hxJ3u1wxNICzfGoHQKipaXybxahBuYwsTBO47fQzfwS3wwK4gKIB3kdOPNfptp0pCb7R84RsgW4jb99MrqaVStvh7dq+cbh1Dj3fBmZwPvvcQsjerQx90BTi31xUzHGUk2ReRABWPiLV9hCp8rm4PW4VzkbFF4o3UGBdvvDkBLakkg6l6A+ygaLIgYfLVEupXyUYk5ZQB1TYY/bTzunUQANGVAuxguiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mK4KpFGgedf9xbhE634sgI9MubE6s59+N4Wkv12HQ4=;
 b=R4/82yIV9UoRUjBDzq2Xqxv1LJFQuFNg0rUOslW7E2FeXVq8R0tYDHb1uDg8GvhUKkKfvFu5ozokoQzNmG/uygv/XlTK7bumO7zKeSNfth2Q0iAMHBiOnK+bQ/ktdaO/Jf6kPja1fzUSl634dhHPR7e2DQ0rF3CK6q85dndtaigzHEHOtwRn/Lizk204775spq4G6/BC04oFOn5PH0a+szMm0VFZ1s/TpNEdcngC1iXWU48u3vf6ECjWVAPY9Gvwhywc7IhLbM+7YCjhCv37zyaSBcXh6gghCvkklp6cv7teD7K9UCZoiEQsWqMe9C2TI2r1VF///SmyE6gTBiya0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mK4KpFGgedf9xbhE634sgI9MubE6s59+N4Wkv12HQ4=;
 b=kxzwJxczknmnYgyhyo28rI56PqKNVpJX1cg4I8qmkMMVBB5/nCAvsVkWlepmtc73/jAok9HrJAV+KgUERsDj9/qD+hs6uGBGmj/SCNrYrfdoD0b2b+VloL1UvNL2Zx6KL9pq4TeSNm4PVJ68zNoGjF6YdvvLgmyvZs+uiTWbwGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 15:15:34 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 15:15:34 +0000
Message-ID: <5318e411-1114-4cba-bd26-74ea9b178b5e@amd.com>
Date: Wed, 5 Feb 2025 16:15:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: versal: update initial stack pointer
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, venkatesh.abbarapu@amd.com, Prasad.Kummari@amd.com
References: <20250203090409.844403-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250203090409.844403-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0166.eurprd09.prod.outlook.com
 (2603:10a6:800:120::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5e5abd-e927-4c37-e247-08dd45f7f02a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGJVcjc3WjgxclNrblhMNWpqaWl5dkRpbVBvdkZVemNWdmNNNEJFbnhqOURZ?=
 =?utf-8?B?cFBMV0FoRGlDWDA1d3pxcEs3TlBNWWJUWnhseERZcTZKU0dYYVFCNHJWNkZh?=
 =?utf-8?B?N0Y0d05JN0ozV09KUWVmenFRdEEvci9OTEgvUU5OM3ZGNzZRZGpDN0FTREtj?=
 =?utf-8?B?N1hnbjkrVjhoamhwN2lQQ0VDamExQThuR090TlRJc0Z5L3lLTW9ielVWTFdW?=
 =?utf-8?B?KzdTZG4xenNGalZyVk52VHRxcVpqSExpOGhtYTZPUVdnRVc3bTg2TWlkMUxV?=
 =?utf-8?B?MFZoRmpYTS8wRWRyMys1aXhTbEpMTC9vbVdISldBS3dveWZjaGc4bk14ME1D?=
 =?utf-8?B?U25FekRSUjc2SlNVd1g2WXZUbXUrdEVTV2dLNEcvOG1aWkFkWlgwOWVyT3cr?=
 =?utf-8?B?amZGSU1hRXVBWnE2cnM5SmhTZVUwK3ZtY3J0My9ldys1TzFxb09XNnNlV011?=
 =?utf-8?B?RHZkQjNKdXhSd24xb29ybG1leEdKa1NFYmgzTjlTRFlUZkp1TC9VZkcyNW01?=
 =?utf-8?B?djBMQ1JmNE82QjFoejFIZXpnN1RMK0F5V1A1RUNSR3gyK0d4c1VwUDFkL1p2?=
 =?utf-8?B?bmdhSFNiY1E4SytDYU81K2ZnL1UxUFdteWlqc21tb2JsQmY5aUJScWZvZi8x?=
 =?utf-8?B?NjFtUnVzYS9xY21EOXlhaTRzSVVRaDk4aW12TDdsZkJOdElKc1oyTHJCRE1z?=
 =?utf-8?B?WG40NWp4UmhzNEdTM3h1dU5BNHRKVzh4UWtUdGZsMURsdXBnMGVaek12U3lH?=
 =?utf-8?B?Q1o0THh3c2RQQTZVTzBCam5zbXBPWWV6WWUxak05NmtyOTdBMXVRQXFGVGJa?=
 =?utf-8?B?M003bkNENmF6bVNuemRmbDljclZmVndhdlduNXNtTWNWZ0N4VVRmelVLQ1M5?=
 =?utf-8?B?MWJiYm1IdmN4ank1QmsrVEQ1Q0tDaVU5U3pha25PVm44RC85OHJtYXNtTzNS?=
 =?utf-8?B?SGdaNlR3cTBVbDNlb1c3YjdzT0FPSHpqL3dycUVtaFJPRzBNN3F6T21uU0Jn?=
 =?utf-8?B?NXVxWG5RWEx3aGxzN2c5bU4ybi9XYW14L1YvQ3ZiQnJEcDA2UDRKQ05DRzh0?=
 =?utf-8?B?RXVFQVVRTUZMT2tteE4yNGdwWWRyTk8rcnlGWFovTmF0N2RsNEllWEtuRUls?=
 =?utf-8?B?MDc5RHVmOGY0T0ZMVlRCTEhtcVAxaitlanFneDRMZW9kV2lBN1ZhdENySERU?=
 =?utf-8?B?UmR3b0kwc2hWN2hCSzNWR2YwblhyY29MT2gvdHhtL0FVQWozT1VMWFhmRnR5?=
 =?utf-8?B?cU50bnQxbk5oSXdKcjNvTzN2V0hIV1NEM1BSQTBsMWpHMEpkWUZxUVdrZEpC?=
 =?utf-8?B?MXFkbm5HU2hZOEM1cmZjWmdMK0Rxb2xiWjZ2K1VwZlJvcUc0NWxOalNFa05H?=
 =?utf-8?B?bWVlRk82cWJMN2I2SEJFS2hjQ3orRkIzZEt3RzRxQUJ6R1hXbDdXdEtiWTFI?=
 =?utf-8?B?RjcrcmVLWE5STTJ5bExDQk40Z1lpaUFOcWZGQnh2dVJxU1A1UWNkbzNIK0dU?=
 =?utf-8?B?b1pESDB1R2dCZHZBd3NBOXhhKzZ5dnd1YWUrVC9mUWE1UDM2Q2ppcWpyQzY0?=
 =?utf-8?B?NWVsa25FaVZBdStpZXpsZjhHYm9yTHNrSXRScDlobW1vNHo0WE9BY1lSQlN3?=
 =?utf-8?B?dkhPODhmSHZUS05Oc3lmUXR6eEJud1ZuaVBSSUM5S3YwRzdpc1V0akxraUdZ?=
 =?utf-8?B?SSs4cWVZN0loVkltMU04WngzbGsxTHR2cEhIUXlkR25ZdldGMHk0SVNzTGp1?=
 =?utf-8?B?ODdCMnpyL0s4MFlhY2dUZTd2dmZtNXBMcE5WWmRDazNOZTVHcjRPdE03dmNz?=
 =?utf-8?B?K2xjUGdvMXJnRkpWbWtubnFVSVdxZFJPMWRnSVFXMG1PUHBtSVdCSnhuK0tS?=
 =?utf-8?Q?H4vZkYGoiqNpS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGNVY1VneDhXUjNzVlhXUmZXUlo0MXR0b0Nna21tVDFQUmprcldvK3JDUkhl?=
 =?utf-8?B?UURkK21EZC9KZmZ5cXVXTzB2Z3BoOGYzQlRZWFhkTklHUGdIUkdXZFVHc1Nh?=
 =?utf-8?B?TmJRcXdELzRmRWxrYnhBNlhNalovUjdxWVZFR09yM0hsSEdSRUZqOVc1TnVE?=
 =?utf-8?B?eWJ0S0U1cUw1aWNoYmh3cHdLSWlkVHpLV09sb0hNaFlMSGdtb2FPQW5YVS9K?=
 =?utf-8?B?Q01SdFZNcWFvWnc4bG56OHc3NHQ1U0xvVzFCK2FQSDBQdmMxS1pQbWpmTmVV?=
 =?utf-8?B?TG9UUWNHWVRVYVBKZlNqWWwvenVCZEU1blg2SlF2bkxHWmU5YkZQK1J2RG4r?=
 =?utf-8?B?dUpYbGZRaVBicHZ2VUp4d2plMTN5aGR4MHRSd2djL1Brak5QOW1qOVh4TGJj?=
 =?utf-8?B?TUVmTXBkWXp6R00xWHJhOThIZGVXR0F4eTBxelhkdGpxWC9aNGFmeFBUS29a?=
 =?utf-8?B?TUhEWjArMFp5czR2UWdHa21OQjQ5UXdhOVQ4eWlEV2JvVDVkTEtuVXhmeG0z?=
 =?utf-8?B?QlVlSk9RaFBGN1BRUDZIM3dhTGVhTjRyWU1qa3Jmb3dQOVBaWit2bEVxWFdn?=
 =?utf-8?B?TDE1dGtaci94TlhMckpQUEkwMkkrclVxRGVSY0NWa004Ky9aMTF3ZlBJbmlz?=
 =?utf-8?B?UkZJaE01b0VjdXZBY3JlRzFpelhYaEV6ZVZUUE1QUC9XKzd2dklCdzNoZU9H?=
 =?utf-8?B?N1NjZHRwS3ZCdWpRUTZ4Vmp1VlBDMDRnMTNRM2hPcU9KalhYa2Uxc3I3UXRy?=
 =?utf-8?B?TWo5NFlkbUNFVXpvdTE4M2RMUkN6cktDZHlsbUMraUo2bHZCUVB0dGszek1N?=
 =?utf-8?B?dmoySHpUQmttTU1iM2laa0lxTHNWWXFqTDJzbTduTThvcDU0ZVAxeUZ5ZXhV?=
 =?utf-8?B?YnJWZGJSbjBjQlcycWN1YVdjNWk5NHFaZ1I4b0tiUVlyM0oyUU50ZDcvNmw2?=
 =?utf-8?B?M2hUdlhnUFdmMGNPZEpDZ0hIbkIwbS9WcVczaldiUm5wbkxhK1h2NTBVT2Js?=
 =?utf-8?B?OUQxQTBpZkkvTnhlVVNXdXJ6TmNqUEw3UjRzWS9ta2pmVTg3ZWlWUUgwZm40?=
 =?utf-8?B?TENmL2xlUC9HSEs5Tk9WeUx0cUJrdUVhcHNJNXhnRzIzcUY5dERTQzVUb0ds?=
 =?utf-8?B?RWY2VFp1WHYyMUkyWVU2TXRwUzFsZElKT3lveDFvQ3ZzNjdlcyt1R3VkYjQ0?=
 =?utf-8?B?aHJkR2pnckhqUWtzSko2aEtUdk0wOS95K2kyTDJTMGtETEpEMmRIY29tSkt5?=
 =?utf-8?B?bVEwamtLMkE5M0FaeHZqMkN0US9XdFBvZWFQUWw0SldvaUZmZU5SNXVhZWlj?=
 =?utf-8?B?TVJ3MDBTajF2cC9oM296TExpVkE3b3lvMGtzN1pZSk5iQnp1ZUR1Z3VzWnZY?=
 =?utf-8?B?WGU3RE90R0hXSjdUNmg3Z3JHVFZYaUFWNllWM1pTeUI1ZTR0Rm1YRmdGQ3ZY?=
 =?utf-8?B?TFgxTTNJcndlcm90OEowd1ZMTy9xVGk3RUtZV2RZNVB5SFpuRXAvNDNCNGZY?=
 =?utf-8?B?ZytndldyVXpNTG9pWFZGYjdqZ1Y4UTBLQzJONFpZMW0wZzJjMWlsM2dqdTR0?=
 =?utf-8?B?VjhRa2ZYSmZzY1NiV3VVemFpUlozYVZNeVNocDM4NlowdjNMZ253Mzc3RkVM?=
 =?utf-8?B?aTNRWkZnNnNJbEpSeGJ0N2ljeWQ5N3Y0SUxzeFhucXJkQTEzUHpPdlJEZWh3?=
 =?utf-8?B?N3Z3RE94OWQ5R0VCL043dW9xam4zTzVMcUtqWk90OENWR2hTWVFzUi9rS0hD?=
 =?utf-8?B?Rm1pbzhJRjdNMmVPOUY3alUzeGJqR0F5R2V0UmFkWGFIK2NOL2F6RGgxZERO?=
 =?utf-8?B?UU11YkIwVWtpcEFTc01odkZuVWtxVlZkSnBrdjhhcitBSUxtSlkxRkU3N0NS?=
 =?utf-8?B?YlVVM1pta3lZSXpNL0tHTm9VdWx6UWNnYXJzOExwdVV6UDFKQ2VSUDYyZ1dN?=
 =?utf-8?B?ZHdUYmFLeCthWTFQWWV6bHZ4TjkzL1RjQndRbzNxVmpQRXhEM1M1YkZrSWYz?=
 =?utf-8?B?dWRWbHJxdVVLY1dXNVNnT1pUWG1JUm9zeElXZ1pMaUtKUDFSMXhXS0ZQR05R?=
 =?utf-8?B?REZpNkJNN3IyaVMyWHgwTkFDTi9sODRIU3BmS3ZaYTNzS21JYUIwSE1WM3dw?=
 =?utf-8?Q?KQEWzNPeEuajh6DwmlexZ68Jn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5e5abd-e927-4c37-e247-08dd45f7f02a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:15:34.7567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3N/WmyGuLbYlxqdgkwsgyHO7agPt/rToa3B3bW70eRXEfvO5hflFHlAiHPTRP+ef
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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



On 2/3/25 10:04, Padmarao Begari wrote:
> The mini u-boot is hanging because of an initial stack
> pointer address is used at half of the memory, when mini
> u-boot is called reloc_fdt() function and doing memcpy()
> for the fdt before relocation, and there is no sufficient
> memory for the stack pointer. To fix, set an initial stack
> pointer address to near the top of memory. The new stack
> pointer address is assigned before calling the relocate
> of u-boot based on the stack relocate calculation and
> this new stack pointer is used while executing u-boot
> from the relocated memory.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   configs/xilinx_versal_mini_ospi_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
> index 9af3817c82..e1cdc186fb 100644
> --- a/configs/xilinx_versal_mini_ospi_defconfig
> +++ b/configs/xilinx_versal_mini_ospi_defconfig
> @@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000
>   CONFIG_SYS_MALLOC_F_LEN=0x500
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFE0000
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFFFE00
>   CONFIG_SF_DEFAULT_SPEED=30000000
>   CONFIG_ENV_SIZE=0x80
>   # CONFIG_DM_GPIO is not set

Applied.
M
