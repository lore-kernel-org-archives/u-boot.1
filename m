Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D54CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DA4E8390D;
	Fri, 17 Oct 2025 17:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="IBk/zyOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B348A83857; Fri, 17 Oct 2025 17:25:42 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D860283826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id A693925D9C;
 Fri, 17 Oct 2025 17:25:40 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h_0uRUP0ILgu; Fri, 17 Oct 2025 17:25:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714740; bh=UBP/k4WePkDUOb5Mc4IHYo+T1eeaBGoFUmOOOVnZ75M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=IBk/zyOJv7UxvG//pykYi5kRkYM1IvolnInRMsRAogtzJp1ZXMrCE6bFZxuLuUdUS
 QCTaB+xX2o3uwsyft2AXPw1cqb5sqtWoSsClNQBb7MJVgvMwGVfPigIgxim+WkIM+t
 RrCsVpdkK1MFaCxUiRmUnrO2AcuHgw5EsUJ3nfgng44Yf9uvuFnole35CRXlXmrKU/
 DE2UEgVLxS0Gws/6IStUPqYx+LHLaga+1YYFOLxFbqV9nycSo+V7oaLc/oZj7fFPlm
 91wAW6y9yJZnrDYV3Aj19cSCK6XUxFq/gfHW3irKEueEELksPUw849pYMQcYWIxMM6
 1yg/kHDg2ZKsA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:54:10 +0530
Subject: [PATCH 5/9] mmc: dw_mmc: return error for invalid voltage setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-mmc-dw-exynos7870-v1-5-a2c5139d9afe@disroot.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714654; l=1345;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=UBP/k4WePkDUOb5Mc4IHYo+T1eeaBGoFUmOOOVnZ75M=;
 b=JqIsW97KyAok1sBrtZes5OVDjpYhTlzETaGXl9udGp2l4smP7U2TYgAHNjFpPz9BIYk592cwM
 DekuPm8jcdCAyvOiaqP1TUM6EwCbdhvA+zUL7R7nHPezGErvVmiLpk7
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

In certain cases, the VQMMC regulator may not support certain voltages.
For instance, a VQMMC regulator which supports only up to 2.7V will not
accept 3.3V as an argument. This is unaccounted for, and thus the driver
incorrectly assumes that the voltage is set successfully.

Fetch the return value in a variable and return if it's non-zero.
(-ENOSYS is exempted as it implies that the voltage adjustment
functionality as a whole isn't supported).

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mmc/dw_mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 94b6641c44c39e67aac453c027d519c0e1580de6..9b143f9931e69531a53caa0196399e9392ddd348 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -649,9 +649,11 @@ static int dwmci_set_ios(struct mmc *mmc)
 			return ret;
 
 		if (mmc->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
-			regulator_set_value(mmc->vqmmc_supply, 1800000);
+			ret = regulator_set_value(mmc->vqmmc_supply, 1800000);
 		else
-			regulator_set_value(mmc->vqmmc_supply, 3300000);
+			ret = regulator_set_value(mmc->vqmmc_supply, 3300000);
+		if (ret && ret != -ENOSYS)
+			return ret;
 
 		ret = regulator_set_enable_if_allowed(mmc->vqmmc_supply, true);
 		if (ret)

-- 
2.51.0

