Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EECEBFD1C
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 08:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9100836AC;
	Mon, 13 Apr 2026 10:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="pJrjOQL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B84BB83B99; Mon, 13 Apr 2026 10:58:07 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A968C8352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 10:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvb5UiNu3iuPN7wRba1BMg0v51d1QYh22TbQzr0Mgc91vo8lvHFsbDdLUjQQEloYuS/WjJaNgaLVsUEchIpqhmwjjSbCgSLFxM8jZiowYmKuRj5fX3WyPALAl8jbBclVTHaCV2RaRpnuj+KxCrZ0BScWCuEBVASA26R/DWXYNtMzV+xXSguR6QmxhpqACnvyKWw6TqiHExJ+5lJbKuB/L1beKQIFx0OeecEDpef9OMFdG3Jv/k48SID+DiybBgVLjEqs+L6Ub1sgXYJK6MfJrVTMRN3dOQfYwph1KUgA8nVchqDXIIkA06TnZDJVV4BTWohAxBd4CUlpDPDrocXx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RPdy1ZJ27HaUQ+Wm30xKlsSK8viyCgrJlBl7UmPZHo=;
 b=oOvXyAfUzEx0fDXV82hYyITPompkRhd6mNy5FPrz2M2QtqIbQwlFDslGhbOlix0Y5kvIiT4lKrVA7CegPT1Fa8QETmhokFTmAt/RHJciQPPB5C5cDgnEJMoUR47DelQZpXvmhoQvGFb5hs7EeR7ylkioosZ43q7yQsXfH3ZrXgDXEEoIsWawwghmLY3QlTYVizKt9nYl2O6gxTMzlbVy0mjJyEvlpzVvUfBsZOBG+yqKoOuMCs8dPWQf3uz7EgTJzEqkz6skvWTXq5FRkRI5uroFUR334plzZ0LCVfbm7OJmSvXFR9QHeCWmu97LUme3LeaPspYrEcRK/i8zz1noYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=baylibre.com smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RPdy1ZJ27HaUQ+Wm30xKlsSK8viyCgrJlBl7UmPZHo=;
 b=pJrjOQL224X05hI+tmJNcEXNhkzpjf75QHsbVFmmm3z3LEhUB4mxspM74YtAuFwpUy9ka/TrYgmnUb6aS/ir3+EUcNacycef3BkyR8ol6/aaaQ4bVXR68hyRiE6jvDfn3/ttfpqmOyisCd9Z7gLqhNbjnXstZzCvcvjrc74l+bI572AuUA5JeWt6bB3sFZG7J/f02QIpgr1jsrNwOopW/hM8eJvxlZ5HxwIOQkDtoQXV5Peh9qsctHCaF7nT342N4dfP9eicu0G8jNMiP4kIXhxsLasuO+Yt8PN3mHxhsiVPbt/v/4/4H9FLnjQPdTKV3YEKAop9P2ENL9kZJeqKLA==
Received: from AS4P189CA0033.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::6)
 by PAWPR05MB10988.eurprd05.prod.outlook.com (2603:10a6:102:390::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:58:02 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::89) by AS4P189CA0033.outlook.office365.com
 (2603:10a6:20b:5dd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 08:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 08:58:02 +0000
Received: from DB3PR08CU002.outbound.protection.outlook.com (40.93.64.87) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Mon, 13 Apr 2026 08:58:02 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by DB9PR05MB7722.eurprd05.prod.outlook.com
 (2603:10a6:10:216::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:58:00 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%4]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:57:59 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 3/4] net: cpsw: Use driver data for phy_sel
Thread-Topic: [PATCH 3/4] net: cpsw: Use driver data for phy_sel
Thread-Index: AQHcyNnqNMY6Z31zX0GpM8JWHK+4+7XctLbQ
Date: Mon, 13 Apr 2026 08:57:59 +0000
Message-ID: <GV2PR05MB11941E84B2F2FBF920F73707F83242@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
 <20260410-topic-cpsw-switch-v2026-07-next-v1-3-c914724b13e4@baylibre.com>
In-Reply-To: <20260410-topic-cpsw-switch-v2026-07-next-v1-3-c914724b13e4@baylibre.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|DB9PR05MB7722:EE_|AM3PEPF00009BA2:EE_|PAWPR05MB10988:EE_
X-MS-Office365-Filtering-Correlation-Id: 999df653-a27c-44be-e0cd-08de993ac4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: LMk4WwIkCWjIMQoOvE03anXTZv4uC7gNmZpmXkAFLzwdwCWZMAJziIA2gItc7eqRgLfDJZsi+jdc04yK9hEZeMiriUPvYlTNrRRPib5VM5LrT4/chVFozegA2zV3+dDngEMbVLn/h/0RNagmrIjdvkGesKpXnHQnnGtt+j3bqTbqTBjfnSj3o7bNV15mZmbk+mbLmF0mQCnph21Lx99st2C8FViRPR6Fv14UboB9y8i3nB52JLUDpWRBXPGgoPAvrp8zgBp9PIi7rX6ZP1yfvestlbteQ2bYCUopQ4eV9TyOXC9OL0szdKrhBzr1T/QRwuiJy/1wqwoqNJ0ft+2ETS0Fkoni6V7GMNQPS80JIEvcWcUFFrxUiIKXF7oYukNP1JDzBSsopJ6gvfaPYkEgdOJAsRIGg/A1jz1WtDwSdTmRlQpFxPb7ReNPlIK9MCQMxW/3mjg7A+ibYMOQupq5RscRxcJpG1XcwaYZKhpy0aQLNjbQHSud+N1T3H68yv3ijzexv4fgVsBk6+GPbZmVGiUYbGBwE0Dl0S9rzLDPcFcVYUauIb89PpI5OtZulqwe67jxyDCDUYXfUQnWCHvOCljPx9TZ6azrB2HRthhSnwrUCvqDrYSre3H2NiwlabZgs78P7yk6i7xc8W7zXJVRsnHJZvp0Xiv2APr3i9I+UGVFYJTfDcm/7kCDv8ad9ZohZyDxjYEEHmZZS5IJOPdBpNuesd4QTnnKQUj4G2cNF8s5b23IoD3BrQcTUlGNupPYgBiJXDYAnEx4fef7PWsOLgLPfdKUdCuHJI/QcVoftGo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bwZ3Ls0f7I4amrZvZUEjH3Y7n7QcFp15IgWV3VZl5sxiFHqWBqzoTSBOTNENimmNF44j6vGVFAmFPw9hMPrcfZwD0/BlTsi3qPPYQUoFF7tXhLFc2TOcy+q9uR9xhVguiSVwfOrpNLEWEYvolx9RebDhOm+l6fAxBYi5d4P3qCHmKaJBn9IAx5xXbrGHtU3DskvfjpXKaNymECL9//QAOT5+lGCYv4ejfGRFk/K1BmWGBJ3RAKXb2yMchAkRfNH/SqKCCvmOfcw5z5gd+RutlcYyXmK9/aik4ze1QCmi5EYX/3wXwslAJMn22I5xB5AJ1SurmTddIS3kO7skQOIiUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB7722
X-CodeTwo-MessageID: 4f3379f0-98e2-463c-bbea-f6b8844266f3.20260413085802@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c27688cc-5087-4456-5708-08de993ac32b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|376014|1800799024|36860700016|35042699022|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Kob0E/mAfRZ9lXgTJFSbIbakQMQYncT61oonJowXB6IW82szrCzln3W2Xyk93v7Fr4zRMRVQax5jwufG+sfh9yPdrHy/FtEr20qmuheXu/GwAqKVZs2EsxMOG9d5cfaLFDpXceyna90wIAHymMmOYLK4ZSrwaZIIQuV306MdMkDeu1FQBXirv14Mju6xA5gsBVdXn+xCWzJIcYwR5VWII3JFqWjdIijFQkK0gsVeZdq6Q/TSfVWi++1rHd/slQRNXlMqB3ROBJZ0RDwJ0AnfgxQs+s+vkp81XiMuroye4srnSEwBMG7LHOQWtSZpuh4ygx9aR5E9kcBfjK+8fh9T0iuO18y650u21aXx/UrvpnBzpD9NfUM9Jln/RyMJATUIQ5Jdb9ssnGhC3xFsgOA0K0UdeK552I7X9gjzLQEMIG8WcNq4+jwzCStIpu9nE96QPBhbs4gOeiLRFMjrLfQMYalaHyiOYU2tML/lEAftm5wKJ1FwJ7XwyrxeK2X69ptGHvsruinbQF2pK/2HVFlULNd3eQfBaWqp3ISA6L4zxcrSguAm/6VvlHTWhpCJqgoBIrr/Wu5ru4TcCIFU2BsFVpvSCqqwzQzZR/YxtSJ/Fz+prSjL24JiL6g6UHJzOS9tDpho4D9/NNp87mDb2NaNc79F99/NYFY3viJBVNT3GW5vcFGYW4ESIaCNVYDhphCQUtiqpKjTONBMHYqh/E+1/CAP4nWNwlrgd9XW1HBx+CeI4MFBeS7krL6TCv+7C8Dy236h8Zgt2Oeu/4JYHpkiJA==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(14060799003)(376014)(1800799024)(36860700016)(35042699022)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X3ugOwrrYKV6eDZ1XjuBVNz2lIv0Dp2m/benHmg1LCiEYr8Yh5os9xbV5QEBPGAvM//uBeRoj8sJ0D+j6+FPmleQLMJHdotYGUt7VMlPFkcqztJweT/qWO9vbVF3dqCV5ynT2aaayirSKNMaGB7fcPR4wpci/UPq4VTkxJcV93uxi6TR1YWB1q+1HQhX/OlMtiA4rt/RgpOJLWS1IvxrheMI1jSSqyKcN//+3XXCZaF7AGdeDJYjfmmYSd7TBJN6sXN6jLHHkBLfl0Nmeq0s8pIvhCyw4jw5V96ciXpRtQKDCzNi6ZxOOhYNtnt0AukFFGBKlTKwDEEPHXt35gM2kr4u7j5r0oeaAWDrRFAgHceNsfKmh0iMVh9D8IlQX38/A1uLqVCVpVyeCTRq4R9jeWSGRI3w9hgzqR20nMvee+hn4BRyz5+pQz4bAnmF5l+/
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:58:02.4706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 999df653-a27c-44be-e0cd-08de993ac4f6
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR05MB10988
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
ZXJzL25ldC90aS9jcHN3LmMgaW5kZXggYzg0NDQxNmQ1MGNhM2RiOWJiMGQ5ZmZlNTZjZDljMzUy
YjhjNThiMC4uYjFmYjAwOTgyMmU5NTg2ODg2ZTU0ODdlNGZiZWVlMTE1ZWVjOWE1OSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9uZXQvdGkvY3Bzdy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3RpL2Nw
c3cuYw0KPiBAQCAtMjE2LDYgKzIxNiwxMCBAQCBzdHJ1Y3QgY3Bzd19wcml2IHsNCj4gIAl1MzIJ
CQkJcGh5X21hc2s7DQo+ICB9Ow0KPiAgDQo+ICtzdHJ1Y3QgY3Bzd19kcml2ZXJfZGF0YSB7DQo+
ICsJdm9pZCAoKmdtaWlfc2VsKShzdHJ1Y3QgY3Bzd19wcml2ICpwcml2LCBwaHlfaW50ZXJmYWNl
X3QgcGh5X21vZGUpOyB9Ow0KDQpBZGQgYSBuZXdsaW5lIGJlZm9yZSB9OyBwbGVhc2UNCg0KS2lu
ZCByZWdhcmRzLA0KTWFhcnRlbg0KDQo=
