Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3292FEA801
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 03:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 009B18352B;
	Wed, 25 Mar 2026 04:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="j6BRYRTE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hKzn7mQH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB9D183CE3; Wed, 25 Mar 2026 04:17:55 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F5481E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 04:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fgXCh6Y8lz9tth;
 Wed, 25 Mar 2026 04:17:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774408672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/Ytvmdv5PRqOC9Da4OUQH/n9C1GMXzDDsUfJGrTftKQ=;
 b=j6BRYRTE8lKhSBRJ8b34Nen3QyWLK2ErKnpMwvI2ZaY8z8qCCMaSwgk7DwUr9QceQnYzmj
 CQs0dNCo67zShkDXUyL8ATH6p4kqsw7jij3ap0v+2FyHdWhSWbmyy0cq1GZp1LmSQcYmrz
 8fNges5PX6V8s90pzoq6ZabtqcEGmbjZ0N1LGidLv0FT8Fg6Q+vvcUn7ztRcLN1JpP9X1z
 0b+HE0nZ8p4inVTiGeWbecTPu34Pec2ANHBGqKCMevYR9QRKq5QMpY9NvYYD/bkKstHbRd
 QgfGZMa+MtugWmSSqj9DAlGe41MRfV3QI4d+7vMfIMdvSqa8pUcOeo8rTrQfzA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=hKzn7mQH;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774408671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/Ytvmdv5PRqOC9Da4OUQH/n9C1GMXzDDsUfJGrTftKQ=;
 b=hKzn7mQH8ehdPqz0JDBPBo7/nAyp3c1FBCWSqkbP0+G2j0NZafS7Ia8A4qydPZR4vt/uba
 2Dt4wkQ2yv3lVj89RcgKPkd3gfsprqnY5560DiQrQvoJGVwhCPiWWkKttTRWLGlfHqiLXh
 n9K8ZisIn2GieWxNkknaYJqYootiZJNMZUvHzoeLKAWsqpCD3bmCCrCyGtXgiXwMQtRdq5
 4RGnayozCDqRi9byGZ/8YEDE02wofOJn2UKEYKQNKJrlsuheH8viVd+cWKvPaik5Qj/eUg
 p6mKhl4MZb2DGtCgjsyVM4fFGR8a72sYMuZMeCWWaKlCjQFQ2bEhuDIO6Z4LQw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Raymond Mao <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC][PATCH 1/3] fdtdec: Deduplicate iterator function
Date: Wed, 25 Mar 2026 04:17:04 +0100
Message-ID: <20260325031743.371728-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 247c217c94a959497e6
X-MBO-RS-META: wu81gi5ywtn1hb5zwmdhwzqdmguokjzx
X-Rspamd-Queue-Id: 4fgXCh6Y8lz9tth
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

Both fdtdec_setup_memory_banksize() and fdtdec_setup_mem_size_base_lowest()
implement the exact same iterator over all memory banks, the only difference
is the body that is executed for each bank. Deduplicate the functionality
into iterator function fdtdec_setup_mem_for_each_bank(), which takes a
function pointer to a function which implements the body as a parameter.
No functional change.

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
 lib/fdtdec.c | 77 ++++++++++++++++++++--------------------------------
 1 file changed, 30 insertions(+), 47 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c38738b48c7..d820f75b031 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1092,7 +1092,7 @@ ofnode get_next_memory_node(ofnode mem)
 	return mem;
 }
 
-int fdtdec_setup_memory_banksize(void)
+static int fdtdec_setup_mem_for_each_bank(void (*bankfn)(struct resource *res, int bank))
 {
 	int bank, ret, reg = 0;
 	struct resource res;
@@ -1120,63 +1120,46 @@ int fdtdec_setup_memory_banksize(void)
 		if (ret != 0)
 			return -EINVAL;
 
-		gd->bd->bi_dram[bank].start = (phys_addr_t)res.start;
-		gd->bd->bi_dram[bank].size =
-			(phys_size_t)(res.end - res.start + 1);
-
-		debug("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx\n",
-		      __func__, bank,
-		      (unsigned long long)gd->bd->bi_dram[bank].start,
-		      (unsigned long long)gd->bd->bi_dram[bank].size);
+		bankfn(&res, bank);
 	}
 
 	return 0;
 }
 
-int fdtdec_setup_mem_size_base_lowest(void)
+static void fdtdec_setup_memory_banksize_bankfn(struct resource *res, int bank)
 {
-	int bank, ret, reg = 0;
-	struct resource res;
-	unsigned long base;
-	phys_size_t size;
-	ofnode mem = ofnode_null();
+	gd->bd->bi_dram[bank].start = (phys_addr_t)res->start;
+	gd->bd->bi_dram[bank].size = (phys_size_t)(res->end - res->start + 1);
 
-	gd->ram_base = (unsigned long)~0;
-
-	mem = get_next_memory_node(mem);
-	if (!ofnode_valid(mem)) {
-		debug("%s: Missing /memory node\n", __func__);
-		return -EINVAL;
-	}
-
-	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		ret = ofnode_read_resource(mem, reg++, &res);
-		if (ret < 0) {
-			reg = 0;
-			mem = get_next_memory_node(mem);
-			if (!ofnode_valid(mem))
-				break;
-
-			ret = ofnode_read_resource(mem, reg++, &res);
-			if (ret < 0)
-				break;
-		}
-
-		if (ret != 0)
-			return -EINVAL;
+	debug("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx\n",
+	      __func__, bank,
+	      (unsigned long long)gd->bd->bi_dram[bank].start,
+	      (unsigned long long)gd->bd->bi_dram[bank].size);
+}
 
-		base = (unsigned long)res.start;
-		size = (phys_size_t)(res.end - res.start + 1);
+int fdtdec_setup_memory_banksize(void)
+{
+	return fdtdec_setup_mem_for_each_bank(fdtdec_setup_memory_banksize_bankfn);
+}
 
-		if (gd->ram_base > base && size) {
-			gd->ram_base = base;
-			gd->ram_size = size;
-			debug("%s: Initial DRAM base %lx size %lx\n",
-			      __func__, base, (unsigned long)size);
-		}
+static void fdtdec_setup_mem_size_base_lowest_bankfn(struct resource *res, int bank)
+{
+	unsigned long base = (unsigned long)res->start;
+	phys_size_t size = (phys_size_t)(res->end - res->start + 1);
+
+	if (gd->ram_base > base && size) {
+		gd->ram_base = base;
+		gd->ram_size = size;
+		debug("%s: Initial DRAM base %lx size %lx\n",
+		      __func__, base, (unsigned long)size);
 	}
+}
 
-	return 0;
+int fdtdec_setup_mem_size_base_lowest(void)
+{
+	gd->ram_base = (unsigned long)~0;
+
+	return fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_size_base_lowest_bankfn);
 }
 
 static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
-- 
2.53.0

