Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5476C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 190D087AC6;
	Tue, 31 Oct 2023 06:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="kkW3KhAf";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="baYkGzQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61CB786FFE; Tue, 31 Oct 2023 06:18:15 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3731C87ABF
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 437213200A58;
 Tue, 31 Oct 2023 01:18:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Tue, 31 Oct 2023 01:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1698729490; x=
 1698815890; bh=MIZlS/GAjkq/kcb0yEs4hZMbT/z+GlqoIRHaYrhJguE=; b=k
 kW3KhAf6DoVvp7gHRkVD6I7oA0FUB2TSkQvfRaFOJVEhWZRGCVq265CvqpnX8G6z
 IMWd64pogVFV4ctK+0iHbjXqzyvaoNqeb8yS1BLTG0RjjiWlJA45UOi5qOZar21m
 x31052Q9THHkVpBlm9Qsi35tWLRJq7+cmxO8oAIXUbgMLE8EyTuQIYTYEiouw5pq
 UTL/vZFuMr7EUuYCsa8ffcoA4xxw50YLapT+iMw8RTH/m+sQp0Vu3o/id+e7DAcZ
 CfXM6rFYENFti6O8d4yGs7PsBQ9QKJ37MBaSsTvUnm/BkSMmkEBT0ybmZcGzjyS9
 e64BLrlfctMZmvMcP1vVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698729490; x=
 1698815890; bh=MIZlS/GAjkq/kcb0yEs4hZMbT/z+GlqoIRHaYrhJguE=; b=b
 aYkGzQ9yrXVIrZ6GC3sOUHTXmZpQFPdJ9jJiAPB7Lye68UWaUoHUjEB4yTQUmQyC
 J2GTQUPrcDh+0apcDsWC83Ya7QLXDLATWMTaJchlFICqZPSz5gzgo7gxm2iesxHa
 fqbmRWXa8RVfzUimpA2M+6hF7oOtSGYoJ3ePSC+0pQTjx6xOjs734q8Gs1yvzvu3
 VTCtJAzoB+DgtDWlA8QIuXehAyH4qxGfvVRRGQZyV1e/R/c7sVJVhqEJ+DrqOWOb
 j2xl1Eg78O4XtbGHnJ7CSrrDM6Jomdw1U2UoyR05yx00CpUVsxKNO73ZTSmT/Z39
 PXpuj8zDby7sdSfrjnqIw==
X-ME-Sender: <xms:Eo5AZXYmt8DSmmFyNBh2x6NLWozhZkhhlPqccTf_BUTvLddf3rrekw>
 <xme:Eo5AZWaAR6vN39CbmFqgCrLN6FAwATYtmrfiMoeEV9NVH6CkW3uPv98a-y3TABCnH
 OAOC1JYRIj-DMkRSg>
X-ME-Received: <xmr:Eo5AZZ-nNfTtLwjtrzg6nQuX2PLfK80ZocCbZYJlZ4kpSlYRHqWdyXmH_XM1xiYjTjp5gZ9myqkCt_DvRQws418vKRtxf9JlUTE3CEWifVZx5c0mgCuQdPDWfPX6SLdb8_BLvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgjeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
 udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Eo5AZdqk6Nw7jQpxrbBEV5v79DYX5ccZ6pYnszi5tqLJ_4dwxO4ioA>
 <xmx:Eo5AZSrRZVRvq1bQbUza1p0S5aml4OQfgGLJksX44b3jXQ8RcGm1xg>
 <xmx:Eo5AZTRn5Ch7vXB6Ey7k6Rd0qpCVMUXEu0gV8NKYN3c9i1vwTmQcSw>
 <xmx:Eo5AZfAewAeE_TAyaQPf0tMaMmgoZckpa2J0i_9HUQaLVY806Egj4A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 01:18:10 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Icenowy Zheng <icenowy@aosc.io>,
 Jesse Taube <Mr.Bossman075@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 2/4] sunxi: binman: Move BL31 and SCP firmware addresses to
 Kconfig
Date: Tue, 31 Oct 2023 00:17:39 -0500
Message-ID: <20231031051805.62430-3-samuel@sholland.org>
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

This is easier to read than the #ifdef staircase, provides better
visibility into the memory map (alongside the other Kconfig
definitions), and allows these addresses to be reused from code.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v2)

Changes in v2:
 - New patch for v2, split from the .dtsi changes

 arch/arm/dts/sunxi-u-boot.dtsi | 24 +++++++-----------------
 arch/arm/mach-sunxi/Kconfig    | 17 +++++++++++++++++
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.dtsi
index a0c8abb7033..7a8764e463b 100644
--- a/arch/arm/dts/sunxi-u-boot.dtsi
+++ b/arch/arm/dts/sunxi-u-boot.dtsi
@@ -1,15 +1,5 @@
 #include <config.h>
 
-#ifdef CONFIG_MACH_SUN50I_H6
-#define BL31_ADDR 0x104000
-#define  SCP_ADDR 0x114000
-#elif defined(CONFIG_MACH_SUN50I_H616)
-#define BL31_ADDR 0x40000000
-#else
-#define BL31_ADDR  0x44000
-#define  SCP_ADDR  0x50000
-#endif
-
 / {
 	aliases {
 		mmc0 = &mmc0;
@@ -69,8 +59,8 @@
 					os = "arm-trusted-firmware";
 					arch = "arm64";
 					compression = "none";
-					load = <BL31_ADDR>;
-					entry = <BL31_ADDR>;
+					load = <CONFIG_SUNXI_BL31_BASE>;
+					entry = <CONFIG_SUNXI_BL31_BASE>;
 
 					atf-bl31 {
 						filename = "bl31.bin";
@@ -78,13 +68,13 @@
 					};
 				};
 
-#ifdef SCP_ADDR
+#if CONFIG_SUNXI_SCP_BASE
 				scp {
 					description = "SCP firmware";
 					type = "firmware";
 					arch = "or1k";
 					compression = "none";
-					load = <SCP_ADDR>;
+					load = <CONFIG_SUNXI_SCP_BASE>;
 
 					scp {
 						filename = "scp.bin";
@@ -106,10 +96,10 @@
 				@config-SEQ {
 					description = "NAME";
 					firmware = "atf";
-#ifndef SCP_ADDR
-					loadables = "uboot";
-#else
+#if CONFIG_SUNXI_SCP_BASE
 					loadables = "scp", "uboot";
+#else
+					loadables = "uboot";
 #endif
 					fdt = "fdt-SEQ";
 				};
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index a10e4c06b6a..b0fbda0aa09 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -155,6 +155,23 @@ config SUNXI_RVBAR_ALTERNATIVE
 	for all other SoCs, so the content of the SRAM_VER_REG becomes
 	irrelevant there, and we can use the same code.
 
+config SUNXI_BL31_BASE
+	hex
+	default 0x00044000 if MACH_SUN50I || MACH_SUN50I_H5
+	default 0x00104000 if MACH_SUN50I_H6
+	default 0x40000000 if MACH_SUN50I_H616
+	default 0x0
+	help
+	  Address where BL31 (TF-A) is loaded, or zero if BL31 is not used.
+
+config SUNXI_SCP_BASE
+	hex
+	default 0x00050000 if MACH_SUN50I || MACH_SUN50I_H5
+	default 0x00114000 if MACH_SUN50I_H6
+	default 0x0
+	help
+	  Address where SCP firmware is loaded, or zero if it is not used.
+
 config SUNXI_A64_TIMER_ERRATUM
 	bool
 
-- 
2.41.0

