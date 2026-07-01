Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC17C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 09:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77DE684B76;
	Wed,  1 Jul 2026 11:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qFXakbL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A52F984B45; Wed,  1 Jul 2026 11:11:33 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C7BF84B53
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 11:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=bqb3eH1qUiNOoG7Tg8X0npOzCoqjw9XMPSHtxSPr5ZQ=; b=qFXakbL73J0Q8pEmxkwlc8/jMh
 GHM9LvnxxRT3XBE7xDM9lJ5VX2eliNDAsUSrJcauITmssx++47e+yyh5yurdx5k31xxCsSY3UIVpM
 JtSJdb7SSJAnt9QuHYJ6ssVz/fGot9Jv92iZ7xNNlef7LQ0hfRFeBasZhm3kDsGb+m6yt7rYXmn0i
 IDGr+ECbB/4b79+WjJNhQ49wuwsZ21E4whEMLDgcbtgd9P/SksFi63/8kpWiRv/f+3avFJHRQQSPC
 GaWq0U8mo6kX2afyih1d7X+1U+tHIR6cf2M5kkOlgNTE0Te6BSx+EvyoC6ILlWs8pyeH7E+zYhxvz
 8k65PEKg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1weqyf-000A4Y-1m; Wed, 01 Jul 2026 11:11:29 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1weqyf-0007Md-28; Wed, 01 Jul 2026 11:11:28 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Subject: [PATCH 2/4] arm: dts: tqma6ul: add eeprom nvmem-layout
Date: Wed,  1 Jul 2026 11:11:17 +0200
Message-ID: <20260701091122.1479350-3-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701091122.1479350-1-Max.Merchel@ew.tq-group.com>
References: <20260701091122.1479350-1-Max.Merchel@ew.tq-group.com>
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

TQMa6UL has board-information located in EEPROM at offset 0x20.
Add necessary nodes and properties for nvmem-cells.

Revert this commit once the upstream linux device trees are
accepted and synchronized.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
index 09f94f23074..1ed44c57f59 100644
--- a/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
+++ b/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
@@ -24,6 +24,18 @@
 	bootph-pre-ram;
 };
 
+&m24c64_50 {
+	nvmem-layout {
+		compatible = "fixed-layout";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		module_info: module-info@20 {
+			reg = <0x20 0x60>;
+		};
+	};
+};
+
 &osc {
 	bootph-pre-ram;
 };
-- 
2.43.0

