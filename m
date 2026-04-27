Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2610FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 10:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0B6284106;
	Mon, 27 Apr 2026 12:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MEKleEI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F2A83693; Mon, 27 Apr 2026 12:08:50 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1D70839D9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:08:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-38ddeb0f5abso75746061fa.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 03:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777284527; x=1777889327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVSvjt5gakPp4jdgQvTHZYJ6DsmY1xqBmtYmGCEuNKg=;
 b=MEKleEI5lC0XRQiVtat5qN76xlCKQ+uJw+Ro/gdpV6y7PaGypBgNeqQQKTvl9s/5v4
 6U6nUWsKANQIu6jlR2Q3WJfsD4aAHv/NXgHjc+La/T3ntNkzevlCZnLhz+PRSyywhj6u
 uhZ3cKBKZczzEA5Bpy9vrFw7bP5ZVKK3Es8l+zPm3GIa5ZtD2M0izjFTgdGdEobGiHQS
 vb8tC0+ZkxuqTnr/xSa4MyNN3k+fmSwwFQrTFoTs1BdJX8ZVxjz9p52uL9BVYZfiUGVI
 44Oh0OF72IGJ/nhA3mN8o1twMMOVdSGipyM2IFZ/E0t/Q1MUT8vuaP6dIn/HBkNBjUT9
 jmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777284527; x=1777889327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GVSvjt5gakPp4jdgQvTHZYJ6DsmY1xqBmtYmGCEuNKg=;
 b=W73g59xVKJdnlJHKD2tOySTptkO1aQZ6HI8q7zs/PGbN3hfnOknyo28c1+X8ewWOjC
 xWYW3kS81amRFNAia1ZIm9w8Hhwil1NkwRw4swra46aAsHEqOD51KjMe95Ya56vu3B0m
 2ETaLGy058u3qFdgqv05Uo6MwSBZ6ub+4O+UZR0dLYREhWPRbPmVA66E0sgmWyQ4Hv1d
 DeIIHwRg4BlaG9bX8vPdvBFOBq3hHYzmNTBqF20lm8cQCOyBbieAlTQGFUyxek7ZSHcc
 9r7/0R7jM9ohtTgXI2i6tKWzGQnbi6kogiaoXUgGrAJ4NhPK0q3YydZUd8UK3/5uxCnR
 wgYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hD8nJrRFdTFuvNEVcigou6C1Zl8jdnsD2umSN7Kf3l1bjx10Tg9hjQAcv4wbUfmpRFa3fgNk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1og3YNoSKL6Lilq8OQk4Sn8XuRC5pb7a1OFMh2tTsH8pW2SaO
 aT1PVAdRr88G0LbSa/XqYnrpK7CLDn2LyIpgG7jl7twSgJbRQCbkP+ph3kzud5/GMQk=
X-Gm-Gg: AeBDieu+VJIcrDyCSSNbrMt5rRDyu0ayjKF+vKdGs9WSAZBJWjfpHpBVGPFXUL7AMXh
 EPNt1fhQ691c8uAx/k4SBQzfmAhrtAitC8vHP/lDGJlTPLHlcfArrdpwoR/J3yIlu7szDxK1Xgv
 xrJngXzECMAYwsr64CWpuyz1nQzbapbsUG4kCDF8fooid2MWyeW3YIoWiX6zmOS+tVPG8h2Imd4
 z4MmRlMwqONsWJLZ+wP+PoCBt5dCEJLciItenUg9ICIhVcXKrD2pVqG1BRLCfh1WCzze2yDWWw2
 XryBFh2GrbPK2qEYcNiVfaVV/slqWoq4AwjAPChDTNpAsxSqU1DHBpfHqZWCEOBnAD4Bi6cqxoz
 cVxz1bV/wMGL6dWJmIqCC3vhhi/d9gQo/9SDWc4tyBTHBSxtKWPlJ0wpn2By1Yme7FcGDj75RSk
 tu8LvHfE1mYxNetmUspStL33RtkNBj27sQKbdHxmY+TCZuytl7D2nHsnk32Rl0PIDhRl1cOTCi7
 K3w1Ja8Llc8VxH+XcKStwIU7G+rvzxJU80wT4Hx/hUKjNawDO4hnCSLf7tINS4FNincv6PT9WsN
 +shmFLRDeafM2vJEg4ZYZhye6RtTxv2DW4DjRtG686fFmVUXIn7xMTMCsqjMX0MOxeWpFvyUExE
 Y9wdLFNjy8RYwpI5KJ8mrT7dSOdfm55Rg9P4/0uQEUSn+BCjOwnVvpJSX7yA5Oe6b99vCKtY5Lk
 bW9oYAMvaldMy98Xl3gDEuc1L1kr1Qb6Yzn5XOt9K12xjsNj4QTDigGy+am92v1/aRTz974TO1T
 JaQIjwvw/21xKbt4mamg+t0wEHosg198Kgt
X-Received: by 2002:a05:651c:b1f:b0:38e:8216:13f9 with SMTP id
 38308e7fff4ca-38ec7ac74c2mr136432101fa.26.1777284527128; 
 Mon, 27 Apr 2026 03:08:47 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb6f0b88sm68554791fa.27.2026.04.27.03.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 03:08:46 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v3 1/6] fdtdec: Deduplicate iterator function
Date: Mon, 27 Apr 2026 13:08:22 +0300
Message-ID: <20260427100832.581887-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
References: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

Both fdtdec_setup_memory_banksize() and fdtdec_setup_mem_size_base_lowest()
implement the exact same iterator over all memory banks, the only difference
is the body that is executed for each bank. Deduplicate the functionality
into iterator function fdtdec_setup_mem_for_each_bank(), which takes a
function pointer to a function which implements the body as a parameter.
No functional change.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/fdtdec.c | 77 ++++++++++++++++++++--------------------------------
 1 file changed, 30 insertions(+), 47 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 90d34ae105fb..01be5edf7484 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1114,7 +1114,7 @@ ofnode fdtdec_get_next_memory_node(ofnode mem)
 	return get_next_memory_node(mem);
 }
 
-int fdtdec_setup_memory_banksize(void)
+static int fdtdec_setup_mem_for_each_bank(void (*bankfn)(struct resource *res, int bank))
 {
 	int bank, ret, reg = 0;
 	struct resource res;
@@ -1142,63 +1142,46 @@ int fdtdec_setup_memory_banksize(void)
 		if (ret != 0)
 			return -EINVAL;
 
-		gd->bd->bi_dram[bank].start = (phys_addr_t)res.start;
-		gd->bd->bi_dram[bank].size =
-			(phys_size_t)(res.end - res.start + 1);
-
-		debug("%s: DRAM Bank #%d: start = %pap, size = %pap\n",
-		      __func__, bank,
-		      &gd->bd->bi_dram[bank].start,
-		      &gd->bd->bi_dram[bank].size);
+		bankfn(&res, bank);
 	}
 
 	return 0;
 }
 
-int fdtdec_setup_mem_size_base_lowest(void)
+static void fdtdec_setup_memory_banksize_bankfn(struct resource *res, int bank)
 {
-	int bank, ret, reg = 0;
-	struct resource res;
-	unsigned long base;
-	phys_size_t size;
-	ofnode mem = ofnode_null();
+	gd->bd->bi_dram[bank].start = (phys_addr_t)res->start;
+	gd->bd->bi_dram[bank].size = (phys_size_t)(res->end - res->start + 1);
 
-	gd->ram_base = (unsigned long)~0;
-
-	mem = get_next_memory_node(mem);
-	if (!ofnode_valid(mem)) {
-		debug("%s: Missing /memory node\n", __func__);
-		return -EINVAL;
-	}
-
-	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		ret = ofnode_read_resource(mem, reg++, &res);
-		if (ret < 0) {
-			reg = 0;
-			mem = get_next_memory_node(mem);
-			if (!ofnode_valid(mem))
-				break;
-
-			ret = ofnode_read_resource(mem, reg++, &res);
-			if (ret < 0)
-				break;
-		}
-
-		if (ret != 0)
-			return -EINVAL;
+	debug("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx\n",
+	      __func__, bank,
+	      (unsigned long long)gd->bd->bi_dram[bank].start,
+	      (unsigned long long)gd->bd->bi_dram[bank].size);
+}
 
-		base = (unsigned long)res.start;
-		size = (phys_size_t)(res.end - res.start + 1);
+int fdtdec_setup_memory_banksize(void)
+{
+	return fdtdec_setup_mem_for_each_bank(fdtdec_setup_memory_banksize_bankfn);
+}
 
-		if (gd->ram_base > base && size) {
-			gd->ram_base = base;
-			gd->ram_size = size;
-			debug("%s: Initial DRAM base %lx size %lx\n",
-			      __func__, base, (unsigned long)size);
-		}
+static void fdtdec_setup_mem_size_base_lowest_bankfn(struct resource *res, int bank)
+{
+	unsigned long base = (unsigned long)res->start;
+	phys_size_t size = (phys_size_t)(res->end - res->start + 1);
+
+	if (gd->ram_base > base && size) {
+		gd->ram_base = base;
+		gd->ram_size = size;
+		debug("%s: Initial DRAM base %lx size %lx\n",
+		      __func__, base, (unsigned long)size);
 	}
+}
 
-	return 0;
+int fdtdec_setup_mem_size_base_lowest(void)
+{
+	gd->ram_base = (unsigned long)~0;
+
+	return fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_size_base_lowest_bankfn);
 }
 
 static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
-- 
2.53.0

