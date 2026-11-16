Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B25606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nI56OyqK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=X2xcMroI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D30580D39;
	Mon, 16 Nov 2026 16:28:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x3Q2RRZ-Rteq; Mon, 16 Nov 2026 16:28:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED43C80CDA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846492;
	b=BtEQe6je9Mo7FXpnUGhx/lENgD2ghfFQre39HSzZrKMmQCxb6LjA6AnNq/GGtwOIEQKq
	 z8tTPw8wqkmBFcdG2PwJ5wE5AMwYsOhYfmvg4LefP4NZVuWG6OkDKr3BBHTbtp24PXD8p
	 ZUqC4JbRtC+cnRtTIAPNXVoDIifzCXsW6ZJyzhzrwY1l0dpoUdWjz/cczmGPkJbUJWPa4
	 bnvDWQ+Tyrw+iFhvRGP1r7w80GfcKaYmWjau08ZEzhbrC9O76zPctyODhSVG/rnSIU6KY
	 8Usax3HqRqrkZEgecOIMb+2hPrg6HRAZlTTHcz0ilVuUizrIJYMBpqZgm1TAUeQoRfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846492;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CXnv/0ER6XQqlQ1NzHEspa0egqM68+jdie0dGGggblg=;
	b=sqLidj363OPy9RDkAD+iRslv7K9zCVeLqCd6NaPTCpf7Jcap2IcyD7hDjFAw0WswsnE8
	 nNBKghiPEOOgxzbz0UESWrC0wJEBSZSUbHUlyLhbcjH0wNmBEtvwNCgpI8uY8G206w2nu
	 2MJ9ReIUtcDrqDUAw5GgcZbxUgfISXLm2Twl8Tfl5xyWyIQyAqyKils63EYa124q27uDF
	 l12BWoVe56kVe9iCWs+QMwWFlNQ6wjWVjGqO9BE6QweVbypZP1LxkkpdFuJkK+1ggprxN
	 w1VhxjkYuXEgg7xk6DivmH9J+Xqvvactl0adpTz9OM7/6MuQZvsUbrp4ymDDhKyUcuA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=none header.from=pigmoral.tech;
	dkim=pass header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=X2xcMroI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846492;
	bh=CXnv/0ER6XQqlQ1NzHEspa0egqM68+jdie0dGGggblg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nI56OyqKj2qr3nIfpMFtC/g36aH08u68ikViMUmLDvD3RNTfPj9uf2wHOh1l1JMId
	 qhcz1WMtqxVAuAEWbHI/koWc4AUo9lt6tvpt7udGGxa/UlrRqGyMTZfJcTUxN2+Wv4
	 PMumUUPy28RWS2bXlKn85GewZlwd3qT44r4Sd4T0W29odf6OVp6aXE+FSZNDtje7py
	 eJ7AZlxnGx9SFhKdIU7mDueiZBNXB/NtFo3MVajldhrVuKzJRDFb9osoTBQsyUvVjq
	 CZ4HNrH6adfvJfOFEsu2iQB/wmVLaniR4taEKX6eSpb3cF2YSgZICDm/QT8yAYwsMS
	 hEwSlP+j47PjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED43C80CDA;
	Mon, 16 Nov 2026 16:28:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 34EA54DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B1F480F82
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:28:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OI4iztC9d54S for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:28:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D96C80FA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=X2xcMroI
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D96C80FA6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:28:04 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=X2xcMroI94Uwtc8n87ZjsdtoGPploxmjbbT7LRkHmyhCwu39pcWDM4GS8ySGhKPLodVoqrysIbZW5ReoObI2eQj+BofRxqWcVrkl5V+fM3hKIU49zgStlXUMvw4+ANXvfKOD/uY5dmm04Xj4KuuSAyV76lUipgnWacEAMgFC1eg=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=CXnv/0ER6XQqlQ1NzHEspa0egqM68+jdie0dGGggblg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794846473880941.8803625668822;
 Mon, 16 Nov 2026 08:27:53 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 17 Nov 2026 00:26:18 +0800
Subject: [PATCH v2 3/4] riscv: spacemit: k1: Use the common memory FDT
 fixup
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-riscv-fixup-memory-v2-3-4731aa6c3fb5@pigmoral.tech>
References: <20261117-riscv-fixup-memory-v2-0-4731aa6c3fb5@pigmoral.tech>
In-Reply-To: <20261117-riscv-fixup-memory-v2-0-4731aa6c3fb5@pigmoral.tech>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Eric Chung <eric.chung@riscstar.com>, 
 Yixun Lan <dlan@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>, 
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=IlCAmutAh94DpM+OSn3UJZc4akpXW5GwQTgJ2+i2FCQ=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLJ+691d2laXcP6DxOf629xTv1en+/ZJrXEXfSbwJO7KP
 Z//W27c6ChlYRDjYpAVU2Th8hf/Z63D8+2IQOt9mDmsTCBDGLg4BWAi4qkMv5j4lj9Kms/9hvPe
 b1ePmbJ1C6wYN86POXswfU1b2pkJyx8y/BX8qW9dNmn1VpVD1ziq3tx4OPWHtK/PyUeHNWdKP+g
 94sYBAA==
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index b8f777e89c1a..ac00062fbdd9 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -36,7 +36,6 @@ CONFIG_FIT=y
 CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x08000000
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 # CONFIG_BOARD_INIT is not set

-- 
2.56.1

