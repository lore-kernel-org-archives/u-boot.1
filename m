Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95528C5CFC1
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 23:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AB8A81190;
	Tue, 11 Aug 2026 23:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IeAuXjmVtq4Q; Tue, 11 Aug 2026 23:17:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 860E881192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786490229;
	bh=KBxN+2TKNuvIsV1t7+sNDip6m3EYOYl4HfziP7vjuuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0QO+J4Tn6Id5gucbZp2gZ1XEuRneMNjZhgoFVXst3b1nOKb4ivR23kZPCGhPkL8V7
	 iIbY/mOGxVOV08IyH94huU3dz3wrPEEVJkHhMxEu293F0/2bVO1QLurAr2HmbFAfmJ
	 qiIGTUpy5a4DUe85sHkgTa4h4eJpB53zOACfmZMCLq7CIx2d4IXGHlD7I9bB1v4p/+
	 AMjpooMLkDmT+6HYVX6EA9aySPBp0mVnb6g3Cx7NFIAbGiuw1QoNTuplTfoJa5YRrQ
	 2Vw+HYlwk+bpoAgCn6vqSErGd7RlkqyV39mPa4Zom3voT5wi+ZF791bndBhSThIl+0
	 h9FoWoaRgkH1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 860E881192;
	Tue, 11 Aug 2026 23:17:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C53B3A4
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 23:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42B1181190
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 23:17:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZhTbx4D1S8KR for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 23:17:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=7f0c=gf=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2C7318112C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C7318112C
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C7318112C
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 23:17:06 +0000 (UTC)
X-Forward-Email-ID: 6a7bad6fa067a7a17f1bb579
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>, Randolph Sapp <rs@ti.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Joseph Guo <qijian.guo@nxp.com>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/3] lmb: Return -EFAULT when requested region is not part
 of memory map
Date: Tue, 11 Aug 2026 23:16:47 +0000
Message-ID: <20260811231650.3150771-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811231650.3150771-1-jonas@kwiboo.se>
References: <20260811231650.3150771-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1786490226; bh=KBxN+2TKNuvIsV1t7+sNDip6m3EYOYl4HfziP7vjuuI=;
 b=oV8ZztkTKBBvPt0//jw+BbWmDjx/p7IVhh5nDEZdSxerD5cLDK6Z5WFIuroCB778nSY7Fgmd6
 AuhC6d3hHaZTTaMGTvWqbQGXKujkTe12Ci/YWLTnXn5hDYnXctaIbVmZRdvmH7KgA5hBeqAgi+5
 PE5+gQc6woaXSF/AvsLrWY8JxOQTQl4BFsRUGHyq+JREJGyRSjr2syg2jF2gVlBJkupYijkH9vB
 nT6BzFY7knwOyALKMWWODrSfiwaOtlZHXupKN+XCb28ZEvUnWxVzMh8w9wlbZOEKxBup/qvLi6b
 Cdst0gb1NRLrQ/du/STN/rZfxdgYOLYcLMnHKwvjS2yg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=oV8ZztkT
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

lmb_alloc_addr() is documented to return -EINVAL when the requested
memory region is not part of the LMB memory map. However, -EINVAL is
also used to e.g. indicate that a NULL pointer is passed as the addr
parameter or when the requested memory region partially overlaps an
existing region.

Change lmb_alloc_addr() to return -EFAULT when the requested memory
region is not part of the LMB memory map to make the type of error known
to callers. Also extend unit tests to validate that the return code has
stay the same when the requested memory region partially overlaps.

No caller of lmb_alloc_addr() is checking what type of error code is
returned, so this change has no intended behavior change.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 include/lmb.h  |  2 +-
 lib/lmb.c      |  4 +++-
 test/lib/lmb.c | 10 +++++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index ed472e9ef2e1..028dabb19e86 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -124,7 +124,7 @@ struct lmb {
  * Return: 0 on success, -ve value on failure
  *
  * When the allocation is of type @LMB_MEM_ALLOC_ADDR, the return value can
- * be -EINVAL if the requested memory region is not part of the LMB memory
+ * be -EFAULT if the requested memory region is not part of the LMB memory
  * map, and -EEXIST if the requested region is already allocated.
  */
 int lmb_alloc_mem(enum lmb_mem_type type, u64 align, phys_addr_t *addr,
diff --git a/lib/lmb.c b/lib/lmb.c
index 77440a48486c..f7c2e826d067 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -752,9 +752,11 @@ static int _lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
 				      base + size - 1, 1))
 			/* ok, reserve the memory */
 			return lmb_reserve(base, size, flags);
+
+		return -EINVAL;
 	}
 
-	return -EINVAL;
+	return -EFAULT;
 }
 
 int lmb_alloc_mem(enum lmb_mem_type type, u64 align, phys_addr_t *addr,
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index b6259bef4426..b93b903f99f9 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -779,11 +779,19 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	/* check that allocating outside memory fails */
 	if (ram_end != 0) {
 		ret = lmb_alloc_addr(ram_end, 1, LMB_NONE);
+		ut_asserteq(ret, -EFAULT);
+		ret = lmb_alloc_addr(ram_end - 1, 2, LMB_NOMAP);
+		ut_asserteq(ret, -EINVAL);
+		ret = lmb_alloc_addr(ram_end - 1, 2, LMB_NOOVERWRITE);
 		ut_asserteq(ret, -EINVAL);
 	}
 	if (ram != 0) {
 		ret = lmb_alloc_addr(ram - 1, 1, LMB_NONE);
-		ut_asserteq(ret, -EINVAL);
+		ut_asserteq(ret, -EFAULT);
+		ret = lmb_alloc_addr(ram - 1, 2, LMB_NOMAP);
+		ut_asserteq(ret, -EEXIST);
+		ret = lmb_alloc_addr(ram - 1, 2, LMB_NOOVERWRITE);
+		ut_asserteq(ret, -EEXIST);
 	}
 
 	lmb_pop(&store);
-- 
2.55.0

