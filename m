Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410B3D63930
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 12:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EFC6895F0;
	Wed, 20 Nov 2024 13:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ckodm93w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A5889647; Wed, 20 Nov 2024 13:16:43 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E996895F0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 13:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2EfzUWZF1/n4FhKzIwG5Po7bujTzgiZNKbS5j2ZKIQUvfgpKK/Dv3NxDm4NBnjMlhJ10iEJp9I+XhaYFQkB7Sp2HzjVyWjoOKSS1YM8uU/6BSC7pORNm+ubjZ/uBbJ7lZJKG+IVyTNEsfMnIxgU+LOol8pZwK4pQaWarW0MoJ/72vJ3ChIUWA0riX67U46wn+nUX8oEtUqJQB9dI/GT6DuJff6NsvAOsUfVltmIAAfj5jlRd5y7wvxpirRNPkBoJ7GgFeaIub15b1L9lKXFQkaViztBiv0+wTTdLRIhiX9W+XF1E2jpWjluLTVcxPEBh4/9LfnklFpnki18SGD/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaJbtNOjn+rjHYgTXs8cP8lLlijTCR8kQgkgjNXe+sY=;
 b=kmj9TMhPBmqj6USwvB37NksR6yYhYX4eB3PC8hZ6WpSJVoxU9B6Y6IzXFpIqt5MOr51Li4bT8PLf0ZsC5QNFUiW0gxqAP/aDhExwYhqa6IfOYAyNy9dMTle6bEXeImqFbVj/wPCRQboH459QZ7W5IsBsjP9FNeaZD6i+O/9XBGTj+jMoGabyiu4LGYMsmraRmWTXjuYnFgreOwMxXhcMipHzxx0VolU7Vm5P8As/2E3yt0wfG4AcyM2dNgxoyDUjARNyg19aKhQ3XDkuoCDDnBZTa97dkKwxzBbzaa4Fv+iQqShY59IpNRK4Q/WGpWxvszvhC0iEV4eLC4pEsNlyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaJbtNOjn+rjHYgTXs8cP8lLlijTCR8kQgkgjNXe+sY=;
 b=ckodm93wCO6b/oa0Sy87z6hSM6o07oyHOn/gJICuCyU6iznyL0tdPWCO7XIVR5/ku4sTKfcNH0s7RzL7CyjegHMru7HSdMokfMpfWgcHvPpNT61krdVqkcPWTPREB0TZRfpcxgOMlnhkodN5tWt5jfB9xZLkPvsGvuTxkbER9n0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 12:16:35 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 12:16:35 +0000
Message-ID: <cb6773e7-e1bb-462f-ba9b-731e8959343d@amd.com>
Date: Wed, 20 Nov 2024 13:16:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
To: Marek Vasut <marex@denx.de>,
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "fabrice.gasnier@foss.st.com" <fabrice.gasnier@foss.st.com>,
 "git (AMD-Xilinx)" <git@amd.com>
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
 <20241112050740.15343-4-venkatesh.abbarapu@amd.com>
 <d61ab683-744d-4024-a5d3-71b372e85d02@denx.de>
 <SA1PR12MB869770E331845B38B0BC2AC098592@SA1PR12MB8697.namprd12.prod.outlook.com>
 <5c4c73e1-4b47-427a-b84c-099b044d07a8@denx.de>
 <SA1PR12MB8697165267E847E8F8FDC0D9985B2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <b06d22ba-6629-4893-a90e-185f676017a5@denx.de>
 <SA1PR12MB8697C5004BB109302CE441B198272@SA1PR12MB8697.namprd12.prod.outlook.com>
 <5cd2a342-7208-4cf1-8faa-90dfd82ae5b0@denx.de>
 <SA1PR12MB86972FD15A7312EF59F1A5D298202@SA1PR12MB8697.namprd12.prod.outlook.com>
 <da8d990f-b2fa-4f21-bee5-7d609e9364b2@denx.de>
 <SA1PR12MB8697282F71C84463633BC7D598212@SA1PR12MB8697.namprd12.prod.outlook.com>
 <63680409-ee94-4b2d-85cc-14640e77b9ab@denx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <63680409-ee94-4b2d-85cc-14640e77b9ab@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::16) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b05df6-9d1e-4ac5-da60-08dd095d2d4d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTh0TkJSeWZkOW8xOGtEQ2h3L3pYL2JwUHUvMjdPZVYxVm5xZjJ1dWcxYS83?=
 =?utf-8?B?WEhzbURpYlMzOHducW90NXI3bGxBNlZMSUpIR0VXT2FicVJ3RmpBLzZJaUFF?=
 =?utf-8?B?TFNwL0MxeUxhaEc2Um45b1lkUzZzd0lXZDNSWDhSVVgyV0wxU0hwSFlERndh?=
 =?utf-8?B?cDVYeTEvYmEzemRWQTUxVzJGSWluT0ZhdmpTMHlLSzJwQ0lFT1MzanNjbzZq?=
 =?utf-8?B?b0d1MENTK2NWWU1WaWlXeDVwMEFCWDRNWUc4bmR6cnovZzFoQ2w2SGpGMFEw?=
 =?utf-8?B?VHZ6WDdQaXZOSVRrK3JoMGlFNmhxOW50VFBTRE5tQUFaMlRpN3BDc3ZVNGk1?=
 =?utf-8?B?bUpXMEU3aWZCMUxoTnc2SUFpR0NRZGR4U0ZXZ1VQaWZ3M2QyUllGRitDUG8r?=
 =?utf-8?B?RDZ5SFQ5NEY5VlVnbWQxeUU2SFdzTkVCMGFOZlh6cVdEWkRGN0s1eHZXNlNU?=
 =?utf-8?B?S2w2M0F1RGdVb2cvV25mcTBIR0p4VU5WTy9ZWlBINUczdnRxZlhIY1AxN0Rm?=
 =?utf-8?B?dHpwd1Ztd3pzYzJtQUFoUHNQUWhrSGo0YU9CaTRNMmhKZmtoRjNON1pKbG5s?=
 =?utf-8?B?dUpvVHFham05dzNGY1lxYldSTm5kQ3hvdmZsQ05BcFkrUXRETFp0WDRwRFll?=
 =?utf-8?B?bUJLOSs0Z3B6dmpNS0xkeXFhdm1pM0lPNFdPMnNGbTB6RSs5WGtJY2VXaStH?=
 =?utf-8?B?aGtFUGxmU2htK3lPelVvSU04KzdyMHRubStvQXhnTEMrOTk2dnlZOS9hUGhB?=
 =?utf-8?B?OTJRUE5tdWxSYzQ0UXhEeWd1OE42TUVVS3hxcUpRMG9HSjRYdHpQWktSU3Vp?=
 =?utf-8?B?dzZiKy9SMFdxL1pHd2txWmRoeGV2Wkl4bUVYMXY2MzF1cElVYllkUno4UEpr?=
 =?utf-8?B?N090SURKMXhWRlNlM2ZpczBGbnBSaGk4dGtRdGlpTmVqUFhmaGZpWmdJSThv?=
 =?utf-8?B?bFpkdTZZOUZ2bldFemdyT1ZnZG4rN0pORitLR0RTWjc3eW95SEFYdGxSVmg4?=
 =?utf-8?B?MGFTMlFFT29vNmR0dFM4b0RkYnMwS3NCQmU5a09EM1MrWmRpbWZyR2l3Z1pK?=
 =?utf-8?B?R3BTMlVDbGxsQmRVWmhweU14VzNpODNYc1BXZ0svRU1NTDlRMEVQREJ3TDEv?=
 =?utf-8?B?QnFWM212Ry9SUlh2VnYyeDMreS9NeWg5Zk5oQm1yb0xSTDErYitMZCs1ZmVC?=
 =?utf-8?B?VlY1eFZ1OGFuaXFUeU9YYU4rRjR0cHJubFlwK2xTZGw5SnY3bXh2Uk5odTBP?=
 =?utf-8?B?VGhkSUwyVXZGRkhTNEEvRUV3NWlJRFFUUFJiakw0eE56ZUJVUmlzU0d1czUw?=
 =?utf-8?B?UnlzczNmNG9FRFRWQVZMUDNON3FlOFJFSG96SjJmdGJiTFNIVzVvc0E2NXNh?=
 =?utf-8?B?QU13Zko2OFBLR3RXeFQwSDNMb3NQbHA2RnJDQ0lkU1ZLN1QyZVpRZDNybjBj?=
 =?utf-8?B?TnZXUHg3WjlyRHNtc2p3VVlKZEtCalRONkg1bU84Zi95TDhQck9VVGVPZ1NP?=
 =?utf-8?B?bEtzUWFzVjYwU1BTRWNLSG1CQ09XVmxPc1ZkS05VVFg3dUJ4S05zZDlBQjFG?=
 =?utf-8?B?R1liNTZKQjY1YkxvbzR1a2lTOUY1SVREWTN4UGIxQTRiOEpOcFRpZDNKSDJ0?=
 =?utf-8?B?NkJEZzdBaUpZaVZpRlFoS3RFRXdlNUtOS2IzOENJWHhodEVieGNkRURFdTFQ?=
 =?utf-8?B?bDk0TkNSRi9KVFdyUFVzdFoxN2dhQ2lzT2xpWGxNOXpIQTZRS20vd3Y5ZWVL?=
 =?utf-8?Q?PcuzEtXh39tiR5yrUpbD+iUi3ALuaqzQm0R7A9Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K051WVo1N3h5dGxqS09KZW1NREpRbzAyOWsxQ3ZybDYzU3dCaDUrUHY5VUs3?=
 =?utf-8?B?YkRjUXJLeFJzUVd5TWtsMDVQakJoVTBSYWQ1Nzh5VkFwVkJHMUdXVlpIVXFo?=
 =?utf-8?B?OTRvaS9WV3RMcEZ4d1pDY05EcnFuK1VNUFNuNC84QzQyd3dBQ0NzQ2Fwcml3?=
 =?utf-8?B?b1ZJNnZrN3VRSHQ1RWhYVW1NRmI5K1lYWmVRV3ZHSEF5MzdlOHJhUGk2L0Za?=
 =?utf-8?B?Mlo3TEQydkt6YTE3UlhjeFhRSzZabEowNlRVRkZ5aXR5TXlkRWlTYXF5QkQr?=
 =?utf-8?B?cjhnYVZmbW9DM0ZKTkNpOXBtTmh4eU05eW00R0ExNDE0bUtWVUxXdXI3NU1r?=
 =?utf-8?B?aXZBQVlWajJKRXFYc0NhWWRycEFKV3VYQmwrSmxRRzluQmI1ek8wOWFOdXN5?=
 =?utf-8?B?Q1BnaVRYNDVwU2ZHdVhLN2daMHVOK0JFT2ZWWFpDQlBIZW1aNU40WUJKZXpP?=
 =?utf-8?B?TnNDU2NhNFVCR2p5Y3ZtNVNmUDdTWkZ6eENTaDBoZDdmSlNJWEVPOGNUMHd0?=
 =?utf-8?B?YXovcnpRT2JnbDJ3WEpJQjBoSEF3Q2E5aHpTcVBGVGdhVjlpM2tTdi9qQ3V0?=
 =?utf-8?B?NGZNRXpIWFNZY0MrdG5Cd2NEc3M2bW8yeUZpMGFWcDNsM3Q5UjcwSW5PajJl?=
 =?utf-8?B?c2J6U2tMbjc5UDVqLzJFMndVdjI0QlNEbGdHOVhXKytLZGFLK2Q3NG91R0k5?=
 =?utf-8?B?Q2JMczkzeFVVd1JKMXVCZW0rSDAzNzUySExlMEU2b2JkS1k2TldwSXV6TG5Z?=
 =?utf-8?B?U3dMK1FXcGd4akFMZWgvTTMwYklLdlpta2h5OWlDOXh4KzE4Nm9GajdjNU5R?=
 =?utf-8?B?ekx3eE5GU29EZXJlWDNMaDBxdkp1RHJZN0xRRkNiSGtRQ1YxN3czNlpxQlhn?=
 =?utf-8?B?OWxpQkdTSlFpblFKeXNINVhDQVRVQXJ1WlN4eHhzTlZTME1DOFl0d0RNOHpY?=
 =?utf-8?B?RnZ3ckpoNW4zcE9NNmpGcUdkbk1qOHdIMUd3Y1B2WVJ6VGVxSXN3Vys3TXdm?=
 =?utf-8?B?cHBSTDdneEZNUFFkMEtrT3BQci9iUUQrZjFaV0ZRa1hzZXEyOGpUMmZpNzJF?=
 =?utf-8?B?cmxwZWJhUHRTODZpenZCa1RnSEdZNTFGWEpyMGt1eVBkVXFYUGd1MHZreS9U?=
 =?utf-8?B?Sm1CbldmSllZYXBZaVMxeU9zUkh0RGNaZzdBa0wyMzhHMnpqZVo2T3hORzgy?=
 =?utf-8?B?eVhuRktIQXoxRUhSeXNkSWhvT0tvUnJXVW8rQTN6OURZWWdkQWhwL3pQcC84?=
 =?utf-8?B?bVRIeXU5T3dzcDhpeUgxRld6ZlJLbzhKdENXbGZzNzVPYzFCa0tvdVUyVjZk?=
 =?utf-8?B?a0dIbCt3dW42WGVjUnhZL0NBUm4xeGwrNGZyVHpJQUNOZEVGQ1FWQm4wRXU5?=
 =?utf-8?B?K3BpRWJQSzljcktCaUthRFQwNHB6akY2aHBvaUNIN1VKUGxCa0lOVXVCNVpY?=
 =?utf-8?B?MmNCbEVabE5Ob1BGSTIrV0I4TWZzZU90NjZqa1c1RHFVTVhPdDZ0cmJEdlRi?=
 =?utf-8?B?MjJ4S2hBNkhNRko0Sy92THBFNjFhSVVNUzVnTm1PYndJalhBM0RsdFRRcmth?=
 =?utf-8?B?OVJ4SWY2MjBCZ0VzckJpRUFIREdGTHpZdlFpSmw5QWVQbEUweVg5WWUveEZ6?=
 =?utf-8?B?Z2V6bVVmTzVHZEQyZmIvd01uUlhJQXdKNnljOXdHekZhUlF0cHIyS3d2VDJ1?=
 =?utf-8?B?NlFkL04yT3crMHhqc1NGZHB6eEc0Tm1zVW1ncmFTSnMrRWNUVDJYaXJ3bGcr?=
 =?utf-8?B?QWJFRGY4TmdrWmtuNllPUDFaRkFSN1lLN2V5Q0dNK3VDdXRJM3NrbndybG9i?=
 =?utf-8?B?RC9KbkVnK1FIZS9wYTV3MzdCYTNuU1F6TVBhb2p1aldKZ2JBbDhOQzlJWUhZ?=
 =?utf-8?B?OVlTaXJHYkdjK1RLbDVWenV5OEJ5WG5rb3J3NDl1WVVSam45bk1tbXBpc2Vk?=
 =?utf-8?B?NnhqWjhLUkxrYzVRRHlKYjB6RWxsdlVWZzBGME8vVUQ1OUxlL3hrYW85QXYy?=
 =?utf-8?B?aWFiYStIeCtVYUVpTDBoUTFKSHJNS1EvdXZJenRiWjlvUFlGSW5HaW8vUTJG?=
 =?utf-8?B?Nmpjd0s5UjROeG1CLzcxNkdIT1M2R3pCbDZwUlpwYUZVT2FlYjdaSjExMnA2?=
 =?utf-8?Q?7JfyDH5py42IlxC11vmpx8VwX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b05df6-9d1e-4ac5-da60-08dd095d2d4d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 12:16:35.5411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6O9XtPf3KNCtgrSZ4hnvAwlImtyliG6uL83RPAL2F++BdGkEkwi4fZp4oaLTyYp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830
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



On 11/20/24 09:46, Marek Vasut wrote:
> On 11/20/24 5:22 AM, Abbarapu, Venkatesh wrote:
>> Hi,
>>
>>> -----Original Message-----
>>> From: Marek Vasut <marex@denx.de>
>>> Sent: Tuesday, November 19, 2024 7:49 PM
>>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx.de
>>> Cc: Simek, Michal <michal.simek@amd.com>; fabrice.gasnier@foss.st.com; git
>>> (AMD-Xilinx) <git@amd.com>
>>> Subject: Re: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
>>> USB5744
>>>
>>> On 11/19/24 4:22 AM, Abbarapu, Venkatesh wrote:
>>>
>>> [...]
>>>
>>>>>>>>> Is there a matching delay requirement specified in the USB hub
>>>>>>>>> datasheet or is this a workaround for some board-specific behavior ?
>>>>>>>> The matching delay is not specified in the USB5744 hub document,
>>>>>>>> but based on
>>>>>>> testing on 2 boards with the above-mentioned delay i2c failures
>>>>>>> were not
>>>>> observed.
>>>>>>> Is this 10ms a board-specific reset delay ?
>>>>>>> Why is it in a generic driver ?
>>>>>> On our boards we observed i2c failures when we set the reset delay
>>>>>> as 5us and power on delay as 1ms as per the USB5744 datasheet. The
>>>>>> reason of adding 10ms delay is because of i2c failures and the linux
>>>>>> reference is
>>>>>> https://github.com/torvalds/linux/commit/908f61bedb2c40c6d856bbfd7f8
>>>>>> 70
>>>>>> b967a4cb498 Do you have anything with respect to these delays, as
>>>>>> you might have tested on some other boards? If anything, please let me know.
>>>>> If the 10ms delay is a board specific delay, then this has to be
>>>>> handled in a board specific way, not hard-coded in the driver.
>>>>> Probably add some new property which specifies the extra board
>>>>> specific reset delay, but be sure to run that property by the Linux kernel
>>> maintainers too.
>>>> Thanks. I will check how to add the board specific delay as new property.
>>>
>>> Add some reset-...-us , similar to what ethernet PHYs already do in DT.
>> Sure...will check and initiate discussion with the Linux team.
>>
>>>
>>>> As this delay might be specific to the boards which we tested.
>>>> There won't be any issue if we can add the default "reset_delay"(5us) and
>>> "power_on_delay" (1ms) from the USB5744 datasheet, as other boards will be
>>> working without any board specific delay?
>>> Right, the driver has to be generic , that means it should contain delays 
>>> specified in
>>> the datasheet. Board specific delays have to be configured in board specific 
>>> DTs.
>> Thanks. I have updated the delays based on usb5744 specification in the
>> [PATCH v13 3/7] usb: onboard-hub: add support for Microchip USB5744
>> Please review.
> V13 also enables the hub driver for Xilinx hardware, does it not ?
> If so, won't doing so lead to incorrect behavior due to -- now -- too short 
> delay ? I suspect you will need V14 which adds those board specific delays via 
> DT for the Xilinx hardware.

Feel free to drop these patches from this series.

Thanks,
Michal

