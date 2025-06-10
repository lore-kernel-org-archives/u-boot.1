Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA3EC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 12:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C7E82C30;
	Tue, 10 Jun 2025 14:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nsLEaQZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 111AA82A65; Tue, 10 Jun 2025 09:41:52 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7F8F80C83
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2345c60507bso36022335ad.0
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 00:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749541308; x=1750146108; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXRZhKuw246mm7AHz93P6EMaorBvvL8ZJabMvvCjWzw=;
 b=nsLEaQZn5u4yKQxH9Q9lqOaUICJWTZEaQ5bspX7Jc+JAMC8RIJySDF5UekdVTvxpFH
 qVio7oj1cXW/mB/oyP77zi9Ar1NC71IxyZOxNZ1Bpj4MijnmAiFZYChlQ0ode3aCcdvV
 7fjuCS6G2Fa896owxCfyzvRRVBJpYlXXVjh1YC7RZmgkTDmqyjmBB0ciJ9FsZOJ869V/
 Swjw1wnkwLEr+4jsfDPxsXAJ8fAgHa9SlAVtDlWZVw1o0gPjFc2gqk21923dA1FVMe1n
 AuUBCpA/8pSd8aP+WETEzRbhWuVXLpysdaT//H4hSOrYV7aAbzM8OOyaD52uaSFOutV2
 9e4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749541308; x=1750146108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FXRZhKuw246mm7AHz93P6EMaorBvvL8ZJabMvvCjWzw=;
 b=pVMRB2lVOdW2A1Id4hdSUvwnashpfdka8FukkCkF9UiEAfNHIte2faKk/f6BL/fmM8
 rxFBBAZ0Sjv5mbczu5I58j3J+azYSnksnf2oNW+KSSauAZim9A4gtIiG36w8Vhj7VzkA
 qW+U+RFc3TL6U1uFBSH4PckNu1HvIEjfBQ71EfzlQTF9kGDr+XtG9J4yE8BoxNYs6D3E
 OuszAQQ9nb9WHSOWBnf+TSLAMkJHba4wb2I4fSpZ1nAuNrB3qQK/W/aeu+4M8DBhS3eD
 CXFTD+gblluvpyaEVUTM54WWMNRXBHJ8Zca4A1pL9E0qlMCOwK79SNf4i8qL9FtXjI6w
 dpeQ==
X-Gm-Message-State: AOJu0Ywpseq179x+wI08rd5V2SRqPJr6rN1h2j7PWp/mjBJ/Ba/P3wx2
 zrCHjyFaGOlhb0s6X4aWcnjmJ0qytK0JDSb5zDrKFFLzkbeW80IV09uBSu1YmNFl
X-Gm-Gg: ASbGncvI+DiBNtS1Ue5BZSeJguKesNHWwF9lqHJjDcgxgdxPXOhiejPNU3/10y7v0HM
 Sx58+k6tUi9CDCC3TdcPfqw2UUcLLjNfRo3HXtPC/uJpd4FierAH7O+qaUs3z7Ehj6EODH57134
 prkkXXjA9WzDYmsJqT2e8cIggA5Hs8gHq+79PewhN3W4gyiryhGkTnA99TNi2NeI71wB/TrE5V/
 wHM6oiSu6v38n+mDOY7MArFFz7apU9AAEhoxnIb4n35ti9J80HyG6doYjEtD5zevLqRCTJzEVP/
 d05P8phUwplifxjcaIrxen6CKv1TQXhRoNkTnmdTG+EaIheZ/JK0aDa+xYBj2bcNO+HdYrJa98J
 VdbSlXBJ+ZGptT4UwaZ1cvLXd2tv/v5I8B7s=
X-Google-Smtp-Source: AGHT+IHjdQkXgLXbvrsbC2DN7Gpt94fa86uiTOj2BPT2K7/Y82bZix7nNRVOXrKXmIaRd+jGhWA35g==
X-Received: by 2002:a17:903:98d:b0:22d:b243:2fee with SMTP id
 d9443c01a7336-23601d05923mr181344825ad.13.1749541308081; 
 Tue, 10 Jun 2025 00:41:48 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603092640sm65201945ad.54.2025.06.10.00.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 00:41:47 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com,
 paul.henrys_ext@softathome.com, d-gole@ti.com, afd@ti.com,
 d.schultz@phytec.de, nm@ti.com, n-francis@ti.com, alpernebiyasak@gmail.com
Subject: [PATCH v4 5/5] arm: dts: phycore-am62x: Add missing tifsstub image
 nodes for FIT loadables
Date: Tue, 10 Jun 2025 07:41:21 +0000
Message-ID: <20250610074121.8308-6-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610074121.8308-1-aristo.chen@canonical.com>
References: <20250610074121.8308-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Jun 2025 14:57:04 +0200
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

The phycore-am62x build was broken due to mkimage reporting an undefined
'image "tifsstub-hs"' in the 'loadables' property of the FIT configuration.
This occurred because the `loadables` field referenced `tifsstub-hs`,
`tifsstub-fs`, and `tifsstub-gp`, but no corresponding nodes were defined
under /images.

This patch was inspired by commit 622f826bf025704cbcc4f39252d4a83129a9cabb
("arm: dts: phycore-am62x: Package TIFS Stub"). It resolves the issue by
adding proper Binman nodes for each TIFS variant (`tifsstub-hs`,
`tifsstub-fs`, and `tifsstub-gp`).

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 9b536d679af..b01bc5dfead 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -405,11 +405,105 @@
 };
 
 &binman {
+	tifsstub-hs {
+		filename = "tifsstub.bin_hs";
+		ti-secure-rom {
+			content = <&tifsstub_hs_cert>;
+			core = "secure";
+			load = <0x40000>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "custMpk.pem";
+			countersign;
+			tifsstub;
+		};
+		tifsstub_hs_cert: tifsstub-hs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		tifsstub_hs_enc: tifsstub-hs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+	tifsstub-fs {
+		filename = "tifsstub.bin_fs";
+		tifsstub_fs_cert: tifsstub-fs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		tifsstub_fs_enc: tifsstub-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+
+	};
+
+	tifsstub-gp {
+		filename = "tifsstub.bin_gp";
+		ti-secure-rom {
+			content = <&tifsstub_gp>;
+			core = "secure";
+			load = <0x60000>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "ti-degenerate-key.pem";
+			tifsstub;
+		};
+		tifsstub_gp: tifsstub-gp.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
 	ti-spl_unsigned {
 		insert-template = <&ti_spl_unsigned_template>;
 
 		fit {
 			images {
+				tifsstub-hs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+
+				tifsstub-fs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+
+				tifsstub-gp {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-gp";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_gp";
+					};
+				};
+
 				dm {
 					ti-dm {
 						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-- 
2.43.0

