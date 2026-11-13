Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454DB606A889
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Fd3ELJ1q
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06D2C6063E;
	Fri, 13 Nov 2026 23:57:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4orOWF5QksfD; Fri, 13 Nov 2026 23:57:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 12390606D0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794614257;
	b=lZnGaoAjqs6VhcnvB5OYqQBv6xEXD6849Iizyoh240zYtg0xMaKEJ1wweNVubVKAmlDb
	 gFEXU/qmfsaVrlP6JndyvzqctQ3mNBW+dmawqkufKt7E7TICMAXNgSA40Ymv7+0IB6DHY
	 Dt3MVKnn7nXVYmHECyyO8Snyz+cEf0yoCy+0BgfeIvP2QzqaS0Yqjaa9oa9/+g2G7BluJ
	 rfBmpfpogd/0czyokcvBN2hDE9l4J5zHw3XbEJu7+X+gcBYwO5ukum/X95Bbe9qmfttzf
	 ntemsDZF9DBXDZ3GVt+N5SP9BZaSfKjbxUNdyu8M3gXcxzxGnAi3Ioo13fnD1wfJGhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794614257;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=O9nTq0IbmyhVqCGn3f0bvYS0COdbOu/v3hvN0JKL27A=;
	b=Oamwaay+65BVqwB4IfFcprTv2e7xIIEUX8u9AVC8Jsyab1TG7jrSi+Q4GJk+kBeUAkOr
	 MY8Um0W+NRXtNlMhR59BWRKEWHbZ/aiEQ+5Z2WVHaHBJ94alTtLOwrLnziiZbShFic2pg
	 2FclAHPaXgCwHTedHbNycuf6XdESbSOT+lmgrqFfr7mQg917drguDoJ7JR1P4UsmV+S8h
	 n/Y/ge402necW+NS5gLzVh4nvjYG1x1t/VfbGGuoC9uMFLP60FwXzjcLMqhxZuBF50jFc
	 +rgHAkQ8qY21PxDVtRnIlTimEbUnaOHNy6kGZXqQqkg5snOcF6jR7ghaj0i+rYrIEQQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794614257;
	bh=O9nTq0IbmyhVqCGn3f0bvYS0COdbOu/v3hvN0JKL27A=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Fd3ELJ1qeWHczQVM2s1XvZEHVKaPthYGzGSpS9/NaRBDPjcPA93VCvTEgggKN4UuP
	 5ZU1LlDftDwlBIBc5bqYYf/XYDBIYo+2MAfA70X1JVuCnc1Jvj2qITpeNHDw/Z6dX7
	 xjFgzgPidXhCzTViWWipsvN7X1TkNyNlu9lKF7A5B8XPySLc5vxfLJRaw2VfZYyRQ+
	 dFtS+H7ogvo6GLIIEvcVVpqP267v9Ymo6aYf3gs9FmmT9TdNseVBaxs466iDDUAVty
	 APaMqK8g6Kt3bwupArPQdh05tOggE2+LoyfqX8peyIpzppLhSWqPnSMrSm5tD3fS28
	 zLdAeqZ1cIDCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12390606D0;
	Fri, 13 Nov 2026 23:57:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E97D28C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 23:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B55B40E96
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 23:57:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9SvXGko5u5SZ for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 23:57:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B8D4D40E95
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8D4D40E95
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 23:57:33 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xS193-000000008MS-1RYI;
 Fri, 13 Nov 2026 23:57:25 +0000
Date: Fri, 13 Nov 2026 23:57:22 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Randolph Sapp <rs@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kumar Gala <galak@kernel.crashing.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] lmb: Check available space below the allocation limit
Message-ID: <b33d1c37d001192a911db58dbadc5f7223051a7d.1794614217.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A limited allocation checks the full bank size before applying its
upper address limit. If the remaining range is smaller than the request,
subtracting the size can underflow and reserve memory outside RAM.
Check the available range before calculating the candidate address.

Fixes: 4ed6552f7159 ("[new uImage] Introduce lmb from linux kernel for memory mgmt of boot images")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 lib/lmb.c      |  2 ++
 test/lib/lmb.c | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/lib/lmb.c b/lib/lmb.c
index ca00047f624..8067f184f44 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -698,6 +698,8 @@ static int _lmb_alloc_base(phys_size_t size, ulong align,
 			if (base < lmbbase)
 				base = -1;
 			base = min(base, max_addr);
+			if (base - lmbbase < size)
+				continue;
 			base = ALIGN_DOWN(base - size, align);
 		} else {
 			continue;
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 168c66ae649..a69a915c06f 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -12,6 +12,7 @@
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
+#include <linux/sizes.h>
 
 static inline bool lmb_is_nomap(struct lmb_region *m)
 {
@@ -491,6 +492,30 @@ static int lib_test_lmb_at_0(struct unit_test_state *uts)
 }
 LIB_TEST(lib_test_lmb_at_0, 0);
 
+static int lib_test_lmb_alloc_max_underflow(struct unit_test_state *uts)
+{
+	struct alist *mem_lst, *used_lst;
+	phys_addr_t addr = SZ_4K;
+	struct lmb store;
+	int ret, count;
+
+	ut_assertok(setup_lmb_test(uts, &store, &mem_lst, &used_lst));
+	ut_assertok(lmb_add(0, SZ_1M));
+
+	ret = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, SZ_4K, &addr, SZ_8K,
+			    LMB_NONE);
+	count = used_lst->count;
+	lmb_pop(&store);
+
+	ut_assert(ret < 0);
+	ut_asserteq(SZ_4K, addr);
+	ut_asserteq(0, count);
+
+	return 0;
+}
+
+LIB_TEST(lib_test_lmb_alloc_max_underflow, 0);
+
 /* Check that calling lmb_reserve with overlapping regions fails. */
 static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
 {
-- 
2.56.0
