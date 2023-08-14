Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4464C001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13987869C7;
	Mon, 14 Aug 2023 23:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UxeNCKJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCB49869CA; Mon, 14 Aug 2023 23:56:16 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89DCC86987
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bbf8cb694aso41288085ad.3
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050171; x=1692654971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NA8wXXMGZUgB5LvuvYMeBlIkfqo2g+gkxhB8hUfXhoE=;
 b=UxeNCKJ+crlCgx3lvL+qi75QfAm7coeb6+AUA4mCRYcmrIb/r60+W3UxFsiv8dKn5E
 CfTMnq/CtszsKCbJ+f6Ttw0wBDTHnpHQOTyWY79qGU+NolwgKQWOw6EuZqGMBC4XqONN
 QNtoQ8K8s+RH/NeRMHVR7cVCxiYsOWvD+OiEYbl2/YQFPZragmtqkSb07IVEVDKwzshH
 t2gi0NHqHD5iI7oD3h24F7aAdUCW4yTYOLsP7Z6k67w1uw7TcehMU+qxWL5A5HgBZu1K
 TREKfpKTtqlHA3tcbl3ps41CGYSUNNt3WqBLFlZq938biqD0jmdUj45kajUJwhYps5XY
 15sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050171; x=1692654971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NA8wXXMGZUgB5LvuvYMeBlIkfqo2g+gkxhB8hUfXhoE=;
 b=ZUEM43O49sUaSH+I3v6Y8QYKJato/Q96JcOFltKezGfKpmDEscDZWcNaqPEFmfh5IO
 aULfDgWAB5LHRLGYhpC1tgoL1nBC9hQDUPjRvqPfOPzQunngHDgNDtA9XHM54BKdHRzB
 oAtF71vcXaOdO8FGC7V+cBiCsZbA8tIdvmpaCbEu2/D+RAhCHUxns1ob0rKHqDxFECe1
 hGWA9rtQPIzGuf6sZ+FUsty+6lwPmjalKw30C2OyV1xAk0h0/kc2hqRW1870DfrCtulj
 L4YFjqFZXAXHglMzXaL9OQoMCXCGVdxiI1bceYWNvnORiI3lro4W9ecjSH4w6zh1zRPY
 K/KA==
X-Gm-Message-State: AOJu0Yz7Rpw+mAKr/7kYMzsQ1TPPONEXQD67AbNVhhgzLGte/NJwk7IL
 gyT4DLobWKE1N7d5kPEKcM84E/0qFhSfZwIBglw=
X-Google-Smtp-Source: AGHT+IEDsD/XrBlDbTrCAjJmXeac63tFqtPy9ZwYs6eSo7zJk9DPY5txWaBlZWqrXZ7DuHmLi2skrw==
X-Received: by 2002:a17:902:8688:b0:1b8:954c:1f6 with SMTP id
 g8-20020a170902868800b001b8954c01f6mr9411233plo.36.1692050171605; 
 Mon, 14 Aug 2023 14:56:11 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:56:11 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 14/17] arm: dts: qcom: sdm845: Add UFS HC and PHY nodes
Date: Tue, 15 Aug 2023 03:24:54 +0530
Message-Id: <20230814215457.4075025-15-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
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

Add UFS HC and PHY nodes in Qualcomm SDM845 dtsi.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm/dts/sdm845.dtsi | 62 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
index 056a1674d5..9ef41e3c84 100644
--- a/arch/arm/dts/sdm845.dtsi
+++ b/arch/arm/dts/sdm845.dtsi
@@ -30,6 +30,68 @@
 			compatible = "qcom,gcc-reset-sdm845";
 			reg = <0x00100000 0x1f0000>;
 			#reset-cells = <1>;
+
+		ufs_mem_hc: ufshc@1d84000 {
+			compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0x01d84000 0x2500>;
+			phys = <&ufs_mem_phy_lanes>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <2>;
+			#reset-cells = <1>;
+			resets = <&reset GCC_UFS_PHY_BCR>;
+			reset-names = "rst";
+
+			power-domains = <&gcc UFS_PHY_GDSC>;
+
+			clock-names =
+				"core_clk",
+				"bus_aggr_clk",
+				"iface_clk",
+				"core_clk_unipro",
+				"tx_lane0_sync_clk",
+				"rx_lane0_sync_clk",
+				"rx_lane1_sync_clk",
+				"ice_core_clk";
+			clocks =
+				<&gcc GCC_UFS_PHY_AXI_CLK>,
+				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				<&gcc GCC_UFS_PHY_AHB_CLK>,
+				<&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
+				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+			freq-table-hz =
+				<50000000 200000000>,
+				<0 0>,
+				<0 0>,
+				<37500000 150000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 300000000>;
+		};
+
+		ufs_mem_phy: phy@1d87000 {
+			compatible = "qcom,sdm845-qmp-ufs-phy";
+			reg = <0x01d87000 0x18c>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clock-names = "ref",
+				      "ref_aux";
+			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+
+			ufs_mem_phy_lanes: phy@1d87400 {
+				reg = <0x01d87400 0x108>,
+				      <0x01d87600 0x1e0>,
+				      <0x01d87c00 0x1dc>,
+				      <0x01d87800 0x108>,
+				      <0x01d87a00 0x1e0>;
+				#phy-cells = <0>;
+			};
 		};
 
 		gpio_north: gpio_north@3900000 {
-- 
2.38.1

