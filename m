Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F7CCCF9EA
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 01:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD6482A9E;
	Wed, 29 Oct 2025 02:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gigadevice.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gigadevice.com header.i=@gigadevice.com header.b="lbxfhVIc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACBEC8352B; Wed, 29 Oct 2025 02:53:54 +0100 (CET)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A757180422
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 02:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gigadevice.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vlim@gigadevice.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBC2ozPbHRm2OJq1bL+oAAt5ts3maO3OrU2+XAMGmYBd4anYW55sgBKllhqeN66nuDcgGfbllBY0BI1WMIQFNb6eGWjOdW5rrEoCoceIIBjtbLVIKm8X+ukCZoLTXml6mjFgLyVnO1BGXDBiESduogwE6rUqG88u8v4UU4NMMtk7Ss99kGa2jYHqnQYn41L7wtbb7kiHv+aP+9shmFoeFOmbNphd4siAVEf+pJUgRHHN1eK3rd6UThWIWaARBF87HHcFQ/7fsEak7WTCLtTt3GqnNyMZMUbD0QCARC5ElNUPnou8KBdgjADeKDsPyeJH50TTxXhjiWhMfevlD1U2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9xeSB/zUuTZQjJPZy191Gx1J8bnHJV3qfIu4c/gzDo=;
 b=yijhIb2W75lc+ebBrs0bmccNgbkzrmjFTeGc9NCJkNsn4mRlD7tVpc3XFkg+6Q4bBwhSbMvEN2EN5lE3hDPTTau3Qm2cZ88HbbHKrRjyZOYWaWgBIukqzuct3d8CQJery+5Ev7LQZJT7/9rLSdO1JSphVHf1OtgVcinfExDSYddjwjO4k87Gl8VIxxbGLOPr36PLuzbjJeY67fWabxQWbyECqghlXxIUx8U6KgW3Z9a+LNYtlwc+bf/xNkh4uiQu1Hcf2qPJlFTzqVIKs7XGksv4ohg1Q8v/hAaIkV817xmyuEUrk5vX7z6tu1BmNPUXDPYCT7BAZjKdJBsQfCdilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigadevice.com; dmarc=pass action=none
 header.from=gigadevice.com; dkim=pass header.d=gigadevice.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigadevice.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9xeSB/zUuTZQjJPZy191Gx1J8bnHJV3qfIu4c/gzDo=;
 b=lbxfhVIcfUkx70eJWUIJiVOu6jEZ/uAw/FSJkRPfD0uTI9K1Y0TgSWiHML6smMQE9ijtoU3CgBWYHdupZAU1NVNNO1yC34VigbdGRMqJV0qVfOK1y/UpVaq/HBbatRs5/yiFPxqrEHglgg3b5VRd1WN3bpGB1q3zesCqPSNsw84=
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com (2603:1096:4:26f::11)
 by TYZPR06MB6189.apcprd06.prod.outlook.com (2603:1096:400:335::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 01:53:45 +0000
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16]) by SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 01:53:45 +0000
From: Vlim <vlim@gigadevice.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Jagan Teki <jagan@amarulasolutions.com>, Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>, Tom Rini <trini@konsulko.com>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Vignesh R <vigneshr@ti.com>, havish.mutya
 <havish.mutya@amd.com>
Subject: Re: [PATCH] mtd: spi-nor-ids: Reformat the table
Thread-Topic: [PATCH] mtd: spi-nor-ids: Reformat the table
Thread-Index: AQHcR6R84bCIRBwF0Uan6yynaKMByLTWzOjRgAAdAwCAARTGzYAAUrUAgAAKLMU=
Date: Wed, 29 Oct 2025 01:53:45 +0000
Message-ID: <SI6PR06MB78132750D9E159847DA0F798BBFAA@SI6PR06MB7813.apcprd06.prod.outlook.com>
References: <20251028004729.119349-1-marek.vasut+renesas@mailbox.org>
 <SI6PR06MB7813347A75CE48B5924DF36EBBFDA@SI6PR06MB7813.apcprd06.prod.outlook.com>
 <20ee9a4e-9d66-4507-9c88-6efacef85297@mailbox.org>
 <SI6PR06MB7813BEE2045C178C32397BCABBFDA@SI6PR06MB7813.apcprd06.prod.outlook.com>
 <1f163d6d-bd46-4dcf-afa3-2cc246461bfe@mailbox.org>
In-Reply-To: <1f163d6d-bd46-4dcf-afa3-2cc246461bfe@mailbox.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigadevice.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7813:EE_|TYZPR06MB6189:EE_
x-ms-office365-filtering-correlation-id: 50e899cb-eb17-41a5-8109-08de168dfec4
x-ld-processed: f84ba339-959c-4ab1-9b67-1e43414f945e,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|38070700021|13003099007|8096899003|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?WU9WSzRLVDgyRXhCdURRQ1JKQ2lJaGZ0Z3lEUU04L3g5WTF0MFdmYU5OZXQ4?=
 =?utf-8?B?RTNTY05ZdkZyaU56ZjNIc1hXYkNGOWw5a28rVEJwbGwrTHRlN1RIQThscHdt?=
 =?utf-8?B?bGhCblh5TFlnY0Fwcy8xSXp6aHNTM3NXcVMvQUZJK08rRy9aWnRMKzVkK1Bq?=
 =?utf-8?B?aXFsWVpSNlZOa0t0VElqWGN2TVhpTzZNUUFFZGxPVmd2c1l6citvRTI0SjVV?=
 =?utf-8?B?b3RBcm5YU001U0tYTXl5emt1K2dGNHI4TnpiS1E3QW1UWERXcHUxOW1QakhG?=
 =?utf-8?B?QWduNmxBNCtuZEtMQkFPdXdQWGlNUjRDbXo4eEhLQ3oxNjhCb0xCUUpGWjEr?=
 =?utf-8?B?NU5neWdTVk13TExkVmNHa0ZWV3hqZEJQZDJnYUw3TEtkRmFOeU9wcTNzcnhD?=
 =?utf-8?B?QitJdzZQTEE1QS9laXhxZlVWV1l0TXZpcjJreHZoLzV2RUZUb01GNUIrbUJw?=
 =?utf-8?B?a0oyYzdCek9XbVpzTVpYanpwR05oOS9LSXl5ZjdJVmJmMFYrUEFwRlpOMlNK?=
 =?utf-8?B?ckErMkdVaElheGdWcDBwR3pySi8wTXFOWE5zSXdZT09DeEJqbW55Z1BncXVq?=
 =?utf-8?B?OU1WUkNOcjNLeURCNE9VbUdtblRqNVlEYmRhMnpJUTFIb0Njd2RjVkhxQndL?=
 =?utf-8?B?SG9xQXduZXNNVkF3Y2NPNGZqdVNWZFo5L1FDTThkclVCdEFpcUprb1dYbnZX?=
 =?utf-8?B?WEErR2VhcUg2anAzaitTUHluMmI0dkMrUzNtdXVneHYwZjRDRW5VN1cwQzlq?=
 =?utf-8?B?K29KNjNJQS9GVTIrTXlvYVMvRU9UT3ZoMmsvVXZWY0xEN1preUVMeGRmVzJL?=
 =?utf-8?B?NGJxMUVnV29lYTFWanQ5RDBJQTBNSFJReHZvYWt1Z2xpWVNVRDEwYTNYWWhx?=
 =?utf-8?B?T3Q4MzJubEZjYnNxOXlmRTVuWkltckdWaDJQOEE1ZDJDN3RhU3YvaDNWYS8w?=
 =?utf-8?B?c2VtbTZzR2FCeXZzRlBlQ3hKYXdQZi9sNEIwYjg2VDZhNTcyNXpoUFlIQkt5?=
 =?utf-8?B?M05mR3U3WlJFWkI0NytVdUZnRlhRYlBDSDJmcFNVWDk0bE1uZFczNUFnVjFw?=
 =?utf-8?B?U29uZVJsaFBTY0Iva1FSTlVzUURWdWEzSUJSekc3SXk1S2gxUmNmTzZuNENl?=
 =?utf-8?B?VkJrMUtPUTFsdE9xSmlpdlowbEpPQ2RMMUZ3NlBnODAralNZcldBcmlUaEsx?=
 =?utf-8?B?MGo2YzNOOGkzcDFHckREeFpRRmd0ZnFxZ3BNSnhXS1FkL2hiOEc4djZ5NjND?=
 =?utf-8?B?ZUdhMm1XNXdHbzZzY2R4ZnlLb2NIVDBVaE00U3crcUg5MmdxTTUvbTA4Mktr?=
 =?utf-8?B?eVIyZzVJUk1ldzFwYUw5T1UzMWZVYkFtMUxRUXdVdWs3SCtFSkowbzNTYzE5?=
 =?utf-8?B?M0gxQjU3NEFnenVIcEdXMnhOOGFWRUJCK2YrcTMwbDRyQ1lZMldoV3ZEZkFU?=
 =?utf-8?B?WStxNGlXN2pCYWJ1VVl2aUNicDk2Ti9teEtBZkFtV3ZydTl4dXg5cUhTUkp6?=
 =?utf-8?B?dXBUZ0NFdS95Q21HU0hXTWtqSjNzbWRXRUlDNVY5ZHFkNi95L01TbXREVExI?=
 =?utf-8?B?bmxxdVVZdHNEcVpLaG51bWNES1JRbitPVkNlU0ZLNHRLNUp6ZWgxVFU5NFlj?=
 =?utf-8?B?NWd6RXJzbGxPOXhmdEdjZitiNG82Ykp6QmlnckFEWFBhZTVSTU5UYkRXQW1j?=
 =?utf-8?B?bWpTNzcxay9PNjcvRnU5N0tOVTRuNWVFY0dVSXlVeDJhdTRTTjZYSElBZGRH?=
 =?utf-8?B?dmN1TXVGV1VtdGE5OXZjajIzSW9NbXhHSlc1OEFTbW51akZjcUxEQ1dkVXRh?=
 =?utf-8?B?aTBzNDhpS3VGZDVwTk1tZFlXZzR5eWh3MnFnRVkvQVArTTJTalVqSGQyMWE2?=
 =?utf-8?B?NnRjR2tJNUsrdFNDMDVaYllJM3QxSjlweHpiQmdZOGFaUUpjV041QTZHRFhr?=
 =?utf-8?B?aDUrdFpUS0oxL0ZaRm9zR1V5d21MNmFxZDB4TjVyQmVXQTUrK0VERWZXeFlX?=
 =?utf-8?B?aER0cTZON3hsMk16a1F0NlhUUFpOMFM1aWxxMUZmczFRdDVydThjcGFDT29v?=
 =?utf-8?Q?PEaS8t?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7813.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021)(13003099007)(8096899003)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjdCWU1RVW5yT2NLT0loekZ6T2I5K25DSWJDMWlnZStxNEJ4NjZqTUcrc3Mw?=
 =?utf-8?B?blBtVHd3bVFDNHh5KzdHTU5OMDVyNUJDZHdvcGJiekZYOGJiSGprT2Q0amZP?=
 =?utf-8?B?UWhPck5uSjllNVZPYi9rZytjUkhkaUdBbkxYRCsyZWV3UnNQaE5RZmRiNWh6?=
 =?utf-8?B?aDBIZ1BZQzhZdUpqbENWblgyN2xUWXhYT2NHZktTTWYwRGtUa0c2ZzJyM29h?=
 =?utf-8?B?dGRLU3QzUmJQRWFmL2VPbXVBMFRiajBCNnRlaG9IVE9tQ1JUVklGN2JWeGtX?=
 =?utf-8?B?VndpU2liQXpMUXVOTDZRVUFTdU51S0wyT00waUI4YVNQcEZmMjdrK0lFeUxN?=
 =?utf-8?B?Um00eFVFR2JFNjZLbXpWc0gzYUVYSXA4K1BWcUVLckxBWUdWUGNvNHdNVWJY?=
 =?utf-8?B?WGJDMlF2RktPdmQ2RCsyckUxRUh3RXJ0ZzF2RmIvbEg1MFV2OS9OL0hKSFdp?=
 =?utf-8?B?aGpXWnFmdUJ0VlllMndxajJyTlliais2RllsVi9SbzI5dlcvT2tQSzN6S3NG?=
 =?utf-8?B?U2dncGRJTXBBQ2UvWXUwcU9CcHFHRGFEVHNsbWlnb2h5S1hjSGlxWUprQUZU?=
 =?utf-8?B?UlRWdHpoeGlXaXFyQUNrVlc3SjVhaFgvTHZhMEZlRmJhWW80cFkwMkdhR215?=
 =?utf-8?B?cDg4N0I2UGxna1M3b2c0a0pCc25oZTVQOE9vRHFsYitGMGp4UUVTVzZFOUlt?=
 =?utf-8?B?Q09wdWd4REtOZVdMZ2VFZU1HaE9jRFdIRk00REp6YWN2NEpzaDdJR0tOdW1S?=
 =?utf-8?B?RENXZm8ybzdHUmQ4Wm42VTdmdFppQkdCTllUclVkZDVRR0tMWFZaVDlvS1Nh?=
 =?utf-8?B?ZG9rRGNGeXBHck04c2ZJYmlNNXZrNUFKS1RORHdaQUFOaWNmZzRjdWlmdWFG?=
 =?utf-8?B?eVg1S09uTU8zUHJ2YXI3VWpNSVcrU1dtVXZhTExHbkduNExZOSs2NzE2eGRM?=
 =?utf-8?B?eTFCWklWeFR2VzE5akNYMGZ6T0NWTGpTNGwzVStmNjlucTBEL1ZCS3AvUDhH?=
 =?utf-8?B?VXQxYlpxa0w5V2laQnJvWWhEQXN6Y3lnRGV5SFJVSDUxbnVCZ1FjdWlzVmlT?=
 =?utf-8?B?bzJ5ZVdwdVRxczJZYXMyZUhmWVhKSUhiU2ptY291bzR2TUQzYzVoZjIzcFJF?=
 =?utf-8?B?NFVUYnFFdmEwZDdzcEViaTM5RjRWRVZUZkxrRXlYUW9QRFN1ZFFMU05XSjJ2?=
 =?utf-8?B?dHhrc1dWbWpZdmNYVVJ2QWI1U3dkbjFCaWF4TndTSXV0azZkU3NTSVFxZzhF?=
 =?utf-8?B?NTJzV2Y2eHFPWWRBa0ltUElCYUcxU2ZVTTcvZ1FqK0ZhUDlYeFZoTEVvN0Vs?=
 =?utf-8?B?SC91MUMzSkpuaHZ3OEo1YnlIWXY1aXNzMC9XRkxlcEgvS3FrUlFzMGJweEh3?=
 =?utf-8?B?WWxFUExWdFZyZDdtelQwYkNocDQ1WUc1dXVGLzdMdlhvWE5DS2ZvcWg1NFhx?=
 =?utf-8?B?UllpejJzQ0tQRHVYcHh5Mlc3dVBXbDA1MmoydmJpSk5heHJvOFVjK0RBY3lR?=
 =?utf-8?B?NENWUEN1c1draHMxQUhpT1lRVGt1cnE2Z0FlcXFrK2UvcHRwc1V4c05LMVJL?=
 =?utf-8?B?RTNjN3NPMklVU0dlTlJyRE1lOGlDWXZGLzc5MlJ2MmxOUjd2aGFoRlhiM2lo?=
 =?utf-8?B?cFljSVpOcHRkSkNZY3lsUWxjY25zRjlRdW5BWVBQa0wrNFJWNkcwT0h3Q2ZU?=
 =?utf-8?B?UjBLblBRdnp5ZzZMSkRXTkd5MUdMKyt4QXE3YVNEVEFIM0xnblI4WEw1MEE4?=
 =?utf-8?B?WmQrUTB4cDFUcU40SDJ6ZXlobmZ6aUV2SGdFcVZPdjFnU0lHa3dsellrSUVB?=
 =?utf-8?B?Znlja2hlNWdGSzlnbi9UbGxTNHRtRy9zc2dUc25OMmxiUFNBYXpsbUhRUFFU?=
 =?utf-8?B?cnFCWElMeEtNMmEwaDh3djZJUmt4ei9vbDFXSXZHOFdHTXRLVWRFd0s0bHVU?=
 =?utf-8?B?WG53d0dnUkU5MERXNnE1VHFZOERTUXFKNlN3akU2VUpMRlVGWTdrSnZVanlY?=
 =?utf-8?B?bHBtblBxdTRGQ2kvU041OWF2eVVyVmZuV1d5eE5WZnNGaTF0aWptTzVaYjVH?=
 =?utf-8?B?NUZ3ZEhQOENoWU9LZ2sxd1dJQ005dW5oRm1VK21yMU02YW5VZTJ1S21hMTI0?=
 =?utf-8?B?RlNQT0ZieVZIaFk5ZDAwUDQycFFMK2FMdXZlUmZpOVlBTDdhc1IvMnA0OEFW?=
 =?utf-8?Q?VaDS476lZwOFXHhNO/D0PA9qxF5VieulyC2GoUNRrBb0?=
MIME-Version: 1.0
X-OriginatorOrg: gigadevice.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7813.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e899cb-eb17-41a5-8109-08de168dfec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 01:53:45.3200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f84ba339-959c-4ab1-9b67-1e43414f945e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4xRukMOiyFNS/J/HX1hfzWQtYmuWolZ2XzzPZ8OA63WspANuDY/4wpf9XvBv/0TDt7RN2zEE/QmlHK+w4M7Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6189
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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

VGhhbmtzLCBNYXJlaywNCg0KQ2FuIHlvdSBwbGVhc2Ugc2hvdyBtZSB0aGUgcHJlZmVycmVkIGZv
cm1hdD8NCg0KVGhpcyB3YXMgdGhlIG9yaWdpbmFsIGZvcm1hdCwNCg0K4oCCew0KIOKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAgklORk8oImdkMjVxMzIiLCAweGM4NDAxNiwgMCwg
NjQgKiAxMDI0LCAgNjQsDQog4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCCU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFE
X1JFQUQgfA0KIOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAglNQSV9OT1JfSEFTX0xPQ0sgfCBTUElfTk9SX0hBU19UQikNCiDigILigILigILigILi
gILigIJ9LA0KDQoNClRoaXMgb25lIGxvb2tzIGNsZWFuZXIuDQoNCuKAguKAguKAguKAguKAguKA
gntJTkZPKCJnZDI1YjI1NiIsIDB4Yzg0MDE5LCAwLCA2NCAqIDEwMjQsIDUxMizigILigIJTRUNU
XzRLIHwNCuKAguKAguKAguKAguKAguKAglNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFE
X1JFQUQgfCBTUElfTk9SX0hBU19MT0NLIHwgU1BJX05PUl80Ql9PUENPREVTKeKAguKAguKAguKA
guKAguKAgn0sDQoNClJlZ2FyZHMsDQoNClZpY3Rvcg0KDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KRnJvbTogTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0QG1haWxib3gub3JnPg0K
U2VudDogVHVlc2RheSwgT2N0b2JlciAyOCwgMjAyNSAxODowNw0KVG86IFZsaW0gPHZsaW1AZ2ln
YWRldmljZS5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZSA8dS1ib290QGxpc3RzLmRlbnguZGU+
DQpDYzogSmFnYW4gVGVraSA8amFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb20+OyBUYWthaGlybyBL
dXdhbm8gPFRha2FoaXJvLkt1d2Fub0BpbmZpbmVvbi5jb20+OyBUb20gUmluaSA8dHJpbmlAa29u
c3Vsa28uY29tPjsgVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPjsgVmVu
a2F0ZXNoIFlhZGF2IEFiYmFyYXB1IDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNvbT47IFZpZ25l
c2ggUiA8dmlnbmVzaHJAdGkuY29tPjsgaGF2aXNoLm11dHlhIDxoYXZpc2gubXV0eWFAYW1kLmNv
bT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIG10ZDogc3BpLW5vci1pZHM6IFJlZm9ybWF0IHRoZSB0
YWJsZQ0KDQpbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIG1hcmVrLnZhc3V0QG1haWxi
b3gub3JnLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVh
cm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCg0K5q2k5Li65aSW6YOo6YKu5Lu277yM6LCo
6Ziy6ZKT6bG86YKu5Lu277yM6K+35rOo5oSP6YKu5Lu25piv5ZCm5raJ5Y+K5pWP5oSf5L+h5oGv
DQpUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLCBiZXdhcmUgb2YgcGhpc2hpbmcgZW1haWxzLiBQ
bGVhc2UgcGF5IGNsb3NlIGF0dGVudGlvbiB0byB3aGV0aGVyIHRoZSBlbWFpbCBjb250YWlucyBz
ZW5zaXRpdmUgaW5mb3JtYXRpb24NCg0KT24gMTAvMjgvMjUgOTozMyBQTSwgVmxpbSB3cm90ZToN
Cj4gSGksIE1hcmVrLA0KDQpIZWxsbyBWbGltLA0KDQo+ICAgIDEuDQo+IHJlZm9ybWF0IHRoZSB0
YWJsZSB0byBmb2xsb3cgdGhpcyBmb3JtYXQuDQo+DQo+IOKAguKAguKAguKAguKAguKAgnsNCj4g
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCSU5GTygiZ2QyNXEzMiIsIDB4Yzg0
MDE2LCAwLCA2NCAqIDEwMjQsICA2NCwNCj4g4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJ
X05PUl9RVUFEX1JFQUQgfA0KPiDigILigILigILigILigILigILigILigILigILigILigILigILi
gILigILigILigILigILigIJTUElfTk9SX0hBU19MT0NLIHwgU1BJX05PUl9IQVNfVEIpDQo+IOKA
guKAguKAguKAguKAguKAgn0sDQoNCldoeSB0aGlzIHdheSA/IERvZXMgaXQgYnJpbmcgYW55IGlt
cHJvdmVtZW50LCBhc2lkZSBmcm9tIGJlaW5nIGxlc3MNCmNvbmNpc2UgPw0KDQo+ICAgIDEuDQo+
IFJlLWFycmFuZ2UgdGhlIG9yZGVyIG9mIHRoZSB0YWJsZSBiYXNlZCBvbiB0aGUgSUQsIHNvIHRo
YXQgSSBjYW4gZ3JvdXAgdGhlIHBhcnQgI3MgYnkgcHJvZHVjdCBmYW1pbHkuDQoNClN1cmUuIEkn
bGwganVzdCB3YWl0IGZvciB0aGUgbWFpbnRhaW5lciBhbmQgd2hpY2hldmVyIHBhdGNoIHRoZXkg
cGljaw0KZmlyc3QsIHRoZSBvdGhlciB3aWxsIGJlIHJlYmFzZWQgYW5kIHJlc2VudC4NCg0KPiAg
ICAyLg0KPiBJIGhhdmUgYSBmZXcgbW9yZSBwYXJ0IG51bWJlcnMgdG8gYWRkIHRvIHRoZSB0YWJs
ZSwgY2FuIEkgYWRkIHRoZW0gd2l0aCB0aGlzIHVwZGF0ZT8NCg0KU3VyZS4NCg0KPiAgICAzLg0K
PiBEbyBJIHN1Ym1pdCBhcyBhIG5ldyBwYXRjaD8NCg0KWWVzLCBidXQgcGxlYXNlLCBsZXQncyB3
YWl0IGZvciBtYWludGFpbmVyIGlucHV0IGZpcnN0Lg0KDQotLQ0KQmVzdCByZWdhcmRzLA0KTWFy
ZWsgVmFzdXQNCg==
