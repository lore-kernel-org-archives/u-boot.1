Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D124D7876B
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA6228977D;
	Thu, 21 Nov 2024 15:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="AMPKznYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27001896E0; Thu, 21 Nov 2024 15:28:13 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 581C58976E
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:28:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rre7P+kHVG1EmUSiZ2U7SeSWxUprcaEjx2Pwl+HmN9M=; b=AMPKznYYm4u2dshhmnsWpuLZHz
 lPOpKnmIDmFFu97H6KLmSd93LdWxt9syAvBXyNL7BEFVMI3cfCd9YeusWFUtWaf19yFO+FCYzpAc/
 K63Wvlf+K/YyTfTE6GKO5zu0BXTd3Uc7TYq7QTrGdE9ekvBuS3lOstDTmrMUjgzRBBCOGwb3NjQyL
 0jMd8SyzhotOMny5Hwzlkru0ELBZG1oW9XU9LuTQ5SOz4/pm1CTO/ngKwXtF05kQECvJlmIt/CkRk
 ykyOeZRxlZ71itWYHgsSCGxtbTZQjKGDmIWGCgkek16uR8SMbGov8nYP2WdaDrF6eQE3Vt3BbPjWW
 rRY+Knfw==;
Received: from [185.156.123.69] (helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1tE8A2-0007f9-6J; Thu, 21 Nov 2024 15:27:58 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH 06/20] DONOTMERGE: dt-bindings: arm: rockchip: Add Firefly
 ROC-RK3576-PC binding
Date: Thu, 21 Nov 2024 15:27:17 +0100
Message-ID: <20241121142731.1202209-7-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121142731.1202209-1-heiko@sntech.de>
References: <20241121142731.1202209-1-heiko@sntech.de>
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

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 dts/upstream/Bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dts/upstream/Bindings/arm/rockchip.yaml b/dts/upstream/Bindings/arm/rockchip.yaml
index 1ef09fbfdfa..9536f3b7070 100644
--- a/dts/upstream/Bindings/arm/rockchip.yaml
+++ b/dts/upstream/Bindings/arm/rockchip.yaml
@@ -193,6 +193,11 @@ properties:
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
2.45.2

