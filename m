Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7719CC8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 15:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB6782F4E;
	Fri,  4 Jul 2025 17:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cern.ch header.i=@cern.ch header.b="lBF+7Juw";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="lBF+7Juw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D86E8277D; Fri,  4 Jul 2025 15:46:58 +0200 (CEST)
Received: from ZRZP278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c213::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B33F8806D8
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 15:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pieter.van.trappen@cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7ilmF1+Blu+UhS7Fr/Wz+vZEnwIlxovRg07QwEKzF7lstmaa/CoSXd3RrOyWdOIrU3TxoW2Teah4IHp8WpGVdpVem1S0r5/gd98Iq9FTOkHp6Bsa7Zx+OSTzBLtijUfuULmwm+E5zPwsBfbLBdk2RMHOnPvieOXWbKf5CnZCaY3xFaIPgMAh/OKJv20Iw6iuJlvExaYoYlRora13Yyo883fMxOl3gk/QAoDMF4e7u9GTfcuYSK3zXhYGA13JP9mDC9S062iVhgmm6dki470Rv+5IODIKoytRPKIBuOF6lpxesaQyLqfip7ohSVTvvC5J7cm7u2n82KE81dyuVrClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1A/u+wujCNUqTcK6XC9ZPF0mGOVXU4ClHtOwBDOWc8=;
 b=MHNV+a8bMw+2NEufKmvZHa/IqowZ/KGKxrplTF2miSxI6F/uhTChJZ+5RRWhHwlrmqwJyYa2X3tJwaJ6tvXNfhYkwtnjodARO+zS+e0kqGjrYaC4CNJSQHfqd2rUm7S8b5aZlT/LgsONEb2+78NM0gcOgkfvnKJIkDgb1wyWkIecEskrbQZsRnaapTiW+KMgtaUfjJJy3mUqcYl0e0clF88wd1fNTLCL4AEzT1qsxYeqmn7jGXVcyXlensfSsG5gjvMMbbWPJYKT00Pc3DLpLl83RzsUI9amxnBswAhfuiuTeCrKL9Dy8Z9XbpHIOTz94VZ6THRbLx/zsvbXoXpmxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=amd.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1A/u+wujCNUqTcK6XC9ZPF0mGOVXU4ClHtOwBDOWc8=;
 b=lBF+7Juwi7wIH+JfGGGZp1E1MHDohSILd9BsBXcOMCFBbuSw9ATdwfur0WowmgQgtqmKPaw8U2VtQHoayynZcAASgR6Qug2XlcsK0YEalHih/cBA7W8KQjzxhrMADmWLVhhCYtEg18ZYVwz52Rrj0LgBiTaXIvO5/N+V/1VQ2Xc=
Received: from DU7P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::25)
 by ZRH2PFD2378DF59.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::226) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 13:46:49 +0000
Received: from DB1PEPF0003922E.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::f0) by DU7P191CA0017.outlook.office365.com
 (2603:10a6:10:54e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 13:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 DB1PEPF0003922E.mail.protection.outlook.com (10.167.8.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Fri, 4 Jul 2025 13:46:48 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com; dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch
 header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=lBF+7Juw
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17010000.outbound.protection.outlook.com
 [40.93.85.0])
 by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id 58386FC217;
 Fri, 04 Jul 2025 15:46:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1A/u+wujCNUqTcK6XC9ZPF0mGOVXU4ClHtOwBDOWc8=;
 b=lBF+7Juwi7wIH+JfGGGZp1E1MHDohSILd9BsBXcOMCFBbuSw9ATdwfur0WowmgQgtqmKPaw8U2VtQHoayynZcAASgR6Qug2XlcsK0YEalHih/cBA7W8KQjzxhrMADmWLVhhCYtEg18ZYVwz52Rrj0LgBiTaXIvO5/N+V/1VQ2Xc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::14)
 by ZR1PPFB275FCB1C.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 13:46:45 +0000
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8]) by ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8%5]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 13:46:45 +0000
Message-ID: <07e981b2-8d8d-4296-891d-68c1d9e3d22c@cern.ch>
Date: Fri, 4 Jul 2025 15:46:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] Improve user feedback in case of FPGA bitstream
 load failure
To: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Cc: vtpieter@gmail.com, u-boot@lists.denx.de
References: <20250626093519.115655-1-vtpieter@gmail.com>
 <20250626093519.115655-2-vtpieter@gmail.com>
 <6e88abac-88fd-4b65-abff-bb36c2e7203c@amd.com>
 <0a6df085-d0f6-4274-8f47-2ef291aada32@cern.ch>
 <86a735fc-3281-4b43-94ea-a8bc8cf72b0c@amd.com>
 <20250704133457.GE6424@bill-the-cat>
Content-Language: en-US, fr
From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
In-Reply-To: <20250704133457.GE6424@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0302CA0002.eurprd03.prod.outlook.com
 (2603:10a6:205:2::15) To ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:4f::14)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: ZR0P278MB0759:EE_|ZR1PPFB275FCB1C:EE_|DB1PEPF0003922E:EE_|ZRH2PFD2378DF59:EE_
X-MS-Office365-Filtering-Correlation-Id: a36f8b2a-aaa5-4d08-6471-08ddbb013911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|19092799006; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?R3lBTGdOVVFNRzV6YWY5ODlyZi80dStwcUZxVGt1VERheGl5T29DRmZIdDU0?=
 =?utf-8?B?d0pPS0Q5MURCR25CYzA3VmNUYjA5M3hsTTZ4VmkxYlB2SlA3QnhoaFNKUFAz?=
 =?utf-8?B?UFN3aVhVb2gybDgwUWI2TEgxSzR3UVBVUFQvU1crNVZIOHB5UG5uNFp4eWtG?=
 =?utf-8?B?cVUyK1lkMkVLSFJvN2taNW5rZnQ5ZDUyYU1FektCb2NKN1Y3RFZHbE9OWk9x?=
 =?utf-8?B?aW5rdDJJUWIzZEZ5QUxHNk9OcHlrVUhGT0lUenJYT1AvOEdXOVo4MUtqRjU3?=
 =?utf-8?B?WTAwajZUUmg0TTQ3WFdyTmd1Qndwa1JaVHZ3M3ozbjZqUW82RTEzZnRqRmhm?=
 =?utf-8?B?WnVsUEY5VlRCbTRtK3BIeWhCdndaaWZ6RGVuU0NOdXRRRUsyMUtGN2VzcDYy?=
 =?utf-8?B?WVVmUmdRajNIM2ViVFBMdHBFZTNxZGdDcWF5K1lhbWkzU2QwWTk5aERqcGY5?=
 =?utf-8?B?MW1DcEdZd0Z0NFRib2JOSDNnTTJ0VXp1MGVLbXNjdHlhZW43L01qcFlsUzgx?=
 =?utf-8?B?a1U2THV0aHNKa2d2K3BERit5Tnl3c2piZnN1bml4VG5yTm00UEpIRkNZenpk?=
 =?utf-8?B?UHQvbWIwbWxsOFUwT3MwNGlSdlIyazdEMS9QMkQyWVdzaHFWOG5PbTF0dkc0?=
 =?utf-8?B?YXBGV0RpbmUxVFRnbEpHWmpPTm1tUTlRTGdFblRvQzlxQUFXdkJuTXo0TDAv?=
 =?utf-8?B?QWVuS0VXNE5kbGtHeW52YklQdnpUMW55bkNuSDVmTXNEQ05qRTR6SkQwZzdi?=
 =?utf-8?B?NnNJTm41TnM3anVoc1p3NzVOcTc3WmdMMWk5dmh1RVRmYW5NaWpBZktYMlZp?=
 =?utf-8?B?eXdLVzc3TnJJVHhaWjNSTHppYndINDdmeFVMM2V4L1hacVFDRlV2MzNYY0Q0?=
 =?utf-8?B?MUNIRENIaVlEOEdNYXluSUVqSXQ5ZEpDbnhuVlE0WElhd0IxSzZTc0FSZFBW?=
 =?utf-8?B?NTRHSitiV2lneVBabFRxRnZuNThPTDYzR002cW85N2pZTW56MUpCOCtsTGZ0?=
 =?utf-8?B?a0ZUQlRoUGJUb0hkbk5ZclR2QVhicnZ5eWREbTdQQnAwTzdvNnRjK3g4Ujdp?=
 =?utf-8?B?TWwybzIydERUY3NvcXJodG1qNlMvTTNoQ3crQXNDV3loaThMdUo0TGxWSzF1?=
 =?utf-8?B?bnIwQTdjOXcwVlNJTjZBbWlXT2QyMi9rZjBRWTE4RHFyTGJ5TGtjOGcrNEJ5?=
 =?utf-8?B?TjFHVmw2ZTJvbXhqaGZjL2ZIb3B4bkN4WFZWcExDUVQxaFVTZ2RuNkRpSlR1?=
 =?utf-8?B?ZDdCNi81VlJVMHJaTWNiSG1vRkl3d1lBOW94UDlldkhRUllEQXFOaFVDYlBp?=
 =?utf-8?B?N3NiY3FQZmpXd1pCSW5pZ09veThIeG1jcDA0bEJwY3h3blJmVktkbVBpamUv?=
 =?utf-8?B?MGduMXNwQXRuYXlUTDF0V0lnT1NGakU0Rm9PZWZ4aHdEdDdjcTYwZHZZaXZV?=
 =?utf-8?B?bVNMS3BWQ3hOKzQrSDBDeXFCQ01yLzNZbjRkSEcyMVZ3U2lVTFJ6MWtHTlFy?=
 =?utf-8?B?dE82UW0vZERySjVrRFBOVWlPeUNsUlgxenlGNnpOMW16MzFGREhXWU9XbE5G?=
 =?utf-8?B?OTc0eUsyOXdwS1BlM3hOSGdFQXRuQS9RVDhhN0JJZStLUzBXTERBckUwLzcx?=
 =?utf-8?B?UE5LQlhmSlRVc1FOVFA4b3RxUWtCM3lhQXY5cW1tZXJmbjNXa2dTdUxJQXQ0?=
 =?utf-8?B?RWx6QklNdUlNb000anYrVEVPZWtReEM4M2lNOG9ETERRa0xtS2p0WXlFUWhw?=
 =?utf-8?B?ZFRUallOQW1BOGdiTmFGZlMwZ1hCdXlzQ3kvWFVySHh6NVVXSFlwUlpNRG5E?=
 =?utf-8?B?SlpKN2h4OTY0UXJ6UHB5T3VRMFJzQ3FQTU5tZm5zLzBJQVBSU2RSUzcwcXlp?=
 =?utf-8?B?cnh4cnNmTkpHV2dyb3hzTVJvYnZPTGxjUkEwWEJHMlRTN3p5NUhUVGxlZ0o0?=
 =?utf-8?Q?1SuXXvmReGc=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM; PTR:;
 CAT:NONE; SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(19092799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1PPFB275FCB1C
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 75c9798d-7805-472f-8b87-08ddbb01373b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|36860700013|1800799024|19092799006|35042699022|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlprS3RnLzVzdnhyL2VlR2hZL0JkRUI5UHVpUEt4TGFUdmRlaXFBelpRTFhR?=
 =?utf-8?B?N0xVajd4WTljRmpJYUErenZrOE5ZemE2dnp4YjFYSCtwVURjZ1k3NjJZZll2?=
 =?utf-8?B?NENubXBqTzM0WGFSSFJic1ZHS0RWclpJQmF2TERKVEhsRFhGQXQ0NUVsRUx6?=
 =?utf-8?B?ZTVVK0w3bWpOdFNMdmZoeTVMYnNJbzU2aEdtRFZlOWt5ZjJ1cUgyV2ZJL3BK?=
 =?utf-8?B?aC9oYk55KzlJTi9NS0RBTnlKTUpRZXlKbENPVlRqRmJwWDhEYTJPMFo4bmdF?=
 =?utf-8?B?bXp5QlhqMCs1VXFyNVFYYnVKbkREV1d1RjdmU1pTcDRRdXJVcHZLWm9VcWlx?=
 =?utf-8?B?dXFUTGpXVE9Pdkp3dzN0TEJRamJXa0ZoRHNOV1lNQ2UrK05GSnFMNDQ5UEpH?=
 =?utf-8?B?ZkhwcTBXZ3ladGZEbTZtN25mSnd3R2lyTEdJUnN5cHNlSTR2RFFTMXByN2xt?=
 =?utf-8?B?amFyMEhCVGtMZmcyb3ljeWtTY2FmNmJnRlhxNllMMnFlYjRMckY2enJzMjhJ?=
 =?utf-8?B?S3RxWWRrMCtkTDByemp5bHhsa1BEaERoSTF2V3ZSaFhGUnYwUU4vdUgrN3F0?=
 =?utf-8?B?Njc0ZU9kZi9lTzQyTi91dkpNRGMwWVFNbjM5Q1hnbTQ4SEVMWU5GV2ZWb1dM?=
 =?utf-8?B?bVVqZzhsZFA5NXpsWmkycWk1SmlvM0xxRzhXVGtFV3VrYWQyd25pV0czNk93?=
 =?utf-8?B?ajdEZWJvcFZwNW5MSHBRTW00RUh2Q0V6T3NtQmZ4K1BTdlR0Sng4R1Y4Slkx?=
 =?utf-8?B?RGgvZ2tDNUZkMUpYaTdzRFJqcEswalZkT2cvMmxZUWRQZzgrQWxiOE1tKzVj?=
 =?utf-8?B?aDBsMHRnN2tsWlkvT0g5dk9EQWhOUkQ0Tm1UZ0J0aytnR0E4R2JoQ0syWlVr?=
 =?utf-8?B?UGJLMmErTHZzdnZsK2hLQjl1ZXFPRGNIMUlvcE1GZG92Z1htd3Zta3NQM29w?=
 =?utf-8?B?dWp5UHZ2c0tFbVpPUXZGSVJ6VUtvTDFlZHFRcHl1Y01HLzFsNUZKTDJqL2xI?=
 =?utf-8?B?bnVYeFBhQm11VXRqZTR5T2JFOGtLVjVGZkY2amp6TC9xd2V3WERod1VKZUxQ?=
 =?utf-8?B?bUR0aUN5dFVRd0E2cjhJQVFyZjR0bE1zejBNS2VISTJ4blc3TGpjN1dkREhC?=
 =?utf-8?B?cjY2bzJWUnAzbi9LWFFxMEdUVlNBYkU4WlBGNm5mRHB4NWRHWGlmVmI3QTk2?=
 =?utf-8?B?L2xNUWhSVUlyU2xtU1lJSW1uaER5L01rdHloVW5RVmwzSmVTSUU5Q3dha1JS?=
 =?utf-8?B?UGt0dHFaa05qV2NqVkRJUFBKeGF3V2NEZGduU1dZeEMvZGtqQVA0OHA2STJN?=
 =?utf-8?B?OUt5cW1oU2FnZVBldlJLaWRHTFNYRDVaK3dhRUE2RWhPMllCaG5xdVR4TE5k?=
 =?utf-8?B?bmlZczcvazRhZWFuY0lyYVBZd01KdlJTMm9FdW8ya1hycGI0K21yNGxCUDZx?=
 =?utf-8?B?V25XOFFIK1VUL09ZTjNwR1FxamNiZk56ODIzckl3ZXA0Rk43VCtxK1B1WFVt?=
 =?utf-8?B?Y2x5d251ekw0YTAzSnMvUmhjM2Mrb05pSXNxNGk5MUgvVXNGdkxnbTZTNmFJ?=
 =?utf-8?B?UzZlbndVUXE4OXgyaEU1RU1uSUhQLzhINWRjRWswV3BpWmNXY1Q1aTBnWWlu?=
 =?utf-8?B?Y0E3Mzl1SE1kaldXVWdPT1VsWTE2c3REdERKbXRQNkdMeFA2WkpYSEFheUNt?=
 =?utf-8?B?V3BYVHYvanJrU0JzckpYZC9XSmFBK3hJelBiVnFXR0pXeDZEZUpzL01sKzBP?=
 =?utf-8?B?bEFpVU1uaXJEdWVBSDFtaTU5WGx2Z1ZKeVRGUTdkM2pSaVV6U0VrY1Y5SUo5?=
 =?utf-8?B?SUpPM3JRMS9HRnQ4SmV0d1BpR3BGOU0zWlB5L1ZUMUlBeHpPanRsNklrMWNR?=
 =?utf-8?B?N1JpTTBzMUlobXNpZEJxODgxSSt3TUZqVW42ZkNOanovVXM4TTFramVKYVhL?=
 =?utf-8?B?QlRISDlUUzNubUd2YmkzVUFGclgxMDQzUlRvSlFsZWs4cEJzRWlaUzQ3dDM3?=
 =?utf-8?B?VkR3cUJveG9OdTlZS0hSdnhJMHVodUloWVYrb1BWSG5Uci9NbnZIb1NBT0Jl?=
 =?utf-8?Q?G/fQiM?=
X-Forefront-Antispam-Report: CIP:51.103.219.121; CTRY:CH; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mx1.crn.activeguard.cloud; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(36860700013)(1800799024)(19092799006)(35042699022)(376014);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 13:46:48.2301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a36f8b2a-aaa5-4d08-6471-08ddbb013911
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19; Ip=[51.103.219.121];
 Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRH2PFD2378DF59
X-Mailman-Approved-At: Fri, 04 Jul 2025 17:56:46 +0200
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

On 04/07/2025 15:34, Tom Rini wrote:
> On Fri, Jul 04, 2025 at 03:21:08PM +0200, Michal Simek wrote:
>>
>>
>> On 7/4/25 14:38, Pieter Van Trappen wrote:
>>> On 02/07/2025 10:51, Michal Simek wrote:
>>>> On 6/26/25 11:35, vtpieter@gmail.com wrote:
>>>>> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
>>>>>
>>>>> In cmd/fpga.c, change some `debug` calls to `log_err` for important
>>>>> user feedback and use CMD_RET_FAILURE in favor of CMD_RET_USAGE due to
>>>>> its long output which hides the actual, useful return message. Change
>>>>> the remaining `debug` calls to `log_debug`. Remove all 'fpga:' and
>>>>> __func__ strings as `log_*` has this covered.
>>>>>
>>>>> For `do_fpga_loads`, move up the `do_fpga_check_params` call for more
>>>>> consistent command output; use a constant instead of multiple '5' use.
>>>>>
>>>>> In drivers/fpga/zynq*.c, change 'up to' to 'above' which corrects this
>>>>> confusing/wrong statement.
>>>>>
>>>>> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
>>>>> ---
>>>>>    cmd/fpga.c              | 99 +++++++++++++++++++++--------------------
>>>>>    drivers/fpga/zynqmppl.c |  4 +-
>>>>>    drivers/fpga/zynqpl.c   |  4 +-
>>>>>    3 files changed, 54 insertions(+), 53 deletions(-)
>>>>
>>>> I would be the best if you can create also cover letter.
>>>> But let me reply to this patch but issue is likely related to
>>>> others. I am also not in CC on 3/4.
>>>
>>> Hi Michal, well there's a cover letter (v3 0/4) but it's only been sent
>>> to the mailing list cause for the actual patches I use the
>>> get_maintainer.pl script (only). Probably also the reason why the 3/4
>>> patch, amending the sandbox_defconfig, didn't reach you. I'll make sure
>>> all v4 patches are sent to you.
>>>
>>>> Anyway CI is failing with
>>>> $ tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e
>>>> -- board ${TEST_PY_BD} ${OVERRIDE}
>>>> Building current source for 1 boards (1 thread, 64 jobs per thread)
>>>>      sandbox:  +   sandbox
>>>> +drivers/fpga/fpga.c:23:13: error: ‘fpga_no_sup’ defined but not
>>>> used [- Werror=unused-function]
>>>> +   23 | static void fpga_no_sup(char *fn, char *msg)
>>>> +      |             ^~~~~~~~~~~
>>>> +cc1: all warnings being treated as errors
>>>> +make[3]: *** [scripts/Makefile.build:249: drivers/fpga/fpga.o] Error 1
>>>> +make[2]: *** [scripts/Makefile.build:388: drivers/fpga] Error 2
>>>> +make[1]: *** [Makefile:1930: drivers] Error 2
>>>>
>>>> which should be fixed.
>>>
>>> OK I can fix this. Where does this CI job run? Also do you know if there
>>> a reason why not all -Werror options are on by default in the Makefile
>>> (KBUILD_CFLAGS) while they are on for the CI?
>>
>> As far as I know we have two pipelines. One in Azure and another via gitlab.
>> I do use gitlab one as the part of source.denx.de.
>>
>> I can't see any platform which has WERROR enabled by default.
>>
>> M
>>
>>   30 config WERROR
>>   31         bool "Compile U-Boot with warnings as errors"
>>   32         help
>>   33           A U-Boot build should not cause any compiler warnings, and this
>>   34           enables the '-Werror' flag to enforce that rule.
>>   35
>>   36           However, if you have a new (or very old) compiler or linker with odd
>>   37           and unusual warnings, or you have some architecture with problems,
>>   38           you may need to disable this config option in order to
>>   39           successfully build U-Boot.
>>
> 
> We've had -Werror being passed in CI, via buildman for basically
> forever, but only recently added the WERROR Kconfig option to make it
> easier for the non-buildman flow to also use it.

Thanks for the explanation, that helps understanding the difference 
between the Makefile and `buildman -E` used with CI, in addition to the 
WERROR help section. To me, and for the sake of other first 
contributors, it would make sense to switch Werror on by default but 
this has a larger impact and would probably break other workflows.

Cheers, Pieter
