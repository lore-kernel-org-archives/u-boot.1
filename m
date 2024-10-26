Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BB2D0C604
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 16:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78505890A9;
	Sat, 26 Oct 2024 18:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JnOWiaoj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D2F88F70; Sat, 26 Oct 2024 17:52:57 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E8BD88F68
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 17:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c940512711so557267a12.1
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729957968; x=1730562768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQrShvwriuQDKFqJj6OrnTtsRLZPoG0QXMzucOz7mmk=;
 b=JnOWiaoj4lSGOmU9dHOHjLFiV3GDC7AKODlokqfvz7bSxAKSaziaCOme3G+hQ9RwFZ
 xcI8QRNyzKJNUFwuslKQXPkRDc9Hh4G5dTlQegcl0i0U23JBc3lno3ijHGbvuBOsWhRL
 0Blu//onAoVkLgGE1MZQXbOFD98cS7Tzii/XY10gN5M0L9AAY3NCO3sZAnV29rZ9bZtn
 A8Z1JOkPmQiHaBo3OXd9WLmJr5kniwkcM0Ap6fSDbHS+pjwvsGS5HY1D9uvR7k+EB8cr
 izpo0Q92iIx+TBKE0R0dhJm7UzqZfkU82Fj8E0QaSrUgFEgNR3W+TJNaA1blDc4pJ7pZ
 qj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729957968; x=1730562768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HQrShvwriuQDKFqJj6OrnTtsRLZPoG0QXMzucOz7mmk=;
 b=IzywWJgxYEL16/BSklTkBt4TPtikrilmPAl1L6uMxbA5faaWcz/gpf9SxAGzolKaYq
 C7Dd9cbtenHGyvoAs+4R88lriSRb8Bkvyt9SqvG5yCP0RLn9hVB1B46BtckzOJczgFe8
 5fv1RqN6mJVU4clDNrnh+Ly+IGjCn2qHdyyjBrn6j4E+du8pL+mzvkxlWpVQD8G51cDZ
 /ZnNi9qn2oUi02iSEMvXH8aRVBEgsGMMUFQFK20CQVs8+Du5a3n2jv9cGzYaAY/EbwWp
 UNpyNe6r8YTBbc29XZmcTA90ss4LAIZjLN0RRw3oNwiDgU2C4sgmDPIveCUe3kVegye0
 nhIA==
X-Gm-Message-State: AOJu0YxWOdl+/frz5+NWrSx7MsbZ892iLCjMVnf4TVKXEtx+LADpsMnL
 nasGB/Xcr92qrObxBxhDIGrJdVdfgmFCCb/BI4MIJi0qTvRWahZ+rOYanw==
X-Google-Smtp-Source: AGHT+IFhYOOSbkcYhNuQRyyTGRzBElKBqdFrFIGnA3kRWJ2sAy6U4kNo1F+fOVbACFoBa5gqU9JGHw==
X-Received: by 2002:a05:6402:2682:b0:5cb:67a8:cf0a with SMTP id
 4fb4d7f45d1cf-5cbbf87519cmr971868a12.2.1729957967597; 
 Sat, 26 Oct 2024 08:52:47 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb63197casm1620179a12.63.2024.10.26.08.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 08:52:46 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 10/11] ARM: socfpga: apply binman approach to fpga parts
Date: Sat, 26 Oct 2024 15:52:19 +0000
Message-Id: <20241026155220.26300-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241026155220.26300-1-l.rubusch@gmail.com>
References: <20241026155220.26300-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 26 Oct 2024 18:16:43 +0200
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

Convert the .its based approach to binman instruction covered in the
device tree generation. This reduces additional instructions and
integrates the former separate build step into building the u-boot.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 ..._arria10_enclustra_mercury_aa1-u-boot.dtsi | 44 +++++++++++++++++++
 arch/arm/mach-socfpga/Kconfig                 |  1 +
 board/enclustra/mercury_aa1/fpga.its          | 32 --------------
 doc/board/enclustra/mercury-aa1.rst           |  3 ++
 4 files changed, 48 insertions(+), 32 deletions(-)
 delete mode 100644 board/enclustra/mercury_aa1/fpga.its

diff --git a/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
index 6e38286572..9587d2dddb 100644
--- a/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
@@ -18,6 +18,10 @@
 		compatible = "u-boot,fs-loader";
 		phandlepart = <&mmc 1>;
 	};
+
+	binman: binman {
+		multiple-images;
+	};
 };
 
 &fpga_mgr {
@@ -43,3 +47,43 @@
 };
 
 #endif
+
+&binman {
+	u-boot {
+		filename = "fpga.itb";
+
+		fit {
+			description = "FIT image with FPGA bistream";
+			fit,external-offset = <0>;
+			#address-cells = <1>;
+
+			images {
+				fpga-periph-1 {
+					description = "FPGA peripheral bitstream";
+					type = "fpga";
+					compression = "none";
+					blob-ext {
+						filename = "bitstream.periph.rbf";
+					};
+				};
+
+				fpga-core-1 {
+					description = "FPGA core bitstream";
+					type = "fpga";
+					compression = "none";
+					blob-ext {
+						filename = "bitstream.core.rbf";
+					};
+				};
+			};
+
+			configurations {
+				default = "config-1";
+				config-1 {
+					description = "Boot with FPGA early IO release config";
+					fpga = "fpga-periph-1", "fpga-core-1";
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 60d8c889dc..e7236a56f7 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -186,6 +186,7 @@ config TARGET_SOCFPGA_EBV_SOCRATES
 
 config TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1
 	bool "Enclustra Mercury+ AA1"
+	select BINMAN
 	select TARGET_SOCFPGA_ARRIA10
 
 config TARGET_SOCFPGA_IS1
diff --git a/board/enclustra/mercury_aa1/fpga.its b/board/enclustra/mercury_aa1/fpga.its
deleted file mode 100644
index cb42d61fbd..0000000000
--- a/board/enclustra/mercury_aa1/fpga.its
+++ /dev/null
@@ -1,32 +0,0 @@
-/dts-v1/;
-
-/ {
-	description = "FIT image with FPGA bistream";
-	#address-cells = <1>;
-
-	images {
-		fpga-periph-1 {
-			description = "FPGA peripheral bitstream";
-			data = /incbin/("../../../bitstream.periph.rbf");
-			type = "fpga";
-			arch = "arm";
-			compression = "none";
-		};
-
-		fpga-core-1 {
-			description = "FPGA core bitstream";
-			data = /incbin/("../../../bitstream.core.rbf");
-			type = "fpga";
-			arch = "arm";
-			compression = "none";
-		};
-	};
-
-	configurations {
-		default = "config-1";
-		config-1 {
-			description = "Boot with FPGA early IO release config";
-			fpga = "fpga-periph-1", "fpga-core-1";
-		};
-	};
-};
diff --git a/doc/board/enclustra/mercury-aa1.rst b/doc/board/enclustra/mercury-aa1.rst
index cba36aae2e..f3c629d42e 100644
--- a/doc/board/enclustra/mercury-aa1.rst
+++ b/doc/board/enclustra/mercury-aa1.rst
@@ -66,6 +66,9 @@ Build u-boot. Source your favorite toolchain for ARM first.
     $ make socfpga_enclustra_mercury_aa1_defconfig
     $ make -j8
 
+Note: Call ``make`` with ``NO_PYTHON=1`` where python tools unnecessarily falls
+back into additional python setup.
+
 Setup and compile a boot script as needed. Depending on the boot-mode select
 ``sd-aa1.cmd`` for SD/eMMC, or ``qspi-aa1.cmd`` for QSPI flash.
 
-- 
2.25.1

