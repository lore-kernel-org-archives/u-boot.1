Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26485CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 09:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0848483FEC;
	Wed, 10 Jun 2026 11:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lEWavdS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0F968489E; Wed, 10 Jun 2026 11:02:01 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7710883FEC
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 11:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nora.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=JpabfN+5/VZdE9mLPreUs1vTvpdfMCsA6uEGodOuabw=; b=lEWavdS1dIYazwbKUx/Aqlk4sm
 lRMAUK0uM13hW2+17XZ6Bww+btVh6p1zr3i7eSf7Ll/pmtOdI8jCB1zgi7X9Gm2vr7RcGebwC6stz
 uSZaEg7Plvcph5MZSMCP5C7jpMyORMoimPtXF+WYkiXtnR5mI8RsPi5Ms2gJoVdJ42q4QxCMOF5AY
 FfDEck22ZPBj26E6WuNA7jkigaU+6lFjlT6hXIuLHRIy61s/zY9dNsxRPGRfgfn0kxu14dJ70mfQZ
 27KtKLMV89O4vcw4ZHpZooAg7+BbecshPLwqoUiTpgSGnWa2cdcdW/ho8N3PbJG82tyxV5aIlpxF5
 kdLO7plQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wXEow-000FgJ-1a; Wed, 10 Jun 2026 11:01:58 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wXEp6-0007Wr-3D; Wed, 10 Jun 2026 11:02:09 +0200
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 1/4] bootm: fix flush_cache() with IH_TYPE_KERNEL_NOLOAD
Date: Wed, 10 Jun 2026 11:01:22 +0200
Message-ID: <20260610090125.99112-1-nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 10 Jun 2026 11:31:59 +0200
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
---
 boot/bootm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index ec74873b503..51d99a3385f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -617,7 +617,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	ulong blob_end = os.end;
 	ulong image_start = os.image_start;
 	ulong image_len = os.image_len;
-	ulong flush_start = ALIGN_DOWN(load, ARCH_DMA_MINALIGN);
+	ulong flush_start;
 	bool no_overlap;
 	void *load_buf, *image_buf;
 	int err;
@@ -659,6 +659,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
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

