Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B00C0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 17:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E04FD8755C;
	Sat, 28 Oct 2023 19:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h8dKv8gt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 578848786A; Sat, 28 Oct 2023 19:36:20 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D75186F6B
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 19:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A45E960AF0;
 Sat, 28 Oct 2023 17:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10087C433C8;
 Sat, 28 Oct 2023 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698514576;
 bh=qLER9RkPZxXLhCZqE6W/UiDYxQP1SUDJ9462L3fKWNU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h8dKv8gtmHvnkIDGxm8eQJ+P2YF+Bi1X/eJ4X2ApQHPnWsOEAedBKDn5Tfvvyflo9
 jZzzzgaUYeRlUyUw/hhLABB5X7MmFEW0XMSudh4QCdVaBtkLQNZi2gWBmbn1C91QwW
 yfG/5z7FAc3MXB4t3fkyzCgSRg0B/R/M6NgIR6CyGF17CfGo+HaTJdAwIX9fE7PuQb
 8LTzkGSUfJGXAeeY4+ZFLaRRvK0HFuOahbYXJu1k03JKRsyKOA6WxVCr0Ip8cKHEMh
 ZQkFEffkSmrNNJsIb9HQB/33l/yJ1FVHlDu1L+IPzBWBzPL+P7GD2qDT+YiPMmARmH
 lwdAMK+3XZXcw==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	trini@konsulko.com
Cc: s-vadapalli@ti.com, r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
 marcel.ziswiler@toradex.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 2/3] arm: dts: k3-am625-verdin-wifi-dev-u-boot.dtsi: Fix
 DMA/Ethernet
Date: Sat, 28 Oct 2023 20:36:02 +0300
Message-Id: <20231028173603.24338-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028173603.24338-1-rogerq@kernel.org>
References: <20231028173603.24338-1-rogerq@kernel.org>
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

Update main_bcdma and main_pktdma nodes for native configuration in the
absence of DM services. u-boot k3-udma driver expects these additional
register fields else probe will fail.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Nishanth Menon <nm@ti.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
index afa24d07a4..75cb60b57d 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
@@ -42,6 +42,33 @@
 	bootph-all;
 };
 
+&main_bcdma {
+	reg = <0x00 0x485c0100 0x00 0x100>,
+	      <0x00 0x4c000000 0x00 0x20000>,
+	      <0x00 0x4a820000 0x00 0x20000>,
+	      <0x00 0x4aa40000 0x00 0x20000>,
+	      <0x00 0x4bc00000 0x00 0x100000>,
+	      <0x00 0x48600000 0x00 0x8000>,
+	      <0x00 0x484a4000 0x00 0x2000>,
+	      <0x00 0x484c2000 0x00 0x2000>;
+	reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt",
+		    "ringrt" , "cfg", "tchan", "rchan";
+};
+
+&main_pktdma {
+	reg = <0x00 0x485c0000 0x00 0x100>,
+	      <0x00 0x4a800000 0x00 0x20000>,
+	      <0x00 0x4aa00000 0x00 0x20000>,
+	      <0x00 0x4b800000 0x00 0x200000>,
+	      <0x00 0x485e0000 0x00 0x10000>,
+	      <0x00 0x484a0000 0x00 0x2000>,
+	      <0x00 0x484c0000 0x00 0x2000>,
+	      <0x00 0x48430000 0x00 0x1000>;
+	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
+		    "cfg", "tchan", "rchan", "rflow";
+	bootph-all;
+};
+
 &cpsw3g {
 	bootph-all;
 };
-- 
2.34.1

