Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAAACD4F52
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 09:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A80984664;
	Mon, 18 May 2026 11:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i4jbjGR1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79E9F84683; Mon, 18 May 2026 11:00:59 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CF7D84150
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 11:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so14261315e9.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779094857; x=1779699657; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GLznvzcIH/VdtHlggOIe431Ib2Wl0s2F6rggmNnn5Dw=;
 b=i4jbjGR1CVtkHUZGQQpuZ7aVmElX+kZmOZUKGIe1yfgETG77KcPh335KXQWE1ceM4V
 UYMccWD4o/E8Er5FI6xR05VfPzK0BEr/307+IpgKuiikQ1RcszzE6N/o+sZhLWwfAO3f
 lRvw2lCO2yyPBcyp2SfEkDI4wdQ4xYFEYHjjluUifE5YGCwyMJfEM8je+KGYz4soZp+w
 pjxps1U5bptfZSQuVnE7AaaxBEwRKpHKKut88IJpnRNx5LzFFneAknPTv2gK+DWOlV6p
 ukse+zYcZ70Ieyq2IsFwzjbBG9zzkV4iJF8cnD5tUThRxjREq6C0CEPahcBoyMZ+g3Jg
 vBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779094857; x=1779699657;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GLznvzcIH/VdtHlggOIe431Ib2Wl0s2F6rggmNnn5Dw=;
 b=T7Z6PqDTWo7S0qQko/iuL702R2kBJfoLH2UemhOa9pZR3lAd8e+K8bVV3RFCjVhVBq
 +VbsJ/ss2jGN/l3QCVLrmXaLbIX1lHNZrAuBlxBTO9e9/XZK9ci3n23LMd7dNkDe/Eao
 a4SEZ+H1IQacq4LC4vmY5LhEmfg8FVLkdYaRuKa5QD4/FZtZJ8t+s+R1eTNMcDhQbs/f
 Ud6qB/EgLhS2ADS4cQe/uYr2itWzl2BFsIslt4y5uYA4ndXH9f9HVe+N1yOHOAKI+iDe
 4CUXvQUK5fxZznSi3f47AHrbXvqDOCy0WE0trNCjL0WTFtf75K6+6qE0XbirJl/Sqkb1
 ZTRg==
X-Gm-Message-State: AOJu0YyDBbYsI8TMpOIxqwSpirUft/dhPnepr0EFhSfv/gWLfNlGV1B4
 UhoCiiX4qhPrj2v+2p8xhlQ0eMlmpIVw0wY9m2p14qBYLYF9lsrXx1wlnr4jObFOnAQ=
X-Gm-Gg: Acq92OGehcnn4hw219OhT1u1gwOVyfncwMi8c92enaHNOx9J1wB8W7LZKahHUxn24eU
 gisM5xlLCtHkeXQVBkmj46Qcg/hP0yZv/ZBLZ8ZBBpDVMWNnkH7YVPnujoOHouwJxv/VQU67w0L
 EsgAvsy3a+WmKMBDOb4fTyqlsDsfPCAfNlFWPzuPhsIOJfva/8OSK2jc5iavVHMLGiQNiOQ0mq2
 Gph0Cc424Ix+SR9xq9pBQBRp8BPEdTKxs/HACq9Bc0mzXfzuKa8FOLewB6hhva319ItMtSwkt3D
 rxJHa6+7V2oqw6jxPxaANMTVMldKUWueowGwk5+9v9uwmFTqJhP5+m+3K7eplqrgxJ3HdenYPqA
 pMx7xDvBn9UITjyEoPkV6O0l8diVIk6VYp6gIit/Dz1H0R8I6OybM2MOTGf4EEO46LgWw9HENZn
 G3/rgBKrme/Qlu2KVrUm4lYdAma0d78as9W7cSaYEYj5U37KCNv8uNXSELp002ofxBLHg3
X-Received: by 2002:a05:600c:858d:b0:48e:82b4:b54 with SMTP id
 5b1f17b1804b1-48fe6514873mr169291695e9.23.1779094856804; 
 Mon, 18 May 2026 02:00:56 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab3977sm265269425e9.9.2026.05.18.02.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 02:00:56 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 18 May 2026 11:00:51 +0200
Subject: [PATCH v5 2/4] armv8: mmu: teach the pagetable dumper to show
 explicit FAULT maps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-b4-mmu-unmap-fixes-v5-2-7802245a40a2@linaro.org>
References: <20260518-b4-mmu-unmap-fixes-v5-0-7802245a40a2@linaro.org>
In-Reply-To: <20260518-b4-mmu-unmap-fixes-v5-0-7802245a40a2@linaro.org>
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
 bh=Aqt7QllEVl6IVGVZ1mAxAjvPtBso0Pihph0PTz7aJRY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhiyuqy5PAhc++MXuNn/SPJuylC+vI2MVnQwcu6fsyLxua
 K97a5pXRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIotMM/3RdZonrPZw8d+1c
 M+li1029vgfvuH5q+LSbdYn8D+dc3m6Gf7YrBc/dyrT4b/zp8adPlcdNv694bly0IDpqnfvpHx8
 25gYBAA==
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
index 97a1c39ed268..2800ba57a464 100644
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

