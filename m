Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BC1CD4F49
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0677583EF9;
	Mon, 18 May 2026 16:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="Lzh1hpEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D3A483FEE; Mon, 18 May 2026 16:05:10 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E881803C6
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 16:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhBmahWU2G1zAFRO3ntQixffKxdtw+lQpp5JeIXH0P0ymbV1vkMcMHVm129vBZtEaqLQTDGxZADDFXT5XPV23gZV1dx31CWdiwI5Cf7iyFmQKLP838/9ctrLAmrXjAoa+n+wbeysi0bLXdt2dQTxlMUBmI0Dif1yC5Yh7O+YXdaF/QbRJZYBiczp7ZJ8SS72zx1cBfnJAt9GR0ypG0l1N9NcRmrKhI06IVe9IV4rgqxkZvfhRN4koveA0OWvraYl4P4F8CiOgV7ALBJ4gvv7rBCcbwEs41evwvIySRvRwCjFdDbC1wgzJwOwJmy2kKoXCrr9Eh467JCfEs9pYotndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tbxce9dy09OoZ4EbKYgWdiUYrEVecjxcGgHGrL4Q2GE=;
 b=lPOzYDqS5cmvP0x2A07KJjoxazT2czm9B/QZcGrzs1+Av2SfaT5LJIASq8pYKAuxePVBejiiqo28sWm+NIUpbibsO8TWPHAbkmrsj1NPAkil83Z0cRO/tucWeJGQm+F5VmLDhoenWN6x3CQJtf6qxBbuLnWiIJotNg16O+qeIUChZ115BJcLE+eLUXfp2C+Cn1wvVMA/9sTQXEEIc8k9b+p2djA3YUlJwC74G857ew9UXwwzXZXbmWhlShEeel7jd9egCb051KfCIUCBUDN26GQh2wgcnD6irMKXeLQGmf1coLmvBX6el9Ct/K4QpHsDVXISLQPdBpOZw7prpjoSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=amd.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tbxce9dy09OoZ4EbKYgWdiUYrEVecjxcGgHGrL4Q2GE=;
 b=Lzh1hpEjOn3QaW/Wo7FZWvVGxIwb91Knh5KMhnkCrxc4U59jSXAK3qp1aoxnP/b8VGd6V2tv7IYbJ2DRdC3bS1nb3Bhr0zWul0fCnxbDrrUaXhBxl3wF+wY9v+urrR6j/f3tASd/T1CLj+Kv+K6DVO17S++g9Obm577fARWhgVUi5ZznmkZOxCFrIGO+PoNQjgVwKwFEUSitchgGRih2RrfO8ahKKpspOuPrqlna902IcAf+Rff4QiXSEEPARi7+U82voaRX1h/z5VDbrmOn8GK4RRO//sSPEqdTD5W6HXV8aV4mOZ8+zhC1a8w91nJ3903IvvKITlulubb3vhYfow==
Received: from DUZPR01CA0346.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::29) by DBAPR05MB7528.eurprd05.prod.outlook.com
 (2603:10a6:10:1a4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 14:05:05 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::61) by DUZPR01CA0346.outlook.office365.com
 (2603:10a6:10:4b8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 14:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 14:05:04 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.64) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Mon, 18 May 2026 14:05:04 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by PAWPR05MB10988.eurprd05.prod.outlook.com
 (2603:10a6:102:390::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 14:05:01 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%4]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 14:05:01 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Michal Simek <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "git@amd.com" <git@amd.com>, Simon Glass
 <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v3 1/5] reset: Add reset_reset() and reset_reset_bulk() API
Thread-Topic: [PATCH v3 1/5] reset: Add reset_reset() and reset_reset_bulk()
 API
Thread-Index: AQHc4rzbCDLskqqraUWKae54XuSMorYTl/zAgAAGb4CAABgoUIAAB54AgAAB5gCAABWDgIAAAOUA
Date: Mon, 18 May 2026 14:05:01 +0000
Message-ID: <GV2PR05MB11941B769B4CC8DCBF3E7E27E83032@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <cover.1778665323.git.michal.simek@amd.com>
 <b8229b9f7b357cf6013e8423831a9af1d69fefdb.1778665323.git.michal.simek@amd.com>
 <GV2PR05MB1194140D0CFDB4D8C63BB998183032@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <0f7c82f8-dfff-4c0b-84c5-41f189ee042b@amd.com>
 <GV2PR05MB1194186BCEE688E85977E22FE83032@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <12534d6c-6961-4fb7-80c3-d83c3f8d13dd@amd.com>
 <GV2PR05MB11941B4DBA7BBB814C32BFEAF83032@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <50aef2c8-562d-44c6-a8af-315a6266f07a@amd.com>
In-Reply-To: <50aef2c8-562d-44c6-a8af-315a6266f07a@amd.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|PAWPR05MB10988:EE_|DB5PEPF00014B9B:EE_|DBAPR05MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a2b894-7ce3-4b35-24ca-08deb4e6760a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|56012099003|18002099003|38070700021|22082099003;
X-Microsoft-Antispam-Message-Info-Original: qGahRY9Mv07Y6XBZQ9D7+HPhjk371wDUAwV8ESVMBkh6hXeZS6dD2P6/mDsco1KIduw8xgoYanata5md/P1/8zZDQWWOL2jb3Ci0AtCZtm30bjVp6y1esECRa8Lg4OwhuvId/NpD3Xn7C4/zTjxqUDZZ7WK81QYZPf+c1siMygOQcs+9p4VeHbk0HHq+vx4zYUg6dcj0E5DSTxZJroKkRWvnkhQjMZvIju2JKpWnbdOw324AZIw/A8wApR9rLtf8QozWUupnJYFsI2A4epIE4UUfwmrziPv6M4Vmci8JlCZjU78CtrswZAMK7sT+M71HPpdd2rvHY4lFjRq8qs0IwItlM/RZTqNY8k9T6d1LB0+TO3JLwhgopnwcMA7tWaLUABlZwzk6INFQnX7zhV+0GWbLs9TD8MMNX6Vn2nKjUGpkq6DMt5I9iiGCE9zKVxO/gYxcKcT4sPHw7RDQHDyJq3w+lQX7oMo2ywN2yUdTP0SFF3QUTEXq1icl2w+TL1fF0SeNWT9oxT3ryz+T+FWXilrJ91VuOAZQ3IrnBCSAft2DgiJuWHN94g1Wmi5rOLvVK/v812AJNHb5GoCXeyBc/exmY2fY4FrzBmUBRyzp22Quqyc9MWLiLJYVYzdPaapzbInPeA+0GbFiNBqqZydI5hjFeMaRO+3VVV2UB1A3LkcPie1Xxume3xaF6ga9RbfLtGEkKvfZrqXyk59OvSEiUqcuHWfLzKS+sQ5Z7ifMATl+NCFxvymJplQG94Q8EGuY
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(56012099003)(18002099003)(38070700021)(22082099003);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IxUJdBE8Li1fxPqis7AJIqyu4jO/wHaX4k3Ebkva+VMid/sazPUdsui9j3YoMS1IeF/hp9um7nG/StnFV3/mGaE/z9/ntgol33+/oop4ZNVTXO6KkwbW56NbDbQoVG8Hy5nhmNI3zDZlru1UDzaEZTx07b58Rg1owCq/qKpTxBGsOxUojbGxNYVPf91VH3Vl95eZF8hX2br+MhlyXCu45yNOC6o5hqlcExhEyLHgtn7RoVlRSpF0Aro2nt+vmsELNcdLhYVk3MDand5whxFbSG1lF357HxlJa+PPIBFgl2VaBN/yDG1Y/9MPDNbIIXuGhR3qECo1ZLcvSTUeCnKrPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR05MB10988
X-CodeTwo-MessageID: 8ff15939-859c-4a3c-9b13-f0c154bad2ea.20260518140504@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 513611f6-842d-4d71-4f7d-08deb4e67409
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|14060799003|1800799024|35042699022|82310400026|22082099003|56012099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: rWv/yqNSeJVQJFrQZfTaE5CLW3DTv+v3ZC0FG0hEFBNP4DgJei+V0BdqVxpsV/8c3FrxaU8Kepa70qvMa9WYFNLsEbK+GfftP7Zkx1RprU85vRoL87ZVSRfEOvmvT8SwLqb0Q1E7Fouc4rZTYiCOBgla/aSfAlawtlS9xAUvEGJxCNEWUubbHE5GsKvqTnva3yjRtB79cDjLiG8raJzcqYuoGJ7pyV7Xk1fYahwc92qS7CCs8xoCyO93dfZ2DmBYzoRliCjinkWYq48+6zGiYTzXzE+ExwlsQFvTwTPiJ+5dCximmIorntRzmHrT3A6nluQskhDd1pZuChmH+ZcU5+o35fCwutf1BNZQ+DEnzRNRbT03z1Hkt6mXT25cKdhBy6ns4UpTm+UtvCFrzgPL+1iGypg3E5mPkMgNCG36knMZXGvwFR12B1moe4lR3Sv6BCWPFFrqGYG0g9U8VdshcbwuZK+EAtpgW5k5xKxg0Pg+iFQvGcTwqmRVFDrmX4XMLPzXmSh+IjFdRJhR8NHqnD8kxpYUIdItN3aSh5giVdYfOJPEyQy1TZMCiazvnqoEyDsq7j0CN0DheqcQSmgFtqhvEpEQqGf7GjR/WT6ED7Lpm4t8O34e7y29eoV0Y/fX4a7bNxql6CY0Izs2c8g7FDJjqN5auS0L7FQRed0v3B/OK1F9hApO32Of5B+qvNJKnqY8NtQ8C5hyzKkz99gXH7pgam8BHAOgNg9boO2pDBc=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(14060799003)(1800799024)(35042699022)(82310400026)(22082099003)(56012099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c0OQJKTJv2fVKOTD7LEzUaf68DvWr2m5VsHBB4g20iPZuAAbEckaQuB0jymzftEhhiqu4ebTEcpFCR5dqZTJis8jMy7VBCWvP2LOzpWKDsoChbdEZLuHViSMba6Cq/dIludwiEIi90ZPz6Co1F6hUui90c75nQTUFrn93Dtd2/P6NwwfcqLgtKeIkPBsObYoQ0Dd9vujcYrLEZ80Zy5NaHTl94A1pDzTwr83GGisadY4sHYUTIhpwp+Z+yQKuSramgBpSLW99Hpk3yLo5M1m+XLyy9t1tValsjZRmij1outinqKblpGhBtSdiErNUjHUjuHB+1kvTLPzEXeRks47aiqpSwCSLKI0ZT+Dg1Gbp9nmGDT7xDL7GuOytqbrr+fNFsit8m+pb23VEUBoaGt2r5/QWlKiZzkJA3zTGKZ9ohiMNmZRnxSyutA7OKUlIn7I
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:05:04.8000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a2b894-7ce3-4b35-24ca-08deb4e6760a
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR05MB7528
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

SGVsbG8gTWljaGFsLA0KDQo+IEZyb206IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQGFtZC5j
b20+DQo+IE9uIDUvMTgvMjYgMTU6NDAsIE1hYXJ0ZW4gQnJvY2sgd3JvdGU6DQo+ID4NCj4gPiBI
b3cgYWJvdXQgc29tZXRoaW5nIGxpa2UgdGhpcz8NCj4gPg0KPiA+IGludCByZXNldF9yZXNldF9i
dWxrKHN0cnVjdCByZXNldF9jdGxfYnVsayAqYnVsaywgdWxvbmcgZGVsYXlfdXMpDQo+ID4gew0K
PiA+IAlpbnQgaSwgcmV0LCBzb2Z0ID0gMDsNCj4gPg0KPiA+IAlmb3IgKGkgPSAwOyBpIDwgYnVs
ay0+Y291bnQ7IGkrKykgew0KPiA+IAkJc3RydWN0IHJlc2V0X29wcyAqb3BzID0gcmVzZXRfZGV2
X29wcyhidWxrLT5yZXNldHNbaV0uZGV2KTsNCj4gPg0KPiA+IAkJaWYgKG9wcy0+cnN0X3Jlc2V0
KSB7DQo+ID4gCQkJcmV0ID0gb3BzLT5yc3RfcmVzZXQoJmJ1bGstPnJlc2V0c1tpXSwgZGVsYXlf
dXMpOw0KPiA+IAkJfSBlbHNlIHsNCj4gPiAJCQlyZXQgPSByZXNldF9hc3NlcnQoJmJ1bGstPnJl
c2V0c1tpXSk7DQo+ID4gCQkJc29mdCsrOw0KPiANCj4gQnV0IHRoaXMgd2lsbCBoYXZlIHdlaXJk
IGJlaGF2aW9yIHdoZW4geW91IGhhdmUgbXVsdGlwbGUgcmVzZXQgY29udHJvbGxlcnMgd2hlcmUN
Cj4gb25lIGhhcyByc3RfcmVzZXQgaW1wbGVtZW50ZWQgYW5kIGFub3RoZXIgbm90LiBUaGVuIG9u
IHRoYXQgb25lIHdpdGggcnN0X3Jlc2V0DQo+IGFub3RoZXIgZGVhc3NlcnQgaXMgZ29pbmcgdG8g
YmUgY2FsbGVkLg0KDQo+ICAgICAgICAgZm9yIChpID0gMDsgaSA8IGJ1bGstPmNvdW50OyBpKysp
IHsNCj4gICAgICAgICAgICAgICAgIHN0cnVjdCByZXNldF9vcHMgKm9wcyA9IHJlc2V0X2Rldl9v
cHMoYnVsay0+cmVzZXRzW2ldLmRldik7DQo+IA0KPiAgICAgICAgICAgICAgICAgaWYgKCFvcHMt
PnJzdF9yZXNldCkgew0KDQpEaWQgeW91IG1pc3MgdGhlICggISBvcHMtPnJzdF9yZXNldCApIGhl
cmU/IEl0IHdpbGwgbm90IGNhbGwgZGVhc3NlcnQgZm9yIHRoZSByc3RfcmVzZXQgY2FzZXMuDQoN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gcmVzZXRfZGVhc3NlcnQoJmJ1bGstPnJl
c2V0c1tpXSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAgICAgICAgICAg
ICB9DQo+ICAgICAgICAgfQ0KDQpJIGRvIGFncmVlIHRoYXQgdGltaW5nIG1pZ2h0IGJlY29tZSBz
a2V0Y2h5LiBCdXQgSSBkb24ndCBzZWUgYSBvbmUtc2l6ZS1maXRzLWFsbCBzb2x1dGlvbi4NCg0K
S2luZCByZWdhcmRzLA0KTWFhcnRlbg0KDQo=
