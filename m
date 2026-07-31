Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E81C5516D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 14:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 826BC60B08;
	Fri, 31 Jul 2026 14:22:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RSrxF-AEfFuH; Fri, 31 Jul 2026 14:21:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D4756061E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785507719;
	bh=jb4ZdJgBsDW6GWPf50lzWIfQbEomYoGaqMZffXF9A7Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j+uEfvnOxs0/++e1elxYDh+AI9Olb4ryQKK0vU3mymdLiQ2qAnjzF0v/EUBP5Sn+Y
	 2AZv5L4Q45bu2m8l/gLv/AQEvzNxuO3STka6PbjPZGpIZX0W0C4/OyfeVgEA90EVwl
	 ntzW0rQwHiYUKDYk6YD32FI80Zo7c1ivvzNi5hivq7X0EqroT6s+2XaV5D8gGMQ/bY
	 bnE7KSs47HjD3vbPyUpd6WYkKp92TsvaC8wB668GK7uYEtHfQ2RcK8Bt1HrHy5YO9j
	 8crPI2Z1wJ6qCgJl2oo+K+xvT/0MzjNOsc+d/Y7B7MKFLRgjK6UmoD4kfnX9qrBp+U
	 StCmuEijtJvhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D4756061E;
	Fri, 31 Jul 2026 14:21:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 03EA637F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:21:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01F4A410F2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:21:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3juqUtBT1jiy for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 14:21:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=maarten.brock@sttls.nl; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 288DC40F41
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 288DC40F41
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 288DC40F41
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfCLD4IOw96wMu51O3qmL6IMkkUz3QEYHtuL1ptvM2pDo//oHxXVRIq2FcsXO5tUst9aN2+7QeqXZqbfEcdJoQfJh4WFCa/Dm3qQZSH7JjxTCYjqhzZZ/Ol7L5pvEWB4UAe8KquFG99ICekWYffVN2P5dhMLyRb1T2zekmT3ToOGZgLQeWnLZfNBU0hlR0YhDF7kui/uSYz+qRJ8TmgCtqH1LBDlCpUK91hMwb2DFN7TiYx7EVvbdl6Imm76LfTZOdca8NYo/9p3xZINgqJgorq6sQCerBH1l2M5kAWzo/OwD4eRuPrZgy3Rcu0ZYGChCn8X99HIBvh4JZR5zLtJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb4ZdJgBsDW6GWPf50lzWIfQbEomYoGaqMZffXF9A7Y=;
 b=OsZohEAs7+itWKNdEPh3KpQbSQ4v59oHT3OU67B1JM6LE3DBxPUd1GOQ92ClXNeQkWLEhBdM2l2uJoIA+9q90z5Z8za1x2EvWiChwwMH4tp4x59VmGT2jmbMOJlNWXNGLpqLcHtJOCIlwulf22253gsfNXQUnLAmyVolpM8/GNOCxnDu/WVRcJdiyW40cLygKvCBIsgCJktLKz4iIRfXzEVbpW3DiExG9scKsiQs01PsE1F/olQEbbNqSDLqED/fU+wuIDbHfLW9F0I97WAMF7fWgR8WsIJUk14UuDYB18hs/neIVqAQG6NKd/ZxrVnoiJotEmYI3QBNcO3+LmOanw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
Received: from DU7P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::17)
 by PAXPR05MB8304.eurprd05.prod.outlook.com (2603:10a6:102:152::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 14:21:47 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::35) by DU7P191CA0013.outlook.office365.com
 (2603:10a6:10:54e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 14:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 31 Jul 2026 14:21:46 +0000
Received: from DB3PR08CU002.outbound.protection.outlook.com (40.93.64.86) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Fri, 31 Jul 2026 14:21:46 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by AM8PR05MB8113.eurprd05.prod.outlook.com
 (2603:10a6:20b:366::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 14:21:44 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 14:21:44 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: RE: [PATCH v2] power: regulator: tps65219: Fix LDO selector boundaries
Thread-Topic: [PATCH v2] power: regulator: tps65219: Fix LDO selector
 boundaries
Thread-Index: AQHdIO+vgDQ3juGV50iMjEi2XeS96LaHq9Ig
Date: Fri, 31 Jul 2026 14:21:44 +0000
Message-ID: <GV2PR05MB119411F0042BF3F6705E81E8E83C82@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20260731013643.28244-1-bhimesh.matsa@gmail.com>
 <20260731125133.10998-1-bhimesh.matsa@gmail.com>
In-Reply-To: <20260731125133.10998-1-bhimesh.matsa@gmail.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|AM8PR05MB8113:EE_|DU2PEPF00028D04:EE_|PAXPR05MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 842b9432-d75d-4cc3-f2fd-08deef0f0df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|6133799003|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 10DIWj6gCLbL36KRTk+e49nz+8Dz+uJJShjtZ6mK7fu2jephGfVEQ616eZZac25Po+e2UrzoMpwU0owhfJK6l0AAXLeDtzHkNU3uwbdT3uy2YqJGY4l3oP5IJLZSHX2CQGpf0c2rQPYXEFS9+viKybYOJEJaFufmmd9QWOkyoZzka3IEy7uXW+IpBSJW1dXaGNIjiWH0GjHX5IBnUzJXmW/bXHKlnVn3f901z+7CZ+bJ+QZh0biOA740Ey/4mP+4Wm0cbPL0iRWPeRXrVsLTvmkqlbchfYOxGj3Yn08MaUSq4UuiSLBiMwVfO4F2Bjx8F5TSz4LHJXEszn5GTw6XEFtfKW0GaZSytyMi98qs4lITo8rqwnrX3a0XQxVoO3rbThoemVa4AKhE1AetO5dJ6w20HwGegIZmQ9FwyT/KxYecsU5lsVDZS45ip4d7pm4KoOyDl7Kva6GrwA9B3Q6y92hDd8vOptPXZJ2bf9cLCLaNanHaMdUUqRrRgcSpQNov83xb+VD+HtAPleRWwvEz/m+gX9QKLmnziCWvfTlZA00se8SZfCi1wg+3jW7d4evo60zwN7nbwutpIEfzUTGOP3NeW/qXMRhbDePUqXvLmw4f839aeUfFv7cE7Lm3g2o+qeVsK0qwO00fFTF5lUtPlNk8FC2RJw4d0HOV+rEOhvMbNLxjz9dksRqYGCQBY6+gUmZDv6X+YBqRQv8rKj+I4mnyBGrjfROlsMoZe446eWY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(6133799003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aIlkinQs4s1jZ9qxmJYC+IXlcCWsiQALn5u6WclVZnE5lKigWi4CcIQBvdDRxFQOy33POl7oIUm1ENUTDV9c5VXZ9cBmMkWzlxTSesF3nzsaMo5tU112nzQCl/j49ZWODNHlz4uAm+K3r/lhjuAMyQ4ptrqG+wN2qLlMPNezSX6HZGNDBM32bBSgh6fzn+0oNLlD+l0VNa6mTADpsStqYX+iTBTAYaAM/PTCuIe7LkSaxlkTTrkstQrNEQyUJx+d5I0B+neqe7jdY7Qe1eCwP/h6sBqk4ZBA/7BUzTUnz6+sv0scI/1+Sihs/C88SB/dbHk+pZvjDDWoiFoIGypFVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB8113
X-CodeTwo-MessageID: cbd6edbb-83c4-4357-b237-22f7fb5e5eb5.20260731142146@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9b29b80d-2859-4715-0f7f-08deef0f0c33
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|14060799003|1800799024|35042699022|6133799003|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: k5J5pxTnrLjhxm3JxW65My7E2Wy/c0mDiJFUYsFW3wU8w5++ho244e4Y0eQfomzDdGOUHypBrzAIxGqWMIYlWohcN0QLoWwUzSEKMYsEmaZmm8mzLqOoQq3pawGB9XkuthGZgVvaEF6fhoWjvUqynth8UhWoZ/7yXWCEXMwCNC5f2vc6JgsKu3+BVk6BzgFlI8c1BKET8NAepkIfsD4wdamKq2Cl7/GjBlCBxXZK53gMBXm+bq2aKoJB6+Iohy4kStpKYp5NvbYbrC3u7d8h0bA3I3p2StE6QGtlfSZJJw/cQ0o3uknlf8YcKGPYz8Qj5VSNxTKelYj83XyFdF6hqEEz4DqQO7PUMZywbboTuis95ZOWizTmJN8HhH2TPtG3liseSY30akWdk6WRsySMwYKqkSKEYCk1sLrnOJbOxwWRmNDIXfoAaPgwIAxnIssUpA0hQ4seWrxOBGgu9N9Dg4pUF2/Ygjxn8HYlLWWhW5wL1EVZX5/+X5zrfNy7SAWEo4yrPO8LHHVJyAd/xegORAYWuYExUkwj+vQS3fVaiuBdUYl77yZyYdHC1qqi8G622pbSTUqvDqYBRIlTxC/0qa/Ilp+lwCIo86YeLFK0yGsmF6M35z4k6AKxWiJDdrp4zwXTtom+9Nglzn2CNQSGdZnW+Qtt2bj4fc0+8+NRQLnaatKqbYNahKnxEZRXUpoLFmHo9Xx3r6kZ37uMospIYw==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(14060799003)(1800799024)(35042699022)(6133799003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ARtTjECgpLJk2G0DtObvQiivBWZwz+d84GbJIDEvQZy5Y4GMkQUkduTVA4vGbnvRUaiyHEj6K2KYWQYzOnDiYByJ672vsu6jS4quLrZcUR8e7GK4Y4tmE9zNBrV2qhmEeRlfb/FY/XdkOVQHzJIpS6Xur7qaUgfeUwjxPsUb9LNAGGYIp/JEuvtrzVArx/qvNOFI5w229AEMJUncNhuVmcdfD6Fv9xrF4X7MAeSohEcvgimxD5gTuommbedsAgitTgP0bsmNiUn6hc6IbHSrkZi2FMiIEM3GsbOuq9uoloaxcmuzSxp5ecFjVuXMxgOxhZl3DnNOuko6Xth0JuKV2RwVwv+fRk71TwIr1RCPejIGqGZaDKZkOWPFCyifIX8I0dTL0jUvGfJFTkZJqpPnZYcNDbb9LCIlwxWqUdRz1zr28A8D/i/DXLaq44YZBjzR
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 14:21:46.9484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 842b9432-d75d-4cc3-f2fd-08deef0f0df4
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB8304
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb4ZdJgBsDW6GWPf50lzWIfQbEomYoGaqMZffXF9A7Y=;
 b=OivIrsROZ05n3jtmu/9jJns2OmRU1yeHK/aSxt6w/8cHV3ty9LAGaFB5dy5lJMnL3i2kES7rQHznKHWmoa9vhPuxjsjUfqxzJWJIlcIO6AOW43iezyygf3Bh694rKvx6SpC97IT17YqqB4Xb3+uH98iI8zBTJyT2l+sN3ynf+essdijde2fA2mvNug2eW6PQYbrDwk3ArnywsW+Yx87Zterdk1a553/OnEQE4iZzwD+2Jv+Pw8BIQs47vVRMRGflT/nknIwl7NeP+76ZnqFkgdPhydeTUWDI56NFZ1qjIHiYQShdrhqsX729Lo57d4e73JZZWn65RNeGc1mlOfgeOA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=sttls.nl
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sttls.nl header.i=@sttls.nl header.a=rsa-sha256
 header.s=selector1 header.b=OivIrsRO
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

PiBGcm9tOiBVLUJvb3QgPHUtYm9vdC1ib3VuY2VzQGxpc3RzLnUtYm9vdC1wcm9qZWN0Lm9yZz4g
T24gQmVoYWxmIE9mIEt1bWFyYSBCaGltZXN3YXJhcmFvIE1hdHNhDQo+IA0KPiBBY2NvcmRpbmcg
dG8gdGhlIFRQUzY1MjE5IGRhdGFzaGVldCwgc2VsZWN0b3JzIDB4MzggdGhyb3VnaCAweDNmDQo+
IG1hcCB0byAzLjQgViBmb3IgTERPMSBhbmQgTERPMi4NCj4gDQo+IEZvciBMRE8zIGFuZCBMRE80
LCBzZWxlY3RvcnMgMHgwMCB0aHJvdWdoIDB4MGMgbWFwIHRvIDEuMiBWLA0KPiB3aGlsZSBzZWxl
Y3RvcnMgMHgzNiB0aHJvdWdoIDB4M2YgbWFwIHRvIDMuMyBWLg0KPiANCj4gVGhlIGRyaXZlciBj
dXJyZW50bHkgdXNlcyAweDU2LCAweDEyLCBhbmQgMHg1NCBhcyBzZWxlY3RvciBib3VuZGFyeQ0K
PiB2YWx1ZXMuIFRoZXNlIHZhbHVlcyBkbyBub3QgbWF0Y2ggdGhlIHNlbGVjdG9yIGJvdW5kYXJp
ZXMgZGVmaW5lZCBieQ0KPiB0aGUgZGF0YXNoZWV0Lg0KPiANCj4gVXNlIHRoZSBjb3JyZWN0IHNl
bGVjdG9yIGJvdW5kYXJ5IHZhbHVlcyBvZiAweDM4LCAweDBjLCBhbmQgMHgzNi4NCj4gDQo+ICAj
ZGVmaW5lIFRQUzY1MjE5X0xETzEyX1ZPTFRfTUlOCQkgNjAwMDAwDQo+ICAjZGVmaW5lIFRQUzY1
MjE5X0xETzEyX1ZPTFRfTUFYCQkzNDAwMDAwDQo+ICAjZGVmaW5lIFRQUzY1MjE5X0xETzEyX1ZP
TFRfUkVHX01JTgkwDQo+IC0jZGVmaW5lIFRQUzY1MjE5X0xETzEyX1ZPTFRfUkVHX01BWAkweDU2
DQo+ICsjZGVmaW5lIFRQUzY1MjE5X0xETzEyX1ZPTFRfUkVHX01BWAkweDM4DQoNCklmIHRoZSBt
YXhpbXVtIGZvciAzLjRWIGlzIDB4M2YgdGhlbiB3aHkgZG8geW91IHVzZSAweDM4IGhlcmU/DQoN
Cj4gICNkZWZpbmUgVFBTNjUyMTlfTERPMzRfVk9MVF9NSU4JCTEyMDAwMDANCj4gICNkZWZpbmUg
VFBTNjUyMTlfTERPMzRfVk9MVF9NQVgJCTMzMDAwMDANCj4gLSNkZWZpbmUgVFBTNjUyMTlfTERP
MzRfVk9MVF9SRUdfTUlOCTB4MTINCj4gLSNkZWZpbmUgVFBTNjUyMTlfTERPMzRfVk9MVF9SRUdf
TUFYCTB4NTQNCj4gKyNkZWZpbmUgVFBTNjUyMTlfTERPMzRfVk9MVF9SRUdfTUlOCTB4MGMNCg0K
SWYgdGhlIG1pbmltdW0gZm9yIDEuMlYgaXMgMHgwMCB0aGVuIHdoeSBkbyB5b3UgdXNlIDB4MGMg
aGVyZT8NCg0KPiArI2RlZmluZSBUUFM2NTIxOV9MRE8zNF9WT0xUX1JFR19NQVgJMHgzNg0KDQpJ
ZiB0aGUgbWF4aW11bSBmb3IgMy4zViBpcyAweDNmIHRoZW4gd2h5IGRvIHlvdSB1c2UgMHgzNiBo
ZXJlPw0KDQpLaW5kIHJlZ2FyZHMsDQpNYWFydGVuIEJyb2NrDQoNCg==
