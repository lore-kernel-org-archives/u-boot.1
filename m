Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A66BC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 09:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8901B84CE9;
	Thu,  2 Jul 2026 11:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Bn0+5qF5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE5684C6C; Thu,  2 Jul 2026 09:14:59 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F6778056B
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 09:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3E7103F442
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782976497;
 bh=mICyDnm4S7Mdrcj9EzQFWtKnO+i02noZJJkVCPJf+lI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Bn0+5qF5ReDU8EYmDxVogK9o7cFa9dq2zOVlE4qDP+ZIzdzFbiSHjepYvuIO9SOWV
 lzNfrYffZO9xMpgETW39Z1B2bwBLfySD2Ld635VGZdS1aq5jJ/BaXdGPIoznmn4SCY
 U+49A3dx9DnLY0S/VCjuzAhXYoqWYdLQCvMUiC9V8XDwUGk+9AHS8rCgDVHs3aYYVc
 OBkNsuTXkpUNgKxspJ1UYYFpn9yFdiEhWBHoRvmVI0hWKmaQcbqfUhtN0d2oQU40H4
 7WjNLaTTN55wFl44wvRL3jta+bKlPLpv9dJaOBPE3pAeQ/y5LKR0thZSXbmBi8aY00
 GqpBwIjilkkcQW1waFgAMb1Y3J8xl5UFuFF37g1/brqJV3dhjRRUu7NvkXj0vxXESI
 iJcQ/X5Jk+YRvzpeBkSmkXJFnGgv8ag9R1a+SUTBKxQikodUlrs7mUCU4bCK6SszMT
 xkCaKNS10JzaOd9v3+0xj8o6Z9ycuCJfMd0SNUdw9qspm8eZ/77fAIdh/vuDjIEvwO
 spr6o1sKzRXv1skfAMA82D0pM7RwIET2XtfVpRnzH26SjrMz+2sz/vXHbHipQttRbr
 dkCHPpj+Sfd2L9LXF6BUC2jO0M8PDqXJC+/5MFAe71KEf7FCeDgg60IbATGZtmZPTS
 RkFgPAutYDLUHjDYUzECSeYQ=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8423f1fe39eso2407411b3a.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 00:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782976495; x=1783581295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mICyDnm4S7Mdrcj9EzQFWtKnO+i02noZJJkVCPJf+lI=;
 b=iP13++YjVb+Eo2FcOEeconhr6C2vwgHkQgjPxIfEmdD6xqu0j1rrmHhRX34HCUJJjz
 WPUunduIvv7LabYo6w4eCzCGoKkhBDGdwa33ShL2FXJWN+6LBoT6EYPeO/K3R0EvD/VW
 azC1OgwGIB3nLoWX1omcdo4RuCqulnivilPKevlgYfvB79G/ebQdo+yvwcQod32o2Vwj
 m7TaQ0C7W19yakLhjshK527G1RxFYfS3jlxnZGmSDXr2WCKPJpK6C69T0Rfs/TwEvau3
 ZZ1k5MNoQ0cyS/zXRyYs0B+DVlwOVAyXWZlRsOGXvZ2KM6C74heJICWwBrzE/82PFtHa
 6kjA==
X-Gm-Message-State: AOJu0Yydjasiy7gLDB8O5X5HhGqgvL/E0I4y2pHQ0NYUn/fqKu2SbOZ6
 Nl3EBireQVyMZL416kpw2dOEgz6QGFt2FJPGSz+bCBJdGqzTYYOwQHU8c/EAwdIFvhRJSv0r7SM
 LPapFCBAw4BeULzRy0sGfn3o7se80xixjVBF3Qycu1uemG0T+15KZ312n3WHET1SofbSoM4HdkW
 J3a7PBZw==
X-Gm-Gg: AfdE7cksw+YHn6e6ONgZo+PoEGlXBsca0cD7cq4Meaql96A2nnJe3hc749iA83UTAzH
 yTylCsLeAd77jYfx7PkI+VGq1iOJIB+pPjCaIbVq7LJSiZttj9SL8fzCHZMRFAFKrtflAkABFos
 vEx2K7+dSLP3Mjxt8HSYH4NOZlrne+O/Bkprp8G1nRF8926iMWJLO2hRq2/+LLFnyz0cpSxgrMG
 vNDCkl522OCQa5CyYHWpB+KYGkBy7j1IGAbXZsIeOrEeO/iYwsBn4yncbsUBcr0IHXEp47pwsv6
 6tWlsYj5E0apKpscg7BbhgL6Mh6MLBwqUmBz1+rCdJbrjs5HspGAk8vpOXkoL99XlRzeLhjHVX6
 3O2/9x8Tf/D94nIFJNeENaF25zPvVlAtmqvS7GEkSxHEnsRa6d26g6QcdE3W0OvpNXsCfdCFEHg
 jE1g==
X-Received: by 2002:a05:6a00:4299:b0:82c:dfea:9e2a with SMTP id
 d2e1a72fcca58-847c4fc3358mr4170113b3a.2.1782976495423; 
 Thu, 02 Jul 2026 00:14:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:4299:b0:82c:dfea:9e2a with SMTP id
 d2e1a72fcca58-847c4fc3358mr4170076b3a.2.1782976494945; 
 Thu, 02 Jul 2026 00:14:54 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cba05575sm894056b3a.61.2026.07.02.00.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 00:14:54 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/3] vbe: bound FIT external-data offset and size before
 blk_read
Date: Thu,  2 Jul 2026 07:13:58 +0000
Message-ID: <20260702071425.9204-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702071425.9204-1-aristo.chen@canonical.com>
References: <20260621143938.2863-1-aristo.chen@canonical.com>
 <20260702071425.9204-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 11:20:23 +0200
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

vbe_read_fit() loads a firmware-phase FIT from the trusted firmware area
and then issues a blk_read() to pull in the image, and optionally an
FDT, referenced by the FIT image node. The source offset on the device
and the read length both come from the FIT's data-position or data-offset
property and its data-size property, which live on mutable boot media
and can be controlled by an attacker with prior write access to the
firmware area.

Without a range check the resulting blk_read() can read past the
firmware area on the device and, on the non-SPL path, write an
attacker-chosen number of blocks past the malloc(aligned_size) FIT
buffer into adjacent memory. Only the SPL branch routes through
spl_load_simple_fit(), which hashes the data. The external-data block
reached from TPL or VPL, and from the bootflow path via
abrec_read_bootflow_fw() and vbe_simple_read_bootflow_fw(), runs before
any signature or hash check on the loaded phase.

Confine the FIT-supplied [load_addr, load_addr + len) window to
[addr, addr + area_size] before computing block numbers and lengths,
and apply the same constraint to fdt_load_addr and fdt_size. The checks
are written in subtraction-only form against the trusted area_size so
the comparison itself cannot overflow.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/vbe_common.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index a86986d86e9..844100b7ee6 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -278,6 +278,17 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 		ulong fdt_offset;
 		void *base_buf, *fdt_base_buf;
 
+		/*
+		 * load_addr and len describe the external data location in
+		 * the FIT, which lives on mutable boot media. Bound them
+		 * against the trusted area_size so the blk_read() below
+		 * cannot read past the firmware area or write an
+		 * attacker-chosen number of blocks past the FIT allocation.
+		 */
+		if (load_addr < addr || load_addr - addr > area_size ||
+		    len > area_size - (load_addr - addr))
+			return log_msg_ret("rng", -E2BIG);
+
 		/* Find the start address to load from */
 		base = ALIGN_DOWN(load_addr, desc->blksz);
 
@@ -321,6 +332,11 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 
 		/* now the FDT */
 		if (fdt_size) {
+			/* Same constraint as above for the FDT region */
+			if (fdt_load_addr < addr ||
+			    fdt_load_addr - addr > area_size ||
+			    fdt_size > area_size - (fdt_load_addr - addr))
+				return log_msg_ret("rng", -E2BIG);
 			fdt_offset = area_offset + fdt_load_addr - addr;
 			blknum = fdt_offset / desc->blksz;
 			extra = fdt_offset % desc->blksz;
-- 
2.43.0

