Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0EFC5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 07:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D00C87D9B;
	Fri,  1 Mar 2024 08:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ONeB4QHR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D1D687D9C; Fri,  1 Mar 2024 08:42:28 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3164B87CE8
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 08:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xlt76vqS/ZVor9wCNR1vrE/XJppdSJVMxc04YYqnJZbKqVRlsVCsx1SclUHok2IwR+EW9rqulusdjexIA2xQZAdeuWSWy/4/v3VousBVFFYyzh7SVeP/vV9PHBRuiHRBX54gIcM9ZF/x7kj7SenbPLflNPvKvcrAzsygC6GibzqxiAOpfMXjqDZZxHCHh6+C+pbJ3CsNK9hcgfLPlc57BwzH0ScUBzSNBN7NFP2NLAw5UWUBfMVq2VMNhsyme7LUDgClL113LNC2z+lpLaCAMrcLXy1CSBGJHhbnr98heeVSuRLk2tFv8nJLx9oT68eIMeRlHueq/xfMUffRI3nd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YWqoD1ltRVqHDgXH3G9wcrnY6WictWfAWIfqG8u/Tc=;
 b=ezTjZpImyVBkQF+SwlS5DdOEYJNWDpHVI49AFYmgZwEQGiEdagRkju1d/WCdcfVsUuEjLecyQqfUMEAD+91CJG1WcdH5Bs8l7aUB+spm1Wkj6JKlDLS84CZsvlFbLyAFWaMDHD/tRYtj/5ECqr0uPAmWks4blTqW39spgbUxUODx6aQor5l6V7XAlaOCOirchZUDyqjRn36AiRwOHlAIyceEaoUuIzQHcQ1gdTQZy3YBzlRnUKwQ4DrU9EVDvzpdjzfrdVDxlTLM0C13J3AbtDWvIXS4TWXi9Mk1jIY5xpBihMjtgfpGfRRddp8NCHpqLZTN1rHKryVnURZtA5s+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YWqoD1ltRVqHDgXH3G9wcrnY6WictWfAWIfqG8u/Tc=;
 b=ONeB4QHRpkKgFN+YuQzvn41fVbdLCZKC0TadVFyz2XgCLPTKzQGQIxpz/xFnRCAkhHO6OpVEiIWyZ2rpTHnjyCpzsTsc01x/tHr1Jlb/6SwCZrRyvnTy0PWGeWJlnKil8c6e05xrW1c6FUD7+dPKNhlqQu137Wn7OUusJqFi1jM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 07:42:21 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7316.046; Fri, 1 Mar 2024
 07:42:21 +0000
Message-ID: <9a6739d2-2f71-4a80-8a94-f995a66650ed@amd.com>
Date: Fri, 1 Mar 2024 08:42:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] riscv: mbv: Enhance MB-V support with also enabling
 SPL
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Rick Chen <rick@andestech.com>, Shiji Yang <yangshiji66@outlook.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cover.1707911544.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1707911544.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::31) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 66851c44-1b73-4257-6cd7-08dc39c320c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FzEC9w4Wx6QYzd1Qc8yohwN1utrg4Sg77XUXko/IPKH/9RJmMzc9v9QgvzKa8n34wa4slV2m4Wnac5L4Dp7AwzL8B7XNPDZbaZWgu3wfC9+nsskUfbq71KfYDsx1Gwcvaoxa63TZzZj4j5fyyZoBB4Hm5ltgV2/+p5FpAdo7PnJjARsIMUdxEWOyUys0DJF5BNXuFuHmcqw9Od4kqYCfdtv/hJ0JXB28hUyqtKAULs6RCdV3FNjgDVbgwcr3gXhJoK6z7Pcut1wli6hYHpLJ1Cj/MzfCioso+cSTEsKUpkkxdaRJOHnozJ4oO2p15jjft29xXgj4idw/1Va5M3dwGX+KY7pEQvTl8ckUbxKo2kov8cFfqraBQDrM3jOmJOMQ1NkVnDpw0YqAqLy9pn7MO0cIZlYdUyx5yZBBNfS37mXPCVMKKF/bTYzvcGDF1q97KmXFvHMyvaBmHvxAPK1wQ+t/DflQJw0SVQVRjuALRtBQJx5geEjUj7/6F1lLCSwo+byL4uOoemUaohQsJdGuRVInNNLzDJK5vXSNP6cpIuXKkiC623u+YFeX0Lu+Eb6uk243JH4K6oH0yt6RVhSnomEimXvhlwy88J5bo/yO1hX2znVTta+AYILKeJTcC7n9xe5LUTbrExkUHI7ElpVNxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEdyVVQ4NndQT3VGVEhmY0luSnpCd0oraDlsNkxiaXhFK0d2Zk9aNDl0WFJo?=
 =?utf-8?B?MzZuWWZrb3F4ZmVuNHAvTnpNanRzME9GeTdvTUdXYis3bHMvalFKeFBIdUlB?=
 =?utf-8?B?TVZKK3BZV3lxZURqbDI2MWIrWkV5WlB2LzVKWlM4a2Z4OU9peXNaRVRLb2Rj?=
 =?utf-8?B?M0lsWXE4NHA4aEZuNnQxYlN6Ry9jbDVnZGZCUDBWTk9FRzNIN0FLSUx3M2JN?=
 =?utf-8?B?VHhlZGlxMmVZTHNSLy9hejF0M1FqRnBZUlNvS29GTlNqTVFScHAyanZMV2tX?=
 =?utf-8?B?V0VleTNyUTdZQmhEYTRUa2FTNHQvSEU2WElXRXRlMWM4eldHSk1WMTFKeENr?=
 =?utf-8?B?TEhtUEtvdlBLQlh5MHBmVjRBTjBEeGR4cjM1T1dpekMwREN6bHpWYzJ1cjF6?=
 =?utf-8?B?MlNCSzNETjFRSEFOSHZHdVM5Ulo1WXdZS0EwcndXRWQ0a21yOVBBdkVlVU9v?=
 =?utf-8?B?aUZnQ2kraFAzSWtwTTQrSytabThpVnhBNThDY1lDZEVIM1NhS2FLSTU0cmQy?=
 =?utf-8?B?alpkOXloQjJwbk5XWmEwUC9jUW5lNEZSTEtqNUpPaFA4L2lqN1Q3b1I3b04x?=
 =?utf-8?B?VFB3OEp4eXZRaTFjK2JZWUUwenJQeUg5OWxGRERKcFFCVkxjdDY1VGViYVJ3?=
 =?utf-8?B?WXE0N21iVEM3U1JXeThIdTVtRGErMkJOSkV4NkZyOXhKUFF4SmJMbmw2NmJS?=
 =?utf-8?B?SUQzOXZ6MlRRWVB1QUpFaHl2QTF5Y1kyUllORE1zQWJmT3hhNEpWZFV1Tmky?=
 =?utf-8?B?bUxUMDJYUEx5RVF6em5RSkovTXhpcTE1UFc4WWRKNC8vVjUzQlZXMlBGNTR4?=
 =?utf-8?B?aTZqNjFJQ3JtMXJJak9PUGl0RHFzY3VoSG9JSDI2QVZodW1OWkUvVms4OEpq?=
 =?utf-8?B?N2cxK013Y2h1U3VoWXpjWk1vclFEY3A1OWFzcVZvK1A5azVacHAxVXJpVXd2?=
 =?utf-8?B?SlNnVnFkVmVmSXRTbkJieTNmT1YvSlBZUWhUUjRadmhGZVd5cFgxWU1NRnls?=
 =?utf-8?B?c05tS2JBbFZmSXhoNGZscEhmakxDV0kyUFZhL0pMTWFGeS9Wd2xSekFMbnN3?=
 =?utf-8?B?RlpQUXFnUVFSWStjZDJmem9oU05hUm1kR3N5T21RZ3hwQmc2bVRDbXZXN3Q3?=
 =?utf-8?B?NmMrL3h0Zm9vWk84TEVud2xvM3pPaXFNUDVJTzdGSzlVQzdQMVVqSVRtMWpx?=
 =?utf-8?B?SU9rOHFGYnBNUmFpbXRhOUkzZkpJT09RbzRSLzNnQ1hSdDNMV3ltUmpudTZB?=
 =?utf-8?B?S2pMeUVNZWxXdVNaaXdZK2I5S2k0MDFhUjkzMGE0QWlZUVVQYzJwWUREbVBt?=
 =?utf-8?B?WklZUytETjdrRURmeHcvS0VIdDhmTFB1dVFYNldabktmVUU0OWcxYjhKc2Fj?=
 =?utf-8?B?SEw2byt2ZXNWbWlWWmx6OEQvZkZpSnE2Rk5BWjcyTzYwVFVoKytpOXBFN210?=
 =?utf-8?B?VGhBa01yUjJhVDY5RGlEOWF0RzVBQ2xGSHlyaCt2MmN2OWIxZzN4bEJuYzdu?=
 =?utf-8?B?ektoQ1BQNDA5cXJ6ZXZmVWVWVW1sZU9ENHdGTUZlOEo5NGZmRTNwZlVnRDlS?=
 =?utf-8?B?UnZocEd1WGV4V0RQWkNibCs5djZ4RHlhbE5zd3ZHOU8xa3F0elVtOFQzaDRX?=
 =?utf-8?B?b1FvUU1nYTZDZVRrYTdkQzJEZkdzWW5aSU5kUUNPbXp1ZWI4SkRwN1F2WURW?=
 =?utf-8?B?Q3VGTUNtNVdjQkVXS2JlTEZsRmR2ZnROZVdPRGNoZk4yaUtCUVFvK0dZKzEw?=
 =?utf-8?B?L2xYbjErOVc3KzkzSnRlSkxDck5EWW5GbG5iWkFWS3lzeS9TWTBNL0pWaWQ4?=
 =?utf-8?B?OVRIU2JCeHZnM2N6cGVFTVpFNjFRdDlwQWdqeHV3RG1YSFFpK3lHR1hKTU51?=
 =?utf-8?B?dzFXY0ZrN2lSallycms2YmI5L0ZVWXVuamx3bDhJZ0EyaGZwT3lXZlJuRng3?=
 =?utf-8?B?NEg3WHc1TXlVVnNMSTdpTmFFYklPRmhJOFRjRXhGcHd6b3h0KzBTRFdwNVFn?=
 =?utf-8?B?SGJzVFJFck1BcER6QVQxeUVrUVdmYXYxaW9pYVFvTU9Gc1hqai9YMlovZjlu?=
 =?utf-8?B?TGhNS3F6eGllUnh2eFdkSGY1UTJCSi9DekdKdUJ2NEJMZ0ZGRlkzK3laajNM?=
 =?utf-8?Q?AVDEc1RawVbKJOL++cHnpaE7c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66851c44-1b73-4257-6cd7-08dc39c320c2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 07:42:21.4149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sylye9AKVZbNfrYdcEXLYRkQFzmsf2IL/y/7oDxd3tKPB62e8tXwlFd5x5msmgXw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
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



On 2/14/24 12:52, Michal Simek wrote:
> Hi,
> 
> enhance MB-V support with SPL configuration to support OpenSBI.
> All of that changes are out of generic Risc-V support that's why happy to
> take it via my tree. Please let me know if you want this to take via riscv
> subtree.

Applied via my xilinx tree.

Thanks,
Michal
