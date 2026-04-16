Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401D7F433F7
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 06:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 311F184206;
	Thu, 16 Apr 2026 08:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="USypUPpU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 089B584206; Thu, 16 Apr 2026 08:00:12 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A55483C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488c2690057so76093375e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 23:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776319206; x=1776924006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zIRukHnnD2yRthhxfE5asPyAnbq119C7lGxwUlkI2W4=;
 b=USypUPpU5HE9kES0tjNojaEc5ORTf6sDagU1PufnQ5F+ROgggzPYgJJ/hSs6P2avkN
 1pd0I44s1Hx381cUsmO18xWn8xTctRyym5OySP9d9scj0X+sVxV7BBsk/ZMShhGX84bu
 WutmhBXiuSFcsBsh9+omybEBQbtIxoe6RaFi8OT9rfgyyRNAfVxIHC0NR60OHrosMTgo
 /Gm5GDY8I+sSfs0KdU0sLU2N8uidu9w19/EvO0kGsWZRdIc2mCZtidje7NA+C+ipQp2e
 8CJ7Ii7pdLoH/74queAJrqEP72abD1GDPQgyeoUramiwLYjkJ8rAWbC3RJHrVskTQ1kj
 Pk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776319206; x=1776924006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zIRukHnnD2yRthhxfE5asPyAnbq119C7lGxwUlkI2W4=;
 b=AMLMcPlIGFtgm0WuDTnM1eizZq92KCFpePCfYc3/RcN+h8TN4jVA/x7ByHdbEGe1kv
 kzaduCKZ3ogBjVGd38oWhX6Tm27DofShLYfW8f9aFltVxGt6UGerllFYB3fmoNq5XIBM
 tRXhmWRmC+jXy03vHzQSZV/qcjHTleILtSaT2znxMJ5tDxd8QcEy/Hrl8uSpN/rhQBzZ
 HhQo1wCA/PZllG+aSEdvjAyLxZ92JrpJOJZSy2H5qtugryH3O4PNy9WXOaBajLCcdY13
 3/nO2WUWh97oLGM3OTZhH61znKuxXDtIwYCUNjQwjOEY0OUCStvOCIT8f5Uphvs0y2wB
 SYMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UUrlBNztjqnjv/tUellyDSjFmqA+lKMHFmx6ueB544HSNEKDJIc5+2ek7zV2E1yexK3BF6EA=@lists.denx.de
X-Gm-Message-State: AOJu0YydUPqmRWdnS3F/WS32prhfqYeICvRL9r5qT5EyMJz3854rYrr1
 cZmj2Iz3wc1uGEsvVTnaz1aOWKpx2NXEjsBcXTnZU+fk74z48Ut8ENhY/2yw4hKXvPs=
X-Gm-Gg: AeBDietuBpkfAL0R0E6wcbwVlNtpl1HTt9pBZMt7ZVaR8mjTkISrZUUacBqpHTZnA8w
 4gdca9SvVodHtX7K2jJJEDogORut9Y5elPajN9NxhVz/UvoFVcKtQX4oXR3RDgZVU7Db8k+bBVn
 l3785JY7NTos+yHTP5nGu3n57cyHMiAPI181UFZRgrOwQGBMzJ+m8qVg9nNiC9lfUxfsjRTOYmh
 8ugnPCtsVdBW316kTz6cwV7VgLZ6Cnf0p0dU1i/5z7cBOlFEBc7VTu09JhomszXqWVIMXBv5Ynj
 GezfzwU+0L+1Swuu6WT8Xx+HDwE/T4xDBsQXPSk0oyxq2EHm0sYfQ2EVfrUPQxao1M3VQjNGCIl
 +T9wAGb+H2Uzwrukjzoc0L5F9ee+LkPMFSDOyp2xuzOTuVzsiLtYWsjOVcXORxxtnW3aMfJAMlZ
 PUcQSSBcxIa1USK8VJDsw0YgqGPD0A4WZL/JyQ/0cy8caM1f2YibZ0NChH/WZsQOXbq15AJ0j7s
 pKeP1oBf19aniBL5NRW/zywcT4kasYLS97UdQZiUpG39K1ddm8Q03rsAKp36RqPNiyIjL1qhjIa
 3cFh5GXiwDH1LJ/Bq1TR79RciV6rCR86Shh4R6nSaF3HikS7IjAD2fJ4Leiz50ULRubmBHZBG9W
 EbhR4MoOep89VdxOekFD/Tn/ddP7GMKwOJm7k99CgrC4/vQk91Ihg5bZOMPI8CVIQVASMmpaTp8
 7Q869vXfECAcpgfYu1YjO42i4pPNIqzp/kqeqCWEAkEh71yE23pOdnWJr3p8iI
X-Received: by 2002:a05:600c:8b84:b0:486:ffa3:594 with SMTP id
 5b1f17b1804b1-488f71cef2fmr1598335e9.23.1776319205445; 
 Wed, 15 Apr 2026 23:00:05 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e9a770sm36379755e9.19.2026.04.15.23.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 23:00:04 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 1/6] fdtdec: Deduplicate iterator function
Date: Thu, 16 Apr 2026 08:59:37 +0300
Message-ID: <20260416055948.130041-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
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
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 lib/fdtdec.c | 77 ++++++++++++++++++++--------------------------------
 1 file changed, 30 insertions(+), 47 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index fb3375ea157e..9c35b08e709f 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1096,7 +1096,7 @@ ofnode fdtdec_get_next_memory_node(ofnode mem)
 	return get_next_memory_node(mem);
 }
 
-int fdtdec_setup_memory_banksize(void)
+static int fdtdec_setup_mem_for_each_bank(void (*bankfn)(struct resource *res, int bank))
 {
 	int bank, ret, reg = 0;
 	struct resource res;
@@ -1124,63 +1124,46 @@ int fdtdec_setup_memory_banksize(void)
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

