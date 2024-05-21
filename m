Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238A4C25B7A
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 13:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7F4488777;
	Tue, 21 May 2024 15:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KKR/CT3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91D598874F; Tue, 21 May 2024 13:16:31 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 882A8880AE
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 13:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andrea.calabrese@amarulasolutions.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-572af0b12b8so8264872a12.2
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 04:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1716290184; x=1716894984;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sj1sd0SFiSOcHn8zQdr6C7SRLpaNwPQw93Rk7na9lJM=;
 b=KKR/CT3HkYEdEPqcdAibVkov52J51LmEWvhgxgr+EEQ9ZAYWCGTc0f6BLUjBhahVdN
 nU4D3QxBnR5OTy89WTT2GWJwXVil/Xm84/2mA+YAwaP1HrqJd9o5URbAbld79SXEQjKF
 rOWx/KK2jpP4dNyHa+h8medRJT4SkC36rU7QA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716290184; x=1716894984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sj1sd0SFiSOcHn8zQdr6C7SRLpaNwPQw93Rk7na9lJM=;
 b=r3SjEbFlIw3oBBJRTJ+/vAIE1vjJrzFBc/RjfMFBsnbHVH8WMK8JW50BN4vDitnzTn
 ue4XoblIrVGPc/ULHf4jTcqV4Nfghty5vdRISMTVZ3GAQfbyaWjcSmPajM/E9q2SdKvL
 j33PuxnIcpYrj0WzRlq7vnoxTLc1ftchG/jrkjF80p1CkRM/OvIJObQW/j560wKYEOsy
 gqnh6XZUBhgG8f9RdLtvipoCpBMhKyQYeVxidp5hpvBbcgOBsZPmmkEEUW6Q6FZlDHu1
 irLDu9aTTbvJfyBJvZZfvPkEZC1fOA008yZ14w94SoP8dPjtQ8WQHzpSBxJRyA89oOv5
 OYIA==
X-Gm-Message-State: AOJu0YwZugmi6nZAnJ1WHLl50sjYpzjBCYZVomjNONJh4vu4EfLKf/f6
 pJtNBXh5GUnmrNhQqrNRmMN5yyu5URDFlbXl2KpBSQoPPTyQfogEk+uQduvidJ/Fs7lZRB8h9zV
 CeDhiDA==
X-Google-Smtp-Source: AGHT+IFAlY/U0xmhJXmVckwZi2NSbaaR/Vc2UdAmPkWAIbh/48dGqLmLtlnh2IKEGMActkGrWKVfGw==
X-Received: by 2002:a50:d653:0:b0:572:7d75:a715 with SMTP id
 4fb4d7f45d1cf-5734d6b4120mr20883839a12.28.1716290182652; 
 Tue, 21 May 2024 04:16:22 -0700 (PDT)
Received: from andrea-amarula.amarulasolutions.com ([85.148.28.6])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-574eb5ec296sm9294667a12.35.2024.05.21.04.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 04:16:21 -0700 (PDT)
From: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: flavia.caforio@amarulasolutions.com, michael@amarulasolutions.com,
 andrea.calabrese@amarulasolutions.com, linux-amarula@amarulasolutions.com
Subject: [PATCH] Add support for am623 from BSH
Date: Tue, 21 May 2024 13:15:47 +0200
Message-Id: <20240521111547.106139-1-andrea.calabrese@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 May 2024 15:05:46 +0200
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

Added support for ARM chipsets r5 and a53, part of the am623 board.
Created the dtsi files, updated the kconfig and makefile and added the
dts files.

AM623-M3 is a low-cost board based on K3 AM623 SoC.
It supports the following interfaces:
- 256 MB LPDDR3 RAM
- x1 USB OTG Connector
- CC330x SimpleLink™ Wi-Fi 6 and Bluetooth® Low Energy companion IC
- 512 Mbit OSPI flash
- x1 UART through UART-USB bridge
- x1 eMMC 4GB

Add basic support for AM623-M3.

Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
Signed-off-by: Flavia Caforio <flavia.caforio@amarulasolutions.com>

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index a5c82ebf7a..a281ae9812 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1213,13 +1213,16 @@ dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-r5-evm.dtb \
 			      k3-am642-r5-sk.dtb \
 			      k3-am642-r5-phycore-som-2gb.dtb
 
-dtb-$(CONFIG_SOC_K3_AM625) += k3-am625-sk.dtb \
+dtb-$(CONFIG_SOC_K3_AM625) += k3-am62-ccm-m3.dtb \
+			      k3-am62-r5-ccm-m3.dtb \
+			      k3-am625-sk.dtb \
 			      k3-am625-r5-sk.dtb \
 			      k3-am625-beagleplay.dtb \
 			      k3-am625-r5-beagleplay.dtb \
 			      k3-am625-verdin-r5.dtb \
 			      k3-am625-r5-phycore-som-2gb.dtb
 
+
 dtb-$(CONFIG_SOC_K3_AM62A7) += k3-am62a7-sk.dtb \
 			      k3-am62a7-r5-sk.dtb
 
diff --git a/arch/arm/dts/k3-am62-ccm-m3-binman.dtsi b/arch/arm/dts/k3-am62-ccm-m3-binman.dtsi
new file mode 100644
index 0000000000..a54eb20bc3
--- /dev/null
+++ b/arch/arm/dts/k3-am62-ccm-m3-binman.dtsi
@@ -0,0 +1,456 @@
+//# SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 Amarula Solutions B.V.
+ */
+#include "k3-binman.dtsi"
+
+#ifdef CONFIG_TARGET_AM625_R5_BSH_CCM_M3
+
+&binman {
+	tiboot3-am62x-hs-evm.bin {
+		filename = "tiboot3-am62x-hs-evm.bin";
+		ti-secure-rom {
+			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
+				<&combined_dm_cfg>, <&sysfw_inner_cert>;
+			combined;
+			dm-data;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&u_boot_spl>;
+			content-sysfw = <&ti_fs_enc>;
+			content-sysfw-data = <&combined_tifs_cfg>;
+			content-sysfw-inner-cert = <&sysfw_inner_cert>;
+			content-dm-data = <&combined_dm_cfg>;
+			load = <0x43c00000>;
+			load-sysfw = <0x40000>;
+			load-sysfw-data = <0x67000>;
+			load-dm-data = <0x43c3a800>;
+		};
+		u_boot_spl: u-boot-spl {
+			no-expanded;
+		};
+		ti_fs_enc: ti-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+		combined_tifs_cfg: combined-tifs-cfg.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+		sysfw_inner_cert: sysfw-inner-cert {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		combined_dm_cfg: combined-dm-cfg.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+};
+
+&binman {
+	tiboot3-am62x-hs-fs-evm.bin {
+		filename = "tiboot3-am62x-hs-fs-evm.bin";
+		symlink = "tiboot3.bin";
+		ti-secure-rom {
+			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
+				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
+			combined;
+			dm-data;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&u_boot_spl_fs>;
+			content-sysfw = <&ti_fs_enc_fs>;
+			content-sysfw-data = <&combined_tifs_cfg_fs>;
+			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
+			content-dm-data = <&combined_dm_cfg_fs>;
+			load = <0x43c00000>;
+			load-sysfw = <0x40000>;
+			load-sysfw-data = <0x67000>;
+			load-dm-data = <0x43c3a800>;
+		};
+		u_boot_spl_fs: u-boot-spl {
+			no-expanded;
+		};
+		ti_fs_enc_fs: ti-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+		sysfw_inner_cert_fs: sysfw-inner-cert {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		combined_dm_cfg_fs: combined-dm-cfg.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+};
+
+&binman {
+	tiboot3-am62x-gp-evm.bin {
+		filename = "tiboot3-am62x-gp-evm.bin";
+		ti-secure-rom {
+			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
+				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
+			combined;
+			dm-data;
+			content-sbl = <&u_boot_spl_unsigned>;
+			load = <0x43c00000>;
+			content-sysfw = <&ti_fs_gp>;
+			load-sysfw = <0x40000>;
+			content-sysfw-data = <&combined_tifs_cfg_gp>;
+			load-sysfw-data = <0x67000>;
+			content-dm-data = <&combined_dm_cfg_gp>;
+			load-dm-data = <0x43c3a800>;
+			sw-rev = <1>;
+			keyfile = "ti-degenerate-key.pem";
+		};
+		u_boot_spl_unsigned: u-boot-spl {
+			no-expanded;
+		};
+		ti_fs_gp: ti-fs-gp.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
+			type = "blob-ext";
+			optional;
+		};
+		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+
+	};
+};
+
+#endif
+
+#ifdef CONFIG_TARGET_AM625_A53_BSH_CCM_M3
+
+#define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
+#define SPL_AM625_CCM_M3_DTB "spl/dts/k3-am62-ccm-m3.dtb"
+#define AM625_CCM_M3_DTB "u-boot.dtb"
+
+&binman {
+	ti-dm {
+		filename = "ti-dm.bin";
+		blob-ext {
+			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+		};
+	};
+
+	fsstub-hs {
+		filename = "fsstub.bin_hs";
+		ti-secure-rom {
+			content = <&fsstub_hs_cert>;
+			core = "secure";
+			load = <0x40000>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "custMpk.pem";
+			countersign;
+			fsstub;
+		};
+		fsstub_hs_cert: fsstub-hs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		fsstub_hs_enc: fsstub-hs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+	fsstub-fs {
+		filename = "fsstub.bin_fs";
+		fsstub_fs_cert: fsstub-fs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		fsstub_fs_enc: fsstub-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+	fsstub-gp {
+		filename = "fsstub.bin_gp";
+		ti-secure-rom {
+			content = <&fsstub_gp>;
+			core = "secure";
+			load = <0x60000>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "ti-degenerate-key.pem";
+			fsstub;
+		};
+		fsstub_gp: fsstub-gp.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+
+
+	ti-spl {
+		insert-template = <&ti_spl_template>;
+
+		fit {
+			images {
+
+				dm {
+					ti-secure {
+						content = <&dm>;
+						keyfile = "custMpk.pem";
+					};
+					dm: ti-dm {
+						filename = "ti-dm.bin";
+					};
+				};
+
+				fsstub-hs {
+					description = "FSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "fsstub-hs";
+					load = <0x87800000>;
+					entry = <0x87800000>;
+					blob-ext {
+						filename = "fsstub.bin_hs";
+					};
+				};
+
+				fsstub-fs {
+					description = "FSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "fsstub-fs";
+					load = <0x87800000>;
+					entry = <0x87800000>;
+					blob-ext {
+						filename = "fsstub.bin_fs";
+					};
+				};
+
+				fsstub-gp {
+					description = "FSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "fsstub-gp";
+					load = <0x87800000>;
+					entry = <0x87800000>;
+					blob-ext {
+						filename = "fsstub.bin_gp";
+					};
+				};
+
+				fdt-0 {
+					description = "k3-am62_ccm_m3";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&spl_am625_ccm_m3_dtb>;
+						keyfile = "custMpk.pem";
+					};
+					spl_am625_ccm_m3_dtb: blob-ext {
+						filename = SPL_AM625_CCM_M3_DTB;
+					};
+
+				};
+
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-am62_ccm_m3";
+					firmware = "atf";
+					loadables = "fsstub-hs", "fsstub-fs", "fsstub-gp", "dm", "spl";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
+};
+
+&binman {
+	u-boot {
+		insert-template = <&u_boot_template>;
+
+		fit {
+			images {
+				uboot {
+					description = "U-Boot for AM625 CCM board";
+				};
+
+				fdt-0 {
+					description = "k3-am62_ccm_m3";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&am625_ccm_m3_dtb>;
+						keyfile = "custMpk.pem";
+					};
+					am625_ccm_m3_dtb: blob-ext {
+						filename = AM625_CCM_M3_DTB;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-am62_ccm_m3";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-0";
+				};
+
+			};
+		};
+	};
+};
+
+&binman {
+	ti-spl_unsigned {
+		insert-template = <&ti_spl_unsigned_template>;
+
+		fit {
+			images {
+
+				dm {
+					ti-dm {
+						filename = "ti-dm.bin";
+					};
+				};
+
+				fsstub-hs {
+					description = "FSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "fsstub-hs";
+					load = <0x87800000>;
+					entry = <0x87800000>;
+					blob-ext {
+						filename = "fsstub.bin_hs";
+					};
+				};
+
+				fsstub-fs {
+					description = "FSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "fsstub-fs";
+					load = <0x87800000>;
+					entry = <0x87800000>;
+					blob-ext {
+						filename = "fsstub.bin_fs";
+					};
+				};
+
+				fsstub-gp {
+					description = "FSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "fsstub-gp";
+					load = <0x87800000>;
+					entry = <0x87800000>;
+					blob-ext {
+						filename = "fsstub.bin_gp";
+					};
+				};
+
+				fdt-0 {
+					description = "k3-am62_ccm_m3";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					spl_am625_ccm_m3_dtb_unsigned: blob {
+						filename = SPL_AM625_CCM_M3_DTB;
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-am62_ccm_m3";
+					firmware = "atf";
+					loadables = "fsstub-hs", "fsstub-fs",
+						    "fsstub-gp", "dm", "spl";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
+};
+
+&binman {
+	u-boot_unsigned {
+		insert-template = <&u_boot_unsigned_template>;
+
+		fit {
+			images {
+				uboot {
+					description = "U-Boot for AM625 board";
+				};
+
+				fdt-0 {
+					description = "k3-am62_ccm_m3";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					am625_ccm_m3_dtb_unsigned: blob {
+						filename = AM625_CCM_M3_DTB;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-am62_ccm_m3";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
+};
+
+#endif
diff --git a/arch/arm/dts/k3-am62-ccm-m3-ddr.dtsi b/arch/arm/dts/k3-am62-ccm-m3-ddr.dtsi
new file mode 100644
index 0000000000..6a39a7df17
--- /dev/null
+++ b/arch/arm/dts/k3-am62-ccm-m3-ddr.dtsi
@@ -0,0 +1,11 @@
+//# SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 Amarula Solutions B.V.
+ */
+
+#include "k3-am64-ddr.dtsi"
+&memorycontroller {
+	power-domains = <&k3_pds 170 TI_SCI_PD_SHARED>,
+			<&k3_pds 55 TI_SCI_PD_SHARED>;
+	clocks = <&k3_clks 170 0>, <&k3_clks 16 4>;
+};
diff --git a/arch/arm/dts/k3-am62-ccm-m3-u-boot.dtsi b/arch/arm/dts/k3-am62-ccm-m3-u-boot.dtsi
new file mode 100644
index 0000000000..303c562f33
--- /dev/null
+++ b/arch/arm/dts/k3-am62-ccm-m3-u-boot.dtsi
@@ -0,0 +1,93 @@
+//# SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 Amarula Solutions B.V.
+ */
+
+#include "k3-am62-ccm-m3-binman.dtsi"
+#include "k3-am62x-ccm-m3-common-u-boot.dtsi"
+
+&ospi0_pins_default {
+	bootph-all;
+};
+
+&ospi0 {
+	bootph-all;
+
+	flash@0 {
+		bootph-all;
+
+		partitions {
+			bootph-all;
+
+			partition@3fc0000 {
+				bootph-all;
+			};
+		};
+	};
+};
+
+&main_i2c0 {
+	bootph-all;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	tps65219: pmic@30 {
+		compatible = "ti,tps65219";
+		reg = <0x30>;
+
+		regulators {
+			buck1_reg: buck1 {
+				regulator-name = "VDD_CORE";            /* VDDSOC */
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck2_reg: buck2 {
+				regulator-name = "VCC1V8";             /* VDD_1V8 */
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck3_reg: buck3 {
+				regulator-name = "VDD_LPDDR4";        /* VDD_DRAM */
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1_reg: ldo1 {
+				regulator-name = "LDO1_NOT_USED";
+				regulator-min-microvolt = <00000000>;
+				regulator-max-microvolt = <00000000>;
+			};
+
+			ldo2_reg: ldo2 {
+				regulator-name = "VDDAR_CORE";        /* VPP_1V8 */
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3_reg: ldo3 {
+				regulator-name = "VDDA_1V8";          /* VDDA_1V8 */
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4_reg: ldo4 {
+				regulator-name = "LDO4_NOT_USED";
+				regulator-min-microvolt = <00000000>;
+				regulator-max-microvolt = <00000000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-am62-ccm-m3.dts b/arch/arm/dts/k3-am62-ccm-m3.dts
new file mode 100644
index 0000000000..475a1b5f4a
--- /dev/null
+++ b/arch/arm/dts/k3-am62-ccm-m3.dts
@@ -0,0 +1,76 @@
+//# SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 Amarula Solutions B.V.
+ */
+
+/dts-v1/;
+
+#include "k3-am62x-ccm-m3-common.dtsi"
+
+/ {
+	compatible =  "ti,am625-sk", "ti,am625";
+	model = "BSH - CCM-M3";
+};
+
+/* CCM-M3 uses NAND QSPI 4-wire */
+&ospi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&ospi0_pins_default>;
+
+	flash@0{
+		compatible = "spi-nand";
+		reg = <0x0>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <2>;
+		cdns,phy-mode;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi_nand.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "ospi_nand.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "ospi_nand.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@600000 {
+				label = "ospi_nand.env";
+				reg = <0x600000 0x40000>;
+			};
+
+			partition@640000 {
+				label = "ospi_nand.env.backup";
+				reg = <0x640000 0x40000>;
+			};
+
+			partition@2000000 {
+				label = "ospi_nand.rootfs";
+				reg = <0x2000000 0xd9c0000>;
+			};
+
+			partition@f9c0000 {
+				label = "ospi_nand.phypattern";
+				reg = <0xf9c0000 0x40000>;
+			};
+			/* End of 256MB */
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-am62-r5-ccm-m3.dts b/arch/arm/dts/k3-am62-r5-ccm-m3.dts
new file mode 100644
index 0000000000..a757423545
--- /dev/null
+++ b/arch/arm/dts/k3-am62-r5-ccm-m3.dts
@@ -0,0 +1,84 @@
+//# SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 Amarula Solutions B.V.
+ */
+
+#include "k3-am62-ccm-m3.dts"
+
+#include "k3-am62x-ccm-m3-ddr-config.dtsi"
+#include "k3-am62-ccm-m3-ddr.dtsi"
+#include "k3-am62-ccm-m3-u-boot.dtsi"
+
+/ {
+	aliases {
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a53_0;
+		serial0 = &wkup_uart0;
+		serial3 = &main_uart1;
+	};
+
+	a53_0: a53@0 {
+		compatible = "ti,am654-rproc";
+		reg = <0x00 0x00a90000 0x00 0x10>;
+		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 135 0>;
+		clocks = <&k3_clks 61 0>;
+		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		assigned-clock-parents = <&k3_clks 61 2>;
+		assigned-clock-rates = <200000000>, <1200000000>;
+		ti,sci = <&dmsc>;
+		ti,sci-proc-id = <32>;
+		ti,sci-host-id = <10>;
+		bootph-pre-ram;
+	};
+
+	dm_tifs: dm-tifs {
+		compatible = "ti,j721e-dm-sci";
+		ti,host-id = <36>;
+		ti,secure-host;
+		mbox-names = "rx", "tx";
+		mboxes= <&secure_proxy_main 22>,
+			<&secure_proxy_main 23>;
+		bootph-pre-ram;
+	};
+};
+
+&dmsc {
+	mboxes= <&secure_proxy_main 0>,
+		<&secure_proxy_main 1>,
+		<&secure_proxy_main 0>;
+	mbox-names = "rx", "tx", "notify";
+	ti,host-id = <35>;
+	ti,secure-host;
+};
+
+&secure_proxy_sa3 {
+	/* We require this for boot handshake */
+	status = "okay";
+};
+
+&cbass_main {
+	sysctrler: sysctrler {
+		compatible = "ti,am654-system-controller";
+		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
+		mbox-names = "tx", "rx", "boot_notify";
+		bootph-pre-ram;
+	};
+};
+
+/* WKUP UART0 is used for DM firmware logs */
+&wkup_uart0 {
+	status = "okay";
+};
+
+/* Main UART1 is used for TIFS firmware logs */
+&main_uart1 {
+	status = "okay";
+};
+
+&ospi0 {
+	reg = <0x00 0x0fc40000 0x00 0x100>,
+	      <0x00 0x60000000 0x00 0x08000000>;
+};
diff --git a/arch/arm/dts/k3-am62x-ccm-m3-common-u-boot.dtsi b/arch/arm/dts/k3-am62x-ccm-m3-common-u-boot.dtsi
new file mode 100644
index 0000000000..d4f17f0a60
--- /dev/null
+++ b/arch/arm/dts/k3-am62x-ccm-m3-common-u-boot.dtsi
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2024 Amarula Solutions B.V.
+ */
+
+#include "k3-am62-ccm-m3-binman.dtsi"
+
+/ {
+	chosen {
+		stdout-path = "serial2:115200n8";
+		tick-timer = &timer1;
+	};
+
+	aliases {
+		mmc0 = &sdhci0;
+		mmc2 = &sdhci2;
+	};
+
+	memory@80000000 {
+		bootph-all;
+	};
+};
+
+&cbass_main{
+	bootph-all;
+
+	timer1: timer@2400000 {
+		clock-frequency = <25000000>;
+		bootph-all;
+	};
+};
+
+&dmss {
+	bootph-all;
+};
+
+&secure_proxy_main {
+	bootph-all;
+};
+
+&dmsc {
+	bootph-all;
+};
+
+&k3_pds {
+	bootph-all;
+};
+
+&k3_clks {
+	bootph-all;
+};
+
+&k3_reset {
+	bootph-all;
+};
+
+&wkup_conf {
+	bootph-all;
+};
+
+&chipid {
+	bootph-all;
+};
+
+&main_pmx0 {
+	bootph-all;
+};
+
+&main_uart0 {
+	bootph-all;
+};
+
+&main_uart0_pins_default {
+	bootph-all;
+};
+
+&cbass_mcu {
+	bootph-all;
+};
+
+&cbass_wakeup {
+	bootph-all;
+};
+
+&mcu_pmx0 {
+	bootph-all;
+};
+
+&wkup_uart0 {
+	bootph-all;
+};
+
+&main_i2c0 {
+	bootph-all;
+};
+
+&main_i2c0_pins_default {
+	bootph-all;
+};
+
+&sdhci0 {
+	bootph-all;
+};
+
+&usbss0 {
+	bootph-all;
+};
+
+&usb0 {
+	dr_mode = "peripheral";
+	/* Since role switching is not supported in U-Boot */
+	/delete-property/ extcon;
+	bootph-all;
+};
+
+&usbss1 {
+	bootph-all;
+};
+
+
+
+&main_bcdma {
+	bootph-all;
+	reg = <0x00 0x485c0100 0x00 0x100>,
+	      <0x00 0x4c000000 0x00 0x20000>,
+	      <0x00 0x4a820000 0x00 0x20000>,
+	      <0x00 0x4aa40000 0x00 0x20000>,
+	      <0x00 0x4bc00000 0x00 0x100000>,
+	      <0x00 0x48600000 0x00 0x8000>,
+	      <0x00 0x484a4000 0x00 0x2000>,
+	      <0x00 0x484c2000 0x00 0x2000>;
+	reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt",
+		    "ringrt" , "cfg", "tchan", "rchan";
+};
+
+&main_pktdma {
+	bootph-all;
+	reg = <0x00 0x485c0000 0x00 0x100>,
+	      <0x00 0x4a800000 0x00 0x20000>,
+	      <0x00 0x4aa00000 0x00 0x20000>,
+	      <0x00 0x4b800000 0x00 0x200000>,
+	      <0x00 0x485e0000 0x00 0x10000>,
+	      <0x00 0x484a0000 0x00 0x2000>,
+	      <0x00 0x484c0000 0x00 0x2000>,
+	      <0x00 0x48430000 0x00 0x1000>;
+	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
+		    "cfg", "tchan", "rchan", "rflow";
+};
+
+&fss {
+	bootph-all;
+};
+
+&ospi0_pins_default {
+	bootph-all;
+};
+
+&main_mmc0_pins_default {
+	bootph-all;
+};
+
+&dmsc {
+	bootph-all;
+	k3_sysreset: sysreset-controller {
+		compatible = "ti,sci-sysreset";
+		bootph-all;
+	};
+};
+
+&main_gpio0 {
+	bootph-all;
+};
+
+&main_i2c1 {
+	bootph-all;
+};
+
+&main_i2c1_pins_default {
+	bootph-all;
+};
diff --git a/arch/arm/dts/k3-am62x-ccm-m3-common.dtsi b/arch/arm/dts/k3-am62x-ccm-m3-common.dtsi
new file mode 100644
index 0000000000..ca8920bcd0
--- /dev/null
+++ b/arch/arm/dts/k3-am62x-ccm-m3-common.dtsi
@@ -0,0 +1,419 @@
+//# SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 Amarula Solutions B.V.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "k3-am625.dtsi"
+
+/ {
+	aliases {
+		serial2 = &main_uart0;
+		mmc0 = &sdhci0;
+		spi0 = &ospi0;
+		usb0 = &usb0;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 256M RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x10000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_tfa_ddr: tfa@8a500000 {
+			reg = <0x00 0x8a500000 0x00 0x80000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@87600000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x87600000 0x00 0x00100000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_memory_region: r5f-memory@87700000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x87700000 0x00 0x00c00000>;
+			no-map;
+		};
+	};
+
+	vcc_5v: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_3v3: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		/* This get supplied by pmic that is powered by the 5v */
+		vin-supply = <&vcc_5v>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	usdhc2_pwrseq: usdhc2-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+        pinctrl-names = "default";
+        pinctrl-0 = <&main_wifi_reset_pins_default>;
+        reset-gpios = <&main_gpio1 3 GPIO_ACTIVE_LOW>;
+		post-power-on-delay-ms = <10>;
+		power-off-delay-us = <100>;
+	};
+};
+
+&usb0 {
+        dr_mode = "peripheral";
+        pinctrl-names = "default";
+        pinctrl-0 = <&main_usb0_pins_default>;
+};
+
+
+&cpsw3g {
+	status = "disabled";
+};
+
+&dss {
+	status = "disabled";
+};
+
+&dss_ports {
+	status = "disabled";
+};
+
+&main_pmx0 {
+
+	main_uart0_pins_default: main-uart0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
+			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
+		>;
+	};
+
+	uartbt_pins_default: uartbt-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0224, PIN_INPUT, 3) /* (D22) MMC1_DAT3.UART2_RXD */
+			AM62X_IOPAD(0x0228, PIN_OUTPUT, 3) /* (C21) MMC1_DAT2.UART2_TXD */
+			AM62X_IOPAD(0x0230, PIN_INPUT, 3) /* (A22) MMC1_DAT0.UART2_CTSn */
+			AM62X_IOPAD(0x022c, PIN_OUTPUT, 3) /* (B21) MMC1_DAT1.UART2_RTSn */
+		>;
+	};
+
+	uartdbus_pins_default: uartdbus-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01ac, PIN_INPUT, 2) /* (E19) MCASP0_AFSR.UART1_RXD */
+			AM62X_IOPAD(0x01b0, PIN_OUTPUT, 2) /* (A20) MCASP0_ACLKR.UART1_TXD */
+		>;
+	};
+
+	/* Bluetooth */
+	main_uart2_pins_default: main-uart2-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0224, PIN_INPUT, 3) /* (D22) MMC1_DAT3.UART2_RXD */
+			AM62X_IOPAD(0x0228, PIN_OUTPUT, 3) /* (C21) MMC1_DAT2.UART2_TXD */
+			AM62X_IOPAD(0x0230, PIN_INPUT, 3) /* (A22) MMC1_DAT0.UART2_CTSn */
+			AM62X_IOPAD(0x022c, PIN_OUTPUT, 3) /* (B21) MMC1_DAT1.UART2_RTSn */
+		>;
+	};
+
+	/* D-Bus */
+	main_uart1_pins_default: main-uart1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01ac, PIN_INPUT, 2) /* (E19) MCASP0_AFSR.UART1_RXD */
+			AM62X_IOPAD(0x01b0, PIN_OUTPUT, 2) /* (A20) MCASP0_ACLKR.UART1_TXD */
+		>;
+	};
+
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1e0, PIN_INPUT_PULLUP, 0) /* (B16) I2C0_SCL */
+			AM62X_IOPAD(0x1e4, PIN_INPUT_PULLUP, 0) /* (A16) I2C0_SDA */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17) I2C1_SCL */
+			AM62X_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */
+		>;
+	};
+
+	main_i2c3_pins_default: main-i2c3-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01d0, PIN_INPUT, 2) /* (A15) UART0_CTSn.I2C3_SCL */
+			AM62X_IOPAD(0x01d4, PIN_INPUT, 2) /* (B15) UART0_RTSn.I2C3_SDA */
+		>;
+	};
+
+	main_mmc0_pins_default: main-mmc0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
+			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
+			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
+			AM62X_IOPAD(0x210, PIN_INPUT, 0) /* (AA1) MMC0_DAT1 */
+			AM62X_IOPAD(0x20c, PIN_INPUT, 0) /* (AA3) MMC0_DAT2 */
+			AM62X_IOPAD(0x208, PIN_INPUT, 0) /* (Y4) MMC0_DAT3 */
+			AM62X_IOPAD(0x204, PIN_INPUT, 0) /* (AB2) MMC0_DAT4 */
+			AM62X_IOPAD(0x200, PIN_INPUT, 0) /* (AC1) MMC0_DAT5 */
+			AM62X_IOPAD(0x1fc, PIN_INPUT, 0) /* (AD2) MMC0_DAT6 */
+			AM62X_IOPAD(0x1f8, PIN_INPUT, 0) /* (AC2) MMC0_DAT7 */
+		>;
+	};
+
+	main_mmc2_pins_default: main-mmc2-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x120, PIN_INPUT_PULLUP, 0) /* (C24)  MMC2_CMD */
+			AM62X_IOPAD(0x118, PIN_INPUT, 0)        /* (D25)  MMC2_CLK */
+			AM62X_IOPAD(0x114, PIN_INPUT_PULLUP, 0) /* (B24)  MMC2_DAT0 */
+			AM62X_IOPAD(0x110, PIN_INPUT_PULLUP, 0) /* (C25)  MMC2_DAT1 */
+			AM62X_IOPAD(0x10c, PIN_INPUT_PULLUP, 0) /* (E23)  MMC2_DAT2 */
+			AM62X_IOPAD(0x108, PIN_INPUT_PULLUP, 0) /* (D24)  MMC2_DAT3 */
+			AM62X_IOPAD(0x11c, PIN_INPUT, 0)        /* (#N/A) MMC2_CLKB */
+		>;
+	};
+
+	main_wifi_reset_pins_default: main-wifi-reset-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x184, PIN_OUTPUT, 7) /* (AE23) RGMII2_RD0.GPIO1_3 */
+		>;
+	};
+
+	main_wlirq_pins_default: main-wlirq-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x180, PIN_INPUT, 7) /* (AD23) RGMII2_RXC.GPIO1_2 */
+		>;
+	};
+
+	usr_led_pins_default: usr-led-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x244, PIN_OUTPUT, 2) /* (C17) MMC1_SDWP.TIMER_IO7 */
+		>;
+	};
+
+	ospi0_pins_default: qspi-nand-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0000, PIN_OUTPUT, 0) /* (H24) OSPI0_CLK */
+			AM62X_IOPAD(0x002c, PIN_OUTPUT, 0) /* (F23) OSPI0_CSn0 */
+			AM62X_IOPAD(0x000c, PIN_INPUT, 0) /* (E25) OSPI0_D0 */
+			AM62X_IOPAD(0x0010, PIN_INPUT, 0) /* (G24) OSPI0_D1 */
+			AM62X_IOPAD(0x0014, PIN_INPUT, 0) /* (F25) OSPI0_D2 */
+			AM62X_IOPAD(0x0018, PIN_INPUT, 0) /* (F24) OSPI0_D3 */
+		>;
+	};
+
+	pmic_irq_pins_default: pmic-irq-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01f4, PIN_INPUT, 0) /* (D16) EXTINTn */
+		>;
+	};
+
+	main_usb0_pins_default: main-usb0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0254, PIN_INPUT, 0) /* (C20) USB0_DRVVBUS */
+		>;
+	};
+};
+
+&wkup_uart0 {
+	/* WKUP UART0 is used by DM firmware */
+	status = "reserved";
+};
+
+&mcu_uart0 {
+	status = "disabled";
+};
+
+&main_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+};
+
+&main_uart1 {
+	status = "disabled";
+};
+
+&main_uart2 {
+	status = "disabled";
+};
+
+&main_uart3 {
+	status = "disabled";
+};
+
+&main_uart4 {
+	status = "disabled";
+};
+
+&main_uart5 {
+	status = "disabled";
+};
+
+&main_uart6 {
+	status = "disabled";
+};
+
+
+&mcu_i2c0 {
+	status = "disabled";
+};
+
+&wkup_i2c0 {
+	status = "disabled";
+};
+
+&main_i2c0 {
+	tps65219: pmic@30 {
+		compatible = "ti,tps65219";
+		reg = <0x30>;
+		buck1-supply = <&vcc_5v>;
+		buck2-supply = <&vcc_5v>;
+		buck3-supply = <&vcc_5v>;
+		ldo1-supply = <&vcc_5v>;
+		ldo2-supply = <&vcc_5v>;
+		ldo3-supply = <&vcc_5v>;
+		ldo4-supply = <&vcc_5v>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		/* ti,power-button; */
+
+		regulators {
+			buck1_reg: buck1 {
+				regulator-name = "VDD_CORE";            /* VDDSOC */
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck2_reg: buck2 {
+				regulator-name = "VCC1V8_SYS";          /* VDD_1V8 */
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck3_reg: buck3 {
+				regulator-name = "VDD_LPDDR4";          /* VDD_DRAM */
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2_reg: ldo2 {
+				regulator-name = "VDDAR_CORE";        /* VPP_1V8 */
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3_reg: ldo3 {
+				regulator-name = "VDDA_1V8";          /* VDDA_1V8 */
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&main_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	clock-frequency = <100000>;
+};
+
+
+&main_i2c2 {
+	status = "disabled";
+};
+
+&main_i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c3_pins_default>;
+	clock-frequency = <100000>;
+
+	st25dv04k: st25dv04k@53 {
+		compatible = "st25dv,st25dv04k";
+		reg = <0x53>;
+		status = "okay";
+	};
+};
+
+/* eMMC */
+&sdhci0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins_default>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
+
+/* Wi-Fi */
+&sdhci2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc2_pins_default>;
+	bus-width = <4>;
+	non-removable;
+	cap-power-off-card;
+	keep-power-in-suspend;
+	//vmmc-supply = <&wlan_en>;
+	mmc-pwrseq = <&usdhc2_pwrseq>;
+
+	ti,fails-without-test-cd;
+	ti,driver-strength-ohm = <50>;
+	assigned-clocks = <&k3_clks 157 158>;
+	assigned-clock-parents = <&k3_clks 157 160>;
+	max-frequency = <5000000>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore@2 {
+			compatible = "ti,cc33xx";
+			reg = <2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&main_wlirq_pins_default>;
+			interrupt-parent = <&main_gpio1>;
+			interrupts = <2 IRQ_TYPE_EDGE_RISING>;
+			irq-gpio = <&main_gpio1 2 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&usbss0 {
+	status = "okay";
+	ti,vbus-divider;
+};
+
+&mailbox0_cluster0 {
+	mbox_m4_0: mbox-m4-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
diff --git a/arch/arm/dts/k3-am62x-ccm-m3-ddr-config.dtsi b/arch/arm/dts/k3-am62x-ccm-m3-ddr-config.dtsi
new file mode 100644
index 0000000000..4dbac6af35
--- /dev/null
+++ b/arch/arm/dts/k3-am62x-ccm-m3-ddr-config.dtsi
@@ -0,0 +1,2191 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This file was generated with the
+ * AM62x SysConfig DDR Subsystem Register Configuration Tool v0.09.10
+ * Wed Nov 15 2023 15:14:51 GMT+0100 (Mitteleuropäische Normalzeit)
+ * DDR Type: LPDDR4
+ * F0 = 50MHz    F1 = NA     F2 = 800MHz
+ * Density (per channel): 16Gb
+ * Write DBI: Enable
+ * Number of Ranks: 1
+*/
+
+#define DDRSS_PLL_FHS_CNT 3
+#define DDRSS_PLL_FREQUENCY_1 400000000
+#define DDRSS_PLL_FREQUENCY_2 400000000
+
+
+#define DDRSS_CTL_0_DATA 0x00000B00
+#define DDRSS_CTL_1_DATA 0x00000000
+#define DDRSS_CTL_2_DATA 0x00000000
+#define DDRSS_CTL_3_DATA 0x00000000
+#define DDRSS_CTL_4_DATA 0x00000000
+#define DDRSS_CTL_5_DATA 0x00000000
+#define DDRSS_CTL_6_DATA 0x00000000
+#define DDRSS_CTL_7_DATA 0x00002710
+#define DDRSS_CTL_8_DATA 0x000186A0
+#define DDRSS_CTL_9_DATA 0x00000005
+#define DDRSS_CTL_10_DATA 0x00000064
+#define DDRSS_CTL_11_DATA 0x00027100
+#define DDRSS_CTL_12_DATA 0x00186A00
+#define DDRSS_CTL_13_DATA 0x00000005
+#define DDRSS_CTL_14_DATA 0x00000640
+#define DDRSS_CTL_15_DATA 0x00027100
+#define DDRSS_CTL_16_DATA 0x00186A00
+#define DDRSS_CTL_17_DATA 0x00000005
+#define DDRSS_CTL_18_DATA 0x00000640
+#define DDRSS_CTL_19_DATA 0x01010100
+#define DDRSS_CTL_20_DATA 0x01010100
+#define DDRSS_CTL_21_DATA 0x01000110
+#define DDRSS_CTL_22_DATA 0x02010002
+#define DDRSS_CTL_23_DATA 0x0000000A
+#define DDRSS_CTL_24_DATA 0x000186A0
+#define DDRSS_CTL_25_DATA 0x00000000
+#define DDRSS_CTL_26_DATA 0x00000000
+#define DDRSS_CTL_27_DATA 0x00000000
+#define DDRSS_CTL_28_DATA 0x00000000
+#define DDRSS_CTL_29_DATA 0x00020200
+#define DDRSS_CTL_30_DATA 0x00000000
+#define DDRSS_CTL_31_DATA 0x00000000
+#define DDRSS_CTL_32_DATA 0x00000000
+#define DDRSS_CTL_33_DATA 0x00000000
+#define DDRSS_CTL_34_DATA 0x08000010
+#define DDRSS_CTL_35_DATA 0x00002020
+#define DDRSS_CTL_36_DATA 0x00000000
+#define DDRSS_CTL_37_DATA 0x00000000
+#define DDRSS_CTL_38_DATA 0x0000040C
+#define DDRSS_CTL_39_DATA 0x00000000
+#define DDRSS_CTL_40_DATA 0x00000A1C
+#define DDRSS_CTL_41_DATA 0x00000000
+#define DDRSS_CTL_42_DATA 0x00000A1C
+#define DDRSS_CTL_43_DATA 0x00000000
+#define DDRSS_CTL_44_DATA 0x05000804
+#define DDRSS_CTL_45_DATA 0x00000700
+#define DDRSS_CTL_46_DATA 0x09090004
+#define DDRSS_CTL_47_DATA 0x00000203
+#define DDRSS_CTL_48_DATA 0x00320007
+#define DDRSS_CTL_49_DATA 0x09090023
+#define DDRSS_CTL_50_DATA 0x0000190F
+#define DDRSS_CTL_51_DATA 0x00320007
+#define DDRSS_CTL_52_DATA 0x09090023
+#define DDRSS_CTL_53_DATA 0x0900190F
+#define DDRSS_CTL_54_DATA 0x000A0A09
+#define DDRSS_CTL_55_DATA 0x040006DB
+#define DDRSS_CTL_56_DATA 0x09092004
+#define DDRSS_CTL_57_DATA 0x00000C0A
+#define DDRSS_CTL_58_DATA 0x06006DB0
+#define DDRSS_CTL_59_DATA 0x09092006
+#define DDRSS_CTL_60_DATA 0x00000C0A
+#define DDRSS_CTL_61_DATA 0x06006DB0
+#define DDRSS_CTL_62_DATA 0x03042006
+#define DDRSS_CTL_63_DATA 0x04050002
+#define DDRSS_CTL_64_DATA 0x100F100F
+#define DDRSS_CTL_65_DATA 0x01010008
+#define DDRSS_CTL_66_DATA 0x041F1F07
+#define DDRSS_CTL_67_DATA 0x03111103
+#define DDRSS_CTL_68_DATA 0x00001111
+#define DDRSS_CTL_69_DATA 0x00000101
+#define DDRSS_CTL_70_DATA 0x00000000
+#define DDRSS_CTL_71_DATA 0x01000000
+#define DDRSS_CTL_72_DATA 0x00130803
+#define DDRSS_CTL_73_DATA 0x000000BB
+#define DDRSS_CTL_74_DATA 0x00000130
+#define DDRSS_CTL_75_DATA 0x00000C28
+#define DDRSS_CTL_76_DATA 0x00000130
+#define DDRSS_CTL_77_DATA 0x00000C28
+#define DDRSS_CTL_78_DATA 0x00000005
+#define DDRSS_CTL_79_DATA 0x0000000A
+#define DDRSS_CTL_80_DATA 0x00000010
+#define DDRSS_CTL_81_DATA 0x00000098
+#define DDRSS_CTL_82_DATA 0x0000017E
+#define DDRSS_CTL_83_DATA 0x00000098
+#define DDRSS_CTL_84_DATA 0x0000017E
+#define DDRSS_CTL_85_DATA 0x03004000
+#define DDRSS_CTL_86_DATA 0x00001201
+#define DDRSS_CTL_87_DATA 0x00060005
+#define DDRSS_CTL_88_DATA 0x00000006
+#define DDRSS_CTL_89_DATA 0x00000000
+#define DDRSS_CTL_90_DATA 0x05121208
+#define DDRSS_CTL_91_DATA 0x05030A05
+#define DDRSS_CTL_92_DATA 0x05030C06
+#define DDRSS_CTL_93_DATA 0x01030C06
+#define DDRSS_CTL_94_DATA 0x02010201
+#define DDRSS_CTL_95_DATA 0x00006E01
+#define DDRSS_CTL_96_DATA 0x0136006E
+#define DDRSS_CTL_97_DATA 0x01360136
+#define DDRSS_CTL_98_DATA 0x00000136
+#define DDRSS_CTL_99_DATA 0x00000000
+#define DDRSS_CTL_100_DATA 0x05010303
+#define DDRSS_CTL_101_DATA 0x0C040505
+#define DDRSS_CTL_102_DATA 0x06050203
+#define DDRSS_CTL_103_DATA 0x030C0605
+#define DDRSS_CTL_104_DATA 0x05060502
+#define DDRSS_CTL_105_DATA 0x03030306
+#define DDRSS_CTL_106_DATA 0x03010000
+#define DDRSS_CTL_107_DATA 0x00010000
+#define DDRSS_CTL_108_DATA 0x00000000
+#define DDRSS_CTL_109_DATA 0x01000000
+#define DDRSS_CTL_110_DATA 0x80104002
+#define DDRSS_CTL_111_DATA 0x00040003
+#define DDRSS_CTL_112_DATA 0x00040005
+#define DDRSS_CTL_113_DATA 0x00030000
+#define DDRSS_CTL_114_DATA 0x00050004
+#define DDRSS_CTL_115_DATA 0x00000004
+#define DDRSS_CTL_116_DATA 0x00040003
+#define DDRSS_CTL_117_DATA 0x00040005
+#define DDRSS_CTL_118_DATA 0x00000000
+#define DDRSS_CTL_119_DATA 0x00002EC0
+#define DDRSS_CTL_120_DATA 0x00002EC0
+#define DDRSS_CTL_121_DATA 0x00002EC0
+#define DDRSS_CTL_122_DATA 0x00002EC0
+#define DDRSS_CTL_123_DATA 0x00002EC0
+#define DDRSS_CTL_124_DATA 0x00000000
+#define DDRSS_CTL_125_DATA 0x0000051D
+#define DDRSS_CTL_126_DATA 0x00030A00
+#define DDRSS_CTL_127_DATA 0x00030A00
+#define DDRSS_CTL_128_DATA 0x00030A00
+#define DDRSS_CTL_129_DATA 0x00030A00
+#define DDRSS_CTL_130_DATA 0x00030A00
+#define DDRSS_CTL_131_DATA 0x00000000
+#define DDRSS_CTL_132_DATA 0x00005518
+#define DDRSS_CTL_133_DATA 0x00030A00
+#define DDRSS_CTL_134_DATA 0x00030A00
+#define DDRSS_CTL_135_DATA 0x00030A00
+#define DDRSS_CTL_136_DATA 0x00030A00
+#define DDRSS_CTL_137_DATA 0x00030A00
+#define DDRSS_CTL_138_DATA 0x00000000
+#define DDRSS_CTL_139_DATA 0x00005518
+#define DDRSS_CTL_140_DATA 0x00000000
+#define DDRSS_CTL_141_DATA 0x00000000
+#define DDRSS_CTL_142_DATA 0x00000000
+#define DDRSS_CTL_143_DATA 0x00000000
+#define DDRSS_CTL_144_DATA 0x00000000
+#define DDRSS_CTL_145_DATA 0x00000000
+#define DDRSS_CTL_146_DATA 0x00000000
+#define DDRSS_CTL_147_DATA 0x00000000
+#define DDRSS_CTL_148_DATA 0x00000000
+#define DDRSS_CTL_149_DATA 0x00000000
+#define DDRSS_CTL_150_DATA 0x00000000
+#define DDRSS_CTL_151_DATA 0x00000000
+#define DDRSS_CTL_152_DATA 0x00000000
+#define DDRSS_CTL_153_DATA 0x00000000
+#define DDRSS_CTL_154_DATA 0x00000000
+#define DDRSS_CTL_155_DATA 0x00000000
+#define DDRSS_CTL_156_DATA 0x03050000
+#define DDRSS_CTL_157_DATA 0x03050305
+#define DDRSS_CTL_158_DATA 0x00000000
+#define DDRSS_CTL_159_DATA 0x08010000
+#define DDRSS_CTL_160_DATA 0x000E0808
+#define DDRSS_CTL_161_DATA 0x01000000
+#define DDRSS_CTL_162_DATA 0x0E080808
+#define DDRSS_CTL_163_DATA 0x00000000
+#define DDRSS_CTL_164_DATA 0x08080801
+#define DDRSS_CTL_165_DATA 0x0000080E
+#define DDRSS_CTL_166_DATA 0x00040003
+#define DDRSS_CTL_167_DATA 0x00000007
+#define DDRSS_CTL_168_DATA 0x00000000
+#define DDRSS_CTL_169_DATA 0x00000000
+#define DDRSS_CTL_170_DATA 0x00000000
+#define DDRSS_CTL_171_DATA 0x00000000
+#define DDRSS_CTL_172_DATA 0x00000000
+#define DDRSS_CTL_173_DATA 0x00000000
+#define DDRSS_CTL_174_DATA 0x01000000
+#define DDRSS_CTL_175_DATA 0x00000000
+#define DDRSS_CTL_176_DATA 0x00001500
+#define DDRSS_CTL_177_DATA 0x0000100E
+#define DDRSS_CTL_178_DATA 0x00000002
+#define DDRSS_CTL_179_DATA 0x00000000
+#define DDRSS_CTL_180_DATA 0x00000001
+#define DDRSS_CTL_181_DATA 0x00000002
+#define DDRSS_CTL_182_DATA 0x00000C00
+#define DDRSS_CTL_183_DATA 0x00001000
+#define DDRSS_CTL_184_DATA 0x00000C00
+#define DDRSS_CTL_185_DATA 0x00001000
+#define DDRSS_CTL_186_DATA 0x00000C00
+#define DDRSS_CTL_187_DATA 0x00001000
+#define DDRSS_CTL_188_DATA 0x00000000
+#define DDRSS_CTL_189_DATA 0x00000000
+#define DDRSS_CTL_190_DATA 0x00000000
+#define DDRSS_CTL_191_DATA 0x00000000
+#define DDRSS_CTL_192_DATA 0x0005000A
+#define DDRSS_CTL_193_DATA 0x0404000D
+#define DDRSS_CTL_194_DATA 0x0000000D
+#define DDRSS_CTL_195_DATA 0x005000A0
+#define DDRSS_CTL_196_DATA 0x060600C8
+#define DDRSS_CTL_197_DATA 0x000000C8
+#define DDRSS_CTL_198_DATA 0x005000A0
+#define DDRSS_CTL_199_DATA 0x060600C8
+#define DDRSS_CTL_200_DATA 0x000000C8
+#define DDRSS_CTL_201_DATA 0x00000000
+#define DDRSS_CTL_202_DATA 0x00000000
+#define DDRSS_CTL_203_DATA 0x00000000
+#define DDRSS_CTL_204_DATA 0x00000000
+#define DDRSS_CTL_205_DATA 0x00000004
+#define DDRSS_CTL_206_DATA 0x00000000
+#define DDRSS_CTL_207_DATA 0x00000000
+#define DDRSS_CTL_208_DATA 0x00000034
+#define DDRSS_CTL_209_DATA 0x0000001A
+#define DDRSS_CTL_210_DATA 0x00000000
+#define DDRSS_CTL_211_DATA 0x00000034
+#define DDRSS_CTL_212_DATA 0x0000001A
+#define DDRSS_CTL_213_DATA 0x00000000
+#define DDRSS_CTL_214_DATA 0x00000004
+#define DDRSS_CTL_215_DATA 0x00000000
+#define DDRSS_CTL_216_DATA 0x00000000
+#define DDRSS_CTL_217_DATA 0x00000034
+#define DDRSS_CTL_218_DATA 0x0000001A
+#define DDRSS_CTL_219_DATA 0x00000000
+#define DDRSS_CTL_220_DATA 0x00000034
+#define DDRSS_CTL_221_DATA 0x0000001A
+#define DDRSS_CTL_222_DATA 0x00000000
+#define DDRSS_CTL_223_DATA 0x00000000
+#define DDRSS_CTL_224_DATA 0x00000031
+#define DDRSS_CTL_225_DATA 0x000000B1
+#define DDRSS_CTL_226_DATA 0x000000B1
+#define DDRSS_CTL_227_DATA 0x00000031
+#define DDRSS_CTL_228_DATA 0x000000B1
+#define DDRSS_CTL_229_DATA 0x000000B1
+#define DDRSS_CTL_230_DATA 0x00000000
+#define DDRSS_CTL_231_DATA 0x00000000
+#define DDRSS_CTL_232_DATA 0x00000000
+#define DDRSS_CTL_233_DATA 0x00000000
+#define DDRSS_CTL_234_DATA 0x00000000
+#define DDRSS_CTL_235_DATA 0x00000000
+#define DDRSS_CTL_236_DATA 0x00000000
+#define DDRSS_CTL_237_DATA 0x00000000
+#define DDRSS_CTL_238_DATA 0x00000000
+#define DDRSS_CTL_239_DATA 0x00000000
+#define DDRSS_CTL_240_DATA 0x00000000
+#define DDRSS_CTL_241_DATA 0x00000000
+#define DDRSS_CTL_242_DATA 0x00000000
+#define DDRSS_CTL_243_DATA 0x00000000
+#define DDRSS_CTL_244_DATA 0x00000000
+#define DDRSS_CTL_245_DATA 0x00000000
+#define DDRSS_CTL_246_DATA 0x00000000
+#define DDRSS_CTL_247_DATA 0x00000000
+#define DDRSS_CTL_248_DATA 0x00000000
+#define DDRSS_CTL_249_DATA 0x00000000
+#define DDRSS_CTL_250_DATA 0x00000000
+#define DDRSS_CTL_251_DATA 0x00000000
+#define DDRSS_CTL_252_DATA 0x00000000
+#define DDRSS_CTL_253_DATA 0x44000000
+#define DDRSS_CTL_254_DATA 0x44444444
+#define DDRSS_CTL_255_DATA 0x00002744
+#define DDRSS_CTL_256_DATA 0x00000027
+#define DDRSS_CTL_257_DATA 0x00000027
+#define DDRSS_CTL_258_DATA 0x00000027
+#define DDRSS_CTL_259_DATA 0x00000027
+#define DDRSS_CTL_260_DATA 0x00000027
+#define DDRSS_CTL_261_DATA 0x00000000
+#define DDRSS_CTL_262_DATA 0x00000000
+#define DDRSS_CTL_263_DATA 0x0000000F
+#define DDRSS_CTL_264_DATA 0x0000000F
+#define DDRSS_CTL_265_DATA 0x0000000F
+#define DDRSS_CTL_266_DATA 0x0000000F
+#define DDRSS_CTL_267_DATA 0x0000000F
+#define DDRSS_CTL_268_DATA 0x0000000F
+#define DDRSS_CTL_269_DATA 0x00000000
+#define DDRSS_CTL_270_DATA 0x00001400
+#define DDRSS_CTL_271_DATA 0x00000014
+#define DDRSS_CTL_272_DATA 0x00000014
+#define DDRSS_CTL_273_DATA 0x00000014
+#define DDRSS_CTL_274_DATA 0x00000014
+#define DDRSS_CTL_275_DATA 0x00000014
+#define DDRSS_CTL_276_DATA 0x00000020
+#define DDRSS_CTL_277_DATA 0x00010000
+#define DDRSS_CTL_278_DATA 0x00000100
+#define DDRSS_CTL_279_DATA 0x00000000
+#define DDRSS_CTL_280_DATA 0x00000000
+#define DDRSS_CTL_281_DATA 0x00000101
+#define DDRSS_CTL_282_DATA 0x00000000
+#define DDRSS_CTL_283_DATA 0x00000000
+#define DDRSS_CTL_284_DATA 0x00000000
+#define DDRSS_CTL_285_DATA 0x00000000
+#define DDRSS_CTL_286_DATA 0x00000000
+#define DDRSS_CTL_287_DATA 0x00000000
+#define DDRSS_CTL_288_DATA 0x00000000
+#define DDRSS_CTL_289_DATA 0x00000000
+#define DDRSS_CTL_290_DATA 0x0C181511
+#define DDRSS_CTL_291_DATA 0x00000304
+#define DDRSS_CTL_292_DATA 0x00000000
+#define DDRSS_CTL_293_DATA 0x00000000
+#define DDRSS_CTL_294_DATA 0x00000000
+#define DDRSS_CTL_295_DATA 0x00000000
+#define DDRSS_CTL_296_DATA 0x00000000
+#define DDRSS_CTL_297_DATA 0x00000000
+#define DDRSS_CTL_298_DATA 0x00000000
+#define DDRSS_CTL_299_DATA 0x00000000
+#define DDRSS_CTL_300_DATA 0x00000000
+#define DDRSS_CTL_301_DATA 0x00000000
+#define DDRSS_CTL_302_DATA 0x00000000
+#define DDRSS_CTL_303_DATA 0x00000000
+#define DDRSS_CTL_304_DATA 0x00000000
+#define DDRSS_CTL_305_DATA 0x00020000
+#define DDRSS_CTL_306_DATA 0x00400100
+#define DDRSS_CTL_307_DATA 0x00080032
+#define DDRSS_CTL_308_DATA 0x01000200
+#define DDRSS_CTL_309_DATA 0x03200040
+#define DDRSS_CTL_310_DATA 0x00020018
+#define DDRSS_CTL_311_DATA 0x00400100
+#define DDRSS_CTL_312_DATA 0x00180320
+#define DDRSS_CTL_313_DATA 0x00030000
+#define DDRSS_CTL_314_DATA 0x00280028
+#define DDRSS_CTL_315_DATA 0x00000100
+#define DDRSS_CTL_316_DATA 0x01010000
+#define DDRSS_CTL_317_DATA 0x00000000
+#define DDRSS_CTL_318_DATA 0x3FFF0000
+#define DDRSS_CTL_319_DATA 0x000FFF00
+#define DDRSS_CTL_320_DATA 0xFFFFFFFF
+#define DDRSS_CTL_321_DATA 0x00FFFF00
+#define DDRSS_CTL_322_DATA 0x0B000000
+#define DDRSS_CTL_323_DATA 0x0001FFFF
+#define DDRSS_CTL_324_DATA 0x01010101
+#define DDRSS_CTL_325_DATA 0x01010101
+#define DDRSS_CTL_326_DATA 0x00000118
+#define DDRSS_CTL_327_DATA 0x00000C01
+#define DDRSS_CTL_328_DATA 0x01000100
+#define DDRSS_CTL_329_DATA 0x00000000
+#define DDRSS_CTL_330_DATA 0x00000000
+#define DDRSS_CTL_331_DATA 0x01030303
+#define DDRSS_CTL_332_DATA 0x00000001
+#define DDRSS_CTL_333_DATA 0x00000000
+#define DDRSS_CTL_334_DATA 0x00000000
+#define DDRSS_CTL_335_DATA 0x00000000
+#define DDRSS_CTL_336_DATA 0x00000000
+#define DDRSS_CTL_337_DATA 0x00000000
+#define DDRSS_CTL_338_DATA 0x00000000
+#define DDRSS_CTL_339_DATA 0x00000000
+#define DDRSS_CTL_340_DATA 0x00000000
+#define DDRSS_CTL_341_DATA 0x00000000
+#define DDRSS_CTL_342_DATA 0x00000000
+#define DDRSS_CTL_343_DATA 0x00000000
+#define DDRSS_CTL_344_DATA 0x00000000
+#define DDRSS_CTL_345_DATA 0x00000000
+#define DDRSS_CTL_346_DATA 0x00000000
+#define DDRSS_CTL_347_DATA 0x00000000
+#define DDRSS_CTL_348_DATA 0x00000000
+#define DDRSS_CTL_349_DATA 0x00000000
+#define DDRSS_CTL_350_DATA 0x00000000
+#define DDRSS_CTL_351_DATA 0x00000000
+#define DDRSS_CTL_352_DATA 0x00000000
+#define DDRSS_CTL_353_DATA 0x00000000
+#define DDRSS_CTL_354_DATA 0x00000000
+#define DDRSS_CTL_355_DATA 0x00000000
+#define DDRSS_CTL_356_DATA 0x00000000
+#define DDRSS_CTL_357_DATA 0x00000000
+#define DDRSS_CTL_358_DATA 0x00000000
+#define DDRSS_CTL_359_DATA 0x00000000
+#define DDRSS_CTL_360_DATA 0x00000000
+#define DDRSS_CTL_361_DATA 0x00000000
+#define DDRSS_CTL_362_DATA 0x00000000
+#define DDRSS_CTL_363_DATA 0x00000000
+#define DDRSS_CTL_364_DATA 0x00000000
+#define DDRSS_CTL_365_DATA 0x00000000
+#define DDRSS_CTL_366_DATA 0x00000000
+#define DDRSS_CTL_367_DATA 0x00000000
+#define DDRSS_CTL_368_DATA 0x00000000
+#define DDRSS_CTL_369_DATA 0x00000000
+#define DDRSS_CTL_370_DATA 0x00000000
+#define DDRSS_CTL_371_DATA 0x01000101
+#define DDRSS_CTL_372_DATA 0x01010001
+#define DDRSS_CTL_373_DATA 0x00010101
+#define DDRSS_CTL_374_DATA 0x01070703
+#define DDRSS_CTL_375_DATA 0x05020201
+#define DDRSS_CTL_376_DATA 0x08080C0C
+#define DDRSS_CTL_377_DATA 0x00080308
+#define DDRSS_CTL_378_DATA 0x0009030E
+#define DDRSS_CTL_379_DATA 0x00090312
+#define DDRSS_CTL_380_DATA 0x09090806
+#define DDRSS_CTL_381_DATA 0x01000000
+#define DDRSS_CTL_382_DATA 0x03020301
+#define DDRSS_CTL_383_DATA 0x04000102
+#define DDRSS_CTL_384_DATA 0x1B000004
+#define DDRSS_CTL_385_DATA 0x00000176
+#define DDRSS_CTL_386_DATA 0x00000200
+#define DDRSS_CTL_387_DATA 0x00000200
+#define DDRSS_CTL_388_DATA 0x00000200
+#define DDRSS_CTL_389_DATA 0x00000200
+#define DDRSS_CTL_390_DATA 0x00000693
+#define DDRSS_CTL_391_DATA 0x00000E9C
+#define DDRSS_CTL_392_DATA 0x03050202
+#define DDRSS_CTL_393_DATA 0x00250201
+#define DDRSS_CTL_394_DATA 0x00001850
+#define DDRSS_CTL_395_DATA 0x00000200
+#define DDRSS_CTL_396_DATA 0x00000200
+#define DDRSS_CTL_397_DATA 0x00000200
+#define DDRSS_CTL_398_DATA 0x00000200
+#define DDRSS_CTL_399_DATA 0x00006D68
+#define DDRSS_CTL_400_DATA 0x0000F320
+#define DDRSS_CTL_401_DATA 0x070D0402
+#define DDRSS_CTL_402_DATA 0x00250607
+#define DDRSS_CTL_403_DATA 0x00001850
+#define DDRSS_CTL_404_DATA 0x00000200
+#define DDRSS_CTL_405_DATA 0x00000200
+#define DDRSS_CTL_406_DATA 0x00000200
+#define DDRSS_CTL_407_DATA 0x00000200
+#define DDRSS_CTL_408_DATA 0x00006D68
+#define DDRSS_CTL_409_DATA 0x0000F320
+#define DDRSS_CTL_410_DATA 0x070D0402
+#define DDRSS_CTL_411_DATA 0x00000607
+#define DDRSS_CTL_412_DATA 0x00000000
+#define DDRSS_CTL_413_DATA 0x0302000A
+#define DDRSS_CTL_414_DATA 0x01000500
+#define DDRSS_CTL_415_DATA 0x01010001
+#define DDRSS_CTL_416_DATA 0x00010001
+#define DDRSS_CTL_417_DATA 0x01010001
+#define DDRSS_CTL_418_DATA 0x02010000
+#define DDRSS_CTL_419_DATA 0x00000200
+#define DDRSS_CTL_420_DATA 0x02000201
+#define DDRSS_CTL_421_DATA 0x14140600
+#define DDRSS_CTL_422_DATA 0x00202020
+#define DDRSS_PI_0_DATA 0x00000B00
+#define DDRSS_PI_1_DATA 0x00000000
+#define DDRSS_PI_2_DATA 0x00000000
+#define DDRSS_PI_3_DATA 0x01000000
+#define DDRSS_PI_4_DATA 0x00000001
+#define DDRSS_PI_5_DATA 0x00010064
+#define DDRSS_PI_6_DATA 0x00000000
+#define DDRSS_PI_7_DATA 0x00000000
+#define DDRSS_PI_8_DATA 0x00000000
+#define DDRSS_PI_9_DATA 0x00000000
+#define DDRSS_PI_10_DATA 0x00000000
+#define DDRSS_PI_11_DATA 0x00000002
+#define DDRSS_PI_12_DATA 0x00000005
+#define DDRSS_PI_13_DATA 0x00010001
+#define DDRSS_PI_14_DATA 0x08000000
+#define DDRSS_PI_15_DATA 0x00010300
+#define DDRSS_PI_16_DATA 0x00000005
+#define DDRSS_PI_17_DATA 0x00000000
+#define DDRSS_PI_18_DATA 0x00000000
+#define DDRSS_PI_19_DATA 0x00000000
+#define DDRSS_PI_20_DATA 0x00000000
+#define DDRSS_PI_21_DATA 0x00000000
+#define DDRSS_PI_22_DATA 0x00000000
+#define DDRSS_PI_23_DATA 0x00010000
+#define DDRSS_PI_24_DATA 0x280A0001
+#define DDRSS_PI_25_DATA 0x00000000
+#define DDRSS_PI_26_DATA 0x00010000
+#define DDRSS_PI_27_DATA 0x00003200
+#define DDRSS_PI_28_DATA 0x00000000
+#define DDRSS_PI_29_DATA 0x00000000
+#define DDRSS_PI_30_DATA 0x01010102
+#define DDRSS_PI_31_DATA 0x00000000
+#define DDRSS_PI_32_DATA 0x00000000
+#define DDRSS_PI_33_DATA 0x00000000
+#define DDRSS_PI_34_DATA 0x00000001
+#define DDRSS_PI_35_DATA 0x000000AA
+#define DDRSS_PI_36_DATA 0x00000055
+#define DDRSS_PI_37_DATA 0x000000B5
+#define DDRSS_PI_38_DATA 0x0000004A
+#define DDRSS_PI_39_DATA 0x00000056
+#define DDRSS_PI_40_DATA 0x000000A9
+#define DDRSS_PI_41_DATA 0x000000A9
+#define DDRSS_PI_42_DATA 0x000000B5
+#define DDRSS_PI_43_DATA 0x00000000
+#define DDRSS_PI_44_DATA 0x00000000
+#define DDRSS_PI_45_DATA 0x00010100
+#define DDRSS_PI_46_DATA 0x00000015
+#define DDRSS_PI_47_DATA 0x000007D0
+#define DDRSS_PI_48_DATA 0x00000300
+#define DDRSS_PI_49_DATA 0x00000000
+#define DDRSS_PI_50_DATA 0x00000000
+#define DDRSS_PI_51_DATA 0x01000000
+#define DDRSS_PI_52_DATA 0x00010101
+#define DDRSS_PI_53_DATA 0x01000000
+#define DDRSS_PI_54_DATA 0x03000000
+#define DDRSS_PI_55_DATA 0x00000000
+#define DDRSS_PI_56_DATA 0x00001701
+#define DDRSS_PI_57_DATA 0x00000000
+#define DDRSS_PI_58_DATA 0x00000000
+#define DDRSS_PI_59_DATA 0x00000000
+#define DDRSS_PI_60_DATA 0x0A0A140A
+#define DDRSS_PI_61_DATA 0x10020101
+#define DDRSS_PI_62_DATA 0x01000210
+#define DDRSS_PI_63_DATA 0x05000404
+#define DDRSS_PI_64_DATA 0x00010001
+#define DDRSS_PI_65_DATA 0x0001000E
+#define DDRSS_PI_66_DATA 0x01010100
+#define DDRSS_PI_67_DATA 0x00010000
+#define DDRSS_PI_68_DATA 0x00000034
+#define DDRSS_PI_69_DATA 0x00000000
+#define DDRSS_PI_70_DATA 0x00000000
+#define DDRSS_PI_71_DATA 0x0000FFFF
+#define DDRSS_PI_72_DATA 0x00000000
+#define DDRSS_PI_73_DATA 0x00000000
+#define DDRSS_PI_74_DATA 0x00000000
+#define DDRSS_PI_75_DATA 0x00000000
+#define DDRSS_PI_76_DATA 0x01000000
+#define DDRSS_PI_77_DATA 0x08000100
+#define DDRSS_PI_78_DATA 0x00020000
+#define DDRSS_PI_79_DATA 0x00010002
+#define DDRSS_PI_80_DATA 0x00000001
+#define DDRSS_PI_81_DATA 0x00020001
+#define DDRSS_PI_82_DATA 0x00020002
+#define DDRSS_PI_83_DATA 0x00000000
+#define DDRSS_PI_84_DATA 0x00000000
+#define DDRSS_PI_85_DATA 0x00000000
+#define DDRSS_PI_86_DATA 0x00000000
+#define DDRSS_PI_87_DATA 0x00000000
+#define DDRSS_PI_88_DATA 0x00000000
+#define DDRSS_PI_89_DATA 0x00000000
+#define DDRSS_PI_90_DATA 0x00000000
+#define DDRSS_PI_91_DATA 0x00000400
+#define DDRSS_PI_92_DATA 0x0A090B0C
+#define DDRSS_PI_93_DATA 0x04060708
+#define DDRSS_PI_94_DATA 0x01000005
+#define DDRSS_PI_95_DATA 0x00000800
+#define DDRSS_PI_96_DATA 0x00000000
+#define DDRSS_PI_97_DATA 0x00010008
+#define DDRSS_PI_98_DATA 0x00000000
+#define DDRSS_PI_99_DATA 0x0000AA00
+#define DDRSS_PI_100_DATA 0x00000000
+#define DDRSS_PI_101_DATA 0x00010000
+#define DDRSS_PI_102_DATA 0x00000000
+#define DDRSS_PI_103_DATA 0x00000000
+#define DDRSS_PI_104_DATA 0x00000000
+#define DDRSS_PI_105_DATA 0x00000000
+#define DDRSS_PI_106_DATA 0x00000000
+#define DDRSS_PI_107_DATA 0x00000000
+#define DDRSS_PI_108_DATA 0x00000000
+#define DDRSS_PI_109_DATA 0x00000000
+#define DDRSS_PI_110_DATA 0x00000000
+#define DDRSS_PI_111_DATA 0x00000000
+#define DDRSS_PI_112_DATA 0x00000000
+#define DDRSS_PI_113_DATA 0x00000000
+#define DDRSS_PI_114_DATA 0x00000000
+#define DDRSS_PI_115_DATA 0x00000000
+#define DDRSS_PI_116_DATA 0x00000000
+#define DDRSS_PI_117_DATA 0x00000000
+#define DDRSS_PI_118_DATA 0x00000000
+#define DDRSS_PI_119_DATA 0x00000000
+#define DDRSS_PI_120_DATA 0x00000000
+#define DDRSS_PI_121_DATA 0x00000000
+#define DDRSS_PI_122_DATA 0x00000000
+#define DDRSS_PI_123_DATA 0x00000000
+#define DDRSS_PI_124_DATA 0x00000008
+#define DDRSS_PI_125_DATA 0x00000000
+#define DDRSS_PI_126_DATA 0x00000000
+#define DDRSS_PI_127_DATA 0x00000000
+#define DDRSS_PI_128_DATA 0x00000000
+#define DDRSS_PI_129_DATA 0x00000000
+#define DDRSS_PI_130_DATA 0x00000000
+#define DDRSS_PI_131_DATA 0x00000000
+#define DDRSS_PI_132_DATA 0x00000000
+#define DDRSS_PI_133_DATA 0x00010000
+#define DDRSS_PI_134_DATA 0x00000000
+#define DDRSS_PI_135_DATA 0x00000000
+#define DDRSS_PI_136_DATA 0x0000000A
+#define DDRSS_PI_137_DATA 0x000186A0
+#define DDRSS_PI_138_DATA 0x00000100
+#define DDRSS_PI_139_DATA 0x00000000
+#define DDRSS_PI_140_DATA 0x00000000
+#define DDRSS_PI_141_DATA 0x00000000
+#define DDRSS_PI_142_DATA 0x00000000
+#define DDRSS_PI_143_DATA 0x00000000
+#define DDRSS_PI_144_DATA 0x01000000
+#define DDRSS_PI_145_DATA 0x00010003
+#define DDRSS_PI_146_DATA 0x02000101
+#define DDRSS_PI_147_DATA 0x01030001
+#define DDRSS_PI_148_DATA 0x00010400
+#define DDRSS_PI_149_DATA 0x06000105
+#define DDRSS_PI_150_DATA 0x01070001
+#define DDRSS_PI_151_DATA 0x00000000
+#define DDRSS_PI_152_DATA 0x00000000
+#define DDRSS_PI_153_DATA 0x00000000
+#define DDRSS_PI_154_DATA 0x00010001
+#define DDRSS_PI_155_DATA 0x00000000
+#define DDRSS_PI_156_DATA 0x00000000
+#define DDRSS_PI_157_DATA 0x00000000
+#define DDRSS_PI_158_DATA 0x00000000
+#define DDRSS_PI_159_DATA 0x00010000
+#define DDRSS_PI_160_DATA 0x00000004
+#define DDRSS_PI_161_DATA 0x00000000
+#define DDRSS_PI_162_DATA 0x00000000
+#define DDRSS_PI_163_DATA 0x00000000
+#define DDRSS_PI_164_DATA 0x00000800
+#define DDRSS_PI_165_DATA 0x00780078
+#define DDRSS_PI_166_DATA 0x00101001
+#define DDRSS_PI_167_DATA 0x00000034
+#define DDRSS_PI_168_DATA 0x00000042
+#define DDRSS_PI_169_DATA 0x00020042
+#define DDRSS_PI_170_DATA 0x02000200
+#define DDRSS_PI_171_DATA 0x00000004
+#define DDRSS_PI_172_DATA 0x00000A0C
+#define DDRSS_PI_173_DATA 0x000A1C00
+#define DDRSS_PI_174_DATA 0x001C0000
+#define DDRSS_PI_175_DATA 0x00000013
+#define DDRSS_PI_176_DATA 0x000000BB
+#define DDRSS_PI_177_DATA 0x00000130
+#define DDRSS_PI_178_DATA 0x00000C28
+#define DDRSS_PI_179_DATA 0x00000130
+#define DDRSS_PI_180_DATA 0x04000C28
+#define DDRSS_PI_181_DATA 0x01010404
+#define DDRSS_PI_182_DATA 0x00001501
+#define DDRSS_PI_183_DATA 0x001D001D
+#define DDRSS_PI_184_DATA 0x01000100
+#define DDRSS_PI_185_DATA 0x00000100
+#define DDRSS_PI_186_DATA 0x00000000
+#define DDRSS_PI_187_DATA 0x05070703
+#define DDRSS_PI_188_DATA 0x01010C0C
+#define DDRSS_PI_189_DATA 0x01010101
+#define DDRSS_PI_190_DATA 0x000C0C0A
+#define DDRSS_PI_191_DATA 0x00000000
+#define DDRSS_PI_192_DATA 0x00000000
+#define DDRSS_PI_193_DATA 0x04000000
+#define DDRSS_PI_194_DATA 0x06020808
+#define DDRSS_PI_195_DATA 0x04040206
+#define DDRSS_PI_196_DATA 0x00090031
+#define DDRSS_PI_197_DATA 0x00110039
+#define DDRSS_PI_198_DATA 0x00110039
+#define DDRSS_PI_199_DATA 0x01010101
+#define DDRSS_PI_200_DATA 0x0002000D
+#define DDRSS_PI_201_DATA 0x000200C8
+#define DDRSS_PI_202_DATA 0x010000C8
+#define DDRSS_PI_203_DATA 0x000E000E
+#define DDRSS_PI_204_DATA 0x00C90100
+#define DDRSS_PI_205_DATA 0x010000C9
+#define DDRSS_PI_206_DATA 0x00C900C9
+#define DDRSS_PI_207_DATA 0x32103200
+#define DDRSS_PI_208_DATA 0x01013210
+#define DDRSS_PI_209_DATA 0x0A070601
+#define DDRSS_PI_210_DATA 0x0D09070D
+#define DDRSS_PI_211_DATA 0x0D09070D
+#define DDRSS_PI_212_DATA 0x000C000D
+#define DDRSS_PI_213_DATA 0x00001000
+#define DDRSS_PI_214_DATA 0x00000C00
+#define DDRSS_PI_215_DATA 0x00001000
+#define DDRSS_PI_216_DATA 0x00000C00
+#define DDRSS_PI_217_DATA 0x02001000
+#define DDRSS_PI_218_DATA 0x0016000D
+#define DDRSS_PI_219_DATA 0x001600C8
+#define DDRSS_PI_220_DATA 0x000000C8
+#define DDRSS_PI_221_DATA 0x00001900
+#define DDRSS_PI_222_DATA 0x32000056
+#define DDRSS_PI_223_DATA 0x06000101
+#define DDRSS_PI_224_DATA 0x001F0204
+#define DDRSS_PI_225_DATA 0x32120056
+#define DDRSS_PI_226_DATA 0x05000101
+#define DDRSS_PI_227_DATA 0x001F0608
+#define DDRSS_PI_228_DATA 0x32120056
+#define DDRSS_PI_229_DATA 0x05000101
+#define DDRSS_PI_230_DATA 0x00000608
+#define DDRSS_PI_231_DATA 0x05030900
+#define DDRSS_PI_232_DATA 0x00040900
+#define DDRSS_PI_233_DATA 0x0000062B
+#define DDRSS_PI_234_DATA 0x20010004
+#define DDRSS_PI_235_DATA 0x0A0A0A03
+#define DDRSS_PI_236_DATA 0x11090000
+#define DDRSS_PI_237_DATA 0x1009000F
+#define DDRSS_PI_238_DATA 0x000062B8
+#define DDRSS_PI_239_DATA 0x20030023
+#define DDRSS_PI_240_DATA 0x0C0A0C0C
+#define DDRSS_PI_241_DATA 0x11090000
+#define DDRSS_PI_242_DATA 0x1009000F
+#define DDRSS_PI_243_DATA 0x000062B8
+#define DDRSS_PI_244_DATA 0x20030023
+#define DDRSS_PI_245_DATA 0x0C0A0C0C
+#define DDRSS_PI_246_DATA 0x00000000
+#define DDRSS_PI_247_DATA 0x00000176
+#define DDRSS_PI_248_DATA 0x00000E9C
+#define DDRSS_PI_249_DATA 0x00001850
+#define DDRSS_PI_250_DATA 0x0000F320
+#define DDRSS_PI_251_DATA 0x00001850
+#define DDRSS_PI_252_DATA 0x0000F320
+#define DDRSS_PI_253_DATA 0x0136006E
+#define DDRSS_PI_254_DATA 0x03030136
+#define DDRSS_PI_255_DATA 0x00000003
+#define DDRSS_PI_256_DATA 0x00000000
+#define DDRSS_PI_257_DATA 0x05030503
+#define DDRSS_PI_258_DATA 0x00000503
+#define DDRSS_PI_259_DATA 0x00002710
+#define DDRSS_PI_260_DATA 0x000186A0
+#define DDRSS_PI_261_DATA 0x00000005
+#define DDRSS_PI_262_DATA 0x00000064
+#define DDRSS_PI_263_DATA 0x0000006E
+#define DDRSS_PI_264_DATA 0x00027100
+#define DDRSS_PI_265_DATA 0x000186A0
+#define DDRSS_PI_266_DATA 0x00000005
+#define DDRSS_PI_267_DATA 0x00000640
+#define DDRSS_PI_268_DATA 0x00000136
+#define DDRSS_PI_269_DATA 0x00027100
+#define DDRSS_PI_270_DATA 0x000186A0
+#define DDRSS_PI_271_DATA 0x00000005
+#define DDRSS_PI_272_DATA 0x00000640
+#define DDRSS_PI_273_DATA 0x01000136
+#define DDRSS_PI_274_DATA 0x00320040
+#define DDRSS_PI_275_DATA 0x00010008
+#define DDRSS_PI_276_DATA 0x03200040
+#define DDRSS_PI_277_DATA 0x00010018
+#define DDRSS_PI_278_DATA 0x03200040
+#define DDRSS_PI_279_DATA 0x00000318
+#define DDRSS_PI_280_DATA 0x00280028
+#define DDRSS_PI_281_DATA 0x03040404
+#define DDRSS_PI_282_DATA 0x00000303
+#define DDRSS_PI_283_DATA 0x02020101
+#define DDRSS_PI_284_DATA 0x67676767
+#define DDRSS_PI_285_DATA 0x00000000
+#define DDRSS_PI_286_DATA 0x55000000
+#define DDRSS_PI_287_DATA 0x00000000
+#define DDRSS_PI_288_DATA 0x3C00005A
+#define DDRSS_PI_289_DATA 0x00005500
+#define DDRSS_PI_290_DATA 0x00005A00
+#define DDRSS_PI_291_DATA 0x0D100F3C
+#define DDRSS_PI_292_DATA 0x0003020E
+#define DDRSS_PI_293_DATA 0x00000001
+#define DDRSS_PI_294_DATA 0x01000000
+#define DDRSS_PI_295_DATA 0x00020201
+#define DDRSS_PI_296_DATA 0x00000000
+#define DDRSS_PI_297_DATA 0x00000000
+#define DDRSS_PI_298_DATA 0x00000004
+#define DDRSS_PI_299_DATA 0x00000000
+#define DDRSS_PI_300_DATA 0x00000031
+#define DDRSS_PI_301_DATA 0x00000000
+#define DDRSS_PI_302_DATA 0x00000000
+#define DDRSS_PI_303_DATA 0x44000000
+#define DDRSS_PI_304_DATA 0x00140F27
+#define DDRSS_PI_305_DATA 0x00000000
+#define DDRSS_PI_306_DATA 0x00000034
+#define DDRSS_PI_307_DATA 0x0000001A
+#define DDRSS_PI_308_DATA 0x000000B1
+#define DDRSS_PI_309_DATA 0x00000000
+#define DDRSS_PI_310_DATA 0x00000000
+#define DDRSS_PI_311_DATA 0x44000000
+#define DDRSS_PI_312_DATA 0x00140F27
+#define DDRSS_PI_313_DATA 0x00000000
+#define DDRSS_PI_314_DATA 0x00000034
+#define DDRSS_PI_315_DATA 0x0000001A
+#define DDRSS_PI_316_DATA 0x000000B1
+#define DDRSS_PI_317_DATA 0x00000000
+#define DDRSS_PI_318_DATA 0x00000000
+#define DDRSS_PI_319_DATA 0x44000000
+#define DDRSS_PI_320_DATA 0x00140F27
+#define DDRSS_PI_321_DATA 0x00000000
+#define DDRSS_PI_322_DATA 0x00000004
+#define DDRSS_PI_323_DATA 0x00000000
+#define DDRSS_PI_324_DATA 0x00000031
+#define DDRSS_PI_325_DATA 0x00000000
+#define DDRSS_PI_326_DATA 0x00000000
+#define DDRSS_PI_327_DATA 0x44000000
+#define DDRSS_PI_328_DATA 0x00140F27
+#define DDRSS_PI_329_DATA 0x00000000
+#define DDRSS_PI_330_DATA 0x00000034
+#define DDRSS_PI_331_DATA 0x0000001A
+#define DDRSS_PI_332_DATA 0x000000B1
+#define DDRSS_PI_333_DATA 0x00000000
+#define DDRSS_PI_334_DATA 0x00000000
+#define DDRSS_PI_335_DATA 0x44000000
+#define DDRSS_PI_336_DATA 0x00140F27
+#define DDRSS_PI_337_DATA 0x00000000
+#define DDRSS_PI_338_DATA 0x00000034
+#define DDRSS_PI_339_DATA 0x0000001A
+#define DDRSS_PI_340_DATA 0x000000B1
+#define DDRSS_PI_341_DATA 0x00000000
+#define DDRSS_PI_342_DATA 0x00000000
+#define DDRSS_PI_343_DATA 0x44000000
+#define DDRSS_PI_344_DATA 0x00140F27
+#define DDRSS_PHY_0_DATA 0x04F00000
+#define DDRSS_PHY_1_DATA 0x00000000
+#define DDRSS_PHY_2_DATA 0x00030200
+#define DDRSS_PHY_3_DATA 0x00000000
+#define DDRSS_PHY_4_DATA 0x00000000
+#define DDRSS_PHY_5_DATA 0x01000000
+#define DDRSS_PHY_6_DATA 0x03000400
+#define DDRSS_PHY_7_DATA 0x00000001
+#define DDRSS_PHY_8_DATA 0x00000001
+#define DDRSS_PHY_9_DATA 0x00000000
+#define DDRSS_PHY_10_DATA 0x00000000
+#define DDRSS_PHY_11_DATA 0x01010000
+#define DDRSS_PHY_12_DATA 0x00010000
+#define DDRSS_PHY_13_DATA 0x00C00001
+#define DDRSS_PHY_14_DATA 0x00CC0008
+#define DDRSS_PHY_15_DATA 0x00660601
+#define DDRSS_PHY_16_DATA 0x00000003
+#define DDRSS_PHY_17_DATA 0x00000000
+#define DDRSS_PHY_18_DATA 0x00000000
+#define DDRSS_PHY_19_DATA 0x0000AAAA
+#define DDRSS_PHY_20_DATA 0x00005555
+#define DDRSS_PHY_21_DATA 0x0000B5B5
+#define DDRSS_PHY_22_DATA 0x00004A4A
+#define DDRSS_PHY_23_DATA 0x00005656
+#define DDRSS_PHY_24_DATA 0x0000A9A9
+#define DDRSS_PHY_25_DATA 0x0000B7B7
+#define DDRSS_PHY_26_DATA 0x00004848
+#define DDRSS_PHY_27_DATA 0x00000000
+#define DDRSS_PHY_28_DATA 0x00000000
+#define DDRSS_PHY_29_DATA 0x08000000
+#define DDRSS_PHY_30_DATA 0x0F000008
+#define DDRSS_PHY_31_DATA 0x00000F0F
+#define DDRSS_PHY_32_DATA 0x00E4E400
+#define DDRSS_PHY_33_DATA 0x00071020
+#define DDRSS_PHY_34_DATA 0x000C0020
+#define DDRSS_PHY_35_DATA 0x00062000
+#define DDRSS_PHY_36_DATA 0x00000000
+#define DDRSS_PHY_37_DATA 0x55555555
+#define DDRSS_PHY_38_DATA 0xAAAAAAAA
+#define DDRSS_PHY_39_DATA 0x55555555
+#define DDRSS_PHY_40_DATA 0xAAAAAAAA
+#define DDRSS_PHY_41_DATA 0x00005555
+#define DDRSS_PHY_42_DATA 0x01000100
+#define DDRSS_PHY_43_DATA 0x00800180
+#define DDRSS_PHY_44_DATA 0x00000001
+#define DDRSS_PHY_45_DATA 0x00000000
+#define DDRSS_PHY_46_DATA 0x00000000
+#define DDRSS_PHY_47_DATA 0x00000000
+#define DDRSS_PHY_48_DATA 0x00000000
+#define DDRSS_PHY_49_DATA 0x00000000
+#define DDRSS_PHY_50_DATA 0x00000000
+#define DDRSS_PHY_51_DATA 0x00000000
+#define DDRSS_PHY_52_DATA 0x00000000
+#define DDRSS_PHY_53_DATA 0x00000000
+#define DDRSS_PHY_54_DATA 0x00000000
+#define DDRSS_PHY_55_DATA 0x00000000
+#define DDRSS_PHY_56_DATA 0x00000000
+#define DDRSS_PHY_57_DATA 0x00000000
+#define DDRSS_PHY_58_DATA 0x00000000
+#define DDRSS_PHY_59_DATA 0x00000000
+#define DDRSS_PHY_60_DATA 0x00000000
+#define DDRSS_PHY_61_DATA 0x00000000
+#define DDRSS_PHY_62_DATA 0x00000000
+#define DDRSS_PHY_63_DATA 0x00000000
+#define DDRSS_PHY_64_DATA 0x00000000
+#define DDRSS_PHY_65_DATA 0x00000004
+#define DDRSS_PHY_66_DATA 0x00000000
+#define DDRSS_PHY_67_DATA 0x00000000
+#define DDRSS_PHY_68_DATA 0x00000000
+#define DDRSS_PHY_69_DATA 0x00000000
+#define DDRSS_PHY_70_DATA 0x00000000
+#define DDRSS_PHY_71_DATA 0x00000000
+#define DDRSS_PHY_72_DATA 0x041F07FF
+#define DDRSS_PHY_73_DATA 0x00000000
+#define DDRSS_PHY_74_DATA 0x01CC0801
+#define DDRSS_PHY_75_DATA 0x1003CC08
+#define DDRSS_PHY_76_DATA 0x20000140
+#define DDRSS_PHY_77_DATA 0x07FF0200
+#define DDRSS_PHY_78_DATA 0x0000DD01
+#define DDRSS_PHY_79_DATA 0x00100303
+#define DDRSS_PHY_80_DATA 0x00000000
+#define DDRSS_PHY_81_DATA 0x00000000
+#define DDRSS_PHY_82_DATA 0x00021000
+#define DDRSS_PHY_83_DATA 0x00100010
+#define DDRSS_PHY_84_DATA 0x00100010
+#define DDRSS_PHY_85_DATA 0x00100010
+#define DDRSS_PHY_86_DATA 0x00100010
+#define DDRSS_PHY_87_DATA 0x02020010
+#define DDRSS_PHY_88_DATA 0x51516041
+#define DDRSS_PHY_89_DATA 0x31C06000
+#define DDRSS_PHY_90_DATA 0x07AB0340
+#define DDRSS_PHY_91_DATA 0x0000C0C0
+#define DDRSS_PHY_92_DATA 0x04050000
+#define DDRSS_PHY_93_DATA 0x00000504
+#define DDRSS_PHY_94_DATA 0x42100010
+#define DDRSS_PHY_95_DATA 0x010C053E
+#define DDRSS_PHY_96_DATA 0x000F0C1D
+#define DDRSS_PHY_97_DATA 0x01000140
+#define DDRSS_PHY_98_DATA 0x007A0120
+#define DDRSS_PHY_99_DATA 0x00000C00
+#define DDRSS_PHY_100_DATA 0x000001CC
+#define DDRSS_PHY_101_DATA 0x20100200
+#define DDRSS_PHY_102_DATA 0x00000005
+#define DDRSS_PHY_103_DATA 0x76543210
+#define DDRSS_PHY_104_DATA 0x00000008
+#define DDRSS_PHY_105_DATA 0x034C034C
+#define DDRSS_PHY_106_DATA 0x034C034C
+#define DDRSS_PHY_107_DATA 0x034C034C
+#define DDRSS_PHY_108_DATA 0x034C034C
+#define DDRSS_PHY_109_DATA 0x0000034C
+#define DDRSS_PHY_110_DATA 0x00008000
+#define DDRSS_PHY_111_DATA 0x00800080
+#define DDRSS_PHY_112_DATA 0x00800080
+#define DDRSS_PHY_113_DATA 0x00800080
+#define DDRSS_PHY_114_DATA 0x00800080
+#define DDRSS_PHY_115_DATA 0x00800080
+#define DDRSS_PHY_116_DATA 0x00800080
+#define DDRSS_PHY_117_DATA 0x00800080
+#define DDRSS_PHY_118_DATA 0x00800080
+#define DDRSS_PHY_119_DATA 0x01800080
+#define DDRSS_PHY_120_DATA 0x01000000
+#define DDRSS_PHY_121_DATA 0x00000000
+#define DDRSS_PHY_122_DATA 0x00000000
+#define DDRSS_PHY_123_DATA 0x00080200
+#define DDRSS_PHY_124_DATA 0x00000000
+#define DDRSS_PHY_125_DATA 0x0000F0F0
+#define DDRSS_PHY_126_DATA 0x00000000
+#define DDRSS_PHY_127_DATA 0x00000000
+#define DDRSS_PHY_128_DATA 0x00000000
+#define DDRSS_PHY_129_DATA 0x00000000
+#define DDRSS_PHY_130_DATA 0x00000000
+#define DDRSS_PHY_131_DATA 0x00000000
+#define DDRSS_PHY_132_DATA 0x00000000
+#define DDRSS_PHY_133_DATA 0x00000000
+#define DDRSS_PHY_134_DATA 0x00000000
+#define DDRSS_PHY_135_DATA 0x00000000
+#define DDRSS_PHY_136_DATA 0x00000000
+#define DDRSS_PHY_137_DATA 0x00000000
+#define DDRSS_PHY_138_DATA 0x00000000
+#define DDRSS_PHY_139_DATA 0x00000000
+#define DDRSS_PHY_140_DATA 0x00000000
+#define DDRSS_PHY_141_DATA 0x00000000
+#define DDRSS_PHY_142_DATA 0x00000000
+#define DDRSS_PHY_143_DATA 0x00000000
+#define DDRSS_PHY_144_DATA 0x00000000
+#define DDRSS_PHY_145_DATA 0x00000000
+#define DDRSS_PHY_146_DATA 0x00000000
+#define DDRSS_PHY_147_DATA 0x00000000
+#define DDRSS_PHY_148_DATA 0x00000000
+#define DDRSS_PHY_149_DATA 0x00000000
+#define DDRSS_PHY_150_DATA 0x00000000
+#define DDRSS_PHY_151_DATA 0x00000000
+#define DDRSS_PHY_152_DATA 0x00000000
+#define DDRSS_PHY_153_DATA 0x00000000
+#define DDRSS_PHY_154_DATA 0x00000000
+#define DDRSS_PHY_155_DATA 0x00000000
+#define DDRSS_PHY_156_DATA 0x00000000
+#define DDRSS_PHY_157_DATA 0x00000000
+#define DDRSS_PHY_158_DATA 0x00000000
+#define DDRSS_PHY_159_DATA 0x00000000
+#define DDRSS_PHY_160_DATA 0x00000000
+#define DDRSS_PHY_161_DATA 0x00000000
+#define DDRSS_PHY_162_DATA 0x00000000
+#define DDRSS_PHY_163_DATA 0x00000000
+#define DDRSS_PHY_164_DATA 0x00000000
+#define DDRSS_PHY_165_DATA 0x00000000
+#define DDRSS_PHY_166_DATA 0x00000000
+#define DDRSS_PHY_167_DATA 0x00000000
+#define DDRSS_PHY_168_DATA 0x00000000
+#define DDRSS_PHY_169_DATA 0x00000000
+#define DDRSS_PHY_170_DATA 0x00000000
+#define DDRSS_PHY_171_DATA 0x00000000
+#define DDRSS_PHY_172_DATA 0x00000000
+#define DDRSS_PHY_173_DATA 0x00000000
+#define DDRSS_PHY_174_DATA 0x00000000
+#define DDRSS_PHY_175_DATA 0x00000000
+#define DDRSS_PHY_176_DATA 0x00000000
+#define DDRSS_PHY_177_DATA 0x00000000
+#define DDRSS_PHY_178_DATA 0x00000000
+#define DDRSS_PHY_179_DATA 0x00000000
+#define DDRSS_PHY_180_DATA 0x00000000
+#define DDRSS_PHY_181_DATA 0x00000000
+#define DDRSS_PHY_182_DATA 0x00000000
+#define DDRSS_PHY_183_DATA 0x00000000
+#define DDRSS_PHY_184_DATA 0x00000000
+#define DDRSS_PHY_185_DATA 0x00000000
+#define DDRSS_PHY_186_DATA 0x00000000
+#define DDRSS_PHY_187_DATA 0x00000000
+#define DDRSS_PHY_188_DATA 0x00000000
+#define DDRSS_PHY_189_DATA 0x00000000
+#define DDRSS_PHY_190_DATA 0x00000000
+#define DDRSS_PHY_191_DATA 0x00000000
+#define DDRSS_PHY_192_DATA 0x00000000
+#define DDRSS_PHY_193_DATA 0x00000000
+#define DDRSS_PHY_194_DATA 0x00000000
+#define DDRSS_PHY_195_DATA 0x00000000
+#define DDRSS_PHY_196_DATA 0x00000000
+#define DDRSS_PHY_197_DATA 0x00000000
+#define DDRSS_PHY_198_DATA 0x00000000
+#define DDRSS_PHY_199_DATA 0x00000000
+#define DDRSS_PHY_200_DATA 0x00000000
+#define DDRSS_PHY_201_DATA 0x00000000
+#define DDRSS_PHY_202_DATA 0x00000000
+#define DDRSS_PHY_203_DATA 0x00000000
+#define DDRSS_PHY_204_DATA 0x00000000
+#define DDRSS_PHY_205_DATA 0x00000000
+#define DDRSS_PHY_206_DATA 0x00000000
+#define DDRSS_PHY_207_DATA 0x00000000
+#define DDRSS_PHY_208_DATA 0x00000000
+#define DDRSS_PHY_209_DATA 0x00000000
+#define DDRSS_PHY_210_DATA 0x00000000
+#define DDRSS_PHY_211_DATA 0x00000000
+#define DDRSS_PHY_212_DATA 0x00000000
+#define DDRSS_PHY_213_DATA 0x00000000
+#define DDRSS_PHY_214_DATA 0x00000000
+#define DDRSS_PHY_215_DATA 0x00000000
+#define DDRSS_PHY_216_DATA 0x00000000
+#define DDRSS_PHY_217_DATA 0x00000000
+#define DDRSS_PHY_218_DATA 0x00000000
+#define DDRSS_PHY_219_DATA 0x00000000
+#define DDRSS_PHY_220_DATA 0x00000000
+#define DDRSS_PHY_221_DATA 0x00000000
+#define DDRSS_PHY_222_DATA 0x00000000
+#define DDRSS_PHY_223_DATA 0x00000000
+#define DDRSS_PHY_224_DATA 0x00000000
+#define DDRSS_PHY_225_DATA 0x00000000
+#define DDRSS_PHY_226_DATA 0x00000000
+#define DDRSS_PHY_227_DATA 0x00000000
+#define DDRSS_PHY_228_DATA 0x00000000
+#define DDRSS_PHY_229_DATA 0x00000000
+#define DDRSS_PHY_230_DATA 0x00000000
+#define DDRSS_PHY_231_DATA 0x00000000
+#define DDRSS_PHY_232_DATA 0x00000000
+#define DDRSS_PHY_233_DATA 0x00000000
+#define DDRSS_PHY_234_DATA 0x00000000
+#define DDRSS_PHY_235_DATA 0x00000000
+#define DDRSS_PHY_236_DATA 0x00000000
+#define DDRSS_PHY_237_DATA 0x00000000
+#define DDRSS_PHY_238_DATA 0x00000000
+#define DDRSS_PHY_239_DATA 0x00000000
+#define DDRSS_PHY_240_DATA 0x00000000
+#define DDRSS_PHY_241_DATA 0x00000000
+#define DDRSS_PHY_242_DATA 0x00000000
+#define DDRSS_PHY_243_DATA 0x00000000
+#define DDRSS_PHY_244_DATA 0x00000000
+#define DDRSS_PHY_245_DATA 0x00000000
+#define DDRSS_PHY_246_DATA 0x00000000
+#define DDRSS_PHY_247_DATA 0x00000000
+#define DDRSS_PHY_248_DATA 0x00000000
+#define DDRSS_PHY_249_DATA 0x00000000
+#define DDRSS_PHY_250_DATA 0x00000000
+#define DDRSS_PHY_251_DATA 0x00000000
+#define DDRSS_PHY_252_DATA 0x00000000
+#define DDRSS_PHY_253_DATA 0x00000000
+#define DDRSS_PHY_254_DATA 0x00000000
+#define DDRSS_PHY_255_DATA 0x00000000
+#define DDRSS_PHY_256_DATA 0x04F00000
+#define DDRSS_PHY_257_DATA 0x00000000
+#define DDRSS_PHY_258_DATA 0x00030200
+#define DDRSS_PHY_259_DATA 0x00000000
+#define DDRSS_PHY_260_DATA 0x00000000
+#define DDRSS_PHY_261_DATA 0x01000000
+#define DDRSS_PHY_262_DATA 0x03000400
+#define DDRSS_PHY_263_DATA 0x00000001
+#define DDRSS_PHY_264_DATA 0x00000001
+#define DDRSS_PHY_265_DATA 0x00000000
+#define DDRSS_PHY_266_DATA 0x00000000
+#define DDRSS_PHY_267_DATA 0x01010000
+#define DDRSS_PHY_268_DATA 0x00010000
+#define DDRSS_PHY_269_DATA 0x00C00001
+#define DDRSS_PHY_270_DATA 0x00CC0008
+#define DDRSS_PHY_271_DATA 0x00660601
+#define DDRSS_PHY_272_DATA 0x00000003
+#define DDRSS_PHY_273_DATA 0x00000000
+#define DDRSS_PHY_274_DATA 0x00000000
+#define DDRSS_PHY_275_DATA 0x0000AAAA
+#define DDRSS_PHY_276_DATA 0x00005555
+#define DDRSS_PHY_277_DATA 0x0000B5B5
+#define DDRSS_PHY_278_DATA 0x00004A4A
+#define DDRSS_PHY_279_DATA 0x00005656
+#define DDRSS_PHY_280_DATA 0x0000A9A9
+#define DDRSS_PHY_281_DATA 0x0000B7B7
+#define DDRSS_PHY_282_DATA 0x00004848
+#define DDRSS_PHY_283_DATA 0x00000000
+#define DDRSS_PHY_284_DATA 0x00000000
+#define DDRSS_PHY_285_DATA 0x08000000
+#define DDRSS_PHY_286_DATA 0x0F000008
+#define DDRSS_PHY_287_DATA 0x00000F0F
+#define DDRSS_PHY_288_DATA 0x00E4E400
+#define DDRSS_PHY_289_DATA 0x00071020
+#define DDRSS_PHY_290_DATA 0x000C0020
+#define DDRSS_PHY_291_DATA 0x00062000
+#define DDRSS_PHY_292_DATA 0x00000000
+#define DDRSS_PHY_293_DATA 0x55555555
+#define DDRSS_PHY_294_DATA 0xAAAAAAAA
+#define DDRSS_PHY_295_DATA 0x55555555
+#define DDRSS_PHY_296_DATA 0xAAAAAAAA
+#define DDRSS_PHY_297_DATA 0x00005555
+#define DDRSS_PHY_298_DATA 0x01000100
+#define DDRSS_PHY_299_DATA 0x00800180
+#define DDRSS_PHY_300_DATA 0x00000000
+#define DDRSS_PHY_301_DATA 0x00000000
+#define DDRSS_PHY_302_DATA 0x00000000
+#define DDRSS_PHY_303_DATA 0x00000000
+#define DDRSS_PHY_304_DATA 0x00000000
+#define DDRSS_PHY_305_DATA 0x00000000
+#define DDRSS_PHY_306_DATA 0x00000000
+#define DDRSS_PHY_307_DATA 0x00000000
+#define DDRSS_PHY_308_DATA 0x00000000
+#define DDRSS_PHY_309_DATA 0x00000000
+#define DDRSS_PHY_310_DATA 0x00000000
+#define DDRSS_PHY_311_DATA 0x00000000
+#define DDRSS_PHY_312_DATA 0x00000000
+#define DDRSS_PHY_313_DATA 0x00000000
+#define DDRSS_PHY_314_DATA 0x00000000
+#define DDRSS_PHY_315_DATA 0x00000000
+#define DDRSS_PHY_316_DATA 0x00000000
+#define DDRSS_PHY_317_DATA 0x00000000
+#define DDRSS_PHY_318_DATA 0x00000000
+#define DDRSS_PHY_319_DATA 0x00000000
+#define DDRSS_PHY_320_DATA 0x00000000
+#define DDRSS_PHY_321_DATA 0x00000004
+#define DDRSS_PHY_322_DATA 0x00000000
+#define DDRSS_PHY_323_DATA 0x00000000
+#define DDRSS_PHY_324_DATA 0x00000000
+#define DDRSS_PHY_325_DATA 0x00000000
+#define DDRSS_PHY_326_DATA 0x00000000
+#define DDRSS_PHY_327_DATA 0x00000000
+#define DDRSS_PHY_328_DATA 0x041F07FF
+#define DDRSS_PHY_329_DATA 0x00000000
+#define DDRSS_PHY_330_DATA 0x01CC0801
+#define DDRSS_PHY_331_DATA 0x1003CC08
+#define DDRSS_PHY_332_DATA 0x20000140
+#define DDRSS_PHY_333_DATA 0x07FF0200
+#define DDRSS_PHY_334_DATA 0x0000DD01
+#define DDRSS_PHY_335_DATA 0x00100303
+#define DDRSS_PHY_336_DATA 0x00000000
+#define DDRSS_PHY_337_DATA 0x00000000
+#define DDRSS_PHY_338_DATA 0x00021000
+#define DDRSS_PHY_339_DATA 0x00100010
+#define DDRSS_PHY_340_DATA 0x00100010
+#define DDRSS_PHY_341_DATA 0x00100010
+#define DDRSS_PHY_342_DATA 0x00100010
+#define DDRSS_PHY_343_DATA 0x02020010
+#define DDRSS_PHY_344_DATA 0x51516041
+#define DDRSS_PHY_345_DATA 0x31C06000
+#define DDRSS_PHY_346_DATA 0x07AB0340
+#define DDRSS_PHY_347_DATA 0x0000C0C0
+#define DDRSS_PHY_348_DATA 0x04050000
+#define DDRSS_PHY_349_DATA 0x00000504
+#define DDRSS_PHY_350_DATA 0x42100010
+#define DDRSS_PHY_351_DATA 0x010C053E
+#define DDRSS_PHY_352_DATA 0x000F0C1D
+#define DDRSS_PHY_353_DATA 0x01000140
+#define DDRSS_PHY_354_DATA 0x007A0120
+#define DDRSS_PHY_355_DATA 0x00000C00
+#define DDRSS_PHY_356_DATA 0x000001CC
+#define DDRSS_PHY_357_DATA 0x20100200
+#define DDRSS_PHY_358_DATA 0x00000005
+#define DDRSS_PHY_359_DATA 0x76543210
+#define DDRSS_PHY_360_DATA 0x00000008
+#define DDRSS_PHY_361_DATA 0x034C034C
+#define DDRSS_PHY_362_DATA 0x034C034C
+#define DDRSS_PHY_363_DATA 0x034C034C
+#define DDRSS_PHY_364_DATA 0x034C034C
+#define DDRSS_PHY_365_DATA 0x0000034C
+#define DDRSS_PHY_366_DATA 0x00008000
+#define DDRSS_PHY_367_DATA 0x00800080
+#define DDRSS_PHY_368_DATA 0x00800080
+#define DDRSS_PHY_369_DATA 0x00800080
+#define DDRSS_PHY_370_DATA 0x00800080
+#define DDRSS_PHY_371_DATA 0x00800080
+#define DDRSS_PHY_372_DATA 0x00800080
+#define DDRSS_PHY_373_DATA 0x00800080
+#define DDRSS_PHY_374_DATA 0x00800080
+#define DDRSS_PHY_375_DATA 0x01800080
+#define DDRSS_PHY_376_DATA 0x01000000
+#define DDRSS_PHY_377_DATA 0x00000000
+#define DDRSS_PHY_378_DATA 0x00000000
+#define DDRSS_PHY_379_DATA 0x00080200
+#define DDRSS_PHY_380_DATA 0x00000000
+#define DDRSS_PHY_381_DATA 0x0000F0F0
+#define DDRSS_PHY_382_DATA 0x00000000
+#define DDRSS_PHY_383_DATA 0x00000000
+#define DDRSS_PHY_384_DATA 0x00000000
+#define DDRSS_PHY_385_DATA 0x00000000
+#define DDRSS_PHY_386_DATA 0x00000000
+#define DDRSS_PHY_387_DATA 0x00000000
+#define DDRSS_PHY_388_DATA 0x00000000
+#define DDRSS_PHY_389_DATA 0x00000000
+#define DDRSS_PHY_390_DATA 0x00000000
+#define DDRSS_PHY_391_DATA 0x00000000
+#define DDRSS_PHY_392_DATA 0x00000000
+#define DDRSS_PHY_393_DATA 0x00000000
+#define DDRSS_PHY_394_DATA 0x00000000
+#define DDRSS_PHY_395_DATA 0x00000000
+#define DDRSS_PHY_396_DATA 0x00000000
+#define DDRSS_PHY_397_DATA 0x00000000
+#define DDRSS_PHY_398_DATA 0x00000000
+#define DDRSS_PHY_399_DATA 0x00000000
+#define DDRSS_PHY_400_DATA 0x00000000
+#define DDRSS_PHY_401_DATA 0x00000000
+#define DDRSS_PHY_402_DATA 0x00000000
+#define DDRSS_PHY_403_DATA 0x00000000
+#define DDRSS_PHY_404_DATA 0x00000000
+#define DDRSS_PHY_405_DATA 0x00000000
+#define DDRSS_PHY_406_DATA 0x00000000
+#define DDRSS_PHY_407_DATA 0x00000000
+#define DDRSS_PHY_408_DATA 0x00000000
+#define DDRSS_PHY_409_DATA 0x00000000
+#define DDRSS_PHY_410_DATA 0x00000000
+#define DDRSS_PHY_411_DATA 0x00000000
+#define DDRSS_PHY_412_DATA 0x00000000
+#define DDRSS_PHY_413_DATA 0x00000000
+#define DDRSS_PHY_414_DATA 0x00000000
+#define DDRSS_PHY_415_DATA 0x00000000
+#define DDRSS_PHY_416_DATA 0x00000000
+#define DDRSS_PHY_417_DATA 0x00000000
+#define DDRSS_PHY_418_DATA 0x00000000
+#define DDRSS_PHY_419_DATA 0x00000000
+#define DDRSS_PHY_420_DATA 0x00000000
+#define DDRSS_PHY_421_DATA 0x00000000
+#define DDRSS_PHY_422_DATA 0x00000000
+#define DDRSS_PHY_423_DATA 0x00000000
+#define DDRSS_PHY_424_DATA 0x00000000
+#define DDRSS_PHY_425_DATA 0x00000000
+#define DDRSS_PHY_426_DATA 0x00000000
+#define DDRSS_PHY_427_DATA 0x00000000
+#define DDRSS_PHY_428_DATA 0x00000000
+#define DDRSS_PHY_429_DATA 0x00000000
+#define DDRSS_PHY_430_DATA 0x00000000
+#define DDRSS_PHY_431_DATA 0x00000000
+#define DDRSS_PHY_432_DATA 0x00000000
+#define DDRSS_PHY_433_DATA 0x00000000
+#define DDRSS_PHY_434_DATA 0x00000000
+#define DDRSS_PHY_435_DATA 0x00000000
+#define DDRSS_PHY_436_DATA 0x00000000
+#define DDRSS_PHY_437_DATA 0x00000000
+#define DDRSS_PHY_438_DATA 0x00000000
+#define DDRSS_PHY_439_DATA 0x00000000
+#define DDRSS_PHY_440_DATA 0x00000000
+#define DDRSS_PHY_441_DATA 0x00000000
+#define DDRSS_PHY_442_DATA 0x00000000
+#define DDRSS_PHY_443_DATA 0x00000000
+#define DDRSS_PHY_444_DATA 0x00000000
+#define DDRSS_PHY_445_DATA 0x00000000
+#define DDRSS_PHY_446_DATA 0x00000000
+#define DDRSS_PHY_447_DATA 0x00000000
+#define DDRSS_PHY_448_DATA 0x00000000
+#define DDRSS_PHY_449_DATA 0x00000000
+#define DDRSS_PHY_450_DATA 0x00000000
+#define DDRSS_PHY_451_DATA 0x00000000
+#define DDRSS_PHY_452_DATA 0x00000000
+#define DDRSS_PHY_453_DATA 0x00000000
+#define DDRSS_PHY_454_DATA 0x00000000
+#define DDRSS_PHY_455_DATA 0x00000000
+#define DDRSS_PHY_456_DATA 0x00000000
+#define DDRSS_PHY_457_DATA 0x00000000
+#define DDRSS_PHY_458_DATA 0x00000000
+#define DDRSS_PHY_459_DATA 0x00000000
+#define DDRSS_PHY_460_DATA 0x00000000
+#define DDRSS_PHY_461_DATA 0x00000000
+#define DDRSS_PHY_462_DATA 0x00000000
+#define DDRSS_PHY_463_DATA 0x00000000
+#define DDRSS_PHY_464_DATA 0x00000000
+#define DDRSS_PHY_465_DATA 0x00000000
+#define DDRSS_PHY_466_DATA 0x00000000
+#define DDRSS_PHY_467_DATA 0x00000000
+#define DDRSS_PHY_468_DATA 0x00000000
+#define DDRSS_PHY_469_DATA 0x00000000
+#define DDRSS_PHY_470_DATA 0x00000000
+#define DDRSS_PHY_471_DATA 0x00000000
+#define DDRSS_PHY_472_DATA 0x00000000
+#define DDRSS_PHY_473_DATA 0x00000000
+#define DDRSS_PHY_474_DATA 0x00000000
+#define DDRSS_PHY_475_DATA 0x00000000
+#define DDRSS_PHY_476_DATA 0x00000000
+#define DDRSS_PHY_477_DATA 0x00000000
+#define DDRSS_PHY_478_DATA 0x00000000
+#define DDRSS_PHY_479_DATA 0x00000000
+#define DDRSS_PHY_480_DATA 0x00000000
+#define DDRSS_PHY_481_DATA 0x00000000
+#define DDRSS_PHY_482_DATA 0x00000000
+#define DDRSS_PHY_483_DATA 0x00000000
+#define DDRSS_PHY_484_DATA 0x00000000
+#define DDRSS_PHY_485_DATA 0x00000000
+#define DDRSS_PHY_486_DATA 0x00000000
+#define DDRSS_PHY_487_DATA 0x00000000
+#define DDRSS_PHY_488_DATA 0x00000000
+#define DDRSS_PHY_489_DATA 0x00000000
+#define DDRSS_PHY_490_DATA 0x00000000
+#define DDRSS_PHY_491_DATA 0x00000000
+#define DDRSS_PHY_492_DATA 0x00000000
+#define DDRSS_PHY_493_DATA 0x00000000
+#define DDRSS_PHY_494_DATA 0x00000000
+#define DDRSS_PHY_495_DATA 0x00000000
+#define DDRSS_PHY_496_DATA 0x00000000
+#define DDRSS_PHY_497_DATA 0x00000000
+#define DDRSS_PHY_498_DATA 0x00000000
+#define DDRSS_PHY_499_DATA 0x00000000
+#define DDRSS_PHY_500_DATA 0x00000000
+#define DDRSS_PHY_501_DATA 0x00000000
+#define DDRSS_PHY_502_DATA 0x00000000
+#define DDRSS_PHY_503_DATA 0x00000000
+#define DDRSS_PHY_504_DATA 0x00000000
+#define DDRSS_PHY_505_DATA 0x00000000
+#define DDRSS_PHY_506_DATA 0x00000000
+#define DDRSS_PHY_507_DATA 0x00000000
+#define DDRSS_PHY_508_DATA 0x00000000
+#define DDRSS_PHY_509_DATA 0x00000000
+#define DDRSS_PHY_510_DATA 0x00000000
+#define DDRSS_PHY_511_DATA 0x00000000
+#define DDRSS_PHY_512_DATA 0x00000000
+#define DDRSS_PHY_513_DATA 0x00000000
+#define DDRSS_PHY_514_DATA 0x00000000
+#define DDRSS_PHY_515_DATA 0x00000000
+#define DDRSS_PHY_516_DATA 0x00000000
+#define DDRSS_PHY_517_DATA 0x00000100
+#define DDRSS_PHY_518_DATA 0x00000200
+#define DDRSS_PHY_519_DATA 0x00000000
+#define DDRSS_PHY_520_DATA 0x00000000
+#define DDRSS_PHY_521_DATA 0x00000000
+#define DDRSS_PHY_522_DATA 0x00000000
+#define DDRSS_PHY_523_DATA 0x00400000
+#define DDRSS_PHY_524_DATA 0x00000080
+#define DDRSS_PHY_525_DATA 0x00DCBA98
+#define DDRSS_PHY_526_DATA 0x03000000
+#define DDRSS_PHY_527_DATA 0x00200000
+#define DDRSS_PHY_528_DATA 0x00000000
+#define DDRSS_PHY_529_DATA 0x00000000
+#define DDRSS_PHY_530_DATA 0x00000000
+#define DDRSS_PHY_531_DATA 0x00000000
+#define DDRSS_PHY_532_DATA 0x0000002A
+#define DDRSS_PHY_533_DATA 0x00000015
+#define DDRSS_PHY_534_DATA 0x00000015
+#define DDRSS_PHY_535_DATA 0x0000002A
+#define DDRSS_PHY_536_DATA 0x00000033
+#define DDRSS_PHY_537_DATA 0x0000000C
+#define DDRSS_PHY_538_DATA 0x0000000C
+#define DDRSS_PHY_539_DATA 0x00000033
+#define DDRSS_PHY_540_DATA 0x0A418820
+#define DDRSS_PHY_541_DATA 0x003F0000
+#define DDRSS_PHY_542_DATA 0x000F013F
+#define DDRSS_PHY_543_DATA 0x0000000F
+#define DDRSS_PHY_544_DATA 0x020002CC
+#define DDRSS_PHY_545_DATA 0x00030000
+#define DDRSS_PHY_546_DATA 0x00000300
+#define DDRSS_PHY_547_DATA 0x00000300
+#define DDRSS_PHY_548_DATA 0x00000300
+#define DDRSS_PHY_549_DATA 0x00000300
+#define DDRSS_PHY_550_DATA 0x00000300
+#define DDRSS_PHY_551_DATA 0x42080010
+#define DDRSS_PHY_552_DATA 0x0000803E
+#define DDRSS_PHY_553_DATA 0x00000003
+#define DDRSS_PHY_554_DATA 0x00000002
+#define DDRSS_PHY_555_DATA 0x00000000
+#define DDRSS_PHY_556_DATA 0x00000000
+#define DDRSS_PHY_557_DATA 0x00000000
+#define DDRSS_PHY_558_DATA 0x00000000
+#define DDRSS_PHY_559_DATA 0x00000000
+#define DDRSS_PHY_560_DATA 0x00000000
+#define DDRSS_PHY_561_DATA 0x00000000
+#define DDRSS_PHY_562_DATA 0x00000000
+#define DDRSS_PHY_563_DATA 0x00000000
+#define DDRSS_PHY_564_DATA 0x00000000
+#define DDRSS_PHY_565_DATA 0x00000000
+#define DDRSS_PHY_566_DATA 0x00000000
+#define DDRSS_PHY_567_DATA 0x00000000
+#define DDRSS_PHY_568_DATA 0x00000000
+#define DDRSS_PHY_569_DATA 0x00000000
+#define DDRSS_PHY_570_DATA 0x00000000
+#define DDRSS_PHY_571_DATA 0x00000000
+#define DDRSS_PHY_572_DATA 0x00000000
+#define DDRSS_PHY_573_DATA 0x00000000
+#define DDRSS_PHY_574_DATA 0x00000000
+#define DDRSS_PHY_575_DATA 0x00000000
+#define DDRSS_PHY_576_DATA 0x00000000
+#define DDRSS_PHY_577_DATA 0x00000000
+#define DDRSS_PHY_578_DATA 0x00000000
+#define DDRSS_PHY_579_DATA 0x00000000
+#define DDRSS_PHY_580_DATA 0x00000000
+#define DDRSS_PHY_581_DATA 0x00000000
+#define DDRSS_PHY_582_DATA 0x00000000
+#define DDRSS_PHY_583_DATA 0x00000000
+#define DDRSS_PHY_584_DATA 0x00000000
+#define DDRSS_PHY_585_DATA 0x00000000
+#define DDRSS_PHY_586_DATA 0x00000000
+#define DDRSS_PHY_587_DATA 0x00000000
+#define DDRSS_PHY_588_DATA 0x00000000
+#define DDRSS_PHY_589_DATA 0x00000000
+#define DDRSS_PHY_590_DATA 0x00000000
+#define DDRSS_PHY_591_DATA 0x00000000
+#define DDRSS_PHY_592_DATA 0x00000000
+#define DDRSS_PHY_593_DATA 0x00000000
+#define DDRSS_PHY_594_DATA 0x00000000
+#define DDRSS_PHY_595_DATA 0x00000000
+#define DDRSS_PHY_596_DATA 0x00000000
+#define DDRSS_PHY_597_DATA 0x00000000
+#define DDRSS_PHY_598_DATA 0x00000000
+#define DDRSS_PHY_599_DATA 0x00000000
+#define DDRSS_PHY_600_DATA 0x00000000
+#define DDRSS_PHY_601_DATA 0x00000000
+#define DDRSS_PHY_602_DATA 0x00000000
+#define DDRSS_PHY_603_DATA 0x00000000
+#define DDRSS_PHY_604_DATA 0x00000000
+#define DDRSS_PHY_605_DATA 0x00000000
+#define DDRSS_PHY_606_DATA 0x00000000
+#define DDRSS_PHY_607_DATA 0x00000000
+#define DDRSS_PHY_608_DATA 0x00000000
+#define DDRSS_PHY_609_DATA 0x00000000
+#define DDRSS_PHY_610_DATA 0x00000000
+#define DDRSS_PHY_611_DATA 0x00000000
+#define DDRSS_PHY_612_DATA 0x00000000
+#define DDRSS_PHY_613_DATA 0x00000000
+#define DDRSS_PHY_614_DATA 0x00000000
+#define DDRSS_PHY_615_DATA 0x00000000
+#define DDRSS_PHY_616_DATA 0x00000000
+#define DDRSS_PHY_617_DATA 0x00000000
+#define DDRSS_PHY_618_DATA 0x00000000
+#define DDRSS_PHY_619_DATA 0x00000000
+#define DDRSS_PHY_620_DATA 0x00000000
+#define DDRSS_PHY_621_DATA 0x00000000
+#define DDRSS_PHY_622_DATA 0x00000000
+#define DDRSS_PHY_623_DATA 0x00000000
+#define DDRSS_PHY_624_DATA 0x00000000
+#define DDRSS_PHY_625_DATA 0x00000000
+#define DDRSS_PHY_626_DATA 0x00000000
+#define DDRSS_PHY_627_DATA 0x00000000
+#define DDRSS_PHY_628_DATA 0x00000000
+#define DDRSS_PHY_629_DATA 0x00000000
+#define DDRSS_PHY_630_DATA 0x00000000
+#define DDRSS_PHY_631_DATA 0x00000000
+#define DDRSS_PHY_632_DATA 0x00000000
+#define DDRSS_PHY_633_DATA 0x00000000
+#define DDRSS_PHY_634_DATA 0x00000000
+#define DDRSS_PHY_635_DATA 0x00000000
+#define DDRSS_PHY_636_DATA 0x00000000
+#define DDRSS_PHY_637_DATA 0x00000000
+#define DDRSS_PHY_638_DATA 0x00000000
+#define DDRSS_PHY_639_DATA 0x00000000
+#define DDRSS_PHY_640_DATA 0x00000000
+#define DDRSS_PHY_641_DATA 0x00000000
+#define DDRSS_PHY_642_DATA 0x00000000
+#define DDRSS_PHY_643_DATA 0x00000000
+#define DDRSS_PHY_644_DATA 0x00000000
+#define DDRSS_PHY_645_DATA 0x00000000
+#define DDRSS_PHY_646_DATA 0x00000000
+#define DDRSS_PHY_647_DATA 0x00000000
+#define DDRSS_PHY_648_DATA 0x00000000
+#define DDRSS_PHY_649_DATA 0x00000000
+#define DDRSS_PHY_650_DATA 0x00000000
+#define DDRSS_PHY_651_DATA 0x00000000
+#define DDRSS_PHY_652_DATA 0x00000000
+#define DDRSS_PHY_653_DATA 0x00000000
+#define DDRSS_PHY_654_DATA 0x00000000
+#define DDRSS_PHY_655_DATA 0x00000000
+#define DDRSS_PHY_656_DATA 0x00000000
+#define DDRSS_PHY_657_DATA 0x00000000
+#define DDRSS_PHY_658_DATA 0x00000000
+#define DDRSS_PHY_659_DATA 0x00000000
+#define DDRSS_PHY_660_DATA 0x00000000
+#define DDRSS_PHY_661_DATA 0x00000000
+#define DDRSS_PHY_662_DATA 0x00000000
+#define DDRSS_PHY_663_DATA 0x00000000
+#define DDRSS_PHY_664_DATA 0x00000000
+#define DDRSS_PHY_665_DATA 0x00000000
+#define DDRSS_PHY_666_DATA 0x00000000
+#define DDRSS_PHY_667_DATA 0x00000000
+#define DDRSS_PHY_668_DATA 0x00000000
+#define DDRSS_PHY_669_DATA 0x00000000
+#define DDRSS_PHY_670_DATA 0x00000000
+#define DDRSS_PHY_671_DATA 0x00000000
+#define DDRSS_PHY_672_DATA 0x00000000
+#define DDRSS_PHY_673_DATA 0x00000000
+#define DDRSS_PHY_674_DATA 0x00000000
+#define DDRSS_PHY_675_DATA 0x00000000
+#define DDRSS_PHY_676_DATA 0x00000000
+#define DDRSS_PHY_677_DATA 0x00000000
+#define DDRSS_PHY_678_DATA 0x00000000
+#define DDRSS_PHY_679_DATA 0x00000000
+#define DDRSS_PHY_680_DATA 0x00000000
+#define DDRSS_PHY_681_DATA 0x00000000
+#define DDRSS_PHY_682_DATA 0x00000000
+#define DDRSS_PHY_683_DATA 0x00000000
+#define DDRSS_PHY_684_DATA 0x00000000
+#define DDRSS_PHY_685_DATA 0x00000000
+#define DDRSS_PHY_686_DATA 0x00000000
+#define DDRSS_PHY_687_DATA 0x00000000
+#define DDRSS_PHY_688_DATA 0x00000000
+#define DDRSS_PHY_689_DATA 0x00000000
+#define DDRSS_PHY_690_DATA 0x00000000
+#define DDRSS_PHY_691_DATA 0x00000000
+#define DDRSS_PHY_692_DATA 0x00000000
+#define DDRSS_PHY_693_DATA 0x00000000
+#define DDRSS_PHY_694_DATA 0x00000000
+#define DDRSS_PHY_695_DATA 0x00000000
+#define DDRSS_PHY_696_DATA 0x00000000
+#define DDRSS_PHY_697_DATA 0x00000000
+#define DDRSS_PHY_698_DATA 0x00000000
+#define DDRSS_PHY_699_DATA 0x00000000
+#define DDRSS_PHY_700_DATA 0x00000000
+#define DDRSS_PHY_701_DATA 0x00000000
+#define DDRSS_PHY_702_DATA 0x00000000
+#define DDRSS_PHY_703_DATA 0x00000000
+#define DDRSS_PHY_704_DATA 0x00000000
+#define DDRSS_PHY_705_DATA 0x00000000
+#define DDRSS_PHY_706_DATA 0x00000000
+#define DDRSS_PHY_707_DATA 0x00000000
+#define DDRSS_PHY_708_DATA 0x00000000
+#define DDRSS_PHY_709_DATA 0x00000000
+#define DDRSS_PHY_710_DATA 0x00000000
+#define DDRSS_PHY_711_DATA 0x00000000
+#define DDRSS_PHY_712_DATA 0x00000000
+#define DDRSS_PHY_713_DATA 0x00000000
+#define DDRSS_PHY_714_DATA 0x00000000
+#define DDRSS_PHY_715_DATA 0x00000000
+#define DDRSS_PHY_716_DATA 0x00000000
+#define DDRSS_PHY_717_DATA 0x00000000
+#define DDRSS_PHY_718_DATA 0x00000000
+#define DDRSS_PHY_719_DATA 0x00000000
+#define DDRSS_PHY_720_DATA 0x00000000
+#define DDRSS_PHY_721_DATA 0x00000000
+#define DDRSS_PHY_722_DATA 0x00000000
+#define DDRSS_PHY_723_DATA 0x00000000
+#define DDRSS_PHY_724_DATA 0x00000000
+#define DDRSS_PHY_725_DATA 0x00000000
+#define DDRSS_PHY_726_DATA 0x00000000
+#define DDRSS_PHY_727_DATA 0x00000000
+#define DDRSS_PHY_728_DATA 0x00000000
+#define DDRSS_PHY_729_DATA 0x00000000
+#define DDRSS_PHY_730_DATA 0x00000000
+#define DDRSS_PHY_731_DATA 0x00000000
+#define DDRSS_PHY_732_DATA 0x00000000
+#define DDRSS_PHY_733_DATA 0x00000000
+#define DDRSS_PHY_734_DATA 0x00000000
+#define DDRSS_PHY_735_DATA 0x00000000
+#define DDRSS_PHY_736_DATA 0x00000000
+#define DDRSS_PHY_737_DATA 0x00000000
+#define DDRSS_PHY_738_DATA 0x00000000
+#define DDRSS_PHY_739_DATA 0x00000000
+#define DDRSS_PHY_740_DATA 0x00000000
+#define DDRSS_PHY_741_DATA 0x00000000
+#define DDRSS_PHY_742_DATA 0x00000000
+#define DDRSS_PHY_743_DATA 0x00000000
+#define DDRSS_PHY_744_DATA 0x00000000
+#define DDRSS_PHY_745_DATA 0x00000000
+#define DDRSS_PHY_746_DATA 0x00000000
+#define DDRSS_PHY_747_DATA 0x00000000
+#define DDRSS_PHY_748_DATA 0x00000000
+#define DDRSS_PHY_749_DATA 0x00000000
+#define DDRSS_PHY_750_DATA 0x00000000
+#define DDRSS_PHY_751_DATA 0x00000000
+#define DDRSS_PHY_752_DATA 0x00000000
+#define DDRSS_PHY_753_DATA 0x00000000
+#define DDRSS_PHY_754_DATA 0x00000000
+#define DDRSS_PHY_755_DATA 0x00000000
+#define DDRSS_PHY_756_DATA 0x00000000
+#define DDRSS_PHY_757_DATA 0x00000000
+#define DDRSS_PHY_758_DATA 0x00000000
+#define DDRSS_PHY_759_DATA 0x00000000
+#define DDRSS_PHY_760_DATA 0x00000000
+#define DDRSS_PHY_761_DATA 0x00000000
+#define DDRSS_PHY_762_DATA 0x00000000
+#define DDRSS_PHY_763_DATA 0x00000000
+#define DDRSS_PHY_764_DATA 0x00000000
+#define DDRSS_PHY_765_DATA 0x00000000
+#define DDRSS_PHY_766_DATA 0x00000000
+#define DDRSS_PHY_767_DATA 0x00000000
+#define DDRSS_PHY_768_DATA 0x00000000
+#define DDRSS_PHY_769_DATA 0x00000000
+#define DDRSS_PHY_770_DATA 0x00000000
+#define DDRSS_PHY_771_DATA 0x00000000
+#define DDRSS_PHY_772_DATA 0x00000000
+#define DDRSS_PHY_773_DATA 0x00000100
+#define DDRSS_PHY_774_DATA 0x00000200
+#define DDRSS_PHY_775_DATA 0x00000000
+#define DDRSS_PHY_776_DATA 0x00000000
+#define DDRSS_PHY_777_DATA 0x00000000
+#define DDRSS_PHY_778_DATA 0x00000000
+#define DDRSS_PHY_779_DATA 0x00400000
+#define DDRSS_PHY_780_DATA 0x00000080
+#define DDRSS_PHY_781_DATA 0x00DCBA98
+#define DDRSS_PHY_782_DATA 0x03000000
+#define DDRSS_PHY_783_DATA 0x00200000
+#define DDRSS_PHY_784_DATA 0x00000000
+#define DDRSS_PHY_785_DATA 0x00000000
+#define DDRSS_PHY_786_DATA 0x00000000
+#define DDRSS_PHY_787_DATA 0x00000000
+#define DDRSS_PHY_788_DATA 0x0000002A
+#define DDRSS_PHY_789_DATA 0x00000015
+#define DDRSS_PHY_790_DATA 0x00000015
+#define DDRSS_PHY_791_DATA 0x0000002A
+#define DDRSS_PHY_792_DATA 0x00000033
+#define DDRSS_PHY_793_DATA 0x0000000C
+#define DDRSS_PHY_794_DATA 0x0000000C
+#define DDRSS_PHY_795_DATA 0x00000033
+#define DDRSS_PHY_796_DATA 0x00000000
+#define DDRSS_PHY_797_DATA 0x00000000
+#define DDRSS_PHY_798_DATA 0x000F0000
+#define DDRSS_PHY_799_DATA 0x0000000F
+#define DDRSS_PHY_800_DATA 0x020002CC
+#define DDRSS_PHY_801_DATA 0x00030000
+#define DDRSS_PHY_802_DATA 0x00000300
+#define DDRSS_PHY_803_DATA 0x00000300
+#define DDRSS_PHY_804_DATA 0x00000300
+#define DDRSS_PHY_805_DATA 0x00000300
+#define DDRSS_PHY_806_DATA 0x00000300
+#define DDRSS_PHY_807_DATA 0x42080010
+#define DDRSS_PHY_808_DATA 0x0000803E
+#define DDRSS_PHY_809_DATA 0x00000003
+#define DDRSS_PHY_810_DATA 0x00000002
+#define DDRSS_PHY_811_DATA 0x00000000
+#define DDRSS_PHY_812_DATA 0x00000000
+#define DDRSS_PHY_813_DATA 0x00000000
+#define DDRSS_PHY_814_DATA 0x00000000
+#define DDRSS_PHY_815_DATA 0x00000000
+#define DDRSS_PHY_816_DATA 0x00000000
+#define DDRSS_PHY_817_DATA 0x00000000
+#define DDRSS_PHY_818_DATA 0x00000000
+#define DDRSS_PHY_819_DATA 0x00000000
+#define DDRSS_PHY_820_DATA 0x00000000
+#define DDRSS_PHY_821_DATA 0x00000000
+#define DDRSS_PHY_822_DATA 0x00000000
+#define DDRSS_PHY_823_DATA 0x00000000
+#define DDRSS_PHY_824_DATA 0x00000000
+#define DDRSS_PHY_825_DATA 0x00000000
+#define DDRSS_PHY_826_DATA 0x00000000
+#define DDRSS_PHY_827_DATA 0x00000000
+#define DDRSS_PHY_828_DATA 0x00000000
+#define DDRSS_PHY_829_DATA 0x00000000
+#define DDRSS_PHY_830_DATA 0x00000000
+#define DDRSS_PHY_831_DATA 0x00000000
+#define DDRSS_PHY_832_DATA 0x00000000
+#define DDRSS_PHY_833_DATA 0x00000000
+#define DDRSS_PHY_834_DATA 0x00000000
+#define DDRSS_PHY_835_DATA 0x00000000
+#define DDRSS_PHY_836_DATA 0x00000000
+#define DDRSS_PHY_837_DATA 0x00000000
+#define DDRSS_PHY_838_DATA 0x00000000
+#define DDRSS_PHY_839_DATA 0x00000000
+#define DDRSS_PHY_840_DATA 0x00000000
+#define DDRSS_PHY_841_DATA 0x00000000
+#define DDRSS_PHY_842_DATA 0x00000000
+#define DDRSS_PHY_843_DATA 0x00000000
+#define DDRSS_PHY_844_DATA 0x00000000
+#define DDRSS_PHY_845_DATA 0x00000000
+#define DDRSS_PHY_846_DATA 0x00000000
+#define DDRSS_PHY_847_DATA 0x00000000
+#define DDRSS_PHY_848_DATA 0x00000000
+#define DDRSS_PHY_849_DATA 0x00000000
+#define DDRSS_PHY_850_DATA 0x00000000
+#define DDRSS_PHY_851_DATA 0x00000000
+#define DDRSS_PHY_852_DATA 0x00000000
+#define DDRSS_PHY_853_DATA 0x00000000
+#define DDRSS_PHY_854_DATA 0x00000000
+#define DDRSS_PHY_855_DATA 0x00000000
+#define DDRSS_PHY_856_DATA 0x00000000
+#define DDRSS_PHY_857_DATA 0x00000000
+#define DDRSS_PHY_858_DATA 0x00000000
+#define DDRSS_PHY_859_DATA 0x00000000
+#define DDRSS_PHY_860_DATA 0x00000000
+#define DDRSS_PHY_861_DATA 0x00000000
+#define DDRSS_PHY_862_DATA 0x00000000
+#define DDRSS_PHY_863_DATA 0x00000000
+#define DDRSS_PHY_864_DATA 0x00000000
+#define DDRSS_PHY_865_DATA 0x00000000
+#define DDRSS_PHY_866_DATA 0x00000000
+#define DDRSS_PHY_867_DATA 0x00000000
+#define DDRSS_PHY_868_DATA 0x00000000
+#define DDRSS_PHY_869_DATA 0x00000000
+#define DDRSS_PHY_870_DATA 0x00000000
+#define DDRSS_PHY_871_DATA 0x00000000
+#define DDRSS_PHY_872_DATA 0x00000000
+#define DDRSS_PHY_873_DATA 0x00000000
+#define DDRSS_PHY_874_DATA 0x00000000
+#define DDRSS_PHY_875_DATA 0x00000000
+#define DDRSS_PHY_876_DATA 0x00000000
+#define DDRSS_PHY_877_DATA 0x00000000
+#define DDRSS_PHY_878_DATA 0x00000000
+#define DDRSS_PHY_879_DATA 0x00000000
+#define DDRSS_PHY_880_DATA 0x00000000
+#define DDRSS_PHY_881_DATA 0x00000000
+#define DDRSS_PHY_882_DATA 0x00000000
+#define DDRSS_PHY_883_DATA 0x00000000
+#define DDRSS_PHY_884_DATA 0x00000000
+#define DDRSS_PHY_885_DATA 0x00000000
+#define DDRSS_PHY_886_DATA 0x00000000
+#define DDRSS_PHY_887_DATA 0x00000000
+#define DDRSS_PHY_888_DATA 0x00000000
+#define DDRSS_PHY_889_DATA 0x00000000
+#define DDRSS_PHY_890_DATA 0x00000000
+#define DDRSS_PHY_891_DATA 0x00000000
+#define DDRSS_PHY_892_DATA 0x00000000
+#define DDRSS_PHY_893_DATA 0x00000000
+#define DDRSS_PHY_894_DATA 0x00000000
+#define DDRSS_PHY_895_DATA 0x00000000
+#define DDRSS_PHY_896_DATA 0x00000000
+#define DDRSS_PHY_897_DATA 0x00000000
+#define DDRSS_PHY_898_DATA 0x00000000
+#define DDRSS_PHY_899_DATA 0x00000000
+#define DDRSS_PHY_900_DATA 0x00000000
+#define DDRSS_PHY_901_DATA 0x00000000
+#define DDRSS_PHY_902_DATA 0x00000000
+#define DDRSS_PHY_903_DATA 0x00000000
+#define DDRSS_PHY_904_DATA 0x00000000
+#define DDRSS_PHY_905_DATA 0x00000000
+#define DDRSS_PHY_906_DATA 0x00000000
+#define DDRSS_PHY_907_DATA 0x00000000
+#define DDRSS_PHY_908_DATA 0x00000000
+#define DDRSS_PHY_909_DATA 0x00000000
+#define DDRSS_PHY_910_DATA 0x00000000
+#define DDRSS_PHY_911_DATA 0x00000000
+#define DDRSS_PHY_912_DATA 0x00000000
+#define DDRSS_PHY_913_DATA 0x00000000
+#define DDRSS_PHY_914_DATA 0x00000000
+#define DDRSS_PHY_915_DATA 0x00000000
+#define DDRSS_PHY_916_DATA 0x00000000
+#define DDRSS_PHY_917_DATA 0x00000000
+#define DDRSS_PHY_918_DATA 0x00000000
+#define DDRSS_PHY_919_DATA 0x00000000
+#define DDRSS_PHY_920_DATA 0x00000000
+#define DDRSS_PHY_921_DATA 0x00000000
+#define DDRSS_PHY_922_DATA 0x00000000
+#define DDRSS_PHY_923_DATA 0x00000000
+#define DDRSS_PHY_924_DATA 0x00000000
+#define DDRSS_PHY_925_DATA 0x00000000
+#define DDRSS_PHY_926_DATA 0x00000000
+#define DDRSS_PHY_927_DATA 0x00000000
+#define DDRSS_PHY_928_DATA 0x00000000
+#define DDRSS_PHY_929_DATA 0x00000000
+#define DDRSS_PHY_930_DATA 0x00000000
+#define DDRSS_PHY_931_DATA 0x00000000
+#define DDRSS_PHY_932_DATA 0x00000000
+#define DDRSS_PHY_933_DATA 0x00000000
+#define DDRSS_PHY_934_DATA 0x00000000
+#define DDRSS_PHY_935_DATA 0x00000000
+#define DDRSS_PHY_936_DATA 0x00000000
+#define DDRSS_PHY_937_DATA 0x00000000
+#define DDRSS_PHY_938_DATA 0x00000000
+#define DDRSS_PHY_939_DATA 0x00000000
+#define DDRSS_PHY_940_DATA 0x00000000
+#define DDRSS_PHY_941_DATA 0x00000000
+#define DDRSS_PHY_942_DATA 0x00000000
+#define DDRSS_PHY_943_DATA 0x00000000
+#define DDRSS_PHY_944_DATA 0x00000000
+#define DDRSS_PHY_945_DATA 0x00000000
+#define DDRSS_PHY_946_DATA 0x00000000
+#define DDRSS_PHY_947_DATA 0x00000000
+#define DDRSS_PHY_948_DATA 0x00000000
+#define DDRSS_PHY_949_DATA 0x00000000
+#define DDRSS_PHY_950_DATA 0x00000000
+#define DDRSS_PHY_951_DATA 0x00000000
+#define DDRSS_PHY_952_DATA 0x00000000
+#define DDRSS_PHY_953_DATA 0x00000000
+#define DDRSS_PHY_954_DATA 0x00000000
+#define DDRSS_PHY_955_DATA 0x00000000
+#define DDRSS_PHY_956_DATA 0x00000000
+#define DDRSS_PHY_957_DATA 0x00000000
+#define DDRSS_PHY_958_DATA 0x00000000
+#define DDRSS_PHY_959_DATA 0x00000000
+#define DDRSS_PHY_960_DATA 0x00000000
+#define DDRSS_PHY_961_DATA 0x00000000
+#define DDRSS_PHY_962_DATA 0x00000000
+#define DDRSS_PHY_963_DATA 0x00000000
+#define DDRSS_PHY_964_DATA 0x00000000
+#define DDRSS_PHY_965_DATA 0x00000000
+#define DDRSS_PHY_966_DATA 0x00000000
+#define DDRSS_PHY_967_DATA 0x00000000
+#define DDRSS_PHY_968_DATA 0x00000000
+#define DDRSS_PHY_969_DATA 0x00000000
+#define DDRSS_PHY_970_DATA 0x00000000
+#define DDRSS_PHY_971_DATA 0x00000000
+#define DDRSS_PHY_972_DATA 0x00000000
+#define DDRSS_PHY_973_DATA 0x00000000
+#define DDRSS_PHY_974_DATA 0x00000000
+#define DDRSS_PHY_975_DATA 0x00000000
+#define DDRSS_PHY_976_DATA 0x00000000
+#define DDRSS_PHY_977_DATA 0x00000000
+#define DDRSS_PHY_978_DATA 0x00000000
+#define DDRSS_PHY_979_DATA 0x00000000
+#define DDRSS_PHY_980_DATA 0x00000000
+#define DDRSS_PHY_981_DATA 0x00000000
+#define DDRSS_PHY_982_DATA 0x00000000
+#define DDRSS_PHY_983_DATA 0x00000000
+#define DDRSS_PHY_984_DATA 0x00000000
+#define DDRSS_PHY_985_DATA 0x00000000
+#define DDRSS_PHY_986_DATA 0x00000000
+#define DDRSS_PHY_987_DATA 0x00000000
+#define DDRSS_PHY_988_DATA 0x00000000
+#define DDRSS_PHY_989_DATA 0x00000000
+#define DDRSS_PHY_990_DATA 0x00000000
+#define DDRSS_PHY_991_DATA 0x00000000
+#define DDRSS_PHY_992_DATA 0x00000000
+#define DDRSS_PHY_993_DATA 0x00000000
+#define DDRSS_PHY_994_DATA 0x00000000
+#define DDRSS_PHY_995_DATA 0x00000000
+#define DDRSS_PHY_996_DATA 0x00000000
+#define DDRSS_PHY_997_DATA 0x00000000
+#define DDRSS_PHY_998_DATA 0x00000000
+#define DDRSS_PHY_999_DATA 0x00000000
+#define DDRSS_PHY_1000_DATA 0x00000000
+#define DDRSS_PHY_1001_DATA 0x00000000
+#define DDRSS_PHY_1002_DATA 0x00000000
+#define DDRSS_PHY_1003_DATA 0x00000000
+#define DDRSS_PHY_1004_DATA 0x00000000
+#define DDRSS_PHY_1005_DATA 0x00000000
+#define DDRSS_PHY_1006_DATA 0x00000000
+#define DDRSS_PHY_1007_DATA 0x00000000
+#define DDRSS_PHY_1008_DATA 0x00000000
+#define DDRSS_PHY_1009_DATA 0x00000000
+#define DDRSS_PHY_1010_DATA 0x00000000
+#define DDRSS_PHY_1011_DATA 0x00000000
+#define DDRSS_PHY_1012_DATA 0x00000000
+#define DDRSS_PHY_1013_DATA 0x00000000
+#define DDRSS_PHY_1014_DATA 0x00000000
+#define DDRSS_PHY_1015_DATA 0x00000000
+#define DDRSS_PHY_1016_DATA 0x00000000
+#define DDRSS_PHY_1017_DATA 0x00000000
+#define DDRSS_PHY_1018_DATA 0x00000000
+#define DDRSS_PHY_1019_DATA 0x00000000
+#define DDRSS_PHY_1020_DATA 0x00000000
+#define DDRSS_PHY_1021_DATA 0x00000000
+#define DDRSS_PHY_1022_DATA 0x00000000
+#define DDRSS_PHY_1023_DATA 0x00000000
+#define DDRSS_PHY_1024_DATA 0x00000000
+#define DDRSS_PHY_1025_DATA 0x00000000
+#define DDRSS_PHY_1026_DATA 0x00000000
+#define DDRSS_PHY_1027_DATA 0x00000000
+#define DDRSS_PHY_1028_DATA 0x00000000
+#define DDRSS_PHY_1029_DATA 0x00000100
+#define DDRSS_PHY_1030_DATA 0x00000200
+#define DDRSS_PHY_1031_DATA 0x00000000
+#define DDRSS_PHY_1032_DATA 0x00000000
+#define DDRSS_PHY_1033_DATA 0x00000000
+#define DDRSS_PHY_1034_DATA 0x00000000
+#define DDRSS_PHY_1035_DATA 0x00400000
+#define DDRSS_PHY_1036_DATA 0x00000080
+#define DDRSS_PHY_1037_DATA 0x00DCBA98
+#define DDRSS_PHY_1038_DATA 0x03000000
+#define DDRSS_PHY_1039_DATA 0x00200000
+#define DDRSS_PHY_1040_DATA 0x00000000
+#define DDRSS_PHY_1041_DATA 0x00000000
+#define DDRSS_PHY_1042_DATA 0x00000000
+#define DDRSS_PHY_1043_DATA 0x00000000
+#define DDRSS_PHY_1044_DATA 0x0000002A
+#define DDRSS_PHY_1045_DATA 0x00000015
+#define DDRSS_PHY_1046_DATA 0x00000015
+#define DDRSS_PHY_1047_DATA 0x0000002A
+#define DDRSS_PHY_1048_DATA 0x00000033
+#define DDRSS_PHY_1049_DATA 0x0000000C
+#define DDRSS_PHY_1050_DATA 0x0000000C
+#define DDRSS_PHY_1051_DATA 0x00000033
+#define DDRSS_PHY_1052_DATA 0x2307B9AC
+#define DDRSS_PHY_1053_DATA 0x10000000
+#define DDRSS_PHY_1054_DATA 0x000F0000
+#define DDRSS_PHY_1055_DATA 0x0000000F
+#define DDRSS_PHY_1056_DATA 0x020002CC
+#define DDRSS_PHY_1057_DATA 0x00030000
+#define DDRSS_PHY_1058_DATA 0x00000300
+#define DDRSS_PHY_1059_DATA 0x00000300
+#define DDRSS_PHY_1060_DATA 0x00000300
+#define DDRSS_PHY_1061_DATA 0x00000300
+#define DDRSS_PHY_1062_DATA 0x00000300
+#define DDRSS_PHY_1063_DATA 0x42080010
+#define DDRSS_PHY_1064_DATA 0x0000803E
+#define DDRSS_PHY_1065_DATA 0x00000003
+#define DDRSS_PHY_1066_DATA 0x00000002
+#define DDRSS_PHY_1067_DATA 0x00000000
+#define DDRSS_PHY_1068_DATA 0x00000000
+#define DDRSS_PHY_1069_DATA 0x00000000
+#define DDRSS_PHY_1070_DATA 0x00000000
+#define DDRSS_PHY_1071_DATA 0x00000000
+#define DDRSS_PHY_1072_DATA 0x00000000
+#define DDRSS_PHY_1073_DATA 0x00000000
+#define DDRSS_PHY_1074_DATA 0x00000000
+#define DDRSS_PHY_1075_DATA 0x00000000
+#define DDRSS_PHY_1076_DATA 0x00000000
+#define DDRSS_PHY_1077_DATA 0x00000000
+#define DDRSS_PHY_1078_DATA 0x00000000
+#define DDRSS_PHY_1079_DATA 0x00000000
+#define DDRSS_PHY_1080_DATA 0x00000000
+#define DDRSS_PHY_1081_DATA 0x00000000
+#define DDRSS_PHY_1082_DATA 0x00000000
+#define DDRSS_PHY_1083_DATA 0x00000000
+#define DDRSS_PHY_1084_DATA 0x00000000
+#define DDRSS_PHY_1085_DATA 0x00000000
+#define DDRSS_PHY_1086_DATA 0x00000000
+#define DDRSS_PHY_1087_DATA 0x00000000
+#define DDRSS_PHY_1088_DATA 0x00000000
+#define DDRSS_PHY_1089_DATA 0x00000000
+#define DDRSS_PHY_1090_DATA 0x00000000
+#define DDRSS_PHY_1091_DATA 0x00000000
+#define DDRSS_PHY_1092_DATA 0x00000000
+#define DDRSS_PHY_1093_DATA 0x00000000
+#define DDRSS_PHY_1094_DATA 0x00000000
+#define DDRSS_PHY_1095_DATA 0x00000000
+#define DDRSS_PHY_1096_DATA 0x00000000
+#define DDRSS_PHY_1097_DATA 0x00000000
+#define DDRSS_PHY_1098_DATA 0x00000000
+#define DDRSS_PHY_1099_DATA 0x00000000
+#define DDRSS_PHY_1100_DATA 0x00000000
+#define DDRSS_PHY_1101_DATA 0x00000000
+#define DDRSS_PHY_1102_DATA 0x00000000
+#define DDRSS_PHY_1103_DATA 0x00000000
+#define DDRSS_PHY_1104_DATA 0x00000000
+#define DDRSS_PHY_1105_DATA 0x00000000
+#define DDRSS_PHY_1106_DATA 0x00000000
+#define DDRSS_PHY_1107_DATA 0x00000000
+#define DDRSS_PHY_1108_DATA 0x00000000
+#define DDRSS_PHY_1109_DATA 0x00000000
+#define DDRSS_PHY_1110_DATA 0x00000000
+#define DDRSS_PHY_1111_DATA 0x00000000
+#define DDRSS_PHY_1112_DATA 0x00000000
+#define DDRSS_PHY_1113_DATA 0x00000000
+#define DDRSS_PHY_1114_DATA 0x00000000
+#define DDRSS_PHY_1115_DATA 0x00000000
+#define DDRSS_PHY_1116_DATA 0x00000000
+#define DDRSS_PHY_1117_DATA 0x00000000
+#define DDRSS_PHY_1118_DATA 0x00000000
+#define DDRSS_PHY_1119_DATA 0x00000000
+#define DDRSS_PHY_1120_DATA 0x00000000
+#define DDRSS_PHY_1121_DATA 0x00000000
+#define DDRSS_PHY_1122_DATA 0x00000000
+#define DDRSS_PHY_1123_DATA 0x00000000
+#define DDRSS_PHY_1124_DATA 0x00000000
+#define DDRSS_PHY_1125_DATA 0x00000000
+#define DDRSS_PHY_1126_DATA 0x00000000
+#define DDRSS_PHY_1127_DATA 0x00000000
+#define DDRSS_PHY_1128_DATA 0x00000000
+#define DDRSS_PHY_1129_DATA 0x00000000
+#define DDRSS_PHY_1130_DATA 0x00000000
+#define DDRSS_PHY_1131_DATA 0x00000000
+#define DDRSS_PHY_1132_DATA 0x00000000
+#define DDRSS_PHY_1133_DATA 0x00000000
+#define DDRSS_PHY_1134_DATA 0x00000000
+#define DDRSS_PHY_1135_DATA 0x00000000
+#define DDRSS_PHY_1136_DATA 0x00000000
+#define DDRSS_PHY_1137_DATA 0x00000000
+#define DDRSS_PHY_1138_DATA 0x00000000
+#define DDRSS_PHY_1139_DATA 0x00000000
+#define DDRSS_PHY_1140_DATA 0x00000000
+#define DDRSS_PHY_1141_DATA 0x00000000
+#define DDRSS_PHY_1142_DATA 0x00000000
+#define DDRSS_PHY_1143_DATA 0x00000000
+#define DDRSS_PHY_1144_DATA 0x00000000
+#define DDRSS_PHY_1145_DATA 0x00000000
+#define DDRSS_PHY_1146_DATA 0x00000000
+#define DDRSS_PHY_1147_DATA 0x00000000
+#define DDRSS_PHY_1148_DATA 0x00000000
+#define DDRSS_PHY_1149_DATA 0x00000000
+#define DDRSS_PHY_1150_DATA 0x00000000
+#define DDRSS_PHY_1151_DATA 0x00000000
+#define DDRSS_PHY_1152_DATA 0x00000000
+#define DDRSS_PHY_1153_DATA 0x00000000
+#define DDRSS_PHY_1154_DATA 0x00000000
+#define DDRSS_PHY_1155_DATA 0x00000000
+#define DDRSS_PHY_1156_DATA 0x00000000
+#define DDRSS_PHY_1157_DATA 0x00000000
+#define DDRSS_PHY_1158_DATA 0x00000000
+#define DDRSS_PHY_1159_DATA 0x00000000
+#define DDRSS_PHY_1160_DATA 0x00000000
+#define DDRSS_PHY_1161_DATA 0x00000000
+#define DDRSS_PHY_1162_DATA 0x00000000
+#define DDRSS_PHY_1163_DATA 0x00000000
+#define DDRSS_PHY_1164_DATA 0x00000000
+#define DDRSS_PHY_1165_DATA 0x00000000
+#define DDRSS_PHY_1166_DATA 0x00000000
+#define DDRSS_PHY_1167_DATA 0x00000000
+#define DDRSS_PHY_1168_DATA 0x00000000
+#define DDRSS_PHY_1169_DATA 0x00000000
+#define DDRSS_PHY_1170_DATA 0x00000000
+#define DDRSS_PHY_1171_DATA 0x00000000
+#define DDRSS_PHY_1172_DATA 0x00000000
+#define DDRSS_PHY_1173_DATA 0x00000000
+#define DDRSS_PHY_1174_DATA 0x00000000
+#define DDRSS_PHY_1175_DATA 0x00000000
+#define DDRSS_PHY_1176_DATA 0x00000000
+#define DDRSS_PHY_1177_DATA 0x00000000
+#define DDRSS_PHY_1178_DATA 0x00000000
+#define DDRSS_PHY_1179_DATA 0x00000000
+#define DDRSS_PHY_1180_DATA 0x00000000
+#define DDRSS_PHY_1181_DATA 0x00000000
+#define DDRSS_PHY_1182_DATA 0x00000000
+#define DDRSS_PHY_1183_DATA 0x00000000
+#define DDRSS_PHY_1184_DATA 0x00000000
+#define DDRSS_PHY_1185_DATA 0x00000000
+#define DDRSS_PHY_1186_DATA 0x00000000
+#define DDRSS_PHY_1187_DATA 0x00000000
+#define DDRSS_PHY_1188_DATA 0x00000000
+#define DDRSS_PHY_1189_DATA 0x00000000
+#define DDRSS_PHY_1190_DATA 0x00000000
+#define DDRSS_PHY_1191_DATA 0x00000000
+#define DDRSS_PHY_1192_DATA 0x00000000
+#define DDRSS_PHY_1193_DATA 0x00000000
+#define DDRSS_PHY_1194_DATA 0x00000000
+#define DDRSS_PHY_1195_DATA 0x00000000
+#define DDRSS_PHY_1196_DATA 0x00000000
+#define DDRSS_PHY_1197_DATA 0x00000000
+#define DDRSS_PHY_1198_DATA 0x00000000
+#define DDRSS_PHY_1199_DATA 0x00000000
+#define DDRSS_PHY_1200_DATA 0x00000000
+#define DDRSS_PHY_1201_DATA 0x00000000
+#define DDRSS_PHY_1202_DATA 0x00000000
+#define DDRSS_PHY_1203_DATA 0x00000000
+#define DDRSS_PHY_1204_DATA 0x00000000
+#define DDRSS_PHY_1205_DATA 0x00000000
+#define DDRSS_PHY_1206_DATA 0x00000000
+#define DDRSS_PHY_1207_DATA 0x00000000
+#define DDRSS_PHY_1208_DATA 0x00000000
+#define DDRSS_PHY_1209_DATA 0x00000000
+#define DDRSS_PHY_1210_DATA 0x00000000
+#define DDRSS_PHY_1211_DATA 0x00000000
+#define DDRSS_PHY_1212_DATA 0x00000000
+#define DDRSS_PHY_1213_DATA 0x00000000
+#define DDRSS_PHY_1214_DATA 0x00000000
+#define DDRSS_PHY_1215_DATA 0x00000000
+#define DDRSS_PHY_1216_DATA 0x00000000
+#define DDRSS_PHY_1217_DATA 0x00000000
+#define DDRSS_PHY_1218_DATA 0x00000000
+#define DDRSS_PHY_1219_DATA 0x00000000
+#define DDRSS_PHY_1220_DATA 0x00000000
+#define DDRSS_PHY_1221_DATA 0x00000000
+#define DDRSS_PHY_1222_DATA 0x00000000
+#define DDRSS_PHY_1223_DATA 0x00000000
+#define DDRSS_PHY_1224_DATA 0x00000000
+#define DDRSS_PHY_1225_DATA 0x00000000
+#define DDRSS_PHY_1226_DATA 0x00000000
+#define DDRSS_PHY_1227_DATA 0x00000000
+#define DDRSS_PHY_1228_DATA 0x00000000
+#define DDRSS_PHY_1229_DATA 0x00000000
+#define DDRSS_PHY_1230_DATA 0x00000000
+#define DDRSS_PHY_1231_DATA 0x00000000
+#define DDRSS_PHY_1232_DATA 0x00000000
+#define DDRSS_PHY_1233_DATA 0x00000000
+#define DDRSS_PHY_1234_DATA 0x00000000
+#define DDRSS_PHY_1235_DATA 0x00000000
+#define DDRSS_PHY_1236_DATA 0x00000000
+#define DDRSS_PHY_1237_DATA 0x00000000
+#define DDRSS_PHY_1238_DATA 0x00000000
+#define DDRSS_PHY_1239_DATA 0x00000000
+#define DDRSS_PHY_1240_DATA 0x00000000
+#define DDRSS_PHY_1241_DATA 0x00000000
+#define DDRSS_PHY_1242_DATA 0x00000000
+#define DDRSS_PHY_1243_DATA 0x00000000
+#define DDRSS_PHY_1244_DATA 0x00000000
+#define DDRSS_PHY_1245_DATA 0x00000000
+#define DDRSS_PHY_1246_DATA 0x00000000
+#define DDRSS_PHY_1247_DATA 0x00000000
+#define DDRSS_PHY_1248_DATA 0x00000000
+#define DDRSS_PHY_1249_DATA 0x00000000
+#define DDRSS_PHY_1250_DATA 0x00000000
+#define DDRSS_PHY_1251_DATA 0x00000000
+#define DDRSS_PHY_1252_DATA 0x00000000
+#define DDRSS_PHY_1253_DATA 0x00000000
+#define DDRSS_PHY_1254_DATA 0x00000000
+#define DDRSS_PHY_1255_DATA 0x00000000
+#define DDRSS_PHY_1256_DATA 0x00000000
+#define DDRSS_PHY_1257_DATA 0x00000000
+#define DDRSS_PHY_1258_DATA 0x00000000
+#define DDRSS_PHY_1259_DATA 0x00000000
+#define DDRSS_PHY_1260_DATA 0x00000000
+#define DDRSS_PHY_1261_DATA 0x00000000
+#define DDRSS_PHY_1262_DATA 0x00000000
+#define DDRSS_PHY_1263_DATA 0x00000000
+#define DDRSS_PHY_1264_DATA 0x00000000
+#define DDRSS_PHY_1265_DATA 0x00000000
+#define DDRSS_PHY_1266_DATA 0x00000000
+#define DDRSS_PHY_1267_DATA 0x00000000
+#define DDRSS_PHY_1268_DATA 0x00000000
+#define DDRSS_PHY_1269_DATA 0x00000000
+#define DDRSS_PHY_1270_DATA 0x00000000
+#define DDRSS_PHY_1271_DATA 0x00000000
+#define DDRSS_PHY_1272_DATA 0x00000000
+#define DDRSS_PHY_1273_DATA 0x00000000
+#define DDRSS_PHY_1274_DATA 0x00000000
+#define DDRSS_PHY_1275_DATA 0x00000000
+#define DDRSS_PHY_1276_DATA 0x00000000
+#define DDRSS_PHY_1277_DATA 0x00000000
+#define DDRSS_PHY_1278_DATA 0x00000000
+#define DDRSS_PHY_1279_DATA 0x00000000
+#define DDRSS_PHY_1280_DATA 0x00000000
+#define DDRSS_PHY_1281_DATA 0x00010100
+#define DDRSS_PHY_1282_DATA 0x00000000
+#define DDRSS_PHY_1283_DATA 0x00000000
+#define DDRSS_PHY_1284_DATA 0x00000000
+#define DDRSS_PHY_1285_DATA 0x00000000
+#define DDRSS_PHY_1286_DATA 0x00050000
+#define DDRSS_PHY_1287_DATA 0x04000000
+#define DDRSS_PHY_1288_DATA 0x00000055
+#define DDRSS_PHY_1289_DATA 0x00000000
+#define DDRSS_PHY_1290_DATA 0x00000000
+#define DDRSS_PHY_1291_DATA 0x00000000
+#define DDRSS_PHY_1292_DATA 0x00000000
+#define DDRSS_PHY_1293_DATA 0x00002001
+#define DDRSS_PHY_1294_DATA 0x00004001
+#define DDRSS_PHY_1295_DATA 0x00020028
+#define DDRSS_PHY_1296_DATA 0x01010100
+#define DDRSS_PHY_1297_DATA 0x00000000
+#define DDRSS_PHY_1298_DATA 0x00000000
+#define DDRSS_PHY_1299_DATA 0x0F0F0E06
+#define DDRSS_PHY_1300_DATA 0x00010101
+#define DDRSS_PHY_1301_DATA 0x010F0004
+#define DDRSS_PHY_1302_DATA 0x00000000
+#define DDRSS_PHY_1303_DATA 0x00000000
+#define DDRSS_PHY_1304_DATA 0x00000064
+#define DDRSS_PHY_1305_DATA 0x00000000
+#define DDRSS_PHY_1306_DATA 0x00000000
+#define DDRSS_PHY_1307_DATA 0x01020103
+#define DDRSS_PHY_1308_DATA 0x0F020102
+#define DDRSS_PHY_1309_DATA 0x03030303
+#define DDRSS_PHY_1310_DATA 0x03030303
+#define DDRSS_PHY_1311_DATA 0x00041B42
+#define DDRSS_PHY_1312_DATA 0x00005201
+#define DDRSS_PHY_1313_DATA 0x00000000
+#define DDRSS_PHY_1314_DATA 0x00000000
+#define DDRSS_PHY_1315_DATA 0x00000000
+#define DDRSS_PHY_1316_DATA 0x00000000
+#define DDRSS_PHY_1317_DATA 0x00000000
+#define DDRSS_PHY_1318_DATA 0x00000000
+#define DDRSS_PHY_1319_DATA 0x07030101
+#define DDRSS_PHY_1320_DATA 0x00005400
+#define DDRSS_PHY_1321_DATA 0x000040A2
+#define DDRSS_PHY_1322_DATA 0x00024410
+#define DDRSS_PHY_1323_DATA 0x00004410
+#define DDRSS_PHY_1324_DATA 0x00004410
+#define DDRSS_PHY_1325_DATA 0x00004410
+#define DDRSS_PHY_1326_DATA 0x00004410
+#define DDRSS_PHY_1327_DATA 0x00004410
+#define DDRSS_PHY_1328_DATA 0x00004410
+#define DDRSS_PHY_1329_DATA 0x00004410
+#define DDRSS_PHY_1330_DATA 0x00004410
+#define DDRSS_PHY_1331_DATA 0x00004410
+#define DDRSS_PHY_1332_DATA 0x00000000
+#define DDRSS_PHY_1333_DATA 0x00000076
+#define DDRSS_PHY_1334_DATA 0x00000400
+#define DDRSS_PHY_1335_DATA 0x00000008
+#define DDRSS_PHY_1336_DATA 0x00000000
+#define DDRSS_PHY_1337_DATA 0x00000000
+#define DDRSS_PHY_1338_DATA 0x00000000
+#define DDRSS_PHY_1339_DATA 0x00000000
+#define DDRSS_PHY_1340_DATA 0x00000000
+#define DDRSS_PHY_1341_DATA 0x03000000
+#define DDRSS_PHY_1342_DATA 0x00000000
+#define DDRSS_PHY_1343_DATA 0x00000000
+#define DDRSS_PHY_1344_DATA 0x00000000
+#define DDRSS_PHY_1345_DATA 0x04102006
+#define DDRSS_PHY_1346_DATA 0x00041020
+#define DDRSS_PHY_1347_DATA 0x01C98C98
+#define DDRSS_PHY_1348_DATA 0x3F400000
+#define DDRSS_PHY_1349_DATA 0x3F3F1F3F
+#define DDRSS_PHY_1350_DATA 0x0000001F
+#define DDRSS_PHY_1351_DATA 0x00000000
+#define DDRSS_PHY_1352_DATA 0x00000000
+#define DDRSS_PHY_1353_DATA 0x00000000
+#define DDRSS_PHY_1354_DATA 0x00000001
+#define DDRSS_PHY_1355_DATA 0x00000000
+#define DDRSS_PHY_1356_DATA 0x00000000
+#define DDRSS_PHY_1357_DATA 0x00000000
+#define DDRSS_PHY_1358_DATA 0x00000000
+#define DDRSS_PHY_1359_DATA 0x76543210
+#define DDRSS_PHY_1360_DATA 0x00040198
+#define DDRSS_PHY_1361_DATA 0x00000000
+#define DDRSS_PHY_1362_DATA 0x00000000
+#define DDRSS_PHY_1363_DATA 0x00000000
+#define DDRSS_PHY_1364_DATA 0x00040700
+#define DDRSS_PHY_1365_DATA 0x00000000
+#define DDRSS_PHY_1366_DATA 0x00000000
+#define DDRSS_PHY_1367_DATA 0x00000000
+#define DDRSS_PHY_1368_DATA 0x00000002
+#define DDRSS_PHY_1369_DATA 0x00000000
+#define DDRSS_PHY_1370_DATA 0x00000000
+#define DDRSS_PHY_1371_DATA 0x0001F7C2
+#define DDRSS_PHY_1372_DATA 0x00020002
+#define DDRSS_PHY_1373_DATA 0x00000000
+#define DDRSS_PHY_1374_DATA 0x00001142
+#define DDRSS_PHY_1375_DATA 0x03020000
+#define DDRSS_PHY_1376_DATA 0x00000080
+#define DDRSS_PHY_1377_DATA 0x03900390
+#define DDRSS_PHY_1378_DATA 0x03900390
+#define DDRSS_PHY_1379_DATA 0x03900390
+#define DDRSS_PHY_1380_DATA 0x03900390
+#define DDRSS_PHY_1381_DATA 0x03000300
+#define DDRSS_PHY_1382_DATA 0x03000300
+#define DDRSS_PHY_1383_DATA 0x00000300
+#define DDRSS_PHY_1384_DATA 0x00000300
+#define DDRSS_PHY_1385_DATA 0x00000300
+#define DDRSS_PHY_1386_DATA 0x00000300
+#define DDRSS_PHY_1387_DATA 0x3183BF77
+#define DDRSS_PHY_1388_DATA 0x00000000
+#define DDRSS_PHY_1389_DATA 0x0C000DFF
+#define DDRSS_PHY_1390_DATA 0x30000DFF
+#define DDRSS_PHY_1391_DATA 0x3F0DFF11
+#define DDRSS_PHY_1392_DATA 0x01990000
+#define DDRSS_PHY_1393_DATA 0x780DFFCC
+#define DDRSS_PHY_1394_DATA 0x00000C11
+#define DDRSS_PHY_1395_DATA 0x00018011
+#define DDRSS_PHY_1396_DATA 0x0089FF00
+#define DDRSS_PHY_1397_DATA 0x000C3F11
+#define DDRSS_PHY_1398_DATA 0x01990000
+#define DDRSS_PHY_1399_DATA 0x000C3F91
+#define DDRSS_PHY_1400_DATA 0x01990000
+#define DDRSS_PHY_1401_DATA 0x3F0DFF11
+#define DDRSS_PHY_1402_DATA 0x01990000
+#define DDRSS_PHY_1403_DATA 0x00018011
+#define DDRSS_PHY_1404_DATA 0x0089FF00
+#define DDRSS_PHY_1405_DATA 0x20040004
diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
index 8b0cdd74f4..1b0293879d 100644
--- a/arch/arm/mach-k3/am62x/Kconfig
+++ b/arch/arm/mach-k3/am62x/Kconfig
@@ -65,6 +65,7 @@ config TARGET_VERDIN_AM62_R5
 endchoice
 
 source "board/beagle/beagleplay/Kconfig"
+source "board/bsh/am623_ccm_m3/Kconfig"
 source "board/phytec/phycore_am62x/Kconfig"
 source "board/ti/am62x/Kconfig"
 source "board/toradex/verdin-am62/Kconfig"
diff --git a/board/bsh/am623_ccm_m3/Kconfig b/board/bsh/am623_ccm_m3/Kconfig
new file mode 100644
index 0000000000..6022ff26cb
--- /dev/null
+++ b/board/bsh/am623_ccm_m3/Kconfig
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0+
+# (C) Copyright 2024 Amarula Solutions B.V.
+
+choice
+	prompt "TI K3 AM62x based boards"
+	optional
+
+config TARGET_AM625_A53_BSH_CCM_M3
+	bool "TI K3 based AM625 BSH CCM M3 running on A53"
+	select ARM64
+	select BINMAN
+
+config TARGET_AM625_R5_BSH_CCM_M3
+	bool "TI K3 based AM625 BSH CCM M3 running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	select DM_PMIC
+	imply SYS_K3_SPL_ATF
+
+endchoice
+
+if TARGET_AM625_A53_BSH_CCM_M3
+
+config SYS_BOARD
+	default "am623_ccm_m3"
+
+config SYS_VENDOR
+	default "bsh"
+
+config SYS_CONFIG_NAME
+	default "am62x_bsh-ccm-m3"
+
+source "board/ti/common/Kconfig"
+
+endif
+
+if TARGET_AM625_R5_BSH_CCM_M3
+
+config SYS_BOARD
+	default "am623_ccm_m3"
+
+config SYS_VENDOR
+	default "bsh"
+
+config SYS_CONFIG_NAME
+	default "am62x_bsh-ccm-m3"
+
+config SPL_LDSCRIPT
+	default "arch/arm/mach-omap2/u-boot-spl.lds"
+
+source "board/ti/common/Kconfig"
+
+endif
diff --git a/board/bsh/am623_ccm_m3/MAINTAINERS b/board/bsh/am623_ccm_m3/MAINTAINERS
new file mode 100644
index 0000000000..9c2206ee60
--- /dev/null
+++ b/board/bsh/am623_ccm_m3/MAINTAINERS
@@ -0,0 +1,7 @@
+AM62x BOARD BSH M3 board
+M:	Michael Trimarchi <michael@amarulasolutions.com>
+S:	Maintained
+F:	am623_ccm_m3
+F:	include/configs/am62x_bsh-ccm-m3.h
+F:	configs/am62x_bsh-ccm-m3_r5_defconfig
+F:	configs/am62x_bsh-ccm-m3_a53_defconfig
diff --git a/board/bsh/am623_ccm_m3/Makefile b/board/bsh/am623_ccm_m3/Makefile
new file mode 100644
index 0000000000..e22be381b7
--- /dev/null
+++ b/board/bsh/am623_ccm_m3/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+# (C) Copyright 2024 Amarula Solutions B.V.
+
+obj-y	+= am623_ccm_m3.o
diff --git a/board/bsh/am623_ccm_m3/am623_ccm_m3.c b/board/bsh/am623_ccm_m3/am623_ccm_m3.c
new file mode 100644
index 0000000000..5cf6dd48a9
--- /dev/null
+++ b/board/bsh/am623_ccm_m3/am623_ccm_m3.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Board specific initialization for BSH AM62x based platform CCM-M3
+ *
+ * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ *	Suman Anna <s-anna@ti.com>
+ * Copyright (C) 2023 BSH Hausgeraete GmbH - https://www.bsh.com/
+ *	Bode Michael <michael.bode@bshg.com>
+ *
+ */
+
+#include <common.h>
+#include <command.h>
+#include <env.h>
+#include <spl.h>
+#include <init.h>
+#include <video.h>
+#include <splash.h>
+#include <cpu_func.h>
+#include <k3-ddrss.h>
+#include <fdt_support.h>
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include <dm/uclass.h>
+#include <net.h>
+#include <asm/gpio.h>
+#include <cpu_func.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#ifdef CONFIG_SYS_SPI_U_BOOT_OFFS
+uint32_t spl_mtd_get_uboot_offs(void)
+{
+	return CONFIG_SYS_SPI_U_BOOT_OFFS;
+}
+#endif
+
+int board_init(void)
+{
+	return 0;
+}
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+#if defined(CONFIG_SPL_BUILD)
+
+#if defined(CONFIG_K3_AM64_DDRSS)
+static void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image)
+{
+	struct udevice *dev;
+	int ret;
+
+	dram_init_banksize();
+
+	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+	if (ret)
+		panic("Cannot get RAM device for ddr size fixup: %d\n", ret);
+
+	ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
+	if (ret)
+		printf("Error fixing up ddr node for ECC use! %d\n", ret);
+}
+#else
+static void fixup_memory_node(struct spl_image_info *spl_image)
+{
+	u64 start[CONFIG_NR_DRAM_BANKS];
+	u64 size[CONFIG_NR_DRAM_BANKS];
+	int bank;
+	int ret;
+
+	dram_init();
+	dram_init_banksize();
+
+	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+		start[bank] =  gd->bd->bi_dram[bank].start;
+		size[bank] = gd->bd->bi_dram[bank].size;
+	}
+
+	/* dram_init functions use SPL fdt, and we must fixup u-boot fdt */
+	ret = fdt_fixup_memory_banks(spl_image->fdt_addr, start, size,
+				     CONFIG_NR_DRAM_BANKS);
+	if (ret)
+		printf("Error fixing up memory node! %d\n", ret);
+}
+#endif
+
+void spl_perform_fixups(struct spl_image_info *spl_image)
+{
+#if defined(CONFIG_K3_AM64_DDRSS)
+	fixup_ddr_driver_for_ecc(spl_image);
+#else
+	fixup_memory_node(spl_image);
+#endif
+}
+
+#define CTRLMMR_USB0_PHY_CTRL	0x43004008
+#define CTRLMMR_USB1_PHY_CTRL	0x43004018
+#define CORE_VOLTAGE		0x80000000
+
+#define WKUP_CTRLMMR_DBOUNCE_CFG1 0x04504084
+#define WKUP_CTRLMMR_DBOUNCE_CFG2 0x04504088
+#define WKUP_CTRLMMR_DBOUNCE_CFG3 0x0450408c
+#define WKUP_CTRLMMR_DBOUNCE_CFG4 0x04504090
+#define WKUP_CTRLMMR_DBOUNCE_CFG5 0x04504094
+#define WKUP_CTRLMMR_DBOUNCE_CFG6 0x04504098
+
+void spl_board_init(void)
+{
+	u32 val;
+
+	/* Set USB0 PHY core voltage to 0.85V */
+	val = readl(CTRLMMR_USB0_PHY_CTRL);
+	val &= ~(CORE_VOLTAGE);
+	writel(val, CTRLMMR_USB0_PHY_CTRL);
+
+	/* Set USB1 PHY core voltage to 0.85V */
+	val = readl(CTRLMMR_USB1_PHY_CTRL);
+	val &= ~(CORE_VOLTAGE);
+	writel(val, CTRLMMR_USB1_PHY_CTRL);
+
+	/* We have 32k crystal, so lets enable it */
+	val = readl(MCU_CTRL_LFXOSC_CTRL);
+	val &= ~(MCU_CTRL_LFXOSC_32K_DISABLE_VAL);
+	writel(val, MCU_CTRL_LFXOSC_CTRL);
+	/* Add any TRIM needed for the crystal here.. */
+	/* Make sure to mux up to take the SoC 32k from the crystal */
+	writel(MCU_CTRL_DEVICE_CLKOUT_LFOSC_SELECT_VAL,
+	       MCU_CTRL_DEVICE_CLKOUT_32K_CTRL);
+
+	/* Setup debounce conf registers - arbitrary values. Times are approx */
+	/* 1.9ms debounce @ 32k */
+	writel(WKUP_CTRLMMR_DBOUNCE_CFG1, 0x1);
+	/* 5ms debounce @ 32k */
+	writel(WKUP_CTRLMMR_DBOUNCE_CFG2, 0x5);
+	/* 20ms debounce @ 32k */
+	writel(WKUP_CTRLMMR_DBOUNCE_CFG3, 0x14);
+	/* 46ms debounce @ 32k */
+	writel(WKUP_CTRLMMR_DBOUNCE_CFG4, 0x18);
+	/* 100ms debounce @ 32k */
+	writel(WKUP_CTRLMMR_DBOUNCE_CFG5, 0x1c);
+	/* 156ms debounce @ 32k */
+	writel(WKUP_CTRLMMR_DBOUNCE_CFG6, 0x1f);
+
+	enable_caches();
+}
+
+
+#endif /* CONFIG_SPL_BUILD */
+
+#ifdef CONFIG_TI_I2C_BOARD_DETECT
+
+int checkboard(void)
+{
+	printf("Board: %s rev %s\n", "BSH", "CCM M3");
+	return 0;
+}
+#endif
+
+#if !defined(CONFIG_SPL_BUILD)
+static void set_boot_media(void)
+{
+	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+
+	switch (bootmode) {
+	case BOOT_DEVICE_EMMC:
+	case BOOT_DEVICE_MMC:
+		printf("Booted from eMMC.\n");
+		#ifdef FAKE_SERIAL_NAND_BOOT
+			env_set("boot", "ospi_nand");
+		#else
+			env_set("boot", "mmc");
+		#endif
+		break;
+	case BOOT_DEVICE_GPMC_NAND:
+		printf("Booted from Serial NAND.\n");
+		env_set("boot", "ospi_nand");
+		break;
+	case BOOT_DEVICE_DFU:
+		printf("Booted from USB DFU\n");
+		break;
+	default:
+		break;
+	}
+}
+#endif
+
+#ifdef CONFIG_BOARD_LATE_INIT
+int board_late_init(void)
+{
+#if !defined(CONFIG_SPL_BUILD)
+	set_boot_media();
+#endif
+	return 0;
+}
+#endif
+
+#if !defined(CONFIG_SPL_BUILD)
+
+#define WKUP_MMR0_MAIN_DEVSTAT_REG (0x43000030)
+
+static int do_bmode(struct cmd_tbl *cmdtp, int flag, int argc,
+                        char *const argv[])
+{
+	if (argc != 2)
+			return CMD_RET_USAGE;
+
+	if ( (!strcmp(argv[1], "usb")) || (!strcmp(argv[1], "dfu") ) ) {
+		run_command("mw 0x43000030 0x00000453 0x1;reset", 0);
+	} else if (!strcmp(argv[1], "emmc")) {
+		run_command("mw 0x43000030 0x0000054B 0x1;reset", 0);
+	} else if (!strcmp(argv[1], "nand")) {
+		run_command("mw 0x43000030 0x00000483 0x1;reset", 0);
+	} else {
+		return CMD_RET_USAGE;
+	}
+
+	/* Not reached ... */
+	return CMD_RET_USAGE;
+};
+
+U_BOOT_CMD(
+        bmode, CONFIG_SYS_MAXARGS, 2,       do_bmode,
+        "Set boot mode and reset",
+        "<usb|emmc|nand>"
+);
+
+#endif
diff --git a/board/bsh/am623_ccm_m3/am623_ccm_m3.env b/board/bsh/am623_ccm_m3/am623_ccm_m3.env
new file mode 100644
index 0000000000..739200dbe9
--- /dev/null
+++ b/board/bsh/am623_ccm_m3/am623_ccm_m3.env
@@ -0,0 +1,90 @@
+#include <env/ti/mmc.env>
+#include <env/ti/k3_dfu.env>
+#include <env/ti/k3_rproc.env>
+
+loadaddr=0x82000000
+kernel_addr_r=0x82000000
+fdtaddr=0x85000000
+dtboaddr=0x86000000
+fdt_addr_r=0x85000000
+fdtoverlay_addr_r=0x86000000
+rdaddr=0x85080000
+ramdisk_addr_r=0x85080000
+scriptaddr=0x80000000
+pxefile_addr_r=0x80100000
+bootm_size=0x4000000
+boot_fdt=try
+
+boot_fit=0
+addr_fit=0x8e000000
+name_fit=fitImage
+update_to_fit=setenv loadaddr ${addr_fit}; setenv bootfile ${name_fit}
+get_overlaystring=
+	for overlay in $name_overlays;
+	do;
+	setenv overlaystring ${overlaystring}'#'${overlay};
+	done;
+get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}
+run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}
+bootcmd_ti_mmc=
+	run findfdt; run init_${boot};
+#if CONFIG_CMD_REMOTEPROC
+	run boot_rprocs;
+#endif
+	if test ${boot_fit} -eq 1;
+		then run get_fit_${boot}; run get_overlaystring; run run_fit;
+	else;
+		run get_kern_${boot}; run get_fdt_${boot}; run get_overlay_${boot}; run run_kern;
+	fi;
+
+
+mtdparts=mtdparts=spi-nand0:512k(ospi_nand.tiboot3),2m(ospi_nand.tispl),4m(ospi_nand.u-boot),256k(ospi_nand.env),256k(ospi_nand.env.backup),222976k@32m(ospi_nand.rootfs),256k@255744k(ospi_nand.phypattern)
+
+partitions=name=rootfs,start=8MiB,size=-,uuid=${uuid_gpt_rootfs}
+
+default_device_tree=ti/k3-am62-ccm-m3.dtb
+findfdt=
+	setenv name_fdt ${default_device_tree};
+	setenv fdtfile ${name_fdt}
+name_kern=Image
+console=ttyS2,115200n8
+args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
+	${mtdparts}
+run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+
+boot=mmc
+mmcdev=0
+bootpart=0:1
+bootdir=/boot
+rd_spec=-
+
+rproc_fw_binaries= 0 /lib/firmware/am62-mcu-m4f0_0-fw
+
+emmc_erase=
+	mmc dev 0 0;
+	mmc erase 0 0x760000;
+	mmc dev 0 1;
+	mmc erase 0 0x1000;
+	mmc dev 0 2;
+	mmc erase 0 0x1000
+
+nand_erase=
+	mtd erase ospi_nand.tiboot3;
+	mtd erase ospi_nand.tispl;
+	mtd erase ospi_nand.u-boot;
+	mtd erase ospi_nand.env;
+	mtd erase ospi_nand.env.backup;
+	mtd erase ospi_nand.rootfs;
+	mtd erase ospi_nand.phypattern
+
+emmc_fdisk=
+	if gpt verify mmc 0; then
+	else
+		uid_disk=${uuid_gpt_disk};${partitions};
+		setenv uuid_gpt_disk 70512705-e56d-47ff-a89e-5beaf466be6f;
+		setenv uuid_gpt_rootfs c586a30c-0bf1-4323-aba8-779c814ee135;
+		gpt write mmc 0 ${partitions};
+		mmc partconf 0 1 1 1;
+		mmc bootbus 0 2 0 0;
+		reset;
+	fi
diff --git a/board/bsh/am623_ccm_m3/board-cfg.yaml b/board/bsh/am623_ccm_m3/board-cfg.yaml
new file mode 100644
index 0000000000..45c89dd15f
--- /dev/null
+++ b/board/bsh/am623_ccm_m3/board-cfg.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Board configuration for AM62
+#
+
+---
+
+board-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
+    control:
+        subhdr:
+            magic: 0xC1D3
+            size: 7
+        main_isolation_enable: 0x5A
+        main_isolation_hostid: 0x2
+    secproxy:
+        subhdr:
+            magic: 0x1207
+            size: 7
+        scaling_factor: 0x1
+        scaling_profile: 0x1
+        disable_main_nav_secure_proxy: 0
+    msmc:
+        subhdr:
+            magic: 0xA5C3
+            size: 5
+        msmc_cache_size: 0x0
+    debug_cfg:
+        subhdr:
+            magic: 0x020C
+            size: 8
+        trace_dst_enables: 0x00
+        trace_src_enables: 0x00
diff --git a/board/bsh/am623_ccm_m3/pm-cfg.yaml b/board/bsh/am623_ccm_m3/pm-cfg.yaml
new file mode 100644
index 0000000000..9853a25eb8
--- /dev/null
+++ b/board/bsh/am623_ccm_m3/pm-cfg.yaml
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Power management configuration for AM62
+#
+
+---
+
+pm-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
diff --git a/board/bsh/am623_ccm_m3/rm-cfg.yaml b/board/bsh/am623_ccm_m3/rm-cfg.yaml
new file mode 100644
index 0000000000..725f7c83f0
--- /dev/null
+++ b/board/bsh/am623_ccm_m3/rm-cfg.yaml
@@ -0,0 +1,981 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for AM62X
+#
+
+---
+
+rm-cfg:
+    rm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
+        host_cfg:
+            subhdr:
+                magic: 0x4C41
+                size: 356
+            host_cfg_entries:
+                -  # 1
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 2
+                    host_id: 30
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 3
+                    host_id: 36
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 4
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 5
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 6
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 7
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 8
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 9
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 10
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 11
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 12
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 13
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 14
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 15
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 16
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 17
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 18
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 19
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 20
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 21
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 22
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 23
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 24
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 25
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 26
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 27
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 28
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 29
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 30
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 31
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 32
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+        resasg:
+            subhdr:
+                magic: 0x7B25
+                size: 8
+            resasg_entries_size: 976
+            reserved: 0
+    resasg_entries:
+        -
+            start_resource: 0
+            num_resource: 16
+            type: 64
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 4
+            type: 64
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 4
+            type: 64
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 22
+            type: 64
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 16
+            type: 192
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 34
+            num_resource: 2
+            type: 192
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 320
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 320
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 26
+            type: 384
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 50176
+            num_resource: 164
+            type: 1666
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 1667
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1677
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1677
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 6
+            type: 1677
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 54
+            num_resource: 18
+            type: 1678
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 6
+            type: 1678
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 6
+            type: 1678
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 78
+            num_resource: 2
+            type: 1678
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 80
+            num_resource: 2
+            type: 1678
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 12
+            type: 1679
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 50
+            num_resource: 2
+            type: 1679
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 52
+            num_resource: 2
+            type: 1679
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1696
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1696
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 6
+            type: 1696
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1697
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1697
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1697
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1697
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 2
+            type: 1697
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 12
+            type: 1698
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 2
+            type: 1698
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 2
+            type: 1698
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 35
+            type: 1802
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 36
+            type: 1802
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 36
+            type: 1802
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 8
+            type: 1802
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 512
+            type: 1805
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 525
+            num_resource: 256
+            type: 1805
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 525
+            num_resource: 256
+            type: 1805
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 781
+            num_resource: 128
+            type: 1805
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 909
+            num_resource: 627
+            type: 1805
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1024
+            type: 1807
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 29
+            type: 1808
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4608
+            num_resource: 99
+            type: 1809
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5120
+            num_resource: 24
+            type: 1810
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5632
+            num_resource: 51
+            type: 1811
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6144
+            num_resource: 51
+            type: 1812
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6656
+            num_resource: 51
+            type: 1813
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8192
+            num_resource: 32
+            type: 1814
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8704
+            num_resource: 32
+            type: 1815
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9216
+            num_resource: 32
+            type: 1816
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9728
+            num_resource: 22
+            type: 1817
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10240
+            num_resource: 22
+            type: 1818
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10752
+            num_resource: 22
+            type: 1819
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11264
+            num_resource: 28
+            type: 1820
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11776
+            num_resource: 28
+            type: 1821
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 28
+            type: 1822
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 1923
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1936
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1936
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1936
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 83
+            num_resource: 8
+            type: 1938
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 91
+            num_resource: 8
+            type: 1939
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 99
+            num_resource: 10
+            type: 1942
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 112
+            num_resource: 3
+            type: 1942
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 115
+            num_resource: 3
+            type: 1942
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1944
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1945
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1946
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1947
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1955
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1955
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1955
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 27
+            num_resource: 1
+            type: 1957
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 1
+            type: 1958
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1961
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1961
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1961
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1962
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1962
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1962
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 1
+            type: 1965
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1966
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 21
+            num_resource: 1
+            type: 1967
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1968
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 1
+            type: 1969
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1970
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 1
+            type: 1971
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1972
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 2112
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 2122
+            host_id: 12
+            reserved: 0
diff --git a/board/bsh/am623_ccm_m3/schema.yaml b/board/bsh/am623_ccm_m3/schema.yaml
new file mode 100644
index 0000000000..c8dd2e79e7
--- /dev/null
+++ b/board/bsh/am623_ccm_m3/schema.yaml
@@ -0,0 +1,436 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Config schema for TI K3 devices
+#
+
+---
+
+definitions:
+    u8:
+        type: integer
+        minimum: 0
+        maximum: 0xff
+    u16:
+        type: integer
+        minimum: 0
+        maximum: 0xffff
+    u32:
+        type: integer
+        minimum: 0
+        maximum: 0xffffffff
+
+
+
+type: object
+properties:
+    pm-cfg:
+        type: object
+        properties:
+            rev:
+                type: object
+                properties:
+                    boardcfg_abi_maj:
+                        $ref: "#/definitions/u8"
+                    boardcfg_abi_min:
+                        $ref: "#/definitions/u8"
+    board-cfg:
+        type: object
+        properties:
+            rev:
+                type: object
+                properties:
+                    boardcfg_abi_maj:
+                        $ref: "#/definitions/u8"
+                    boardcfg_abi_min:
+                        $ref: "#/definitions/u8"
+            control:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    main_isolation_enable:
+                        $ref: "#/definitions/u8"
+                    main_isolation_hostid:
+                        $ref: "#/definitions/u16"
+
+
+            secproxy:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    scaling_factor:
+                        $ref: "#/definitions/u8"
+                    scaling_profile:
+                        $ref: "#/definitions/u8"
+                    disable_main_nav_secure_proxy:
+                        $ref: "#/definitions/u8"
+
+            msmc:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    msmc_cache_size:
+                        $ref: "#/definitions/u8"
+            debug_cfg:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    trace_dst_enables:
+                        $ref: "#/definitions/u16"
+                    trace_src_enables:
+                        $ref: "#/definitions/u16"
+
+    sec-cfg:
+        type: object
+        properties:
+            rev:
+                type: object
+                properties:
+                    boardcfg_abi_maj:
+                        $ref: "#/definitions/u8"
+                    boardcfg_abi_min:
+                        $ref: "#/definitions/u8"
+
+            processor_acl_list:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    proc_acl_entries:
+                        type: array
+                        minItems: 32
+                        maxItems: 32
+                        items:
+                            type: object
+                            properties:
+                                processor_id:
+                                    $ref: "#/definitions/u8"
+                                proc_access_master:
+                                    $ref: "#/definitions/u8"
+                                proc_access_secondary:
+                                    type: array
+                                    minItems: 3
+                                    maxItems: 3
+                                    items:
+                                        $ref: "#/definitions/u8"
+            host_hierarchy:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    host_hierarchy_entries:
+                        type: array
+                        minItems: 32
+                        maxItems: 32
+                        items:
+                            type: object
+                            properties:
+                                host_id:
+                                    $ref: "#/definitions/u8"
+                                supervisor_host_id:
+                                    $ref: "#/definitions/u8"
+
+            otp_config:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    otp_entry:
+                        type: array
+                        minItems: 32
+                        maxItems: 32
+                        items:
+                            type: object
+                            properties:
+                                host_id:
+                                    $ref: "#/definitions/u8"
+                                host_perms:
+                                    $ref: "#/definitions/u8"
+                    write_host_id:
+                        $ref: "#/definitions/u8"
+
+            dkek_config:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    allowed_hosts:
+                        type: array
+                        minItems: 4
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+                    allow_dkek_export_tisci:
+                        $ref: "#/definitions/u8"
+                    rsvd:
+                        type: array
+                        minItems: 3
+                        maxItems: 3
+                        items:
+                            $ref: "#/definitions/u8"
+
+            sa2ul_cfg:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    rsvd:
+                        type: array
+                        minItems: 2
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+                    enable_saul_psil_global_config_writes:
+                        $ref: "#/definitions/u8"
+                    auth_resource_owner:
+                        $ref: "#/definitions/u8"
+
+            sec_dbg_config:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    allow_jtag_unlock:
+                        $ref: "#/definitions/u8"
+                    allow_wildcard_unlock:
+                        $ref: "#/definitions/u8"
+                    allowed_debug_level_rsvd:
+                        $ref: "#/definitions/u8"
+                    rsvd:
+                        $ref: "#/definitions/u8"
+                    min_cert_rev:
+                        $ref: "#/definitions/u32"
+                    jtag_unlock_hosts:
+                        type: array
+                        minItems: 4
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+
+
+            sec_handover_cfg:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    handover_msg_sender:
+                        $ref: "#/definitions/u8"
+                    handover_to_host_id:
+                        $ref: "#/definitions/u8"
+                    rsvd:
+                        type: array
+                        minItems: 4
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+
+    rm-cfg:
+        type: object
+        properties:
+            rm_boardcfg:
+                type: object
+                properties:
+                    rev:
+                        type: object
+                        properties:
+                            boardcfg_abi_maj:
+                                $ref: "#/definitions/u8"
+                            boardcfg_abi_min:
+                                $ref: "#/definitions/u8"
+
+                    host_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            host_cfg_entries:
+                                type: array
+                                minItems: 0
+                                maxItems: 32
+                                items:
+                                    type: object
+                                    properties:
+                                        host_id:
+                                            $ref: "#/definitions/u8"
+                                        allowed_atype:
+                                            $ref: "#/definitions/u8"
+                                        allowed_qos:
+                                            $ref: "#/definitions/u16"
+                                        allowed_orderid:
+                                            $ref: "#/definitions/u32"
+                                        allowed_priority:
+                                            $ref: "#/definitions/u16"
+                                        allowed_sched_priority:
+                                            $ref: "#/definitions/u8"
+                    resasg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            resasg_entries_size:
+                                        $ref: "#/definitions/u16"
+                            reserved:
+                                        $ref: "#/definitions/u16"
+
+            resasg_entries:
+                type: array
+                minItems: 0
+                maxItems: 468
+                items:
+                    type: object
+                    properties:
+                        start_resource:
+                            $ref: "#/definitions/u16"
+                        num_resource:
+                            $ref: "#/definitions/u16"
+                        type:
+                            $ref: "#/definitions/u16"
+                        host_id:
+                            $ref: "#/definitions/u8"
+                        reserved:
+                            $ref: "#/definitions/u8"
+
+    tifs-rm-cfg:
+        type: object
+        properties:
+            rm_boardcfg:
+                type: object
+                properties:
+                    rev:
+                        type: object
+                        properties:
+                            boardcfg_abi_maj:
+                                $ref: "#/definitions/u8"
+                            boardcfg_abi_min:
+                                $ref: "#/definitions/u8"
+
+                    host_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            host_cfg_entries:
+                                type: array
+                                minItems: 0
+                                maxItems: 32
+                                items:
+                                    type: object
+                                    properties:
+                                        host_id:
+                                            $ref: "#/definitions/u8"
+                                        allowed_atype:
+                                            $ref: "#/definitions/u8"
+                                        allowed_qos:
+                                            $ref: "#/definitions/u16"
+                                        allowed_orderid:
+                                            $ref: "#/definitions/u32"
+                                        allowed_priority:
+                                            $ref: "#/definitions/u16"
+                                        allowed_sched_priority:
+                                            $ref: "#/definitions/u8"
+                    resasg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            resasg_entries_size:
+                                        $ref: "#/definitions/u16"
+                            reserved:
+                                        $ref: "#/definitions/u16"
+
+            resasg_entries:
+                type: array
+                minItems: 0
+                maxItems: 468
+                items:
+                    type: object
+                    properties:
+                        start_resource:
+                            $ref: "#/definitions/u16"
+                        num_resource:
+                            $ref: "#/definitions/u16"
+                        type:
+                            $ref: "#/definitions/u16"
+                        host_id:
+                            $ref: "#/definitions/u8"
+                        reserved:
+                            $ref: "#/definitions/u8"
diff --git a/board/bsh/am623_ccm_m3/sec-cfg.yaml b/board/bsh/am623_ccm_m3/sec-cfg.yaml
new file mode 100644
index 0000000000..088b2dbaf1
--- /dev/null
+++ b/board/bsh/am623_ccm_m3/sec-cfg.yaml
@@ -0,0 +1,379 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Security management configuration for AM62
+#
+
+---
+
+sec-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
+    processor_acl_list:
+        subhdr:
+            magic: 0xF1EA
+            size: 164
+        proc_acl_entries:
+            -  # 1
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 2
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 3
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 4
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 5
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 6
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 7
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 8
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 9
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 10
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 11
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 12
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 13
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 14
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 15
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 16
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 17
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 18
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 19
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 20
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 21
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 22
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 23
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 24
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 25
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 26
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 27
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 28
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 29
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 30
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 31
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 32
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+    host_hierarchy:
+        subhdr:
+            magic: 0x8D27
+            size: 68
+        host_hierarchy_entries:
+            -  # 1
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 2
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 3
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 4
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 5
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 6
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 7
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 8
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 9
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 10
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 11
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 12
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 13
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 14
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 15
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 16
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 17
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 18
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 19
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 20
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 21
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 22
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 23
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 24
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 25
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 26
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 27
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 28
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 29
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 30
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 31
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 32
+                host_id: 0
+                supervisor_host_id: 0
+    otp_config:
+        subhdr:
+            magic: 0x4081
+            size: 69
+        write_host_id: 0
+        otp_entry:
+            -  # 1
+                host_id: 0
+                host_perms: 0
+            -  # 2
+                host_id: 0
+                host_perms: 0
+            -  # 3
+                host_id: 0
+                host_perms: 0
+            -  # 4
+                host_id: 0
+                host_perms: 0
+            -  # 5
+                host_id: 0
+                host_perms: 0
+            -  # 6
+                host_id: 0
+                host_perms: 0
+            -  # 7
+                host_id: 0
+                host_perms: 0
+            -  # 8
+                host_id: 0
+                host_perms: 0
+            -  # 9
+                host_id: 0
+                host_perms: 0
+            -  # 10
+                host_id: 0
+                host_perms: 0
+            -  # 11
+                host_id: 0
+                host_perms: 0
+            -  # 12
+                host_id: 0
+                host_perms: 0
+            -  # 13
+                host_id: 0
+                host_perms: 0
+            -  # 14
+                host_id: 0
+                host_perms: 0
+            -  # 15
+                host_id: 0
+                host_perms: 0
+            -  # 16
+                host_id: 0
+                host_perms: 0
+            -  # 17
+                host_id: 0
+                host_perms: 0
+            -  # 18
+                host_id: 0
+                host_perms: 0
+            -  # 19
+                host_id: 0
+                host_perms: 0
+            -  # 20
+                host_id: 0
+                host_perms: 0
+            -  # 21
+                host_id: 0
+                host_perms: 0
+            -  # 22
+                host_id: 0
+                host_perms: 0
+            -  # 23
+                host_id: 0
+                host_perms: 0
+            -  # 24
+                host_id: 0
+                host_perms: 0
+            -  # 25
+                host_id: 0
+                host_perms: 0
+            -  # 26
+                host_id: 0
+                host_perms: 0
+            -  # 27
+                host_id: 0
+                host_perms: 0
+            -  # 28
+                host_id: 0
+                host_perms: 0
+            -  # 29
+                host_id: 0
+                host_perms: 0
+            -  # 30
+                host_id: 0
+                host_perms: 0
+            -  # 31
+                host_id: 0
+                host_perms: 0
+            -  # 32
+                host_id: 0
+                host_perms: 0
+    dkek_config:
+        subhdr:
+            magic: 0x5170
+            size: 12
+        allowed_hosts: [128, 0, 0, 0]
+        allow_dkek_export_tisci: 0x5A
+        rsvd: [0, 0, 0]
+    sa2ul_cfg:
+        subhdr:
+            magic: 0x23BE
+            size: 0
+        auth_resource_owner: 0
+        enable_saul_psil_global_config_writes: 0x5A
+        rsvd: [0, 0]
+    sec_dbg_config:
+        subhdr:
+            magic: 0x42AF
+            size: 16
+        allow_jtag_unlock: 0x5A
+        allow_wildcard_unlock: 0x5A
+        allowed_debug_level_rsvd: 0
+        rsvd: 0
+        min_cert_rev: 0x0
+        jtag_unlock_hosts: [0, 0, 0, 0]
+    sec_handover_cfg:
+        subhdr:
+            magic: 0x608F
+            size: 10
+        handover_msg_sender: 0
+        handover_to_host_id: 0
+        rsvd: [0, 0, 0, 0]
diff --git a/configs/am62x_bsh-ccm-m3_a53_defconfig b/configs/am62x_bsh-ccm-m3_a53_defconfig
new file mode 100644
index 0000000000..e927b2ab9a
--- /dev/null
+++ b/configs/am62x_bsh-ccm-m3_a53_defconfig
@@ -0,0 +1,211 @@
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_TI_SECURE_DEVICE=y
+CONFIG_SYS_MALLOC_LEN=0x08000000
+CONFIG_SYS_MALLOC_F_LEN=0x9000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_SOC_K3_AM625=y
+CONFIG_K3_ATF_LOAD_ADDR=0x8a500000
+CONFIG_TARGET_AM625_A53_BSH_CCM_M3=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80B80000
+CONFIG_DM_GPIO=y
+CONFIG_SPL_DM_SPI=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62-ccm-m3"
+CONFIG_SPL_TEXT_BASE=0x80080000
+CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_SIZE_LIMIT=0x80000
+CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
+CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
+CONFIG_CONSOLE_MUX=y
+CONFIG_MISC_INIT_R=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_ADDR=0x80D00000
+CONFIG_SPL_MAX_SIZE=0x80000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x80c80000
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x900000
+CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
+CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1000
+CONFIG_SUPPORT_EMMC_BOOT_OVERRIDE_PART_CONFIG=y
+CONFIG_SYS_MMCSD_RAW_MODE_EMMC_BOOT_PARTITION=0
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD_LOAD=y
+CONFIG_SPL_NAND_SPI_SUPPORT=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62X U-Boot A53 SPL"
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_RAM_SUPPORT=y
+CONFIG_SPL_RAM_DEVICE=y
+# CONFIG_SPL_SPI_FLASH_TINY is not set
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPL_SPI_FLASH_MTD=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
+CONFIG_SPL_THERMAL=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_SPL_USB_STORAGE=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_SPL_DFU=y
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_BOARD_INIT=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SYS_MAXARGS=64
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_NET is not set
+CONFIG_CMD_CLS=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_UBI=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_DEVICE_REMOVE=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_CLK_TI_SCI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_MTD=y
+CONFIG_DFU_RAM=y
+CONFIG_DFU_SF=y
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x600000
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_TI_SCI_PROTOCOL=y
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_DM_PCA953X=y
+CONFIG_SPL_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_DM_MAILBOX=y
+CONFIG_K3_SEC_PROXY=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SPL_I2C_EEPROM=y
+CONFIG_FS_LOADER=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SF_DEFAULT_SPEED=5000000
+CONFIG_BOOTDEV_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_S28HX_T=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_SCI_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_TPS65219=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPL_DM_REGULATOR_GPIO=y
+CONFIG_K3_SYSTEM_CONTROLLER=y
+CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_REMOTEPROC_TI_K3_M4F=y
+CONFIG_RESET_TI_SCI=y
+CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
+CONFIG_SOC_TI=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_CADENCE_QSPI_PHY=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_TI_SCI=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_DWC3_AM62=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_SPL_GZIP=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_CMD_REMOTEPROC=y
+CONFIG_HUSH_PARSER=y
diff --git a/configs/am62x_bsh-ccm-m3_a53_usbdfu_defconfig b/configs/am62x_bsh-ccm-m3_a53_usbdfu_defconfig
new file mode 100644
index 0000000000..ef4484dc98
--- /dev/null
+++ b/configs/am62x_bsh-ccm-m3_a53_usbdfu_defconfig
@@ -0,0 +1,206 @@
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_TI_SECURE_DEVICE=y
+CONFIG_SYS_MALLOC_LEN=0x08000000
+CONFIG_SYS_MALLOC_F_LEN=0x9000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_SOC_K3_AM625=y
+CONFIG_K3_ATF_LOAD_ADDR=0x8a500000
+CONFIG_TARGET_AM625_A53_BSH_CCM_M3=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80B80000
+CONFIG_DM_GPIO=y
+CONFIG_SPL_DM_SPI=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62-ccm-m3"
+CONFIG_SPL_TEXT_BASE=0x80080000
+CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_SIZE_LIMIT=0x80000
+CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
+CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="setenv dfu_alt_info_flashenv uEnv.txt ram 0x82000000 0x10000000; setenv dfu_alt_info ${dfu_alt_info_flashenv}; dfu 0 ram 0; env import -t ${loadaddr} $filesize; run user_commands;"
+CONFIG_CONSOLE_MUX=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_MISC_INIT_R=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_ADDR=0x80D00000
+CONFIG_SPL_MAX_SIZE=0x80000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x80c80000
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x900000
+CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62X U-Boot A53 SPL"
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_RAM_SUPPORT=y
+CONFIG_SPL_RAM_DEVICE=y
+# CONFIG_SPL_SPI_FLASH_TINY is not set
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPL_SPI_FLASH_MTD=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
+CONFIG_SPL_THERMAL=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_SPL_USB_STORAGE=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_SPL_DFU=y
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_SYS_MAXARGS=64
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_NET is not set
+CONFIG_CMD_CLS=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_DEVICE_REMOVE=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_CLK_TI_SCI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_MTD=y
+CONFIG_DFU_RAM=y
+CONFIG_DFU_SF=y
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x600000
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_TI_SCI_PROTOCOL=y
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_DM_PCA953X=y
+CONFIG_SPL_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_DM_MAILBOX=y
+CONFIG_K3_SEC_PROXY=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SPL_I2C_EEPROM=y
+CONFIG_FS_LOADER=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SF_DEFAULT_SPEED=5000000
+CONFIG_BOOTDEV_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_S28HX_T=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_MTD_UBI=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_SCI_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_TPS65219=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPL_DM_REGULATOR_GPIO=y
+CONFIG_K3_SYSTEM_CONTROLLER=y
+CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_REMOTEPROC_TI_K3_M4F=y
+CONFIG_RESET_TI_SCI=y
+CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
+CONFIG_SOC_TI=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_CADENCE_QSPI_PHY=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_TI_SCI=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_DWC3_AM62=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_SPL_GZIP=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_CMD_REMOTEPROC=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_HUSH_PARSER=y
+
+
diff --git a/configs/am62x_bsh-ccm-m3_r5_defconfig b/configs/am62x_bsh-ccm-m3_r5_defconfig
new file mode 100644
index 0000000000..141c632764
--- /dev/null
+++ b/configs/am62x_bsh-ccm-m3_r5_defconfig
@@ -0,0 +1,150 @@
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_TI_SECURE_DEVICE=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x900000
+CONFIG_SYS_MALLOC_F_LEN=0x9000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_SOC_K3_AM625=y
+CONFIG_TARGET_AM625_R5_BSH_CCM_M3=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x43c3a7f0
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_OFFSET=0x600000
+CONFIG_DM_GPIO=y
+CONFIG_SPL_DM_SPI=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-ccm-m3"
+CONFIG_DM_I2C=y
+CONFIG_SPL_I2C=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+# CONFIG_TI_I2C_BOARD_DETECT is not defined
+CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_SPL_TEXT_BASE=0x43c00000
+CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x7000
+CONFIG_SPL_SIZE_LIMIT=0x3A7F0
+CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
+CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
+CONFIG_SPL_FIT_IMAGE_POST_PROCESS=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_MAX_SIZE=0x3B000
+CONFIG_SPL_PAD_TO=0x0
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x43c3b000
+CONFIG_SPL_BSS_MAX_SIZE=0x3000
+CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_SEPARATE_BSS=y
+CONFIG_SYS_SPL_MALLOC=y
+CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
+CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84005000
+CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_EARLY_BSS=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD_LOAD=y
+CONFIG_SPL_NAND_SPI_SUPPORT=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_RAM_SUPPORT=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_REMOTEPROC=y
+# CONFIG_SPL_SPI_FLASH_TINY is not set
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_ASKENV=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_TIME=y
+CONFIG_CMD_FAT=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=0
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_DEVICE_REMOVE=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_SPL_CLK_K3_PLL=y
+CONFIG_SPL_CLK_K3=y
+CONFIG_TI_SCI_PROTOCOL=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_DM_MAILBOX=y
+CONFIG_K3_SEC_PROXY=y
+CONFIG_SPL_MISC=y
+CONFIG_ESM_K3=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SF_DEFAULT_MODE=0
+CONFIG_SF_DEFAULT_SPEED=5000000
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_S28HX_T=y
+CONFIG_PINCTRL=y
+# CONFIG_PINCTRL_GENERIC is not set
+CONFIG_SPL_PINCTRL=y
+# CONFIG_SPL_PINCTRL_GENERIC is not set
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_POWER_DOMAIN=y
+CONFIG_K3_SYSTEM_CONTROLLER=y
+CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_RESET_TI_SCI=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
+CONFIG_SOC_TI=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_TIMER=y
+CONFIG_SPL_TIMER=y
+CONFIG_OMAP_TIMER=y
+CONFIG_LIB_RATIONAL=y
+CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x600000
+CONFIG_SYS_MALLOC_LEN=0x08000000
+
+#CONFIG_LOG=y
+#CONFIG_SPL_LOG=y
+#CONFIG_LOG_MAX_LEVEL=7
+#CONFIG_SPL_LOG_MAX_LEVEL=7
diff --git a/configs/am62x_bsh-ccm-m3_r5_usbdfu_defconfig b/configs/am62x_bsh-ccm-m3_r5_usbdfu_defconfig
new file mode 100644
index 0000000000..de3904447b
--- /dev/null
+++ b/configs/am62x_bsh-ccm-m3_r5_usbdfu_defconfig
@@ -0,0 +1,122 @@
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_TI_SECURE_DEVICE=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x900000
+CONFIG_SYS_MALLOC_F_LEN=0x9000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_SOC_K3_AM625=y
+CONFIG_TARGET_AM625_R5_BSH_CCM_M3=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x43c3a7f0
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_OFFSET=0x600000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-ccm-m3"
+CONFIG_SPL_TEXT_BASE=0x43c00000
+CONFIG_DM_RESET=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x7000
+CONFIG_SPL_SIZE_LIMIT=0x3A7F0
+CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
+CONFIG_SPL_FIT_IMAGE_POST_PROCESS=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
+CONFIG_SPL_MAX_SIZE=0x3B000
+CONFIG_SPL_PAD_TO=0x0
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x43c3b000
+CONFIG_SPL_BSS_MAX_SIZE=0x3000
+CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_SEPARATE_BSS=y
+CONFIG_SYS_SPL_MALLOC=y
+CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
+CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84000000
+CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_EARLY_BSS=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_RAM_SUPPORT=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_REMOTEPROC=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_SPL_DFU=y
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_ASKENV=y
+CONFIG_CMD_DFU=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_TIME=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=0
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_SPL_CLK_K3_PLL=y
+CONFIG_SPL_CLK_K3=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
+CONFIG_TI_SCI_PROTOCOL=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_DM_MAILBOX=y
+CONFIG_K3_SEC_PROXY=y
+CONFIG_MISC=y
+CONFIG_ESM_K3=y
+CONFIG_PINCTRL=y
+# CONFIG_PINCTRL_GENERIC is not set
+CONFIG_SPL_PINCTRL=y
+# CONFIG_SPL_PINCTRL_GENERIC is not set
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_POWER_DOMAIN=y
+CONFIG_K3_SYSTEM_CONTROLLER=y
+CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_RESET_TI_SCI=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
+CONFIG_SOC_TI=y
+CONFIG_TIMER=y
+CONFIG_SPL_TIMER=y
+CONFIG_OMAP_TIMER=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_LIB_RATIONAL=y
+CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_BOOTDELAY=0
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x600000
+CONFIG_SYS_MALLOC_LEN=0x08000000
diff --git a/include/configs/am62x_bsh-ccm-m3.h b/include/configs/am62x_bsh-ccm-m3.h
new file mode 100644
index 0000000000..d97699faa7
--- /dev/null
+++ b/include/configs/am62x_bsh-ccm-m3.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration header file for K3 AM625 SoC family
+ *
+ * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ *	Suman Anna <s-anna@ti.com>
+ */
+
+#ifndef __CONFIG_BSH_AM625_EVM_H
+#define __CONFIG_BSH_AM625_EVM_H
+
+#include <config_distro_bootcmd.h>
+
+/* DDR Configuration */
+#define CFG_SYS_SDRAM_BASE1             0x880000000
+
+/*
+ * We setup defaults based on constraints from the Linux kernel, which should
+ * also be safe elsewhere.  We have the default load at 32MB into DDR (for
+ * the kernel), FDT above 128MB (the maximum location for the end of the
+ * kernel), and the ramdisk 512KB above that (allowing for hopefully never
+ * seen large trees).  We say all of this must be within the first 256MB
+ * as that will normally be within the kernel lowmem and thus visible via
+ * bootm_size and we only run on platforms with 256MB or more of memory.
+ *
+ * As a temporary storage for DTBO blobs (which should be applied into DTB
+ * blob), we use the location 15.5 MB above the ramdisk. If someone wants to
+ * use ramdisk bigger than 15.5 MB, then DTBO can be loaded and applied to DTB
+ * blob before loading the ramdisk, as DTBO location is only used as a temporary
+ * storage, and can be re-used after 'fdt apply' command is done.
+ */
+
+#define DEFAULT_LINUX_BOOT_ENV \
+	"loadaddr=0x82000000\0" \
+	"kernel_addr_r=0x82000000\0" \
+	"fdtaddr=0x85000000\0" \
+	"dtboaddr=0x86000000\0" \
+	"fdt_addr_r=0x85000000\0" \
+	"fdtoverlay_addr_r=0x86000000\0" \
+	"rdaddr=0x85080000\0" \
+	"ramdisk_addr_r=0x85080000\0" \
+	"scriptaddr=0x80000000\0" \
+	"pxefile_addr_r=0x80100000\0" \
+	"bootm_size=0x4000000\0" \
+	"boot_fdt=try\0"
+
+#define DEFAULT_FIT_TI_ARGS \
+	"boot_fit=0\0" \
+	"addr_fit=0x8e000000\0" \
+	"name_fit=fitImage\0" \
+	"update_to_fit=setenv loadaddr ${addr_fit}; setenv bootfile ${name_fit}\0" \
+	"get_overlaystring=" \
+		"for overlay in $name_overlays;" \
+		"do;" \
+		"setenv overlaystring ${overlaystring}'#'${overlay};" \
+		"done;\0" \
+	"get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}\0" \
+	"run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}\0" \
+
+/*
+ * DDR information.  If the CONFIG_NR_DRAM_BANKS is not defined,
+ * we say (for simplicity) that we have 1 bank, always, even when
+ * we have more.  We always start at 0x80000000, and we place the
+ * initial stack pointer in our SRAM. Otherwise, we can define
+ * CONFIG_NR_DRAM_BANKS before including this file.
+ */
+#define CFG_SYS_SDRAM_BASE		0x80000000
+
+/* If DM_I2C, enable non-DM I2C support */
+
+/*
+ * The following are general good-enough settings for U-Boot.  We set a
+ * large malloc pool as we generally have a lot of DDR, and we opt for
+ * function over binary size in the main portion of U-Boot as this is
+ * generally easily constrained later if needed.  We enable the config
+ * options that give us information in the environment about what board
+ * we are on so we do not need to rely on the command prompt.  We set a
+ * console baudrate of 115200 and use the default baud rate table.
+ */
+
+/* As stated above, the following choices are optional. */
+
+/* Console I/O Buffer Size */
+/*
+ * When we have SPI, NOR or NAND flash we expect to be making use of
+ * mtdparts, both for ease of use in U-Boot and for passing information
+ * on to the Linux kernel.
+ */
+
+/*
+ * Our platforms make use of SPL to initalize the hardware (primarily
+ * memory) enough for full U-Boot to be loaded. We make use of the general
+ * SPL framework found under common/spl/.  Given our generally common memory
+ * map, we set a number of related defaults and sizes here.
+ */
+#if !defined(CONFIG_NOR_BOOT) && \
+	!(defined(CONFIG_QSPI_BOOT) && defined(CONFIG_AM43XX))
+
+/*
+ * We also support Falcon Mode so that the Linux kernel can be booted
+ * directly from SPL. This is not currently available on HS devices.
+ */
+
+/*
+ * Place the image at the start of the ROM defined image space (per
+ * CONFIG_SPL_TEXT_BASE and we limit our size to the ROM-defined
+ * downloaded image area minus 1KiB for scratch space.  We initalize DRAM as
+ * soon as we can so that we can place stack, malloc and BSS there.  We load
+ * U-Boot itself into memory at 0x80800000 for legacy reasons (to not conflict
+ * with older SPLs).  We have our BSS be placed 2MiB after this, to allow for
+ * the default Linux kernel address of 0x80008000 to work with most sized
+ * kernels, in the Falcon Mode case.  We have the SPL malloc pool at the end
+ * of the BSS area.  We suggest that the stack be placed at 32MiB after the
+ * start of DRAM to allow room for all of the above (handled in Kconfig).
+ */
+
+#ifdef CONFIG_SPL_OS_BOOT
+/* FAT */
+
+/* RAW SD card / eMMC */
+#endif
+
+/* General parts of the framework, required. */
+
+#ifdef CONFIG_MTD_RAW_NAND
+#define CFG_SYS_NAND_U_BOOT_START	CONFIG_TEXT_BASE
+#endif
+#endif /* !CONFIG_NOR_BOOT */
+
+/* Generic Environment Variables */
+
+#ifdef CONFIG_CMD_NET
+#define NETARGS \
+	"static_ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}" \
+		"::off\0" \
+	"nfsopts=nolock\0" \
+	"rootpath=/export/rootfs\0" \
+	"netloadimage=tftp ${loadaddr} ${bootfile}\0" \
+	"netloadfdt=tftp ${fdtaddr} ${fdtfile}\0" \
+	"netargs=setenv bootargs console=${console} " \
+		"${optargs} " \
+		"root=/dev/nfs " \
+		"nfsroot=${serverip}:${rootpath},${nfsopts} rw " \
+		"ip=dhcp\0" \
+	"netboot=echo Booting from network ...; " \
+		"setenv autoload no; " \
+		"dhcp; " \
+		"run netloadimage; " \
+		"run netloadfdt; " \
+		"run netargs; " \
+		"bootz ${loadaddr} - ${fdtaddr}\0"
+#else
+#define NETARGS ""
+#endif
+
+#ifdef CONFIG_ARM64
+
+#ifdef CONFIG_DISTRO_DEFAULTS
+
+#ifdef CONFIG_CMD_MMC
+#define BOOT_TARGET_MMC(func) \
+	func(MMC, mmc, 0) \
+	func(MMC, mmc, 1)
+#else
+#define BOOT_TARGET_MMC(func)
+#endif
+
+#ifdef CONFIG_CMD_UBIFS
+#define BOOT_TARGET_UBIFS(func) func(UBIFS, ubifs, 0, UBI, boot)
+#else
+#define BOOT_TARGET_UBIFS(func)
+#endif
+
+#ifdef CONFIG_CMD_USB
+# define BOOT_TARGET_USB(func)	func(USB, usb, 0)
+#else
+# define BOOT_TARGET_USB(func)
+#endif
+
+
+#define BOOT_TARGET_DEVICES(func) \
+	BOOT_TARGET_MMC(func) \
+	BOOT_TARGET_UBIFS(func) \
+	BOOT_TARGET_USB(func)
+
+#include <config_distro_bootcmd.h>
+
+/* Incorporate settings into the U-Boot environment */
+#define CFG_EXTRA_ENV_SETTINGS					\
+	BOOTENV
+
+#endif
+
+#endif /* CONFIG_ARM64 */
+
+
+#define BSH_CONVENIENCE_SETTINGS \
+        "bsh_emmc_boot=run envboot; run distro_bootcmd\0"
+
+#define CONFIG_EXTRA_ENV_SETTINGS					\
+	BSH_CONVENIENCE_SETTINGS
+
+#endif /* __CONFIG_BSH_AM625_EVM_H */
-- 
2.34.1

