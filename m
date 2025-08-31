Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E0DCA1002
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 13:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2964A839FA;
	Mon,  1 Sep 2025 15:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=skothe.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E896783447; Sun, 31 Aug 2025 17:17:34 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0620683929
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 17:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=skothe.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=steffen.kothe@skothe.net
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cFFx60mNzz9tKf;
 Sun, 31 Aug 2025 17:17:30 +0200 (CEST)
From: Steffen Kothe <steffen.kothe@skothe.net>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com
Subject: [PATCH 2/2] arm: mach-k3: am64x: Implement get_reset_reason()
Date: Sun, 31 Aug 2025 15:17:06 +0000
Message-ID: <20250831151706.404373-3-steffen.kothe@skothe.net>
In-Reply-To: <20250831151706.404373-1-steffen.kothe@skothe.net>
References: <20250831151706.404373-1-steffen.kothe@skothe.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Sep 2025 15:15:28 +0200
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
Reply-To: steffen.kothe@skothe.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Implement get_reset_reason() for AM64x to enable reporting of the reset
cause in the cpuinfo output.

Notice that the AM64x does not support dedicated reset cause bits for
WDT and PORZ as the AM62x does.

An explanation of this difference is not part of the technical reference
manual and remains unclear.

Signed-off-by: Steffen Kothe <steffen.kothe@skothe.net>
---
 arch/arm/mach-k3/am64x/boot.c | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/mach-k3/am64x/boot.c b/arch/arm/mach-k3/am64x/boot.c
index ce8ae941be6..f88f92b9f23 100644
--- a/arch/arm/mach-k3/am64x/boot.c
+++ b/arch/arm/mach-k3/am64x/boot.c
@@ -103,3 +103,39 @@ u32 get_boot_device(void)
 
 	return bootmedia;
 }
+
+const char *get_reset_reason(void)
+{
+	u32 reset_reason = readl(CTRLMMR_MCU_RST_SRC);
+
+	/* After reading reset source register, software must clear it */
+	if (reset_reason)
+		writel(reset_reason, CTRLMMR_MCU_RST_SRC);
+
+	if (reset_reason == 0 ||
+	   (reset_reason & (RST_SRC_SW_MAIN_POR_FROM_MAIN |
+			    RST_SRC_SW_MAIN_POR_FROM_MCU)))
+		return "POR";
+
+	if (reset_reason & (RST_SRC_SAFETY_ERR | RST_SRC_MAIN_ESM_ERR))
+		return "ESM";
+
+	if (reset_reason & (RST_SRC_SW_MAIN_WARM_FROM_MAIN |
+			    RST_SRC_SW_MAIN_WARM_FROM_MCU  |
+			    RST_SRC_SW_MCU_WARM_RST))
+		return "RST";
+
+	if (reset_reason & (RST_SRC_SMS_WARM_RST | RST_SRC_SMS_COLD_RST))
+		return "DMSC";
+
+	if (reset_reason & RST_SRC_DEBUG_RST)
+		return "JTAG";
+
+	if (reset_reason & RST_SRC_THERMAL_RST)
+		return "THERMAL";
+
+	if (reset_reason & (RST_SRC_MAIN_RESET_PIN | RST_SRC_MCU_RESET_PIN))
+		return "PIN";
+
+	return "UNKNOWN";
+}
-- 
2.51.0

