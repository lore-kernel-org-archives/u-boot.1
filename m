Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A378E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 09:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC619802EF;
	Wed, 18 Dec 2024 10:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PtrflHIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2403C80304; Wed, 18 Dec 2024 10:22:14 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73EF78022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 10:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ucm6plXPfUBXkaJTJIKu/HjKvmco3xgzm86vjE3qC9sj0+D15XohRcDcKQsvN/MmXsHHOdwWl9GjkFNHu8TGkUeySNK9EvqU0SNhuJOWsS31c87H6FGi9S7vknyYAOfIbYstrnsBc0liWdrZHTiAOnFyvY8EqtjZZfLof48Lbqb7GErdsSwP9rUDcIjzdKtKrTpSbkcjC51TEsiVcvjJGF74+jFLIc/ff0TwaX/bwQjfIu96kTmt1a5wvxJKarIuljATzB1rXU5XFr+wWV7n4h8iexN0XLes24UH32gAasegTSVdbTVO2urvdl6mxmFYnAwsq5zbRqZP0J+FLxa7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksWmjnelU9zH9e87VyfSzpgLwfwgEoKbGgudXkKoOZ0=;
 b=dGpTCExJeZNz6hKWETnEdzWYvEddEsRLzq49wVWpH46Y238KhnlfExMPeLadx7AhvxqwOK8PPeI8Ye1S1zejyOxxiI9P/HI4RZNMG64B/bbtILsS733mjxUmJCBqN2uFlJSQXVUuCMA1n6Tvvn5irpkmwrdPPiS/Gyyi6SmCBODCrxngIYbbqtBF1pXNIKPRVsGV0BL/6ixQck4qXnxztnHtssitWEJnaLGFAGc5waml4IY0ZtzZ2Ei4rwOiOX5fJtHFd9/McCUCtczeg45ySxgwX8Ma7jmkCwfW+Gw5SGscJfc+2jI8blHNfDeZ3nAgTTUNXn8oK9vKNu8nY8K+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksWmjnelU9zH9e87VyfSzpgLwfwgEoKbGgudXkKoOZ0=;
 b=PtrflHICb7QcebFQnKEMsO6Vo/h0PBUL8vci2QyOzYicKKzBFJ9VciZYB3MwpZWVz4kqT+cFtmSExSx3shxb0zAZWGsi5mcUmweAA2Ph2N6IeZIZ8s3znMrN1uSSoqdhL6FVTv5QLiGMTKuvYyLpBfGnFzouuMO5V828kJBBoPk=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 09:22:07 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 09:22:07 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "tudor.ambarus@linaro.org"
 <tudor.ambarus@linaro.org>, "j-humphreys@ti.com" <j-humphreys@ti.com>
CC: "Simek, Michal" <michal.simek@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v2] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Thread-Topic: [PATCH v2] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Thread-Index: AQHbS8U++/+ZgliyKU+5ZpBpRoNYRLLoAMqAgABIX5CAAGvTgIAALkRwgAJYDYCAAIjQkA==
Date: Wed, 18 Dec 2024 09:22:07 +0000
Message-ID: <SA1PR12MB86975AD9D85A5F7865FF4AFD98052@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241211120644.775575-1-venkatesh.abbarapu@amd.com>
 <fccae74a-3097-4172-8ae5-3bc72e8d9aa0@denx.de>
 <SA1PR12MB869702808B7A784031F17F83983B2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <3307c1e3-123b-4ff1-8140-18be7393b5e5@denx.de>
 <SA1PR12MB86974EDF358A58732A9B7A6F983B2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <7f2b69af-ea98-4d22-a831-e484811c9715@denx.de>
In-Reply-To: <7f2b69af-ea98-4d22-a831-e484811c9715@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|CH3PR12MB9148:EE_
x-ms-office365-filtering-correlation-id: b94afe8a-75b4-4c42-1164-08dd1f45719f
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MlgzRHdMSVd0aHBBK0QrUzNqTkxWRUNlb2hIWGY2T2tDbXBuOHpYbHdqNzFF?=
 =?utf-8?B?TVlaWmVVczNuWVMzc1pualNlSHg3eGkxS1RCaGNrY21WdkdtZkZMT201SUMw?=
 =?utf-8?B?bXdBZ08rczdJcVdpeDQvcHNGbVBLNXdkU0lEb3JGMWF1VitpU2owZUJ2dUpY?=
 =?utf-8?B?emlPUldqYXBSQ1plcEloalhNUUFaRlJlZGhXOWVPVGNIT0JZTW50UlFvbWpz?=
 =?utf-8?B?WHhOZ3FTeVlyZ0tXbmJFUFh0MUIxRXlNczlsdmtXamk0WVFpZ2MvaVhmanNX?=
 =?utf-8?B?QStXTVpJTGUvRjlRalA1K04vMFhJTHRFSjhzNTlPVkNYTzNBZ2NKWGlGUkMr?=
 =?utf-8?B?dVpGY1hDK0ZmcEh4K2JBdXA2QmtXdzg2Wm5sWmx1WmFQbm5HbDVUTytDUDFO?=
 =?utf-8?B?ZWF2Zk83TzdFVHM5WEljN2FLZ05Ealc1R1Y3ZEw3aERwY1MzcVVISXh6ZnlI?=
 =?utf-8?B?NmpwamtzcUE0NGRYcGwra2Q4VitxRWtJWjVUVTc1S3FLckxZaisxK0QvVnJ0?=
 =?utf-8?B?UGNxTDlRczkrZGh3RVgxTlFHcHE4cUZyU0RCakd2Ty9NZ1Z1UkJhS0NKS3dM?=
 =?utf-8?B?aDNsRWpjQXc5WTNSbFB0TWh3MExCeHFnVndnRnJncmczc3dMVklNUWZlajJo?=
 =?utf-8?B?Z1YwM1EyQ0JJZVU1SnZOVmFsOUNvV05mU3NrZ2dGd1JuWUxTME1kMkZVK2pZ?=
 =?utf-8?B?RHlSbjJZdXdTMEhQQTJQME5IUjZJRW5rMnduSmw3YTdtdGZ0c041SXU3L0lu?=
 =?utf-8?B?ZVo2eFFxKzRTQVFXdDhmcjRTTlM0MG1GR29CMFB3dFRYMGs3UUI1N3ZuMnlH?=
 =?utf-8?B?T2VIOUIyY2Z1OFlMY3ZrbnRIZldMNVBqdFlpMlhwZ0w0bDV3WXU2SGg4TlhV?=
 =?utf-8?B?cXRUamRhR0FVc3ZrSGhTM3FqZC9CcDFFN05oRTBkdjZpZWs0U1N1VU5yc21U?=
 =?utf-8?B?OGZ4dkFvZ1Vxb3o3ekdJemkycDdsREkwSmlrQlFiZk1sZldsYUlLVlNSa0dt?=
 =?utf-8?B?a0s5R2MxaUZQTzgyZWh5R25sVm1ka1ROb0llaVhYSDFpQ2Q3Vm5wVUlYMWpR?=
 =?utf-8?B?M2tMZmpmeHRvcjJIS1RNblFtMldRYnFsamMycVdIK2NiNVhrU1c2T2dTVWph?=
 =?utf-8?B?ZGFhMys1ZEhhQ3V4T1JZSjJNWEY2TS9kT3hWT0g3aWh5VVUyNHhFeHcweFpH?=
 =?utf-8?B?M2lMenUzaXN5TDVoeEdTR3pLYUZJU1g2NFlhWUpWOEpPUHNZQzVyNUYzaFZ0?=
 =?utf-8?B?NlZ6YTMvQmpWMkNoUWpuZ3hSV1c4cFZCWXpBQm9sanpWTG4vN0FOSWYwTWJU?=
 =?utf-8?B?bENTY2dYdStuSTR6d1ZFM3NHVDBWbEQ3bTYyYTZteTA1aTJoeWQzdmIzcU9j?=
 =?utf-8?B?SXR6Vkd6b2NjU1FyckhJQXFKc25RL3NaZ2Z2clkzSlZKMXJNeklWMG5PMjZm?=
 =?utf-8?B?dTYzaVJWWkliN2RwcngwSDViWlc2eUNMMEllOGl0Q3d4THZnUzdPRFI1NW5y?=
 =?utf-8?B?TVI2enExQVpvNjI2SlgrZ3RQT29OYkErUW9DckZ3MnJtS3BseTBiYXBpU2l0?=
 =?utf-8?B?bzlwVnBFcEtENUVDUzJkN0NlVTFONFNRRHVwNnl0TzkwNTN1SGNRRGJJU016?=
 =?utf-8?B?b2Q0TmtiakZGcDVaV1RnaDY3TEYyL0hMUXZRNnZkemlia0w0ZVVRZlJBY3hE?=
 =?utf-8?B?T0U0RlBreDEyOXd0bVloOGhJTFdTTHVNRnNiSDJZejd4ZlU3TEVXTXBkMVRu?=
 =?utf-8?B?MkZ6K243MkNRRHgycVY3MGlEaDdxQkx5WklNcmlpL25JcTB5N2RtSXEyMUZW?=
 =?utf-8?B?VkJWTVJvRXZDQkxJK1pxek0zb1hXQ2Y3Vm91Z2IyczQzQktnY3FmVDZFYk9t?=
 =?utf-8?B?SEdSWWxRanNWZ2I5L2tuZE5OWjVlZGxQY0pwcjB0UzhOUGxDb21nMWdoTzFB?=
 =?utf-8?Q?equBgRcexK5k5wbu6cB7sQ8F4Ep1w70G?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHp4dXFqemFpWm8wYUo2dzJZUDl6N2dQZmwzVWZGdUtTd3hPeGFBdmFjRU0v?=
 =?utf-8?B?TDRhaFVsVzJPQXJRQWg2UzZ3OHVqRGRiVjVqU1RCOVZzNnVrbDByenFlczBi?=
 =?utf-8?B?MmR4dTFTUDBVZDF4S2V1ak1nVHBYTXFaMThZQXJxS244UUNWUTZZZWVUK0tS?=
 =?utf-8?B?SnVLK2laNjg2ajZ1UStjYzBnWGhHWU85dlRjL1RJc3RrcFpuaVMwWEhjZlIy?=
 =?utf-8?B?V1FTbGxkaG05bXF4ViszSmR6RDcyQ3ZjWitXTFhFbHNibEdYSkdTUVVEYUNX?=
 =?utf-8?B?R0xXZUExcER5QjNXckRMNEUyem5OVHBDWVg4WW1qU3VoNUtWa2ZpNmZJK0xn?=
 =?utf-8?B?REdEZ2tzUHJXMEJjUWtnaTFkMGFSNE1EWUY3RzBheHRQRVVkSUdBRjBTTWZn?=
 =?utf-8?B?TjJsSTBLejlPcVpodW5aM2NJOXlmU3VFYkJ0MnZhOTd3Vk0vTTVnUjE1eWVy?=
 =?utf-8?B?aHpuNWVFN2g5WDZsT2Y5L3dBRzNzbnBjWmgvMS8raXlDK3Y5azV3TCtEcTVM?=
 =?utf-8?B?WFBUM1ZIUWxoSVg3V3JsNlRGWTF1clRWa1pKeTczOTNNclhtdk1USHF0THgy?=
 =?utf-8?B?c0I0b1lTZytjcjJjWGFaOXpkYTVNS3FoV2pTbUhxWXZ3S0MzQ1JCL284bndQ?=
 =?utf-8?B?U3UzdUd1SytNWVpya3ROcSsyUldEVUxlS0w0MnUwbUNoMjV3aVJvbHR6U3l1?=
 =?utf-8?B?bFljRlV1SG82V09WTmM4d0dlUFRIZ09CUVdpWlBrNE5QNm9ZdytwSjdKcnBP?=
 =?utf-8?B?dE1XNEcwQ0FhdS9HL3F6VkhjSDNXNExrbFQ1dXVSK1k2Q29SZXA4SUZnZWpX?=
 =?utf-8?B?aFNUODV3eEpYbGhCeGJER3dEZ2pPNTg4T3JkRmJwYnBSWUJCZFRub25kY3pM?=
 =?utf-8?B?bHI2bnh4MzJOcklDbU9SdDNoa0liTng1YWNweVhYWlUzLzBzRnZiQ0ViOGlj?=
 =?utf-8?B?WEdPMFRISytjc1VBd0lJNHpTaHloamlWcURyOU1nQ2NFcUd0NU9WUVBOKzdF?=
 =?utf-8?B?angvcVFTVGliTkRhWHdIbzNWRUN1NTNMZUpPdFBpa2ROWnVBVEJjSXZVcGpR?=
 =?utf-8?B?NDB0ZWliRnpSQTBjbW1jcjRnekhnTzZNM2lDUkVSUVRCSEIxYS9Ec2hLQlZP?=
 =?utf-8?B?WkpidG0zNmMxM3g3R2J0SE4xL0FpNlZYVThmNTNrZExRUXR5RHRyWGNUM2t5?=
 =?utf-8?B?bEVyRXBXVzFnT0wwa2J0TWNJbFJyTnlSdmR1dFlNUDA0RFllTDlobGN4ekkv?=
 =?utf-8?B?andCdzlvSDU3TG5GTzlZOHRHR0JUSlBTQjNQNXNxcFd3S3JsaHBYSVRHNGF0?=
 =?utf-8?B?WFZLbGNsYmNvY3BBSHBvdUYrSUhhOTE4MGJqRUVGMHdWOVNzZ2t2MjEveERS?=
 =?utf-8?B?SWFWdndrM1NRMVpCR1Y3TlUwTFNSalZtMnBiSWp2NTlxL3ZtcGFvTkV3dzZM?=
 =?utf-8?B?YmxEN1JLdkE0SnhVd0RBbnZ2ditNbWRwcFlQRTVtc2MwTmFTOEJ1MzJlMk9B?=
 =?utf-8?B?R2hHRTFHVE53eHI5b0w1ZHpvUGExWlFHRmQ2bzJ4MXlNSWREczF0bDJxUmlt?=
 =?utf-8?B?R1VVZXI5S2dKdUtmV00xVXJLbUthUVJGWjdGN3NTOGZ5TERHTk1ROG1EZVdF?=
 =?utf-8?B?TjBZdHpiZHhoam9ieUJTaExOQmRGdjVVNjBwcjh2WndvdzI2d2NQV3JaY3lj?=
 =?utf-8?B?WDlLWkhTZzZtU21rQllxSzVacXBmc25nMU56eVo4bHRrZ08zTGJYZG5tTFZS?=
 =?utf-8?B?VEx2a3BFUTRFdlpOMktKbnpyZXhwYmdPd1hFeVJvcXNjYXoyWCtaWXJnYTBu?=
 =?utf-8?B?RTdXdUNrRUQ2VjRMdXpCWXRhYm1xQktqazFBWFc1Uk0vL0F5dTNrSkxxa2Fl?=
 =?utf-8?B?emNYSHlDOHZNT2FIQmF2SklNRmo4Nkc2OG51RUd1VXRUeUlmRnNqN01zQ2JV?=
 =?utf-8?B?NkNRL2Z5NGxGTmlKL1kzY3VQZ3RkQWJuaEQyKy9SSnJCbFQ0UmNrWWVYdVdn?=
 =?utf-8?B?V1BmT1RkRXNjTlRMMzFWNllOSU1zNFpLN0t6WW9TVStrSlZWRldzYVVMbVhj?=
 =?utf-8?B?OHp5Tk9GWkJkZk5pWUF0aWFNanNYK1R5MGZKWTBOSVRZOHR2aWNwVWF5akJX?=
 =?utf-8?Q?0wZk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94afe8a-75b4-4c42-1164-08dd1f45719f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 09:22:07.5474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlLGSfsVp8jbACdP39R+j/do0zVqa4UDyBtIfAV6qexhBth/ZbLbnm+N7FyW1++tSg90+tK/hUl87JmJuLfNxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQgPG1h
cmV4QGRlbnguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMTgsIDIwMjQgNjozOSBB
TQ0KPiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1QGFtZC5jb20+
OyB1LWJvb3RAbGlzdHMuZGVueC5kZTsNCj4gdHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnOyBqLWh1
bXBocmV5c0B0aS5jb20NCj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29t
PjsgamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+IHZpZ25lc2hyQHRpLmNvbTsgdS1rdW1h
cjFAdGkuY29tOyB0cmluaUBrb25zdWxrby5jb207IHNlYW5nYTJAZ21haWwuY29tOw0KPiBjYWxl
Yi5jb25ub2xseUBsaW5hcm8ub3JnOyBzamdAY2hyb21pdW0ub3JnOyB3aWxsaWFtLnpoYW5nQGJy
b2FkY29tLmNvbTsNCj4gc3RlZmFuX2JAcG9zdGVvLm5ldDsgcXVlbnRpbi5zY2h1bHpAY2hlcnJ5
LmRlOyBUYWthaGlyby5LdXdhbm9AaW5maW5lb24uY29tOw0KPiBwLW1hbnRlbmFAdGkuY29tOyBn
aXQgKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0g
bXRkOiBzcGktbm9yOiBGaXggdGhlIHNwaV9ub3JfcmVhZCgpIHdoZW4gY29uZmlnDQo+IFNQSV9T
VEFDS0VEX1BBUkFMTEVMIGlzIGVuYWJsZWQNCj4gDQo+IE9uIDEyLzE2LzI0IDI6NTggUE0sIEFi
YmFyYXB1LCBWZW5rYXRlc2ggd3JvdGU6DQo+IA0KPiA+Pj4+PiArKysgYi9kcml2ZXJzL210ZC9z
cGkvc3BpLW5vci1jb3JlLmMNCj4gPj4+Pj4gQEAgLTExNDAsNyArMTE0MCw3IEBAIHN0YXRpYyBp
bnQgc3BpX25vcl9lcmFzZShzdHJ1Y3QgbXRkX2luZm8NCj4gPj4+Pj4gKm10ZCwgc3RydWN0DQo+
ID4+Pj4gZXJhc2VfaW5mbyAqaW5zdHIpDQo+ID4+Pj4+ICAgICAJCQkJbm9yLT5zcGktPmZsYWdz
ICY9IH5TUElfWEZFUl9VX1BBR0U7DQo+ID4+Pj4+ICAgICAJCX0NCj4gPj4+Pj4gICAgICNpZmRl
ZiBDT05GSUdfU1BJX0ZMQVNIX0JBUg0KPiA+Pj4+PiAtCQlyZXQgPSB3cml0ZV9iYXIobm9yLCBh
ZGRyKTsNCj4gPj4+Pj4gKwkJcmV0ID0gd3JpdGVfYmFyKG5vciwgb2Zmc2V0KTsNCj4gPj4+Pg0K
PiA+Pj4+IFRoaXMgY2hhbmdlIGlzIHJlYWxseSBpbm9idmlvdXMsIHRoZSBjb2RlIGFib3ZlIGxp
a2VseSBuZWVkcyB0byBiZQ0KPiA+Pj4+IGNvbXBpbGVkIG91dCBpZiB0aGUgU1BJX1NUQUNLRURf
UEFSQUxMRUwgc3R1ZmYgaXMgZGlzYWJsZWQgPw0KPiA+Pj4NCj4gPj4+IEluIHRoZSBzcGlfbm9y
X2VyYXNlKCkNCj4gPj4+IAlvZmZzZXQgPSBhZGRyOw0KPiA+Pj4gCWlmKFBBUkFMTEVMKQ0KPiA+
Pj4gCQlvZmZzZXQvPTI7DQo+ID4+PiAJc28gZm9yIHBhcmFsbGVsIG9yIHNpbmdsZSBjb25maWd1
cmF0aW9uIHdlIG5lZWQgdG8gcGFzcyAib2Zmc2V0IiB0byB3cml0ZV9iYXIoKQ0KPiA+Pj4gCXdy
aXRlX2Jhcihub3IsIG9mZnNldCIpOw0KPiA+Pg0KPiA+PiBUaGUgY29kZSBhYm92ZSBsaWtlbHkg
bmVlZHMgdG8gYmUgY29tcGlsZWQgb3V0IGlmIHRoZQ0KPiA+PiBTUElfU1RBQ0tFRF9QQVJBTExF
TCBzdHVmZiBpcyBkaXNhYmxlZCA/DQo+ID4+DQo+ID4+IFsuLi5dDQo+ID4+DQo+ID4gQWxyZWFk
eSB0aGUgY29kZSBoZXJlIGlzIGJlaW5nIGNoZWNrZWQgd2l0aCB0aGUgZmxhZ3MgU05PUl9GX0hB
U19QQVJBTExFTA0KPiBhbmQgU05PUl9GX0hBU19TVEFDS0VELiBEbyB5b3Ugd2FudCB0byBhZGQg
dGhlIGNoZWNrDQo+IFNQSV9TVEFDS0VEX1BBUkFMTEVMIGFwYXJ0IGZyb20gdGhlc2UgZmxhZ3M/
DQo+IA0KPiBZZXMsIHRvIGNvbXBpbGUgdGhlIGNvZGUgb3V0IGNvbXBsZXRlbHkuDQoNCk9rLi4u
V2lsbCB1cGRhdGUgdGhlIHBhdGNoLg0KPiANCj4gPj4+PiBJZiBJIGxvb2sgYXQgdGhpcyBjaGFu
Z2Ugd2l0aCAnZ2l0IHNob3cgLXcnICwgdGhlIGNoYW5nZSBsb29rcyBsaWtlIHRoaXM6DQo+ID4+
Pj4NCj4gPj4+PiAiDQo+ID4+Pj4gICAgICNpZmRlZiBDT05GSUdfU1BJX0ZMQVNIX0JBUg0KPiA+
Pj4+ICsgICAgICAgICAgICAgICB1MzIgcmVtYWluX2xlbjsNCj4gPj4+PiArDQo+ID4+Pj4gICAg
ICAgICAgICAgICAgICAgIHJldCA9IHdyaXRlX2Jhcihub3IsIG9mZnNldCk7DQo+ID4+Pj4gICAg
ICAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiBsb2dfcmV0KHJldCk7DQo+ID4+Pj4gKyAgICAgICAgICAgICAgIHJlbWFp
bl9sZW4gPSAoU1pfMTZNICogKG5vci0+YmFua19jdXJyICsgMSkpIC0gb2Zmc2V0Ow0KPiA+Pj4+
ICsgICAgICAgICAgICAgICBpZiAobGVuIDwgcmVtYWluX2xlbikNCj4gPj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICByZWFkX2xlbiA9IGxlbjsNCj4gPj4+PiArICAgICAgICAgICAgICAgZWxz
ZQ0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJlYWRfbGVuID0gcmVtYWluX2xlbjsN
Cj4gPj4+PiAgICAgI2VuZGlmDQo+ID4+Pj4gLQ0KPiA+Pj4+ICsgICAgICAgICAgICAgICBpZiAo
Q09ORklHX0lTX0VOQUJMRUQoU1BJX1NUQUNLRURfUEFSQUxMRUwpKSB7DQo+ID4+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKGxlbiA8IHJlbV9iYW5rX2xlbikNCj4gPj4+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlYWRfbGVuID0gbGVuOw0KPiA+Pj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4gPj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJlYWRfbGVuID0gcmVtX2JhbmtfbGVuOw0KPiA+Pj4+IC0NCj4gPj4+
PiArICAgICAgICAgICAgICAgfQ0KPiA+Pj4+ICAgICAgICAgICAgICAgICAgICBpZiAocmVhZF9s
ZW4gPT0gMCkNCj4gPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsg
Ig0KPiA+Pj4+DQo+ID4+Pj4gV2h5IGlzIHRoZXJlIHRoaXMgcGFydCBvZiBjb2RlIHR3aWNlIG5v
dywgaWZkZWZmZWQgb3V0IGRpZmZlcmVudGx5IGluIGVhY2ggY2FzZSA/DQo+ID4+Pj4NCj4gPj4+
PiAiDQo+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGxlbiA8IHJlbV9iYW5r
X2xlbikNCj4gPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlYWRfbGVu
ID0gbGVuOw0KPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4gPj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlYWRfbGVuID0gcmVtX2JhbmtfbGVu
OyAiDQo+ID4+Pg0KPiA+Pj4gRm9yIHBhcmFsbGVsL3N0YWNrZWQgY29uZmlndXJhdGlvbiBhbmQg
YWRkcmVzcyB3aWR0aCB0aGUNCj4gPj4+ICJyZW1fYmFua19sZW4iIHdpbGwgdmFyeQ0KPiA+PiBh
bmQgYXMgd2UgZG9uJ3Qgd2FudCB0byBkaXN0dXJiIHRoZSBkZWZhdWx0IHJlYWQgZnVuY3Rpb25h
bGl0eSBhZGRlZA0KPiA+PiB0aGUgaWZkZWYgc2VwYXJhdGVseS4NCj4gPj4gV2hhdCB3b3VsZCBo
YXBwZW4gaWYgYm90aCBTUElfRkxBU0hfQkFSIGFuZCBTUElfU1RBQ0tFRF9QQVJBTExFTA0KPiBh
cmUNCj4gPj4gZW5hYmxlZCBvbiBhIHN5c3RlbSB0aGF0IG9ubHkgaGFzIG9uZSBTUEkgTk9SIGF0
dGFjaGVkDQo+ID4+IChub24tc3RhY2tlZC9wYXJhbGxlbCkgPyBJIG5vdGljZWQgdGhlIHNlY29u
ZCAiY29weSIgb2YgdGhlIGNvZGUNCj4gPj4gYmVoYXZlcyBzbGlnaHRseSBkaWZmZXJlbnRseSBp
biB0aGUgZWxzZSBicmFuY2gsIHNvIGRvZXMgdGhhdCBtZWFuIHRoaXMgd291bGQNCj4gYnJlYWsg
c3VjaCBzZXR1cCA/DQo+ID4NCj4gPiBJZiBib3RoIFNQSV9GTEFTSF9CQVIgYW5kIFNQSV9TVEFD
S0VEX1BBUkFMTEVMIGFyZSBlbmFibGVkLCB0aGUNCj4gInJlbV9iYW5rX2xlbiIgbWFuaXB1bGF0
aW9uIGlzIGRvbmUgdW5kZXIgdGhlDQo+IENPTkZJR19JU19FTkFCTEVEKFNQSV9TVEFDS0VEX1BB
UkFMTEVMKSBjb2RlIGFuZCB0aGlzIHdvbid0IGJyZWFrIGFueQ0KPiBkZWZhdWx0IGZ1bmN0aW9u
YWxpdHkuDQo+IFdvdWxkbid0IHJlYWRfbGVuIGNhbGN1bGF0aW9uIGJlIGRvbmUgdHdpY2UgPw0K
WWVzLiAgQXMgInJlbV9iYW5rX2xlbiIgd2lsbCBiZSBjaGFuZ2VkIGJhc2VkIG9uIHBhcmFsbGVs
IGNvbmZpZ3VyYXRpb24sIHNvIGFkZGVkIHRoZSBhZGRpdGlvbmFsIGNvZGUgY29weSB0byBub3Qg
YnJlYWsgdGhlIGRlZmF1bHQgY29kZS4NCg0KVGhhbmtzDQpWZW5rYXRlc2gNCg==
