Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71508CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 09:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8E0384974;
	Wed,  3 Jun 2026 11:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vO/xJ6Jr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C087084954; Wed,  3 Jun 2026 11:55:45 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C6384972
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 11:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 78C7DC6245C;
 Wed,  3 Jun 2026 09:55:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A62605FFA8;
 Wed,  3 Jun 2026 09:55:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 621AF10888CCF; 
 Wed,  3 Jun 2026 11:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780480538; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=6CNEdNhGPCm01oGmYwp2RHTgsgRQnZ55udQa8zl1ToU=;
 b=vO/xJ6Jrnz/uh/kLCleek+XZ3MPJDANBizdKBCg+OnSX1gNLJlSKMZTCVMuOluGcq43mlI
 RpW0JF1xuqrMY33j5ZhuP8a48JxcnaKeygIokmGEkSlvl1/f2eutsudHz+ejaMAHmJw99H
 mKDsUj+r/dqJbcvcG03SsDkHRuho56E/jPJ2/PLujA663UCaxaPKU7KdMfXFZ1e2D+VIW5
 sqd7B9ZBxTpHEz+7BxiZC2P/7QyE5KQ1WPiG6noKW39Pcp1xtnhnUDdtg94DXmpIsUyRd2
 3m+iNP4LyPAGXZFhlafMznh/3gbS8R450KT8ksvwQXCiB4gS6QrtUviXjR3F/Q==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH v2 16/16] arm: dts: k3-j7200: Extend firewall for ATF region
 to TIFS
Date: Wed,  3 Jun 2026 11:54:49 +0200
Message-ID: <20260603095449.2089514-17-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603095449.2089514-1-richard.genoud@bootlin.com>
References: <20260603095449.2089514-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Prasanth Babu Mantena <p-mantena@ti.com>

Extend the access to SRAM region of ATF to TIFS as well. This is
needed for TIFS for encryption and decryption of ATF as a part of
low power mode sequence. TIFS encrypts the ATF while entering into
low power mode and decrypts it back while resuming back.
So, giving permissions for TIFS to access this region.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/dts/k3-binman.dtsi | 7 ++++++-
 arch/arm/dts/k3-security.h  | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 0fd93f9536a2..4ff668e905ed 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -475,7 +475,12 @@
 					FWCTRL_CACHE)>;
 		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
 						FWPERM_SECURE_PRIV_RWCD |
-						FWPERM_SECURE_USER_RWCD)>;
+						FWPERM_SECURE_USER_RWCD)>,
+					<((FWPRIVID_TIFS << FWPRIVID_SHIFT) |
+						FWPERM_SECURE_PRIV_RWCD |
+						FWPERM_SECURE_USER_RWCD |
+						FWPERM_NON_SECURE_PRIV_RWCD |
+						FWPERM_NON_SECURE_USER_RWCD)>;
 		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
 		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;
 	};
diff --git a/arch/arm/dts/k3-security.h b/arch/arm/dts/k3-security.h
index 33609caa8fb5..3e066bca6ad7 100644
--- a/arch/arm/dts/k3-security.h
+++ b/arch/arm/dts/k3-security.h
@@ -7,6 +7,7 @@
 #define DTS_ARM64_TI_K3_FIREWALL_H
 
 #define FWPRIVID_ALL    0xc3
+#define FWPRIVID_TIFS   0xca
 #define FWPRIVID_ARMV8  1
 #define FWPRIVID_SHIFT  16
 
-- 
2.47.3

