Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F438ED7B82
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 08:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81846841A2;
	Tue, 14 Apr 2026 10:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="IdHeMaEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A39ED841B9; Tue, 14 Apr 2026 10:25:26 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7447584181
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 10:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1gIQ7nyMmhMxbF2NPvhLv3aDKGHqOgSqcNFc65t3qUrJsQgdwPAQQLtYrREb5Tt5INe9aLmYlFZRSBz9agKUhCymCGdshxINXUFNXR70ciQiBvZ4AE+SeglkBRCRNjA0TLYsl8gk2qlTrjyE8qE00MwWEwFDPWKgE51+4o2zRcunkLsQ3bU3rPakZ1YQZOWVxNN3k76P306m9hVYKFKxT3iPkJFdrsxQYQbOEUW/wcsLJmOb3SuLFldxnrBZteTcoBwr3XsjonL3w6k+paKuQxeijEgNuSL9Gliu8rAfAkOuEvxU9H/RTz4QF37rLMSgjlEYB2A+CXTfLnAub3g8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7u+Cb+nWuHRl80KslBYQSIZnUdpNFT23QPSe+7KHzao=;
 b=VMgkCzmuIQ+xTSCgB7myx56fdW0Ix3/WE5kS4GeVIRdkglE6hftSVMKhlO+GG3zzEzh17h1nKwubGW9iFd3LZqIlJ0COrQp+whKdtncrkdRd6rvhaBgxlRBWudyha4y799CVgzOEiSKhLM4qHd/BRh86xx+Jbd/qRKzVpip7S+o/wvpSSVGfQJZGdJZuQJEwaLtpNdUIpgeA9i4L8r6f+7KXGn7eg81hfuCj2FBnuSIeKj+7TAiZrvnsBfPtpkDsOzFKsO6nT49KcjoHcsWfJg5MK2krS1cOLlF2L1Coc5cxtK5l5dAWhnaRLb2lJQgfuiyG0M2IErYYSBHg0vEucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=baylibre.com smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u+Cb+nWuHRl80KslBYQSIZnUdpNFT23QPSe+7KHzao=;
 b=IdHeMaEJoywfZGftI8QJ0SN6g60Sk3HEe1RsgsGGCN/ZkH68rOtGD4KBAfuGWTLubeKe/7P1NXNllSZrxy7EQmD2shWPCAPChrAU/3FI1ICRdle+z+/iO2OCmQ7AlacFC1cBPRXAL+KilZZjxuhSHtzVJY/ERgR2zZuaKe8vC5zmms9VtIuDuhMqiDl+N0Ybie5cGe+JJOOjkxwYFlnkGlHvlzFzffjK422+nYvKC65QZSvnNBZhNflUAbG3FmV1G8lrOjMacZI4IsbdgcKq211kKrc+6YANOPmcaS0HFOPnzMiv6xpTeE9SnZWolDdn4G/Rcy2g9VPKVpyiv70ZMQ==
Received: from LO4P123CA0187.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a4::12)
 by AM7PR05MB6929.eurprd05.prod.outlook.com (2603:10a6:20b:1af::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:25:20 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:600:1a4:cafe::15) by LO4P123CA0187.outlook.office365.com
 (2603:10a6:600:1a4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 08:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 08:25:19 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.55) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 14 Apr 2026 08:25:18 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by DB9PR05MB7692.eurprd05.prod.outlook.com
 (2603:10a6:10:1f9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:25:17 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%4]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:25:16 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Markus Schneider-Pargmann <msp@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 2/4] net: cpsw: Remove compat string argument
Thread-Topic: [PATCH 2/4] net: cpsw: Remove compat string argument
Thread-Index: AQHcyNnklLG+3/lS4EC2//So5z8jRLXctaDAgAFxqgCAABYVgA==
Date: Tue, 14 Apr 2026 08:25:16 +0000
Message-ID: <GV2PR05MB119419B55DD47889763A53EED83252@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
 <20260410-topic-cpsw-switch-v2026-07-next-v1-2-c914724b13e4@baylibre.com>
 <GV2PR05MB11941D5BAD20EA6CC43F2C3F783242@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <DHSONMPLU5N5.AY9KGH9Z6WFD@baylibre.com>
In-Reply-To: <DHSONMPLU5N5.AY9KGH9Z6WFD@baylibre.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|DB9PR05MB7692:EE_|DU6PEPF00009525:EE_|AM7PR05MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d04171-6ce8-4a44-b2b3-08de99ff5d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: hjPKykCTwyAcZs+rYGt8XVEHaPf+7oVfl4+te0Lc/vOMyFukDrpl8JNehbS8jubV1Ns+xerPldthrcwKb7xez79EpvZNH1lug0ZQtcL5JTiGRD79v1si84GMm8YFLUesjon0alwcSvuvO4JWAHv+b/vbESYU4k3cgXnkLwWteefYyNWrE5dqkWwrkFHYSyXSxFZNP7/PvCgMFupujtghYeov/2JqN3WoL2t+jzPH2XqlfM32LWIq9Ls+4M4b6ZS3lrkAGqtdqU9UsXJwI3ypnOjufBRiek1UO9xZYy92aKaU041Opj8+bczaCTrGArFGk/ZYtZdXkgkw0uXHEtGhx0TA/IXI+GZF5NsAeDRCrv8zgKTwqq4dvu5yW+M6+cFYypqL9AKU7meMkaTCLr7h8bfCHmWPzLJ+KaXxVz4GwC+Zo3+pc4408zjNsN594QsZIzXBD+KydDnjfgt1oGR7UjU6NU8gjAuD7/g7oi2vxxryziTbRSedkV53TCj3k1oCbh4weQWo8IakVWCtAj9yuDBTInp810+B4HCrED5zCASATmvOCl+o6lAUvziitzKf7daT4UY40CcST4oIAW6Q9LNYLJHSX+voL7D3ZqHoGr7eKqcjnu8YwMtKpewVGZ9O2Acuy6x/qEF7w9O9dq4peltNVouNJQXia996SKJeHeXxbKz7XQ1S0b7fAxTMROGnrw7jsOFGVhX5ZZDVFjYwqtoChw/W/v8BUa0g+cNQULzOFrSJqfvKETOCkSdKH6LEmVb7GItmiMCuutlv3OhIS9UXAR9m3ug42x5TyJ8sJQI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: R6eg2Cs2DUnVyDdLzSy9ARLDqm9itvSPColqcH6xp7shKbkqCrBkVo5e/h/6kdgARbOSSE+ngPeAELegfmd000hTrZWTDypKSql9Iemd0yLh5vJxoIVf4FXtoVL1DBfGk6uiuGIbrV75ND/VRDigiUWoEndO+nbkgezEts9OEzfEXJwnxOa+mRXywInNIU+Ogz5fp3ouJ94S52XtpOWwXABcz57FK3YlM490qZjZR/TT0iVLytLLYmC861KuorJkKloMdoIopzbfOltVnhVrILME4eDUulDw1TqUxTtR8eJNOeseeW+yiL7GFsidCI6ZYknIfn3E7q7EZSfnQO9mfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB7692
X-CodeTwo-MessageID: 182d626e-81ad-4f75-ac7d-47cce6aca80a.20260414082518@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6fe17264-a4f2-4ebc-d27d-08de99ff5b97
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|14060799003|35042699022|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: XI6z7sn3h0MT1FEd6Bo2x9C6j+IpkJXbfReHcOM/QzU2Rsf2+FFduZJ0W4nK5lCeWfRR8LfxZ8nptHg0M6JxQtfBzk1QvmeYGpEZOEuLqr4rF+Jger/wjUZbzAxfoKEwEsAjvl7M211pmSBVoFzxaF9xk8kX978lruuAZMSO7LtJKXpHszXc/Ystqzisif+h7cUm+7vYGinx0oDqgRX/NMCkQmCVq+b/b3HEGU0BUIvHnZK8WLRgo7Mie7CuU9Th4ACZj7v7Gf5jHsG/tz7/CJAOJpFcj5AN5GhO/PpkkIRnHGfa0Q7eBTFckQnbZwb9ovIJN/8z9+E5fXXn53G5P6Hmt/P40kFCg7F+sXRjCMKyEz6uFHmtTyNWszIFsBgm66JSQsxV8quM2wN/gDtX15TGfumcR+DeH3HJnHtVgmNyYb9fo1YOaaicZ9sl4DvhfcrizFy8A++BIyu+XVbOZx2TMjJkgSUoc+5BrBblps7lafTm5cKc549h8C995c1rd5QI8f6sCpEEhuk2qII/wZbsBXGZrApexbEreG6lnP9H9xnawIGJLD58RvPdeTgNfbhsJvUefdgCmLEZEiXuiec0oQa4x/r8lY3CZB83EmREs8G3V0iBKledqtJq7yE0jmSwJguWYzCnBTyV+V7B2oHV3oivUzdYsLIQhn/pwDzmg3dz8J33eve8+mMYkZoFp/82TPdmulTzfW2HBIWjqFFK7shquuv1+HjWm7ZM1YRtwCIxvx9j2SzrmYQ5xdR7RT3MiuIqfDEOQWuAW/RBDQ==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(14060799003)(35042699022)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6DLLRbCOqI7xpS6/OVogmx/cXr1W7UM9I1tfl1qJ5f1iASVtC4qXMjYacMkQdcWqh88tLShOKl/fgrUZ+nsSLlDVchCbF2wRw4bbMxnY3ghY/H9ytzcMAgq4eM4tCc+StPyryAo4mq/hAIeAbne8AbeM0OaAqSlIGiqA00bBdF0UW6hJ80gJtgjCCD1+19vwskU/40FdTOk/DD66YlzpjcrCj+ujQK4dDi/zzQu9P0oee/UQ9DecF0Abs2HQKOGWpjpglA/jasun+Sl2BQ0MRabzjTlbi4XXcNBUaXcb2ZCmeIWSUAspzlgd+3xXo40yCVUI22rTofm6dl7EFq512CjP3Y440MFtF/VFwqRPCTaaA1E/JipOxt/Xl32x1Y85kHocMUtQUXfGBn3nIkx0zqyha9zzvI9BYwDFDfLssXVCsv0stab+0De/mxxMf9Ke
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 08:25:19.8044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d04171-6ce8-4a44-b2b3-08de99ff5d93
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6929
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

SGkgTWFya3VzLA0KDQpUbyBteSBzaGFtZWZ1bCBzdXJwcmlzZSwgeW91IGFyZSByaWdodC4NCk15
IGNvbXBhbnkgZm9yY2VzIG1lIHRvIHVzZSBicm9rZW4gc29mdHdhcmUgYW5kIHRoaXMgd2FzIG9u
ZSBvZiBpdHMgImZlYXR1cmVzIi4NCkkgaGF2ZSBub3cgdHVybmVkIGl0IG9mZiwgd2hvIGtub3dz
IGhvdyBsb25nIGl0IHdpbGwgaG9sZC4NCg0KT3RoZXIgZmVhdHVyZXMgaW5jbHVkZTogcmVzZXR0
aW5nIHRoZSBjdXJzb3IgdG8gdGhlIHRvcC1sZWZ0IHdoaWxlIHlvdSBhcmUgd3JpdGluZyBhbiBl
bWFpbC4NCg0KS2luZCByZWdhcmRzLA0KTWFhcnRlbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IE1hcmt1cyBTY2huZWlkZXItUGFyZ21hbm4gPG1zcEBiYXlsaWJyZS5j
b20+DQo+IFNlbnQ6IFR1ZXNkYXkgMTQgQXByaWwgMjAyNiA5OjAxDQo+IFRvOiBNYWFydGVuIEJy
b2NrIDxNYWFydGVuLkJyb2NrQHN0dGxzLm5sPjsgTWFya3VzIFNjaG5laWRlci1QYXJnbWFubiAo
VEkpIDxtc3BAYmF5bGlicmUuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IEplcm9t
ZSBGb3Jpc3NpZXIgPGplcm9tZS5mb3Jpc3NpZXJAYXJtLmNvbT47IFRvbSBSaW5pIDx0cmluaUBr
b25zdWxrby5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi80XSBuZXQ6IGNwc3c6IFJlbW92
ZSBjb21wYXQgc3RyaW5nIGFyZ3VtZW50DQo+IA0KPiBIaSBNYWFydGVuLA0KPiANCj4gT24gTW9u
IEFwciAxMywgMjAyNiBhdCAxMTowMCBBTSBDRVNULCBNYWFydGVuIEJyb2NrIHdyb3RlOg0KPiA+
IEhpIE1hcmt1cywNCj4gPg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdGkvY3Bzdy5j
IGIvZHJpdmVycy9uZXQvdGkvY3Bzdy5jIGluZGV4DQo+IDZiZmRiYjYwMDkxYWMxY2I3ZWY1YTBi
YjNhZDUyMjFjMmMxMTIwNmYuLmM4NDQ0MTZkNTBjYTNkYjliYjBkOWZmZTU2Y2Q5YzM1MmI4YzU4
YjAgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbmV0L3RpL2Nwc3cuYw0KPiA+PiArKysgYi9k
cml2ZXJzL25ldC90aS9jcHN3LmMNCj4gPj4gQEAgLTEwNjQsOSArMTA2NCwxMCBAQCBzdGF0aWMg
dm9pZCBjcHN3X2dtaWlfc2VsX2RyYTd4eChzdHJ1Y3QgY3Bzd19wcml2ICpwcml2LA0KPiA+PiAg
CXdyaXRlbChyZWcsIHByaXYtPmRhdGEtPmdtaWlfc2VsKTsNCj4gPj4gIH0NCj4gPj4NCj4gPj4g
LXN0YXRpYyB2b2lkIGNwc3dfcGh5X3NlbChzdHJ1Y3QgY3Bzd19wcml2ICpwcml2LCBjb25zdCBj
aGFyICpjb21wYXQsDQo+ID4+IC0JCQkgcGh5X2ludGVyZmFjZV90IHBoeV9tb2RlKQ0KPiA+PiAr
c3RhdGljIHZvaWQgY3Bzd19waHlfc2VsKHN0cnVjdCBjcHN3X3ByaXYgKnByaXYsIHBoeV9pbnRl
cmZhY2VfdA0KPiA+PiArcGh5X21vZGUpDQo+ID4NCj4gPiBJbmRlbnQgcGxlYXNlLiBBbmQgY29u
c2lkZXIgdG8ga2VlcCB0aGUgdHlwZSBvbiB0aGUgc2FtZSBsaW5lIGFzIHRoZSBwYXJhbWV0ZXIu
DQo+IA0KPiBJIHRoaW5rIHRoaXMgbWF5IGhhdmUgYmVlbiB5b3VyIG1haWwgY2xpZW50PyBBdCBs
ZWFzdCBpbiBteSBnaXQgcGF0Y2gNCj4gYW5kIHRoZSBwYXRjaCBJIGNhbiBzZWUgSSBzZW50IGl0
IGlzIGFsbCBvbiBvbmUgbGluZToNCj4gDQo+ICtzdGF0aWMgdm9pZCBjcHN3X3BoeV9zZWwoc3Ry
dWN0IGNwc3dfcHJpdiAqcHJpdiwgcGh5X2ludGVyZmFjZV90IHBoeV9tb2RlKQ0KPiANCj4gQmVz
dA0KPiBNYXJrdXMNCg==
