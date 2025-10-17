Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF901CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B010A838E5;
	Fri, 17 Oct 2025 17:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="XRUuC0/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E004383857; Fri, 17 Oct 2025 17:25:16 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F42F83826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 7B53325D5F;
 Fri, 17 Oct 2025 17:25:14 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CrYf4q2jzfmC; Fri, 17 Oct 2025 17:25:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714713; bh=E3ChwwxnsSQnLtfrMAofftcs7/HUOlKqBQVk8U96nWg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XRUuC0/TdV3sczXiJjK4YKObesQDM4BWtnOQDWLHFQV8FcWASiu1j/BONYioDPl63
 1v/2D4j5YHC596jJoHbsUS2dofiK7FZax5B0lHJZ08sjaCQCeBZ/pfsV9YR0AkQua2
 UnqVRxltHFFcwCdo9ZU4rtv4/Aj3rQ/NgvEF51Y+e8RGqkEojeFz7aHpK2sJe4MAEf
 uFFjreh9ni0T9o2T9Xyfle1evHm4xWQUys1BwZZ6QO5d51NdeyDsHxrv+x2/v4VWn3
 3S5XHWjNDwYsyD0KbNSaNiLxicRpRyNO2K0+XIOzQgB6Bk6Mn61MvlIwB9qc3II/TM
 e0CGdTGiwGeSg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:54:08 +0530
Subject: [PATCH 3/9] mmc: dw_mmc: properly address command completion in
 dwmci_control_clken()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-mmc-dw-exynos7870-v1-3-a2c5139d9afe@disroot.org>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Jean-Jacques Hiblot <jjhiblot@ti.com>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714654; l=1694;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=E3ChwwxnsSQnLtfrMAofftcs7/HUOlKqBQVk8U96nWg=;
 b=TEoGvmTl+tyt8qSlpc//W9zeEqnMSolbyF4CJmhO7J83drRF7gEIr6gn9osuSdWJ4A1A+VNmR
 eKDF6a7856OAajyIqVxpoevIWhW8FdUzA7Se/j7weBDQTkRhTEE4V+A
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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

The current implementation polls for the DWMCI_CMD register, for the
DWMCI_CMD_START bit to turn off, which indicates that the command has
been completed. The problem with this approach is that it doesn't
address the DWMCI_INTMSK_CDONE bit in the interrupt register,
DWMCI_RINTSTS. As a result, subsequent commands result in timeout errors.

Re-implement the waiting logic by polling for said interrupt status bit
and setting it low if raised.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mmc/dw_mmc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 130a5bb57f3cddc50b3cd0df2f40981de680e852..1aa992c352c3f11ccdd1c02745fa988646952261 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -507,20 +507,21 @@ static int dwmci_control_clken(struct dwmci_host *host, bool on)
 {
 	const u32 val = on ? DWMCI_CLKEN_ENABLE | DWMCI_CLKEN_LOW_PWR : 0;
 	const u32 cmd_only_clk = DWMCI_CMD_PRV_DAT_WAIT | DWMCI_CMD_UPD_CLK;
-	int timeout = 10000;
-	u32 status;
+	int i, timeout = 10000;
+	u32 mask;
 
 	dwmci_writel(host, DWMCI_CLKENA, val);
 
 	/* Inform CIU */
 	dwmci_writel(host, DWMCI_CMD, DWMCI_CMD_START | cmd_only_clk);
-	do {
-		status = dwmci_readl(host, DWMCI_CMD);
-		if (timeout-- < 0) {
-			debug("%s: Timeout!\n", __func__);
-			return -ETIMEDOUT;
+
+	for (i = 0; i < timeout; i++) {
+		mask = dwmci_readl(host, DWMCI_RINTSTS);
+		if (mask & DWMCI_INTMSK_CDONE) {
+			dwmci_writel(host, DWMCI_RINTSTS, DWMCI_INTMSK_CDONE);
+			break;
 		}
-	} while (status & DWMCI_CMD_START);
+	}
 
 	return 0;
 }

-- 
2.51.0

