Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F04FC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 335F282027;
	Fri, 28 Mar 2025 16:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jSF1Cbm6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CA8981FBC; Fri, 28 Mar 2025 16:36:16 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECBD4809A5
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d43c972616so6563865ab.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176172; x=1743780972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8u6lKZZBPmpU3gfDZju8XpcWyW21eWUZSV939N/sPHc=;
 b=jSF1Cbm6ZELn907IAwlEjUbUn+CQxpaZX7e9VswYEWHvjetUsluiAK2xKP4il5DnRY
 eIzu73sdpdEzyc+F0mzO70+WgFe0HpluYcRlO3lZb7VH8xytKXBfvFKNTh15M8bS8zYN
 nybPAih2G6ZzpEoAt5iDchTfBARJSbyDk8KWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176172; x=1743780972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8u6lKZZBPmpU3gfDZju8XpcWyW21eWUZSV939N/sPHc=;
 b=Cq2AdTZXN0S4sgH34mXs83A3P48S0hOnPsHSv3NzMzuAgoS5oVOMFXL2bEH6D/vEkM
 xrVRH/3mmtNnVtCHjZmikr+W5BPFT4Qw2XXAhTZdn+QfZP05EDwexYi/0tBNaPxFMcCm
 BkOme2QnDLr6O6Q9ltTy0Ptbzny07J4+NmGRoW01261LLMD5atlrwUFYkdmeev6OWdM0
 vd3kR0eDBzXtrhCUdgk51LHhfUHuALe9B2iNV0mLcDlb46F4lXNhuhtHanFL6v+Y1NRE
 qoKL1fYBWy4fFd1mmfGJeUGptYhx7CxJ5IjuMRuDaswMjhti1bgDBOSi7DnOq0zasG2m
 ZJ2A==
X-Gm-Message-State: AOJu0Yz7R+d3YkzAx5z58UJTwOApNVzxkZsZbmauhhO3aAGlt+cantGi
 GiwUX+4oBJkI1Sg5L/zvOoRugdMldSfDQkgwEgDtyI/2oGGJX3JeW/kmQfjehXHhZiesN0Qxie0
 =
X-Gm-Gg: ASbGnctSvoSjtHlri3pPCay8rKh+G4zN2CdjgCEuHUBboFSHP16w2LmNvmeo6XOpRiC
 iLjZvgCi+3U36ri5c4Kl/LcRVDSf7Gt82MMvhs5mliskydNwNeeI9zwp2cbDncNoqjVQ4LH/5cB
 9twhpNMm6ijbP3a/n6fEGLTuvceB3Hlg6cnYrBW/bo4HFSsOBam+YNl4VDTgDg7ngtJ6xnBftAj
 bT4p+wv+ZhsquUGqPxU/qrtrnQ+YLfTEWRPSMShqvdTlqU7eVzmh9HWsVzr/Q2xRoYHi3r72ohO
 12tuuGIKxBXFyeKunku13egQCQUd6PnVsngPEAY+HC9wNQG00tqiQi1HhXNiIIU7A2e+pD86RCY
 6Dvu5Hw==
X-Google-Smtp-Source: AGHT+IEqlcSdhKxK+J03YOLt2Dd4M8T+W16El+8JTWKhVqbbLU3zt2ArOMkHU7lSw2bwgW6tnQlYKQ==
X-Received: by 2002:a05:6e02:4401:10b0:3a9:cde3:2ecc with SMTP id
 e9e14a558f8ab-3d5d6cfd363mr24377755ab.6.1743176171927; 
 Fri, 28 Mar 2025 08:36:11 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 16/31] rockchip: Add a VPL image
Date: Fri, 28 Mar 2025 09:34:56 -0600
Message-ID: <20250328153522.3555472-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

The VPL image is immutable and has a single VPL binary plus a devicetree
for each board we need to support.

The devicetree is run through fdtgrep to remove unwanted nodes and
properties and reduce its size.

Changes in v2:
- Move VPL things into a separate file

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 91 +++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index d15c593bf7f..eee57db5478 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -109,4 +109,95 @@
 			};
 		};
 	};
+
+	simple-bin {
+		vpl {
+			type = "fit";
+			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200 + 0x8000)>;
+			description = "FIT image for U-Boot TPL";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+			fit,align = <512>;
+			fit,external-offset = <0>;
+			images {
+				image-vpl {
+					description = "U-Boot VPL";
+					type = "firmware";
+					os = "u-boot";
+					arch = ARCH;
+					compression = "lz4";
+					load = <CONFIG_VPL_TEXT_BASE>;
+					entry = <CONFIG_VPL_TEXT_BASE>;
+					section {
+						compress = "lz4";
+						u-boot-vpl-nodtb {
+							symbols-base = <0>;
+						};
+						u-boot-vpl-bss-pad {
+						};
+					};
+				};
+				@fdt-SEQ {
+					description = "fdt-NAME";
+					compression = "none";
+					type = "flat_dt";
+					fit,fdt-phase = "vpl";
+				};
+			};
+			configurations {
+				default = "@config-DEFAULT-SEQ";
+				@config-SEQ {
+					description = "NAME.dtb";
+					fdt = "fdt-SEQ";
+					fit,firmware = "image-vpl";
+					fit,loadables;
+					fit,compatible;
+				};
+			};
+		};
+# ifdef CONFIG_BOOTMETH_VBE_ABREC
+		vbe-a {
+			type = "section";
+			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
+			spl-a {
+				insert-template = <&spl_template>;
+				size = <0x100000>;
+			};
+
+			u-boot-a {
+				insert-template = <&common_part>;
+			};
+		};
+		vbe-b {
+			type = "section";
+			offset = <0x1000000>;
+			spl-b {
+				insert-template = <&spl_template>;
+				size = <0x100000>;
+			};
+
+			u-boot-b {
+				insert-template = <&common_part>;
+			};
+		};
+		vbe-recovery {
+			type = "section";
+			offset = <0x1800000>;
+			spl-recovery {
+				insert-template = <&spl_template>;
+				size = <0x100000>;
+			};
+
+			u-boot-recovery {
+				insert-template = <&common_part>;
+			};
+		};
+# else /* CONFIG_BOOTMETH_VBE_SIMPLE */
+		vbe {
+			type = "fit";
+			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
+			insert-template = <&common_part>;
+		};
+# endif /* VBE method */
+	};
 };
-- 
2.43.0

