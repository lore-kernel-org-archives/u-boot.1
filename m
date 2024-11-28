Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F27D6D255
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 03:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF03D89833;
	Thu, 28 Nov 2024 04:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732764403;
	bh=Eow8VBCeZIgIHI2PvgMgm59OvuCCxBpUqmcXuNSM/c0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vNASCnyqDwB3o+2DOGw3++zLObKZqg1PYtqG0nmD5y9TEKaU62NR6TAgouGN48GrF
	 35HNWdXnhQPbKqDLuSSZCOF1GjA33k/KpFIKqZsvg75V292B7ITfWe2deCU/qaSWf2
	 AAWE8Lsttu/H+tRHuSa/rGB701u+VF9ZNJbmcFbCJHNNUM28r0Lirg/ffbJDme+11Z
	 bD8q3/IzdkAU5Y5y+3JuSNMWXi9o2v6g/PxCNLvOSBEnaHsIIqFaXfyS8l6p6ca49L
	 CK4PG/c/l2uD/Zwp/FB2e6z85Y53EqQPgoh4PHJQtvQOep3WGHuHNSoV5PLFSY/nEv
	 Z+NMYcRI8U+4A==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 553B988E4B;
 Thu, 28 Nov 2024 04:26:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732764401;
 bh=Eow8VBCeZIgIHI2PvgMgm59OvuCCxBpUqmcXuNSM/c0=;
 h=From:To:Cc:Subject:Date:From;
 b=OtXRP+Qienk71yn+CU9V+Yne9NwS1UTYSLyo/7kjorkZWAO9AwE/rAcreiewYDsrq
 gFTxVXVezaFKrirJu/GvYOHSCGk++fx2krYWWe5by34GXyKaahE+5MQD6I+2mG6boT
 qeDNHpg9/WeMUH8dCvm2s7nzmi+Z2LFQDvWfK9p9MgYtTL4uHVIxzy36Ai31SKcc1S
 48h1rNzZ5T1PL1l1uvXXOFMsnU226RvHyp3H7nxUD7UXc4rJ1lgwQ6p1yB+SLBGchI
 Bro3ZYlsO81afjd0EwppDQmUaNVBFavo7u6x6QmjcfhwtxxAJMgiNTgbeBJd04O5HO
 C0UMYqs0xUayA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] ARM: dts: imx: Make DRAM coding GPIOs available in all
 phases on Data Modul i.MX8M Mini/Plus eDM SBC
Date: Thu, 28 Nov 2024 04:25:23 +0100
Message-ID: <20241128032623.269459-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

The DRAM configuration GPIO straps must be accessible in all boot phases
because the GPIOs are sampled both in U-Boot SPL as well as early on in
U-Boot proper. The already present bootph-pre-ram DT property made the
GPIO controllers available in SPL, but not early on in U-Boot proper,
which made gpio_request_list_by_name_nodev() in board dmo_get_memcfg()
fail. Add missing bootph-all DT property to all GPIO controllers which
are referenced in dmo,ram-coding-gpios DT property to make those GPIO
controllers available early in U-Boot proper as well.

Fixes: 8c103c33fb14 ("dm: dts: Convert driver model tags to use new schema")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
NOTE: For v2025.01
---
 arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi | 1 +
 arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi b/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
index a235e088fa4..babe51ebdc1 100644
--- a/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
@@ -77,6 +77,7 @@
 
 &gpio2 {
 	bootph-pre-ram;
+	bootph-all;
 
 	dsi-reset-hog {
 		bootph-pre-ram;
diff --git a/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi b/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
index 805b5f57955..f2779ff14a0 100644
--- a/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
@@ -64,6 +64,7 @@
 
 &gpio3 {
 	bootph-pre-ram;
+	bootph-all;
 
 	bl-enable-hog {
 		bootph-pre-ram;
@@ -92,6 +93,7 @@
 
 &gpio4 {
 	bootph-pre-ram;
+	bootph-all;
 
 	dsi-reset-hog {
 		bootph-pre-ram;
-- 
2.45.2

