Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02946D2F7E1
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 08:31:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A202A892BA;
	Fri, 18 Oct 2024 10:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="HwG9Kapo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cPZfPd1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E805489139; Fri, 18 Oct 2024 10:30:16 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C6F891B1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=b.spranger@linutronix.de
From: Benedikt Spranger <b.spranger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1729240214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cCys+O2znfk6e5uG9AXqfiMXZZC7eRfgGV0184xo2BQ=;
 b=HwG9KapotXLTatEOqHlf04Xg5jNWVXBEQt3mQS53puOI3a+14rpHAbH8P4ZTtgyQFLcP8F
 Y4aSjv+RiVkeGJPQdF84FOnUBsndz1Uo4CLI+elRwD2I6RbWRsAvv4Pk/3MNfXPlE0Dtre
 v7lOaiSsdKIm703qzVHqETnszOYI1Hl/0pzAWkh4G1gwPjZHrQ6Y8SCUl4430lJMFr4a4n
 W4kM+2bHwYX1Zs2dFk3sLU2wmkOGM1UyRiIQdgCjdfQ5kome8KPDHIlTUnfGFAZZzhnyiZ
 rTjCbd4Hb6bp2hddFQOOUxVbxpjITC61IHujlaSnFJRNj+DgYJNO9oFglXGSZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1729240214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cCys+O2znfk6e5uG9AXqfiMXZZC7eRfgGV0184xo2BQ=;
 b=cPZfPd1vQUxwxsixd4m7VnqZFhUb0ZisZFJ6gya+eVk2KV8nRqWvDSQFFTALDpFbpnUhFy
 rq9bLadwNk/NngCg==
To: u-boot@lists.denx.de
Cc: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 5/5] mtd: nand: raw: atmel_nand: Add missing nand_scan_ident()
Date: Fri, 18 Oct 2024 10:30:06 +0200
Message-ID: <20241018083006.10349-7-b.spranger@linutronix.de>
In-Reply-To: <20241018083006.10349-1-b.spranger@linutronix.de>
References: <20241018083006.10349-1-b.spranger@linutronix.de>
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

In board_nand_init() the used NAND flash is not evaluated. This left
vital parts of internal structures uninitialized and SPL NAND flash
access is broken.

Add the missing nand_scan_ident() to board_nand_init().

Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/mtd/nand/raw/atmel_nand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/atmel_nand.c b/drivers/mtd/nand/raw/atmel_nand.c
index 4dbf7b47135..cf7ac54ea13 100644
--- a/drivers/mtd/nand/raw/atmel_nand.c
+++ b/drivers/mtd/nand/raw/atmel_nand.c
@@ -1423,6 +1423,10 @@ int board_nand_init(struct nand_chip *nand)
 	nand->bbt_options |= NAND_BBT_USE_FLASH;
 #endif
 
+	ret = nand_scan_ident(mtd, CONFIG_SYS_NAND_MAX_CHIPS, NULL);
+	if (ret)
+		return ret;
+
 #ifdef CONFIG_ATMEL_NAND_HWECC
 #ifdef CONFIG_ATMEL_NAND_HW_PMECC
 	ret = atmel_pmecc_nand_init_params(nand, mtd);
-- 
2.45.2

