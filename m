Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E924C83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 22:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA70382E34;
	Tue, 29 Jul 2025 00:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WxH3X0jT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OhnLIpIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6353082EB8; Tue, 29 Jul 2025 00:39:05 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6510182D21
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 00:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4brYLG0kZ6z9t8w;
 Tue, 29 Jul 2025 00:39:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753742342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=D61wAKYzSpC6oB+suuX+Rh7E12Sk/QlCXYBNdGKW3sM=;
 b=WxH3X0jTp0jinjxG5wNDLPAgXuElMDCLIMYsk1M3dSm0L6PjIN51vd6ajMLaGO0WJSSfeo
 kIjaP8zgNGAL4F/miC0hFhIBddMePbmTVnZlEfVjVyaYWVVc1HfnhL+Z/nUBD7X41lJHgq
 pDj+acLu8oQAsHqNra9EsN5OQFv1zaEFtc6kBakooEsSWDp5cmpWMPZxFyl0tNfuiGizc/
 LfIbFh1hDQ7q6bzBsbX7gKUomm/j8T67bTGsuzogdSdhoDzGHzadAFGyS6270LWbhQM51x
 K4uf6nzN4sDBCGUCzZlm9VNsWJtARbBESr60ukHRwvyeFCDGMwIV7ROOg9IpWw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=OhnLIpIT;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753742340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=D61wAKYzSpC6oB+suuX+Rh7E12Sk/QlCXYBNdGKW3sM=;
 b=OhnLIpITymPxquTMNsn75u8LDUTWYFnxl83XltBM7n5zrKj+QAt3Ut7d29iNMVYZoUX+wr
 gAkafaWEIUjUbmRSCQMjWxSOfL0AUcRA/dp0ZbMsOEyDgmeCVwVIshTq/C5LO4iNAoCPK8
 SFKspI1NxuT96EkEyTMP+w7CyhTiXOOegmkgNaPUdQi3EKnn8Jhsr+T0xe8i5q5WzPThrB
 ETRHmk1mL2ObOnVIluK0LQcai0o9jevl6wm1+BcrTW55bd+jurFLH1Gti/dN5yHtSH+wdT
 LMvzZYa1H3VuzjXSWYM+zMYw/jbmICDjYyyDBwt9m2xYGVHX2fgLlmqBifQs3Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
Subject: [PATCH] ARM: imx6: dh-imx6: Enable USB OTG ID pin pull up in SPL
Date: Tue, 29 Jul 2025 00:38:34 +0200
Message-ID: <20250728223849.87212-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2275760f0c8474133d6
X-MBO-RS-META: 1qrkwncdhq8zb7trs673p74uo7zohaai
X-Rspamd-Queue-Id: 4brYLG0kZ6z9t8w
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

Enable SoC pull up for USB OTG ID pin in SPL. There is no dedicated pull up
resistor on the SoM itself, and the pull up is mandatory for correct USB OTG
ID pin detection. U-Boot proper already configures the USB OTG ID pin pull
up via DT pinctrl node entry.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 board/dhelectronics/dh_imx6/dh_imx6_spl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/board/dhelectronics/dh_imx6/dh_imx6_spl.c b/board/dhelectronics/dh_imx6/dh_imx6_spl.c
index a50763e1926..eb9bc93d973 100644
--- a/board/dhelectronics/dh_imx6/dh_imx6_spl.c
+++ b/board/dhelectronics/dh_imx6/dh_imx6_spl.c
@@ -49,6 +49,10 @@
 	(PAD_CTL_PUS_47K_UP | PAD_CTL_SPEED_LOW | PAD_CTL_DSE_80ohm |	\
 	 PAD_CTL_SRE_FAST | PAD_CTL_HYS)
 
+#define OTG_PAD_CTRL							\
+	(PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm |	\
+	 PAD_CTL_SRE_SLOW | PAD_CTL_HYS)
+
 static const struct mx6dq_iomux_ddr_regs dhcom6dq_ddr_ioregs = {
 	.dram_sdclk_0	= 0x00020030,
 	.dram_sdclk_1	= 0x00020030,
@@ -509,7 +513,7 @@ int board_mmc_init(struct bd_info *bis)
 
 /* USB */
 static iomux_v3_cfg_t const usb_pads[] = {
-	IOMUX_PADS(PAD_GPIO_1__USB_OTG_ID	| MUX_PAD_CTRL(NO_PAD_CTRL)),
+	IOMUX_PADS(PAD_GPIO_1__USB_OTG_ID	| MUX_PAD_CTRL(OTG_PAD_CTRL)),
 	IOMUX_PADS(PAD_EIM_D31__GPIO3_IO31	| MUX_PAD_CTRL(NO_PAD_CTRL)),
 };
 
-- 
2.47.2

