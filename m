Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A62CD8CA8
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 02:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14458848D8;
	Wed, 10 Jun 2026 04:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="QzH5B6aL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A58B8849AA; Wed, 10 Jun 2026 04:18:02 +0200 (CEST)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64AC5848D7
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 04:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan_chen@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dR2FG22UIxtkufQD8apLCfo/6yC31lVlxylvp4svJC6S2wkcXI+uzWas5ejgB6IyTnizz4ECkYi2SJJ84/vRkybJlJKzyIq5W/elZVANOe0W6HEpS4OpIQOgs/+ukJWzNW6HV9p5cKGnsenCdW3REegVcFR5qJMA2zuKwdfZCrSgdl2w85gUnWJm28Fum32+VBAenoRNG10wIqhjku0ElJ2Rk9uzocqaRQ+aCEoHWhmIEGESm6h+y0VMYWwTcikTjI3Bpso5kLM2iMHJTjiRROTmLQoPEVi73kG3uoMZOxtn7Fe17HhjVh2Ki+XLKyDm6ZYjLEA3W2o5FLuF8q2JPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIRas9SWCcc4jJMfscAUSCN98GS7RvA57ZJCdJnMIEg=;
 b=tz1NVBoQkgquMq7fkDDs2Fe7RZ1GEGZGmwYvEsDyAt9tAjLgXSOf2Z47YO3zerq9/uY0byJdowuwraucHhtvEBD79lJ825rCjPNIztqCgS1AtBpQewx/rV0sQSrbUDmndqKjZQ+HRZl9z3OjUvFqS9SN84R/mK8V4nmyOzdZRmQjhZcUEuWJH/42sxEmYLxi3CAzUPwMreSPcwqO2qcG06A7v378FqFLgl9331IwEKrHYXmfJUIZcwaXhe0GtHapPGcVYY3JAtw8PLpUglj8FDNGKNgLHv/ueKUAckoC4EpRbAJSelwBmcnIL4PAiPKwKIF/jHdb8miUKKltj6kkvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIRas9SWCcc4jJMfscAUSCN98GS7RvA57ZJCdJnMIEg=;
 b=QzH5B6aL6smYGv8R9Vg51h/alxKdLKvlTnUCKKJGsTEzFWe4AuTYCwLh4Lz8Dy5SJwYVjH4RcBGPZXcJF4UN5gS0785ZcO0FUuMtfgLJtJgkots+lfoqZ7mKPLCSvpuduB7NryOAnku/c5KkNuvo6plrCwi7dRLwu5+KgMloDiG46XAHstRRt2GKtx70It6lEudICVLI9VQhAcx/6DXUrBApl6cVOsOW0qReUTjQBRiGPVZ2Zp7IoY9R9UGioDiBfYhTjHxhZCyifJWzmliKlRVYC1pv15xZgt88VVp7ge6bkGTnsuU1EX8AFsZuCaAYOHHTMeJVPyE3MYr1tzmHDw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TY8PR06MB9270.apcprd06.prod.outlook.com (2603:1096:405:3b1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 02:17:53 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::b696:e104:1f5e:7838]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::b696:e104:1f5e:7838%7]) with mapi id 15.21.0092.007; Wed, 10 Jun 2026
 02:17:53 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, BMC-SW <BMC-SW@aspeedtech.com>, Joel
 Stanley <joel@jms.id.au>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, ChiaWei
 Wang <chiawei_wang@aspeedtech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Tien
 Fong Chee <tien.fong.chee@altera.com>, Andre Przywara
 <andre.przywara@arm.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Peng Fan <peng.fan@nxp.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Brian Sune <briansune@gmail.com>, Johan
 Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, David Lechner
 <dlechner@baylibre.com>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Janne Grunau <j@jannau.net>, Paul Kocialkowski <contact@paulk.fr>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, Kuan-Wei
 Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Philip Molloy
 <philip.molloy@analog.com>
Subject: RE: [PATCH v3 0/5] arm: aspeed: add initial AST2700 SoC support
Thread-Topic: [PATCH v3 0/5] arm: aspeed: add initial AST2700 SoC support
Thread-Index: AQHc7Ke8r8q9DzgzU0apsQGQASmET7Y3JRJQ
Date: Wed, 10 Jun 2026 02:17:53 +0000
Message-ID: <TY2PPF5CB9A1BE61846EEBD7BD6648BE188F21A2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260526-ast2700_clk-v3-0-a4cd24c214d6@aspeedtech.com>
In-Reply-To: <20260526-ast2700_clk-v3-0-a4cd24c214d6@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TY8PR06MB9270:EE_
x-ms-office365-filtering-correlation-id: 06c98a17-6e66-4e13-2834-08dec6967a87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: SAb+uNaXRoBGFG4pYbLT5qD0rElWFW5fL8GXGTIMH5/6/MDETE2RnLEBdAKmhVuAwor1r1pDxZgOsB1G/b7iRcTVMn2Cbf54EplHdA9mn3U/+MpodbhS2F0LVGEwj7oAfSnCrb0M1PddaTpEG6Jr0+fefv2xnc2xV4Oh60nMsTNQa++8c+fA61f2911XLV6tuLb/EXIk0r6EzEoXRFBQ9QUyn56sqhFzVZgx2xHpqAXpSaYMhp46znqrXx9DvMFyxWdrRv0/vtPiz0/swJItOI6KU0B7PmGkyVnUvYLaDxHFCwfUv68gWMz6oIin+S8N+TKpchm+1b2vzaaJbSfjVRCLwp+2k/K3nRzI6EEjHA1iknK8mfvTQYGQsYBeo3CbUzYxjF472P1V8bKXy4oyDgieWaEByCGwsGK7NkZTZcOzcALOVUM2ay6OJ5N8FhvRcmroaohduXQUeWKvbQiNLPgKrCi8QXAbv6rMqQa/ugH4tFUG3n4Z8x4ZUePxvlnymiIlsUr1tdHbcf8ZmN7aBzfnVz/UOm5LjMqAnuGOFus8dkUWBDOWZzCcTUFR5BbrSO/5VQLLOHAw5nJ/0Yq4oi4iu2GSskQ1kIzmvQf3/E1l7EfY/hlqKMqk/hFji/JN83oBaiewKqKRs9roWvC5+bAWHXqU2kDHwIoLbEA6Sb13nB/2akc+FSvwusgG/3fYAN6gaSNROwq78SB98Yc4lqiFnAvi9UA8CcCerYRKfVEIY3YGAe7mjKFFrpS0CJWu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cURZU0l4UHVoa3JaRUFEeERINFc5ZVdnTXU1dXNJVndZeGluYm9PdER4d2ZJ?=
 =?utf-8?B?c20xMm5jNFluT0hBWi91SzdQME1GSVR6dzZwUmNWWm9TWFZHY1M3L2tmUlhl?=
 =?utf-8?B?UWdWajdCQllQbHdwbFl4ZXZwN1NBa1FpOG5UQUlmQjZQUi9IUUcwSzI2dmdO?=
 =?utf-8?B?VFVKV0lIblE0K1p2bVJ4VzBaaHNPUnRQTGphOUJxczZXa0lhUVh3Q2xJeTJV?=
 =?utf-8?B?ckpUMDhYU044SFh4M3h0Y0U2SlpmMzV2aDM2S0RlNzhZVThFd29UZUpZUE1J?=
 =?utf-8?B?SXNBeDBVQko2VGRTSzF6cmlBdEdDcmI4QUR0V2ttTFBmb3d2V2x1cVJHMVZV?=
 =?utf-8?B?eWRTNGJJVm5tTndnNS9RNHR4Y3hHUTRUdDlzUkQyRjdQazVBdytseW9QM04z?=
 =?utf-8?B?ZkxuYXVpb3JqK0JhUXFQU2ZtMGVBbDMvMVQ4ZU45SjFQT1hMTmR0b1I3bGVr?=
 =?utf-8?B?bnR3Z1VNSkQwNzJVR005a0pLdkZmVE11b052S2QvcWRLUkF6cFp6VzlXOE11?=
 =?utf-8?B?NFc2VDFhZ3FGMVFKRTlYMHk3cytYWng5Vk1Tc1c1Sk9SSnduNTd3YUtVUGta?=
 =?utf-8?B?UUFKN0wrck51T3hTNitzSEhGMUgzTEpnek8rbHB4Z1p5bC9Rd2dXbnErMnRk?=
 =?utf-8?B?Q21SVVRsay9ZeHN1UGNPN0prc2Y0WGVWamxqSnJUVWdNc2FlVjZnSGJNOHln?=
 =?utf-8?B?M3ZIOUo2Z01HZHhxWWZtM3cxUkg4cW9ZakUzckdaQTdhdnFKTW45bXhrUVBU?=
 =?utf-8?B?Q1lMNUJRTnFsVklxVHluNnlCT3FPUzQraHdTTUF5bHovU1NMd0VWQ3kxSDNO?=
 =?utf-8?B?clhIT0JaZ2xwck5POFV0eXVWZE91dnR4ei9iazk4VG9od0UwUWdKOVZkelhs?=
 =?utf-8?B?MFFRUXRiWU1yZXV2dEVzaVZlYXNlY3Z5M0tCY1NleWo0d09PVWJxTFlMczg4?=
 =?utf-8?B?dXluTmdySmpsVXBCdUYvV2ZqR0FQSTdsbHAzUjU3bXZZZ0tISUdHR0NqRy9x?=
 =?utf-8?B?aXYraS9SZmFXU29FeTBZVWJDUVpDVTBPN1duWHpaOTQvSURqQStQWmk5Y3hq?=
 =?utf-8?B?MjJSRkMzZVh4aXFRZDRFOTVzTVJxQS9janFJMTIxMWg2SkdiOWVtRldNdThl?=
 =?utf-8?B?Y1JERU5Jc2c3QVBSUVNSZU4wSkQxc3RWUVJsZWxEc2ZRVE1LUUdyUVBQcGdj?=
 =?utf-8?B?WHBQaDlDM3pQMlVuZ1cwaWZhMk5HVXRLZm5wZG9Yc0Y0QmdUdnVWL05VOFBs?=
 =?utf-8?B?QWhqVUpFOTBrQS80WFV1N2xPcTE0aXQ1WndTZXcrbFJ3YmlWL0FZNlpBcGtq?=
 =?utf-8?B?KzFwWUdTOHNPSlZKWnh2L3c3dWlONDVWRTI4bzJERDVqZUxEdEhtMjVqUnBk?=
 =?utf-8?B?dW1kNmRqZEJGZU1nR0k1T1granVOa1UrU2hEZkNYRE80dGRmY0RWRi9yRW5L?=
 =?utf-8?B?YWF5WDNGa2JPci9PWG40SVNlMGltQkpxczJPUklNRXdLcHhZOXl5bXpNZFZk?=
 =?utf-8?B?emNCVm92WVhuWFkxdkM3OHhWakdxdUtQK1AwbTJuNzhIVm5ZTG5BRXJDR0hk?=
 =?utf-8?B?R1ZUQnNNODE3ZnArdXJCTGVGb0RlMU5PMm5venc4OFJ5b3R4eUhaTUdpYmJH?=
 =?utf-8?B?R3JFTkkvZ2czVVIyTXVVYjd4QlJGREhCU2JteWlBais3bDRvQnpkaDBjZURi?=
 =?utf-8?B?LytHTGpobGV6TUFnMTZGbjh5TlBzUDRhTzVtaGNwRW9PNWQ5VVJ1TnFtdWdT?=
 =?utf-8?B?R1F5elZubk5YdHdYeEpOZTliNkpudGQ0TnNnUkpOZk0xempjNVVKY1VQZzQ4?=
 =?utf-8?B?cm1NSzRKUHFrMDJGV2tTbVRKckpzR2FpQWI2L2lzcEV1bllXcWFVbDAvMFJK?=
 =?utf-8?B?ZXRsVSs4b3g5UGZ0OFdTTEJ0b2QrYmd0Z1ZIUENWYlZoVTljMzBPWG92ZElj?=
 =?utf-8?B?L1BqblFZcVZhNFBFeFB5ZGlJb3RYNmlQa1hpd3BLZU83Q0g1M2JBMVZHdWtQ?=
 =?utf-8?B?aDYxUmloSEc4V0FDTXBGalNtSzRSdnBPVDVNMnY0RGpESSs1V2w2TVI0aXdB?=
 =?utf-8?B?aEFzak9YT21XUWEvZG4ybmpUVEQ5YUpXZFRSV0s5cENkRHVmUVlZNmQxMkFK?=
 =?utf-8?B?RG9YeGdhQkhiRkVtUHFxcTRNdGVkUGRmbk9hbmcyMjJ5NFR2KzBwdHRwVTl2?=
 =?utf-8?B?eDJwWnJWYmdqcm1nSW9sdldLSFhQZUJzSmpPbGtzemtIZE1iV3NQZVpQME16?=
 =?utf-8?B?T2pjOXlsU1VWc3MxdkRLUHdqendXNDYrR3NKNEpaTnZyL2UrQTlWOUU3YzBm?=
 =?utf-8?B?cnVmRWVaMnFzbUFDWmxRRmpnZXpYcHY4cWVGMHdVZWp3QmZzb3V5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IQYrDGtI5CgiSMdhY1D9rpujKuAvlqvr7uZ4/y2/q4eMCFI/Fgw3d2+nhjNxjrdindm5enCsCt/iz9nl+77ewTlPWFZ+HUBT/AaoifVwDfRXfUnOAg3LJYL209/DTdI+Zszm8kOUtISZDsPoHPAQinTkFMBPO9dI2Kxy/kXaZKxgo0gXiK0oSBysLaJgy4OwljDW53oxHJjF8jUEnGLuIS/ytzfKZZmukGNdHUPtyPczkkYKd6xuFRbef+4Idog7Gbj/5T1uCIqfaPRlW1qM0IsiZIl7RlRnok9yO07AxhUjMMdImbW/8S15I0rAw7zwJpgh51tUHz43N2JYc2iJFw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c98a17-6e66-4e13-2834-08dec6967a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 02:17:53.5934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PIIEAwEh+5wtwHLstUGeEaR5QpFZd+TWrL/QSRW9fYmhaPTqL3nuUd+m4OGpO//veq/27xpOfeWMrkCkhNvZ6c3BS1L0SNCAjxUMEcylvlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR06MB9270
X-Mailman-Approved-At: Wed, 10 Jun 2026 04:22:34 +0200
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

SGVsbG8gVG9tLA0KCVdpbGwgdGhpcyBBU1QyNzAwIFNvQyBwYXRjaCBzZXJpZXMgY2FuIGJlZW4g
bWVyZ2VkPw0KUnlhbiBDaGVuDQoNCj4gU3ViamVjdDogW1BBVENIIHYzIDAvNV0gYXJtOiBhc3Bl
ZWQ6IGFkZCBpbml0aWFsIEFTVDI3MDAgU29DIHN1cHBvcnQNCj4gDQo+IEFTVDI3MDAgaXMgdGhl
IDh0aCBnZW5lcmF0aW9uIG9mIEludGVncmF0ZWQgUmVtb3RlIE1hbmFnZW1lbnQgUHJvY2Vzc29y
DQo+IGludHJvZHVjZWQgYnkgQVNQRUVEIFRlY2hub2xvZ3kgSW5jLiBJdCBpcyBhIEJvYXJkIE1h
bmFnZW1lbnQgQ29udHJvbGxlcg0KPiAoQk1DKSBTb0MgZmFtaWx5IHdpdGggYSBkdWFsLWRpZSBh
cmNoaXRlY3R1cmU6DQo+IFNvQzAgKCJDUFUiIGRpZSB3aXRoIGZvdXIgQVJNIENvcnRleC1BMzUg
YXBwbGljYXRpb24gY29yZXMpIGFuZA0KPiBTb0MxICgiSU8iIGRpZSB3aXRoIHBlcmlwaGVyYWxz
KSBlYWNoIFNvQyBoYXZlIGl0cyBvd24gU0NVIFBMTHMsIGNsb2NrIGRpdmlkZXJzDQo+IGFuZCBy
ZXNldCBkb21haW5zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUnlhbiBDaGVuIDxyeWFuX2NoZW5A
YXNwZWVkdGVjaC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYzOg0KPiAgIC0gbWFjaDogYWRk
ICJOOiBhc3QyNzAwIiB0byB0aGUgQVJNIEFTUEVFRCBNQUlOVEFJTkVSUyBlbnRyeS4NCj4gICAt
IExpbmsgdG8gdjI6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjA1MjAtYXN0Mjcw
MF9jbGstdjItMC1jNzc4YjI5MDhlNWVAYXNwZWVkdGUNCj4gY2guY29tDQo+IENoYW5nZXMgaW4g
djI6DQo+ICAgLSB2MSBvbmx5IGhhdmUgY2xrIGRyaXZlciwgdjIgYXBwbHkgZnVsbCBBU1QyNzAw
IHBsYXRmb3JtIGFuZA0KPiAgICAgcmVzZXQsIGNsaywgcmFtIGRyaXZlci4NCj4gICAtIE1vdmUg
c2N1X2FzdDI3MDAuaCBmcm9tIHRoZSBjbGsgcGF0Y2ggaW50byB0aGUgbWFjaC1hc3BlZWQNCj4g
ICAtIHBhdGNoIHNvIHRoZSBTb0MgaGVhZGVyIGlzIHByb3ZpZGVkIGFsb25nc2lkZSB0aGUgU29D
IGNvZGUNCj4gICAgIHRoYXQgY29uc3VtZXMgaXQuDQo+ICAgTGluayB0byB2MToNCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDUwOC1hc3QyNzAwX2Nsay12MS0xLTI3OTdhNjI2YTIz
OEBhc3BlZWR0DQo+IGVjaC5jb20NCj4gDQo+IC0tLQ0KPiBSeWFuIENoZW4gKDUpOg0KPiAgICAg
ICBhcm06IGFzcGVlZDogYWRkIEFTUEVFRCBBU1QyNzAwIFNvQyBmYW1pbHkgc3VwcG9ydA0KPiAg
ICAgICBhcm06IGR0czogYXNwZWVkOiBBZGQgaW5pdGlhbCBBU1QyN3h4IFNvQyBkZXZpY2UgdHJl
ZQ0KPiAgICAgICBjbGs6IGFzdDI3MDA6IGFkZCBjbG9jayBkcml2ZXIgc3VwcG9ydA0KPiAgICAg
ICByZXNldDogYXN0MjcwMDogYWRkIHJlc2V0IGRyaXZlciBzdXBwb3J0DQo+ICAgICAgIHJhbTog
YXNwZWVkOiBhZGQgU0RSQU0gY29udHJvbGxlciBkcml2ZXIgZm9yIEFTVDI3MDANCj4gDQo+ICBN
QUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4g
IGFyY2gvYXJtL2R0cy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0K
PiAgYXJjaC9hcm0vZHRzL2FzdDI3MDAtZXZiLmR0cyAgICAgICAgICAgICAgICAgICB8ICA4OCAr
KysNCj4gIGFyY2gvYXJtL2R0cy9hc3QyNzAwLXUtYm9vdC5kdHNpICAgICAgICAgICAgICAgfCAg
MjUgKw0KPiAgYXJjaC9hcm0vZHRzL2FzdDI3MDAuZHRzaSAgICAgICAgICAgICAgICAgICAgICB8
IDY5Mw0KPiArKysrKysrKysrKysrKysrKysNCj4gIGFyY2gvYXJtL2luY2x1ZGUvYXNtL2FyY2gt
YXNwZWVkL2ZtY19oZHIuaCAgICAgfCAgNTIgKysNCj4gIGFyY2gvYXJtL2luY2x1ZGUvYXNtL2Fy
Y2gtYXNwZWVkL3BsYXRmb3JtLmggICAgfCAgMzAgKy0NCj4gIGFyY2gvYXJtL2luY2x1ZGUvYXNt
L2FyY2gtYXNwZWVkL3NjdS5oICAgICAgICAgfCAxNDUgKysrKw0KPiAgYXJjaC9hcm0vaW5jbHVk
ZS9hc20vYXJjaC1hc3BlZWQvc2N1X2FzdDI3MDAuaCB8IDUxNCArKysrKysrKysrKysrDQo+ICBh
cmNoL2FybS9pbmNsdWRlL2FzbS9hcmNoLWFzcGVlZC9zZHJhbS5oICAgICAgIHwgMTM3ICsrKysN
Cj4gIGFyY2gvYXJtL21hY2gtYXNwZWVkL0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAgMTEg
Kw0KPiAgYXJjaC9hcm0vbWFjaC1hc3BlZWQvTWFrZWZpbGUgICAgICAgICAgICAgICAgICB8ICAg
MSArDQo+ICBhcmNoL2FybS9tYWNoLWFzcGVlZC9hc3QyNzAwL0tjb25maWcgICAgICAgICAgIHwg
IDM2ICsNCj4gIGFyY2gvYXJtL21hY2gtYXNwZWVkL2FzdDI3MDAvTWFrZWZpbGUgICAgICAgICAg
fCAgIDIgKw0KPiAgYXJjaC9hcm0vbWFjaC1hc3BlZWQvYXN0MjcwMC9hcm02NC1tbXUuYyAgICAg
ICB8ICA0MyArKw0KPiAgYXJjaC9hcm0vbWFjaC1hc3BlZWQvYXN0MjcwMC9ib2FyZF9jb21tb24u
YyAgICB8ICA5MCArKysNCj4gIGFyY2gvYXJtL21hY2gtYXNwZWVkL2FzdDI3MDAvY3B1LWluZm8u
YyAgICAgICAgfCAxMTQgKysrDQo+ICBhcmNoL2FybS9tYWNoLWFzcGVlZC9hc3QyNzAwL2xvd2xl
dmVsX2luaXQuUyAgIHwgMTMyICsrKysNCj4gIGFyY2gvYXJtL21hY2gtYXNwZWVkL2FzdDI3MDAv
cGxhdGZvcm0uYyAgICAgICAgfCAgNjQgKysNCj4gIGJvYXJkL2FzcGVlZC9ldmJfYXN0MjcwMC9L
Y29uZmlnICAgICAgICAgICAgICAgfCAgMTMgKw0KPiAgYm9hcmQvYXNwZWVkL2V2Yl9hc3QyNzAw
L01ha2VmaWxlICAgICAgICAgICAgICB8ICAgMSArDQo+ICBib2FyZC9hc3BlZWQvZXZiX2FzdDI3
MDAvZXZiX2FzdDI3MDAuYyAgICAgICAgIHwgICA1ICsNCj4gIGNvbmZpZ3MvZXZiLWFzdDI3MDBf
ZGVmY29uZmlnICAgICAgICAgICAgICAgICAgfCAxNDkgKysrKw0KPiAgZHJpdmVycy9jbGsvYXNw
ZWVkL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2Nsay9h
c3BlZWQvY2xrX2FzdDI3MDAuYyAgICAgICAgICAgICAgIHwgOTUyDQo+ICsrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gIGRyaXZlcnMvcmFtL2FzcGVlZC9LY29uZmlnICAgICAgICAgICAgICAg
ICAgICAgfCAgIDQgKy0NCj4gIGRyaXZlcnMvcmFtL2FzcGVlZC9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgICAgfCAgIDIgKy0NCj4gIGRyaXZlcnMvcmFtL2FzcGVlZC9zZHJhbV9hc3QyNzAwLmMg
ICAgICAgICAgICAgfCAgMTUgKy0NCj4gIGRyaXZlcnMvcmVzZXQvS2NvbmZpZyAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDkgKw0KPiAgZHJpdmVycy9yZXNldC9NYWtlZmlsZSAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL3Jlc2V0L3Jlc2V0LWFzdDI3MDAu
YyAgICAgICAgICAgICAgICAgIHwgIDgyICsrKw0KPiAgaW5jbHVkZS9jb25maWdzL2V2Yl9hc3Qy
NzAwLmggICAgICAgICAgICAgICAgICB8ICA1OCArKw0KPiAgMzIgZmlsZXMgY2hhbmdlZCwgMzQ2
MyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDM4
ZGJlNjM3YzlkZmNhZGJkMWJjMjAxYmZiYjI3Zjk2YjJhZDUyNWENCj4gY2hhbmdlLWlkOiAyMDI2
MDMyNy1hc3QyNzAwX2Nsay0yNThlYWNiOWQ3MDMNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0N
Cj4gUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+DQoNCg==
