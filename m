Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5433FC83F1D
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 18:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88660808AF;
	Sat, 12 Jul 2025 20:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="GSpQIbFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5019A81D5D; Sat, 12 Jul 2025 20:52:33 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17544805D7
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 20:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: 7145445c-5f52-11f0-beb8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 7145445c-5f52-11f0-beb8-005056992ed3;
 Sat, 12 Jul 2025 21:00:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=977i1qjvc0X4+BBilfNHcOYHjjEkcgpVBVsWewQa+dE=;
 b=GSpQIbFDTlhcnfMOIo0YogP5Rx1qKwSp6LlhC15Oq6YFtqH2Ue2RrHVCqWKbSc+TVPXAwQDwzdLno
 6GNFn73AUxhxMLh9Y01eIiWcAvlMeAo7BeMrrdibn1o461zZB6qNb4YUshCm72KO+FBUEn8TOmK4U+
 99FstJrXtVgRWu48=
X-KPN-MID: 33|itsmQ63JXHQvGjvX9E8weRmrC8QvZv19jS2/4gIiPJQy7xEM4pfGgGJiIi+NCrX
 S3niAy1cRGO8EGWOrE8Gk+slW4LKplVJNFBfgMoqMtjI=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|HTWXyas2fMTeFMeEeoDeZyzU3p47Fafsq6fTpPlmHdgI5vnmqHo+rfxqSM4zYr1
 SoN3mpat5Ss+QwqS1b/e3FQ==
X-Originating-IP: 80.61.163.207
Received: from korngold.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 5c760803-5f51-11f0-9821-00505699d6e5;
 Sat, 12 Jul 2025 20:52:30 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, josef.holzmayr@northern.tech, liviu.dudau@foss.arm.com,
 Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH] board: vexpress_ca9x4: Enable D-cache and MMU
Date: Sat, 12 Jul 2025 20:52:27 +0200
Message-ID: <20250712185227.17100-1-kettenis@openbsd.org>
X-Mailer: git-send-email 2.49.0
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

Enable the D-cache, which will also enable the MMU.  The latter
make sure we don't do unaligned access on Strongly-ordered memory,
which has UNPREDICTABLE behaviour according the architecture
definition.  This fixes using U-Boot with recent versions of
QEMU's vexpress-ca9 emulation.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 board/armltd/vexpress/vexpress_common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/board/armltd/vexpress/vexpress_common.c b/board/armltd/vexpress/vexpress_common.c
index 6c374e25e32..3833af59b09 100644
--- a/board/armltd/vexpress/vexpress_common.c
+++ b/board/armltd/vexpress/vexpress_common.c
@@ -165,3 +165,11 @@ void smp_set_core_boot_addr(unsigned long addr, int corenr)
 	writel(addr, CONFIG_SYSFLAGS_ADDR);
 }
 #endif
+
+#if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
+void enable_caches(void)
+{
+	/* Enable D-cache. I-cache is already enabled in start.S */
+	dcache_enable();
+}
+#endif
-- 
2.49.0

