Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF30CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 12:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF5C986D0E;
	Mon, 16 Oct 2023 14:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697460663;
	bh=HdkboJ+db82njs8OqjvJIDnT09a8JULs6LP5oMoYskQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DeKSlqiDYNhjZfioim0HTvdYVE4wHO1/67YnVTsQNE1tEtVq2ASfYVqzN8G8G7tvn
	 H4uF1BbzllFupbHAngXGgvGTptS7LC5DG++CehsGJENZCHsueT3bpnHb6PqeLEpMv8
	 jTMTCgMcaRwdxvQ9gmDRQo4Xo5tJDXO9ZXt1WqQbKRfXeubj9WhNnFr+zOabWLRcQa
	 G+xEmcXKYR5Rm0zKoz1DK50ieZezaJW2NplLk/DyWGfDklDJDwOS3kt7kBsI6ynP8m
	 EPCOGZfVvgLQ2bi8+P76FY8Jm3LOZum1JPoyjKItL7+wqzM+uHKQn/vv3REypuqu0a
	 9hLMsovxTohWg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9E36786BC8;
 Mon, 16 Oct 2023 14:51:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697460662;
 bh=HdkboJ+db82njs8OqjvJIDnT09a8JULs6LP5oMoYskQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oaofRd1p7KsmuBtgZwe3F/xh0m2NeiE6A3KLJI4nU8IUEHlviZ4yfa8NuVX5lDMee
 oHFh/BFYfBNc/W9KWqVPm7jQH42cqQKVQyUXeV/JvgaKlCcPddufRfbgkrsnDVnyx8
 Ce6notL8GVNuO/xzP09Axy+klaQSJHb9GniQPvN9ysFx2G6IV/v66VT5L63Gx+Tane
 tLMpf1u6uCV9Zsy9rU1jupZfuEmue4upVO3u91/5gv8Iczg3SRnSQwWcJjudbM4o3s
 +AHytTYH/QHSAqYAmXTdq/4fDEpgVkqZGChJ8gux1fbxcG/aNbemL0gQD0R2jWK4vp
 aSjfhhPgId6hA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Fabio Estevam <festevam@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Ovidiu Panait <ovpanait@gmail.com>, Roger Quadros <rogerq@kernel.org>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH v2 4/7] arm64: dts: imx8mp: Drop i.MX8MP DHCOM rev.100 PHY
 address workaround from PDK3 DT
Date: Mon, 16 Oct 2023 14:50:05 +0200
Message-ID: <20231016125019.21583-4-marex@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016125019.21583-1-marex@denx.de>
References: <20231016125019.21583-1-marex@denx.de>
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

In case the i.MX8MP DHCOM rev.100 has been populated on the PDK3
carrier board, the on-SoM PHY PHYAD1 signal has been pulled high
by the carrier board and changed the PHY MDIO address from 5 to 7.
This has been fixed on production rev.200 SoM by additional buffer
on the SoM PHYAD/LED signals, remove the workaround.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: Ovidiu Panait <ovpanait@gmail.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
---
V2: Rebase and collect the patches in one series
---
 arch/arm/dts/imx8mp-dhcom-pdk3.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/imx8mp-dhcom-pdk3.dts b/arch/arm/dts/imx8mp-dhcom-pdk3.dts
index c5f0607f43b..867d238f2b5 100644
--- a/arch/arm/dts/imx8mp-dhcom-pdk3.dts
+++ b/arch/arm/dts/imx8mp-dhcom-pdk3.dts
@@ -227,10 +227,6 @@
 	};
 };
 
-&ethphy0g {
-	reg = <7>;
-};
-
 &fec {	/* Second ethernet */
 	pinctrl-0 = <&pinctrl_fec_rgmii>;
 	phy-handle = <&ethphypdk>;
-- 
2.42.0

