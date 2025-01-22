Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13F4C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 13:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388ED808E6;
	Wed, 22 Jan 2025 14:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AhPR7V2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7453A80944; Wed, 22 Jan 2025 14:58:06 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37A518083F
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 14:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uozQK0AV+QK+ZBm3YXqMjPVHe24qvAE/ECTCkT771oVAT9HExETX3A8LeGaJnzcRjfzF4dyTv3cvPzO4j2aBl+R4YgGQkrKpb4AzB76W3lJeHa5hH21ml7ioddAqrkalPP/S5ZRDsDOc8G6JLsKR9lGQotHDVn6/2FrL8CFY5aF3qX/qXtt9eaZn58Vl8Ssj5OivRrs64BF5gUv8f+G063b6Tb256WPTGGbc0xrKS3dXhIb5Pe9GDRY95+GwiRmuUh9TSRYvQgbVMIebyvwKQGHx4zSGGiNwwG2U4WZOsXJy9IYjuxer19+X9XeAAv1uCQWxZrORWhebCtJkB8MSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRAUNo7RWSDn7kiY9dey4khUFf3z4SZ4iLOJufAZh+Y=;
 b=ZHyVHaW3HAbI9KNL3QmUbW6PvG3BwzKLjGulpkN/FClRGGUo1VUT01gy5XuyC+T7AT5VFrNcpQmh2sLM9m1Mu1G8CroCgIEb+QpcdWWXIMu7l5qHsSKCeiI7lfsFcE06LtcVz1Q2RmmT0EhBUCHZb2gY5mjl9BXIe3oR7K1pI6EBvtm8zNNJntGU3gygo5aliOmjWSJHnLQFIkAroWM1J7F+dZYLU4N3LM5D04aTTJFo+JR8KT2EpZIJl2kz0RBnhF4pd1GH1UlEw9uBpoIa47InG5c/hWt/TS09Z48n2xq6tqTyTQIkRn3mp9ZYW1Dkm0YIUblr0Fk4s1ZgyBLtvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRAUNo7RWSDn7kiY9dey4khUFf3z4SZ4iLOJufAZh+Y=;
 b=AhPR7V2J7HyyTkRD8ku43x/ld15pnJ2c3jrww1Jtf7JEM8NoH4f38n1MJDaooAVkxSjPc9yYt3F7V+y/3WPWdP9EgfMSRzhzPezIoFNvnTnyxi3UHoO3HdRdaxN5bELZ9jYxhnUzgGbxEifnbNoQpTO1qa74jy56Ad4Cnug6xMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 13:57:59 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 13:57:59 +0000
Message-ID: <9ebdf3e6-8fcb-464e-922d-d596e55f4ccd@amd.com>
Date: Wed, 22 Jan 2025 14:57:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: phy: Let gmiitorgmii converter create
 additional PHY
To: Tapio Reijonen <tapio.reijonen@vaisala.com>, u-boot@lists.denx.de
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jacky Chou <jacky_chou@aspeedtech.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>, Tom Rini <trini@konsulko.com>
References: <20250122092250.722356-1-tapio.reijonen@vaisala.com>
 <20250122092250.722356-2-tapio.reijonen@vaisala.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250122092250.722356-2-tapio.reijonen@vaisala.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::13) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: e26ee903-0b3f-41fa-73bd-08dd3aecc7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEhzTEJWRkZNTTRDV2VHUmdvaVorSFdGSnZadU50MVhsNGVjV3JpWmhlaWw1?=
 =?utf-8?B?MWgwdWVmalRRRW44UXFGM2pqQktWVGZwYjJhYUVWTGIxSEpSeEpWOTdqRFZ5?=
 =?utf-8?B?L2ZPVlRaaTg2Wm5DN3lNZjVyeWRCVGsxSmIxajdBNGR0dHZLV0l5dk9Cd2hy?=
 =?utf-8?B?MFZVamk3SC85UlYwakE4Sm54bFZzVVI4TmlZNFI4aTE2SG9qSWx3RGRqb0da?=
 =?utf-8?B?KzBZTmczN2xDTlY5OWxHSU9tSXUyUk4xZ0swNVA4L29vRks5MnAvSmMxeEhw?=
 =?utf-8?B?SG44a3RkVW1wVTRkU05nNlN3QUtVUFpZbzBYZXlBdEtqdmVrajdQbjFnVnRn?=
 =?utf-8?B?MDdHTDNNN2xhRzlPbjFTOFlsd1pqaE0wNkRGa3BlM2c5V2tiYzVUbkNqQzdC?=
 =?utf-8?B?OEFCYVlCK3lxdkhveXZxYmV5aVJuN2JtYXBxQ3dLbDhxTFJiTURyRUFNeGhz?=
 =?utf-8?B?S2hWeGhnbjc3YW55L3hSNkQrVmNhMDQ0WSttNW9xaHFQOFRzQngwNFkzc0or?=
 =?utf-8?B?cEc2cmJwVjhkb0dTZXlaRWZLTGN3YTI3ZzRvUzNONmQrTE0vZmtmT1AxcHVP?=
 =?utf-8?B?L2srcmVwa0FCYk1VNHltdk02Z0VJQnQyYmZSQTZKeXNlRVczVnNWeklzQW1u?=
 =?utf-8?B?L2ZoZGRsb21aWWZkcDgwbDFsV1ljUFdJWkN1d0lTNlk0aGM1MUc3eEdTUktR?=
 =?utf-8?B?WmlXUWlPUmhwbkpzeXVZdEN3T29KNEliS3pXYisybmRKSTlocEhNdDRzV1Ra?=
 =?utf-8?B?MngxcmcyYUU3MU1Vd09CejFVMTNOL2dyTGJNTjliMG5NOTFJT2Q2WDlWZXda?=
 =?utf-8?B?bjloMHJEYVVGc3dmamlna2xIQTlGY2JqdllMSnBWRS9BcGlmbFdKUFZwZEJm?=
 =?utf-8?B?R2FhMkgranRiSmFvcGRjZUs4SjhDU1BWUTFoZ2ZFd0ZNMmJ5OHJ2TVBBelBT?=
 =?utf-8?B?Qkwxa2xUY1NxTFN0VHp4U3VSKzcxUU5QVnRZM2laZkIyeUhBNU9ZNlhsVXVF?=
 =?utf-8?B?ZGFtakpZVzBXaE9Ddkw3Z1kzUFJlbjdlY3NUMVYvMmlsNG9RamRndGZzenQr?=
 =?utf-8?B?bWRlZjlWYlZWZ2V4b0JuRnJoVmpVQkJuVGxwc1luYmdwMmNQUkhYQ1dRNzBz?=
 =?utf-8?B?djNEd3hhcGxxb3BsNDFWb3NVYTJlVWdYVUI2M2F4bVRmNzRJZEszT1lIQVlE?=
 =?utf-8?B?YXducllJU1Fma0M1NllzR256TU5rSnpQd014U1RJRGlaY0JxUWRWS1ZqVVU5?=
 =?utf-8?B?OVllYnJiUVZTOE9CclRuYlhkdCs0Z3BMcXBFekl2cTdMYXFqVFRhV1kxNW5X?=
 =?utf-8?B?blFNL0dESU5iallXdVREVmw5YmcwL0EydHFKdnNUS1kxYmdZOUVuemhaRm1q?=
 =?utf-8?B?MVMxcjFpUUpKa1ltTnorUEZ5bXhtSUhDNHVOWW4wZlNZdSsxb0dFQU1LZVAx?=
 =?utf-8?B?VG8vN2ZqU2NQYVVEVzFBYmd0aU9tNUFWbExyZDhjbU02dmc0S1NSOEVJOWpZ?=
 =?utf-8?B?L0hpNWplWU9yL29IcEEySHJXQ0dzckFIRC9MaUJFcFUrZlZPOGRqNm1pamdN?=
 =?utf-8?B?cEIxbm0wN1lEa1g1aGRZSU9Sa1p2clhKZkFxTklYWnhzRldiOHBNcmhMc3lp?=
 =?utf-8?B?UllpSXFBNFJOLzlNdDVyMVB4UHJEYU1SVFp0MHBadDBpRlBzek55V2dXbmh5?=
 =?utf-8?B?YitzdE84aHlnd094UEpMM0FuYVpHeHBMd2E2R08zQUJYYUZQenVXellRd0wv?=
 =?utf-8?B?a1JDM202YU5DNU84aDJXVnp3aWdOQ0V0dmdORXROYW0wZVB0OERZNnJOaVhV?=
 =?utf-8?B?NHNRcUlXMkxQRE5YOVZtanJ4WXBhWjhRZUE2VUJMTUdlUHBLTWJoMThTM1Jm?=
 =?utf-8?Q?h2S7Obz3kzBAj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0h4cStzVnFoempSVUFCdHdpZkFENHBtdldkREY4SlZVaUZrcGJobUVhR1lz?=
 =?utf-8?B?RUVRc2FJR1RjbHBHTTQ1ZHhEYThsZG5RU09vdUo1ZHU3REhDRUlyaEROMWR0?=
 =?utf-8?B?dlpiTlM0TDgvZ05iZWpKM3ROc2J3aG9Ramhha2o1RmJwdUt1WlNFMDQrN2dz?=
 =?utf-8?B?UURCOVFlNzhwQnAyVHF6Q2hHLzlYRnBGSXJkTWM2bkR2dTVpcmhOQ3VhdXV5?=
 =?utf-8?B?YnQ3eWMrWEIzdktpT3o5OWUxUVRvdGs1T2w3SWMrRk10U245UDJhSklyaTR5?=
 =?utf-8?B?Vlc0NFRteElsSFZvamVvSGs1b2NRenlsYzEzTVhNWUpKc3hGOC9vWXNKdjB6?=
 =?utf-8?B?b0FEcXhOU1RiUE9BY1pRWDI3L3dUcm1aRW8yZWFkcE9paVNXVFFEc1Eyais4?=
 =?utf-8?B?eGhMS2FzNTJpQ3hqeEdTRjZtSmpHOVRpQkpuWGdJMGMySmlzMHM1ai9pbFZO?=
 =?utf-8?B?ZEw4Z091cytvZEUyMnN5RCtSRllZQ1pJWTdoNy91dFlwb0NrY3FTQVkxb0Ft?=
 =?utf-8?B?VjJWSVZUUUFFVFhadVFrOHJPS2VvYWF5b0lKSmdLNXc2ZmZVOXZLUDRIMDd0?=
 =?utf-8?B?T1hUcWVWVUVWdEdFNFllZ3IzM0N6MFFQVGU5WlluK09jZDEvc3JCNXRqbnkz?=
 =?utf-8?B?S2tUbTV2cm9LQmtJN05uU1djbTVYNHM4eWJTMzRFZm1ETDNmNkZyejJqYTFT?=
 =?utf-8?B?d0F4a3VaaUVNUnN4QTMwMGVIaUNBSGNsQ2xzT0pLSWhZa1VxeHhLUEFiMDIy?=
 =?utf-8?B?anRoNFVZSVN3Zm14TWVrQnNTY2g4MEtza2RKMnRQbWQrNGszRTlEcm5QWE4z?=
 =?utf-8?B?dlE4VFV4Um1XVUEzQWhaVjgyRFU2QWdXZTZlYUJwdTV1T1laMmkvckZ3bktk?=
 =?utf-8?B?WkVOelBDdENITk9LY0l0dkpDVTNWNHh4YkFTd01XdkVzcjVNNXpUMTRqdUdu?=
 =?utf-8?B?U0wzTE41NURUTXQyckZiR3pXSHRrU3JXcy8yZGtIeVlzRHprT0NUQWJOWnVG?=
 =?utf-8?B?YTlLVnR0U0hlNXFweUhScFE4WXg4bm44WHJZSFpMRTZUelo0TCtwQUxDYXBk?=
 =?utf-8?B?RXhGR2taenBhMnVtOTZXNDRXRjBBWG1tbTFIRGQwdDR6SkZQdjVKdjBjSkZS?=
 =?utf-8?B?c1EybG9JSVVOYktzUXdhVEdqaUg5aGhXUUl3aHdLRU15b2lBVlJDTWdTMWxu?=
 =?utf-8?B?THBydjdvdGRhSDNFdU1LbnRXWjRtaWJGYm1wZHluYVlWOU9lbFFpaHNXRU5r?=
 =?utf-8?B?ZXd4eSs3M09iUVlZY043VktCVTdHTDI1K2tVMDZ2aC90Ty9hRSs3SzFzVnYw?=
 =?utf-8?B?V3ZBSDlvR1hoNkM4ZFFxeDA0WTh6eXkxMDY2T3N2RVZJV3dTOEVpM0NLSnMw?=
 =?utf-8?B?RVV6WUwxQjE2anAyN1pNSDFXQVhESDdsM3o3S3prR2ZXVnB4aDlMbEpOMXVj?=
 =?utf-8?B?K2p2c0p1eTFya2QxMDFNZnR3bzhtcml0bkR0K0ZVZ1pkU2R1UVFON3BXYXg1?=
 =?utf-8?B?Qms4czRQWC9zR1lvVURBdmw4TU9OOWdKS3d6d09YUmFpNmpQQmk4V2wvOFVk?=
 =?utf-8?B?RGIza2JEaVpIOG9HbEI3SytjYUh4STRiU25rV293ckIyemxNeE41THhqdmx2?=
 =?utf-8?B?RnBleUtsT2NibkxWK2RPRWNpYkVOYytPbTRTdE5McFZSTnNDUTA3Q2YwK1FJ?=
 =?utf-8?B?U1pBSXY3TnNoZFN5dXBkZWN6Y0h4TnptVk9VcjZjRFdPL3VsY3dCUXMzMmJq?=
 =?utf-8?B?WkFNQ1RJMXBZcFFycGpZTWlieFRQbFA0Q09BNEZ6VDEzOThDUVdZL3E2SzZO?=
 =?utf-8?B?SUdiOUU5SllnQTVkZFdmRlVRdGRVU1RiSEROOUNSU1NTMXpUUWtPcCtZQm1n?=
 =?utf-8?B?U3FRZWhEYkhuNEJkR0RTUUwzRHIwd1BHQURVUUNCanFrMFVmVVUyUFVhNkJJ?=
 =?utf-8?B?aGphd1p5MXRScU5PRzlpYVc0cXhMRDg1Rk5PRmsrNXc4NHJKVGJYK1laa29i?=
 =?utf-8?B?TjNkaGpsTkgxb2VoeEtlTzM1cTFrQnA0dGZFNmVuU2tneFF1M3hCTDdCeWl0?=
 =?utf-8?B?a3hXWFJxUlJ2cUxGS0poc3J5SWE4MnhVemlZZExvaGY4WWQyMk9CdUo5Y2NJ?=
 =?utf-8?Q?8UBJFRuSdhdJs61q7FIHpr1E3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26ee903-0b3f-41fa-73bd-08dd3aecc7f7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 13:57:59.8831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84H5m0uX7Zv5s4b53rAX8KvnqlHCdX4AzEhwlt1cTAH644qW+Pemwpv0ahPnaMVY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
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



On 1/22/25 10:22, Tapio Reijonen wrote:
> Change the order to connect gmiitorgmii before PHY creation.
> The gmiitorgmii create additional in DTS configured PHY during
> it's configuration. This ensures, that converter sits between the
> MAC and the external phy
> MAC <==> GMII2RGMII <==> RGMII_PHY.

as I said please extend commit message to describe reasons behind this and using 
that dt config as you use.

> 
> Fixes: a744a284e354 ("net: phy: Add support for ethernet-phy-id with gpio reset")

And we can discuss if this is a fix of this commit. It is more or less 
workaround for Linux kernel limitation and not actual fix. Because with correct 
DT binding existing code should work.
Obviously correct way to handle it would be to fix Linux kernel driver not to 
convince U-Boot to use Linux kernel dt binding.

M

> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> 
> ---
> 
> (no changes since v1)
> 
> ---
>   drivers/net/phy/phy.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 716a1d461115..740533adecac 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -939,14 +939,14 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
>   		phydev = phy_device_create(bus, 0, PHY_NCSI_ID, false);
>   #endif
>   
> -#ifdef CONFIG_PHY_ETHERNET_ID
> +#ifdef CONFIG_PHY_XILINX_GMII2RGMII
>   	if (!phydev)
> -		phydev = phy_connect_phy_id(bus, dev, addr);
> +		phydev = phy_connect_gmii2rgmii(bus, dev);
>   #endif
>   
> -#ifdef CONFIG_PHY_XILINX_GMII2RGMII
> +#ifdef CONFIG_PHY_ETHERNET_ID
>   	if (!phydev)
> -		phydev = phy_connect_gmii2rgmii(bus, dev);
> +		phydev = phy_connect_phy_id(bus, dev, addr);
>   #endif
>   
>   	if (!phydev)

