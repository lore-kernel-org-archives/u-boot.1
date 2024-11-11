Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07DDD41D46
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 884308862E;
	Tue, 12 Nov 2024 03:47:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=qrv-systems.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9A6F89379; Mon, 11 Nov 2024 20:24:20 +0100 (CET)
Received: from mr4.vodafonemail.de (mr4.vodafonemail.de [145.253.228.164])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1171C89371
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 20:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=qrv-systems.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr4.vodafonemail.de (Postfix) with ESMTPS id 4XnKH65vYcz20hQ;
 Mon, 11 Nov 2024 19:24:18 +0000 (UTC)
Received: from tachyon.qrv-systems.net
 (ip-095-222-025-162.um34.pools.vodafone-ip.de [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4XnKGz3sq8z8sZp;
 Mon, 11 Nov 2024 19:24:08 +0000 (UTC)
Received: by tachyon.qrv-systems.net (Postfix, from userid 516)
 id E44912E01D4; Mon, 11 Nov 2024 20:24:07 +0100 (CET)
From: Yuri Zaporozhets <yuriz@qrv-systems.net>
To: u-boot@lists.denx.de
Cc: Yuri Zaporozhets <yuriz@qrv-systems.net>
Subject: [PATCH] spl: increase SPL_SYS_MALLOC_SIZE when using BIOSEMU on RISC-V
Date: Mon, 11 Nov 2024 20:24:04 +0100
Message-Id: <20241111192404.79676-1-yuriz@qrv-systems.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 795
X-purgate-ID: 155817::1731353054-2EFE4465-4C40DD64/0/0
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:32 +0100
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

If BIOSEMU is compiled for RISC-V (SiFive Unmatched board) and the function
dm_pci_run_vga_bios() is executed, U-Boot stops with error message saying
that the SPL malloc pool is too small. So increase the default pool size
when both BIOSEMU and RISCV parameters are set.

Signed-off-by: Yuri Zaporozhets <yuriz@qrv-systems.net>
---
 common/spl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 045fcac10a..240543c9c7 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -462,6 +462,7 @@ config SPL_CUSTOM_SYS_MALLOC_ADDR
 config SPL_SYS_MALLOC_SIZE
 	hex "Size of the SPL malloc pool"
 	depends on SPL_SYS_MALLOC
+	default 0x180000 if BIOSEMU && RISCV
 	default 0x100000
 
 config SPL_READ_ONLY
-- 
2.39.5

