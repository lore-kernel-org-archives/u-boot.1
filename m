Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3A9C36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 15:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61ED981E60;
	Sat, 29 Mar 2025 16:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="NGlmrCQB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D8A805C8; Sat, 29 Mar 2025 16:06:57 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94C1981E47
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 16:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1dca=WR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743260811; bh=QV6WTZwY2kpr6Qfn/vhDkAx09DyKL8rS31dPzrMQu68=;
 b=NGlmrCQB4WdYpXpexOBOoH/mLzMvFYMku9Dk6ROHJLV1p4G83TdYbG0w1Mi3/USjVaTWVXpKG
 tIC+HofMXV4gA27BhC0COHR1WriprxUUeTiVVam5vFbXMTNEt//LQhOuAHm1FKaRY3HPmNPAvjt
 Y0YE731irt4/gPx5jagotVq7JHBd5cH5rZNim6KIevv2aHfk2re0lXuagwmqV1HWKknIaYWMjHZ
 eo62UDEjMEEQX5K9KpQrFMyMDNaqQH6kAOGWSyVRAWTJ9K9++Z0dIgFqnd87Wenwu/h8BIe8B3i
 cwkj18gHtyNHTurVbjQQgt0BB4sGDj0g99ZrdqLIAP9w==
X-Forward-Email-ID: 67e80c8921787eb134711f57
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 05/10] rockchip: binman: Un-indent the FIT template
Date: Sat, 29 Mar 2025 15:06:08 +0000
Message-ID: <20250329150626.2879942-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250329150626.2879942-1-jonas@kwiboo.se>
References: <20250329150626.2879942-1-jonas@kwiboo.se>
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
---
Changes in v4:
- Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
---
 arch/arm/dts/rockchip-u-boot.dtsi | 176 +++++++++++++++---------------
 1 file changed, 88 insertions(+), 88 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 9ef1ca6cd13a..f860bfc1ba72 100644
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
-					arch = ARCH;
-					compression = COMP;
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
2.49.0

