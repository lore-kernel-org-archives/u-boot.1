Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0F3EE14C3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EB8386AA3;
	Wed,  6 Sep 2023 23:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jTOkIePB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IWhbsQFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55CB586A81; Wed,  6 Sep 2023 23:30:59 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB74A86A54
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RgwXc65G5z9sW6;
 Wed,  6 Sep 2023 23:30:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z9JbK8sw11zwbpCR0Hvklum/d9/Cujs/ilblRL3yyZc=;
 b=jTOkIePB1DaPn3ul7YkCjoRVE/7kBOnEKG3c+iLf+8C7sK61yg6OJV6OheV0lAjO3e9mIM
 9uzfXwsUcFtHq+1KTJfCU62YyHSEJMV9yihQEJ/M2y28ohSP7/zKmddR+pLI9Rx5YhZhQL
 Aq3vt1OPQGYMdBUEJFr4oCZRE+OrqAsDDIswB77OE3kW3VX8GGnouePv5mOV0r1pcnA3Rk
 b79RP9HwjHnsWhW6c1Gm9D4DLU8mbnTYIg7LhE6pqlBs+2n/NVssGUEZavX4tdyxmwVNdd
 vC/lCqKjwT5fa+pRsxHZFg+4YcjEXlByv/hZTxXlp8YRopYSDVZ1HbUy47pdtQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z9JbK8sw11zwbpCR0Hvklum/d9/Cujs/ilblRL3yyZc=;
 b=IWhbsQFMPatyuiWAcms5v7HLk1nicaBL44ZK/IXosz7DvNbtixbnmjW9sY46SZbqZWBumW
 YpMqUOaxkRA5ZlmAJ0GScLmmYI3vheSf8qF09AQP830IsxT3xKU12BfrL/WTIOR9Vd0NA1
 ZciKKOHjzSwyKl1TRTQeYzUSIwa8jbDHzF/eXrqY8GKKO69ZuA0PyaOeShvMwOdnNVBVV8
 lNS38YWNMRtOSrAR8Q1oi0TUPLog18bfp/SKZWUgUzj24stN5TBQKrMlMAEikTbvpw46Tb
 hfRyrMl1t62FMy6V5OM5UvtrD3KuHuiZte7F176hEGm55272P+lDmDcUyEqjcw==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 26/35] mtd: ubifs: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:30:06 +0200
Message-Id: <20230906213015.203437-27-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jdiwpptkgimjm9xey3h7yuh8h9cpgqbm
X-MBO-RS-ID: 2681a2f1062f3183079
X-Rspamd-Queue-Id: 4RgwXc65G5z9sW6
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 fs/ubifs/ubifs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index 609bdbf6037..a509584e5d7 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -201,12 +201,6 @@ static int __init compr_init(struct ubifs_compressor *compr)
 {
 	ubifs_compressors[compr->compr_type] = compr;
 
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-	ubifs_compressors[compr->compr_type]->name += gd->reloc_off;
-	ubifs_compressors[compr->compr_type]->capi_name += gd->reloc_off;
-	ubifs_compressors[compr->compr_type]->decompress += gd->reloc_off;
-#endif
-
 	if (compr->capi_name) {
 		compr->cc = crypto_alloc_comp(compr->capi_name, 0, 0);
 		if (IS_ERR(compr->cc)) {
-- 
2.40.1

