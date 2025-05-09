Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD2FC3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 12:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E05082A25;
	Fri,  9 May 2025 14:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=draeger.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=draeger.com header.i=@draeger.com header.b="sfrdrawT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA56F8210D; Fri,  9 May 2025 11:40:49 +0200 (CEST)
Received: from FR5P281CU006.outbound.protection.outlook.com
 (mail-germanywestcentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20c::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE6328059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 11:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=draeger.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Olaf.Baehring@draeger.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLLrG4H24Kmfhc2c9AOL/y47PNLNXGfy1vaTjZn484ZyVzz//9jgNN5tijLUXN6JHb2KMYe7UubOj/30H5WqDzMT/Y4dKfyvdXKlshXExUo/gQlIdTkmvJURdUYdVYcPc4aPPGy0MumnsF79XAsjkPwpCXkfaRyRcCK4LuoeRob77PAlqszJ5BTb6cn9LfxPD+semJ6nqhd4oRAb0LT/HDdmTJhjGfCdoqfjML+ntJ/h+sEQUloy4MO8cefYmKHd6V3ozoDOXfzILxpZ4LV2Rnb1AFo9AACcQKf+qKaGm+uDLQAbYUIUisJB8RRZOpw2xYoVLxj2ojO0CwBCC+J6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MobRfmKOvX/HjmaWuL4jX2kFWRGCMpdwlie7qwCm7qY=;
 b=VHFV2VnNB5giNwB5lnGp1x2xBg+6EKzGuNGYKD2TatYLbkiwc/r0QSJwxViAZ5zlh+R6jV29bIlePCN+JD9E3LQdrCJ323MvNWvs3YAHr5PwhucaSIK+mukIjxw2ASlJ4qixD0SqpI1KWY8lROP2FwfPaS7+zVThTXNFbB00ha8Gl5OiRFfd0xkQOP0AwzUB92NR8Z2CEGD/etuweLwhNqaVNx/1YX+FVn0438dfWeF1zzP4pnOu9xzebim9kNiSzpA8JIHWkJTeqNAZTy8HFhYNHWi0SJEfoAzkHOmaFy34ocGH/tQVoovAI5YuDduNmglW9TokSAI19HcsVAnEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=draeger.com; dmarc=pass action=none header.from=draeger.com;
 dkim=pass header.d=draeger.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=draeger.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MobRfmKOvX/HjmaWuL4jX2kFWRGCMpdwlie7qwCm7qY=;
 b=sfrdrawTD71AgQx1kHqSYT+36P2vtjMjEcM352dU3gEvxcVeeY3282wPSVzOF53ZwoCLJUz3+hKo4PTGpW2MouXj0CK7gw9sWr208DYFPJVHRnhgUAEIZY0yquSI0GNsR247QENK/FyafN1xZwVc6XYs8e53p7G1LV/ua3oA8zx7amWdNv/GXPFGWYg4zGPDYIVQZcDb93yaybm1wWQVYzzmhNB4Pq+jRQrcBN1RJDrv65wu2oJ0KIFHOGegfFNzU0o6aWJgCwQaZ6hJSqqjt/56HI4NuMPkcKwSktGlJ2UqMhcwdREJ2DmAd9+pDpR1P6dnzZ8NsSxz6ilLwcjQGA==
Received: from BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3e::5) by
 BEUP281MB3676.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a1::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.23; Fri, 9 May 2025 09:40:45 +0000
Received: from BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a8ca:7b80:b13a:ccfa]) by BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a8ca:7b80:b13a:ccfa%3]) with mapi id 15.20.8722.024; Fri, 9 May 2025
 09:40:44 +0000
From: "Baehring, Olaf" <Olaf.Baehring@draeger.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: Gaurav Jain <gaurav.jain@nxp.com>, Marek Vasut <marex@denx.de>, Peng Fan
 <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: arm:, imx:, caam: [PATCH] bugfix CAAM error on startup
Thread-Topic: , imx:, caam: [PATCH] bugfix CAAM error on startup
Thread-Index: AQHbwMZvu6V0n0UYzUeep5HWjvqTsA==
Date: Fri, 9 May 2025 09:40:44 +0000
Message-ID: <BE1P281MB22929674BBA49DDCF59D404CE18AA@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
References: <BE1P281MB229278535DE4B55BD7240B14E18D2@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
 <a0971d75-fb68-476a-9d65-025584231859@gmx.de>
In-Reply-To: <a0971d75-fb68-476a-9d65-025584231859@gmx.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_16b2258f-3676-449a-9218-817a22e44788_ActionId=90fbc017-0208-4a81-8e3f-a7d1bc953dc4;
 MSIP_Label_16b2258f-3676-449a-9218-817a22e44788_ContentBits=0;
 MSIP_Label_16b2258f-3676-449a-9218-817a22e44788_Enabled=true;
 MSIP_Label_16b2258f-3676-449a-9218-817a22e44788_Method=Standard;
 MSIP_Label_16b2258f-3676-449a-9218-817a22e44788_Name=Internal -
 Labeled;
 MSIP_Label_16b2258f-3676-449a-9218-817a22e44788_SetDate=2025-05-09T09:35:37Z;
 MSIP_Label_16b2258f-3676-449a-9218-817a22e44788_SiteId=e8d897a8-f400-4625-858a-6f3ae627542b;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=draeger.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2292:EE_|BEUP281MB3676:EE_
x-ms-office365-filtering-correlation-id: 860d091f-c028-43fd-873b-08dd8edd91ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T3RmUUlHOW4wOGNSWHd0b09aSDNXU2JjSWRQOFo5K0RNc0dUQ3RRK2tSU3Fa?=
 =?utf-8?B?VGlmR3pybWpkblAxVU51VHd5R1ppalVEUnlVWVNTZ0tLd1FIVCtIZXBJbnp3?=
 =?utf-8?B?Q1pIQ2VGOGJoNXdoZVlBMmVCWC9tWE5YL1UxM280NlRKZzBkbmk0NER1OWlh?=
 =?utf-8?B?NTRhVHVVMDM1bGE2VFp1Z0o2SFJzd0NibGgxUEFqR1UrT3FtY3JRb0NzUkY4?=
 =?utf-8?B?Vjd5MW10aWlVYXNPRmhnQWQyMUJ5TGo1L0dCMlR0QzJGVUJlUzFIRzNKNnZH?=
 =?utf-8?B?U2J1VE9kL2ZKbzBjUEtHUUtOaW5DUE5zQ204MnZPbkxQbVV3Z0h3bXZvNmQ2?=
 =?utf-8?B?Ui84TnRCU3VoR0FnaG93UDhwVXBBWEZybzdybDBFRWxDRnpXSnFMb1NmZkkx?=
 =?utf-8?B?YkFvOS95eElqSk9Ldy9ES1puZGI3OTFZblFBQmMrdlFrWUFVbmhWaldsajVm?=
 =?utf-8?B?TUtGMUg4b2orK1hQek85NUVVb0VKNVF5Tnh6ZnRvb3ZlN29vU21oKzFsKzdq?=
 =?utf-8?B?RW1iR0hLUEVydVVGM1pmQVplcDRsWi9iNXcxOCs2V1hjSVQ3NVppVEtaOUhz?=
 =?utf-8?B?ZWZtRzEwRnVoYmFGSFFtejM0dGM3WlFFQjE3SmNkdEYxc1k2eHlRcG41dHNH?=
 =?utf-8?B?UFhxZTFVU0NaRUIxd2N3anR1Z0U5OCs3SXRRc1hMa3piSHJFeTF3eE9FRXJy?=
 =?utf-8?B?UUFJVGZ3QXhETmdSOExOeDVFclkyV2MvK0RVTmdPcFRKOXFSV0NuYU4rSU45?=
 =?utf-8?B?ckFiTFNqT2svZzk2Z08zbWx2eTBacFZid0NXVnl0NkFIYVYzRldBQk5STkNu?=
 =?utf-8?B?UndrL0VkNUdlK1hQUWJSQzlxWTNZMlFVeXZOMWhtUXBndTJRSUlxWnY2ZjA1?=
 =?utf-8?B?VFl0WnFpR1p6ckFlWkJLVmZJRDNWT1RpZHlSOGlHWmFCSk9IdVh0bTJRZk1R?=
 =?utf-8?B?amF6MkJvZGFwcmlVMW5PMmpLMjI4YUhpbUwxMHVULzBmR0JUTys1c0NIbUR0?=
 =?utf-8?B?NHRua3lYR0MyN2NKemQzSFY5VnkvYVFWNGQ3MWkwMXFZQjU1TFl2RkgySGFL?=
 =?utf-8?B?bW8za0hkQTVkTlJ2YW9zT0RCT3lwUXZzUlpjRGk2cWlOYTIySitUR2VwMm9J?=
 =?utf-8?B?TlNyNTA2Vkk4SzBqSGhGUFk3T20xWTBKNnRnekpBRzIvSjM1M3h4cnBQYWRq?=
 =?utf-8?B?aTZINmtaTjF0ektHRmdFanEzQW8xSnBYOU5sZW91Rm10dVF2UDBUUjRxUmpF?=
 =?utf-8?B?dzQwTnF3d0ZaRnBUYWJuRkRiU2k5TnJyRVNoeDJHU2FKUG1BRklFVmF5dDZ5?=
 =?utf-8?B?eVR3UUNLREpuWGlXOTRJSzBXS3duRWhYaEc0Mnd3a0kybU9QWU5FRU1xSjlT?=
 =?utf-8?B?RVdLeENqR2xReFhMcmo1RDRnMkZjQjYrK1hKRUswM3lKRFQ4Qk9wLzU1REtt?=
 =?utf-8?B?VWNqSXo0cXZrTy9VRTVNaTg0TjFweU92b3R0dTFiQVZiSTN6TUlLY3B2YTF5?=
 =?utf-8?B?b3hac2dkNzFiZVVUZzZIZkRoeWxKWjF2T0M2czBkOFpScUdzdlUxUkgzTHAr?=
 =?utf-8?B?K1RlTUkzaksrNGowK0pBMlVxU3BuRTNkSTlkVnFkOVBKS3pxMTFmamJBTkRN?=
 =?utf-8?B?ek96ODc2TU4zL3ZnR0ZseWJhNlZmOEtxUDFPSFFaODdFbDVReDZFY1NBSjBW?=
 =?utf-8?B?cHdyZGdiTU1pUFlrQmRDNDRYYTRLZWd4UGQ4Sk40SHJQMTBnK3NXYUZ3elNp?=
 =?utf-8?B?dHRYWFRJNTY5d1dhaEhVdnBsZDhzSDNuWC9qU3Urazg0MUVxcnZYVlNPUXJn?=
 =?utf-8?B?OURGZUl5OGRFMjRoYi9LV3hOSXVOL2g5Ykt5ZXlEcWxpS3lJdUI5REQySmRw?=
 =?utf-8?B?Ui8xOHBySjhTL2phOExDak1ldWVteTZ5K2tONVZ1a0U2UXdTQjM3aWJEQzBa?=
 =?utf-8?B?QWdHUXlBTHNEZVZCczFZZlBNOHpHbjc2cnRERkUrVlBJMnh1Z3ZVdG5scVNp?=
 =?utf-8?Q?bBDqr8Wc9UNdcv1wAc9/v9DsmvjZBU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUVkeEJMeGRKTlZReXNMa1NmRDNCUEtqbkZ0Mm94c0xCb0p2Q0dKSDk0WGVO?=
 =?utf-8?B?UlpYM0xyRWhtYkRUMTdxcU14dFpxczVnQkJYNWVqcXZMT1dzSSsvTkRUZi9j?=
 =?utf-8?B?N00zMDFQUitCUkVOUnF5dVRBem90M2hBVlFibHJ0enAyR2xQdEx2eWFGVzVR?=
 =?utf-8?B?cFN1Z3k2SGVmRkQ4SkIyVDAwTmduS2dUL1FMeVBlMWtnYS93cjZvUmU0UEZK?=
 =?utf-8?B?Mzl4ZDU0ZDBPWXY4bkIwVkZmUHVoc013OHpMdjRuTU9sYlJ4OVZxNUEwZCs1?=
 =?utf-8?B?Rkh0Z2Y1WjhlNUJyOUo1ck1INCtPRHJzNHNndW5VWG43eWovQ1JPT0dSY04r?=
 =?utf-8?B?RlpKTlZ6bWxrQ0g4dndDNGJCY1pYbGhGMFMzd3I4T1huR0VweDUydHl5SUVl?=
 =?utf-8?B?bmFxUWdISW9GTzUweHE5WWUzbk1vdFdUbUlzd1RtdGVwZzBhejJBY3lJU1Yw?=
 =?utf-8?B?Z01wVDFQYUsrRTFDY1kwMXZEK3FUWmNnSVJIZnFyb2VKNDJsK3ArM3ZUeTUw?=
 =?utf-8?B?UXZ1cGpZb3V2NXZtT1NVYjF4TDdiKzdPSEJreTA2aEVmUEZsc0JhdHJDbUJt?=
 =?utf-8?B?V1BVZkx3em5IR0VRTTJUQ0RtSVBVNW1sQkQ5WlpCdzc5NmNXZ1ZTTnFRbkor?=
 =?utf-8?B?WU9NRFVJV2paNjRqek5Yb3AzbFF4aDRJb0tvVEx6L0duQ2lYUzZvWlRvUlg1?=
 =?utf-8?B?S1JqdjB0Y1o3OTl3VGNVNGZ4RkIwN2NSNXY1NldXVnRIczZpSldiWGo4eVBU?=
 =?utf-8?B?dkNjR1RCVmJ4QnhocEQvZG5oYk84SHFOMmhuQWpCZTZPc21BbVFoWGlpNkNQ?=
 =?utf-8?B?U3d0SEx3THRxV3Z2TTh2ejhiOE95OTlHRlBsT1dzT3NYak8rYzV2MVoxYys4?=
 =?utf-8?B?VmJJRVBkbi85eUhoQmI5MS91bnFRbDhsTXNrd2ptS2xha05MZ0E0b1kyaWVh?=
 =?utf-8?B?ZlYvN0lPa0kwV2JIcm9KQU9YVjE0RjlybGE4YnpOSmQ2VzdBM0ZHWXRRSWVW?=
 =?utf-8?B?aWtPSjVNV0JoZkYwTC9pZ2NqbHIxb1Njb2FXOGRnWmc4cnF3UjdRSk9zSjhW?=
 =?utf-8?B?OWw1OUswcHJqMlFTbTl3Y29FSk1BRngxaFJBS0ZKL01BYUhXT21waVJLY2li?=
 =?utf-8?B?UVhBbFR6WWFQblNTV0N0UFNzTGJkd2Q1V3h4UkU5MldlZzNXUmhYbTYwZmJW?=
 =?utf-8?B?WTltZElHVkwyM250RGdpQjdEZmNkOWtFbVh5UzIyeWkwa0ZSOTNSRGxaUzhM?=
 =?utf-8?B?ZWR5QTZuMXpTVW5JVVYzOTJJL0JRUkt4cHNLY09uei9aR1N6T1BHUGcwMFF5?=
 =?utf-8?B?WG84QTd1cmNxd0xYTEQxVjRKc2VLaFRVTnJlV0taMHBWZitjSlFRS2pHSTZO?=
 =?utf-8?B?MEkrVzdoM2RDajhkVFo3WmxIWEg1MVJCT1gvUEdqU2paNll3WDgyMWh6dWoz?=
 =?utf-8?B?ZVZQMEx5T21FU2NvK0tCaGhPc29NSG5XS1ZpeStyYmNSZURpcU9jNXlDbmxC?=
 =?utf-8?B?eTg2aUZEcnk2bWRDQXRPM3BGQkdGbEhHck1vclUwZnhkU2x6Y3U5RWxGcCtJ?=
 =?utf-8?B?MllYWm4zQ05mNlMzdm1aVmpCSlhxRWVZaGovQ1lwcHhGY054d0g5K1ZWTEdx?=
 =?utf-8?B?MjczMlZKeTlYb1U4TkF3NWVYNDBvWlplUUJjMCtEK0JOZnhNZmw0eG9nY0lX?=
 =?utf-8?B?anhxakZ2UGxpU1BZcXc0TmZtZG5NSmdQL0FWckduU0xQVlJWb0xOT2RCcnJ3?=
 =?utf-8?B?U3hpZEg3d0h6ekc5ME9kLzR1YXQyNFhGY240bHJRUmxRUmlGeWVlYXpEMXlV?=
 =?utf-8?B?MTdldW4rRWdUWVU2NnQyTGQ2d3N3bWZOSUxsanp5aGxYVkYzNFRmNm5xRVpO?=
 =?utf-8?B?ZU9qNXZmd0ovb0ZsM1pBTTVqZkJ1SkdxL0Y3bGxLS1E1R0hlWkZNcWtkYUpq?=
 =?utf-8?B?K0JmZVpzRHdmNnczZG54UXJSQkpUckdFWlpvTnBkVVNYcGVaNUZDTzNnL3hD?=
 =?utf-8?B?WXpCaGE1SktiQlcyY3B1d1loeGlCT25lcmNsUStKMlovQytUdVdpRURDdkFG?=
 =?utf-8?B?SU1jWm5SeWd6dmZDelhqNXhpSGtGNk9wdEkyMWxFZzVndzRaVkIwaHlVZ0J4?=
 =?utf-8?Q?WPd57FkshM5IF2cNLU0OKowop?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: draeger.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 860d091f-c028-43fd-873b-08dd8edd91ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 09:40:44.1443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e8d897a8-f400-4625-858a-6f3ae627542b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvqErpA21Eq7woe8q6Of3Cq1B7hZVfLiWVVkZ42z4BotuPD8NM90du286j/pzSCC5bwAIuunSZq5+Vm1C0AuTgLk3xL0nD8BNnRZNB5CA/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3676
X-Mailman-Approved-At: Fri, 09 May 2025 14:40:00 +0200
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

SW50ZXJuYWwNCg0KSW4gcmFyZSBjYXNlcyBVLUJvb3QgcmV0dXJucyBhbiBlcnJvciBtZXNzYWdl
IHdoZW4gaW50YW50aWF0aW5nIHRoZSBSTkcNCm9mIHRoZSBDQUFNIGRldmljZToNCuKAnFNFQzA6
ICBSTkc0IFNIMCBpbnN0YW50aWF0aW9uIGZhaWxlZCB3aXRoIGVycm9yIDB4ZmZmZmZmZmbigJ0N
ClRoaXMgIG1lYW5zLCB0aGF0IGV2ZW4gd2hlbiB0aGUgQ0FBTSBkZXZpY2UgcmVwb3J0cyBhIGZp
bmlzaGVkDQpkZXNjcmlwdG9yLCBub25lIGlzIGZvdW5kIGluIHRoZSBvdXRwdXQgcmluZy4NClRo
aXMgbWlnaHQgYmUgY2F1c2VkIGJ5IGEgbWlzc2luZyBjYWNoZSBpbnZhbGlkYXRpb24gYmVmb3Jl
DQpyZWFkaW5nIHRoZSBtZW1vcnkgb2YgdGhlIG91dHB1dCByaW5nDQpUaGlzIHBhdGNoIG1vdmVz
IHRoZSBjYWNoZSBpbnZhbGlkYXRpb24gb2YgdGhlIG91dHB1dCByaW5nIGZyb20gc3RhcnQgb2YN
CnRoZSBqb2IgdG8gaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIG5vdGlmaWNhdGlvbiBmcm9tIGhhcmR3
YXJlIHdoZXJlIHRoZQ0Kb3V0cHV0IHJpbmcgd2lsbCBiZSByZWFkLg0KDQpTaWduZWQtb2ZmLWJ5
OiBCYWVocmluZywgT2xhZiA8b2xhZi5iYWVocmluZ0BkcmFlZ2VyLmNvbT4NCi0tLQ0KDQogZHJp
dmVycy9jcnlwdG8vZnNsL2pyLmMgfCAzMCArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0N
CiBkcml2ZXJzL2NyeXB0by9mc2wvanIuaCB8ICA0IC0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDE3
IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
cnlwdG8vZnNsL2pyLmMgYi9kcml2ZXJzL2NyeXB0by9mc2wvanIuYw0KaW5kZXggOGY3YTgyMWVi
ZjMuLmVkZjY3OGQzNjNlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jcnlwdG8vZnNsL2pyLmMNCisr
KyBiL2RyaXZlcnMvY3J5cHRvL2ZzbC9qci5jDQpAQCAtMjE3LDEzICsyMTcsNiBAQCBzdGF0aWMg
aW50IGpyX2VucXVldWUodWludDMyX3QgKmRlc2NfYWRkciwNCg0KICAgICAgICBqci0+aGVhZCA9
IChoZWFkICsgMSkgJiAoanItPnNpemUgLSAxKTsNCg0KLSAgICAgICAvKiBJbnZhbGlkYXRlIG91
dHB1dCByaW5nICovDQotICAgICAgIHN0YXJ0ID0gKHVuc2lnbmVkIGxvbmcpanItPm91dHB1dF9y
aW5nICYNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+KEFSQ0hfRE1B
X01JTkFMSUdOIC0gMSk7DQotICAgICAgIGVuZCA9IEFMSUdOKCh1bnNpZ25lZCBsb25nKWpyLT5v
dXRwdXRfcmluZyArIGpyLT5vcF9zaXplLA0KLSAgICAgICAgICAgICAgICAgICBBUkNIX0RNQV9N
SU5BTElHTik7DQotICAgICAgIGludmFsaWRhdGVfZGNhY2hlX3JhbmdlKHN0YXJ0LCBlbmQpOw0K
LQ0KICAgICAgICBzZWNfb3V0MzIoJnJlZ3MtPmlyamEsIDEpOw0KDQogICAgICAgIHJldHVybiAw
Ow0KQEAgLTI0Myw2ICsyMzYsNyBAQCBzdGF0aWMgaW50IGpyX2RlcXVldWUoaW50IHNlY19pZHgs
IHN0cnVjdCBjYWFtX3JlZ3MgKmNhYW0pDQogI2Vsc2UNCiAgICAgICAgdWludDMyX3QgKmFkZHI7
DQogI2VuZGlmDQorICAgICAgIHVuc2lnbmVkIGxvbmcgc3RhcnQsIGVuZDsNCg0KICAgICAgICB3
aGlsZSAoc2VjX2luMzIoJnJlZ3MtPm9yc2YpICYmIENJUkNfQ05UKGpyLT5oZWFkLCBqci0+dGFp
bCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBqci0+
c2l6ZSkpIHsNCkBAIC0yNTAsNiArMjQ0LDE0IEBAIHN0YXRpYyBpbnQganJfZGVxdWV1ZShpbnQg
c2VjX2lkeCwgc3RydWN0IGNhYW1fcmVncyAqY2FhbSkNCiAgICAgICAgICAgICAgICBmb3VuZCA9
IDA7DQoNCiAgICAgICAgICAgICAgICBjYWFtX2RtYV9hZGRyX3Qgb3BfZGVzYzsNCisNCisgICAg
ICAgICAgICAgICAvKiBJbnZhbGlkYXRlIG91dHB1dCByaW5nICovDQorICAgICAgICAgICAgICAg
c3RhcnQgPSAodW5zaWduZWQgbG9uZylqci0+b3V0cHV0X3JpbmcgJg0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfihBUkNIX0RNQV9NSU5BTElHTiAtIDEp
Ow0KKyAgICAgICAgICAgICAgIGVuZCA9IEFMSUdOKCh1bnNpZ25lZCBsb25nKWpyLT5vdXRwdXRf
cmluZw0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICsganItPm9wX3Np
emUsIEFSQ0hfRE1BX01JTkFMSUdOKTsNCisgICAgICAgICAgICAgICBpbnZhbGlkYXRlX2RjYWNo
ZV9yYW5nZShzdGFydCwgZW5kKTsNCisNCiAgICAgICAgI2lmZGVmIENPTkZJR19DQUFNXzY0QklU
DQogICAgICAgICAgICAgICAgLyogUmVhZCB0aGUgNjQgYml0IERlc2NyaXB0b3IgYWRkcmVzcyBm
cm9tIE91dHB1dCBSaW5nLg0KICAgICAgICAgICAgICAgICAqIFRoZSAzMiBiaXQgaGlnbiBhbmQg
bG93IHBhcnQgb2YgdGhlIGFkZHJlc3Mgd2lsbA0KQEAgLTI4MywyOCArMjg1LDMxIEBAIHN0YXRp
YyBpbnQganJfZGVxdWV1ZShpbnQgc2VjX2lkeCwgc3RydWN0IGNhYW1fcmVncyAqY2FhbSkNCiAg
ICAgICAgICAgICAgICB9DQoNCiAgICAgICAgICAgICAgICAvKiBFcnJvciBjb25kaXRpb24gaWYg
bWF0Y2ggbm90IGZvdW5kICovDQotICAgICAgICAgICAgICAgaWYgKCFmb3VuZCkNCisgICAgICAg
ICAgICAgICBpZiAoIWZvdW5kKSB7DQorICAgICAgICAgICAgICAgICAgICAgICBpbnQgc2xvdHNf
ZnVsbCA9IHNlY19pbjMyKCZyZWdzLT5vcnNmKTsNCisNCisgICAgICAgICAgICAgICAgICAgICAg
IGpyLT50YWlsID0gKGpyLT50YWlsICsgc2xvdHNfZnVsbCkgJiAoanItPnNpemUgLSAxKTsNCisg
ICAgICAgICAgICAgICAgICAgICAgIHNlY19vdXQzMigmcmVncy0+b3Jqciwgc2xvdHNfZnVsbCk7
DQogICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLTE7DQorICAgICAgICAgICAgICAgfQ0K
DQogICAgICAgICAgICAgICAganItPmluZm9baWR4XS5vcF9kb25lID0gMTsNCiAgICAgICAgICAg
ICAgICBjYWxsYmFjayA9ICh2b2lkICopanItPmluZm9baWR4XS5jYWxsYmFjazsNCiAgICAgICAg
ICAgICAgICBhcmcgPSBqci0+aW5mb1tpZHhdLmFyZzsNCg0KICAgICAgICAgICAgICAgIC8qIFdo
ZW4gdGhlIGpvYiBvbiB0YWlsIGlkeCBnZXRzIGRvbmUsIGluY3JlbWVudA0KLSAgICAgICAgICAg
ICAgICAqIHRhaWwgdGlsbCB0aGUgcG9pbnQgd2hlcmUgam9iIGNvbXBsZXRlZCBvdXQgb2Ygb3Jl
ZHIgaGFzDQorICAgICAgICAgICAgICAgICogdGFpbCB0aWxsIHRoZSBwb2ludCB3aGVyZSBqb2Ig
Y29tcGxldGVkIG91dCBvZiBvcmRlciBoYXMNCiAgICAgICAgICAgICAgICAgKiBiZWVuIHRha2Vu
IGludG8gYWNjb3VudA0KICAgICAgICAgICAgICAgICAqLw0KICAgICAgICAgICAgICAgIGlmIChp
ZHggPT0gdGFpbCkNCiAgICAgICAgICAgICAgICAgICAgICAgIGRvIHsNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAganItPmluZm9bdGFpbF0ub3BfZG9uZSA9IDA7DQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHRhaWwgPSAodGFpbCArIDEpICYgKGpyLT5zaXplIC0gMSk7
DQogICAgICAgICAgICAgICAgICAgICAgICB9IHdoaWxlIChqci0+aW5mb1t0YWlsXS5vcF9kb25l
KTsNCg0KICAgICAgICAgICAgICAgIGpyLT50YWlsID0gdGFpbDsNCi0gICAgICAgICAgICAgICBq
ci0+cmVhZF9pZHggPSAoanItPnJlYWRfaWR4ICsgMSkgJiAoanItPnNpemUgLSAxKTsNCg0KICAg
ICAgICAgICAgICAgIHNlY19vdXQzMigmcmVncy0+b3JqciwgMSk7DQotICAgICAgICAgICAgICAg
anItPmluZm9baWR4XS5vcF9kb25lID0gMDsNCi0NCiAgICAgICAgICAgICAgICBjYWxsYmFjayhz
dGF0dXMsIGFyZyk7DQogICAgICAgIH0NCg0KQEAgLTM3OCw3ICszODMsNiBAQCBzdGF0aWMgaW50
IGpyX3N3X2NsZWFudXAodWludDhfdCBzZWNfaWR4LCBzdHJ1Y3QgY2FhbV9yZWdzICpjYWFtKQ0K
DQogICAgICAgIGpyLT5oZWFkID0gMDsNCiAgICAgICAganItPnRhaWwgPSAwOw0KLSAgICAgICBq
ci0+cmVhZF9pZHggPSAwOw0KICAgICAgICBqci0+d3JpdGVfaWR4ID0gMDsNCiAgICAgICAgbWVt
c2V0KGpyLT5pbmZvLCAwLCBzaXplb2YoanItPmluZm8pKTsNCiAgICAgICAgbWVtc2V0KGpyLT5p
bnB1dF9yaW5nLCAwLCBqci0+c2l6ZSAqIHNpemVvZihjYWFtX2RtYV9hZGRyX3QpKTsNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2NyeXB0by9mc2wvanIuaCBiL2RyaXZlcnMvY3J5cHRvL2ZzbC9qci5o
DQppbmRleCBiMTM2Y2Q4ZDA1YS4uOGQ1Y2EwM2U1MDEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Ny
eXB0by9mc2wvanIuaA0KKysrIGIvZHJpdmVycy9jcnlwdG8vZnNsL2pyLmgNCkBAIC04MywxMCAr
ODMsNiBAQCBzdHJ1Y3Qgam9icmluZyB7DQogICAgICAgICAqIGluLW9yZGVyIGpvYiBjb21wbGV0
aW9uDQogICAgICAgICAqLw0KICAgICAgICBpbnQgdGFpbDsNCi0gICAgICAgLyogUmVhZCBpbmRl
eCBvZiB0aGUgb3V0cHV0IHJpbmcuIEl0IG1heSBub3QgbWF0Y2ggd2l0aCB0YWlsIGluIGNhc2UN
Ci0gICAgICAgICogb2Ygb3V0IG9mIG9yZGVyIGNvbXBsZXRldGlvbg0KLSAgICAgICAgKi8NCi0g
ICAgICAgaW50IHJlYWRfaWR4Ow0KICAgICAgICAvKiBXcml0ZSBpbmRleCB0byBpbnB1dCByaW5n
LiBXb3VsZCBiZSBhbHdheXMgZXF1YWwgdG8gaGVhZCAqLw0KICAgICAgICBpbnQgd3JpdGVfaWR4
Ow0KICAgICAgICAvKiBTaXplIG9mIHRoZSByaW5ncy4gKi8NCi0tDQoyLjM0LjENCi0tLQ0KVGhp
cyBjb21tdW5pY2F0aW9uIGNvbnRhaW5zIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbi4gSWYgeW91
IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBwbGVhc2UgcmV0dXJuIHRoaXMgZW1haWwg
dG8gdGhlIHNlbmRlciBhbmQgZGVsZXRlIGl0IGZyb20geW91ciByZWNvcmRzLg0KDQpEaWVzZSBO
YWNocmljaHQgZW50aGFlbHQgdmVydHJhdWxpY2hlIEluZm9ybWF0aW9uZW4uIFNvbGx0ZW4gU2ll
IG5pY2h0IGRlciBiZWFic2ljaHRpZ3RlIEVtcGZhZW5nZXIgZGllc2VyIEUtbWFpbCBzZWluLCBz
ZW5kZW4gU2llIGJpdHRlIGRpZXNlIGFuIGRlbiBBYnNlbmRlciB6dXJ1ZWNrIHVuZCBsb2VzY2hl
biBTaWUgZGllIEUtbWFpbCBhdXMgSWhyZW0gU3lzdGVtLg0K
