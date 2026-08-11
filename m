Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63F5C5CFC1
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 23:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08E99407EE;
	Tue, 11 Aug 2026 23:17:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QlHT9f3j3TQ5; Tue, 11 Aug 2026 23:17:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F03F7407C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786490232;
	bh=b/qG3LuRslkOD8EvPcXQW+ILYg6sVkUjJybDvh8xHjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FeacyHtH7uw7AGYQOb3hrHeEXkyKzHsQck8031zks923YhA1toP69nKJL6R2dBfH/
	 tPeTq9WvhpYIHLYndL0Gsj9/QX8S+bNdBnUWuuUAOfc4i+EnfJ9K/RMQVpz1EYzFlm
	 tgIE3nPL7klAW3hlhk4BrdGgwZjvKU/VLS95wKUwfdn1uv+kNZ0HPqtjDG6WpDaB4Z
	 ygNWuYvnJ0bhdQO2D/SgoQrbMKYFgcXZJRV8zvjkZoBechrS87+qSvgCSip0x+qQZu
	 9ZPaSOjmj3VhTLLyLTprOafIoz+KdGgkUzf5vqm4hKUi+5rLTOuk5WmXu8rWxNhCAy
	 rNea7UMmg8pLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F03F7407C4;
	Tue, 11 Aug 2026 23:17:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 949B328A
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 23:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86E5581193
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 23:17:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9k7XBSyp_udk for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 23:17:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=7f0c=gf=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7A7148112C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A7148112C
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A7148112C
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 23:17:08 +0000 (UTC)
X-Forward-Email-ID: 6a7bad71a067a7a17f1bb5a3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
Subject: [PATCH v2 2/3] lmb: Return -EFAULT when freeing unallocated memory
 regions
Date: Tue, 11 Aug 2026 23:16:48 +0000
Message-ID: <20260811231650.3150771-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811231650.3150771-1-jonas@kwiboo.se>
References: <20260811231650.3150771-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1786490227; bh=b/qG3LuRslkOD8EvPcXQW+ILYg6sVkUjJybDvh8xHjo=;
 b=Sbn8I9JNbP2OZa6dfhiap8Dj+YN+xpHCetVfFxt0EJqZK21u0l22uM9s1Cduu5gx64Y2aNNzr
 BzV25Kmc31w+fj0Jz5yIn7LDkZja2C0pabOyzrg0ipciH8dvc3uDPSMFqZiQEttzikQuawApNti
 tSPp1SY+75PPhzNnjtR1rIzOGuMEpqHMYnzPY4thjBLeaYRNUepgxlLeEmTsLxhOtcbnQnpeMqD
 NKBvl3fDbb7Q6UjuQn+AQtbuoyfi6yn03S31uXL0nFFKUtyLz0wq4GR+YWSa+b8ibIKlTaXeHje
 VejWbw3T3AiznlXwb2bGUmnC0p4u3Gnoq57G3nbc/8aw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Sbn8I9JN
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

Make lmb_free() return -EFAULT when the requested memory region is not
allocated, instead of the generic -1 error value.

Document the updated error code in the public API comment and change the
LMB unit test to check for the new -EFAULT errno value.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 include/lmb.h  | 2 ++
 lib/lmb.c      | 2 +-
 test/lib/lmb.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 028dabb19e86..157a24baf978 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -168,6 +168,8 @@ int lmb_is_reserved_flags(phys_addr_t addr, int flags);
  * @flags: Memory region attributes
  *
  * Return: 0 on success, negative error code on failure.
+ *
+ * The return value can be -EFAULT when the region has not been allocated.
  */
 long lmb_free(phys_addr_t base, phys_size_t size, u32 flags);
 
diff --git a/lib/lmb.c b/lib/lmb.c
index f7c2e826d067..ca00047f6242 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -286,7 +286,7 @@ static long _lmb_free(struct alist *lmb_rgn_lst, phys_addr_t base,
 
 	/* Didn't find the region */
 	if (i == lmb_rgn_lst->count)
-		return -1;
+		return -EFAULT;
 
 	/* Check to see if we are removing entire region */
 	if (rgnbegin == base && rgnend == end) {
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index b93b903f99f9..168c66ae6499 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -477,7 +477,7 @@ static int lib_test_lmb_at_0(struct unit_test_state *uts)
 		   0, 0, 0, 0);
 	/* check that this was an error by freeing b */
 	ret = lmb_free(b, 4, LMB_NONE);
-	ut_asserteq(ret, -1);
+	ut_asserteq(ret, -EFAULT);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a, ram_size - 4,
 		   0, 0, 0, 0);
 
-- 
2.55.0

