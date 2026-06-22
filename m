Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17EDCDB46F
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 11:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A2F5849BB;
	Mon, 22 Jun 2026 13:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="fOAsSXzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E6DF84866; Mon, 22 Jun 2026 13:20:26 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B307E84832
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 13:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nora.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=AaCpbqsTMWd4mCEIPJ+pb/OV3J8goFNGxOcaBXWzU+o=; b=fOAsSXzchpp1iv3U5VOtPx/ABS
 2SZAdzb8QcpVHIaSQKciMrMOJ3l2QgjzXIk1wyHQcu6LZDEDxALTyYLZn1LqzfrcAS6zyEdy7axWu
 EXO786a/W/bwJrF8nUsMupBPAtaRIsvu9Jj1abWC99fd4/2bTUGi3o/d6zWhYf2vY9vtYj019IN1w
 FE2UC//S/k6U88KuRpoMMqf/uiqWA4NwgYfe0g4ty5bpOWkijV3swVa/NPe+ZIsGtn+4LasYYjLZn
 bhobu3aW1QrPahxYKGbD6L+hPNsWSn6joS/6gtXKKlCYtjRfVvLknE3eVR8nC109GmwwQmekftZgu
 KVPXf1Kg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wbchR-0002Xl-1g; Mon, 22 Jun 2026 13:20:21 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wbchQ-000N6e-1L; Mon, 22 Jun 2026 13:20:21 +0200
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v2 1/3] bootm: fix flush_cache() with IH_TYPE_KERNEL_NOLOAD
Date: Mon, 22 Jun 2026 13:19:31 +0200
Message-ID: <20260622111933.1488593-1-nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

`flush_start` must be set after `load` has been assigned.

Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression")
Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

v2:
- Rebased onto next
- Collected Reviewed-by

Patch 2/4 from v1 has been dropped, as an alternative solution has been
merged. Whether CONFIG_SYS_BOOTM_LEN should be used for the allocation
size is undecided.


 boot/bootm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 4c260a5f5ce..7c9a6f82976 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -618,7 +618,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	ulong image_start = os.image_start;
 	ulong image_len = os.image_len;
 	ulong decomp_len = CONFIG_SYS_BOOTM_LEN;
-	ulong flush_start = ALIGN_DOWN(load, ARCH_DMA_MINALIGN);
+	ulong flush_start;
 	bool no_overlap;
 	void *load_buf, *image_buf;
 	int err;
@@ -663,6 +663,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	/* We need the decompressed image size in the next steps */
 	images->os.image_len = load_end - load;
 
+	flush_start = ALIGN_DOWN(load, ARCH_DMA_MINALIGN);
 	flush_cache(flush_start, ALIGN(load_end, ARCH_DMA_MINALIGN) - flush_start);
 
 	debug("   kernel loaded at 0x%08lx, end = 0x%08lx\n", load, load_end);
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

