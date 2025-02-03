Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D48C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 09:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 399848070F;
	Mon,  3 Feb 2025 10:32:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xy1a2nFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFE0280711; Mon,  3 Feb 2025 10:32:39 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B48B980608
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 10:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDSfBkum35Qd8mdllgQy91qp5jhKjeOnSfd3mMEGKHNdQSxYyNL1uC6aMWrAF/bKjI/dqixTxMg/P5CrjXg8os033CZrPoaSpWPgTSAKyKLuVHOmOajOocWBGIDFeit4ju7H0o25XIxgEWBvllMHTjT6N3mdPpZ1+s7yHTGXfX1KiSEzckRwlX8IG3SmJ5QrANcqs5AU3swlAlwoHEs7UupJVDPg4KxVFMjuTUJKQtz1EH1sRsBw6jNKWV70lfAvzaDEEaYHx3Jc6tz9ttuFA6QhG3Jylbum/4pDc9wi6AIAiI9epaKhoLlFnuuHN0DlKh+CR7SlQI+mWsAxo08Qfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLgWmLV7Ie4UvXOuGkd4D8Bn3jM26JvRnKC+sHXQo50=;
 b=R6OrTyb0gah5C7ODNXrAK09cgC42qhBy1fqzZ3dh6I/JSwTLwqnnaLIMyJaesvNiS6feLyK6n29jGq+efK+rkEkayIwpUhwGCV1gCcgSKR+50fU49HxfmI6wvquuHSs7lOibD3e5Bnh0838pXqTTBaHS2NFRWlnwH7kR/8hUhdi2ufT1r2cj9wS9HB2pI2XKk5TKLbJ8x7e0yEBv42BOa657uHZA6q1owRng4X0yf01YpTkU/XliZE2pDrR7xAB1NaSE9Wdh7k8Kpc0hEBvh6FSO6yUXPV4AG6atYkcGRZZOeAkMzstKPhJOlZi4ANrw5QzQNLkaImnTzasNgE/veQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLgWmLV7Ie4UvXOuGkd4D8Bn3jM26JvRnKC+sHXQo50=;
 b=xy1a2nFX30+NSw7IyqAnYUXEo48y5/DdkbRJU5P9a5icjjflSOstwMNUdyMZk2sovkq0wD8Bheng3B2zYQllKtbzSyCHWVJStnFfkDGuU4trXOpQQ4SZ3VBtY0LiD8fMBkXxNILEphsdU+2Hf9CUG674eHlS2I5oe7nna1WiacQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 09:32:34 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 09:32:34 +0000
Message-ID: <9e815f8e-5036-4ff1-adcf-cb2b9325431a@amd.com>
Date: Mon, 3 Feb 2025 10:32:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable mkfwumdata tool for a/b update
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <6d82c9a2db30e12ea17fa125c68a555d7f070851.1737723845.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <6d82c9a2db30e12ea17fa125c68a555d7f070851.1737723845.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0042.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::31) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: e3fab72b-179c-4112-ff64-08dd4435b062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cloxcmVreUlWSUt5VjY1NlFkR3BHMG1CMFF6OEdQdm51ayswN0tNTUozRDNE?=
 =?utf-8?B?YWRmU09wUTRaL0xXVUkvbmJkOW01aUJEclNLWHM2QlVmTWZRenBBYUJnNFB6?=
 =?utf-8?B?di9DaENrVzUxVkV4L0lFYXpNaXAwN0tSL0JUT1g1OGlGaFUxc2ZLOEo4SXl5?=
 =?utf-8?B?UlJzdkd3RzhGUWQwejJ2UmtObmVCWnZMekh0SHVvOVB4ajY3b2ZzNE0zNTd3?=
 =?utf-8?B?dTk3S0M5eTN3MXVNT3lTdTJEN0ZQcFpaNWNRZUtUeW9Kdy82ZS82NU5LN1g0?=
 =?utf-8?B?VVd2VDBkdFZYeElra3Q4WmNWb01pZk02U1VObXIyNHdSSjlMQWl0cE8vcVlt?=
 =?utf-8?B?VEFrRWpLMkpyRllQaEk4bzduempQOHBYcGVjMVBGSEc0TU1qVHFRc3NsTUJX?=
 =?utf-8?B?dXV1bWhmQXRVb0hVMjlrY0hRR05oZS9IM01oUy9XR1dWMUZOL3A1UUN1VjdJ?=
 =?utf-8?B?RGwwNzhNZWxPVW4xTWhnTWZCNGM1WWx6U3cyT2VGekMxWGE4U2ExL1c0b0Ns?=
 =?utf-8?B?NmxEVUZDL1VxYUUwbFJrWk1UUGlNU0d0WkVUcGRiNTF4L0dTY09kYUhwQ2dH?=
 =?utf-8?B?SkxWNWtpMGZtSjBiaDJXN21uTDYxbkRmZVgzSkc3WnNYUnZucXorZ2lST3Q4?=
 =?utf-8?B?ZFI1ZW5ZQXJ0WEczUlNPcjZmcktFNVljZFVmR2V1MjRDQXV3Vjl4SW5ENlVU?=
 =?utf-8?B?QkhmM0VDWm9VdzVoNGJoR2pNZEFEU21Hc1hSai9KYmd4endObVpDZVpMQ3lM?=
 =?utf-8?B?L1ZlL055cmFFbnBTSVpIeVUrelJ6d1c4Y1d1dEdtWlhIZUZZWmUxeHhKTUw5?=
 =?utf-8?B?RTkwTGQxZTg4K3h2cGhaakt2eTdLTmJmdmRjdlcrMXllcHVqSlVtZmxramtr?=
 =?utf-8?B?d1o1Zk5yb0R6RFB1SHd1UmRWUXdDUkVkUEZ5UEMrWi9LWGFIWU1LM1BMT09F?=
 =?utf-8?B?WnhRSHFYNnVYV0lZRm5BcXoxZG53THRPd3RMckJocnlBTmsreWJzR0syODZT?=
 =?utf-8?B?QWZhWlZTbzFZV2xGNk5FTll2b2d1R1daZEUrY1ZNV1hsZytYZlh3a01tc0I4?=
 =?utf-8?B?MlVJS2c4SEduVGdaL2FFbGFDT1JYT0JOaGxzaVlaeldXaHFtZXYybytERGUr?=
 =?utf-8?B?Y0RSaXJ2L3pLNXVTVEFjZEVyblprVWtUN2dsV2h6aHNldE8xYXRMdHhkTmVK?=
 =?utf-8?B?VXYrQ0JqZmd5T2RoQ0dHeG5DR0RRMzA3MlZMK21vS05tMTkzRmdldzRka3Fh?=
 =?utf-8?B?SGNiSE9sc0JObU5uU2JodmNXTENFQVVIWFl6dmhmbmRZVXFqV3V3TGlKRUkw?=
 =?utf-8?B?N1JZWWZtR1dCZmZZbVdrZXRoWUZFS1g1alplWjF5a1VhK0lURGp6Q3o2UWEz?=
 =?utf-8?B?bTE5UmlTRDQ0SjA3SWtyb1hZOXB2STViRGJNQ3J3SkJmTUJSWW93MTFuUVVP?=
 =?utf-8?B?R0tlVjJvcjBuWTVSVkFXYjZKODFlN0I1TVRudGowVFdNVTN1THhiS1B2bnBY?=
 =?utf-8?B?NVRuZFhIdmxkYlk1TzdQK1JTSmxqRzIvVGxtYnRSL2xzQ2k1SXIybFhFdHR2?=
 =?utf-8?B?OUVOWUZRSlh1dW1LVTVWUW1nV0YrZ3c0M3E5Mm9ubXVXc1orSWUxM3ZDMmk1?=
 =?utf-8?B?Nk1WRkw0WmIzd3J4NCt1aXo0QjZTZ3JGajU2U01yTkNOWnU0WnFZeDBKeGR6?=
 =?utf-8?B?Nm03ZGRJUEZiMEZERDQzYzRaRkxTUFh0TUhvMUFWZnYyTlQwRDlpSFJxd3hB?=
 =?utf-8?B?RGxJd3BHTDAyTk85VGE4SWJySXJzT3dNcVpSOUlBOHJ2VUhNL2w3QWxQZWM3?=
 =?utf-8?B?WExBNVdZeWJKZlBudVdGejkvVHpYRW5xWFFEVVUrMDZYTEp1d1hjVGFxdjRm?=
 =?utf-8?Q?ZbGb6QJDyNIQe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVRkRTJPS3NxdVhKYlRldW5LSU9HM1h1Z3RxcVdRSWNHdGRraXhYeEVtQUtx?=
 =?utf-8?B?T3FuYm1oVzN4MmlFbUxMb3hXYy9BZlRMZjVCcmt6V1VCQUp5MDhJYXhLQTJZ?=
 =?utf-8?B?ZXhnS0NyajhZNDl3d0daRVlrNXFEOURlYUNIaWp4bmFHNmt4YVIzWXJySEpS?=
 =?utf-8?B?NFNibjdwTzY1bHQrTlgrN3N5YlkxZmVIR2ZXRkU0N2tLdEJMQ1BTTjJlMVVj?=
 =?utf-8?B?S0pUU01PSFVPSVp4d0NDZCtaaC9yNGN1Sk9QeURWeXhuc3J3WjZLVWsvcnFm?=
 =?utf-8?B?YkEwL1B1aGhKUXRIanNSMENKdUZoVlFpcXpuQzNkbDBISkhUcDBaNFlVYjNR?=
 =?utf-8?B?eHVQTGNvWk5vcDZ0RlVYQ3JrWjFYZjNnb1ZEaTJnUUFoNU0rOS92ajJLeTBZ?=
 =?utf-8?B?OE85RTY3M0lEZ3cvenZOMXh1L0JndGVPNUljRHFMZlV3UTFkWSsydXhLQ1hF?=
 =?utf-8?B?YVNPem52SWhsQTFqOXMvdW9jWTROcmQ3OU52OGhQVHN3dC9FY213dDcyMXZz?=
 =?utf-8?B?c1o0dTQ5N21Yb21vd2gwMnpIRzB0OGc3RTBXd0lnQXg5Q0NxQUFKeTl0Vnlq?=
 =?utf-8?B?MWlldk9QOU9sWnNjMEQzS3ZaM3JnR0FMbHNjSUxzYXlQTXgrWHFrbUlMUmFn?=
 =?utf-8?B?QVptcTlEc3RHRG1hVi9GSkRIb3ZSeGpMaE95dExvQ0gzQWp1QnFVdUhMVytC?=
 =?utf-8?B?UFIwdTRnM0xXZkdqUWQyNXZGVmlEamNLZDh0NzRTYWkxKzdGbjdMcFhKVi92?=
 =?utf-8?B?NlFaekROVGFCb1drOW9RU3ZqTTEwY0VYa25ENzFQcFlIVXc3TjFCR1NCVEYy?=
 =?utf-8?B?Mk5PelM2TDZoeksrOUhEN3IxUGhGTXp2MWFYbXN1dm1ONWM4WXB1UFpLNnJt?=
 =?utf-8?B?SmtvSjljV1o5YWFMRE1aSkxrZlVTZklhRDhCYXd3blhEYVVSdzlsWm1JSFpa?=
 =?utf-8?B?czdSYXVENTllN2Nmcm1IZWswYldIZ1dWS2MvSGduellHQ3V0VE4ySElXTWZS?=
 =?utf-8?B?UmJtRXZpZFNkdmRMNElsSEt6UmNyMkt6ams3amRZNGUvbEhZVVRnOFJ4T3dE?=
 =?utf-8?B?dmVTUnBlWU5OaW4rcm5OTytPR2JXY3p4UElhZEFhK3B4MGlnK01ZOWliTWdB?=
 =?utf-8?B?RVNZZXY4aldwMUUzTVlKWmp3Tk83MDZad1FybmxXUlJGSjk4QjFxdU5zb1F4?=
 =?utf-8?B?a0k5WlJaMWJRVU84LytLNXd0TVUxd0ZOL0NBM09wZnFhVndza2c3TlVVYXlm?=
 =?utf-8?B?TGowNDBkNGx2NVJRT3dZbi9xZ2h2T3B6MVlvdXBOV09vbEV5SGsvS0p4Zjdt?=
 =?utf-8?B?OXRZSFphOHZRdzhoSEZYYTBwb1lvTVlEc2pIR0dMWTFZY0kyY1FsZHk0ZzFX?=
 =?utf-8?B?RVRESTNTS1hDbUVvYk5DdVJtSzBWVnZITnhiR09Ib3B0Zkx4WklyU21LbHp3?=
 =?utf-8?B?eksvdmdpZGVTSWxYc2pxck90YlpzN0lrZVhZY2RQeGYrdGFZVy8yczRtQzha?=
 =?utf-8?B?a1dDZjAzblh3Slo0RDhaekM5bmZqamRURDN4K0diUzQ4cDcyUnFXNm1mek93?=
 =?utf-8?B?Ty9ySGJTeWZJZEs2S1dkTmV5MlJFNHdxeC80cThFT3R0TTlaQW1SdDVhZXda?=
 =?utf-8?B?MklId2hzQzcrN0RvMWx1T2J2TWZiUGZhbVVmRDZPL3pFNDh6Y1piTStBdi93?=
 =?utf-8?B?OUhERjhsQVBrb0sxcVZEU3ozSDVrOU1OUXladnlLQ0wyZWJ4ZzNVaitiVlNm?=
 =?utf-8?B?MzM4Ym9DSnA0VGl3SU1HVjZuMmE0SEphZ2ZSVmJFVzhtdWtEZnM3N1RzVTRT?=
 =?utf-8?B?TFUzdlNNSGZEd1I4K2JXUHozaFNxTGgzK0dJd0IwNmFqTC9XVENnSkkyUy92?=
 =?utf-8?B?T0I1UDl3TWY1djlzUGQrZ2tWRUJjbkFUYmIwZXYxbXlPUEw5ZXJFRjhnWktn?=
 =?utf-8?B?RVczUitKNEhUV2c2akM4bXpNS3hpWGZNd1Z1TDRyVjVGZS85SWpPd0ZieUNw?=
 =?utf-8?B?aDVEY1NWb0JmZXZOQWQyRG9QSkt6eFQvNk84bElqOVc2djVvUm1NdUdqcHpE?=
 =?utf-8?B?RFliamtCcUk3S2diNjFhVDA0VDF4OWRKeG1GTis3NFJ4ald0QmJJb3ZxcFk0?=
 =?utf-8?Q?LUm5ZQxCtq7Cm7aQZmhmRVekn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fab72b-179c-4112-ff64-08dd4435b062
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 09:32:34.2701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YERa+JaF418yrs3AiKlknnGWt10GtF0q1POqg1A3sPm3LtAwTCW/KpIJ6ToilwX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
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



On 1/24/25 14:04, Michal Simek wrote:
> Build mkfwumdata tool by default for building ab mdata structure.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/amd_versal2_virt_defconfig   | 1 +
>   configs/xilinx_versal_virt_defconfig | 1 +
>   configs/xilinx_zynqmp_virt_defconfig | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index a7d8b035a714..57a6a06df7cd 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -157,3 +157,4 @@ CONFIG_VIRTIO_NET=y
>   CONFIG_VIRTIO_BLK=y
>   CONFIG_TPM=y
>   # CONFIG_OPTEE_LIB is not set
> +CONFIG_TOOLS_MKFWUMDATA=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index dd6e3ca34660..70e73ac7ad45 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -171,3 +171,4 @@ CONFIG_VIRTIO_MMIO=y
>   CONFIG_VIRTIO_NET=y
>   CONFIG_VIRTIO_BLK=y
>   CONFIG_TPM=y
> +CONFIG_TOOLS_MKFWUMDATA=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index 05ead1a41b4d..c0721b65fd48 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -249,3 +249,4 @@ CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman.dtb"
>   CONFIG_PANIC_HANG=y
>   CONFIG_TPM=y
>   CONFIG_SPL_GZIP=y
> +CONFIG_TOOLS_MKFWUMDATA=y

Applied.
M
