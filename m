Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823C5C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 04:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15FD0847C8;
	Sun,  5 Jul 2026 06:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bBFXFXzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F26158484C; Sun,  5 Jul 2026 05:44:43 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F401D801A9
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 05:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A68713F1F4
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 03:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783223081;
 bh=mICyDnm4S7Mdrcj9EzQFWtKnO+i02noZJJkVCPJf+lI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=bBFXFXznDa446ierG3OKCmBzKj04aMR6chaqys0Of2jOzMr4Ruht+pzNLS6Q2BX+B
 pzO6BTq00U7DNhMy5ESgEKoctZSYyH56kQdoXjrSSDDZGMLl8fGH/9pGVLbuAunYJM
 LawOwtpezkDkraI8uOP/ILqOQf7cbirvPAdp/vmp9nSHImq97OmPOve6lppJsYNohO
 he0/jSmCW/m0CeCmNfaMiMlx8/dDDy/ieQOmf97aDtYoGfMJHi0UncwT8GOmQjq8bT
 u1TUJFRUI3lO4c3KdlpxWooLz9XfTOl0TqmXhOEcgim4iSNbdvxq8Ny/y/dIyBlMFx
 N1x4S94q5WguUXWEAz0UUXu912g75h2ECoTV+YysM6I7dVl9fqubHhrC7Cxhsw7P4B
 ZFU8yBLqIsMoXn2zMHjWmEZRsOUqoIKNN3rbb2gG5GNQL+mW6578umbivEvnYZ+bzC
 oL3J6PyAXWYNJe1QdXqkiA8UeNr1ZhZgC8P70E2CiA0103v2oA29SdBfnsm3cqW/es
 f6n2G+meEAHMgHeisVJZKt6wA2GOOxmeV2cOd0Fk9GgYsaDrEU9l/JVIh2yyWjMX2k
 8ivSFNRyvDMI8G+PjhWHbey7H2OTkEaLWmVWnESCiC3YKt5ue0J2C6xej3GRJg1W6u
 UXh0z6WmaCkAdBfrDbyiZnzs=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-847c3a12ce8so1862358b3a.1
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 20:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783223080; x=1783827880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mICyDnm4S7Mdrcj9EzQFWtKnO+i02noZJJkVCPJf+lI=;
 b=VwOIKtgeFVY1vun2Lm1szmpaunW6ebKy2RWQh9zNYrwNimm2VfpJWUNFkr4kuUEgCB
 bcMyjoPt4p9OD9Ul6XDJXAYA20DTeoKdBaDbzFU/EUIHhiHTaHbQ5beUJMU/JO4WE1qD
 uHF7pWC2yZt443EsVnZM4TN/YMy/QuZ/b40MKNpii4qbtgWgK414zZNikKEPnhiOocWo
 RYjgH8cge38kNMeCExKjeFKV/NJq0bsLBxs7Esv+gx77fMG7BMyMr2KYEoCAjyitzbaj
 gvp/z9Eejqoo4OPZFl2BuV4SxD6P1xSbxfVhwNLJLaQ3o0MviZ5mc9kVP/YkHQ59/f+O
 IV4w==
X-Gm-Message-State: AOJu0Yw3xBjXNxR5iN7vISGGv9VtL1gmlryyvsNlJ2aWxtmBTfsshgg8
 Q3sYDtFm9l5OJ90gsWgz/hpXYnVC2KlrUNUWzkQMLCkL/Aijj17rBDbU7qUixbfBDgWwn3bTNCW
 AtqcekV9gstdj6SQERxeyft6bf1OYXbvIQZ3jUzQCatw7gFMVBcXNEcwSTeO49aJ/rFP+5MWES/
 f2RsM=
X-Gm-Gg: AfdE7cmA7NL14PZY+cXyziOXg+4rhrbrYjl8y7xz0dCj0lJG+uungULtRYgv/T7lsL8
 DlgnVK86suXYyVselFX5ULg5tPQ5frSQxHpP8JauNVagFbeL7TDoq234aGHE6Xnl5ClfkMm1Ket
 48b5LAZY5K7rG2E3/RjRDjIGo6I4MkI0NkxWQAEI+gYY2x3hN11uqprUa//r94lHKcFN24cqUYB
 0CDp3kNgGthZr51KrQlLq79OgBGs6y2cJTXlsrYx2kJ+wS23bvbH0C4gqa1lTlGvN51UoNHbquO
 beYJXQuTiAWVLZ+FZtDvCdI0NtKAHMJjm9bFE6CuSLy3P7+d52McgdaJxrEcIj8oaFysSCCUgaC
 s2L68O5N6zHiggDj6AT1elF5h9ogJRVgjrPYGWYin83RLBO8bwhunawCilK0OHbpXqWKWLrAe0+
 y7k1hm
X-Received: by 2002:a05:6a21:32a2:b0:3ba:f5c7:6bc3 with SMTP id
 adf61e73a8af0-3c03e15d9b5mr5405540637.10.1783223080102; 
 Sat, 04 Jul 2026 20:44:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:32a2:b0:3ba:f5c7:6bc3 with SMTP id
 adf61e73a8af0-3c03e15d9b5mr5405480637.10.1783223077997; 
 Sat, 04 Jul 2026 20:44:37 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e926a4294sm4424735a12.26.2026.07.04.20.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 20:44:37 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/3] vbe: bound FIT external-data offset and size before
 blk_read
Date: Sun,  5 Jul 2026 03:44:10 +0000
Message-ID: <20260705034414.2247-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705034414.2247-1-aristo.chen@canonical.com>
References: <20260702071425.9204-1-aristo.chen@canonical.com>
 <20260705034414.2247-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Jul 2026 06:05:54 +0200
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

