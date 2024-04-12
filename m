Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8272CC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 15:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 044FE881F6;
	Fri, 12 Apr 2024 17:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="uJqcR1yP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04677881FB; Fri, 12 Apr 2024 17:53:28 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F022881D7
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 17:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4832881ce4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43CDhas5027966; Fri, 12 Apr 2024 17:53:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=Rii30/jm+NBxVQpfj+6GhRwGy8HkmvwzjoeA1pJGpE0=; b=uJ
 qcR1yPQ+j5lBbRMuFCSATKLJauEDhf7YDC1TKir+HKgToTvcqpc0x3lalXvWrMXZ
 5aZSJgcgPONtT4XElOUWdK8ettRDNhvb54kX2vpMC4/S9/ephwD1nV5BfjvUuocW
 bLB5Fr85vLs8x8TC2NyBKZhF3vawbo0xsSH7HDVIDb7wiVytoWmakH7TuBbCsnmS
 CyeJlj0kKC/yaFwYzyyK1/rW3rkID68TLp+bOrIdZPKf6XwH+/DpvW7wgMXUvsX0
 ER97EZRgDJwS9/4qsocWGArpyWAAd/4DnnzfuSr75kgblMdGt5YpwFhW08y0Ew74
 AXXT7Id+pkl6DxSX+UaA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xbhbjfvtk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Apr 2024 17:53:19 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7BF904004A;
 Fri, 12 Apr 2024 17:53:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4313C21A22E;
 Fri, 12 Apr 2024 17:53:15 +0200 (CEST)
Received: from localhost (10.252.26.170) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 12 Apr
 2024 17:53:14 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Kumar Gala
 <galak@kernel.crashing.org>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2 2/2] lmb: Fix adjacent region merge in
 lmb_add_region_flags()
Date: Fri, 12 Apr 2024 17:53:06 +0200
Message-ID: <20240412155307.735631-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412155307.735631-1-patrice.chotard@foss.st.com>
References: <20240412155307.735631-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.26.170]
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_12,2024-04-09_01,2023-05-22_02
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
 reserved[3]    [0xdaae1000-0xdfffffff], 0x0551f000 bytes flags: 0
 reserved[4]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
...

after this patch:

...
lmb_dump_all:
 memory.cnt = 0x1 / max = 0x2
 memory[0]      [0xc0000000-0xdfffffff], 0x20000000 bytes flags: 0
 reserved.cnt = 0x5 / max = 0x10
 reserved[0]    [0x10000000-0x10045fff], 0x00046000 bytes flags: 4
 reserved[1]    [0x30000000-0x3003ffff], 0x00040000 bytes flags: 4
 reserved[2]    [0x38000000-0x3800ffff], 0x00010000 bytes flags: 4
 reserved[3]    [0xdaae1000-0xddffffff], 0x0351f000 bytes flags: 0
 reserved[4]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
...

Fixes: 4ed6552f7159 ("[new uImage] Introduce lmb from linux kernel for memory mgmt of boot images")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

Changes in v2:
  _ Fix lmb_add_region_flags() by updating test which leads to
    extend an existing region

 lib/lmb.c | 57 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index b6afb731440..4ed60f4a843 100644
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
@@ -283,19 +299,21 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
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
+			if (overlap < 0 || flags == rgn->region[overlap].flags) {
+				/*
+				 * no overlap detected or overlap with same flags detected,
+				 * extend region
+				 */
+				if  (adjacent > 0)
+					rgn->region[i].base -= size;
+				rgn->region[i].size += size;
+				coalesced++;
+				break;
+			}
 		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
 			/* regions overlap */
 			return -1;
@@ -420,21 +438,6 @@ long lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size)
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

