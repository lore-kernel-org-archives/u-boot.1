Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB629C44503
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 22:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 872B184A63;
	Thu,  9 Jul 2026 00:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zeU5dYp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5B4C84AB8; Thu,  9 Jul 2026 00:06:02 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7088584A1F
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 00:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=747f=FD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783548357; bh=clqwjNPZRnATteOsLS+fjOGcuj04GOFlZlUhtrZYliQ=;
 b=zeU5dYp6/NnIA/wW/O60m2x1frIynUm3yVUsOwA8b77yR19LoMqhWr+A4iT/7qaXDkukPrN/q
 0HqBDfVvJ9YqmEhyUJpxq6gRDeMICwWPqk+uvG2bC1TKHtmArJVZdtqLAf0Wq65OSQwtGxLtqiB
 kLM8ZT01jcYB35yqBb3gEgUbxhl+RmGpad70qYRSP4W6aac2/dIPV456r+vkaA8bj/C6uEBUErC
 xUayF3wlYHZNf5T8I6rei8R1k3CrYoHgVa9+W1UgLrqqjkmmbFENUVkulb5/QoBlHb3KGt7ch9t
 UWXGs05sC4e5ybEPC3k/c+5+5AlXv7vELa3dktBA3THA==
X-Forward-Email-ID: 6a4ec9c32402b3ca75f90453
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 04/11] x86: apl: fsp_bindings: Drop redundant CONFIG_TPL_BUILD
 check
Date: Wed,  8 Jul 2026 22:05:30 +0000
Message-ID: <20260708220540.3368825-5-jonas@kwiboo.se>
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
 arch/x86/cpu/apollolake/fsp_bindings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/cpu/apollolake/fsp_bindings.c b/arch/x86/cpu/apollolake/fsp_bindings.c
index b4bb677f5cde..4b85fddbc8ad 100644
--- a/arch/x86/cpu/apollolake/fsp_bindings.c
+++ b/arch/x86/cpu/apollolake/fsp_bindings.c
@@ -653,7 +653,7 @@ int fsp_m_update_config_from_dtb(ofnode node, struct fsp_m_config *cfg)
 }
 #endif
 
-#if !defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 const struct fsp_binding fsp_s_bindings[] = {
 	{
 	.type = FSP_UINT8,
-- 
2.54.0

