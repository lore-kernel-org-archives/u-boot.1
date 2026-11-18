Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7299606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lx+EUSdZ;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VUINUeC3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B86F2812B1;
	Wed, 18 Nov 2026 23:20:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EHtAc9VdvOB4; Wed, 18 Nov 2026 23:20:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8055E81299
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795044024;
	b=oxVt0TYYFwTjiO7f5TDqAVG7wPwRotRy7qNImiRNn8RO1Uh1nsK5IAX9d1LCpOVuQpCI
	 uSFVmAl/9djKtpe+QIOmfKx3LOCSzgEFhjBzbC0C17ZWrQ4bb510JrN3E4lDTteDvA0YD
	 Ko8KM7Y3vyAp8+MrPDsmH+6mSjDIQGt0Agx1VTxSOWmXzDeuUXeUvRC8jss5DthA6pIcE
	 dSD8PPlFoj+CQV+t8tV9ZeMGpi9jCMgnCjXmXyakFmAYYG0Obuv7eWrx2QVhqxXlqKltP
	 ZH3Oy5lO5KRhJ1C7VgWjkJyNmPK3UI4PBIdpbCC8ZZnPyXk/1q+x8YrCYP1IuKN9btw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795044024;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BNQafi/fawz6ngWTFtaQDh2ZXi5bYfhiGgMlFb+nLMI=;
	b=lEkCxejq+7WyvSBSSqV3T702EM7DB0EN5hNinepJofN4k2bQtzM3N4Av+9TyMf3gILoY
	 onUZCe9dH5a8i0WYE/A69adpcJB/6CLWIaaoLzP/JnW3EA9CVNuqGfPgR0ejEA4MzE3cW
	 x0Do9nBDzG/80nuj6R8ZUILY28ftY9jGFb4I0I3+l6xX9f5elOXRz+HVeHYsStvyLIF/y
	 9AUObwWMTfdQjhlBs7+cYAjYGOeNFvipsuygZ2b/ijB7tIIn3KKwg0uOAPMMBL/KvxuFG
	 4f17LOx9/1N6FlAd4SEHN0A+2WGmaK0i/8fcUlKbSyXlvzMwFkZrKcyxwyk8CtYSWaQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795044024;
	bh=BNQafi/fawz6ngWTFtaQDh2ZXi5bYfhiGgMlFb+nLMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lx+EUSdZs82ObZ7inH866EvlxMKL+jMx3bWTsgFf5QDa73X+J4NwwgbP6eIIKUBUo
	 XOfbr4cTtaRi71TkrYS/ygAHHGNtbKMEOmA3M7qqcz4Ioh8ekTh32OwS8a++9QQHMu
	 OnEBkiirBvLGRFmcJxAmU9sQ0/QifFTBN8JlVueTd2FvsxjNZr16lozqZyGeEHNRus
	 JGi41iENDmtgf0Ukl3R0WqY2WJGtsfdUyzNUcVpKC9Ung8wIngatfOHe0wuaV/AtgV
	 JL5dY+SxRPdFIbVSQKejPfvclgXOCmu4BtnkGa/Wg8ceOaKUvyH1X2rvCQgygdb9VQ
	 eWH580SKUzwCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8055E81299;
	Wed, 18 Nov 2026 23:20:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 64AD69F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 46EF4408AC
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KDD9O3NZSrPS for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 23:20:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 634B240873
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VUINUeC3
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 634B240873
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:20 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-86156cf8a7eso266580a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795044020; x=1795648820;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BNQafi/fawz6ngWTFtaQDh2ZXi5bYfhiGgMlFb+nLMI=;
 b=VUINUeC33ZeD8f0byJuTxmCysaEKLr4tpi6gi2gXugf2ZWaYCPDrARvIXxUpCmuQrp
 oGpR0PDtvKQ7UzfncjE9PmkrYFir59KYlF0pK9yQJUw2SSvwlLyGhuqyFqc0ue14/IcD
 GWpqtbKEBrDHX44z3PU45Fxd2upDK0b4u+rNeRRUBhEdFo0JOEnLppkAPazAa4qjIjTR
 Un07iuidV2P7jpNYe6au/kvBNNRsqqu4AM7RNtCpqtSJINtn8caLnpWNADuVkco2JwlH
 g1YzmnX6hI9RblguG7YzFFvx0/O5AJJGSQAjh3eoW55znyKfiyrMD9rtgJ5MCBIwhHdt
 /FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795044020; x=1795648820;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BNQafi/fawz6ngWTFtaQDh2ZXi5bYfhiGgMlFb+nLMI=;
 b=Syvh6CFSdGOkF3YvZfDQE88uVlXXj8Axd0mdqXeZeHEUXUXj1SSi4T0/W2IctcZYAU
 2kzu2tkU5YXjyzzUQiZtrEF/G+rR0JK5dtlj1IkIt5E+Bf1LwWWjAxXYUoMtRmeG0KIf
 wNfhY6AABaNKScrkCp8q6QUE5ntY8de0bb6lBisVylrIt6CI8wGOnnOURycMP+SXqDnA
 3MbRckWAoLw4e1GFdL4NEYCd9dFXMJQbEyzo3UYwkRMl/sY5GUZ7gP1euuHnOPtcnJ9K
 RrZbJlQWsvc1HC0q6U5RAariycgG12F1hDZtYkPJs37ucntp7HCiz1dv5RGesSQ0apGe
 lPuA==
X-Gm-Message-State: APuU4Z/NeZB005F42KV5e9qyuI9Wn4NKoxrWXC0VK9uFRNLs9e7WvXH5
 zCFZklIaPWqLUN0XQHZ61bp+/sEOM9sP8STsd0sl8JQbQ8vmNKdTYl/go/DOwQAaV4o=
X-Gm-Gg: AYBFou0txZZHUJy+py/pILztZ4Dua7u7lT0YyG7g+s9799urgSMtGp+vQj6A2O9vhlD
 5QRmjJI/ZQIZCV4lt1MmHez2rdcvGDPSiSPpXz74zEgx+hU0izJR9vl/I8oGCDc61dO860JOt6w
 4g8AIj39sZ74YvEQYHZrEgQyLGwowRzRNG0DqTSvlTihEhrNtLxMF038ndrgIsGRMrZTAu39GB7
 qrSsy3UmGm6O0CyqT+rFSiJTjGJRjRQIrEDDmw344MHnp5DloSci682YjzLpXK0KaS43Hctmami
 URstxiDrHzvKv5rJiuTK7DRzJWLTV89FTYcYIt9mAXOL/jq7hW3/74Kr8ny4noNZJSFpNqGsnBS
 vsDVlaeA+uebianruh6ht49Sd9PMDK8KYkwJ0HH8pqH9lUd37RfzVmzjn1pFE2V0SnT+lsRvLkb
 nTJAurt8+3FK412p63gFCXTK3Uw/IoiVKOHLZObFd7A1jNXrjOJo9R+ziHeLdnzORIQiVgwdYMJ
 A2WyTD3BctCuuud8vuMdXD9hmsS1wqgWA9tndrX48iuCl4lUFkItc2jfyL+ybemdc/5ylXGPlfU
 IkI4IWxNrCaHEDZXPU56wIEvtI/rTto9xQ==
X-Received: by 2002:a05:6830:b15:b0:862:bb95:4148 with SMTP id
 46e09a7af769-8630416c8a5mr45728a34.33.1795044019892; 
 Wed, 18 Nov 2026 15:20:19 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9834:2835:378c:43f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862f01d4764sm3025878a34.5.2026.11.18.15.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 15:20:18 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 18 Nov 2026 17:19:00 -0600
Subject: [PATCH 1/7] arm: mediatek: map DRAM from the DRAM banks on Genio SoCs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-mtk-genio-one-defconfig-per-soc-v1-1-1505d27fdfcb@baylibre.com>
References: <20261118-mtk-genio-one-defconfig-per-soc-v1-0-1505d27fdfcb@baylibre.com>
In-Reply-To: <20261118-mtk-genio-one-defconfig-per-soc-v1-0-1505d27fdfcb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5122; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=UWdGn0wK5xWItmyaASQFIiKui7wEM2kB4gbwQ0ugBQ0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/jKAH32033pzzr0o8RhlNtXoxHKW9hozyJK0k
 b3zOrcRiTOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav4ygBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A+2sH/14YP3dcj4rfUf8Fm6/fMRbqM+lj5UmI187ckCd
 RXnEVg3kR6RbiZXtFD8YhCAdXfBQVonyz1ZxMB2BQO3/yDVSJgSodv0XdEfstLJEUHa/Mhb/pjY
 EpjFbXi3pcV0osu+wcnPVt64wrYFAahamG3uKuXSOkgSzn3hM1RV9wB5bP4f+X/rW+kM8oMr30A
 Sk56wDEjjJ+pPQ3ln1CNiT5dlKStSBJhdeCymBFYalR3ueI0AVGLkpCeg4EHxXE12MFPw/YHxvG
 7bbHwJY/VL5CbyOnTVUSTf5Ux5lpWbwP6PYiMEpm1aLgnBH9qGgenBu5dlSYgB0Bgb/2eSMJmYc
 GC50=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Map DRAM in the MMU table from the DRAM banks in the devicetree in
U-Boot proper on MT8188, MT8189, MT8195, MT8365 and MT8366, instead of
using the fixed CONFIG_MTK_MEM_MAP_DDR_SIZE. Other MediaTek SoCs keep
the fixed size.

The fixed size comes from the configuration, so boards with different
amounts of DRAM, such as the Genio 510 (4 GiB) and Genio 700 (8 GiB),
need separate configurations that differ only in the default devicetree
and this value, and a board with less DRAM than the configured size maps
memory that does not exist. dram_init() already takes the DRAM size from
the devicetree, so build the map from the same source.

Fill in the DRAM entries in dram_init_banksize(), which runs before
arch_reserve_mmu() sizes the page tables. They replace the fixed entry,
which is kept for SPL and for U-Boot before relocation, where the DRAM
banks are not known yet. Lower its default to 4 GiB on MT8188 and set
4 GiB on MT8189 (which had the generic 512 MiB default), the smallest
amount of DRAM on boards with these SoCs (the Genio 510, and Genio 520
boards fitted with 4 GiB instead of the usual 8 GiB), so that it does
not map memory that does not exist.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig         | 18 ++++++++++++--
 arch/arm/mach-mediatek/armv8-mem-map.c | 44 ++++++++++++++++++++++++++--------
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 4732e5b21c6..df609f82fd1 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -159,6 +159,15 @@ endchoice
 
 if ARM64
 
+config MTK_MEM_MAP_FROM_DRAM_BANKS
+	bool
+	default y if TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195 || \
+		     TARGET_MT8365 || TARGET_MT8366
+	help
+	  Map DRAM in mem_map from the DRAM banks in the devicetree instead
+	  of a fixed size, so that one configuration can serve boards with
+	  different amounts of DRAM.
+
 config MTK_MEM_MAP_DDR_BASE_PHY
 	hex "DDR physical base address"
 	default 0x40000000
@@ -167,8 +176,8 @@ config MTK_MEM_MAP_DDR_BASE_PHY
 
 config MTK_MEM_MAP_DDR_SIZE
 	hex "DDR .size in mem_map"
-	default 0x200000000 if TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8188 || TARGET_MT8195
-	default 0x100000000 if TARGET_MT8366
+	default 0x200000000 if TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8195
+	default 0x100000000 if TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8366
 	default 0xc0000000 if TARGET_MT8365
 	default 0x80000000 if TARGET_MT7981 || TARGET_MT7986 || TARGET_MT8183
 	default 0x40000000 if TARGET_MT7622 || TARGET_MT8512
@@ -176,6 +185,11 @@ config MTK_MEM_MAP_DDR_SIZE
 	help
 	  Target-specific DDR region size in mem_map.
 
+	  With MTK_MEM_MAP_FROM_DRAM_BANKS, this region is only used until
+	  the DRAM banks are known, i.e. in SPL and in U-Boot before
+	  relocation, so it must not be larger than the smallest amount of
+	  DRAM fitted to any board with this SoC.
+
 config MTK_MEM_MAP_MMIO_SIZE
 	hex "MMIO .size in mem_map"
 	default 0x40000000 if TARGET_MT7622 || TARGET_MT7981 || TARGET_MT7986 || TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8512
diff --git a/arch/arm/mach-mediatek/armv8-mem-map.c b/arch/arm/mach-mediatek/armv8-mem-map.c
index cbaa9b4c267..b9980a75fac 100644
--- a/arch/arm/mach-mediatek/armv8-mem-map.c
+++ b/arch/arm/mach-mediatek/armv8-mem-map.c
@@ -1,24 +1,48 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <fdtdec.h>
+#include <init.h>
 #include <asm/armv8/mmu.h>
+#include <linux/kernel.h>
 
-static struct mm_region mediatek_mem_map[] = {
+#define MTK_MEM_MAP_DRAM_IDX	1
+#define MTK_MEM_MAP_DRAM_ATTRS \
+	(PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE)
+
+static struct mm_region mediatek_mem_map[MTK_MEM_MAP_DRAM_IDX +
+					 CONFIG_NR_DRAM_BANKS + 1] = {
 	{
-		/* DDR */
-		.virt = CONFIG_MTK_MEM_MAP_DDR_BASE_PHY,
-		.phys = CONFIG_MTK_MEM_MAP_DDR_BASE_PHY,
-		.size = CONFIG_MTK_MEM_MAP_DDR_SIZE,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
-	}, {
 		.virt = 0x00000000UL,
 		.phys = 0x00000000UL,
 		.size = CONFIG_MTK_MEM_MAP_MMIO_SIZE,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* List terminator */
-	}
+	},
+	{
+		/* DDR */
+		.virt = CONFIG_MTK_MEM_MAP_DDR_BASE_PHY,
+		.phys = CONFIG_MTK_MEM_MAP_DDR_BASE_PHY,
+		.size = CONFIG_MTK_MEM_MAP_DDR_SIZE,
+		.attrs = MTK_MEM_MAP_DRAM_ATTRS,
+	},
+	/* The remaining entries are zero, which terminates the list. */
 };
 
 struct mm_region *mem_map = mediatek_mem_map;
+
+/* SPL keeps the fixed entry, since there is no SPL_ version of this option. */
+#if CONFIG_IS_ENABLED(MTK_MEM_MAP_FROM_DRAM_BANKS)
+int dram_init_banksize(void)
+{
+	int ret;
+
+	ret = fdtdec_setup_memory_banksize();
+	if (ret)
+		return ret;
+
+	return mem_map_from_dram_banks(MTK_MEM_MAP_DRAM_IDX,
+				       ARRAY_SIZE(mediatek_mem_map),
+				       MTK_MEM_MAP_DRAM_ATTRS);
+}
+#endif

-- 
2.53.0

