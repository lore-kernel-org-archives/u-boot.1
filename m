Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA65C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 12:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 891218488D;
	Mon,  6 Jul 2026 14:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pP24vyu4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 157768490A; Mon,  6 Jul 2026 14:34:20 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AAE2846FD
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 14:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mathieu.dubois-briand@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 96AD9C8EC79;
 Mon,  6 Jul 2026 12:34:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7E7B5601A2;
 Mon,  6 Jul 2026 12:34:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8858B11BB98E0; 
 Mon,  6 Jul 2026 14:34:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1783341256; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=bcBhDPsgCXtLxJIXOoLciRsOKWPufiZs6DNQTYB9Id0=;
 b=pP24vyu4S8G4WU4o/w75tY1GkkOPTn5iI5kVH+sEvHrjbo7BzDiUDAo25hor+e0q9uMzJK
 iSdajTek65/GVp2li0fySGzG6MB1c8uujskatrt8M0FUapT7xlG3dwe4FuTZHlBOJGS8wp
 F1k6NnIoW/7tYcDOFEpdf/d9Xd+HV4FGWQhbKqYjioBs9YOp+qmhJN/9oAFska0Q321/1K
 spCaHuIlcy9FRg0KPfqdkn588aaXTeyVz3AmDu2gb8ufUaXyyrzfZjJ8H9M6/MaJJSWfJn
 xlnR6u8IQWBWJqp0b41Nh4UdQ8gHWva9PT3tcinLo5xra0Z1i0sp4Ubg3Zqeig==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 06 Jul 2026 14:34:01 +0200
Subject: [PATCH] imx93_frdm: Add OP-TEE device tree node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-master-v1-1-25bae88d130a@bootlin.com>
X-B4-Tracking: v=1; b=H4sIALigS2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwMz3dzE4pLUIt1kc8NEA6M0UwOTNAMloOKCotS0zAqwQdGxtbUA17B
 1/FgAAAA=
X-Change-ID: 20260706-master-c71a02f504f0
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341255; l=951;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=kTRvRs/oPe+/o3iqgdeKPzMpKmrcd0/Ffeyv01pjR08=;
 b=rgUUjizAO1KvgIjTY+P61/rcGlK7K+yxpDY9HzljyEd2f4SC/7PHQ3e/jH2rWT7JdcyWlLgAp
 ZJNreyRLHxSBIoIWPPc1aSy3UkUMPxDRSrZduoW65Bhi9gpTAzaUh2s
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
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

Add missing firmware/optee node, so is can be both used and copied into
Linux device tree by optee_copy_firmware_node(). This is consistent with
other i.MX93 boards.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi b/arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi
index 41111b1a95a2..2ce9f46b2ad8 100644
--- a/arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi
+++ b/arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi
@@ -12,6 +12,13 @@
 		bootph-pre-ram;
 		bootph-some-ram;
 	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
 };
 
 &A55_0 {

---
base-commit: 780084d7c07f511da4a39b43277c573156ed42e0
change-id: 20260706-master-c71a02f504f0

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

