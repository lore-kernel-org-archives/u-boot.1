Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECF8C61DC7
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 544BA80D4F;
	Thu, 27 Aug 2026 07:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t6EW-r-MU0ql; Thu, 27 Aug 2026 07:35:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787816135;
	bh=grJlQCJTwJqeB4CAIFhxVb3nXcH71HNsCSL7/NGcllY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y+Dl19BdTkpl6SK2IswIrIjyQk9Ghf+chljSfdaUqgOlWETNEUwTlsmk2det5Rd0z
	 5tJhl8neqiTFwIPeSSUzT0vyMuoRdAryu7eS+Ryd+dYCt+X/1/gZO92NdfDrVGrg4W
	 MvnCqTI16WhGxo2WM5jmqDpsrzhAvaWrGWocNrXRcGqNiHL4VXfdxdVzDtHxKd378N
	 pGTNors0tUjOPLomesJ+9dqQXq8xgfqeKXiuYK7GGNoGp9NtzL07emWNXoJCa669kf
	 mOfPNtgLAL97clZQI3P5u7lgnC+XoZlJpwCY7g5GFADFX5nq4/pO77tVYrnNs/t9b4
	 vo88pCaaSbNbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89F5080D66;
	Thu, 27 Aug 2026 07:35:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D0523A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E46B80D4F
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gDI4x7h3no-t for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:35:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pB2Bajtd
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F9C680D09
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:28 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47db714766aso462650f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787816126; x=1788420926;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=grJlQCJTwJqeB4CAIFhxVb3nXcH71HNsCSL7/NGcllY=;
 b=pB2BajtdWvtlKgpVJQ0JWQKd9zzoefQQ1NG9J7ymHFt1/Xir8uVBcttvlVJnegYGlo
 KUIsTJQxNbn46iBAccQRjecVzh/Vso02MlMPCGBUItbEiSPLUvUCQllzjTl/Fa+C+6pC
 0byYhPgYLM8kl8tvfA61VQ30YQn2qX/LgDt2+CkX93zkDglK4j8F/akzMc7ZnzCXrCRu
 ExAQRM6TVrTldioPsSkuFmz0D9rRjkUC9LyFQrYL6vk/+ZXVyhVgka0yqGmmblGJVeDB
 2aGOephYrkP7la5fcPiSYTyNe5ujmAs/zguLe2ez9USjt1ik2yd6tl7FbxTXyxGdssMz
 ci1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816126; x=1788420926;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=grJlQCJTwJqeB4CAIFhxVb3nXcH71HNsCSL7/NGcllY=;
 b=GtsCaU0vx96qU/JHeRx+8kKVhBg9R9TynhIOLkgrA1xkxWHIeqXxyLzLVfvTpAU0XT
 jws453kJFUfjj2gV12TrcFy/7UGDT8xAqmZ+EbyOl4J4XGbxbObJQllQz19bqLaPyOTh
 OYYetxwMTYnkFom9JqptZtwulZwkPY1RI1ciqo86MINs2l6Z10RrmCq17ZL2BbaqIm1K
 rqqOD6R0uSxSIlEOb8piiSMxMGxY67jKkL7cTi6Tv3AlQiPg+orthMv1aDCchgSxhhAr
 AlLDaw+LoG+0tp7nqXtxGxFoPD+L7sXgljW13JagUzldHEWliCq2SipjGwvA9FVh2SwD
 Nvuw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3jq+94bhLCQN8gO+jn50CHhMLaCK1D2j1uGxRjyw8630VHslWfPSg3tqonNAXRg6KIUpbCvw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m/sdQ1JX6jh+Vub3E4pkr0e4Auas8Om2faxMbqaMhTwwwBo/JY
 +RxjpbJ93bPIEwfF6b3s2xVn6EPtJ0ix2U0Km6/Zvz0UyMKKOPDgy55oRHqZxymMED4=
X-Gm-Gg: AR+sD136bJq5gDPCc2+OYd0j/nsnxwjEcsUnSjgjhP/Fczbse2tPRTl41B3XcnrI0WB
 dZDeQwwZ/8GrAnEHYW0iuMJ0GB3mZiadvw1bEXFHP6NLpxhwKGxUPttMifs/RDRAUse2ecgI6m7
 yOQBH6P79atFYNd10tAH6YgJmZNOfS9Uz47vwd52nEpJxFgcYN2p4MzRox3WB/XWY1jk8W9iosl
 WDBr0b19FsQVlREJkeR/Pgj9ZRzlC4kgPp1D5twjdIrGYcsdUw8ApgvP6/mGJbSVn6/8GvX7p/O
 nh3xjhgKKrnp9WV9mCabDSKfvpdQiCBmlg6eDKjtOo/bhbHZJ4gBVyCykFO5vgNkN8mOYwh/Zfk
 Xk5nh/NX4N4ZcoyyE7XjL5TxEaF5sF8KSOFYFaEukbXpQMMqkGSX6CwnjZDTpOxs+1VEXK4PCah
 1lqk6pnA9U0dhM2MRSURCg/GBwts5i74Pd7lYrEch083X2/sxShO8nN2UfImEq3vXDKoZpGDD9D
 32LgMt5W0qmK0yx4NDPWPeZnn+2XmDE9oX/EWRa4+0grmiPBWRzjOaL1sSryMOQ+pyQXRQ36s6k
 /3cLz0Rg1g==
X-Received: by 2002:a5d:5847:0:b0:482:dd86:348 with SMTP id
 ffacd0b85a97d-482eab6a866mr5537880f8f.4.1787816126376; 
 Thu, 27 Aug 2026 00:35:26 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab6d0sm6788666f8f.13.2026.08.27.00.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:35:26 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 27 Aug 2026 09:35:01 +0200
Subject: [PATCH v5 4/6] arm: dts: mediatek: support signed Genio 510 and
 700 bootloader FIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-ccaione-upstream-mt8390-spl-v5-4-81d04e3ab785@baylibre.com>
References: <20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com>
In-Reply-To: <20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.16.0
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

The unsigned bootloader FIT only provides hashes, so SPL cannot establish
a chain of trust before loading BL31, OP-TEE and U-Boot.

When SPL FIT signature verification is enabled, sign the complete
configuration and require its public key in the SPL control devicetree.
The configuration signature covers the firmware, all loadables and
U-Boot's control devicetree.

Use binman's u-boot-spl-pubkey-dtb entry to inject the key while
preserving the fixed SPL region expected by the external DDR loader.
Unsigned builds keep using the existing image layout.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi | 11 +++++++++++
 arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi  | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi
index ce492790aee..c5e6da7c58a 100644
--- a/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi
+++ b/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi
@@ -12,6 +12,9 @@
 		fit {
 			description = MTK_BOOTLOADERS_DESCRIPTION;
 			#address-cells = <1>;
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+			fit,sign;
+#endif
 
 			images {
 				uboot {
@@ -90,6 +93,14 @@
 					firmware = "atf";
 					loadables = "uboot", "optee-1";
 					fdt = "uboot-fdt";
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+
+					signature {
+						algo = "sha256,rsa3072";
+						key-name-hint = "bootloaders";
+						sign-images = "firmware", "loadables", "fdt";
+					};
+#endif
 				};
 			};
 		};
diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
index e49ad5c471f..30de2ec621c 100644
--- a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
+++ b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
@@ -11,6 +11,22 @@ ddr-loader {
 	size = <CONFIG_MTK_GENIO_DDR_LOADER_SIZE>;
 };
 
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+u-boot-spl {
+	type = "section";
+	size = <CONFIG_SPL_MAX_SIZE>;
+
+	u-boot-spl-nodtb {
+	};
+
+	u-boot-spl-pubkey-dtb {
+		algo = "sha256,rsa3072";
+		required = "conf";
+		key-name-hint = "bootloaders";
+	};
+};
+#else
 u-boot-spl {
 	size = <CONFIG_SPL_MAX_SIZE>;
 };
+#endif

-- 
2.55.0

