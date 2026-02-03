Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D013E8784C
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 16:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9999683BC8;
	Tue,  3 Feb 2026 17:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JwH0BP1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 630FC83BDD; Tue,  3 Feb 2026 17:57:17 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C795839DF
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 17:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YE9cBkDh2e+0SUsuPl3tBwgoSYqoHOOBX8KQhVfx1Bq9i83akp8rUAOG597okOiCaX2UrbgA254LUvSuhjoaq6Abvo21L4ZfQI/GMPeYLUbfk13u2vPJGH7C5MQB62NKu5F54JAL/J3jGJIwbHHXXbFkkhfZKZ2IeWOL8FzMqcJHeLym+z+9WG4+hrj/DE8HX/KYTc6i7iWix4u/P5gk2AjhzGaa8tBwUovhgiCDuPN3pEFjChO9h76Q2u02vvGdK+GohQDpyP9AuF9LMterLmzu59d3F1J/GNuh9rPoQYrjCNMnzNfm5NtijZuAjoc0XyArKm4aJ6D0Ucz9kz9QXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9mlvtyj3hWzegh+ssMuijffOCgBWT7dBfFQycik1vY=;
 b=zPR9nQEG5Yiih5Xez6M/MSnBS/59pqe2t7fo64mICYDxRkt5w5TGc0lUaHtj7jsSIE6+RJx99HeiIpWSixh19Fbhtabj665H3Pa1wphjlYhfrJd+MLXn8ZblL488qWqxIaQ49KRxTjCm9pUSGVX/BzOpPJktNNC+tIX0Am9BphVkfGek6lj7/SG5Re+sGLVaJxW6JJbhZp6u54XinfWFNjvazFaB4SGncEBrlS7W5V1ixVhHKdP3ZSSdMuUB5pY5WhT7VM3BfdsvB81LOxv3xEHo4a7FLBiCgUhESdTt22+Rh7bG6AeSWK1PGlKrSjjmIzo2dWz2i9pLycbU90Oxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9mlvtyj3hWzegh+ssMuijffOCgBWT7dBfFQycik1vY=;
 b=JwH0BP1UUKpug+Ce9+jeJb48W2W+LkcvGO4wBWZLUKtkY2rtboVW8viP1b2SxTdmlCobefu+dKesCToSP1mXyJXtssh/r0uGSi+zD/y/aw18tYg9Cu6OyqO7F7RQUvH9scWq8D5LcR7hnNDUnUq+8MyyulV4XAwrS5B4V2R+N2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI1PR04MB9881.eurprd04.prod.outlook.com (2603:10a6:800:1e1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 16:57:10 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 16:57:10 +0000
Message-ID: <c3d83865-c0e4-4478-90b5-0e291ad4e67c@cherry.de>
Date: Tue, 3 Feb 2026 17:57:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] gpio: Introduce gpio-delay driver and enable it on
 Kria
To: Marek Vasut <marek.vasut@mailbox.org>, Michal Simek
 <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Anshul Dalal <anshuld@ti.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Eoin Dickson <eoin.dickson@microchip.com>, Fabio Estevam
 <festevam@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nithish Kumar Naroju <nithishkumar.naroju@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Rohit Visavalia
 <rohit.visavalia@amd.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Tom Rini
 <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
References: <cover.1770105146.git.michal.simek@amd.com>
 <0097d26f-9e6a-4412-bd74-8c3a3bf19fa6@mailbox.org>
 <be5256e4-b99c-490c-9217-7671c53914ee@amd.com>
 <5f9895bd-4786-40b0-988e-e0b843c43fd0@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5f9895bd-4786-40b0-988e-e0b843c43fd0@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::14) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI1PR04MB9881:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ae6433-3370-4fe9-e413-08de6345455e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|10070799003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dy9MaHpHcEEwVnRuVkJFK291SzdHdWtrY1BIS05sR1pZc09SamVkVVQzR1Ey?=
 =?utf-8?B?Tm9XSEZqbjlJMjBLUnFCYkN6RVZ0SzJSbjkzWmNxOThodDUwMzB6aElCMDJo?=
 =?utf-8?B?ZE1EdXY1RE91RkJJdXc3NkxtNVhURXMxMzhrTXhFVmlXbENPWUkvM1U4WXY3?=
 =?utf-8?B?U2EvWG5CYWxTVEdEc2c5VGdoeHAwRi9TOXVKc3dvSUVqaUQ2elViZTcwOXNU?=
 =?utf-8?B?ODhSWlBUT1ZDRXR6a1k4V3N2ZlNOaXFNVnEraGorT2h6ME1iV2ZaaDdIOG1F?=
 =?utf-8?B?KzEyZDVDS3crNGNiWXRtL1BUbVJKcGxNSzJDZy9Ib2kyTUJrVjdxRE51UHNO?=
 =?utf-8?B?elltQlVHcXFUREVtR1ZOa2ovOE5PQUZsN01SWUpnSGdiYnV5WFh2bXp6NHMy?=
 =?utf-8?B?a05QUFRoVURyaVZZZlBEVUZZZndOcVF2NUU0Zis3Y2xjTnIvZEF5U0xIVW55?=
 =?utf-8?B?c1VmUGtmeWRNYmZ1WVR6WENpUnZaSk1YNEFLbXI1QkErMC9tejAyMWZEUDVh?=
 =?utf-8?B?aDBFQnFiZmN2eU1tV2hFTmRjSGpkaE9SemRQS3pieGM1Zkw1R3YyV0RTenF4?=
 =?utf-8?B?azdaR2xkMnhjSm1QTTR4ZVpCWmFLRHpWYlFUN1hVMXZOK0tFT1hBZ2pmNVZD?=
 =?utf-8?B?TFRheXA1WTkxRWM0NTJjMForODRxenZzWWdkbGxJWFB0UkIwcWQ5R0NBaFFF?=
 =?utf-8?B?ZmVYTDhzUGpCUnc1RjViNVhwbVFqVTdpMmc4UG5SNlFBRmM1MHJCRHFMVmt0?=
 =?utf-8?B?QVQzMUEyWFArZjBoNkRBK1RUaHpNZWxlOWlKUCtQU3VnbnRIbHlYeWVZeGF3?=
 =?utf-8?B?Qi90ZHF3eEM1KzdadlVmaVBpalZUaGRnOHQ5V24ydTNmaGtzWUZicG14eEFM?=
 =?utf-8?B?b1VjcFVkeTJoU05hL3dCS05ZdnVmUzJKVnArT0VDdXR3dU02TS9pZUI2bERa?=
 =?utf-8?B?WElSTDZrZkhoOG4rVE9WQmhLYWhRZk1LVGlKL1VQZm52SGlvazhxbER4UkRG?=
 =?utf-8?B?V3ZwSDBRb0xOdU9GSUN5TlpLeC9PUEEyYWNzQUJwdWZWNlVYV0UxdXlsNzR4?=
 =?utf-8?B?UndxSFRteWhaZmxzMzNocCtOZGlCc2V0eDIyZW9xY1VwT2tadlhORHIrUHJI?=
 =?utf-8?B?VTh2S0NoTlBhZ01nY0tiV0Q1Nzk3WU5udnFVeW94dFRVb0t0cm93VUp0Ykty?=
 =?utf-8?B?enU3d0FXMm9IZ2tsZUxjdWJMWEhIRnYyaDBUUVBVY09ZdUExc1JHbktOU0ov?=
 =?utf-8?B?U2RQZGxNNXI2bkVONkl6ZW1DRFIwZ0JNaW1rcDQ0NGFMeWdVbUlodE53cjlJ?=
 =?utf-8?B?UU5sMzAxQnVURTIxL2g5U1lPd3U5QkkzWHo2bkdYeEdwSVI0cHY0TFQyMGl3?=
 =?utf-8?B?TzdENkxLam5Bbm5nY0FRdlQvQVp3NVpKOG5yWC9nQW90MXF4SE1ZUUpER0xa?=
 =?utf-8?B?bWZWS2NDdExOcHNoTkU4ZFlYMnYwYUdKVit5RkNUNjNnM2VubnhsTkl5RTQ4?=
 =?utf-8?B?bFNzSGlBeGsrQ2JiQmxKNEdadi9KRWlUZ09HWFowQnkzMnl3czNuNnFNM2Fh?=
 =?utf-8?B?VjRQRDhXajNsZy84Ymk3OFlYcTh4RzBjY3NPaEdiOXROOXlSbnJ6UHBNYnF5?=
 =?utf-8?B?NUl4RVN5MzA2eUQ5ZVBBajdXT1lHaXZNWEp6V08vVHpITWxjQTNjK3N6YWw1?=
 =?utf-8?B?YXVvZzdiZEd1Y2M1NVhndDdwT00rQ0pIbS8yRUxiKzdUMGQ0L0hEd20wS1hi?=
 =?utf-8?B?cTJnTDE2NGMrV2Q4a3F1T2c3TXcvblJ3OW5LRmRRYjZsMnlTTERWWnBNK1Ay?=
 =?utf-8?B?WmdFY1hRQ294citqY25lVnBHZ05BcG8xQnhES0JmM1RkYTE4d2htK2gxNkNI?=
 =?utf-8?B?YzlmbGNMUmhYaEZVTUJ3VlJDNE9oNkdsRmVINkJ4NEwxZ01wVXE2QThnVlE1?=
 =?utf-8?B?UWJlUjRZOC9BdlR5ejRDU2xsTzQ3YkdvZVB5ci9rUzRERGxnN1E4aUl1U0dv?=
 =?utf-8?B?aDFKTk50eXZpUkZJamYrN1dBL2RsYytWQk9raFhuYVU0SWNOT1lIVDJXT1hX?=
 =?utf-8?B?aXdzd3NObEFOY2ZjY1lnMGY5VWZuLzZkazczVmNnMWtVa3F3cWZoa1ByVUlj?=
 =?utf-8?Q?SEQA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aktzQnMvS050cFRWLzdzaFhmYUdJcStTb1dNYVVMVEtzU1k5UTI0UUxqN0Vq?=
 =?utf-8?B?SXJ6bFNHOWsvNkZoTjgrVU9waDY5VmRwS0N0N2hYUVlpaDBYTWY4NlBWZ2NX?=
 =?utf-8?B?a1N2RUZHL1VpV1FXNzhNNnVGK0RCbGRVODlIQWFBYkRZRTdCbnNnaFQrcUNv?=
 =?utf-8?B?VHZ3YmgzZm02WStva0h0cGYweDdqekVyL1JTSTdzZ0tYcEJWUEpvMGQ1amhs?=
 =?utf-8?B?MS9vQlZsRksxR2FUNVZvYXFXMzZlcnN1MUNVcElaZjFhTWhVd1dDYXlFMXlt?=
 =?utf-8?B?M2pXMnRyRTBXQUtoWDZZQTFPY3Q4NnZna05CWlJKTVk1R1BFZXNNQ1pjQzFh?=
 =?utf-8?B?M1RieWdESkpjUGdtK2JVNlpzWVUxajYzalBqT0dWUU45MEQ2QndHVXM2eXoy?=
 =?utf-8?B?Smo3dnl3SytreW5QSnJJQ0lCSy9PU0VIdDZhZzloL2J5a1VLSjNVUnBnN1dG?=
 =?utf-8?B?bkw5YllWMDFVZ3BaTWZYVTk0dW5vaFI5NnFaZVBKa3cvbDBOeEZ3Zk5xSW9m?=
 =?utf-8?B?cVlMdE5RWnV4VnhGWkdTUVM0emFYTXZuUzdELzNiemZHL2E3TFR1YlMrZGFh?=
 =?utf-8?B?QjduckFJNUw0d3YrRGxkNE9GSFl4cmpWVWYrdXRQR1dtWVRMT3dnUFpwRGJl?=
 =?utf-8?B?UHBHQUtGYjd5aWRuR1BaU3A5VnJLUi9TWDBwdnF3cVlQSkFkWXdueTlzZEFa?=
 =?utf-8?B?VFo0cUw2TDhkck9ha0dLSmdLSHlmVWVGUzNwMUxIb2JtbzRKM1ZIRDVLaXVI?=
 =?utf-8?B?VmxZWlBVQ1VOdWFhZEU5OTBoT3JPNmRMTUN3OXBCWkNERjZwTEN6SGZ1Y2hY?=
 =?utf-8?B?L3FNcldUTVVIVWdlMkY3TERtQWFqazZCeEdQUVlMTEU2a0FIazR2RHcyT3Rq?=
 =?utf-8?B?bjd2cVFGTzlEaklGUTBZdkhUYllkNVZzcTJrdm9nL0c2cTJBTVVBdVRPYVpS?=
 =?utf-8?B?M2lxS1FDM2dVeUZpTGJUNHliSWs1d2tLTzR3MFdwdnpycnkvYzF5dkFxU2Q3?=
 =?utf-8?B?SlJtWS9Md1pJcVhZRXloOE5xRzlNK09SMmJJVktaa0Z4VnVpbzRkR1R0OTdo?=
 =?utf-8?B?MUtWeXhjZG9zV080RUkwRWhsdnBoT0ozUmxzYnMrMDBFV09OMUxtOGFNSXFx?=
 =?utf-8?B?Q2lQUVpRcDI5eG5ielRRZFdUdndielhYQ1hGVlYrTFpjUXh3R21ObDYwYllQ?=
 =?utf-8?B?ejVDNWMxNUFmenR3c0NzdlhvLy9YTTl0U0FJK2dObzF1QjNFWXl1TlBZdWg0?=
 =?utf-8?B?aTBGK3Nheis2QmV6M3VGYTd3WEMyWTlKVFRiQmRQdElRNVBPeW01UHdBcER5?=
 =?utf-8?B?ZGJsU2RBcnZ4LzFHTlU3Z09PRXdvS1czNThDUGtmdkJLY3RKTUR4c3RudXFw?=
 =?utf-8?B?VUptZlNucVlNR0pKOVdHbXdOMHcrVnVic00vVTdtWW5kbXl0SU9ZUDl1K0k0?=
 =?utf-8?B?aVRybURLUUMvSmNKMFR4ME03cWtEd2dVZ1graUlLaWxDNUdXejZWTGEwc3Ex?=
 =?utf-8?B?NEE2NE4xcDRWdFpUQzA2UEI3NmVRUW9XdlpHWW9DWWlNNWlZUXk0eDZrZ1My?=
 =?utf-8?B?bjJLa1ZPdzJSS2ZwZlRxY0NFSUdWWUFYdHREU0EwSkdnNFpmWDIwRlJBUHZ6?=
 =?utf-8?B?R25JSm5IRys3UW5TQnltZFlYdGh4ZU5POXVHcDJIOWxxeEpFVUU4RkhjamNX?=
 =?utf-8?B?eUdQNXVKMkx3OEZUZEhyb3NQdlliOFVRWDZsTURUcC9aSjIxR0RRd1lhekJ5?=
 =?utf-8?B?UzBKNzZwdEo1c0NQTW9CZllvNitDci9aOVJWUmpPMzNONTN5Uks4anRxNDNH?=
 =?utf-8?B?RnNSNmV1VUFtN2hmRElRZk5WTERxTlg4Mk1XaFR4TDJkWm1MWGgvczV4SW0w?=
 =?utf-8?B?eTZmWFFFNGk1NmhtOHQxUXNldW9nc0dFVHF1d2crWXRsOGJNRVNaZU1FYW9w?=
 =?utf-8?B?b0lGa3JLMmdVTEVKSFU4Ky9SUm1ybFFXQUZTMzJIOFNncXl3UG9LM3FpZDBH?=
 =?utf-8?B?Q0lMV0xmQjlJZ3dvVm5JUVZqdlFqbDhtKytxZzE1RTY1U0x6U21KdHUrN3dJ?=
 =?utf-8?B?L3J2TTI5YkJjSXhhSnJRbVg3Smg3YTVpM0Fpb01DK25HT01ucTlmM3pLN3JR?=
 =?utf-8?B?SStPbHdEbmZKSVVsU0ZZaWZuVkxudUozWTlrZlZHTGJxaFloODd0TlF3dDM0?=
 =?utf-8?B?Y1pBVmZxd3ExZEhIRXRjTVVDaG9FNnVENFVJQnVvMWplZXFkMFFOZGJPUStN?=
 =?utf-8?B?akRoUjdXM3RIaDBLNkh5RkVrSmd2ZmRmRy9PeFlIaFlKSW9rSUpjUGJFNUdk?=
 =?utf-8?B?SE52K21Nank0WFJURFdsTGFNOVZIelVqQmx6eWRqVndXbFZhYkRUU3l0WEJO?=
 =?utf-8?Q?6995Mg9X5pRQotVUPE/5n6OV/U4l6kuO5C4xU?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ae6433-3370-4fe9-e413-08de6345455e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:57:10.1743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6HANzVkY8aJDIkwxKYHwPUFl4s1KBQyKdz/OPdpmxZVuzLwhtA9Ea0azoUUinZy/dGCRHbNuwNzIrFuvopdzYNnbfE4FmDfVQoy8yUMBpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9881
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

On 2/3/26 5:38 PM, Marek Vasut wrote:
> On 2/3/26 4:32 PM, Michal Simek wrote:
>>
>>
>> On 2/3/26 12:39, Marek Vasut wrote:
>>> On 2/3/26 8:52 AM, Michal Simek wrote:
>>>> Hi,
>>>>
>>>> we need to wait more time for getting USB hub out of reset to be 
>>>> able to do
>>>> initialiation over i2c that's why use gpio-delay driver instead of 
>>>> changing
>>>> waiting time in usb hub driver. Waiting time depends on gpio wiring 
>>>> on the
>>>> board which is in some of our case going via SLG programmable device.
>>> Can you not use some regulator or make the reset assert/deassert time 
>>> configurable via DT property ?
>>
>> Sorry not following. delay is configurable via DT now - the patch 3/3 
>> for example.
> 
> 3/3 never arrived in my mailbox, I think I was CCed only on 0 and 2 .
> 
>> This avoid a need to change usb5744 driver to wait longer time which 
>> is what we discussed in past.
> If the delay is configurable via DT, why would the driver have to be 
> changed ?

Delay is configurable via DT for the GPIO delay device. The delay is NOT 
configurable via DT for the USB onboard hub device. Because of the 
latter, the former is added as GPIO controller for adding delay to the 
latter driver's reset line.
