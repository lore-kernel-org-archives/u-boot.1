Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6CACDB466
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 09:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA1DB846F4;
	Thu, 25 Jun 2026 11:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="HBkS/WCT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 994F884704; Thu, 25 Jun 2026 11:00:32 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D9D58460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 11:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZ/FHgImLr9P37qIomPAg6EoFbDntKEFbhYi+THq0D7oZavSQfjdRZaFOmYpnNZZre1Uay7nDV9KGGJgfw1oB60tC6KMuheK6QaUyml0FB2QDkQ8vDoFmb7a6dL7X4uhkK8w/vTx0gEb2ojpz4CJCQnJ7xq+6pQRBq5HgZvC2S/uXTnxi12Aku/mOor8XOK9vgx6YwiuG78RzIspGDokhuSl86Q3S84LDcgakehmJgmTBAL3e/cZwiREjGkCvlR0pFgBogNkximnHVWadA2XTiF3wSJ2TeoaHtufoElq4zt4iooLIJmsC9XDfaX/Qr2LicPWRhB11Ol1C3ttBuKvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM5Ja1Gh0i0M1yhy5veSRoL+pqwMRG/OsW8QPPQa/HY=;
 b=ZyYX4X9tCIJTulLrutHiG0cEk37eJPbHCOOjY2R5fA+BIAdISUlHAdTuvOyju0F4scjzfOVnZ+Iv2/wLCTwuWhKvbaVUomhLY+RHvzbaxl59B9jPSeCj/GyIBCXB9agFZCg4lehz0D6IYXlwqZqjXy0fbdmL1x4GRXNzsWKfj8M55IkPQ2kaN2ErvnMtiFgB8ul0EiiJpwHKlS4um8RJOrtA4qgQtUsJiwqFjl/+rCYA7sacwTgocq/eUZJGmrFeIMqzCPzBCX1Ye81RASwL/nOuONsLTQN1CaqOnfc4ZwBt2U68uRzLRq8G+ACz7Yr3oBZoqIVRdJ313pomGoEr4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM5Ja1Gh0i0M1yhy5veSRoL+pqwMRG/OsW8QPPQa/HY=;
 b=HBkS/WCTMHL48rX3HF+56BQVqlxfQFtZCFUo+1W56P5wSwt+2mN+o9oPGd99odNq8PSo3H8zTNARwpqtgLH68ou7cf7vKt3L520ILDrHeyiTPwNdIvdVDOaLxoX8txT9RAA9ldJec8KaSrRmo89NHzeJP5Xz7XZYsg2yqQAdDHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB7815.eurprd04.prod.outlook.com (2603:10a6:20b:28a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 09:00:27 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 09:00:27 +0000
Message-ID: <be4cde3b-4565-48b8-9e12-40a874c89bc1@cherry.de>
Date: Thu, 25 Jun 2026 11:00:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] rockchip: rk3568: Add support for LinkEase EasePi R1
To: Liangbin Lian <jjm2473@gmail.com>
Cc: u-boot@lists.denx.de
References: <20260512091532.97256-1-jjm2473@gmail.com>
 <20260512091532.97256-2-jjm2473@gmail.com>
 <b2b25f9e-336e-419f-b2a0-e5942df246af@cherry.de>
 <CAP_9mL409bOVu1kg-y07ZxNpfdb--g8A1T2hUbRUetXfeMF81w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAP_9mL409bOVu1kg-y07ZxNpfdb--g8A1T2hUbRUetXfeMF81w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VIUP296CA0168.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35d::11) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4c20aa-8649-4275-3c46-08ded2983392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|18002099003|22082099003|4133799003|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: ZqYWJaaDHVxIa0Melg3/p/rJagKRe7O6gZOHnu+cU9BAEVVXOw3GMOyH11mDspD8yapEK1gXvet5XHsrYMDMs3/TvXHeY8qr1GiF2PtEbGoVeGrKFzgKcnLSCoRB64h0Mm2nxwvc+bpwXQZDjhsGKt9cDsVUFvsyqMUSw7uWofaOhAwuPvLgTGMYrw/p6y4ebchgmEg6/dYMqxYOPkt5zKWRzMuzffAROU5hkjNj+mx69xwmMKoV4YCZh946METp2FtL/Y2CmNDwE9x8b+dQKiwLjSpSeO/ESei6ix4SUOPjws+c1d2m81MvwHRtHef6lKE3sQOQgtE3wH2ufZk6Rr5XoDn2r3NeB7x3algsk/mRqfXjRNiTJcv0PklejT7keEGh2s+Lr5A7fLVnDm+HVs2O0LYSz7wPHtWhxVlHt7o2wGhrW/431CSO99/GYpx5sNGKRQBfz6QtTooFpV//wNUuJL3BikJIsGt4x80UpmFR3scNHJ70MsqUeg4hMeKX7jFz7MrfxZBBxUEKf/KjoGMYAH73Yc67D8yCj+kzxOEo6IqQjcp32psboVm9LxcvxtRxomj796jHXd6lEpdjOoWgeIeoX0fyb5DQa/TjjNpqPy22VohQPoRrIBwjXsHdk+6917KM6P832QSc7AndsWE6dmRbID2gBzGhHHjR5QQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(18002099003)(22082099003)(4133799003)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVhpcGJ0ZHl4QnA1dWluK1dRUjRDSDRQTktlWm1HRXRrck96NE1qelRHa2ND?=
 =?utf-8?B?enNXcEFRc1o2UW5rWE1yaTE2TzU4Tk1xQUxuNmtKR2dyblcwYVl2bmFVMGor?=
 =?utf-8?B?cnBaWG83MXJ5Q1pmOGZrOEhLRHNzYk1YTkJKYmNENlZManh6Uzk0OTJmR2VZ?=
 =?utf-8?B?OHR3aDNWbzdUWGlJZSt2UStaTi9wbHJHNGxyQVIxL2FkM0RkdFN0S2tHeHo1?=
 =?utf-8?B?V0pPOUcyR3dvMCtLNHczR3hRRWhZaGtrWUtPR1k1NEI2dHNoS0VKRVlVbDdm?=
 =?utf-8?B?R1c2Qk82SEw1UmdMdEEwZ2hwamtzNWM4RXAyNytCZVFSMGs1eDRXd2l0aFpt?=
 =?utf-8?B?NlVWREpuYzQzVDdPaU91aW05aUVoN2x3c2M3Ui8vWHIyYjI4V2d1ajNETkdO?=
 =?utf-8?B?dFpCdEcxNzBNVjg0T0FNTmZENng4bHFSSFIyMFZaMlBrVGZLUEtocVI5L2lD?=
 =?utf-8?B?ZWtPUjNWcFM0MTZSWVgvNGxNdmdETXVIM1RvOXR5Ri95MTRxeWlqdENGRXJq?=
 =?utf-8?B?dEFCWVBpUHRTb0ZwcjEvaE5NWEUyQktuUjhnZUh5K3dPS29vL3JYTnUvOEt1?=
 =?utf-8?B?OGNoK0RBTk9DbFlTS0lOOWhSNEpGdnhJdlBFSkdRY241Ymt5UFNsRmVEWURo?=
 =?utf-8?B?aS9jaUZnR0dwK3lJRE1zaHdBK0ZTRXk4UWtkV0ZoWDdvc1ZjUkNRTzFrOEdV?=
 =?utf-8?B?ZmExRlFIbUl3YytoMnU5TUNGOGVtTjV4YXNEckRDRmFXZ3lIdlFzQTEzcnR2?=
 =?utf-8?B?OVVXQ2NOWGhvamVyeDNheFVXcU1HMW4zKzVFNXVKTncyWmF3ZzR5UG0vNXNU?=
 =?utf-8?B?bnRSZGFTeE1ESGRlVWgxNUt3Ym1USUV2WllaQndrWGNBVzdyeFE3WkE5Qkpy?=
 =?utf-8?B?Y2txT3NPTHJENTJTcDZWcEZFT3REUHIrQkJyVnZPWWtVMzNYTTY2a3FHV2lr?=
 =?utf-8?B?c3ZEQkFvK0lqWGYwVnFYRFdSZk5iNnZVR0NyUWhMWStFNTFLUW1oU2VvWVd3?=
 =?utf-8?B?bm5ySzFwNkdQUzlBZm1iaG95dm9QYU90WVkybGxkenB2N0xKSVZRV2FNbG1D?=
 =?utf-8?B?d292L1Q2RmlUbWF3ZzdhSU5oa25sdkJva1N1TXB1bFBNWGVJMENFLzRBbVlO?=
 =?utf-8?B?Q2lHT1U0U0kwYkFSVG5BdTlmRkxVMDUxdzlkU3p6MVk3ZFJJUTFMRGo2aVJt?=
 =?utf-8?B?N3BlRDJpYk5kTDM2b0xMcnhSSERjYjhOM1U0MlUxbGhYTXg3RUVPWXlkUXBp?=
 =?utf-8?B?K1BHdFo2M0pYODd3WGNJeFk0QU16K2NUVUJJL1BUbk1yTk5USW9PWGV0MzdG?=
 =?utf-8?B?Vi9UbnNvcW9JUEoveksyRXVPOFdjd3AzcGIxYW92dmYxTm8rbzZ5ZTcxVGFj?=
 =?utf-8?B?R3kyMlR3b1FJTkI0M3RmTVNLUlR6QVNuYjhkRDdCakVaSzRId1pITDZyYm96?=
 =?utf-8?B?cHkxUEtXUnExSFlwcFQ5clcxZjhLZkVvQSt3MFNIZ2p6YjMrSHpzaWsvZXBu?=
 =?utf-8?B?WnBLWGVUbUxtaGwvUWhnUTVYTlhuQWJqTWpZelljYVVqSkVjeHp5YVVCL0FY?=
 =?utf-8?B?dmwvMzBmbkVHWUZhNEQxV2tybEtXUUY4VDNlbXUxTlZ3SDFNSUUzeklxWEln?=
 =?utf-8?B?aDBpT2JPUXZMMWhSRmJTWDZNRTM2cjM5eVIyTVk3aXhDTGRwMUFiMkc1eDJw?=
 =?utf-8?B?TmdhS1hKb0hxK3BiM09OczdBTFZsaDFzY0pWOThpOXBnTEprNGljbE5BS1kr?=
 =?utf-8?B?RStPOUl3ak5nY0E2WTFaUzRWRWVldnY5MHJwMVlOMWQ3S0ZNZGx1TkR1T0Qr?=
 =?utf-8?B?Z2dHVTQxcWV2S3kvV0wxbWtBYnhsMGZmUDg4dTh5WXhBVzBDMS9UM0NZeHFh?=
 =?utf-8?B?VzZxc1pMNzNNRUFUUHFoSE9Jd2h6S0V6RTZIUzR3VDlzbURnL2FEQVdmVWxi?=
 =?utf-8?B?enRrbWpOcXQ1b0gzSnVKVUR5MVd1eDFaRnJkQlllNUQvZHA3bTVoL3RKMWJw?=
 =?utf-8?B?OTFSTWZYck56ZVNJMWtOVW5JU3lQWXhPYzFldTZrbEJmQm5UcWVyclByOWJr?=
 =?utf-8?B?ZVJvK1hVTThYVTVXeVNsUWttOEpPT0RaMHZlaU9VYkpHRVFnbVdwdFl6NGhO?=
 =?utf-8?B?d25kMitFVXF4SjVVSkwxVWIrTHp6ajhvbWkrc3YwbEVFRUxvbkxrQlhNQjNw?=
 =?utf-8?B?aVcwK01MYXBkSmtILzRqT3dYLyt6ejlLYUljb1hYWFJyZW1yWSs3Rk14YUFF?=
 =?utf-8?B?Q0xZTWl5cVBFb1JZNnZvTmQrMEN5Z3lZRjg5UHYyL2lXbnZRL3FBdU42eEE3?=
 =?utf-8?B?Y0dLYWZpQk5tODF4UVRPTzM0TEtqb21zV1cxMS9lWU5PdDVlbW1ldz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4c20aa-8649-4275-3c46-08ded2983392
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 09:00:27.6775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKOmqaaKhnFltWUsuGBkkcrBG9vrg/RTB8+yf5FdIb+r8A402QlYnuKrzLHa5qN+zOymsXH7YUZpoWIHV6tt6W/tuT28RGUbaZANMCxAei8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7815
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

Hi,

On 6/25/26 10:36 AM, Liangbin Lian wrote:
> Hi Quentin,
> 
>>> +CONFIG_LEGACY_IMAGE_FORMAT=y
>>
>> Do you really need this?
> 
> I found `mkimage -A $INITRD_ARCH -O linux -T ramdisk -C gzip -n
> uInitrd -d $2 $tempname` in the Armbian code [1], so
> `CONFIG_LEGACY_IMAGE_FORMAT=y` should still be needed, right?
> 
> [1] https://github.com/armbian/build/blob/main/packages/bsp/common/etc/initramfs/post-update.d/99-uboot
> 

Seems you could be right since they add it for a couple of boards 
defconfigs via patches, c.f. 
patch/u-boot/u-boot-genio/0003-GENIO-configs-genio-350-720-evk-Enable-LEGACY_IMAGE_.patch 
and patch/u-boot/u-boot-tqma/0005-add-LEGACY_IMAGE_FORMAT.patch.

So I guess it's "fine" (although you won't be able to do a proper secure 
boot with this enabled). So you can keep it in.

Thanks for the pointer!

Cheers,
Quentin
