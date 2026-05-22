Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797B7CD5BB1
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 11:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00BFC843B6;
	Fri, 22 May 2026 13:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="BFZMC48v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A244846DF; Fri, 22 May 2026 13:09:28 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BAB4841D7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 13:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=/HRf/kDqtg1HIGJbiSl2nRG/23z2on9dIVGbdVxdytQ=; b=BFZMC48vMs3jdNuSU/gxgqhi1W
 6K5OLc/tm8IH0pnFLTZi2ha2iqUjHnh+0TnFE9zUYwUS65rK53a8TtqFf0jzQgkgfFfUEJ2PneeBU
 B8ZH+xSBaab1yZOnoWK+uTila1Bk2Ifw/aKAh5i9lA5Rlw38hdmXJ5SuWZzKyFMBt5giwCu6jS8Z1
 py3S3S6J5xA9YNvUSGgBrOcW/IVG7liCws0ZI04XbnIG8WJeV7xkTsczErGdBs8ZIq+RA/dVbSvqD
 xTggcVjt1CtaIShY4LlILWl8X49Q4cO0O4LqcdLcScxc0IZsAQ2+QvmjlOa+9QH/POs6KqueiB2df
 SAg8XyYw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQNkr-00052B-1t; Fri, 22 May 2026 13:09:25 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQNkq-000MsE-2D; Fri, 22 May 2026 13:09:25 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/1] board: tqma7: update fastboot env
Date: Fri, 22 May 2026 13:09:15 +0200
Message-Id: <20260522110915.2269457-1-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Replace magic value with documented variable.
While at it, restrict fastboot env guard to USB
as its the only supported fastboot method.

Fixes d000ce5efee3 ("board: tqma7: add code for u-boot with spl")

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 board/tq/tqma7/tqma7.env | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/board/tq/tqma7/tqma7.env b/board/tq/tqma7/tqma7.env
index 857f16d11bb..05035078869 100644
--- a/board/tq/tqma7/tqma7.env
+++ b/board/tq/tqma7/tqma7.env
@@ -28,8 +28,15 @@ uboot_spi_sector_size=TQMA7_SPI_FLASH_SECTOR_SIZE
 uboot_spi_start=TQMA7_SPI_UBOOT_START
 uboot_spi_size=TQMA7_SPI_UBOOT_SIZE
 
-#ifdef CONFIG_FASTBOOT_UUU_SUPPORT
+#ifdef CONFIG_USB_FUNCTION_FASTBOOT
+
+/* 0=user 1=boot1 2=boot2 */
+fastboot_mmc_boot_partition = 1
+
 fastboot_partition_alias_all=CONFIG_FASTBOOT_FLASH_MMC_DEV:0
-fastboot_raw_partition_bootloader=TQMA7_MMC_UBOOT_SECTOR_START TQMA7_MMC_UBOOT_SECTOR_COUNT mmcpart 1
+fastboot_raw_partition_bootloader=
+	TQMA7_MMC_UBOOT_SECTOR_START TQMA7_MMC_UBOOT_SECTOR_COUNT mmcpart
+	"${fastboot_mmc_boot_partition}"
 fastbootcmd=fastboot usb 0
+
 #endif
-- 
2.34.1

