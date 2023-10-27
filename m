Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9170C25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 20:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CA548772C;
	Fri, 27 Oct 2023 22:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="tsii1eIX";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="tsii1eIX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C6387755; Fri, 27 Oct 2023 22:40:50 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 894528772C
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 22:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=QIa9fNDU0GsnN2XNam00EShKWPSasw5vG41glYT0NNxXai+BIN3ziwMf1hChXndW8CsCPQ1psuJY5ddkwaH9G/IMDfFOdWSsNziF7K2uVxnp4xn+5vHFGkOJdxFi8wACuAdrx9FY0nGITSUpNbV1x8eeuTpfKmUKx1d3ZKKn9/vv38S2qH9PvovPb7M+95m9sH2i9ZkIanYPAHUtuDAHb4ZqNvHTLg8+Os6xWzOf/yGY9VELC1Wr1WdxcyR/3R1mcICt79V2PqEccsefgR/G0D5PqC4izOQFPC+iA+CG/fmQmxbDH8EGO03tsS1qmb5ULR4KeLnQTgI+9HzHsDhwjA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNFQrzbCH+RayZMWIhcGT5z0AG26E6qoeQP6sWRZjOs=;
 b=M0Urs5V8YmejJW3fMiaxWPzKZPsVRhn8RsUFGELBp+KpIkdgbKjNsxoJU/cblYoqMXkgtN3D5j1ixVrKad3uQNWoI3vp2bAVtzlpcTYDVVM11zkR1cGFObcEEBYlSIR9LzGGblH7SXUXlxJYWmhVC4iyjwuY9zMbLHy0cxhFhOdwFZ6AmWjvn+Tlif2PTlnRGp7HX3gN7Ij3AQ0t7QFn8uKu6DvlqZS+osVWj+rUldXYIaOVE+fPeS30pwcaOGvKzVi1GRpPHXw29j1PTloDNgeeraiuiGST2C3tlLn2dQknKI4FYMYJh36nheAvpGZMQjQ54DK/u3Y5MiwLZ/tGig==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.81) smtp.rcpttodomain=arm.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNFQrzbCH+RayZMWIhcGT5z0AG26E6qoeQP6sWRZjOs=;
 b=tsii1eIX2oEuGSavOGl5Rdej8s9Uyua8KyEJPD3GNhWELM3P+tjDxDU2s49jnRuS596Dyi0ngrrqy6qdC3P47rQSIV477vxUaYIrfFZRX8QhlIOA7w2IFX0VwlJFof3QEaTJFqx6TajIf4AIL60RdSia+HxA1NgvrP+4LbjKITe5WMhVoA12zEJR65nRl0OEStf+2smZNjhO0FKmqyLgR21iTvJa5/HmwdhLJFum/sp7+Tqs7bAk3sOsldFOYLMBpstQkLXe46tr9FqQrTrNogKngXqAw2EZud3vINS7GC9QeICToip6SgseOZVd2JojwhD07JPRGbbWabivNDhkzg==
Received: from AS8PR07CA0019.eurprd07.prod.outlook.com (2603:10a6:20b:451::22)
 by GVXPR03MB10309.eurprd03.prod.outlook.com (2603:10a6:150:156::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 20:40:44 +0000
Received: from AM6EUR05FT041.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:451:cafe::e) by AS8PR07CA0019.outlook.office365.com
 (2603:10a6:20b:451::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.9 via Frontend
 Transport; Fri, 27 Oct 2023 20:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.81) by
 AM6EUR05FT041.mail.protection.outlook.com (10.233.241.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.22 via Frontend Transport; Fri, 27 Oct 2023 20:40:44 +0000
Received: from outmta (unknown [192.168.82.133])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 B45EB2008009A; Fri, 27 Oct 2023 20:40:43 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (unknown
 [104.47.51.168])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id D19F72008006F; 
 Fri, 27 Oct 2023 20:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xrxoc2cXHFDBsg6V78mYPKvfvvd+gR31ePSSrqMYNR48FDd7vnQ7jaKQ87JXqFTO0w6fTkEZCbMEdWKG+ZM5fZhv/yjiBM/Bg5MngB8VhDwhyexqyrh6KBINTSEwPks3N3t14pmSfbxtwaFFaYQw7xEUYIfWNnUP6OHa2klfNq/01O5thl8FgbnUIEiHKnxPS7zDINAs86kUF+gl65DhybdI2uxWhs3r0DuiNCeMjypmV6MseLL7rBCJYhQlwZOZXWAKhXzglThyxBarPwcJeVi5T7w9iz+LxK5cRR+BytwpOfjX+vbydKl6LrM7ADMRp5jSYVYeCpHVFkppAtCO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNFQrzbCH+RayZMWIhcGT5z0AG26E6qoeQP6sWRZjOs=;
 b=E7tB3Gtm1EdT6hKySEbEpJPjXlaNVnauM81YysZ7V8nq+7VzGgN+04tyU6upv1SkNpJGEY9kzi6GBnl76PAUSPyWCDFyZ6yUb3H9TVncWgEi6gRdfGSzrpWlMit0RzUJ6h7C6NPIgBJH8GNRv02kJXB2EZsTcjszE/86WRItIZcEUiD/FV91EFLX1NyCO59OR1NAZNeiRvW5JjiJFLxKQxrb3mznUmJ7G8UFtbOLrG6Xdr0P6TBZ8hfx9a8CW1lerXJjSTx0pJqWpiNqr6lgdCtRwVj9F5qwueksRuEdoGkRCIK8vYXR0ZUUbjC1+r/ehsRN2YuWHIdasq5CZHPefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNFQrzbCH+RayZMWIhcGT5z0AG26E6qoeQP6sWRZjOs=;
 b=tsii1eIX2oEuGSavOGl5Rdej8s9Uyua8KyEJPD3GNhWELM3P+tjDxDU2s49jnRuS596Dyi0ngrrqy6qdC3P47rQSIV477vxUaYIrfFZRX8QhlIOA7w2IFX0VwlJFof3QEaTJFqx6TajIf4AIL60RdSia+HxA1NgvrP+4LbjKITe5WMhVoA12zEJR65nRl0OEStf+2smZNjhO0FKmqyLgR21iTvJa5/HmwdhLJFum/sp7+Tqs7bAk3sOsldFOYLMBpstQkLXe46tr9FqQrTrNogKngXqAw2EZud3vINS7GC9QeICToip6SgseOZVd2JojwhD07JPRGbbWabivNDhkzg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PAVPR03MB9211.eurprd03.prod.outlook.com (2603:10a6:102:325::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 20:40:29 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::7d1a:d4ce:f301:582a]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::7d1a:d4ce:f301:582a%6]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 20:40:29 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 1/3] arm: Fix software interrupt handler
Date: Fri, 27 Oct 2023 16:40:13 -0400
Message-Id: <20231027204015.1547595-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20231027204015.1547595-1-sean.anderson@seco.com>
References: <20231027204015.1547595-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PAVPR03MB9211:EE_|AM6EUR05FT041:EE_|GVXPR03MB10309:EE_
X-MS-Office365-Filtering-Correlation-Id: 79bf9925-1f0a-4f77-48d4-08dbd72cfdee
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: NwGBL1nIxjG9R0SKphBZi38hDpNRrnbmQnYDteSGqzOEZoUsEl8PHBSd2iBhgjklgPJvS0Uw32bclih+hV9qn0Z821t++avXZTf5VmKq1g9r13XosCRUjDjzr1gqvsAfvPzVuXW9qPYyPKt/6pixexVVg5y30uNwIIAfN7BekjGUfqhpiH+aIiYveaCF29n4mLB1oXaK0+O+4pVf3cvZs3n7fvFGP26xSmf15bbM8nzcyAc2cOz9tVvSOgP7vrraj0DsZz5UugTFCIvqAAE0v0VqDPHc0Z4GzwKkPKuk6fJQhz69gc+LnLada+27kzB274xMcHyWnAxwxMmDLhnOVtzBEKxadF3KDxPlm6AQrDT+SQfw6nlveYdoP0tSfmrDvtpqsn74zBHRJnt+GF2JmMNVG2s4oKfQXRh5qLcjAHN4bkjowM3YAOXg1DA5U4HoZKqEjfSlCQs+eMRWzsL3TOY4L02LRC6BhXnM3fYmTeVYz/BTstwsffXg9Bt/UNwBhEpoNq2rzhmOCh6+7y0KJ4ouKNRqhSodeBtkASyeDJ6L29xQXimMwbalV/qczkjVu90zxz0mt9SQTxnMJIidDqxfLk5Y3N+WughRhrfALQ4dN1aUBqFINdodO77CbLmS
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39850400004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(107886003)(41300700001)(8936002)(8676002)(54906003)(6486002)(44832011)(4326008)(478600001)(38350700005)(2906002)(5660300002)(316002)(36756003)(66476007)(66946007)(66556008)(86362001)(6916009)(52116002)(6512007)(1076003)(2616005)(26005)(6506007)(83380400001)(38100700002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9211
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT041.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 33ea21da-beaa-4c1b-ef55-08dbd72cf4e6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7JgGSC4pW3maHTnuOmDk+M72HLJAe8UIWU1+cn96e9/NLpCFOOBHEJWWlaQG3BLJEuJVz/V2fji6QCaqVUmRgIjTLXxonmgmaJ95CZzQnfp6AHgQS5XdEN3FSJocQABubdXumq0C4eoURpnT5G2y82GHD5AP/hZXdwroDb8/v7Gt3FFAH5G+TJh8NP8QUME8JRA6jPSfJhVqUsQzODzn9PHbbZyHr9KppHTF/9u6M1DocXr6cIyIumiD+FlexXF2a0xb2yqQVWi5u8pNX9FTFmQ8cHSn+2hlnAGNxkLrPuRVA6R77PT0I8pfTs+ChZjBtwfpHlh8zNagwuqIXJvfIlx+NxnCpKV8/tU0eVO9zK4fF9Tr/fYk8Y32vlw5j8TyLh+Dn08xxWIQzIT8PgwE465h5jEpIdw0QEsRFofLQY0n6S8cGVcOxkCbTzg0VC6HuHtSCFxj3UVR4tkEZgc67/0os9bp5vPXSmBbnkPByByrX/RwdhGN5Be4QnngDexEeRqWZJ7Pe3QLnHxr0j9F66qzPI76JPXSXwPUL4WqRrm92HsFzprrluhbXW1PWDHNcWYl58cgHfN32snx3z2aW2HqrgUWqrBgsz2w9SBNthlnXxuzOUoanrbO0A2xoQRVShGunoyPqOY6Dp9GCkhh8BdI8r5hRa8tABUuoaIx74ahkoIOyqXE61omCqsHb+sPmyrVXOHEGoM8sKLqdHRdvmc4QYgI0ELdn+h4/qa/l5hXtJM8ZwXfDeYNyQDrjNWnZoA7CtlO8GY0s5SMLpPAg==
X-Forefront-Antispam-Report: CIP:20.160.56.81; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(346002)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(478600001)(36860700001)(6666004)(40480700001)(6486002)(6506007)(36756003)(2616005)(107886003)(1076003)(26005)(82740400003)(6512007)(40460700003)(47076005)(34070700002)(83380400001)(2906002)(5660300002)(44832011)(41300700001)(8676002)(8936002)(86362001)(4326008)(7596003)(7636003)(356005)(70586007)(54906003)(70206006)(6916009)(316002)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 20:40:44.1373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bf9925-1f0a-4f77-48d4-08dbd72cfdee
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.81];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT041.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10309
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

When we take a software interrupt, we are already in supervisor mode.
get_bad_stack assumes we are not in supervisor mode so it can clobber
the stack pointer. This causes us to have an invalid stack once that
macro finishes. Revert back to the get_bad_stack_swi macro which was
previously removed.

Fixes: 41623c91b09 ("arm: move exception handling out of start.S files")
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 arch/arm/lib/vectors.S | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/vectors.S b/arch/arm/lib/vectors.S
index 7cf7d1636f5..fe8ca403ac9 100644
--- a/arch/arm/lib/vectors.S
+++ b/arch/arm/lib/vectors.S
@@ -240,6 +240,18 @@ IRQ_STACK_START_IN:
 	movs	pc, lr		@ jump to next instruction & switch modes.
 	.endm
 
+	.macro get_bad_stack_swi
+	sub	r13, r13, #4	@ space on current stack for scratch reg.
+	str	r0, [r13]	@ save R0's value.
+	ldr	r0, IRQ_STACK_START_IN		@ get data regions start
+	str	lr, [r0]	@ save caller lr in position 0 of saved stack
+	mrs	lr, spsr	@ get the spsr
+	str	lr, [r0, #4]	@ save spsr in position 1 of saved stack
+	ldr	lr, [r0]	@ restore lr
+	ldr	r0, [r13]	@ restore r0
+	add	r13, r13, #4	@ pop stack entry
+	.endm
+
 	.macro get_irq_stack			@ setup IRQ stack
 	ldr	sp, IRQ_STACK_START
 	.endm
@@ -260,7 +272,7 @@ undefined_instruction:
 
 	.align	5
 software_interrupt:
-	get_bad_stack
+	get_bad_stack_swi
 	bad_save_user_regs
 	bl	do_software_interrupt
 
-- 
2.35.1.1320.gc452695387.dirty

