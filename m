Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD67CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 09:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4244846CA;
	Wed, 27 May 2026 11:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Hgyo9VeH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAB9484671; Wed, 27 May 2026 11:52:29 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 138E5846A5
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
 bh=pz2jzG4RtDlgMeV0eZH7Vo60i0UZ7Lvw7G1P0HwATfo=; b=Hgyo9VeHTg19+v+Z98MPBeFi7C
 PXv66JbrXeISMPjOQeadjE5NP/SfAUCAFJRCbWZ9Te7hkq88Stm/RccGnzbC1IkUSr6TxnBN9WOmZ
 QAcIkqudcKrawifsiajJGmuFmdGJ3iJdHHm4yzcu3mHZKp5qHf+cG73+3N28zn7eTqVdNnkD6A5Oa
 ueKPI2EQzFsMln4Z+HZpzxq3y51MihZ4bPo7GYg0MwMupZps6S7xwzCSeKOtTu/8vY+gAzeq4jaXZ
 MfKAVcZ625IPUVreNB4imMntO8MnBFdRwxtVCBkSRmNlQXzIl67Q7aKFhB8YdBukRSTh1l6wU2Qnk
 qg6SGD4w==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wSAw6-0002Sd-0N; Wed, 27 May 2026 11:52:26 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wSAw5-000JXI-0c; Wed, 27 May 2026 11:52:25 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 5/7] arm: dts: tqma7: add eeprom nvmem-layout
Date: Wed, 27 May 2026 11:51:21 +0200
Message-Id: <20260527095123.50797-6-Alexander.Feilke@ew.tq-group.com>
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

TQMa7 has board-information located in EEPROM at offset 0x20.
Add necessary nodes and properties for nvmem-cells.

Revert this commit once the upstream linux device trees are
synchronized.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 arch/arm/dts/imx7s-tqma7-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/imx7s-tqma7-u-boot.dtsi b/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
index 2d1d614cd57..36ce80f0a17 100644
--- a/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
+++ b/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
@@ -9,6 +9,18 @@
 
 #include "imx7s-u-boot.dtsi"
 
+&m24c64 {
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
 &soc {
 	bootph-pre-ram;
 };
-- 
2.34.1

