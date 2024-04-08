Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA994CD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 22:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E4088239;
	Tue,  9 Apr 2024 00:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hS/5gGVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE699880FE; Mon,  8 Apr 2024 23:24:00 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24A1B88190
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 23:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 438LNmXl055304;
 Mon, 8 Apr 2024 16:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712611428;
 bh=TWTAIE2gtsjJBn2EcSX8RvsFu5XkKgMX93oUMBDulf8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=hS/5gGVK0TV8/Co70JDbODlH+R2MlBMtcsIf5F4dthcYJAjCXp8E9Yew5nVmrukdR
 4OMaHWRhqq43DPwbl1kPJD5aghi5vknv1lCCJPeIGQESDkJ34iHHMWptMNw7L1vHZZ
 LzQMUAy8+sppCMqWHt1A3oN7V+3nPvdgOOgJKuDQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 438LNlPE061310
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Apr 2024 16:23:48 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 16:23:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 16:23:47 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 438LNl7T086464;
 Mon, 8 Apr 2024 16:23:47 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH 12/16] arm: dts: k3-am625-sk-u-boot: Add sysreset-controller
 node
Date: Mon, 8 Apr 2024 16:22:51 -0500
Message-ID: <20240408212255.95255-13-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408212255.95255-1-j-humphreys@ti.com>
References: <20240408212255.95255-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 09 Apr 2024 00:46:15 +0200
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

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 arch/arm/dts/k3-am625-sk-u-boot.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
index fa778b0ff4c..35bfeae75a0 100644
--- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
@@ -46,3 +46,12 @@
 &cpsw_port2 {
 	status = "disabled";
 };
+
+&dmsc {
+	bootph-pre-ram;
+
+	k3_sysreset: sysreset-controller {
+		compatible = "ti,sci-sysreset";
+		bootph-pre-ram;
+	};
+};
-- 
2.34.1

