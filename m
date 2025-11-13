Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1280CD5BCE
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 11:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2867583DF7;
	Thu, 13 Nov 2025 12:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qtp56we3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vGmF8nL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2728983DFF; Thu, 13 Nov 2025 12:55:27 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D91283DDD
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d6dxl2Qqlz9tff;
 Thu, 13 Nov 2025 12:55:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763034923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=z3hdvhGzaBv4zKN4njjV4YBQy1tlTJosECmGIBQf6/I=;
 b=qtp56we3Gm+OVv5/eqG1A20lMJUh+2p8XxsuXrXJzDYgc2j6KPFRPPQpEA4/ufA7Yuwr4B
 aTX32VWizfSJbqeXF8EZWVhcwMMCv8hVkKtwEJoLYxHq6gnfP6rEP422s1d+DWjFgKqfW8
 j4z6vFADXd1+4J42aW59z1WrG+UOs/66J7s3LOm1mLsVnlhmA3QKpjDwEupjt0cS6dznL1
 +/X9t9vYMKtKK6wkDVhjoZcGflUfr+6Dz1/dZwPg2Qn3ULUx5d+a8vmDcEf1dl28dclwyk
 rEAtM6usVfxnjYxdFjjd17TSbkoavIWP5KuNbB9Z3NO0VrdM320N2joiJ792gQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763034920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=z3hdvhGzaBv4zKN4njjV4YBQy1tlTJosECmGIBQf6/I=;
 b=vGmF8nL1M2bcp8fPJCrqyQymrqrNiaL6jluRNGo3IxH/CXTwC6duf2c9dsFRYmCvKdkYlw
 mSm0z9DZsFuw2enuEzM3AeSmmiDRfFtaQqmD505Z7JdCjjkv8b6DKm1OxXBczl0/i4XBUj
 6zYfJkiYEGmZ6G9JWj6j/gtiDsJY81/QwCeeWHHbJo22AjD/K45NP336HpD7qMdoEg4RuY
 92MlpRSWdt72/KBCxWUIidNbdtHpjA59vc/mSa+aMqSAtF/gMu0wiAG4MrbQgNanhQdgM/
 rB6ag52FfCE0cW7P9IDgR/0CGSWiYxiVqXGBbo++ngZ6P7Nq7LHAn7gNx+CpCA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: [PATCH] boot: Assure FDT is always at 8-byte aligned address
Date: Thu, 13 Nov 2025 12:54:51 +0100
Message-ID: <20251113115516.947835-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: g5jugh4saaxhq38efyuw6j7irzscd6pa
X-MBO-RS-ID: dfddc7c099eb43d0532
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

The fitImage may contain FDT at 4-byte aligned address, because alignment
of DT tags is 4 bytes. However, libfdt and also Linux expects DT to be at
8-byte aligned address. Make sure that the DTs embedded in fitImages are
always used from 8-byte aligned addresses. In case the DT is decompressed,
make sure the target buffer is 8-byte aligned. In case the DT is only
loaded, make sure the target buffer is 8-byte aligned too.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Cc: u-boot@lists.denx.de
---
 boot/image-fit.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 2f2d3e9304d..cccaa48f683 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -23,7 +23,6 @@
 #include <log.h>
 #include <mapmem.h>
 #include <asm/io.h>
-#include <malloc.h>
 #include <memalign.h>
 #include <asm/global_data.h>
 #ifdef CONFIG_DM_HASH
@@ -36,6 +35,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #include <bootm.h>
 #include <image.h>
 #include <bootstage.h>
+#include <malloc.h>
 #include <upl.h>
 #include <u-boot/crc.h>
 
@@ -2279,7 +2279,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 
 		log_debug("decompressing image\n");
 		if (load == data) {
-			loadbuf = malloc(max_decomp_len);
+			loadbuf = memalign(8, max_decomp_len);
 			load = map_to_sysmem(loadbuf);
 		} else {
 			loadbuf = map_sysmem(load, max_decomp_len);
@@ -2291,6 +2291,11 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 			return -ENOEXEC;
 		}
 		len = load_end - load;
+	} else if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
+		   ((uintptr_t)buf & 7)) {
+		loadbuf = memalign(8, len);
+		load = map_to_sysmem(loadbuf);
+		memcpy(loadbuf, buf, len);
 	} else if (load != data) {
 		log_debug("copying\n");
 		loadbuf = map_sysmem(load, len);
-- 
2.51.0

