Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D75FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E9DE844BD;
	Sat, 25 Apr 2026 20:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="htak67co";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC72F842FD; Sat, 25 Apr 2026 19:01:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BBCAE843E0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 899D135AD;
 Fri, 24 Apr 2026 10:32:52 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.64.144])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E5183F7B4;
 Fri, 24 Apr 2026 10:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777051978; bh=+x5wp1lBslfS6w+D+Ltfg462R3eeWTvGEJtTeAHd7Is=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=htak67coacowwD4/k6Zl6g35bFsXrIdxeT+dhMlgQosineUhvvfhHJBerss1EsCTW
 DNGGlgj+AVR8rnp4n6g27Hgt29dHU0nWO3JoqF/VmeJ3rCrtRY6Tq5Jb+xj9W3PlKX
 P+kQbv0aJ/WD0/P1UvyXyMRemuhruLWgUakt3pj4=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH 12/12] efi_loader: align FF-A cache maintenance with runtime
 path
Date: Fri, 24 Apr 2026 18:31:51 +0100
Message-Id: <20260424173151.371134-13-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

Match boot-time FF-A cache handling to runtime behavior

The boot-time FF-A MM communication path used invalidate_dcache_all()
after copying the message into the shared buffer. This differs from the
runtime path, which performs range-based maintenance to avoid global cache
operations.

Update ffa_mm_communicate() to use the same pattern as the runtime helper:
clean the shared buffer range before the SMC and invalidate the same range
after the response. This keeps boot-time and runtime behavior consistent
and avoids whole-cache invalidation.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 lib/efi_loader/efi_variable_tee.c | 33 ++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 30687c21b8e..df509a435b1 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -389,19 +389,38 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
 	memcpy(virt_shared_buf, comm_buf, tx_data_size);
 
 	/*
-	 * The secure world might have cache disabled for
-	 * the device region used for shared buffer (which is the case for Optee).
-	 * In this case, the secure world reads the data from DRAM.
-	 * Let's flush the cache so the DRAM is updated with the latest data.
+	 * Shared buffer cache maintenance for FF-A / OP-TEE communication:
+	 *
+	 * NS -> S (request path):
+	 *
+	 * The non-secure side populates the shared buffer. If the buffer is cached
+	 * in NS, the updated bytes may reside in dirty D-cache lines and not yet be
+	 * visible in DDR. Since the secure world typically reads the shared buffer
+	 * directly from DDR (e.g. with caches disabled / non-coherent mapping), we
+	 * must clean the corresponding cache lines to the Point of Coherency (PoC)
+	 * before entering secure world.
+	 *
+	 * S -> NS (response path):
+	 *
+	 * The secure world may update the same shared buffer in DDR. After returning
+	 * to non-secure, any cached copies of that region in NS may be stale. We
+	 * therefore invalidate the shared buffer range after the FF-A call to drop
+	 * those lines and force subsequent reads to fetch the latest data from DDR.
 	 */
-#ifdef CONFIG_ARM64
-	invalidate_dcache_all();
-#endif
+	if (IS_ENABLED(CONFIG_ARM64))
+		flush_dcache_range((unsigned long)virt_shared_buf,
+				   (unsigned long)virt_shared_buf +
+				   CONFIG_FFA_SHARED_MM_BUF_SIZE);
 
 	/* Announce there is data in the shared buffer */
 
 	ffa_ret = ffa_notify_mm_sp();
 
+	if (IS_ENABLED(CONFIG_ARM64))
+		invalidate_dcache_range((unsigned long)virt_shared_buf,
+					(unsigned long)virt_shared_buf +
+					CONFIG_FFA_SHARED_MM_BUF_SIZE);
+
 	switch (ffa_ret) {
 	case 0: {
 		ulong rx_data_size;
-- 
2.34.1

