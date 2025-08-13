Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9057FCA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 21:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E78EB836C8;
	Wed, 13 Aug 2025 23:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="n1KIl/ds";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bT1hVhiO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4F0883767; Wed, 13 Aug 2025 23:27:25 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEFC182A53
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 23:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4c2M0C56JZz9tHh;
 Wed, 13 Aug 2025 23:27:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755120443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3z/vIZUUeHnpx2EtYXFW3t9IBS+Hw+NwfuwjP7SfasU=;
 b=n1KIl/dsTaqRYqszyGBCTxA/ZR9Sjz7G3iFXlVjWNMm0Mcrn3Lvd5bMA61r7PZySwt2oC8
 zDYBMfk7DCsdbYleibIYawlGS30M/zY30Ro0qTFQ7lgBZBDjneOVWgTcS3pYVi0IBXVIsp
 msJYai1GJmq6zbDXs4VFZZP74zHMlJKlEqGIMiILTlmcEUjt/iiXFfUo2YaqTLYS21iu0R
 YhylVfWr3tsjhGJWMO3y9kgeeOMILTxI2VLW313+Uj7YbDE3RyCBWDIwtY1TQTPNuFC+Lb
 5dC+mAlZiUijQga1FZlAFvyWrGEeG84H1YhTKDHcSF/hpop/QymX+0RbtVnlIA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755120441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3z/vIZUUeHnpx2EtYXFW3t9IBS+Hw+NwfuwjP7SfasU=;
 b=bT1hVhiOFMOsOGlDCBx0WbDwzRX6VxKt+nkNKLZGom4p0+WJosqJ7ciEMgzOrZ9nw6kAt8
 hNY5RXyseXgdpdA4mdvGJM44uMx8L4+IdKCEdEo/+eKaBWIeOAlMpZAP2A+nToDpVu7Tkb
 Z4MQmDanzhHOYTRtRd7UA00sWhPnqtbvxehFmMeKm3TfDwS+GSGWidEvcphvBecFbnrbEQ
 PeiHopjzENVV+BBrjay4zAg1cN8dR4AZ1Wj2A2UlE367v0JthYUgo1OaaiLiNGR7Tv8md/
 0WWaywgAjpra8pGwo3TjErOeFvuace3aQQAK/AHjV+DQ5jVTn/2qcmYDETtsKw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] arm64: dts: renesas: r8a779g3: Set VDDQ18_25_AVB voltage
 on Retronix R-Car V4H Sparrow Hawk EVTB1
Date: Wed, 13 Aug 2025 23:26:59 +0200
Message-ID: <20250813212713.112861-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 593c985ee3e8fc34348
X-MBO-RS-META: 9n8qs54f48mrswfr9r91czoy5hfqfssw
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

The Retronix R-Car V4H Sparrow Hawk EVTB1 uses 1V8 IO voltage supply
for VDDQ18_25_AVB power rail. Update the AVB0 pinmux to reflect the
change in IO voltage. Since the VDDQ18_25_AVB power rail is shared,
all four AVB0, AVB1, AVB2, TSN0 PFC/GPIO POC[7..4] registers have to
be configured the same way.

Correct the voltage for EVTA1 boards accordingly by patching the U-Boot
control DT in SPL.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
---
V2: Move DT change to arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
    until the same fix lands in mainline Linux
---
 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi |  7 +++++++
 board/renesas/sparrowhawk/sparrowhawk.c        | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
index b5f226f2f2a..dff0355150d 100644
--- a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
@@ -7,6 +7,13 @@
 
 #include "r8a779g0-u-boot.dtsi"
 
+&avb0_pins {
+	pins-vddq18-25-avb {
+		pins = "PIN_VDDQ_AVB0", "PIN_VDDQ_AVB1", "PIN_VDDQ_AVB2", "PIN_VDDQ_TSN0";
+		power-source = <1800>;
+	};
+};
+
 /* Page 31 / FAN */
 &gpio1 {
 	pwm-fan-hog {
diff --git a/board/renesas/sparrowhawk/sparrowhawk.c b/board/renesas/sparrowhawk/sparrowhawk.c
index 1fd7a63d2fa..58de7f25cbd 100644
--- a/board/renesas/sparrowhawk/sparrowhawk.c
+++ b/board/renesas/sparrowhawk/sparrowhawk.c
@@ -231,6 +231,18 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
 		printf("Failed to disable UHS pins in MicroSD node: %d\n", err);
 		return;
 	}
+
+	offs = fdt_path_offset(blob, "/soc/pinctrl@e6050000/avb0/pins-vddq18-25-avb");
+	if (offs < 0) {
+		printf("Failed to locate AVB pinctrl node: %d\n", offs);
+		return;
+	}
+
+	err = fdt_setprop_u32(blob, offs, "power-source", 2500);
+	if (err < 0) {
+		printf("Failed to set AVB IO voltage: %d\n", err);
+		return;
+	}
 }
 #endif
 
-- 
2.47.2

