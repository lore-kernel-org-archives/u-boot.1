Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89314CA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 12:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3803B40A99;
	Wed, 30 Sep 2026 12:18:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mnrfoxz0LOfN; Wed, 30 Sep 2026 12:18:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 771BB40A55
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790770715;
	b=lO9jaalbozJ6kBlOd+WriXWe+Uy+BnXACQvBxyuN3wpwSxPPtpDGl4HhHEM+uwXuJ5la
	 sw35hE2DfmmWcUP6wLperuJv0pxMtfZczmtawh+TgiGxmTzoSOd2wXounMdgypXB2VX0s
	 NP1xtD5tA6ICt5nomxl09G3tK5sstqI5Z/5QP5pnQIWXEKnaEAu1I64hf1IEGT117afqA
	 X5tMQB3zBH/XzN8TsceljwqHGJya/TTGEuCqwmzcjGX6HJUNn3EdIwdR2NK2cc9nYQIBm
	 kjisYQs1JeN1Hh86jGbQW1If5yIPxHGbNzYIXCuxOBBqbp4sxsuB84KyGvK7CTqHN6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790770715;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BSrBpTaOaEt1wysuUy9Y1k8j6W+1zZwlT/ANpk/MeTk=;
	b=P410O+7eQUloqpa+ybbW5WQAo+iMCdrAbq0lJn+JcP/KO+cvNG55500wDnG0+XCrrdqd
	 UqjYslnNuuxIMue1tzLlNZ5rP54j4p4fL0ijmKbKOYYrz1rLwop7vaZk7wxXNr4LtoU3i
	 ami17V37kpTwXFPKycJwXZNHkI2UstECd815WXjbHZAqMvzq24uG0RKR+t7I0sd42wplK
	 7uk4Jg6MshMsf2RVMCaEian+FUKOicpgtxc5EhGbIeud+VlGv5BjcOGI/fYcQW3wDhFxK
	 rwndVdeddBWvUF04Yg7x+aiBgq6bmeJnyjQXFnC69eDyh0lJNE+A5Jm/ET2zUdAAA0w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=I7wUHQjq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790770715;
	bh=BSrBpTaOaEt1wysuUy9Y1k8j6W+1zZwlT/ANpk/MeTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tofg9C8UoekcNQBfMeDQe0yILrtuJC715naTqm98zi87Ndf84YnzdSxDyF4/3rc3i
	 w7TjwsuVyNPT0SQjNS6KKuhrh5sWdkh2oHwmVAcs04ErUwiQsAAwmAYOCbkVtg5Wwf
	 XM1780dOFyX1m+/5udqYWT79NRcY986zWwOqS405s44KGjKeibBF6wqVNfVJrLvgdY
	 kG+ObD4uYJezkhtkIv3TTx83G5ugchUG8/BGajyG5+VuQ4VLyrPSG7bPvddMHYLVK5
	 EnS/eesH/2KEBpMNnPbmAvB4XjLX375x6BTMVUkID0neNyFP0RSxTX0ESYOlFdkICL
	 va9Mktl+OVvTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 771BB40A55;
	Wed, 30 Sep 2026 12:18:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AFC4380
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C94140A55
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:18:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yAHSktRMwppT for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 12:18:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5E032407B2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790770713;
 b=qeU+Y59fJ7DJyL4LALG4DRZOi5m1IChJzVg7K82kgXXbuKMFeZ16WxKghT9WwyQ2lprw
 SNCl76CdQM1D8IDU1MIJz97XM+JsNlYjemFGvwBDxJuil9gs3Z+otlCawSZ4pzTnFBFf/
 QeTAmxB6GDWvdwB2pZaihcHpQkR8uEe2xhaI7P+jZ/qkhuKXNM+2/g6QNkmEdLqUZa0tT
 Cmq+qQuHviOITk1I5uartVon0kiISbyS7zHPSGGcFkvMFKV7iWo2mSQB/shgjtGgKQvzw
 k5MDTowzLvE4Sk/baG5QLtDdsynMzdvXDE7t0CqWmjclTEJiVmFmE2Ryn1CjDKWUdLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790770713;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=BSrBpTaOaEt1wysuUy9Y1k8j6W+1zZwlT/ANpk/MeTk=;
 b=Lp+44py5WnD/l3yMDl8O2kR/IvqAp9xh+0nmcvklpSFTL3gnv9KcwABlvwjXcQDA6VjR
 I0Zk2EGIJQh+CUkn+EYz/r9JtsoiLiCx36iDksefcdaJl1d55K6ZkyABKsk1mAebik/Ff
 B06h8NpYhWtPTUe0gfsJwcIkvjWa1SCePnxYfZ1ukUr0k1jkrzpGGvHIBfBnDdhCTixcg
 NHnHXQcbXZghGxD40PBux9L0/gV0eMGDZHMsRhYL65/8Vb68t8aLfba43zItuHHTHepsP
 MRsKl+e0e5pqEmzb59cEHugzvEmXkfrBx+ZXjHE+sJSsv1AMaxJKS7CSZFzsTvlEtAA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=I7wUHQjq; 
 arc=none smtp.remote-ip="2a00:1450:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:39::10; helo=mail-ua2-x10.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=I7wUHQjq
Received: from mail-ua2-x10.google.com (mail-ua2-x10.google.com
 [IPv6:2a00:1450:4864:39::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E032407B2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:18:32 +0000 (UTC)
Received: by mail-ua2-x10.google.com with SMTP id
 a1e0cc1a2514c-97e96a8ba8cso3345497241.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 05:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790770711; x=1791375511;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BSrBpTaOaEt1wysuUy9Y1k8j6W+1zZwlT/ANpk/MeTk=;
 b=I7wUHQjqXIA8sis7/qhKXZOV5MsKF9IZpyNLqsyBvtX+rimtLsQ5iidhel9jddkl2m
 rxyXAR5EdN4HgrQ5hN3w5a/9pPI+wdj3bPzFopwMu2gBzNUsOh1Zb70C48o/2KCi04X+
 0aXYflWEN6LpSLM4UOAHYJmNO+T7d3/+J/W9J9yBCsnS227VSp6DoiP+FJx7k26Fu+p+
 Zq62EuNVM0Xwy1lyMKai8BDuTTWRM4pyl7qfE/aSgAXqSFnEbBFS4wsvI11Co9N3E78H
 0K6qHjfH+csGjRmSvqV3mXDdfajLWbCFBRYALVCaKiZHa8PoZMLUfrPivheTcj0lgGrq
 DLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790770711; x=1791375511;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BSrBpTaOaEt1wysuUy9Y1k8j6W+1zZwlT/ANpk/MeTk=;
 b=mxr0lu2o1jW+p7ZCXQs+uaOY73RnRRFFwta24vC8w5HGQ8Mre9fhAR/bcZcCcUnCnm
 H3S3ep8NsH9hmTYiyyk5WBd7cjYyBbi228AcCv9+5VZVLjMZx+pxEx1j1Du4AZmgFEYg
 bEw44cRvfInjRNh6bK1MVQHOa+JFFH66/7uIk6I6ZCMBEFmV8lHuy1d6Tvu7DXrmKaEx
 uoHNwJcf6Ju4+6AxQWB9UtoroYaPuGS2kujTdmPFrOYEIMCNZRKBRmbnV0OqnGFUI8WX
 w06BLEFMufQxlBQhs5Ehzcar07D9Xakcl5vTWl4dV/0StoWNi4N9XP7wm4Ioj4pr3w1d
 F/pA==
X-Forwarded-Encrypted: i=1;
 AKwUvBztjo5QNYJ6QYjOpH5kkVjbG6nFc4xkWbX43QB64A2xC/B5/DvbAgZY7DOTUgBKsobNuUTtBIc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL4Hh+/lCngfLjJGFl1RJPnqJeOif/sRaTwTWBV/i+BOb3GBYya
 5HgE4M4UHKUQQmH1DZaTknhEFC50EQJrPI81WIzJtYCpuM896J9vEq98NpYCKnKcDgY=
X-Gm-Gg: AYBFou1CIKKE9Ifm1tHx07lJ8uL/jxicjdnoh+fIB2w7cQkbt6vj6V7Xbov9Mu2tzFE
 5AYImV0Z1d2kWhmEMqg6GxvAuim0xEutKew1ozq/TeMXJXqp2s7OXE48aehIsYQjmXBgKKrcPqZ
 xFH8OqIUxtTSQi5OvHs671LWEl9WIzEM5YPWY7PllGO3MQ0v5NXxCZPChbiM4Hj6be4OsOiUwg/
 Z67t9iac/PouRAfcTsvsCU+K1t344ArKAbHV9+oswIqb/zD20AyM2bfBzNeSz3QfEeZA+GqbEy9
 jAthOEkN7cUeiGKE1+tviqQ9sGKM6W7Bx8WE2HMeuWRIACgjktdIG7Y7k+UGeSTVrdhQp3n6RgY
 k0UFX3DHI0Uzn+U9aZ4BYsFMltXkSyiDdUFf93DPPHT/GY9d8C2puEI3w5tzE4C/pH8s8nZPoLy
 37japIrL0rkT2yJs7I22T7NWqQ4DDfQbaNbvzvKkSmVBnXDcXxKv8/ZzlwslHXMT3QeCd5c7yx1
 eOk677aNmc+IE3U4dG5plPjb9zF9wSlQocr4A==
X-Received: by 2002:a05:6102:1620:b0:7b3:949:ec0e with SMTP id
 ada2fe7eead31-7be73791b53mr286007137.26.1790770710939; 
 Wed, 30 Sep 2026 05:18:30 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:9534::ddab])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7be14b3cfb9sm1298403137.12.2026.09.30.05.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 05:18:30 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Wed, 30 Sep 2026 09:17:50 -0300
Subject: [PATCH 2/2] riscv: cpu: cv1800b: keep U-Boot out of reserved
 memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-256m-fixes-v1-2-69546876ff28@baylibre.com>
References: <20260930-256m-fixes-v1-0-69546876ff28@baylibre.com>
In-Reply-To: <20260930-256m-fixes-v1-0-69546876ff28@baylibre.com>
To: Leo Yu-Chi Liang <leo.liang@sifive.com>, 
 u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 Kongyang Liu <seashell11234455@gmail.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The upstream devicetrees reserve the end of DRAM for the coprocessor
firmware, as a no-map region:

  cv1800b-milkv-duo:    region@83f40000, size 0xc0000
  sg2002-milkv-duo256m: region@8fe00000, size 0x200000

ram_top is the end of DRAM, so U-Boot relocates into that region. On the
Milk-V Duo, relocaddr is 0x83f76000, and LMB then fails to reserve the
region:

ERROR: reserving fdt memory region failed (addr=83f40000 size=c0000
flags=2): -17

Implement board_get_usable_ram_top() with get_mem_top(), which returns
the highest free window below the devicetree reserved regions, as the
Xilinx boards do.

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 arch/riscv/cpu/cv1800b/dram.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/riscv/cpu/cv1800b/dram.c b/arch/riscv/cpu/cv1800b/dram.c
index 5d7659887b9..abcc239a289 100644
--- a/arch/riscv/cpu/cv1800b/dram.c
+++ b/arch/riscv/cpu/cv1800b/dram.c
@@ -3,10 +3,14 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
+#include <asm/global_data.h>
 #include <fdtdec.h>
 #include <init.h>
+#include <memtop.h>
 #include <linux/sizes.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
@@ -16,3 +20,24 @@ int dram_init_banksize(void)
 {
 	return fdtdec_setup_memory_banksize();
 }
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	phys_size_t size;
+	phys_addr_t reg;
+
+	if (!total_size)
+		return gd->ram_top;
+
+	/*
+	 * The coprocessor firmware is reserved at the end of DRAM, keep
+	 * U-Boot out of it and of any other reserved region.
+	 */
+	size = ALIGN(CONFIG_SYS_MALLOC_LEN + total_size, SZ_1M);
+	reg = get_mem_top(gd->ram_base, gd->ram_size, size,
+			  (void *)gd->fdt_blob);
+	if (!reg)
+		return gd->ram_top;
+
+	return reg + size;
+}

-- 
2.53.0

