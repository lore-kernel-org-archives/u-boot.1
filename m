Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D20C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 09:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5EF84B65;
	Wed,  1 Jul 2026 11:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="THLQ3hwL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A25DE84B50; Wed,  1 Jul 2026 11:11:33 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78AB584B52
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
 bh=GKhlB6XppLCVUVDQbMqp0h/kTfBc0rRx0oRlkCWlqX8=; b=THLQ3hwLq5zENSptT7qVg+8B18
 8IYKtw8dJOk1ZYf3s+0EDOo+nHOdyl6IrHdfpaA7h2m3j3jD2BCBg/85nPXSLOVImaVH/eb8LIXEb
 uoYvcP8dAiHG347n2EQRUP9tgYpUdaBhlj1JcIs391aKF6/L5fCbG9CCaHThoUF/NqTwdipJ/ILjL
 XVXe9obN95b/OeXgvIgskja9Sp++w6gq+V7tr4GW5kGNaM/wSIyL/S6N77Yb4qVFRoixOKFF/NfJl
 wI0luvoR0sQBh5lHhkLHMA3PjqUEa6P8zp33RdnWVHODGOy5p7nyxFVc56bPfuGyC/1pxrs5/GpxN
 f+36yV4w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1weqyf-000A4X-1v; Wed, 01 Jul 2026 11:11:30 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1weqyf-0007Md-34; Wed, 01 Jul 2026 11:11:29 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Subject: [PATCH 3/4] arm: dts: tqma6ul: integrate tq,eeprom sysinfo driver
Date: Wed,  1 Jul 2026 11:11:18 +0200
Message-ID: <20260701091122.1479350-4-Max.Merchel@ew.tq-group.com>
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

Add sysinfo node for tq,eeprom sysinfo driver.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi b/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
index 1ed44c57f59..c9e6cef38a2 100644
--- a/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
+++ b/arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi
@@ -14,6 +14,12 @@
 		u-boot,mmc-env-offset = <0x100000>;
 		u-boot,mmc-env-offset-redundant = <0x110000>;
 	};
+
+	sysinfo: sysinfo {
+		compatible = "tq,eeprom-sysinfo";
+		nvmem-cells = <&module_info>;
+		nvmem-cell-names = "device_info";
+	};
 };
 
 &clks {
-- 
2.43.0

