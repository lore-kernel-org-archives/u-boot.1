Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14CFCD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 12:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04EEE847FD;
	Wed, 20 May 2026 14:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SHXgeQc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8942E8469F; Wed, 20 May 2026 06:46:26 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C758039B
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 907163F7BB
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 04:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779252383;
 bh=bSnsmly31JFrVsPe06CGQQ5qFcHwujThWxM/1vefgDQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=SHXgeQc1RK2NW4jVelaeP9aZEqRYGLQN2iP0VGO3FvIA/GOYMyCvwwIZzNUeLFTAb
 nDjSZ3VnPiHacDZin875b07MStAZ18nOzN5iOiiXo3Mdsp2og4ridcTIDAyi1O/F3c
 CLZCJyCUSft41EE5htUo1hdo3k1QSNKLVuG9t16KsjlkLglNjfgpMXaK2yJ5X1T5fR
 AeTnW3DWoFI3Ti4E5mfwpzgnvor7atRB0T3cZND9oROdDTSPJ2DyKg+dIYD/7s6iP7
 HEXa17JQm3h3w8l19rq/xDT94XchWxZSBGpwTWioyGPXMN+H6KZ0WsZRfasQUbCMXF
 e5cyHkzMWO5cVCuWVD+AUGzlltV7sYScqIZ87dVH8lszRvVs8DhvBpLfb9UigzXQ55
 ZH7xLkGlCyKl/OohrP7qPn6PIXYI0H1z90Ncn3xVrc7egmXt4JMmAF9Ar80Rrek5hi
 flzKzhZjfR4Ey+PQdFbFNCRoKlfdjGIZArTgNJg/WRE9J1aI/7QM308UllPzv8TkgM
 pD+IWWEXP9HjGmpMG7zHntUMH6X2z7rvj+jPfS6t5eiDm8+srfaq1rYdU+pVvH+e+r
 KjSLBNAB94q407OpKWUzCU1vjqesZDNd3U5wEj29jtD03Z+uO3m3fGG+mh4EUxrr0w
 byKNB8sGbmVu6AMQWcDajBOw=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-836d0184333so6065733b3a.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 21:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779252382; x=1779857182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bSnsmly31JFrVsPe06CGQQ5qFcHwujThWxM/1vefgDQ=;
 b=mGtgH2kgJBdlFF8g+GPl2QrgZKUZP/Es4goyJ7D1MBc/EFm/xmxdqcUBRvCP7umPBm
 kOTf1U+uySXc57D8FQCE5KxSDaAsyxKBNSnJsMmAmhuLtLfl5sJgnh+8dd4Y2GRV3YHp
 y2C7M9gsLLCpolFqgN/B0H+Ajt/z0eRnz03+E6KJSEm/wvz/PDQiDnQIIR/ZMoxgQLj5
 tiCCBArYUQ1IDmPE/fYvemqV3BEmijVhD9e+c6EjXJmI4xlxdwMrLLCbCOqWHd6TUmsR
 dEABD9RPmAQtp61h+t+3WCxbJ54QzRvLlRDFwzdX/KRiZ4O3Fd0Vpzs99t8Q78uzllhh
 NknQ==
X-Gm-Message-State: AOJu0Yzod5yVKSdjpD8boGoXH0KeJM2ivUa7H8FfYND2nsG+rbGB53mb
 pWV8U0gCz7LS8GEijnavMfHRWld9k1Y5iOUzk1D+eXZlNOn3WgnjNhoZRlGSvQ9tqvueZUI8zHX
 9don1v/i0nTCdLKJDhvirrF+w5uRheG6qOWoK2YPBrvCJHQ/j3IzzLbFw5DkioVpf40x8VGCnjA
 yPPAZ1Tg==
X-Gm-Gg: Acq92OF+UB9yfLlJ6Ed2SJrzh2NWMnMdYneC7KTC9hhCcWpx1+UsW/goTVPKQ7yos8J
 o0wPxw7zq5CKmAbZ/UgY381/p3ZVQUXxm4+VntQuEV1Ng23yE+PIq+B5JH0MaSUTQioP6Zm9Jli
 2PuP6ACo8Knz9fMgzTebsz/OzTcnUY80nwTLttysnGCzE/fi1T0VITAsrOmb6ClkuzZnwgkcdGV
 NaCcETLkNNe4s91UExSXrybYXr2dFI3OVTq+HFV6dFitErSw/hvP1dJoUsEIss/O96p9NQSrJ+2
 CLLIhuM0LaewUeRUXOFctRxbwmeTAmG8IAHPVP8CvIz9YKY9G+MVabmvhYd7iA4Faj8RicJb3bG
 7zxAGC2+LrOR8CW5JP/OcjZi5b+UHP4SF7cm/AIxYW8nKqAP+EzdedXptebh+ApCNRXC5LErL01
 uxqwoCrPflI7bQVP4=
X-Received: by 2002:a05:6a00:9092:b0:83e:d957:e5b3 with SMTP id
 d2e1a72fcca58-83f33dd42c8mr24525974b3a.34.1779252382099; 
 Tue, 19 May 2026 21:46:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:9092:b0:83e:d957:e5b3 with SMTP id
 d2e1a72fcca58-83f33dd42c8mr24525949b3a.34.1779252381701; 
 Tue, 19 May 2026 21:46:21 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f1977a570sm18570304b3a.20.2026.05.19.21.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:46:21 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Ludwig Nussel <ludwig.nussel@siemens.com>
Subject: [PATCH v1 1/2] bootm: fix overflow of the noload kernel decompression
 buffer
Date: Wed, 20 May 2026 04:45:50 +0000
Message-ID: <20260520044554.15373-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520044554.15373-1-aristo.chen@canonical.com>
References: <20260520044554.15373-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 May 2026 14:49:56 +0200
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

For a compressed kernel_noload image, bootm_load_os() allocates a
decompression buffer sized to ALIGN(image_len * 4, SZ_1M), assuming the
kernel compresses by no more than a factor of four. It then passes
CONFIG_SYS_BOOTM_LEN, rather than the size of that buffer, to
image_decomp() as the output limit. The decompressors honour the limit
they are given, so a kernel that decompresses to more than four times
its compressed size is written past the end of the allocated buffer and
corrupts adjacent memory.

Pass the allocation size to image_decomp() and handle_decomp_error() so
decompression stops at the buffer boundary and fails cleanly when the
image is too large, instead of overflowing. The regular non-noload
paths are unchanged and continue to use CONFIG_SYS_BOOTM_LEN.

Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 4836d6b2d41..98226b208ee 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -610,6 +610,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	ulong blob_end = os.end;
 	ulong image_start = os.image_start;
 	ulong image_len = os.image_len;
+	ulong decomp_len = CONFIG_SYS_BOOTM_LEN;
 	ulong flush_start = ALIGN_DOWN(load, ARCH_DMA_MINALIGN);
 	bool no_overlap;
 	void *load_buf, *image_buf;
@@ -623,11 +624,11 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	 * Use an alignment of 2MB since this might help arm64
 	 */
 	if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE) {
-		ulong req_size = ALIGN(image_len * 4, SZ_1M);
 		phys_addr_t addr;
 
+		decomp_len = ALIGN(image_len * 4, SZ_1M);
 		err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr,
-				    req_size, LMB_NONE);
+				    decomp_len, LMB_NONE);
 		if (err)
 			return 1;
 
@@ -635,17 +636,17 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 		images->os.load = (ulong)addr;
 		images->ep = (ulong)addr;
 		debug("Allocated %lx bytes at %lx for kernel (size %lx) decompression\n",
-		      req_size, load, image_len);
+		      decomp_len, load, image_len);
 	}
 
 	load_buf = map_sysmem(load, 0);
 	image_buf = map_sysmem(os.image_start, image_len);
 	err = image_decomp(os.comp, load, os.image_start, os.type,
 			   load_buf, image_buf, image_len,
-			   CONFIG_SYS_BOOTM_LEN, &load_end);
+			   decomp_len, &load_end);
 	if (err) {
 		err = handle_decomp_error(os.comp, load_end - load,
-					  CONFIG_SYS_BOOTM_LEN, err);
+					  decomp_len, err);
 		bootstage_error(BOOTSTAGE_ID_DECOMP_IMAGE);
 		return err;
 	}
-- 
2.43.0

