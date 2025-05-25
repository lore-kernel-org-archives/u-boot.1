Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5271DC54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6595282CB6;
	Sun, 25 May 2025 12:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fOpPf5Lm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A5CC8365C; Sun, 25 May 2025 12:48:26 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD2882BF3
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a36efcadb8so1357107f8f.0
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170103; x=1748774903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0YyphaC4Nd096sqmH0bmWkhfnvlbJIqF6V57367Zh2I=;
 b=fOpPf5Lmx0QCfHOdI5Gk7v5Q1Ba905cqhE5epnKoyjB/AV64EsH7YC0KQRx3RaKWP3
 qpAqmoE9BaASSqBwwoLa73ybI6x3F+a92rtpLZw1h0zfMPHWjB64EsPoRGJ8YV265y0R
 kEGzJWvB5K3uFZXmNWpfhg5u1Q9UoG7UH2wfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170103; x=1748774903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0YyphaC4Nd096sqmH0bmWkhfnvlbJIqF6V57367Zh2I=;
 b=hBW/iuUlY3s/Z1oV4dCtW6OlA+M8ix6T5j4G4FhmFPeOSkwTymbGpNnDJFC5GkjbSG
 lBlkAqt6aG3WFnvZGKCJEL2UoOepiaLLjzlLUkFwtP6Wfl1l7Ei5LKHEET53hAuu/GfJ
 WbHiTYKEdq9n7xs8Ea17yc10+I0EIVD6KJ2ps8gig4Uzo349iuu0RrPZpQYTVEErffQn
 haNPOqGYFI3O9k+zR2n7jDjRQB0G7cZSE2Pd0XCRfnbwx4X47dJ40bHAM9xqNdPEuPjp
 mJgPeiqcBU9GiXoupOF++awSY/nNi7U3CLjo9s58ts0IWN8VJHJABOLOf7HkFdo4TIGm
 lizg==
X-Gm-Message-State: AOJu0YwxO6imf9UNzS+qkNCazZWfJGe50hDcsaxYVxjUqI2ROix+4VBZ
 aEZ+Al5Yc4/33Nk2Kz/S/KHL0vjFTi5vFBGEdy1jIyvB+i2dfy/x5kyArlvFw/NQMKu2BDXIo38
 w9qqDqD4o
X-Gm-Gg: ASbGncsTsGGc/y9AuI+wzZlIiWTcGawqPnhV7BfO50Fe5JLmJgC/gyzVLab7Rmmg8ol
 HAxgDa53Xs953Qkt2edliNhVE2AXqLdRmH72xLj99DS9LIjR3mDTE9bFEiR38/uTviPGsnfV3q0
 hrTjrbY7f9Jj9/CUHSz/fo1l49Fac6n/E7Na3MWaWzkM6Yl7xwkMXs+KxwrJzzkhceXSILW+7J9
 u6RsaawoDrZOqqbotnAAZxNM4yMCv6blmH9ePc30dSyLw7/znn9LOotyym6usLktzggH5k53gV7
 mrPGCvkPiiRzbLkM1kcncjkEyDhjMAk89+2yLDIFCOX/Y/V9o4GskuY4m8DnA9Gjo0lgYaM=
X-Google-Smtp-Source: AGHT+IEeYRrBQb2x7KSwB6vThM/wI7fkARxEtAgnvG5ddKPtnVWkTpGjbwssyJF6u6cjzUbErawAEw==
X-Received: by 2002:a05:6000:2403:b0:3a0:7d39:c23f with SMTP id
 ffacd0b85a97d-3a4cb44b674mr4347405f8f.21.1748170103524; 
 Sun, 25 May 2025 03:48:23 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 10/25] rockchip: Add a VPL image
Date: Sun, 25 May 2025 11:47:46 +0100
Message-Id: <20250525104801.1440260-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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
2.34.1

