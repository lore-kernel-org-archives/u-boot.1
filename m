Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221C6CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 07:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB92488B3F;
	Mon,  7 Oct 2024 09:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eRPeWhaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA7B1885B3; Mon,  7 Oct 2024 09:32:17 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C8188B3F
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 09:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/FAgpJj5Ts2y6LaiIVUAFLVLEXyN6NUdSPFHfhTqVNYp5NdMWIMe8Tq0Yw9cCkwVB9KL0DpsXLWbtgm1WotPSUk7wL/kTZbK8WsFzstu8Mid70isC2Rg5m5Nvnkuiv8NROzEVJRM16lPY6rRMLsqsiEnItWohEwKXnxksQtto7Eero5B5i17f/+7TaNbXxPCWgnP9eF2Bqu9YRMvrOhTGRn2Ok3uITSVGYXHxNrssa3NW32g7Xvc9fiTSjXfvx4TI7QfzIgY0mTKXQjG93Y84g5jHBLuyuVb9TMn0cEBwPBklXKS8MAjjZed7OhanDxej3kXefvNIZQcn53cXmO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu/GgddIXWanfvuE0uzRAr27OMcNiIr6bVsaL86XPgM=;
 b=eusG2O05lWrFzfxQJn6sXgnpW0Spqs4UfvR8a1wuYFqMAcpsBX5npcRt9WKT3QSggfSvCKOZF16varz/s2l3asI5wZQ//8lpIJUz+dDS4KwLrIDXI5hVcXPD36IuMV6hpw4JgzGs2zJX8Y5atX30L44jajXk2fhbLvgqjDiw4zkH0S4Kz5t1KN7muUYoP7kJ7ErCntR5YStE/D46xvuGnXNIs8Z2IYIsC/dHcmXoHxA4kejjZ21rGiDjwh05v/SndINOVcKiDXwStl2GlFDrbdGE3RUXYG7LUEbSZ2eoqy5tnND27PwgtsUd6H+mYbybQ57/iAphZ1K+Sak8hbAshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu/GgddIXWanfvuE0uzRAr27OMcNiIr6bVsaL86XPgM=;
 b=eRPeWhaP8fxUxLJUtoUtL9JzNfokxGWBHi4DOkXj+LaWUAUJq3aa03+Eltt4C4WvyKwbplskzD4mxx0GLngztiR+maeqTbJXhIQYmN5cw0TuRB0H/jjPlK08Cf7mbZeWlgfdieLTREpIUS8k6ra/z1BDZBDQAtxMdMT8ljw3MSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 07:32:12 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 07:32:12 +0000
Message-ID: <d617d1af-e98a-4258-b5de-41a4c88d859a@amd.com>
Date: Mon, 7 Oct 2024 09:32:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynqmp: Remove conditional check for
 bootmenu_default variable
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <0e30b44ce3b478fdec21edad8d896f4d438ce331.1727867715.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <0e30b44ce3b478fdec21edad8d896f4d438ce331.1727867715.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:803:14::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 8687c403-f6d6-456b-c228-08dce6a228d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1M5WHJxU2dYb0U1dEozeS9WdVI2YWVUK0lSQXRNaHFrUWpPNnExejlHYkt1?=
 =?utf-8?B?NUE3MXlPVCtBc1RSYWZzM05jVGV1MEZMVVRtRGtTU1pPNDhieGpTYnFKRGIy?=
 =?utf-8?B?WFd1TzRJNDZPOFQ0ZlZwRE9uMHlMeGdVY0lpOXAzNWRWckpRNlFXZWhxVEtn?=
 =?utf-8?B?dWMvNEx5aWRBMDV4RVEvOExpTGJtK1BteldlTEwyVUROVFp6aVJadk9rbXYv?=
 =?utf-8?B?T2FQUmZ2TjBTa0FoeTJnbm9FcFNlL0JoZjJmeEVmYUlYMW4vV3pXOFp1WUYv?=
 =?utf-8?B?b3VlRlpKUkhDdDV5MHZjbG5WWkk1dDB0QnRhRkRkSm8xWUt5VmRPWDdYM2F3?=
 =?utf-8?B?Z0dtcTRRVlF3VU16QWRtSXQrTHhod29iQkFDZWtwYTlpWG1yZFY4SjUwTHN3?=
 =?utf-8?B?Wmh1ZHZydXg0WGxZSldpZml1TVltWU1rNytaSTFUMUhZYWEyZVNYbE4vWnlU?=
 =?utf-8?B?TG5IbkYvaFAxM3UydThNaUpwQk1EVWd1NzRsOHo3WnBxb3MvTDVFZTJMc3h0?=
 =?utf-8?B?YWJRaENVdFBDUlpNV0pRWERQbVNzSEI4ZythZVZWVy9wdFEyekk3LzgvNnYw?=
 =?utf-8?B?NTBMaWVUc25MMUlhd2thZExHVjJpV1RwOS9XY0VudTF5WmZmTVVhY0sxQm05?=
 =?utf-8?B?Mi9RMzVEbWdXUXgrSjdid0pnSlpHQWVka1dScGpyWXB4Znd5dGNGMzNUUDJm?=
 =?utf-8?B?U3VoM2g3dnBLWTFtRGFoTXBneUo1OTZtaWdBZHRFSU8ya3lXaVdWQnZSdVlp?=
 =?utf-8?B?c2tkNUFnSjNoR0c3Q2JjQnRwbDRvSisrV3NyUHE0ejFISVBhWlpYdFpRbjJD?=
 =?utf-8?B?MkNnbG80Y01aQ2RPZmdQZkNmcDUwdTMxZ3k2TTZpSEhncVhOczBUWjJ2THlt?=
 =?utf-8?B?Z0tSUjVsaGNzcmlRQUwxVmcwMmphZWpXb25ndWxISkR2VVZWNTJNclp4Uzlk?=
 =?utf-8?B?RTVYMTJsU05tZkxKVk42SDN6UEVCdkxwQnVScm5sNTdVR1NRZmJBZmk2bkZM?=
 =?utf-8?B?VDREbEoycW45dWxTRDFTZTdnUWRjMUFDLzZXcWVtSmNVVXIxbGZUNFJQQnlX?=
 =?utf-8?B?aE1ITnNaQzhOWE5ERmNuc2N2TG5xcnpuK3NCN2xLbVZ3N2VhbGJhMStWMnpz?=
 =?utf-8?B?eG9TcEZocjJvd1NXL1NINHZON3NjYktOb3VzYS9zR1VjcE9OZ1RQMjNVVmdR?=
 =?utf-8?B?bWlpUVJDTUwzR3AzNy83NDRad2dmYmdYM2d2eHcyZzhJR3d3WWtHb0JaRHlD?=
 =?utf-8?B?WjFnZ25xRTY3NnJoNUJWRmdYa0FUSGVweTZWMW1vem5GR3Z5VVA3bS9NRzhs?=
 =?utf-8?B?Uk5PNXlaMDlDUE8zVFo2MzRlUHFJdklNRWNSOS9VbXRGR21rRDRhcGp3TWNu?=
 =?utf-8?B?V3ZKd2xKaXBVdU1GWTlXL1JQR25pdFhFL2hzdVd0bXJvMnpRMElhMitLblZG?=
 =?utf-8?B?T1RUT0lEbFdIV3c1cUFVQ1k4bmljNUNDWTc3MEh1em5xSzFiYnBNdHFaL2hL?=
 =?utf-8?B?S1gwMzRaSHhKQTlmcXVDenZXWHUwQXl2UXhpRlcvdHBCR2Q3aHZUWkw0KzE2?=
 =?utf-8?B?VURpcEp4bHE5UXMxekVCbTdmWGE3d1h1Z0Z1VEY4UmZYMUc5bFV3czE0b3FH?=
 =?utf-8?B?MlZMQlJkbnRBcFhrUXZ2WHhFQk5QQng2MkgwQ0F0RmNHcGN0bFVqYVhSYXBJ?=
 =?utf-8?B?MDJMOHdqeDRrdWFoamx6K1Bvd0QzRnptTDhtVHAyTTlnMGFQTTNXRmpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkxkV1B6d2hTMTdvK3Y0V0Q5UVp0YllPMVpWbUxVV3pQYjZzUW0wZXJXRVhr?=
 =?utf-8?B?M3dubGd0Z1JtNXRTQVk0emhBaE43a0o1YjRrYW9zMjRrSHQyNWlQajZSOTVB?=
 =?utf-8?B?bWQ2WjA0bzg0c05VQUtabHZLUXg3VlJxM2ovZUVDV3ZWVmJkR1Yxd0dselVZ?=
 =?utf-8?B?Y21IRmd4R25CeWpKQkZzRjNpbU5mTkltcFkwNDNjSnROTUxQbzhoRmxWSVFi?=
 =?utf-8?B?aEZzS1V3QityQ2dFblJtK1Bvd3phUkF3R2tHaU40NGh3Y3phbXFWdTdiS3pL?=
 =?utf-8?B?d2ZMNWYyczl6dlVNeHJ5YjUvVWw4d3cwQnVxREZpZ0liL2J1OE04S0V2cHg0?=
 =?utf-8?B?R3BzZU1pMjJ0MkdwOHM1SXYxS0dXRzBuRVIzU09FZU5YemxhZjIreVdkS3Fr?=
 =?utf-8?B?Z29tVkdPMkVVRVRzQnRuN1pONEdmQitJNWVYRERYSGFDNWM4dytiRWwyWHox?=
 =?utf-8?B?bEF0UGNUVjdiM1hLRlk0anhXYTF1UWs4b01Ga0hkVy9XWmg1cDJvRk1KVmJL?=
 =?utf-8?B?d1R4N1lCQUlkT2Y3NjNuTG1DaDcvSTBDMm9QOEVLZTEvWlFuR1FiTkk3QkR1?=
 =?utf-8?B?azdTUW9YajJKajV3VWh5eWxLYTdRalBxSTZTZStvcXd5ZVZKdmJMR2xKMm1D?=
 =?utf-8?B?ZDRRYnV2VHRkL0trdTZxVUxERk1kUVBJS1lacUE3d0VQVkxadFU5U2Z3U05M?=
 =?utf-8?B?NzBqeWxOSUhlalYzTUhCV1NDOHB1SFBhcGFUeTVCZlhLTDNVcEdjSG5sOUZ1?=
 =?utf-8?B?d1V4cFlaRzJYTzVWTENydWdPZmQ5amRZQWV2N28rY1NTa1p6RnpBdGZNZzRP?=
 =?utf-8?B?b240QTlzcUwvVTRsNzB1eGJJK2NuNTFmcXFZZ0VYd2tFdHdSMFZSaFNVeTB6?=
 =?utf-8?B?SEhvWnpxcWRkY2JYQThYWFRyVDBlYllzNHVXQmZzV3NaU2tJZ2ZkblBvbVp4?=
 =?utf-8?B?dHY4KzhPVW5qY2U2REgrSjZaSUQwUkdQaTVOL0sxWVdOaVh4c3pYUU5nY3d2?=
 =?utf-8?B?eDVEM21NZ1NTeUl4Y3V4QjdOem4zQ1g4K2sxZ3YybmZTSTZoSGFMRGlzajY3?=
 =?utf-8?B?ZmxlSXpHM0ZpREYvWSt0MGF1MUJhQkVMLzdoWUNBYi82L3BlNXNUVVZyaHJH?=
 =?utf-8?B?YzNPYUpuanNERWNvSTlvL0duYUp6SDd0ak5qTVQ0Yk92VFBNcWlSZ09ZSjdU?=
 =?utf-8?B?b1Q4WWtyN1FHVW5CYXJlUDJ4TzBnYjNEN2YrR3ZMUEZOTituRjgxaUNiVUtM?=
 =?utf-8?B?THNWdlVUZ3hPcXFuMW80eUtXN0tVMys4ODFiajJhUUN1c3Q5YzdxL0toeUJy?=
 =?utf-8?B?K1V6dzBoN3RWRGZDeEt5ZkRORGNtWFV3RldyaGc2c1FRS09PUURsTGdFMzBO?=
 =?utf-8?B?c2t1QVBzTlR1M0lhMm5lU3pGWnV1WEo4OFAxRDBoZDRaakFuQTc3WGF3R1Js?=
 =?utf-8?B?T240ODg2SndjTmt5dTl1WW9Kak5Mb1Z4Z3BXVUxnNFNXckhDbXBpVlB2Nnpk?=
 =?utf-8?B?L1FFN3YyZGlEYXZLVzFRMVQ5Nzc0VURSWExueURhMU8ydUVReER6S1FmdWFQ?=
 =?utf-8?B?aDZod3pKbjQyM3VpNGFRMGlsM3o1cFljeS9GWGk0ak1UMEhvVFpNSFJkM2Ru?=
 =?utf-8?B?VkZxNkhCZ1oycCt2MW9GMlkyYU40RldYald0OC9zakZrai9GOXN5VWRWUkdY?=
 =?utf-8?B?VXNMTStGNEl5cS8xYlgwTnQyR3ErdkNsSHpoOGxXWUxkNXlWR3hFeHNQZEFC?=
 =?utf-8?B?enlMUWV0ZTRzUkR3NHZUQ1pCb2pFTDE3RXc1K1RGWklEanI2M0lwTjdPV282?=
 =?utf-8?B?UEc4N2l3MzZoa0haRlVYS1ByS2ZGZHpMWXpIQmp1SXZGTDNyNG9EbE0zNGlt?=
 =?utf-8?B?QWVWNmVYWEN0eFlIRjZmMGlRK2U5Kzdiblp4ZHVDVkx5ekFMMkdZVUk0bG03?=
 =?utf-8?B?bWsvQzU2dlZyVGIvYm05cDdoTkdnNzdaMEx0VHR3bnpHa0pQOFV5U1JFa3dJ?=
 =?utf-8?B?RVVZMkVrcFlydHViaXo1QWJ6aW53Z3lXQnEyblpTcHhHRTdKcUoyL2xFSDlm?=
 =?utf-8?B?VGI1aERud3VNUW0xc2lqT2RzYnhzSCtOalRBbUM5WXdzVzJlY0JTYzJuQVdo?=
 =?utf-8?Q?6pucDfd7KZMC0T8Ka/mejOrnJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8687c403-f6d6-456b-c228-08dce6a228d8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 07:32:12.6353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHWgIpjm8QntNKAHK2HO85ZV21WkLUGkLIdpABnhynlYxUPuMCGl2IwPuoGdXqfn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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



On 10/2/24 13:15, Michal Simek wrote:
> From: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>
> 
> As per bootmenu support added default boot options to CC on AMD CCs and
> default to SOM on others.
> However, if no secondary boot device is enabled in the design,it should
> be the default boot option for SOM when combined with AMD CCs because it
> only contains SOM peripherals.
> To address this issue, The conditional check for the bootmenu_default
> variable was removed, and it has always been set to SOM as the default
> boot option.
> In this way, users can choose preferred boot options from the bootmenu
> based on the boot devices configured in the design for AMD CCs.
> 
> Fixes: 61bf0fa8663d ("xilinx: zynqmp: Add bootmenu support")
> Signed-off-by: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynqmp/zynqmp_kria.env | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> index d0e431ebb46f..927f398c3c38 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -51,8 +51,7 @@ som_mmc_boot=setenv boot_targets mmc0 && run distro_bootcmd
>   
>   # To disable bootmenu set enable_bootmenu=0
>   enable_bootmenu=1
> -check_cc_for_default_boot=if test ${card1_name} = SCK-KV-G || test ${card1_name} = SCK-KR-G || test ${card1_name} = SCK-KD-G; then setenv bootmenu_default 1; else setenv bootmenu_default 0; fi
> -som_bootmenu=if test ${enable_bootmenu} = 1; then run check_cc_for_default_boot; bootmenu; else run som_mmc_boot; fi
> +som_bootmenu=if test ${enable_bootmenu} = 1; then bootmenu; else run som_mmc_boot; fi
>   
>   k26_starter=SMK-K26-XCL2G
>   k24_starter=SMK-K24-XCL2G

Applied.
M
