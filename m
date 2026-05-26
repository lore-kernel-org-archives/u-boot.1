Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F375FCD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47E9F8489D;
	Tue, 26 May 2026 14:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dYISrGJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 427498484C; Tue, 26 May 2026 14:40:58 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C524584878
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 14:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=tgMRy/aJBPtUYKmZtz0PK+CmQKwrXFDq2uHrPlF9pHM=; b=dYISrGJJ1VmkZPQ6t8QUySiH2X
 s9fjv/H7pbaheOWurMPhLkHdZffRf6aX4wwZYCa+JCz5YE8kQmdDl/OYJ2phX2tK6WJnPGVj++9DM
 75U/ssu58Zf3G+y0kaszRGvhHreZDL2/RmqY333AjdF7DUK17DzFGf9+Rxv+c3LA3GwHDAZ8WRzrW
 nYeglESQ4XtKFedXmdA6Rh7o/Yqh7lCm5VVJ9OHjCkjicatpqGiMxZeVHhPWhJ1vKuczjvqurA7e8
 3+MBktgPdIygMoOIPeKhOaS/h6WfgBgAGmKpoUU4FBnsp8F2UdoUAnT518qdX5IOKqs9KqVzy9N6W
 glfgGrAQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wRr5Z-000PK4-1t; Tue, 26 May 2026 14:40:53 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wRr5Y-000B1h-25; Tue, 26 May 2026 14:40:53 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Subject: [PATCH v2 5/6] arm: dts: tqma7: integrate tq,eeprom sysinfo driver
Date: Tue, 26 May 2026 14:40:43 +0200
Message-Id: <20260526124044.354578-6-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526124044.354578-1-Alexander.Feilke@ew.tq-group.com>
References: <20260526124044.354578-1-Alexander.Feilke@ew.tq-group.com>
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

TQMa7 has board-information located in EEPROM at offset 0x20.
Add necessary nodes and properties for tq,eeprom sysinfo driver.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 arch/arm/dts/imx7s-tqma7-u-boot.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/imx7s-tqma7-u-boot.dtsi b/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
index 2d1d614cd57..29c063c1c16 100644
--- a/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
+++ b/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
@@ -9,6 +9,26 @@
 
 #include "imx7s-u-boot.dtsi"
 
+/ {
+	sysinfo: sysinfo {
+		compatible = "tq,eeprom-sysinfo";
+		nvmem-cells = <&module_info>;
+		nvmem-cell-names = "device_info";
+	};
+};
+
+&m24c64 {
+	nvmem-layout {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		module_info: module-info@20 {
+			reg = <0x20 0x60>;
+		};
+	};
+};
+
 &soc {
 	bootph-pre-ram;
 };
-- 
2.34.1

