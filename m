Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED547CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 09:52:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89ACB846AA;
	Wed, 27 May 2026 11:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ojdO735f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3880846D1; Wed, 27 May 2026 11:52:29 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4324D846AA
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 11:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=7/27HCEDy/L7oYvzN/Z0gtJXxr/jgWVq76I3cetQExg=; b=ojdO735fz8zgB4pzGu6Aif+6Og
 YVv1J6HvqqcshgOHDMRfEHU7+lO2tuEN6CkopFPz6wVVAZhGwm/Eq+fdnIBiFR4JQhOm3dbTHB72H
 pZAQo/jeWjBSDThjUouXARWA6O9ggzVefyyjVhOJe8VEfZSQSGVdm00ILgaL+X6V3ZkFH5FLpGABV
 r/NGuHRE9C7uQtvEi9gr1C7gDsKTPwQSLFDl8KoemF2iIhdTNx6XediwkVXdMhMM6bTh6NdgHexoE
 QGfKWZYqX5oeGcBYByFPEeDOtsZRmHPbeT2jIJIgM/Hf7rhlFnX5GJhDQson0pi1XrdB8PkkUZdkE
 GHJaUIvQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wSAw6-0002T8-1P; Wed, 27 May 2026 11:52:26 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wSAw5-000JXI-1j; Wed, 27 May 2026 11:52:26 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 6/7] arm: dts: tqma7: integrate tq,eeprom sysinfo driver
Date: Wed, 27 May 2026 11:51:22 +0200
Message-Id: <20260527095123.50797-7-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
References: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
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

