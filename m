Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49341CCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 07:19:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D946D8334F;
	Thu, 23 Oct 2025 09:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="RxHI1g+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05764835B3; Thu, 23 Oct 2025 09:19:06 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBD1E8323A
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 09:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzK1JqGMZv/0boZkkj+MBXt814ZcPsFCVkW7z9QMX9bPO31B4cHQ44XYNgCExsBZxwf7umg1/6KBlacx+++1xq9eYA0LOu+g59wSqKm1DaHLwzKlvGXfyB4l3NIIb3y+60NTyFcp//n76DVBxIG0Y59tZzc3QAQ/cP/9bRr9ZAkQ1Vz8jvUmFM+9dP1V57IxKJLz70XKr8j49Kklsx8W0fhO4TqE5CB71Rv13dGSgk76EFOnQu4egKqB2rfIMexTMMbfFRpHWWnmrvfNvZRuY+ugtC5eN3xSs8LyQaheX0lAfK83qZUUNthznGNUODOMhKdmx4tQWv+IW96zHY0SWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL+wJXZfneheUsxezStJniAZCegUD27/koSgILyNEmk=;
 b=fYoMXDygf5BFmLBcvtAnR3bf1r9BdyyP3e9+LUvDV2wmBOjdCmCmAfJfmzCxvyQ1CFgJpQfnCK6ZoYuhfLZ5WPNjbTXesmyEXV/HryBhkwjMQTb5Njo1+608tt9/SoAJ5t5MFWK3DlMJEstdnklrL65Z7qzHSqtHH4+SM8XC/Atj4Bp2eLIWgnvHlO38UE0fY6DBGwWFV+P/a1A7L0PUj1gQeJLPDpexqDcG3jh6IcljqxeYu04Rm304w59Mfv9XLLINQT1dQmxxlOHro6b5V8ks5+OZZptzSNSSnlBtDUNmsEAZOm9cq/DGoJi2gPy9dZpXGKdwK3jYyT2klFea6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL+wJXZfneheUsxezStJniAZCegUD27/koSgILyNEmk=;
 b=RxHI1g+5uDfdOMmUeBJ2hL8Fst24HuAR+qmTe2tPD46tJwafFCaHcRVpk/5ox6RjZyy9seacc4R1Yw8Sy8PoOIGQUlumQFQpk9TOusE4FFLuyj+WHlG7j9P32B5vHzGSNxVA38ZBwdGrCwpk2caGOWqv+aLdafGcHFA34kt8tdfEcHmryqaJ3LkD9rRPpPhMdJ2SUVPFZeHWECYyPdJhjZDkOhMAwPJAEoyak6eV1m75GamhkCeBL0WJ9Wbf9dt4oLFs0CqgSh96zuRgWvIlkRp0H3uBYAvPvzgTdZIVKcOjPnTWZP9dtS0gPpIrqs6AOWXe8YT9ZKeWOxq4rY6lSg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by FRWPR04MB11271.eurprd04.prod.outlook.com (2603:10a6:d10:19c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:00 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "marex@denx.de" <marex@denx.de>,
 "tien.fong.chee@altera.com" <tien.fong.chee@altera.com>
Subject: RE: [PATCH] mmc: sdhci: Add SDHCI_SPEC_400, _410, and _420 version
 defines
Thread-Topic: [PATCH] mmc: sdhci: Add SDHCI_SPEC_400, _410, and _420 version
 defines
Thread-Index: AQHcQ+MtfxqA1IIJRUaAyvNbOe1UDrTPT7qQgAACj4CAAAA9MA==
Date: Thu, 23 Oct 2025 07:19:00 +0000
Message-ID: <PAXPR04MB8459E5564C640E86A4CB515888F0A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251023060614.6441-1-tanmay.kathpalia@altera.com>
 <PAXPR04MB8459DA42188F3B88E21C007588F0A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <73d9ad0c-08b1-48c9-b890-5f1acd560994@altera.com>
In-Reply-To: <73d9ad0c-08b1-48c9-b890-5f1acd560994@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|FRWPR04MB11271:EE_
x-ms-office365-filtering-correlation-id: 3b12112b-238d-4e43-2114-08de1204705f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?N01POGpEK2k0UjVIOTBpSy9sbFVyVnNxN3BiR1EyZ2w0RkZVQkM3UFNleEpm?=
 =?utf-8?B?Tk5RNk93UzR0T01xakRjZ3ZwamREL3A1Nkhac3dWenhyNnhZMWkrbzFzdjY3?=
 =?utf-8?B?S2FUSnF6TTRVaWV4ODIrUnVhckJPWmpTL1VGdG1GRjU1UEpwdkkzd0x1RG1w?=
 =?utf-8?B?aUJsWXU3YUo2bDROTXZwUTY0U2E4dERTZ0JVU1NYdGVaTjdyTVNxMFNhZThz?=
 =?utf-8?B?RlpsY3VodHdBWmdzTHJ5RncydmhXa1lmeUNGZ2o3VUJnSkVtNU8rTkZwcjVn?=
 =?utf-8?B?TW1aR0xzMUJnQ0xjSW9Hbmp5RXJ0ZFU4cVNxSnNrMmZkODhkbVFwSllYNita?=
 =?utf-8?B?aExjOFhEVzlkQ3NvSUlxUVIvRFRJSUVDcndJUURxczlXdTFiTi9VZDhTU2Jo?=
 =?utf-8?B?Mk53WnhDNE1EMEpET1IyM0kzazladTFHRzRBU3lVY3p5cXlEUEZURngzV3Rh?=
 =?utf-8?B?ZStyb01nYlpPZzBldndhOGVwa2lqWGRrSzZNWmFWUjQyVXZ5cXZFc05pK0hj?=
 =?utf-8?B?ZW9wK24zNVEzVmYxc2tHTFhHcjFHcXF4Zy9EL1p2cmtTNGpVK1Q5OEF5MXRn?=
 =?utf-8?B?bFlYb2Y2dm5CYThkZUZXL283K2lORnlQR2kxRC9vUS9BNzNOMFVoTWMyMnpw?=
 =?utf-8?B?Qjk2c3VyUXBtYTQ5Z3NLaURGVkR0bm8xTkdPK1FoWFRSTGE4OE1vb2ZFQy9U?=
 =?utf-8?B?YXllVzNqZ0hNd05lWW5qSTNVZUNNbTFlMkgvei9SWjFad0RvWERUY2JzSWlz?=
 =?utf-8?B?TjRvdVY5b0g5Nnh3NWZQbEU1VXpYWC9uKzJjL1JETHBEK05OR1hrWlFNNjBQ?=
 =?utf-8?B?NTV1QzZvZndTeUFPWTQ4T0xSUnFaaWk1SHhoRVdDeElFck5SNlliR1JiNlBm?=
 =?utf-8?B?bVVXWk50TC9LQ29sMmFtMmlYaVpUYUovQldlbUVOeXU4SlFPamRWYmkwNlpp?=
 =?utf-8?B?Y0M4WVJLWmowc1p0YUZpbllYT1VSaTNOaFRxS3FVVVoyZ1paeE5OWElEclVx?=
 =?utf-8?B?YzM5by9FRmg4VnN5akpWdk1UeW12NU5yQnFsZ29kQmRrUEx3cFY1c2pCMStm?=
 =?utf-8?B?dkxCYWxMR1Y1Q2lxSGxMK0QxWHNwcytuSDFpWTZrYmZSMDRhY3VuL3BBQkl3?=
 =?utf-8?B?cEJQRFE5YnVXVzZkZWRoSWRlZmtXL2Nwbk43YlVqcEZHbDBHYks5MkZLejdC?=
 =?utf-8?B?Yi8xWnlhaG1QNkpYNE1oVEtqdHVkUDBwWlNndlZUNDhHdUFUMGl2Q2JYelYv?=
 =?utf-8?B?NGJmbXBINnlkbWx4L3h0ZCtaSlhjK3haUnpQd1l5NFVrRFR6TFFNZDhSSSs3?=
 =?utf-8?B?Q3ZRUjh5YUtER0tmZ1NYbmkxOERma0s2dERhcktFOElLM1ZsMnBuL2t1bVph?=
 =?utf-8?B?RGwzWHBjdUx1b2pTSFk4ZzlMamlobXRzamRLTG9FZmFkcERhOFFWcjZTbTVY?=
 =?utf-8?B?bEc5clFnNlkvYVBtaEQxcktvWnBKUW5scjUxK3pGSCtzUVF3b2NLeDlDMXBy?=
 =?utf-8?B?NHdrcTZxNGFkNjNCa3plQUJBMWwyd3JvT0FJYkQreFZ5Q0FsMG0rWFFWbWNk?=
 =?utf-8?B?L1F5MktTam9ESVBOc3MrVWIyY2ZZOWVyenYya01Uc1h0bkd1aklIb2FHN2Fu?=
 =?utf-8?B?YkMrd2pkQ2RFVUcxT0p0VHpkZWxaRzd0bmRnMldUekNUaS9zd2FUNFFtSGwr?=
 =?utf-8?B?S0tKNnN3NlhCU0FxM0hGNDFkWldobm8xMVdUYUhYSkxnZXo3UCsvV0dBSC8r?=
 =?utf-8?B?N2Z2UHV0dEZoREpKQW55VE1leXlPRDJybkV0WW51aGZzVWxWT0cxQWFBVUVD?=
 =?utf-8?B?dHEvUmNIUWcwRTF2Q3VVdXBqL01aWm12ZGVwbUh5aTdVUmV4SzVVa0tJYU10?=
 =?utf-8?B?MHFOUGFtWExBMEJLUzJnYlZLWVFHUnY0TG13ZmRJbW5BMkVtc1E5eWhxcWw1?=
 =?utf-8?B?ZHh1SERrMUhseUJwcXJpZ2UzdnBITkZZbjFHWnIva2tWR1FBMm54dkFON3JE?=
 =?utf-8?B?UHFoc2VneUR2WUFXNS94LzA5eEQ5UndrVXlBVjJTZk1UMVBBNUpFRFNObnVj?=
 =?utf-8?Q?75dbFy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUZ0OGdzK0tqTUhSb1ZzalRoejd1cXM3NUNvcXY5THJKTVUyVGVWdFNkUHpk?=
 =?utf-8?B?R2VuUkVPWGFmbElPOUZiVHh4ZGpwVE5tUkN2dnB3bDkvOU5PUytibGtRVHFC?=
 =?utf-8?B?QlZMWTllVzczZWhVZWEzOW5kTW5vY2RHcC9uMlRldnc4T2FCcVgrZ0k3NHAz?=
 =?utf-8?B?Y3c0S2o2eWtrSGQzRnlkdGVxcnlYV2FQcE1DUkF5Qndsc1RTeTVNSGd3a1k0?=
 =?utf-8?B?QTAxbHk1M3A2UWoweXdVWDNpVHVLbXV4a1BIaWsxNHNaaGtRQ1h3VWdOa3VS?=
 =?utf-8?B?K1RQM3FTL2drYXhQWGIrQVFqaFF1Z0xnaFU4TnloT0JzSnF1d1lvUkFvakhq?=
 =?utf-8?B?TG1SMzREZ091eTRxV3huQnVLQVdDR0l0dDJPdmZGc0YxY0U2cGM3R0NURnVO?=
 =?utf-8?B?UFlnRUQ5SEtLdzZKYU1OQys5Z2pQRm1BWE43K2toQ2ZmV1kzTHh3T2VNRGFr?=
 =?utf-8?B?bUpUTmc1Y01wb09xQjlOdVI1K2V4UVRrUThJWFhmK2dIZ1I5ODlxRVBUV0hQ?=
 =?utf-8?B?WEI2VGM1RGlQTCtRYklBWlpvVXY3UThKTGhmZ3llbmVYYXJwYzYvNzRDdVFH?=
 =?utf-8?B?dmlGY0tJcjh5MnlMS3FJcldJTzVLblhrVXF0eFFXUHBiMUpWZ3QrSVY0eDRG?=
 =?utf-8?B?KzFmajkwVE5yb3NuZXZ4bGFXdmpxN2V0ZHFJQWxySThmczRoSWJBSmVDRTJZ?=
 =?utf-8?B?dXYrRC96T3dlNzBFdXZBWitOd1N5WW9Ea0E2YTMvTndDT2d3SHBYN2hDQzFD?=
 =?utf-8?B?UWlGajFid0F0LytGVFd4L3NTL0tnZEFTcm9sR0ZZSkk4bGdpUTZHOElWaTdW?=
 =?utf-8?B?WFhDNExmVFlKY2dodTE4MXovTmx3MFhMZDFGd3pqbFFhOU5tM2loNHA3Tk5u?=
 =?utf-8?B?SlhuL3BGVjFUazY1S0FEbWl0MzFqSzYzdFBUNDRpQ1A3STlWRmRobERTbkN5?=
 =?utf-8?B?S0l6b0t6SzlRUFI0NmhQUnFZWExMdHpxSDRFcVUrOUFJNDZuT1A3aUJFQUtz?=
 =?utf-8?B?TmJYVHR6RUJBRzVYWnI0MzF6akg5U0UxRHR6VnpDRDhyOHBsbUY4djYybUty?=
 =?utf-8?B?RGdiWHJYRjZkL2NmR21sV1g1c2NHcXllMnllV1NiU3JWRURZSTFneFV1RU9t?=
 =?utf-8?B?bk9LUE1WSVhOZndCOWlwV0RkWWp2SHVUK3U1aktPbWVIWEFKVVFEM0szbEhi?=
 =?utf-8?B?NzhnR1BZQmtaRUtjbmN0dU9WeEJvdUZ3Z3ZlenAxUGVkWVFqMUo2UnRvcFVF?=
 =?utf-8?B?RmVyaUs0TG9FQU1rYzNwQWIyaUY4NXE5NDBsRUlvaUNCalQ1NGFYZjU0dFND?=
 =?utf-8?B?eVl2cEsrcnlMN0ZpYjU2b0ROclVXRjNTeGtZQlN1U0J1Sm9ZN3dhazllY1JG?=
 =?utf-8?B?TTJqQlNYRjFGZXM5alNTcTdvRFNwZDA2aVM4RjBqeHZuMVBFeXdjaEdFczYx?=
 =?utf-8?B?eEM4WVQxSThOa2wyRldabDNJOUU0ZkVCb2thUGozYzV6b0ZJLzFEakpwWVY5?=
 =?utf-8?B?aVhoczJjT2dDRDRpdFlnaG4vbUxJck1IdWpyNXBmVjFMb01PVFY1dWs4V0Jk?=
 =?utf-8?B?czBzNzJhQ2R3ZFBwRUowQkluWUNCdWVvakNuSFY1UWFJY1dYNkFydmdGMmV6?=
 =?utf-8?B?V3JDSGZ1T2FUc3dhN1VzZGZCSk1Sd0xVVTQvZTV6KzF4K0xIQjVjQWNJaTNl?=
 =?utf-8?B?SjQ1NHJlS2VtSFBWcGU5V2JUcGQ4Nld3MDYwcUlCQlI1OHlPYm9DTmh1eUUv?=
 =?utf-8?B?ZnhZZzRzUHQ4RmN5V2FPTWs1R1RqeVVhMGVhSGVCOUo5Z0FtSTIxdWh0Q3Jl?=
 =?utf-8?B?U0ZoRVQvOFpZd2gyQkdvL2RLRmg0d3QxVjdQNnZOWjNuOGxibExWZDkvM21F?=
 =?utf-8?B?ME9GZ0FvMmRLMGF3UmdMS2pxMi9LR2VsNFJDRnBkd3pVbE9Jdjh1OTYvUVVj?=
 =?utf-8?B?OGxUNUZQRm5sVHR1UE94MXNpRHJnMzZPN3YrM3VubUVJWDBjeGtSZ0hmelVL?=
 =?utf-8?B?cmEwd0RyY09YVWhHU3FyUVZHR1RscHdvY2phSHFPazUwV1pMZkk0Q2ZMeGxJ?=
 =?utf-8?B?NjVYYXR4UGltME1vQlNOMFhZcGFVNmNnL3J0Unpad25hMVNhYkF0dVBPTUtZ?=
 =?utf-8?Q?Xgqw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b12112b-238d-4e43-2114-08de1204705f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 07:19:00.7496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qi820mh/QUED+MDhlgH+j41UENszCS3A/OGTtdmIJ5uLDSmjRaNbV4XMzznJTi51nqga81P+n+qKxSghjNBRdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11271
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

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBtbWM6IHNkaGNpOiBBZGQgU0RIQ0lfU1BFQ180MDAsIF80
MTAsIGFuZA0KPiBfNDIwIHZlcnNpb24gZGVmaW5lcw0KPiANCj4gPg0KPiANCj4gSSBhbSBjdXJy
ZW50bHkgd29ya2luZyBvbiBhbm90aGVyIHBhdGNoIHNlcmllcyByZWxhdGVkIHRvIFNESENJDQo+
IENhZGVuY2UsIHdoaWNoIHdpbGwgcmVxdWlyZSB0aGUgdXNlIG9mIHRoZXNlIG5ld2VyIFNESENJ
IHNwZWNpZmljYXRpb24NCj4gdmVyc2lvbiBtYWNyb3MuIFdvdWxkIHlvdSBwcmVmZXIgdGhhdCBJ
IGFkZCB0aGVzZSBkZWZpbmVzIGFzIHBhcnQgb2YNCj4gdGhhdCB1cGNvbWluZyBzZXJpZXMsIGlu
c3RlYWQgb2YgYXMgYSBzdGFuZGFsb25lIHBhdGNoPw0KPiANCj4gSSBpbml0aWFsbHkgdGhvdWdo
dCBvZiBzdWJtaXR0aW5nIHRoZXNlIGNoYW5nZXMgc2VwYXJhdGVseSBzaW5jZSB0aGV5DQo+IGFm
ZmVjdCB0aGUgU0RIQ0kgaW50ZXJmYWNlIGZpbGUgYW5kIGNvdWxkIGJlIHVzZWZ1bCBmb3IgZnV0
dXJlIFNESENJDQo+IGNvbnRyb2xsZXIgc3VwcG9ydCwgYnV0IEnigJltIGhhcHB5IHRvIGluY2x1
ZGUgdGhlbSBpbiB0aGUgc2VyaWVzIGlmIHRoYXTigJlzDQo+IHByZWZlcmFibGUuDQo+IA0KPiBQ
bGVhc2UgbGV0IG1lIGtub3cgeW91ciBwcmVmZXJlbmNlLg0KDQpQbGVhc2UgaW5jbHVkZSB0aGlz
IHBhdGNoIGluIHlvdXIgc2VyaWVzLg0KDQpUaGFua3MsDQpQZW5nLiANCg0KPiANCj4gVGhhbmtz
LA0KPiBUYW5tYXkNCg0K
