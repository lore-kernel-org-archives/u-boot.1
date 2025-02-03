Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37049C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 10:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3920380608;
	Mon,  3 Feb 2025 11:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VRht3FkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F396280780; Mon,  3 Feb 2025 11:07:49 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAC94805E7
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 11:07:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zW3Zlq5qtgnQzB2+rKx9wLu53k41CivUEdogLac2uZfDO6tO/RsCVMDIlJHLkhv/5c/c82WX1nleKMXBKvXeC2B749A2UW4GD3aRLI9n//CV+yVeJtfF7TxP8+wGFi4loclAX81yq3F2+FuqpZvhThNQ0qnBAiKdTOT3KsHY02mjTSuDOUTQZ87DllkmavXG6uXImVYJsfrTCT7elIVFKsxrZmiZCotzLWim81o49yTrwS6zzmNrutl1sSZOfjVvyM7NQHTkZdCYsohV+fUmGRdkS6AEsFeW/yLGpxWT7VDO4i1FucvStSfzqmGLU2s/Jsgf2/Wrx5EJool/QUs9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGbOM+sqL7bdVansiJDe/f9Y+uFX7JH1vYWsnU05smM=;
 b=SRW+ouaiZfE2Yq3dYHqv85XSCHGJL5/8XeKs8u2zIavNsY2KCctR4TN6wgWfRXugSBX8wxx7EblPeIgew/UNFCyebwI5JbP8o70rlH/YefaIXyMa/LxIcIPgDYz1tPFib7BBPqc/wsltOmOQLlurlugv/TGBKwBBrvzR3bhzNOKXBeVlAASvCbi20agexlNRxjDaFEWkZHLDrXMJvYXtqOb9uPiXUovDNA+f4FUEpeD8S1wnX0QA9v771rnSxrO2AbZGo4GeKIgvPn9CB3vMHLLgskR8Kdboklj4a9NkCTq2rCMLYqq91B0aoxAJ0v8ymix7J1IDBZp3JS5txHh8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGbOM+sqL7bdVansiJDe/f9Y+uFX7JH1vYWsnU05smM=;
 b=VRht3FkWyNAz9cF2+1kI1rwIG5KTqwGV0w0zyZRO+Ov80AT2VMKp+RaVEoYDa6m7/gUFTJUfG1SKkfkGT7XZo9/d57KK6mJFIQvHWmWFNuxcVBaCQHuGZ9hyMiDp3HLcSBPwXOB0/73kCSUH/5bbmtSU6CakMct/dKznYAmHFG1xoCqqrb1CDYTcIyTURVGOvghAIDU11wprYXbeVkna6KjBYNPaE9TY85gacL7E+QEuL1XNbd7jsulAu9lglPtlpazN9v0yWGHPV1AFkosfJvnSa004mpM/LrSxZ5jFbLjEXan+T++JBgpJpboUf/uQk9dPQHaJavAbWxgq18mlwQ==
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by PAXP195MB1232.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 10:07:45 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%6]) with mapi id 15.20.8398.017; Mon, 3 Feb 2025
 10:07:45 +0000
From: Daniel Schultz <D.Schultz@phytec.de>
To: Wadim Egorov <W.Egorov@phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "upstream@lists.phytec.de" <upstream@lists.phytec.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "nmorrisson@phytec.com" <nmorrisson@phytec.com>,
 "d-gole@ti.com" <d-gole@ti.com>, "sjg@chromium.org" <sjg@chromium.org>
Subject: Re: [PATCH 2/3] board: phytec: phycore_am64x: Add support for 1 GB
 RAM variant and ECC
Thread-Topic: [PATCH 2/3] board: phytec: phycore_am64x: Add support for 1 GB
 RAM variant and ECC
Thread-Index: AQHbcHI9ImzGk8ElqkeNl8OpnGMiubM1ZgoA
Date: Mon, 3 Feb 2025 10:07:45 +0000
Message-ID: <7c29aa05-d64c-4c1c-bec3-9aff7f412850@phytec.de>
References: <20250127041612.985929-1-w.egorov@phytec.de>
 <20250127041612.985929-2-w.egorov@phytec.de>
In-Reply-To: <20250127041612.985929-2-w.egorov@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0P195MB2484:EE_|PAXP195MB1232:EE_
x-ms-office365-filtering-correlation-id: 3f0ece58-c7c1-41be-6c3d-08dd443a9ad1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?b0NiU2RZbms5dFFaM2R2VHo4bVlIOGI1UE9MbmpBN2NaS1JpYzR3Y2pkQUwz?=
 =?utf-8?B?VVl5cHFQWWRMV05FcEpEbnNoeHpQdEhXQnhxSEpmVHZXZkhNaE5xZTI3SC9q?=
 =?utf-8?B?c25kU2gyeXVxSU5XaitYellTWlZIS3NYd3ZqTnowWWpabkh2UWRZcUI3Y1FC?=
 =?utf-8?B?c2JuMTBBTC80RmlSbUVXK0s0Qk5tQTdZbEhaSlFFc0dOYlI4UW9aMGFDYWU1?=
 =?utf-8?B?N0tyVFhJeHRCMW0xZjVVNGg4SU9CWS8zeCtpd25FVGw0bnY3RzNXRGlFa0RT?=
 =?utf-8?B?SmxCZy9rT0lsdFJEaVRVT0tjUnZLUlRCRnJ1YVRTWjRNbHpwVSt2ZDRCMnZa?=
 =?utf-8?B?UUFVOEpYby9IYjg4OWNta1ArcEhBMjU2V2grOVNVczB3eHgrQzM1bHYxdVNu?=
 =?utf-8?B?YmFoQ3FHa3Y2eUc2RTJ3WEdLcU1TcFRkamFUQTNqNzExT1lpSE9TdWU5ZGpr?=
 =?utf-8?B?QW1SVGJYaHFNYnFnNElKdWlRTHRKU0tNL0Z5eXh3NmtVQ1NwVWF4QkdmRFlL?=
 =?utf-8?B?ZVNIZ1l1NVk2YnFVelF1YTkzVnI0emx4K2I0SVBaRnJWSU52RnVFbGtiMXFZ?=
 =?utf-8?B?bFRuZElIVnJoTmU3dUV1T0pMSGJVeFh3ZU5tWEJ0VUIwOWlVdS9aUGptaWVN?=
 =?utf-8?B?bEZIVGZJTUFUbE1mVkRFcG10MWZXeGNwTnFYR1E1M3dHWXZIR2pQM3lXV1Fw?=
 =?utf-8?B?WDk4eHV0Y0lEQXdiNVlzVHJqY1pwN0RqcnI1V2N5SlBHbGNURjNsUnRESDB4?=
 =?utf-8?B?anRWa29IcC9hamhrUGxCa3d2K3R6blBvZzhoYW1SUGhhUks4QnhhRm5OWnpi?=
 =?utf-8?B?TWhjTmY0aFZua2dxRUhoUjdlZ0RvK1pBaUlvdFA1UFI5WFcrSjJBVEZIbVFZ?=
 =?utf-8?B?QW11MkxWTUZ1Ui9YYno0WkRFYjZibGpVNjVqeGtZRDJpZUo0SjlKK2RIaU9F?=
 =?utf-8?B?RitsQjNKVG5kL3pWT0ZOaExBaWVWT0V1eXoyaURRV1RoejB3QzArTnRBRlk2?=
 =?utf-8?B?L0tDMXV3bFl3UzcxMk5hVVlkOFhLZmsvV2pHSW9KKzJ2c0F1OXMvZEI3ak9V?=
 =?utf-8?B?RHpFZnhiWWpuVFhhMnlkYkNLV0gvZDNiNzUxTTZEclA1YzRrZnZObUh0Q01U?=
 =?utf-8?B?MUxoM0plU3ZHQUxhQmw1V0NaT3p6L01LWjdpeDd0N3VnaTF2M21mOTBuK0ox?=
 =?utf-8?B?czI5VkFHN3NqZ3RJTFhEYWF6aDZBd3liVlRMK25LRnR4dDZkUEVZTTNoY2g0?=
 =?utf-8?B?MDV4UWJrMWlJd3NMclpRVGM1SmtIeWZuZzNSQ2pMbUt3bjc1UHk5U25Ed0F3?=
 =?utf-8?B?Qnhya1laMk5pMUhUOENseWp3NUpWWjVCZFFucDVLelNXT2txdEM2L3VwOUIx?=
 =?utf-8?B?alRoOHR1M2VVVlBRZUczd1R1M2Z5OTVsYzJScVRSeGNGZ3FSTk1sWVBLc1ZS?=
 =?utf-8?B?cGY0ZEY3ZUt6Um5SQWJiZ1VRb01yZThuL3JiVCtxeGlCdXNkdzVKQTF3bEFy?=
 =?utf-8?B?K21NcWd4NCtYVy9zQk01TloxS1RSTDJYM2t0UWQwLy9BOTdqRk5EMUY1OGgz?=
 =?utf-8?B?Mi9ZM3V2NlVmYXdIZlBhUmZnZytvcUtZTG1oemI2VFJudWpaUTBBYVVvdGk1?=
 =?utf-8?B?UEl1SlNRbzNYZUVRSHJwTzJ0VllEcG9xNVJYYmd4KzVJalZuZWRFaXlqaFdu?=
 =?utf-8?B?NVcvcXhUYTBkUmRtMlJ4aHRYemlaODVlL0c2Y0IzYUFxejNWblFid3dCdU93?=
 =?utf-8?B?MGdUZmRJaUJVOHZsaEJXR3lHS3RMS0Y5MEhyQyt0MVc5LzJGMExBVldmNzhy?=
 =?utf-8?B?eHJ0WCt2Njg2ODRqRFZtQVJMKzdic0JjR1B6TGtPSTh5U3hPazhIRXN3SE45?=
 =?utf-8?B?aS9aanVwMTMxQy9vNDYzZU1KUk9vWG1TSFBpUnhCa1h1T09ZUDdncGYxeUNF?=
 =?utf-8?Q?yLMUpqHKF1lsNfFEriwLtFhySmyZYrQj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlNZM004ZmFVZ3pZK3krOFNOODh1NllncGV3aDBzbk9XQmlMSzIzUWozdXBT?=
 =?utf-8?B?R0hUTXE4NzNMRUJzMUhFcTRxN3RERFNOWXFNY1c0bndPMlJ6L01odEo4YW1M?=
 =?utf-8?B?UWEyQytpU1YvQ2VMVnpFWHM3eEhwZlhRbVVNWFNCYU1yR0dzZjlFeHAvcGg5?=
 =?utf-8?B?SVl3dWpqM1I4SjdyT2dRdG92bE9PQmdOV3RuNnNQQ0M4bmI2N0RmZFdSVEY1?=
 =?utf-8?B?ZndHbjhQUmUzLzQyQmxacUU4WkZ5M1JkQi9ML1pJbDVwOEdIbjMrWmhYNWo1?=
 =?utf-8?B?QSt0bWM5a1FpWDR2eFRqLzFQTkJGdjFVYTJwanhxWklWTnA4NEErU0QyOHM1?=
 =?utf-8?B?TXdBdVJlczBveHk0QWpkSXZYcUdXRGVPaEhYSzc4N1VxRG1zRjNOYWVGSmRu?=
 =?utf-8?B?SitJOFcvRFl3TWZKZ3BrNU5LbHlyQUpUM3BzeDRWcXNMdVRWU3pNR2UrbllL?=
 =?utf-8?B?eFViRllrMGN5dC9qbldzdnowaUJnV2g0Nk5PejVBVUN6ODlmdW1DNGFLSksx?=
 =?utf-8?B?TTJqVWgyUHAvY1VFQUNYeEc3SU10QlFzcjZ5ZzdLcGo1a3k1eksyRXVaQjEy?=
 =?utf-8?B?S0lMZGtNbDV4d3VoN0FNejJGK0dicFNiZXVpMHFkTHN6WFRCTFpFT1BSbHhI?=
 =?utf-8?B?ZklQSjlxeGlHaUF3Yzk3cm1WM1hYcFFMSDNQVHVBcGxua3hLTllEbjVHaVpH?=
 =?utf-8?B?SlpESEx5eVlTYjh5a2lvZFJRaHgxWXg1VGVrL0pabWJ6WjJQdVI3ZVR0aWdm?=
 =?utf-8?B?QWZ5MjVPY2hvaVJyU3BsbFpkeE52Ukk1SmFVd2N1RXFwbXdLMFc3alpsNGM5?=
 =?utf-8?B?ZUxxbm5iNjl3c2QxNXNPaVliMVoxZXVuQTl5V0JseUFNU3pTNHQrdE8zbkln?=
 =?utf-8?B?bmdkQzJhN21Dcmh0SGtEYncvVkQ2ZlBvcjBocDVmNmx4eW1KbGZxVnM1bDJM?=
 =?utf-8?B?ak1naWxYMGN4dENxNVlsdExDbExoWVJ1VkNrOTdyZjgyQ0FhMFpYVkVrQU51?=
 =?utf-8?B?dmlzYkRhaERUb2poWDVjQlZHU0NtMDA4Q3RqNVRHMGQ2Z1hnUTB5ejExSWNk?=
 =?utf-8?B?WVdha1BhenhZV0dWcmd3bzdXcGxta0tROCtyVytITU1zcUNTcnR4T2JySTl5?=
 =?utf-8?B?R1hIRDZwcWhMQktSTjFvSnpua3FaK3NlUURVR1IvanQvY3IrY0loWmxYZ1ZW?=
 =?utf-8?B?RFFaRVVyQ0lMV2cyd0svTlRIWXRNNXVqNHNZSFZEaVdhNHZCMHQrY3RNdUQv?=
 =?utf-8?B?eDQ5R3ZWZG5TTEZ6cnNtZ1dxa3lqVzJ6a3ZTRGZQT1FMWjVub2p2MXk3WXFN?=
 =?utf-8?B?L0w4d3dTSDF2MWhraW4rdDZYdUdnUmJMdWtHSDlSRWlFYm1ycXlTQVRkcWZi?=
 =?utf-8?B?ellVTld0OERzeXFacGtIaTB5NVNKbFBHaVc2b1lhK0F2b0h2RWVZMGlxWFo3?=
 =?utf-8?B?SytVbVdqR0lsUnk0MVBUYllxYXQrcHV2STNXQVdRdUt4TWNnNWlFQjV0dG5M?=
 =?utf-8?B?TXF2VGFFRWZHSXJac1dyUU1xSjJ6OU45ZmMxTmtZendKZTc2dzJENmtTdWtt?=
 =?utf-8?B?NWMxek1nWU1WZmI2d2Y1ampTalJHZDRxekNxVHNNV0ZsRUdBaTUxbkVDRDR6?=
 =?utf-8?B?bzdDdVg2aTdFTC9NOWRReHpmT0JlejV0TUpaTFJpdCtSOHZiUzBLUjEvQzh5?=
 =?utf-8?B?TytJZGVvTUhFNjhFVE81SlVGclRoRERRN0xqV2lEZGltemNSSUIwWkQ2TGlO?=
 =?utf-8?B?Z042NTJ6R1BVTU9xQXZzakZvUHRDTmk5WUVhbUFHM2d5TEdONDJBYzlFRHRQ?=
 =?utf-8?B?eGZpL3FhT1lZUVN4TnRiRXdGRzdjcTBxenJYbE5mRENyWDRJalRaNnZwZTMw?=
 =?utf-8?B?NWM5OFZwZUZkMm5Na1o0aWFlazEvemJwNGJGeFQ5dTlpdGQzNW1hQlhFeGhi?=
 =?utf-8?B?aUNhTEIwc2RRclpHR3hwMjMzUUM2cDNNc3RxMmFxMmVvdkdLR0VNRUp6NDBi?=
 =?utf-8?B?QUV0TlpHOVlrRTcyc2Z0TWw5Rk80ZUdPK3dRdUZkOXpLZjUrNWd1bXBuZXdG?=
 =?utf-8?B?eVViUFQ4MzI0Z3QrT1kzYzZGYVhmYTZ1VVZRbmFPVTVrcjY5M1FuZUxzNTI5?=
 =?utf-8?B?cjBXYW10TFBnZXE5SWRXR1FWTEdWTjBFdW5xZWdJa1pnK1FEakVOU285QlQy?=
 =?utf-8?Q?N8vMS7HGVrqacH7WP5ibCV0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8E96F4706E40944B53F0F4B36855286@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0ece58-c7c1-41be-6c3d-08dd443a9ad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 10:07:45.2378 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSK71xhzq7KnF6jTKOZJVR+jUAwaAZSh1Su1OktXZ4QNa44PZjzMfSqKtqFSwd1m0Glj0jVosFpv+kapuWxUmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1232
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

DQpPbiAyNy4wMS4yNSAwNToxNiwgV2FkaW0gRWdvcm92IHdyb3RlOg0KPiBEZXRlY3QgUkFNIHNp
emUgdmlhIEVFUFJPTSBhbmQgYWRqdXN0IEREUiBzaXplIGFuZCBiYW5rcyBhY2NvcmRpbmdseS4N
Cj4gSW5jbHVkZSBuZWNlc3NhcnkgZml4dXBzIHRvIGhhbmRsZSBFQ0MtZW5hYmxlZCBjb25maWd1
cmF0aW9ucy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogV2FkaW0gRWdvcm92IDx3LmVnb3JvdkBwaHl0
ZWMuZGU+DQpUZXN0ZWQtYnk6IERhbmllbCBTY2h1bHR6IDxkLnNjaHVsdHpAcGh5dGVjLmRlPg0K
PiAtLS0NCj4gICBib2FyZC9waHl0ZWMvcGh5Y29yZV9hbTY0eC9LY29uZmlnICAgICAgICAgfCAg
MjUgKysrKysNCj4gICBib2FyZC9waHl0ZWMvcGh5Y29yZV9hbTY0eC9waHljb3JlLWFtNjR4LmMg
fCAxMDUgKysrKysrKysrKysrKysrKysrKystDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMjggaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRl
Yy9waHljb3JlX2FtNjR4L0tjb25maWcgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9hbTY0eC9LY29u
ZmlnDQo+IGluZGV4IDgyOTUyNmMzMjk1Li5hNzA5YjcxYmE0ZCAxMDA2NDQNCj4gLS0tIGEvYm9h
cmQvcGh5dGVjL3BoeWNvcmVfYW02NHgvS2NvbmZpZw0KPiArKysgYi9ib2FyZC9waHl0ZWMvcGh5
Y29yZV9hbTY0eC9LY29uZmlnDQo+IEBAIC0zNSwzICszNSwyOCBAQCBjb25maWcgU1lTX0NPTkZJ
R19OQU1FDQo+ICAgc291cmNlICJib2FyZC9waHl0ZWMvY29tbW9uL0tjb25maWciDQo+ICAgDQo+
ICAgZW5kaWYNCj4gKw0KPiArY29uZmlnIFBIWUNPUkVfQU02NFhfUkFNX1NJWkVfRklYDQo+ICsg
ICAgICAgIGJvb2wgIlNldCBwaHlDT1JFLUFNNjR4IFJBTSBzaXplIGZpeCBpbnN0ZWFkIG9mIGRl
dGVjdGluZyINCj4gKyAgICAgICAgZGVmYXVsdCBmYWxzZQ0KPiArICAgICAgICBoZWxwDQo+ICsg
ICAgICAgICAgUkFNIHNpemUgaXMgYXV0b21hdGljIGJlaW5nIGRldGVjdGVkIHdpdGggdGhlIGhl
bHAgb2YNCj4gKyAgICAgICAgICB0aGUgRUVQUk9NIGludHJvc3BlY3Rpb24gZGF0YS4gU2V0IFJB
TSBzaXplIHRvIGEgZml4IHZhbHVlDQo+ICsgICAgICAgICAgaW5zdGVhZC4NCj4gKw0KPiArY2hv
aWNlDQo+ICsgICAgICAgIHByb21wdCAicGh5Q09SRS1BTTY0eCBSQU0gc2l6ZSINCj4gKyAgICAg
ICAgZGVwZW5kcyBvbiBQSFlDT1JFX0FNNjRYX1JBTV9TSVpFX0ZJWA0KPiArICAgICAgICBkZWZh
dWx0IFBIWUNPUkVfQU02NFhfUkFNX1NJWkVfMkdCDQo+ICsNCj4gK2NvbmZpZyBQSFlDT1JFX0FN
NjRYX1JBTV9TSVpFXzFHQg0KPiArICAgICAgICBib29sICIxR0IgUkFNIg0KPiArICAgICAgICBo
ZWxwDQo+ICsgICAgICAgICAgU2V0IFJBTSBzaXplIGZpeCB0byAxR0IgZm9yIHBoeUNPUkUtQU02
NHguDQo+ICsNCj4gK2NvbmZpZyBQSFlDT1JFX0FNNjRYX1JBTV9TSVpFXzJHQg0KPiArICAgICAg
ICBib29sICIyR0IgUkFNIg0KPiArICAgICAgICBoZWxwDQo+ICsgICAgICAgICAgU2V0IFJBTSBz
aXplIGZpeCB0byAyR0IgZm9yIHBoeUNPUkUtQU02NHguDQo+ICsNCj4gK2VuZGNob2ljZQ0KPiBk
aWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfYW02NHgvcGh5Y29yZS1hbTY0eC5jIGIv
Ym9hcmQvcGh5dGVjL3BoeWNvcmVfYW02NHgvcGh5Y29yZS1hbTY0eC5jDQo+IGluZGV4IDhmM2Iy
MjY1N2M3Li5mMTRjODdmNWM3MiAxMDA2NDQNCj4gLS0tIGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVf
YW02NHgvcGh5Y29yZS1hbTY0eC5jDQo+ICsrKyBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2FtNjR4
L3BoeWNvcmUtYW02NHguYw0KPiBAQCAtMTEsOSArMTEsMTIgQEANCj4gICAjaW5jbHVkZSA8ZW52
Lmg+DQo+ICAgI2luY2x1ZGUgPGVudl9pbnRlcm5hbC5oPg0KPiAgICNpbmNsdWRlIDxzcGwuaD4N
Cj4gKyNpbmNsdWRlIDxhc20vYXJjaC9rMy1kZHIuaD4NCj4gICAjaW5jbHVkZSA8ZmR0X3N1cHBv
cnQuaD4NCj4gICAjaW5jbHVkZSA8YXNtL2FyY2gvaGFyZHdhcmUuaD4NCj4gICANCj4gKyNpbmNs
dWRlICIuLi9jb21tb24vYW02X3NvbV9kZXRlY3Rpb24uaCINCj4gKw0KPiAgIERFQ0xBUkVfR0xP
QkFMX0RBVEFfUFRSOw0KPiAgIA0KPiAgIGludCBib2FyZF9pbml0KHZvaWQpDQo+IEBAIC0yMSwx
NSArMjQsMTEzIEBAIGludCBib2FyZF9pbml0KHZvaWQpDQo+ICAgCXJldHVybiAwOw0KPiAgIH0N
Cj4gICANCj4gK3N0YXRpYyB1OCBwaHl0ZWNfZ2V0X2FtNjRfZGRyX3NpemVfZGVmYXVsdCh2b2lk
KQ0KPiArew0KPiArCWludCByZXQ7DQo+ICsJc3RydWN0IHBoeXRlY19lZXByb21fZGF0YSBkYXRh
Ow0KPiArDQo+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX1BIWUNPUkVfQU02NFhfUkFNX1NJWkVf
RklYKSkgew0KPiArCQlpZiAoSVNfRU5BQkxFRChDT05GSUdfUEhZQ09SRV9BTTY0WF9SQU1fU0la
RV8xR0IpKQ0KPiArCQkJcmV0dXJuIEVFUFJPTV9SQU1fU0laRV8xR0I7DQo+ICsJCWVsc2UgaWYg
KElTX0VOQUJMRUQoQ09ORklHX1BIWUNPUkVfQU02NFhfUkFNX1NJWkVfMkdCKSkNCj4gKwkJCXJl
dHVybiBFRVBST01fUkFNX1NJWkVfMkdCOw0KPiArCX0NCj4gKw0KPiArCXJldCA9IHBoeXRlY19l
ZXByb21fZGF0YV9zZXR1cCgmZGF0YSwgMCwgRUVQUk9NX0FERFIpOw0KPiArCWlmICghcmV0ICYm
IGRhdGEudmFsaWQpDQo+ICsJCXJldHVybiBwaHl0ZWNfZ2V0X2FtNl9kZHJfc2l6ZSgmZGF0YSk7
DQo+ICsNCj4gKwkvKiBEZWZhdWx0IEREUiBzaXplIGlzIDJHQiAqLw0KPiArCXJldHVybiBFRVBS
T01fUkFNX1NJWkVfMkdCOw0KPiArfQ0KPiArDQo+ICAgaW50IGRyYW1faW5pdCh2b2lkKQ0KPiAg
IHsNCj4gLQlyZXR1cm4gZmR0ZGVjX3NldHVwX21lbV9zaXplX2Jhc2UoKTsNCj4gKwl1OCByYW1f
c2l6ZTsNCj4gKw0KPiArCWlmICghSVNfRU5BQkxFRChDT05GSUdfQ1BVX1Y3UikpDQo+ICsJCXJl
dHVybiBmZHRkZWNfc2V0dXBfbWVtX3NpemVfYmFzZSgpOw0KPiArDQo+ICsJcmFtX3NpemUgPSBw
aHl0ZWNfZ2V0X2FtNjRfZGRyX3NpemVfZGVmYXVsdCgpOw0KPiArDQo+ICsJc3dpdGNoIChyYW1f
c2l6ZSkgew0KPiArCWNhc2UgRUVQUk9NX1JBTV9TSVpFXzFHQjoNCj4gKwkJZ2QtPnJhbV9zaXpl
ID0gMHg0MDAwMDAwMDsNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBFRVBST01fUkFNX1NJWkVfMkdC
Og0KPiArCQlnZC0+cmFtX3NpemUgPSAweDgwMDAwMDAwOw0KPiArCQlicmVhazsNCj4gKwlkZWZh
dWx0Og0KPiArCQlnZC0+cmFtX3NpemUgPSAweDgwMDAwMDAwOw0KPiArCX0NCj4gKw0KPiArCXJl
dHVybiAwOw0KPiAgIH0NCj4gICANCj4gICBpbnQgZHJhbV9pbml0X2JhbmtzaXplKHZvaWQpDQo+
ICAgew0KPiAtCXJldHVybiBmZHRkZWNfc2V0dXBfbWVtb3J5X2JhbmtzaXplKCk7DQo+ICsJdTgg
cmFtX3NpemU7DQo+ICsNCj4gKwltZW1zZXQoZ2QtPmJkLT5iaV9kcmFtLCAwLCBzaXplb2YoZ2Qt
PmJkLT5iaV9kcmFtWzBdKSAqIENPTkZJR19OUl9EUkFNX0JBTktTKTsNCj4gKw0KPiArCWlmICgh
SVNfRU5BQkxFRChDT05GSUdfQ1BVX1Y3UikpDQo+ICsJCXJldHVybiBmZHRkZWNfc2V0dXBfbWVt
b3J5X2JhbmtzaXplKCk7DQo+ICsNCj4gKwlyYW1fc2l6ZSA9IHBoeXRlY19nZXRfYW02NF9kZHJf
c2l6ZV9kZWZhdWx0KCk7DQo+ICsJc3dpdGNoIChyYW1fc2l6ZSkgew0KPiArCWNhc2UgRUVQUk9N
X1JBTV9TSVpFXzFHQjoNCj4gKwkJZ2QtPmJkLT5iaV9kcmFtWzBdLnN0YXJ0ID0gQ0ZHX1NZU19T
RFJBTV9CQVNFOw0KPiArCQlnZC0+YmQtPmJpX2RyYW1bMF0uc2l6ZSA9IDB4NDAwMDAwMDA7DQo+
ICsJCWdkLT5yYW1fc2l6ZSA9IDB4NDAwMDAwMDA7DQo+ICsJCWJyZWFrOw0KPiArDQo+ICsJY2Fz
ZSBFRVBST01fUkFNX1NJWkVfMkdCOg0KPiArCQlnZC0+YmQtPmJpX2RyYW1bMF0uc3RhcnQgPSBD
RkdfU1lTX1NEUkFNX0JBU0U7DQo+ICsJCWdkLT5iZC0+YmlfZHJhbVswXS5zaXplID0gMHg4MDAw
MDAwMDsNCj4gKwkJZ2QtPnJhbV9zaXplID0gMHg4MDAwMDAwMDsNCj4gKwkJYnJlYWs7DQo+ICsN
Cj4gKwlkZWZhdWx0Og0KPiArCQkvKiBDb250aW51ZSB3aXRoIGRlZmF1bHQgMkdCIHNldHVwICov
DQo+ICsJCWdkLT5iZC0+YmlfZHJhbVswXS5zdGFydCA9IENGR19TWVNfU0RSQU1fQkFTRTsNCj4g
KwkJZ2QtPmJkLT5iaV9kcmFtWzBdLnNpemUgPSAweDgwMDAwMDAwOw0KPiArCQlnZC0+cmFtX3Np
emUgPSAweDgwMDAwMDAwOw0KPiArCQlwcmludGYoIkREUiBzaXplICVkIGlzIG5vdCBzdXBwb3J0
ZWRcbiIsIHJhbV9zaXplKTsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0K
PiArI2lmIGRlZmluZWQoQ09ORklHX0szX0REUlNTKQ0KPiAraW50IGRvX2JvYXJkX2RldGVjdCh2
b2lkKQ0KPiArew0KPiArCXZvaWQgKmZkdCA9ICh2b2lkICopZ2QtPmZkdF9ibG9iOw0KPiArCWlu
dCBiYW5rOw0KPiArDQo+ICsJdTY0IHN0YXJ0W0NPTkZJR19OUl9EUkFNX0JBTktTXTsNCj4gKwl1
NjQgc2l6ZVtDT05GSUdfTlJfRFJBTV9CQU5LU107DQo+ICsNCj4gKwlkcmFtX2luaXQoKTsNCj4g
KwlkcmFtX2luaXRfYmFua3NpemUoKTsNCj4gKw0KPiArCWZvciAoYmFuayA9IDA7IGJhbmsgPCBD
T05GSUdfTlJfRFJBTV9CQU5LUzsgYmFuaysrKSB7DQo+ICsJCXN0YXJ0W2JhbmtdID0gZ2QtPmJk
LT5iaV9kcmFtW2JhbmtdLnN0YXJ0Ow0KPiArCQlzaXplW2JhbmtdID0gZ2QtPmJkLT5iaV9kcmFt
W2JhbmtdLnNpemU7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIGZkdF9maXh1cF9tZW1vcnlfYmFu
a3MoZmR0LCBzdGFydCwgc2l6ZSwgQ09ORklHX05SX0RSQU1fQkFOS1MpOw0KPiArfQ0KPiArI2Vu
ZGlmDQo+ICsNCj4gKyNpZiBJU19FTkFCTEVEKENPTkZJR19YUExfQlVJTEQpDQo+ICt2b2lkIHNw
bF9wZXJmb3JtX2ZpeHVwcyhzdHJ1Y3Qgc3BsX2ltYWdlX2luZm8gKnNwbF9pbWFnZSkNCj4gK3sN
Cj4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfSzNfRERSU1MpICYmIElTX0VOQUJMRUQoQ09ORklH
X0szX0lOTElORV9FQ0MpKQ0KPiArCQlmaXh1cF9kZHJfZHJpdmVyX2Zvcl9lY2Moc3BsX2ltYWdl
KTsNCj4gKwllbHNlDQo+ICsJCWZpeHVwX21lbW9yeV9ub2RlKHNwbF9pbWFnZSk7DQo+ICAgfQ0K
PiArI2VuZGlmDQo+ICAgDQo+ICAgI2RlZmluZSBDVFJMTU1SX1VTQjBfUEhZX0NUUkwJMHg0MzAw
NDAwOA0KPiAgICNkZWZpbmUgQ09SRV9WT0xUQUdFCQkweDgwMDAwMDAwDQo=
