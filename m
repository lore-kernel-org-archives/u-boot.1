Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8314C4725D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 12:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8697A8785F;
	Fri, 12 Jan 2024 13:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="myKYEbmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C38E387947; Fri, 12 Jan 2024 13:50:14 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D788287937
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:50:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BB14B61D65;
 Fri, 12 Jan 2024 12:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CE7C433F1;
 Fri, 12 Jan 2024 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705063811;
 bh=PJA3FP5R7N1uB6IHUHOxEMkK3Q5erQp2iEcTSVKvuKY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=myKYEbmTup/NOVtZBWBl01oG/CkXUFDIVm3kvOothlYidvFNxVlpM1VwHRn/hK55v
 B195mDop3iSJWzKfDidgfgg0XNitgiPwGZmgFhLmAT5Xmab9T4F2o9ixKpgLRqn/aY
 O+oWN9CrVj8X1y4xvl37x3K52itg3mHYXmU+bfxF5P3n7HRPpTIf8sScoktb+Bor9B
 N4yteB9KdLBC/eAZVFtyJBXmY5oizKrwS81pykrf2xjyIJjadKZIUvDVErHdV6Xbaf
 m5txkHGox970347v61eUbD0sCJTPLMjCl3Ki6MBcCNzisKTqSySpo/OFhe347wC0mM
 NxFAfBU2QblhA==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	robertcnelson@gmail.com,
	trini@konsulko.com,
	marex@denx.de
Cc: n-francis@ti.com, praneeth@ti.com, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, srk@ti.com, vigneshr@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 4/5] arm: dts: k3-j721e-beagleboneai64: Fix USB operation
Date: Fri, 12 Jan 2024 14:49:50 +0200
Message-Id: <20240112124951.238098-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112124951.238098-1-rogerq@kernel.org>
References: <20240112124951.238098-1-rogerq@kernel.org>
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

Without correct SERDES MUX and Lane control settings
USB0 will be broken. Set the MUX and Lane control devices
to be auto probed so they are configured correctly.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
index f83caf7998..017a5a722e 100644
--- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
@@ -165,6 +165,7 @@
 
 &serdes_ln_ctrl {
 	bootph-all;
+	u-boot,mux-autoprobe;
 };
 
 &serdes2_usb_link {
@@ -173,6 +174,7 @@
 
 &usb_serdes_mux {
 	bootph-all;
+	u-boot,mux-autoprobe;
 };
 
 &serdes_wiz2 {
-- 
2.34.1

