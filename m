Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64919C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E345188580;
	Mon, 10 Jun 2024 15:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="fW2K/7I1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DC9088574; Mon, 10 Jun 2024 15:34:13 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC86388520
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718026449; x=1720618449;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BcETWn/GrAeN9XxECymHIdo45+EG4H3ef34M87b+VQg=;
 b=fW2K/7I1y/MlF+EfNVRKL1L80XcsrVp+wH21Co66yHF8bSMY6soawIWECUPYL3mE
 4e1NfdyD+8gOIge5M5n10ykE+FYCIF3B4o3aoDuMlqSDeq3M9FpCsB41iNRXkm5K
 41cXAzpiHJU7sgk9rehG2GpnMo9H9aJAYy8HOQuMCiI=;
X-AuditID: ac14000a-03e52700000021bc-e5-666700d19877
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 65.7D.08636.1D007666;
 Mon, 10 Jun 2024 15:34:09 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jun
 2024 15:34:09 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <d.schultz@phytec.de>, <nmorrisson@phytec.com>
Subject: [PATCH 02/13] arch: arm: dts: k3-am642-phyboard-electra: Add fixed
 partitions
Date: Mon, 10 Jun 2024 15:33:41 +0200
Message-ID: <20240610133352.2473414-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610133352.2473414-1-w.egorov@phytec.de>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWyRpKBR/ciQ3qawf/behYfGjezWUydtJnd
 4u3eTnaLd337mSy636k7sHq8OrCK3ePsnR2MHv3dLawefy6+Yw1gieKySUnNySxLLdK3S+DK
 2Np7m7ngIFdF+9M2tgbGZRxdjJwcEgImEuefrmXrYuTiEBJYwiRx59p8RgjnMaPEhCf97CBV
 bALqEnc2fGMFsUUEgiR6L31iBLGZBTwktv7dABTn4BAWCJO4eTYNxGQRUJV42icJUsErYCmx
 Ztl8Nohd8hIzL30Hm8gpYCXxY81esIlCQDWLPq1hgagXlDg58wkLxHR5ieats5khbAmJgy9e
 MEPUy0u8uLScBWbmtHOvmSHsUImtX7YzTWAUmoVk1Cwko2YhGbWAkXkVo1BuZnJ2alFmtl5B
 RmVJarJeSuomRlC4izBw7WDsm+NxiJGJg/EQowQHs5IIr1BGcpoQb0piZVVqUX58UWlOavEh
 RmkOFiVx3tUdwalCAumJJanZqakFqUUwWSYOTqkGRnGNkz81/t058s5yR0K+qOWTO6xbPstt
 MpnO9dbSa5bLCu0JM762/DVsZn592zRoy+Hoo5o/b/j6VB1p/LvlWVZgx/yIv4u0wzR9pSW2
 BaUJuss2T9RbOTehm+e797ka52cfLkZz3c6YtkebQ/4lh0qCebRV3WKZlvU3nK492qwV5zEv
 0yyqW4mlOCPRUIu5qDgRAEqDz0NlAgAA
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

From: Nathan Morrisson <nmorrisson@phytec.com>

Add a fixed partitions node to the AM64x device tree so that it can
be used to fixup the Linux device tree.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 .../k3-am642-phyboard-electra-rdk-u-boot.dtsi | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
index 4677c35e2d9..8f3c3a185ae 100644
--- a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
@@ -115,6 +115,32 @@
 	bootph-all;
 	flash@0 {
 		bootph-all;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x00000 0x80000>;
+			};
+			partition@80000 {
+				label = "ospi.tispl";
+				reg = <0x080000 0x200000>;
+			};
+			partition@280000 {
+				label = "ospi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+			partition@680000 {
+				label = "ospi.env";
+				reg = <0x680000 0x40000>;
+			};
+			partition@6c0000 {
+				label = "ospi.env.backup";
+				reg = <0x6c0000 0x40000>;
+			};
+		};
 	};
 };
 
-- 
2.34.1

