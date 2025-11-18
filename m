Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4CCCED603
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 11:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD6A983C98;
	Tue, 18 Nov 2025 12:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="IaBLxCbn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30B1283CB9; Tue, 18 Nov 2025 12:09:45 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E07C83BD2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 12:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5h1D2mpyXrIsWX6/+PmN/OF1J+H595uOKeVD58vip5eTFu9hPQLcKYHpOOpYFx5lPzwAOT09bqQCOoivgEELQV+pID1TWB+J74HawenuYwugxO2yEDOuDd0baZTxJM7MhJND6JjnUIPwJRBo+Dis+KmTegjMmnnH8H/rxRcneR6yaXwYwx5EoyCiglB96+M9E1IV9NgReDW4nDqETylwU6lF5Es7YrCrtQeb3BjhUa5FQGdTYkLjSltw1nihAUwT2zdG7De3l6pnRZsspZcvS0NeokZDW1ujksft031jahKBn3khOlsQ+0dnjfKhRNL4mJPzPSrvfSTj3JgBjY6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkFGq5dIjG9O8GsR0FUA6d0IHTy3CA9yDLjRuQFVivk=;
 b=K3LkAzt39Xe4A3iJ2eXSxsg3kPQI1nV3EuLzf3Q4al+VNjqlAprR6o4bvFcRpe71WLJzOD/xkNopFu4cjK8A5aLRVEI2aSDen+eTxAZQp60lRR8Ggdz7kzN9c80ddM+W40ffYDmp59nodPDI4QWTvmXxcgOOD4DsfSag6Op2dBysCKZABartgm+ArK8XE8UB81xlV7M0uF8un5Y5mmYJTYdHVmXutM8L73xvg3a/jRgUxZs5zJvyniBPtqwhv4A2ELuPoOd7E4NwYa+eN69zfSPYC6SvnoVyiwavAhmkw40CYQasvmiJ7GCjC8iXlOUkwnvS2Xl50PlNoGp3k4VKYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=baylibre.com smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkFGq5dIjG9O8GsR0FUA6d0IHTy3CA9yDLjRuQFVivk=;
 b=IaBLxCbnML0tSCCfOg5bq50G7FBnIb0ROVKzMIQw+9NZ/uB2nMpvIzz1IDrHWmKIig3zTmK5NV0feCKi3ejTsO1qscYaPh6eFzQceVsy4qq3Y95oclzBBgPsp4SG2jI+tHL9q6Xn0/kaKMogcBhdvQ1f72tVkUuNTKIsyWn0Ws4dm5EgYzre3BiPsvnFEWklx8AohlnAr+wOJ/ElzsXmM0r2gygVdEKj4GYqiYh4GZMfGb35rTtCiv0JU7GKxgmvcysaSHQOpdW6WIvKgpaUk9mXuEr3MHvBhXNDYcW39h//p/aWlWt5wTz7Jg4czw9gKatLLEZzbyr1EgUMJiP50g==
Received: from AS8PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:20b:127::28)
 by VI1PR05MB10936.eurprd05.prod.outlook.com (2603:10a6:800:1d0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 11:09:39 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:20b:127:cafe::db) by AS8PR04CA0143.outlook.office365.com
 (2603:10a6:20b:127::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Tue,
 18 Nov 2025 11:09:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 11:09:39 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.51) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 18 Nov 2025 11:09:38 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by PAXPR05MB8095.eurprd05.prod.outlook.com
 (2603:10a6:102:154::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 11:09:36 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::8532:a1ae:4fc1:3b89]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::8532:a1ae:4fc1:3b89%3]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 11:09:36 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Alif Zakuan Yuslaimi
 <alif.zakuan.yuslaimi@altera.com>, Casey Connolly
 <casey.connolly@linaro.org>, Tingting Meng <tingting.meng@altera.com>, Peng
 Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Duje Mihanovic
 <duje@dujemihanovic.xyz>, Liya Huang <1425075683@qq.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Marek
 Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Andrew
 Goodbody <andrew.goodbody@linaro.org>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Sukrut Bellary <sbellary@baylibre.com>
Subject: RE: [PATCH 01/15] board: ti: am335x: Fix DM_TPS65910 condition
Thread-Topic: [PATCH 01/15] board: ti: am335x: Fix DM_TPS65910 condition
Thread-Index: AQHcWHgDuPR5VQSYuk+JOJb2IS37MbT4RhLQ
Date: Tue, 18 Nov 2025 11:09:36 +0000
Message-ID: <GV2PR05MB1194108EEB54378B8A1FDC16783D6A@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-1-91ce13c661e2@baylibre.com>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-1-91ce13c661e2@baylibre.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|PAXPR05MB8095:EE_|AMS0EPF000001A2:EE_|VI1PR05MB10936:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a2f2c3-1a9c-4209-06ca-08de2692f77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?ekFGaDdIMHYrWEs4bXp5TzV4OVhZL1ptWU1uQkRBMFA5MVVsblZZNnVVZXJ5?=
 =?utf-8?B?OURuR0pTWDlmSFRJaE5ZZUdIUmM5MWlaTUFtWmNjR2RYc01VTWlKTWYyNUVk?=
 =?utf-8?B?VnN5aElLTDhUNUpQTk1uMTE5QU0yOW94cndYNjBiVHZrOWN2NHQwYUZMNlph?=
 =?utf-8?B?K24vMTl3TGhsZm52YlVIUTJiSmhPcDcwcklyRzd4UU9HS1VhMnJwQVFmV1dj?=
 =?utf-8?B?TTVkYnlTdk9LZm9zbkM0Rk1wUlIvblpQNUo4V2h6Mit0Tml6bWFaVGVrcGVN?=
 =?utf-8?B?aWNJRFlPSXlPTjEvTzVwdnQrK3pTY3Z0RjIzMWNjRzFYL2ljYmJiRjZqems2?=
 =?utf-8?B?blcyZ0JBM2hVbkVHbWJ3V3hlUFQwRnpINlI4Z010eXJHM29DTFJSR0Flc0hL?=
 =?utf-8?B?OXFLYVNyTDdCM3RNVGNVZHVXeWtVT3FaTGtqMTQ3Mmg3SmI4elFPNStqV3lQ?=
 =?utf-8?B?Q0haUWJmcG4yUk9mbFVOZ21ack92SHkwSzRzZERoZTB6czNXSS9aV1B2WkNJ?=
 =?utf-8?B?TkhnUGs3UVRqTWkvaGtsUlAxbFR3QUJFVStwckhrbk50TjZiVDlZSFE3NGZp?=
 =?utf-8?B?bjEzY2dRVlNsTWwxVmF0VkR5a0taa3AvMldSZlEwbVl0cWtKTExOdnpEMHhv?=
 =?utf-8?B?b2F0MWRqaVkwanRDQ09GZXlRcjZOdHFlMnNWWW9LS1JlZVp1Zm0rT0xjTm9s?=
 =?utf-8?B?SURKYThEZWFtOEc1Z1MyYTdqMEp3SDAyYW0rdDhlT0wxWUtpTytuY1JkcFQw?=
 =?utf-8?B?UnhXekUzNHBlWThrcXkwU1h2SmhmRGZwSFpycXdRUXNkQmt4a0ZOdGdzcUhv?=
 =?utf-8?B?MVJxd1BpNjF0ZnV6bjV2SVFxVUZwR0ZlSUt5WGRJbjF5YXdqR2RsQmhlL1Vu?=
 =?utf-8?B?TWpVbHE0WU42TiswNGFDVzhtZVkxbnlGWWxnODcxalIxNy9tOVB1dFJwWDdv?=
 =?utf-8?B?RVY0ZUQ0QkV5eGE4QmFUMzhsVjlJSkU4d1Y0MHFvV1ZMU2xhQS9IeGRLNE9w?=
 =?utf-8?B?M2J6SlZsL21QeTRuL1JsWHpOQjhoS1hGbFRrb0VIUEY1YkpVN1VWMGJ6NXNE?=
 =?utf-8?B?UmJpeGQ0L21EZEpOZ3hTL0VpZldPQkR1UW5keDhTV2Z1RjVXbkNaQmpqOTFT?=
 =?utf-8?B?L0l2ODRCemFPNnUxTE93V3BuZlBGMnhhS1VXZi9hNW5tZDc0STVadHc1NHRI?=
 =?utf-8?B?QmladjRwUU5JQnQvN21ncjRMNUx5K2RvYjEwSHFBckgvTnFiZXNCZGhMN1R0?=
 =?utf-8?B?bUlHR2dtL1VndTNDeVdSdmp6SHo4UnRkSGFCUXB2eE11T1JnTWhwb1Q4aWNo?=
 =?utf-8?B?VG5ndkcyT2x3eE1HRDNubm1aTmtWT3lwMDNESVAwSk9hQlROdlpRckQ5K3FT?=
 =?utf-8?B?b0N2SU1XN0x5K3ZjeGlmQWptMWllZVhSRVRRUXJTcFhlc0FRTnczRTNDcDIv?=
 =?utf-8?B?UzUwdUdmVGJDQ1pva2VyWit2UmJiWFg2bTFoekF2MlZvQzNXbHIrR2hsZ01C?=
 =?utf-8?B?SUFtS2hyRHhoWVIvYUt3WWdKRjlJTU5LZVF3SktyM0RITEE3N3ArYkFHNXlj?=
 =?utf-8?B?V2JDc2FpbU5PUEQyemtCN2hveVpNNytuRDIrRUgramliem1mMjVtQS9uRDA2?=
 =?utf-8?B?dk5PSEdQOVpHU0xhcFNXd3dQbEJhRWVXaytIYmgyc3k3ZWVqa0dKZ3VzZm1L?=
 =?utf-8?B?SDVwUmNWUEY3S3kraXArTkpEYWNQbk1ad0o0VHRwRit5RnlWTkNFNFpnYkMx?=
 =?utf-8?B?L2dzYlVzSVNJc0lVQU0wN3lRMDhmYWM3TjBDWk4zMnVRZWpMYkQzcG9OeUh6?=
 =?utf-8?B?aGR3MGZCYm11Zm85LzBNRUhYSHRsNTZTUkRKWVlOQ25tMVpMWWQyMno5UTFK?=
 =?utf-8?B?Z3VVWTByUHRDRHN6akF6UEFvUUtNNVk3VnBaOEtIYnYxUzVsWHlkanIzNUQz?=
 =?utf-8?B?VitLRzNybzAyYVE0U0FaNDUrSHB2c3RaWGxJY29QbWVYOXFRYklFalZGZGlQ?=
 =?utf-8?B?Tk5FVjB5ZkJqK3BWbk9lSG8zVUp1MkZNMlFXdlNGQWlKSk9tZ25hQ1dPdXpF?=
 =?utf-8?Q?thD6qU?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB8095
X-CodeTwo-MessageID: 759ff674-05b3-49d7-a5e2-ebc425aed565.20251118110938@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8e0ad4b6-f0dd-47e5-261e-08de2692f591
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|35042699022|7416014|14060799003|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVVZdG5POEpGVEsrTlhLS1J4Z0lsVUprelBaQ3YwVWZHMFVTU09JKzFvZ1lK?=
 =?utf-8?B?cjFqbzVTRjFzNCtKYUhHNERuL0VXL2JocFA4UHhIUjdUUVNiZzJ4Rk10Tjc2?=
 =?utf-8?B?dVphKytQdlRYQThydlRaMStWeHhXZnJjT2lFYk1HVUFZckNRRTR1eElwQlNI?=
 =?utf-8?B?N0xOTmdUZnprZTAzUVlDbDVlN1VKWmtGZU40N1RjNk1USHgrWTZpNnlIcjlw?=
 =?utf-8?B?UTJ2aXIyeFYrZ1hjTFpHZEdDKzF1dmtvT3NWSU1QYzhVanZBUkxhWnFuTG5K?=
 =?utf-8?B?RFFCc2tuMVNSa2Z2V2x3K3hDVFFWVnl1Y2FnNmo0TjFNU0JraXdscGdhSEdN?=
 =?utf-8?B?SGprR1Zsb2NKT2l0RUMrblYvSnAwVXFhRXZ1UXRocEhsTzBuV1dzS0syeHJR?=
 =?utf-8?B?bUU5OGEwWFgrazZIelpISkd6TVI0anNoaURPTEV0RmtDeTJIbGh4OHQxY3Zn?=
 =?utf-8?B?U0RKZ3I5STVidkxiZ2pwaXBGRmJBWGc2clRXaFIxM1R0dUVrdmMrQ2c3MXdX?=
 =?utf-8?B?MlcyUWxERFRBYm1lMzRGaVJVWnFEYU1LYjcxU2hBMlBQLzhYZU1IUnFBY1gv?=
 =?utf-8?B?UkpVdWVkZnBOMlJzckdaYWc2TG5US2FvbytubDVnZWVGUVZKMmluOFp1Nytv?=
 =?utf-8?B?SFJYRUlIalNSNTk5TXQwakdLTU56dGcyNlkrUEE4cTJXQWl2RDZkWEE5N0o0?=
 =?utf-8?B?WlpiWDNTd0xrQ2g0eWJlelJMZVFxcUEyeHRTU1NmZmJkb2UvM0QyTDMvZTM5?=
 =?utf-8?B?Q0NBMHJxV0o1cjlWdElVOGlHaEtiZyt3QjZwVEpIVWNVTm5nZEI0eUprMWtF?=
 =?utf-8?B?OU5BM3hMdmZQdnp1OHdvS0orTmdBekJBUUdtaUJCczRwNmdpYUJUaHNmdExa?=
 =?utf-8?B?SUlCdndHRU5HNlhvR3VScXJSK1NrME1ob2J0cHRIak5lWitsNW1WSTVQcUcw?=
 =?utf-8?B?bTRJWkZha3F2SEIzTE9HNE81TVhqdDZmVUlxdG8wNXRLcGFwZmVlT2ZZRUVG?=
 =?utf-8?B?TCtBcmY2SmFFbVYvL1ZLOTdwcis3ZXpjVHFXMlJ0ZGlqcDJGWmp5ajdvQUlX?=
 =?utf-8?B?Q0xTK3g3WVczK2tEeHloYUYwOFJPY2FnWFo2VkUydENyb2NnYnhmUkpsaFNx?=
 =?utf-8?B?RE9PNzV3MWxPaWFpTUxna2FEL1NQc3dRQXdDL25GMnhkT0VpREI0VERRTnFX?=
 =?utf-8?B?dE5aRklwK2luVktqdXkrODBUcEZDS2RCL05sLzMrc2tMNnNXeEFXZVF1ZmRq?=
 =?utf-8?B?d0N2SThZUGEwNE43NktUSUFJUEZheXBYYk1kMUZ5ODA3cm5hUVFYSlI4QWU5?=
 =?utf-8?B?a3Y2ZzNnTnZmbWFJb2VNSVp2dnNUeEdKV2x1VndOWEhKcGJnZFZrdVFqTHd1?=
 =?utf-8?B?dGhtRXN6WnY5eXhtd0ltQ3ZRRXNhQ25YUWlsN1VIVVR4Y3JNd3l1UVZwQXBk?=
 =?utf-8?B?Vlh3SjZlVEZ1RGN6L0Y5SUMvVW9sRUliTS82REVKMXNZbU0rNXY1a3VQaGZV?=
 =?utf-8?B?bUptQXVRcEE5ZFEzaWZMR1dIckZqUkd2NnQvWGQ4MkwrM0FMSWRjaXM3M2FL?=
 =?utf-8?B?Ym9VYm1pYVhCQ3J1Qkcxay9oT3FpVVZKRXBqNldvbVRxR253azZsQkpmRlVX?=
 =?utf-8?B?MnRJQ0U5dnhneExJd0NkZmc3clI2aWppZ0o0WHZESURwSlZscGZYVVJTSEhp?=
 =?utf-8?B?d0lXNmpvaDQrVzgyR01MYWRPSi91TjhlU0hTYlBFZ0FOcmZvbGRHb3JzSlly?=
 =?utf-8?B?NFVhdk9pUU1DanJRVVA0TW5nMUxVMEFFOUl5OUx0MEVLZHREbGVPVEhOTTds?=
 =?utf-8?B?Mmh0NWV3dFJlNEJhd2QyNlljZVMrV2xrN3VZRFdXQjFyWUJXWU42WUl0UVpH?=
 =?utf-8?B?d3NqTXZwdGVTNGpsdkRGdzkvbmNvc0w3eHVINU1va0FTRmJMb1VWSnJSOVJF?=
 =?utf-8?B?UlM3Y285KzdPN3F1UVlkejdEeEg4clZJMlphT2VuVEt3b0dDcnF3UXdQVzUy?=
 =?utf-8?B?eTRMMkI3Y3VSSlpGMm81QjZHdEovNVFTaHZoOWt2MzVzWCtCdmZqa1R6cHpX?=
 =?utf-8?B?MzdMWDdLMEtacUR5RzJ6R0NOM2EwbEVwckIrcnloMFJydW9teWpZWDJCdUcx?=
 =?utf-8?Q?07Uc=3D?=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(35042699022)(7416014)(14060799003)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 11:09:39.0956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a2f2c3-1a9c-4209-06ca-08de2692f77a
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB10936
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

PiBGcm9tOiBNYXJrdXMgU2NobmVpZGVyLVBhcmdtYW5uIChUSS5jb20pIDxtc3BAYmF5bGlicmUu
Y29tPg0KPiBzY2FsZV92Y29yZXNfZ2VuZXJpYygpIGNhbGxzIGZ1bmN0aW9ucyBpbXBsZW1lbnRl
ZCBpbiB0cHM2NTkxMC5jLCBub3QNCj4gdHBzNjU5MTBfZG0uYy4gQ2hhbmdlIGd1YXJkIGZyb20g
Q09ORklHX0RNX1BNSUNfVFBTNjU5MTAgdG8NCj4gQ09ORklHX1NQTF9QT1dFUl9UUFM2NTkxMC4N
Cj4gDQo+IEZpeGVzOiAwYjlmZjA4NTE1OTIgKCJib2FyZDogdGk6IGFtMzM1eDogRG8gbm90IGNh
bGwgZGlzYWJsZWQgUE1JQyBmdW5jdGlvbnMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgU2No
bmVpZGVyLVBhcmdtYW5uIChUSS5jb20pIDxtc3BAYmF5bGlicmUuY29tPg0KPiAtLS0NCj4gIGJv
YXJkL3RpL2FtMzM1eC9ib2FyZC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvdGkvYW0zMzV4
L2JvYXJkLmMgYi9ib2FyZC90aS9hbTMzNXgvYm9hcmQuYw0KPiBpbmRleA0KPiA3MTI4MThlYzIz
NTYyZmFkODVmZWJmNjYxNmFlYTNjZWExYTNhOWVhLi45MGUzN2E4ZDkxMzMwMzY1YmI1ZjI3YzM3
DQo+IDFiZTdiOTc0OWRlOWZkZSAxMDA2NDQNCj4gLS0tIGEvYm9hcmQvdGkvYW0zMzV4L2JvYXJk
LmMNCj4gKysrIGIvYm9hcmQvdGkvYW0zMzV4L2JvYXJkLmMNCj4gQEAgLTQyOSw3ICs0MjksNyBA
QCB2b2lkIHNjYWxlX3Zjb3Jlc19nZW5lcmljKGludCBmcmVxKQ0KPiAgew0KPiAgCWludCBzaWxf
cmV2LCBtcHVfdmRkOw0KPiANCj4gLQlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX0RNX1BNSUNfVFBT
NjU5MTApKQ0KPiArCWlmICghSVNfRU5BQkxFRChDT05GSUdfU1BMX1BPV0VSX1RQUzY1OTEwKSkN
Cj4gIAkJcmV0dXJuOw0KPiANCj4gIAkvKg0KPiANCj4gLS0NCj4gMi41MS4wDQoNCkFja2VkLWJ5
OiBNYWFydGVuIEJyb2NrIDxtYWFydGVuLmJyb2NrQHN0dGxzLm5sPg0KDQo=
