Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1A1C4707B
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 18:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6546D8795E;
	Sat, 13 Jan 2024 19:34:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705170848;
	bh=cWEnLH+l2mJSDNilU0FkQaM6IKXNgOMqqXPNnMHraSo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cLj0yS6Ajv/bzvMT/6lGXfNW4licghoR5V7eM+CKGwoZRWxBl/DxXRWOOR7hu3vQW
	 NPB9SCuF16YB/7suvADOtiNqcLeY5bk+hHIH22IHHLON84c4FBmjOHTkmnoIU+MUeP
	 I2BSduvBKepmPbztnIZcPUt1ofZ5hXckGMQFsd6algoemwqHhinf7jtKVztLu5PS9g
	 mjI3FlI3Zz8p8TopzZpvsN1hmnTciUS+sQAbp0ZuRwtZYM6L9+hP6vEo9kg/TYJG6M
	 riKdK06iZEDiGTOSSTt2kurQK5oF36GkV3gzpeyCOHYaP8P/eeu1N946Q57MfEIstM
	 fpiFsY0QhHp7A==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5EC8387883;
 Sat, 13 Jan 2024 19:34:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705170847;
 bh=cWEnLH+l2mJSDNilU0FkQaM6IKXNgOMqqXPNnMHraSo=;
 h=From:To:Cc:Subject:Date:From;
 b=CRYlngTf66H2rfEmIVwx3HATFoR6NuvujAeWNYSmirEBXf84MzyDOFdSQadioqzhi
 Ar3o+wFJOLTx9LeoFwT7a9tb2cWrFfAXWk2JBZAny+IRhxs4mCVt/RRyDYY6kY6xfM
 9NGvXL5OMHbUD/wZH21WEWOAGPxTqFNxvJGAVWepW54+fMZiQVJOmkwADr0a4kI840
 4BiZDlY8uSprwGul2dNLxsHtz9wsbLKz4phOZ5D6cW4qadRPl31fMNWNUUm7HzkoDJ
 ZuH6fXZCY4odZRNK0U1e/coQqJrMFf55tcXNMPHVLAXIgWzy5hB6btqFwz7ExkMoSL
 63nhCCS8/NKhQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Stefano Babic <sbabic@denx.de>
Subject: [RFC][PATCH] ARM: imx: verdin-imx8mm: Set CAN oscillator frequency
 based on model
Date: Sat, 13 Jan 2024 19:33:17 +0100
Message-ID: <20240113183350.176131-1-marex@denx.de>
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

The older i.MX8M Mini Verdin SoMs before rev. 1.1C came with 20 MHz SPI CAN
controller oscillator, the newer SoMs use 40 MHz oscillator. Handle both by
overriding the oscillator frequency just before booting the kernel.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Philippe Schenker <philippe.schenker@toradex.com>
Cc: Stefano Babic <sbabic@denx.de>
---
 board/toradex/verdin-imx8mm/verdin-imx8mm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
index b2781b51d6a..8bc1a51eeb1 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -142,6 +142,25 @@ int board_phys_sdram_size(phys_size_t *size)
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
+	const char *canoscpath = "/oscillator";
+	int canoscoff, freq, ret;
+
+	canoscoff = fdt_path_offset(blob, canoscpath);
+	if (canoscoff < 0)	/* No CAN oscillator found. */
+		goto exit;
+
+	if (tdx_hw_tag.ver_assembly < 2)        /* rev. A or B */
+		freq = 20000000;
+	else					/* rev. C or newer */
+		freq = 40000000;
+
+	ret = fdt_setprop_u32(blob, canoscoff, "clock-frequency", freq);
+	if (ret < 0) {
+		printf("Failed to set CAN oscillator clock-frequency, ret=%d\n",
+			ret);
+	}
+
+exit:
 	return ft_common_board_setup(blob, bd);
 }
 #endif
-- 
2.43.0

