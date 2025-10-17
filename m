Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C60CCD19F
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FD678391C;
	Fri, 17 Oct 2025 17:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="jRRIOxDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E358F83857; Fri, 17 Oct 2025 17:26:23 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09AD983826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id B26E625C64;
 Fri, 17 Oct 2025 17:26:21 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3TetqBNOD4eD; Fri, 17 Oct 2025 17:26:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714781; bh=VTxEZ7mR/ARAtHKEuhvav2PAl7e1a5Mxuv8w1JWQSY0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jRRIOxDu2tj1BzKxOkh/+i/FvM4YU0O/bCCEWmLvEEnKijrcXupZ5/lIARUUHIqm4
 BwPbkp+Uws6oMeM7eyby/QrBnb7uVj5XDZxv608xIkfngyVptMuoZitFdwJEYZhuMS
 cf+dB+BgEZy4y1p5PAcxhn+Zq8ey2MyhF4yKD6Lj8bMIZLZjtOHT9gSYbcYkldS7zT
 B7MfpOFyugORY6MXr24IaEs219IXbAQEyGCd9clwQE5XjCywd9o9mOK9bwn+0oaOX3
 476Q0RIsJx7SH4LbJBp8MmM5Qtyzi9Ty+xEzxilVI4YDa2N/MVtDP/sxcJ4QJjZmrY
 jFI57fuAogoHw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:54:11 +0530
Subject: [PATCH 6/9] mmc: enable/disable VQMMC regulator only during MMC
 power cycle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-mmc-dw-exynos7870-v1-6-a2c5139d9afe@disroot.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714654; l=2144;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=VTxEZ7mR/ARAtHKEuhvav2PAl7e1a5Mxuv8w1JWQSY0=;
 b=5hpG9646dJVpCd0+4m+vhO1e/F490EGG2PwLJEvyS5eLQoZBQq7fSBg6LuXOnrblniz1u6B97
 BSrjbGvXT4fAiAYDs1LdaMGFIUAGXpr5tr9QJQEzFWGSsHL3wx6d+e5
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

Disrupting the regulator voltage during ios configuration messes with
the MMC initialization sequence. Move the VQMMC regulator enable/disable
functions to the MMC power cycle function, similar to how its done for
the VMMC regulator.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mmc/dw_mmc.c |  8 --------
 drivers/mmc/mmc.c    | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 9b143f9931e69531a53caa0196399e9392ddd348..f3c0cc5cd8e5045a870b5d5d2952da21bfba7e4d 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -644,20 +644,12 @@ static int dwmci_set_ios(struct mmc *mmc)
 	if (mmc->vqmmc_supply) {
 		int ret;
 
-		ret = regulator_set_enable_if_allowed(mmc->vqmmc_supply, false);
-		if (ret)
-			return ret;
-
 		if (mmc->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
 			ret = regulator_set_value(mmc->vqmmc_supply, 1800000);
 		else
 			ret = regulator_set_value(mmc->vqmmc_supply, 3300000);
 		if (ret && ret != -ENOSYS)
 			return ret;
-
-		ret = regulator_set_enable_if_allowed(mmc->vqmmc_supply, true);
-		if (ret)
-			return ret;
 	}
 #endif
 
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index b1cfa3cd7c22fac07fa16fac1cdb9500d2470a50..55dd021897c98b3af0ffddc9f64c035bf2e6484b 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2844,6 +2844,16 @@ static int mmc_power_on(struct mmc *mmc)
 			return ret;
 		}
 	}
+
+	if (mmc->vqmmc_supply) {
+		int ret = regulator_set_enable_if_allowed(mmc->vqmmc_supply,
+							  true);
+
+		if (ret && ret != -ENOSYS) {
+			printf("Error enabling VQMMC supply : %d\n", ret);
+			return ret;
+		}
+	}
 #endif
 	return 0;
 }
@@ -2861,6 +2871,16 @@ static int mmc_power_off(struct mmc *mmc)
 			return ret;
 		}
 	}
+
+	if (mmc->vqmmc_supply) {
+		int ret = regulator_set_enable_if_allowed(mmc->vqmmc_supply,
+							  false);
+
+		if (ret && ret != -ENOSYS) {
+			pr_debug("Error disabling VQMMC supply : %d\n", ret);
+			return ret;
+		}
+	}
 #endif
 	return 0;
 }

-- 
2.51.0

