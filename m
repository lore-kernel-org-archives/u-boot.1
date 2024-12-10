Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B84BE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 21:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C9D180104;
	Tue, 10 Dec 2024 22:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Mw7ySzBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E94068020D; Tue, 10 Dec 2024 22:43:39 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07D30800DF
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 22:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BALhZd02523863
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 15:43:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733867015;
 bh=N397mB+llr9q9N6wQokNelHn4ToYWdglPkmowjAHRlU=;
 h=From:Date:Subject:To:CC;
 b=Mw7ySzBFdxUk9p39HzS4qG6h1cE6VIBkGd44ZvWxboFT21IjgdLB9GNGgf9+DcMgv
 LSGX8jCaGeCQAbXq0G7SWkGnjda2NllLIOvJv9BoB8k1nEESDVWA2L5UkGKziSfC9P
 Wzmqpfk2ioqT+UfxaDYmLLbkXCrRNT+gvV5rKD/M=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BALhZ04028173
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 10 Dec 2024 15:43:35 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Dec 2024 15:43:34 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Dec 2024 15:43:34 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BALhYZi098861;
 Tue, 10 Dec 2024 15:43:34 -0600
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 10 Dec 2024 15:43:30 -0600
Subject: [PATCH] arm: dts: k3-am62p-sk-binman: add SE security variant builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241210-am62px-hs-binman-v1-1-be44e98a29e7@ti.com>
X-B4-Tracking: v=1; b=H4sIAAG2WGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0Nz3cRcM6OCCt2MYt2kzLzcxDzdJAszs1RjS0tT8zQzJaC2gqLUtMw
 KsJHRsbW1AGBrboNiAAAA
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2229; i=bb@ti.com;
 h=from:subject:message-id; bh=xHs9oxDo5pj5xeoqH3JAOowVyg5J0lpk/cHsL6cf1EA=;
 b=owNCWmg5MUFZJlNZU9ASaQAAa3/////7fv/7r/v/brV0/f+nVoC//T/XvN9rfZzJv3fz9N8wA
 RrJhyA0A0AAZADINAGmjQAaAAaBoAB6gaaAZBoAPU9TRoDQaeoN6ibSempoA0eogD1AZHqAaGgG
 hoyaAGQ00AGjQAaaZAAaAehGI00aDIZDT0mgDRkGIZNNHqGgx3qJ6npGmmj1AxBoA0AABoyAAGg
 GgAZNBkB6EPUZAAGg0AAGgAAGjajygQQZimSB3ITc2DCOcU+htJ/FXlIv0VvRpGbcCmpuc4GOmN
 tsc9+htioYCeFoMMV9lcWeD8SBcoZOYekDnNh12s05AVmAkCLuFjaFSPiMROmU0ESEOvhQjEQct
 jvzERO9iHL3GJGPJWo3+SRS5AEGrNoWJC+HnQj1419BmFJm9fPw/oBS6LwkqNOmgUmi+ovBY0BL
 iJkNwk3HFcDY9dTYbF0zDY9IfGPMBCY+2SBGFwBA+anCobBSZUCO8vwg391kj+phGuZpZrOOF46
 1NFplV8sCUq0UK24PxqNFAfq+JKw4JJBh7aFYOuX6KyMNlFYQ8gW5FTNaZ1+g8SRlphkzIRib9b
 sgv54X3bqE7B+6sz6AcsBQfZ+Jj0hDNA1MiBV4M1kzR/kLoD4ZtrH8YQuTVD/2ZMSRDDVQEN5ww
 Ambjq8mcE/xdyRThQkFPQEmkA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The Texas Instruments Foundational Security (TIFS) firmware must match
the security level configured on the SoC. To boot Security Enforced (SE)
variants of the AM62Px, add another tiboot3 build which packages the
Security Enforced (SE) firmware variant for AM62Px SoCs.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am62p-sk-binman.dtsi | 49 ++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index 2177d5428d4f9..797644a7e0d5f 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -57,6 +57,55 @@
 			type = "blob-ext";
 		};
 	};
+
+	tiboot3-am62px-hs-evm.bin {
+		filename = "tiboot3-am62px-hs-evm.bin";
+
+		ti-secure-rom {
+			content = <&u_boot_spl_hs>, <&ti_fs_enc_hs>, <&combined_tifs_cfg_hs>,
+				  <&combined_dm_cfg_hs>, <&sysfw_inner_cert_hs>;
+			combined;
+			dm-data;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&u_boot_spl_hs>;
+			content-sysfw = <&ti_fs_enc_hs>;
+			content-sysfw-data = <&combined_tifs_cfg_hs>;
+			content-sysfw-inner-cert = <&sysfw_inner_cert_hs>;
+			content-dm-data = <&combined_dm_cfg_hs>;
+			load = <0x43c00000>;
+			load-sysfw = <0x40000>;
+			load-sysfw-data = <0x67000>;
+			load-dm-data = <0x43c4a800>;
+		};
+
+		u_boot_spl_hs: u-boot-spl {
+			no-expanded;
+		};
+
+		ti_fs_enc_hs: ti-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62px-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+
+		combined_tifs_cfg_hs: combined-tifs-cfg.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+
+		sysfw_inner_cert_hs: sysfw-inner-cert {
+			filename = "ti-sysfw/ti-fs-firmware-am62px-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+
+		combined_dm_cfg_hs: combined-dm-cfg.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
 };
 
 #include "k3-binman-capsule-r5.dtsi"

---
base-commit: 45f05f681224d88d1b170063001b59edc8fc24cf
change-id: 20240617-am62px-hs-binman-b866e39957f6

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

