Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0C6D2127B
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 08:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 777B4891B1;
	Fri, 18 Oct 2024 10:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="cqs9LsXg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lOLy8abM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B772D8912B; Fri, 18 Oct 2024 10:30:16 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C81B89175
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=b.spranger@linutronix.de
From: Benedikt Spranger <b.spranger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1729240213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJiCOWtBkiXxNucm8mSAf3ZuS/cjqvgO9lUGRM5luP4=;
 b=cqs9LsXgjFGVvBVg0g1vvWrc6sL6mONVmPMqcEgelheUEqKzONRhbT2F6sRUUpsT/lEfj9
 jbifguok/8WHZ+OxEV8A/7esfZrZaM20JIUTgFUfRD04jp78g8Jz5gsA/2N7pBkhF9O87B
 SEC8ZxZvDFpJ51BAwndYJ40+xNkTgzWCP05+jhv3ScOHZELx8GZcJ+eBUegMOLv/Tb1Gcn
 LE2SHkVgaffXQamsRsjDn2y6m1jNj5JmX7IW3yR4Wsi80EbVcejmhXOsuH5K/lOMiWapA+
 IINU9fIHiyvDIePjl0aszefo0b/w6i/OLtH3CFSwVotrAS3+J6+I5UmvIrxbYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1729240213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJiCOWtBkiXxNucm8mSAf3ZuS/cjqvgO9lUGRM5luP4=;
 b=lOLy8abMcBpUcFbiLqglBpVUyLrjdTs66aXlDtJ3rzeEqfqQR81kE9DIDawmo6h1eGwDHt
 FFBnr5bQcSzdOyCQ==
To: u-boot@lists.denx.de
Cc: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 2/5] drivers/mtd/ubispl/ubispl.c: Fix error message
Date: Fri, 18 Oct 2024 10:30:03 +0200
Message-ID: <20241018083006.10349-4-b.spranger@linutronix.de>
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

The bad CRC error message has transposed characters, which render the
output useless:

"bad CRC at record 213: #08x, not #08x" instead of
"bad CRC at record 213: #00000000, not #4be31f4d"

Fix the error message.

Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/mtd/ubispl/ubispl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubispl/ubispl.c b/drivers/mtd/ubispl/ubispl.c
index 90a7c4c6f9e..9face5fae15 100644
--- a/drivers/mtd/ubispl/ubispl.c
+++ b/drivers/mtd/ubispl/ubispl.c
@@ -113,7 +113,7 @@ static int vtbl_check(struct ubi_scan_info *ubi,
 
 		crc = crc32(UBI_CRC32_INIT, &vtbl[i], UBI_VTBL_RECORD_SIZE_CRC);
 		if (be32_to_cpu(vtbl[i].crc) != crc) {
-			ubi_err("bad CRC at record %u: %#08x, not %#08x",
+			ubi_err("bad CRC at record %u: #%08x, not #%08x",
 				i, crc, be32_to_cpu(vtbl[i].crc));
 			ubi_dump_vtbl_record(&vtbl[i], i);
 			return 1;
-- 
2.45.2

