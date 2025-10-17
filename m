Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6D7CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72C89838D2;
	Fri, 17 Oct 2025 17:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="iP9p0asd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED0383857; Fri, 17 Oct 2025 17:25:01 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D723B83826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id A64C925C64;
 Fri, 17 Oct 2025 17:24:59 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0eupmS-F-qM5; Fri, 17 Oct 2025 17:24:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714699; bh=6Usj0LM9t/rS9iQ19oFiQuYqGTrmMQo1Tu/2E1Eq5xk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=iP9p0asdg3BWu7hcqWHYRmab5lA+rRBI9iJXNEGQVX6hzhdhCOdgl5onlBPEifUQu
 oyUhVK8Ufel0TRY19CjBxmRSFV3Oqgg7s/fmZfpRGIF8vcMp863rBVggrt0fYlPbxC
 dgsRNbXkKtzyzgBTw4N6SPV1L/IGAOlpMZLcvFEpJTvtdK07tKovHer/dR4/QSr3PJ
 ++HAV3c+E72OTSo4xjZfvtgs/uDSHJDNX1DF4tQ8IkVAm4Lg6BAqstsgv0HiRXs96r
 nmzby4tp/mzAkLrTWyro5tdeumjpmTfzhO0sbbCy+3amF1DOjGDT+Dq38TwR8vOoH1
 zvbq5PwJXpucA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:54:07 +0530
Subject: [PATCH 2/9] mmc: dw_mmc: do not skip dwmci_setup_bus() for same
 non-zero clock frequency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-mmc-dw-exynos7870-v1-2-a2c5139d9afe@disroot.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714654; l=961;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=6Usj0LM9t/rS9iQ19oFiQuYqGTrmMQo1Tu/2E1Eq5xk=;
 b=eB3J5f6nean9hAEi4xodn4CM8vQdF1CTj//BGgI86/PUNokgO3C1W6YakPjLkITf6jerPoS+5
 SQNGrtpTHJDAw4oxlx/6YY4y+rGQI9nDymzwM+2T3eLm86eptyT24pm
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

In dwmci_setup_bus(), if the requested frequency is equal to the current
frequency, the function is returned, assuming no changes are required in
associated registers.

On certain SD cards, skipping in such situations may result in a timeout
errors during MMC initialization. Due to the lack of documentation, the
cause is unknown, but removing said check seems to fix the issue.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mmc/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index c6a18a5427ac64cc74a0a95f9780156b52beeee5..130a5bb57f3cddc50b3cd0df2f40981de680e852 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -554,7 +554,7 @@ static int dwmci_setup_bus(struct dwmci_host *host, u32 freq)
 	unsigned long sclk;
 	int ret;
 
-	if (freq == host->clock || freq == 0)
+	if (!freq)
 		return 0;
 
 	/*

-- 
2.51.0

