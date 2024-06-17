Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE58C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB2388283;
	Mon, 17 Jun 2024 15:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y2kZOiJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C45787DC7; Mon, 17 Jun 2024 15:39:19 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B97882DA
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:39:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3c9xszXlTEV/eY/O2LSuW+P43TzNtWNdDbcVYKunVO4232LXDZo/6MbFZ/3IuW2TeVXnQe5NSNfj9t4FjRsiY7IchUmLTgsI3tubjy2rtXOrVdSP7c5QdDorS6sP3zMckneic6B8MlReK7Y1vHUyOzWYpqrjaRasXZZC62IRTKnwyUGiRLFtHqHhuM6NF3Yg8Dd0KDl2jJxYe2W6TU0+5AybVksKQ0gKvFSF6wNJ1DrHFnUFU0Z/xSU+EeoFoziW3NpTf1Bt7PPLSQpKJzonvfBumM+/y690AHU1m05AptlukZFBloiaA1C2dZgE2FY89/mq77VrIRXpXZp4xnn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3t5I/cCh7GA9oWvMJFjf9pRUdwDA7IvmoaPOwsnyjU=;
 b=Rdxi+96cxcZR4sef2Du4/DQYmWvyM8pP/vo2b+RVuTiJarKGMEGrtdzZ/tgAyVG+63IFfX1/7KPYZZ2g/pFSEVAHS+ngWwhfZkjhiKRk4cGF0U3ecDIPwddz8Evaqz7n5q0m4vZv3Y0hfvCiEFK3LPcIOpvN4IUwLMQqRhvlnJEk8jy4jhlPbf8tvxvcbJ4Ych77uNpt/5j/JH5Hhkg6hOmaRYymkuHD5dLaRvwsA/kMotEtf3BZnQ2paCOMrQn0CDgG5UlhOOxpv2FEc4HYpdWZ1ge4boQYQ2Q/FmD6Q1MgL6D15rECCt9huydmaBKCTzvTAKqY3Augogp4gu7ALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3t5I/cCh7GA9oWvMJFjf9pRUdwDA7IvmoaPOwsnyjU=;
 b=y2kZOiJS+93k4VSdwS1X/jtxTRfXnllxwWoEUQcOvpxmWovfUrxHPl8EAfRoWsOfwnTVuBMbuTGFrEaA1Js1OnZfuVWFova27Bs7WgTfBQ82eNe3iN5uhRc+h9jEON2y5h6mgLPevfnLiX0U/IBCnwPUqPAcYXjIEtCwI4hT3ZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 13:39:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 13:39:10 +0000
Message-ID: <ae2f27e8-dbb6-4711-8659-0c47e3a9de54@amd.com>
Date: Mon, 17 Jun 2024 15:38:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: ids: Add IS25LP01GG flash support
To: Dragan Simic <dsimic@manjaro.org>
Cc: Dhruva Gole <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>,
 u-boot@lists.denx.de, venkatesh.abbarapu@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com
References: <20240617041841.1336632-1-prasad.kummari@amd.com>
 <20240617062822.474khxwuq4yxs5ra@dhruva>
 <18ca247a-980a-4d6a-906a-bb5719482626@amd.com>
 <ce7685916d3b76527425368754ea096f@manjaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ce7685916d3b76527425368754ea096f@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0001.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::13) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 2359d626-9e23-47cc-33fe-08dc8ed2de5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmdMRzFrWnhINVZUdHRXdEc2bzM1eGN4R1FiY1R4ZlNvQjN3dVd5YnhMbnIz?=
 =?utf-8?B?dmY3QXAvTGh5REk4WlN5cFJieDhycGNJUSsrMDBHYlYwU3o5eTJQRUIrT1ZF?=
 =?utf-8?B?UUNzblIxKzRaZ2NwVE9QeHpjMDRmRFhGeFhNUVZUZUhyODFucExha1lmc2Fv?=
 =?utf-8?B?RFhERjN6dmVVbm1pbW9UekVvSjRXQmxCMXQwRVBZR2w4dE5KUzRLUTh5dkp5?=
 =?utf-8?B?LzZlY0d4U2FZdE1tNlFMZ1NLMGdCeTZzcSt6bk5Hbkx1bHQ1c2ppUEJ0bW1C?=
 =?utf-8?B?b2hrSlBlcmdsVlVDOVJ0RzF6SDFQdEgyQlNGM3pQVWowc2RFUHBwamdxUUg0?=
 =?utf-8?B?OW83MVM5KzE2OUJXdURmbWQ1RG93L3NTTjFjVkM5UEpWZGVtMklna2RkaFhn?=
 =?utf-8?B?VnhhSkFQNEhXdVVMbGlNQ0NGdUtubFVxR2FodmxLeGxsaUV4eS9UbEpXV2FT?=
 =?utf-8?B?aXpFbGJxcWR0QVdDV0k0eVZOeVZRNUM5T0ZVOGVHS0FiY0YrVWRDNkQxR1dR?=
 =?utf-8?B?Q1VKT2RTWVlkbGU3bUpDQmZhamRHVjZReWY0dEU1ZW1MdkoyaUhqekxEQ3Ar?=
 =?utf-8?B?WnJ3OVJEVCtwd041Q1pVblpVM0poeGh1SXVUYUNON3lnOWYvM2FtTlJvQkND?=
 =?utf-8?B?cUJsc0I1OGNIY2Fmd3pvdGIxcnFiSDVyWEZSMW5EK3lnbjNiSTlEYzRkeUg2?=
 =?utf-8?B?c3ExR3ZmaGhWRnp3bTJzaEU3dWxESXJvcDFla0hENFNyVDhXcGhPdXZnZVJ0?=
 =?utf-8?B?d0M1d0RINUlIWUYrT3F3SzR6N1NRWkorS3dodjhLRzd6NVRBK0dpOTBBcUJ3?=
 =?utf-8?B?eGJtNXY2TVJ6Nzl6NWVtL1dMU1R1NTRaLyt2ZzRySElLcW1EVkJCNlUwdGFt?=
 =?utf-8?B?MFB6MGZvOXdOL0VXMFBud1NZZ1Z5QUZkc3pxb2xGeXlURlBRc2hrOXd0dkVP?=
 =?utf-8?B?RmEwTzcrMzZ4SjFEaVBLL1RyWm1hL2piMjJIV2Y1eG1oUzh0eURWN0d3OWdD?=
 =?utf-8?B?cjhPaUdBVVppSnlWNGZwVlp4cDRIQm1MbmlXaUxZY2UxMG9ZZ2dtUVBJTWFh?=
 =?utf-8?B?cVFxbmFwUHFqU0t4Y0d3M2dsR0l0ZVVkckE1c3V2bXQydkM2TW1ab0Y5LzhW?=
 =?utf-8?B?MStMTVhzNzVvSEhWTnNlS3VJV3JxVWpvOTBJU2JDdmRmZ1g5OFpoMUp6dEly?=
 =?utf-8?B?SndmOGtNeVZ1ZEZQTTQ2MlhoNGJ1RS9nV2RSc01LYUM5NmZUTmlwckY3Ynhy?=
 =?utf-8?B?anE3am5IMVp3RmNMaXRxZnRlRTRVZGVwbjh5Ym5HR3hHbHN2R3VNbThQdTBC?=
 =?utf-8?B?ZURKQ1BOVnJKenRpZUc1d29BSmw0MFVyZ29jeHhPWE1naXhLb0Flc0N4U0ZP?=
 =?utf-8?B?MWMvUHhvd2RPcDNyQkZpSnVFLzRURzlrU0hQUzhTajFCU3hFOVpLUHhWZUFz?=
 =?utf-8?B?bG9xNmpEeTNvRzNxM2tZSThGK2FFVXduR0EvRWZjUi9qc0ZkNUxDdVJraTNs?=
 =?utf-8?B?cG5RblNsa2Q4S0JpeWE3dmgyR2JJM2tSOENQZVV6ZGZxM0dPc0ZFaXRObXYz?=
 =?utf-8?B?QSs2TG9FRFdsSDJYZGNqVG5MTnp5Nkd2QldSL1N6a0JPeGJTMVdsK3c0a3FQ?=
 =?utf-8?B?RU9KUWluTmtCR1BBTVRLUmVFTmYxN2lnSW02aUhCdUlwajdxTUYzY1B2OXd0?=
 =?utf-8?Q?ficwIpcMEbcX70W5V7En?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHJaeW9UeEMrV3NIaHJkTlI5WVdRSlpHaUxWVHI0MFMyc3F6aDRmdFVhZmFP?=
 =?utf-8?B?UllIcXUwLzlFNXhJMHNDWHZuQUFkOTRxelpnWW92QmlQbmxoOFpnUnNrejJU?=
 =?utf-8?B?YUFkdGMxcGRnQ1k5RyswZzlnWWRQK1FzYWtNRlF1VDA3TU1XSTBmK0FwT0VF?=
 =?utf-8?B?Y2p1eTltTExabnhBK0NDZVh6akRub0JBd3pXY09KYjFRZzFxbS80Mi9zRXUr?=
 =?utf-8?B?TjhyYUhjSEMwT3NRSk1wNGVYd1I1L1FiSm83blNDNDVQSGY5SG9LZWYwaUJD?=
 =?utf-8?B?N1NQRW95bERYc0Zwbk1RQkhXQlpIU1Z3ei9PSTN4NDFsK0VSNXI5UUkzbCtI?=
 =?utf-8?B?OHVYVitWRENTa25WYXhPOEJJWE5rS2dFamJiZitqR2NkdWp1U1dNNjhtRFYx?=
 =?utf-8?B?eVVhNmp5MkQ3L3NXdUcyUlNrTktPdE8xUHNWM3lOcGRmWXpLNE1UbFRoMmw3?=
 =?utf-8?B?bW5QQ2tra1RtTFFhd25TK0NNTTV6alhMdTFXeUV2V1dHOWJ0c25uQ1ZUYjZz?=
 =?utf-8?B?UUxPMFAyU3M3aU45VkJKeGZyWjhTN2Z4U3VSTUFDZzdMTVNNSlZVVWUwR25F?=
 =?utf-8?B?UTZacFFSN044eVFjcmQ0d1VYOVI4V2ppRFFON1QzNXVnNlhhYzVoaVFCWFo1?=
 =?utf-8?B?US9MMS9sbUwwYWdQWUdNU3R5aDBBTy9LTHN6QnVlbFVLeGI4bTRIRlZza2Vr?=
 =?utf-8?B?T0ZMdHRZOEdzSGVzN1I4ZHhwUGJscFVva2MveXdaZ0JCT3NoMndpQjN5OWFH?=
 =?utf-8?B?cmhkQ3liU1VKanppOVVoNHYvaEJrN2NPOHJ0ZVgyS1JPMVdnZW5MbEEyRTBn?=
 =?utf-8?B?VS94ZWZ6ak5IcHFUb25xdklDOEFuTUQ1WE9LNThWRURybW9OTkFXMTJLYnNG?=
 =?utf-8?B?TUljaXpPOE5DNEFvWnRFWDV3RnFPR3llVTliejNTQlhtOWFMeDcrYUtWMkRM?=
 =?utf-8?B?bWRJN2kwM1hnQ2FBU3YxNkNEajFwUVM3UUtmckxIUUF3T3B1WGpoZDhEbm1F?=
 =?utf-8?B?MDJRNHdGaXBhSTZoTnpoTVhZcnRwOHN6UXVhL0x0d1QzS2tiSUZENFNoeG9I?=
 =?utf-8?B?ekxPVDJEV3o0bnRQbTkvN3h6VTVVdEVVaU1GNS9VbVZMQlJUYXl5OUNGZ2xN?=
 =?utf-8?B?dTNxemcrSll2eGhwak8xd3dmcjdGTmkxbWlNWnZjMk5wTUUzV0JDK3hWNUdD?=
 =?utf-8?B?elE4MEVTYzdtZSttNXRrMkZORHpPK2s0MDYwcmZlYlpuNVNSNEtSaDgyaDNj?=
 =?utf-8?B?QmtLckgrZlpSSDFHZkpuSklzYUgycEN5NFczaFh0SlE0eFhEUEo0Y28wMFhu?=
 =?utf-8?B?eG5FM1R4YTM1aVNlVmxGQTJTcWRseTluVm54U0Y3RDAvZ3VaUlIvWktqcE11?=
 =?utf-8?B?bE8xMkNQRmJJT2ZwSTQ4T2U2ZkFjNFdXdDBtWXZZT1VJdFZEbEtFZUVWdWk0?=
 =?utf-8?B?UTNlcG02OWtuamZ3TUNBK1YwMzZHWCsxNDB4RzdXeDlpTGJtYk9GMmZsSUtW?=
 =?utf-8?B?aGpTbjJkZzNyYldWRW9zdklxTTdBTmd3RDQ0OC9PSGl1em0ySjJpQUR0dVpU?=
 =?utf-8?B?TlNwblJIY0hNZUVFWXhZS1BIbEc2SCs4aU9zWUd2T3NteVV2R2Y2Q3lTSm5q?=
 =?utf-8?B?dTdWN2w1QzNpVmRMTHN4ZCtBMnhXTUd6akxtQjEzR2hDZFlHODV5bEFFamZ0?=
 =?utf-8?B?bU1zY3UyenE4N1l3RUtNdk9xYnBwMDhTTUtzdG9yTXgzYU94ajF2eVpIUmJ0?=
 =?utf-8?B?a1g4eE9aTkpmcFdHTXB6Z3VGRVIzSmlibjRNVnJCbUNpNmNCTG1ZRTVtc0Ux?=
 =?utf-8?B?QjdUaCtvalBsV09QTUZmSGpGeXBQZ3BMajlwYkl2b29FM1pVK1BkRk5tNWhB?=
 =?utf-8?B?UWVlYSs3U0Z1SHdDeWdsQmRDelFXZTlaQ3RCNmZUaHNMMFN0ZmlRa1QwSllw?=
 =?utf-8?B?V3hWcXo0UXZOd3J4eGNoNVRZLzI4VUt0NFBIQUk4elJtOXBEcktObkZhKzN5?=
 =?utf-8?B?cGs0YkJad3REUUREZ3ZiOCtvN3o1U1lXWmwvdzIxam1MQ2Z4TG1NSTlweVNE?=
 =?utf-8?B?WHZLcVI4ZEhSS3BLMU9UZDFBZnh1QWRCZ1JuN0ora1VKMVd4U0VUWmFMSnox?=
 =?utf-8?Q?cLIyEcKgkWfAF0Su8BD+blb0M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2359d626-9e23-47cc-33fe-08dc8ed2de5a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 13:39:10.7011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AF+JjLDwZRoJ4HzGOdQq74d+73kylvZyQCTLkmdn9bz20G7XAQo5CmOOdlbMIeIq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320
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



On 6/17/24 15:31, Dragan Simic wrote:
> Hello Michal,
> 
> On 2024-06-17 15:26, Michal Simek wrote:
>> On 6/17/24 08:28, Dhruva Gole wrote:
>>> On Jun 17, 2024 at 09:48:42 +0530, Prasad Kummari wrote:
>>>> Add support for ISSI 128MB flash IS25LP01GG. This part
>>>
>>> Can we have the datasheet link for this part?
>>> I am assuming it's this?
>>> https://www.issi.com/WW/pdf/25LP-WP01GG.pdf
>>
>> Problem with links is that they will disappear when company decide to
>> change infrastructure or is acquired by different one.
> 
> You can prevent that by making sure that the link to the PDF file
> is archived on The Wayback Machine. [1]  That way, even if the URL
> becomes invalid at some point in time, the contents won't be lost.
> 
> [1] https://web.archive.org/

No idea about it. Up to Tom.

Cheers,
Michal

