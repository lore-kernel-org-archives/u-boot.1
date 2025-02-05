Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF515C02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A7D5808E6;
	Wed,  5 Feb 2025 02:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RAUdwT0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1D00806C9; Wed,  5 Feb 2025 02:57:25 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C69807A8
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71e1158fe3eso3429466a34.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720641; x=1739325441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJh2cpc79tQFkIxLPC+Lb+b5C0oE0CTneGPaxly3UYk=;
 b=RAUdwT0o2HoLTU/ymTbo9rtCMGQra8ll6nAX523SZXAcauU2TRCLomTYzUYDZYc00y
 yi99TX66hvcF/5qOc8pW1E1dFmW3BJ2F7V9QHeTOgVQ+BEpFZ7VWtN3Ui4IsQv4vYIs+
 aIC9ESSObaxClX9lyWkui9a7fGoXp2/X9PrJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720641; x=1739325441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJh2cpc79tQFkIxLPC+Lb+b5C0oE0CTneGPaxly3UYk=;
 b=E04p4iz7fa5it/xHf3C3cq8BvBeWvboOF3Z/pPYuB1YW/xUJhQhB8uYPJLCdSbD75g
 ibYBGXTXZYmNRyzS8Zf58UnqcYRBACoiAmbfjjLesFegDUV2jL1Pyc+gNr5btcUBH21m
 LKC4PrbhgKk2uJTOH3BcZlVaxISnEMwUAg6whL3fo3Rg4lMX2K9jOlkPK0VFySmsnnCN
 I9G45gZ4RSdmyuDW0SQhp2u95Yh4wp5TPABy06W2ffHPKBsDFt0pnXeouVuT0bDwJnqa
 9+9sFtVQe2KQbagDayU+M9G8BdNAPvhvHyEkbVQ/raHXUNSOJSj7c/6XeGzgg3oUJoxA
 JNKw==
X-Gm-Message-State: AOJu0YzyM4stt0papG609S2vKJ1XBe+eIguL7e9RhEL8Jg2XhRSYBODw
 6uT1QaG8eQJqqRohDzoBYtBQVQRjPsB14l+Vt6g0ggCPS8GZp1xxBiJzpyyl7OZHoGqrZTEGeQQ
 =
X-Gm-Gg: ASbGncs9imqtAFGWhT2aFxxCvnUBt8rxCEMyzM6bCah+mc7p9q20u2ReEWmejBr1Smh
 E2o3cnnNFtCayAU2tsmxO1K9fXZ2MQTTrO/ce4b3UEMlfhgPHUaur83wysWn5e8PFmCmvNftn1h
 9vVZx+fri4nlxi7cY+TolYc0vvnVv89SfI4HiuLRCxiSjHMV2XK/u0UYOOuH4fYaDGDZFqT+JTV
 /r9zKDqnAfzUOW4sIzHtb4YnM0jlVjWSCDYH5e39weHdQ77HI5VaHKSbcIlsOziVAZDImrPwWku
 UsWqP+SUZ2lrRpzQU+FgMPNzLUy1vKHZjFSGeqXZ9nHAM5f/WWjV
X-Google-Smtp-Source: AGHT+IHvgkzujodI+Q69chD5gSawOKrL5z3TJwKXqcKDgRrEadEGg9e25g89bLqqAoKIiMp8fLrQXA==
X-Received: by 2002:a05:6830:3591:b0:71d:f239:c091 with SMTP id
 46e09a7af769-726a4152701mr799026a34.6.1738720640985; 
 Tue, 04 Feb 2025 17:57:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:57:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 18/29] rockchip: Add a VPL image
Date: Tue,  4 Feb 2025 18:55:08 -0700
Message-ID: <20250205015606.2686149-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

 arch/arm/dts/rockchip-u-boot.dtsi | 94 ++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index c87d17db00e..0611533a310 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -270,6 +270,97 @@
 			};
 		};
 
+#ifdef CONFIG_VPL
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
+			offset = <(0x1000000)>;
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
+#else /* !VPL */
+
 #ifdef HAS_FIT
 		fit {
 			offset = <CONFIG_SPL_PAD_TO>;
@@ -279,7 +370,8 @@
 		u-boot-img {
 			offset = <CONFIG_SPL_PAD_TO>;
 		};
-#endif
+#endif /* HAS_FIT */
+#endif /* VPL */
 		fdtmap {
 		};
 	};
-- 
2.43.0

