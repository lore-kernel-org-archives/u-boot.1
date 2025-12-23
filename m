Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49154E6F093
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 13:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11E0B83FD9;
	Tue, 23 Dec 2025 14:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="EDPxF3jK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC2383FFA; Tue, 23 Dec 2025 14:58:57 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F347F83FD4
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 14:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9sT0zjtSOd0KJj8EKpalFBwQcW0zERkU2P1TLAN5p0T/i5hM0sy2k3AJR6cYVbZ52FAbGHJmtgbUM+QRjqtNgtdm0MX2myx/OveSaj+XP3eow+0cXz4e2dclC68bZ8IlcFbVwb5WNmz5POfQfgYnM1hM9af+hjxqQXI2yY5fXofj0V2nZIlPyIvzfuT6J3Uusb/exLO89f/FZgYTk6ToXvFKi3aOxKDLuoKzkGRfP6xOwd/xSlz0G7a/uSi4sD9HBxuhzFesIJ/qIf6tAKHB1WdLwP9S7yTcympnyGmRtVo6ujdhwmHkWW8k62kC2YHX/QBx4C+AFPDsVb5iQSyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9sORiZ7F3ppNCKHOu8sXCt1Xwv6x9Dq7TLYeD52mNQ=;
 b=YtSTE2TOw8gTsrKmsb1gkPPHljbie8FcHsPAz4h58znsMbdAkLobkfFJYMp0yRDs+ZBpEggORU7cgVZuhY+N+3Lu2ECn7UpUZDO9Rd0MMsz2Y8NSqq7P9Ei6Lg2DTZbnV6N2/xQd7ul84KnpdX58glcO1yl4aKMysnqipmN8a3C1nCnIxF0ZyZKeEj081d25lX4nPdEwOifWgWUPZtM6vLi1FDfvI1p/Rs80+MdGo38FCwJ4nEqbZd+vNMXHfCgBCqG0ufKKNMrqPmI1vkIcxiFctrJ2xuCfYKnYUvY6KCjwHiOVu0dB9zkbh5f7ELlyzm8uHSvGCIRtlr3Gq6MOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9sORiZ7F3ppNCKHOu8sXCt1Xwv6x9Dq7TLYeD52mNQ=;
 b=EDPxF3jKpRQDI9a1Qe1inQ/2z0uPg/YkGEStlr6hbg4YlHHaO14iEZRHRJo6HLMT6CEQINQGWtaftAgBsVQSH9jp4AhjzooGZBHz7HdbBSaIatcCO8vmlKfxjFJpUaK4vsntRm7NIrPLeK0NbWN3NYWYc9/qJ1iPowbvbNmBCbRVMPO9Pa4A0Kvai+k4jMdBgGKfUve332kT5MJ7JglB4DDsu4uXiLEzA1Jj4OYMoVjX1o5fC4/n7Q/3ecMsITFJcTzmQ4v/teebQuSoCMeSiPzOmVnCJ0xMgNaliHMmZlQ+J/Z1KC72/H+oT3dUn3CdrqlX66waSMZ/CI0hy1/IaA==
Received: from AS4P250CA0006.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::8)
 by VI1PR05MB7134.eurprd05.prod.outlook.com (2603:10a6:800:178::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Tue, 23 Dec
 2025 13:58:49 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::4) by AS4P250CA0006.outlook.office365.com
 (2603:10a6:20b:5df::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.10 via Frontend Transport; Tue,
 23 Dec 2025 13:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 13:58:48 +0000
Received: from DB3PR08CU002.outbound.protection.outlook.com (40.93.64.83) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 23 Dec 2025 13:58:48 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by AS2PR05MB9983.eurprd05.prod.outlook.com
 (2603:10a6:20b:5fa::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 13:58:46 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::8532:a1ae:4fc1:3b89]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::8532:a1ae:4fc1:3b89%3]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 13:58:46 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: U-Boot Mailing List <u-boot@lists.denx.de>
CC: David Zang <davidzangcs@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mathieu Othacehe <othacehe@gnu.org>, Peng Fan <peng.fan@nxp.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] omap_hsmmc: Support CONFIG_MMC_BROKEN_CD
Thread-Topic: [PATCH] omap_hsmmc: Support CONFIG_MMC_BROKEN_CD
Thread-Index: Adx0FCd9b/X98XjTSguLZ16auIS7yA==
Date: Tue, 23 Dec 2025 13:58:45 +0000
Message-ID: <GV2PR05MB1194100C3AFD5CDBCA957E91083B5A@GV2PR05MB11941.eurprd05.prod.outlook.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|AS2PR05MB9983:EE_|AM4PEPF00027A60:EE_|VI1PR05MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: e3fee74e-c97c-4ba0-7580-08de422b65aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?cUlWUDBRcWQxRzQ4bU1KSm9CL0hzdVJDbEYrZGpnZEZ5V2M1UFNpVk44dlZX?=
 =?utf-8?B?TDJhaXR3ZmpyUTdKbmFXeG1VVWd4S1pzV2sxbDNCaDFuTUNiQ1c0eWNVN25t?=
 =?utf-8?B?WGJSYUdBUUxDdmI2R25WVTFsbEhKRm5PODA1VEVvV3lEQkRFSXlkVzZhczBs?=
 =?utf-8?B?eWVGUDFId3RGNk1aQmd4UUdPeTl2Q0xPcWU2emk0ZXIrL3J1eTJRRXhnUGpG?=
 =?utf-8?B?VjJ3VitKSGpoUzZ0WmJuRVhldEE1dTBOSXE1M2NVZGx1cGIxNjNxZGVrTFgw?=
 =?utf-8?B?b0lNNkl2RkVFc2JvZldNak9WL2hnZkdlcFJDN21EN2MyaUpPZWQ1M2ZZbTV3?=
 =?utf-8?B?WWJic3V6YmlyaDdFbVlOUEwyUlI3Zy8rVktSMkpiRXBIMjZ2Q3BFUDN4Z1BL?=
 =?utf-8?B?bVM3SmtjTElrc0RBN2RXRUkvUitsVzJDdTR2WVNUOFdhNCswN1VpcHVDZkpN?=
 =?utf-8?B?ZytNWmIrZzExb1ZZSmNOMFZNc2QwT2QveFFFWHRreGY4ZmNXdCtEQWNyMjV5?=
 =?utf-8?B?bDNTMDJld29vcU5rdzhLd2hPT3FTZVgvRnhrUFF0SGp0YUtyUGxLNG1JbXMw?=
 =?utf-8?B?QlhsWWxORFlBM2NHZU5MdVZVa1IzUDZpSkhSZlR4d1VPa0hON2J0cUloWkZ2?=
 =?utf-8?B?azNMQ2pLN2RBY1pQbDRiWDNEUU9ncXlTTHlMb2tGdStNcG56d2dHVHQ5UFR1?=
 =?utf-8?B?SXltbW1Dd1hjNlJweGN4UEI2S0VpUEs1WDV3SzJnOUdSRldMN2FZbXhlUGoy?=
 =?utf-8?B?QWI5bHozc3RmUTd5UXI0ZXJ1N3JFc044RERpaFpVbjJvdit3dkNZd0p0Nkcy?=
 =?utf-8?B?RmdLZzdhZDdXRUxpbVlXbituQlVIcmNiTWs4VStnYlpJb2Z4dXZRT2xVZUZX?=
 =?utf-8?B?Sk00Vk9kTlYyb0N3a3BlTTEwQnJQbzVLSGM3c3RlOEZnUmpzM2gzZVZOYXpE?=
 =?utf-8?B?R1RpQ3U0ZS9UZUF3UVo0cFo1VjZNM1lucVE3UUVuU3EyL1Yzb0ZaWmpZYk9D?=
 =?utf-8?B?dURmNEJzcXBmbHIrQVdEWWNydm9tc21BNzh5QWdlL1lNclUvK2g0ZlI5MDVW?=
 =?utf-8?B?TWNFeWw5elh5aStrRE5JUFJrT2x2UDVWOU95YzJQT0F4anFwajFpQ1YyZmpx?=
 =?utf-8?B?bmx0T2c3MGxBQkhUcm96Qkl4a2I3U0tMRjMxWWF6Y01XVXV0eHBlM3FydWpM?=
 =?utf-8?B?S1BQUUwyQldUdHNEU0drQkFCVlpINW9ROFlmc3Z3ZmdkKytOREdKNXp3ZW1V?=
 =?utf-8?B?di9Rd3FSZExXaFNkZ2sxWHFrYlk3NXQrdXN5aUlWSUZSTEJOek15eG5FbDRw?=
 =?utf-8?B?bUw3ZjdQRWkvU3ZUUDJxdUdPaU9XSDdqNm9WMWhDbU1pZlFZZTk0dzZ6Wng4?=
 =?utf-8?B?UXhFeElyZzg3OFEyTEYxblNsYUZia0UwMGxnRWU2MENENnpxVkhkOWFobXRW?=
 =?utf-8?B?RGFrMFQ5ZEhJTzhCSU5CdVpYbklrRnZuZHlWWE9YUThVK0p6YjNkenFaWXFX?=
 =?utf-8?B?bDZhSytkcVBRSWNMS09HTHBYRVlrd1Z6cVBhMGdoUGNWcSswTWthNXgzVXhB?=
 =?utf-8?B?d0RuaGd1SmdQZDE4aTBHYlRtTUJmM1VBN2FFVDk1WDM2SG1UaFl1cFpaMUZk?=
 =?utf-8?B?M1BrMWVjeEY2V3c1VGpub3N3S0xoOFJ4QVB2NkNGazcrUG9kd0RuZjFjOFda?=
 =?utf-8?B?bFJMS0g0Z2JXY0w0amdUeXVyeUNOV3FjNjcxY3Qvb1NtcFBjMFh5bWVIdGI0?=
 =?utf-8?B?ckVWTDNnWStmYVA4TGo1N0c3bC9aRU0yZ2JkSlVxVWFOS3I1dWVma0JCcGxt?=
 =?utf-8?B?ckUvdnJBdk95UFVWaWdWMCsyZEZSOE4zcVduOUg3dGRFd1BuajZsM0R4VFdm?=
 =?utf-8?B?ZC9kY2NTMmFNL0FId2t2VHRzQXV1NlAvTGhoVERYcjd6RkdFcFU4Z3g1aXBX?=
 =?utf-8?B?ejFsUWxiUHozMXBiSWkxVDBGWlVLOW9HZE5QTEU3Z29zcnpDaFI0eFlhZDA3?=
 =?utf-8?B?RktacTdEdmJyMnU3V1hkQlRvbHdrTGVzSFZJS3QxUEVGbG9rNVJKYnlWTkNL?=
 =?utf-8?Q?aU1SPC?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR05MB9983
X-CodeTwo-MessageID: 979d2cf3-a915-41dc-b443-9b8291ffb1b7.20251223135848@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0c650c74-feb2-4b08-7945-08de422b63eb
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700013|82310400026|35042699022|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXVKWVNXbFI1N1phRGxaRm1uN2JGNjRaOUU0WFdlS2haL1NoRGxET3VyS0k2?=
 =?utf-8?B?ZFFjWVVkb2RGYm5Vb01hQmVINVlHb3o4NWx2d0s1QVZyWkxNKzJ0UmpRM1Y0?=
 =?utf-8?B?UVE1SE01YnYwZkppWW9Mdmp2ZkdZWHJDdmI4VXdvUFd1RlFJT0drWUxJSktO?=
 =?utf-8?B?YnRwU0VzRzdReEptTjFHTXB0UkZ5LzRFTEthUmtLeEJFdktYblhHTVAzd2lz?=
 =?utf-8?B?d1JsOUJBNm4wQmNINEtYSGRKQUcyMERUV1Z0aG5janRqZzd2eFp4eVJVakpS?=
 =?utf-8?B?ZDBDMkJDaVp1Zm0zTEdzek5LZC9mUmFDUDZBVlBrSGZTS3RZNWFyUEErVlNy?=
 =?utf-8?B?NjQvL0JDNXVBblpUbHpTQWc4MmtUNktoQXZMS0FteFNsUjNTR2hHK3RLMnlp?=
 =?utf-8?B?aGlhZW5NMVVDbnJHcCs1bW5TMDBhOW1zV2lzcmt0enlwSGtPbEt5OWpYdzNY?=
 =?utf-8?B?WGdlelBydENnQTYrNG5wZG5pYmk2bjN3YTdIVjVZQVRlcGhNWnduMmN2eENn?=
 =?utf-8?B?a3FWY2RCZk1QRnNreE5FbEZ1eHc0TWFONVR1UXZZdmtrVDNBVU9rZjBzV1d4?=
 =?utf-8?B?U0U1c0hSV3c4Ti9GdmlUNy9qK0R0V2tpQXN0SDdHUFlXQjVmeWpTMWdyUzR3?=
 =?utf-8?B?MmRDVWl6d1dwUmlGblg1MEs4U1dvNWkrb3hCbmhGS1gvME9GUTk5TlhtY0g3?=
 =?utf-8?B?S2dRUTZEWmVudVJxaGZhdmFWdEZhVC8xZHFTc1d4d3RRdnFtSWdXcGloSzZ0?=
 =?utf-8?B?N0o0K21VWm02WUk2NDYwaDU3UGhhbWxZVzRsV2dQRXArM0IwbjNXVmVyM1Z3?=
 =?utf-8?B?ZEVlYllHU3A4VkdwaUJFYkhWeFhHNGwvWjI5YURvMzdMcWJGS0JIS2xCdXRH?=
 =?utf-8?B?NFVxQks5eEdzRnJvNWFsRmhWSG5tbE1Hc3lKWE5mcHk5WXM1RkhyWGN6Q2hy?=
 =?utf-8?B?cEZNeEFnOEZOVGplcDJhTlJJNGpNcS9UMWNnR0VRZ21CSWdEZ3VTS0hjcmRV?=
 =?utf-8?B?N0g1SXNSRUJXZ1BCeW1iZ3NtYmRxK3VGb2xwVlp0TVZKZHl3T3MvcStaemtQ?=
 =?utf-8?B?cXF4U1JOVnZwTHBTVUVsdmVuYXdSMjdaUW5NM2dscEN1NzZqZ1hlR3hwd3pH?=
 =?utf-8?B?dWh3RkJjekdaZGNFdnlEMmRjS0R0RnlsVGlkOHVTR1U1UEM3dFVqd3JRM09V?=
 =?utf-8?B?Vi9Ld3BCR1c1TGM1dXYwZTdTeW5SQ1F0NjIrMVpGQkRTUkJzK2VBMlRwaGtC?=
 =?utf-8?B?SUlQKzZzRS9mRjhtZEFFL3dnNm9YV2ZWMUEzL2FKNk80cXJMWG1RcXh2dEpv?=
 =?utf-8?B?ckUxWURFTFozUzhrN24zc1JyRVZhcHVKSndHVnlObGR4TGJaTnhCbER5akhx?=
 =?utf-8?B?ZzZtdzUrMUp1UTQ0cmIxWTNQSlFZREFYcXVIWG1OTzRRS05lWVAzVEtXRWJG?=
 =?utf-8?B?ZHN1b1IyT2xCVVIwWitrR1djWXZ1TFFReGVEQ0I4OUM1cTVZUThYVE5ha040?=
 =?utf-8?B?b3FnYWlEVDFuZGhETGE5SDJUb0F6VnExYitnSVZxSlJlMTh4bUVGZ2wvdXVk?=
 =?utf-8?B?TXI0MCtjam5tZU9MeXMyYUhSU0pRTmlYNHJQbEpBYkMraUNHNzdxTVhud0s4?=
 =?utf-8?B?aGdDNGlucnF6OVFha2pVY0VZcWZOaG54OXNKVTZpaFlzM2J0NUhyZVg0dENN?=
 =?utf-8?B?RGhLdk9GS1J3SEgrcHJvUzdKTkh1ZStnb1JpbktBZmluWDBiL1lxa2h3VDJR?=
 =?utf-8?B?dld5N08rUjdlNlJoT0tyampUVmZ4SXdMYVJGMDJTMUMyZnJteURFSjBibStn?=
 =?utf-8?B?V3oyL00wYkx5di9YNlhXOW5aVEVHYlE2M2hWRGxlZW5uMG0xSzQxdUxVSmJj?=
 =?utf-8?B?Z0ZnNzNva1BSUVFna3ZCRDVFTjhGeWZxVjBXUVJlOEJBQVFvNzAyQURFaVo3?=
 =?utf-8?B?L2ZuZ3BJZ3Q5K2RRdXNPZUhUQ0M2K3c1VHlOYXpVUG9seU8zNHlESDR1cVBS?=
 =?utf-8?B?dGRBSXZ5RmJNQ1lKaWhycHlTZHY4UDNxWEFJdGJkOEVqbURaZWFUQ01KYnhD?=
 =?utf-8?B?M25yWFBsYWFXZ1VYNHFJUElKNnRqQ2x0S0dLcHAzdVQzdjdDYjc2c3F0bUta?=
 =?utf-8?Q?uprg=3D?=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700013)(82310400026)(35042699022)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 13:58:48.9661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fee74e-c97c-4ba0-7580-08de422b65aa
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB7134
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

QWRkIHN1cHBvcnQgZm9yIHRoZSBDT05GSUdfTU1DX0JST0tFTl9DRCBvcHRpb24gdG8gb21hcF9o
c21tYy5jDQpUaGlzIHNob3VsZCBiZSBzZWxlY3RlZCB3aGVuIHRoZXJlIGlzIG5vIENhcmQgRGV0
ZWN0IGNvbm5lY3Rpb24gb24gYSBib2FyZC4NCg0KU2lnbmVkLW9mZi1ieTogTWFhcnRlbiBCcm9j
ayA8bWFhcnRlbi5icm9ja0BzdHRscy5ubD4NCi0tLQ0KDQogZHJpdmVycy9tbWMvb21hcF9oc21t
Yy5jIHwgNyArKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL29tYXBfaHNtbWMuYyBiL2RyaXZl
cnMvbW1jL29tYXBfaHNtbWMuYw0KaW5kZXggYWU3NDIwODA2NDMuLjljNzhkNWE2NTQ0IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9tbWMvb21hcF9oc21tYy5jDQorKysgYi9kcml2ZXJzL21tYy9vbWFw
X2hzbW1jLmMNCkBAIC01OSw4ICs1OSw5IEBADQogREVDTEFSRV9HTE9CQUxfREFUQV9QVFI7DQoN
CiAvKiBzaW1wbGlmeSBkZWZpbmVzIHRvIE9NQVBfSFNNTUNfVVNFX0dQSU8gKi8NCi0jaWYgKGRl
ZmluZWQoQ09ORklHX09NQVBfR1BJTykgJiYgIWRlZmluZWQoQ09ORklHX1hQTF9CVUlMRCkpIHx8
IFwNCi0gICAgICAgKGRlZmluZWQoQ09ORklHX1hQTF9CVUlMRCkgJiYgZGVmaW5lZChDT05GSUdf
U1BMX0dQSU8pKQ0KKyNpZiAgICAhZGVmaW5lZChDT05GSUdfTU1DX0JST0tFTl9DRCkgJiYgXA0K
KyAgICAgICAoKGRlZmluZWQoQ09ORklHX1hQTF9CVUlMRCkgICYmIGRlZmluZWQoQ09ORklHX1NQ
TF9HUElPKSkgfHwgXA0KKyAgICAgICAgKCFkZWZpbmVkKENPTkZJR19YUExfQlVJTEQpICYmIGRl
ZmluZWQoQ09ORklHX09NQVBfR1BJTykpKQ0KICNkZWZpbmUgT01BUF9IU01NQ19VU0VfR1BJTw0K
ICNlbHNlDQogI3VuZGVmIE9NQVBfSFNNTUNfVVNFX0dQSU8NCkBAIC04OSw3ICs5MCw3IEBAIHN0
cnVjdCBvbWFwX2hzbW1jX2RhdGEgew0KICAgICAgICB1c2hvcnQgbGFzdF9jbWQ7DQogI2lmZGVm
IE9NQVBfSFNNTUNfVVNFX0dQSU8NCiAjaWYgQ09ORklHX0lTX0VOQUJMRUQoRE1fTU1DKQ0KLSAg
ICAgICBzdHJ1Y3QgZ3Bpb19kZXNjIGNkX2dwaW87ICAgICAgIC8qIENoYW5nZSBEZXRlY3QgR1BJ
TyAqLw0KKyAgICAgICBzdHJ1Y3QgZ3Bpb19kZXNjIGNkX2dwaW87ICAgICAgIC8qIENhcmQgRGV0
ZWN0IEdQSU8gKi8NCiAgICAgICAgc3RydWN0IGdwaW9fZGVzYyB3cF9ncGlvOyAgICAgICAvKiBX
cml0ZSBQcm90ZWN0IEdQSU8gKi8NCiAjZWxzZQ0KICAgICAgICBpbnQgY2RfZ3BpbzsNCi0tDQoy
LjM0LjENCg0K
