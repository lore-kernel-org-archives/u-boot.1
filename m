Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09CEE732DB
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 14:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2475086E64;
	Thu, 28 Sep 2023 16:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="JqUrAH0D";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="JqUrAH0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6BF886E7E; Thu, 28 Sep 2023 16:45:25 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8CA686E74
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 16:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOmAD6z+IjusRQWp426FOsLRBYMkAjV5sXHsBLcvNjM=;
 b=JqUrAH0DW1z59Q2lAxlsi88eJJxZMw6OXxsqEZUvkjxlfqMbX9r8vmIRD/HYY797FTJtw1Vh0f8sufJpcpjDcS1P/LEHINDENadkAB+Qdtw7/kivMbkhUJPw4GXFHV47Sa1GEDDPB6A+k9vYNX/nymT6DdQLE7aZR3GSJsrV58Pkwu+L+deyY+9kUlQ8uNyPDEyLb9rk5Cu3gLUi+H3r45tqKmefnSKkcpNITJT5MMcsNCU0hdSvSi68X8fw7jhwc51mD8EAkWPcUyQkk4XRxEbKRHTHHS+Kw4IaP2YrCY2kIscCERF1JVXeYDbrSuwR2aHz4PKD8FzrTUvBYi2PjQ==
Received: from AS8PR04CA0148.eurprd04.prod.outlook.com (2603:10a6:20b:127::33)
 by AS8PR03MB7831.eurprd03.prod.outlook.com (2603:10a6:20b:34f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 14:45:22 +0000
Received: from AM6EUR05FT042.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:127:cafe::d0) by AS8PR04CA0148.outlook.office365.com
 (2603:10a6:20b:127::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.23 via Frontend
 Transport; Thu, 28 Sep 2023 14:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.84)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.84; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.84) by
 AM6EUR05FT042.mail.protection.outlook.com (10.233.241.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 28 Sep 2023 14:45:20 +0000
Received: from outmta (unknown [192.168.82.133])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 3C460200813AB; Thu, 28 Sep 2023 14:45:20 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.110])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 99A0D2008006C; 
 Thu, 28 Sep 2023 14:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6+bW2mUWmkY08fJ7sw2aHOepI/I0RCjIqjRxXDFYYfkQ0FWRSN63Kj+ijcUpcmV340hSdy0sUqxVntnqh5zuKxMHzM88NWcwDRDfitV6C2UH9w7fBR1/xVOwaRnWLGIQfmmH01JksJrzuOMZSxhavcSKhKuy10efUcmELLiz5IArr8idsxUzy/Ou/FKnOk1u+p5ePCCqVyURu1yH6t3YCWfTW9Y5R4FWCUTs9Nd2ED3CTeQ2iRSfqipjPW7CpUxnKJv/wDRTfcQi+AlojxiSL4dAnjXUaZ5btdl/IX5ad6QBwqRseI4ZIVm6hgJyarEQcULS2vmg4RZPN68r606bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOmAD6z+IjusRQWp426FOsLRBYMkAjV5sXHsBLcvNjM=;
 b=mbnZ7/bn6NcfQvu4wQ0aA5el1IupFYdzAHUKZKO7U2la7WJEX6uYso9ugKWjj1nkmF90tDLZima0l0bq2w7LxbQvnz4Zk7gup88jDQ3JEHKOZ8DFUGyu5OYsjUZR7XkDekyJDGQOyU3dqyApEyUbtyLeP0wUY3dlH8xfl+CTR4IiDGneQZ4SKspBTLg8CVt3soMWB/aO7tQS92LAF7CFbhftTNOBfLsLPYr3HtuYGjP7tB5HhrEOPUtKWWUx6JzpmBog4ZoMzgAIrfnMa+S9uRAp8W89jKbpN766rVkRjywV/zlLCSLj5L9PSX3TUyj9Myq9wtaxdKkNtedlMT4yFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOmAD6z+IjusRQWp426FOsLRBYMkAjV5sXHsBLcvNjM=;
 b=JqUrAH0DW1z59Q2lAxlsi88eJJxZMw6OXxsqEZUvkjxlfqMbX9r8vmIRD/HYY797FTJtw1Vh0f8sufJpcpjDcS1P/LEHINDENadkAB+Qdtw7/kivMbkhUJPw4GXFHV47Sa1GEDDPB6A+k9vYNX/nymT6DdQLE7aZR3GSJsrV58Pkwu+L+deyY+9kUlQ8uNyPDEyLb9rk5Cu3gLUi+H3r45tqKmefnSKkcpNITJT5MMcsNCU0hdSvSi68X8fw7jhwc51mD8EAkWPcUyQkk4XRxEbKRHTHHS+Kw4IaP2YrCY2kIscCERF1JVXeYDbrSuwR2aHz4PKD8FzrTUvBYi2PjQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from AS8PR03MB8832.eurprd03.prod.outlook.com (2603:10a6:20b:56e::11)
 by AS8PR03MB6870.eurprd03.prod.outlook.com (2603:10a6:20b:29f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 14:45:11 +0000
Received: from AS8PR03MB8832.eurprd03.prod.outlook.com
 ([fe80::afab:7dfd:192:dee5]) by AS8PR03MB8832.eurprd03.prod.outlook.com
 ([fe80::afab:7dfd:192:dee5%5]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 14:45:11 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 1/4] common: Only mark malloc initialized after
 mem_malloc_init
Date: Thu, 28 Sep 2023 10:44:55 -0400
Message-Id: <20230928144458.2511087-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20230928144458.2511087-1-sean.anderson@seco.com>
References: <20230928144458.2511087-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00016415.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:d) To AS8PR03MB8832.eurprd03.prod.outlook.com
 (2603:10a6:20b:56e::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR03MB8832:EE_|AS8PR03MB6870:EE_|AM6EUR05FT042:EE_|AS8PR03MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ebc3f5-1e38-4fa7-1b89-08dbc03189f6
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: +xgP5tRl/WdH0daalmkrkhCVFNkKtDbbnTUJElKFoKekoJ5YSVSIGFnca0O0U+CWjF6+i+L/LC4ZcWZHQSz/uGmjHcmSEIb5gnNHzT5np0bfWg9Q54nSfQUR1UNf1JiswRlJfDlkjtq3YQNFzvqavtsDe8mZGpR7XdDelaqkQ3VbKMSo5ZCmFOCzDzRt5nqvlDocpm2WYEGGeaD+dpuTR6VcTe/fbNTNA/rtqj2JuHtc4GMb9faXYdZOCl2UXg4SpHVRnw9Vsxl417+SeHTg0A5iCieCVIcWwh0wrcKGW8rSUJkcnvD+rUEmP6eb8kiRe0keTECEPvi2cgWnjthUYebX8qCICRH339sbXVganSWEs3y+NmK8cXzVbQ/IL+uRpr2G2r5eu7ZSWHY26UI7nUqQiefutnpSuAt/n/oPpIBZQgAUnV0h//uj5yjSsQoFvSSiWYBVw5WU0sLn6H9nD2f4mFPItOuIPSVuNAWP7eU5mWyumKfhSjuVlYH0AV1a/ukBZOZ17Ax505Y1GRrsibEiL2SihNNOka2V4O6kw4DgTyGqvNR7fWHy/OPkYdooMCYhO9wZboL5rJXyuio5gJGVTKh6T5N6ZRHWraDkfrhV1zs8LNZ/jjp2BDKPvTQo
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR03MB8832.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(376002)(396003)(346002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2906002)(4326008)(41300700001)(316002)(8676002)(8936002)(44832011)(36756003)(5660300002)(66946007)(66476007)(66556008)(86362001)(478600001)(1076003)(6506007)(6512007)(52116002)(6666004)(2616005)(107886003)(38100700002)(38350700002)(26005)(83380400001)(6486002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6870
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT042.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 052ba972-0a89-426f-768c-08dbc03184bd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2LqpE3q5ex26huxrLzWDN8ozopqGIR1xHVHekdUQvimeaa/HA6KZu/XQBd9YgZr6G4PVXbVEp9YbiTfWEf014Og1XZgmQSlUsD5nKBPPq9RQ+qjF3tVb4Z+rzKfkyDXVUBb5liRODhIzWHeXYY6d2tEw+m6bYfqM7s4/0wQeL4/jGJ2kLyFGMKG+fUfnIrUJpD4EP6Xw0oqbYxgA+rmdSzwIxEOyLf9+l4uSFAYBnzKV/M1ic4vM26sMsDrl6L6YK/7UwIZPQ4VKTBx+2EqjjyyyfXvdawGzH6IoOSwB3ht7zAtDwH9ydWSpbJIhX2Y4UWzaQOTjtvX9zHY6Xke4apATriv2mYuls10nLgrFIHQ6nFcbqaqsLaQI3WZ5pPEPVhVH5RSLIVZiSPRSDaVMenButDFi6pPFDwkTuC0AucfeS3lbkNkPMjstAFyUEdImwY9j+IbUivL15mrQLa5rulaz7qjkSv9KVE+UkD+d/HYsytbCa/eMa9LzD6+d1oOGrdmcIgnuTUszi1lR9Qts1MetEHqGxqax64j7PKJzyXSnKzlUICYJhsT2fzcSKWeu44Ol40XNYuZH+yApRvgme6JcLlBrwUHtz0U+phakYdyxIx16Aey5Iwf2yZ9VjNOvKN5FQ98GtO27v4zNU1pY0acPo6bmtIAcSV3+3ESvhM7XuEk+X63EUuCdjHcn3Ze7GFhWTnx9ClBLQ+cP3lNlhp2xcPdAMmdrEsD0a6v1sxQz0ZvVLQw2x6fSEk72/aETuVeAT/Q64H9yUsSUup87HA==
X-Forefront-Antispam-Report: CIP:20.160.56.84; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(39850400004)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(46966006)(40470700004)(41300700001)(40460700003)(336012)(70586007)(7596003)(356005)(316002)(83380400001)(7636003)(40480700001)(44832011)(8676002)(36756003)(8936002)(70206006)(4326008)(5660300002)(2616005)(6486002)(1076003)(6512007)(47076005)(86362001)(6506007)(54906003)(6666004)(107886003)(26005)(82740400003)(2906002)(478600001)(36860700001)(34070700002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 14:45:20.3126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ebc3f5-1e38-4fa7-1b89-08dbc03189f6
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.84];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT042.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7831
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

Instead of marking malloc as initialized as soon as relocation is done,
defer it until after we call mem_malloc_init. This ensures that malloc
initialization is done before we switch away from simple_malloc, and
matches the SPL behavior.

Fixes: c9356be3074 ("dm: Split the simple malloc() implementation into its own file")
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- New

 common/board_r.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/board_r.c b/common/board_r.c
index 52786901be5..cd1e5a3a4c7 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -98,7 +98,7 @@ static int initr_trace(void)
 static int initr_reloc(void)
 {
 	/* tell others: relocation done */
-	gd->flags |= GD_FLG_RELOC | GD_FLG_FULL_MALLOC_INIT;
+	gd->flags |= GD_FLG_RELOC;
 
 	return 0;
 }
@@ -204,6 +204,7 @@ static int initr_malloc(void)
 	gd_set_malloc_start(start);
 	mem_malloc_init((ulong)map_sysmem(start, TOTAL_MALLOC_LEN),
 			TOTAL_MALLOC_LEN);
+	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
 	return 0;
 }
 
-- 
2.35.1.1320.gc452695387.dirty

