Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2D4C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 00:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 199D987779;
	Fri,  3 Nov 2023 01:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RwK5dPyc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E170F86FDA; Fri,  3 Nov 2023 01:39:03 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA44387719
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 01:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A30cBTn097504;
 Thu, 2 Nov 2023 19:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698971891;
 bh=9HNvFIOmEkuNBo1ii8CP4hudE/NyIA2MeTGmrsCzK8s=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RwK5dPycadEFBEeFrqzp4+T3vBaDyda/NXUQMhQ/QQ91fidCHI8QrsO98oXvy8D1T
 mjCKhjVbKspdiZPRpkFA91Q/x3RLo8ZLyQSv3FhHvp9XreUT/Dzk9pee4rzefOEYFx
 pf5Cqpt4qNYeV/GBuClo+//jeTNE72zNapf0kB2U=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A30cBZb021149
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 19:38:11 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 19:38:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 19:38:11 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A30cAum030080;
 Thu, 2 Nov 2023 19:38:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 12/15] arm: dts: k3-j721e-binman: Use macros that can be
 overridden for dtbs
Date: Thu, 2 Nov 2023 19:38:02 -0500
Message-ID: <20231103003805.2420005-13-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231103003805.2420005-1-nm@ti.com>
References: <20231103003805.2420005-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Allow the reuse of k3-j721e-binman for other platforms such as
BeagleBone-AI64. Provide a couple of macros to indicate the correct
dtb to be able to re-use soc binman dtsi file

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/dts/k3-j721e-binman.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index d9c4fbf593af..6166c931dea6 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -295,16 +295,28 @@
 #ifdef CONFIG_TARGET_J721E_A72_EVM
 
 #define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
+#ifndef SPL_J721E_EVM_DTB
 #define SPL_J721E_EVM_DTB "spl/dts/k3-j721e-common-proc-board.dtb"
+#endif
 
 #define UBOOT_NODTB "u-boot-nodtb.bin"
+
+#ifndef J721E_EVM_DTB
 #define J721E_EVM_DTB "u-boot.dtb"
+#endif
 
 #ifdef DUAL_DTB_BINMAN
+
+#ifndef SPL_J721E_SK_DTB
 #define SPL_J721E_SK_DTB "spl/dts/k3-j721e-sk.dtb"
+#endif
+
+#ifndef J721E_SK_DTB
 #define J721E_SK_DTB "arch/arm/dts/k3-j721e-sk.dtb"
 #endif
 
+#endif
+
 &binman {
 	ti-dm {
 		filename = "ti-dm.bin";
-- 
2.40.0

