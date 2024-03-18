Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0436FC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 19:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33EC887BC9;
	Mon, 18 Mar 2024 20:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="dVVWAwVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F89187F0A; Mon, 18 Mar 2024 20:35:57 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE28879E8
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 20:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ptosi@google.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-513a08f2263so4915636e87.3
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 12:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1710790554; x=1711395354; darn=lists.denx.de;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+4dPW9inF4sGTDbNSx6omyqt1ELiq/g4Amr8Sh4eMw=;
 b=dVVWAwVaV7xOiQQKITIJTJBJZyQgWzgGs2cjzWRTue+byK0gTq34STgBtvyYum+nBL
 PY8FG4VwqEHHg07t7LxMCl6PV7oti+lG7snwfGcHyFOQle5UX1BWaWcNcdpfuSNcphzi
 lQFEj5bqdjhlpYu4bWAxfrQ1Y6LR2JDWQI2BABzEl6xfeE4dUZ05l0wXswDDEyabLvCs
 DSpdbZFnEgcyIXjaVtvaeWiY/hytuMkUyU9u6rEed4e9u3Sqfw26iglAYpaVFhrcvzsH
 IJsLmCUl5SGLp3+K21EmeMRt1WYCzfPC72tzzovn7wT8cTdwpUSZGwoT9+PXJp7uM96m
 oAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710790554; x=1711395354;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n+4dPW9inF4sGTDbNSx6omyqt1ELiq/g4Amr8Sh4eMw=;
 b=CxgmGpfP1RgdGD3xgKJ1JbxFfkAWHLPa+VvxZCC518SmNMsGA/YSe7G7zpJdqkcBeA
 p6Hn7xZA3nuuVWlnuh/BAGrVcpouKcp6KWCiH9600z6qFvtZKHVSxdKOhGaoetAalp8j
 6z0m1SfeoPbe6Mrn4Hc9ghSITRRwFsYY84GGi08zNUeup00ha8KRvVkFX5MDzqloXC+x
 gImy9TK2tK4dW9tGNuRnTUr8fOYoCvU3co46hMbaUwnds4SWFT6noizGwOPNIDYZQ9h8
 VDusfmHX5txA4JTFbMlKXwu6pH8gnzKW2S5ClbqIzFm/TWbwi9dt2zKZ0nkfqHK0AeaH
 jdcQ==
X-Gm-Message-State: AOJu0YwGMLrBe7NFDKZ7PAL4BnQy4F6aGbkJf3hjqpJJ8/STKydTgwmh
 BheCq+VsDQ4I4Mb9anw+g5HPtFqNwzLQW25go5B0tU641o9Ya+z5Kx1NnpshCb56jvPBgINQ9Qd
 x/Q==
X-Google-Smtp-Source: AGHT+IFoebjmnvZcNQasUWb0eQ1k9ziwq3IZthManuViR3oUOBwcldwPdCwO7cxGnwyOJIY3548W+Q==
X-Received: by 2002:ac2:57c5:0:b0:513:bf20:d8b2 with SMTP id
 k5-20020ac257c5000000b00513bf20d8b2mr278702lfo.65.1710790554158; 
 Mon, 18 Mar 2024 12:35:54 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com.
 [34.90.227.64]) by smtp.gmail.com with ESMTPSA id
 xj4-20020a170906db0400b00a46aba003eesm2736097ejb.215.2024.03.18.12.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 12:35:53 -0700 (PDT)
Date: Mon, 18 Mar 2024 19:35:49 +0000
From: =?utf-8?Q?Pierre-Cl=C3=A9ment?= Tosi <ptosi@google.com>
To: u-boot@lists.denx.de
Cc: Marc Zyngier <maz@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: Fix map_range() not splitting mapped blocks
Message-ID: <43haokus4jdxguk4arig5tsqcgq2wbezwpbj7oti6pdkvrfual@wa7vz2iypcv5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

The implementation of map_range() creates the requested mapping by
walking the page tables, iterating over multiple PTEs and/or descending
into existing table mappings as needed. When doing so, it assumes any
pre-existing valid PTE to be a table mapping. This assumption is wrong
if the platform code attempts to successively map two overlapping ranges
where the latter intersects a block mapping created for the former.

As a result, map_range() treats the existing block mapping as a table
mapping and descends into it i.e. starts interpreting the
previously-mapped range as an array of PTEs, writing to them and
potentially even descending further (extra fun with MMIO ranges!).

Instead, pass any valid non-table mapping to split_block(), which
ensures that it actually was a block mapping (calls panic() otherwise)
before splitting it.

Fixes: 41e2787f5ec4 ("arm64: Reduce add_map() complexity")
Signed-off-by: Pierre-Clément Tosi <ptosi@google.com>
---
 arch/arm/cpu/armv8/cache_v8.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 697334086f..57d06f0575 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -326,6 +326,8 @@ static void map_range(u64 virt, u64 phys, u64 size, int level,
 		/* Going one level down */
 		if (pte_type(&table[i]) == PTE_TYPE_FAULT)
 			set_pte_table(&table[i], create_table());
+		else if (pte_type(&table[i]) != PTE_TYPE_TABLE)
+			split_block(&table[i], level);
 
 		next_table = (u64 *)(table[i] & GENMASK_ULL(47, PAGE_SHIFT));
 		next_size = min(map_size - (virt & (map_size - 1)), size);
-- 
2.44.0.291.gc1ea87d7ee-goog


-- 
Pierre
