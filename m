Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B011C0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 13:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99B8281244;
	Mon, 27 Jan 2025 14:41:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dPdE99qJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6192E814B6; Mon, 27 Jan 2025 14:41:23 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 402C881436
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 14:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385dece873cso2406291f8f.0
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 05:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737985280; x=1738590080; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9pLdgKnHhFn0QhpDykbz3iP4SyGOd4kziT4e2fr4g7o=;
 b=dPdE99qJQhufFKplEW7mqv+RKrFR0FlsZf8ZVUn0qVj0ByVRA4QpsNMmWSfJAnZYFO
 wLYqqLYkxIkG1D2KUfUTytiVweeUCGoafsVdeccMGYDfNSWyaPKC50pdqsW2thioxOAu
 n9tfVQd/PSBY/2RIj3klSnZ5VdMPy/NSLDuNCmumcyVSzMkNB7rEf/1q21GGI41dQH15
 AClqG06LJHINC0v+vJ5B5MaHMyo3OnDqfc4UGoLMYMrsT3bRWQHl8qJeO7qOilfwvJ4b
 5ly/RMa1v126YJfXRP6LkiFgEh/Sh3MZ4M9++BrIX1Cj240mqWswetKVV91OHWr1YGc7
 L3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737985280; x=1738590080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9pLdgKnHhFn0QhpDykbz3iP4SyGOd4kziT4e2fr4g7o=;
 b=wnyUXWv+juO5b/iBmLwepyUDxLPsNPO0tlspILXexVuFpam+wa/YwL9k7Z0AXrseN7
 x9yFfRNr+KsO62M1rMhvbpls+7dHL3FsN7zyTqbT8A97kPGdQPSKqn7o3btLsiusko2m
 u/H4sUWbBxAfjigodikZYVjils8kxsK2kcozYg7Www+WYa9EcYNR1CTXU/3o8nd4FjC1
 BtHMSHpGAQWI+DM685pPDWjZ4XYRRpxQaeuwCQY0xyoA3d/2ifwcdthknhp9U5FZN0VE
 NuPT1uclM0m8MHJaX4l79l+Qeam/qNygLSqfhry/mCRbhy3vR8wl/nbaa89Q5FH23X4k
 pVUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXczcp1JbGDhzC9dxIk+sUNDLm4MdxhnTbqEl0IUI1sKd3GljZT4JN7sYq+PLLjWx1tiuRxm2Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzE0ormBeK+KOhFnMyUCzYlFor504BErVMQH+E1RLNMv7gRUJbu
 Zr0XS0jDCxXfBXebqikEBakLYhRQ6uNd3lgd5iTfm7bdKe2K8ntU
X-Gm-Gg: ASbGncsqaoO+s8QFApYdSDC4OXakiu+5fm+q7yxCPjGLwGllVF2TzwyGhC4qm94r6cw
 vcWDCd6yGWjzbJSTBgna4UkzTcvrflyblpl2SqtgzmkMxwRWiQVO8WcPVdVqayQjDMQUyRGbFhZ
 AemlhIC7Bygw4/36X6R7qBcHlhjHuB1TmAqTslhsQjF40NGYvxzyqb+gSYN8Be8cp/Thq3/A61q
 OSKTNM2e1PXq3ne2K7TZO7wefaJE1VArpiYaGBiUUQaH8F1ggQhuRfmDsyvq+hH2l5cL9BDjKhJ
 iyEyOIUd4LbUVowqj65JWHygVCfz185Qa+bD6n6R01xccGtIUw==
X-Google-Smtp-Source: AGHT+IHRkpFCurJGg05y4+L0SNl9aYKSEDP7rRWDgLMvFXPieGUY2vNGh20Va5esE9iaDlkP+qwe2w==
X-Received: by 2002:a05:6000:104d:b0:386:3803:bbd5 with SMTP id
 ffacd0b85a97d-38bf57c901bmr29994619f8f.45.1737985279673; 
 Mon, 27 Jan 2025 05:41:19 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4199sm10873900f8f.89.2025.01.27.05.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 05:41:19 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Christian Marangi <ansuelsmth@gmail.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 John Crispin <john@phrozen.org>, Dong Huang <dong.huang@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 8/8] arm: dts: mediatek: add PCIe node for MT7981
Date: Mon, 27 Jan 2025 14:40:45 +0100
Message-ID: <20250127134046.26345-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127134046.26345-1-ansuelsmth@gmail.com>
References: <20250127134046.26345-1-ansuelsmth@gmail.com>
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

Add PCIe node for MT7981 with all the required properties to make PCIe
work.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7981.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index 2360c6bbdca..5b4cadc22f7 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -339,6 +339,41 @@
 		status = "okay";
 	};
 
+	pcie: pcie@11280000 {
+		compatible = "mediatek,mt8192-pcie";
+		device_type = "pci";
+		reg = <0x11280000 0x4000>;
+		reg-names = "pcie-mac";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&infracfg CLK_INFRA_IPCIE_CK>,
+				<&infracfg CLK_INFRA_IPCIE_PIPE_CK>,
+				<&infracfg CLK_INFRA_IPCIER_CK>,
+				<&infracfg CLK_INFRA_IPCIEB_CK>;
+		clock-names = "pl_250m", "tl_26m", "peri_26m", "top_133m";
+		phys = <&u3port0 PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy";
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x20000000 0x20000000 0 0x10000000>;
+
+		#interrupt-cells = <1>;
+
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie_intc 0>,
+			<0 0 0 2 &pcie_intc 1>,
+			<0 0 0 3 &pcie_intc 2>,
+			<0 0 0 4 &pcie_intc 3>;
+
+		status = "disabled";
+
+		pcie_intc: interrupt-controller {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+		};
+	};
+
 	usbtphy: usb-phy@11e10000 {
 		compatible = "mediatek,mt7981",
 			     "mediatek,generic-tphy-v2";
-- 
2.47.1

