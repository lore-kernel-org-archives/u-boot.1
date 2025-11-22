Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87B5CFC539
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 16:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A708983B43;
	Sat, 22 Nov 2025 17:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="e+8NoCLH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF0083A2B; Sat, 22 Nov 2025 14:18:05 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75BE783A2B
 for <U-Boot@lists.denx.de>; Sat, 22 Nov 2025 14:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ozandurgut.2001@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atpZn4thXv0jNp5QBL0/daHdq0BEO53XDVi/BDnR7DZ2rS1BP8SreXZIaEG6+tpBC2mOYgnOmJBIyfo3PmLz86fBmAYVpUWGor30pdJKC9SzxRoLA2Obo6MMTpj7oesNQzKmrMqEumFrvJWGeD65wFoR9fiilAgQP9aRv7riav5kCztyjU7j+DCy0USqFS7dCkbHaD2c3aNOUsty7rY9TzA/VXUCcerxkBos64CM9shgGRK6B+uRACF7SzD2K8c46sHHVMpk1BSGR+5c358xWG9kgJ9IVo8vbeShd3V20oMbHnqP3hTuJ3NcuWHrDbHo57AxAxKbimIaZU2r/karDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayluC5CgnNegJq3B5I/P2Vaa7kp3MuWucCHAdSpk+EM=;
 b=Uz1J+85LXiA6RalZVTJeJ+lmjRZ3mqIqvZsUNznM3sz3QfqmOmvpx4NKPxCrUkZwS0M8awJV+F+kc940BurRXxeVlMpZwWYEfpEdGxMvnKv45D0ADGWnMw8IV/2arSkHwUhk7NIBQWOSDOtALf8e+OCw+/HQc6dyNL6YttBgxd9osPh51N+rkbcaouChvkGAQEbodnaiCbYMNYjwo/EOxaDJUSz61VB0ptGidP0GpjOd7S67uLlXl3GZndIFzJM3rIyaNn9xCGos3gJeB5YczdVlFzPhKpKZu9gCHW87c8Rm8YmUW1RxlK4maLkIQiyJsqoUWBy31pq279zgZ+fObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayluC5CgnNegJq3B5I/P2Vaa7kp3MuWucCHAdSpk+EM=;
 b=e+8NoCLHvUffAb7y6PD7JkGN45q8EU3HtpGNhXZiw+I1T98YyYWl0Qg8gvj5M1mbthedchad1hMKOosVc9melDWZMfybCpVrYUtAMYhJb/QAv4XYqfAl/7panK9HENdAsd3FJIUda/6j00v5zqVGccLhYPqzpSxFA4/WNWM4qCeEf1PXoltvEhPLOe/j2oXZ8AXJHK3p8z+t+fhkJ1wdE0jTEzMci02bzPOs7JXZDv9LjNMdWYPk3pfsmCMiKZZxgjxTs2R109gqne2ZwIOR9U6y5Re8ibbDxB1CZRPb9COodjPhmOfY8KJi5iJgwBFpeDl9+R0hj0GOgG5rO3kd5Q==
Received: from DU2PPFBA6D4FC4D.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::aa0)
 by AS8P189MB2491.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Sat, 22 Nov
 2025 13:18:02 +0000
Received: from DU2PPFBA6D4FC4D.EURP189.PROD.OUTLOOK.COM
 ([fe80::630b:e9d:95ce:df37]) by DU2PPFBA6D4FC4D.EURP189.PROD.OUTLOOK.COM
 ([fe80::630b:e9d:95ce:df37%4]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 13:18:02 +0000
Message-ID: <DU2PPFBA6D4FC4D0E86306717E76599508AFDD2A@DU2PPFBA6D4FC4D.EURP189.PROD.OUTLOOK.COM>
Date: Sat, 22 Nov 2025 14:18:00 +0100
User-Agent: Mozilla Thunderbird
To: U-Boot@lists.denx.de
From: Ozan Durgut <ozandurgut.2001@hotmail.com>
Content-Language: en-US
Subject: v2025.10 env Kconfig rename (fb5235239aad) removed backward
 compatibility
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To DU2PPFBA6D4FC4D.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:18:3::aa0)
X-Microsoft-Original-Message-ID: <26138728-261d-425e-a5ba-d10c971e02a9@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PPFBA6D4FC4D:EE_|AS8P189MB2491:EE_
X-MS-Office365-Filtering-Correlation-Id: e63ae1af-4b65-4e7b-5bb0-08de29c99036
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|39105399006|5072599009|6090799003|461199028|8060799015|15080799012|19110799012|23021999003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnhNRnRVUzVHTTVNV3FtaVRFSVdaVFozSkVTdm5jS1FkUmtkaEM2RVVZSkZY?=
 =?utf-8?B?czdyemVFMW1pSlhQV3BVejh5clQwNWtqa3g5bmZhM2ttSEg0VjBjRHVTeGlP?=
 =?utf-8?B?Z2pCbFNBcGJ4ZXVZbnlYYXVIYmZjanphVzJwMWhSKzU0T29ON2RpS3ArMlk2?=
 =?utf-8?B?TTd6UW1pQzhZdUI1WGtVSTZIRVFhTVFCNEpBdjU0Q3FRMWo0QmRrWnpMQmxK?=
 =?utf-8?B?TTFWdVpEWE5UWUN4WE5PNmNEaG9wUGZ4VUVKbG40ZkxlVnhZZDRMdEdNWnJJ?=
 =?utf-8?B?RTM5VVNxUnJSOEdraXRPeWNiemI3OU9admR6M0VkcWhxRWFIcExERWNHTzVY?=
 =?utf-8?B?dFdDbkJhNHAzWFBUWU85Y2pVemZWMGJlQlM4SEpKcmkwNFF6ZGpsL1ArcWRx?=
 =?utf-8?B?b0VHcmNNY2pKN0pHWUJ5SHlxRHZXVnMxN0orNC9kMzhsT3lTbnFUS01oMHVa?=
 =?utf-8?B?eWhNTDJxNEpCS1BaL1ArTjdQTEhsOEo2dnhtMk1raVBJbzRYdWZsdm1TajNX?=
 =?utf-8?B?cWNmanZuZEZPdGh2WWZQVG1tb0hTT3IrekxqckFnUURIK2lwTlkwWEZKSWZJ?=
 =?utf-8?B?S0MvR1U4ZDFyeTUyVFAvZTBPZk9JZXpmSUFjbmc4OGtBR09ZMG5rUkZsVVVs?=
 =?utf-8?B?RFdjV3ZUTHFEaGZWODBQR2t2T3FvendCZno3emxtbTNnekJCMDN2WEZmV0Qr?=
 =?utf-8?B?KysrVlN1Ri8vMTRVMm9YNWgyODZyWlBFUmJnZEhTelBSRWRaam1JckxtcDNT?=
 =?utf-8?B?R1dGSjRpa1J0QmdvNGxaQmxobGVURnN6cG9mQ0k3NWxEeTgwYWdlSDllcGRE?=
 =?utf-8?B?RUlML2hDV3creFJYbkF2NHdpRForVExoSDhiRHQ3cyt2QURaZkFCVXhmTFdC?=
 =?utf-8?B?YytmSm5NcTVkNDlBODBWOUpSTWIxMjJ0V1RzN1ppWmRLd25BYmNFclJoQ0Rj?=
 =?utf-8?B?MTl6SnJKaHZEcmRPcXlTRkJ2aHFtaUNUdjBsQitWNUg0NXBKQmpRTDNzWkZJ?=
 =?utf-8?B?UU5WRTkrL1hHVmlpR0pSOWgzM09OQTNNOFpZWXVaVFVObkQrd2ZaTWUxMG5G?=
 =?utf-8?B?R0pPeXl6L3F3elhnUm5ub3dCWXFUTkljRVRIb0MzZ2hUM3hSbzR5REFXdno2?=
 =?utf-8?B?cTRISXVBaklDM05MaGdKd09sNE1PSVJrWnppdy9MNkoraUhBejJYYm1TNkpp?=
 =?utf-8?B?czk4TUJoUVJYT0pMT2ttOGwzZUFpcFk0SlRJeXRnTnN4RVBsYmNJWWFLaTFW?=
 =?utf-8?B?bE9TZlpJa01YQ2RvaVYxSFRUK0hDM250SG1kZ3pvZ0xRN1RIak9oRnpZTG1Y?=
 =?utf-8?B?RXdDWWVjMFZWY3NtMTJIMjJhZkZEVndLQytaeDVCUTh6TmhsYlJjUXdKS3lm?=
 =?utf-8?B?YUtacC91VElXREpSWU9mNUgxTG1sSS9YTVhZVWVMcXNvTHdKM1pkdWVGeDN2?=
 =?utf-8?B?aFZ4dnAvdTczZUVFQVRNcXBtMXAySmZ5SFkrOFBVZW9ablF0YnBwUDVPaU9R?=
 =?utf-8?B?NkVTZkdnZDA0N1NwVzVYTk9oTVlzMkFPZncrcGd4R1RuVFJ6emdoOEd6WTNV?=
 =?utf-8?B?NDh6Z1NJTnBhN3pQT2wvZjJlb3E5RTNWOC9WeWJrdU5BTVkxL1pJZjNsVHFG?=
 =?utf-8?B?M3pGeks5WkJwYnd1dGZIZ0JSRnNabVE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWhrOE1xQldkcHJnaUp6enJOMzhqVjJEOHdXZVUySlNNMVo4Z0VRY3l0YkVw?=
 =?utf-8?B?amtLQTNzYk9YY1NSRmswbVNpNU5abzBBcmRvRkNiK3h5cCtEVmpjWXpSUnRU?=
 =?utf-8?B?bEdFY29MNnQvMlhJbngvVzlkUVZiRkFEM2dsSFNzNXJocjU3OU1zbm8rN0du?=
 =?utf-8?B?T0ozbnp6NVhpUGZjWmpBdUpSOXlMUnFTcGVuTm5Mb0JLNi9GT29MZmtNNDB3?=
 =?utf-8?B?Z25heVpSWllES2hkclJ4MnRwbk5pa050UENTcEVRclRSbTY0OWJyQW5vOHRm?=
 =?utf-8?B?UEZLOHFsa29Cak02cDZxU01CNUlIL3Voc1pZMjAzSHFUZU1LVGYrc1g2N3hl?=
 =?utf-8?B?SXFpZkZuWm1RdEJWTW02NWQ1NTBqQ1hYSC9mOXBhSldLQzRVYVg4MVFhaWc0?=
 =?utf-8?B?UjEzaEdXM0hWR09LbmY0Nk1rQnJoWnc4V0pBbGtaOXVJRHhhMjRGUkxrb3RG?=
 =?utf-8?B?S0UxeFZ2S1Fuc2VmZERvS0ppZGEyTEx0cWxhc3BFLy9ybHhzZFBZYnJlaFlh?=
 =?utf-8?B?a0ZQaVU2YnNqR1BKMWFqaWtlS3hOZmRhUkIrRHhsbWQwSmFVWjZLbGo5UTU4?=
 =?utf-8?B?MHhZd0c0czdWU3p2Q25lYUREMmdkRkFtTzVPVUNNY2d5a3ZwYXRqWlYyUFVD?=
 =?utf-8?B?ZWF4OEZISEkvTkFuRjJsU25UODNWRUNnVld1Nk52aSsyWXR4RUh1bWs2KzZi?=
 =?utf-8?B?aURnd3dGTmhIYTcyVWxVS3YrU291c29TUkgwMWVFVUkwa1hvbjlFc2dEWEZy?=
 =?utf-8?B?a01WNzQrVVR4Nnp5R3FZZm5XQUU4dHNEMWxGU1U4LzNPOHVMbzU4bW4xODZK?=
 =?utf-8?B?L2FiNytCZE41UDBCWTdtUThPYWYxT3ljeWE4ZjBZQVVmVXY5OWNyeGNvdkVH?=
 =?utf-8?B?TjdMMmRMa3ErVWM0cVNjbkIwV0g2Yy8xY0xWQ0NhY0NBWTRhY3NHVlltZ1ZR?=
 =?utf-8?B?ZW5sM1kvODdvb1ZobTV1Ni9xQjkyMWhONVJDZDBSaiswNTdqNHAxd2M5QTVh?=
 =?utf-8?B?YVNMVmZRZmxKVFF5UGFuTjBmdngrOVdSMXBITmxnUlVLRzRBSlhoMDJsbmhP?=
 =?utf-8?B?bzdwZXU4dDNXckQ3cTFXb05vV3cwSEh1c3NHYXNxajZ1UFRDeHVVOW5pQlU0?=
 =?utf-8?B?MnhBdktBMjdYUUFpQVgrbmlOQmQvZXI1Y25ZL05xT0J1YUR2SGo2azZWM0p4?=
 =?utf-8?B?RDh1OXZPcUlYbm5YUW5xTGJUUTJuaVFkN0I5OWRXQ2xjRWxyU0hUTVNaOWpa?=
 =?utf-8?B?c2VYUDI0Rm9UeTVwWjN3UG5leDgrSFNhVUM0MlhmTWJTbVMwQ3BPc1pvcGx1?=
 =?utf-8?B?bVk1ZUc5Y0JNMG5oT3pBSS8vamxCME1XUHdNUmdWUjZvcVZDYU1lVVJ6ZVhl?=
 =?utf-8?B?NDhiWko3SHQ4SFJMVnRQWGtkZktCckZZaktyRFEyckJrZEwxU2xMM1RkYlRr?=
 =?utf-8?B?dGRUcnpGNU9NSVpMY2VNQ3g1a0Q2dXR6a1VDdVhWejU3S3BFZ0FobXlhYS9M?=
 =?utf-8?B?L2RzbVQrK1gxSm5yRGNlYkRvRElvZTNnZnIvOGpTVTN6WHc0OWJvREJwOUZV?=
 =?utf-8?B?andYbVlRUElRNXJ1TDB6RUFHVGE5bUkwbit2dDJuQlh3Umx5cHgxV2JJMzUz?=
 =?utf-8?B?bWdzd3ExSFl2dFJPSUZ3ZTJ1U1dKMTd1RHl3R2lyV3RkcGJqTlRwd0lqbHph?=
 =?utf-8?Q?VBFKFUeecc6+VWWleRMZ?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2ef4d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e63ae1af-4b65-4e7b-5bb0-08de29c99036
X-MS-Exchange-CrossTenant-AuthSource: DU2PPFBA6D4FC4D.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 13:18:02.1680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2491
X-Mailman-Approved-At: Sat, 22 Nov 2025 17:36:27 +0100
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

Dear U-Boot maintainers,

I hope you're doing well.

I would like to raise a backward compatibility concern regarding commit 
fb5235239aad ("env: Rename DEFAULT_ENV_FILE to 
ENV_DEFAULT_ENV_TEXT_FILE"), which landed in the v2025.10 release.

Previously used Kconfig symbols CONFIG_USE_DEFAULT_ENV_FILE and 
CONFIG_DEFAULT_ENV_FILE have been replaced with 
CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE and 
CONFIG_ENV_DEFAULT_ENV_TEXT_FILE. However, the old symbols were removed 
outright, without a compatibility shim or deprecation period.

This change causes breakage when integrating U-Boot with Buildroot, as 
Buildroot currently lacks a mechanism to handle such changes 
conditionally based on U-Boot's version. As a result, downstream users 
are forced to choose between breaking support for older or newer U-Boot 
versions.

Would it be possible to consider introducing the legacy symbols as 
aliases, or at least providing a transitional method to support both? If 
there is a preferred approach to handle such transitions, or if you 
would recommend a specific pattern, we would be happy to align with 
upstream direction.

Looking forward to your input.

Best regards,
Ozan Durgut
Analog Devices

