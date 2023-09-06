Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927FAEE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E33186A31;
	Wed,  6 Sep 2023 23:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jbirUShl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CE1xkVOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF68786A5D; Wed,  6 Sep 2023 23:31:03 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 540B386A94
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RgwXh0t44z9sjN;
 Wed,  6 Sep 2023 23:31:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZcdExdQ+kMmX2M3dUEeP7uYM42JDoUwCyebdhWdtok=;
 b=jbirUShlkkz+VoP0SJT8D+/KI5AG7yc+oVMoFp4sAdwgAKnGeSrI8++m75+sWLnAop9KAF
 w8fxy6DJTTVV2vKXktMqG5XVZkXpGdZ+Lyt2SsGT66Xf7un2XGeHWzIuENFkVoQqxjv9bt
 Pp8KvZiS46LVkvRISw3/yKfxpp/+x3O1WM5zbuJDBk3cQxaz/ztxV8SCn5qCP1w/XnlI6L
 WrBGlx/bMwxGe33BBuUNoySYxSAK9uTxrJUlaeK2IwazhgKNlAlVdgxyWmteXRSer5AVmF
 aJjC/t5nFgl0Ijn+sV/lTTA5AG7CKelMVq000I7iyFGkM95M4Lw1UXLSStCgjQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZcdExdQ+kMmX2M3dUEeP7uYM42JDoUwCyebdhWdtok=;
 b=CE1xkVOsIGL76XqzwJ1X4guP9iBUG6eqB4GLyklGoF+mA8MKrWMsx7jtMTPJQlxhIKh2qD
 NFrbX6pd4RYrnlAhk7b7EoWiYfeAMuHRMD4RmG1Qgsglmnn9EJbCGG/iBLXew6T4Ta+cLj
 DeTutPJhYDqzxFM8sUZmTlXaWQpyqaMd+3ozLr2SRZ7Lc3EbePfc0q1lY1os9zi2L2ug5O
 971FH1Uxvn+ni//NN+DTlmrd8bf+YarA8coRWl7EljbYgAJfyHKS4QJzcXSACyQOyv/qtY
 crjKGFz3CJF3UBIKmr6akQYxQl1mUzs8UdSsnSSRPSSUmQ5jcSDNbK2BQ1CTrw==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 31/35] spi: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:30:11 +0200
Message-Id: <20230906213015.203437-32-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4a5ba65750c0842085e
X-MBO-RS-META: 8symzb4abozu4xwrhxn4izg3c5yisgef
X-Rspamd-Queue-Id: 4RgwXh0t44z9sjN
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
 drivers/spi/spi-uclass.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index c929e7c1d0e..f4795e68672 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -196,38 +196,6 @@ static int spi_post_probe(struct udevice *bus)
 
 		spi->max_hz = dev_read_u32_default(bus, "spi-max-frequency", 0);
 	}
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-	struct dm_spi_ops *ops = spi_get_ops(bus);
-	static int reloc_done;
-
-	if (!reloc_done) {
-		if (ops->claim_bus)
-			ops->claim_bus += gd->reloc_off;
-		if (ops->release_bus)
-			ops->release_bus += gd->reloc_off;
-		if (ops->set_wordlen)
-			ops->set_wordlen += gd->reloc_off;
-		if (ops->xfer)
-			ops->xfer += gd->reloc_off;
-		if (ops->set_speed)
-			ops->set_speed += gd->reloc_off;
-		if (ops->set_mode)
-			ops->set_mode += gd->reloc_off;
-		if (ops->cs_info)
-			ops->cs_info += gd->reloc_off;
-		if (ops->mem_ops) {
-			struct spi_controller_mem_ops *mem_ops =
-				(struct spi_controller_mem_ops *)ops->mem_ops;
-			if (mem_ops->adjust_op_size)
-				mem_ops->adjust_op_size += gd->reloc_off;
-			if (mem_ops->supports_op)
-				mem_ops->supports_op += gd->reloc_off;
-			if (mem_ops->exec_op)
-				mem_ops->exec_op += gd->reloc_off;
-		}
-		reloc_done++;
-	}
-#endif
 
 	return 0;
 }
-- 
2.40.1

