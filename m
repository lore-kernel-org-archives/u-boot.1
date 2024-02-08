Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5248CC48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 17:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98FDB87CDB;
	Thu,  8 Feb 2024 18:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1707413665;
	bh=bRSL9B7JLYjMqq465FU5uMumF3dW8JljXh8rHRNHAjk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kS/wbItPAhDAjjkmI2LiGk4Nt7amfG4sZ3jQMYFQ/FyIA4oZUd1HSCtxh3FQbrL1y
	 iyJYQVOhEyO99HLwrm/uWRswa255+vGyd/iK9Y9IQCodB06k1CE5yxJUZoUi6w69yT
	 JEYIbHKwERwNVpgxx48vLKGOWvjxSmXLisDPLPd5JWL2iyRrrR99Z7dvyTgtTGnA+P
	 5emDkTMnI6VCGGRtN3ysUpMtl62+dPubydMwVirRHXk61u4tZv5YMqNmA6Fv7mXWS6
	 +JyUysZ25YlH3Oe1N67Z0sGGPJQVAXZrMkzowbtmxsKQoBkcVtntWI2pLdu2C6UN3e
	 u7jjZ4eEZuugQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 016A087CCF;
 Thu,  8 Feb 2024 18:34:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1707413664;
 bh=bRSL9B7JLYjMqq465FU5uMumF3dW8JljXh8rHRNHAjk=;
 h=From:To:Cc:Subject:Date:From;
 b=jqmjY4/RQX9l1U/YMlp6p+aGb8WsFQ/HkRei1PQ0i9DTXHfIkLozk/aUwwk8Y2cgD
 L+V+cx0xOUv64FtgT5ES7Jb8WbxnRFgW11/Q+45pWpSGkGKDI5FqibtbqD9Udry+XH
 OjmkoGFGhzfwGtNNa5lqu+qRT1vOV4Xf23z/abpS5glOytsqvGsZMfjxF4EqhQJr6t
 mJM2sIQ5Ymucx6GUGWq4F0nT4oMu9YuD4XJKoGeONYoT+XLb4vlgro6aXtel8ZbrOX
 LaBCjw5QxK4yu4Eabv9YN57EZKop5QEmOW8xI2qfV5FZI6H1CHu8riBz3yi1F1ewQ3
 43V32gRLPMTHA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: imx: Let SPL configure ECSPI1 clock on Data Modul i.MX8M
 Plus eDM SBC
Date: Thu,  8 Feb 2024 18:33:50 +0100
Message-ID: <20240208173415.397633-1-marex@denx.de>
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

The SPL clock code does configure the ECSPI clock frequency, which has
to match the mxc-spi driver configuration for successful SPI NOR boot.
Drop the assigned-clock from DT ecspi1 node on this board to let the
SPL clock code do the configuration and keep it aligned with the driver
expectation.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Stefano Babic <sbabic@denx.de>
---
 arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi b/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
index cb6ea356fd7..805b5f57955 100644
--- a/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
@@ -45,6 +45,9 @@
 };
 
 &ecspi1 {
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-rates;
+	/delete-property/ assigned-clock-parents;
 	bootph-pre-ram;
 	flash@0 {
 		bootph-pre-ram;
-- 
2.43.0

