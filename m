Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DABCD4F50
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 13:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA1B84664;
	Mon, 18 May 2026 15:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="rb3cw8RA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E05684664; Mon, 18 May 2026 15:40:17 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E704D83AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ny4UoVTaGRHQDVXyqnvZh4vZcco3PzmosAG5xCynn7cE8kkLvCKxeJKBINasRg4GZEBZT3wZMQ+oVbQDsAUwFxlU/i898s6uaTrPUwhgIn2JUvUsDL78xWA4tbcejlBgWWvKAJNZ/Wdube68Nru9nzGyYftLm7uWqGYsAVs9prcZ9WGtxha3nnL/9XJchmrCOJuiGj+VKd6qiVIXZw3KJEdYGtw8Uw1lBGkUn/tNvUF9QhxladsdTnLy2cmgl3W4t/Itqzx2JU4p4WDkqTWfwbiXPcG92M7wgMylwBVSc47KBywodH9ZEIDsLjH7GubI+X5hfCFY+IMyFCg/mrxV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPEtH66J0zpUQ2eUi+Uw1a4CiS3FGWZayU0m2p2elGg=;
 b=tRfSltUMribjGld0kLsTM3IrWqjJSwIeGal5m5lAuoHqDJ6NSJm+1dya3L2oA4KLPhIYZ172TqJGdo5mF+Iz9xpcy0pmQJv2rwOOScnAhbBjeP9hQ6powxZIfhB2G4++T8sCt9PtKnhKO9LQ0tFTU6CoYs6ZGFFDGp8NWMEziJyp/6DRcTk4VwGChD/6YVruxK9Pae3BE60RRvalJEGJDYB0Anr0lRcgqiuShnddiKs+LEou1J7cneBKW6tknwaX+qNvs+f2QWT2gSOm3q/yb7KwBEK8Omh3TrdJ/qfR4FZL9UJWzH7WrNA0rsAwlPguH8+es0qgPV8KOiU9clESeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=amd.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPEtH66J0zpUQ2eUi+Uw1a4CiS3FGWZayU0m2p2elGg=;
 b=rb3cw8RAGQO0jursQ8XbWzSZx44FC8M5Jys8EpSMwlg6m1wgiYVQlIqFkWokZnNZdmh0dK6H4cZw/FHprXw2bK4+Ph7lzgLjheW48WmbhvlH+6hWlZXo+h5oXJGBBcSTDXhBn/hEZNvWFarKk/pC3dhWg7UWgLdKococNf/zRrQV9K4bt63yc8An0bbtjjD04ZDKj3XLFElzorxyq/iTXfqiLWOY15NpTFR6hE9m+Xu1nNG2uzNNVXw4zOnvRfg6sx8phdVCBNH1glEKIyFYSb3UcFDmAqgmQLipIkUXw8Eseb5rgd9t6mi6CYTiBYA0MXGIU9w/NSgrk6xa0Kz+3w==
Received: from DUZP191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::27)
 by AS8PR05MB9857.eurprd05.prod.outlook.com (2603:10a6:20b:5c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 13:40:08 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::b5) by DUZP191CA0010.outlook.office365.com
 (2603:10a6:10:4f9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 13:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 13:40:08 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.48) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Mon, 18 May 2026 13:40:07 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by PR3PR05MB7097.eurprd05.prod.outlook.com
 (2603:10a6:102:65::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 13:40:04 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%4]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 13:40:04 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Michal Simek <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "git@amd.com" <git@amd.com>, Simon Glass
 <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v3 1/5] reset: Add reset_reset() and reset_reset_bulk() API
Thread-Topic: [PATCH v3 1/5] reset: Add reset_reset() and reset_reset_bulk()
 API
Thread-Index: AQHc4rzbCDLskqqraUWKae54XuSMorYTl/zAgAAGb4CAABgoUIAAB54AgAAB5gA=
Date: Mon, 18 May 2026 13:40:04 +0000
Message-ID: <GV2PR05MB11941B4DBA7BBB814C32BFEAF83032@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <cover.1778665323.git.michal.simek@amd.com>
 <b8229b9f7b357cf6013e8423831a9af1d69fefdb.1778665323.git.michal.simek@amd.com>
 <GV2PR05MB1194140D0CFDB4D8C63BB998183032@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <0f7c82f8-dfff-4c0b-84c5-41f189ee042b@amd.com>
 <GV2PR05MB1194186BCEE688E85977E22FE83032@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <12534d6c-6961-4fb7-80c3-d83c3f8d13dd@amd.com>
In-Reply-To: <12534d6c-6961-4fb7-80c3-d83c3f8d13dd@amd.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|PR3PR05MB7097:EE_|DB1PEPF00039233:EE_|AS8PR05MB9857:EE_
X-MS-Office365-Filtering-Correlation-Id: 7935b0a6-c3ad-4404-f738-08deb4e2f9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003|4143699003|3023799003;
X-Microsoft-Antispam-Message-Info-Original: iahObpScJCVeDnx8smeSqnL3aTEwXHKbJChLIxAO0zkiInpaFa0q31iofr6gXPu2pNYSrfqU9z1wLb3X9SjQRyvi9rwAbC/MndZzVRUcQaW7wB44x8UA6y/A4LhFbcNGuZNQyOMs2XxvkDZ90uRR+2PrnUGMDA3F8n4COwcsxEZoVhMcG7+fakVnO08808bwSPcuN4kNriqk0nqnURo9onCzwTtXATaiyfSe84TZ5PNJQPsePT6ryWpTS0ycXWBjjeOkp2NHJHra2Itby3vsVz5jQ4DBgkIg3KjIZzd4ZbSsMWiiftyF4Xg+sJks6CcImBbny/T5/lKwazIHGNy3D7dHymo3YLCVt59BFqkG7ltRVVSTcRiUZAOs/DA6zDI2WmVf+Gpl/kYJ1IkHIEy0y5BBZFzug9/UujIu8SWN7joepiK0E4/6UIZNvfN+EDOEQgzSr+VUeKwML9+vDNmfUVKpPKLbLK4NUxeVph8DqL7NGoNhY03woRg+GbkOMnd5VU64515Oh2O3btuBQ0dVSTGlNy6oouylrOVntdAXaVEGR4h3NkkaLrVoaM2k6ev5R8WiZj4bntA4+r3l12xZ1XTX3OlZdjuv0zI7r7FZZvVmSUy58yZg3TBI1glLLtlXwim5SDz0zKpS1kjwm1zeGmJIoJdSu48Psyq+WRtG1B7na3e3swhRD+i2i/EcD5/BA5FdaOR5U0aYDbM+JqTVT+NM3ymwHR43U4QX64oTCfkq8K4JwwO8uKfVAWZGF5rH
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003)(4143699003)(3023799003);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cdXcVl9NohJY2wDLjLTUzXrFc72odUzcA8kX2hCcwj1yfg/Mjg0T3er/BYR6O6mXOarz7uG0iE4VWSaUyR66sU2aUJsXy6Iasy+38PAUMerULZL4Fw8wG4paWTLHs9q4dJAd/r+6Dh0hfs+3WoJIE3aGjDcXyqBvkttcQLrtDrOQlkOeaXYHXswYXQcV2JRwmcg8erE9uGBWanw29dWi2ofEnTtQp7rDjXIjkAIQ1//5z+u4gudL7JVB3Dt4/QBqJ+SemqS/bjbS22KQ2diA/F1HaCXX5DTsBjhXJlz2tsrafW0Ii+iAuA8iwucrbCjymUhzGRGJydIPM5gayjACkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR05MB7097
X-CodeTwo-MessageID: 21d010fb-b342-45a4-a3ab-13553ed8893f.20260518134007@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1475d104-495a-4bcb-8bf6-08deb4e2f787
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|14060799003|82310400026|35042699022|1800799024|4143699003|3023799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7aGo6c7xNL7UoBjMlyNj9izAOh825lxi3R+qlsfT6Bv4n4ZwwZexdBNtbJrwD8sbquLF4/OuLBMEgL8QxPdwQp+V15YaqyxzwCNDGe13zaN3zT0y7s/kTamGKr6e3gBnCcbSo6HbBMYn8H9bn33KDKGTUcp2BkHCCjNDn9QftTuhdno5IqtWWlw0FbuPAu3z8EmD8J49L9Xv3yVCIHP1JBaUoqnbtMyGlHuwAYBzkVtYhObsl6CiScY7eSxrSmnd0MFVgOYIZOnQ7c+AyejgUy/2tCJj3a00KDbY/2VbjIkGw6ATvzCJqVyxInQ2REyQdNJovTStbEN9ZhtTZ3Tb0Det19jRLmYhKNAVY4YyAlMHFSm/gXEshmpPPIlIYWkmYKyuu6KSO+mG1LZEq6z06Q/9khn+afc6JWcLOe286qQgsEAHSlT7Hh0HDsRdkVK757pBgImtW6Xwp/1cbhZFk/I6FEBFFdYq0su4vdIoroCJB7XcLcDktARQU5r9UW48SSbEJmU/jpJTqIl0DzD77XMlWtHzceIiHGEmJITxOLfu75QBj7y7AIBjYdkPTdLLTegq4Q6kRlwr1UiI6gCE02eoSyM2p00GrS3fQgZ9oFBThA3M7yYL6Fu+AySMb6JJWxcO5MXnTIRPgkxzJTKZns6utYvs81FTuln8vnFjufQ27hPei8mY0guBULRPGecyeQVGn2M1JY7wF5iWlZPKywTwKo2KaHJJTtIPqbNTx1w=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(14060799003)(82310400026)(35042699022)(1800799024)(4143699003)(3023799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ipNrQ2ED5Cn1eVp0KcFlHMzKJwkEtZ/Pis1cBKWS5EyimYjxVClm8PKLmTswIQi8nsu7hQvbv9Ki85ygDsEmzJhpuhq15t+xrgH2MhK3CUnqWIxzbtAqCIn/LmNpEB16r2kUbRkyl9qt4mQKj6yZIC7XLcMJ5tVJ1ZzdD4W+hnkXE+XcBvnWU4zAU5YRdDn38Zfy3xyxyTHXWdcYjDVuNaOY5Hkq2U87Xx1GQoAa/iirHzc9Ran3POlaDKltobEG6Jx7vUhORfEh1Lgi4ghbemDzjmRcuJD/lQ2PUh7A7kv6zCfj4V0AyOaD+3WeRdY1bltX7yrjeaS2eXkuFTNNSem/R5F8PmZ0qltq1rd6Y7PI6sGfDhF6Nz/EZ8I5fWr/pJc0DUNwuehK+QGaBadcDF0kg7io0dRh0nL2PV7CLINcEkZegATYZryovum3c8XN
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 13:40:08.1894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7935b0a6-c3ad-4404-f738-08deb4e2f9fd
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB9857
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
b20+DQo+IE9uIDUvMTgvMjYgMTQ6MDcsIE1hYXJ0ZW4gQnJvY2sgd3JvdGU6DQo+ID4+IEZyb206
IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+ID4+IE9uIDUvMTgvMjYgMTI6
MjEsIE1hYXJ0ZW4gQnJvY2sgd3JvdGU6DQo+ID4+DQo+ID4+IEkgZXhwZWN0IHlvdSB3b3VsZCBs
aWtlIHRvIGRvIGl0IGxpa2UgdGhpcyByaWdodD8NCj4gPj4NCj4gPj4gaW50IHJlc2V0X3Jlc2V0
X2J1bGsoc3RydWN0IHJlc2V0X2N0bF9idWxrICpidWxrLCB1bG9uZyBkZWxheV91cykNCj4gPj4g
ew0KPiA+PiAJaW50IHJldDsNCj4gPj4NCj4gPj4gCXJldCA9IHJlc2V0X2Fzc2VydF9idWxrKGJ1
bGspOw0KPiA+PiAJaWYgKHJldCkgew0KPiA+PiAJCWRldl9lcnIoYnVzLCAiRmFpbGVkIHRvIGFz
c2VydCByZXNldDogJWRcbiIsIHJldCk7DQo+ID4+IAkJcmV0dXJuIHJldDsNCj4gPj4gCX0NCj4g
Pj4NCj4gPj4gCXVkZWxheShkZWxheV91cyk7DQo+ID4+DQo+ID4+IAkvKiBEZWFzc2VydCBhbGwg
T1NQSSByZXNldCBsaW5lcyAqLw0KPiA+PiAJcmV0ID0gcmVzZXRfZGVhc3NlcnRfYnVsayhidWxr
KTsNCj4gPj4gCWlmIChyZXQpIHsNCj4gPj4gCQlkZXZfZXJyKGJ1cywgIkZhaWxlZCB0byBkZWFz
c2VydCByZXNldDogJWRcbiIsIHJldCk7DQo+ID4+IAkJcmV0dXJuIHJldDsNCj4gPj4gCX0NCj4g
Pj4NCj4gPj4gCXJldHVybiAwOw0KPiA+PiB9DQo+ID4NCj4gPiBUaGF0IGlzIGNvcnJlY3QuDQo+
ID4gQW5kIGEgc2luZ2xlIGRlbGF5IG9mIGRlbGF5X3VzIHRha2VzIGxlc3MgdGltZSB0aGFuIE4q
ZGVsYXlfdXMgKGZvciBOPjEpLCBzbyB0aGUgdG90YWwgc3RhcnR1cCB0aW1lIGlzIHNtYWxsZXIg
KGEuay5hLiBmYXN0ZXIgc3RhcnR1cCkuDQo+IA0KPiBJdCByZWFsbHkgZGVwZW5kcyBvbiBvdGhl
ciBmYWN0b3JzIGFuZCBkZWxheSB0aW1lLiBJbiBvdXIgY2FzZSBpdCBpcyBub3QganVzdA0KPiBN
TUlPIGFjY2Vzcy4gQnV0IGl0IGlzIFNNQyB0byBURi1BIGFuZCB0aGVuIHNlY29uZGluZyByZXF1
ZXN0IG92ZXIgbWFpbGJveCB0bw0KPiBhbm90aGVyIGZpcm13YXJlIHRvIGFjayBpdCBmaXJzdCBh
bmQgdGhlbiBkbyBpdC4gQW5kIHdpdGggYWJvdmUgeW91IHdvdWxkIGhhdmUNCj4gdG8gZG8gdHdp
Y2UgY29tcGFyZSB0byBvbmNlLg0KPiANCj4gSSBjYW4gZG8gYW5vdGhlciBvcHRpbWl6YXRpb24g
d2hpY2ggaXMgdGhhdCBpZiBidWxrLT5jb3VudCBpcyAxIHRoZW4gY2FsbA0KPiByZXNldF9yZXNl
dCgpIGRpcmVjdGx5IGFuZCBmb3Igb3RoZXJzIGRvIHdoYXQgeW91IHNlZSBhYm92ZS4NCj4gDQo+
IFdoYXQgZG8geW91IHRoaW5rPw0KDQpJIHZlcnkgbXVjaCBkb3VidCB0aGF0IGFsbCBzb3J0cyBv
ZiBhY3Rpb25zIGFuZCBjb21wYXJlcyB3aWxsIGV2ZXIgdGFrZSBtb3JlIHRpbWUgdGhhbiAxIHVz
LCB1bmxlc3Mgc29tZSBzZXJpYWwgcHJvdG9jb2wgaXMgaW52b2x2ZWQgKHVhcnQvc3BpL2kyYyku
DQpTbywgSSBleHBlY3QgdGhhdCBkZWxheV91cyBpcyBhbHdheXMgdGhlIGRvbWluYW50IGVsYXBz
ZWQgdGltZS4gQW5kIE4qZGVsYXlfdXMgZXZlbiBtb3JlIHNvLg0KDQpJIGRvIHVuZGVyc3RhbmQg
dGhhdCBpZiB0aGUgZGVsYXkgaXMgaGFuZGxlZCBieSByc3RfcmVzZXQoKSBhbmQgdW5kZXJseWlu
ZyBoYXJkd2FyZSwgdGhpbmdzIG1pZ2h0IGJlIGRpZmZlcmVudC4NClNvIHNwZWNpYWwgaGFuZGxp
bmcgb2YgYnVsay0+Y291bnQ9MSBvciAqYWxsKiBidWxrIHJlc2V0cyBhcmUgaGFuZGxlZCBieSBy
c3RfcmVzZXQoKSBjb3VsZCBiZSBhIGdvb2QgaWRlYS4NCg0KSG93IGFib3V0IHNvbWV0aGluZyBs
aWtlIHRoaXM/DQoNCmludCByZXNldF9yZXNldF9idWxrKHN0cnVjdCByZXNldF9jdGxfYnVsayAq
YnVsaywgdWxvbmcgZGVsYXlfdXMpDQp7DQoJaW50IGksIHJldCwgc29mdCA9IDA7DQoNCglmb3Ig
KGkgPSAwOyBpIDwgYnVsay0+Y291bnQ7IGkrKykgew0KCQlzdHJ1Y3QgcmVzZXRfb3BzICpvcHMg
PSByZXNldF9kZXZfb3BzKGJ1bGstPnJlc2V0c1tpXS5kZXYpOw0KDQoJCWlmIChvcHMtPnJzdF9y
ZXNldCkgew0KCQkJcmV0ID0gb3BzLT5yc3RfcmVzZXQoJmJ1bGstPnJlc2V0c1tpXSwgZGVsYXlf
dXMpOw0KCQl9IGVsc2Ugew0KCQkJcmV0ID0gcmVzZXRfYXNzZXJ0KCZidWxrLT5yZXNldHNbaV0p
Ow0KCQkJc29mdCsrOw0KCQl9DQoJCWlmIChyZXQgPCAwKQ0KCQkJcmV0dXJuIHJldDsNCgl9DQoN
CglpZiAoc29mdCA9PSAwKQ0KCQlyZXR1cm4gMDsNCg0KCXVkZWxheShkZWxheV91cyk7DQoNCglm
b3IgKGkgPSAwOyBpIDwgYnVsay0+Y291bnQ7IGkrKykgew0KCQlzdHJ1Y3QgcmVzZXRfb3BzICpv
cHMgPSByZXNldF9kZXZfb3BzKGJ1bGstPnJlc2V0c1tpXS5kZXYpOw0KDQoJCWlmICghb3BzLT5y
c3RfcmVzZXQpIHsNCgkJCXJldCA9IHJlc2V0X2RlYXNzZXJ0KCZidWxrLT5yZXNldHNbaV0pOw0K
CQkJaWYgKHJldCA8IDApDQoJCQkJcmV0dXJuIHJldDsNCgkJfQ0KCX0NCg0KCXJldHVybiAwOw0K
fQ0KDQpLaW5kIHJlZ2FyZHMsDQpNYWFydGVuIEJyb2NrDQoNCg==
