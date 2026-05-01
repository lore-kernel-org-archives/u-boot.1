Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9017ECCFA13
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 22:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D9CB840D8;
	Sat,  2 May 2026 00:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EEWg5dz2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D49B4841D7; Sat,  2 May 2026 00:28:19 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8B7C83693
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 00:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8cb20bcff5aso216010385a.3
 for <u-boot@lists.denx.de>; Fri, 01 May 2026 15:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777674496; x=1778279296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vsgyUU/3UNTOHKVozBCl2pFqT4bdD/OJ1Ag1k46uKEQ=;
 b=EEWg5dz2GwmbSVi+Ci3CHzwqJ3653BG3TFqkRDTVjSVB2IpzRTIhKAXtfIsSNHMmMG
 w/OHYBvjMLF8YjV3YgsBbJvxHxX0wHGtrWdJJnbBiH0HAdSKaBtTmIj8wSa6PVqo96+f
 0wxd1gXrBr3ffcDhh8jAyR3EXPfNr5ZZwP+GYa84HL3ntv1iPTKhaocMx0CBDCpptoxo
 qa13fORNOVo8VBH6ak9heeK+iqfx/cIO74nZE6CnwOEzkeq9AegDdR1g4D4yCkxFuEBI
 1lfp6RYiWG1u619dJQb8mwkA2k9pnQE2PenH6dLEZN/K4xY7IwHOcBKOw6mPbJtect2K
 H35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777674496; x=1778279296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsgyUU/3UNTOHKVozBCl2pFqT4bdD/OJ1Ag1k46uKEQ=;
 b=e6cTHL8eBTvHHIHy03b6zVU2i4B0rVfdONW9ZeAfAs7qEsXBQ4m5yherEtE0+wa238
 ee/NrJMAF2ic1FhZ0OpTw8DAxlBoy+mpuJ0JsAZwlkdn/Pnq8ZOWmU9ZYPGguZNsoYwX
 ytJSpXAexd7L5CZderFY53NAsWw0F9EnOav5WZyEGlQgdkUgKOj2dQAsZ3i+daDGfawT
 F6WUzvTHqtNgb+0gCNMOMOR3WNAa942nkcQgQH90sv2YwQynRyJRG2wlhXEQo5v5nSn8
 GU5iV/HUC7egFIir5oz3WPW0yfSnmMZv5BE/eVoKY4CHnUG/dUEnFz8uvSn5t7PTfxEB
 tW1A==
X-Gm-Message-State: AOJu0YwHU7O4cxcmDReNw4SHLZ+hjX0YHKEVLBdfw6xi8HhY0HkrSoO/
 wMveXtdNbSDdWcwy2Nr4FdirUhuJ7tdhXlAJ9ye9PfjmCeap2xsSvXNJ2pjjPn2VY98=
X-Gm-Gg: AeBDiesBI3qdBPiCIxAO70zP8zYtYQWoDNXtRCqAKkOtbVkfMWOE01/LTDKfBhv6biA
 MqyqZsYlgbhwi+nWNMl436rCQNw7GsXzf0AafJBF9+tgfKFsmcjZQsHmw+PKqP4jFKMPfQSjTvY
 OPY5WJ3PIueVFezj184owQROn/iU/ivndIQRB2LOYzELtkXCrc4MNAJKHEQIqEZ91oLmMR+5kM/
 TDfYO6aja822LKOij8xdw09v5Az7BWItZJ+XMjHPyyFKlNVH7vwiwQouCTJXgEduNeJ585VYuM0
 uS7FGfwLOJNc8kn+V01Q0iJrqLTMENTplpxduF+SDmkMoUnGaTHkogHNZALFduKbs0anc3JTGl3
 viqFNTtYGqDuJjW5UWhfXFJmDpPfiHbnVOK81gRnSCkTLaWuxegsGaOI5w0gwahamuA9bKmDBqV
 GbqPlGkni48YkzazpijhbEU9bcGObMPPpyOM2uAEEN/ld1z17CVuQUGlTnhH6nydNaH6mEMH5HH
 4Bc6kSp4bo4xLQ0TtgWQQ==
X-Received: by 2002:a05:620a:4891:b0:8da:dc5d:acf5 with SMTP id
 af79cd13be357-8fd155f2791mr219282185a.12.1777674496150; 
 Fri, 01 May 2026 15:28:16 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc2938e7f8sm284458485a.7.2026.05.01.15.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 15:28:15 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Michal Simek <michal.simek@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH] lib: fdtdec: validate bloblist FDT before consuming libfdt
 size
Date: Fri,  1 May 2026 18:28:00 -0400
Message-Id: <20260501222801.1596650-1-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Raymond Mao <raymond.mao@riscstar.com>

Coverity Scan defects are observed in fdtdec_apply_bloblist_dtos(),
since the live FDT taken from the bloblist is passed to libfdt helpers
which consume header size/offset fields:
- fdt_open_into()
- fdt_pack()
- bloblist_resize(..., fdt_totalsize(...))

Add a small helper to validate the FDT header and confirm that the
advertised totalsize fits within the currently allocated bloblist
record. Use the sanitized size before calling fdt_open_into(), again
after overlays are applied before calling fdt_pack(), and once more
after packing before shrinking the bloblist record.

This keeps the existing flow unchanged while making the size consumers
operate on validated FDT metadata.

Fixes: b70cbbfbf94f ("fdtdec: apply DT overlays from bloblist")
Addresses-Coverity-ID: CID 645837: (TAINTED_SCALAR)
Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 lib/fdtdec.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c6e13b6abef..edeaf16af51 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1744,9 +1744,31 @@ static int fdtdec_apply_dto_blob(void **blob, __maybe_unused int size)
 	return fdt_overlay_apply_verbose((void *)gd->fdt_blob, *blob);
 }
 
+static int fdtdec_get_valid_fdt_size(const void *fdt, int alloc_size,
+				     int *fdt_sizep)
+{
+	int ret, fdt_size;
+
+	/*
+	 * Validate the header before libfdt trusts any header offsets/sizes.
+	 * Also make sure the advertised totalsize fits in the bloblist record.
+	 */
+	ret = fdt_check_header(fdt);
+	if (ret)
+		return ret;
+
+	fdt_size = fdt_totalsize(fdt);
+	if (fdt_size > alloc_size)
+		return -FDT_ERR_TRUNCATED;
+
+	*fdt_sizep = fdt_size;
+
+	return 0;
+}
+
 static int fdtdec_apply_bloblist_dtos(void)
 {
-	int ret;
+	int ret, live_fdt_size;
 	struct fdt_header *live_fdt;
 	int blob_size;
 	size_t padded_size, max_size;
@@ -1760,8 +1782,12 @@ static int fdtdec_apply_bloblist_dtos(void)
 	if (live_fdt != gd->fdt_blob)
 		return -ENOENT;
 
+	ret = fdtdec_get_valid_fdt_size(live_fdt, blob_size, &live_fdt_size);
+	if (ret)
+		return ret;
+
 	/* Calculate the allowed padded size */
-	padded_size = fdt_totalsize(live_fdt) + CONFIG_SYS_FDT_PAD;
+	padded_size = live_fdt_size + CONFIG_SYS_FDT_PAD;
 	max_size = bloblist_get_total_size() - bloblist_get_size() + blob_size;
 	if (padded_size > max_size)
 		padded_size = max_size;
@@ -1772,6 +1798,7 @@ static int fdtdec_apply_bloblist_dtos(void)
 		if (ret)
 			return ret;
 
+		blob_size = padded_size;
 		ret = fdt_open_into(live_fdt, live_fdt, padded_size);
 		if (ret)
 			return ret;
@@ -1781,9 +1808,18 @@ static int fdtdec_apply_bloblist_dtos(void)
 	if (ret)
 		return ret;
 
-	/* Shink the blob to the actual FDT size */
+	ret = fdtdec_get_valid_fdt_size(live_fdt, blob_size, &live_fdt_size);
+	if (ret)
+		return ret;
+
 	fdt_pack(live_fdt);
-	return bloblist_resize(BLOBLISTT_CONTROL_FDT, fdt_totalsize(live_fdt));
+
+	ret = fdtdec_get_valid_fdt_size(live_fdt, blob_size, &live_fdt_size);
+	if (ret)
+		return ret;
+
+	/* Shrink the blob to the actual FDT size */
+	return bloblist_resize(BLOBLISTT_CONTROL_FDT, live_fdt_size);
 }
 
 int fdtdec_setup(void)
-- 
2.25.1

