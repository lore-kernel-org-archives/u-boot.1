Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F37CD6C2BA
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8423E89630;
	Wed, 20 Nov 2024 01:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Iwa5Mid7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C50BB88DB2; Tue, 19 Nov 2024 23:47:08 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75CA088ED9
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4315549c4d5so6896095e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732056423; x=1732661223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y9WbDmSMKJwyeH+scxHCKNE1pRYeLjJXP8smDB3meqE=;
 b=Iwa5Mid7RK/C6wLJPUc5gJUeErAEBYnVJMvk/4SSTW95GeUG1py2Ld/6F5buE/Di3A
 r0zu1HJnD1eCI93soRpmDX9vw8h3Kj9j3YkU2cGMMrrZ/Ttg2TsFOgjnSEdxFGbAF5EW
 KESPhSFN5OuNFc30Ut2OM26w/t4NWB+X2gAvdtvtzv3QTLZfqftc4faSoH6mdrhZ6naN
 +8VxUb7ki3J/pSLxaxTRn6/U7gRK/jf1jhjhJsVdQuG9m8gGQEtbcje8/Pay3tRDdfpA
 OmQCep2YKbPZnhDttnVUPpUplXj/ho+1zHXR0mICRVfdKpPFWXDzYE4XT16WUf0xQKmh
 NMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732056423; x=1732661223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y9WbDmSMKJwyeH+scxHCKNE1pRYeLjJXP8smDB3meqE=;
 b=CpHUnA1i1lQUDnwkXUddZ7tj7dwSTh/9sVuhzKeEVZqqponR4q26Gk1ukdMpKnf8Mu
 LR/NJUjPUK4VS20OY1lFDh3n9qVoQvK/suwu0SKkd/fDlvbn7YgnisVwQxRR3JBCTwqu
 jHr56t3BhGVUsuhpj/WyzEM+FUhzJPJj/uP9MvTMtfHW4VAlq4KN9s3Hq/8GQKo460Js
 bMNqbqUm/5txoZUGugq9Crjq/tYGGRE7yYiEnVR3mD6yJYGV5VP/H4XyUajvHbyvxrhc
 BU3bo2OQNYWTzC82ZRx8Tx5cceSglSMH8v+abq3qQ0d+1J9hLAdSnPCUBnUOdFEpckJf
 fU9A==
X-Gm-Message-State: AOJu0YxUqxpQcp6RgHW8GlaLFVoZjJCkRgIU6jljnM96guTRlDt/nqAM
 UnZ+22x5LvsLRGd4C7aavXiGlLitDUskLC/m0X7UCwtmVDkb9fxxmJPCJdlb
X-Gm-Gg: ASbGnct31E4Fr9ChcYq3wK2darQyyTxPHt6oAuPQLqHHX8SPON55/KXWNjcCkfJJIVb
 1SBxGPocM6t8CQc26aL6JnGvCG1h9uB+9VAsYJuPhu08UOkZ/9+OyPLuhlgfKrodbABJwwetnJ9
 xKPghNQ5RiJbWZgYUVkWRazzrYqovOVLKTYVQDROcXIcatNIQribiz7P4/sulfHTwoucO/rmGbs
 3CR6A5Fojli3j1KWCFfGupmXHJW8u+JFQqzRI/ojOTiUY3DZ0/a9O5UW8HCotE0zAjuRRXkSPIc
 4/i78G16v/ROgsus7+VhGcC1W/eZ
X-Google-Smtp-Source: AGHT+IFtRWw2UmYjTQAGazmfpYD5udpe36E11TUvUTbDtL0Mpouw7uLk+aVh2L4O98LgsLvqxLSMnQ==
X-Received: by 2002:a05:600c:1391:b0:42c:df54:18f6 with SMTP id
 5b1f17b1804b1-4334899cbb6mr2097735e9.3.1732056422846; 
 Tue, 19 Nov 2024 14:47:02 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da27fc8esm216979795e9.21.2024.11.19.14.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:47:01 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 v5 10/10] ARM: socfpga: apply binman approach to fpga parts
Date: Tue, 19 Nov 2024 22:46:43 +0000
Message-Id: <20241119224643.27692-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241119224643.27692-1-l.rubusch@gmail.com>
References: <20241119224643.27692-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Nov 2024 01:27:55 +0100
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
2.39.2

