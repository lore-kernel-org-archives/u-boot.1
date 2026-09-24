Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544BEC98314
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F4196813AE;
	Thu, 24 Sep 2026 12:54:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3_poMgn82wI1; Thu, 24 Sep 2026 12:54:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 23D1D813B6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790254467;
	b=tGCYzWvKfU99n5dFqlcLrh+AzwJjXe4BQcy2erhjP7fFw0D7mSOb6ViTKCZyzf/c/aV2
	 ADo5ik23Vm2GXdybQAfmmh86jrfw9aoNJl7m5fXydynePHH2TmJB0brnd+keTkQAC1sBi
	 B+7vtjDu8gdVEgd8tejWPujMGab3ZLHAGTc7pX0/FXptfMJ44uYo74ADHjuUT5rAiWH8c
	 WncVM1PE8v6vpe+WDoQUqdpg9VnVeIB7hJ6qXHogiiiFmBc5wO7Li/bZ2a4OH53bDTBUF
	 CjNRIN+cKGRMBGEzoQ7RMbO8jNwsGnTZjRHZSU5fZaXkD0YGyqTF/pTSZhYTNVhRMDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790254467;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Sj/FeBfSm3iApQahJNNVt5T+hY3nJhukzY6lXwN7oq0=;
	b=bjT/ZfErEv85IQi+WQ0FeRZ3OhOkSy3WaOIyLbdKxmso+tfoQ4EoRlP3ls+UXY+6slZx
	 7/OKfTVMtpqcjE2YKajqyK+0Q92iPM3/wwfwac7aW+szjZY9BtYRr3Tu1Y5js6Cao1Mh/
	 tGVKsxlv0vWUfVkw7PhICIAev23fuetnEkto0mq4s8kvzfvrQzeuKR7J3WJAGr0d7Qx1h
	 7tcMwIyh7RxCNcaOmfc8CAH1A1Wj08MzOGRcEFKKx/XOw0IacCoVMcdMdlzw0Q+4gid2c
	 Yvnr9XxJxM4BE3Kj2k6z+9OhcSI1YP9i8XpjmBZETkzN2jTC7UtGWIW02NmAhwnBBlA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790254467;
	bh=Sj/FeBfSm3iApQahJNNVt5T+hY3nJhukzY6lXwN7oq0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IvPa0MGz3hOrwnHCbWzS6BcpoTvwSmJT+Hajz9564J47/YVAURXMblQl8uZZVbmfg
	 b2frEEGWTV1zuFaXg/YvDGw32qP/BS3m39I59bfZvw4YAZRjZnhrloMiGlMO8306I+
	 uVibVLY5K3q9ItJgJi7vrctMeGxc/lnoJtI7Aee+Q9sJH+5gh72UY2Nu2hB///mzN5
	 vV0y091G85r7XOTW/a6GEqrBRCHloRtZv1agw7rqif+EvSe2oi6FKLZKVEvinvsGLU
	 Oo+a2Kmr50SOYuBtiyZSi7D0s7Ga0g+spxo5vIySEwjPPG49qF1OUryT7ysHrt2qSg
	 3vE6rzy9SQoZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23D1D813B6;
	Thu, 24 Sep 2026 12:54:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F4BD13B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CBED40456
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:54:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VnETi0i-vBQB for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:54:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9F1AB400FB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790254465;
 b=SEguKWARZSy0g0UZ/QMxIu0JOngfImV3weq0Je7CnttHaaLCNzQCs6W6L30YAtUwYdRE
 crjIDYCL7Jy7Wijca0l9qJGR1K7rA4vc4Zp0U+Z4fWXU4otSjFzs07Y2qNSf+XbkEtxrC
 3ALQA4r89MXKpGGgf8TPel0VWvyqqKTRXg+gsnvWDLJV897GOaF0lkiuOTvRjFCiSZaQ8
 NUn2V7kYN7lDLegok02xTLvvK5Zh4QsJ9jESKuLgAG8/BU6ZSWzbd0waQ/XFlls98472B
 rCPcUN9A+7UBRh/YDxxUxcTblqOZl/kvXM4r9TZ6nyVe7b9R3yxZC2wE9ZM7Dm5njFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790254465;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Sj/FeBfSm3iApQahJNNVt5T+hY3nJhukzY6lXwN7oq0=;
 b=PZypyTBHgfYjEpSw6lsXB3M9WGYTA60vVmHMngFt0xSWESyeKVezCojjO/HogBj9FAEg
 A6j7V4raeAar5BbdxhZC1dq5Dtn8NGlJxCsRpWe05cj+rbVuS9BkdNuTKQvEgeHZ6Ypa0
 zxp3y10aYdXq14qQKgo/WRUgcThAK5SPtTGxDonHvAriJw7AcvT1VHATZ6PkLx4vN4riq
 bK0ajOmdaPANJazeHh9iapMqUAR4/lt0Qmzz5g+rlKrYOcLZuUxp+rBI3BkW8O1r1IE3S
 ZOnW0HgBb4hTm9F+FGJ183qyQYDt5ENSV5+MYF5mywqNPWn9UCguixnlY4okRj44WSg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NjS21Jp4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NjS21Jp4
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F1AB400FB
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:54:24 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4bb359e6878so1023107b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790254463; x=1790859263;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Sj/FeBfSm3iApQahJNNVt5T+hY3nJhukzY6lXwN7oq0=;
 b=NjS21Jp4aqAGOuztNII8yYIkLrPVbTtw2KYTAQeMwqb/TFhPxfXoefmMd1G9QstTYH
 FWoNgvuK+QuKSXJIi9WttaX648R8QfOTpxGDd1iO+Y2xuIIMVupadtUUXyJzbZnW0QGN
 W39ady1NLu0OWSVy91gwEwcbWzF80ba007gx6TPax1JsRG4ClptLd2O4CtEv3cSXaEFV
 pwi6so/ej1ScMCo+otv9rSdxgD6j71ifoIDKrkrNsFxYFRKT2afcO33qEhWel5XNmUPB
 eJi8J2nQUiHS12jfrJce06iq3q4mnFRDr7GuFzd5DytiLHBA3rGfmZYjfhmfpIMDEyCv
 xHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790254463; x=1790859263;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Sj/FeBfSm3iApQahJNNVt5T+hY3nJhukzY6lXwN7oq0=;
 b=XLsMIES/86NAHeDMrI/zYNzlaE8i7XyLrjhbxjoBnjB75mePuOJ1t+collMcYE2s4F
 4lsoLWAy0iP5/jh9eYMUR7EjvSjimUtThGNh9iGv2ieokIrbwGuxXUjq2zlYuLL6706d
 RhrAVRoDyTraJhacVzH3dy4gSPLT54HnCq7M0KW1AJx5OTiPdvYFD1om0+690GUDgq7a
 W4XiQDB48vEChaZTyrs/tp/NyFEgQ0FyQqvHkFVAhce30QW7BZWLH9mVH2IN96f4V+M+
 g3VcqEXa6L40xWf2br8KlV5ZTvSn9/0nOcl8qEIMEuUACJWT8OFUXYsXZwRQVGcmgPzg
 lZIA==
X-Gm-Message-State: AFuF++mgaytLsUszR41JI34k/aaa4ZDD9MlNPcAT0MeHeu7uJBATvwfV
 VuDAkWuFrn9+OsTXdZoDXsIK/w0JZ4dvQBhjHzxyx0Nh0Dqg5JhkpgluYEDV24KGwjY=
X-Gm-Gg: AYBFou2WjoIK/irxAqrnMR0JMqBDUKgjuc1yuC56sYpy0v/gwdo5MG6yMePQ98j3W1K
 6QmNldX2tcqiCtmOmkzYlJ0vRDiLTj4k/9KgAeI4WBtl3SQg5M+95Acw+HZ3gSrEpcJGrquqLm9
 VzXF2CvCaFHcMzGQ3LiSpJ1Di/Ni+dJUTDQ6PSPrC//S+UTGq+RLVV5tI2ZURlpi5vqS2BddDOF
 rsxjS7yKj6ejX50Zf+iw2gGvRWGkSvIH6bPzkmUidQ4MfcxH5hDOB/heZWbnDOLHJnfwE95H5jw
 We3F9FkVLIPArtujl007BNK7H2N94Zyn5mHM773bbgmOer+jeL/X1W6i53wckIFQkSVCjcwfvoT
 YT73PG4etXl4jG0Xn10+tPRQcg+eEsgy6hVGvhOUXEKUtIwXgIj20opxgl5xX8OleoTRbbC5g1f
 qVDLGtQxFLiv2vadUxXuv9446uy6C2jyYD7ZMGz2+JiP0ud5hN2tmY1ugvf3AUHuQyGBaNiOOP9
 Zg=
X-Received: by 2002:a05:6808:c2bf:b0:4c4:6b5c:30c3 with SMTP id
 5614622812f47-4d727712c7cmr2134879b6e.0.1790254463158; 
 Thu, 24 Sep 2026 05:54:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4d5c4bf8e14sm4602253b6e.14.2026.09.24.05.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 05:54:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 07:54:12 -0500
Subject: [PATCH] clk: mediatek: mt8189: match the mmsys compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-mtk-clk-mt8189-mmsys-v1-1-cb4abe521454@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBCF4auQWTsJrQlQr2JclGGqIxZNB4yGc
 HcKrF6+xftnUE7CCpdihsRfUXkPGeZUAD38cGeULhtsaavS2TPGsUd69Xkb0ziMUf+KdWDXeiL
 jQwX5+kkc5Ldnr7fDOrVPpnFrwbKsbvtC0XgAAAA=
X-Change-ID: 20260923-mtk-clk-mt8189-mmsys-7fe9bacc1af6
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2461; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=S+I8lEKtloEk2QZjwOn3PAPwucDomtCIC2lb2O0PCTg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtR10UIRHiAlDH1YqRSrdk4c/+PkbGiccTQh6I
 npxR50OdQaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarUddBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AcFUIAJ6Bl0QIAm40Xcs9qTUili42gTjRQtrB7T3QmB5
 TyBOhsFtUyeMc7jTJL4GyZCxydT0h24t6BG+HVf1DLcQEuMztXkD46o92Wj0ZPKFQBZcrjxH4/b
 l254xLm843VDobJa/5/5Rw2aCw2aFailsw62/45dAiTbOY7o2ObImNlN8OjrMoxdLwRJ3Gg8ZLf
 Y1pGK2ABcEhDiIxfPW1U+EqeI/DGP66yDhNOwjCjG933HrZYpsmaiGkTP0wTwLBvMAZrsls1DvJ
 iMevB/Gf1Cv7Auzh6CZAvcCeZNzoDiY1PtCYBLMqbPztoiSH8rK71OI8coQMOqbtY6tpAPlgPyo
 ttwk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Change the compatible of the display clock controller from
"mediatek,mt8189-dispsys" to "mediatek,mt8189-mmsys" and rename the node
to syscon@14000000 with the mmsys label.

The display clock gates live in the mmsys register block at 0x14000000.
The proposed Linux binding for MT8189 adds "mediatek,mt8189-mmsys" to
mediatek,mmsys.yaml, which requires a "syscon@" node name, a "syscon"
fallback and #clock-cells. This follows MT8188 and MT8195, where the
vdosys0 mmsys node is also the display clock provider. The old
"mediatek,mt8189-dispsys" name is not in any upstream binding.

The mmsys label matches the other SoCs with a single mmsys block at
0x14000000 (MT8183, MT8186, MT8192 and MT8365). Update the one reference
in the power controller node.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8189.dtsi          | 6 +++---
 drivers/clk/mediatek/clk-mt8189.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
index f3a350c51b8..656f5488c72 100644
--- a/arch/arm/dts/mt8189.dtsi
+++ b/arch/arm/dts/mt8189.dtsi
@@ -169,7 +169,7 @@
 					power-domain@MT8189_POWER_DOMAIN_DISP {
 						reg = <MT8189_POWER_DOMAIN_DISP>;
 						clocks = <&topckgen_clk CLK_TOP_DISP0_SEL>,
-							 <&dispsys_config_clk CLK_MM_SMI_LARB>;
+							 <&mmsys CLK_MM_SMI_LARB>;
 						clock-names = "disp", "ss-disp";
 						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
@@ -398,8 +398,8 @@
 			#clock-cells = <1>;
 		};
 
-		dispsys_config_clk: clock-controller@14000000 {
-			compatible = "mediatek,mt8189-dispsys", "syscon";
+		mmsys: syscon@14000000 {
+			compatible = "mediatek,mt8189-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index a5cb387772a..ece7d739f86 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -2000,7 +2000,7 @@ static const struct udevice_id mt8189_clk_compat[] = {
 		.data = (ulong)&imp_clks_tree,
 	},
 	{
-		.compatible = "mediatek,mt8189-dispsys",
+		.compatible = "mediatek,mt8189-mmsys",
 		.data = (ulong)&mm_clks_tree,
 	},
 	{

---
base-commit: e3ed6c6436abc18af0c7a0298ac72f83ebf2b5d1
change-id: 20260923-mtk-clk-mt8189-mmsys-7fe9bacc1af6

Best regards,
--  
David Lechner <dlechner@baylibre.com>

