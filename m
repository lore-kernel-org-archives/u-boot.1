Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E09CD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 11:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80D0B83E81;
	Tue, 12 May 2026 13:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NTxADHD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7806A83E76; Tue, 12 May 2026 13:13:17 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A6CB801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 13:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-44a14580111so3982691f8f.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 04:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778584395; x=1779189195; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jHXEvYR3IkuEWMIU2Q/QFGu65N8K3C0Cc/OykN25ALQ=;
 b=NTxADHD/v9X2ZahM3i6C8v8U721engOu1MHKn5a3871o370dkyhteeP/NB/+MMxpvp
 1rd/hQtE3kn6yopcdzIHhWmzoe0oweIbKm2i5oBsKTrON4yW20cvK7qbntDbjDZaMahT
 OcTpyfQqM0ZH4/txp73rLUqwvBBdIjI8UfGqQOLwNUdofU9up+gn3cdp6XDU6jwFOHrY
 bbHfAbVkAprA8kNQOYdcIOcft+9Z0kTKIqqpCeDepcczUtxukpBZDGL5s7zZJdsAJv0w
 AAkoXs//QgLkKukbOfpDnDLeMq0ppzxBGZY7l67hBt3KEQy7QWMHtMQwkNdEvWzhnjqJ
 bEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778584395; x=1779189195;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jHXEvYR3IkuEWMIU2Q/QFGu65N8K3C0Cc/OykN25ALQ=;
 b=fmfCclF0kEwnbZ9r8HonWTRBUKDDem3H8TsQ/PhJ+aJYMzwL7bsRwR5D1DOmpWFeO4
 bOXT+DWl7Q2WtpoYpUs3VYrfCYFo0rRHcmGArfImQedBHY8ZSU+HQTwVsrURVbZn9ESr
 4wHxfz04C3prU9kiqRj0KsK4as5Gxa9tVuP5WdoJ2Hzn+V4syUBnxafSh3wuLhQVvyYN
 IcvRrPQxcDkB4JV1ik19uifCmB+VCdARF1z9ObaiAyIBlrwsdA56gIurEpIGk020x7/f
 dfaKvnSMZz60YPwNDj9SjJF0Z5kQXe5hWpoPf+AN2oGIef7S2nKQqEhLxhTiKVvJ3nR3
 WtOw==
X-Gm-Message-State: AOJu0Yz5DtHtekdxetXrwNi7kXFTkOmUXAps6xliVAzQf4oT4mbUG9Gz
 Q4RgVS6JcpXyioohQcJq32d/9Cf0lhO8x3YmbJ0Phk4E/+WliBuJCiH5pU8bJPd+r64=
X-Gm-Gg: Acq92OGPNzqGOG+Ib45uxdcalNfCJWF63ElK/KOZzDrLsLYcVYTjQuRAuAoaUKXN5Xw
 9TyZtwJJtLfAmk85KPR0JA4+p+Za6rAajys5Y+GRd6jo3FQr4lwKr98wZJkaNQi7WXHRUNPbhci
 5hC8O2OzDzG/pWdMxSH1UUwwjLw69EzQ8QLIw4gq5gNyGwWzMPvoG9CXWbRUzWwRl7scwQfq+l9
 xtjK+Ck71Dj2EKz6L9+sZilH7PN69qXZgaRhUCJbEwb2B2azJDP86x3emJGZ/cpWfvlHxDVcuHD
 vcYqcNqPdNqsvlnEB958IKzHrfONGd9BYMARBvjlc2gjbO0GWHPW8ZZ3/yNnhrRoA+wZAMcOfks
 6/eyyy3erCKRDhWU46ThWjVZne/G0d2bchl3Mil4yskpp87lMjuUEH1HWaYu1gkQatRQLdHnIcF
 +Trv/McnBfS/khSwW14OtV9YUKg/VPx87DCoGNraatlXw6qyZa4oG4VHJEzxwwpPTkSkBd
X-Received: by 2002:a5d:5f42:0:b0:455:460a:33a5 with SMTP id
 ffacd0b85a97d-455460a3511mr24415543f8f.34.1778584395013; 
 Tue, 12 May 2026 04:13:15 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6b00fsm35124259f8f.11.2026.05.12.04.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 04:13:14 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 12 May 2026 13:13:11 +0200
Subject: [PATCH v4 2/4] armv8: mmu: teach the pagetable dumper to show
 explicit FAULT maps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-b4-mmu-unmap-fixes-v4-2-fab802f647c9@linaro.org>
References: <20260512-b4-mmu-unmap-fixes-v4-0-fab802f647c9@linaro.org>
In-Reply-To: <20260512-b4-mmu-unmap-fixes-v4-0-fab802f647c9@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Fu7kjOhau2q2gnn/gGhvZs7871UvGg5NlOdRHBQT9FY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhixmbrcLeuwHGL/vfRPwKvPeTs4Pi5sO9xWzM7VOsPUuX
 cTHqpnaUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACaiNp2RYcs7RrOPTNqTTj/J
 beDOPs1ix/l+qZ741G/f9CqCIrjC+hj+KToXltiY8X60NWw5o7hGYf6qWu//DS4nLdZP5V9u8v5
 tJAA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

When a region is explicitly unmapped (like with
mmu_change_region_attr(.... PTE_TYPE_FAULT)) the address translation
still remains but won't be used since the region is marked invalid.
Print these regions when we dump the pagetable to help with debugging.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 368c622cd18e..36d337378fcd 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -533,9 +533,9 @@ static void __pagetable_walk(u64 addr, u64 tcr, int level, pte_walker_cb_t cb, v
 
 		if (exit)
 			return;
 
-		if (pte_type(&pte) == PTE_TYPE_FAULT)
+		if (!pte)
 			continue;
 
 		attrs = pte & ALL_ATTRS;
 		/* If we're currently inside a block or set of pages */
@@ -572,9 +572,9 @@ static void __pagetable_walk(u64 addr, u64 tcr, int level, pte_walker_cb_t cb, v
 
 			/* Go down a level */
 			__pagetable_walk(_addr, tcr, level + 1, cb, priv);
 			state[level] = WALKER_STATE_START;
-		} else if (pte_type(&pte) == PTE_TYPE_BLOCK || pte_type(&pte) == PTE_TYPE_PAGE) {
+		} else {
 			/* We foud a block or page, start walking */
 			entry_start = pte;
 			state[level] = WALKER_STATE_REGION;
 		}
@@ -707,8 +707,12 @@ static bool pagetable_print_entry(u64 start_attrs, u64 end, int va_bits, int lev
 {
 	u64 _addr = start_attrs & GENMASK_ULL(va_bits, PAGE_SHIFT);
 	int indent = va_bits < 39 ? level - 1 : level;
 
+	/* Ignore empty blocks */
+	if (!start_attrs)
+		return false;
+
 	printf("%*s", indent * 2, "");
 	if (PTE_IS_TABLE(start_attrs, level))
 		printf("[%#016llx]%19s", _addr, "");
 	else

-- 
2.53.0

