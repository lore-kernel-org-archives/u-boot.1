Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE51C02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52262807D7;
	Wed,  5 Feb 2025 02:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZnFdNO4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98BF4805A1; Wed,  5 Feb 2025 02:56:56 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7CE4801F5
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5fc0c06e1deso3062744eaf.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720610; x=1739325410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCsGfH37slEP6U+eafFFvc1hUNFOj7LRaLKHmZexSpY=;
 b=ZnFdNO4cMBukeX++emjkrHkMFjME26nSA/fUATVMFF9HGd98ysZpg1EODOsxf/MRFJ
 cxS93nCdMvc39n8GZgecUJU88E/DJW1dSup3QvgIFEAgjQuKJYz++zVZh04AC+4knJFn
 kUx+OWdBVM3VN1qig1wfTTZp4heRAAoC0H3Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720610; x=1739325410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCsGfH37slEP6U+eafFFvc1hUNFOj7LRaLKHmZexSpY=;
 b=bVzuXrCVC7WKD0iyUQ1GpiCdIfdQoChpqRGJVEz2yrk0SCyLqZVwVdilYIeCWC/my3
 TNs+9OoxL9HU67ZY9mWzU1XevvZ6O/xuSMMEez9TEXwVU8yyjBzoWSkUmXpJ2syc+C8/
 VwLGgg788bgz2TQpoViFkbbm8q54gcU1jFpUbUb7LGEwcHNkbuiWQMwaLeffRq85D0nT
 t86aKovvQskUe8TdhfzUjAb3k/Zy3KaulmsmM48sSvrR1GNVdFqLbONCHp295DToPI5G
 tHmn5uL4pLsCOX2gqXWHlhkEyelSp6FbctvD5llhiy1mAs9wZXEDDBLzstHMr7vAkCVp
 99QQ==
X-Gm-Message-State: AOJu0YzA366KCTUJI9Ljq1kP0cMpeX2NTgD/5YJvWESLha8yybXTW7Tq
 2ijIrehKagZGmMJM3aiLIJ0PZf/cEh0sF7oDmAFRntgnF9/4Mwc3n+JRhlV5duyLE2KJuhlEv3k
 =
X-Gm-Gg: ASbGncvGzWwMJBAogY1kFC81Z/f1n7hw3SATfU+/9Fo53CFagXQPlGCAeveTp3oQcjd
 H7NbXq3bkMmaokLhIpraZ83ClwCp6PFMWym1j5QjSTTaQPg8vJBNtj3MbvvfwjV7XpfvlRw5tot
 rtib7xlGAD39f5NP7rQCAqjveh4lOJxI42L/YsuVQk/gGZOsLAr7yo7LL5+KS3F15uhti5vf3Xg
 bepgajl6AHz59Q1kq1CWy24f5wNtKiDxw1Uy0g5CepwRQm5K4fjKbvcyjJzcUzvTGn3rZcr03d8
 jXQR1J/MD61ljDXI3qON98JaTQc30QeHGa8uTxWYTZmC2JW/VImd
X-Google-Smtp-Source: AGHT+IHkuFWoliYZt8dK8hmrtRethQSCAyhwu5+DQodCu2GTRyIg68NHh9zyIv3yboTVQJJ7jpylFg==
X-Received: by 2002:a05:6820:1809:b0:5f8:a3df:aa9 with SMTP id
 006d021491bc7-5fc479e15d9mr906938eaf.7.1738720610257; 
 Tue, 04 Feb 2025 17:56:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:56:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 10/29] rockchip: dts: Un-indent the FIT template
Date: Tue,  4 Feb 2025 18:55:00 -0700
Message-ID: <20250205015606.2686149-11-sjg@chromium.org>
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

Fix the indentation on the template. This is done in a separate patch
so that it is easier to review.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/rockchip-u-boot.dtsi | 178 +++++++++++++++---------------
 1 file changed, 89 insertions(+), 89 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 8418635ed84..4cf7c49a74c 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -33,121 +33,121 @@
 &binman {
 #ifdef HAS_FIT
 	common_part: template-1 {
-			type = "fit";
+		type = "fit";
 #ifdef CONFIG_ARM64
-			description = "FIT image for U-Boot with bl31 (TF-A)";
+		description = "FIT image for U-Boot with bl31 (TF-A)";
 #else
-			description = "FIT image with OP-TEE";
+		description = "FIT image with OP-TEE";
 #endif
-			#address-cells = <1>;
-			fit,fdt-list = "of-list";
-			filename = "u-boot.itb";
-			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
-			fit,align = <512>;
-			images {
-				u-boot {
-					description = "U-Boot";
-					type = "standalone";
-					os = "U-Boot";
-					arch = ARCH;
-					compression = COMP;
-					load = <CONFIG_TEXT_BASE>;
-					entry = <CONFIG_TEXT_BASE>;
-					u-boot-nodtb {
+		#address-cells = <1>;
+		fit,fdt-list = "of-list";
+		filename = "u-boot.itb";
+		fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
+		fit,align = <512>;
+		images {
+			u-boot {
+				description = "U-Boot";
+				type = "standalone";
+				os = "U-Boot";
+				arch = ARCH;
+				compression = COMP;
+				load = <CONFIG_TEXT_BASE>;
+				entry = <CONFIG_TEXT_BASE>;
+				u-boot-nodtb {
 					compress = COMP;
-					};
+				};
 #ifdef CONFIG_SPL_FIT_SIGNATURE
-					hash {
-						algo = "sha256";
-					};
-#endif
+				hash {
+					algo = "sha256";
 				};
+#endif
+			};
 
 #ifdef CONFIG_ARM64
-				@atf-SEQ {
-					fit,operation = "split-elf";
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = ARCH;
-					os = "arm-trusted-firmware";
-					compression = "none";
-					fit,load;
-					fit,entry;
-					fit,data;
-
-					atf-bl31 {
-					};
+			@atf-SEQ {
+				fit,operation = "split-elf";
+				description = "ARM Trusted Firmware";
+				type = "firmware";
+				arch = ARCH;
+				os = "arm-trusted-firmware";
+				compression = "none";
+				fit,load;
+				fit,entry;
+				fit,data;
+
+				atf-bl31 {
+				};
 #ifdef CONFIG_SPL_FIT_SIGNATURE
-					hash {
-						algo = "sha256";
-					};
+				hash {
+					algo = "sha256";
+				};
 #endif
+			};
+			@tee-SEQ {
+				fit,operation = "split-elf";
+				description = "TEE";
+				type = "tee";
+				arch = ARCH;
+				os = "tee";
+				compression = "none";
+				fit,load;
+				fit,entry;
+				fit,data;
+
+				tee-os {
+					optional;
 				};
-				@tee-SEQ {
-					fit,operation = "split-elf";
-					description = "TEE";
-					type = "tee";
-					arch = ARCH;
-					os = "tee";
-					compression = "none";
-					fit,load;
-					fit,entry;
-					fit,data;
-
-					tee-os {
-						optional;
-					};
 #ifdef CONFIG_SPL_FIT_SIGNATURE
-					hash {
-						algo = "sha256";
-					};
-#endif
+				hash {
+					algo = "sha256";
 				};
+#endif
+			};
 #else /* !CONFIG_ARM64 */
-				op-tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = ARCH;
-					os = "tee";
-					compression = "none";
-					load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
-					entry = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
-
-					tee-os {
-					};
+			op-tee {
+				description = "OP-TEE";
+				type = "tee";
+				arch = ARCH;
+				os = "tee";
+				compression = "none";
+				load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
+				entry = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
+
+				tee-os {
+				};
 #ifdef CONFIG_SPL_FIT_SIGNATURE
-					hash {
-						algo = "sha256";
-					};
-#endif
+				hash {
+					algo = "sha256";
 				};
+#endif
+			};
 #endif /* CONFIG_ARM64 */
 
-				@fdt-SEQ {
-					description = "fdt-NAME";
-					compression = "none";
-					type = "flat_dt";
+			@fdt-SEQ {
+				description = "fdt-NAME";
+				compression = "none";
+				type = "flat_dt";
 #ifdef CONFIG_SPL_FIT_SIGNATURE
-					hash {
-						algo = "sha256";
-					};
-#endif
+				hash {
+					algo = "sha256";
 				};
+#endif
 			};
+		};
 
-			configurations {
-				default = "@config-DEFAULT-SEQ";
-				@config-SEQ {
-					description = "NAME.dtb";
-					fdt = "fdt-SEQ";
+		configurations {
+			default = "@config-DEFAULT-SEQ";
+			@config-SEQ {
+				description = "NAME.dtb";
+				fdt = "fdt-SEQ";
 #ifdef CONFIG_ARM64
-					fit,firmware = "atf-1", "u-boot";
+				fit,firmware = "atf-1", "u-boot";
 #else
-					fit,firmware = "op-tee", "u-boot";
+				fit,firmware = "op-tee", "u-boot";
 #endif
-					fit,loadables;
-				};
+				fit,loadables;
 			};
+		};
 	};
 #endif /* HAS_FIT */
 
-- 
2.43.0

