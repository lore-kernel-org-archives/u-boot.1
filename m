Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E40E732DE
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 14:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B405A86E77;
	Thu, 28 Sep 2023 16:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="jF3Je05S";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="jF3Je05S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A45F38655F; Thu, 28 Sep 2023 16:45:24 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BECBD86E5A
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 16:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7F9S8FwiYr/5t6O7zorcU52qmbyc95ntyL9yojuj+o=;
 b=jF3Je05StrRyPmrk0YG18GUAqiYcuGeoKq9uiRZfQ5fXEuobPWM/9xhzaPyDNpNjE0G0J7dBiQfhxN4j6hNqm6lmTZj/FkHWXkAyceeaACNHcO8N5zcQNWZWcBJMSL4JVFZJxwCqo9Y96UBCzQiceBOYRrOmTwbhNFFvu9YEOHnyBp824807v3XCC0np1KlvPOl5n/OOLUsvw1VLoN5AhUZX5becLAvAG7kejglLvRty2h/3Kx+C5DaY5ZOKUtwgatL/Q4OF3BfeN5sa6XRDa6hxt+WVjP1j6PlfUthGHjRe23DyzB3F8yOTlw6QQ7ciCKAtjAHeKwpZRoz1qMi6gQ==
Received: from DU2PR04CA0339.eurprd04.prod.outlook.com (2603:10a6:10:2b4::18)
 by AS8PR03MB7157.eurprd03.prod.outlook.com (2603:10a6:20b:2ed::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 14:45:20 +0000
Received: from DB8EUR05FT048.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:2b4:cafe::73) by DU2PR04CA0339.outlook.office365.com
 (2603:10a6:10:2b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Thu, 28 Sep 2023 14:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.81) by
 DB8EUR05FT048.mail.protection.outlook.com (10.233.238.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.25 via Frontend Transport; Thu, 28 Sep 2023 14:45:20 +0000
Received: from outmta (unknown [192.168.82.140])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 371CF200813AA; Thu, 28 Sep 2023 14:45:20 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.105])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 971952008006C; 
 Thu, 28 Sep 2023 14:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJKnkTHqWaYYwK4wB6eqOMGvyRiT6vQjKZ4uHG3Fu/b84LKhO3myERcPC1LPoybLj+ni0ICECnPTL2PTQyUeew/nDSBWBknqlEZ9LT/et4/Mz0oiX7b82X8K/hCIAykdkx+ci/5/BktgqyyzG4kgfwtdXXi4+6UcxDU+/A9hj/7gnfTgWTpH73NKqBKKQzp5wLzrlh6yuQ3wjhj6+1ujNNa4ZZzgo613antuc91jqsV1FdxWi2dvHYEL5BQR+Bvxt3BdyEIATJl9C/Ex8R1BW+x82cjQPK/mQf7C7IoiXpI9AEmuYRS9Yvre1vuYjObGU3/3MGuTxOSzguhTa5AMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7F9S8FwiYr/5t6O7zorcU52qmbyc95ntyL9yojuj+o=;
 b=KrFdzEF4YI+sRYLM0NL+syiYO2AfGjoYn+k8zMas00fWdSc5Zxph4HvJeZMNyzeTdH606BKJwqgNlMFmxidJwb0T7G8OMdI1LHbJ2rJErJAfZxUkosQ5JIuBOPwEpDc3JAKatoU12LYT53jv0E6FGBR17eJJd6+LAW7VnrJ7QKj9AzoloZfq5RbzqCTwNQdMUpJqdljgAaLF7eUHk4S4iJiOpXMwmo4+fBlhQjI/wAQnmyK4yFlNCJhVo/y3cSCElwROiV4H58JNE+njTPRe1QzxFgSzuoIFc4Ht70uAdMfH8AIaoP8jmVfoUAIHFlzQCElRjQRVtp6cIxhStclVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7F9S8FwiYr/5t6O7zorcU52qmbyc95ntyL9yojuj+o=;
 b=jF3Je05StrRyPmrk0YG18GUAqiYcuGeoKq9uiRZfQ5fXEuobPWM/9xhzaPyDNpNjE0G0J7dBiQfhxN4j6hNqm6lmTZj/FkHWXkAyceeaACNHcO8N5zcQNWZWcBJMSL4JVFZJxwCqo9Y96UBCzQiceBOYRrOmTwbhNFFvu9YEOHnyBp824807v3XCC0np1KlvPOl5n/OOLUsvw1VLoN5AhUZX5becLAvAG7kejglLvRty2h/3Kx+C5DaY5ZOKUtwgatL/Q4OF3BfeN5sa6XRDa6hxt+WVjP1j6PlfUthGHjRe23DyzB3F8yOTlw6QQ7ciCKAtjAHeKwpZRoz1qMi6gQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from AS8PR03MB8832.eurprd03.prod.outlook.com (2603:10a6:20b:56e::11)
 by AS8PR03MB6870.eurprd03.prod.outlook.com (2603:10a6:20b:29f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 14:45:12 +0000
Received: from AS8PR03MB8832.eurprd03.prod.outlook.com
 ([fe80::afab:7dfd:192:dee5]) by AS8PR03MB8832.eurprd03.prod.outlook.com
 ([fe80::afab:7dfd:192:dee5%5]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 14:45:12 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 2/4] malloc: Don't use ifdefs for SYS_MALLOC_DEFAULT_TO_INIT
Date: Thu, 28 Sep 2023 10:44:56 -0400
Message-Id: <20230928144458.2511087-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20230928144458.2511087-1-sean.anderson@seco.com>
References: <20230928144458.2511087-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00016415.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:d) To AS8PR03MB8832.eurprd03.prod.outlook.com
 (2603:10a6:20b:56e::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR03MB8832:EE_|AS8PR03MB6870:EE_|DB8EUR05FT048:EE_|AS8PR03MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: beeb77c5-f820-4c2b-d11d-08dbc0318a16
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /lzQuSuLdZDdLbStDwP2qojxMXHfVzJ/JTOOXK+ItmjlBuFVUtGfhy+VbTpChK1ntRoTfpv2GGht0Afcq/64Joa/6H8x2/do67Xw+QuTfFJZYowmavhvU950MiTkr+WNYzKRt4yllu44tyvZIEfO2MdxS1Xbtk7cOp/IzpCz+/Fp1Mw1zeyryePGWcOCeRR9JU8umXEEgCJblao1MBUqCz0OmXgYSJfWXBHr8nvu4KKVICOObb+UAv4yONDC7rkYfwOlQV8F/4X7MAh5xRR64cSKFMUR0xbcjsISOkeYmekcZ3ux4QD+3VOrRyrgBw5wyCFTi+BRrhFAO8kC8mzQ/daeJge3Hwcl8KCtZ38445UEo0JEZrSiFqtXHaFVofMS6xWZSX1OON22f9QlD8Grq9H1CUS8bL5e3+F5jve4HS05nkK1l5r707rhUurSc37FpXKNYkvZiexj7LirqNPxnxogfUjuPAbR2q1Gu3Z5+7UyEfS6Q4AbRT2IE71KnFmW5ePxNBh2CFEjqGnkdXmK4E+ixPrEivNvYJIJO+BE/qzQkPMXCzbwQunKxdBoJRb8roZ43pEx2Nq6dVq4HSPIUevJVSRi6Bv1n9M+9E1OhBkF5oXk9YxjJ1Kpy52cA5CI
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR03MB8832.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(376002)(396003)(346002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2906002)(4326008)(41300700001)(316002)(8676002)(8936002)(44832011)(36756003)(5660300002)(66946007)(66476007)(66556008)(86362001)(478600001)(1076003)(6506007)(6512007)(52116002)(6666004)(2616005)(107886003)(38100700002)(38350700002)(26005)(83380400001)(6486002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6870
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT048.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c961f89e-84b3-4016-7a1c-08dbc031856b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdcw4hK3BKqdmbR+NP3xPsy/cl/OZu7pP3fRJtejLTT/Edss8MlWNzLGQa8l/XaJMsy5QJ+US/ki8yVm787VKjRiyQ2+nUwizTGY9Bq9y/ZjsFUmDaFDBQyKwMAvaq3tL0r2AguWhYNLPmR2kc4RbAlHyh/0xy4YDOV1swTnE/qICmvIIuQVQ+TanVlbrsyc3Cdu8wxPNIY0Xe4HOqPBK5e6rylwApd8yXGWziNYGGwz4eEnuAtU9yR3IDQdhASfQ6mbxNTnQDfRWKuiuk9FeQj5Iwwy/HWwfRGLKylylCc2UDOUOFTOk/16JKPAmODqaRiRcHfbQ0ZoxEJWhDz+lVB9gS+2D4GQ0WtmpZHz383v2KjySoozBVso4Zsxs/IOPZarCsnOFSlE9VCsLq41lijosBUoWhPCMiFWgZmU6cDjtn8kt2hIsOuEPVn2ratKP4wpPohxL74NhG0hRZ7PXKdgdsan7s4KtxNZwRleN7p18TaBRFCv65nMIu9GK3QLTzqtZ5MWfkZa16LsgOmQr0wZbw7J6VoVTFqhbNTlvSDWaeEH7ATZUCbmzLyTb2nAo94R66ACC2BX7j3bYU7Wo4ICLd4P8/7tStuHu+niUT4Rb034Ok74UtCKOdbL26V4XEzebZK53FOs+DceOUr3Ao1QZ+Zy5vGDYX3Xx+9oLKBD5zDL4uyDgSTaWb+MxHsPizSI+rz8zzTEGMWzaZhcMS5LcSzbvfNy0YXx0xz91z7alr5CilTRkjRs6NTJWEGfIUlPh6i28Yblg82hBHbzYA==
X-Forefront-Antispam-Report: CIP:20.160.56.81; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(346002)(39850400004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(41300700001)(8676002)(1076003)(2616005)(107886003)(4326008)(8936002)(70206006)(70586007)(316002)(54906003)(26005)(336012)(44832011)(34070700002)(86362001)(36860700001)(40460700003)(2906002)(478600001)(7596003)(356005)(82740400003)(6486002)(40480700001)(47076005)(7636003)(36756003)(83380400001)(6666004)(6512007)(5660300002)(6506007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 14:45:20.4957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beeb77c5-f820-4c2b-d11d-08dbc0318a16
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.81];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT048.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7157
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

With CONFIG_IS_ENABLED we can eliminate some ifdefs.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/dlmalloc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index c2f5a7347b8..c7cd7815a27 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -575,9 +575,7 @@ static mbinptr av_[NAV * 2 + 2] = {
  IAV(120), IAV(121), IAV(122), IAV(123), IAV(124), IAV(125), IAV(126), IAV(127)
 };
 
-#ifdef CONFIG_SYS_MALLOC_DEFAULT_TO_INIT
 static void malloc_init(void);
-#endif
 
 ulong mem_malloc_start = 0;
 ulong mem_malloc_end = 0;
@@ -612,9 +610,8 @@ void mem_malloc_init(ulong start, ulong size)
 	mem_malloc_end = start + size;
 	mem_malloc_brk = start;
 
-#ifdef CONFIG_SYS_MALLOC_DEFAULT_TO_INIT
-	malloc_init();
-#endif
+	if (CONFIG_IS_ENABLED(SYS_MALLOC_DEFAULT_TO_INIT))
+		malloc_init();
 
 	debug("using memory %#lx-%#lx for malloc()\n", mem_malloc_start,
 	      mem_malloc_end);
@@ -719,7 +716,6 @@ static unsigned int max_n_mmaps = 0;
 static unsigned long max_mmapped_mem = 0;
 #endif
 
-#ifdef CONFIG_SYS_MALLOC_DEFAULT_TO_INIT
 static void malloc_init(void)
 {
 	int i, j;
@@ -748,7 +744,6 @@ static void malloc_init(void)
 	memset((void *)&current_mallinfo, 0, sizeof(struct mallinfo));
 #endif
 }
-#endif
 
 /*
   Debugging support
-- 
2.35.1.1320.gc452695387.dirty

