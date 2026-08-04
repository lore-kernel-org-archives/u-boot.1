Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0F8C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 14:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 128A36075B;
	Tue,  4 Aug 2026 14:44:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ymIMPf7Zl2i9; Tue,  4 Aug 2026 14:44:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C89106065E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785854661;
	bh=ypnX9/0tKFiH5tQ8DNRNTkn4Gk1tlOkuIB9I8bOICOg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lj1hzYTV9Ha/2bgzYhFtMpt4spympCESQSZvawQba/A4CZjU8sPqRVyNOs0uXBfwx
	 MXlScyBqM0t9UqWvyMDyShSzJ7qRLlwPy0N7kSv0f7qlbAKj2e2w1w5hIcM/EgYWZp
	 iq6zjkbIg7lsbzR/Yb45ESQac57/p+S1Q/YhRj8e9e3cpetE1HKbXoeADwWmr3C521
	 k1s0kBLDKNAb2BIkIrKl8GpjKL6DTumicBvJJlcQZ89ovGdydOX2/3isHPuS0yqxKi
	 Q/f+Y6yRtlhQ7Jc0Ix4kDZ/L8nU6XPeMHDuliFlJyFB/GM+Kt0OE4c4p2ECzEkTjcv
	 +4gGAP7PDsFFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C89106065E;
	Tue,  4 Aug 2026 14:44:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ABE5A218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA3148065C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:44:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ty3LgwtveNzm for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 14:44:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=maarten.brock@sttls.nl; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3AC0280C21
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3AC0280C21
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3AC0280C21
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/ce4n3LVNs/JnIATDJfKAWFlUJ2ExMKTS22iAe6jfHMT+xFfgBqEgof9vOo37noNna5bVlYyw3v8zkotqrjr2kZPFPEqQ77QryO1fNv8r8PDtYpR75KSI/L4GaE6l7k9cK51pihG4n6g0jWO88fnDewtix/zxeVwpWrIXEC9ip/C1vB6S5IZu8wWajLzMIYKSQlVQdOyI/kd40/Zop0eI2nnRiAMksBAGAktrZa2UK+Uz7Q5lt9Kj+T1LOM/+ou2xXM2FGlVm4MQYHNtZYvdoKrXe9QjPb6uClSD8TpOpS41me3ztqwk7zP1jZfJ7jxRp5/j6xhYgxmu4MSD6mWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GD3XZTr67FeeuQOWpeQSYdHm65OZKQ/RzpkrrkLQ+vg=;
 b=LMt7LPsL7UXJpNC8ejGulXMM/JTMUvNTHwgQefyOyoSEB3q5VthoXcyvwtd1kOJ8ud4c+ZpSDOGw+IXlkubBHvmFwda6Enxj08IZzItFaNi3r6yaNwneUFRH8IjMHCP1PFuGerirnrohXpd07QWfbZ9eYXJNelt4/Vs/dX0J52UeTv0IvtfsrIAvPX7sVIIT9hUmMQoh8to6vbY7BIhPjqVUylE5J4N33AunYL+7WmepgaBg3+X8tDd8dctO9nsofSucVMZ699hBLq4kP3QBXoOmE42DUSijkNS4d3aO1O1aie0DMVLcMQgqumbKxQYJarlrTORYO6fPbOn9bBKhfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
Received: from AS4P192CA0027.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::17)
 by VI0PR05MB11571.eurprd05.prod.outlook.com (2603:10a6:800:26a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 14:44:12 +0000
Received: from AMS0EPF000001A6.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::92) by AS4P192CA0027.outlook.office365.com
 (2603:10a6:20b:5e1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 14:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS0EPF000001A6.mail.protection.outlook.com (10.167.16.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 14:44:10 +0000
Received: from DB3PR08CU002.outbound.protection.outlook.com (40.93.64.87) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 04 Aug 2026 14:44:10 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by AS8PR05MB8278.eurprd05.prod.outlook.com
 (2603:10a6:20b:33a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 14:44:08 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 14:44:07 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Kumara Bhimeswararao <bhimesh.matsa@gmail.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>, Tom Rini
 <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: RE: [PATCH v2] power: regulator: tps65219: Fix LDO selector boundaries
Thread-Topic: [PATCH v2] power: regulator: tps65219: Fix LDO selector
 boundaries
Thread-Index: AQHdIO+vgDQ3juGV50iMjEi2XeS96LaHq9IggAEYUoCABTaF4A==
Date: Tue, 4 Aug 2026 14:44:07 +0000
Message-ID: <GV2PR05MB119417EEE35B83CD0DFA0BA9983D42@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20260731013643.28244-1-bhimesh.matsa@gmail.com>
 <20260731125133.10998-1-bhimesh.matsa@gmail.com>
 <GV2PR05MB119411F0042BF3F6705E81E8E83C82@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <CAKoOE-J==fVUAj7uOjrymrOCoQy4=cKDm+Kj275+SvW-5wB05Q@mail.gmail.com>
In-Reply-To: <CAKoOE-J==fVUAj7uOjrymrOCoQy4=cKDm+Kj275+SvW-5wB05Q@mail.gmail.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|AS8PR05MB8278:EE_|AMS0EPF000001A6:EE_|VI0PR05MB11571:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f2ed25-5be3-49d1-bfca-08def236d892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|6133799003|56012099006|10067099003|4143699003|8096899003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: CuMktnidCamDwOpQTZ4ze0WFgwrZk1uejWlvcic/bjPDkwl8CcBdpCEROjqzyZoVuV3X9A8+mLqqQW7Ze6EjcCZCaRrFNzi+2VNGkNip8x9VMM5sCIUCrXNrOPdbohCYa8z+q9x3HRxXdN+XEC28FzkZ7oB4RKCaTHZx4PRg0tEz4RjYOu5uvVJGsQKE+4Tg+AzL2GRSRmIyp+8BjstoUCzfibGyCoEp7SPuyxeDjAA8Y/Af/kfrNlzcvR7alNoVW7aoXWsS0C+dh1jkjW2ICmums28tZb6VVOSIJGQhYa2eKT2Yhr2Z3WxJX4BfOLQPTnW3UsXE7dOP+T8slbWCPQnlHeqkkv1mGbp+YXW8dfTdqgViaPOAfk9dW8kv1x0cDm3I/MiKhDXXXpMEA974WpauE1gdMO5ripRD8hEDkmSEPpcrI/tq6WiPqhnpt2XOdiUGmuBw7yxKfIEEZLuMnOY6V3ZC1MCmkOMcljwVngjSK/0zVcnoWnNw1zkRtjuCd4kAa/V/RbectRM/1z0SIFNU9s1PISXwYZ0TDyK2M5MVfQ4uRhK+lm+o0UBBbLyz/J8AMp6FQ4Fbz4zdvy/kR6R7TBSQ05LJ2sTjySNRT4BhOOHda7ZiOCSnkF5E4hH8Mi1vdNHjbLnfahmP+mVk0WCmUBiIpo78iNjIp11Vi4LCsa4oGmtTx8o3Hz24KCpVDZV+Y/Upv7xc96CQgwjOZk5bvCtf7Qf5FqE7RkhNyYU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hziXEEpMyLVmbGZzQtuEOUOnQ1hkx95+l5pbngeNWe5vMUpnTjjxqOQepXROLO4Yfw9mO6unFpKEwWNX1mqJReuzZAGvShVMCeE4sbH9O3Kmw+rX0WeealPWuF4YOWRrIkHwuKz5Ru2wTj+6/CRIQtNkHjmCNFEqXFhC5uGtFUDLRJHfnIolxPLALk6P1WdAc0E24Ts2VT0MAsodfKf11SfGn4hcNiT1s+Z0jQ7aqxqaRYBScY8XqweDG76sZ0TIEpxyydcVLXvKHDh46tATM3xUunUh+uN8g7oQoddFS3rD5frEKiG/1ue4BhIbDSg1NoGjtQH0erRoI2037W1wHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB8278
X-CodeTwo-MessageID: a38dce0e-c02a-401b-9f05-e9133e6e008c.20260804144410@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4e5a6303-19e3-4a67-2901-08def236d6ae
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|30052699003|82310400026|14060799003|35042699022|376014|4143699003|56012099006|10067099003|6133799003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: OBqcTiyk21kIXeO1W+eobwvWLzLo8sz8hai28R8L0Cho+B/V+cYO6+jlMvRtsgZ8DIMk2DXf9hKWVSy8Mfgw2TY0A4jVKLvsSFlMsrCA95wUM+m4RpnTK7bgCjWTFm2+h2wiqPi6lZfdLdOrwfSNMCgfPPW59xbkCVJJMAzjQoDOEFiQySuHRJ3/4OvduHN0cnmIcIrSbUFs68dStFETBhfoXLp0WLk8DKCPq5clApTsTvrN2tLuhYwZXs6fqBtbb30pz1CrgXqT0XR8EQojEwDoVG6ZRoChT6SWQRK1PLEJsPP2zjDxHcJIPSoBmOfGxFOWu24kjN8BfqId5a2Rw9JMEKeX+S3EmkLKdbRWhh0AZhTx2gnNmbLQJe2agKK8hGk75Uji9XDo04xlzy1XM36mAN5j+0lVqSchsuXnv0R9s9MtqHLijn/Dc2qvbtllMwronBddxW14mGL9KQAcIvflDolYLdRfqLqnMWlblYcGdbInN4eLQcpx+lELYP+Pe56GQQuD0SqpuDC8Mtq7GFLfGgFXFOoGgtUTm4/JjmoL38tfZUFzzEkWmEjpEhir5uH9GDmKDF5Q2hPLVW0CrMoMWYV2dd7pLw+eu+BRk1zbn3KzxR6vjg4LhFFRpIvvn19Ne51Wa1ps1rDQosLBar/xza/jUTUttwTIlVWEvG/GkEn6K6J7BYpfJutw4xQizvkFyvO7NPHltRJw3BrwBg==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(30052699003)(82310400026)(14060799003)(35042699022)(376014)(4143699003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BkiwvCMu43O5BFneIuZBSLjl7efQGY41utnI7E09SZlLDHPYEYeLnITJjyxGwX2msBcNC1cW3k5SFiH3cjV0D8vXQ6z5FWmPHN8UD9hDT9CdBrZ6qXXhLqsSX93ex93IFKjeVk+Ml8/yzRLcdtUHKtM6sWLXZvmKYV/53tmkldj17rr3+JhbOfltoNqGSpCwWh0SUO4iQqTEY6jGgIiQR/75dvMRdoNMCjI9GTZlCRYKUwcZOgo8VqrGSLW2oqCOUDyBSaK8/HQL32N27N4VYr09z5vV6/lxNMmAHSBf9oMDiRxIP0MF8xuDsD2mekcCviI/dj3LJ4nw3MeUuMwlE6EH2M2221QhRRemFhGqvC6Dq75iGy5fnGNHfr5cAIrJFxXODv/OltP4+oTGI70Y1cYeD6XIOeqOz6EQuVCYNfK2zS8jjG6kKgm8uhTQdf2v
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:44:10.8592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f2ed25-5be3-49d1-bfca-08def236d892
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR05MB11571
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD3XZTr67FeeuQOWpeQSYdHm65OZKQ/RzpkrrkLQ+vg=;
 b=VKO7K9yQQgaVdLqbK6PhOVIDtP6zGMdnKL4OAM9z5CVtwvYGidhaGUbvuY1RegOhzC4lnaVn9myzmBSY9jaqIPahikthomq+WJzuKauD40qdF6mzD6RSbNCN8eK/QSy7/pw9VMMGNNjg9MtvcQN0KrQ2RT/NDy2hu7HDughoMSiNiAjuWGnhJoPr0/v8T9k89ItNxGTuj/fsBi8tjwmICEaZnfoQIAKmmfPYdnXOaJPOP4DrYofzOmmVK2c2qF6nrXSTjRqVq2NTmuDkNVXwiAgxUTT7x/NJSujWrAd72W+Z+L6UgrqkOA8iG9dbGUZGyk9W00RNABedV5XOyHosXA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=sttls.nl
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sttls.nl header.i=@sttls.nl header.a=rsa-sha256
 header.s=selector1 header.b=VKO7K9yQ
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

SGVsbG8gS3VtYXJhLA0KDQpUaGFua3MuIEkgdW5kZXJzdGFuZCBub3cuIFRoZSB2YWx1ZXMgYXJl
IHVzZWQgZm9yIGludGVycG9sYXRpb24uDQoNCk1heWJlIHlvdSBjYW4gcmVwbGFjZSAnbWFwJyB3
aXRoICdzYXR1cmF0ZScgaW4geW91ciBjb21taXQgbG9nID8NCkFuZCBhZGQgJ2ZvciBpbnRlcnBv
bGF0aW9uJyBhZnRlcjoNCidVc2UgdGhlIGNvcnJlY3Qgc2VsZWN0b3IgYm91bmRhcnkgdmFsdWVz
IG9mIDB4MzgsIDB4MGMsIGFuZCAweDM2LicNCg0KS2luZCByZWdhcmRzLA0KTWFhcnRlbiBCcm9j
aw0KDQpGcm9tOiBLdW1hcmEgQmhpbWVzd2FyYXJhbyA8YmhpbWVzaC5tYXRzYUBnbWFpbC5jb20+
DQpTZW50OiBTYXR1cmRheSAxIEF1Z3VzdCAyMDI2IDg6NTcNClRvOiBNYWFydGVuIEJyb2NrIDxN
YWFydGVuLkJyb2NrQHN0dGxzLm5sPg0KQ2M6IEphZWhvb24gQ2h1bmcgPGpoODAuY2h1bmdAc2Ft
c3VuZy5jb20+OyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IHUtYm9vdEBsaXN0cy51LWJv
b3QtcHJvamVjdC5vcmc7IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBOZWlsIEFybXN0
cm9uZyA8bmVpbC5hcm1zdHJvbmdAbGluYXJvLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJd
IHBvd2VyOiByZWd1bGF0b3I6IHRwczY1MjE5OiBGaXggTERPIHNlbGVjdG9yIGJvdW5kYXJpZXMN
Cg0KSGkgTWFhcnRlbiwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpUaGVzZSBtYWNyb3Mg
YXJlIHVzZWQgYXMgdGhlIHNhdHVyYXRpb24gYm91bmRhcmllcyBpbg0KdHBzNjUyMTlfbGRvX3Zh
bDJ2b2x0KCksIHdoaWNoIHVzZXM6DQoNCmlmICh2YWwgPj0gcmVnX21heCkNCnJldHVybiBtYXg7
DQplbHNlIGlmICh2YWwgPD0gcmVnX2Jhc2UpDQpyZXR1cm4gYmFzZTsNCg0KVGhlcmVmb3JlLCB0
aGV5IHJlcHJlc2VudCB0aGUgZmlyc3Qgb3IgbGFzdCBzZWxlY3RvciBpbiB0aGUgc2F0dXJhdGVk
DQpyYW5nZSByYXRoZXIgdGhhbiB0aGUgbnVtZXJpY2FsbHkgaGlnaGVzdCBvciBsb3dlc3Qgc2Vs
ZWN0b3IgdmFsdWUuDQoNCkFjY29yZGluZyB0byBUYWJsZSA3LTIgb2YgdGhlIFRQUzY1MjE5IGRh
dGFzaGVldDoNCg0KLSBMRE8xL0xETzI6IHNlbGVjdG9ycyAweDM4LTB4M2YgYWxsIG1hcCB0byAz
LjQgViwgc28gcmVnX21heCBpcyAweDM4Lg0KLSBMRE8zL0xETzQ6IHNlbGVjdG9ycyAweDAwLTB4
MGMgYWxsIG1hcCB0byAxLjIgViwgc28gcmVnX2Jhc2UgaXMgMHgwYy4NCi0gTERPMy9MRE80OiBz
ZWxlY3RvcnMgMHgzNi0weDNmIGFsbCBtYXAgdG8gMy4zIFYsIHNvIHJlZ19tYXggaXMgMHgzNi4N
Cg0KVXNpbmcgMHgzZiBvciAweDAwIGhlcmUgd291bGQgbm90IGNvcnJlY3RseSBjb3ZlciB0aGUg
ZW50aXJlIHNhdHVyYXRlZA0KcmFuZ2VzIHdpdGggdGhlIGN1cnJlbnQgPj0gYW5kIDw9IGNvbXBh
cmlzb25zLg0KDQpEb2VzIHRoYXQgY2xhcmlmeSB0aGUgcmVhc29uaW5nIGJlaGluZCB0aGVzZSBi
b3VuZGFyeSB2YWx1ZXM/DQoNCktpbmQgcmVnYXJkcywNCkt1bWFyYSBCaGltZXN3YXJhbyBNYXRz
YQ0KDQpPbiBGcmksIEp1bCAzMSwgMjAyNiBhdCA3OjUx4oCvUE0gTWFhcnRlbiBCcm9jayA8TWFh
cnRlbi5Ccm9ja0BzdHRscy5ubDxtYWlsdG86TWFhcnRlbi5Ccm9ja0BzdHRscy5ubD4+IHdyb3Rl
Og0KPiBGcm9tOiBVLUJvb3QgPHUtYm9vdC1ib3VuY2VzQGxpc3RzLnUtYm9vdC1wcm9qZWN0Lm9y
ZzxtYWlsdG86dS1ib290LWJvdW5jZXNAbGlzdHMudS1ib290LXByb2plY3Qub3JnPj4gT24gQmVo
YWxmIE9mIEt1bWFyYSBCaGltZXN3YXJhcmFvIE1hdHNhDQo+DQo+IEFjY29yZGluZyB0byB0aGUg
VFBTNjUyMTkgZGF0YXNoZWV0LCBzZWxlY3RvcnMgMHgzOCB0aHJvdWdoIDB4M2YNCj4gbWFwIHRv
IDMuNCBWIGZvciBMRE8xIGFuZCBMRE8yLg0KPg0KPiBGb3IgTERPMyBhbmQgTERPNCwgc2VsZWN0
b3JzIDB4MDAgdGhyb3VnaCAweDBjIG1hcCB0byAxLjIgViwNCj4gd2hpbGUgc2VsZWN0b3JzIDB4
MzYgdGhyb3VnaCAweDNmIG1hcCB0byAzLjMgVi4NCj4NCj4gVGhlIGRyaXZlciBjdXJyZW50bHkg
dXNlcyAweDU2LCAweDEyLCBhbmQgMHg1NCBhcyBzZWxlY3RvciBib3VuZGFyeQ0KPiB2YWx1ZXMu
IFRoZXNlIHZhbHVlcyBkbyBub3QgbWF0Y2ggdGhlIHNlbGVjdG9yIGJvdW5kYXJpZXMgZGVmaW5l
ZCBieQ0KPiB0aGUgZGF0YXNoZWV0Lg0KPg0KPiBVc2UgdGhlIGNvcnJlY3Qgc2VsZWN0b3IgYm91
bmRhcnkgdmFsdWVzIG9mIDB4MzgsIDB4MGMsIGFuZCAweDM2Lg0KPg0KPiAgI2RlZmluZSBUUFM2
NTIxOV9MRE8xMl9WT0xUX01JTiAgICAgICAgICAgICAgIDYwMDAwMA0KPiAgI2RlZmluZSBUUFM2
NTIxOV9MRE8xMl9WT0xUX01BWCAgICAgICAgICAgICAgMzQwMDAwMA0KPiAgI2RlZmluZSBUUFM2
NTIxOV9MRE8xMl9WT0xUX1JFR19NSU4gIDANCj4gLSNkZWZpbmUgVFBTNjUyMTlfTERPMTJfVk9M
VF9SRUdfTUFYICAweDU2DQo+ICsjZGVmaW5lIFRQUzY1MjE5X0xETzEyX1ZPTFRfUkVHX01BWCAg
MHgzOA0KDQpJZiB0aGUgbWF4aW11bSBmb3IgMy40ViBpcyAweDNmIHRoZW4gd2h5IGRvIHlvdSB1
c2UgMHgzOCBoZXJlPw0KDQo+ICAjZGVmaW5lIFRQUzY1MjE5X0xETzM0X1ZPTFRfTUlOICAgICAg
ICAgICAgICAxMjAwMDAwDQo+ICAjZGVmaW5lIFRQUzY1MjE5X0xETzM0X1ZPTFRfTUFYICAgICAg
ICAgICAgICAzMzAwMDAwDQo+IC0jZGVmaW5lIFRQUzY1MjE5X0xETzM0X1ZPTFRfUkVHX01JTiAg
MHgxMg0KPiAtI2RlZmluZSBUUFM2NTIxOV9MRE8zNF9WT0xUX1JFR19NQVggIDB4NTQNCj4gKyNk
ZWZpbmUgVFBTNjUyMTlfTERPMzRfVk9MVF9SRUdfTUlOICAweDBjDQoNCklmIHRoZSBtaW5pbXVt
IGZvciAxLjJWIGlzIDB4MDAgdGhlbiB3aHkgZG8geW91IHVzZSAweDBjIGhlcmU/DQoNCj4gKyNk
ZWZpbmUgVFBTNjUyMTlfTERPMzRfVk9MVF9SRUdfTUFYICAweDM2DQoNCklmIHRoZSBtYXhpbXVt
IGZvciAzLjNWIGlzIDB4M2YgdGhlbiB3aHkgZG8geW91IHVzZSAweDM2IGhlcmU/DQoNCktpbmQg
cmVnYXJkcywNCk1hYXJ0ZW4gQnJvY2sNCg==
