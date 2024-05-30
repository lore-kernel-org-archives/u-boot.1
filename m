Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5213CC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 13:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BCD28870D;
	Thu, 30 May 2024 15:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2U79BzQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8739D886B5; Thu, 30 May 2024 08:04:54 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 051CA886D2
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 08:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUtRf9bGMcksAT8jVR7r6ppNrOh0iDOx60ew8LQVhgjIYUzsiVQFQy34h5XZlAHPZe1bHecMXe6bWh2rNZNy3pmg1ZA4UNQaUF+v5Z8Xvmc6G1sT3EjyO16vn34+RGBx8t4MkL/KZmWgO+p4fptVUT6yOeOdEhO9Wg/By54i3qqTeO3X0USZ0MnuULdkU8LXO87TSyuX3fRObg0c0Jt9grSPdmLVZBRWlHQg+iLuC+eKDuBqPPrDR0BZaZz+njTHPS0oXMVdx15eOHDath8qxwXURVDwiCi/h2kqy7xiquez/2mWcpRTgFMnJXkyOIN3kUqNlww8AeoHNT4zs97tNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=airPyMuzyH3R04z6F3LbQtCfBavnQnojg6z7WFmV1oo=;
 b=NrKeFJqaoAKxufv2KSecDKIarq0oXJO/KNPmcki4p+UqoxePFPzkAvbwed/6Dyvh4kiFVjCBFtR6pr02GuqMAa/E3vlyIMRHaTNueM6bIJaWkEVmNcbVM7h74hJikMATrjfrod2MFOTyVaSodrnZR2AIuej61/NxalsxUh8FMXrtyC/a1rInBOyw76LrCI/a+LnwjcqWuR+S8TLpeJXRXu0wQgJJc8Vt4TowQ4vCoLSInzOjY9tSvUfn3YEsk+7JoHIvrJLdbICJ4blHQ0VFMfC+sNT/8Q0u36JNMtSscCKmLJIvHEnv16u821DrVjVnttmsjI0vpZCDU2Ek9mqXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=airPyMuzyH3R04z6F3LbQtCfBavnQnojg6z7WFmV1oo=;
 b=2U79BzQa1bIEUGQLrmiU5gqxkR9GifTTOXisU6qfsXZeEt78CRkSvMsFRKVsqd6aNP6HCnqsMuMy2j+uaqIlCgKxrAqmen4QVEMlMq5sfOQ2CS9+Qv+k8YTpR2Bf9CPOeLpGREH27WyYSdm5xpH7/pBOfNYYMwkGVy5Jq+n+cNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 06:04:48 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Thu, 30 May 2024
 06:04:48 +0000
Message-ID: <990b73c8-b33c-4ae9-b100-bfeb2f2c184d@amd.com>
Date: Thu, 30 May 2024 08:04:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64: versal2: Add support for new AMD Versal Gen 2
 SoC
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Emmanuel Di Fede <emmanuel.difede@cysec.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Fabio Estevam
 <festevam@denx.de>, Hai Pham <hai.pham.ud@renesas.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Igor Prusov <IVPrusov@sberdevices.ru>, Jaehoon Chung
 <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 "Polak, Leszek" <LPolak@arri.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tim Harvey <tharvey@gateworks.com>, Tony Dinh <mibodhi@gmail.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 William Zhang <william.zhang@broadcom.com>
References: <cover.1716994063.git.michal.simek@amd.com>
 <20240529161316.GP2568172@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240529161316.GP2568172@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0045.eurprd09.prod.outlook.com
 (2603:10a6:802:1::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0ffe8c-2df9-413a-f006-08dc806e6933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlJocmJVbXpuQ1JqSE1qUjFyWUxNemRIcWZOamp2bGc5RU5MY2pIM1piR2Q1?=
 =?utf-8?B?WWttS2ZYZGhUNTlrQ1NKdWdPRTlBTWoyVUw4OENpQ1E3aTJNUUtoNkRVY3Zi?=
 =?utf-8?B?Vk8vWWhJVFR0L01Dd0xoOHdpeDNKSFFOK0dLTlBzdk82SVJSK3VoTW5BV3pJ?=
 =?utf-8?B?ay9PVTdFWjlhbURTeFh1S2lSNm55UTZYeVdFREd6ZVdydkx4ZGN5VHFVNGlI?=
 =?utf-8?B?elFEY1pLOXVaTXVqay9BNGhiQmhjMVcwWDNwVndMdUY0bDVPTjFQYXlHTVFE?=
 =?utf-8?B?eDF0NHdXYXNBY0lzT010MS8vSEVVVksxUUtkZFVmdmlLQndQY29MbkhPZDRN?=
 =?utf-8?B?SXllV1dtU2lBMzhXcFpIWVp2dmI0YjVDWUkzSUh5ZmpQUmQzWXRmMVhob3By?=
 =?utf-8?B?ellXSGhid1Zhb0w2azMwTXNWeUt4ZlRqendXNytJTWtKaXFFOTdrc1czTGFQ?=
 =?utf-8?B?UkFENVFWZk9xRkkwcTlVenBsVmM0NDU2U0YvY3NQV2VZNWNhR0srUW0zdXZG?=
 =?utf-8?B?ZUpkc283QmU0enlYNkdDZjhxL0Jqd0QvMThPNzV2ekE4RUxXZHI0dW1wRTV2?=
 =?utf-8?B?aXNkN0M0VC83akZsZExHNW95eHRtcklGOVBoQjhVcHhiNlFaY2JUdzgxenJW?=
 =?utf-8?B?MTh1amNOVnd5UFhORmdtK2JVOU9OeGUxbHhLNExJZGlsbWhsWndjbjRpTU41?=
 =?utf-8?B?LzMzeWpUZFVwNUxnY010VnZTYjFTZk9DVllZL2p4MzZ1Z1YwVlZna2FPcWtv?=
 =?utf-8?B?cHFkK1BuVGZ6Qm1POGxMZGZmT0pRSlY3eFpiTjh6ZVdtaGlQbGpZNjVKbUZM?=
 =?utf-8?B?d0hRVExseGNtRnd1SU1YOHI4eFNYUGlzTFJCUEtZcU9ZR3RMNkJBMXhqOHhk?=
 =?utf-8?B?SjlzSDhHYWpPVFRJcXNMeXF2SGl2dHJLZFhHVCs3UEJUVE94S1FrbTduQUk1?=
 =?utf-8?B?U1ExdkdZRlJ3VnpHSTFSNVpzOHhjQnVUc1hPeXg4SXBZVTJGUkkwdWFvSHI2?=
 =?utf-8?B?T3RFY1BhbWtlaGExK09Xa01ubno5cUkrQjEydkFocHR4cGRPRlNxcTZDNkt1?=
 =?utf-8?B?enc1d3dTNjRIaXd3Rkg4MCtMak12K2ExdVJlOTVwajRTS2hXL2hkWkV3dDZN?=
 =?utf-8?B?R0huS1A1N1Z3bTh3cHhjVXJ0ZVkvTDJmQkdKdU1EUWE5c0x0WGRyMTZoUGsw?=
 =?utf-8?B?L2ZBajlaejVwTVhzYkZBcVpFNlVyUWpOZVNzT3lXZjJpSXlIN0Z4Q1NUWHJl?=
 =?utf-8?B?SDJuSTMxWXE4YnVlT1NQZFpXRURqbVFHdU1xclROMjM1UlM5ZVRCTmJ0ZlBW?=
 =?utf-8?B?QUdKajBHakloeklKYkVDMDhaL3BUSjJNRmRsbyt1ZFhoS01rd043NnlueVdp?=
 =?utf-8?B?NUNRUDJXczdid3F0dVYzaUZGaDJ1SXpZQW4xUFpMSFFuRTBOcFdSR2U4bGUv?=
 =?utf-8?B?aVlSM09pYUNrampnRzBTd0pZVjJDNkNqaUE2NGdWdG5lSGdja2pBOSt1Qll1?=
 =?utf-8?B?WFMyRlV0QkNUNWNkeU4yT1dPTHNPUUFoR2xYTkNaTTVNbzloZzdqNkNkRS9K?=
 =?utf-8?B?Smo2dFVsb25wUFpidm9Ib1J6VnFWdlM5cHh4YkZ6aENNWWYzSytFSmhROTJx?=
 =?utf-8?Q?kfqofhZbtrUBfuTcTMmV1Vg56DkHLcVHBFlsuJlF/ups=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(7416005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnhrTGI0RWV3aG9TRnBkNVB4MmhQaE9pczZBL3YzemdRWHhhVzRyVW5JQ3lI?=
 =?utf-8?B?MVdzV3RpQ3lqYUZ2S1dWVVlEZVNPVDIrVS81SEtYbWpkQ1daUnZ2Q0FTN215?=
 =?utf-8?B?bG4yUEQzY3d1b05CNlhma0NDb1JJcjNUT1g1dzlaYlV1aGs5d1U1eUdFeXFH?=
 =?utf-8?B?OUNtRjhIRTZKMVZPU1FoRnBiSTh0OS9tMlZWUjFleGt1RXdmOWw3VTNreER2?=
 =?utf-8?B?dEU4a0dKZDEvNWVOSnJRY0kvM1pVVG5PdVNNUGRDMlpwS3JBcWEvNXdKS09Y?=
 =?utf-8?B?NHJ1TDlHSG04MDFhOVVPM0N1V3lhYUxhTmFCSVpNRkFGd1Fjd1JqSkxVdzZS?=
 =?utf-8?B?UUhnc0l0UWZPVXd5Q2hRWXdSdTRSVDNlM1EvV0JpblNpMzVJOFo4TGlhRG5M?=
 =?utf-8?B?OGpOQXNDMS9FUE5IR0FaN2F2NEFSU2c2d2kzMVZNTm1uUDMwclByMWZ6Z1BB?=
 =?utf-8?B?Uk5rSTZJRXRwREJWc3F6Qlppd0p4ZVd1NldUQjZibUxFL2xUdFpMZFNmK2s4?=
 =?utf-8?B?YXdhQ0RZcnBCakhZVnJWSzMvVjNBeEhvMTFMMEpBUzlQYXhIOU5IM0dOME1l?=
 =?utf-8?B?QjA2UjUzYmxkSTJCZUNFMVc2emkzVis0MksrcG5FYmxORzk0RlpRbE9KeEpT?=
 =?utf-8?B?Z0hLaDBVbUVXL0g4UEhLWnJTSHRtdDBVcms1OGl1OUp0cVZlOHdWejNUSTl2?=
 =?utf-8?B?eHVabmt6ZDBkUWJnc1V6eHg5b3VRaHdMZFpRSlJVUndheGgzLzk2NmNrUTFx?=
 =?utf-8?B?b283SHI5clRIMmVLNDRUS1RFNFZtbnAvTWYwbmhUWUpSMVREd1NZRkVYZFZO?=
 =?utf-8?B?bS9iOEZsK2FiSUphV01nYm84bDF5RDgxcytwd1ZlS0VMTDRiZkRHazY1WnY5?=
 =?utf-8?B?VStoQXRBdEhXQmlOV1pmTUFkMlpNV2Z0WWo1WFRKbjRkdkpLMmhMWTNzQnBX?=
 =?utf-8?B?K3lFWlFGM3cxTUtXNGVyZEI5c1BpT0NaaU1DeVFnc0owZEUweStUVlZaOStB?=
 =?utf-8?B?RzhHRXNaVlVQNFNUOVZoQVc1dWJlaXZ4VkZ0RmorTkdyV3E5K1U5RDhldlNk?=
 =?utf-8?B?RXZIVGRtemZUQUplcmFZeFhoV1RRZTF1b0gzTWRIMEM3cCtrbWNYaDZVdzVN?=
 =?utf-8?B?OE9CNWsxcEVYL3lBMm4zWUN0M0E1RXFNRE9wbElXVDNUdEl6dmdVL1djZVZM?=
 =?utf-8?B?ekQwQ0I3OGRnd2h1L0c0YnhGcVgwYTJNT0E1YmREbUxnd3lhaDQyOUw0eGRC?=
 =?utf-8?B?OWQ3Q3g1STNycDdETkpOOXVjWC96NjlVQ0ltWVd2d0hwcWRtZmJiN0pVbEZ5?=
 =?utf-8?B?SUZIT3p3Rmx4STFsUDNzS3dtUTkyVXNtOCtqa1JmNzlIcGdNeWlRS1d3THM5?=
 =?utf-8?B?MXd4Q0czNGZNZzd2dnlkeTJyUTJkYlFPMlNjWWZlYkZXYndSc1ZaR3dUNUVH?=
 =?utf-8?B?dUhiWW1KOEdlYTlvTHdrbzgwU0RWZmpNbENCUEhQbkxMQjIrZU4ycXVKNG5n?=
 =?utf-8?B?aHVWOVgrNnZvU3JmeE0rZXg2K2MrRmh6dWc4eTludDhmMjFpUjFhdlhvamtX?=
 =?utf-8?B?ekwvQjBHVkJiSlMxTjhBbm9ZM1U0YldUUGNtenBEU29tYmtMSElBOWMreU4r?=
 =?utf-8?B?SnRKYmlwRHZCam5PQmlBQVdVZ29zMFBNc0FLUUYvMGFCQktqY05SQVkzODFX?=
 =?utf-8?B?ZUM3YXdsTEVDY1Vpem0xR01HU1hpYmJhT3FObk8ydEQ0cmgrUWVmWFB4UnZw?=
 =?utf-8?B?L0ZDRkFkMVRaRjFnQXY2YStKdXp0T1l0b2txc2JhSitXc1JNc1JrcDFjYUF5?=
 =?utf-8?B?OHpTVXhvbFhQb3c0RkhmRGNGYUtaS1pVM0syNitIYVpJUk1YYzJKWVpqYjdW?=
 =?utf-8?B?R1FWZUZHWFlCNFA3ckxUQXJLMHFaenpycWFGQ2x4TTM5U0dpYlJWYlFvK2tI?=
 =?utf-8?B?K2dFTzhudWdaeG9GV0kybzc4USszK2pZaWl0eEFtTHppVmZGWE5ZKzFiZk1F?=
 =?utf-8?B?SElpNlRES1ZLKzl3Mi9sVzVGcTc3eVpzVWtaZ1J2QnpuRzhKMDV1YVUvdDNE?=
 =?utf-8?B?K294WG4wejhpOWZtd3RrenN6SmtMOHlxb3Jnb25kYnVJNG0rVjd1cEpsWTlQ?=
 =?utf-8?Q?eg3s9U1HUtuUUyuVSalTMnJeV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0ffe8c-2df9-413a-f006-08dc806e6933
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 06:04:48.2035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhkyZKFVXwzJbqqNGQFlCL/vnNMTg3WZ/iYoy33j7EyprWegfrenMA25pzXon8H4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399
X-Mailman-Approved-At: Thu, 30 May 2024 15:50:06 +0200
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

Hi Tom,

On 5/29/24 18:13, Tom Rini wrote:
> On Wed, May 29, 2024 at 04:47:57PM +0200, Michal Simek wrote:
> 
>> Hi,
>>
>> I am sending patches for adding initial support for new AMD Versal Gen 2
>> SoC. If you want to find out more information please take a look at this
>> page:
>> https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal.html
>>
>> Thanks,
>> Michal
>>
>>
>> Michal Simek (4):
>>    arm64: versal2: Add support for AMD Versal Gen 2
>>    soc: versal2: Add SoC driver for AMD Versal Gen 2
>>    mmc: versal2: Update zynq_sdhci driver to support AMD Versal Gen 2
>>    spi: versal2: Enable spi drivers for Versal Gen 2
> 
> My only concerns are name-related and not-blocking. First, should we
> perhaps instead have arch/arm/mach-versal/{gen2,net}/ (and presumably
> gen2-net down the line)?

There are completely 3 different SOCs only names are similar
Versal is 2 cores a72
Versal NET 16 cores a78
Versal Gen 2 8 cores a78
with different features.

Creating subfolders under current mach-versal would be very confusing.
We can definitely try to make it as small as possible but still they are 
separated families.

We tried to reuse existing platforms but it is hard to keep it in sync that's 
why new platform is better way to go.
But as you know we are trying to reuse for example board/xilinx/common/ folder 
as much as possible that we don't have code duplication.


> Second, and I see I can't say we should follow
> the Linux kernel since there's no versal dts files upstream, should we
> still be "xilinx" and not "amd" ? I do see the kernel shoves all the
> imx8 (as an example of a modern part) stuff under
> arch/arm64/boot/dts/freescale/ and if nothing else we should be
> consistent between projects whenever possible. Thanks.

I am not going to send DTSes to U-Boot and just push them to Linux kernel at 
right time. And target is arch/arm64/boot/dts/amd which already exists for old 
amd socs and elba (pensando). Versal Gen 2 should go there.

It means Versal and Versal NET will be branded under Xilinx and Versal Gen 2 
will be branded under AMD. Also we are going to stop to use xlnx, dt prefixes 
for new IPs and will start to use amd, prefix.

Thanks,
Michal

