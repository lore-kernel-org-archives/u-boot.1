Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B18C25B74
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 00:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 187DE8844E;
	Wed, 22 May 2024 02:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716337294;
	bh=NBfIA8IjVQZk94zbzALGq++Ui+W6ejbont8clGw/rVs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ASfzcREJq3kZrRG8BcqJDwkJaBNRTawS2TAQflojtzOdh3TuWNdRYhCAkgfCrznBo
	 /KqsiTFba3BlTMa2Wd/45wxuu2m7evoW2pGGQe1FFeL5hnl7xrr5/JNczwkoug2joY
	 FrL8WDSQOGaBKSXVbNIwjAcF9MTrMHdi/mBYAX9rf6PeVk8o/KdDuCkAQ+7IwS02Dr
	 zgww00y8fGpEl1j3UDGAdCvVlYgKcSJ4gsoTFAK/Ma3adaPdOUp7guuKKcaSc+xMOL
	 0bpx7T0E0me0pqhnXra+0uiTE0h6fU+kNFYNELUsbU07R7E2vBXRYg4sKW0uMKF/Mj
	 ZBmslVYdiudvw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 58F7188464;
 Wed, 22 May 2024 02:21:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1716337292;
 bh=NBfIA8IjVQZk94zbzALGq++Ui+W6ejbont8clGw/rVs=;
 h=From:To:Cc:Subject:Date:From;
 b=VxZAB+lsUZ9owmSfdGgEA4weRqhNpjUaKyZr8hlzBkSw5KGuMoqAmPk1dNMQR/eiw
 3ETc0Ryd80E/H471zpGWOwtZjgURq+EZ4MKT8knmHLEa+hvzggXvsK2k5dQK+fYugV
 CaEK9jf5iBEtJrVX80T57uwR62erQ20a+jU7QYSSwvx3dTzqyThSGkqSvusuqrMbSl
 uq1thdOs+R3QgPwOmvsFazAI/Zvop7DkKoXiY0y61hUoyUgT1txAAByHBXMAyB62PN
 jMYX8jU3mwX84PW+C3ehT+fopjv4adT6vreY32tfLhUp3W3Jz09FdqGu/cvCYmbSo8
 4o5Ecvr1/Sfpg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2] ARM: imx: verdin-imx8mm: Set CAN oscillator frequency
 based on model
Date: Wed, 22 May 2024 02:21:14 +0200
Message-ID: <20240522002122.50796-1-marex@denx.de>
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
---
 board/toradex/verdin-imx8mm/verdin-imx8mm.c | 30 +++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
index 55c02653da6..ef632d95f0a 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -125,6 +125,36 @@ int board_phys_sdram_size(phys_size_t *size)
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
+	 * The actual "prodid" (PID4 in Toradex naming) that have the CAN
+	 * functionality are 0055 and 0059. Special case 20 MHz variant
+	 * here:
+	 * - 0055, V1.1A, V1.1B, V1.1C and V1.1D, use a 20MHz oscillator
+	 * - 0059, V1.1A and V1.1B, use a 20MHz oscillator
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

