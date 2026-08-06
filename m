Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5159C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 08:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B9A380D1F;
	Thu,  6 Aug 2026 08:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z-hdTFPxG-OT; Thu,  6 Aug 2026 08:17:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6677680D0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786004262;
	bh=BehNlAlyreKniyljDgFCbtYlB62o7FncfL69+N9zZSA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i9EuDmY1a2lwTZMbWwLfditQDjKB0vjhyNZ44cNC5jzQMJSy62RX93CCdIg+HtDpx
	 +m6tvDpIDwXW2xQlMRgp6OhwmY0eTMCOAc16tF0zPgPw61ZRc4YGbRxpPvnvno3P0X
	 cA9Er0IlIfR5NLdyYvtGKvaol0FJn+lWt7S3h2ado8j02v1WXPU4vcuU3RbbsdQjTa
	 oUe4SuxqeFoTk/lw5gCfy6aho5aikEIJlwR69bZMBLPnfkwj8iU5kdd0jfY7Uc0yov
	 gOIdDIZB6bu0pWMdsud10HJg71aIZF5K6WUJ5KiHbNzqeDncgbbdrjqnqX9fs1lJcl
	 LooDWYBny4V/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6677680D0B;
	Thu,  6 Aug 2026 08:17:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DD28D218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 08:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA38A80D0B
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 08:17:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CkZJrY4hC4V0 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 08:17:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=maarten.brock@sttls.nl; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C227C80D05
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C227C80D05
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C227C80D05
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 08:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNRRDbqEGxVUDG0g0NFxIzdrP9rxdz2Z9bCzfcOqrmwgYN5OCQ5pwNiaAR/VcbYKO6BP2yS5jN9o8Qqtz/3qyXkOF53C7d9qHJp6GjyhAaJoGBbme/UiDmMB3F3AovAYiOsEVNi9iW8Q/B8p9Jq/5r0bifLH6JrNEazhWIRZerw7fu0tEbAp3JsN0rzCjxPeNbJA2kelkrmCqQu41hKeOCJDrJeY55W1Hn+IGvvTaE5S3x3W471wUXYqTzFHbl1jq3Q+o98iCFZceHUB3QRlOsUzQoYMNNbWrwwQeSFRzzHuok28HB5hX+hLqaWlyqZrK58GctyLpbIDZ2Gu8z2DdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BehNlAlyreKniyljDgFCbtYlB62o7FncfL69+N9zZSA=;
 b=MvAaYGU6qnk/0O1A4wjylRingY4z2JXp5sO+U0csKjaWf292mHYWvsQsq+IAFM/eDf7+F2S1hUGU6ZOm6Qk3gDvFP97P5IChdO5GeuSDAOEAcRj04QE/BF/OQb7q3oa6Aj79lzqIRCUVcodDHDVtpW25dK8e/c2sxN8B7sO4ew5PfNB5PhNxbtL4cm4EGDj7HbQMhpVScnx7/kNcAnxKgy5iIFxF/YhQPv8YC/4AXBrwNlfN1yfOUSQZNYLazH61RnVdpNDbDK1OhZScWQupWPpUhARhbgd345YjIoNzjy2t8ORT1gvV7bzMklFjiP00wGH+an59c2FBtC004cxSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
Received: from AS9PR06CA0588.eurprd06.prod.outlook.com (2603:10a6:20b:486::28)
 by PR3PR05MB6923.eurprd05.prod.outlook.com (2603:10a6:102:68::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 08:17:33 +0000
Received: from AM3PEPF0000A78D.eurprd04.prod.outlook.com
 (2603:10a6:20b:486:cafe::4d) by AS9PR06CA0588.outlook.office365.com
 (2603:10a6:20b:486::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 08:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM3PEPF0000A78D.mail.protection.outlook.com (10.167.16.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 08:17:33 +0000
Received: from DB6PR07CU003.outbound.protection.outlook.com (40.93.64.92) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Thu, 06 Aug 2026 08:17:32 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by AS8PR05MB10253.eurprd05.prod.outlook.com
 (2603:10a6:20b:613::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 08:17:29 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%6]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 08:17:29 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: RE: [PATCH v3] power: regulator: tps65219: Fix LDO selector boundaries
Thread-Topic: [PATCH v3] power: regulator: tps65219: Fix LDO selector
 boundaries
Thread-Index: AQHdJUrXCknxtvvfaUGJx6hPZeIOHraQrFqQ
Date: Thu, 6 Aug 2026 08:17:29 +0000
Message-ID: <GV2PR05MB119410BC934202527D72F93C483D22@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20260731013643.28244-1-bhimesh.matsa@gmail.com>
 <20260806005803.5998-1-bhimesh.matsa@gmail.com>
In-Reply-To: <20260806005803.5998-1-bhimesh.matsa@gmail.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|AS8PR05MB10253:EE_|AM3PEPF0000A78D:EE_|PR3PR05MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ecba45-c8fc-4cf1-6377-08def3932a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|56012099006|4143699003|10067099003|18002099003|22082099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original: QG34TnRqaoEZZBOJ4x40FTl3IWILfaulP/HZcNgxux1mhEaSUQKNN7J6ia7YFRTIXlSix75bwDyFfj+WNAYtVgvNwW3YISPlzS2yMGvog4PoLaVyM98vtnH3iQXxPzRMxLBun5qE7Xb08dbfIIApj3oVSDXiR55TmTmvxEb7+1I/JnJeIAg7mTR7QilHmWy4BiSA+5LOlFEQF5NNwVzPnU+Ii3DIOFCp3INJ/xo3S95fogoLcIDmSuwXXKCyMBG20s0E2yCTFVV3qQSfPK+wDFRLE/ZaQsywfuzh4Ok0zlI8hVZPy3LE9+ZzJ0aKeridwu4PFkiuDxllZiaUhVReXqJ+33+uj/BewD5Mw4vQwBV6yyfhW2cdVmzj3iUatnmcYzPWgoegfcD8XkRKCBawYa7Kvd7DnPOIGLJjGgoq+fM9ZTRSOlUdI8aOwXja83HxKz0wgXuTQrXWrrlW1g9pSfNLMC1v4s36dGvYOj8A0Na+7/KIGaGoAgDlzj7j33G0iE9jyegP9Ws/1Y9VCRJv9Li6DtPfEfrUFnOA/6+mjpp3yg/doNMx61MgFXlEQWLMrqcdR+k8pZroQYPXHQGtVoYMpmCdXi1/r6HnuN7PAU+eLg9jgiAEoS8bS6MzPj+NKcDzDve6H3HPnKojqLCrXDzakdNQhTiT6sYzCY59jj5gYwiOe+De5E4R0RHyIP+qkNZ8mV/sPLKvDJrR1jNekvSGelCxnooiBs87Z9UHfY0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kf/tYYrz/wgMHBr4s0kUlg+8KkE7aeud6HAU9pXNi76pyoXFvtWqr/xB85IYw7nSq1grItlUw2iqt5r59zk3LS58BbRQ2MqazsYgFu0oBy6VyYYL1a+h5zpMGhRREv3DSHd4XDEZ+4n7tSBjXQzIKOX6C41CTxzYW46OLqtMo+d8OrTkzVLW68gXD5THWMBfGbUJKN+vLppgvZg0FZFFvLjYpQxhE/eGOW5/Q7/x9gZ/oNH9sNvShfsQnONhrtUZ+UptvRF1oVdVdabtrENp8kbPy+6S43so6K+ZNr1er1Hz+ZKyyCs0jETdhWt25vQv0vZye54u0nnniIEaldGlMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB10253
X-CodeTwo-MessageID: 808a1c0c-7394-4979-8b4d-9f9c860cf732.20260806081732@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ee6dbd3b-73e3-4be9-730c-08def393284d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|35042699022|14060799003|18002099003|22082099003|4143699003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: DATHqzOGHi1gozkIxRmRThlzWFA3RuhZLlpUJQ4lBza160CwkJ4zInwXTjySRxr5m3iFI3ej28bEAG4W0WlTJIjAWg10XXWI8Fw1iBt2ZZJ7Z/q/azQHCgMSC72A3mZI/1CQSDcnCgpCy7YPFv1ZKzbntPviws/NNUwEPjw8GTI4shP4RZoSXNGfcO5I/x4gJHl3Cl3ogXeFzxH6Ac6pmW8zgsNy2Q4RcxEX4SqKXbG1WG0k1Gju8X04TH02yia4oJUTH6xrCvfOa1Lh29patgYaQ4/E3GFQwY5wowaeEJNnIev4D5KmM8h9vCWpImDcz2tZ1oqnXhHBK9N7/xMlOL4gdS0Vv/SpeLoAGtFROMsOIRILtjV777jU1GoD0ndMbPq0SS2pkjz8SZKwNRJ3I1qDQxa0LxWJmwxVSZiVnzEMzm9LxqECeuviX4Gj3VjdE7T9q29WHnNNiQPMFE7MGP6XYr9FN38DpmsUAOfe1fmYtgQ/496X4kaFg72J64yKSVAzJuSbLAMR6YHsUvCFsEGuBQzZoYLyvApvdj+fxkTXWTLT/VNgx8iYI+hMMgeiqv6S6phK+zZXe1qUMNIK1FyCF0cbbTiKyksOBD7lI1fOTwvUuccDpMWIP73NpYhchSZsvlYs8ly2A9uP8od/ZLVSQUQtvAofsXjFd2AdwQo8gGM/Q3V12EIzBwy3lWQ0ww+YyBte7W7nzzmO+M/PMQ==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(35042699022)(14060799003)(18002099003)(22082099003)(4143699003)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: viIIstyGEDi7cHovmDH9M2+VkZBBaaSPW2Xv5JiW32aVX/O86TA8IfnhTlNTEdsN0WGxEDmr3dlxNFQttg4McBAYHY7c8zUVhA4r9ZCrbAD8G0NX6M4uJD1bz/YscUIt5A66tvS69uehsZujenESh7Oj+wSWi1FhaL7x+K5VgXVXNfVDIP2+FEviuLZVHvwoYsFCb4ew5YKOkHBUh5dB+dcN9UKpoJqbGuAiRRsFHm+2mw3JprxkpHnkOSJd6ohpuBAaPzo0m4lXD4UY5GYQI/uFHDEe8sgrdHPUFtplBl/4xaEBu9eyBsQN67mMRizhPADdZz22B7GvLwmTOBjQA9nN9A/L9hmlcsGCcPvoqn1+aiPzFT9OCmdo4GLt8Dtj8gvqgU4rA1Wwr+rQc/tDTIUFhH2e4VE1IeMVxlfYjsE+C4F2F+p3CWXf5WNdudBG
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 08:17:33.3446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ecba45-c8fc-4cf1-6377-08def3932a9a
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR05MB6923
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BehNlAlyreKniyljDgFCbtYlB62o7FncfL69+N9zZSA=;
 b=HCiOVWIfIee6ewTz25LBtLdx84fHaK2LrE/wg/KiWGD/Cg1nPQ97OiAGhQfq0/oAPJjINW2feya4JPicL8FDjo6vtYLBgjHtfNUgPgY7nqFRJuWQd04qeMmPaIdn+ntrJaiYN4GqkMW3jVvSqNZX7kzyhEwAS6gT9RwxjBWCdwSBQYWyimFZjX/Wknpl6XJIWjYE/AtF8WNifjOM0z3/z6qtvWIJMr/LstVaZD4oxkwSS7fIuCL4ZlDJHC1vJ4aRnLTcR3NPJKrApYe2vMSPmOojpFNIC4kdaZ12FV6BEgJEkqyfBmkBoWS+jFswZGMUcDkhs4wwNSTrrj0BRXK8ww==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=sttls.nl
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sttls.nl header.i=@sttls.nl header.a=rsa-sha256
 header.s=selector1 header.b=HCiOVWIf
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVLUJvb3QgPHUtYm9vdC1ib3Vu
Y2VzQGxpc3RzLnUtYm9vdC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIEt1bWFyYSBCaGltZXN3
YXJhcmFvIE1hdHNhDQo+IFNlbnQ6IFRodXJzZGF5IDYgQXVndXN0IDIwMjYgMjo1OA0KPiBUbzog
SmFlaG9vbiBDaHVuZyA8amg4MC5jaHVuZ0BzYW1zdW5nLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPjsgdS1ib290QGxpc3RzLnUtYm9vdC1wcm9qZWN0Lm9yZw0KPiBDYzogVG9tIFJp
bmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IE5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0Bs
aW5hcm8ub3JnPjsgS3VtYXJhIEJoaW1lc3dhcmFyYW8gTWF0c2ENCj4gPGJoaW1lc2gubWF0c2FA
Z21haWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjNdIHBvd2VyOiByZWd1bGF0b3I6IHRwczY1
MjE5OiBGaXggTERPIHNlbGVjdG9yIGJvdW5kYXJpZXMNCj4gDQo+IEFjY29yZGluZyB0byB0aGUg
VFBTNjUyMTkgZGF0YXNoZWV0LCBzZWxlY3RvcnMgMHgzOCB0aHJvdWdoIDB4M2YNCj4gc2F0dXJh
dGUgYXQgMy40IFYgZm9yIExETzEgYW5kIExETzIuDQo+IA0KPiBGb3IgTERPMyBhbmQgTERPNCwg
c2VsZWN0b3JzIDB4MDAgdGhyb3VnaCAweDBjIHNhdHVyYXRlIGF0DQo+IDEuMiBWLCB3aGlsZSBz
ZWxlY3RvcnMgMHgzNiB0aHJvdWdoIDB4M2Ygc2F0dXJhdGUgYXQgMy4zIFYuDQo+IA0KPiBUaGUg
ZHJpdmVyIGN1cnJlbnRseSB1c2VzIDB4NTYsIDB4MTIsIGFuZCAweDU0IGFzIHNlbGVjdG9yIGJv
dW5kYXJ5DQo+IHZhbHVlcy4gVGhlc2UgdmFsdWVzIGRvIG5vdCBtYXRjaCB0aGUgc2VsZWN0b3Ig
Ym91bmRhcmllcyBkZWZpbmVkIGJ5DQo+IHRoZSBkYXRhc2hlZXQuDQo+IA0KPiBVc2UgdGhlIGNv
cnJlY3Qgc2VsZWN0b3IgYm91bmRhcnkgdmFsdWVzIG9mIDB4MzgsIDB4MGMsIGFuZCAweDM2DQo+
IGZvciBpbnRlcnBvbGF0aW9uLg0KPiANCj4gRml4ZXM6IGI1Y2ZhMGM3Y2E0ZiAoInBvd2VyOiBh
ZGQgZHJpdmVyIGZvciB0aGUgVFBTNjUyMTkgUE1JQyIpDQo+IFNpZ25lZC1vZmYtYnk6IEt1bWFy
YSBCaGltZXN3YXJhcmFvIE1hdHNhIDxiaGltZXNoLm1hdHNhQGdtYWlsLmNvbT4NCj4gLS0tDQo+
ICBpbmNsdWRlL3Bvd2VyL3RwczY1MjE5LmggfCA2ICsrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL3Bvd2VyL3RwczY1MjE5LmggYi9pbmNsdWRlL3Bvd2VyL3RwczY1MjE5LmgNCj4gaW5kZXgg
ZTg3ODBhZjJkODEuLmMzMTE0ZjI2ZTFkIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3Bvd2VyL3Rw
czY1MjE5LmgNCj4gKysrIGIvaW5jbHVkZS9wb3dlci90cHM2NTIxOS5oDQo+IEBAIC00NywxMCAr
NDcsMTAgQEANCj4gICNkZWZpbmUgVFBTNjUyMTlfTERPMTJfVk9MVF9NSU4JCSA2MDAwMDANCj4g
ICNkZWZpbmUgVFBTNjUyMTlfTERPMTJfVk9MVF9NQVgJCTM0MDAwMDANCj4gICNkZWZpbmUgVFBT
NjUyMTlfTERPMTJfVk9MVF9SRUdfTUlOCTANCj4gLSNkZWZpbmUgVFBTNjUyMTlfTERPMTJfVk9M
VF9SRUdfTUFYCTB4NTYNCj4gKyNkZWZpbmUgVFBTNjUyMTlfTERPMTJfVk9MVF9SRUdfTUFYCTB4
MzgNCj4gICNkZWZpbmUgVFBTNjUyMTlfTERPMzRfVk9MVF9NSU4JCTEyMDAwMDANCj4gICNkZWZp
bmUgVFBTNjUyMTlfTERPMzRfVk9MVF9NQVgJCTMzMDAwMDANCj4gLSNkZWZpbmUgVFBTNjUyMTlf
TERPMzRfVk9MVF9SRUdfTUlOCTB4MTINCj4gLSNkZWZpbmUgVFBTNjUyMTlfTERPMzRfVk9MVF9S
RUdfTUFYCTB4NTQNCj4gKyNkZWZpbmUgVFBTNjUyMTlfTERPMzRfVk9MVF9SRUdfTUlOCTB4MGMN
Cj4gKyNkZWZpbmUgVFBTNjUyMTlfTERPMzRfVk9MVF9SRUdfTUFYCTB4MzYNCg0KSSBvbmx5IG5v
dyBzZWUgdGhhdCB0aGUgdmFsdWVzIHdlcmUgY29ycmVjdCBpZiBpbnRlcnByZXRlZCBhcyBkZWNp
bWFsIGRlc3BpdGUgdGhlIDB4IHByZWZpeC4NCkxHVE0NCj4gDQo+ICAjZW5kaWYgLyogVFBTNjUy
MTlfSCAqLw0KPiANCj4gYmFzZS1jb21taXQ6IDEwMGUxMmVhNzhjNzMwNzFiOTcxMGYwOGIzMmZk
NDU5MDAxOTI2NmYNCj4gLS0NCj4gMi40My4wDQoNCkFja2VkLWJ5OiBNYWFydGVuIEJyb2NrIDxt
YWFydGVuLmJyb2NrQHN0dGxzLm5sPg0KDQo=
