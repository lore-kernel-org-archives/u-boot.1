Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE26C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 07:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C6A885D2;
	Wed, 29 May 2024 09:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NolWu/kB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37A86885D9; Wed, 29 May 2024 09:48:59 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7CE088590
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 09:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44T7msct088449;
 Wed, 29 May 2024 02:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716968934;
 bh=LdAFC6k9IDyETidYT+YtFjF3hBPmD7WROS/9eijfoY4=;
 h=From:To:CC:Subject:Date;
 b=NolWu/kB0CS29kHq3zmvXnxJpJwBEj3/dh9a7RPVQ9W6SiJ60mLGJUtA2dLFf/m7n
 seHDap9r8FTLXxmhYKUX4mltoMlvbgRzfcY2CXEf/Z47/6oL5XySfQvQCUAUXQBEuO
 hDMf4b4xRz58Q2/6hVa43WgqFrZKVfkqO6RXq75U=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44T7ms62107993
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 May 2024 02:48:54 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 02:48:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 02:48:53 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44T7moT8110630;
 Wed, 29 May 2024 02:48:50 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <c-shilwant@ti.com>, <afd@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>, 
 <nm@ti.com>, <bb@ti.com>, <u-boot@lists.denx.de>, <sjg@chromium.org>,
 <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH] arm: dts: k3-*-binman: Make default DM file optional
Date: Wed, 29 May 2024 13:18:49 +0530
Message-ID: <20240529074849.363281-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
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

The default DM firmware path is non-optional as of now. Make it
optional so that users that choose to provide DM via TI_DM argument
instead of BINMAN_INDIRS can do so without build errors.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/dts/k3-am625-sk-binman.dtsi | 1 +
 arch/arm/dts/k3-am62a-sk-binman.dtsi | 1 +
 arch/arm/dts/k3-am62p-sk-binman.dtsi | 1 +
 arch/arm/dts/k3-j7200-binman.dtsi    | 1 +
 arch/arm/dts/k3-j721e-binman.dtsi    | 1 +
 arch/arm/dts/k3-j721s2-binman.dtsi   | 1 +
 arch/arm/dts/k3-j784s4-binman.dtsi   | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index dfd38d64f63..eddf05594d5 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -149,6 +149,7 @@
 		filename = "ti-dm.bin";
 		blob-ext {
 			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+			optional;
 		};
 	};
 
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index ec3bf7ce913..6f82f26bf85 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -152,6 +152,7 @@
 		filename = "ti-dm.bin";
 		blob-ext {
 			filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+			optional;
 		};
 	};
 	ti-spl {
diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index dea14945bf5..2233921d320 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -72,6 +72,7 @@
 
 		blob-ext {
 			filename = "ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+			optional;
 		};
 	};
 
diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index e8020fec2dc..a524b246187 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -281,6 +281,7 @@
 		filename = "ti-dm.bin";
 		blob-ext {
 			filename = "ti-dm/j7200/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+			optional;
 		};
 	};
 	ti-spl {
diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 1514d897634..0483fc5dd3f 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -310,6 +310,7 @@
 		filename = "ti-dm.bin";
 		blob-ext {
 			filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+			optional;
 		};
 	};
 	ti-spl {
diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index 46297ebef9e..d121d8c0c54 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -149,6 +149,7 @@
 		filename = "ti-dm.bin";
 		blob-ext {
 			filename = "ti-dm/j721s2/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+			optional;
 		};
 	};
 	ti-spl {
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index e4dd6e14a66..146cd7652c9 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -170,6 +170,7 @@
 
 		blob-ext {
 			filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+			optional;
 		};
 	};
 
-- 
2.34.1

