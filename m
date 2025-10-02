Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09DECAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 15:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07452835A2;
	Thu,  2 Oct 2025 17:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="y9SqDQes";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="y9SqDQes";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EFEB835AA; Thu,  2 Oct 2025 17:42:48 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0174F81D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 17:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XNE2GQ2N22aikUE8e2X76cnoFSUJNqiuzt7prN9b/GKP7YeLOi9vYOKYRUwLzGhwDghAyMugPkjHQunJE3POKVlvaJeg8vYjXULEK4kq08pfqoKrcZhdMxqCYRH3/G/P9vBGKn+W9Ty15GWoJKOzlA3qh2GYgMg6RnhVmh/EuOwIXuJ421+ZkmNawBTYAFyOTmjLrsEEM1zxgoB0oTpsa8KJ/H0wI8afQ/o2SeRqlJial0dYeZD4bPShYpJ8YlFDF64oeTtDemLWjvdMPuuUA4bsoEtGoim4lIjefj5qN2aTw9UMtEE82QKwTg72NasmIbNWF3I3Wi53Y1liOyxVoQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4fhCpyB5WXdyTek4viAYrZer4aDJTEmn25BOqJ6+RU=;
 b=K/152XFnGGBy8L4BYE4N4zSoVkf9t3xUtW2wNmXM8n4LyEjIrtQIFgkuIqvcVaUgVxhOySDOX1FWoX4FulrGdHOUtgbL9svMygj2mz5pw/tDDB0i36A0zB5p7kwo1W9P4ChfgemW9lAXqfMY6InVrqAnDfT0M/KfcCCkkJaRKif1hFEF52TPXV9iMg7LX31Gy8uB+S/4tBML7kpexBtYpsnFE8jRzm1ta2kfadoMvaS1E+UvxJfdiejcveDwtlf6gM7MMbKp1NW2wbiEYyR5CB9i7gMz+uGUMDNcTKcf0jFPmiWfhuFhU2AT/k94awyXp6dUf+CGb1fwcg9PanALKQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.80) smtp.rcpttodomain=gmx.de smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4fhCpyB5WXdyTek4viAYrZer4aDJTEmn25BOqJ6+RU=;
 b=y9SqDQesgAtffb9rNTFht+fPyZJDXpHY/TSC7cQRgbW5uB3RiICyyH/FG4KJb48n8ggr15y9R9MyTTNuh3BXqatCyzB6g9MsVehDm5WtIO5nnHBaKV0Jzv91pGAbWf4X/ohnuR+Xax2Mm6YB8i4g4FqFity/5XTw50qYx1rl/FlwecxOXEkQZd0cL0f3jmDwhQtBDARIJA7njI6VJ8lNcCXq/i86zXJmdis/Od8YwLFz2nWOLJ6BwGQSPJ4nvxAfeM/1gBo1zFpmE4Q5f1G6A/bLmZc/A8PVMgLIYuabEqVra+xh+0tbGYLs79Ptgs4RHQ4gdMbfuP32gOKef1EvLQ==
Received: from AS8PR05CA0023.eurprd05.prod.outlook.com (2603:10a6:20b:311::28)
 by DU0PR03MB9865.eurprd03.prod.outlook.com (2603:10a6:10:401::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 15:42:39 +0000
Received: from AM4PEPF00027A6C.eurprd04.prod.outlook.com
 (2603:10a6:20b:311:cafe::e7) by AS8PR05CA0023.outlook.office365.com
 (2603:10a6:20b:311::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 2 Oct 2025 15:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.80) by
 AM4PEPF00027A6C.mail.protection.outlook.com (10.167.16.90) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15
 via Frontend Transport; Thu, 2 Oct 2025 15:42:38 +0000
Received: from outmta (unknown [192.168.82.146])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 880B9200831E2; Thu, 02 Oct 2025 15:42:38 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (unknown
 [52.101.65.112])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 63E4220082B49; 
 Thu, 02 Oct 2025 15:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNIumslwqAlAIFEn5fJO6AzG7TvTgz0Ft85GwCKPEKBNrmfBAw8rnTVBdy5zy/FW2UdUars5r8b+Y97tCro90GyfVazE/brMPaqIZ5HBc3zop/OZxZoynmDZCVqCFps7Wx0Na7psWkZ1LvGB2jZrqbMPBrJQTuLQE0G0otJuAaxqPQqc53fCrSuz25rAmghrAS9U5/MwQ9MSs43575kadpKClkUWw+lsnOCwyuhgN/OZvkinMeBDmGb4fQq/o/2S3vRVbDSdCX9O1SWocw/Zk/5Adffegg2wpB1RnwPf4oujvDnHGwYpsTqKIkKHT1DRzLLPyJAei8onszrlh/JC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4fhCpyB5WXdyTek4viAYrZer4aDJTEmn25BOqJ6+RU=;
 b=NkR1J9daZPedkkRxtDYrsoGlMhe+E/SAKzaqvPoNzYXaVuFmixhrWxTjjlmdj46FIiBN38nEZCVrnRcU3ZUUAr1a6wPApABcqd8lL5LpS5emhsO2JoIoAstG0BACcd34U1xTHgSaMA1jo/kwY7Pn9ZyO6llZ2NW9DGqt9FJmDKp89CtvSrIdKVvhWe+pk0a7oLT1HCdp8defK7PhsbA9njeBC+wT18B66J5lE5K92ytmA2FAeT6xrGkw4idSHv0beStxas8IU1sEbxGw+NZAlUC/e9fliE3nJmWQhpZ735rxSYBqtD6U9vLnjtKrAIU+pwrsMup3AOode7yaZZ8F9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4fhCpyB5WXdyTek4viAYrZer4aDJTEmn25BOqJ6+RU=;
 b=y9SqDQesgAtffb9rNTFht+fPyZJDXpHY/TSC7cQRgbW5uB3RiICyyH/FG4KJb48n8ggr15y9R9MyTTNuh3BXqatCyzB6g9MsVehDm5WtIO5nnHBaKV0Jzv91pGAbWf4X/ohnuR+Xax2Mm6YB8i4g4FqFity/5XTw50qYx1rl/FlwecxOXEkQZd0cL0f3jmDwhQtBDARIJA7njI6VJ8lNcCXq/i86zXJmdis/Od8YwLFz2nWOLJ6BwGQSPJ4nvxAfeM/1gBo1zFpmE4Q5f1G6A/bLmZc/A8PVMgLIYuabEqVra+xh+0tbGYLs79Ptgs4RHQ4gdMbfuP32gOKef1EvLQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by PA4PR03MB7389.eurprd03.prod.outlook.com (2603:10a6:102:be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 15:42:35 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 15:42:35 +0000
Message-ID: <081c49ae-f1ac-4119-8ef4-c4433131b983@seco.com>
Date: Thu, 2 Oct 2025 11:42:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: semihosting: Fixup smh_flen and smh_read against
 overflow
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20251002-fs_semihosting-v2-1-c1783e4188d8@linaro.org>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20251002-fs_semihosting-v2-1-c1783e4188d8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::16) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|PA4PR03MB7389:EE_|AM4PEPF00027A6C:EE_|DU0PR03MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a2d648-8d1c-472e-8c32-08de01ca5103
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?VG53K29JeFFFeEZDbXVRMjkwVG9WaE80ZjRLN1dGK09oK3JQb0RBRFVYWFlG?=
 =?utf-8?B?RlRxeGpFTVYrcW9FcEhiSGVHdEZNeWdZTjhsRmYzY0dKNUJDNDAxRURwdk1C?=
 =?utf-8?B?V1RGRjJiRyttelQwOUJ5QlBienFLTk1IVU8yaGZaSGJKeGpwaktESWJsYmZK?=
 =?utf-8?B?WUxwM0ROM29mWU13cEVCOUgxbmpWd1o2M2YxUDdVNlRXVm5vMTZ3ZTlFc3RB?=
 =?utf-8?B?U0I0VHYwTzNTaGdrU3pveVVRRC8wcC9LOTFaLzN4ZER5RkMzd2Y0WTYzK1Q2?=
 =?utf-8?B?WXc1ZXdGRy9NL2g2VXd1T2svMURDcnVUVHVCYVFEOUdFR1cycldRd0h2a3lY?=
 =?utf-8?B?dFEwWFpFSEhhSHluTzF3T3hBL3pYaktzZlkxVnVCMFpQeThZSGJqVWNXM0pT?=
 =?utf-8?B?M0hrSVFxOUs5blNSU3ZSVjNtN3lGTFZoQkNXeDU2NTZJaEpyQmR6VlplV0Fq?=
 =?utf-8?B?Y0FPWHQyYndtczlDekF6NkJ5dzRRdVUrbklCQXNEaXp1ZWVZVDlHZ25KeFpj?=
 =?utf-8?B?elFEV2gvcGErTnc3WlkxcWpEaDF0MFhGYXlVWUlJVzFMVVZxTVA1aVFQd1FC?=
 =?utf-8?B?UEJ4VWpCK09DNk9NdGtOMGI2OElITkgxUTIzWWN1ZVppRmRJQ3M0cXNjM2JE?=
 =?utf-8?B?WHJobmVZKythM0d5b2tMYWFWWW1DME51dHdnR0ZHRk1RUUZsTng0Wm9NMGZJ?=
 =?utf-8?B?U3lxWDk4SmM3a0F1TXYxbEdtcEk4MVF1NjNXUXRlRFdqU3Y2U2RlUkZJNDlL?=
 =?utf-8?B?Z0xsbUszVk1laHhOTGt6Z21XZFNhRWk1cjFZckNXc01KQllkT0owbitnU2Rv?=
 =?utf-8?B?MElJTjg0dHN1aG1ySlFrQXlYaVZoWnRKN1RLVU4zWjM0MlFrZmNBY1k5Y3gy?=
 =?utf-8?B?bXRiam9sOUVSSWRrU1dXcTk5dXBDVnZxV3N5a0RRVmdib3FGOUg3N3lBMzB0?=
 =?utf-8?B?TFkyZmcxMTBVK2Nwa0c5Z2h3VFJDQlU0cjFlRUFybitQRm1mOGUzU3ViUDI3?=
 =?utf-8?B?SDFON3hIeVErRzl6aHQ4V3FyRWNNUUgxZUZ2blJnZGRFODM1MHNOSHVaS1Fh?=
 =?utf-8?B?OXBJeXBZcVpBMmFtRlF4RytwNHFzZkVtcXdsSVNVNzBDMm0zWkpoRC9GaEcx?=
 =?utf-8?B?QzVPWG5NSkR4MGlBMGUrTHRkb0tZaFg5b1k1QlROMEY1aWFxOHZocXN5UXY3?=
 =?utf-8?B?Ris5TGRMYXg5VjNDbk5HT0FmY1hrV3NEbWhYNWVyUjZwQ1p5dGF0cVRjQ0hL?=
 =?utf-8?B?Qlc4RmRZbVFoZW1NM3pDZldrK0N4Sk83ajdkYmJBa1BCVXA3dWRIUVNHQlNy?=
 =?utf-8?B?YUE3alZkWWJyRjQyaTZCNEFmU2tiVzQrSE94OFlucXR2MmtENFhyVWNtKzA0?=
 =?utf-8?B?aCtlSk1xa0h0N0hxUDluNHFlbVJ4dUlGNHNyczQyZU5RckNoOFhLTjZVWEc3?=
 =?utf-8?B?KzJueUJTNnA3QkhnSCt1TUFUdXpPNDV1ZzNhbUw5RTVGaklyYUlLbHBiRERX?=
 =?utf-8?B?UnRZSXUrWGI2bm9Lcm5PYWovaDhRQTJPdTVsUTZXVzNPcXluQ1VtR2xJaHg2?=
 =?utf-8?B?eXpaeURsZ3JjV2JaRGY1bTg1WGVIUHFoeFFaVUhQRTFCU21ER2gxcW9SZVZY?=
 =?utf-8?B?bWt6SzZ0ZG5SV2JSRURtTng3a0VjeUZHa3VFVFpieGl0TGV0ZlJ0NFBmYUI1?=
 =?utf-8?B?MEZ4WnJXZklWOERXNUpmMldWTnJmdVl0emxadlZNQ25MWnhRcUs0cmtEbVNO?=
 =?utf-8?B?cmMvVUNVb3Nnak9QdEg4Y2VBSldBTGdJMXZ5UVpsalE4MXo1cXlsaWZ3RGFy?=
 =?utf-8?B?WnUxRVZFZitrNFErbjZkZFlQdEc3c3lRcU1MZkg5ZWZlbzR5ZHQwT3NFREsv?=
 =?utf-8?B?VG91Z0Q4NkdsOXhJejNjak13NG1qTURDUTZTQVovSGNlZSt1ZWpHSGZUbTlp?=
 =?utf-8?B?ZHlEZERUZmk1a0QxR3ZaK3V5akJEaUtaVUVBaE5XdkI4cWtwS2ZEZVNoejdW?=
 =?utf-8?B?WUF4TXRoeER3PT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7389
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 75c764a6-9ad9-4c66-076c-08de01ca4eee
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|35042699022|376014|82310400026|14060799003|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkwrM2V3RHpoZm0rSm1Delc5UjBxMEZsMUFOcGxEeTNqemtDYk9FZ0FVL2gw?=
 =?utf-8?B?cnR3OU5xdzhrSFQ4OWlCbkk3dkJaVjArclBOV1pXT2ZYeUVHY2ZJK0pScVpT?=
 =?utf-8?B?cHJVbldzNGdMc0ViZzJSM0hhODd5MUlWZlkyZXBVYWNxdEQxNGFYYTE3Z204?=
 =?utf-8?B?Yzh2eVpudnc5MUdnZ0tsY0dOYnZJcW51RHEvNWExemhJRWV6Q0w2YWkvelVx?=
 =?utf-8?B?ZmtqblVkU1A5YkhtaUlZQzlIQnlSVytUVnI2RWc2T2I0T0FQNHZGVnJkRkkz?=
 =?utf-8?B?NHFVd1JSUWcrTmN5bFlKTTk2UnBlNUhUbXpMNUdLS2dEdXJWelVFN1oyZW8r?=
 =?utf-8?B?Q3Q4TGVoaUltcktBenlOdjMyTzYwYmdubDBHU1BTbm9tRjVTUmg1Mkc0ZHBI?=
 =?utf-8?B?enEwU3JKNDNpaExLbHpMdGlUZmtyTzNoTjNsakJCK3lLT0VTV0liQlFGRTg3?=
 =?utf-8?B?TDgwWnJrS0x3cGJYM29ya0JpakQycFdmWVd0aHliSXpkU2tkdHZHbkZrMm5j?=
 =?utf-8?B?V2ppV0JNejBKYWFLMW1iblZSRDFPY1NXbDc2ZmNaRnQ2YjRFa2pzdVllVVNw?=
 =?utf-8?B?V1JMeDZNSmFSVGpDYW5IeEZYd0pxS0FFa3ZQVWZiaWp6YlVvOXNCYkRMK3pr?=
 =?utf-8?B?QVpNeGNtVjdQVFdYdzJnR0lWZHhaRnRqQjdJUHpac09OSUg4YVhYbW5QZURH?=
 =?utf-8?B?bHlId1p4TGpzR29KZHhKY3piWHllTE5hZUplODhHcERwYXFYTWNvYmprT1dj?=
 =?utf-8?B?QjdJOUN4Qnh1dXYyL00xR3RKUDhqYXJGV21tYlRVeWlhWWtLcDUyNmN2MFAr?=
 =?utf-8?B?UWlyQ2VVWXVQWEtXM2d1Qng0ajBMZHd5dUZVaitZT0g0Rk1pSmJMUHNyb3Ew?=
 =?utf-8?B?ZnlpQzVpUTJnbW9RV2Iwc3cwb2xpeSt5akxGdnFtVWY1eEkxU0JvTUdPUGcz?=
 =?utf-8?B?cEtHMFhNRmpsZDZLVGdKb2xUMDVFeUZmdE5xM0JMNnIzM09NS0pSZWdORzFZ?=
 =?utf-8?B?M2t5bkd6bjFlOWdFbGFaalpITktpTXUyTTNjWXN0OS9aVWE5ZWc3clhhSjJm?=
 =?utf-8?B?cHA4aDBqaTRQK2VGeHhqcm5MREVVeStLWFdnajY4azBIckxDRzVUQVpwQ3lF?=
 =?utf-8?B?aUV3NmpUdk9hb0hQclBETko1ZUMyaXYzdnBMWmM0Y3hCdnVaY2F1VFNxbklI?=
 =?utf-8?B?cUJDV291ai9uVDJuVjY1ZTlZTi8vTGMzbXpsT2dwRUE5bDNsS0RIbXQybVdl?=
 =?utf-8?B?ZCtEUFMvcTZ6WGNWSXFzVU1OL0hUU2diMGRRbi9ycVljKzk5ZlRPZUJtN2R3?=
 =?utf-8?B?NGhRTVpVREdvN1JUMWZ5OG1vekh3NmRML24yMmphTCtnTGhwbzVZcDRLaWpm?=
 =?utf-8?B?RFNCL015OEJJMnptZitHdlYzUFNtb2NMbEY4ZC9WbXczTmpVQ3QwdnNNaUtq?=
 =?utf-8?B?RnhiVkwxSnA1b0VLNFE3aUlYeDdOQnAySDdCU0hDaXJtRUJZNmFpc3UrakRx?=
 =?utf-8?B?MmF0UVlIR1Jic016SWRBdVZ6a3B4bzByK01RaVpIakFZYVBVWWYrMHVKa2xy?=
 =?utf-8?B?VDE1VG9FZ3RsSjVsYy9GZHRHY1BiUE4zeEZQN2k5eTJFSUY1STk3Qk11SmIz?=
 =?utf-8?B?cThNSFVmTzIzUWcxQlBibE1iUmRFWW83U0x6TmQ3Y2ZTb2VmVjRqTGxBd0FY?=
 =?utf-8?B?cHJXQlFHRkZQZWpUeXdNK255aFBGSEF5aklBeHUvTWRwQzJMMTRLM0xpVDhj?=
 =?utf-8?B?WjZDdnVmR1l1S0FtdWhFd25tcVR3NmtCZ2ZiZmNLMk5rbGFOM1Rvb2oza1Zt?=
 =?utf-8?B?citxN1VmeE9jcnJuYkQ3NGFhUVQ2YnU0S0U4TUt0N2hjV1hGNGxCSm14RlBt?=
 =?utf-8?B?d21rL25jT3MrSENqNUhhSjRrSXo1VlJ1RHBJcC9NNkFzMThhWGFiNmZsQ2ZV?=
 =?utf-8?B?OUVtRWhJUFRleUlEam1oMFhGMCszYzBsRGpIdTI4OE9lTW16L1NDYTQ1VFlV?=
 =?utf-8?B?WUxkTGg1MG9OV0FsZGV4WkRsMFU1OHpvaUxuc0NYb28vR3IrK2ExbWd2QXpa?=
 =?utf-8?B?S0VIUVZQSTBuZWdFVVRYYzVHL3Z4T2Y2dVlOeG53dzlmWE8rZWo0dFd3VzNE?=
 =?utf-8?Q?uoRk=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.80; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(1800799024)(35042699022)(376014)(82310400026)(14060799003)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 15:42:38.6945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a2d648-8d1c-472e-8c32-08de01ca5103
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.80];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9865
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

On 10/2/25 10:32, Andrew Goodbody wrote:
> The sys calls SYS_FLEN and SYS_READ were being used in a way that did
> not allow for file sizes > 2^31. Fixing this required changing the
> signatures of the functions smh_flen and smh_read to allow file
> sizes up to 2^32 - 2 and also being able to return errors that could be
> tested for.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Changes in v2:
> - Fixup smh_flen and smh_read to allow for > 2^31 byte files
> - Link to v1: https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2fr%2f20251002%2dfs%5fsemihosting%2dv1%2d1%2d1124e6becc51%40linaro.org&umid=ee8de4df-2479-48c7-83ae-b302789e6a41&rct=1759415558&auth=d807158c60b7d2502abde8a2fc01f40662980862-944860761829276b5cf613a133926bf7544353ff
> ---
>  common/spl/spl_semihosting.c        | 13 +++++++------
>  drivers/serial/serial_semihosting.c |  6 ++++--
>  fs/semihostingfs.c                  | 13 +++++++------
>  include/semihosting.h               | 13 +++++++------
>  lib/semihosting.c                   | 25 +++++++++++++++++++------
>  5 files changed, 44 insertions(+), 26 deletions(-)
> 
> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
> index f36863fe48d25859ee9af67a67140893b6e9e262..fb578a274d0d937b2ed5bd13e505bcefd4491799 100644
> --- a/common/spl/spl_semihosting.c
> +++ b/common/spl/spl_semihosting.c
> @@ -13,13 +13,14 @@ static ulong smh_fit_read(struct spl_load_info *load, ulong file_offset,
>  			  ulong size, void *buf)
>  {
>  	long fd = *(long *)load->priv;
> -	ulong ret;
> +	long ret;
> +	size_t bytes_read;
>  
>  	if (smh_seek(fd, file_offset))
>  		return 0;
>  
> -	ret = smh_read(fd, buf, size);
> -	return ret < 0 ? 0 : ret;
> +	ret = smh_read(fd, buf, size, &bytes_read);
> +	return ret < 0 ? 0 : bytes_read;
>  }
>  
>  static int spl_smh_load_image(struct spl_image_info *spl_image,
> @@ -27,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>  {
>  	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>  	int ret;
> -	long fd, len;
> +	long fd;
> +	size_t len;
>  	struct spl_load_info load;
>  
>  	fd = smh_open(filename, MODE_READ | MODE_BINARY);
> @@ -36,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>  		return fd;
>  	}
>  
> -	ret = smh_flen(fd);
> +	ret = smh_flen(fd, &len);
>  	if (ret < 0) {
>  		log_debug("could not get length of image: %d\n", ret);
>  		goto out;
>  	}
> -	len = ret;
>  
>  	spl_load_init(&load, smh_fit_read, &fd, 1);
>  	ret = spl_load(spl_image, bootdev, &load, len, 0);
> diff --git a/drivers/serial/serial_semihosting.c b/drivers/serial/serial_semihosting.c
> index 56a5ec72428afdd97eccad739a46189380ba3e76..017b1f8eda84f5c25e09be7e970d0ebfdbf2ace0 100644
> --- a/drivers/serial/serial_semihosting.c
> +++ b/drivers/serial/serial_semihosting.c
> @@ -25,11 +25,12 @@ static int smh_serial_getc(struct udevice *dev)
>  {
>  	char ch = 0;
>  	struct smh_serial_priv *priv = dev_get_priv(dev);
> +	size_t bytes_read;
>  
>  	if (priv->infd < 0)
>  		return smh_getc();
>  
> -	smh_read(priv->infd, &ch, sizeof(ch));
> +	smh_read(priv->infd, &ch, sizeof(ch), &bytes_read);
>  	return ch;
>  }
>  
> @@ -140,11 +141,12 @@ static void smh_serial_setbrg(void)
>  static int smh_serial_getc(void)
>  {
>  	char ch = 0;
> +	size_t bytes_read;
>  
>  	if (infd < 0)
>  		return smh_getc();
>  
> -	smh_read(infd, &ch, sizeof(ch));
> +	smh_read(infd, &ch, sizeof(ch), &bytes_read);
>  	return ch;
>  }
>  
> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
> index 77e39ca407e4d240a1fd573497c5b6b908816454..71b6634b0660e32cc63f7fc60ec1af8d3248433a 100644
> --- a/fs/semihostingfs.c
> +++ b/fs/semihostingfs.c
> @@ -23,7 +23,8 @@ int smh_fs_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info)
>  static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>  			  loff_t maxsize, loff_t *actread)
>  {
> -	long fd, size, ret;
> +	long fd, ret;
> +	size_t size;
>  
>  	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>  	if (fd < 0)
> @@ -34,19 +35,19 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>  		return ret;
>  	}
>  	if (!maxsize) {
> -		size = smh_flen(fd);
> +		ret = smh_flen(fd, &size);
>  		if (ret < 0) {
>  			smh_close(fd);
> -			return size;
> +			return ret;
>  		}
>  
>  		maxsize = size;
>  	}
>  
> -	size = smh_read(fd, buffer, maxsize);
> +	ret = smh_read(fd, buffer, maxsize, &size);
>  	smh_close(fd);
> -	if (size < 0)
> -		return size;
> +	if (ret < 0)
> +		return ret;
>  
>  	*actread = size;
>  	return 0;
> diff --git a/include/semihosting.h b/include/semihosting.h
> index 4e844cbad87bb1ae6bb365f87f3e7a8aeea445f4..60535199b9532ce16620aea3ca1ea741c5b73766 100644
> --- a/include/semihosting.h
> +++ b/include/semihosting.h
> @@ -95,12 +95,12 @@ long smh_open(const char *fname, enum smh_open_mode mode);
>   * @fd: A file descriptor returned from smh_open()
>   * @memp: Pointer to a buffer of memory of at least @len bytes
>   * @len: The number of bytes to read
> + * @read_len: Pointer which will be updated with actual bytes read on success,
> + *  with 0 indicating %EOF
>   *
> - * Return:
> - * * The number of bytes read on success, with 0 indicating %EOF
> - * * A negative error on failure
> + * Return: 0 on success or negative error on failure
>   */
> -long smh_read(long fd, void *memp, size_t len);
> +long smh_read(long fd, void *memp, size_t len, size_t *read_len);
>  
>  /**
>   * smh_write() - Write data to a file
> @@ -124,10 +124,11 @@ long smh_close(long fd);
>  /**
>   * smh_flen() - Get the length of a file
>   * @fd: A file descriptor returned from smh_open()
> + * @size: Pointer which will be updated with length of file on success
>   *
> - * Return: The length of the file, in bytes, or a negative error on failure
> + * Return: 0 on success or negative error on failure
>   */
> -long smh_flen(long fd);
> +int smh_flen(long fd, size_t *size);
>  
>  /**
>   * smh_seek() - Seek to a position in a file
> diff --git a/lib/semihosting.c b/lib/semihosting.c
> index 9be5bffd30124777c4f8110065e6cca5640312ac..a0f42d41e4a7ad95023c684f6824bfc677ad25cd 100644
> --- a/lib/semihosting.c
> +++ b/lib/semihosting.c
> @@ -93,9 +93,9 @@ struct smh_rdwr_s {
>  	size_t len;
>  };
>  
> -long smh_read(long fd, void *memp, size_t len)
> +long smh_read(long fd, void *memp, size_t len, size_t *read_len)
>  {
> -	long ret;
> +	size_t ret;
>  	struct smh_rdwr_s read;
>  
>  	debug("%s: fd %ld, memp %p, len %zu\n", __func__, fd, memp, len);
> @@ -105,9 +105,20 @@ long smh_read(long fd, void *memp, size_t len)
>  	read.len = len;
>  
>  	ret = smh_trap(SYSREAD, &read);
> -	if (ret < 0)
> +	if (!ret) {
> +		/* Success */
> +		*read_len = len;
> +		return 0;
> +	} else if (ret == len) {
> +		/* EOF */
> +		*read_len = 0;
> +		return 0;
> +	} else {
> +		/* Partial success */
> +		*read_len = len - ret;
>  		return smh_errno();
> -	return len - ret;
> +	}
> +
>  }
>  
>  long smh_write(long fd, const void *memp, size_t len, ulong *written)
> @@ -140,7 +151,7 @@ long smh_close(long fd)
>  	return 0;
>  }
>  
> -long smh_flen(long fd)
> +int smh_flen(long fd, size_t *size)
>  {
>  	long ret;
>  
> @@ -149,7 +160,9 @@ long smh_flen(long fd)
>  	ret = smh_trap(SYSFLEN, &fd);
>  	if (ret == -1)
>  		return smh_errno();
> -	return ret;
> +
> +	*size = (size_t)ret;
> +	return 0;

This is completely wrong. long is 32-bits on 32-bit systems, so you
cannot get the upper 64 bits just by casting to a size_t.

--Sean
