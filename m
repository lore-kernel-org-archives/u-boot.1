Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D025BD41D61
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 16:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61CD7830E4;
	Thu, 11 Dec 2025 17:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="VHdnPXk9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="tc58sLB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FDAB8367F; Thu, 11 Dec 2025 17:07:59 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B848309A
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=R4I4Hk+UA53VVi1fscZT0gmnjyaMrpL/osGUaPZQvqBHHBoiiQuu9/NpHyZPto8b32EntNZzkutPLTsAdTj7x58d4raSEbZN65rygfInKm8r0qd3rgfKTqgfNlwA5xS+cdrxqcUtDKxIJ4BVvZ2f7tkFbdV8amRZ6M4uzuSWDxP59DxfMxw8iN1Br5Py8nm8ab/GuUkdy+zovDqhA+1NZTfjkaP7N90jjV8PHhK5HSN+v+s31AI+rNpSr7RIsHIoTVtdlocmMYNjsVYjJn3ML+QLGGsB9t4DlxEBsF2tgnLsYcxaP0ZzZqxWDQ+cSQe3Cr2Kd658WBF+VZXN9HEWVQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xaQbEjxnYjM0j2j7RpzztVFITSXgdQKAsxLxWXR8TQ=;
 b=Zvw5xsZioBhlCvj0S7iA5YY0tHCe8eYq7ZtIzBExjEIrI1wQOoMp2ZB8Lx/v1M4Mf/O5URXqHsasKG3behNVGAR8NGnBhKZ3HMovbYDeV1xZUZca/opZRPqXSTEUMLdYJGgYWk9KA2wMp/piJ12zS0jp4ZSjDSfgTqeU7+qwnKWwYZUZz/7hTw3kzUqiiT4dBhCzQyxEHuWGWDicbbUq/UAlU15+L2LDowHHc7tvknYwuL2xZnYOOx9ciJr7blAN6rkkr/8AJ5RanVh6q3sdyol/iBUmXuN8/2QJrsAK+cHbo7n0gmA58iOKqodWpuBHDnf1BWlHsutMPikWMfD04Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.82) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xaQbEjxnYjM0j2j7RpzztVFITSXgdQKAsxLxWXR8TQ=;
 b=VHdnPXk9XyV7TYaxqtaFf9rFaMxHiXtaY7VQbFpZUbzAg+FkaJRmchntzkM1+Nr/OuC3aq675kUPhwjUeSfrHW+uOST3qPxrYTIIka26woMJhEqjD/hi+XJ6Xvk9ToZOsdqy7yS/NKQjNBCi7nrourW3em5JCitakH+J0PueC0chwN9Z23rrDsK4tBpjmbh0rvFv7dHzvUr7qcya01LPRKiyEjpBIEPAeEzspeU2QybsHtEaEUWFoDyB4hB1mY536jEQ4g6C+bpo1E86eMSI2BXYtSjFG56AJH+NsoiubgifAWJdBXPEDkgB2RhKfJiStVIzaswz0UBAeSGXLOuP6g==
Received: from AS4P195CA0001.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::8)
 by DB9PR03MB7193.eurprd03.prod.outlook.com (2603:10a6:10:227::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 16:07:54 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::3e) by AS4P195CA0001.outlook.office365.com
 (2603:10a6:20b:5e2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Thu,
 11 Dec 2025 16:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.82)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.82 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.82; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.82) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Thu, 11 Dec 2025 16:07:54 +0000
Received: from outmta (unknown [192.168.82.144])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 DEDAC20080EBF; Thu, 11 Dec 2025 16:07:53 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (unknown
 [40.107.159.118])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id F041020081245; 
 Thu, 11 Dec 2025 16:07:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViH9ReP5gZx8nGXtSTE9DVOYO+ao85q9YZCftZr+82H9tSnEjDlC89rTQlN9rZCjy8E9lsruwR4a6K4QGT0FzkJipKpaeXFgPppwVNLL+nWrVSxVY7Pu70H06u3Y13/EgoQI5lae07ylP4wTaif7Ck2kqFOULswx5h7DJiNHVdPaKKKRAkGdTkFUmLa8N/ccNgYF39LbVBCM6ILacAL/jbdboaem/lqTemjebKbbRtI3N5tiy26dVgs3u2VjQUWIkq7QIlOKEk1MrF3457X4yq5y7aun2u5JaARbUnl5eAnOXoiOibpo+nZ18sVSxpCAigBOdLwOyFgTQYAIxsrLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kgdakXZxmFY/dl02FnwROf99i2/4wJlbOi7yh1WQ3Q=;
 b=MHk/Dpae7P/jVsyY3uETRSJw/0iFcBnfQIx+tmFis7g6ryN5qoBFj8D1+xu576EU3g3lZoQwlOyAt7GAsLR8zAHpfXLghPisYfZV2KD2n/vLRMxt+7wEVeKgfFWWEG8ghuUFe5/rhXwwhM6AyvoPX5v3dUtTlzxPJ0+oiubf15uu2Xl+WeZapGgCt1+l8z+Cay3ccmspZsyUr9shaXOB9NvmKEiX+RjzGrh5Z4V/kCo0hDMIJKH1NFvQr+h9DrnxNNf050qb5i4IoRokYOzRSehswMKUPAlytKQMm8Ka86rfZj8+GyZqjQcSHfJBS8F91h2vfJroHUgd8qsozfAd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kgdakXZxmFY/dl02FnwROf99i2/4wJlbOi7yh1WQ3Q=;
 b=tc58sLB4iDw4/08QuF2sdAI+v4GneJOjm1fWtU7weD9bhlVyEixLGK8BWv5B0unRS6WTWdAS1tOIKUlCLTtaNODLPF0ahxOoKySvxTYbvaYkLnvqutsNVDfo6X3dovGfwxqfPuxTI3CjtuHTG7c0/bAlvl8l2epiX+gjxFDWST48eCf/tYRJDdh/lwIV+aK/fwzaaDnNoCg1kfirhH4c9SQyrCTvOMQjX8STAW5BEIgzZOB/CGsE29wukzFFOjK8iA2RDO7ii6+MvHaZ2TSI1uM/GCwN3LT2QVuRNlEdy7iWGuVcUyEoOq24SRdYH+CNGCI1aOD6THpyrEPEPOTLlQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by DU2PR03MB7862.eurprd03.prod.outlook.com (2603:10a6:10:2d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Thu, 11 Dec
 2025 16:07:49 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 16:07:49 +0000
Message-ID: <7106151d-5909-4582-a0b6-7d585f354175@seco.com>
Date: Thu, 11 Dec 2025 11:07:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: designware: Allow disabling designware driver in
 SPL
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
References: <20251211-spi-designware-spl-v2-1-4b570c82e357@linaro.org>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20251211-spi-designware-spl-v2-1-4b570c82e357@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|DU2PR03MB7862:EE_|AM2PEPF0001C717:EE_|DB9PR03MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b2e395-eb69-4c5d-b92a-08de38cf7120
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?YTVOS2NTTzNwRG9CWGFPNnRXbWZvYWxIY1BrdWtvUzZUN1l0SVJMdDE0Q0tr?=
 =?utf-8?B?VEZIWnRzVEljeUlmaGFIRjF1RGlxVHdBVjRqSkJGUDFuK2RlVlNqVWw1QlBv?=
 =?utf-8?B?Snlyci9HS3M0WWdubE1aOFU3eEV0UGdqTytabm9mVitTRjl6RHp1Mzd4U1Ra?=
 =?utf-8?B?eDlnOU8yay8zNlM0Nm5IZ2NQdnBJS0h6bUhsRnVLclJ4UXgvKzNNdWNTdHF3?=
 =?utf-8?B?OGFVTTQ1ekEwaFRLZzhMcEczTVFrcC8vejNtWjkwZEh5dFlad0U0Zi9RZmJZ?=
 =?utf-8?B?Q1JnYVpCa3IzSFZHZTZMSTNmR1VUNmgrODRhK1NzMkhNdFYwZDA1elJWOEs1?=
 =?utf-8?B?aTdTcis1QS90UlQxR0FwKzEyZXhaUnlQVCsyTHpOT1JEc0VIQW5LTFNqMVpo?=
 =?utf-8?B?c251cm9tUGVjWWJUM2JHMkZNOFBZdy9lT2hNcU54aVdCMStTaXQ0cFZnTDlP?=
 =?utf-8?B?cWdaSW8vV3Z0UkJOUjdiWk8xZUl1Y3NiODI0Z0V0Z3htOE45eGkreGlWR09m?=
 =?utf-8?B?S0NNUzhlSXRFaGxZajhiQlZGZ1pSTDVwdDJaeExVbVg1cGlCSyttZ1FteTNU?=
 =?utf-8?B?RW8zaUUzdEJIazlic2hKZVJyN0l0S0FmQTZtbGMzS1ljcE5VK0M5TmZlemVB?=
 =?utf-8?B?WGJFbDNWR0kwVm92b25vNUZib05lRldnZ2pYMmE0SVNXaWNKa2x0VVJHVTl1?=
 =?utf-8?B?c2FjUDFwUU4zU2VMNldIOVVPOUlQVGZmRHF5Yy9sd3ZKZHI0M2RyOENYMXZt?=
 =?utf-8?B?ZnhaQ0J1eiswSlZtNW9TdWgyTlBpd3R3UUNobXdiaWMxY3p3Q2FtTjBNbEZ4?=
 =?utf-8?B?dXdIUFRvV1pyT0IzY1JSMFF1cVFGYWdLUlN0enF0YXpUZVNzTERDQTJyT1hF?=
 =?utf-8?B?NXZNM2t2enptNTRaRjI2dGR3UldTZlI4WWpWQ0JkZGlOQUdGUER0UHYzWVdY?=
 =?utf-8?B?M0VwOG4yODdqdzFsOW90aGVYcEp1UCtUdUpoMWVOZ29hUlp4czJ5V1lzZmZF?=
 =?utf-8?B?V3h2eTI5MmZ6YklSanNwclh3bGdZSDZWSGo0YnhwaG1vdWVWMFNZSmtTRHdj?=
 =?utf-8?B?dXlxbi9Zc0JaTG81MnlIYnlVVkhxS2wzWUViSWwzRTg3SHd2MTZma3FzQmlG?=
 =?utf-8?B?Ukw0TldUTlh3cjd2YzgrVnhRMHVSdytWVHJYTVFwTGpHTXprcTZtM0dFWEhJ?=
 =?utf-8?B?cmMyN2pZMVgxZThxbjE0TVZ3enZtbnFzb0duczN2b2JhL3J1eTJLS3dTV3F3?=
 =?utf-8?B?R3orSzJUS2VGSnVGWGg3R0pTOWVIci8wUFhCM1UyRG8zWWpvVFBXOFZWa0xw?=
 =?utf-8?B?T3htZXdqd2N6eldoQk91anFlU2pLY3RxdnNXQlNyN1lVRFdFcUs2RmFiRDUx?=
 =?utf-8?B?NTFqdHJmMjhKTFRJL3RKOW14eWlxc2wyUnh3MTNCaUFLYVVldEFRYmhjMFRS?=
 =?utf-8?B?Z0Q2WHhiclJrTXAzRmVvaFlpcC9EMXAzNFI3Z2VHeFBTM1BOclNTVVNna1Rq?=
 =?utf-8?B?QjVOK0Z2UXJaV2JFekh3Q28zazVJSlRzUkRLeUFKV1NYcDZqd3l2bnV3ak1n?=
 =?utf-8?B?dmFpQmFXbE54N040dkphYVJ1V2hkbTBuZ2F2ZXR0elVYbWN0a2pGaTBSVDhj?=
 =?utf-8?B?b0s2dDNVNEJhZkxFQy9reE0wWE5VR3JPUEZ5QmN2L2E3NVFqcG1iL0R2R3Ey?=
 =?utf-8?B?aVZ2aHgwTGVPcFMxUzVyWkhxcVpWbytVQlRyWGt6S0VGTnQ4bzZzQlV4NHg3?=
 =?utf-8?B?MzZlMENjTnppRkJCam1objhiaktWcHhlS3dqWGtzelVaMkZ0TVpoRjZpSmFx?=
 =?utf-8?B?VjM5RThCVGJ5L2dGZlVpQzBGYW9Lbml0bURQeDA4SWRQeEVoSkM4bE9rMTR4?=
 =?utf-8?B?bEt5V0xSV2VXT2xxTVhRRDgwREpLSmFSS291UG9qVG5tL25xS3hNaE1oRzJZ?=
 =?utf-8?B?NEpWZkpPNHNLTGp3OHROT1l1Ulk2ZHZNYUhoRUM3Y09Zdk9uamhGYmZHNmJs?=
 =?utf-8?B?SnRGb3hOKzRnPT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB7862
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0dc320d8-d869-446b-0799-08de38cf6e66
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|14060799003|36860700013|376014|35042699022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzFDK2J2RzN4RVNEVytyMHVQZk5YcUVoVUNNbEpZVndic05NQVNUN2swRE5H?=
 =?utf-8?B?NWwxQmxXYnFFM1VnN1NOWXpDeWkxQ2xDYklBd01tSGF4Skc1SzV5aUhHU00w?=
 =?utf-8?B?V2I0WW4zK2VpL2NkK1pGZmVwTkE0S0RIUXpOMTE0QVo1RXhCMnFSMDhOY0gr?=
 =?utf-8?B?ODFPL0RVV0hzSVpaWGQxYmd6Nit6UWRuQUVSYnZpMWloenkvQWFJZ0ZWUHpM?=
 =?utf-8?B?MytGTjZoalU3LzRIZTBvTkdKc1VOZDJDQ1Z5R09WTTd5VlExVG95MTRTYVVH?=
 =?utf-8?B?UnByOTdBdFFXUWwvYWZmaVRWVVFKay90WnlpdEN2YTZoOHlEcW80T09kbUQr?=
 =?utf-8?B?TnhVUjByTEsrY1NZVDZtSzdwL0VJc3FzYmUvU2VjZ2F3bjBPODNrSldtcGFr?=
 =?utf-8?B?bDJBWHZsazhJT3FueGV0eTJ0YWs0WGZVSzlwc2c0Y0d2bVE0cWcxWjBFZTNs?=
 =?utf-8?B?R1E0bWV3bTkxZFhhU1BGdmlKNHlqOCtVcWpkeW11RG8wM1NQNk5qV05xOWx4?=
 =?utf-8?B?ZktNTUl6ODcvSytiaGlvN010Mmk1TkYvekhyU3F2OEx3ZWVoZ3hlSnFtMGQ5?=
 =?utf-8?B?QktoQm4yaGZLTjRPZS9sOVVDRzBuRy8rMGVjdXhsSVJ2T3hWWHZDbVZKNWJR?=
 =?utf-8?B?ZUVqbWZqUTBtMjF1T1lIVlAwVGhmb1YvbTdHa3hTendiN0pjeU9yQldiRWx1?=
 =?utf-8?B?VXlmME9tUU1neWZ6RTZRRGhyRk44bGUrbklqUTFVZWtDZ3JPTm1mS2dFeGZm?=
 =?utf-8?B?MXVQaDJnc2o2cmhJRnlXK0JJa2NkblpmVjQrd2tueUtObWwvNU1WZlVoa1pG?=
 =?utf-8?B?MWRpdTBvVFZkQ3pCS2JtM3g5TW1zQU5nRWVUZjRkR3Y2aFU3QlE0VHJjbCs0?=
 =?utf-8?B?M3lTZStkaDZrazhMWkN5MmM4Y3RpZjJoYXU3NldVeGN3SE1XbjdwVzRtYXg5?=
 =?utf-8?B?RXI2ZDBNUTRnN2QvTEpncGdKSUdaT2xkL2tJa0krTUtLSzZpeTJxZzZad0VO?=
 =?utf-8?B?TFpuRFp2UUJjakt1M01GTCtnNGRSbG1YSFlqclVZbWhVeVM4VzRrendqcDhw?=
 =?utf-8?B?Y2JkY1JiRmRPS3N6dEhwdU44cUU1d3hoWjZ5RENuUlZZbmpRVEtreTBRTHEv?=
 =?utf-8?B?dEp1WFZ5a0NGSlpqSkhMYWRXeGF4TTJrY3luYkxzVmVMQ0drcVoxMFZ1RWdK?=
 =?utf-8?B?UXJUeTdYSlhlYTlZR3lZWEhGREVhb2NDSjRSbTIvdlJFSWFvUU5XemVRNFJI?=
 =?utf-8?B?anNCR2xIcUlOT2pqNSswNTAyYjFJNXBrSjJJZjFxMDZzOXBJUkRiM1lpSTFx?=
 =?utf-8?B?eXU0SHFWVElsd2RpakswUXByZkJ4Mng2NnhSY2NXZDQ4OFlkQ21adFo1djMr?=
 =?utf-8?B?UjhqMStqbWtUZ3RkVmYxTWFodmlNQzd0ejQyYUJtV0w5dmVtQ21DdDNSTTg3?=
 =?utf-8?B?WklMbXBTd3RzZ3AybE8vQnYvUG1yMnMreHhGZnBjOTB6YkVBWU1ac1hSK2V6?=
 =?utf-8?B?cEN6WFVsOGhtYUlCdDF0c0ZKRTlHOU5uZ2VHOU5pTFBkNklYSHMyRTVzUHZP?=
 =?utf-8?B?QjYvT2RRSHRVYjEwRlhRU3Roc1ZhVXR1QnNobmFyV3dldGI0ejVrSDVxMWtj?=
 =?utf-8?B?V2R4QnVTdGlGYlZVWGtGZ0pzSWtGc3FGaTVIOWZjakxwWkFkbHUwK0QxNWRu?=
 =?utf-8?B?ZkY4dEJpdU15Vjg4NjZZOVQ0KzBvbGJmQ2Z1R054Nkl1UlQxL0kwLzdCRnNm?=
 =?utf-8?B?ck1vNUZHcmxnVHRmUVp1UllZdTQ5NjBVd3lEZG1md0M2MlpkUlJVS0MzSklF?=
 =?utf-8?B?V0dTeVFPVjVObU9YOGxwTnlNMUMvVWVjei83Sm9ReVBrVy9IREwxY21TRkZy?=
 =?utf-8?B?RytOSHE1QUoxQTB4TkV2eGpvU04yMTFxbXFhdDlIQ2tEN0VtcXpCYWVINFg1?=
 =?utf-8?B?dUZ3WC9rWVZ5cVZmSTZKdDZPQzBYaEh0R1ZzVjZwcGgzSmx4aUlMR05ZT0dB?=
 =?utf-8?B?eVp1U3JTUDNPQU8rYXlSUk1hQU5FY2lYN3REcDFvVEtsUUp0bENDM0dmajMw?=
 =?utf-8?B?RTdwaUZsN1JnaHlneHE1aUlwZTBNSDhndzhJelhleVBBdXhCVGczeTBycFRN?=
 =?utf-8?Q?AftA=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.82; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(14060799003)(36860700013)(376014)(35042699022);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 16:07:54.0099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b2e395-eb69-4c5d-b92a-08de38cf7120
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.82];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7193
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

On 12/11/25 11:05, Ralph Siemsen wrote:
> To reduce SPL size, make it possible to exclude designware driver,
> while keeping it enabled in the main u-boot.
>
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
> Changes in v2:
> - defaut y if DESIGNWARE_SPI  (Tom)
> - move out of the SPI/DM_SPI and add depends SPL_DM_SPI (Sean)
> - Link to v1: https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/=
v1/query?url=3Dhttps%3a%2f%2flore.kernel.org%2fr%2f20251208%2dspi%2ddesignw=
are%2dspl%2dv1%2d1%2d21e6f519a4de%40linaro.org&umid=3De83941c8-36b4-4867-97=
ac-ce962ab37278&rct=3D1765469141&auth=3Dd807158c60b7d2502abde8a2fc01f406629=
80862-2e9feff7cf949797cd8f1fd98013073db7b6fb3c
> ---
>  drivers/spi/Kconfig  | 8 ++++++++
>  drivers/spi/Makefile | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 2afb15fff1e..e31db9d4e31 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -677,6 +677,14 @@ config SH_QSPI
>         Enable the Renesas Quad SPI controller driver. This driver can be
>         used on Renesas SoCs.
>
> +config SPL_DESIGNWARE_SPI
> +     bool "Designware SPI driver in SPL"
> +     depends on SPL_DM_SPI
> +     default y if DESIGNWARE_SPI
> +     help
> +       Enable the Designware SPI driver during SPL.
> +       See the help of DESIGNWARE_SPI for details.
> +
>  config MXC_SPI
>       bool "MXC SPI Driver"
>       depends on MACH_IMX
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index d5d1e543588..0dc2d23e172 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -35,7 +35,7 @@ obj-$(CONFIG_CF_SPI) +=3D cf_spi.o
>  obj-$(CONFIG_CORTINA_SFLASH) +=3D ca_sflash.o
>  obj-$(CONFIG_CV1800B_SPIF) +=3D cv1800b_spif.o
>  obj-$(CONFIG_DAVINCI_SPI) +=3D davinci_spi.o
> -obj-$(CONFIG_DESIGNWARE_SPI) +=3D designware_spi.o
> +obj-$(CONFIG_$(PHASE_)DESIGNWARE_SPI) +=3D designware_spi.o
>  obj-$(CONFIG_EXYNOS_SPI) +=3D exynos_spi.o
>  obj-$(CONFIG_FSL_DSPI) +=3D fsl_dspi.o
>  obj-$(CONFIG_FSL_ESPI) +=3D fsl_espi.o
>
> ---
> base-commit: 0e0a198a68be71148f5ec27ef86796174f91436f
> change-id: 20251208-spi-designware-spl-d85d6a26e5e9
>
> Best regards,
> --
> Ralph Siemsen <ralph.siemsen@linaro.org>
>

Reviewed-by: Sean Anderson <sean.anderson@seco.com>

[CES 2026, SECO]<https://exhibitors.ces.tech/8_0/exhibitor/exhibitor-detail=
s.cfm?exhid=3D001Pp000010EbaOIAS>
