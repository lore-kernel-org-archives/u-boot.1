Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD744C369AE
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 20:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7731E82AE1;
	Sun, 13 Apr 2025 22:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wSdUmvDA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAAA3828D0; Sun, 13 Apr 2025 22:00:16 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 207638215F
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 22:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b5c5=XA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744574412; bh=NXofVZcFtgXfbBhM6h47q4EqUQQJz7XAAocUF8X2tMw=;
 b=wSdUmvDAE1SsQK25FGOuhjhNcGE30TR4YkPdOPEa89bYcixMNBwYodvL2PzgAZ5TsMcVc8+pI
 FudugTF75x0DLEn7DhbaF+J3JUZH5AYKLUhU92uYP5iZD2CyTk+9LaN8TXeDMHwTOvbvUFvrQor
 suFF1EcDpEmnOuf+W4CnbqoWs7X/ea/3T4cncTa7NMTi2BkbzgMDre8OKn62Z8ICiTddVBxRhiw
 2Ffqm+sF2tqeqQIxdsztFPZdATXa7+XdfpQs222m8lynGZgfToTIanev6txYXQPJC9C/SCXLdBq
 /eV0ghroggb/phQfxu6rR7H5oZwBA/Z6hPOGbNZ0bRIA==
X-Forward-Email-ID: 67fc17c86900761fb15162da
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v6 4/7] rockchip: binman: Un-indent the FIT template
Date: Sun, 13 Apr 2025 19:59:36 +0000
Message-ID: <20250413195949.432730-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413195949.432730-1-jonas@kwiboo.se>
References: <20250413195949.432730-1-jonas@kwiboo.se>
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

From: Simon Glass <sjg@chromium.org>

Fix the indentation on the template. This is done in a separate patch
so that it is easier to review.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v6:
- No change

Changes in v5:
- Collect r-b tags

Changes in v4:
- Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
---
 arch/arm/dts/rockchip-u-boot.dtsi | 176 +++++++++++++++---------------
 1 file changed, 88 insertions(+), 88 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 0c074c0ec6b9..e97e9d23834c 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -33,120 +33,120 @@
 &binman {
 #ifdef HAS_FIT
 	fit_template: template-1 {
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
-			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
-			fit,align = <512>;
-			images {
-				u-boot {
-					description = "U-Boot";
-					type = "standalone";
-					os = "u-boot";
-					arch = FIT_ARCH;
-					compression = FIT_UBOOT_COMP;
-					load = <CONFIG_TEXT_BASE>;
-					entry = <CONFIG_TEXT_BASE>;
-					u-boot-nodtb {
+		#address-cells = <1>;
+		fit,fdt-list = "of-list";
+		fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
+		fit,align = <512>;
+		images {
+			u-boot {
+				description = "U-Boot";
+				type = "standalone";
+				os = "u-boot";
+				arch = FIT_ARCH;
+				compression = FIT_UBOOT_COMP;
+				load = <CONFIG_TEXT_BASE>;
+				entry = <CONFIG_TEXT_BASE>;
+				u-boot-nodtb {
 					compress = FIT_UBOOT_COMP;
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
-					arch = FIT_ARCH;
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
+				arch = FIT_ARCH;
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
+				arch = FIT_ARCH;
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
-					arch = FIT_ARCH;
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
-					arch = FIT_ARCH;
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
+				arch = FIT_ARCH;
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
2.49.0

