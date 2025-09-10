Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11E4CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 09:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1CFB8323A;
	Wed, 10 Sep 2025 11:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A65830B4; Wed, 10 Sep 2025 11:23:41 +0200 (CEST)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id 71FB982B20
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hayashi.kunihiko@socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 10 Sep 2025 18:23:36 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
 by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id 2ED432069FC4;
 Wed, 10 Sep 2025 18:23:36 +0900 (JST)
Received: from kinkan3.css.socionext.com ([172.31.9.51]) by m-FILTER with
 ESMTP; Wed, 10 Sep 2025 18:23:36 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
 by kinkan3.css.socionext.com (Postfix) with ESMTP id EB0A91757;
 Wed, 10 Sep 2025 18:23:35 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: u-boot@lists.denx.de
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tom Rini <trini@konsulko.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/2] board: qemu-sbsa: Fix mistyped GICV3 definition
Date: Wed, 10 Sep 2025 18:23:27 +0900
Message-Id: <20250910092327.279749-3-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910092327.279749-1-hayashi.kunihiko@socionext.com>
References: <20250910092327.279749-1-hayashi.kunihiko@socionext.com>
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

The config "GIC_V3" seems to be typo, and currently "GICV3" remains
disabled. Since "GIC_V3_ITS" is enabled in qemu-sbsa, "GICV3" should
also be enabled.

Fixes: 6d722894fd48 ("board: emulation: Add QEMU sbsa support")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 board/emulation/qemu-sbsa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/emulation/qemu-sbsa/Kconfig b/board/emulation/qemu-sbsa/Kconfig
index 9ea6303ec9ca..1f058a439328 100644
--- a/board/emulation/qemu-sbsa/Kconfig
+++ b/board/emulation/qemu-sbsa/Kconfig
@@ -34,7 +34,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	select PCIE_ECAM_GENERIC
 	select SYS_PCI_64BIT
 	select USB
-	select GIC_V3
+	select GICV3
 	select GIC_V3_ITS
 	select SYS_FLASH_CFI_WIDTH_16BIT
 	imply AHCI_GENERIC
-- 
2.34.1

