Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBFEE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC94580200;
	Thu, 12 Dec 2024 14:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rZodjrxN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cDwbGtdo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3005B80200; Thu, 12 Dec 2024 14:35:29 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27F72801FE
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Y8D4G6bKCz9tQ5;
 Thu, 12 Dec 2024 14:35:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734010526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YlN7+ApO7hpKpI6sxDiWYkLo6yR5tn1VdN1wr8g5754=;
 b=rZodjrxNmejcpitvlTmPTBqZLmziCkxIR9HAANeKDQniB3T5t74tBVpUrQy4FXkgWGnvwL
 xmMad79GmQgAwBYPTf7usBSownd82ZhaRsAPmtLzNzyNW+gzvHdEdo8YdoX1xW7AkccU80
 M/Z+jtMTxXA+JSXJ+24mJ+yv3EnOJrO6P93RMXdeYNiOjVLPNtl48zwIVz5xVSd/DB3v9e
 be1fvgbddmFBEnq8XSwMvfU9tpasdwmpJSUVp0rJwKIneG3Sc0Jf64Q18joAbdDAhN1E8/
 oKWmH/59s5fyja2vV8jZbDm3n++HLd1MlSwH+KAMVldIn3Q59Uz8Gd3PYy/Huw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734010525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YlN7+ApO7hpKpI6sxDiWYkLo6yR5tn1VdN1wr8g5754=;
 b=cDwbGtdoIDwqK7Qd/afIFadmV25SE3Z1DBPgxh3/ccn9d3Lt9GW+ZlhAnqj63qhMesgo5C
 AXIdSjBY7/tXE/dRcm0AQw+SEDjNmp9UBn++EUs+0zmnoYYwI//2f3PZ57U1gDfM/BRcnT
 eOtySDSLQrQb1+GhC0JCazrR9cXmlzoArLH7jxdMM8YleWbuOTmc39PzIL9jc8/qc+K/9G
 9oKPZL6zpw0rA+i7Bp+QyKg6ps73S7md/CHC9n+VoRaXmpse/JH8EcXbsxd63w1/2WW5y2
 ++igNeCsWFtWsWasfGaUEnW5CvS/Lt3mhCTzvuGfF5kcvUVIeeH/FcxPbPUHtg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] arm64: dts: renesas: Add R8A779G0 V4H DBSC5 and RT-VRAM
 DT nodes
Date: Thu, 12 Dec 2024 14:34:31 +0100
Message-ID: <20241212133508.84233-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241212133508.84233-1-marek.vasut+renesas@mailbox.org>
References: <20241212133508.84233-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: f3c71gfsmiprdcxyizedm7wt4ssbob5d
X-MBO-RS-ID: bf024bedb2b13d2fc33
X-Rspamd-Queue-Id: 4Y8D4G6bKCz9tQ5
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

Describe DBSC5 DRAM controller and RT-VRAM configuration interface
as two new DT nodes in R-Car Gen4 R8A779G0 U-Boot DT extras file.
This node is used by the U-Boot SPL for R8A779G0 SoC, where the
DBSC5 and RT-VRAM drivers bind to these nodes and bring up the
DRAM controller and RT-VRAM settings respectively, so U-Boot
proper can be loaded into DRAM and started on Cortex A76 core.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a779g0-u-boot.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/dts/r8a779g0-u-boot.dtsi b/arch/arm/dts/r8a779g0-u-boot.dtsi
index f60eba531e4..42df321178b 100644
--- a/arch/arm/dts/r8a779g0-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g0-u-boot.dtsi
@@ -15,3 +15,21 @@
 &extalr_clk {
 	bootph-all;
 };
+
+&soc {
+	ram@e6780000 {	/* DBSC5 */
+		compatible = "renesas,r8a779g0-dbsc";
+		reg = <0 0xe6780000 0 0x80000>;
+		power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+		status = "okay";
+		bootph-all;
+	};
+
+	ram@ffec0000 {	/* RT-VRAM */
+		compatible = "renesas,r8a779g0-rtvram";
+		reg = <0 0xffec0000 0 0xf000>;
+		power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+		status = "okay";
+		bootph-all;
+	};
+};
-- 
2.45.2

