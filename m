Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D538C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 09:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 510D4888C4;
	Mon, 29 Apr 2024 11:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B9iksByC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89F9883330; Mon, 29 Apr 2024 11:00:10 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E07B8894E
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 11:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6U0nmJP3HLllr9KAOW/HM+whkMSZaMwqvl04pul3FPlnUf8CumvLlLfrX3c/6bWkzHZ5xRoY6tIPCCDjo7cNqGjgmABlDe1LV/tW85Kx3nwB0CFOUn1Gf16pfMsvWb2+segRRKkvm6MX0tcOzBjfkw6EhY+9xDsNTROnsHOYE1zFObhV3meZ2PC12lGcrbNFL1Bs/IvYb9a84+oRmPxIwaGyXL2wQVbNw0NkqmWNqd05SzhT7yxIpO8pNcfjJbMzV4qAFB4Ls3fDcjCIl5gE/KjESJECETA+jI0QvZgtHIDM6r4JZLdJUR+GrxscrqRApWMLwk/nBuF5G3dFey5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQGiwM0mA7OlryqX/MrvOSc5eKx/GFtvz6ZGsQ66GL4=;
 b=LuabMmAMWQzBekTnaGg7mpKPR5VFohVhYIs1P/+TmwwOn1lKhRUAqHD3Ip/v+kLkTKf9qi0ZxH5O2+BeZPqCmQH2U8WZn7JePjguxGA1Luym1TK2QoLz7W9yu8phlH20qnGNwU6lgGTuwn6IVmMgE1cWO87/ON36f9hVoLv3iUff7rvnSYLKUqXPcqqGK1oOxdIw9oWvrdc4wXAVMNo52/j/JtKFMvQccHNP2r+KqeEButdHV0rqJU5Ya7KRN3anBhiwNuApw3FQ/WP3r/4d5YOUCR0hlwTTOg/ZKHPU1vqCK9YiVg2aL5xQg4xgfvrexBXnVHRziPaK5dndLONkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQGiwM0mA7OlryqX/MrvOSc5eKx/GFtvz6ZGsQ66GL4=;
 b=B9iksByC7cVFP6TDCF+iX3PFZDlIDIGv3S5aXBYfzYjt36C+UquZYdTR1P8VMuDiPyxndrsniS9RiHjwDlM1RD+5eMtWlvp06runrn6J/Al02Y4JOc8HEmJ69PEnrdz55lM/nVoYpOSw2inVNcwXv8sgT0L2V0JVG/0y04VAoS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB7411.namprd12.prod.outlook.com (2603:10b6:806:2b1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 09:00:00 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 09:00:00 +0000
Message-ID: <492a3ad7-87ad-4068-95dc-4637a8525f92@amd.com>
Date: Mon, 29 Apr 2024 10:59:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: zynq: Fix EMIO clock use detection for gem0
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Igor Prusov <ivprusov@sberdevices.ru>
References: <20240416084456.2821567-1-megi@xff.cz>
 <ca63cfb0-5e5f-4522-8cda-87dec22588c9@amd.com>
 <5gv2fqik5vtygldqmv23tpcsyaftazblm4atk3igweduivmiqu@aeoflxwzlvx3>
 <9a5501c1-359d-4e5c-a25e-7c1631451af5@amd.com>
 <ue225zvgzd4zg5u45uvdatgsevkqau4udfpythlncczwv62znz@fdk2lhm6rdhw>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ue225zvgzd4zg5u45uvdatgsevkqau4udfpythlncczwv62znz@fdk2lhm6rdhw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0070.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: aacadfcf-93ef-4daf-1a15-08dc682abffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWRwTUY2L3hqTGxOeEhjbTNQV2x4bTdEL3AyZGFhZzhWVFlGTFlDSW04OVNy?=
 =?utf-8?B?ZjdIOWUvd3p1RlczNTNMUXk0RndmczRrRmhRL2tLT1F6L01ZdERxb2JHRU82?=
 =?utf-8?B?cWYycDZhNDJDYWNIaUMrZkVRNXNqT0o4cHkzT0p5cU5QTTI0RU5kV0g1VDlo?=
 =?utf-8?B?WUhNRlpoU3dlczVhQktXWUY3T0tZYWlzUHRNWm53Q2hXclMxRXl3MTJGNWxG?=
 =?utf-8?B?MWRxNnVVY25laEhqQzl4aTRHV1ZQcHBxdXdqbjJTOFJoNnJvREdFUG5xWnNS?=
 =?utf-8?B?YmJTWUh2cXRjSmFUbkRMYjhlZ2Q1ZXVRcjNpQi9xaWpmZ0xyZUJieTYzVkI0?=
 =?utf-8?B?NCtRQlRqblJHNGFYWkszbjd4YmpRTkk4aWY1KzQwM29iM3dJYnV5eXVnWHZO?=
 =?utf-8?B?NzR5Y1lXRmY4dzBzaXpRZzFrckRyQnF5Q3FmZU4va2VkNlpmYVVrdnBCZ2Rq?=
 =?utf-8?B?NmhPSktxR3ZTZnJuaWMrUkgvTkxETG91ZkRENW11ZVJHL1dZQ1ZEc1Y2UUl5?=
 =?utf-8?B?eTdvcm9JMFg0QnlyakRFNmhkVTUxWUdmSHJ5Q3EyTFhnY0MrTmEyT093c2tQ?=
 =?utf-8?B?dFU5WkJlYlNnbi91d1hIOGpUM2t3a240R0lnV2hlYW5oajNZeWUyUC9xTDl0?=
 =?utf-8?B?YWlzZXVqMU0xYkQ0T3c2aDBjNjF2cFQ4YUNFV2VGQ0d1bzNXZ2MyWjZDU0xo?=
 =?utf-8?B?eEk2dC96V2NpRzNuUnBDWm1NMUM3Y0pRVmlqenlDdmFESVBGbk9IQUkwYWIz?=
 =?utf-8?B?VlJYNzRhTG9SeGMxRjBNVDRhQm1TQkRXaVVycmd5YUxoWXdHdTk4MERaNWwz?=
 =?utf-8?B?L3FZek14c3RmWDVhM1Z6Y24vZUNjMGw3VXcyMFM3cEFMQ015YWRtT2ZaUzFj?=
 =?utf-8?B?aTZSS1h1eWxKT2dmSCtRWlpEK3dEZDRBMTJBSEJwZG5Xc1ZEcHJoTHR2VDI5?=
 =?utf-8?B?YkpKR2w0UVZuajlGN0xWY0x3TWtDTkVYQnUwdU5tZWJNOWRLTFBqQWh3aVlv?=
 =?utf-8?B?OTlkeDJMUWV0QmpkcmRYRnFiRGpOZkR1SlFScWdLbWhVeEJJbjJwVzQ2YlFM?=
 =?utf-8?B?ZGNmbXVCWnRFUUVqWG9RZVN3MHFlTDRXUDVCUEt1ajQydDRlU20ySUZjTGhx?=
 =?utf-8?B?TDRxenlob3A2NUF4UWFOMzJDcXZaUmJUYUg0UVFqdWM1K1lvWDN4SER6VC96?=
 =?utf-8?B?L0VXMkIwdi9QdVZxNmtad1NZdUp3SWU0TWkxUEM3bHFsQVdMUXdPc3FNdHcx?=
 =?utf-8?B?NkdWZTZuYVNtWGl3UTY0RGx5SlVlTC8veDlXeG90WmtuT2pUamFESWlqTjhv?=
 =?utf-8?B?Skk3QUZYbThETEt5bUtKUnBXTDYweURMT05vQ0dTVWZjbVZqWW9lbHpsOEg4?=
 =?utf-8?B?ZWF6YS9jcTRaK2xQR01iRGFqZ211MGRqdTdaUWt5MVdtRzRrMEZVdGFoa0E4?=
 =?utf-8?B?cGlKTFk0YkprcUtFVCtlU1ZFZ2tkaVFOU3hQK3o0MFVtRGQ0T05ISkFiTlVm?=
 =?utf-8?B?ZEpXMFB1MzZSM3dJTitucnV1cGc3TExwT29LT0NJbW5sVTBYVW1ybHRHeWEw?=
 =?utf-8?B?SFJwUmNkYUxGVHptSjZsVGUvbUlEMENVMS8xQVJpaE0xZEY0dlFESmRCbUN1?=
 =?utf-8?Q?TGDzy3hdn5fHqTzU62GMEV7I7vlclLNgiLI1ngL0rJFo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2E1dUo2QVhGRXBQUkE4WUh6ZkEvOVVIOFRpMDFaSUs0Y0tncGFqZG9iTUNy?=
 =?utf-8?B?MnpPaXA5dDcxRjlwNDNhYnBDUHdmQ20vajJSa3lIZ2hFcCsrcUpuT09MNGIw?=
 =?utf-8?B?MElMeE52R0hRRmc4R0cvUnlOZE9CaCtnYXdlbFVZZDhoVGJVQzNrTW9zOVVa?=
 =?utf-8?B?Vlk0ZU1maEVGQVNKVXNuUEp0VDIyU0o5Z2tNODFwSytqYXVyckxrNmVYM3lW?=
 =?utf-8?B?b0tOSnU3V2Q4MDJZV0d5ekpjU3liRFpOVXdvamtTZ2NqVGZSRWNGRDIvMzVo?=
 =?utf-8?B?TTN4dDBZRnFOQnAwdzVDbXVzckQ1NlRvZURKNXk0dW9PeTJqN0hyMndqVjNK?=
 =?utf-8?B?TEVPV0p5WStWOUhLcXNXWFJSY2V2VGloOXdLdVN6MW1zS09DZHh0UzFCbDJZ?=
 =?utf-8?B?YTRSMG9JTnI3VXF5OFpiTXJLVFB2Y1EycWFYMkY4bnFVK1EvT1ZORjlkM3lk?=
 =?utf-8?B?eGV0TTI4d2JyaWhFSDRLTm91b1VwQTVLNXQ0ZmErTFM0QlpvT0tQbXF5eXht?=
 =?utf-8?B?QXc1Sm1vb2ZpQXJkTmlqb3dCejJST3craTI1U0I3RFR6NXZEQXdDb29QNTIv?=
 =?utf-8?B?UWN5NEFnWUFXcUpxaHhUaHRxOXJtOE9kLzc2T1BUOHc0Z05pMFRVVCsyRjlG?=
 =?utf-8?B?M0tuV0NsaTFiVkh2NGx4bXBreVF4SHhVcHgrTTQ2V0hieHUwekVLcGlIcTJT?=
 =?utf-8?B?TVVjNmFFT3Z6bVo2VlFaTnFUTitDSHNrYU1ucWtGZmJOMFQvNm54Y2w0Q0NS?=
 =?utf-8?B?MDNHOFZIVTdhd3lhdStoUVB5b1FraVduSTAzL0xuYzVYaTI3ZXFPeVJLWHFa?=
 =?utf-8?B?emJFZkJyWGpselFVZ3RKTDVtMUpHSGNvbGZhZVNQbFdNOUhweElKWFB1YWZj?=
 =?utf-8?B?aU1sd0NQSTRnQWJyODdtbUVDdEtrdkZnQm9FempGSVVOZG9mSEpPK2QvdjdS?=
 =?utf-8?B?M3pxanR2UHpoNnRaU0toMm42QTJwT0lvT0tGZ2NJWnRzRkdjUUF5WnZicXFW?=
 =?utf-8?B?MUxQeTc2SEcvMHREQzhWcGp4a1FBOUhMZWtuMUh1K3NwVFI2bmxxZWlUTlZw?=
 =?utf-8?B?ZktBOTdRZEQ1S2ZFZFlFNnpqdklDaTgySTYvMzUxeGpJbXRLWit3SXVCT3cv?=
 =?utf-8?B?Q1BUa1VkdnU3enFBS21YaDRROGJqWFgxM1NQVnp1NmxWa2U3Y3JDVVRoSWZU?=
 =?utf-8?B?aGJwbTNqRDFZNHNBNmNReHpUWmljM3dPa0szNzMxdnB2K3YzR1VNSkpadGJC?=
 =?utf-8?B?NUJKMFl1aUpjTHVBNFI2RnMyelF5Vm5ERXRjSG1UM0NjOGdESWVpVHRBekdR?=
 =?utf-8?B?bFo0QzM3dzRjRHg3MEtBN0FDWFhNWWllQ3BPZVNDZ0hPSWZ6YTJUN09mNCtw?=
 =?utf-8?B?L0pnTnkyQ24zOEtVRmcwSHk1WVpJdW5WTlB6QVFKOG9scUN0cmMxSmg1aVg1?=
 =?utf-8?B?emhQcmJ2V0FIRjFDVVVha200KzZPMDUyUVhkSit2ekVPVVNUMjdqYTdqd0Vq?=
 =?utf-8?B?WjRaWi9GY2hmTTlTZVVpNG1Mc2MvSENZKzM4aFZSTno0Mk0wZ2lQWFNpLzFG?=
 =?utf-8?B?d01ER3lkK1NMbzlPTklGNEFCNmtXN1VJZWdXYy9KcDczenVrdm1jWlhzZ0kv?=
 =?utf-8?B?YnVhZlY1YmZpdG9jUzRBNFlJSjhvTkJuQ04xYkFBUDAramdoeW00V0lRQi9m?=
 =?utf-8?B?aXZmU0hybVFhL3RnamtZTHgyVENrSEQ3MDI3em12blg0dFRZdElnRElqWk53?=
 =?utf-8?B?VkhKWGtjVUtqOHNUUlN1Y1FlYWpHVGY4bXVvSndWb1JFTndCVmZvYTh3eFNy?=
 =?utf-8?B?WUFsS1F6Sjg0WGZmMHMvajBoczZHNldiOXl4eENzUk53c0o0YmlBZU42c2Ey?=
 =?utf-8?B?UkZnTTJMR2MrSW5aaDF6ZUhjZVVyODUzanF4UW9ZNGlRdmJvNXphaHBGUFd6?=
 =?utf-8?B?WGljV3VLaUVoQ01WaFZ0M3B1K2wwVlA4bTZqaTZHZyt3c1liVVRiN09Vc3Bp?=
 =?utf-8?B?MDhxc3pZWElYVnNYbWltU0FUNDVTbVlhY1lMT2U3UDB5WTdmaGlVcjR0ZldT?=
 =?utf-8?B?eGFneFF5S2hSRlhJbGtGVFdDYnZqZ2Z1T01yN05zSEo4SlZ3bXliZlphYmJx?=
 =?utf-8?Q?u5nGY5iKTLSv6cZF7LHjrvmq8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacadfcf-93ef-4daf-1a15-08dc682abffe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 09:00:00.1264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faSRHM6SqGdAkgrHsOlzRfRgO1ePy/BOcg5KNUScrcabrlLINu9qu/TLpA9Jdbzq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7411
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



On 4/25/24 17:18, Ondřej Jirman wrote:
> On Thu, Apr 25, 2024 at 12:59:29PM GMT, Michal Simek wrote:
>>> Well, it doesn't help that the code is almost all refering to CLK_CTRL while
>>> actually accessing gem1_rclk_ctrl in the struct.
>>>
>>> In any case it can't detect the case when sourcing the clock from EMIO and
>>> not one of the PLLs, apparently.
>>>
>>> The failure I'm talking about is here in zynq_gem.c:
>>>
>>>           ret = clk_get_rate(&priv->tx_clk);
>>>           if (ret != clk_rate) {
>>>                   ret = clk_set_rate(&priv->tx_clk, clk_rate);
>>>                   if (IS_ERR_VALUE(ret)) {
>>>                           dev_err(dev, "failed to set tx clock rate %ld\n", clk_rate);
>>>                           return ret;
>>>                   }
>>>           }
>>>
>>> And all I get is "failed to set tx clock rate" from U-Boot and no ethernet.
>>
>> Zynq is quite a old device but I expect you have external clock out of chip
>> or you generate it in PL. For that you need to describe it.
>>
>> How does your DT looks like for external clocks?
> 
> The situation is that RX/TX clocks just come from outside
> https://megous.com/dl/tmp/af9e7c9e8d51781b.png via PL. 25MHz clock is
> generated by the PHY.
> 
> I solved it eventually.
> 
> I described the PHY generated clock as a fixed-clock node, and added a
> reference to it under &clkc as a source for "gem0_emio_clk".
> 
>    https://megous.com/git/u-boot/tree/arch/arm/dts/zynq-ebaz-megi.dts?h=v2024.07#n26
> 
> Zynq clk code seems to fetch gem0_emio_clk from DT for the purpose of
> determining the clk rate for gem0 in emio mode:
> 
>    https://elixir.bootlin.com/u-boot/latest/source/drivers/clk/clk_zynq.c#L524
>    https://elixir.bootlin.com/u-boot/latest/source/drivers/clk/clk_zynq.c#L280
> 
> This got rid of the "failed to set tx clock rate" error. Thank you for the hint.
> 
> 
> BTW, I managed to get the .bit file loaded via SPL only with a SPL patch:
> 
>    https://megous.com/git/u-boot/commit/?h=v2024.07&id=c1403bd080bc517c9dc6f507ee12b62fa85153bc
> 
> It's similar to how it's done in:
> 
>    https://elixir.bootlin.com/u-boot/latest/source/boot/image-board.c#L677
> 
> fpga_load() function doesn't work with .bit file I get from Vivado but
> fpga_loadbitstream() one does. SPL doesn't call it, though. Is that by design?
> Should I be converting .bit file to something else usable by fpga_load()
> somehow?

Yes there was limitation or missing detection which fpga format is supported.

> 
> I'd like to load bitstream in SPL from FIT because U-Boot proper may already
> need some PL logic activated for ethernet to work there. Also it's one less
> file on the /boot filesystem to worry about. :)

I think you have two options.
1. convert your bitstream in bit format to bin format
2. Extend SPL code to support both formats.

I would go with option 1 but patches for option 2 are definitely welcome.

Thanks,
Michal

