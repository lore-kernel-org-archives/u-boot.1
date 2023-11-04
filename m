Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A30C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 02:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 164AD8711D;
	Sat,  4 Nov 2023 03:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RNz0geun";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5058186FE8; Sat,  4 Nov 2023 03:46:04 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEA13870F6
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 03:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A42jCYf081642;
 Fri, 3 Nov 2023 21:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699065913;
 bh=qPnXD/K1CxczxZ5JBOoXrGLZtXQr+HlpF49uCoxhLPg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RNz0geunJb34Bf7MmG5NX0vwcRJIDmlhtjAqpW9eAwzr6CqCuk/NMkPfvfUlrRhsG
 9A41PBMMx0LTc6s5OCWkAwAv2R8dFdYeGkcJJ7GXjqsdoj5OXToDdqV7yey/JCXR91
 MmcEmr4sdoDoO6Tl/BS7KEPDSx5MIusf8nBcSqNM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A42jCsV013648
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 Nov 2023 21:45:12 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 Nov 2023 21:45:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 Nov 2023 21:45:12 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A42jCfi100651;
 Fri, 3 Nov 2023 21:45:12 -0500
From: Nishanth Menon <nm@ti.com>
To: <trini@konsulko.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Francesco Dolcini <francesco@dolcini.it>, Andrew Davis
 <afd@ti.com>, <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 1/2] arm: mach-k3: Move K3 degenerate keys out of board
 folder
Date: Fri, 3 Nov 2023 21:45:10 -0500
Message-ID: <20231104024511.3597476-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231104024511.3597476-1-nm@ti.com>
References: <20231104024511.3597476-1-nm@ti.com>
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

This file is common for all of K3, move it out of board/ directory and
into mach-k3. And change the relative paths to absolute paths in the
binman paths.

While at it, drop the reference in verdin-binman file which is
redundant.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes from V1:
* Dropped the override from verdin dtsi

V1: https://lore.kernel.org/all/20231103224453.3264313-1-nm@ti.com/

 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi         | 4 ----
 arch/arm/dts/k3-binman.dtsi                               | 2 +-
 {board/ti => arch/arm/mach-k3}/keys/ti-degenerate-key.pem | 0
 3 files changed, 1 insertion(+), 5 deletions(-)
 rename {board/ti => arch/arm/mach-k3}/keys/ti-degenerate-key.pem (100%)

diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index b489d8afbe36..ea22bfb9bad6 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -9,10 +9,6 @@
 	filename = "../../ti/keys/custMpk.pem";
 };
 
-&dkey_pem {
-	filename = "../../ti/keys/ti-degenerate-key.pem";
-};
-
 #ifdef CONFIG_TARGET_VERDIN_AM62_R5
 
 &binman {
diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 0212d44ee3b2..b941726e6246 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -20,7 +20,7 @@
 	ti-degenerate-key {
 		filename = "ti-degenerate-key.pem";
 		dkey_pem: blob-ext {
-			filename = "../keys/ti-degenerate-key.pem";
+			filename = "arch/arm/mach-k3/keys/ti-degenerate-key.pem";
 		};
 	};
 };
diff --git a/board/ti/keys/ti-degenerate-key.pem b/arch/arm/mach-k3/keys/ti-degenerate-key.pem
similarity index 100%
rename from board/ti/keys/ti-degenerate-key.pem
rename to arch/arm/mach-k3/keys/ti-degenerate-key.pem
-- 
2.40.0

