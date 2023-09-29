Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A5CE728C4
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 16:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A54A86EF4;
	Fri, 29 Sep 2023 18:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="mVwAb1N4";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="mVwAb1N4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD69F86EF6; Fri, 29 Sep 2023 18:07:30 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05hn2231.outbound.protection.outlook.com [52.100.175.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE16486EF2
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 18:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvGzbUoM+XAvVrz6Oa3lntSiHbpV4ZrHDYPASEG8BLg=;
 b=mVwAb1N43Z7O/qFmbKD9+NziFj8DLck9F/izwKFRRTcI/Gwe4rOVRWD8aNYI+khZUthI/wL2M8+WeZr7LJXcGNp9McKmCuny/v70sqHLbwnGFnVgKC5I0hGhzBbM+bBtxDzXm5a+9uZDPlRRn0feCTMIp9LS9SetJJrLgbl8a0IUENGmcoUYozAwRc08UWG7SXVJxMoyJurGWxRrz0S0k6i/UE78Qe1Adr6mNdFWXsLB9XgUut8rc/n2/rUwiWfLkPEwAEttKH9q3jcOrZ3tsFxLCO3cmnvWjzp4YC1ObZ1NQowPDNYGNGOI5/fQjJSFgZIrmr9HH9KoLQ4JQkVL5w==
Received: from AM6P194CA0024.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::37)
 by AS4PR03MB8180.eurprd03.prod.outlook.com (2603:10a6:20b:4e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Fri, 29 Sep
 2023 16:07:25 +0000
Received: from AM6EUR05FT055.eop-eur05.prod.protection.outlook.com
 (2603:10a6:209:90:cafe::73) by AM6P194CA0024.outlook.office365.com
 (2603:10a6:209:90::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.23 via Frontend
 Transport; Fri, 29 Sep 2023 16:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.80) by
 AM6EUR05FT055.mail.protection.outlook.com (10.233.240.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.17 via Frontend Transport; Fri, 29 Sep 2023 16:07:24 +0000
Received: from outmta (unknown [192.168.82.140])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 3A3EF20086FCA; Fri, 29 Sep 2023 16:07:24 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown
 [104.47.17.169])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id A460E2008006D; 
 Fri, 29 Sep 2023 16:07:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZhWpuLtFNL6EuNEpOHBMZ+dhIErcAoZbpEvqrZiv6iX7JzRER7tPpE5bqMp91kasDC11rGYuyMssTxnBdNlYTjaz/YFanW4gEq0vtwNEd1ba2sEy1/lXlfbsO4O2GZ8mrY9uprkhAYxbrtkYgqah4iHhf0Mhm8Iv95Q9dmit1QR/iyi0WfjSp35J01WROjH5suEtPRkVQmd3yvokSvBeBFxOyew4Jw+9z8jYxh+xcQqkOXSQKLAwptMVZxzKkz49oCvWfAlzxe88iARd6EX2kGEvIDHe6vLLe5KcXitXZI0jT7UOgkDDsNSAByFc+CrT8RWlHXJJBcZHHyQz75vDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvGzbUoM+XAvVrz6Oa3lntSiHbpV4ZrHDYPASEG8BLg=;
 b=fol09JrD8WYU9oj4KFpWfi15d+StaO6Xope5+uSLl9qRaPOtiqehZ5SCvmyTwDYRnCT6S7Sy2/u2xcovsgRvnwNKYgH4E04sKTjHGC/m93MAIi+WHN5Df3lQU5Tn6Ly8yT1dYhPI4OIv0qL1Pcz1hBLIcE7HqhJVJxS1IravWnNhJUfAQhjscEHI3XPSWHiEs5fY30aupznhiyrXbQAXmV6ltSR07Ic5hohXY7k/au6BNmdFnTDElQww8gkbSrbNQJfm+r5sXNGPUmpM9FK+I5W8BDSUtR/Zob3w7SfQbqBNOd2w60iP3TGBh0H+JaKaEq4RWLvQg5Mz7Oo6IfK+eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvGzbUoM+XAvVrz6Oa3lntSiHbpV4ZrHDYPASEG8BLg=;
 b=mVwAb1N43Z7O/qFmbKD9+NziFj8DLck9F/izwKFRRTcI/Gwe4rOVRWD8aNYI+khZUthI/wL2M8+WeZr7LJXcGNp9McKmCuny/v70sqHLbwnGFnVgKC5I0hGhzBbM+bBtxDzXm5a+9uZDPlRRn0feCTMIp9LS9SetJJrLgbl8a0IUENGmcoUYozAwRc08UWG7SXVJxMoyJurGWxRrz0S0k6i/UE78Qe1Adr6mNdFWXsLB9XgUut8rc/n2/rUwiWfLkPEwAEttKH9q3jcOrZ3tsFxLCO3cmnvWjzp4YC1ObZ1NQowPDNYGNGOI5/fQjJSFgZIrmr9HH9KoLQ4JQkVL5w==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PA4PR03MB6896.eurprd03.prod.outlook.com (2603:10a6:102:f0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 16:07:20 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340%5]) with mapi id 15.20.6792.026; Fri, 29 Sep 2023
 16:07:19 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] test: Fix SPL tests not being run
Date: Fri, 29 Sep 2023 12:06:54 -0400
Message-Id: <20230929160654.3475279-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0088.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::29) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PA4PR03MB6896:EE_|AM6EUR05FT055:EE_|AS4PR03MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: eb25111d-7798-4247-e696-08dbc1062b4b
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: CWv05qpUPQbytGyolhZXI0PBHtuzpjcs/KqVMbwcroP3CnMXkmyctS6J2R5VHiGadjzf5pWayUDyCt0m0USsnKdgH2HGhHHaj2PGlqqhXoYixZK/vwg4eZH2zK9SyKq1wNqbpiehnYqNau3h1O1BycSMjz/R0FhCEo9waNLSKmNkh1wloLkPTb8dEmpQEmeY+QHf1oQC/SlbUiNNtfMtLVnFhBrOgXv+T7OUtobiEIKdVP1frWS8pTvxGLcbE4C9esx6qCy+58e64fOZTR+M5qwtWQrrdRIiD45N9ocPsgLjYzdCr48qB2z5rXWVtsYfw4zhyFYguCmde1M0WC288e51CnVgWzXurRLGYb/eTecrig4dyQCooQBUB5nEGOAE/XOZixVBe8RoT+ltsiSKqNzLC4dligdbTz0WqjvVz0gi2g5Re1VJTmpKdvjpuA7poeHuCzZfrpYqY9t845M1SvIF82NzrKzJLlu5dvJx5ZGq9ODfVlEMroxbGc4mw4hVWFRZ3fhvN2EvWxKwg/kZph0zWLZNtVjQPAEGtyLSIY/gT1MESuZZSxuJzJRG1iLTnOhHYVCyFqRXdx3QHqOQ57pQeke5sn82H1T+n1vfRWaWDDw8vTVerZrO8CSz4i5y
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(376002)(346002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(4744005)(2906002)(44832011)(5660300002)(8936002)(4326008)(8676002)(26005)(36756003)(1076003)(2616005)(107886003)(41300700001)(66946007)(66556008)(66476007)(316002)(54906003)(6916009)(52116002)(6506007)(83380400001)(6486002)(478600001)(6666004)(38100700002)(38350700002)(6512007)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6896
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT055.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 685ca04b-0d50-4453-3dda-08dbc106284c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvQzSmbOEUm0VGX/V0KtXMnC1xOBn41g0gtkKt6hHDhdrUKBvxpTJOPl/ipov8/Fy1dnT4fBAPCVW4RtgPyzDCKeG8tnT95a/UpCZqkepUXdezyVMQgKUyCjDZ6CHFoSYi6kLDuUmJcQAQN2JEKUeahSnLb6xhXyIq+JSDf1hA0uiHnHuWoU39P2we3OWTzNZqYnUv1Xm0dBbFnJgiU7iA3jnrQ9AU+SDN3N6xT6QAuX5NLCnfbsyaHxCnQgm3J5m+Ugn6s9m4NHFWNnsdO15J88Bztn5hfmdU7KoCTMdNzgMVYe7LO2Jc6Z7LpK9/+VvuC878HQrP7HoS+N4rPV465c+54mvJMV07PH5LyhknHbhJWIi84sAQQBfgrSOUJAXk/wd0CE50hPyAS6eEIZrvVy8MtQF2UCpc05THAau21gheVPufCLJBFo57zPo0YwKKxtpkgHSudoeUFxFIDjRg0nTnsTWNFrKkeZGTTeqJ6jODayJA63qEmdKyTP5k6Mpfo/+X17J6wo/Ld1iL5q0mUyDmu+E+Ookx4YUDuKTLzt2b2MlfV1SmReFwEnuUpRiZyEqnm+AdVUfKV3CfdeF9czceLFTpSQhTeMu23B8/qMgICzuKIMrnIXyhoYgLj/WQJKe7JDZpOfPVnLg5rbXgza3cdGsC/EhY7A3JkJGHWP7fvQvK1p8zLYMIZE+tkQsGiSJj2c169Ovf3vq92mhUUamZwmZ3c+ULa0W4U4gJS2+QGYvJoSPnXNmzKilq1fBeRDZJ9rBqxMh+FR+UDV1mekrKAwjhmrzinFkYUP6BYsxajrAs3ONXJEGACsnCvL
X-Forefront-Antispam-Report: CIP:20.160.56.80; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(136003)(39850400004)(230922051799003)(451199024)(186009)(5400799018)(64100799003)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(8936002)(6916009)(316002)(2906002)(41300700001)(478600001)(70206006)(70586007)(6486002)(54906003)(6506007)(6512007)(8676002)(1076003)(107886003)(2616005)(4326008)(44832011)(83380400001)(336012)(6666004)(4744005)(47076005)(36860700001)(26005)(5660300002)(34070700002)(7636003)(7596003)(40460700003)(82740400003)(356005)(86362001)(40480700001)(36756003)(12100799045);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 16:07:24.2947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb25111d-7798-4247-e696-08dbc1062b4b
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.80];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT055.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8180
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

SPL doesn't have OF_LIVE enabled, so we can only run tests with a flat
tree. Don't skip them even if they don't use the devicetree.

Fixes: 6ec5178c0ef ("test: Skip flat-tree tests if devicetree is not used")
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 test/test-main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/test-main.c b/test/test-main.c
index 778bf0a18a0..edb20bc4b9c 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -476,7 +476,8 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
 	 *   (for sandbox we handle this by copying the tree, but not for other
 	 *    boards)
 	 */
-	if ((test->flags & UT_TESTF_SCAN_FDT) &&
+	if ((!CONFIG_IS_ENABLED(OF_LIVE) ||
+	     (test->flags & UT_TESTF_SCAN_FDT)) &&
 	    !(test->flags & UT_TESTF_LIVE_TREE) &&
 	    (CONFIG_IS_ENABLED(OFNODE_MULTI_TREE) ||
 	     !(test->flags & UT_TESTF_OTHER_FDT)) &&
-- 
2.35.1.1320.gc452695387.dirty

