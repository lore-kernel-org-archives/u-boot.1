Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29353CA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 15:25:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A2083ACE;
	Fri, 15 Aug 2025 17:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aandtinstruments.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=aandtinstruments.com header.i=@aandtinstruments.com header.b="lHl1aye6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FA8583AAE; Fri, 15 Aug 2025 14:19:11 +0200 (CEST)
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c205::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C0883A9A
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 14:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aandtinstruments.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sam@aandtinstruments.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGQOnHfe4gc/7v+OAIr4ps184LKvNLFXtpREQklUnlGZMg8Q9jVpuze5gEUwPDIFxhRvXCktyCs9/51qo8FQwtsB+5zy6aF5vdcwQOJ0hOrj3ExSwEAzbOVRetiyMrGDlBuRo4KyA5W9e8eGx//9+UY0xI60MMpHqe33VK76zrzA5zPbKHvHaTfPC75hOSDfk/S3uJvPULJI18z0fr+LbD8n8m9N59jOF7YAdhEwnkXCkFkU3il/PFNCM0kTHc7qa+2h6mYQTnAhyZUIOet16+GBBP2/YVpz9z9rzJBhKXwwetQeihrr3KJYNMQPAOdrTuaxX3TH+otdt5N2c/UYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w96rHwFc+S/BMcq7J9jHZ4DZ4Wgqc4zWeVex/QLWCVo=;
 b=wjyPEUcTas0pxIFkvq0c08EFCzmk8GRPgDOro42UjBdmRbBPn30CtngkKSN5nWqi32v4nH4WA+typ573vNIX7cSNIO7lMgLrcDHO4ywu8AmJCfo3nFJrEYM/FAlo2gVveEhD3DNrsaOlI4UTG+ei54kmAdqYQCcZYRhFBibxVzWWsf+Rm0IjXsH98RQMtfmRVodAZz6rAjQcs4pl/+wLmWi6xiTczveLbEAi30SpuzzOsar3GzEBo4OTcX2THXDIoyfqNMNOOJN1LXoUDfaybl5puxBLz+FL620HmBW2NBY4MiPpAqHDUvbXXrsTjJg4O9cyJouy9xV1AVXmVaya4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aandtinstruments.com; dmarc=pass action=none
 header.from=aandtinstruments.com; dkim=pass header.d=aandtinstruments.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aandtinstruments.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w96rHwFc+S/BMcq7J9jHZ4DZ4Wgqc4zWeVex/QLWCVo=;
 b=lHl1aye62KzKDAU0LubAdUFMPvtmfVGm1mhpg1PWJ9fiEfSQjEHvIYkAl79ZZixr/4OBcaXmGHoxymThfUDwYQ4TTJqTTxU2sH7dvDc3Li2ZVbnBs2/cRs+h4mNzt9foOj1WnI3kvvYdNCzz6vfowaTeEhEf+RQta96tygfTSe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aandtinstruments.com;
Received: from CWXP265MB4747.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:152::8)
 by CWLP265MB5785.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 12:19:06 +0000
Received: from CWXP265MB4747.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2aa8:b86d:87df:2db9]) by CWXP265MB4747.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2aa8:b86d:87df:2db9%6]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 12:19:06 +0000
Message-ID: <c34fab31-6c3a-4cff-ab6a-8a6f3db2d2d4@aandtinstruments.com>
Date: Fri, 15 Aug 2025 13:19:04 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: u-boot@lists.denx.de
From: Sam Meredith <sam@aandtinstruments.com>
Subject: [PATCH] video: mxsfb: fix pixel clock polarity
Organization: A+T Instruments
X-ClientProxiedBy: LO4P123CA0298.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::15) To CWXP265MB4747.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:152::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP265MB4747:EE_|CWLP265MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 4740baea-efd9-4e26-705d-08dddbf5edbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWFUWTREanc1S0xPam1kQTJkclRUVTlBSUhPMWhhRzMwQlVtcEIwVW1LbGti?=
 =?utf-8?B?U2ZSUU9KazRXanlEMXVXSHdYMlhOeGxtK0NRRHJrYnByTmJSWE5YdDF0eWhE?=
 =?utf-8?B?YkRWR1k3ZDFUSWdyVTZISFh4VmRMOVJjc3E0VjdqSFZUMjdFbXRodGNGWlJV?=
 =?utf-8?B?QlBHaUlSdnJUa3BWNWtJZVlqbGZmSmN4MXpoWFpxN0JYTWNMSzIzZXE5Um1T?=
 =?utf-8?B?QTZRWEExMkNHZW9rbnFmOXNLM2tPbmkzc25KTXMwdWw3bVRUWEtjYUd2Z21P?=
 =?utf-8?B?bjZSaXQ5OEsyZjBpckZhZWl6RWFXSTAwYjN4bjE4THBMOGdVeU5lY2o0QStF?=
 =?utf-8?B?TllRUU16T2FQN1VGTVUzYkMvL2gvc0FkYmVVbE8zVU41SmVTZFZzNG92RDhV?=
 =?utf-8?B?RXNZOEd0cEExOTl0TjE4L09PSDR0aldZL0pGMzdaZVh1N0dZbmZoV2IyT3JU?=
 =?utf-8?B?NkJGeHlyejN2blBpdVFXZWsyazBTV0YyZlNCd0xHMjZOYkhNKzBXUUhneUJD?=
 =?utf-8?B?cXNFckhLOHF4b294RjlIQ2hQOGk2K1A5ZmZOcXA0dVJmWi9zWFExRlZjV2tu?=
 =?utf-8?B?eUprdE14V2l3WlU1NnBmd3BGWjFBZ3hUWnYvcitzTUJNQjRHdGN5aFBBM203?=
 =?utf-8?B?VHJDZWVMcGE0Tlh2Z1g2UnpYai9RRGVyQ3BPckI0YXFNb0t4U2xUWWhuRENG?=
 =?utf-8?B?Zm9LM05pNjhWQnpWTnNYUjRUSDhwR2Q0QTVHcThuSk1TWTBieXN3ak8wYWE5?=
 =?utf-8?B?NzBCTzEzWi9ZYUJpaDJDQmpKYXkxVGFFcjczdDBRRUhMU3QycHNiWGZaOXgx?=
 =?utf-8?B?YW5heGZGSUxGTG9WaGRKSktuUDdrZytsY3J2djE0MGNLSjFWNzlrU1FLZlZ3?=
 =?utf-8?B?UWw2WjB4U1dMTnFSWUJpZm84NzFISGY3SER5MUhIRGxYQ3ZuL3RQVXFnd3pX?=
 =?utf-8?B?dGhrZXk3bzdGVlVGaXhBNEVnUXVpOGNWT1hIZjhtTkg4SXpqTWZLODhWQTlC?=
 =?utf-8?B?K1I3eXhNNU1lVFZpUGV5QlJqWHVJenJtQi94VTlMaUVBU3MxVFdwZFJwaGs2?=
 =?utf-8?B?Ty9QTlBpVXRkck5LcnkzYUhaWE5IeDE3SW9DemVMWHZsNStZdnpRbko2bURu?=
 =?utf-8?B?TTAwOVB6NHR6RHZPRDJJZFczZWFCYzR6L3RlMFFHL0x5QkczWERVMjRLWmlC?=
 =?utf-8?B?dCtaeE85ZDNOM1BBQmZJSHZXbXpUWUJiOXJsaDMvZzNtNVhxa2x0QU50dGYw?=
 =?utf-8?B?Vlo5VFo3WFdPeVVKUE5TbnBUMXhOcElLRzR3Y3M4SDNlODhtUFFlN3NNYWtr?=
 =?utf-8?B?UjVXdzJkdzh2NnhoZnZCeVRoOEllVy8zaWhmVUhaczhQNjhPZndUZEhab3Aw?=
 =?utf-8?B?L29EOUw3UWpqL2oyRll4VVoyZ1k2SjJ4YUlqN1l0WndZWDI0Y1FLVlpET28x?=
 =?utf-8?B?QUswbnJYYzlVVmpYWFVTVUxPZzVrdUFaSjltNDAwRVB0Q0ZtemFnVWt5ejZr?=
 =?utf-8?B?YTY4a1VvTTFCR29aaXBOVUZDMFIvdkUwcFdKdG9LN2FIMSsrYk1zeUh2VmdQ?=
 =?utf-8?B?OFNiQ0crSDAwV3pIYUlmK09FYUxRbDRmUFlYVGxER2tJUndRLzE0UlRpa05D?=
 =?utf-8?B?NTZGa09USG92VmpaUzRnWHJaSGtOVGZzTUFuT0FsWlh3ZjNYWEIyTjZid2gy?=
 =?utf-8?B?MmcxR0REY09WNEdZai9zOTJWMi9oSGxzL0gvRVhGNUk5QVNJZWMxeDdnbTRp?=
 =?utf-8?B?WkhlTTArNU9GM1h5TFNabC9WMHl3S2k3czFKV1ZmbGVDdUxsemFHMzhWTFBo?=
 =?utf-8?Q?lncddXmRG94ztes8OxCRFecN125Cm2Tt51NvM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP265MB4747.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(8096899003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bllrN21qWVFuN3VXZFU2K004OFBKOHJBVXlLL1B3ZGpTcDIvNXpGNTd3MUhh?=
 =?utf-8?B?YW1vTW9VK3hvTTViaDJodmNPUllhUkd3YmtLaU5CWWJnZEFrb21CWGdscGQ1?=
 =?utf-8?B?VEdHWE5IUlljQ1VpTWwvd1pXdFFIUUl1RHNUdzNtOFc0ekRmblp0aWZXMmQw?=
 =?utf-8?B?bWtFd3pRemNrN2VpYmVObURiSElham9scEpjK25NU2pnMHd4akNoU3IrajVm?=
 =?utf-8?B?ZzhxY29oZGJydHJBWG1qZkdPTHNLMzQzTXVVTmt3NWFFS0dkOE1OT24zcXJW?=
 =?utf-8?B?bEs2Zmlxa1ErYWhWeTBET1ltUy9BY3RhU3FqWUpod3p6dTdtSmY4azlNUzEz?=
 =?utf-8?B?TTJQU0JDZHdhdU1qR1Z4R0ZmMUJSeldlVmJER01SalhhZXZVOFFiY2UwOWFE?=
 =?utf-8?B?TS94Zk1MWHFmMkRIRnFFa3VZMWxENzZpNVU0bElndXJBajlSS1hZUUVuWHdF?=
 =?utf-8?B?VWp2bG92dVpyTE5NVEJFdDY5K1hqK3R0UjJsQnR5NEtWall2dkluaG5jTGxR?=
 =?utf-8?B?TGYvUzgrZU5WdkZGV3F2TUFNSGxYU21BUndRMWRSMVQrbWE0SzhDZFBvREg3?=
 =?utf-8?B?bmJ6LzI5L3NYb0ovSERPWnhXbDRudDNMSXNhSTRuMWJsMFBIZ1U1OEtKSUZW?=
 =?utf-8?B?N2VDTDEzMVZqMldwK1JSUi9zdVZzbW02OStvcVFRZmZsOTNsbDd1NkMvZndX?=
 =?utf-8?B?U3Jha1kvay9vekFYQ09SNktxQ3l4MWkwWmtyTis0OEM1Slc0cjlEdTZsM1Rt?=
 =?utf-8?B?clNEVzJZRTZTUlZvR2M5ek9iakRxd2prWW9LbzJlMGN6QVZ4RXN4dlFTZU9n?=
 =?utf-8?B?MjhOamY0VHF6cnd1V1RlZlVjUnU2azBXSGw2cGlMakhLTzNERHZQcGJWV0Mr?=
 =?utf-8?B?aVV1VXdacGVKYzhDbkEvOXNPVGVETG8wOVNOcUdiZ0p5NFkwZFUwY1lXMGhz?=
 =?utf-8?B?TVozdE1oWEw0WVoyeVY4Q3hkekV3OTdxcjdIOTNsRTdjVDZ4U3psV3BSNXI4?=
 =?utf-8?B?QUJnK0tyQUdPRHZSMEVqazNleUw0dUJ5eXM5NUltd1ZUK0QwZkdyeVhQTmRt?=
 =?utf-8?B?TFR5bUtBc3lOZlVzS1RkbEY0TytPQUVUbXFRNG9ycHRqMzQzMjJ0cm5jR2o3?=
 =?utf-8?B?UU1kbWlpbjhLanl3ejBJYzZlejlST0dSb1pManlra0NHUXZKdFUrL0NhL3hF?=
 =?utf-8?B?RGNFMmRCbElsdVRXTG9vQkZNUUNSdHlKM1BsWnNtelJqSXpkMTNBbG1Qb2JW?=
 =?utf-8?B?Vk1zS0MxYzNPTER3S0l4TTlJQkQ0dTRzVFF5ZjdhdytOUlR4NmFyVXptaEUr?=
 =?utf-8?B?SUVwcXVkcFRsa3ZiaEVoRTZMbFhLenI1L1VhbW41dkI1OUZQM2svL0p2d3c2?=
 =?utf-8?B?N2t6clMyMkY0cVdYVWdTby9Uci93eFNNNDdhekFNTnkxVHZuQVNUUU9sUmZz?=
 =?utf-8?B?VHQ5QTdQRW1FelF1SDVwanYrSlJQbGpPeGdaL0ZCOVJuRGRCQi9lallQYjR2?=
 =?utf-8?B?dHpvbXVBQlVDR2ZITGhwUDhkZ2t2WG1kaGcvcXg2clNWYjlhMU9tcU9pOGh2?=
 =?utf-8?B?MkpuVzA3c0lnNGpZTE0yRG9LeG43V3piM1hEUGJiVkV4dFV1aXpLdkdiREpM?=
 =?utf-8?B?YlVxSW81OTdQSTdZbnc4cE5oZkQ2V1RHaG02Z3llR1JWN3RENGRIZ2tzeEhN?=
 =?utf-8?B?c0ZBeHRMVmMxTC9kdytJTjdjSGNDVTNYUzMwT0R2bk5BUjdOQ2pxcitxKzla?=
 =?utf-8?B?YW13WTVtcGNydXhxQzBRSC82M01zRUxJSmtEQ0IzUXlyeTU0QkYxU21JZDFT?=
 =?utf-8?B?TFZod1AxakhsZDJVU0dmMFlJQjUvcU1JQXJCb1FoVTNTaFFnYmMzemtTSnd2?=
 =?utf-8?B?cm50ZERnUkd1TkVnUkNkdVZ2RVFOL0lNTFhUbUFFVzBaS3hORk8rcFMyeDd1?=
 =?utf-8?B?Z1k5UndSVXlFNWl3MllqdG1ydFY0R0pydGNZaGdzS0dqbjZjVWUxL25Ra1Yz?=
 =?utf-8?B?VlpzVzdGelpmbHNPZkVPS2FNcUJhcVZnUFhSeithcUUrV01PYm03dDY2allV?=
 =?utf-8?B?TFR3eTZoa0tvZy9KK2I0SFg4OHJmTjNpa2gxYUxHbHVzNHA5ak9yc2pWM0NZ?=
 =?utf-8?B?K01BSVVqNzdDb2FIbklJZkFnNnY5Ri92V2lRZjczaExVMUpIaFFYL3JIbnVj?=
 =?utf-8?Q?o9zb5OcvF7pevIf4ICPl4Qs=3D?=
X-OriginatorOrg: aandtinstruments.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4740baea-efd9-4e26-705d-08dddbf5edbc
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB4747.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 12:19:06.1336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d6157d7c-4ef5-4a2b-84e0-a947c460f4ca
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZmdiutw80nx0G0sczI0Cy27vUU8irmW4rOmNWvXgjM31/LzTKgmwdNSQDXl0FAMwLwqhlwzWCLpAwch+tDJ5OOImWIeat3bmZmk3BV4jQW3bTwpLOJrRf8gkTzQ++kE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5785
X-Mailman-Approved-At: Fri, 15 Aug 2025 17:24:54 +0200
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

DISPLAY_FLAGS_PIXDATA_NEGEDGE means the controller drives the data on
pixel clocks falling edge. That is DOTCLK_POL=0 (default) not 1.

Signed-off-by: Sam Meredith<sam@aandtinstruments.com>
---

This patch was submitted back in 2021 but never merged. I arrived at the exact same patch.
https://marc.info/?l=u-boot&m=163794537017364&w=2

As was pointed out back then, the mxsfb-drm driver in the Linux kernel has
made the same change and it remains to this day:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/mxsfb?h=v5.16-rc2&id=53990e416bb7adaa59d045f325a47f31a11b75ee <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/mxsfb?h=v5.16-rc2&id=53990e416bb7adaa59d045f325a47f31a11b75ee>

I found this was required on an IMX8X SoM.
Without the patch a splash screen displays with aliasing-like jagged edges.

  drivers/video/mxsfb.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index e72839cead4..58338ed6004 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -159,7 +159,7 @@ static void mxs_lcd_init(struct udevice *dev, u32 fb_addr,
          vdctrl0 |= LCDIF_VDCTRL0_HSYNC_POL;
      if(flags & DISPLAY_FLAGS_VSYNC_HIGH)
          vdctrl0 |= LCDIF_VDCTRL0_VSYNC_POL;
-    if(flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+    if(flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
          vdctrl0 |= LCDIF_VDCTRL0_DOTCLK_POL;
      if(flags & DISPLAY_FLAGS_DE_HIGH)
          vdctrl0 |= LCDIF_VDCTRL0_ENABLE_POL;
