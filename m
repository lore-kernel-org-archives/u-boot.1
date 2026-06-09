Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E0ACD8CB9
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 16:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 653E284942;
	Tue,  9 Jun 2026 18:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="0BEaGLVO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D7BA848DC; Tue,  9 Jun 2026 18:52:49 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 723A084942
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 18:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso67051535e9.3
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 09:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1781023967; x=1781628767; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RO1Sc3RdY75iviqvthqViYzO1jA1tp+5USBwkrCqbHc=;
 b=0BEaGLVOsDOHQaT0vZ6UwEGJTV5EFsxyVKFmm+Swi5PlDo4DLWBbZ2nHWbEshuqpRl
 UVglUyyb1KIbVl2nM6NSGu8KM3ZH37iqSwpMtziVQ+TQWKv3U9F4Qy+8tR81sUk+mQ6L
 LSFlpaTH/c6gOndY49apiIwnOg9+LtI/JMa1WO42O1znapnFw/4wQBplCzZEHcY3bA5T
 HW2u8lpQgdWW8f5OsxMMjOQuKU7iQAauwDQQ7tZlY/wAIeYK3ue+htGvmRRWnSzdVg7O
 S4EPWSOr8b+Vir48NkIfyUHPS0SqmzAVmiWQiO08xAfVU9OBhYlGND3TdhOu0Bd2vHGQ
 Qurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781023967; x=1781628767;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RO1Sc3RdY75iviqvthqViYzO1jA1tp+5USBwkrCqbHc=;
 b=igu5+PK1Ul0NHNmvmZ8Ayc9y8QqDKu/Uheq94zdPkg6JelSNg/QN7FI0VX3fqd30Z4
 LyPu0Pqhx5OWcNEO25ummg3ur6boNAmTPxcWDAMXi94YagwBp4PptZKVG7foWV2rO+oo
 Hga5Jd0s0fNJbtucvfarjgFafZ3sDaQy4EZqudVM2zzMPnrwatyUgs26OdpAU6qejruP
 zMO+/nJBHY7m0znBThsnY30JzkiB78hZOpEWzRUgA1d4LOsDaYDV8MppKzQVppWgYjtY
 2DGMNZqM4U55YeYrS1+7EF4VRR/jXdichu9dEXhjgJ9ukLUYhXdnr9pc7RIOhGg7A0Cc
 e1XA==
X-Gm-Message-State: AOJu0YzSagDXYPx/tGp9s2y/Wrnh9Z5eXNAo4PXHXDej+mAv+ZA3WBF6
 WTuZIwu+E4isxEi3odTKLAIEN2tpYzOzNXUA191R8gSI+sJ5pNjUrVyg1jVWd5PEsNA=
X-Gm-Gg: Acq92OFId9s7wUdrlYN/tvPV8QAsWqwZVK0ZackLNbMgzExP9OGuTuzsNZ1/EkP7YBz
 eO5+GMduzsKd739fFatq7VFT8rdufUo7RALGHkrBLsrhXovNYjY8FUpaith0x31Mh6BJXJpuY2g
 Osz9E6aaHvtApl9tpfRuWNQl1vFkKpVIBt10U38APuzV3K9wFQZfVJ+roLwgUXmb99TmgAABTCf
 xS4pWY50shVA99CAg+xCKEzAy8oXwcXsA+KUT236zzSHwltEyReya8A/tbmFzunlDGIpvi0siE+
 LGS9l7gsMgq1IJZwW8RJhUfhR2HLy5YyN4/9YVR109khbN7LOmIG/3WejXIqDbptyqr3KnakI9T
 kyk2Vhjzijk6eeGGj2uevz0j7bAg4lKTkzhMK2n+KXUBtZ/GU+Os9ROTdBwMRpg1aSXgBmr8tBo
 1ApJB5XGKdN+Rzl3gzWN1iBPz3eDdnFvGfv5iiKI2SpVephdy7eqY=
X-Received: by 2002:a05:600c:3ba4:b0:490:bad9:de43 with SMTP id
 5b1f17b1804b1-490c2525dacmr379437065e9.0.1781023966905; 
 Tue, 09 Jun 2026 09:52:46 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3b5b06sm450121115e9.3.2026.06.09.09.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 09:52:46 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 09 Jun 2026 20:52:27 +0400
Subject: [PATCH 4/4] rockchip: binman: Add support for Falcon mode FIT
 images with ATF+Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-atf-falcon-v1-4-2b20c5e83615@flipper.net>
References: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
In-Reply-To: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5972; i=alchark@flipper.net;
 h=from:subject:message-id; bh=GSMHFK2R1ayT8xC335OuH2CtbW1a0IwzvWJBtjSlXiQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRpuJyZxnEm/mX4vP/rLq7wDIirr5Re4JP0R4mT/z7zM
 xsdPr+/HRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEy1Zw/Dfwdd+0LZb2/LLJzer7pp8rfpO2f+qoo3T6x4t3Ht+jcr6i8jwzLXBYf
 ilr8ynz3vxwf23IOvlh6eVGW7zPzNtNp/Z/a/sGAEAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Modern Rockchip SoCs such as RK3576 require ATF to be running to provide
firmware services to the OS. To enable booting Linux in Falcon mode on
such SoCs, add binman support for generation of FIT images containing
appropriately split ATF raw binaries (as is currently done by binman for
U-boot proper images), externally preprocessed DTB and a Linux kernel.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 Makefile                           |   2 +
 arch/arm/dts/rockchip-u-boot.dtsi  | 109 +++++++++++++++++++++++++++++++++++++
 tools/binman/etype/falcon_fdt.py   |  26 +++++++++
 tools/binman/etype/linux_kernel.py |  22 ++++++++
 4 files changed, 159 insertions(+)

diff --git a/Makefile b/Makefile
index 4e5c1dd6a1c4..844e5adb7b31 100644
--- a/Makefile
+++ b/Makefile
@@ -1690,6 +1690,8 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		$(foreach f,$(BINMAN_INDIRS),-I $(f)) \
 		-a atf-bl1-path=${BL1} \
 		-a atf-bl31-path=${BL31} \
+		-a linux-kernel-path=${LINUX_KERNEL} \
+		-a falcon-fdt-path=${FALCON_FDT} \
 		-a tee-os-path=${TEE} \
 		-a ti-dm-path=${TI_DM} \
 		-a opensbi-path=${OPENSBI} \
diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 4ba6a87e78ab..866a6ab654ca 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -161,6 +161,96 @@
 			};
 		};
 	};
+
+#ifdef CONFIG_SPL_OS_BOOT
+	fit_falcon_template: template-falcon {
+		type = "fit";
+		description = "FIT image for Falcon Linux with bl31 (TF-A)";
+		#address-cells = <1>;
+		fit,fdt-list-val = "u-boot";
+		fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
+		fit,align = <512>;
+
+		images {
+			@atf-SEQ {
+				fit,operation = "split-elf";
+				description = "ARM Trusted Firmware";
+				type = "firmware";
+				arch = FIT_ARCH;
+				os = "arm-trusted-firmware";
+				compression = "none";
+				fit,load;
+				fit,entry;
+				fit,data;
+
+				atf-bl31 {
+				};
+#ifdef FIT_HASH_ALGO
+				hash {
+					algo = FIT_HASH_ALGO;
+				};
+#endif
+			};
+
+			kernel {
+				description = "Linux kernel";
+				type = "kernel";
+				arch = FIT_ARCH;
+				os = "linux";
+				compression = "none";
+				load = <0x48000000>;
+				entry = <0x48000000>;
+
+				linux-kernel {
+				};
+#ifdef FIT_HASH_ALGO
+				hash {
+					algo = FIT_HASH_ALGO;
+				};
+#endif
+			};
+
+			fdt-1 {
+				description = "falcon-fdt";
+				type = "flat_dt";
+				arch = FIT_ARCH;
+				compression = "none";
+				load = <0x52000000>;
+
+				falcon-fdt {
+				};
+#ifdef FIT_HASH_ALGO
+				hash {
+					algo = FIT_HASH_ALGO;
+				};
+#endif
+			};
+		};
+
+		configurations {
+			default = "config-1";
+			@config-SEQ {
+				description = "RK3576 Falcon Linux via ATF";
+				fit,firmware = "atf-1", "kernel";
+				fit,loadables;
+				fdt = "fdt-SEQ";
+#ifdef FIT_HASH_ALGO
+				hash {
+					algo = FIT_HASH_ALGO;
+				};
+#endif
+			};
+		};
+	};
+
+	falcon-fit {
+		filename = "u-boot-rockchip-falcon.itb";
+
+		fit {
+			insert-template = <&fit_falcon_template>;
+		};
+	};
+#endif
 #endif /* HAS_FIT */
 
 	simple-bin {
@@ -260,6 +350,25 @@
 		};
 		};
 	};
+
+#ifdef CONFIG_SPL_OS_BOOT
+	simple-bin-usb472-falcon {
+		filename = "u-boot-rockchip-usb472-falcon.bin";
+		pad-byte = <0x00>;
+
+		u-boot-spl {
+		};
+
+		payload {
+			type = "section";
+			align = <CONFIG_SYS_CACHELINE_SIZE>;
+			u-boot-any {
+				type = "fit";
+				insert-template = <&fit_falcon_template>;
+			};
+		};
+	};
+#endif
 #endif /* CONFIG_ROCKCHIP_MASKROM_IMAGE */
 };
 #endif /* CONFIG_SPL */
diff --git a/tools/binman/etype/falcon_fdt.py b/tools/binman/etype/falcon_fdt.py
new file mode 100644
index 000000000000..7c5b13b60d05
--- /dev/null
+++ b/tools/binman/etype/falcon_fdt.py
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2026 Flipper FZCO
+#
+# Entry type for Linux DTB used in Falcon mode FIT images.
+
+from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
+
+
+class Entry_falcon_fdt(Entry_blob_named_by_arg):
+    """Falcon Linux DTB for Rockchip maskrom Falcon image
+
+    Properties / Entry arguments:
+        - falcon-fdt-path: Filename containing the Falcon Linux DTB (optional,
+            defaults to 'u-boot.dtb')
+
+    This allows selecting the Falcon DTB from an environment variable passed
+    through binman entry arguments, while defaulting to the built U-Boot
+    control DTB when not provided.
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node, 'falcon-fdt')
+        # Entry_blob defaults filename to etype when no filename is provided.
+        # Treat that as "unset" and fall back to the control DTB.
+        if not self._filename or self._filename == self.etype:
+            self._filename = 'u-boot.dtb'
diff --git a/tools/binman/etype/linux_kernel.py b/tools/binman/etype/linux_kernel.py
new file mode 100644
index 000000000000..15a1da690c4f
--- /dev/null
+++ b/tools/binman/etype/linux_kernel.py
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2026 Flipper FZCO
+#
+# Entry-type module for Linux kernel binary blob
+
+from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
+
+
+class Entry_linux_kernel(Entry_blob_named_by_arg):
+    """Linux kernel image blob
+
+    Properties / Entry arguments:
+        - linux-kernel-path: Filename of file to read into entry. This is
+            typically an uncompressed ARM64 Image.
+
+    This entry allows binman FIT templates to consume a kernel provided via
+    make variable, similar to how BL31 is passed to atf-bl31.
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node, 'linux-kernel', required=True)
+        self.external = True

-- 
2.53.0

