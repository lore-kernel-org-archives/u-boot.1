Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A7DC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 14:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C23BB87E50;
	Mon, 11 Mar 2024 15:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bm9wjWLH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C551287D3C; Mon, 11 Mar 2024 15:53:08 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B2087DD3
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 15:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0b7s0rZjYR+/8HH2svPIgoF7xPVwIiFMx+g3/YV7UKxGbUqjNi1226bsWZgPvbVYS91yIwu5JshqUkh0JBm66KT0iOAjOFTh/Lrf+2yi1U9wmuFsx2tNtEbfpmbuR1UjuSyoMDrNrJXsk+LyjT5WS5mTXE3d3vNNTcoiI2eUJeNQ6jnF9gEiisnHkS/3/E2Fcvfz068bBolGcR55lDI1Zwo5XIlv24p6vgFSIJKdm8MgAZP5Hq9OgI/qQ1Dx0ZUe6iWuPg+qxOgs45wqdoQ4vBJ6pBLv83RKpkAZoqgUoFqHHa6fVrE3IIt6lecttW0/awZIOXb2uUx5G+vXjycow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4imUpfC/DR/hg9sAa3hHz3wI6gJ6i7RK7aJcHk//tI=;
 b=Vc7cLhXFy0wbVRn3dQlM5Zd9F59GNLF+V6/JG4nCjqzS2yQViA0lw742YtPVBRCJPx1xguA9H4Lz1r8F3KfiJeVnA2f0rR5CUwgnbP01P31u3EDOPkH1kwIG9KWXckUZ2hxw2QIySu3UgNws8fC59EXJRpwQ4dycY8CjjlbiPWlmF+kMtUfhqZ6O+O5lfCdO5ZpeNEzwWtXdfvztUPllaEnUndWbtVPUA7rA3HWOjslAnfoU98InOUUGiwuuDXk2WST8WCgTvl0dLi/JVgUBJ0Lt0uPrKCYOCQrsD3yedcOGXKP04/dLM57DGcJOr31gsuL3rI8kXvcp+aqD4EpxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4imUpfC/DR/hg9sAa3hHz3wI6gJ6i7RK7aJcHk//tI=;
 b=Bm9wjWLHWgfZOSmsYgRN7SzoBYNpsuZCI4Ayo8K0iJjPUYi5Y+eC15D2ro1G7q99CsfEB53n3sg2MltNIgI9NsVfVaESrfMLl0CUNIRWIvqc3UpHQB6KJ57q2fUqB43GGws8UZPoydTKyPWOPYVVHLllFrrC9C1MkPFUlPIHxEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 14:53:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 14:53:02 +0000
Message-ID: <9e3f916a-7e5b-4ec8-abe4-c2cead1df557@amd.com>
Date: Mon, 11 Mar 2024 15:52:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Love Kumar <love.kumar@amd.com>
Cc: Angelo Dureghello <angelo@kernel-space.org>, u-boot@lists.denx.de,
 git@xilinx.com, Marek Vasut <marex@denx.de>
References: <20240302151813.GA1652651@bill-the-cat>
 <bd0b13b0-0554-b280-a40a-17056a1e2c5e@kernel-space.org>
 <c11e1809-b5d1-46cd-a5c8-a5276b83f26f@amd.com>
 <c523aabd-93a4-f9db-2726-7f912a85aef0@kernel-space.org>
 <20240307001053.GE1523872@bill-the-cat>
 <c05a25ca-d4b7-1179-cf46-645bc4cdba89@kernel-space.org>
 <c0bbe63d-adee-456f-bcf8-44579aa2593a@amd.com>
 <20240307125525.GF1523872@bill-the-cat>
 <553992bb-c159-d9b9-6e9d-b762ea55da79@kernel-space.org>
 <cf96e2a6-9e49-4058-8bfc-f31b3d028190@amd.com>
 <20240311143938.GV1523872@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240311143938.GV1523872@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0046.namprd17.prod.outlook.com
 (2603:10b6:510:323::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: f09e5bc3-9b5d-4866-a061-08dc41daf3b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7dsMMWm8EnfOHgZcnKCHb0C68oIp+F87mZp1ZvCDZH4nhAmRqJc//wK5MjyuWEhqvMn7IF+jXbM6oD804Qjmr15S/AKVUqXGuOvjdNL6AL7t0LEbzlT2j8ODLH4l0m62xazyxifMyDKCEyURG2WTmrsJodpu1PWQ5HXDW5mxYuCeJI/0qLPX2enOpcqF4Ls4AzanwkFM6gxudZ0pH4N/N8mwKNRB4mIwxl6p6U23dh+FM9a8bbEtmV6NrdwUDJ0voXjyXnBjGD1eSJWKsQ39oK5Dhpj/QqmFSwrpy5d3UU1TfrXZgVVkIAE9r0FVCuDH4STIoUZBMf8Awb0p5t4Aw9NdZtpTYGkaTrM7IxbCa1C5ErOCI63ddyI5FoGOMXxbHOewihK7ktCi9RVOiOf6q2DznmhE/8RXVKKNLcdztxem7eRnOvizMvI8y+MBqjw4RwxA+glk1BmW1IvmHAhcJ/X4m7EHeamedJ2a1OGXxyDG7Ofb+a6cG3oKXDcHJeqrjVDXJNqESU8sa4+Xa2USwL96Z8JLZZnYqt8/4SuIp6rDcct8puv4hB+MtC5eDXuwK6pyn7Y6CCEjCrbOIwl+uExIyz2BEui2goiUGlRUw1B8UhR5IipfnU52NEY/6WqSWy5a597Ld99xdBQGf0gJOIXe+CkITfe7wv/IKRXt4EE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2RxYlZVWHV1RURtdW9TN0xETWpLcmpHKzh1QmY4dTdXbUJmVy9wVW5OQzFG?=
 =?utf-8?B?ZWZpKzRncWtaVitCaFM2Njk4NlVsWmpuR1lvSmtvb3lhUWxwSjNhbGsrVHpL?=
 =?utf-8?B?Q3E1dWUzTzRQN2srYi82ajZBaDd1aVhIdHQ4NmNVVWFlb0gwMTE3Wnh6MWZP?=
 =?utf-8?B?bnZtaVN0RWJrQmphTUE4US90MzlRd2xxQXEzZndLZGtzOGRzZkcvMXUyNXZ4?=
 =?utf-8?B?TDVaRkxzVDJFSmE5ME52ZEtURjVSKzNHN0prVXVrMmxJUlNKNHZDcmpwd1F6?=
 =?utf-8?B?YXhCNVVSWEg4NDBxYmM0a0p2Y3lIeFFReWVGL24wdVQwUTcrY3JNRXBDNjdR?=
 =?utf-8?B?RVZlZ0pOYUljOXM0ZWpOdTF4WlBPa2dwYmJvYjVqejFmYkhMZW1WMXNWV2Zt?=
 =?utf-8?B?eVhtT01hNUlSeDArZUE3aDB5dTRobnd0eTZnUWNsY2hFZm16amdDbXBTdjVj?=
 =?utf-8?B?WUNOeE9ZMEx5WlN5SUEremtGdXYva1ZCaXNhZGRwenVNZUJhTXNuRjhFQ2JH?=
 =?utf-8?B?QzBXdXY1T3RGaFNlY1hmem5tMkZlNFRDR2VLMTU0VHZPVUhGclJ1YTRLVUNR?=
 =?utf-8?B?YWhZRlFkb1RBY01XZldtR1dxWnVkUUd2MnFvMHNYWStaMGZJYjVFWXdPRHpZ?=
 =?utf-8?B?YVJWczREWmNLR0N5cDV5SXVpbTB2Qmg2TUdZQW9lMTF1VDNpS3I2LzNJNUdT?=
 =?utf-8?B?Y2xMZXBnUHRhTSt5ZGd5ZHFjSE93eFAweHRTeGpjL0hUMC96dkI1YWZxQkpJ?=
 =?utf-8?B?ZE1yZWhqS2hTMUVPb2toaDJaM1JsQytvVlVCS1RETnBiZWNPdDROTlN2Vml6?=
 =?utf-8?B?T21Jb0dBaHpHVG15aHhOdWtselU1YUY1NnAvUWkyd3U4dm9IZzNlRXV4VUhH?=
 =?utf-8?B?cmJTMTlESUpxM2VUREcyTEFjUkNQVGJqem1ReU5rUllZcktEUWxqY0RUZU8r?=
 =?utf-8?B?RmV1YnVSZUJVMkp2NThxV3p0eVZmLy91bXlSWlFjZGFJNWgraXZpZUlMbGVB?=
 =?utf-8?B?ejhKTkhhWFBnaDBEN1liZis4bElVNHRQcis4Z3dsVkw5UHBqNmpPTS9xckg2?=
 =?utf-8?B?N0FmcCtRcEJURlJ0UmIrS0lIWTlJV1o1akpGVEMveGNmTCtxaUJ2OEdlbGRN?=
 =?utf-8?B?U0ZBdXg2RzR5Ui9hOG9EcnprWTE0VGVXQXNZa2V1NlpwSm5MdG55RURxdVkz?=
 =?utf-8?B?VnI4YkxTc3JRa3NIQUVCbmtWWUJqZUt1NnZJNU80M1F2TXdsZmsxWCtDd0VP?=
 =?utf-8?B?WHNXMHk3a05MdVN4VDlNeGJVb0h3enExYVUyL0FrcW1HR1FDUXF3ZVpUQm0x?=
 =?utf-8?B?ZGh3ZldlM1lwcEFxRnVLbFpGOVhoa2tDVkI2d1lmYlo3WklUa1dTTXArRmFH?=
 =?utf-8?B?Qm5uTm5VdDlYMDM0bnN5N2hNekc1UXRKekJsQ2VHeGtyeEJZL2hVTjlVK0l0?=
 =?utf-8?B?L3ZOd1R6dDFXejhYTGdlTUVsSURQbzV5SHArSHB6aUl5WkVORlJNd2xNNFE0?=
 =?utf-8?B?UnI2WU9YQXhpK291NG11VVUzK0hyK1lxenhBR21Ya0tUYVVTZTZ2enNLaWVO?=
 =?utf-8?B?d3lGalArS1ptQnNxdGpzWC96L01aNUJ3dXZrM3hZVVIwWmh2c0pQUUh6bDAv?=
 =?utf-8?B?bVlEZ09qSnAySEpQTU9TZzZlaktEQXFMcmcyYUhGVlg0QU1tQjZjTHhoeFFy?=
 =?utf-8?B?TVMrS3F3Rm5vUzlMZEJBcGtHN25VdTJ1cVVRaU5WUlNRMWlOZy9HaDBIMDJK?=
 =?utf-8?B?SDdLUFE4WUxvUkVLdnliOVh5aUE3dEg1NFZSRUhlZ2Fwc3Vaa3FoOStaQW9i?=
 =?utf-8?B?U1hvdCtoWTgxcFBBUUhDN29sZzZrb0xEMWFqOVNwYUU0Vi94ZFFzRDdWZEdY?=
 =?utf-8?B?YURjT1F1NEliQnFwQi9GZTlHdzZGbUpzUEJ1YWZoUUNUN0ZMUGVtSDhJQ3Yx?=
 =?utf-8?B?SjlkZVRoc2tJcHErWW1xM2p6THhVMEFZOCs4ZmdNa1ZyVGFSZVVYZzlISVp4?=
 =?utf-8?B?ZFM2emtwNnVHa3FrRG9FbW9JSVRXa3BNQ1ovWW1PNnE5YUpwNWdFWExEb0Vl?=
 =?utf-8?B?bEtjMXdaeUhFcTZRL3JTV3hnSUZoRU45Q3hlRGZoS1NreW80bjIzTXd1MC9D?=
 =?utf-8?Q?CQbzc4U7XVKwIVx01ce6QLaBf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09e5bc3-9b5d-4866-a061-08dc41daf3b6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 14:53:02.8280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84UsCdTRDUedFksZzZ5YT5AlH8RODM87Iy1wzH/IO/q9ymHZuiWvagj66Kev9Ufk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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



On 3/11/24 15:39, Tom Rini wrote:
> On Mon, Mar 11, 2024 at 02:40:59PM +0530, Love Kumar wrote:
>> Hi,
>>
>> On 11/03/24 2:11 pm, Angelo Dureghello wrote:
>>> Hi,
>>>
>>> jfyi,
>>>
>>> reset support added in qemu
>>> merged as commit d3c79c3974.
>>>
>>> Regards,
>>> angelo
>>>
>> The other issue was with echo commands:
>> => echo $modeboot
>> $modeboot
>>
>> => echo $?
>> $?
>>
>> Does HUSH shell is enabled by default for this?
> 
> It is not, so at least the saveenv test needs to depend on HUSH_PARSER
> too.

Based on logs on this platform echo $? doesn't return any value.
There is any config for it which is not enabled for this platform.
Do you know which Kconfig symbol it is?

Depending on HUSH is likely big hammer but I was not able to find that exact
Kconfig symbol just for $?

thanks,
Michal

