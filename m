Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC8EC001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 16:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC87C8696C;
	Mon, 14 Aug 2023 18:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2834986978; Mon, 14 Aug 2023 18:05:37 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A8CC86679
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 18:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id D5AE068AFE; Mon, 14 Aug 2023 18:05:33 +0200 (CEST)
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Yanhong Wang <yanhong.wang@starfivetech.com>,
 Xingyu Wu <xingyu.wu@starfivetech.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
In-Reply-To: <20230814160404.9B2E067373@verein.lst.de>
Subject: [PATCH 2/2] riscv: jh7110: enable riscv,timer in the device tree
Message-Id: <20230814160533.D5AE068AFE@verein.lst.de>
Date: Mon, 14 Aug 2023 18:05:33 +0200 (CEST)
From: duwe@lst.de (Torsten Duwe)
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

The JH7110 has the arhitectural CPU timer on all 5 rv64 cores.
Note that in the device tree.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/riscv/dts/jh7110.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
index 081b833331..ec237a46ff 100644
--- a/arch/riscv/dts/jh7110.dtsi
+++ b/arch/riscv/dts/jh7110.dtsi
@@ -163,6 +163,15 @@
 		};
 	};
 
+	timer {
+		compatible = "riscv,timer";
+		interrupts-extended = <&cpu0_intc 5>,
+				      <&cpu1_intc 5>,
+				      <&cpu2_intc 5>,
+				      <&cpu3_intc 5>,
+				      <&cpu4_intc 5>;
+	};
+
 	osc: oscillator {
 		compatible = "fixed-clock";
 		clock-output-names = "osc";
-- 
2.35.3

