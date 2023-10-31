Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B88C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 325E187AE0;
	Tue, 31 Oct 2023 06:18:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="Rm3m7q/q";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="BzpIoqVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70D3986FFE; Tue, 31 Oct 2023 06:18:19 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF8387AE4
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 91EDC3200A58;
 Tue, 31 Oct 2023 01:18:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 31 Oct 2023 01:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1698729495; x=
 1698815895; bh=JJvm4TSuEb/1tTG5oIzrcgyUnxbcAZqndwTPl/Fq1Fg=; b=R
 m3m7q/qdIToCYrjOXisPjr6ZEvY5dS4U913B4FHWqbLqVmAvO4wdzyvch1PAd9B1
 gEB3uxCXAoHTLTpGd0OlpyHh6LdypBfm2S0xXIaPKIrpNn2B5rN4IUO4iAIMee1l
 1fXp1QMPdm8/b6KLGb27+qirFxov1+2pvfQ9ZK0cPe6SK4GPQsuZWs8KwrQQo92p
 7ffqTlds4eEPxdPSQNRN0Psr5hXRiRdnNoKgcNKs8UmpUL8riGenoe5tNEbkhag/
 1Rf4D8EbcNLTJLpv4ReDvXnUfoLbkczFvdSdq4H2bvG3hrSZxGMEplWAv0ig3yo+
 l5lODlWLN7MAza+lby01Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698729495; x=
 1698815895; bh=JJvm4TSuEb/1tTG5oIzrcgyUnxbcAZqndwTPl/Fq1Fg=; b=B
 zpIoqVeszsdooI611eVf8yXRwOmJzy9638yxQOAYfIUecuIN89VdpibgVgZaUf9F
 DZ4WO4dOSpuV8rnyDBE2RfCm2VT8g3xfVBR0UcS35CWQjTd0FmHbhs54TNv6zrzH
 lCuqdx0RPNKqDGQtHV7zNytvbG6mhZ1dKIdMgJwL6imOXBJxr1OT/Qx8l+XjKJRg
 NQAG7GIKK8tus9/VmYXYzbcAncvScIoKj6BaDBDu4AikagTHQXxbt7ElT3gHKWBO
 dXlUeB+RKMc+hDMUNWvWnSriVCLfGY2qppGAbhpuxcVjHImJ6/Itzn5vH//07QyL
 Ims5Cdxt6Wx8e0RVW0uNQ==
X-ME-Sender: <xms:F45AZTyMT4LX7exeDy4rriOLJjNxqfZx7s-SNJsNjEfSIceW1f5xyA>
 <xme:F45AZbS5Ioug3mBct0HfjQxMhR3rt2JCyJ8itXz_O3My5Y-AAXBVnrDuMtCje_u9-
 W55c8jp2M6Y4fmcxw>
X-ME-Received: <xmr:F45AZdUh8bGDGJLETu9BliYex-FaDPV_gxVrqbJ7PlXv9giH3F-CyiLmKZ30d633svWMOCNzFrmq_JcPEmHgI75LKPlZthPlJT833p-pUGuGXWvrTo9SenVsuEi3IlAMOFjGbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgjeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
 udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:F45AZdgxUJNmhG5slChHTqq1TgHzkdheDI8jAscV0HKeUGXVxZjvdA>
 <xmx:F45AZVANUUXxM8HTVBYJh9HeL2nYEXKyUh-RnsMAGi8y4RcYD2LDlA>
 <xmx:F45AZWInH3wiktI7ilJsygiJp2Ix0KRL6UbX3S5mMAEPf-NM1yerig>
 <xmx:F45AZQ_5PtEUY6VkyyfBkQUZwx0fh4RdELoUYW8Hw9SfIRmBQa1UaA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 01:18:14 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Icenowy Zheng <icenowy@aosc.io>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 4/4] sunxi: Enable SPL FIT loading for 32-bit SoCs
Date: Tue, 31 Oct 2023 00:17:41 -0500
Message-ID: <20231031051805.62430-5-samuel@sholland.org>
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

Now that 32-bit SoCs can load U-Boot proper (and possibly other
firmware) from a FIT, use this method by default. SPL_FIT_IMAGE_TINY is
required to stay within the 24 or 32 KiB SPL size limit on early SoCs;
for consistency, enable it everywhere.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v2)

Changes in v2:
 - New patch for v2, split from the .dtsi changes

 arch/arm/Kconfig   | 1 +
 common/spl/Kconfig | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d812685c984..42781d02f0f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1167,6 +1167,7 @@ config ARCH_SUNXI
 	imply SPL_GPIO
 	imply SPL_LIBCOMMON_SUPPORT
 	imply SPL_LIBGENERIC_SUPPORT
+	imply SPL_LOAD_FIT
 	imply SPL_MMC if MMC
 	imply SPL_POWER
 	imply SPL_SERIAL
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index a0968ff1065..aebbfbf99d2 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -567,8 +567,7 @@ config SYS_MMCSD_RAW_MODE_EMMC_BOOT_PARTITION
 config SPL_FIT_IMAGE_TINY
 	bool "Remove functionality from SPL FIT loading to reduce size"
 	depends on SPL_FIT
-	default y if MACH_SUN50I || MACH_SUN50I_H5 || SUN50I_GEN_H6
-	default y if ARCH_IMX8M || ARCH_IMX9
+	default y if ARCH_IMX8M || ARCH_IMX9 || ARCH_SUNXI
 	help
 	  Enable this to reduce the size of the FIT image loading code
 	  in SPL, if space for the SPL binary is very tight.
-- 
2.41.0

