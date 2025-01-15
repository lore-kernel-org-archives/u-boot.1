Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7DDC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 16:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E130E806FB;
	Wed, 15 Jan 2025 17:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="r1kro7ea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A9AA8033D; Wed, 15 Jan 2025 17:16:30 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 659AA806D4
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AAFC81484D4E; Wed, 15 Jan 2025 17:16:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1736957787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SF/FKxc1gwawXc4jzu7qWcy9JcokJGzxF9CRlOY2nTw=;
 b=r1kro7eabiAcF7GkSsLGJoFXqR/x/ur1L0RjZ+57pnFVpTUtt17NlK4JNz636/Av+meOuK
 +tPvYiD/vaY4N7eZr/MzpMVMR1zIguoIGAcVmLowVhmy7CiX+LerR4Gw+7bZor34AB0mRH
 BnX2KU6a4h9rvezYaJhhbtnYIfAfhF5T0hLGx5945YvgGWKACxaU3EouK+EAVNrWwrn9Ne
 oCMNsqudSWTS33LiLfUKJ9L06SM3i5DZlPqfoi9eM2qSDmwzSwVwSTMQo3zZz7FrqLdNkp
 foWq/eHgOlI/S2ZmGeJPKiZrIHam7awfdHj2yRxlJmYUuaNaQeJqr4xs0Q5XgQ==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/2] spi: atmel: Really drop atmel_spi.h
Date: Wed, 15 Jan 2025 17:16:20 +0100
Message-Id: <20250115161621.1551826-2-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250115161621.1551826-1-ada@thorsis.com>
References: <20250115161621.1551826-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

First try dropping this was with commit 37434db29be4 ("spi: atmel: Drop
atmel_spi.h") back in 2018 which was reverted not much later with commit
5270df283676 ("Revert "spi: atmel: Drop atmel_spi.h"").

Second try dropping this was in 2020 with commit beeb34ac0cc6 ("spi:
atmel: Drop atmel_spi.h"), but that only moved all the definitions into
the source file and did not remove the header file.

Currently all of the definitions in the header file are (still)
contained in the source file, and the header file is include nowhere.

Fixes: beeb34ac0cc6 ("spi: atmel: Drop atmel_spi.h")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    Build tested for all upstream atmel boards.  This is no complete build
    coverage, but should be safe to remove, because it is not included
    anywhere.

 drivers/spi/atmel_spi.h | 86 -----------------------------------------
 1 file changed, 86 deletions(-)
 delete mode 100644 drivers/spi/atmel_spi.h

diff --git a/drivers/spi/atmel_spi.h b/drivers/spi/atmel_spi.h
deleted file mode 100644
index 9663cca5e66..00000000000
--- a/drivers/spi/atmel_spi.h
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
- * Register definitions for the Atmel AT32/AT91 SPI Controller
- */
-
-/* Register offsets */
-#include <linux/bitops.h>
-#define ATMEL_SPI_CR			0x0000
-#define ATMEL_SPI_MR			0x0004
-#define ATMEL_SPI_RDR			0x0008
-#define ATMEL_SPI_TDR			0x000c
-#define ATMEL_SPI_SR			0x0010
-#define ATMEL_SPI_IER			0x0014
-#define ATMEL_SPI_IDR			0x0018
-#define ATMEL_SPI_IMR			0x001c
-#define ATMEL_SPI_CSR(x)		(0x0030 + 4 * (x))
-#define ATMEL_SPI_VERSION		0x00fc
-
-/* Bits in CR */
-#define ATMEL_SPI_CR_SPIEN		BIT(0)
-#define ATMEL_SPI_CR_SPIDIS		BIT(1)
-#define ATMEL_SPI_CR_SWRST		BIT(7)
-#define ATMEL_SPI_CR_LASTXFER		BIT(24)
-
-/* Bits in MR */
-#define ATMEL_SPI_MR_MSTR		BIT(0)
-#define ATMEL_SPI_MR_PS			BIT(1)
-#define ATMEL_SPI_MR_PCSDEC		BIT(2)
-#define ATMEL_SPI_MR_FDIV		BIT(3)
-#define ATMEL_SPI_MR_MODFDIS		BIT(4)
-#define ATMEL_SPI_MR_WDRBT		BIT(5)
-#define ATMEL_SPI_MR_LLB		BIT(7)
-#define ATMEL_SPI_MR_PCS(x)		(((x) & 15) << 16)
-#define ATMEL_SPI_MR_DLYBCS(x)		((x) << 24)
-
-/* Bits in RDR */
-#define ATMEL_SPI_RDR_RD(x)		(x)
-#define ATMEL_SPI_RDR_PCS(x)		((x) << 16)
-
-/* Bits in TDR */
-#define ATMEL_SPI_TDR_TD(x)		(x)
-#define ATMEL_SPI_TDR_PCS(x)		((x) << 16)
-#define ATMEL_SPI_TDR_LASTXFER		BIT(24)
-
-/* Bits in SR/IER/IDR/IMR */
-#define ATMEL_SPI_SR_RDRF		BIT(0)
-#define ATMEL_SPI_SR_TDRE		BIT(1)
-#define ATMEL_SPI_SR_MODF		BIT(2)
-#define ATMEL_SPI_SR_OVRES		BIT(3)
-#define ATMEL_SPI_SR_ENDRX		BIT(4)
-#define ATMEL_SPI_SR_ENDTX		BIT(5)
-#define ATMEL_SPI_SR_RXBUFF		BIT(6)
-#define ATMEL_SPI_SR_TXBUFE		BIT(7)
-#define ATMEL_SPI_SR_NSSR		BIT(8)
-#define ATMEL_SPI_SR_TXEMPTY		BIT(9)
-#define ATMEL_SPI_SR_SPIENS		BIT(16)
-
-/* Bits in CSRx */
-#define ATMEL_SPI_CSRx_CPOL		BIT(0)
-#define ATMEL_SPI_CSRx_NCPHA		BIT(1)
-#define ATMEL_SPI_CSRx_CSAAT		BIT(3)
-#define ATMEL_SPI_CSRx_BITS(x)		((x) << 4)
-#define ATMEL_SPI_CSRx_SCBR(x)		((x) << 8)
-#define ATMEL_SPI_CSRx_SCBR_MAX		GENMASK(7, 0)
-#define ATMEL_SPI_CSRx_DLYBS(x)		((x) << 16)
-#define ATMEL_SPI_CSRx_DLYBCT(x)	((x) << 24)
-
-/* Bits in VERSION */
-#define ATMEL_SPI_VERSION_REV(x)	((x) & 0xfff)
-#define ATMEL_SPI_VERSION_MFN(x)	((x) << 16)
-
-/* Constants for CSRx:BITS */
-#define ATMEL_SPI_BITS_8		0
-#define ATMEL_SPI_BITS_9		1
-#define ATMEL_SPI_BITS_10		2
-#define ATMEL_SPI_BITS_11		3
-#define ATMEL_SPI_BITS_12		4
-#define ATMEL_SPI_BITS_13		5
-#define ATMEL_SPI_BITS_14		6
-#define ATMEL_SPI_BITS_15		7
-#define ATMEL_SPI_BITS_16		8
-
-/* Register access macros */
-#define spi_readl(as, reg)					\
-	readl(as->regs + ATMEL_SPI_##reg)
-#define spi_writel(as, reg, value)				\
-	writel(value, as->regs + ATMEL_SPI_##reg)
-- 
2.39.5

