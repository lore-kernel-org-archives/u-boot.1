Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E09CC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 14:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B80658786A;
	Mon, 11 Mar 2024 15:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="QJ2BhAJm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4769987E3D; Mon, 11 Mar 2024 15:41:12 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9DFC87EEB
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 15:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=38002904ae=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BEdp1A009497; Mon, 11 Mar 2024 15:40:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=6llXTwRp3Kwenc2Um6A7hLRm2gqVUvPJScNR1b7WPIQ=; b=QJ
 2BhAJmT4rJgbKg1MFBAYHfX0WLybaNvG6ldXfZizhuiSqBQzepDc3GM3yePLASyp
 PI/koliVX8yH6YeFxeIYMlWfxf3hIGF4tgXTxrh8OWSn66LgTsfpUXtMw9ZxS1gD
 AkNN1uKTbrduI2AUpsO7SiyoXOilHcfkzyZBWc3ioAtyZaCet9wVBcPOTMxPDjJZ
 ovUzjX/NlHzvQvAhh/C3RqErDGJgTvK9AWHlHF5LG7SExodiQshrvlVzPPhnb4Y0
 W7LwWY6HUD8utTwSQR3Co0ex6KgGPn/Fd6e5HTUu2N07iNIo32Gg0I8W57DqSNEv
 YYb7pw4aFrlu1ENZj+og==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wrfhfgh8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 15:40:58 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F21FD4002D;
 Mon, 11 Mar 2024 15:40:53 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6D7C32828A3;
 Mon, 11 Mar 2024 15:40:25 +0100 (CET)
Received: from localhost (10.201.20.71) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Mar
 2024 15:40:25 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Kumar Gala
 <galak@kernel.crashing.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 2/2] lmb: Fix adjacent region merge in lmb_add_region_flags()
Date: Mon, 11 Mar 2024 15:39:18 +0100
Message-ID: <20240311143918.2927406-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311143918.2927406-1-patrice.chotard@foss.st.com>
References: <20240311143918.2927406-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.71]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
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

In case a new region is adjacent to a previous region with
similar flag, this region is merged with its predecessor, but no
check are done if this new added region is overlapping another region
present in lmb (see reserved[3] which overlaps reserved[4]).

This occurs when the LMB [0xdaafd000-0xddb18000] is added and overlaps
the LMB [0xdbaf4380-0xddffffff].

Call lmb_overlaps_region() before merging the new region with the
adjacent region already present in lmb.

In case of adjacent region found, code is 90% similar in case
adjacent region is located before/after the new region.
Factorize adjacent region management in lmb_add_region_flags().

Issue reproduced on STM32MP157-DK2 with SCMI DT, bdinfo command's output
shows:

before this patch:
...
lmb_dump_all:
 memory.cnt = 0x1 / max = 0x2
 memory[0]      [0xc0000000-0xdfffffff], 0x20000000 bytes flags: 0
 reserved.cnt = 0x5 / max = 0x10
 reserved[0]    [0x10000000-0x10045fff], 0x00046000 bytes flags: 4
 reserved[1]    [0x30000000-0x3003ffff], 0x00040000 bytes flags: 4
 reserved[2]    [0x38000000-0x3800ffff], 0x00010000 bytes flags: 4
 reserved[3]    [0xdaadf000-0xdfffffff], 0x05521000 bytes flags: 0
 reserved[4]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
...

after this patch:

...
lmb_dump_all:
 memory.cnt = 0x1 / max = 0x2
 memory[0]      [0xc0000000-0xdfffffff], 0x20000000 bytes flags: 0
 reserved.cnt = 0x6 / max = 0x10
 reserved[0]    [0x10000000-0x10045fff], 0x00046000 bytes flags: 4
 reserved[1]    [0x30000000-0x3003ffff], 0x00040000 bytes flags: 4
 reserved[2]    [0x38000000-0x3800ffff], 0x00010000 bytes flags: 4
 reserved[3]    [0xdaadf000-0xdaaf7fff], 0x00019000 bytes flags: 0
 reserved[4]    [0xdbaf4380-0xddffffff], 0x0250bc80 bytes flags: 0
 reserved[5]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
...

Fixes: 4ed6552f7159 ("[new uImage] Introduce lmb from linux kernel for memory mgmt of boot images")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 lib/lmb.c | 55 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index b6afb731440..f583b10f776 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -130,6 +130,22 @@ static void lmb_fix_over_lap_regions(struct lmb_region *rgn, unsigned long r1,
 	lmb_remove_region(rgn, r2);
 }
 
+static long lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
+				phys_size_t size)
+{
+	unsigned long i;
+
+	for (i = 0; i < rgn->cnt; i++) {
+		phys_addr_t rgnbase = rgn->region[i].base;
+		phys_size_t rgnsize = rgn->region[i].size;
+
+		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize))
+			break;
+	}
+
+	return (i < rgn->cnt) ? i : -1;
+}
+
 void lmb_init(struct lmb *lmb)
 {
 #if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
@@ -257,7 +273,7 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 				 phys_size_t size, enum lmb_flags flags)
 {
 	unsigned long coalesced = 0;
-	long adjacent, i;
+	long adjacent, i, overlap;
 
 	if (rgn->cnt == 0) {
 		rgn->region[0].base = base;
@@ -283,19 +299,19 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 		}
 
 		adjacent = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
-		if (adjacent > 0) {
-			if (flags != rgnflags)
-				continue;
-			rgn->region[i].base -= size;
-			rgn->region[i].size += size;
-			coalesced++;
-			break;
-		} else if (adjacent < 0) {
+		if (adjacent != 0) {
 			if (flags != rgnflags)
 				continue;
-			rgn->region[i].size += size;
-			coalesced++;
-			break;
+			overlap = lmb_overlaps_region(rgn, base, size);
+			if (overlap < 0) {
+				/* no overlap detected, extend region */
+				if  (adjacent > 0)
+					rgn->region[i].base -= size;
+				rgn->region[i].size += size;
+				coalesced++;
+				break;
+			}
+			continue;
 		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
 			/* regions overlap */
 			return -1;
@@ -420,21 +436,6 @@ long lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 	return lmb_reserve_flags(lmb, base, size, LMB_NONE);
 }
 
-static long lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
-				phys_size_t size)
-{
-	unsigned long i;
-
-	for (i = 0; i < rgn->cnt; i++) {
-		phys_addr_t rgnbase = rgn->region[i].base;
-		phys_size_t rgnsize = rgn->region[i].size;
-		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize))
-			break;
-	}
-
-	return (i < rgn->cnt) ? i : -1;
-}
-
 phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align)
 {
 	return lmb_alloc_base(lmb, size, align, LMB_ALLOC_ANYWHERE);
-- 
2.25.1

