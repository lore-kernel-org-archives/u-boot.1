Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA906CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 09:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD2584704;
	Wed, 10 Jun 2026 11:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="eMu/4qoo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 009CD8488A; Wed, 10 Jun 2026 11:02:02 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B2B9841C2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 11:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nora.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=2dwWs3PP7jmeh77x4uhbB27Zw/bQS3SFdv3OxcEI/tU=; b=eMu/4qooPahSRjKAy+WSDCApAA
 jNeAJV+x3FF+UMKGwb9IgOrClaRClS80FFmP5nXiNlrYHfAWT0GLTMXWY3XFD77DYxKSglZgwPSRP
 2lKbwY2EA9bMzKFlFNfIGqJTKRt7+qi3yo+Bc3OFsQiqBqwbO3Icyzi5tQk40FEIBIhdRKN0ojTwz
 D3fO/QuEk5VT26Zg+5QadiI8P0dEzH2v7VjO0qwE9fj9KJF3KAeewLTrWSXjDtZaA8T0h3OTX3nOy
 kA6Ob+PESTGNID0ZL2CvxqJ50mVeovjJIrDtFIBB4OfyQY1zlFiO0ek3WLWTzO6u40DmEf7wdORCT
 IUgOTyOQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wXEow-000Fgg-2M; Wed, 10 Jun 2026 11:01:58 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wXEp7-0007Wr-0j; Wed, 10 Jun 2026 11:02:09 +0200
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 2/4] bootm: use CONFIG_SYS_BOOTM_LEN for IH_TYPE_KERNEL_NOLOAD
 decompression buffer
Date: Wed, 10 Jun 2026 11:01:23 +0200
Message-ID: <20260610090125.99112-2-nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610090125.99112-1-nora.schiffer@ew.tq-group.com>
References: <20260610090125.99112-1-nora.schiffer@ew.tq-group.com>
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

CONFIG_SYS_BOOTM_LEN is passed to image_decomp(), so the same should be
used for the buffer allocation. Deriving a buffer size from the
compressed size if not possible, as the compression ratio may be
arbitrarily high for data with many repititions (for example ranges of
0x00 or 0xff).

Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression")
Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 boot/bootm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 51d99a3385f..db29606021d 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -623,18 +623,15 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	int err;
 
 	/*
-	 * For a "noload" compressed kernel we need to allocate a buffer large
-	 * enough to decompress in to and use that as the load address now.
-	 * Assume that the kernel compression is at most a factor of 4 since
-	 * zstd almost achieves that.
+	 * For a "noload" compressed kernel we need to allocate a buffer of
+	 * size CONFIG_SYS_BOOTM_LEN and use that as the load address now.
 	 * Use an alignment of 2MB since this might help arm64
 	 */
 	if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE) {
-		ulong req_size = ALIGN(image_len * 4, SZ_1M);
 		phys_addr_t addr;
 
 		err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr,
-				    req_size, LMB_NONE);
+				    CONFIG_SYS_BOOTM_LEN, LMB_NONE);
 		if (err)
 			return 1;
 
@@ -642,7 +639,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 		images->os.load = (ulong)addr;
 		images->ep = (ulong)addr;
 		debug("Allocated %lx bytes at %lx for kernel (size %lx) decompression\n",
-		      req_size, load, image_len);
+		      (ulong)CONFIG_SYS_BOOTM_LEN, load, image_len);
 	}
 
 	load_buf = map_sysmem(load, 0);
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

