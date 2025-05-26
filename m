Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1930C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A2338373B;
	Mon, 26 May 2025 12:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GG1BwQxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3810383768; Mon, 26 May 2025 12:16:23 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1026283721
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3dca2473129so11879905ab.2
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254579; x=1748859379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0MI/fz0KFDpLxoxm1fSOyvbwQUBPs1o7oED+Zh3KPU=;
 b=GG1BwQxlmUISRcp64aJ1GLNd6hXkaLuqOfIxuiIYZDrrbyu5lTlG80YGNttak+5q90
 FNdAjlUQl4o4DxVTOEUCBDy9YYLz9VVAgwCM86P9K4XehXt+1X62gU9zmActZG4S1FUU
 PGwg8p+VzT9u4VlfDm8w/UdrEz1pS61rL8x2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254579; x=1748859379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0MI/fz0KFDpLxoxm1fSOyvbwQUBPs1o7oED+Zh3KPU=;
 b=j0Xw6UqP4LRBwWrKEy8gIO8z+FsIhuXFGrmDKBXClcFjLeZhNutFpCB2KzvVO1SDe6
 OToaaM8Q7rmOvkD4murcKBNQHdRNZojz8fWzdPkVgDiUS11x+Ovke36Sed0D8a9Z5zOd
 x5Ac8uadrW0t18sb3ccAUk35X+/Z/5KqQmFG44vsgn/lAEKSNHUoZ1FKzWdNYB6eKDX2
 lajt8PZdfnDQiqoNCnGKuiL1RYQZd8E6UDB3P0ZfjmCt7HR8Mg6nfPop8CBE/UZhE76o
 UYlW1nFVnVFmQXEspWyN0OaswmmXtpqyI2rr5BSX+7qGzoCXg40G9BZQ84P/BZERfIIa
 KtWA==
X-Gm-Message-State: AOJu0Yx4IdC7d+U4wSZWOixPWySMryO1g/dB1G9R3ePFvdHRXWDsQG+M
 4wB3qf/MKkYXc3w23ImOx0/uoXy5TGX4KWFlliOrXaowg3yooEMCaiB71pXBHomwFn//ntTPUso
 wO62rWu5Z
X-Gm-Gg: ASbGncuCkigN9g2KCMuzFY74zRD+NLN6cZMP413D8Evz7t6iktzMIx3qiTv+mmKq4GM
 EvGBYCqh9HCdlNN7ZnHbCTwO31zF3CKxyYICVkJxKmk6Ah3fjVSLTDT0+RWpEz4+qkjaRWiWkqV
 JqyJ7lCWT5w/9kFBjCohuRjf4o/uLAAWTxtq/mU3IoegdEBHkpdXrC7D9s5BfZ25h55l8Pg4CqB
 EhwkrPTnFOemHl8jQJ4CyrDDJmGqYdH3CwIQtVThzevP6IQl5oxSpasBVuTQ9Ug2R8+noY1lODl
 rtUFXyRZC1BrqV84qqZI/HxzMFhnAZKfxvNKa3ooMW/JqH4KK6vDG/E0ILDeI44qUhJnydKnkIX
 CdT13fta7MOKFiEhX1jRriek=
X-Google-Smtp-Source: AGHT+IF9+vmDCpX771V8kqns/OGCSvvDLchYR/SMx27783VgoklQUJycX6THYMtdvx1zlHHjeNm84A==
X-Received: by 2002:a05:6e02:221c:b0:3d1:a75e:65f6 with SMTP id
 e9e14a558f8ab-3dc9b751a1fmr101164695ab.18.1748254579230; 
 Mon, 26 May 2025 03:16:19 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 10/25] rockchip: Add a VPL image
Date: Mon, 26 May 2025 04:14:56 -0600
Message-ID: <20250526101541.3254628-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Use FIT_ARCH instead of ARCH
- Use fit_template instead of common_part

Changes in v2:
- Move VPL things into a separate file

 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 91 +++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index 9604972543b..0d767113408 100644
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
+					arch = FIT_ARCH;
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
+				insert-template = <&fit_template>;
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
+				insert-template = <&fit_template>;
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
+				insert-template = <&fit_template>;
+			};
+		};
+# else /* CONFIG_BOOTMETH_VBE_SIMPLE */
+		vbe {
+			type = "fit";
+			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
+			insert-template = <&fit_template>;
+		};
+# endif /* VBE method */
+	};
 };
-- 
2.43.0

