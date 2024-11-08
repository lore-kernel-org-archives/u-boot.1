Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E7FD5C0C0
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 12:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A729D88DF1;
	Fri,  8 Nov 2024 13:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cfN/T/I6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6740989083; Fri,  8 Nov 2024 13:41:32 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D8088B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 13:41:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cfoowu2onOOW+OOiFl5NmT2TrdWRhWUhofDJu7Z62AUhgo92AqEp9OF+rRLtG5O/25OeHjLhoZpyvUjjgGARxW455vDtLSSnx1odww2RQn8g2pm/1JoD72fqvcpXHhkzEsH1C9erBillKFu3incj0ySUDw5ju6cSiyAV3S13nZs2d5bMda/Ud/+FuIZ+vmA/POwDeYkhDG24TKPWDv5wkWILoOrsbnNjLj0A3QyjZq0uSlaBvaGseMrBaYuEItUhPmMFbKpvkP1xfAyE4e3/7kH/6bfrLwVXup5aR5NetmMZwezW4IW4QgZ/B76AgG3BdxnwtYUcHO5dd36lw9KT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9twpSL5mctX8b0LkUsOWbnFIZSF4P0P3xz522C4U9Q=;
 b=uewN/I7q01KMvu9L9q0DgIwWI5awDuAxYogeeBGj9ukoKaKyxKIZwRdu8MI/1xQLrZcEtmWO4po6Q1+D7EiMpr4Nfi19wQGWuATO589zb00v1MveZTOv7GjLu6uoB5nlGfhbM5Q6A5mKW+SuwnY+4BeQdC9k9JgzgXoR9PIV6Ry1AWnOtw+Le9OS/YEF+LhjKovI56ufPQJWIL1m5sZVzOwxS/xYwXtPtYZskTWYq9TgkzReSd6Zb7NiIphoUffm/iqIFGdvSJKArB2N8tZmXISyhpDJ9yDSVpzZKdkH1I8hLAgcWRR8+peCjD96aTov0cfMvmxmQrd5Fxwric+5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9twpSL5mctX8b0LkUsOWbnFIZSF4P0P3xz522C4U9Q=;
 b=cfN/T/I6gZ6IgtpLgxO5zNtCP8Mbs7EL/e8N+OQD+L98tfkgIs2x9Hgh3+N+Xw/9iqhIkJzmPCl2tXNqmjt4qiYOlMws7geRpGgiDjM7bTASGYTonpcRZntFCkdKErQxswx+x5LwrJuaTrcqELvVNLMEYVHeR+MNwFl1dMFmuu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 12:41:25 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 12:41:24 +0000
Message-ID: <4c05d240-ab4d-4f44-b036-380151e1478c@amd.com>
Date: Fri, 8 Nov 2024 13:41:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] boot/image-board.c: boot_get_fpga(): pass compatible
 flag to fpga_load()
To: Peter Korsgaard <peter@korsgaard.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
References: <20241105162136.839633-1-peter@korsgaard.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241105162136.839633-1-peter@korsgaard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 471e4d0e-2ba9-418b-1113-08dcfff2a822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFlFQ0tvWldVQm9WT09ET0M3K1IyeXdUaW4yRHF0dnNEZ2N0M2ZQemRnTXUr?=
 =?utf-8?B?Ri9oV093aHVmSjRFWFNkZEVpTGZ5K0R6MVgzSGtuSGdWVDk0NFpwR2ZCYytW?=
 =?utf-8?B?MXVvMTlHeDYvMkl0ajhEMUlWbmVuUmpwUHNqU3g4Uk1rM1lFeFB5RDM4VCtn?=
 =?utf-8?B?VUpDeHlYVDRrNkRVcjNOancxR0VKb2xNMjdxektYVjVLZFIzZTUzVnNldkQz?=
 =?utf-8?B?T2tTM3o2VllxZ2lrN2Z2RndWdGtlTTlxclBwVS8vb3BmVXc5N0NpMGd3ZGg2?=
 =?utf-8?B?OC9WYmwxL1E1TFR4azgwQmRYRU00VGRmUWZ2YUtkWUdmUEc2bDVWQ3BOT0wx?=
 =?utf-8?B?UHVoODcvOEx4elhxTU8yNTJuSFczeTZrWVg5eWhSeGpMQ2JkOWJnQTVGbWpq?=
 =?utf-8?B?bFBkTWpiWHk1Tzh1RHEwRi9VZGw4NTB3RHVXS3JKWmwxTzVHbUR4dU5pMkR0?=
 =?utf-8?B?SVo5SVVQZy93Ny9PTWcvWnAyV3JhcG1Xcm5obHUwWU5HNDRORlFqdjQzZ053?=
 =?utf-8?B?TFJUeG5LRVFlRFVrbytDajZuTDJveTRIVkFLWlhQK243ZlRDQWFFSHNGbUVq?=
 =?utf-8?B?SFg3eG02OUxHMDVUQkNSUlRHc2NqZTF3cVhWaWwwRkVkM3AzcUtMYXFmYlBj?=
 =?utf-8?B?bC94WWxRVW9NSlFZaDVhaTJ5K1g3NnB0Qzk5UjVjMHF5L25CcU10cG5Vekp3?=
 =?utf-8?B?YjRUZFQ1NlRhWUJ5UTBhY2o2a2lFd0JYQi92bGZrQllTaW1Gd2M4R3ZEbXdM?=
 =?utf-8?B?anNhVVhCdVUwR2haRnJEeW1IdlpjK2VSb05WbTdxTkJUSStUNEFVazRTQXdl?=
 =?utf-8?B?cFJkUGdhcExWVEcvbnYzODROcDUvRVVZQk1Xak5YNndUM0dTUUFjdVltYkZO?=
 =?utf-8?B?NTJ5TTdyZk9wRWV6ZVI5cGF5OWNzMi9ubkVIc0h2SzAvWCtLNElyNmdPNjZz?=
 =?utf-8?B?UzBhczF5SFhHelhHYy9QMnEzOWU1TDJWMmd4aVJPMTNLankvRVM2WWZxNUNJ?=
 =?utf-8?B?aWNLTCtDMWQwVXBlRWgzTDhUdUZpOFhRdVRvbkRCQ09KbnZPU2pBcDNEYkFX?=
 =?utf-8?B?c2YwZ1o1UlJ3dmpwSytQUkxnVjdYSWlDMUJ6R0IvSTVQT3ZPUWVkZXRrN3Va?=
 =?utf-8?B?TCtabFpDeVpvSVRvRERpM25tallBOHpDTEFUanJrYStZSml3Um9aVWk4QUE4?=
 =?utf-8?B?TjhUcXdTakJBWk5GaVE5MHlWck53S0pubHM1QTFxWGovMlphOGNsejEvUVBV?=
 =?utf-8?B?cGdXaElYOWlIUEdFTEliZ1k5REhxdjgzQTRncjhBWXdBWWt5RG5HTlVyV1Yy?=
 =?utf-8?B?SUh0dWRTNndmWk8wd2YrUFVtRkIwOHA0bDJoWXZlYWZnbVhVVmhiSG4wTk5v?=
 =?utf-8?B?YUlGRjdBOU5NdHFDR3p4L3gyc2Z0a0p2YUwwM3R4eEJYZ1hyTFEwZTJUUnZR?=
 =?utf-8?B?a1VFWWFIYS82dDZRRlAwRjFubWhBZGpTUmd0dys3MjA0bTlCWHRrZWh0bS9r?=
 =?utf-8?B?VlVJNlByempGMlVlVElqYXd2cHgvUlA2VGl1VWJHeFlkUkRHWUxoN3ppYmhz?=
 =?utf-8?B?SzVlZlNoK0NTN0VJc21ZWWU5K2k3aUZZQncyLzVLVFFVN2U1Z1VwVEF4WXdT?=
 =?utf-8?B?bEdjLzYreHZxRVpnaVhFVE1UVlJHdWVSZ0tCQy9xNUFRRHYwbkcxM1hZYlhI?=
 =?utf-8?B?UTNsd0JkZ0tDR2xHUENIWHc0Znc5MXlydXd2c0VpYnV1dzNaT3lONDVDWGxF?=
 =?utf-8?Q?dRER42yPMs+piIxCCbIMNGP3aduSYbRvUu4Q57R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzIwLzIxQ0N4SWl6QzFZVG13QUZMTENRZ0pmc0o1RDJRRXFzbExWTE0zTmhS?=
 =?utf-8?B?RWpJZHdPcUlzbGpRMHRwOWc1c0ZIdm1jRTRRcXRkU2h5NnA4RTlnUnY0NDJv?=
 =?utf-8?B?TUZ1Uy9ncFJ6SjUxTEFnNEZWUHpsWW0xeGl3Um1PVlJsL2R2NEZmWEFwRVNv?=
 =?utf-8?B?cnFTcnBrZjkwZWRmcEx5WmRmYmdwWFNaS1lQd3ZBOXB6Q05aM0orbjJTK2Z4?=
 =?utf-8?B?OFJDSy9wcjY5emo2QjdzRHp1UmkvbEFGUThvcGc3ZEQ5bUxNVzJreGVSYk14?=
 =?utf-8?B?NVhwWTNsRDh6L3JxN2l3bDVhTjJJZTZDNU56ZUpIbEFFTlZxZFhEWHg0MFZj?=
 =?utf-8?B?Z0VxR0JGQXVUYlFnbFRNY0h1L3JIWGhKZmV0cllqM0oxVTF0TGNXYU1TRmlL?=
 =?utf-8?B?RU01M1JLQ0ljZk55MmJadDdkaGFUcmNXOENoM3YxcXNLa0IwZHpvRVkwZTRY?=
 =?utf-8?B?ZHdIbEo1SUU4VEVqVjNiTko1eit0ekYyQlhIczJ1SllkSDh5WDhLZms2cUEz?=
 =?utf-8?B?d25EeWx3THB3MUk4Z0xzMzYxNkl3YW1mb082VkVvWnVhb0JOaU9YSXpUQS9B?=
 =?utf-8?B?Q0ROYitjbHZDQ3B6SE56bEE2aEk1cy9Vb2ZCcExFVXgwYUVTTW0zVlEzaWR2?=
 =?utf-8?B?R0FKMWZaVzYrckIrMUZHS1lLWHpRTS9pc0tQbXNadGRXSXhJcDdhNXRYd3FY?=
 =?utf-8?B?UlVxSjk2Y1BMUjhya1QrdUw4aWUxbWhtL1lkWm5Gd2ZvelY2M2ZqUTFYdVlZ?=
 =?utf-8?B?T0ROZWxZUmVxUXhkWlhRZzNWR09uelVvL0lUbm04Q2ZBOTNSNUlaUGpvcVRM?=
 =?utf-8?B?ZlBZNDRmQmh1cmQ4ZVgwWEo2NnhYL2hCbFpWWEx1WEFNYk9wUXB4VCtoTVJ3?=
 =?utf-8?B?dnNKaHBsd1owTWFwd1lZSEFuL0dwRzFYbmhBK05tYUR6QW0wTW1lYkorU1Fl?=
 =?utf-8?B?TktWaUo1TDlDNkRDRGlUMFdoUiszeW12Q1RaaVVPVmZNemVGdUEyZ3p6Smta?=
 =?utf-8?B?MFZyUDZleHNhdWduRkNSL25uait3dTNRaUlrZmkyeU9lNjFuUC9BeTRzUTdL?=
 =?utf-8?B?SkIwMXdNaFNmVXRUazhXZFd1ZWc5VGxzQVRFSzZHL1BtL1IvWnJpdEFIL3Zn?=
 =?utf-8?B?emREV0FNSWNrRkl1M1JGNmhuZ2RtUVZPVTI5Y2xxNVg3ZllOdlJRanRudjZz?=
 =?utf-8?B?T1FXbElZaFIvM2ZOOWZlWldUUWNiWDV4RG0zYW9XaGFHTDhnQytBcmNKdnJY?=
 =?utf-8?B?SlVtc2Y2RURZaVVpUFV0bHNQZkhJV2xqQm5WS1B2dGdmQ2ZDZ3FqUjdFTzZj?=
 =?utf-8?B?a3huSGVqZnJUQ0JxN1Q0UWNmNGVTVDUvdFFoRmEzeWFmdVlUdlRxQyt1M1dC?=
 =?utf-8?B?WWZ3T0pSczljaDBTTlJsa2ozc3lpQlN2Y2VjL1YrUnJjQ21mTXFwclVBeWlJ?=
 =?utf-8?B?Sy9KcHFSWUV3eWRhMnBxUERxMzdmUjhma1VYWUdPQzQwK2VwMW1lcDc1TmVB?=
 =?utf-8?B?K01hU2lLaU5NcUtPd2s4WlpWbmVZSTBWT0c1U0lQd1JKZ2RTT2x4VlVNeE91?=
 =?utf-8?B?czVLa3cyT0JTNjBqc05WZlYzZWtnRm5iM0xraVVXT3hrcU1iaTd1blhMYkJQ?=
 =?utf-8?B?SVdHbHpLTzVRUXNROEhJU1BwVlN3R2ZCaGg4ZnpIU2NkZEwzSmEzdFEvM3Jr?=
 =?utf-8?B?d3YxTXRpNDljckZ6eittMjY2cGdJWmdhWXR1ejRKT3hsWkhPRW5sL012QjNa?=
 =?utf-8?B?WFJDSDZiYzY5Q1lXRmM2R05JaG1haGdsQU5NcWx1eHUzOGZPRkN3RnN5QVA0?=
 =?utf-8?B?cHRWUW1zU2R1RXdFVHo2TXNHcERmZGFmenFxS3hZZFhCWHBDLzZxemJKZytq?=
 =?utf-8?B?MDNwbTdMMGl1Nm1ZeHBqK3ZxcGlhc0o0K0U0Mk55djg4UC80ZEZEM3VuSXpN?=
 =?utf-8?B?MmNGWkY4M0hmWjdUQjZiVmpKcTNLd2lWZXo3VzJiSTNyeVZOVkJWMmh4c3dt?=
 =?utf-8?B?Q05HelBlbStLN0d3YVY5NWRrYks1eElibTVVRGttMTJoc0I5UzA2TWI0RjFS?=
 =?utf-8?B?Z0xZbmF4OE0yLzVpYmUxajVQSGQ1dGRydkkybDRSUlI3WFFpYWJ2VUJ3NFgz?=
 =?utf-8?Q?HzBKP2NOR/2glTfYh81l0yqyI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471e4d0e-2ba9-418b-1113-08dcfff2a822
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 12:41:24.8830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPmjS+dr+pyvEaaRMxmtfPeatznAGq6DRaCYN6u9YmeNeclb3jctbeR5dIreOGA+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
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



On 11/5/24 17:21, Peter Korsgaard wrote:
> For E.G. signed FPGA bitstreams, similar to how it is done for the FPGA
> loading from SPL since commit 71f1a5392aad ("spl: fit: pass real compatible
> flags to fpga_load()").
> 
> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
> ---
> Changes since v1:
> - Reference correct SPL commit
> 
>   boot/image-board.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/boot/image-board.c b/boot/image-board.c
> index 1757e5816d8..b726bd6b303 100644
> --- a/boot/image-board.c
> +++ b/boot/image-board.c
> @@ -624,9 +624,10 @@ int boot_get_fpga(struct bootm_headers *images)
>   	void *buf;
>   	int conf_noffset;
>   	int fit_img_result;
> -	const char *uname, *name;
> +	const char *uname, *name, *compatible;
>   	int err;
>   	int devnum = 0; /* TODO support multi fpga platforms */
> +	int flags = 0;
>   
>   	if (!IS_ENABLED(CONFIG_FPGA))
>   		return -ENOSYS;
> @@ -674,20 +675,29 @@ int boot_get_fpga(struct bootm_headers *images)
>   			return fit_img_result;
>   		}
>   
> +		conf_noffset = fit_image_get_node(buf, uname);
> +		compatible = fdt_getprop(buf, conf_noffset, "compatible", NULL);
> +		if (!compatible) {
> +			printf("'fpga' image without 'compatible' property\n");
> +		} else {
> +			if (CONFIG_IS_ENABLED(FPGA_LOAD_SECURE))
> +				flags = fpga_compatible2flag(devnum, compatible);
> +		}
> +
>   		if (!fpga_is_partial_data(devnum, img_len)) {
>   			name = "full";
>   			err = fpga_loadbitstream(devnum, (char *)img_data,
>   						 img_len, BIT_FULL);
>   			if (err)
>   				err = fpga_load(devnum, (const void *)img_data,
> -						img_len, BIT_FULL, 0);
> +						img_len, BIT_FULL, flags);
>   		} else {
>   			name = "partial";
>   			err = fpga_loadbitstream(devnum, (char *)img_data,
>   						 img_len, BIT_PARTIAL);
>   			if (err)
>   				err = fpga_load(devnum, (const void *)img_data,
> -						img_len, BIT_PARTIAL, 0);
> +						img_len, BIT_PARTIAL, flags);
>   		}
>   
>   		if (err)

Applied.
M
