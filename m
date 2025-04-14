Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D008CC369B5
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 20:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE66F82887;
	Mon, 14 Apr 2025 22:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="llMj2D7F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA1168295C; Mon, 14 Apr 2025 22:21:33 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B19A8828AB
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 22:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=km5t4elMndVnIyqjwTvcM5d2HULcZ9/IEY3Z/HEjzio=; b=llMj2D7FR3TIMyj5jcoTS9Tf06
 32kfPpzwqwcXDHR5q8qpG2ndJU5Nt36V+04IYS84WDj//qEQ3rjkLGUkYz0Df4cylmDxS3ajiOTeC
 4/NoHoFehMoqBx10cCYSI6AVlVOJ4LTg10MgiAcFRLAYsctiQeco6q5j384cHIYpWihjgVNll3J0E
 WpmpRYEPDLnJu74k/jqs/zXmvxwTp1Wf96TTedOV/oG0U1dzicSO0m/SlF83te6DnYqm1wF6e3riB
 8M76hHMhYTez+FIZc4l1nT33oOxouBCMcILa7D5VPbJ/y6YCBvBMAUDZcEGlD0TXUD8SW9iyZuxSN
 lao6+Wog==;
Received: from i53875b95.versanet.de ([83.135.91.149]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u4Q00-0001rf-0v; Mon, 14 Apr 2025 22:01:44 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com,
 "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH v2 14/16] dt-bindings: arm: rockchip: Add Firefly
 ROC-RK3576-PC binding
Date: Mon, 14 Apr 2025 22:01:09 +0200
Message-ID: <20250414200111.1357867-15-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250414200111.1357867-1-heiko@sntech.de>
References: <20250414200111.1357867-1-heiko@sntech.de>
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

Add devicetree binding for the ROC-RK3576-PC SBC.

The board is based on the RK3576 SoC (4*Cortex-A72 + 4*Cortex-A53).

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20250210205126.1173631-2-heiko@sntech.de

[ upstream commit: 2be4a4171401761cb5fb02225d8b18351f6807c0 ]

(cherry picked from commit 89026942ddd0475d78b11b019285fff0c1d47266)
---
 dts/upstream/Bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dts/upstream/Bindings/arm/rockchip.yaml b/dts/upstream/Bindings/arm/rockchip.yaml
index 522a6f0450e..0f4ca08d9ae 100644
--- a/dts/upstream/Bindings/arm/rockchip.yaml
+++ b/dts/upstream/Bindings/arm/rockchip.yaml
@@ -236,6 +236,11 @@ properties:
               - firefly,roc-rk3399-pc-plus
           - const: rockchip,rk3399
 
+      - description: Firefly ROC-RK3576-PC
+        items:
+          - const: firefly,roc-rk3576-pc
+          - const: rockchip,rk3576
+
       - description: Firefly Station M2
         items:
           - const: firefly,rk3566-roc-pc
-- 
2.47.2

