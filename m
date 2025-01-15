Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640A2C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 16:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 501CB80703;
	Wed, 15 Jan 2025 17:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="PzarkSEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18AD48070C; Wed, 15 Jan 2025 17:16:34 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13BDB80702
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 627591484F28; Wed, 15 Jan 2025 17:16:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1736957791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRTs5bKpep05f3vISOujOha2rogiYmIkw1uw9nmJHbQ=;
 b=PzarkSEtXfqHhYWr/z5JMFtNJlgMTJcSDbvS7WR0zIThIoNfAZJdcP3z7EQXstsU8SxUN4
 EOwfntWYU6K58obajIQ58+sBJLxr9Bs4wO42yAYCqPdv81WBqamNS/i92BfgqpBkAJTBPD
 oB0hNXsWmbQkxHyG0GHFWWoxD6iWsD46K8w5AsJc9TeopGT0P2rSaghrtcASPzkiSdnym8
 wL3mL/V7u+2MVdBtrrHO1V4Bcw9YO4cCpjnFnc7ovs1j1GFUbuTVo2DSJUatnhYdeHvZS+
 yhbhoJz/8oiGzy2B/tKBZsFvuj+U6UDQ8jgk3SxtbkyGjOVduIOd7+6GHwYE9g==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Mathew McBride <matt@traverse.com.au>, Pratyush Yadav <p.yadav@ti.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 2/2] Revert "mem: spi-mem: add declaration for
 spi_mem_default_supports_op"
Date: Wed, 15 Jan 2025 17:16:21 +0100
Message-Id: <20250115161621.1551826-3-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250115161621.1551826-1-ada@thorsis.com>
References: <20250115161621.1551826-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

We have a duplicate declaration of spi_mem_default_supports_op() which
was added twice, first with commit af6266c1c27a ("mem: spi-mem: add
declaration for spi_mem_default_supports_op") for v2021.04, and again
with commit 2299076e34f8 ("spi: spi-mem: export
spi_mem_default_supports_op()") for v2021.07.

The first commit is reverted here, because the second better matches the
definition and has a better place in the declaration order.

Note: Linux declares this in a different section of spi-mem.h which is
disabled in U-Boot through `#ifndef __UBOOT__`.

This reverts commit af6266c1c27add8beac7f3365c00b3525a9012c4.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Cc: Mathew McBride <matt@traverse.com.au>
Cc: Pratyush Yadav <p.yadav@ti.com>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>

 include/spi-mem.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/spi-mem.h b/include/spi-mem.h
index 3c8e95b6f53..2eb05a2e5bc 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -329,9 +329,6 @@ bool spi_mem_default_supports_op(struct spi_slave *slave,
 
 int spi_mem_exec_op(struct spi_slave *slave, const struct spi_mem_op *op);
 
-bool spi_mem_default_supports_op(struct spi_slave *mem,
-				 const struct spi_mem_op *op);
-
 struct spi_mem_dirmap_desc *
 spi_mem_dirmap_create(struct spi_slave *mem,
 		      const struct spi_mem_dirmap_info *info);
-- 
2.39.5

