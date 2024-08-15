Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7DEC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 08:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF70188A29;
	Thu, 15 Aug 2024 10:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723709405;
	bh=efJO5G58F0gEctwu3FgAMvIyEfS59IkqA2cUjzguJFA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=skn8pHttEfyNeR63UA30jmUg0YJl62of0xppKeroVYI4xp48lEcEpvMackpm4Yb29
	 pNDKvL+Rd39Ct9cf5YoHlpi2aqDK89RtQnyl79FpJEzkwPV4wKbuLqm7qhG/7tYYzz
	 gCB0N2ZKMe/sECt2PgshI70RWOXruEAGc56wm1NSkvCPjaFc/WF/6xHbXNYGd5b0g+
	 CXKE/jUertlrs3c4WSZ6q5O+LB61zYW+6IvfWzslmuBK8gGmjdD4hHAnTn23oJGPb2
	 e2Yh9iW9txqdz9CecNST5o6HkSDKmkx9MpMW90seGFUgDlJDbRx2KB/5+DiMNP0ykN
	 qo8xgOBUf+luw==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E4D36889C9;
 Thu, 15 Aug 2024 10:10:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723709405;
 bh=efJO5G58F0gEctwu3FgAMvIyEfS59IkqA2cUjzguJFA=;
 h=From:To:Cc:Subject:Date:From;
 b=YBqXM+9D6aG+ShLXR/f5sXzlMxF+AZfh0AdbFe27gV4Dhf2KcRXJZM4SQCjM3jN8w
 ze7riMQN6LhfiHVr06HRZNgKIyVNGxbaoDH6ru1jA81XsDA+09tkCnyRo6HCj3M0r/
 ULKPrk3mtIyB9h3rg2A2YDIWIamK044yMN0wFBNww5DKrPHyoBKJYlBTsEzYcz3Ve2
 lhQA64Y2c7lWBYzQVL8/zYROI+X9uxkrMTcNW+G3PtYTJxu7bWUaKBcu8vfkS4eEWG
 INBmNLLmTkhCgMoN9y2ucdSbKttRts9A1OcsZ7HhYGRQdqWK3U2SxXtug/uj1jMsOo
 tsvNbCBn0b5+g==
From: Lukasz Majewski <lukma@denx.de>
To: Teresa Remmet <t.remmet@phytec.de>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] config: imx: Define CFG_SYS_UBOOT_BASE for Phytec's imx8mm
 SoM QSPI boot
Date: Thu, 15 Aug 2024 10:09:48 +0200
Message-Id: <20240815080948.457524-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
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

The image offset when booting from SPI-NOR (QSPI, FSPI driver) is
different than one for SD card / eMMC as extra space (0x1000) is consumed
by FSPI configuration header (CONFIG_FSPI_CONF_HEADER).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 include/configs/phycore_imx8mm.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/configs/phycore_imx8mm.h b/include/configs/phycore_imx8mm.h
index 0910ae2d87..92c30022a8 100644
--- a/include/configs/phycore_imx8mm.h
+++ b/include/configs/phycore_imx8mm.h
@@ -11,8 +11,17 @@
 #include <linux/stringify.h>
 #include <asm/arch/imx-regs.h>
 
+#define UBOOT_ITB_OFFSET			0x57C00
+#define FSPI_CONF_BLOCK_SIZE		0x1000
+#define UBOOT_ITB_OFFSET_FSPI  \
+	(UBOOT_ITB_OFFSET + FSPI_CONF_BLOCK_SIZE)
+#ifdef CONFIG_FSPI_CONF_HEADER
+#define CFG_SYS_UBOOT_BASE  \
+	(QSPI0_AMBA_BASE + UBOOT_ITB_OFFSET_FSPI)
+#else
 #define CFG_SYS_UBOOT_BASE \
 		(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
+#endif
 
 #ifdef CONFIG_SPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
-- 
2.39.2

