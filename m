Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD80C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 14:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A56682CFA;
	Wed, 25 Jun 2025 16:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1750862527;
	bh=+DNo6IyqR8KySgYo9aFPBxzfPNCM6p6kuw/IQ3knUzs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZyhcjNupqe/6j5vvsAh07P7Ni0hpKaUp1Fk/YOknfm3BeNCOzHcJXedxv6kc90Unh
	 dP4Amog044oqo7QtmcYEHAifLieeLhnL9RRqdRgDhgSXPMUcBVlIYvtwi3GM5hHmJs
	 pyNl5qVDNR6bGK8uBEkun6QOJdZZ16fqggjoIAQhstFCiPKj46wkwqakqc/GU/8vwL
	 7IyG5ZeY0nnAdGLYSiA2QrZ4zJGN0/mR0F0hEZXPIaMwoMTOyTmkeIRjdEwdVheI3K
	 nLNkg2kQFe2lGwGCSxjUsKczm2YOWb4ffo7/ymFtFRruDoBiByw31htKRuuFapveN0
	 2aQ4BRWqEF1VQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8B7582CFA; Wed, 25 Jun 2025 16:42:05 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C513D82C4C
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="AfBla4yK"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5003F1039BD02; 
 Wed, 25 Jun 2025 16:41:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1750862519; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=+DNo6IyqR8KySgYo9aFPBxzfPNCM6p6kuw/IQ3knUzs=;
 b=AfBla4yK5YLJpy+Jls/jdCsVT8Hp+aPB2AGU+pHf1PeW4QM5P5xmtQkvsQ6uVGSDjEB/78
 aJaiVNtv/k92locERjnvcoOvP81tXvLRr9fcFtUx45k8StGG6KhAqbH+Yc0/9edHQHM+y7
 JNAC08z70hDZvivfX4YBnLMRawvtUOY4J0aigjyHtmLHkQJEZcet9MhmcaE8GDeHW0rp3n
 aKWQjkSk1vr5tUPJk4CEbiUKbwwq6veTgLw0pFPe7XGPmX/M54ip5ua7uwyeveFW2FuNnR
 ybbC2DKJfhFUu/6oReEFCxK1xIdWeayupiSSGc0fzW56kqKp+4zkYqYCr3lZeg==
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, albert.aribaud@3adev.fr,
 u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] dts: pcm052: bk4: Use proper compatible for QSPI SPI-NOR
 memory
Date: Wed, 25 Jun 2025 16:41:30 +0200
Message-Id: <20250625144130.1704509-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In the contemporary U-Boot the "spi-flash" compatible is used only when
CONFIG_$(PHASE_)SPI_FLASH_TINY is defined so spi-nor-tiny.c is compiled.

As vf610 devices are not using SPL at all, the SPI_FLASH_TINY is not
defined and no QSPI flash child nodes are considered as valid ones.

The result is that the 'sf probe' command fails and SPI NOR memory is not
accessible on e.g. BK4 device.

The fix is to use proper compatible - in this case "jedec,spi-nor".

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/dts/vf610-pcm052.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/vf610-pcm052.dtsi b/arch/arm/dts/vf610-pcm052.dtsi
index ccdc0f57e2b..2b82b7313dd 100644
--- a/arch/arm/dts/vf610-pcm052.dtsi
+++ b/arch/arm/dts/vf610-pcm052.dtsi
@@ -244,7 +244,7 @@
 	qflash0: spi_flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <108000000>;
 		reg = <0>;
 	};
@@ -252,7 +252,7 @@
 	qflash1: spi_flash@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <66000000>;
 		reg = <1>;
 	};
-- 
2.39.5

