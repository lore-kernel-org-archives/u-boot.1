Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFA9CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 09:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD91584C5F;
	Fri,  8 May 2026 11:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="j8ICBzCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D74FB84C66; Fri,  8 May 2026 11:06:53 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A905784C3F
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 11:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+H8RT8razcYSIQRIfShUjHDQZAkW64OgmuaPYF8WukiWcXKQ7qRnTaUsRTGBMm8SGssmmirtwOHFr+9Zj943bfSoixn1cidVpDO+dXkjm5Gf0POw0Dz+nOlw3VLm3r+j527eLTXaKoJVO0M8PjA4huyfH6+StiCEc4gMBFnxUQk/BjSClnhFu1oAJtbbdmXtp9LLnX+hfve9/yF47C+xj/c6BcSYhQkCxecNv3QmEcEWJPfSewoenfvQFc/Mgyl6/+xAdV8ar3lZsmol/CTV7jbhazCm9cxo9zV6Pif7cRApqpPxB0ARk7T8uCUr3eTgX5l39eA0TrORNXdwARCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4e06fs03++7tNvcnW7Ek2arnbySRFQbaFMWAl4A5aE=;
 b=fML4kujSrejQohwbvSd3kMOmm0ZQi33o8gTLyGbXbmRqpu3xBo5cfvojH9zT0LwB51bqpIkob8LBfIGuVbFlvh2pvD/a5lqzoxen8WdNDBpRIhM8sylwPlwiCOiEsuZYMXa8nwYmTC+ewy2H8mSt29t1ZgEwOZxk60+n/Ns6cRpeuKwJ9c2mrNpjlQn8nheo+k+s8gLVCsHimKxs9d1O25HeKpiPfjvGphLVnRS+8Afc5HTMq+pcKtEJcfBFADZ6yH88nSr8ZAcs/Yf6TEj1h3CqvtP0nHyawQ24CPsj+PZ/sE0FQuYHW8P2jV0g8Ej+f3kQVBEOUhI7UghHiDy5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=mailbox.org smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4e06fs03++7tNvcnW7Ek2arnbySRFQbaFMWAl4A5aE=;
 b=j8ICBzCjHdyyX58yS1KpP8FN/9+A7k0YarT8LODeirQc2G5eXtks1ztF0OciP1bV3bjpRXL5HW0bnI8PCIYe/qPvydVkXRPTleaW6gwDX2Wk/byJUujUUGJl9HXyBFZRhTnupuox0xWX2Et1gwjk/8PTiZ96P29kdRT46tfXKgD2I/Fzf1jSJRsQGYbOh1a9QLMiiXpc8MPU/P8031SdgIwJYDQQ1C2pp6b/RyYqH02HGt4hiE43jp3ejmQhpoSaPnYJFMpvF7eBuyKNQtAWf56k49wGLVUmTI1dNk1i+WOK1VuXqNyhU+biU27Cnbzo+kgbYavCCbI3pwJxNJBJwA==
Received: from CWLP265CA0453.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b7::22)
 by GVXPR05MB11075.eurprd05.prod.outlook.com (2603:10a6:150:118::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 09:06:46 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:400:1b7:cafe::3b) by CWLP265CA0453.outlook.office365.com
 (2603:10a6:400:1b7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 09:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 09:06:46 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.66) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Fri, 08 May 2026 09:06:45 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by DB9PR05MB8156.eurprd05.prod.outlook.com
 (2603:10a6:10:23e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 09:06:43 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 09:06:43 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] i2c: designware_i2c: Staticize and constify driver ops
Thread-Topic: [PATCH] i2c: designware_i2c: Staticize and constify driver ops
Thread-Index: AQHc3m3F6aajwY6Tc0uTWWa1IVQpnbYD1qyw
Date: Fri, 8 May 2026 09:06:43 +0000
Message-ID: <GV2PR05MB11941F63872E9E63334FBD8FF833D2@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20260507220617.209146-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220617.209146-1-marek.vasut+renesas@mailbox.org>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|DB9PR05MB8156:EE_|AMS0EPF00000199:EE_|GVXPR05MB11075:EE_
X-MS-Office365-Filtering-Correlation-Id: a6eae71e-0b97-4074-77e0-08deace1217c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original: sOZmqylmHAGXjBnG8usR7/uqPF+yY1TggfemrJnnhGhxHRYxOwGDqfsnxJ5ogaTlOywGo6KtFPi8hDlO3e32y3C83CRn88TVi7sbP3J28S21MN2KtTdq6GyQfZgC4sF6v0xRarBW1uSsfVsQinLZ1VFaKwJuyToGBh3Ty5im2HrI9akhaN/xvIu4HTYfrjDDKOnnRLVWo57KiMEWqS8ImczrjXIjspG/kVAVAHbBQG7ZXHpW1/aWxdbB0aqOzehbkfvBHJLrZBQbS2INoNikx7LGYQQCYyJYRL89Gsapo81jzFFv6nhFuTyDgbLem9sDzWJ1i+eLNl/GPvCahcAMfd4ijRVjtIE3za5kV/5VQuIl2r+UHOr1q47oVpUUVCnDqgJ+en2rwZy23iiJShaPJWZTUdp+BdTaKMQdDE0KPV0bKXaXVaE4zDxKGNf+vOmKhsRlqxGcYxgzUHWL2kvBhE7cuJCmwUaKsbLPc8C61SMmWmR1/SPUZUKAISHBAX5oB5yEbukq8Pc9OcYxwbplnxm1BB5SNeIzNyP0TQfTdZ4DE1Y+B6nPXNwtLpY23Q5o8g2WhXgW/R9IRLhm9vt3T7CP0K15YD5NQd/Qk+Ze+7fNCGlsLDPQiwdFDkjmngPWGeIHKbZaKBBYQMh2l4mgGRwNLz9NE/HTDToNkP9gEwg0onyi32Q3F6nTK63M80UuaHCTeJAU6dfFak4sPTV+4HbklrA9xlEh5nVkzCOjrspXodKg0aLZ+/cHpz0DW7GP
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qIDxPxy5G0+cXOnF6g5Qi6JgLOaLjW6ZieDwK8m4Qwxxg1K/UFpqxnA6qkTSOIPXWkjy44PgPrquZwn3PBQjlT3vKr2doRa6yGDJmcVilPAv1OGrKVU7lnJ37fCV8qx9qSCdCzSpE0JyHaCY8soYdEc0PD5UdnDRPCx0BhHC5W69YGmW7aMCYtM69wkbSj+hVlFMhinBESy6XbG6+meuHqUzlXwo5fHvds5sikAaUeAGXpeQHXFI130F80W9/M/QmCABV0O68X7m19SiMEyslwtNwfHRo9lourM2pRwa6TwRk09JB0oYrmOKaK/uCLInFu3ftZxmZQvunoRER7SiUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8156
X-CodeTwo-MessageID: ccb47df2-adeb-497f-9214-4a49de67a335.20260508090645@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fd138874-c3a2-4a63-aa52-08deace11fbf
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|82310400026|376014|1800799024|36860700016|35042699022|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 48OYDQAK28WAL6yiUJ273kFrmApB1DjbQuX55Q3fVoPAO80vta+lBYEEUt1fM008WjAk6kxAaYw2XTPvENxnQqPiJySBOKzMtvWKoNEPdik8r2blU43dt0qXOeur+e3lx/9GT79/9bomwsCyPOAVJheK+fON53Nm5r5OlBa62UuFiO2Hc7hedt16jB9h6uEyak6LK2nT2Upxt6nMNBE8d5pW1Xy0NWsQ328w0SXO4LKBthTiLWzQmgmL09/JmD6zg6gPqF4TKaWgexWN/GnE9esQxHTu8BnZdJ3JBJzFvGL+aqP3s8kxtAZkcIroL5NoHuS+pn9fAF2HjYQfDCXwB8P8V7xqQPDZ4c2m7gcoG6RFK1qHpfChVKf0JTNfEV+VVgyjsuFK4gQWmLHl4/yJIGXUTf/st8UPUV6wyzyHBRXG4wcha1NL/BwFi6ozQJG/E7QK2MWz9gSDIk6uteaE7d+WnlX91bNUAzUHjmsTWXc7YUSNXbfMWN68yVdnaLZKCwPJ7PIsqTVyhAjImEHP8WMcnzb52J9BrVTYHps3cwBtpAxUt23WT1E5vmZYaZ7Lcq57lrP+PhCXXhe1XTf8hbbz5S0ahM65bcFDxhlwERRsp7rTFJNiCG1tQ8JHYScMsZZG7sR0bttzcdmJfsdWpkypuzqkIgEzwKoJlsUet4eLa1cdTRynUzDnxYrLWyH5Dehq9HvMAP79/SlLF2HhjmBtKqktERoRYEj3swqAx7k=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(14060799003)(82310400026)(376014)(1800799024)(36860700016)(35042699022)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FX8pmWggyYbsl2thiC0gNJJ56Pgt5YpxI4ogmQ786odK5QCyPExa50QFke+aLDq/278HJWMviS9I/0Aq27mqKKmf33+Wg5QuYueeD5Jp1D+tr2TFh42XqziyMqn3RyKjd+Aa72HycYFxzge/467juk/T9vLDm9FVBap6OgHuhXJtm6fwTIiP2CrjupBAPQBnNPMdjYWwibKV5DGVMw9yQJ2qnYdWJYwvnYGJk1vWYU47NkwO0xAmgQEd24Mb25UMVrmvN1QEEkIx+BklSwPnsBmTAmLjtEAdN6W9MtbML3QSHPtU5qn56h/VioppvfQwtLlAm792yScq+YIDuaB6zksyvtzOVPbcBDH4uvEVC5TnuVM/uReKawxbZq1uSSrUzH5kS6AXzvq0X+taHDmyE59b54qAZ7hKyaOvMH5sDQR/prWmK8xvr+u7Jl+KI+QP
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:06:46.2478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6eae71e-0b97-4074-77e0-08deace1217c
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR05MB11075
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

SGkgTWFyZWssDQoNCkkgZG9uJ3Qgc2VlIGNvbnN0IGJlaW5nIGFwcGxpZWQuDQpJIHNlaXRoZXIg
dGhlIHBhdGNoIG9yIHRoZSBjb21tZW50IGluY29ycmVjdD8NCg0KS2luZCByZWdhcmRzLA0KTWFh
cnRlbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFUtQm9vdCA8dS1i
b290LWJvdW5jZXNAbGlzdHMuZGVueC5kZT4gT24gQmVoYWxmIE9mIE1hcmVrIFZhc3V0DQo+IFNl
bnQ6IEZyaWRheSA4IE1heSAyMDI2IDA6MDYNCj4gVG86IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+
IENjOiBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BtYWlsYm94Lm9yZz47IEhlaWtv
IFNjaG9jaGVyIDxoc0BuYWJsYWRldi5jb20+OyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29t
Pg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGkyYzogZGVzaWdud2FyZV9pMmM6IFN0YXRpY2l6ZSBhbmQg
Y29uc3RpZnkgZHJpdmVyIG9wcw0KPiANCj4gU2V0IHRoZSBvcHMgc3RydWN0dXJlIGFzIHN0YXRp
YyBjb25zdC4gVGhlIHN0cnVjdHVyZSBpcyBub3QgYWNjZXNzaWJsZQ0KPiBmcm9tIG91dHNpZGUg
b2YgdGhpcyBkcml2ZXIgYW5kIGlzIG5vdCBnb2luZyB0byBiZSBtb2RpZmllZCBhdCBydW50aW1l
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0K3JlbmVzYXNA
bWFpbGJveC5vcmc+DQo+IC0tLQ0KPiBDYzogSGVpa28gU2Nob2NoZXIgPGhzQG5hYmxhZGV2LmNv
bT4NCj4gQ2M6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+IENjOiB1LWJvb3RAbGlz
dHMuZGVueC5kZQ0KPiAtLS0NCj4gIGRyaXZlcnMvaTJjL2Rlc2lnbndhcmVfaTJjX3BjaS5jIHwg
MiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvZGVzaWdud2FyZV9pMmNfcGNpLmMgYi9kcml2
ZXJzL2kyYy9kZXNpZ253YXJlX2kyY19wY2kuYw0KPiBpbmRleCBjMjFjNDEyMjMxYy4uYWQ0MTIy
YzJhYmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaTJjL2Rlc2lnbndhcmVfaTJjX3BjaS5jDQo+
ICsrKyBiL2RyaXZlcnMvaTJjL2Rlc2lnbndhcmVfaTJjX3BjaS5jDQo+IEBAIC0xNjgsNyArMTY4
LDcgQEAgc3RhdGljIGludCBkd19pMmNfYWNwaV9maWxsX3NzZHQoY29uc3Qgc3RydWN0IHVkZXZp
Y2UgKmRldiwNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+IC1zdHJ1Y3QgYWNwaV9vcHMgZHdf
aTJjX2FjcGlfb3BzID0gew0KPiArc3RhdGljIHN0cnVjdCBhY3BpX29wcyBkd19pMmNfYWNwaV9v
cHMgPSB7DQo+ICAJLmZpbGxfc3NkdAk9IGR3X2kyY19hY3BpX2ZpbGxfc3NkdCwNCj4gIH07DQo+
IA0KPiAtLQ0KPiAyLjUzLjANCg0K
