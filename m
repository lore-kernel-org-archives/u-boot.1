Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC18E732DE
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 14:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F49986E6C;
	Thu, 28 Sep 2023 16:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="VudOYSqT";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="VudOYSqT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E1A86E7A; Thu, 28 Sep 2023 16:45:24 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF48886E6B
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 16:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQ9Sh7tf5IeqiGsKmB3XeGslnSTZaVJb2zDUYMPOF5c=;
 b=VudOYSqTeVk2Ax2VU2zjDG/5es7L+GOxtmVK/GNMRlsAQf/AHLbX6nFfs4xmRVtsOy57xpoYBsbE9T3bOYN4M34CrFpw7wBPsHlAuUI9FiLs1W5xHHsbHPhSOUGBzzT8biWJkHwLxQIXv+SGKD/6+9ln5mBPkhi0u6PM/fleQ4nnmZEU1TI7wIkL7jsLpXqQOPbasFlxpKOjHdPg63ew5yDYQDXDHhgSx2VrWZHYQcYoVDjIWIs7bDz87hhn6a/VZf/a2g2FAtI/hFRhPCh2GiNSa5bRmDuTkmF114l6OXPYMFqLqedPM30Ts8tOy09cI7trHuhZ7r6t0RdKttvjfA==
Received: from DB7PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:10:36::17)
 by AS8PR03MB9649.eurprd03.prod.outlook.com (2603:10a6:20b:5ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 14:45:19 +0000
Received: from DB8EUR05FT028.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:36:cafe::6e) by DB7PR05CA0004.outlook.office365.com
 (2603:10a6:10:36::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Thu, 28 Sep 2023 14:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.85) by
 DB8EUR05FT028.mail.protection.outlook.com (10.233.238.130) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.25 via Frontend Transport; Thu, 28 Sep 2023 14:45:19 +0000
Received: from outmta (unknown [192.168.82.133])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 E5A33200813AB; Thu, 28 Sep 2023 14:45:18 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.104])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id C3A492008006D; 
 Thu, 28 Sep 2023 14:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThIqykB7OnjXAUaTT90T5nwVt56nPpcb8LVaHBTJ0N7A2NXY8WLqMFiBmGCuFRhzBc70bpbtvWCY/caNicL9IkYFUONwgA3tvZ0ouzHP2s3qB72woRWMOldMFM9HjJvBlIsiwRFnp2rUtVoH/rfi7GXlQonr/xCWjbz7mprTGZ4vPNS1rm1t1HhydQwl6Z2itmdu/KSiWCyCTKebWjUgmKYr/uoJcMyBbJHXqM9HIXbg0yVBhrUi1ic8OVnq7XndTykSVnkXrZGx3zLPeJ/tTRjq1InPELlmgks5DhJskFD9Dt7IGxqoNiZr/MluXjDSArhDZJSmLaMqyJLW8cmPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQ9Sh7tf5IeqiGsKmB3XeGslnSTZaVJb2zDUYMPOF5c=;
 b=MT/U/bH9Z//X0WiUe5oGHg5ILSQiKBQWThdU5lc1BE7mweXMViKRrZCiySEoYIju1j3HTQEJRk7GeNIIBe0Xt/2fPGdrgNrY2pjPIlgb4m0n9hmhjocA+uYFq0Nn8B8trK8D1VSS+z61wNH9J731QrGQ+7XUrJKEw6BSlnuXNxlf6a7rqsajtsz/6aBtYquPC0T268eqzl0+4990McczrLwC+QA+GxsyxSjK0IbGDXP7lxGiELdhbIldQPACeKmL1yR/h7eldOvowoAc+01yZ3jxICGZsYna5jcOQM6Ex5RCwrUAUXggNJP4GvpO9XBgecOuasoXIHjuXZgMTqQt+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQ9Sh7tf5IeqiGsKmB3XeGslnSTZaVJb2zDUYMPOF5c=;
 b=VudOYSqTeVk2Ax2VU2zjDG/5es7L+GOxtmVK/GNMRlsAQf/AHLbX6nFfs4xmRVtsOy57xpoYBsbE9T3bOYN4M34CrFpw7wBPsHlAuUI9FiLs1W5xHHsbHPhSOUGBzzT8biWJkHwLxQIXv+SGKD/6+9ln5mBPkhi0u6PM/fleQ4nnmZEU1TI7wIkL7jsLpXqQOPbasFlxpKOjHdPg63ew5yDYQDXDHhgSx2VrWZHYQcYoVDjIWIs7bDz87hhn6a/VZf/a2g2FAtI/hFRhPCh2GiNSa5bRmDuTkmF114l6OXPYMFqLqedPM30Ts8tOy09cI7trHuhZ7r6t0RdKttvjfA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from AS8PR03MB8832.eurprd03.prod.outlook.com (2603:10a6:20b:56e::11)
 by AS8PR03MB6870.eurprd03.prod.outlook.com (2603:10a6:20b:29f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 14:45:14 +0000
Received: from AS8PR03MB8832.eurprd03.prod.outlook.com
 ([fe80::afab:7dfd:192:dee5]) by AS8PR03MB8832.eurprd03.prod.outlook.com
 ([fe80::afab:7dfd:192:dee5%5]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 14:45:14 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 3/4] malloc: Don't statically initialize av_ if using
 malloc_init
Date: Thu, 28 Sep 2023 10:44:57 -0400
Message-Id: <20230928144458.2511087-4-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20230928144458.2511087-1-sean.anderson@seco.com>
References: <20230928144458.2511087-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00016415.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:d) To AS8PR03MB8832.eurprd03.prod.outlook.com
 (2603:10a6:20b:56e::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR03MB8832:EE_|AS8PR03MB6870:EE_|DB8EUR05FT028:EE_|AS8PR03MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e57847-3073-4fda-7eb7-08dbc0318948
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: PGDakCuUn8+WCelprGftBdmV0xm72l/JnLTydpx9fJC6njImUqp80z47dAoUDQuaOH+00y/n329hcjkBO3EMovtpXgoQYs1jF2G0fXQdsB2uQ9gfcY2EG0K6QG8KwxNjNYbFGStwMxVPwGA4CP9WMZO99dQpTlyb6uwhb7IZVzwkAK6XQbka7GkaTemiFEV7FP45np4ljUnCG/u2LmuaHYfMFZoHzsTPtMC5RwcxJFgvWt6YInpPooeEctWejMldF+yZ2ZhTt6G152FDs83+/jZ3GqkvAZzEDI8Ule3y6dRvrwjk3rMyj/vq8uQkY849wJ4LoAKv9HeMG5yFO9pwdLJRFUUA2UnRTinOmoi0IBdKStomqppbyAe035mT2HrxVA1uTGu73Bz/LQ6MYADbI1bJeXJlGHlUdXJYw7/adOFSo86IYmKm/mP+xouBWuFy0Xn1gDHUsj+rJuTviAwNu9bYdMihH4H1IjvD4hvSJv1f6jXtH23PRgM1XyP6Wzqh2/Kcf31T/E043N+iPu06pu+EsRbtDvrByMXvp0Q+0o4i5l+PvVl1vbl8q9uZXsS4SmQxIv/O7+Rp0VNjjdxfaEobGmnqqtcwe0O0VrZvBhq2SPqG7TpJWXDMhg1Z5L6u
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR03MB8832.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(376002)(396003)(346002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2906002)(4326008)(41300700001)(316002)(8676002)(8936002)(44832011)(36756003)(5660300002)(66946007)(66476007)(66556008)(86362001)(478600001)(1076003)(6506007)(6512007)(52116002)(6666004)(2616005)(107886003)(38100700002)(38350700002)(26005)(83380400001)(6486002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6870
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT028.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ffeb1cba-ff85-483c-dfdc-08dbc031861b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgQGGUv3Hbu3SQJQVKlsMdFxX1QqeqNKz0baGJTjIlh8eukhIW3Zs8TtS0AfR6gIuEv5T52s+p1PQf6O4vZByn2godZ0/w9Gc2HVtdScmZz/5a8E0GTvYeYYMgZipRb8fbR+ql8jnHB0dBxOeY2U1B+ndZ6EV1HwczNa8uKRX1ysxlcjthUsRxLJZnRo1azJBsfKWhPPyTukBxg8VSEYZxEFKzdti9NOgDMqxElOsef4F6ygfmgmsx5VcbaPQBLSB/m6AQN4FZfqBo7qCtjmnsrIY5Mo43V7Ij7ccGpvtY7qPQs8R5CWdzjVd1KZusKzFue0qJ8gA/rxOEycGQuI38n7tRePixYmbrHlhbge6Qa5YnYxGZ/u1B9MhvCbPNxhxATQ/vwzzURUo39PKu+4/g5nZ8ShhPLkQJJzl0cwKHBZgu8nS3BFtt8NcFZOdWgSYeZC94PU9IJX7dR9/CtVJkfxzKi3mmEdXMjdKEUNNnFihvWzHjrGHcrnpow3jZQxGc/k+PbO4zv0blKTzeV7bXjDPvQ27T4Zs5ucP522Qz+5t5H95UPMOEDKcDBp532/u2e2P4Kh3S+NYhggbNTkqYXgUBmzvrHY6FZMnVtgr8FYWxwj6jluTFtWs5pGE9+TfmzLqt6RU3FBO995P5P33RUj9xSJGAMT4mbr9hrj1IcJizX8QCsaa8fIuZM6FJMSMdZrtSfuCoVVM1rJdYyC5yYAbdf6qyQRQPbM+15tR3SyZMvrwelkYAw/7DxYabVeEXvysQW2Vm59PnIDw7OTIg==
X-Forefront-Antispam-Report: CIP:20.160.56.85; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(376002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(2616005)(336012)(83380400001)(26005)(107886003)(1076003)(34070700002)(36860700001)(47076005)(70206006)(2906002)(316002)(54906003)(6666004)(6486002)(4326008)(8936002)(478600001)(6506007)(70586007)(8676002)(6512007)(44832011)(41300700001)(86362001)(36756003)(7596003)(356005)(5660300002)(82740400003)(7636003)(40480700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 14:45:19.1436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e57847-3073-4fda-7eb7-08dbc0318948
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.85];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT028.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9649
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

When we enable malloc_init, there is no need to statically initialize
av_, since we are going to do it manually. This lets us move av_ to
.bss, saving around 1-2k of data (depending on the pointer size).

cALLOc must be adjusted to not access top before malloc_init.

While we're at it, rename/reword the Kconfig to better describe what
this option does.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Use CONFIG_IS_ENABLED in conditionals

Changes in v2:
- Fix cALLOc condition

 Kconfig           | 18 +++++++-----------
 common/dlmalloc.c |  9 +++++++--
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/Kconfig b/Kconfig
index a3061c86124..3967613b232 100644
--- a/Kconfig
+++ b/Kconfig
@@ -405,18 +405,14 @@ if EXPERT
 	  When disabling this, please check if malloc calls, maybe
 	  should be replaced by calloc - if one expects zeroed memory.
 
-config SYS_MALLOC_DEFAULT_TO_INIT
-	bool "Default malloc to init while reserving the memory for it"
+config SYS_MALLOC_RUNTIME_INIT
+	bool "Initialize malloc's internal data at runtime"
 	help
-	  It may happen that one needs to move the dynamic allocation
-	  from one to another memory range, eg. when moving the malloc
-	  from the limited static to a potentially large dynamic (DDR)
-	  memory.
-
-	  If so then on top of setting the updated memory aside one
-	  needs to bring the malloc init.
-
-	  If such a scenario is sought choose yes.
+         Initialize malloc's internal data structures at runtime, rather than
+         at compile-time. This is necessary if relocating the malloc arena
+         from a smaller static memory to a large DDR memory. It can also
+         reduce the size of U-Boot by letting malloc's data reside in .bss
+         instead of .data.
 
 config TOOLS_DEBUG
 	bool "Enable debug information for tools"
diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index c7cd7815a27..ec1a20fc3d7 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -556,6 +556,7 @@ typedef struct malloc_chunk* mbinptr;
 #define IAV(i)  bin_at(i), bin_at(i)
 
 static mbinptr av_[NAV * 2 + 2] = {
+#if !CONFIG_IS_ENABLED(SYS_MALLOC_RUNTIME_INIT)
  NULL, NULL,
  IAV(0),   IAV(1),   IAV(2),   IAV(3),   IAV(4),   IAV(5),   IAV(6),   IAV(7),
  IAV(8),   IAV(9),   IAV(10),  IAV(11),  IAV(12),  IAV(13),  IAV(14),  IAV(15),
@@ -573,6 +574,7 @@ static mbinptr av_[NAV * 2 + 2] = {
  IAV(104), IAV(105), IAV(106), IAV(107), IAV(108), IAV(109), IAV(110), IAV(111),
  IAV(112), IAV(113), IAV(114), IAV(115), IAV(116), IAV(117), IAV(118), IAV(119),
  IAV(120), IAV(121), IAV(122), IAV(123), IAV(124), IAV(125), IAV(126), IAV(127)
+#endif
 };
 
 static void malloc_init(void);
@@ -610,7 +612,7 @@ void mem_malloc_init(ulong start, ulong size)
 	mem_malloc_end = start + size;
 	mem_malloc_brk = start;
 
-	if (CONFIG_IS_ENABLED(SYS_MALLOC_DEFAULT_TO_INIT))
+	if (CONFIG_IS_ENABLED(SYS_MALLOC_RUNTIME_INIT))
 		malloc_init();
 
 	debug("using memory %#lx-%#lx for malloc()\n", mem_malloc_start,
@@ -2137,7 +2139,10 @@ Void_t* cALLOc(n, elem_size) size_t n; size_t elem_size;
 #ifdef CONFIG_SYS_MALLOC_CLEAR_ON_INIT
 #if MORECORE_CLEARS
   mchunkptr oldtop = top;
-  INTERNAL_SIZE_T oldtopsize = chunksize(top);
+  INTERNAL_SIZE_T oldtopsize;
+  if (!CONFIG_IS_ENABLED(SYS_MALLOC_F) ||
+      (gd->flags & GD_FLG_FULL_MALLOC_INIT))
+    oldtopsize = chunksize(top);
 #endif
 #endif
   Void_t* mem = mALLOc (sz);
-- 
2.35.1.1320.gc452695387.dirty

