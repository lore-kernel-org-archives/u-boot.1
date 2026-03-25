Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B7CFEA802
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 03:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D052783DC9;
	Wed, 25 Mar 2026 04:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Zle3Gvam";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="H8XsQrMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC9EB81E18; Wed, 25 Mar 2026 04:17:56 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6BF8838BB
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 04:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fgXCk2VWhz9skw;
 Wed, 25 Mar 2026 04:17:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774408674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q30R5+wG4ZLaMzEOGSH1x4VZiiWM3yZyNYb3CwYWU9U=;
 b=Zle3GvamyZmatHtyCdA8zqJITl0oT14YpS87DYCMXlpPjoIKAbWfbqVpCmR9Z28itpUR7m
 l0ODYk1eQSOXtdjI8/gN8dRPgz3QSi/4dVhgfZx4YDZmMMhircslWJuRIfA8SXHgsJLBJv
 FZWxsaR4M6zx9spWuA0ZhaL5HmYcASQATWW+L9nxtPA6jKMusQboXHMmlZYNRvjKbI3f+8
 cOXJAwjQwiKU767AKMmN70v3jO+f1FxFz+vO6x5WtUeXGkYMDcm24bS6lpw/gEs/zAjobj
 KDorGmNMMZNP5A542mPVhDinkWSGZRW4Z5dCFGFwO47PAP0n/ziHQoffIUlyGw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=H8XsQrMH;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774408673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q30R5+wG4ZLaMzEOGSH1x4VZiiWM3yZyNYb3CwYWU9U=;
 b=H8XsQrMHfsK7Y6eyzTcXSNp5WtEw3NN+WtXkG5QaL13kPrd8v/qxNvmHy5MpbAX6F3NeY/
 ePscTvrkXcii1nvxMwmGbT6w6ZbvQ3859kJWFC765Wx9LsGE1GHcII2G0L7WDM924VJoye
 mCTljmTFMvVbprL5SgIFjWEVO+kSkZtB1bLLQdcUPSOGf0cL9vV1sNb7fCkyuPSoGICN2D
 zaLAij8ANtovfABYZvZzTYPz7rkbmVjn9kdMkC3aSDvFYN6sAZ4F0N4/2/V9EZHL7mWTCq
 0OOeGu+WQ967EyL8G0a+/CtTLxhk2GhiYJkSWNS64YShMsdzs5PcafRAIJ67PQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Raymond Mao <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC][PATCH 2/3] fdtdec: Introduce fdtdec_setup_mem_ram_top() to
 determine end of topmost DRAM bank
Date: Wed, 25 Mar 2026 04:17:05 +0100
Message-ID: <20260325031743.371728-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260325031743.371728-1-marek.vasut+renesas@mailbox.org>
References: <20260325031743.371728-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dfe040c917e4f810369
X-MBO-RS-META: etd6c9114dwx37734uu1okmgbag4i9pg
X-Rspamd-Queue-Id: 4fgXCk2VWhz9skw
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

Introduce function fdtdec_setup_mem_ram_top(), which determines the topmost
address in the last DRAM bank, to be assigned into gd->ram_top in order to
relocate U-Boot to the actual end of all DRAM. This makes use of iterator
function fdtdec_setup_mem_for_each_bank() introduced in previous commit.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Raymond Mao <raymondmaoca@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 include/fdtdec.h | 16 ++++++++++++++++
 lib/fdtdec.c     | 18 ++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/fdtdec.h b/include/fdtdec.h
index d9fcd037ed2..26e40c3cdb4 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -933,6 +933,22 @@ int fdtdec_setup_mem_size_base(void);
  */
 int fdtdec_setup_mem_size_base_lowest(void);
 
+/**
+ * fdtdec_setup_mem_ram_top() - decode and setup gd->ram_top to highest address
+ * available in any memory bank
+ *
+ * Decode the /memory 'reg' property to determine the highest end of the memory
+ * bank and populate the global data ram_top with it.
+ *
+ * This function should be called from a boards board_get_usable_ram_top().
+ * This helper function allows for boards to query the device tree for topmost
+ * DRAM address.
+ *
+ * Return: 0 if OK, -EINVAL if the /memory node or reg property is missing or
+ * invalid
+ */
+int fdtdec_setup_mem_ram_top(void);
+
 /**
  * fdtdec_setup_memory_banksize() - decode and populate gd->bd->bi_dram
  *
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index d820f75b031..bdb26d8fb75 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1162,6 +1162,24 @@ int fdtdec_setup_mem_size_base_lowest(void)
 	return fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_size_base_lowest_bankfn);
 }
 
+static void fdtdec_setup_mem_ram_top_bankfn(struct resource *res, int bank)
+{
+	if ((res->end + 1) > gd->ram_top)
+		gd->ram_top = res->end + 1;
+}
+
+int fdtdec_setup_mem_ram_top(void)
+{
+	phys_addr_t old_top = gd->ram_top;
+	int ret;
+
+	ret = fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_ram_top_bankfn);
+	if (ret)
+		gd->ram_top = old_top;
+
+	return ret;
+}
+
 static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
 {
 #if CONFIG_IS_ENABLED(MULTI_DTB_FIT_GZIP) ||\
-- 
2.53.0

