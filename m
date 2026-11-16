Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F0606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bAFPXIor;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=hpvxuYra
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 391EC80D88;
	Mon, 16 Nov 2026 16:28:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ZT4HDwTaOoH; Mon, 16 Nov 2026 16:28:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8968E8100A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846498;
	b=mfCbSj1THxDv0c7Lghjpe9itNb5uKZckIdsV68BVgh9u04VQrroAtqQptMtlB1lqluMC
	 GNwhXolunzeVSBFwY3p9dlKB59/dFTPgec8Wgh+f88DRViiE0CvljeyQ90F0Wf9aDnIci
	 tCjt77nI4z7VKh8wnkrg/DXM60AsswkW+2BSY9XrMjayJGYJzKFMq/gAe3JGQoAEKYb9w
	 v/Vvnmdx3Nq4SyA3p48xfl/Phb1RKh+kcy1uMywtq7DrqlmLBJRKGdSFNRxpK5mncx7cS
	 GfkGmvlaLjv39/pDpaWQuIY5SZSVt1Uk2JDob9OpxYVvG9HdmXZBgx6gJLJ/2E0R2Dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846498;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C8KjndYgj01FoOMzlbvmvfrHzrHW9jxSRiSIIlCziwc=;
	b=C7BdFFv0tmDS5bzaSI4SYDQCcCkXQS/8MCoW5jnKnoZUrsGEU9BY3LW/KQu+ANs3/QJF
	 6YHfVfAqMZVCAMfIgB3uir3LZklo/tf3ngLKw48umdeEgtYIVHShMbTZ157y6hSgHNO0Y
	 J47q0JYiOJcmk/LfM2L93oRIKUmzg3z8xfL2S5MZKjFxLGbQoowu488psinLs6GmL5cuB
	 2I2OXvi4go/9czEIu95kDvUZ0A2PQL9yAi+Fx8mBPHkcexbouLbNHbRuNncQxyUHKSKx9
	 RRnGNYr87jC4Vinpne/InXPvDAIr5U3ClGuDVWrXuwnvGo4BOr3MinP6H1WTcucp0vQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846498;
	bh=C8KjndYgj01FoOMzlbvmvfrHzrHW9jxSRiSIIlCziwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bAFPXIorA9CtQLlCpsdocoZtWqBT5JDsKfDgWeq0zq0DAQCVRzUTEZr41xcy/rtdf
	 AM7urmDXY5JFCH4+ko28VombwAGTfqYO8fQGDIJ3SNEmj7IxMM4d+K5GilzsyN5TYh
	 j1C1Qll8dxYb6sgX/tH3dd5lH4fCQlkof04sLtiagxhwiqXJmgMuLBLGvVHdU9YyCr
	 MeSAAQEllj9Rt/nXLuATqTCn9kmF6pa5kBJFk5xfsWxaLFQLVefoO5NjJPX/6oT/2W
	 9rtwVFvxT2Ve0/jA89jZ0aaLhgEduYRzBrXs8QiXNn/8IBJDdFJMnW++Ejw75zTtPH
	 hDgkckee+ByCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8968E8100A;
	Mon, 16 Nov 2026 16:28:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 96D4A4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8818A40692
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:28:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fmgf16DWPphc for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:28:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E272340681
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=hpvxuYra
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E272340681
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:28:16 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=hpvxuYradYgNu7j8570MvhVvYqvo/wxTJULodPrYJJkSR4H6AgQkPCVIIMOTMUfW5YovWRHXd13+rtgPXjqhXKBmbgIVCx+xAyzOVrbL72mm/A5XRKdu/WPJSt38mdP8YnfjwWWs4wCtNOR0XomJfs5vQphPNbQ8+tQb8ryCuz8=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=C8KjndYgj01FoOMzlbvmvfrHzrHW9jxSRiSIIlCziwc=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794846484772660.856745254799;
 Mon, 16 Nov 2026 08:28:04 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 17 Nov 2026 00:26:19 +0800
Subject: [PATCH v2 4/4] riscv: starfive: visionfive2: Use the common memory
 FDT fixup
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-riscv-fixup-memory-v2-4-4731aa6c3fb5@pigmoral.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=JN+adXsMi3T5sp7PLsjdz+EQg8PLn10jDvT7wdMV7Ic=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLJ+692fe2d+UnLt1l3/WNbNuiy14MuG3Q/EX5XvvV9qc
 +6YQhejbUcpC4MYF4OsmCILl7/4P2sdnm9HBFrvw8xhZQIZwsDFKQATcX3AyHCTh3f28lWvkrvP
 bTw9ydn36NJjObYeMZKrdxw74bYg+dxlhv+l0Wv0RepeyKzddvvMtOgpPx4+4H9f/2BdiklYvv5
 XlnxeAA==
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
gd->dram[], making VisionFive 2's ft_board_setup() redundant.

Remove the board hook, its unused header and global data declaration,
and disable CONFIG_OF_BOARD_SETUP.

Keep the SPL memory fixup, which passes the detected DRAM size to U-Boot
proper through the device tree.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 board/starfive/visionfive2/starfive_visionfive2.c | 7 -------
 configs/starfive_visionfive2_defconfig            | 1 -
 2 files changed, 8 deletions(-)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 97f40715f8fe..f526ce9ecf50 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -6,7 +6,6 @@
 
 #include <cpu_func.h>
 #include <dm.h>
-#include <fdt_support.h>
 #include <env.h>
 #include <log.h>
 #include <asm/arch/eeprom.h>
@@ -14,7 +13,6 @@
 #include <asm/sections.h>
 #include <linux/bitops.h>
 
-DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
 
@@ -100,8 +98,3 @@ int board_late_init(void)
 
 	return 0;
 }
-
-int ft_board_setup(void *blob, struct bd_info *bd)
-{
-	return fdt_fixup_memory(blob, 0x40000000, gd->ram_size);
-}
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index e2a1f10dbc0a..b832a65f56ce 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -38,7 +38,6 @@ CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_QSPI_BOOT=y
 CONFIG_SD_BOOT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 debug rootwait earlycon=sbi"
 CONFIG_USE_PREBOOT=y

-- 
2.56.1

