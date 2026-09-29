Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C67CA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:06:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E46DF60717;
	Tue, 29 Sep 2026 00:06:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hcHY1sfN7uqk; Tue, 29 Sep 2026 00:06:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1D5726070C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790640375;
	b=U3Y7n5j/4jsquyEbJIxcPzuCA+vB5P6maFDS77I0plDCe1sDHglYHrUReJTBs/QusRwW
	 FqDdLIe8l/o/eHy8TWx68nX8R2/tywJe9PXqKe9FW4loKGWiJ6ca7xp29pXiL+UNqKJ7+
	 6opFs/uh4xHzb8dtXJhmhbsth7WvVSfk/TGzMa+/1+8k7W+CcRcXjJbIBsSlGsxdr9lYX
	 bGC0nYn5Jsj5gzD0FlbI85+alQHj7t+dsj5+AQKn3IDaFV4XEeWoZyQ9auXEylUbbkjOs
	 PSRR71KCp8DCPW9Qv6bF6vReHYXTzvXCPVIq8Vk19sNzPjWJ95GZbRv07cEmzM5qr6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790640375;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Lvxcl0CwIKsfbXJsC7m5EFmSrMZRezvSBsTXJ3KcpAY=;
	b=R6G6VqgbOKUNj4/uk2H11CGddW5FxA+kHhgeWuo+ExTl2YOvT70P4XiUsSjK9igXu6FH
	 0joExxAdi6a7O8SZMPWRqvY16ArX6KjXh/eKKWq66R3ZZ0zVxH6retkGSpLke7bOwODZy
	 hB//9oP97Z8FAtlU+G/0in6fUXmtiZyMEabSXmQJf/zQO2IK2su5PXY9bunRzERfWgBDt
	 UwzztvWf55qn4nBuId2KPB2ivwO1U9Ai+LnV0JVgt3kgoo6LquOTHxsggA3hnf9p4fi8+
	 MX0zW0BnShpOJsmZadjICZqCaGOUhA9gZDzNzlYjbyunO0HGYy9bWY46Tiiovr8q1Ew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=makrotopia.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790640375;
	bh=Lvxcl0CwIKsfbXJsC7m5EFmSrMZRezvSBsTXJ3KcpAY=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HdB+XzHjsv5tfRzJU9ahFGX6Kvgq6FesPUNDqcBGT/4aLDZD32+2ONv/U2vm6H77U
	 bwCD4pj6y4+O8k995c/sxaWeoDQdrWdOFCQvFLfLj4SQtd65zxBmOpL9xAweBBM3dF
	 R0P1Mw0TDD2TKW0QnwDPAynYG/pn+0Ob2aj+X5gnYNyrYMxqrT40fgmOfbhfX/L2Qe
	 FZrXjnuwFmzM1kpTuGYuWUvL2md96VjXeHzV3glGTATxzeKojXPqmUzgRE/Ey/lpHk
	 Dc7tHwpxjKd8aE4hNT5PDh07NhZYLztqJ3MJSKyxST8B4tTwe40K3LpdSzlibNfl+b
	 jLkbyTdOjQcRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D5726070C;
	Tue, 29 Sep 2026 00:06:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED36A417
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:06:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE9876070C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:06:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XIjhgqsYGadz for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:06:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0B90E60707
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790640373;
 b=TyUWlnTvb9zPdrBUWPNyf6TA3IO1z9WM4UD1MmZfWck+i8rEzLrIqYwBZeWeVDuZo7x3
 OaD5pJLXnMnJ5cURUl30O3EUdAjthkIhZmBzf/rbiMb1i01oXYzd89AoYGj1GCvSo2Iw/
 PGt7/g2mB/4EQ1jjUuWo4rsTeML6abhbbMOb/ruBGKq7CJjpGq7zuDQWRyVc0vjqnz20v
 TKjMZzF2VF8pO3Jixqo7XrHhfBmhDoP75HZw4zUfroiudI/3ov9zaONvXzsJAa0bb5SF0
 +OLp9tphFOK20RVuqtZUNwSndCeuJCvOhjz8tsa161uCNcScnb+OR/4tOOtN31dQi2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790640373;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=Lvxcl0CwIKsfbXJsC7m5EFmSrMZRezvSBsTXJ3KcpAY=;
 b=Em4eGkD7XvqCs+uVjjZdbQ38x9eLzas5yDekSlqQqdBHsot5WhdaX3gZxzLF7pqoZDYd
 S/eqZmCs/suGoSNWigQvahNBPzEU1GvqeazfiU55bRyWll55GmHTU4vrXf6+5fZw5VIt6
 0WYXbETdKOo+qiNUIHGxcNfeAGofo+DyVAMzqrJFPlxqWzOH8KhzQe+FrxXcvhGdrBTeh
 NBxFzCXgT3I2opjspcA+AbEbmvy3RjWaIMbYofq98ODNY8//HycckZigjfIy9/c6oN7HW
 aTb9glgRILdGsw3IbCjUbSjIOV4XAKg15QNSm1l5X7njwfmPsDpTrXhCLRiJxrtIffQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=makrotopia.org; 
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B90E60707
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:06:12 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1xBLMG-000000001Sg-2h4d;
 Tue, 29 Sep 2026 00:06:08 +0000
Date: Tue, 29 Sep 2026 01:06:05 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Weijie Gao <weijie.gao@mediatek.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 11/11] test: boot: imagemap: reset driver-model state between
 tests
Message-ID: <8fc90665aa0d615c4fe7fdabae57727666cac612.1790626459.git.daniel@makrotopia.org>
References: <cover.1790626459.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790626459.git.daniel@makrotopia.org>
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

The tests bind and probe devices under dm_root() and the storage tests
depend on real driver-model state, but none of them asks for the DM
init and uninit the test framework provides. A test that fails before
imagemap_cleanup() therefore leaves its bound device behind, and the next
one trips over the name clash in device_bind_driver().

Pass UTF_DM throughout, and UTF_SCAN_FDT for the two tests that walk
device-tree partitions. Those two are also marked UTF_LIVE_TREE: they
drive mtd_probe_devices(), which cannot parse the partitions of a master
bound from a flat tree.

Fixes: 05c1fbbfa79f ("test: boot: add imagemap unit tests")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 test/boot/imagemap.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
index 20a8f150a48..de00a174470 100644
--- a/test/boot/imagemap.c
+++ b/test/boot/imagemap.c
@@ -155,7 +155,7 @@ static int imagemap_test_map_basic(struct unit_test_state *uts)
 	return 0;
 }
 
-IMAGEMAP_TEST(imagemap_test_map_basic, 0);
+IMAGEMAP_TEST(imagemap_test_map_basic, UTF_DM);
 
 /* Test: map() returns cached pointer for already-mapped range */
 static int imagemap_test_map_cached(struct unit_test_state *uts)
@@ -188,7 +188,7 @@ static int imagemap_test_map_cached(struct unit_test_state *uts)
 	return 0;
 }
 
-IMAGEMAP_TEST(imagemap_test_map_cached, 0);
+IMAGEMAP_TEST(imagemap_test_map_cached, UTF_DM);
 
 /* Test: map() returns correct offset within a larger region */
 static int imagemap_test_map_offset(struct unit_test_state *uts)
@@ -222,7 +222,7 @@ static int imagemap_test_map_offset(struct unit_test_state *uts)
 	return 0;
 }
 
-IMAGEMAP_TEST(imagemap_test_map_offset, 0);
+IMAGEMAP_TEST(imagemap_test_map_offset, UTF_DM);
 
 /* Test: map() re-reads when extending a region to a larger size */
 static int imagemap_test_map_extend(struct unit_test_state *uts)
@@ -281,7 +281,7 @@ static int imagemap_test_map_extend(struct unit_test_state *uts)
 	return 0;
 }
 
-IMAGEMAP_TEST(imagemap_test_map_extend, 0);
+IMAGEMAP_TEST(imagemap_test_map_extend, UTF_DM);
 
 /* Test: map_to() reads to a specified address and records it */
 static int imagemap_test_map_to(struct unit_test_state *uts)
@@ -315,7 +315,7 @@ static int imagemap_test_map_to(struct unit_test_state *uts)
 	return 0;
 }
 
-IMAGEMAP_TEST(imagemap_test_map_to, 0);
+IMAGEMAP_TEST(imagemap_test_map_to, UTF_DM);
 
 /* Test: lookup() returns NULL for unmapped ranges */
 static int imagemap_test_lookup_miss(struct unit_test_state *uts)
@@ -350,7 +350,7 @@ static int imagemap_test_lookup_miss(struct unit_test_state *uts)
 	return 0;
 }
 
-IMAGEMAP_TEST(imagemap_test_lookup_miss, 0);
+IMAGEMAP_TEST(imagemap_test_lookup_miss, UTF_DM);
 
 /* Test: LMB reservations are made for map() allocations */
 static int imagemap_test_lmb_reserve(struct unit_test_state *uts)
@@ -383,7 +383,7 @@ static int imagemap_test_lmb_reserve(struct unit_test_state *uts)
 	return 0;
 }
 
-IMAGEMAP_TEST(imagemap_test_lmb_reserve, 0);
+IMAGEMAP_TEST(imagemap_test_lmb_reserve, UTF_DM);
 
 /* Test: cleanup() removes the device */
 static int imagemap_test_cleanup(struct unit_test_state *uts)
@@ -405,7 +405,7 @@ static int imagemap_test_cleanup(struct unit_test_state *uts)
 	return 0;
 }
 
-IMAGEMAP_TEST(imagemap_test_cleanup, 0);
+IMAGEMAP_TEST(imagemap_test_cleanup, UTF_DM);
 
 /* Test: map() with multiple disjoint regions */
 static int imagemap_test_multi_region(struct unit_test_state *uts)
@@ -448,7 +448,7 @@ static int imagemap_test_multi_region(struct unit_test_state *uts)
 	return 0;
 }
 
-IMAGEMAP_TEST(imagemap_test_multi_region, 0);
+IMAGEMAP_TEST(imagemap_test_multi_region, UTF_DM);
 
 /* Test: read beyond image size returns error */
 static int imagemap_test_read_oob(struct unit_test_state *uts)
@@ -474,7 +474,7 @@ static int imagemap_test_read_oob(struct unit_test_state *uts)
 	return 0;
 }
 
-IMAGEMAP_TEST(imagemap_test_read_oob, 0);
+IMAGEMAP_TEST(imagemap_test_read_oob, UTF_DM);
 
 /*
  * Test: block-addressed backend (bl_len > 1) still returns/places the
@@ -514,7 +514,7 @@ static int imagemap_test_blocklen(struct unit_test_state *uts)
 	return 0;
 }
 
-IMAGEMAP_TEST(imagemap_test_blocklen, 0);
+IMAGEMAP_TEST(imagemap_test_blocklen, UTF_DM);
 
 #if CONFIG_IS_ENABLED(MTD_BLOCK)
 /*
@@ -571,7 +571,8 @@ static int imagemap_test_mtd_blk(struct unit_test_state *uts)
 
 	return 0;
 }
-IMAGEMAP_TEST(imagemap_test_mtd_blk, 0);
+
+IMAGEMAP_TEST(imagemap_test_mtd_blk, UTF_DM | UTF_SCAN_FDT | UTF_LIVE_TREE);
 #endif /* MTD_BLOCK */
 
 #if CONFIG_IS_ENABLED(MTD_UBI) && CONFIG_IS_ENABLED(UBI_BLOCK)
@@ -649,5 +650,6 @@ static int imagemap_test_ubiblock(struct unit_test_state *uts)
 
 	return 0;
 }
-IMAGEMAP_TEST(imagemap_test_ubiblock, 0);
+
+IMAGEMAP_TEST(imagemap_test_ubiblock, UTF_DM | UTF_SCAN_FDT | UTF_LIVE_TREE);
 #endif /* MTD_UBI && UBI_BLOCK */
-- 
2.55.0
