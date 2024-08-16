Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7A0C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 12:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3CC688B11;
	Fri, 16 Aug 2024 14:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="u9bLPYz8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16B4988B06; Fri, 16 Aug 2024 14:28:32 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6838889F8
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBaXWB/WHPaP9duiJuu29kTBTl58qcObJV2hVRqFQm8YqbtXTc59eh5mBIhW/FhFwDkKm81VWQq9b+ngg+UxOkUcHwMpuJa/+1hwmwa0OsqQw+sUXS7A3ugAEx9yZV/XS09J+u1WHzgXwJffINW3ayLi1niwHtzgwBIRu4ZUVHnDt7Bb7wlA8qNI/AUsXJjcDYgl/mFxCbF/R7+7DdT3hLJ5P7isJVq7etgB/NKVefGiO7ISFq7HK78zwELmfYD0aWjZSMb620GCaSs7R7NKDkrQkRqKTGUkdvz9lKpAyIpj/J2h9d142zPfx7GI4Ospj2zLvsLtrBQHoKVKJ6re2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qer0PGB/qtX4IhDrQTZiAZCvINx1p0c1cn6x3gdhrSQ=;
 b=WkSvj0/e+KKHROinjT4zGrac3GTQzJEFDSDHVnGEyLWUriIBIMLRNRmy53gpbkJJJCWYm6+e1WL335NHDoBx1ZJ4zl4o68oqPbS+fseXyofJaSoRUqA/oJwd5M1MLn4zkFW3oLcD6XE8iUy/Ap/+BCwM/1vYGn8SaWtReUwNFZS3XHY5ja//L1jiPfOAC9mlzXqCfY/PeGfqV9+PANp44BRSkQZjskkjCZqXc5DpeB5NzgZAD7I+Wo3TxbZipFEf0Bezv2EbqSfe1NLGNuxGXXKRMVfQ/NwMMHtiRcFmWm5eQUvPaKK/8e1MHCO6D25uVo9y1Qu/tQuyiqndasrzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qer0PGB/qtX4IhDrQTZiAZCvINx1p0c1cn6x3gdhrSQ=;
 b=u9bLPYz8LXn6+ybrgRohLoxZrk31m4E/n/CsRMOb3dvShzQmtXhq3d+pYvH1FuTZIR/7gDd9d5j2foDZ941FJZHf0Rg29P/k4inwcltkn7KWi/GZZUfW3xtaC3sAtjaG2XD6pWQs5tPTb8avIG0nW1IvymMMN7ph/DwfXAyR8mfTaViCk3uQYo3jMbFaz2pSRDyWM0NUuQ41r2Y5jShM1LJruAQ+PB/eSKMzWdN0MZ19ZO2L81EYaUGo3veB2mdgsryUH80J3j6lD5fEHSiNFriscaYnkX0AH42NUCyQU3QhNWYFwLzDK05ZNYK70mmoZV7FTCcGGb3XGdj9IFch0w==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB3PR10MB6905.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:428::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 12:28:22 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7849.021; Fri, 16 Aug 2024
 12:28:22 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "bb@ti.com" <bb@ti.com>, "joao.goncalves@toradex.com"
 <joao.goncalves@toradex.com>, "c-vankar@ti.com" <c-vankar@ti.com>,
 "rogerq@kernel.org" <rogerq@kernel.org>, "nm@ti.com" <nm@ti.com>,
 "dannenberg@ti.com" <dannenberg@ti.com>, "n-jain1@ti.com" <n-jain1@ti.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "afd@ti.com" <afd@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "michal.simek@amd.com"
 <michal.simek@amd.com>, "d-gole@ti.com" <d-gole@ti.com>, "danishanwar@ti.com"
 <danishanwar@ti.com>, "devarsht@ti.com" <devarsht@ti.com>,
 "w.egorov@phytec.de" <w.egorov@phytec.de>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>,
 "kishon@ti.com" <kishon@ti.com>, "sjoerd@collabora.com"
 <sjoerd@collabora.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "matthias.schiffer@ew.tq-group.com"
 <matthias.schiffer@ew.tq-group.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "kabel@kernel.org" <kabel@kernel.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "srk@ti.com" <srk@ti.com>
Subject: Re: [PATCH v3 04/10] soc: ti: k3-navss-ringacc: Fix reset ring API
Thread-Topic: [PATCH v3 04/10] soc: ti: k3-navss-ringacc: Fix reset ring API
Thread-Index: AQHazpbuejjhjHLwGkeXHNStsrwvuLIqEmAA
Date: Fri, 16 Aug 2024 12:28:22 +0000
Message-ID: <047e9aff7ac10f52cd3afb052da6874eb4ebbdda.camel@siemens.com>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-5-c-vankar@ti.com>
In-Reply-To: <20240705045030.1141934-5-c-vankar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB3PR10MB6905:EE_
x-ms-office365-filtering-correlation-id: d0e3493a-03bd-4b0a-2eda-08dcbdeeeb32
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?djR2L0MwUG91M2ZreHZVcWxvRkZlRThXcHVkbE8vTXdzYTlEUjdoa2MrTWp4?=
 =?utf-8?B?dmFvZ2w5WnpnVTBLbkJGODVYcHVrTXFvVnlPWmQrRHNXOWpzMHlaWEI2MG1X?=
 =?utf-8?B?STlrQTR0WFpVc3A3eGMvMVRLMWRFMlZlejczd2NIK0hSOXdTYVZrVXlLNHBX?=
 =?utf-8?B?OFVMbDBMOFdyQ1lHOGE3djh4U2YwMmpXRHhFcFFIc0V6N0RGYUNRRU8rTHUz?=
 =?utf-8?B?UFVXdTJuYXNNWkFNd1JEWEQ5aGNDSzgwWEFrQmZUV2lKUWVLY2JNZ21IdkU0?=
 =?utf-8?B?VnFqbjZMZEJWZzQxaGl0dlVaSFZNMEhTOHM1K21DZUFuZ1poUFBLSThqWStS?=
 =?utf-8?B?VXpIWHRTay9LK1Zod2dJRE9SamduSE81L0NubGdCQzVQbElBbElrVEpCWS9w?=
 =?utf-8?B?Wi9IRjd5YTltQlZIekswVWMwMVc0bzdtd3NjQ1IybmE1Qy9XZ1BUS0FtMndQ?=
 =?utf-8?B?cnByWTVUZDFVZEpZOXkwZ0hscTZ4OXIvWEF6NFdla1dZRGhUSnpyd1hPcDJV?=
 =?utf-8?B?TzB2TmRpZ1djeDE3QzNxT1BLS0hBQ3BjR1FZeFBhKzIzUkdVd1o3MjVaMldU?=
 =?utf-8?B?bkVtZ1MyQm9jblZTcjZGU1BTME9YTG0wemJoakF5bHdBcTl1M2RRMnlQZ3NW?=
 =?utf-8?B?MUYyWGxmQlNKVHpFUDRJWUhUbU83WWJQTUhUVXZSejdqWVQzRUl3WCtNZ3I4?=
 =?utf-8?B?bHcrRWNaSm41NDM3dG5rRDllY3ZIRlRZaC9jTTMvRVBUbjMzVjJ2NWdSdlN1?=
 =?utf-8?B?SUZrTkFjR3I4a2ZiUlltTnE1NzBBZmpXUFVBWTMwYWtiNnVVamxQUmRYZEJm?=
 =?utf-8?B?cG1QK2dzVmNTNW5ZYjMwWFA3ZHo1Y21VdVJZRTFpT1FIRFFhSXJpMkZxMGV1?=
 =?utf-8?B?ckdNQ0hIcnNTamRGQmVkVHlRend1VjM1Wlg5V251K1hSUFQ0aGpxK0RpL3V0?=
 =?utf-8?B?enVoNXJZNW5uMm43ZWdDejlTejNBdU9hdGRDMXJlREV0T1lINFpLVEpmK2Ju?=
 =?utf-8?B?MjBrbnFWNVZDR0ZyQXBFbTZUeDhENmNFcnUyVHU4T09VTjVhb3htQ29IRWph?=
 =?utf-8?B?Q3pkSjh2WFBIZk5lcEo3N2tiMnFCNisvNnJtdFhoMjdGZUI0aDJDTzRuUG56?=
 =?utf-8?B?L1pqSzRlN25nU2IvUEpSUTdxWjROOU1yMXA0UGhlbklYY3JYV0hVUkZXbnhn?=
 =?utf-8?B?Y2k5YkJ0S1ArengxaUowN3V3YnpvS0NMOWhHOHlEVWpiVHpoWHcreFhXUWE4?=
 =?utf-8?B?djh0bjZBTDk3b0d0ZmIyMVVTMGx4TE92M3FGOFVSOGh3Rk9heTRpOXEwc2gw?=
 =?utf-8?B?Rm5FcUJKRWVVdWZuYkl3WVliOHhaeEdQMjlMS1gvRnplalMrbEh1aGd3NzA5?=
 =?utf-8?B?SEd3TjRGemYwbFQrSXBuVVBnVGFQUDRXYmVqazFkaFVnckJ3ZUE2SFdYNktY?=
 =?utf-8?B?K3luQ0lBNEl1ZWphYnRVNEYzNU9FN2ZoRFh4T0ZIRXVVaDVNUnhPbmxraTJp?=
 =?utf-8?B?UldXa3MvZ0w3UXc2S0gySk9xT0tXUTFiRTNiWHJ3ZUlzSGtnTG03T3crVFRR?=
 =?utf-8?B?Zk5GN09ra00wQWx3aHFiRjk0OXlzTDBzZjMxbjVZcTcxR1gvSWlEWVhBOTBX?=
 =?utf-8?B?VmE4U01lZEVIUFlRem5ydDJjTUtyMmRKTld0UjhUczJMR1ZvT0pqdjlEVmN3?=
 =?utf-8?B?Y2hGUjZvN3lpVHpYNUNyVEJiVlJPaXowOG5WV28zNCtkMGQwQms0MXB0Nngy?=
 =?utf-8?B?MW5naHBEakFNTnlFSXhFTVBtOU84V1pQTTJ3dTRzR2N6S2dMR000cHNqajlv?=
 =?utf-8?B?TjNEdk5EREttZFdqTlg0WU5vemlHU1BrK1c0dXVQQmxQMkVrbGpsV3c5bkds?=
 =?utf-8?Q?Eq+3V+MoR5fpQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekVmTUw1YXNzR3AxM2p5emx1elRJR3c2SjNyTWNvV2tFdzd3SkxidC9yb3VC?=
 =?utf-8?B?Z3ZnVlZTaGRnREZvMHNZcGcvMWlqeEI1eGVBNHAwSUovUWl6Q1Yvdmo3Wng0?=
 =?utf-8?B?R001MTJQWlcwZndkdS9Pc1NtM1RyNjlpcGZ5emwrNHlMYTFsczVlMmpiMU5L?=
 =?utf-8?B?dTJCb29DK2Znbjd2aDE4WU1MUitRZDNVWnFiT0lKSEFVVFowa01wUXFTMTR3?=
 =?utf-8?B?b0k0cHRabjY5ZzN5V0pnM21hTS9CelJtbEtrQnBpVUNtc0NzUDlJS1Myb1l2?=
 =?utf-8?B?WFFwWTlwQWovbHJWSnAya0J3RGFJNzBNY0gyZGRSSlRXTldIaVF5Y2hIUHFh?=
 =?utf-8?B?Q3lvMy85MEx5YkRBSi9HYkxvQVhZMG5tTjBqdHp4Vmk3Y3BxaEdFQy9BVVZG?=
 =?utf-8?B?MitqNjdVVGFhYWE0bTNkcVEvc0hpTEo4aHlmQ0U0dmZBOTBpNHZ4ZjZhVFdv?=
 =?utf-8?B?TUlQR1lCakZhWTJSc2ttR0FicTBBazZSbU9aWVJsU1djY3JOb1FNVHRObzA0?=
 =?utf-8?B?SUh0U2NMemRlaE4yTzE1SHVvb0xobERmOCtzMFNPMHV5WEU2QWFPUzAvU2do?=
 =?utf-8?B?SnQxcmFubTJCVWhId1FJVms5UkVxNVNNaTFsdkNSa3dRZnJVUlBLK0Q1VGVU?=
 =?utf-8?B?RTFtSUpBaE5XUFk4WWFUc2V5TUsxRUtRSFFwUnhCTjI1aUJieUx0WXExOEhO?=
 =?utf-8?B?cCs2MldnQnQydGJkSjZ2N1hvRFFTejJRWjBDWVB1R2F5b2VHZ3BQNlMwV1JB?=
 =?utf-8?B?M1JJRFVIVnMzai9NZUFKU1VaQ2RMM1Y1M3ZYb1I5czYzZTJYL3pvUXA0N1c1?=
 =?utf-8?B?d1BmbmFXTi9QZ2txWk5wMEJ2VFlFNkZvQXMxSFY3d3k5Skw4YVJTTkI3djBu?=
 =?utf-8?B?K0lqblBUeDZmWktuN0ZuWXc2Z2p6SEM4MjJMK2xaWGl5TmZ0V3lHb1d6MGRN?=
 =?utf-8?B?Z2oybkx6TC9wM1RBWHB4T0JGQ0hUbGxLMitVR0M4OG4zRVAwejNmQVlnL2oz?=
 =?utf-8?B?a215Q1o4TUNGR1Q5UGg2aTFwQ05haXpjNEZxYWw3VVNLZFFRZUg2bGlqMXpE?=
 =?utf-8?B?VHpPWmliZDRXOWFoS1YwSjFpaDhnVHA1UWlWTHd5SkJ6WVJSUnRla0hrRml6?=
 =?utf-8?B?dzFiMU5DSldtQjliSnRzaURkK1ZVbGk2UXgwZ29VbmdwYzJPZEJmeTFQSWor?=
 =?utf-8?B?SEJxZVBlWlVTNDBjL1A2VU5odmpCOTVCNFk0Ymc3YkpyaXhDUTJPZmQ2dkww?=
 =?utf-8?B?cnJCdFp0VUIzTlBNM1huRW9MRTFVamJKQVMwbVEvMFlUTitJWk5VcEpNbnJG?=
 =?utf-8?B?MWh5eUlGN2pyMThQVVZaSEg0VDVjNmtYMExhY3Z2U1orSUZMWVRMZUJ1b014?=
 =?utf-8?B?czlVN2RZUnZ1VjRTUXhXTEZoUjdaMWxaeTRnRjd6dVdJb0dZSUYxNy80enV0?=
 =?utf-8?B?eW83dm82N2lOWTArNEh1dGdrTjJkUGtpUm15MU5wMGEwOG45K0ZnSWVMMmVO?=
 =?utf-8?B?ckMvNFpKMndwWFdtNWtlMWQ4b1F5SUoxd3hOd09KbnVzdS8xS0lGUTBDeFg5?=
 =?utf-8?B?Z2lyeXJjN0lyV0RvQysyWXh4N0h2b2FZeTJyeVlpdnk0SkppbXUxcE40SEk1?=
 =?utf-8?B?bkR2M3FTM3l3WExCdDhmNUg5VmFWTGwzbHlURGRyWlNvYXZCWFU0R3liSHB1?=
 =?utf-8?B?WTAvMmYxYzNrZkJHdEVmZ1VmOW1GNEtoTGE5cXlLM01nV1hic3hhWWRUZ21S?=
 =?utf-8?B?K3d0ZXY5TTdpZDZHMFFkWFlXclVSQmZyV0gxQVlHZ05aWWlHek8vL0k2Z1ZX?=
 =?utf-8?B?REV2WnRPY0hGL3pYUWtmRlRSN0k4RmQ2V3BiRWlGcE9zWXV0UExaaTNFdVhW?=
 =?utf-8?B?disvMVc4bXRKdjgxa3Z3S2JCQVZsMWNoNVA5YUZGaGZ2ZE9LT3Z1S0Q0T2sy?=
 =?utf-8?B?NzFmLzM5MEJvc0lTRjJjaE9wSWx4M1NNcUV2RzhCazlsWGVyTTQrWFRzWjdR?=
 =?utf-8?B?cE15SmRqek5SOXBKcnRuUmRnbFovRklSZDI4elBMNkp4RzNuS21HdHhXSmdB?=
 =?utf-8?B?cVdZdzZCVUdwemR2NzFEbjFmbDBlY09xc3dielUrRU9maTNzaUtDMXVEZVNJ?=
 =?utf-8?B?UnlwQnBWZzZ3T0pnY0l0Q0x3MWRxTzR3dVlhOGhNV0U3SytPZHdSNWhjTHNv?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21C071CF1565124CA43D1D5B4154B4E9@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e3493a-03bd-4b0a-2eda-08dcbdeeeb32
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 12:28:22.5012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+rPPDmRa0zcDbPS8tUvENLwxshRecXnbwCUdxOiLeWLcTmPVgsZe5+mG92q54kvCnZS+TOgRnCy0xOT672ZcZWxTAzyNcNSALPRNPN9fa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6905
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

SGkgQ2hpbnRhbiwgVmlnbmVzaCwNCg0KT24gRnJpLCAyMDI0LTA3LTA1IGF0IDEwOjIwICswNTMw
LCBDaGludGFuIFZhbmthciB3cm90ZToNCj4gRnJvbTogVmlnbmVzaCBSYWdoYXZlbmRyYSA8dmln
bmVzaHJAdGkuY29tPg0KPiANCj4gRXhwZWN0YXRpb24gb2YgazNfcmluZ2FjY19yaW5nX3Jlc2V0
X3JhdygpIGlzIHRvIHJlc2V0IHRoZSByaW5nIHRvDQo+IHJlcXVlc3RlZCBzaXplIGFuZCBub3Qg
dG8gMC4gRml4IHRoaXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWaWduZXNoIFJhZ2hhdmVuZHJh
IDx2aWduZXNockB0aS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNpZGRoYXJ0aCBWYWRhcGFsbGkg
PHMtdmFkYXBhbGxpQHRpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQ2hpbnRhbiBWYW5rYXIgPGMt
dmFua2FyQHRpLmNvbT4NCj4gLS0tDQo+IA0KPiBMaW5rIHRvIHYyOg0KPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yLzIwMjQwNDI1MTIwODIyLjIwNDgwMTItNS1jLXZhbmthckB0aS5jb20vDQo+
IA0KPiBDaGFuZ2VzIGZyb20gdjIgdG8gdjM6DQo+IC0gTm8gY2hhbmdlcy4NCj4gDQo+IMKgZHJp
dmVycy9zb2MvdGkvazMtbmF2c3MtcmluZ2FjYy11LWJvb3QuYyB8IDkgKysrKysrKystDQo+IMKg
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc29jL3RpL2szLW5hdnNzLXJpbmdhY2MtdS1ib290LmMgYi9kcml2
ZXJzL3NvYy90aS9rMy1uYXZzcy1yaW5nYWNjLXUtYm9vdC5jDQo+IGluZGV4IGY5NTgyMzljMmEu
LjVkNjUwYjlkZTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL3RpL2szLW5hdnNzLXJpbmdh
Y2MtdS1ib290LmMNCj4gKysrIGIvZHJpdmVycy9zb2MvdGkvazMtbmF2c3MtcmluZ2FjYy11LWJv
b3QuYw0KPiBAQCAtMjUsOSArMjUsMTYgQEAgc3RydWN0IGszX25hdl9yaW5nX2NmZ19yZWdzIHsN
Cj4gwqAjZGVmaW5lIEtOQVZfUklOR0FDQ19DRkdfUklOR19TSVpFX0VMU0laRV9NQVNLCQlHRU5N
QVNLKDI2LCAyNCkNCj4gwqAjZGVmaW5lIEtOQVZfUklOR0FDQ19DRkdfUklOR19TSVpFX0VMU0la
RV9TSElGVAkJKDI0KQ0KPiDCoA0KPiArI2RlZmluZSBLTkFWX1JJTkdBQ0NfQ0ZHX1JJTkdfU0la
RV9NQVNLCQkJR0VOTUFTSygxNSwgMCkNCj4gKw0KPiDCoHN0YXRpYyB2b2lkIGszX3JpbmdhY2Nf
cmluZ19yZXNldF9yYXcoc3RydWN0IGszX25hdl9yaW5nICpyaW5nKQ0KPiDCoHsNCj4gLQl3cml0
ZWwoMCwgJnJpbmctPmNmZy0+c2l6ZSk7DQo+ICsJdTMyIHJlZzsNCj4gKw0KPiArCXJlZyA9IHJl
YWRsKCZyaW5nLT5jZmctPnNpemUpOw0KPiArCXJlZyAmPSBLTkFWX1JJTkdBQ0NfQ0ZHX1JJTkdf
U0laRV9NQVNLOw0KDQpzaG91bGQgaXQgYWN0dWFsbHkgYmUgInJlZyAmPSB+S05BVl9SSU5HQUND
X0NGR19SSU5HX1NJWkVfTUFTSzsiPw0KT3RoZXJ3aXNlIHlvdSBjb3VsZCBwb3RlbnRpYWxseSBi
dW1wIHRoZSBzaXplIHRvIHNvbWUgbnVtYmVyIGhpZ2hlciB0aGFuIHJpbmctPnNpemUNCmlmIHlv
dSAiT1IiIHJpbmctPnNpemUgd2l0aCBzb21ldGhpbmcgbG93ZXIgdGhhbiByaW5nLT5zaXplIGFu
ZCByaW5nLT5zaXplIGlzIG5vdA0KTl4yLTE/DQoNCj4gKwlyZWcgfD0gcmluZy0+c2l6ZTsNCj4g
Kwl3cml0ZWwocmVnLCAmcmluZy0+Y2ZnLT5zaXplKTsNCj4gwqB9DQo+IMKgDQo+IMKgc3RhdGlj
IHZvaWQgazNfcmluZ2FjY19yaW5nX3JlY29uZmlnX3Ftb2RlX3JhdyhzdHJ1Y3QgazNfbmF2X3Jp
bmcgKnJpbmcsIGVudW0gazNfbmF2X3JpbmdfbW9kZSBtb2RlKQ0KDQotLSANCkFsZXhhbmRlciBT
dmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
