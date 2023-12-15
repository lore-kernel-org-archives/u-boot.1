Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462B6C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A257887BDC;
	Fri, 15 Dec 2023 14:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BsJto7hR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF55987BDD; Fri, 15 Dec 2023 14:32:58 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E651487BC0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:32:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4DF8440212; 
 Fri, 15 Dec 2023 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702647175;
 bh=6trO8TkvSjAUMR8dBjkR1dDfFKNy4iCtk4x3p1Hx/zc=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=BsJto7hRRErWt13eN7yvKBDsue3b1Of7FFS3RvR8G5e+PYLbOwxX+S8a6Uq2bH/TW
 hu0YYS88QKUeG4ozEpqclnvLiNPt59sfL3czBQ3vdSSDCVGR2ioFagx+1zrBij2G2A
 nN8/cGv4lQBJFpI5SXdrX1NpsVs+AKtWd6ZfcRSaCZ3EYCJtdXLVOBHNRk2Qcqdzch
 kRbqNVxOSCBICduIOoaqsaUSMbTQ6KRBn0/3Y2bvcHFPYVUq2Qwr5gs3Ii6SkQNcID
 Nn5mdZRst5mL7Sym+hXbRBlcQ5p4jx2ZZkg0IoUDj6MWKR8ku33JXXHRfLLx+Cn1wP
 wQhv+ruv/fr0w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 6/9] risc-v: add support for QEMU firmware tables
Date: Fri, 15 Dec 2023 14:32:42 +0100
Message-Id: <20231215133245.7923-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
References: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
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

Enable the QEMU firmware interface if ACPI tables are to be supported on
the QEMU platform.

Enable the QFW MMIO interface if the QEMU firmware interface is enabled.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
	no change
---
 board/emulation/qemu-riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
index 2709c9ca1e..59cf66896e 100644
--- a/board/emulation/qemu-riscv/Kconfig
+++ b/board/emulation/qemu-riscv/Kconfig
@@ -33,6 +33,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
 	select GENERIC_RISCV
 	select SUPPORT_SPL
+	select QFW if ACPI
+	select QFW_MMIO if QFW
 	imply AHCI
 	imply SMP
 	imply BOARD_LATE_INIT
-- 
2.40.1

