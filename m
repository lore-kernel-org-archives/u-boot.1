Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE28FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 13:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0B3B8426C;
	Mon, 27 Apr 2026 15:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="o+xaAzDp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DE3A8426C; Mon, 27 Apr 2026 15:59:06 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4830F842D7
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 15:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1777298340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kWTUBg2VsWz8OU5Msqt/D80hQw4+SFIAgAewiGHBhUQ=;
 b=o+xaAzDpCHZj3X260vXrauNnYZHFCFg41RUFB/SR6B1Ode1RIO7ImCPVbraJupZUF4lSkm
 BrAgeuaghLWrrT/GWQ2hlHDqxmwthVkma8r1sjiIdrYtUdopRQCKecT1II652YuU4R8Pw9
 KY0gNe8574sex0qhLRpctChT0LRtAEY=
Received: from archlinux (<unknown> [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 6623ac95
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 27 Apr 2026 13:59:00 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, u-boot@lists.denx.de, sjg@chromium.org,
 Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v2 5/9] mmc: Kconfig: allows m68k to use esdhc imx driver
Date: Mon, 27 Apr 2026 15:58:50 +0200
Message-ID: <20260427135854.18496-5-angelo@kernel-space.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427135854.18496-1-angelo@kernel-space.org>
References: <20260427135854.18496-1-angelo@kernel-space.org>
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

Allow cpu families as mcf5441x (m68k) to use the fsl_esdhc_imx driver
since the hardware ip module is the same.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>

---
Changes in v2:
- moved before menuconfig changes
---
 drivers/mmc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 22bd3a972bd..24bd16ad5f3 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -924,7 +924,7 @@ config ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE
 
 config FSL_ESDHC_IMX
 	bool "Freescale/NXP i.MX eSDHC controller support"
-	depends on MACH_IMX
+	depends on MACH_IMX || M68K
 	help
 	  This selects support for the i.MX eSDHC (Enhanced Secure Digital Host
 	  Controller) found on numerous Freescale/NXP SoCs.
-- 
2.54.0

