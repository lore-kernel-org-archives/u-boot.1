Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E5AC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BBB486538;
	Mon,  6 Nov 2023 17:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="UrvHYNhk";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="C3AgvB6t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D32618272A; Mon,  6 Nov 2023 17:56:08 +0100 (CET)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56EA38272A
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id d7dfee8e;
 Mon, 6 Nov 2023 16:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=s1; bh=RqXuHz9TS+WPlinxsVYgfq0emfk
 =; b=UrvHYNhkPEuQ4VkVWvVBPV1nArzrj2y4uLz0IGjH5hpFCCKuVAwcW3u4XFs
 A2KOHVS9jGowDTKjeqE3ycl5GHyhtUsnd34QMjoIcO7gfk/rKpXDWbbWfclWeSrq
 zEhtx0J6hzTWNlbiCNDleVzUvjU6Yzu33kmkDZephPMzzUEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=from:to
 :cc:subject:date:message-id:mime-version
 :content-transfer-encoding; q=dns; s=s1; b=E+V+Mltuu6eeErDAhoE+s
 z0dQuiUpp53OTapmPUg4N7RbzHnjXZTL2IO2R7ASxPzKyy8m31597J1fdxZNiC24
 0sYNKHl3uKoFGzKxr7mT492ijrCLaJ7dztjKy7FrRl+OXaazVYDk/kgy9wEKTVlI
 tv49N4wDvhxXFstcgDDBM0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1699289778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ncj6KZ5hOf/6cfqaQ/V3ogEqlerTDklMDwTE9IEkZvc=;
 b=C3AgvB6tWZggVjSK59VZO4mcsbGmTbXjlK7bWvLeiK3XK6vfw6m/Ba6Utn2JOXujKQF2nW
 KeD0pMaS8VNkzU4S8SH4aMUSHR8O+orfZ+Pr0Pc+wXEnBbwtNNQOG2psoHFTtDtNAT8kg6
 W5m0UAiIh5Xp2QisT7UThfRkoXqkQUo=
Received: from localhost.localdomain (host-79-24-2-249.retail.telecomitalia.it
 [79.24.2.249])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 7ccddead
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 6 Nov 2023 16:56:18 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH] m68k: remove unused mcf54xx devicetree
Date: Mon,  6 Nov 2023 17:55:25 +0100
Message-ID: <20231106165525.675612-1-angelo@kernel-space.org>
X-Mailer: git-send-email 2.42.0
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

Remove unused devicetree, can be re-added later, in case
some board would use it.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
 arch/m68k/dts/mcf54xx.dtsi | 72 --------------------------------------
 1 file changed, 72 deletions(-)
 delete mode 100644 arch/m68k/dts/mcf54xx.dtsi

diff --git a/arch/m68k/dts/mcf54xx.dtsi b/arch/m68k/dts/mcf54xx.dtsi
deleted file mode 100644
index e9cebb9f74..0000000000
--- a/arch/m68k/dts/mcf54xx.dtsi
+++ /dev/null
@@ -1,72 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2018 Angelo Dureghello <angelo@sysam.it>
- */
-
-/ {
-	compatible = "fsl,mcf54x5";
-
-	aliases {
-		/* TO DO, clarify on serial, this SoC seems to have SPC and
-		 * no UARTS.
-		 */
-		spi0 = &dspi0;
-		fec0 = &fec0;
-		fec1 = &fec1;
-	};
-
-	soc {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		mbar: mbar@80000000 {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0x00000000 0x80000000 0x10000>;
-			reg = <0x80000000 0x10000>;
-
-			dspi0: dspi@8a00 {
-				compatible = "fsl,mcf-dspi";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x8a00 0x100>;
-				spi-max-frequency = <50000000>;
-				num-cs = <4>;
-				spi-mode = <0>;
-				status = "disabled";
-			};
-
-			fec0: ethernet@9000 {
-				compatible = "fsl,mcf-dma-fec";
-				reg = <0x9000 0x800>;
-				mii-base = <0>;
-				max-speed = <100>;
-				timeout-loop = <50000>;
-				rx-task = <0>;
-				tx-task = <1>;
-				rx-piority = <6>;
-				tx-piority = <7>;
-				rx-init = <16>;
-				tx-init = <17>;
-				status = "disabled";
-			};
-
-			fec1: ethernet@9800 {
-				compatible = "fsl,mcf-dma-fec";
-				reg = <0x9800 0x800>;
-				mii-base = <1>;
-				max-speed = <100>;
-				timeout-loop = <50000>;
-				rx-task = <2>;
-				tx-task = <3>;
-				rx-piority = <6>;
-				tx-piority = <7>;
-				rx-init = <30>;
-				tx-init = <31>;
-				status = "disabled";
-			};
-		};
-	};
-};
-- 
2.42.0

