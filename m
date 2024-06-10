Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD320C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CDEA8853F;
	Mon, 10 Jun 2024 15:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VXFa5m16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A22C088568; Mon, 10 Jun 2024 15:34:11 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD199884E7
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
 bh=I0LxzIpudAvhlkLLukHpGez6ROa11+OBeJWHCcvDHNM=;
 b=VXFa5m16+H3p0H984azNZXOcPAaSOe4wxLWm8vHA+V9muLQNHjJi3buQd3y/7Xs3
 lDeLLvlQCjgYOrGPGowRLTuvOrwfuuoF7mqjrIHr4O1X+fQIEpVL/atgSRdjpvuY
 +FCpw/39IPqVRa+tWdwkbREU5VN5GkHe/IwqzCMuRlQ=;
X-AuditID: ac14000a-03251700000021bc-e4-666700d1f175
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 05.7D.08636.1D007666;
 Mon, 10 Jun 2024 15:34:09 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jun
 2024 15:34:09 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <d.schultz@phytec.de>, <nmorrisson@phytec.com>
Subject: [PATCH 01/13] arch: arm: dts: k3-am625-phyboard-lyra: Add fixed
 partitions
Date: Mon, 10 Jun 2024 15:33:40 +0200
Message-ID: <20240610133352.2473414-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610133352.2473414-1-w.egorov@phytec.de>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWyRpKBR/ciQ3qawYkNqhYfGjezWUydtJnd
 4u3eTnaLd337mSy636k7sHq8OrCK3ePsnR2MHv3dLawefy6+Yw1gieKySUnNySxLLdK3S+DK
 ePlzBXvBSq6Krg3zmRsYezi6GDk5JARMJNpnH2HqYuTiEBJYwiRxefsiKOcxo8SEJ/3sIFVs
 AuoSdzZ8YwWxRQSCJHovfWIEsZkFPCS2/t0AFhcWCJZYP+U1WJxFQFXi5d8WFhCbV8BSou/5
 VUaIbfISMy99B5vJKWAl8WPNXrBeIaCaRZ/WQNULSpyc+YQFYr68RPPW2cwQtoTEwRcvmCHq
 5SVeXFrOAjNz2rnXzBB2qMTWL9uZJjAKzUIyahaSUbOQjFrAyLyKUSg3Mzk7tSgzW68go7Ik
 NVkvJXUTIyjkRRi4djD2zfE4xMjEwXiIUYKDWUmEVygjOU2INyWxsiq1KD++qDQntfgQozQH
 i5I47+qO4FQhgfTEktTs1NSC1CKYLBMHp1QDo6cpw5zi3QavhJcolq2pVNGdGfR/UTmnxpuE
 GRoNEe+Nm/kl/y3dvHmZjFkKm1BpokXbbo6rutsb17POFeqTY/rW0h2icqlY9H5Q+Y23Dumf
 1GuD132e3ld6b0q/Qf2qw7ullq8WZkpPWxdcpfnno/nGQ/z+tU43k7XfuH25cUpnycPbHxf0
 KbEUZyQaajEXFScCACFp0TJnAgAA
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

Add a fixed partitions node to the AM62x device tree so that it can
be used to fixup the Linux device tree.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
index 94162282068..7c76acc0d59 100644
--- a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
@@ -127,6 +127,32 @@
 
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

