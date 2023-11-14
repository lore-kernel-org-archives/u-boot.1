Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55576C46CCA
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 20:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FFCA8707C;
	Tue, 14 Nov 2023 21:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="euKo83vJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFE1A86FC6; Tue, 14 Nov 2023 21:29:13 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40B8887101
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 21:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5A021CE1AA9;
 Tue, 14 Nov 2023 20:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E17C433C8;
 Tue, 14 Nov 2023 20:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699993743;
 bh=I0F1+qsrpoOYqKGxmJkmg9SI/C42q4/DiJNT8yjH3vA=;
 h=From:To:Cc:Subject:Date:From;
 b=euKo83vJ76Ky1i/lSsySqIhJLpWaNmgUCxxnmpho6wH7CMB6NC9+TeyWGGMcBbGvW
 3yLzl19nAua8bYT1cXwlfESosHJ6ErMWbk5lPdvZjsACwZTAhOWI9WRy3JD4vgfCSj
 IUeRLZ5k4r2l5Yvt5XJTeHL1mFi9/Dq1hBqJ9cDREWfRMjeiohBdLGG6Z8REG+vFue
 tvSbWG97iQttyXOdDG55DfEVC+0UQLft8VKYK7gc6vxI1IkSATYzVU3jF0/0E/nZWA
 o0cGj919uUUbXgXw3lJSOfrGSKkT5FZ+KZ6/O4GEG7EkAdFZ+qok2E7CcZLq7XgxNw
 162MoFdBVUt2A==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: marcel.ziswiler@toradex.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
 vigneshr@ti.com, srk@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] arm: dts: k3-am625-verdin-wifi-dev-u-boot.dtsi: Fix DMA with
 BCDMA
Date: Tue, 14 Nov 2023 22:28:56 +0200
Message-Id: <20231114202856.39072-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
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

BCDMA can be used at SPL for OSPI boot and mem-to-mem DMA
so add "bootph-all" to BCDMA node.

Suggested-by: Nishanth Menon <nm@ti.com>
Fixes: 9a3f2b6798b0 ("arm: dts: k3-am625-verdin-wifi-dev-u-boot.dtsi: Fix DMA/Ethernet")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
index 75cb60b57d..588d9594a8 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
@@ -53,6 +53,7 @@
 	      <0x00 0x484c2000 0x00 0x2000>;
 	reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt",
 		    "ringrt" , "cfg", "tchan", "rchan";
+	bootph-all;
 };
 
 &main_pktdma {

base-commit: 92b27528d777ce85362af45e7d2974a6c856219b
-- 
2.34.1

