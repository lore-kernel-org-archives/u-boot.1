Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F4BCA0FE1
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 07:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7C9D809A5;
	Mon, 25 Aug 2025 09:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="oI4k2hw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EB6181E13; Mon, 25 Aug 2025 09:45:13 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B038003E
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 09:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mo2Gt4m+bEmlPDySXDSljHrZFmnojTuZ2qURXSRKmjB+hTrVFpjj2IOC/DfVyBtKAN0TEs6JsZx6e3LyWY/XQq7wFETkO2DYeKTgu/kwONHdoqc0gqjWjGueUqwNQYgpmcmrFVhUNqb9crMor23Pwutk58+7Ofgtf8ygvy+DdMneEyhE0TC6lhjhd3V21SJ49feVxufIOoLo2L69vUokCVP8oclPA9Ioe5GndGUch/S7X9XCT+bSSVa3wU/FW4DUIN3Xln/lHOq+eKwUSCG07dwnKLEGgRyCHUUdnCr1li4PJdM6aySTHNPhq8Pa+z9QiUbrohdqUGDs39GTwAoOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3jMsMH/spimAKloDg8NEyDDvNmuKlhR+tf3FMd5OA8=;
 b=C/KqMKN67phwExh5O4MD2t5YX3/UCZ6Ib/rKs5RzXEpI6TRAjowI45FlQ3K3t/UbiVMEE2KS3uN1rL/vcjLZsO8JpWeb2Aitk2rNSewwD1ueZODoftQ4DpaRkh9LwOi3Ktv/rRBs8ZsKhuPZCMrTs5QfU9pNbRhCE6q/pg8+CXr52F7x7IAFRzYTAfJAMROseuDsx5AdUqt4XMEBHsMVsiUngfg4Xc1/rc3i3PPQpPx/MFziEx6qWbtpnBU2hUti/FydwMOoFlxoDhQ0izAQWK5bv/yM7d0w2b6I6KLKXCszRdD21w/6Fl+Yp6dCsFHURSh1Njw0iEUzKuespk/3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3jMsMH/spimAKloDg8NEyDDvNmuKlhR+tf3FMd5OA8=;
 b=oI4k2hw03wKiNhkdEt3RQkWfZzehCclkHVMPkX53v5mpuszsgE5ND+N0xNX5VEMphI619PhBoRroMJlZ3Pv0zslpO93NW4Hh2ToELJJeS+sWbzeuhEZk/8rR6KiQKbqj0ur+8gtjwxIm3rHMHwkA1LO+b/SsfZGOsu4c9sDiWlf1kLE+IXuFuCTebqRQeX9Hyd5eZ/5Qn35cLhXaj7IDYAw2GVa8Zp3How1ok1rPlgNKQYoJ5Ft9c1AmnAuttobgwFWK5LwdlL7bSHNUSas01UWhr68RP9q0KbYBzKWzNf8yWtTQ9pxXz1DnPH/JC0Uu7AlmY2eZHuOQbXCmmsOSIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH0PR03MB6382.namprd03.prod.outlook.com (2603:10b6:510:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 07:45:06 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 07:45:06 +0000
Message-ID: <9879ace5-88e0-40be-8b49-4e3baee5c1ec@altera.com>
Date: Mon, 25 Aug 2025 13:14:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fs_loader: Add QSPI RAW partition loading support
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250820075351.6455-1-nareshkumar.ravulapalli@altera.com>
 <24b4a185-3575-46ae-8d5d-43fd0902a4f3@mailbox.org>
 <088604a7-3220-4158-a7aa-6e1528b9e38d@altera.com>
 <4f28a730-3952-4a6e-8f9b-506b588b43e6@mailbox.org>
 <6f4b1dbf-45ea-42d8-8f26-a611ed215d75@altera.com>
 <48d5afec-0508-46d6-b444-117d4a7bfe32@mailbox.org>
 <303a50e6-e670-4456-a23c-cb829bc1dd88@altera.com>
 <edcc50c3-4968-494e-9fb1-6acdefd26a53@mailbox.org>
 <c13ee750-2534-4cfa-ac6c-a6a51dec33b1@altera.com>
 <6935fd0b-8027-48a0-b9ec-076535d929b9@mailbox.org>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <6935fd0b-8027-48a0-b9ec-076535d929b9@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::18) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH0PR03MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: d88cad98-38bb-44a2-3011-08dde3ab4ef9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0hhRmwvcHk4Y0pEamNyUHdVMGVKTkRKR3p3Q2VYZUhUdHNTMTFDbTZYZjVZ?=
 =?utf-8?B?TkVpczc2ZnBqb1NNb2s0eFlpMmxZQmh5eDJ5K1BoTkdhVHV0R2UxaHQyTnVp?=
 =?utf-8?B?RzBHbERJcGJpeWZGMnY1UkNLeW9LMDVEZjFtb1pnendmTFNxRVcrMVV0QUxr?=
 =?utf-8?B?aDFRSExFVm1xeS8vRnVEbEd4KzNWMCt0RVpZYWdGa3d1QTBKeHo4STVOQVln?=
 =?utf-8?B?QzEreFcrVnIyUCtQZWJJOERGUG16cUhhY21oaE9IV0poU2Y2bXVKcmRGcW9h?=
 =?utf-8?B?UUJyVXF4a3hXbk5INWFHTnp3Z3dnelpTazk3QlRpbkVIc29pTWE4OXQvVm1G?=
 =?utf-8?B?WDVNemJLSGxPSFhtRWZadFc2WmNIQ3k0YVk3L3E0T0NQQWZQbGcwNkdYdFlW?=
 =?utf-8?B?TFQyUjd1cVRydkFOeEt5QWRGYmJPTEtySk8zaTdxTUkySWtzUElhc0l1d3oz?=
 =?utf-8?B?anUrSTdaWmxkdllWTm90UzRRMEdzWUZKM2h6UnZXOVBnY3FkajZYb1BFekd3?=
 =?utf-8?B?dkl6RHBDYUhvc0VJWURBaVdjZk9uTlFFMFB0Vzg2NndnUVpoNUJxVG5jZUFx?=
 =?utf-8?B?VW5XQ1dOdkF0QjAxdmJGTjA2bXlhYS9kQUZGZEtkWFNHNmd2eDNQNktSRmtN?=
 =?utf-8?B?dC9naVJVS1hYRmJVTFVzQWpqYVNkVmUvMUErdzhHL256b0x3YUlRSXFwM3FN?=
 =?utf-8?B?V3NZM0dScjFGb09KSEtsbWVLeUZDc0lQQkJTV0xRTDhJSWpVK1I2c2VXNUlJ?=
 =?utf-8?B?SS9xQWQzbVJRcVNRbDRTeVMwcEJyVmhXOTlZTlIwQ0FkYytqbFloYktybCtW?=
 =?utf-8?B?cTZHSFUzeUhxaXBQYWt6eCtIM3IvblcxRDN4T3I3YzF3dURuVXNZWXk5V1Zz?=
 =?utf-8?B?RWYvQkVBQ0ZYby9oblh0c0h5YjVMemlvbWdvanFCNFR4MytpTmdWN1FsbzB2?=
 =?utf-8?B?MklaM21ndlZmU1VGYjhVUXRrdHROUTRXOUtJZ2ppOHhybjhwTUluaFdySHZC?=
 =?utf-8?B?SndnSFNpTU85eGVhbTNLUk43dWhUWCt0Z0JOSTdLRXRvRWdrNSt3RTNOYmpQ?=
 =?utf-8?B?SlE0MytsZ0pnM2ZoODkrcHJRa243TVRlc0J3SVo2aEpQTEpxVXM4bnN4YlV0?=
 =?utf-8?B?OERuRHFjK253N0p6VXl3emt0Zmk3dzY4V2pla3ptemJXNFJtRERlNGhkTDBi?=
 =?utf-8?B?cGY5NVJCeUR6aHFjQ3dPRGtkMWpEVnZUNzczZG5zTVZrK3NVRGVDQ3JzZjdB?=
 =?utf-8?B?QmIzUld5U09NTUhkOGcxeS9CMjNxZkh2dU1CVUs5N3luLy9pNEhnRHhlQjNy?=
 =?utf-8?B?S0N0SFd4RGNNMVBtS0VsWDVKUHBWYlNCNjdpa2l4MkVvM1MyWnJHdGlXWUJF?=
 =?utf-8?B?dDQ1QTc0Zk80aU1zdHhaL3dEOURuQnR1Z2V1aS8xMkRJdkJ5bGxjZ3JzNFRD?=
 =?utf-8?B?M1g0eHA5bVVSRXAvdUh5Yk1EVG5SSmx4cjQ1YW5mZ3dOa3drTWVFeE9TQlNQ?=
 =?utf-8?B?enpVTlI1c0F6TXQ0Mjd0YjZNK2piT2NYRVZuaVYzaVJtNXBFeWl3Z2ZscUFT?=
 =?utf-8?B?UG51QkJpR1FRd1lpYThSVkk4NEloUnpwbkhmdXRyU1QxdGpYeCtrWVVicndK?=
 =?utf-8?B?NytWTU9LTjlCMEh4Y3J5SFZIMGhTWFNuRld3VUdQekwxaHNQQTIwZmlBajhV?=
 =?utf-8?B?eW9pNHQyNnBNR1gydFhQUXlyTXhZQytkS0xmZlBzSmppbWZzaWQ2RkwzMVc4?=
 =?utf-8?B?N2poeXZpZ1FzcDJxNGFIbS8vR1hYMXdCdXN0N0ZMZVhjK0UwOWdpNjNOWHhD?=
 =?utf-8?B?ejN2YXJsRzJEaW1XOVFXNGMzc2o4bmd4MS9RVnhsRFlEemlaY2pOWmcyVFJL?=
 =?utf-8?B?Q1NPZDdpZTgxOTdCTlRiVXNsQVg5Z2hmdXZMNUVTZTZFMGNiRHdyb3lab3lq?=
 =?utf-8?Q?7AqPPiTG6BE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU9xajdjV2dUU3MrUnNURjBhZnZrWlc4OGZEWGtlbksrMEV2RW9Mc21TY0kr?=
 =?utf-8?B?NzFvL0ltU0t6eGdVWDlacFhKWnpCYXJwNk0xc3NRY0IzMEJaMlBEbmxQR3Bv?=
 =?utf-8?B?NitHb3RmODBnZnFRenRtZ2c5M0NVV2wwT2NPakxXWTBDaVFXT3JtTnpBanUx?=
 =?utf-8?B?dklkYnRnR2tJL1lrZHBnMEkzMHk5Z3cvU1gzK21qMXdwNzN0aFZpSDFUMmUx?=
 =?utf-8?B?bE1DR3V1aTlzU091TC8xbnE4eW15aHdjR0lOWk5yanI4M3JnVUxPTFJkSDVj?=
 =?utf-8?B?Z25HZ2dlSndhRjFSMWhtVHhIOUJHSHhRTVV4b28xWldHbDc4bFpaTTVGMVRu?=
 =?utf-8?B?bUFLdVRUcytaYk9WUW1jbTJnMkhtQUQrSlRDYWc2QXpjVUM5L0FrUW9yTGs0?=
 =?utf-8?B?dzkrSVYwRW55dVAxVzI0Skx4akdha2o2WjNITlljZUIyOERyQWo5N2JmaElF?=
 =?utf-8?B?d1VkU3hVVitoeG5aVUoyZTRYOUJ4MVV1cWtlaGNtRVpxZzFlamcyUVRZRmh6?=
 =?utf-8?B?RVpoNTB6OFpIZUd3M0dQNjRadm9QYVEvSmNFMWkzb3k4cHJvdFRCTU9wNDBx?=
 =?utf-8?B?WS96OTJpQXVwQ05zTHJpOWpCNFFPWW1QKzNLOUdNVU5CUzJ0cHJsNG9PdmUw?=
 =?utf-8?B?R2lNK1RxWXRFTlRsSEFiQzNiSjNMTXozWlRGZDk4ci9JeEpmYUJybUxTZFFw?=
 =?utf-8?B?OTNRcmpIYTYrY1E4YlU0WjVmWm84Z3BwNVd6eWpjaysyWUYvZ25UWnVpV1p6?=
 =?utf-8?B?bzN5QkhFMXhDelhMUmQ5dnJ2WVdFQXRsOFZNc3E3SnhVNld2enlLM1ExQkMx?=
 =?utf-8?B?d3BZZURzSkFwK21QaU1JWGM1aXR3QnI2MjJvVSszM1U0bXA2TGw5K3czc0NR?=
 =?utf-8?B?RjI3VVZubHpCVDM5S2hhWGlIRDg4NnhDajFwSWx5NlJubDBQejVQV2pBLy9a?=
 =?utf-8?B?eEhkY0hkTnEzc2VlQlI1Q2F5M2tIdGR1U1JwRmYzbXQ5V3RKbC9zZEhxQllZ?=
 =?utf-8?B?aVkzSmtsSE9qVmtmZmVNakJTR3RqaitQeTRldmthTVd2VklacTRTaHZZY0dI?=
 =?utf-8?B?c1pWbzNpRDB2MG53WTFFYUhIQUFJZEp5cXk5bnpUZGV5TEJkWjQwMWZSL1BU?=
 =?utf-8?B?UXdra0NMdUkwNVlMQXB4eXZuUmcyRlpZbUtXbzdjK0lQeHVZUDYveHNXM0RX?=
 =?utf-8?B?Mlo4TjNXT2pDNUN1a2ZMOWtaQkE3ZGxMcWtnWkc0N1c1NzlMVTd6a1NheTNz?=
 =?utf-8?B?bjd6eTRYT3JzelBRd0gzNHhuZjhhTm1mVXhoanRRdG1GWHJVSDZEc0Z1b1Ri?=
 =?utf-8?B?WEM0cEpzS3YvZTlTTE1Dem1VRFpDMmgycUJWK01QYXMrVWV5VnN1dGxxaE1Q?=
 =?utf-8?B?TWZxekxya2pLSHpnUVBEaXl1WW4reHdpeDhyeHpQYUlQOEJyT3dZNDV2UkZ4?=
 =?utf-8?B?MDA5M1g5UXN5OTFRYWZDY1RYVEIzd0ZTeDltUnpXeXVTM3YrdmhtMW02UWdh?=
 =?utf-8?B?Lytrc0llMm1xK29NRUNuRlJndGZTdVcvWnliSGlCMjVUZ1RIL2FHb3pYQVVn?=
 =?utf-8?B?SFltT1IwSk5FVzlPcFIyOTkySEJSbHArcmRJdkdtSktsOVduLzBiS3JnampM?=
 =?utf-8?B?K21wL0M0d21qWHVpWWRXMVdQSHFReS9YSUVtR3d1TlhySURDaVl5dGRVc3Zp?=
 =?utf-8?B?TmhsVm5ZcmxibnhOVFNpRlVNV3lJZHRHQnp1S0JGbzhWZFAzcUpJQmxwcTNK?=
 =?utf-8?B?RXRUT3NGUlpabzhZcmI4a3RyNVNoN3R3MHBhamE1aHpLTWNIV2wxRUhxKzB1?=
 =?utf-8?B?Y1I2NHhoLzBXb21YUjdKMEJlQkJUYXd1d0YzTmo1eHJrVSsxanAyWWdkS0Fx?=
 =?utf-8?B?Mk1IaUIraWxpK0xmZEx5cEhwM2ZFdVZCa05jMWpSSm9vbGRsM2pzdCs5ZzNa?=
 =?utf-8?B?OEgwRjVicStoR0hPZm1EY1pJL0N5QmVNTE5kWDBDaUs5RnZBNWt6VTkwZkJi?=
 =?utf-8?B?ZGlIbjFNV284WG44SDMzM3VSb2VOUzFQSkVZalB4MDZJQ2d1aUhmZnNnS0lB?=
 =?utf-8?B?NWl2elpiR3NXblEwZjJia21WVnBzMVNmK05lZUFjTTQydTFGQzI1dFdFVzQ4?=
 =?utf-8?B?bzlRdjZsVkNEVVk4QW1od1lPT2c3YWJyMHRJVHJ5cUVvQlFpMWkyeVFiMG44?=
 =?utf-8?Q?fByGJMUZ4FLLVVAF4IIhWqs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88cad98-38bb-44a2-3011-08dde3ab4ef9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:45:06.4189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sa/ioXAqAbfUnC37k5v5ciwLaJymgmnuxkmL6cfA03gmOVUCuSuPHUsHKgH1J3325ym5Wmoxu8TseRibQtFDCyNHMJptQ/P/HocnQ1UNSPYHzYVmHrUjC+NAeux5z3wR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6382
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

Hi Marek

On 21-Aug-25 5:33 PM, Marek Vasut wrote:
> 
> On 8/21/25 12:26 PM, Ravulapalli, Naresh Kumar wrote:
> 
> [...]
> 
>>> How big is the file ? crc32 is weak . Why not use e.g. fitImage for
>>> this ?
>>>
>>> If this raw loading should be available to users, it should come with a
>>> BIG WARNING about data integrity.
>>
>> User can use CRC32 and if they require SHA256/512, they can use that as
>> well or any other algorithm as desired.
>>
>> RAW partition support is helpful for flash constraint devices especially
>> in a use case where we need to store data as RAW during run-time and if
>> data integrity is required, user has the flexibility to choose
>> respective algorithms like CRC/SHA etc. The whole objective of this
>> patch is to provide that flexibility to the user.
>>
>> I don't think we need the BIG WARNING, as RAW data by definition will
>> not have any built-in integrity features and users should exercise
>> caution if data integrity is required. It is mentioned in the enum
>> definition that choosing "DATA_RAW" flag will store data as RAW.
> 
> It is not a good idea to use RAW data in the first place, because it
> gives the user false sense of safety, but in reality it can lead to
> silent data corruption. Hence, please add big warning.
> 
> Also, how big are your payloads ? You did not answer that question .

Is adding "log_warning()" be sufficient, like "log_warning("%s: Chosen 
RAW data type DOESN'T have built-in data integrity support\n", __func__);" ?

Our typical payloads are of 3 KB size.
