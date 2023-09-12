Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A10CCA0EF1
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 15:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F1286EF6;
	Tue, 12 Sep 2023 17:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XSq/5s8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D28A86F61; Tue, 12 Sep 2023 17:11:14 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34AD786E24
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 17:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6bc57401cb9so568837a34.0
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694531469; x=1695136269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6RSSTmngBLyNCc6HAl9CGhao8leZdhNygf/krspFuE=;
 b=XSq/5s8RYVpX2uVMWXnrBDWg42m34X8r9wnHLz4aP8YCkCE5XV6Edrnc5Kq07xZMqV
 ib+ImebrHnVEZNAVNZ/fUjoWQCzIejc3+OL7GBNWtFJ8RkFJ7dGxZX07QDNmeowNBdtm
 bo870/PG1JT6aZstKA+D9bW+yFZqqTb+Favm7Q2D7qsJLjwhkxrngkzQegdBkCNt2PfZ
 Na0YohOBlJk0IB/ZgN4js2gDTO2n3dD8JAv++4W343AcM9nwG6eM8z3V7Tn5v4s76x64
 lvs7R0Ad1fmd5bIY7jkBtac14jzP3lbmLxpLYFn8SjBmWDaGDAgi+9FG9e4rIEU9Ib3Q
 2GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694531469; x=1695136269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y6RSSTmngBLyNCc6HAl9CGhao8leZdhNygf/krspFuE=;
 b=fhY8d9RD7Kn3fum2icBf9XnZfMXXAYhaugGZgVNXRMsgapepw9ocNnUa1VfTfx2eF4
 6MBdatC70KILSGYr8NU3AMDUdTsdmnmOGF8UmfCNhw8M4XctIjwlKr28VOsKrZuam+Ni
 qT78CDHg4pC1nthN0jiPTT8xW796ItWruiOCSFWc+EX0nuMLyYQa5NxjV6PBXhZ0Fs3U
 gnusGQEWFWDtNgQo3LgupVwNvLNlo1xZvE2EbV5+5r8/Gy44Hz/cAukhtVfbMn8MJiNm
 s2/l54GeJRtt8UF6UKmttU8nQnNaYJLLAkk07se2KwvY9Avz/TGwJTCCwcnBBGYiJcUp
 iJ8g==
X-Gm-Message-State: AOJu0Yxf/6gUc7UsyeQO9SqZCZTUWknHM3x91bHuMuLipx6eZblFfCbz
 f75a2we4YWyEX4GsWfTtmF4=
X-Google-Smtp-Source: AGHT+IE7oB2LMJNQwKHQso0yLsWB8RAX2B5beqBUusU7lz5J9w27TqPvRJqVEVtaDpBvDTuArQ6qnA==
X-Received: by 2002:a9d:5a8e:0:b0:6b9:b987:1337 with SMTP id
 w14-20020a9d5a8e000000b006b9b9871337mr33546oth.1.1694531469500; 
 Tue, 12 Sep 2023 08:11:09 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:676a:5a77:75a8:efc8])
 by smtp.gmail.com with ESMTPSA id
 g26-20020a9d6b1a000000b006b8e8884f2fsm4052101otp.51.2023.09.12.08.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 08:11:08 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Eduard Strehlau <eduard@lionizers.com>
Subject: [PATCH] imx7: Disable CAAM Job Ring 0
Date: Tue, 12 Sep 2023 12:11:00 -0300
Message-Id: <20230912151100.1735378-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Trying to boot a fitImage after a successful hab_auth_img operation
causes the following error:

 ## Loading kernel from FIT Image at 88000000 ...
   Using 'conf-imx7d-smegw01.dtb' configuration
   Trying 'kernel-1' kernel subimage
     Description:  Linux kernel
     Type:         Kernel Image
     Compression:  uncompressed
     Data Start:   0x8800010c
     Data Size:    9901752 Bytes = 9.4 MiB
     Architecture: ARM
     OS:           Linux
     Load Address: 0x80800000
     Entry Point:  0x80800000
     Hash algo:    sha256
     Hash value:   28f8779bbf010780f16dd3d84ecb9b604c44c5c2cf7acd098c264a2d3f68e969
   Verifying Hash Integrity ... sha256Error in SEC deq
   CAAM was not setup properly or it is faulty error!

The reason for this error is that the BootROM uses the CAAM Job Ring 0,
so disable its node in U-Boot to avoid the resource conflict.

imx8m dtsi files also have the Job Ring 0 disable since the following
kernel commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch?h=v6.5&id=dc9c1ceb555ff661e6fc1081434600771f29657c

For a temporary solution, disable the Job Ring 0 in imx7s-u-boot.dtsi.

Reported-by: Eduard Strehlau <eduard@lionizers.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi | 2 ++
 arch/arm/dts/imx7d-pico-pi-u-boot.dtsi         | 2 ++
 arch/arm/dts/imx7d-sdb-qspi-u-boot.dtsi        | 2 ++
 arch/arm/dts/imx7d-sdb-u-boot.dtsi             | 2 ++
 arch/arm/dts/imx7d-smegw01-u-boot.dtsi         | 3 +++
 arch/arm/dts/imx7s-u-boot.dtsi                 | 7 +++++++
 6 files changed, 18 insertions(+)
 create mode 100644 arch/arm/dts/imx7d-smegw01-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx7s-u-boot.dtsi

diff --git a/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi b/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi
index 52aa8758701f..57ca28edb70d 100644
--- a/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi
+++ b/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi
@@ -3,6 +3,8 @@
  * Copyright 2020-2022 Toradex
  */
 
+#include "imx7s-u-boot.dtsi"
+
 &{/aliases} {
 	/* SDHCI instance order: eMMC, SD/MMC */
 	mmc0 = &usdhc3;
diff --git a/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi b/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi
index 67b41ae1129c..843b4583e53a 100644
--- a/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi
+++ b/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi
@@ -1,3 +1,5 @@
+#include "imx7s-u-boot.dtsi"
+
 /{
     aliases {
         mmc0 = &usdhc3;
diff --git a/arch/arm/dts/imx7d-sdb-qspi-u-boot.dtsi b/arch/arm/dts/imx7d-sdb-qspi-u-boot.dtsi
index 62cdcbaeb67d..896c8bcaa5ad 100644
--- a/arch/arm/dts/imx7d-sdb-qspi-u-boot.dtsi
+++ b/arch/arm/dts/imx7d-sdb-qspi-u-boot.dtsi
@@ -3,6 +3,8 @@
  * Copyright 2018 NXP
  */
 
+#include "imx7s-u-boot.dtsi"
+
 &qspi {
 	flash0: mx25l51245g@0 {
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/imx7d-sdb-u-boot.dtsi b/arch/arm/dts/imx7d-sdb-u-boot.dtsi
index ac1d6e2e6480..e4a27b8dd5aa 100644
--- a/arch/arm/dts/imx7d-sdb-u-boot.dtsi
+++ b/arch/arm/dts/imx7d-sdb-u-boot.dtsi
@@ -1,3 +1,5 @@
+#include "imx7s-u-boot.dtsi"
+
 &fec2 {
 	status = "disable";
 };
diff --git a/arch/arm/dts/imx7d-smegw01-u-boot.dtsi b/arch/arm/dts/imx7d-smegw01-u-boot.dtsi
new file mode 100644
index 000000000000..90f7500ee34c
--- /dev/null
+++ b/arch/arm/dts/imx7d-smegw01-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "imx7s-u-boot.dtsi"
diff --git a/arch/arm/dts/imx7s-u-boot.dtsi b/arch/arm/dts/imx7s-u-boot.dtsi
new file mode 100644
index 000000000000..c4c1da3c64f1
--- /dev/null
+++ b/arch/arm/dts/imx7s-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+
+&crypto {
+	sec_jr0: jr@1000 {
+		status = "disabled";
+	};
+};
-- 
2.34.1

