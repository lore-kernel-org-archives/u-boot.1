Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B1CCD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6411C881E7;
	Thu, 11 Apr 2024 06:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="vWfLNziV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A32881DC; Thu, 11 Apr 2024 06:28:39 +0200 (CEST)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5501C88207
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:28:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3LMOdgg9cMPu+F5Wwl4YQ4aPXibELfSL8nWMatR9/Q=;
 b=vWfLNziVSimRxOyu2Jl55bu7pwpf6tGbPRiejT3sya9+0D2QEmOreMAstS2J5WKgq29PWz
 G2NiAzZzB1pbqTLGwrfM3pDYjInqihQ2IXIAeyIhjOcMUeQsTgNBEWHOM0i8xzRONvyjjM
 AZEo2fR6tASquxB4BNEBqHuDlpd0OBYX1k+TNdlyPWB1E10fnpCza6tTKR1qwT6bYHHq7U
 OutvaJEafrh3eNVEMFd/n/+PLTFTHJTD5P5UFewB989iMV8piw3vbBnbdgIl7n2rlhdi1z
 CxFQx73VofkenkuXqiu3AuIn7b+epAusa9HATnDEkn27/wB69r8zM83zm+kWrQ==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 14:25:29 +1000
Subject: [PATCH RFC 12/15] nand: Add spinand_ helper functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-spinand-v1-12-62d31bb188e8@jookia.org>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809583; l=1045;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=WERNGD2kgBdI2g5lxVJKMbVmr/9SfB1ucpGkRbeKEmA=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAIlQ1s7mSsvIFEhtwh+xh48l
 ke4diTz5sTReKAff6j3uQ2O37n9Ll2TkcQmRNc/mAahclpAMaiPaZ1sksiXlfCQUAAOlk
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

These are implemented by the board-specific SPL code for use with
NAND-aware loaders like UBI.

Signed-off-by: John Watts <contact@jookia.org>
---
 include/nand.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/nand.h b/include/nand.h
index 220ffa202e..9fb8941dce 100644
--- a/include/nand.h
+++ b/include/nand.h
@@ -10,6 +10,7 @@
 
 #include <config.h>
 
+extern void spinand_init(void);
 extern void nand_init(void);
 void nand_reinit(void);
 unsigned long nand_size(void);
@@ -110,7 +111,9 @@ int nand_get_lock_status(struct mtd_info *mtd, loff_t offset);
 u32 nand_spl_adjust_offset(u32 sector, u32 offs);
 int nand_spl_load_image(uint32_t offs, unsigned int size, void *dst);
 int nand_spl_read_block(int block, int offset, int len, void *dst);
+int spinand_spl_read_block(int block, int offset, int len, void *dst);
 void nand_deselect(void);
+void spinand_deselect(void);
 
 #ifdef CONFIG_SYS_NAND_SELECT_DEVICE
 void board_nand_select_device(struct nand_chip *nand, int chip);

-- 
2.44.0

