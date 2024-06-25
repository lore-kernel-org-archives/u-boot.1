Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E94EC30653
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 08:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA669884F6;
	Tue, 25 Jun 2024 10:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719304012;
	bh=u4GLnNICl/FM6/zEs2izo0+EErR0f9NiGG3RmpprGzA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FCRyTFJQrqy3kW1SmoHzOxO+5RVLD+4aciS0JAAD+bfG/4NZ2yH0TxjGXBttpEdzz
	 9Jc77lEb+Ci3+UCo/WMJyzx62viy2mNtqOejXqoLdyXFA5PXK420GWCfDrPkcnqgTp
	 Ho32KR6B9CKlc18FKPY/5Q2JAlkausEOQdevcmEEv/SuB1wJiLxLMUHFRsvGoQBJDg
	 AOE95niztqoPURPKbPuGIVg2NknzAufBmsHhDL+UzWfby26YYHELYjeqxBxSXMM9zQ
	 243RNI1PO2gFqinBaufnLZWg7BNrRcomNmD/Uw4EGr1lSRbBiN6WQJHSD36Vv+ZWb8
	 OzUVi9/Bi2W3A==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 965CB884DB;
 Tue, 25 Jun 2024 10:26:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719304011;
 bh=u4GLnNICl/FM6/zEs2izo0+EErR0f9NiGG3RmpprGzA=;
 h=From:To:Cc:Subject:Date:From;
 b=E1cMBNJmJKUO/4eXLVhTNRb8mKvYO4WpRwL5p9hNKgd23rDnnOfILdZ2EXTTcMIHR
 ap8fEVjpSAwE1zHxrNsb7CK5ItwqGOpDK5G62nOz2JkMnvqPjXwmh6IKdyNQvxtWRC
 DSpOg0XZjd18HV5gBFNDUcibWyCNBsQ4knjQKGutFDr7HdQ+ocoh8vlTlhJPB2KSq/
 NIg4ul91WvQzna9W2NMFbprhljokgkd439JYzh9huzOOab2l1bpOmFI+KgmEeB6y3G
 e2cIb0iNa/s5/qY71qT2m4GNGRCwMdImPV3T+t/jKRN3RnMFjyGT9QelHGxStrn1gg
 Hc53LnqozH9aA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH v3] ARM: imx: verdin-imx8mm: Set CAN oscillator frequency
 based on model
Date: Tue, 25 Jun 2024 10:26:15 +0200
Message-ID: <20240625082638.8867-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

The older i.MX8M Mini Verdin SoMs may came with 20 MHz SPI CAN controller
oscillator, the newer SoMs always use 40 MHz oscillator. Handle both by
overriding the oscillator frequency just before booting the kernel.

These are the known variants with 20 MHz oscillator:
- 0055, V1.1A, V1.1B, V1.1C and V1.1D, use a 20MHz oscillator
- 0059, V1.1A and V1.1B, use a 20MHz oscillator

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Martyn Welch <martyn.welch@collabora.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@lists.denx.de
---
V2: - Update the comment in conditional statement
    - Update ver_assembly check for 0055 rev.A/B/C/D
V3: - Update code comment per upstream feedback
---
 board/toradex/verdin-imx8mm/verdin-imx8mm.c | 29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
index 55c02653da6..59cc28f652f 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -125,6 +125,35 @@ int board_phys_sdram_size(phys_size_t *size)
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
+	const char *canoscpath = "/oscillator";
+	int freq = 40000000;	/* 40 MHz is used on most variants */
+	int canoscoff, ret;
+
+	canoscoff = fdt_path_offset(blob, canoscpath);
+	if (canoscoff < 0)	/* No CAN oscillator found. */
+		goto exit;
+
+	/*
+	 * The following "prodid" (PID4 in Toradex naming) use
+	 * a 20MHz CAN oscillator:
+	 * - 0055, V1.1A, V1.1B, V1.1C and V1.1D
+	 * - 0059, V1.1A and V1.1B
+	 */
+	if ((tdx_hw_tag.ver_major == 1 && tdx_hw_tag.ver_minor == 1) &&
+	    ((tdx_hw_tag.prodid == VERDIN_IMX8MMQ_IT &&
+	      tdx_hw_tag.ver_assembly <= 1) ||	/* 0059 rev. A or B */
+	     (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WIFI_BT_IT &&
+	      tdx_hw_tag.ver_assembly <= 3))) {	/* 0055 rev. A/B/C/D */
+		freq = 20000000;
+	}
+
+	ret = fdt_setprop_u32(blob, canoscoff, "clock-frequency", freq);
+	if (ret < 0) {
+		printf("Failed to set CAN oscillator clock-frequency, ret=%d\n",
+		       ret);
+	}
+
+exit:
 	return ft_common_board_setup(blob, bd);
 }
 #endif
-- 
2.43.0

