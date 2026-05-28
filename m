Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03C4CD6E45
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BC20846A5;
	Thu, 28 May 2026 19:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V+xrXH7e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E468486D; Thu, 28 May 2026 19:11:18 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A04FB84857
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e685ddb3b0so632741a34.1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988275; x=1780593075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0MI/fz0KFDpLxoxm1fSOyvbwQUBPs1o7oED+Zh3KPU=;
 b=V+xrXH7enF42pVmmjDsPyE97M24WqjQdFKqxrVyiELAGP8F/wuoV+06cPGIMnqz+Nm
 I2g5CJYw9wt7EBnqeh4em3SL7s17FzZdKGziyyO4xQ2+oF6XiTuBLinhiMTeoT3/X79H
 2c6PWjQcIOotv9EUWbedY+VHgnZ62EurDXmTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988275; x=1780593075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V0MI/fz0KFDpLxoxm1fSOyvbwQUBPs1o7oED+Zh3KPU=;
 b=VLUUZSd4eEz7gnHl1vpzQCzb9v0fZubRfLqQeqi1vdGxASCPhUZ8NkVrrbwUDzcI5y
 5XiVgZ9RxMsHTLd3WTR+ePsZEpgpHkJEVneWj+yXUY7DNIkCjqIpEwabbRzUE6s/Kado
 JYyFIQUExQtoFvKzDzvUbJljbOBB+rd/Y7fe2ptgHIiyee/Kv6CwDRdGNmRCsKjq6aUv
 Yl+npe4cBSkINZfSQq6Lp4rAIm90dhxhC0a0+FjJAFF9TI+RY/j9oOPw8E2cjZgs8tas
 LKjLMKr+lH9302vrlfA9DX+YM791VTXJnVnnRILdQo+q3eMk5LZob0V5wqBctu4cDQA0
 eFKQ==
X-Gm-Message-State: AOJu0YxLw4L6gxNv8R3ySCUv6nZmZkCYPfnNEiQwkIIIWutD8grP4imJ
 ijhKa8d9v5mD7CO4pgK0v2ksi/Sl6zQeolr/M51uRHoqPx+Dt2vqQfGSwDdj3mH1T5cS4ErqFU3
 NMGoJgpSChRM=
X-Gm-Gg: Acq92OHGnnYh913dJ+8mexI4HiHR2mbZ/UFzKfKmqLInz3Jue4lVjiCwgug1oRAYrKN
 RM7QwfehG46I/haHxSQQBTct+DA6IJNdmFbBm/hUZ6s1qkrhrJfO9a6+wntvoOObUF4ON/dTnMX
 1uxVjFG0eaXsUdlAOTHRJwTlUCfYeAA/5+xcX143UzJ9Ks2EgcNhIZwGuzhCy7eomgsKzNg4ziD
 dziaI0t74hOp224WQJlUVIG/ONNojhn3+xzWiQYBXlUPTcK2trngEes7c3IpfpywiB3nEhiZwvH
 TTxWepSfXJ0rHKFvZNgvCwauvZ4H0GmWtic9ksKq8bB3llrmJo7e1OBdeyrmGNQex7q4m3+6wi5
 WucYOXOeCrQ+M2OxQ/lleaeGPvnNqPXMXr4pexKN43E0He2gHY/CxC745tIvUbUmo5JuCnqg3vg
 LxpqG1CjTctSNbbR9WToTQvtJcVQ+Vo8QDTuV68Co=
X-Received: by 2002:a05:6830:d09:b0:7d7:e142:2ead with SMTP id
 46e09a7af769-7e5fef2fed1mr16427124a34.20.1779988275313; 
 Thu, 28 May 2026 10:11:15 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 10/22] rockchip: Add a VPL image
Date: Thu, 28 May 2026 11:10:17 -0600
Message-ID: <20260528171043.910264-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

