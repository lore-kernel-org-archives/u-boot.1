Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF26C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:29:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B814781423;
	Tue, 28 Jul 2026 12:29:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gXOtwb_YFCtl; Tue, 28 Jul 2026 12:29:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A2F7281414
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241796;
	bh=BEtha/GmSKUOY9ZJ0HS6qE+34sgH0sQMgm5MS1QVUls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=my24S5bDMDONWwDsoIxKMjYiBKkExg+TlXjAUCb9FX5s6xKW1qgW7TtZYvG7D7E7Z
	 bJkPtqRQyJKa/25tsCzIv3xYyR2O6MxR9Pzvc8oIzZ17H3UCfy43+55qiAkPpc40M0
	 NgwrKfytz3U6ei+3303QfY3UxEy1JC1YA7k+lBtR6iOUHd4wHDcUb+m59wkN6KHHTC
	 zxcczxub0QkHGB7paQU2dTJqiy2JNVdDOyoZfJeMFQtWlo05N6+670CxynUpey+oko
	 z8kq9B17etOIEOmYnur/e0lINNPDiCbaGlHC2SHxzEeiaO9wyWzO+eQGuiLDeRXeH4
	 RbqSAj2J1Cy9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2F7281414;
	Tue, 28 Jul 2026 12:29:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B90FB23F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AACEA80F00
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qL5W_mqEEU_r for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:29:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B75E78134E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B75E78134E
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B75E78134E
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:43 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4956869750eso28657415e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241781; x=1785846581;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BEtha/GmSKUOY9ZJ0HS6qE+34sgH0sQMgm5MS1QVUls=;
 b=DuZvt62rbloQCq2+BJJOXhSnsUikUjVebHil3T8z9AO7/xKhs2PvKYOF0BGbev5obp
 RjfNgUON1STiDs1xNZ+TbqoziOox/dlFNdRtrMrzj9/Q3XZw9annQXIKQZUr3J8zaZCD
 WUYNRqs1mlEo2jeguATb3Ld9XlrMtLdWRhUakc3oz8qQstBmc3gLCjaVpSONwq761jC8
 p5tCAlzgD+bmpmQt+L6DZbjzMG1eEU44OxrIhtlDugzeWYr/i31JSNRLcycDX+fWC2J7
 0dkkOtjiY2zn00nm8TO3mXJzdTArxsvKKP58erONyq4QZYtdIgTsqUeV+0x296s6huGr
 xlZg==
X-Gm-Message-State: AOJu0YxcVlL4P0fiL5u6bRmFhv+kT3y1eMg9N9sl/HmuLNbtn4rLiP7R
 UKzxpJX++7rHiIS6ret0ZTZcQjGWRzdwF6W0cro4YrlX0w9QBp29WDegH8xtDFG+bFQ=
X-Gm-Gg: AR+sD12y9du1lLPcb12RKleGdos1W+gM/bBR/sztOUd/jc71A4RlclUcyn8qtKuyQ4m
 kJouGdEFueB4+5i5o8J3D9bn+gEA8jBFtMUe7R404YczqSQ24Fm2l0XXcAHXIofsnqbZhPZzYkV
 QO9VWGy41ddHy1bOlh8MF92D3ohiCavOZZaAHkiRPn6kBZ5QMGSx5AQb7cLzDz/YW2p3LGwu8Od
 8hhmNVUryHifwySA6jmDAURf+miWugGKnorbZOve9i7rKSYSg+ZeaAYegQQ5O9Ao+vrz0HYW0T5
 8zWFl1IHV7HBBVRrXurWwAgOLbZxM5A3qH2vbNQTp/jOfiUv4YPlJNscMsZ/5pxiqaq5cFli+lh
 FqgLZ5Qmcf+LE5NQO1NV/IeeB4La/gMPY1T6dX/37tcELwT1m2x53iZUtA2jm8/SnGafkpMbfiB
 ZfkPRP2DIbhKBAdDgGic14Sh30lyq949H6iSxeSyvy2/SJTsspgW3qknx2ASTZoIqhJ+KTeYTXD
 XY5xudVxv1E/VGA3vXbeZQU1tSW0VGZoU4LvksZ4p/GNAzuT45JugF35emuUro=
X-Received: by 2002:a05:600c:4755:b0:495:3fe8:880f with SMTP id
 5b1f17b1804b1-496c6414fe3mr24305155e9.4.1785241781652; 
 Tue, 28 Jul 2026 05:29:41 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm58324766f8f.27.2026.07.28.05.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:29:41 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 14:29:44 +0200
Subject: [PATCH 12/13] arm: dts: mt8188: add hdmi override node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-add-genio-510-and-genio-700-hdmi-v1-12-ac54bd75f960@baylibre.com>
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
 d=baylibre.com; s=google; t=1785241781; x=1785846581;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BEtha/GmSKUOY9ZJ0HS6qE+34sgH0sQMgm5MS1QVUls=;
 b=DdNDSSXTTtXFdc7jFm19r4MPH3gfU+KWFNiVtz/ov8fkeSneh3dUpsUuivZpZ0woPT
 375XORZ/m6fXn2o2Nj64hOGLs4IXPTvLTN9Wh04H4ARHjDLj46tYg7sDbEyjjpcZJtVi
 3wDypXNSMD6ubt3hd5J048QIybMK8f+Ov1QtarN27YTULFzvhIHVv7rG9e9v9CdO82Ie
 PgZ+wCcl2EbMlsQmBevYRB//ibtAWn7Vz9dsG9Uu/fIf1UZzvGqGHZk6hyaVyf+xDmLv
 0oKNsF1yMAft3v4MWcQIQjC+zcxF2O7Ec1yaVpOdQAcD3Abn5DLRbNUPTFz4KOISQZVq
 8Xkw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DdNDSSXT
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

The mt8188 SoC provides an HDMI encoder and PHY fed through the DPI1
interface attached to the vdosys1 display data path.

Compared to the kernel, the following U-Boot specific properties are
added to the hdmi node:
- a "memory-region" phandle to the framebuffer reserved-memory region
- phandles to all the components of the pipeline, since U-Boot has no
  DRM framework to walk the graph

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 arch/arm/dts/mt8188-u-boot.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/dts/mt8188-u-boot.dtsi b/arch/arm/dts/mt8188-u-boot.dtsi
index 923e52522de..26a2bddd24e 100644
--- a/arch/arm/dts/mt8188-u-boot.dtsi
+++ b/arch/arm/dts/mt8188-u-boot.dtsi
@@ -79,3 +79,24 @@
 &mmc0 {
 	bootph-pre-ram;
 };
+
+&hdmi {
+	/* U-Boot specific: the framebuffer lives in this reserved region */
+	memory-region = <&framebuffer>;
+
+	/*
+	 * U-Boot specific: U-Boot has no DRM framework, so the video
+	 * driver locates the components of the display pipeline directly
+	 * through these phandles.
+	 */
+	mediatek,dpi1 = <&dpi1>;
+	mediatek,vdosys1 = <&vdosys1_pipeline>;
+	mediatek,merge3 = <&merge3>;
+	mediatek,merge5 = <&merge5>;
+	mediatek,mixer = <&ethdr0>;
+	mediatek,mutex1 = <&mutex1>;
+	mediatek,padding4 = <&padding4>;
+	mediatek,padding5 = <&padding5>;
+	mediatek,rdma4 = <&vdo1_rdma4>;
+	mediatek,rdma5 = <&vdo1_rdma5>;
+};

-- 
2.54.0

