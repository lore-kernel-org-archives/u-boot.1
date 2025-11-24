Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A44CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 15:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2720083DEC;
	Mon, 24 Nov 2025 16:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZwUJqCrs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC70783DFF; Mon, 24 Nov 2025 16:05:31 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EF9F83B85
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvgW//m2VMp3rRA4pdh239shXCKDqyY5Y+ZXyTRCcAZq6UqqeZiwVoeGVOXyj1a7VuswtAvFQDaG35jXSifz9ZvRMGh9LktUjhnyyJBwkCcUnf2cARmpMadPSaG9+OR6bCiqNByaAmDAYdxmisAUuRtzGHJ1pEX0fAl0HS+90w8n5LYFExac15Ux8SMcrVHQyAJOLsV7V9C78UgjgWiaeD0rnJZANu+iP48DmiEu5I+NrNn9CWGzJUAkA61a4aHO/JEawUb1Wd7rE40lB7KqAqufba4TfSFS6dIGQsHrvSJuUQaSPQSZgfY/THdCSVROKOSg8IGgETkMacDj4YnBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg1CNX4zyvZ3HC1Ls0Dkx+av0PYQN2ydbn1twnvT8o8=;
 b=Z4C6BEjERH302dH9ob3Qp2iXJCaRYzKrRnkNeGoUzaCHrHECVxJF6izOUFc3w/vyioThCMfrG4wA0CeZPPF8CIWCPyGNuD0jQCv6FVHE0m2hmNrIeYxKAHFUJonJ5LqFX0DNiE4IhnkZpxj+SF8pmdETYKuaDhVaMIQXQVxNKMM+Tfa23hjJJvwWcsvM1xFUwLmYEE/lfedvRuB09p2tMb7aJRtQSRUx5/9p/TgT55LYaF+hdaKg4Y74cYKfdNkGAQ2+To0Bi2gPBeSRR74JpfxNo2Kz8qWNT11dunuE0YhYWxNbHjActbubIubxxr8hTUwGROGGYbL3OQCu2Lyy5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg1CNX4zyvZ3HC1Ls0Dkx+av0PYQN2ydbn1twnvT8o8=;
 b=ZwUJqCrswjNDQ9Zjwnlyg+3ZDUX2jo6zGjxgrEcO4omNZ4wB2tR5RmDRhAw/8LtJWQbaFwbo8Cd9GXQ9vt0Ke2rxOeGYOcPeqSA5jpw0YXwyjkXOO/trnv4fs6tNBZ01yLw8N+Kd01VQeBKCiQHhMMiaJRm5p2M7djhwhEjPgCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 15:05:23 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 15:05:23 +0000
Message-ID: <9e9ec219-3ae7-4ec8-8f85-5edb4bbbe53a@cherry.de>
Date: Mon, 24 Nov 2025 16:05:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mkimage: Add support for bundling TEE in mkimage -f auto
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 u-boot@dh-electronics.com
References: <20251118232045.578034-1-marek.vasut@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251118232045.578034-1-marek.vasut@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV1PR04MB9149:EE_
X-MS-Office365-Filtering-Correlation-Id: e721e1ac-ac34-4f08-7d89-08de2b6ae49a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnQyOHBVRmtuRFlwZXNpamdHVHhpYmhueENhQ1dycDE3YjI5c3ltUmhSeE54?=
 =?utf-8?B?NnYzajcrNlVqblNQandtUFdTRzVUMi9TeE1HMXFTeXFaTkQrQmsySjhmUmQ3?=
 =?utf-8?B?YkFxUFNwUTk3eDEyeDFKL2JHajJybjFzTHM4UjVhZVIzWTlzYTRpUzdLTWs1?=
 =?utf-8?B?dTUrSEtRUnVwU2gxaVJnckJPOHZDdGRzMTFOeTF3SDBTd2VHNGhOVUJOZENp?=
 =?utf-8?B?WFVMWDlMckY3eTFBWTF2Q0dYZ3RGRnRJNHl3d212Y2hYbEhVQkMyQnFZd2c4?=
 =?utf-8?B?RUZnNzNmZVdyQmtiRFNGMXp5bHYvUXUrTW4vQXp6c29pcXFNYVFjMU9ueDFT?=
 =?utf-8?B?YUU4UHpIVkZOdFVjdDluVnZxSTN3aERLOWxGNkhXTHpYU0Y0cGU0d3IrenhZ?=
 =?utf-8?B?MDhHcjRORlhTTHk0anhHOEZGRHpGSmhEYkh6a2lQZHc2VUhXVndYZVhnVlFv?=
 =?utf-8?B?clVpM3NOY05KSFFic3Q1dTFVcTVaNHVHSG9Pb0RHYlZzT2xtNDJMSjVOVVpP?=
 =?utf-8?B?dERWb0drZDh6d3E3YlplOUpPdVVTb1lNbDhuRGNOTjIzSEVWaGJuekVnSm5p?=
 =?utf-8?B?L0lMczAyZFczNG9zWEh0Q01NREF6bXJzR3BXSUI4Qk5mVnY5TkZPTEJWQW9j?=
 =?utf-8?B?cVNQbitmdTVlYzE3OXI3Uyt2N1hmZ1ZCbTNiakczM3hoeGNsSGlKQXF3aElj?=
 =?utf-8?B?L3NxcFdOMlhTb2hpQWUrdlpIc3c0aWNiNi9KYVRSeWJOMTlYNGtVay9zZTRF?=
 =?utf-8?B?OEtseVh5SUlGTFNFL0FWcGJOelhaL1FwYkc4YUZOWDkwRS9tU0w1ZXFJcVA2?=
 =?utf-8?B?akp4V3B3K0tTYTBBa3dWdXA0Vml2YklzL3hKeG1LT1FZNXBBbUxZN1J4LzdU?=
 =?utf-8?B?WnlOUkYxMHpFaVZGSW9oNTI5dGFYSFEvZ0VyUjZwV1ZhNm5mYURueVdra3dq?=
 =?utf-8?B?WmdoMlVVR2U2RkhYWDZXYk40SHZWQTlHL3lQU1c4N0xMamVwR0l0U3gyai9D?=
 =?utf-8?B?WjM2WVpqK0d2VjFMM3VHbFFab3NyUUFjVkRTajV3NTF0SU02WTJQUFdSNHJl?=
 =?utf-8?B?N0lQR056bVZMSVVURkJQUXhCMnFJQmQ5UWJWRXVMV1YxOW0xVEl2NTJRODlr?=
 =?utf-8?B?K05yZVd1RVZZenpBK0ZtWjQ5SEJDVTdjVlEyVVk3OTFrdmM0dnp0bjhCaUYx?=
 =?utf-8?B?UDJuNmNScWJROFY1ZzBwaTR0OGdQcnFZQnB3bmdBYzNjQUtLaVUrZGN0ZVpI?=
 =?utf-8?B?T2FadElWQ2FFUTVnTk5rcGNKV2NOa2JLZzVLQ3R2TlNlUmJTV1pvRUNwRldh?=
 =?utf-8?B?S0hKU3pEMlZ2cjB3R1RScDdvSTZxdFluR1F5YmVQQjU2cWVpY2pqYUdXY2xS?=
 =?utf-8?B?QjlQZlVwT2lCWWczZzE0OHJhVXpTMkFOclRVMis2STk2WnFxNEVjY01XenI1?=
 =?utf-8?B?Q0I2ZVVBandRZWlNamRlYkJFcGNUNTdtdW9ldEJCdzBrWDk4aFZLcXprVlFR?=
 =?utf-8?B?N3Q1WjArMWh1Y0tKMDZqbmVlN2JkSjNjcnFtblpzN1l1UFN3cmVUVzNDQmcr?=
 =?utf-8?B?VXFlVk15UW1qSFhURzJhaythY1czcXE4ZjY1M3RrcERhdFU3VkNHbW5GaFJM?=
 =?utf-8?B?dnRka2FLUXRURDhuZGthWTQ2NXkvdWZFZ1dNb1NMdkpNc3hHbnRLTjBPOUQw?=
 =?utf-8?B?aVZzSll0MnBWbkZ2K3Y2K1g4WnRhK3BFS2J2N2xoLzFOTHM4emxtOEN2cDBH?=
 =?utf-8?B?eFVWcVBCWG14N1FkNHBWZy9UZGNqcFJjeS9jME1JVVNIQXVLV09nc05hRy9l?=
 =?utf-8?B?aVZ6My9hU0dPTnozSGhPckNRMWEzb09JL2toR3hyUVBpV0xNNUZBNVF0YjU0?=
 =?utf-8?B?cTFFVjdUa0V0M2hCVkhhK2xpRnBFNzhBYnBXUHptd3czSEM3M3NqQzQzNHJC?=
 =?utf-8?Q?zoHZMUeljEfAkKL4U1M33knacxpGF9IK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3ljMjd3Y0lCMSt1aE1PRnRjMmZLUTd1NU9BUHI4aFFwMWQvWjRTN2NaR3Vl?=
 =?utf-8?B?L0RVR3Q0TjVNcWttY3lpOHZraEVaOWhYak15SlFROTZqRzlLSkFyVXpMVkgy?=
 =?utf-8?B?Z0dhRmt3dy9qNEpjbkJETG1VVUxJd1N0R2U2Y1Fxb3EvWjZhQjNTWEhQU3cx?=
 =?utf-8?B?Q2VGMkVOY1oybXBRMktUeDhhNXl1akVKY0ZycFFzSGJiZ3RrWVl3bjROQ2ha?=
 =?utf-8?B?QnlLSzlXR0EraHJnTUNNMGZ4cXhmNWV4cnhDZzNGNGFDQ20yNElQdnhRV1ZU?=
 =?utf-8?B?bHc1SDRRTmxRMStIMkdzU0x4Z3pDZHNkQUVRWEgvbnl0NGhVS0F0NFZ5NTZJ?=
 =?utf-8?B?Y2xteGtOQVZNTnl6dlVPUk0xWEdwc2pocE1sZlIyeUd4U2w2NmRyZEJweEJk?=
 =?utf-8?B?VkdUQUQ5R2tYb0UvQ3R5RUNZSXV0dTE3S3I4TWdCaTBKalBsTWU0eTkveXFx?=
 =?utf-8?B?TXB0TzJlL0hPbTFrOTN6UFBkN1o1eHMwaTlKRHdwZTNja0dMeFVsS0xJekNr?=
 =?utf-8?B?QUkzbTI2VjBXRUFxYU9HSmoxR3A5aDBPdWRGTkQrRjZhOGk1bUxySGR1RFIw?=
 =?utf-8?B?YzI3NVVNOGRFcllvM2V2RWlrcGlWVUxqRTZ3ZTlSZlpXRW5VQlJZSDZrM2ZU?=
 =?utf-8?B?TE5VbFQyZkd6bStSWC9LUG5ra0REVE9CZWZWdThZT3UxdDBkYjZRdVo2QlUw?=
 =?utf-8?B?akxzQXRrTCtqcDFKNFh0am1EYmZHT21CYjArRHNpNG82Q2JITEd1enJ6cGZa?=
 =?utf-8?B?Vkl4YnRRZ1N2QlAvVTBBaVJlOG9OcUk4U2k0bG5kSG56TTZQZjRUc2I4ZVZJ?=
 =?utf-8?B?dXRlaENBRGxLU3R6YVJzeGpIcENrajEzTnJYLzF4SGpYQU92cTFwbnVnY3Ba?=
 =?utf-8?B?VUFhTHI1a2ZDZjczdWRNYXFKZXNUcG5NREswNklQOW43UFJyYTdvdVdZOFlK?=
 =?utf-8?B?QTRjVDZUOUwrZXpHaklkcHBWZ2JZYVQwY29yR1E5YnJCcWJDYVdkY0laU3pl?=
 =?utf-8?B?WVR0WElNYlJUMDRGaG5OQVFCaDZHUDlvVEpweTN0K29iZkQ1cVZqM3lOdlA4?=
 =?utf-8?B?Y1daa0hDOTB0eHZyMHJNYmxOQ01iaHQyQlY1MmFVVHlpU1AyZjFUVXBMTTYx?=
 =?utf-8?B?bkJRYmM2YlpFdEtIZmJZRmwxMCtwWGozSUdEdFJIK1E0OFl1bVhSWW5vak02?=
 =?utf-8?B?T0JhbWgwNDNKRU1BSmVFUUIzY0V2Mlk0Y0VPOGREeVNleEJHK3Ftb0VtSVo3?=
 =?utf-8?B?YWhCc3FiSUdSMEVxS2ZYRXh5enU3RzRvUWY4U3hLYVNEeXYwV01tMkp3MHhH?=
 =?utf-8?B?Q0VwdDFobWNpazB3OUE0NjluaGF6SVdrbWJjQjNXSXpzOUtNRFVXU0hXeGdk?=
 =?utf-8?B?SXlYVE1tUzhEUjREMGxxRWFjeXBOUU5jdUs0L1RoT2FsNTBGWkxObmN0TUxU?=
 =?utf-8?B?MXdQRy9mNTdwckRmdlUvZ0lDT3lhWExhdFk4S3dPZmNyQXBMSThQdXlmd2xZ?=
 =?utf-8?B?R2ROdVZoZVcvTEMvc2thcDBtUjBJa1FLTG8yYVJmUHdoVG9RWWUvU2RUQkNu?=
 =?utf-8?B?aDlPRSsyVmlRRUphb1J4Q0xmSVZTQUM4cWw2Q0pnRWJtRVRXTkFLa1NRYXlj?=
 =?utf-8?B?YmZkY0NLU2sxMTZNcXBWaForaDJKeVpUamtvZVY4QkNLMnBWSnh2SklUaXpv?=
 =?utf-8?B?aEEzYzhvS2gxRUtmMXY0SUw3V05wMndwZFBML0l3QkphVmxyUVNkTHFtUDA5?=
 =?utf-8?B?UW0wTjBmcmoxeDBQWU9Ic1VCQU0yajhNZFlyZXozYjc3dGRvbnNNOTdBcXdV?=
 =?utf-8?B?U1JPeG5rN0t3QU5rNHI3QVJXUmlRUzBSRTFoNlJkYWRIVWpOYkJVMWcvZzFx?=
 =?utf-8?B?SkdEWWVnRVlSNnhLamNmVGpvVU1YL1ZESHlKUEY1VHozWlRFOTFIQWpXQ1RT?=
 =?utf-8?B?ZE5lT3h5Z1VqVTVlTUI1enNrUjlwR1Q3NlhnOXF5aTJVSnNERW1ERHpFRGxH?=
 =?utf-8?B?SmNxVHNPbW1UY01oNGZOd01hejk5c2ptRFNEN0FIVEMwckRhUHVaTGFEQmtD?=
 =?utf-8?B?eWdUaVRQUFNRdDZGREYxaGl6c1lMOVFFc0Q5ekllMUlINExyQVdJQmxGTjZW?=
 =?utf-8?B?emZrVTJQbi81NGxrUE9wUUl6QWZPbWZjWGY4UjRiTE56RnBEajh0OFdVdTQw?=
 =?utf-8?Q?JzQRYhVbbmvktETFVtmgU0I=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e721e1ac-ac34-4f08-7d89-08de2b6ae49a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 15:05:23.5889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsmwIbRas/Y5qtapGjd3k8pRvUCWAbHXq2WxOzzWPGSX+m6e9nbMqROp4Ukp+n7WIKKKrN9FcLYi6qTGVHzaEIoXZf5LTImS9RvPtYeoCF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149
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

Hi Marek,

On 11/19/25 12:20 AM, Marek Vasut wrote:
> Introduce two new parameters to be used with mkimage -f auto to bundle
> TEE image into fitImage, using auto-generated fitImage. Add -z to specify
> TEE file name and -Z to specify TEE load and entry point address. This is
> meant to be used with systems which boot all of TEE, Linux and its DT from
> a single fitImage, all booted by U-Boot.
> 
> Example invocation:
> "
> $ mkimage -E -A arm -C none -e 0xc0008000 -a 0xc0008000 -f auto \
>            -d arch/arm/boot/zImage \
>            -b arch/arm/boot/dts/st/stm32mp135f-dhcor-dhsbc.dtb \
>            -z ../optee_os/out/arm-plat-stm32mp1/core/tee-raw.bin \
> 	  -Z 0xde000000 \
>            /path/to/output/fitImage
> "
> 
> Documentation update and test are also included, the test validates
> both positive and negative test cases, where fitImage does not include
> TEE and does include TEE blobs.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: "Carlos López" <carlos.lopezr4096@gmail.com>
> Cc: Aristo Chen <jj251510319013@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Julien Masson <jmasson@baylibre.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Mayuresh Chitale <mchitale@ventanamicro.com>
> Cc: Paul HENRYS <paul.henrys_ext@softathome.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Rasmus Villemoes <ravi@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> Cc: u-boot@lists.denx.de
> Cc: u-boot@dh-electronics.com
> ---
>   doc/mkimage.1                         |  12 +++
>   include/image.h                       |   1 +
>   test/py/tests/test_fit_auto_signed.py | 110 +++++++++++++++++++++++---
>   tools/fit_image.c                     |  55 ++++++++++++-
>   tools/imagetool.h                     |   2 +
>   tools/mkimage.c                       |  17 +++-
>   6 files changed, 185 insertions(+), 12 deletions(-)
> 
> diff --git a/doc/mkimage.1 b/doc/mkimage.1
> index c705218d345..c87003a6c0a 100644
> --- a/doc/mkimage.1
> +++ b/doc/mkimage.1
> @@ -251,6 +251,18 @@ Append TFA BL31 file to the image.
>   .B \-\-tfa-bl31-addr
>   Set TFA BL31 file load and entry point address.
>   .
> +.TP
> +.B \-z
> +.TQ
> +.B \-\-optee-file
> +Append OPTEE file to the image.
> +.
> +.TP
> +.B \-Z
> +.TQ
> +.B \-\-optee-addr
> +Set OPTEE file load and entry point address.
> +.

I believe we use tee-file and tee-addr according to the last diff in 
this patch?

Please specify this is parsed as hex.

Which formats are supported for the --tee-file parameter? OP-TEE OS 
itself has multiple versions for the binary header (v1 and v2?) and we 
can pass either a binary (tee.bin) or an ELF (tee.elf) in binman, c.f. 
tools/binman/etype/tee_os.py

>   .SS Options for creating FIT images
>   .
>   .TP
> diff --git a/include/image.h b/include/image.h
> index 9a1c828416d..d543c6cf254 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -1105,6 +1105,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
>   #define FIT_SCRIPT_PROP		"script"
>   #define FIT_PHASE_PROP		"phase"
>   #define FIT_TFA_BL31_PROP	"tfa-bl31"
> +#define FIT_TEE_PROP		"tee"
>   
>   #define FIT_MAX_HASH_LEN	HASH_MAX_DIGEST_SIZE
>   
> diff --git a/test/py/tests/test_fit_auto_signed.py b/test/py/tests/test_fit_auto_signed.py
> index 0b5dbd5401c..cb8bd519fd9 100644
> --- a/test/py/tests/test_fit_auto_signed.py
> +++ b/test/py/tests/test_fit_auto_signed.py
> @@ -117,23 +117,31 @@ class SignedFitHelper(object):
>               algo = self.__fdt_get_string(f'{node}/signature', 'algo')
>               assert algo == sign_algo + "\n", "Missing expected signature algo!"
>   
> -    def check_fit_loadables(self, present):
> +    def check_fit_loadables(self, bl31present, teepresent):
>           """Test that loadables contains both kernel and TFA BL31 entries.
>   
>           Each configuration must have a loadables property which lists both
>           kernel-1 and tfa-bl31-1 strings in the string list.

Missing update to the method docstring.

>           """
> -        if present:
> +        if bl31present:
>               assert "/images/tfa-bl31-1" in self.images_nodes
>           else:
>               assert "/images/tfa-bl31-1" not in self.images_nodes
> +        if teepresent:
> +            assert "/images/tee-1" in self.images_nodes
> +        else:
> +            assert "/images/tee-1" not in self.images_nodes
>           for node in self.confgs_nodes:
>               loadables = self.__fdt_get_string(f'{node}', 'loadables')
>               assert "kernel-1" in loadables
> -            if present:
> +            if bl31present:
>                   assert "tfa-bl31-1" in loadables
>               else:
>                   assert "tfa-bl31-1" not in loadables
> +            if teepresent:
> +                assert "tee-1" in loadables
> +            else:
> +                assert "tee-1" not in loadables

[...]

> +    # Run the same tests as 1/2/3 above, but this time with TEE
> +    # options -z tee.bin -Z 0x56780000 to cover both mkimage with
> +    # and without TEE use cases.
> +    b_args = " -d" + kernel_file + " -b" + dt1_file + " -b" + dt2_file + " -z" + tee_file + " -Z 0x56780000"
> +
> +    # 4 - Create auto FIT with images crc32 checksum, and verify it
> +    utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + " " + fit_file)
> +
> +    fit = SignedFitHelper(ubman, fit_file)
> +    if fit.build_nodes_sets() == 0:
> +        raise ValueError('FIT-7 has no "/image" nor "/configuration" nodes')
> +
> +    fit.check_fit_crc32_images()
> +
> +    fit.check_fit_loadables(bl31present=False, teepresent=True)
> +
> +    # 5 - Create auto FIT with signed images, and verify it
> +    utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + s_args + " " +
> +                      fit_file)
> +
> +    fit = SignedFitHelper(ubman, fit_file)
> +    if fit.build_nodes_sets() == 0:
> +        raise ValueError('FIT-8 has no "/image" nor "/configuration" nodes')
> +
> +    fit.check_fit_signed_images(key_name, sign_algo, verifier)
> +
> +    fit.check_fit_loadables(bl31present=False, teepresent=True)
> +
> +    # 6 - Create auto FIT with signed configs and hashed images, and verify it
> +    utils.run_and_log(ubman, mkimage + ' -fauto-conf' + b_args + s_args + " " +
> +                      fit_file)
> +
> +    fit = SignedFitHelper(ubman, fit_file)
> +    if fit.build_nodes_sets() == 0:
> +        raise ValueError('FIT-9 has no "/image" nor "/configuration" nodes')
> +
> +    fit.check_fit_signed_confgs(key_name, sign_algo)
> +
> +    fit.check_fit_loadables(bl31present=False, teepresent=True)
> +
> +    # Run the same tests as 1/2/3 above, but this time with TEE
> +    # options -z tee.bin -Z 0x56780000 to cover both mkimage with
> +    # and without TEE use cases.

And with TFA BL31...

[...]

> diff --git a/tools/fit_image.c b/tools/fit_image.c
> index 0306333141e..6388b04e340 100644
> --- a/tools/fit_image.c
> +++ b/tools/fit_image.c
> @@ -180,6 +180,13 @@ static int fit_calc_size(struct image_tool_params *params)
>   		total_size += size;
>   	}
>   
> +	if (params->fit_tee) {
> +		size = imagetool_get_filesize(params, params->fit_tee);
> +		if (size < 0)
> +			return -1;
> +		total_size += size;
> +	}
> +
>   	for (cont = params->content_head; cont; cont = cont->next) {
>   		size = imagetool_get_filesize(params, cont->fname);
>   		if (size < 0)
> @@ -433,6 +440,30 @@ static int fit_write_images(struct image_tool_params *params, char *fdt)
>   		fdt_end_node(fdt);
>   	}
>   
> +	/* And a TEE file if available */
> +	if (params->fit_tee) {
> +		fdt_begin_node(fdt, FIT_TEE_PROP "-1");
> +
> +		fdt_property_string(fdt, FIT_TYPE_PROP, FIT_TEE_PROP);
> +		fdt_property_string(fdt, FIT_OS_PROP,
> +				    genimg_get_os_short_name(params->os));
> +		fdt_property_string(fdt, FIT_ARCH_PROP,
> +				    genimg_get_arch_short_name(params->arch));
> +		get_basename(str, sizeof(str), params->fit_tee);
> +		fdt_property_string(fdt, FIT_DESC_PROP, str);
> +
> +		ret = fdt_property_file(params, fdt, FIT_DATA_PROP,
> +					params->fit_tee);
> +		if (ret)
> +			return ret;
> +		fdt_property_u32(fdt, FIT_LOAD_PROP, params->fit_tee_addr);
> +		fdt_property_u32(fdt, FIT_ENTRY_PROP, params->fit_tee_addr);
> +		fit_add_hash_or_sign(params, fdt, true);
> +		if (ret)
> +			return ret;
> +		fdt_end_node(fdt);
> +	}
> +

OK so... On Rockchip we have TF-A and OP-TEE OS split in multiple 
entries with different load addresses (see @atf-seq and @tee-seq in 
arch/arm/dts/rockchip-u-boot.dtsi). I guess this means we wouldn't be 
able to use this auto FIT?

>   	fdt_end_node(fdt);
>   
>   	return 0;
> @@ -473,10 +504,20 @@ static void fit_write_configs(struct image_tool_params *params, char *fdt)
>   		len = strlen(str);
>   		fdt_property_string(fdt, typename, str);
>   
> -		if (params->fit_tfa_bl31) {
> +		if (params->fit_tfa_bl31 && params->fit_tee) {
> +			snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP "-1." FIT_TEE_PROP "-1", typename);
> +			str[len] = 0;
> +			len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
> +			str[len] = 0;
> +			len += strlen(FIT_TEE_PROP "-1") + 1;
> +		} else if (params->fit_tfa_bl31) {
>   			snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP "-1", typename);
>   			str[len] = 0;
>   			len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
> +		} else if (params->fit_tee) {
> +			snprintf(str, sizeof(str), "%s-1." FIT_TEE_PROP "-1", typename);
> +			str[len] = 0;
> +			len += strlen(FIT_TEE_PROP "-1") + 1;
>   		}
>   
>   		fdt_property(fdt, FIT_LOADABLE_PROP, str, len + 1);
> @@ -498,10 +539,20 @@ static void fit_write_configs(struct image_tool_params *params, char *fdt)
>   		len = strlen(str);
>   		fdt_property_string(fdt, typename, str);
>   
> -		if (params->fit_tfa_bl31) {
> +		if (params->fit_tfa_bl31 && params->fit_tee) {
> +			snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP "-1." FIT_TEE_PROP "-1", typename);
> +			str[len] = 0;
> +			len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
> +			str[len] = 0;
> +			len += strlen(FIT_TEE_PROP "-1") + 1;
> +		} else if (params->fit_tfa_bl31) {
>   			snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP "-1", typename);
>   			str[len] = 0;
>   			len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
> +		} else if (params->fit_tee) {
> +			snprintf(str, sizeof(str), "%s-1." FIT_TEE_PROP "-1", typename);
> +			str[len] = 0;
> +			len += strlen(FIT_TEE_PROP "-1") + 1;
>   		}

The coded here seems to be shared with one diff above, maybe it'd make 
sense to make this into a reusable function? What do you think?

Cheers,
Quentin
