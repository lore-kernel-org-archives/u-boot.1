Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3197C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DF3D813ED;
	Tue, 28 Jul 2026 12:29:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id op84OGpf2IQh; Tue, 28 Jul 2026 12:29:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 983BB813B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241791;
	bh=74C958VvIGoYbC2qcCXcVLEbTnKqXdYADu14K5+Z6Hc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MwuWGhC864BGXksCpl+fV7hMiTN2KY/A73u6uzjvo38Zs6ebeA2i/8pnUAkzXU0tR
	 gn049M+g17UxzN8zyCSUwaGOufqQgx5kgfrZ5ulwAzr56dOCvX3HpPkWJMxDferg1M
	 RFlWctJIzSHGG4i62X2oqXsmzLky7hXv1A2Unp25k7FYEt/6Ssjn/zRL7F09Jn3deu
	 rf6PwTRozx5eAnrv1yhmCZnFj8vIYO7UNZh5imXx8jl47n25I7n2pxoSeMksuGoirA
	 R6vYIi4u2OS7ude97CpoTLiyjfsrvX6pjzb+GdpB2EJTtP49iAw8/JwNAzd/0UK5Sc
	 M2aaFuZwdNB1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 983BB813B7;
	Tue, 28 Jul 2026 12:29:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D70642E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BCE1C409FA
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PJTtrEIXqK4D for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:29:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CDE9B409B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDE9B409B0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDE9B409B0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:41 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so4869815e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241780; x=1785846580;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=74C958VvIGoYbC2qcCXcVLEbTnKqXdYADu14K5+Z6Hc=;
 b=G6B6MleRHvm1sSrXBYUiwbarpPmSQfma03mcEX559ZtEAmFU7kmn+tffyTbMjrlchV
 K/O829S66zk59VG5W7asIx2j+NCsUB5o+tme/lMk3vmT3he/G+yk1DjPShOJB/iV1cW5
 AtphmmLIZ13w7c21Qp1Y8Q9TKe6s28icpxud7e1qggRTmU3LOf8qbXuhZXb7WmsI+dw3
 FmrYy5+ZWAaeItdC0XlrsckQ/N0pqYvfOjr4RPv58Yo2dCGspIPk7c8BVtMOWixxOzzp
 v4WDVn0aqgvJgxH4e5D9fEnhun8oBGw78sZzqLtd1G2YKc8bW+tEEfdaMa72Z5Va244p
 CEyw==
X-Gm-Message-State: AOJu0YzeY1CRGlLPMnP6CsnOVyXwhYeF1ZPcepN/FO5FhPUGWOu/B2Jp
 9y6XgKVX+1DpK0cMpOBhASoaX2xSZFlwwSBjUnnqk3gtHwRY9p8NNoQegcsemi8fgGY=
X-Gm-Gg: AR+sD11WtyOzZFyTxiONMFYUlcgCB52A0UAiT+ClarpQczdoXf2wIf+M1u0fjdT7kl8
 876X9Pp+kODXEI1G6WNAZtcbjmWreh48sz+pin0gYSJ9XmTeCRcjJtfvEu6yb+6RY2wv3ZsCAWM
 9w3eiFoJ8c1oytyWpG3Mg67Ujdz5pC0C8pbL+PQoDOXEnXj3t/vWKhcByGPjhJDmj2dnbG9aDrA
 E2mJHRex+ZFLuS16Rgoz0tZl3qwvw+L+qutAU/mNewHc/P6O6XyABUFW2ZO8s9Ll2nF+Dp3VTo3
 FH+nO9gTLek6NPml2HOodDGFYlMdBD+oZup4mcnAdkEUXYVOj422i3EuMgEcYh7zimyhYycbDuE
 vVpt0wYARGdhFPH3lIzVy0law4JhnYMABa1Gn1TEAEebMdN6wF9s7qgX42+LFVY1dys0dym4smi
 exPJ4YlEP+hwFVwIvh5eZ3yJaoPilNjBY+jZosqm2PuLteW6l9dd9gb+iX5QVycRoJAXN8wC4PC
 9/lKZ94NaEqO7YNJUdnQTKlupS3IhEaYOZQfzZV6StaXgruTxLop4Ap0EvDKFo=
X-Received: by 2002:a05:600c:e549:20b0:492:6f5c:fd8c with SMTP id
 5b1f17b1804b1-496c6585511mr16105255e9.15.1785241779609; 
 Tue, 28 Jul 2026 05:29:39 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm58324766f8f.27.2026.07.28.05.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:29:39 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 14:29:42 +0200
Subject: [PATCH 10/13] arm: dts: mt8188: add vdosys1-pipeline node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-add-genio-510-and-genio-700-hdmi-v1-10-ac54bd75f960@baylibre.com>
References: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
In-Reply-To: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785241780; x=1785846580;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=74C958VvIGoYbC2qcCXcVLEbTnKqXdYADu14K5+Z6Hc=;
 b=AvA/vqme65vPrKyHjuzgYYii+o8/MTF3/t6uPegNONxfVWZbu6ghLlVE1CqcPYtkFj
 5idxxCatY6XDd3iGew4cvhD32Jt5pBh7hDo05X5YTfCbbCsBZ34U1R/O/8URKwVuSHOL
 fjip72r8eCvYt/UkAFcTZbCW5+UyolBFKodsXJEH4ywqF5P+RX4epPkf99uhGq9i+idM
 naPpMv2EEip5hB6i6ny0M7eXMQwcUXTWv5v5dchIilfmQjgBPT3vN3SOCd9Aq5jbt2b8
 7vopYsQOD5xhUl778Vc3nwDYndrFPMh/UvLpgZ+StwDre6AgIW4MdS6e+IMoLUkFzHUI
 /3rA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AvA/vqme
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

The vdosys1 syscon node from the upstream dtsi is bound by the clock
driver in U-Boot, so the display routing (SEL_IN/SOUT muxes) of the
same register block is described by a separate U-Boot specific node.
It also carries the clocks of the HDR back-end path that are not
attached to any component node.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 arch/arm/dts/mt8188-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/mt8188-u-boot.dtsi b/arch/arm/dts/mt8188-u-boot.dtsi
index 131377d9a97..fd1121a72cd 100644
--- a/arch/arm/dts/mt8188-u-boot.dtsi
+++ b/arch/arm/dts/mt8188-u-boot.dtsi
@@ -4,6 +4,18 @@
  * Author: Julien Masson <jmasson@baylibre.com>
  */
 
+/ {
+	vdosys1_pipeline: vdosys1-pipeline {
+		compatible = "mediatek,mt8188-vdosys1-pipeline";
+		reg = <0 0x1c100000 0 0x1000>;
+		clocks = <&vdosys1 CLK_VDO1_SMI_LARB3>,
+			 <&vdosys1 CLK_VDO1_SMI_LARB2>,
+			 <&vdosys1 CLK_VDO1_HDR_VDO_BE>,
+			 <&vdosys1 CLK_VDO1_DPI0>,
+			 <&vdosys1 CLK_VDO1_DPI1_HDMI>;
+	};
+};
+
 &u3phy0 {
 	compatible = "mediatek,mt8188-tphy", "mediatek,generic-tphy-v3",
 		     "mediatek,generic-tphy-v2";

-- 
2.54.0

