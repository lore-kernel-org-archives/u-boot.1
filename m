Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DB4C55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 22:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7224C40741;
	Tue,  4 Aug 2026 22:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vsK_BqHmpAU7; Tue,  4 Aug 2026 22:33:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9B4C40781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785882792;
	bh=KDcNIv/bG15DtZDeFrNfXPLSKnLoLnPX6ck+YT13aVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g7iPCPTWbb9k65NSsgF+dUK1I+VocOYwOsPsSGXz4bXgUNAhLPSNlFIzb0Dg3WDuR
	 8TU0kvP9RQrjBw9GXH8exH+VpWIG4Px8efzGoEELZ1g/uNyRHiv1vf12JaFDVOg0ss
	 /OHm8RPRF8FnMMz3eMeRKZkhZEygGA03+/DpGSecTqw45BQeBSTsGSclTQaLpFqddZ
	 36GqJ2WQ1JowDP6ivPTT9sCcyfJMdQYuxIjzkfT2ObZmn/Cl48TZ5B6nm0fOwzQHBj
	 Y+u6s0pExwYQMPlJ3G8FbbN784YpKdPuKQm+kHJwjcIVB8CPXffeMyeiwTUz6Uc1U/
	 ISMWE0u26ozHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9B4C40781;
	Tue,  4 Aug 2026 22:33:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D2C7F2B6
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA6EE4076D
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3rOR81HfP3Ya for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 22:33:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 52A6B4074E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52A6B4074E
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52A6B4074E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:07 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6aae90e595fso212862eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 15:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785882786; x=1786487586;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KDcNIv/bG15DtZDeFrNfXPLSKnLoLnPX6ck+YT13aVk=;
 b=okts9Bj6KtfuwYX/KJ4D/my2Uq9qqWnQeppI2vE2cjYCifgUFlg3zoBNqdzp+41DJ7
 Mm6f8e348F+nTbEWmOmoteGX26aTjiQvJGsPBXqZMNiGlnb2ScvF8BL8h/Umje7Ebb+n
 d/tMTE4qaP8FtFP+WjqZXvwytlK7rygG5uJfz5ojnehd4eYHyO0y5LzJQB1OrfIXs1Je
 PvfiwqUoVkr5qsb5jviaD7yLEMKDDXUl8lXo2Jzd5gfqamNOltIRH8ivn25Qk1ZxxnGz
 oujBqvwceJdE+tJeqs9CCCPSLkAsimvIdmWg4J1iK4YdhYqqoPUJ2WLjnZmXh5uhBIZ2
 pqUw==
X-Gm-Message-State: AOJu0YzlKqWo18Z16SiNfcLNSffrzsyoLf91TQQddDINhSQbNq2ekcQJ
 Gs1CzmIuUF1+SA9pT2MspTwSgVdIvDbvDAj2DccVdm69yCdsakf39zgV5Q0usecAS2g=
X-Gm-Gg: AR+sD10nZmv2U284Yvo6cue5xnbCmbEBm5/MdSwAdrygzG0lPsmkc/EYuOMp26YTO/Q
 G3CT/BYNX+8J8Ae7J10TcHqI0Qb7XcOqElRdg3raXdoGRq6nOSu6+5LW+eXJ3ixlwhsrhmOsoPz
 vh9A7kbwGgEqDBiNJyBJIYH5IXcT4YLtxz0mq9d84GTZFv4ub9AhqFvTy/bFnZdOC+qEEEluoor
 MveZG5EOPBgah+GBKCXIu/vk8dFVa7f1PNLhSSiubKVru+YqjUslCkvz9+5kR3Gt6o1NxE9KYNL
 12mo6lRGNJpd9AVl0V52E8gRwBINhJKO0x0GR4FpqOH0LUKZK0Xx0MNUWElwpWrwZwD+t6oqVig
 qF0Hfqq8EdyMJkrQ2TmTCTvjIrIkkAzv6zy3cyUHWVDQctDEdDfVyE60eYw9Z/I1nl18KA+vc6v
 fLIUx7i8EKquFWge/KvFuo7nzFDm8nxAUgJOdtZTe9nEFM3/TLtMU0T2Rq6jPluSK9Cw==
X-Received: by 2002:a05:6820:1792:b0:6ac:a994:8a02 with SMTP id
 006d021491bc7-6ae96c8ee40mr1388474eaf.12.1785882786018; 
 Tue, 04 Aug 2026 15:33:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a444:841f:6b21:eaf5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ae93d524d3sm1016111eaf.6.2026.08.04.15.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 15:33:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 04 Aug 2026 17:32:05 -0500
Subject: [PATCH 5/7] arm: dts: add mt6366 PMIC include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-mtk-pmic-mt6366-v1-5-f3b36b8a1a47@baylibre.com>
References: <20260804-mtk-pmic-mt6366-v1-0-f3b36b8a1a47@baylibre.com>
In-Reply-To: <20260804-mtk-pmic-mt6366-v1-0-f3b36b8a1a47@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8414; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=S3UMcfx0CBjYhfwMGXDoaB2+3yLldjH33OzlEjuqGaA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcmiFskyhGn4rysbQMcNFUrFa4i5yolSUT/bY2
 6gaNSjzKR6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanJohRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ALSsH/1EXZ0r7i7qBK3AtXhmbwnkAy/UnvWX7xFuazNT
 rJocPnz7Ja+6abHYqqZTTIvmIXdDubf2VTzTo6bLilZM/ZrMaOqIyarnnaCMXm6FTUJIY2P4t7L
 1bf5MSkgo2dgT/VGNQRUJfyMGNTm4NMgyJhFcM+AW6cqLHNh4ZQfrzmCJSJ/KM5Du18/m8d0UrS
 Zgf8q9RNG1GNFldZ0AG5l7XZfbpXthz6zFWch6WKxXi3jOY++FpseZgBG0qmM8YeBwo0a8mgN14
 QqzTKnGOuztN2uxjKwoSy4bwKAjh1lJbi+Qn70oDkMNhEinMOJR5v1cfyfdSsA3JbB3iNtxU+Bx
 Rhhw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785882786; x=1786487586;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KDcNIv/bG15DtZDeFrNfXPLSKnLoLnPX6ck+YT13aVk=;
 b=f8fUnpHSesSKR/xkubSPDfrTbYkgjsPn9hP4gcm56PCj5l7mha0GWHukgRcL8TxKI+
 rIX3aKPLx5VWj4TFOfxjqwujK9iVvPc5DCUJMT+u21+6HzLjJPSbPBENm7GDmK48hLwN
 btCK3+NAjzd+EK+4vqrYas3Wi2qPJzcevAD+kv3DXUb7dnQPPIr+iJjF8sKgJFWUfRaD
 4f+hGH9B/2JHdTIGA4/6kr/DY+k5cdrJWv9RWA6vMSz85yabXB3P+CAmK4sPBSEe1qrM
 N6cVk+1AK1T+OVONwx3CHTzWH/cAaB6JaOT8zmbIN0kk879Aw2zli150EdzCDBxKHTcQ
 58AA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=f8fUnpHS
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a mt6366.dtsi file for the MediaTek MT6366 PMIC. For now, this just
includes the regulators since that is all that U-Boot uses. This should
eventually be replaced by an upstream devicetree file.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt6366.dtsi | 273 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 273 insertions(+)

diff --git a/arch/arm/dts/mt6366.dtsi b/arch/arm/dts/mt6366.dtsi
new file mode 100644
index 00000000000..9b3a23d51b6
--- /dev/null
+++ b/arch/arm/dts/mt6366.dtsi
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 MediaTek Inc.
+ */
+
+&pwrap {
+	pmic: pmic {
+		compatible = "mediatek,mt6366", "mediatek,mt6358";
+
+		regulators {
+			compatible = "mediatek,mt6366-regulator", "mediatek,mt6358-regulator";
+
+			mt6366_vdram1_reg: vdram1 {
+				regulator-name = "vdram1";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <2087500>;
+				regulator-enable-ramp-delay = <0>;
+			};
+
+			mt6366_vcore_reg: vcore {
+				regulator-name = "vcore";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-always-on;
+			};
+
+			mt6366_vpa_reg: vpa {
+				regulator-name = "vpa";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3650000>;
+				regulator-enable-ramp-delay = <250>;
+			};
+
+			mt6366_vproc11_reg: vproc11 {
+				regulator-name = "vproc11";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-always-on;
+			};
+
+			mt6366_vproc12_reg: vproc12 {
+				regulator-name = "vproc12";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-always-on;
+			};
+
+			mt6366_vgpu_reg: vgpu {
+				regulator-name = "vgpu";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-enable-ramp-delay = <200>;
+			};
+
+			mt6366_vs2_reg: vs2 {
+				regulator-name = "vs2";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <2087500>;
+				regulator-enable-ramp-delay = <0>;
+				regulator-always-on;
+			};
+
+			mt6366_vmodem_reg: vmodem {
+				regulator-name = "vmodem";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-enable-ramp-delay = <900>;
+				regulator-always-on;
+			};
+
+			mt6366_vs1_reg: vs1 {
+				regulator-name = "vs1";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <2587500>;
+				regulator-enable-ramp-delay = <0>;
+				regulator-always-on;
+			};
+
+			mt6366_vdram2_reg: vdram2 {
+				regulator-name = "vdram2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <3300>;
+			};
+
+			mt6366_vsim1_reg: vsim1 {
+				regulator-name = "vsim1";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <3100000>;
+				regulator-enable-ramp-delay = <540>;
+			};
+
+			mt6366_vibr_reg: vibr {
+				regulator-name = "vibr";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <60>;
+			};
+
+			mt6366_vrf12_reg: vrf12 {
+				regulator-name = "vrf12";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			mt6366_vio18_reg: vio18 {
+				regulator-name = "vio18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <2700>;
+				regulator-always-on;
+			};
+
+			mt6366_vusb_reg: vusb {
+				regulator-name = "vusb";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3100000>;
+				regulator-enable-ramp-delay = <270>;
+				regulator-always-on;
+			};
+
+			mt6366_vcn18_reg: vcn18 {
+				regulator-name = "vcn18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vfe28_reg: vfe28 {
+				regulator-name = "vfe28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vsram_proc11_reg: vsram-proc11 {
+				regulator-name = "vsram_proc11";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+
+			mt6366_vcn28_reg: vcn28 {
+				regulator-name = "vcn28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vsram_others_reg: vsram-others {
+				regulator-name = "vsram_others";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+
+			mt6366_vsram_gpu_reg: vsram-gpu {
+				regulator-name = "vsram_gpu";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-enable-ramp-delay = <240>;
+			};
+
+			mt6366_vxo22_reg: vxo22 {
+				regulator-name = "vxo22";
+				regulator-min-microvolt = <2200000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-enable-ramp-delay = <120>;
+				regulator-always-on;
+			};
+
+			mt6366_vefuse_reg: vefuse {
+				regulator-name = "vefuse";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <1900000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vaux18_reg: vaux18 {
+				regulator-name = "vaux18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vmch_reg: vmch {
+				regulator-name = "vmch";
+				regulator-min-microvolt = <2900000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <60>;
+			};
+
+			mt6366_vbif28_reg: vbif28 {
+				regulator-name = "vbif28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vsram_proc12_reg: vsram-proc12 {
+				regulator-name = "vsram_proc12";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+
+			mt6366_vemc_reg: vemc {
+				regulator-name = "vemc";
+				regulator-min-microvolt = <2900000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <60>;
+			};
+
+			mt6366_vio28_reg: vio28 {
+				regulator-name = "vio28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_va12_reg: va12 {
+				regulator-name = "va12";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-enable-ramp-delay = <270>;
+				regulator-always-on;
+			};
+
+			mt6366_vrf18_reg: vrf18 {
+				regulator-name = "vrf18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			mt6366_vcn33_bt_reg: vcn33 {
+				regulator-name = "vcn33";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3500000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vmc_reg: vmc {
+				regulator-name = "vmc";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <60>;
+			};
+
+			mt6366_vaud28_reg: vaud28 {
+				regulator-name = "vaud28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <270>;
+				regulator-always-on;
+			};
+
+			mt6366_vsim2_reg: vsim2 {
+				regulator-name = "vsim2";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <3100000>;
+				regulator-enable-ramp-delay = <540>;
+			};
+		};
+	};
+};

-- 
2.43.0

