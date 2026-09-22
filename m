Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1CBC982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 14:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 209CF40AFA;
	Tue, 22 Sep 2026 14:40:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TC5bqzkN2B8B; Tue, 22 Sep 2026 14:40:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 47B1D40CB8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790088008;
	b=tQy6nCz+gPa8HkLUcQL2HtUkvaFHotE600rRP4c2Gc6UW5fQX3/OHzfmN4bEtyfArOHm
	 qIDm7oEROoFPimpNqhYsV+kkVw27wsx4Sqsb4xf/BkUtVJ8RgKtt+ycpXg1YTD8x12MEP
	 YzgVQjtdWcHYNUbFSjlmn1odk9jF9+F6WDtfW4VkNAiJxxkgiFqihTDP7iUj7E85R3lX/
	 DjsfTNvKMcUZP3Bl40/r2WOD+tlu4wrIC/U6HmmGtqzZcb1ed6tUBgntTXs0aC7mRCu7C
	 VzPOByU6zjP7GNoBjumNOFq0VDtBvZrZhwufnWV6KP1QQorsIf21v4xr5SjaJ57MrCg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790088008;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ojoj+yDtUVtsmGrLeW6DZN840vBnbcaxOIYNQFB3m1I=;
	b=RNfNUC75BUbX6AnJiJcb0iAaI3VEogha5aUyhXZA6mjxiwR6vdT2vD3fOWOMmw9E60xl
	 87YwsEOdwSQyA7WHYq/+w6IEii3fGFERPZrYbzlz4U6xAhe2LZ7IRGrJD2i5vYcMFDGle
	 51bRyL5wNCSW+AacFJQVd26KOneRot1opCKZ5F1eKezznYGKBPNYLMXnlpA5F80bANl9R
	 EjshBNlQ7XqrHxsSZ5o5YoHMciYMVyzHSpVFyLl9TaDU5/O2+yO6SwmZNRjng+Hjp3pCI
	 9EJOxBPzVW2q57trmdH7kRwHx7Y7PxU+i/rWOvd/okGJkmTJ+WcOzqQUeteUq+nGnfg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790088008;
	bh=ojoj+yDtUVtsmGrLeW6DZN840vBnbcaxOIYNQFB3m1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wEgYLcn7qjef1BxJcVygqPODuep8Dpvp4jX6DSeVwfZC97dpHt856waQ6E5Mv5N9D
	 Zs8eYKcaQoSKr3BK6I/LQXH4N/fhlfLeiwx1ffmNwvmgu0/FFDwIfaNvEPNNUb01uz
	 +Lgs1viXWwVLlYo6E28pFKEXtOo4HRJDSlyHfLA2s11DvdDN5xTd8z3u7vRiNMFy0N
	 JLEoPACbaJu6k/mmQu2qNbVZPU7n2AKQY1n3DOz2xS3Tj+hZqAPeIpHtmrmGFoItd0
	 q+YlZYLkJHTDycRa9VR1qg+Ad8kNNZaBoA7OB5N5N+bFB/F5XJh74K4UJeH7iphaTS
	 O+eEbeZI/7B5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47B1D40CB8;
	Tue, 22 Sep 2026 14:40:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F2D13352
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF7C64028B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:40:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lD-krwYVVnEj for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 14:40:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 28D084002B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790088003;
 b=QEiREyoWhqIJ1taBazvLVz4I2IOvoDU91u4eA9BuoXjWVoSjaZ7X6oHSpSr1VZd9U++z
 n5XF+g3lwW5BPuhPmtl+rtWFMyOw0CYDVckqQg1xunASo0zc8g5yRBN7+ihHkraMDWjED
 V8zefQLWwLLzPhqKl1osPrjYKXEJF+k+YtqYjJX5keEtMNqvo2ZyiiSj7GkVSeMLPIf33
 SbHtsLmipuzD6K7X/8/A9pa4Id+YZv3ZB34GBwnxuslqLfA0iQfUq0Xmj01MWRaFrf5md
 nbi+W8nbFE08eJAeDfioCsgm1qM+p9NMgApCGDjqhiLi7YaoWge/9fxXHsQNyH5ICyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790088003;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-ZohoMailClient;
 bh=ojoj+yDtUVtsmGrLeW6DZN840vBnbcaxOIYNQFB3m1I=;
 b=QMeTBf5szIIVwk8FODLLtqdZW5EFcEnDZoCVRyyoxPacLhXQ7TTmIOj4aBSLjoEd3pEN
 QtUxRs2599EzsnudzBRDCveJ9/xydzoyuCWlirnTuBlWJC1Z/sIExv0PEeXj669dW2gP9
 Y9nbykAykDrl8fih0/mNpD7cia8UkcmTiO32zcsT11bE5xkdWqADipz1JZnuTC++yBdK1
 OypNzes8QcYfuxT692dphwyVo/zZZNZAYWEslFdIo2drg09z+M02LNEITkXiAEiGULR6s
 OMOBztdw3AUQZiqgzEOhLLK0uQMdrkgQ6YMDigOAbQZnVNvRV3ESq4XAX9JeTOdO/3w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=pigmoral.tech; 
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=O0lBbacp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=O0lBbacp
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28D084002B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790087970; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FCDt1j/4HWZyp6oNUkt+3rsgPAC+1DBOq9+syK/70Iq2sKIzjJKaicFQ/Oi1XqLjxjQF0LymaiN+xwmk0UOJ/fy4DcyT8mf5PXJK3GztyJBSTUQV0cmOVCyOWX7dU3IJNpfgeUAsfmvR6csVp4h8bf3+Y3jRXZTUqqK6JQ/jFIc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790087970;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ojoj+yDtUVtsmGrLeW6DZN840vBnbcaxOIYNQFB3m1I=; 
 b=BXvZdG4pn84EpUqFVqZfOT7HwXGEgyRAlwQpjEY/JGmX/VfK54gBJIiHirS36i+CAb+tDmdmT7Xt4TI0xcVLFYNsxI+CZPSaOEycD3QSy6GUqIPUJ/Eil+vqwdlj4uLP7ImbOnvZcCe6uJtA4w49kzKKr6uMLN2+FstlkfBy+ew=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790087970; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=ojoj+yDtUVtsmGrLeW6DZN840vBnbcaxOIYNQFB3m1I=;
 b=O0lBbacp06Bsg7f2KLPKPX3XNe0MKxDrLfW+aNP1mbEYluXGX6NI2ta1M9E53hKl
 6ra6ISqOnLKjAympjM28uARgCXn6uKHSTOlm7f26+wkFsscSys8bjdwQc7jHScIv8yX
 cHWwMikVPpPO78dLWTILlOHmF9pgSMQtFbuNtwQ8=
Received: by smtp.zohomail.com with SMTPS id 1790087967563327.159553054845;
 Tue, 22 Sep 2026 07:39:27 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 22 Sep 2026 22:38:46 +0800
Subject: [PATCH 2/3] riscv: spacemit: k1: Use the common memory FDT fixup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-riscv-fixup-memory-v1-2-83b3166320e6@pigmoral.tech>
References: <20260922-riscv-fixup-memory-v1-0-83b3166320e6@pigmoral.tech>
In-Reply-To: <20260922-riscv-fixup-memory-v1-0-83b3166320e6@pigmoral.tech>
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org, 
 u-boot-spacemit@groups.io
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>, Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=phfBumVlT/jJ2kmptkkjnXLFsJsAVXDQPZGcN9MOmTk=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLI2TWb2OfE06++DKHW1Zenxs/d7LdAP/dW4TPic3C1ul
 js2e7jPdpSyMIhxMciKKbJw+Yv/s9bh+XZEoPU+zBxWJpAhDFycAjARzlcMf8WuKKVYRL58fMem
 RkwopvWnxhmN+yI+JT9zf8UbZiwL2sDwhzPFcpLY1jtrFS6yv/s6VcBI6N6JcmkrDZbrj+57lUs
 t4QUA
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
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

The RISC-V arch_fixup_fdt() now updates the OS memory nodes from
gd->dram[], making K1's ft_board_setup() redundant.

Remove the board hook and its unused header, and disable
CONFIG_OF_BOARD_SETUP since no board-specific fixups remain.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/cpu/k1/dram.c      | 15 ---------------
 configs/spacemit_k1_defconfig |  1 -
 2 files changed, 16 deletions(-)

diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
index 2893bc6b99a4..d6543cbd3a40 100644
--- a/arch/riscv/cpu/k1/dram.c
+++ b/arch/riscv/cpu/k1/dram.c
@@ -7,7 +7,6 @@
 #include <asm/io.h>
 #include <config.h>
 #include <bitfield.h>
-#include <fdt_support.h>
 #include <linux/sizes.h>
 
 #define DDR_BASE 0xC0000000
@@ -74,17 +73,3 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 
 	return gd->ram_size;
 }
-
-int ft_board_setup(void *blob, struct bd_info *bd)
-{
-	u64 start[CONFIG_NR_DRAM_BANKS];
-	u64 size[CONFIG_NR_DRAM_BANKS];
-	int i;
-
-	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		start[i] = gd->dram[i].start;
-		size[i] = gd->dram[i].size;
-	}
-
-	return fdt_fixup_memory_banks(blob, start, size, CONFIG_NR_DRAM_BANKS);
-}
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 0604c2feefc1..b4d19aa4411d 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -32,7 +32,6 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x08000000
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 # CONFIG_BOARD_INIT is not set

-- 
2.55.0

