Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2AAF3C9AD
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE58D83642;
	Tue, 24 Feb 2026 17:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b8Hvkqjb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E51D883981; Tue, 24 Feb 2026 17:10:44 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9734182BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDt7DsDUf4uZjoYzB2bxovURX/G9AE2WcrTAJp9g/71QXaoUlMhkaGwyVIA8ftZ6J8iaOdYfSCLfWcumwXBDnaIlZrgkXXDKKud0gFoyuIv0TNtyJeCA0wyk6WFeW5IDD28MG9IniH+AYhxyHFO3cOCnD0msP4ZDUt+aQk/ldPsy41Oz6C/ELe4M5pK3kOFNxxvXEAdkNMKTEKjJOvohOQIIrMVWs4uy1MF20YJwcn1BdcB+MDW/OKvY6e9cjWWyjn358LjOXCTZJNaiMlmDbdu2LkP4AGRiaHcS8AnV/ObLuwsfoWNW6cihdattCaM5rh65WXZm/XTg5800D1dNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4rhlVce70GJqcvSkuJKoEMGJXftv+e3ixqpWA/aAdw=;
 b=WoE/8Wz40qbsnJ1hPAK/Ohpz6RwUdp1T+j2cbwXepzQKM9LKsSWOYXvrMEreL/r6xm/N7MX1oAFqTU+H+5nhgGjzW2eOGLn7oTSvlwZ4ghdRJwmlzbHZO6Sd8rcIGeRCNDCQukPT7YQWOWef620ao9abFS1K0l+kSEn709o/Eg3MPZFXZhCKuHBUlEO/dvFoIw8LoQdmByQdW5gqWyW8MuM/mr2PtgoXv8w9knlWT56XZzSnpH12sSo30zgBgjJfEGPzsK7q5ijWyDki7b85Ia4paymvHIgvt0gG4zvK6Y40wGHBY96Ez7VIR544vooQcI5OAxGbY1/FcQZB8DcQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4rhlVce70GJqcvSkuJKoEMGJXftv+e3ixqpWA/aAdw=;
 b=b8HvkqjbAQ4ZyEgEm7WkU6TnlyJSkAOjQINxVegztxYDFJu0tPDD4wIB1g4O7wk/wY6nzAjL8eM9XnfuHEKx+QOgP1haeIm3KRMjMkegNh8cOBWsaagQ0VM3r/SRo5V6Nu2R/ltGFbgMc/o7m+W8GhVILfZ+N6NT2ASXt5vUR10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:10:33 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:10:33 +0000
Message-ID: <4fdab7f4-aa11-4abe-953e-6d9785945fbd@amd.com>
Date: Tue, 24 Feb 2026 17:10:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] gpio: scmi: Add gpio_scmi driver
To: Dan Carpenter <dan.carpenter@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Philip Molloy <philip.molloy@analog.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Eoin Dickson <eoin.dickson@microchip.com>, u-boot@lists.denx.de,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>, arm-scmi@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>
References: <cover.1771856828.git.dan.carpenter@linaro.org>
 <e3649db2cbde07a53c7139d72c2c597f9a6d8fbd.1771856828.git.dan.carpenter@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <e3649db2cbde07a53c7139d72c2c597f9a6d8fbd.1771856828.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::6) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: acb0c998-d4e1-4ca2-81e2-08de73bf3cc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1NRVHllV1R2RHFDRVRkc3dSeHh0Ym1jdlo0bm1FdDlLT1hKVVh1ZFJyYVhX?=
 =?utf-8?B?VGhFdlNjcFJCOUx2RDU4bkw1UzRyUko1NWQ3V0VjTU1uVEFZNW9GeEp4R1JM?=
 =?utf-8?B?TmVNTm40QktqcE9sWEVvbkVWS1ZqS1RybDBYL3Q3VXF2NWRtd0tvWTFmQjlQ?=
 =?utf-8?B?Vjc3cnJ2TnpzbEd2a3A2STdRSzlqNGRSOTBqWUpLNmNSTXo0QzdsWWhFK0NK?=
 =?utf-8?B?eEcvVjdZUlF0TElmUEZucTBVR1IvTnQ0bDJCaUsxRHlxb3ozbE5VWURnZmJm?=
 =?utf-8?B?K1VUMU9DYkRoVjcwSVVHeEtjV01Kejg3ZGZFOUp2OTdQUFNQZnlJSytTWUJJ?=
 =?utf-8?B?Q1d2K1RVYWJoL1krTUxsbEExTWpESkUzejV4NVBlMlpoRit6b1FEbkxtYWJT?=
 =?utf-8?B?TC9kV2NBUG8zTzhSams2VjhmMnZFeXlOVi9YY3gwb1hqVWx5eFhGcUpwU2kr?=
 =?utf-8?B?RU1BZFlza2JycHpURVhTakN1d0hCelRLbmx4MXZHUWJsemR4M0pjUTRpQi9s?=
 =?utf-8?B?NFhFekttblZQcTdSQ0lpUTBPZUpxQ1lLSmxVcVB3SkFCcDB4L2w0UWV0aW5X?=
 =?utf-8?B?TVhETWwvQ0UwSTU3dHJWeWxBSVc2dllCU1c1TC83SHUzb2JVYVIzdFhtUitN?=
 =?utf-8?B?SElod3BBcm82NUJCR205Ynl6cU5SRENwM0I5bWpCNmpZQURsbHhKNS85b3Yv?=
 =?utf-8?B?UWFaTlJ3bTFvK04xRStFYkUrUFVueGlDckpJN1ROendUbVdPcml5dFpOZHBV?=
 =?utf-8?B?Ylg2WTV1YktoSi9jQWN4NDd2Yy82eUJMNWtJcnJtSitHTlFrMkxTaHRDYWNs?=
 =?utf-8?B?czN5OUl5MUltZGc0cVEzdENnNUd0L2RXZGRpc2Z4bkg1bDl4aFNFWnM2MHgv?=
 =?utf-8?B?eSs5Z3NTOWpJeWh1UERnVG5sZVlsREdWeURQK3o1a29LV2JkdU1XT1JXU2dy?=
 =?utf-8?B?U01DVlN1c2EzRlJaV1VTbk1VS1RPNjhWK2Q5SytiVUJocU15RFpaQUZUUTBN?=
 =?utf-8?B?MTdTY3Byemo3NVNGSTYwQ0IwRkxmdzZqNE9IVXNQOGxuSElJZVFmZEVzKzRr?=
 =?utf-8?B?elArWFo1WU1LVHMrTE4yb09xeVMwVm9BbnlTeDBlektSazd3cFVySGVGZGc5?=
 =?utf-8?B?ZU5SbXdxdEV4ME4zendEK1BYdkduTFZzTFkwOXRkZHo3OFVwM3B2YzlMdkxa?=
 =?utf-8?B?OE9NaHJIZFg4REJCb2g3WWl0VzFJTGZWdXJUNUpEUnZSMnhkdjlVR1dPdTFm?=
 =?utf-8?B?a2FiQ3ZHUlozU0lsWVV4dmttdzExYmFJdjJkQXRCYUJsRGxkTURvaXk1US9U?=
 =?utf-8?B?TkljSGtwNGI1N2xVeTRSZ3gxdlVWdTJVRXU4bTRqZ2ZPNEFuaVVIVHNNNjJ2?=
 =?utf-8?B?Z01HUkxLMmlaSXFkNW5wc1c1TlJmUFZJT2N1VkUyVC9PLzdTekJ1RUo1ejRP?=
 =?utf-8?B?RkU0RjNURk5tNU9mSWtJY2FuQ0VyNi9lY1E1YjRzSlYwbUlzQWRXbVdXREdM?=
 =?utf-8?B?MmdmMnh6bVhIdFpXTXZuR3Q2eDFWUS82Mzh0dmtvakJ0VU4wNWMzd3Y1dXl0?=
 =?utf-8?B?SExFTitkeW4wa2pTS0g4eFZGdE1YRVlPSEpKb0hKY3hSekF1a25JOXQzTmVN?=
 =?utf-8?B?TzY0Z0xFWlROM1dLdEcxL1RZVTVXbFIzZ3c1SkJJbjVjb01qS0Eya1grQUMr?=
 =?utf-8?B?NnRoUjhHcW9WSlgyZTI3QmVPODRSbnorQW10ZGltL3NBWG01ekwyd1RvSm1L?=
 =?utf-8?B?eFh5OW81cXR6OWQ5SklzdTlFallEVzArcG1jOFVIcmRBNjR1VmNQUkxoTEJS?=
 =?utf-8?B?MURJSmhOMXc5SG45anl3MGRvTnc1bktqNWFXTjFidHNqcVVrR0NydkNkK3p2?=
 =?utf-8?B?L1NYR1JEV2NmMERRVUJyMkdCclF0UEk0NzNaMzFQOTJFV29QeFlvWnZNbXJ3?=
 =?utf-8?B?Y2Vxbk1iRFV1cHI5QnJWWDVVQ2ZDRUZnaHRGS1c5KzZRSmIwOUswTzdVKzJm?=
 =?utf-8?B?alNiajcxdlF6b0VuMlZNS1hGTkQ2aTR0eHpiWW9GSGg4Z09qaXIzN3NZam9s?=
 =?utf-8?B?dXY1NERHc3RvTkhoZm13WWJUQWkrSUltL0c5WWdxVGRBcTFHdWxxeWczd3JF?=
 =?utf-8?Q?TePw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG9UK2xWcVNnem1veEM3M2M0TFF1MVVpWUhBa3hvYUcreEVXamNFRFp5bFU5?=
 =?utf-8?B?ZXpaV3RDNFNHRlNxN3g4Mi9zNE5KRlJsenlueVEralJBY3puWU9ZcHJwUnhu?=
 =?utf-8?B?RExhdXNiV0NEYVRJTWZlZjNKclk5WGM3S2JmUWswSUFhU2JKdmdVU21nUmNX?=
 =?utf-8?B?cGlMdFFDK1NXZWFITnVET2x1T0RnTlVOTHMySEUzV1lGZnh6Qks4UDNKY2lm?=
 =?utf-8?B?bkVvcUZuY3FPVmJzb3dObFRqcjNqa1djQzlzbjdJOVpIMEFPOTZGcjdob1Bk?=
 =?utf-8?B?U2F1ZGdCSk5Hby90RERpaWJQYmhuOGF3QnJza1RRSWpBb1JGNkxPUXNNSzhv?=
 =?utf-8?B?bU50ejEvdVM2VVNuUEJOaytWUDlid0RaSWpnOEdsK1gwQXBZbXB5eXRxcW5o?=
 =?utf-8?B?ZCsrR01oekRScDNDTkR4THFFbXh1c2VCcnhLU1lDVEk5ZVRhRWx3d0xQTGJF?=
 =?utf-8?B?QmxYYWpaTHF6RmhsR0kvR3J1SENIcDJYS1NLd3pXNlYwUXdTVjU2TjdQY3pK?=
 =?utf-8?B?cVE1Vm5WNkRSVXBaREp0MG5zNjErdDRBL2E1Rjh2OHRadWdoZDhIcU9JKzNT?=
 =?utf-8?B?alYxQVJIUWR1SkpmbkphZHl6ZVVOb3ZmQkVxSjd2cjRUMjNrMm5nTkdnMmpy?=
 =?utf-8?B?a0hKenJaRnRRY3ZWSnRuTSs1Tmp4MWFBWVdkU2dzM1VUdDdkNjNLc3FDNTll?=
 =?utf-8?B?MzFQRWtnRmlvMnpVekZoT2xZVlBtSUFIUUdDQVppbWlCKy9jY2xKeE9kampP?=
 =?utf-8?B?cThGYnlna25NWDRIN2VmaDRIcUJRcmZIY256dDl6SldoV2tRcExYQW1FNWti?=
 =?utf-8?B?Mk5scVR3UmRMNCtnZWNhVkNhRzNBOURvTXNqTjc1YlQwK3d5ZWViQ0xWalZz?=
 =?utf-8?B?TnNPcTh3dnU2Rm9iOWNTcm5vSUZJZkhQNWxuYmJSVmt4RFFVcEY2SlRFT3BU?=
 =?utf-8?B?MWQ4VXB4WkNSSVFLRlBURWJraHAxRzIvbVFCQjRoaVN6aTdpTC9qay9nbmFW?=
 =?utf-8?B?RFhPMVZodjZ1a21RWE9BUGVXa1MvMlNwT1R4SWVRVS9vMFZrNlkrRC9IV3g3?=
 =?utf-8?B?cktneWIvb2VQZGdERXp4cEg2bWN2SytIR1RkaXV2YnozRzBJUGpOSDVBV09F?=
 =?utf-8?B?VUpkYzYybzBEYjFzYnU3SEVsLzFXaDh5Q2k5Qlh1WlRlaFdNOUtSYU9keHNJ?=
 =?utf-8?B?RjZ3ZUtZR2kveG8xOFdaWVdaaGRTdjNYVkNpZnFXY3BUOGRoUWRmcnpoczlj?=
 =?utf-8?B?Um04SnBkWHcyTFBUSGhndFZXQjczY2wwc0RKVFdFSllkZmdXSitjbG1vWGdq?=
 =?utf-8?B?Vy9oV1YxRHFUajBzanBQZWxxRm5KUzJhcmlCL2gweHRaai9adC9SLzd3cVZI?=
 =?utf-8?B?WDBvWDB5SnNKaFdrallzS1lDcFh2cm9QWFU5dE0wTEswaU93MmtsajR0bEhj?=
 =?utf-8?B?Z0RSekIzOEtLdS9WRTdGVU45bWxuNHlUMEF1N0phOEtqYUFRZXdvWldCL0RJ?=
 =?utf-8?B?NHJ4SlhoVUV6dUxCdzhuWUIrYTFqc284WWZaajBaa2xhTTkwSlVKYThvMGV3?=
 =?utf-8?B?Ullua2c1dWxNTTVxMUMzY3JnMUtsU00xS3hPSERBTDc2K3dOUVZYNkVJUVd0?=
 =?utf-8?B?a09xSkNlYWxHU0pjNFltQ3EvRjY3NTkvTFQxbEpQZDhrRVFPUkh2c3BRL1c0?=
 =?utf-8?B?eFJ6MW5lRE03YUorZExlZUVpemlYR3dOaGw1VmMrT1J3RlZ4Y2tUSGM5NitG?=
 =?utf-8?B?VlFhYXR5ZUFJeHBMTVlEelh0RCtTM2M0L3dRNkhiTWlMQ0RiUDl3L0tMOW5z?=
 =?utf-8?B?Q3paK1YwcFlGYm1nbDZhaUlJdzAyMm9Ra3F5R1hFQ3dQQ3Yya0hiRnhsRi9K?=
 =?utf-8?B?WW16Z2o0WDllQXBPVmhnQVkyUXNxdTFaUGt1T0QzZlhNU3Zlb0IvRGEvR2lZ?=
 =?utf-8?B?cEZVOE5MWjg4ay9CL3NlRVJnNHhFNHE1a0VBbTZEOE9RTkdjakZlUm5iWjRI?=
 =?utf-8?B?VFJOUjNSYllRNVI0dlgwUS9qOUkyZkZwaXI4anpwOFM5Uk0wRWVJOEd6eVRF?=
 =?utf-8?B?Wks3bnVXSjk3eEUvc2NsZDYrN3ZsZGtqOVZCR1dUS25FZlh2QVdCb3JxMGN2?=
 =?utf-8?B?MFZXS1F6eEhQQ3UzQTRoazVFaUJmT1lQd2kzRUNLYnJiWHQxZVRJK29iMk9r?=
 =?utf-8?B?cTVpaEZUU05NUWg3akRscnhTQXlGUmtvRzk5U1dyZXEzbjhtMWJtcTFUblNK?=
 =?utf-8?B?bHBtK0diSWRKQ3ZzbUVoanUxWlIvRi9MOUR1L3BSRjEwM1RXdlExeUZMQ21H?=
 =?utf-8?B?OXd2RmxVL0hQa2w1TWlvaEZhM3N5TmNhUjJyZmRJaGVEMFdnTkt4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb0c998-d4e1-4ca2-81e2-08de73bf3cc1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:10:33.0177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JE67tXZG3oRCldmSx7tIC807X+S4X+8wUTso0yKX4ufem8p/hiLnOjOmX7RJeDJ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940
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



On 2/23/26 15:33, Dan Carpenter wrote:
> This provides gpio support over SCMI.  The device tree entry would look
> like this:
> 
>                  scmi_gpio1: gpio1 {
>                          compatible = "scmi,gpio";
>                          scmi,pinctrl = <&scmi_pinctrl 0 2>;
>                          pinctrl-names = "default";
>                          pinctrl-0 = <&pinmux1>;
>                          gpio-controller;
>                  };
> 
> The scmi,pinctrl phandle points to the function and the index within that
> function.  The pinctrl-0 phandle points to the initial pin configuration
> if necessary.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/gpio/Kconfig     |   6 ++
>   drivers/gpio/Makefile    |   1 +
>   drivers/gpio/gpio_scmi.c | 221 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 228 insertions(+)
>   create mode 100644 drivers/gpio/gpio_scmi.c
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 60c5c54688e6..7d22c1f792d1 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -723,6 +723,12 @@ config SLG7XL45106_I2C_GPO
>   	   8-bit gpo expander, all gpo lines are controlled by writing
>   	   value into data register.
>   
> +config GPIO_SCMI
> +	bool "SCMI GPIO pinctrl driver"
> +	depends on DM_GPIO && PINCTRL_SCMI
> +	help
> +	   Support pinctrl GPIO over the SCMI interface.
> +
>   config ADP5585_GPIO
>   	bool "ADP5585 GPIO driver"
>   	depends on DM_GPIO && DM_I2C
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 910478c0c7a9..0003ed74be67 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_SL28CPLD_GPIO)	+= sl28cpld-gpio.o
>   obj-$(CONFIG_ADP5588_GPIO)	+= adp5588_gpio.o
>   obj-$(CONFIG_ZYNQMP_GPIO_MODEPIN)	+= zynqmp_gpio_modepin.o
>   obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+= gpio_slg7xl45106.o
> +obj-$(CONFIG_GPIO_SCMI)		+= gpio_scmi.o
>   obj-$(CONFIG_$(PHASE_)ADP5585_GPIO)	+= adp5585_gpio.o
>   obj-$(CONFIG_RZG2L_GPIO)	+= rzg2l-gpio.o
>   obj-$(CONFIG_MPFS_GPIO)	+= mpfs_gpio.o
> diff --git a/drivers/gpio/gpio_scmi.c b/drivers/gpio/gpio_scmi.c
> new file mode 100644
> index 000000000000..a859ad610587
> --- /dev/null
> +++ b/drivers/gpio/gpio_scmi.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2026 Linaro Ltd.
> + */
> +
> +#include <asm/gpio.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <scmi_protocols.h>
> +
> +struct scmi_gpio_priv {
> +	struct udevice *pin_dev;
> +	char *bank_name;
> +	u32 num_pins;
> +	u16 *pins;
> +};
> +
> +static int scmi_gpio_request(struct udevice *dev, unsigned int offset, const char *label)
> +{
> +	struct scmi_gpio_priv *priv = dev_get_priv(dev);
> +	int pin;
> +	int ret;
> +
> +	if (offset >= priv->num_pins)
> +		return -EINVAL;
> +	pin = priv->pins[offset];
> +
> +	ret = scmi_pinctrl_request(priv->pin_dev, SCMI_PIN, pin);
> +	if (ret == -EOPNOTSUPP)
> +		ret = 0;
> +	if (ret)
> +		dev_err(dev, "%s(): request failed: %d\n", __func__, ret);
> +	return ret;
> +}
> +
> +static int scmi_gpio_rfree(struct udevice *dev, unsigned int offset)
> +{
> +	struct scmi_gpio_priv *priv = dev_get_priv(dev);
> +	int pin;
> +	int ret;
> +
> +	if (offset >= priv->num_pins)
> +		return -EINVAL;
> +	pin = priv->pins[offset];
> +
> +	ret = scmi_pinctrl_release(priv->pin_dev, SCMI_PIN, pin);
> +	if (ret == -EOPNOTSUPP)
> +		ret = 0;
> +	if (ret)
> +		dev_err(dev, "%s(): release failed: %d\n", __func__, ret);
> +	return ret;
> +}
> +
> +static int scmi_gpio_set_flags(struct udevice *dev, unsigned int offset, ulong flags)
> +{
> +	struct scmi_gpio_priv *priv = dev_get_priv(dev);
> +	const int MAX_FLAGS = 10;
> +	u32 configs[MAX_FLAGS * 2];
> +	int cnt = 0;
> +	u32 pin;
> +
> +	if (offset >= priv->num_pins)
> +		return -EINVAL;
> +	pin = priv->pins[offset];
> +
> +	if (flags & GPIOD_IS_OUT) {
> +		configs[cnt++] = SCMI_PIN_OUTPUT_MODE;
> +		configs[cnt++] = 1;
> +		configs[cnt++] = SCMI_PIN_OUTPUT_VALUE;
> +		if (flags & GPIOD_IS_OUT_ACTIVE)
> +			configs[cnt++] = 1;
> +		else
> +			configs[cnt++] = 0;
> +	}
> +	if (flags & GPIOD_IS_IN) {
> +		configs[cnt++] = SCMI_PIN_INPUT_MODE;
> +		configs[cnt++] = 1;
> +	}
> +	if (flags & GPIOD_OPEN_DRAIN) {
> +		configs[cnt++] = SCMI_PIN_DRIVE_OPEN_DRAIN;
> +		configs[cnt++] = 1;
> +	}
> +	if (flags & GPIOD_OPEN_SOURCE) {
> +		configs[cnt++] = SCMI_PIN_DRIVE_OPEN_SOURCE;
> +		configs[cnt++] = 1;
> +	}
> +	if (flags & GPIOD_PULL_UP) {
> +		configs[cnt++] = SCMI_PIN_BIAS_PULL_UP;
> +		configs[cnt++] = 1;
> +	}
> +	if (flags & GPIOD_PULL_DOWN) {
> +		configs[cnt++] = SCMI_PIN_BIAS_PULL_DOWN;
> +		configs[cnt++] = 1;
> +	}
> +	/* TODO: handle GPIOD_ACTIVE_LOW and GPIOD_IS_AF flags */
> +
> +	return scmi_pinctrl_settings_configure(priv->pin_dev, SCMI_PIN, pin,
> +					       cnt / 2, &configs[0]);
> +}
> +
> +static int scmi_gpio_get_value(struct udevice *dev, unsigned int offset)
> +{
> +	struct scmi_gpio_priv *priv = dev_get_priv(dev);
> +	u32 value;
> +	int pin;
> +	int ret;
> +
> +	if (offset >= priv->num_pins)
> +		return -EINVAL;
> +	pin = priv->pins[offset];
> +
> +	ret = scmi_pinctrl_settings_get_one(priv->pin_dev, SCMI_PIN, pin,
> +					    SCMI_PIN_INPUT_VALUE, &value);
> +	if (ret) {
> +		dev_err(dev, "settings_get_one() failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return value;
> +}
> +
> +static int scmi_gpio_get_function(struct udevice *dev, unsigned int offset)
> +{
> +	struct scmi_gpio_priv *priv = dev_get_priv(dev);
> +	u32 value;
> +	int pin;
> +	int ret;
> +
> +	if (offset >= priv->num_pins)
> +		return -EINVAL;
> +	pin = priv->pins[offset];
> +
> +	ret = scmi_pinctrl_settings_get_one(priv->pin_dev, SCMI_PIN, pin,
> +					    SCMI_PIN_INPUT_MODE,
> +					    &value);
> +	if (ret) {
> +		dev_err(dev, "settings_get() failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (value)
> +		return GPIOF_INPUT;
> +	return GPIOF_OUTPUT;
> +}
> +
> +static const struct dm_gpio_ops scmi_gpio_ops = {
> +	.request	= scmi_gpio_request,
> +	.rfree		= scmi_gpio_rfree,
> +	.set_flags	= scmi_gpio_set_flags,
> +	.get_value	= scmi_gpio_get_value,
> +	.get_function	= scmi_gpio_get_function,
> +};
> +
> +static int get_pins(struct udevice *dev, u32 function, u32 index, char **f_name,
> +		    u16 **pins, u32 *npins)
> +{
> +	struct scmi_gpio_priv *priv = dev_get_priv(dev);
> +	struct pinctrl_scmi_priv *pin_info = dev_get_priv(priv->pin_dev);
> +	u32 group;
> +
> +	if (function >= pin_info->num_functions)
> +		return -EINVAL;
> +	if (index >= pin_info->function_info[function].num_groups)
> +		return -EINVAL;
> +	group = pin_info->function_info[function].groups[index];
> +	if (group >= pin_info->num_groups)
> +		return -EINVAL;
> +
> +	*f_name = pin_info->function_info[function].name;
> +	*pins = pin_info->group_info[group].pins;
> +	*npins = pin_info->group_info[group].num_pins;
> +
> +	return 0;
> +}
> +
> +static int scmi_gpio_probe(struct udevice *dev)
> +{
> +	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> +	struct scmi_gpio_priv *priv = dev_get_priv(dev);
> +	struct ofnode_phandle_args args;
> +	int ret;
> +
> +	ret = dev_read_phandle_with_args(dev, "scmi,pinctrl", NULL, 2, 0, &args);
> +	if (ret) {
> +		dev_err(dev, "failed to read scmi,pinctrl phandle: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = uclass_get_device_by_ofnode(UCLASS_PINCTRL, args.node, &priv->pin_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to find pinctrl device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = get_pins(dev, args.args[0], args.args[1], &priv->bank_name,
> +		       &priv->pins, &priv->num_pins);
> +	if (ret) {
> +		dev_err(dev, "failed to get pins for %u %u\n", args.args[0], args.args[1]);
> +		return ret;
> +	}
> +
> +	uc_priv->bank_name = priv->bank_name;
> +	uc_priv->gpio_count = priv->num_pins;
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id scmi_gpio_match[] = {
> +	{ .compatible = "scmi,gpio" },


Can you point me the dt binding document?

I am aware about this one and grep is not returning me anything from linux-next too

https://lore.kernel.org/all/20231002021602.260100-1-takahiro.akashi@linaro.org/

Thanks,
Michal
