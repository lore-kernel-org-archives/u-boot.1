Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1A606A880
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gauEqcO5;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=YFU4JtpO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 015B6607D9;
	Mon, 16 Nov 2026 13:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bj6zpkhfJ_RY; Mon, 16 Nov 2026 13:54:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C34C607B5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794837256;
	b=nWB5NJAGCZRygA6qXTmM4jAgGDvs+56E92ntuu53hR+uVx5C04oKxK4gb0dvdquDy92V
	 Ss+LQZ7RTz3nAc/wysXzhzCmsCp8Ya15EJYFEDbiJtejqU1Ve1ucZIv7ciFGsTWfKkePG
	 FCGkWquiOhgGhfZ8+r0YgdUdy9v0jcnFHjNNMb4CA6S6xS1LTVDEOCkZlFb/OTGDsBJuh
	 o9Sm/W/QdebDm3ExxAq523mxW4UtkvQGj2SNS80z8jkk1ZmjMjgWNqcM26mN90fl+9t8w
	 xzs1kh68SblUAXzXXlYktqQQTp78ArpLeILz5uWjOmohX6dbO6U9nLSg/b19KGonZvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837256;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bs/dQGAxcVUaaemG0Y2SLYPERyfruF4OwvfLn3ICbxQ=;
	b=bsKiZX0R+38EeGE1TU0W0JvCcDr3dYuz2Y6tsv/pLXulf5t31045bVYY8ExV6VczZgL4
	 D+UP/znf0lsHPdjaamFct5dY4F587UsNvDpT8Y9M+E5aLpT9QG8S7iZGs1UHJgoAGw7bn
	 KRi4lTPHRB4KfK1AYiUhnmHGBNW1NSukbP5HK3lapQSlzijyYV6R17GhErz9cfULkFbsP
	 KzASFNlSE9Zh1tAutOhdqqqr4lEm7uIUIFjIfPLCMoSrcNXSKDtFyMu9MBqUuro7GasXq
	 3Y4Im03bb6ylIt3/RNVbz9yMiLrZC66chHtFIuZkmrUwMGWJJr01A5+x/1si2xVBOHQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794837256;
	bh=bs/dQGAxcVUaaemG0Y2SLYPERyfruF4OwvfLn3ICbxQ=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gauEqcO5RECpGpWHsX53ftWwXaPAsyqxHlZhxVvIf4KuvPGA5Ap9a+IHr9PowD1uI
	 Z3vZjhLXSNFTvPcLtj8Z/pft+W6VASJBB1k/C69HMJonIneuUs1AkclLP34Yc1hJTK
	 RaZ622O63TGbs1QaYAlM/kPWp7Fc7k+QiU6B4nRa6pknS++C/kC0Yu2alhR3xE4A/M
	 YxogNTRCDLYc9sl8l+ce7emHZScxgGa1Yd0UwybMSw6j5oQezTOn1qITP0h9sEsFjV
	 2IVh5wpAwzGmXZknlQ17D7rvTQ8o8KQ8nTfVVUQneOkBeKiq5sww5l9zEiRL1z1J6t
	 9FDA9Q/uQftBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C34C607B5;
	Mon, 16 Nov 2026 13:54:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 528E8109
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 38BC7400D5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:54:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZK6ulW1_w3Gs for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 13:54:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CA1774009D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=y.moog@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=YFU4JtpO
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA1774009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bs/dQGAxcVUaaemG0Y2SLYPERyfruF4OwvfLn3ICbxQ=;
 b=YFU4JtpOFSxBzX4s9dxuQZ3LdTwmpFAg5DQeOQcDY42k6b68qMubCRno+rCwqE+Rkt1t94jRiaqdiEEBdu7L9WH3/Po1YJxNHqKsJfC3LlpF1j4wphStppgDpU2+hLBK3myHa2ClybNJ7rLrCymxo+27edhsxRMWs51GvLhi24bVLgtGI89ojwneUNftmRzCaWdUtryp0RzMbPDPCXYBaSfcE+oZc/lOQt3QTKMmH/ALrZ8ss+4M765Iw7n3KynYTqg47yUhBW6BwcMU3tx/9SkrIKOhN4kZXCUp8vDWFR/z1xIt7cD/uqBPLL9+7PJUSJ7YTmJJc1vhtYpNJltjxg==
Received: from PAZP264CA0119.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1ef::12)
 by PA3P195MB2876.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:4b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 13:54:05 +0000
Received: from MAD0EPF000008C5.eurprd05.prod.outlook.com
 (2603:10a6:102:1ef:cafe::aa) by PAZP264CA0119.outlook.office365.com
 (2603:10a6:102:1ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 13:54:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.50.189) smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: Fail (protection.outlook.com: domain of phytec.de does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Postix.phytec.de;
Received: from Postix.phytec.de (91.26.50.189) by
 MAD0EPF000008C5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 13:54:03 +0000
Received: from [192.168.2.222] (172.25.39.168) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 16 Nov
 2026 14:53:59 +0100
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 0/2] board: phytec: update i.MX 8MP Libra RDK to new revision
Date: Mon, 16 Nov 2026 14:53:49 +0100
Message-ID: <20261116-wip-y-moog-phytec-de-bspimx8m-4196-v1-0-e44000b3d3d0@phytec.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO0K+2oC/yXNQQ6CMBBA0auQWTsJBYOtVzEsaDvCmJQ2HVQI4
 e5WXb7N/zsIZSaBa7VDphcLx7lAnSpw0zCPhOyLoambTqm6xTcn3DDEOGKatoUcekIricOqA56
 V6dC03upBG7o4ghJKme68/ia3/m952ge55VuG4/gAidAo+oYAAAA=
X-Change-ID: 20261103-wip-y-moog-phytec-de-bspimx8m-4196-93db8a89e7ce
To: NXP i.MX U-Boot Team <uboot-imx@nxp.com>,
 <u-boot@lists.u-boot-project.org>, <upstream@lists.phytec.de>
CC: Benjamin Hahn <b.hahn@phytec.de>, Christian Hemp <C.Hemp@phytec.de>, "Jan
 Remmet" <j.remmet@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Stefano Babic" <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Yannic Moog <y.moog@phytec.de>, Peng Fan <peng.fan@nxp.com>, Adam Ford
 <aford173@gmail.com>, =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794837239; l=2263;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=1Zrw0esEzAm3bgFwk8+EQb5ERsmgMHPpgHiZnR06BQY=;
 b=w1RO+8pKQ4et2pcMBGXN7CXserIwWlOK7l20DLHVvMykGUfwiQy6IVs0z6s/7G004VVDP/eEh
 tqZremebbh2CBLQUYD+3O5+Wd8C1BPBtHu3GuPH2BKJIZZjSqyUAcCE
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C5:EE_|PA3P195MB2876:EE_
X-MS-Office365-Filtering-Correlation-Id: 74414f94-17a9-4703-46cb-08df43e91324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|23010399003|36860700016|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261022075727099003|261021135927099003|261026140227099003|261026121527099003|261022105027099003|261022115727099003|261028144727099003|261102123227099003|261009223327099003|261009223027099003|261009221727099003|261009220027099003|261009221227099003|18002099003;
X-Microsoft-Antispam-Message-Info: gmuGXw98MI9VsPy5d7yGV1vW1h0/bmUx/3wA9XEKN1YHyyuOCBhKrvsVE1xqPj47VfAYkffB6KBTypjUTiy+xCWVIJdauNeQrB7o1d6LMVztMlYpYwPADY0ZIEqVpg6D6la9cP0r30Oz3GQ7koFQSXuoVXsRXqCC8AY+tlYCgyQD4CYRA8Zd8CFrGV980N41e2VDiY86P7kHPcbSuEb5z4m9B9TQNu7rFwkBV5bXR8yNLdoHbfq9x0gjnCimQ2i8Tf6Dlt4pVkW7IH3scpZeqUqjdfzwiBk4qQxM7/a+dEWa+1VyRCde7KmNjsDmJYZdLMhtMPtLU/sKTUVTG0op7yHNYf/Ff796O5TY/KnVafwwpZLJ21lSEK89YoaKYO+OGI4tPklKPU6JMJBbsaaiJtriy8fyMBpHaNAscDGvp/4hR71ZVIeIczazuyxBEW5i0DnQ2EMgKkYLpUtr3G9FyCs0GHi8X2Z1ZT7Gq3GZm4recWDsK2rr8qvj1W9JdEoy//soRKr1x04V2rCGXnJZcO44GTodZCBsItfj4zhlM3oW4AYNNMyApQXMwIQehjpPOOgLcXPWZtCHt3PJNL+5UXvuT7cBocS5476xhrA+frqXSBNG/6Hqa1HmxcWMg/0BjSbl9c+sBiXEcNWw3Q12XA==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261021135927099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022115727099003)(261028144727099003)(261102123227099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009220027099003)(261009221227099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fF5ngGmxRWDM7cXGl0ymQeJXrfknENOG9NXp8Kml8/qzPPQ56VnJEBjto5Sw9+ii4kHpJCPqAM3Lly18djWnDAJ0aPMxErU0oT6fGyYvi4OKrXNzxUFlZMGjYq0hTY30pJ6t8SzQx6NCaOAQKX1VyrYmR/14ax9kUs8PcBH1+Oqw80KgYb8cFHbnGaeeiKXprn3Fphjem7JdJh320f8aNq7y/ZU0rLqzJWHDE1cswgC6hJBC+xUXEySQkgb00rSlyG14XCDav+Dyp10wSyJujvyKjSM9K5DtggLcPvHftc8f9UlH7fJAGV/PVJyJ01J10WgMPeDBzMTZarlku7B5bd8umReWujlGrNXm0zcLMRAeoOaxGN56lDutiGGesxjr58pkxPqld/h51828TM9v6/t/OwL3gvR3nt8qLJSif636Q0EScjy2rW4jHIWrO3L3
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:54:03.6534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74414f94-17a9-4703-46cb-08df43e91324
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P195MB2876
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The goal of this series is to add support for a new revision of the
i.MX 8M Plus FPSC product. The product has been renamed since.
As a result, add new files corresponding to the new name and then remove
the succeeded board.

The board does not use OF_UPSTREAM, yet. The device tree has been sent
to the kernel [1]. The board will use OF_UPSTREAM once kernel device
tree is synced.

[1] https://lore.kernel.org/linux-arm-kernel/20261116-imx8mp-phyflex-v1-0-4adcf8b4d373@phytec.de

---
Yannic Moog (2):
      board: phytec: add phyFLEX-i.MX 8M Plus Libra RDK support
      board: phytec: remove imx8mp-libra-fpsc

 arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi     | 149 ----
 arch/arm/dts/imx8mp-phyflex-fpsc-g-som.dtsi        | 858 +++++++++++++++++++++
 arch/arm/dts/imx8mp-phyflex-libra-rdk-u-boot.dtsi  |  68 ++
 arch/arm/dts/imx8mp-phyflex-libra-rdk.dts          | 592 ++++++++++++++
 arch/arm/mach-imx/imx8m/Kconfig                    |  10 +-
 board/phytec/common/imx8m_som_detection.h          |   7 +
 board/phytec/imx8mp-libra-fpsc/Kconfig             |  16 -
 board/phytec/imx8mp-libra-fpsc/MAINTAINERS         |  10 -
 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c |  89 ---
 board/phytec/imx8mp-phyflex-libra-rdk/Kconfig      |  45 ++
 board/phytec/imx8mp-phyflex-libra-rdk/MAINTAINERS  |  11 +
 .../Makefile                                       |   4 +-
 .../imx8mp-phyflex-libra-rdk.c                     | 120 +++
 .../imx8mp-phyflex-libra-rdk.env}                  |   3 +-
 .../imximage-8mp-sd.cfg                            |   1 -
 .../lpddr4_timing.c                                |  66 +-
 .../imx8mp-phyflex-libra-rdk/lpddr4_timing.h       |  11 +
 .../spl.c                                          |  40 +-
 ...efconfig => imx8mp-phyflex-libra-rdk_defconfig} |  18 +-
 ...libra-fpsc.rst => imx8mp-phyflex-libra-rdk.rst} |  13 +-
 doc/board/phytec/index.rst                         |   2 +-
 ...8mp-libra-fpsc.h => imx8mp-phyflex-libra-rdk.h} |  13 +-
 22 files changed, 1825 insertions(+), 321 deletions(-)
---
base-commit: c26b629e58d053e3bc9cd3d2d1a034850ce58022
change-id: 20261103-wip-y-moog-phytec-de-bspimx8m-4196-93db8a89e7ce

Best regards,
--  
Yannic Moog <y.moog@phytec.de>

