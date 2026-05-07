Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4A8CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 19:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA19384C00;
	Thu,  7 May 2026 21:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kACYKokt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88FF584BF2; Thu,  7 May 2026 21:58:26 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF38384B58
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 21:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b150559bso9872465e9.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778183904; x=1778788704; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jHXEvYR3IkuEWMIU2Q/QFGu65N8K3C0Cc/OykN25ALQ=;
 b=kACYKoktcgT38TrP6PR0ufGw7jy9xQUDcq+dlf0gGQsM3CCCWXBxwLEwLSRth9Vzjh
 YaUAl7Bnye6N19xKiDOtN//YEtMvoSsGJ8YJoCjY5OgO3vafYOB3r4e2USGi0Tr+Nkd3
 qCoQZJZTax0KN+HomN/51cXcKj8BL21iU7BetsAbU2MZnlbEO+75BmBC+zbbwhXWZ1zj
 bI9pSViS6kI2fOnsdy8iIDLLLCaDqsUuUrbz6NRHKXGyBxRQGI8MH5xcY9+BoMwOJ2kK
 84FGkszj1darGjqN8r6jX/1Ku8hBMW70vObRoF1dFqS11kl/1tI49dWZcjfUi0n+5OJx
 iQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778183904; x=1778788704;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jHXEvYR3IkuEWMIU2Q/QFGu65N8K3C0Cc/OykN25ALQ=;
 b=YBS+gzHvWys+IMpvJYygFyO+k1MAiN0dpctLAiPw8N9xGCrIJII3GiaXgRpV9AFk3S
 GZybo4nmyFc4biH0NxedCe0uJk5dnCDZH4ZV3Cx9pflOdpa47gjr5PPGGhR/gcUQFkf4
 4Y7pxxSO90THjRYlfNNWKoIih8LGGDM/R6T8T1/WbUjHr/Rs2pCuLyUNskwob/I795DU
 6/OF0AgKT+uGPeY0JAPArKNDzblE55+IZtg6LeGXu6rbuenO26BYmGZpkGgOfAck5Cx7
 EzWkj9s9zCJvjcw3Odh7ynYQlTcb1dZSDkD0KgYtl9hwRVK0DRQs/eDA683tCkKbZy8P
 xI0Q==
X-Gm-Message-State: AOJu0YxEBtinUbSM6ObT5pDlegzKjV66cgWc4Ng7T185lqJ/M6aEBhS3
 C30Bdzm5cyMzIV4YbWO23ZLTaZjCmFBOMp88FnVn6zRO9RbnlUUN4UMUzFCnNMibCRAu4zBayta
 j5QTDcoY=
X-Gm-Gg: AeBDies4FwAG5xfRfb8oiQMXADEir3CpOfkorUMWhZU1Q1R7UnBuOp7PgHoMUnnC4ne
 hMYmWYk9LSoIGlE6BgIbfZZV6FO2u3ThzGr0SF1fGj1YBsQi35HkqM0GaAZ+HZ7wPwGlbSMGYT4
 2iLVnO9eiJD/TK4VnldrQGl6vMn4HGRJ3B4B+Y7YwIE79BFCzKa3gFjpxZH2/YyJgEYBNrb6pRd
 6rmXC+96Ow5fBZdvx+mGBSH57D9pVgqupk0T5su5rkq7p/4D/xRNlvrQBn3WW6mDxhKQJHkvBMU
 QJBqPEmnMW9f3wJhznfSo+FDbsRCdJMm0yFdMwKMvf3aFn1V8woWaqSGaT3y/G/tAEwRqDEHbh5
 tU6JQ6/WHfZ9oVkcPEAQcjRi9Urlhr1xXgc5O4gJlWNFKE9V5MbDBqOSjhy05p/1rAcdMa8/8Si
 3j+Qc+A27EzYWm87Ih8AcD4Yk06qvAaN7/6GuEGLMj5vl3QO8JvP8jSGAmKtQTk1AB16oG
X-Received: by 2002:a05:600c:3e8d:b0:488:bc6a:528d with SMTP id
 5b1f17b1804b1-48e51f40b12mr160788145e9.22.1778183904125; 
 Thu, 07 May 2026 12:58:24 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538d2878sm235344265e9.15.2026.05.07.12.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:58:23 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 07 May 2026 21:58:09 +0200
Subject: [PATCH v3 2/4] armv8: mmu: teach the pagetable dumper to show
 explicit FAULT maps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-b4-mmu-unmap-fixes-v3-2-aac7726d87d5@linaro.org>
References: <20260507-b4-mmu-unmap-fixes-v3-0-aac7726d87d5@linaro.org>
In-Reply-To: <20260507-b4-mmu-unmap-fixes-v3-0-aac7726d87d5@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw/724zpJWtO9B0a9XsH8ef1lRF5R5cn/JOw/yMnWOjz
 UrlzC3HO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmcCGcHEKwETyrBj+qe748jtSKV9BziTS
 UTpjS1ueebrwpaPmX6XmWbJcyiwMZ/jvMjHOuLI502zj5deuSldvPbX+fZtzvXFepvW2qKv3Khv
 ZAA==
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

