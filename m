Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC22C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 02:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C980A406C5;
	Tue,  4 Aug 2026 02:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aOxD8Y2yRWtR; Tue,  4 Aug 2026 02:15:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAE7D40692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785809730;
	bh=8uMaTQVWpRTf3qmAQZ1hDGbSL7Yqz0f9l0IEEeMeOXM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YkDj9X8P+fF3S11g8yZRSmRsi+GQsClTC0U1K9i1IkYdQWvyAKi0HQNb3vxB3t//7
	 j9uJE1Db/R6kdxP4psicZt349go0qjBvvauuVIMpivgYkEFINUVCbRVfDkP6H0kCe2
	 jv6GUFAGjV5Ki7TD5QtTtxhEaVsW7iWULIjpcmj4Pmy8kH1JKwIiwV6Ubs7kWu/9OB
	 BT8QbB11CbWH/MYBd4pjHe1fe6Mq0r4dbtJ39evycZVqSIBLI+wi3Os8I+OXSH4rYE
	 PC9SFlYq8D2eLE8Wgse2YfNboSWN4hz/iaINHMcKil0kvtJ07gkJLJwN8mwAKCxlQE
	 oRK/IWd4vfE1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAE7D40692;
	Tue,  4 Aug 2026 02:15:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 15E66194
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 01:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 047DB40670
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 01:39:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id izYOpTSrENU1 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 01:39:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mlpkos@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DBB844065B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DBB844065B
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBB844065B
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 01:39:37 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56DA580087; Tue,  4 Aug 2026 03:39:35 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBDA580087
 for <u-boot@lists.denx.de>; Tue,  4 Aug 2026 03:39:32 +0200 (CEST)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e9f69ee6f4so3604849a34.2
 for <u-boot@lists.denx.de>; Mon, 03 Aug 2026 18:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785807571; x=1786412371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8uMaTQVWpRTf3qmAQZ1hDGbSL7Yqz0f9l0IEEeMeOXM=;
 b=iNWEHCb/LA8zl8kTtX1i6ZtMYpf9kNuA1lbghAwGcABv84TRmgvCi+BCo5G4obHNos
 4xJ1d4JcNLgdsV1HVAlPjW5eDb4qcMUK6t8gSApWZJ1hHwrQr3D7jqdbP0smXnkLsZN1
 4k1jslRS4fGhZ9Sh5qyy+AFUrWyb/lwq9UT9KJybcKai9kiJ2Xsct3ray7n1o1INHS13
 6AoMUpIU4rTq5p3zvdzXQ/fGyiyAgsy4HJS1uualgo3yXVEvrMytDkzdySowJdOs1+/f
 P4gqukEV9oWArw8EHlCMwvy2SLqaYFomaTKtu1semxxOlLJNlwbNXD3wjyqGIaFJ9eyy
 nUKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqV9e5VBFGltQN4Zx8tpLRAKeUtlicIMBy3By9kWrqjrtw5ZWoVK2JgXk9mXe4lgISqfUQauNE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx37WfUkHf9i9kfR+rzHfukud6f8GTwt1UocEdyYyTl15g1N55j
 TsXp7fkYmnmC+AhHsbMAgxo5x+TSTJRLF7zAx8EKwZTeqRVA5bK77yVp
X-Gm-Gg: AR+sD11G2IwZfaw8c0k2Gx0a0wOTWdiVWFXvuqC8dMuE1x+p8XVWRs+yBL3GZfGdUJP
 hTPuYVzDrLDACH0+awOdxUvscgfzCbUydJzfKlWUQLPDhW+SEoLT2b7kE3dl53KuG3Kl6LhfXs5
 1CCtB3AnyFkjIk+1EQRNkz4XpnzGNLYUxutRz9GO7JKjaqw9FVW0M2NcygRXAs44Zd800l5RIW8
 N5d1SUlb5vrudi0ux2JrZ1WRrLdwwuzBARERq/BsNc67Fo+aWwyuwqfAZFRmnGZe3X+eL4KWg+N
 SDOhjbQieaK8/dL99hbIUPrCGveY06u1xKYfnXA0uUewjYIioWgUIZWujyaOYBe3nj3329GPdQN
 hcjs1dcAiLTHRE7Pj3mJgFZQ5fzXGpk4yMwKSOK73C4iqa7IC98X0JaVaIR706serwK2mOLGOHt
 MegNQIpHVktFJIuTr8kZvN2w7i8SjDCKYpewf5FeixTz03m5lO87c8EyYGETpw4QWFYim2vnS9M
 i4+DEatiA==
X-Received: by 2002:a05:6830:6f86:b0:7ee:38af:b195 with SMTP id
 46e09a7af769-7f196b97f01mr23044140a34.2.1785807571396; 
 Mon, 03 Aug 2026 18:39:31 -0700 (PDT)
Received: from localhost.localdomain ([96.27.197.23])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18ed3c81fsm8647085a34.5.2026.08.03.18.39.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Aug 2026 18:39:30 -0700 (PDT)
From: Mahmoud Komaiha <mlpkos@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot@lists.denx.de,
 Mahmoud Komaiha <mkomaiha@umich.edu>
Subject: [PATCH] ARM: socfpga: fix dead guard on
 board_spl_mmc_get_uboot_raw_sector()
Date: Mon,  3 Aug 2026 21:38:58 -0400
Message-ID: <20260804013858.23721-1-mlpkos@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 04 Aug 2026 02:15:27 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785807571; x=1786412371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8uMaTQVWpRTf3qmAQZ1hDGbSL7Yqz0f9l0IEEeMeOXM=;
 b=B4HkU88OHHnswXGMkhutE/blgJyOwCONjDXAsnGuQD0LezLOc7Iyw6kJn6wFkkYPsg
 bc3VouE+r3iGj4dehSRLjaoT2ZlBvLxQBw2ybzVW1MfAxfoOd6iqIJD0HBPTzsn1EZqe
 pYH9cGir+dMWMQb2eJ7B/viLbIWyApDSwvBGFH5Rjt+/ueqoSkcVHo9MaQiZDf4PfjM5
 ad1tU0ts5P+q6gk2EQFfdhhafvyeRoOCPjB890MVH3YD/ZYG90U1oG1ggJAZdDjTO1m7
 sh8abB9fsUMLXa/pDEstV/nbD3gdr4zNnB+Uvk6uXA8GBoxA/BdBVkd/7PDCipzvGnYr
 +LNg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=B4HkU88O
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mlpkos@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="B4HkU88O"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Mahmoud Komaiha <mkomaiha@umich.edu>

board_spl_mmc_get_uboot_raw_sector() is guarded on
CONFIG_TARGET_SOCFPGA_ARRIA10 and CONFIG_TARGET_SOCFPGA_GEN5. Neither
symbol exists in Kconfig: the family symbols are ARCH_SOCFPGA_ARRIA10 and
ARCH_SOCFPGA_GEN5, while the per-board symbols are of the form
TARGET_SOCFPGA_ARRIA10_SOCDK / TARGET_SOCFPGA_TERASIC_DE10_NANO. These two
lines are the only references to either symbol in the tree.

The guard is therefore never true and the function is dead code on every
SoCFPGA board, so the offset of u-boot proper inside u-boot-with-spl.sfp
is never applied.

When SPL loads u-boot proper from the 0xa2 partition
(SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) the resulting load address
is the start of that partition, which holds SPL itself rather than u-boot
proper. SPL then hangs with no diagnostic after printing
"spl: mmc boot mode: raw".

Observed on a Terasic DE10-Nano (Cyclone V, GEN5) booting from SD with the
standard layout (0xa2 partition at sector 1024). Instrumenting
mmc_load_image_raw_partition() showed the computed load sector as 1024
instead of 1536. With the guard corrected the offset is applied, the load
sector becomes 1536, and the board boots to the U-Boot prompt.

Signed-off-by: Mahmoud Komaiha <mkomaiha@umich.edu>
---
 arch/arm/mach-socfpga/board.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
index 4d7f0b9a..fd7f15b3 100644
--- a/arch/arm/mach-socfpga/board.c
+++ b/arch/arm/mach-socfpga/board.c
@@ -211,8 +211,8 @@ void lmb_arch_add_memory(void)
 }
 #endif
 
-#if (defined(CONFIG_TARGET_SOCFPGA_ARRIA10) || \
-     defined(CONFIG_TARGET_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
+#if (defined(CONFIG_ARCH_SOCFPGA_ARRIA10) || \
+     defined(CONFIG_ARCH_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
 unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						 unsigned long raw_sect)
 {
-- 
2.50.1 (Apple Git-155)

