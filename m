Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45048CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 11:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F231A848B3;
	Tue,  2 Jun 2026 13:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Ro3Z2/OC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BE6B84859; Tue,  2 Jun 2026 13:58:17 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D092784879
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 13:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=MeJDqNck7rNLhBB6JhT0vmlCdesguo6+yB8uwimLFKI=; b=Ro3Z2/OC8w1LfUhF4v6U4SiAHL
 aA1jEsCsPrtYacCj2oTzRsvILP/G8s1i8UP9a/BPNOvKqSakHD7j8eYdrBviJZcEtc8rek0gb6XyH
 9pz7Ph/arn9cMDV0f7k5dDODWM5GC1dGyV8CCxcymUavdwedb217QXcOfFRrkO5sl2QoOD//3cnGd
 bdr5Jig+8E7e9HxVAJJPKATpbml4f43yK4QYl+Xy0eos6NosASlOdDk/XWoYTrTBaJ9X3m7RIdi6B
 0G87ajCPHOF7O8R8TBc2hDlJmlt2rOPC6eQE96EcknQcz/WVeaclEwRaMSJZuX2QsCXctr3oDHERI
 xaIHnBFg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wUNl7-000Ljg-1l; Tue, 02 Jun 2026 13:58:13 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wUNl6-000J89-1Y; Tue, 02 Jun 2026 13:58:13 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 6/7] arm: dts: tqma7: integrate tq,eeprom sysinfo driver
Date: Tue,  2 Jun 2026 13:57:54 +0200
Message-Id: <20260602115755.371164-7-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602115755.371164-1-Alexander.Feilke@ew.tq-group.com>
References: <20260602115755.371164-1-Alexander.Feilke@ew.tq-group.com>
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Add sysinfo node for tq,eeprom sysinfo driver.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 arch/arm/dts/imx7s-tqma7-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/imx7s-tqma7-u-boot.dtsi b/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
index 36ce80f0a17..2b6bbcc0276 100644
--- a/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
+++ b/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
@@ -9,6 +9,14 @@
 
 #include "imx7s-u-boot.dtsi"
 
+/ {
+	sysinfo: sysinfo {
+		compatible = "tq,eeprom-sysinfo";
+		nvmem-cells = <&module_info>;
+		nvmem-cell-names = "device_info";
+	};
+};
+
 &m24c64 {
 	nvmem-layout {
 		compatible = "fixed-layout";
-- 
2.34.1

