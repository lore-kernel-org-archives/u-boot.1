Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46306FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 10:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9FB784715;
	Wed, 29 Apr 2026 12:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pD3TNqk/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA3B4847B0; Wed, 29 Apr 2026 12:06:14 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FD788470B
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 12:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso108100645e9.2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 03:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777457172; x=1778061972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Clmv1oIb7H0fe0ZZtu7eDkUi7I+nMi0Dw1zT+YduOHQ=;
 b=pD3TNqk/ESmXHevwGtCODWuA8GZH6uu5hqhGNVesFyF7prYNxDgGFyzbgnkmDpOsGy
 nZEeJa5os67HYqxcfnrgUrOk5PfPC+tN9b6iKrRkCBzjuZWHv+qUHIvXtUKha3AdsuXa
 BiQRiEwebK10SR3g728ZwlvR/JkAaFrYcumPhPnQg+CWC3hMSgwvl/4CM5TAWx6o/u4e
 ICAzWX33Wkp5G4fxwxVwt3ET72US+jh+Xswg3je/O8TW9+DzRFqTOdgJAwJ56UFlfrtg
 zQMTh5xS4YPniyhWo/crm4P0ScDGmpWPitQ5YV6CkWfj2Vp2Hl4JVs+GGyi0/ARoqkEu
 Z+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777457172; x=1778061972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Clmv1oIb7H0fe0ZZtu7eDkUi7I+nMi0Dw1zT+YduOHQ=;
 b=Gv3TcTIGjR25Vw6Lq63QiNfCKEh0bsEzf43YV3VYCeGooH4mucNTf43lKxkb9TEyxF
 w70MbzoNoVCH/az3/vPHREAaQRi6+FU67ajxXZhm7LmlFfP27tYiBFgly6/y14v5saWh
 NyFKorsMc0DB5dUIFoDOtCimzY6UDIcTTrZ7eTLFzHA0/TFLkJCSW5alpLzdjKDwDdTb
 atx7hZHgo2EAO9S+xmWJiqS4u+BxZSX4xTJEzyMkmfIMi46J3ZBhh9Q03iaLUcr2t/fT
 s5JZkKEfKDTb9rI8WMPCqgnqgATF/y9B8+u3tE2erlHhvmOpbQcdPgBV5V712aSv5Bvl
 Souw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HPfxkGr5aPQd0c7PvpUFv03Bpd5vqU/19lZVhfxenkjmfFUnmuQOLb7+UkWrpfdl7B09HC0A=@lists.denx.de
X-Gm-Message-State: AOJu0YzpCOM8I2NaCBwxziyVCnUFlk2gd+BGlECB0lgsuIWknS4OP4/y
 oG/5V/mh/Rcb4wMjL6i17pFcrYz1t8zwtTV3gDFceL0WYV8g8/9sFi97vs23bw==
X-Gm-Gg: AeBDieu7WlJs6nDSqZxfuhDKAIe7Ck8F6zZ4eI2bKUYL+5OmwEt58XMyjB4n0+sxtZI
 lPP6j04BtVczEKeXCupGSE+dIR0VhMwMZ9EwYIRaE6N/7SAGxmrosstifxIpp193p4ySF+YKabv
 ZU00eJk/9621pHEvbJgqHIK3bOPrMX+Lg1M+VvCY9lA2MjKdVUWkNRIanSUwbObZ3XSKOmNx6TE
 mjkEWb4YxsK/gc/i1ucc3A+zPzCgNQ5FbtAxKUVwkS1Pe+ACv75RhvJ0f2gyNUI1MAgRoPman5/
 wZFrF2MPYj4hemrJAuPYRrvSxpi4AKRRufHB4NVujAG6fyPpgINT9uThQS6ndRXW6Msc0fsWdOr
 w+Q4lYuMImJ5RjX5gy7tkLUXZdm6+OrK748OYV8Gs2Ce09SHNXjtaM9VAEyh0aLzCgeZ7BejZOa
 RHG+cOAqdNPtCl84/nCDlxDh6mlTWniQk/Ir08K1K5o33SGZJoh8lRrsjvJIi4kTr/5KjnNPgmj
 L6wNZjt83A9GpgrniOYTT+2DYwgvGkt0RTu5DGlgDR5MZgr
X-Received: by 2002:a05:600c:3541:b0:48a:599a:3716 with SMTP id
 5b1f17b1804b1-48a77b19ce1mr112873955e9.23.1777457172024; 
 Wed, 29 Apr 2026 03:06:12 -0700 (PDT)
Received: from emanueleg-nb.homenet.telecomitalia.it
 (host-87-2-163-213.retail.telecomitalia.it. [87.2.163.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b912ee3sm27229845e9.2.2026.04.29.03.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 03:06:11 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v1] common: memsize: fix occasionally failing alias probing
Date: Wed, 29 Apr 2026 12:03:56 +0200
Message-ID: <20260429100400.2860345-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

probe_ram_size_by_alias() detects whether a probe address still aliases
a lower address by writing through one address and reading through the
other.

On i.MX95 this occasionally reported a false non-alias when the alias
read happened immediately after the write.

A memory barrier alone, mb(), was tested but did not make the failure go
away. This suggests that ordering the CPU accesses is not sufficient for
this probe, likely because the issue is in the path to the memory
controller rather than in the core itself.

Read the written address back before checking the alias address. This
appears to force the write to become observable at the probe address
before using the alias read to decide whether the tested address range
exists.

If the readback does not match the written pattern, restore the saved
value and continue with the next check. This keeps the probe robust for
addresses that do not reliably retain the test pattern.

Fixes: 0977448b45e2 ("common: memsize: add RAM size probe based on alias detection")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 common/memsize.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/common/memsize.c b/common/memsize.c
index 3ecf9bac2aac..fd22f85a164e 100644
--- a/common/memsize.c
+++ b/common/memsize.c
@@ -145,6 +145,7 @@ long get_ram_size(long *base, long maxsize)
 long probe_ram_size_by_alias(const struct ram_alias_check *checks)
 {
 	long save[2];
+	long pat;
 	int dcache_en = 0;
 	long ret = 0;
 
@@ -161,12 +162,27 @@ long probe_ram_size_by_alias(const struct ram_alias_check *checks)
 		if (dcache_en)
 			dcache_flush_invalidate(s);
 
-		*d = ~save[0];
+		pat = ~save[0];
+		*d = pat;
 		sync();
 		if (dcache_en)
 			dcache_flush_invalidate(d);
 
-		if (*s != ~save[0])
+		/*
+		 * Make sure the test pattern is observable at the probe
+		 * address before checking whether it is also visible through
+		 * the alias address.
+		 */
+		if (*d != pat) {
+			*d = save[1];
+			sync();
+			if (dcache_en)
+				dcache_flush_invalidate(d);
+			checks++;
+			continue;
+		}
+
+		if (*s != pat)
 			ret = checks->size;
 
 		/* Restore content */
-- 
2.43.0

