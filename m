Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF106070F1B
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lzmgg5vj;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=jDyeK4Qn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AAACB40DA0;
	Fri, 13 Nov 2026 17:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UX8t0-G1IklX; Fri, 13 Nov 2026 17:20:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 032F640D8D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794590450;
	b=P0wWShFa1+QRGCpy6LZg9H/oD80dSANzwy8cBvdyXoC2X5mTJdJQ6fbOllLt9U0bGEnj
	 J/EzmRX5PW1EVflmDIW/RJ0bwu41WNW2ML2w6IYkA35NWVO/G+FscVSEeQTeGkP6xCmig
	 jisHtnqyYj/4/ZUq0ud1gD5ADj2SP46/yKgQE7kIWBqLSOo78QJrUGqbwFWj4hd6SOoc7
	 sHt5U5wbk/rp5FJXKLOuhbRydoPGRFenN6rAioBDiZ5EFcZHJVc5Ecc7WnXNvC6UFpNoJ
	 G0JnyVsrIKDF8/jDB3buNAHRFnGAf7C5eBcpbmSc3OesFW20AAsgCdhmU+ywpizMzxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794590450;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+Lb+1PqOWHUH5SRlfpWs9xqAfMvJat0NJ7Zag9uVqEQ=;
	b=VvcMKNE6UMb3k7m4bIfcuE9PkL8GKqYtTN5B9A/ZmWcSPCQrg0m/fOmdcJd78po8bTSY
	 rVEj+5rHoepvihl4Yn7tImBLynDID5K4xaJMz9tltB1lOZ9Ko6iLEoJ0jF51Cv8vzMG3P
	 pYqmNzkvdRIyvkny8sDWiLmUmLloEFXLWlde2Jxhha55TEDvcmX2/ZP8sJ+mk0ThmErhX
	 51CvcUlag1t/O27cpZnbjjWPqCKjy0LTNa2J7NJcf+BKBbjg98QYoGpsWwamdA1UYSbiL
	 qJVIM5BQn2FZ8B31SuTvfEHs3VheWZhuM4UZfLSVsIrIKKHtJZWKNtsvNgISju8iVjQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794590450;
	bh=+Lb+1PqOWHUH5SRlfpWs9xqAfMvJat0NJ7Zag9uVqEQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lzmgg5vjAV/hKPBan3NWAYzoxtE59YntBYrdOdxa2m5Qkm/tfGnQtxVGssjTyujjs
	 H6rbGB1T6k22jMM6X/JpHv8pAUW8dLI2FILUavM6wpvbQCSSKwtYmJ4p/h/O5ra8gX
	 ycs08M+ZOBldZQICd+7cYDD2fNIZbBCt2LmjOVHIWaB9haZB4yP30xr52QCb9Vg7uS
	 mCZ1nIbTsMW4J7qRNHKvVlh92vAEpGnq8rOvA0TdtK2/AXQZl8l+wgfKItejHdnnts
	 nSXF1uIVwiK8gQpeUvXdtoEbLouE3UoaVoQw2l2oKHaVn6AKgDe2IiPptcEd/UpdXk
	 MOea2Z5OCG5QQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 032F640D8D;
	Fri, 13 Nov 2026 17:20:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AF2CA2E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:20:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ACAD5400A8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:20:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id enkNeP32GUok for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:20:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 307BC4005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jDyeK4Qn
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 307BC4005E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:20:46 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7f84a55e31aso1471593a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 09:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794590445; x=1795195245;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+Lb+1PqOWHUH5SRlfpWs9xqAfMvJat0NJ7Zag9uVqEQ=;
 b=jDyeK4Qndg75qitSdEK0IfLdqcgQZzxBWfOZQ+ioFBTcbhBKsjyOkx9hX7pwBPY9+I
 DqUHKqI1Xl4u1BdJLB77B1U0POKoS8ghOt5oFDEyyQjEnuE+S2f5jlzRvW6zQnaPq+Ax
 l7c6SasCfy3VZKoK+TGx6lyquTR2bwW5xKRPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794590445; x=1795195245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+Lb+1PqOWHUH5SRlfpWs9xqAfMvJat0NJ7Zag9uVqEQ=;
 b=QR48hUs/4fwhfacXi5xKGWwd/JDXLec0ajWJHSnkcR32gyi0BHZ8FHfxbZxgaCjxJg
 Nk79/cihp37XmYdivSvXb1YBdSHDFzw0Wl9GKx2AfM14UeIA7j5MqDjKSGN35ZNMGljT
 3/Nwab82S9PhjCR8GYODxek7F2eJNi4XXXQyrNuLFHJhr4YE629gWHz9AZLeU+HHqcE+
 bjJFZKxltU3tIEC93rp7NdiYmHUiP4JlrIesBh5cEGowJQxDlPhzLgPRwDG8xQyYsxJE
 ijEVgUfgOyRMDX8V6NwoXmdsUki1uR+i8w2y0aZ+jTzsOkbrIzZkVMAqcLVTAfXRUaLL
 txgQ==
X-Gm-Message-State: APuU4Z9iCKY2z43KQ9JEgpfTTREYE4RqhmxicS4mPlMy3HM3WCIibdBE
 JJp/oC8Nc53Z1Vi258xPzgPleqIp5LZxYwRZrmrGsqsYOZMOQfpR79ZMCg1wqpArEIfuGSZQh6c
 QR6vLbKHMDw==
X-Gm-Gg: AYBFou3OwONRq8dRabj9exonwb3Ojjj8/psyxjWoK8nWGODU67GBFXvoTcUBJKXieU8
 wQQF9jp2i638qarMGO+cUf3SMNFJ1NSSIR40Dkws0+w23QqL4lPA/Y4jcHSD6khTm1e0whSevLp
 rGpSkbBfjWeX5hXCW0WG6yq540EVjt+gNjMzIcCDerBosHPFD8LdKhiXrrKI1cFBjGqjgZJfqeZ
 Zn5wn4dRKee8LuhFPSFUKwYVMeRDTtAtfBdnvVOUoWWR413/zmUm0VTNQ6rmxH60nGsXjGkAy/U
 GSkSvld+d/tzuFOcIj7K5Qh5pDc0QCoR4WwJ68ojrKKHq2MuXIrD5Z/6gtx32E2UdaJl2RB5i/0
 6GrDvz13LSYJVX1/zMusemyVaQ3Y0HbDR5ZuhjzyISXISFKmhrEBAOP6iSGWz+bqfRacUHxmGj3
 8XCp/t8czJICi3qw0PWuH1z3dvm0dcfgr9WEUwfG1Jy3jvfvm2jMIwyOrlMULFTzud/7OeNuj+5
 3tap97gLkt6fn0nBPvxQfDozGc6PmMKoCh5LBteKGvFwtHBc/NFcc9bTkqAPZJDeHgsGMPGIbnq
 VV1vqkXcJSmr6bC1+MFtCJwMyRzWdrSsDDkVgJxI0/3ZKHll7dCdy6XL31rNyZleOK0EKWexrx6
 E3RXflI97xGj0pfKtr5Fu9uNZIRXrtCFz6Rfn5mETZzhMVIjYKOFnj4+RJShThWwOia1X3sFhnl
 OAnWaYZGFA7Q7yydLWljJaYfuacoum7iUlE5xBz6jV9TadV3HfkKsxAxRUW4kBjIExNVvXk9UAQ
 4Z8jg==
X-Received: by 2002:a05:6830:718c:b0:802:68c:1606 with SMTP id
 46e09a7af769-8628974186bmr2854363a34.1.1794590445405; 
 Fri, 13 Nov 2026 09:20:45 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8628818de94sm2797106a34.23.2026.11.13.09.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:20:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] arm: Remove spring board
Date: Fri, 13 Nov 2026 11:20:43 -0600
Message-ID: <20261113172043.1235725-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This board no longer has an active maintainer. Furthermore, as it seems
unlikely there are active users of this platform, remove it now instead
of waiting.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If someone would like to pick this up instead, that's fine.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm/dts/Makefile              |   1 -
 arch/arm/dts/exynos5250-spring.dts | 702 -----------------------------
 arch/arm/mach-exynos/Kconfig       |   8 -
 board/samsung/smdk5250/Kconfig     |  13 -
 board/samsung/smdk5250/MAINTAINERS |   6 -
 configs/spring_defconfig           | 102 -----
 include/configs/spring.h           |  13 -
 7 files changed, 845 deletions(-)
 delete mode 100644 arch/arm/dts/exynos5250-spring.dts
 delete mode 100644 configs/spring_defconfig
 delete mode 100644 include/configs/spring.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index cf4674042a2c..9efbc95b9384 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -22,7 +22,6 @@ dtb-$(CONFIG_TARGET_POPLAR) += hi3798cv200-poplar.dtb
 
 dtb-$(CONFIG_ARCH_EXYNOS5) += exynos5250-arndale.dtb \
 	exynos5250-snow.dtb \
-	exynos5250-spring.dtb \
 	exynos5250-smdk5250.dtb \
 	exynos5420-smdk5420.dtb \
 	exynos5420-peach-pit.dtb \
diff --git a/arch/arm/dts/exynos5250-spring.dts b/arch/arm/dts/exynos5250-spring.dts
deleted file mode 100644
index 9c478837ba44..000000000000
--- a/arch/arm/dts/exynos5250-spring.dts
+++ /dev/null
@@ -1,702 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Google Spring board device tree source
- *
- * Copyright (c) 2013 Google, Inc
- * Copyright (c) 2014 SUSE LINUX Products GmbH
- */
-
-/dts-v1/;
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/input/input.h>
-#include "exynos5250.dtsi"
-
-/ {
-	model = "Google Spring";
-	compatible = "google,spring", "samsung,exynos5250", "samsung,exynos5";
-
-	aliases {
-		i2c0 = "/i2c@12C60000";
-		i2c1 = "/i2c@12C70000";
-		i2c2 = "/i2c@12C80000";
-		i2c3 = "/i2c@12C90000";
-		i2c4 = "/i2c@12CA0000";
-		i2c5 = "/i2c@12CB0000";
-		i2c6 = "/i2c@12CC0000";
-		i2c7 = "/i2c@12CD0000";
-		i2c104 = &cros_ec_ldo_tunnel;
-		spi0 = "/spi@12d20000";
-		spi1 = "/spi@12d30000";
-		spi2 = "/spi@12d40000";
-		spi3 = "/spi@131a0000";
-		spi4 = "/spi@131b0000";
-		mmc0 = "/mmc@12200000";
-		serial0 = "/serial@12C30000";
-		console = "/serial@12C30000";
-	};
-
-	memory {
-		reg = <0x40000000 0x80000000>;
-	};
-
-	iram {
-		reg = <0x02020000 0x60000>;
-	};
-
-	config {
-		samsung,bl1-offset = <0x1400>;
-		samsung,bl2-offset = <0x3400>;
-		u-boot-memory = "/memory";
-		u-boot-offset = <0x3e00000 0x100000>;
-	};
-
-	flash@0 {
-		reg = <0 0x100000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		pre-boot {
-			label = "bl1 pre-boot";
-			reg = <0 0x2000>;
-			read-only;
-			filename = "e5250.nbl1.bin";
-			type = "blob exynos-bl1";
-			required;
-		};
-
-		spl {
-			label = "bl2 spl";
-			reg = <0x2000 0x8000>;
-			read-only;
-			filename = "bl2.bin";
-			type = "blob exynos-bl2 boot,dtb";
-			payload = "/flash/ro-boot";
-			required;
-		};
-
-		ro-boot {
-			label = "u-boot";
-			reg = <0xa000 0xb0000>;
-			read-only;
-			type = "blob boot,dtb";
-			required;
-		};
-	};
-
-	chosen {
-		bootargs = "console=tty1";
-		stdout-path = "serial3:115200n8";
-	};
-
-	board-rev {
-		compatible = "google,board-revision";
-		google,board-rev-gpios = <&gpy4 0 0>, <&gpy4 1 0>,
-					 <&gpy4 2 0>;
-	};
-
-	i2c@12C90000 {
-		clock-frequency = <100000>;
-		tpm@20 {
-			reg = <0x20>;
-			compatible = "infineon,slb9645tt";
-		};
-	};
-
-	mmc@12200000 {
-		bus-width = <8>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <1 3>;
-		non-removable;
-	};
-
-	mmc@12210000 {
-		status = "disabled";
-	};
-
-	mmc@12220000 {
-		/* MMC2 pins are used as GPIO for eDP bridge */
-		status = "disabled";
-	};
-
-	mmc@12230000 {
-		status = "disabled";
-	};
-
-	ehci@12110000 {
-		samsung,vbus-gpio = <&gpx1 1 GPIO_ACTIVE_HIGH>;
-		status = "okay";
-	};
-
-	xhci@12000000 {
-		samsung,vbus-gpio = <&gpx2 7 GPIO_ACTIVE_HIGH>;
-	};
-
-	sound {
-		compatible = "google,spring-audio-max98088";
-
-		samsung,model = "Spring-I2S-MAX98088";
-		samsung,audio-codec = <&max98088>;
-		codec-enable-gpio = <&gpx1 7 0>;
-
-		cpu {
-			sound-dai = <&i2s1 0>;
-		};
-
-		codec {
-			sound-dai = <&max98088 0>;
-		};
-	};
-
-	spi@12d30000 {
-		spi-max-frequency = <50000000>;
-		firmware_storage_spi: flash@0 {
-			compatible = "jedec,spi-nor";
-			reg = <0>;
-		};
-	};
-
-	tmu@10060000 {
-		samsung,min-temp	= <25>;
-		samsung,max-temp	= <125>;
-		samsung,start-warning	= <95>;
-		samsung,start-tripping	= <105>;
-		samsung,hw-tripping	= <110>;
-		samsung,efuse-min-value	= <40>;
-		samsung,efuse-value	= <55>;
-		samsung,efuse-max-value	= <100>;
-		samsung,slope		= <274761730>;
-		samsung,dc-value	= <25>;
-	};
-
-	fimd@14400000 {
-		samsung,vl-freq = <60>;
-		samsung,vl-col = <1366>;
-		samsung,vl-row = <768>;
-		samsung,vl-width = <1366>;
-		samsung,vl-height = <768>;
-
-		samsung,vl-clkp;
-		samsung,vl-dp;
-		samsung,vl-hsp;
-		samsung,vl-vsp;
-
-		samsung,vl-bpix = <4>;
-
-		samsung,vl-hspw = <32>;
-		samsung,vl-hbpd = <80>;
-		samsung,vl-hfpd = <48>;
-		samsung,vl-vspw = <5>;
-		samsung,vl-vbpd = <14>;
-		samsung,vl-vfpd = <3>;
-		samsung,vl-cmd-allow-len = <0xf>;
-
-		samsung,winid = <0>;
-		samsung,interface-mode = <1>;
-		samsung,dp-enabled = <1>;
-		samsung,dual-lcd-enabled = <0>;
-	};
-
-	dp@145b0000 {
-		samsung,lt-status = <0>;
-
-		samsung,master-mode = <0>;
-		samsung,bist-mode = <0>;
-		samsung,bist-pattern = <0>;
-		samsung,h-sync-polarity = <0>;
-		samsung,v-sync-polarity = <0>;
-		samsung,interlaced = <0>;
-		samsung,color-space = <0>;
-		samsung,dynamic-range = <0>;
-		samsung,ycbcr-coeff = <0>;
-		samsung,color-depth = <1>;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm 0 1000000 0>;
-		brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
-		default-brightness-level = <1>;
-		enable-gpios = <&gpx3 0 GPIO_ACTIVE_HIGH>;
-		power-supply = <&fet1>;
-	};
-
-	panel: panel {
-		compatible = "auo,b116xw03";
-		power-supply = <&fet6>;
-		backlight = <&backlight>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&bridge_out>;
-			};
-		};
-	};
-};
-
-&i2c_0 {
-	status = "okay";
-	samsung,i2c-sda-delay = <100>;
-	samsung,i2c-max-bus-freq = <378000>;
-
-	s5m8767-pmic@66 {
-		compatible = "samsung,s5m8767-pmic";
-		reg = <0x66>;
-		interrupt-parent = <&gpx3>;
-		wakeup-source;
-
-		s5m8767,pmic-buck-dvs-gpios = <&gpd1 0 GPIO_ACTIVE_LOW>, /* DVS1 */
-		                              <&gpd1 1 GPIO_ACTIVE_LOW>, /* DVS2 */
-		                              <&gpd1 2 GPIO_ACTIVE_LOW>; /* DVS3 */
-
-		s5m8767,pmic-buck-ds-gpios = <&gpx2 3 GPIO_ACTIVE_LOW>, /* SET1 */
-		                             <&gpx2 4 GPIO_ACTIVE_LOW>, /* SET2 */
-		                             <&gpx2 5 GPIO_ACTIVE_LOW>; /* SET3 */
-
-		/*
-		 * The following arrays of DVS voltages are not used, since we are
-		 * not using GPIOs to control PMIC bucks, but they must be defined
-		 * to please the driver.
-		 */
-		s5m8767,pmic-buck2-dvs-voltage = <1350000>, <1300000>,
-		                                 <1250000>, <1200000>,
-		                                 <1150000>, <1100000>,
-		                                 <1000000>, <950000>;
-
-		s5m8767,pmic-buck3-dvs-voltage = <1100000>, <1100000>,
-		                                 <1100000>, <1100000>,
-		                                 <1000000>, <1000000>,
-		                                 <1000000>, <1000000>;
-
-		s5m8767,pmic-buck4-dvs-voltage = <1200000>, <1200000>,
-		                                 <1200000>, <1200000>,
-		                                 <1200000>, <1200000>,
-		                                 <1200000>, <1200000>;
-
-		clocks {
-			compatible = "samsung,s5m8767-clk";
-			#clock-cells = <1>;
-			clock-output-names = "en32khz_ap",
-			                     "en32khz_cp",
-			                     "en32khz_bt";
-		};
-
-		regulators {
-			ldo4_reg: LDO4 {
-				regulator-name = "P1.0V_LDO_OUT4";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-				op_mode = <0>;
-			};
-
-			ldo5_reg: LDO5 {
-				regulator-name = "P1.8V_LDO_OUT5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				op_mode = <0>;
-			};
-
-			ldo6_reg: LDO6 {
-				regulator-name = "vdd_mydp";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-always-on;
-				op_mode = <3>;
-			};
-
-			ldo7_reg: LDO7 {
-				regulator-name = "P1.1V_LDO_OUT7";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-always-on;
-				op_mode = <3>;
-			};
-
-			ldo8_reg: LDO8 {
-				regulator-name = "P1.0V_LDO_OUT8";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-				op_mode = <3>;
-			};
-
-			ldo10_reg: LDO10 {
-				regulator-name = "P1.8V_LDO_OUT10";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				op_mode = <3>;
-			};
-
-			ldo11_reg: LDO11 {
-				regulator-name = "P1.8V_LDO_OUT11";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				op_mode = <0>;
-			};
-
-			ldo12_reg: LDO12 {
-				regulator-name = "P3.0V_LDO_OUT12";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
-				op_mode = <3>;
-			};
-
-			ldo13_reg: LDO13 {
-				regulator-name = "P1.8V_LDO_OUT13";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				op_mode = <0>;
-			};
-
-			ldo14_reg: LDO14 {
-				regulator-name = "P1.8V_LDO_OUT14";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				op_mode = <3>;
-			};
-
-			ldo15_reg: LDO15 {
-				regulator-name = "P1.0V_LDO_OUT15";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-				op_mode = <3>;
-			};
-
-			ldo16_reg: LDO16 {
-				regulator-name = "P1.8V_LDO_OUT16";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				op_mode = <3>;
-			};
-
-			ldo17_reg: LDO17 {
-				regulator-name = "P1.2V_LDO_OUT17";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-always-on;
-				op_mode = <0>;
-			};
-
-			ldo25_reg: LDO25 {
-				regulator-name = "vdd_bridge";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-always-on;
-				op_mode = <1>;
-			};
-
-			buck1_reg: BUCK1 {
-				regulator-name = "vdd_mif";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-always-on;
-				regulator-boot-on;
-				op_mode = <3>;
-			};
-
-			buck2_reg: BUCK2 {
-				regulator-name = "vdd_arm";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-always-on;
-				regulator-boot-on;
-				op_mode = <3>;
-			};
-
-			buck3_reg: BUCK3 {
-				regulator-name = "vdd_int";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-always-on;
-				regulator-boot-on;
-				op_mode = <3>;
-			};
-
-			buck4_reg: BUCK4 {
-				regulator-name = "vdd_g3d";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				op_mode = <3>;
-			};
-
-			buck5_reg: BUCK5 {
-				regulator-name = "P1.8V_BUCK_OUT5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-				op_mode = <1>;
-			};
-
-			buck6_reg: BUCK6 {
-				regulator-name = "P1.2V_BUCK_OUT6";
-				regulator-min-microvolt = <2050000>;
-				regulator-max-microvolt = <2050000>;
-				regulator-always-on;
-				regulator-boot-on;
-				op_mode = <0>;
-			};
-
-			buck9_reg: BUCK9 {
-				regulator-name = "vdd_ummc";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
-				regulator-boot-on;
-				op_mode = <3>;
-			};
-		};
-	};
-};
-
-&dp {
-	status = "okay";
-	samsung,color-space = <0>;
-	samsung,dynamic-range = <0>;
-	samsung,ycbcr-coeff = <0>;
-	samsung,color-depth = <1>;
-	samsung,link-rate = <0x0a>;
-	samsung,lane-count = <1>;
-	samsung,hpd-gpio = <&gpc3 0 GPIO_ACTIVE_HIGH>;
-
-	ports {
-		port@0 {
-			dp_out: endpoint {
-				remote-endpoint = <&bridge_in>;
-			};
-		};
-	};
-};
-
-&i2c_1 {
-	status = "okay";
-	samsung,i2c-sda-delay = <100>;
-	samsung,i2c-max-bus-freq = <378000>;
-};
-
-&i2c_2 {
-	status = "okay";
-	samsung,i2c-sda-delay = <100>;
-	samsung,i2c-max-bus-freq = <66000>;
-};
-
-&i2c_3 {
-	status = "okay";
-	samsung,i2c-sda-delay = <100>;
-	samsung,i2c-max-bus-freq = <66000>;
-};
-
-&i2c_4 {
-	status = "okay";
-	samsung,i2c-sda-delay = <100>;
-	samsung,i2c-max-bus-freq = <66000>;
-	clock-frequency = <66000>;
-
-	cros_ec: embedded-controller {
-		compatible = "google,cros-ec-i2c";
-		reg = <0x1e>;
-		interrupts = <6 IRQ_TYPE_NONE>;
-		interrupt-parent = <&gpx1>;
-		wakeup-source;
-		u-boot,i2c-offset-len = <0>;
-		ec-interrupt = <&gpx1 6 GPIO_ACTIVE_LOW>;
-		cros_ec_ldo_tunnel: cros-ec-ldo-tunnel {
-			compatible = "google,cros-ec-ldo-tunnel";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			power-regulator {
-				compatible = "ti,tps65090";
-				reg = <0x48>;
-
-				regulators {
-					dcdc1 {
-						ti,enable-ext-control;
-					};
-					dcdc2 {
-						ti,enable-ext-control;
-					};
-					dcdc3 {
-						ti,enable-ext-control;
-					};
-					fet1: fet1 {
-						regulator-name = "vcd_led";
-						ti,overcurrent-wait = <3>;
-					};
-					tps65090_fet2: fet2 {
-						regulator-name = "video_mid";
-						regulator-always-on;
-						ti,overcurrent-wait = <3>;
-					};
-					fet3 {
-						regulator-name = "wwan_r";
-						regulator-always-on;
-						ti,overcurrent-wait = <3>;
-					};
-					fet4 {
-						regulator-name = "sdcard";
-						ti,overcurrent-wait = <3>;
-					};
-					fet5 {
-						regulator-name = "camout";
-						regulator-always-on;
-						ti,overcurrent-wait = <3>;
-					};
-					fet6: fet6 {
-						regulator-name = "lcd_vdd";
-						ti,overcurrent-wait = <3>;
-					};
-					tps65090_fet7: fet7 {
-						regulator-name = "video_mid_1a";
-						regulator-always-on;
-						ti,overcurrent-wait = <3>;
-					};
-					ldo1 {
-					};
-					ldo2 {
-					};
-				};
-			};
-		};
-	};
-};
-
-&i2c_5 {
-	status = "okay";
-	samsung,i2c-sda-delay = <100>;
-	samsung,i2c-max-bus-freq = <66000>;
-};
-
-&i2c_7 {
-	status = "okay";
-	samsung,i2c-sda-delay = <100>;
-	samsung,i2c-max-bus-freq = <66000>;
-
-	ps8622-bridge@8 {
-		compatible = "parade,ps8622";
-		reg = <0x8>;
-		sleep-gpios = <&gpc3 6 GPIO_ACTIVE_LOW>;
-		reset-gpios = <&gpc3 1 GPIO_ACTIVE_LOW>;
-		hotplug-gpios = <&gpc3 0 GPIO_ACTIVE_HIGH>;
-		power-supply = <&ldo6_reg>;
-		parade,regs = /bits/ 8 <
-			0x02 0xa1 0x01 /* HPD low */
-			/*
-			 * SW setting: [1:0] SW output 1.2V voltage is
-			 * lower to 96%
-			 */
-			0x04 0x14 0x01
-			/* RCO SS setting: [5:4] = b01 0.5%, b10 1%, b11 1.5% */
-			0x04 0xe3 0x20
-			0x04 0xe2 0x80 /* [7] RCO SS enable */
-			/*
-			 * RPHY Setting: [3:2] CDR tune wait cycle before
-			 * measure for fine tune b00: 1us,
-			 * 01: 0.5us, 10:2us, 11:4us
-			 */
-			0x04 0x8a 0x0c
-			0x04 0x89 0x08 /* [3] RFD always on */
-			/*
-			 * CTN lock in/out: 20000ppm/80000ppm. Lock out 2 times
-			 */
-			0x04 0x71 0x2d
-			/* 2.7G CDR settings */
-			0x04 0x7d 0x07 /* NOF=40LSB for HBR CDR setting */
-			0x04 0x7b 0x00 /* [1:0] Fmin=+4bands */
-			0x04 0x7a 0xfd /* [7:5] DCO_FTRNG=+-40% */
-			/*
-			 * 1.62G CDR settings:
-			 * [5:2]NOF=64LSB [1:0]DCO scale is 2/5
-			 */
-			0x04 0xc0 0x12
-			0x04 0xc1 0x92 /* Gitune=-37% */
-			0x04 0xc2 0x1c /* Fbstep=100% */
-			0x04 0x32 0x80 /* [7] LOS signal disable */
-			/* RPIO Setting */
-			/* [7:4] LVDS driver bias current 75% (250mV swing) */
-			0x04 0x00 0xb0
-			 /* [7:6] Right-bar GPIO output strength is 8mA */
-			0x04 0x15 0x40
-			/* EQ Training State Machine Setting */
-			0x04 0x54 0x10 /* RCO calibration start */
-			/* [4:0] MAX_LANE_COUNT set to one lane */
-			0x01 0x02 0x81
-			/* [4:0] LANE_COUNT_SET set to one lane */
-			0x01 0x21 0x81
-			0x00 0x52 0x20
-			0x00 0xf1 0x03 /* HPD CP toggle enable */
-			0x00 0x62 0x41
-			/* Counter number add 1ms counter delay */
-			0x00 0xf6 0x01
-			/*
-			 * [6]PWM function control by DPCD0040f[7], default
-			 * is PWM block always works
-			 */
-			0x00 0x77 0x06
-			0x00 0x4c 0x04
-			/*
-			 * 04h Adjust VTotal tolerance to fix the 30Hz no-
-			 * display issue
-			 * DPCD00400='h00 Parade OUI = 'h001cf8
-			 */
-			0x01 0xc0 0x00
-			0x01 0xc1 0x1c /* DPCD00401='h1c */
-			0x01 0xc2 0xf8 /* DPCD00402='hf8 */
-			/* DPCD403~408 = ASCII code D2SLV5='h4432534c5635 */
-			0x01 0xc3 0x44
-			0x01 0xc4 0x32 /* DPCD404 */
-			0x01 0xc5 0x53 /* DPCD405 */
-			0x01 0xc6 0x4c /* DPCD406 */
-			0x01 0xc7 0x56 /* DPCD407 */
-			0x01 0xc8 0x35 /* DPCD408 */
-			/* DPCD40A Initial Code major revision '01' */
-			0x01 0xca 0x01
-			/* DPCD40B Initial Code minor revision '05' */
-			0x01 0xcb 0x05
-			0x01 0xa5 0xa0 /* DPCD720, Select internal PWM */
-			/*
-			 * 0xff for 100% PWM of brightness, 0h for 0% brightness
-			 */
-			0x01 0xa7 0x00
-			/*
-			 * Set LVDS output as 6bit-VESA mapping, single LVDS
-			 * channel
-			 */
-			0x01 0xcc 0x13
-			0x02 0xb1 0x20 /* Enable SSC set by register */
-			/* Set SSC enabled and +/-1% central spreading */
-			0x04 0x10 0x16
-			0x04 0x59 0x60 /* MPU Clock source: LC => RCO */
-			0x04 0x54 0x14 /* LC -> RCO */
-			0x02 0xa1 0x91>; /* HPD high */
-		ports {
-			port@0 {
-				bridge_out: endpoint {
-					remote-endpoint = <&panel_in>;
-				};
-			};
-
-			port@1 {
-				bridge_in: endpoint {
-					remote-endpoint = <&dp_out>;
-				};
-			};
-		};
-	};
-
-	max98088: soundcodec@10 {
-		reg = <0x10>;
-		compatible = "maxim,max98088";
-		#sound-dai-cells = <1>;
-	};
-};
-
-#include "cros-ec-keyboard.dtsi"
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index b084b7284aa0..fc315e161d8c 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -157,13 +157,6 @@ config TARGET_SNOW
 	select OF_CONTROL
 	select SUPPORT_SPL
 
-config TARGET_SPRING
-	bool "Spring board"
-	select EXYNOS5_DT
-	select EXYNOS5250
-	select OF_CONTROL
-	select SUPPORT_SPL
-
 config TARGET_SMDK5420
 	bool "SMDK5420 board"
 	select EXYNOS5_DT
@@ -280,7 +273,6 @@ source "board/samsung/origen/Kconfig"
 source "board/samsung/trats2/Kconfig"
 source "board/samsung/odroid/Kconfig"
 source "board/samsung/arndale/Kconfig"
-source "board/samsung/smdk5250/Kconfig"
 source "board/samsung/smdk5420/Kconfig"
 source "board/samsung/espresso7420/Kconfig"
 source "board/samsung/axy17lte/Kconfig"
diff --git a/board/samsung/smdk5250/Kconfig b/board/samsung/smdk5250/Kconfig
index 11ffaee5ce17..698ee9125c92 100644
--- a/board/samsung/smdk5250/Kconfig
+++ b/board/samsung/smdk5250/Kconfig
@@ -23,16 +23,3 @@ config SYS_CONFIG_NAME
 	default "snow"
 
 endif
-
-if TARGET_SPRING
-
-config SYS_BOARD
-	default "smdk5250"
-
-config SYS_VENDOR
-	default "samsung"
-
-config SYS_CONFIG_NAME
-	default "spring"
-
-endif
diff --git a/board/samsung/smdk5250/MAINTAINERS b/board/samsung/smdk5250/MAINTAINERS
index c60b6f81e9bd..8b012768dbd4 100644
--- a/board/samsung/smdk5250/MAINTAINERS
+++ b/board/samsung/smdk5250/MAINTAINERS
@@ -10,9 +10,3 @@ M:	Jaehoon Chung <jh80.chung@samsung.com>
 S:	Maintained
 F:	include/configs/snow.h
 F:	configs/snow_defconfig
-
-SPRING BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
-F:	include/configs/spring.h
-F:	configs/spring_defconfig
diff --git a/configs/spring_defconfig b/configs/spring_defconfig
deleted file mode 100644
index ebe9b8fe1194..000000000000
--- a/configs/spring_defconfig
+++ /dev/null
@@ -1,102 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SKIP_LOWLEVEL_INIT=y
-CONFIG_SPL_SKIP_LOWLEVEL_INIT=y
-CONFIG_ARCH_CPU_INIT=y
-# CONFIG_SPL_USE_ARCH_MEMCPY is not set
-# CONFIG_SPL_USE_ARCH_MEMSET is not set
-CONFIG_ARCH_EXYNOS=y
-CONFIG_TEXT_BASE=0x43E00000
-CONFIG_SYS_MALLOC_LEN=0x5004000
-CONFIG_SYS_MALLOC_F_LEN=0x400
-CONFIG_ARCH_EXYNOS5=y
-CONFIG_TARGET_SPRING=y
-CONFIG_NR_DRAM_BANKS=8
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2050000
-CONFIG_SF_DEFAULT_SPEED=50000000
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_OFFSET=0x3FC000
-CONFIG_ENV_SECT_SIZE=0x4000
-CONFIG_DEFAULT_DEVICE_TREE="exynos5250-spring"
-CONFIG_SPL_TEXT_BASE=0x02023400
-CONFIG_SYS_LOAD_ADDR=0x43e00000
-CONFIG_SPL=y
-CONFIG_DEBUG_UART_BASE=0x12c30000
-CONFIG_DEBUG_UART_CLOCK=100000000
-CONFIG_IDENT_STRING=" for spring"
-CONFIG_DEBUG_UART=y
-CONFIG_FIT=y
-CONFIG_FIT_BEST_MATCH=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_SYS_PBSIZE=1024
-CONFIG_SILENT_CONSOLE=y
-# CONFIG_SPL_FRAMEWORK is not set
-CONFIG_SPL_FOOTPRINT_LIMIT=y
-CONFIG_SPL_MAX_FOOTPRINT=0x3800
-CONFIG_SYS_PROMPT="spring # "
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_USB=y
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_TIME=y
-CONFIG_CMD_SOUND=y
-CONFIG_CMD_PMIC=y
-CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_TPM=y
-CONFIG_CMD_TPM_TEST=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_SPI_BUS=1
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_I2C_CROS_EC_LDO=y
-CONFIG_SYS_I2C_S3C24X0=y
-CONFIG_I2C_MUX=y
-CONFIG_I2C_ARB_GPIO_CHALLENGE=y
-CONFIG_CROS_EC_KEYB=y
-CONFIG_CROS_EC=y
-CONFIG_CROS_EC_I2C=y
-CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_S5P=y
-CONFIG_SPI_FLASH_GIGADEVICE=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_SMC911X=y
-CONFIG_DM_PMIC=y
-CONFIG_DM_PMIC_MAX77686=y
-CONFIG_PMIC_S5M8767=y
-CONFIG_PMIC_TPS65090=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_MAX77686=y
-CONFIG_REGULATOR_S5M8767=y
-CONFIG_REGULATOR_TPS65090=y
-CONFIG_DM_PWM=y
-CONFIG_PWM_EXYNOS=y
-CONFIG_SOUND=y
-CONFIG_I2S=y
-CONFIG_I2S_SAMSUNG=y
-CONFIG_SOUND_MAX98088=y
-CONFIG_SOUND_MAX98095=y
-CONFIG_SOUND_WM8994=y
-CONFIG_EXYNOS_SPI=y
-CONFIG_TPM_TIS_INFINEON=y
-CONFIG_USB=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_HOST_ETHER=y
-CONFIG_USB_ETHER_ASIX88179=y
-CONFIG_VIDEO=y
-# CONFIG_VIDEO_BPP8 is not set
-CONFIG_DISPLAY=y
-CONFIG_VIDEO_EXYNOS=y
-CONFIG_EXYNOS_DP=y
-CONFIG_EXYNOS_FB=y
-CONFIG_VIDEO_BRIDGE=y
-CONFIG_VIDEO_BRIDGE_PARADE_PS862X=y
-CONFIG_TPM=y
-CONFIG_ERRNO_STR=y
diff --git a/include/configs/spring.h b/include/configs/spring.h
deleted file mode 100644
index 2f0a5807be0d..000000000000
--- a/include/configs/spring.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (c) 2015 Google, Inc
- */
-
-#ifndef __CONFIG_SPRING_H
-#define __CONFIG_SPRING_H
-
-#include <configs/exynos5250-common.h>
-#include <configs/exynos5-dt-common.h>
-#include <configs/exynos5-common.h>
-
-#endif	/* __CONFIG_SPRING_H */
-- 
2.43.0

