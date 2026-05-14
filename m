Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B25CD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 09:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02FFD8341A;
	Thu, 14 May 2026 11:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BVHMKXcb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA9583EF9; Thu, 14 May 2026 11:15:31 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1251C8056B
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 11:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso68970025e9.3
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 02:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778750126; x=1779354926; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WzH5AvQnXxwwUZ2fXGojWhoilbUechWmfL/9LBap5i4=;
 b=BVHMKXcbUMn+BjwDLoI64hoAvYW4rW4lcx4Hge7ayK3xWUVYXRXwGdo0WoXZvokGdp
 HLvGMYulUtbtDPA4nSa2VkxCSH7Q9UTfCd4fV+kHkyuI1yskgJi7Kb14bJvwEeeNR3nk
 sPH5CssmAWL423/timnAleOyuYUsyC8c+oSCW/Aa1t3El/d+1EoEaJuoMe10OqSXBozU
 sRQanXRS2GhRxc922gWAF0JZmBnXYx77taZowo65TEZesMv2D25GDh1kwthwJZxDhzld
 4ItVqejJheDmxoONxUiCUimBQJmcJZY7h7QpFnKCo/yy+LPEY3IEMdO1mFZeNveibl+R
 aWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778750126; x=1779354926;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WzH5AvQnXxwwUZ2fXGojWhoilbUechWmfL/9LBap5i4=;
 b=Ju2sUsat6qKbXVICgcLhxJp+tjR+etKYh8z8bEbz6Diho3sUsvgVSfrqGuNUTGhTGq
 ryVEUtia1RHGBTn9FkMHwLbD82t4Ic+JSyLD51KHXZeVLaxqsIgaaQ7KSr64KUisJQHU
 WGoXFP0Om+s/CnboiiCnMTRvmWOvOgjcEtzq02qexH21xcN5HhSnYZAraqga1CB2qzNo
 K5nJnNy7G38oAMKi/nWQvBPivdaDzUdnBPNb1ycxW502haV/GfujKKVol/elu6RZsZD7
 t+Vpo5hz2NuQFnLOZgsUXBzhnLOvgY5og8Jzymf6mfIMfMP1ZvFeUIXKtfnom0B2cCjT
 r84A==
X-Gm-Message-State: AOJu0YzxYDnp4J4/HKuUBA6xGZ7W5IqYLbHWM2maYdYvCfF5RWV8OHSk
 LX/LagGVKwr4ZATa1k8rhMP73VreFptRfT47v8if4ZSzo51DtxlS0KOdp1nrhPlL
X-Gm-Gg: Acq92OE1QYlvjiSFjDVzenI40ahyqEILNjVYYqUCr2qY3o5RBmN8NX3FZug/zVYQqnZ
 3a1JadkxlEo+Bc+AyqNd+/JTpUPdijJAfCXUgFg9MzUdnPMHZwmj8iKsMAdrB0rWDNbwumYoAd4
 /vS73Re3iQJIhwTN232je+xr/KTmk/MqgwUoC6XSwJsLar5sirmjvfGw2T/qfYt4M6bH569sDk/
 4cMGnJH9rjdbaBiHNTwP1+PaUgmfJh9j6yNlgE1kzmww/sqiV87Eyw2n8NPOfpNk5seilYh4iGz
 e9IG4Uja1WOkR+hnSLtZBhqPWgN/PWT4pBEORvTSid4SA8VRdpzje5AswEkc/h6r7Ngmn2o1yl6
 ir1KhwpoqzlJzGjq+/sF/YCubkVVBOeUlvHDBcYR7pcly1XrAJ+Aha6byQsuW11MjRwODGjLsVJ
 4/2DXDl/rcNambd0YZChH0qk5eZzM89GsCaJ9LPlZCPIr4Cr2jDOpm09+0cRu96ok115sI0rBLO
 NX+xFugOhO1Z9Vdojo6888L41eG4PA2+u40SZcpHxCZZFcSvIGq+jFYmcd+q/lDxA==
X-Received: by 2002:a05:600c:4583:b0:489:1d23:4524 with SMTP id
 5b1f17b1804b1-48fce9b30eemr93796555e9.5.1778750126158; 
 Thu, 14 May 2026 02:15:26 -0700 (PDT)
Received: from emanueleg-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd62b4d34sm16503535e9.2.2026.05.14.02.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 02:15:25 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH v1] arm: dts: k3-am69-aquila: fix combined boot firmware image
 build
Date: Thu, 14 May 2026 11:15:12 +0200
Message-ID: <20260514091516.2784772-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

The combined boot firmware firmware-aquila-am69-gp.bin depends on
tiboot3-am69-gp-aquila.bin, which in turn requires the GP variant
of the TI system firmware blob (ti-fs-firmware-j784s4-gp.bin).

Fix the combined boot firmware image build by adding the missing binman
nodes.

Fixes: f62d4535cf17 ("arm: dts: k3-am69-aquila: add combined boot firmware image")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi b/arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi
index f91cdf15aff3..c3a66ac8dae2 100644
--- a/arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi
+++ b/arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi
@@ -12,6 +12,11 @@
 #if defined(CONFIG_CPU_V7R)
 
 &binman {
+	tiboot3_am69_gp {
+		insert-template = <&tiboot3_j784s4_gp>;
+		filename = "tiboot3-am69-gp-aquila.bin";
+	};
+
 	tiboot3-am69-hs {
 		insert-template = <&tiboot3_j784s4_hs>;
 		filename = "tiboot3-am69-hs-aquila.bin";
@@ -28,6 +33,10 @@
 	filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-enc.bin";
 };
 
+&ti_fs_gp {
+	filename = "ti-sysfw/ti-fs-firmware-j784s4-gp.bin";
+};
+
 &sysfw_inner_cert {
 	filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-cert.bin";
 };
-- 
2.43.0

