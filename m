Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18665C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 22:06:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9348A84A77;
	Thu,  9 Jul 2026 00:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ynGG4BUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EB3E84A4B; Thu,  9 Jul 2026 00:05:55 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C9F184A7A
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 00:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=747f=FD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783548351; bh=tl7in3FtNi+LCIWtDCNkv51x+JATNB9m0+V7Ul6iRnA=;
 b=ynGG4BUNwrnZUew8pFhc1R20gBq0wOYFgV2D7zF+Nf2WRI3NcdH9a9EQ3uGoi9GtQVZhtN5kx
 9PRLWcvHm1FBUyaGkq7XsM4fZ7t5cBWiKjjYqeHOxAnhxD/n/hvRWNtea/3kVlDnH/DC2hQCZ00
 K+2BtIB09Go8w+BD813zl11FoKyb7n3CTO87L1NeZstOE4KlNrKeRPzsVb3LHnM4CvLgiXirpfA
 Q+Hdhvs/Fg/TT6ch9v2670NYYznXgGJ+2eupj55daohrNfz0Z3ll45LFHakhtoIuYkQ2YeAiQnJ
 OWyTdVQp5QQbvisGkjEVbkV/95t0G3Jg7FdO41LSanYg==
X-Forward-Email-ID: 6a4ec9be2402b3ca75f9041b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 02/11] dm: core: Drop redundant CONFIG_TPL_BUILD check
Date: Wed,  8 Jul 2026 22:05:28 +0000
Message-ID: <20260708220540.3368825-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708220540.3368825-1-jonas@kwiboo.se>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The XPL_BUILD symbol is set for all xPL phases, i.e. TPL, VPL and SPL.
Conditional guards that test for both XPL_BUILD and TPL_BUILD symbols
are therefore redundant.

Drop the redundant TPL_BUILD symbol check from conditional guards that
also test for the XPL_BUILD symbol to cleanup from an old SPL to XPL
symbol rename.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/core/ofnode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 1388b4810317..75cae0d36b5b 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1665,8 +1665,8 @@ int ofnode_read_simple_size_cells(ofnode node)
 
 bool ofnode_pre_reloc(ofnode node)
 {
-#if defined(CONFIG_XPL_BUILD) || defined(CONFIG_TPL_BUILD)
-	/* for SPL and TPL the remaining nodes after the fdtgrep 1st pass
+#if defined(CONFIG_XPL_BUILD)
+	/* for xPL the remaining nodes after the fdtgrep 1st pass
 	 * had property bootph-all or bootph-pre-sram/bootph-pre-ram.
 	 * They are removed in final dtb (fdtgrep 2nd pass)
 	 */
-- 
2.54.0

