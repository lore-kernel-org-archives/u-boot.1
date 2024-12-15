Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27CEE7717F
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 23:30:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAC1A801BF;
	Mon, 16 Dec 2024 00:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1734305447;
	bh=MusT4ZOIorBrONsjspVDd8/qpNsLs43bOaUjTSRfAjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y8l28VY747E6yh1fZTLTsl20wrqXU7DvFhJfOi/w4t+RAXVXiCkkafwpv/CLwOrKP
	 H06XlTUovBxXVijOibpHCwidFMPm3nIgfgcXpQFK0GC0tmcJWIUb6899G7xAJ9Gzzu
	 gsIB/Genntm0CMWWiRQSecx0WAK02vzh9yXXyF5tafsK4k2qwrgkOVkNlZZvyxsbKQ
	 RZU97Bv2K09XR5KqxaTcRXo9x1gGX+DtBkaSBPPds+XD5ustTnKRPl3WxZjpBu6aHh
	 rdeXXRloyiOT8hpaekympAoAHgipN3N6BpuiLvhXOPeJ8KExlAuSsFITTTgRkcvxJX
	 wzpjwGii5o/DQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AB0E80192; Mon, 16 Dec 2024 00:30:45 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E8F3800D7
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 00:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Jz9462vT"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F0EBA1049AF74; Mon, 16 Dec 2024 00:30:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1734305442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MusT4ZOIorBrONsjspVDd8/qpNsLs43bOaUjTSRfAjM=;
 b=Jz9462vT8cn4jGP4I7Lhvyp5yc+G1flgtW4kHNjnE+by0DhSO9RrSt3FWqw9snKleysV3W
 IA0DeWypbz3GOFT3BPHiZ2c1hX0b9fl9pp0X15XPpQ0Nki4VeP6YJmvf/mL/7LJFtF7cA4
 7M2URqpbKMkMF74YT2fcbOuq3CFmyNAEKVn71JMQEcif3fZ3Era31JjdD1Vw4YhNRe/FGe
 oPvLDGjSbAH5ToFBu9UPhSaHX3KspSgXRr6IqcBEzXFCTEgFR16x0jBN52uuB7e5T0xhdb
 /Thit0xmv35rEeNcIPQriNG5f27Hd2HIuDCYNcpvTQmWQaU879dmtm7OITbmWw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/4] ARM: dts: stm32: Reinstate SPL_SYS_MMCSD_RAW_MODE on DH
 STM32MP15xx DHSOM
Date: Mon, 16 Dec 2024 00:29:13 +0100
Message-ID: <20241215233011.569287-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241215233011.569287-1-marex@denx.de>
References: <20241215233011.569287-1-marex@denx.de>
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

Commit 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
broke booting from SD card on STM32MP15xx , reinstate raw mode SD
boot configuration options and select the correct raw mode partition
for STM32MP15xx to fix SD boot on STM32MP15xx DHSOM.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
Reported-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
NOTE: For 2025.01
---
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 configs/stm32mp15_dhsom.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/stm32mp15_dhsom.config b/configs/stm32mp15_dhsom.config
index efc149577ea..04ee9bfc444 100644
--- a/configs/stm32mp15_dhsom.config
+++ b/configs/stm32mp15_dhsom.config
@@ -57,11 +57,14 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_STACK=0x30000000
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x1d00000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SPL_TEXT_BASE=0x2FFC2500
 CONFIG_SPL_USB_GADGET=y
 CONFIG_STM32_ADC=y
 CONFIG_SYSRESET_SYSCON=y
 CONFIG_SYS_BOOTCOUNT_ADDR=0x5C00A14C
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x3
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MALLOC_F_LEN=0x3000
 CONFIG_SYS_PBSIZE=1050
 CONFIG_PREBOOT="run dh_preboot"
-- 
2.45.2

