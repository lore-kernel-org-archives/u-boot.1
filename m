Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D737CF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A798C89343;
	Fri, 20 Sep 2024 09:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AD8C8Hl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7AEF8937C; Fri, 20 Sep 2024 09:03:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F448937D
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815811; x=1758351811;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+iqGUcGUEE4bBN7rZNa2VRI3Z8djVEa87CU7p+pt5JY=;
 b=AD8C8Hl4EkWz2+YsCeE6ueWDcKGWeMNzkH+RAVE+WriE+Op3von8cwZJ
 nEj3Gitbh7FQDdnMvt05U7Dg5tWzFC5QYuZAkpkEsBmvpYY4syG9QbekT
 DdvSRgyJeI70vXiBLcpPTVUMaFg68J2umUQyZBkeDqGCM6PI2kZFFFYUy
 I1E4bguC8CxZV6EYr6SueRRovS9cN2ivODEtthRTEsEA/WOqsp0O67RP5
 iEQJYxon4YR61bVkDjM2Y3XLppt27BeIiG5M/k2ppWplx9+AYPElPy3fY
 i3aSPrhBa73+t7y3Td9ppadU13aXvBUudZ6ZMDey4HuqoPhpSvw8FS16X A==;
X-CSE-ConnectionGUID: UAYhITowRQmmfT3FeNMpYQ==
X-CSE-MsgGUID: gCu4iCFLQl6kavIPNKsszw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961052"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961052"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:30 -0700
X-CSE-ConnectionGUID: 0CrfNNrSRdSSieiEBRBvGQ==
X-CSE-MsgGUID: BukKmHiiRneoFAecEEIctw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235114"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:28 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 08/20] arm: dts: agilex5: Enable XGMAC
Date: Fri, 20 Sep 2024 15:02:30 +0800
Message-Id: <20240920070242.20884-9-tien.fong.chee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920070242.20884-1-tien.fong.chee@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
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

From: Tien Fong Chee <tien.fong.chee@intel.com>

Enable XGMAC for SoCFPGA Agilex5 devkit.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index 9eb21d65428..75ab05031bc 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -122,3 +122,36 @@
 	bootph-all;
 };
 
+&gmac0 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&emac0_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac0_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&emac2_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
-- 
2.25.1

