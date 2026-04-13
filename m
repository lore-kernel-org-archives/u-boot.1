Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5EAEBFD1E
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D20FB836AC;
	Mon, 13 Apr 2026 11:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="hgqda2WW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B88F84119; Mon, 13 Apr 2026 11:00:31 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 676828352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drfYj5IDwmM2cZgsR7xScdZ+PdDIaw4mnmafFcUpnKxqFi3v4zVx5PQe56tz/2xenUFdzCio6myInfePNwYN+Y2kz3PMEFGGDEGbHLua8i55osTv5+lygajcALhdE081NVdNEcRYhKc3gLvxXRgAJBzMLvZPJZFD2D0zUcTXSotMHnb6w2veazuzKq401KBct6beICWl51HAXpVccokzCWnMaD3pninJqNkYmeKtJQw+vvfCYnPeLSwAP0qtuZ+7nzmtQrpKl0yEwncI1U4MMoXVOGWYsihKIPKXupm5xDKlx7MzOYp3gWWQdf6mPeFf/I9/4JYtRY4TB/nRfUblpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XsyVwP4UOLxdsZtOVkfEDUV5ZL/v6bfTPsYFy/fgUU=;
 b=G4BCVKssqraYqr4wpX3r2R8n/6Y03+b5FzP1x+f8Zi9zbjgVSnUG49HgVyQwOWlyduY/A4VGOgFcRCxXfsin5lJT+nIoKtnrM3PJMEeQ6uoiHM/vEv5Gbtz0P84Oh3nKjwBGthsWF8UKz8CTDKV9QX/ihI8607SFOWngsecfpElDWSFXqrVw2+kjhwdVsOGOt8qPcaSEV1/AkJfetMXu3AJxcHVvOqfXeTBhJXt2ZY95MJJ/4UhOgEtsGwazNpHXBNi+iLFbEJIhjUPxWLSSpl5aMrEMpyNvcbCs8FPEohZKvhm2LA7krPrrZCR2oGHShVSVQ8UpLoZQJEzsvYuAIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=baylibre.com smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XsyVwP4UOLxdsZtOVkfEDUV5ZL/v6bfTPsYFy/fgUU=;
 b=hgqda2WWSWcPJSQ741Xj7L5jwl8nQe2gTwSIvfFTDQncLKrgkBAiZz3CbVenKL+eD2bV08sy12n0uM6mIbBHd/e6ugJQsiF+wykmu+DyUbTccWmgPblJO+GyppucqrFoW5fpcnRk6I/RvvZVxPI9LSj7Lo4hfvdhfzMOStGHAqgDA2vfQ7EPh5QEPCegix1P/nFUSP9/dy1NQaPRKlApsnj0PjCuT0h0JfTeBHwfqjwqLqioJd9TSBCCvHbg48j7NVr912OCk2DkX+jxyJkF8FddtggJBOIY9VUGcDTvzVTbJOHbDW1FcwcFJsR+csBJi7CSK+0LXTjGi64WkqLBsw==
Received: from AS4P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::16)
 by GV2PR05MB12763.eurprd05.prod.outlook.com (2603:10a6:150:337::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 09:00:26 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::72) by AS4P190CA0027.outlook.office365.com
 (2603:10a6:20b:5d0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 09:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 13 Apr 2026 09:00:26 +0000
Received: from AM0PR07CU002.outbound.protection.outlook.com (40.93.65.66) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Mon, 13 Apr 2026 09:00:25 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by AS8PR05MB7957.eurprd05.prod.outlook.com
 (2603:10a6:20b:33f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 13 Apr
 2026 09:00:22 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%4]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 09:00:22 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 2/4] net: cpsw: Remove compat string argument
Thread-Topic: [PATCH 2/4] net: cpsw: Remove compat string argument
Thread-Index: AQHcyNnklLG+3/lS4EC2//So5z8jRLXctaDA
Date: Mon, 13 Apr 2026 09:00:22 +0000
Message-ID: <GV2PR05MB11941D5BAD20EA6CC43F2C3F783242@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
 <20260410-topic-cpsw-switch-v2026-07-next-v1-2-c914724b13e4@baylibre.com>
In-Reply-To: <20260410-topic-cpsw-switch-v2026-07-next-v1-2-c914724b13e4@baylibre.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|AS8PR05MB7957:EE_|AM3PEPF0000A795:EE_|GV2PR05MB12763:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6065d9-9158-4006-ad1d-08de993b1ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original: Ws18QSMuI2fQWC20sfN4xkHrss1yTBWDTWp/y04Sde/xh5IbpesTd5Uci9UR3lTyuBW3IbF+cbyNDz7BH2/O5kvKti1Py6kVr/vOj38J+eIkQ+QrJI+FR4d07knVSyTWSoyt0bWCQ1XtR4Cyg2DlXtgatVT3pye5FfwHpA8LztS/a/TUgtizddFJrhlm6HuW29W8DtevbQa+b17N4jhbEIif0kUnvS8svWCLL90MEYJR6RjkG5T/CLT4KDlyDq7k9OR7lmDPkoCvRPcS1a0iNrzYxfB6ZafWaZcwT2wN1EZDAfdRbvqC8LJjn5mjR9iQJxoHxTsEQWtED/CC+CgXzgvzadanGdW/T0A00sL7hgBO4A8KkdKSJdAZz/Uhecyp1cImOhyOqcilLEz4/9qeEyySGASKJIQjSU8CQ4ZhZMGUAbRWk4CeDbz6VjseCGn6TdwvO4ThqxLo399KQqnqfAeMZKySoyrvMnJ/4zW+o2pANR1sZNMJkM1VlyP+T80dJjnqEoV2c7smjvAjyS150yXq8J3XS/2vyaz1cREAzGwmWU7Ep2+IGHRBgcclYxeR2nlEFxfSFuRft/yZ7R+s2GCJPA6YS4dbohVVezNGpGp6YkeDinrAYfGCChRNQcQtjwbQ2wSnS3FvBWav23dLWyzc67nKCru8KrjKm4iBz6+1/CPNZc7Z0zfW4hXuPPE4Sq9yuwi0TiNCQtINX93KOB65EZ8Q1OSiqrCzvAFPoqvSZbdbdj+sI2B8Qf5Q9mV2erAhB7O7+pB7Z3ia1XNtlrsPtmuKgQ9EH4TD8AuOnJE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Whd4Ex6qr2Ou49ByioaNgCKynHIpX76/CSGGBcX7/moH5WE6yaANCidmBkL/01QnZwbP5tsqzF+AUFL65Chtu2jjy4UqWW98W/ZVw4v/ZphHsdCttcBLpu3+VldPqzUorjji/JqpisOZEW9w4GsUD8xJE19R6Sv9NUM85cc54to0OuD1se9GtBP3lv3LHmTNIcQiuvFThor72Uzjsig59t9S5nmbeyu9Xp488tK40K69McRz3/gwl3HUbgSav3SLE6apOEgmVCQ5NoA2n5HSqTVhVwqUDEcPFze42xTsHuzKDc4k/S7IXMUkIskUQBUiX9LdcP0tJxle9vn3KOuWoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB7957
X-CodeTwo-MessageID: 29a4fe32-de07-4609-8990-008f043c0b40.20260413090025@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f9aa2237-d7d9-4305-3354-08de993b1894
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|35042699022|36860700016|14060799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JaLrf6J4RulFdf8OORQCSZ9BiynJ3LaQI2Y/u8lMOK5XNYu4GV2sOM8XOMMg6N0BITWzAJlmjSL5QVNRRE1Bgax00LrbT9zNalKaDzgS2Z5XgRj4qRycfyYvdtJee0cf42o3ID0HrPtSvxevfykQovXigijN8VgO5ohUiGAe5+RdmnfYyBh8NQqM59usjHFABERQNj+WnDMTMnlk+gf4wiV/oh1zFzful6/NIOgl8zEw69sLp77C0ULnuq1LNAH5pIS5mCIdNYvCTGa3k/YpK5WckWvtVc0DkEPmZbtTyGmBTMeOcVTZAesyRn1Z7atsrxJ8QhUsi910O4VfjMrn24U1U0q4NMboT8MWQ+BgybB3Rrov8TOmUxdu1L33yQ+YmHmqOp5yVX30OhYUm8v+2zoLda3B8oVkJshOkeRXUBf9S/uHkatuFU179EHbt5B2kpfpPDqu5CX9hATtt75yqL6Aq856JcSFYcPpsaSTGq3nEaIG4GE20NJYF1O1k8egKubn+orL+ZP7S9sndppFNmMHk99R4CgKo6ND1Pdw5wuhzIgy6TKsDwDmxn4iBQ0C7m2yNr8DcfgcGxDmuSf239XeQ6HwS5cxaYteqG0cdrLZ69lOpiNe2P5jbjp6s/28zns1N1eZuqq73FEX998orZ6CaNjcfP0ei0aA9/gcCjfWXjLneGT/BvY7s5HF6f9D54Dg3WJ9X8XbUhmvasKKBRnTYZKSxQ1YoiTs4UhekQ4dlolUSC5leRT1fLpNi7oBRbjL18EqaHXJ69wDWih7hg==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(35042699022)(36860700016)(14060799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b1Eb5ivlDNlEU5opcw2xOGXsWUSWmMp9Ohe02L9j5fJr81k11RqAz8ouJLCwxaEqcy1VKRxwRg0RXcMFqW1bLEE3XQB6OO7m+FhY83pbdUIBy6bnxOvTzzdb4J3l+CWtzABVuMibrQJ+6cPiH4UGwD6bCaXUso+Yx6j47KiYKkY/WhPRSOnLw/zrhSrkyFFURvlIIyABlWGuiCeuIcwd2Q8pn0kBBJpGvUHidMg4Im4xwONETizRCy3m8fNTs73vqnO8Var6vsVdf6t9+JXP29AS7tTbMmNp8WpBEGKOoV4UZDKtp7Dr3ZODczUCzxrlgkHYKx8jN2BHMWVi7Wt0t3m+S5OyvVcZ25Ru1E1+poSDFq6OQrruerXcIVT3gMrmtb93QBvzVrZnfYM89pb8+SwNQ9TKcTMUfpkBCb/8PySOArogcJ24FmymGTvRcjXe
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 09:00:26.3304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6065d9-9158-4006-ad1d-08de993b1ab6
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR05MB12763
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

SGkgTWFya3VzLA0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC90aS9jcHN3LmMgYi9kcml2
ZXJzL25ldC90aS9jcHN3LmMgaW5kZXggNmJmZGJiNjAwOTFhYzFjYjdlZjVhMGJiM2FkNTIyMWMy
YzExMjA2Zi4uYzg0NDQxNmQ1MGNhM2RiOWJiMGQ5ZmZlNTZjZDljMzUyYjhjNThiMCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9uZXQvdGkvY3Bzdy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3RpL2Nw
c3cuYw0KPiBAQCAtMTA2NCw5ICsxMDY0LDEwIEBAIHN0YXRpYyB2b2lkIGNwc3dfZ21paV9zZWxf
ZHJhN3h4KHN0cnVjdCBjcHN3X3ByaXYgKnByaXYsDQo+ICAJd3JpdGVsKHJlZywgcHJpdi0+ZGF0
YS0+Z21paV9zZWwpOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgdm9pZCBjcHN3X3BoeV9zZWwoc3Ry
dWN0IGNwc3dfcHJpdiAqcHJpdiwgY29uc3QgY2hhciAqY29tcGF0LA0KPiAtCQkJIHBoeV9pbnRl
cmZhY2VfdCBwaHlfbW9kZSkNCj4gK3N0YXRpYyB2b2lkIGNwc3dfcGh5X3NlbChzdHJ1Y3QgY3Bz
d19wcml2ICpwcml2LCBwaHlfaW50ZXJmYWNlX3QgDQo+ICtwaHlfbW9kZSkNCg0KSW5kZW50IHBs
ZWFzZS4gQW5kIGNvbnNpZGVyIHRvIGtlZXAgdGhlIHR5cGUgb24gdGhlIHNhbWUgbGluZSBhcyB0
aGUgcGFyYW1ldGVyLg0KDQpLaW5kIHJlZ2FyZHMsDQpNYWFydGVuDQoNCg==
