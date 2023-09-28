Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D92CE732DE
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 14:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6858E86E6E;
	Thu, 28 Sep 2023 16:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="jPL1OQ6W";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="jPL1OQ6W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B0E186E6E; Thu, 28 Sep 2023 16:45:22 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 854908655F
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 16:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnhvP4BZDUhV8rS9iVOrm6df/i6y3iwFC2wX2LXTaXI=;
 b=jPL1OQ6WYnogx6AhIe1sQsAHb8gzU4NzuxzzcHmzEcFOO9r2qv09KsdcNtdlyJzINW/zfhYfNoskN6rAhvL40ME8N3FqhodF6f5cmfisnKXgy7bnqq77lGasGUC/kRff2QqyferircKrulEa6R4CCHnGe0Gkp0Nw9wbgJskMYSBg6aCWKlUneksTB+XkBjzym917nOKeitF7bhyrvjTYLfqwD+gbC77uMWD4n2LkyCfya3xWoe0/yHmNVtSt1litUlaeaoFtqD9bQw6cM68JMbkvSl3Kg86XinNUZo7HzVF/vPmVgzUXS8EpBdyKmlc5BSlDiEGGVa2Il85ZJIvwgQ==
Received: from AM6P192CA0092.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::33)
 by AM9PR03MB7995.eurprd03.prod.outlook.com (2603:10a6:20b:43e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.34; Thu, 28 Sep
 2023 14:45:17 +0000
Received: from VI1EUR05FT005.eop-eur05.prod.protection.outlook.com
 (2603:10a6:209:8d:cafe::8) by AM6P192CA0092.outlook.office365.com
 (2603:10a6:209:8d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Thu, 28 Sep 2023 14:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.85) by
 VI1EUR05FT005.mail.protection.outlook.com (10.233.242.124) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 28 Sep 2023 14:45:17 +0000
Received: from outmta (unknown [192.168.82.133])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 E0FFE200813AB; Thu, 28 Sep 2023 14:45:16 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.113])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 35DD62008006C; 
 Thu, 28 Sep 2023 14:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zr5ef9EoPV8DPStpHdCjMrdNBTbe3Y134PLE/uxhxsCAFJ+lepWjhautN1rzQ6owB17V7B8zMNtQJMkB6gZ0HuW7KfIpKaXZAFU2ZwjsNLpZeN8KGF1wFTnBRf60U3v3LDW+KH9Kv78cp6PVhYP/zK2QaeocdZWT8M04ePwwC00J4XnHFTu0ca56qRcYyi3SVSWi7EZvOptmZILWFKkgIBw3ZqqUqOmH7JBkDam+2hXlaxMzdpforwwy1OSwj2fuoQdDcZPHm5/wSRCJXOIrc4UcPu+mCtX5w+XDKlNm445Q8u1FYGIDBPWM4lfWG6cx2cW7vg95Mp6gqKqGkGUfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnhvP4BZDUhV8rS9iVOrm6df/i6y3iwFC2wX2LXTaXI=;
 b=QSENAhXpvbG6Ba39MPsLvNrzO58/62cqe3IjX2d9ED8mloSYu70rPfXr+wbrDW28N5JsyBE5QkP/wsWvV2nGo3CEXcholLArhg9cIBlWFtsresSpRI4bBs9OG5BHoGRbtM10kLgtj9l7jj10+wmIXASLAYN1bKunMTT7mhGqQ1Bybw09dklU9599s2CzfzeMMIXQ8Ra9F+I78fNentTDPGbp3YV/AJOJPAY0K/f6gDgNGqPDuIGgPSXTp9nCE+bE3OzDnLFDsiVmRkLdv4totB2tyWT9EUEE7k+EuIByUGX2rZcTX/T62ndqqYXpGcPX9lzJvwrttyPtJlggTiBncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnhvP4BZDUhV8rS9iVOrm6df/i6y3iwFC2wX2LXTaXI=;
 b=jPL1OQ6WYnogx6AhIe1sQsAHb8gzU4NzuxzzcHmzEcFOO9r2qv09KsdcNtdlyJzINW/zfhYfNoskN6rAhvL40ME8N3FqhodF6f5cmfisnKXgy7bnqq77lGasGUC/kRff2QqyferircKrulEa6R4CCHnGe0Gkp0Nw9wbgJskMYSBg6aCWKlUneksTB+XkBjzym917nOKeitF7bhyrvjTYLfqwD+gbC77uMWD4n2LkyCfya3xWoe0/yHmNVtSt1litUlaeaoFtqD9bQw6cM68JMbkvSl3Kg86XinNUZo7HzVF/vPmVgzUXS8EpBdyKmlc5BSlDiEGGVa2Il85ZJIvwgQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from AS8PR03MB8832.eurprd03.prod.outlook.com (2603:10a6:20b:56e::11)
 by AS8PR03MB6870.eurprd03.prod.outlook.com (2603:10a6:20b:29f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 14:45:10 +0000
Received: from AS8PR03MB8832.eurprd03.prod.outlook.com
 ([fe80::afab:7dfd:192:dee5]) by AS8PR03MB8832.eurprd03.prod.outlook.com
 ([fe80::afab:7dfd:192:dee5%5]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 14:45:10 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 0/4] malloc: Reduce size by initializing data at runtime
Date: Thu, 28 Sep 2023 10:44:54 -0400
Message-Id: <20230928144458.2511087-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00016415.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:d) To AS8PR03MB8832.eurprd03.prod.outlook.com
 (2603:10a6:20b:56e::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR03MB8832:EE_|AS8PR03MB6870:EE_|VI1EUR05FT005:EE_|AM9PR03MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2e8b6c-deed-44e3-b20d-08dbc031881d
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Sl/phCiBSAkKxpPIicwGnt4lxhJoFV0LCaxkXeSzPKTX7olJCGoNikUFdBn8TqE8WcgyMfkejNDWFOzXjdWMaWKxCjfPZ2wQGmina1+KqKSs7qe9xbXONhEyc3RDHu9kXcmCY3JyPJZX9zbTb4tFQxEac51Eq0HrJh3CxmLtEwapife7VIz3VKLzKRAD1nGULVnYDSMkc+vMCUYdMYbl2Yo4wxm7F99cbQgTh/HSaNdZwaHKQZUAajqotMqU1hNrF/6sgX2v17GhPN413ZtkbDcG4OXafthk+elhuZOWPSz6V5OPZMhsN3yvo1u4YxrOliT6uiD1LXUho3SCxoecQKX2i7AwBY7NjHq/ZgMPKQwOwJSvS1YsxP9CUN+jGSiW9pBXwFe8Nwjz9KrLyknUOMsvRwWbmhEDECPn2yW06TIp600RtmDgfOnFv8ce3j6oJw2lAa30+hXUdzPZtfUxG62AYO2EZ+SHmzFh7O5Us0gARcOhop+uUKsi4bMpVgcLbULPVoGrGCG5NsV0hTokBvZ0I4Gn37t6zlXtv3kJo4A66vmMyQJp4P7LdR/GGZ0unvxfAI6XwQDIsuwH7/mwXkj56n2slFcn2zIZjxSadEs=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR03MB8832.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(376002)(396003)(346002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2906002)(4326008)(41300700001)(316002)(8676002)(8936002)(44832011)(36756003)(5660300002)(66946007)(66476007)(66556008)(86362001)(478600001)(1076003)(6506007)(6512007)(52116002)(6666004)(2616005)(107886003)(38100700002)(38350700002)(26005)(83380400001)(966005)(6486002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6870
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR05FT005.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e6cdcd07-1026-449d-730f-08dbc031840f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U30xjLUJIJGhc6QXkxlPbRkhuG9fizklIOLXenYGWeRXjvWX+LHJPfFfYXhwo6d4VAGGN8ypsuzgSLQwC9hZ4nSE0VwAxjWFoM2L3ZUlbnlYR1Y8OA8MUpPABooJDbrl+6kAaGtGt6NbXCYY0KC5+mAG7G/TZZQK1+nSZH52k1ZHunIhtoszmQV8qaeKtn47x45/OVyR2napDbrRijfRpkP+gpAb6h8CZDoFqqYlLhyOe4KzGufLVN1OXSssZ34rZkkDBlVnuqxV+GNuwT9RqSndOnHGy48DZrlnxrHFE22DZVJzyE/nNXsh/Mtnm1pkdqaeH+I9IgxPy+TDib8M9eMKC7lHFSmXQmdfGnBdn+gJx3x23DpAxA4XRqAe2m0MkDnAC8d2/iBxoa5k8OfoAAekNqyVCpeGR9dv9EjiPL020jsuVuUN1RV4Pt2yWLYx/8v11WK42I+eBbSFM3qO2Ne+MHDL31XzzQfTaukqh+LTuKLSgL6vAHh1rG7FBhRSpehxIKqu+e27pWl0472eVOW6OB6b+EQtb+biRKV6Q6HvXqarr8TlpPc31lkcDepczmaRIqxrM8BmdSNxbnxcXA32T+3lKMVlVOy9R9NHtB2SMkLV71svc5eW8xBbyw0nwipQkYouhGBp61xU85SDuwjo28IwZJwCeKTYN9OfI0IMmc9A+MihmFk1Fn7mNY3IChJGWUky+4wbh5Ei+IQNFRe/YgT2sScYrtPzAPkIDsFFhuMlL08WvNdHVn1qcp7m
X-Forefront-Antispam-Report: CIP:20.160.56.85; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(136003)(39850400004)(396003)(346002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(36840700001)(40470700004)(46966006)(966005)(40480700001)(478600001)(40460700003)(47076005)(2906002)(83380400001)(36860700001)(82740400003)(356005)(7596003)(7636003)(70206006)(70586007)(6512007)(6506007)(4326008)(6486002)(54906003)(336012)(5660300002)(44832011)(2616005)(41300700001)(316002)(107886003)(8936002)(8676002)(6666004)(1076003)(26005)(34070700002)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 14:45:17.1853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2e8b6c-deed-44e3-b20d-08dbc031881d
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.85];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT005.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7995
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

In my efforts to get SPL to fit into flash after some changes I made, I
noticed that av_ is one of the largest variables in SPL. As it turns
out, we can generate it at runtime, and the code is already there. This
has the potential to save 1-2k across the board, for some (very) minor
boot time increase.

This series is based on [1], since this makes checking for SYS_MALLOC_F
easier. Passing CI at [2].

To measure the boot time difference, I applied the following patch:

---
 common/board_r.c | 5 +++++
 common/spl/spl.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/common/board_r.c b/common/board_r.c
index 58a5986aa54..ca624b20d46 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -194,6 +194,7 @@ static int initr_barrier(void)
 	return 0;
 }

+static ulong malloc_begin, malloc_end;
 static int initr_malloc(void)
 {
 	ulong malloc_start;
@@ -208,8 +209,10 @@ static int initr_malloc(void)
 	 * reserve_noncached().
 	 */
 	malloc_start = gd->relocaddr - TOTAL_MALLOC_LEN;
+	malloc_begin = timer_get_boot_us();
 	mem_malloc_init((ulong)map_sysmem(malloc_start, TOTAL_MALLOC_LEN),
 			TOTAL_MALLOC_LEN);
+	malloc_end = timer_get_boot_us();
 	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
 	return 0;
 }
@@ -570,6 +573,8 @@ static int dm_announce(void)

 static int run_main_loop(void)
 {
+	printf("malloc_init took %luus (%lu %lu)\n", malloc_end - malloc_begin,
+	       malloc_begin, malloc_end);
 #ifdef CONFIG_SANDBOX
 	sandbox_main_loop_init();
 #endif
diff --git a/common/spl/spl.c b/common/spl/spl.c
index d74acec10b5..b34d1f4b4e6 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -755,7 +755,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	spl_set_bd();

 #if defined(CONFIG_SYS_SPL_MALLOC)
+	ulong malloc_begin = timer_get_boot_us();
 	mem_malloc_init(SYS_SPL_MALLOC_START, CONFIG_SYS_SPL_MALLOC_SIZE);
+	ulong malloc_end = timer_get_boot_us();
 	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
 #endif
 	if (!(gd->flags & GD_FLG_SPL_INIT)) {
@@ -817,6 +819,8 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	spl_image.boot_device = BOOT_DEVICE_NONE;
 	board_boot_order(spl_boot_list);

+	printf("malloc_init took %luus (%lu %lu)\n", malloc_end - malloc_begin,
+	       malloc_begin, malloc_end);
 	ret = boot_from_devices(&spl_image, spl_boot_list,
 				ARRAY_SIZE(spl_boot_list));
 	if (ret) {
--
2.25.1

I found that MALLOC_CLEAR_ON_INIT dominated the mem_malloc_init time
(taking around 150 ms in SPL on my board). After disabling it, I found
that MALLOC_RUNTIME_INIT took around 5 us on average.

[1] https://lore.kernel.org/u-boot/20230926141514.2101787-1-sjg@chromium.org/
[2] https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipelines/17900

Changes in v3:
- Use CONFIG_IS_ENABLED in conditionals
- Don't enable SPL_SYS_MALLOC_RUNTIME_INIT if we are short on BSS

Changes in v2:
- Only mark malloc initialized after mem_malloc_init
- Fix cALLOc condition

Sean Anderson (4):
  common: Only mark malloc initialized after mem_malloc_init
  malloc: Don't use ifdefs for SYS_MALLOC_DEFAULT_TO_INIT
  malloc: Don't statically initialize av_ if using malloc_init
  malloc: Enable SYS_MALLOC_RUNTIME_INIT by default in SPL

 Kconfig           | 27 +++++++++++++++++----------
 common/board_r.c  |  3 ++-
 common/dlmalloc.c | 16 ++++++++--------
 3 files changed, 27 insertions(+), 19 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty

