Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851DCCD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 402DD848B0;
	Mon,  8 Jun 2026 15:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pqL6VmeT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40ED283FEC; Mon,  8 Jun 2026 15:12:25 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DA6A84895
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 02F124E413F6;
 Mon,  8 Jun 2026 13:12:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C2C025FFB7;
 Mon,  8 Jun 2026 13:12:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0F44B106A28D5; 
 Mon,  8 Jun 2026 15:12:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780924340; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=e/iCegLGN6mA+6dOsZSmm3+G+arpq4Ve1JQUBSs1Xa0=;
 b=pqL6VmeTovTSaibPtWs/hMcZLT55IL+4d1spKnHwyxMPsxJmkUYkIMlNjqo99zQdweKxVN
 Dc0jpTVe98hpemOuSIu19g5XwsEBsGkFWCAb+HZewRw/I9MMeLmFZ5j0cHWII9ODVVZMcf
 7BdLtLrr6+DZ2vFFjSA0pHQak500IR9r8MqOjjT0V5LBgKEgnTou3DEMJ1N2LzdC6RVKXj
 qjJSUXNv0nZjV0UYcNM4tK9yp4b/smnEOmpZcWambp8dxMDMSKhRxjOjtwz4nRvhMRaL2S
 iqkSS2/UW+TvVVCModnXM3kWuk9HVUbCfoK85snmIbeec2rgW038vsAzv9Ch+A==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Mon, 08 Jun 2026 15:11:57 +0200
Subject: [PATCH v3 1/6] arm: omap: Move PRM I2C channel frequency to vc.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-omap4-support-v3-1-8595ccd203f0@bootlin.com>
References: <20260608-omap4-support-v3-0-8595ccd203f0@bootlin.com>
In-Reply-To: <20260608-omap4-support-v3-0-8595ccd203f0@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:33:31 +0200
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

PRM_VC_I2C_CHANNEL_FREQ_KHZ is defined in omap5/clock.h but isn't really
related to clocks.

Since it's only used by mach-omap2/vc.c, move its definition there.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 arch/arm/include/asm/arch-omap5/clock.h | 3 ---
 arch/arm/mach-omap2/vc.c                | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-omap5/clock.h b/arch/arm/include/asm/arch-omap5/clock.h
index eeb3c6f2a6c..aaa5e573115 100644
--- a/arch/arm/include/asm/arch-omap5/clock.h
+++ b/arch/arm/include/asm/arch-omap5/clock.h
@@ -204,9 +204,6 @@
 /* Clock frequencies */
 #define OMAP_SYS_CLK_IND_38_4_MHZ	6
 
-/* PRM_VC_VAL_BYPASS */
-#define PRM_VC_I2C_CHANNEL_FREQ_KHZ	400
-
 /* CTRL_CORE_SRCOMP_NORTH_SIDE */
 #define USB2PHY_DISCHGDET	(1 << 29)
 #define USB2PHY_AUTORESUME_EN (1 << 30)
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index cb377aa1272..92d2682a3f2 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -46,6 +46,8 @@
 #define PRM_VC_VAL_BYPASS_DATA_SHIFT		16
 #define PRM_VC_VAL_BYPASS_DATA_MASK		0xFF
 
+#define PRM_VC_I2C_CHANNEL_FREQ_KHZ		400
+
 /**
  * omap_vc_init() - Initialization for Voltage controller
  * @speed_khz: I2C buspeed in KHz

-- 
2.54.0

