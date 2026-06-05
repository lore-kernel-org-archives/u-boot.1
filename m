Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B88CD6E7D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 17:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D399D84996;
	Fri,  5 Jun 2026 19:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KYNARIB3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E6584956; Fri,  5 Jun 2026 17:43:23 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 890E284932
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 17:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 47BC53F8E4
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1780674201;
 bh=bAWXUc+thdzuT2IKjixyaJMRQ7VhaqcXAYHAfXapvmI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=KYNARIB3WSG7xzSquPy0tm7bM/fHYwTefbBEqfULbxfwvJSlj6x+N6gMz3n3L0bLB
 v4xdAQA3SU5ThQSunZDw40MTEBqbEidaSssV0jj+Xa2noYrCGNtxK9YLjZYKU1SecK
 XG18qwEO978IZCbh+yGEoR+DECsSOT5dqdR5cZFix1wg7qqe0vvjpEFkzwok/u0dB4
 x/Ws7Xx18vCoPReMsVkjDAFz/KYAxAMGwVAtUkV0+Oo05M5wUuRTdvlAg35NIGeiiL
 G/C+8Z2lvyLmXP+a6hMTQcr7Xzeh1N6Ecci1+DWzLZYgJ/DtWjiGQcejOyYUEls8fp
 4Gb9Iiwvq9JuOXs26slj5cYIphGFb/Z5HruCR+fxvutBaR860MNLFw4YJizv4p8a/q
 va+oorro3R2FyaUOUh/201HfcJVpe5CGhFplHbEFFbfTDyxMGvbZ5/WKvSP8jTK4I4
 yj5RwNswnXF/KBk6+AKd7nX395r44ezququ8z8dtN69/wb2V1KVnhHyIf5ucdthZuA
 mt41A7Xu9JcXP3kW1cQFnq3Ypaw6az5j337UKI/vt3O9tn7gEQYfIMWzKOqAw+5+qM
 I8NDYalofGnc8yT+nooWn7N9WMEpXooVTUQ/e6DtrHJDoW1X3JKKx3DCoDjJ5VBwCq
 VwAqNrWO3ipdX8XXEabCb92c=
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36e09ec696aso3571006a91.0
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 08:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780674200; x=1781279000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bAWXUc+thdzuT2IKjixyaJMRQ7VhaqcXAYHAfXapvmI=;
 b=grEC8SW+6j01UcnwZbt16jmPfwuUB2+dzQh4FiW9A3Rf7WiSUZsciflDK8V1liH7a2
 nmW0fWxp4O5VtE7oTy+op4hw6S6Yc820tl9ybmTJ5fDzlrxEJ3ZD1zuMdto/8MF9PoMD
 fX1NOKoEWSleZtGhav0j8vmQNQy1f7mAb3j0AZUFhErxspkKpsL11JQvn0ILgTzbzujq
 AeFAMM829d68XxXk2d67zxC67ITcyQ2Cu41MCB5OZf4xVE10kNsKmTTHK2AbLrbW/Rkn
 hkMs2FWwxxJ5T6Hb9Gs7+hc9WOWa54jCxzGxdQtlIdumAUQf2U8HOE59AAFS+/CVo/Vu
 9tRw==
X-Gm-Message-State: AOJu0Yx9U4lWa1PqZ4Rq5mM+tD/EbQK2jUWjrvrEO0PdkWr9zY1PEONQ
 F/GjLmdtB3nIpD8vuElzNouZ4QMkr+sbFmWk+01F/lrKvFe0jiYkpYo1VE5/K3ucrXyDvq3caBx
 CB0I26ZXLglbhU9dH5Ckd2QXdhdD061IhUsG3FiK310WlEQ5Z2Ekj6uFuFwOFQ+BAqZyKplhrHc
 m+a7g=
X-Gm-Gg: Acq92OFPDEyaz1h25RiBzisHhRv1bPtEJiyj2ku9eAceqbbo3KB7Po72/5XhIGPbg0m
 s4SpoCh+MpUov6i+/04QEcsYPlhMWRLOKxFgstEpyLoPi8KXZgxeQ53ZoOicmUnH+9jIkGNHo/f
 DiOZ/p+RkN49HMot7PKJIZPO7Ud4kULlJxV280lQBzF67d8y8yMOXmF8KYdP7vS/S71IMtd3+DP
 8nHiZv7ODJsvMPo/VKnV8LnWGLupqNav4kgM+VyPdYnNPNxHA+LEp8510dAw6Q7DGPbP3G50iuM
 EumNR7qrjb3225ifSuK9nyoUyTbqfGOWOapRSy4N4yr8f4UGo9dHw/BdH/NSKU6OEdJx5U63B0S
 qrmEsSAMi7c+EIlyFoTdJBIzNpoL/7km3tyYWUAOWENuX+4K+294W+GuCFenWb2mt4qVqXv6SKv
 hF+uxo
X-Received: by 2002:a17:90b:5827:b0:36b:a0fa:ff96 with SMTP id
 98e67ed59e1d1-370ef1f2cdemr4486942a91.12.1780674199646; 
 Fri, 05 Jun 2026 08:43:19 -0700 (PDT)
X-Received: by 2002:a17:90b:5827:b0:36b:a0fa:ff96 with SMTP id
 98e67ed59e1d1-370ef1f2cdemr4486923a91.12.1780674199271; 
 Fri, 05 Jun 2026 08:43:19 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f70a285a1sm7233531a91.9.2026.06.05.08.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 08:43:18 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>
Subject: [PATCH v3 1/3] bootm: fix overflow of the noload kernel decompression
 buffer
Date: Fri,  5 Jun 2026 15:42:49 +0000
Message-ID: <20260605154255.833334-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605154255.833334-1-aristo.chen@canonical.com>
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260527150637.2850104-1-aristo.chen@canonical.com>
 <20260605154255.833334-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 05 Jun 2026 19:15:17 +0200
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
paths are unchanged and continue to use CONFIG_SYS_BOOTM_LEN. When the
failure is triggered by the smaller per-image buffer, print a note so
that handle_decomp_error()'s generic advice to increase
CONFIG_SYS_BOOTM_LEN does not mislead the reader.

Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression")
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 4836d6b2d41..b55c41f30b7 100644
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
 
@@ -635,17 +636,20 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
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
+		if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE)
+			printf("Note: noload decompression buffer is %#lx bytes (not CONFIG_SYS_BOOTM_LEN)\n",
+			       decomp_len);
 		bootstage_error(BOOTSTAGE_ID_DECOMP_IMAGE);
 		return err;
 	}
-- 
2.43.0

