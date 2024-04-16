Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6715DC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 10:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABDAC882AC;
	Tue, 16 Apr 2024 12:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lZerSh+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8342D882AC; Tue, 16 Apr 2024 12:09:42 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CBA08833D
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRwtOvdf61UChBxf6j2KmTt7lYbwhe4tg+SoMsaUvSkUi6+MI6ei9en2V7vdVDX16VuYOSHTEb+LmHAHuhdStcmvfL4OpvnO0/wB0Nn6OIYH7EsZuNdoqye+eiFAdSYEDf05cXCKWJpEANgK6SXt1ntPAdZaEh8/eLxaxjnGm0v/K+Bt7qdYszxC3Gam5CPGEluM7dn34+zN+zytC8NdfZkXO9FsuQins0o4VeEvBxjBDevSwG1uq+yfUTV8YMsvHKqqchDwZS/KNjTAO7j+w850MeU5/luNATULQYR7vc4xTOudHnk0NovEDWFWmQL8eA+rXbtlbwA4yTYsSZZG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zem5IhnySvS2bs3hEn5NhnzMqgnbupwITES6kfU9XGk=;
 b=Lfq3pa7EQWcTJhKS7++SxGcV1ay96/fk8qG1bZBnTuYIhu6DYEa5zO39eVWJIZbZU73Ng+V8yN82ZUxxz12gsyQ/my2pCGZ0He3pGnGSPe8BPOCT4/+Lp/6ZQGEiC2oNWdyYW4VxdbL0FfVwRxds7kQD3a1arsiaWwqp4/GKxBz3/KTkjnLPREhSXH9AQGt6cmYBfb2ICe2NlTPBfnAYMiRuwGVYpg1Rtz5YI07IApp8TOpXGT+S5893DBC//1Y5O1rkcVKQQkCKHet3/XJ2rOuk81CNefrF0EeEmZiYyci2NTwYITwJkirFGyZypRu7r5Z17JpfmlQJQVuOEX7TkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zem5IhnySvS2bs3hEn5NhnzMqgnbupwITES6kfU9XGk=;
 b=lZerSh+6ZvOz5R011elU+eQprVA2A53TAy8NoiXZpHwrCzHacR1JQYBaSNWQljCQKFbwqkMGh3i0c1MIb1f6Ebn5hpKVAt5ZceivCFtFgX5wpcWlv4+U4LRIuPGB0gf+qSM9GaxojuaZg4G/jXpEZmLb8kiFvtl3XOfBTbA6BxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 10:09:33 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::40b9:ca6b:89d7:f45f]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::40b9:ca6b:89d7:f45f%7]) with mapi id 15.20.7409.053; Tue, 16 Apr 2024
 10:09:33 +0000
Message-ID: <bc3ef401-a0aa-41f9-9004-117e7c7b836a@amd.com>
Date: Tue, 16 Apr 2024 12:09:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] Kconfig: Make all Kconfig encoding ascii
To: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Lunn <tim@feathertop.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>, u-boot@lists.denx.de, git@xilinx.com
References: <cover.1713180904.git.michal.simek@amd.com>
 <55ab78c9f2781b31278395f9e0066041f97b00f6.1713180904.git.michal.simek@amd.com>
 <6b45c003-f6a0-4ee4-a01f-e5acc81d68a9@gmx.de>
 <20240416003612.GJ1054907@bill-the-cat> <20240416065946.GC4165@francesco-nb>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240416065946.GC4165@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0213.eurprd07.prod.outlook.com
 (2603:10a6:802:58::16) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 851f0fd8-a7e5-4ade-0831-08dc5dfd4fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OCdC1AlFHLETiJThl3S14WC//+A2I/p4uy7MiciQW/WL+uTOgX4olhzAvFPHMlMptUWZc0g7JU/RDEJyTyL9zrQKwoHFhFiqjlCvMsmnWNMWjAF7Ls7++Zd6qGKUkBwLktuUjMBmOEeK+kvR6UYE9k3Q6uYErekJXBbouclnnbwmOjYcKYjksTVtFKfFf81s5UFIx3o/ecuG/F449YH0jc/F4ni5HLK9exG/8sOWpuqb+yRveudW1nK5GFjIPvTUAwKkdcK4DcDxriMQrpQOOtXPwawHjdxwj85bOQI94snKJLgCpZYOEvkWL3+mavUcKlFuso7X4ksOrzriMYr5LCKqeoI+KAnd6q/8OoSi8/4egEx87i8a2hU5GISmfR2Ofdn6tUJW5hx4a2VVuOchms4D5mqFkn6JXaci2DA1iiID2ZyQGZflbpIn8z0yZWAIuD/HloPyorp1cXcYerWyOuRryajiNPRKTfIChB5Z+6kPoSdoNkljpYeYcunmNpNElxBli9RpsiI/pv3T8WNenAc5K2BY3W1jR2EmYXfi9gywWnsIyUokJqlhDgcPYhoAkSaCc9p4DMBsTETWjYatmsm5WWdvZHT+T6Gz8q1ZLcHe8+7Wf2aeOYo+hx8F2na5e/9g1SCxQw2RQPb4q5pF5QWmSVHAHJ3I8m4WsOzKL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(7416005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU1HZTYwRHhxTnVmVjc3eXl1eWd3Q3ZjeVZ6di95Vk9kNGpTVHBJaFdyWkEw?=
 =?utf-8?B?bHZrQkxMc1Y1Uk9TTmdQSEFxdUJhSHhvSjViMFVCQkNkSVkrcXd4di9UWmww?=
 =?utf-8?B?eEVTOTRLMUNzOW1YbVBnekxCOWlHQVFBU3pNdVlzbDZHblRKWmphbTd5UVMv?=
 =?utf-8?B?Q3Q0S3BwQkcrSEZVOVJmcHkxb2VzVk43U1dMcXRJWDB1K0JMMGhKa3JGTk1N?=
 =?utf-8?B?c1lBVnNwekJHZ0lxb3lDNGZjTVNzYXkreG4xNXE2VjVvUG9ZUDAvRlROVjJF?=
 =?utf-8?B?emwwZ25GQm1PMktrQ2hZbXhYZFM0NTJmQnkvY0Q5QXM2SVNzaTN4Y0ZuUHRI?=
 =?utf-8?B?QVh0VjNGMnBEQXJQYXp3ck1weXdxeTBZbnJVc2lHV3BVVGpBRU5JTGNrcDEw?=
 =?utf-8?B?SWVUQnNaR2JIRlFDWktCbjlXdmVGbW02YmdpRjk4TW5kMlZudVdCSW5oMld6?=
 =?utf-8?B?T1ZBUEZKaVp0WUEzMWlONEdGcUw4LzdJS3JQUkgzTEhMTHRyR2J1QnhjMytl?=
 =?utf-8?B?cnFxOU50dlFWZ2pqS3poUGN0R1hhN1NKV3JpU21qNHBlSUlINWZlQ0pUa0Er?=
 =?utf-8?B?aThuemErSjB5TlVGaXNxUlh5U1B0MHdKME5RK3A2NS8vVnRidUNBUWxXcmpo?=
 =?utf-8?B?RGhwOGRiaU9NUmt6TXJ3Nnh2UjJzWmR0aFByc3NPcWo0bzdMeXh4QXVHNE9p?=
 =?utf-8?B?WUdXYUtkWkdLQmZ6RmV1ZzZ6SnhnZUdOUXJGT0JtRXVOTjBYRmRTSnZqeDJD?=
 =?utf-8?B?SFJ2UWVrN2t3T3pvSnhOb3RiNkErbE9BMFFQcjlaQW1XblZxYUo5MWJSNVM1?=
 =?utf-8?B?RnJyWU9vK1d6STcxUVJBVjA0YzV0aVl5b2ZYMWNNcDJ5QTg2b0dIZE05Mmdy?=
 =?utf-8?B?R2gwVXpUN01Xb0tXVU5sNm5HTVh5ME5iSy82Z1lwcm9TY3VlVmYwOWdRaXVI?=
 =?utf-8?B?L3Nkc05WaHNPa2k2cE5VZUJqWUczTWlKNy96M01zZzlQSHhxTk9BYjhTa04r?=
 =?utf-8?B?SjhnbkQ4bGI0Y2xCWlVVTXdBK1hSYmliVWl1OHE2Z1FhQUk5Vmw0L2lzQkZv?=
 =?utf-8?B?MnREZU9xSDNOK1ZLYzZVRHd3TzR4M2psV3JuOFppZnNST1QxRmtHZE9Ic1VM?=
 =?utf-8?B?YVFjcUwwdUM4c2IxUU1rNW9MY2JTL1djOHVwNW9sOG5VWUh3bmJxTEhPQWhp?=
 =?utf-8?B?L3RjTWtvVTVYNzZEK01KYWZqZit3dWxBblhNM2V6MWh5ckZjMTlsY01zZmtC?=
 =?utf-8?B?UllUaWNnQjZnZzZadUdVYkZ5RE9Pd01yR2FvcW1QVTYvMVpDMGxtVEVkTXZP?=
 =?utf-8?B?cGV3ODhpem1kME9LWmd5bEtnT0tyZitiMkhCOHpONFNmeWg1N2YvcG82c3Jy?=
 =?utf-8?B?cEhPKy9wcHJIMm1nRDcxdGZnZzIraUdGcW5vSUZEWFREU1VWZE85aFVxV3Vr?=
 =?utf-8?B?cXg1eUVVNk1jb3UzWmhEZ3JSS25McGhNUmtIRTYvdWlaZEdjTGUyMVFGbXlo?=
 =?utf-8?B?MVd4b25ObGZTMnNzUTZpcFJVemZmZFpkczhxN3JveDU0ODhmV2F0ZmZzWHpM?=
 =?utf-8?B?VnBPT2h4VmpucEY5R0hJdkZqYXh6dHVIUkVJdXk2S2N1ekhYQ20wV3pqUXc4?=
 =?utf-8?B?QXZQK1U1Y3Rvc2IzaTZianJCVWw5L3ZST2pKbnZ1S2d3RW9SbDRrSVZMV3FI?=
 =?utf-8?B?bnVVUys3NmJIcHpuNEFjWHhXYzZYekVvNEE3UUtVL1NzWW1hRUJlbGt4Tlpv?=
 =?utf-8?B?aEc1ak9zOUlLTSs3QUM0eURMVmRkT2hCY0xGUU1RQUZpeW5oOVVPZ2loY21t?=
 =?utf-8?B?K25hOW5QMGE1YTFBREIyZkY5Y2Q4cEgrd3JLbjhJV1ZBMEJoWGJsVjdQRkcx?=
 =?utf-8?B?UnJyWEIvdGhjdGVoeHEyMjdyOXo0ZE5ZUGRGZmhSanhkWUJGc01lNlR5aFhh?=
 =?utf-8?B?MW1RdDlEdWsyd0ZzMEJQd0xvZ29qczhkNEN3ZGxrY2ZjenlRTmJBb2c1dktB?=
 =?utf-8?B?WHFIcEwwam8xTWoyWURsMVlucmk0WFZyN05SeTZhczJxT2FZSE83YklzcFo0?=
 =?utf-8?B?UmVRM20rL21mSnBORi9FT0w2YU0vbVZhczZ5UEJ4bzZQbkR1bk9nL3Z4Sm4v?=
 =?utf-8?Q?PpxyvyvEomBIddG8g98sL2HfA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851f0fd8-a7e5-4ade-0831-08dc5dfd4fcd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 10:09:32.9456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88YHDz2M91vI1d1I8WIQfxjpm2sA5/7nqDGmMw62kJpgqGsbsMeTqQVEHcQ/JVzG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
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



On 4/16/24 08:59, Francesco Dolcini wrote:
> On Tue, Apr 16, 2024 at 02:36:12AM +0200, Tom Rini wrote:
>> On Mon, Apr 15, 2024 at 02:22:02PM +0200, Heinrich Schuchardt wrote:
>>> On 15.04.24 13:35, Michal Simek wrote:
>>>> Some of Kconfigs are using utf-8 encoding because of used chars. Convert
>>>> all of them to ascii enconging.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> [snip]
>>>> diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rockchip/rv1126/Kconfig
>>>> index ae323ee91235..64a70f61f894 100644
>>>> --- a/arch/arm/mach-rockchip/rv1126/Kconfig
>>>> +++ b/arch/arm/mach-rockchip/rv1126/Kconfig
>>>> @@ -6,8 +6,8 @@ config TARGET_RV1126_NEU2
>>>>    	  Neu2:
>>>>    	  Neural Compute Module 2(Neu2) is a 96boards SoM-CB compute module
>>>>    	  based on Rockchip RV1126 from Edgeble AI.
>>>> -	  Neu2 powered with Consumer grade (0 to +80 °C) RV1126 SoC.
>>>> -	  Neu2k powered with Industrial grade (-40 °C to +85 °C) RV1126K SoC.
>>>> +	  Neu2 powered with Consumer grade (0 to +80 C) RV1126 SoC.
>>>> +	  Neu2k powered with Industrial grade (-40 C to +85 C) RV1126K SoC.
>>>
>>> C is the sign for coulomb which is the unit of electric charge. How
>>> about 'deg C'?
>>
>> I'll note that in Linux there's seemingly nothing consistent, and I'm
>> fine with any of "deg C" or "degrees C" or "temperature range (-40 C to
>> +85 C)" as all of those should be clear in context.
> 
> My 2 cents ... while I agree with Tom that the context will make it
> clear, it is not making it correct nor nice. Using just "C" for Celsius
> degrees is horrible ...

I used deg C in v2 version.

Thanks,
Michal
