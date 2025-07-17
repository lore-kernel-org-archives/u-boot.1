Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA6AC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 18:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F7B7834A3;
	Thu, 17 Jul 2025 20:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X+6/PR4k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BC02834D4; Thu, 17 Jul 2025 20:48:34 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3A6383457
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 20:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56HImTE4071743;
 Thu, 17 Jul 2025 13:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752778109;
 bh=Uev98L8HlMx+uOxGnzqe6d7R66U8TrTScb+KllCs7P8=;
 h=From:Date:Subject:To:CC;
 b=X+6/PR4kYc6PmRYTHlN3PPPhZSjVEqQBZ8ewIvn5JIJjqN41J6eRjZb/vai/XzePk
 NSjmsz6MBJGbpecXrZF+CW2FIk3tL49Iy5OEmPI8zK45eirzwEySzXZOP3oeJd6pqS
 qRFnkC3V6fQxG4XUkiHMnQKukMpRvCagQOjxVoQk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56HImTsb1829895
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 17 Jul 2025 13:48:29 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 17
 Jul 2025 13:48:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 17 Jul 2025 13:48:29 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56HImTgl2312333;
 Thu, 17 Jul 2025 13:48:29 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Thu, 17 Jul 2025 13:48:22 -0500
Subject: [PATCH v2] arm: dts: k3: use SPL_TEXT_BASE for R5 SPL load address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250717-dt-cleanup-v2-1-bbbd41cb0d81@ti.com>
X-B4-Tracking: v=1; b=H4sIAHVFeWgC/23MSw7CIBSF4a00dywGME2pI/fRdMDjYm+itAEkm
 oa9ix07/E9yvh0SRsIE126HiIUSraGFPHVgFx3uyMi1BsllzwcxMJeZfaAOr40pNUrfO6Ot59A
 OW0RP7wOb5tYLpbzGz2EX8Vv/MkUwwfQohOHGqIs0t0xnuz5hrrV+AR3RkqKhAAAA
X-Change-ID: 20250717-dt-cleanup-8892f5dbacf0
To: Wadim Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Garrett Giordano
 <ggiordano@phytec.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>, Bryan Brattlof
 <bb@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15615; i=bb@ti.com;
 h=from:subject:message-id; bh=I9LCl7qajaQPeaZ0gO+8YMJVCIHr0mnXVuS+Umppxyk=;
 b=owNCWmg5MUFZJlNZJ2gdZgAAZ////75rf2n7Wo6zv43t8ef+7c779v7633v33j17y5HzzP+wA
 RtlB2oNGQAAADTRpppoaAA2oMmgAANNNGgBoANHqDI00MhpkyYQyaNPSNqZND1DyiAAMmgBo0xA
 A0GJhDTRoA0NGQYTJkYCG0IGQZDTaQABpk0AGQyDBNAhkeo0aBoMTQAaNAZNAYTTQDTIGgAMmTE
 0wAjRggBpoNNNBppkaaDJo0AZNAAGQFuos7WgSce7lF9rVb5IXHZpkq7ty4ZcKDxH7Apw4IvxKC
 MuL7SnU+Ba7evkygGP2vS5pBhTtAC9kill+ie8HGaYPPsgsz5brrU4XQSjs3EGvjxBgbEF9hanU
 LwiBEgI3NNE2iwCV6qVGWQrCTF0W2ekN/DQqWQbhJ1XbmeTdblgZ1LTnlmvg7VdyfxLGWhwT4cq
 s8Ee/UriCI+tNwk/rPa5KG2O7Ch0CCcMOA9ftkyoZ+XXWhh4JgnuH1/PkAIkOwR1ZmZOpOKWfgf
 SEQJ8K1IK3bpzuGPF056oUPyzClBvt3QV8KEOgmIt5ejHm310PA7ZuIPve8Tbmy6+D7/UmIrKPk
 C7+0DEnOsBTFH/FwPLMdlKkDcNAuoIZWYWlbkB6OPBUVN6CtVLJP+vzN9LtPwckjGIgDY54dGOz
 OpFh+qjv8XckU4UJAnaB1mA
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

The load address for the R5's SPL is defined in Kconfig by
SPL_TEXT_BASE. Rather than hard coding the load address which could
lead to hard to debug issues if this value is changed, just use the
SPL_TEXT_BASE value.

Reviewed-by: Andrew Davis <afd@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v2:
- Included j7200, j721s2 and j7842s to cleanup
- Link to v1: https://lore.kernel.org/r/20250717-dt-cleanup-v1-1-a911b0bb832b@ti.com
---
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi      |  6 +++---
 arch/arm/dts/k3-am625-sk-binman.dtsi               |  6 +++---
 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi  |  6 +++---
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi      |  6 +++---
 arch/arm/dts/k3-am62a-sk-binman.dtsi               |  6 +++---
 arch/arm/dts/k3-am62p-sk-binman.dtsi               |  4 ++--
 arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi |  4 ++--
 arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi       |  4 ++--
 arch/arm/dts/k3-j7200-binman.dtsi                  | 10 +++++-----
 arch/arm/dts/k3-j721s2-binman.dtsi                 |  6 +++---
 arch/arm/dts/k3-j722s-binman.dtsi                  |  4 ++--
 arch/arm/dts/k3-j784s4-binman.dtsi                 |  6 +++---
 12 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 6deebdadf092aff27ddb4201e408f2aefe9a0f0f..a9bd5a2be84abf5645c540360b08f15260bca5d3 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -25,7 +25,7 @@
 			content-sysfw-data = <&combined_tifs_cfg>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert>;
 			content-dm-data = <&combined_dm_cfg>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c3a800>;
@@ -69,7 +69,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_fs>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
 			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c3a800>;
@@ -105,7 +105,7 @@
 			combined;
 			dm-data;
 			content-sbl = <&u_boot_spl_unsigned>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			content-sysfw = <&ti_fs_gp>;
 			load-sysfw = <0x40000>;
 			content-sysfw-data = <&combined_tifs_cfg_gp>;
diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 6822a5dac896eb55de15d8c9eb38061f76ec6e51..f743c4353b49c882a87631610232e6d6de1300c4 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -23,7 +23,7 @@
 			content-sysfw-data = <&combined_tifs_cfg>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert>;
 			content-dm-data = <&combined_dm_cfg>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c3a800>;
@@ -67,7 +67,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_fs>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
 			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c3a800>;
@@ -103,7 +103,7 @@
 			combined;
 			dm-data;
 			content-sbl = <&u_boot_spl_unsigned>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			content-sysfw = <&ti_fs_gp>;
 			load-sysfw = <0x40000>;
 			content-sysfw-data = <&combined_tifs_cfg_gp>;
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index bfbba28269cf3435944e2e25bf9c454af88046f4..65fef6e479070bb64cd1297d17b189c72892379f 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -23,7 +23,7 @@
 			content-sysfw-data = <&combined_tifs_cfg>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert>;
 			content-dm-data = <&combined_dm_cfg>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c3a800>;
@@ -67,7 +67,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_fs>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
 			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c3a800>;
@@ -103,7 +103,7 @@
 			combined;
 			dm-data;
 			content-sbl = <&u_boot_spl_unsigned>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			content-sysfw = <&ti_fs_gp>;
 			load-sysfw = <0x40000>;
 			content-sysfw-data = <&combined_tifs_cfg_gp>;
diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
index fd3401015325cd34fd7e3592e1f5bc6cfec50b3a..9bcdf74ffe46368ddc6a872d02f26378aba763a9 100644
--- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
@@ -30,7 +30,7 @@
 			content-sysfw-data = <&combined_tifs_cfg>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert>;
 			content-dm-data = <&combined_dm_cfg>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c3a800>;
@@ -74,7 +74,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_fs>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
 			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c3a800>;
@@ -110,7 +110,7 @@
 			combined;
 			dm-data;
 			content-sbl = <&u_boot_spl_unsigned>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			content-sysfw = <&ti_fs_gp>;
 			load-sysfw = <0x40000>;
 			content-sysfw-data = <&combined_tifs_cfg_gp>;
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index 877a513a2418611b491963925440011cc1e319bf..0685bdd7e0c78087777e12cfa3d936c63f2fa597 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -27,7 +27,7 @@
 			content-sysfw-data = <&combined_tifs_cfg>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert>;
 			content-dm-data = <&combined_dm_cfg>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c3a800>;
@@ -71,7 +71,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_fs>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
 			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c3a800>;
@@ -107,7 +107,7 @@
 			combined;
 			dm-data;
 			content-sbl = <&u_boot_spl_unsigned>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			content-sysfw = <&ti_fs_gp>;
 			load-sysfw = <0x40000>;
 			content-sysfw-data = <&combined_tifs_cfg_gp>;
diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index d65e5c4d4e1e53f30040f32306d7b8c0159a3176..feb59edcd832ba535deac296ff82f3d9929050fe 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -25,7 +25,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_fs>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
 			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c4a800>;
@@ -72,7 +72,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_hs>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_hs>;
 			content-dm-data = <&combined_dm_cfg_hs>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c4a800>;
diff --git a/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
index 13fac18d7aac6fd5d146bcd5b815282f8e53372d..b1591faaf0a52e9f18e95c85b9da18d43d8a8758 100644
--- a/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
@@ -25,7 +25,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_fs>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
 			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c4a800>;
@@ -74,7 +74,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_hs>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_hs>;
 			content-dm-data = <&combined_dm_cfg_hs>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c4a800>;
diff --git a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
index 2a0023fb7c313270ed6b4ccf967a2b59bf8e3d09..0e810e7f492dbb37cde89b6adc8b78098e0134e7 100644
--- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
+++ b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
@@ -75,7 +75,7 @@
 			content-sysfw-data = <&combined_tifs_cfg>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert>;
 			content-dm-data = <&combined_dm_cfg>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c7a800>;
@@ -125,7 +125,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_fs>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
 			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c7a800>;
diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index b74bd1657f9327b96fefe84df919f2685212c792..b4e0ce8bfcf2686b69bd0e064fc4db7245d92ddb 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -24,7 +24,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_sr1>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_sr1>;
 			content-dm-data = <&combined_dm_cfg_sr1>;
-			load = <0x41c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x7f000>;
 			load-dm-data = <0x41c80000>;
@@ -67,7 +67,7 @@
 			content-sysfw-data = <&combined_tifs_cfg>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert>;
 			content-dm-data = <&combined_dm_cfg>;
-			load = <0x41c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x7f000>;
 			load-dm-data = <0x41c80000>;
@@ -112,7 +112,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_fs_sr1>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_fs_sr1>;
 			content-dm-data = <&combined_dm_cfg_fs_sr1>;
-			load = <0x41c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x7f000>;
 			load-dm-data = <0x41c80000>;
@@ -155,7 +155,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_fs>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
 			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <0x41c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x7f000>;
 			load-dm-data = <0x41c80000>;
@@ -192,7 +192,7 @@
 			combined;
 			dm-data;
 			content-sbl = <&u_boot_spl_unsigned>;
-			load = <0x41c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			content-sysfw = <&ti_fs_gp>;
 			load-sysfw = <0x40000>;
 			content-sysfw-data = <&combined_tifs_cfg_gp>;
diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index 4f524e58ceba0af22f4e8b588cdca8cadc753f6b..f79b3e543ae30b8760dd7c9b8e54f6b9292e6a3e 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -23,7 +23,7 @@
 			content-sysfw-data = <&combined_tifs_cfg>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert>;
 			content-dm-data = <&combined_dm_cfg>;
-			load = <0x41c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x41c80000>;
@@ -66,7 +66,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_fs>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
 			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <0x41c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x41c80000>;
@@ -103,7 +103,7 @@
 			combined;
 			dm-data;
 			content-sbl = <&u_boot_spl_unsigned>;
-			load = <0x41c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			content-sysfw = <&ti_fs_gp>;
 			load-sysfw = <0x40000>;
 			content-sysfw-data = <&combined_tifs_cfg_gp>;
diff --git a/arch/arm/dts/k3-j722s-binman.dtsi b/arch/arm/dts/k3-j722s-binman.dtsi
index 57e966ea666447118503e59ed0ddf40f471ae4c0..278b7bfac7fa0369f1227941d392a17ce71a1112 100644
--- a/arch/arm/dts/k3-j722s-binman.dtsi
+++ b/arch/arm/dts/k3-j722s-binman.dtsi
@@ -23,7 +23,7 @@
 			content-sysfw-data = <&combined_tifs_cfg>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert>;
 			content-dm-data = <&combined_dm_cfg>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c7a800>;
@@ -73,7 +73,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_fs>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
 			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <0x43c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
 			load-dm-data = <0x43c7a800>;
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index a7ce1ee2b03175d8eb74c539c240592c9d3046eb..34b2cc1e681f7ab63f8b3c954488e6aee43f408f 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -27,7 +27,7 @@
 			content-sysfw-data = <&combined_tifs_cfg>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert>;
 			content-dm-data = <&combined_dm_cfg>;
-			load = <0x41c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x66800>;
 			load-dm-data = <0x41c80000>;
@@ -74,7 +74,7 @@
 			content-sysfw-data = <&combined_tifs_cfg_fs>;
 			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
 			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <0x41c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x66800>;
 			load-dm-data = <0x41c80000>;
@@ -114,7 +114,7 @@
 			combined;
 			dm-data;
 			content-sbl = <&u_boot_spl_unsigned>;
-			load = <0x41c00000>;
+			load = <CONFIG_SPL_TEXT_BASE>;
 			content-sysfw = <&ti_fs_gp>;
 			load-sysfw = <0x40000>;
 			content-sysfw-data = <&combined_tifs_cfg_gp>;

---
base-commit: 3b4604a40b9fd61b87e9d059fc56f04d36f1a380
change-id: 20250717-dt-cleanup-8892f5dbacf0

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

