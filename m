Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD48C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 920DB87AC2;
	Tue, 31 Oct 2023 06:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="e6cmOsqX";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="g0nnzrbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5715E87AE0; Tue, 31 Oct 2023 06:18:17 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59F7987AD6
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 7E55A3200A55;
 Tue, 31 Oct 2023 01:18:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 31 Oct 2023 01:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1698729493; x=
 1698815893; bh=jBWpfOaonL2oxWwLDELa5WgRCw9F4kU/exj55UWFIZs=; b=e
 6cmOsqXRzHdN9n0+zIdYyJ5DCJ2CosQtFpkcp38HpMqPTF+eGsqfYdTE15vi6Zcg
 K20lOHXVYX0leVG7KI0r3ALDtSTEuPDXU2VcwurkNtPIntRXR11HKvB9Jh8o8VsU
 bTqjTeMlX3SbUjhEHnSfOV4O+kzvVNYA2lMFDyj+5E89I0G5vgxVAtLE6jSayz8r
 kG/ZxrIBBUYoVjEr25tFwpub716Oj2TzG/EqdRsKrtslCxokjnsFZvT2OYxe2dvr
 HR+NuguFQFqb1BWVWXLnaae2JeJNgGjn2Z7jB3QahdV84nOsHF/PZ35eoLPNoJLY
 sWHABxmy+jgFOEUYVdkjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698729493; x=
 1698815893; bh=jBWpfOaonL2oxWwLDELa5WgRCw9F4kU/exj55UWFIZs=; b=g
 0nnzrbu5KXuN7MxtOuXH39hihJEdj6ggAxDdlN+tRxe39bfwikddrrr4tX7WDxdb
 4dYICOMqt+IWw5SNMgLDboxM7/U9Tlh5WXlMQhskBizuGjJWubnosjz3GmBuBCjz
 HrDBrRs0bYm3bHe9mq8kgBRk95sHGyoeNxlCTPCmdf6DHB2v9ddUwOFj/LSlCZES
 +lpWYknoIZjWWC3vtrU+NsS2ySVyA6XZh/ARoZZFxSHEvrUqiirBQedaaKHd1JZe
 WBnBEblrvtmkZl/r5mewHrDIbUTKZkWf5bV6haFc3ARyAL3K8QIsSmmQX1+S1IlZ
 KI6QCTMdDEdXJc3vc63YQ==
X-ME-Sender: <xms:FI5AZbA7NSpIe0jqx6Brpn_8FJTRKPFe170Fx6lBGVuO-U82rQjRkA>
 <xme:FI5AZRimgLqlFgTjge9MxwUPt4SPakPWkMGhLMDJxwyQR5BR5PH2A-eCEnReLea19
 NewFdxLJtAH09MM0g>
X-ME-Received: <xmr:FI5AZWmggOOvfUBmYUUm3AUtLbqx-e5JE6VruxEhE5UgZtL0gTahRnwYaYzq6_OtffDMOvKDLdjJRo0xI0QKqZpo7_Ch-qvCN3MjCe_MsIprdvVX1NRAo26Qiph_yl17Fn_duQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgjeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
 udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:FI5AZdwOkqEbL5KjzdyarYFQeCNxdFdhKIUV0ZUn6nnT1uZv9UrZmQ>
 <xmx:FI5AZQTAnbtK8Po_WT5NQrEgEnQ2fbBQIh91eESMVrmyqKCsdABO9w>
 <xmx:FI5AZQb2RJmdTNurU5yhk1Jwh5bITfAKVxnfAvypRvXKIjgNmeZUGQ>
 <xmx:FY5AZWNz7vS7IE_5qF4X49hidu6bDNFNs12L8_6BVthZLF__sMonuQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 01:18:12 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Icenowy Zheng <icenowy@aosc.io>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 3/4] sunxi: binman: Support FIT generation for 32-bit SoCs
Date: Tue, 31 Oct 2023 00:17:40 -0500
Message-ID: <20231031051805.62430-4-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031051805.62430-1-samuel@sholland.org>
References: <20231031051805.62430-1-samuel@sholland.org>
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

Some 32-bit SoCs can use SCP firmware to implement additional PSCI
functionality, such as system suspend. In order to load this firmware
from SPL, we need to generate and use a FIT instead of a legacy image.

Adjust the binman FIT definition so it does not rely on TF-A BL31, as
this is not used on 32-bit SoCs. Instead, after loading the firmware,
U-Boot proper is executed directly.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v2)

Changes in v2:
 - Rely on binman min-size instead of using explicit offsets
 - Use Kconfig for firmware addresses instead of an #ifdef staircase

 arch/arm/dts/sunxi-u-boot.dtsi | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.dtsi
index 7a8764e463b..ed1cb91eeb5 100644
--- a/arch/arm/dts/sunxi-u-boot.dtsi
+++ b/arch/arm/dts/sunxi-u-boot.dtsi
@@ -1,5 +1,11 @@
 #include <config.h>
 
+#ifdef CONFIG_ARM64
+#define ARCH "arm64"
+#else
+#define ARCH "arm"
+#endif
+
 / {
 	aliases {
 		mmc0 = &mmc0;
@@ -34,30 +40,32 @@
 			filename = "spl/sunxi-spl.bin";
 		};
 
-#ifdef CONFIG_ARM64
+#ifdef CONFIG_SPL_LOAD_FIT
 		fit {
-			description = "Configuration to load ATF before U-Boot";
+			description = "Configuration to load U-Boot and firmware";
 			#address-cells = <1>;
 			fit,fdt-list = "of-list";
 
 			images {
 				uboot {
-					description = "U-Boot (64-bit)";
+					description = "U-Boot";
 					type = "standalone";
 					os = "u-boot";
-					arch = "arm64";
+					arch = ARCH;
 					compression = "none";
 					load = <CONFIG_TEXT_BASE>;
+					entry = <CONFIG_TEXT_BASE>;
 
 					u-boot-nodtb {
 					};
 				};
 
+#if CONFIG_SUNXI_BL31_BASE
 				atf {
 					description = "ARM Trusted Firmware";
 					type = "firmware";
 					os = "arm-trusted-firmware";
-					arch = "arm64";
+					arch = ARCH;
 					compression = "none";
 					load = <CONFIG_SUNXI_BL31_BASE>;
 					entry = <CONFIG_SUNXI_BL31_BASE>;
@@ -67,6 +75,7 @@
 						missing-msg = "atf-bl31-sunxi";
 					};
 				};
+#endif
 
 #if CONFIG_SUNXI_SCP_BASE
 				scp {
@@ -95,7 +104,11 @@
 
 				@config-SEQ {
 					description = "NAME";
+#if CONFIG_SUNXI_BL31_BASE
 					firmware = "atf";
+#else
+					firmware = "uboot";
+#endif
 #if CONFIG_SUNXI_SCP_BASE
 					loadables = "scp", "uboot";
 #else
-- 
2.41.0

