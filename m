Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F743C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F5EE80B98;
	Sun,  9 Feb 2025 22:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YCLLx5TI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E58A80834; Sun,  9 Feb 2025 22:15:58 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BDA280A0A
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-844ee166150so90190839f.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135754; x=1739740554; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aXoQ+JXfLr+uzrYdj6ynQVc/FDZ5pXk+dhn+ca6FcaQ=;
 b=YCLLx5TI4x+DBlpRmbnuDBPjnzodQ0P2jlrSN2SHpomurcbiZNpyeHrmLLfMx9P/Gj
 eO5rsZU70W1VN60vAfhVjxKhpai4WD//4sKOUDoKDLx6ShwpU5eFJiNCdmASIU6wK+6N
 Uj2JcKH3XxYHO2p65AnXv7nwTCn4bbyJvf1qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135754; x=1739740554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aXoQ+JXfLr+uzrYdj6ynQVc/FDZ5pXk+dhn+ca6FcaQ=;
 b=oy7X+bArBdBqFRgZQfr8FOp8luEiDgPgctQUh0NIxWJEfa6oOTaP3GxMY/tRDSr/Rq
 bHDex3IUX/kmzgWBpzt7njgkiCdMMByhzz6Bw9Tl008mxlnWU/AGB47bBi3aF3fg4CRr
 jWFWlHDHz5JMxgCDYna+PGD8R6VZtI5UGo0AUBaxwb5HRUZRwVBs81EourByrHi371XC
 NnrZ2SGVwHTgR9ebF/72h2lz6htXc2UnxrrSsY88uc0L38NGTHEE0G0kBXr1QzE8mlRd
 RSBaLuSNBOgSb6KbK0M3ja2SqdyidZa2SGfRX4nPBf8V0jRoI724Pk36oicbSO59Wogd
 oH/Q==
X-Gm-Message-State: AOJu0Yw4dFwYZCOV/V8gyxPxT0V4pft4DxdtNC0SDfjeXaunX99TrjNm
 M6wtJwys/DKmj6dDHN4plq+tpSHjQMdiuFdbH//yKc2/xVDUBaBGMXw7dxftsMAq2lHAUtURmtE
 =
X-Gm-Gg: ASbGncuFSfZCjCmf03NqtErIHOcgp7/fhV2eMngh8au4NPB4CXCjEZ0Jd1cjx/KddYm
 ITB1acGi0wPpnmCT6Un8n7YDxHb9jsZnewalF4WSK8FsHfqFxSzEXXY8ff8mpsfcU43mIpTYOIT
 4prWR7jrhPTF6454vEUa6G91O+02+KZ+MAB3RL/pkRhJFYjHUWws9oK4y6Vyh3s27vPWzuMn85E
 kbB933UQI8mhdDfvHAQ3zYX5LG+MsPE/RD+WRnAYcifgcExf7pofzn6thLRig7Qs/TEMbgzVNY+
 MIZocJ2uxIMC0WlGti0+wqRWv5Aex6L6icY3yQS6+bRDPTmrI5e7
X-Google-Smtp-Source: AGHT+IHvBZHXYexp+UPKNvbo1xzmyGEsBGedqgyBPAXnqTp7kmYzREisWMQT5zFZXT5Iex92C7hJUQ==
X-Received: by 2002:a92:ca4d:0:b0:3d0:258e:4841 with SMTP id
 e9e14a558f8ab-3d13df7faa7mr84439645ab.21.1739135754235; 
 Sun, 09 Feb 2025 13:15:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:15:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 13/35] rockchip: dts: Un-indent the FIT template
Date: Sun,  9 Feb 2025 14:14:34 -0700
Message-ID: <20250209211502.2299245-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

(no changes since v1)

 arch/arm/dts/rockchip-u-boot.dtsi | 178 +++++++++++++++---------------
 1 file changed, 89 insertions(+), 89 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index ca666ba0cd4..281119a53d3 100644
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
-					os = "u-boot";
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
+				os = "u-boot";
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

