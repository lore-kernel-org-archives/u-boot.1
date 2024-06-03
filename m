Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EC0C25B76
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 14:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C9D87CFE;
	Mon,  3 Jun 2024 16:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="ZTdsIz1d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A52087D07; Mon,  3 Jun 2024 16:50:38 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17DEB831A1
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 16:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzcWF9QEzBeH0hUEZD8Zb14sPOqJX4C/6nDqUb9Suavk7+Ztx4tJ/UQF0Z4mYUzF/A3aUBLCxHmpvnVITzPOhuL53udTTxKTSvgZIl/SP1HfBsdWfwk+dHgXNveLHm1HWH/++QaIx0Jyt/ek0YRyIWZuhRy5Ogxve5Hm1VxO4HaywHQiKkaCyHYO4BMy9pN06AoFqfcm9TCLbm/4NQ82L15wI9ZbmVO2Ce/kRbYJagYq6HGVvIb3sNjYROBTJrOXlZD3X91n5kGHb+6+c/hVH/d2gTapj7C/QGETFftOHJoQS1cgh+/UtAY9armga8Xs0A4na5xcu6RmPho3Vqf99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgFQKPJ8RrKMGyr2dn+9hZ22RLdqyOHVyUe1Fqw2vOw=;
 b=nXzRuUgk1GTQ5EVd2/iCTNUAb1X+Y/8530kJudV/RgJu7GxwFfRUReoWfoD8hteO8zV+ihaGJMvFlIXE10h5S3zBbPjIlbvi1kj5cK6OAD6ZwiQ7nqiGBcp2V8eK5jShivJGMiS/Dx8Va5ox6HGSHdyWgEtzy/Veh1qjFH911DILkxe/sE/BYBiCYaXgjHOzPuyvYO89uVJ6ItgieXlKJ0VDnH6tmJKoq8Ux/5/VmwkyAp9p+sWoAReREYqjY3hTAjUDuS+RR5MtdAKvJQ4lzgPwXwN79qMEj2wjCBghqpBEb8QGh41PC01S4KI0wBxtaXa502flLmG/kwD5Dk/a8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgFQKPJ8RrKMGyr2dn+9hZ22RLdqyOHVyUe1Fqw2vOw=;
 b=ZTdsIz1d2ohIQQ3kuCqQ3NZOjkHTSfhMDC9psZY2/c1I28Gc4E4fShs4Wvak+nHGnO2gzLyd35GS/dxHSlaxigyv8XVwE3m3fIGvnk3H+e8CGFSSLJwzfhgGJEqn5PkSpwS7yhUNYgKFE4uj59Y8U37TBmllj8LjcwpRBkZTqpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by DU0PR08MB8905.eurprd08.prod.outlook.com (2603:10a6:10:47d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 14:50:34 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 14:50:34 +0000
Message-ID: <efaa2184-d082-41c6-8e8f-682d60771e8d@weidmueller.com>
Date: Mon, 3 Jun 2024 16:50:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xilinx: zynqmp: Enable reset_cpu() in SPL
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>, Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240603133447.173402-1-lukas.funke-oss@weidmueller.com>
 <20240603133447.173402-3-lukas.funke-oss@weidmueller.com>
 <d0489c83-7225-4127-9ba6-e9b29165d2b5@amd.com>
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <d0489c83-7225-4127-9ba6-e9b29165d2b5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::12) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|DU0PR08MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: a40d50bc-1d63-4455-2740-08dc83dc860d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFg0ZXEwTU9ZN2FERGJPVjBnWm56dWVPZUhDZXJ3STczVm90SFF5Q0twQjRo?=
 =?utf-8?B?Y2oxS1Y1U1FzMG5jaG1NYkZpTEdoc25nZ3NrY2l4L2V0Qm5qU21id0RCSU5B?=
 =?utf-8?B?MlJBZ0F1Zzl2QXVaUEczTTZJZHlhV3BJUUZGVjVvNnBQOFJnTWJtTTlLb1NX?=
 =?utf-8?B?KzJ3REVaWitDSVlPUjUrT29TeVFlS2NKOXljeHN1MHNhc1c5UGVINVFBSFRW?=
 =?utf-8?B?T0NwbFRBZWMwblFVZGVUWGlvdkZpbmU0UTBjV2QvRzJFTGVaOGxEZ3JtOWpt?=
 =?utf-8?B?YlBUZzY0T1dOWjlDbjRFRGl6RTZQNmFKR2o3WkxCM2Y3QTdQaHpvb254dnhk?=
 =?utf-8?B?K2RJRXBUUW9BaTNWZ3VTMmtjOTI1R2tFcjNPeU1KYW11dytiSlMwZGhNTVBZ?=
 =?utf-8?B?YmtjY09kRGdQbWNvdnRzUnhCaXN5Y2pCSitHZ0UrNG1jSHVFdUVFdkVobFRE?=
 =?utf-8?B?NkhRRXpMMmQ2dk9uT04zSDAxNmdQRHlFN0hrcWo4Z1VuT1l3QUo1YVJHcXdW?=
 =?utf-8?B?UDBoR3NGNlJMRUlGYnlSN0l5ZDR5RFo4eTJBdnNsRk15Z2xadllkaUNBNUk0?=
 =?utf-8?B?U2N5RjBBL2hGZklMZ1oyelVsOGR4L1dPVWlMYkN1QzE4UXVjZG1mNzRxVkVD?=
 =?utf-8?B?U2IrNExiZUUxd2IrZnF1MXl6SUdPZVVwMk9WUzFQdzNidkdMNGJoeU9ocmh0?=
 =?utf-8?B?S1VqSEJWeFY5MjkwMVlDNkozMGx6QU1jdTg4K1NncUZWbitBbnZKSUhBa3Ro?=
 =?utf-8?B?b1JpWCtFdW8wN2QxYk14MnE4TFI1M0lKMXhhOFZ6R3kyNkZBRlVLdVowN3Z6?=
 =?utf-8?B?SVhETlNObkpCMFFocDZFdFV1ZmNzN29xeG9HZnZ5WCs4aC9lS29DeCtFR3pH?=
 =?utf-8?B?RHpVRjBURXB0dUkrRVNWN3RibmM0b2R4d0pUTlhQSzlJcXFLVy82OHNUUnZi?=
 =?utf-8?B?NGhiTjNXSUNWR1VaNUwxeThxQ1ZUckMwMWxRWlRsY09GeVpEMW0vWkVKbE1i?=
 =?utf-8?B?VkxCRDN5YWZzMitLRm9tY1hCTTJLOEl0cEZHTTNHM2V4S0QzZjdTbGwvRWpX?=
 =?utf-8?B?aWtrZkR4UGR2dy9GSXRHU1pmNEpFak0wcHY3bVZ2K0cxVHAzUEptdWNMSGpp?=
 =?utf-8?B?NkFpMFRoR3BVWHQ3VmhlUHFrc095a0JaMFlnL3JkV083a21ybG9NZGRoUW5h?=
 =?utf-8?B?ZG5JYTBBbmNUR0ZEbkxvVmVlbitlaXdvT0V1QlJ3Rk1wR3BLSEVOZ2ZPVFNq?=
 =?utf-8?B?NnpKQzBMbmdDMWQvbDFlNUpOcmhmRjVDVEs2QWs5b053ZFh5VTBjc2R3Znox?=
 =?utf-8?B?OWVFMWlvQ055NUtkMmlCMWVxbkppQzJKVmZ4R2lqT2dkMXl3VlhYNVlnZy9Z?=
 =?utf-8?B?aDFrMjEzeW9NZzUvYkkwSFB5akV6STJsUEFtcks0c0hjYmF0Q1VNV2JQa2o0?=
 =?utf-8?B?T2VhekllZ012RVUycmdobXVlTUFNSDlSUkVIZkdiRm5VZFI0TFpDK0JJYTVV?=
 =?utf-8?B?UHcvNk02eTUyS1E2a01CVnhpVHpDbFJWZVZBZW9GVFdBZWtlbEoydmtpbW1l?=
 =?utf-8?B?VGxUamJvMSt6OWk4Y3Vkb1hHejBMSVZRRXZTUGlnODkrV0dESmxjMXdqWFNU?=
 =?utf-8?B?UDlMZjlNSEJMMzdnRWpCSXM2eHdETzVRb3RHTjN1K0pvREZWaTVuWS94RmVE?=
 =?utf-8?B?RnVvUEF3S28vZTQ4cVJrKzVoRWVCRS9zem4vWDVHTFpHU0dkblYzNmpnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUlBRmV6enBMWHFDNEFzZ0thMVU4WnY2NGRualZlcTEzQlo0dkNRc1Q5cCtv?=
 =?utf-8?B?cnpLejlodjVKR1JQaWovV1hFRnM2TllJYVhlR1pGYmxuMFY2Y2lRU1VrRjRj?=
 =?utf-8?B?YWZsOVNuY2RLWHhBbEsvN3prS21ZT3R2MGJPd3NBOVc0bWUvSG4vZk0xZTdG?=
 =?utf-8?B?MVZsbVRCVldLM0owVDRoUk5ydDBXWGduMjZwNDk1TEJLZzV6ZUtYMGtUQkFJ?=
 =?utf-8?B?Z080aVcySkRab2pacUl0a2dTcCtOVURFNWliZ2NXbzdEVFVUSGxadlhOM1FL?=
 =?utf-8?B?N2NSd3Q4MitiNnJlWnU3blFTbGFoTVJQR0xJMkdWVTNZQWRvUUpxalUzeEFU?=
 =?utf-8?B?TVhySFg4QnVPZmJmUDkwdVREVElzNGJtNVg2V25hRi9oUTNIOXpoQWxmTWwz?=
 =?utf-8?B?bmE4bEsrWHVoUUplNnI0cVFWOXhNRkJvUzhGZlE0YXdZbTRpRDZqRFcyQkFQ?=
 =?utf-8?B?THVOVVZsaXQ5Yk1vdStMdVhzRzVIMjZIZzdyYXYzSnFHNnpsQzMwTzlqUStO?=
 =?utf-8?B?VUNFeWNZeUFpemxWKy9FV012b1hkS1R6T1JtbUZ0Y1RZZ2p5QnJjR1V1c3V2?=
 =?utf-8?B?NmJmT2ZqSzhYaTNRWHJJMFEwVXk5dzBmTzdrRnhXUnh5dy9hOVg3NDJxd2tL?=
 =?utf-8?B?UGpHZlpUbmFoVThhOU95cXc1ZkFiN0pVWFh3aHEvSU1DUjZMdlBwR1pxeVpz?=
 =?utf-8?B?NWQ1Y1dHWW9DVEVMNjF2eHhKcG5NQm5vajdjbVNhdHBvc2dDUnIxRkxmR0U5?=
 =?utf-8?B?OVU2aW9jekRJWlpJUXViaThyVk1yZHBJYzVwUEtXejBqVGFlL0Y1NW9mQmU2?=
 =?utf-8?B?WjQyaEJpU0VyYWlNeHM3U0ZzckVhSzNrWk9ORzhFSVdobmlYbnZkYWczUGlH?=
 =?utf-8?B?d1UvYUJ5WnpvV2VqUnhZbXJFaUN2ZU5DQlVBQ0JMS0I3dFlNVDlvYzRxNlRM?=
 =?utf-8?B?N0F1TmRXNU9KWllMalUvamF5OSttRjNjZm5wZVlsWnBDZHdVbXpXYnIwS1VP?=
 =?utf-8?B?SHYwcDQvMi9JVDF6elVwLzZ4Zll5dDdBY01RUmZXZWphMFlabENZaDlmZHd6?=
 =?utf-8?B?ZXZqbnlPOVd6cjZmR2U5OG5nWHVmT3lReEFIallYaUJXT2VCNmdURXZzWE9T?=
 =?utf-8?B?RTlVWjRud3VSRWtXTXB5ZG5HeHh4NGFQVTlCVmtuTnZNUmdBYjhtaHFMbWtM?=
 =?utf-8?B?azhtZDBJSmZEZjgyQlNOREF0RUxMU29RNHdsdE9tTVJ2TkViUHBkeEtJOGtS?=
 =?utf-8?B?OEozUEhtOWVOUHBBK2s0Mzh1SWtjR0c1WUlaWjZ3VFk5RzR2ek1pWngvMktr?=
 =?utf-8?B?YWk4YnJITnROVnNldFRqTCtaKzJGQXBndFFIeWdwcGlNZSt1azI3Tlk1emRo?=
 =?utf-8?B?YWE2Q2tHQ3h6VC85VXNTQjY4OVlISEdxWDd0SzFabllmL0M1ZDJuVjVCT0RI?=
 =?utf-8?B?TkpTUHcySUNhdnJZSlo5K2NUcFdqYkZOQ1A4V200RHRoL2VOb20vTWlpWEFv?=
 =?utf-8?B?Y0FKQW1iVFJrMmNYa1lOOVhsLy8ybUkwWFA0VkcwTng4aWdqS1IyaVpleXhy?=
 =?utf-8?B?R3RLRlhYVDFObEpHd0ZqOGFEWEM1bkxuc0hEZVFrY1NUVGY5c3JkWEJabFRt?=
 =?utf-8?B?OHRDa0ZmL3pwdWZwcmdzSHdoclhUQkxua3BGRkFlMGFnZkZTSWxFZVVnTDFz?=
 =?utf-8?B?MktxSW42RDlCcmFBMXBMRWlvekQ1RnlBQ3JYUjVQYUtDTEJ0MThidWk1YmRl?=
 =?utf-8?B?bnB0ckN1ekdMbGVnWEJaLzlSZjRPU1NVMkxXVytBM0dPdEFBMDJ1MjBOeTVi?=
 =?utf-8?B?UGxralBaWFhDaEVLZmhWZmVzNjM0K1VjSVdMZjN1cDRtVmRVVDdBemxIdXR6?=
 =?utf-8?B?UzJkMExlWGJXTDR1eFVqYmQrK3l5TWFEemxvZGk0aWxEYjYwbUZweGxZVFBh?=
 =?utf-8?B?YUhsZUVoL1JGYWxSOHNhQ2I0Um43QVdBQTF6TCtNSFdFT25WZFNQMDY5QW1N?=
 =?utf-8?B?WUNRbGdDd2VJQVloamdydittaEkxOTNCY0dVZlp4ck8vaDNxN2Z6UnFGRnlT?=
 =?utf-8?B?Rnp6RGdxbWRLSGs3NjZ1UXNudEpxelJvTmkrVzlmaTc0dE14MmVQMlpyMVJs?=
 =?utf-8?B?b3NweFhSNzRlQ1NtMjc3SFdyb3FPekswbWVmTHZVeFpmaER6S2R2Z0lhbi82?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40d50bc-1d63-4455-2740-08dc83dc860d
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 14:50:34.5910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfJ880oYNapHDOa6ggcXwxACtQZ70g9OyYQ1Saudd+c4OPtb6XhtPjVepygGB0GMXR7VJJiCPW7AM73sxfG+hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8905
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

On 03.06.2024 16:32, Michal Simek wrote:
> 
> 
> On 6/3/24 15:34, lukas.funke-oss@weidmueller.com wrote:
>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>
>> This commit enables SPL to reset the CPU via PMU-firmware. The usual
>> reset mechanism requires bl31 to be loaded which may not be the case in
>> SPL.
>>
>> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
>> ---
>>
>>   board/xilinx/zynqmp/zynqmp.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
>> index 95a134b972d..99f5c178c1d 100644
>> --- a/board/xilinx/zynqmp/zynqmp.c
>> +++ b/board/xilinx/zynqmp/zynqmp.c
>> @@ -40,6 +40,7 @@
>>   #include <linux/bitops.h>
>>   #include <linux/delay.h>
>>   #include <linux/sizes.h>
>> +#include <dt-bindings/reset/xlnx-zynqmp-resets.h>
>>   #include "../common/board.h"
>>   #include "pm_cfg_obj.h"
>> @@ -285,6 +286,14 @@ int dram_init(void)
>>   #if !CONFIG_IS_ENABLED(SYSRESET)
>>   void reset_cpu(void)
>>   {
>> +    if (!CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)) {
>> +        log_warning("reset failed: ZYNQMP_FIRMWARE disabled");
>> +        return;
>> +    }
>> +
>> +    xilinx_pm_request(PM_RESET_ASSERT,
>> +              ZYNQMP_PM_RESET_START + ZYNQMP_RESET_SOFT,
>> +              PM_RESET_ACTION_ASSERT, 0, 0, NULL);
> 
> If you disable ZYNQMP_FIRMWARE xilinx_pm_request() should fail.
> 
> we should likely fix it in drivers/mmc/zynq_sdhci.c:114

That's an odd place for a default implementation. I'd like to move the 
functions to a common location but I've no idea where. That's probably 
why the last developer moved it here. Any suggestions?

> 
> Thanks,
> Michal

