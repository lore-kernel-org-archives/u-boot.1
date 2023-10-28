Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D600C27C47
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 17:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 768BB8704D;
	Sat, 28 Oct 2023 19:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hkwrwd+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50B938704D; Sat, 28 Oct 2023 19:36:17 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E9B086F6B
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 19:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 325CCB8168A;
 Sat, 28 Oct 2023 17:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473B4C433C9;
 Sat, 28 Oct 2023 17:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698514573;
 bh=upSlIfbuLA16D2Slc8jAwnWGI+Dtzthx/nsGBZ454No=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Hkwrwd+MMogW3e+3WT5SpU5NPrfnm3FyTnUAvRHfcvgOcT41avRhjz2T1T0JV13AZ
 4ojT8Q+nFB9jWaCkixW3XJVa/+TWdqKXSe0fJqNEF0VVAL61Ve5T1vOvKg8VCOQTCd
 jDCxm92mvneQ71O7WxpqQ53GuSJW4rcm3Mw1HiUm5biT2R8f4xyNUa/dQhQkXgeiVh
 RRtAWEPOx8KYI7IItTFgZUaZ1ulF9fzEyKBkVHjPs01qPYLu+MNnPqq9tPVFoOeoya
 gseWlTHWdqJsQ5Enxe/aIfE9TVG9mKyj/tlIwEvrn9I0gz66IrnR5xffxtizRXtnXS
 XhCk6fcIGaA0Q==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	trini@konsulko.com
Cc: s-vadapalli@ti.com, r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
 marcel.ziswiler@toradex.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 1/3] arm: dts: k3-am625-sk-u-boot.dtsi: Update main_bcdma
 and main_pktdma nodes
Date: Sat, 28 Oct 2023 20:36:01 +0300
Message-Id: <20231028173603.24338-2-rogerq@kernel.org>
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

From: Siddharth Vadapalli <s-vadapalli@ti.com>

Update main_bcdma and main_pktdma nodes for native configuration in the
absence of DM services.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/dts/k3-am625-sk-u-boot.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
index b78d34b459..7ae5e01f7c 100644
--- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
@@ -126,7 +126,30 @@
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
 &main_pktdma {
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
 	bootph-all;
 };
 
-- 
2.34.1

