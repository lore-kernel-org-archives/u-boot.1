Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682F3C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 06:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E14E880F0E;
	Tue,  3 Jun 2025 08:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="5Az7b2L6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E3182045; Tue,  3 Jun 2025 08:18:49 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A968680AE1
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 08:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzvit05/HVIuWN2E9kAOxmC/8Q7a56yZZw7Hcl9EVSWIYiguyiFuNhJQQO3tcZoqU+wL93xPPIbWcBxF+wAPD4xmaaN2Yok2Pz/tYDtkM4q4KH59ktuIN5QC0y6m8EGLy9FpifebsCeJJCvFIgINQSMLVmS1D+ULchV2gGaPj4bS+QHphOknAA/aaVTM2owyetSDMQ2IN7168M8dyGgLik8HkjDTrAVRgFP9jO2Q1XNSFe/bKHTVsiwEbyVMmLj8LJOh9sEzVvIymE8vb9tb/h9uBSZdY9nutMxffHV8/KTDgv08KQmaNO3kDUy1GZIVpogb86h0tCOsH9P0ZYlpWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Djwk4YYvViV+PPhiY5aJNax1JYwl6TArpmCvRezF9Yw=;
 b=jb0uZcJd/N9YROLvKnYA+YdZHHAMeRsn9vUYNTpOamnbAAox2bMp4fGyHxV0aX29NMAkePKcJrBBn0bi5tbDcv+Yjw7kPWHZF0UMdWMNJbdHEjIGfAjjdqF4qebC2LZnnaQTj/CQzOt0+TZzJIGFd2Kv9+SOYtsPD97EuOQ7zP+uqI3sy+XVfrjmhRH/QEASwfyW0tydKZE9DzjPsJYTdmBcV4o53uKNJAPgJy7isY4zlBKwRNko0I7Q+noJlUTXNca/BsF7Xl5zWSYeStKkK/gexxBOBp4Q8jgA8SX1FZw18fR7yH+dCxiGJbBw7Tj6vaqfyabTGsYBT7Am8wX+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Djwk4YYvViV+PPhiY5aJNax1JYwl6TArpmCvRezF9Yw=;
 b=5Az7b2L6aECCI2hNRdIc5UOK241ocDBO3gZDbRbJr1C2W01hAbMYSpFvjkWLYTQZzhMxAKpyXczfr50YsCm/uS9Lq6dDA51dds40YfbWtOwQqL6uyxe4voo7B2WBZXznfh4G6qlxtDKlLPJ2cmf+5dHQWLrbtkVGYIFt1MpxUKOJ7iUbitE//00qXxgYORjIcjpu8kP+uv14vlax89hXaQHH/vJ/zpPdHMI6rHzxLRN7mwSJdChdpXt5YuWPMEKsWyqSmjO7aQqvrXumxsGacwBSZpAV+U1Y85pEcovNGaC5xzkTxe0NHQ3MLETn9q/CzAjejcCeNdaFNrYOx7sYpA==
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by PH7PR11MB6722.namprd11.prod.outlook.com
 (2603:10b6:510:1ae::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Tue, 3 Jun
 2025 06:18:43 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::d6a7:781c:d71a:e817]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::d6a7:781c:d71a:e817%5]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 06:18:43 +0000
From: <Mihai.Sain@microchip.com>
To: <eugen.hristev@linaro.org>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: RE: [PATCH] atmel: Remove local <dt-bindings/pinctrl/at91.h>
Thread-Topic: [PATCH] atmel: Remove local <dt-bindings/pinctrl/at91.h>
Thread-Index: AQHbz2OogTvvaPG67kWcmuKBJiiLqbPvzlIAgAAwKoCAAAEvgIAA/VNA
Date: Tue, 3 Jun 2025 06:18:43 +0000
Message-ID: <PH3PPF37F43E35D1A1812BFA8DF0D982EDC826DA@PH3PPF37F43E35D.namprd11.prod.outlook.com>
References: <20250528000118.3002916-1-trini@konsulko.com>
 <72a265ca-d5e7-40ca-b05f-5a3cf8f0f0c8@linaro.org>
 <20250602145716.GX100073@bill-the-cat>
 <3ccfcf04-f6e7-4510-ba18-637275384cb7@linaro.org>
In-Reply-To: <3ccfcf04-f6e7-4510-ba18-637275384cb7@linaro.org>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|PH7PR11MB6722:EE_
x-ms-office365-filtering-correlation-id: 9f7f0ff5-b338-4cc4-34e7-08dda2667da5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aU15Z1A4VGFQdGRFUHJiSzE1aXByTnVmeGlYY0hLdGh6QzNtOW9IaTZpM3dl?=
 =?utf-8?B?MjEyaFJkRDN1V3ZSL1FpK2RuUldVK2ZTMzFEdWpBK3lVWkVpYUZZWkpNK0FD?=
 =?utf-8?B?TklLSzVmeXdyUUNFNThPN1lQOXNuL20vbjFoWTNYK3RzUjEwZG5yQ3dvWHll?=
 =?utf-8?B?N2psWTF3YWx5RnZQV2tPSEl0WDZhTkRzRmhsZDh6ZGtRRW1VUk1sTjJqZGND?=
 =?utf-8?B?cDZOUFMzcTBUK3AyTmovdkxzM2JKaVdobE9RT2g4N3RBbUtyaDNRUm1Hb0VY?=
 =?utf-8?B?NEhOZmNtNzhKY20rbU10aVlHVGlHcHZXYVhkd0thVll4QmhFWi9KR3BDRnUz?=
 =?utf-8?B?bTJwcWhiMFFwZDNuT3dDeG1Jang3RDFnbmEvODRTcWcyZXo5S1NXYW9rNDhQ?=
 =?utf-8?B?dXRKUGFqdUs5ak9oVlhtbjlwVG1oUWxsemdia3FLUlRMbitWTGJtMW0zTUJk?=
 =?utf-8?B?Z3Nlcjk2ZDJ5cVNEUlhGR09UWnQ5bmlxVUcwZnBKVCs2RXh6bzFxaWZzbWtO?=
 =?utf-8?B?dmttbjNwaGxNRFZUSk9BR1NBYytETkNnMUt6Tnk3Sk5naCs0cHVIcllyNUJ6?=
 =?utf-8?B?RHl4WG5Pc1c3b2pmTTJLU0E3OHMyWnlsNE40MVNXTkRqL25VSkdCY0NIMmtS?=
 =?utf-8?B?aEdXMXM5dVVjR0pPUlJrbWx1aDdRL3pMNEFrbTU5RERjTDZDNUpXbzhUcmhx?=
 =?utf-8?B?c3h3TUJHTW5LcjZEODdJWktlNlhKMzloZjZsckY5OEU3V29RcEY4MFRBTjQr?=
 =?utf-8?B?YXNhOWVlTnp2dmwzMmFmTFE2NWk1aFpHb21hWGJ0OU1CdmJYaytxbnNjaXVJ?=
 =?utf-8?B?SWxUWERzUEhjRUZScEFYRDNTYytHdHRLZHBlOTByb1JlTzlBM2tqU0xBS1B5?=
 =?utf-8?B?VkdrNEpRZ0dEZWxTVFZ3ZFFVWktvRmZEZkdRdW5Rak00Y2xodVR0V2lvd2R5?=
 =?utf-8?B?Z3lWcUVkMWtSZ1A0c00reit6RVBNaFpPdGkrRVpDUk9mQmRMSHJYYzR2Rjhl?=
 =?utf-8?B?ald4aVNENExlWkdCcTdUSFRBOWo2cTFRMWsrN3NPa3ZIclE4WU1naEw4YldD?=
 =?utf-8?B?N1A3anh5YTJINTZlbEx2dGtiMzA5ei9yYzNnNndlYm5zNWhnYkN3R015cUpr?=
 =?utf-8?B?Ym9icEVJYnBwTHRtUXdEMGFsZ1lEcE5NNjloNDlFdk1Wd3phRk5kOUt2bVZT?=
 =?utf-8?B?K3AzZk1ZZktsVVNMTDh0T3RQQW1JSDZWMUZ6Ynp1VXRZQlFXdlg5Y0Zmb21F?=
 =?utf-8?B?TDFTMVJ6QS92QVQyalkvTmhMbEp1eHVmaHpZUzNMVkZ3UXBsY1J4M3kzZUkr?=
 =?utf-8?B?YmpJYVVidjRET3ZTUGlWYVRidytJUkJkM3FvSGRyLzRmQzFmOGlUd0J1UGRp?=
 =?utf-8?B?N1NIZHpCRVN3cERGcmdnczA0cGd3cWFNSkY0VDIxZjRtYzFBVUtDUzJIa3oz?=
 =?utf-8?B?Uis4U1ZsUDBqM1ErM1FjS1BUVGdMOTZrWGpuNWsrZnp6ZSsveXpmcEZrdzJF?=
 =?utf-8?B?YjlHc2s4bUJiZzlaelZRTkJBZWxSVW1NVjk3MHpQTlJ3V0FUQUwxbXQ4cnZ0?=
 =?utf-8?B?MnIzSitPcjVTbkR2ZHBYTHBoVVFzMmFtM09CdEl4UGlnaGN0Uno5UTAvWXRs?=
 =?utf-8?B?SjFMRFJWQ1E3dGZ2c0NZUFdaVXFkNStCSnYwZFV0L2hrM2ptRHlid2FyQ25R?=
 =?utf-8?B?UWQzcm9JSXRhLy9NbXNrSFZoUmZ0UGxxejB6NzJFZkFjNk9QczRSNmlzdDFK?=
 =?utf-8?B?SVQ1bC9lQmtqejdheExoN2dubzNBSDlUc3RiOFhZWVFCWTB4bGFQT0tBUHEr?=
 =?utf-8?B?NEozTWlWT3V2Q1pKMjM2V3BQeSt6M0psNThTYXZOZ0FWeUt1bWEwa1F3eFJk?=
 =?utf-8?B?RkdqRW4vZ0VaNlZva2JXSFQ0S1VHSTAwVkYxS1UvMXFCOFJVV1lHdlEwZDQv?=
 =?utf-8?B?ZVNGYi9HL0hRM3o1RXQ0UnRCMHJTZVZBYW1XbFZLM21qQVpjWDlaQmZtbDR0?=
 =?utf-8?Q?zNh/O12vbLiA3R1VDbEumUZR2FqBAY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1pGakJpbjhyVUdaVjV0THpuSDh3bXlOWnRhcE1XSTJmUFBSbFk5bWhRMVF5?=
 =?utf-8?B?Mm1XMDZUSVBWTmloM1NZVzFyMWFBM0o4cnMvUElqQWkwOFFLMGJNN1hEZkcv?=
 =?utf-8?B?RjBzS014VFQ0Uk9kSU1DUGZna2lrTjJtMDJHWXczYmxab1BxOWZGN002UEJw?=
 =?utf-8?B?cHR3dDZ2YWZBWGpaQjRsTG11eWdLQWpxcGRkMzBLNnFUdUt5d2xqaFlXaHNP?=
 =?utf-8?B?RWp4YXVOSENkSW1KN0xtOEI4Yk5WeFFzTUdjZlpVRzlPQTdUR3AxMExnY0d0?=
 =?utf-8?B?WTFYTnZXTnQ3WDRHOVBVYVpDSlcyYWM3L1NaeGUzT2VxZDRzWFJxUlFZbHRD?=
 =?utf-8?B?eTltSGp6ckd3VUVqSlZ4NXczS0ZIa1hsZjRuazdGb3pYb3pMdEVhWk0yNHMw?=
 =?utf-8?B?S3Y4UzFkU3MxTVRIOUsxV2diMlhpTUhWRmZCcVJQQ2lZNE9ia1FFMGNLYzJ2?=
 =?utf-8?B?VEhML05xd1Z2YVJxeG5NeXdFNkJLbG9TRFlXTVpwQzg3ek8rditUemdPQ2JX?=
 =?utf-8?B?WU9PYjI3SEZKTndIejkrTzJURjJpODhKcEc3U25iSENKLzdYOUF5Rk85QXhV?=
 =?utf-8?B?bU9tVFRzUzdRWW16RmkzKy9nVU8wNzUrLzdQNWxUbjQrZk9lcm5sa292NGlU?=
 =?utf-8?B?UjhheDFpMUphK09sSVlVT2N2N2dWeXVRK3JGNlB0VjBjaGg0RUpHdFRTTHNE?=
 =?utf-8?B?QlVtVnNQemF1NlJjWFU5cDFSaTZHenpXTXMySFBvU2VaZDhYdnN6MEErSXpH?=
 =?utf-8?B?UEYyZGg2SEFWalhON24rcDNtaG9jajhjZkRFMDV4VUFYMnpjZ1JZQ1FNT0tx?=
 =?utf-8?B?ZUlhV0FFTTVRVkExaDQyRDVGQUN1TFhsRHJEbE8rNmI3QU1mYUljTG9rdnlJ?=
 =?utf-8?B?S2YrNUpCNll5TVJ5MDNIOHR2dnFqRi9SMnpxeXJqZ04rM29PRHNWMDNveGwv?=
 =?utf-8?B?c1cwRmJScU92K0NSeExqd1RVbEszWldMZlVwTC9jMFlTZHEvYzdrc1RndXhk?=
 =?utf-8?B?MGd3ajlURTMxS0pVY0dzOHNLU0txVDFzcHNVRVpZWEJtZFl6TUZrcWtmc3Rw?=
 =?utf-8?B?NmkwRjVtaVpQMlNZcS95VVFyU05BUzhFVk50L0NyaDBNWDk5aGI0d1kzd29T?=
 =?utf-8?B?QzJjVmZycEhiNUhMZnVVWW9oaEhDRDM3QnZHNFlHek9iMEtkVmgxVTZYL0Fw?=
 =?utf-8?B?alFydXFqRUxoY3BJcUJIeHR2L2NLNnhucnVva0JOQUYySWZBamhaWXExY0tD?=
 =?utf-8?B?MG0rNFBNYjFQaGpwbE9zbGw5MlFwUzFsd2FWOWZPQ3p2UFVPVmovVzBKd0cy?=
 =?utf-8?B?ZWt2eVpJUlVtVmZGWnpLTmQ5RW9leFllS0UzckVDb2RramJaa2h6YXdUMUZZ?=
 =?utf-8?B?MUJpL1Y0cnJxaEk3OGlGRTUwdEg2WjVMWE5ZNWNSVFNPQjIwNWRMc1hwTHBz?=
 =?utf-8?B?VFZKd2JIQXdUOWFkRURHd3RTYWpGNXhEWUVuUXpzTEo2U0JJdFMwV09KODRK?=
 =?utf-8?B?bmtxYlJMU1kxdG9yS1JHSkwrMk5uMVdKZzgzQlI2RVd2RUdtUko3T1g5S1dm?=
 =?utf-8?B?ZStEM3JHOVhneUduZjVCZS9XSDh3MHVtYlZzTnY3Z0d6bUs3OUpBUjNvYUdM?=
 =?utf-8?B?c211SmROeENvaE5sMzROZVlrNHI0UjBSUWhNOUNtRjh5NFhNdjZDaFdBVEUy?=
 =?utf-8?B?YXhzdkpUV0R4aHBRbkJsM3hUSFUwTm5Bam1ac281ckVtZDI5Q1htR29RR0VO?=
 =?utf-8?B?RDBUandnTEhRcUdXbHAxdGRQRnJrVXhqVXhOUUtYT3pQQWxXL3U4QjVsZkNB?=
 =?utf-8?B?eCtQYUJYSHBBT29WNk1jQ3M5YmZjZ0kyYUx3a1pRVVlQaGFDUVQxZWlhblRy?=
 =?utf-8?B?VlA5MnZaWXBKNEpYS1pMMXBmT0JUaittcVdrNzRSemJGWktRRElxQVFueUUx?=
 =?utf-8?B?alFvU2cwcy95cFJVVlpuNEk5YU1VVmY5MWczbFdGUzk2NU1lRHo1NDdRcm9S?=
 =?utf-8?B?RE42aklCSVdBMWN2MVl5Y1hvWVkzZkNCUGlCNXFEYXJ5WklaczNqaXF4SEcz?=
 =?utf-8?B?c3dtZm9uOVIxUGttRWVCdFFzZklEdDB5UEg1QVlRNnFuNkZSY2tMZE9HVHI0?=
 =?utf-8?Q?AtpxEIO9WgC8NllIxllZbf8JD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7f0ff5-b338-4cc4-34e7-08dda2667da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 06:18:43.4692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdBRiFHkMbNggW7UywfDogPmHhZXZpTTiOpDRUqEIus50broN28gdYrUjU0/H1gyQo1rMI6XaRErYMW8DN0m/9e5EuctU/qOI/9aOx6Jsis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6722
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

PiA+Pj4gV2UgaGF2ZSB0aGlzIGJpbmRpbmcgZmlsZSBpbiBib3RoIGluY2x1ZGUvZHQtYmluZGlu
Z3MvIGFuZA0KPiA+Pj4gZHRzL3Vwc3RyZWFtL2luY2x1ZGUvZHQtYmluZGluZ3MuIFRoZXNlIGZp
bGVzIGFyZSBpZGVudGljYWwgc2F2ZSBmb3IgdGhlDQo+ID4+PiBmYWN0IHRoYXQgd2UgZG8gbm90
IGhhdmUgY29tbWl0IGFkYjI0MjRkMGQwNSAoImR0LWJpbmRpbmdzOiBjbG9jazogYWRkDQo+ID4+
PiBjbG9jayBkZWZpbml0aW9ucyBmb3IgUmFsaW5rIFNvQ3MiKSBmcm9tIHRoZSBrZXJuZWwgYXBw
bGllZC4gSG93ZXZlciwNCj4gPj4+IHRoaXMgY2hhbmdlIGlzIHJhdGhlciBpbXBvcnRhbnQgYW5k
IHNob3VsZCBub3QgaGF2ZSBiZWVuIG9taXR0ZWQgaGVyZQ0KPiA+Pj4gbW9zdCBsaWtlbHkuIFJl
bW92ZSBvdXIgbG9jYWwgY29weSB0byBnZXQgaW4gc3luYyB3aXRoIHVwc3RyZWFtIG5vdy4NCj4g
Pj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPg0K
PiA+Pj4gLS0tDQo+ID4+PiBDYzogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBsaW5hcm8u
b3JnPg0KPiA+Pj4gQ2M6IE1paGFpIFNhaW4gPG1paGFpLnNhaW5AbWljcm9jaGlwLmNvbT4NCj4g
Pj4+DQo+ID4+PiBUaGUgZnVsbCBrZXJuZWwgY29tbWl0IGxvZyBpcyBhdA0KPiA+Pj4NCj4gaHR0
cHM6Ly93ZWIuZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRz
L2xpbnV4LmdpdC9jb21taXQvPw0KPiBpZD0wYjMyOTI4NTI4NjMyMTU4MjVmODg5MDViOWRiYWZj
MzEwMWUxZDdlDQo+ID4+PiBhbmQgc28gdGhpcyBzb3VuZHMgdmVyeSBpbXBvcnRhbnQuIFBsZWFz
ZSBsZXQgbWUga25vdyBpZiB0aGlzIHNob3VsZCBnbw0KPiA+Pj4gaW4gbWFzdGVyIGZvciB2MjAy
NS4wNyAob3IgRXVnZW4sIHBsZWFzZSBwaWNrIGl0IGFuZCBzZW5kIGEgUFIpLiBUaGFua3MhDQo+
ID4+DQo+ID4+IEhpIFRvbSwNCj4gPj4NCj4gPj4gSSBkbyBub3Qgc2VlIHRoZSBjb25uZWN0aW9u
IHdpdGggdGhlIFJhbGluayBTb0NzLiBNYXliZSB3cm9uZyBjb21taXQNCj4gPj4gcmVmZXJlbmNl
ZCA/DQo+ID4NCj4gPiBFcm0sIHRoZSBrZXJuZWwgbGluayBmb3IgbWUgaXMgInBpbmN0cmw6IGF0
OTE6IEVuYWJsZSBzbGV3cmF0ZSBieQ0KPiA+IGRlZmF1bHQgb24gU0FNOVg2MCIuDQo+IA0KPiBU
aGUgbGluayBpcyBnb29kLCBJIG1lbnQgdGhlIGNvbW1pdCBtZXNzYWdlIGFib3ZlLg0KPiA+DQo+
ID4+IEFueXdheSwgb24gdGhlIHNsZXdyYXRlIGJpdHMsIGFzIG9mIHRvZGF5IHdlIGhhdmUgRElT
PT0wIGFuZCBFTkE9PTEgYW5kDQo+ID4+IHRoZSBkcml2ZXIgdHJlYXRzIHRoZW0gdGhlIHNhbWUg
d2F5LiBIZW5jZSBEVHMgd2l0aCBESVMgZmxhZyB3aWxsIGhhdmUNCj4gPj4gdGhlIGJpdCBlcmFz
ZWQgaW4gdGhlIHJlZ2lzdGVyDQo+ID4+DQo+ID4+IFdpdGggdGhlIGtlcm5lbCBiaW5kaW5ncyBm
aWxlLCBESVM9PTEgYW5kIEVOQT09MCwgYnV0IHRoZSBkcml2ZXIgc3RpbGwNCj4gPj4gY29uc2lk
ZXJzIERJUz09MCBhbmQgRU5BPT0xICwgc28gdGhlIERUcyB0aGF0IGhhdmUgRElTIGFzIGZsYWdz
IHdpbGwgZ2V0DQo+ID4+IHRoZSBiaXQgd3JpdHRlbiBpbiB0aGUgcmVnaXN0ZXIuDQo+ID4+DQo+
ID4+IElmIHdlIGFsc28gcG9ydCB0aGUgZHJpdmVyIHBhdGNoIHRoZW4gdGhlIGRyaXZlciB3aWxs
IGFsc28gY29uc2lkZXINCj4gPj4gRElTPT0xIGFuZCBFTkE9PTAgLCBzbyB0aGUgRFRzIHdpdGgg
RElTIGZsYWcgd2lsbCBnZXQgdGhlIGJpdCB3cml0dGVuIGluDQo+ID4+IHRoZSByZWdpc3Rlci4N
Cj4gPj4NCj4gPj4gU28gdGhlcmUgaXMgYW4gaW1wb3J0YW50IGNoYW5nZSBieSBjaGFuZ2luZyB0
aGUgYml0cyB2YWx1ZXMsIGFzIHRoZQ0KPiA+PiByZWdpc3RlciBldmVudHVhbGx5IGVuZHMgdXAg
d2l0aCBhIGRpZmZlcmVudCB2YWx1ZS4NCj4gPj4gVGhlIGRyaXZlciBwYXRjaCBhcHBhcmVudGx5
IGp1c3QgaW50ZXJwcmV0cyB0aGUgRElTL0VOQSBiaXRzDQo+ID4+IGRpZmZlcmVudGx5LCBidXQg
dGhlIGVuZCByZXN1bHQgaXMgdGhlIHNhbWUNCj4gPj4NCj4gPj4gUGxlYXNlIGNvcnJlY3QgbWUg
aWYgbXkgbG9naWMgaXMgd3JvbmcuDQo+ID4+DQo+ID4+IEkgd291bGQgYWxzbyBiZWxpZXZlIHRl
c3Rpbmcgb24gdGhlIHNhbTl4NjAgd291bGQgYmUgcmVxdWlyZWQgZm9yIHRoZQ0KPiA+PiBzbGV3
IHJhdGUgY2hhbmdlLiBGcm9tIHdoYXQgSSByZW1lbWJlciBiYWNrIHRoZW4sIHNsZXcgcmF0ZSBj
aGFuZ2Ugd2FzDQo+ID4+IG5vdCBuZWVkZWQgaW4gVWJvb3QsIGJ1dCBJIG1pZ2h0IGJlIHdyb25n
Lg0KPiA+DQo+ID4gU28sIHRoZXJlJ3MgSSBndWVzcyB0d28gcGFydHMgdG8gYWxsIG9mIHRoaXMu
IEZpcnN0LCB5ZXMgaXQgd291bGQgYmUNCj4gPiBnb29kIHRvIHRlc3QgdGhpcyBjaGFuZ2Ugb24g
cmVhbCBoYXJkd2FyZSBhbmQgbWFrZSBzdXJlIHRoaW5ncyB3b3JrIGFzDQo+ID4gZXhwZWN0ZWQu
IFNlY29uZCwgeWVzLCBpdCBsb29rcyBsaWtlIHdlIG5lZWQgdG8gbWFrZSB0aGUgcGFyYWxsZWwg
Y2hhbmdlDQo+ID4gaW4gZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5jICh0byBtYXRjaCB3
aGF0IHRoZSBrZXJuZWwgZGlkIGF0IHRoZQ0KPiA+IHRpbWUgdG9vKSBhbmQgd2UgY2FuJ3QganVz
dCByZW1vdmUgdGhlIG9sZCBiaW5kaW5nIGZpbGUgd2UgbmVlZCB0bw0KPiA+IHVwZGF0ZSB0aGVt
IGF0IHRoZSBzYW1lIHRpbWUgKHNpbmNlIGxvbmcgdGVybSB3ZSBuZWVkIHRvIHJlbW92ZSBhbGwg
b2YNCj4gPiB0aGUgb2xkIGtlcm5lbCBkdHMgc3R1ZmYpLiAgVGhlIGZpbmFsIHRoaW5nIGlzIHRo
YXQgaXQgcmVhbGx5IGlzDQo+ID4gaW1wb3J0YW50IHRvIGdldCB0aGVtIGluIHN5bmMgYXMgaXQn
cyB2YWxpZCB0byBwYXNzIG91ciBkZXZpY2UgdHJlZSB0bw0KPiA+IHRoZSBrZXJuZWwgdG8gdXNl
LiBDYW4geW91IHRha2UgY2FyZSBvZiB0aGUgY2hhbmdlcyBoZXJlPyAgSSBkb24ndCBoYXZlDQo+
ID4gaGFyZHdhcmUgdG8gdGVzdCBvbiwgdGhhbmtzLg0KPiANCj4gSSBkbyBub3QgaGF2ZSBhbnkg
c2FtOXg2MCBiYXNlZCBib2FyZCAuIFRoaXMgd291bGQgaGF2ZSB0byBiZSB0ZXN0ZWQgYnkNCj4g
TWloYWkgb3Igc29tZW9uZSBmcm9tIE1pY3JvY2hpcCB0ZWFtLg0KPiANCj4gU28geW91ciBwYXRj
aCB3b3VsZCBiZSBnb29kLCB0aGVuIGFub3RoZXIgcGF0Y2ggZm9yIHRoZSBwaW5jdHJsIGRyaXZl
cg0KPiB0byBwb3J0IHRoZSBjaGFuZ2VzIGZyb20gTGludXggLiBUaGlzIGNhbiBiZSBkb25lIGJ5
IE1paGFpIG9yIHRoZSB0ZWFtLA0KPiBpZiB0aGV5IHdhbnQsIG90aGVyd2lzZSBJIHdpbGwgZG8g
aXQsIGJ1dCBpdCBoYXMgdG8gYmUgdGVzdGVkIGFueXdheSBieQ0KPiBzb21lb25lIC4gRXNwZWNp
YWxseSB0aGUgaGFyZHdhcmUgd2l0aCBzbGV3IHJhdGVzLCBsaWtlIHRoZSBTRCBjYXJkLg0KDQpZ
ZXMuDQpJIGNhbiB0ZXN0IHRoZSBtb2RpZmljYXRpb25zIG9uIHNhbTl4NjAgYW5kIHNhbTl4NyBi
b2FyZHMsIHNpbmNlIHRoZXkgdXNlIHRoZSBzYW1lIHBpbiBjb250cm9sbGVyLg0KVGhpcyBwYXRj
aCBzaG91bGQgYmUgcG9ydGVkID8NCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9j
b21taXQvMGIzMjkyODUyODYzMjE1ODI1Zjg4OTA1YjlkYmFmYzMxMDFlMWQ3ZQ0KDQpSZWdhcmRz
LA0KTWloYWkNCg0KPiANCj4gRXVnZW4NCj4gDQo+ID4NCg0K
