Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E63C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 080A18791C;
	Thu, 21 Dec 2023 18:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RokLCX0c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F21887907; Thu, 21 Dec 2023 18:44:26 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9798C878BA
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiERr081622;
 Thu, 21 Dec 2023 11:44:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180655;
 bh=kb364LwvEljisOVazcCINrL4OoiLOt7Z9UI4DBmBb/w=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RokLCX0cNkuFQYB9pD9/YymsfupGcecDsQXNgHMHmXa6FLcJWzNq+za4kH/80jtYU
 DWl+Ky6QrhXIqMSRr6koXLllKcCwKWw4ljR4BFWINv9fzWvQduxxm1GXi7snV+avIE
 rB6/XBc28ovkKMNcKUxySJ4LFK2UxlUpmKkQpm+o=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiEb9113472
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:14 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEgN080237;
 Thu, 21 Dec 2023 11:44:14 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 12/26] arm: dts: k3-am654: add needed regs to udmap nodes
Date: Thu, 21 Dec 2023 11:43:58 -0600
Message-ID: <20231221174412.210807-13-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054; i=bb@ti.com;
 h=from:subject; bh=o1zXoI/aVQxP1woMNLwF02HnlcWKNz2gMWw3w9+Ea8k=;
 b=owNCWmg5MUFZJlNZo3Y3JAAAZn///75P/q3yvC+499jt/51Dnf+376+u314v9u2/nnX3+fywA
 Rswx2poADTQANNBkaAyAaNAA0ANGgyaBoBiaD0jQAGjQYgZBkyZMR6hmphoaiANAMQMTTINGhkZ
 HqDTENNBoGgGQZMmjTTQMQ0MmRp6mjQMhoHqAD0T1DRppoAByaZDTEBpiaaYmgGTIyGmEwmgAAG
 QZBiZNMEADAmIaaAAAAYmgGmhkAwfxH1wTFi5DADWVRKUTklHX1tu90LlRyUAYJAEhWJP9oFhhw
 puKfgSagdtl9axDFJrIPj7+CSUEbxfjdVuaHQt+D53ABvxXKvcGeHyJxmA+dpWoPZvQ63LWEiM0
 IPW8IjqP5Qhlsows6qXhSEJyCUbuWFfmoAmucNI2VDA2SxtiYOkfQd3M+CMPWB5ACohmvgKCfYu
 2RxYMUhDV07lSoK2q5LduzVjKb55YszGaTBrtFnjQl1tGhA6XEbFJg6xRhoVfxJrjSIJPuMmRtc
 i9hJxwv1w1wjBbPgKlP6Ynk9IxTEg9RmkeXJVJFVf0Zak0BFM5Z5YRtqZhW402PcFVTgc6dCVNw
 IdryMaCA71gm54+kAUBueAd7vm1Gx3S7IB8J9rEIt8LmpA+96jSnPQ0MKPSA8wKviiwBPJxEu8U
 dFdX+DCv8XckU4UJCjdjckA
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Ethernet is one of a few IPs in U-Boot that depend on DMA to operate.
However there are a few missing registers ranges in the udmap nodes
need to properly setup DMA for the am65x.

A fix has been added to the Linux kernel[0] to add these ranges however
they have not made it to a Linux tag. To keep DMA operational until the
next DT sync from Linux, add these ranges to the *-u-boot.dtsi with a
note for our future selves.

[0] https://lore.kernel.org/r/20231213135138.929517-2-vigneshr@ti.com
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index 9cd8c353c515b..645241da322a5 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -260,3 +260,35 @@
 &mcu_r5fss0 {
 	ti,cluster-mode = <0>;
 };
+
+/* The DMA driver requires a few extra register ranges
+ * which are missing for the am65x. A patch has been
+ * sent and will be synced after the v6.8-rc1 linux
+ * tag is published
+ */
+&main_udmap {
+	reg = <0x0 0x31150000 0x0 0x100>,
+	      <0x0 0x34000000 0x0 0x100000>,
+	      <0x0 0x35000000 0x0 0x100000>,
+	      <0x0 0x30b00000 0x0 0x10000>,
+	      <0x0 0x30c00000 0x0 0x10000>,
+	      <0x0 0x30d00000 0x0 0x8000>;
+	reg-names = "gcfg", "rchanrt", "tchanrt",
+		    "tchan", "rchan", "rflow";
+};
+
+/* The DMA driver requires a few extra register ranges
+ * which are missing for the am65x. A patch has been
+ * sent and will be synced after the v6.8-rc1 linux
+ * tag is published
+ */
+&mcu_udmap {
+	reg = <0x0 0x285c0000 0x0 0x100>,
+	      <0x0 0x2a800000 0x0 0x40000>,
+	      <0x0 0x2aa00000 0x0 0x40000>,
+	      <0x0 0x284a0000 0x0 0x4000>,
+	      <0x0 0x284c0000 0x0 0x4000>,
+	      <0x0 0x28400000 0x0 0x2000>;
+	reg-names = "gcfg", "rchanrt", "tchanrt",
+		    "tchan", "rchan", "rflow";
+};
-- 
2.43.0

