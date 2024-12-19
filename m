Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0941E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 04:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 285038021D;
	Thu, 19 Dec 2024 05:21:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OA/QrP0f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F267180241; Thu, 19 Dec 2024 05:21:51 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5570B8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 05:21:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6Z2X304UYdQKeBGwgG9M3sVG0HV9suMRY2hXV/abj3z9/JVY9mhi8hLnC5+2yORkbbMrtJXlJzUmO7nqk+Xbjnda2JTWB7XadbHfScWgT68uDJ6Opo9xlAZVlkJWn44w99EV3jarYTueGsfKBlhwufgVciCm0lOFn8lmd7wwm3spFrXhq0cT6SKFaDAzE7yUIcUi6xcnGF+7muNslAa3tvY/ngSgaXYjBkCeaVx87DWbu4qAjKAuxQKBt3Cd/9FeIXVyiwRLpZRAkgJp8g8Q3XuIT9dvRldvI0BtsDW4WHOy087b2CMzETYD1cyFCZl1UEQrjXGLygv+kseGx3vRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zEqaDWagkSUhyPVCH6X3E1bCe0RtVzfCgYN8fOAoww=;
 b=wqtDZnziSGMRPWFa5nj8W0pBs3F6PZ9CwmLgnUsRw64Mb8Jqlc1vE5CRXZtFbQtsvYWMKbY5jMfW/D4f85Km6I5F8thZk/x3try1bT0ElfLI2VDGyLJ3GsBsJCgCaO2xmlzuMirJCXBpmSbB0oVdRsP9jV4uZ/hLDdPwZQRKZxz27VajuWXWrcQcPnHe7vhD6kNfKxlhknnAYt36yzgWkIGKiFW8Z1Pvmt78ent3hWoDEnApEEqdfAlfgbly0/Duw6HzK9lNloEMRc7LKT6J1uYUGkAvQ9QLXjaiMgxZazB2OF4cBfWpbtYN9Fx2uIgRUDSZ9Em36PadN7psZI0ImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zEqaDWagkSUhyPVCH6X3E1bCe0RtVzfCgYN8fOAoww=;
 b=OA/QrP0ffb+PEMAq5NPCjFG4Cz1amsL/S6KeBRK/gSZuQWKc6Ss3o5xazFJRBt7qPrJUKbdMWiRfbkh6TGiID1KPMMQ276JLQUheN84+SCBHK0xKD0NKfmf7ecwLrpKjTHN8fOWK+iwQZ+KxIa0WLvt0ARa1YqcIG+92sj3545g=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Thu, 19 Dec
 2024 04:21:45 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 04:21:45 +0000
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
Thread-Index: AQHbS8U++/+ZgliyKU+5ZpBpRoNYRLLoAMqAgABIX5CAAGvTgIAALkRwgAJYDYCAAIjQkIAAThWAgADwiVA=
Date: Thu, 19 Dec 2024 04:21:45 +0000
Message-ID: <SA1PR12MB86973CA2A3534CA9FC48DDA698062@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241211120644.775575-1-venkatesh.abbarapu@amd.com>
 <fccae74a-3097-4172-8ae5-3bc72e8d9aa0@denx.de>
 <SA1PR12MB869702808B7A784031F17F83983B2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <3307c1e3-123b-4ff1-8140-18be7393b5e5@denx.de>
 <SA1PR12MB86974EDF358A58732A9B7A6F983B2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <7f2b69af-ea98-4d22-a831-e484811c9715@denx.de>
 <SA1PR12MB86975AD9D85A5F7865FF4AFD98052@SA1PR12MB8697.namprd12.prod.outlook.com>
 <7cef71fc-7d7f-4c9f-b28c-e2b1ab893f75@denx.de>
In-Reply-To: <7cef71fc-7d7f-4c9f-b28c-e2b1ab893f75@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|BL1PR12MB5947:EE_
x-ms-office365-filtering-correlation-id: 37358a65-3124-4d18-de57-08dd1fe4a603
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VlIwVit0Z3FraEN2SGhWZTlCKzBuL28zWGVRNWduaDRtd1dJQ3llWFQ0S0tO?=
 =?utf-8?B?NnE5N0FaSWh2Y0N1dEpJeXVBT2Z2djVCMURvUmVGQm9oMGo4NWJ0MmpqbW5D?=
 =?utf-8?B?MDNSMnljRktQY3p6eGJyMld4Mk1hL2lFTlQ4UTR6Y2dQZlNsbGFIalNna3Vt?=
 =?utf-8?B?enlJSmpvM2RUc1ZHSTlzSEZUcTdpRXh0UzhkOHFscHRuQzdIcXZJSGJsenpL?=
 =?utf-8?B?V0R0Q1hLSEt0SW5OU2YybkszNmpWbU5rbXFuK3VPNGJlOUV6WWVnTmJqeVRX?=
 =?utf-8?B?d0JLVDVIVnh1bEpkSmxZTnVuMDAwWHRkNHFyYW9jYmxqQnVNRkhxRlNPNC9h?=
 =?utf-8?B?VS9ZVi9SRzg1YWtRQmtGVFRJZDB3NlNPZmdxMlVXTjN3bGdtTUYrZTZzdU5o?=
 =?utf-8?B?L0hCUkhLZzNkSHU3c3VnV0ZGU05uQlN5b0dMQVl2NUozbFJpeDgyZ3dobktK?=
 =?utf-8?B?TnA4aVE2WVNlZUIwaDFSbnZVQnVjTkFabjJjSE5FdXNxUHJIc3k1akZDU2FS?=
 =?utf-8?B?a08wNjBhOEZwS1JLcDRuRWVBSHJrTXpLaTFnY0hPdURPdGtFeFVHaUxmWlo0?=
 =?utf-8?B?aHVaci9LMVhLekZiYVpiTlJQM1FWZDVaS05RREkwZ3B0WVY4bWlDcHpSeTk1?=
 =?utf-8?B?a3lQb1E0aG9iZlM0VndheVhNYUFaOVJwNzJxbE8rQ1d6WVdhd2hiaVozb1Y3?=
 =?utf-8?B?QU5kUUR4REExVStocTVKd2tQeFBVSFhEdWNML3FnaHlSS0ZZai9YUGg2bDdK?=
 =?utf-8?B?OVdEYVp4cDhMMHJrVmJWeGFjNTVJc3BESGJvNlRuWTVsTkd4Vnh6WTNHMGlJ?=
 =?utf-8?B?UkJqdDlycjl2azRTU0FMaVZucE5YL01XdENNWVZ2dCt4YWVRVDJpeUxOS1pK?=
 =?utf-8?B?d3NFTGpkeUhqTEJHU3NkQ2xZOVppbGNNTFhWMmw2eHVJV3pubVhycHI0TEc0?=
 =?utf-8?B?UFpwV0VKci9XSmQ2RUU5bXlBajI0dlUzeHRLRXZSdVJxRE5KV2xyWVNUcEEv?=
 =?utf-8?B?RHNwYzRVSHhHeWtQVEM0dlhQR3hEa2Z4NjBxanhyRVB6bHEvTzVCTFl1Rmh4?=
 =?utf-8?B?cHkvbXAveTJ6cGJLOEgrUzZzRzNESEZZQ3lmMkYvNTYrUGJSYkpoeGVwSTgw?=
 =?utf-8?B?cFM3bUZKZTl3VnI4ZXFoYkYyZ2k2VnJsQUZQbUx6TEt3TXVJTkxqTWJOeTF5?=
 =?utf-8?B?NmQ4R3JhT1lpQ1JoaUNyRE9KQlZRZWd1WVdDU0U3NG0yMENBb2x5Wk9JczZI?=
 =?utf-8?B?cEs2Wm1KbEF2eDE4bzIzY2dPSFhEaVZaQW9MRzlydmVsVExFYnlsMWxNRk1R?=
 =?utf-8?B?Ui9RYWFBSE9ZMFVtWkg4WFg2aW84OGNhNUk1UnJER0tDNis4V2cvTy8raVlF?=
 =?utf-8?B?eUg2S0NPd3RWNTZmajAvOHRFelZlUGlhNjhldDhHUGVxQzBKS0pnczliZ0Mv?=
 =?utf-8?B?RnVoNm9HNG1ibkl6b3BCaC9ia244VWc1a0UvQ2cxd1J2SUlFYlBrVjU2eHhr?=
 =?utf-8?B?c3cwYUxnd01UL0ZSYmlvNk4yamEzUTVRL0FxVnVLQ1BnWVE0eUFJbFNmY2tH?=
 =?utf-8?B?VEkvR1NzQmpYUVcydkc5REhYbHZVMnVYRy9xV2hqYkhsRTB0eGd4ZjFXTUtC?=
 =?utf-8?B?L1dRRWl3eWJETlZmd1pDWUJDcjFGaHQ1VHlZTzdCbVI4dmt5WkcydzVwejF6?=
 =?utf-8?B?NnM3MWtRN3BUM0pmQytRd2ovY0VrdVorM1JDVUdFTEV1UGdTcVBmRHFqL3pT?=
 =?utf-8?B?cys4OWJ0ZlF5eGVDQkN3NFZkdGxITGNzaDI2TVJGWXNjbE1IODExeU16NTdt?=
 =?utf-8?B?ajFoeGNIQXE4VlRTVE91VTJsWDE5bUVyb0lRNzJTNDZTL2wrb0FYdGJSd3JF?=
 =?utf-8?B?elZXQU9wNjN1eFZYN1RXbnhxZHVOazUyMk8rYSs4TGpBZE9ialhIWmNLbWxL?=
 =?utf-8?Q?MmkAY5UjwnK67XLtFB/G3TgHGyU3cA08?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkFHQTRCRDUwTTl4bHRTeUlKbHJsM3VZeUlLVENyb2ZiQ2tpWHJyR2hyS1B5?=
 =?utf-8?B?VEFCTGkzZU12aFVzencvcjJ6QklwWExjTXpZbU5tcDM3MEliQ3lNaGdHYkc1?=
 =?utf-8?B?RHUvUjNpeHR2MGpINmhjYUdmTDhNSC9QQks0ZjRBM0tqdXJ0VkkxWUpzREVR?=
 =?utf-8?B?SnBteDFIcUxoTmxISEVVTUN3SC9UbjFOdHZWYTNyQ2N1cTN2ODRjTklSbGlC?=
 =?utf-8?B?OHZpQjB4Q3hrY3dqTWpxWlhwSVpFV3lxT05kU3V4Zmt1ckhRcFZ5eXZWWWhW?=
 =?utf-8?B?VmhSeWVVQ3hQcTRyR2w2L25ITS9kTWh4TzhNRHpBZ0hLOFFYL1gzQmluR2lX?=
 =?utf-8?B?M05Yd0QzNmswSmRjOVVvVEdzRTZlbFdTODkwUit6OWkwTktjbm1QV3l2MjBq?=
 =?utf-8?B?SnEwZVpCaVFBNkx5Z2pDa3EyamN3L29OaUxmekk5TnE2ZXBhZGhKWWxZZVND?=
 =?utf-8?B?dUJJc0cwZERsektodXkwektHUjdKT3B6MldMR2I0aHgyK2xwRzFucnh2Z1ls?=
 =?utf-8?B?R0ZJT2lpVXppSXdiVnorZUNkVnlRQVY3bC9WbUpDcG9WUWx3TWlUS1BxM2l0?=
 =?utf-8?B?NHFjWUoybVFTQWVNN2NJNTRIQlY2V080NjRNN2FieVU4eS8rUkRBZFFxVEdE?=
 =?utf-8?B?Y2pxaVJNNEo0M3NvVVJmVXYyM0xoUUcwWFRIK2I2UlVWWElyR3AyZGFXTURB?=
 =?utf-8?B?QjFsc0RjWnArTGpYM3hCR0NuQkZxNVI2VTlIM3oxdG5DcFI2VFhBSXN6SWlC?=
 =?utf-8?B?cldhaC91RnV1WTkyZjBWUk84L2dnZmZoSmRHY1VhWExPSE9peFpzOC92WEJL?=
 =?utf-8?B?cTJsL0gxTUdEQ0RKSzBGM29OUERnL3F1dCtxSllCbDg2UjFwVDZyWWEwbWV4?=
 =?utf-8?B?WUtNTUd6bVdaMUprKzU2T2VBQmVtUFZoTzdMSmxsdUhGTWpxRDhpTE51RC8z?=
 =?utf-8?B?YUhLc01xb3dqR2JYbjZYSlVCZ0dweHJoVjdHb3hOTnN3dmppVWE1NTl3cFBj?=
 =?utf-8?B?bVpiRWdaV1VBNksvb1l0UDN2YWFhazUyTXA5cGNnSENQRzBDUnd2eGtVdERS?=
 =?utf-8?B?VE44SE9HTDZkNllTQXgrb2tmUS9Hc3ZGanFwSVM2SWVSbWdYUXFWTXZUeTJ4?=
 =?utf-8?B?MUJqUTF4QzY4c3hMS0dIdGwxVkhob0tRMGpFMEZjMFBDdmlTY1RCdlVpVVVV?=
 =?utf-8?B?ZlVja05wWGNna2ZOSG5uSTgrOThOc091NVI4eHUyVWllN0IrK3FmQWc1S3B3?=
 =?utf-8?B?U3BMK1YrcWxmVStlTFJ6RElkOHNnS2hNWDI5ZG1ydXZBSHV2a0lWakU3V2FM?=
 =?utf-8?B?K2NUWTF2Zk90czRaYUZkK0VlOVQrakYvUmIyTTdqZHlROVAzU1ZFTVRpSmda?=
 =?utf-8?B?TkJvNzJSbnVuUWt0RVpkVGxSaFJoK3ZXZ0Y4OWZBdFZkbmZ6K3I2d2lpMHpB?=
 =?utf-8?B?RFBBNlNjcDVqZVU3UW1pSFlwTkhNSGtKZXVkT216MElNRlFOU1dhclluTG5J?=
 =?utf-8?B?K09hNVR0ZXhKZU9LVHFydWNBSzZGRnhLdSsxa0dpakZoVUVkZkpuTlAyejBh?=
 =?utf-8?B?NEM0SmxNTmhwdUtYTzRNOFBkZnFudm1vWGFOY0VjbWRHRGRBMG1zTXhaT0M2?=
 =?utf-8?B?Y0V0ZmxCTXN5bGNPbTB1REZFbzcvaWNQaFFPQSt2aCtTbzkrOEpSUzlFaHh5?=
 =?utf-8?B?d2tuUDVkcUZ2WXB3TXZ6U01WU20wSjE2dmVFZ0lLWko1Vm51TzhwUGNOQjR0?=
 =?utf-8?B?eE5BOVlDdnFYRkowV2F3eURCUi9zU245MC85NVdYWEpGbE50MDZZM0lRVlFh?=
 =?utf-8?B?cjB5TmVDdW82TzZwQTJ2U29sRTBKclNpMHEwUjBzd0hEYnNPNVdOVG9ud1Ax?=
 =?utf-8?B?S1V0MlpYc0dDdTFiQUR4Ny9WUFZZWWw1ZWo3MUZvdXdHQXFvSmtjU3hIQ2tz?=
 =?utf-8?B?Ui9XbHZOSk9nQWdpdXg4d0h2UVNHSzQ5NHBXRDJnQUtnb1F6ZmNDb21NTnlt?=
 =?utf-8?B?RFRZbnlwRTMwbk94UkpNYWc4ZzhFamhwUTk5dzUxc3p2V3huM2dBTGNydHl0?=
 =?utf-8?B?bGFiWjBseDN2Sm4zU2VBSjhTWDJUVDlHb3pEZUlaS21LamNOUDJZbExNTlYx?=
 =?utf-8?Q?tvqA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37358a65-3124-4d18-de57-08dd1fe4a603
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 04:21:45.4609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JO735LNoFDqypI0BsMYJfO8n3GUNo12sJVk2ryY2w1BBz3VXI2+OFSt28bTbnmt0Qt1MtskSGJWZgLvFcRCkZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947
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
cmV4QGRlbnguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMTgsIDIwMjQgNzoyOCBQ
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
VEFDS0VEX1BBUkFMTEVMIGlzIGVuYWJsZWQNCj4gDQo+IE9uIDEyLzE4LzI0IDEwOjIyIEFNLCBB
YmJhcmFwdSwgVmVua2F0ZXNoIHdyb3RlOg0KPiANCj4gPj4+Pj4gRm9yIHBhcmFsbGVsL3N0YWNr
ZWQgY29uZmlndXJhdGlvbiBhbmQgYWRkcmVzcyB3aWR0aCB0aGUNCj4gPj4+Pj4gInJlbV9iYW5r
X2xlbiIgd2lsbCB2YXJ5DQo+ID4+Pj4gYW5kIGFzIHdlIGRvbid0IHdhbnQgdG8gZGlzdHVyYiB0
aGUgZGVmYXVsdCByZWFkIGZ1bmN0aW9uYWxpdHkNCj4gPj4+PiBhZGRlZCB0aGUgaWZkZWYgc2Vw
YXJhdGVseS4NCj4gPj4+PiBXaGF0IHdvdWxkIGhhcHBlbiBpZiBib3RoIFNQSV9GTEFTSF9CQVIg
YW5kDQo+IFNQSV9TVEFDS0VEX1BBUkFMTEVMDQo+ID4+IGFyZQ0KPiA+Pj4+IGVuYWJsZWQgb24g
YSBzeXN0ZW0gdGhhdCBvbmx5IGhhcyBvbmUgU1BJIE5PUiBhdHRhY2hlZA0KPiA+Pj4+IChub24t
c3RhY2tlZC9wYXJhbGxlbCkgPyBJIG5vdGljZWQgdGhlIHNlY29uZCAiY29weSIgb2YgdGhlIGNv
ZGUNCj4gPj4+PiBiZWhhdmVzIHNsaWdodGx5IGRpZmZlcmVudGx5IGluIHRoZSBlbHNlIGJyYW5j
aCwgc28gZG9lcyB0aGF0IG1lYW4NCj4gPj4+PiB0aGlzIHdvdWxkDQo+ID4+IGJyZWFrIHN1Y2gg
c2V0dXAgPw0KPiA+Pj4NCj4gPj4+IElmIGJvdGggU1BJX0ZMQVNIX0JBUiBhbmQgU1BJX1NUQUNL
RURfUEFSQUxMRUwgYXJlIGVuYWJsZWQsIHRoZQ0KPiA+PiAicmVtX2JhbmtfbGVuIiBtYW5pcHVs
YXRpb24gaXMgZG9uZSB1bmRlciB0aGUNCj4gPj4gQ09ORklHX0lTX0VOQUJMRUQoU1BJX1NUQUNL
RURfUEFSQUxMRUwpIGNvZGUgYW5kIHRoaXMgd29uJ3QgYnJlYWsNCj4gYW55DQo+ID4+IGRlZmF1
bHQgZnVuY3Rpb25hbGl0eS4NCj4gPj4gV291bGRuJ3QgcmVhZF9sZW4gY2FsY3VsYXRpb24gYmUg
ZG9uZSB0d2ljZSA/DQo+ID4gWWVzLiAgQXMgInJlbV9iYW5rX2xlbiIgd2lsbCBiZSBjaGFuZ2Vk
IGJhc2VkIG9uIHBhcmFsbGVsIGNvbmZpZ3VyYXRpb24sIHNvDQo+IGFkZGVkIHRoZSBhZGRpdGlv
bmFsIGNvZGUgY29weSB0byBub3QgYnJlYWsgdGhlIGRlZmF1bHQgY29kZS4NCj4gQ2FuIHlvdSBw
bGVhc2UgYWxzbyB1cGRhdGUgaXQgdG8gYXZvaWQgdGhlIGNvZGUgZHVwbGljYXRpb24gPw0KVGhl
IGNvZGUgaXMgZW50aXJlbHkgc2VwYXJhdGVkIG91dCBiYXNlZCBvbiBDT05GSUdfSVNfRU5BQkxF
RChTUElfU1RBQ0tFRF9QQVJBTExFTCksIG5vdCBzdXJlIEkgY2FuIHJlbW92ZSB0aGlzIGFkZGl0
aW9uYWwgY29kZSBjb3B5LiBEbyB5b3UgaGF2ZSBhbnkgYmV0dGVyIHdheSB0byBhdm9pZCB0aGlz
IGNvZGUgZHVwbGljYXRpb24/DQoNClRoYW5rcw0KVmVua2F0ZXNoDQo+IA0KPiBUaGFuayB5b3UN
Cg==
